# `04-Users-Groups-Permissions.md`

```md
# Linux Users, Groups & Permissions

> Goal: Understand how Linux controls who can access files, directories, and privileged operations.

---

# 1. First Principle

Linux security starts with:

```text
WHO are you?
      ↓
WHAT groups are you in?
      ↓
WHAT permissions do you have?
      ↓
WHAT resources can you access?
```

The basic security model is:

```text
User
 ├── UID
 ├── Primary Group
 └── Supplementary Groups
        ↓
Permissions
        ↓
Access
```

This is the foundation of Linux authorization.

---

# 2. Users

Every Linux process normally runs with a user identity.

Check your identity:

```bash
whoami
```

Detailed information:

```bash
id
```

Example:

```text
uid=1000(user) gid=1000(user) groups=1000(user),27(sudo)
```

Meaning:

```text
uid=1000       → user ID
gid=1000       → primary group
groups=...     → groups the user belongs to
```

---

# 3. UID

UID = User ID.

Linux internally uses numeric IDs rather than usernames.

Example:

```text
root → UID 0
user → UID 1000
```

Important:

```text
UID 0 = root-level identity
```

Find UID information:

```bash
id
```

or:

```bash
cat /etc/passwd
```

---

# 4. `/etc/passwd`

View user accounts:

```bash
cat /etc/passwd
```

Example:

```text
user:x:1000:1000:User:/home/user:/bin/bash
```

Structure:

```text
username : password-field : UID : GID : description : home : shell
```

Example:

```text
user
 ↓
UID 1000
 ↓
GID 1000
 ↓
/home/user
 ↓
/bin/bash
```

---

# 5. Groups

Groups allow multiple users to share permissions.

Example:

```text
Developers
 ├── Alice
 ├── Bob
 └── Charlie
```

Instead of granting permissions individually, you can grant them to the group.

Check groups:

```bash
groups
```

or:

```bash
id
```

---

# 6. `/etc/group`

View groups:

```bash
cat /etc/group
```

Example:

```text
developers:x:1001:alice,bob
```

Meaning:

```text
developers → group name
1001       → GID
alice,bob  → members
```

---

# 7. Root

`root` is the privileged Linux user.

```text
root
UID = 0
```

Root can generally bypass many normal permission restrictions.

Check:

```bash
whoami
```

Try:

```bash
sudo whoami
```

Expected:

```text
root
```

---

# 8. Why Root Is Dangerous

Normal user:

```text
Limited permissions
      ↓
Limited damage
```

Root:

```text
Extensive permissions
      ↓
Potentially complete system control
```

Therefore:

> Use the least privilege necessary.

This principle is called **Least Privilege**.

---

# 9. `sudo`

`sudo` allows an authorized user to execute a command with elevated privileges.

Example:

```bash
sudo systemctl status ssh
```

Instead of permanently becoming root, you elevate only for the required command.

Good practice:

```bash
sudo command
```

instead of:

```bash
sudo -i
```

unless you actually need an administrative shell.

---

# 10. `/etc/sudoers`

Sudo authorization is controlled through sudo configuration.

View safely:

```bash
sudo visudo
```

Do not casually edit `/etc/sudoers` with a normal text editor.

`visudo` validates syntax before saving.

---

# 11. File Ownership

Every file normally has:

```text
Owner
Group
Permissions
```

Example:

```bash
ls -l file.txt
```

Output:

```text
-rw-r--r-- 1 user developers 120 Oct 8 file.txt
```

Important portion:

```text
Owner  → user
Group  → developers
```

---

# 12. Permissions

Linux commonly represents permissions as:

```text
r = read
w = write
x = execute
```

There are three permission categories:

```text
Owner
Group
Others
```

Example:

```text
-rwxr-xr--
```

Break it down:

```text
Owner   Group   Others
rwx     r-x     r--
```

Meaning:

```text
Owner  → read + write + execute
Group  → read + execute
Others → read only
```

---

# 13. Reading `ls -l`

Run:

```bash
ls -l file.txt
```

Example:

```text
-rw-r--r-- 1 user user 100 file.txt
```

First character:

```text
- → regular file
d → directory
l → symbolic link
```

Then:

```text
rw- r-- r--
```

means:

```text
Owner  → rw-
Group  → r--
Others → r--
```

---

# 14. Directory Permissions

Directory permissions behave differently.

For a directory:

```text
r → list contents
w → create/delete entries
x → enter/traverse directory
```

The `x` permission is particularly important.

Example:

```bash
ls -ld /home/user
```

---

# 15. Numeric Permissions

Linux also represents permissions numerically.

Values:

```text
r = 4
w = 2
x = 1
```

Therefore:

```text
rwx = 4 + 2 + 1 = 7
rw- = 4 + 2     = 6
r-x = 4 +     1 = 5
r-- = 4         = 4
```

Example:

```text
755
```

means:

```text
Owner  → 7 = rwx
Group  → 5 = r-x
Others → 5 = r-x
```

---

# 16. `chmod`

`chmod` changes permissions.

Example:

```bash
chmod 644 file.txt
```

Result:

```text
Owner  → rw-
Group  → r--
Others → r--
```

For a script:

```bash
chmod 755 script.sh
```

Result:

```text
Owner  → rwx
Group  → r-x
Others → r-x
```

---

# 17. Symbolic `chmod`

Instead of numbers:

```bash
chmod u+x script.sh
```

Meaning:

```text
u → user/owner
+ → add
x → execute
```

Group:

```bash
chmod g+w file.txt
```

Others:

```bash
chmod o-r file.txt
```

---

# 18. `chown`

Change ownership:

```bash
sudo chown alice file.txt
```

Change owner and group:

```bash
sudo chown alice:developers file.txt
```

Verify:

```bash
ls -l file.txt
```

---

# 19. `chgrp`

Change group ownership:

```bash
sudo chgrp developers file.txt
```

---

# 20. Practical Lab

Create:

```bash
mkdir -p ~/linux-lab/permissions
cd ~/linux-lab/permissions
```

Create:

```bash
echo "Linux security lab" > secret.txt
```

Check:

```bash
ls -l secret.txt
```

Change permissions:

```bash
chmod 600 secret.txt
```

Now:

```text
Owner  → read/write
Group  → no access
Others → no access
```

Check:

```bash
ls -l secret.txt
```

---

# 21. Why `600` Is Useful

```text
600
```

means:

```text
Owner  → rw-
Group  → ---
Others → ---
```

This is often appropriate for sensitive personal files.

Examples can include:

```text
Private configuration
Private keys
Sensitive local data
```

However, always follow the application's required permissions.

---

# 22. Dangerous Permissions

A common mistake is:

```bash
chmod 777 file
```

This means:

```text
Owner  → rwx
Group  → rwx
Others → rwx
```

Everyone can potentially read, modify, and execute the file.

Avoid using `777` as a generic solution to permission problems.

---

# 23. Security Scenario — World-Writable File

Find world-writable files:

```bash
find / -type f -perm -002 -ls 2>/dev/null
```

Why is this interesting?

```text
Any user
   ↓
Can modify file
   ↓
If privileged process executes it
   ↓
Potential security risk
```

This is why permissions matter.

---

# 24. SUID

SUID = Set User ID.

For an executable with SUID:

```text
Process may execute with file owner's effective privileges.
```

Find SUID files:

```bash
find / -type f -perm -4000 -ls 2>/dev/null
```

Example permission:

```text
-rwsr-xr-x
```

Notice:

```text
s
```

instead of the normal owner execute bit.

---

# 25. Why SUID Matters

Suppose:

```text
Executable
Owner = root
SUID enabled
        ↓
Normal user executes it
        ↓
Program may run with elevated effective privileges
```

SUID itself is not malicious.

Many legitimate Linux programs use it.

Security analysts look for:

```text
Unexpected SUID binary
Weak/custom SUID program
Old vulnerable SUID program
Incorrectly configured SUID executable
```

---

# 26. SGID

SGID is similar but relates to group privileges.

Find SGID files:

```bash
find / -type f -perm -2000 -ls 2>/dev/null
```

Directory SGID also has an important behavior:

New files created inside the directory can inherit the directory's group.

Useful for shared project directories.

---

# 27. Sticky Bit

The sticky bit is commonly used on shared directories such as:

```text
/tmp
```

Check:

```bash
ls -ld /tmp
```

You may see:

```text
drwxrwxrwt
```

The final:

```text
t
```

represents the sticky bit.

Conceptually:

```text
Shared directory
      ↓
Users can create files
      ↓
But users cannot normally delete
another user's files
```

---

# 28. ACL

ACL = Access Control List.

Traditional permissions provide:

```text
Owner
Group
Others
```

ACLs allow more specific access rules.

Check:

```bash
getfacl file.txt
```

Example concept:

```text
Owner → rw
Group → r
Alice  → rw
Bob    → r
Others → none
```

Set an ACL:

```bash
setfacl -m u:alice:rw file.txt
```

Check:

```bash
getfacl file.txt
```

---

# 29. Permission Calculation

Remember:

```text
r = 4
w = 2
x = 1
```

Examples:

```text
7 = rwx
6 = rw-
5 = r-x
4 = r--
3 = -wx
2 = -w-
1 = --x
0 = ---
```

Common permissions:

```text
644 → rw-r--r--
600 → rw-------
755 → rwxr-xr-x
700 → rwx------
```

---

# 30. Security Principle — Least Privilege

Do not give:

```text
777
```

just because an application says:

```text
Permission denied
```

Instead determine:

```text
Which user runs the application?
Which group does it need?
What file needs access?
What minimum permission is required?
```

Then grant only that permission.

---

# 31. Practical Security Audit

Check a sensitive file:

```bash
ls -l /etc/passwd
```

Check:

```bash
ls -l /etc/shadow
```

Check your identity:

```bash
id
```

Check sudo access:

```bash
sudo -l
```

`sudo -l` shows commands the current user is allowed to execute through sudo.

This is important for both administration and security auditing.

---

# 32. Privilege Escalation Concept

A simplified privilege escalation path can look like:

```text
Low-privileged user
       ↓
Find misconfiguration
       ↓
Abuse excessive permission
       ↓
Execute privileged operation
       ↓
Higher privileges
```

Examples of things defenders should audit:

```text
Weak sudo rules
SUID binaries
Writable scripts
Writable service files
Weak file permissions
Excessive group membership
```

We will study these in later security topics.

---

# 33. Practical Audit Commands

### Current identity

```bash
id
```

### Current groups

```bash
groups
```

### Sudo permissions

```bash
sudo -l
```

### File permissions

```bash
ls -l FILE
```

### Detailed metadata

```bash
stat FILE
```

### World-writable files

```bash
find / -type f -perm -002 -ls 2>/dev/null
```

### SUID files

```bash
find / -type f -perm -4000 -ls 2>/dev/null
```

### SGID files

```bash
find / -type f -perm -2000 -ls 2>/dev/null
```

---

# 34. Practical Lab — Permission Audit

Create:

```bash
mkdir -p ~/linux-lab/permissions
cd ~/linux-lab/permissions
```

Create files:

```bash
touch public.txt private.txt script.sh
```

Set:

```bash
chmod 644 public.txt
chmod 600 private.txt
chmod 755 script.sh
```

Check:

```bash
ls -l
```

You should understand why each file has different permissions.

---

# 35. Practical Lab — Ownership

Create:

```bash
echo "ownership test" > ownership.txt
```

Check:

```bash
ls -l ownership.txt
```

Find your identity:

```bash
id
```

Change group only if you have an appropriate lab group:

```bash
sudo chgrp <group> ownership.txt
```

Verify:

```bash
ls -l ownership.txt
```

Do not change ownership of system files during practice.

---

# 36. Practical Lab — SUID Discovery

Run:

```bash
find / -type f -perm -4000 -ls 2>/dev/null
```

For each result, ask:

```text
1. What program is this?
2. Is it expected?
3. Which package owns it?
4. Why does it need SUID?
5. Is it patched?
```

Do not modify or exploit the binaries on a production system.

---

# 37. Practical Lab — ACL

Create:

```bash
echo "ACL test" > acl.txt
```

Check:

```bash
getfacl acl.txt
```

If ACL tools are installed, create an ACL for a lab user:

```bash
setfacl -m u:<username>:rw acl.txt
```

Check:

```bash
getfacl acl.txt
```

You should see the additional user-specific permission.

---

# 38. Real-World Scenario

### Problem

A web application needs to read:

```text
/opt/app/config.json
```

Instead of:

```bash
chmod 777 /opt/app/config.json
```

ask:

```text
Which user runs the application?
```

Find the service:

```bash
ps aux | grep <application>
```

Then determine the required ownership/group and grant the minimum permission.

The security principle is:

```text
Application
    ↓
Required access only
    ↓
No unnecessary privileges
```

---

# 39. Common Mistakes

### Mistake 1

Using:

```bash
chmod 777
```

as a fix.

### Mistake 2

Running everything with:

```bash
sudo
```

### Mistake 3

Ignoring group memberships.

### Mistake 4

Assuming SUID automatically means malware.

### Mistake 5

Changing permissions on system files without understanding the consequences.

### Mistake 6

Giving write access when read access is sufficient.

---

# 40. Interview Questions

### What is UID?

Numeric identifier representing a Linux user.

### What is GID?

Numeric identifier representing a Linux group.

### What is root?

The UID 0 privileged identity.

### What does `chmod 755` mean?

```text
Owner  → rwx
Group  → r-x
Others → r-x
```

### What does `chmod 600` mean?

```text
Owner  → rw-
Group  → ---
Others → ---
```

### What is SUID?

A permission bit that can cause an executable to run with the file owner's effective privileges.

### What is SGID?

A permission bit associated with group privileges; on directories it also causes group inheritance for newly created files.

### What is the sticky bit?

A directory permission mechanism commonly used on shared directories so users cannot normally delete other users' files.

### What is ACL?

A mechanism providing more granular access rules beyond the basic owner/group/others model.

---

# 41. Quick Cheat Sheet

```text
WHO AM I?
id
whoami
groups

USERS
/etc/passwd
/etc/shadow

GROUPS
/etc/group

PERMISSIONS
r = 4
w = 2
x = 1

CHANGE PERMISSIONS
chmod

CHANGE OWNER
chown

CHANGE GROUP
chgrp

CHECK ACL
getfacl

SET ACL
setfacl

SUID
find / -type f -perm -4000 2>/dev/null

SGID
find / -type f -perm -2000 2>/dev/null

WORLD-WRITABLE
find / -type f -perm -002 2>/dev/null

SUDO
sudo
sudo -l
```

---

# 42. Core Mental Model

Remember:

```text
USER
  ↓
GROUPS
  ↓
FILE OWNER / GROUP
  ↓
PERMISSIONS
  ↓
ACCESS
```

And for security:

```text
Too much privilege
        ↓
More attack surface
        ↓
Potential privilege escalation
```

The goal of Linux security is therefore:

> Give users and processes exactly the privileges they need — and no more.
```

### Next

`05-Processes.md`

We’ll cover **processes, PID/PPID, foreground/background processes, signals, process states, `/proc`, `ps`, `top`, `kill`, `jobs`, `systemd processes, suspicious-process detection, and basic process investigation** in the same concise format.