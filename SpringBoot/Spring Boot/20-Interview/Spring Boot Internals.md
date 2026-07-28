# Spring Boot Internals

## What are Spring Boot Internals?

Spring Boot Internals explain **what happens behind the scenes** when a Spring Boot application starts.

Understanding these internals helps you:

- Write better Spring Boot applications
- Debug startup issues
- Optimize performance
- Crack Spring Boot interviews

> **In simple words:**
>
> Spring Boot Internals explain **how Spring Boot works internally**, not just how to use it.

---

# Complete Startup Flow

```
main()

↓

SpringApplication.run()

↓

Create SpringApplication Object

↓

Detect Application Type

↓

Create Application Context

↓

Load Environment

↓

Read application.properties

↓

Start Embedded Server

↓

Component Scanning

↓

Create Beans

↓

Dependency Injection

↓

Auto Configuration

↓

Bean Initialization

↓

Application Ready
```

---

# Step 1: main() Method

Every Spring Boot application starts here.

```java
@SpringBootApplication
public class Application {

    public static void main(String[] args) {

        SpringApplication.run(
                Application.class,
                args
        );

    }

}
```

`SpringApplication.run()` is responsible for bootstrapping the entire application.

---

# Step 2: Create SpringApplication

Internally,

```java
SpringApplication app =
        new SpringApplication(Application.class);
```

The `SpringApplication` object stores startup information and coordinates the boot process.

---

# Step 3: Detect Application Type

Spring Boot checks the classpath.

If it finds:

```
spring-boot-starter-web

↓

Servlet Application

↓

Tomcat
```

If it finds:

```
spring-boot-starter-webflux

↓

Reactive Application

↓

Netty
```

---

# Step 4: Create Application Context

Spring creates an IoC Container.

Examples:

```
Servlet App

↓

AnnotationConfigServletWebServerApplicationContext
```

```
Reactive App

↓

AnnotationConfigReactiveWebServerApplicationContext
```

The Application Context manages every Spring Bean.

---

# Step 5: Load Environment

Spring Boot loads configuration from multiple sources.

Priority (highest to lowest):

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

Example:

```properties
server.port=8081

spring.application.name=demo
```

---

# Step 6: Component Scanning

Spring scans packages starting from the package containing the main class.

```
com.example

├── controller

├── service

├── repository

└── config
```

Classes annotated with:

- `@Component`
- `@Service`
- `@Repository`
- `@Controller`
- `@RestController`

are registered as Spring Beans.

---

# Step 7: Bean Creation

For every discovered component:

```
Class

↓

Object Created

↓

Spring Bean
```

Example:

```java
@Service
public class UserService {

}
```

Spring creates only one instance by default (Singleton scope).

---

# Step 8: Dependency Injection

Example:

```java
@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

}
```

Flow:

```
UserRepository Bean

↓

Injected into

↓

UserService Bean
```

---

# Step 9: Auto Configuration

This is one of Spring Boot's biggest features.

Example:

Dependency added:

```xml
spring-boot-starter-data-jpa
```

Spring Boot automatically configures:

- DataSource
- EntityManager
- Hibernate
- Transaction Manager

No manual configuration required.

---

# How Auto Configuration Works

Spring Boot uses:

```
@EnableAutoConfiguration

↓

AutoConfiguration.imports

↓

Conditional Configuration

↓

Beans Created
```

Auto-configuration classes are applied only when their conditions are satisfied.

Example:

```java
@ConditionalOnClass(DataSource.class)
```

Meaning:

> Configure the bean only if `DataSource` exists on the classpath.

---

# Step 10: Embedded Server Starts

Spring Boot automatically starts an embedded server.

Supported servers:

- Tomcat (Default)
- Jetty
- Undertow

Flow:

```
Application

↓

Embedded Tomcat

↓

Port 8080

↓

Ready
```

---

# Step 11: Bean Lifecycle

```
Bean Created

↓

Dependency Injection

↓

@PostConstruct

↓

Bean Ready

↓

Application Running

↓

@PreDestroy

↓

Bean Destroyed
```

---

# Bean Scopes

| Scope | Description |
|--------|-------------|
| Singleton | One Bean per Application (Default) |
| Prototype | New Bean every request from the container |
| Request | One Bean per HTTP Request |
| Session | One Bean per HTTP Session |

---

# What is IoC Container?

The IoC (Inversion of Control) Container is responsible for:

- Creating Beans
- Managing Beans
- Injecting Dependencies
- Destroying Beans

```
Application

↓

IoC Container

↓

Beans
```

---

# What is DispatcherServlet?

`DispatcherServlet` is the front controller of Spring MVC.

Flow:

```
Client

↓

DispatcherServlet

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Response
```

Every HTTP request passes through the `DispatcherServlet`.

---

# Spring Boot Request Flow

```
Browser

↓

DispatcherServlet

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Repository

↓

Service

↓

Controller

↓

JSON Response
```

---

# Starter Dependencies

Starter dependencies provide preconfigured libraries.

Example:

```xml
spring-boot-starter-web
```

Includes:

- Spring MVC
- Embedded Tomcat
- Jackson
- Validation support

---

# application.properties Loading

Spring Boot automatically reads:

```
src

└── main

    └── resources

        └── application.properties
```

Example:

```properties
server.port=9090

spring.application.name=order-service
```

---

# Why is Spring Boot Fast to Develop?

Because it provides:

- Auto Configuration
- Embedded Server
- Starter Dependencies
- Component Scanning
- Convention over Configuration

---

# Internal Architecture

```
main()

↓

SpringApplication

↓

Application Context

↓

Environment

↓

Component Scan

↓

Bean Creation

↓

Dependency Injection

↓

Auto Configuration

↓

Embedded Server

↓

Application Ready
```

---

# Advantages

- Very little configuration
- Faster development
- Automatic dependency management
- Embedded server support
- Production-ready features
- Easy testing and deployment

---

# Common Mistakes

❌ Placing the main class in a sub-package, causing component scanning to miss classes.

❌ Creating objects using `new` instead of letting Spring manage them.

❌ Using field injection instead of constructor injection.

❌ Defining duplicate beans without qualifiers.

❌ Assuming Auto Configuration always works without checking dependencies or configuration.

---

# Interview Questions

### 1. What happens when `SpringApplication.run()` is called?

It starts the Spring Boot application by creating the Application Context, loading configuration, performing component scanning, creating beans, applying auto-configuration, starting the embedded server, and preparing the application to handle requests.

---

### 2. What is the Application Context?

It is Spring's IoC container that manages bean creation, dependency injection, configuration, and the bean lifecycle.

---

### 3. What is Auto Configuration?

Auto Configuration automatically creates and configures beans based on the dependencies available on the application's classpath.

---

### 4. What is Component Scanning?

Component Scanning searches packages for classes annotated with Spring stereotypes (such as `@Component`, `@Service`, `@Repository`, and `@Controller`) and registers them as beans.

---

### 5. Why should the main class be placed in the root package?

Because Spring Boot scans the package containing the main class and all its sub-packages. Placing it in the root ensures all application components are discovered.

---

### 6. What is the default embedded server in Spring Boot?

Apache Tomcat.

---

### 7. What is the role of DispatcherServlet?

It is the front controller that receives every HTTP request, routes it to the appropriate controller, and returns the response.

---

### 8. What is the default bean scope?

**Singleton**.

---

### 9. What is the IoC Container?

It is responsible for creating, managing, injecting, and destroying Spring-managed beans.

---

### 10. How does Spring Boot know which beans to create automatically?

It uses Auto Configuration classes with conditional annotations (such as `@ConditionalOnClass` and related conditions) to determine whether a bean should be created.

---

# Quick Revision

- `main()` calls `SpringApplication.run()`.
- Spring creates the **Application Context (IoC Container)**.
- Configuration is loaded from properties, environment variables, and command-line arguments.
- Component Scanning discovers Spring-managed classes.
- Beans are created and dependencies are injected.
- Auto Configuration configures libraries automatically.
- Embedded Tomcat starts by default.
- `DispatcherServlet` handles all incoming HTTP requests.
- Singleton is the default bean scope.
- Spring Boot follows **Convention over Configuration** to reduce manual setup.