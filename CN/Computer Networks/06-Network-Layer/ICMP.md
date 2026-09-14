# ICMP

## 1. What is ICMP?

**ICMP = Internet Control Message Protocol**

ICMP is used with IP networks for:

* Error reporting
* Network diagnostics
* Control/informational messages

> **ICMP does not carry application data like TCP/UDP.**

---

# 2. Layer

ICMP is associated with the **Network Layer (L3)**.

```text
Application
    ↓
TCP / UDP
    ↓
IP
    ↓
ICMP
```

For IPv4:

> **ICMP is carried inside an IPv4 packet.**

---

# 3. Why ICMP is Needed?

IP itself is a **best-effort** protocol.

When something goes wrong, a router/host may need to report the problem.

Example:

```text id="w5z2q8"
Host A → Router → ❌ Destination
                    ↓
              ICMP message
                    ↓
                  Host A
```

---

# 4. Important ICMP Messages ⭐⭐⭐⭐⭐

### Echo Request / Echo Reply

Used by **ping**.

```text id="5s8k1q"
Host A ── Echo Request ──→ Host B
Host A ←── Echo Reply ─── Host B
```

Used to test:

> **Reachability + round-trip time**

---

### Destination Unreachable

Sent when a destination cannot be reached or a particular delivery condition fails.

Example:

```text id="m8v4c2"
Destination unreachable
        ↓
ICMP error message
```

---

### Time Exceeded ⭐⭐⭐⭐⭐

Used when the IPv4 **TTL reaches zero** during forwarding.

```text id="2x6n9a"
TTL = 0
 ↓
Packet discarded
 ↓
ICMP Time Exceeded
```

This is important for **traceroute/tracert**.

---

### Redirect

Can inform a host about a potentially better next hop for a destination on the local network.

---

# 5. Ping

`ping` uses:

```text id="p4k7s1"
ICMP Echo Request
        ↓
       Host
        ↓
ICMP Echo Reply
```

It helps determine whether a host is reachable and measures round-trip delay.

⚠️ A failed ping does **not necessarily prove** that the destination host is down; ICMP may be filtered or blocked.

---

# 6. Traceroute ⭐⭐⭐⭐⭐

Traceroute discovers the path toward a destination by using packets with progressively increasing TTL values.

Conceptually:

```text id="j5m2v8"
TTL = 1 → Router 1 responds
TTL = 2 → Router 2 responds
TTL = 3 → Router 3 responds
...
```

When a router decrements TTL to zero:

```text id="x9q3k6"
TTL = 0
 ↓
Discard packet
 ↓
ICMP Time Exceeded
```

Thus traceroute can discover intermediate routers.

---

# 7. ICMP vs TCP/UDP

| ICMP                                      | TCP                | UDP                      |
| ----------------------------------------- | ------------------ | ------------------------ |
| Network-layer control/diagnostic protocol | Transport          | Transport                |
| Error/control messages                    | Reliable transport | Connectionless transport |
| No port numbers                           | Uses ports         | Uses ports               |
| Used by ping/traceroute mechanisms        | Web, etc.          | DNS, streaming, etc.     |

🔥 **ICMP does not use TCP or UDP port numbers.**

---

# 8. ICMP Error Messages

An ICMP error message generally includes information about the packet that caused the error so the sender can identify the relevant flow.

For classic ICMPv4 error messages, part of the original IP packet is included.

---

# 9. ICMPv4 vs ICMPv6

| ICMPv4                  | ICMPv6                         |
| ----------------------- | ------------------------------ |
| Used with IPv4          | Used with IPv6                 |
| IPv4 diagnostics/errors | IPv6 diagnostics/errors        |
| ARP is separate in IPv4 | Neighbor Discovery uses ICMPv6 |

🔥 ICMPv6 is especially important because **Neighbor Discovery Protocol (NDP)** is built using ICMPv6.

---

# 🔥 GATE Traps

### Trap 1

**Ping uses TCP.**

❌

> Ping uses **ICMP Echo Request/Reply**.

---

### Trap 2

**ICMP is a transport-layer protocol.**

❌

> ICMP → associated with **Network Layer**.

---

### Trap 3

**ICMP uses port numbers.**

❌

Ports belong to **TCP/UDP**.

---

### Trap 4

**TTL reaching zero causes the packet to continue.**

❌

```text
TTL → 0
 ↓
Discard
 ↓
ICMP Time Exceeded
```

---

### Trap 5

**Traceroute directly asks every router for its address.**

❌

It exploits **TTL expiration and resulting responses** to identify hops.

---

# ⚡ 30-Second Revision

```text id="n7c4x1"
ICMP
 ↓
Network Layer
 ↓
Error + Control + Diagnostics

Important:
├── Echo Request/Reply → ping
├── Destination Unreachable
├── Time Exceeded → traceroute
└── Redirect

No TCP/UDP ports

TTL reaches 0
    ↓
Packet discarded
    ↓
ICMP Time Exceeded

IPv4 → ICMPv4
IPv6 → ICMPv6
```

### GATE Priority

**ICMP + TTL → 🔥🔥🔥🔥🔥**
**Ping → 🔥🔥🔥🔥**
**Traceroute → 🔥🔥🔥🔥🔥**
**ICMP vs TCP/UDP → 🔥🔥🔥🔥**
