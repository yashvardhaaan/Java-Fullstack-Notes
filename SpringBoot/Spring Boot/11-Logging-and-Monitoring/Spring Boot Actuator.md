# Spring Boot Actuator

## What is Spring Boot Actuator?

**Spring Boot Actuator** is a Spring Boot module that provides **production-ready monitoring and management features** for your application.

It exposes endpoints that help developers and DevOps teams monitor the application's:

- Health
- Metrics
- Environment
- Beans
- Mappings
- Logs
- Configuration

> **In simple words:**
>
> Spring Boot Actuator is like a health dashboard for your application.

---

# Why Do We Need Actuator?

Imagine your application is running on a production server.

Questions you might have:

- Is the application running?
- Is the database connected?
- How much memory is being used?
- How many requests are coming?
- Which endpoints are available?

Without Actuator

```
Production Server

↓

No Information

↓

Hard to Debug
```

With Actuator

```
Production Server

↓

Actuator

↓

Health Information

↓

Easy Monitoring
```

---

# Real-World Example

Think of a car dashboard.

It displays:

- Fuel Level
- Engine Temperature
- Speed
- Battery Status

```
Car

↓

Dashboard

↓

Driver
```

Similarly,

Spring Boot Actuator displays the health and status of your application.

---

# Actuator Architecture

```
Application

↓

Spring Boot Actuator

↓

Monitoring Endpoints

↓

Developer / DevOps
```

---

# Adding Actuator Dependency

Maven

```xml
<dependency>

    <groupId>

        org.springframework.boot

    </groupId>

    <artifactId>

        spring-boot-starter-actuator

    </artifactId>

</dependency>
```

After adding this dependency,

Spring Boot automatically creates Actuator endpoints.

---

# How Actuator Works

```
Application Starts

↓

Actuator Initializes

↓

Creates Endpoints

↓

Application Ready
```

---

# Default Endpoint

After starting the application,

visit

```
http://localhost:8080/actuator
```

It shows the available Actuator endpoints.

---

# Common Actuator Endpoints

| Endpoint | Purpose |
|----------|----------|
| `/actuator` | Lists available endpoints |
| `/actuator/health` | Application health |
| `/actuator/info` | Application information |
| `/actuator/metrics` | Performance metrics |
| `/actuator/env` | Environment properties |
| `/actuator/beans` | Spring Beans |
| `/actuator/mappings` | All HTTP endpoints |
| `/actuator/loggers` | Logging configuration |

---

# Health Endpoint

```
GET

↓

/actuator/health
```

Response

```json
{
  "status": "UP"
}
```

Meaning

```
Application

↓

Running Successfully
```

---

# Info Endpoint

Configuration

```properties
management.info.env.enabled=true

info.app.name=InterviewApp

info.app.version=1.0
```

Request

```
GET

↓

/actuator/info
```

Response

```json
{
  "app": {
    "name": "InterviewApp",
    "version": "1.0"
  }
}
```

---

# Metrics Endpoint

Request

```
GET

↓

/actuator/metrics
```

Provides information such as:

- JVM Memory
- CPU Usage
- HTTP Requests
- Garbage Collection

---

# Beans Endpoint

```
GET

↓

/actuator/beans
```

Displays all Spring Beans created by the IoC Container.

---

# Environment Endpoint

```
GET

↓

/actuator/env
```

Shows

- Environment Variables
- Application Properties
- System Properties

Useful for debugging configuration issues.

---

# Mappings Endpoint

```
GET

↓

/actuator/mappings
```

Displays all REST endpoints.

Example

```
GET /users

POST /users

DELETE /users/{id}
```

---

# Loggers Endpoint

```
GET

↓

/actuator/loggers
```

Displays current logging levels.

You can also change log levels dynamically.

Example

```
INFO

↓

DEBUG
```

without restarting the application.

---

# Exposing Endpoints

By default,

not every endpoint is publicly accessible.

Expose endpoints using

```properties
management.endpoints.web.exposure.include=*
```

Or expose only specific endpoints

```properties
management.endpoints.web.exposure.include=

health,info,metrics
```

---

# Changing Actuator Base Path

Default

```
/actuator
```

Custom

```properties
management.endpoints.web.base-path=/manage
```

Now

```
http://localhost:8080/manage/health
```

---

# Actuator Request Flow

```
Developer

↓

HTTP Request

↓

Actuator Endpoint

↓

Application Information

↓

JSON Response
```

---

# Actuator Architecture Flow

```
Spring Boot

↓

Actuator

↓

Health

↓

Metrics

↓

Beans

↓

Environment

↓

JSON Response
```

---

# Common Configuration

```properties
management.endpoints.web.exposure.include=health,info

management.endpoint.health.show-details=always
```

Meaning

```
Expose

↓

Health

+

Info

↓

Show Full Details
```

---

# Actuator vs Logging

| Actuator | Logging |
|----------|----------|
| Shows current application state | Records past events |
| Provides monitoring endpoints | Stores log messages |
| Returns JSON responses | Writes logs to console/files |
| Used for health and metrics | Used for debugging |

---

# Actuator vs Spring Boot Application

| Spring Boot | Actuator |
|--------------|-----------|
| Runs the application | Monitors the application |
| Handles business logic | Provides management endpoints |
| Serves client requests | Serves monitoring information |

---

# Common Mistakes

❌ Exposing all Actuator endpoints in production.

❌ Allowing unauthenticated access to sensitive endpoints.

❌ Ignoring the Health endpoint.

❌ Not monitoring application metrics.

❌ Exposing environment properties containing secrets.

---

# Real-World Example

## Banking Application

```
Application Running

↓

/actuator/health

↓

Status = UP
```

---

## E-Commerce Website

```
High CPU Usage

↓

/actuator/metrics

↓

Investigate Performance
```

---

## Food Delivery App

```
Database Issue

↓

/actuator/health

↓

Database = DOWN
```

---

# Advantages

- Built-in monitoring.
- Production-ready endpoints.
- Easy health checks.
- Performance metrics.
- Environment inspection.
- Works seamlessly with monitoring tools like Prometheus and Grafana.

---

# Best Practices

- Expose only required endpoints in production.
- Secure Actuator endpoints using Spring Security.
- Regularly monitor health and metrics.
- Avoid exposing sensitive configuration values.
- Integrate Actuator with monitoring dashboards.

---

# Interview Questions

### 1. What is Spring Boot Actuator?

Spring Boot Actuator is a module that provides production-ready monitoring and management endpoints for Spring Boot applications.

---

### 2. Which dependency is required to use Actuator?

```xml
spring-boot-starter-actuator
```

---

### 3. Which endpoint checks the application's health?

```text
/actuator/health
```

---

### 4. Which endpoint provides JVM and application metrics?

```text
/actuator/metrics
```

---

### 5. How do you expose all Actuator endpoints?

```properties
management.endpoints.web.exposure.include=*
```

*(In production, exposing all endpoints is generally not recommended.)*

---

### 6. Can Actuator endpoints be secured?

Yes.

Spring Security can be used to restrict access to Actuator endpoints.

---

### 7. What is the difference between Actuator and Logging?

Actuator provides the current health, metrics, and management information about the application, while logging records events that occurred during application execution.

---

# Quick Revision

- Spring Boot Actuator provides production-ready monitoring features.
- Add the `spring-boot-starter-actuator` dependency.
- Common endpoints include `/health`, `/info`, `/metrics`, `/beans`, `/env`, and `/mappings`.
- Configure endpoint exposure using `management.endpoints.web.exposure.include`.
- Secure Actuator endpoints in production.
- Use Actuator to monitor application health and performance.
- Actuator integrates well with tools like Prometheus and Grafana.
- It is an essential component for production Spring Boot applications.