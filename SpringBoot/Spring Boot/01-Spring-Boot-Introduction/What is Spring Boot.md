# What is Spring Boot?

## Definition

**Spring Boot** is an extension of the Spring Framework that makes it easy to build production-ready Java applications with minimal configuration.

It eliminates most of the boilerplate configuration required in Spring and allows developers to create applications quickly.

> **In simple words:**
> Spring Boot = Spring Framework + Auto Configuration + Embedded Server + Production Features

---

# Why was Spring Boot introduced?

Before Spring Boot:

- Large XML configuration files
- Manual dependency management
- Need to install external Tomcat server
- Lots of setup before writing business logic

Spring Boot solved these problems by providing:

- Auto Configuration
- Starter Dependencies
- Embedded Servers
- Opinionated Defaults
- Production-ready tools

---

# Features of Spring Boot

## 1. Auto Configuration

Automatically configures your application based on the dependencies available.

Example:

If you add:

```xml
spring-boot-starter-web
```

Spring Boot automatically configures:

- DispatcherServlet
- Tomcat
- Jackson
- Spring MVC

without writing configuration.

---

## 2. Starter Dependencies

Instead of adding many libraries individually, Spring Boot provides starter projects.

Example:

```xml
spring-boot-starter-web
```

Already contains:

- Spring MVC
- Jackson
- Validation
- Embedded Tomcat
- Logging

---

## 3. Embedded Server

No need to install Tomcat separately.

Just run:

```bash
mvn spring-boot:run
```

or

```bash
java -jar app.jar
```

The application starts immediately.

Supported servers:

- Tomcat (default)
- Jetty
- Undertow

---

## 4. Production Ready

Spring Boot provides production-ready features through **Spring Boot Actuator**.

Examples:

- Health Check
- Metrics
- Application Info
- Memory Usage
- Thread Dump

---

## 5. Opinionated Defaults

Spring Boot provides sensible default configurations.

Example:

- Default logging
- Default JSON converter
- Default embedded server
- Default error handling

You only customize when needed.

---

# Spring Boot Architecture

```
Developer
      │
      ▼
Spring Boot Application
      │
      ▼
Auto Configuration
      │
      ▼
Spring Framework
      │
      ▼
Embedded Tomcat
      │
      ▼
Running Application
```

---

# Real World Example

Imagine opening a restaurant.

### Without Spring Boot

You have to:

- Buy kitchen equipment
- Install gas
- Arrange tables
- Hire staff
- Set up billing
- Then start cooking

A lot of preparation before serving food.

---

### With Spring Boot

You rent a fully equipped kitchen.

Everything is already available.

You only cook the food.

Spring Boot prepares the environment so you focus on writing business logic.

---

# Advantages

- Faster development
- Less configuration
- Easy dependency management
- Embedded server
- Production ready
- Easy deployment
- Better developer productivity
- Microservice friendly

---

# Disadvantages

- Less control over auto configuration
- Slightly larger application size
- Can be difficult to understand internal working initially

---

# Where is Spring Boot used?

- REST APIs
- Banking Applications
- E-Commerce Platforms
- Healthcare Systems
- Payment Gateways
- Microservices
- Enterprise Applications
- Cloud Applications

---

# Spring Boot Workflow

```
Write Code
      │
      ▼
Add Starter Dependency
      │
      ▼
Spring Boot Auto Configuration
      │
      ▼
Embedded Server Starts
      │
      ▼
Application Ready
```

---

# Interview Questions

### 1. What is Spring Boot?

Spring Boot is a framework built on top of the Spring Framework that simplifies application development by providing auto configuration, starter dependencies, embedded servers, and production-ready features.

---

### 2. Why use Spring Boot instead of Spring?

Because it reduces configuration, speeds up development, provides embedded servers, and simplifies dependency management.

---

### 3. Does Spring Boot replace Spring?

No.

Spring Boot is built on top of the Spring Framework.

---

### 4. Can Spring Boot work without Spring?

No.

Spring Boot internally uses the Spring Framework.

---

### 5. Which embedded servers are supported?

- Tomcat (Default)
- Jetty
- Undertow

---

### 6. What are the main features of Spring Boot?

- Auto Configuration
- Starter Dependencies
- Embedded Server
- Actuator
- Opinionated Defaults

---

# Quick Revision

- Spring Boot is built on top of Spring Framework.
- Reduces configuration.
- Uses starter dependencies.
- Provides embedded server.
- Supports auto configuration.
- Production-ready using Actuator.
- Focus on business logic instead of setup.