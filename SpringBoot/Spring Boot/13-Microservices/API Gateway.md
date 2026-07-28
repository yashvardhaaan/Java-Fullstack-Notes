# API Gateway

## What is an API Gateway?

An **API Gateway** is a **single entry point** for all client requests in a microservices architecture.

Instead of clients calling individual microservices directly, they send requests to the API Gateway, which routes them to the appropriate service.

> **In simple words:**
>
> Think of an API Gateway as a receptionist in an office. Visitors talk only to the receptionist, who then directs them to the correct department.

---

# Why Do We Need an API Gateway?

Without API Gateway

```
Client

├── User Service

├── Order Service

├── Payment Service

├── Inventory Service

└── Notification Service
```

Problems

- Client must know every service URL.
- Multiple network requests.
- Authentication repeated in every service.
- Difficult to manage.

---

With API Gateway

```
Client

↓

API Gateway

↓

User Service

Order Service

Payment Service

Inventory Service

Notification Service
```

The client communicates with only one endpoint.

---

# Real-World Example

Consider an E-Commerce application.

When a customer opens the mobile app:

```
Customer

↓

API Gateway

↓

User Service

↓

Product Service

↓

Cart Service

↓

Order Service
```

The customer doesn't know where each service is located.

---

# API Gateway Architecture

```
                Client
                   │
                   ▼
          +----------------+
          |  API Gateway   |
          +----------------+
           │      │      │
           ▼      ▼      ▼
      User     Order   Payment
     Service   Service  Service
```

---

# Responsibilities of API Gateway

- Request Routing
- Authentication
- Authorization
- SSL Termination
- Load Balancing
- Rate Limiting
- Logging
- Monitoring
- Request Filtering
- Response Aggregation

---

# Request Flow

```
Client

↓

API Gateway

↓

Authentication

↓

Route Request

↓

Microservice

↓

Response

↓

Client
```

---

# How API Gateway Works

```
Client

↓

GET /orders/101

↓

API Gateway

↓

Order Service

↓

Database

↓

Response

↓

API Gateway

↓

Client
```

---

# Benefits

## Single Entry Point

```
Client

↓

API Gateway

↓

All Services
```

Only one endpoint is exposed.

---

## Centralized Authentication

Instead of

```
User Service

Authentication

Order Service

Authentication

Payment Service

Authentication
```

Use

```
API Gateway

↓

Authentication

↓

All Services
```

Authentication logic is centralized.

---

## Request Routing

Example

```
/users/**

↓

User Service
```

```
/orders/**

↓

Order Service
```

```
/payments/**

↓

Payment Service
```

---

## Response Aggregation

Sometimes the Gateway collects responses from multiple services.

```
Client

↓

API Gateway

↓

User Service

↓

Order Service

↓

Payment Service

↓

Combined Response
```

This reduces multiple client requests.

---

# Spring Cloud Gateway

Spring Boot commonly uses

```
Spring Cloud Gateway
```

It is the recommended API Gateway for Spring Cloud applications.

---

# Dependency

```xml
<dependency>
    <groupId>
        org.springframework.cloud
    </groupId>

    <artifactId>
        spring-cloud-starter-gateway
    </artifactId>
</dependency>
```

---

# Basic Configuration

```properties
spring.application.name=api-gateway

server.port=8080
```

---

# Route Configuration

```yaml
spring:
  cloud:
    gateway:
      routes:
        - id: order-service
          uri: lb://ORDER-SERVICE
          predicates:
            - Path=/orders/**
```

Explanation

- `id` → Route name
- `uri` → Destination service
- `lb://` → Use Service Discovery and Load Balancer
- `Path` → Incoming URL pattern

---

# Request Routing Flow

```
Client

↓

/orders/15

↓

API Gateway

↓

ORDER-SERVICE

↓

Order Service
```

---

# API Gateway with Eureka

```
Client

↓

API Gateway

↓

Eureka Server

↓

Order Service
```

The gateway asks Eureka where the service is located.

---

# API Gateway with OpenFeign

```
Client

↓

API Gateway

↓

Order Service

↓

OpenFeign

↓

Inventory Service
```

The Gateway routes external requests, while OpenFeign handles service-to-service communication.

---

# API Gateway vs Load Balancer

| API Gateway | Load Balancer |
|-------------|---------------|
| Entry point for clients | Distributes requests among instances |
| Routes requests | Selects service instance |
| Handles authentication | Improves availability |
| Performs filtering | Balances traffic |

---

# API Gateway vs Service Discovery

| API Gateway | Service Discovery |
|-------------|-------------------|
| Used by external clients | Used by internal services |
| Routes requests | Finds service locations |
| Single entry point | Service registry |
| Provides security | Provides dynamic lookup |

---

# Advantages

- Single client endpoint.
- Centralized authentication.
- Simplified client applications.
- Request routing.
- Response aggregation.
- Easy monitoring.
- Supports rate limiting.
- Improves security.

---

# Disadvantages

- Additional infrastructure.
- Can become a bottleneck if not scaled.
- More configuration.
- Gateway failure can affect all services if not highly available.

---

# Best Practices

- Keep business logic out of the Gateway.
- Use Service Discovery for routing.
- Enable HTTPS.
- Configure rate limiting.
- Monitor Gateway performance.
- Deploy multiple Gateway instances.
- Use centralized logging.

---

# Common Mistakes

❌ Putting business logic inside the API Gateway.

❌ Hardcoding service URLs.

❌ Not enabling authentication.

❌ Ignoring rate limiting.

❌ Running only one Gateway instance in production.

---

# Real-World Example

## Food Delivery Application

```
Customer

↓

API Gateway

↓

Restaurant Service

↓

Order Service

↓

Payment Service

↓

Delivery Service

↓

Notification Service
```

The mobile application communicates only with the API Gateway.

---

# Interview Questions

### 1. What is an API Gateway?

An API Gateway is a single entry point that receives client requests and routes them to the appropriate microservices.

---

### 2. Why do we need an API Gateway?

It simplifies client communication, centralizes authentication, handles routing, logging, rate limiting, and improves security.

---

### 3. Which API Gateway is commonly used with Spring Boot?

**Spring Cloud Gateway**.

---

### 4. What is the difference between an API Gateway and Service Discovery?

- API Gateway handles incoming client requests.
- Service Discovery helps microservices locate each other dynamically.

---

### 5. What is the purpose of `lb://` in Spring Cloud Gateway?

It tells the Gateway to use the configured Load Balancer and Service Discovery to find an available service instance.

---

### 6. Can an API Gateway perform authentication?

Yes. Authentication and authorization are commonly centralized at the Gateway.

---

### 7. Should business logic be placed inside an API Gateway?

No. The Gateway should focus on cross-cutting concerns like routing, security, and monitoring, while business logic belongs in microservices.

---

# Quick Revision

- API Gateway is the **single entry point** for client requests.
- Spring Boot commonly uses **Spring Cloud Gateway**.
- Handles **routing, authentication, authorization, logging, and rate limiting**.
- Integrates with **Eureka** using `lb://SERVICE-NAME`.
- Clients communicate only with the Gateway.
- Business logic should remain inside microservices.
- Often used together with **Service Discovery**, **OpenFeign**, and **Load Balancing**.