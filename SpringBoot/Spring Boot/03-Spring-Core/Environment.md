# Environment

## What is Environment in Spring?

The **Environment** in Spring is an abstraction that provides access to the application's **configuration properties** and **active profiles**.

It acts as a central place from which Spring reads configuration values.

> **In simple words:**
>
> The Environment helps Spring answer questions like:
> - "What is the database URL?"
> - "Which profile is active?"
> - "What is the value of a configuration property?"

---

# Why Do We Need Environment?

Instead of hardcoding values:

```java
String databaseUrl = "jdbc:mysql://localhost:3306/employees";
```

we store them in configuration files.

Example:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/employees
```

Spring reads these values through the Environment.

Benefits:

- Easy configuration
- Better maintainability
- Different settings for different environments
- No code changes when configuration changes

---

# Sources of Environment Properties

Spring reads properties from multiple sources, including:

- `application.properties`
- `application.yml`
- Environment Variables
- JVM System Properties
- Command-line Arguments
- Property Files

Example:

```properties
server.port=8080
spring.application.name=EmployeeApp
```

---

# Accessing Environment

Spring provides the `Environment` interface.

```java
import org.springframework.core.env.Environment;
```

Inject it using Constructor Injection:

```java
@Service
public class EmployeeService {

    private final Environment environment;

    public EmployeeService(Environment environment) {
        this.environment = environment;
    }

}
```

---

# Reading a Property

Suppose:

```properties
app.name=Employee Management System
```

Read it:

```java
String appName = environment.getProperty("app.name");

System.out.println(appName);
```

Output:

```
Employee Management System
```

---

# Reading with Default Value

If the property doesn't exist:

```java
String appName =
        environment.getProperty("app.name", "Default App");
```

If `app.name` is missing:

```
Default App
```

is returned.

---

# Checking Active Profiles

```java
String[] profiles = environment.getActiveProfiles();

for (String profile : profiles) {
    System.out.println(profile);
}
```

Output:

```
dev
```

or

```
prod
```

depending on the active profile.

---

# Common Environment Methods

| Method | Description |
|---------|-------------|
| `getProperty()` | Returns a property value |
| `containsProperty()` | Checks if a property exists |
| `getActiveProfiles()` | Returns active profiles |
| `getDefaultProfiles()` | Returns default profiles |

---

# How Environment Works

```
Application Starts
        │
        ▼
Load Configuration Files
        │
        ▼
Create Environment
        │
        ▼
Read Properties
        │
        ▼
Provide Values to Beans
```

---

# Environment vs @Value

## Using Environment

```java
String port =
        environment.getProperty("server.port");
```

---

## Using @Value

```java
@Value("${server.port}")
private String port;
```

---

| Environment | @Value |
|-------------|---------|
| Reads properties programmatically | Injects a single property |
| Suitable for multiple properties | Simple and concise |
| More flexible | Easier for small use cases |

---

# Real-World Example

Suppose your application runs in different environments.

### Development

```properties
server.port=8080
```

### Production

```properties
server.port=9090
```

Spring's Environment automatically reads the correct value based on the active configuration.

---

# Advantages

- Centralized configuration access
- Supports multiple property sources
- Supports profiles
- Reduces hardcoded values
- Improves flexibility

---

# Best Practices

- Store configuration in `application.properties` or `application.yml`.
- Avoid hardcoding values in Java code.
- Use `@Value` for simple property injection.
- Use `Environment` when you need to read properties dynamically.

---

# Interview Questions

### 1. What is Environment in Spring?

Environment is a Spring abstraction used to access configuration properties and active profiles.

---

### 2. Which interface represents the Environment?

```java
org.springframework.core.env.Environment
```

---

### 3. How do you read a property using Environment?

```java
environment.getProperty("property.name");
```

---

### 4. What is the difference between Environment and @Value?

- `Environment` is used for programmatic access to properties.
- `@Value` injects individual property values directly into fields or constructors.

---

### 5. What are active profiles?

Active profiles determine which configuration should be used for a particular environment, such as development, testing, or production.

---

# Quick Revision

- Environment provides access to application properties and profiles.
- It reads values from multiple property sources.
- Use `getProperty()` to read configuration values.
- Use `getActiveProfiles()` to check the active profile.
- `@Value` is suitable for simple property injection, while `Environment` offers more flexibility.
- Environment helps externalize configuration and avoid hardcoded values.