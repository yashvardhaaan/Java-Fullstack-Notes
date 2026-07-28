# OpenFeign

## What is OpenFeign?

**OpenFeign** is a **declarative HTTP client** provided by Spring Cloud that allows one microservice to call another using a Java interface.

Instead of writing HTTP request code manually, you simply define an interface and annotate it with `@FeignClient`.

> **In simple words:**
>
> OpenFeign lets one microservice call another as if it were calling a normal Java method.

---

# Why Do We Need OpenFeign?

Without OpenFeign

```
Order Service

↓

Create HTTP Request

↓

Set URL

↓

Set Headers

↓

Handle Response

↓

Convert JSON

↓

Return Data
```

A lot of boilerplate code is required.

---

With OpenFeign

```
Order Service

↓

Feign Client

↓

Inventory Service
```

Just call a Java method.

---

# Real-World Example

Imagine an E-Commerce application.

```
Customer Places Order

↓

Order Service

↓

Inventory Service

↓

Payment Service

↓

Notification Service
```

The **Order Service** uses OpenFeign to communicate with the Inventory and Payment services.

---

# How OpenFeign Works

```
Order Service

↓

Feign Client

↓

HTTP Request

↓

Inventory Service

↓

HTTP Response

↓

Java Object
```

Feign automatically converts Java objects to JSON and vice versa.

---

# Architecture

```
Client

↓

API Gateway

↓

Order Service

↓

OpenFeign Client

↓

Inventory Service
```

---

# Adding Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

---

# Enable Feign

```java
@SpringBootApplication
@EnableFeignClients
public class OrderApplication {

    public static void main(String[] args) {
        SpringApplication.run(OrderApplication.class, args);
    }

}
```

---

# Creating a Feign Client

```java
@FeignClient(name = "inventory-service")
public interface InventoryClient {

    @GetMapping("/inventory/{id}")
    InventoryResponse getInventory(
            @PathVariable Long id
    );

}
```

---

# Using the Feign Client

```java
@Service
public class OrderService {

    private final InventoryClient inventoryClient;

    public OrderService(
            InventoryClient inventoryClient
    ) {
        this.inventoryClient = inventoryClient;
    }

    public InventoryResponse checkInventory(Long id) {
        return inventoryClient.getInventory(id);
    }

}
```

No HTTP request code is written manually.

---

# Request Flow

```
Order Service

↓

inventoryClient.getInventory()

↓

OpenFeign

↓

HTTP Request

↓

Inventory Service

↓

HTTP Response

↓

Java Object
```

---

# Path Variables

```java
@GetMapping("/products/{id}")
Product getProduct(
        @PathVariable Long id
);
```

---

# Request Parameters

```java
@GetMapping("/products")
List<Product> search(
        @RequestParam String category
);
```

---

# Sending Request Body

```java
@PostMapping("/orders")
OrderResponse createOrder(
        @RequestBody OrderRequest request
);
```

---

# Calling Multiple Services

```
Order Service

├── Inventory Client

├── Payment Client

└── Notification Client
```

Each client is a separate interface.

---

# OpenFeign vs RestTemplate

| OpenFeign | RestTemplate |
|-----------|--------------|
| Declarative | Imperative |
| Less Code | More Boilerplate |
| Interface Based | Manual HTTP Calls |
| Easy to Maintain | More Complex |
| Recommended | Legacy |

---

# OpenFeign vs WebClient

| OpenFeign | WebClient |
|-----------|-----------|
| Blocking | Supports Reactive Programming |
| Easier to Use | More Flexible |
| Interface Based | Fluent API |
| Good for Standard Microservices | Good for Reactive Applications |

---

# Advantages

- Minimal boilerplate code.
- Easy microservice communication.
- Interface-based programming.
- Integrates with Service Discovery.
- Supports load balancing.
- Easy maintenance.

---

# Disadvantages

- Network latency still exists.
- Blocking by default.
- Requires proper error handling.
- Depends on network availability.

---

# Best Practices

- Use Service Discovery instead of hardcoded URLs.
- Configure connection and read timeouts.
- Combine with Circuit Breaker for fault tolerance.
- Handle exceptions gracefully.
- Keep client interfaces small and focused.

---

# Common Mistakes

❌ Hardcoding service URLs.

❌ Ignoring timeout configuration.

❌ Not implementing fallback mechanisms.

❌ Putting too many APIs in one Feign client.

❌ Assuming network calls are always successful.

---

# Real-World Example

```
Customer

↓

Order Service

↓

OpenFeign

↓

Inventory Service

↓

Stock Available

↓

Order Created
```

---

# Interview Questions

### 1. What is OpenFeign?

OpenFeign is a declarative HTTP client used in Spring Cloud to simplify communication between microservices.

---

### 2. Why is OpenFeign preferred over RestTemplate?

Because it reduces boilerplate code by allowing developers to define HTTP calls using annotated Java interfaces.

---

### 3. Which annotation enables Feign clients?

```java
@EnableFeignClients
```

---

### 4. Which annotation creates a Feign client?

```java
@FeignClient
```

---

### 5. Can OpenFeign work with Service Discovery?

Yes. It integrates with services like Eureka to locate service instances dynamically.

---

### 6. Can OpenFeign be used with Circuit Breakers?

Yes. It is commonly integrated with Resilience4j to provide fallback behavior when a downstream service fails.

---

### 7. Is OpenFeign synchronous or asynchronous?

By default, OpenFeign performs synchronous (blocking) HTTP calls.

---

# Quick Revision

- OpenFeign is a **declarative HTTP client**.
- Use `@EnableFeignClients` to enable Feign.
- Use `@FeignClient` to define service interfaces.
- Eliminates manual HTTP request code.
- Integrates with **Service Discovery** and **Load Balancing**.
- Commonly paired with **Circuit Breakers** for resilience.
- Best suited for communication between Spring Boot microservices.