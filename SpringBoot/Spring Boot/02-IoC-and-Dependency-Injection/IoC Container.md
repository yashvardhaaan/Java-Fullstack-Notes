# IoC Container

## What is an IoC Container?

The **IoC (Inversion of Control) Container** is the **core component of the Spring Framework** responsible for creating, configuring, managing, and destroying Spring Beans.

> **In simple words:**
>
> The IoC Container is like a **manager** that creates objects, stores them, injects dependencies, and manages their entire lifecycle.

---

# What is Inversion of Control (IoC)?

Normally, a class creates its own dependencies.

Example:

```java
EmployeeRepository repository = new EmployeeRepository();
```

With IoC, the responsibility of creating and managing objects is **transferred to the Spring Framework**.

```
Without IoC

Developer

↓

Creates Objects

-----------------------

With IoC

Spring Container

↓

Creates Objects
```

---

# Why Do We Need an IoC Container?

Without an IoC Container:

- Manual object creation
- Tight coupling
- Difficult testing
- Difficult maintenance

With an IoC Container:

- Automatic object creation
- Dependency Injection
- Loose coupling
- Centralized object management

---

# Responsibilities of the IoC Container

The IoC Container is responsible for:

- Creating Beans
- Managing Bean lifecycle
- Injecting Dependencies
- Managing Bean Scope
- Configuring Beans
- Destroying Beans when required

---

# How IoC Container Works

```
Application Starts
        │
        ▼
Read Configuration
(@Component, @Bean, etc.)
        │
        ▼
Component Scan
        │
        ▼
Create Beans
        │
        ▼
Store Beans
        │
        ▼
Inject Dependencies
        │
        ▼
Application Ready
```

---

# Bean Management Example

### Repository

```java
@Repository
public class EmployeeRepository {

}
```

### Service

```java
@Service
public class EmployeeService {

    private final EmployeeRepository repository;

    public EmployeeService(EmployeeRepository repository) {
        this.repository = repository;
    }

}
```

Spring performs the following steps:

1. Creates `EmployeeRepository` Bean.
2. Creates `EmployeeService` Bean.
3. Injects `EmployeeRepository` into `EmployeeService`.
4. Stores both Beans in the IoC Container.

---

# Types of IoC Containers

Spring provides two main IoC Containers.

## 1. BeanFactory

- Basic IoC Container
- Creates Beans lazily (only when needed)
- Lightweight
- Suitable for simple applications

Example:

```java
BeanFactory factory = new XmlBeanFactory(resource);
```

> **Note:** `XmlBeanFactory` is deprecated and mainly seen in older Spring applications.

---

## 2. ApplicationContext (Recommended)

- Advanced IoC Container
- Supports Dependency Injection
- Supports Event Handling
- Supports Internationalization (i18n)
- Supports Bean Post Processors
- Pre-instantiates Singleton Beans by default

Example:

```java
ApplicationContext context =
        new AnnotationConfigApplicationContext(AppConfig.class);
```

In Spring Boot, the `ApplicationContext` is created automatically when the application starts.

---

# BeanFactory vs ApplicationContext

| Feature | BeanFactory | ApplicationContext |
|---------|-------------|--------------------|
| Bean Loading | Lazy | Eager (Singletons) |
| Dependency Injection | Yes | Yes |
| Event Support | No | Yes |
| Internationalization | No | Yes |
| Recommended | No | Yes |

---

# Real-World Example

Imagine a **hotel**.

Without a manager:

- Every guest finds a room on their own.
- Every guest arranges cleaning and food.

With a manager:

- The manager assigns rooms.
- The manager arranges services.
- Guests simply use the room.

Similarly:

- **Hotel Manager → IoC Container**
- **Room → Bean**
- **Guest → Application Class**

The IoC Container manages everything so your classes can focus on business logic.

---

# Advantages

- Loose Coupling
- Automatic Dependency Injection
- Centralized Bean Management
- Better Testability
- Easier Maintenance
- Better Code Reusability

---

# Best Practices

- Use `ApplicationContext` in modern Spring applications.
- Let Spring manage application objects instead of creating them with `new`.
- Prefer Constructor Injection with the IoC Container.
- Keep Beans stateless whenever possible.

---

# Interview Questions

### 1. What is an IoC Container?

An IoC Container is the core Spring component that creates, manages, configures, and destroys Spring Beans.

---

### 2. What is the difference between IoC and Dependency Injection?

- **IoC** is the principle of handing over object creation and management to the framework.
- **Dependency Injection** is the technique used by Spring to provide required dependencies.

---

### 3. What are the two types of IoC Containers?

- `BeanFactory`
- `ApplicationContext`

---

### 4. Which IoC Container is used in Spring Boot?

**ApplicationContext**

---

### 5. What are the responsibilities of the IoC Container?

- Create Beans
- Manage Bean Lifecycle
- Inject Dependencies
- Manage Bean Scope
- Configure Beans
- Destroy Beans

---

# Quick Revision

- IoC Container is the heart of the Spring Framework.
- It creates, manages, and destroys Spring Beans.
- It performs Dependency Injection automatically.
- `ApplicationContext` is the most commonly used IoC Container.
- `BeanFactory` is the basic container, while `ApplicationContext` provides additional enterprise features.
- IoC improves maintainability, flexibility, and testability.