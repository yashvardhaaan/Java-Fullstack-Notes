# `06-Services-Systemd.md`

# Linux Services & systemd

## 1. First Principle

A **process** is running software.

A **service** is a program designed to run in the background and provide a function.

Examples:

```text
SSH        → remote access
Nginx      → web server
PostgreSQL → database
Docker     → container management
Cron       → scheduled tasks
```

Modern Linux systems commonly use **systemd** to manage these services.

```text
systemd
   ↓
Starts services
   ↓
Stops services
   ↓
Restarts services
   ↓
Monitors services
   ↓
Controls startup behavior
```

---

# 2. What is systemd?

`systemd` is the main service and system manager on many Linux distributions.

Check it:

```bash
ps -p 1 -o pid,comm,args
```

Typical output:

```text
PID COMMAND COMMAND
1   systemd /sbin/init
```

PID `1` is special because it is the ancestor of most processes.

---

# 3. systemctl

The main command for managing systemd services is:

```bash
systemctl
```

Check a service:

```bash
systemctl status ssh
```

On some distributions:

```bash
systemctl status sshd
```

You may see:

```text
Active: active (running)
```

Meaning the service is currently running.

---

# 4. Start and Stop Services

Start:

```bash
sudo systemctl start nginx
```

Stop:

```bash
sudo systemctl stop nginx
```

Restart:

```bash
sudo systemctl restart nginx
```

Reload configuration without fully restarting:

```bash
sudo systemctl reload nginx
```

### Difference

```text
start
  ↓
Start service

stop
  ↓
Stop service

restart
  ↓
Stop + start

reload
  ↓
Reload configuration
```

---

# 5. Enable vs Start

This is an important interview concept.

### Start

```bash
sudo systemctl start nginx
```

Starts it **now**.

### Enable

```bash
sudo systemctl enable nginx
```

Configures it to start automatically during boot.

You can do both:

```bash
sudo systemctl enable --now nginx
```

Meaning:

> Enable at boot and start immediately.

---

# 6. Disable a Service

```bash
sudo systemctl disable nginx
```

Prevents automatic startup.

To stop it immediately as well:

```bash
sudo systemctl disable --now nginx
```

---

# 7. Check Service Status

```bash
systemctl status nginx
```

Useful information includes:

```text
Active state
PID
Memory
CPU
Recent logs
Startup configuration
```

For a simple state:

```bash
systemctl is-active nginx
```

Check whether it starts at boot:

```bash
systemctl is-enabled nginx
```

---

# 8. List Services

Running services:

```bash
systemctl list-units --type=service --state=running
```

All installed service units:

```bash
systemctl list-unit-files --type=service
```

This is useful during security investigations.

You may discover an unexpected service.

---

# 9. Service Files

systemd services are defined using **unit files**.

Example:

```text
/etc/systemd/system/myapp.service
```

System-provided services may be located under:

```text
/usr/lib/systemd/system/
```

or:

```text
/lib/systemd/system/
```

Inspect a service:

```bash
systemctl cat nginx
```

This shows how systemd starts it.

---

# 10. Understanding a Service File

Example:

```ini
[Unit]
Description=My Application

[Service]
ExecStart=/opt/myapp/app
User=myuser
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

### `[Unit]`

General information and dependencies.

### `[Service]`

Defines how the program runs.

```ini
ExecStart=/opt/myapp/app
```

The executable that starts the service.

```ini
User=myuser
```

The account used to run it.

```ini
Restart=on-failure
```

Restart if the process fails.

### `[Install]`

Defines how the service integrates with system startup.

---

# 11. Why Services Matter in Cybersecurity

Attackers may create **persistence** using services.

Example:

```text
Attacker gains access
       ↓
Creates malicious service
       ↓
Service starts at boot
       ↓
Malware executes automatically
```

Therefore, unexpected services are important investigation targets.

Check:

```bash
systemctl list-unit-files --type=service
```

Look for:

- unfamiliar service names
- unusual executable paths
- services running as root
- recently created service files
- executables in `/tmp`, `/var/tmp`, or user directories

---

# 12. Investigating a Suspicious Service

Suppose you find:

```text
my-update.service
```

First:

```bash
systemctl status my-update.service
```

Then:

```bash
systemctl cat my-update.service
```

Find the process:

```bash
systemctl status my-update.service
```

You can then investigate its PID:

```bash
ps -fp <PID>
```

Find executable:

```bash
readlink -f /proc/<PID>/exe
```

Check its network connections:

```bash
ss -ntp
```

Mental model:

```text
Service
   ↓
Unit file
   ↓
ExecStart
   ↓
Process
   ↓
Executable
   ↓
Network / Files
```

---

# 13. Service Logs

systemd commonly uses **journald** for logging.

View service logs:

```bash
journalctl -u nginx
```

Recent logs:

```bash
journalctl -u nginx --since "1 hour ago"
```

Follow logs live:

```bash
journalctl -u nginx -f
```

System logs:

```bash
journalctl
```

Recent boot logs:

```bash
journalctl -b
```

---

# 14. Practical Security Scenario

Imagine an analyst finds:

```text
Active: suspicious.service
User: root
ExecStart=/tmp/update
```

Investigation:

```bash
systemctl status suspicious.service
```

Then:

```bash
systemctl cat suspicious.service
```

Check executable:

```bash
ls -l /tmp/update
```

Hash it:

```bash
sha256sum /tmp/update
```

Check process:

```bash
ps aux | grep update
```

Check network:

```bash
ss -ntp
```

Check logs:

```bash
journalctl -u suspicious.service
```

Now you have evidence about:

```text
Who runs it?
What runs?
Where is it?
When does it start?
What process does it create?
Does it communicate externally?
```

---

# 15. Service Security Hardening

A service should generally run with **minimum required privileges**.

Prefer:

```ini
User=appuser
```

instead of:

```ini
User=root
```

when root privileges are unnecessary.

Other useful hardening options can include:

```ini
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
```

These restrict what the service can do.

**Do not blindly add hardening options to production services**—test compatibility first.

---

# 16. Practical Lab

Check whether SSH is running:

```bash
systemctl status ssh
```

Find its process:

```bash
pgrep -a ssh
```

Find listening ports:

```bash
ss -lntp
```

View SSH logs:

```bash
journalctl -u ssh --since "1 hour ago"
```

List enabled services:

```bash
systemctl list-unit-files --state=enabled
```

Look for services you don't recognize.

---

# 17. Important Commands

```bash
systemctl status <service>
systemctl start <service>
systemctl stop <service>
systemctl restart <service>
systemctl reload <service>

systemctl enable <service>
systemctl disable <service>

systemctl is-active <service>
systemctl is-enabled <service>

systemctl list-units --type=service
systemctl list-unit-files --type=service

systemctl cat <service>

journalctl -u <service>
journalctl -u <service> -f
journalctl -b
```

---

# 18. Interview Questions

### Q1. What is systemd?

A system and service manager used by many modern Linux distributions.

### Q2. What is `systemctl`?

The command-line utility used to manage systemd units and services.

### Q3. Difference between `start` and `enable`?

```text
start  → runs now
enable → starts automatically at boot
```

### Q4. Where can systemd service files exist?

Common locations include:

```text
/etc/systemd/system/
/usr/lib/systemd/system/
/lib/systemd/system/
```

### Q5. How can you investigate a suspicious service?

```text
systemctl status
      ↓
systemctl cat
      ↓
Find ExecStart
      ↓
Inspect process
      ↓
Inspect executable
      ↓
Check network
      ↓
Check journal logs
```

---

# 19. Quick Cheat Sheet

```bash
# Status
systemctl status nginx

# Start / Stop
sudo systemctl start nginx
sudo systemctl stop nginx

# Restart
sudo systemctl restart nginx

# Boot startup
sudo systemctl enable nginx
sudo systemctl disable nginx

# Service configuration
systemctl cat nginx

# Running services
systemctl list-units --type=service --state=running

# Logs
journalctl -u nginx
journalctl -u nginx -f

# Network
ss -lntp
```

## Core Mental Model

```text
systemd
   ↓
Service
   ↓
Unit file
   ↓
ExecStart
   ↓
Process
   ↓
Executable
   ↓
Files + Network + Privileges
```

For a **Cybersecurity Analyst**, this chain is important because services are a common place to investigate **persistence, privilege abuse, unauthorized software, and suspicious processes**.

**Next:** `07-Linux-Networking.md`