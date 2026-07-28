# Microservices Basics

## What are Microservices?

**Microservices** is an architectural style where a large application is divided into **small, independent, and loosely coupled services**.

Each service:

- Has a single responsibility
- Runs independently
- Has its own business logic
- Can be deployed independently
- Communicates with other services using APIs or messaging

> **In simple words:**
>
> Instead of building one huge application, we split it into multiple small applications, each responsible for one specific task.

---

# Why Do We Need Microservices?

Without Microservices (Monolithic)

```
Single Application

↓

User

Order

Payment

Inventory

Notification

↓

One Deployment
```

Problems

- Difficult to maintain
- Slow deployments
- One bug can affect the whole application
- Hard to scale

---

With Microservices

```
User Service

Order Service

Payment Service

Inventory Service

Notification Service

↓

Independent Services
```

Each service works independently.

---

# Real-World Example

Imagine Amazon.

Instead of one huge application,

Amazon has separate services like:

```
User Service

↓

Product Service

↓

Cart Service

↓

Order Service

↓

Payment Service

↓

Notification Service
```

Each team works on its own service.

---

# Monolithic vs Microservices

## Monolithic Architecture

```
Client

↓

One Application

↓

Database
```

Everything is inside one application.

---

## Microservices Architecture

```
Client

↓

API Gateway

↓

User Service

Order Service

Payment Service

↓

Databases
```

Each service has its own responsibility.

---

# Microservices Architecture

```
Client

↓

API Gateway

↓

Authentication Service

↓

User Service

↓

Order Service

↓

Inventory Service

↓

Payment Service

↓

Notification Service

↓

Databases
```

---

# Characteristics of Microservices

- Small and focused
- Independently deployable
- Loosely coupled
- Highly scalable
- Fault tolerant
- Technology independent
- Each service owns its own database

---

# How Microservices Work

```
Client

↓

API Gateway

↓

Order Service

↓

Calls Inventory Service

↓

Calls Payment Service

↓

Stores Order

↓

Returns Response
```

---

# Independent Deployment

Example

```
Payment Service Updated

↓

Deploy Only Payment Service

↓

Other Services Continue Running
```

Unlike a monolithic application, the entire system doesn't need redeployment.

---

# Database per Service

Recommended Architecture

```
User Service

↓

User Database
```

```
Order Service

↓

Order Database
```

```
Payment Service

↓

Payment Database
```

Each service manages its own data.

---

# Communication Between Services

## Synchronous

REST API

```
Order Service

↓

HTTP

↓

Inventory Service
```

Tools

- OpenFeign
- WebClient
- RestTemplate (Legacy)

---

## Asynchronous

Message Queue

```
Order Service

↓

RabbitMQ / Kafka

↓

Notification Service
```

The sender doesn't wait for an immediate response.

---

# Typical Microservices Components

| Component | Purpose |
|-----------|----------|
| API Gateway | Single Entry Point |
| Service Discovery | Locate Services |
| Config Server | Centralized Configuration |
| OpenFeign | Service Communication |
| Circuit Breaker | Fault Tolerance |
| Load Balancer | Distribute Traffic |
| Distributed Tracing | Track Requests |
| Docker | Containerization |
| Kubernetes | Container Orchestration |

---

# Request Flow

```
Client

↓

API Gateway

↓

Order Service

↓

Inventory Service

↓

Payment Service

↓

Notification Service

↓

Response
```

---

# Advantages

- Independent deployment
- Easy scalability
- Better fault isolation
- Faster development
- Smaller codebase
- Technology flexibility
- Independent teams

---

# Disadvantages

- Complex architecture
- Difficult debugging
- Network latency
- Distributed transactions
- More infrastructure
- Monitoring is harder

---

# Common Challenges

- Service communication
- Data consistency
- Distributed transactions
- Authentication
- Logging
- Monitoring
- Network failures

---

# Best Practices

- One service, one responsibility.
- Keep services loosely coupled.
- Each service should own its database.
- Use API Gateway.
- Implement centralized logging.
- Use Circuit Breaker for resilience.
- Use Config Server for configuration.
- Containerize services using Docker.
- Monitor using Prometheus and Grafana.

---

# Common Mistakes

❌ Creating too many tiny services.

❌ Sharing the same database between all services.

❌ Tight coupling between services.

❌ Ignoring monitoring and logging.

❌ Not handling failures.

❌ Using synchronous communication everywhere.

---

# Real-World Example

## E-Commerce Application

```
Customer

↓

API Gateway

↓

Cart Service

↓

Order Service

↓

Payment Service

↓

Inventory Service

↓

Notification Service
```

---

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

Delivery Service

↓

Payment Service

↓

Notification Service
```

---

# Monolithic vs Microservices Comparison

| Monolithic | Microservices |
|-------------|---------------|
| Single Application | Multiple Small Services |
| Single Deployment | Independent Deployment |
| Single Database | Database per Service |
| Difficult Scaling | Easy Scaling |
| One Technology Stack | Different Technologies Possible |
| Simpler Setup | More Complex Infrastructure |

---

# Interview Questions

### 1. What are Microservices?

Microservices are an architectural style where an application is divided into small, independent services that communicate over a network.

---

### 2. What are the advantages of Microservices?

- Independent deployment
- Better scalability
- Fault isolation
- Faster development
- Smaller codebase
- Team independence

---

### 3. What is the biggest disadvantage of Microservices?

The increased complexity of managing communication, monitoring, deployment, and data consistency across multiple services.

---

### 4. Should all Microservices share one database?

No. Each microservice should own its own database to remain loosely coupled and independently deployable.

---

### 5. How do Microservices communicate?

They communicate either:

- Synchronously using REST APIs (OpenFeign, WebClient)
- Asynchronously using message brokers (Kafka, RabbitMQ)

---

### 6. Why is an API Gateway used?

An API Gateway acts as a single entry point, routing client requests to the appropriate microservice while handling cross-cutting concerns like authentication, rate limiting, and logging.

---

### 7. Which tools are commonly used in a Microservices architecture?

- Spring Boot
- Spring Cloud
- API Gateway
- OpenFeign
- Config Server
- Eureka (Service Discovery)
- Resilience4j (Circuit Breaker)
- Docker
- Kubernetes
- Prometheus & Grafana

---

# Quick Revision

- Microservices split a large application into **small independent services**.
- Each service has **one responsibility**.
- Services communicate using **REST APIs** or **message brokers**.
- Each service should have **its own database**.
- API Gateway provides a **single entry point**.
- Use **Docker** for containerization and **Kubernetes** for orchestration.
- Microservices improve scalability and deployment but increase architectural complexity.