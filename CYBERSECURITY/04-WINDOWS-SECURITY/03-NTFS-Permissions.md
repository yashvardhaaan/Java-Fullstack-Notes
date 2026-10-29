# `03-NTFS-Permissions.md`

# NTFS Permissions

## 1. First Principle

Windows needs to answer:

> **Can this user perform this action on this resource?**

The basic model is:

```text
User
 ↓
Groups
 ↓
Security Token
 ↓
NTFS Access Control List (ACL)
 ↓
Allow / Deny
 ↓
File or Folder
```

Example:

```text
Yash
 ↓
Users group
 ↓
ACL
 ↓
C:\Reports
 ↓
Read → Allowed
Write → Denied
```

For cybersecurity, permissions determine **who can read, modify, delete, or execute files**.

---

# 2. NTFS

**NTFS (New Technology File System)** is the primary Windows filesystem used on modern Windows installations.

NTFS supports:

- File permissions
- Folder permissions
- Ownership
- Auditing
- Encryption features
- File metadata

The most important security feature here is the **ACL**.

---

# 3. ACL — Access Control List

An ACL defines who can access a resource and what they can do.

Conceptually:

```text
C:\Secret
    ↓
ACL
 ├── Administrator → Full Control
 ├── SecurityTeam → Read
 └── Guest → Deny
```

View permissions with:

```cmd
icacls C:\Secret
```

Example:

```text
BUILTIN\Administrators:(F)
BUILTIN\Users:(R)
```

Meaning:

```text
(F) → Full Control
(R) → Read
```

---

# 4. Common NTFS Permissions

Important permissions include:

| Permission | Meaning |
|---|---|
| Read | Read file contents |
| Write | Modify/write |
| Read & Execute | Read and execute |
| Modify | Read, write, execute, delete |
| Full Control | Almost complete control |

Mental model:

```text
Read
 ↓
Can see

Write
 ↓
Can modify

Execute
 ↓
Can run

Delete
 ↓
Can remove

Full Control
 ↓
Broad control
```

---

# 5. `icacls`

`icacls` is one of the most important Windows permission tools.

View:

```cmd
icacls C:\Users
```

View a specific file:

```cmd
icacls C:\Users\Public\test.txt
```

Example:

```text
BUILTIN\Users:(R)
```

means members of `Users` have read access.

---

# 6. Granting Permissions

Example:

```cmd
icacls C:\Reports /grant analyst:R
```

Meaning:

```text
C:\Reports
    ↓
analyst
    ↓
Read permission
```

Grant modify:

```cmd
icacls C:\Reports /grant analyst:M
```

Grant full control:

```cmd
icacls C:\Reports /grant analyst:F
```

Be careful with `F`.

Giving unnecessary Full Control increases risk.

---

# 7. Removing Permissions

```cmd
icacls C:\Reports /remove analyst
```

This removes the specified user's explicit ACL entry.

Always verify afterward:

```cmd
icacls C:\Reports
```

---

# 8. Permission Inheritance

Folders can pass permissions to their child files/folders.

Example:

```text
C:\Company
     ↓
    ACL
     ↓
Reports
     ↓
report.pdf
```

The child may inherit permissions from its parent.

This is called **inheritance**.

Why it matters:

> A file may appear secure, but its parent folder could be granting additional access.

---

# 9. Explicit vs Inherited Permissions

There are two important concepts:

```text
Explicit
   ↓
Permission directly assigned to object

Inherited
   ↓
Permission received from parent
```

Inspect:

```cmd
icacls C:\Reports
```

Look for inherited entries.

When troubleshooting access, ask:

```text
Where did this permission come from?
```

---

# 10. Ownership

Every NTFS object has an owner.

Check ownership:

```cmd
icacls C:\Reports
```

Take ownership:

```cmd
takeown /f C:\Reports /r /d Y
```

Changing ownership is a **privileged operation**.

Don't use it casually.

Security relevance:

```text
Attacker
   ↓
Obtains high privileges
   ↓
Changes ownership
   ↓
Changes permissions
   ↓
Accesses protected files
```

---

# 11. Access Check

When a process accesses a file:

```text
Process
   ↓
User/Security Token
   ↓
File ACL
   ↓
Windows evaluates permissions
   ↓
ALLOW / DENY
```

For example:

```text
User = analyst
Group = SecurityTeam

File ACL:
SecurityTeam → Read
```

Result:

```text
Read → Allowed
Write → Denied
```

---

# 12. NTFS vs Share Permissions

When a folder is accessed through a network share, there can be two permission layers:

```text
Network Share Permission
        +
NTFS Permission
        ↓
Effective access
```

For example:

```text
Share → Full Control
NTFS  → Read
```

The effective access is generally restricted by the more restrictive combination.

This is important when investigating Windows file shares.

---

# 13. Practical Security Scenario

Suppose:

```text
C:\Finance
```

contains sensitive files.

You run:

```cmd
icacls C:\Finance
```

and discover:

```text
Everyone:(F)
```

This means everyone has Full Control.

That is potentially dangerous.

A better design might be:

```text
FinanceTeam → Modify
Management  → Read
Administrators → Full Control
```

The exact permissions depend on business requirements.

---

# 14. Dangerous Permission Pattern

Be suspicious of:

```text
Everyone → Full Control
Users → Full Control
UnknownUser → Modify
```

Especially for:

```text
C:\Windows
C:\Program Files
Security software directories
Application directories
System scripts
Service executables
```

Why?

```text
Writable executable
       ↓
Attacker modifies it
       ↓
Legitimate process executes it
       ↓
Malicious code runs
```

This is a common **privilege escalation/persistence concept**.

---

# 15. Practical Investigation

Suppose a Windows service runs:

```text
C:\Apps\MyService\service.exe
```

You discover ordinary users can modify `service.exe`.

Potential attack path:

```text
Low-privileged user
       ↓
Modify service executable
       ↓
Service runs as SYSTEM
       ↓
Malicious code executes
       ↓
Privilege escalation
```

Therefore, check:

```cmd
icacls C:\Apps\MyService\service.exe
```

You want to ensure only appropriate administrators/service owners can modify security-sensitive executables.

---

# 16. Practical Lab

Create a test folder:

```cmd
mkdir C:\NTFSLab
```

Create a file:

```cmd
echo Secret data > C:\NTFSLab\secret.txt
```

Check permissions:

```cmd
icacls C:\NTFSLab\secret.txt
```

Create a test user if you have permission:

```cmd
net user testuser * /add
```

Grant read access:

```cmd
icacls C:\NTFSLab /grant testuser:R
```

Check again:

```cmd
icacls C:\NTFSLab
```

Remove the test permission:

```cmd
icacls C:\NTFSLab /remove testuser
```

Clean up when finished:

```cmd
del C:\NTFSLab\secret.txt
rmdir C:\NTFSLab
```

---

# 17. Security Audit Commands

Find permissions on a sensitive directory:

```cmd
icacls C:\Windows
```

Check Program Files:

```cmd
icacls "C:\Program Files"
```

Check a service executable:

```cmd
icacls "C:\Path\service.exe"
```

Check ownership:

```cmd
icacls "C:\Path\service.exe"
```

For a broader investigation, PowerShell can also inspect ACLs:

```powershell
Get-Acl "C:\Path\service.exe"
```

---

# 18. Detection Thinking

When investigating a potentially compromised Windows machine:

```text
Suspicious executable
       ↓
Check owner
       ↓
Check ACL
       ↓
Who can modify it?
       ↓
What process executes it?
       ↓
Under which account?
```

Especially investigate:

```text
User-writable
      +
Privileged execution
```

Example:

```text
C:\App\service.exe
        ↓
Users → Modify
        ↓
Service → SYSTEM
```

This is a high-value privilege escalation finding.

---

# 19. Least Privilege

Good design:

```text
Normal Users
    ↓
Read

Application Account
    ↓
Required access only

Administrators
    ↓
Administrative control
```

Avoid:

```text
Everyone
   ↓
Full Control
```

The principle is:

> **Give the minimum permissions required to perform the job.**

---

# 20. Interview Questions

### Q1. What is NTFS?

The Windows filesystem that provides features including file permissions, ownership, auditing, and metadata.

### Q2. What is an ACL?

An Access Control List defines which users/groups can perform which actions on an object.

### Q3. What is inheritance?

Permissions inherited from a parent folder by a child object.

### Q4. What is `icacls`?

A Windows command-line utility for viewing and modifying NTFS permissions.

### Q5. Why are writable service executables dangerous?

If a low-privileged user can modify an executable that runs with SYSTEM privileges, they may be able to execute code with those higher privileges.

---

# 21. Quick Cheat Sheet

```cmd
:: View permissions
icacls C:\Folder

:: Grant Read
icacls C:\Folder /grant user:R

:: Grant Modify
icacls C:\Folder /grant user:M

:: Grant Full Control
icacls C:\Folder /grant user:F

:: Remove permission
icacls C:\Folder /remove user

:: Ownership
takeown /f C:\Folder /r /d Y
```

PowerShell:

```powershell
Get-Acl "C:\Folder"
```

## Core Mental Model

```text
User
 ↓
Groups
 ↓
Security Token
 ↓
NTFS ACL
 ↓
Inheritance
 ↓
Access Check
 ↓
Allow / Deny
```

### Cybersecurity principle

> **Always investigate who can modify security-sensitive files, not just who can read them.**

A low-privileged user with **write access to something executed by a highly privileged process** can create a serious privilege-escalation path.

**Next:** `04-Windows-Processes-Services.md`