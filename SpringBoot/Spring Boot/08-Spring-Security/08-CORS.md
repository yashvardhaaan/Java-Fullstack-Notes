# CORS (Cross-Origin Resource Sharing)

## What is CORS?

**CORS (Cross-Origin Resource Sharing)** is a browser security mechanism that controls **whether one website can access resources from another website**.

It allows or blocks requests coming from **different origins**.

> **In simple words:**
>
> CORS decides **which websites are allowed to access your backend API.**

---

# Why Do We Need CORS?

Suppose your frontend is running on:

```
http://localhost:3000
```

Your Spring Boot backend is running on:

```
http://localhost:8080
```

When React calls the backend,

```
React App

↓

GET http://localhost:8080/api/users
```

The browser notices:

```
3000 ≠ 8080
```

These are different origins.

By default,

the browser blocks the request.

---

# What is an Origin?

An **Origin** consists of:

```
Protocol

+

Domain

+

Port
```

Example

```
http://localhost:8080
```

Protocol

```
http
```

Domain

```
localhost
```

Port

```
8080
```

---

# Same Origin Examples

```
http://localhost:8080

↓

http://localhost:8080
```

Same Origin

✅ Allowed

---

```
https://example.com

↓

https://example.com
```

Same Origin

✅ Allowed

---

# Different Origin Examples

```
http://localhost:3000

↓

http://localhost:8080
```

Different Port

❌ Different Origin

---

```
http://example.com

↓

https://example.com
```

Different Protocol

❌ Different Origin

---

```
http://example.com

↓

http://api.example.com
```

Different Subdomain

❌ Different Origin

---

# Why Does the Browser Block It?

Imagine:

```
bank.com
```

stores your banking information.

Now,

```
evil.com
```

tries to read it.

Without CORS,

```
evil.com

↓

bank.com

↓

Read Account Details
```

This would be dangerous.

CORS protects users from such attacks.

---

# How CORS Works

```
Browser

↓

Frontend Request

↓

Backend

↓

Check Allowed Origin

↓

Allowed?

↓

Yes

↓

Response

OR

↓

Blocked by Browser
```

---

# Browser Request Flow

```
React App

↓

GET /users

↓

Browser

↓

Spring Boot

↓

Access-Control-Allow-Origin

↓

Browser

↓

Return Response
```

---

# CORS Response Header

Example

```
Access-Control-Allow-Origin:

http://localhost:3000
```

This tells the browser:

```
Requests from localhost:3000

↓

Allowed
```

---

# Without CORS

```
React

↓

Spring Boot

↓

Browser Blocks Response

↓

CORS Error
```

Example Error

```
Access to fetch at

'http://localhost:8080'

has been blocked by CORS policy.
```

---

# Enabling CORS Using @CrossOrigin

```java
@RestController
@RequestMapping("/users")
@CrossOrigin(
        origins = "http://localhost:3000"
)
public class UserController {

    @GetMapping
    public String getUsers() {

        return "Users";

    }

}
```

Only requests from:

```
http://localhost:3000
```

are allowed.

---

# Allow Multiple Origins

```java
@CrossOrigin(

    origins = {

        "http://localhost:3000",

        "http://localhost:4200"

    }

)
```

Both applications can access the API.

---

# Global CORS Configuration

```java
@Configuration
public class CorsConfig
        implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(

            CorsRegistry registry

    ) {

        registry.addMapping("/**")

                .allowedOrigins(

                        "http://localhost:3000"

                )

                .allowedMethods(

                        "GET",

                        "POST",

                        "PUT",

                        "DELETE"

                );

    }

}
```

This configuration applies to every controller.

---

# CORS Configuration in Spring Security

When Spring Security is enabled,

configure CORS inside the Security Filter Chain.

```java
@Bean
public SecurityFilterChain securityFilterChain(

        HttpSecurity http

) throws Exception {

    http

        .cors(Customizer.withDefaults())

        .csrf(csrf -> csrf.disable());

    return http.build();

}
```

---

# Simple Request

A simple request:

```
GET

POST

HEAD
```

does not require a preflight request.

Flow

```
Browser

↓

GET Request

↓

Server

↓

Response
```

---

# Preflight Request

For requests like:

```
PUT

DELETE

PATCH
```

or custom headers,

the browser first sends:

```
OPTIONS
```

request.

```
Browser

↓

OPTIONS

↓

Server

↓

Allowed?

↓

Yes

↓

Actual Request
```

---

# Preflight Flow

```
Browser

↓

OPTIONS Request

↓

Spring Boot

↓

CORS Validation

↓

Allowed?

↓

Yes

↓

Actual API Request

↓

Response
```

---

# Common CORS Headers

| Header | Purpose |
|---------|----------|
| `Access-Control-Allow-Origin` | Allowed origin |
| `Access-Control-Allow-Methods` | Allowed HTTP methods |
| `Access-Control-Allow-Headers` | Allowed request headers |
| `Access-Control-Allow-Credentials` | Allows cookies/credentials |

---

# CORS vs CSRF

| CORS | CSRF |
|------|------|
| Controls cross-origin requests | Prevents forged requests |
| Browser security feature | Authentication security feature |
| Uses HTTP headers | Uses CSRF Tokens |
| Protects APIs from unauthorized origins | Protects authenticated users |

---

# Request Flow

```
Frontend

↓

Browser

↓

Spring Security

↓

CORS Check

↓

Allowed Origin?

↓

Yes

↓

Controller

↓

Response

OR

↓

Blocked by Browser
```

---

# Real-World Example

## React + Spring Boot

```
React

↓

localhost:3000

↓

Spring Boot

↓

localhost:8080

↓

CORS Configuration

↓

Response
```

---

## Angular + Spring Boot

```
Angular

↓

localhost:4200

↓

Spring Boot API

↓

Allowed Origin

↓

Success
```

---

## Mobile Application

```
Mobile App

↓

REST API

↓

Allowed

↓

Receive Response
```

---

# Advantages

- Securely allows cross-origin requests.
- Prevents unauthorized websites from accessing APIs.
- Supports frontend-backend separation.
- Required for modern SPA frameworks like React and Angular.
- Easy to configure in Spring Boot.

---

# Best Practices

- Never use `allowedOrigins("*")` in production for sensitive APIs.
- Allow only trusted frontend domains.
- Configure CORS globally when multiple controllers require it.
- Configure CORS with Spring Security if security is enabled.
- Restrict allowed HTTP methods whenever possible.
- Enable credentials only when necessary.

---

# Interview Questions

### 1. What is CORS?

CORS (Cross-Origin Resource Sharing) is a browser security mechanism that controls whether one origin can access resources from another origin.

---

### 2. What is an Origin?

An origin consists of:

- Protocol
- Domain
- Port

---

### 3. Why does CORS occur?

Because the frontend and backend are running on different origins.

Example:

```
Frontend

http://localhost:3000
```

Backend

```
http://localhost:8080
```

---

### 4. Which annotation enables CORS for a controller?

```java
@CrossOrigin
```

---

### 5. What is a Preflight Request?

A browser sends an `OPTIONS` request before certain cross-origin requests (such as `PUT`, `DELETE`, or requests with custom headers) to check whether the server allows the actual request.

---

### 6. Is CORS a Spring Security feature?

No.

CORS is a **browser security mechanism**. Spring Boot and Spring Security provide ways to configure the required HTTP headers.

---

### 7. What is the difference between CORS and CSRF?

- **CORS** controls which origins can access your API.
- **CSRF** protects authenticated users from forged requests.

---

# Quick Revision

- CORS stands for **Cross-Origin Resource Sharing**.
- An origin is made up of **Protocol + Domain + Port**.
- Different origins are blocked by the browser unless the server explicitly allows them.
- Use `@CrossOrigin` for controller-level configuration.
- Use `WebMvcConfigurer` for global CORS configuration.
- When using Spring Security, enable CORS in the `SecurityFilterChain`.
- Browsers send an `OPTIONS` preflight request before certain cross-origin requests.
- CORS protects against unauthorized cross-origin access, while CSRF protects authenticated users from forged requests.