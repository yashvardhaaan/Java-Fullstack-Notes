# Service Discovery

## What is Service Discovery?

**Service Discovery** is a mechanism that allows microservices to **find and communicate with each other automatically** without knowing each other's IP addresses or ports.

Instead of hardcoding service locations, services register themselves with a **Service Registry**, and other services discover them when needed.

> **In simple words:**
>
> Service Discovery is like a phonebook for microservices. Every service registers its address, and other services look it up whenever they need to communicate.

---

# Why Do We Need Service Discovery?

Without Service Discovery

```
Order Service

↓

Inventory Service

↓

http://192.168.1.20:8082
```

Problems

- Hardcoded IP addresses
- Port changes break communication
- Difficult scaling
- Manual configuration

---

With Service Discovery

```
Order Service

↓

Service Registry

↓

Inventory Service
```

The registry automatically provides the current location of the service.

---

# Real-World Example

Imagine calling a friend.

Without a contact list:

```
Remember Phone Number

↓

Dial Number
```

If the number changes, you cannot call.

With a contact list:

```
Search Contact

↓

Get Latest Number

↓

Call Friend
```

Service Discovery works in the same way.

---

# Microservices Without Service Discovery

```
Client

↓

Order Service

↓

Inventory Service (IP Address)

↓

Payment Service (IP Address)
```

Every service must know the exact address of every other service.

---

# Microservices With Service Discovery

```
                +------------------+
                | Service Registry |
                +------------------+
                  ↑     ↑      ↑
                  |     |      |
       Register   |     |      | Register

+-------------+  +-------------+  +--------------+
| Order       |  | Inventory   |  | Payment      |
| Service     |  | Service     |  | Service      |
+-------------+  +-------------+  +--------------+

        ↓

Client Request
```

---

# How Service Discovery Works

```
Inventory Service Starts

↓

Registers Itself

↓

Service Registry

↓

Order Service Requests Inventory

↓

Registry Returns Address

↓

Order Service Calls Inventory
```

---

# Components

## 1. Service Provider

The service that registers itself.

Example

```
Inventory Service
```

---

## 2. Service Registry

Stores service information.

Example

```
Eureka Server
```

---

## 3. Service Consumer

Looks up another service.

Example

```
Order Service
```

---

# Registration Flow

```
Inventory Service

↓

Starts

↓

Registers with Eureka

↓

Registry Stores

Service Name

IP Address

Port

Status
```

---

# Discovery Flow

```
Order Service

↓

Ask Eureka

↓

Where is Inventory Service?

↓

Returns

localhost:8082

↓

HTTP Call
```

---

# Popular Service Discovery Tools

| Tool | Description |
|------|-------------|
| Netflix Eureka | Most popular with Spring Cloud |
| Consul | HashiCorp Service Discovery |
| Kubernetes DNS | Built-in Kubernetes Discovery |
| Apache ZooKeeper | Distributed Coordination |
| Nacos | Alibaba Service Discovery |

---

# Netflix Eureka

Eureka consists of

```
Eureka Server

↓

Stores Services

↓

Clients Register

↓

Clients Discover
```

---

# Adding Eureka Server Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
</dependency>
```

---

# Enable Eureka Server

```java
@SpringBootApplication
@EnableEurekaServer
public class EurekaServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(
                EurekaServerApplication.class,
                args
        );
    }

}
```

---

# Eureka Server Configuration

```properties
server.port=8761

spring.application.name=eureka-server

eureka.client.register-with-eureka=false

eureka.client.fetch-registry=false
```

Access Dashboard

```
http://localhost:8761
```

---

# Adding Eureka Client Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

---

# Client Configuration

```properties
spring.application.name=inventory-service

eureka.client.service-url.defaultZone=http://localhost:8761/eureka
```

---

# Calling Services Using Service Name

Instead of

```text
http://localhost:8082/products
```

Use

```text
http://inventory-service/products
```

The service registry resolves the actual address.

---

# Service Discovery with OpenFeign

```java
@FeignClient(name = "inventory-service")
public interface InventoryClient {

    @GetMapping("/products")
    List<Product> getProducts();

}
```

OpenFeign automatically asks Eureka for the service location.

---

# Request Flow

```
Client

↓

API Gateway

↓

Order Service

↓

Service Registry

↓

Inventory Service

↓

Response
```

---

# Client-Side Discovery

```
Order Service

↓

Eureka

↓

Gets Available Instances

↓

Chooses One

↓

Calls Service
```

Spring Cloud LoadBalancer helps choose an available instance.

---

# Advantages

- No hardcoded IP addresses.
- Automatic service registration.
- Easier scaling.
- Better fault tolerance.
- Dynamic discovery.
- Simplifies microservice communication.

---

# Disadvantages

- Additional infrastructure.
- Registry becomes a critical component.
- More network communication.
- Requires monitoring and maintenance.

---

# Best Practices

- Use meaningful service names.
- Enable health checks.
- Combine with Load Balancing.
- Secure the Service Registry.
- Remove unhealthy service instances automatically.
- Monitor registry health.

---

# Common Mistakes

❌ Hardcoding service URLs.

❌ Registering duplicate service names.

❌ Ignoring health checks.

❌ Running a single registry in production without high availability.

❌ Forgetting to configure service registration.

---

# Real-World Example

## E-Commerce System

```
Customer

↓

API Gateway

↓

Order Service

↓

Service Registry

↓

Inventory Service

↓

Payment Service

↓

Notification Service
```

Whenever a service scales up or moves to another server, the registry provides the updated location automatically.

---

# Service Discovery vs API Gateway

| Service Discovery | API Gateway |
|-------------------|-------------|
| Finds Service Locations | Entry Point for Clients |
| Used by Microservices | Used by External Clients |
| Resolves Service Addresses | Routes Requests |
| Internal Communication | External Communication |

---

# Interview Questions

### 1. What is Service Discovery?

Service Discovery is a mechanism that enables microservices to automatically locate and communicate with each other without hardcoding IP addresses or ports.

---

### 2. Why is Service Discovery needed?

It allows services to scale, restart, or change locations without requiring configuration changes in other services.

---

### 3. What is Eureka?

Eureka is a Service Registry provided by Netflix and integrated with Spring Cloud for service registration and discovery.

---

### 4. What is the difference between a Eureka Server and a Eureka Client?

- **Eureka Server** maintains the registry of available services.
- **Eureka Client** registers itself with the server and discovers other services.

---

### 5. How does OpenFeign work with Service Discovery?

OpenFeign uses the service name defined in `@FeignClient`, asks the Service Registry for the service's current location, and sends the request to an available instance.

---

### 6. What happens if a service changes its IP address?

The service re-registers with the Service Registry, and other services automatically discover the updated address without code changes.

---

### 7. Can Service Discovery be used with Load Balancing?

Yes. Spring Cloud LoadBalancer or similar tools distribute requests among multiple instances of the same service.

---

# Quick Revision

- Service Discovery helps **microservices find each other dynamically**.
- Services register themselves with a **Service Registry**.
- **Netflix Eureka** is the most common Service Discovery solution in Spring Cloud.
- Clients use **service names**, not IP addresses.
- OpenFeign integrates seamlessly with Service Discovery.
- Supports **dynamic scaling**, **fault tolerance**, and **load balancing**.
- Eliminates hardcoded service URLs in microservice architectures.