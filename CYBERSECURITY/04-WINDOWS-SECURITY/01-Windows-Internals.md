Yes. We’ll follow **exactly this Windows Security structure**, one `.md` file at a time, with the same style as the Linux notes:

- First Principle
- Core concept
- Important commands/tools
- What each command means
- Practical cybersecurity scenario
- Detection / prevention
- Small hands-on lab
- Interview points
- Quick cheat sheet

Not unnecessarily long.

## `01-Windows-Internals.md`

# Windows Internals

## 1. First Principle

Windows is an operating system that manages:

```text
Hardware
   ↓
Windows Kernel
   ↓
Processes / Memory / Drivers
   ↓
Applications
   ↓
Users
```

The **kernel** is the core of Windows. It controls access to important system resources.

For cybersecurity, the key idea is:

> **Who is executing what, with which privileges, and what resources can it access?**

---

# 2. User Mode vs Kernel Mode

Windows separates execution into two major areas:

```text
User Mode
   ↓
Applications
Browsers
PowerShell
Services
   ↓
Windows APIs
   ↓
Kernel Mode
   ↓
Hardware / Memory / Drivers
```

### User Mode

Normal applications run here.

Examples:

```text
Chrome
PowerShell
Notepad
Python
```

If an application crashes, normally it should not crash the entire operating system.

### Kernel Mode

Highly privileged code runs here.

Examples:

- Windows kernel
- device drivers
- core system components

A compromised kernel-level component can have extremely high privileges.

---

# 3. Windows Kernel

The Windows kernel manages important resources such as:

```text
CPU
Memory
Processes
Threads
Devices
Security
File access
Networking
```

Security principle:

```text
Application
    ↓
Request resource
    ↓
Windows security checks
    ↓
Kernel
    ↓
Resource
```

This separation prevents ordinary applications from directly controlling everything.

---

# 4. Processes and Threads

A **process** is a running program.

A **thread** is an execution path inside a process.

```text
Process
 ├── Thread 1
 ├── Thread 2
 └── Thread 3
```

Example:

```text
chrome.exe
 ├── Browser thread
 ├── Network thread
 └── Rendering threads
```

Check processes:

```powershell
Get-Process
```

Find a specific process:

```powershell
Get-Process chrome
```

Or:

```cmd
tasklist
```

---

# 5. Process ID

Every running process has a **PID**.

PowerShell:

```powershell
Get-Process | Select-Object Name,Id
```

Example:

```text
Name        Id
----        --
explorer    4520
powershell  7812
```

Here:

```text
explorer → PID 4520
PowerShell → PID 7812
```

PID is important during incident investigation.

---

# 6. Parent and Child Processes

Processes can create other processes.

Example:

```text
explorer.exe
      ↓
powershell.exe
      ↓
cmd.exe
      ↓
whoami.exe
```

Security analysts care about **process relationships**.

For example:

```text
Word
 ↓
PowerShell
 ↓
cmd
 ↓
malicious.exe
```

This can be suspicious depending on context.

---

# 7. Windows Services

Many background applications run as services.

Examples:

```text
Windows Update
Windows Defender
Print Spooler
SQL Server
```

PowerShell:

```powershell
Get-Service
```

Find a specific service:

```powershell
Get-Service WinDefend
```

Start:

```powershell
Start-Service <ServiceName>
```

Stop:

```powershell
Stop-Service <ServiceName>
```

Security principle:

> An unexpected service can be a persistence mechanism.

---

# 8. Windows Registry

The Registry stores important Windows configuration.

Conceptually:

```text
Windows
   ↓
Registry
   ├── Users
   ├── Services
   ├── Software
   └── System configuration
```

Registry is especially important for security because attackers can abuse certain registry locations for:

- persistence
- configuration changes
- execution
- disabling security controls

We'll study it in detail in:

```text
07-Registry.md
```

---

# 9. Windows Security Boundary

Windows uses security identities and access controls.

A process can have a security context containing information such as:

```text
User
Groups
Privileges
Integrity level
```

Conceptually:

```text
User
 ↓
Token
 ↓
Process
 ↓
Access to resources
```

This becomes important when investigating **privilege escalation**.

---

# 10. Integrity Levels

Windows uses **Integrity Levels** to help restrict what processes can do.

Common levels include:

```text
Low
Medium
High
System
```

Typical example:

```text
Normal application
      ↓
Medium integrity

Administrator application
      ↓
High integrity

SYSTEM process
      ↓
System integrity
```

A security analyst should ask:

> Is this process running with more privileges than it actually needs?

---

# 11. Practical Investigation

Suppose you find a suspicious:

```text
powershell.exe
```

First identify it:

```powershell
Get-Process powershell
```

Find its PID:

```powershell
Get-Process powershell | Select-Object Name,Id,Path
```

Now investigate:

```text
Process
   ↓
PID
   ↓
Executable path
   ↓
Parent process
   ↓
User
   ↓
Network connections
```

This is the basic Windows process investigation mindset.

---

# 12. Practical Scenario

Imagine a user opens an unexpected document.

You observe:

```text
WINWORD.EXE
      ↓
powershell.exe
      ↓
cmd.exe
      ↓
unknown.exe
```

The process chain is suspicious because a document application launching a command shell and then an unknown executable can indicate malicious activity.

The correct response is **investigation**, not immediately assuming compromise.

Useful evidence:

```text
Process tree
Executable path
Command line
User
File hash
Network connections
Windows Event Logs
```

---

# 13. Basic Windows System Information

PowerShell:

```powershell
Get-ComputerInfo
```

Operating system information:

```powershell
Get-CimInstance Win32_OperatingSystem
```

Computer name:

```powershell
hostname
```

Current user:

```powershell
whoami
```

Windows version:

```cmd
winver
```

---

# 14. Practical Lab

Open **PowerShell**.

### Step 1 — Find current user

```powershell
whoami
```

### Step 2 — List processes

```powershell
Get-Process
```

### Step 3 — Find PowerShell

```powershell
Get-Process powershell
```

### Step 4 — List services

```powershell
Get-Service
```

### Step 5 — Check Windows Defender service

```powershell
Get-Service WinDefend
```

### Step 6 — Check OS

```powershell
Get-CimInstance Win32_OperatingSystem |
Select-Object Caption,Version
```

Try to answer:

```text
Who am I?
What processes are running?
What services are running?
Which security services are active?
What Windows version am I using?
```

---

# 15. Cybersecurity Relevance

Windows internals helps you understand:

```text
Processes
   ↓
Services
   ↓
Users
   ↓
Privileges
   ↓
Registry
   ↓
Event Logs
   ↓
Network Activity
```

These are the foundations of Windows attack detection.

---

# 16. Interview Questions

### Q1. What is the Windows kernel?

The privileged core of Windows responsible for managing resources such as memory, processes, hardware, and security mechanisms.

### Q2. Process vs thread?

```text
Process → running program/container
Thread  → execution unit inside a process
```

### Q3. What is PID?

A unique identifier assigned to a running process.

### Q4. Why is a process tree important?

It shows **which process created another process**, which is extremely useful for detecting suspicious execution chains.

### Q5. Why are Windows services important for cybersecurity?

Services run in the background and can be abused for persistence or privilege escalation.

---

# 17. Quick Cheat Sheet

```powershell
# Current user
whoami

# Processes
Get-Process
Get-Process <name>

# Process details
Get-Process | Select-Object Name,Id,Path

# Services
Get-Service
Get-Service <name>

# System information
Get-ComputerInfo

# OS information
Get-CimInstance Win32_OperatingSystem

# Hostname
hostname
```

## Core Mental Model

```text
Windows
   ↓
Kernel
   ↓
Processes + Threads
   ↓
Users + Security Tokens
   ↓
Privileges
   ↓
Resources
```

> **For a Windows Security Analyst, don't just learn commands. Learn to follow the chain: User → Process → Privilege → Resource → Event → Network.**

**Next:** `02-Windows-Users-Groups.md`