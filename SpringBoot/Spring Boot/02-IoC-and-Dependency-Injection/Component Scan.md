# Component Scan

## What is Component Scan?

**Component Scan** is a feature of Spring that automatically scans the specified packages, detects Spring components, creates their objects (Beans), and registers them in the **Spring IoC Container**.

> **In simple words:**
>
> Component Scan tells Spring:
> **"Search for all classes annotated with Spring annotations and create their objects automatically."**

---

# Why Do We Need Component Scan?

Without Component Scan, every Bean would need to be registered manually.

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

For hundreds of classes, this becomes difficult to manage.

With Component Scan:

```java
@Service
public class EmployeeService {

}
```

Spring automatically detects and creates the Bean.

---

# How Component Scan Works

```
Application Starts
        │
        ▼
@ComponentScan
        │
        ▼
Scans Specified Packages
        │
        ▼
Finds Spring Components
        │
        ▼
Creates Beans
        │
        ▼
Stores Beans in IoC Container
```

---

# @ComponentScan Annotation

```java
@ComponentScan(basePackages = "com.example")
public class AppConfig {

}
```

It tells Spring to scan the `com.example` package and all its sub-packages.

---

# @SpringBootApplication

In Spring Boot:

```java
@SpringBootApplication
public class EmployeeApplication {

    public static void main(String[] args) {
        SpringApplication.run(EmployeeApplication.class, args);
    }

}
```

`@SpringBootApplication` already includes:

```java
@ComponentScan
```

So, you usually **do not need to add `@ComponentScan` manually**.

---

# What Does Component Scan Detect?

It scans classes annotated with:

- `@Component`
- `@Service`
- `@Repository`
- `@Controller`
- `@RestController`
- `@Configuration`

Example:

```java
@Service
public class EmployeeService {

}
```

Spring detects this class and creates a Bean.

---

# Package Structure Example

```
com.example.employee
│
├── EmployeeApplication.java
├── controller/
├── service/
├── repository/
└── entity/
```

Since `EmployeeApplication` is in the root package, Spring scans all sub-packages automatically.

---

# Custom Package Scanning

```java
@SpringBootApplication
@ComponentScan(basePackages = {
    "com.example.employee",
    "com.example.common"
})
public class EmployeeApplication {

}
```

Spring scans both packages.

---

# What Happens Internally?

```
Spring Boot Starts
        │
        ▼
Reads @ComponentScan
        │
        ▼
Scans Packages
        │
        ▼
Finds Annotated Classes
        │
        ▼
Creates Beans
        │
        ▼
Registers Beans in IoC Container
```

---

# If a Class is Outside the Scan Package

Example:

```
com.example.employee

com.company.payment
```

If Spring scans only:

```
com.example.employee
```

Then:

```
com.company.payment.PaymentService
```

will **not** become a Spring Bean.

It must either:

- Be moved into a scanned package, or
- Be included using `@ComponentScan`.

---

# Advantages

- Automatic Bean creation
- Reduces manual configuration
- Cleaner code
- Easy maintenance
- Supports Dependency Injection

---

# Best Practices

- Place the main application class in the **root package**.
- Keep all Spring components inside its sub-packages.
- Use custom `@ComponentScan` only when necessary.

---

# Interview Questions

### 1. What is Component Scan?

Component Scan is the process by which Spring searches for classes annotated with Spring stereotypes, creates their Beans, and registers them in the IoC Container.

---

### 2. Which annotation performs Component Scan?

```java
@ComponentScan
```

---

### 3. Does `@SpringBootApplication` include `@ComponentScan`?

Yes.

`@SpringBootApplication` is a combination of:

- `@SpringBootConfiguration`
- `@EnableAutoConfiguration`
- `@ComponentScan`

---

### 4. Which annotations are detected during Component Scan?

- `@Component`
- `@Service`
- `@Repository`
- `@Controller`
- `@RestController`
- `@Configuration`

---

### 5. What happens if a class is outside the scanned package?

Spring does not detect it, so no Bean is created unless that package is explicitly included in `@ComponentScan`.

---

# Quick Revision

- Component Scan automatically finds Spring components.
- It creates Beans and stores them in the IoC Container.
- Performed using `@ComponentScan`.
- `@SpringBootApplication` already includes `@ComponentScan`.
- Scan starts from the package containing the main application class.
- Classes outside the scanned packages are not managed by Spring.