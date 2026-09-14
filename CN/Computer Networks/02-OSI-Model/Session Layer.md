# Session Layer — OSI Layer 5

## 1. What is the Session Layer?

**L5 = establishes, manages, synchronizes, and terminates communication sessions between applications.**

### First principle

> **L5 answers: "How do we manage an ongoing conversation/session?"**

```text
Application A
     ↕
  SESSION
     ↕
Application B
```

---

## 2. Main Functions

### ① Session Establishment

Creates a communication session.

```text
A ── Request ──→ B
A ←─ Response ── B
```

---

### ② Session Management

Maintains an active session and controls the dialogue between communicating parties.

---

### ③ Session Termination

Properly ends the communication session.

```text
Start → Communication → End
```

---

### ④ Synchronization ⭐

Places **checkpoints** in long data transfers.

Example:

```text
Data
│
├── Checkpoint 1
├── Checkpoint 2
├── Checkpoint 3
└── Checkpoint 4
```

If failure occurs after checkpoint 3:

> Communication can resume from an appropriate checkpoint rather than restarting everything.

---

## 3. Dialog Control

Session layer can coordinate **who communicates when**.

Two modes:

### Half-duplex

```text
A → B
A ← B
```

Only one side communicates at a time.

### Full-duplex

```text
A ⇄ B
```

Both can communicate simultaneously.

---

# 4. Session vs Transport 🔥

This is more important than memorizing the layer.

| Session                           | Transport                                |
| --------------------------------- | ---------------------------------------- |
| Manages **conversation/session**  | Provides **end-to-end/process delivery** |
| Session establishment/termination | Connection establishment/termination     |
| Synchronization/checkpoints       | Reliability/retransmission               |
| Dialogue control                  | Flow/congestion control                  |

### Think:

> **L5 = Manage the conversation**

> **L4 = Deliver the data**

---

# 5. Important GATE Note

In the **TCP/IP model**, Session Layer does **not exist as a separate layer**.

Its functions are generally incorporated into the **Application layer**.

```text
OSI:
Application
Presentation
Session
     ↓
TCP/IP:
Application
```

---

# 🔥 GATE Traps

### Trap 1

**Session ≠ Transport**

TCP's connection management is not the same concept as the OSI Session Layer's broader session-management functions.

### Trap 2

**Checkpointing/synchronization → Session Layer**

### Trap 3

Session layer does **not** perform routing.

```text
Routing → Network Layer
```

### Trap 4

Session layer does **not** provide MAC addressing.

```text
MAC → Data Link
```

---

# ⚡ Quick Revision

```text
L5 SESSION
│
├── Establish session
├── Manage session
├── Terminate session
├── Synchronization/checkpoints
└── Dialog control
```

### One-line memory

> **Session Layer = manages the conversation between applications.**

### GATE Priority: ⭐⭐

**Low compared with L2, L3 and L4.** Know the **functions + checkpointing + OSI/TCP-IP mapping**, but don't spend excessive time on it.

### Placement Priority: ⭐⭐⭐

Know the basic definition and be able to explain **Session vs Transport**.
