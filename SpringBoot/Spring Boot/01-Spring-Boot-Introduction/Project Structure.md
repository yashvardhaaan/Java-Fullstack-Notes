# Spring Boot Project Structure

## Introduction

A well-organized project structure makes a Spring Boot application easier to develop, test, and maintain.

Spring Boot follows a layered architecture where each package has a specific responsibility.

> **In simple words:**
> Every package has one job. This separation makes the code clean, reusable, and scalable.

---

# Standard Spring Boot Project Structure

```
EmployeeManagement/
│
├── src/
│   │
│   ├── main/
│   │   │
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── employee/
│   │   │               │
│   │   │               ├── EmployeeApplication.java
│   │   │               │
│   │   │               ├── controller/
│   │   │               ├── service/
│   │   │               ├── repository/
│   │   │               ├── entity/
│   │   │               ├── dto/
│   │   │               ├── config/
│   │   │               ├── exception/
│   │   │               ├── security/
│   │   │               └── util/
│   │   │
│   │   └── resources/
│   │       │
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

Contains all Java source code.

```
src
└── main
    └── java
```

Everything related to your application's logic is stored here.

---

## 2. EmployeeApplication.java

This is the entry point of the application.

```java
@SpringBootApplication
public class EmployeeApplication {

    public static void main(String[] args) {
        SpringApplication.run(EmployeeApplication.class, args);
    }

}
```

Responsibilities:

- Starts Spring Boot
- Creates IoC Container
- Performs Component Scan
- Starts Embedded Tomcat

---

## 3. controller/

Handles HTTP requests.

Responsibilities:

- Accept requests
- Validate input
- Return HTTP responses

Example:

```java
@RestController
@RequestMapping("/employees")
public class EmployeeController {

}
```

---

## 4. service/

Contains business logic.

Responsibilities:

- Process business rules
- Call repository layer
- Perform calculations
- Handle transactions

Example:

```java
@Service
public class EmployeeService {

}
```

---

## 5. repository/

Communicates with the database.

Usually extends:

```java
JpaRepository
```

Example:

```java
@Repository
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

Responsibilities:

- Save
- Update
- Delete
- Fetch

---

## 6. entity/

Contains JPA Entity classes.

Each entity represents one database table.

Example:

```java
@Entity
public class Employee {

}
```

---

## 7. dto/

DTO = Data Transfer Object.

Used to transfer data between:

- Client
- Controller
- Service

Examples:

```
EmployeeRequest.java

EmployeeResponse.java
```

Benefits:

- Hide entity fields
- Improve security
- Reduce unnecessary data transfer

---

## 8. config/

Contains configuration classes.

Examples:

- Swagger Configuration
- CORS Configuration
- Bean Configuration
- Security Configuration

---

## 9. exception/

Contains custom exceptions.

Example:

```
ResourceNotFoundException

GlobalExceptionHandler
```

Used for centralized exception handling.

---

## 10. security/

Contains Spring Security-related classes.

Examples:

- JWT Filter
- SecurityConfig
- UserDetailsService
- Authentication Provider

---

## 11. util/

Contains helper classes.

Examples:

- Date Utility
- JWT Utility
- Password Utility
- Constants

---

# resources Folder

```
src/main/resources
```

Contains non-Java files.

---

## application.properties

Stores application configuration.

Example:

```properties
server.port=8080

spring.application.name=EmployeeService
```

---

## application.yml

Alternative configuration file using YAML syntax.

Example:

```yaml
server:
  port: 8080
```

---

## static/

Contains static resources.

Examples:

```
CSS

JavaScript

Images

Fonts
```

---

## templates/

Contains HTML templates.

Used with:

- Thymeleaf
- Mustache
- FreeMarker

---

# src/test/java

Contains test classes.

Examples:

```
EmployeeControllerTest

EmployeeServiceTest

EmployeeRepositoryTest
```

Used for:

- Unit Testing
- Integration Testing

---

# pom.xml

Maven's project configuration file.

Contains:

- Dependencies
- Plugins
- Java Version
- Build Configuration

Example:

```xml
<dependencies>

</dependencies>
```

---

# Maven Wrapper

Files:

```
mvnw

mvnw.cmd
```

Purpose:

Run Maven commands without installing Maven globally.

Example:

```bash
./mvnw spring-boot:run
```

Windows:

```bash
mvnw.cmd spring-boot:run
```

---

# .gitignore

Specifies files that Git should ignore.

Common entries:

```
target/

.idea/

*.class

*.log
```

---

# Package Interaction

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

Response Flow:

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
com.example.employee
│
├── controller
├── service
├── repository
├── entity
├── dto
├── config
├── exception
├── security
├── util
└── EmployeeApplication.java
```

---

# Best Practices

- Keep one responsibility per package.
- Do not put business logic inside controllers.
- Keep controllers thin and services rich.
- Use DTOs instead of exposing entities directly.
- Handle exceptions globally.
- Store configuration in `application.properties` or `application.yml`.
- Follow naming conventions consistently.

---

# Advantages

- Clean architecture
- Easy maintenance
- Better readability
- Scalable codebase
- Easy testing
- Separation of concerns
- Reusable components

---

# Interview Questions

### 1. What is the purpose of `src/main/java`?

It contains all the Java source code of the application.

---

### 2. What is stored inside the `controller` package?

Classes that handle HTTP requests and return responses.

---

### 3. Why do we use a `service` layer?

To keep business logic separate from the controller, making the application easier to maintain and test.

---

### 4. What is the role of the `repository` package?

It communicates with the database and performs CRUD operations.

---

### 5. Why do we use DTOs?

DTOs transfer only the required data between the client and the server while hiding internal entity details.

---

### 6. What is stored in `src/main/resources`?

Configuration files, static resources, templates, and other non-Java files.

---

### 7. What is `pom.xml`?

It is the Maven configuration file that manages project dependencies, plugins, and build settings.

---

# Quick Revision

- `src/main/java` → Java source code
- `controller` → Handles HTTP requests
- `service` → Business logic
- `repository` → Database operations
- `entity` → Database tables
- `dto` → Data Transfer Objects
- `config` → Configuration classes
- `security` → Authentication & Authorization
- `exception` → Global exception handling
- `util` → Helper classes
- `resources` → Configuration and static files
- `test` → Test classes
- `pom.xml` → Maven configuration
- `.gitignore` → Git ignore rules