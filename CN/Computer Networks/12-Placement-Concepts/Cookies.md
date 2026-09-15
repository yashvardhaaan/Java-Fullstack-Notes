````md id="cookies"
# Cookies

## 1. What is a Cookie?

A **cookie** is a small piece of data stored by the browser and associated with a website.

> **Cookie = client-side stored data used to maintain state/context across HTTP requests.**

Why needed?

HTTP is **stateless**:

```text
Request 1 → Server
Request 2 → Server
Request 3 → Server
````

By default, the server does not automatically know that all requests came from the same user.

Cookies help maintain that context.

---

# 2. Basic Cookie Flow ⭐⭐⭐⭐⭐

```text
1. Client → Server
           ↓
2. Server → Set-Cookie
           ↓
3. Browser stores cookie
           ↓
4. Later request
           ↓
5. Browser → Cookie
           ↓
6. Server recognizes state/session
```

Example:

```http
Set-Cookie: sessionId=abc123
```

Later:

```http
Cookie: sessionId=abc123
```

---

# 3. Cookie Attributes ⭐⭐⭐⭐⭐

### `Expires`

Specifies when the cookie expires.

### `Max-Age`

Specifies lifetime in seconds.

### `Domain`

Controls which domain can receive the cookie.

### `Path`

Controls which URL paths the cookie is sent to.

### `Secure`

Cookie is sent only over **HTTPS**.

### `HttpOnly`

JavaScript cannot normally access the cookie through `document.cookie`.

Useful for reducing cookie theft through XSS.

### `SameSite` ⭐⭐⭐⭐⭐

Controls when cookies are sent in **cross-site** contexts.

Common values:

```text
Strict
Lax
None
```

`SameSite=None` generally requires `Secure`.

---

# 4. Session Cookie vs Persistent Cookie

### Session Cookie

Usually removed when the browser session ends.

No persistent `Expires`/`Max-Age` is specified.

### Persistent Cookie

Has an expiration/lifetime.

```text
Expires / Max-Age
        ↓
Persistent cookie
```

| Session                           | Persistent                            |
| --------------------------------- | ------------------------------------- |
| Temporary                         | Stored for defined lifetime           |
| Usually ends with browser session | Survives browser restart until expiry |

---

# 5. Secure Cookie ⭐⭐⭐⭐⭐

```http
Set-Cookie: sessionId=abc; Secure
```

The browser sends it only over an HTTPS connection.

🔥 **Secure does not encrypt the cookie itself.**

It controls **when it is transmitted**.

---

# 6. HttpOnly Cookie ⭐⭐⭐⭐⭐

```http
Set-Cookie: sessionId=abc; HttpOnly
```

JavaScript cannot normally read it using:

```js
document.cookie
```

### Why useful?

If an XSS vulnerability exists, it makes it harder for injected JavaScript to directly steal the session cookie.

🔥 **HttpOnly does NOT prevent XSS itself.**

---

# 7. SameSite Cookie ⭐⭐⭐⭐⭐

Controls cross-site cookie sending.

### Strict

Most restrictive.

```text
Cross-site request
      ↓
Cookie generally NOT sent
```

### Lax

Allows cookies in some top-level navigation cases while restricting many cross-site requests.

### None

Allows cross-site cookie use.

```text
SameSite=None
      +
Secure
```

---

# 8. Cookies and Sessions ⭐⭐⭐⭐⭐

A common architecture:

```text
Browser
   ↓
sessionId cookie
   ↓
Server
   ↓
Session Store
   ↓
User information
```

The cookie contains only an identifier:

```text
sessionId = abc123
```

Server stores:

```text
abc123 → User 42
```

### Important

> **Cookie ≠ Session**

A cookie is client-side storage/transmission mechanism.

A session is server-side state in a common session architecture.

---

# 9. Cookies vs Local Storage ⭐⭐⭐⭐

| Cookie                                                   | localStorage                  |
| -------------------------------------------------------- | ----------------------------- |
| Automatically sent to matching requests                  | Not automatically sent        |
| Has security attributes such as HttpOnly/Secure/SameSite | No HttpOnly                   |
| Small size                                               | Larger storage capacity       |
| Common for sessions                                      | Common for client-side data   |
| Sent in HTTP headers                                     | Accessed through browser APIs |

🔥 Sensitive authentication/session data needs careful storage decisions.

---

# 10. Cookie Security Attacks

### XSS

Malicious JavaScript may attempt to steal accessible cookies.

**Defense:**

* HttpOnly
* Output encoding
* Input validation
* CSP and other XSS defenses

### CSRF

Attacker tricks a user's browser into making an authenticated request.

**Defense:**

* SameSite cookies
* CSRF tokens
* Origin/Referer checks where appropriate

### Session Fixation

Attacker causes a victim to use a known session identifier.

**Defense:**

* Regenerate session ID after authentication.

---

# 11. Cookie Size

Cookies are designed for **small pieces of data**.

🔥 Don't use cookies as a general-purpose database.

---

# 🔥 Interview / GATE Traps

1. **HTTP is stateless.**
2. Cookies help maintain state across HTTP requests.
3. Server sends cookies using **`Set-Cookie`**.
4. Browser sends them using **`Cookie`**.
5. `Secure` → send only over HTTPS.
6. `HttpOnly` → prevents normal JavaScript access.
7. `HttpOnly` does **not** prevent XSS.
8. `SameSite` → controls cross-site cookie sending.
9. `SameSite=None` generally requires `Secure`.
10. Cookie ≠ session.
11. Session ID is commonly stored in a cookie.
12. Persistent cookie → `Expires` / `Max-Age`.
13. Cookies are automatically attached to matching HTTP requests.
14. localStorage is **not automatically sent** with HTTP requests.
15. Cookies are small; don't treat them as general storage.

---

# ⚡ 30-Second Revision

```text
HTTP = Stateless
       ↓
Cookie = Maintains client context
       ↓
Set-Cookie → Server → Browser
Cookie     → Browser → Server
```

### Security

```text
Secure
 ↓
HTTPS only

HttpOnly
 ↓
No normal JS access

SameSite
 ↓
Cross-site request control
```

### Common architecture

```text
Browser
   ↓
sessionId cookie
   ↓
Server
   ↓
Session Store
   ↓
User state
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```
```
