# Spring vs Spring Boot

## Introduction

Many beginners think **Spring** and **Spring Boot** are different frameworks.  
Actually,

> **Spring Boot is built on top of the Spring Framework.**

Spring Boot simplifies Spring development by reducing configuration and providing many features out of the box.

---

# What is Spring?

Spring is a lightweight Java framework used for building enterprise applications.

It provides features like:

- Dependency Injection (DI)
- Inversion of Control (IoC)
- Spring MVC
- Spring Security
- Spring Data JPA
- Transaction Management

In traditional Spring, developers have to configure most things manually.

---

# What is Spring Boot?

Spring Boot is an extension of the Spring Framework.

It provides:

- Auto Configuration
- Starter Dependencies
- Embedded Servers
- Production-ready features
- Minimal configuration

Its goal is to let developers focus on writing business logic instead of setup.

---

# Spring vs Spring Boot

| Feature | Spring | Spring Boot |
|---------|---------|-------------|
| Configuration | Mostly Manual | Mostly Automatic |
| XML Configuration | Required in older versions | Rarely Required |
| Dependency Management | Manual | Starter Dependencies |
| Embedded Server | No | Yes |
| Deployment | WAR file on external server | Executable JAR |
| Development Speed | Slower | Faster |
| Initial Setup | More | Very Less |
| Production Features | Need separate setup | Built-in (Actuator) |
| Microservices | Possible | Highly Recommended |

---

# Configuration Example

## Spring

You need to configure:

- DispatcherServlet
- View Resolver
- Component Scan
- DataSource
- Transaction Manager
- Server

Lots of configuration before writing code.

---

## Spring Boot

Just add:

```xml
spring-boot-starter-web
```

Create:

```java
@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

}
```

Run the application.

Everything is configured automatically.

---

# Dependency Management

## Spring

Need to add many dependencies individually.

Example:

- spring-core
- spring-context
- spring-web
- spring-beans
- spring-expression
- spring-aop
- jackson
- tomcat

---

## Spring Boot

Only one dependency:

```xml
spring-boot-starter-web
```

It automatically includes all required libraries.

---

# Server Management

## Spring

Need to install:

- Apache Tomcat
- Jetty
- WebLogic
- JBoss

Deploy the WAR file manually.

---

## Spring Boot

Embedded server is already included.

Simply run:

```bash
mvn spring-boot:run
```

or

```bash
java -jar app.jar
```

No separate server installation is needed.

---

# Project Structure

## Spring

```
Application
     │
Configuration
     │
XML / Java Config
     │
External Server
     │
Run
```

---

## Spring Boot

```
Application
     │
Starter Dependencies
     │
Auto Configuration
     │
Embedded Server
     │
Run
```

---

# Real World Example

Imagine building a house.

### Spring

You buy everything separately:

- Bricks
- Cement
- Doors
- Windows
- Electric wiring
- Plumbing

Then assemble everything.

---

### Spring Boot

You buy a ready-to-move house.

Most things are already installed.

You only customize what you need.

---

# Advantages of Spring

- Very flexible
- Full control over configuration
- Suitable for complex enterprise applications

---

# Advantages of Spring Boot

- Faster development
- Less configuration
- Embedded server
- Easy dependency management
- Production-ready
- Better for microservices

---

# Does Spring Boot Replace Spring?

**No.**

Spring Boot **uses Spring internally**.

```
Spring Boot
      │
      ▼
Spring Framework
      │
      ▼
Core Spring Modules
```

Without Spring, Spring Boot cannot work.

---

# When Should You Use Spring?

Use Spring when:

- You need complete control over configuration.
- You are maintaining older enterprise applications.
- The project already uses traditional Spring.

---

# When Should You Use Spring Boot?

Use Spring Boot when:

- Building REST APIs
- Developing Microservices
- Creating Cloud Applications
- Rapid Development
- Modern Enterprise Applications

Today, almost all new Spring projects use Spring Boot.

---

# Interview Questions

### 1. What is the difference between Spring and Spring Boot?

Spring is a framework for building Java applications. Spring Boot is an extension of Spring that simplifies development by providing auto configuration, starter dependencies, and embedded servers.

---

### 2. Does Spring Boot replace Spring?

No. Spring Boot is built on top of the Spring Framework.

---

### 3. Why is Spring Boot faster to develop?

Because it eliminates most manual configuration through auto configuration and starter dependencies.

---

### 4. Does Spring Boot require an external Tomcat server?

No. It comes with an embedded Tomcat server by default.

---

### 5. Can we create WAR files using Spring Boot?

Yes. Although Spring Boot commonly creates executable JAR files, it can also generate WAR files for deployment to external servers.

---

# Quick Revision

- Spring Boot is built on top of Spring.
- Spring requires more manual configuration.
- Spring Boot provides auto configuration.
- Spring Boot uses starter dependencies.
- Spring Boot has an embedded server.
- Spring Boot is preferred for modern applications and microservices.
- Spring provides the core features; Spring Boot makes them easier to use.