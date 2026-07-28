# @RequestBody

## What is `@RequestBody`?

`@RequestBody` is a Spring annotation used to **read the HTTP request body** and automatically convert it into a Java object.

It is mainly used with:

- POST
- PUT
- PATCH

requests where the client sends data in **JSON** format.

> **In simple words:**
>
> `@RequestBody` tells Spring:
> **"Take the JSON sent by the client and convert it into a Java object."**

---

# Why Do We Need `@RequestBody`?

Suppose a client wants to create a new employee.

The client sends:

```json
{
    "name": "John",
    "department": "IT",
    "salary": 65000
}
```

Instead of reading every field manually, Spring converts the JSON directly into an `Employee` object.

---

# Syntax

```java
@PostMapping("/employees")
public String createEmployee(
        @RequestBody Employee employee) {

    return "Employee Created";

}
```

---

# How `@RequestBody` Works

```
Client

↓

POST Request

↓

JSON Body

↓

@RequestBody

↓

Java Object

↓

Controller Method

↓

Response
```

---

# Basic Example

## Employee Class

```java
public class Employee {

    private String name;
    private String department;
    private double salary;

    // Getters and Setters

}
```

---

## Controller

```java
@RestController
public class EmployeeController {

    @PostMapping("/employees")
    public Employee createEmployee(
            @RequestBody Employee employee) {

        return employee;

    }

}
```

---

## Request

```
POST /employees
```

Request Body

```json
{
    "name": "John",
    "department": "IT",
    "salary": 65000
}
```

---

## Response

```json
{
    "name": "John",
    "department": "IT",
    "salary": 65000
}
```

---

# JSON to Java Object Conversion

```
JSON

↓

{
   "name":"John",
   "department":"IT"
}

↓

Jackson

↓

Employee Object

↓

Controller Method
```

Spring Boot uses the **Jackson** library to perform this conversion automatically.

---

# Using `@RequestBody` with POST

```java
@PostMapping("/students")
public Student addStudent(
        @RequestBody Student student) {

    return student;

}
```

Client sends JSON.

Spring converts it into a `Student` object.

---

# Using `@RequestBody` with PUT

```java
@PutMapping("/employees/{id}")
public Employee updateEmployee(

        @PathVariable Long id,

        @RequestBody Employee employee) {

    return employee;

}
```

The client sends updated employee details in the request body.

---

# Using `@RequestBody` with PATCH

```java
@PatchMapping("/employees/{id}")
public Employee updateSalary(

        @PathVariable Long id,

        @RequestBody Employee employee) {

    return employee;

}
```

PATCH is commonly used for **partial updates**.

---

# Combining `@PathVariable` and `@RequestBody`

```java
@PutMapping("/employees/{id}")
public Employee updateEmployee(

        @PathVariable Long id,

        @RequestBody Employee employee) {

    employee.setId(id);

    return employee;

}
```

Request:

```
PUT /employees/101
```

Request Body

```json
{
    "name":"John",
    "department":"HR"
}
```

---

# Validation with `@Valid`

```java
@PostMapping("/employees")
public Employee createEmployee(

        @Valid
        @RequestBody Employee employee) {

    return employee;

}
```

Entity

```java
public class Employee {

    @NotBlank
    private String name;

    @Email
    private String email;

}
```

Spring validates the request before executing the method.

---

# Request Flow

```
Client

↓

POST Request

↓

JSON Body

↓

DispatcherServlet

↓

@RequestBody

↓

Jackson

↓

Java Object

↓

Controller

↓

Response
```

---

# `@RequestBody` vs `@RequestParam`

| `@RequestBody` | `@RequestParam` |
|----------------|-----------------|
| Reads JSON from request body | Reads query parameters |
| Used for complex objects | Used for simple values |
| Mostly used with POST/PUT/PATCH | Mostly used with GET |

Example:

Using `@RequestBody`

```
POST /employees
```

```json
{
    "name":"John"
}
```

Using `@RequestParam`

```
GET /employees?department=IT
```

---

# `@RequestBody` vs `@PathVariable`

| `@RequestBody` | `@PathVariable` |
|----------------|-----------------|
| Reads data from request body | Reads data from URL |
| Used for object data | Used for resource identifiers |

---

# Real-World Example

### Banking Application

Transfer money.

```
POST /transactions
```

Request Body

```json
{
    "fromAccount": 1001,
    "toAccount": 2001,
    "amount": 5000
}
```

Spring converts the JSON into a `Transaction` object.

---

### E-Commerce Application

Create a product.

```
POST /products
```

Request Body

```json
{
    "name":"Laptop",
    "price":75000,
    "stock":20
}
```

Spring automatically creates a `Product` object.

---

# Advantages

- Automatically converts JSON into Java objects.
- Reduces manual parsing.
- Works seamlessly with Jackson.
- Supports validation using `@Valid`.
- Makes REST APIs clean and readable.

---

# Best Practices

- Use `@RequestBody` for POST, PUT, and PATCH requests.
- Validate input using `@Valid`.
- Keep DTOs separate from Entity classes.
- Return meaningful error messages for invalid input.
- Handle validation exceptions using `@ControllerAdvice`.

---

# Interview Questions

### 1. What is `@RequestBody`?

`@RequestBody` is used to read the HTTP request body and convert JSON into a Java object.

---

### 2. Which library converts JSON to Java objects?

**Jackson**.

---

### 3. Which HTTP methods commonly use `@RequestBody`?

- POST
- PUT
- PATCH

---

### 4. Can `@RequestBody` be used with `@Valid`?

Yes.

```java
public Employee create(
        @Valid @RequestBody Employee employee)
```

---

### 5. What is the difference between `@RequestBody` and `@RequestParam`?

- `@RequestBody` reads JSON from the request body.
- `@RequestParam` reads values from query parameters.

---

# Quick Revision

- `@RequestBody` reads the HTTP request body.
- It converts JSON into Java objects automatically.
- Spring Boot uses Jackson for conversion.
- Commonly used with POST, PUT, and PATCH requests.
- Works well with `@Valid` for input validation.
- Ideal for sending complex objects in REST APIs.