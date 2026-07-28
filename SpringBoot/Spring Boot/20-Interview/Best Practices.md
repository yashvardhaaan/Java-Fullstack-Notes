# Spring Boot Best Practices

## What are Best Practices?

**Best Practices** are recommended techniques and guidelines that help developers build applications that are:

- Clean
- Maintainable
- Secure
- Scalable
- Performant
- Production Ready

> **In simple words:**
>
> Best Practices are proven ways to write better Spring Boot applications.

---

# Why Do We Need Best Practices?

Without Best Practices

```
Large Controller

↓

Business Logic

↓

SQL Queries

↓

Difficult Maintenance
```

Problems

- Duplicate code
- Difficult debugging
- Hard testing
- Poor scalability

---

With Best Practices

```
Controller

↓

Service

↓

Repository

↓

Database
```

Every layer has a single responsibility.

---

# Follow Layered Architecture

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
```

Never skip layers.

---

# Keep Controllers Thin

Controller should only

- Receive Request
- Validate Input
- Call Service
- Return Response

Good Example

```java
@PostMapping
public UserResponse create(

        @RequestBody UserRequest request

){

    return service.create(request);

}
```

Bad Example

```java
@PostMapping
public User create(

        @RequestBody User user

){

    // Validation

    // Business Logic

    // SQL Query

}
```

---

# Put Business Logic in Service Layer

Good

```
Controller

↓

Service

↓

Repository
```

Bad

```
Controller

↓

Business Logic

↓

Repository
```

---

# Keep Repository for Database Operations Only

Repository should contain

- CRUD
- Queries
- Database Access

Repository should NOT contain

- Business Logic
- Validations
- HTTP Calls

---

# Use DTOs

Never expose Entity objects directly.

Bad

```java
public User getUser(){

}
```

Good

```java
public UserResponse getUser(){

}
```

Benefits

- Better Security
- Cleaner APIs
- Easier Versioning

---

# Validate Input

Use Bean Validation.

```java
@NotBlank

private String name;

@Email

private String email;
```

Never trust client input.

---

# Use Global Exception Handling

Instead of

```
try

catch

try

catch
```

Use

```java
@RestControllerAdvice
```

Centralized exception handling.

---

# Constructor Injection

Good

```java
public UserService(

        UserRepository repository

){

    this.repository = repository;

}
```

Avoid

```java
@Autowired

private UserRepository repository;
```

Constructor injection improves immutability and testability.

---

# Use @Transactional

For multiple database operations.

```java
@Transactional
public void transfer(){

}
```

Ensures all operations succeed or rollback together.

---

# Use Logging Instead of System.out.println()

Bad

```java
System.out.println("Saved");
```

Good

```java
private static final Logger log =

LoggerFactory.getLogger(

        UserService.class

);

log.info("User saved");
```

---

# Externalize Configuration

Bad

```java
String password = "admin123";
```

Good

```properties
spring.datasource.password=${DB_PASSWORD}
```

Use environment variables or secret managers.

---

# Use Pagination

Bad

```java
findAll();
```

Good

```java
Page<User> users =
repository.findAll(pageable);
```

Prevents loading huge datasets.

---

# Use Proper HTTP Status Codes

| Status | Meaning |
|---------|----------|
| 200 | Success |
| 201 | Created |
| 204 | No Content |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |

---

# Secure APIs

Always use

- Spring Security
- JWT
- OAuth2
- HTTPS

Never expose sensitive endpoints publicly.

---

# Handle Sensitive Data Carefully

Never expose

- Passwords
- Tokens
- Secret Keys
- Database Credentials

Always encrypt sensitive information.

---

# Keep Methods Small

Bad

```
500 Lines

↓

One Method
```

Good

```
Small Methods

↓

Easy Testing

↓

Easy Reading
```

---

# Use Meaningful Names

Bad

```java
public void abc(){

}
```

Good

```java
public void createOrder(){

}
```

Readable code is maintainable code.

---

# Monitor Your Application

Use

- Spring Boot Actuator
- Micrometer
- Prometheus
- Grafana

Monitor

- Memory
- CPU
- Database
- Requests
- Errors

---

# Optimize Database

Use

- Indexes
- Pagination
- Lazy Loading
- Connection Pool
- Batch Processing

Avoid

```
N+1 Queries
```

---

# Use Asynchronous Processing

Long-running tasks

```
Email

PDF

Notification
```

should use

```java
@Async
```

---

# Write Unit Tests

Test

- Service Layer
- Repository Layer
- Controller Layer

Popular Tools

- JUnit
- Mockito

---

# Keep Dependencies Updated

Regularly update

- Spring Boot
- Hibernate
- Libraries

Security fixes are important.

---

# Project Structure

```
com.example.project

├── controller

├── service

├── repository

├── entity

├── dto

├── mapper

├── config

├── security

├── exception

└── util
```

---

# Common Mistakes

❌ Business logic inside Controllers.

❌ Returning Entity objects.

❌ Ignoring validation.

❌ Hardcoding credentials.

❌ Not handling exceptions.

❌ Loading entire tables.

❌ Using `System.out.println()` for logging.

❌ Ignoring transactions.

❌ Not writing tests.

❌ Exposing sensitive APIs.

---

# Real-World Example

## Banking Application

```
Controller

↓

Service

↓

Repository

↓

Database
```

Transactions ensure consistency.

---

## E-Commerce Website

```
Controller

↓

Validation

↓

Service

↓

Repository
```

Uses DTOs and pagination.

---

## Food Delivery App

```
Order Service

↓

Inventory Service

↓

Notification Service

↓

Email
```

Uses asynchronous processing.

---

# Advantages

- Clean architecture.
- Better maintainability.
- Easier testing.
- Higher security.
- Better scalability.
- Improved performance.
- Production-ready applications.

---

# Interview Questions

### 1. Why should Controllers be thin?

Because Controllers should only handle HTTP requests and delegate business logic to the Service Layer.

---

### 2. Why should DTOs be used?

DTOs prevent exposing internal entities and allow flexible API design.

---

### 3. Why is constructor injection preferred?

It promotes immutability, makes dependencies explicit, and simplifies unit testing.

---

### 4. Why should `System.out.println()` be avoided?

It is unsuitable for production. Logging frameworks provide configurable log levels and better monitoring.

---

### 5. Why is pagination important?

Pagination prevents loading millions of records into memory, improving performance and scalability.

---

### 6. Why should credentials never be hardcoded?

Hardcoded credentials are a security risk and make configuration difficult across environments.

---

### 7. Which layer should contain business logic?

The **Service Layer**.

---

# Quick Revision

- Follow Layered Architecture.
- Keep Controllers thin.
- Put business logic in Services.
- Use Repositories only for database access.
- Use DTOs instead of Entities.
- Validate input using Bean Validation.
- Handle exceptions globally.
- Use constructor injection.
- Use `@Transactional` for database operations.
- Log using SLF4J/Logback instead of `System.out.println()`.
- Externalize configuration.
- Secure APIs with Spring Security and HTTPS.
- Use pagination, indexing, and connection pooling.
- Write unit tests and keep dependencies updated.