# `12-Linux-Security-Hardening.md`

# Linux Security Hardening

## 1. First Principle

**Security hardening means reducing the ways an attacker can compromise or abuse a system.**

Think:

```text
Default System
     ↓
Remove unnecessary services
     ↓
Restrict users
     ↓
Restrict permissions
     ↓
Secure SSH
     ↓
Configure firewall
     ↓
Enable logging
     ↓
Patch regularly
     ↓
Hardened System
```

The goal is not:

> "Make the system impossible to attack."

The goal is:

> **Reduce attack surface + reduce privileges + improve detection.**

---

# 2. Attack Surface

The **attack surface** is everything an attacker could potentially interact with.

Examples:

```text
Open ports
Running services
User accounts
SSH
Web applications
File permissions
Installed software
Scheduled tasks
```

Check listening ports:

```bash
sudo ss -lntup
```

Ask:

> Does this service really need to be exposed?

---

# 3. Update the System

Security vulnerabilities are frequently fixed through updates.

Ubuntu/Debian:

```bash
sudo apt update
sudo apt upgrade
```

RHEL/Fedora-based systems commonly use:

```bash
sudo dnf update
```

Check OS:

```bash
cat /etc/os-release
```

Security principle:

```text
Vulnerability
    ↓
Security patch
    ↓
Reduced exploitation risk
```

---

# 4. Remove Unnecessary Services

List running services:

```bash
systemctl list-units --type=service --state=running
```

Check a service:

```bash
systemctl status <service>
```

If a service isn't required, consider stopping and disabling it:

```bash
sudo systemctl disable --now <service>
```

Don't blindly disable services.

First determine:

```text
What does it do?
Who uses it?
Is it required?
What depends on it?
```

---

# 5. User Account Security

List users:

```bash
cat /etc/passwd
```

Check current identity:

```bash
id
```

Find users with UID 0:

```bash
awk -F: '$3 == 0 {print $1}' /etc/passwd
```

Normally, `root` should be the only UID 0 account.

Check accounts with login shells:

```bash
grep -E '/bin/bash|/bin/sh' /etc/passwd
```

Remove unnecessary accounts according to your organization's account-management policy.

---

# 6. Principle of Least Privilege

Users should have only the permissions they need.

Bad:

```text
Everyone → Administrator
```

Better:

```text
User
 ↓
Required permissions only
```

Check sudo privileges:

```bash
sudo -l
```

Review sudo configuration:

```bash
sudo visudo
```

Avoid giving unnecessary commands with unrestricted `sudo`.

---

# 7. File Permissions

Check important files:

```bash
ls -l /etc/passwd
ls -l /etc/shadow
```

`/etc/shadow` contains password hashes and should be strongly restricted.

Check:

```bash
ls -l /etc/shadow
```

Find world-writable files:

```bash
find / -type f -perm -002 2>/dev/null
```

World-writable files can create security risks depending on where they are and how they are used.

---

# 8. SUID Files

SUID allows a program to execute with the privileges of its owner.

Find SUID files:

```bash
find / -type f -perm -4000 2>/dev/null
```

Why security analysts care:

```text
SUID executable
      ↓
Runs with elevated privileges
      ↓
Vulnerable/misconfigured program
      ↓
Potential privilege escalation
```

Do not assume every SUID file is malicious. Many legitimate Linux utilities use SUID.

Investigate unexpected ones.

---

# 9. SSH Hardening

Check SSH configuration:

```bash
sudo sshd -t
```

Configuration:

```text
/etc/ssh/sshd_config
```

Important settings include:

```text
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
```

Restrict users where appropriate:

```text
AllowUsers analyst admin
```

Before disabling password authentication:

> **Verify that key-based login works first.**

Otherwise you may lock yourself out.

Reload after changes:

```bash
sudo systemctl reload ssh
```

---

# 10. Firewall

Check UFW:

```bash
sudo ufw status
```

Enable:

```bash
sudo ufw enable
```

Allow SSH:

```bash
sudo ufw allow 22/tcp
```

Allow HTTP:

```bash
sudo ufw allow 80/tcp
```

Allow HTTPS:

```bash
sudo ufw allow 443/tcp
```

The principle is:

```text
Default
   ↓
Block unnecessary traffic
   ↓
Allow only required services
```

Be careful when changing firewall rules remotely.

---

# 11. Disable Unnecessary Network Exposure

Check:

```bash
sudo ss -lntup
```

Example:

```text
0.0.0.0:22
0.0.0.0:80
0.0.0.0:5432
```

Ask:

```text
SSH → Required?
HTTP → Required?
PostgreSQL → Should it be public?
```

A database normally should not be unnecessarily exposed to the public Internet.

---

# 12. Secure File Sharing

Check mounted filesystems:

```bash
findmnt
```

Check sensitive mount options where appropriate.

For temporary storage, administrators may consider options such as:

```text
nodev
nosuid
noexec
```

These can reduce certain attack paths, but they can also break legitimate software.

Therefore:

> **Test security controls before applying them to production.**

---

# 13. Log Monitoring

Check system logs:

```bash
journalctl -p err
```

SSH logs:

```bash
journalctl -u ssh
```

Authentication failures:

```bash
grep "Failed password" /var/log/auth.log
```

Check recent logins:

```bash
last
```

Security principle:

```text
Prevention
    +
Detection
    +
Response
```

Hardening without monitoring leaves you blind to attacks.

---

# 14. Protect Cron and Scheduled Tasks

Check user cron:

```bash
crontab -l
```

Root cron:

```bash
sudo crontab -l
```

System cron:

```bash
cat /etc/crontab
```

Check systemd timers:

```bash
systemctl list-timers
```

Look for:

```text
Unknown scripts
Unexpected users
/tmp executables
Hidden files
Frequent execution
Remote downloads
```

---

# 15. Process Security

Look at running processes:

```bash
ps aux
```

Find high CPU processes:

```bash
ps aux --sort=-%cpu | head
```

Check process hierarchy:

```bash
pstree -p
```

For a suspicious PID:

```bash
readlink -f /proc/<PID>/exe
```

Then investigate:

```text
Process
 ↓
User
 ↓
Executable
 ↓
Parent
 ↓
Files
 ↓
Network
```

---

# 16. Password Policy

Password security should be handled according to organizational policy.

Basic account information:

```bash
sudo chage -l username
```

This can show password-aging information.

Good practices generally include:

- strong unique passwords
- MFA where possible
- no shared accounts
- limited privileged accounts
- appropriate password expiration policies where required

---

# 17. Disable Direct Root Login

For SSH:

```text
PermitRootLogin no
```

Better administrative model:

```text
Normal account
      ↓
sudo
      ↓
Specific administrative action
```

Instead of:

```text
SSH
 ↓
root
 ↓
Everything
```

This improves accountability and reduces unnecessary privileged access.

---

# 18. Security Baseline

A baseline is a known-good configuration.

Example:

```text
Expected:
22 → SSH
443 → HTTPS
```

Later you find:

```text
22 → SSH
443 → HTTPS
4444 → unknown service
```

The deviation becomes an investigation point.

Think:

```text
Known Good
    ↓
Compare
    ↓
Deviation
    ↓
Investigate
```

This is a core SOC/security analyst skill.

---

# 19. Basic Hardening Audit Script

```bash
#!/bin/bash

echo "===== LINUX SECURITY AUDIT ====="

echo
echo "[OS]"
cat /etc/os-release | head

echo
echo "[CURRENT USER]"
id

echo
echo "[LISTENING PORTS]"
sudo ss -lntup

echo
echo "[RUNNING SERVICES]"
systemctl list-units --type=service --state=running

echo
echo "[SUID FILES]"
find / -type f -perm -4000 2>/dev/null | head -30

echo
echo "[WORLD-WRITABLE FILES]"
find / -type f -perm -002 2>/dev/null | head -30

echo
echo "[CRON]"
crontab -l 2>/dev/null

echo
echo "[DISK]"
df -h
```

This isn't a complete security scanner.

It is a **basic analyst checklist automation**.

---

# 20. Hardening Workflow

Use this order:

```text
1. Inventory
      ↓
2. Identify attack surface
      ↓
3. Remove unnecessary services
      ↓
4. Secure accounts
      ↓
5. Apply least privilege
      ↓
6. Secure SSH
      ↓
7. Configure firewall
      ↓
8. Patch system
      ↓
9. Enable logging
      ↓
10. Monitor continuously
```

---

# 21. Practical Scenario

You receive a new Linux server.

### Step 1 — Identify OS

```bash
cat /etc/os-release
```

### Step 2 — Identify network exposure

```bash
sudo ss -lntup
```

### Step 3 — Identify services

```bash
systemctl list-units --type=service --state=running
```

### Step 4 — Check users

```bash
cat /etc/passwd
```

### Step 5 — Check sudo

```bash
sudo -l
```

### Step 6 — Check SSH

```bash
sudo sshd -t
```

### Step 7 — Check firewall

```bash
sudo ufw status
```

### Step 8 — Check scheduled tasks

```bash
crontab -l
systemctl list-timers
```

### Step 9 — Check logs

```bash
journalctl -p err
```

You now have a basic security baseline.

---

# 22. What Hardening Does NOT Mean

Hardening doesn't mean:

```text
Disable everything
```

It means:

```text
Required service → Keep + secure
Unnecessary service → Remove/disable
Required port → Restrict
Unnecessary port → Close
Required user → Restrict
Unnecessary privilege → Remove
Important logs → Monitor
```

Security is about **controlled exposure**, not simply turning features off.

---

# 23. Important Commands

```bash
# System
cat /etc/os-release
uname -r

# Users
id
cat /etc/passwd
sudo -l

# Services
systemctl list-units --type=service --state=running

# Network
sudo ss -lntup

# Firewall
sudo ufw status

# SSH
sudo sshd -t
systemctl status ssh

# Permissions
find / -type f -perm -002 2>/dev/null
find / -type f -perm -4000 2>/dev/null

# Logs
journalctl
journalctl -p err
journalctl -u ssh

# Scheduled tasks
crontab -l
systemctl list-timers

# Processes
ps aux
pstree -p
```

---

# 24. Interview Questions

### Q1. What is Linux hardening?

Reducing the attack surface and restricting unnecessary privileges, services, accounts, and network exposure.

### Q2. What is least privilege?

Giving users and processes only the permissions required to perform their tasks.

### Q3. How do you identify exposed services?

```bash
sudo ss -lntup
```

### Q4. How do you find SUID files?

```bash
find / -type f -perm -4000 2>/dev/null
```

### Q5. How would you harden SSH?

```text
Disable unnecessary root login
        ↓
Prefer key authentication
        ↓
Restrict allowed users
        ↓
Use firewall controls
        ↓
Monitor authentication logs
```

### Q6. Why is hardening not enough?

Because prevention can fail. Systems also need **logging, monitoring, detection, and incident response**.

---

# 25. Quick Cheat Sheet

```bash
# Attack surface
sudo ss -lntup

# Services
systemctl list-units --type=service --state=running

# Users
cat /etc/passwd
id

# Sudo
sudo -l

# SUID
find / -type f -perm -4000 2>/dev/null

# World writable
find / -type f -perm -002 2>/dev/null

# SSH
sudo sshd -t

# Firewall
sudo ufw status

# Logs
journalctl -p err

# Cron
crontab -l

# Timers
systemctl list-timers

# Processes
ps aux
```

## Core Mental Model

```text
                    LINUX SYSTEM
                         │
       ┌─────────────────┼─────────────────┐
       ↓                 ↓                 ↓
    Users            Services           Network
       ↓                 ↓                 ↓
 Permissions         Processes          Ports
       ↓                 ↓                 ↓
       └─────────────────┼─────────────────┘
                         ↓
                    Attack Surface
                         ↓
                    HARDENING
                         ↓
              Prevention + Detection
```

### Final cybersecurity principle

> **Secure the system by reducing unnecessary access, privileges, services, and exposure — then continuously monitor what remains.**

This completes the **Linux fundamentals → security** sequence:

```text
01 Fundamentals
02 File System
03 Commands
04 Users & Permissions
05 Processes
06 Services & systemd
07 Networking
08 Logs
09 SSH
10 Bash
11 Cron
12 Security Hardening
```

**Next major section:** Windows Security / Networking / Active Directory, depending on the cybersecurity roadmap you're following.