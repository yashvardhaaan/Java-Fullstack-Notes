# REST Basics

## What is REST?

**REST (Representational State Transfer)** is an **architectural style** used to build web services that allow different applications to communicate over the **HTTP protocol**.

A REST API exposes resources (such as users, products, orders) through URLs and performs operations on them using HTTP methods.

> **In simple words:**
>
> REST is a way for two applications to communicate over the internet using HTTP.

---

# Why Do We Need REST?

Imagine an E-Commerce application.

- Mobile App
- Website
- Admin Panel

All of them need to access the same data.

Instead of each application directly connecting to the database, they communicate through a **REST API**.

```
Mobile App
      │
      ▼
REST API
      ▲
      │
Website
      │
      ▼
Database
```

This makes the system secure, scalable, and reusable.

---

# What is a REST API?

A **REST API** is a web service that follows REST principles and communicates using HTTP.

Example:

```
GET /users
```

Returns all users.

```
POST /users
```

Creates a new user.

---

# What is a Resource?

A **Resource** is any object or data that the API exposes.

Examples:

- User
- Product
- Employee
- Student
- Order

Resources are identified using URLs.

Example:

```
/users

/products

/orders
```

---

# REST Architecture

```
Client
(Mobile/Web)

      │

HTTP Request

      ▼

REST API
(Spring Boot)

      │

Business Logic

      ▼

Database
```

The client sends an HTTP request.

The REST API processes the request and returns an HTTP response.

---

# REST Principles

## 1. Client-Server Architecture

The client and server are independent.

```
Client

↓

Request

↓

Server

↓

Response
```

Example:

- React Application → Client
- Spring Boot Application → Server

---

## 2. Stateless

Every request is independent.

The server **does not remember previous requests**.

Example:

```
Request 1

↓

Server Processes

↓

Response

Request 2

↓

Server Processes Again
```

Each request must contain all the required information.

---

## 3. Uniform Interface

Resources are accessed using consistent URLs.

Example:

```
GET /users

GET /users/101

POST /users

DELETE /users/101
```

---

## 4. Cacheable

Responses can be cached.

Benefits:

- Faster response
- Reduced server load
- Better performance

---

## 5. Layered System

The client does not know whether it is communicating with:

- API Gateway
- Load Balancer
- Microservice
- Actual Server

Example:

```
Client

↓

Load Balancer

↓

API Gateway

↓

Spring Boot

↓

Database
```

---

# HTTP Methods Used in REST

| Method | Purpose |
|---------|----------|
| GET | Read Data |
| POST | Create Data |
| PUT | Update Entire Resource |
| PATCH | Update Partial Resource |
| DELETE | Delete Data |

Example:

```
GET /employees

POST /employees

PUT /employees/101

DELETE /employees/101
```

---

# Request and Response

### HTTP Request

```
GET /employees/101
```

---

### HTTP Response

```json
{
  "id": 101,
  "name": "John",
  "department": "IT"
}
```

---

# REST URL Design

Good URLs:

```
/employees

/employees/101

/products

/orders
```

Avoid:

```
/getEmployees

/createEmployee

/deleteEmployee
```

Use **nouns**, not verbs.

---

# REST vs SOAP

| REST | SOAP |
|------|------|
| Architectural Style | Protocol |
| Uses HTTP | Uses XML-based Messaging |
| Lightweight | Heavyweight |
| Faster | Slower |
| Mostly JSON | Mostly XML |
| Widely Used | Enterprise Legacy Systems |

---

# Real-World Example

### Food Delivery App

```
Customer

↓

Mobile App

↓

REST API

↓

Restaurant Database
```

When you order food:

```
POST /orders
```

When you check your order:

```
GET /orders/1001
```

The mobile app communicates with the backend using REST APIs.

---

# Advantages

- Simple to understand
- Platform independent
- Lightweight
- Fast communication
- Supports JSON and XML
- Easy to scale
- Widely used in modern applications

---

# Best Practices

- Use nouns for resource names.
- Use proper HTTP methods.
- Keep APIs stateless.
- Return meaningful HTTP status codes.
- Use JSON as the default response format.
- Design clean and consistent URLs.

---

# Interview Questions

### 1. What is REST?

REST (Representational State Transfer) is an architectural style for designing web services that communicate over HTTP.

---

### 2. What is a REST API?

A REST API is a web service that follows REST principles and allows clients to perform operations on resources using HTTP methods.

---

### 3. What is a Resource?

A resource is any object or data exposed by a REST API, such as a user, product, or order.

---

### 4. Why is REST called Stateless?

Because the server does not store client state between requests. Every request contains all the information needed to process it.

---

### 5. What are the common HTTP methods used in REST?

- GET
- POST
- PUT
- PATCH
- DELETE

---

### 6. Why is REST popular?

Because it is simple, lightweight, scalable, platform-independent, and works well with HTTP and JSON.

---

# Quick Revision

- REST stands for **Representational State Transfer**.
- REST is an architectural style for building web services.
- REST APIs communicate over HTTP.
- Resources are identified using URLs.
- REST follows principles like Statelessness, Client-Server, Uniform Interface, Cacheability, and Layered System.
- Common HTTP methods are GET, POST, PUT, PATCH, and DELETE.
- Use nouns in URLs and proper HTTP methods for clean API design.