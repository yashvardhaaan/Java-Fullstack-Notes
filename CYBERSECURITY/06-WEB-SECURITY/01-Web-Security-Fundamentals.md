# `01-Web-Security-Fundamentals.md`

# Web Security Fundamentals

## 1. First Principle

**Web security is about protecting web applications, APIs, users, and data from unauthorized access or manipulation.**

A web application has three major components:

```text
User / Browser
      ↓
Frontend
      ↓
Backend / API
      ↓
Database / External Services
```

An attacker can target **any layer**.

---

# 2. What Happens When You Open a Website?

Example:

```text
https://example.com/login
```

Basic flow:

```text
Browser
   ↓
DNS
   ↓
TCP/TLS Connection
   ↓
HTTP Request
   ↓
Web Server
   ↓
Application
   ↓
Database
   ↓
HTTP Response
   ↓
Browser
```

Every step creates potential security concerns.

---

# 3. CIA Triad in Web Security

### Confidentiality

Only authorized users can access information.

Example:

```text
User A ❌ cannot access User B's private orders
```

### Integrity

Data cannot be modified without authorization.

Example:

```text
₹500 payment
```

must not silently become:

```text
₹50,000
```

### Availability

The application should remain accessible to legitimate users.

Example:

```text
DDoS
```

can attack availability.

---

# 4. Authentication vs Authorization

These are fundamental concepts.

### Authentication

**Who are you?**

```text
Username + Password
       ↓
Authentication
       ↓
User identified
```

### Authorization

**What are you allowed to do?**

```text
Authenticated User
       ↓
Authorization
       ↓
Can this user access /admin?
```

Example:

```text
User
→ Can view own profile

Admin
→ Can manage users
```

A common vulnerability is correctly authenticating a user but failing to enforce authorization.

---

# 5. Attack Surface

The **attack surface** is everything an attacker can interact with.

Example web application:

```text
Login
Registration
Search
File Upload
API
Admin Panel
Cookies
Headers
Webhooks
Database
Third-party APIs
```

More exposed functionality generally means more opportunities for mistakes.

---

# 6. Input Is Untrusted

One of the most important web-security principles:

> **Never automatically trust data received from the client.**

Example:

```http
GET /user?id=123
```

The server should not assume:

```text
id=123
```

is safe or authorized.

An attacker could try:

```http
GET /user?id=124
```

The application must verify whether the authenticated user is allowed to access user `124`.

---

# 7. Client vs Server Trust

The browser is controlled by the user.

Therefore:

```javascript
if (isAdmin) {
    showAdminPanel();
}
```

is **not a security control**.

An attacker can modify client-side JavaScript or send requests directly.

Security decisions must happen on the server:

```text
Browser
   ↓
Request
   ↓
Server
   ↓
Authentication
   ↓
Authorization
   ↓
Action
```

---

# 8. HTTP Security Fundamentals

HTTP contains:

```text
Request
+
Response
```

Example request:

```http
GET /profile HTTP/1.1
Host: example.com
Cookie: session=abc123
```

Example response:

```http
HTTP/1.1 200 OK
Content-Type: text/html
```

Security vulnerabilities often involve manipulating:

```text
URL
Parameters
Headers
Cookies
Request body
HTTP methods
```

---

# 9. Common Web Vulnerability Categories

The upcoming files cover major vulnerability classes:

```text
Authentication
Cookies / Sessions
CORS
CSRF
XSS
SQL Injection
Command Injection
Path Traversal
File Upload
SSRF
XXE
Deserialization
Request Smuggling
Race Conditions
Prototype Pollution
Clickjacking
Open Redirect
Security Misconfiguration
```

These are not isolated concepts.

They often interact.

---

# 10. Example — E-Commerce Application

Consider:

```text
Food Delivery Application
```

Architecture:

```text
React Frontend
      ↓
Spring Boot API
      ↓
Authentication
      ↓
PostgreSQL
      ↓
Razorpay / Other Services
```

Potential security issues:

```text
Login
→ Authentication vulnerabilities

Cookies
→ Session theft

Order API
→ Authorization problems

Search
→ SQL Injection

Image upload
→ File upload vulnerabilities

Webhook
→ SSRF / authentication issues

Frontend
→ XSS

Admin API
→ Broken access control
```

Security must therefore be considered across the entire application.

---

# 11. OWASP

**OWASP — Open Worldwide Application Security Project**

OWASP provides widely used guidance for application security.

The **OWASP Top 10** is particularly useful for learning common web application risks.

However:

> Don't memorize vulnerability names only. Understand the underlying cause, exploitation concept, impact, and mitigation.

---

# 12. Secure Development Lifecycle

Security should be included throughout development.

```text
Requirements
     ↓
Design
     ↓
Development
     ↓
Security Testing
     ↓
Deployment
     ↓
Monitoring
     ↓
Incident Response
```

Not:

```text
Build everything
     ↓
"Let's check security at the end."
```

---

# 13. Industry-Level Example — Broken Access Control

Suppose:

```http
GET /api/orders/1001
```

belongs to User A.

User B changes the request:

```http
GET /api/orders/1002
```

If the server returns User A's order without checking ownership:

```text
User B
  ↓
Modified ID
  ↓
Server
  ↓
Unauthorized data
```

This is a serious access-control problem.

The server should perform something conceptually like:

```text
Authenticated User
        ↓
Does user own order 1002?
        ↓
     Yes → Allow
     No  → Deny
```

This principle will become important throughout this section.

---

# 14. Defense in Depth

Don't rely on one security control.

Example:

```text
Authentication
      +
Authorization
      +
Input Validation
      +
Parameterized Queries
      +
HTTPS
      +
Secure Headers
      +
Logging
      +
Monitoring
```

If one control fails, additional controls can reduce the impact.

---

# 15. Web Security Testing Mindset

When assessing an application, think:

### 1. What can I control?

```text
Parameters
Headers
Cookies
Request body
Files
URLs
```

### 2. What does the server trust?

```text
User ID?
Role?
Filename?
Redirect URL?
Content-Type?
```

### 3. What should I be allowed to access?

```text
Own resources
vs
Other users' resources
```

### 4. What happens when input is unexpected?

```text
Malformed
Very large
Unexpected type
Missing
Duplicate
Special characters
```

This mindset is more valuable than memorizing payloads.

---

# 16. Small Hands-On Lab

You can inspect HTTP requests using browser Developer Tools.

Open:

```text
Chrome
→ F12
→ Network
```

Then visit a website you own or are authorized to test.

Inspect:

```text
Request URL
HTTP Method
Status Code
Request Headers
Response Headers
Cookies
Request Body
Response Body
```

Example:

```text
GET /api/products
Status: 200
Content-Type: application/json
```

Try to understand:

```text
Browser
   ↓
HTTP Request
   ↓
Server
   ↓
HTTP Response
```

This becomes the foundation for all subsequent web-security topics.

---

# 17. SOC Relevance

Web attacks generate useful security telemetry.

A SOC analyst may investigate:

```text
大量 failed logins
Unusual API requests
Suspicious user-agent strings
Repeated 4xx/5xx responses
Unexpected admin access
SQL error patterns
Large numbers of requests
Unexpected outbound connections
```

Important principle:

> A single suspicious request is often only a clue. Correlating requests, authentication events, process activity, and network logs provides stronger evidence.

---

# 18. Interview Questions

### Q1. What is web security?

Protecting web applications, APIs, users, and data against unauthorized access, modification, disruption, and abuse.

### Q2. Authentication vs authorization?

```text
Authentication
→ Who are you?

Authorization
→ What are you allowed to do?
```

### Q3. Why can't frontend validation be trusted?

Because the client is controlled by the user and requests can be modified or generated independently of the UI.

### Q4. What is an attack surface?

The collection of exposed interfaces, functionality, services, and inputs that an attacker can interact with.

### Q5. Why is input considered untrusted?

Because it originates outside the trusted server-side security boundary.

### Q6. What is defense in depth?

Using multiple independent security controls instead of relying on a single protection.

---

# 19. Quick Cheat Sheet

```text
Web Security
→ Protect applications + APIs + users + data

Authentication
→ Who are you?

Authorization
→ What can you access?

Attack Surface
→ Everything exposed to interaction

Client
→ Untrusted

Server
→ Enforce security decisions

Input
→ Never blindly trust

CIA
→ Confidentiality
→ Integrity
→ Availability

Defense in Depth
→ Multiple security controls

OWASP
→ Important application-security guidance
```

## Core Mental Model

```text
                 WEB APPLICATION
                       |
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
     Browser          API          Database
        |              |              |
        └──────────────┼──────────────┘
                       ↓
                 Security Controls
                       ↓
        Authentication + Authorization
        Input Validation + Secure Coding
        Encryption + Logging + Monitoring
```

**Next:** `02-HTTP-Request-Response.md`