# REST Client

## What is a REST Client?

A **REST Client** is a component used to **send HTTP requests** from one application to another REST API.

It allows a Spring Boot application to:

- Call external APIs
- Communicate with microservices
- Consume REST services
- Exchange JSON data

> **In simple words:**
>
> A REST Client is used when your application wants to talk to another application over HTTP.

---

# Why Do We Need a REST Client?

Imagine an e-commerce application.

```
Customer Places Order

↓

Need Payment Status

↓

Payment Service
```

Without a REST Client

```
Order Service

↓

Cannot Communicate

↓

No Payment Information
```

---

With REST Client

```
Order Service

↓

HTTP Request

↓

Payment Service

↓

Response
```

Applications can communicate easily.

---

# Real-World Example

Imagine calling customer support.

```
You

↓

Phone Call

↓

Customer Support

↓

Answer
```

Similarly,

```
Application

↓

REST Client

↓

Another Application

↓

Response
```

---

# REST Client Architecture

```
Client

↓

Spring Boot Application

↓

REST Client

↓

REST API

↓

JSON Response

↓

Application
```

---

# How REST Client Works

```
Create HTTP Request

↓

Send Request

↓

Remote Server

↓

JSON Response

↓

Convert to Java Object
```

---

# Common REST Clients in Spring

- RestTemplate (Legacy)
- WebClient (Modern)
- OpenFeign (Microservices)

---

# HTTP Methods

REST Clients support:

| Method | Purpose |
|----------|----------|
| GET | Fetch Data |
| POST | Create Data |
| PUT | Update Data |
| PATCH | Partial Update |
| DELETE | Delete Data |

---

# GET Request Example

```java
RestTemplate restTemplate =

        new RestTemplate();

String response =

        restTemplate.getForObject(

                "http://localhost:8081/users/1",

                String.class

        );
```

---

# POST Request Example

```java
UserRequest request =

        new UserRequest();

UserResponse response =

        restTemplate.postForObject(

                "http://localhost:8081/users",

                request,

                UserResponse.class

        );
```

---

# PUT Request Example

```java
restTemplate.put(

        "http://localhost:8081/users/1",

        request

);
```

---

# DELETE Request Example

```java
restTemplate.delete(

        "http://localhost:8081/users/1"

);
```

---

# Request Flow

```
Application

↓

REST Client

↓

HTTP Request

↓

Remote Server

↓

HTTP Response

↓

Java Object
```

---

# JSON Conversion

Response

```json
{
    "id": 1,
    "name": "John"
}
```

↓

Spring Boot

↓

```java
UserResponse
```

Spring automatically converts JSON into Java objects.

---

# Sending Headers

```java
HttpHeaders headers =

        new HttpHeaders();

headers.setBearerAuth(token);
```

Common headers

- Authorization
- Content-Type
- Accept

---

# Request Entity

```java
HttpEntity<UserRequest> entity =

        new HttpEntity<>(

                request,

                headers

        );
```

Allows sending:

- Headers
- Request Body

Together.

---

# Response Entity

```java
ResponseEntity<UserResponse> response =

        restTemplate.exchange(

                url,

                HttpMethod.GET,

                entity,

                UserResponse.class

        );
```

Provides

- Status Code
- Headers
- Body

---

# Error Handling

Possible responses

| Status | Meaning |
|---------|----------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 404 | Not Found |
| 500 | Internal Server Error |

Always handle failures gracefully.

---

# Timeout

```
REST Client

↓

Waiting...

↓

Timeout

↓

Exception
```

Configure connection and read timeouts to avoid hanging requests.

---

# REST Client Lifecycle

```
Create Request

↓

Send HTTP Request

↓

Receive Response

↓

Convert JSON

↓

Return Java Object
```

---

# REST Client vs OpenFeign

| REST Client | OpenFeign |
|--------------|-----------|
| Manual HTTP calls | Interface-based |
| More boilerplate | Less boilerplate |
| Greater control | Easier to maintain |
| Suitable for general HTTP calls | Best for Microservices |

---

# REST Client vs WebClient

| REST Client (RestTemplate) | WebClient |
|----------------------------|-----------|
| Blocking | Reactive & Non-Blocking |
| Simple | High-performance |
| Legacy | Recommended for new applications |

---

# Common Use Cases

- Payment Gateway Integration
- Weather APIs
- Maps API
- Authentication Services
- Currency Exchange
- Internal Microservices

---

# Advantages

- Easy communication between applications.
- Supports all HTTP methods.
- Automatic JSON conversion.
- Supports headers and authentication.
- Simple integration with REST APIs.

---

# Disadvantages

- `RestTemplate` is in maintenance mode.
- Blocking requests can reduce scalability.
- Requires proper timeout configuration.
- Network failures must be handled.

---

# Best Practices

- Prefer **WebClient** for new Spring Boot applications.
- Use **OpenFeign** for Microservices communication.
- Configure connection and read timeouts.
- Handle HTTP errors gracefully.
- Use DTOs instead of exposing entities.
- Secure API calls with HTTPS and authentication.

---

# Common Mistakes

❌ Ignoring timeout configuration.

❌ Not handling HTTP errors.

❌ Returning Entity objects instead of DTOs.

❌ Hardcoding API URLs.

❌ Using `RestTemplate` for new reactive applications.

---

# Real-World Example

## Banking Application

```
Banking App

↓

REST Client

↓

Payment Gateway

↓

Payment Status
```

---

## E-Commerce Website

```
Order Service

↓

REST Client

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

REST Client

↓

Maps API

↓

Route Information
```

---

# Interview Questions

### 1. What is a REST Client?

A REST Client is a component used to send HTTP requests from one application to another REST API.

---

### 2. Which REST Clients are available in Spring Boot?

- RestTemplate
- WebClient
- OpenFeign

---

### 3. Is `RestTemplate` recommended for new projects?

No. `RestTemplate` is in maintenance mode. **WebClient** is recommended for new applications.

---

### 4. What is `ResponseEntity`?

`ResponseEntity` represents the complete HTTP response, including the status code, headers, and response body.

---

### 5. Why should timeouts be configured?

To prevent the application from waiting indefinitely for a slow or unavailable service.

---

### 6. What data format is commonly exchanged using REST Clients?

JSON.

---

### 7. When should OpenFeign be preferred over RestTemplate?

OpenFeign is preferred in Microservices because it reduces boilerplate code through interface-based API calls.

---

# Quick Revision

- REST Clients communicate with REST APIs over HTTP.
- Common clients are RestTemplate, WebClient, and OpenFeign.
- RestTemplate is legacy; WebClient is recommended for new projects.
- Supports GET, POST, PUT, PATCH, and DELETE.
- Use `ResponseEntity` for full HTTP responses.
- Configure timeouts and handle errors properly.
- Secure requests using HTTPS and authentication.