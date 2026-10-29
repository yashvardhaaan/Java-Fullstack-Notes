# `06-CSRF.md`

# CSRF — Cross-Site Request Forgery

## 1. First Principle

**CSRF tricks a user's browser into sending an unwanted state-changing request to a website where the user is already authenticated.**

The key issue is:

```text
Victim is logged in
        +
Browser automatically sends credentials
        ↓
Attacker causes unwanted request
        ↓
Server accepts it
```

Example:

```text
Victim logged into bank
        ↓
Visits malicious website
        ↓
Browser sends authenticated request
        ↓
Money transfer occurs
```

---

# 2. Why CSRF Happens

CSRF is especially relevant when authentication uses cookies.

Suppose:

```text
Cookie:
session=abc123
```

The browser may automatically attach that cookie to requests for the relevant site.

An attacker may try to cause the browser to make:

```http
POST /api/change-email
```

The server sees:

```text
Valid session
     ↓
Request accepted
```

The problem is that the legitimate user did not intentionally perform the action.

---

# 3. Simple CSRF Scenario

Imagine a vulnerable application:

```http
POST /change-email

email=attacker@example.com
```

Victim is logged in.

An attacker's page attempts to cause the victim's browser to submit the request.

Conceptually:

```text
Attacker Website
       ↓
Victim Browser
       ↓
Target Website
       ↓
Change Email
```

If the application relies only on the automatically supplied session cookie, the request may be accepted.

---

# 4. CSRF vs XSS

These are different vulnerabilities.

### CSRF

Attacker causes a victim's browser to perform an unwanted action.

```text
Attacker
   ↓
Victim Browser
   ↓
Target Application
```

### XSS

Attacker gets malicious JavaScript to execute in the target application's security context.

```text
Attacker-controlled input
        ↓
Target Website
        ↓
Malicious JavaScript executes
```

XSS can sometimes bypass or undermine CSRF defenses, which is why both matter.

---

# 5. CSRF Requirements

A typical CSRF scenario requires several conditions:

```text
1. Victim is authenticated
2. Authentication is automatically sent
3. Attacker can cause a request
4. Request changes server-side state
5. Server lacks adequate CSRF defenses
```

Commonly affected actions:

```text
Change email
Change password
Transfer money
Create/delete resources
Change account settings
```

---

# 6. CSRF Token

One of the classic defenses is a **CSRF token**.

The server generates a secret/unpredictable token associated with the user's session.

Example form:

```html
<input
    type="hidden"
    name="csrf_token"
    value="random-token">
```

The request becomes:

```text
POST /change-email

email=user@example.com
csrf_token=random-token
```

The server verifies:

```text
Session valid?
      +
CSRF token valid?
      ↓
Allow
```

An attacker's website generally does not know the legitimate CSRF token.

---

# 7. Synchronizer Token Pattern

Typical flow:

```text
User requests form
       ↓
Server generates CSRF token
       ↓
Token included in form
       ↓
User submits form
       ↓
Server verifies token
       ↓
Valid → Process
Invalid → Reject
```

This is commonly called the **Synchronizer Token Pattern**.

---

# 8. SameSite Cookies

Modern browsers provide another important defense through:

```text
SameSite
```

Example:

```http
Set-Cookie: session=abc123; Secure; HttpOnly; SameSite=Lax
```

Possible values:

```text
Strict
Lax
None
```

`SameSite` controls when cookies are sent in cross-site contexts.

For many applications, `Lax` or `Strict` can significantly reduce CSRF risk.

However:

> Do not treat cookie configuration as the only security control without understanding the application's architecture.

---

# 9. Origin Validation

The server can inspect the:

```http
Origin:
```

header.

Example:

```http
Origin: https://attacker.example
```

The application can compare it against trusted origins.

Conceptually:

```text
Origin
   ↓
Trusted?
 ┌─┴─┐
Yes No
 ↓   ↓
Allow Reject
```

For sensitive state-changing operations, origin validation can be an additional CSRF defense.

---

# 10. Referer Validation

Applications may also inspect the:

```http
Referer:
```

header where appropriate.

Example:

```http
Referer: https://app.example.com/account
```

But `Referer` can be affected by privacy policies and browser behavior.

Therefore, it should be handled carefully and is generally better considered as part of a layered defense rather than the sole protection.

---

# 11. CSRF with JSON APIs

A common misconception is:

> "My API uses JSON, so CSRF is impossible."

Not necessarily.

For example:

```http
POST /api/profile
Content-Type: application/json
```

If authentication relies on cookies and the application accepts a request pattern that an attacker can trigger cross-site, CSRF may still need consideration.

Using:

```text
Authorization: Bearer <token>
```

where the token is not automatically attached by the browser can change the CSRF threat model.

But XSS and token theft remain important concerns.

---

# 12. CSRF vs CORS

These are different.

### CORS

Controls whether browser JavaScript can access certain cross-origin responses.

### CSRF

Concerns unwanted state-changing requests made using the victim's authentication context.

```text
CORS
→ Can attacker JS READ the response?

CSRF
→ Can attacker cause an unwanted authenticated ACTION?
```

CORS should not be used as a replacement for CSRF protection.

---

# 13. Industry Example — Banking

Suppose a banking application has:

```http
POST /transfer
```

with:

```text
recipient=12345
amount=50000
```

The victim is authenticated using a session cookie.

A vulnerable application might accept the request based only on:

```text
Valid session cookie
```

A secure design could require:

```text
Valid session
+
CSRF protection
+
Authorization
+
Transaction validation
+
Possibly additional transaction authentication
```

For high-value financial actions, additional controls such as transaction signing or step-up authentication may also be appropriate.

---

# 14. Industry Example — Your Food Delivery App

Suppose your Spring Boot application has:

```http
POST /api/address/delete
```

Authentication:

```text
Session cookie
```

An attacker could attempt to cause the victim's browser to submit:

```text
addressId=123
```

If the server only checks:

```text
Is session valid?
```

then CSRF may be possible.

Secure architecture:

```text
Request
   ↓
Session validation
   ↓
CSRF validation
   ↓
Authorization
   ↓
Does address belong to user?
   ↓
Delete
```

Notice that **CSRF protection and authorization are both required**.

---

# 15. CSRF Token Is Not a Password

A CSRF token should be:

```text
Random
Unpredictable
Associated with the user's session/context
```

Don't use:

```text
csrf=12345
```

or:

```text
csrf=username
```

Use a secure random token generated by a trusted framework/library.

---

# 16. Small Hands-On Lab

Use an application you own or are explicitly authorized to test.

Open:

```text
F12
→ Network
```

Perform a state-changing action such as changing a profile setting.

Inspect the request.

Look for:

```text
Cookie
Origin
Referer
CSRF token/header
HTTP method
Request body
```

Ask:

```text
Is authentication automatically attached?

Is there a CSRF token?

Does the server validate Origin?

Is SameSite configured?

Does the server verify authorization?
```

---

# 17. Spring Security

If you're using Spring Boot/Spring Security, CSRF protection is an important built-in capability for applications using browser-based authentication.

Don't blindly disable it:

```java
csrf(csrf -> csrf.disable())
```

without understanding the application's authentication model.

For example, a browser application using session cookies has a different CSRF threat model from a stateless API using bearer tokens in an `Authorization` header.

The correct configuration depends on the architecture.

---

# 18. SOC Relevance

CSRF is primarily an application-security issue, but SOC analysts may encounter related activity.

Potential indicators:

```text
Unexpected state-changing requests
Suspicious Origin headers
Unusual account-setting changes
Unexpected password/email modifications
Abnormal authenticated requests
```

Example:

```text
User normally:
GET /orders

Suddenly:
POST /change-email
POST /add-payment-method
POST /change-password
```

Correlate:

```text
Authentication logs
+
HTTP logs
+
Origin/Referer
+
Session information
+
Account changes
```

---

# 19. Common Mistakes

### ❌ Relying only on CORS

CORS is not CSRF protection.

### ❌ Disabling CSRF everywhere

Understand your authentication architecture first.

### ❌ Using predictable CSRF tokens

Tokens must be unpredictable.

### ❌ Checking only whether the user is logged in

Authentication does not prove that the request was intentionally initiated by the user.

### ❌ Forgetting authorization

Even with CSRF protection:

```text
User A
  ↓
Valid request
  ↓
/orders/123
```

The server must still check whether User A is authorized to access order `123`.

---

# 20. Interview Questions

### Q1. What is CSRF?

An attack where an attacker causes an authenticated user's browser to make an unwanted state-changing request.

### Q2. Why is CSRF associated with cookies?

Because browsers can automatically attach cookies to requests for the relevant site.

### Q3. How do you prevent CSRF?

Common defenses include:

```text
CSRF tokens
SameSite cookies
Origin validation
Appropriate authentication architecture
```

### Q4. Does CORS prevent CSRF?

No. CORS and CSRF address different security concerns.

### Q5. Does a CSRF token need to be secret?

It must be unpredictable and protected appropriately so an attacker cannot obtain a valid token for the victim's session.

### Q6. Is CSRF possible with bearer tokens?

It depends on how the token is stored and attached. If the browser does not automatically attach the credential cross-site, the classic cookie-based CSRF model may not apply. Other threats, especially XSS/token theft, still matter.

---

# 21. Quick Cheat Sheet

```text
CSRF
→ Cross-Site Request Forgery

Goal
→ Cause unwanted authenticated action

Common target
→ Cookie-based authentication

Defenses
→ CSRF token
→ SameSite cookies
→ Origin validation
→ Layered authorization

CSRF ≠ XSS
CSRF ≠ CORS

CSRF Token
→ Unpredictable
→ Associated with session/context

Important
→ Authentication + CSRF + Authorization
```

## Core Mental Model

```text
              VICTIM
                ↓
         Already Logged In
                ↓
        Authentication Cookie
                ↓
        ┌───────────────┐
        │ Attacker tries │
        │ unwanted action│
        └───────┬───────┘
                ↓
           Target Server
                ↓
       CSRF Validation
          /         \
       Valid       Invalid
         ↓            ↓
       Allow        Reject
```

**Next:** `07-XSS.md`