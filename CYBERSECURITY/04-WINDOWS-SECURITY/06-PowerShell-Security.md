# `06-PowerShell-Security.md`

# PowerShell for Cybersecurity

## 1. First Principle

PowerShell is both:

- a **Windows administration tool**
- a **powerful scripting language**

Think:

```text
PowerShell
    ↓
Windows APIs / System
    ↓
Processes
Files
Services
Users
Registry
Network
```

For cybersecurity, PowerShell is important because administrators use it for legitimate automation, while attackers can also abuse it for **execution, discovery, persistence, and post-compromise activity**.

The goal is not to avoid PowerShell.

> **Learn to recognize both legitimate and suspicious PowerShell behavior.**

---

# 2. PowerShell vs CMD

CMD:

```cmd
ipconfig
tasklist
whoami
```

PowerShell:

```powershell
Get-NetIPConfiguration
Get-Process
whoami
```

The major difference is that PowerShell works heavily with **objects**, not just text.

Example:

```powershell
Get-Process
```

returns process objects.

You can filter them directly:

```powershell
Get-Process | Where-Object {$_.CPU -gt 100}
```

Conceptually:

```text
Get data
   ↓
Object
   ↓
Filter
   ↓
Action
```

---

# 3. Cmdlets

PowerShell commands are commonly called **cmdlets**.

They usually follow:

```text
Verb-Noun
```

Examples:

```powershell
Get-Process
Get-Service
Get-User
Get-Item
Get-Content
```

Common verbs:

```text
Get
Set
New
Remove
Start
Stop
Invoke
```

This naming convention makes PowerShell easier to understand.

---

# 4. Getting Help

PowerShell has built-in help.

```powershell
Get-Help Get-Process
```

More detailed:

```powershell
Get-Help Get-Process -Detailed
```

Examples:

```powershell
Get-Help Get-Process -Examples
```

Find commands:

```powershell
Get-Command *Process*
```

This is useful when learning rather than memorizing every command.

---

# 5. System Enumeration

Get computer information:

```powershell
Get-ComputerInfo
```

Operating system:

```powershell
Get-CimInstance Win32_OperatingSystem
```

Current user:

```powershell
whoami
```

Hostname:

```powershell
hostname
```

These are basic **system discovery** commands.

---

# 6. Process Discovery

List processes:

```powershell
Get-Process
```

Find PowerShell:

```powershell
Get-Process powershell
```

Sort by CPU:

```powershell
Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 10
```

Why this matters:

```text
Process
   ↓
PID
   ↓
Executable
   ↓
Command line
   ↓
Parent
```

This is the same investigation model from the previous Windows notes.

---

# 7. Service Discovery

List services:

```powershell
Get-Service
```

Running services:

```powershell
Get-Service |
Where-Object {$_.Status -eq "Running"}
```

Find a specific service:

```powershell
Get-Service WinDefend
```

For detailed information:

```powershell
Get-CimInstance Win32_Service |
Select-Object Name,State,StartMode,StartName,PathName
```

Security use:

> Identify unexpected services or services running with excessive privileges.

---

# 8. File Investigation

List files:

```powershell
Get-ChildItem
```

Equivalent to:

```cmd
dir
```

Find a specific file:

```powershell
Get-ChildItem C:\Users -Recurse -Filter "*.exe"
```

Read a file:

```powershell
Get-Content C:\Temp\test.txt
```

Check file information:

```powershell
Get-Item C:\Temp\test.exe
```

Calculate hash:

```powershell
Get-FileHash C:\Temp\test.exe
```

Hashing is useful for identifying files and comparing them against known indicators.

---

# 9. Network Discovery

View IP configuration:

```powershell
Get-NetIPConfiguration
```

View network adapters:

```powershell
Get-NetAdapter
```

View TCP connections:

```powershell
Get-NetTCPConnection
```

Listening connections:

```powershell
Get-NetTCPConnection -State Listen
```

Find connections belonging to a process:

```powershell
Get-NetTCPConnection -OwningProcess 5000
```

Security question:

> Which process is communicating with which remote system?

---

# 10. PowerShell Pipeline

One of the most important concepts:

```text
Command A
   ↓
|
   ↓
Command B
```

Example:

```powershell
Get-Process |
Where-Object {$_.CPU -gt 100}
```

Meaning:

```text
Get processes
      ↓
Send process objects
      ↓
Keep CPU > 100
```

Another example:

```powershell
Get-Service |
Where-Object {$_.Status -eq "Running"} |
Select-Object Name,Status
```

This is extremely useful for security automation.

---

# 11. Variables

```powershell
$user = whoami

Write-Host "Current user: $user"
```

Another example:

```powershell
$process = Get-Process powershell

$process.Id
$process.Path
```

Variables let scripts store and reuse information.

---

# 12. Conditions

PowerShell can make decisions.

```powershell
$service = Get-Service WinDefend

if ($service.Status -eq "Running") {
    Write-Host "Defender is running"
}
else {
    Write-Host "Check Defender status"
}
```

Security automation can use this pattern to detect configuration problems.

---

# 13. Practical Security Script

```powershell
Write-Host "===== WINDOWS SECURITY CHECK ====="

Write-Host "`n[USER]"
whoami

Write-Host "`n[HOST]"
hostname

Write-Host "`n[DEFENDER]"
Get-Service WinDefend |
Select-Object Name,Status

Write-Host "`n[LISTENING PORTS]"
Get-NetTCPConnection -State Listen |
Select-Object LocalAddress,LocalPort,OwningProcess

Write-Host "`n[TOP PROCESSES]"
Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 10 Name,Id,CPU
```

This performs basic:

```text
Identity
 ↓
Security service
 ↓
Network exposure
 ↓
Process inspection
```

---

# 14. PowerShell in Attacks

Attackers may use PowerShell because it is:

```text
Already installed
      +
Powerful
      +
Can interact with Windows APIs
      +
Can automate tasks
```

Suspicious examples may include:

```text
PowerShell
 ↓
Encoded command
 ↓
Downloads content
 ↓
Executes content
```

or:

```text
Office application
 ↓
PowerShell
 ↓
Suspicious script
```

Again:

> PowerShell itself is **not malicious**.

The **behavior and context** matter.

---

# 15. Encoded Commands

You may encounter:

```powershell
powershell.exe -EncodedCommand ...
```

This can be legitimate, but it deserves investigation because encoding can make command-line content harder to read.

Security analyst workflow:

```text
Encoded command
      ↓
Decode safely
      ↓
Understand behavior
      ↓
Check parent process
      ↓
Check user
      ↓
Check network activity
```

Do not blindly execute suspicious decoded commands.

---

# 16. PowerShell Logging

PowerShell can generate logs that help defenders understand execution.

Useful log:

```text
Microsoft-Windows-PowerShell/Operational
```

View:

```powershell
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" -MaxEvents 20
```

Advanced environments may enable:

- Script Block Logging
- Module Logging
- Transcription

These improve visibility into PowerShell activity.

---

# 17. Practical Investigation Scenario

Suppose you receive an alert:

```text
powershell.exe
```

Don't immediately kill it.

Investigate:

### Step 1 — Find process

```powershell
Get-Process powershell
```

### Step 2 — Find command line

```powershell
Get-CimInstance Win32_Process |
Where-Object {$_.Name -eq "powershell.exe"} |
Select-Object ProcessId,ParentProcessId,CommandLine
```

### Step 3 — Check parent

```text
Word → PowerShell
```

This is more suspicious than:

```text
Administrator → PowerShell
```

### Step 4 — Check network

```powershell
Get-NetTCPConnection -OwningProcess <PID>
```

### Step 5 — Check file activity / downloaded files

```powershell
Get-ChildItem C:\Users\Public
```

Now correlate:

```text
User
 ↓
Parent
 ↓
PowerShell
 ↓
Command
 ↓
File
 ↓
Network
```

---

# 18. Practical Lab

Run these commands in PowerShell:

### Identity

```powershell
whoami /all
```

### Processes

```powershell
Get-Process | Select-Object Name,Id,Path
```

### Services

```powershell
Get-Service
```

### Network

```powershell
Get-NetTCPConnection
```

### Files

```powershell
Get-ChildItem C:\Temp -ErrorAction SilentlyContinue
```

### Event logs

```powershell
Get-WinEvent -LogName Security -MaxEvents 10
```

Try to build this mental picture:

```text
Who am I?
   ↓
What is running?
   ↓
What services exist?
   ↓
What network connections exist?
   ↓
What security events occurred?
```

---

# 19. PowerShell Security Mindset

When you see PowerShell execution, investigate:

```text
WHO?
 ↓
Which user?

WHAT?
 ↓
Which command?

PARENT?
 ↓
Who launched PowerShell?

WHERE?
 ↓
What files/scripts?

NETWORK?
 ↓
Where did it connect?

WHEN?
 ↓
What happened before/after?
```

This turns PowerShell from just a command-line tool into a **security investigation source**.

---

# 20. Interview Questions

### Q1. What is PowerShell?

A Windows command shell and scripting language designed for administration and automation.

### Q2. Why is PowerShell important in cybersecurity?

Because it provides powerful access to Windows systems and is widely used by both administrators and attackers.

### Q3. What is the PowerShell pipeline?

It passes objects from one command to another for filtering, transformation, and processing.

### Q4. How would you investigate suspicious PowerShell?

```text
Process
 ↓
Command line
 ↓
Parent process
 ↓
User
 ↓
Files
 ↓
Network
 ↓
Event logs
```

### Q5. Is PowerShell itself malicious?

No. It is a legitimate Windows administration technology. Suspiciousness depends on behavior and context.

---

# 21. Quick Cheat Sheet

```powershell
# Help
Get-Help <command>
Get-Command *Process*

# System
Get-ComputerInfo
whoami
hostname

# Processes
Get-Process
Get-Process <name>

# Services
Get-Service

# Files
Get-ChildItem
Get-Content
Get-Item
Get-FileHash

# Network
Get-NetIPConfiguration
Get-NetAdapter
Get-NetTCPConnection

# Events
Get-WinEvent -LogName Security -MaxEvents 20

# Pipeline
Get-Process | Where-Object {$_.CPU -gt 100}
```

## Core Mental Model

```text
PowerShell
    ↓
Windows APIs
    ↓
System Discovery
    ↓
Process / Files / Services / Network
    ↓
Automation
    ↓
Security Investigation
```

> **For a Windows Security Analyst, PowerShell is both a tool you use for investigation and a source of telemetry you must learn to detect.**

**Next:** `07-Windows-Registry.md`