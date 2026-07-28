# @RestController

## What is `@RestController`?

`@RestController` is a Spring annotation used to create **RESTful Web Services**.

It tells Spring that the class will handle HTTP requests and return **data directly** (usually JSON or XML) instead of rendering a web page.

> **In simple words:**
>
> `@RestController` tells Spring:
> **"This class will receive HTTP requests and return data as the response."**

---

# Why Do We Need `@RestController`?

Suppose a mobile application requests employee details.

```
GET /employees/101
```

The backend should return:

```json
{
  "id": 101,
  "name": "John",
  "department": "IT"
}
```

Instead of returning an HTML page, we return JSON.

This is exactly what `@RestController` does.

---

# Syntax

```java
@RestController
public class EmployeeController {

}
```

Spring automatically treats every method inside this class as a REST endpoint.

---

# How `@RestController` Works

```
Client

↓

HTTP Request

↓

@RestController

↓

Business Logic

↓

JSON Response

↓

Client
```

---

# Example

```java
@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {

        return "Hello Spring Boot";

    }

}
```

Request:

```
GET /hello
```

Response:

```
Hello Spring Boot
```

---

# Returning JSON

```java
@RestController
public class EmployeeController {

    @GetMapping("/employee")
    public Employee getEmployee() {

        return new Employee(101, "John", "IT");

    }

}
```

Employee:

```java
public class Employee {

    private int id;
    private String name;
    private String department;

    public Employee(int id, String name, String department) {
        this.id = id;
        this.name = name;
        this.department = department;
    }

}
```

Response:

```json
{
  "id": 101,
  "name": "John",
  "department": "IT"
}
```

Spring automatically converts the Java object into JSON using **Jackson**.

---

# Common HTTP Mapping Annotations

| Annotation | HTTP Method |
|------------|-------------|
| `@GetMapping` | GET |
| `@PostMapping` | POST |
| `@PutMapping` | PUT |
| `@PatchMapping` | PATCH |
| `@DeleteMapping` | DELETE |

Example:

```java
@RestController
@RequestMapping("/employees")
public class EmployeeController {

    @GetMapping
    public String getEmployees() {
        return "All Employees";
    }

    @PostMapping
    public String addEmployee() {
        return "Employee Added";
    }

}
```

---

# @RestController vs @Controller

## `@RestController`

```java
@RestController
public class EmployeeController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello";
    }

}
```

Response:

```
Hello
```

or JSON.

---

## `@Controller`

```java
@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "index";
    }

}
```

Response:

```
index.html
```

---

# Difference Between @RestController and @Controller

| `@RestController` | `@Controller` |
|-------------------|---------------|
| Returns JSON/XML or plain text | Returns View (HTML/JSP/Thymeleaf) |
| Used for REST APIs | Used for MVC Applications |
| Includes `@ResponseBody` automatically | Requires `@ResponseBody` to return data |

---

# Internal Working

`@RestController` is a combination of:

```java
@Controller
@ResponseBody
```

So,

```java
@RestController
```

is equivalent to:

```java
@Controller
@ResponseBody
```

`@ResponseBody` tells Spring to write the returned object directly into the HTTP response body.

---

# Request Flow

```
Client

↓

GET /employees

↓

DispatcherServlet

↓

@RestController

↓

Service Layer

↓

Repository

↓

Database

↓

JSON Response

↓

Client
```

---

# Real-World Example

Food Delivery App

```
GET /restaurants

↓

@RestController

↓

Restaurant List

↓

JSON

↓

Mobile App
```

The mobile app displays the restaurant list received from the REST API.

---

# Advantages

- Easy to build REST APIs
- Automatically returns JSON
- Reduces boilerplate code
- Integrates with Spring MVC
- Supports all HTTP methods

---

# Best Practices

- Use `@RestController` for REST APIs.
- Keep controllers lightweight; move business logic to the Service layer.
- Return appropriate HTTP status codes.
- Use `ResponseEntity` when you need more control over the response.

---

# Interview Questions

### 1. What is `@RestController`?

`@RestController` is a Spring annotation used to create REST APIs that return data directly instead of rendering views.

---

### 2. What does `@RestController` return?

It typically returns:

- JSON
- XML
- Plain Text

---

### 3. What is the difference between `@RestController` and `@Controller`?

- `@RestController` returns data (JSON/XML).
- `@Controller` returns views (HTML/JSP/Thymeleaf).

---

### 4. Is `@RestController` a combination of other annotations?

Yes.

```java
@RestController
=
@Controller
+
@ResponseBody
```

---

### 5. Which library converts Java objects to JSON?

**Jackson** (included by default with `spring-boot-starter-web`).

---

# Quick Revision

- `@RestController` is used to build REST APIs.
- It returns data directly in the HTTP response.
- It automatically converts Java objects to JSON.
- It combines `@Controller` and `@ResponseBody`.
- Use mapping annotations like `@GetMapping`, `@PostMapping`, `@PutMapping`, and `@DeleteMapping`.
- Keep controllers focused on handling requests and delegate business logic to the Service layer.v