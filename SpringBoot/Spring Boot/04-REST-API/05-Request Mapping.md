# @RequestMapping

## What is `@RequestMapping`?

`@RequestMapping` is a Spring annotation used to **map HTTP requests to controller methods or an entire controller class**.

It defines:

- URL (Path)
- HTTP Method
- Request Parameters
- Headers
- Content Type

> **In simple words:**
>
> `@RequestMapping` tells Spring:
> **"When this URL is requested, execute this method."**

---

# Why Do We Need `@RequestMapping`?

Suppose a client sends a request:

```
GET /employees
```

Spring needs to know:

- Which controller should handle it?
- Which method should execute?

`@RequestMapping` creates this mapping.

---

# Basic Syntax

```java
@RequestMapping("/employees")
public class EmployeeController {

}
```

or

```java
@RequestMapping("/employees")
public String getEmployees() {

}
```

---

# How `@RequestMapping` Works

```
Client

↓

HTTP Request

↓

DispatcherServlet

↓

@RequestMapping

↓

Controller Method

↓

Response
```

---

# Mapping a URL

```java
@RestController
public class EmployeeController {

    @RequestMapping("/employees")
    public String getEmployees() {

        return "All Employees";

    }

}
```

Request:

```
GET /employees
```

Response:

```
All Employees
```

---

# Class-Level Mapping

Instead of writing the same URL repeatedly:

```java
@RestController
@RequestMapping("/employees")
public class EmployeeController {

    @RequestMapping("/all")
    public String getAll() {
        return "All Employees";
    }

    @RequestMapping("/count")
    public String count() {
        return "100";
    }

}
```

Available URLs:

```
/employees/all

/employees/count
```

---

# Specifying HTTP Method

By default:

```java
@RequestMapping("/employees")
```

supports all HTTP methods.

To restrict it:

```java
@RequestMapping(
    value = "/employees",
    method = RequestMethod.GET
)
public String getEmployees() {

    return "Employees";

}
```

Now only GET requests are allowed.

---

# Supported HTTP Methods

| HTTP Method | Example |
|-------------|----------|
| GET | Retrieve Data |
| POST | Create Data |
| PUT | Update Entire Resource |
| PATCH | Partial Update |
| DELETE | Delete Data |

Example:

```java
@RequestMapping(
    value = "/employees",
    method = RequestMethod.POST
)
public String addEmployee() {

    return "Employee Added";

}
```

---

# Using Multiple HTTP Methods

```java
@RequestMapping(
    value = "/employee",
    method = {
        RequestMethod.GET,
        RequestMethod.POST
    }
)
public String employee() {

    return "Employee";

}
```

This method accepts both GET and POST requests.

---

# Mapping Based on Parameters

```java
@RequestMapping(
    value = "/search",
    params = "name"
)
public String searchEmployee() {

    return "Searching...";

}
```

Request:

```
GET /search?name=John
```

---

# Mapping Based on Headers

```java
@RequestMapping(
    value = "/employees",
    headers = "API-Version=1"
)
public String versionOne() {

    return "Version 1";

}
```

Spring executes this method only if the required header is present.

---

# Mapping Based on Content Type

Consumes:

```java
@RequestMapping(
    value = "/employees",
    consumes = "application/json"
)
public String createEmployee() {

    return "Created";

}
```

Produces:

```java
@RequestMapping(
    value = "/employees",
    produces = "application/json"
)
public Employee employee() {

    return new Employee();

}
```

---

# @RequestMapping vs Shortcut Annotations

Instead of:

```java
@RequestMapping(
    value = "/employees",
    method = RequestMethod.GET
)
```

Use:

```java
@GetMapping("/employees")
```

Similarly:

| Shortcut | Equivalent |
|-----------|------------|
| `@GetMapping` | GET |
| `@PostMapping` | POST |
| `@PutMapping` | PUT |
| `@PatchMapping` | PATCH |
| `@DeleteMapping` | DELETE |

Shortcut annotations are cleaner and preferred.

---

# Request Flow

```
Client

↓

GET /employees

↓

DispatcherServlet

↓

@RequestMapping

↓

Controller Method

↓

Response
```

---

# Real-World Example

Food Delivery Application

```
GET /restaurants

↓

RestaurantController

↓

Return Restaurant List
```

```
POST /orders

↓

OrderController

↓

Create Order
```

Each URL is mapped to a specific controller method using `@RequestMapping`.

---

# Advantages

- Maps URLs to controller methods
- Supports all HTTP methods
- Can map based on parameters and headers
- Supports content negotiation
- Reduces routing complexity

---

# Best Practices

- Use class-level `@RequestMapping` for common URLs.
- Prefer `@GetMapping`, `@PostMapping`, etc., over `@RequestMapping(method=...)`.
- Keep URLs meaningful and RESTful.
- Use nouns instead of verbs in endpoint names.

---

# Interview Questions

### 1. What is `@RequestMapping`?

`@RequestMapping` is used to map HTTP requests to controller classes or methods.

---

### 2. Where can `@RequestMapping` be used?

- At the class level
- At the method level

---

### 3. What is the default HTTP method for `@RequestMapping`?

By default, it accepts **all HTTP methods** unless a specific method is specified.

---

### 4. What is the difference between `@RequestMapping` and `@GetMapping`?

- `@RequestMapping` is generic and supports all HTTP methods.
- `@GetMapping` is a shortcut specifically for GET requests.

---

### 5. Can `@RequestMapping` map requests based on headers or parameters?

Yes. It supports mapping using:

- `params`
- `headers`
- `consumes`
- `produces`

---

# Quick Revision

- `@RequestMapping` maps HTTP requests to controller methods.
- It can be used at both the class and method levels.
- By default, it supports all HTTP methods.
- It can map requests based on URL, method, headers, parameters, and content type.
- Prefer shortcut annotations like `@GetMapping` and `@PostMapping` for cleaner code.
- It is one of the core annotations in Spring MVC and Spring Boot REST APIs.