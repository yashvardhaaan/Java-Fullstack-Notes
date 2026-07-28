# Controller Layer

## What is the Controller Layer?

The **Controller Layer** is the **entry point** of a Spring Boot application.

It receives HTTP requests from the client, processes the request, calls the appropriate Service, and returns the response.

The Controller **does not contain business logic**.

> **In simple words:**
>
> The Controller acts like a receptionist. It accepts requests, forwards them to the right department (Service Layer), and returns the result to the client.

---

# Why Do We Need the Controller Layer?

Imagine a client wants to fetch user details.

Without a Controller

```
Client

↓

Database
```

Problems

- No validation
- No routing
- No API structure
- Tight coupling

---

With a Controller

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database
```

The application becomes organized and easier to maintain.

---

# Real-World Example

Imagine a restaurant.

```
Customer

↓

Waiter

↓

Chef

↓

Food
```

The waiter doesn't cook the food.

Similarly,

```
Client

↓

Controller

↓

Service

↓

Database
```

The Controller doesn't perform business logic.

---

# Responsibilities of Controller

- Accept HTTP requests
- Read request parameters
- Read request body
- Validate input
- Call Service Layer
- Return HTTP response
- Return proper status codes

---

# Controller Flow

```
Client

↓

HTTP Request

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Response

↓

Client
```

---

# @RestController

`@RestController` tells Spring Boot that the class will handle REST API requests.

```java
@RestController
public class UserController {

}
```

It is equivalent to

```java
@Controller
@ResponseBody
```

---

# @RequestMapping

Defines the base URL for all APIs inside the controller.

```java
@RestController
@RequestMapping("/users")
public class UserController {

}
```

All endpoints start with

```
/users
```

---

# Dependency Injection

Controllers usually inject the Service Layer.

```java
@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService service;

    public UserController(UserService service) {
        this.service = service;
    }

}
```

---

# GET API

Retrieve data.

```java
@GetMapping("/{id}")
public User getUser(

        @PathVariable Long id

){

    return service.getUser(id);

}
```

Request

```
GET /users/1
```

Flow

```
Client

↓

Controller

↓

Service

↓

Response
```

---

# POST API

Create new data.

```java
@PostMapping
public User createUser(

        @RequestBody User user

){

    return service.save(user);

}
```

Request

```
POST /users
```

---

# PUT API

Update existing data.

```java
@PutMapping("/{id}")
public User updateUser(

        @PathVariable Long id,

        @RequestBody User user

){

    return service.update(id, user);

}
```

---

# DELETE API

Delete data.

```java
@DeleteMapping("/{id}")
public void deleteUser(

        @PathVariable Long id

){

    service.delete(id);

}
```

---

# Reading Request Body

JSON Request

```json
{
  "name": "John",
  "email": "john@gmail.com"
}
```

Controller

```java
@PostMapping
public User save(

        @RequestBody User user

){

    return service.save(user);

}
```

`@RequestBody` converts JSON into a Java object.

---

# Reading Path Variables

URL

```
GET /users/10
```

Controller

```java
@GetMapping("/{id}")
public User get(

        @PathVariable Long id

){

    return service.getUser(id);

}
```

---

# Reading Query Parameters

Request

```
GET /users?page=1&size=10
```

Controller

```java
@GetMapping
public List<User> getUsers(

        @RequestParam int page,

        @RequestParam int size

){

    return service.getUsers(page, size);

}
```

---

# Returning ResponseEntity

`ResponseEntity` gives full control over the HTTP response.

```java
@GetMapping("/{id}")
public ResponseEntity<User> getUser(

        @PathVariable Long id

){

    return ResponseEntity.ok(

            service.getUser(id)

    );

}
```

---

# HTTP Status Codes

| Status Code | Meaning |
|-------------|---------|
| 200 | OK |
| 201 | Created |
| 204 | No Content |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |

---

# Controller Architecture

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

# Validation in Controller

```java
@PostMapping
public User save(

        @Valid

        @RequestBody UserRequest request

){

    return service.save(request);

}
```

`@Valid` triggers validation before calling the Service Layer.

---

# Exception Handling

Controllers should not handle exceptions manually.

Instead, use a global exception handler.

```
Controller

↓

Throws Exception

↓

Global Exception Handler

↓

HTTP Response
```

---

# Thin Controller Principle

Good Controller

```
Receive Request

↓

Validate

↓

Call Service

↓

Return Response
```

Bad Controller

```
Receive Request

↓

Business Logic

↓

Database Query

↓

Validation

↓

Calculations

↓

Response
```

Controllers should remain small and focused.

---

# Controller vs Service

| Controller | Service |
|------------|----------|
| Handles HTTP requests | Contains business logic |
| Reads request data | Processes business rules |
| Returns responses | Coordinates repositories |
| No database access | Uses Repository Layer |

---

# Common Use Cases

- Login API
- User Registration
- Product Search
- Order Creation
- Payment APIs
- Employee Management

---

# Common Mistakes

❌ Writing business logic inside the Controller.

❌ Accessing the Repository directly.

❌ Returning entities without considering DTOs.

❌ Not validating request data.

❌ Catching every exception inside the Controller.

---

# Real-World Example

## Banking Application

```
Transfer Request

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Response
```

---

## E-Commerce Website

```
Place Order

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

## Food Delivery App

```
Order Food

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

# Advantages

- Clear separation of concerns.
- Easy API management.
- Better maintainability.
- Easier testing.
- Standardized request handling.
- Cleaner application architecture.

---

# Best Practices

- Keep Controllers thin.
- Move business logic to the Service Layer.
- Use constructor injection.
- Validate incoming requests with `@Valid`.
- Return `ResponseEntity` when custom status codes or headers are needed.
- Use DTOs instead of exposing entities directly.
- Handle exceptions using `@ControllerAdvice`.

---

# Interview Questions

### 1. What is the Controller Layer?

The Controller Layer handles HTTP requests, delegates work to the Service Layer, and returns HTTP responses.

---

### 2. What is the difference between `@Controller` and `@RestController`?

- `@Controller` is used for MVC applications that return views.
- `@RestController` is used for REST APIs and returns JSON/XML responses by default.

---

### 3. Can business logic be written inside a Controller?

No. Business logic should be placed in the Service Layer to keep Controllers clean and maintainable.

---

### 4. What is `@RequestBody`?

`@RequestBody` converts the incoming HTTP request body (usually JSON) into a Java object.

---

### 5. What is `ResponseEntity`?

`ResponseEntity` allows you to customize the HTTP response, including the body, status code, and headers.

---

### 6. Why is constructor injection preferred in Controllers?

Constructor injection makes dependencies immutable, improves testability, and is recommended by Spring.

---

### 7. What is the role of `@RequestMapping`?

`@RequestMapping` defines the base URL path for the Controller or maps requests to handler methods.

---

# Quick Revision

- The Controller Layer is the entry point for REST APIs.
- It handles HTTP requests and returns HTTP responses.
- Controllers delegate business logic to the Service Layer.
- Use `@RestController` for REST APIs.
- Use `@RequestBody`, `@PathVariable`, and `@RequestParam` to read request data.
- Use `ResponseEntity` for flexible HTTP responses.
- Keep Controllers thin and focused on request handling.