````md id="http-status-codes"
# HTTP Status Codes

## 1. What is an HTTP Status Code?

An **HTTP status code** tells the client the result of its request.

```text
Client
  ↓
HTTP Request
  ↓
Server
  ↓
HTTP Response + Status Code
````

Example:

```http
HTTP/1.1 200 OK
```

> **Status code = result of the HTTP request**

---

# 2. Status Code Classes ⭐⭐⭐⭐⭐

| Class | Meaning       | Range   |
| ----- | ------------- | ------- |
| 1xx   | Informational | 100–199 |
| 2xx   | Success       | 200–299 |
| 3xx   | Redirection   | 300–399 |
| 4xx   | Client error  | 400–499 |
| 5xx   | Server error  | 500–599 |

🔥 Easy trick:

```text
1 → Information
2 → Success
3 → Redirect
4 → Client problem
5 → Server problem
```

---

# 3. 1xx — Informational

Request received; processing is continuing.

### 100 Continue

Client can continue sending the request body.

### 101 Switching Protocols

Server agrees to switch protocols.

Example:

* HTTP → WebSocket upgrade

> **1xx = intermediate/informational response**

---

# 4. 2xx — Success ⭐⭐⭐⭐⭐

## 200 OK

Request succeeded.

```text
GET /users
→ 200 OK
```

---

## 201 Created ⭐⭐⭐⭐⭐

A new resource was successfully created.

```text
POST /users
→ 201 Created
```

Often accompanied by a `Location` header identifying the new resource.

---

## 202 Accepted

Request accepted for processing, but processing may **not yet be complete**.

Useful for asynchronous operations.

🔥 **202 ≠ completed successfully.**

---

## 204 No Content

Request succeeded but there is **no response content/body**.

Example:

```text
DELETE /users/10
→ 204 No Content
```

---

# 5. 3xx — Redirection ⭐⭐⭐⭐⭐

## 301 Moved Permanently

Resource has a new permanent URL.

```text
Old URL
  ↓
301
  ↓
New URL
```

---

## 302 Found

Resource is temporarily available at another location.

---

## 303 See Other

Client should retrieve another resource using GET.

---

## 304 Not Modified ⭐⭐⭐⭐⭐

Resource has not changed since the client's cached version.

```text
Client Cache
    ↓
Conditional Request
    ↓
304 Not Modified
    ↓
Use cached copy
```

🔥 **304 is related to caching.**

It normally has no response body.

---

## 307 Temporary Redirect

Temporary redirect while preserving the request method.

## 308 Permanent Redirect

Permanent redirect while preserving the request method.

---

# 6. 4xx — Client Errors ⭐⭐⭐⭐⭐

The request cannot be fulfilled because of something associated with the request/client.

---

## 400 Bad Request

Server cannot understand/process the request due to invalid request syntax/data.

Example:

```text
Malformed JSON
   ↓
400 Bad Request
```

---

## 401 Unauthorized ⭐⭐⭐⭐⭐

Authentication is required or authentication failed.

Better interpretation:

> **401 = unauthenticated / authentication problem**

Example:

```text
No valid authentication
       ↓
401
```

🔥 The name **"Unauthorized"** can be misleading.

---

## 403 Forbidden ⭐⭐⭐⭐⭐

Server understood the request but refuses to authorize it.

```text
Authenticated user
        ↓
No permission
        ↓
403 Forbidden
```

### Key distinction

```text
401 → Authentication problem
403 → Authorization/permission problem
```

---

## 404 Not Found ⭐⭐⭐⭐⭐

Requested resource was not found.

```text
GET /users/99999
        ↓
404
```

---

## 405 Method Not Allowed ⭐⭐⭐⭐

HTTP method is known but **not allowed for that resource**.

Example:

```text
DELETE /readonly-file
       ↓
405 Method Not Allowed
```

---

## 409 Conflict ⭐⭐⭐⭐

Request conflicts with the current state of the resource.

Example:

* Duplicate resource
* Version/state conflict

---

## 429 Too Many Requests ⭐⭐⭐⭐⭐

Client has sent too many requests in a given period.

Commonly associated with:

**Rate limiting**

```text
Too many requests
       ↓
429
```

---

# 7. 5xx — Server Errors ⭐⭐⭐⭐⭐

Server failed while trying to fulfill a valid request.

---

## 500 Internal Server Error

Generic server-side failure.

```text
Request
  ↓
Server exception/error
  ↓
500
```

---

## 501 Not Implemented

Server does not support the functionality required to fulfill the request.

---

## 502 Bad Gateway ⭐⭐⭐⭐⭐

A gateway/proxy received an **invalid response from an upstream server**.

```text
Client
  ↓
Proxy / Gateway
  ↓
Upstream Server
  ✕
Invalid response
  ↓
502
```

---

## 503 Service Unavailable ⭐⭐⭐⭐⭐

Server is currently unable to handle the request.

Possible reasons:

* Overload
* Maintenance
* Temporary unavailability

---

## 504 Gateway Timeout ⭐⭐⭐⭐⭐

Gateway/proxy did not receive a timely response from an upstream server.

```text
Client
  ↓
Gateway
  ↓
Upstream
  ↓
⏳ Timeout
  ↓
504
```

---

# 8. 401 vs 403 ⭐⭐⭐⭐⭐

This is one of the **most common interview questions**.

### 401

```text
"Who are you?"
       ↓
Authentication failed/missing
```

### 403

```text
"I know who you are,
but you can't access this."
       ↓
Forbidden
```

---

# 9. 502 vs 503 vs 504 ⭐⭐⭐⭐⭐

| Code | Meaning                     |
| ---- | --------------------------- |
| 502  | Bad response from upstream  |
| 503  | Service unavailable         |
| 504  | Upstream response timed out |

Example:

```text
502 → Upstream replied incorrectly
503 → Service unavailable
504 → Upstream didn't respond in time
```

---

# 10. Common API Status Codes

A typical REST API might use:

```text
GET     /users/10
   ↓
200 OK

POST    /users
   ↓
201 Created

DELETE  /users/10
   ↓
204 No Content

Invalid request
   ↓
400

Not authenticated
   ↓
401

No permission
   ↓
403

Resource missing
   ↓
404

Too many requests
   ↓
429

Server failure
   ↓
500
```

---

# 🔥 Interview / GATE Traps

1. **2xx → success**
2. **3xx → redirection**
3. **4xx → client/request-side error**
4. **5xx → server-side error**
5. **200 → OK**
6. **201 → Created**
7. **204 → No Content**
8. **301 → permanent redirect**
9. **302 → temporary redirect**
10. **304 → Not Modified / caching**
11. **400 → Bad Request**
12. **401 → authentication problem**
13. **403 → forbidden / authorization problem**
14. **404 → resource not found**
15. **405 → method not allowed**
16. **429 → too many requests / rate limiting**
17. **500 → internal server error**
18. **502 → bad upstream response**
19. **503 → service unavailable**
20. **504 → gateway timeout**
21. **401 ≠ 403**
22. **502 ≠ 504**
23. 202 means **accepted for processing**, not necessarily completed.

---

# ⚡ 30-Second Revision

```text
1xx → INFORMATION
2xx → SUCCESS
3xx → REDIRECT
4xx → CLIENT ERROR
5xx → SERVER ERROR
```

### Must remember

```text
200 → OK
201 → Created
204 → No Content

301 → Permanent Redirect
302 → Temporary Redirect
304 → Not Modified

400 → Bad Request
401 → Authentication
403 → Forbidden
404 → Not Found
405 → Method Not Allowed
429 → Too Many Requests

500 → Internal Error
502 → Bad Upstream Response
503 → Service Unavailable
504 → Gateway Timeout
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```
```
