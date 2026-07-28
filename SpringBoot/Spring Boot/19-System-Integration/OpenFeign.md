# OpenFeign

## What is OpenFeign?

**OpenFeign** is a **declarative HTTP client** used in Spring Boot to communicate with other REST APIs.

Instead of writing HTTP request code manually, you simply define an interface, and Spring generates the implementation automatically.

> **In simple words:**
>
> OpenFeign lets you call another REST API just like calling a Java method.

---

# Why Do We Need OpenFeign?

Imagine a Microservices application.

```
Order Service

↓

Needs Customer Details

↓

Customer Service
```

Without OpenFeign

```
Create HTTP Request

↓

Set Headers

↓

Handle Response

↓

Convert JSON

↓

Return Data
```

Lots of boilerplate code.

---

With OpenFeign

```
Call Java Method

↓

OpenFeign

↓

HTTP Request

↓

Customer Service
```

Simple and clean.

---

# Real-World Example

Imagine calling your friend.

Without OpenFeign

```
Dial Number

↓

Wait

↓

Connect

↓

Talk
```

Lots of manual work.

---

With OpenFeign

```
Call Friend

↓

Phone Handles Everything
```

OpenFeign hides all the HTTP communication.

---

# OpenFeign Architecture

```
Order Service

↓

Feign Client

↓

HTTP Request

↓

Customer Service

↓

JSON Response

↓

Order Service
```

---

# How OpenFeign Works

```
Application

↓

Feign Interface

↓

Spring Creates Implementation

↓

HTTP Request

↓

Response
```

---

# Required Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

---

# Enable OpenFeign

```java
@SpringBootApplication
@EnableFeignClients
public class OrderApplication {

}
```

Spring scans and creates all Feign clients automatically.

---

# Creating a Feign Client

```java
@FeignClient(

        name = "customer-service",

        url = "http://localhost:8081"

)
public interface CustomerClient {

    @GetMapping("/customers/{id}")
    CustomerDto getCustomer(

            @PathVariable Long id

    );

}
```

---

# Using the Feign Client

```java
@Service
public class OrderService {

    private final CustomerClient customerClient;

    public OrderService(

            CustomerClient customerClient

    ){

        this.customerClient = customerClient;

    }

    public CustomerDto getCustomer(

            Long id

    ){

        return customerClient.getCustomer(id);

    }

}
```

---

# Request Flow

```
Client

↓

Order Service

↓

Feign Client

↓

Customer Service

↓

Response

↓

Order Service

↓

Client
```

---

# Passing Path Variables

```java
@GetMapping("/users/{id}")
UserDto getUser(

        @PathVariable Long id

);
```

---

# Passing Request Parameters

```java
@GetMapping("/users")
List<UserDto> getUsers(

        @RequestParam String city

);
```

---

# Sending Request Body

```java
@PostMapping("/users")
UserDto createUser(

        @RequestBody UserRequest request

);
```

---

# Sending Headers

```java
@GetMapping("/users")
UserDto getUser(

        @RequestHeader("Authorization")

        String token

);
```

---

# Error Handling

If another service returns an error,

```
Feign Client

↓

404

↓

Exception
```

You can implement a custom error decoder or fallback mechanism.

---

# Timeout Configuration

```properties
spring.cloud.openfeign.client.config.default.connectTimeout=5000

spring.cloud.openfeign.client.config.default.readTimeout=10000
```

This prevents requests from waiting forever.

---

# Logging

```properties
logging.level.org.springframework.cloud.openfeign=DEBUG
```

Useful during development and debugging.

---

# OpenFeign Lifecycle

```
Create Request

↓

Feign Client

↓

HTTP Request

↓

Remote Service

↓

JSON Response

↓

Java Object
```

---

# OpenFeign vs RestTemplate

| OpenFeign | RestTemplate |
|------------|--------------|
| Declarative | Imperative |
| Less code | More code |
| Interface-based | Object-based |
| Cleaner | More boilerplate |
| Preferred in Microservices | Legacy approach |

---

# OpenFeign vs WebClient

| OpenFeign | WebClient |
|------------|-----------|
| Blocking | Supports Reactive & Non-Blocking |
| Interface-based | Fluent API |
| Best for Microservices | Best for Reactive Applications |

---

# Common Use Cases

- Microservices Communication
- User Service
- Payment Service
- Inventory Service
- Notification Service
- Customer Service

---

# Advantages

- Minimal boilerplate code.
- Easy to read and maintain.
- Automatic JSON serialization.
- Spring Cloud integration.
- Easy integration with service discovery.

---

# Disadvantages

- Blocking by default.
- Additional dependency required.
- Not ideal for reactive applications.
- Depends on network availability.

---

# Best Practices

- Keep Feign clients focused on one service.
- Configure connection and read timeouts.
- Handle failures gracefully using fallbacks or retries.
- Use DTOs instead of exposing entities.
- Secure API calls with authentication headers.
- Log requests carefully without exposing sensitive data.

---

# Common Mistakes

❌ Calling unavailable services without timeout configuration.

❌ Returning Entity objects instead of DTOs.

❌ Hardcoding service URLs in production.

❌ Ignoring exception handling.

❌ Creating one Feign client for multiple unrelated services.

---

# Real-World Example

## Banking Application

```
Transaction Service

↓

Feign

↓

Account Service

↓

Account Details
```

---

## E-Commerce Website

```
Order Service

↓

Feign

↓

Inventory Service

↓

Stock Available
```

---

## Food Delivery App

```
Order Service

↓

Feign

↓

Restaurant Service

↓

Restaurant Details
```

---

# Interview Questions

### 1. What is OpenFeign?

OpenFeign is a declarative HTTP client that simplifies communication between Spring Boot applications and external REST APIs.

---

### 2. Which annotation enables OpenFeign?

```java
@EnableFeignClients
```

---

### 3. Which annotation defines a Feign client?

```java
@FeignClient
```

---

### 4. Why is OpenFeign preferred in Microservices?

Because it reduces boilerplate code and allows developers to call remote services using simple Java interfaces.

---

### 5. Is OpenFeign synchronous or asynchronous?

By default, OpenFeign performs **blocking (synchronous)** HTTP calls.

---

### 6. Can OpenFeign send request headers and request bodies?

Yes. It supports `@RequestHeader`, `@RequestBody`, `@PathVariable`, and `@RequestParam`.

---

### 7. What is the difference between OpenFeign and RestTemplate?

OpenFeign is interface-based and declarative, while RestTemplate requires manually writing HTTP request logic.

---

# Quick Revision

- OpenFeign is a declarative HTTP client.
- Enable it using `@EnableFeignClients`.
- Define clients using `@FeignClient`.
- Supports GET, POST, PUT, DELETE, headers, parameters, and request bodies.
- Commonly used for Microservices communication.
- Configure timeouts and error handling.
- Prefer DTOs and secure communication in production.