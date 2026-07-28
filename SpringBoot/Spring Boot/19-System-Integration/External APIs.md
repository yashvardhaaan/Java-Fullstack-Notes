# External APIs

## What are External APIs?

An **External API** is an API provided by another application or service that your application can communicate with over the internet.

Instead of implementing everything yourself, you can use external services for:

- Payments
- Maps
- Weather
- SMS
- Email
- Authentication
- Currency Exchange

> **In simple words:**
>
> An External API allows your application to use features provided by another system.

---

# Why Do We Need External APIs?

Imagine an e-commerce application.

Without External API

```
Customer Pays

↓

You Build Payment Gateway

↓

Huge Development Cost
```

Very difficult.

---

With External API

```
Customer Pays

↓

Stripe / Razorpay

↓

Payment Success
```

Much easier.

---

# Real-World Example

When ordering food,

```
Food Delivery App

↓

Google Maps API

↓

Calculate Route

↓

Delivery Partner Navigates
```

The app doesn't build its own map system.

---

# External API Architecture

```
Client

↓

Spring Boot Application

↓

External API

↓

External Server

↓

Response

↓

Spring Boot

↓

Client
```

---

# How External APIs Work

```
Application

↓

HTTP Request

↓

Internet

↓

External API

↓

JSON Response

↓

Application
```

---

# Popular External APIs

- Stripe
- Razorpay
- Google Maps
- OpenWeather
- Twilio
- Firebase
- GitHub API
- PayPal

---

# Request Flow

```
Client

↓

Controller

↓

Service

↓

REST Client

↓

External API

↓

JSON Response

↓

Client
```

---

# Example

Request

```
GET

/api/weather
```

Spring Boot

↓

Calls

```
https://api.weather.com
```

↓

Receives

```json
{
    "temperature": 30,
    "city": "Pune"
}
```

↓

Returns Response

---

# HTTP Methods

External APIs commonly use:

| Method | Purpose |
|----------|----------|
| GET | Read Data |
| POST | Create Data |
| PUT | Update Data |
| PATCH | Partial Update |
| DELETE | Delete Data |

---

# Authentication

Many external APIs require authentication.

Common methods

- API Key
- Bearer Token
- OAuth 2.0
- JWT
- Basic Authentication

Example

```
Authorization:

Bearer eyJhb...
```

---

# Request Headers

Example

```
GET /users

Authorization: Bearer TOKEN

Content-Type: application/json

Accept: application/json
```

---

# JSON Response

Example

```json
{
    "id": 1,
    "name": "John",
    "email": "john@example.com"
}
```

Spring Boot converts JSON into Java objects.

---

# DTO Example

```java
public class UserResponse {

    private Long id;

    private String name;

    private String email;

}
```

---

# Error Handling

Possible responses

| Status Code | Meaning |
|-------------|----------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Server Error |

---

# Timeout Handling

Sometimes,

```
Application

↓

Calls API

↓

No Response

↓

Timeout
```

Always configure reasonable timeout values.

---

# Retry Mechanism

```
Call API

↓

Failed

↓

Retry

↓

Success
```

Retries help handle temporary network failures.

---

# External API Flow

```
Client

↓

Controller

↓

Service

↓

External API

↓

Response

↓

Service

↓

Controller

↓

Client
```

---

# Common Use Cases

- Payment Gateway
- Weather Information
- Maps & Navigation
- SMS Service
- Email Service
- Currency Conversion
- Social Login

---

# Advantages

- Saves development time.
- Adds powerful features quickly.
- Easy integration.
- Highly scalable.
- Uses trusted third-party services.

---

# Disadvantages

- Internet dependency.
- API rate limits.
- Possible downtime.
- Security concerns.
- Third-party pricing may change.

---

# Best Practices

- Store API keys securely.
- Use HTTPS for all API communication.
- Configure connection and read timeouts.
- Implement retries for temporary failures.
- Handle HTTP errors gracefully.
- Cache responses when appropriate.
- Monitor API usage and rate limits.

---

# Common Mistakes

❌ Hardcoding API keys.

❌ Ignoring timeout configuration.

❌ Not validating API responses.

❌ Assuming every request succeeds.

❌ Exposing sensitive API credentials.

---

# Real-World Example

## Banking Application

```
Customer Pays

↓

Payment Gateway API

↓

Payment Success
```

---

## E-Commerce Website

```
Enter Address

↓

Google Maps API

↓

Validate Address
```

---

## Food Delivery App

```
Track Driver

↓

Maps API

↓

Live Location
```

---

# Interview Questions

### 1. What is an External API?

An External API is a service provided by another application that your application communicates with over HTTP.

---

### 2. Why are External APIs used?

They provide ready-made features such as payments, maps, authentication, messaging, and weather without building them from scratch.

---

### 3. What are common authentication methods?

- API Key
- Bearer Token
- OAuth 2.0
- JWT
- Basic Authentication

---

### 4. What format do most REST APIs use?

JSON.

---

### 5. Why should timeouts be configured?

To prevent the application from waiting indefinitely when an external service is slow or unavailable.

---

### 6. Why are retries useful?

Retries help recover from temporary network failures or short-lived service outages.

---

### 7. How should API keys be stored?

Store them securely using environment variables, secret managers, or configuration servers—not in source code.

---

# Quick Revision

- External APIs provide services from other applications.
- Communication happens using HTTP/HTTPS.
- Most APIs exchange data in JSON format.
- Common authentication methods include API Keys and Bearer Tokens.
- Configure timeouts and retries for reliability.
- Handle HTTP errors gracefully.
- Keep API credentials secure.