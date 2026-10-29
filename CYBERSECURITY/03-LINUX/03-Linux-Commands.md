# `03-Linux-Commands.md`

```md
# Linux Commands

> Goal: Master the Linux command line from first principles and learn how cybersecurity analysts combine commands to investigate systems, files, processes, logs, users, and network activity.

---

# 1. First Principle — Why Linux Has So Many Small Commands

Linux follows a powerful philosophy:

> Build small tools that do one thing well, then combine them.

For example:

```text
ps
 |
 | process information
 v
grep
 |
 | filtering
 v
sort
 |
 | ordering
 v
head
 |
 | limiting output
 v
report
```

Instead of requiring one giant program, Linux allows you to combine small commands.

Example:

```bash
ps aux | grep ssh | sort
```

This idea is extremely important for cybersecurity.

A security analyst frequently needs to:

```text
Collect
   ↓
Filter
   ↓
Transform
   ↓
Correlate
   ↓
Analyze
   ↓
Report
```

---

# 2. Command Structure

Most Linux commands follow:

```bash
command [options] [arguments]
```

Example:

```bash
ls -lah /var/log
```

Breakdown:

```text
ls       -> command
-lah     -> options
/var/log -> argument
```

Another example:

```bash
grep -i "failed" /var/log/auth.log
```

```text
grep       -> command
-i         -> option
"failed"   -> search pattern
auth.log   -> input file
```

---

# 3. Command Execution Flow

When you type:

```bash
ls
```

the shell roughly does:

```text
You
 |
 v
Shell
 |
 | Parse command
 v
Find executable
 |
 v
Execute program
 |
 v
Program produces output
 |
 v
Terminal
```

If you use:

```bash
ls | grep ssh
```

the flow becomes:

```text
ls
 |
 | stdout
 v
PIPE
 |
 v
grep
 |
 v
Terminal
```

---

# 4. `pwd`

`pwd` means:

```text
Print Working Directory
```

Run:

```bash
pwd
```

Example:

```text
/home/user
```

This tells you where you currently are.

---

# 5. Practical Use of `pwd`

Before performing filesystem operations:

```bash
pwd
```

is a good habit.

For example:

```bash
cd /tmp
pwd
```

Output:

```text
/tmp
```

This prevents mistakes when running commands against relative paths.

---

# 6. `ls`

List directory contents:

```bash
ls
```

Detailed listing:

```bash
ls -l
```

Show hidden files:

```bash
ls -a
```

Human-readable sizes:

```bash
ls -lh
```

Combine:

```bash
ls -lah
```

---

# 7. Understanding `ls -lah`

Example:

```bash
ls -lah
```

Possible output:

```text
drwxr-xr-x  2 user user 4.0K Oct  8 09:00 .
drwxr-xr-x 20 user user 4.0K Oct  8 08:00 ..
-rw-r--r--  1 user user  120 Oct  8 09:00 notes.txt
```

Important fields:

```text
permissions
   |
   v
owner
   |
   v
group
   |
   v
size
   |
   v
date/time
   |
   v
filename
```

Permissions will be studied deeply in:

```text
04-Users-Groups-Permissions.md
```

---

# 8. `cd`

Change directory:

```bash
cd /etc
```

Go to parent:

```bash
cd ..
```

Go home:

```bash
cd ~
```

Go to previous directory:

```bash
cd -
```

Go to filesystem root:

```bash
cd /
```

---

# 9. Practical Navigation Exercise

Run:

```bash
cd /
pwd
```

Then:

```bash
cd /etc
pwd
```

Then:

```bash
cd ..
pwd
```

Then:

```bash
cd -
pwd
```

Understand exactly what directory you are in after every command.

---

# 10. `mkdir`

Create directory:

```bash
mkdir lab
```

Create nested directories:

```bash
mkdir -p ~/linux-lab/commands/files/logs
```

Verify:

```bash
ls -R ~/linux-lab/commands
```

---

# 11. `touch`

Create an empty file:

```bash
touch test.txt
```

Create multiple files:

```bash
touch file1.txt file2.txt file3.txt
```

Useful for labs.

Example:

```bash
mkdir -p ~/linux-lab/commands
cd ~/linux-lab/commands

touch users.txt
touch logs.txt
touch alerts.txt
```

---

# 12. `cat`

Display a file:

```bash
cat users.txt
```

Create content:

```bash
echo "admin" > users.txt
```

Read it:

```bash
cat users.txt
```

---

# 13. `cat` for Multiple Files

```bash
cat file1.txt file2.txt
```

This outputs both files sequentially.

You can combine files:

```bash
cat file1.txt file2.txt > combined.txt
```

Flow:

```text
file1
   \
    +--> cat --> combined.txt
   /
file2
```

---

# 14. `less`

For large files:

```bash
less /var/log/syslog
```

Useful keys:

```text
Space -> next page
b     -> previous page
/     -> search
n     -> next match
q     -> quit
```

Security analysts frequently use `less` for large logs.

---

# 15. `head`

Show first lines:

```bash
head file.txt
```

First 20 lines:

```bash
head -20 file.txt
```

Equivalent:

```bash
head -n 20 file.txt
```

---

# 16. `tail`

Show last lines:

```bash
tail file.txt
```

Last 20:

```bash
tail -n 20 file.txt
```

---

# 17. `tail -f`

Follow a file as it changes:

```bash
tail -f application.log
```

This is extremely useful for monitoring logs.

Example:

```text
Application
     |
     v
Writes new log
     |
     v
application.log
     |
     v
tail -f
     |
     v
Terminal
```

Stop with:

```text
Ctrl+C
```

---

# 18. Practical Log Monitoring Lab

Terminal 1:

```bash
mkdir -p ~/linux-lab/commands/logs
cd ~/linux-lab/commands/logs

touch application.log

tail -f application.log
```

Terminal 2:

```bash
echo "INFO Application started" >> ~/linux-lab/commands/logs/application.log
```

Then:

```bash
echo "WARNING CPU high" >> ~/linux-lab/commands/logs/application.log
```

Then:

```bash
echo "ERROR Database unavailable" >> ~/linux-lab/commands/logs/application.log
```

Terminal 1 should display the new lines immediately.

---

# 19. `cp`

Copy a file:

```bash
cp source.txt destination.txt
```

Copy into directory:

```bash
cp source.txt ~/linux-lab/
```

Copy directory recursively:

```bash
cp -r directory backup-directory
```

---

# 20. `mv`

Move:

```bash
mv file.txt ~/linux-lab/
```

Rename:

```bash
mv old.txt new.txt
```

The same command performs both operations.

---

# 21. `rm`

Remove a file:

```bash
rm file.txt
```

Interactive removal:

```bash
rm -i file.txt
```

Recursive directory removal:

```bash
rm -r directory
```

Force:

```bash
rm -f file.txt
```

Dangerous combination:

```bash
rm -rf directory
```

Never run destructive commands unless you completely understand the target.

---

# 22. `file`

Identify a file:

```bash
file suspicious.bin
```

Example:

```text
ELF 64-bit LSB executable
```

For a script:

```bash
file script.sh
```

For an image:

```bash
file photo.jpg
```

Cybersecurity use:

```text
Unknown file
    ↓
file
    ↓
Determine type
```

---

# 23. `stat`

Display metadata:

```bash
stat suspicious.bin
```

Useful information:

```text
Size
Permissions
Owner
Group
Access time
Modification time
Change time
```

This is useful during investigations.

---

# 24. `sha256sum`

Calculate SHA-256:

```bash
sha256sum file.txt
```

Example:

```text
4f3a... file.txt
```

Why hashes matter:

```text
File A
   |
 SHA-256
   |
Hash A

File B
   |
 SHA-256
   |
Hash B
```

If hashes differ, the file contents differ.

---

# 25. `md5sum`

You may encounter:

```bash
md5sum file.txt
```

MD5 is useful for identifying known artifacts in some legacy contexts, but should not be relied upon for modern cryptographic integrity/security requirements.

Prefer:

```bash
sha256sum file.txt
```

for modern workflows.

---

# 26. `find`

Search for files.

Example:

```bash
find /var/log -type f
```

Find by name:

```bash
find /var/log -name "*.log"
```

Case-insensitive:

```bash
find /var/log -iname "*.LOG"
```

---

# 27. `find` by Modification Time

Files modified in the last day:

```bash
find /var/log -type f -mtime -1
```

Files modified within 60 minutes:

```bash
find /tmp -type f -mmin -60
```

This is useful during incident response.

---

# 28. `find` by Size

Find files larger than 100 MB:

```bash
find /var -type f -size +100M 2>/dev/null
```

Find small files:

```bash
find . -type f -size -1k
```

---

# 29. `find` by Permission

Find SUID files:

```bash
find / -type f -perm -4000 2>/dev/null
```

Find SGID files:

```bash
find / -type f -perm -2000 2>/dev/null
```

Find world-writable files:

```bash
find / -type f -perm -002 2>/dev/null
```

These commands are useful for security auditing.

---

# 30. `grep`

`grep` searches text.

Example:

```bash
grep "ERROR" application.log
```

Case-insensitive:

```bash
grep -i "error" application.log
```

Show line numbers:

```bash
grep -n "error" application.log
```

Invert match:

```bash
grep -v "INFO" application.log
```

---

# 31. Recursive `grep`

Search directories:

```bash
grep -R "password" /etc
```

More safely suppress permission errors:

```bash
grep -R "password" /etc 2>/dev/null
```

Case-insensitive:

```bash
grep -Ri "password" /etc 2>/dev/null
```

Security note:

Do not assume every occurrence of a word like `password` represents a real credential.

It could be documentation or configuration.

---

# 32. `grep -E`

Extended regular expressions:

```bash
grep -E "ERROR|WARNING" application.log
```

This searches for either:

```text
ERROR
```

or:

```text
WARNING
```

---

# 33. Practical Log Investigation

Create:

```bash
cat > auth-demo.log <<'EOF'
Accepted password for alice
Failed password for admin
Failed password for root
Accepted publickey for alice
Failed password for test
Failed password for admin
EOF
```

Search failures:

```bash
grep "Failed" auth-demo.log
```

Count:

```bash
grep -c "Failed" auth-demo.log
```

Expected:

```text
4
```

---

# 34. `wc`

Count lines:

```bash
wc -l auth-demo.log
```

Count words:

```bash
wc -w auth-demo.log
```

Count bytes:

```bash
wc -c auth-demo.log
```

Most common security use:

```bash
wc -l
```

---

# 35. Combining `grep` and `wc`

Count failed authentication events:

```bash
grep -c "Failed password" auth-demo.log
```

Alternative:

```bash
grep "Failed password" auth-demo.log | wc -l
```

The second demonstrates the Linux pipeline model.

---

# 36. `sort`

Sort lines:

```bash
sort users.txt
```

Reverse:

```bash
sort -r users.txt
```

Numeric:

```bash
sort -n numbers.txt
```

Human-readable sizes:

```bash
sort -h sizes.txt
```

---

# 37. `uniq`

Remove adjacent duplicate lines:

```bash
sort users.txt | uniq
```

Count duplicates:

```bash
sort users.txt | uniq -c
```

This pattern is very useful:

```bash
sort file | uniq -c
```

---

# 38. Practical Security Example — Repeated IPs

Suppose:

```text
192.168.1.10
10.0.0.5
192.168.1.10
192.168.1.20
10.0.0.5
10.0.0.5
```

Run:

```bash
sort ips.txt | uniq -c | sort -nr
```

Possible result:

```text
3 10.0.0.5
2 192.168.1.10
1 192.168.1.20
```

This identifies repeated values.

---

# 39. `cut`

Extract fields.

Example:

```bash
cut -d: -f1 /etc/passwd
```

Breakdown:

```text
-d:
 |
 +-- delimiter is :

-f1
 |
 +-- select field 1
```

Output:

```text
root
daemon
bin
sys
sync
...
```

This is a common way to extract usernames.

---

# 40. Extract Usernames

```bash
cut -d: -f1 /etc/passwd
```

Count them:

```bash
cut -d: -f1 /etc/passwd | wc -l
```

Sort:

```bash
cut -d: -f1 /etc/passwd | sort
```

---

# 41. `awk`

`awk` is a powerful text-processing language.

Example:

```bash
awk -F: '{print $1}' /etc/passwd
```

Meaning:

```text
-F:
 |
 +-- field separator = :

$1
 |
 +-- first field

print
 |
 +-- display field
```

---

# 42. Extract UID

```bash
awk -F: '{print $1, $3}' /etc/passwd
```

Output conceptually:

```text
root 0
daemon 1
bin 2
user 1000
```

---

# 43. Find Users With UID 0

```bash
awk -F: '$3 == 0 {print $1}' /etc/passwd
```

This checks:

```text
field 3 == 0
```

UID 0 is associated with root-level identity.

This is an important security check.

---

# 44. Find Interactive Login Shells

Example:

```bash
awk -F: '$7 ~ /(bash|zsh|fish)$/ {print $1, $7}' /etc/passwd
```

This can help identify accounts configured with interactive shells.

It is not a complete account-security assessment.

---

# 45. `sed`

`sed` is a stream editor.

Example:

```bash
sed 's/ERROR/ALERT/g' application.log
```

This replaces:

```text
ERROR
```

with:

```text
ALERT
```

in the output.

Important:

This command does not modify the original file unless you explicitly use an in-place option.

---

# 46. `tr`

Translate or delete characters.

Example:

```bash
echo "HELLO" | tr 'A-Z' 'a-z'
```

Output:

```text
hello
```

Very useful with `/proc`.

Example:

```bash
cat /proc/$$/cmdline | tr '\0' ' '
```

This converts NUL separators into spaces.

---

# 47. `tee`

`tee` sends output both to the terminal and a file.

Example:

```bash
echo "System check" | tee report.txt
```

You see:

```text
System check
```

and it is also written to:

```text
report.txt
```

Append:

```bash
echo "Next check" | tee -a report.txt
```

---

# 48. Why `tee` Is Useful

Suppose you are collecting system information:

```bash
uname -a | tee system-report.txt
```

You can see the result immediately while saving it.

More commands:

```bash
{
    hostname
    uptime
    whoami
    uname -a
} | tee system-report.txt
```

---

# 49. `xargs`

`xargs` converts input into command arguments.

Example:

```bash
printf "a\nb\nc\n" | xargs echo
```

Output:

```text
a b c
```

Example with files:

```bash
find . -name "*.log" -print0 | xargs -0 ls -l
```

The `-print0` + `-0` combination safely handles filenames containing spaces and special characters.

---

# 50. Why `xargs` Matters in Security

You may collect a list of suspicious files:

```bash
find /tmp -type f -name "*.sh"
```

Then process them.

However, never blindly pipe untrusted filenames into destructive commands.

Avoid patterns like:

```bash
find / -type f | xargs rm
```

without understanding the consequences.

---

# 51. `strings`

Extract printable strings from binary files:

```bash
strings suspicious.bin
```

Useful for malware triage.

You may discover strings such as:

```text
http://example.com
User-Agent
config
password
command
```

Finding a string does not prove malicious behavior.

It provides investigative clues.

---

# 52. `diff`

Compare files:

```bash
diff config.old config.new
```

Useful for configuration auditing.

Example:

```bash
diff /tmp/before.conf /tmp/after.conf
```

You can identify what changed.

---

# 53. `cmp`

Compare files byte-by-byte:

```bash
cmp file1 file2
```

If they are identical, it may produce no output.

---

# 54. `tar`

Create an archive:

```bash
tar -cf logs.tar /var/log
```

Extract:

```bash
tar -xf logs.tar
```

List:

```bash
tar -tf logs.tar
```

Create gzip-compressed archive:

```bash
tar -czf logs.tar.gz /var/log
```

Extract:

```bash
tar -xzf logs.tar.gz
```

---

# 55. Why `tar` Matters in Security

During authorized incident response, analysts may package evidence or logs.

Example:

```bash
tar -czf investigation-logs.tar.gz /var/log
```

Be careful:

- preserve timestamps where appropriate
- record hashes
- don't modify evidence unnecessarily
- follow organizational forensic procedures

---

# 56. `gzip`

Compress:

```bash
gzip file.txt
```

This usually creates:

```text
file.txt.gz
```

Decompress:

```bash
gunzip file.txt.gz
```

---

# 57. `curl`

`curl` can communicate with URLs and many network services.

Check version:

```bash
curl --version
```

Request a web page:

```bash
curl https://example.com
```

Headers only:

```bash
curl -I https://example.com
```

This is useful for legitimate:

- API testing
- troubleshooting
- service verification
- HTTP investigation

---

# 58. `curl` Security Principle

Never blindly execute downloaded content.

Dangerous pattern:

```bash
curl URL | bash
```

This downloads content and immediately executes it.

A safer investigation approach is to download first, inspect it, verify its source/hash, and only then execute if appropriate.

For example:

```bash
curl -o file.sh https://example.com/file.sh
file file.sh
sha256sum file.sh
less file.sh
```

---

# 59. `wget`

Download a file:

```bash
wget https://example.com/file.txt
```

Check:

```bash
file file.txt
```

Hash:

```bash
sha256sum file.txt
```

Again:

```text
Download
   ↓
Inspect
   ↓
Verify
   ↓
Use
```

Do not blindly execute downloaded scripts.

---

# 60. `history`

View shell history:

```bash
history
```

Search:

```bash
history | grep ssh
```

Security relevance:

Shell history can provide useful investigative context.

However, history is not a complete audit trail.

Commands can be:

- deleted
- disabled
- executed through other mechanisms
- absent from history

Never treat shell history as definitive evidence by itself.

---

# 61. `history` Practical Investigation

Search for privilege escalation commands:

```bash
history | grep sudo
```

Search for SSH:

```bash
history | grep ssh
```

Search for downloads:

```bash
history | grep -E "curl|wget"
```

This is useful for your own system or authorized investigations.

---

# 62. `id`

Display user identity and groups:

```bash
id
```

Example:

```text
uid=1000(user) gid=1000(user) groups=1000(user),27(sudo)
```

This tells you:

```text
UID
GID
Group memberships
```

---

# 63. `whoami`

```bash
whoami
```

Returns:

```text
user
```

Useful when privilege changes occur.

Example:

```bash
sudo whoami
```

Usually returns:

```text
root
```

---

# 64. `who`

Show logged-in users:

```bash
who
```

---

# 65. `w`

More detailed login/session information:

```bash
w
```

It can show:

```text
user
terminal
login time
idle time
current command
```

---

# 66. `last`

View login history:

```bash
last
```

This is useful for investigating account activity.

Example:

```bash
last -n 20
```

shows recent entries.

---

# 67. `ps`

List processes:

```bash
ps
```

More comprehensive:

```bash
ps aux
```

Alternative process hierarchy:

```bash
ps -ef
```

---

# 68. Understanding `ps aux`

Typical fields:

```text
USER
PID
%CPU
%MEM
VSZ
RSS
TTY
STAT
START
TIME
COMMAND
```

This allows you to investigate:

```text
Who owns process?
What PID?
How much CPU?
How much memory?
What command?
```

---

# 69. `pgrep`

Find process IDs by name:

```bash
pgrep ssh
```

Show command:

```bash
pgrep -a ssh
```

Example:

```text
1234 sshd: user
```

---

# 70. `pkill`

Send a signal to processes matching a name:

```bash
pkill process-name
```

Be careful.

It can terminate multiple processes.

Prefer identifying the exact PID before taking action during an investigation.

---

# 71. `kill`

Send signal:

```bash
kill PID
```

Force termination:

```bash
kill -9 PID
```

Better general principle:

```text
Investigate
   ↓
Confirm
   ↓
Choose appropriate signal
   ↓
Terminate only if authorized
```

---

# 72. `top`

Live process monitoring:

```bash
top
```

Useful for:

- CPU spikes
- memory usage
- suspicious processes
- system load

Exit:

```text
q
```

---

# 73. `free`

Memory usage:

```bash
free -h
```

Important fields:

```text
total
used
free
available
swap
```

---

# 74. `df`

Filesystem usage:

```bash
df -h
```

Find full filesystems.

---

# 75. `du`

Directory usage:

```bash
du -sh /var/log
```

Find largest directories:

```bash
du -sh /var/* 2>/dev/null | sort -h
```

---

# 76. `uname`

Kernel information:

```bash
uname -r
```

Full information:

```bash
uname -a
```

---

# 77. `hostname`

```bash
hostname
```

Show hostname.

Set hostname requires appropriate privileges and system-specific configuration, so during learning prefer reading it rather than changing system identity unnecessarily.

---

# 78. `date`

Current system date/time:

```bash
date
```

Useful for:

- log analysis
- timeline construction
- troubleshooting
- incident investigation

---

# 79. `uptime`

```bash
uptime
```

Shows:

- current time
- system uptime
- logged-in users
- load averages

---

# 80. `env`

Display environment variables:

```bash
env
```

Specific variable:

```bash
echo "$PATH"
```

Security relevance:

Environment variables may contain configuration or secrets.

Do not expose environment output publicly without reviewing it.

---

# 81. `export`

Set an environment variable:

```bash
export LAB_MODE=true
```

Check:

```bash
echo "$LAB_MODE"
```

Environment variables are heavily used in applications and automation.

---

# 82. `which` vs `command -v`

Find executable:

```bash
which python
```

Preferred shell-aware method:

```bash
command -v python
```

`command -v` can handle shell built-ins and aliases more appropriately than `which`.

---

# 83. `type`

Check what a command actually is:

```bash
type cd
```

You may get:

```text
cd is a shell builtin
```

Try:

```bash
type ls
```

This helps understand whether something is:

- alias
- builtin
- function
- executable

---

# 84. `alias`

View aliases:

```bash
alias
```

Example:

```bash
alias ll='ls -lah'
```

Then:

```bash
ll
```

Security relevance:

Aliases can change command behavior.

For example, before running a command during investigation, knowing whether it is aliased can matter.

---

# 85. Redirection — First Principle

Linux has three standard streams:

```text
0 -> stdin
1 -> stdout
2 -> stderr
```

---

# 86. `>`

Redirect stdout:

```bash
ls > files.txt
```

The terminal receives no normal output.

The output goes to:

```text
files.txt
```

---

# 87. `>>`

Append stdout:

```bash
echo "new entry" >> log.txt
```

Unlike:

```bash
>
```

it does not overwrite existing content.

---

# 88. `2>`

Redirect stderr:

```bash
find /root -type f 2> errors.txt
```

Normal output and errors are separated.

---

# 89. `2>/dev/null`

Discard errors:

```bash
find / -name "*.log" 2>/dev/null
```

This is common during system enumeration.

But be careful:

Suppressing errors can hide useful information.

---

# 90. `2>&1`

Merge stderr into stdout:

```bash
command > output.txt 2>&1
```

Meaning:

```text
stdout ──┐
         ├──> output.txt
stderr ──┘
```

---

# 91. Pipes

Example:

```bash
cat /etc/passwd | grep bash
```

But often you can avoid unnecessary `cat`:

```bash
grep bash /etc/passwd
```

This is known as:

```text
Useless Use of Cat
```

The first command is not wrong, but the second is simpler.

---

# 92. Security Pipeline Example

Find usernames with interactive Bash shells:

```bash
grep '/bin/bash' /etc/passwd | cut -d: -f1
```

Flow:

```text
/etc/passwd
     |
     v
grep /bin/bash
     |
     v
cut -d: -f1
     |
     v
usernames
```

---

# 93. More Advanced Pipeline

Count shell users:

```bash
grep '/bin/bash' /etc/passwd | cut -d: -f1 | wc -l
```

Pipeline:

```text
grep
 ↓
cut
 ↓
wc
```

This is exactly the kind of command composition you should become comfortable with.

---

# 94. Pipeline for Failed Logins

Example:

```bash
grep "Failed password" /var/log/auth.log | awk '{print $1,$2,$3,$11}' 
```

The exact field containing the source IP depends on the log format.

Therefore, always inspect sample lines first:

```bash
grep "Failed password" /var/log/auth.log | head
```

Then determine the correct field positions.

Do not blindly assume `$11` on every distribution/log format.

---

# 95. Extract and Count Values

If the source IP is field 11 for your log format:

```bash
grep "Failed password" /var/log/auth.log \
| awk '{print $11}' \
| sort \
| uniq -c \
| sort -nr
```

Conceptually:

```text
Authentication logs
       ↓
Failed attempts
       ↓
Extract IP
       ↓
Sort
       ↓
Count duplicates
       ↓
Sort highest first
```

This is a basic log-analysis workflow.

---

# 96. Practical Lab — Build Authentication Data

Create:

```bash
mkdir -p ~/linux-lab/commands/security
cd ~/linux-lab/commands/security
```

Create:

```bash
cat > auth.log <<'EOF'
Failed password from 10.0.0.10
Failed password from 10.0.0.10
Failed password from 10.0.0.20
Failed password from 10.0.0.10
Failed password from 10.0.0.30
Accepted password from 10.0.0.20
Failed password from 10.0.0.20
EOF
```

---

# 97. Extract Failed Attempts

```bash
grep "Failed password" auth.log
```

---

# 98. Extract IP Addresses

Because our lab format has the IP as the last field:

```bash
awk '{print $NF}' auth.log
```

`$NF` means:

```text
Last field
```

But first filter:

```bash
grep "Failed password" auth.log | awk '{print $NF}'
```

---

# 99. Count IPs

```bash
grep "Failed password" auth.log \
| awk '{print $NF}' \
| sort \
| uniq -c \
| sort -nr
```

Expected:

```text
3 10.0.0.10
2 10.0.0.20
1 10.0.0.30
```

This is a simple example of identifying repeated authentication sources.

---

# 100. `tee` Investigation Report

Run:

```bash
{
    echo "===== HOST ====="
    hostname

    echo "===== USER ====="
    whoami

    echo "===== ID ====="
    id

    echo "===== KERNEL ====="
    uname -a

    echo "===== UPTIME ====="
    uptime

    echo "===== MEMORY ====="
    free -h

    echo "===== DISK ====="
    df -h
} | tee system-report.txt
```

Now:

```bash
less system-report.txt
```

You created a basic system report.

---

# 101. Command Substitution

Linux allows the output of a command to become input to another command.

Example:

```bash
echo "Current user: $(whoami)"
```

Output:

```text
Current user: user
```

Another:

```bash
echo "Hostname: $(hostname)"
```

This is heavily used in Bash scripts.

---

# 102. Variables

Create:

```bash
USER_NAME="analyst"
```

Print:

```bash
echo "$USER_NAME"
```

Use:

```bash
echo "Current analyst: $USER_NAME"
```

Best practice:

```bash
"$VARIABLE"
```

Quoting variables helps prevent unwanted word splitting and glob expansion.

---

# 103. Exit Status

Every command returns an exit status.

Run:

```bash
true
echo $?
```

Usually:

```text
0
```

Successful commands conventionally return:

```text
0
```

Failure is usually non-zero.

Try:

```bash
ls /does-not-exist
echo $?
```

You should get a non-zero value.

---

# 104. Why Exit Codes Matter

Scripts can make decisions based on success/failure.

Example:

```bash
if command; then
    echo "Success"
else
    echo "Failure"
fi
```

This becomes essential in Bash automation.

---

# 105. `&&`

Run the second command only if the first succeeds:

```bash
mkdir test && cd test
```

Flow:

```text
mkdir
 |
 +-- success --> cd
 |
 +-- failure --> stop
```

---

# 106. `||`

Run the second command if the first fails:

```bash
cd /does-not-exist || echo "Directory not found"
```

---

# 107. Combining `&&` and `||`

Example:

```bash
mkdir test && echo "Created" || echo "Failed"
```

Be careful with complex logic.

For important scripts, explicit `if` statements are often clearer.

---

# 108. Command Chaining

Example:

```bash
mkdir -p ~/linux-lab/test && \
cd ~/linux-lab/test && \
touch file.txt && \
echo "Lab created"
```

This executes sequentially only when previous commands succeed.

---

# 109. Wildcards

`*` matches multiple characters.

Example:

```bash
ls *.log
```

Matches:

```text
app.log
auth.log
system.log
```

`?` matches one character:

```bash
ls file?.txt
```

---

# 110. Important Security Warning About Wildcards

Be careful with commands like:

```bash
rm *.log
```

Understand what expands before executing destructive commands.

Check first:

```bash
printf '%s\n' *.log
```

Then decide whether the target set is correct.

---

# 111. Quoting

Without quotes:

```bash
cat My File.txt
```

the shell interprets this as multiple arguments.

Correct:

```bash
cat "My File.txt"
```

or:

```bash
cat My\ File.txt
```

---

# 112. Why Quoting Matters in Security

User-controlled filenames can contain:

- spaces
- quotes
- wildcard characters
- command-like strings

Robust scripts should quote variables:

```bash
rm -- "$file"
```

The `--` tells many commands that subsequent arguments should be treated as operands rather than options.

Still, destructive commands should be carefully validated.

---

# 113. Practical File Investigation Script

Create:

```bash
nano investigate.sh
```

Use:

```bash
#!/bin/bash

TARGET="$1"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

if [ ! -e "$TARGET" ]; then
    echo "File not found: $TARGET"
    exit 1
fi

echo "===== FILE ====="
echo "$TARGET"

echo
echo "===== TYPE ====="
file "$TARGET"

echo
echo "===== STAT ====="
stat "$TARGET"

echo
echo "===== HASH ====="
sha256sum "$TARGET"

echo
echo "===== STRINGS ====="
strings "$TARGET" | head -20
```

Run:

```bash
chmod +x investigate.sh
./investigate.sh /bin/ls
```

---

# 114. What This Script Demonstrates

The script combines:

```text
Arguments
Variables
Conditions
file
stat
sha256sum
strings
head
```

This is how simple Linux commands become useful security automation.

---

# 115. Practical Lab — System Recon Command Chain

Run:

```bash
{
    echo "===== IDENTITY ====="
    whoami
    id

    echo
    echo "===== HOST ====="
    hostname

    echo
    echo "===== OS ====="
    cat /etc/os-release

    echo
    echo "===== KERNEL ====="
    uname -a

    echo
    echo "===== UPTIME ====="
    uptime

    echo
    echo "===== PROCESSES ====="
    ps aux | head -20

    echo
    echo "===== DISK ====="
    df -h

    echo
    echo "===== MEMORY ====="
    free -h
} | tee recon.txt
```

Review:

```bash
less recon.txt
```

---

# 116. Practical Lab — Find Suspicious Temporary Files

Run:

```bash
echo "===== Recent files ====="

find /tmp -type f -mmin -60 -ls 2>/dev/null
```

Then:

```bash
echo "===== Executables ====="

find /tmp -type f -executable -ls 2>/dev/null
```

Then:

```bash
echo "===== Symbolic links ====="

find /tmp -type l -ls 2>/dev/null
```

You are building a basic triage workflow.

---

# 117. Practical Lab — Search Configuration

Search `/etc` for SSH:

```bash
grep -Rni "ssh" /etc 2>/dev/null | head -50
```

Search for suspicious keywords:

```bash
grep -RniE "password|secret|token|apikey" /etc 2>/dev/null | head -50
```

Important:

This is only a search.

A match does NOT mean a secret or attack exists.

---

# 118. Practical Lab — Find User Information

List usernames:

```bash
cut -d: -f1 /etc/passwd
```

UIDs:

```bash
awk -F: '{print $1,$3}' /etc/passwd
```

UID 0:

```bash
awk -F: '$3 == 0 {print $1}' /etc/passwd
```

Interactive shells:

```bash
awk -F: '$7 ~ /(bash|zsh|fish)$/ {print $1,$7}' /etc/passwd
```

---

# 119. Practical Lab — Process Triage

List processes:

```bash
ps aux
```

Sort by CPU:

```bash
ps aux --sort=-%cpu | head
```

Sort by memory:

```bash
ps aux --sort=-%mem | head
```

Find SSH:

```bash
pgrep -a ssh
```

Find Bash:

```bash
pgrep -a bash
```

---

# 120. Practical Lab — Find Open Files

If available:

```bash
lsof
```

Find files opened by a process:

```bash
lsof -p PID
```

Find which process has a file open:

```bash
lsof /path/to/file
```

This can be extremely useful during incident response.

If `lsof` is not installed, install it through your distribution's package manager in your lab.

---

# 121. Practical Lab — Network Commands Preview

These commands will be covered in detail later, but know them:

```bash
ip addr
ip route
ss -tulpen
```

They can help identify:

```text
Interfaces
IP addresses
Routes
Listening sockets
Network processes
```

Do not memorize them deeply yet.

---

# 122. Build a Basic Security Triage Script

Create:

```bash
nano triage.sh
```

Add:

```bash
#!/bin/bash

OUT="triage-$(date +%Y%m%d-%H%M%S).txt"

{
    echo "===== LINUX SECURITY TRIAGE ====="
    echo "Date: $(date)"

    echo
    echo "===== USER ====="
    whoami
    id

    echo
    echo "===== HOST ====="
    hostname

    echo
    echo "===== OS ====="
    cat /etc/os-release

    echo
    echo "===== KERNEL ====="
    uname -a

    echo
    echo "===== UPTIME ====="
    uptime

    echo
    echo "===== LOGGED USERS ====="
    who

    echo
    echo "===== PROCESSES ====="
    ps aux --sort=-%cpu | head -20

    echo
    echo "===== MEMORY ====="
    free -h

    echo
    echo "===== DISK ====="
    df -h

    echo
    echo "===== RECENT TMP FILES ====="
    find /tmp -type f -mmin -60 -ls 2>/dev/null

} | tee "$OUT"

echo
echo "Report saved to: $OUT"
```

Make executable:

```bash
chmod +x triage.sh
```

Run:

```bash
./triage.sh
```

---

# 123. Understanding the Triage Script

This:

```bash
OUT="triage-$(date +%Y%m%d-%H%M%S).txt"
```

creates a filename such as:

```text
triage-20261008-091500.txt
```

The command:

```bash
date +%Y%m%d-%H%M%S
```

generates a timestamp.

---

# 124. Why Timestamp Reports?

Security investigations require timelines.

Instead of:

```text
report.txt
```

you can create:

```text
triage-20261008-091500.txt
```

This helps distinguish multiple collection runs.

---

# 125. Command Safety Rules

Before executing a command, ask:

```text
1. What does it do?
2. What files does it touch?
3. Does it modify anything?
4. Does it require root?
5. Can it delete data?
6. Can it terminate processes?
7. Can it send network traffic?
8. Am I authorized to run it?
```

Especially for:

```bash
rm
kill
chmod
chown
mount
umount
systemctl
iptables
curl
wget
```

---

# 126. Read-Only First Principle

During investigation:

```text
Observe first
    ↓
Collect evidence
    ↓
Analyze
    ↓
Decide
    ↓
Act
```

Do not immediately:

```text
Delete
Kill
Modify
Disable
Reconfigure
```

unless the incident-response procedure authorizes it.

---

# 127. Commands You Should Memorize

## Navigation

```bash
pwd
ls
cd
```

## File operations

```bash
touch
cp
mv
rm
mkdir
```

## Reading

```bash
cat
less
head
tail
```

## Search

```bash
find
grep
```

## Text processing

```bash
cut
awk
sed
tr
sort
uniq
wc
```

## System

```bash
uname
hostname
uptime
date
free
df
du
```

## Users

```bash
whoami
id
who
w
last
```

## Processes

```bash
ps
pgrep
top
kill
```

## Investigation

```bash
file
stat
sha256sum
strings
lsof
```

## Archives

```bash
tar
gzip
```

## Networking preview

```bash
ip
ss
curl
wget
```

---

# 128. The Most Important Linux Pattern

Learn this pattern:

```bash
COMMAND | grep PATTERN
```

Then:

```bash
COMMAND | grep PATTERN | awk '{print $FIELD}'
```

Then:

```bash
COMMAND | grep PATTERN | awk '{print $FIELD}' | sort | uniq -c | sort -nr
```

This is the foundation of practical Linux log analysis.

---

# 129. Security Analyst Mental Model

When looking at a command:

```bash
ps aux | grep ssh
```

Don't memorize it as a magic command.

Understand:

```text
ps aux
  |
  +-- collect process information
          |
          v
       pipe
          |
          v
      grep ssh
          |
          +-- filter results
```

When looking at:

```bash
grep "Failed password" auth.log | awk '{print $NF}' | sort | uniq -c | sort -nr
```

Understand:

```text
Log
 ↓
Filter authentication failures
 ↓
Extract relevant field
 ↓
Sort
 ↓
Count duplicates
 ↓
Rank highest first
```

That is the skill you want.

---

# 130. Mini Challenge 1

Create:

```bash
mkdir -p ~/linux-lab/challenges/commands
cd ~/linux-lab/challenges/commands
```

Create:

```bash
cat > access.log <<'EOF'
10.0.0.1 GET /index.html
10.0.0.2 GET /login
10.0.0.1 POST /login
10.0.0.3 GET /admin
10.0.0.1 GET /admin
10.0.0.2 POST /login
10.0.0.1 GET /index.html
10.0.0.3 GET /admin
EOF
```

Tasks:

```text
1. Show all requests from 10.0.0.1
2. Count requests from each IP
3. Show requests to /admin
4. Count POST requests
5. Sort IP addresses by request count
```

---

# 131. Mini Challenge 2

Create:

```bash
cat > system.log <<'EOF'
INFO system started
INFO user login
WARNING memory high
ERROR database unavailable
INFO user logout
ERROR authentication failed
WARNING disk usage high
ERROR database unavailable
INFO service restarted
EOF
```

Tasks:

```text
1. Show ERROR lines
2. Show WARNING lines
3. Count ERROR lines
4. Count WARNING lines
5. Count unique messages
6. Save ERROR lines to errors.txt
```

---

# 132. Mini Challenge 3

Investigate your own system.

Answer using commands:

```text
1. What is my username?
2. What is my UID?
3. What groups am I in?
4. What is my hostname?
5. What Linux distribution am I using?
6. What kernel is running?
7. How long has the system been running?
8. What process consumes the most CPU?
9. What process consumes the most memory?
10. How much disk space is available?
```

---

# 133. Mini Challenge 4 — Security Investigation

Without modifying anything:

```text
1. Find SUID binaries.
2. Find recently modified files in /tmp.
3. Find executable files in /tmp.
4. Find UID 0 accounts.
5. Find interactive-shell accounts.
6. Inspect current login sessions.
7. Inspect recent login history.
8. Inspect running SSH processes.
9. Identify listening network sockets.
10. Create a timestamped report.
```

---

# 134. What You Should Understand Now

You should not simply know commands.

You should understand the data flow:

```text
Command
   ↓
Output
   ↓
Pipe
   ↓
Filter
   ↓
Transform
   ↓
Sort
   ↓
Count
   ↓
Report
```

This is one of the most valuable Linux skills for cybersecurity.

---

# 135. Example Real-World Workflow

Suppose your SOC team receives:

> "Linux server may be experiencing repeated SSH authentication attacks."

A basic investigation might start with:

```bash
hostname
date
who
last -n 20
```

Then inspect processes:

```bash
ps aux | grep ssh
```

Then inspect authentication logs:

```bash
grep -i "failed password" /var/log/auth.log
```

Then count sources according to the actual log format:

```bash
grep -i "failed password" /var/log/auth.log \
| awk '{print $NF}' \
| sort \
| uniq -c \
| sort -nr
```

But first verify the log format:

```bash
grep -i "failed password" /var/log/auth.log | head
```

This is important because **you should understand your input before writing field-extraction logic**.

---

# 136. The Core Skill

Don't become someone who memorizes:

```bash
grep | awk | sort | uniq
```

Become someone who can look at a problem and think:

```text
What data do I need?
        ↓
Where is it?
        ↓
How can I collect it?
        ↓
What field matters?
        ↓
How do I filter it?
        ↓
How do I aggregate it?
        ↓
What does the result mean?
```

That is practical Linux administration and security analysis.

---

# 137. Final Command Cheat Sheet

```bash
# Navigation
pwd
ls -lah
cd
cd ..
cd ~

# Files
touch
cat
less
head
tail
cp
mv
rm
mkdir

# Search
find
grep

# Text
cut
awk
sed
tr
sort
uniq
wc
xargs
tee

# File analysis
file
stat
strings
sha256sum
md5sum
diff
cmp

# Archives
tar
gzip
gunzip

# System
uname
hostname
date
uptime
free
df
du

# Users
whoami
id
who
w
last

# Processes
ps
pgrep
top
kill

# Environment
env
export
echo
type
which
command -v

# Networking
ip
ss
curl
wget
```

---

# 138. Next File

The next file is:

`04-Users-Groups-Permissions.md`

It will go deeply into:

```text
Users
Groups
UID
GID
root
sudo
/etc/passwd
/etc/shadow
/etc/group
/etc/sudoers

File permissions
r
w
x

chmod
chown
chgrp
umask

SUID
SGID
Sticky Bit

ACLs
getfacl
setfacl

Privilege escalation concepts
Permission auditing
World-writable files
Weak permissions
Practical security scenarios
```

The focus will be **understanding why Linux permissions exist, how the kernel evaluates them, how to audit them, and how misconfigurations become security risks**.
```