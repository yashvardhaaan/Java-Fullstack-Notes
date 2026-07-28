# DTO (Data Transfer Object)

## What is a DTO?

A **DTO (Data Transfer Object)** is a simple Java object used to **transfer data between different layers** of an application.

A DTO contains **only the required data** and does **not contain business logic**.

It is mainly used between:

- Controller ↔ Service
- Service ↔ Client

> **In simple words:**
>
> A DTO is a lightweight object that carries only the data needed for a specific operation.

---

# Why Do We Need DTOs?

Suppose we have a User entity.

```java
@Entity
public class User {

    private Long id;

    private String name;

    private String email;

    private String password;

    private String address;

    private String phone;

}
```

If we directly return this entity,

```
Client

↓

Gets Password

Gets Address

Gets Phone

Gets Everything
```

Problems

- Sensitive data exposed
- Large response size
- Tight coupling
- Security risks

---

Using DTO

```
Client

↓

Gets

Name

Email
```

Only required information is returned.

---

# Real-World Example

Imagine applying for a passport.

Government database stores

- Name
- Address
- Aadhaar Number
- Passport Number
- Family Details

But the passport only displays

- Name
- DOB
- Passport Number
- Nationality

It does **not** show every stored detail.

DTO works the same way.

---

# Application Flow

```
Client

↓

Controller

↓

DTO

↓

Service

↓

Entity

↓

Repository

↓

Database
```

---

# Entity vs DTO

## Entity

Represents a database table.

```java
@Entity
public class User {

}
```

---

## DTO

Represents only the data exchanged with clients.

```java
public class UserDTO {

}
```

---

# Example Entity

```java
@Entity
public class User {

    @Id
    private Long id;

    private String name;

    private String email;

    private String password;

}
```

---

# Example DTO

```java
public class UserDTO {

    private String name;

    private String email;

}
```

Notice

```
Password

×

Not Included
```

---

# Request DTO

Used when the client sends data.

Example

```java
public class CreateUserRequest {

    private String name;

    private String email;

    private String password;

}
```

Flow

```
Client

↓

Request DTO

↓

Service
```

---

# Response DTO

Used when returning data.

```java
public class UserResponse {

    private Long id;

    private String name;

    private String email;

}
```

Flow

```
Service

↓

Response DTO

↓

Client
```

---

# Controller Example

```java
@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService service;

    public UserController(UserService service) {
        this.service = service;
    }

    @PostMapping
    public UserResponse createUser(

            @RequestBody CreateUserRequest request

    ) {

        return service.createUser(request);

    }

}
```

---

# Service Example

```java
@Service
public class UserService {

    public UserResponse createUser(

            CreateUserRequest request

    ) {

        User user = new User();

        user.setName(request.getName());

        user.setEmail(request.getEmail());

        user.setPassword(request.getPassword());

        return new UserResponse(

                user.getId(),

                user.getName(),

                user.getEmail()

        );

    }

}
```

---

# DTO Mapping

```
Request DTO

↓

Entity

↓

Database

↓

Entity

↓

Response DTO

↓

Client
```

---

# Manual Mapping

```java
UserResponse response =

        new UserResponse(

                user.getId(),

                user.getName(),

                user.getEmail()

        );
```

---

# Using Java Record

Java 16+ supports Records for DTOs.

```java
public record UserResponse(

        Long id,

        String name,

        String email

) {
}
```

Benefits

- Less boilerplate
- Immutable
- Cleaner code

---

# DTO with Validation

```java
public class CreateUserRequest {

    @NotBlank
    private String name;

    @Email
    private String email;

    @Size(min = 8)
    private String password;

}
```

Controller

```java
@PostMapping
public UserResponse create(

        @Valid

        @RequestBody CreateUserRequest request

){

    return service.createUser(request);

}
```

---

# Mapping Tools

Instead of mapping manually,

popular libraries include:

- MapStruct
- ModelMapper

Flow

```
DTO

↓

Mapper

↓

Entity
```

---

# Why Not Return Entities?

Returning entities directly may:

- Expose passwords
- Expose internal IDs
- Trigger Lazy Loading
- Cause infinite JSON recursion
- Couple API with database structure

---

# DTO Flow

```
Client

↓

Request DTO

↓

Controller

↓

Service

↓

Entity

↓

Repository

↓

Database

↓

Entity

↓

Response DTO

↓

Client
```

---

# DTO vs Entity

| DTO | Entity |
|------|--------|
| Transfers data | Represents database table |
| No business logic | Managed by JPA |
| Used in APIs | Used for persistence |
| Can contain selected fields | Usually contains all fields |

---

# Request DTO vs Response DTO

| Request DTO | Response DTO |
|-------------|--------------|
| Receives client data | Sends data to client |
| Used in POST/PUT | Used in GET/POST responses |
| May include password | Usually excludes sensitive data |

---

# Common Use Cases

- User Registration
- Login APIs
- Product Details
- Order APIs
- Payment APIs
- Employee Management

---

# Common Mistakes

❌ Returning JPA entities directly from Controllers.

❌ Including sensitive fields like passwords in responses.

❌ Using the same DTO for every API.

❌ Putting business logic inside DTO classes.

❌ Skipping validation on request DTOs.

---

# Real-World Example

## Banking Application

```
Database

↓

Account Entity

↓

AccountResponse DTO

↓

Customer
```

Balance and account number may be returned, but internal audit fields remain hidden.

---

## E-Commerce Website

```
Product Entity

↓

ProductResponse DTO

↓

Client
```

Only product details required by the UI are returned.

---

## Food Delivery App

```
Restaurant Entity

↓

RestaurantResponse DTO

↓

Mobile App
```

Only necessary restaurant information is sent.

---

# Advantages

- Improves security.
- Hides sensitive information.
- Reduces response size.
- Decouples API from database.
- Easier API versioning.
- Better maintainability.

---

# Best Practices

- Create separate Request and Response DTOs.
- Never expose passwords or sensitive fields.
- Use validation annotations on Request DTOs.
- Prefer Java Records for immutable DTOs when appropriate.
- Use MapStruct for large projects with many mappings.
- Keep DTOs simple and free of business logic.

---

# Interview Questions

### 1. What is a DTO?

A DTO (Data Transfer Object) is an object used to transfer data between application layers without exposing internal entities.

---

### 2. Why should we use DTOs?

DTOs improve security, reduce payload size, and decouple the API from the database model.

---

### 3. What is the difference between an Entity and a DTO?

An Entity represents database data managed by JPA, while a DTO is used only for transferring data between layers or to clients.

---

### 4. Why shouldn't we return entities directly from REST APIs?

Because entities may expose sensitive information, trigger lazy loading, and tightly couple the API to the database schema.

---

### 5. What is the difference between Request DTO and Response DTO?

A Request DTO receives input from the client, while a Response DTO sends only the required data back to the client.

---

### 6. Which libraries are commonly used for DTO mapping?

- MapStruct
- ModelMapper

---

### 7. Can Java Records be used as DTOs?

Yes. Java Records are an excellent choice for immutable DTOs because they are concise and automatically generate constructors, getters, `equals()`, `hashCode()`, and `toString()`.

---

# Quick Revision

- DTO stands for Data Transfer Object.
- DTOs transfer data between application layers.
- Use Request DTOs for incoming data and Response DTOs for outgoing data.
- Never expose JPA entities directly in REST APIs.
- DTOs improve security, performance, and maintainability.
- Use validation annotations with Request DTOs.
- Prefer Java Records or mapping libraries like MapStruct for cleaner code.