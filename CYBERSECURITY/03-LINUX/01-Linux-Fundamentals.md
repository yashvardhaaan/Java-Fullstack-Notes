# 01 — Linux Fundamentals

Below is the **first MD file** from your Linux structure. I’ll keep the same approach for the remaining files: **first principles → concepts → commands → what each command does → practical scenario → security relevance → hands-on exercises**.

Save this as:

`03-LINUX/01-Linux-Fundamentals.md`

```md
# Linux Fundamentals

> Goal: Understand Linux from first principles and become comfortable using Linux for cybersecurity, system administration, networking, and security analysis.

---

# 1. What is Linux?

Linux is an operating system kernel.

A complete Linux operating system is usually built using:

- Linux Kernel
- GNU utilities
- Shell
- System libraries
- Package manager
- System services
- Applications

Examples of Linux distributions:

- Ubuntu
- Debian
- Fedora
- Rocky Linux
- Arch Linux
- Kali Linux
- Red Hat Enterprise Linux (RHEL)

---

# 2. First Principle: What Does an Operating System Actually Do?

At the most basic level, an operating system sits between:

```text
USER / APPLICATION
        |
        v
   OPERATING SYSTEM
        |
        v
      KERNEL
        |
        v
 HARDWARE
```

Applications should not directly control hardware.

For example:

```text
Firefox
   |
   v
Linux
   |
   v
Kernel
   |
   v
Network Card
```

The Linux kernel manages:

- CPU
- RAM
- Storage
- Network interfaces
- Processes
- Devices
- Security boundaries
- System calls

---

# 3. What is the Kernel?

The kernel is the core component of Linux.

It manages system resources and provides controlled access to hardware.

Major responsibilities:

```text
Kernel
├── Process Management
├── Memory Management
├── File System Management
├── Device Management
├── Network Management
├── Security
└── System Calls
```

For example, when a program wants to read a file:

```text
Application
     |
     | read()
     v
Linux System Call
     |
     v
Kernel
     |
     v
File System
     |
     v
Disk
```

The application does not directly access the disk.

---

# 4. User Space vs Kernel Space

Linux separates normal applications from the kernel.

```text
+--------------------------------+
|          USER SPACE            |
|                                |
| bash                           |
| Firefox                        |
| Python                         |
| SSH                            |
| Applications                   |
+--------------------------------+
|          KERNEL SPACE          |
|                                |
| Process management             |
| Memory management              |
| Networking                     |
| File systems                   |
| Drivers                        |
+--------------------------------+
|           HARDWARE             |
+--------------------------------+
```

## Why is this separation important?

Security.

If a normal application could freely modify kernel memory, a compromised application could potentially control the entire system.

Therefore:

```text
User application
      |
      | controlled request
      v
Kernel
      |
      v
Hardware
```

---

# 5. What is a Linux Distribution?

Linux itself is the kernel.

A distribution packages the kernel with other software.

For example:

```text
Ubuntu
├── Linux Kernel
├── GNU Utilities
├── Bash
├── APT
├── Systemd
├── Libraries
└── Applications
```

Kali Linux is also a Linux distribution.

It is specifically designed for:

- Penetration testing
- Digital forensics
- Security assessment
- Network analysis
- Security research

---

# 6. Opening the Linux Terminal

The terminal provides a command-line interface.

Example:

```bash
user@linux:~$
```

Breakdown:

```text
user       -> current username
@          -> separator
linux      -> hostname
:          -> separator
~          -> current directory
$          -> normal user
```

If you are root:

```bash
root@linux:~#
```

The `#` normally indicates the root user.

---

# 7. First Principle: Everything Starts With the Shell

The shell is a program that interprets commands.

Example:

```bash
ls
```

The shell:

```text
You type command
      |
      v
Shell interprets command
      |
      v
Program is executed
      |
      v
Output is returned
```

Common shells:

- Bash
- Zsh
- Fish
- Dash

Bash is extremely common in Linux environments.

---

# 8. Find Which Shell You Are Using

Run:

```bash
echo $SHELL
```

Example:

```text
/bin/bash
```

### What does it mean?

`echo` prints something.

`$SHELL` is an environment variable containing your default shell.

---

# 9. Your First Linux Commands

Start with:

```bash
whoami
```

This tells you which user you are currently using.

Example:

```text
yash
```

---

## Find the hostname

```bash
hostname
```

Example:

```text
ubuntu-server
```

This tells you the system's hostname.

---

## Find the current directory

```bash
pwd
```

Example:

```text
/home/yash
```

`pwd` means:

```text
Print Working Directory
```

---

## List files

```bash
ls
```

Example:

```text
Documents
Downloads
Pictures
projects
```

---

# 10. Understanding the Linux File System

Linux uses a hierarchical filesystem.

At the top is:

```text
/
```

This is called the root directory.

Example:

```text
/
├── bin
├── boot
├── dev
├── etc
├── home
├── lib
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin
├── srv
├── sys
├── tmp
├── usr
└── var
```

---

# 11. Important Linux Directories

## `/`

The root of the filesystem.

Everything starts here.

```text
/
├── home
├── etc
├── var
└── ...
```

---

## `/home`

Contains normal users' home directories.

Example:

```text
/home/yash
/home/alice
/home/bob
```

---

## `/root`

Home directory of the root user.

Important:

```text
/root
```

is NOT the same as:

```text
/
```

`/` = filesystem root

`/root` = root user's home directory

---

## `/etc`

Contains system configuration.

Examples:

```text
/etc/passwd
/etc/hosts
/etc/ssh/
/etc/systemd/
```

Cybersecurity importance:

Attackers and defenders frequently inspect configuration files under `/etc`.

---

## `/var`

Contains variable data.

Examples:

```text
/var/log
/var/cache
/var/tmp
```

System logs are commonly stored under:

```text
/var/log
```

---

## `/tmp`

Temporary files.

Example:

```text
/tmp
```

Security relevance:

Temporary directories can be abused by malicious programs if permissions are poorly configured.

---

## `/usr`

Contains many user-space programs and libraries.

Examples:

```text
/usr/bin
/usr/sbin
/usr/lib
```

---

## `/bin`

Contains essential user commands.

Depending on the distribution, `/bin` may be linked to `/usr/bin`.

---

## `/sbin`

Contains system administration commands.

Modern distributions may also merge this into `/usr/sbin`.

---

## `/dev`

Represents devices.

Examples:

```text
/dev/sda
/dev/null
/dev/random
```

Linux represents many devices as files.

---

## `/proc`

A virtual filesystem exposing information about running processes and the kernel.

Example:

```bash
ls /proc
```

You may see:

```text
1
2
3
...
```

These numbers can represent process IDs.

---

## `/sys`

Provides information about devices and the kernel.

---

# 12. Navigation

Use:

```bash
pwd
```

Then:

```bash
ls
```

Move into a directory:

```bash
cd Documents
```

Move back:

```bash
cd ..
```

Go to your home directory:

```bash
cd ~
```

Go to filesystem root:

```bash
cd /
```

---

# 13. Absolute vs Relative Paths

This is extremely important.

## Absolute Path

Starts from `/`.

Example:

```bash
/home/yash/projects
```

It always refers to the same location.

---

## Relative Path

Starts from your current directory.

Example:

```bash
projects
```

If you are currently:

```text
/home/yash
```

then:

```text
projects
```

means:

```text
/home/yash/projects
```

---

# 14. Practical Exercise: Create Your Linux Lab

Create a safe practice directory.

```bash
mkdir linux-lab
```

Move into it:

```bash
cd linux-lab
```

Verify:

```bash
pwd
```

Expected:

```text
/home/yash/linux-lab
```

---

# 15. Create Files

Create a file:

```bash
touch notes.txt
```

Check:

```bash
ls
```

You should see:

```text
notes.txt
```

---

# 16. Write Data Into a File

Run:

```bash
echo "Linux Security Lab" > notes.txt
```

Read it:

```bash
cat notes.txt
```

Output:

```text
Linux Security Lab
```

---

# 17. Understanding `>`

This:

```bash
echo "Hello" > file.txt
```

means:

```text
echo output
     |
     v
redirect >
     |
     v
file.txt
```

Important:

`>` overwrites the file.

Example:

```bash
echo "One" > test.txt
echo "Two" > test.txt
```

Now:

```bash
cat test.txt
```

Output:

```text
Two
```

---

# 18. Understanding `>>`

`>>` appends instead of replacing.

```bash
echo "One" > test.txt
echo "Two" >> test.txt
```

Now:

```bash
cat test.txt
```

Output:

```text
One
Two
```

This concept becomes very important when working with logs.

---

# 19. Read Files

Basic command:

```bash
cat notes.txt
```

For large files:

```bash
less notes.txt
```

Other useful commands:

```bash
head notes.txt
tail notes.txt
```

For example:

```bash
tail -f /var/log/syslog
```

On systems using systemd, you will often use:

```bash
journalctl
```

---

# 20. Create Directories

```bash
mkdir projects
```

Create nested directories:

```bash
mkdir -p security/linux/network
```

The `-p` option creates missing parent directories.

---

# 21. Copy Files

```bash
cp notes.txt backup.txt
```

Meaning:

```text
notes.txt
    |
    | copy
    v
backup.txt
```

Copy a directory:

```bash
cp -r projects projects-backup
```

`-r` means recursive.

---

# 22. Move and Rename Files

Rename:

```bash
mv notes.txt linux-notes.txt
```

Move:

```bash
mv linux-notes.txt projects/
```

`mv` is used for both:

- Moving
- Renaming

---

# 23. Delete Files

```bash
rm linux-notes.txt
```

Delete an empty directory:

```bash
rmdir projects
```

Delete a directory recursively:

```bash
rm -r projects
```

### Security rule

Be extremely careful with:

```bash
rm -rf
```

It can recursively delete files/directories without asking for confirmation.

Never execute destructive commands blindly, especially as root.

---

# 24. Command Structure

Linux commands commonly follow this structure:

```bash
command [options] [arguments]
```

Example:

```bash
ls -la /etc
```

Breakdown:

```text
ls       -> command
-la      -> options
/etc     -> argument
```

---

# 25. Understanding Options

Example:

```bash
ls
```

Basic listing.

```bash
ls -l
```

Long format.

```bash
ls -a
```

Show hidden files.

```bash
ls -la
```

Combine both.

---

# 26. Hidden Files

Linux files beginning with `.` are hidden.

Example:

```text
.bashrc
.ssh
.gitconfig
```

View them:

```bash
ls -la
```

Security relevance:

Configuration files may contain:

- API keys
- SSH configuration
- Environment variables
- Application secrets
- User preferences

Never assume a hidden file is harmless.

---

# 27. Getting Help

Use:

```bash
man ls
```

This opens the manual for `ls`.

Search for command documentation:

```bash
man chmod
man ssh
man ps
```

You can also use:

```bash
ls --help
```

---

# 28. Finding Commands

Use:

```bash
which python
```

Example:

```text
/usr/bin/python
```

Another useful command:

```bash
command -v python
```

This helps determine which executable your shell will run.

---

# 29. Environment Variables

Environment variables store configuration information.

View one:

```bash
echo $PATH
```

Example:

```text
/usr/local/bin:/usr/bin:/bin
```

---

# 30. Understanding PATH

When you type:

```bash
python
```

Linux needs to find the executable.

It searches directories listed in:

```bash
$PATH
```

Conceptually:

```text
python
  |
  v
PATH
  |
  +--> /usr/local/bin
  |
  +--> /usr/bin
  |
  +--> /bin
```

Security relevance:

If an attacker can manipulate `PATH`, they may cause a different executable to run.

This is why PATH manipulation matters in:

- Privilege escalation
- Malware analysis
- Incident response
- Secure scripting

---

# 31. Check System Information

Kernel version:

```bash
uname -r
```

More information:

```bash
uname -a
```

Example:

```text
Linux ubuntu 6.x.x ... x86_64 GNU/Linux
```

---

# 32. Check OS Information

```bash
cat /etc/os-release
```

Example:

```text
NAME="Ubuntu"
VERSION="..."
```

This tells you the distribution and version.

---

# 33. Check CPU

```bash
lscpu
```

Useful information includes:

- CPU architecture
- Number of CPUs
- Threads
- Virtualization support
- CPU model

---

# 34. Check Memory

```bash
free -h
```

`-h` means human-readable.

Example:

```text
              total   used   free
Mem:           16G     5G     8G
```

---

# 35. Check Disk Usage

Filesystem usage:

```bash
df -h
```

Directory size:

```bash
du -sh /var/log
```

Difference:

```text
df -> filesystem/disk capacity
du -> directory/file usage
```

---

# 36. Process Basics

A process is a running instance of a program.

Example:

```text
Firefox
   |
   v
Process
   |
   v
PID = 1234
```

List processes:

```bash
ps
```

More detailed:

```bash
ps aux
```

Live process monitoring:

```bash
top
```

or:

```bash
htop
```

if installed.

---

# 37. Process IDs

Every process normally has a PID.

Example:

```text
PID    COMMAND
1      systemd
500    sshd
1200   bash
1500   python
```

Find your shell:

```bash
echo $$
```

`$$` contains the PID of the current shell.

---

# 38. Process Tree

Use:

```bash
pstree
```

Conceptually:

```text
systemd
├── sshd
│   └── bash
│       └── python
└── other services
```

This is useful during incident response.

For example, if you find a suspicious process, you can investigate:

```text
Who started it?
Which parent process created it?
What command launched it?
```

---

# 39. Signals

Linux processes can receive signals.

Example:

```bash
kill 1234
```

This normally sends `SIGTERM`.

Force termination:

```bash
kill -9 1234
```

This sends `SIGKILL`.

Important:

`kill` does not necessarily mean "immediately destroy the process."

It sends a signal.

---

# 40. Practical Scenario: Suspicious Process

Imagine a server is behaving strangely.

You notice high CPU usage.

Start with:

```bash
top
```

Find the process consuming CPU.

Then:

```bash
ps aux | grep <process-name>
```

Investigate:

```bash
readlink -f /proc/<PID>/exe
```

This can show which executable is associated with the process.

Then inspect:

```bash
ls -la /proc/<PID>
```

The `/proc` filesystem can provide valuable process information.

---

# 41. Standard Input, Output and Error

Linux processes have three standard streams:

```text
stdin   -> 0
stdout  -> 1
stderr  -> 2
```

Conceptually:

```text
             stdin
               |
               v
          +---------+
          | Process |
          +---------+
            |     |
            v     v
         stdout stderr
```

---

# 42. Redirect Standard Error

Example:

```bash
command 2> errors.txt
```

Meaning:

```text
stderr
  |
  v
errors.txt
```

Redirect normal output:

```bash
command > output.txt
```

Redirect both:

```bash
command > output.txt 2>&1
```

---

# 43. Pipes

A pipe sends the output of one command into another.

Example:

```bash
ps aux | grep ssh
```

Flow:

```text
ps aux
   |
   | stdout
   v
 grep ssh
```

This is one of the most important Linux concepts.

You combine small tools to perform complex tasks.

---

# 44. Practical Security Example: Find SSH Processes

```bash
ps aux | grep ssh
```

You are essentially saying:

```text
Show all processes
       |
       v
Search the output for "ssh"
```

A more targeted approach can use:

```bash
pgrep -a ssh
```

---

# 45. Search Files

Use:

```bash
find /var/log -type f
```

Find files by name:

```bash
find /var/log -name "*.log"
```

Find files modified recently:

```bash
find /var/log -type f -mtime -1
```

This can be useful during incident investigation.

---

# 46. Text Search with grep

Example:

```bash
grep "error" application.log
```

Search recursively:

```bash
grep -R "password" /etc/
```

Case-insensitive:

```bash
grep -i "error" application.log
```

Show line numbers:

```bash
grep -n "error" application.log
```

---

# 47. Practical Scenario: Investigating Authentication Logs

Suppose you want to investigate failed SSH authentication.

Depending on the distribution, logs may be in:

```text
/var/log/auth.log
```

or:

```text
/var/log/secure
```

Example:

```bash
sudo grep "Failed password" /var/log/auth.log
```

You might discover repeated failed authentication attempts.

This becomes the foundation for detecting:

- Brute-force attempts
- Credential attacks
- Suspicious login activity

---

# 48. Root User

Linux has a special administrative account:

```text
root
```

Root has extensive privileges.

Check current user:

```bash
whoami
```

Run a command with elevated privileges:

```bash
sudo command
```

Example:

```bash
sudo systemctl status ssh
```

---

# 49. Why Root Is Dangerous

Suppose:

```bash
rm -rf /some/directory
```

A normal user may receive permission errors.

Root may be allowed to perform the operation.

Therefore:

```text
More privileges
      =
More capability
      +
More potential damage
```

Security principle:

> Use the least privilege necessary to perform the task.

---

# 50. `sudo`

`sudo` means executing a command with another user's privileges, commonly root.

Example:

```bash
sudo apt update
```

The important principle is:

```text
Normal User
     |
     | authorized sudo operation
     v
Privileged Command
```

Do not automatically run everything using:

```bash
sudo
```

---

# 51. Practical Scenario: Install a Package

On Debian/Ubuntu:

```bash
sudo apt update
```

This refreshes package metadata.

Then:

```bash
sudo apt install curl
```

This installs `curl`.

Verify:

```bash
curl --version
```

---

# 52. Linux Package Managers

Different distributions use different package managers.

Debian/Ubuntu:

```bash
apt
```

Fedora/RHEL:

```bash
dnf
```

Arch:

```bash
pacman
```

The package manager handles:

- Installing software
- Updating software
- Removing software
- Dependency management

---

# 53. Why Package Management Matters in Cybersecurity

Outdated packages can contain known vulnerabilities.

Example:

```text
Application
     |
     v
Old vulnerable library
     |
     v
Known vulnerability
     |
     v
Potential exploitation
```

Security operations therefore include:

- Patch management
- Version checking
- Vulnerability scanning
- Software inventory

---

# 54. Check Logged-in Users

```bash
who
```

Another useful command:

```bash
w
```

You can also use:

```bash
last
```

to inspect login history.

Security relevance:

Unexpected users or login sessions can indicate:

- Account compromise
- Unauthorized access
- Misconfiguration
- Suspicious activity

---

# 55. Check System Uptime

```bash
uptime
```

Example:

```text
up 3 days, 4 hours
```

This can be useful during incident investigation.

---

# 56. Practical Linux Security Investigation Flow

When you first access a Linux system during an authorized security investigation:

```text
1. Identify the system
       |
       v
2. Identify current user
       |
       v
3. Understand privileges
       |
       v
4. Check running processes
       |
       v
5. Check network connections
       |
       v
6. Check users/logins
       |
       v
7. Check services
       |
       v
8. Check logs
       |
       v
9. Check persistence mechanisms
       |
       v
10. Document findings
```

Relevant commands learned so far:

```bash
whoami
hostname
uname -a
cat /etc/os-release
ps aux
top
who
w
last
df -h
free -h
```

Later Linux security files will cover these areas in much greater depth.

---

# 57. Practical Lab 1 — Linux Reconnaissance

Create:

```bash
mkdir -p ~/linux-lab/recon
cd ~/linux-lab/recon
```

Run:

```bash
whoami
hostname
pwd
uname -a
cat /etc/os-release
uptime
free -h
df -h
```

Save the results:

```bash
{
    whoami
    hostname
    pwd
    uname -a
    cat /etc/os-release
    uptime
    free -h
    df -h
} > system-info.txt
```

Read:

```bash
cat system-info.txt
```

### What did you learn?

You created a basic system-information collection script using shell commands and output redirection.

---

# 58. Practical Lab 2 — Process Investigation

Run:

```bash
ps aux
```

Then:

```bash
ps aux | head
```

Then:

```bash
ps aux | grep ssh
```

Try:

```bash
pgrep -a systemd
```

Inspect PID 1:

```bash
ps -p 1 -f
```

### Goal

Understand:

```text
Process
PID
Parent Process
Command
User
CPU
Memory
```

---

# 59. Practical Lab 3 — File Investigation

Create test files:

```bash
mkdir -p ~/linux-lab/files
cd ~/linux-lab/files

touch normal.txt
touch .hidden.txt

echo "hello" > normal.txt
echo "secret test" > .hidden.txt
```

List normal files:

```bash
ls
```

List hidden files:

```bash
ls -la
```

Search:

```bash
find ~/linux-lab/files -type f
```

Search for text:

```bash
grep -R "secret" ~/linux-lab/files
```

---

# 60. Practical Lab 4 — Pipes and Filtering

Run:

```bash
ps aux | grep bash
```

Then:

```bash
ps aux | grep ssh
```

Try:

```bash
ls -la /etc | grep ssh
```

The general pattern is:

```text
COMMAND
   |
   v
OUTPUT
   |
   | pipe
   v
FILTER
```

This pattern is fundamental to Linux administration and cybersecurity.

---

# 61. Practical Lab 5 — Build a Basic System Snapshot

Create:

```bash
mkdir -p ~/linux-lab/snapshot
cd ~/linux-lab/snapshot
```

Create:

```bash
nano snapshot.sh
```

Add:

```bash
#!/bin/bash

echo "===== SYSTEM INFORMATION ====="

echo "User:"
whoami

echo "Hostname:"
hostname

echo "Kernel:"
uname -r

echo "Operating System:"
cat /etc/os-release

echo "Uptime:"
uptime

echo "Memory:"
free -h

echo "Disk:"
df -h

echo "Processes:"
ps aux | head -20
```

Save it.

Make executable:

```bash
chmod +x snapshot.sh
```

Run:

```bash
./snapshot.sh
```

---

# 62. Understanding the Script

First line:

```bash
#!/bin/bash
```

This tells Linux to execute the script using Bash.

Then:

```bash
echo "User:"
```

prints text.

Then:

```bash
whoami
```

gets the current user.

This:

```bash
ps aux | head -20
```

means:

```text
ps aux
   |
   v
all processes
   |
   v
head -20
   |
   v
first 20 lines
```

---

# 63. Why This Matters for Cybersecurity

A security analyst frequently needs to answer:

```text
What system am I looking at?

Who am I?

What privileges do I have?

What OS is running?

What processes are running?

What users are logged in?

What services are active?

What network connections exist?

What happened recently?
```

Linux commands provide the raw information needed to answer these questions.

---

# 64. Important Linux Mental Models

## Mental Model 1 — Everything Is a Process

Applications execute as processes.

```text
Program
   |
   v
Process
   |
   v
PID
```

---

## Mental Model 2 — Linux Has a Hierarchical Filesystem

```text
/
├── etc
├── home
├── var
├── usr
└── ...
```

---

## Mental Model 3 — Permissions Control Access

```text
User
Group
Others
```

This will be covered deeply in:

```text
04-Users-Groups-Permissions.md
```

---

## Mental Model 4 — Commands Are Small Tools

Instead of one huge program:

```text
ps
grep
awk
sed
sort
uniq
cut
head
tail
```

Linux provides small tools that can be combined.

Example:

```bash
ps aux | grep ssh | head
```

---

## Mental Model 5 — Data Flows Through Streams

```text
Command
   |
 stdout
   |
   v
Pipe
   |
   v
Another Command
```

This makes Linux extremely powerful for automation and investigation.

---

# 65. Commands You Should Memorize

### Navigation

```bash
pwd
ls
cd
```

### Files

```bash
touch
cat
less
head
tail
cp
mv
rm
```

### Directories

```bash
mkdir
rmdir
```

### Search

```bash
find
grep
```

### System

```bash
uname
hostname
uptime
free
df
```

### Processes

```bash
ps
top
pgrep
kill
```

### Users

```bash
whoami
who
w
last
```

### Privileges

```bash
sudo
```

### Help

```bash
man
--help
```

---

# 66. Cybersecurity Relevance

Linux fundamentals are required for:

- SOC Analyst
- Cybersecurity Analyst
- Security Engineer
- Penetration Tester
- Incident Responder
- Digital Forensics Analyst
- Cloud Security Engineer
- DevSecOps Engineer
- Malware Analyst

Especially important concepts:

```text
Processes
Files
Permissions
Users
Groups
Services
Logs
Networking
SSH
Bash
System Calls
```

---

# 67. Interview Questions

## Q1. What is Linux?

Linux is an open-source operating system kernel. Linux distributions combine the kernel with user-space utilities, libraries, package managers, and applications.

---

## Q2. What is the difference between Linux and Ubuntu?

Linux is the kernel.

Ubuntu is a Linux distribution containing the Linux kernel plus system utilities, libraries, package management, and applications.

---

## Q3. What is a shell?

A shell is a command interpreter that allows users to interact with the operating system.

Examples:

```text
bash
zsh
fish
```

---

## Q4. What is the difference between `/` and `/root`?

```text
/       -> filesystem root
/root   -> root user's home directory
```

---

## Q5. What is a process?

A process is a running instance of a program with resources such as memory, CPU state, file descriptors, and a process ID.

---

## Q6. What is PID?

PID means Process ID.

It uniquely identifies a running process within the system.

---

## Q7. What is the difference between `>` and `>>`?

```bash
>
```

overwrites a file.

```bash
>>
```

appends to a file.

---

## Q8. What does `|` do?

It sends the standard output of one command to the standard input of another command.

Example:

```bash
ps aux | grep ssh
```

---

## Q9. Why is root dangerous?

Root has extensive privileges and can modify critical system resources. Compromising a root-level process can therefore have severe consequences.

---

# 68. Mini Challenge

Without looking at the answers, try to do the following.

### Task 1

Find:

- Current username
- Hostname
- Kernel version
- OS version

### Task 2

Create:

```text
~/linux-lab/challenge/
```

Inside it create:

```text
logs/
scripts/
reports/
```

### Task 3

Create:

```text
logs/application.log
```

with:

```text
INFO Application started
INFO User logged in
ERROR Database connection failed
WARNING High memory usage
ERROR Authentication failed
```

### Task 4

Find all lines containing:

```text
ERROR
```

### Task 5

Count the number of ERROR lines.

Hint:

```bash
grep "ERROR" application.log | wc -l
```

### Task 6

Save the result into:

```text
reports/errors.txt
```

---

# 69. What You Should Be Able to Do After This File

You should now be able to:

- Navigate Linux
- Understand the Linux filesystem
- Create and manipulate files
- Understand absolute and relative paths
- Understand commands and arguments
- Use pipes
- Redirect output
- Search files
- Search text
- Inspect processes
- Identify users
- Understand root and sudo
- Inspect basic system information
- Understand environment variables
- Perform basic Linux reconnaissance
- Write a basic Bash script

---

# 70. Next File

The next topic is:

```text
02-Linux-File-System.md
```

There we will go deeper into:

```text
/
├── /etc
├── /var
├── /proc
├── /sys
├── /dev
├── /usr
├── /opt
├── /tmp
├── /home
└── /root
```

and learn how a cybersecurity analyst actually uses these directories during:

- Incident response
- Malware investigation
- Log investigation
- Persistence detection
- Configuration auditing
- Forensics
- Privilege escalation analysis
```

### Your Linux learning sequence

We should do the files **one at a time**, in this order:

1. **01-Linux-Fundamentals.md** ← this one
2. **02-Linux-File-System.md**
3. **03-Linux-Commands.md**
4. **04-Users-Groups-Permissions.md**
5. **05-Processes.md**
6. **06-Services-Systemd.md**
7. **07-Networking-Linux.md**
8. **08-Linux-Logs.md**
9. **09-SSH.md**
10. **10-Bash-Scripting.md**
11. **11-Cron-Jobs.md**
12. **12-Linux-Security-Hardening.md**

For each one, I'll keep the same pattern: **first principles → what happens internally → command → line-by-line meaning → where you would actually use it as a cybersecurity analyst → safe practical lab → detection/defense → interview points**.