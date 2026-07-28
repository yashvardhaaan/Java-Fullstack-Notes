# REST API Best Practices

## What are REST API Best Practices?

REST API Best Practices are a set of guidelines that help us design APIs that are:

- Easy to understand
- Consistent
- Scalable
- Secure
- Easy to maintain

> **In simple words:**
>
> Best practices make your APIs clean, predictable, and developer-friendly.

---

# Why Do We Need Best Practices?

Imagine two APIs:

❌ Poor API

```
GET /getEmployeeData

POST /createNewEmployee

DELETE /deleteEmployeeById
```

✅ Good API

```
GET /employees

POST /employees

DELETE /employees/{id}
```

The second API is simpler, follows REST conventions, and is easier to understand.

---

# 1. Use Nouns Instead of Verbs

Resources should be represented as **nouns**, not actions.

❌ Bad

```
GET /getEmployees

POST /createEmployee

DELETE /deleteEmployee
```

✅ Good

```
GET /employees

POST /employees

DELETE /employees/{id}
```

---

# 2. Use Proper HTTP Methods

| Operation | HTTP Method |
|-----------|-------------|
| Create | POST |
| Read | GET |
| Update | PUT / PATCH |
| Delete | DELETE |

Example

```
POST   /employees

GET    /employees

PUT    /employees/101

DELETE /employees/101
```

---

# 3. Use Meaningful Resource Names

Choose resource names that clearly represent the data.

✅ Good

```
/employees

/products

/orders

/customers
```

❌ Bad

```
/emp

/p

/data

/info
```

---

# 4. Use Proper HTTP Status Codes

Return meaningful status codes.

| Status Code | Meaning |
|-------------|---------|
| 200 | Success |
| 201 | Resource Created |
| 204 | No Content |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |

Example

```java
return ResponseEntity.ok(employee);
```

---

# 5. Use JSON for Request and Response

JSON is lightweight and easy to read.

Example

```json
{
    "id":101,
    "name":"John",
    "department":"IT"
}
```

Avoid custom formats unless required.

---

# 6. Use Proper URL Structure

Good URL hierarchy:

```
/customers

/customers/10

/customers/10/orders

/orders/100
```

Avoid deeply nested URLs like:

```
/company/department/team/employee/address/details
```

---

# 7. Version Your APIs

As APIs evolve, maintain backward compatibility.

Example

```
/api/v1/employees

/api/v2/employees
```

This allows old clients to continue working while new clients use updated APIs.

---

# 8. Validate Input Data

Always validate user input.

Example

```java
@PostMapping("/employees")
public ResponseEntity<Employee> createEmployee(

        @Valid
        @RequestBody Employee employee) {

    return ResponseEntity.ok(employee);

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

---

# 9. Handle Exceptions Globally

Instead of handling exceptions in every controller, use:

```java
@ControllerAdvice
```

Example

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

}
```

Benefits:

- Consistent error responses
- Less duplicate code
- Cleaner controllers

---

# 10. Return Consistent Error Responses

Instead of returning plain text:

```
Invalid Input
```

Return structured JSON.

```json
{
    "timestamp":"2026-07-28T10:30:00",
    "status":400,
    "error":"Bad Request",
    "message":"Name is required",
    "path":"/employees"
}
```

---

# 11. Use Pagination for Large Data

Avoid returning thousands of records at once.

❌ Bad

```
GET /employees
```

Returns 1,00,000 employees.

✅ Better

```
GET /employees?page=0&size=10
```

---

# 12. Filter Using Query Parameters

Use query parameters for searching and filtering.

Example

```
GET /employees?department=IT

GET /products?category=Laptop

GET /movies?language=English
```

---

# 13. Keep Controllers Thin

Controller

```java
@PostMapping
public ResponseEntity<Employee> save(
        @RequestBody Employee employee) {

    return ResponseEntity.ok(
            employeeService.save(employee));

}
```

Business logic should be inside the Service layer, not in the Controller.

---

# 14. Secure Your APIs

Use authentication and authorization.

Common approaches:

- Spring Security
- JWT Authentication
- OAuth2

Never expose sensitive data or unsecured endpoints.

---

# 15. Document Your APIs

Use tools like:

- Swagger / OpenAPI
- SpringDoc OpenAPI

Documentation helps frontend developers and third-party consumers understand your APIs.

---

# Request Flow Following Best Practices

```
Client

↓

HTTP Request

↓

Controller

↓

Validation

↓

Service

↓

Repository

↓

Database

↓

ResponseEntity

↓

JSON Response
```

---

# Real-World Example

### Banking API

```
POST   /accounts

GET    /accounts/1001

PUT    /accounts/1001

DELETE /accounts/1001
```

Responses:

```
201 Created

200 OK

404 Not Found

400 Bad Request
```

---

### E-Commerce API

```
GET /products?page=0&size=20

GET /products?category=Mobile

POST /orders

DELETE /orders/10
```

---

# Summary of REST API Best Practices

| Best Practice | Recommendation |
|---------------|----------------|
| Resource Naming | Use nouns |
| HTTP Methods | Use GET, POST, PUT, PATCH, DELETE correctly |
| Status Codes | Return appropriate HTTP status codes |
| Response Format | Use JSON |
| Validation | Validate input using `@Valid` |
| Error Handling | Use `@ControllerAdvice` |
| Pagination | Use `page` and `size` |
| Filtering | Use query parameters |
| Security | Use Spring Security/JWT |
| Documentation | Use Swagger/OpenAPI |

---

# Interview Questions

### 1. Why should REST APIs use nouns instead of verbs?

Resources represent objects (employees, products, orders). HTTP methods already describe the action to perform on those resources.

---

### 2. Why is `ResponseEntity` recommended?

It gives full control over the response body, HTTP status code, and headers.

---

### 3. Why should APIs return proper HTTP status codes?

They help clients understand whether the request succeeded or failed and why.

---

### 4. Why should controllers be thin?

Controllers should only handle HTTP requests and responses. Business logic belongs in the Service layer, making the application easier to maintain and test.

---

### 5. Why is pagination important?

Pagination improves performance by avoiding the transfer of very large datasets in a single response.

---

# Quick Revision

- Use **nouns** for resource names.
- Use the correct HTTP methods.
- Return meaningful HTTP status codes.
- Use JSON for request and response bodies.
- Validate request data using `@Valid`.
- Handle exceptions with `@ControllerAdvice`.
- Use pagination and query parameters for large datasets.
- Keep controllers thin and business logic in the Service layer.
- Secure APIs using Spring Security and JWT.
- Document APIs with Swagger/OpenAPI.