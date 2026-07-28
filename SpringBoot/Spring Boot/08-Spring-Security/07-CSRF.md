# CSRF (Cross-Site Request Forgery)

## What is CSRF?

**CSRF (Cross-Site Request Forgery)** is a security attack where a malicious website tricks an **already authenticated user** into performing unwanted actions on another trusted website.

It exploits the fact that the browser automatically sends cookies (session cookies) with every request.

> **In simple words:**
>
> CSRF tricks a logged-in user into doing something they never intended to do.

---

# Why Do We Need CSRF Protection?

Imagine you are logged into your bank.

```
bank.com
```

Your browser stores the login session.

Now you visit a malicious website.

```
evil.com
```

That website secretly sends:

```
POST /transfer

Amount = $1000

To = Hacker
```

Since your browser automatically sends the session cookie,

the bank thinks:

```
"This request came from the authenticated user."
```

Money gets transferred without your permission.

---

# Real-Life Example

Imagine you have an office ID card.

```
Employee

↓

Office Entry

↓

ID Verified

↓

Inside Office
```

Now someone secretly hands your ID card to another person.

The security guard sees the valid ID card and allows entry.

Similarly,

the browser automatically sends your session cookie.

The server trusts the cookie unless additional verification exists.

---

# How CSRF Attack Works

```
User

↓

Login to Bank

↓

Session Cookie Stored

↓

Visit Malicious Website

↓

Hidden Form Submitted

↓

Browser Sends Session Cookie

↓

Bank Server

↓

Request Accepted

↓

Money Transferred
```

---

# Example Without CSRF Protection

Bank Transfer API

```http
POST /transfer
```

Hidden HTML

```html
<form action="https://bank.com/transfer" method="POST">

    <input type="hidden" name="amount" value="1000">

    <input type="hidden" name="account" value="987654321">

</form>

<script>

    document.forms[0].submit();

</script>
```

The user never clicks anything.

The browser automatically submits the form.

---

# Why Does This Happen?

Because browsers automatically include:

```
Session Cookie
```

with every request.

```
Browser

↓

Request

+

Session Cookie

↓

Server
```

The server cannot determine whether the request originated from the genuine website or a malicious one.

---

# How CSRF Protection Works

Spring Security generates a unique **CSRF Token**.

```
Browser

↓

GET Login Page

↓

Server

↓

Generate CSRF Token

↓

Browser Stores Token
```

Every POST, PUT, PATCH, or DELETE request must include this token.

---

# CSRF Protection Flow

```
User

↓

Open Website

↓

Server Generates CSRF Token

↓

Browser Stores Token

↓

Submit Form

↓

Request Contains Token?

↓

Yes

↓

Request Accepted

OR

↓

403 Forbidden
```

---

# CSRF Token

Example Token

```
X9A81JKM3QW45ZP
```

Every modifying request includes this token.

```
POST /transfer

↓

CSRF Token

↓

Server Verification

↓

Success
```

---

# Spring Security Default Behavior

By default,

Spring Security **enables CSRF protection**.

```
spring-boot-starter-security

↓

CSRF Enabled
```

This is especially useful for:

- Traditional MVC Applications
- Server-side rendered applications
- Session-based authentication

---

# Disabling CSRF

For REST APIs using JWT,

CSRF is usually disabled.

```java
@Bean
public SecurityFilterChain securityFilterChain(

        HttpSecurity http

) throws Exception {

    http

        .csrf(csrf -> csrf.disable());

    return http.build();

}
```

---

# Why is CSRF Disabled for JWT?

JWT Authentication is **stateless**.

```
Client

↓

JWT Token

↓

Authorization Header

↓

Server
```

The browser does **not** automatically send the JWT.

Therefore,

CSRF attacks are generally not possible in the same way as session-based authentication.

---

# Session Authentication vs JWT Authentication

## Session Authentication

```
Browser

↓

Session Cookie

↓

Automatically Sent

↓

CSRF Possible
```

---

## JWT Authentication

```
Browser

↓

Authorization Header

↓

Added Explicitly

↓

CSRF Not Required
```

---

# Request Flow With CSRF

```
Client

↓

POST Request

↓

CSRF Token Present?

↓

Yes

↓

Security Filter Chain

↓

Controller

↓

Response

OR

↓

403 Forbidden
```

---

# Request Flow Without CSRF Token

```
POST Request

↓

No CSRF Token

↓

Security Filter Chain

↓

Request Rejected

↓

403 Forbidden
```

---

# CSRF vs XSS

| CSRF | XSS |
|------|-----|
| Tricks authenticated users | Injects malicious JavaScript |
| Exploits browser cookies | Exploits vulnerable web pages |
| Sends unauthorized requests | Steals user information or executes scripts |
| Prevented using CSRF tokens | Prevented by input validation and output encoding |

---

# CSRF vs CORS

| CSRF | CORS |
|------|------|
| Protects against forged requests | Controls cross-origin access |
| Related to authentication cookies | Related to browser security policy |
| Uses CSRF Tokens | Uses HTTP headers |
| Prevents unauthorized actions | Prevents unauthorized cross-origin communication |

---

# When Should CSRF Be Enabled?

| Application Type | CSRF |
|------------------|------|
| Spring MVC | ✅ Enable |
| Thymeleaf | ✅ Enable |
| JSP | ✅ Enable |
| Session Authentication | ✅ Enable |
| REST API with JWT | ❌ Usually Disabled |

---

# Real-World Example

## Banking Website

```
Login

↓

Session Cookie

↓

Transfer Money

↓

CSRF Token Verified

↓

Transfer Successful
```

---

## Shopping Website

```
Logged In

↓

Place Order

↓

CSRF Token Verified

↓

Order Created
```

---

## REST API

```
JWT Authentication

↓

Authorization Header

↓

CSRF Disabled
```

---

# Advantages of CSRF Protection

- Prevents forged requests.
- Protects authenticated users.
- Prevents unauthorized transactions.
- Enabled by default in Spring Security.
- Easy to integrate.

---

# Best Practices

- Keep CSRF enabled for session-based applications.
- Disable CSRF only for stateless REST APIs using JWT.
- Never disable CSRF without understanding the authentication mechanism.
- Use HTTPS to protect session cookies.
- Combine CSRF protection with secure authentication and authorization.

---

# Interview Questions

### 1. What is CSRF?

CSRF (Cross-Site Request Forgery) is an attack where a malicious website tricks an authenticated user into performing unwanted actions.

---

### 2. Why is CSRF possible?

Because browsers automatically send session cookies with requests.

---

### 3. How does Spring Security prevent CSRF attacks?

By generating and validating a unique CSRF token for state-changing requests.

---

### 4. Is CSRF enabled by default in Spring Security?

Yes.

CSRF protection is enabled by default.

---

### 5. Why is CSRF usually disabled for JWT authentication?

Because JWT is sent in the `Authorization` header rather than automatically as a browser session cookie, making traditional CSRF attacks ineffective.

---

### 6. Which HTTP requests require CSRF protection?

Generally, requests that modify data, such as:

- POST
- PUT
- PATCH
- DELETE

---

### 7. What HTTP status is returned when the CSRF token is missing or invalid?

```
403 Forbidden
```

---

# Quick Revision

- CSRF stands for **Cross-Site Request Forgery**.
- It tricks authenticated users into sending unwanted requests.
- Browsers automatically send session cookies, making CSRF possible.
- Spring Security enables CSRF protection by default.
- CSRF protection uses a unique token to validate requests.
- Keep CSRF enabled for session-based applications.
- Disable CSRF only for stateless JWT-based REST APIs.
- Missing or invalid CSRF tokens result in **403 Forbidden**.