# Bean Lifecycle

## What is Bean Lifecycle?

The **Bean Lifecycle** is the sequence of steps that a Spring Bean goes through from its **creation** until its **destruction**.

> **In simple words:**
>
> Bean Lifecycle describes **how Spring creates, initializes, uses, and destroys a Bean.**

---

# Why Do We Need Bean Lifecycle?

Spring manages the complete lifecycle of every Bean.

It automatically:

- Creates the Bean
- Injects dependencies
- Initializes the Bean
- Makes it available for use
- Destroys it when the application shuts down

This saves developers from manually managing object lifecycle.

---

# Bean Lifecycle Flow

```
Application Starts
        │
        ▼
Bean Instantiation
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
Application Running
        │
        ▼
Application Stops
        │
        ▼
Bean Destruction
```

---

# Step 1: Bean Instantiation

Spring creates the Bean.

Example:

```java
@Service
public class EmployeeService {

}
```

Spring creates an object of `EmployeeService`.

---

# Step 2: Dependency Injection

Spring injects all required dependencies.

```java
@Service
public class EmployeeService {

    private final EmployeeRepository repository;

    public EmployeeService(EmployeeRepository repository) {
        this.repository = repository;
    }

}
```

The IoC Container injects `EmployeeRepository` into `EmployeeService`.

---

# Step 3: Initialization

After dependencies are injected, Spring performs initialization.

There are multiple ways to execute initialization logic.

### Using `@PostConstruct`

```java
@Service
public class EmployeeService {

    @PostConstruct
    public void init() {
        System.out.println("Bean Initialized");
    }

}
```

The `init()` method is called automatically after dependency injection.

---

### Using `InitializingBean`

```java
@Service
public class EmployeeService implements InitializingBean {

    @Override
    public void afterPropertiesSet() {
        System.out.println("Bean Initialized");
    }

}
```

---

### Using `initMethod`

```java
@Configuration
public class AppConfig {

    @Bean(initMethod = "init")
    public EmployeeService employeeService() {
        return new EmployeeService();
    }

}
```

---

# Step 4: Bean Ready to Use

The Bean is now fully initialized.

It can be injected into other classes.

```java
@Autowired
private EmployeeService employeeService;
```

---

# Step 5: Bean Destruction

When the application shuts down, Spring destroys the Bean.

You can execute cleanup logic before destruction.

---

### Using `@PreDestroy`

```java
@Service
public class EmployeeService {

    @PreDestroy
    public void destroy() {
        System.out.println("Bean Destroyed");
    }

}
```

---

### Using `DisposableBean`

```java
@Service
public class EmployeeService implements DisposableBean {

    @Override
    public void destroy() {
        System.out.println("Bean Destroyed");
    }

}
```

---

### Using `destroyMethod`

```java
@Bean(destroyMethod = "cleanup")
public EmployeeService employeeService() {
    return new EmployeeService();
}
```

---

# Complete Lifecycle Example

```java
@Service
public class EmployeeService {

    public EmployeeService() {
        System.out.println("Constructor Called");
    }

    @PostConstruct
    public void init() {
        System.out.println("Initialization");
    }

    @PreDestroy
    public void destroy() {
        System.out.println("Cleanup");
    }

}
```

Output:

```
Constructor Called
Initialization
Application Running...
Cleanup
```

---

# Bean Lifecycle Diagram

```
Create Bean
      │
      ▼
Inject Dependencies
      │
      ▼
@PostConstruct
      │
      ▼
Bean Ready
      │
      ▼
Application Running
      │
      ▼
@PreDestroy
      │
      ▼
Bean Destroyed
```

---

# BeanPostProcessor

Spring allows custom processing before and after Bean initialization.

```
Bean Created
      │
      ▼
postProcessBeforeInitialization()
      │
      ▼
@PostConstruct
      │
      ▼
postProcessAfterInitialization()
```

This mechanism is used internally by Spring for features like AOP, Transactions, and Security.

---

# Advantages

- Automatic lifecycle management
- Cleaner code
- Easy initialization and cleanup
- Better resource management
- Supports custom initialization and destruction logic

---

# Best Practices

- Use `@PostConstruct` for initialization logic.
- Use `@PreDestroy` for cleanup logic.
- Prefer annotations over implementing lifecycle interfaces unless required.
- Keep initialization and cleanup methods lightweight.

---

# Interview Questions

### 1. What is the Bean Lifecycle?

The Bean Lifecycle is the sequence of stages a Spring Bean goes through from creation to destruction.

---

### 2. What are the main phases of the Bean Lifecycle?

- Bean Instantiation
- Dependency Injection
- Initialization
- Bean Ready for Use
- Bean Destruction

---

### 3. Which annotation is used for initialization?

```java
@PostConstruct
```

---

### 4. Which annotation is used before Bean destruction?

```java
@PreDestroy
```

---

### 5. What is a `BeanPostProcessor`?

A `BeanPostProcessor` allows custom processing of Beans before and after their initialization.

---

### 6. When is `@PostConstruct` executed?

After dependency injection and before the Bean is available for use.

---

# Quick Revision

- Bean Lifecycle defines how Spring manages a Bean from creation to destruction.
- Spring creates the Bean, injects dependencies, initializes it, and destroys it when the application ends.
- Use `@PostConstruct` for initialization.
- Use `@PreDestroy` for cleanup.
- `BeanPostProcessor` can customize Beans before and after initialization.
- Spring automatically manages the lifecycle of all Beans in the IoC Container.