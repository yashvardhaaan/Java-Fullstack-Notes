# ARP

## 1. What is ARP?

**ARP = Address Resolution Protocol**

ARP is used in IPv4 networks to discover the **MAC address corresponding to an IPv4 address** on the local network.

> **ARP: IP address → MAC address**

Example:

```text
IP known: 192.168.1.20
       ↓
     ARP
       ↓
MAC found: AA:BB:CC:DD:EE:FF
```

---

# 2. Why is ARP Needed?

Suppose:

```text
PC A
IP  = 192.168.1.10
MAC = MAC-A

PC B
IP  = 192.168.1.20
MAC = MAC-B
```

PC A wants to send an Ethernet frame to PC B.

It knows:

```text
Destination IP = 192.168.1.20
```

but needs:

```text
Destination MAC = MAC-B
```

So it uses **ARP**.

---

# 3. ARP Working ⭐⭐⭐⭐⭐

### Step 1 — ARP Request

A sends:

```text
Who has 192.168.1.20?
Tell 192.168.1.10
```

The request is sent as an **Ethernet broadcast**.

```text
Destination MAC:
FF:FF:FF:FF:FF:FF
```

---

### Step 2 — ARP Reply

The device owning `192.168.1.20` replies:

```text
192.168.1.20 is at MAC-B
```

The reply is normally **unicast** to the requester.

---

### Step 3 — Cache

PC A stores the mapping in its **ARP cache/table**:

```text
192.168.1.20 → MAC-B
```

It can then send the Ethernet frame.

---

# 4. ARP Request vs Reply 🔥

| ARP Request        | ARP Reply                |
| ------------------ | ------------------------ |
| Usually broadcast  | Usually unicast          |
| "Who has this IP?" | "That IP is at this MAC" |
| Sent by requester  | Sent by owner of IP      |

### Easy Trick

```text
Request → Broadcast
Reply   → Unicast
```

---

# 5. ARP Works Only on Local Network ⭐⭐⭐⭐⭐

ARP does **not** find the MAC address of a remote Internet server.

Example:

```text
PC → Router → Internet → Server
```

If the server is on another network:

```text
PC
 ↓
ARP for default gateway's MAC
 ↓
Router
 ↓
...
```

The PC uses the **router/default gateway's MAC** for the first Ethernet hop.

🔥 This is a very important GATE concept.

---

# 6. IP vs MAC During Routing

Suppose:

```text
A → R1 → R2 → B
```

The **destination IP** can remain B's IP throughout the routed journey.

But the **Layer-2 destination MAC** is changed for each link.

Conceptually:

```text
A → R1
MAC destination = R1

R1 → R2
MAC destination = R2

R2 → B
MAC destination = B
```

Therefore:

> **IP = end-to-end logical destination**
> **MAC = next-hop/local-link delivery**

---

# 7. ARP Cache

Devices maintain recently learned mappings:

```text
IP Address       MAC Address
192.168.1.1  →   AA:AA:AA:AA:AA:AA
192.168.1.20 →   BB:BB:BB:BB:BB:BB
```

This avoids sending an ARP request every time.

Entries can **expire** and be refreshed.

---

# 8. Gratuitous ARP

A device can send an ARP message announcing its own IP/MAC mapping.

Common purposes include:

* Updating other devices' ARP caches
* Detecting duplicate IPv4 addresses
* Announcing a changed MAC/IP association

---

# 9. ARP vs RARP

| ARP                         | RARP                                |
| --------------------------- | ----------------------------------- |
| IP → MAC                    | MAC → IP                            |
| Common IPv4 mechanism       | Obsolete                            |
| Used for address resolution | Historically used by diskless hosts |
| Still relevant              | Replaced by DHCP/BOOTP              |

🔥 Memorize:

```text
ARP  → IP → MAC
RARP → MAC → IP
```

---

# 10. ARP and Network Layers

ARP is often described as a **Layer 2/Layer 3 boundary protocol** because it connects:

```text
IPv4 address
     ↕
MAC address
```

For GATE, the safest association is:

> **ARP is used with IPv4 to resolve a local IP address to a MAC address.**

---

# 🔥 GATE Traps

### Trap 1

**ARP maps MAC → IP.**

❌

```text
ARP → IP → MAC
```

---

### Trap 2

**ARP request is unicast.**

❌ Normally:

```text
Request → Broadcast
Reply   → Unicast
```

---

### Trap 3

**To send to a remote server, the host ARPs for the server's MAC.**

❌

It ARPs for the **next hop**, usually the default gateway.

---

### Trap 4

**ARP is used by routers to determine Internet routes.**

❌

ARP resolves **local IPv4 → MAC**. Routing determines the path.

---

# ⚡ 30-Second Revision

```text
ARP
 ↓
IPv4 address → MAC address
 ↓
Local network only

Request:
Broadcast
"Who has IP X?"

Reply:
Usually Unicast
"IP X is at MAC Y"

Cache:
IP → MAC

Remote destination:
ARP → Default Gateway MAC

RARP:
MAC → IP
```

### GATE Priority

**ARP working → 🔥🔥🔥🔥🔥**
**ARP request/reply → 🔥🔥🔥🔥🔥**
**Remote destination / next-hop MAC → 🔥🔥🔥🔥🔥**
**ARP cache → 🔥🔥🔥**
**ARP vs RARP → 🔥🔥🔥🔥**
