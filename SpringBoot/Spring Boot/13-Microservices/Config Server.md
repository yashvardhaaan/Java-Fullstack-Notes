# Config Server

## What is a Config Server?

A **Config Server** is a centralized service that stores and manages configuration files for all microservices.

Instead of each microservice maintaining its own configuration, they fetch their configuration from a central Config Server.

> **In simple words:**
>
> A Config Server is like a shared settings manager where all microservices get their configuration.

---

# Why Do We Need a Config Server?

Without Config Server

```
User Service

↓

application.properties
```

```
Order Service

↓

application.properties
```

```
Payment Service

↓

application.properties
```

Problems

- Duplicate configuration
- Difficult updates
- Inconsistent settings
- Hard to manage multiple environments

---

With Config Server

```
             Config Server
                  │
      ┌───────────┼───────────┐
      │           │           │
      ▼           ▼           ▼
User Service  Order Service  Payment Service
```

All services read configuration from one place.

---

# Real-World Example

Imagine a company with 100 employees.

Without a central HR portal:

```
Every Employee

↓

Keeps Personal Rules

↓

Different Information
```

With a central HR portal:

```
Employees

↓

HR Portal

↓

Latest Policies
```

A Config Server works the same way for microservices.

---

# Microservices Without Config Server

```
User Service

↓

Database URL
```

```
Order Service

↓

Database URL
```

```
Payment Service

↓

Database URL
```

Changing the database URL requires updating every service.

---

# Microservices With Config Server

```
           Git Repository
                  │
                  ▼
          Spring Config Server
                  │
     ┌────────────┼────────────┐
     ▼            ▼            ▼
 User Service  Order Service  Payment Service
```

Configuration is stored only once.

---

# How Config Server Works

```
Microservice Starts

↓

Requests Configuration

↓

Config Server

↓

Reads Git Repository

↓

Returns Configuration

↓

Application Starts
```

---

# Components

## 1. Config Server

Stores and serves configuration.

---

## 2. Git Repository

Stores configuration files.

---

## 3. Config Client

Microservice that requests configuration.

---

# Configuration Flow

```
Developer

↓

Update Git Repository

↓

Config Server

↓

Microservices Fetch Latest Configuration
```

---

# Architecture

```
                Git Repository
                       │
                       ▼
              Spring Config Server
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
 User Service    Order Service   Payment Service
```

---

# Why Use Git?

Git provides:

- Version control
- History tracking
- Rollback support
- Team collaboration

Example

```
application-dev.yml

application-test.yml

application-prod.yml
```

---

# Adding Config Server Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-config-server</artifactId>
</dependency>
```

---

# Enable Config Server

```java
@SpringBootApplication
@EnableConfigServer
public class ConfigServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(
                ConfigServerApplication.class,
                args
        );
    }

}
```

---

# Config Server Properties

```properties
server.port=8888

spring.cloud.config.server.git.uri=https://github.com/example/config-repo
```

---

# Config Client Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-config</artifactId>
</dependency>
```

---

# Config Client Properties

```properties
spring.application.name=order-service

spring.config.import=configserver:http://localhost:8888
```

The application downloads its configuration during startup.

---

# Example Git Repository

```
config-repo

├── application.yml

├── order-service.yml

├── payment-service.yml

├── inventory-service.yml

└── user-service.yml
```

---

# Environment-Specific Configuration

```
application-dev.yml

↓

Development
```

```
application-test.yml

↓

Testing
```

```
application-prod.yml

↓

Production
```

Each environment can have different configuration values.

---

# Configuration Refresh

When configuration changes:

```
Git Updated

↓

Config Server

↓

Refresh Endpoint

↓

Application Uses Latest Configuration
```

Spring Cloud can refresh configuration without restarting the application when configured appropriately.

---

# Advantages

- Centralized configuration.
- Easy environment management.
- Version-controlled settings.
- Less duplication.
- Easier maintenance.
- Better consistency across services.

---

# Disadvantages

- Additional infrastructure.
- Config Server becomes an important dependency.
- Requires proper security.
- Git availability affects configuration updates.

---

# Best Practices

- Store configuration in Git.
- Never store passwords in plain text.
- Use environment-specific configuration files.
- Secure the Config Server.
- Version configuration changes.
- Monitor Config Server availability.

---

# Common Mistakes

❌ Hardcoding configuration in every service.

❌ Storing secrets directly in Git.

❌ Mixing development and production configuration.

❌ Forgetting to secure the Config Server.

❌ Not versioning configuration changes.

---

# Real-World Example

## E-Commerce System

```
Git Repository

↓

Config Server

↓

Order Service

↓

Inventory Service

↓

Payment Service

↓

Notification Service
```

Changing a database URL or API key only requires updating the centralized configuration.

---

# Config Server vs application.properties

| Config Server | application.properties |
|---------------|------------------------|
| Centralized | Local to Each Service |
| Easy to Manage | Difficult at Scale |
| Version Controlled | No Central History |
| Shared Across Services | Independent Files |

---

# Interview Questions

### 1. What is a Config Server?

A Config Server is a centralized service that stores and serves configuration for multiple microservices.

---

### 2. Why is a Config Server needed?

It eliminates duplicate configuration, simplifies management, and allows centralized updates across services.

---

### 3. Where does Spring Cloud Config Server commonly store configuration?

In a Git repository.

---

### 4. Which annotation enables a Config Server?

```java
@EnableConfigServer
```

---

### 5. What is a Config Client?

A Config Client is a microservice that fetches its configuration from the Config Server during startup.

---

### 6. Why is Git commonly used with Config Server?

Because it provides version control, history, collaboration, and rollback capabilities.

---

### 7. Can different environments have different configuration files?

Yes. Common examples include:

- `application-dev.yml`
- `application-test.yml`
- `application-prod.yml`

---

# Quick Revision

- Config Server provides **centralized configuration management**.
- Spring Cloud Config stores configuration commonly in **Git**.
- Enable using `@EnableConfigServer`.
- Microservices act as **Config Clients**.
- Supports **environment-specific configurations**.
- Simplifies configuration updates across all services.
- Best used with **Git**, **Service Discovery**, and **Microservices**.