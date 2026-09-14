````md id="reliable-data-transfer"
# Reliable Data Transfer

## 1. Definition

**Reliable Data Transfer (RDT)** ensures that data reaches the receiver **correctly, completely, and in the proper order** despite packet loss, corruption, or duplication.

> Reliability = **Detect errors + detect loss + recover**

---

# 2. Why is RDT Needed?

The underlying network (IP) is generally **best-effort**.

Packets may be:

```text
Lost
Corrupted
Duplicated
Delivered out of order
````

TCP adds mechanisms to handle these problems.

---

# 3. Main Mechanisms ⭐⭐⭐⭐⭐

TCP reliability mainly uses:

```text
Sequence Numbers
       ↓
ACKs
       ↓
Checksum
       ↓
Retransmission
       ↓
Timers
```

---

# 4. Sequence Numbers ⭐⭐⭐⭐⭐

Sequence numbers identify the position of bytes in the TCP stream.

Example:

```text
Seq = 1000
Data = 500 bytes
```

Bytes:

```text
1000 → 1499
```

Next expected byte:

```text
1500
```

Therefore:

```text
ACK = 1500
```

🔥 Remember:

> **ACK number = next byte expected**

---

# 5. Checksum

Checksum detects **corrupted data**.

```text
Sender
  ↓
Checksum
  ↓
Network
  ↓
Receiver
  ↓
Checksum verification
```

If corruption is detected:

```text
Corruption detected
       ↓
Segment discarded
       ↓
Retransmission may occur
```

⚠️ Checksum **detects** errors; it does not itself correct them.

---

# 6. Acknowledgement ⭐⭐⭐⭐⭐

Receiver tells the sender what data has been successfully received.

Example:

```text
Sender ─── Seq=1000 ───→ Receiver
Sender ←──── ACK=1500 ─── Receiver
```

Meaning:

> "I have received everything up to byte 1499 and expect byte 1500 next."

---

# 7. Retransmission

If a segment is lost, TCP retransmits it.

### Timeout-based retransmission

```text
Sender ─── Segment ───X
                     Lost

        ⏱ Timeout

Sender ─── Segment ───→ Receiver
```

TCP maintains a **retransmission timer**.

---

# 8. Duplicate ACKs ⭐⭐⭐⭐⭐

Suppose:

```text
Segment 1 ✓
Segment 2 ✗ Lost
Segment 3 ✓
Segment 4 ✓
```

Receiver receives later data but still expects Segment 2.

It can send repeated ACKs for the missing data.

```text
ACK 2
ACK 2
ACK 2
```

These are **duplicate ACKs**.

TCP can use multiple duplicate ACKs to trigger:

> **Fast Retransmit**

without waiting for the retransmission timeout.

---

# 9. Fast Retransmit

Traditionally, **3 duplicate ACKs** trigger fast retransmission.

```text
3 Duplicate ACKs
       ↓
Fast Retransmit
       ↓
Retransmit missing segment
```

🔥 GATE/placement favorite.

---

# 10. In-Order Delivery

TCP provides ordered byte-stream delivery.

Suppose receiver gets:

```text
Segment 1
Segment 3
Segment 4
```

while Segment 2 is missing.

TCP knows:

```text
1 ✓
2 ✗
3 ✓
4 ✓
```

The missing data must be recovered before the application receives a continuous ordered stream.

---

# 11. Duplicate Data

A segment may be retransmitted even though the original eventually arrives.

Therefore receiver can see duplicate data.

Sequence numbers allow TCP to identify duplicates.

```text
Same sequence number
       ↓
Duplicate detected
       ↓
Do not deliver duplicate bytes again
```

---

# 12. Stop-and-Wait vs Sliding Window

### Stop-and-Wait

```text
Send 1
 ↓
Wait ACK
 ↓
Send 2
 ↓
Wait ACK
```

Simple but inefficient on high-delay networks.

### Sliding Window

Multiple segments can be outstanding:

```text
Send 1
Send 2
Send 3
Send 4
 ↓
ACKs arrive
 ↓
Window moves
```

This greatly improves throughput.

---

# 13. Flow Control vs Reliability

Don't confuse them.

### Reliability

```text
Was data lost/corrupted?
→ Recover it
```

### Flow Control

```text
Can receiver handle this much data?
→ Limit sender
```

---

# 14. TCP Reliability Summary ⭐⭐⭐⭐⭐

| Problem                    | TCP mechanism                |
| -------------------------- | ---------------------------- |
| Corruption                 | Checksum                     |
| Lost segment               | Timeout / duplicate ACK      |
| Duplicate segment          | Sequence number              |
| Out-of-order data          | Sequence number + reordering |
| Lost ACK                   | Retransmission mechanisms    |
| Continuous high throughput | Sliding window               |

---

# 🔥 GATE Traps

* **Checksum alone does NOT provide reliability.**
* ACK does not mean "last byte received"; it generally means **next byte expected**.
* TCP sequence numbers identify **bytes**, not segments.
* **3 duplicate ACKs → Fast Retransmit** in standard TCP behavior.
* Retransmission can happen because of **timeout** or **duplicate ACK-based detection**.
* UDP does not provide these TCP reliability mechanisms by itself.
* Reliability ≠ flow control.
* Reliability ≠ congestion control.

---

# ⚡ 30-Second Revision

```text
TCP Reliability

Corruption
   ↓
Checksum

Loss
   ↓
Timeout / Duplicate ACK

Duplicate
   ↓
Sequence Number

Out-of-order
   ↓
Sequence Number + Reordering

Recovery
   ↓
Retransmission

Fast loss detection
   ↓
3 Duplicate ACKs
   ↓
Fast Retransmit
```

### GATE Priority

**🔥🔥🔥🔥 — Very High**

Most important:

1. Sequence number
2. ACK calculation
3. Retransmission
4. Duplicate ACK
5. Fast retransmit
6. Sliding window

```
```
