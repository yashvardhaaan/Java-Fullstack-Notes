# Ethernet

## 1. What is Ethernet?

**Ethernet (IEEE 802.3)** is the most widely used **LAN technology**.

> Ethernet mainly operates at **Data Link Layer (L2)**, with physical-layer specifications also defined by Ethernet standards.

---

# 2. Ethernet Frame ⭐⭐⭐⭐⭐

Basic Ethernet frame:

```text id="f7v1gc"
┌─────────┬───────┬─────────┬────────────┬──────┬──────┐
│Preamble │  SFD  │ Dest MAC│ Source MAC │ Type │ Data │
└─────────┴───────┴─────────┴────────────┴──────┴──────┘
                                             ↓
                                          Payload
                                  + FCS at the end
```

### Important fields

| Field           |          Size | Purpose                                  |
| --------------- | ------------: | ---------------------------------------- |
| Preamble        |       7 bytes | Synchronization                          |
| SFD             |        1 byte | Start Frame Delimiter                    |
| Destination MAC |       6 bytes | Receiver                                 |
| Source MAC      |       6 bytes | Sender                                   |
| Type/Length     |       2 bytes | Identifies upper-layer protocol / length |
| Data + Padding  | 46–1500 bytes | Payload                                  |
| FCS             |       4 bytes | Error detection (CRC)                    |

🔥 **GATE must know these sizes.**

---

# 3. Ethernet Frame Size ⭐⭐⭐⭐⭐

Standard Ethernet:

```text id="o6qvra"
Minimum = 64 bytes
Maximum = 1518 bytes
```

These sizes **exclude the 8-byte preamble + SFD**.

### Why minimum 64 bytes?

Historically, for shared half-duplex Ethernet using CSMA/CD:

> The sender needed to remain transmitting long enough to detect a worst-case collision.

---

# 4. Ethernet MTU

Typical Ethernet payload:

```text id="r9i7aq"
46 to 1500 bytes
```

The commonly used Ethernet **MTU = 1500 bytes**.

⚠️ MTU refers to the maximum **IP packet payload carried by Ethernet**, not the complete Ethernet frame.

```text id="3ct1sd"
Ethernet Frame
┌──────────────────────────────┐
│ Header │ IP Packet │ FCS    │
└──────────────────────────────┘
          ↑
       ≤ 1500 B
```

---

# 5. MAC Address

Ethernet uses **48-bit MAC addresses**.

```text id="i8v9lb"
Destination MAC
Source MAC
```

Example:

```text id="l5emh3"
AA:BB:CC:DD:EE:FF
```

---

# 6. Ethernet Switch ⭐⭐⭐⭐⭐

Modern Ethernet networks commonly use **switches**.

```text id="9vux0v"
PC A ──┐
PC B ──┼── Switch ── Router
PC C ──┘
```

The switch:

1. Learns **source MAC → incoming port**
2. Looks up destination MAC
3. Forwards the frame to the appropriate port

---

# 7. Collision Domain

With a switch:

```text id="zj4g0c"
PC A ── Port 1
PC B ── Port 2
PC C ── Port 3
```

Each switch port represents a separate **collision domain**.

Modern switched Ethernet usually operates in **full-duplex**, so collisions do not normally occur.

---

# 8. Broadcast Domain

A normal Layer-2 switch generally forwards broadcasts within the same broadcast domain.

A **router separates broadcast domains**.

```text id="v3y6o9"
LAN 1 ── Router ── LAN 2
       ↑
Broadcast boundary
```

🔥 Common GATE/interview question:

> **Switch → separates collision domains**
> **Router → separates broadcast domains**

---

# 9. Ethernet and CSMA/CD

### Old/shared Ethernet

```text
Shared medium
     ↓
CSMA/CD
```

### Modern switched full-duplex Ethernet

```text
Dedicated switch link
       ↓
Full duplex
       ↓
No collisions
       ↓
CSMA/CD not required
```

This distinction is **very important**.

---

# 10. Ethernet Standards

Examples:

| Standard   | Approx. Speed |
| ---------- | ------------: |
| 10BASE-T   |       10 Mbps |
| 100BASE-TX |      100 Mbps |
| 1000BASE-T |        1 Gbps |
| 10GBASE-T  |       10 Gbps |

### Naming idea

```text id="m5yq3e"
10BASE-T

10  → 10 Mbps
BASE → Baseband
T   → Twisted pair
```

---

# 🔥 GATE Traps

### Trap 1

**Ethernet frame maximum = 1500 bytes**

❌ Wrong.

1500 bytes is the typical **payload/MTU**.

```text
Frame = 1518 bytes maximum
Payload = 1500 bytes maximum
```

---

### Trap 2

**Modern Ethernet always uses CSMA/CD.**

❌ No.

Full-duplex switched Ethernet does not normally have collisions.

---

### Trap 3

**FCS provides error correction.**

❌ No.

FCS uses **CRC for error detection**.

---

### Trap 4

**Switch forwards based on source MAC.**

❌

```text
Source MAC → learning
Destination MAC → forwarding decision
```

---

# ⚡ 30-Second Revision

```text id="j8v6c5"
ETHERNET
   ↓
IEEE 802.3
   ↓
LAN technology
   ↓
48-bit MAC addresses

Frame:
Preamble  7 B
SFD       1 B
Dst MAC   6 B
Src MAC   6 B
Type      2 B
Data      46–1500 B
FCS       4 B

Frame:
Min = 64 B
Max = 1518 B

MTU = 1500 B

Modern switched Ethernet:
Full duplex → no collisions → CSMA/CD unnecessary
```

### GATE Priority

**Ethernet Frame → 🔥🔥🔥🔥🔥**
**Frame size / MTU → 🔥🔥🔥🔥🔥**
**MAC learning → 🔥🔥🔥🔥🔥**
**CSMA/CD connection → 🔥🔥🔥🔥**
**Collision/Broadcast domains → 🔥🔥🔥🔥🔥**
