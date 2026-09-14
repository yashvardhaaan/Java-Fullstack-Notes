# IP Addressing

## 1. What is an IP Address?

An **IP address** is a logical address used at the **Network Layer (L3)** to identify an interface and enable packet delivery across networks.

> **IP → Logical + Network Layer**

For IPv4:

```text
32 bits = 4 bytes
```

Example:

```text
192.168.1.10
```

---

# 2. Network Part + Host Part ⭐⭐⭐⭐⭐

An IPv4 address conceptually contains:

```text
┌───────────────┬──────────────┐
│ Network Part  │  Host Part   │
└───────────────┴──────────────┘
```

* **Network part** → identifies the network
* **Host part** → identifies a host/interface within that network

The **subnet mask/prefix length** determines where the split occurs.

Example:

```text
192.168.1.10/24
```

```text
Network = 192.168.1.0
Host    = 10
```

---

# 3. IPv4 Address Classes

Historically, IPv4 used **classful addressing**.

| Class | First Octet | Default Prefix | Purpose               |
| ----- | ----------: | -------------: | --------------------- |
| A     |       1–126 |             /8 | Large networks        |
| B     |     128–191 |            /16 | Medium networks       |
| C     |     192–223 |            /24 | Small networks        |
| D     |     224–239 |              — | Multicast             |
| E     |     240–255 |              — | Experimental/reserved |

🔥 **Classful addressing is historical. Modern networks use CIDR.**

### Trick

```text
A → 1–126
B → 128–191
C → 192–223
D → 224–239
E → 240–255
```

`127.x.x.x` is reserved for **loopback**.

---

# 4. Network Address

The **network address** identifies the network itself.

Example:

```text
IP = 192.168.10.25/24
```

Mask:

```text
255.255.255.0
```

Network address:

```text
192.168.10.0
```

Host bits are all `0`.

---

# 5. Broadcast Address

For a traditional IPv4 subnet, the **directed broadcast address** has all host bits set to `1`.

Example:

```text
192.168.10.25/24
```

Network:

```text
192.168.10.0
```

Broadcast:

```text
192.168.10.255
```

So:

```text
Network → host bits = 00000000
Broadcast → host bits = 11111111
```

---

# 6. Usable Host Addresses ⭐⭐⭐⭐⭐

For a typical IPv4 subnet:

```text
Number of addresses = 2^h
```

where `h` = number of host bits.

Traditionally:

```text
Usable hosts = 2^h − 2
```

because:

* All host bits `0` → network address
* All host bits `1` → broadcast address

### Example

`/24`:

```text
Host bits = 32 − 24 = 8

Total addresses = 2^8 = 256

Usable hosts = 256 − 2 = 254
```

⚠️ Modern special-purpose prefixes such as `/31` and `/32` have exceptions; don't blindly apply `−2` to every prefix.

---

# 7. Private IPv4 Addresses ⭐⭐⭐⭐⭐

Private IPv4 ranges:

| Range                           | CIDR  |
| ------------------------------- | ----- |
| `10.0.0.0 – 10.255.255.255`     | `/8`  |
| `172.16.0.0 – 172.31.255.255`   | `/12` |
| `192.168.0.0 – 192.168.255.255` | `/16` |

These are used inside private networks and are **not globally routable on the public Internet**.

### Trick

```text
10
172.16–31
192.168
```

---

# 8. Special IPv4 Addresses

### Loopback

```text
127.0.0.0/8
```

Most commonly:

```text
127.0.0.1
```

Used to refer to the local host.

---

### APIPA / Link-local

```text
169.254.0.0/16
```

Used for IPv4 link-local addressing.

---

### Unspecified Address

```text
0.0.0.0
```

Can represent an unspecified address, and in routing can represent the default route:

```text
0.0.0.0/0
```

---

# 9. Public vs Private IP

| Private IP          | Public IP                       |
| ------------------- | ------------------------------- |
| Internal networks   | Internet-routable               |
| Not globally unique | Globally unique allocation      |
| Common with NAT     | Used for Internet communication |

Example:

```text
Laptop → 192.168.1.10
Router  → Public IP
```

NAT can translate between private and public addressing.

---

# 10. Subnet Mask

Subnet mask indicates which bits belong to the network/subnet portion.

Example:

```text
/24
```

means:

```text
11111111.11111111.11111111.00000000
```

Decimal:

```text
255.255.255.0
```

Another example:

```text
/26
```

```text
11111111.11111111.11111111.11000000
```

```text
255.255.255.192
```

---

# 11. Prefix Length ⭐⭐⭐⭐⭐

`/n` means:

> First `n` bits are network/prefix bits.

Examples:

```text
/8   → 8 network bits
/16  → 16 network bits
/24  → 24 network bits
/26  → 26 network bits
```

Therefore:

```text
Host bits = 32 − n
```

---

# 12. GATE Numerical Pattern

Given:

```text
192.168.1.50/26
```

### Step 1: Host bits

```text
32 − 26 = 6
```

### Step 2: Total addresses

```text
2^6 = 64
```

### Step 3: Subnet blocks

The last octet has blocks of 64:

```text
0–63
64–127
128–191
192–255
```

`50` belongs to:

```text
0–63
```

Therefore:

```text
Network   = 192.168.1.0
Broadcast = 192.168.1.63
```

Typical usable hosts:

```text
192.168.1.1 – 192.168.1.62
```

🔥 This type of question is **very important for GATE**.

---

# 🔥 GATE Traps

### Trap 1

`IP address = MAC address`

❌

```text
IP  → L3 → logical
MAC → L2 → link-layer
```

---

### Trap 2

`127.0.0.1` is a normal public IP.

❌ It is **loopback**.

---

### Trap 3

All `192.x.x.x` addresses are private.

❌ Only:

```text
192.168.0.0/16
```

is private in that range.

---

### Trap 4

Private ranges are:

```text
10.x.x.x
172.x.x.x
192.x.x.x
```

❌ Incomplete.

For `172`, only:

```text
172.16.0.0 – 172.31.255.255
```

is private.

---

# ⚡ 30-Second Revision

```text
IPv4
 ↓
32 bits
 ↓
Network + Host

/Prefix:
Network bits = n
Host bits = 32−n

Total addresses = 2^h
Typical usable hosts = 2^h−2

Network address:
Host bits = 0

Broadcast:
Host bits = 1

Private:
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16

Loopback:
127.0.0.0/8
```

### GATE Priority

**Network/Host calculation → 🔥🔥🔥🔥🔥**
**Subnet mask & prefix → 🔥🔥🔥🔥🔥**
**Network/Broadcast address → 🔥🔥🔥🔥🔥**
**Private/Special addresses → 🔥🔥🔥🔥**
**Classful addressing → 🔥🔥🔥**
