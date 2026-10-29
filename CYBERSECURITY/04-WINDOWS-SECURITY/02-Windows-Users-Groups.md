# `02-Windows-Users-Groups.md`

# Windows Users & Groups

## 1. First Principle

Windows security starts with **identity**.

The system needs to know:

> **Who is requesting access?**

Basic model:

```text
User
 ↓
Groups
 ↓
Security Token
 ↓
Privileges
 ↓
Resource Access
```

Example:

```text
Yash
 ↓
Administrators
 ↓
Elevated token
 ↓
Can perform administrative actions
```

For cybersecurity, the important principle is:

> **A compromised user account can become an attacker's entry point.**

---

# 2. Windows User Accounts

A user account represents an identity.

Examples:

```text
Administrator
Guest
normaluser
service accounts
```

Current user:

```powershell id="v1r6de"
whoami
```

More information:

```powershell id="4p8d1r"
whoami /all
```

`whoami /all` can show:

- username
- SID
- groups
- privileges
- integrity information

---

# 3. SID — Security Identifier

Windows identifies accounts using **SIDs**, not just usernames.

Example:

```text
S-1-5-21-...
```

Conceptually:

```text
Username
   ↓
SID
   ↓
Windows security decisions
```

This matters because usernames can change, but the SID is the security identity used by Windows.

Get current SID:

```powershell id="5c5f92"
whoami /user
```

---

# 4. Local Users

List local users:

```powershell id="b4g4qt"
Get-LocalUser
```

Example:

```text
Name
----
Administrator
Guest
student
```

Check one user:

```powershell id="6jy1ir"
Get-LocalUser student
```

Command-line alternative:

```cmd id="0x5sba"
net user
```

---

# 5. Windows Groups

Groups allow permissions to be assigned to multiple users.

Instead of:

```text
User A → Permission
User B → Permission
User C → Permission
```

Use:

```text
Security Group
      ↓
Permissions
      ↓
Members
```

Common groups:

```text
Administrators
Users
Remote Desktop Users
Backup Operators
Guests
```

List local groups:

```powershell id="6a5n3v"
Get-LocalGroup
```

---

# 6. Group Membership

Check current user's groups:

```cmd id="k5n9fa"
whoami /groups
```

PowerShell:

```powershell id="x8w4qk"
Get-LocalGroupMember Administrators
```

Example:

```text
Administrators
 ├── Administrator
 └── student
```

If an unexpected user is in `Administrators`, investigate.

---

# 7. Administrator vs Standard User

### Standard user

Normally has limited privileges.

```text
User
 ↓
Limited access
```

### Administrator

Can perform privileged operations.

```text
Administrator
 ↓
Elevated privileges
 ↓
System configuration
```

Security principle:

> **Do not use administrator privileges when they are unnecessary.**

---

# 8. UAC — User Account Control

UAC helps prevent applications from silently performing administrative actions.

Conceptually:

```text
User starts application
        ↓
Does it require elevation?
        ↓
       Yes
        ↓
UAC prompt
        ↓
User approval
        ↓
Elevated operation
```

This creates an additional security boundary for administrative actions.

---

# 9. Security Token

When a user logs in, Windows creates a **security token** associated with that user's security context.

It contains information such as:

```text
User SID
Group SIDs
Privileges
Integrity information
```

Conceptually:

```text
Login
 ↓
Security Token
 ↓
Process
 ↓
Access Check
 ↓
Allow / Deny
```

This is why simply knowing someone's username isn't enough to understand their effective access.

---

# 10. Privileges

Windows privileges allow certain sensitive operations.

Examples include privileges related to:

```text
Debugging processes
Loading drivers
Backing up files
Restoring files
Taking ownership
Changing system configuration
```

View privileges:

```cmd id="vsvb8c"
whoami /priv
```

Example:

```text
SeChangeNotifyPrivilege
SeShutdownPrivilege
```

Security analysts should pay attention to **unnecessary powerful privileges**.

---

# 11. Local vs Domain Accounts

### Local account

Exists on one Windows machine.

```text
Computer A
 └── user1
```

### Domain account

Managed centrally by **Active Directory**.

```text
Active Directory
       ↓
   User account
       ↓
Multiple computers
```

Domain accounts become especially important in enterprise environments.

You will study this in:

```text
08-Active-Directory.md
```

---

# 12. Service Accounts

Some applications/services need accounts to run.

Example:

```text
Database Service
      ↓
Database Account
```

Security principle:

> Service accounts should have only the permissions required by the service.

A service account with unnecessary administrator privileges increases risk.

---

# 13. Practical Security Scenario

Suppose an analyst sees:

```text
User: john
Group: Administrators
```

But John is supposed to be a normal employee.

Investigate:

```powershell id="9y8n5m"
Get-LocalGroupMember Administrators
```

Then:

```powershell id="9ygqpn"
Get-LocalUser john
```

Check privileges:

```cmd id="t2qkz1"
whoami /priv
```

Questions:

```text
Who added the user?
When?
Why?
Was the account compromised?
What actions were performed?
```

This can indicate:

- privilege abuse
- accidental misconfiguration
- compromised account
- persistence

---

# 14. Practical Lab

### Step 1 — Current identity

```cmd id="f6e3r8"
whoami
```

### Step 2 — Current SID

```cmd id="l0g2z5"
whoami /user
```

### Step 3 — Current groups

```cmd id="qgj8by"
whoami /groups
```

### Step 4 — Current privileges

```cmd id="t0t0q8"
whoami /priv
```

### Step 5 — Local users

```powershell id="4y0vpc"
Get-LocalUser
```

### Step 6 — Administrators

```powershell id="c4d5xy"
Get-LocalGroupMember Administrators
```

Try to determine:

```text
Who am I?
What groups am I in?
Do I have administrator access?
What privileges are available?
Which accounts have administrative access?
```

---

# 15. Security Investigation Commands

### Find administrators

```powershell id="k7v1h9"
Get-LocalGroupMember Administrators
```

### List users

```powershell id="m0c8w2"
Get-LocalUser
```

### Get current identity

```cmd id="7j7qz7"
whoami /all
```

### Check privileges

```cmd id="l8z7o2"
whoami /priv
```

### Check groups

```cmd id="k8p3wv"
whoami /groups
```

---

# 16. Detection Thinking

Watch for:

```text
Unexpected administrator
        ↓
New local account
        ↓
Unexpected group membership
        ↓
Suspicious privileged process
        ↓
Unusual network activity
```

For example:

```text
NewUser
   ↓
Administrators
   ↓
PowerShell
   ↓
External connection
```

This sequence deserves investigation.

---

# 17. Least Privilege

The ideal model:

```text
User
 ↓
Required group
 ↓
Required privilege
 ↓
Required resource
```

Avoid:

```text
Every user
 ↓
Administrator
 ↓
Everything
```

Least privilege limits the damage if an account is compromised.

---

# 18. Interview Questions

### Q1. What is a SID?

A Security Identifier uniquely identifying a Windows security principal.

### Q2. What is a security token?

A structure associated with a process/user that contains identity, group membership, privileges, and other security information used during access checks.

### Q3. What does UAC do?

It helps prevent unauthorized or silent elevation of administrative privileges.

### Q4. How do you find members of the local Administrators group?

```powershell id="n6j7xk"
Get-LocalGroupMember Administrators
```

### Q5. Why is group membership important?

Because group membership can determine what resources and administrative operations a user can access.

---

# 19. Quick Cheat Sheet

```cmd id="4u4u9k"
whoami
whoami /all
whoami /user
whoami /groups
whoami /priv

net user
```

```powershell id="jymzq8"
Get-LocalUser
Get-LocalGroup
Get-LocalGroupMember Administrators
```

## Core Mental Model

```text
User
 ↓
SID
 ↓
Groups
 ↓
Security Token
 ↓
Privileges
 ↓
Access Check
 ↓
Resource
```

> **For a Windows Security Analyst, always investigate identity before investigating access: Who is the user, what groups do they belong to, what privileges do they have, and what can their processes access?**

**Next:** `03-NTFS-Permissions.md`