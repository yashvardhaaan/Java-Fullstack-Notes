# Spring Boot Architecture

## Introduction

Spring Boot follows a layered architecture built on top of the Spring Framework. It simplifies application development by automatically configuring the application, managing dependencies, and providing an embedded server.

> **In simple words:**
> Spring Boot provides a ready-made architecture so you can focus on writing business logic instead of configuring the framework.

---

# Spring Boot Architecture Diagram

```
                    Client
         (Browser / Mobile App / Postman)
                         │
                         ▼
               Embedded Web Server
            (Tomcat / Jetty / Undertow)
                         │
                         ▼
                DispatcherServlet
                         │
                         ▼
                  Controller Layer
                         │
                         ▼
                   Service Layer
                         │
                         ▼
                 Repository Layer
                         │
                         ▼
                 Database (MySQL,
              PostgreSQL, MongoDB)
```

Meanwhile, Spring Boot itself provides:

```
Spring Boot
│
├── Auto Configuration
├── Starter Dependencies
├── Spring Boot CLI
├── Spring Boot Actuator
├── Externalized Configuration
└── Embedded Server
```

---

# Components of Spring Boot Architecture

## 1. Client

The client sends requests to the application.

Examples:

- Browser
- Mobile App
- React Application
- Angular Application
- Postman

Example:

```
GET /employees
```

---

## 2. Embedded Server

Spring Boot contains an embedded web server.

Supported servers:

- Tomcat (Default)
- Jetty
- Undertow

Instead of deploying a WAR file to Tomcat, Spring Boot starts the server automatically.

```
Application Starts
        │
        ▼
Embedded Tomcat Starts
        │
        ▼
Ready to Accept Requests
```

---

## 3. DispatcherServlet

The **DispatcherServlet** is the front controller of Spring MVC.

Responsibilities:

- Receives every HTTP request
- Finds the correct controller
- Invokes the controller method
- Returns the response

Flow:

```
Client

↓

DispatcherServlet

↓

Controller
```

---

## 4. Controller Layer

The controller handles incoming HTTP requests.

Responsibilities:

- Accept requests
- Validate input
- Call the service layer
- Return response

Example:

```java
@RestController
@RequestMapping("/employees")
public class EmployeeController {

}
```

---

## 5. Service Layer

The service layer contains business logic.

Responsibilities:

- Apply business rules
- Perform calculations
- Call repositories
- Handle transactions

Example:

```java
@Service
public class EmployeeService {

}
```

---

## 6. Repository Layer

The repository layer communicates with the database.

Usually extends:

```java
JpaRepository
```

Responsibilities:

- Save
- Update
- Delete
- Fetch data

Example:

```java
@Repository
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

---

## 7. Database

Stores application data.

Supported databases:

- MySQL
- PostgreSQL
- Oracle
- SQL Server
- MongoDB

---

# Internal Spring Boot Components

## Auto Configuration

Automatically configures beans based on:

- Dependencies
- Properties
- Existing Beans

Example:

```
spring-boot-starter-web

↓

Configure Spring MVC

↓

Configure Tomcat

↓

Configure Jackson
```

---

## Starter Dependencies

Instead of adding many libraries manually, Spring Boot provides starter projects.

Example:

```
spring-boot-starter-web
```

Contains:

- Spring MVC
- Jackson
- Embedded Tomcat
- Logging

---

## Spring Boot Actuator

Provides production-ready monitoring.

Examples:

```
/actuator/health

/actuator/info

/actuator/metrics
```

---

## Externalized Configuration

Application settings are stored outside the code.

Example:

```properties
server.port=8080

spring.datasource.url=jdbc:mysql://localhost/demo
```

---

# Complete Request Flow

Suppose the client requests:

```
GET /employees/1
```

Flow:

```
Client
   │
   ▼
Embedded Tomcat
   │
   ▼
DispatcherServlet
   │
   ▼
EmployeeController
   │
   ▼
EmployeeService
   │
   ▼
EmployeeRepository
   │
   ▼
Database
   │
   ▼
EmployeeRepository
   │
   ▼
EmployeeService
   │
   ▼
EmployeeController
   │
   ▼
JSON Response
   │
   ▼
Client
```

---

# Spring Boot Startup Flow

```
main()

↓

SpringApplication.run()

↓

Create IoC Container

↓

Perform Component Scan

↓

Auto Configuration

↓

Create Beans

↓

Start Embedded Tomcat

↓

Application Ready
```

---

# Advantages

- Minimal configuration
- Embedded server
- Auto configuration
- Easy dependency management
- Production-ready features
- Layered architecture
- Easy testing and maintenance

---

# Real-World Example

Imagine a restaurant.

- **Customer** → Client
- **Receptionist** → DispatcherServlet
- **Waiter** → Controller
- **Chef** → Service
- **Store Room** → Repository
- **Kitchen Inventory** → Database

Flow:

```
Customer

↓

Receptionist

↓

Waiter

↓

Chef

↓

Store Room

↓

Inventory
```

The customer only sees the final food, not the internal process.

---

# Interview Questions

### 1. What is Spring Boot Architecture?

Spring Boot Architecture is a layered architecture consisting of the Client, Embedded Server, DispatcherServlet, Controller, Service, Repository, and Database, supported by features like Auto Configuration, Starter Dependencies, and Actuator.

---

### 2. What is the role of DispatcherServlet?

DispatcherServlet is the front controller that receives all HTTP requests and forwards them to the appropriate controller.

---

### 3. Why does Spring Boot use an embedded server?

It eliminates the need to install and configure an external application server, allowing applications to run directly as executable JAR files.

---

### 4. What is the purpose of the Service layer?

The Service layer contains business logic and coordinates operations between the Controller and Repository layers.

---

### 5. What is the responsibility of the Repository layer?

The Repository layer handles database operations such as CRUD (Create, Read, Update, Delete) using Spring Data JPA or other persistence frameworks.

---

### 6. What are the main internal features of Spring Boot?

- Auto Configuration
- Starter Dependencies
- Embedded Server
- Actuator
- Externalized Configuration

---

# Quick Revision

- Client sends HTTP requests.
- Embedded Tomcat receives the request.
- DispatcherServlet acts as the front controller.
- Controller handles the request.
- Service executes business logic.
- Repository communicates with the database.
- Database returns data.
- Response is sent back as JSON.
- Spring Boot simplifies everything using Auto Configuration, Starter Dependencies, and an Embedded Server.