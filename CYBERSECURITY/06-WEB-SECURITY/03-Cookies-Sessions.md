# `03-Cookies-Sessions.md`

# Cookies & Sessions

## 1. First Principle

HTTP is **stateless**.

That means each request is independent:

```text
Request 1 → Server
Request 2 → Server
Request 3 → Server
```

The server needs a mechanism to remember:

> "This request belongs to this authenticated user."

Cookies and sessions solve this problem.

---

# 2. What Is a Cookie?

A cookie is small data stored by the browser and sent back to the server on applicable requests.

Server:

```http
Set-Cookie: session_id=abc123
```

Browser stores it.

Later:

```http
Cookie: session_id=abc123
```

The server can use the cookie to associate the request with a session.

---

# 3. Session-Based Authentication

Typical flow:

```text
Login
  ↓
Username + Password
  ↓
Server verifies credentials
  ↓
Server creates session
  ↓
Session ID sent to browser
  ↓
Browser stores cookie
```

Later:

```text
Browser
  ↓
Cookie: session_id=abc123
  ↓
Server
  ↓
Find session abc123
  ↓
Identify user
```

The browser does **not** need to send the password on every request.

---

# 4. Session ID

A session ID should be:

```text
Random
+
Unpredictable
+
Sufficiently long
```

Example:

```text
session_id=8f4d91a7c...
```

Not:

```text
session_id=12345
```

An attacker who obtains a valid session identifier may potentially impersonate the associated user.

---

# 5. Important Cookie Attributes

## Secure

```http
Set-Cookie: session=abc123; Secure
```

The browser should send the cookie over HTTPS connections.

---

## HttpOnly

```http
Set-Cookie: session=abc123; HttpOnly
```

JavaScript cannot normally access the cookie through:

```javascript
document.cookie
```

This helps reduce the impact of some XSS attacks against session cookies.

It does **not** prevent XSS itself.

---

## SameSite

Controls when cookies are sent in cross-site contexts.

Common values:

```text
Strict
Lax
None
```

Example:

```http
Set-Cookie: session=abc123; Secure; HttpOnly; SameSite=Lax
```

SameSite is particularly important for reducing certain cross-site request attacks.

---

# 6. Cookie Security Example

### Weak

```http
Set-Cookie: session=abc123
```

### Better

```http
Set-Cookie: session=abc123; Secure; HttpOnly; SameSite=Lax
```

The exact configuration depends on the application's architecture.

---

# 7. Session Lifecycle

A secure session should have a lifecycle:

```text
Login
  ↓
Session Created
  ↓
Authenticated Requests
  ↓
Session Rotation where appropriate
  ↓
Logout / Expiration
  ↓
Session Invalidated
```

Don't keep authentication sessions alive indefinitely.

---

# 8. Session Fixation

In a session fixation attack, an attacker attempts to get a victim to use a session identifier that the attacker already knows.

Conceptually:

```text
Attacker
   ↓
Known Session ID
   ↓
Victim logs in using that session
   ↓
Attacker uses same session
```

A key defense is:

> **Regenerate the session ID after successful authentication.**

Example:

```text
Before login:
Session A

After login:
Session B
```

Session A should no longer provide authenticated access.

---

# 9. Session Hijacking

Session hijacking occurs when an attacker obtains a valid authenticated session credential.

Example:

```text
Victim
  ↓
Valid session cookie
  ↓
Attacker obtains cookie
  ↓
Attacker sends cookie
  ↓
Server treats attacker as victim
```

Possible causes include:

```text
XSS
Malware
Insecure transmission
Compromised device
Poor session management
Credential theft
```

HTTPS, `HttpOnly`, secure session management, and endpoint security all help reduce risk.

---

# 10. Session Expiration

Sessions should have appropriate expiration.

Example:

```text
Session created
     ↓
Active
     ↓
Idle timeout
     ↓
Session invalidated
```

Applications may use:

```text
Idle timeout
Absolute timeout
Logout invalidation
Password-change invalidation
Risk-based/session revocation
```

The appropriate values depend on application sensitivity and organizational requirements.

---

# 11. Logout

A secure logout should invalidate the server-side session when using server-side sessions.

Conceptually:

```text
Before logout:

session_id=abc123
     ↓
Valid session ✓
```

After logout:

```text
session_id=abc123
     ↓
Invalid session ✗
```

Simply hiding the frontend page is not logout.

---

# 12. Session vs Cookie

These are related but not identical.

### Cookie

Client-side storage mechanism used by the browser.

### Session

Server-side authentication/state associated with a user.

Typical architecture:

```text
Browser
  ↓
Cookie: session_id=ABC
  ↓
Server
  ↓
Session Store
  ↓
User information
```

---

# 13. Session Storage

A production application might store sessions in:

```text
Memory
Redis
Database
Distributed session store
```

For example:

```text
Spring Boot
    ↓
Session ID cookie
    ↓
Redis
    ↓
User session
```

For distributed applications, shared session storage can allow multiple backend instances to recognize the same session.

---

# 14. Industry Example — E-Commerce

Suppose a user logs into an e-commerce application.

```text
POST /login
        ↓
Server validates credentials
        ↓
Creates session
        ↓
Set-Cookie: session=...
```

Then:

```text
GET /cart
Cookie: session=...
```

The backend identifies the user and returns their cart.

If an attacker steals the session cookie:

```text
Attacker
   ↓
Cookie
   ↓
GET /cart
   ↓
Server
   ↓
Potential unauthorized access
```

Therefore session security is critical.

---

# 15. Session Cookies vs Persistent Cookies

### Session cookie

Usually expires when the browser session ends, depending on browser behavior.

```http
Set-Cookie: session=abc123
```

### Persistent cookie

Has an explicit expiration/max age.

```http
Set-Cookie: remember=abc123; Max-Age=2592000
```

Persistent authentication requires additional care because the credential can remain valid for a longer period.

---

# 16. Cookie Scope

Cookies can have attributes controlling where they are sent.

Important attributes include:

```text
Domain
Path
Secure
HttpOnly
SameSite
Expires
Max-Age
```

For example:

```http
Set-Cookie: session=abc123; Path=/; Secure; HttpOnly; SameSite=Lax
```

Avoid making sensitive cookies broader in scope than necessary.

---

# 17. Session Token vs Password

A session cookie should **not contain the user's plaintext password**.

Bad:

```text
session=password123
```

A session credential should instead be an unpredictable identifier/token.

Example:

```text
session=7f3c9a...random...
```

---

# 18. Industry-Level Example — Spring Boot

A traditional server-side session architecture might look like:

```text
React / Browser
      ↓
Cookie
      ↓
Spring Boot
      ↓
Session Repository
      ↓
Redis
```

Spring Security can manage authentication and session behavior.

Important production considerations include:

```text
HTTPS
Secure cookies
HttpOnly cookies
SameSite configuration
Session fixation protection
Session expiration
CSRF protection
Logout handling
```

---

# 19. Small Hands-On Lab

Use browser Developer Tools on an application you own or are authorized to test.

Open:

```text
F12
→ Application
→ Cookies
```

Inspect:

```text
Name
Value
Domain
Path
Expires
Secure
HttpOnly
SameSite
```

Then open:

```text
F12
→ Network
```

Inspect an authenticated request.

Look for:

```http
Cookie: session=...
```

Understand:

```text
Login
 ↓
Cookie created
 ↓
Cookie sent with requests
 ↓
Server recognizes session
```

---

# 20. SOC Relevance

SOC analysts may investigate:

```text
Session cookie theft
Impossible session behavior
Unexpected geographic access
Multiple devices using same session
Abnormal session duration
Authentication followed by unusual API activity
```

Example:

```text
09:00 → User logs in from Pune
09:05 → Same session appears from another country
09:06 → Sensitive account changes
```

This could be a useful investigation signal, though location alone does not prove compromise.

Correlate:

```text
Authentication logs
+
Session identifiers
+
IP information
+
Device information
+
Application activity
```

---

# 21. Common Mistakes

### ❌ Predictable session IDs

```text
session=10001
```

### ❌ Missing `Secure`

Sensitive cookies should generally use HTTPS and the `Secure` attribute.

### ❌ Missing `HttpOnly`

Can increase the impact of client-side script attacks against cookie-based sessions.

### ❌ Never expiring sessions

Creates unnecessarily long-lived credentials.

### ❌ Not rotating session ID after login

Can enable session fixation.

### ❌ Logout only on frontend

Server-side authentication state must also be invalidated where applicable.

### ❌ Storing passwords in cookies

Never do this.

---

# 22. Interview Questions

### Q1. Why are cookies used?

To allow browsers to retain state and send information such as session credentials with subsequent requests.

### Q2. What is a session?

Server-side state associated with a user, commonly referenced by a session identifier stored in a cookie.

### Q3. What does HttpOnly do?

Prevents normal JavaScript access to the cookie.

### Q4. What does Secure do?

Instructs the browser to send the cookie only over secure HTTPS connections.

### Q5. What is SameSite?

A cookie attribute controlling cross-site cookie sending behavior.

### Q6. What is session fixation?

An attack where a victim is induced to authenticate using a session identifier known to the attacker.

### Q7. What is session hijacking?

Unauthorized use of a valid authenticated session credential.

### Q8. How do you defend against session fixation?

Regenerate the session identifier after authentication and invalidate the previous session where appropriate.

---

# 23. Quick Cheat Sheet

```text
Cookie
→ Browser-side storage

Session
→ Server-side authentication/state

Secure
→ HTTPS only

HttpOnly
→ JavaScript cannot normally read cookie

SameSite
→ Controls cross-site cookie behavior

Session Fixation
→ Attacker gets victim to use known session ID

Session Hijacking
→ Attacker obtains valid session credential

Good Session ID
→ Random + unpredictable

Good Session Management
→ Rotation + expiration + invalidation
```

## Core Mental Model

```text
              USER LOGIN
                  ↓
           Authentication
                  ↓
            Session Created
                  ↓
        ┌───────────────────┐
        │ Session ID Cookie  │
        └─────────┬─────────┘
                  ↓
             Browser
                  ↓
       Cookie on authenticated
             requests
                  ↓
              Server
                  ↓
          Session Validation
                  ↓
         Authorization Check
                  ↓
             Allow / Deny
```

**Next:** `04-Same-Origin-Policy.md`