# Authentication

## What is Authentication?

**Authentication** is the process of **verifying the identity of a user** before allowing access to an application or system.

It answers the question:

> **"Who are you?"**

When a user enters their username and password, the application checks whether the credentials are correct. If they are valid, the user is authenticated.

> **In simple words:**
>
> Authentication is the process of proving your identity.

---

# Why Do We Need Authentication?

Without authentication:

- Anyone can access sensitive data.
- Unauthorized users can modify or delete information.
- Personal and financial information becomes insecure.

Authentication ensures that only legitimate users can access protected resources.

---

# Real-World Example

### ATM Machine

```
Insert ATM Card

↓

Enter PIN

↓

PIN Verified?

↓

Yes

↓

Access Bank Account

OR

No

↓

Access Denied
```

The ATM first verifies your identity before allowing transactions.

---

### Gmail Login

```
Enter Email

↓

Enter Password

↓

Google Verifies Credentials

↓

Login Successful
```

---

### Netflix

```
Username

↓

Password

↓

Authentication

↓

Watch Movies
```

---

# Authentication Flow

```
User

↓

Enter Username & Password

↓

Application

↓

Authentication Manager

↓

User Details Service

↓

Database

↓

Credentials Match?

↓

Yes

↓

Authenticated User

OR

No

↓

Authentication Failed
```

---

# Authentication in Spring Security

Spring Security automatically provides authentication support.

Typical flow:

```
Client

↓

Login Request

↓

Spring Security Filter Chain

↓

Authentication Manager

↓

UserDetailsService

↓

Database

↓

PasswordEncoder

↓

Authenticated User
```

---

# Authentication vs Authorization

| Authentication | Authorization |
|---------------|---------------|
| Verifies identity | Verifies permissions |
| "Who are you?" | "What can you access?" |
| Happens first | Happens after authentication |
| Login process | Access control |
| Example: Username & Password | Example: Admin can delete users |

---

# Types of Authentication

## 1. Username & Password Authentication

Most common authentication method.

```
Username

+

Password

↓

Verified

↓

Login Success
```

Example:

- Facebook
- Gmail
- LinkedIn

---

## 2. OTP Authentication

User receives a One-Time Password.

```
Enter Mobile Number

↓

Receive OTP

↓

Verify OTP

↓

Login
```

Example:

- Banking Apps
- UPI Apps

---

## 3. Biometric Authentication

Uses unique physical characteristics.

Examples:

- Fingerprint
- Face Recognition
- Iris Scan

```
Fingerprint

↓

Verified

↓

Login
```

---

## 4. Multi-Factor Authentication (MFA)

Uses more than one verification method.

```
Password

+

OTP

↓

Authentication
```

Example:

- Google Account
- Microsoft Account

---

## 5. Token-Based Authentication

After successful login:

```
Login

↓

Server Generates Token

↓

Client Stores Token

↓

Token Sent With Every Request

↓

User Verified
```

Example:

- JWT Authentication

---

## 6. Session-Based Authentication

After login:

```
Login

↓

Server Creates Session

↓

Session ID Stored

↓

Browser Sends Session ID

↓

User Verified
```

Used in traditional web applications.

---

# Authentication Process

```
User

↓

Enter Credentials

↓

Server

↓

Validate Credentials

↓

Valid?

↓

Yes

↓

Create Session / Token

↓

Access Granted

OR

No

↓

Access Denied
```

---

# Authentication Components in Spring Security

## AuthenticationManager

Responsible for authenticating users.

```
AuthenticationManager

↓

Authenticate Request
```

---

## UserDetailsService

Loads user information.

```java
UserDetails loadUserByUsername(String username);
```

---

## UserDetails

Represents the authenticated user.

Contains:

- Username
- Password
- Roles
- Authorities
- Account Status

---

## PasswordEncoder

Compares encrypted passwords.

```
Raw Password

↓

Encode

↓

Compare

↓

Match?
```

---

# Authentication Lifecycle

```
Client

↓

HTTP Request

↓

Security Filter Chain

↓

AuthenticationManager

↓

UserDetailsService

↓

Database

↓

PasswordEncoder

↓

Authenticated User

↓

Controller
```

---

# Successful Authentication

```
Username = admin

Password = admin123

↓

Credentials Match

↓

Authenticated

↓

Access Granted
```

---

# Failed Authentication

```
Username = admin

Password = wrong123

↓

Credentials Don't Match

↓

Authentication Failed

↓

401 Unauthorized
```

---

# HTTP Status Codes

| Status Code | Meaning |
|-------------|---------|
| 200 | Authentication Successful |
| 401 | Unauthorized (Invalid Credentials) |
| 403 | Authenticated but Access Forbidden |

---

# Session Authentication vs Token Authentication

| Session | Token |
|---------|-------|
| Server stores session | Client stores token |
| Uses Session ID | Uses JWT or similar token |
| Suitable for traditional web apps | Suitable for REST APIs |
| Requires server memory | Stateless |

---

# Common Authentication Methods

| Method | Example |
|---------|---------|
| Username & Password | Gmail |
| OTP | Banking Apps |
| Fingerprint | Mobile Unlock |
| Face ID | iPhone |
| JWT | REST APIs |
| OAuth2 | Login with Google |

---

# Authentication Architecture

```
             User

              │

              ▼

      Login Request

              │

              ▼

 Spring Security Filter Chain

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

 PasswordEncoder

              │

              ▼

 Authentication Success

              │

              ▼

 Protected Resource
```

---

# Real-World Example

## Banking Application

```
Customer

↓

Login

↓

Username & Password

↓

Authentication

↓

Transfer Money
```

---

## E-Commerce Website

```
Customer

↓

Login

↓

Authentication

↓

Place Order
```

---

## College Portal

```
Student

↓

Login

↓

Authentication

↓

View Results
```

---

# Advantages

- Protects sensitive information.
- Prevents unauthorized access.
- Verifies user identity.
- Enables secure communication.
- Foundation of application security.

---

# Best Practices

- Always encrypt passwords using `PasswordEncoder`.
- Never store plain-text passwords.
- Use HTTPS for login requests.
- Enable Multi-Factor Authentication for sensitive applications.
- Use JWT for stateless REST APIs.
- Implement account lockout after repeated failed login attempts.
- Use strong password policies.

---

# Interview Questions

### 1. What is Authentication?

Authentication is the process of verifying the identity of a user before granting access to an application.

---

### 2. What is the difference between Authentication and Authorization?

Authentication verifies **who the user is**, while Authorization determines **what the authenticated user is allowed to access**.

---

### 3. What are the common types of Authentication?

- Username & Password
- OTP
- Biometric
- Multi-Factor Authentication (MFA)
- Session-Based Authentication
- Token-Based Authentication (JWT)

---

### 4. Which Spring Security component authenticates a user?

```java
AuthenticationManager
```

---

### 5. What is the role of `UserDetailsService`?

It loads user information such as username, password, and roles from the database.

---

### 6. Why is `PasswordEncoder` used?

It securely hashes passwords and compares hashed passwords during authentication.

---

### 7. What is the difference between Session-Based and Token-Based Authentication?

Session-Based Authentication stores session information on the server, whereas Token-Based Authentication uses tokens (such as JWT) and is stateless.

---

# Quick Revision

- Authentication verifies **who the user is**.
- It always happens **before Authorization**.
- Spring Security uses `AuthenticationManager` to authenticate users.
- `UserDetailsService` loads user information from the database.
- `PasswordEncoder` securely verifies passwords.
- Common authentication methods include Username & Password, OTP, Biometric, Session-Based, and JWT.
- Successful authentication allows access to protected resources, while failed authentication returns **401 Unauthorized**.