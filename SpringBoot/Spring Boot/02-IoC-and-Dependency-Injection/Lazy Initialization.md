# Lazy Initialization

## What is Lazy Initialization?

**Lazy Initialization** means that a Spring Bean is **created only when it is needed**, instead of being created when the application starts.

By default, Spring creates **Singleton Beans eagerly** (during application startup). With Lazy Initialization, bean creation is delayed until the bean is first requested.

> **In simple words:**
>
> Lazy Initialization tells Spring:
> **"Don't create this object now. Create it only when someone uses it."**

---

# Why Do We Need Lazy Initialization?

Sometimes a Bean:

- Takes a long time to create
- Uses a lot of memory
- May never be used during the application's execution

Creating such Beans only when needed can improve startup time.

---

# Default Behavior (Eager Initialization)

```java
@Service
public class EmployeeService {

}
```

When the application starts:

```
Application Starts
        │
        ▼
Spring Creates EmployeeService Bean
```

Even if `EmployeeService` is never used, Spring creates it.

---

# Lazy Initialization

```java
@Service
@Lazy
public class EmployeeService {

}
```

Now:

```
Application Starts
        │
        ▼
Bean NOT Created
        │
        ▼
First Time Bean is Requested
        │
        ▼
Spring Creates Bean
```

---

# Example

```java
@Component
@Lazy
public class ReportGenerator {

    public ReportGenerator() {
        System.out.println("ReportGenerator Bean Created");
    }

}
```

Output:

```
Application Started
```

The message is **not printed** until the bean is actually used.

---

# Using the Bean

```java
@RestController
public class ReportController {

    private final ReportGenerator reportGenerator;

    public ReportController(ReportGenerator reportGenerator) {
        this.reportGenerator = reportGenerator;
    }

}
```

When the controller requests the bean for the first time:

```
ReportGenerator Bean Created
```

---

# Lazy Initialization for a Specific Dependency

```java
@Service
public class EmployeeService {

    private final EmployeeRepository repository;

    public EmployeeService(@Lazy EmployeeRepository repository) {
        this.repository = repository;
    }

}
```

Only the `EmployeeRepository` dependency is initialized lazily.

---

# Enable Lazy Initialization for the Entire Application

In `application.properties`:

```properties
spring.main.lazy-initialization=true
```

Now, Spring creates **all Beans lazily** unless specified otherwise.

---

# How Lazy Initialization Works

```
Application Starts
        │
        ▼
Bean Definition Registered
        │
        ▼
No Bean Instance Created
        │
        ▼
Bean Requested
        │
        ▼
Bean Created
        │
        ▼
Bean Returned
```

---

# Eager vs Lazy Initialization

| Feature | Eager Initialization | Lazy Initialization |
|---------|----------------------|---------------------|
| Bean Creation | At Startup | On First Use |
| Startup Time | Slower | Faster |
| Memory Usage | Higher Initially | Lower Initially |
| Default in Spring | Yes | No |

---

# Real-World Example

Imagine a **library**.

### Eager Initialization

The librarian brings **every book** to your table before you ask.

### Lazy Initialization

The librarian brings **only the book you request**.

Spring behaves the same way with Beans.

---

# Advantages

- Faster application startup
- Lower initial memory usage
- Avoids creating unused Beans
- Useful for expensive or rarely used objects

---

# Disadvantages

- First access may be slightly slower because the Bean is created then.
- Configuration errors may be discovered later instead of during application startup.

---

# Best Practices

- Use Lazy Initialization for heavy or rarely used Beans.
- Keep commonly used Beans as eager (default).
- Do not enable lazy initialization everywhere without a good reason, as it may delay error detection.

---

# Interview Questions

### 1. What is Lazy Initialization?

Lazy Initialization delays the creation of a Bean until it is first requested.

---

### 2. Which annotation enables Lazy Initialization?

```java
@Lazy
```

---

### 3. What is the default Bean initialization strategy in Spring?

**Eager Initialization** for Singleton Beans.

---

### 4. How do you enable Lazy Initialization for the entire application?

```properties
spring.main.lazy-initialization=true
```

---

### 5. When should you use Lazy Initialization?

- Heavy Beans
- Rarely used Beans
- Beans with expensive initialization

---

# Quick Revision

- Lazy Initialization creates Beans only when they are first needed.
- Use the `@Lazy` annotation to enable it.
- Spring's default behavior is **Eager Initialization**.
- Lazy Initialization can improve startup performance.
- It is useful for expensive or infrequently used Beans.
- Avoid overusing it, as it can delay error detection and the first request may take slightly longer.