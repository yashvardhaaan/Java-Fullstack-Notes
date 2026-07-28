# @Value

## What is `@Value`?

`@Value` is a Spring annotation used to **inject values from configuration files, environment variables, or expressions into Spring Beans**.

> **In simple words:**
>
> `@Value` tells Spring:
> **"Read this value from the configuration and assign it to this field, constructor parameter, or method parameter."**

---

# Why Do We Need `@Value`?

Instead of hardcoding values:

```java
private String appName = "Employee Management System";
```

Store them in a configuration file:

```properties
app.name=Employee Management System
```

Then inject them:

```java
@Value("${app.name}")
private String appName;
```

Benefits:

- No hardcoded values
- Easy configuration changes
- Environment-specific values
- Better maintainability

---

# Basic Syntax

```java
@Value("${property.name}")
private String value;
```

Example:

```properties
server.port=8080
```

```java
@Value("${server.port}")
private String port;
```

---

# Reading Properties from application.properties

### application.properties

```properties
app.name=Employee Management System

app.version=1.0
```

### Java Class

```java
@Component
public class AppInfo {

    @Value("${app.name}")
    private String appName;

    @Value("${app.version}")
    private String version;

}
```

---

# Reading from application.yml

### application.yml

```yaml
app:
  name: Employee Management System
  version: 1.0
```

### Java Class

```java
@Component
public class AppInfo {

    @Value("${app.name}")
    private String appName;

    @Value("${app.version}")
    private String version;

}
```

---

# Default Value

If the property does not exist:

```java
@Value("${app.owner:Unknown}")
private String owner;
```

If `app.owner` is missing:

```
Unknown
```

is injected.

---

# Constructor Injection

```java
@Service
public class EmployeeService {

    private final String appName;

    public EmployeeService(
            @Value("${app.name}") String appName) {

        this.appName = appName;
    }

}
```

---

# Injecting Primitive Types

```properties
employee.id=101

employee.salary=50000

employee.active=true
```

```java
@Value("${employee.id}")
private int id;

@Value("${employee.salary}")
private double salary;

@Value("${employee.active}")
private boolean active;
```

Spring automatically converts the values to the required type.

---

# Using Spring Expression Language (SpEL)

```java
@Value("#{10 + 20}")
private int total;
```

Output:

```
30
```

Example:

```java
@Value("#{systemProperties['user.name']}")
private String userName;
```

---

# How `@Value` Works

```
Application Starts
        │
        ▼
Load Configuration
        │
        ▼
Read Property
        │
        ▼
Inject Value
        │
        ▼
Bean Ready
```

---

# @Value vs Environment

## Using `@Value`

```java
@Value("${server.port}")
private String port;
```

---

## Using `Environment`

```java
@Autowired
private Environment environment;

String port = environment.getProperty("server.port");
```

| `@Value` | `Environment` |
|-----------|---------------|
| Simple property injection | Programmatic property access |
| Good for a few values | Good for dynamic property lookup |
| Less code | More flexible |

---

# Real-World Example

### application.properties

```properties
company.name=ABC Technologies

company.location=Pune
```

### Java Class

```java
@Component
public class Company {

    @Value("${company.name}")
    private String name;

    @Value("${company.location}")
    private String location;

}
```

Spring automatically injects:

```
ABC Technologies

Pune
```

---

# Advantages

- Externalized configuration
- Reduces hardcoding
- Supports default values
- Works with properties and YAML files
- Supports Spring Expression Language (SpEL)

---

# Best Practices

- Use `@Value` for a small number of configuration properties.
- Use `@ConfigurationProperties` when working with many related properties.
- Keep configuration values outside Java code.
- Use default values where appropriate to avoid startup failures.

---

# Interview Questions

### 1. What is `@Value`?

`@Value` is used to inject values from configuration files, environment variables, or expressions into Spring Beans.

---

### 2. How do you inject a property from `application.properties`?

```java
@Value("${app.name}")
private String appName;
```

---

### 3. How do you specify a default value?

```java
@Value("${app.name:Default App}")
```

---

### 4. Can `@Value` read values from `application.yml`?

Yes. It works with both `application.properties` and `application.yml`.

---

### 5. What is the difference between `@Value` and `Environment`?

- `@Value` is used for simple property injection.
- `Environment` is used for dynamic and programmatic property access.

---

# Quick Revision

- `@Value` injects configuration values into Spring Beans.
- It works with `application.properties`, `application.yml`, environment variables, and SpEL.
- Use `${property.name}` to reference a property.
- Use `:defaultValue` to provide a fallback value.
- `@Value` is ideal for injecting a small number of configuration properties.
- Use `Environment` or `@ConfigurationProperties` for more complex configuration needs.