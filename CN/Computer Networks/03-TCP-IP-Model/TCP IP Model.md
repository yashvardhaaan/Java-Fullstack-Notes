# TCP/IP Model

## 1. What is TCP/IP?

**TCP/IP = Transmission Control Protocol / Internet Protocol**

It is the **protocol suite used for communication across the Internet and modern networks**.

### First principle

> **TCP/IP organizes networking functions into layers and defines protocols that work together for communication.**

---

# 2. TCP/IP 4-Layer Model ⭐⭐⭐⭐⭐

```text
4. Application
3. Transport
2. Internet
1. Network Access
```

### Layer functions

| Layer              | Main Job                    | Examples             |
| ------------------ | --------------------------- | -------------------- |
| **Application**    | Network services            | HTTP, DNS, FTP, SMTP |
| **Transport**      | Process-to-process delivery | TCP, UDP             |
| **Internet**       | Packet delivery + routing   | IP, ICMP             |
| **Network Access** | Local/link transmission     | Ethernet, Wi-Fi      |

---

# 3. Application Layer

Combines the functions of the OSI:

```text
Application
Presentation
Session
```

Examples:

* HTTP/HTTPS
* DNS
* FTP
* SMTP
* DHCP
* SSH

### Think

> **What does the application need from the network?**

---

# 4. Transport Layer ⭐⭐⭐⭐⭐

Provides **process-to-process communication**.

Main protocols:

```text
TCP
UDP
```

Important concepts:

* Port numbers
* Segmentation
* Reliability
* Flow control
* Congestion control
* Connection management

### Think

> **Which process should receive the data?**

---

# 5. Internet Layer ⭐⭐⭐⭐⭐

Responsible for **logical addressing and routing/forwarding of packets**.

Main protocol:

**IP**

Other important protocol:

**ICMP**

### Think

> **Where should the packet go?**

---

# 6. Network Access Layer

Responsible for communication over the **local network/link**.

Includes functions associated with OSI:

```text
Data Link + Physical
```

Examples:

* Ethernet
* Wi-Fi
* Physical transmission media

### Think

> **How do I move the data over this local link?**

---

# 7. OSI ↔ TCP/IP Mapping ⭐⭐⭐⭐⭐

```text
OSI                         TCP/IP

Application ─┐
Presentation ├──────────→ Application
Session ─────┘

Transport ──────────────→ Transport

Network ────────────────→ Internet

Data Link ─┐
Physical ──┴────────────→ Network Access
```

### 🔥 Memorize

$$
\boxed{3\ OSI\ upper\ layers \rightarrow TCP/IP\ Application}
$$

$$
\boxed{OSI\ Network \rightarrow TCP/IP\ Internet}
$$

$$
\boxed{OSI\ Data\ Link+Physical \rightarrow Network\ Access}
$$

---

# 8. TCP/IP 5-Layer Representation

Some textbooks use a **5-layer Internet model**:

```text
Application
Transport
Network
Data Link
Physical
```

This is essentially the TCP/IP architecture with the Network Access layer split into two.

### GATE Tip

Don't get confused between **4-layer TCP/IP** and **5-layer teaching models**.

The traditional TCP/IP model is commonly represented using **4 layers**.

---

# 9. Encapsulation

TCP/IP also follows encapsulation.

```text
Application
   ↓
Data
   ↓
Transport
   ↓
Segment
   ↓
Internet
   ↓
Packet
   ↓
Network Access
   ↓
Frame
   ↓
Bits
```

---

# 10. Addressing

| Layer          | Address/Identifier |
| -------------- | ------------------ |
| Application    | Domain/URL etc.    |
| Transport      | **Port**           |
| Internet       | **IP address**     |
| Network Access | **MAC address**    |

### Trick

> **Port → IP → MAC**

---

# 11. Why TCP/IP Won Over OSI

OSI is extremely useful as a **reference model**, but TCP/IP became dominant because it is tied to a practical, widely deployed **protocol suite**.

```text
OSI
↓
Mainly reference/learning model

TCP/IP
↓
Practical Internet protocol suite
```

---

# 🔥 GATE Traps

### Trap 1

**TCP/IP is NOT just TCP + IP.**

It is a **suite of many protocols**.

```text
TCP/IP Suite
├── HTTP
├── DNS
├── TCP
├── UDP
├── IP
├── ICMP
├── ARP
└── Ethernet
```

---

### Trap 2

TCP is **not** the Internet layer.

```text
TCP → Transport
IP  → Internet
```

---

### Trap 3

OSI has **7 layers**, traditional TCP/IP has **4 layers**.

---

### Trap 4

TCP/IP Application Layer ≠ only OSI Application Layer.

It generally incorporates:

**OSI Application + Presentation + Session**

---

# ⚡ 30-Second Revision

```text
TCP/IP

L4 Application → HTTP, DNS, FTP
L3 Transport   → TCP, UDP, Port
L2 Internet    → IP, ICMP, Routing
L1 Network     → Ethernet, Wi-Fi, Physical
```

### Core idea

$$
\boxed{\text{TCP/IP = Practical Internet protocol suite}}
$$

### GATE Priority: ⭐⭐⭐⭐⭐

Must know:

**4 layers → responsibilities → OSI mapping → protocols → encapsulation → addressing.**
