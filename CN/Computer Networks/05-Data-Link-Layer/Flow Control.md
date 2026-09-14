# Flow Control

## 1. What is Flow Control?

**Flow control** controls the rate at which the **sender sends data** so that a **slow receiver is not overwhelmed**.

```text
Fast Sender ─────────→ Slow Receiver
            Flow Control
                 ↓
        Adjust sending rate
```

### First Principle

> **Flow control protects the receiver.**

---

# 2. Why is Flow Control Needed?

Suppose:

```text
Sender = 100 Mbps
Receiver = 20 Mbps
```

If the sender continuously sends at 100 Mbps, the receiver's buffer can overflow.

Flow control prevents this by making the sender slow down or wait.

---

# 3. Main Flow-Control Techniques

For GATE, know:

1. **Stop-and-Wait**
2. **Sliding Window**

---

# 4. Stop-and-Wait

Sender sends **one frame** and waits for an acknowledgment.

```text
Sender                 Receiver
  |------ Frame 1 ------>|
  |<-------- ACK --------|
  |------ Frame 2 ------>|
  |<-------- ACK --------|
```

### Advantages

* Simple
* Easy to implement

### Disadvantage

❌ Poor utilization when propagation delay is large.

The sender spends significant time **waiting**.

---

# 5. Sliding Window Protocol ⭐⭐⭐⭐⭐

Instead of waiting after every frame, the sender can transmit **multiple frames before receiving ACKs**.

```text
Window

[1][2][3][4]  → Send
```

As ACKs arrive, the window **slides forward**.

```text
Before:

[1][2][3][4] 5 6 7

After ACK for 1:

1 [2][3][4][5] 6 7
```

Hence the name **Sliding Window**.

---

# 6. Sender and Receiver Window

### Sender Window

Number of frames that the sender is allowed to send without waiting.

### Receiver Window

Number of frames the receiver is prepared/allowed to accept.

---

# 7. Flow Control vs Congestion Control 🔥

This is a very common interview/GATE distinction.

| Flow Control                | Congestion Control             |
| --------------------------- | ------------------------------ |
| Protects **receiver**       | Protects **network**           |
| Sender ↔ Receiver           | Entire network                 |
| Receiver capacity           | Network capacity               |
| Example: TCP receive window | Example: TCP congestion window |

### Easy Trick

> **Flow = Receiver**
> **Congestion = Network**

---

# 8. TCP Flow Control

TCP uses a **receiver window (`rwnd`)**.

The receiver tells the sender approximately how much additional data it can accept.

```text
Receiver
   ↓
Advertises rwnd
   ↓
Sender limits outstanding data
```

If receiver buffer becomes full:

```text
rwnd → 0
```

Sender may have to stop sending new data until the window opens again.

---

# 9. Important TCP Window Terms

### `rwnd`

**Receive Window**

Controls flow based on receiver capacity.

### `cwnd`

**Congestion Window**

Controls sending based on network congestion.

Effective TCP sending window is approximately:

```text
Effective Window = min(rwnd, cwnd)
```

🔥 Very important.

---

# 10. Stop-and-Wait vs Sliding Window

| Feature            | Stop-and-Wait   | Sliding Window           |
| ------------------ | --------------- | ------------------------ |
| Frames outstanding | 1               | Multiple                 |
| Waiting            | Frequent        | Reduced                  |
| Efficiency         | Lower           | Higher                   |
| Complexity         | Simple          | Higher                   |
| Used in            | Basic protocols | TCP / reliable protocols |

---

# 🔥 GATE Traps

### Trap 1

**Flow control prevents congestion.**

❌ Not its primary purpose.

Flow control protects the **receiver**.

---

### Trap 2

**Congestion window = receiver window.**

❌

```text
rwnd → receiver
cwnd → network
```

---

### Trap 3

**Sliding window means sender can send unlimited frames.**

❌

It can send only up to the **current window size** without requiring further acknowledgment/progress.

---

### Trap 4

**Stop-and-Wait is always inefficient.**

❌ Not always.

Its efficiency depends strongly on **transmission time, propagation delay, and windowing**.

---

# ⚡ 30-Second Revision

```text
FLOW CONTROL
     ↓
Protect receiver
     ↓
┌────────────────────┐
│ Stop-and-Wait      │
│ 1 frame at a time  │
└────────────────────┘

┌────────────────────┐
│ Sliding Window     │
│ Multiple frames    │
│ Window moves →     │
└────────────────────┘

TCP:
rwnd → receiver capacity
cwnd → network congestion

Effective window ≈ min(rwnd, cwnd)
```

### GATE Priority

**Sliding Window → 🔥🔥🔥🔥🔥**
**TCP `rwnd` / `cwnd` → 🔥🔥🔥🔥🔥**
**Stop-and-Wait → 🔥🔥🔥🔥**
**Flow vs Congestion → 🔥🔥🔥🔥🔥**
