# Distributed Tracing

## What is Distributed Tracing?

**Distributed Tracing** is a technique used to **track a request as it travels through multiple microservices**.

It helps developers understand:

- Which services handled the request
- How long each service took
- Where failures occurred
- Why a request was slow

> **In simple words:**
>
> Distributed Tracing is like a GPS tracker for a request moving through different microservices.

---

# Why Do We Need Distributed Tracing?

Without Distributed Tracing

```
Client

↓

Order Service

↓

Payment Service

↓

Inventory Service

↓

Notification Service
```

If the request fails, it is difficult to know where the problem occurred.

Problems

- Difficult debugging
- Slow issue resolution
- No visibility into request flow
- Hard to identify performance bottlenecks

---

With Distributed Tracing

```
Client

↓

Order Service

↓

Payment Service

↓

Inventory Service

↓

Notification Service

↓

Trace Timeline Available
```

Every step of the request is recorded.

---

# Real-World Example

Imagine tracking a courier package.

```
Warehouse

↓

Sorting Center

↓

City Hub

↓

Delivery Center

↓

Delivered
```

You can see exactly where the package is.

Distributed Tracing works the same way for application requests.

---

# How Distributed Tracing Works

```
Client Request

↓

Trace ID Created

↓

Order Service

↓

Payment Service

↓

Inventory Service

↓

Notification Service

↓

Response Returned
```

Every service adds tracing information to the request.

---

# Trace ID

A **Trace ID** uniquely identifies an entire request.

Example

```
Trace ID

↓

9f1c8ab7-45d8-4d71-a132
```

All services processing this request use the same Trace ID.

---

# Span

A **Span** represents a single unit of work inside one service.

Example

```
Trace

├── Order Service Span

├── Payment Service Span

├── Inventory Service Span

└── Notification Service Span
```

One trace contains multiple spans.

---

# Trace vs Span

| Trace | Span |
|--------|------|
| Entire Request | Single Operation |
| One Trace ID | Individual Span ID |
| Covers Multiple Services | Covers One Task |

---

# Architecture

```
                 Client
                    │
                    ▼
             API Gateway
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
   Order      Payment     Inventory
   Service     Service      Service
        │           │           │
        └───────────┼───────────┘
                    ▼
          Tracing Backend
```

---

# Request Flow

```
Client

↓

API Gateway

↓

Order Service

↓

Payment Service

↓

Inventory Service

↓

Response
```

Every service records:

- Start Time
- End Time
- Duration
- Errors
- Metadata

---

# Popular Distributed Tracing Tools

| Tool | Purpose |
|------|----------|
| Micrometer Tracing | Spring Boot tracing support |
| OpenTelemetry | Vendor-neutral tracing standard |
| Zipkin | Trace visualization |
| Jaeger | Distributed tracing platform |
| Grafana Tempo | Trace storage and visualization |

---

# Spring Boot Support

Modern Spring Boot applications commonly use:

- Micrometer Tracing
- OpenTelemetry
- Zipkin or Jaeger

---

# Example Dependency

```xml
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-tracing-bridge-brave</artifactId>
</dependency>
```

---

# Zipkin Dependency

```xml
<dependency>
    <groupId>io.zipkin.reporter2</groupId>
    <artifactId>zipkin-reporter-brave</artifactId>
</dependency>
```

---

# Logging Example

```
TraceId=9f1c8ab7

SpanId=ac34de11

Service=Order-Service

Duration=45ms
```

This makes it easy to correlate logs across services.

---

# Trace Visualization

```
Trace

↓

Order Service

 45 ms

↓

Payment Service

120 ms

↓

Inventory Service

30 ms

↓

Notification Service

15 ms
```

Developers can immediately identify the slowest service.

---

# Distributed Tracing with API Gateway

```
Client

↓

API Gateway

↓

Order Service

↓

Payment Service

↓

Response
```

The same Trace ID is propagated through every service.

---

# Distributed Tracing with OpenFeign

```
Order Service

↓

OpenFeign

↓

Inventory Service

↓

Same Trace ID
```

The tracing framework automatically propagates tracing headers.

---

# Advantages

- Easier debugging.
- End-to-end request visibility.
- Identifies slow services.
- Faster production issue resolution.
- Better performance monitoring.
- Improved observability.

---

# Disadvantages

- Additional infrastructure.
- Extra storage requirements.
- Slight runtime overhead.
- Requires proper configuration.

---

# Best Practices

- Propagate Trace IDs across all services.
- Combine tracing with centralized logging.
- Monitor trace latency.
- Sample traces in high-traffic systems.
- Secure trace data if it contains sensitive information.
- Use OpenTelemetry for better portability.

---

# Common Mistakes

❌ Logging without Trace IDs.

❌ Not propagating tracing headers.

❌ Collecting every trace in high-volume systems.

❌ Ignoring slow spans.

❌ Using tracing without monitoring dashboards.

---

# Real-World Example

## E-Commerce Application

```
Customer

↓

API Gateway

↓

Order Service

↓

Payment Service

↓

Inventory Service

↓

Notification Service

↓

Response
```

If checkout becomes slow, tracing immediately shows which service caused the delay.

---

# Distributed Tracing vs Logging

| Logging | Distributed Tracing |
|----------|---------------------|
| Individual Service Logs | End-to-End Request Tracking |
| Difficult to Correlate | Same Trace ID Across Services |
| Good for Events | Good for Request Flow |
| Local View | System-Wide View |

---

# Interview Questions

### 1. What is Distributed Tracing?

Distributed Tracing tracks a request across multiple microservices to understand its complete journey and performance.

---

### 2. What is a Trace ID?

A Trace ID is a unique identifier shared by all services handling the same request.

---

### 3. What is a Span?

A Span represents a single operation or unit of work within one service.

---

### 4. Why is Distributed Tracing important?

It simplifies debugging, identifies performance bottlenecks, and provides end-to-end visibility into distributed systems.

---

### 5. Which tools are commonly used for Distributed Tracing?

- OpenTelemetry
- Micrometer Tracing
- Zipkin
- Jaeger
- Grafana Tempo

---

### 6. Can Distributed Tracing work with OpenFeign?

Yes. Tracing frameworks automatically propagate Trace IDs between services making HTTP calls.

---

### 7. What is the difference between logging and distributed tracing?

Logging records individual events, while distributed tracing connects those events across multiple services using a shared Trace ID.

---

# Quick Revision

- Distributed Tracing tracks **requests across multiple microservices**.
- A **Trace** represents the complete request.
- A **Span** represents one operation within a service.
- **Trace ID** is shared across all services handling the request.
- Common tools: **OpenTelemetry**, **Micrometer Tracing**, **Zipkin**, **Jaeger**, **Grafana Tempo**.
- Helps identify **slow services**, **failures**, and **performance bottlenecks**.
- Works seamlessly with **Spring Boot**, **OpenFeign**, and **API Gateway**.