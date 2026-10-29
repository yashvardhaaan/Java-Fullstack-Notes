# `05-Authentication-and-Authorization.md`

```md
# Authentication and Authorization

Authentication and authorization are two of the most important security mechanisms.

> Authentication = Who are you?
>
> Authorization = What are you allowed to do?

---

# 1. Authentication

## What?

Authentication verifies the identity of a user, device, or service.

### First Principle

Ask:

> "Can I prove that this entity is really who it claims to be?"

Examples:

- Username + password
- OTP
- Biometrics
- Security key
- Certificate
- MFA

### Example

```text
User
 ↓
Username + Password
 ↓
Authentication
 ↓
Identity Verified
```

---

# 2. Authorization

## What?

Authorization determines what an authenticated user is allowed to access or perform.

### First Principle

Ask:

> "Now that I know who you are, what are you allowed to do?"

Example:

```text
Admin → Create/Delete users

Manager → View team information

Employee → View own information
```

---

# 3. Authentication vs Authorization

| Authentication | Authorization |
|---|---|
| Verifies identity | Determines permissions |
| "Who are you?" | "What can you access?" |
| Happens first | Happens after authentication |
| Password, OTP, biometrics | Roles, permissions, policies |

### Simple Example

You enter a company building.

```text
Security Guard
   ↓
Checks your ID
   ↓
Authentication
   ↓
You are an employee
   ↓
Access to allowed floors
   ↓
Authorization
```

---

# 4. Authentication Factors

Authentication can use different types of evidence.

### Something You Know

- Password
- PIN
- Security question

### Something You Have

- Phone
- Hardware security key
- Smart card

### Something You Are

- Fingerprint
- Face
- Iris

Using multiple factor types is called:

> Multi-Factor Authentication (MFA)

---

# 5. Why MFA Is Important

Suppose an attacker steals a password.

Without MFA:

```text
Stolen Password
      ↓
Login Successful
```

With MFA:

```text
Stolen Password
      ↓
MFA Required
      ↓
Attacker Cannot Provide Second Factor
      ↓
Access Blocked
```

MFA therefore reduces the impact of stolen credentials.

---

# 6. Authorization Models

## RBAC — Role-Based Access Control

Permissions are assigned to roles.

Example:

```text
Admin
 ↓
All administrative operations

Developer
 ↓
Development resources

Employee
 ↓
Basic resources
```

Common in enterprise applications.

---

## ABAC — Attribute-Based Access Control

Access depends on attributes.

Example:

```text
User = Employee
Location = Office
Time = Working Hours
Device = Company Laptop
```

Access may be allowed only when the required conditions are satisfied.

---

# 7. Real Industry Example

Consider a banking application.

```text
Customer Login
      ↓
Authentication
      ↓
Customer Identity Verified
      ↓
Authorization
      ↓
Can access own account
```

The customer should NOT be able to:

```text
View another customer's account
Change bank configuration
Create admin users
```

Even if the user is successfully authenticated.

---

# 8. Common Security Mistake

A system may correctly authenticate a user but incorrectly authorize them.

Example:

```text
GET /users/101
```

User 100 is logged in.

If the application allows user 100 to access user 101's information simply by changing the ID:

```text
/user/100
      ↓
/user/101
```

This can indicate **Broken Access Control / IDOR-type vulnerability**.

The problem is not authentication.

The problem is authorization.

---

# 9. Password Security

Never store passwords as plain text.

Bad:

```text
password = "mypassword123"
```

Instead, passwords should be securely hashed using appropriate password-hashing algorithms.

Conceptually:

```text
Password
   ↓
Password Hashing
   ↓
Stored Hash
```

During login:

```text
Entered Password
      ↓
Hash + Verification
      ↓
Stored Hash
      ↓
Match?
```

---

# 10. Security Analyst Checklist

When reviewing authentication and authorization, check:

- Is MFA enabled?
- Are passwords securely handled?
- Are accounts protected against brute force?
- Are sessions securely managed?
- Are permissions based on least privilege?
- Can users access other users' data?
- Are admin functions properly restricted?
- Are authorization failures logged?
- Are inactive accounts disabled?

---

# 11. Key Takeaways

- Authentication verifies identity.
- Authorization determines permissions.
- Authentication comes before authorization.
- MFA provides additional protection against stolen credentials.
- RBAC assigns permissions through roles.
- ABAC uses attributes and conditions.
- Successful authentication does NOT mean unlimited access.
- Authorization must be checked on every sensitive operation.
- Passwords should never be stored in plain text.

---

# Interview Questions

### Q1. What is authentication?

The process of verifying the identity of a user, device, or service.

### Q2. What is authorization?

The process of determining what an authenticated entity is allowed to access or perform.

### Q3. What is the difference?

Authentication asks:

> "Who are you?"

Authorization asks:

> "What are you allowed to do?"

### Q4. What is MFA?

Multi-Factor Authentication uses two or more different authentication factors to verify identity.

### Q5. What is RBAC?

Role-Based Access Control assigns permissions based on predefined roles.

### Q6. Can authentication be successful while authorization fails?

Yes. A user may be correctly authenticated but still not have permission to access a particular resource.
```

