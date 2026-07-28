# Method Security

## What is Method Security?

**Method Security** is a feature in Spring Security that allows you to secure **individual methods** instead of securing URLs.

Instead of protecting endpoints like:

```
/admin/**
```

you can protect specific methods such as:

- createUser()
- deleteUser()
- updateProduct()
- transferMoney()

using annotations.

> **In simple words:**
>
> Method Security controls **who can execute a particular Java method**.

---

# Why Do We Need Method Security?

Suppose your application has:

```
/users/{id}
```

Both ADMIN and USER can access this endpoint.

But inside the service:

```
View User

↓

Delete User

↓

Update User
```

Only ADMIN should delete users.

URL security alone is not enough.

Method Security solves this problem.

---

# URL Security vs Method Security

## URL Security

```
Request

↓

/admin/**

↓

Allowed?
```

Protects URLs.

---

## Method Security

```
Controller

↓

Service Method

↓

@PreAuthorize

↓

Execute?
```

Protects Java methods.

---

# How Method Security Works

```
Client

↓

HTTP Request

↓

Authentication

↓

Authorization

↓

Controller

↓

Service Method

↓

Method Security

↓

Execute Method?

↓

Yes

↓

Business Logic

OR

↓

403 Forbidden
```

---

# Enabling Method Security

Spring Security does **not** enable method security by default.

Enable it using:

```java
@Configuration
@EnableMethodSecurity
public class SecurityConfig {

}
```

Now Spring will process method security annotations.

---

# Common Method Security Annotations

| Annotation | Purpose |
|------------|---------|
| `@PreAuthorize` | Check permission before method execution |
| `@PostAuthorize` | Check permission after method execution |
| `@Secured` | Restrict access based on roles |
| `@RolesAllowed` | JSR-250 role-based authorization |

---

# @PreAuthorize

Checks authorization **before** executing the method.

```java
@Service
public class UserService {

    @PreAuthorize("hasRole('ADMIN')")
    public void deleteUser() {

        System.out.println("User Deleted");

    }

}
```

Flow

```
Call Method

↓

Check Role

↓

ADMIN?

↓

Yes

↓

Execute Method

OR

↓

403 Forbidden
```

---

# @PostAuthorize

Checks authorization **after** method execution.

```java
@PostAuthorize("hasRole('ADMIN')")
public User getUser() {

    return repository.findById(1L).get();

}
```

Useful when authorization depends on the returned object.

---

# @Secured

Restricts access based on roles.

```java
@Secured("ROLE_ADMIN")
public void createUser() {

}
```

Only ADMIN can execute the method.

---

# @RolesAllowed

Java standard annotation.

```java
@RolesAllowed("ADMIN")
public void updateUser() {

}
```

Requires JSR-250 support.

---

# Multiple Roles

```java
@PreAuthorize(

    "hasAnyRole('ADMIN','MANAGER')"

)
public void generateReport() {

}
```

Both ADMIN and MANAGER can execute the method.

---

# Using Authorities

```java
@PreAuthorize(

    "hasAuthority('DELETE_USER')"

)
public void deleteUser() {

}
```

Spring checks the authority instead of the role.

---

# hasRole() vs hasAuthority()

| hasRole() | hasAuthority() |
|------------|----------------|
| Checks role | Checks permission |
| Example: ADMIN | Example: DELETE_USER |
| Prefixes internally with `ROLE_` | Uses the authority exactly as provided |

---

# Method Security Flow

```
HTTP Request

↓

Authentication

↓

Controller

↓

Service Method

↓

@PreAuthorize

↓

Permission Check

↓

Execute?

↓

Yes

↓

Business Logic

↓

Response

OR

↓

403 Forbidden
```

---

# Complete Example

```java
@Service
public class ProductService {

    @PreAuthorize("hasRole('ADMIN')")
    public void deleteProduct() {

        System.out.println("Product Deleted");

    }

}
```

Controller

```java
@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService service;

    @DeleteMapping("/{id}")
    public void deleteProduct(

            @PathVariable Long id

    ) {

        service.deleteProduct();

    }

}
```

Only ADMIN users can execute the service method.

---

# Real-World Example

## Banking Application

```
Transfer Money

↓

Authenticated Customer

↓

Allowed
```

```
Close Customer Account

↓

ADMIN Only
```

---

## E-Commerce Application

```
View Products

↓

USER

↓

Allowed
```

```
Delete Product

↓

ADMIN

↓

Allowed
```

---

## Hospital Management

```
Doctor

↓

View Patient Record

↓

Allowed
```

```
Delete Patient Record

↓

ADMIN Only
```

---

# Method Security vs URL Security

| Method Security | URL Security |
|-----------------|--------------|
| Secures Java methods | Secures HTTP endpoints |
| Uses annotations | Uses `HttpSecurity` configuration |
| Fine-grained access control | Coarse-grained access control |
| Applied in Service or Controller | Applied before reaching the Controller |

---

# Common Security Expressions

| Expression | Meaning |
|------------|---------|
| `hasRole('ADMIN')` | User must have ADMIN role |
| `hasAnyRole('ADMIN','MANAGER')` | User can have either role |
| `hasAuthority('DELETE_USER')` | User must have a specific authority |
| `hasAnyAuthority(...)` | User must have one of the listed authorities |
| `isAuthenticated()` | User must be logged in |
| `permitAll()` | Everyone is allowed |

---

# Request Processing

```
Request

↓

Security Filter Chain

↓

Authentication

↓

Controller

↓

Service

↓

Method Security

↓

Permission Granted?

↓

Yes

↓

Execute Method

↓

Response

OR

↓

403 Forbidden
```

---

# Advantages

- Fine-grained authorization.
- Protects business logic.
- Easy to read using annotations.
- Works well with roles and authorities.
- Reduces authorization code inside methods.

---

# Best Practices

- Enable method security using `@EnableMethodSecurity`.
- Prefer `@PreAuthorize` for most authorization checks.
- Keep business logic in the Service layer and secure service methods.
- Use roles for broad access and authorities for detailed permissions.
- Do not rely only on URL-based security.

---

# Interview Questions

### 1. What is Method Security?

Method Security secures individual methods using annotations such as `@PreAuthorize` and `@Secured`.

---

### 2. Which annotation enables Method Security?

```java
@EnableMethodSecurity
```

---

### 3. Which annotation checks authorization before method execution?

```java
@PreAuthorize
```

---

### 4. What is the difference between `@PreAuthorize` and `@PostAuthorize`?

- `@PreAuthorize` checks permissions **before** executing the method.
- `@PostAuthorize` checks permissions **after** the method returns.

---

### 5. Where should Method Security usually be applied?

It is commonly applied to **Service layer methods**, where the business logic resides.

---

### 6. What is the difference between URL Security and Method Security?

URL Security protects HTTP endpoints, while Method Security protects individual Java methods.

---

# Quick Revision

- Method Security protects individual Java methods.
- Enable it using `@EnableMethodSecurity`.
- `@PreAuthorize` checks permissions before execution.
- `@PostAuthorize` checks permissions after execution.
- `@Secured` and `@RolesAllowed` provide role-based method access.
- Use `hasRole()` for roles and `hasAuthority()` for fine-grained permissions.
- Apply Method Security mainly in the Service layer to protect business logic.