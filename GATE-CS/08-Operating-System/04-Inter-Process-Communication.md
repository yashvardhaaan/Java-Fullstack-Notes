# `04-Inter-Process-Communication.md`

# Inter-Process Communication (IPC) — GATE CSE 2027

## 1. What is IPC?

**Inter-Process Communication (IPC)** is the set of mechanisms through which processes **exchange data and synchronize their execution**.

> Processes normally have separate address spaces, so the OS must provide a mechanism for them to communicate.

Two fundamental IPC approaches:

```text
1. Shared Memory
2. Message Passing
```

GATE gives high importance to understanding the **difference between these two**. ([GATE Overflow for GATE CSE][1])

---

# 2. Why is IPC Required?

Consider:

```text
Process P1          Process P2
   |                   |
   |  separate        |
   |  address spaces  |
   ↓                   ↓
Memory A             Memory B
```

P1 cannot normally directly access P2's memory.

If they need to communicate:

```text
P1 ───── IPC mechanism ───── P2
```

IPC is useful for:

* data exchange
* synchronization
* cooperation between processes
* producer-consumer systems
* client-server communication

---

# 3. Two Main IPC Models ⭐⭐⭐⭐⭐

| Feature             | Shared Memory              | Message Passing                      |
| ------------------- | -------------------------- | ------------------------------------ |
| Communication       | Common memory region       | Messages                             |
| Data exchange       | Read/write shared area     | send/receive                         |
| Speed               | Usually faster             | Usually slower                       |
| Synchronization     | Must be handled explicitly | Can be integrated into communication |
| Kernel involvement  | Mainly setup               | Often involved in send/receive       |
| Distributed systems | Difficult                  | Very suitable                        |
| Race conditions     | Possible                   | No shared variable required          |

### 🔥 GATE Shortcut

```text
Shared Memory → FAST
Message Passing → SIMPLE / DISTRIBUTED
```

---

# 4. Shared Memory ⭐⭐⭐⭐⭐

The OS creates a shared-memory region and maps it into the address spaces of multiple processes.

```text
Process P1                  Process P2
   |                           |
   |                           |
   └────────┐     ┌────────────┘
            ↓     ↓
       +-------------+
       | Shared      |
       | Memory      |
       +-------------+
```

Now both processes can read/write the same memory region.

### Why is it fast?

After establishing the shared region, processes can communicate by directly accessing memory.

The OS does not necessarily need to handle every individual data read/write.

---

# 5. Shared Memory Needs Synchronization ⭐⭐⭐⭐⭐

This is one of the biggest GATE traps.

Suppose:

```text
shared x = 10
```

Two processes simultaneously execute:

```text
x = x + 1
```

This is not necessarily atomic.

Possible interleaving:

```text
P1: read x → 10
P2: read x → 10
P1: write x → 11
P2: write x → 11
```

Final:

$$
\boxed{x=11}
$$

instead of:

$$
\boxed{x=12}
$$

This is a **race condition**.

Therefore:

> **Shared memory does NOT automatically provide synchronization.**

You need mechanisms such as:

* mutex
* semaphore
* monitor
* spinlock

---

# 6. Message Passing ⭐⭐⭐⭐⭐

Processes communicate through messages.

Basic operations:

```text
send(message)
receive(message)
```

Conceptually:

```text
P1
 |
 | send(M)
 ↓
IPC mechanism
 |
 | receive(M)
 ↓
P2
```

Processes do not need to share variables.

---

# 7. Shared Memory vs Message Passing

### Shared Memory

```text
P1 ──┐
     ↓
  Shared Data
     ↑
P2 ──┘
```

### Message Passing

```text
P1 ── send(M) ──→ P2
P1 ← receive(M) ─ P2
```

### First-principles difference

> Shared memory communicates by **sharing data**.

> Message passing communicates by **transferring data**.

---

# 8. Direct vs Indirect Communication

## Direct Communication

Processes explicitly name each other.

```text
send(P2, message)
receive(P1, message)
```

Communication is directly associated with process identities.

---

## Indirect Communication

Messages are sent through a **mailbox/port**.

```text
P1 → Mailbox → P2
```

Example:

```text
send(Mailbox, message)
receive(Mailbox, message)
```

### GATE Trick

```text
Direct   → process-to-process
Indirect → mailbox/port
```

---

# 9. Blocking vs Non-Blocking Communication ⭐⭐⭐⭐⭐

This is another high-value concept.

## Blocking Send

Sender waits until the communication operation reaches the required condition.

## Non-Blocking Send

Sender continues execution without waiting for the receiver.

---

## Blocking Receive

Receiver waits until a message becomes available.

```text
receive()
   ↓
No message?
   ↓
BLOCK
```

---

## Non-Blocking Receive

Receiver checks for a message and continues if none is available.

---

# 10. Synchronous vs Asynchronous

### Synchronous communication

Sender/receiver may have to synchronize at communication.

### Asynchronous communication

Sender can continue without waiting for the receiver.

### 🔥 Trap

Do not automatically equate:

```text
send = synchronous
receive = asynchronous
```

The behavior depends on whether the operation is **blocking or non-blocking**.

---

# 11. Buffering

Message-passing systems may use a buffer/queue.

```text
Sender
  |
  ↓
+----------------+
| Message Queue  |
+----------------+
  |
  ↓
Receiver
```

Three common cases:

### Zero capacity

No buffering.

Sender must wait until receiver is ready.

### Bounded capacity

Finite number of messages can be stored.

If full:

```text
sender may block
```

### Unbounded capacity

Conceptually unlimited queue.

Sender does not need to wait because of queue capacity.

---

# 12. Pipes ⭐⭐⭐⭐⭐

A **pipe** provides communication between processes through a stream of data.

Typical UNIX model:

```text
P1 ──write──→ PIPE ──read──→ P2
```

A pipe has:

```text
write end
read end
```

---

# 13. Anonymous Pipe

An anonymous pipe is commonly used between **related processes**, such as parent and child.

Typical sequence:

```text
Parent
   |
   | pipe()
   ↓
Pipe
   ↑
   |
Child
```

After `fork()`, parent and child can inherit the pipe's file descriptors.

### 🔥 GATE Pattern

```text
pipe() + fork()
```

is a classic question combination.

---

# 14. Named Pipe / FIFO

A **named pipe** (FIFO) has a name in the filesystem namespace and can be used by processes that do not necessarily have a parent-child relationship.

```text
P1 ──→ FIFO ──→ P2
```

### Difference

| Anonymous Pipe            | Named Pipe                      |
| ------------------------- | ------------------------------- |
| Usually related processes | Can connect unrelated processes |
| No filesystem name        | Has a name                      |
| Common with `fork()`      | Can be opened independently     |

---

# 15. Pipe is Usually Unidirectional

A standard pipe is commonly treated as a **one-way communication channel**.

```text
P1 ─────────→ P2
```

For two-way communication, typically use:

```text
Pipe 1: P1 → P2
Pipe 2: P2 → P1
```

### 🔥 Trap

Don't assume one ordinary pipe automatically gives full duplex communication.

---

# 16. Producer-Consumer Through IPC

Classic example:

```text
Producer
   |
   | data
   ↓
Buffer
   |
   ↓
Consumer
```

IPC can implement the communication, while synchronization ensures:

```text
Producer doesn't overflow buffer
Consumer doesn't consume empty buffer
```

This topic connects directly to the next file:

> **Concurrency**

---

# 17. Shared Memory + Semaphore

A common real-world combination is:

```text
Shared Memory
      +
Semaphore
```

Why?

Shared memory provides:

$$
\boxed{\text{Data exchange}}
$$

Semaphore provides:

$$
\boxed{\text{Synchronization}}
$$

Example:

```text
P1 ─────┐
        ↓
   Shared Memory
        ↑
P2 ─────┘
        +
    Semaphore
```

---

# 18. Message Passing and Synchronization

Message passing can also synchronize processes.

For example, if `receive()` is blocking:

```text
P2 calls receive()
      ↓
No message
      ↓
P2 blocks
```

When P1 sends a message:

```text
P1 → message → P2
```

P2 can continue.

Thus communication itself can impose synchronization.

---

# 19. IPC and Distributed Systems

### Shared memory

Best suited to processes on the **same machine** where memory can be mapped into both address spaces.

### Message passing

Works naturally when processes are on:

```text
same machine
OR
different machines
```

For example:

```text
Computer A                Computer B
Process P1 ──message────→ Process P2
```

### 🔥 GATE Trick

> **Distributed system → think message passing.**

---

# 20. Client-Server IPC

A client and server can communicate using:

* pipes
* message queues
* shared memory
* sockets

Example:

```text
Client
   |
   | request
   ↓
Server
   |
   | response
   ↓
Client
```

For processes on different machines, **sockets/message passing** are natural choices.

---

# 21. Message Queue

A message queue stores messages until they are received.

```text
P1
 |
 | send
 ↓
+----------------+
| Message Queue  |
| M1             |
| M2             |
| M3             |
+----------------+
 |
 ↓
P2
```

Advantages:

* asynchronous communication possible
* messages remain buffered
* sender and receiver don't necessarily execute simultaneously

---

# 22. Signals

A **signal** is a lightweight asynchronous notification sent to a process.

Examples:

```text
SIGINT
SIGTERM
SIGKILL
```

Conceptually:

```text
Process A
   |
   | signal
   ↓
Process B
```

Signals are mainly for **notification/control**, not bulk data transfer.

### 🔥 Trap

Do not treat signals as equivalent to shared memory or message queues for transferring large amounts of data.

---

# 23. Sockets

A **socket** is an endpoint for communication.

```text
Process A
   |
 Socket
   |
 Network
   |
 Socket
   |
Process B
```

Sockets are especially important for:

* client-server systems
* network communication
* distributed systems

---

# 24. IPC Mechanism Comparison

| IPC           | Main idea              |           Distributed? | Typical use              |
| ------------- | ---------------------- | ---------------------: | ------------------------ |
| Shared memory | Common memory          | ❌ Usually same machine | Fast data sharing        |
| Pipe          | Byte/data stream       |   Usually same machine | Related processes        |
| Named pipe    | FIFO                   |   Usually same machine | Unrelated processes      |
| Message queue | Messages               |        Can be extended | Structured communication |
| Signal        | Notification           |                Limited | Event/control            |
| Socket        | Communication endpoint |                  ✅ Yes | Network/client-server    |

---

# 25. GATE PYQ Pattern — Shared Memory

A typical GATE-style question asks:

> Which IPC mechanism is generally fastest for processes on the same machine?

Answer:

$$
\boxed{\text{Shared Memory}}
$$

### Why?

After setup, processes can directly access the shared region instead of transferring each piece of data through kernel-managed messages.

---

# 26. GATE PYQ Pattern — Synchronization

Question:

> Two processes use shared memory. Does shared memory itself guarantee mutual exclusion?

Answer:

$$
\boxed{\text{No}}
$$

Need:

```text
Semaphore / Mutex / other synchronization mechanism
```

A recent IPC practice question explicitly tests this distinction: shared memory does **not** remove the need for synchronization, while message passing does not require shared variables. ([GATE Overflow for GATE CSE][2])

---

# 27. GATE PYQ Pattern — Non-Blocking Send

Question:

> A process performs a non-blocking send. What happens?

Answer:

```text
Sender does not wait for receiver
```

Therefore:

$$
\boxed{\text{Non-blocking send is asynchronous}}
$$

This exact conceptual distinction appears in recent IPC practice material. ([GATE Overflow for GATE CSE][2])

---

# 28. GATE PYQ Pattern — Pipe

Typical question:

> Which IPC mechanism provides a unidirectional communication channel between processes?

Answer:

$$
\boxed{\text{Pipe}}
$$

For bidirectional communication, two pipes can be used.

---

# 29. GATE PYQ Pattern — Related vs Unrelated Processes

Question:

> Parent and child need to communicate after `fork()`. Which is a natural choice?

Think:

$$
\boxed{\text{Anonymous Pipe}}
$$

For unrelated local processes:

$$
\boxed{\text{Named Pipe / FIFO}}
$$

---

# 30. 🔥 GATE Traps

### Trap 1

> Shared memory automatically provides synchronization.

❌ False.

---

### Trap 2

> Message passing requires shared variables.

❌ False.

That is precisely one of its advantages.

---

### Trap 3

> Non-blocking send means sender waits.

❌ False.

Non-blocking means sender can continue.

---

### Trap 4

> Pipe is automatically full-duplex.

❌ Usually false for the standard pipe model.

---

### Trap 5

> Anonymous pipe is ideal for unrelated processes.

❌ Typically named pipes/FIFOs are used when processes don't have the usual parent-child relationship.

---

### Trap 6

> Shared memory is always slower than message passing.

❌ Generally the opposite for local high-volume data exchange after setup.

---

### Trap 7

> IPC only means data transfer.

❌ IPC also supports **synchronization**.

---

# 🎯 GATE Priority

| Topic                              | Priority |
| ---------------------------------- | -------: |
| Shared memory vs message passing   |    ⭐⭐⭐⭐⭐ |
| Blocking/non-blocking              |    ⭐⭐⭐⭐⭐ |
| Pipes                              |    ⭐⭐⭐⭐⭐ |
| Synchronization with shared memory |    ⭐⭐⭐⭐⭐ |
| Message queues                     |     ⭐⭐⭐⭐ |
| Direct/indirect communication      |     ⭐⭐⭐⭐ |
| Buffering                          |     ⭐⭐⭐⭐ |
| Signals                            |      ⭐⭐⭐ |
| Sockets                            |     ⭐⭐⭐⭐ |

GATE's OS syllabus explicitly includes IPC, and historical OS questions show this broader OS area consistently contributes several marks. ([GATE Overflow for GATE CSE][1])

---

# 🧠 GATE Mental Model

Whenever you see an IPC question:

```text
             IPC
              |
       ┌──────┴──────┐
       ↓             ↓
 Shared Memory   Message Passing
       |             |
    FAST          send/receive
       |             |
 Need sync?       Can synchronize
       |
    Semaphore
```

Then ask:

```text
1. Same machine?
   → Shared memory / pipe

2. Different machines?
   → Message passing / socket

3. Need maximum local speed?
   → Shared memory

4. Need synchronization?
   → Semaphore/mutex if shared memory

5. Related processes?
   → Anonymous pipe

6. Unrelated local processes?
   → Named pipe/FIFO

7. Sender should continue?
   → Non-blocking send
```

---

# ⚡ 30-Second Revision

```text
IPC = communication + synchronization between processes

Two fundamental models:
1. Shared Memory
2. Message Passing

Shared Memory:
→ common memory region
→ very fast
→ synchronization still required

Message Passing:
→ send() / receive()
→ no shared variables required
→ good for distributed systems

Communication:
Direct   → process-to-process
Indirect → mailbox/port

Blocking:
→ caller may wait

Non-blocking:
→ caller continues

Pipe:
→ byte stream
→ commonly unidirectional
→ anonymous pipe → related processes
→ named pipe → unrelated processes

Message Queue:
→ stores messages

Signal:
→ notification/control

Socket:
→ communication endpoint
→ network/client-server

Shared Memory = DATA
Semaphore/Mutex = SYNCHRONIZATION
```

### ⭐ GATE Priority: **5/5**

**Most important distinction to remember:**

$$
\boxed{\text{Shared Memory = fast data sharing, but synchronization is still required}}
$$

$$
\boxed{\text{Message Passing = send/receive, no shared variables required}}
$$

➡️ **Next: `05-Concurrency.md`**

[1]: https://gateoverflow.in/subject/operating-system?utm_source=chatgpt.com "Operating System - Subject Page / GATE Overflow for GATE CSE"
[2]: https://gateoverflow.in/541162/go-classes-dpp-gate-cs-operating-system-properties-of-ipc?show=541163&utm_source=chatgpt.com "Operating System: GO Classes DPP | GATE CS | Operating System | Properties of IPC"
