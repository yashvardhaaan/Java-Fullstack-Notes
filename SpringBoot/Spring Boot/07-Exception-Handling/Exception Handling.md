# Exception Handling

## What is Exception Handling?

**Exception Handling** is the process of handling errors that occur during the execution of an application without crashing it.

Instead of showing technical errors to the user, Spring Boot catches exceptions and returns a meaningful response.

> **In simple words:**
>
> Exception Handling allows an application to respond gracefully when something goes wrong.

---

# Why Do We Need Exception Handling?

Suppose a client requests:

```
GET /users/100
```

But user **100** does not exist.

Without Exception Handling:

```
500 Internal Server Error

NullPointerException
```

This is confusing for users.

With Exception Handling:

```json
{
    "status": 404,
    "message": "User not found"
}
```

The user receives a clear and meaningful response.

---

# What is an Exception?

An **Exception** is an event that interrupts the normal execution of a program.

Examples:

- Division by zero
- Invalid input
- File not found
- Database connection failure
- User not found
- Invalid request data

---

# Types of Exceptions in Java

## 1. Checked Exceptions

Checked exceptions are verified at compile time.

Examples:

- IOException
- SQLException
- FileNotFoundException

Example

```java
FileReader reader =
        new FileReader("data.txt");
```

If the file doesn't exist, Java requires you to handle the exception.

---

## 2. Unchecked Exceptions

Unchecked exceptions occur at runtime.

Examples:

- NullPointerException
- ArithmeticException
- IllegalArgumentException
- IndexOutOfBoundsException

Example

```java
int result = 10 / 0;
```

Output

```
ArithmeticException
```

---

# Exception Handling in Spring Boot

Spring Boot automatically catches many exceptions and converts them into HTTP responses.

Example

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

Spring Boot

↓

HTTP Error Response
```

---

# Without Exception Handling

Controller

```java
@GetMapping("/{id}")
public User getUser(
        @PathVariable Long id) {

    return userService.getUser(id);

}
```

Service

```java
public User getUser(Long id) {

    return repository.findById(id).get();

}
```

If the user does not exist:

```
NoSuchElementException
```

Spring returns a generic error response.

---

# With Exception Handling

Service

```java
public User getUser(Long id) {

    return repository.findById(id)

            .orElseThrow(() ->
                    new RuntimeException("User Not Found"));

}
```

Now the exception can be handled centrally to return a proper error response.

---

# Exception Flow

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Exception Occurs

↓

Spring Boot

↓

Exception Handler

↓

HTTP Response
```

---

# Common Exceptions in Spring Boot

| Exception | Cause |
|-----------|-------|
| `NullPointerException` | Accessing a null object |
| `ArithmeticException` | Division by zero |
| `IllegalArgumentException` | Invalid method argument |
| `MethodArgumentNotValidException` | Validation failed |
| `NoSuchElementException` | Data not found |
| `HttpMessageNotReadableException` | Invalid JSON request |
| `DataIntegrityViolationException` | Database constraint violation |

---

# HTTP Status Codes Used

| Status Code | Meaning |
|-------------|---------|
| **200** | Success |
| **201** | Resource Created |
| **400** | Bad Request |
| **401** | Unauthorized |
| **403** | Forbidden |
| **404** | Resource Not Found |
| **409** | Conflict |
| **500** | Internal Server Error |

---

# Spring Boot Exception Handling Flow

```
HTTP Request

↓

Controller

↓

Business Logic

↓

Exception?

↓

No

↓

Response

OR

Yes

↓

Exception Handler

↓

Error Response

↓

Client
```

---

# Example

Controller

```java
@GetMapping("/{id}")
public User getUser(
        @PathVariable Long id) {

    return service.getUser(id);

}
```

Service

```java
public User getUser(Long id) {

    return repository.findById(id)

            .orElseThrow(() ->
                new RuntimeException("User Not Found"));

}
```

If user ID does not exist:

```
Exception

↓

Spring Boot

↓

404 Response
```

(With proper exception handling configured.)

---

# Benefits of Exception Handling

Without Exception Handling

```
Application Error

↓

Stack Trace

↓

Poor User Experience
```

With Exception Handling

```
Application Error

↓

Meaningful Response

↓

Better User Experience
```

---

# Request Processing Flow

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Exception?

↓

No

↓

Response

OR

Yes

↓

Exception Handler

↓

Error Response
```

---

# Real-World Examples

### Banking Application

```
Transfer Money

↓

Account Not Found

↓

Return

404 Account Not Found
```

---

### E-Commerce Application

```
Buy Product

↓

Product Out of Stock

↓

Return

409 Conflict
```

---

### Student Management System

```
Search Student

↓

Student Not Found

↓

404 Response
```

---

# Exception Handling vs Validation

| Exception Handling | Validation |
|--------------------|------------|
| Handles runtime errors | Prevents invalid input |
| Executes after an error occurs | Executes before business logic |
| Returns error response | Stops invalid requests |
| Example: User not found | Example: Invalid email |

---

# Advantages

- Prevents application crashes
- Returns meaningful error messages
- Improves user experience
- Centralizes error handling
- Makes APIs easier to maintain
- Provides consistent error responses

---

# Best Practices

- Never expose stack traces to API clients.
- Use meaningful HTTP status codes.
- Create custom exceptions for business logic.
- Handle exceptions centrally using Global Exception Handling.
- Return a consistent error response format.
- Log exceptions for debugging.

---

# Interview Questions

### 1. What is Exception Handling?

Exception Handling is the process of catching and handling errors so that the application continues to work gracefully.

---

### 2. Why is Exception Handling important?

It prevents application crashes, improves user experience, and returns meaningful error responses.

---

### 3. What is the difference between Checked and Unchecked Exceptions?

- **Checked Exceptions** are checked at compile time.
- **Unchecked Exceptions** occur at runtime.

---

### 4. What are some common exceptions in Spring Boot?

- `NullPointerException`
- `IllegalArgumentException`
- `MethodArgumentNotValidException`
- `NoSuchElementException`
- `DataIntegrityViolationException`

---

### 5. What HTTP status code is commonly returned when a resource is not found?

```text
404 Not Found
```

---

# Quick Revision

- Exception Handling manages runtime errors gracefully.
- Exceptions interrupt the normal flow of program execution.
- Java has Checked and Unchecked exceptions.
- Spring Boot converts exceptions into HTTP error responses.
- Use appropriate HTTP status codes like **400**, **404**, **409**, and **500**.
- Handle exceptions centrally for consistent API responses.
- Never expose internal stack traces to clients.