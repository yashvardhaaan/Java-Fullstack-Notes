# Idempotency

## What is Idempotency?

**Idempotency** means that **performing the same operation multiple times produces the same result as performing it once**.

In REST APIs, an idempotent request can be safely retried without creating duplicate data or changing the final state unexpectedly.

> **In simple words:**
>
> If you send the same request again and again, the final result remains the same.

---

# Why Do We Need Idempotency?

Imagine a payment API.

The client sends

```
Pay ₹100
```

Network timeout occurs.

The client retries.

Without Idempotency

```
Request 1

↓

₹100 Deducted

↓

Retry

↓

Another ₹100 Deducted

↓

Total ₹200
```

Problem

- Duplicate payment
- Incorrect data
- Bad user experience

---

With Idempotency

```
Request 1

↓

₹100 Deducted

↓

Retry

↓

Already Processed

↓

Return Previous Response
```

Only one payment is processed.

---

# Real-World Example

Imagine pressing an elevator button.

```
Press

↓

Lift Called
```

Press again

```
Press

↓

Nothing Changes
```

The elevator doesn't arrive twice.

This is idempotent behavior.

---

# How Idempotency Works

```
Client

↓

Request

↓

Server

↓

Already Processed?

↓

Yes

↓

Return Existing Result

OR

↓

Process Request

↓

Store Result
```

---

# HTTP Methods and Idempotency

| HTTP Method | Idempotent? |
|--------------|-------------|
| GET | ✅ Yes |
| PUT | ✅ Yes |
| DELETE | ✅ Yes |
| POST | ❌ Usually No |
| PATCH | ⚠ Depends on implementation |

---

# GET Example

```
GET /users/1
```

Whether executed once or ten times,

the same resource is returned.

```
GET

↓

User

↓

Same Response
```

---

# PUT Example

Update user name.

```
PUT /users/1

Name = John
```

Repeated requests

```
John

↓

John

↓

John
```

Final state remains the same.

---

# DELETE Example

```
DELETE /users/1
```

First request

```
User Deleted
```

Second request

```
User Already Deleted
```

Final state remains unchanged.

---

# POST Example

```
POST /orders
```

Without Idempotency

```
Request

↓

Order Created

↓

Retry

↓

Another Order Created
```

Duplicate orders are created.

---

# Solving POST Duplicate Requests

Use an **Idempotency Key**.

Client sends

```
POST /payments

Idempotency-Key:

abc123xyz
```

Server stores

```
Key

↓

Response
```

If the same key is received again,

```
Same Key

↓

Return Previous Response

↓

No Duplicate Processing
```

---

# Spring Boot Example

Controller

```java
@PostMapping("/payments")
public PaymentResponse pay(

        @RequestHeader("Idempotency-Key")

        String key,

        @RequestBody PaymentRequest request

){

    return paymentService.process(

            key,

            request

    );

}
```

---

# Service Flow

```
Receive Request

↓

Key Exists?

↓

Yes

↓

Return Stored Response

OR

↓

Process Payment

↓

Save Key

↓

Return Response
```

---

# Pseudo Code

```java
if(idempotencyKeyExists(key)){

    return previousResponse;

}

processPayment();

saveKey(key);

return response;
```

---

# Database Example

| Idempotency Key | Status | Response |
|-----------------|--------|----------|
| abc123 | Success | Payment Completed |
| xyz456 | Success | Order Created |

When the same key is received again,

the stored response is returned.

---

# Request Flow

```
Client

↓

POST

↓

Idempotency Key

↓

Controller

↓

Service

↓

Database

↓

Store Key

↓

Response
```

---

# Without vs With Idempotency

## Without

```
Retry

↓

Duplicate Processing

↓

Duplicate Data
```

---

## With

```
Retry

↓

Key Found

↓

Previous Response Returned
```

---

# Common Use Cases

- Payment APIs
- Order Creation
- Ticket Booking
- Money Transfer
- Wallet Recharge
- Subscription Purchase

---

# Benefits

- Prevents duplicate transactions.
- Safe request retries.
- Better user experience.
- Reliable distributed systems.
- Prevents accidental duplicate data.

---

# Challenges

- Requires storage for idempotency keys.
- Keys should expire after a reasonable time.
- Must ensure keys are unique.
- Additional implementation complexity.

---

# Best Practices

- Use UUIDs as Idempotency Keys.
- Store both the key and the response.
- Set an expiration time for stored keys.
- Apply idempotency mainly to critical POST operations.
- Return the original response for repeated requests.

---

# Idempotent vs Non-Idempotent

| Idempotent | Non-Idempotent |
|-------------|----------------|
| Same request → Same final state | Same request may create new data |
| Safe to retry | Retry may cause duplicates |
| GET, PUT, DELETE | Most POST requests |

---

# Real-World Example

## Banking Application

```
Transfer Money

↓

Network Failure

↓

Retry

↓

Same Idempotency Key

↓

No Duplicate Transfer
```

---

## E-Commerce Website

```
Place Order

↓

Retry

↓

Same Key

↓

No Duplicate Order
```

---

## Food Delivery App

```
Payment

↓

Retry

↓

Existing Transaction

↓

Return Previous Result
```

---

# Common Mistakes

❌ Ignoring duplicate POST requests.

❌ Using predictable idempotency keys.

❌ Not storing previous responses.

❌ Reprocessing requests with the same key.

❌ Keeping idempotency records forever.

---

# Interview Questions

### 1. What is Idempotency?

Idempotency means performing the same operation multiple times produces the same final result as performing it once.

---

### 2. Which HTTP methods are idempotent?

- GET
- PUT
- DELETE

`PATCH` depends on the implementation, while `POST` is generally not idempotent.

---

### 3. Why is POST usually not idempotent?

Because each POST request typically creates a new resource, so repeating it may create duplicates.

---

### 4. What is an Idempotency Key?

An Idempotency Key is a unique identifier sent with a request to ensure the same request is processed only once.

---

### 5. Where is Idempotency commonly used?

- Payment gateways
- Banking systems
- Order creation
- Booking systems
- Subscription services

---

### 6. How do you implement idempotency in Spring Boot?

Receive an `Idempotency-Key`, check if it already exists, return the stored response if found, otherwise process the request, save the key and response, and return the new response.

---

### 7. What are the benefits of idempotency?

It prevents duplicate operations, enables safe retries, improves reliability, and provides a better user experience.

---

# Quick Revision

- Idempotency means repeated requests produce the same final result.
- GET, PUT, and DELETE are idempotent.
- POST is generally not idempotent.
- Use an **Idempotency-Key** for critical POST APIs.
- Store the key and response to handle retries safely.
- Idempotency is essential for payment, banking, and booking systems.
- It improves reliability in distributed systems.