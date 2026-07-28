# @Autowired

## What is @Autowired?

`@Autowired` is a Spring annotation used to **automatically inject (provide) the required dependency into a class**.

Instead of creating objects manually using `new`, Spring creates the object and injects it where needed.

> **In simple words:**  
> `@Autowired` tells Spring:
> **"Find the required bean from the IoC Container and inject it here."**

---

# Why Do We Need @Autowired?

Without `@Autowired`:

```java
public class EmployeeService {

    private EmployeeRepository repository = new EmployeeRepository();

}
```

Problems:

- Tight coupling
- Hard to test
- Spring cannot manage the object

With `@Autowired`:

```java
@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository repository;

}
```

Spring automatically injects the `EmployeeRepository` bean.

---

# How @Autowired Works

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
Finds @Autowired
        │
        ▼
Injects Matching Bean
```

---

# Types of Dependency Injection

## 1. Constructor Injection (Recommended)

```java
@Service
public class EmployeeService {

    private final EmployeeRepository repository;

    @Autowired
    public EmployeeService(EmployeeRepository repository) {
        this.repository = repository;
    }
}
```

> Since Spring 4.3, if a class has only one constructor, `@Autowired` is optional.

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

Used when the dependency is optional or can change.

---

## 3. Field Injection

```java
@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository repository;

}
```

Easy to write, but **not recommended** for production code because it is difficult to test.

---

# Example

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

    @Autowired
    private EmployeeRepository repository;

    public void saveEmployee() {
        repository.save();
    }

}
```

Spring automatically injects `EmployeeRepository` into `EmployeeService`.

---

# What Happens Internally?

```
@ComponentScan
        │
        ▼
Spring Creates EmployeeRepository Bean
        │
        ▼
Spring Creates EmployeeService Bean
        │
        ▼
Finds @Autowired
        │
        ▼
Injects EmployeeRepository Bean
```

---

# Required Dependency

By default, `@Autowired` is required.

If no matching bean is found, Spring throws:

```
NoSuchBeanDefinitionException
```

---

# Optional Dependency

```java
@Autowired(required = false)
private EmployeeRepository repository;
```

If the bean is not available, Spring injects `null` instead of throwing an exception.

---

# Advantages

- Reduces boilerplate code
- Loose coupling
- Easier maintenance
- Better testability (with constructor injection)
- Managed by Spring IoC Container

---

# Best Practice

✅ Prefer **Constructor Injection**

```java
@Service
public class EmployeeService {

    private final EmployeeRepository repository;

    public EmployeeService(EmployeeRepository repository) {
        this.repository = repository;
    }
}
```

Avoid field injection in production applications.

---

# Interview Questions

### 1. What is `@Autowired`?

`@Autowired` is used to automatically inject a required bean from the Spring IoC Container into another bean.

---

### 2. What are the different types of dependency injection?

- Constructor Injection
- Setter Injection
- Field Injection

---

### 3. Which type of injection is recommended?

**Constructor Injection**, because it supports immutability, easier testing, and mandatory dependencies.

---

### 4. What happens if no matching bean is found?

Spring throws a `NoSuchBeanDefinitionException` unless `required = false` is used.

---

### 5. Is `@Autowired` required on a single constructor?

No. Since Spring 4.3, if a class has only one constructor, Spring injects it automatically.

---

# Quick Revision

- `@Autowired` performs automatic dependency injection.
- It injects beans from the Spring IoC Container.
- Supports Constructor, Setter, and Field Injection.
- Constructor Injection is the recommended approach.
- By default, dependencies are required.
- Spring resolves dependencies during application startup.