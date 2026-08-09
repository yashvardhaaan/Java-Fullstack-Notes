# Windows Scripting Basics

> Practical CMD + Batch + PowerShell notes for IT support and internship preparation.

---

# 1. CMD Basics

## 1.1 `cd` — Change Directory

### What it does

Moves to another folder.

### Syntax

```cmd
cd <folder>
```

### Examples

```cmd
cd Documents
```

Go to the parent folder:

```cmd
cd ..
```

Go to the root of the current drive:

```cmd
cd \
```

Change to a specific location:

```cmd
cd C:\Users\Yash\Documents
```

### Practical use

Used constantly when navigating through the Windows file system.

---

# 2. `dir` — List Files and Folders

### What it does

Displays files and folders in the current directory.

```cmd
dir
```

Useful options:

```cmd
dir /a
```

Shows hidden files.

```cmd
dir /s
```

Lists files in the current directory and subdirectories.

```cmd
dir /b
```

Displays a simple list of names.

### Practical use

Use it to inspect what exists inside a directory.

---

# 3. `cls` — Clear Screen

```cmd
cls
```

Clears the CMD window.

---

# 4. `mkdir` — Create Directory

Creates a new folder.

```cmd
mkdir project
```

You can also use:

```cmd
md project
```

Example:

```cmd
mkdir GitNotes
cd GitNotes
```

---

# 5. `rmdir` — Remove Directory

Removes a directory.

```cmd
rmdir folder
```

Remove a directory and its contents:

```cmd
rmdir /s folder
```

Remove without confirmation:

```cmd
rmdir /s /q folder
```

> **Be careful:** `/s /q` can permanently delete files.

---

# 6. `copy` — Copy Files

Copies one or more files.

```cmd
copy file.txt backup.txt
```

Copy to another directory:

```cmd
copy file.txt C:\Backup\
```

---

# 7. `move` — Move Files

Moves a file or folder.

```cmd
move file.txt C:\Backup\
```

Rename using `move`:

```cmd
move old.txt new.txt
```

---

# 8. `del` — Delete Files

Deletes files.

```cmd
del file.txt
```

Delete multiple files:

```cmd
del *.txt
```

> **Be careful:** deleted files using `del` may not go to the Recycle Bin.

---

# 9. `ren` — Rename

Renames a file or folder.

```cmd
ren old.txt new.txt
```

Example:

```cmd
ren test.txt notes.txt
```

---

# 10. `type` — Display File Contents

Displays text inside a file.

```cmd
type notes.txt
```

Useful for quickly reading text files from CMD.

---

# 11. `echo`

Displays text.

```cmd
echo Hello
```

Output:

```text
Hello
```

Create a file:

```cmd
echo Hello World > test.txt
```

Append to a file:

```cmd
echo Another line >> test.txt
```

---

# 12. `where`

Finds the location of an executable.

```cmd
where java
```

Example:

```cmd
where git
```

This is useful for checking whether a program is available in the system `PATH`.

---

# 13. `set`

Displays or creates environment variables.

Show variables:

```cmd
set
```

Create a variable:

```cmd
set NAME=Yash
```

Use it:

```cmd
echo %NAME%
```

Output:

```text
Yash
```

---

# 14. `hostname`

Displays the computer's hostname.

```cmd
hostname
```

### Practical use

Useful when identifying a machine during IT support.

---

# 15. `whoami`

Displays the currently logged-in user.

```cmd
whoami
```

Example output:

```text
DESKTOP-123ABC\Yash
```

### Practical use

Useful for checking which Windows account is currently being used.

---

# 16. `systeminfo`

Displays detailed Windows system information.

```cmd
systeminfo
```

Information can include:

* OS version
* Host name
* RAM
* Windows installation date
* System manufacturer
* System model
* Processor information
* Windows updates

### Practical use

Useful for collecting basic system information during troubleshooting.

---

# 17. `ver`

Displays the Windows version.

```cmd
ver
```

---

# 18. `tasklist`

Displays currently running processes.

```cmd
tasklist
```

Find a specific process:

```cmd
tasklist | findstr chrome
```

### Practical use

Useful when checking whether an application is running or consuming resources.

---

# 19. `taskkill`

Terminates a running process.

Using process name:

```cmd
taskkill /IM notepad.exe
```

Force termination:

```cmd
taskkill /F /IM notepad.exe
```

Using PID:

```cmd
taskkill /PID 1234 /F
```

### Practical use

Useful when an application has frozen and cannot be closed normally.

---

# 20. `ipconfig`

Displays network configuration.

```cmd
ipconfig
```

Detailed information:

```cmd
ipconfig /all
```

Release DHCP address:

```cmd
ipconfig /release
```

Request a new DHCP address:

```cmd
ipconfig /renew
```

Clear DNS cache:

```cmd
ipconfig /flushdns
```

### Practical use

One of the most important Windows networking commands.

---

# 21. `ping`

Tests network connectivity.

```cmd
ping google.com
```

Ping an IP address:

```cmd
ping 8.8.8.8
```

Send a specific number of packets:

```cmd
ping -n 10 google.com
```

### What it helps identify

* Network connectivity
* Packet loss
* Latency
* DNS resolution problems

Example:

```text
ping 8.8.8.8
```

If this works but:

```text
ping google.com
```

fails, DNS may be the problem.

---

# 22. `tracert`

Shows the route packets take to a destination.

```cmd
tracert google.com
```

### Practical use

Useful when investigating where network connectivity is failing.

---

# 23. `nslookup`

Queries DNS information.

```cmd
nslookup google.com
```

You can query a specific DNS server:

```cmd
nslookup google.com 8.8.8.8
```

### Practical use

Useful for diagnosing DNS problems.

---

# 24. `netstat`

Displays network connections and listening ports.

```cmd
netstat
```

Show ports and process IDs:

```cmd
netstat -ano
```

Continuously display:

```cmd
netstat -ano 5
```

### Important options

```text
-a    All connections and listening ports
-n    Show numerical addresses
-o    Show process ID
```

Example:

```cmd
netstat -ano
```

You can then identify the process using:

```cmd
tasklist
```

---

# 25. `arp`

Displays the ARP cache.

```cmd
arp -a
```

### Practical use

Useful for basic local-network troubleshooting.

---

# 26. `pathping`

Combines features of `ping` and `tracert`.

```cmd
pathping google.com
```

Useful for analyzing:

* Network latency
* Packet loss
* Network path

---

# 27. `route`

Displays or modifies the routing table.

View routes:

```cmd
route print
```

### Practical use

Useful for advanced network troubleshooting.

---

# 28. `getmac`

Displays MAC addresses.

```cmd
getmac
```

More detailed:

```cmd
getmac /v
```

---

# 29. `driverquery`

Displays installed device drivers.

```cmd
driverquery
```

### Practical use

Useful for troubleshooting driver-related problems.

---

# 30. `chkdsk`

Checks a disk for file-system errors.

```cmd
chkdsk
```

Check and attempt repairs:

```cmd
chkdsk C: /f
```

> Some operations may require administrator privileges or a restart.

---

# 31. `sfc`

System File Checker scans protected Windows system files.

```cmd
sfc /scannow
```

### Practical use

Useful when Windows system files may be corrupted.

> Usually run from an elevated Command Prompt.

---

# 32. `DISM`

Deployment Image Servicing and Management.

Check Windows image health:

```cmd
DISM /Online /Cleanup-Image /CheckHealth
```

Scan:

```cmd
DISM /Online /Cleanup-Image /ScanHealth
```

Repair:

```cmd
DISM /Online /Cleanup-Image /RestoreHealth
```

### Practical use

Useful for repairing Windows component-store problems.

---

# 33. `shutdown`

Shuts down or restarts Windows.

Shutdown:

```cmd
shutdown /s /t 0
```

Restart:

```cmd
shutdown /r /t 0
```

Cancel a scheduled shutdown:

```cmd
shutdown /a
```

---

# 34. `gpupdate`

Refreshes Group Policy settings.

```cmd
gpupdate
```

Force update:

```cmd
gpupdate /force
```

### Practical use

Common in Windows/domain environments.

---

# 35. `net`

The `net` command provides several network and Windows administration functions.

View running services:

```cmd
net start
```

Start a service:

```cmd
net start <service>
```

Stop a service:

```cmd
net stop <service>
```

Example:

```cmd
net stop Spooler
```

---

# 36. `sc`

Service Controller command.

Query a service:

```cmd
sc query Spooler
```

Start:

```cmd
sc start Spooler
```

Stop:

```cmd
sc stop Spooler
```

### Practical use

Useful for service troubleshooting and automation.

---

# 37. Batch Scripting

A batch file usually has:

```text
.bat
```

extension.

Example:

```bat
@echo off

echo System Information
hostname
whoami
ipconfig

pause
```

Save it as:

```text
system-info.bat
```

Run it from CMD.

---

# 38. Batch Variables

Create a variable:

```bat
@echo off

set NAME=Yash

echo Hello %NAME%

pause
```

Output:

```text
Hello Yash
```

---

# 39. Batch `if`

```bat
@echo off

if exist test.txt (
    echo File exists
) else (
    echo File does not exist
)

pause
```

### Practical use

Useful for checking whether files, folders, or conditions exist before performing an action.

---

# 40. Batch `for`

Loop through files:

```bat
@echo off

for %%f in (*.txt) do (
    echo %%f
)

pause
```

This prints all `.txt` files.

---

# 41. Batch `pause`

Pauses execution.

```bat
pause
```

Usually used at the end of scripts so the CMD window remains visible.

---

# 42. Batch `@echo off`

```bat
@echo off
```

Prevents commands themselves from being displayed while the script runs.

Example:

```bat
@echo off

echo Starting script...
hostname
ipconfig

pause
```

---

# 43. PowerShell

PowerShell is Microsoft's modern command-line shell and scripting environment.

Start PowerShell from:

```text
Start Menu → PowerShell
```

or:

```cmd
powershell
```

---

# 44. `Get-Help`

Provides help about PowerShell commands.

```powershell
Get-Help Get-Process
```

Detailed help:

```powershell
Get-Help Get-Process -Detailed
```

Examples:

```powershell
Get-Help Get-Process -Examples
```

---

# 45. `Get-Command`

Finds available commands.

```powershell
Get-Command
```

Find commands related to processes:

```powershell
Get-Command *Process*
```

### Practical use

Useful when you know what you want to do but don't know the command.

---

# 46. `Get-Process`

Lists running processes.

```powershell
Get-Process
```

Find a process:

```powershell
Get-Process chrome
```

Sort by CPU:

```powershell
Get-Process | Sort-Object CPU -Descending
```

---

# 47. `Stop-Process`

Stops a process.

```powershell
Stop-Process -Name notepad
```

Force:

```powershell
Stop-Process -Name notepad -Force
```

---

# 48. `Get-Service`

Lists Windows services.

```powershell
Get-Service
```

Find a specific service:

```powershell
Get-Service Spooler
```

Find running services:

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

---

# 49. `Start-Service`

Starts a service.

```powershell
Start-Service Spooler
```

---

# 50. `Stop-Service`

Stops a service.

```powershell
Stop-Service Spooler
```

---

# 51. `Restart-Service`

Restarts a service.

```powershell
Restart-Service Spooler
```

---

# 52. `Get-ChildItem`

PowerShell equivalent of `dir`.

```powershell
Get-ChildItem
```

Alias:

```powershell
dir
```

or:

```powershell
ls
```

List a specific folder:

```powershell
Get-ChildItem C:\Users
```

---

# 53. `Set-Location`

Changes the current directory.

```powershell
Set-Location C:\Users
```

Alias:

```powershell
cd C:\Users
```

---

# 54. `Get-Location`

Shows the current directory.

```powershell
Get-Location
```

---

# 55. `New-Item`

Creates a file or folder.

Create folder:

```powershell
New-Item -ItemType Directory Test
```

Create file:

```powershell
New-Item -ItemType File test.txt
```

---

# 56. `Copy-Item`

Copies files or folders.

```powershell
Copy-Item test.txt backup.txt
```

Copy a folder:

```powershell
Copy-Item Project C:\Backup\ -Recurse
```

---

# 57. `Move-Item`

Moves files or folders.

```powershell
Move-Item test.txt C:\Backup\
```

---

# 58. `Remove-Item`

Deletes files or folders.

```powershell
Remove-Item test.txt
```

Remove a folder recursively:

```powershell
Remove-Item Project -Recurse
```

> Be careful with `Remove-Item`.

---

# 59. PowerShell Variables

Variables start with `$`.

```powershell
$name = "Yash"

Write-Host $name
```

Another example:

```powershell
$age = 21

Write-Host "Age: $age"
```

---

# 60. PowerShell `if`

```powershell
$cpu = 80

if ($cpu -gt 70) {
    Write-Host "High CPU usage"
}
else {
    Write-Host "CPU usage is normal"
}
```

Common comparison operators:

```text
-eq    Equal
-ne    Not equal
-gt    Greater than
-lt    Less than
-ge    Greater than or equal
-le    Less than or equal
```

---

# 61. PowerShell `foreach`

```powershell
$names = "Git", "Docker", "PowerShell"

foreach ($name in $names) {
    Write-Host $name
}
```

Useful for processing multiple files, users, services, etc.

---

# 62. PowerShell Pipeline `|`

The pipeline sends the output of one command to another command.

Example:

```powershell
Get-Process | Sort-Object CPU
```

Another example:

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

### Mental model

```text
Command 1
   ↓
   |
   ↓
Command 2
   ↓
Result
```

---

# 63. `Where-Object`

Filters results.

Example:

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

Find stopped services:

```powershell
Get-Service | Where-Object {$_.Status -eq "Stopped"}
```

---

# 64. `Sort-Object`

Sorts results.

```powershell
Get-Process | Sort-Object CPU
```

Descending:

```powershell
Get-Process | Sort-Object CPU -Descending
```

---

# 65. `Select-Object`

Selects specific properties or a specific number of results.

```powershell
Get-Process | Select-Object Name, CPU
```

Top 10:

```powershell
Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 10
```

---

# 66. `Get-ComputerInfo`

Displays detailed computer information.

```powershell
Get-ComputerInfo
```

Useful for:

* Windows version
* BIOS information
* Computer name
* OS information
* Hardware information

---

# 67. `Get-NetIPConfiguration`

Displays network configuration.

```powershell
Get-NetIPConfiguration
```

Useful for checking:

* IP address
* Gateway
* Network adapter
* DNS information

---

# 68. `Get-NetAdapter`

Displays network adapters.

```powershell
Get-NetAdapter
```

Find enabled adapters:

```powershell
Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
```

---

# 69. `Test-Connection`

PowerShell equivalent of basic `ping`.

```powershell
Test-Connection google.com
```

Example:

```powershell
Test-Connection 8.8.8.8
```

---

# 70. `Resolve-DnsName`

Performs DNS lookup.

```powershell
Resolve-DnsName google.com
```

Similar purpose to:

```cmd
nslookup google.com
```

---

# 71. `Get-NetTCPConnection`

Displays TCP connections.

```powershell
Get-NetTCPConnection
```

Find listening connections:

```powershell
Get-NetTCPConnection |
Where-Object {$_.State -eq "Listen"}
```

---

# 72. `Get-Content`

Reads the contents of a file.

```powershell
Get-Content notes.txt
```

Similar to CMD:

```cmd
type notes.txt
```

---

# 73. `Set-Content`

Writes content to a file.

```powershell
Set-Content notes.txt "Hello World"
```

> This replaces existing content.

---

# 74. `Add-Content`

Adds content to an existing file.

```powershell
Add-Content notes.txt "Another line"
```

---

# 75. Practical IT Troubleshooting Script

A simple PowerShell script can collect system information:

```powershell
Write-Host "===== COMPUTER ====="

hostname
whoami

Write-Host "`n===== SYSTEM ====="

Get-ComputerInfo |
Select-Object WindowsProductName, WindowsVersion, OsArchitecture

Write-Host "`n===== NETWORK ====="

Get-NetIPConfiguration

Write-Host "`n===== NETWORK ADAPTERS ====="

Get-NetAdapter

Write-Host "`n===== TOP PROCESSES ====="

Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 10 Name, CPU

Write-Host "`n===== SERVICES ====="

Get-Service |
Where-Object {$_.Status -eq "Running"} |
Select-Object -First 20 Name, Status
```

---

# 76. Basic Network Troubleshooting Workflow

When a user says:

> "My computer has no internet."

Start with:

```cmd
ipconfig
```

Check connectivity:

```cmd
ping 8.8.8.8
```

Test DNS:

```cmd
ping google.com
```

Check DNS:

```cmd
nslookup google.com
```

Check route:

```cmd
tracert google.com
```

Clear DNS cache:

```cmd
ipconfig /flushdns
```

Renew DHCP:

```cmd
ipconfig /release
ipconfig /renew
```

---

# 77. Basic Application Troubleshooting

If an application is frozen:

```cmd
tasklist
```

Find the application:

```cmd
tasklist | findstr chrome
```

Terminate it:

```cmd
taskkill /IM chrome.exe /F
```

Or use PowerShell:

```powershell
Get-Process chrome
```

Then:

```powershell
Stop-Process -Name chrome -Force
```

---

# 78. Basic Windows System Troubleshooting

Check system information:

```cmd
systeminfo
```

Check disk:

```cmd
chkdsk
```

Check Windows system files:

```cmd
sfc /scannow
```

Repair Windows image:

```cmd
DISM /Online /Cleanup-Image /RestoreHealth
```

Check drivers:

```cmd
driverquery
```

---

# 79. CMD vs PowerShell

| Task             | CMD          | PowerShell        |
| ---------------- | ------------ | ----------------- |
| List files       | `dir`        | `Get-ChildItem`   |
| Change directory | `cd`         | `Set-Location`    |
| Copy             | `copy`       | `Copy-Item`       |
| Move             | `move`       | `Move-Item`       |
| Delete           | `del`        | `Remove-Item`     |
| Processes        | `tasklist`   | `Get-Process`     |
| Kill process     | `taskkill`   | `Stop-Process`    |
| Services         | `sc` / `net` | `Get-Service`     |
| Ping             | `ping`       | `Test-Connection` |
| DNS              | `nslookup`   | `Resolve-DnsName` |
| Network adapter  | `ipconfig`   | `Get-NetAdapter`  |

---

# 80. Commands You Should Actually Memorize

For an entry-level IT role, prioritize these:

## File System

```cmd
cd
dir
mkdir
rmdir
copy
move
del
ren
type
```

## System

```cmd
hostname
whoami
systeminfo
tasklist
taskkill
driverquery
```

## Networking

```cmd
ipconfig
ping
tracert
nslookup
netstat
arp
pathping
getmac
```

## Windows Repair

```cmd
chkdsk
sfc
DISM
gpupdate
```

## Services

```cmd
sc
net start
net stop
```

## PowerShell

```powershell
Get-Help
Get-Command
Get-Process
Stop-Process
Get-Service
Start-Service
Stop-Service
Restart-Service
Get-ChildItem
New-Item
Copy-Item
Move-Item
Remove-Item
Get-ComputerInfo
Get-NetIPConfiguration
Get-NetAdapter
Test-Connection
Where-Object
Sort-Object
Select-Object
```

---

# 81. 80/20 Learning Order

Learn in this order:

```text
CMD
 │
 ├── cd
 ├── dir
 ├── mkdir
 ├── copy
 ├── move
 ├── del
 └── type
        ↓
System Commands
 │
 ├── systeminfo
 ├── hostname
 ├── whoami
 ├── tasklist
 └── taskkill
        ↓
Networking
 │
 ├── ipconfig
 ├── ping
 ├── tracert
 ├── nslookup
 └── netstat
        ↓
Windows Troubleshooting
 │
 ├── chkdsk
 ├── sfc
 ├── DISM
 └── gpupdate
        ↓
Batch
 │
 ├── variables
 ├── if
 ├── for
 └── .bat scripts
        ↓
PowerShell
 │
 ├── Get-Process
 ├── Get-Service
 ├── Get-ChildItem
 ├── Get-NetAdapter
 ├── Get-NetIPConfiguration
 ├── Where-Object
 └── pipeline
```

## Final Goal

You should be able to open Windows CMD or PowerShell and comfortably do:

```text
Navigate files
      ↓
Inspect system
      ↓
Check network
      ↓
Check processes
      ↓
Check services
      ↓
Troubleshoot problems
      ↓
Automate repetitive tasks
```

That is enough **basic Windows scripting knowledge for an entry-level IT internship**. Advanced PowerShell can be learned later.
