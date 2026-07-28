# Application Layers

## What are Application Layers?

**Application Layers** are a way of organizing code into different sections where **each layer has a specific responsibility**.

Instead of writing all logic in one class,

Spring Boot separates the application into multiple layers.

The most common layers are:

- Controller Layer
- Service Layer
- Repository Layer
- Database

> **In simple words:**
>
> Application Layers divide an application into smaller parts so that each part has only one responsibility.

---

# Why Do We Need Application Layers?

Imagine building an E-Commerce application.

Without Layers

```
Controller

↓

Business Logic

↓

Validation

↓

Database Query

↓

Response
```

Problems

- Large classes
- Difficult debugging
- Hard to maintain
- Poor code reuse

---

With Layers

```
Controller

↓

Service

↓

Repository

↓

Database
```

Each layer handles one specific responsibility.

---

# Real-World Example

Imagine a restaurant.

```
Customer

↓

Waiter

↓

Chef

↓

Kitchen
```

The customer never goes directly to the kitchen.

Similarly,

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database
```

Each component has a dedicated role.

---

# Spring Boot Layered Architecture

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

# Complete Request Flow

```
Browser

↓

REST API

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Repository

↓

Service

↓

Controller

↓

JSON Response
```

---

# Layer Responsibilities

| Layer | Responsibility |
|--------|----------------|
| Controller | Handles HTTP requests and responses |
| Service | Contains business logic |
| Repository | Interacts with the database |
| Database | Stores application data |

---

# Controller Layer

Responsibilities

- Receive HTTP requests
- Validate request format
- Call Service Layer
- Return HTTP response

Example

```java
@RestController
@RequestMapping("/users")
public class UserController {

}
```

Flow

```
Client

↓

Controller
```

---

# Service Layer

Responsibilities

- Business logic
- Validation
- Transactions
- Calling multiple repositories
- Applying business rules

Example

```java
@Service
public class UserService {

}
```

Flow

```
Controller

↓

Service
```

---

# Repository Layer

Responsibilities

- Database operations
- CRUD
- Queries
- Data access

Example

```java
@Repository
public interface UserRepository

        extends JpaRepository<User, Long>{

}
```

Flow

```
Service

↓

Repository

↓

Database
```

---

# Database Layer

Responsibilities

- Store data
- Retrieve data
- Update records
- Delete records

```
Repository

↓

Database
```

---

# Request Flow Example

Suppose the client requests:

```
GET /users/1
```

Flow

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Repository

↓

Service

↓

Controller

↓

Client
```

---

# Project Structure

```
src

└── main

    └── java

        └── com.example.app

            ├── controller

            ├── service

            ├── repository

            ├── entity

            ├── dto

            ├── config

            ├── exception

            └── Application.java
```

---

# Why Separate Layers?

Suppose business logic changes.

Without Layers

```
Controller Modified

Database Modified

Business Logic Modified
```

Everything changes.

With Layers

```
Business Rule

↓

Service Layer Only
```

Other layers remain unchanged.

---

# Layer Communication

```
Controller

↓

Service

↓

Repository

↓

Database
```

Communication should always flow downward.

Avoid

```
Controller

↓

Database
```

or

```
Repository

↓

Controller
```

---

# Benefits of Layered Architecture

- Loose coupling
- High maintainability
- Better readability
- Easy testing
- Better scalability
- Code reuse

---

# Example

## User Registration

```
Client

↓

POST /users

↓

Controller

↓

Validate Request

↓

Service

↓

Check Email Exists

↓

Repository

↓

Database

↓

Success

↓

Response
```

---

# Responsibilities Summary

## Controller

- Accept Request
- Return Response
- HTTP Status Codes

---

## Service

- Business Rules
- Transactions
- Validation
- Coordination

---

## Repository

- SQL Operations
- CRUD
- Query Methods

---

## Database

- Persist Data
- Retrieve Data

---

# Layered Architecture vs Monolithic Class

## Layered

```
Controller

↓

Service

↓

Repository
```

Each class has one responsibility.

---

## Single Class

```
Controller

↓

Business Logic

↓

SQL

↓

Validation

↓

Everything Together
```

Hard to maintain.

---

# Common Use Cases

- Banking Applications
- E-Commerce Platforms
- Hospital Management Systems
- Food Delivery Apps
- Inventory Systems
- Enterprise Applications

---

# Common Mistakes

❌ Writing business logic inside the Controller.

❌ Accessing the Repository directly from the Controller.

❌ Writing SQL queries inside the Service.

❌ Mixing validation, business logic, and database code in one class.

❌ Making one class responsible for everything.

---

# Real-World Example

## Banking Application

```
Transfer Money

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

## E-Commerce Website

```
Place Order

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

## Food Delivery App

```
Place Order

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

# Advantages

- Clean architecture.
- Easy maintenance.
- Better code organization.
- Easier testing.
- Loose coupling.
- Scalable design.

---

# Best Practices

- Keep Controllers thin.
- Put business logic in the Service Layer.
- Keep Repositories focused on data access.
- Follow the Single Responsibility Principle.
- Use DTOs between layers when exposing APIs.
- Do not bypass layers unless absolutely necessary.

---

# Interview Questions

### 1. What are Application Layers?

Application Layers divide an application into separate components where each layer has a specific responsibility.

---

### 2. What are the common layers in Spring Boot?

- Controller
- Service
- Repository
- Database

---

### 3. Why should business logic not be placed inside the Controller?

Because Controllers should only handle HTTP requests and responses. Business logic belongs in the Service Layer for better maintainability and reusability.

---

### 4. Which layer communicates with the database?

The Repository Layer communicates directly with the database.

---

### 5. Can a Controller directly access a Repository?

Technically yes, but it is **not recommended**. The Controller should call the Service Layer, which then interacts with the Repository.

---

### 6. What is the main benefit of layered architecture?

It improves maintainability, readability, scalability, and follows the Separation of Concerns principle.

---

### 7. What is the typical request flow in a Spring Boot application?

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Repository

↓

Service

↓

Controller

↓

Client
```

---

# Quick Revision

- Application Layers separate responsibilities into different components.
- The standard flow is Controller → Service → Repository → Database.
- Controllers handle HTTP requests and responses.
- Services contain business logic.
- Repositories perform database operations.
- Layered architecture improves maintainability, scalability, and testability.
- Keep each layer focused on a single responsibility.