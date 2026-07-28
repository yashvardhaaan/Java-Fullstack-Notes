# CRUD APIs

## What is CRUD?

**CRUD** stands for the four basic operations performed on data in an application.

- **C** → Create
- **R** → Read
- **U** → Update
- **D** → Delete

Almost every web application performs these four operations.

> **In simple words:**
>
> CRUD APIs allow clients to create, retrieve, update, and delete resources.

---

# Why Do We Need CRUD APIs?

Imagine an Employee Management System.

A user should be able to:

- Add a new employee
- View employee details
- Update employee information
- Delete an employee

Instead of creating random APIs, REST follows standard HTTP methods to perform these operations.

---

# CRUD Operations

| Operation | HTTP Method | Example URL |
|-----------|-------------|-------------|
| Create | POST | `/employees` |
| Read All | GET | `/employees` |
| Read One | GET | `/employees/{id}` |
| Update | PUT | `/employees/{id}` |
| Partial Update | PATCH | `/employees/{id}` |
| Delete | DELETE | `/employees/{id}` |

---

# CRUD Flow

```
Client

↓

HTTP Request

↓

Spring Boot Controller

↓

Service Layer

↓

Repository

↓

Database

↓

HTTP Response
```

---

# 1. Create (POST)

Creates a new resource.

### Controller

```java
@PostMapping("/employees")
public ResponseEntity<Employee> createEmployee(
        @RequestBody Employee employee) {

    Employee saved = service.save(employee);

    return ResponseEntity
            .status(HttpStatus.CREATED)
            .body(saved);

}
```

### Request

```
POST /employees
```

Request Body

```json
{
    "name":"John",
    "department":"IT",
    "salary":65000
}
```

### Response

```
201 Created
```

```json
{
    "id":101,
    "name":"John",
    "department":"IT",
    "salary":65000
}
```

---

# 2. Read All (GET)

Fetches all resources.

```java
@GetMapping("/employees")
public ResponseEntity<List<Employee>> getEmployees() {

    return ResponseEntity.ok(service.findAll());

}
```

Request

```
GET /employees
```

Response

```json
[
  {
    "id":101,
    "name":"John"
  },
  {
    "id":102,
    "name":"Alice"
  }
]
```

---

# 3. Read One (GET)

Fetches a specific resource.

```java
@GetMapping("/employees/{id}")
public ResponseEntity<Employee> getEmployee(
        @PathVariable Long id) {

    Employee employee = service.findById(id);

    return ResponseEntity.ok(employee);

}
```

Request

```
GET /employees/101
```

---

# 4. Update (PUT)

Updates the complete resource.

```java
@PutMapping("/employees/{id}")
public ResponseEntity<Employee> updateEmployee(

        @PathVariable Long id,

        @RequestBody Employee employee) {

    employee.setId(id);

    return ResponseEntity.ok(service.update(employee));

}
```

Request

```
PUT /employees/101
```

Request Body

```json
{
    "name":"John",
    "department":"HR",
    "salary":70000
}
```

---

# 5. Partial Update (PATCH)

Updates only specific fields.

```java
@PatchMapping("/employees/{id}")
public ResponseEntity<Employee> updateDepartment(

        @PathVariable Long id,

        @RequestBody Employee employee) {

    return ResponseEntity.ok(service.partialUpdate(id, employee));

}
```

Request

```
PATCH /employees/101
```

Request Body

```json
{
    "department":"Finance"
}
```

---

# 6. Delete (DELETE)

Deletes a resource.

```java
@DeleteMapping("/employees/{id}")
public ResponseEntity<Void> deleteEmployee(
        @PathVariable Long id) {

    service.delete(id);

    return ResponseEntity.noContent().build();

}
```

Request

```
DELETE /employees/101
```

Response

```
204 No Content
```

---

# Complete CRUD Endpoints

| HTTP Method | URL | Operation |
|-------------|-----|-----------|
| POST | `/employees` | Create Employee |
| GET | `/employees` | Get All Employees |
| GET | `/employees/{id}` | Get Employee by ID |
| PUT | `/employees/{id}` | Update Employee |
| PATCH | `/employees/{id}` | Partial Update |
| DELETE | `/employees/{id}` | Delete Employee |

---

# Common HTTP Status Codes

| Operation | Status Code |
|-----------|-------------|
| Create | **201 Created** |
| Read | **200 OK** |
| Update | **200 OK** |
| Delete | **204 No Content** |
| Invalid Request | **400 Bad Request** |
| Not Found | **404 Not Found** |

---

# Request Flow Example

```
POST /employees

↓

EmployeeController

↓

EmployeeService

↓

EmployeeRepository

↓

Database

↓

201 Created
```

---

# Real-World Example

### Banking Application

```
POST   /accounts
```

Create a new account.

```
GET    /accounts/1001
```

View account details.

```
PUT    /accounts/1001
```

Update account information.

```
DELETE /accounts/1001
```

Close an account.

---

### E-Commerce Application

```
POST   /products
```

Add a new product.

```
GET    /products
```

View all products.

```
PATCH /products/10
```

Update only the product price.

```
DELETE /products/10
```

Remove a product.

---

# Best Practices

- Use proper HTTP methods for each operation.
- Return meaningful HTTP status codes.
- Validate request data using `@Valid`.
- Return `404 Not Found` if a resource doesn't exist.
- Use `ResponseEntity` for better control over responses.
- Keep business logic in the Service layer.

---

# Interview Questions

### 1. What is CRUD?

CRUD stands for **Create, Read, Update, and Delete**, the four basic operations performed on data.

---

### 2. Which HTTP methods are used for CRUD?

| CRUD | HTTP Method |
|------|-------------|
| Create | POST |
| Read | GET |
| Update | PUT / PATCH |
| Delete | DELETE |

---

### 3. What is the difference between PUT and PATCH?

- **PUT** updates the entire resource.
- **PATCH** updates only specific fields.

---

### 4. Which status code is returned after creating a resource?

```
201 Created
```

---

### 5. Which status code is commonly returned after deleting a resource?

```
204 No Content
```

---

# Quick Revision

- CRUD = **Create, Read, Update, Delete**.
- POST → Create
- GET → Read
- PUT → Update entire resource
- PATCH → Update specific fields
- DELETE → Delete resource
- Use RESTful URLs like `/employees/{id}`.
- Return proper HTTP status codes such as **200**, **201**, **204**, and **404**.
- Keep controllers thin and move business logic to the Service layer.