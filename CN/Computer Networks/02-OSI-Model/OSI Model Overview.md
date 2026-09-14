# OSI Model Overview

## 1. What is OSI?

**OSI = Open Systems Interconnection**

It is a **7-layer reference model** developed to standardize network communication.

### Why?

Networking is complex → divide it into **7 manageable functions**.

```text
7  Application
6  Presentation
5  Session
4  Transport
3  Network
2  Data Link
1  Physical
```

---

## 2. First Principle

Each layer has **one primary responsibility** and:

* uses services of the layer below
* provides services to the layer above
* communicates logically with its **peer layer** on another host

```text
Host A                         Host B

Application  ←─────────────→  Application
Presentation ←─────────────→  Presentation
Session      ←─────────────→  Session
Transport    ←─────────────→  Transport
Network      ←─────────────→  Network
Data Link    ←─────────────→  Data Link
Physical     ←─────────────→  Physical
```

Actual data physically travels **down → across → up**.

---

# 3. Seven Layers — Core Function

| Layer              | Main Responsibility                  | Key Terms       |
| ------------------ | ------------------------------------ | --------------- |
| **7 Application**  | Network services to applications     | HTTP, DNS, FTP  |
| **6 Presentation** | Translation, encryption, compression | Encoding        |
| **5 Session**      | Establish/manage sessions            | Dialog control  |
| **4 Transport**    | End-to-end delivery                  | TCP, UDP, ports |
| **3 Network**      | Routing & logical addressing         | IP              |
| **2 Data Link**    | Framing & MAC addressing             | Ethernet        |
| **1 Physical**     | Transmission of raw bits             | Signals, cables |

### Memory

**A P S T N D P**

> **All People Seem To Need Data Processing**

---

# 4. Layer 7 — Application

Provides **network services to user applications**.

Examples:

* HTTP
* DNS
* FTP
* SMTP

### Think:

> **"What does the application want?"**

---

# 5. Layer 6 — Presentation

Responsible for **representation of data**.

Main functions:

* Translation
* Encryption/decryption
* Compression/decompression

### Think:

> **"In what format should the data be represented?"**

---

# 6. Layer 5 — Session

Manages communication sessions/dialogues.

Functions:

* Establish session
* Maintain session
* Terminate session
* Synchronization/checkpoints

### Think:

> **"How do we manage the conversation?"**

---

# 7. Layer 4 — Transport ⭐

Provides **end-to-end/process-to-process communication**.

Important concepts:

* TCP
* UDP
* Port numbers
* Segmentation
* Flow control
* Congestion control
* Reliability

### Think:

> **"How should data reach the correct process?"**

---

# 8. Layer 3 — Network ⭐⭐⭐⭐⭐

Responsible for **packet delivery between networks**.

Main concepts:

* IP addressing
* Routing
* Packet forwarding

### Think:

> **"Which path should the packet take?"**

---

# 9. Layer 2 — Data Link ⭐⭐⭐⭐⭐

Responsible for **node-to-node delivery over a single link**.

Main concepts:

* Frames
* MAC addresses
* Error detection
* Media access control

### Think:

> **"How does data move across this local link?"**

---

# 10. Layer 1 — Physical

Responsible for transmitting **raw bits**.

Deals with:

* Electrical/optical/radio signals
* Cables
* Connectors
* Bit transmission

### Think:

> **"How are 0s and 1s physically transmitted?"**

---

# 11. Addressing by Layer 🔥

| Layer     | Address         |
| --------- | --------------- |
| Transport | **Port number** |
| Network   | **IP address**  |
| Data Link | **MAC address** |

### Memory

**Port → IP → MAC**

As you move downward:

```text
Process
  ↓
IP/network
  ↓
Device/link
```

---

# 12. PDU by Layer 🔥

| Layer        | PDU                |
| ------------ | ------------------ |
| Application  | Data               |
| Presentation | Data               |
| Session      | Data               |
| Transport    | Segment / Datagram |
| Network      | Packet             |
| Data Link    | Frame              |
| Physical     | Bits               |

### Trick

**Segment → Packet → Frame → Bits**

---

# 13. Encapsulation

Sender:

```text
Data
 ↓
[Transport Header + Data]
 ↓
[Network Header + Segment]
 ↓
[Data-Link Header + Packet + Trailer]
 ↓
Bits
```

Receiver performs the reverse:

**Decapsulation**

---

# 14. Most Important GATE Distinctions

### Transport vs Network

```text
Transport → Process-to-process
Network   → Host/network-to-host/network
```

### Network vs Data Link

```text
Network   → End-to-end path across networks
Data Link → Node-to-node across one link
```

### MAC vs IP

```text
MAC → Layer 2
IP  → Layer 3
```

### Port vs IP

```text
Port → identifies application/process
IP   → identifies network-layer endpoint
```

---

# 🔥 GATE Traps

### Trap 1

**Router → Layer 3**

**Switch/Bridge → Layer 2**

**Hub/Repeater → Layer 1**

---

### Trap 2

TCP is **not** Layer 3.

```text
TCP → L4
IP  → L3
```

---

### Trap 3

A layer doesn't necessarily mean **one protocol**.

Example:

```text
Transport
 ├── TCP
 └── UDP
```

---

### Trap 4

OSI is primarily a **reference model**, not a protocol suite.

---

# 🎯 Placement Questions

**Q: What happens when you send data through a network?**

> Data is encapsulated as it moves down the layers, transmitted as bits, then decapsulated as it moves up the receiver's layers.

**Q: Why does a router operate at Layer 3?**

> Because routing decisions use network-layer logical addresses such as IP addresses.

**Q: Switch vs Router?**

> Switch → MAC/frame/L2.
> Router → IP/packet/L3.

---

# ⚡ 30-Second Revision

```text
L7 Application   → Network services
L6 Presentation  → Format / Encryption / Compression
L5 Session       → Session management
L4 Transport     → End-to-end / Ports / TCP-UDP
L3 Network       → IP / Routing
L2 Data Link     → MAC / Frames
L1 Physical      → Bits / Signals
```

### Memorize these 5:

**L7 → Application**

**L4 → TCP/UDP + Port**

**L3 → IP + Routing**

**L2 → MAC + Frame**

**L1 → Bits**

### GATE Priority: ⭐⭐⭐⭐⭐

This is the **base for the entire Computer Networks subject**. Master the layer responsibilities and the **L2/L3/L4 distinctions**; the remaining OSI files will build directly on this.
