# `03-Threads.md`

# Threads — GATE CSE 2027

## 1. What is a Thread?

A **thread is the smallest unit of CPU execution/scheduling within a process**.

> Process = resource container
> Thread = execution unit

A process can contain multiple threads.

```text
Process
├── Thread 1
├── Thread 2
└── Thread 3
```

---

# 2. Process vs Thread ⭐⭐⭐⭐⭐

| Feature         | Process                                        | Thread                            |
| --------------- | ---------------------------------------------- | --------------------------------- |
| Address space   | Own                                            | Shared within process             |
| Code            | Own                                            | Shared                            |
| Data            | Own                                            | Shared                            |
| Heap            | Own                                            | Shared                            |
| Open files      | Process resources, generally shared by threads | Shared                            |
| Stack           | Own                                            | **Each thread has its own**       |
| Registers       | Own execution context                          | **Each thread has its own**       |
| Program Counter | Own                                            | **Each thread has its own**       |
| Creation        | More expensive                                 | Usually cheaper                   |
| Context switch  | Generally heavier                              | Generally lighter                 |
| Communication   | IPC usually needed                             | Shared memory naturally available |

### 🔥 Most important rule

Threads of the same process share:

```text
Code
Data
Heap
Open files/resources
```

Each thread has its own:

```text
Program Counter
Registers
Stack
```

### Memory trick

> **Shared: Code + Data + Heap**
> **Private: Stack + Registers + PC**

---

# 3. Why Threads?

Threads provide:

### 1. Responsiveness

One thread can continue while another waits.

### 2. Resource sharing

Threads naturally share the process's address space.

### 3. Economy

Creating/switching threads is generally cheaper than processes.

### 4. Parallelism

On a multicore CPU, multiple threads can execute simultaneously.

---

# 4. Single-Threaded vs Multithreaded Process

### Single-threaded

```text
Process
   ↓
Thread
```

### Multithreaded

```text
Process
   ├── T1
   ├── T2
   ├── T3
   └── T4
```

All threads belong to the same process and share its resources.

---

# 5. What Does Each Thread Have Separately?

This is **very important for GATE**.

Every thread has its own:

### Program Counter

Points to the next instruction.

### Registers

Contains the thread's CPU execution state.

### Stack

Stores:

* local variables
* function calls
* return addresses

Therefore:

```text
Process
├── T1 → PC1, Registers1, Stack1
├── T2 → PC2, Registers2, Stack2
└── T3 → PC3, Registers3, Stack3
```

---

# 6. What Do Threads Share?

Threads in one process generally share:

```text
┌─────────────────────────┐
│        PROCESS          │
│                         │
│ Code       ← Shared     │
│ Data       ← Shared     │
│ Heap       ← Shared     │
│ Open Files ← Shared     │
│                         │
│ T1: Stack + Registers   │
│ T2: Stack + Registers   │
│ T3: Stack + Registers   │
└─────────────────────────┘
```

### 🔥 GATE Trap

> **Stack is NOT shared between threads.**

Each thread requires its own stack.

---

# 7. User-Level Threads (ULT)

User-level threads are managed by a **user-level thread library**, without requiring the OS kernel to manage each thread individually.

```text
Application
   ↓
Thread Library
   ↓
ULTs
   ↓
Kernel sees process
```

### Advantages

* Fast creation
* Fast switching
* No kernel intervention for many thread operations
* Custom scheduling possible

### Disadvantages

* A blocking system call can block the entire process under the traditional many-to-one model.
* Kernel may not know about individual threads.
* Traditional ULT many-to-one cannot achieve true parallelism on multiple cores.

---

# 8. Kernel-Level Threads (KLT)

Kernel directly manages/schedules threads.

```text
Application
   ↓
Kernel
   ↓
T1, T2, T3
```

### Advantages

* If one thread blocks, another thread can run.
* Can achieve true parallelism on multicore systems.
* Kernel can schedule individual threads.

### Disadvantages

* Creation/switching generally has more overhead.
* Requires kernel involvement.

---

# 9. User-Level vs Kernel-Level Threads

| Feature                          | User-Level              | Kernel-Level               |
| -------------------------------- | ----------------------- | -------------------------- |
| Managed by                       | Thread library          | OS kernel                  |
| Kernel knows individual threads? | Usually no              | Yes                        |
| Creation                         | Faster                  | Slower                     |
| Switching                        | Faster                  | More overhead              |
| Blocking one thread              | May block whole process | Other threads can continue |
| Multicore parallelism            | Not with many-to-one    | Yes                        |

### 🔥 GATE shortcut

```text
ULT → fast but blocking problem
KLT → slower but better OS/multicore support
```

---

# 10. Multithreading Models ⭐⭐⭐⭐⭐

There are three classic models:

1. Many-to-One
2. One-to-One
3. Many-to-Many

---

## 10.1 Many-to-One

Many user threads map to one kernel thread.

```text
T1 ─┐
T2 ─┼──→ K1
T3 ─┘
```

### Advantages

* Very fast thread management
* Simple

### Major disadvantage

If one thread performs a blocking system call:

```text
All threads may block
```

Also:

> Cannot achieve true parallel execution on multiple CPUs because only one kernel thread exists.

---

# 11. One-to-One

Each user thread maps to one kernel thread.

```text
T1 ──→ K1
T2 ──→ K2
T3 ──→ K3
```

### Advantages

* One blocked thread doesn't necessarily block others.
* Can execute threads in parallel on multiple CPUs.

### Disadvantage

Creating many threads can create many kernel threads → greater overhead.

---

# 12. Many-to-Many

Many user threads are mapped to many kernel threads.

```text
T1 ─┐
T2 ─┼──→ K1
T3 ─┼──→ K2
T4 ─┘
```

Allows flexibility between user-level and kernel-level threading.

---

# 13. Two-Level Model

A variation of many-to-many that also permits some user threads to be bound to specific kernel threads.

Conceptually:

```text
Many user threads
       ↓
Many kernel threads
       +
Some user threads can be bound to a kernel thread
```

---

# 14. Thread Context Switch ⭐⭐⭐⭐⭐

Suppose T1 and T2 belong to the **same process**.

During:

```text
T1 → T2
```

the OS must switch the thread execution context.

Important:

* T1's registers saved
* T2's registers restored
* T1's PC saved
* T2's PC restored
* stack pointer changes

### What usually does NOT need to change?

The process's:

```text
Address space
Code
Heap
Data
```

because both threads belong to the same process.

### Therefore

Thread switching can be cheaper than process switching.

---

# 15. GATE PYQ — Thread Context Switch

**GATE CSE 2023, Question 12** asked:

> Which information needs to be saved when switching from thread T1 to thread T2 of the **same process**?

The key concept is that each thread has its own:

* Program counter
* Registers
* Stack-related execution state

while the address space remains shared. ([GateOverflow][1])

### 🔥 GATE approach

Whenever the question says:

> **T1 → T2 of the same process**

immediately think:

```text
PC → different
Registers → different
Stack → different
Address space → same
```

---

# 16. GATE PYQ — Thread Properties

**GATE CSE 2024 Set 1, Question 14** directly tested statements about threads. ([GateOverflow][2])

The important concepts tested include:

* Threads can be implemented at user level as well as kernel level.
* Threads of the same process share resources.
* Threads do not each have an independent address space.
* Each thread has its own execution context.

### PYQ lesson

Don't memorize:

> "Everything is shared between threads."

Instead memorize:

$$
\boxed{\text{Shared resources + private execution state}}
$$

---

# 17. Thread and File Descriptors

Threads belonging to the same process generally share the process's **open-file resources/file descriptor table**.

Therefore, if one thread opens a file, other threads can generally access the process's file descriptor resources.

### 🔥 Trap

Do **not** assume:

```text
1 thread = 1 file descriptor table
```

The file descriptor table is associated with the **process**, not independently with each thread in the traditional model.

---

# 18. Thread and Global Variables

Suppose:

```c
int x = 10;
```

is global to a process.

Multiple threads can access `x`.

```text
T1 ─┐
T2 ─┼──→ shared x
T3 ─┘
```

Therefore, simultaneous modification can cause:

> **Race condition**

This becomes extremely important in the next topics:

* Concurrency
* Synchronization
* Semaphores
* Mutexes

---

# 19. Thread-Local Storage

Although threads share process data, an OS/thread library can provide **thread-local storage (TLS)**.

Conceptually:

```text
T1 → own local copy of variable
T2 → own local copy
T3 → own local copy
```

So:

```text
Global variable → shared
Thread-local variable → private
```

---

# 20. Thread Safety

A function is **thread-safe** if it can be safely used concurrently by multiple threads without causing incorrect behavior.

Problem example:

```text
T1 ──→ shared data ←── T2
```

without proper synchronization.

This can produce inconsistent results.

---

# 21. Process vs Threads — GATE Table

| Property          | Process  | Threads of same process |
| ----------------- | -------- | ----------------------- |
| Address space     | Separate | Shared                  |
| Code              | Separate | Shared                  |
| Data              | Separate | Shared                  |
| Heap              | Separate | Shared                  |
| Stack             | Own      | **Each thread own**     |
| Registers         | Own      | **Each thread own**     |
| PC                | Own      | **Each thread own**     |
| Communication     | IPC      | Shared memory           |
| Creation overhead | Higher   | Lower                   |
| Isolation         | High     | Lower                   |

---

# 22. 🔥 GATE Traps

### Trap 1

> Threads have separate address spaces.

❌ False.

Threads of the same process share the address space.

---

### Trap 2

> Threads share their stacks.

❌ False.

Each thread has its own stack.

---

### Trap 3

> Threads share registers.

❌ False.

Each thread has its own CPU register state.

---

### Trap 4

> User-level threads cannot be created.

❌ False.

They can be managed entirely by user-level libraries.

---

### Trap 5

> Many-to-one can achieve true multicore parallelism.

❌ False.

Only one kernel thread exists.

---

### Trap 6

> One blocked user thread never affects another thread.

❌ Not necessarily.

In many-to-one, a blocking system call can block the entire process.

---

### Trap 7

> Thread switch requires changing the entire address space.

❌ Generally false for threads within the same process.

---

### Trap 8

> Process = smallest scheduling unit in every OS.

❌ False.

Modern OS commonly schedule **threads**.

---

# 23. GATE Question Patterns

| Pattern                                 | Priority |
| --------------------------------------- | -------: |
| Shared vs private resources             |    ⭐⭐⭐⭐⭐ |
| Thread context switch                   |    ⭐⭐⭐⭐⭐ |
| User vs kernel threads                  |    ⭐⭐⭐⭐⭐ |
| Many-to-one / one-to-one / many-to-many |    ⭐⭐⭐⭐⭐ |
| Process vs thread                       |    ⭐⭐⭐⭐⭐ |
| Blocking behavior                       |    ⭐⭐⭐⭐⭐ |
| Multicore parallelism                   |     ⭐⭐⭐⭐ |
| Thread-local storage                    |      ⭐⭐⭐ |
| Thread safety                           |     ⭐⭐⭐⭐ |

The recent GATE trend supports giving this topic high priority: the Operating Systems syllabus has consistently carried roughly **6–10 marks overall**, and threads have appeared directly in recent papers, including GATE 2024 and GATE 2023. ([GATE Overflow for GATE CSE][3])

---

# 🎯 GATE Mental Model

Whenever you see **THREAD**, ask:

```text
1. Same process?
       ↓
2. What is shared?
       ↓
Code + Data + Heap + resources

3. What is private?
       ↓
PC + Registers + Stack

4. Which threading model?
       ↓
Many-to-One / One-to-One / Many-to-Many

5. Is there a blocking call?
       ↓
Check whether other threads can continue.

6. Is it multicore?
       ↓
Check whether multiple kernel threads exist.
```

---

# ⚡ 30-Second Revision

```text
Thread = smallest unit of CPU execution/scheduling.

Threads of same process SHARE:
→ Code
→ Data
→ Heap
→ Open files/resources

Each thread has OWN:
→ Program Counter
→ Registers
→ Stack

ULT:
→ managed by user library
→ fast
→ many-to-one blocking problem

KLT:
→ managed by kernel
→ more overhead
→ supports multicore parallelism

Many-to-One:
Many ULT → 1 KLT
→ no true parallelism
→ blocking problem

One-to-One:
1 ULT → 1 KLT
→ parallelism possible

Many-to-Many:
Many ULT → Many KLT

Same-process thread switch:
→ PC/registers/stack change
→ address space remains same

Thread switch generally cheaper than process switch.
```

### ⭐ GATE Priority: **5/5**

**Must memorize:**

$$
\boxed{\text{Shared: Code + Data + Heap}}
$$

$$
\boxed{\text{Private: PC + Registers + Stack}}
$$

➡️ **Next: `04-Inter-Process-Communication.md`**

[1]: https://db.gateoverflow.in/questions/operating-system?sort=gate&start=20&utm_source=chatgpt.com "Previous GATE Questions in Operating System / GATE Overflow for GATE CSE"
[2]: https://db.gateoverflow.in/questions/operating-system?sort=hot&start=60&utm_source=chatgpt.com "Hot questions in Operating System / GATE Overflow for GATE CSE"
[3]: https://gateoverflow.in/subject/operating-system?utm_source=chatgpt.com "Operating System - Subject Page / GATE Overflow for GATE CSE"
