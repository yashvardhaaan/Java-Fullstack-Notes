# `02-Linux-File-System.md`

```md
# Linux File System

> Goal: Understand how Linux organizes files, directories, devices, processes, configuration, logs, and runtime information — and learn how a cybersecurity analyst uses the filesystem during investigation, troubleshooting, and hardening.

---

# 1. First Principle — What Is a File System?

A file system is the structure Linux uses to organize and manage data on storage.

At the simplest level:

```text
Disk
 |
 +-- Partitions
      |
      +-- File System
             |
             +-- Directories
             |
             +-- Files
```

Linux presents the filesystem as a single hierarchy:

```text
/
```

Everything starts from `/`.

Unlike Windows, where you commonly see:

```text
C:\
D:\
E:\
```

Linux generally presents one unified tree:

```text
/
├── boot
├── dev
├── etc
├── home
├── opt
├── proc
├── root
├── run
├── sys
├── tmp
├── usr
└── var
```

---

# 2. The Most Important Mental Model

Think of Linux as:

```text
                    /
                    |
        +-----------+-----------+
        |           |           |
       etc        home         var
        |           |           |
   configuration   users       logs
```

Different directories have different purposes.

For cybersecurity, you should immediately associate:

```text
/etc      -> configuration
/var/log  -> logs
/home     -> user data
/root     -> root user's home
/tmp      -> temporary data
/proc     -> process/kernel information
/sys      -> hardware/kernel information
/dev      -> devices
/usr      -> programs/libraries
/opt      -> optional applications
/boot     -> boot files
/run      -> runtime information
```

---

# 3. Why Linux Uses This Structure

Linux separates different types of data so that:

- configuration is organized
- applications can find required files
- logs can be stored consistently
- users have separate home directories
- system components can access required resources
- administrators can control permissions
- security monitoring becomes possible

This separation is extremely important during incident response.

For example:

```text
Suspicious process
      |
      +--> /proc
      |
      +--> executable
      |
      +--> command line
      |
      +--> environment
```

Another example:

```text
Suspicious login
      |
      +--> /var/log
      |
      +--> authentication logs
      |
      +--> login history
```

---

# 4. Root Directory `/`

The root directory is:

```text
/
```

Check it:

```bash
ls /
```

You may see:

```text
bin
boot
dev
etc
home
lib
lib64
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
```

The exact structure differs between distributions.

---

# 5. Understanding `/`

Run:

```bash
pwd
```

If you see:

```text
/home/user
```

you are currently inside that directory.

Go to filesystem root:

```bash
cd /
```

Verify:

```bash
pwd
```

Output:

```text
/
```

Now:

```bash
ls -la
```

---

# 6. `/bin`

Traditionally:

```text
/bin
```

contains essential user commands.

Examples may include:

```text
ls
cp
mv
cat
rm
sh
```

On modern Linux distributions, `/bin` may be a symbolic link to:

```text
/usr/bin
```

Check:

```bash
ls -ld /bin
```

If it is a symbolic link, you may see something similar to:

```text
/bin -> usr/bin
```

---

# 7. Why Symbolic Links Matter

A symbolic link is essentially a filesystem reference to another path.

Example:

```bash
ln -s /var/log/application.log mylog
```

Now:

```bash
ls -l mylog
```

You may see:

```text
mylog -> /var/log/application.log
```

The important idea:

```text
mylog
  |
  v
actual file
```

Security relevance:

Attackers can sometimes abuse symbolic links when applications incorrectly trust file paths.

---

# 8. `/sbin`

Traditionally contains system administration commands.

Examples can include:

```text
ip
mount
fsck
shutdown
```

Modern distributions may organize these under:

```text
/usr/sbin
```

Check:

```bash
ls -ld /sbin
```

---

# 9. `/usr`

`/usr` contains a large portion of user-space software.

Typical structure:

```text
/usr
├── bin
├── sbin
├── lib
├── share
├── include
└── local
```

Inspect:

```bash
ls /usr
```

---

# 10. `/usr/bin`

Contains many normal user-space programs.

Example:

```bash
ls /usr/bin | head
```

Find a command:

```bash
which bash
```

or:

```bash
command -v bash
```

You may get:

```text
/usr/bin/bash
```

---

# 11. `/usr/sbin`

Contains many system administration programs.

Inspect:

```bash
ls /usr/sbin | head
```

---

# 12. `/usr/local`

Usually contains software installed locally by the administrator rather than the distribution package manager.

Example:

```text
/usr/local/bin
/usr/local/sbin
/usr/local/lib
```

Security relevance:

An unexpected executable under:

```text
/usr/local/bin
```

should sometimes be investigated.

It does NOT automatically mean malware.

Always establish:

```text
Who installed it?
When?
Why?
Which package?
What does it execute?
```

---

# 13. `/etc`

One of the most important directories for a Linux security analyst.

```text
/etc
```

contains system-wide configuration.

Inspect:

```bash
ls -la /etc
```

Examples:

```text
/etc/passwd
/etc/group
/etc/hosts
/etc/hostname
/etc/ssh/
/etc/systemd/
/etc/fstab
```

---

# 14. `/etc/passwd`

Inspect:

```bash
cat /etc/passwd
```

Example:

```text
root:x:0:0:root:/root:/bin/bash
user:x:1000:1000:User:/home/user:/bin/bash
```

Each line describes a user account.

The traditional format is:

```text
username:password_placeholder:UID:GID:GECOS:home:shell
```

Example:

```text
user:x:1000:1000:User:/home/user:/bin/bash
```

Breakdown:

```text
user
 |
 +-- username

x
 |
 +-- password field/reference

1000
 |
 +-- UID

1000
 |
 +-- primary GID

User
 |
 +-- account information

/home/user
 |
 +-- home directory

/bin/bash
 |
 +-- login shell
```

---

# 15. Important Security Point About `/etc/passwd`

The `x` does NOT normally mean the password itself is stored there.

Modern Linux systems generally store password hashes in:

```text
/etc/shadow
```

Access to `/etc/shadow` should be restricted.

Check:

```bash
ls -l /etc/passwd
```

Then:

```bash
ls -l /etc/shadow
```

Typical permissions for `/etc/shadow` are much more restrictive.

---

# 16. `/etc/group`

Inspect:

```bash
cat /etc/group
```

A group entry commonly looks like:

```text
sudo:x:27:user
```

Conceptually:

```text
group
 |
 +-- group name
 +-- group ID
 +-- members
```

Groups are important for authorization.

For example:

```text
user
 |
 +--> developers
 +--> docker
 +--> sudo
```

Membership in a privileged group can provide additional capabilities.

---

# 17. `/etc/hostname`

Check:

```bash
cat /etc/hostname
```

This contains the system hostname on many distributions.

You can also use:

```bash
hostname
```

---

# 18. `/etc/hosts`

Inspect:

```bash
cat /etc/hosts
```

Example:

```text
127.0.0.1 localhost
127.0.1.1 mycomputer
```

The hosts file can provide local hostname-to-IP mappings.

Security relevance:

Unexpected entries can sometimes be relevant during investigation.

For example:

```text
10.10.10.50 internal-server
```

could influence how applications resolve that hostname.

Never assume an entry is malicious without understanding the environment.

---

# 19. `/etc/ssh`

If OpenSSH is installed, you may find:

```text
/etc/ssh
```

Inspect:

```bash
ls -la /etc/ssh
```

A common configuration file is:

```text
/etc/ssh/sshd_config
```

View it:

```bash
sudo less /etc/ssh/sshd_config
```

Security settings can include:

```text
PermitRootLogin
PasswordAuthentication
PubkeyAuthentication
AllowUsers
AllowGroups
```

We will study SSH deeply in:

```text
09-SSH.md
```

---

# 20. `/etc/fstab`

The file:

```text
/etc/fstab
```

defines filesystems that can be mounted automatically.

Inspect:

```bash
cat /etc/fstab
```

This can help understand:

- disks
- partitions
- mount points
- filesystem types
- mount options

---

# 21. `/var`

`/var` contains variable data.

Examples:

```text
/var/log
/var/cache
/var/lib
/var/tmp
```

Think:

```text
/etc -> configuration
/var -> changing data
```

---

# 22. `/var/log`

This is one of the most important locations for security analysts.

```bash
ls -lah /var/log
```

Depending on the distribution, you may find:

```text
auth.log
syslog
kern.log
boot.log
```

or:

```text
secure
messages
```

Other applications may create their own log directories.

---

# 23. Investigating Logs

Search for authentication failures:

```bash
sudo grep -i "failed" /var/log/auth.log
```

On distributions using `/var/log/secure`:

```bash
sudo grep -i "failed" /var/log/secure
```

Search for SSH failures:

```bash
sudo grep -i "failed password" /var/log/auth.log
```

Search for successful logins:

```bash
sudo grep -i "accepted" /var/log/auth.log
```

These commands are useful during basic incident investigation.

---

# 24. `/var/lib`

Contains persistent application/system state.

Examples:

```text
/var/lib/dpkg
/var/lib/systemd
/var/lib/postgresql
```

Depending on installed software, many other directories may exist.

Security relevance:

An investigator may inspect `/var/lib` to understand:

- installed packages
- application state
- databases
- service state
- persistent system information

---

# 25. `/var/cache`

Contains cached data.

Example:

```bash
ls -lah /var/cache
```

Package managers may store cached package information here.

---

# 26. `/var/tmp`

Temporary files that may survive longer than files in `/tmp`.

Inspect:

```bash
ls -lah /var/tmp
```

Security investigation:

Unexpected executable files or scripts in temporary locations deserve investigation.

Do not automatically delete them.

First determine:

```text
Who created them?
When?
What process created them?
What is their purpose?
```

---

# 27. `/tmp`

Temporary storage.

Inspect:

```bash
ls -lah /tmp
```

Create a harmless test file:

```bash
echo "Linux lab" > /tmp/linux-lab.txt
```

Read:

```bash
cat /tmp/linux-lab.txt
```

Delete:

```bash
rm /tmp/linux-lab.txt
```

---

# 28. Why `/tmp` Matters to Security

Temporary directories are writable by many users.

Therefore they are commonly involved in:

- temporary application data
- installers
- scripts
- sockets
- application artifacts
- security investigations

A suspicious executable in `/tmp` should be investigated.

For example:

```bash
find /tmp -type f -executable -ls 2>/dev/null
```

This searches for executable files.

Important:

An executable file is NOT automatically malicious.

---

# 29. `/home`

Contains normal users' home directories.

Example:

```text
/home
├── alice
├── bob
└── user
```

Inspect:

```bash
ls -la /home
```

---

# 30. User Home Directory

Example:

```text
/home/user
```

Typical contents:

```text
Documents
Downloads
Pictures
Desktop
.config
.ssh
.bashrc
```

Inspect:

```bash
ls -la /home/user
```

---

# 31. Hidden Configuration Files

Files beginning with `.` are hidden from normal `ls`.

Example:

```text
.bashrc
.profile
.ssh
.config
```

Use:

```bash
ls -la
```

to see them.

---

# 32. `.bashrc`

For Bash users, `.bashrc` can contain shell configuration and commands.

Inspect your own file:

```bash
cat ~/.bashrc
```

Security relevance:

Shell startup files can potentially be abused for persistence.

For example, a malicious command inserted into a startup file could execute when the user starts a shell.

Never modify system files just to experiment.

Use a lab account or your own harmless test environment.

---

# 33. `.ssh`

A user's SSH configuration is commonly stored under:

```text
~/.ssh
```

Check:

```bash
ls -la ~/.ssh
```

Potential files include:

```text
authorized_keys
config
known_hosts
id_ed25519
id_ed25519.pub
```

Important:

Private keys must be protected.

Do not expose or upload private keys.

---

# 34. `/root`

This is the root user's home directory.

```bash
sudo ls -la /root
```

You may see:

```text
.bashrc
.profile
.ssh
```

Security relevance:

If an attacker obtains root access, `/root` may contain sensitive configuration and credentials.

---

# 35. `/boot`

Contains files required during the boot process.

Inspect:

```bash
ls -lah /boot
```

You may see:

```text
vmlinuz-...
initrd...
grub/
```

The Linux kernel image is commonly stored here.

---

# 36. Understanding the Boot Flow

Simplified:

```text
Power On
   |
   v
Firmware
   |
   v
Bootloader
   |
   v
Linux Kernel
   |
   v
Initial userspace
   |
   v
systemd
   |
   v
Services
   |
   v
Login
```

This becomes important when studying persistence and system startup.

---

# 37. `/dev`

Linux represents devices through entries under:

```text
/dev
```

Inspect:

```bash
ls -lah /dev
```

Examples:

```text
/dev/null
/dev/zero
/dev/random
/dev/sda
/dev/nvme0n1
```

---

# 38. `/dev/null`

`/dev/null` is a special device that discards data written to it.

Example:

```bash
echo "test" > /dev/null
```

Nothing is displayed.

Common usage:

```bash
command > /dev/null
```

Security scripts sometimes use:

```bash
2>/dev/null
```

to suppress error messages.

Example:

```bash
find /etc -type f 2>/dev/null
```

---

# 39. `/dev/zero`

Provides zero bytes.

Example:

```bash
head -c 10 /dev/zero | od -An -t x1
```

This generates zero-valued bytes.

---

# 40. `/dev/random` and `/dev/urandom`

These provide random data interfaces.

Check:

```bash
ls -l /dev/random /dev/urandom
```

Applications can use these interfaces for cryptographic randomness.

Do not treat random-device output as readable text.

---

# 41. `/proc`

`/proc` is a virtual filesystem.

It does not represent ordinary files stored permanently on disk.

It exposes kernel and process information.

Check:

```bash
ls /proc
```

You may see:

```text
1
2
3
...
cpuinfo
meminfo
mounts
net
sys
```

---

# 42. Process Directories in `/proc`

Numeric directories usually correspond to process IDs.

For example:

```text
/proc/1
/proc/1234
/proc/5678
```

Check PID 1:

```bash
ls -la /proc/1
```

---

# 43. `/proc/<PID>/cmdline`

Shows the command line associated with a process.

Example:

```bash
cat /proc/1/cmdline | tr '\0' ' '
```

Why `tr`?

Arguments in `/proc/<PID>/cmdline` are separated by NUL bytes.

This converts NUL characters into spaces.

---

# 44. `/proc/<PID>/exe`

This is a symbolic link to the executable.

Example:

```bash
readlink -f /proc/1/exe
```

You may get something like:

```text
/usr/lib/systemd/systemd
```

This is extremely useful during process investigation.

---

# 45. Practical Process Investigation

First identify a PID:

```bash
pgrep -a bash
```

Suppose the PID is:

```text
1500
```

Then:

```bash
readlink -f /proc/1500/exe
```

Check command line:

```bash
cat /proc/1500/cmdline | tr '\0' ' '
```

Check current working directory:

```bash
readlink -f /proc/1500/cwd
```

Check executable path:

```bash
readlink -f /proc/1500/exe
```

Check root directory of process:

```bash
readlink -f /proc/1500/root
```

---

# 46. `/proc/<PID>/fd`

Processes have file descriptors.

Inspect:

```bash
ls -la /proc/1500/fd
```

You may see links such as:

```text
0 -> /dev/pts/0
1 -> /dev/pts/0
2 -> /dev/pts/0
```

These commonly represent:

```text
0 -> stdin
1 -> stdout
2 -> stderr
```

---

# 47. Why `/proc` Is Valuable During Incident Response

Suppose you discover:

```text
suspicious-process
PID = 4321
```

You can investigate:

```bash
readlink -f /proc/4321/exe
cat /proc/4321/cmdline | tr '\0' ' '
readlink -f /proc/4321/cwd
ls -la /proc/4321/fd
```

This helps answer:

```text
What executable is running?
How was it launched?
Where is it running from?
What files does it have open?
```

---

# 48. `/sys`

`/sys` is another virtual filesystem.

It exposes information about:

- devices
- drivers
- kernel subsystems
- hardware

Inspect:

```bash
ls /sys
```

You may see:

```text
block
bus
class
devices
firmware
kernel
module
```

---

# 49. `/sys/class`

Useful for examining device classes.

Example:

```bash
ls /sys/class/net
```

This may show:

```text
eth0
lo
wlan0
```

The exact interface names vary.

This is useful when investigating networking.

---

# 50. `/sys/class/net`

Inspect network interfaces:

```bash
ls /sys/class/net
```

Get interface state:

```bash
cat /sys/class/net/lo/operstate
```

For another interface:

```bash
cat /sys/class/net/<interface>/operstate
```

Possible result:

```text
up
```

or:

```text
down
```

---

# 51. `/run`

`/run` contains runtime information.

It is generally populated during system boot.

Inspect:

```bash
ls -lah /run
```

You may find:

```text
/run/sshd
/run/systemd
/run/user
```

Runtime files can include:

- PID files
- sockets
- service state
- temporary runtime configuration

---

# 52. `/run/user`

Inspect:

```bash
ls -la /run/user
```

You may see directories associated with logged-in users.

For example:

```text
/run/user/1000
```

The number often corresponds to a UID.

---

# 53. `/opt`

`/opt` is commonly used for optional/additional software.

Example:

```text
/opt/application
```

Inspect:

```bash
ls -lah /opt
```

Security relevance:

Third-party applications may be installed here.

If you are investigating an unfamiliar application:

```bash
find /opt -maxdepth 3 -type f
```

can help inventory its files.

---

# 54. `/srv`

`/srv` is traditionally used for data served by system services.

For example:

```text
/srv/www
/srv/ftp
```

Its usage depends on the system.

---

# 55. `/mnt`

Temporary mount point commonly used by administrators.

Example:

```bash
ls -lah /mnt
```

---

# 56. `/media`

Often used for automatically mounted removable media.

Example:

```text
/media/user/USB
```

Inspect:

```bash
ls -lah /media
```

---

# 57. Filesystem vs Mount Point

A filesystem can be mounted at a directory.

Conceptually:

```text
Disk
 |
 v
Filesystem
 |
 v
Mount
 |
 v
Directory
```

For example:

```text
/dev/nvme0n1p2
        |
        v
       /
```

Another filesystem might be mounted at:

```text
/home
```

---

# 58. View Mounted Filesystems

Use:

```bash
mount
```

A more readable command:

```bash
findmnt
```

Or:

```bash
df -h
```

These commands provide different views of storage and mounts.

---

# 59. View Block Devices

Use:

```bash
lsblk
```

Example:

```text
NAME        SIZE TYPE MOUNTPOINT
nvme0n1     512G disk
├─nvme0n1p1  1G part /boot
└─nvme0n1p2 511G part /
```

Your output will differ.

---

# 60. Why `lsblk` Matters

During system investigation, you may need to understand:

```text
Which disks exist?
Which partitions exist?
Where are they mounted?
Is an external disk attached?
```

Run:

```bash
lsblk -f
```

This adds filesystem information.

---

# 61. Disk Usage

Check filesystem capacity:

```bash
df -h
```

Example:

```text
Filesystem      Size  Used Avail Use%
/dev/sda2       100G   70G   30G  70%
```

Remember:

```text
df -> filesystem capacity
du -> directory/file usage
```

---

# 62. Find Large Directories

Example:

```bash
sudo du -sh /var/* 2>/dev/null | sort -h
```

Breakdown:

```text
du
 |
 +-- calculate disk usage

-s
 |
 +-- summary

-h
 |
 +-- human-readable

/var/*
 |
 +-- examine directories

2>/dev/null
 |
 +-- hide permission errors

|
 +-- pipe output

sort -h
 |
 +-- sort human-readable sizes
```

---

# 63. Practical Scenario — Disk Full

Imagine a server reports:

```text
Disk usage: 100%
```

First:

```bash
df -h
```

Find large directories:

```bash
sudo du -xhd1 / 2>/dev/null | sort -h
```

Then investigate likely locations:

```bash
sudo du -xhd1 /var 2>/dev/null | sort -h
```

Then:

```bash
sudo du -xhd1 /var/log 2>/dev/null | sort -h
```

Possible causes:

```text
Huge logs
Application crash loops
Large temporary files
Database growth
Unexpected files
```

Do not blindly delete files.

---

# 64. Find Recently Modified Files

Example:

```bash
find /etc -type f -mtime -1 2>/dev/null
```

Meaning:

```text
find /etc
 |
 +-- search under /etc

-type f
 |
 +-- regular files

-mtime -1
 |
 +-- modified within roughly the last day
```

This can be useful during incident response.

---

# 65. Find Recently Created/Modified Files in `/tmp`

```bash
find /tmp -type f -mmin -60 2>/dev/null
```

This looks for files modified within approximately the last 60 minutes.

Potential investigation question:

```text
Did something create a new file recently?
```

---

# 66. Find Executable Files

```bash
find /tmp -type f -executable -ls 2>/dev/null
```

This identifies executable files.

Again:

```text
Executable != malware
```

Use this as an investigation starting point.

---

# 67. Find World-Writable Files

A world-writable file can be modified by other users.

Example:

```bash
find /etc -type f -perm -002 -ls 2>/dev/null
```

Security significance:

Poor permissions can create opportunities for unauthorized modification.

Do not change permissions automatically without understanding the system.

---

# 68. Find SUID Files

SUID is a permission mechanism where an executable can run with the file owner's privileges.

Search:

```bash
find / -type f -perm -4000 -ls 2>/dev/null
```

This is an important security concept.

Common legitimate SUID programs exist.

The security question is:

```text
Is this SUID binary expected?
Is it legitimate?
Is it patched?
Is it unnecessarily privileged?
```

---

# 69. Find SGID Files

```bash
find / -type f -perm -2000 -ls 2>/dev/null
```

SGID relates to group privileges.

We will study SUID/SGID deeply in:

```text
04-Users-Groups-Permissions.md
```

---

# 70. Symbolic Link Investigation

Find symbolic links:

```bash
find /etc -type l -ls 2>/dev/null
```

Resolve a link:

```bash
readlink -f /path/to/link
```

Inspect:

```bash
ls -l /path/to/link
```

---

# 71. Practical Scenario — Suspicious File

Suppose an analyst finds:

```text
/tmp/update
```

Do not immediately execute it.

First:

```bash
ls -lah /tmp/update
```

Then:

```bash
file /tmp/update
```

Then:

```bash
stat /tmp/update
```

Then:

```bash
sha256sum /tmp/update
```

Then inspect permissions:

```bash
ls -l /tmp/update
```

Then determine whether it is running:

```bash
pgrep -a update
```

If it is running, investigate the PID through `/proc`.

---

# 72. `stat`

`stat` provides metadata.

Example:

```bash
stat /tmp/update
```

You can learn:

```text
File
Size
Permissions
Owner
Group
Access time
Modify time
Change time
```

This is useful in investigations.

---

# 73. File Timestamps

Linux commonly exposes:

```text
atime -> access time
mtime -> modification time
ctime -> metadata/status change time
```

Inspect:

```bash
stat file.txt
```

Important:

`ctime` does NOT mean creation time.

It means inode/status change time.

Filesystem-specific birth/creation timestamps may exist, but availability depends on filesystem and tools.

---

# 74. File Type Identification

Use:

```bash
file suspicious-file
```

Example:

```text
ELF 64-bit LSB executable
```

This can help identify whether something is:

```text
Text
ELF executable
Script
Archive
Image
PDF
Shared library
```

---

# 75. Hash a File

Use:

```bash
sha256sum suspicious-file
```

Example:

```text
abc123... suspicious-file
```

Why?

Hashes can help compare files.

For example:

```text
Known-good hash
        |
        v
Compare
        |
        v
Observed hash
```

If hashes differ, the files differ.

---

# 76. Practical Investigation Workflow

When you encounter an unfamiliar file:

```text
1. Do not execute it
        |
        v
2. Identify location
        |
        v
3. Check permissions
        |
        v
4. Check owner/group
        |
        v
5. Check timestamps
        |
        v
6. Identify file type
        |
        v
7. Calculate hash
        |
        v
8. Determine whether it is running
        |
        v
9. Inspect parent process
        |
        v
10. Check persistence mechanisms
```

Useful commands:

```bash
ls -lah FILE
stat FILE
file FILE
sha256sum FILE
pgrep -a PROCESS
```

---

# 77. Important Files to Know

Memorize these:

```text
/etc/passwd
/etc/shadow
/etc/group
/etc/hosts
/etc/hostname
/etc/fstab
/etc/ssh/sshd_config
/etc/sudoers
/etc/systemd/
/var/log/
/tmp/
/var/tmp/
/home/
/root/
/proc/
/sys/
/dev/
/run/
/boot/
```

You will repeatedly encounter these during Linux security work.

---

# 78. Practical Lab — Filesystem Recon

Create:

```bash
mkdir -p ~/linux-lab/filesystem
cd ~/linux-lab/filesystem
```

Create a report:

```bash
{
    echo "===== ROOT ====="
    ls -lah /

    echo "===== ETC ====="
    ls -lah /etc | head -30

    echo "===== HOME ====="
    ls -lah /home

    echo "===== VAR ====="
    ls -lah /var

    echo "===== TMP ====="
    ls -lah /tmp

    echo "===== DEV ====="
    ls -lah /dev | head -30

    echo "===== PROC ====="
    ls /proc | head -30

    echo "===== SYS ====="
    ls /sys

    echo "===== RUN ====="
    ls -lah /run
} > filesystem-report.txt
```

Read:

```bash
less filesystem-report.txt
```

---

# 79. Practical Lab — Investigate Your Own Process

Get your shell PID:

```bash
echo $$
```

Suppose:

```text
2500
```

Now:

```bash
ls -la /proc/2500
```

Check executable:

```bash
readlink -f /proc/2500/exe
```

Check command:

```bash
cat /proc/2500/cmdline | tr '\0' ' '
```

Check working directory:

```bash
readlink -f /proc/2500/cwd
```

Check file descriptors:

```bash
ls -la /proc/2500/fd
```

You have now performed basic process-level filesystem investigation.

---

# 80. Practical Lab — Investigate `/tmp`

List files:

```bash
ls -lah /tmp
```

Find recent files:

```bash
find /tmp -type f -mmin -120 -ls 2>/dev/null
```

Find executables:

```bash
find /tmp -type f -executable -ls 2>/dev/null
```

Find symbolic links:

```bash
find /tmp -type l -ls 2>/dev/null
```

For each interesting file:

```bash
file FILE
stat FILE
sha256sum FILE
```

---

# 81. Practical Lab — Investigate `/etc`

List:

```bash
ls -lah /etc
```

Inspect:

```bash
cat /etc/hostname
cat /etc/os-release
cat /etc/hosts
```

Inspect users:

```bash
cat /etc/passwd
```

Inspect groups:

```bash
cat /etc/group
```

Inspect SSH configuration if present:

```bash
sudo ls -lah /etc/ssh
```

---

# 82. Practical Lab — Find Interesting Configuration

Search for SSH configuration:

```bash
find /etc/ssh -type f -maxdepth 2 2>/dev/null
```

Search for configuration files:

```bash
find /etc -type f -name "*.conf" 2>/dev/null | head -50
```

Search for a specific configuration keyword:

```bash
grep -Rni "PermitRootLogin" /etc/ssh 2>/dev/null
```

---

# 83. Practical Lab — Find Large Files

Search `/var`:

```bash
sudo find /var -type f -size +100M -ls 2>/dev/null
```

Search your home directory:

```bash
find ~ -type f -size +100M -ls 2>/dev/null
```

This is useful for:

- disk troubleshooting
- incident investigation
- locating unexpected artifacts

---

# 84. Practical Lab — Build a File Investigation Script

Create:

```bash
nano file-investigate.sh
```

Add:

```bash
#!/bin/bash

TARGET="$1"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

if [ ! -e "$TARGET" ]; then
    echo "File does not exist."
    exit 1
fi

echo "===== FILE ====="
echo "$TARGET"

echo
echo "===== TYPE ====="
file "$TARGET"

echo
echo "===== METADATA ====="
stat "$TARGET"

echo
echo "===== SHA256 ====="
sha256sum "$TARGET"

echo
echo "===== PERMISSIONS ====="
ls -lah "$TARGET"

echo
echo "===== SYMBOLIC LINK ====="
readlink -f "$TARGET"
```

Make executable:

```bash
chmod +x file-investigate.sh
```

Run:

```bash
./file-investigate.sh /etc/hosts
```

---

# 85. Understanding the Script

This:

```bash
TARGET="$1"
```

takes the first command-line argument.

If you run:

```bash
./file-investigate.sh /etc/hosts
```

then:

```text
$1
```

contains:

```text
/etc/hosts
```

---

# 86. Input Validation

This:

```bash
if [ -z "$TARGET" ]; then
```

checks whether the variable is empty.

Then:

```bash
echo "Usage: $0 <file>"
```

prints usage information.

`$0` is the script name.

---

# 87. File Existence Check

This:

```bash
if [ ! -e "$TARGET" ]; then
```

checks whether the specified path does not exist.

This prevents the script from blindly running commands against an invalid path.

---

# 88. Why This Script Is Useful

You have created a small defensive investigation utility.

It collects:

```text
File type
Metadata
Hash
Permissions
Resolved path
```

This is a basic example of how cybersecurity analysts automate repetitive tasks.

Later, your Bash scripting file will build much more advanced tools.

---

# 89. Important Security Principle

Never confuse:

```text
unusual
```

with:

```text
malicious
```

For example:

```text
/tmp/random-script
```

could be:

- legitimate software
- administrator activity
- installer
- security tool
- malicious program

Investigation requires context.

Always ask:

```text
Who?
What?
When?
Where?
Why?
How?
```

---

# 90. Linux Filesystem Investigation Checklist

When investigating a Linux machine:

```text
[ ] Identify OS
[ ] Identify kernel
[ ] Identify hostname
[ ] Identify current user
[ ] Identify privileged groups
[ ] Inspect /etc
[ ] Inspect /var/log
[ ] Inspect /tmp
[ ] Inspect /var/tmp
[ ] Inspect /home
[ ] Inspect running processes
[ ] Inspect /proc
[ ] Inspect services
[ ] Inspect network connections
[ ] Inspect persistence
[ ] Check suspicious files
[ ] Hash suspicious files
[ ] Document findings
```

---

# 91. Common Mistakes

## Mistake 1

Running:

```bash
rm -rf
```

without understanding the target.

Avoid destructive commands during learning.

---

## Mistake 2

Executing an unknown file.

Instead:

```bash
file FILE
stat FILE
sha256sum FILE
```

first.

---

## Mistake 3

Deleting suspicious evidence.

During an investigation, deleting the file can destroy evidence.

---

## Mistake 4

Assuming every file in `/tmp` is malicious.

Temporary files are normal.

---

## Mistake 5

Assuming every SUID file is malicious.

Many legitimate Linux programs use SUID.

---

## Mistake 6

Changing permissions without understanding consequences.

For example:

```bash
chmod 777 FILE
```

is usually a poor security practice.

---

# 92. Interview Questions

## Q1. What is `/etc`?

A directory containing system-wide configuration files.

---

## Q2. What is `/var/log`?

A common location for system and application logs.

---

## Q3. What is `/proc`?

A virtual filesystem exposing process and kernel information.

---

## Q4. What is `/sys`?

A virtual filesystem exposing information about devices, drivers, and kernel subsystems.

---

## Q5. What is `/dev`?

A filesystem containing device interfaces represented as filesystem entries.

---

## Q6. What is `/tmp`?

A directory commonly used for temporary files.

---

## Q7. Difference between `/root` and `/`?

```text
/      -> filesystem root
/root  -> root user's home directory
```

---

## Q8. How do you find SUID files?

```bash
find / -type f -perm -4000 -ls 2>/dev/null
```

---

## Q9. How do you investigate a suspicious process?

Start with:

```bash
ps aux
```

Then use its PID:

```bash
readlink -f /proc/PID/exe
cat /proc/PID/cmdline | tr '\0' ' '
ls -la /proc/PID/fd
```

---

## Q10. How do you identify a suspicious file?

Start with:

```bash
file FILE
stat FILE
ls -lah FILE
sha256sum FILE
```

Then investigate its origin, execution, parent process, persistence, and network activity.

---

# 93. Mini Challenge

Create:

```text
~/linux-lab/challenge
```

Inside it create:

```text
logs/
evidence/
reports/
scripts/
```

Create:

```text
logs/application.log
```

with:

```text
INFO Application started
INFO User login
WARNING High CPU
ERROR Database failed
ERROR Authentication failed
INFO Application restarted
```

Now answer using Linux commands:

### Challenge 1

Find all `ERROR` entries.

### Challenge 2

Count them.

### Challenge 3

Save them to:

```text
reports/errors.txt
```

### Challenge 4

Find all files modified within the last hour.

### Challenge 5

Find executable files inside your challenge directory.

### Challenge 6

Calculate SHA-256 for:

```text
logs/application.log
```

### Challenge 7

Create a script that performs all six tasks automatically.

---

# 94. The Big Picture

You should now have this mental map:

```text
Linux Filesystem
       |
       +----------------+
       |                |
 Configuration        Runtime
       |                |
      /etc             /run
       |
       +----------------+
       |
      Logs
       |
    /var/log
       |
       +----------------+
       |
    Processes
       |
     /proc
       |
       +----------------+
       |
    Hardware
       |
      /sys
       |
       +----------------+
       |
    Devices
       |
      /dev
       |
       +----------------+
       |
     Users
       |
     /home
       |
       +----------------+
       |
 Temporary Data
       |
 /tmp /var/tmp
```

---

# 95. What You Must Remember

If you remember only these associations:

```text
/          -> filesystem root

/etc       -> configuration

/var       -> variable/persistent application data

/var/log   -> logs

/home      -> normal users

/root      -> root user's home

/tmp       -> temporary files

/var/tmp   -> temporary files with longer persistence

/usr       -> user-space programs/libraries

/opt       -> optional/third-party software

/boot      -> boot-related files

/dev       -> devices

/proc      -> processes/kernel information

/sys       -> hardware/kernel information

/run       -> runtime information

/mnt       -> temporary mount point

/media     -> removable media
```

These paths should become automatic in your mind.

---

# 96. Cybersecurity Connection

Linux filesystem knowledge is the foundation for:

```text
Incident Response
       |
       +-- Find suspicious files

Digital Forensics
       |
       +-- Analyze filesystem artifacts

SOC Analysis
       |
       +-- Investigate logs

Malware Analysis
       |
       +-- Locate executables/configuration

Threat Hunting
       |
       +-- Search suspicious paths

Privilege Escalation Analysis
       |
       +-- Inspect permissions/SUID

Persistence Detection
       |
       +-- Inspect startup/configuration

System Hardening
       |
       +-- Protect sensitive locations
```

---

# 97. Final Practical Workflow

When given a Linux machine for an authorized security investigation:

```bash
# 1. Identify yourself
whoami

# 2. Identify the machine
hostname

# 3. Identify the OS
cat /etc/os-release

# 4. Identify the kernel
uname -r

# 5. Check privileges/groups
id

# 6. Check running processes
ps aux

# 7. Check logged-in users
w

# 8. Check disk/mounts
df -h
lsblk

# 9. Check temporary locations
ls -lah /tmp
ls -lah /var/tmp

# 10. Check important logs
ls -lah /var/log

# 11. Check recent files in important locations
find /tmp -type f -mmin -120 -ls 2>/dev/null

# 12. Check SUID files
find / -type f -perm -4000 -ls 2>/dev/null

# 13. Inspect suspicious processes
readlink -f /proc/PID/exe
cat /proc/PID/cmdline | tr '\0' ' '

# 14. Hash suspicious files
sha256sum FILE
```

This is not a complete incident-response procedure, but it gives you the **filesystem mental model and command foundation** needed for the next Linux security topics.

---

# 98. Next

The next file is:

`03-Linux-Commands.md`

It will go deeper into command-line mastery:

```text
ls
cd
pwd
cp
mv
rm
mkdir
touch
cat
less
head
tail
grep
find
sort
uniq
cut
awk
sed
xargs
wc
tr
tee
file
stat
strings
diff
tar
gzip
curl
wget
ssh
ps
top
kill
id
who
w
history
```

with **command chaining, pipes, redirection, filtering, text processing, practical security investigation, and hands-on Bash exercises**.
```