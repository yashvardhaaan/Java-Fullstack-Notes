# Custom Exceptions

## What are Custom Exceptions?

A **Custom Exception** is a user-defined exception created to represent **business-specific errors** in an application.

Instead of throwing generic exceptions like:

```java
RuntimeException
```

or

```java
IllegalArgumentException
```

we create meaningful exceptions such as:

- `UserNotFoundException`
- `ProductNotFoundException`
- `AccountNotFoundException`
- `InsufficientBalanceException`

> **In simple words:**
>
> A Custom Exception represents a specific business error with a meaningful name.

---

# Why Do We Need Custom Exceptions?

Suppose a user requests:

```
GET /users/100
```

User **100** does not exist.

Without a custom exception:

```java
throw new RuntimeException("User Not Found");
```

Problems:

- Generic exception
- Hard to understand
- Difficult to maintain

Instead:

```java
throw new UserNotFoundException("User Not Found");
```

Now anyone reading the code immediately understands what went wrong.

---

# How Custom Exceptions Work

```
Client

↓

Controller

↓

Service

↓

Business Rule Failed

↓

Custom Exception

↓

Global Exception Handler

↓

HTTP Response

↓

Client
```

---

# Creating a Custom Exception

```java
public class UserNotFoundException
        extends RuntimeException {

    public UserNotFoundException(
            String message) {

        super(message);

    }

}
```

Explanation

- Extends `RuntimeException`
- Calls the parent constructor using `super(message)`
- Stores the custom error message

---

# Throwing a Custom Exception

Service

```java
@Service
public class UserService {

    public User getUser(Long id) {

        return repository.findById(id)

                .orElseThrow(() ->

                        new UserNotFoundException(
                                "User Not Found"));

    }

}
```

If the user does not exist:

```
UserNotFoundException
```

is thrown.

---

# Handling Custom Exception

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

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

}
```

---

# Response

```
GET /users/10
```

Response

```text
User Not Found
```

Status

```
404 Not Found
```

---

# Returning Custom Error Response

ErrorResponse

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

Handler

```java
@ExceptionHandler(
        UserNotFoundException.class
)
public ResponseEntity<ErrorResponse> handle(

        UserNotFoundException ex,

        HttpServletRequest request

) {

    ErrorResponse error = ErrorResponse.builder()

            .timestamp(LocalDateTime.now())

            .status(HttpStatus.NOT_FOUND.value())

            .error("Not Found")

            .message(ex.getMessage())

            .path(request.getRequestURI())

            .build();

    return ResponseEntity

            .status(HttpStatus.NOT_FOUND)

            .body(error);

}
```

---

# Complete Flow

```
Client

↓

GET /users/5

↓

Controller

↓

Service

↓

repository.findById()

↓

User Found?

↓

Yes

↓

Return User

OR

No

↓

Throw UserNotFoundException

↓

@RestControllerAdvice

↓

ErrorResponse

↓

404 Response
```

---

# Example 1: Banking Application

Custom Exception

```java
public class InsufficientBalanceException
        extends RuntimeException {

    public InsufficientBalanceException(
            String message) {

        super(message);

    }

}
```

Service

```java
if (balance < amount) {

    throw new InsufficientBalanceException(
            "Insufficient Balance");

}
```

Response

```json
{
    "status": 400,
    "message": "Insufficient Balance"
}
```

---

# Example 2: E-Commerce Application

```java
public class ProductNotFoundException
        extends RuntimeException {

    public ProductNotFoundException(
            String message) {

        super(message);

    }

}
```

```java
throw new ProductNotFoundException(
        "Product Not Found");
```

---

# Example 3: Student Management System

```java
public class StudentNotFoundException
        extends RuntimeException {

    public StudentNotFoundException(
            String message) {

        super(message);

    }

}
```

---

# Custom Exception vs Built-in Exception

| Custom Exception | Built-in Exception |
|------------------|-------------------|
| Created by developer | Provided by Java |
| Represents business rules | Represents system/runtime errors |
| Example: `UserNotFoundException` | Example: `NullPointerException` |
| More meaningful | Generic |

---

# Checked vs Unchecked Custom Exception

## Checked Exception

```java
public class FileUploadException
        extends Exception {

}
```

Must be handled using `try-catch` or `throws`.

---

## Unchecked Exception (Most Common)

```java
public class UserNotFoundException
        extends RuntimeException {

}
```

Does not require mandatory handling.

> **Spring Boot applications typically use unchecked exceptions (`RuntimeException`) for business logic.**

---

# Exception Hierarchy

```
Throwable

├── Error

└── Exception

      ├── Checked Exceptions

      │      └── IOException

      │
      └── RuntimeException

             ├── NullPointerException

             ├── IllegalArgumentException

             └── UserNotFoundException
```

---

# Request Flow

```
Client

↓

Controller

↓

Service

↓

Business Rule

↓

Custom Exception

↓

Global Exception Handler

↓

ResponseEntity

↓

Client
```

---

# Real-World Examples

### Banking Application

```
Withdraw Money

↓

Balance < Amount

↓

InsufficientBalanceException

↓

400 Bad Request
```

---

### E-Commerce Application

```
Search Product

↓

Product Not Found

↓

ProductNotFoundException

↓

404 Not Found
```

---

### Student Management System

```
Search Student

↓

Student Missing

↓

StudentNotFoundException

↓

404 Response
```

---

# Advantages

- Makes code more readable
- Represents business-specific errors
- Easy to maintain
- Improves debugging
- Produces meaningful API responses
- Works seamlessly with Global Exception Handling

---

# Best Practices

- Extend `RuntimeException` for business exceptions.
- Give exceptions meaningful names.
- Throw specific exceptions instead of generic ones.
- Handle custom exceptions using `@RestControllerAdvice`.
- Return proper HTTP status codes.
- Keep exception classes simple and focused.

---

# Interview Questions

### 1. What is a Custom Exception?

A Custom Exception is a user-defined exception created to represent business-specific errors.

---

### 2. Why do we create Custom Exceptions?

To make the code more meaningful, maintainable, and easier to debug.

---

### 3. Which class do Spring Boot business exceptions usually extend?

```java
RuntimeException
```

---

### 4. Where are Custom Exceptions usually handled?

Inside a class annotated with:

```java
@RestControllerAdvice
```

using:

```java
@ExceptionHandler
```

---

### 5. Why are unchecked exceptions preferred in Spring Boot?

Because they reduce boilerplate code and are well-suited for business logic, allowing centralized handling through Global Exception Handling.

---

# Quick Revision

- Custom Exceptions represent business-specific errors.
- Create them by extending `RuntimeException`.
- Throw them from the Service layer when business rules fail.
- Handle them globally using `@RestControllerAdvice` and `@ExceptionHandler`.
- Return meaningful HTTP status codes and error messages.
- Prefer descriptive names like `UserNotFoundException` or `ProductNotFoundException` over generic exceptions.