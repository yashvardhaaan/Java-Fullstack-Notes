# Testcontainers

## What is Testcontainers?

**Testcontainers** is a Java library that allows you to run **real Docker containers** during your tests.

Instead of using fake databases or manually installing databases, Testcontainers starts temporary Docker containers automatically.

It is commonly used for testing:

- MySQL
- PostgreSQL
- MongoDB
- Redis
- Kafka
- RabbitMQ

> **In simple words:**
>
> Testcontainers creates a temporary Docker container for your tests and removes it after the tests finish.

---

# Why Do We Need Testcontainers?

Suppose your application uses PostgreSQL.

Without Testcontainers

```
Developer

↓

Install PostgreSQL

↓

Configure Database

↓

Run Tests
```

Problems

- Different versions on different machines.
- Difficult setup.
- Tests may fail due to environment differences.

With Testcontainers

```
Run Test

↓

Start PostgreSQL Container

↓

Execute Tests

↓

Stop Container
```

Everything is automatic.

---

# Real-World Example

Imagine a laboratory experiment.

Instead of building a permanent lab every time,

scientists create a temporary testing environment.

```
Create Lab

↓

Perform Experiment

↓

Destroy Lab
```

Testcontainers works the same way.

---

# Why Not Use H2 Database?

Many projects use H2 for testing.

```
Application

↓

H2 Database

↓

Fast
```

However,

H2 behaves differently from PostgreSQL or MySQL.

Example

```
Works in H2

↓

Fails in PostgreSQL
```

Testcontainers solves this by using the **actual database engine**.

---

# Testcontainers Architecture

```
JUnit Test

↓

Testcontainers

↓

Docker

↓

PostgreSQL Container

↓

Spring Boot

↓

Repository

↓

Database
```

---

# How Testcontainers Works

```
Start Test

↓

Download Image (First Time)

↓

Create Container

↓

Run Tests

↓

Stop Container

↓

Delete Container
```

No manual cleanup is required.

---

# Prerequisites

Before using Testcontainers, you need:

- Java
- Spring Boot
- JUnit 5
- Docker Desktop (or Docker Engine)
- Internet connection (first image download)

---

# Maven Dependency

```xml
<dependency>

    <groupId>

        org.testcontainers

    </groupId>

    <artifactId>

        junit-jupiter

    </artifactId>

    <scope>

        test

    </scope>

</dependency>

<dependency>

    <groupId>

        org.testcontainers

    </groupId>

    <artifactId>

        postgresql

    </artifactId>

    <scope>

        test

    </scope>

</dependency>
```

---

# Basic Example

```java
@Testcontainers
class UserRepositoryTest {

}
```

The annotation enables Testcontainers for the test class.

---

# Creating a PostgreSQL Container

```java
@Testcontainers
class UserRepositoryTest {

    @Container
    static PostgreSQLContainer<?> postgres =

            new PostgreSQLContainer<>("postgres:17")

                    .withDatabaseName("testdb")

                    .withUsername("postgres")

                    .withPassword("postgres");

}
```

Flow

```
JUnit

↓

PostgreSQL Container

↓

Database Ready

↓

Run Tests
```

---

# Connecting Spring Boot

Spring Boot needs the container details.

Example

```java
@DynamicPropertySource
static void configure(

        DynamicPropertyRegistry registry

){

    registry.add(

            "spring.datasource.url",

            postgres::getJdbcUrl

    );

    registry.add(

            "spring.datasource.username",

            postgres::getUsername

    );

    registry.add(

            "spring.datasource.password",

            postgres::getPassword

    );

}
```

Now Spring Boot automatically connects to the container database.

---

# Repository Test Example

```java
@SpringBootTest

@Testcontainers
class UserRepositoryTest {

    @Autowired
    private UserRepository repository;

    @Test
    void testSave() {

        User user = new User();

        user.setName("Yash");

        User saved = repository.save(user);

        assertNotNull(saved.getId());

    }

}
```

Flow

```
Save User

↓

Repository

↓

PostgreSQL Container

↓

Data Stored

↓

Assertion Passed
```

---

# Container Lifecycle

```
Start Test

↓

Create Docker Container

↓

Run Test

↓

Stop Container

↓

Delete Container
```

Every test gets a clean environment.

---

# Supported Databases

Testcontainers supports many technologies.

Examples

- PostgreSQL
- MySQL
- MariaDB
- Oracle
- SQL Server
- MongoDB
- Redis
- Kafka
- RabbitMQ
- Elasticsearch

---

# Testcontainers Flow

```
JUnit

↓

Docker

↓

Create Container

↓

Spring Boot Connects

↓

Execute Test

↓

Container Removed
```

---

# Testcontainers vs H2

| Testcontainers | H2 |
|----------------|----|
| Real database | In-memory database |
| Production-like behavior | Different behavior from production |
| Requires Docker | No Docker required |
| More reliable | Faster but less realistic |

---

# Testcontainers vs Mockito

| Testcontainers | Mockito |
|----------------|----------|
| Uses real database | Uses fake objects |
| Integration Testing | Unit Testing |
| Slower | Faster |
| Tests complete flow | Tests isolated classes |

---

# Testcontainers vs Embedded Database

| Testcontainers | Embedded Database |
|----------------|-------------------|
| Real database engine | Lightweight in-memory database |
| Production-like | Mainly for simple tests |
| Requires Docker | No Docker needed |

---

# Common Annotations

| Annotation | Purpose |
|------------|----------|
| `@Testcontainers` | Enables Testcontainers |
| `@Container` | Declares a Docker container |
| `@SpringBootTest` | Loads Spring Boot application |
| `@DynamicPropertySource` | Passes container properties to Spring |

---

# Common Mistakes

❌ Docker is not running.

❌ Wrong Docker image name.

❌ Forgetting `@Testcontainers`.

❌ Forgetting `@Container`.

❌ Hardcoding database URLs instead of using container properties.

---

# Real-World Example

## Banking Application

```
Transfer Money Test

↓

PostgreSQL Container

↓

Verify Database Update
```

---

## E-Commerce Website

```
Create Order

↓

MySQL Container

↓

Verify Order Saved
```

---

## Food Delivery App

```
Place Order

↓

PostgreSQL Container

↓

Verify Order Stored
```

---

# Advantages

- Uses real databases.
- Provides production-like testing.
- No manual database installation.
- Clean environment for every test.
- Works well in CI/CD pipelines.
- Supports many databases and messaging systems.

---

# Best Practices

- Use Testcontainers for Integration Tests.
- Keep Docker running before executing tests.
- Prefer the same database engine used in production.
- Avoid sharing containers between unrelated tests.
- Use `@DynamicPropertySource` to configure Spring Boot.
- Combine Testcontainers with `@SpringBootTest`.

---

# Interview Questions

### 1. What is Testcontainers?

Testcontainers is a Java library that starts temporary Docker containers for automated testing.

---

### 2. Why use Testcontainers instead of H2?

Because it uses the same database engine as production, reducing environment-specific issues.

---

### 3. Which annotation enables Testcontainers?

```java
@Testcontainers
```

---

### 4. What does `@Container` do?

It marks a Docker container that will be managed automatically during the test.

---

### 5. Why is `@DynamicPropertySource` used?

It provides Spring Boot with the container's JDBC URL, username, and password at runtime.

---

### 6. Does Testcontainers require Docker?

Yes.

Docker must be installed and running.

---

### 7. Is Testcontainers mainly used for Unit Testing or Integration Testing?

It is mainly used for **Integration Testing**, where real databases and external services are required.

---

# Quick Revision

- Testcontainers runs real Docker containers during tests.
- It is mainly used for Integration Testing.
- Supports PostgreSQL, MySQL, MongoDB, Redis, Kafka, RabbitMQ, and more.
- `@Testcontainers` enables Testcontainers.
- `@Container` declares the Docker container.
- `@DynamicPropertySource` connects Spring Boot to the container.
- Docker must be running before executing tests.
- Testcontainers provides production-like, reliable testing environments.