# `08-Linux-Logs.md`

# Linux Logs & Log Analysis

## 1. First Principle

A **log is a record of something that happened** on a system.

Think:

```text
Event
  ↓
Application / Kernel / Service
  ↓
Log
  ↓
Investigation
  ↓
Detection / Response
```

For cybersecurity:

> **Logs are evidence of system activity.**

They can help answer:

- Who logged in?
- When did they log in?
- Which service failed?
- What process started?
- Was authentication successful?
- Did something suspicious happen?

---

# 2. Where Linux Logs Live

Traditional Linux logs are commonly stored under:

```text
/var/log/
```

Check:

```bash
ls -lah /var/log/
```

Common files/directories:

```text
/var/log/auth.log
/var/log/syslog
/var/log/kern.log
/var/log/dmesg
```

Exact files vary by Linux distribution.

For example, RHEL-based systems commonly use:

```text
/var/log/secure
/var/log/messages
```

---

# 3. journalctl

Modern Linux systems commonly use **systemd-journald**.

The main command is:

```bash
journalctl
```

View logs:

```bash
journalctl
```

View recent logs:

```bash
journalctl -n 50
```

Meaning:

```text
-n 50
  ↓
Show last 50 entries
```

---

# 4. Follow Logs in Real Time

```bash
journalctl -f
```

`-f` means **follow**.

It continuously displays new log entries.

This is useful when:

- troubleshooting a service
- monitoring authentication
- observing application behavior

Stop with:

```text
Ctrl + C
```

---

# 5. Logs for a Specific Service

Example:

```bash
journalctl -u ssh
```

Some systems use:

```bash
journalctl -u sshd
```

Follow them:

```bash
journalctl -u ssh -f
```

Recent logs:

```bash
journalctl -u ssh -n 50
```

Mental model:

```text
journalctl
    ↓
Select source
    ↓
Filter time
    ↓
Filter event
    ↓
Investigate
```

---

# 6. Filter by Time

Today's logs:

```bash
journalctl --since today
```

Last hour:

```bash
journalctl --since "1 hour ago"
```

Specific period:

```bash
journalctl --since "2026-10-08 08:00" --until "2026-10-08 09:00"
```

This is extremely useful during incident investigation.

Example:

> "The server started behaving strangely at 08:30."

You can investigate:

```bash
journalctl --since "08:00" --until "09:00"
```

---

# 7. Authentication Logs

Authentication events are highly important for cybersecurity.

Depending on the distribution:

```bash
sudo grep "Failed password" /var/log/auth.log
```

or:

```bash
sudo grep "Failed password" /var/log/secure
```

Successful SSH logins:

```bash
sudo grep "Accepted" /var/log/auth.log
```

Possible output:

```text
Failed password for invalid user admin from 203.0.113.10
```

This can indicate attempted unauthorized access.

---

# 8. `grep` for Log Analysis

`grep` searches text.

Example:

```bash
grep "error" /var/log/syslog
```

Case-insensitive:

```bash
grep -i "error" /var/log/syslog
```

Search authentication failures:

```bash
grep -i "failed" /var/log/auth.log
```

Count matches:

```bash
grep -c "Failed password" /var/log/auth.log
```

---

# 9. Finding Attack Patterns

Suppose SSH logs contain:

```text
Failed password for root from 203.0.113.10
Failed password for admin from 203.0.113.10
Failed password for user from 203.0.113.10
```

Search:

```bash
grep "Failed password" /var/log/auth.log
```

Extract source IPs:

```bash
grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}'
```

The exact field position can vary by log format, so always inspect sample lines first.

---

# 10. Count Repeated IP Addresses

A common investigation pattern:

```bash
grep "Failed password" /var/log/auth.log \
| awk '{print $(NF-3)}' \
| sort \
| uniq -c \
| sort -nr
```

Conceptually:

```text
grep
 ↓
Find failed logins

awk
 ↓
Extract IP

sort
 ↓
Group identical values

uniq -c
 ↓
Count them

sort -nr
 ↓
Show highest counts first
```

This can reveal a source generating many authentication failures.

---

# 11. Kernel Logs

Kernel events can be viewed using:

```bash
journalctl -k
```

or:

```bash
dmesg
```

Examples of useful information:

- hardware problems
- driver events
- device detection
- kernel errors
- security-related kernel messages

Search for errors:

```bash
journalctl -k | grep -i error
```

---

# 12. Log Levels

Common severity levels include:

| Level | Meaning |
|---|---|
| `emerg` | Emergency |
| `alert` | Immediate action required |
| `crit` | Critical |
| `err` | Error |
| `warning` | Warning |
| `notice` | Significant event |
| `info` | Informational |
| `debug` | Debugging |

You may filter journal logs by priority:

```bash
journalctl -p err
```

Errors and more severe messages:

```bash
journalctl -p err..emerg
```

---

# 13. Login History

Useful commands:

```bash
last
```

Shows previous login sessions.

Current users:

```bash
who
```

More information:

```bash
w
```

Failed login attempts:

```bash
lastb
```

`lastb` may require root privileges.

These are useful when investigating account compromise.

---

# 14. Security Investigation Scenario

Suppose a server owner says:

> "Someone may have accessed my SSH server."

Start with:

```bash
last
```

Then inspect failed attempts:

```bash
sudo lastb
```

Search SSH failures:

```bash
sudo grep "Failed password" /var/log/auth.log
```

Search successful SSH authentication:

```bash
sudo grep "Accepted" /var/log/auth.log
```

Check recent journal entries:

```bash
sudo journalctl -u ssh --since "24 hours ago"
```

Then correlate:

```text
Time
 ↓
Username
 ↓
Source IP
 ↓
Success/failure
 ↓
Session
 ↓
Commands/processes
```

This is much more useful than looking at one log line in isolation.

---

# 15. Log Correlation

One event rarely tells the whole story.

Example:

```text
08:10
Failed SSH login

08:12
Successful SSH login

08:13
sudo command

08:14
New process started

08:15
Outbound network connection
```

Individually these may be normal.

Together they may indicate compromise.

The analyst therefore asks:

> **What happened before and after this event?**

---

# 16. Log Rotation

Logs can grow continuously.

Linux systems commonly use **log rotation** to prevent them from consuming all disk space.

Check:

```bash
ls -lh /var/log/
```

You may see:

```text
auth.log
auth.log.1
auth.log.2.gz
```

Compressed logs can be searched using:

```bash
zgrep "Failed password" /var/log/auth.log.2.gz
```

This is important during investigations because older evidence may be stored in rotated logs.

---

# 17. Practical Lab

Generate some events by checking SSH:

```bash
systemctl status ssh
```

Then inspect:

```bash
journalctl -u ssh -n 20
```

Check authentication:

```bash
sudo grep -i "ssh" /var/log/auth.log
```

Check recent logins:

```bash
last
```

Check failed logins:

```bash
sudo lastb
```

Finally:

```bash
journalctl --since "1 hour ago"
```

Try to identify:

```text
1. What services generated logs?
2. What users appeared?
3. Were there authentication failures?
4. What timestamps were involved?
5. Were there unusual events?
```

---

# 18. Simple Security Log Analysis Script

```bash
#!/bin/bash

LOG="/var/log/auth.log"

echo "===== Failed SSH Attempts ====="

grep "Failed password" "$LOG" | tail -20

echo
echo "===== Successful SSH Logins ====="

grep "Accepted" "$LOG" | tail -20

echo
echo "===== Failed Attempt Count ====="

grep -c "Failed password" "$LOG"
```

### What it does

```text
LOG
 ↓
Stores log file path

grep
 ↓
Finds authentication events

tail
 ↓
Shows recent entries

grep -c
 ↓
Counts failures
```

This is a simple example of **security automation using Bash**.

---

# 19. Detection Thinking

Don't just search for `"error"`.

Look for behavioral patterns:

```text
Many failed logins
        ↓
Successful login
        ↓
Privilege escalation
        ↓
Suspicious process
        ↓
Outbound connection
```

Other useful indicators:

- login from unexpected IP
- login at unusual time
- new user creation
- repeated authentication failures
- unexpected service start
- repeated sudo failures
- unusual process execution

---

# 20. Important Commands

```bash
# Journal
journalctl
journalctl -n 50
journalctl -f
journalctl -u ssh
journalctl --since "1 hour ago"
journalctl -k
journalctl -p err

# Traditional logs
ls -lah /var/log/

# Search
grep "Failed password" /var/log/auth.log
grep -i "error" /var/log/syslog

# Authentication
last
lastb
who
w

# Rotated logs
zgrep "Failed password" /var/log/auth.log.2.gz
```

---

# 21. Interview Questions

### Q1. What is the purpose of logs?

To record system/application events that can be used for troubleshooting, monitoring, auditing, and security investigation.

### Q2. What is `journalctl`?

A command-line tool for querying logs collected by `systemd-journald`.

### Q3. How do you view logs for a specific service?

```bash
journalctl -u <service>
```

### Q4. How do you monitor logs in real time?

```bash
journalctl -f
```

### Q5. How would you investigate SSH brute-force attempts?

```text
Authentication logs
       ↓
Failed login attempts
       ↓
Source IPs
       ↓
Frequency
       ↓
Successful logins
       ↓
Account activity
```

### Q6. Why is log correlation important?

Because individual events may look normal, while a sequence of related events can reveal an attack.

---

# 22. Quick Cheat Sheet

```bash
# View logs
journalctl

# Last 50 entries
journalctl -n 50

# Real-time
journalctl -f

# Service logs
journalctl -u ssh

# Time filtering
journalctl --since "1 hour ago"

# Kernel logs
journalctl -k

# Errors
journalctl -p err

# Login history
last
lastb
who
w

# Search authentication
grep "Failed password" /var/log/auth.log
grep "Accepted" /var/log/auth.log

# Count failures
grep -c "Failed password" /var/log/auth.log
```

## Core Mental Model

```text
Event
  ↓
Log
  ↓
Filter
  ↓
Correlate
  ↓
Investigate
  ↓
Detect
  ↓
Respond
```

For a **Cybersecurity Analyst**, logs are one of the most important sources of evidence. Learn to connect **timestamp + user + process + IP + action**, rather than simply searching for error messages.

**Next:** `09-SSH.md`