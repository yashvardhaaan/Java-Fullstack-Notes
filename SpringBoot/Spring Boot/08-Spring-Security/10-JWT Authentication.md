# JWT Authentication

## What is JWT Authentication?

**JWT Authentication** is a stateless authentication mechanism where the server verifies the user's identity using a **JSON Web Token (JWT)** instead of maintaining a server-side session.

After a successful login, the server generates a JWT and sends it to the client. The client includes this token in every subsequent request.

> **In simple words:**
>
> The user logs in once, receives a JWT, and uses that token to prove their identity for future requests.

---

# Why Do We Need JWT Authentication?

Suppose a user logs into an application.

Without JWT

```
Login

↓

Server Creates Session

↓

Stores Session in Memory

↓

Client Sends Session ID
```

Problems:

- Server memory usage increases.
- Difficult to scale.
- Session replication is required.

---

With JWT

```
Login

↓

Generate JWT

↓

Return JWT

↓

Client Stores JWT

↓

JWT Sent With Every Request

↓

Server Validates JWT

↓

Response
```

No session is stored on the server.

---

# JWT Authentication Flow

```
User

↓

Enter Username & Password

↓

Spring Security

↓

AuthenticationManager

↓

UserDetailsService

↓

Database

↓

Credentials Valid?

↓

Yes

↓

Generate JWT

↓

Return JWT

↓

Client Stores JWT

↓

Future Requests

↓

Authorization Header

↓

JWT Validation

↓

Controller
```

---

# Complete Architecture

```
                Login

                  │

                  ▼

        Username & Password

                  │

                  ▼

      AuthenticationManager

                  │

                  ▼

       UserDetailsService

                  │

                  ▼

              Database

                  │

                  ▼

        Authentication Success

                  │

                  ▼

          Generate JWT

                  │

                  ▼

        Return JWT to Client

                  │

──────────────────────────────────────────

Client Stores JWT

                  │

                  ▼

Authorization: Bearer Token

                  │

                  ▼

     JWT Authentication Filter

                  │

                  ▼

          Validate Token

                  │

                  ▼

      SecurityContext Updated

                  │

                  ▼

            Controller
```

---

# Step 1 : User Login

Client sends

```http
POST /login
```

Request

```json
{
    "username": "yash",
    "password": "admin123"
}
```

---

# Step 2 : Authentication

Spring Security performs

```
Username

↓

Load User

↓

Password Match?

↓

Authenticated
```

Internally

```
AuthenticationManager

↓

UserDetailsService

↓

PasswordEncoder

↓

Success
```

---

# Step 3 : Generate JWT

After successful authentication

```
Username

↓

JWT Utility

↓

Generate Token

↓

JWT
```

Example

```
eyJhbGciOiJIUzI1Ni...

eyJzdWIiOiJ5YXNo...

SflKxwRJSMeKKF2...
```

---

# Step 4 : Return JWT

Response

```json
{
    "token":"eyJhbGciOiJIUzI1Ni..."
}
```

---

# Step 5 : Client Stores JWT

The client stores the token.

Common storage options

- Memory
- Secure Cookie
- Browser Storage (used with care)

---

# Step 6 : Client Sends JWT

Every request contains

```http
GET /api/users

Authorization: Bearer eyJhbGciOiJIUzI1Ni...
```

---

# Step 7 : JWT Authentication Filter

The request reaches Spring Security.

```
HTTP Request

↓

JWT Filter

↓

Extract Token

↓

Validate Token

↓

Extract Username

↓

Load User

↓

Authentication Success

↓

SecurityContext

↓

Controller
```

---

# JWT Authentication Filter

Spring Security uses a custom filter.

Usually,

it extends

```java
OncePerRequestFilter
```

Reason

```
One HTTP Request

↓

Filter Executes Once
```

---

# Sample JWT Filter

```java
@Component
public class JwtAuthenticationFilter
        extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(

            HttpServletRequest request,

            HttpServletResponse response,

            FilterChain filterChain

    ) throws ServletException, IOException {

        String authHeader =

                request.getHeader("Authorization");

        filterChain.doFilter(request, response);

    }

}
```

---

# Extracting JWT

Authorization Header

```http
Authorization:

Bearer eyJhbGciOiJIUzI1Ni...
```

Java

```java
String authHeader =

        request.getHeader("Authorization");
```

---

# Removing "Bearer"

```java
String token =

        authHeader.substring(7);
```

Result

```
eyJhbGciOiJIUzI1Ni...
```

---

# Validating JWT

```
JWT

↓

Signature Valid?

↓

Expired?

↓

Username Extracted?

↓

Authentication Successful
```

---

# Updating SecurityContext

After validation

```
JWT

↓

Username

↓

UserDetails

↓

Authentication Object

↓

SecurityContextHolder
```

Spring now considers the user authenticated.

---

# Request Flow

```
HTTP Request

↓

Security Filter Chain

↓

JWT Authentication Filter

↓

Validate JWT

↓

SecurityContext

↓

Authorization

↓

Controller

↓

Response
```

---

# Security Configuration

```java
@Bean
public SecurityFilterChain securityFilterChain(

        HttpSecurity http

) throws Exception {

    http

        .csrf(csrf -> csrf.disable())

        .sessionManagement(session ->

                session.sessionCreationPolicy(

                        SessionCreationPolicy.STATELESS

                )
        )

        .authorizeHttpRequests(auth -> auth

                .requestMatchers("/login")

                .permitAll()

                .anyRequest()

                .authenticated()

        );

    return http.build();

}
```

---

# Why Stateless?

```
Request 1

↓

JWT

↓

Authenticate

↓

Forget
```

```
Request 2

↓

JWT

↓

Authenticate Again

↓

Forget
```

No session exists on the server.

---

# JWT Authentication vs Session Authentication

| JWT Authentication | Session Authentication |
|--------------------|------------------------|
| Stateless | Stateful |
| Client stores token | Server stores session |
| Uses Authorization header | Uses Session Cookie |
| Better for REST APIs | Better for MVC applications |
| Easy to scale | Requires session replication |

---

# Authentication Lifecycle

```
Login

↓

Authenticate

↓

Generate JWT

↓

Client Stores JWT

↓

Every Request

↓

JWT Validation

↓

Controller
```

---

# Common Components

| Component | Responsibility |
|------------|----------------|
| AuthenticationManager | Authenticates user |
| UserDetailsService | Loads user details |
| PasswordEncoder | Verifies password |
| JwtUtil | Generates and validates JWT |
| JwtAuthenticationFilter | Validates every request |
| SecurityContextHolder | Stores authenticated user |

---

# Real-World Example

## Banking Application

```
Customer Login

↓

JWT Generated

↓

Transfer Money

↓

JWT Verified

↓

Success
```

---

## E-Commerce Website

```
Login

↓

JWT

↓

View Orders

↓

Authenticated
```

---

## Food Delivery Application

```
Login

↓

JWT

↓

Track Order

↓

Authenticated
```

---

# Advantages

- Stateless authentication.
- Highly scalable.
- No server-side session.
- Suitable for REST APIs.
- Faster request processing.
- Easy integration with Spring Security.

---

# Best Practices

- Always use HTTPS.
- Keep JWT expiration short.
- Use Refresh Tokens for long sessions.
- Never store sensitive information inside the JWT payload.
- Validate every JWT before processing the request.
- Use `Authorization: Bearer <token>` for every protected request.
- Set `SessionCreationPolicy.STATELESS` for JWT-based APIs.

---

# Interview Questions

### 1. What is JWT Authentication?

JWT Authentication is a stateless authentication mechanism where users authenticate using a JSON Web Token instead of a server-side session.

---

### 2. Why is `SessionCreationPolicy.STATELESS` used?

Because JWT applications do not use server-side sessions. Every request is authenticated independently.

---

### 3. Which Spring Security filter is commonly used for JWT validation?

A custom filter extending:

```java
OncePerRequestFilter
```

---

### 4. Where is the JWT sent?

In the HTTP Authorization header.

```http
Authorization: Bearer <token>
```

---

### 5. What happens after JWT validation?

Spring creates an Authentication object and stores it in the `SecurityContextHolder`.

---

### 6. Why is `OncePerRequestFilter` preferred?

Because it guarantees that the filter executes only once for each HTTP request.

---

### 7. Does the server store JWT?

No.

The client stores the JWT, and the server validates it on every request.

---

# Quick Revision

- JWT Authentication is a **stateless** authentication mechanism.
- After login, the server generates a JWT and returns it to the client.
- The client sends the token in the `Authorization: Bearer <token>` header.
- A custom `JwtAuthenticationFilter` validates the token for every request.
- After successful validation, Spring stores the authenticated user in the `SecurityContextHolder`.
- Configure `SessionCreationPolicy.STATELESS` for JWT-based applications.
- JWT Authentication is ideal for REST APIs and Microservices.