# Transport Layer — OSI Layer 4

## 1. What is the Transport Layer?

**L4 = process-to-process (end-to-end) communication.**

```text id="u2xq7e"
Process A
   ↓
Host A → Network → Host B
                     ↑
                  Process B
```

### First principle

> **Network Layer finds the destination host; Transport Layer finds the destination process/application on that host.**

---

## 2. Main Responsibilities ⭐⭐⭐⭐⭐

* Process-to-process delivery
* **Port addressing**
* Segmentation/reassembly
* Reliability
* Flow control
* Congestion control
* Connection management

---

# 3. Port Number ⭐⭐⭐⭐⭐

IP identifies the **host**.

Port identifies the **process/application**.

```text id="4o4h8b"
IP Address + Port Number
        ↓
Specific application/process
```

Example:

```text id="9y3j8v"
192.168.1.10 : 443
       IP       Port
```

### Remember

```text id="a1b7jy"
MAC  → Device on local link
IP   → Host/network endpoint
Port → Process/application
```

---

# 4. TCP vs UDP ⭐⭐⭐⭐⭐

The two major Transport Layer protocols:

```text id="bupwcx"
Transport
├── TCP
└── UDP
```

---

## TCP

**Transmission Control Protocol**

* Connection-oriented
* Reliable
* Ordered delivery
* Error recovery
* Flow control
* Congestion control
* Uses acknowledgements and retransmissions

```text id="ez40y0"
Sender ──→ Data
Sender ←── ACK
```

### Think:

> **TCP = reliable, ordered byte stream**

---

## UDP

**User Datagram Protocol**

* Connectionless
* No guaranteed delivery
* No guaranteed ordering
* No retransmission mechanism built into UDP
* Low overhead

```text id="1oygka"
Sender ─────→ Receiver
```

### Think:

> **UDP = simple, lightweight datagrams**

---

# 5. TCP Connection Establishment ⭐⭐⭐⭐⭐

TCP commonly establishes a connection using the **3-way handshake**.

```text id="c9n3fy"
Client                    Server

  SYN ─────────────────→
      ←──────────── SYN + ACK
  ACK ─────────────────→
```

### Why 3-way?

Both sides need to establish that they can:

* send
* receive
* synchronize sequence numbers

### GATE

**SYN → SYN+ACK → ACK**

---

# 6. Reliability

TCP achieves reliability using mechanisms such as:

* Sequence numbers
* Acknowledgements
* Retransmissions
* Checksums
* Timers

### Basic idea

```text id="9p0xiw"
Data #1 → ACK
Data #2 → ACK
Data #3 → lost
              ↓
          Retransmit
```

---

# 7. Flow Control ⭐⭐⭐⭐⭐

Prevents a **fast sender from overwhelming a slow receiver**.

```text id="q1z1ry"
Sender ───────→ Receiver
 Fast             Slow
```

TCP uses a **receive window** to control how much unacknowledged data can be sent.

### Think:

> **Flow control = receiver protection**

---

# 8. Congestion Control ⭐⭐⭐⭐⭐

Prevents the **network itself from becoming overloaded**.

```text id="4e8d7n"
Many senders
     ↓
   Network
     ↓
 Congestion
```

TCP adjusts its sending rate based on network conditions.

### Think:

> **Congestion control = network protection**

---

# 🔥 Flow vs Congestion Control

| Flow Control          | Congestion Control   |
| --------------------- | -------------------- |
| Protects **receiver** | Protects **network** |
| Receiver capacity     | Network capacity     |
| Receive window        | Congestion window    |

### Easy trick

> **Flow → Receiver**

> **Congestion → Network**

---

# 9. Segmentation

Transport layer can divide application data into smaller units.

```text id="1z0bsa"
Large Data
    ↓
Segment 1
Segment 2
Segment 3
```

Receiver reassembles the data in the appropriate order.

---

# 10. TCP vs UDP — GATE Table

| Feature            | TCP                 | UDP            |
| ------------------ | ------------------- | -------------- |
| Connection         | Connection-oriented | Connectionless |
| Reliability        | Yes                 | No guarantee   |
| Ordering           | Yes                 | No guarantee   |
| ACK                | Yes                 | No             |
| Retransmission     | Yes                 | No             |
| Flow control       | Yes                 | No             |
| Congestion control | Yes                 | No             |
| Overhead           | Higher              | Lower          |

---

# 11. Common Applications

### TCP commonly used by

* HTTP/HTTPS
* FTP
* SMTP

### UDP commonly used by

* DNS queries (commonly)
* DHCP
* Real-time applications

⚠️ Application protocols can use different transports depending on the version/configuration.

---

# 🔥 GATE Traps

### Trap 1

❌ IP provides reliable delivery.

✅ IP is fundamentally **best-effort**.

Reliability is typically provided by **TCP**, when required.

---

### Trap 2

❌ Port number belongs to Network Layer.

✅ **Port → Transport Layer**

---

### Trap 3

Flow control ≠ congestion control.

```text
Flow       → Receiver
Congestion → Network
```

---

### Trap 4

TCP is **byte-stream oriented**, not message-oriented.

UDP provides **datagram/message boundaries**.

---

# ⚡ 30-Second Revision

```text id="n9d3cb"
L4 TRANSPORT
│
├── Process-to-process
├── Port numbers
├── Segmentation
├── Reliability
├── Flow control
├── Congestion control
├── TCP
└── UDP
```

### Core formula

$$
\boxed{L4 = \text{Process-to-process + Ports}}
$$

### Must memorize

**TCP → Reliable + Ordered + Connection-oriented**

**UDP → Connectionless + Lightweight + No delivery guarantee**

**Flow control → Receiver**

**Congestion control → Network**

### GATE Priority: ⭐⭐⭐⭐⭐

### Placement Priority: ⭐⭐⭐⭐⭐

**This is one of the most important CN topics.** Focus heavily on **TCP handshake, sequence/ACK numbers, sliding window, flow control, congestion control, retransmission and TCP numericals.**
