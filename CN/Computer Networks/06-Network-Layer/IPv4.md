# IPv4

## 1. What is IPv4?

**IPv4 = Internet Protocol version 4**

It is a **Network Layer (L3)** protocol used for logical addressing and packet delivery across interconnected networks.

```text id="2j1xq8"
IPv4 Address = 32 bits = 4 bytes
```

Example:

```text id="1m3l2r"
192.168.1.10
```

---

# 2. IPv4 Address Format ⭐⭐⭐⭐⭐

32 bits are divided into **4 octets**:

```text id="9h6w1k"
11000000.10101000.00000001.00001010
    192     168       1        10
```

Each octet:

```text id="g3u0k2"
8 bits → 0 to 255
```

Therefore:

```text id="4v8q7n"
2³² ≈ 4.29 billion
```

possible IPv4 addresses.

---

# 3. IPv4 Header ⭐⭐⭐⭐⭐

Minimum IPv4 header size:

```text id="r8d0c1"
20 bytes
```

Maximum:

```text id="x2q6m8"
60 bytes
```

because the **IHL** field is measured in 32-bit words.

```text id="1q4f8s"
Minimum IHL = 5
5 × 4 = 20 bytes
```

```text id="n5f9ba"
Maximum IHL = 15
15 × 4 = 60 bytes
```

---

# 4. Important IPv4 Header Fields

| Field           | Purpose                         |
| --------------- | ------------------------------- |
| Version         | IPv4 = 4                        |
| IHL             | Header length                   |
| Total Length    | Entire IP packet size           |
| Identification  | Fragment identification         |
| Flags           | Fragmentation control           |
| Fragment Offset | Fragment position               |
| TTL             | Limits packet lifetime          |
| Protocol        | Identifies upper-layer protocol |
| Header Checksum | Checks IPv4 header              |
| Source IP       | Sender                          |
| Destination IP  | Receiver                        |

🔥 For GATE, focus especially on:

**TTL, Protocol, Total Length, Fragmentation fields, Header Checksum.**

---

# 5. TTL ⭐⭐⭐⭐⭐

**TTL = Time To Live**

It prevents packets from circulating indefinitely due to routing loops.

At each router:

```text id="l1n8bh"
TTL = TTL − 1
```

If TTL reaches zero, the packet is discarded.

The router typically sends an **ICMP Time Exceeded** message.

### Important

TTL is effectively a **hop limit**, not literally a timer in modern forwarding behavior.

---

# 6. Protocol Field ⭐⭐⭐⭐⭐

The IPv4 **Protocol** field identifies the next-layer protocol carried inside the IP packet.

Examples:

```text id="h9x2e4"
TCP  → 6
UDP  → 17
ICMP → 1
```

Conceptually:

```text id="g7m1k5"
IPv4 Packet
     ↓
Protocol field
     ↓
TCP / UDP / ICMP
```

---

# 7. Total Length

The **Total Length** field includes:

```text id="5o4c9z"
IPv4 Header + Payload
```

Maximum IPv4 packet size:

```text id="5h5u8q"
65,535 bytes
```

because Total Length is a **16-bit field**.

---

# 8. Fragmentation ⭐⭐⭐⭐⭐

IPv4 can fragment a packet when it is too large for the outgoing link's **MTU**, subject to fragmentation controls.

Important fields:

```text id="x1s4r7"
Identification
Flags
Fragment Offset
```

### Flags

Important bits:

* **DF = Don't Fragment**
* **MF = More Fragments**

---

# 9. Fragment Offset 🔥

Fragment Offset is measured in:

```text id="5q4m0w"
8-byte units
```

🔥 **Very important GATE numerical concept.**

Therefore, except for the final fragment, fragment payload sizes generally need to be multiples of **8 bytes**.

---

# 10. IPv4 Fragmentation Example

Suppose:

```text id="2eq2a8"
Original IP packet = 4000 bytes
MTU = 1500 bytes
IPv4 header = 20 bytes
```

Maximum payload per fragment:

```text id="0cnz4x"
1500 − 20 = 1480 bytes
```

So payload can be divided as:

```text id="j3k5l8"
Fragment 1 → 1480
Fragment 2 → 1480
Fragment 3 → 1040
```

Total:

```text id="0p4p9b"
1480 + 1480 + 1040 = 4000
```

Each fragment gets its own IPv4 header.

---

# 11. Header Checksum

IPv4 has a **header checksum**.

It checks:

> **Only the IPv4 header**, not the entire packet payload.

Routers update/recalculate it because fields such as TTL change.

🔥 Don't confuse this with:

* TCP checksum
* UDP checksum
* Ethernet FCS

---

# 12. IPv4 vs IPv6

| IPv4                          | IPv6                    |
| ----------------------------- | ----------------------- |
| 32-bit address                | 128-bit address         |
| Header minimum 20 B           | Base header 40 B        |
| Header checksum               | No base-header checksum |
| Router fragmentation possible | Routers do not fragment |
| Broadcast supported           | No broadcast            |
| Uses ARP commonly             | Uses Neighbor Discovery |

---

# 🔥 GATE Traps

### Trap 1

**IPv4 header checksum checks the whole packet.**

❌

> It checks the **IPv4 header only**.

---

### Trap 2

**Fragment Offset is measured in bytes.**

❌

> Measured in **8-byte units**.

---

### Trap 3

**TTL is the remaining time in seconds.**

❌

Think:

> **TTL ≈ hop limit**

---

### Trap 4

**Protocol field specifies the destination IP.**

❌

It identifies the **upper-layer protocol**.

---

### Trap 5

**IPv4 maximum packet size = 1500 bytes.**

❌

1500 bytes is a common Ethernet MTU.

IPv4 Total Length can be up to:

```text id="l8r0xm"
65,535 bytes
```

---

# ⚡ 30-Second Revision

```text id="w2y7s1"
IPv4
 ↓
L3
 ↓
32-bit address

Header:
Min = 20 B
Max = 60 B

Total Length:
Header + Payload
Max = 65,535 B

TTL:
Decrement at routers

Protocol:
TCP = 6
UDP = 17
ICMP = 1

Fragmentation:
ID + Flags + Offset
Offset → 8-byte units

Header Checksum:
IPv4 header only
```

### GATE Priority

**Fragmentation → 🔥🔥🔥🔥🔥**
**IPv4 header → 🔥🔥🔥🔥🔥**
**TTL → 🔥🔥🔥🔥**
**Addressing → 🔥🔥🔥🔥🔥**
**Header checksum → 🔥🔥🔥**
