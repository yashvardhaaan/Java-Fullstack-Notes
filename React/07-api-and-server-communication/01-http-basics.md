# 01 — HTTP Basics

HTTP is the foundation of **frontend ↔ backend communication**. Before learning `fetch`, REST APIs, Axios, etc., you should understand how HTTP actually works.

---

## WHY?

A React application usually cannot store everything itself.

For example:

```text
React Application
      ↓
"I need user data"
      ↓
HTTP Request
      ↓
Backend Server
      ↓
Database
      ↓
HTTP Response
      ↓
React Application
```

HTTP provides the communication mechanism between the **client** and **server**.

Without understanding HTTP, concepts like:

* `GET`
* `POST`
* `PUT`
* `PATCH`
* `DELETE`
* status codes
* headers
* request body
* REST APIs
* authentication

will be difficult to understand properly.

---

# WHAT?

## What is HTTP?

**HTTP = HyperText Transfer Protocol**

It is a protocol used for communication between a **client** and a **server**.

For a React application:

```text
Browser = Client
React   = Frontend
Backend = Server
```

Example:

```text
React
  ↓
GET /api/users
  ↓
Backend
  ↓
Database
  ↓
Users data
  ↓
React
```

---

# HTTP Request and Response

HTTP communication normally follows:

```text
CLIENT
   |
   | HTTP Request
   ↓
SERVER
   |
   | HTTP Response
   ↓
CLIENT
```

For example:

```text
Browser
   |
   | GET /api/products
   ↓
Server
   |
   | 200 OK
   | [{...}, {...}]
   ↓
Browser
```

---

# HTTP Request

A request is sent **from the client to the server**.

A request can contain:

```text
HTTP Request
├── Method
├── URL
├── Headers
└── Body
```

Example:

```http
POST /api/users HTTP/1.1
Content-Type: application/json

{
  "name": "Yash",
  "email": "yash@example.com"
}
```

Let's understand each part.

---

# 1. HTTP Method

The method tells the server **what operation the client wants to perform**.

Common methods:

| Method | Typical purpose           |
| ------ | ------------------------- |
| GET    | Retrieve data             |
| POST   | Create/send data          |
| PUT    | Replace/update resource   |
| PATCH  | Partially update resource |
| DELETE | Delete resource           |

Example:

```http
GET /api/users
```

means:

> Give me users.

---

```http
POST /api/users
```

means:

> Create a user.

---

```http
DELETE /api/users/10
```

means:

> Delete user 10.

---

# 2. URL

The URL tells the client **where to send the request**.

Example:

```text
https://example.com/api/users
```

Breakdown:

```text
https://
   ↓
Protocol

example.com
   ↓
Domain

/api/users
   ↓
Path
```

A URL can also contain query parameters:

```text
/api/products?category=laptop&page=2
```

Here:

```text
category=laptop
page=2
```

are query parameters.

---

# 3. Headers

Headers provide **additional information about the request or response**.

Example:

```http
Content-Type: application/json
```

This tells the server:

> The request body contains JSON.

Another common header:

```http
Authorization: Bearer <token>
```

This can carry authentication credentials.

Common headers:

```text
Content-Type
Authorization
Accept
Cache-Control
```

---

# 4. Request Body

The body contains data sent to the server.

For example:

```http
POST /api/users

{
  "name": "Yash",
  "email": "yash@example.com"
}
```

The JSON object is the **request body**.

GET requests typically don't use a request body; query parameters are commonly used instead.

---

# HTTP Response

The server sends a response back.

A response contains:

```text
HTTP Response
├── Status Code
├── Headers
└── Body
```

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "name": "Yash",
  "email": "yash@example.com"
}
```

---

# Status Codes

Status codes tell the client **what happened with the request**.

They are grouped into categories.

## 1xx — Informational

```text
100–199
```

Generally informational responses.

---

## 2xx — Success

```text
200 OK
201 Created
204 No Content
```

### 200

Request succeeded.

```text
GET /users
→ 200 OK
```

### 201

Something was successfully created.

```text
POST /users
→ 201 Created
```

### 204

Request succeeded but there is no response body.

Common example:

```text
DELETE /users/10
→ 204 No Content
```

---

# 3xx — Redirection

```text
300–399
```

Examples:

```text
301 Moved Permanently
302 Found
304 Not Modified
```

These generally involve redirects or caching behavior.

---

# 4xx — Client Errors

These indicate a problem with the request/client side.

Common ones:

```text
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
409 Conflict
422 Unprocessable Content
```

### 400

The request is invalid.

```text
POST /users
→ invalid JSON/data
→ 400 Bad Request
```

### 401

Authentication is required or credentials are invalid.

```text
GET /profile
→ 401 Unauthorized
```

### 403

The server understood the request but refuses to allow it.

```text
Admin page
→ normal user
→ 403 Forbidden
```

### 404

Requested resource wasn't found.

```text
GET /users/999999
→ 404 Not Found
```

---

# 5xx — Server Errors

These indicate that something went wrong on the server.

Examples:

```text
500 Internal Server Error
502 Bad Gateway
503 Service Unavailable
```

For example:

```text
React
 ↓
GET /api/users
 ↓
Backend crashes
 ↓
500 Internal Server Error
```

---

# ⭐ Important Status Code Table

| Code | Meaning               | Typical example                |
| ---: | --------------------- | ------------------------------ |
|  200 | OK                    | Successful GET                 |
|  201 | Created               | Successful POST                |
|  204 | No Content            | Successful DELETE              |
|  400 | Bad Request           | Invalid request                |
|  401 | Unauthorized          | Not authenticated              |
|  403 | Forbidden             | No permission                  |
|  404 | Not Found             | Resource doesn't exist         |
|  409 | Conflict              | Duplicate/conflicting resource |
|  422 | Unprocessable Content | Validation failure             |
|  500 | Internal Server Error | Server failure                 |
|  503 | Service Unavailable   | Server temporarily unavailable |

---

# WHERE?

HTTP is used whenever applications communicate over a network.

### React → Backend

```text
React
 ↓ HTTP
Node.js / Java / Python / .NET
```

### Backend → External API

```text
Backend
 ↓ HTTP
Payment API
```

### Browser → Website

```text
Chrome
 ↓ HTTP/HTTPS
Website Server
```

---

# HOW?

Let's see a complete React example.

```jsx
async function getUsers() {
  const response = await fetch(
    "https://example.com/api/users"
  );

  const data = await response.json();

  console.log(data);
}
```

What happens?

### Step 1

React executes:

```js
fetch("/api/users");
```

### Step 2

Browser creates an HTTP request:

```http
GET /api/users
```

### Step 3

Server processes the request.

### Step 4

Server sends:

```http
200 OK
```

with JSON:

```json
[
  {
    "id": 1,
    "name": "Yash"
  }
]
```

### Step 5

React reads the response:

```js
const data = await response.json();
```

Now:

```js
data
```

contains the JavaScript representation of the JSON.

---

# HTTP vs HTTPS

## HTTP

```text
http://example.com
```

Data is transmitted without the protection provided by TLS encryption.

## HTTPS

```text
https://example.com
```

HTTP is used over a **TLS-encrypted connection**.

For modern web applications, HTTPS should be used for production traffic, especially when handling authentication or sensitive information.

Think:

```text
HTTP
 ↓
Communication protocol

HTTPS
 ↓
HTTP + TLS security
```

---

# Query Parameters

Query parameters are commonly used to provide filtering, searching, sorting, pagination, etc.

Example:

```text
/api/products?category=phone&page=2
```

Here:

```text
category = phone
page     = 2
```

React:

```js
fetch(
  "/api/products?category=phone&page=2"
);
```

---

# Path Parameters

Path parameters identify a specific resource.

Example:

```text
/api/users/25
```

Here:

```text
25
```

is the user ID.

React:

```js
fetch(`/api/users/${userId}`);
```

If:

```js
userId = 25;
```

the request becomes:

```text
/api/users/25
```

### Query vs Path

```text
/api/users/25
          ↑
       Path parameter
```

vs.

```text
/api/users?page=2
             ↑
        Query parameter
```

---

# Request vs Response

This distinction is extremely important.

### Request

Client → Server

```text
Method
URL
Headers
Body
```

### Response

Server → Client

```text
Status code
Headers
Body
```

Remember:

```text
REQUEST
Client → Server

RESPONSE
Server → Client
```

---

# Practical React Example

```jsx
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    async function loadUsers() {
      const response = await fetch("/api/users");

      if (!response.ok) {
        throw new Error("Failed to fetch users");
      }

      const data = await response.json();

      setUsers(data);
    }

    loadUsers();
  }, []);

  return (
    <div>
      {users.map((user) => (
        <p key={user.id}>
          {user.name}
        </p>
      ))}
    </div>
  );
}
```

The communication is:

```text
React Component
      ↓
fetch()
      ↓
GET /api/users
      ↓
Backend
      ↓
Database
      ↓
JSON Response
      ↓
response.json()
      ↓
setUsers()
      ↓
React UI
```

---

# 🔥 Common Mistakes

### Mistake 1 — Confusing request and response

```text
Request  = Client → Server
Response = Server → Client
```

---

### Mistake 2 — Thinking 404 means server is down

Not necessarily.

```text
404
```

usually means the requested resource/route wasn't found.

A server failure is more commonly represented by:

```text
500
```

---

### Mistake 3 — Thinking 401 and 403 are the same

They are different.

```text
401 → Authentication problem
403 → Permission/access problem
```

A useful shorthand:

> **401 = Who are you?**
> **403 = I know who you are, but you can't do this.**

---

### Mistake 4 — Sending sensitive information through URLs

Avoid putting sensitive information such as passwords or secrets in query parameters.

Bad:

```text
/login?password=123456
```

Use an appropriate request body and secure transport instead.

---

# 🎯 Interview Questions

### Q1. What is HTTP?

> HTTP is an application-layer protocol used for communication between clients and servers.

---

### Q2. What is the difference between HTTP and HTTPS?

> HTTPS is HTTP secured using TLS, providing encryption and protection against certain types of interception and tampering.

---

### Q3. What is an HTTP request?

> An HTTP request is a message sent by a client to a server containing information such as the method, URL, headers, and optionally a body.

---

### Q4. What is an HTTP response?

> An HTTP response is the server's message back to the client containing a status code, headers, and optionally a body.

---

### Q5. Difference between 401 and 403?

```text
401 → Authentication required/failed
403 → Authenticated but not permitted
```

---

### Q6. Difference between 400 and 500?

```text
400 → Client/request problem
500 → Server-side problem
```

---

### Q7. What is a request header?

> A request header provides metadata or instructions about the request, such as content type or authorization information.

---

### Q8. What is a request body?

> The request body contains data sent from the client to the server, commonly used with methods such as POST, PUT, and PATCH.

---

### Q9. What are query parameters?

> Query parameters are key-value parameters appended to a URL, commonly used for filtering, searching, sorting, and pagination.

Example:

```text
/products?category=mobile&page=2
```

---

# ⭐ Remember

```text
                 HTTP
                  │
       ┌──────────┴──────────┐
       ↓                     ↓
    REQUEST               RESPONSE
       │                     │
   Method                  Status
   URL                     Headers
   Headers                 Body
   Body
       │                     ↑
       └────── Server ───────┘
```

### One-line interview answer

> **HTTP is the communication protocol that allows a client such as a React application to send requests to a server and receive responses containing status codes, headers, and data.**

---

**Next topic:** `02 — REST API`
