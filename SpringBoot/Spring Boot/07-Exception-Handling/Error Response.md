# Error Response

## What is an Error Response?

An **Error Response** is the structured JSON object returned by a Spring Boot application whenever a request fails.

Instead of returning a confusing stack trace or generic error message, we return a well-defined JSON object that helps both the client and the developer understand what went wrong.

> **In simple words:**
>
> An Error Response is a standard format used to send error details back to the client.

---

# Why Do We Need an Error Response?

Suppose a client requests:

```
GET /users/100
```

But the user does not exist.

Without a proper error response:

```
500 Internal Server Error
```

The client has no idea what actually happened.

With a proper error response:

```json
{
    "timestamp": "2026-07-28T14:30:15",
    "status": 404,
    "error": "Not Found",
    "message": "User Not Found",
    "path": "/users/100"
}
```

The client immediately understands the problem.

---

# Why Standardize Error Responses?

A standard error response provides:

- Consistent API responses
- Easy debugging
- Better frontend integration
- Better user experience
- Easier API documentation

---

# Typical Error Response

```json
{
    "timestamp": "2026-07-28T14:30:15",
    "status": 404,
    "error": "Not Found",
    "message": "User Not Found",
    "path": "/users/100"
}
```

---

# Meaning of Each Field

| Field | Description |
|--------|-------------|
| `timestamp` | Time when the error occurred |
| `status` | HTTP status code |
| `error` | HTTP error name |
| `message` | Detailed error message |
| `path` | Requested API endpoint |

---

# Error Response Flow

```
Client

↓

HTTP Request

↓

Controller

↓

Service

↓

Repository

↓

Exception

↓

Global Exception Handler

↓

ErrorResponse Object

↓

JSON Response

↓

Client
```

---

# Creating ErrorResponse Class

```java
public class ErrorResponse {

    private LocalDateTime timestamp;

    private int status;

    private String error;

    private String message;

    private String path;

}
```

Using Lombok

```java
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ErrorResponse {

    private LocalDateTime timestamp;

    private int status;

    private String error;

    private String message;

    private String path;

}
```

---

# Returning Error Response

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(
            UserNotFoundException.class
    )
    public ResponseEntity<ErrorResponse> handleUserNotFound(

            UserNotFoundException ex,

            HttpServletRequest request

    ) {

        ErrorResponse error = ErrorResponse.builder()

                .timestamp(LocalDateTime.now())

                .status(HttpStatus.NOT_FOUND.value())

                .error(HttpStatus.NOT_FOUND.getReasonPhrase())

                .message(ex.getMessage())

                .path(request.getRequestURI())

                .build();

        return ResponseEntity

                .status(HttpStatus.NOT_FOUND)

                .body(error);

    }

}
```

---

# Response

```json
{
    "timestamp": "2026-07-28T14:30:15",
    "status": 404,
    "error": "Not Found",
    "message": "User Not Found",
    "path": "/users/10"
}
```

---

# Validation Error Response

When validation fails:

```java
@PostMapping
public void create(

        @Valid
        @RequestBody
        UserDTO dto

) {

}
```

Spring throws:

```
MethodArgumentNotValidException
```

---

# Custom Validation Response

```java
@ExceptionHandler(
        MethodArgumentNotValidException.class
)
public ResponseEntity<ErrorResponse> handleValidation(

        MethodArgumentNotValidException ex,

        HttpServletRequest request

) {

    ErrorResponse error = ErrorResponse.builder()

            .timestamp(LocalDateTime.now())

            .status(HttpStatus.BAD_REQUEST.value())

            .error("Validation Failed")

            .message("Invalid Request")

            .path(request.getRequestURI())

            .build();

    return ResponseEntity.badRequest()

            .body(error);

}
```

---

# Better Validation Response

Instead of returning only one message, collect all validation errors.

```java
@ExceptionHandler(
        MethodArgumentNotValidException.class
)
public Map<String, String> handleValidation(

        MethodArgumentNotValidException ex

) {

    Map<String, String> errors = new HashMap<>();

    ex.getBindingResult()

      .getFieldErrors()

      .forEach(error ->

          errors.put(

              error.getField(),

              error.getDefaultMessage()

          )

      );

    return errors;

}
```

Response

```json
{
    "name": "Name is required",
    "email": "Invalid email",
    "age": "Age must be at least 18"
}
```

---

# Common HTTP Error Responses

## 400 Bad Request

```json
{
    "status": 400,
    "error": "Bad Request",
    "message": "Validation Failed"
}
```

---

## 401 Unauthorized

```json
{
    "status": 401,
    "error": "Unauthorized",
    "message": "Authentication Required"
}
```

---

## 403 Forbidden

```json
{
    "status": 403,
    "error": "Forbidden",
    "message": "Access Denied"
}
```

---

## 404 Not Found

```json
{
    "status": 404,
    "error": "Not Found",
    "message": "User Not Found"
}
```

---

## 409 Conflict

```json
{
    "status": 409,
    "error": "Conflict",
    "message": "Duplicate Email"
}
```

---

## 500 Internal Server Error

```json
{
    "status": 500,
    "error": "Internal Server Error",
    "message": "Unexpected Error"
}
```

---

# Error Response Architecture

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Exception

↓

@RestControllerAdvice

↓

ErrorResponse DTO

↓

ResponseEntity

↓

JSON Response
```

---

# Request Processing Flow

```
HTTP Request

↓

Business Logic

↓

Success?

↓

Yes

↓

Normal Response

OR

No

↓

Exception

↓

Global Exception Handler

↓

ErrorResponse

↓

Client
```

---

# Real-World Example

## Banking Application

```
Transfer Money

↓

Account Not Found

↓

404 Error Response
```

---

## E-Commerce Application

```
Create Product

↓

Duplicate Product

↓

409 Conflict
```

---

## Student Management System

```
Register Student

↓

Validation Failed

↓

400 Bad Request
```

---

# Error Response vs Exception

| Exception | Error Response |
|-----------|----------------|
| Java object | JSON returned to client |
| Internal to application | Visible to API consumer |
| Thrown by application | Generated by exception handler |
| Stops normal execution | Explains what went wrong |

---

# Advantages

- Consistent API responses
- Easy frontend integration
- Better debugging
- Professional API design
- Easier maintenance
- Improves user experience

---

# Best Practices

- Return a standard error response format for every API.
- Include timestamp, status, message, and request path.
- Never expose stack traces or internal implementation details.
- Use meaningful HTTP status codes.
- Return field-level validation errors for validation failures.
- Log exceptions for troubleshooting.

---

# Interview Questions

### 1. What is an Error Response?

An Error Response is a structured JSON object returned to the client when an API request fails.

---

### 2. What fields should a standard Error Response contain?

Typical fields include:

- `timestamp`
- `status`
- `error`
- `message`
- `path`

---

### 3. Which class usually returns custom Error Responses in Spring Boot?

A class annotated with:

```java
@RestControllerAdvice
```

---

### 4. How do you return field-level validation errors?

By handling `MethodArgumentNotValidException` and extracting field errors using `BindingResult`.

---

### 5. Why should stack traces not be returned to clients?

Because they expose internal implementation details and may create security risks.

---

# Quick Revision

- Error Response is the JSON returned when an API request fails.
- Use a consistent response structure across the application.
- Common fields: `timestamp`, `status`, `error`, `message`, and `path`.
- Generate Error Responses using `@RestControllerAdvice` and `@ExceptionHandler`.
- Return field-level validation errors for invalid input.
- Never expose stack traces or sensitive information in API responses.
- Always use appropriate HTTP status codes like **400**, **404**, **409**, and **500**.