# ResponseEntity

## What is `ResponseEntity`?

`ResponseEntity` is a Spring class used to **return the complete HTTP response** from a controller.

With `ResponseEntity`, you can control:

- HTTP Status Code
- Response Body
- HTTP Headers

> **In simple words:**
>
> `ResponseEntity` lets you decide **what data to return, which status code to send, and what headers to include**.

---

# Why Do We Need `ResponseEntity`?

Without `ResponseEntity`, Spring only returns the response body.

Example:

```java
@GetMapping("/hello")
public String hello() {
    return "Hello";
}
```

Response:

```
Hello
```

Status Code:

```
200 OK
```

But what if you want to return:

- **201 Created**
- **404 Not Found**
- **400 Bad Request**
- Custom Headers

That's where `ResponseEntity` is used.

---

# Syntax

```java
ResponseEntity<T>
```

Example:

```java
@GetMapping("/hello")
public ResponseEntity<String> hello() {

    return ResponseEntity.ok("Hello Spring Boot");

}
```

---

# How `ResponseEntity` Works

```
Client

↓

HTTP Request

↓

Controller

↓

ResponseEntity

↓

Status + Headers + Body

↓

Client
```

---

# Returning a Simple Response

```java
@GetMapping("/hello")
public ResponseEntity<String> hello() {

    return ResponseEntity.ok("Hello Spring Boot");

}
```

Response

```
Status : 200 OK

Body : Hello Spring Boot
```

---

# Returning an Object

```java
@GetMapping("/employees/{id}")
public ResponseEntity<Employee> getEmployee(
        @PathVariable Long id) {

    Employee employee = service.findById(id);

    return ResponseEntity.ok(employee);

}
```

Response

```json
{
    "id":101,
    "name":"John",
    "department":"IT"
}
```

---

# Returning 201 Created

```java
@PostMapping("/employees")
public ResponseEntity<Employee> createEmployee(
        @RequestBody Employee employee) {

    Employee saved = service.save(employee);

    return ResponseEntity
            .status(HttpStatus.CREATED)
            .body(saved);

}
```

Status

```
201 Created
```

---

# Returning 404 Not Found

```java
@GetMapping("/employees/{id}")
public ResponseEntity<Employee> getEmployee(
        @PathVariable Long id) {

    Employee employee = service.findById(id);

    if (employee == null) {
        return ResponseEntity.notFound().build();
    }

    return ResponseEntity.ok(employee);

}
```

Status

```
404 Not Found
```

---

# Returning 400 Bad Request

```java
@PostMapping("/employees")
public ResponseEntity<String> saveEmployee(
        @RequestBody Employee employee) {

    if (employee.getName() == null) {

        return ResponseEntity
                .badRequest()
                .body("Name is required");

    }

    return ResponseEntity.ok("Saved");

}
```

---

# Returning 204 No Content

```java
@DeleteMapping("/{id}")
public ResponseEntity<Void> deleteEmployee(
        @PathVariable Long id) {

    service.delete(id);

    return ResponseEntity.noContent().build();

}
```

Status

```
204 No Content
```

No response body is returned.

---

# Adding HTTP Headers

```java
@GetMapping("/download")
public ResponseEntity<String> download() {

    HttpHeaders headers = new HttpHeaders();

    headers.add("App-Version", "1.0");

    return ResponseEntity
            .ok()
            .headers(headers)
            .body("Download Started");

}
```

Response

```
Status : 200 OK

Header :
App-Version : 1.0

Body :
Download Started
```

---

# Common Factory Methods

| Method | Description |
|----------|-------------|
| `ok()` | Returns 200 OK |
| `status()` | Returns a custom status |
| `created()` | Returns 201 Created |
| `accepted()` | Returns 202 Accepted |
| `noContent()` | Returns 204 No Content |
| `badRequest()` | Returns 400 Bad Request |
| `notFound()` | Returns 404 Not Found |
| `internalServerError()` | Returns 500 Internal Server Error |

---

# Request Flow

```
Client

↓

Request

↓

Controller

↓

ResponseEntity

↓

Status Code

↓

Headers

↓

Body

↓

Client
```

---

# ResponseEntity vs Returning Object

## Returning Object

```java
@GetMapping
public Employee getEmployee() {

    return employee;

}
```

Spring automatically returns:

```
200 OK
```

You cannot easily change the status code.

---

## Using ResponseEntity

```java
@GetMapping
public ResponseEntity<Employee> getEmployee() {

    return ResponseEntity.ok(employee);

}
```

You have full control over:

- Status Code
- Headers
- Response Body

---

# ResponseEntity vs @ResponseBody

| `ResponseEntity` | `@ResponseBody` |
|------------------|-----------------|
| Controls entire HTTP response | Returns only the response body |
| Can set status codes | Uses default status code |
| Can add headers | Cannot add headers easily |

---

# Real-World Example

### Banking Application

```
POST /accounts
```

If successful:

```
201 Created
```

Return:

```java
ResponseEntity.status(HttpStatus.CREATED)
              .body(account);
```

---

### E-Commerce Application

```
GET /products/100
```

If product exists:

```
200 OK
```

If not:

```
404 Not Found
```

---

# Advantages

- Full control over HTTP responses
- Easy to return different status codes
- Supports custom headers
- Makes APIs more RESTful
- Improves error handling

---

# Best Practices

- Use `ResponseEntity` in REST APIs.
- Return meaningful HTTP status codes.
- Use `ResponseEntity<Void>` when no response body is needed.
- Return proper error messages with 4xx and 5xx responses.
- Use global exception handling (`@ControllerAdvice`) for consistent error responses.

---

# Interview Questions

### 1. What is `ResponseEntity`?

`ResponseEntity` is a Spring class that represents the complete HTTP response, including the body, status code, and headers.

---

### 2. Why use `ResponseEntity`?

To control:

- HTTP Status Code
- Response Body
- HTTP Headers

---

### 3. What is the difference between returning an object and `ResponseEntity`?

Returning an object uses the default HTTP status, while `ResponseEntity` allows full control over the response.

---

### 4. How do you return `404 Not Found`?

```java
return ResponseEntity.notFound().build();
```

---

### 5. How do you return `201 Created`?

```java
return ResponseEntity
        .status(HttpStatus.CREATED)
        .body(employee);
```

---

# Quick Revision

- `ResponseEntity` represents the complete HTTP response.
- It allows you to control the **status code**, **headers**, and **response body**.
- Common methods include `ok()`, `status()`, `created()`, `badRequest()`, `notFound()`, and `noContent()`.
- It is recommended for building professional REST APIs.
- Use `ResponseEntity` whenever you need more than just returning data.