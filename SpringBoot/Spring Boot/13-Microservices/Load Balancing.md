# Load Balancing

## What is Load Balancing?

**Load Balancing** is the process of **distributing incoming requests across multiple instances of the same service**.

Instead of sending all requests to one server, a Load Balancer spreads the traffic evenly to improve performance and availability.

> **In simple words:**
>
> Load Balancing ensures that no single server gets overloaded by sharing the work among multiple servers.

---

# Why Do We Need Load Balancing?

Without Load Balancing

```
           Client
              │
              ▼
      Order Service (Only One)

      10,000 Requests

              │

      Server Overloaded
```

Problems

- Slow response time
- Server crashes
- Poor user experience
- Single point of failure

---

With Load Balancing

```
               Client
                  │
                  ▼
          Load Balancer
          /     |      \
         ▼      ▼       ▼
 Order-1   Order-2   Order-3
```

Requests are shared across multiple instances.

---

# Real-World Example

Imagine a supermarket.

Without Load Balancing

```
10 Customers

↓

One Billing Counter

↓

Long Queue
```

With Load Balancing

```
10 Customers

↓

3 Billing Counters

↓

Faster Checkout
```

The same idea applies to servers.

---

# How Load Balancing Works

```
Client

↓

Load Balancer

↓

Order Service Instance 1

↓

OR

↓

Order Service Instance 2

↓

OR

↓

Order Service Instance 3
```

Each new request is sent to one of the available instances.

---

# Architecture

```
                Client
                   │
                   ▼
          API Gateway
                   │
                   ▼
           Load Balancer
           /     |      \
          ▼      ▼       ▼
     Order-1 Order-2 Order-3
```

---

# Request Flow

```
Client

↓

API Gateway

↓

Load Balancer

↓

Available Service Instance

↓

Response
```

---

# Service Instances

Example

```
ORDER-SERVICE

↓

Instance 1

↓

localhost:8081
```

```
ORDER-SERVICE

↓

Instance 2

↓

localhost:8082
```

```
ORDER-SERVICE

↓

Instance 3

↓

localhost:8083
```

The Load Balancer automatically selects one instance.

---

# Load Balancing Algorithms

## 1. Round Robin

Requests are distributed one after another.

```
Request 1 → Server 1

Request 2 → Server 2

Request 3 → Server 3

Request 4 → Server 1
```

Most commonly used.

---

## 2. Random

A random server is selected.

```
Request

↓

Random Instance
```

---

## 3. Least Connections

The request goes to the server with the fewest active connections.

```
Server A → 50 Users

Server B → 10 Users

↓

Choose Server B
```

Useful for uneven workloads.

---

## 4. Weighted Round Robin

More powerful servers receive more requests.

```
Server A (Weight 3)

Server B (Weight 1)

↓

A receives more traffic.
```

---

# Client-Side vs Server-Side Load Balancing

## Client-Side

```
Client

↓

Gets Service Instances

↓

Chooses One
```

Example

- Spring Cloud LoadBalancer

---

## Server-Side

```
Client

↓

Load Balancer

↓

Chooses Server
```

Examples

- NGINX
- HAProxy
- AWS Application Load Balancer

---

# Spring Cloud LoadBalancer

Spring Cloud provides

```
Spring Cloud LoadBalancer
```

It replaces Netflix Ribbon.

It works with:

- Eureka
- OpenFeign
- API Gateway

---

# Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

---

# Load Balancer with Eureka

```
Order Service

↓

Ask Eureka

↓

Available Instances

↓

Choose One

↓

Call Service
```

---

# Load Balancer with OpenFeign

```java
@FeignClient(name = "inventory-service")
public interface InventoryClient {

    @GetMapping("/products")
    List<Product> getProducts();

}
```

When multiple instances exist,

```
Inventory-1

Inventory-2

Inventory-3
```

Spring Cloud LoadBalancer automatically selects one.

---

# API Gateway + Load Balancer

```
Client

↓

API Gateway

↓

Load Balancer

↓

Inventory Service

↓

Response
```

---

# Health Checks

The Load Balancer sends traffic only to healthy instances.

```
Instance 1

Healthy

✓
```

```
Instance 2

Down

✗
```

Only healthy services receive requests.

---

# Scaling Example

```
Morning

↓

2 Instances
```

```
Afternoon

↓

10 Instances
```

```
Night

↓

2 Instances
```

The Load Balancer distributes requests automatically as instances are added or removed.

---

# Advantages

- Better performance.
- High availability.
- Fault tolerance.
- Easy horizontal scaling.
- Improved reliability.
- Prevents server overload.

---

# Disadvantages

- Additional infrastructure.
- More configuration.
- Health checks require monitoring.
- Incorrect configuration may cause uneven traffic.

---

# Best Practices

- Use health checks.
- Combine with Service Discovery.
- Scale services horizontally.
- Monitor request distribution.
- Remove unhealthy instances automatically.
- Deploy multiple Load Balancer instances in production.

---

# Common Mistakes

❌ Sending all traffic to one instance.

❌ Ignoring health checks.

❌ Running only one service instance.

❌ Hardcoding service addresses.

❌ Not monitoring server utilization.

---

# Real-World Example

## E-Commerce Application

```
Customer

↓

API Gateway

↓

Load Balancer

↓

Order Service-1

↓

Order Service-2

↓

Order Service-3

↓

Response
```

During a flash sale, requests are distributed across all available instances to prevent overload.

---

# Load Balancing vs Service Discovery

| Load Balancing | Service Discovery |
|----------------|-------------------|
| Chooses a service instance | Finds available service instances |
| Distributes traffic | Maintains service registry |
| Improves performance | Enables dynamic communication |
| Prevents overload | Removes hardcoded addresses |

---

# Interview Questions

### 1. What is Load Balancing?

Load Balancing distributes incoming requests across multiple instances of a service to improve performance, availability, and reliability.

---

### 2. Why is Load Balancing important in Microservices?

It prevents a single service instance from becoming overloaded and enables horizontal scaling.

---

### 3. What is the difference between Client-Side and Server-Side Load Balancing?

- **Client-Side:** The client chooses the service instance (e.g., Spring Cloud LoadBalancer).
- **Server-Side:** A dedicated Load Balancer selects the instance (e.g., NGINX, AWS ALB).

---

### 4. Which library replaced Netflix Ribbon in Spring Cloud?

**Spring Cloud LoadBalancer**.

---

### 5. How does Load Balancing work with Eureka?

Eureka provides the list of available service instances, and the Load Balancer selects one instance to handle the request.

---

### 6. Can OpenFeign use Load Balancing?

Yes. When integrated with Service Discovery, OpenFeign automatically uses Spring Cloud LoadBalancer to communicate with available service instances.

---

### 7. Why are health checks important for Load Balancing?

Health checks ensure that requests are sent only to healthy service instances, improving reliability and fault tolerance.

---

# Quick Revision

- Load Balancing distributes **requests across multiple service instances**.
- Improves **performance**, **availability**, and **fault tolerance**.
- Common algorithms: **Round Robin**, **Random**, **Least Connections**, **Weighted Round Robin**.
- Spring Boot uses **Spring Cloud LoadBalancer**.
- Works with **Eureka**, **OpenFeign**, and **API Gateway**.
- Health checks prevent traffic from reaching unhealthy instances.
- Essential for scalable and highly available microservice architectures.