You're right. I went outside the structure in the image.

We have already completed:

1. `01-Cybersecurity-Fundamentals.md`
2. `02-CIA-Triad.md`
3. `03-Threat-Vulnerability-Risk.md`
4. `04-Attack-Surface.md`
5. `05-Security-Controls.md`
6. `06-Authentication-vs-Authorization.md`

So the **next file according to your exact structure** is:

# `07-Least-Privilege.md`

```md
# Least Privilege

## 1. What is Least Privilege?

Least Privilege means giving a user, application, device, or service **only the minimum permissions required to perform its job**.

### First Principle

> "Give only the access that is necessary, and nothing more."

---

# 2. Simple Example

Suppose an employee only needs to read customer data.

Bad:

```text
Employee
   ↓
Read + Write + Delete + Admin Access
```

Better:

```text
Employee
   ↓
Read Customer Data
```

The second design reduces the possible damage if the account is compromised.

---

# 3. Why Least Privilege Matters

If an attacker compromises an account with excessive permissions:

```text
Compromised Account
       ↓
Excessive Permissions
       ↓
More Systems Accessible
       ↓
Greater Damage
```

With least privilege:

```text
Compromised Account
       ↓
Limited Permissions
       ↓
Limited Access
       ↓
Limited Damage
```

---

# 4. Least Privilege Applies To

It is not only for users.

It applies to:

- Users
- Administrators
- Applications
- APIs
- Services
- Databases
- Cloud resources
- Devices

Example:

A backend application that only needs to read a database should not have permission to delete the entire database.

---

# 5. Real Industry Example

Consider an e-commerce application.

```text
Customer
   ↓
Can view own orders

Support Agent
   ↓
Can view customer orders

Developer
   ↓
Can access development environment

Database Admin
   ↓
Can manage database
```

Each role receives only the permissions required for its responsibilities.

---

# 6. Practical Example — Database

Suppose an application only needs to read product information.

Bad:

```text
Application
   ↓
Database Admin
   ↓
SELECT + INSERT + UPDATE + DELETE + DROP
```

Better:

```text
Application
   ↓
Read-Only Database Account
   ↓
SELECT
```

If the application is compromised, the attacker has fewer opportunities to damage the database.

---

# 7. Least Privilege in Cloud

Cloud platforms use permissions to control access to resources.

Example:

A server only needs to read files from a storage bucket.

It should have:

```text
Read → Allowed
Write → Denied
Delete → Denied
Admin → Denied
```

Do not give:

```text
Full Administrator Access
```

just because it is convenient.

---

# 8. Just-in-Time Access

Some privileged access should exist only when needed.

Example:

```text
Normal User
     ↓
No Admin Access
     ↓
Incident occurs
     ↓
Temporary Admin Access
     ↓
Work completed
     ↓
Admin Access Removed
```

This reduces the time during which powerful permissions are available.

---

# 9. Least Privilege vs Privileged Access

### Normal Access

Used for everyday work.

Example:

```text
Employee → Read company documents
```

### Privileged Access

Used for sensitive administrative operations.

Example:

```text
Administrator → Create/Delete accounts
```

Privileged accounts should receive extra protection such as:

- MFA
- Strong authentication
- Monitoring
- Limited access
- Temporary elevation

---

# 10. Security Analyst Checklist

When reviewing access:

- Does the user really need this permission?
- Are unused permissions removed?
- Are administrator accounts limited?
- Are service accounts restricted?
- Are permissions regularly reviewed?
- Are inactive accounts disabled?
- Is privileged access monitored?
- Is temporary access removed after use?

---

# 11. Real-World Security Principle

A common mistake is:

> "Give full access because it is easier."

This creates unnecessary risk.

Security should follow:

```text
Required Access
      ↓
Minimum Permissions
      ↓
Regular Review
      ↓
Remove Unnecessary Access
```

---

# 12. Key Takeaways

- Least privilege means minimum necessary access.
- It applies to users, applications, services, and devices.
- Excessive permissions increase attack impact.
- Privileged accounts require stronger protection.
- Temporary privilege can be safer than permanent privilege.
- Permissions should be reviewed regularly.
- Least privilege helps limit lateral movement and damage after compromise.

---

# Interview Questions

### Q1. What is the principle of least privilege?

Giving an entity only the minimum permissions required to perform its legitimate function.

### Q2. Why is least privilege important?

It reduces the potential damage caused by compromised accounts, applications, or services.

### Q3. Does least privilege apply only to users?

No. It also applies to applications, APIs, services, devices, and cloud resources.

### Q4. Give a practical example.

A web application that only needs to read a database should use a read-only database account rather than a database administrator account.

### Q5. What is Just-in-Time access?

Providing privileged access temporarily when required and removing it after the task is completed.
```

**Next in the exact image order:** `08-Defense-in-Depth.md` — then `09-Zero-Trust.md`.