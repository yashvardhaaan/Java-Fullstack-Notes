# HTTP Status Codes

## What are HTTP Status Codes?

**HTTP Status Codes** are **3-digit numbers** returned by the server to indicate the result of an HTTP request.

They tell the client whether the request was:

- Successful
- Failed
- Unauthorized
- Resource Not Found
- Server Error

> **In simple words:**
>
> HTTP Status Codes are the server's way of saying:
> **"Here's what happened with your request."**

---

# Why Do We Need HTTP Status Codes?

Suppose a client requests:

```
GET /employees/101
```

The server should clearly indicate whether:

- The employee exists
- The employee doesn't exist
- The request is invalid
- The server encountered an error

Instead of sending only data, the server sends an HTTP Status Code.

---

# Structure of an HTTP Response

```
HTTP Response

↓

Status Code

↓

Headers

↓

Response Body
```

Example:

```
HTTP/1.1 200 OK

Content-Type: application/json

{
   "id":101,
   "name":"John"
}
```

---

# Categories of HTTP Status Codes

| Range | Meaning |
|--------|----------|
| 1xx | Informational |
| 2xx | Success |
| 3xx | Redirection |
| 4xx | Client Error |
| 5xx | Server Error |

---

# 1xx - Informational

The request has been received and is being processed.

Example:

```
100 Continue
```

Rarely used in REST APIs.

---

# 2xx - Success

The request was processed successfully.

## 200 OK

Used when data is successfully retrieved.

Example:

```
GET /employees
```

Response:

```
200 OK
```

---

## 201 Created

Used when a new resource is created.

Example:

```
POST /employees
```

Response:

```
201 Created
```

---

## 202 Accepted

The request has been accepted but processing will happen later.

Example:

```
202 Accepted
```

---

## 204 No Content

Request succeeded but there is no response body.

Example:

```
DELETE /employees/101
```

Response:

```
204 No Content
```

---

# 3xx - Redirection

The client must perform another action to complete the request.

## 301 Moved Permanently

The resource has permanently moved.

---

## 302 Found

The resource is temporarily available at another location.

---

## 304 Not Modified

The cached version is still valid.

Commonly used with browser caching.

---

# 4xx - Client Errors

The problem is with the client's request.

---

## 400 Bad Request

The request contains invalid data.

Example:

```json
{
   "name": ""
}
```

Response:

```
400 Bad Request
```

---

## 401 Unauthorized

Authentication is required.

Example:

```
Missing JWT Token
```

Response:

```
401 Unauthorized
```

---

## 403 Forbidden

The user is authenticated but does not have permission.

Example:

```
Admin API

↓

Normal User
```

Response:

```
403 Forbidden
```

---

## 404 Not Found

The requested resource does not exist.

Example:

```
GET /employees/999
```

Response:

```
404 Not Found
```

---

## 405 Method Not Allowed

The HTTP method is not supported.

Example:

```
POST /employees

Only GET Allowed
```

---

## 409 Conflict

The request conflicts with the current state.

Example:

Creating a user with an email that already exists.

---

# 5xx - Server Errors

The request was valid, but the server failed to process it.

---

## 500 Internal Server Error

Unexpected server error.

Example:

```
NullPointerException

Database Failure

Unhandled Exception
```

Response:

```
500 Internal Server Error
```

---

## 502 Bad Gateway

A gateway or proxy received an invalid response from another server.

---

## 503 Service Unavailable

The server is temporarily unavailable.

Example:

- Server Maintenance
- High Traffic

---

## 504 Gateway Timeout

The server did not receive a response in time from another service.

Common in microservices.

---

# Common Status Codes in Spring Boot

| Operation | Status Code |
|-----------|-------------|
| GET Success | 200 OK |
| POST Success | 201 Created |
| PUT Success | 200 OK |
| PATCH Success | 200 OK |
| DELETE Success | 204 No Content |
| Invalid Input | 400 Bad Request |
| Unauthorized | 401 Unauthorized |
| Forbidden | 403 Forbidden |
| Resource Not Found | 404 Not Found |
| Server Error | 500 Internal Server Error |

---

# Returning Status Codes in Spring Boot

Using `ResponseEntity`:

```java
@GetMapping("/{id}")
public ResponseEntity<Employee> getEmployee(@PathVariable Long id) {

    Employee employee = service.findById(id);

    return ResponseEntity.ok(employee);

}
```

Create a resource:

```java
@PostMapping
public ResponseEntity<Employee> createEmployee(
        @RequestBody Employee employee) {

    Employee saved = service.save(employee);

    return ResponseEntity.status(201).body(saved);

}
```

Delete a resource:

```java
@DeleteMapping("/{id}")
public ResponseEntity<Void> deleteEmployee(
        @PathVariable Long id) {

    service.delete(id);

    return ResponseEntity.noContent().build();

}
```

---

# How HTTP Status Codes Work

```
Client Sends Request
        │
        ▼
Spring Boot Processes Request
        │
        ▼
Return HTTP Status Code
        │
        ▼
Client Understands Result
```

---

# Real-World Example

Suppose you order food.

```
POST /orders
```

Restaurant accepts the order.

```
201 Created
```

---

Check your order.

```
GET /orders/101
```

Order exists.

```
200 OK
```

---

Check a non-existing order.

```
GET /orders/999
```

```
404 Not Found
```

---

# Best Practices

- Use the correct status code for every response.
- Never return `200 OK` for an error.
- Return `201 Created` after creating a resource.
- Return `204 No Content` after successful deletion when no body is needed.
- Return meaningful error messages along with 4xx and 5xx responses.

---

# Interview Questions

### 1. What are HTTP Status Codes?

HTTP Status Codes are 3-digit numbers returned by the server to indicate the result of an HTTP request.

---

### 2. What is the difference between 401 and 403?

- **401 Unauthorized** → Authentication is required or has failed.
- **403 Forbidden** → Authentication succeeded, but the user does not have permission.

---

### 3. What is the difference between 200 and 201?

- **200 OK** → Request processed successfully.
- **201 Created** → A new resource has been created successfully.

---

### 4. When should you use 204 No Content?

After a successful operation (such as DELETE) when there is no response body to return.

---

### 5. What does 404 Not Found mean?

The requested resource does not exist on the server.

---

### 6. What does 500 Internal Server Error indicate?

An unexpected error occurred on the server while processing the request.

---

# Quick Revision

- HTTP Status Codes indicate the result of an HTTP request.
- Categories:
  - **1xx** → Informational
  - **2xx** → Success
  - **3xx** → Redirection
  - **4xx** → Client Errors
  - **5xx** → Server Errors
- Common codes:
  - **200** → OK
  - **201** → Created
  - **204** → No Content
  - **400** → Bad Request
  - **401** → Unauthorized
  - **403** → Forbidden
  - **404** → Not Found
  - **500** → Internal Server Error
- Spring Boot commonly returns status codes using `ResponseEntity`.