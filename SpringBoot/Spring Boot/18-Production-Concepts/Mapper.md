# Mapper

## What is a Mapper?

A **Mapper** is a component that converts one object into another.

In Spring Boot, a Mapper is commonly used to convert:

- DTO → Entity
- Entity → DTO

It separates conversion logic from business logic, making the code cleaner and easier to maintain.

> **In simple words:**
>
> A Mapper is a translator between different Java objects.

---

# Why Do We Need a Mapper?

Suppose a client sends a request.

```
Client

↓

UserRequest DTO

↓

Database Entity
```

The DTO and Entity have different purposes.

Without a Mapper

```
Service

↓

Copy Field 1

↓

Copy Field 2

↓

Copy Field 3

↓

Copy Field 4

↓

Save Entity
```

Problems

- Repeated code
- Hard to maintain
- Error-prone
- Violates Single Responsibility Principle

---

With a Mapper

```
Service

↓

Mapper

↓

Entity
```

The Service focuses only on business logic.

---

# Real-World Example

Imagine a translator.

```
Person A

↓

Translator

↓

Person B
```

The translator converts one language into another.

Similarly,

```
DTO

↓

Mapper

↓

Entity
```

---

# Application Flow

```
Client

↓

Request DTO

↓

Controller

↓

Service

↓

Mapper

↓

Entity

↓

Repository

↓

Database

↓

Entity

↓

Mapper

↓

Response DTO

↓

Client
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

# Example Request DTO

```java
public class UserRequest {

    private String name;

    private String email;

    private String password;

}
```

---

# Example Response DTO

```java
public class UserResponse {

    private Long id;

    private String name;

    private String email;

}
```

---

# Manual Mapping

Without Mapper

```java
User user = new User();

user.setName(request.getName());

user.setEmail(request.getEmail());

user.setPassword(request.getPassword());
```

Returning response

```java
UserResponse response =

        new UserResponse(

                user.getId(),

                user.getName(),

                user.getEmail()

        );
```

This code becomes repetitive across many services.

---

# Creating a Mapper

```java
@Component
public class UserMapper {

    public User toEntity(

            UserRequest request

    ) {

        User user = new User();

        user.setName(request.getName());

        user.setEmail(request.getEmail());

        user.setPassword(request.getPassword());

        return user;

    }

    public UserResponse toResponse(

            User user

    ) {

        return new UserResponse(

                user.getId(),

                user.getName(),

                user.getEmail()

        );

    }

}
```

---

# Using Mapper in Service

```java
@Service
public class UserService {

    private final UserMapper mapper;

    private final UserRepository repository;

    public UserService(

            UserMapper mapper,

            UserRepository repository

    ) {

        this.mapper = mapper;
        this.repository = repository;

    }

    public UserResponse create(

            UserRequest request

    ) {

        User user = mapper.toEntity(request);

        repository.save(user);

        return mapper.toResponse(user);

    }

}
```

---

# Mapping Flow

```
Request DTO

↓

Mapper

↓

Entity

↓

Database

↓

Entity

↓

Mapper

↓

Response DTO
```

---

# Manual Mapper vs MapStruct

## Manual Mapper

```
Developer

↓

Writes Mapping Code
```

Advantages

- Full control
- Easy for small projects

Disadvantages

- More boilerplate
- Repeated code

---

## MapStruct

```
Interface

↓

Generated Mapper

↓

Object Conversion
```

MapStruct generates mapping code at compile time.

---

# MapStruct Example

Mapper Interface

```java
@Mapper(componentModel = "spring")
public interface UserMapper {

    User toEntity(UserRequest request);

    UserResponse toResponse(User user);

}
```

Spring automatically injects the generated implementation.

---

# ModelMapper Example

```java
ModelMapper mapper = new ModelMapper();

UserResponse response =

        mapper.map(

                user,

                UserResponse.class

        );
```

Unlike MapStruct, ModelMapper performs mapping at runtime.

---

# Mapper Architecture

```
Controller

↓

Service

↓

Mapper

↓

Repository

↓

Database
```

---

# Why Not Map in Controller?

Bad

```
Controller

↓

Create Entity

↓

Business Logic

↓

Repository
```

Good

```
Controller

↓

Service

↓

Mapper

↓

Repository
```

Controllers remain clean.

---

# Why Not Map in Repository?

Repositories should only interact with the database.

```
Repository

↓

CRUD

↓

Queries
```

Object conversion belongs in the Mapper.

---

# Mapper vs Service

| Mapper | Service |
|---------|----------|
| Converts objects | Contains business logic |
| No business rules | Applies business rules |
| DTO ↔ Entity | Coordinates application flow |
| Reusable conversion code | Uses Mapper and Repository |

---

# Mapper vs DTO

| Mapper | DTO |
|---------|-----|
| Converts objects | Holds data |
| Contains mapping methods | Contains fields only |
| No persistence | No business logic |

---

# Common Use Cases

- User Registration
- Login APIs
- Product Management
- Order Processing
- Employee Management
- Payment APIs

---

# Common Mistakes

❌ Writing mapping code inside Controllers.

❌ Writing mapping code in every Service method.

❌ Returning JPA entities directly instead of DTOs.

❌ Mixing business logic with mapping logic.

❌ Using one DTO for every API response.

---

# Real-World Example

## Banking Application

```
AccountRequest

↓

Mapper

↓

Account Entity

↓

Database

↓

Mapper

↓

AccountResponse
```

---

## E-Commerce Website

```
ProductRequest

↓

Mapper

↓

Product Entity

↓

Database

↓

Mapper

↓

ProductResponse
```

---

## Food Delivery App

```
RestaurantRequest

↓

Mapper

↓

Restaurant Entity

↓

Database

↓

Mapper

↓

RestaurantResponse
```

---

# Advantages

- Reduces duplicate code.
- Keeps Services clean.
- Improves maintainability.
- Easy to reuse.
- Better separation of concerns.
- Simplifies DTO conversion.

---

# Best Practices

- Keep mapping logic inside dedicated Mapper classes.
- Use MapStruct for medium and large projects.
- Use manual mapping for very small projects if appropriate.
- Keep Mappers free from business logic.
- Create separate methods for Request and Response conversions.
- Test mapping logic independently.

---

# Interview Questions

### 1. What is a Mapper?

A Mapper converts one object into another, commonly between DTOs and Entities.

---

### 2. Why do we use a Mapper?

To separate object conversion logic from business logic, reducing duplicate code and improving maintainability.

---

### 3. What is the difference between a DTO and a Mapper?

A DTO stores data, while a Mapper converts data between DTOs and Entities.

---

### 4. What is MapStruct?

MapStruct is a compile-time code generation library that automatically creates efficient mapper implementations.

---

### 5. What is the difference between MapStruct and ModelMapper?

- **MapStruct** generates mapping code at compile time and is generally faster.
- **ModelMapper** performs mapping at runtime using reflection, making it easier to start with but typically slower.

---

### 6. Should business logic be written inside a Mapper?

No. A Mapper should only handle object conversion. Business logic belongs in the Service Layer.

---

### 7. Where should a Mapper be used in a Spring Boot application?

Typically in the Service Layer to convert Request DTOs to Entities before saving, and Entities to Response DTOs before returning data.

---

# Quick Revision

- A Mapper converts objects such as DTOs and Entities.
- It keeps Controllers and Services clean.
- Mapping logic should be centralized and reusable.
- Use MapStruct for compile-time generated mappers.
- ModelMapper performs runtime mapping.
- Keep business logic out of Mappers.
- Mappers improve code readability, maintainability, and separation of concerns.