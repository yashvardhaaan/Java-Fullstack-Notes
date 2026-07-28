# WebClient

## What is WebClient?

**WebClient** is Spring's modern HTTP client used to communicate with REST APIs.

It is part of **Spring WebFlux** and supports both:

- Synchronous communication
- Asynchronous communication
- Reactive programming
- Non-blocking I/O

> **In simple words:**
>
> WebClient is the modern replacement for `RestTemplate` and is recommended for new Spring Boot applications.

---

# Why Do We Need WebClient?

Imagine an application that calls multiple external services.

Without WebClient

```
Request

↓

Wait for Response

↓

Next Request

↓

Wait Again

↓

Slow
```

The thread remains blocked while waiting.

---

With WebClient

```
Request

↓

Continue Processing

↓

Response Arrives

↓

Process Response
```

The thread is not blocked while waiting.

---

# Real-World Example

Imagine ordering food online.

Blocking Approach

```
Order

↓

Stand at Counter

↓

Wait

↓

Food Ready
```

You cannot do anything else.

---

Non-Blocking Approach

```
Order

↓

Get Token

↓

Sit Anywhere

↓

Food Ready Notification
```

You are free while waiting.

WebClient works in the same way.

---

# WebClient Architecture

```
Client

↓

Spring Boot

↓

WebClient

↓

External API

↓

JSON Response

↓

Application
```

---

# How WebClient Works

```
Create Request

↓

Send Request

↓

Continue Execution

↓

Response Arrives

↓

Process Response
```

---

# Required Dependency

For Spring Boot WebFlux

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-webflux</artifactId>
</dependency>
```

---

# Creating WebClient

```java
WebClient client =

        WebClient.create(

                "http://localhost:8081"

        );
```

---

# Using WebClient Bean

```java
@Configuration
public class AppConfig {

    @Bean
    public WebClient webClient(){

        return WebClient.builder()

                .baseUrl("http://localhost:8081")

                .build();

    }

}
```

---

# GET Request Example

```java
UserResponse response =

        webClient

                .get()

                .uri("/users/1")

                .retrieve()

                .bodyToMono(UserResponse.class)

                .block();
```

---

# POST Request Example

```java
UserResponse response =

        webClient

                .post()

                .uri("/users")

                .bodyValue(request)

                .retrieve()

                .bodyToMono(UserResponse.class)

                .block();
```

---

# PUT Request Example

```java
webClient

        .put()

        .uri("/users/1")

        .bodyValue(request)

        .retrieve()

        .bodyToMono(Void.class)

        .block();
```

---

# DELETE Request Example

```java
webClient

        .delete()

        .uri("/users/1")

        .retrieve()

        .bodyToMono(Void.class)

        .block();
```

---

# Understanding Mono and Flux

WebClient uses Reactive Streams.

## Mono

Represents **0 or 1 value**.

```
User

↓

Mono<User>
```

Example

```java
Mono<UserResponse>
```

---

## Flux

Represents **0 to many values**.

```
Users

↓

Flux<User>
```

Example

```java
Flux<UserResponse>
```

---

# Request Flow

```
Application

↓

WebClient

↓

HTTP Request

↓

REST API

↓

JSON Response

↓

Mono / Flux

↓

Application
```

---

# Sending Headers

```java
webClient

        .get()

        .uri("/users")

        .header(

                "Authorization",

                "Bearer TOKEN"

        );
```

---

# Error Handling

```java
webClient

        .get()

        .uri("/users")

        .retrieve()

        .onStatus(

                HttpStatusCode::isError,

                response -> Mono.error(

                        new RuntimeException(

                                "API Error"

                        )

                )

        );
```

---

# Timeout

```java
webClient

        .get()

        .uri("/users")

        .retrieve()

        .bodyToMono(UserResponse.class)

        .timeout(

                Duration.ofSeconds(5)

        );
```

---

# Blocking vs Non-Blocking

Blocking

```
Request

↓

Wait

↓

Response

↓

Continue
```

---

Non-Blocking

```
Request

↓

Continue Working

↓

Response Arrives

↓

Process Response
```

---

# WebClient vs RestTemplate

| WebClient | RestTemplate |
|------------|--------------|
| Modern | Legacy |
| Reactive | Blocking |
| Non-Blocking | Blocking |
| Better Scalability | Lower Scalability |
| Recommended | Maintenance Mode |

---

# WebClient vs OpenFeign

| WebClient | OpenFeign |
|------------|-----------|
| Fluent API | Interface-based |
| Reactive Support | Blocking by Default |
| More Flexible | Less Boilerplate |
| Best for Reactive Apps | Best for Traditional Microservices |

---

# Common Use Cases

- External REST APIs
- Microservices Communication
- Payment Gateway Integration
- Weather Services
- Authentication Services
- Notification Services

---

# Advantages

- Non-blocking communication.
- High performance.
- Better scalability.
- Reactive programming support.
- Recommended for new Spring Boot projects.

---

# Disadvantages

- Slightly steeper learning curve.
- Reactive programming concepts are required.
- Can be unnecessarily complex for very simple applications.

---

# Best Practices

- Prefer WebClient over RestTemplate for new projects.
- Configure connection and read timeouts.
- Handle HTTP errors properly.
- Use `Mono` for single responses and `Flux` for multiple responses.
- Avoid calling `.block()` in fully reactive applications.
- Reuse a configured `WebClient` bean instead of creating new instances.

---

# Common Mistakes

❌ Creating a new WebClient instance for every request.

❌ Ignoring timeout configuration.

❌ Not handling API errors.

❌ Calling `.block()` everywhere in reactive applications.

❌ Returning Entity objects instead of DTOs.

---

# Real-World Example

## Banking Application

```
Banking App

↓

WebClient

↓

Payment Service

↓

Payment Status
```

---

## E-Commerce Website

```
Order Service

↓

WebClient

↓

Inventory Service

↓

Stock Details
```

---

## Food Delivery App

```
Order Service

↓

WebClient

↓

Maps API

↓

Route Details
```

---

# Interview Questions

### 1. What is WebClient?

WebClient is Spring's modern HTTP client used to communicate with REST APIs using both blocking and non-blocking approaches.

---

### 2. Which Spring module provides WebClient?

**Spring WebFlux**

---

### 3. Why is WebClient preferred over RestTemplate?

Because it supports non-blocking I/O, reactive programming, and offers better scalability for modern applications.

---

### 4. What is `Mono`?

`Mono` represents **zero or one** result.

---

### 5. What is `Flux`?

`Flux` represents **zero to many** results.

---

### 6. Is WebClient synchronous or asynchronous?

It is designed for **asynchronous, non-blocking** communication, though `.block()` can be used to wait synchronously when needed.

---

### 7. When should WebClient be used?

Use WebClient for new Spring Boot projects, reactive applications, and applications that require high concurrency or communicate with multiple external services.

---

# Quick Revision

- WebClient is the modern replacement for `RestTemplate`.
- It is part of **Spring WebFlux**.
- Supports reactive and non-blocking communication.
- Uses `Mono` (single result) and `Flux` (multiple results).
- Preferred for new Spring Boot applications.
- Configure timeouts and handle errors properly.
- Avoid unnecessary `.block()` calls in reactive applications.