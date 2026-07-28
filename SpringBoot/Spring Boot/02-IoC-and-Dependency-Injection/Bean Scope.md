# Bean Scope

## What is Bean Scope?

**Bean Scope** defines **how many instances of a Spring Bean are created** and **how long they live** in the Spring IoC Container.

> **In simple words:**
>
> Bean Scope tells Spring:
> **"Should I create one object or multiple objects for this bean?"**

---

# Why Do We Need Bean Scope?

Different applications have different requirements.

For example:

- A database service should have only one object.
- A shopping cart should have a separate object for each user.

Bean Scope allows us to control this behavior.

---

# Types of Bean Scopes

Spring provides six bean scopes:

| Scope | Description |
|--------|-------------|
| singleton | One object for the entire Spring Container (Default) |
| prototype | A new object every time the bean is requested |
| request | One object per HTTP request |
| session | One object per HTTP session |
| application | One object per ServletContext |
| websocket | One object per WebSocket session |

---

# 1. Singleton Scope (Default)

Only **one instance** of the bean is created.

```java
@Component
@Scope("singleton")
public class EmployeeService {

}
```

Or simply:

```java
@Component
public class EmployeeService {

}
```

Since `singleton` is the default scope, `@Scope("singleton")` is optional.

### Example

```
EmployeeService

↓

Spring Container

↓

One Object

↓

Shared Everywhere
```

---

# 2. Prototype Scope

A **new object** is created every time the bean is requested.

```java
@Component
@Scope("prototype")
public class Employee {

}
```

### Example

```
Request 1

↓

Object A

Request 2

↓

Object B

Request 3

↓

Object C
```

Each request gets a different object.

---

# 3. Request Scope

Available only in **Spring Web Applications**.

One bean is created for **each HTTP request**.

```java
@Component
@RequestScope
public class UserRequest {

}
```

Example:

```
Request 1

↓

Object A

Request 2

↓

Object B
```

---

# 4. Session Scope

One bean is created for each user session.

```java
@Component
@SessionScope
public class ShoppingCart {

}
```

Example:

```
User A

↓

ShoppingCart A

User B

↓

ShoppingCart B
```

---

# 5. Application Scope

Only one bean exists for the entire web application.

```java
@Component
@ApplicationScope
public class AppConfiguration {

}
```

Shared across all users.

---

# 6. WebSocket Scope

One bean is created for each WebSocket connection.

```java
@Component
@Scope("websocket")
public class ChatSession {

}
```

Used in:

- Chat Applications
- Live Notifications
- Real-time Messaging

---

# How Bean Scope Works

```
Application Starts
        │
        ▼
Spring Creates Bean
        │
        ▼
Apply Bean Scope
        │
        ▼
Store in IoC Container
```

---

# Singleton vs Prototype

| Feature | Singleton | Prototype |
|---------|-----------|-----------|
| Number of Objects | One | Multiple |
| Default Scope | Yes | No |
| Memory Usage | Low | Higher |
| Shared | Yes | No |
| Use Case | Services, Repositories | Temporary Objects |

---

# Real-World Example

### Singleton

Think of a **CEO** in a company.

There is only **one CEO** for the entire company.

Similarly, Spring creates only one Singleton bean.

---

### Prototype

Think of **ID Cards**.

Every employee has a different ID card.

Similarly, every request gets a new Prototype bean.

---

# When to Use Which Scope?

| Scope | Common Use Cases |
|--------|------------------|
| Singleton | Service, Repository, Controller |
| Prototype | Temporary Objects, Reports |
| Request | HTTP Request Data |
| Session | Shopping Cart, Logged-in User |
| Application | Shared Configuration |
| WebSocket | Chat Sessions |

---

# Advantages

- Better memory management
- Improved performance
- Flexible object lifecycle
- Supports web-specific scopes
- Easy to configure

---

# Best Practices

- Use **Singleton** for stateless beans like services and repositories.
- Use **Prototype** only when a new object is required each time.
- Use **Request** and **Session** scopes only in web applications.
- Avoid unnecessary Prototype beans, as they increase memory usage.

---

# Interview Questions

### 1. What is Bean Scope?

Bean Scope defines the lifecycle and the number of instances created for a Spring Bean.

---

### 2. What is the default bean scope in Spring?

**Singleton**

---

### 3. What is the difference between Singleton and Prototype?

- **Singleton:** One shared object for the entire container.
- **Prototype:** A new object is created every time the bean is requested.

---

### 4. Which bean scope is used for a shopping cart?

**Session Scope**

---

### 5. Which bean scope is used for REST request-specific data?

**Request Scope**

---

### 6. How do you specify a bean scope?

Using the `@Scope` annotation.

Example:

```java
@Scope("prototype")
```

---

# Quick Revision

- Bean Scope defines how many bean instances Spring creates.
- Default scope is **Singleton**.
- **Prototype** creates a new object every time.
- **Request** creates one object per HTTP request.
- **Session** creates one object per user session.
- **Application** creates one object for the entire web application.
- **WebSocket** creates one object per WebSocket connection.
- Use `@Scope` to define a bean's scope.