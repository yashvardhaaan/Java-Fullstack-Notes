# Secrets Management

## What is Secrets Management?

**Secrets Management** is the practice of securely storing, accessing, and managing sensitive information used by an application.

Examples of secrets include:

- Database Passwords
- API Keys
- JWT Secret Keys
- AWS Access Keys
- OAuth Client Secret
- SMTP Passwords

> **In simple words:**
>
> Secrets Management keeps sensitive information secure instead of storing it directly in your code.

---

# Why Do We Need Secrets Management?

Suppose you build a banking application.

Bad Practice

```properties
spring.datasource.password=admin123

jwt.secret=mySecretKey

aws.secret=abcd1234
```

If this project is pushed to GitHub,

everyone can see these secrets.

Problems

- Database can be compromised.
- API keys can be stolen.
- Attackers can access cloud resources.
- Huge security risk.

Instead,

store secrets outside the application.

---

# Real-World Example

Imagine you own a house.

```
House Key

↓

Keep Inside a Safe
```

Not

```
House Key

↓

Tape It to the Front Door
```

Similarly,

never store passwords or secret keys inside your source code.

---

# What is a Secret?

A **Secret** is any sensitive information that should only be accessible to authorized users or applications.

Examples

```
Database Password

↓

Secret
```

```
JWT Secret

↓

Secret
```

```
API Key

↓

Secret
```

---

# Where Should Secrets Be Stored?

Recommended locations:

```
Environment Variables
```

```
Docker Secrets
```

```
Kubernetes Secrets
```

```
AWS Secrets Manager
```

```
HashiCorp Vault
```

```
Azure Key Vault
```

```
Google Secret Manager
```

---

# How Secrets Management Works

```
Application

↓

Needs Database Password

↓

Secret Manager

↓

Return Secret

↓

Connect Database
```

The application never hardcodes the password.

---

# Hardcoded Secret (Bad Practice)

```java
String jwtSecret =
        "mySuperSecret123";
```

Problems

- Visible in source code.
- Can be committed to Git.
- Difficult to rotate.
- Security risk.

---

# Using Environment Variables

Operating System

```
JWT_SECRET=mySecretKey

DB_PASSWORD=password
```

application.properties

```properties
jwt.secret=${JWT_SECRET}

spring.datasource.password=${DB_PASSWORD}
```

Spring Boot reads the values at startup.

---

# Secret Loading Flow

```
Operating System

↓

Environment Variable

↓

Spring Environment

↓

Application

↓

Business Logic
```

---

# Using Docker Secrets

Docker

```
Secret

↓

Container

↓

Spring Boot

↓

Application
```

Example

```bash
docker secret create db_password password.txt
```

The application reads the secret from Docker.

---

# Using Kubernetes Secrets

Example

```yaml
apiVersion: v1

kind: Secret

metadata:
  name: database-secret

type: Opaque

data:
  username: cm9vdA==

  password: cGFzc3dvcmQ=
```

The application can access these values as environment variables or mounted files.

---

# Using AWS Secrets Manager

Flow

```
Spring Boot

↓

AWS Secrets Manager

↓

Retrieve Secret

↓

Application
```

Secrets remain outside the application code.

---

# Using HashiCorp Vault

```
Spring Boot

↓

Vault

↓

Authentication

↓

Retrieve Secret

↓

Application
```

Vault is widely used in enterprise applications.

---

# Secret Rotation

A secret should not remain the same forever.

Example

```
Old Password

↓

Rotate

↓

New Password

↓

Application Uses New Secret
```

Benefits

- Reduces security risks.
- Limits damage if a secret is leaked.

---

# Secrets vs Configuration Properties

| Configuration Property | Secret |
|------------------------|--------|
| Server Port | Database Password |
| Application Name | JWT Secret |
| Logging Level | API Key |
| Feature Flags | OAuth Client Secret |

Not every configuration value is a secret.

---

# Secrets vs Environment Variables

| Environment Variables | Secrets Manager |
|-----------------------|-----------------|
| Good for small projects | Better for production |
| Managed by operating system | Managed by a dedicated service |
| Simple to use | Supports auditing and rotation |
| Limited security features | Enterprise-grade security |

---

# Common Secrets

| Secret | Example |
|---------|----------|
| Database Password | MySQL Password |
| JWT Secret | Signing Key |
| API Key | Payment Gateway Key |
| OAuth Client Secret | Google OAuth Secret |
| SMTP Password | Email Server Password |
| AWS Secret Key | Cloud Authentication |

---

# Security Risks of Hardcoding Secrets

```
Developer

↓

Push Code

↓

GitHub Repository

↓

Password Exposed
```

Possible consequences

- Database compromise.
- Unauthorized cloud access.
- Financial loss.
- Data breach.

---

# Secure Architecture

```
Application

↓

Secret Manager

↓

Retrieve Secret

↓

Use Secret

↓

Never Store in Source Code
```

---

# Real-World Example

## Banking Application

```
Database Password

↓

AWS Secrets Manager

↓

Spring Boot

↓

Database
```

---

## E-Commerce Application

```
Payment API Key

↓

Vault

↓

Payment Service
```

---

## Email Service

```
SMTP Password

↓

Environment Variable

↓

Spring Boot

↓

Mail Server
```

---

# Advantages

- Improves application security.
- Prevents accidental exposure of passwords.
- Supports secret rotation.
- Works with cloud platforms.
- Keeps sensitive data out of source code.

---

# Best Practices

- Never hardcode secrets in Java code.
- Never commit secrets to Git repositories.
- Use Environment Variables for local development.
- Use a dedicated Secrets Manager in production.
- Rotate secrets regularly.
- Apply the principle of least privilege.
- Restrict access to secrets.
- Audit secret usage.

---

# Interview Questions

### 1. What is Secrets Management?

Secrets Management is the secure storage and management of sensitive information such as passwords, API keys, and encryption keys.

---

### 2. Why should secrets never be stored in source code?

Because source code may be shared, committed to version control, or accessed by unauthorized users, exposing sensitive information.

---

### 3. What are examples of secrets?

- Database passwords
- JWT secret keys
- API keys
- OAuth client secrets
- Cloud access keys

---

### 4. Where should secrets be stored?

Common options include:

- Environment Variables
- AWS Secrets Manager
- HashiCorp Vault
- Azure Key Vault
- Google Secret Manager
- Docker Secrets
- Kubernetes Secrets

---

### 5. What is secret rotation?

Secret rotation is the process of periodically replacing old secrets with new ones to improve security.

---

### 6. Are all configuration properties secrets?

No.

Properties like server ports and application names are configuration values, while passwords, API keys, and signing keys are secrets.

---

### 7. Which approach is recommended for production?

Use a dedicated Secrets Management solution such as AWS Secrets Manager or HashiCorp Vault instead of storing secrets in source code or configuration files.

---

# Quick Revision

- Secrets Management securely stores sensitive application data.
- Examples include database passwords, API keys, JWT secrets, and cloud credentials.
- Never hardcode secrets or commit them to Git.
- Use Environment Variables for development.
- Use AWS Secrets Manager, HashiCorp Vault, or similar services in production.
- Rotate secrets regularly.
- Restrict access to secrets using the principle of least privilege.
- Secrets are different from normal configuration properties like server ports or application names.