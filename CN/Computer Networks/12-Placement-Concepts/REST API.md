````md id="rest-api"
# REST API

## 1. What is REST?

**REST = Representational State Transfer**

REST is an **architectural style** for designing networked APIs.

> **REST API = API designed around resources, HTTP methods, and stateless communication.**

Example:

```text
/users
/orders
/products
````

These represent **resources**.

---

# 2. Resource ⭐⭐⭐⭐⭐

A resource is an entity that the API exposes.

Examples:

```text
/users
/users/10

/products
/products/25

/orders
/orders/100
```

Think:

```text
/users       → collection
/users/10    → one user
```

---

# 3. HTTP Methods + REST ⭐⭐⭐⭐⭐

REST commonly maps HTTP methods to operations:

| HTTP Method | Typical REST operation |
| ----------- | ---------------------- |
| GET         | Read                   |
| POST        | Create                 |
| PUT         | Replace                |
| PATCH       | Partial update         |
| DELETE      | Delete                 |

Example:

```text
GET    /users/10      → Get user 10
POST   /users         → Create user
PUT    /users/10      → Replace user 10
PATCH  /users/10      → Modify part of user 10
DELETE /users/10      → Delete user 10
```

---

# 4. Statelessness ⭐⭐⭐⭐⭐

A REST interaction should be **stateless**.

> Each request contains the information necessary for the server to process it.

```text
Request 1 → Server
Request 2 → Server
Request 3 → Server
```

The server should not depend on hidden client-session state to understand the request.

### Example

```http
GET /users/10
Authorization: Bearer <token>
```

The request carries its authentication information.

🔥 **Stateless does NOT mean "no server-side data exists."**

A server can still store:

* Database records
* User data
* Logs
* Caches

Statelessness concerns **client request state/context**, not all server storage.

---

# 5. REST Representation

The resource itself and its representation are different concepts.

Example:

```text
Resource:
User 10

Representation:
{
  "id": 10,
  "name": "Yash"
}
```

Common representation formats:

* JSON
* XML

Modern REST APIs commonly use **JSON**.

---

# 6. REST URL Design ⭐⭐⭐⭐⭐

### Good

```text
GET /users
GET /users/10
GET /users/10/orders
```

### Avoid action-heavy URLs

```text
❌ /getUser
❌ /deleteUser
❌ /createUser
```

Prefer HTTP methods:

```text
GET    /users/10
DELETE /users/10
POST   /users
```

> **URL identifies the resource; HTTP method describes the operation.**

---

# 7. Query Parameters

Used commonly for filtering, searching, sorting, or pagination.

Example:

```text
GET /users?city=Pune
```

```text
GET /products?category=phone&page=2
```

Path parameter:

```text
/users/10
```

Query parameter:

```text
/users?id=10
```

They serve different API-design purposes.

---

# 8. REST + HTTP Status Codes ⭐⭐⭐⭐⭐

A REST API should use meaningful HTTP status codes.

```text
GET /users/10
      ↓
200 OK
```

```text
POST /users
      ↓
201 Created
```

```text
DELETE /users/10
      ↓
204 No Content
```

```text
GET /users/999
      ↓
404 Not Found
```

```text
Invalid request
      ↓
400 Bad Request
```

---

# 9. Idempotency ⭐⭐⭐⭐⭐

REST APIs often take advantage of HTTP method semantics.

```text
PUT /users/10
```

Repeating the same PUT should produce the same intended final state.

```text
PUT X
PUT X
PUT X
 ↓
Final state = X
```

POST is generally not idempotent:

```text
POST /orders
POST /orders
```

May create two orders.

🔥 This is important when designing **retries**.

---

# 10. REST Constraints ⭐⭐⭐⭐⭐

The major REST architectural constraints are:

### 1. Client-Server

Client and server have separate responsibilities.

```text
Client ↔ API Server
```

### 2. Stateless

Each request contains necessary context.

### 3. Cacheable

Responses should indicate whether they can be cached.

### 4. Uniform Interface

A consistent way of interacting with resources.

### 5. Layered System

Client doesn't necessarily know whether it is communicating directly with the final server.

```text
Client
 ↓
Proxy
 ↓
Load Balancer
 ↓
Server
```

### 6. Code-on-Demand (Optional)

Server can optionally send executable code to the client.

🔥 The first five are the core constraints; **code-on-demand is optional**.

---

# 11. REST vs SOAP ⭐⭐⭐⭐⭐

| REST                            | SOAP                                  |
| ------------------------------- | ------------------------------------- |
| Architectural style             | Protocol                              |
| Commonly uses HTTP              | Can use multiple transport mechanisms |
| Often JSON                      | XML-based messaging                   |
| Lightweight/common for web APIs | More formal/feature-rich              |
| Resource-oriented design        | Operation/service-oriented            |

🔥 **REST is not a protocol.**

---

# 12. REST vs HTTP

They are not the same.

```text
HTTP
 ↓
Communication protocol

REST
 ↓
Architectural style
```

REST commonly uses HTTP, but REST is **not equivalent to HTTP**.

---

# 13. REST API Example

Suppose we have an e-commerce API:

```text
GET    /products
GET    /products/20
POST   /products
PUT    /products/20
PATCH  /products/20
DELETE /products/20
```

Flow:

```text
Client
  ↓
HTTP Request
  ↓
REST API
  ↓
Application Logic
  ↓
Database
  ↓
HTTP Response
```

---

# 🔥 Interview / GATE Traps

1. **REST = architectural style, not protocol.**
2. REST commonly uses HTTP.
3. REST is generally **stateless**.
4. Stateless ≠ no database/server storage.
5. Resource → `/users/10`.
6. HTTP method → operation.
7. GET → retrieve.
8. POST → create/submit.
9. PUT → replace.
10. PATCH → partial update.
11. DELETE → remove.
12. REST API commonly uses JSON, but REST does **not require JSON**.
13. REST does not require HTTP in the strict architectural sense, though HTTP is overwhelmingly common for REST APIs.
14. **POST is generally non-idempotent; PUT and DELETE are idempotent.**
15. REST has a **uniform interface** constraint.
16. Code-on-demand is an **optional** REST constraint.
17. `GET /users/10` is generally preferable to `/getUser?id=10` for resource-oriented design.

---

# ⚡ 30-Second Revision

```text
REST
 ↓
Architectural Style
 ↓
Resources
 ↓
HTTP Methods
 ↓
Stateless Requests
 ↓
Representations
 ↓
HTTP Responses
```

```text
/users
 ↓
GET    → Read
POST   → Create

/users/10
 ↓
GET    → Read
PUT    → Replace
PATCH  → Partial Update
DELETE → Delete
```

### Core REST constraints

```text
Client-Server
Stateless
Cacheable
Uniform Interface
Layered System
Code-on-Demand (optional)
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐⭐

```
```
