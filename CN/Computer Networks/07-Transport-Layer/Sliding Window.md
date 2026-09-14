````md id="sliding-window"
# Sliding Window Protocol

## 1. Definition

**Sliding Window** allows the sender to transmit **multiple frames/segments before waiting for ACKs**.

> It improves network utilization compared with Stop-and-Wait.

---

# 2. Stop-and-Wait vs Sliding Window ⭐⭐⭐⭐⭐

### Stop-and-Wait

```text
Send 1 → Wait ACK
Send 2 → Wait ACK
Send 3 → Wait ACK
````

Only **one outstanding packet**.

### Sliding Window

```text
Send 1
Send 2
Send 3
Send 4
      ↓
  ACKs arrive
      ↓
  Window slides
```

Multiple packets can be outstanding.

---

# 3. Window

Suppose:

```text
Window Size = 4
```

Initially:

```text
[ 1  2  3  4 ] 5  6  7
  ↑
Sendable
```

After ACK for 1:

```text
1 [ 2  3  4  5 ] 6  7
    ↑
Window slides
```

After ACK for 2:

```text
1 2 [ 3  4  5  6 ] 7
      ↑
```

Hence the name:

> **Sliding Window**

---

# 4. Why Sliding Window?

Main purpose:

> Keep the communication link busy.

With Stop-and-Wait:

```text
Send → WAIT → Send → WAIT
```

A high-delay link may remain idle.

Sliding Window:

```text
Send → Send → Send → Send
              ↓
            ACKs
```

Better utilization and throughput.

---

# 5. Sender Window ⭐⭐⭐⭐⭐

The sender maintains a range of sequence numbers that can be sent without waiting for individual ACKs.

Example:

```text id="e5b5w2"
Window size = 4

[1 2 3 4] 5 6 7 8
```

The sender can transmit:

```text
1, 2, 3, 4
```

before needing further acknowledgement.

---

# 6. Receiver Window

The receiver window determines which sequence numbers the receiver is prepared to accept.

In TCP, the advertised receive window is important for **flow control**.

```text
Receiver
   ↓
"I can accept W more bytes"
   ↓
Sender limits outstanding data
```

---

# 7. TCP Sliding Window ⭐⭐⭐⭐⭐

TCP uses a byte-oriented sliding window.

The sender's usable sending window is commonly:

```text
Effective Window = min(rwnd, cwnd)
```

where:

```text
rwnd = receiver's advertised window
cwnd = congestion window
```

Therefore:

```text
rwnd → Flow Control
cwnd → Congestion Control
```

🔥 Extremely important.

---

# 8. Go-Back-N vs Selective Repeat ⭐⭐⭐⭐⭐

Sliding-window protocols are commonly discussed using:

### Go-Back-N (GBN)

If packet 2 is lost:

```text
1 ✓
2 ✗
3 ✓
4 ✓
```

Sender may retransmit:

```text
2
3
4
```

Hence:

> **Go back to the missing packet and retransmit subsequent packets.**

---

### Selective Repeat (SR)

If packet 2 is lost:

```text
1 ✓
2 ✗
3 ✓
4 ✓
```

Only the missing packet is retransmitted:

```text
2
```

Receiver can buffer correctly received out-of-order packets.

---

# 9. GBN vs Selective Repeat

| Feature            | Go-Back-N         | Selective Repeat |
| ------------------ | ----------------- | ---------------- |
| Retransmission     | Lost + subsequent | Only lost        |
| Receiver buffering | Limited           | Yes              |
| Efficiency         | Lower             | Higher           |
| Complexity         | Lower             | Higher           |

---

# 10. Sequence Number Trap ⭐⭐⭐⭐⭐

If sequence number field has **m bits**:

```text
Number of sequence numbers = 2^m
```

### Go-Back-N

Maximum sender window:

```text
W ≤ 2^m − 1
```

### Selective Repeat

Maximum window:

```text
W ≤ 2^(m−1)
```

🔥 **Very important GATE formula.**

Example:

```text
m = 3
```

Then:

```text
Sequence numbers = 2³ = 8
```

GBN:

```text
W ≤ 7
```

Selective Repeat:

```text
W ≤ 4
```

---

# 11. Why SR Window ≤ Half the Sequence Space?

Suppose:

```text
m = 3
Sequence numbers = 0...7
```

If the window were too large, after sequence-number wraparound the receiver could confuse:

```text
Old packet
```

with:

```text
New packet having the same sequence number
```

Therefore SR needs:

```text
W ≤ 2^(m−1)
```

---

# 12. Bandwidth-Delay Product ⭐⭐⭐⭐

Sliding windows are closely related to:

> **Bandwidth-Delay Product (BDP)**

Approximate amount of data that can be "in flight":

```text
BDP = Bandwidth × RTT
```

To keep a link fully utilized, the window should be sufficiently large relative to the amount of data that can be in flight.

Example:

```text
Bandwidth = 10 Mbps
RTT = 100 ms
```

```text
BDP = 10 × 10^6 × 0.1
    = 1,000,000 bits
    = 125,000 bytes
```

---

# 🔥 GATE Traps

* Sliding Window ≠ Stop-and-Wait.
* TCP sliding window is primarily **byte-oriented**.
* `rwnd` → receiver/flow control.
* `cwnd` → network/congestion control.
* GBN retransmits the missing packet **and subsequent outstanding packets**.
* Selective Repeat retransmits **only the missing packets**.
* For `m`-bit sequence numbers:

  * GBN: `W ≤ 2^m − 1`
  * SR: `W ≤ 2^(m−1)`
* Sequence numbers wrap around.
* Larger window does not automatically mean unlimited throughput; congestion and receiver capacity matter.

---

# ⚡ 30-Second Revision

```text
Sliding Window
      ↓
Multiple packets in flight
      ↓
Better link utilization

GBN:
Loss → retransmit lost + later packets

SR:
Loss → retransmit only lost packet

m-bit sequence number:
Total = 2^m

GBN:
W ≤ 2^m − 1

SR:
W ≤ 2^(m−1)

TCP:
Effective Window = min(rwnd, cwnd)
```

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Focus on **window-size numericals, sequence-number wraparound, GBN vs SR, and TCP `rwnd/cwnd`**.

```
```
