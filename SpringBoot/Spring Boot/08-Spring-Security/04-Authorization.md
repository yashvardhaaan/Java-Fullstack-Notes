# Authorization

## What is Authorization?

**Authorization** is the process of determining **what an authenticated user is allowed to access or perform**.

It answers the question:

> **"What are you allowed to do?"**

Authentication verifies the user's identity, while Authorization determines the permissions granted to that user.

> **In simple words:**
>
> Authentication checks **who you are**, whereas Authorization checks **what you can do**.

---

# Why Do We Need Authorization?

Imagine a Banking Application.

There are three users:

- Customer
- Employee
- Admin

Can all of them:

- Delete accounts?
- View all customer details?
- Transfer money on behalf of customers?

**No.**

Each user should only perform actions they are permitted to do.

Without Authorization:

```
Customer

↓

Delete Bank Database ❌
```

With Authorization:

```
Customer

↓

Transfer Money ✅

Delete Database ❌
```

---

# Authentication vs Authorization

| Authentication | Authorization |
|---------------|---------------|
| Verifies identity | Verifies permissions |
| "Who are you?" | "What can you do?" |
| Happens first | Happens after authentication |
| Login process | Access control |
| Uses username/password | Uses roles and authorities |

---

# Authorization Flow

```
Client

↓

Login

↓

Authentication

↓

Authentication Successful

↓

Authorization

↓

Permission Granted?

↓

Yes

↓

Controller

↓

Response

OR

↓

403 Forbidden
```

---

# How Authorization Works in Spring Security

```
Client

↓

HTTP Request

↓

Security Filter Chain

↓

Authentication

↓

Authorization

↓

Controller

↓

Business Logic

↓

Response
```

Authorization is checked **only after successful authentication**.

---

# Real-Life Example

Imagine a company office.

```
Employee

↓

Show ID Card

↓

Identity Verified

↓

Access Employee Area
```

```
Visitor

↓

Show ID Card

↓

Identity Verified

↓

Denied Entry to Server Room
```

Identity is verified first.

Permissions are checked second.

---

# Authorization Using Roles

Users are usually assigned one or more roles.

Example

```
ADMIN

USER

MANAGER

HR
```

Spring Security checks these roles before allowing access.

---

# Example

Admin APIs

```
/admin/**
```

Only ADMIN can access.

Customer APIs

```
/profile/**
```

Authenticated users can access.

Public APIs

```
/login

/register
```

Anyone can access.

---

# Configuring Authorization

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(

            HttpSecurity http

    ) throws Exception {

        http

            .authorizeHttpRequests(auth -> auth

                .requestMatchers(

                        "/login",

                        "/register"

                ).permitAll()

                .anyRequest()

                .authenticated()

            );

        return http.build();

    }

}
```

---

# Explanation

```java
.requestMatchers("/login", "/register")
```

Public APIs.

Anyone can access.

---

```java
.permitAll()
```

Allows access without login.

---

```java
.anyRequest()
```

Represents every remaining request.

---

```java
.authenticated()
```

Requires the user to be logged in.

---

# Authorization Using Roles

```java
.authorizeHttpRequests(auth -> auth

    .requestMatchers("/admin/**")

    .hasRole("ADMIN")

    .requestMatchers("/user/**")

    .hasRole("USER")

    .anyRequest()

    .authenticated()

)
```

Explanation

```
/admin/**

↓

ADMIN only
```

```
/user/**

↓

USER only
```

---

# Role Checking Flow

```
User

↓

Login

↓

Authentication

↓

Load Roles

↓

Request

↓

Has Required Role?

↓

Yes

↓

Access Granted

OR

↓

403 Forbidden
```

---

# Authorization Using Authorities

Instead of roles,

Spring Security can also use **Authorities**.

Example

```
READ_PRODUCT

CREATE_PRODUCT

DELETE_PRODUCT

UPDATE_PRODUCT
```

Authorities provide more fine-grained control than roles.

---

# Roles vs Authorities

| Role | Authority |
|------|-----------|
| High-level permission | Specific permission |
| Example: ADMIN | Example: DELETE_USER |
| Groups multiple permissions | Single permission |
| Easier to manage | More flexible |

---

# HTTP Status Codes

| Status Code | Meaning |
|-------------|---------|
| 200 | Authorized |
| 401 | User is not authenticated |
| 403 | User is authenticated but not authorized |

---

# Request Flow

```
HTTP Request

↓

Security Filter Chain

↓

Authentication

↓

Authorization

↓

Permission Granted?

↓

Yes

↓

Controller

↓

Response

OR

↓

403 Forbidden
```

---

# Real-World Example

## Banking Application

```
Customer

↓

Transfer Money

↓

Authorized

↓

Success
```

```
Customer

↓

Delete Employee

↓

403 Forbidden
```

---

## E-Commerce Application

```
Customer

↓

View Products

↓

Allowed
```

```
Customer

↓

Delete Product

↓

403 Forbidden
```

---

## College Portal

```
Student

↓

View Marks

↓

Allowed
```

```
Student

↓

Add Faculty

↓

403 Forbidden
```

---

# Authorization Architecture

```
User

↓

Authentication

↓

SecurityContext

↓

Roles / Authorities

↓

Authorization Check

↓

Controller

↓

Business Logic
```

---

# Common Authorization Methods

| Method | Description |
|---------|-------------|
| `authenticated()` | User must be logged in |
| `permitAll()` | Anyone can access |
| `denyAll()` | Nobody can access |
| `hasRole()` | Checks a role |
| `hasAnyRole()` | Checks multiple roles |
| `hasAuthority()` | Checks a permission |
| `hasAnyAuthority()` | Checks multiple permissions |

---

# Advantages

- Protects sensitive APIs.
- Restricts unauthorized actions.
- Supports role-based security.
- Supports permission-based security.
- Easy integration with Spring Security.
- Improves application security.

---

# Best Practices

- Always authenticate users before authorization.
- Follow the Principle of Least Privilege.
- Use roles for broad access control.
- Use authorities for fine-grained permissions.
- Protect all sensitive endpoints.
- Never rely on frontend authorization alone.
- Return proper HTTP status codes.

---

# Interview Questions

### 1. What is Authorization?

Authorization is the process of determining what an authenticated user is allowed to access.

---

### 2. What is the difference between Authentication and Authorization?

Authentication verifies identity, while Authorization determines permissions.

---

### 3. Which annotation configures URL-based authorization?

Using `HttpSecurity`:

```java
.authorizeHttpRequests()
```

---

### 4. Which method allows public access?

```java
.permitAll()
```

---

### 5. Which method requires authentication?

```java
.authenticated()
```

---

### 6. What is the difference between 401 and 403?

- **401 Unauthorized** → User is not authenticated.
- **403 Forbidden** → User is authenticated but does not have permission.

---

### 7. Which is more fine-grained: Roles or Authorities?

Authorities are more fine-grained because they represent individual permissions.

---

# Quick Revision

- Authorization determines **what an authenticated user can access**.
- It always happens **after Authentication**.
- Configure authorization using `authorizeHttpRequests()`.
- `permitAll()` allows public access.
- `authenticated()` requires login.
- `hasRole()` checks user roles.
- `hasAuthority()` checks specific permissions.
- **401** means the user is not logged in.
- **403** means the user is logged in but lacks permission.
- Follow the Principle of Least Privilege when assigning permissions.