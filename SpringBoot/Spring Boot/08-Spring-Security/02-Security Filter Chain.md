# Security Filter Chain

## What is Security Filter Chain?

The **Security Filter Chain** is the core component of Spring Security that **intercepts every incoming HTTP request** before it reaches your application.

It is a chain of security filters where each filter performs a specific security-related task like:

- Authentication
- Authorization
- CSRF Protection
- CORS Handling
- Session Management
- JWT Validation
- Exception Handling

> **In simple words:**
>
> Think of the Security Filter Chain as a **security checkpoint** at the entrance of your application. Every request must pass through this checkpoint before reaching your controller.

---

# Why Do We Need Security Filter Chain?

Suppose someone calls your API:

```
GET /users
```

Without Security Filter Chain

```
Client

↓

Controller

↓

Database
```

Anyone can access your APIs.

---

With Security Filter Chain

```
Client

↓

Security Filter Chain

↓

Authentication

↓

Authorization

↓

Controller

↓

Database
```

Only authenticated and authorized users can access protected resources.

---

# How Security Filter Chain Works

```
HTTP Request

↓

Filter 1

↓

Filter 2

↓

Filter 3

↓

Filter 4

↓

Controller

↓

HTTP Response
```

Each filter performs one responsibility.

---

# Spring Security Request Flow

```
Client

↓

HTTP Request

↓

Security Filter Chain

↓

Authentication Filter

↓

Authorization Filter

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

# Real-Life Example

Imagine entering an airport.

```
Passenger

↓

Security Check

↓

Identity Verification

↓

Luggage Scan

↓

Boarding Pass Verification

↓

Allowed to Enter
```

Similarly,

```
Request

↓

Security Filters

↓

Authenticated?

↓

Authorized?

↓

Controller
```

---

# What Happens Inside the Filter Chain?

```
Incoming Request

↓

Check CSRF

↓

Check Authentication

↓

Check Authorization

↓

Load Security Context

↓

Controller

↓

Response
```

---

# Default Security Filter Chain

When Spring Security is added,

```xml
<dependency>

    <groupId>org.springframework.boot</groupId>

    <artifactId>spring-boot-starter-security</artifactId>

</dependency>
```

Spring Boot automatically creates a default Security Filter Chain.

All endpoints become protected.

---

# Configuring Security Filter Chain

Spring Security 6 uses a `SecurityFilterChain` bean instead of `WebSecurityConfigurerAdapter`.

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

                .anyRequest()

                .authenticated()

            )

            .formLogin();

        return http.build();

    }

}
```

---

# Explanation

```java
@Bean
```

Creates the Security Filter Chain bean.

---

```java
HttpSecurity
```

Used to configure Spring Security.

---

```java
.authorizeHttpRequests()
```

Defines authorization rules.

---

```java
.anyRequest().authenticated()
```

Every request requires authentication.

---

```java
.formLogin()
```

Enables the default login page.

---

```java
http.build()
```

Builds and returns the Security Filter Chain.

---

# Request Processing Example

User requests

```
GET /profile
```

Flow

```
Request

↓

Security Filter Chain

↓

Authenticated?

↓

No

↓

Login Page

OR

Yes

↓

Controller

↓

Response
```

---

# Common Filters in Spring Security

| Filter | Responsibility |
|---------|----------------|
| `SecurityContextHolderFilter` | Loads security context |
| `UsernamePasswordAuthenticationFilter` | Handles login authentication |
| `AnonymousAuthenticationFilter` | Creates anonymous user if not logged in |
| `ExceptionTranslationFilter` | Handles authentication and authorization exceptions |
| `AuthorizationFilter` | Checks user permissions |

> Spring Security contains many internal filters, but these are among the most commonly discussed in interviews.

---

# Authentication Flow

```
Login Request

↓

UsernamePasswordAuthenticationFilter

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
```

---

# Authorization Flow

```
Authenticated User

↓

AuthorizationFilter

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

# SecurityContext

After successful authentication,

Spring stores the authenticated user inside the **SecurityContext**.

```
Login

↓

Authentication Success

↓

SecurityContext

↓

Future Requests
```

---

# Security Filter Chain vs Servlet Filter

| Servlet Filter | Security Filter Chain |
|----------------|-----------------------|
| Java EE feature | Spring Security feature |
| Generic request filtering | Security-specific filtering |
| Used for logging, compression, etc. | Used for authentication and authorization |
| Created manually | Configured using Spring Security |

---

# Filter Execution Order

```
Request

↓

SecurityContextHolderFilter

↓

UsernamePasswordAuthenticationFilter

↓

AuthorizationFilter

↓

Controller

↓

Response
```

Filters execute in order before the request reaches the controller.

---

# Real-World Example

## Banking Application

```
Customer

↓

Transfer Money

↓

Security Filter Chain

↓

Verify Login

↓

Verify Permission

↓

Transfer Amount
```

---

## E-Commerce Application

```
Customer

↓

Checkout

↓

Authentication

↓

Authorization

↓

Order Placed
```

---

## College Portal

```
Student

↓

View Marks

↓

Authentication

↓

Authorization

↓

Marks Displayed
```

---

# Advantages

- Centralized security
- Every request is secured
- Easy to customize
- Supports JWT authentication
- Supports OAuth2
- Provides CSRF protection
- Easy integration with Spring Boot

---

# Best Practices

- Configure security using `SecurityFilterChain` instead of deprecated approaches.
- Allow only required public endpoints.
- Protect all sensitive APIs.
- Use JWT for stateless REST APIs.
- Place custom filters at the correct position in the chain.
- Keep authentication and authorization logic separate.

---

# Interview Questions

### 1. What is the Security Filter Chain?

The Security Filter Chain is a chain of filters that intercepts every HTTP request and performs security-related tasks before the request reaches the controller.

---

### 2. Why is the Security Filter Chain needed?

It ensures that only authenticated and authorized users can access protected resources.

---

### 3. Which class is used to configure the Security Filter Chain?

```java
HttpSecurity
```

---

### 4. What replaced `WebSecurityConfigurerAdapter` in Spring Security 6?

A `SecurityFilterChain` bean.

---

### 5. Which filter handles username and password authentication?

```text
UsernamePasswordAuthenticationFilter
```

---

### 6. What happens after successful authentication?

The authenticated user's information is stored in the `SecurityContext`.

---

### 7. Does every request pass through the Security Filter Chain?

Yes. Every incoming HTTP request is processed by the Security Filter Chain before reaching the controller.

---

# Quick Revision

- The Security Filter Chain is the core of Spring Security.
- Every HTTP request passes through the filter chain.
- Each filter performs a specific security task.
- Configure it using a `SecurityFilterChain` bean and `HttpSecurity`.
- `UsernamePasswordAuthenticationFilter` handles login requests.
- `AuthorizationFilter` checks permissions.
- After successful authentication, user details are stored in the `SecurityContext`.
- Spring Security 6 uses `SecurityFilterChain` instead of `WebSecurityConfigurerAdapter`.