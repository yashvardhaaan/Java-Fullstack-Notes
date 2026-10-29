# `04-Same-Origin-Policy.md`

# Same-Origin Policy (SOP)

## 1. First Principle

The **Same-Origin Policy (SOP)** is a fundamental browser security mechanism.

Its purpose is to prevent one website from freely reading sensitive data belonging to another website.

Mental model:

```text
https://bank.example
        ↓
Browser security boundary
        ↓
https://attacker.example
        ✗
Cannot freely read bank data
```

Without SOP, a malicious website could potentially read data from websites where the user is already logged in.

---

# 2. What Is an Origin?

An origin is defined by three components:

```text
Scheme + Host + Port
```

Example:

```text
https://example.com:443
```

has:

```text
Scheme → https
Host   → example.com
Port   → 443
```

Two URLs have the same origin only when all three match.

---

# 3. Same-Origin Examples

These are same-origin:

```text
https://example.com/page1
https://example.com/page2
```

Same:

```text
https
example.com
443
```

Therefore:

```text
Same Origin ✓
```

---

# 4. Different Origins

### Different scheme

```text
http://example.com
https://example.com
```

Different origin.

### Different host

```text
https://example.com
https://api.example.com
```

Different origin.

### Different port

```text
https://example.com:443
https://example.com:8443
```

Different origin.

---

# 5. Origin vs Site

These concepts are related but different.

```text
Origin
→ Scheme + Host + Port
```

A **site** is primarily based on the registrable domain and scheme for modern browser security concepts.

For example:

```text
https://app.example.com
https://api.example.com
```

are different **origins**, even though they belong to the same broader site.

This distinction becomes important when learning:

```text
SOP
CORS
Cookies
CSRF
SameSite
```

---

# 6. Why SOP Exists

Imagine you are logged into:

```text
https://bank.example
```

Your browser has a valid session.

You then visit:

```text
https://evil.example
```

Without browser security boundaries, malicious JavaScript could potentially attempt:

```text
evil.example
     ↓
Request/read bank data
     ↓
Steal sensitive information
```

SOP prevents arbitrary cross-origin reading by browser scripts.

---

# 7. SOP Does Not Mean Cross-Origin Requests Are Impossible

This is a common misconception.

Browsers can make certain cross-origin requests or load cross-origin resources.

For example:

```html
<img src="https://example.com/image.jpg">
```

or:

```html
<script src="https://cdn.example.com/app.js"></script>
```

The important distinction is:

> **Being able to send/load something cross-origin is not the same as being allowed to read the response.**

CORS controls certain cross-origin access to responses.

---

# 8. SOP and JavaScript

Suppose:

```text
https://attacker.example
```

runs:

```javascript
fetch("https://bank.example/api/account");
```

The browser applies its cross-origin security rules.

If the bank does not permit the requesting origin through an appropriate CORS policy, JavaScript generally cannot read the protected response.

Conceptually:

```text
Attacker JS
    ↓
Cross-origin request
    ↓
Bank
    ↓
Response
    ↓
Browser SOP/CORS enforcement
    ↓
Response inaccessible to attacker JS
```

---

# 9. SOP Is Not Authentication

SOP does **not** determine:

```text
Who the user is
```

It is a browser security boundary.

Authentication is handled by mechanisms such as:

```text
Sessions
Cookies
Tokens
Passwords
MFA
```

Authorization determines:

```text
What the authenticated user can access
```

---

# 10. SOP and Cookies

Cookies have their own security rules.

Suppose:

```text
https://bank.example
```

sets:

```http
Set-Cookie: session=abc123; Secure; HttpOnly
```

A malicious origin generally cannot simply read that cookie through JavaScript because of browser cookie security and `HttpOnly`.

However, cross-site requests and cookie sending have separate rules.

That's why you must understand:

```text
SOP
+
Cookies
+
SameSite
+
CORS
+
CSRF
```

together.

---

# 11. SOP and CORS

This distinction is extremely important.

### SOP

Browser security policy that restricts cross-origin interactions, especially reading responses from scripts.

### CORS

A mechanism through which a server tells the browser:

> "This particular origin is allowed to access my response."

Example:

```http
Access-Control-Allow-Origin: https://app.example.com
```

Conceptually:

```text
Browser
   ↓
Cross-Origin Request
   ↓
Server
   ↓
CORS Response Headers
   ↓
Browser decides whether JS can read response
```

---

# 12. Industry Example — React + Spring Boot

Suppose your application has:

```text
Frontend:
https://app.example.com

Backend:
https://api.example.com
```

These are:

```text
Different origins
```

because the hosts differ.

The React frontend may call:

```text
https://api.example.com/api/orders
```

The backend must be configured appropriately for the browser to allow the frontend to read the response.

This is where CORS configuration becomes relevant.

---

# 13. Dangerous CORS Configuration

A poorly configured server might allow arbitrary origins:

```http
Access-Control-Allow-Origin: *
```

This is not automatically a vulnerability, but it can be dangerous depending on what the endpoint exposes and whether credentials are involved.

More importantly, avoid blindly allowing arbitrary origins for sensitive authenticated APIs.

Bad conceptual configuration:

```text
Any Origin
     ↓
Sensitive authenticated API
```

Better:

```text
Known trusted frontend
        ↓
Sensitive API
```

---

# 14. SOP and DOM Access

Same-origin pages can normally access each other's DOM when they share an origin.

Example:

```text
https://example.com/page1
https://example.com/page2
```

Because they are same-origin, JavaScript can generally interact with the DOM according to normal browser rules.

But:

```text
https://example.com
https://evil.com
```

are different origins.

The malicious page cannot freely inspect the other page's DOM.

---

# 15. `window.postMessage`

Sometimes legitimate applications need controlled communication between different origins.

For example:

```text
https://app.example.com
        ↕
https://payments.example
```

JavaScript can use:

```javascript
window.postMessage()
```

But the receiver must validate the sender's origin.

Example:

```javascript
window.addEventListener("message", (event) => {
    if (event.origin !== "https://trusted.example.com") {
        return;
    }

    // Process trusted message
});
```

Never blindly trust:

```javascript
event.data
```

or accept messages from arbitrary origins.

---

# 16. Industry-Level Example — Payment Integration

Suppose your application embeds a payment component:

```text
Your App
   ↓
Payment iframe
```

The two components may have different origins.

They may communicate using:

```text
postMessage()
```

A secure implementation should validate:

```text
Sender origin
+
Expected message structure
+
Expected action
```

Otherwise, an attacker-controlled page could potentially send malicious messages.

---

# 17. Small Hands-On Lab

Create two simple pages on different origins, or use two localhost ports.

For example:

```text
http://localhost:3000
http://localhost:8080
```

These are different origins because the ports differ.

Open Developer Tools:

```text
F12
→ Console
```

Try making a cross-origin `fetch()` between applications you control.

Observe the browser's CORS/SOP behavior in the console.

You may see an error similar to:

```text
blocked by CORS policy
```

This demonstrates that the browser is enforcing cross-origin access rules.

---

# 18. SOP Does Not Stop Server-to-Server Requests

This is important for security testing.

SOP is primarily a **browser security boundary**.

A backend server can make requests to another server without being subject to browser SOP in the same way.

Therefore:

```text
Browser → Server
```

and:

```text
Server → Server
```

are very different security situations.

This distinction becomes extremely important when learning:

```text
SSRF
```

---

# 19. SOC Relevance

SOP/CORS issues can appear in web-security investigations.

A SOC analyst may encounter:

```text
Unexpected origins
Suspicious cross-origin requests
Misconfigured CORS policies
Untrusted postMessage communication
Credential-related browser attacks
```

Example:

```text
Unknown origin
      ↓
Sensitive API request
      ↓
CORS allows origin
      ↓
Sensitive response exposed
```

The analyst should investigate:

```text
Origin
Request
Response
Authentication state
CORS headers
Application configuration
```

---

# 20. Common Mistakes

### ❌ Thinking SOP blocks every cross-origin request

It doesn't.

### ❌ Thinking CORS is authentication

It isn't.

### ❌ Trusting every `Origin`

The application should explicitly determine which origins are trusted.

### ❌ Trusting `postMessage` blindly

Validate:

```text
event.origin
+
message structure
```

### ❌ Confusing origin and domain

Origin includes:

```text
Scheme + Host + Port
```

---

# 21. Interview Questions

### Q1. What is Same-Origin Policy?

A browser security mechanism that restricts scripts from freely accessing resources/data from different origins.

### Q2. What defines an origin?

```text
Scheme + Host + Port
```

### Q3. Are these same-origin?

```text
https://example.com
https://example.com/api
```

Yes.

### Q4. Are these same-origin?

```text
https://example.com
https://api.example.com
```

No.

### Q5. Does SOP prevent all cross-origin requests?

No. Browsers permit certain cross-origin requests/resource loading, while restricting access to responses and other interactions according to browser security rules.

### Q6. What is CORS?

A mechanism that allows servers to specify which origins may access certain cross-origin responses from browser scripts.

### Q7. Does SOP protect server-to-server communication?

No. SOP is primarily a browser security mechanism.

---

# 22. Quick Cheat Sheet

```text
SOP
→ Browser security boundary

Origin
→ Scheme + Host + Port

Same Origin
→ All three match

Different Origin
→ At least one differs

SOP
→ Restricts cross-origin browser access

CORS
→ Server-controlled permission for certain cross-origin access

postMessage
→ Controlled cross-origin communication

HttpOnly
→ Prevents normal JS access to cookie

SOP ≠ Authentication
SOP ≠ Authorization
CORS ≠ Authentication
```

## Core Mental Model

```text
                 BROWSER
                    |
          ┌─────────┴─────────┐
          ↓                   ↓
     Origin A             Origin B
          |                   |
          ↓                   ↓
       Trusted?          Cross-Origin?
          |                   |
          └─────────┬─────────┘
                    ↓
            Browser Security
                    ↓
          SOP + CORS + Cookie
              Security Rules
```

**Next:** `05-CORS.md`