# `10-Bash-Scripting.md`

# Bash Scripting for Cybersecurity

## 1. First Principle

A Bash script is simply:

> **A sequence of Linux commands executed automatically.**

Instead of manually doing:

```text
Check processes
↓
Check ports
↓
Check disk
↓
Check logs
```

you write a script:

```bash
#!/bin/bash

ps aux
ss -lntp
df -h
journalctl -n 20
```

This is the foundation of **Linux automation**.

For cybersecurity, Bash is useful for:

- system enumeration
- log analysis
- security checks
- incident response
- automation
- file investigation
- process monitoring

---

# 2. Your First Bash Script

Create:

```bash
nano hello.sh
```

Write:

```bash
#!/bin/bash

echo "Hello Cybersecurity"
echo "Current user:"
whoami
```

Run:

```bash
chmod +x hello.sh
./hello.sh
```

### Explanation

```bash
#!/bin/bash
```

Tells Linux to use Bash to execute the script.

```bash
echo
```

Prints text.

```bash
whoami
```

Shows the current user.

```bash
chmod +x hello.sh
```

Makes the script executable.

---

# 3. Variables

Variables store values.

```bash
#!/bin/bash

username="analyst"
echo "User: $username"
```

Output:

```text
User: analyst
```

Important:

```bash
$username
```

means:

> Get the value stored in `username`.

---

# 4. Command Substitution

You can store command output in a variable.

```bash
#!/bin/bash

user=$(whoami)
hostname=$(hostname)

echo "User: $user"
echo "Host: $hostname"
```

Concept:

```text
Command
   ↓
Output
   ↓
Variable
```

This is heavily used in automation.

---

# 5. User Input

```bash
#!/bin/bash

read -p "Enter username: " username

echo "Searching for: $username"
```

`read` waits for user input.

Example:

```text
Enter username: admin
Searching for: admin
```

---

# 6. Conditions

Scripts can make decisions.

```bash
#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Running as root"
else
    echo "Running as normal user"
fi
```

Concept:

```text
Condition
   ↓
TRUE  → first block
FALSE → second block
```

`EUID` is the effective user ID.

Root normally has:

```text
EUID = 0
```

---

# 7. File Checking

```bash
#!/bin/bash

FILE="/etc/passwd"

if [ -f "$FILE" ]; then
    echo "File exists"
else
    echo "File does not exist"
fi
```

Useful tests:

```text
-f → regular file
-d → directory
-r → readable
-w → writable
-x → executable
```

Example:

```bash
if [ -r "/etc/passwd" ]; then
    echo "Readable"
fi
```

---

# 8. Loops

Loops repeat operations.

### For loop

```bash
#!/bin/bash

for user in alice bob admin; do
    echo "Checking $user"
done
```

Output:

```text
Checking alice
Checking bob
Checking admin
```

This is useful when checking multiple users, files, IPs, etc.

---

# 9. Loop Through Files

```bash
#!/bin/bash

for file in /var/log/*.log; do
    echo "Checking: $file"
done
```

The shell expands:

```text
/var/log/*.log
```

into matching files.

---

# 10. While Loop

```bash
#!/bin/bash

count=1

while [ "$count" -le 5 ]; do
    echo "Scan $count"
    count=$((count + 1))
done
```

Output:

```text
Scan 1
Scan 2
Scan 3
Scan 4
Scan 5
```

---

# 11. Functions

Functions allow you to reuse code.

```bash
#!/bin/bash

check_user() {
    echo "Current user: $(whoami)"
}

check_user
```

Another example:

```bash
check_disk() {
    df -h /
}

check_disk
```

Useful for building larger security scripts.

---

# 12. Exit Codes

Linux commands return an **exit status**.

Usually:

```text
0 → success
non-zero → failure/error
```

Check the previous command:

```bash
echo $?
```

Example:

```bash
ls /tmp
echo $?
```

If successful:

```text
0
```

This allows scripts to make decisions.

```bash
if ls /tmp >/dev/null 2>&1; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
```

---

# 13. `&&` and `||`

Run the second command only if the first succeeds:

```bash
mkdir test && echo "Created successfully"
```

Run another command if the first fails:

```bash
ls /fake || echo "Directory does not exist"
```

Mental model:

```text
command && success-action
command || failure-action
```

---

# 14. Arguments

Scripts can accept command-line arguments.

Script:

```bash
#!/bin/bash

echo "Target: $1"
```

Run:

```bash
./scan.sh 192.168.1.10
```

Output:

```text
Target: 192.168.1.10
```

Important variables:

```text
$0 → script name
$1 → first argument
$2 → second argument
$# → number of arguments
$@ → all arguments
```

---

# 15. Practical Cybersecurity Script — System Information

```bash
#!/bin/bash

echo "===== SYSTEM INFORMATION ====="

echo "User: $(whoami)"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"

echo
echo "===== IP ADDRESSES ====="
ip -br addr

echo
echo "===== LISTENING PORTS ====="
ss -lnt

echo
echo "===== DISK ====="
df -h /
```

This creates a simple **system enumeration script**.

---

# 16. Security Audit Script

```bash
#!/bin/bash

echo "===== BASIC SECURITY AUDIT ====="

echo
echo "[1] Current User"
whoami

echo
echo "[2] Current UID"
id

echo
echo "[3] Listening Ports"
ss -lnt

echo
echo "[4] Running Services"
systemctl list-units --type=service --state=running

echo
echo "[5] SUID Files"
find / -type f -perm -4000 2>/dev/null | head -20

echo
echo "[6] Disk Usage"
df -h
```

### What it does

```text
Identity
   ↓
Network exposure
   ↓
Services
   ↓
Privileged files
   ↓
Disk status
```

This is a simple example of **security enumeration automation**.

---

# 17. Redirecting Errors

You may see permission errors from:

```bash
find /
```

Send errors somewhere else:

```bash
find / -type f -perm -4000 2>/dev/null
```

Meaning:

```text
2 → stderr
/dev/null → discard output
```

Therefore:

```bash
2>/dev/null
```

means:

> Discard error messages.

---

# 18. Logging Script Output

You can save output:

```bash
./audit.sh > audit.txt
```

Append instead of overwrite:

```bash
./audit.sh >> audit.txt
```

Save both normal output and errors:

```bash
./audit.sh > audit.txt 2>&1
```

This is useful when creating automated security reports.

---

# 19. Practical Scenario — Suspicious Process

Create:

```bash
nano process_check.sh
```

```bash
#!/bin/bash

echo "===== TOP CPU PROCESSES ====="

ps aux --sort=-%cpu | head -10

echo
echo "===== LISTENING NETWORK SERVICES ====="

ss -lntp
```

Run:

```bash
chmod +x process_check.sh
./process_check.sh
```

Now you have a quick first-level system triage tool.

---

# 20. Practical Scenario — Check Failed SSH Attempts

```bash
#!/bin/bash

LOG="/var/log/auth.log"

echo "===== SSH FAILED LOGIN ATTEMPTS ====="

if [ -f "$LOG" ]; then
    grep "Failed password" "$LOG" | tail -20
else
    echo "Authentication log not found at $LOG"
fi
```

This demonstrates:

```text
Variable
   ↓
File check
   ↓
Search
   ↓
Display results
```

Remember that some Linux distributions use `/var/log/secure` instead.

---

# 21. Good Bash Security Practices

### Quote variables

Prefer:

```bash
rm -- "$file"
```

instead of:

```bash
rm $file
```

Quoting helps prevent unexpected word splitting and pathname expansion.

### Validate input

Don't blindly execute user input.

Dangerous pattern:

```bash
bash -c "$user_input"
```

Treat external input as untrusted.

### Use absolute paths when appropriate

For security-sensitive scripts:

```bash
/usr/bin/id
/usr/bin/grep
```

can reduce ambiguity caused by a manipulated `PATH`.

### Don't run everything as root

Use:

```bash
sudo
```

only where necessary.

---

# 22. Bash + Cybersecurity Workflow

A practical analyst may automate:

```text
Collect
   ↓
Filter
   ↓
Analyze
   ↓
Detect
   ↓
Report
```

Example:

```bash
journalctl -u ssh |
grep "Failed password" |
awk '{print $(NF-3)}' |
sort |
uniq -c |
sort -nr
```

This is powerful because each command performs one small operation.

---

# 23. Practical Lab

Create:

```bash
nano linux_audit.sh
```

Add:

```bash
#!/bin/bash

echo "===== LINUX SECURITY AUDIT ====="

echo
echo "[USER]"
id

echo
echo "[HOST]"
hostname

echo
echo "[KERNEL]"
uname -r

echo
echo "[NETWORK]"
ip -br addr

echo
echo "[LISTENING PORTS]"
ss -lnt

echo
echo "[TOP PROCESSES]"
ps aux --sort=-%cpu | head -6

echo
echo "[DISK]"
df -h /
```

Run:

```bash
chmod +x linux_audit.sh
./linux_audit.sh
```

Save results:

```bash
./linux_audit.sh > audit.txt
```

Now open:

```bash
less audit.txt
```

You have created a basic **Linux security assessment script**.

---

# 24. Interview Questions

### Q1. What is Bash scripting?

Automating Linux commands and logic using the Bash shell.

### Q2. What does `$?` represent?

The exit status of the previous command.

### Q3. What is `$1`?

The first command-line argument passed to the script.

### Q4. Difference between `>` and `>>`?

```text
>   → overwrite
>>  → append
```

### Q5. What does `2>/dev/null` do?

Redirects standard error to `/dev/null`, effectively discarding it.

### Q6. Why is Bash useful for cybersecurity?

It allows analysts to quickly automate:

- enumeration
- log analysis
- system checks
- incident-response tasks
- repetitive investigations

---

# 25. Quick Cheat Sheet

```bash
#!/bin/bash

echo "text"

name="Yash"
echo "$name"

user=$(whoami)

read -p "Input: " value

if [ "$value" = "yes" ]; then
    echo "Yes"
fi

for file in /var/log/*.log; do
    echo "$file"
done

function check() {
    echo "Running check"
}

echo $?
echo "$1"
echo "$#"
echo "$@"

command1 && command2
command1 || command2

command > file
command >> file
command 2>/dev/null
command > file 2>&1
```

## Core Mental Model

```text
Linux Commands
      ↓
Bash
      ↓
Variables + Conditions + Loops
      ↓
Automation
      ↓
Security Checks
      ↓
Detection / Response
```

For a **Cybersecurity Analyst**, you don't need to become a Bash software engineer first. You need enough Bash to **combine Linux tools, automate repetitive investigation, process logs, and build small security utilities**.

**Next:** `11-Cron-Jobs.md`