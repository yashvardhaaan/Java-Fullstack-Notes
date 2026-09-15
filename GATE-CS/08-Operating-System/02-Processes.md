# `02-Processes.md`

# Processes — GATE CSE 2027

## 1. What is a Process?

A **process is a program in execution**.

> Program = passive code; Process = active execution.

Example:

```text
Program: chrome.exe
        ↓
Loaded into memory + execution state
        ↓
Process
```

A process contains more than just the program code.

### Process memory layout

```text
High Address
+------------------+
| Stack            | ↓
+------------------+
|                  |
| Heap             | ↑
+------------------+
| Data             |
+------------------+
| Code/Text        |
+------------------+
Low Address
```

---

# 2. Program vs Process

| Program                 | Process                              |
| ----------------------- | ------------------------------------ |
| Passive                 | Active                               |
| Stored on disk          | Executing/in memory                  |
| No execution state      | Has execution state                  |
| Can have many processes | Each process represents an execution |

Example:

```text
One program
   ↓
Multiple executions
   ↓
P1, P2, P3 ...
```

---

# 3. Process Control Block — PCB ⭐⭐⭐⭐⭐

The OS maintains information about every process in a **Process Control Block (PCB)**.

Typical PCB contains:

| Information                   | Example                  |
| ----------------------------- | ------------------------ |
| Process ID                    | PID                      |
| Process state                 | Ready/Running/Blocked    |
| Program counter               | Next instruction         |
| CPU registers                 | Register values          |
| CPU scheduling information    | Priority, queue pointers |
| Memory-management information | Page tables, limits      |
| Accounting information        | CPU time                 |
| I/O status                    | Open files/devices       |

> **PCB = OS's complete management record for a process.**

### 🔥 GATE Trap

The **program itself is not the PCB**.

PCB stores the **execution context and management information**.

---

# 4. Process States ⭐⭐⭐⭐⭐

Basic 5-state model:

```text
             admitted
 NEW ─────────────────→ READY
                          |
                          | dispatch
                          ↓
                       RUNNING
                       /     \
             I/O wait /       \ exit
                     ↓         ↓
                 WAITING    TERMINATED
                     |
                     | I/O complete
                     ↓
                   READY
```

### States

| State           | Meaning                    |
| --------------- | -------------------------- |
| New             | Process is being created   |
| Ready           | Waiting for CPU            |
| Running         | Currently executing on CPU |
| Waiting/Blocked | Waiting for event/I/O      |
| Terminated      | Finished execution         |

---

# 5. State Transitions

### Ready → Running

CPU scheduler dispatches the process.

### Running → Ready

Usually:

* time quantum expires
* preemption occurs

### Running → Waiting

Process requests an event/I/O and must wait.

### Waiting → Ready

The required event/I/O completes.

### Running → Terminated

Process finishes or calls `exit()`.

---

# 6. 🔥 GATE Trap: Waiting ≠ Ready

A process in **Ready** state:

> wants CPU but is waiting for CPU.

A process in **Waiting** state:

> cannot continue until some event occurs.

```text
READY   → waiting for CPU
WAITING → waiting for event
```

This distinction is extremely important.

---

# 7. Process Scheduling Queues

Typical queues:

```text
Job Queue
   ↓
Ready Queue
   ↓
CPU
   ↓
I/O Queue
```

### Ready queue

Processes waiting for CPU.

### Device/I/O queue

Processes waiting for a particular I/O device/event.

---

# 8. Long-Term, Short-Term and Medium-Term Schedulers

## Long-Term Scheduler

Selects processes from:

```text
Job pool → Ready queue
```

Controls the **degree of multiprogramming**.

### Characteristics

* invoked less frequently
* relatively slower
* controls which jobs enter the system

---

## Short-Term Scheduler ⭐⭐⭐⭐⭐

Selects a process from:

```text
Ready queue → CPU
```

Also called **CPU scheduler**.

### Characteristics

* invoked very frequently
* must be fast

---

## Medium-Term Scheduler

Responsible mainly for:

```text
Memory ↔ Disk
```

It can **suspend and resume processes**.

This is associated with swapping.

---

# 9. Dispatcher

The **dispatcher** gives control of the CPU to the process selected by the short-term scheduler.

Dispatcher performs tasks such as:

1. Context switch
2. Switch to user mode
3. Jump to proper instruction in user program

### Dispatcher latency

Time required by dispatcher to stop one process and start another.

---

# 10. Context Switch ⭐⭐⭐⭐⭐

A **context switch** occurs when CPU switches from one process/thread to another.

The OS must save the old execution context and restore the new one.

```text
Process P1 running
       ↓
Save P1 context
       ↓
Load P2 context
       ↓
Process P2 running
```

Context includes things such as:

* Program counter
* CPU registers
* Process state

The information is maintained through the PCB.

### 🔥 Trap

Context switching is **overhead**.

During context switching:

> CPU is not executing useful user-process instructions.

---

# 11. Context Switch vs Mode Switch

These are **not the same**.

### Mode switch

```text
User mode ↔ Kernel mode
```

### Context switch

```text
Process P1 ↔ Process P2
```

A system call can cause a **mode switch without necessarily causing a context switch**.

Similarly, a context switch involves changing the executing process and generally involves kernel scheduling activity.

### GATE Rule

```text
Mode switch ≠ Context switch
```

---

# 12. Process Creation

A process can create another process.

The creator is the:

> **Parent process**

The newly created process is:

> **Child process**

```text
        Parent
       /      \
    Child1   Child2
```

This forms a **process tree**.

---

# 13. PID

Each process generally has a unique **Process ID (PID)**.

Example:

```text
Parent PID = 100
Child PID  = 101
```

Recall:

```c
fork()
```

returns:

```text
Parent → child's PID
Child  → 0
```

---

# 14. Parent and Child Resources

When a process creates a child, the child may inherit some resources/attributes depending on the OS mechanism.

Important concept:

```text
Parent
  ↓ fork
Child
```

The child initially gets a copy/logical view of much of the parent's execution state.

### 🔥 GATE Trap

After `fork()`:

```c
int x = 10;
fork();
x++;
```

Parent and child have separate address spaces.

So each process modifies **its own copy** of `x`.

They do **not** automatically share ordinary variables.

---

# 15. Copy-on-Write — COW

Modern operating systems commonly optimize `fork()` using **Copy-on-Write**.

Initially:

```text
Parent ──┐
         ├── same physical pages
Child  ──┘
```

When one process modifies a page:

```text
Parent → original page
Child  → copied page
```

### Why?

Avoid unnecessary copying when the child immediately performs `exec()`.

### GATE Concept

> `fork()` creates a separate process/address space logically; physical memory pages may initially be shared through COW.

---

# 16. Process Termination

A process terminates when:

* it completes execution
* calls `exit()`
* encounters a fatal error
* is terminated by another process/OS

After termination, the OS eventually releases its resources.

---

# 17. Zombie Process ⭐⭐⭐⭐⭐

A child has terminated but its parent has **not yet collected its termination status**.

```text
Child
  ↓
Terminates
  ↓
Zombie
  ↓
Parent calls wait()
  ↓
Zombie entry removed
```

### Key point

Zombie is:

> **terminated child + parent has not performed the required wait/reaping**

It does **not** continue executing.

---

# 18. Orphan Process ⭐⭐⭐⭐⭐

An orphan occurs when:

```text
Parent terminates
       ↓
Child is still running
```

The child is adopted/re-parented by a suitable system process.

### Difference

| Zombie                         | Orphan                 |
| ------------------------------ | ---------------------- |
| Child already terminated       | Child still executing  |
| Parent hasn't collected status | Parent terminated      |
| Doesn't execute                | Can continue executing |

### Memory trick

```text
Zombie → dead child
Orphan → parent dead
```

---

# 19. `wait()` and `waitpid()`

Parent can wait for child termination.

```c
wait(NULL);
```

or more specifically:

```c
waitpid(pid, ...);
```

Purpose:

* synchronization
* collect child termination status
* reap terminated child

---

# 20. Process Hierarchy

Suppose:

```text
P1 creates P2
P2 creates P3
P3 creates P4
```

Then:

```text
P1
└── P2
    └── P3
        └── P4
```

If P2 terminates while P3 continues:

```text
P3 becomes orphan
```

---

# 21. Process vs Thread

You will study threads in the next file, but this distinction is essential.

| Process                           | Thread                                     |
| --------------------------------- | ------------------------------------------ |
| Independent execution environment | Execution unit inside process              |
| Own address space                 | Shares process address space               |
| Context switch generally heavier  | Generally lighter                          |
| IPC often required for sharing    | Communication easier through shared memory |
| More isolation                    | Less isolation                             |

---

# 22. Process Control Operations

Important operations:

```text
create
terminate
wait
execute
suspend
resume
```

UNIX examples:

```text
fork()  → create process
exec()  → replace program image
wait()  → wait for child
exit()  → terminate
```

---

# 23. Multiprogramming

Multiple processes are kept in memory so that CPU utilization can improve.

Suppose:

```text
P1 → waiting for I/O
P2 → can use CPU
```

Instead of keeping CPU idle:

```text
CPU → P2
```

### Core idea

> When one process waits for I/O, another ready process can execute.

This is one of the fundamental reasons operating systems support process scheduling.

---

# 24. Degree of Multiprogramming

Number of processes that are maintained in the system/memory for execution is commonly referred to as the **degree of multiprogramming**.

### Long-term scheduler

Controls the admission of jobs and therefore influences the degree of multiprogramming.

---

# 25. GATE PYQ Pattern — Process State

Typical GATE question:

> A process waiting for completion of an I/O operation is in which state?

Answer:

$$
\boxed{\text{Waiting/Blocked}}
$$

Not Ready.

### Why?

Because it **cannot use the CPU yet**; it is waiting for an external event.

---

# 26. GATE PYQ Pattern — Context Switch

Typical question:

> Which information needs to be saved during a process switch?

Important answer:

```text
Program Counter
CPU Registers
Process state
```

These are part of the process execution context.

### 🔥 Trap

The entire process memory is **not copied during every context switch**.

The OS saves/restores the necessary CPU execution context.

---

# 27. GATE PYQ Pattern — Process Creation

Typical question:

```c
fork();
fork();
```

Number of processes:

$$
\boxed{4}
$$

But:

```c
if (fork() == 0)
    fork();
```

Number:

$$
\boxed{3}
$$

because only the child performs the second `fork()`.

---

# 28. GATE PYQ Pattern — Zombie

Question pattern:

> A child has terminated, but the parent has not called `wait()`. What is the child?

Answer:

$$
\boxed{\text{Zombie}}
$$

---

# 29. GATE PYQ Pattern — Orphan

Question pattern:

> Parent terminates while child is still executing. What happens?

Answer:

$$
\boxed{\text{Child\ becomes\ orphan}}
$$

The child can continue execution.

---

# 30. GATE PYQ Pattern — Scheduler

| Question says                 | Think       |
| ----------------------------- | ----------- |
| Job pool → ready queue        | Long-term   |
| Ready queue → CPU             | Short-term  |
| Suspend/resume, memory ↔ disk | Medium-term |
| Gives CPU to selected process | Dispatcher  |

### 🔥 One-line trick

```text
Long  → admits
Short → selects CPU
Medium → suspends/swaps
Dispatcher → hands over CPU
```

---

# 31. Important GATE Traps

### Trap 1

**Ready ≠ Waiting**

```text
Ready   → waiting for CPU
Waiting → waiting for event/I/O
```

### Trap 2

**Zombie ≠ Orphan**

```text
Zombie → child dead
Orphan → parent dead
```

### Trap 3

Context switch does not mean copying the entire process.

### Trap 4

`fork()` gives parent and child separate logical address spaces.

### Trap 5

COW may allow physical pages to be shared initially.

### Trap 6

Short-term scheduler is also called CPU scheduler.

### Trap 7

Dispatcher ≠ scheduler.

Scheduler chooses; dispatcher actually transfers control.

### Trap 8

A process waiting for I/O is not using CPU.

---

# 🎯 GATE Priority

| Topic                        | Priority |
| ---------------------------- | -------: |
| Process states/transitions   |    ⭐⭐⭐⭐⭐ |
| PCB                          |    ⭐⭐⭐⭐⭐ |
| `fork()` process tree        |    ⭐⭐⭐⭐⭐ |
| Context switch               |    ⭐⭐⭐⭐⭐ |
| Zombie/orphan                |    ⭐⭐⭐⭐⭐ |
| Schedulers                   |    ⭐⭐⭐⭐⭐ |
| Process creation/termination |     ⭐⭐⭐⭐ |
| COW                          |     ⭐⭐⭐⭐ |
| Multiprogramming             |      ⭐⭐⭐ |
| Dispatcher                   |     ⭐⭐⭐⭐ |

---

# ⚡ 30-Second Revision

```text
Process = program in execution

PCB:
PID + state + PC + registers + scheduling +
memory info + I/O info

States:
NEW → READY → RUNNING → WAITING → READY
                         ↓
                    TERMINATED

Ready   = waiting for CPU
Waiting = waiting for event/I/O

Schedulers:
Long-term   → Job → Ready
Short-term  → Ready → CPU
Medium-term → Suspend/Resume

Dispatcher → gives CPU to selected process

Context switch:
Save P1 context → Load P2 context

Zombie:
Child terminated + not reaped

Orphan:
Parent terminated + child still running

fork() → new process
exec() → new program image
wait() → wait/reap child
exit() → terminate

COW:
fork() initially shares physical pages;
copy occurs when modification happens.
```

### ⭐ GATE Priority: **5/5**

**Most important:** Process states + PCB + context switch + scheduler + `fork()`/zombie/orphan.

➡️ **Next: `03-Threads.md`**
