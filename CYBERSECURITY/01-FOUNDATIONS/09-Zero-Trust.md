Here is the **9th file exactly according to your structure**, in clean Markdown format.

### `09-Zero-Trust.md`

```md
# Zero Trust

## 1. What is Zero Trust?

Zero Trust is a security approach based on the principle:

> **Never trust, always verify.**

It means users, devices, applications, and network locations should not automatically be trusted.

---

## 2. First Principle

Traditional security assumes:

```text
Inside Network → Trusted
Outside Network → Untrusted
```

Zero Trust assumes:

```text
Every Access Request
        ↓
     Verify
        ↓
    Authorize
        ↓
 Grant Minimum Access
        ↓
    Monitor
```

Being inside the company network does not automatically mean trusted access.

---

## 3. What Does Zero Trust Verify?

Before allowing access, evaluate:

- User identity
- Authentication status
- Device security
- Requested resource
- User permissions
- Request context
- Risk level

Example:

```text
User
 ↓
Identity Verification
 ↓
MFA
 ↓
Device Check
 ↓
Permission Check
 ↓
Access Decision
```

---

## 4. Example

An employee wants to access a company database.

Traditional approach:

```text
Employee
   ↓
Company VPN
   ↓
Internal Network
   ↓
Database
```

Zero Trust:

```text
Employee
   ↓
Authenticate
   ↓
Verify MFA
   ↓
Check Device
   ↓
Check Permission
   ↓
Allow Required Access
   ↓
Monitor Activity
```

---

## 5. Zero Trust and Least Privilege

These principles work together.

### Zero Trust

> Verify access before trusting the request.

### Least Privilege

> Give only the minimum required permissions.

Together:

```text
Verify
  ↓
Authorize
  ↓
Minimum Access
  ↓
Monitor
```

---

## 6. Assume Breach

One important Zero Trust principle is:

> **Assume that a compromise may already exist.**

Therefore, organizations should limit the damage caused by a compromised account or device.

Controls include:

- Network segmentation
- MFA
- Least privilege
- Endpoint security
- Continuous monitoring
- Strong access controls

---

## 7. Real Industry Example

Suppose an employee's credentials are stolen.

The attacker attempts to access an internal application.

Zero Trust can evaluate:

```text
Stolen Credentials
        ↓
MFA Required
        ↓
Device Verification
        ↓
Permission Check
        ↓
Risk Evaluation
        ↓
Allow / Deny
```

Even though the credentials are valid, access can still be denied if other security requirements are not satisfied.

---

## 8. Zero Trust Architecture

A simplified model:

```text
User / Device
      ↓
Identity Provider
      ↓
Policy Decision
      ↓
Policy Enforcement
      ↓
Application / Resource
      ↓
Continuous Monitoring
```

The decision to allow access is based on security policy rather than simply network location.

---

## 9. Zero Trust vs Traditional Security

### Traditional Perimeter Model

```text
Internet
   ↓
Firewall
   ↓
Internal Network
   ↓
Trusted Users
```

Problem:

If an attacker gains internal access, they may be able to move toward other systems.

### Zero Trust Model

```text
User
 ↓
Verify
 ↓
Policy Check
 ↓
Specific Resource
 ↓
Limited Access
 ↓
Monitor
```

Access is evaluated at the resource level.

---

## 10. Practical Security Analyst Checklist

When evaluating Zero Trust:

- Is MFA enabled?
- Are users verified before accessing sensitive resources?
- Are permissions limited?
- Are devices evaluated?
- Are sensitive systems segmented?
- Is privileged access monitored?
- Are suspicious activities detected?
- Are internal users automatically trusted?

---

## 11. Key Takeaways

- Zero Trust follows **"Never trust, always verify."**
- Internal network access does not automatically mean trusted.
- Every sensitive access request should be evaluated.
- Least privilege is an important part of Zero Trust.
- Assume that a compromise may already exist.
- Segmentation helps limit attacker movement.
- Continuous monitoring is important.
- Zero Trust is a **security strategy/architecture**, not a single product.

---

# Interview Questions

### Q1. What is Zero Trust?

Zero Trust is a security approach that continuously verifies users, devices, and access requests instead of automatically trusting them.

### Q2. What is the core principle of Zero Trust?

> **Never trust, always verify.**

### Q3. Does Zero Trust mean trusting nobody?

No. It means trust is not automatically granted. Access must be verified and authorized.

### Q4. How is Zero Trust related to Least Privilege?

Zero Trust verifies whether access should be allowed, while Least Privilege limits that access to only what is necessary.

### Q5. What does "Assume Breach" mean?

It means designing security controls with the assumption that an attacker may already have gained some level of access.

### Q6. Is Zero Trust a security product?

No. Zero Trust is a security architecture and strategy implemented using multiple technologies and security controls.
```