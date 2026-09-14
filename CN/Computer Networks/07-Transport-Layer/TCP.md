````md id="t0v9xk"
# TCP — Transmission Control Protocol

## 1. Definition

**TCP** is a **connection-oriented, reliable, ordered, byte-stream Transport Layer protocol**.

> TCP provides reliable process-to-process communication over an unreliable IP network.

---

## 2. Main Characteristics ⭐⭐⭐⭐⭐

- Layer 4
- Connection-oriented
- Reliable
- Ordered delivery
- Full-duplex
- Byte-stream oriented
- Uses sequence numbers
- Uses acknowledgements
- Retransmits lost data
- Flow control
- Congestion control
- Error detection using checksum

---

## 3. TCP Segment

TCP's PDU is called a **segment**.

```text id="w7q5z1"
Application Data
       ↓
      TCP
       ↓
   TCP Segment
       ↓
      IP
       ↓
   IP Packet
````

---

# 4. TCP Header ⭐⭐⭐⭐⭐

Minimum TCP header = **20 bytes**

Maximum TCP header = **60 bytes**

```text id="g1x4pd"
+----------------------+----------------------+
| Source Port (16)     | Destination Port(16) |
+----------------------+----------------------+
|          Sequence Number (32)                |
+-----------------------------------------------+
|       Acknowledgment Number (32)              |
+------+--------+-------------------------------+
| HLEN | Flags  |       Window Size             |
+------+--------+-------------------------------+
| Checksum             | Urgent Pointer         |
+----------------------+----------------------+
|              Options ...                      |
+-----------------------------------------------+
|                    Data                       |
+-----------------------------------------------+
```

### Important fields

| Field            |     Size | Purpose                      |
| ---------------- | -------: | ---------------------------- |
| Source Port      |       16 | Sender process               |
| Destination Port |       16 | Receiver process             |
| Sequence Number  |       32 | Identifies byte position     |
| ACK Number       |       32 | Next byte expected           |
| Header Length    |        4 | TCP header size              |
| Flags            |  Several | Control connection/data      |
| Window           |       16 | Receiver's advertised window |
| Checksum         |       16 | Error detection              |
| Urgent Pointer   |       16 | Urgent data                  |
| Options          | Variable | Additional features          |

---

# 5. Sequence Number ⭐⭐⭐⭐⭐

TCP is **byte-oriented**.

Sequence numbers identify **bytes**, not segments.

Suppose:

```text id="w8n4az"
Sequence Number = 1000
Data = 500 bytes
```

Then bytes are:

```text id="2x1k8a"
1000 ... 1499
```

Next expected byte:

```text id="k4j3g7"
1500
```

So:

```text id="4k8h9s"
ACK = 1500
```

🔥 **GATE Favorite**

> TCP ACK number generally indicates the **next byte expected**.

---

# 6. TCP Acknowledgement

TCP uses acknowledgements to provide reliability.

```text id="0m6r9p"
Sender                    Receiver
  |                         |
  | ---- Data ------------> |
  |                         |
  | <------ ACK ------------ |
  |                         |
```

If data is lost:

```text id="h7z3m2"
Sender ---- Segment ----X
                     Lost

Sender ← ACK / duplicate ACKs

        ↓
    Retransmission
```

---

# 7. TCP Reliability ⭐⭐⭐⭐⭐

TCP achieves reliable delivery using:

```text id="q4v1sd"
Sequence Numbers
       +
ACKs
       +
Retransmission
       +
Timers
       +
Checksum
```

This handles:

* Lost segments
* Duplicate segments
* Out-of-order segments
* Corrupted segments

---

# 8. TCP is a Byte Stream ⭐⭐⭐⭐⭐

TCP does **not preserve application message boundaries**.

Suppose application sends:

```text id="3r7k1m"
"HELLO"
"WORLD"
```

TCP sees a continuous stream:

```text id="8p2d4a"
HELLOWORLD
```

The receiver may obtain it as:

```text id="k5w1q9"
"HEL"
"LOWO"
"RLD"
```

The application must define its own message boundaries.

🔥 **Very important placement/GATE concept.**

---

# 9. TCP Flow Control

TCP uses a **receiver window** to prevent overwhelming the receiver.

```text id="9h6x2q"
Sender ─────────────→ Receiver
          Data
                      ↓
                Receive Buffer
```

Receiver advertises how much additional data it can accept.

This is called the:

> **Advertised Receive Window (rwnd)**

---

# 10. TCP Congestion Control

TCP also controls how much data is injected into the network.

Important concepts:

* Congestion Window (**cwnd**)
* Slow Start
* Congestion Avoidance
* Fast Retransmit
* Fast Recovery

Effective sending window is commonly expressed as:

```text id="p3f7y2"
Effective Window = min(rwnd, cwnd)
```

🔥

```text
rwnd → Receiver limitation
cwnd → Network limitation
```

---

# 11. TCP Connection Establishment

TCP uses the **3-way handshake**.

```text id="f4m2k8"
Client                    Server
  |                         |
  |-------- SYN ----------> |
  |                         |
  | <----- SYN + ACK -------|
  |                         |
  |-------- ACK ----------> |
  |                         |
       Connection
       Established
```

Detailed explanation comes in **Three Way Handshake.md**.

---

# 12. TCP Connection Termination

TCP normally uses a **4-segment termination process**.

```text id="r8q2v5"
Client                    Server
  |                         |
  |-------- FIN ----------> |
  | <-------- ACK ----------|
  | <-------- FIN ----------|
  | -------- ACK ---------->|
```

This will be covered in **Four Way Handshake.md**.

---

# 13. Important TCP Flags ⭐⭐⭐⭐⭐

| Flag | Meaning                                             |
| ---- | --------------------------------------------------- |
| SYN  | Synchronize sequence numbers / establish connection |
| ACK  | Acknowledgement field valid                         |
| FIN  | Graceful connection termination                     |
| RST  | Reset connection                                    |
| PSH  | Push data to application                            |
| URG  | Urgent pointer valid                                |

Modern TCP also has flags such as **ECE** and **CWR** for congestion notification.

---

# 14. TCP Port Numbers

TCP uses **16-bit port numbers**.

```text id="7d4q8n"
0 – 65535
```

Example:

```text id="2z8w4p"
HTTPS → TCP 443
HTTP  → TCP 80
SSH   → TCP 22
```

---

# 🔥 GATE Traps

### Trap 1

TCP sequence number identifies segments.

❌

> TCP sequence numbers identify **bytes** in the byte stream.

---

### Trap 2

TCP preserves message boundaries.

❌

> TCP is a **byte stream**.

---

### Trap 3

ACK = last byte received.

❌ Usually not.

> ACK number = **next byte expected**.

---

### Trap 4

TCP reliability comes only from checksum.

❌

Checksum detects corruption; reliability additionally requires **ACKs, sequence numbers and retransmission**.

---

### Trap 5

Flow control and congestion control are the same.

❌

```text
Flow control      → Receiver
Congestion control → Network
```

---

### Trap 6

TCP uses a 2-way handshake.

❌

> Connection establishment → **3-way handshake**

---

# ⚡ 30-Second Revision

```text id="x4v6p2"
TCP
 ↓
Layer 4
 ↓
Connection-oriented
 ↓
Reliable
 ↓
Ordered
 ↓
Byte stream
 ↓
Sequence Number + ACK
 ↓
Retransmission
 ↓
Flow Control
 ↓
Congestion Control
```

### Key Numbers

```text
TCP port          = 16 bits
Sequence number   = 32 bits
ACK number        = 32 bits
Min TCP header    = 20 bytes
Max TCP header    = 60 bytes
```

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Focus especially on:

1. **Sequence & ACK numbers**
2. **TCP header**
3. **3-way handshake**
4. **4-way termination**
5. **Sliding window**
6. **Flow control**
7. **Congestion control**
8. **TCP numericals**

```
```
