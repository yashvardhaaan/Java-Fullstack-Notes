# `@ControllerAdvice` Annotation

## What is `@ControllerAdvice`?

`@ControllerAdvice` is a Spring Boot annotation used to provide **centralized exception handling** across multiple controllers.

Instead of writing `@ExceptionHandler` methods inside every controller, we can place them in a single class annotated with `@ControllerAdvice`.

> **In simple words:**
>
> `@ControllerAdvice` acts as a **global advisor** for all controllers.

---

# Why Do We Need `@ControllerAdvice`?

Suppose your application has:

- UserController
- ProductController
- OrderController
- PaymentController

If every controller has its own exception handler:

```
UserController

↓

@ExceptionHandler
```

```
ProductController

↓

@ExceptionHandler
```

```
OrderController

↓

@ExceptionHandler
```

This results in:

- Duplicate code
- Difficult maintenance
- Inconsistent error responses

Instead, we use one centralized class.

---

# Without `@ControllerAdvice`

```
UserController

↓

@ExceptionHandler
```

```
ProductController

↓

@ExceptionHandler
```

```
OrderController

↓

@ExceptionHandler
```

Every controller contains repeated exception handling code.

---

# With `@ControllerAdvice`

```
UserController

        ↘

ProductController

        → ControllerAdvice

OrderController

        ↗

PaymentController
```

All controllers share the same exception handling logic.

---

# How `@ControllerAdvice` Works

```
Client

↓

Controller

↓

Exception

↓

@ControllerAdvice

↓

@ExceptionHandler

↓

Response

↓

Client
```

---

# Basic Example

```java
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<String> handleException(

            RuntimeException ex

    ) {

        return ResponseEntity

                .status(HttpStatus.NOT_FOUND)

                .body(ex.getMessage());

    }

}
```

Now every controller automatically uses this handler.

---

# Example Controllers

UserController

```java
@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping("/{id}")
    public String getUser(
            @PathVariable Long id) {

        throw new RuntimeException("User Not Found");

    }

}
```

---

ProductController

```java
@RestController
@RequestMapping("/products")
public class ProductController {

    @GetMapping("/{id}")
    public String getProduct(
            @PathVariable Long id) {

        throw new RuntimeException("Product Not Found");

    }

}
```

Both controllers use the same exception handler.

---

# Response

Request

```
GET /users/10
```

Response

```json
{
    "status": 404,
    "message": "User Not Found"
}
```

---

Request

```
GET /products/20
```

Response

```json
{
    "status": 404,
    "message": "Product Not Found"
}
```

---

# Handling Multiple Exceptions

```java
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(
            NullPointerException.class
    )
    public String handleNullPointer() {

        return "Null Pointer Error";

    }

    @ExceptionHandler(
            IllegalArgumentException.class
    )
    public String handleIllegalArgument() {

        return "Invalid Argument";

    }

}
```

Each method handles a different exception type.

---

# Handling Validation Exceptions

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

Whenever `@Valid` validation fails, this method is executed.

---

# Returning Custom Error Object

ErrorResponse

```java
public class ErrorResponse {

    private int status;

    private String message;

}
```

Handler

```java
@ExceptionHandler(RuntimeException.class)
public ResponseEntity<ErrorResponse> handle(

        RuntimeException ex

) {

    ErrorResponse error = new ErrorResponse();

    error.setStatus(404);

    error.setMessage(ex.getMessage());

    return ResponseEntity

            .status(HttpStatus.NOT_FOUND)

            .body(error);

}
```

Response

```json
{
    "status": 404,
    "message": "User Not Found"
}
```

---

# Request Flow

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

@ControllerAdvice

↓

@ExceptionHandler

↓

HTTP Response
```

---

# `@ControllerAdvice` vs `@RestControllerAdvice`

| `@ControllerAdvice` | `@RestControllerAdvice` |
|---------------------|-------------------------|
| Used for Spring MVC applications | Used for REST APIs |
| May require `@ResponseBody` | Automatically adds `@ResponseBody` |
| Returns View or Response | Returns JSON Response |

> **Note:** For REST APIs, `@RestControllerAdvice` is generally preferred.

---

# `@ExceptionHandler` vs `@ControllerAdvice`

| `@ExceptionHandler` | `@ControllerAdvice` |
|---------------------|---------------------|
| Handles specific exceptions | Centralizes exception handling |
| Usually inside one controller | Separate class |
| Local scope | Global scope |
| Suitable for small projects | Suitable for medium and large projects |

---

# Real-World Example

### Banking Application

```
AccountController

↓

RuntimeException

↓

@ControllerAdvice

↓

404 Response
```

---

### E-Commerce Application

```
ProductController

↓

Product Not Found

↓

@ControllerAdvice

↓

404 Response
```

---

### Student Management System

```
StudentController

↓

Student Not Found

↓

@ControllerAdvice

↓

404 Response
```

---

# Advantages

- Centralized exception handling
- Reduces duplicate code
- Easy to maintain
- Consistent error responses
- Reusable across all controllers
- Improves API design

---

# Best Practices

- Use one global exception handler for the entire application.
- Return consistent error response objects.
- Handle specific exceptions before generic exceptions.
- Use `ResponseEntity` to return proper HTTP status codes.
- For REST APIs, prefer `@RestControllerAdvice`.

---

# Interview Questions

### 1. What is `@ControllerAdvice`?

`@ControllerAdvice` is used to provide centralized exception handling across multiple controllers.

---

### 2. What is the difference between `@ExceptionHandler` and `@ControllerAdvice`?

- `@ExceptionHandler` handles exceptions for a specific controller.
- `@ControllerAdvice` provides centralized exception handling for all controllers.

---

### 3. Can one `@ControllerAdvice` class handle multiple exceptions?

Yes.

Create multiple `@ExceptionHandler` methods inside the same class.

---

### 4. What is the difference between `@ControllerAdvice` and `@RestControllerAdvice`?

- `@ControllerAdvice` is used for Spring MVC applications.
- `@RestControllerAdvice` combines `@ControllerAdvice` and `@ResponseBody`, making it ideal for REST APIs.

---

### 5. Why is `@ControllerAdvice` preferred in large applications?

Because it centralizes exception handling, reduces duplicate code, and ensures consistent error responses.

---

# Quick Revision

- `@ControllerAdvice` provides centralized exception handling.
- It works across all controllers in the application.
- It is commonly used with `@ExceptionHandler`.
- It reduces code duplication and improves maintainability.
- `@RestControllerAdvice` is preferred for REST APIs because it automatically returns JSON responses.
- Return consistent error objects using `ResponseEntity`.