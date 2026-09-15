````md id="cors"
# CORS

## 1. What is CORS?

**CORS = Cross-Origin Resource Sharing**

It is a browser security mechanism that controls whether a web page from one **origin** can access resources from another origin.

> **CORS controls cross-origin requests made by browser-based JavaScript.**

Example:

```text
Frontend
https://app.example.com
        ↓
        API
https://api.example.com
````

These are **different origins** because their hosts differ.

---

# 2. What is an Origin? ⭐⭐⭐⭐⭐

An origin is:

```text
Origin = Scheme + Host + Port
```

Example:

```text
https://example.com:443
```

### Different origin?

```text
http://example.com
https://example.com
```

❌ Different scheme.

```text
https://example.com
https://api.example.com
```

❌ Different host.

```text
https://example.com:443
https://example.com:8080
```

❌ Different port.

### Same-origin

```text
https://example.com/page1
https://example.com/page2
```

✅ Same origin.

🔥 **Path does not determine origin.**

---

# 3. Why CORS? ⭐⭐⭐⭐⭐

Browsers enforce the **Same-Origin Policy (SOP)**.

Without browser restrictions, malicious websites could potentially make requests to other sites using your browser's credentials and read sensitive responses.

CORS provides a controlled way for a server to say:

> "Requests from this origin are allowed."

---

# 4. Basic CORS Flow

```text id="v7m0lm"
Browser
   ↓
Request from Origin A
   ↓
Server
   ↓
Access-Control-Allow-Origin
   ↓
Browser checks permission
   ↓
Allow / Block JavaScript access
```

Example response:

```http
Access-Control-Allow-Origin: https://app.example.com
```

This tells the browser that this origin is allowed.

---

# 5. Simple Request vs Preflight ⭐⭐⭐⭐⭐

Not every cross-origin request requires a preflight.

For certain requests, the browser first sends:

```http
OPTIONS /api/users
Origin: https://app.example.com
```

This is called a **preflight request**.

Server may respond:

```http
Access-Control-Allow-Origin: https://app.example.com
Access-Control-Allow-Methods: GET, POST
Access-Control-Allow-Headers: Authorization, Content-Type
```

Then the browser can send the actual request if permitted.

```text id="9r9y8d"
Browser
   ↓
OPTIONS (preflight)
   ↓
Server
   ↓
Permission
   ↓
Actual Request
   ↓
Response
```

🔥 **OPTIONS → commonly used for CORS preflight.**

---

# 6. Why Does Preflight Happen?

The browser may preflight requests that are considered potentially more significant/non-simple.

Common triggers include:

* Certain HTTP methods such as PUT, PATCH, DELETE
* Custom/non-safelisted request headers
* Certain content types

Example:

```http
Authorization: Bearer <token>
```

can cause a preflight in a cross-origin browser request.

---

# 7. Important CORS Headers ⭐⭐⭐⭐⭐

### `Access-Control-Allow-Origin`

Specifies allowed origin(s).

```http
Access-Control-Allow-Origin: https://app.example.com
```

### `Access-Control-Allow-Methods`

Allowed HTTP methods.

```http
Access-Control-Allow-Methods: GET, POST, DELETE
```

### `Access-Control-Allow-Headers`

Allowed request headers.

```http
Access-Control-Allow-Headers: Authorization, Content-Type
```

### `Access-Control-Allow-Credentials`

Controls whether credentials may be included in cross-origin requests.

```http
Access-Control-Allow-Credentials: true
```

---

# 8. Credentials + CORS ⭐⭐⭐⭐⭐

Credentials can include:

* Cookies
* HTTP authentication
* Client certificates in relevant contexts

When credentials are used, the server must explicitly allow the requesting origin.

```http
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: https://app.example.com
```

🔥 A wildcard origin:

```http
Access-Control-Allow-Origin: *
```

cannot be used to allow credentialed CORS requests.

---

# 9. CORS vs Same-Origin Policy ⭐⭐⭐⭐⭐

### Same-Origin Policy

Browser security restriction.

```text
Different Origin
      ↓
Browser restricts access
```

### CORS

Controlled mechanism allowing a server to relax certain cross-origin browser restrictions.

```text
Server
  ↓
"I allow this origin"
  ↓
Browser permits access
```

> **SOP = restriction**
> **CORS = controlled permission**

---

# 10. CORS vs CSRF ⭐⭐⭐⭐⭐

They are different.

### CORS

Controls whether browser JavaScript can access cross-origin responses.

### CSRF

An attack where a victim's browser is tricked into making an unwanted authenticated request.

```text id="xw7gkg"
CORS
 ↓
Cross-origin access control

CSRF
 ↓
Unauthorized action using victim's credentials
```

🔥 CORS is **not a general CSRF defense**.

---

# 11. CORS Is a Browser Mechanism

Important:

```text id="l5r3gu"
Browser → Enforces CORS
```

A server-to-server HTTP request does not automatically become subject to browser CORS rules.

Example:

```text id="c7b2dw"
Server A ─────→ Server B
```

CORS is primarily relevant to **browser security and browser-origin requests**.

---

# 🔥 Interview / GATE Traps

1. **CORS = Cross-Origin Resource Sharing.**
2. CORS is primarily a **browser security mechanism**.
3. Origin = **scheme + host + port**.
4. Different port → different origin.
5. Different scheme → different origin.
6. Different subdomain → different origin.
7. Different path alone → **same origin**.
8. **OPTIONS** is commonly used for CORS preflight.
9. Preflight happens only for requests that require it; **not every cross-origin request is preflighted**.
10. `Access-Control-Allow-Origin` specifies allowed origins.
11. `Access-Control-Allow-Methods` specifies allowed methods.
12. `Access-Control-Allow-Headers` specifies allowed request headers.
13. Credentialed CORS cannot use `Access-Control-Allow-Origin: *`.
14. CORS ≠ authentication.
15. CORS ≠ authorization.
16. CORS ≠ encryption.
17. CORS ≠ CSRF protection.
18. Non-browser/server-to-server requests are not blocked by browser CORS enforcement.

---

# ⚡ 30-Second Revision

```text id="q4t5p0"
Origin
 ↓
Scheme + Host + Port

Different Origin
 ↓
Same-Origin Policy
 ↓
Browser restricts access

CORS
 ↓
Server explicitly allows origin
 ↓
Browser permits cross-origin access
```

### Preflight

```text id="8s4a0r"
Browser
   ↓
OPTIONS
   ↓
CORS permission check
   ↓
Actual Request
```

### Key headers

```text id="7x1wbo"
Allow-Origin  → Which origin?
Allow-Methods → Which methods?
Allow-Headers → Which headers?
Allow-Credentials → Credentials allowed?
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐⭐

```
```
