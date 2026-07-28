# OAuth2 Basics

## What is OAuth2?

**OAuth 2.0** is an **authorization framework** that allows a user to grant a third-party application limited access to their resources **without sharing their password**.

It is commonly used for:

- Login with Google
- Login with GitHub
- Login with Facebook
- Login with Microsoft

> **In simple words:**
>
> OAuth2 lets another application access your information **without giving it your password**.

---

# Why Do We Need OAuth2?

Imagine you want to sign in to a website.

Without OAuth2

```
New Website

↓

Enter Google Password

↓

Website Stores Password
```

Problems

- Password shared with third-party website.
- Security risk.
- Difficult to manage.

---

With OAuth2

```
Website

↓

Redirect to Google

↓

Google Verifies User

↓

Google Sends Authorization

↓

Website Logs In User
```

The website **never knows your Google password**.

---

# Real-World Example

Imagine visiting a hotel.

Instead of giving the hotel the **key to your house**,

you give them a **temporary visitor pass**.

```
House Key

↓

Full Access

❌ Never Share
```

Instead

```
Visitor Pass

↓

Limited Access

↓

Temporary

↓

Safe
```

OAuth2 works in the same way.

---

# Authentication vs Authorization

## Authentication

```
Who are you?
```

Example

```
Username

+

Password
```

---

## Authorization

```
What are you allowed to access?
```

Example

```
View Email

✓

Delete Email

✗
```

OAuth2 is primarily an **Authorization Framework**.

Although it is commonly used for login, the actual authentication is usually handled by the identity provider (Google, GitHub, etc.).

---

# OAuth2 Roles

OAuth2 has four main participants.

```
User

↓

Client Application

↓

Authorization Server

↓

Resource Server
```

---

## 1. Resource Owner

The person who owns the data.

Example

```
You
```

---

## 2. Client

The application requesting access.

Example

```
Shopping Website

↓

Login with Google
```

---

## 3. Authorization Server

Authenticates the user and issues tokens.

Examples

- Google
- GitHub
- Microsoft

---

## 4. Resource Server

Stores protected resources.

Example

```
Google APIs

↓

User Profile

↓

Email

↓

Photos
```

---

# OAuth2 Architecture

```
          User

            │

            ▼

 Client Application

            │

            ▼

Authorization Server

            │

            ▼

 Access Token

            │

            ▼

 Resource Server

            │

            ▼

 Protected Resource
```

---

# OAuth2 Login Flow

```
User

↓

Click

"Login with Google"

↓

Redirect to Google

↓

Enter Credentials

↓

Google Verifies User

↓

User Grants Permission

↓

Authorization Code

↓

Application

↓

Exchange Code

↓

Access Token

↓

Access User Information

↓

Login Successful
```

---

# Step-by-Step Flow

## Step 1

User clicks

```
Login with Google
```

---

## Step 2

Application redirects to

```
accounts.google.com
```

---

## Step 3

User enters Google credentials.

Google authenticates the user.

---

## Step 4

Google asks

```
Allow this application

to access your profile?
```

User chooses

```
Allow
```

---

## Step 5

Google returns an

```
Authorization Code
```

---

## Step 6

Application exchanges the code for an

```
Access Token
```

---

## Step 7

Application uses the

```
Access Token
```

to access the user's information.

---

# OAuth2 Tokens

OAuth2 commonly uses two types of tokens.

## Access Token

Used to access protected resources.

Example

```
Authorization:

Bearer ACCESS_TOKEN
```

Usually expires quickly.

---

## Refresh Token

Used to obtain a new Access Token without requiring the user to log in again.

Flow

```
Access Token Expires

↓

Refresh Token

↓

New Access Token
```

---

# Authorization Code Flow

This is the **most commonly used OAuth2 flow** for web applications.

```
User

↓

Login with Google

↓

Authorization Code

↓

Application

↓

Access Token

↓

Google API
```

---

# OAuth2 vs JWT

| OAuth2 | JWT |
|---------|-----|
| Authorization framework | Token format |
| Defines authorization process | Stores user information |
| Can issue JWT tokens | Can be used inside OAuth2 |
| Used for third-party login | Used for authentication and authorization |

---

# OAuth2 vs Session Authentication

| OAuth2 | Session Authentication |
|---------|------------------------|
| Uses tokens | Uses server sessions |
| Supports third-party login | Traditional login |
| Stateless communication | Stateful communication |
| Works well for APIs | Common in MVC applications |

---

# OAuth2 in Spring Boot

Add dependency

```xml
<dependency>

    <groupId>

        org.springframework.boot

    </groupId>

    <artifactId>

        spring-boot-starter-oauth2-client

    </artifactId>

</dependency>
```

---

# Basic Security Configuration

```java
@Bean
public SecurityFilterChain securityFilterChain(

        HttpSecurity http

) throws Exception {

    http

        .authorizeHttpRequests(auth -> auth

                .anyRequest()

                .authenticated()

        )

        .oauth2Login(Customizer.withDefaults());

    return http.build();

}
```

This enables OAuth2 login with the configured provider.

---

# OAuth2 Flow in Spring Security

```
User

↓

Login with Google

↓

Spring Security

↓

Google Authorization Server

↓

Authorization Code

↓

Access Token

↓

User Information

↓

Spring Security

↓

Application
```

---

# Real-World Examples

## Login with Google

```
User

↓

Google Login

↓

Google Authenticates

↓

Application Login
```

---

## Login with GitHub

```
Developer

↓

GitHub Login

↓

Access Granted

↓

Dashboard
```

---

## Login with Microsoft

```
Employee

↓

Microsoft Account

↓

Company Portal
```

---

# Advantages

- Users do not share passwords with third-party applications.
- Secure authorization mechanism.
- Supports Single Sign-On (SSO).
- Widely supported by major providers.
- Easy integration with Spring Security.
- Uses temporary tokens instead of permanent credentials.

---

# Best Practices

- Always use HTTPS.
- Prefer the Authorization Code Flow for web applications.
- Store client secrets securely.
- Request only the permissions (scopes) your application needs.
- Keep Access Tokens short-lived.
- Use Refresh Tokens for long sessions.
- Validate tokens before accessing protected resources.

---

# Interview Questions

### 1. What is OAuth2?

OAuth2 is an authorization framework that allows applications to access user resources without sharing the user's password.

---

### 2. Is OAuth2 an authentication protocol?

No.

OAuth2 is an **authorization framework**. Authentication is typically handled by the identity provider (such as Google or GitHub). OpenID Connect (OIDC) extends OAuth2 to provide standardized authentication.

---

### 3. What are the main roles in OAuth2?

- Resource Owner
- Client
- Authorization Server
- Resource Server

---

### 4. What is an Access Token?

An Access Token is used by the client application to access protected resources on behalf of the user.

---

### 5. What is a Refresh Token?

A Refresh Token is used to obtain a new Access Token after the current one expires, without requiring the user to log in again.

---

### 6. What is the most common OAuth2 flow for web applications?

The **Authorization Code Flow**.

---

### 7. What is the difference between OAuth2 and JWT?

OAuth2 defines the authorization process, while JWT is a token format that can carry user information. OAuth2 may use JWT as its access token format.

---

# Quick Revision

- OAuth2 is an **authorization framework**.
- It allows users to grant limited access without sharing passwords.
- Common providers include Google, GitHub, Microsoft, and Facebook.
- The main participants are Resource Owner, Client, Authorization Server, and Resource Server.
- The Authorization Code Flow is the most common flow for web applications.
- OAuth2 commonly uses Access Tokens and Refresh Tokens.
- JWT and OAuth2 are different concepts; OAuth2 can use JWT tokens internally.
- Spring Security enables OAuth2 login using `.oauth2Login()`.