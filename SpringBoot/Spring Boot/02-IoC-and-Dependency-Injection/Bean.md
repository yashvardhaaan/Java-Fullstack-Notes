# Bean

## What is a Bean?

A **Bean** is an object that is **created, managed, and destroyed by the Spring IoC Container**.

Instead of creating objects using the `new` keyword, Spring creates and manages them as Beans.

> **In simple words:**
>
> A Bean is simply a Java object whose lifecycle is managed by Spring.

---

# Why Do We Need Beans?

Without Spring:

```java
EmployeeService service = new EmployeeService();
```

Problems:

- Manual object creation
- Tight coupling
- Difficult to manage dependencies

With Spring:

```java
@Service
public class EmployeeService {

}
```

Spring automatically creates the object and manages it.

---

# How is a Bean Created?

A Bean can be created in multiple ways.

### 1. Using Stereotype Annotations

```java
@Component
public class EmployeeService {

}
```

Other stereotype annotations:

- `@Component`
- `@Service`
- `@Repository`
- `@Controller`
- `@RestController`

---

### 2. Using `@Bean`

```java
@Configuration
public class AppConfig {

    @Bean
    public EmployeeService employeeService() {
        return new EmployeeService();
    }

}
```

Use `@Bean` when you need to create or configure objects manually.

---

# How Spring Creates a Bean

```
Application Starts
        │
        ▼
Component Scan
        │
        ▼
Finds @Component / @Service / @Repository
        │
        ▼
Creates Bean
        │
        ▼
Stores Bean in IoC Container
```

---

# Bean Lifecycle

```
Bean Creation
      │
      ▼
Dependency Injection
      │
      ▼
Initialization
      │
      ▼
Bean Ready to Use
      │
      ▼
Bean Destruction
```

---

# Bean Example

```java
@Service
public class EmployeeService {

    public void display() {
        System.out.println("Employee Service");
    }

}
```

Spring automatically creates an `EmployeeService` bean and stores it in the IoC Container.

---

# Bean vs Object

| Bean | Object |
|------|--------|
| Managed by Spring | Managed by Developer |
| Created by IoC Container | Created using `new` |
| Supports Dependency Injection | No Dependency Injection |
| Lifecycle managed by Spring | Lifecycle managed manually |

---

# Bean Naming

By default, Spring creates the bean name from the class name.

Example:

```java
@Service
public class EmployeeService {

}
```

Bean Name:

```
employeeService
```

Custom Bean Name:

```java
@Service("empService")
public class EmployeeService {

}
```

Bean Name:

```
empService
```

---

# Bean Scope

By default, every Bean is:

```
Singleton
```

Meaning:

```
One Bean

↓

Shared Throughout the Application
```

To change the scope:

```java
@Component
@Scope("prototype")
public class Employee {

}
```

---

# Where are Beans Stored?

Beans are stored inside the **Spring IoC Container**.

```
Spring IoC Container
│
├── employeeService
├── employeeRepository
├── employeeController
└── dataSource
```

Whenever a bean is needed, Spring retrieves it from the container.

---

# Advantages

- Automatic object creation
- Dependency Injection support
- Better code organization
- Loose coupling
- Easy testing
- Lifecycle management

---

# Best Practices

- Use stereotype annotations (`@Service`, `@Repository`, etc.) for application classes.
- Use `@Bean` for third-party libraries or custom object creation.
- Let Spring manage your objects instead of using `new`.

---

# Interview Questions

### 1. What is a Bean in Spring?

A Bean is a Java object whose lifecycle is managed by the Spring IoC Container.

---

### 2. How can a Bean be created?

- Using stereotype annotations (`@Component`, `@Service`, `@Repository`, `@Controller`)
- Using the `@Bean` annotation inside a `@Configuration` class

---

### 3. What is the difference between a Bean and an Object?

An Object is created manually using `new`, whereas a Bean is created, managed, and injected by the Spring IoC Container.

---

### 4. Where are Beans stored?

Inside the Spring IoC Container.

---

### 5. What is the default scope of a Bean?

**Singleton**

---

### 6. When should you use `@Bean` instead of `@Component`?

Use `@Bean` when creating objects from third-party libraries or when custom object creation/configuration is required.

---

# Quick Revision

- A Bean is a Java object managed by Spring.
- Beans are created by the Spring IoC Container.
- Create Beans using `@Component` or `@Bean`.
- Default Bean scope is **Singleton**.
- Beans support Dependency Injection.
- Avoid creating Spring-managed objects using `new`.