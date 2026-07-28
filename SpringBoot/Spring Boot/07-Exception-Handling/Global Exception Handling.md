# Global Exception Handling

## What is Global Exception Handling?

**Global Exception Handling** is the process of handling exceptions from **all controllers** in a single centralized class.

In Spring Boot, this is usually implemented using:

- `@RestControllerAdvice`
- `@ExceptionHandler`

Instead of writing exception handling logic in every controller, we write it once and reuse it across the entire application.

> **In simple words:**
>
> Global Exception Handling means **one place to handle all application exceptions**.

---

# Why Do We Need Global Exception Handling?

Suppose your application has:

- UserController
- ProductController
- OrderController
- PaymentController
- AuthController

Without Global Exception Handling

```
UserController

↓

Exception Handling
```

```
ProductController

↓

Exception Handling
```

```
OrderController

↓

Exception Handling
```

Problems:

- Duplicate code
- Hard to maintain
- Inconsistent error responses

---

With Global Exception Handling

```
UserController

        ↘

ProductController

         → Global Exception Handler

OrderController

        ↗

PaymentController
```

One handler serves the entire application.

---

# How Global Exception Handling Works

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

@RestControllerAdvice

↓

@ExceptionHandler

↓

JSON Response

↓

Client
```

---

# Creating Global Exception Handler

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

}
```

`@RestControllerAdvice` automatically applies to every REST controller.

---

# Handling RuntimeException

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<String> handleRuntimeException(

            RuntimeException ex

    ) {

        return ResponseEntity

                .status(HttpStatus.BAD_REQUEST)

                .body(ex.getMessage());

    }

}
```

---

# Example Controller

```java
@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping("/{id}")
    public String getUser(
            @PathVariable Long id) {

        throw new RuntimeException(
                "User Not Found");

    }

}
```

Response

```json
User Not Found
```

Status

```
400 Bad Request
```

---

# Handling Multiple Exceptions

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(
            NullPointerException.class
    )
    public ResponseEntity<String> handleNullPointer(

            NullPointerException ex

    ) {

        return ResponseEntity

                .status(HttpStatus.INTERNAL_SERVER_ERROR)

                .body(ex.getMessage());

    }

    @ExceptionHandler(
            IllegalArgumentException.class
    )
    public ResponseEntity<String> handleIllegalArgument(

            IllegalArgumentException ex

    ) {

        return ResponseEntity

                .badRequest()

                .body(ex.getMessage());

    }

}
```

---

# Handling Validation Exceptions

When validation fails:

```java
@PostMapping
public void save(

        @Valid
        @RequestBody
        UserDTO dto

) {

}
```

Spring throws

```
MethodArgumentNotValidException
```

Global Handler

```java
@ExceptionHandler(
        MethodArgumentNotValidException.class
)
public ResponseEntity<String> handleValidation(

        MethodArgumentNotValidException ex

) {

    return ResponseEntity

            .badRequest()

            .body("Validation Failed");

}
```

---

# Returning a Custom Error Response

Create ErrorResponse DTO

```java
public class ErrorResponse {

    private LocalDateTime timestamp;

    private int status;

    private String error;

    private String message;

    private String path;

}
```

---

Global Handler

```java
@ExceptionHandler(RuntimeException.class)
public ResponseEntity<ErrorResponse> handleException(

        RuntimeException ex,
        HttpServletRequest request

) {

    ErrorResponse error = new ErrorResponse();

    error.setTimestamp(LocalDateTime.now());

    error.setStatus(404);

    error.setError("Not Found");

    error.setMessage(ex.getMessage());

    error.setPath(request.getRequestURI());

    return ResponseEntity

            .status(HttpStatus.NOT_FOUND)

            .body(error);

}
```

---

# Response

```json
{
    "timestamp": "2026-07-28T12:30:10",
    "status": 404,
    "error": "Not Found",
    "message": "User Not Found",
    "path": "/users/5"
}
```

---

# Request Processing Flow

```
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

@RestControllerAdvice

↓

@ExceptionHandler

↓

ErrorResponse

↓

HTTP Response
```

---

# Handling Custom Exceptions

Custom Exception

```java
public class UserNotFoundException
        extends RuntimeException {

    public UserNotFoundException(
            String message) {

        super(message);

    }

}
```

Handler

```java
@ExceptionHandler(
        UserNotFoundException.class
)
public ResponseEntity<String> handleUserNotFound(

        UserNotFoundException ex

) {

    return ResponseEntity

            .status(HttpStatus.NOT_FOUND)

            .body(ex.getMessage());

}
```

---

# Typical Exceptions Handled Globally

| Exception | HTTP Status |
|-----------|-------------|
| `MethodArgumentNotValidException` | 400 |
| `IllegalArgumentException` | 400 |
| `UserNotFoundException` | 404 |
| `AccessDeniedException` | 403 |
| `DataIntegrityViolationException` | 409 |
| `Exception` | 500 |

---

# Exception Hierarchy

```
Exception

├── RuntimeException

│      ├── UserNotFoundException

│      ├── IllegalArgumentException

│      └── NullPointerException

└── Checked Exceptions
```

Handle specific exceptions before generic ones.

---

# Global Exception Handling vs Local Exception Handling

| Global | Local |
|---------|-------|
| Handles all controllers | Handles one controller |
| Uses `@RestControllerAdvice` | Uses `@ExceptionHandler` inside controller |
| Centralized | Controller-specific |
| Easy to maintain | Duplicate code possible |

---

# Real-World Example

## Banking Application

```
Transfer Money

↓

Account Not Found

↓

AccountNotFoundException

↓

Global Exception Handler

↓

404 Response
```

---

## E-Commerce Application

```
Place Order

↓

Product Out of Stock

↓

ProductException

↓

Global Handler

↓

409 Conflict
```

---

## Student Management System

```
Find Student

↓

Student Not Found

↓

StudentNotFoundException

↓

404 Response
```

---

# Advantages

- Centralized exception handling
- Consistent API responses
- Reduces duplicate code
- Easy to maintain
- Improves API design
- Better debugging and logging

---

# Best Practices

- Prefer `@RestControllerAdvice` for REST APIs.
- Return a consistent error response object.
- Handle specific exceptions before generic ones.
- Map exceptions to appropriate HTTP status codes.
- Log exceptions for debugging.
- Avoid exposing stack traces to API clients.

---

# Interview Questions

### 1. What is Global Exception Handling?

Global Exception Handling is a centralized mechanism for handling exceptions from all controllers in a Spring Boot application.

---

### 2. Which annotation is commonly used for Global Exception Handling?

```java
@RestControllerAdvice
```

---

### 3. Which annotation handles individual exceptions inside the global handler?

```java
@ExceptionHandler
```

---

### 4. Why is `@RestControllerAdvice` preferred for REST APIs?

Because it combines `@ControllerAdvice` and `@ResponseBody`, automatically returning JSON responses.

---

### 5. Why should we return a custom error response?

To provide consistent, meaningful, and client-friendly error messages with useful details like timestamp, status, message, and request path.

---

# Quick Revision

- Global Exception Handling manages exceptions for the entire application.
- Use `@RestControllerAdvice` to create a centralized exception handler.
- Use `@ExceptionHandler` methods for specific exception types.
- Return consistent error response objects using `ResponseEntity`.
- Handle validation, business, and runtime exceptions globally.
- Map exceptions to appropriate HTTP status codes such as **400**, **404**, **409**, and **500**.