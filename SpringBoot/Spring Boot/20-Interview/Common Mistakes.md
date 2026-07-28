# Common Spring Boot Mistakes

## Why Should You Know Common Mistakes?

Knowing common mistakes helps you:

- Write cleaner code
- Avoid production issues
- Improve application performance
- Build secure applications
- Perform well in interviews

> **In simple words:**
>
> Learning what **not** to do is just as important as learning what to do.

---

# 1. Putting Business Logic in Controller

❌ Bad

```java
@RestController
public class UserController {

    @PostMapping("/users")
    public User create(

            @RequestBody User user

    ){

        // Validation

        // Business Logic

        // Save User

        return user;

    }

}
```

Problems

- Fat Controller
- Hard to test
- Difficult maintenance

---

✅ Good

```
Controller

↓

Service

↓

Repository
```

```java
@PostMapping("/users")
public UserResponse create(

        @RequestBody UserRequest request

){

    return service.create(request);

}
```

---

# 2. Returning Entity Objects

❌ Bad

```java
@GetMapping
public User getUser(){

}
```

Problems

- Exposes internal database structure
- Passwords may be leaked
- Tight coupling

---

✅ Good

```java
@GetMapping
public UserResponse getUser(){

}
```

Always return DTOs.

---

# 3. Using Field Injection

❌ Bad

```java
@Autowired

private UserRepository repository;
```

Problems

- Hard to test
- Hidden dependencies
- Not immutable

---

✅ Good

```java
private final UserRepository repository;

public UserService(

        UserRepository repository

){

    this.repository = repository;

}
```

Use Constructor Injection.

---

# 4. Ignoring Validation

❌ Bad

```java
@PostMapping
public void save(

        @RequestBody UserRequest request

){

}
```

Any invalid data can enter the application.

---

✅ Good

```java
@PostMapping
public void save(

        @Valid

        @RequestBody

        UserRequest request

){

}
```

---

# 5. No Global Exception Handling

❌ Bad

```
try

catch

try

catch

try

catch
```

Repeated everywhere.

---

✅ Good

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

}
```

Centralize exception handling.

---

# 6. Hardcoding Configuration

❌ Bad

```java
String password = "admin123";
```

Problems

- Security risk
- Difficult deployment

---

✅ Good

```properties
spring.datasource.password=${DB_PASSWORD}
```

Use environment variables.

---

# 7. Using System.out.println()

❌ Bad

```java
System.out.println("User Saved");
```

---

✅ Good

```java
log.info("User Saved");
```

Use logging frameworks like SLF4J with Logback.

---

# 8. Missing Transactions

❌ Bad

```java
repository.save(accountA);

repository.save(accountB);
```

If one operation fails,

data becomes inconsistent.

---

✅ Good

```java
@Transactional
public void transfer(){

}
```

---

# 9. Loading Huge Data

❌ Bad

```java
findAll();
```

Millions of records can overload memory.

---

✅ Good

```java
findAll(pageable);
```

Use Pagination.

---

# 10. Ignoring Lazy Loading

❌ Bad

```
Loop

↓

Each Loop

↓

Database Query
```

Result

```
N+1 Queries
```

---

✅ Good

Use

- Fetch Join
- Entity Graph
- DTO Projection

when appropriate.

---

# 11. Ignoring Database Indexes

Without Index

```
Search

↓

Entire Table Scan
```

---

With Index

```
Search

↓

Direct Lookup
```

Much faster.

---

# 12. Keeping Transactions Open Too Long

❌ Bad

```
Transaction

↓

Call External API

↓

Send Email

↓

Commit
```

Problems

- Long database locks
- Poor performance

---

✅ Good

```
Transaction

↓

Database Work

↓

Commit

↓

External API

↓

Email
```

---

# 13. Calling External APIs Without Timeouts

❌ Bad

```
Call API

↓

Wait Forever
```

---

✅ Good

```
Configure Timeout

↓

Fail Fast

↓

Retry
```

---

# 14. Not Closing Resources

Example

```java
InputStream

↓

Never Closed
```

Result

- Memory Leak
- Resource Leak

---

Use

```java
try-with-resources
```

---

# 15. Ignoring Security

Common mistakes

- No Authentication
- No Authorization
- No HTTPS
- Weak Password Storage

Always use

- Spring Security
- BCrypt
- JWT/OAuth2
- HTTPS

---

# 16. Hardcoding API Keys

❌ Bad

```java
String apiKey = "123456";
```

---

✅ Good

```properties
api.key=${API_KEY}
```

---

# 17. No Logging

Without logs

```
Production Error

↓

No Information

↓

Long Debugging
```

Always log:

- Errors
- Warnings
- Important Events

---

# 18. Poor Package Structure

❌ Bad

```
All Files

↓

One Package
```

---

✅ Good

```
controller

service

repository

entity

dto

config

security

exception
```

---

# 19. Not Writing Tests

Problems

- Bugs reach production
- Difficult refactoring

Write

- Unit Tests
- Integration Tests

---

# 20. Ignoring Monitoring

Production should monitor

- CPU
- Memory
- Database
- API Response Time
- Error Rate

Use

- Spring Boot Actuator
- Micrometer
- Prometheus
- Grafana

---

# Common Mistakes Summary

| Mistake | Better Approach |
|----------|-----------------|
| Business logic in Controller | Move to Service |
| Return Entity | Return DTO |
| Field Injection | Constructor Injection |
| No Validation | Bean Validation |
| No Exception Handling | `@RestControllerAdvice` |
| Hardcoded Secrets | Environment Variables |
| `System.out.println()` | Logger |
| No Transactions | `@Transactional` |
| `findAll()` Everywhere | Pagination |
| No Timeouts | Configure Timeouts |
| No Monitoring | Actuator + Metrics |

---

# Real-World Example

## Banking Application

```
Money Transfer

↓

@Transactional

↓

Commit

↓

Send Notification
```

Avoid sending emails before the transaction commits.

---

## E-Commerce Website

```
Controller

↓

Service

↓

Repository

↓

Database
```

Use DTOs, validation, and pagination.

---

## Food Delivery App

```
Order

↓

Inventory

↓

Payment

↓

Notification
```

Handle failures with transactions and proper exception handling.

---

# Best Practices

- Keep Controllers thin.
- Use DTOs.
- Use Constructor Injection.
- Validate every request.
- Handle exceptions globally.
- Use transactions wisely.
- Configure timeouts.
- Secure secrets.
- Log important events.
- Monitor production systems.
- Write automated tests.

---

# Interview Questions

### 1. Why should business logic not be placed in Controllers?

Controllers should only handle HTTP requests and delegate business logic to the Service Layer.

---

### 2. Why is returning Entity objects considered a bad practice?

Entities may expose sensitive fields and tightly couple the API to the database model.

---

### 3. Why is constructor injection preferred?

It improves immutability, makes dependencies explicit, and simplifies testing.

---

### 4. Why should `System.out.println()` be avoided?

It is not suitable for production logging. Use a logging framework with configurable log levels.

---

### 5. Why is pagination important?

It prevents excessive memory usage and improves performance when retrieving large datasets.

---

### 6. Why should API keys and passwords never be hardcoded?

Hardcoded secrets are a major security risk and make deployments across environments difficult.

---

### 7. What tools are commonly used to monitor Spring Boot applications?

Spring Boot Actuator, Micrometer, Prometheus, and Grafana.

---

# Quick Revision

- Keep Controllers thin.
- Put business logic in Services.
- Return DTOs, not Entities.
- Use constructor injection.
- Validate requests.
- Handle exceptions globally.
- Use `@Transactional`.
- Configure timeouts.
- Never hardcode secrets.
- Use logging instead of `System.out.println()`.
- Implement pagination.
- Monitor production applications.
- Write unit and integration tests.