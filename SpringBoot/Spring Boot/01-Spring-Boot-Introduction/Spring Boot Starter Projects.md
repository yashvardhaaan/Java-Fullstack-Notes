# Spring Boot Project Structure

## Introduction

When you create a Spring Boot project using **Spring Initializr**, it generates a standard project structure.

This structure helps organize your code, configuration files, static resources, templates, and tests in a clean and maintainable way.

> **In simple words:**  
> The project structure is the folder organization that keeps your Spring Boot application well-structured and easy to manage.

---

# Standard Spring Boot Project Structure

```
my-project/
│
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/demo/
│   │   │       ├── DemoApplication.java
│   │   │       ├── controller/
│   │   │       ├── service/
│   │   │       ├── repository/
│   │   │       ├── entity/
│   │   │       ├── dto/
│   │   │       ├── config/
│   │   │       ├── exception/
│   │   │       └── util/
│   │   │
│   │   └── resources/
│   │       ├── application.properties
│   │       ├── static/
│   │       ├── templates/
│   │       └── application.yml
│   │
│   └── test/
│       └── java/
│
├── pom.xml
├── mvnw
├── mvnw.cmd
└── .gitignore
```

---

# Folder Explanation

## 1. src/main/java

This folder contains all the Java source code.

Example:

```
src/main/java
```

Inside it, you'll create packages like:

- controller
- service
- repository
- entity
- dto
- config
- exception
- util

---

## 2. DemoApplication.java

This is the **main class** of the application.

Example:

```java
@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

}
```

It starts the Spring Boot application.

---

## 3. controller/

Contains REST Controllers.

Responsibilities:

- Handle HTTP requests
- Receive client data
- Return HTTP responses

Example:

```
EmployeeController.java
```

---

## 4. service/

Contains business logic.

Responsibilities:

- Process data
- Apply business rules
- Call repositories

Example:

```
EmployeeService.java
```

---

## 5. repository/

Contains database access code.

Responsibilities:

- Save data
- Update data
- Delete data
- Fetch data

Usually extends:

```java
JpaRepository
```

Example:

```
EmployeeRepository.java
```

---

## 6. entity/

Contains database entities.

Each class represents a database table.

Example:

```java
@Entity
public class Employee {

}
```

---

## 7. dto/

DTO = Data Transfer Object.

Used for transferring data between:

- Client
- Controller
- Service

instead of exposing entities directly.

Example:

```
EmployeeRequest.java

EmployeeResponse.java
```

---

## 8. config/

Contains configuration classes.

Examples:

- Security Configuration
- Swagger Configuration
- CORS Configuration
- Bean Configuration

---

## 9. exception/

Contains custom exceptions and global exception handlers.

Examples:

```
ResourceNotFoundException

GlobalExceptionHandler
```

---

## 10. util/

Contains helper or utility classes.

Examples:

- Date Utility
- JWT Utility
- Password Utility

---

# Resources Folder

```
src/main/resources
```

Contains non-Java resources.

---

## application.properties

Main configuration file.

Example:

```properties
spring.application.name=employee-service

server.port=8080

spring.datasource.url=jdbc:mysql://localhost:3306/demo
```

---

## application.yml

Alternative to `application.properties`.

Example:

```yaml
server:
  port: 8080
```

---

## static/

Contains static files.

Examples:

- CSS
- JavaScript
- Images
- Fonts

---

## templates/

Contains HTML templates.

Used with:

- Thymeleaf
- FreeMarker
- Mustache

---

# src/test/java

Contains test classes.

Examples:

- Unit Tests
- Integration Tests

Example:

```
EmployeeServiceTest.java
```

---

# pom.xml

The Maven configuration file.

Contains:

- Dependencies
- Plugins
- Project Information
- Build Configuration

Example:

```xml
<dependencies>

</dependencies>
```

---

# mvnw and mvnw.cmd

These are **Maven Wrapper** files.

They allow running Maven even if Maven is not installed globally.

Run:

```bash
./mvnw spring-boot:run
```

or on Windows:

```bash
mvnw.cmd spring-boot:run
```

---

# .gitignore

Specifies files Git should ignore.

Common ignored files:

```
target/

.idea/

*.class
```

---

# Typical Request Flow

```
Client
   │
   ▼
Controller
   │
   ▼
Service
   │
   ▼
Repository
   │
   ▼
Database
```

Response:

```
Database
   │
Repository
   │
Service
   │
Controller
   │
Client
```

---

# Recommended Package Structure

```
com.example.demo
│
├── controller
├── service
├── repository
├── entity
├── dto
├── config
├── exception
├── util
└── DemoApplication.java
```

---

# Advantages

- Clean organization
- Easy maintenance
- Separation of concerns
- Scalable architecture
- Easier testing
- Better readability

---

# Interview Questions

### 1. What is the purpose of `src/main/java`?

It contains the application's Java source code.

---

### 2. What is stored in `src/main/resources`?

Configuration files, static resources, templates, and other non-Java resources.

---

### 3. What is the purpose of the `controller` package?

It handles incoming HTTP requests and returns responses.

---

### 4. Why do we use the `service` package?

To implement business logic and keep controllers lightweight.

---

### 5. What is the purpose of `repository`?

It provides database access using Spring Data JPA or other persistence technologies.

---

### 6. What is `pom.xml`?

It is Maven's project configuration file containing dependencies, plugins, and build settings.

---

# Quick Revision

- `src/main/java` → Java source code
- `controller` → Handles HTTP requests
- `service` → Business logic
- `repository` → Database operations
- `entity` → Database tables
- `dto` → Data transfer objects
- `config` → Configuration classes
- `resources` → Properties, templates, static files
- `test` → Test classes
- `pom.xml` → Maven configuration
- `.gitignore` → Git ignore rules
- `mvnw` → Maven Wrapper