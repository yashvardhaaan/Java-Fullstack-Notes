# @Configuration

## What is `@Configuration`?

`@Configuration` is a Spring annotation that marks a class as a **configuration class**. It tells Spring that this class contains **Bean definitions** that should be managed by the Spring IoC Container.

> **In simple words:**
>
> `@Configuration` tells Spring:
> **"This class contains instructions for creating and configuring Beans."**

---

# Why Do We Need `@Configuration`?

Sometimes, we need to create Beans manually instead of using `@Component`.

For example:

- Third-party library classes
- Custom object creation
- Bean customization
- Multiple Bean configurations

Instead of annotating every class with `@Component`, we can define Beans inside a configuration class.

---

# Basic Syntax

```java
@Configuration
public class AppConfig {

}
```

This class becomes a Spring Configuration class.

---

# Creating Beans Using `@Bean`

Inside a configuration class, use the `@Bean` annotation.

```java
@Configuration
public class AppConfig {

    @Bean
    public EmployeeService employeeService() {
        return new EmployeeService();
    }

}
```

Spring creates an `EmployeeService` Bean and stores it in the IoC Container.

---

# Complete Example

### EmployeeService.java

```java
public class EmployeeService {

    public void display() {
        System.out.println("Employee Service");
    }

}
```

---

### Configuration Class

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

### Using the Bean

```java
ApplicationContext context =
        new AnnotationConfigApplicationContext(AppConfig.class);

EmployeeService service =
        context.getBean(EmployeeService.class);

service.display();
```

Output:

```
Employee Service
```

---

# How `@Configuration` Works

```
Application Starts
        │
        ▼
Reads @Configuration
        │
        ▼
Finds @Bean Methods
        │
        ▼
Creates Beans
        │
        ▼
Stores Beans in IoC Container
```

---

# `@Configuration` vs `@Component`

| `@Configuration` | `@Component` |
|------------------|--------------|
| Used for configuration classes | Used for general Spring Beans |
| Contains `@Bean` methods | Represents a single Bean |
| Defines multiple Beans | Creates one Bean per class |

---

# `@Bean` vs `@Component`

## Using `@Component`

```java
@Component
public class EmployeeService {

}
```

Spring creates the Bean automatically using Component Scanning.

---

## Using `@Bean`

```java
@Bean
public EmployeeService employeeService() {
    return new EmployeeService();
}
```

Spring creates the Bean using the method inside a configuration class.

---

# Why Use `@Bean`?

`@Bean` is useful when:

- You cannot modify the source code.
- The class belongs to a third-party library.
- You need custom initialization.
- You need to configure constructor arguments.

Example:

```java
@Bean
public ObjectMapper objectMapper() {
    return new ObjectMapper();
}
```

---

# Multiple Beans in One Configuration Class

```java
@Configuration
public class AppConfig {

    @Bean
    public EmployeeService employeeService() {
        return new EmployeeService();
    }

    @Bean
    public EmployeeRepository employeeRepository() {
        return new EmployeeRepository();
    }

}
```

Spring creates both Beans.

---

# Full Flow

```
@Configuration
        │
        ▼
@Bean Methods
        │
        ▼
Create Objects
        │
        ▼
Register Beans
        │
        ▼
IoC Container
```

---

# Advantages

- Centralized Bean configuration
- Easy management of Beans
- Useful for third-party classes
- Supports custom Bean creation
- Improves application organization

---

# Best Practices

- Use `@Configuration` for application configuration.
- Use `@Component` for your own application classes.
- Use `@Bean` when manual Bean creation is required.
- Keep configuration classes focused on related Beans.

---

# Interview Questions

### 1. What is `@Configuration`?

`@Configuration` marks a class as a source of Spring Bean definitions.

---

### 2. Why is `@Configuration` used?

It allows developers to define and configure Beans manually using `@Bean` methods.

---

### 3. What is the difference between `@Configuration` and `@Component`?

`@Configuration` is used for configuration classes containing `@Bean` methods, while `@Component` marks a class itself as a Spring Bean.

---

### 4. Can a `@Configuration` class contain multiple Beans?

Yes. A single configuration class can contain multiple `@Bean` methods.

---

### 5. When should you use `@Bean` instead of `@Component`?

Use `@Bean` when working with third-party classes or when custom object creation/configuration is needed.

---

# Quick Revision

- `@Configuration` marks a class as a Spring configuration class.
- It is used to define Beans manually.
- `@Bean` methods inside a configuration class create Spring Beans.
- Spring registers these Beans in the IoC Container.
- Use `@Configuration` for centralized and custom Bean configuration.