# `09-SSH.md`

# SSH — Secure Shell

## 1. First Principle

SSH allows you to **securely access and control another computer over a network**.

Basic model:

```text
SSH Client
    ↓
Network
    ↓
SSH Server
    ↓
Authentication
    ↓
Shell / Command Execution
```

Example:

```bash
ssh user@192.168.1.20
```

Meaning:

```text
ssh       → SSH client
user      → remote username
@         → at
192.168.1.20 → remote machine
```

For cybersecurity, SSH is important because it provides legitimate remote administration but is also frequently targeted for:

- brute-force attacks
- stolen credentials
- unauthorized access
- privilege escalation
- persistence

---

# 2. SSH Client vs Server

### Client

The machine initiating the connection.

```bash
ssh user@server
```

### Server

The machine accepting SSH connections.

Common SSH server software:

```text
OpenSSH
```

Check:

```bash
systemctl status ssh
```

or:

```bash
systemctl status sshd
```

---

# 3. SSH Port

Default SSH port:

```text
22/TCP
```

Check whether SSH is listening:

```bash
sudo ss -lntp | grep ':22'
```

Example:

```text
LISTEN 0 128 0.0.0.0:22
```

This means an SSH service is listening on TCP port 22.

---

# 4. Connecting Using SSH

Basic:

```bash
ssh username@server-ip
```

Example:

```bash
ssh analyst@192.168.1.20
```

Specify another port:

```bash
ssh -p 2222 analyst@192.168.1.20
```

Verbose mode:

```bash
ssh -v analyst@192.168.1.20
```

Verbose mode is useful for troubleshooting authentication and connection problems.

---

# 5. SSH Authentication

SSH can authenticate users using:

```text
Password
   OR
SSH Key
```

SSH keys are generally preferred over passwords for server administration.

Basic key architecture:

```text
Client
 ├── Private Key 🔒
 └── Public Key

Server
 └── Authorized Public Key
```

The private key should **never be shared**.

---

# 6. Generate an SSH Key

Generate an Ed25519 key:

```bash
ssh-keygen -t ed25519
```

You will normally get:

```text
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
```

Meaning:

```text
id_ed25519
    ↓
Private key

id_ed25519.pub
    ↓
Public key
```

Protect the private key:

```bash
chmod 600 ~/.ssh/id_ed25519
```

---

# 7. Copy Public Key to Server

```bash
ssh-copy-id user@server
```

This places your public key in:

```text
~/.ssh/authorized_keys
```

on the server.

Then connect:

```bash
ssh user@server
```

The server verifies that you possess the corresponding private key.

---

# 8. `authorized_keys`

On the server:

```bash
cat ~/.ssh/authorized_keys
```

This file contains public keys that are allowed to authenticate that account.

Security implication:

> An unauthorized key added to `authorized_keys` can provide persistent access to an account.

Therefore, during incident response, inspect:

```bash
ls -la ~/.ssh/
cat ~/.ssh/authorized_keys
```

---

# 9. SSH Configuration

Server configuration is commonly:

```text
/etc/ssh/sshd_config
```

View it:

```bash
sudo less /etc/ssh/sshd_config
```

Important settings include:

```text
Port
PermitRootLogin
PasswordAuthentication
PubkeyAuthentication
AllowUsers
```

After changing configuration, validate it:

```bash
sudo sshd -t
```

If valid, restart/reload SSH:

```bash
sudo systemctl reload ssh
```

---

# 10. SSH Security Hardening

### Disable direct root login

In `sshd_config`:

```text
PermitRootLogin no
```

Why?

```text
Internet
   ↓
SSH
   ↓
root login
```

Removing direct root login reduces the attack surface.

---

### Prefer key authentication

```text
PasswordAuthentication no
```

But **only disable passwords after confirming key-based access works**.

Otherwise, you can lock yourself out.

---

### Restrict allowed users

Example:

```text
AllowUsers analyst admin
```

This limits SSH access to specific accounts.

---

# 11. SSH Logs

SSH authentication activity is extremely important for security monitoring.

Depending on the distribution:

```bash
sudo journalctl -u ssh
```

or:

```bash
sudo journalctl -u sshd
```

Traditional log:

```bash
sudo grep "Failed password" /var/log/auth.log
```

Successful authentication:

```bash
sudo grep "Accepted" /var/log/auth.log
```

---

# 12. Detecting Brute Force

Example:

```text
Failed password for root from 203.0.113.10
Failed password for admin from 203.0.113.10
Failed password for test from 203.0.113.10
```

Search:

```bash
sudo grep "Failed password" /var/log/auth.log
```

Count attempts:

```bash
sudo grep -c "Failed password" /var/log/auth.log
```

Extract frequent source IPs:

```bash
sudo grep "Failed password" /var/log/auth.log \
| awk '{print $(NF-3)}' \
| sort | uniq -c | sort -nr
```

Concept:

```text
Logs
 ↓
Failed attempts
 ↓
Extract IP
 ↓
Count
 ↓
Identify suspicious sources
```

---

# 13. Successful Login Investigation

Search:

```bash
sudo grep "Accepted" /var/log/auth.log
```

You may see:

```text
Accepted publickey for analyst from 192.168.1.50
```

Investigate:

```text
Who?
 ↓
When?
 ↓
From where?
 ↓
How authenticated?
 ↓
What happened afterward?
```

Then correlate with:

```bash
last
```

and:

```bash
journalctl --since "1 hour ago"
```

---

# 14. SSH Security Investigation

Suppose you find:

```text
Accepted password for admin from 203.0.113.50
```

You don't immediately conclude that the account was compromised.

Investigate:

### Step 1 — Identify login

```bash
last
```

### Step 2 — Check SSH logs

```bash
sudo journalctl -u ssh --since "2 hours ago"
```

### Step 3 — Check sudo activity

```bash
sudo grep "sudo" /var/log/auth.log
```

### Step 4 — Check processes

```bash
ps aux
```

### Step 5 — Check network connections

```bash
sudo ss -tnp
```

### Step 6 — Check SSH keys

```bash
cat ~/.ssh/authorized_keys
```

---

# 15. SSH Agent

SSH agent can store private keys in memory so you don't repeatedly enter passphrases.

Check:

```bash
ssh-add -l
```

Add a key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Security principle:

> Protect the SSH agent and private keys because they can provide access to other systems.

---

# 16. SSH File Permissions

Typical private key permission:

```bash
chmod 600 ~/.ssh/id_ed25519
```

SSH directory:

```bash
chmod 700 ~/.ssh
```

Authorized keys:

```bash
chmod 600 ~/.ssh/authorized_keys
```

Check:

```bash
ls -la ~/.ssh/
```

Incorrect permissions can cause SSH to reject keys or create security risks.

---

# 17. Practical Lab

Generate a key:

```bash
ssh-keygen -t ed25519
```

Check:

```bash
ls -la ~/.ssh/
```

Inspect the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Check SSH configuration:

```bash
sudo sshd -t
```

Check service:

```bash
systemctl status ssh
```

Check listening port:

```bash
sudo ss -lntp | grep ':22'
```

Check authentication logs:

```bash
sudo journalctl -u ssh -n 50
```

---

# 18. Important Commands

```bash
# Connect
ssh user@host

# Different port
ssh -p 2222 user@host

# Debug
ssh -v user@host

# Generate key
ssh-keygen -t ed25519

# Copy public key
ssh-copy-id user@host

# List loaded keys
ssh-add -l

# SSH service
systemctl status ssh

# Validate configuration
sudo sshd -t

# SSH logs
journalctl -u ssh

# Authentication failures
grep "Failed password" /var/log/auth.log

# Successful authentication
grep "Accepted" /var/log/auth.log
```

---

# 19. Cybersecurity Mental Model

When investigating SSH:

```text
SSH Connection
      ↓
Source IP
      ↓
Username
      ↓
Authentication method
      ↓
Success / Failure
      ↓
Session
      ↓
Commands / Processes
      ↓
Network Activity
```

This allows an analyst to move from:

> **"Someone connected."**

to:

> **"Who connected, from where, how did they authenticate, and what did they do afterward?"**

---

# 20. Interview Questions

### Q1. What is SSH?

A protocol used for secure remote access and command execution over a network.

### Q2. What is the default SSH port?

```text
TCP 22
```

### Q3. Difference between public and private key?

```text
Public key → placed on server
Private key → kept secret on client
```

### Q4. What is `authorized_keys`?

A file containing public keys permitted to authenticate an account.

### Q5. How would you detect SSH brute force?

Analyze repeated failed authentication attempts and correlate their source IPs, usernames, timestamps, and subsequent successful logins.

### Q6. Why shouldn't you blindly disable password authentication?

Because if key-based authentication hasn't been tested, you may lock yourself out of the server.

---

# 21. Quick Cheat Sheet

```bash
ssh user@host

ssh-keygen -t ed25519
ssh-copy-id user@host

chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/authorized_keys

sudo sshd -t

systemctl status ssh
sudo ss -lntp | grep ':22'

journalctl -u ssh
last
sudo grep "Failed password" /var/log/auth.log
sudo grep "Accepted" /var/log/auth.log
```

## Core Mental Model

```text
Client
   ↓
SSH
   ↓
Authentication
   ↓
Server
   ↓
Shell
   ↓
Commands
   ↓
Processes
   ↓
Network / Files
```

For a **Cybersecurity Analyst**, SSH is important for both **secure administration and attack detection**. Learn to investigate SSH activity through **authentication logs + source IP + user + keys + processes + network connections**.

**Next:** `10-Bash-Scripting.md`