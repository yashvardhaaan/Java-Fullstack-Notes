# JWT (JSON Web Token)

## What is JWT?

**JWT (JSON Web Token)** is an open standard (RFC 7519) used to securely transmit information between two parties as a **JSON object**.

In Spring Boot, JWT is mainly used for **authentication and authorization** in REST APIs.

Unlike Session Authentication, JWT is **stateless**, meaning the server does not store any session information.

> **In simple words:**
>
> JWT is a digital identity card that proves who you are after logging in.

---

# Why Do We Need JWT?

Imagine an API:

```
GET /api/orders
```

Without JWT:

Every request requires checking the database or maintaining a server session.

```
Client

↓

Login

↓

Server Creates Session

↓

Server Stores Session
```

Problems:

- Server memory increases.
- Difficult to scale.
- Sessions must be synchronized across servers.

---

With JWT:

```
Client

↓

Login

↓

Server Generates JWT

↓

Client Stores JWT

↓

JWT Sent With Every Request

↓

Server Verifies JWT

↓

Response
```

No session is stored on the server.

---

# What Does JWT Stand For?

```
J → JSON

W → Web

T → Token
```

---

# JWT Authentication Flow

```
User

↓

Login

↓

Username & Password

↓

Server Verifies Credentials

↓

Generate JWT

↓

Return JWT

↓

Client Stores JWT

↓

Future Requests

↓

Authorization Header

↓

Server Validates JWT

↓

Access Granted
```

---

# JWT Structure

A JWT consists of **three parts** separated by dots (`.`).

```
Header

.

Payload

.

Signature
```

Example

```
xxxxx.yyyyy.zzzzz
```

---

# JWT Architecture

```
JWT

│

├── Header

├── Payload

└── Signature
```

---

# 1. Header

The Header contains information about the token.

Example

```json
{
    "alg": "HS256",
    "typ": "JWT"
}
```

Explanation

```
alg

↓

Signing Algorithm
```

```
typ

↓

Token Type
```

---

# 2. Payload

The Payload contains user information called **Claims**.

Example

```json
{
    "sub": "yash",
    "role": "ADMIN",
    "exp": 1754000000
}
```

Common Claims

| Claim | Meaning |
|--------|----------|
| sub | Subject (Username) |
| exp | Expiration Time |
| iat | Issued At |
| iss | Issuer |
| role | User Role |

---

# 3. Signature

The Signature verifies that the JWT has not been modified.

```
Header

+

Payload

+

Secret Key

↓

Hash Algorithm

↓

Signature
```

If someone changes the Payload,

the Signature becomes invalid.

---

# Complete JWT Structure

```
Header

↓

Base64 Encode

+

Payload

↓

Base64 Encode

+

Signature

↓

JWT Token
```

Example

```
eyJhbGciOiJIUzI1Ni...

.

eyJzdWIiOiJ5YXNo...

.

SflKxwRJSMeKKF2...
```

---

# JWT Login Flow

```
User

↓

POST /login

↓

Username & Password

↓

AuthenticationManager

↓

Database

↓

Generate JWT

↓

Return JWT

↓

Client
```

---

# Using JWT

Client stores the token.

Every request includes:

```http
Authorization: Bearer <JWT_TOKEN>
```

Example

```http
GET /api/users

Authorization:

Bearer eyJhbGciOiJIUzI1Ni...
```

---

# JWT Request Flow

```
Client

↓

HTTP Request

↓

Authorization Header

↓

Bearer Token

↓

Spring Security

↓

Validate JWT

↓

Extract Username

↓

Authenticate User

↓

Controller

↓

Response
```

---

# Stateless Authentication

Session Authentication

```
Client

↓

Session ID

↓

Server Memory
```

JWT Authentication

```
Client

↓

JWT

↓

No Server Session
```

JWT is **stateless**.

---

# JWT Lifecycle

```
Login

↓

Generate JWT

↓

Store Token

↓

Send Token

↓

Validate Token

↓

Access Resource

↓

Token Expires

↓

Login Again
```

---

# Advantages of JWT

- Stateless Authentication
- Faster than Session Authentication
- Scalable
- Suitable for Microservices
- Works well with REST APIs
- Supports distributed systems

---

# Disadvantages of JWT

- Cannot be revoked easily.
- Larger than Session IDs.
- If stolen, it can be used until expiration.
- Secret key must be protected.

---

# Session Authentication vs JWT

| Session Authentication | JWT Authentication |
|------------------------|-------------------|
| Stateful | Stateless |
| Server stores session | Client stores token |
| Uses Session ID | Uses JWT |
| Requires server memory | No server memory |
| Better for traditional MVC | Better for REST APIs |

---

# JWT vs OAuth2

| JWT | OAuth2 |
|------|---------|
| Token format | Authorization framework |
| Stores user information | Delegates authentication |
| Used in APIs | Used for Login with Google, GitHub, etc. |
| Self-contained token | May use JWT internally |

---

# Common JWT Claims

| Claim | Description |
|--------|-------------|
| sub | Username |
| exp | Expiration Time |
| iat | Issued Time |
| iss | Issuer |
| aud | Audience |
| role | User Role |

---

# JWT Validation

When a request arrives,

Spring checks:

```
Token Present?

↓

Yes

↓

Signature Valid?

↓

Yes

↓

Expired?

↓

No

↓

Authenticated

↓

Controller
```

Otherwise

```
401 Unauthorized
```

---

# JWT Authentication Architecture

```
Client

↓

Login

↓

Spring Security

↓

AuthenticationManager

↓

Database

↓

Generate JWT

↓

Return Token

↓

Client Stores JWT

↓

Authorization Header

↓

JWT Validation

↓

Controller
```

---

# Real-World Example

## Banking Application

```
Customer

↓

Login

↓

JWT Generated

↓

Transfer Money

↓

JWT Verified

↓

Success
```

---

## E-Commerce Application

```
Customer

↓

Login

↓

JWT

↓

View Orders

↓

Authenticated
```

---

## Food Delivery App

```
User

↓

Login

↓

JWT

↓

Place Order

↓

Success
```

---

# Advantages

- Stateless authentication
- Highly scalable
- Secure when properly implemented
- Reduces server memory usage
- Ideal for REST APIs and Microservices
- Easy integration with Spring Security

---

# Best Practices

- Always use HTTPS.
- Keep JWT expiration short.
- Never store sensitive information in the Payload.
- Protect the signing secret key.
- Use Refresh Tokens for long-lived sessions.
- Always validate the Signature and Expiration time.
- Send JWT using the `Authorization` header with the `Bearer` prefix.

---

# Interview Questions

### 1. What is JWT?

JWT (JSON Web Token) is a compact, self-contained token used for authentication and authorization in stateless applications.

---

### 2. What are the three parts of a JWT?

- Header
- Payload
- Signature

---

### 3. Where is JWT stored?

Usually on the client side (for example, in browser storage or a secure cookie), depending on the application's security requirements.

---

### 4. How is JWT sent to the server?

Using the HTTP Authorization header.

```http
Authorization: Bearer <TOKEN>
```

---

### 5. Why is JWT called stateless?

Because the server does not store session information. Each request contains all the information needed to identify the user.

---

### 6. Can the Payload be read?

Yes.

The Header and Payload are **Base64URL encoded**, **not encrypted**. Sensitive information should never be stored in them.

---

### 7. What is the purpose of the Signature?

The Signature ensures the token has not been modified and verifies that it was issued by a trusted source.

---

# Quick Revision

- JWT stands for **JSON Web Token**.
- JWT is used for stateless authentication.
- A JWT consists of **Header**, **Payload**, and **Signature**.
- The client sends the JWT in the `Authorization: Bearer <token>` header.
- The server validates the token before granting access.
- JWT does not require server-side sessions.
- Never store sensitive data in the Payload.
- Always use HTTPS, validate expiration, and protect the signing key.