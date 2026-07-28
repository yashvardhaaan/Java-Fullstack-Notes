# Health Checks

## What are Health Checks?

**Health Checks** are mechanisms that determine whether an application and its dependencies are **running correctly and are ready to serve requests**.

Spring Boot provides Health Checks through the **Actuator Health Endpoint**.

> **In simple words:**
>
> A Health Check answers the question:
>
> **"Is my application healthy and working properly?"**

---

# Why Do We Need Health Checks?

Imagine your application depends on:

- Database
- Redis
- Kafka
- External APIs

Even if the application is running,

one dependency may fail.

```
Application

↓

Database Down

↓

Application Not Working Properly
```

Health Checks detect such problems automatically.

---

# Real-World Example

Think about a hospital patient.

Doctors check

- Heart Rate
- Blood Pressure
- Temperature
- Oxygen Level

```
Patient

↓

Medical Tests

↓

Healthy?

↓

Yes / No
```

Similarly,

Health Checks verify whether your application is healthy.

---

# Health Check Architecture

```
Client

↓

Health Endpoint

↓

Application

↓

Database

↓

Redis

↓

External APIs

↓

Health Status
```

---

# Spring Boot Health Check

Spring Boot provides

```
/actuator/health
```

Request

```
GET

↓

/actuator/health
```

---

# Health Endpoint Response

Healthy Application

```json
{
  "status": "UP"
}
```

Meaning

```
Application

↓

Healthy

↓

Ready to Serve Requests
```

---

# Unhealthy Application

Example

```json
{
  "status": "DOWN"
}
```

Meaning

```
Application

↓

Problem Detected

↓

Needs Attention
```

---

# Health Status Values

| Status | Meaning |
|---------|----------|
| `UP` | Application is healthy |
| `DOWN` | Application is not working |
| `OUT_OF_SERVICE` | Application is temporarily unavailable |
| `UNKNOWN` | Health cannot be determined |

---

# How Health Checks Work

```
Health Request

↓

Actuator

↓

Check Database

↓

Check Disk Space

↓

Check Dependencies

↓

Generate Health Status
```

---

# Dependency Health Checks

Spring Boot automatically checks many components.

Example

```
Application

│

├── Database

├── Disk Space

├── Redis

├── MongoDB

├── RabbitMQ

└── Kafka
```

Each dependency contributes to the overall health.

---

# Detailed Health Information

Enable detailed output.

```properties
management.endpoint.health.show-details=always
```

Request

```
GET

↓

/actuator/health
```

Example Response

```json
{
  "status": "UP",
  "components": {
    "db": {
      "status": "UP"
    },
    "diskSpace": {
      "status": "UP"
    }
  }
}
```

---

# Health Check Flow

```
Request

↓

Actuator

↓

Check Components

↓

Combine Results

↓

Return JSON
```

---

# Database Health Check

If the database is connected,

```
Database

↓

Connection Successful

↓

Status = UP
```

If the database is unavailable,

```
Database

↓

Connection Failed

↓

Status = DOWN
```

---

# Disk Space Health Check

Spring Boot automatically checks disk space.

```
Disk Space

↓

Enough Space?

↓

UP

OR

↓

DOWN
```

Useful when the server is running out of storage.

---

# Custom Health Indicator

You can create your own Health Check.

Example

```java
@Component
public class PaymentHealthIndicator

        implements HealthIndicator {

    @Override
    public Health health() {

        return Health.up().build();

    }

}
```

Now,

Spring Boot includes this in

```
/actuator/health
```

---

# Custom Health Flow

```
Health Request

↓

Custom Health Indicator

↓

Custom Logic

↓

UP / DOWN
```

Example

```
Payment Gateway

↓

Available?

↓

UP
```

---

# Multiple Health Indicators

```
Application

│

├── Database

├── Disk

├── Redis

├── Payment Gateway

└── Email Server

↓

Overall Health
```

If one important dependency fails,

overall status may become

```
DOWN
```

---

# Kubernetes Health Checks

Kubernetes frequently checks

```
/actuator/health
```

to decide whether a container is healthy.

```
Kubernetes

↓

Health Endpoint

↓

Healthy?

↓

Keep Running

OR

↓

Restart Container
```

---

# Load Balancer Health Checks

Load Balancer

```
Request

↓

Health Check

↓

Server Healthy?

↓

Yes

↓

Forward Request
```

If unhealthy,

```
Skip Server
```

This prevents users from reaching failed instances.

---

# Health Checks vs Metrics

| Health Checks | Metrics |
|---------------|---------|
| Shows application health | Shows performance data |
| UP or DOWN status | CPU, Memory, Request Count |
| Used for availability | Used for monitoring performance |

---

# Health Checks vs Logging

| Health Checks | Logging |
|---------------|----------|
| Current application state | Historical events |
| Used for monitoring | Used for debugging |
| JSON response | Log messages |

---

# Common Configuration

```properties
management.endpoint.health.show-details=always

management.endpoints.web.exposure.include=

health
```

This exposes only the Health endpoint.

---

# Health Check Request Flow

```
Client

↓

GET /actuator/health

↓

Actuator

↓

Health Indicators

↓

Overall Status

↓

JSON Response
```

---

# Common Mistakes

❌ Exposing detailed health information publicly.

❌ Ignoring database health.

❌ Not checking external services.

❌ Returning `UP` even when important services are unavailable.

❌ Not securing Health endpoints in production.

---

# Real-World Example

## Banking Application

```
Application

↓

Database

↓

Payment Service

↓

Health Check

↓

UP
```

---

## E-Commerce Website

```
Product Service

↓

Inventory Database

↓

Health Check

↓

DOWN

↓

Alert Sent
```

---

## Food Delivery App

```
Order Service

↓

Redis

↓

Health Check

↓

UP
```

---

# Advantages

- Detects failures quickly.
- Improves application reliability.
- Helps load balancers route traffic.
- Enables Kubernetes health monitoring.
- Supports custom health indicators.
- Simplifies production monitoring.

---

# Best Practices

- Use Spring Boot Actuator Health endpoint.
- Secure detailed health information.
- Monitor all critical dependencies.
- Create custom health indicators for external services.
- Integrate Health Checks with monitoring tools.
- Regularly review health status in production.

---

# Interview Questions

### 1. What is a Health Check?

A Health Check verifies whether an application and its dependencies are healthy and ready to handle requests.

---

### 2. Which endpoint provides application health in Spring Boot?

```text
/actuator/health
```

---

### 3. What does the `UP` status mean?

The application and its monitored components are healthy and ready to serve requests.

---

### 4. Can we create custom Health Checks?

Yes.

By implementing the `HealthIndicator` interface.

---

### 5. Why are Health Checks important in Kubernetes?

Kubernetes uses them to determine whether a container should continue running or be restarted.

---

### 6. What is the difference between Health Checks and Metrics?

Health Checks indicate whether the application is healthy, while Metrics provide performance-related information such as CPU usage and request counts.

---

### 7. Should detailed Health Check information be exposed publicly?

Generally, no.

Detailed health information should be secured because it may reveal internal application details.

---

# Quick Revision

- Health Checks determine whether an application is healthy.
- Spring Boot provides `/actuator/health`.
- Common statuses are `UP`, `DOWN`, `OUT_OF_SERVICE`, and `UNKNOWN`.
- Spring Boot automatically checks databases, disk space, and other supported components.
- Create custom checks using `HealthIndicator`.
- Kubernetes and load balancers use Health Checks for traffic management.
- Secure detailed health information in production.
- Health Checks are essential for production-ready Spring Boot applications.