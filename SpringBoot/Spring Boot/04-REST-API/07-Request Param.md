# @RequestParam

## What is `@RequestParam`?

`@RequestParam` is a Spring annotation used to **extract values from the query parameters** of an HTTP request and bind them to method parameters.

Query parameters appear **after the `?`** in the URL.

> **In simple words:**
>
> `@RequestParam` tells Spring:
> **"Take this value from the URL's query string and pass it to my method."**

---

# Why Do We Need `@RequestParam`?

Suppose we want to search employees by department.

Instead of creating multiple URLs:

```
/employees/IT

/employees/HR

/employees/Sales
```

We can use one API:

```
/employees?department=IT
```

The query parameter changes dynamically.

---

# Syntax

```java
@GetMapping("/employees")
public String getEmployees(
        @RequestParam String department) {

    return department;

}
```

---

# How `@RequestParam` Works

```
Client

↓

GET /employees?department=IT

↓

@RequestParam

↓

department = IT

↓

Controller Method

↓

Response
```

---

# Basic Example

```java
@RestController
public class EmployeeController {

    @GetMapping("/employees")
    public String getEmployees(
            @RequestParam String department) {

        return "Department : " + department;

    }

}
```

Request:

```
GET /employees?department=IT
```

Response:

```
Department : IT
```

---

# Multiple Request Parameters

```java
@GetMapping("/employees")
public String getEmployees(

        @RequestParam String department,
        @RequestParam String city) {

    return department + " " + city;

}
```

Request:

```
GET /employees?department=IT&city=Pune
```

Response:

```
IT Pune
```

---

# Custom Parameter Name

```java
@GetMapping("/employees")
public String getEmployee(

        @RequestParam("dept")
        String department) {

    return department;

}
```

Request:

```
GET /employees?dept=IT
```

Spring maps:

```
dept

↓

department
```

---

# Optional Request Parameter

By default, `@RequestParam` is **required**.

```java
@GetMapping("/employees")
public String getEmployees(

        @RequestParam(required = false)
        String department) {

    return department;

}
```

Now this request is valid:

```
GET /employees
```

---

# Default Value

```java
@GetMapping("/employees")
public String getEmployees(

        @RequestParam(
            defaultValue = "IT")
        String department) {

    return department;

}
```

Request:

```
GET /employees
```

Response:

```
IT
```

---

# Multiple Data Types

```java
@GetMapping("/products")
public String product(

        @RequestParam Long id,
        @RequestParam double price,
        @RequestParam boolean available) {

    return "Product";

}
```

Spring automatically converts query parameters into Java data types.

---

# Using `@RequestParam` with Collections

```java
@GetMapping("/students")
public List<String> getStudents(

        @RequestParam List<String> names) {

    return names;

}
```

Request:

```
GET /students?names=John,Alice,Bob
```

Response:

```
[John, Alice, Bob]
```

---

# Request Flow

```
Client

↓

GET /employees?department=IT

↓

DispatcherServlet

↓

@RequestParam

↓

department = IT

↓

Controller Method

↓

JSON Response
```

---

# @RequestParam vs @PathVariable

| `@RequestParam` | `@PathVariable` |
|-----------------|-----------------|
| Reads query parameters | Reads URL path values |
| Can be optional | Usually required |
| Used for filtering/searching | Used to identify a resource |

Example:

Using `@RequestParam`

```
GET /employees?department=IT
```

Using `@PathVariable`

```
GET /employees/101
```

---

# Real-World Example

### E-Commerce Application

Search products by category.

```
GET /products?category=Mobile
```

Spring extracts:

```
Mobile
```

and passes it to:

```java
@RequestParam String category
```

---

### Movie Application

Filter movies.

```
GET /movies?language=English&year=2025
```

Spring maps:

```
language = English

year = 2025
```

---

# Advantages

- Ideal for filtering and searching
- Supports optional parameters
- Supports default values
- Automatically converts data types
- Makes APIs flexible

---

# Best Practices

- Use `@RequestParam` for filtering, sorting, pagination, and searching.
- Use meaningful parameter names.
- Provide default values where appropriate.
- Use `required = false` for optional parameters.
- Validate user input before processing.

---

# Interview Questions

### 1. What is `@RequestParam`?

`@RequestParam` is used to extract query parameters from an HTTP request and bind them to method parameters.

---

### 2. Is `@RequestParam` required by default?

Yes. By default, it is required unless `required = false` is specified.

---

### 3. How do you make a request parameter optional?

```java
@RequestParam(required = false)
String department
```

---

### 4. How do you provide a default value?

```java
@RequestParam(defaultValue = "IT")
String department
```

---

### 5. What is the difference between `@RequestParam` and `@PathVariable`?

- `@RequestParam` is used for query parameters like filtering and searching.
- `@PathVariable` is used for resource identifiers in the URL path.

---

# Quick Revision

- `@RequestParam` extracts values from query parameters.
- Query parameters come after the `?` in the URL.
- It is required by default.
- Supports optional parameters and default values.
- Automatically converts values to Java data types.
- Best used for filtering, searching, sorting, and pagination.