# `09-Kerberos.md`

# Kerberos — Windows Security Notes

## 1. First Principle

**Kerberos** is a network authentication protocol used by Windows Active Directory environments.

Its main idea is:

> **Prove your identity using trusted tickets instead of repeatedly sending your password across the network.**

Mental model:

```text
User
 ↓
Domain Controller / KDC
 ↓
Authentication
 ↓
Ticket
 ↓
Access Network Service
```

---

# 2. Why Kerberos Exists

Imagine a company with:

```text
1000 Users
500 Computers
100 Servers
```

A user shouldn't have to send their password to every server they access.

Instead:

```text
Password
   ↓
Domain Controller
   ↓
Authentication
   ↓
Kerberos Ticket
   ↓
Use ticket to access services
```

The password is primarily used to establish the user's identity with the authentication system.

---

# 3. Important Kerberos Components

## KDC

**KDC = Key Distribution Center**

The KDC runs on a Domain Controller.

It has two major logical components:

```text
KDC
├── Authentication Service (AS)
└── Ticket Granting Service (TGS)
```

---

# 4. TGT — Ticket Granting Ticket

After successful authentication, the user receives a:

**TGT = Ticket Granting Ticket**

Simplified:

```text
User
 ↓
Authentication
 ↓
TGT
```

The TGT allows the user to request additional service tickets without entering their password every time.

---

# 5. TGS — Ticket Granting Service

Suppose the user wants to access:

```text
FileServer01
```

The user uses the TGT to request a service ticket.

```text
TGT
 ↓
TGS request
 ↓
Service Ticket
 ↓
FileServer01
```

---

# 6. Complete Kerberos Flow

Simplified Windows domain authentication:

```text
1. User logs in
       ↓
2. Client contacts KDC
       ↓
3. Authentication Service
       ↓
4. TGT issued
       ↓
5. User requests service ticket
       ↓
6. TGS issues service ticket
       ↓
7. Client presents ticket to server
       ↓
8. Server grants access
```

Remember:

```text
TGT
 ↓
Get Service Ticket
 ↓
Access Service
```

---

# 7. Service Principal Name — SPN

An **SPN (Service Principal Name)** identifies a service instance in an AD environment.

Example:

```text
MSSQLSvc/sql01.example.com:1433
```

It tells Kerberos:

```text
Service
   ↓
Which account is associated with it?
```

SPNs are important because Kerberos needs to know which account represents a particular service.

---

# 8. Why SPNs Matter in Security

Attackers may search for service accounts associated with SPNs.

This is related to an attack technique called:

**Kerberoasting**

Conceptually:

```text
AD
 ↓
Service Account + SPN
 ↓
Request service ticket
 ↓
Obtain ticket material
 ↓
Offline password cracking attempt
```

The important defensive lesson:

> **Weak service-account passwords increase Kerberoasting risk.**

---

# 9. Kerberoasting — Defensive Understanding

Suppose:

```text
SQL Service
      ↓
svc_sql
      ↓
SPN registered
```

If the service account has a weak password, an attacker who can request the appropriate service ticket may attempt to crack the associated encrypted material offline.

Therefore organizations should use:

- Long random service-account passwords
- Managed service accounts where appropriate
- Least privilege
- Monitoring for unusual service-ticket requests

---

# 10. Golden Ticket

Another important Kerberos attack concept is the **Golden Ticket**.

It involves abuse of the domain's **KRBTGT account** and forged Kerberos authentication material.

Conceptually:

```text
KRBTGT compromise
       ↓
Forged TGT
       ↓
Potential domain-wide access
```

This is extremely serious because the KRBTGT account is fundamental to Kerberos ticket issuance in an AD domain.

### Defensive focus

Protect:

- Domain Controllers
- KRBTGT credentials
- Domain Admin accounts
- Privileged administrative systems

And monitor unusual authentication behavior.

---

# 11. Kerberos vs NTLM

Modern Windows domains prefer Kerberos where possible, but **NTLM** can still appear for compatibility and certain scenarios.

| Kerberos | NTLM |
|---|---|
| Ticket-based | Challenge-response |
| Primary AD authentication protocol | Legacy/compatibility protocol |
| Uses KDC | Does not use Kerberos KDC |
| Supports mutual authentication | More limited |
| Common in domain environments | Still encountered in enterprises |

Security teams often want to understand **where NTLM is still being used and whether it can be reduced**.

---

# 12. Useful Commands

## Check Kerberos Tickets

```cmd
klist
```

Shows cached Kerberos tickets.

Example:

```text
Cached Tickets
    Client: user@DOMAIN
    Server: krbtgt/DOMAIN
```

---

## Purge Cached Tickets

```cmd
klist purge
```

This removes cached Kerberos tickets for the current logon session.

⚠️ You may need to authenticate again to access resources.

---

## Request/Refresh Tickets

```cmd
klist get
```

Depending on Windows version/context, this can request a ticket for a specified service.

Example:

```cmd
klist get cifs/server01
```

`CIFS` is commonly associated with Windows file-sharing services.

---

# 13. Practical Investigation

Suppose a user says:

> "I suddenly cannot access the company's file server."

Start by checking Kerberos tickets:

```cmd
klist
```

If necessary, purge the cached tickets:

```cmd
klist purge
```

Then authenticate again and check:

```cmd
klist
```

You may see tickets for services such as:

```text
cifs/server01
HTTP/webserver
MSSQLSvc/sqlserver
```

This helps determine whether Kerberos authentication is occurring.

---

# 14. SOC Detection Scenario

Suppose a SOC detects unusual Kerberos activity.

Analyst investigates:

```text
User
 ↓
Source Computer
 ↓
Authentication
 ↓
Service Ticket Request
 ↓
Target Service
 ↓
Time
 ↓
Normal or abnormal?
```

Example:

```text
Normal:
Employee → Workstation → File Server

Suspicious:
Employee → Unknown workstation → Multiple servers
```

The second pattern deserves investigation, especially if combined with:

- Unusual login time
- New source IP
- Privileged account
- Large number of service requests
- Other suspicious endpoint activity

---

# 15. Important Windows Event IDs

For Kerberos investigations, useful events can include:

```text
4768 → Kerberos authentication ticket (TGT) requested
4769 → Kerberos service ticket requested
4770 → Kerberos service ticket renewed
4771 → Kerberos pre-authentication failed
```

A useful investigation pattern is:

```text
4768
  ↓
TGT requested

4769
  ↓
Service ticket requested

Endpoint / network telemetry
  ↓
What happened afterward?
```

Event IDs should always be interpreted in context rather than treated as automatic indicators of compromise.

---

# 16. Small Hands-On Lab

On a domain-joined Windows machine:

### Step 1 — Check tickets

```cmd
klist
```

### Step 2 — Identify your identity

```cmd
whoami
```

### Step 3 — Check domain information

```cmd
whoami /fqdn
```

### Step 4 — Clear tickets

```cmd
klist purge
```

### Step 5 — Access an authorized network resource

For example, an organization-approved file share.

Then:

```cmd
klist
```

Observe how Kerberos tickets are present for services you accessed.

---

# 17. Security Best Practices

Organizations can reduce Kerberos-related risk through:

### Strong service-account credentials

Avoid predictable passwords.

### Managed Service Accounts

Use appropriate managed accounts where possible.

### Least privilege

Service accounts should have only required permissions.

### Protect Domain Controllers

Restrict administrative access.

### Monitor authentication

Look for abnormal:

- TGT requests
- Service-ticket requests
- Authentication failures
- Privileged account activity

### Reduce unnecessary NTLM

Where technically feasible, move toward stronger authentication mechanisms.

---

# 18. Interview Questions

### Q1. What is Kerberos?

A ticket-based authentication protocol widely used by Windows Active Directory.

### Q2. What is a TGT?

A **Ticket Granting Ticket** used to request service tickets from the KDC.

### Q3. What is a service ticket?

A ticket used to authenticate to a particular network service.

### Q4. What is KDC?

The **Key Distribution Center**, running as part of a Domain Controller, that handles Kerberos authentication and ticket issuance.

### Q5. What is an SPN?

A **Service Principal Name** identifies a service instance associated with an account in Active Directory.

### Q6. What is Kerberoasting?

An attack technique involving service tickets associated with service accounts, followed by offline password-cracking attempts.

### Q7. What is a Golden Ticket?

A forged Kerberos TGT created through compromise of the domain's KRBTGT secret, potentially enabling extensive unauthorized access.

### Q8. Which command shows Kerberos tickets?

```cmd
klist
```

---

# 19. Quick Cheat Sheet

```text
Kerberos
→ Ticket-based authentication

KDC
→ Key Distribution Center

AS
→ Authentication Service

TGT
→ Ticket Granting Ticket

TGS
→ Ticket Granting Service

SPN
→ Service Principal Name

klist
→ View Kerberos tickets

klist purge
→ Clear cached tickets

4768
→ TGT request

4769
→ Service ticket request

4771
→ Kerberos pre-authentication failure

Kerberoasting
→ Service-account ticket attack

Golden Ticket
→ Forged TGT using compromised KRBTGT secret
```

## Core Mental Model

```text
User Login
    ↓
KDC
    ↓
TGT
    ↓
Request Service Ticket
    ↓
Service Ticket
    ↓
Target Server
    ↓
Authentication / Access
    ↓
Event Logs
    ↓
SOC Detection
```

**Next:** `10-Windows-Authentication.md`