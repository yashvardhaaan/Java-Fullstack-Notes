# OSI Interview Questions — Quick Notes

## 1. What is OSI?

**OSI (Open Systems Interconnection)** is a **7-layer reference model** used to understand and standardize network communication.

```text
L7 Application
L6 Presentation
L5 Session
L4 Transport
L3 Network
L2 Data Link
L1 Physical
```

---

## 2. Why use layers?

* Reduce complexity
* Modularity
* Standardization
* Interoperability
* Easier troubleshooting

> **Each layer has a specific responsibility.**

---

## 3. Which layer does what?

| Layer           | Key responsibility                   |
| --------------- | ------------------------------------ |
| L7 Application  | Network services                     |
| L6 Presentation | Translation, encryption, compression |
| L5 Session      | Session management                   |
| L4 Transport    | End-to-end/process delivery          |
| L3 Network      | Routing, IP                          |
| L2 Data Link    | Frames, MAC                          |
| L1 Physical     | Bits/signals                         |

### 🔥 Shortcut

**L4 → Port/TCP**

**L3 → IP/Router**

**L2 → MAC/Switch**

**L1 → Bits/Hub**

---

## 4. TCP vs IP vs Ethernet

```text
TCP      → L4
IP       → L3
Ethernet → L2
```

---

## 5. MAC vs IP vs Port ⭐⭐⭐⭐⭐

| Address | Layer | Identifies                     |
| ------- | ----- | ------------------------------ |
| MAC     | L2    | Interface/device on local link |
| IP      | L3    | Network-layer endpoint         |
| Port    | L4    | Process/application endpoint   |

### Memory

> **MAC → Device/link**

> **IP → Host/network**

> **Port → Process**

---

## 6. Switch vs Router ⭐⭐⭐⭐⭐

### Switch

* Mainly L2
* Uses MAC addresses
* Forwards frames
* Connects devices within LANs

### Router

* Mainly L3
* Uses IP addresses
* Forwards packets
* Connects different networks

```text
Switch → MAC → Frame
Router → IP  → Packet
```

---

## 7. Hub vs Switch

| Hub                       | Switch                                          |
| ------------------------- | ----------------------------------------------- |
| L1                        | L2                                              |
| Sends signal to all ports | Selectively forwards frames                     |
| No MAC learning           | MAC learning                                    |
| One collision domain      | Each switch port is a separate collision domain |

---

## 8. What is encapsulation?

Adding layer-specific control information while data moves **down the sender's stack**.

```text
Data
 ↓
Segment
 ↓
Packet
 ↓
Frame
 ↓
Bits
```

Reverse process = **decapsulation**.

---

## 9. What is a protocol?

A **set of communication rules between peer entities**.

Examples:

```text
HTTP → Application
TCP  → Transport
IP   → Network
Ethernet → Data Link
```

---

## 10. Service vs Protocol

**Service:** what a layer provides to the layer above.

**Protocol:** rules used by peer entities to communicate.

> **Service = WHAT**

> **Protocol = RULES/HOW**

---

## 11. Transport vs Network

### Transport

**Process-to-process**

Uses **port numbers**.

### Network

**Host/network-to-host/network**

Uses **IP addresses**.

```text
L4 → Which process?
L3 → Which host/network?
```

---

## 12. Flow Control vs Congestion Control ⭐⭐⭐⭐⭐

**Flow control:**

> Protects the **receiver** from a fast sender.

**Congestion control:**

> Protects the **network** from excessive traffic.

```text
Flow       → Receiver
Congestion → Network
```

---

## 13. TCP vs UDP

| TCP                     | UDP                            |
| ----------------------- | ------------------------------ |
| Connection-oriented     | Connectionless                 |
| Reliable                | No delivery guarantee          |
| Ordered                 | No ordering guarantee          |
| ACK/retransmission      | No built-in ACK/retransmission |
| Flow/congestion control | No built-in mechanisms         |
| Byte stream             | Datagram                       |

---

## 14. What happens when you type a URL?

Simplified flow:

```text
URL
 ↓
DNS → IP address
 ↓
TCP connection (if applicable)
 ↓
TLS (HTTPS)
 ↓
HTTP request
 ↓
IP routing
 ↓
Ethernet/Wi-Fi
 ↓
Server
```

🔥 **Very common placement question.**

---

# 🎯 10 Questions You Must Be Able to Answer

1. What is the OSI model?
2. Why are networks divided into layers?
3. What is a protocol?
4. What is encapsulation?
5. Difference between MAC and IP?
6. Difference between switch and router?
7. Difference between TCP and UDP?
8. Flow control vs congestion control?
9. What happens when you enter a URL?
10. Explain OSI layers from L1 → L7.

---

# ⚡ Final Revision

```text
L7 → Application → HTTP/DNS
L6 → Presentation → Format/Encryption
L5 → Session → Session management
L4 → Transport → TCP/UDP/Port
L3 → Network → IP/Routing
L2 → Data Link → MAC/Frame
L1 → Physical → Bits/Signals
```

### GATE Priority: ⭐⭐⭐⭐

### Placement Priority: ⭐⭐⭐⭐⭐

**For GATE:** focus on layer mapping and conceptual distinctions.

**For placements:** focus on **"what happens when you type a URL", TCP/IP flow, DNS, HTTP/HTTPS, switch vs router, and MAC/IP/port.**
