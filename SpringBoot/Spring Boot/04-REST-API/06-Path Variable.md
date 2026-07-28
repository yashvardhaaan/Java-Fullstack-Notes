# @PathVariable

## What is `@PathVariable`?

`@PathVariable` is a Spring annotation used to **extract values from the URL path** and pass them as method parameters.

It is commonly used to identify a specific resource.

> **In simple words:**
>
> `@PathVariable` tells Spring:
> **"Take this value from the URL and pass it to my method."**

---

# Why Do We Need `@PathVariable`?

Suppose we want to fetch employee details.

Employee IDs:

```
101
102
103
```

Instead of creating different APIs:

```
/employee101

/employee102

/employee103
```

We create one API:

```
/employees/{id}
```

The value changes dynamically.

---

# Syntax

```java
@GetMapping("/employees/{id}")
public String getEmployee(@PathVariable int id) {

    return "Employee ID : " + id;

}
```

---

# How `@PathVariable` Works

```
Client

↓

GET /employees/101

↓

@PathVariable

↓

id = 101

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

    @GetMapping("/employees/{id}")
    public String getEmployee(@PathVariable int id) {

        return "Employee ID : " + id;

    }

}
```

Request:

```
GET /employees/101
```

Response:

```
Employee ID : 101
```

---

# Multiple Path Variables

```java
@GetMapping("/students/{id}/courses/{courseId}")
public String getCourse(
        @PathVariable int id,
        @PathVariable int courseId) {

    return "Student : " + id +
           ", Course : " + courseId;

}
```

Request:

```
GET /students/5/courses/101
```

Response:

```
Student : 5, Course : 101
```

---

# Custom Variable Name

If the variable name is different:

```java
@GetMapping("/employees/{employeeId}")
public String getEmployee(

        @PathVariable("employeeId")
        int id) {

    return "Employee : " + id;

}
```

Here,

```
employeeId

↓

id
```

---

# Using String Path Variable

```java
@GetMapping("/users/{username}")
public String getUser(
        @PathVariable String username) {

    return username;

}
```

Request:

```
GET /users/john
```

Response:

```
john
```

---

# Using Multiple Data Types

```java
@GetMapping("/products/{id}")
public String product(
        @PathVariable Long id) {

    return "Product : " + id;

}
```

Supported types:

- int
- long
- String
- UUID
- double
- float
- boolean

Spring automatically converts the URL value into the required Java type.

---

# Returning an Object

```java
@RestController
public class EmployeeController {

    @GetMapping("/employees/{id}")
    public Employee getEmployee(
            @PathVariable Long id) {

        return employeeService.findById(id);

    }

}
```

Request:

```
GET /employees/101
```

Response:

```json
{
    "id":101,
    "name":"John",
    "department":"IT"
}
```

---

# Request Flow

```
Client

↓

GET /employees/101

↓

DispatcherServlet

↓

@PathVariable

↓

id = 101

↓

Service Layer

↓

Database

↓

JSON Response
```

---

# @PathVariable vs @RequestParam

| `@PathVariable` | `@RequestParam` |
|-----------------|-----------------|
| Reads data from URL path | Reads data from query parameters |
| Mandatory by default | Can be optional |
| Used to identify a resource | Used for filtering/searching |

Example:

Using `@PathVariable`

```
GET /employees/101
```

Using `@RequestParam`

```
GET /employees?id=101
```

---

# Real-World Example

### Banking Application

Get account details.

```
GET /accounts/5001
```

Spring extracts:

```
5001
```

and passes it to:

```java
@PathVariable Long id
```

---

### E-Commerce Application

View product.

```
GET /products/200
```

Spring passes:

```
200
```

to the controller method.

---

# Advantages

- Creates clean RESTful URLs
- Easy to read
- Supports dynamic values
- Automatically converts data types
- Perfect for identifying resources

---

# Best Practices

- Use `@PathVariable` to uniquely identify resources.
- Keep variable names meaningful.
- Use RESTful URL naming conventions.
- Validate IDs in the service layer.
- Return `404 Not Found` if the resource does not exist.

---

# Interview Questions

### 1. What is `@PathVariable`?

`@PathVariable` is used to extract values from the URL path and bind them to method parameters.

---

### 2. When should you use `@PathVariable`?

Use it when the value is part of the resource's URL, such as an employee ID or product ID.

---

### 3. Can there be multiple `@PathVariable`s in one URL?

Yes.

Example:

```java
@GetMapping("/students/{id}/courses/{courseId}")
```

---

### 4. What is the difference between `@PathVariable` and `@RequestParam`?

- `@PathVariable` reads values from the URL path.
- `@RequestParam` reads values from query parameters.

---

### 5. Does Spring automatically convert the path variable to the required Java type?

Yes. Spring performs automatic type conversion for common Java data types.

---

# Quick Revision

- `@PathVariable` extracts values from the URL path.
- It is commonly used to identify a specific resource.
- Supports multiple path variables.
- Automatically converts URL values to Java types.
- Produces clean and RESTful URLs.
- Use `@RequestParam` for query parameters and `@PathVariable` for resource identifiers.