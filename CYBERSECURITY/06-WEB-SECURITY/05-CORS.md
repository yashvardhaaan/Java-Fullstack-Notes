# `05-CORS.md`

# CORS — Cross-Origin Resource Sharing

## 1. First Principle

**CORS is a browser security mechanism that controls which origins are allowed to read responses from another origin.**

Example:

```text
Frontend
https://app.example.com
        ↓
        API request
        ↓
Backend
https://api.example.com
```

These are different origins.

The backend can tell the browser:

```text
"Allow https://app.example.com to read my response."
```

---

# 2. Why CORS Exists

Without browser cross-origin protections, a malicious website could potentially use a victim's browser to access sensitive information from another website.

CORS works together with the **Same-Origin Policy**.

Mental model:

```text
JavaScript
    ↓
Cross-origin request
    ↓
Server response
    ↓
Browser checks CORS policy
    ↓
Allow / Block JavaScript access
```

---

# 3. What Is an Origin?

An origin consists of:

```text
Scheme + Host + Port
```

Example:

```text
https://app.example.com:443
```

contains:

```text
https
app.example.com
443
```

These are different origins:

```text
https://example.com
https://api.example.com
```

because the hosts differ.

---

# 4. Basic CORS Header

A server can respond with:

```http
Access-Control-Allow-Origin: https://app.example.com
```

This tells the browser that JavaScript running from:

```text
https://app.example.com
```

is allowed to access the response.

---

# 5. Simple CORS Flow

```text
React App
https://app.example.com
        ↓
GET https://api.example.com/products
        ↓
API Server
        ↓
Access-Control-Allow-Origin:
https://app.example.com
        ↓
Browser
        ↓
JavaScript can read response ✓
```

---

# 6. Wildcard `*`

A server may respond:

```http
Access-Control-Allow-Origin: *
```

This means broadly:

```text
Any origin may access the response
```

This can be appropriate for genuinely public resources.

But be careful with sensitive APIs.

For example:

```text
Private user data
+
Overly broad CORS policy
```

can create security problems depending on the authentication and credential model.

---

# 7. Credentials

Cross-origin requests may involve credentials such as cookies.

Example:

```javascript
fetch("https://api.example.com/profile", {
    credentials: "include"
});
```

The server must explicitly allow credentialed cross-origin access.

For example:

```http
Access-Control-Allow-Credentials: true
```

And the server generally cannot use:

```http
Access-Control-Allow-Origin: *
```

with credentialed CORS requests.

Instead, it should specify an allowed origin:

```http
Access-Control-Allow-Origin: https://app.example.com
Access-Control-Allow-Credentials: true
```

---

# 8. Preflight Request

Some cross-origin requests trigger a **preflight** request.

The browser sends:

```http
OPTIONS /api/users HTTP/1.1
Origin: https://app.example.com
Access-Control-Request-Method: POST
Access-Control-Request-Headers: Authorization, Content-Type
```

The server can respond:

```http
HTTP/1.1 204 No Content
Access-Control-Allow-Origin: https://app.example.com
Access-Control-Allow-Methods: POST
Access-Control-Allow-Headers: Authorization, Content-Type
```

Then the browser can send the actual request if the CORS requirements are satisfied.

---

# 9. Why `OPTIONS` Matters

A preflight asks the server:

> "Is this cross-origin request allowed?"

Conceptually:

```text
Browser
   ↓
OPTIONS
   ↓
"Can I send POST with Authorization?"
   ↓
Server
   ↓
"Yes"
   ↓
Browser
   ↓
POST
```

The browser handles this process automatically.

---

# 10. Common CORS Headers

Important headers include:

```text
Access-Control-Allow-Origin
Access-Control-Allow-Credentials
Access-Control-Allow-Methods
Access-Control-Allow-Headers
Access-Control-Expose-Headers
Access-Control-Max-Age
```

Example:

```http
Access-Control-Allow-Origin: https://app.example.com
Access-Control-Allow-Methods: GET, POST, PUT
Access-Control-Allow-Headers: Authorization, Content-Type
```

---

# 11. CORS Is Not Authentication

This is extremely important.

CORS does **not** mean:

```text
"This user is authorized."
```

It means approximately:

```text
"This browser origin is permitted to access this response."
```

Authentication:

```text
Who are you?
```

Authorization:

```text
What are you allowed to access?
```

CORS:

```text
Which browser origins may read this cross-origin response?
```

---

# 12. Industry Example — React + Spring Boot

Suppose your application uses:

```text
Frontend:
https://food.example.com

Backend:
https://api.food.example.com
```

React calls:

```javascript
fetch("https://api.food.example.com/orders");
```

The Spring Boot backend may configure an allowed origin:

```java
@CrossOrigin(origins = "https://food.example.com")
```

or configure CORS globally.

Conceptually:

```text
React
   ↓
Cross-origin request
   ↓
Spring Boot
   ↓
CORS policy
   ↓
Browser
```

For production systems, prefer explicit trusted origins rather than broad wildcard policies for sensitive APIs.

---

# 13. Dangerous CORS Configuration

Consider a sensitive API:

```text
/api/profile
/api/orders
/api/payments
```

and a configuration that effectively trusts arbitrary origins.

Potentially dangerous architecture:

```text
Any Origin
     ↓
Sensitive authenticated API
     ↓
Private data
```

The actual impact depends on whether credentials are involved and how authentication is implemented.

Therefore:

> CORS misconfiguration must be analyzed together with authentication, cookies, and authorization.

---

# 14. Origin Reflection Problem

A particularly dangerous pattern is blindly reflecting the supplied `Origin`.

Conceptually:

```text
Request:
Origin: https://attacker.example

Server:
Access-Control-Allow-Origin: https://attacker.example
```

If the application dynamically trusts arbitrary origins, an attacker-controlled website may gain access to responses that should only be available to trusted origins.

The correct approach is an **allowlist**:

```text
Trusted Origins
      ↓
Check incoming Origin
      ↓
Allowed?
 ┌────┴────┐
Yes       No
 ↓         ↓
Allow     Reject
```

---

# 15. CORS and Cookies

Suppose authentication uses cookies:

```http
Cookie: session=abc123
```

A cross-origin request might use:

```javascript
fetch(url, {
    credentials: "include"
});
```

For the browser to expose the response to JavaScript, the server's CORS policy must appropriately allow the requesting origin and credentials.

This is why these concepts must be understood together:

```text
Cookies
+
SameSite
+
SOP
+
CORS
+
CSRF
```

---

# 16. CORS Does Not Replace CSRF Protection

Suppose a user is authenticated using cookies.

An attacker might attempt to cause the victim's browser to send a request to the target application.

CORS primarily controls whether the attacker's JavaScript can **read the response**.

It does not serve as a general replacement for CSRF protections.

For state-changing operations, applications may use:

```text
CSRF tokens
+
SameSite cookies
+
Origin/Referer validation
```

as appropriate.

CSRF is covered in the next security topic.

---

# 17. CORS Errors vs Security Vulnerabilities

A browser might show:

```text
Blocked by CORS policy
```

This does not automatically mean the server is insecure.

It may simply mean:

```text
Frontend origin
      ↓
Not permitted by API CORS policy
```

Similarly, a CORS configuration that allows `*` is not automatically exploitable.

You must ask:

```text
Is sensitive data exposed?
Are credentials involved?
Can an attacker-controlled origin read it?
Is authentication required?
What does the server return?
```

---

# 18. Small Hands-On Lab

Use two applications that you own/control.

For example:

```text
Frontend:
http://localhost:3000

Backend:
http://localhost:8080
```

These are different origins because the ports differ.

From the frontend:

```javascript
fetch("http://localhost:8080/api/products")
```

Inspect the browser console.

Then configure the backend to allow:

```text
http://localhost:3000
```

Observe how the browser behavior changes.

Inspect the response headers in:

```text
F12
→ Network
→ Request
→ Response Headers
```

Look for:

```text
Access-Control-Allow-Origin
```

---

# 19. curl Lab

You can manually send an `Origin` header:

```bash
curl -i https://api.example.com \
  -H "Origin: https://app.example.com"
```

Look at the response headers.

You may see:

```http
Access-Control-Allow-Origin: https://app.example.com
```

Important:

> `curl` does not enforce browser SOP/CORS. It simply shows you what the server returns.

This distinction is useful during security testing.

---

# 20. SOC Relevance

CORS investigations may involve:

```text
Unexpected Origin headers
Suspicious cross-origin requests
Sensitive API responses
Overly broad CORS policies
Credentialed cross-origin requests
Unexpected trusted domains
```

Example:

```text
Attacker-controlled origin
        ↓
Sensitive API
        ↓
Server allows origin
        ↓
Response contains private data
```

An analyst should investigate:

```text
Origin
Endpoint
Authentication
Response data
CORS headers
Application configuration
```

---

# 21. Common Mistakes

### ❌ `Access-Control-Allow-Origin: *` everywhere

Not automatically vulnerable, but inappropriate for many sensitive APIs.

### ❌ Trusting arbitrary origins

Don't blindly reflect the `Origin` header.

### ❌ Treating CORS as authentication

CORS doesn't establish user identity.

### ❌ Using CORS as CSRF protection

They solve different problems.

### ❌ Testing only with curl

CORS is primarily enforced by browsers, so browser behavior matters.

### ❌ Allowing unnecessary methods/headers

Use the minimum required permissions.

---

# 22. Interview Questions

### Q1. What is CORS?

A browser security mechanism that allows servers to specify which origins may access certain cross-origin responses.

### Q2. What is `Access-Control-Allow-Origin`?

A response header specifying which origin may access the response.

### Q3. What is a preflight request?

A browser-generated `OPTIONS` request used to check whether a cross-origin request is permitted before sending the actual request.

### Q4. Can CORS authenticate a user?

No.

### Q5. Can CORS prevent CSRF?

It is not a substitute for CSRF protection.

### Q6. Why is blindly reflecting `Origin` dangerous?

Because an application may accidentally trust attacker-controlled origins and expose sensitive responses to them.

### Q7. Does curl enforce CORS?

No. Browser CORS enforcement is a client-side browser security mechanism.

---

# 23. Quick Cheat Sheet

```text
CORS
→ Cross-Origin Resource Sharing

Purpose
→ Control browser access to cross-origin responses

Origin
→ Scheme + Host + Port

Important headers
→ Allow-Origin
→ Allow-Credentials
→ Allow-Methods
→ Allow-Headers

Preflight
→ OPTIONS request

Credentials
→ Cookies/auth credentials in cross-origin requests

Danger
→ Arbitrary/reflective trusted origins

CORS ≠ Authentication
CORS ≠ Authorization
CORS ≠ CSRF protection
```

## Core Mental Model

```text
                 BROWSER
                    ↓
          Cross-Origin Request
                    ↓
                 SERVER
                    ↓
          CORS Response Headers
                    ↓
                 BROWSER
                    ↓
          ┌─────────┴─────────┐
          ↓                   ↓
      Allowed              Not Allowed
          ↓                   ↓
   JS reads response      JS blocked
```

**Next:** `06-CSRF.md`