# Property Sources

## What are Property Sources?

**Property Sources** are the different locations from which Spring reads configuration properties.

These properties are used to configure the application's behavior, such as:

- Server Port
- Database URL
- Username
- Password
- API Keys
- Custom Application Properties

> **In simple words:**
>
> Property Sources tell Spring:
> **"Where should I look for configuration values?"**

---

# Why Do We Need Property Sources?

Instead of hardcoding values:

```java
String databaseUrl = "jdbc:mysql://localhost:3306/employees";
```

Store them externally:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/employees
```

Benefits:

- Easy configuration
- Better security
- Environment-specific settings
- No code changes for configuration updates

---

# Common Property Sources in Spring

Spring reads properties from multiple sources.

| Property Source | Example |
|-----------------|---------|
| `application.properties` | Main configuration file |
| `application.yml` | YAML configuration file |
| Environment Variables | `JAVA_HOME` |
| JVM System Properties | `-Dserver.port=9090` |
| Command-line Arguments | `--server.port=9090` |
| `@PropertySource` | Custom property files |

---

# application.properties

Example:

```properties
server.port=8080

spring.application.name=EmployeeApp

app.version=1.0
```

Read using:

```java
@Value("${app.version}")
private String version;
```

---

# application.yml

Example:

```yaml
server:
  port: 8080

spring:
  application:
    name: EmployeeApp

app:
  version: 1.0
```

YAML provides a cleaner structure for nested properties.

---

# Environment Variables

Operating systems allow configuration through environment variables.

Example:

```
DATABASE_URL=jdbc:mysql://localhost:3306/employees
```

Spring can read these values automatically.

---

# JVM System Properties

Pass properties while starting the application.

```bash
java -Dserver.port=9090 -jar app.jar
```

Spring uses:

```
server.port = 9090
```

---

# Command-line Arguments

```bash
java -jar app.jar --server.port=9090
```

Spring overrides the value from configuration files with the command-line value.

---

# Custom Property File

Create a custom file.

```
app.properties
```

Example:

```properties
company.name=OpenAI
```

Load it using:

```java
@Configuration
@PropertySource("classpath:app.properties")
public class AppConfig {

}
```

Read the property:

```java
@Value("${company.name}")
private String companyName;
```

---

# Property Source Priority

If the same property exists in multiple places, Spring follows a priority order.

| Higher Priority | Lower Priority |
|-----------------|----------------|
| Command-line Arguments | JVM System Properties |
| JVM System Properties | Environment Variables |
| Environment Variables | `application.properties` / `application.yml` |
| `application.properties` / `application.yml` | `@PropertySource` |

**Example**

```
application.properties

server.port=8080
```

Run:

```bash
java -jar app.jar --server.port=9090
```

Final value:

```
9090
```

because command-line arguments have higher priority.

---

# How Property Sources Work

```
Application Starts
        │
        ▼
Load Property Sources
        │
        ▼
Resolve Property Values
        │
        ▼
Inject into Beans
        │
        ▼
Application Ready
```

---

# Accessing Properties

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

public void display() {

    String port = environment.getProperty("server.port");

    System.out.println(port);

}
```

---

# Real-World Example

Suppose your application has:

```
application.properties

↓

server.port=8080
```

Production server starts the application as:

```bash
java -jar app.jar --server.port=9090
```

Spring uses:

```
9090
```

because the command-line argument has higher priority.

---

# Advantages

- Externalized configuration
- Easy deployment
- Environment-specific settings
- Better security
- Flexible configuration management

---

# Best Practices

- Store common configuration in `application.properties` or `application.yml`.
- Keep sensitive information (passwords, API keys) outside source code.
- Use environment variables or secret management tools for production credentials.
- Use `@PropertySource` only for additional custom property files.

---

# Interview Questions

### 1. What are Property Sources?

Property Sources are the locations from which Spring reads configuration values.

---

### 2. Name some common Property Sources.

- `application.properties`
- `application.yml`
- Environment Variables
- JVM System Properties
- Command-line Arguments
- `@PropertySource`

---

### 3. What is `@PropertySource`?

`@PropertySource` is used to load properties from a custom property file.

Example:

```java
@PropertySource("classpath:app.properties")
```

---

### 4. Which has higher priority: `application.properties` or command-line arguments?

**Command-line arguments** have higher priority.

---

### 5. How can you read a property in Spring?

Using:

- `@Value`
- `Environment`

---

# Quick Revision

- Property Sources are places where Spring reads configuration values.
- Common sources include `application.properties`, `application.yml`, environment variables, JVM properties, and command-line arguments.
- Use `@PropertySource` for custom property files.
- Command-line arguments override values from configuration files.
- Access properties using `@Value` or the `Environment` interface.
- Externalized configuration makes applications flexible, secure, and easy to maintain.