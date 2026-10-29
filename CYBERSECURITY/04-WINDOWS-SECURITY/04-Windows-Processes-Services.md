# `04-Windows-Processes-Services.md`

# Windows Processes & Services

## 1. First Principle

A Windows system is basically a collection of **processes performing work**.

```text
Program
   ↓
Process
   ↓
Threads
   ↓
CPU + Memory + Files + Network
```

A **service** is a special type of background application designed to operate without requiring a user to interact with it.

For cybersecurity, the key question is:

> **What is running, who started it, with which privileges, and what is it doing?**

---

# 2. Process vs Service

### Process

A running instance of a program.

Example:

```text
chrome.exe
powershell.exe
notepad.exe
```

View processes:

```powershell
Get-Process
```

### Service

A background program managed by Windows Service Control Manager.

Examples:

```text
Windows Defender
Windows Update
Print Spooler
```

View services:

```powershell
Get-Service
```

Mental model:

```text
Service
   ↓
Starts
   ↓
Process
   ↓
Does work
```

---

# 3. Process ID — PID

Every running process has a PID.

```powershell
Get-Process | Select-Object Name,Id
```

Example:

```text
Name          Id
----          --
explorer      4200
powershell    7800
```

You can investigate PID `7800`:

```powershell
Get-Process -Id 7800
```

PID is important because Windows security tools and logs often reference processes using their PID.

---

# 4. Process Details

Get more information:

```powershell
Get-Process powershell | Format-List *
```

Useful information includes:

- Process name
- PID
- CPU usage
- Memory
- Path
- Start time
- Parent process information, depending on the object/tool used

A simpler view:

```powershell
Get-Process powershell |
Select-Object Name,Id,Path,StartTime
```

---

# 5. Task Manager

Windows provides a graphical process viewer:

```text
Ctrl + Shift + Esc
```

Task Manager can show:

- CPU
- Memory
- Disk
- Network
- Processes
- Startup applications
- Services

For a security analyst, Task Manager is useful for **quick inspection**, but deeper investigation usually requires PowerShell, Event Logs, Sysmon, EDR, or other security tools.

---

# 6. Process Tree

A process tree shows parent-child relationships.

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

This relationship is extremely important for detection.

A suspicious example could be:

```text
winword.exe
     ↓
powershell.exe
     ↓
cmd.exe
     ↓
unknown.exe
```

The chain doesn't automatically prove malware, but it is a strong investigation signal.

---

# 7. Finding the Parent Process

PowerShell:

```powershell
Get-CimInstance Win32_Process |
Select-Object ProcessId,ParentProcessId,Name
```

Example:

```text
Name          ProcessId   ParentProcessId
----          ---------   ---------------
powershell    5000        4200
```

Meaning:

```text
PID 4200
   ↓
created
   ↓
PID 5000
```

To investigate a process:

```powershell
Get-CimInstance Win32_Process -Filter "ProcessId=5000" |
Select-Object Name,ProcessId,ParentProcessId,CommandLine
```

The **command line** is often extremely valuable during malware investigations.

---

# 8. Command Line

Two processes can have the same executable but behave differently depending on their arguments.

Example:

```text
powershell.exe
```

versus:

```text
powershell.exe -File C:\Scripts\backup.ps1
```

Inspect command lines:

```powershell
Get-CimInstance Win32_Process |
Select-Object Name,ProcessId,CommandLine
```

Security analysts look for:

```text
Encoded commands
Unexpected scripts
Downloads
Hidden execution
Unusual paths
Suspicious arguments
```

---

# 9. Process Path

Knowing the executable location is important.

Example:

```text
C:\Windows\System32\svchost.exe
```

versus:

```text
C:\Users\Public\svchost.exe
```

The names are the same, but the locations are very different.

Get process path:

```powershell
Get-Process powershell |
Select-Object Name,Path
```

Security principle:

> **Never trust a process name alone. Check its path.**

---

# 10. Process Network Connections

You can investigate network connections associated with a process.

First find the PID:

```powershell
Get-Process
```

Then:

```powershell
Get-NetTCPConnection -OwningProcess 5000
```

Example:

```text
LocalPort  RemoteAddress    RemotePort
---------  -------------    ----------
51520      203.0.113.50     443
```

Now you can correlate:

```text
Process
 ↓
PID
 ↓
Remote IP
 ↓
Remote Port
```

This is a basic incident-response technique.

---

# 11. Windows Services

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

Check service details:

```powershell
Get-CimInstance Win32_Service |
Where-Object {$_.Name -eq "WinDefend"} |
Select-Object Name,State,StartMode,StartName,PathName
```

Important fields:

```text
State
StartMode
StartName
PathName
```

---

# 12. Service Startup Types

Common startup modes:

```text
Automatic
Manual
Disabled
```

Conceptually:

```text
Automatic
   ↓
Starts automatically

Manual
   ↓
Starts when requested

Disabled
   ↓
Cannot normally start
```

Check:

```powershell
Get-CimInstance Win32_Service |
Select-Object Name,State,StartMode
```

---

# 13. Why Services Matter in Cybersecurity

Attackers may create malicious services for persistence.

Example:

```text
Attacker
   ↓
Obtains privileged access
   ↓
Creates malicious service
   ↓
Service starts automatically
   ↓
Malware executes
```

A suspicious service may have:

```text
Unknown name
Unusual executable path
SYSTEM privileges
Automatic startup
Executable in user-writable directory
```

Again:

> These are indicators for investigation, not automatic proof of compromise.

---

# 14. Investigating a Suspicious Service

Suppose you discover:

```text
UpdaterService
```

Check it:

```powershell
Get-CimInstance Win32_Service |
Where-Object {$_.Name -eq "UpdaterService"} |
Select-Object Name,State,StartMode,StartName,PathName
```

You might discover:

```text
StartName : LocalSystem
PathName  : C:\Users\Public\update.exe
```

This deserves investigation because:

```text
LocalSystem
     +
Executable in unusual location
     +
Automatic service
```

Check the file:

```powershell
Get-Item "C:\Users\Public\update.exe"
```

Calculate hash:

```powershell
Get-FileHash "C:\Users\Public\update.exe"
```

Then investigate its process and network activity.

---

# 15. Service → Process Investigation

Use this chain:

```text
Service
   ↓
PathName
   ↓
Executable
   ↓
Process/PID
   ↓
User
   ↓
Network
```

Example:

```powershell
Get-CimInstance Win32_Service |
Where-Object {$_.Name -eq "UpdaterService"} |
Select-Object Name,StartName,PathName
```

Then:

```powershell
Get-Process
```

Then investigate the executable:

```powershell
Get-FileHash "C:\Path\program.exe"
```

---

# 16. Practical Scenario — Suspicious PowerShell

Suppose EDR reports:

```text
powershell.exe
PID: 6400
```

Investigate:

### Step 1 — Process

```powershell
Get-Process -Id 6400
```

### Step 2 — Command line

```powershell
Get-CimInstance Win32_Process -Filter "ProcessId=6400" |
Select-Object Name,CommandLine,ParentProcessId
```

### Step 3 — Parent

Find the parent PID:

```text
ParentProcessId = 5200
```

Then:

```powershell
Get-Process -Id 5200
```

### Step 4 — Network

```powershell
Get-NetTCPConnection -OwningProcess 6400
```

Now you have:

```text
Parent
  ↓
PowerShell
  ↓
Command line
  ↓
Network connection
```

This is the core of process triage.

---

# 17. Process Termination

You can terminate a process:

```powershell
Stop-Process -Id 6400
```

Force termination:

```powershell
Stop-Process -Id 6400 -Force
```

Use force carefully.

During incident response, **collect evidence before terminating a suspicious process when practical**, because stopping it may destroy useful volatile evidence.

---

# 18. Service Management

Start:

```powershell
Start-Service <ServiceName>
```

Stop:

```powershell
Stop-Service <ServiceName>
```

Restart:

```powershell
Restart-Service <ServiceName>
```

Check:

```powershell
Get-Service <ServiceName>
```

Don't stop security services simply because they are unfamiliar. First determine what they are and why they exist.

---

# 19. Practical Lab

Open PowerShell.

### Step 1 — List processes

```powershell
Get-Process
```

### Step 2 — Find PowerShell

```powershell
Get-Process powershell
```

### Step 3 — Find its PID

```powershell
Get-Process powershell |
Select-Object Name,Id,Path
```

### Step 4 — Investigate command line

```powershell
Get-CimInstance Win32_Process |
Where-Object {$_.Name -eq "powershell.exe"} |
Select-Object Name,ProcessId,ParentProcessId,CommandLine
```

### Step 5 — List services

```powershell
Get-Service
```

### Step 6 — Check Defender

```powershell
Get-CimInstance Win32_Service |
Where-Object {$_.Name -eq "WinDefend"} |
Select-Object Name,State,StartMode,StartName,PathName
```

Try to answer:

```text
What is running?
Who started it?
What command launched it?
What privileges does it have?
Is it communicating over the network?
```

---

# 20. Detection Mental Model

When you see a suspicious process:

```text
        PROCESS
           ↓
         PID
           ↓
    Parent Process
           ↓
      Command Line
           ↓
    Executable Path
           ↓
       User/Token
           ↓
    Network Connections
           ↓
       File Activity
```

This is much more useful than simply asking:

> "Is the process name suspicious?"

---

# 21. Common Suspicious Indicators

Investigate combinations such as:

```text
Office application
      ↓
PowerShell
      ↓
Network connection
```

or:

```text
Unknown service
      ↓
SYSTEM
      ↓
Executable in user-writable directory
```

or:

```text
Browser
      ↓
Unexpected command shell
      ↓
Unknown executable
```

Context matters. Legitimate administration and software updates can produce unusual-looking process chains.

---

# 22. Interview Questions

### Q1. Process vs service?

A process is a running instance of a program. A service is a background application managed by Windows' service infrastructure.

### Q2. Why is ParentProcessId important?

It helps establish **which process created another process**, which is valuable for detecting suspicious execution chains.

### Q3. How do you inspect a process command line?

```powershell
Get-CimInstance Win32_Process |
Select-Object Name,ProcessId,CommandLine
```

### Q4. How do you find services running as SYSTEM?

```powershell
Get-CimInstance Win32_Service |
Where-Object {$_.StartName -eq "LocalSystem"} |
Select-Object Name,State,PathName
```

### Q5. Why is an executable in a user-writable directory suspicious for a SYSTEM service?

Because a lower-privileged user may potentially modify the executable and cause malicious code to execute with SYSTEM privileges.

---

# 23. Quick Cheat Sheet

```powershell
# Processes
Get-Process
Get-Process -Id <PID>

# Process details
Get-Process | Select Name,Id,Path

# Process command lines
Get-CimInstance Win32_Process |
Select Name,ProcessId,ParentProcessId,CommandLine

# Services
Get-Service

# Service details
Get-CimInstance Win32_Service |
Select Name,State,StartMode,StartName,PathName

# Network connections
Get-NetTCPConnection -OwningProcess <PID>

# File hash
Get-FileHash "C:\path\file.exe"

# Stop process
Stop-Process -Id <PID>
```

## Core Mental Model

```text
Windows Process
      ↓
PID
      ↓
Parent
      ↓
Command Line
      ↓
Executable
      ↓
User / Privileges
      ↓
Network
      ↓
Behavior
```

> **For a Windows Security Analyst, process investigation is about understanding behavior and relationships—not just looking at process names.**

**Next:** `05-Windows-Event-Logs.md`