# Spring Boot Cheat Sheet

## Spring Boot Architecture

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

---

# Common Annotations

## Spring Core

| Annotation | Purpose |
|------------|----------|
| `@SpringBootApplication` | Main Spring Boot application |
| `@Component` | Generic Spring Bean |
| `@Service` | Business Logic |
| `@Repository` | Database Layer |
| `@Controller` | MVC Controller |
| `@RestController` | REST API Controller |
| `@Configuration` | Configuration Class |
| `@Bean` | Creates Spring Bean |

---

## Dependency Injection

| Annotation | Purpose |
|------------|----------|
| `@Autowired` | Inject Dependency |
| Constructor Injection | Recommended Dependency Injection |

---

## REST API

| Annotation | Purpose |
|------------|----------|
| `@RequestMapping` | Base URL |
| `@GetMapping` | GET API |
| `@PostMapping` | POST API |
| `@PutMapping` | PUT API |
| `@PatchMapping` | PATCH API |
| `@DeleteMapping` | DELETE API |
| `@RequestBody` | Read Request Body |
| `@RequestParam` | Query Parameter |
| `@PathVariable` | URL Variable |
| `@RequestHeader` | HTTP Header |

---

## Validation

| Annotation | Purpose |
|------------|----------|
| `@Valid` | Trigger Validation |
| `@NotNull` | Cannot be Null |
| `@NotBlank` | Cannot be Blank |
| `@NotEmpty` | Cannot be Empty |
| `@Size` | Length Validation |
| `@Email` | Valid Email |
| `@Min` | Minimum Value |
| `@Max` | Maximum Value |
| `@Pattern` | Regex Validation |

---

## JPA

| Annotation | Purpose |
|------------|----------|
| `@Entity` | Database Table |
| `@Table` | Table Name |
| `@Id` | Primary Key |
| `@GeneratedValue` | Auto Generate ID |
| `@Column` | Column Mapping |
| `@OneToOne` | One-to-One |
| `@OneToMany` | One-to-Many |
| `@ManyToOne` | Many-to-One |
| `@ManyToMany` | Many-to-Many |
| `@JoinColumn` | Foreign Key |
| `@Version` | Optimistic Locking |

---

## Transactions

| Annotation | Purpose |
|------------|----------|
| `@Transactional` | Database Transaction |

---

## Exception Handling

| Annotation | Purpose |
|------------|----------|
| `@RestControllerAdvice` | Global Exception Handler |
| `@ExceptionHandler` | Handle Specific Exception |

---

## Security

| Annotation | Purpose |
|------------|----------|
| `@EnableWebSecurity` | Enable Spring Security |
| `@PreAuthorize` | Method Authorization |
| `@Secured` | Role-Based Security |

---

## Scheduling

| Annotation | Purpose |
|------------|----------|
| `@EnableScheduling` | Enable Scheduler |
| `@Scheduled` | Schedule Tasks |

---

## Async

| Annotation | Purpose |
|------------|----------|
| `@EnableAsync` | Enable Async |
| `@Async` | Execute in Background |

---

## Caching

| Annotation | Purpose |
|------------|----------|
| `@EnableCaching` | Enable Cache |
| `@Cacheable` | Read Cache |
| `@CachePut` | Update Cache |
| `@CacheEvict` | Remove Cache |

---

## OpenFeign

| Annotation | Purpose |
|------------|----------|
| `@EnableFeignClients` | Enable Feign |
| `@FeignClient` | Create HTTP Client |

---

# HTTP Methods

| Method | Purpose |
|---------|----------|
| GET | Fetch Data |
| POST | Create Data |
| PUT | Update Entire Resource |
| PATCH | Partial Update |
| DELETE | Delete Resource |

---

# HTTP Status Codes

| Code | Meaning |
|------|----------|
| 200 | OK |
| 201 | Created |
| 204 | No Content |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 405 | Method Not Allowed |
| 409 | Conflict |
| 500 | Internal Server Error |
| 503 | Service Unavailable |

---

# Bean Lifecycle

```
Container Starts

↓

Bean Created

↓

Dependency Injection

↓

@PostConstruct

↓

Bean Ready

↓

Application Running

↓

@PreDestroy

↓

Bean Destroyed
```

---

# Request Lifecycle

```
Client

↓

DispatcherServlet

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
```

---

# Spring Boot Starter Dependencies

| Dependency | Purpose |
|------------|----------|
| spring-boot-starter-web | REST APIs |
| spring-boot-starter-data-jpa | Database |
| spring-boot-starter-security | Security |
| spring-boot-starter-validation | Validation |
| spring-boot-starter-test | Testing |
| spring-boot-starter-mail | Email |
| spring-boot-starter-cache | Caching |
| spring-boot-starter-webflux | WebClient |

---

# Common Repository Methods

```java
save()

findById()

findAll()

deleteById()

existsById()

count()

findAll(Pageable)
```

---

# Spring Boot Project Structure

```
src

└── main

    ├── java

    │   └── com.example.project

    │       ├── controller

    │       ├── service

    │       ├── repository

    │       ├── entity

    │       ├── dto

    │       ├── mapper

    │       ├── config

    │       ├── security

    │       ├── exception

    │       └── util

    └── resources

        ├── application.properties

        ├── static

        └── templates
```

---

# Common application.properties

```properties
spring.application.name=my-app

server.port=8080

spring.datasource.url=jdbc:mysql://localhost:3306/demo

spring.datasource.username=root

spring.datasource.password=password

spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=true

spring.jpa.properties.hibernate.format_sql=true
```

---

# Layer Responsibilities

| Layer | Responsibility |
|--------|----------------|
| Controller | Handle HTTP Requests |
| Service | Business Logic |
| Repository | Database Access |
| Entity | Database Mapping |
| DTO | Request & Response Models |
| Mapper | Entity ↔ DTO Conversion |
| Config | Application Configuration |

---

# Common Design Patterns

- Singleton
- Factory
- Builder
- Strategy
- Adapter
- Observer
- Proxy
- Dependency Injection

---

# Common Security Checklist

- Use HTTPS
- Validate Inputs
- Hash Passwords (BCrypt)
- Use JWT/OAuth2
- Never Hardcode Secrets
- Enable CORS Properly
- Use Role-Based Authorization
- Prevent SQL Injection
- Prevent XSS
- Prevent CSRF (where applicable)

---

# Performance Checklist

- Use Connection Pool (HikariCP)
- Create Database Indexes
- Use Pagination
- Avoid N+1 Queries
- Use Lazy Loading Carefully
- Cache Frequently Used Data
- Use Async Processing
- Monitor Application Metrics

---

# Production Checklist

- Logging Enabled
- Global Exception Handling
- Environment Variables
- Health Checks
- Monitoring
- API Versioning
- Validation
- Unit Tests
- Integration Tests
- Secure Secrets
- Docker Support

---

# Common Interview Topics

- Spring Boot Architecture
- IoC & Dependency Injection
- Bean Lifecycle
- REST APIs
- Spring MVC
- Spring Data JPA
- Hibernate
- Transactions
- Spring Security
- JWT Authentication
- Exception Handling
- Validation
- Caching
- Scheduling
- Async Processing
- Microservices
- OpenFeign
- WebClient
- Docker
- Performance Optimization

---

# One-Minute Revision

- Follow Controller → Service → Repository architecture.
- Use constructor injection instead of field injection.
- Use DTOs instead of exposing Entities.
- Validate requests using Bean Validation.
- Handle exceptions globally with `@RestControllerAdvice`.
- Use `@Transactional` for multi-step database operations.
- Secure APIs using Spring Security and JWT.
- Use HikariCP for connection pooling.
- Prefer WebClient for new REST clients.
- Use OpenFeign for Microservices.
- Implement pagination for large datasets.
- Keep Controllers thin and Services focused.
- Log using SLF4J instead of `System.out.println()`.
- Monitor production applications with Actuator and Micrometer.