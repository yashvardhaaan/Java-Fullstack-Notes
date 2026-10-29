# `02-HTTP-Request-Response.md`

# HTTP Request & Response

## 1. First Principle

HTTP is the communication protocol used by browsers, APIs, and web servers.

Basic model:

```text
Client
  ↓
HTTP Request
  ↓
Server
  ↓
HTTP Response
  ↓
Client
```

Example:

```text
Browser → GET /products → Server
Browser ← 200 OK + JSON ← Server
```

Understanding HTTP deeply is essential for web security.

---

# 2. HTTP Request

A request contains:

```text
Method
URL / Path
Headers
Body
```

Example:

```http
POST /api/login HTTP/1.1
Host: example.com
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "secret"
}
```

---

# 3. HTTP Methods

Common methods:

| Method | Purpose |
|---|---|
| GET | Retrieve data |
| POST | Create/submit data |
| PUT | Replace a resource |
| PATCH | Partially modify a resource |
| DELETE | Delete a resource |
| HEAD | Headers only |
| OPTIONS | Ask what methods/options are supported |

Example REST API:

```http
GET /api/users/10
POST /api/users
PATCH /api/users/10
DELETE /api/users/10
```

---

# 4. GET Request

Example:

```http
GET /products?id=10 HTTP/1.1
Host: shop.example
```

The query parameter is:

```text
id=10
```

Important:

> GET parameters are visible in the URL and should not be used for sensitive secrets.

Avoid:

```text
GET /login?password=secret123
```

---

# 5. POST Request

POST commonly sends data in the request body.

```http
POST /api/login HTTP/1.1
Host: example.com
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "secret"
}
```

The server processes the submitted data.

---

# 6. HTTP Headers

Headers provide metadata.

Example:

```http
Host: example.com
Content-Type: application/json
Authorization: Bearer eyJ...
User-Agent: Mozilla/5.0
Accept: application/json
```

Security-relevant headers include:

```text
Authorization
Cookie
Origin
Referer
Content-Type
Host
User-Agent
```

Attackers frequently manipulate headers, so applications should not blindly trust them.

---

# 7. HTTP Request Body

The body carries data.

JSON example:

```json
{
  "username": "yash",
  "role": "user"
}
```

Form example:

```text
username=yash&password=secret
```

File uploads can also use request bodies, commonly with:

```text
multipart/form-data
```

---

# 8. HTTP Response

A response contains:

```text
Status Code
Headers
Body
```

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 10,
  "name": "Laptop"
}
```

---

# 9. HTTP Status Codes

### 2xx — Success

```text
200 OK
201 Created
204 No Content
```

### 3xx — Redirection

```text
301 Moved Permanently
302 Found
304 Not Modified
```

### 4xx — Client/request problem

```text
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
405 Method Not Allowed
429 Too Many Requests
```

### 5xx — Server-side problem

```text
500 Internal Server Error
502 Bad Gateway
503 Service Unavailable
504 Gateway Timeout
```

---

# 10. 401 vs 403

This is a common interview question.

### 401

Authentication is missing or invalid.

```text
"Who are you?"
→ Authentication required/failed
```

### 403

The server understood the request but refuses access.

```text
"I know who you are,
but you're not allowed to do this."
```

Example:

```text
User → /admin
       ↓
Authenticated
       ↓
Not authorized
       ↓
403 Forbidden
```

---

# 11. URL Structure

Example:

```text
https://example.com:443/api/users?id=10#profile
```

Parts:

```text
https
 ↓
Scheme

example.com
 ↓
Host

443
 ↓
Port

/api/users
 ↓
Path

?id=10
 ↓
Query

#profile
 ↓
Fragment
```

The fragment is generally handled by the browser and is not sent to the server in the HTTP request.

---

# 12. HTTP vs HTTPS

HTTP:

```text
Client
  ↓
HTTP
  ↓
Server
```

HTTPS:

```text
Client
  ↓
TLS
  ↓
HTTP
  ↓
Server
```

HTTPS protects communication using TLS.

It provides:

```text
Confidentiality
+
Integrity
+
Server authentication
```

---

# 13. Cookies

A server can send:

```http
Set-Cookie: session=abc123
```

The browser later sends:

```http
Cookie: session=abc123
```

Cookies are commonly used for:

```text
Sessions
Authentication
Preferences
Tracking
```

Important security attributes include:

```text
Secure
HttpOnly
SameSite
```

These will be covered in detail in:

```text
03-Cookies-Sessions.md
```

---

# 14. Authorization Header

APIs commonly use:

```http
Authorization: Bearer <token>
```

Example:

```http
GET /api/profile HTTP/1.1
Authorization: Bearer eyJhbGci...
```

The server validates the token before returning protected information.

Never expose real access tokens in:

```text
GitHub
Screenshots
Logs
Public URLs
Chat messages
```

---

# 15. Content-Type

`Content-Type` tells the server what type of data is being sent.

JSON:

```http
Content-Type: application/json
```

HTML:

```http
Content-Type: text/html
```

Plain text:

```http
Content-Type: text/plain
```

File upload:

```http
Content-Type: multipart/form-data
```

Incorrect assumptions about content types can sometimes contribute to security vulnerabilities.

---

# 16. CORS and Origin

Browsers send an `Origin` header for relevant cross-origin requests.

Example:

```http
Origin: https://app.example.com
```

The server may respond:

```http
Access-Control-Allow-Origin: https://app.example.com
```

CORS controls browser behavior around cross-origin requests.

It is **not authentication**.

This becomes important in:

```text
05-CORS.md
```

---

# 17. Industry Example — Login Request

A React frontend might send:

```http
POST /api/login HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "********"
}
```

Server:

```text
Validate input
     ↓
Find user
     ↓
Verify password
     ↓
Create session/token
     ↓
Return response
```

Response might be:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "message": "Login successful"
}
```

The exact authentication architecture depends on the application.

---

# 18. Industry Example — Broken Authorization

Request:

```http
GET /api/orders/1002
Authorization: Bearer <User-A-token>
```

The attacker changes:

```text
1002 → 1003
```

If the server returns another user's order without checking ownership:

```text
Attacker
   ↓
Modified HTTP request
   ↓
API
   ↓
Unauthorized data
```

This is a server-side authorization failure.

HTTP itself is not the vulnerability.

The application incorrectly trusted the resource identifier.

---

# 19. HTTP Security Testing Mindset

When inspecting an HTTP request, ask:

```text
1. Who is making this request?
2. How is authentication provided?
3. What authorization check occurs?
4. Which inputs can I control?
5. Does the server validate them?
6. Is sensitive information exposed?
7. Can the request be replayed?
8. Can parameters be changed?
9. Are security headers configured correctly?
```

This mindset will help with almost every vulnerability in this section.

---

# 20. Small Hands-On Lab

Open Chrome:

```text
F12
→ Network
```

Visit a website you own or are authorized to test.

Click a request and inspect:

```text
Headers
Payload
Response
Cookies
Timing
Status Code
```

For example:

```text
Request:
GET /api/products

Response:
200 OK

Content-Type:
application/json
```

Try changing your understanding of the request:

```text
Method
Path
Query parameters
Headers
Body
```

This is the foundation for using tools such as Burp Suite later.

---

# 21. Using curl

Simple GET:

```bash
curl https://example.com
```

Show response headers:

```bash
curl -I https://example.com
```

Send JSON:

```bash
curl -X POST https://example.com/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"test"}'
```

Breakdown:

```text
-X
→ HTTP method

-H
→ Header

-d
→ Request body
```

Only test endpoints you own or are explicitly authorized to assess.

---

# 22. SOC Relevance

HTTP logs are extremely valuable during web investigations.

A SOC analyst may examine:

```text
Source IP
Destination
URL
HTTP method
Status code
User-agent
Timestamp
Response size
Authentication events
```

Example suspicious pattern:

```text
Many requests
      ↓
Different URLs
      ↓
Repeated 404s
      ↓
Then successful admin request
```

This could indicate reconnaissance followed by attempted access.

A single `404` is normal.

The **sequence and context** matter.

---

# 23. Interview Questions

### Q1. What are the main parts of an HTTP request?

```text
Method
URL/path
Headers
Body
```

### Q2. What are the main parts of an HTTP response?

```text
Status code
Headers
Body
```

### Q3. Difference between 401 and 403?

```text
401 → Authentication problem
403 → Authorization/access denied
```

### Q4. HTTP vs HTTPS?

HTTPS is HTTP protected by TLS.

### Q5. What is Content-Type?

It indicates the media type of the request or response body.

### Q6. Can HTTP headers be trusted?

Not automatically. Client-controlled headers can often be modified.

### Q7. What is CORS?

A browser security mechanism controlling certain cross-origin requests and access to their responses.

---

# 24. Quick Cheat Sheet

```text
HTTP
→ Client-server communication

Request
→ Method + URL + Headers + Body

Response
→ Status + Headers + Body

GET
→ Retrieve

POST
→ Submit/create

PUT
→ Replace

PATCH
→ Partial update

DELETE
→ Delete

401
→ Authentication problem

403
→ Authorization denied

4xx
→ Client/request-side errors

5xx
→ Server-side errors

HTTPS
→ HTTP + TLS

Cookie
→ Client-stored state sent with requests

Authorization
→ Authentication credentials/token

Origin
→ Origin of a browser request
```

## Core Mental Model

```text
                 HTTP
                  |
        ┌─────────┴─────────┐
        ↓                   ↓
     REQUEST             RESPONSE
        |                   |
   Method/URL          Status Code
   Headers             Headers
   Body                Body
        |                   |
        └─────────┬─────────┘
                  ↓
            Web Application
                  ↓
       Authentication / Authorization
                  ↓
              Data / API
```

**Next:** `03-Cookies-Sessions.md`