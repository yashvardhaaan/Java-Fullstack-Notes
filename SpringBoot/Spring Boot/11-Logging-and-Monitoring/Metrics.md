# Metrics

## What are Metrics?

**Metrics** are numerical measurements that describe the **performance, health, and behavior** of an application over time.

Spring Boot Actuator automatically collects various metrics about your application and exposes them through the **Metrics Endpoint**.

> **In simple words:**
>
> Metrics are numbers that tell you how well your application is performing.

---

# Why Do We Need Metrics?

Suppose your application is running in production.

Questions you may have:

- How many requests are coming?
- How much memory is being used?
- What is the CPU usage?
- How fast are APIs responding?
- Is the JVM healthy?

Without Metrics

```
Application Running

↓

No Performance Data

↓

Difficult to Analyze
```

With Metrics

```
Application Running

↓

Metrics Collected

↓

Performance Dashboard

↓

Easy Monitoring
```

---

# Real-World Example

Imagine driving a car.

The dashboard displays:

- Speed
- Fuel Level
- Engine Temperature
- RPM

```
Car

↓

Dashboard

↓

Performance Data
```

Similarly,

Metrics provide important performance information about your application.

---

# Metrics Architecture

```
Application

↓

Spring Boot Actuator

↓

Micrometer

↓

Metrics

↓

Monitoring Tool
```

---

# How Metrics Work

```
Application

↓

Collect Performance Data

↓

Store Metrics

↓

Expose Through Endpoint

↓

Monitoring Dashboard
```

---

# Metrics Endpoint

Spring Boot provides

```
GET

↓

/actuator/metrics
```

Example Response

```json
{
  "names": [
    "jvm.memory.used",
    "jvm.memory.max",
    "system.cpu.usage",
    "http.server.requests"
  ]
}
```

---

# Viewing a Specific Metric

Request

```
GET

↓

/actuator/metrics/jvm.memory.used
```

Example Response

```json
{
  "name": "jvm.memory.used",
  "measurements": [
    {
      "value": 52428800
    }
  ]
}
```

---

# Common Spring Boot Metrics

| Metric | Purpose |
|---------|----------|
| `jvm.memory.used` | JVM memory currently used |
| `jvm.memory.max` | Maximum JVM memory |
| `system.cpu.usage` | CPU usage |
| `process.cpu.usage` | JVM process CPU usage |
| `http.server.requests` | Total HTTP requests |
| `disk.free` | Free disk space |
| `disk.total` | Total disk space |

---

# HTTP Request Metrics

```
Client

↓

GET /users

↓

Controller

↓

Response

↓

Request Count Increased
```

Spring Boot automatically tracks

- Total requests
- Response time
- HTTP status codes

---

# JVM Memory Metrics

```
Application

↓

JVM

↓

Heap Memory

↓

Memory Usage
```

Useful for detecting memory leaks.

---

# CPU Metrics

```
Application Running

↓

CPU Usage

↓

20%

↓

Normal
```

or

```
Application Running

↓

CPU Usage

↓

95%

↓

Performance Issue
```

---

# Request Timing

Metrics also measure

```
API Request

↓

Execution Time

↓

250 ms
```

This helps identify slow APIs.

---

# Metrics Flow

```
Client Request

↓

Spring Boot

↓

Collect Metrics

↓

Micrometer

↓

Actuator

↓

JSON Response
```

---

# What is Micrometer?

**Micrometer** is the metrics collection library used by Spring Boot.

It acts as a bridge between Spring Boot and monitoring systems.

```
Spring Boot

↓

Micrometer

↓

Prometheus

↓

Grafana
```

---

# Custom Metrics

You can create your own metrics.

Example

```java
@Component
public class OrderService {

    private final Counter orderCounter;

    public OrderService(

            MeterRegistry registry

    ){

        orderCounter = Counter.builder(

                "orders.created"

        ).register(registry);

    }

    public void createOrder(){

        orderCounter.increment();

    }

}
```

Flow

```
Create Order

↓

Increment Counter

↓

Metric Updated
```

---

# Counter Metric

A Counter always increases.

Example

```
Order Created

↓

Counter = 1

↓

Counter = 2

↓

Counter = 3
```

Used for:

- Orders
- Logins
- Payments
- API Requests

---

# Gauge Metric

A Gauge represents a current value.

Example

```
Active Users

↓

120

↓

150

↓

140
```

It can increase or decrease.

---

# Timer Metric

A Timer measures execution time.

```
API Called

↓

Start Timer

↓

Execute

↓

Stop Timer

↓

Record Duration
```

---

# Metric Types

| Type | Purpose |
|------|----------|
| Counter | Counts events |
| Gauge | Current value |
| Timer | Measures execution time |
| Distribution Summary | Records value distributions |

---

# Metrics Request Flow

```
Application

↓

Micrometer

↓

Actuator

↓

/metrics

↓

JSON Response
```

---

# Metrics vs Health Checks

| Metrics | Health Checks |
|----------|---------------|
| Shows performance | Shows health status |
| CPU, Memory, Requests | UP or DOWN |
| Continuous measurements | Availability check |

---

# Metrics vs Logging

| Metrics | Logging |
|----------|----------|
| Numerical data | Text messages |
| Used for monitoring | Used for debugging |
| Shows trends | Shows events |

---

# Common Configuration

```properties
management.endpoints.web.exposure.include=

health,info,metrics
```

Now,

```
/actuator/metrics
```

is available.

---

# Monitoring with Prometheus

```
Spring Boot

↓

Micrometer

↓

Prometheus

↓

Grafana Dashboard

↓

Charts & Alerts
```

Prometheus collects metrics,

Grafana displays them visually.

---

# Common Mistakes

❌ Ignoring application metrics.

❌ Monitoring only CPU usage.

❌ Not tracking response time.

❌ Creating too many unnecessary custom metrics.

❌ Exposing metrics publicly without proper security.

---

# Real-World Example

## Banking Application

```
Money Transfer API

↓

Execution Time

↓

350 ms
```

---

## E-Commerce Website

```
Orders Created

↓

Counter

↓

5,000 Orders
```

---

## Food Delivery App

```
Active Users

↓

Gauge

↓

8,500 Users
```

---

# Advantages

- Monitors application performance.
- Detects bottlenecks early.
- Measures API response time.
- Tracks JVM and system resources.
- Integrates with Prometheus and Grafana.
- Helps maintain production reliability.

---

# Best Practices

- Monitor CPU, memory, and request metrics.
- Track API response times.
- Create custom metrics only when necessary.
- Secure Actuator metrics endpoints.
- Integrate with Prometheus and Grafana.
- Review metrics regularly to identify performance issues.

---

# Interview Questions

### 1. What are Metrics?

Metrics are numerical measurements that describe the performance and behavior of an application.

---

### 2. Which endpoint provides metrics in Spring Boot?

```text
/actuator/metrics
```

---

### 3. What is Micrometer?

Micrometer is the metrics collection library used by Spring Boot to collect and export metrics to monitoring systems.

---

### 4. What is the difference between a Counter and a Gauge?

- **Counter** only increases and counts events.
- **Gauge** represents a value that can increase or decrease.

---

### 5. Which metric measures API execution time?

A **Timer** metric measures how long an operation or API takes to execute.

---

### 6. Which monitoring tools commonly use Spring Boot Metrics?

Prometheus collects metrics, and Grafana visualizes them through dashboards.

---

### 7. What is the difference between Metrics and Logging?

Metrics provide numerical performance data, while Logging records textual events that occur during application execution.

---

# Quick Revision

- Metrics measure application performance and resource usage.
- Spring Boot exposes metrics through `/actuator/metrics`.
- Micrometer is the metrics library used by Spring Boot.
- Common metrics include CPU usage, JVM memory, HTTP requests, and disk space.
- Metric types include Counter, Gauge, Timer, and Distribution Summary.
- Prometheus collects metrics, while Grafana visualizes them.
- Monitor response time, memory, CPU, and request counts in production.
- Metrics are essential for building reliable and scalable Spring Boot applications.