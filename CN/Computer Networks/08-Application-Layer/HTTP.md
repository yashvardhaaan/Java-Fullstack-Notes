````md id="http-gate"
# HTTP — HyperText Transfer Protocol

## 1. Definition

**HTTP** is an **Application Layer protocol** used for communication between clients and web servers.

> HTTP follows a **request → response** model.

```text
Client
  │
  │ HTTP Request
  ↓
Server
  │
  │ HTTP Response
  ↓
Client
````

---

# 2. HTTP Layer & Port ⭐⭐⭐⭐⭐

HTTP operates at the **Application Layer (L7)**.

Traditional HTTP:

```text
HTTP  → TCP → IP
Port  → 80
```

HTTPS:

```text
HTTPS → TCP → TLS → IP
Port  → 443
```

⚠️ Modern HTTP/3 is different:

```text
HTTP/3 → QUIC → UDP
```

---

# 3. HTTP Request ⭐⭐⭐⭐⭐

A request contains:

```text id="y3x9n8"
Request Line
Headers
Blank Line
Optional Body
```

Example:

```http
GET /index.html HTTP/1.1
Host: example.com
```

### Request Line

```text
METHOD  URL/path  VERSION
```

Example:

```text
GET /index.html HTTP/1.1
```

---

# 4. HTTP Methods ⭐⭐⭐⭐⭐

| Method  | Purpose                        |
| ------- | ------------------------------ |
| GET     | Retrieve resource              |
| POST    | Submit/create/process data     |
| PUT     | Replace/update resource        |
| PATCH   | Partial update                 |
| DELETE  | Delete resource                |
| HEAD    | Headers only, no response body |
| OPTIONS | Supported methods/capabilities |

### Easy memory

```text
GET     → Get
POST    → Submit
PUT     → Replace
PATCH   → Partial update
DELETE  → Delete
HEAD    → Headers
```

---

# 5. HTTP Response ⭐⭐⭐⭐⭐

Response contains:

```text id="6a9w1j"
Status Line
Headers
Blank Line
Optional Body
```

Example:

```http
HTTP/1.1 200 OK
Content-Type: text/html
```

---

# 6. HTTP Status Codes ⭐⭐⭐⭐⭐

Status codes are grouped by first digit:

| Class | Meaning       |
| ----- | ------------- |
| 1xx   | Informational |
| 2xx   | Success       |
| 3xx   | Redirection   |
| 4xx   | Client error  |
| 5xx   | Server error  |

Important:

```text
200 → OK
201 → Created
301 → Moved Permanently
302 → Found/temporary redirect
304 → Not Modified
400 → Bad Request
401 → Unauthorized
403 → Forbidden
404 → Not Found
500 → Internal Server Error
502 → Bad Gateway
503 → Service Unavailable
```

🔥 Remember:

```text
4xx → Client-side/request problem
5xx → Server-side problem
```

---

# 7. HTTP is Stateless ⭐⭐⭐⭐⭐

HTTP itself is **stateless**.

This means:

> Each request is independent; HTTP does not inherently remember previous requests.

Example:

```text
Request 1 → Server
Request 2 → Server
Request 3 → Server
```

The server does not automatically know that all three came from the same application session.

State can be maintained using mechanisms such as:

* Cookies
* Sessions
* Tokens

---

# 8. Persistent vs Non-Persistent HTTP ⭐⭐⭐⭐⭐

### Non-Persistent HTTP

One TCP connection is used for one request/response transaction.

```text
TCP connection
      ↓
Request
      ↓
Response
      ↓
Close
```

Multiple objects may require multiple connections.

---

### Persistent HTTP

The TCP connection can remain open for multiple requests/responses.

```text
TCP connection
      ↓
Request → Response
      ↓
Request → Response
      ↓
Request → Response
      ↓
Close
```

🔥 Persistent connections reduce repeated connection-establishment overhead.

---

# 9. HTTP/1.0 vs HTTP/1.1

### HTTP/1.0

Traditionally:

```text
One TCP connection
      ↓
One request/response
```

Persistent connections were not the default behavior.

### HTTP/1.1

Persistent connections became the default.

```text
One TCP connection
      ↓
Multiple requests/responses
```

---

# 10. HTTP/1.1 Pipelining ⭐⭐⭐

HTTP/1.1 can support **pipelining**, where multiple requests are sent without waiting for each response.

However, responses remain ordered, which can cause:

> **Head-of-Line (HOL) blocking**

---

# 11. HTTP/2 ⭐⭐⭐⭐⭐

HTTP/2 improves HTTP communication over a TCP connection.

Important features:

* Binary framing
* Multiplexing
* Header compression (**HPACK**)
* Stream-based communication
* Multiple requests/responses can be in flight over one TCP connection

Conceptually:

```text
                TCP Connection
                     ↓
        ┌────────────┼────────────┐
       Stream 1    Stream 2    Stream 3
```

### Key benefit

Multiple streams can share one connection instead of requiring separate connections for every resource.

---

# 12. HTTP/3 ⭐⭐⭐⭐⭐

HTTP/3 uses:

```text
HTTP/3
  ↓
QUIC
  ↓
UDP
```

QUIC provides transport features such as:

* Reliability
* Encryption integration
* Stream multiplexing
* Connection migration

🔥 Important distinction:

> **HTTP/3 does NOT run directly over TCP.**

---

# 13. HTTP Cookies

Cookies allow state to be maintained across HTTP requests.

Typical flow:

```text
Client → Server
       ← Set-Cookie

Client → Cookie → Server
```

Cookies can be used for:

* Sessions
* Preferences
* Authentication-related state
* Tracking

---

# 14. HTTP Cache ⭐⭐⭐⭐

Caching avoids repeatedly downloading unchanged resources.

```text
Client
  ↓
Cache
  ↓
Server
```

Important response:

```text
304 Not Modified
```

means the cached representation can generally be reused.

---

# 🔥 GATE Traps

### Trap 1

HTTP is a Transport Layer protocol.

❌

> HTTP = **Application Layer**

---

### Trap 2

HTTP always uses TCP.

❌

```text
HTTP/1.1 → TCP
HTTP/2   → TCP
HTTP/3   → QUIC → UDP
```

---

### Trap 3

HTTP is stateful.

❌

> HTTP itself is **stateless**.

Cookies/sessions can provide stateful application behavior.

---

### Trap 4

404 means server failure.

❌

> **404 = Not Found** → 4xx client/request-side status class.

---

### Trap 5

500 means client error.

❌

> **500 = Internal Server Error** → 5xx server-side status class.

---

### Trap 6

HTTPS is a completely different application protocol from HTTP.

❌

HTTPS is essentially:

```text
HTTP
 ↓
TLS
 ↓
TCP
```

for HTTP versions that use TCP.

---

# ⚡ 30-Second Revision

```text
HTTP
 ↓
Application Layer
 ↓
Request ↔ Response

HTTP → TCP → IP
Port 80

HTTPS → TLS → TCP → IP
Port 443

HTTP/3 → QUIC → UDP

Methods:
GET
POST
PUT
PATCH
DELETE
HEAD
OPTIONS

Status:
1xx → Info
2xx → Success
3xx → Redirect
4xx → Client
5xx → Server

HTTP = Stateless
```

### 🔥 Must Remember

> **HTTP/1.1 & HTTP/2 → TCP**
> **HTTP/3 → QUIC → UDP**

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Focus on:

1. HTTP request/response
2. Methods
3. Status codes
4. Persistent vs non-persistent HTTP
5. HTTP/1.1 vs HTTP/2 vs HTTP/3
6. HTTP vs HTTPS
7. Statelessness
8. HTTP timing/connection numericals

```
```
