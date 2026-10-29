# `08-Windows-Active-Directory.md`

# Windows Active Directory — Cybersecurity Notes

## 1. First Principle

**Active Directory (AD)** is Microsoft's system for centrally managing users, computers, groups, policies, and access in an organization.

Think of it as:

```text
Organization
     ↓
Active Directory
     ↓
Users + Computers + Groups + Policies
     ↓
Authentication + Authorization + Management
```

Instead of configuring every computer separately, an organization can manage thousands of systems centrally.

---

# 2. Workgroup vs Domain

### Workgroup

Each computer manages its own users.

```text
PC1 → Users
PC2 → Users
PC3 → Users
```

There is no central identity system.

### Domain

A central AD environment manages identities.

```text
              Domain Controller
                     ↓
        ┌────────────┼────────────┐
        ↓            ↓            ↓
      PC-01        PC-02        PC-03
        ↓            ↓            ↓
      Users        Users        Users
```

This is common in enterprise environments.

---

# 3. Domain Controller

A **Domain Controller (DC)** is a Windows Server that provides important Active Directory services.

It can handle:

- User authentication
- Computer authentication
- Group management
- Security policies
- Directory queries
- Kerberos authentication
- LDAP directory services

Important mental model:

```text
User
 ↓
Domain Controller
 ↓
Authentication
 ↓
Access to authorized resources
```

---

# 4. Important AD Components

## Domain

Logical security boundary containing users, computers, groups, and other objects.

Example:

```text
corp.example.com
```

---

## Organizational Unit — OU

Used to organize AD objects.

Example:

```text
corp.example.com
│
├── IT
│   ├── Users
│   └── Computers
│
├── HR
│   └── Users
│
└── Finance
    └── Users
```

OUs are particularly useful for applying **Group Policy**.

---

# 5. AD Objects

Common objects include:

```text
User
Computer
Group
Organizational Unit
Printer
Service Account
```

Example:

```text
User: Rahul
Group: IT-Admins
Computer: IT-PC-01
```

A user may belong to multiple groups.

```text
Rahul
 ↓
IT-Employees
 ↓
VPN-Users
 ↓
Developers
```

Group membership can determine access.

---

# 6. Authentication vs Authorization

These are extremely important in cybersecurity interviews.

### Authentication

> Who are you?

Example:

```text
Username + password
        ↓
Authentication
        ↓
Identity confirmed
```

### Authorization

> What are you allowed to access?

```text
Authenticated User
        ↓
Groups / Permissions
        ↓
Access allowed or denied
```

Remember:

```text
Authentication → Identity
Authorization  → Permissions
```

---

# 7. Kerberos

**Kerberos** is the primary authentication protocol used in modern Windows domains.

Simplified flow:

```text
User
 ↓
Authentication request
 ↓
Domain Controller / KDC
 ↓
Ticket
 ↓
Access requested service
```

Instead of repeatedly sending a password to every service, Kerberos uses **tickets**.

Important terms:

- KDC — Key Distribution Center
- TGT — Ticket Granting Ticket
- TGS — Ticket Granting Service
- Service ticket

### Mental model

```text
Login
 ↓
Get TGT
 ↓
Request service ticket
 ↓
Access service
```

---

# 8. LDAP

**LDAP — Lightweight Directory Access Protocol**

LDAP is used to interact with directory information.

For example, applications can query:

```text
Users
Groups
Computers
Organizational Units
```

Conceptually:

```text
Application
     ↓
LDAP query
     ↓
Active Directory
     ↓
Directory information
```

LDAP commonly uses:

```text
389  → LDAP
636  → LDAPS
```

---

# 9. Group Policy

**Group Policy** allows administrators to centrally configure Windows systems.

Examples:

- Password policies
- Windows Firewall
- Security settings
- Software configuration
- User restrictions
- Desktop settings
- Script execution policies

Mental model:

```text
Administrator
      ↓
Group Policy
      ↓
Users / Computers
      ↓
Consistent security configuration
```

---

# 10. Useful Commands

### Check current user

```cmd
whoami
```

Shows the currently logged-in identity.

---

### Show domain information

```cmd
whoami /fqdn
```

Shows the user's fully qualified domain name when applicable.

---

### Show groups

```cmd
whoami /groups
```

Useful for understanding group memberships and security context.

---

### View domain information

```cmd
systeminfo
```

Look for domain/workgroup information.

---

### Query AD users

On systems with the AD PowerShell module:

```powershell
Get-ADUser -Filter *
```

This retrieves AD user objects.

---

### Find a specific user

```powershell
Get-ADUser -Identity username
```

---

### Find computers

```powershell
Get-ADComputer -Filter *
```

---

### Find groups

```powershell
Get-ADGroup -Filter *
```

These commands require appropriate AD tools/module access.

---

# 11. Practical Cybersecurity Scenario

### Scenario

An employee's account suddenly accesses a sensitive server.

An analyst investigates:

```text
User login
   ↓
Which account?
   ↓
Which computer?
   ↓
Which groups?
   ↓
What authentication occurred?
   ↓
What resource was accessed?
   ↓
Was the access expected?
```

For example:

```text
User: employee1
Group: Finance-Users
Resource: Finance Server
Time: 02:30 AM
```

The analyst asks:

> Why is a Finance user accessing the server at 02:30 AM?

Possible explanations:

- Legitimate maintenance
- Scheduled task
- VPN session
- Compromised credentials
- Unauthorized activity

The event needs correlation rather than an immediate conclusion.

---

# 12. AD Security Risks

Active Directory is extremely important to attackers because compromising privileged accounts can provide access to many systems.

Common attack concepts include:

### Credential Theft

Attackers attempt to obtain credentials or authentication material.

### Password Attacks

Examples:

```text
Password spraying
Brute force
Credential stuffing
```

### Privilege Escalation

```text
Normal User
    ↓
Higher Privileges
    ↓
Administrator
```

### Lateral Movement

Moving from one compromised machine to another.

```text
PC-01
 ↓
Server-01
 ↓
Server-02
```

### Kerberoasting

Attackers may target service accounts associated with Kerberos service principals and attempt offline password cracking.

### Pass-the-Hash

Attackers may abuse captured NTLM authentication material instead of needing the user's plaintext password.

These are concepts you should understand for defensive security; actual investigation should focus on authentication logs, endpoint telemetry, and abnormal access patterns.

---

# 13. Privileged Groups

Some AD groups are particularly sensitive.

For example:

```text
Domain Admins
Enterprise Admins
Administrators
```

Membership should be tightly controlled.

A security analyst should ask:

```text
Who is privileged?
        ↓
Why are they privileged?
        ↓
Is the membership expected?
        ↓
When did it change?
```

Unexpected addition of an account to a highly privileged group is a major investigation signal.

---

# 14. Detection Mindset

When investigating suspicious AD activity, correlate:

```text
Account
   +
Computer
   +
Authentication
   +
Group membership
   +
Source IP
   +
Time
   +
Resource accessed
   +
Process activity
```

Example:

```text
Unusual login
     ↓
Privileged account
     ↓
New source computer
     ↓
Sensitive server accessed
     ↓
Suspicious process
```

This combination is much more meaningful than looking at a single event.

---

# 15. Small Hands-On Lab

If you have a Windows machine that is **not connected to an organization's AD**, you can still practice the identity concepts locally.

Run:

```cmd
whoami
```

Then:

```cmd
whoami /user
```

Then:

```cmd
whoami /groups
```

Then:

```cmd
whoami /priv
```

Understand the chain:

```text
User
 ↓
SID
 ↓
Groups
 ↓
Privileges
 ↓
Security Token
 ↓
Access
```

If you later build a Windows Server lab with a domain controller and Windows client VM, you can practice actual AD administration safely.

---

# 16. SOC Investigation Example

Suppose you receive:

```text
Alert:
User added to Domain Admins
```

Investigation:

```text
1. Who was added?
       ↓
2. Who performed the change?
       ↓
3. When?
       ↓
4. From which machine?
       ↓
5. Was there an approved change?
       ↓
6. What happened afterward?
```

Then correlate with:

- Authentication logs
- Domain Controller logs
- Process creation
- PowerShell activity
- Network connections
- Other account changes

---

# 17. Interview Questions

### Q1. What is Active Directory?

A centralized directory and identity-management system used to manage users, computers, groups, policies, and access in Windows domain environments.

### Q2. What is a Domain Controller?

A server that provides Active Directory services, including authentication and directory management.

### Q3. What is Kerberos?

A ticket-based authentication protocol used by Windows domains.

### Q4. Authentication vs authorization?

```text
Authentication → Who are you?
Authorization  → What can you access?
```

### Q5. What is Group Policy?

A mechanism for centrally applying configuration and security policies to users and computers.

### Q6. What is lateral movement?

Moving from one compromised system or account to another within an environment.

### Q7. Why are Domain Admin accounts highly sensitive?

They have extensive privileges across the domain, so compromise can have significant organizational impact.

---

# 18. Quick Cheat Sheet

```text
Active Directory
→ Centralized Windows identity/directory system

Domain Controller
→ Provides AD services

Domain
→ Logical security boundary

OU
→ Organizes AD objects

User
→ Identity

Group
→ Collection of users/computers used for access management

Kerberos
→ Primary Windows domain authentication protocol

LDAP
→ Directory access/query protocol

Group Policy
→ Centralized configuration/security policies

Authentication
→ Who are you?

Authorization
→ What can you access?

Lateral Movement
→ Moving between systems

Domain Admin
→ Highly privileged domain account/group
```

## Core Mental Model

```text
                 Active Directory
                       ↓
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
      Users          Groups        Computers
        ↓              ↓              ↓
        └──────────────┼──────────────┘
                       ↓
                Authentication
                       ↓
                  Authorization
                       ↓
                 Resource Access
                       ↓
                    Logging
                       ↓
                  Detection
```

**Next:** `09-Windows-Defender-Firewall.md` — Windows Firewall, profiles, inbound/outbound rules, PowerShell commands, troubleshooting, and SOC investigation.