# Spring Security Basics

## What is Spring Security?

**Spring Security** is a powerful security framework that provides **authentication**, **authorization**, and protection against common security attacks for Spring applications.

It helps secure web applications and REST APIs with minimal configuration.

> **In simple words:**
>
> Spring Security is like a **security guard** standing at the entrance of your application. Every request must pass through it before reaching your code.

---

# Why Do We Need Spring Security?

Imagine you have a Banking Application.

Without Spring Security:

```
Internet

↓

Anyone

↓

Transfer Money
```

Anyone can access your APIs.

With Spring Security:

```
Internet

↓

Spring Security

↓

Verify User

↓

Allow / Deny Request

↓

Controller
```

Only authenticated and authorized users can access protected resources.

---

# Features of Spring Security

- Authentication
- Authorization
- Password Encryption
- CSRF Protection
- CORS Support
- Session Management
- JWT Support
- OAuth2 Login
- Method-Level Security
- Protection against common attacks

---

# Spring Security Architecture

```
Client

↓

HTTP Request

↓

Spring Security Filter Chain

↓

Authentication

↓

Authorization

↓

Controller

↓

Service

↓

Repository

↓

Database
```

Every request first passes through Spring Security.

---

# How Spring Security Works

```
User

↓

HTTP Request

↓

Security Filter Chain

↓

Authenticated?

↓

No

↓

401 Unauthorized

OR

Yes

↓

Authorized?

↓

No

↓

403 Forbidden

OR

Yes

↓

Controller

↓

Business Logic

↓

Response
```

---

# Default Behavior

When you add the Spring Security dependency:

```xml
<dependency>

    <groupId>
        org.springframework.boot
    </groupId>

    <artifactId>
        spring-boot-starter-security
    </artifactId>

</dependency>
```

Spring Boot automatically:

- Secures every endpoint.
- Generates a default username.
- Generates a random password.
- Displays the password in the console.
- Shows the default login page.

---

# Default Login Flow

```
Client

↓

GET /users

↓

Not Logged In

↓

Redirect

↓

Default Login Page

↓

Username & Password

↓

Authentication

↓

Access Granted
```

---

# Default Credentials

Username

```
user
```

Password

```
Generated in Console
```

Example:

```
Using generated security password:

2af74c73-0fa3-4b62-bf21-fd3299c21ef5
```

---

# Request Processing

```
HTTP Request

↓

Spring Security Filters

↓

Authentication

↓

Authorization

↓

Controller

↓

Response
```

---

# Authentication in Spring Security

Authentication verifies the identity of the user.

```
Username

↓

Password

↓

AuthenticationManager

↓

Database

↓

Authenticated
```

---

# Authorization in Spring Security

Authorization checks what the authenticated user is allowed to do.

Example

```
Admin

↓

Delete User

↓

Allowed
```

```
Normal User

↓

Delete User

↓

403 Forbidden
```

---

# Spring Security Components

## Security Filter Chain

Intercepts every incoming request before it reaches the controller.

```
Request

↓

Security Filter Chain

↓

Controller
```

---

## AuthenticationManager

Responsible for authenticating users.

```
Login Request

↓

AuthenticationManager

↓

Success / Failure
```

---

## UserDetailsService

Loads user information from the database.

```java
UserDetails loadUserByUsername(
        String username
);
```

---

## PasswordEncoder

Encrypts and verifies passwords.

```
Password

↓

BCrypt

↓

Encrypted Password
```

---

## SecurityContext

Stores authentication information for the currently logged-in user.

```
Current User

↓

SecurityContext
```

---

# Authentication Flow

```
Client

↓

Login Request

↓

Authentication Filter

↓

AuthenticationManager

↓

UserDetailsService

↓

Database

↓

PasswordEncoder

↓

Authentication Success

↓

SecurityContext

↓

Controller
```

---

# Authorization Flow

```
Authenticated User

↓

Request

↓

Check Roles

↓

Allowed?

↓

Yes

↓

Controller

OR

No

↓

403 Forbidden
```

---

# Spring Security vs Manual Security

| Spring Security | Manual Security |
|-----------------|-----------------|
| Built-in framework | Developer writes everything |
| Secure by default | Easy to make mistakes |
| Password encryption | Must implement manually |
| CSRF protection | Must implement manually |
| Session management | Manual handling |
| JWT & OAuth2 support | Custom implementation |

---

# Common HTTP Status Codes

| Status | Meaning |
|---------|---------|
| 200 | Request Successful |
| 401 | Unauthorized (Not Authenticated) |
| 403 | Forbidden (No Permission) |
| 404 | Resource Not Found |

---

# Dependency

Maven

```xml
<dependency>

    <groupId>
        org.springframework.boot
    </groupId>

    <artifactId>
        spring-boot-starter-security
    </artifactId>

</dependency>
```

---

# Simple Configuration

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

}
```

This enables Spring Security customization.

---

# Real-World Example

## Banking Application

```
Customer

↓

Login

↓

Spring Security

↓

Verify Credentials

↓

Transfer Money
```

---

## E-Commerce Application

```
Customer

↓

Login

↓

Spring Security

↓

View Orders
```

---

## College Portal

```
Student

↓

Login

↓

Spring Security

↓

View Marks
```

---

# Advantages

- Easy to integrate.
- Highly secure.
- Protects REST APIs.
- Supports JWT and OAuth2.
- Password encryption.
- Flexible authentication mechanisms.
- Built-in protection against common attacks.

---

# Best Practices

- Always store encrypted passwords.
- Use HTTPS in production.
- Prefer BCrypt for password hashing.
- Disable CSRF only for stateless REST APIs when appropriate.
- Follow the principle of least privilege.
- Use JWT for stateless APIs.
- Never expose sensitive information in responses.

---

# Interview Questions

### 1. What is Spring Security?

Spring Security is a framework that provides authentication, authorization, and protection against common security vulnerabilities for Spring applications.

---

### 2. What is the default username after adding Spring Security?

```
user
```

---

### 3. Where is the default password shown?

It is printed in the application console during startup.

---

### 4. What is the difference between Authentication and Authorization?

- **Authentication** verifies who the user is.
- **Authorization** determines what the authenticated user is allowed to access.

---

### 5. Which component authenticates users?

```
AuthenticationManager
```

---

### 6. What is the role of `UserDetailsService`?

It loads user information such as username, password, and roles from the database.

---

### 7. What is the purpose of the Security Filter Chain?

It intercepts every incoming request and performs security checks before the request reaches the controller.

---

# Quick Revision

- Spring Security secures Spring applications and REST APIs.
- Every request passes through the **Security Filter Chain**.
- It provides Authentication, Authorization, Password Encryption, CSRF Protection, CORS Support, JWT, and OAuth2.
- By default, all endpoints are secured.
- Default username is **`user`**, and a generated password is printed in the console.
- Important components include **AuthenticationManager**, **UserDetailsService**, **PasswordEncoder**, and **SecurityContext**.
- Authentication verifies identity, while Authorization checks permissions.