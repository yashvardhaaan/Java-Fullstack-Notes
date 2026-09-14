# Network Layer — OSI Layer 3

## 1. What is the Network Layer?

**L3 = delivers packets from source network to destination network.**

```text
Host A → Router → Router → Router → Host B
          └──── Network Layer ────┘
```

### First principle

> **L3 answers: "Where is the destination, and which path should the packet take?"**

---

## 2. Main Responsibilities ⭐⭐⭐⭐⭐

* **Logical addressing → IP**
* **Routing → finding a path**
* **Forwarding → sending packet to next hop**
* Packet delivery between different networks
* Fragmentation/reassembly in IPv4

---

## 3. IP Address ⭐⭐⭐⭐⭐

IP address is a **logical address** used to identify a network-layer endpoint.

Example:

```text
192.168.1.10
```

### MAC vs IP

```text
MAC → L2 → local/link delivery
IP  → L3 → routing across networks
```

---

## 4. Routing ⭐⭐⭐⭐⭐

**Routing = determining the path from source to destination.**

Example:

```text
A
 ↓
R1 → R2 → R3
          ↓
          B
```

Router decides:

> **Which next hop should I use?**

Routing protocols include:

* RIP
* OSPF
* BGP

---

## 5. Forwarding vs Routing 🔥

These are frequently confused.

### Routing

**Control-plane decision:**

> Which path should be used?

### Forwarding

**Data-plane action:**

> Send this packet to the selected next hop/interface.

```text
Routing   → Build/choose path
Forwarding → Actually move packet
```

---

## 6. Packet

L3 receives a segment from Transport Layer and creates a packet/datagram.

```text
[TCP Header][Data]
       ↓
[IP Header][TCP Header][Data]
```

So:

> **IP packet contains the transport-layer segment.**

---

## 7. Router

A router primarily operates at **L3**.

It examines the **destination IP address** and uses its forwarding table to decide where to send the packet.

```text
Network A
    ↓
 Router
    ↓
Network B
```

### Key

**Router → IP → Packet → L3**

---

## 8. Network-to-Network Delivery

Consider:

```text
A ── R1 ── R2 ── B
```

### L3

Thinks about the **overall destination**:

```text
A → B
```

### L2

Handles each individual link:

```text
A → R1
R1 → R2
R2 → B
```

This distinction is **very important for GATE**.

---

# 9. IPv4 Addressing

IPv4 uses **32-bit addresses**.

Example:

```text
192.168.1.10
```

Written as four decimal octets:

```text
192 . 168 . 1 . 10
 8     8    8    8
        = 32 bits
```

---

## 10. Network Part + Host Part

An IP address can conceptually be divided into:

```text
[ Network Part ][ Host Part ]
```

The subnet mask/prefix determines the division.

Example:

```text
192.168.1.10/24
```

```text
Network = 192.168.1.0
Host    = 10
```

### GATE

CIDR/subnetting is **high priority**.

---

# 11. Important L3 Protocols

| Protocol | Purpose                       |
| -------- | ----------------------------- |
| **IP**   | Packet delivery/routing       |
| **ICMP** | Error reporting/diagnostics   |
| **ARP**  | IPv4 address → MAC resolution |
| **OSPF** | Routing                       |
| **RIP**  | Routing                       |
| **BGP**  | Inter-domain routing          |

⚠️ **ARP is commonly associated with the boundary between L2 and L3**; don't blindly force every protocol into a single OSI layer.

---

# 12. Fragmentation

In IPv4, a packet may need fragmentation if it is too large for the outgoing link's **MTU**.

```text
Large IP packet
      ↓
 Fragment
 ┌────┬────┬────┐
 F1   F2   F3
```

The destination can reassemble the fragments.

### GATE

Know:

* MTU
* Fragmentation
* Fragment offset
* Identification
* Don't Fragment (DF)
* More Fragments (MF)

---

# 🔥 GATE Traps

### Trap 1

```text
MAC → L2
IP  → L3
Port → L4
```

---

### Trap 2

**Routing ≠ Forwarding**

```text
Routing   → path determination
Forwarding → packet movement
```

---

### Trap 3

**Router ≠ Switch**

```text
Switch → MAC/frame
Router → IP/packet
```

---

### Trap 4

L3 is not responsible for **process-to-process** delivery.

That's Transport Layer.

```text
L3 → Host/network delivery
L4 → Process-to-process delivery
```

---

# ⚡ 30-Second Revision

```text
L3 NETWORK
│
├── IP Address
├── Packet
├── Routing
├── Forwarding
├── Inter-network delivery
├── IPv4 fragmentation
└── Router
```

### Core formula

$$
\boxed{L3 = IP + Routing + Forwarding}
$$

### Most important distinction

> **L2 moves a frame across one link.**

> **L3 moves a packet across multiple interconnected networks.**

### Priority

**GATE: ⭐⭐⭐⭐⭐**
**Placement: ⭐⭐⭐⭐⭐**

🔥 **Do not just memorize this layer.** The high-scoring parts coming from L3 are **IPv4 addressing → subnetting → CIDR → routing → ARP/ICMP → fragmentation**.
