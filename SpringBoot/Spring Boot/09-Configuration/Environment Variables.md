# Environment Variables

## What are Environment Variables?

**Environment Variables** are configuration values stored **outside the application** and provided by the operating system.

Spring Boot can automatically read these variables and use them as configuration values.

Examples:

- Database Password
- API Keys
- JWT Secret
- SMTP Password
- Server Port

> **In simple words:**
>
> Environment Variables allow you to configure your application **without storing sensitive information inside the project**.

---

# Why Do We Need Environment Variables?

Suppose your application has a database password.

Hardcoded in Java

```java
String password = "admin123";
```

Problems

- Password is visible.
- Password may be uploaded to GitHub.
- Every developer sees the password.
- Not secure.

Instead,

Store it as an Environment Variable.

```
Operating System

↓

DATABASE_PASSWORD=password123

↓

Spring Boot

↓

Application
```

---

# Real-World Example

Imagine your house.

```
House

↓

Door Lock Password
```

Would you write the password on the front door?

```
❌ No
```

Instead,

keep it somewhere safe.

Similarly,

don't keep passwords inside your source code.

Store them in Environment Variables.

---

# How Environment Variables Work

```
Operating System

↓

Environment Variables

↓

Spring Boot

↓

Application Configuration

↓

Application Starts
```

---

# Example Environment Variables

Windows

```
DB_USERNAME=root

DB_PASSWORD=password

JWT_SECRET=mySecretKey

SERVER_PORT=8080
```

Linux / macOS

```bash
export DB_USERNAME=root

export DB_PASSWORD=password

export JWT_SECRET=mySecretKey
```

---

# Using Environment Variables in Spring Boot

application.properties

```properties
spring.datasource.username=${DB_USERNAME}

spring.datasource.password=${DB_PASSWORD}
```

Spring Boot replaces

```
${DB_USERNAME}
```

with

```
root
```

and

```
${DB_PASSWORD}
```

with

```
password
```

---

# Database Example

Environment Variables

```
DB_URL=jdbc:mysql://localhost:3306/company

DB_USERNAME=root

DB_PASSWORD=password
```

application.properties

```properties
spring.datasource.url=${DB_URL}

spring.datasource.username=${DB_USERNAME}

spring.datasource.password=${DB_PASSWORD}
```

Application

```
Spring Boot

↓

Reads Variables

↓

Connects Database
```

---

# Reading Environment Variables Using @Value

Environment Variable

```
APP_NAME=SeatForge
```

Java

```java
@Component
public class AppInfo {

    @Value("${APP_NAME}")
    private String appName;

}
```

Spring injects

```
SeatForge
```

into

```
appName
```

---

# Using Default Values

Suppose

```
APP_NAME
```

does not exist.

```java
@Value("${APP_NAME:DefaultApp}")
private String appName;
```

Spring uses

```
DefaultApp
```

---

# Configuration Loading Flow

```
Operating System

↓

Environment Variables

↓

Spring Environment

↓

@ConfigurationProperties

↓

Application
```

---

# Environment Variables vs application.properties

Suppose

application.properties

```properties
spring.datasource.password=123456
```

Environment Variable

```
SPRING_DATASOURCE_PASSWORD=securePassword
```

Spring Boot chooses

```
Environment Variable

↓

Higher Priority
```

Result

```
securePassword
```

is used.

---

# Property Resolution Priority

Higher priority overrides lower priority.

```
Command Line Arguments

↓

Environment Variables

↓

application.properties

↓

application.yml

↓

Default Values
```

---

# Setting Environment Variables

## Windows Command Prompt

```cmd
set DB_USERNAME=root

set DB_PASSWORD=password
```

---

## Windows PowerShell

```powershell
$env:DB_USERNAME="root"

$env:DB_PASSWORD="password"
```

---

## Linux / macOS

```bash
export DB_USERNAME=root

export DB_PASSWORD=password
```

---

# Environment Variables in Docker

Docker

```bash
docker run \
-e DB_USERNAME=root \
-e DB_PASSWORD=password \
my-app
```

Flow

```
Docker

↓

Environment Variables

↓

Spring Boot

↓

Application
```

---

# Environment Variables in Kubernetes

Example

```yaml
env:
  - name: DB_USERNAME
    value: root

  - name: DB_PASSWORD
    value: password
```

Kubernetes injects the values into the application container.

---

# Environment Variables vs Hardcoded Values

## Hardcoded

```java
String secret =
        "mySecret123";
```

Problems

- Visible in code.
- Security risk.
- Difficult to change.

---

## Environment Variable

```
JWT_SECRET=mySecret123
```

Java

```properties
jwt.secret=${JWT_SECRET}
```

Secure and configurable.

---

# Common Environment Variables

| Variable | Purpose |
|----------|----------|
| `DB_URL` | Database URL |
| `DB_USERNAME` | Database username |
| `DB_PASSWORD` | Database password |
| `JWT_SECRET` | JWT signing secret |
| `SERVER_PORT` | Server port |
| `API_KEY` | External API key |

---

# Real-World Example

## Banking Application

```
Database Password

↓

Environment Variable

↓

Spring Boot

↓

Database
```

---

## Payment Gateway

```
API Key

↓

Environment Variable

↓

Payment Service
```

---

## Email Service

```
SMTP Password

↓

Environment Variable

↓

Mail Sender
```

---

# Advantages

- Keeps sensitive information out of source code.
- Easy to change for different environments.
- Improves application security.
- Works well with Docker and Kubernetes.
- Supported directly by Spring Boot.

---

# Best Practices

- Never hardcode passwords or API keys.
- Store secrets as Environment Variables.
- Use different values for development, testing, and production.
- Provide default values only for non-sensitive properties.
- Combine Environment Variables with Spring Profiles for environment-specific configurations.

---

# Interview Questions

### 1. What are Environment Variables?

Environment Variables are operating system-level configuration values that Spring Boot can read to configure an application.

---

### 2. Why should passwords not be stored in `application.properties`?

Because they can be accidentally committed to version control, exposing sensitive information.

---

### 3. How do you access an Environment Variable in Spring Boot?

Using placeholders.

```properties
spring.datasource.password=${DB_PASSWORD}
```

or

```java
@Value("${DB_PASSWORD}")
```

---

### 4. Which has higher priority: Environment Variables or `application.properties`?

Environment Variables have higher priority and override values defined in `application.properties`.

---

### 5. Can Environment Variables be used in Docker?

Yes.

Docker commonly passes configuration using the `-e` option.

---

### 6. Why are Environment Variables useful in production?

They allow configuration and secrets to be changed without modifying or rebuilding the application.

---

### 7. Are Environment Variables suitable for storing API keys and JWT secrets?

Yes. They are one of the recommended ways to provide sensitive configuration to an application.

---

# Quick Revision

- Environment Variables are OS-level configuration values.
- Spring Boot automatically reads Environment Variables.
- Use `${VARIABLE_NAME}` to reference them.
- Environment Variables have higher priority than `application.properties`.
- Store passwords, API keys, and JWT secrets as Environment Variables.
- They work seamlessly with Docker, Kubernetes, and cloud deployments.
- Never hardcode sensitive information inside Java code.
- Use default values only for non-sensitive configurations.