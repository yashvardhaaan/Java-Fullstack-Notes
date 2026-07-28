# Configuration Properties

## What are Configuration Properties?

**Configuration Properties** are values used to configure the behavior of a Spring Boot application **without changing the source code**.

These values are usually stored in:

- `application.properties`
- `application.yml`

Examples include:

- Database URL
- Database Username
- Server Port
- API Keys
- Logging Levels
- Email Configuration

> **In simple words:**
>
> Configuration Properties are settings that tell your application how to behave.

---

# Why Do We Need Configuration Properties?

Imagine an application running in three environments:

```
Development

↓

Database A
```

```
Testing

↓

Database B
```

```
Production

↓

Database C
```

Without configuration properties,

you would have to modify the Java code every time.

Example

```java
String database =
        "jdbc:mysql://localhost:3306/dev";
```

Later for production,

```java
String database =
        "jdbc:mysql://production-server";
```

This is not a good practice.

Instead,

move these values outside the code.

---

# Where are Configuration Properties Stored?

Spring Boot mainly supports:

```
application.properties
```

or

```
application.yml
```

Example

```properties
server.port=8080

spring.application.name=LibraryApp
```

---

# Common Configuration Properties

| Property | Purpose |
|-----------|----------|
| `server.port` | Changes server port |
| `spring.application.name` | Application name |
| `spring.datasource.url` | Database URL |
| `spring.datasource.username` | Database username |
| `spring.datasource.password` | Database password |
| `logging.level.root` | Logging level |

---

# Example

application.properties

```properties
server.port=9090

spring.application.name=EmployeeService

spring.datasource.url=jdbc:mysql://localhost:3306/company

spring.datasource.username=root

spring.datasource.password=password
```

Result

```
Application

↓

Runs on Port 9090

↓

Connects to company database
```

---

# How Spring Boot Reads Properties

```
Application Starts

↓

Read application.properties

↓

Load Configuration

↓

Create Beans

↓

Application Ready
```

---

# Accessing Properties Using @Value

Suppose

```properties
app.name=Employee Management System
```

Java

```java
@Component
public class AppInfo {

    @Value("${app.name}")
    private String appName;

}
```

Result

```
Employee Management System
```

---

# Accessing Multiple Properties

application.properties

```properties
app.name=Library

app.version=1.0

app.owner=Yash
```

Java

```java
@Component
public class AppInfo {

    @Value("${app.name}")
    private String name;

    @Value("${app.version}")
    private String version;

    @Value("${app.owner}")
    private String owner;

}
```

---

# What is @ConfigurationProperties?

When there are many related properties,

using multiple `@Value` annotations becomes difficult.

Spring provides

```java
@ConfigurationProperties
```

to bind related properties into a single Java object.

---

# Example

application.properties

```properties
app.name=SeatForge

app.version=1.0

app.owner=Yash
```

Java

```java
@Component
@ConfigurationProperties(prefix = "app")
public class AppProperties {

    private String name;

    private String version;

    private String owner;

    // Getters and Setters

}
```

Spring automatically maps:

```
app.name

↓

name
```

```
app.version

↓

version
```

```
app.owner

↓

owner
```

---

# Property Binding Flow

```
application.properties

↓

Spring Boot

↓

@ConfigurationProperties

↓

Java Object

↓

Application
```

---

# Nested Properties

application.properties

```properties
database.url=jdbc:mysql://localhost:3306/test

database.username=root

database.password=password
```

Java

```java
@Component
@ConfigurationProperties(prefix = "database")
public class DatabaseProperties {

    private String url;

    private String username;

    private String password;

}
```

---

# Using YAML

Instead of

```properties
app.name=SeatForge

app.version=1.0
```

YAML

```yaml
app:
  name: SeatForge
  version: 1.0
```

Both produce the same result.

---

# Property Loading Priority

Spring Boot loads properties from multiple sources.

Higher priority overrides lower priority.

```
Command Line Arguments

↓

Environment Variables

↓

application.properties

↓

Default Values
```

---

# Default Values with @Value

```java
@Value("${app.name:DefaultApp}")
private String appName;
```

If

```
app.name
```

is missing,

Spring uses

```
DefaultApp
```

---

# Custom Properties

application.properties

```properties
company.name=ABC Technologies

company.location=Pune

company.founded=2025
```

Java

```java
@Value("${company.name}")
private String companyName;
```

---

# Configuration Properties Lifecycle

```
Application Starts

↓

Load Properties

↓

Create Environment

↓

Inject Properties

↓

Create Beans

↓

Ready
```

---

# @Value vs @ConfigurationProperties

| @Value | @ConfigurationProperties |
|----------|--------------------------|
| Reads one property | Reads multiple related properties |
| Good for small values | Good for grouped configurations |
| Manual mapping | Automatic binding |
| Less scalable | More scalable |

---

# Configuration Properties vs Hardcoded Values

## Hardcoded

```java
String url =
        "jdbc:mysql://localhost";
```

Needs recompilation to change.

---

## Configuration Property

```properties
database.url=jdbc:mysql://localhost
```

Can be changed without modifying Java code.

---

# Real-World Example

## Banking Application

```
Database URL

↓

application.properties

↓

Spring Boot

↓

Database Connection
```

---

## E-Commerce Application

```
Payment Gateway URL

↓

Configuration Property

↓

Application
```

---

## Email Service

```
SMTP Server

↓

Configuration Property

↓

Email Sender
```

---

# Advantages

- Separates configuration from business logic.
- Easy to change without modifying code.
- Supports multiple environments.
- Supports automatic binding using `@ConfigurationProperties`.
- Makes applications easier to maintain.

---

# Best Practices

- Keep configuration outside Java code.
- Use `@ConfigurationProperties` for related settings.
- Use `@Value` only for a few individual properties.
- Do not store passwords directly in source code.
- Group similar properties using prefixes.

---

# Interview Questions

### 1. What are Configuration Properties?

Configuration Properties are external settings used to configure a Spring Boot application without modifying the source code.

---

### 2. Where are Configuration Properties stored?

Typically in:

- `application.properties`
- `application.yml`

---

### 3. What is the difference between `@Value` and `@ConfigurationProperties`?

`@Value` injects a single property, while `@ConfigurationProperties` binds a group of related properties into a Java object.

---

### 4. Which annotation binds multiple properties?

```java
@ConfigurationProperties
```

---

### 5. Why are Configuration Properties important?

They separate configuration from business logic, making applications easier to configure, maintain, and deploy across different environments.

---

### 6. Can Spring Boot read YAML files?

Yes.

Spring Boot supports both:

- `application.properties`
- `application.yml`

---

### 7. What happens if a property is missing?

You can provide a default value using:

```java
@Value("${property.name:defaultValue}")
```

---

# Quick Revision

- Configuration Properties store application settings outside the Java code.
- Common files are `application.properties` and `application.yml`.
- Use `@Value` for single properties.
- Use `@ConfigurationProperties` for grouped properties.
- Spring automatically loads configuration during application startup.
- External configuration makes applications flexible and environment-independent.
- YAML and Properties files are both supported by Spring Boot.
- Avoid hardcoding configuration values in Java classes.