````md id="transport-flow-control"
# Transport Layer — Flow Control

## 1. Definition

**Flow Control** prevents a fast sender from overwhelming a slow receiver.

> **Flow control protects the receiver.**

```text
Fast Sender ─────────→ Slow Receiver
              ↓
        Receiver buffer
        may overflow
````

---

# 2. Why is Flow Control Needed? ⭐⭐⭐⭐⭐

Suppose:

```text
Sender = 100 Mbps
Receiver = 20 Mbps
```

If the sender continuously sends at 100 Mbps:

```text
Receiver Buffer
      ↓
   fills up
      ↓
   Overflow
      ↓
   Data loss
```

Flow control limits how much data the sender can have in flight.

---

# 3. TCP Flow Control ⭐⭐⭐⭐⭐

TCP uses a **receive window (`rwnd`)**.

The receiver advertises how much additional data it can accept.

```text
Receiver
   ↓
Advertises rwnd
   ↓
Sender limits outstanding data
```

Example:

```text
rwnd = 5000 bytes
```

Approximately:

> Sender should not have more than 5000 bytes of unacknowledged data outstanding due to receiver capacity.

---

# 4. Receive Buffer

The receiver has a buffer:

```text
             Receiver
                ↓
        +---------------+
Data →  | Receive Buffer |
        +---------------+
                ↓
           Application
```

If the application reads data slowly, the buffer fills.

Therefore:

```text
Buffer available ↓
rwnd ↓
Sender slows down
```

---

# 5. Zero Window ⭐⭐⭐⭐

If the receiver buffer becomes full:

```text
rwnd = 0
```

The sender should stop sending normal data.

```text
Sender ─────X────→ Receiver
              rwnd = 0
```

When the receiver frees buffer space, it can advertise a larger window.

---

# 6. Flow Control vs Congestion Control ⭐⭐⭐⭐⭐

This is a **very common GATE question**.

| Flow Control                 | Congestion Control                 |
| ---------------------------- | ---------------------------------- |
| Protects receiver            | Protects network                   |
| Receiver buffer              | Network congestion                 |
| `rwnd`                       | `cwnd`                             |
| Receiver advertises capacity | Sender adjusts based on congestion |

### Easy Trick

```text
rwnd → receiver window → Flow control

cwnd → congestion window → Congestion control
```

---

# 7. Effective TCP Sending Window ⭐⭐⭐⭐⭐

TCP is constrained by both:

```text
Receiver capacity
        +
Network capacity
```

Therefore:

```text
Effective Window = min(rwnd, cwnd)
```

Example:

```text
rwnd = 10 KB
cwnd = 6 KB
```

Then:

```text
Effective Window = min(10, 6)
                 = 6 KB
```

---

# 8. Flow Control and ACKs

As the receiver successfully receives data:

```text
Data received
     ↓
ACK sent
     ↓
Window information advertised
```

The sender can then transmit more data as the window allows.

---

# 9. Sliding Window Relationship ⭐⭐⭐⭐⭐

TCP flow control uses a **sliding receive window**.

Example:

```text
Initial:

[ 1  2  3  4 ] 5 6 7
  ← window →

After data is acknowledged:

1 2 [ 3  4  5  6 ] 7
      ← window →
```

The sender can continue transmitting as the window moves forward.

---

# 10. Flow Control ≠ Error Control

Do not confuse them.

### Flow Control

```text
"How much can I send?"
```

### Error Control

```text
"Was the data corrupted/lost?"
```

### Congestion Control

```text
"Is the network overloaded?"
```

---

# 🔥 GATE Traps

### Trap 1

Flow control protects the network.

❌

> **Flow control → receiver**

---

### Trap 2

Congestion control protects the receiver.

❌

> **Congestion control → network**

---

### Trap 3

`cwnd` is the receiver's buffer size.

❌

> `rwnd` relates to receiver capacity.
> `cwnd` relates to network congestion.

---

### Trap 4

If `rwnd = 0`, the sender can freely continue sending normal data.

❌

> A zero advertised window indicates the receiver cannot currently accept more normal data.

---

### Trap 5

TCP's sending rate depends only on `rwnd`.

❌

```text
Effective Window = min(rwnd, cwnd)
```

Both receiver capacity **and** congestion control matter.

---

# ⚡ 30-Second Revision

```text
FLOW CONTROL
     ↓
Protect receiver
     ↓
TCP uses rwnd
     ↓
Receiver advertises available buffer
     ↓
Sender limits outstanding data
```

### Remember

```text
rwnd → Receiver → Flow Control

cwnd → Congestion → Congestion Control

Effective Window
      =
min(rwnd, cwnd)
```

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Focus on:

1. `rwnd`
2. Sliding receive window
3. Zero window
4. `rwnd` vs `cwnd`
5. `min(rwnd, cwnd)` numericals

```
```
