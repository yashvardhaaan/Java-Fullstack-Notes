````md id="j5xq2a"
# UDP — User Datagram Protocol

## 1. Definition

**UDP** is a **connectionless, unreliable, datagram-oriented Transport Layer protocol**.

> UDP provides fast, lightweight process-to-process communication with minimal overhead.

---

## 2. Main Characteristics ⭐⭐⭐⭐⭐

- Transport Layer → **Layer 4**
- Connectionless
- No connection setup/handshake
- Unreliable delivery
- No guarantee of ordering
- No retransmission
- No ACK mechanism
- No flow control
- No congestion control at the UDP protocol itself
- Message/datagram oriented
- Low overhead

---

## 3. UDP Header ⭐⭐⭐⭐⭐

UDP header size = **8 bytes**

```text id="k9f0xr"
+----------------------+----------------------+
| Source Port (16)     | Destination Port(16) |
+----------------------+----------------------+
| Length (16)          | Checksum (16)        |
+----------------------+----------------------+
|              Data                           |
+---------------------------------------------+
````

Total header:

```text id="3q8k1p"
4 × 16 bits = 64 bits = 8 bytes
```

### Fields

| Field            |    Size | Purpose           |
| ---------------- | ------: | ----------------- |
| Source Port      | 16 bits | Sender process    |
| Destination Port | 16 bits | Receiver process  |
| Length           | 16 bits | UDP header + data |
| Checksum         | 16 bits | Error detection   |

---

## 4. UDP Length ⭐⭐⭐⭐

The **Length field includes both header and data**.

```text id="m0m5f9"
UDP Length = UDP Header + UDP Data
```

Since header = 8 bytes:

```text id="4ps2te"
Data size = UDP Length − 8
```

Example:

```text
UDP Length = 100 bytes

Data = 100 − 8
     = 92 bytes
```

🔥 **GATE Trap:**
Do NOT confuse UDP Length with payload length.

---

## 5. UDP Checksum

UDP checksum provides **error detection**.

It can detect corruption in the UDP transmission.

```text id="1r6y8k"
Checksum ≠ Reliability
```

A checksum does **not** provide:

* retransmission
* ordering
* guaranteed delivery

---

## 6. Why Use UDP?

UDP is useful when **low overhead and speed** are more important than built-in reliability.

Common examples:

* DNS
* DHCP
* VoIP
* Online gaming
* Streaming
* Real-time applications
* QUIC → UDP

> If an application needs reliability, it can implement reliability itself or use another protocol such as TCP.

---

## 7. UDP vs TCP ⭐⭐⭐⭐⭐

| Feature            | TCP                 | UDP            |
| ------------------ | ------------------- | -------------- |
| Connection         | Connection-oriented | Connectionless |
| Reliability        | Yes                 | No             |
| Ordering           | Yes                 | No             |
| ACK                | Yes                 | No             |
| Retransmission     | Yes                 | No             |
| Flow control       | Yes                 | No             |
| Congestion control | Yes                 | No             |
| Data model         | Byte stream         | Datagram       |
| Header             | ≥20 bytes           | 8 bytes        |
| Speed/overhead     | Higher overhead     | Lower overhead |

---

# 🔥 GATE Traps

### Trap 1

**UDP is unreliable because it has no checksum.**

❌

UDP **does have a checksum**.

> Checksum detects errors; it does not guarantee delivery.

---

### Trap 2

**UDP establishes a connection before sending data.**

❌

UDP is **connectionless**.

---

### Trap 3

**UDP is always faster than TCP.**

⚠️ Oversimplification.

UDP has **less protocol overhead**, but actual application performance depends on the network and application.

---

### Trap 4

**UDP is stream-oriented.**

❌

UDP is **datagram/message-oriented**.

If an application sends:

```text id="h5p8wd"
Message A
Message B
```

UDP preserves those datagram boundaries.

---

### Trap 5

**UDP Length contains only data.**

❌

```text id="c9h3ws"
UDP Length = Header + Data
```

---

# ⚡ 30-Second Revision

```text id="g5j2q1"
UDP
 ↓
Layer 4
 ↓
Connectionless
 ↓
Datagram-oriented
 ↓
Unreliable
 ↓
No ACK
 ↓
No retransmission
 ↓
No ordering
 ↓
No flow control
 ↓
No congestion control
 ↓
8-byte header
```

### Header

```text id="7j7k7f"
Source Port       16
Destination Port  16
Length             16
Checksum           16
----------------------
Total              64 bits = 8 bytes
```

### GATE Priority

**🔥🔥🔥🔥 — High**

Most important areas:

1. UDP header
2. UDP length calculation
3. UDP vs TCP
4. Datagram vs byte stream
5. Checksum vs reliability
