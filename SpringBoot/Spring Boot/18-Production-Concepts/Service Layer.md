# Service Layer

## What is the Service Layer?

The **Service Layer** contains the **business logic** of the application.

It acts as a bridge between the **Controller Layer** and the **Repository Layer**.

The Service Layer is responsible for:

- Applying business rules
- Processing data
- Coordinating multiple repositories
- Managing transactions
- Returning results to the Controller

> **In simple words:**
>
> The Service Layer is the brain of the application where all business decisions are made.

---

# Why Do We Need the Service Layer?

Imagine a user wants to place an order.

Without Service Layer

```
Controller

↓

Validation

↓

Business Logic

↓

Database Query

↓

Response
```

Problems

- Large Controllers
- Difficult testing
- Code duplication
- Poor maintainability

---

With Service Layer

```
Controller

↓

Service

↓

Repository

↓

Database
```

Each layer has a single responsibility.

---

# Real-World Example

Imagine ordering food.

```
Customer

↓

Waiter

↓

Chef

↓

Kitchen
```

The waiter doesn't cook the food.

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

The Service Layer performs the actual business work.

---

# Service Layer Architecture

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

# Responsibilities

The Service Layer is responsible for:

- Business Logic
- Validation
- Transactions
- Calling multiple repositories
- Data transformation
- Coordinating application flow

It **should not contain SQL queries**.

---

# @Service Annotation

```java
@Service
public class UserService {

}
```

`@Service` tells Spring that this class contains business logic.

Spring automatically manages it as a Bean.

---

# Dependency Injection

The Service usually injects one or more repositories.

```java
@Service
public class UserService {

    private final UserRepository repository;

    public UserService(

            UserRepository repository

    ){

        this.repository = repository;

    }

}
```

---

# Example Service

```java
@Service
public class UserService {

    private final UserRepository repository;

    public UserService(

            UserRepository repository

    ){

        this.repository = repository;

    }

    public User getUser(

            Long id

    ){

        return repository.findById(id)

                .orElseThrow();

    }

}
```

---

# Business Logic Example

Suppose users must be at least 18 years old.

```java
public User register(

        UserRequest request

){

    if(request.getAge() < 18){

        throw new IllegalArgumentException(

                "Age must be at least 18"

        );

    }

    return repository.save(

            new User()

    );

}
```

The age validation belongs in the Service Layer.

---

# Calling Multiple Repositories

Sometimes one operation requires multiple repositories.

```
Place Order

↓

Product Repository

↓

Customer Repository

↓

Order Repository
```

Example

```java
@Service
public class OrderService {

    private final ProductRepository productRepository;

    private final CustomerRepository customerRepository;

    private final OrderRepository orderRepository;

}
```

---

# Service Request Flow

```
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
```

---

# Transaction Management

Business operations often involve multiple database updates.

```java
@Transactional
public void transferMoney(

        Long from,

        Long to,

        Double amount

){

    // Debit

    // Credit

}
```

If one operation fails,

everything rolls back.

```
Start

↓

Debit

↓

Credit Failed

↓

Rollback
```

---

# Service with DTO

```java
public UserResponse createUser(

        UserRequest request

){

    User user = mapper.toEntity(request);

    repository.save(user);

    return mapper.toResponse(user);

}
```

The Service converts DTOs using a Mapper and interacts with the Repository.

---

# Exception Handling

The Service throws exceptions when business rules fail.

```java
if(user == null){

    throw new UserNotFoundException();

}
```

The Controller (or Global Exception Handler) returns the appropriate HTTP response.

---

# Service vs Controller

| Service | Controller |
|----------|------------|
| Business logic | Handles HTTP requests |
| Validation | Reads request data |
| Calls Repository | Returns HTTP response |
| Manages transactions | Calls Service |

---

# Service vs Repository

| Service | Repository |
|----------|------------|
| Business rules | Database operations |
| Calls repositories | Executes queries |
| Transaction management | CRUD methods |
| No SQL | SQL/JPQL interaction |

---

# Complete Request Flow

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

# Common Use Cases

- User Registration
- Login
- Money Transfer
- Product Purchase
- Order Creation
- Inventory Management

---

# Common Mistakes

❌ Writing SQL queries inside the Service.

❌ Calling the Database directly from the Service without a Repository.

❌ Putting business logic inside the Controller.

❌ Creating very large Service classes with unrelated responsibilities.

❌ Ignoring transaction management for multiple database operations.

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

Validate Balance

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

Service

↓

Check Stock

↓

Save Order

↓

Reduce Inventory
```

---

## Food Delivery App

```
Place Order

↓

Service

↓

Check Restaurant

↓

Assign Delivery Partner

↓

Save Order
```

---

# Advantages

- Separates business logic from presentation.
- Improves maintainability.
- Easier to test.
- Supports transaction management.
- Promotes code reuse.
- Follows Separation of Concerns.

---

# Best Practices

- Keep Controllers thin.
- Put all business rules in the Service Layer.
- Use constructor injection.
- Use `@Transactional` for operations involving multiple database updates.
- Keep Services focused on one business domain.
- Use DTOs and Mappers to separate API models from Entities.

---

# Interview Questions

### 1. What is the Service Layer?

The Service Layer contains business logic and acts as a bridge between the Controller and Repository layers.

---

### 2. What annotation is used to define a Service?

```java
@Service
```

---

### 3. Should SQL queries be written inside the Service Layer?

No. SQL and database access belong in the Repository Layer.

---

### 4. Why is the Service Layer important?

It keeps Controllers clean, centralizes business logic, improves maintainability, and supports transaction management.

---

### 5. Can a Service call multiple Repositories?

Yes. A Service often coordinates multiple repositories to complete a business operation.

---

### 6. Why is `@Transactional` commonly used in the Service Layer?

Because it ensures that multiple database operations succeed or fail as a single unit (atomic transaction).

---

### 7. Can one Service call another Service?

Yes. When business operations span multiple domains, one Service can call another Service, but this should be done carefully to avoid tight coupling and circular dependencies.

---

# Quick Revision

- The Service Layer contains business logic.
- It sits between the Controller and Repository layers.
- Use `@Service` to define Service classes.
- Services coordinate repositories and manage transactions.
- Keep SQL queries in the Repository Layer.
- Use `@Transactional` for multi-step database operations.
- Keep Services focused, reusable, and free of presentation logic.