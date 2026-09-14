# RARP

## 1. What is RARP?

**RARP = Reverse Address Resolution Protocol**

RARP performs the reverse operation of ARP:

> **MAC address → IPv4 address**

```text
MAC Address
     ↓
    RARP
     ↓
IPv4 Address
```

---

## 2. Why was RARP Needed?

Historically, some **diskless computers** knew their hardware/MAC address but did not know their IP address when booting.

They could ask a RARP server:

```text
Client
MAC = AA:BB:CC:DD:EE:FF
       ↓
   RARP Request
       ↓
RARP Server
       ↓
IP = 192.168.1.10
```

---

## 3. ARP vs RARP ⭐⭐⭐⭐⭐

| ARP                             | RARP                             |
| ------------------------------- | -------------------------------- |
| IP → MAC                        | MAC → IP                         |
| Resolves local hardware address | Historically obtained IP address |
| Still used with IPv4            | Obsolete                         |
| Request typically broadcast     | Request broadcast                |
| Reply typically unicast         | Reply from RARP server           |

### Easy Trick

```text
ARP  → Forward
IP → MAC

RARP → Reverse
MAC → IP
```

---

## 4. Why RARP Became Obsolete

RARP had limitations:

* Required a RARP server on the local network
* Provided very limited configuration information
* Mainly supplied an IP address

It was replaced by:

```text
BOOTP
   ↓
DHCP
```

DHCP can provide much more information:

* IP address
* Subnet mask
* Default gateway
* DNS server
* Lease information

---

## 5. RARP vs DHCP 🔥

| RARP                 | DHCP                                  |
| -------------------- | ------------------------------------- |
| MAC → IP             | Client requests network configuration |
| Limited              | Much more configuration               |
| Obsolete             | Widely used                           |
| Requires RARP server | DHCP server/relay architecture        |

---

# 🔥 GATE Traps

### Trap 1

**RARP = ARP reply.**

❌ No.

```text
ARP  → IP → MAC
RARP → MAC → IP
```

---

### Trap 2

**RARP is commonly used today.**

❌ It is **obsolete**.

---

### Trap 3

**RARP provides complete network configuration.**

❌ DHCP is designed for this.

---

# ⚡ 30-Second Revision

```text
RARP
 ↓
Reverse Address Resolution Protocol
 ↓
MAC → IP

Historically:
Diskless host knows MAC
        ↓
RARP server
        ↓
Gets IP address

RARP → obsolete
        ↓
BOOTP / DHCP

ARP  → IP → MAC
RARP → MAC → IP
```

### GATE Priority

**ARP vs RARP → 🔥🔥🔥🔥**
**RARP purpose → 🔥🔥🔥**
**RARP vs DHCP → 🔥🔥**
