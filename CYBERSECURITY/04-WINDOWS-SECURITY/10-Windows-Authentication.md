# `10-Windows-Authentication.md`

# Windows Authentication — Cybersecurity Notes

## 1. First Principle

**Authentication** answers:

> **"Who are you?"**

Windows uses authentication mechanisms to verify a user's identity before allowing access to resources.

Basic flow:

```text
User
 ↓
Credentials / Authentication Material
 ↓
Windows Authentication
 ↓
Identity Verified
 ↓
Security Token
 ↓
Authorization
 ↓
Resource Access
```

Remember:

```text
Authentication → Who are you?
Authorization  → What can you access?
```

---

# 2. Windows Authentication Methods

Common authentication mechanisms include:

```text
Kerberos
NTLM
Windows Hello
Smart Cards / Certificates
Local Account Authentication
```

In an Active Directory domain, **Kerberos is normally the preferred authentication protocol**, while NTLM may still exist for compatibility.

---

# 3. Local Authentication

A standalone Windows computer can authenticate users locally.

Example:

```text
Computer
 └── Local User
      ├── Username
      └── Password
```

The computer verifies the credentials against its local security database.

The important database is:

```text
SAM
```

**SAM = Security Accounts Manager**

It stores information about local accounts.

---

# 4. Domain Authentication

In an AD environment:

```text
User
 ↓
Domain Controller
 ↓
Kerberos / other authentication
 ↓
Identity verified
 ↓
Security token
 ↓
Access resources
```

Example:

```text
CORP\Yash
```

Here:

```text
CORP
 ↓
Domain

Yash
 ↓
User
```

---

# 5. Security Token

After authentication, Windows creates a **security access token** representing the user's security identity.

Conceptually:

```text
Authentication
      ↓
Security Token
      ↓
User SID
      +
Group SIDs
      +
Privileges
      ↓
Access Check
```

This is extremely important.

Windows generally doesn't ask:

> "Is this person Yash?"

for every file access.

Instead, the operating system checks the security token against the resource's security descriptor.

---

# 6. SID

**SID = Security Identifier**

Every Windows account has a unique SID.

Check your SID:

```cmd
whoami /user
```

Example:

```text
USER NAME     SID
CORP\User     S-1-5-21-...
```

The SID is more important internally than the username because usernames can change while the SID identifies the security principal.

---

# 7. Authentication vs Authorization

Consider:

```text
User logs in
     ↓
Authentication
     ↓
"Yes, this is UserA"
     ↓
Security Token
     ↓
Authorization
     ↓
"UserA can read this file"
```

Example:

```text
UserA
 ↓
Authenticated
 ↓
Member of Finance-Users
 ↓
Can access Finance share
```

---

# 8. NTLM

**NTLM** is an older Windows authentication protocol that uses a challenge-response mechanism.

Simplified:

```text
Client
  ↓
Authentication request
  ↓
Server sends challenge
  ↓
Client responds using password-derived authentication material
  ↓
Server verifies
```

The password itself is not simply sent across the network in plaintext.

However, NTLM has security weaknesses compared with modern Kerberos-based authentication and is often a focus of hardening efforts.

---

# 9. Kerberos vs NTLM

| Feature | Kerberos | NTLM |
|---|---|---|
| Main AD protocol | Yes | No |
| Ticket-based | Yes | No |
| KDC required | Yes | No |
| Mutual authentication | Supported | More limited |
| Modern domain environments | Preferred | Legacy/compatibility |

Mental model:

```text
AD environment
     ↓
Prefer Kerberos
     ↓
Reduce unnecessary NTLM
```

---

# 10. Windows Logon Types

Windows records different types of logons.

Important ones for security analysts:

| Logon Type | Meaning |
|---:|---|
| 2 | Interactive |
| 3 | Network |
| 4 | Batch |
| 5 | Service |
| 7 | Unlock |
| 8 | NetworkCleartext |
| 10 | RemoteInteractive / RDP |
| 11 | CachedInteractive |

### Example

If you see:

```text
Logon Type: 10
```

it generally indicates:

> Remote interactive logon, such as RDP.

---

# 11. Important Authentication Event IDs

### 4624 — Successful Logon

```text
4624
→ Successful account logon
```

### 4625 — Failed Logon

```text
4625
→ Failed account logon
```

### 4648 — Explicit Credentials

```text
4648
→ A process attempted to log on using explicitly supplied credentials
```

### 4672 — Special Privileges

```text
4672
→ Special privileges assigned to a new logon
```

These events are valuable for authentication investigations.

---

# 12. Practical SOC Scenario

Suppose an employee normally works:

```text
09:00–18:00
```

The SOC receives:

```text
4624
User: employee1
Logon Type: 10
Source IP: unusual address
Time: 03:15 AM
```

Don't immediately conclude:

```text
→ Account compromised
```

Investigate:

```text
User
 ↓
Logon time
 ↓
Logon type
 ↓
Source IP
 ↓
Source computer
 ↓
Authentication method
 ↓
What happened after login?
```

Look for:

- Multiple failed logins
- Successful login afterward
- New processes
- PowerShell activity
- Privilege changes
- File access
- Network connections

---

# 13. Brute Force vs Password Spraying

## Brute Force

Many passwords against one account.

```text
UserA
 ↓
Password1
Password2
Password3
Password4
...
```

## Password Spraying

One/few common passwords against many accounts.

```text
Password123
 ↓
UserA
UserB
UserC
UserD
...
```

Detection should look for patterns across:

```text
Multiple accounts
+
Multiple authentication failures
+
Common source
+
Short time period
```

---

# 14. Account Lockout

Organizations can configure account lockout policies.

Example:

```text
5 failed attempts
      ↓
Account locked
```

This can reduce brute-force risk.

However, aggressive lockout policies can also be abused to cause **denial of service** by repeatedly triggering lockouts.

Therefore organizations need balanced policies.

---

# 15. Multi-Factor Authentication

MFA adds another authentication factor.

Example:

```text
Password
   +
Authenticator approval
   ↓
Authentication
```

Common factors:

```text
Something you know
→ Password / PIN

Something you have
→ Phone / security key

Something you are
→ Biometrics
```

MFA can significantly reduce the impact of stolen passwords, although phishing-resistant methods provide stronger protection than simply relying on codes or push approvals.

---

# 16. Windows Hello

**Windows Hello** provides passwordless or reduced-password authentication options using mechanisms such as:

- PIN
- Biometrics
- Compatible security hardware

Important:

> A Windows Hello PIN is generally tied to a specific device rather than being a reusable network password.

---

# 17. RDP Authentication

**RDP = Remote Desktop Protocol**

Remote login commonly produces:

```text
Logon Type 10
```

Security teams should monitor:

- Unexpected RDP access
- Repeated failed RDP logins
- RDP from unusual locations
- Privileged accounts using RDP
- RDP followed by suspicious process execution

Mental model:

```text
RDP Login
   ↓
Authentication
   ↓
Interactive Session
   ↓
Process Activity
```

---

# 18. Investigating Current Sessions

Check current logged-on users:

```cmd
query user
```

or:

```cmd
quser
```

This can help identify active interactive sessions.

Check your identity:

```cmd
whoami
```

Check privileges:

```cmd
whoami /priv
```

Check groups:

```cmd
whoami /groups
```

---

# 19. Small Hands-On Lab

### Step 1 — Identify yourself

```cmd
whoami
```

### Step 2 — Get your SID

```cmd
whoami /user
```

### Step 3 — View groups

```cmd
whoami /groups
```

### Step 4 — View privileges

```cmd
whoami /priv
```

### Step 5 — Check current sessions

```cmd
query user
```

### Step 6 — Investigate successful logons

PowerShell:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4624
} -MaxEvents 10
```

This retrieves recent successful logon events.

---

# 20. Authentication Investigation Model

When investigating a login, ask:

```text
WHO?
 ↓
Which account?

WHAT?
 ↓
Which authentication event?

WHEN?
 ↓
What time?

WHERE?
 ↓
Source computer / IP?

HOW?
 ↓
Kerberos / NTLM / RDP / other?

WHAT NEXT?
 ↓
What did the account do after login?
```

This is the core SOC mindset.

---

# 21. Security Best Practices

Organizations should consider:

- Strong passwords
- MFA
- Prefer Kerberos where appropriate
- Reduce unnecessary NTLM
- Restrict RDP exposure
- Least privilege
- Account lockout policies
- Monitor privileged accounts
- Monitor unusual login locations/times
- Disable unused accounts
- Use dedicated administrative accounts
- Protect Domain Controllers

---

# 22. Interview Questions

### Q1. What is authentication?

The process of verifying the identity of a user, device, or service.

### Q2. What is a security token?

A Windows structure representing the security identity and privileges of an authenticated user or process.

### Q3. What is a SID?

A Security Identifier uniquely identifying a Windows security principal.

### Q4. What is NTLM?

A legacy Windows challenge-response authentication protocol still encountered for compatibility.

### Q5. What is Logon Type 10?

Remote Interactive logon, commonly associated with RDP.

### Q6. What is Event ID 4624?

Successful logon.

### Q7. What is Event ID 4625?

Failed logon.

### Q8. What is password spraying?

Trying a small number of commonly used passwords against many accounts.

### Q9. Why is MFA important?

It adds an additional authentication factor, reducing the impact of a stolen password.

---

# 23. Quick Cheat Sheet

```text
Authentication
→ Who are you?

Authorization
→ What can you access?

SID
→ Security Identifier

SAM
→ Local account security database

Kerberos
→ Primary AD authentication protocol

NTLM
→ Legacy/compatibility authentication

4624
→ Successful logon

4625
→ Failed logon

4648
→ Explicit credentials

4672
→ Special privileges assigned

Logon Type 2
→ Interactive

Logon Type 3
→ Network

Logon Type 5
→ Service

Logon Type 10
→ RDP / Remote Interactive

whoami
→ Current identity

whoami /user
→ SID

whoami /groups
→ Groups

whoami /priv
→ Privileges

query user
→ Current sessions
```

## Core Mental Model

```text
Credentials
     ↓
Authentication
     ↓
Identity / SID
     ↓
Security Token
     ↓
Groups + Privileges
     ↓
Authorization
     ↓
Resource Access
     ↓
Security Events
     ↓
Detection / Investigation
```

**Next:** `11-Windows-Hardening.md`