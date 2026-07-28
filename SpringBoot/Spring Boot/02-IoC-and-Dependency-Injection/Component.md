# @Component

## What is @Component?

`@Component` is a Spring annotation used to mark a Java class as a **Spring Bean**.

When Spring performs **Component Scanning**, it automatically detects classes annotated with `@Component`, creates their objects, and stores them in the **Spring IoC Container**.

> **In simple words:**
>
> `@Component` tells Spring:
> **"Create and manage an object of this class."**

---

# Why Do We Need @Component?

Without Spring:

```java
Employee employee = new Employee();
```

You have to manually create objects.

With Spring:

```java
@Component
public class Employee {

}
```

Spring automatically creates and manages the object.

---

# How @Component Works

```
Application Starts
        │
        ▼
Component Scan
        │
        ▼
Finds @Component
        │
        ▼
Creates Bean
        │
        ▼
Stores Bean in IoC Container
```

---

# Syntax

```java
@Component
public class EmployeeService {

}
```

Spring automatically creates an `EmployeeService` bean.

---

# Example

### EmployeeService.java

```java
@Component
public class EmployeeService {

    public void display() {
        System.out.println("Employee Service");
    }

}
```

### Controller

```java
@RestController
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

}
```

Spring injects the `EmployeeService` bean automatically.

---

# Bean Name

By default, Spring creates the bean name from the class name.

Example:

```java
@Component
public class EmployeeService {

}
```

Bean Name:

```
employeeService
```

Custom Bean Name:

```java
@Component("empService")
public class EmployeeService {

}
```

Bean Name:

```
empService
```

---

# @Component vs @Bean

## @Component

- Used on classes
- Automatically detected by Component Scan
- Best for application classes

Example:

```java
@Component
public class EmployeeService {

}
```

---

## @Bean

- Used on methods
- Declared inside a `@Configuration` class
- Best for third-party classes or custom object creation

Example:

```java
@Configuration
public class AppConfig {

    @Bean
    public EmployeeService employeeService() {
        return new EmployeeService();
    }

}
```

---

# @Component vs Stereotype Annotations

Spring provides specialized versions of `@Component`.

| Annotation | Used For |
|------------|----------|
| `@Component` | Generic Spring Bean |
| `@Service` | Business Logic |
| `@Repository` | Database Layer |
| `@Controller` | MVC Controller |
| `@RestController` | REST API Controller |

All of these are internally based on `@Component`.

---

# How Spring Detects @Component

```
@ComponentScan
        │
        ▼
Search Packages
        │
        ▼
Find @Component
        │
        ▼
Create Bean
        │
        ▼
Register in IoC Container
```

---

# Advantages

- Automatic Bean creation
- Supports Dependency Injection
- Reduces boilerplate code
- Easy to maintain
- Managed by Spring IoC Container

---

# Best Practices

- Use `@Component` for generic helper or utility classes.
- Use specialized annotations like `@Service`, `@Repository`, and `@RestController` when applicable because they improve readability and express the class's responsibility.

---

# Interview Questions

### 1. What is `@Component`?

`@Component` is a Spring annotation that marks a class as a Spring-managed Bean.

---

### 2. What does `@Component` do?

It tells Spring to create an object of the class and register it in the IoC Container.

---

### 3. How does Spring detect `@Component`?

Using **Component Scanning** (`@ComponentScan`).

---

### 4. What is the difference between `@Component` and `@Bean`?

- `@Component` is placed on classes and is discovered automatically.
- `@Bean` is placed on methods inside a `@Configuration` class and is used for manual bean creation.

---

### 5. What are the stereotype annotations in Spring?

- `@Component`
- `@Service`
- `@Repository`
- `@Controller`
- `@RestController`

---

# Quick Revision

- `@Component` marks a class as a Spring Bean.
- Spring detects it during Component Scanning.
- The created Bean is stored in the IoC Container.
- Default bean name is the class name with the first letter in lowercase.
- `@Component` is the parent annotation of `@Service`, `@Repository`, and `@Controller`.
- Use `@Component` for generic Spring-managed classes.