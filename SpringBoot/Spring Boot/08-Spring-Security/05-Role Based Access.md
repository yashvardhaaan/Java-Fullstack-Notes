# Role Based Access

## What is Role Based Access?

**Role-Based Access Control (RBAC)** is an authorization mechanism where **permissions are assigned to roles**, and **roles are assigned to users**.

Instead of giving permissions directly to every user, we assign them a role like:

- ADMIN
- USER
- MANAGER
- EMPLOYEE

Each role has its own permissions.

> **In simple words:**
>
> Users are grouped into roles, and each role determines what the user can access.

---

# Why Do We Need Role Based Access?

Imagine an E-Commerce Application.

There are different users:

- Customer
- Seller
- Admin

Should every user be able to:

- Delete Products?
- View All Orders?
- Manage Users?

No.

Each user should only access the resources required for their role.

---

# Real-World Example

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

Access Denied
```

---

## Banking Application

```
Customer

↓

Transfer Money

↓

Allowed
```

```
Customer

↓

Delete Customer Account

↓

Access Denied
```

---

# Role Based Access Flow

```
User

↓

Login

↓

Authentication

↓

Load User Roles

↓

Request API

↓

Check Role

↓

Authorized?

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

# User → Role Relationship

```
Admin User

↓

ROLE_ADMIN
```

```
Normal User

↓

ROLE_USER
```

```
Manager

↓

ROLE_MANAGER
```

---

# How Spring Security Uses Roles

Spring Security stores roles with authenticated users.

Example

```
Username : yash

Role : ADMIN
```

When accessing:

```
/admin/dashboard
```

Spring checks:

```
Does user have ROLE_ADMIN?

↓

Yes

↓

Access Granted
```

---

# Configuring Role Based Access

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

                .requestMatchers("/")

                .permitAll()

                .requestMatchers("/admin/**")

                .hasRole("ADMIN")

                .requestMatchers("/user/**")

                .hasRole("USER")

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
.hasRole("ADMIN")
```

Only users with:

```
ROLE_ADMIN
```

can access the endpoint.

---

```java
.hasRole("USER")
```

Only users with:

```
ROLE_USER
```

can access the endpoint.

---

```java
.permitAll()
```

Anyone can access.

---

```java
.authenticated()
```

Only logged-in users can access.

---

# Role Checking Process

```
User Request

↓

Security Filter Chain

↓

Authentication

↓

Load Roles

↓

Required Role?

↓

User Has Role?

↓

Yes

↓

Controller

OR

↓

403 Forbidden
```

---

# Example

Suppose we have:

```
User

↓

ROLE_USER
```

Trying to access

```
/admin/users
```

Spring checks

```
Required Role

↓

ROLE_ADMIN

↓

User Role

↓

ROLE_USER

↓

Not Matched

↓

403 Forbidden
```

---

# Multiple Roles

A user can have multiple roles.

Example

```
ROLE_ADMIN

ROLE_MANAGER
```

Configuration

```java
.requestMatchers("/reports/**")

.hasAnyRole(

        "ADMIN",

        "MANAGER"

)
```

Both roles can access the endpoint.

---

# hasRole() vs hasAnyRole()

## hasRole()

Checks a single role.

```java
.hasRole("ADMIN")
```

Only ADMIN can access.

---

## hasAnyRole()

Checks multiple roles.

```java
.hasAnyRole(

        "ADMIN",

        "MANAGER"

)
```

Either ADMIN or MANAGER can access.

---

# Role Hierarchy

```
ROLE_ADMIN

│

├── Manage Users

├── Manage Products

├── Manage Orders

└── View Reports

ROLE_MANAGER

│

├── Manage Products

└── View Reports

ROLE_USER

│

├── Place Order

└── View Profile
```

Higher roles generally have more permissions.

---

# Role vs Authority

| Role | Authority |
|------|-----------|
| High-level permission | Fine-grained permission |
| Example: ADMIN | Example: DELETE_USER |
| Groups multiple permissions | Represents one permission |
| Easier to manage | More flexible |

---

# Database Example

## Users Table

| ID | Username |
|----|----------|
| 1 | yash |
| 2 | rahul |

---

## Roles Table

| ID | Role |
|----|------|
| 1 | ROLE_ADMIN |
| 2 | ROLE_USER |

---

## User_Roles Table

| User ID | Role ID |
|---------|---------|
| 1 | 1 |
| 2 | 2 |

---

# Request Flow

```
HTTP Request

↓

Security Filter Chain

↓

Authentication

↓

Load User Roles

↓

Authorization

↓

Role Match?

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

# Common Methods

| Method | Description |
|---------|-------------|
| `hasRole()` | Checks one role |
| `hasAnyRole()` | Checks multiple roles |
| `authenticated()` | Requires login |
| `permitAll()` | Public endpoint |
| `denyAll()` | Blocks everyone |

---

# Real-World Example

## Banking Application

```
Customer

↓

Transfer Money

↓

ROLE_USER

↓

Allowed
```

```
Admin

↓

Manage Accounts

↓

ROLE_ADMIN

↓

Allowed
```

---

## E-Commerce Website

```
Customer

↓

Buy Product

↓

ROLE_USER
```

```
Admin

↓

Delete Product

↓

ROLE_ADMIN
```

---

## Hospital Management

```
Doctor

↓

View Patient

↓

ROLE_DOCTOR
```

```
Receptionist

↓

Manage Billing

↓

ROLE_RECEPTIONIST
```

---

# Advantages

- Easy to manage permissions.
- Improves application security.
- Prevents unauthorized access.
- Reduces duplicate permission logic.
- Scales well for large applications.

---

# Best Practices

- Assign the minimum required role to each user.
- Avoid giving every user the ADMIN role.
- Use meaningful role names.
- Store roles in the database.
- Combine roles with authorities for complex applications.
- Protect all sensitive endpoints.

---

# Interview Questions

### 1. What is Role-Based Access Control (RBAC)?

RBAC is an authorization mechanism where permissions are assigned to roles, and users are assigned those roles.

---

### 2. Which Spring Security method checks a single role?

```java
.hasRole("ADMIN")
```

---

### 3. Which method allows multiple roles?

```java
.hasAnyRole("ADMIN", "MANAGER")
```

---

### 4. What HTTP status code is returned when a user lacks the required role?

```
403 Forbidden
```

---

### 5. What is the difference between Roles and Authorities?

Roles represent broad categories of access (such as ADMIN or USER), while authorities represent specific permissions (such as READ_PRODUCT or DELETE_USER).

---

### 6. Can one user have multiple roles?

Yes.

A user can be assigned multiple roles, and Spring Security checks whether any required role matches.

---

# Quick Revision

- Role-Based Access Control (RBAC) assigns permissions through roles.
- Common roles include `ROLE_ADMIN`, `ROLE_USER`, and `ROLE_MANAGER`.
- Use `hasRole()` to check one role.
- Use `hasAnyRole()` to allow multiple roles.
- Roles are checked **after Authentication** during Authorization.
- A user without the required role receives **403 Forbidden**.
- Store roles in the database for scalable applications.
- Follow the Principle of Least Privilege by granting only the permissions users actually need.