# Bean Validation

## What is Bean Validation?

**Bean Validation** is a Java specification (Jakarta Bean Validation) used to validate object fields using annotations.

Instead of writing validation logic manually using `if` statements, we simply place validation annotations on fields.

Spring Boot automatically validates the object before it reaches our business logic.

> **In simple words:**
>
> Bean Validation checks whether the incoming data is valid before processing it.

---

# Why Do We Need Bean Validation?

Imagine a user registration API.

Without validation, users could send:

- Empty name
- Invalid email
- Negative age
- Weak password

This could lead to:

- Invalid database records
- Application errors
- Security issues
- Poor user experience

Bean Validation prevents invalid data from entering the application.

---

# Without Bean Validation

```java
@PostMapping("/users")
public String createUser(@RequestBody User user) {

    if (user.getName() == null ||
        user.getName().isEmpty()) {
        return "Name is required";
    }

    if (user.getAge() < 18) {
        return "Age must be at least 18";
    }

    return "User Created";
}
```

Problems:

- Too many `if` statements
- Hard to maintain
- Repeated validation logic

---

# With Bean Validation

```java
public class User {

    @NotBlank
    private String name;

    @Email
    private String email;

    @Min(18)
    private int age;

}
```

Controller

```java
@PostMapping("/users")
public String createUser(
        @Valid @RequestBody User user) {

    return "User Created";
}
```

Spring Boot validates the object automatically.

---

# How Bean Validation Works

```
Client

↓

HTTP Request

↓

Controller

↓

@Valid

↓

Bean Validation

↓

Valid?

↓

Yes ----------→ Controller Logic

↓

No

↓

Validation Exception

↓

Error Response
```

---

# Bean Validation Architecture

```
Client

↓

Spring Boot

↓

Controller

↓

@Valid

↓

Hibernate Validator

↓

Validation Annotations

↓

Java Object
```

---

# Bean Validation Dependency

Spring Boot Starter Validation

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>

    <artifactId>
        spring-boot-starter-validation
    </artifactId>
</dependency>
```

This dependency includes Hibernate Validator, which is the default implementation of Jakarta Bean Validation.

---

# Common Validation Flow

```
User submits data

↓

Spring converts JSON to Object

↓

Bean Validation starts

↓

Checks annotations

↓

If valid

↓

Business Logic

↓

Database

OR

If invalid

↓

MethodArgumentNotValidException

↓

400 Bad Request
```

---

# Example Entity

```java
public class Student {

    @NotBlank
    private String name;

    @Email
    private String email;

    @Min(18)
    private int age;

}
```

---

# Example Request

Valid Request

```json
{
    "name": "John",
    "email": "john@gmail.com",
    "age": 22
}
```

Validation passes.

---

Invalid Request

```json
{
    "name": "",
    "email": "abc",
    "age": 10
}
```

Validation fails.

---

# Validation Process

```
JSON

↓

Java Object

↓

@NotBlank

↓

@Email

↓

@Min

↓

Validation Passed?

↓

Yes → Save Data

No → Return Error
```

---

# Default Error Response

If validation fails, Spring Boot returns an error similar to:

```json
{
    "timestamp": "2026-07-28T10:15:30",
    "status": 400,
    "error": "Bad Request",
    "path": "/users"
}
```

With Global Exception Handling, we can customize this response.

---

# Bean Validation vs Manual Validation

| Bean Validation | Manual Validation |
|-----------------|-------------------|
| Uses annotations | Uses `if` statements |
| Less code | More code |
| Easy to maintain | Hard to maintain |
| Reusable | Repetitive |
| Automatic | Manual |

---

# Bean Validation vs Database Constraints

| Bean Validation | Database Constraint |
|-----------------|---------------------|
| Checks data before saving | Checks data while saving |
| Better user experience | Last line of defense |
| Returns meaningful errors | Database exception |
| Runs in application layer | Runs in database |

> **Best Practice:** Use both Bean Validation and database constraints together.

---

# Real-World Example

### Banking Application

Before creating an account:

- Customer name cannot be empty
- Email must be valid
- Initial deposit must be positive

Bean Validation ensures these rules are checked automatically.

---

### E-Commerce Application

Before placing an order:

- Address cannot be blank
- Phone number must be valid
- Quantity must be greater than zero

---

### Student Management System

Before registering a student:

- Name is required
- Email must be valid
- Age must be greater than or equal to 18

---

# Advantages

- Reduces boilerplate code
- Improves code readability
- Easy to maintain
- Automatic validation
- Better user experience
- Standard Java specification
- Integrates seamlessly with Spring Boot

---

# Best Practices

- Always use `spring-boot-starter-validation`.
- Validate request DTOs instead of JPA entities whenever possible.
- Combine Bean Validation with Global Exception Handling for clean error responses.
- Use meaningful validation messages.
- Do not rely only on frontend validation; always validate on the backend.

---

# Interview Questions

### 1. What is Bean Validation?

Bean Validation is a Java specification used to validate object fields using annotations before processing the request.

---

### 2. Which dependency enables Bean Validation in Spring Boot?

```xml
spring-boot-starter-validation
```

---

### 3. Which implementation does Spring Boot use by default?

**Hibernate Validator**.

---

### 4. Which annotation triggers Bean Validation in Spring Boot?

```java
@Valid
```

---

### 5. Why should we use Bean Validation?

To prevent invalid data from entering the application, reduce manual validation code, and improve maintainability.

---

# Quick Revision

- Bean Validation validates Java objects using annotations.
- Spring Boot uses **Hibernate Validator** by default.
- Add the `spring-boot-starter-validation` dependency.
- `@Valid` triggers validation in controllers.
- Validation happens before business logic executes.
- Invalid requests result in a **400 Bad Request** response.
- Bean Validation reduces manual validation code and improves code quality.