# Circuit Breaker

## What is a Circuit Breaker?

A **Circuit Breaker** is a design pattern used in microservices to **prevent cascading failures** when one service becomes slow, unavailable, or fails.

Instead of continuously calling a failing service, the Circuit Breaker temporarily stops requests and returns a fallback response.

> **In simple words:**
>
> A Circuit Breaker acts like an electrical circuit breaker in your house. If there is a problem, it cuts off the connection to prevent further damage.

---

# Why Do We Need a Circuit Breaker?

Without Circuit Breaker

```
Order Service

↓

Payment Service

↓

Payment Service Down

↓

Repeated Retries

↓

Timeouts

↓

Order Service Slows Down

↓

Entire System Affected
```

Problems

- Long response times
- Cascading failures
- High server load
- Poor user experience

---

With Circuit Breaker

```
Order Service

↓

Circuit Breaker

↓

Payment Service Down

↓

Fallback Response

↓

Application Continues Working
```

---

# Real-World Example

Imagine calling customer support.

```
Call

↓

No Response

↓

Try Again

↓

Still No Response

↓

Waste Time
```

Instead,

```
Call

↓

System Detects Failure

↓

Immediately Shows

"Service Temporarily Unavailable"
```

This saves time and resources.

---

# How Circuit Breaker Works

```
Order Service

↓

Circuit Breaker

↓

Payment Service

↓

Success

↓

Response
```

If failures exceed a limit,

```
Order Service

↓

Circuit Breaker

↓

Blocks Request

↓

Fallback Method
```

---

# Circuit Breaker States

```
          Success
     +---------------+
     |               |
     ▼               |
+-----------+        |
|  CLOSED   |--------+
+-----------+
      |
Too Many Failures
      ▼
+-----------+
|   OPEN    |
+-----------+
      |
 Wait Time Ends
      ▼
+-----------+
| HALF OPEN |
+-----------+
      |
Success? ─────► CLOSED
Failure? ─────► OPEN
```

---

# State Explanation

## 1. Closed State

```
Client

↓

Circuit Breaker

↓

Service
```

- Normal state
- Requests are allowed
- Failures are monitored

---

## 2. Open State

```
Client

↓

Circuit Breaker

↓

Request Blocked

↓

Fallback
```

- Service is considered unhealthy
- Requests are rejected immediately
- No unnecessary network calls

---

## 3. Half-Open State

```
Client

↓

Limited Requests

↓

Service

↓

Healthy?

↓

Yes → Closed

No → Open
```

A few requests are allowed to check whether the service has recovered.

---

# Request Flow

```
Client

↓

Order Service

↓

Circuit Breaker

↓

Payment Service

↓

Response
```

If Payment Service fails,

```
Client

↓

Order Service

↓

Circuit Breaker

↓

Fallback Response
```

---

# Spring Boot Circuit Breaker

The most commonly used library is

```
Resilience4j
```

It is the recommended replacement for Netflix Hystrix.

---

# Dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-circuitbreaker-resilience4j</artifactId>
</dependency>
```

---

# Enable Circuit Breaker

```java
@Service
public class PaymentService {

    @CircuitBreaker(
            name = "paymentService",
            fallbackMethod = "fallbackPayment"
    )
    public String processPayment() {

        // Call external service

        return "Payment Successful";
    }

    public String fallbackPayment(
            Exception ex
    ) {

        return "Payment Service Temporarily Unavailable";

    }

}
```

---

# Configuration Example

```properties
resilience4j.circuitbreaker.instances.paymentService.failureRateThreshold=50

resilience4j.circuitbreaker.instances.paymentService.slidingWindowSize=10

resilience4j.circuitbreaker.instances.paymentService.waitDurationInOpenState=10s
```

---

# Important Configuration

| Property | Purpose |
|----------|----------|
| failureRateThreshold | Failure percentage before opening the circuit |
| slidingWindowSize | Number of requests to evaluate |
| waitDurationInOpenState | Time before moving to Half-Open |
| permittedNumberOfCallsInHalfOpenState | Test requests allowed in Half-Open |

---

# Circuit Breaker with OpenFeign

```
Order Service

↓

OpenFeign

↓

Circuit Breaker

↓

Inventory Service
```

If Inventory Service fails,

```
Fallback Response Returned
```

---

# Advantages

- Prevents cascading failures.
- Improves system stability.
- Faster failure response.
- Reduces unnecessary network calls.
- Improves user experience.
- Supports graceful degradation.

---

# Disadvantages

- Additional configuration.
- Incorrect thresholds may block healthy services.
- Requires monitoring and tuning.

---

# Best Practices

- Use meaningful fallback responses.
- Configure reasonable timeout values.
- Monitor failure rates.
- Combine with Retry carefully.
- Test fallback methods.
- Monitor Circuit Breaker metrics.

---

# Common Mistakes

❌ Returning misleading fallback responses.

❌ Ignoring timeout configuration.

❌ Opening the circuit too aggressively.

❌ Not monitoring Circuit Breaker metrics.

❌ Assuming Circuit Breaker replaces proper error handling.

---

# Real-World Example

## E-Commerce Application

```
Customer

↓

Order Service

↓

Payment Service

↓

Payment Service Down

↓

Circuit Breaker

↓

"Payment service is temporarily unavailable."
```

The application remains responsive instead of waiting for repeated timeouts.

---

# Circuit Breaker vs Retry

| Circuit Breaker | Retry |
|-----------------|-------|
| Stops requests after repeated failures | Tries the request again |
| Prevents cascading failures | Handles temporary failures |
| Uses Closed/Open/Half-Open states | Retries based on configured attempts |
| Improves system stability | Improves success rate for transient issues |

Often, both are used together with proper configuration.

---

# Interview Questions

### 1. What is a Circuit Breaker?

A Circuit Breaker is a resilience pattern that stops requests to a failing service and returns a fallback response until the service recovers.

---

### 2. Why is a Circuit Breaker needed?

It prevents cascading failures, reduces unnecessary requests to unhealthy services, and improves system stability.

---

### 3. What are the three states of a Circuit Breaker?

- Closed
- Open
- Half-Open

---

### 4. Which library is commonly used for Circuit Breakers in Spring Boot?

**Resilience4j**.

---

### 5. What is a fallback method?

A fallback method provides an alternative response when the primary service call fails.

---

### 6. What happens in the Open state?

The Circuit Breaker immediately rejects requests and returns a fallback without contacting the failing service.

---

### 7. Can Circuit Breakers be used with OpenFeign?

Yes. They are commonly combined with OpenFeign to make service-to-service communication more resilient.

---

# Quick Revision

- Circuit Breaker prevents **cascading failures**.
- States: **Closed → Open → Half-Open**.
- **Resilience4j** is the recommended Spring Boot implementation.
- Fallback methods provide alternative responses during failures.
- Helps improve **availability**, **stability**, and **fault tolerance**.
- Commonly used with **OpenFeign**, **API Gateway**, and **Microservices**.