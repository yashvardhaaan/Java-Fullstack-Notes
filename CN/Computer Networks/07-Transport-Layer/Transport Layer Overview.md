````md
# Transport Layer Overview

## 1. Definition

The **Transport Layer (Layer 4)** provides **process-to-process communication** between applications running on different hosts.

> Network Layer = **host-to-host**  
> Transport Layer = **process-to-process**

---

## 2. Why do we need Transport Layer?

Suppose your computer is simultaneously using:

```text
Browser → Web server
WhatsApp → WhatsApp server
SSH → Remote server
````

All these applications use the same IP address.

The Transport Layer uses **port numbers** to identify the correct application/process.

```text
IP Address  → Which host?
Port Number → Which process/application?
```

Example:

```text
192.168.1.10 : 443
      ↑         ↑
     Host      Process
```

---

## 3. Major Functions ⭐⭐⭐⭐⭐

| Function                    | Purpose                             |
| --------------------------- | ----------------------------------- |
| Process-to-process delivery | Deliver data to correct application |
| Port addressing             | Identify processes                  |
| Segmentation                | Divide application data             |
| Reassembly                  | Reconstruct data at receiver        |
| Reliability                 | Ensure delivery when supported      |
| Flow control                | Protect receiver from overload      |
| Congestion control          | Protect network from overload       |
| Connection management       | Establish/terminate connections     |
| Multiplexing                | Multiple applications share network |

---

## 4. Transport Layer PDU

Depending on protocol:

### TCP

```text
Application Data
      ↓
TCP Segment
```

### UDP

```text
Application Data
      ↓
UDP Datagram
```

🔥 **TCP → Segment**
🔥 **UDP → Datagram**

---

## 5. Port Numbers ⭐⭐⭐⭐⭐

Port number identifies the **process/service**.

Port range:

```text
0 – 65535
```

because:

```text
Port = 16 bits
2¹⁶ = 65536
```

Common ports:

| Protocol |  Port |
| -------- | ----: |
| FTP      | 20/21 |
| SSH      |    22 |
| SMTP     |    25 |
| DNS      |    53 |
| DHCP     | 67/68 |
| HTTP     |    80 |
| POP3     |   110 |
| IMAP     |   143 |
| HTTPS    |   443 |

---

## 6. TCP vs UDP

The two major transport protocols are:

```text
Transport Layer
      │
      ├── TCP
      │
      └── UDP
```

### TCP

* Connection-oriented
* Reliable
* Ordered
* ACK + retransmission
* Flow control
* Congestion control
* Byte-stream

### UDP

* Connectionless
* No delivery guarantee
* No ordering guarantee
* No retransmission by UDP
* No flow control by UDP
* No congestion control by UDP
* Datagram-oriented
* Low overhead

---

## 7. Reliability

TCP provides reliable data transfer using:

```text
Sequence Numbers
       +
ACKs
       +
Retransmission
       +
Timers
```

Example:

```text
Sender ── Segment 1 ──→ Receiver
Sender ←──── ACK ────── Receiver
```

If ACK doesn't arrive:

```text
Timeout
   ↓
Retransmit
```

UDP itself does **not** provide this reliability.

---

## 8. Flow Control vs Congestion Control ⭐⭐⭐⭐⭐

### Flow Control

Protects the **receiver**.

```text
Sender ─────────→ Receiver
                  ↑
             "I can handle
               this much"
```

### Congestion Control

Protects the **network**.

```text
Sender → Routers → Receiver
           ↑
      Network congestion
```

🔥 Remember:

> **Flow control = Receiver problem**
> **Congestion control = Network problem**

---

## 9. Multiplexing & Demultiplexing

### Multiplexing

Many applications → one host/network interface.

```text
App A ─┐
App B ─┼──→ Transport Layer ──→ Network
App C ─┘
```

### Demultiplexing

Transport layer uses **port numbers** to deliver incoming data to the correct process.

```text
Network
   ↓
Transport
   ↓
Port Number
   ↓
Correct Application
```

---

## 10. Connection Management

TCP uses connection management:

```text
Connection Establishment
        ↓
     Data Transfer
        ↓
Connection Termination
```

Important mechanisms:

* **3-way handshake** → connection establishment
* **4-way handshake** → typical TCP connection termination

---

# 🔥 GATE Traps

* Transport layer = **process-to-process**, not simply host-to-host.
* IP address identifies the **host**; port identifies the **process/service**.
* TCP is **byte-stream**, not message-oriented.
* UDP preserves **datagram/message boundaries**.
* Flow control protects the **receiver**.
* Congestion control protects the **network**.
* TCP provides reliability; UDP does not inherently provide reliable delivery.
* TCP and UDP are **Transport Layer** protocols.
* TCP uses **segments**; UDP uses **datagrams**.
* Port number = **16 bits**.

---

# ⚡ 30-Second Revision

```text
Transport Layer = L4

Main job:
Process → Process

Address:
IP   → Host
Port → Process

Protocols:
TCP → Reliable, ordered, connection-oriented
UDP → Connectionless, lightweight, datagram

Functions:
✓ Segmentation
✓ Reassembly
✓ Port addressing
✓ Multiplexing
✓ Reliability
✓ Flow control
✓ Congestion control
✓ Connection management
```

### GATE Priority

**Very High 🔥🔥🔥🔥🔥**

Transport Layer is one of the **highest-value CN areas for GATE**, especially:

```text
TCP
↓
Sliding Window
↓
Flow Control
↓
Congestion Control
↓
Handshake
↓
Numericals
```

```
```
