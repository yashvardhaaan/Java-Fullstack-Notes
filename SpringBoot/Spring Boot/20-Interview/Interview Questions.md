# Spring Boot Interview Questions (With Answers)

## 1. What is Spring Boot?

**Answer:**

Spring Boot is a framework built on top of the Spring Framework that simplifies Java application development by providing:

- Auto Configuration
- Embedded Servers
- Starter Dependencies
- Production-ready Features

It helps developers build applications quickly with minimal configuration.

---

## 2. What are the advantages of Spring Boot?

**Answer:**

- Rapid Development
- Auto Configuration
- Embedded Tomcat/Jetty
- Minimal XML Configuration
- Production Ready
- Easy Dependency Management
- Microservices Friendly

---

## 3. What is Auto Configuration?

**Answer:**

Auto Configuration automatically configures Spring Beans based on the dependencies present in the project.

Example:

If `spring-boot-starter-data-jpa` is added, Spring Boot automatically configures:

- DataSource
- EntityManager
- Hibernate
- Transaction Manager

---

## 4. What is Dependency Injection?

**Answer:**

Dependency Injection (DI) is a design pattern where Spring creates and injects required objects instead of the developer creating them manually.

Example:

```java
@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

}
```

---

## 5. What is Inversion of Control (IoC)?

**Answer:**

IoC means Spring manages the creation and lifecycle of objects instead of the application creating them.

```
Application

↓

Spring Container

↓

Creates Beans

↓

Injects Dependencies
```

---

## 6. What is a Spring Bean?

**Answer:**

A Spring Bean is an object that is created, managed, and destroyed by the Spring IoC Container.

Common annotations:

- `@Component`
- `@Service`
- `@Repository`
- `@Controller`

---

## 7. What is the difference between `@Component`, `@Service`, and `@Repository`?

**Answer:**

| Annotation | Purpose |
|------------|----------|
| `@Component` | Generic Spring Bean |
| `@Service` | Business Logic |
| `@Repository` | Database Access |

Functionally they are all Spring Beans, but each represents a different application layer.

---

## 8. What is the difference between `@Controller` and `@RestController`?

**Answer:**

| @Controller | @RestController |
|-------------|-----------------|
| Returns Views | Returns JSON/XML |
| Used in MVC | Used for REST APIs |

`@RestController` = `@Controller` + `@ResponseBody`

---

## 9. Explain Spring Boot Architecture.

**Answer:**

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

- Controller → Handles HTTP requests
- Service → Business logic
- Repository → Database operations

---

## 10. What is a DTO?

**Answer:**

DTO (Data Transfer Object) is used to transfer data between the client and server without exposing Entity objects.

Benefits:

- Security
- Cleaner APIs
- API Versioning
- Better Maintainability

---

## 11. Why should we not return Entity objects?

**Answer:**

Because Entities:

- Expose database structure
- May expose sensitive fields
- Increase coupling between API and database

Instead, return DTOs.

---

## 12. What is `JpaRepository`?

**Answer:**

`JpaRepository` is a Spring Data JPA interface that provides built-in CRUD operations.

Example:

```java
public interface UserRepository
        extends JpaRepository<User, Long> {

}
```

---

## 13. What is Hibernate?

**Answer:**

Hibernate is an ORM (Object Relational Mapping) framework that converts Java Objects into database records and vice versa.

---

## 14. What is ORM?

**Answer:**

ORM maps Java classes to database tables.

Example:

```
User.java

↓

Hibernate

↓

users Table
```

---

## 15. What is the difference between JPA and Hibernate?

**Answer:**

| JPA | Hibernate |
|-----|-----------|
| Specification | Implementation |
| Defines rules | Implements rules |
| Vendor Independent | Hibernate Specific |

---

## 16. What is `@Transactional`?

**Answer:**

`@Transactional` ensures that multiple database operations execute as a single unit.

If one operation fails,

everything rolls back.

---

## 17. What are ACID properties?

**Answer:**

- **Atomicity** → All or Nothing
- **Consistency** → Valid Data
- **Isolation** → Transactions don't interfere
- **Durability** → Data survives after commit

---

## 18. What is Lazy Loading?

**Answer:**

Lazy Loading loads related data only when it is actually needed.

Improves performance by avoiding unnecessary database queries.

---

## 19. What is Eager Loading?

**Answer:**

Eager Loading loads related data immediately when the parent entity is fetched.

Useful when related data is always required.

---

## 20. What is the N+1 Query Problem?

**Answer:**

It occurs when one query fetches parent records and additional queries fetch each child record individually.

Example:

```
1 Query

↓

100 Users

↓

100 More Queries

↓

101 Total Queries
```

Avoid using:

- Fetch Join
- Entity Graph
- DTO Projection

---

## 21. What is HikariCP?

**Answer:**

HikariCP is Spring Boot's default connection pool.

It improves performance by reusing database connections.

---

## 22. What is Bean Validation?

**Answer:**

Bean Validation validates user input using annotations.

Example:

```java
@NotBlank

@Email

@Size
```

---

## 23. What is `@RestControllerAdvice`?

**Answer:**

It provides centralized exception handling for all REST Controllers.

Example:

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

}
```

---

## 24. What is Spring Security?

**Answer:**

Spring Security is used for:

- Authentication
- Authorization
- Password Encryption
- JWT
- OAuth2

---

## 25. Authentication vs Authorization?

**Answer:**

| Authentication | Authorization |
|---------------|---------------|
| Who are you? | What can you access? |
| Login | Permissions |

---

## 26. What is JWT?

**Answer:**

JWT (JSON Web Token) is a secure token used for stateless authentication.

Flow:

```
Login

↓

Generate JWT

↓

Client Stores Token

↓

Send Token

↓

Access API
```

---

## 27. What is the default server in Spring Boot?

**Answer:**

**Apache Tomcat**

Embedded Tomcat is included automatically with `spring-boot-starter-web`.

---

## 28. What is OpenFeign?

**Answer:**

OpenFeign is a declarative HTTP client used for communication between microservices using interfaces.

---

## 29. What is WebClient?

**Answer:**

WebClient is Spring's modern HTTP client.

Features:

- Reactive
- Non-blocking
- High Performance

Recommended over RestTemplate for new applications.

---

## 30. Why is Constructor Injection preferred?

**Answer:**

Because it:

- Supports immutability
- Makes dependencies explicit
- Improves unit testing
- Avoids NullPointerExceptions

---

## 31. What is the difference between `@Component` and `@Bean`?

**Answer:**

| @Component | @Bean |
|------------|--------|
| Applied on Class | Applied on Method |
| Component Scanning | Manual Bean Creation |
| Used for your own classes | Used for third-party classes or custom configuration |

---

## 32. What is the difference between `findById()` and `getReferenceById()`?

**Answer:**

| findById() | getReferenceById() |
|------------|--------------------|
| Queries database immediately | Returns a lazy proxy |
| Returns `Optional<T>` | Returns entity reference |
| Safer for reads | Useful when only a reference is needed |

---

## 33. What is Caching?

**Answer:**

Caching stores frequently accessed data in memory to reduce database calls and improve performance.

Spring provides:

- `@Cacheable`
- `@CachePut`
- `@CacheEvict`

---

## 34. What is API Versioning?

**Answer:**

API Versioning allows multiple versions of an API to exist without breaking existing clients.

Example:

```
/api/v1/users

/api/v2/users
```

---

## 35. What are Spring Boot Starters?

**Answer:**

Starter dependencies are preconfigured dependency bundles.

Examples:

- `spring-boot-starter-web`
- `spring-boot-starter-data-jpa`
- `spring-boot-starter-security`
- `spring-boot-starter-validation`

---

# Quick Revision

- Spring Boot simplifies Spring development.
- IoC manages object creation.
- DI injects required dependencies.
- Controllers handle requests.
- Services contain business logic.
- Repositories interact with the database.
- DTOs should be used instead of Entities.
- JPA is the specification; Hibernate is its implementation.
- `@Transactional` ensures atomic database operations.
- HikariCP manages database connections.
- Spring Security handles authentication and authorization.
- WebClient is preferred over RestTemplate for new applications.
- OpenFeign simplifies communication between microservices.