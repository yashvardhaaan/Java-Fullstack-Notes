# Mockito

## What is Mockito?

**Mockito** is a Java testing framework used to create **Mock Objects** for Unit Testing.

A **Mock Object** is a fake implementation of a real object that allows you to test a class **without using its actual dependencies**.

Mockito is commonly used with **JUnit 5** in Spring Boot applications.

> **In simple words:**
>
> Mockito creates fake objects so you can test one class without depending on databases, APIs, or other services.

---

# Why Do We Need Mockito?

Suppose we have:

```
Controller

↓

Service

↓

Repository

↓

Database
```

If we want to test only the **Service**,

we don't want to connect to a real database.

Instead,

we replace the Repository with a **Mock Object**.

```
Service

↓

Mock Repository

↓

Fake Data
```

---

# Real-World Example

Imagine a movie scene.

Instead of using a real explosion,

the movie uses special effects.

```
Real Explosion

↓

Dangerous
```

Instead,

```
Fake Explosion

↓

Safe

↓

Looks Real
```

Mockito creates fake objects in the same way.

---

# Without Mockito

```
Service

↓

Repository

↓

Database

↓

Slow Test
```

Problems

- Requires database.
- Slower tests.
- Difficult to isolate the Service.

---

# With Mockito

```
Service

↓

Mock Repository

↓

Fake Response

↓

Fast Test
```

---

# Mockito Architecture

```
Application

│

├── Controller

├── Service

├── Repository

└── Database

          ▲

          │

     Mockito Mock

          │

          ▼

      Fake Object
```

---

# Example Application

Repository

```java
@Repository
public class UserRepository {

    public String findUser() {

        return "Yash";

    }

}
```

---

Service

```java
@Service
public class UserService {

    private UserRepository repository;

    public UserService(UserRepository repository) {

        this.repository = repository;

    }

    public String getUser() {

        return repository.findUser();

    }

}
```

---

# Unit Testing Problem

During testing,

```
UserService

↓

UserRepository

↓

Real Database
```

We don't want this.

Instead,

Mockito creates

```
Mock Repository

↓

Fake Data

↓

UserService
```

---

# Adding Mockito

Spring Boot includes Mockito through:

```xml
spring-boot-starter-test
```

No additional dependency is required in most Spring Boot projects.

---

# @Mock

Creates a mock object.

```java
@Mock
private UserRepository repository;
```

Result

```
Mockito

↓

Fake UserRepository
```

---

# @InjectMocks

Creates the object being tested and injects the mock dependencies.

```java
@InjectMocks
private UserService service;
```

Flow

```
Mock Repository

↓

Inject

↓

UserService
```

---

# Initializing Mockito

```java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {

}
```

This enables Mockito in JUnit 5.

---

# First Mockito Test

```java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository repository;

    @InjectMocks
    private UserService service;

    @Test
    void testGetUser() {

        when(repository.findUser())

                .thenReturn("Yash");

        String result = service.getUser();

        assertEquals("Yash", result);

    }

}
```

---

# How `when()` Works

```java
when(repository.findUser())

        .thenReturn("Yash");
```

Flow

```
Service Calls Repository

↓

Repository Mock

↓

Return "Yash"

↓

Service Receives Value
```

---

# thenReturn()

Returns a fake value.

```java
when(repository.findUser())

        .thenReturn("Spring");
```

No real database is used.

---

# Mock Execution Flow

```
JUnit

↓

Mockito

↓

Create Mock

↓

Inject Mock

↓

Run Service

↓

Fake Response

↓

Assertion

↓

Pass
```

---

# verify()

Checks whether a method was called.

```java
verify(repository)

        .findUser();
```

Meaning

```
Was findUser()

called?

↓

Yes

↓

Pass
```

---

# verify() with Count

```java
verify(repository, times(2))

        .findUser();
```

Meaning

```
findUser()

↓

Called Twice?

↓

Pass
```

---

# Mocking Exceptions

```java
when(repository.findUser())

        .thenThrow(

                new RuntimeException()

        );
```

Useful for testing exception handling.

---

# Mocking Lists

```java
when(repository.findAll())

        .thenReturn(

                List.of("Java", "Spring")

        );
```

Mockito returns fake list data.

---

# Mockito Flow

```
Create Mock

↓

Define Behavior

↓

Inject Mock

↓

Call Service

↓

Receive Fake Data

↓

Verify Result
```

---

# Mockito Annotations

| Annotation | Purpose |
|------------|----------|
| `@Mock` | Creates a mock object |
| `@InjectMocks` | Injects mocks into the class under test |
| `@Spy` | Creates a partial mock |
| `@Captor` | Captures method arguments |

---

# Mock vs Spy

| Mock | Spy |
|------|-----|
| Completely fake object | Wraps a real object |
| Real methods are not called | Real methods are called unless mocked |
| Used for isolation | Used for partial mocking |

---

# Mockito vs JUnit

| Mockito | JUnit |
|----------|--------|
| Creates mock objects | Runs tests |
| Fakes dependencies | Executes test methods |
| Verifies interactions | Provides assertions |
| Used with JUnit | Testing framework |

---

# Common Mistakes

❌ Connecting to a real database in a Unit Test.

❌ Forgetting `@ExtendWith(MockitoExtension.class)`.

❌ Mocking the class under test instead of its dependencies.

❌ Using Mockito for Integration Tests.

---

# Real-World Example

## Banking Application

```
AccountService

↓

Mock AccountRepository

↓

Fake Account

↓

Pass
```

---

## E-Commerce Website

```
ProductService

↓

Mock ProductRepository

↓

Fake Product

↓

Pass
```

---

## Food Delivery App

```
OrderService

↓

Mock OrderRepository

↓

Fake Order

↓

Pass
```

---

# Advantages

- Fast Unit Tests.
- No database required.
- Tests classes in isolation.
- Easy to simulate different scenarios.
- Supports exception testing.
- Integrates seamlessly with JUnit 5.

---

# Best Practices

- Mock only external dependencies.
- Do not mock simple Java objects (POJOs).
- Keep one behavior per test.
- Verify important interactions.
- Use descriptive test method names.
- Avoid excessive mocking.

---

# Interview Questions

### 1. What is Mockito?

Mockito is a Java mocking framework used to create fake objects for Unit Testing.

---

### 2. Why is Mockito used?

Mockito isolates the class under test by replacing its dependencies with mock objects.

---

### 3. What is the purpose of `@Mock`?

It creates a fake implementation of a dependency.

---

### 4. What is the purpose of `@InjectMocks`?

It creates the object being tested and injects all required mock dependencies.

---

### 5. What does `when().thenReturn()` do?

It defines the behavior of a mock object by specifying what value should be returned when a method is called.

---

### 6. What does `verify()` do?

It checks whether a method on a mock object was called and optionally how many times.

---

### 7. What is the difference between Mock and Spy?

A **Mock** is a completely fake object, while a **Spy** wraps a real object and allows selected methods to be mocked.

---

# Quick Revision

- Mockito is used to create Mock Objects.
- Mock objects replace real dependencies like repositories or external APIs.
- `@Mock` creates fake objects.
- `@InjectMocks` injects mock dependencies into the class under test.
- `when().thenReturn()` defines mock behavior.
- `verify()` checks method interactions.
- Mockito is commonly used with JUnit 5.
- Mockito helps write fast, isolated, and reliable Unit Tests.