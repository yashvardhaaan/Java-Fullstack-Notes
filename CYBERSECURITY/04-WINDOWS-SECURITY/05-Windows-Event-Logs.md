# `05-Windows-Event-Logs.md`

# Windows Event Logs

## 1. First Principle

A Windows system continuously generates **events** describing what happened.

```text
User / Process / Service
        ↓
      Action
        ↓
   Windows Event
        ↓
    Event Log
        ↓
 Detection / Investigation
```

For cybersecurity:

> **Event logs provide evidence about activity that occurred on a Windows system.**

They can help answer:

- Who logged in?
- When?
- Which process started?
- Was an account created?
- Was a service installed?
- Did authentication fail?
- Was PowerShell executed?

---

# 2. Event Viewer

Windows provides a graphical tool called:

```text
Event Viewer
```

Open it:

```text
Win + R
```

Then:

```text
eventvwr.msc
```

Important locations:

```text
Windows Logs
 ├── Application
 ├── Security
 ├── System
 └── Setup
```

For cybersecurity, **Security** and **System** are especially important.

---

# 3. Windows Event Log Structure

An event commonly contains:

```text
Event ID
Time
Provider
Level
User
Computer
Message
```

Example:

```text
Event ID: 4624
Logon Type: 2
Account Name: admin
```

Think:

```text
Event ID
   ↓
What happened?
```

```text
Timestamp
   ↓
When?
```

```text
Account
   ↓
Who?
```

---

# 4. Important Security Event IDs

You should know these:

| Event ID | Meaning |
|---:|---|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4634 | Logoff |
| 4648 | Logon using explicit credentials |
| 4672 | Special privileges assigned to new logon |
| 4688 | New process created |
| 4720 | User account created |
| 4722 | User account enabled |
| 4728 | User added to security-enabled global group |
| 4732 | User added to security-enabled local group |
| 7045 | New service installed |

These IDs are extremely useful for Windows security monitoring.

---

# 5. Event ID 4624 — Successful Logon

```text
4624
```

means a successful logon occurred.

PowerShell:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4624
} -MaxEvents 10
```

This asks:

```text
Security log
   ↓
Find Event ID 4624
   ↓
Return recent events
```

During investigation, examine:

- account
- timestamp
- logon type
- source/network information
- authentication details

---

# 6. Event ID 4625 — Failed Logon

```text
4625
```

means an attempted logon failed.

Search:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
} -MaxEvents 20
```

A large number of failures may indicate:

```text
Password guessing
Brute force
Misconfigured application
Legitimate user mistakes
```

So:

> **Many failed logons are a signal, not automatically proof of an attack.**

---

# 7. Event ID 4688 — Process Creation

```text
4688
```

records process creation when appropriate auditing is enabled.

This is extremely valuable for security investigations.

Conceptually:

```text
User
 ↓
Process
 ↓
Command line
 ↓
Child process
```

For example:

```text
WINWORD.EXE
     ↓
powershell.exe
     ↓
cmd.exe
```

This process chain can reveal suspicious execution.

---

# 8. Event ID 4720 — New User

```text
4720
```

indicates that a user account was created.

Search:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4720
} -MaxEvents 10
```

Security question:

> Was this account creation expected?

Unexpected account creation can indicate:

- persistence
- unauthorized administration
- compromised credentials

---

# 9. Event ID 4732 — User Added to Local Group

```text
4732
```

can indicate a user was added to a security-enabled local group.

This is important when the group is:

```text
Administrators
```

Potential attack path:

```text
Compromised account
       ↓
Added to Administrators
       ↓
Higher privileges
       ↓
System compromise
```

Always investigate the **user, group, actor, and timestamp**.

---

# 10. Event ID 7045 — Service Installed

A new service can be a persistence mechanism.

Search:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='System'
    Id=7045
} -MaxEvents 10
```

Investigation:

```text
New service
   ↓
Service name
   ↓
Executable path
   ↓
Account used
   ↓
When installed?
   ↓
Was it authorized?
```

This connects directly with your previous topic:

```text
04-Windows-Processes-Services.md
```

---

# 11. Event ID 4672 — Special Privileges

```text
4672
```

indicates special privileges were assigned to a new logon.

This can help identify highly privileged sessions.

Investigation flow:

```text
4672
 ↓
Account
 ↓
Logon event
 ↓
What happened afterward?
```

Don't treat every 4672 event as malicious. Administrators and system accounts can legitimately generate these events.

---

# 12. PowerShell Logs

PowerShell can generate valuable security telemetry.

Useful logs may include:

```text
Microsoft-Windows-PowerShell/Operational
```

Query:

```powershell
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" -MaxEvents 20
```

For advanced detection, PowerShell logging such as **Script Block Logging** can provide much more visibility when properly configured.

---

# 13. Searching Events

Get recent Security events:

```powershell
Get-WinEvent -LogName Security -MaxEvents 20
```

Filter by Event ID:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
} -MaxEvents 20
```

Filter by time:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
    StartTime=(Get-Date).AddHours(-1)
}
```

This means:

```text
Security log
   ↓
Failed logons
   ↓
Only the last hour
```

---

# 14. Practical Investigation Scenario

Suppose an organization suspects an account was compromised.

Start with:

### Step 1 — Successful logons

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4624
} -MaxEvents 20
```

### Step 2 — Failed logons

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
} -MaxEvents 20
```

### Step 3 — Privileged activity

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4672
} -MaxEvents 20
```

### Step 4 — Process creation

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4688
} -MaxEvents 20
```

Now correlate:

```text
Login
 ↓
Privilege
 ↓
Process
 ↓
Network
 ↓
Action
```

This is the foundation of Windows event investigation.

---

# 15. Event Correlation

One event is often not enough.

Example:

```text
10:00 → 4625 Failed login
10:01 → 4625 Failed login
10:02 → 4624 Successful login
10:03 → 4672 Privileged logon
10:04 → 4688 PowerShell
10:05 → Network connection
```

Individually:

```text
Could be normal
```

Together:

```text
Potentially suspicious sequence
```

This is why SOC analysts use **correlation** rather than looking at events independently.

---

# 16. Practical Lab

Open PowerShell as Administrator.

### View recent Security events

```powershell
Get-WinEvent -LogName Security -MaxEvents 20
```

### Find failed logons

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
} -MaxEvents 10
```

### Find successful logons

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4624
} -MaxEvents 10
```

### Find process creation

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4688
} -MaxEvents 10
```

### Find newly installed services

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='System'
    Id=7045
} -MaxEvents 10
```

Try to determine:

```text
Who?
When?
What happened?
Which account?
Which process?
Was the activity expected?
```

---

# 17. Simple Event Monitoring Script

```powershell
Write-Host "===== FAILED LOGONS ====="

Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
} -MaxEvents 10

Write-Host "`n===== SUCCESSFUL LOGONS ====="

Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4624
} -MaxEvents 10

Write-Host "`n===== NEW SERVICES ====="

Get-WinEvent -FilterHashtable @{
    LogName='System'
    Id=7045
} -MaxEvents 10
```

This creates a basic security-event triage script.

---

# 18. Event Logs and SOC

In a real organization:

```text
Windows
   ↓
Event Logs
   ↓
SIEM / EDR
   ↓
Correlation
   ↓
Alert
   ↓
SOC Analyst
   ↓
Investigation
```

Examples of SIEM platforms include:

- Microsoft Sentinel
- Splunk
- Elastic

The Windows event log is therefore a **data source** for security monitoring.

---

# 19. What to Look For

High-value events include:

```text
Authentication
     ↓
4624 / 4625

Privilege
     ↓
4672

Process execution
     ↓
4688

Account creation
     ↓
4720

Group membership changes
     ↓
4728 / 4732

Service installation
     ↓
7045
```

Think:

> **Identity → Privilege → Execution → Persistence**

---

# 20. Interview Questions

### Q1. What is Windows Event Viewer?

A Windows interface for viewing and investigating system and application events.

### Q2. What does Event ID 4624 indicate?

Successful logon.

### Q3. What does Event ID 4625 indicate?

Failed logon.

### Q4. Why is Event ID 4688 important?

It records process creation when the relevant auditing is enabled, helping analysts investigate process execution.

### Q5. Why is Event ID 7045 important?

It can identify newly installed Windows services, which may be relevant to persistence investigations.

### Q6. Why is event correlation important?

Because a sequence of related events can reveal an attack that individual events don't make obvious.

---

# 21. Quick Cheat Sheet

```powershell
# Recent Security events
Get-WinEvent -LogName Security -MaxEvents 20

# Successful logon
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4624
}

# Failed logon
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4625
}

# Process creation
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4688
}

# New user
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    Id=4720
}

# New service
Get-WinEvent -FilterHashtable @{
    LogName='System'
    Id=7045
}

# PowerShell operational logs
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational"
```

## Core Mental Model

```text
Windows Activity
      ↓
Event
      ↓
Event ID
      ↓
Timestamp + User + Details
      ↓
Correlate Events
      ↓
Detect Suspicious Behavior
      ↓
Investigate
```

> **For a Windows Security Analyst, don't memorize Event IDs without understanding the story they tell: who acted, what happened, when it happened, and what happened immediately before and after.**

**Next:** `06-PowerShell-Security.md`