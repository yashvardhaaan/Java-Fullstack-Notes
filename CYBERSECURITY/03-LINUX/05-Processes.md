# `05-Processes.md`

# Linux Processes

## 1. First Principle

A **program** is a file containing instructions.

A **process** is that program **while it is running**.

```text
Program
   ↓
Execute
   ↓
Process
   ↓
CPU + Memory + Files + Permissions
```

Example:

```bash
python3 app.py
```

`app.py` is the program.  
The running Python instance is the process.

### Why cybersecurity cares

Attackers often run malicious processes after gaining access.

A security analyst asks:

> **Which process is running, who started it, with which privileges, and what is it accessing?**

---

# 2. PID — Process ID

Every running process gets a unique **PID**.

```bash
ps
```

Example:

```text
PID TTY          TIME CMD
1234 pts/0    00:00:00 bash
1456 pts/0    00:00:01 python3
```

Here:

```text
1234 → bash process
1456 → python process
```

Find your shell's PID:

```bash
echo $$
```

`$$` means **current shell's PID**.

---

# 3. Parent and Child Processes

Processes can create other processes.

```text
systemd
   │
   └── bash
        │
        └── python3
```

- **Parent Process** → creates another process
- **Child Process** → created by a parent
- **PPID** → Parent Process ID

Check it:

```bash
ps -ef
```

Example:

```text
root   1000   1     /usr/bin/bash
user   1200   1000  python3 app.py
```

Meaning:

```text
PID 1200
PPID 1000
```

Python was started by the bash process.

---

# 4. Viewing Processes

## Basic

```bash
ps
```

Shows processes associated with the current terminal.

## All processes

```bash
ps aux
```

Important columns:

```text
USER
PID
%CPU
%MEM
COMMAND
```

## Full process hierarchy

```bash
ps -ef
```

## Find a specific process

```bash
pgrep python
```

Or:

```bash
ps aux | grep python
```

`|` sends the output of one command to another.

---

# 5. Process Tree

```bash
pstree
```

Example:

```text
systemd
 ├─sshd
 │  └─bash
 │     └─python3
 └─cron
```

This is extremely useful during incident investigation.

You can see **who spawned what**.

---

# 6. Real-Time Process Monitoring

```bash
top
```

Useful information:

- CPU usage
- memory usage
- PID
- process owner
- running processes

If available:

```bash
htop
```

`htop` provides an easier interactive view.

---

# 7. Process States

A process can have different states.

Common states:

| State | Meaning |
|---|---|
| `R` | Running |
| `S` | Sleeping |
| `D` | Uninterruptible sleep |
| `T` | Stopped |
| `Z` | Zombie |

Check:

```bash
ps aux
```

Example:

```text
USER PID %CPU STAT COMMAND
user 1234 10.2 R    python3 app.py
```

`R` means the process is currently runnable/running.

---

# 8. Background Processes

Run something in the background:

```bash
sleep 100 &
```

`&` tells the shell to run the command in the background.

Check jobs:

```bash
jobs
```

Bring it to foreground:

```bash
fg
```

Send it back:

```bash
Ctrl + Z
```

Continue in background:

```bash
bg
```

---

# 9. Signals

Linux doesn't simply "delete" a process.

It sends a **signal** to it.

```bash
kill PID
```

Common signals:

| Signal | Number | Purpose |
|---|---:|---|
| `SIGTERM` | 15 | Ask process to terminate |
| `SIGKILL` | 9 | Force termination |
| `SIGHUP` | 1 | Hangup/reload in many applications |
| `SIGSTOP` | 19 | Stop process |
| `SIGCONT` | 18 | Continue stopped process |

Prefer graceful termination:

```bash
kill 1234
```

Force only when necessary:

```bash
kill -9 1234
```

### Important

`SIGKILL` cannot be handled by the application.

So don't automatically use:

```bash
kill -9
```

---

# 10. `/proc` — Process Information

Linux exposes process information through:

```text
/proc
```

For PID `1234`:

```bash
ls /proc/1234
```

Important files:

```text
/proc/1234/cmdline
/proc/1234/status
/proc/1234/exe
/proc/1234/cwd
/proc/1234/fd/
```

### Command used to start process

```bash
cat /proc/1234/cmdline
```

### Process status

```bash
cat /proc/1234/status
```

### Executable

```bash
readlink -f /proc/1234/exe
```

### Current working directory

```bash
readlink -f /proc/1234/cwd
```

### Open files

```bash
ls -l /proc/1234/fd
```

---

# 11. Security Investigation Scenario

Suppose you notice:

```text
python3
```

using high CPU.

First find it:

```bash
pgrep -a python
```

Then:

```bash
ps -fp <PID>
```

Check executable:

```bash
readlink -f /proc/<PID>/exe
```

Check command:

```bash
cat /proc/<PID>/cmdline
```

Check owner:

```bash
ps -o user,pid,ppid,cmd -p <PID>
```

Check parent:

```bash
pstree -sp <PID>
```

Check network connections:

```bash
ss -ntp
```

Now you can ask:

```text
Who owns it?
       ↓
What executable?
       ↓
What command?
       ↓
Who spawned it?
       ↓
What files does it access?
       ↓
Is it communicating over the network?
```

This is the basic thinking behind **process triage**.

---

# 12. Suspicious Process Indicators

A process deserves investigation when you see things like:

```text
Unknown executable
        +
Running as root
        +
Unexpected parent
        +
High CPU
        +
Network connection
```

For example:

```text
root  2345  ... /tmp/.hidden/miner
```

Possible concerns:

- executable located in `/tmp`
- hidden filename
- running as root
- unexpected process

This doesn't automatically mean malware, but it is a strong investigation signal.

---

# 13. Useful Investigation Commands

```bash
ps aux
```

List processes.

```bash
ps -ef
```

Show process hierarchy information.

```bash
pgrep -a <name>
```

Find process by name.

```bash
pstree -p
```

Show process tree with PIDs.

```bash
top
```

Monitor CPU/memory.

```bash
readlink -f /proc/<PID>/exe
```

Find executable.

```bash
cat /proc/<PID>/cmdline
```

Find command-line arguments.

```bash
ls -l /proc/<PID>/fd
```

Inspect open file descriptors.

```bash
ss -ntp
```

Inspect TCP connections and associated processes.

---

# 14. Small Practical Lab

Start a process:

```bash
sleep 300 &
```

Find it:

```bash
pgrep -a sleep
```

Suppose PID is `2500`.

Inspect it:

```bash
ps -fp 2500
```

Check executable:

```bash
readlink -f /proc/2500/exe
```

Check status:

```bash
cat /proc/2500/status
```

Stop it:

```bash
kill 2500
```

Verify:

```bash
pgrep -a sleep
```

---

# 15. Process Security Concepts

A process inherits security context from its execution environment.

Important concepts:

```text
Process
 ├── PID
 ├── PPID
 ├── User
 ├── Groups
 ├── Permissions
 ├── Environment
 ├── Open Files
 ├── Network Connections
 └── Executable
```

For cybersecurity, always connect:

> **Process + Identity + Executable + Parent + Network**

---

# 16. Interview Questions

### Q1. What is a process?

A running instance of a program.

### Q2. What is PID?

A unique identifier assigned to a process.

### Q3. What is PPID?

The PID of the process that created the current process.

### Q4. Difference between `SIGTERM` and `SIGKILL`?

`SIGTERM` requests graceful termination; `SIGKILL` forcibly terminates the process.

### Q5. What is `/proc`?

A virtual filesystem exposing runtime information about processes and the Linux kernel.

### Q6. How would you investigate a suspicious process?

```text
ps
 ↓
PID/owner
 ↓
/proc/PID
 ↓
executable
 ↓
command line
 ↓
parent process
 ↓
open files
 ↓
network connections
```

---

# 17. Quick Cheat Sheet

```bash
ps aux
ps -ef
pgrep -a <name>
pstree -p
top
jobs
fg
bg

kill <PID>
kill -9 <PID>

cat /proc/<PID>/status
cat /proc/<PID>/cmdline
readlink -f /proc/<PID>/exe
readlink -f /proc/<PID>/cwd
ls -l /proc/<PID>/fd

ss -ntp
```

### Core mental model

```text
Program
   ↓
Process
   ↓
PID
   ↓
Who owns it?
   ↓
Who spawned it?
   ↓
What is it executing?
   ↓
What files/network resources does it use?
```

**Next:** `06-Services-Systemd.md`