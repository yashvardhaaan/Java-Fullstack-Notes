````md id="sessions"
# Sessions

## 1. What is a Session?

A **session** is a mechanism used by an application to maintain a user's state across multiple HTTP requests.

> **Session = server/application-side state associated with a client/user.**

HTTP itself is stateless:

```text
Request 1 → Server
Request 2 → Server
Request 3 → Server
````

The server needs a way to associate these requests with the same user.

---

# 2. How Sessions Work ⭐⭐⭐⭐⭐

Common architecture:

```text
Browser
   ↓
Login
   ↓
Server creates Session
   ↓
Session ID
   ↓
Cookie
   ↓
Browser stores Cookie
```

Later:

```text
Browser
   ↓
Cookie: sessionId=ABC123
   ↓
Server
   ↓
Find session ABC123
   ↓
Identify user
```

Example:

```text id="g0kz5v"
Cookie:
sessionId = ABC123

Server Session Store:
ABC123 → User = 42
```

🔥 Usually the browser stores the **session identifier**, while the server stores the corresponding session state.

---

# 3. Why Sessions?

Without a session:

```text
Login request
      ↓
Authenticated

Next request
      ↓
Server doesn't automatically know
who the user is
```

With session:

```text
Login
 ↓
Session created
 ↓
Session ID
 ↓
Future requests
 ↓
User recognized
```

---

# 4. Session Lifecycle ⭐⭐⭐⭐⭐

```text
Login
  ↓
Create Session
  ↓
Send Session ID
  ↓
Client stores ID
  ↓
Requests use Session ID
  ↓
Server validates session
  ↓
Logout / Expiration
  ↓
Session destroyed/invalidated
```

---

# 5. Session ID ⭐⭐⭐⭐⭐

A session ID should be:

* Random
* Unpredictable
* Sufficiently long
* Unique
* Protected in transit

Example:

```text id="3q9p8d"
sessionId = 7f83a9...random...
```

🔥 Never use predictable values such as:

```text
sessionId = 1
sessionId = 2
sessionId = 3
```

Attackers could guess them.

---

# 6. Session Cookie ⭐⭐⭐⭐⭐

A common implementation stores the session ID in a cookie:

```http
Set-Cookie: sessionId=ABC123; Secure; HttpOnly; SameSite=Lax
```

Then:

```http
Cookie: sessionId=ABC123
```

### Security attributes

| Attribute | Purpose                     |
| --------- | --------------------------- |
| Secure    | HTTPS transmission          |
| HttpOnly  | Prevent normal JS access    |
| SameSite  | Controls cross-site sending |

---

# 7. Session vs Cookie ⭐⭐⭐⭐⭐

They are **not the same thing**.

| Cookie                   | Session                     |
| ------------------------ | --------------------------- |
| Client-side mechanism    | Application state           |
| Stored by browser        | Commonly stored server-side |
| Sent with HTTP requests  | Associated with session ID  |
| Can contain various data | Represents user's state     |

Typical relationship:

```text id="1r48vp"
Cookie
   ↓
Session ID
   ↓
Server Session
   ↓
User State
```

---

# 8. Session vs JWT ⭐⭐⭐⭐⭐

### Traditional Session

```text id="k2jqq8"
Client
  ↓
Session ID
  ↓
Server
  ↓
Session Store
```

Server maintains state.

### JWT

```text id="n4ml2e"
Client
  ↓
JWT
  ↓
Server verifies token
```

The token can carry claims, so the server may not need a central session store for every request.

| Session                         | JWT                                          |
| ------------------------------- | -------------------------------------------- |
| Server-side state commonly used | Token carries claims                         |
| Client stores session ID        | Client stores token                          |
| Easy server-side invalidation   | Revocation requires additional design        |
| Often cookie-based              | Often sent in Authorization header or cookie |

🔥 JWT is **not automatically more secure** than sessions.

---

# 9. Session Fixation ⭐⭐⭐⭐⭐

Attacker gets a victim to use a **known session ID**.

```text id="j2z5tw"
Attacker
   ↓
Known Session ID
   ↓
Victim logs in
   ↓
Same Session ID becomes authenticated
   ↓
Attacker may hijack session
```

### Defense

**Regenerate the session ID after successful authentication.**

---

# 10. Session Hijacking ⭐⭐⭐⭐⭐

Attacker obtains a valid user's session ID.

```text id="5cnm6f"
Victim
   ↓
Valid Session ID
   ↓
Attacker obtains it
   ↓
Attacker impersonates user
```

Possible defenses:

* HTTPS
* Secure cookies
* HttpOnly cookies
* SameSite where appropriate
* Short session lifetime
* Session ID rotation
* Secure application design

---

# 11. Session Expiration

Sessions can expire because of:

### Idle timeout

Session expires after inactivity.

### Absolute timeout

Session expires after a maximum lifetime regardless of activity.

```text id="2m0o9x"
Login
 ↓
Session
 ↓
Timeout
 ↓
Invalid
```

---

# 12. Distributed Sessions ⭐⭐⭐⭐

Problem:

```text id="9h4h69"
             Load Balancer
             /           \
          Server A      Server B
```

If session exists only on Server A, Server B may not know it.

Solutions:

### Shared Session Store

```text
Server A ──┐
           ↓
       Redis/DB
           ↑
Server B ──┘
```

### Sticky Sessions

Load balancer repeatedly sends the user to the same server.

🔥 Shared session storage generally provides better flexibility when scaling horizontally.

---

# 13. Session Security Best Practices

```text id="3i6qzt"
Use HTTPS
   +
Secure cookie
   +
HttpOnly
   +
SameSite
   +
Random session ID
   +
Regenerate after login
   +
Expiration/timeout
```

---

# 🔥 Interview / GATE Traps

1. **HTTP is stateless; sessions provide application-level state.**
2. Session ≠ cookie.
3. A cookie commonly stores a **session ID**, not the complete session state.
4. Session ID must be unpredictable.
5. Regenerate session ID after authentication to help prevent session fixation.
6. Session hijacking = attacker obtains a valid session credential.
7. `HttpOnly` helps prevent JavaScript from directly reading the cookie.
8. `Secure` → cookie sent over HTTPS.
9. `SameSite` helps control cross-site cookie sending.
10. JWT and sessions solve related but different state/token-management problems.
11. JWT is **not automatically stateless in every application design**.
12. Distributed systems may use shared session stores or sticky sessions.

---

# ⚡ 30-Second Revision

```text id="z3lq9w"
HTTP
 ↓
Stateless
 ↓
Session
 ↓
Maintains user state

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

### Security

```text id="hlw5tx"
Random ID
HTTPS
Secure
HttpOnly
SameSite
Timeout
Regenerate after login
```

### Scaling

```text id="w7y2hs"
Load Balancer
   ↓
Server A / B / C
   ↓
Shared Session Store
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```
```
