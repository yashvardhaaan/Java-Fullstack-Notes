# Integration Testing

## What is Integration Testing?

**Integration Testing** verifies that **multiple components of an application work together correctly**.

Instead of testing a single method, Integration Testing checks the interaction between:

- Controller
- Service
- Repository
- Database

> **In simple words:**
>
> Integration Testing checks whether different parts of your application work together as expected.

---

# Why Do We Need Integration Testing?

Suppose your application has:

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

Even if every class passes Unit Tests,

they may fail when connected together.

Example

```
Repository

↓

Wrong SQL Query

↓

Application Fails
```

Unit Tests cannot detect this.

Integration Tests can.

---

# Real-World Example

Imagine building a car.

Every part is tested individually.

```
Engine

✓
```

```
Brake

✓
```

```
Steering

✓
```

But after assembling,

the entire car must be tested.

```
Engine

↓

Brake

↓

Steering

↓

Road Test
```

Similarly,

Integration Testing verifies that all application components work together.

---

# Unit Testing vs Integration Testing

## Unit Testing

```
Service

↓

Mock Repository

↓

Fake Data
```

Tests one component.

---

## Integration Testing

```
Controller

↓

Service

↓

Repository

↓

Real Database

↓

Response
```

Tests the complete flow.

---

# Integration Testing Flow

```
Client Request

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Repository

↓

Service

↓

Controller

↓

Response
```

Everything works together.

---

# Integration Testing Architecture

```
Application

│

├── Controller

│

├── Service

│

├── Repository

│

└── Database

        ▲

        │

 Integration Test

        │

        ▼

 Verify Complete Flow
```

---

# Spring Boot Integration Testing

Spring Boot provides

```java
@SpringBootTest
```

to load the complete application context.

```java
@SpringBootTest
class UserIntegrationTest {

}
```

Spring starts almost the same application context used in production.

---

# Sample Application

Controller

```java
@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping("/{id}")
    public User getUser(

            @PathVariable Long id

    ) {

        return service.getUser(id);

    }

}
```

---

Repository

```java
@Repository
public interface UserRepository

        extends JpaRepository<User, Long> {

}
```

---

# Integration Test Example

```java
@SpringBootTest
class UserIntegrationTest {

    @Autowired
    private UserService service;

    @Test
    void testService() {

        User user = service.getUser(1L);

        assertNotNull(user);

    }

}
```

This test uses the real Service and Repository.

---

# Testing REST APIs

```java
@SpringBootTest

@AutoConfigureMockMvc
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

}
```

This loads the complete Spring Boot application while allowing HTTP requests using MockMvc.

---

# Example

```java
@Test
void testGetUser() throws Exception {

    mockMvc.perform(

            get("/users/1")

    )

    .andExpect(status().isOk());

}
```

Flow

```
HTTP Request

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Response

↓

Assertion
```

---

# Application Context

One important part of Integration Testing is the

```
Application Context
```

Spring creates

- Beans
- Controllers
- Services
- Repositories

just like a real application.

```
Spring Boot

↓

Create Beans

↓

Dependency Injection

↓

Application Ready
```

---

# Database Testing

Unlike Unit Tests,

Integration Tests often use a **real database**.

Example

```
Repository

↓

MySQL

↓

Data Returned
```

or

```
Repository

↓

H2 Database

↓

Test Data
```

---

# H2 In-Memory Database

Many Spring Boot projects use

```
H2 Database
```

during Integration Testing.

```
Application Starts

↓

Create H2 Database

↓

Run Tests

↓

Database Removed
```

Advantages

- Fast
- Temporary
- No installation required

---

# Test Lifecycle

```
@SpringBootTest

↓

Application Starts

↓

Beans Created

↓

Database Connected

↓

Run Tests

↓

Application Stops
```

---

# Integration Testing vs MockMvc

| Integration Testing | MockMvc |
|---------------------|----------|
| Tests complete application flow | Tests Controller layer |
| Uses real beans | Often uses mocked dependencies |
| Can use a real database | Usually avoids database |
| Slower | Faster |

---

# Integration Testing vs Unit Testing

| Unit Testing | Integration Testing |
|--------------|---------------------|
| Tests one class | Tests multiple classes |
| Uses mocks | Uses real components |
| Very fast | Slower |
| No database | Often uses database |

---

# Common Annotations

| Annotation | Purpose |
|------------|----------|
| `@SpringBootTest` | Loads complete Spring Boot application |
| `@AutoConfigureMockMvc` | Enables MockMvc |
| `@Transactional` | Rolls back database changes after each test |
| `@Autowired` | Injects beans |

---

# Using @Transactional

```java
@SpringBootTest

@Transactional
class UserIntegrationTest {

}
```

Flow

```
Insert Data

↓

Run Test

↓

Rollback

↓

Database Clean
```

Each test starts with a clean database.

---

# Request Flow

```
JUnit

↓

Spring Boot

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Repository

↓

Service

↓

Controller

↓

Assertions
```

---

# Common Mistakes

❌ Using mocks in every Integration Test.

❌ Testing only the Service layer.

❌ Forgetting database cleanup.

❌ Making tests depend on execution order.

❌ Sharing test data between tests.

---

# Real-World Example

## Banking Application

```
Transfer Money API

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Balance Updated

↓

Pass
```

---

## E-Commerce Website

```
Create Order

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Order Saved
```

---

## Food Delivery App

```
Place Order

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Success
```

---

# Advantages

- Tests the complete application flow.
- Detects configuration issues.
- Verifies database integration.
- Validates dependency injection.
- Increases confidence before deployment.

---

# Best Practices

- Use `@SpringBootTest` for Integration Tests.
- Keep Unit Tests and Integration Tests separate.
- Use H2 or Testcontainers for database testing.
- Roll back database changes using `@Transactional`.
- Test real business workflows.
- Keep Integration Tests independent.

---

# Interview Questions

### 1. What is Integration Testing?

Integration Testing verifies that multiple components of an application work correctly together.

---

### 2. Which annotation loads the complete Spring Boot application?

```java
@SpringBootTest
```

---

### 3. What is the difference between Unit Testing and Integration Testing?

Unit Testing tests a single class in isolation, while Integration Testing verifies interactions between multiple components.

---

### 4. Why is `@Transactional` commonly used in Integration Tests?

It automatically rolls back database changes after each test, ensuring a clean database state.

---

### 5. Can Integration Tests use a real database?

Yes.

They often use a real database, an H2 in-memory database, or Testcontainers.

---

### 6. Why are Integration Tests slower than Unit Tests?

Because they load the full Spring application context and may interact with external resources such as databases.

---

### 7. Can MockMvc be used in Integration Testing?

Yes.

Using `@SpringBootTest` together with `@AutoConfigureMockMvc`, you can test the complete request flow without starting an external web server.

---

# Quick Revision

- Integration Testing verifies multiple components working together.
- Use `@SpringBootTest` to load the complete application.
- Test Controller, Service, Repository, and Database together.
- Integration Tests often use H2, MySQL, PostgreSQL, or Testcontainers.
- `@Transactional` rolls back database changes after each test.
- Integration Tests are slower than Unit Tests but provide greater confidence.
- Use MockMvc with `@AutoConfigureMockMvc` for end-to-end request testing.
- Integration Testing is essential before deploying production applications.