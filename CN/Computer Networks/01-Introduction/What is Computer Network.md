# 06 — Network Models

## 1. Network Model

A **network model** divides communication functions into layers.

Two important models:

* **OSI Model** → 7 layers
* **TCP/IP Model** → 4/5 layers

---

# 2. OSI Model ⭐⭐⭐⭐⭐

**OSI = Open Systems Interconnection**

```text
7. Application
6. Presentation
5. Session
4. Transport
3. Network
2. Data Link
1. Physical
```

### Mnemonic

**A P S T N D P**

> **All People Seem To Need Data Processing**

---

## 3. Layer Responsibilities

| Layer              | Main Function                        | Examples            |
| ------------------ | ------------------------------------ | ------------------- |
| **7 Application**  | Network services to applications     | HTTP, DNS, FTP      |
| **6 Presentation** | Translation, encryption, compression | Encryption/encoding |
| **5 Session**      | Establish/manage sessions            | Session management  |
| **4 Transport**    | End-to-end delivery                  | TCP, UDP            |
| **3 Network**      | Routing & logical addressing         | IP                  |
| **2 Data Link**    | Framing & MAC addressing             | Ethernet            |
| **1 Physical**     | Transmission of bits                 | Cables, signals     |

### Core idea

```text
Application → What application needs
Transport   → End-to-end delivery
Network     → Which network/path?
Data Link   → Which local device?
Physical    → How to transmit bits?
```

---

# 4. TCP/IP Model ⭐⭐⭐⭐⭐

Common 4-layer representation:

```text
Application
Transport
Internet
Network Access
```

Some textbooks use a **5-layer model** by splitting Network Access into:

```text
Application
Transport
Network
Data Link
Physical
```

---

# 5. OSI vs TCP/IP

| OSI                             | TCP/IP                           |
| ------------------------------- | -------------------------------- |
| 7 layers                        | Usually 4 layers                 |
| Reference model                 | Protocol suite/model             |
| Session + Presentation separate | Included in Application          |
| Data Link + Physical separate   | Often combined as Network Access |

### Mapping

```text
OSI                     TCP/IP

Application ─┐
Presentation ├──────→ Application
Session ─────┘

Transport ──────────→ Transport

Network ────────────→ Internet

Data Link ─┐
Physical ──┴────────→ Network Access
```

---

# 6. Important Layer Mapping

### Application

```text
HTTP
DNS
FTP
SMTP
```

### Transport

```text
TCP
UDP
```

### Network / Internet

```text
IP
ICMP
```

### Data Link

```text
Ethernet
Wi-Fi
```

---

# 🔥 GATE Traps

### Trap 1

**IP is NOT a Transport-layer protocol.**

```text
IP  → Network
TCP → Transport
UDP → Transport
```

---

### Trap 2

**MAC address ≠ IP address**

```text
MAC → Data Link
IP  → Network
```

---

### Trap 3

TCP/IP is primarily a **protocol suite**, whereas OSI is primarily a **reference model**.

---

### Trap 4

Don't assume every real-world protocol fits perfectly into one OSI layer. The models are abstractions.

---

# 🧠 First-Principles Trick

Ask **what problem is being solved?**

```text
Bits?
 ↓
Physical

Frame / MAC?
 ↓
Data Link

Packet / IP / Routing?
 ↓
Network

Segment / TCP / Port?
 ↓
Transport

HTTP / DNS / FTP?
 ↓
Application
```

This lets you identify the layer without memorizing everything.

---

# 📌 GATE Quick Revision

```text
OSI:
7 Application
6 Presentation
5 Session
4 Transport
3 Network
2 Data Link
1 Physical
```

```text
TCP/IP:
Application
Transport
Internet
Network Access
```

### Must remember

**TCP → L4**
**IP → L3**
**Ethernet → L2**
**Bits → L1**

### Priority

**GATE: ⭐⭐⭐⭐⭐**
**Placement: ⭐⭐⭐⭐⭐**

This is a **must-master topic**, especially the **layer responsibilities, OSI ↔ TCP/IP mapping, protocols, addresses, and PDU flow**.
