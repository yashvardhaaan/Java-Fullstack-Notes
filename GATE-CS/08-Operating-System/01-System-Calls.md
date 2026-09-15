# `01-System-Calls.md`

# System Calls — GATE CSE 2027

## 1. What is a System Call?

A **system call** is the interface through which a **user program requests a service from the Operating System kernel**.

> **User program → System Call → Kernel → OS service → Return to user**

Applications cannot directly perform privileged operations such as:

* creating processes
* accessing hardware
* managing files
* allocating certain OS resources

So they request the kernel through system calls.

---

# 2. User Mode vs Kernel Mode

Modern OS generally has at least two execution modes:

| Mode        | Can execute privileged instructions? | Typical code |
| ----------- | ------------------------------------ | ------------ |
| User mode   | ❌ No                                 | Application  |
| Kernel mode | ✅ Yes                                | OS kernel    |

### System call transition

```text
User Mode
   ↓
System Call
   ↓
Kernel Mode
   ↓
OS performs requested operation
   ↓
Return from system call
   ↓
User Mode
```

### 🔥 GATE Trap

A **system call causes a transition from user mode to kernel mode**.

But a normal function call does **not necessarily** cause this transition.

---

# 3. Major Categories of System Calls

| Category                | Purpose                           | Examples                                 |
| ----------------------- | --------------------------------- | ---------------------------------------- |
| Process control         | Create/terminate/manage processes | `fork()`, `exec()`, `wait()`, `exit()`   |
| File management         | File operations                   | `open()`, `read()`, `write()`, `close()` |
| Device management       | Device operations                 | `ioctl()`                                |
| Information maintenance | Get/set system information        | `getpid()`                               |
| Communication           | IPC                               | `pipe()`, shared memory related calls    |
| Protection              | Permissions/security              | `chmod()`, `setuid()`                    |

### ⭐ GATE Priority

**Process-related system calls are the most important.**

Especially:

```text
fork()
exec()
wait()
exit()
```

---

# 4. `fork()`

`fork()` creates a **new child process**.

```c
pid = fork();
```

After successful `fork()`:

```text
Parent Process
      |
      └──── Child Process
```

Both processes continue execution from the instruction **immediately after `fork()`**.

### Return value

| Process |   `fork()` return |
| ------- | ----------------: |
| Parent  | child's PID (> 0) |
| Child   |               `0` |
| Failure |              `-1` |

Therefore:

```c
if (fork() == 0)
    // child
else
    // parent
```

---

# 5. Most Important `fork()` Trick

Consider:

```c
fork();
printf("Hello");
```

After `fork()` there are **2 processes**.

Therefore:

```text
printf → 2 times
```

For:

```c
fork();
fork();
printf("Hello");
```

Number of processes:

```text
1 → 2 → 4
```

Therefore:

```text
printf → 4 times
```

### General rule

If there are `n` unconditional successful `fork()` calls:

$$
\boxed{\text{Number of processes}=2^n}
$$

and if `printf()` is reached by all processes:

$$
\boxed{\text{printf executions}=2^n}
$$

### 🔥 Trap

This formula works only when **every existing process executes every `fork()`**.

Conditional `fork()`, `break`, `continue`, `wait()` etc. can change the answer.

---

# 6. `exec()`

`exec()` is fundamentally different from `fork()`.

### `fork()`

Creates a **new process**.

### `exec()`

Replaces the **current process's program image** with another program.

```text
Before exec:
Process P → Program A

After exec:
Process P → Program B
```

The process itself is not duplicated.

### 🔥 GATE Trap

> `exec()` does **NOT** create a new process.

Usually:

```c
fork();
exec();
```

means:

```text
Parent
  |
  └── Child
       |
       └── exec → child now runs another program
```

This is a very common UNIX process-creation pattern.

---

# 7. `wait()`

`wait()` allows a parent process to wait for a child process.

```c
wait(NULL);
```

Typical behavior:

```text
Parent
  |
  | wait()
  ↓
Blocked
  |
  | child terminates
  ↓
Ready/Running
```

### Why is `wait()` important?

It is commonly used to:

* synchronize parent and child
* collect child termination status
* prevent certain zombie-process situations

---

# 8. `exit()`

`exit()` terminates the calling process.

```c
exit(0);
```

Typical interpretation:

```text
exit(0) → successful termination
non-zero → some error/failure indication
```

---

# 9. `getpid()` and `getppid()`

```c
getpid()
```

→ returns process ID of the current process.

```c
getppid()
```

→ returns process ID of the parent process.

Example:

```text
Parent PID = 100
Child PID  = 101

Inside child:
getpid()  → 101
getppid() → 100
```

---

# 10. File System System Calls

Important calls:

```text
open()
read()
write()
close()
```

Typical sequence:

```c
fd = open("file.txt", ...);
read(fd, buffer, n);
write(fd, buffer, n);
close(fd);
```

### File descriptor

`open()` typically returns a **file descriptor**.

Conceptually:

```text
Process
  |
  └── File Descriptor → Open File → File
```

---

# 11. System Call vs Library Function

This distinction is important.

### System call

Direct interface to kernel functionality.

Examples:

```text
fork()
read()
write()
open()
wait()
```

### Library function

Provided by a programming library.

Examples:

```text
printf()
malloc()
strlen()
```

However, a library function **may internally invoke system calls**.

For example:

```text
printf()
   ↓
C library
   ↓
write() system call
   ↓
Kernel
```

### 🔥 GATE Trap

> **Library function ≠ system call**

A library function can use one or more system calls internally.

---

# 12. System Call Mechanism

Conceptually:

```text
Application
    ↓
Library/API
    ↓
System-call interface
    ↓
Trap / syscall instruction
    ↓
Kernel
    ↓
Service performed
    ↓
Return value
```

The exact implementation depends on the architecture/OS.

---

# 13. System Call vs Interrupt vs Exception

This is a common conceptual GATE area.

| Feature      | System Call     | Hardware Interrupt        | Exception                           |
| ------------ | --------------- | ------------------------- | ----------------------------------- |
| Source       | Program request | Hardware                  | CPU/program event                   |
| Intentional? | Usually yes     | Usually external          | Often caused by execution condition |
| Mode switch  | User → Kernel   | Usually → Kernel/handler  | Usually → Kernel/handler            |
| Example      | `read()`        | Keyboard/device interrupt | Divide by zero, page fault          |

### Important

A system call is a **controlled request by a program** for OS service.

---

# 14. `fork()` Process Tree

Suppose:

```c
fork();
fork();
fork();
```

Process creation:

```text
             P
          /     \
        P1       P
       /  \     /  \
     P2   P3   P4   P5
```

Total:

$$
2^3=8
$$

So the complete tree would contain **8 processes**.

---

# 15. Conditional `fork()` — GATE Favorite

Example:

```c
if (fork() == 0)
    fork();
```

First `fork()`:

```text
P
├── Parent
└── Child
```

Only the **child** executes the second `fork()`.

Therefore:

```text
2 + 1 = 3 processes
```

### 🔥 Trick

Never blindly use:

$$
2^n
$$

Count **which processes actually reach each `fork()`**.

---

# 16. `fork()` + `wait()` Pattern

Consider:

```c
fork();
wait(NULL);
```

The `wait()` does **not undo the process creation**.

After `fork()`:

```text
Parent ──┐
         ├── Child
         └──
```

The parent may wait for the child, but both processes already exist.

### Important

`wait()` affects **execution order**, not the fact that `fork()` created the child.

---

# 17. Zombie vs Orphan

### Zombie

Child has terminated, but parent has not collected its termination status.

```text
Child terminates
      ↓
Zombie
      ↓
Parent calls wait()
      ↓
Zombie entry removed
```

### Orphan

Parent terminates before child.

```text
Parent
   ↓
terminates

Child
   ↓
becomes orphan
```

### 🔥 Trap

```text
Zombie → terminated child
Orphan → running child whose parent terminated
```

---

# 18. GATE PYQ — `fork()` + `wait()`

### GATE CSE 2024 Set 1

Consider:

```c
int x = 3;

while(x > 0) {
    fork();
    printf("hello");
    wait(NULL);
    x--;
}
```

How many times is `printf()` executed?

**Answer:**

$$
\boxed{14}
$$

The official/solution discussion gives the process counts across iterations as:

```text
Iteration 1: 2 processes × 1 print = 2
Iteration 2: 4 processes × 1? 
```

More carefully, because each process has its own copy of `x`:

```text
x = 3 → 2 processes print
x = 2 → 4 processes print
x = 1 → 8 processes print
```

But `wait()` changes the process-tree execution structure, and the standard derivation yields:

$$
\boxed{14}
$$

The GateOverflow solution explicitly gives:

$$
3(2)+2(2)+4(1)=14
$$

This is an excellent example of why you should **not simply apply `2^n` to a loop containing `fork()` and `wait()`**. ([GATE Overflow for GATE CSE][1])

---

# 19. Recent GATE Pattern — `fork()`

GATE continues to ask process-tree questions.

For example, **GATE CSE 2026 Set 1** asked about:

```c
for (i = 0; i < 3; i++) {
    if (fork() == 0)
        continue;
    break;
}
printf("Hello!");
```

The key is to trace **which process executes `continue` and which executes `break`**, rather than assuming every process performs every `fork()`. ([ExamSIDE][2])

### GATE pattern

Expect:

```text
fork()
fork() + if
fork() + loop
fork() + wait()
fork() + printf()
```

as **1–2 mark numerical questions**.

---

# 20. GATE 2023 — Mode Transition

A GATE 2023 question asked which operations guarantee a transition from **user mode to kernel mode**.

Important answer:

```text
System Call
Page Fault
```

A normal:

```text
function call
malloc call
```

does not inherently guarantee such a transition. ([GateOverflow][3])

### 🔥 Remember

```text
System call → Kernel
Page fault  → Kernel
Normal function call → not necessarily
```

---

# 21. Most Important GATE Tricks

### Trick 1 — `fork()`

```text
fork() → creates child
```

### Trick 2 — `exec()`

```text
exec() → replaces current program
```

### Trick 3 — `wait()`

```text
wait() → parent waits for child
```

### Trick 4 — `exit()`

```text
exit() → process terminates
```

### Trick 5 — `fork()` return value

```text
Parent → child PID
Child  → 0
Failure → -1
```

### Trick 6 — Process count

Unconditional independent forks:

$$
\boxed{2^n}
$$

### Trick 7 — Conditional fork

Count **actual fork executions**, not number of `fork()` statements in source code.

### Trick 8 — `exec()`

```text
fork() → new process
exec() → new program image
```

### Trick 9 — Library vs system call

```text
printf() → library function
write()  → system call
```

### Trick 10 — Mode switch

```text
System call → User → Kernel
Page fault  → User → Kernel
```

---

# 🔥 GATE Traps

1. **`exec()` does not create a process.**
2. `fork()` creates a child.
3. Both parent and child continue after `fork()`.
4. Parent receives child's PID; child receives `0`.
5. `wait()` does not terminate the child.
6. `wait()` changes scheduling/order, not process creation.
7. `printf()` is a library function, not itself a system call.
8. `2^n` is unsafe when forks are conditional.
9. Every process has its **own copy of normal variables** after `fork()`.
10. Page fault also causes a user-to-kernel transition.

---

# 🎯 GATE Question Patterns

| Pattern                | Priority |
| ---------------------- | -------- |
| `fork()` process count | ⭐⭐⭐⭐⭐    |
| `fork()` + `if/else`   | ⭐⭐⭐⭐⭐    |
| `fork()` + loops       | ⭐⭐⭐⭐⭐    |
| `fork()` + `wait()`    | ⭐⭐⭐⭐⭐    |
| `fork()` + `exec()`    | ⭐⭐⭐⭐     |
| System call categories | ⭐⭐⭐      |
| User/kernel mode       | ⭐⭐⭐⭐⭐    |
| Library vs system call | ⭐⭐⭐⭐     |
| Zombie/orphan          | ⭐⭐⭐⭐     |
| File system calls      | ⭐⭐⭐      |

---

# ⚡ 30-Second Revision

```text
System Call = User program → Kernel service

fork()  → creates child
exec()  → replaces current process image
wait()  → parent waits for child
exit()  → process terminates

fork() return:
Parent → child PID
Child  → 0
Failure → -1

n unconditional forks:
Processes = 2^n

User → Kernel:
System call
Page fault

Zombie:
Child terminated, parent hasn't collected status

Orphan:
Parent terminated, child still running

printf() → library function
write()  → system call
```

### ⭐ GATE Priority: **⭐⭐⭐⭐⭐ / 5**

**Most important thing to master:** `fork()` process-tree questions. They directly connect to the next topics **Processes, Threads and IPC**, so don't memorize the formula alone—learn to trace which process reaches each statement.

**Next file → `02-Processes.md`**

[1]: https://gateoverflow.in/422795/gate-cse-2024-set-1-question-47?show=431327&utm_source=chatgpt.com "Operating System: GATE CSE 2024 | Set 1 | Question: 47"
[2]: https://questions.examside.com/past-years/gate/gate-cse/operating-systems/process-concepts-and-cpu-scheduling?utm_source=chatgpt.com "Process Concepts and Cpu Scheduling | Operating Systems | GATE CSE Previous Year Questions - ExamSIDE.Com"
[3]: https://db.gateoverflow.in/questions/operating-system?sort=gate&start=20&utm_source=chatgpt.com "Previous GATE Questions in Operating System / GATE Overflow for GATE CSE"
