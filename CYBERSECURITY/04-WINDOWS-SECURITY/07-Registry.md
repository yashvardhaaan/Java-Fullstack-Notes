# `07-Windows-Registry.md`

# Windows Registry — Cybersecurity Notes

## 1. First Principle

The **Windows Registry** is a hierarchical database that stores configuration information used by:

- Windows
- Drivers
- Applications
- Users
- Services
- Security components

Think of it as:

```text
Windows / Application
        ↓
Registry Key
        ↓
Registry Value
        ↓
Configuration / Behavior
```

From a cybersecurity perspective, the Registry is important because attackers can sometimes use it for:

- Persistence
- Configuration changes
- Security evasion
- Application manipulation
- Investigation/forensics

---

# 2. Registry Structure

The Registry is organized into **hives → keys → subkeys → values**.

Example:

```text
HKEY_CURRENT_USER
 └── Software
      └── Microsoft
           └── Windows
                └── CurrentVersion
                     └── Run
```

A registry value contains data such as:

```text
Name        Data
----        ----
MyApp       C:\Users\User\AppData\MyApp.exe
```

---

# 3. Important Registry Hives

| Hive | Meaning | Typical use |
|---|---|---|
| `HKLM` | HKEY_LOCAL_MACHINE | System-wide configuration |
| `HKCU` | HKEY_CURRENT_USER | Current user's configuration |
| `HKCR` | HKEY_CLASSES_ROOT | File associations / COM |
| `HKU` | HKEY_USERS | User profiles |
| `HKCC` | HKEY_CURRENT_CONFIG | Current hardware profile |

### Important

For cybersecurity, remember:

```text
HKLM → machine-wide
HKCU → current user
```

---

# 4. Registry Tools

## Registry Editor

Run:

```text
regedit
```

It provides a graphical interface for viewing and modifying the Registry.

⚠️ Don't randomly modify Registry entries. Incorrect changes can affect Windows or applications.

---

# 5. `reg query`

Used to read Registry information from CMD.

Example:

```cmd
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
```

Meaning:

```text
reg query
    ↓
Read this registry location
```

Check machine-wide startup entries:

```cmd
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
```

---

# 6. PowerShell Registry Access

PowerShell treats the Registry somewhat like a filesystem.

Example:

```powershell
Get-Item "HKCU:\Software\Microsoft"
```

Read values:

```powershell
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
```

Meaning:

```text
Get-ItemProperty
        ↓
Read properties/values
        ↓
From the specified Registry key
```

---

# 7. Registry and Persistence

One major cybersecurity use of the Registry is **persistence**.

Persistence means:

> An attacker attempts to make malicious software execute again after reboot, login, or another event.

One commonly investigated location is:

```text
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
```

For example:

```text
Updater → C:\Users\User\AppData\Roaming\updater.exe
```

If an unknown program appears there, it deserves investigation.

Another location:

```text
HKLM\Software\Microsoft\Windows\CurrentVersion\Run
```

Difference:

```text
HKCU Run
→ affects current user

HKLM Run
→ can affect users on the machine
```

---

# 8. Practical Cybersecurity Scenario

### Situation

A user reports:

> "Every time I log in, a strange program starts."

A SOC analyst investigates:

```cmd
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
```

Suppose they find:

```text
Updater    C:\Users\User\AppData\Roaming\abc.exe
```

Now don't immediately conclude:

```text
abc.exe = malware
```

Instead investigate:

```text
Registry entry
      ↓
Executable path
      ↓
File exists?
      ↓
Digital signature
      ↓
File hash
      ↓
Process behavior
      ↓
Network connections
      ↓
Security events
```

---

# 9. Investigate the File

Check whether the file exists:

```powershell
Test-Path "C:\Users\User\AppData\Roaming\abc.exe"
```

Calculate its hash:

```powershell
Get-FileHash "C:\Users\User\AppData\Roaming\abc.exe"
```

Check file information:

```powershell
Get-Item "C:\Users\User\AppData\Roaming\abc.exe"
```

The hash can then be compared against your organization's threat-intelligence sources.

---

# 10. Registry Permissions

Registry keys also have security permissions.

Conceptually:

```text
User / Process
      ↓
Security Token
      ↓
Registry ACL
      ↓
Access allowed / denied
```

An attacker gaining excessive Registry write permissions may potentially modify configuration or persistence locations.

Therefore:

> Registry permissions should follow least privilege.

---

# 11. Safe Registry Lab

Create a harmless test key under your user account:

```powershell
New-Item -Path "HKCU:\Software\CyberLab" -Force
```

Create a test value:

```powershell
New-ItemProperty `
-Path "HKCU:\Software\CyberLab" `
-Name "TestValue" `
-Value "Hello" `
-PropertyType String
```

Read it:

```powershell
Get-ItemProperty "HKCU:\Software\CyberLab"
```

Remove the test key:

```powershell
Remove-Item "HKCU:\Software\CyberLab" -Recurse
```

### What you learned

```text
New-Item
    ↓
Create Registry key

New-ItemProperty
    ↓
Create Registry value

Get-ItemProperty
    ↓
Read value

Remove-Item
    ↓
Delete test key
```

Use a test location such as `HKCU:\Software\CyberLab` rather than experimenting with critical system keys.

---

# 12. Registry in Incident Response

During an investigation, analysts may examine Registry artifacts for:

- Startup/persistence entries
- Installed software
- User configuration
- Application settings
- Recently used information
- System configuration
- Security-related settings

But remember:

> A Registry entry is evidence, not automatically proof of malicious activity.

Always correlate with:

```text
Registry
   +
Process
   +
File
   +
Event Logs
   +
Network Activity
   =
Better Investigation
```

---

# 13. Detection Mindset

When you see a suspicious Registry modification, ask:

### WHO?

Which user/process made the change?

### WHAT?

Which Registry key/value changed?

### WHEN?

When did the modification occur?

### WHY?

Is there a legitimate software installation or update?

### WHERE?

Where does the referenced executable live?

### WHAT NEXT?

Does that executable create processes, files, network connections, or persistence?

This turns Registry analysis into an investigation rather than simply looking at keys.

---

# 14. Interview Questions

### Q1. What is the Windows Registry?

A hierarchical database containing configuration information for Windows, applications, users, and system components.

### Q2. What is the difference between HKCU and HKLM?

```text
HKCU → current user's configuration
HKLM → system-wide configuration
```

### Q3. Why is the Registry important in cybersecurity?

Because it can contain evidence of configuration changes, persistence mechanisms, installed software, and attacker activity.

### Q4. What is Registry persistence?

Using Registry configuration locations to cause a program to execute automatically during events such as user logon.

### Q5. How would you investigate suspicious startup persistence?

```text
Find Registry entry
      ↓
Identify executable
      ↓
Check path
      ↓
Hash/signature
      ↓
Investigate process behavior
      ↓
Correlate with logs/network activity
```

---

# 15. Quick Cheat Sheet

```text
Registry
→ Windows configuration database

HKLM
→ Machine-wide

HKCU
→ Current user

regedit
→ GUI Registry editor

reg query
→ Query Registry from CMD

Get-Item
→ Read Registry key

Get-ItemProperty
→ Read Registry values

Run keys
→ Common persistence locations

Get-FileHash
→ Calculate file hash

Registry investigation
→ Key + User + Time + Process + File + Network
```

## Core Mental Model

```text
Registry Change
      ↓
Who changed it?
      ↓
Which key/value?
      ↓
When?
      ↓
What executable/configuration?
      ↓
Is it legitimate?
      ↓
Correlate with other evidence
```

**Next:** `08-Windows-Active-Directory.md` — users, domains, domain controllers, Kerberos, LDAP, Group Policy, and AD attack/detection concepts.