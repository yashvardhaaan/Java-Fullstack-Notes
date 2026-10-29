# `21-Web-Attack-Methodology.md`

# Web Attack Methodology

## 1. First Principle

**Web Attack Methodology** is a structured process for assessing a web application for security weaknesses.

The goal is not:

> "Try random attacks."

The goal is:

> **Understand the application → identify attack surface → test security controls → validate impact → document findings.**

A practical methodology:

```text
Reconnaissance
      ↓
Attack Surface Mapping
      ↓
Authentication Testing
      ↓
Authorization Testing
      ↓
Input Validation Testing
      ↓
Business Logic Testing
      ↓
Configuration Testing
      ↓
Impact Validation
      ↓
Reporting
```

Only perform these activities against systems you own or have explicit authorization to test.

---

# 2. Phase 1 — Reconnaissance

First understand the application.

Identify:

```text
Domains
Subdomains
IP addresses
Technologies
APIs
Login pages
Public endpoints
Parameters
File uploads
WebSockets
```

Example:

```text
https://example.com
        ↓
/login
/api/users
/api/orders
/upload
/admin
```

Do not immediately attack anything.

---

# 3. Phase 2 — Attack Surface Mapping

Create an endpoint inventory.

Example:

| Endpoint | Method | Authentication | Input |
|---|---|---|---|
| `/login` | POST | No | username/password |
| `/profile` | GET | Yes | user ID |
| `/orders` | GET | Yes | order ID |
| `/upload` | POST | Yes | file |
| `/redirect` | GET | No | URL |

Then ask:

```text
What does this endpoint accept?
Who can access it?
What does it return?
What state does it change?
```

---

# 4. Phase 3 — Authentication Testing

Determine whether authentication is correctly implemented.

Check:

```text
Login
Logout
Password reset
Session management
MFA
Account lockout
Remember-me functionality
Token handling
```

Questions:

```text
Can authentication be bypassed?
Are sessions properly invalidated?
Are tokens unpredictable?
Does logout invalidate the session?
Is MFA enforced where required?
```

---

# 5. Phase 4 — Authorization Testing

Authentication answers:

> **Who are you?**

Authorization answers:

> **What are you allowed to do?**

Test different roles:

```text
User
Manager
Admin
```

Example:

```text
User A
 ↓
GET /api/orders/1001
```

Then determine whether User A can access:

```text
/api/orders/1002
```

This is where vulnerabilities such as:

```text
IDOR / BOLA
Broken Access Control
Privilege Escalation
```

may appear.

---

# 6. Phase 5 — Input Validation Testing

Every user-controlled input is an attack surface.

Look at:

```text
Query parameters
Path parameters
Headers
Cookies
JSON
Forms
File uploads
HTTP methods
```

Then map the appropriate vulnerability classes:

```text
Input
 ├── HTML → XSS
 ├── SQL → SQL Injection
 ├── OS command → Command Injection
 ├── File path → Path Traversal
 ├── URL → SSRF/Open Redirect
 └── XML → XXE
```

This is much more effective than randomly trying payloads.

---

# 7. Phase 6 — Session & Cookie Testing

Inspect cookies:

```text
Secure
HttpOnly
SameSite
Domain
Path
Expiration
```

Check:

```text
Session fixation
Session reuse
Logout invalidation
Session expiration
Token exposure
Cross-account session issues
```

Browser DevTools:

```text
Application
   ↓
Cookies
```

is useful for this.

---

# 8. Phase 7 — Business Logic Testing

Not every vulnerability is a technical parser bug.

Test the **rules of the application**.

Example:

```text
Coupon:
"Can only be used once."
```

Test whether concurrent requests can redeem it twice.

Other examples:

```text
Price manipulation
Negative quantities
Duplicate payments
Skipping required steps
Unauthorized refunds
Reusing expired tokens
Changing workflow order
```

This is where race conditions and logic flaws become important.

---

# 9. Phase 8 — File & Resource Testing

For upload/download functionality check:

```text
File type validation
File size limits
Path traversal
Access control
File naming
Storage location
Download authorization
```

Example:

```text
GET /download?id=1001
```

Ask:

```text
Can another user access 1001?
Can the path be manipulated?
Can sensitive files be downloaded?
```

---

# 10. Phase 9 — Security Headers & Configuration

Review:

```text
CSP
HSTS
X-Content-Type-Options
CORS
Cookie flags
TLS configuration
Error handling
Debug mode
Exposed admin endpoints
```

Also examine:

```text
Cloud storage
IAM
Network exposure
Database access
Secrets
```

This catches **security misconfiguration**.

---

# 11. Phase 10 — API Testing

Modern applications are often API-driven.

Test:

```text
GET
POST
PUT
PATCH
DELETE
OPTIONS
```

For every API:

```text
Authentication
Authorization
Input validation
Rate limiting
Object-level authorization
Mass assignment
Error handling
Sensitive data exposure
```

Example:

```http
GET /api/users/1001
Authorization: Bearer <token>
```

Ask:

```text
Can User A request User B's object?
```

---

# 12. Phase 11 — Automated + Manual Testing

Use tools for efficiency, but don't depend entirely on scanners.

Common defensive/authorized testing tools:

```text
Burp Suite
OWASP ZAP
curl
Browser DevTools
Nmap
Postman
```

Typical workflow:

```text
Browser
   ↓
Proxy
   ↓
Burp/ZAP
   ↓
Application
```

The proxy allows you to inspect:

```text
Requests
Responses
Headers
Cookies
Parameters
API behavior
```

---

# 13. Manual Testing Is Essential

Automated scanners are good at finding patterns.

Humans are better at understanding:

```text
Business logic
Authorization
Workflow
Application context
Unexpected state transitions
```

Example:

A scanner may identify:

```text
GET /api/order/1001
```

but a human needs to determine:

```text
Should User A actually be allowed to access order 1001?
```

---

# 14. Map Findings to Vulnerability Classes

A useful methodology is:

```text
Authentication
     ↓
Session Management
     ↓
Authorization
     ↓
Input Validation
     ↓
Business Logic
     ↓
Configuration
     ↓
Infrastructure
```

Then map specific findings:

```text
XSS
SQL Injection
CSRF
SSRF
XXE
SSTI
Path Traversal
File Upload
IDOR/BOLA
Open Redirect
Race Condition
```

---

# 15. Validate Impact Safely

Finding a vulnerability is not the same as proving its impact.

For example:

```text
Finding:
Possible IDOR
```

Safe validation:

```text
User A
 ↓
Request User B's test resource
 ↓
Application returns resource
```

Do **not** access unrelated real users' sensitive data.

Use:

```text
Test accounts
Test data
Staging environment
Controlled resources
```

---

# 16. Evidence Collection

For every finding record:

```text
Title
Affected endpoint
Severity
Description
Prerequisites
Reproduction steps
Expected behavior
Actual behavior
Impact
Evidence
Recommended remediation
```

Example:

```text
Title:
Broken Object-Level Authorization

Endpoint:
GET /api/orders/{id}

Expected:
User can access only their own orders.

Actual:
Another user's test order was accessible.

Impact:
Unauthorized access to order information.

Remediation:
Enforce server-side object ownership checks.
```

---

# 17. Risk Prioritization

Not every vulnerability has the same severity.

Consider:

```text
Exploitability
Impact
Authentication required
Privileges required
Data sensitivity
Business impact
Attack complexity
```

Example:

```text
Public RCE
   ↓
Critical
```

while:

```text
Low-impact information disclosure
   ↓
Potentially Low/Medium
```

Severity should be based on the actual environment and impact, not just the vulnerability name.

---

# 18. Small Hands-On Lab

Use your own Spring Boot application.

Create this test plan:

```text
[ ] Authentication
[ ] Authorization
[ ] Session/Cookies
[ ] Input validation
[ ] SQL Injection
[ ] XSS
[ ] CSRF
[ ] File upload
[ ] Path traversal
[ ] SSRF
[ ] CORS
[ ] Security headers
[ ] Rate limiting
[ ] Business logic
[ ] Race conditions
[ ] Error handling
```

For each item record:

```text
Endpoint:
Test:
Expected:
Actual:
Result:
Evidence:
```

Example:

```text
Endpoint: /api/orders/{id}

Test:
Access another test user's order.

Expected:
403 Forbidden.

Actual:
200 OK.

Result:
Potential BOLA.
```

---

# 19. SOC Relevance

A SOC analyst can use this methodology in reverse during an incident.

Instead of:

```text
"What attack happened?"
```

ask:

```text
What endpoint was targeted?
        ↓
What input was supplied?
        ↓
Which vulnerability class fits?
        ↓
Was exploitation successful?
        ↓
What data/action was affected?
        ↓
What happened afterward?
```

Example:

```text
POST /upload
      ↓
Suspicious file
      ↓
Uploaded successfully
      ↓
GET /uploads/file
      ↓
Unexpected server process
      ↓
Potential compromise
```

This connects **web logs + application logs + endpoint/process telemetry**.

---

# 20. Interview Questions

### Q1. What is a good web penetration-testing methodology?

```text
Recon
→ Attack surface mapping
→ Authentication
→ Authorization
→ Input validation
→ Business logic
→ Configuration
→ Impact validation
→ Reporting
```

### Q2. Why test authorization separately from authentication?

Because a user can be correctly authenticated but still access resources they are not authorized to access.

### Q3. Why is manual testing important?

Business logic and authorization flaws often require understanding application behavior rather than matching known vulnerability signatures.

### Q4. What should every finding contain?

```text
Vulnerability
Endpoint
Reproduction
Impact
Evidence
Remediation
```

### Q5. What is the most important rule during testing?

> **Only test systems and data you are explicitly authorized to test.**

---

# 21. Quick Cheat Sheet

```text
1. Discover
      ↓
2. Map attack surface
      ↓
3. Test authentication
      ↓
4. Test authorization
      ↓
5. Test inputs
      ↓
6. Test sessions
      ↓
7. Test business logic
      ↓
8. Test configuration
      ↓
9. Validate impact
      ↓
10. Document + remediate
```

### Key Tools

```text
Burp Suite
OWASP ZAP
Browser DevTools
curl
Postman
Nmap
```

### Key Mindset

```text
Don't ask:
"Which payload should I try?"

Ask:
"What does this endpoint trust,
what can the user control,
and what security decision does the server make?"
```

---

# 22. Core Mental Model

A professional web security assessment follows:

```text
Understand the application
          ↓
Identify trust boundaries
          ↓
Find user-controlled inputs
          ↓
Find security decisions
          ↓
Test whether controls can be bypassed
          ↓
Prove impact safely
          ↓
Fix the root cause
          ↓
Retest
```

**Remember:**

> **Good web security testing is structured around trust boundaries, not a collection of random exploits.**