````md id="v8c2m1"
# TCP vs UDP

## 1. Core Difference ⭐⭐⭐⭐⭐

> **TCP = reliability + ordering + connection**
>
> **UDP = simplicity + low overhead + datagrams**

Both operate at the **Transport Layer (L4)**.

---

## 2. TCP vs UDP — Complete Comparison ⭐⭐⭐⭐⭐

| Feature | TCP | UDP |
|---|---|---|
| Full form | Transmission Control Protocol | User Datagram Protocol |
| Layer | L4 | L4 |
| Connection | Connection-oriented | Connectionless |
| Reliability | ✅ Yes | ❌ No |
| Ordering | ✅ Guaranteed | ❌ Not guaranteed |
| ACK | ✅ Yes | ❌ No |
| Retransmission | ✅ Yes | ❌ No |
| Sequence numbers | ✅ Yes | ❌ No |
| Flow control | ✅ Yes | ❌ No |
| Congestion control | ✅ Yes | ❌ No |
| Data type | Byte stream | Datagram |
| Message boundaries | ❌ Not preserved | ✅ Preserved |
| Handshake | 3-way | None |
| Header size | 20–60 bytes | 8 bytes |
| Overhead | Higher | Lower |
| Error detection | Checksum | Checksum |
| Broadcast/Multicast | Not supported directly | Can be used |
| Typical use | Web, SSH, file transfer | DNS, DHCP, real-time apps |

---

# 3. Reliability ⭐⭐⭐⭐⭐

### TCP

```text
Data
 ↓
Sequence Number
 ↓
Receiver
 ↓
ACK
 ↓
If lost → Retransmission
````

Therefore:

> TCP provides **reliable delivery**.

### UDP

```text
Data
 ↓
Send
 ↓
No delivery guarantee
```

UDP itself does not retransmit lost datagrams.

---

# 4. Data Model ⭐⭐⭐⭐⭐

### TCP → Byte Stream

Application:

```text
SEND("ABC")
SEND("DEF")
```

TCP sees:

```text
ABCDEF
```

The receiver might read:

```text
AB
CDE
F
```

Message boundaries are not preserved.

---

### UDP → Datagram

Application:

```text
SEND("ABC")
SEND("DEF")
```

UDP sends:

```text
Datagram 1 = ABC
Datagram 2 = DEF
```

The boundaries are preserved.

🔥 **Very common GATE/placement question.**

---

# 5. Connection

### TCP

Before data transfer:

```text
SYN
 ↓
SYN + ACK
 ↓
ACK
 ↓
Connection established
```

### UDP

No connection establishment:

```text
Send Datagram → Receiver
```

---

# 6. Header Size ⭐⭐⭐⭐⭐

### TCP

Minimum:

```text
20 bytes
```

Maximum:

```text
60 bytes
```

### UDP

Fixed:

```text
8 bytes
```

Therefore:

> UDP has significantly lower transport-layer header overhead.

---

# 7. When to Use TCP?

Use TCP when **reliable and ordered delivery is important**.

Examples:

* HTTP/1.1
* HTTP/2
* HTTPS over TCP
* SSH
* FTP
* Email protocols such as SMTP

Example:

```text
File transfer

Missing 1 byte
     ↓
File becomes incorrect
     ↓
Reliability required
     ↓
TCP
```

---

# 8. When to Use UDP?

UDP is useful when **low overhead, low latency, or application-controlled reliability** is preferred.

Examples:

* DNS
* DHCP
* VoIP
* Online gaming
* Real-time applications
* QUIC

Example:

```text
Live voice

Old packet arrives late
       ↓
Often less useful than
moving forward with newer data
       ↓
UDP can be suitable
```

---

# 9. Important Modern Example: QUIC

A common trap is:

> "All reliable protocols must use TCP."

❌

**QUIC** provides reliable, secure transport functionality over **UDP**.

```text
HTTP/3
  ↓
 QUIC
  ↓
 UDP
  ↓
 IP
```

So:

> UDP itself is unreliable, but an application/transport protocol built over UDP can implement reliability.

---

# 🔥 GATE Traps

### Trap 1

**UDP has no checksum.**

❌

UDP has a **checksum** for error detection.

---

### Trap 2

**TCP is message-oriented.**

❌

TCP = **byte-stream oriented**.

---

### Trap 3

**UDP cannot be used for reliable communication.**

❌

UDP itself does not provide reliability, but another protocol such as **QUIC** can provide reliability over UDP.

---

### Trap 4

**TCP is always slower than UDP.**

⚠️ Don't make this absolute.

TCP has more protocol mechanisms and overhead, but actual performance depends on network conditions and application requirements.

---

### Trap 5

**TCP and UDP use different IP addresses.**

❌

Both use IP.

```text
TCP → IP → Network
UDP → IP → Network
```

---

### Trap 6

**Port numbers belong to TCP only.**

❌

Both TCP and UDP use **16-bit port numbers**.

---

# ⚡ 30-Second Revision

```text
             TCP              UDP
             ↓                 ↓
       Connection          Connectionless
       Reliable            Unreliable
       Ordered             Unordered
       Byte stream         Datagram
       ACK                 No ACK
       Retransmission      No retransmission
       Flow control        No
       Congestion control  No
       20–60 B header      8 B header
       3-way handshake     No handshake
```

### One-line memory trick

> **TCP = Trust, Control, Precision**
> **UDP = Urgent, Direct, Lightweight**

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Especially remember:

1. **TCP = byte stream**
2. **UDP = datagram**
3. **TCP reliability mechanisms**
4. **Header sizes**
5. **Flow/congestion control**
6. **QUIC over UDP**

```
```
