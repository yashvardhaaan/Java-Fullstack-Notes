# Dependency Injection (DI)

## What is Dependency Injection?

**Dependency Injection (DI)** is a design pattern in which the **Spring IoC Container provides the required objects (dependencies) to a class instead of the class creating them itself.**

> **In simple words:**
>
> Instead of creating an object using `new`, Spring automatically provides the required object.

---

# What is a Dependency?

A dependency is an object that another object needs to perform its work.

Example:

```java
public class EmployeeService {

    private EmployeeRepository repository;

}
```

Here,

`EmployeeService` depends on `EmployeeRepository`.

So,

```
EmployeeRepository
        │
        ▼
EmployeeService
```

`EmployeeRepository` is the dependency.

---

# Why Do We Need Dependency Injection?

Without DI:

```java
public class EmployeeService {

    private EmployeeRepository repository = new EmployeeRepository();

}
```

Problems:

- Tight Coupling
- Hard to Test
- Difficult to Maintain
- Difficult to Replace Implementation

---

With DI:

```java
@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository repository;

}
```

Spring creates the object and injects it automatically.

---

# How Dependency Injection Works

```
Application Starts
        │
        ▼
Spring Creates Beans
        │
        ▼
Stores Beans in IoC Container
        │
        ▼
Finds Dependencies
        │
        ▼
Injects Required Beans
```

---

# Types of Dependency Injection

Spring supports three types of Dependency Injection.

## 1. Constructor Injection (Recommended)

```java
@Service
public class EmployeeService {

    private final EmployeeRepository repository;

    public EmployeeService(EmployeeRepository repository) {
        this.repository = repository;
    }
}
```

Advantages:

- Recommended by Spring
- Easier Testing
- Immutable Dependencies
- Mandatory Dependencies

---

## 2. Setter Injection

```java
@Service
public class EmployeeService {

    private EmployeeRepository repository;

    @Autowired
    public void setRepository(EmployeeRepository repository) {
        this.repository = repository;
    }
}
```

Advantages:

- Optional Dependencies
- Dependency can be changed later

---

## 3. Field Injection

```java
@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository repository;

}
```

Advantages:

- Easy to write

Disadvantages:

- Hard to test
- Not recommended for production

---

# Real Example

### Repository

```java
@Repository
public class EmployeeRepository {

    public void save() {
        System.out.println("Employee Saved");
    }

}
```

---

### Service

```java
@Service
public class EmployeeService {

    private final EmployeeRepository repository;

    public EmployeeService(EmployeeRepository repository) {
        this.repository = repository;
    }

    public void addEmployee() {
        repository.save();
    }

}
```

Spring automatically injects `EmployeeRepository` into `EmployeeService`.

---

# Without DI vs With DI

## Without DI

```
EmployeeService

↓

Creates EmployeeRepository

↓

Tight Coupling
```

---

## With DI

```
Spring Container

↓

Creates EmployeeRepository

↓

Injects into EmployeeService

↓

Loose Coupling
```

---

# Benefits of Dependency Injection

- Loose Coupling
- Better Code Reusability
- Easy Unit Testing
- Easy Maintenance
- Easy to Replace Implementations
- Better Readability

---

# Dependency Injection vs Inversion of Control (IoC)

| Dependency Injection | Inversion of Control |
|----------------------|----------------------|
| Technique | Principle |
| Injects Dependencies | Controls Object Creation |
| Implemented by Spring | Achieved using IoC Container |

**IoC** is the concept.

**DI** is one way to achieve IoC.

---

# Best Practices

- Prefer **Constructor Injection**.
- Avoid Field Injection in production code.
- Keep dependencies minimal.
- Let Spring manage object creation.

---

# Interview Questions

### 1. What is Dependency Injection?

Dependency Injection is a design pattern where Spring provides the required dependencies to a class instead of the class creating them itself.

---

### 2. What are the types of Dependency Injection?

- Constructor Injection
- Setter Injection
- Field Injection

---

### 3. Which type of Dependency Injection is recommended?

**Constructor Injection**, because it supports immutability, easier testing, and mandatory dependencies.

---

### 4. What is the difference between DI and IoC?

IoC is the principle of handing over object creation to the framework, while DI is the mechanism used by Spring to provide required dependencies.

---

### 5. What are the advantages of Dependency Injection?

- Loose Coupling
- Better Testing
- Easy Maintenance
- Reusable Code
- Improved Flexibility

---

# Quick Revision

- Dependency Injection means Spring provides required objects automatically.
- A dependency is an object required by another object.
- Spring injects dependencies from the IoC Container.
- Types of DI:
  - Constructor Injection ✅ (Recommended)
  - Setter Injection
  - Field Injection
- DI reduces coupling and improves maintainability.
- IoC is the concept; DI is its implementation.