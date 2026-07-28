# Spring Profiles

## What are Spring Profiles?

**Spring Profiles** allow you to use **different configurations for different environments** such as:

- Development (dev)
- Testing (test)
- Production (prod)

Instead of changing configuration manually, Spring Boot automatically loads the configuration based on the **active profile**.

> **In simple words:**
>
> Spring Profiles let your application behave differently in different environments without changing the source code.

---

# Why Do We Need Spring Profiles?

Imagine you have a Spring Boot application.

During development:

```
Database

↓

localhost
```

In production:

```
Database

↓

AWS RDS
```

Without Profiles

```
Change Code

↓

Restart Application

↓

Deploy Again
```

This is error-prone.

Instead,

use Profiles.

```
Development

↓

application-dev.properties
```

```
Production

↓

application-prod.properties
```

Spring loads the correct configuration automatically.

---

# Real-World Example

Imagine you drive a car.

```
City Mode

↓

Fuel Efficient
```

```
Sport Mode

↓

High Performance
```

The car is the same,

but its behavior changes depending on the selected mode.

Similarly,

Spring Boot changes its configuration using Profiles.

---

# Common Profiles

```
dev

↓

Development
```

```
test

↓

Testing
```

```
prod

↓

Production
```

---

# Profile Configuration Files

```
src/main/resources

│── application.properties

│── application-dev.properties

│── application-test.properties

│── application-prod.properties
```

---

# application.properties

Common configuration shared by every environment.

```properties
spring.application.name=SeatForge
```

---

# application-dev.properties

```properties
server.port=8080

spring.datasource.url=jdbc:mysql://localhost:3306/devdb
```

---

# application-test.properties

```properties
server.port=8081

spring.datasource.url=jdbc:mysql://localhost:3306/testdb
```

---

# application-prod.properties

```properties
server.port=80

spring.datasource.url=jdbc:mysql://prod-server:3306/proddb
```

---

# Activating a Profile

application.properties

```properties
spring.profiles.active=dev
```

Result

```
Spring Boot

↓

Loads

↓

application-dev.properties
```

---

# Profile Loading Flow

```
Application Starts

↓

Read Active Profile

↓

Load application.properties

↓

Load Profile-Specific File

↓

Override Common Properties

↓

Application Ready
```

---

# Configuration Priority

Suppose

application.properties

```properties
server.port=8080
```

application-prod.properties

```properties
server.port=80
```

Active Profile

```
prod
```

Result

```
Server Port

↓

80
```

Profile-specific properties override common properties.

---

# Activating Profile Using Environment Variable

Instead of

```properties
spring.profiles.active=prod
```

Use

```
SPRING_PROFILES_ACTIVE=prod
```

Spring Boot automatically activates the profile.

---

# Activating Profile Using Command Line

```bash
java -jar app.jar --spring.profiles.active=prod
```

Flow

```
Command Line

↓

Active Profile

↓

Spring Boot

↓

Load Configuration
```

---

# Using @Profile

You can create beans that exist only in a specific environment.

Development Bean

```java
@Component
@Profile("dev")
public class DevEmailService {

}
```

Production Bean

```java
@Component
@Profile("prod")
public class ProdEmailService {

}
```

---

# Bean Loading Flow

```
Active Profile

↓

dev

↓

Load DevEmailService

↓

Ignore ProdEmailService
```

---

# Multiple Profiles

A bean can belong to multiple profiles.

```java
@Component
@Profile({"dev","test"})
public class TestLogger {

}
```

The bean is created when either:

```
dev
```

or

```
test
```

is active.

---

# Profile-Specific Beans

```
Development

↓

Fake Payment Gateway
```

```
Production

↓

Real Payment Gateway
```

Spring automatically selects the correct bean.

---

# Default Profile

If no profile is active,

Spring uses

```
default
```

Configuration from

```
application.properties
```

is applied.

---

# Profiles in Docker

Environment Variable

```bash
docker run \
-e SPRING_PROFILES_ACTIVE=prod \
my-app
```

Flow

```
Docker

↓

Environment Variable

↓

Spring Boot

↓

Production Profile
```

---

# Profiles in Kubernetes

Example

```yaml
env:
  - name: SPRING_PROFILES_ACTIVE
    value: prod
```

---

# Profiles vs Environment Variables

| Spring Profiles | Environment Variables |
|-----------------|-----------------------|
| Select configuration files | Store configuration values |
| Example: dev, test, prod | Example: DB_PASSWORD |
| Change application behavior | Supply configuration values |
| Load profile-specific beans | Override property values |

---

# Profiles vs Hardcoding

## Hardcoded

```java
if(environment.equals("prod")){

}
```

Not recommended.

---

## Using Profiles

```java
@Profile("prod")
```

Cleaner and easier to maintain.

---

# Real-World Example

## Banking Application

Development

```
Mock Payment Service
```

Production

```
Real Payment Service
```

---

## E-Commerce Website

Development

```
Local Database
```

Production

```
Cloud Database
```

---

## Email Service

Development

```
Fake SMTP Server
```

Production

```
Real SMTP Server
```

---

# Advantages

- Easy environment-specific configuration.
- No code changes between environments.
- Supports environment-specific beans.
- Improves maintainability.
- Integrates with Docker and Kubernetes.

---

# Best Practices

- Keep common configuration in `application.properties`.
- Store environment-specific configuration in profile-specific files.
- Never commit production secrets to Git.
- Use `@Profile` for environment-specific beans.
- Activate profiles using environment variables in production.

---

# Interview Questions

### 1. What are Spring Profiles?

Spring Profiles allow an application to load different configurations and beans for different environments such as development, testing, and production.

---

### 2. How do you activate a profile?

Using:

```properties
spring.profiles.active=dev
```

or

```text
SPRING_PROFILES_ACTIVE=dev
```

or

```bash
java -jar app.jar --spring.profiles.active=dev
```

---

### 3. Which annotation creates profile-specific beans?

```java
@Profile
```

---

### 4. Which configuration file is always loaded?

```
application.properties
```

It contains the common configuration shared across all profiles.

---

### 5. What happens if no profile is active?

Spring uses the **default** profile and loads configuration from `application.properties`.

---

### 6. Can a bean belong to multiple profiles?

Yes.

Example:

```java
@Profile({"dev","test"})
```

---

### 7. Why are Spring Profiles useful?

They allow the same application to run in different environments with different configurations without modifying the source code.

---

# Quick Revision

- Spring Profiles support environment-specific configurations.
- Common profiles are **dev**, **test**, and **prod**.
- Use files like `application-dev.properties` and `application-prod.properties`.
- Activate profiles using `spring.profiles.active`, environment variables, or command-line arguments.
- Use `@Profile` to create profile-specific beans.
- Profile-specific properties override common properties.
- Keep shared configuration in `application.properties`.
- Spring Profiles are widely used in production deployments with Docker, Kubernetes, and cloud platforms.