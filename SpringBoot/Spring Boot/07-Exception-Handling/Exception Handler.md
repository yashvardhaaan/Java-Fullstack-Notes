# `@ExceptionHandler` Annotation

## What is `@ExceptionHandler`?

`@ExceptionHandler` is a Spring Boot annotation used to **handle specific exceptions** thrown by a controller.

Instead of allowing Spring Boot to return a generic error, we can catch the exception and return a custom response.

> **In simple words:**
>
> `@ExceptionHandler` catches an exception and returns a meaningful response to the client.

---

# Why Do We Need `@ExceptionHandler`?

Suppose a client requests:

```
GET /users/100
```

But user **100** does not exist.

Without `@ExceptionHandler`

```
500 Internal Server Error

NoSuchElementException
```

Not user-friendly.

With `@ExceptionHandler`

```json
{
    "status": 404,
    "message": "User Not Found"
}
```

The API returns a meaningful response.

---

# How `@ExceptionHandler` Works

```
Client

↓

Controller

↓

Exception Occurs

↓

@ExceptionHandler

↓

Custom Response

↓

Client
```

---

# Basic Example

```java
@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping("/{id}")
    public String getUser(
            @PathVariable Long id) {

        throw new RuntimeException("User Not Found");

    }

    @ExceptionHandler(RuntimeException.class)
    public String handleException(
            RuntimeException ex) {

        return ex.getMessage();

    }

}
```

Output

```
User Not Found
```

---

# Example with `ResponseEntity`

```java
@ExceptionHandler(RuntimeException.class)
public ResponseEntity<String> handleException(
        RuntimeException ex) {

    return ResponseEntity

            .status(HttpStatus.NOT_FOUND)

            .body(ex.getMessage());

}
```

Response

```
404 Not Found
```

Body

```text
User Not Found
```

---

# Handling Multiple Exceptions

```java
@ExceptionHandler({
        IllegalArgumentException.class,
        NullPointerException.class
})
public String handleExceptions(
        Exception ex) {

    return ex.getMessage();

}
```

One method handles multiple exception types.

---

# Handling Validation Exceptions

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

Spring throws

```
MethodArgumentNotValidException
```

Handle it

```java
@ExceptionHandler(
    MethodArgumentNotValidException.class
)
public String handleValidation(

        MethodArgumentNotValidException ex

) {

    return "Validation Failed";

}
```

---

# Returning Custom Error Object

Create ErrorResponse

```java
public class ErrorResponse {

    private int status;

    private String message;

}
```

Handler

```java
@ExceptionHandler(RuntimeException.class)
public ResponseEntity<ErrorResponse> handleException(

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

Exception

↓

@ExceptionHandler

↓

ResponseEntity

↓

HTTP Response
```

---

# Supported Exception Types

```java
@ExceptionHandler(
        NullPointerException.class
)
```

```java
@ExceptionHandler(
        IllegalArgumentException.class
)
```

```java
@ExceptionHandler(
        MethodArgumentNotValidException.class
)
```

```java
@ExceptionHandler(
        RuntimeException.class
)
```

```java
@ExceptionHandler(
        Exception.class
)
```

---

# Local Exception Handling

`@ExceptionHandler` inside a controller handles exceptions **only for that controller**.

```
UserController

↓

@ExceptionHandler

↓

Handles UserController Exceptions Only
```

If another controller throws the same exception, it will **not** be handled here.

---

# Local vs Global Exception Handling

| Local (`@ExceptionHandler`) | Global (`@ControllerAdvice`) |
|-----------------------------|------------------------------|
| Works for one controller | Works for all controllers |
| Suitable for small applications | Suitable for medium and large applications |
| Duplicate code possible | Centralized exception handling |

---

# Real-World Example

### Banking Application

```java
@GetMapping("/{id}")
public Account getAccount(Long id) {

    throw new RuntimeException(
            "Account Not Found");

}
```

Handler

```java
@ExceptionHandler(RuntimeException.class)
public ResponseEntity<String> handle(

        RuntimeException ex

) {

    return ResponseEntity

            .status(HttpStatus.NOT_FOUND)

            .body(ex.getMessage());

}
```

Response

```
404

Account Not Found
```

---

### E-Commerce Application

```
Product Not Found

↓

@ExceptionHandler

↓

404 Response
```

---

### Student Management System

```
Student Not Found

↓

@ExceptionHandler

↓

404 Response
```

---

# Advantages

- Handles exceptions gracefully
- Returns meaningful responses
- Prevents application crashes
- Improves API readability
- Easy to implement
- Supports multiple exception types

---

# Best Practices

- Use `ResponseEntity` to return proper HTTP status codes.
- Handle only related exceptions inside the controller.
- Keep handler methods simple.
- Use `@ControllerAdvice` for application-wide exception handling.
- Return a consistent error response structure.

---

# Interview Questions

### 1. What is `@ExceptionHandler`?

`@ExceptionHandler` is used to catch and handle specific exceptions thrown by a controller.

---

### 2. Where can `@ExceptionHandler` be used?

Inside a controller class or inside a class annotated with `@ControllerAdvice` or `@RestControllerAdvice`.

---

### 3. Does `@ExceptionHandler` handle exceptions from all controllers?

No.

When placed inside a controller, it only handles exceptions from that controller.

---

### 4. How do you return an HTTP status code from an `@ExceptionHandler`?

Using `ResponseEntity`.

```java
return ResponseEntity
        .status(HttpStatus.NOT_FOUND)
        .body("User Not Found");
```

---

### 5. Which exception is thrown when Bean Validation fails?

```text
MethodArgumentNotValidException
```

---

# Quick Revision

- `@ExceptionHandler` catches exceptions thrown by a controller.
- It returns custom error responses instead of generic errors.
- One method can handle one or multiple exception types.
- Use `ResponseEntity` to return appropriate HTTP status codes.
- Inside a controller, it provides **local exception handling** only.
- For application-wide handling, use `@ControllerAdvice` or `@RestControllerAdvice`.