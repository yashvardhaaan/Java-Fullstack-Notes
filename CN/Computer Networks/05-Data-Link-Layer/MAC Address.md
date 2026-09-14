# MAC Address

## 1. What is a MAC Address?

**MAC (Media Access Control) address** is a hardware/link-layer address used to identify a network interface on a local network.

> **MAC → Data Link Layer (L2)**

Example:

```text id="7eq4a8"
00:1A:2B:3C:4D:5E
```

---

# 2. MAC Address Size ⭐

Standard Ethernet MAC address:

```text
48 bits = 6 bytes
```

Usually written as:

```text id="l0t7q5"
XX:XX:XX:XX:XX:XX
```

Each hexadecimal digit = 4 bits.

Therefore:

```text id="8ey8hf"
12 hex digits × 4 = 48 bits
```

---

# 3. MAC vs IP Address 🔥

| MAC Address                       | IP Address                    |
| --------------------------------- | ----------------------------- |
| Layer 2                           | Layer 3                       |
| Local/link delivery               | Inter-network delivery        |
| Hardware/link identifier          | Logical address               |
| Used by switches                  | Used by routers               |
| Typically 48-bit Ethernet address | IPv4 = 32-bit, IPv6 = 128-bit |

### Easy Trick

> **Switch → MAC**
> **Router → IP**

---

# 4. Unicast, Multicast, Broadcast

### Unicast

One sender → one receiver.

```text
A ─────→ B
```

### Multicast

One sender → selected group.

```text
       → B
A ─────→ C
       → D
```

### Broadcast

One sender → all devices on the local broadcast domain.

Ethernet broadcast MAC:

```text id="z0nj8g"
FF:FF:FF:FF:FF:FF
```

🔥 Memorize this.

---

# 5. MAC Address Structure

A typical 48-bit MAC address can be viewed as:

```text id="f2gk4n"
First 24 bits       Last 24 bits
     ↓                    ↓
OUI / organization    Interface-specific
```

**OUI = Organizationally Unique Identifier**

It identifies the organization/vendor allocation, while the remaining portion identifies the interface within that allocation.

---

# 6. MAC Address Is Used on a Local Link

Suppose:

```text
PC A → Router → Server
```

The MAC addresses are relevant to **each individual link**.

Conceptually:

```text id="v9e0aa"
PC A
 ↓
MAC_A → MAC_Router
 ↓
Router
 ↓
MAC_Router → MAC_NextHop
```

The **IP destination can remain the end destination**, while the **L2/MAC destination changes hop-by-hop**.

🔥 This is a very important GATE concept.

---

# 7. MAC Address and ARP

For IPv4 on an Ethernet-like LAN, **ARP** can be used to discover the MAC address corresponding to a local IPv4 address.

Example:

```text id="qv5n9r"
Who has 192.168.1.10?
        ↓
     ARP Request
        ↓
192.168.1.10 → MAC address
```

So:

> **ARP maps IPv4 address → MAC address on the local network.**

---

# 8. MAC Address Table

A switch maintains a **MAC address table**.

Example:

| MAC Address | Port   |
| ----------- | ------ |
| MAC-A       | Port 1 |
| MAC-B       | Port 2 |
| MAC-C       | Port 4 |

The switch learns MAC addresses from the **source MAC address of incoming frames**.

Then it uses the **destination MAC address** to decide where to forward the frame.

---

# 🔥 GATE Traps

### Trap 1

**MAC address identifies a device globally across the Internet.**

❌ No.

MAC is primarily relevant to the **local link/LAN**.

---

### Trap 2

**Router forwards using MAC address.**

❌ Routing/forwarding decisions are based primarily on **IP/network-layer information**.

---

### Trap 3

**Switch learns from destination MAC.**

❌

> Switch learns from **source MAC**.

---

### Trap 4

Broadcast MAC:

```text id="n1b6jy"
FF:FF:FF:FF:FF:FF
```

---

# ⚡ 30-Second Revision

```text id="a0u5cx"
MAC ADDRESS
     ↓
Data Link Layer (L2)
     ↓
Ethernet → 48 bits
     ↓
Switch uses MAC
     ↓
Router uses IP

Unicast    → one
Multicast  → group
Broadcast  → all local devices

Broadcast MAC:
FF:FF:FF:FF:FF:FF

Switch:
Learn → Source MAC
Forward → Destination MAC
```

### GATE Priority

**MAC vs IP → 🔥🔥🔥🔥🔥**
**Switch MAC learning → 🔥🔥🔥🔥🔥**
**Unicast/Multicast/Broadcast → 🔥🔥🔥🔥**
**ARP + MAC → 🔥🔥🔥🔥🔥**
