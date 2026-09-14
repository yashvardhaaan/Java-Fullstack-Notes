# IPv6

## 1. What is IPv6?

**IPv6 = Internet Protocol version 6**

It was developed to address IPv4 address-space limitations and improve several aspects of IP networking.

> **IPv6 address = 128 bits = 16 bytes**

Example:

```text
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

---

# 2. IPv6 Address Format ⭐⭐⭐⭐⭐

128 bits are represented as **8 groups of 16 bits** in hexadecimal.

```text id="j0s5b8"
2001 : 0db8 : 85a3 : 0000 : 0000 : 8a2e : 0370 : 7334
 16      16     16     16     16     16     16     16
```

Total:

```text
8 × 16 = 128 bits
```

---

# 3. IPv6 Address Compression ⭐⭐⭐⭐⭐

IPv6 allows leading zeros in a group to be removed.

Example:

```text
0db8 → db8
0000 → 0
```

So:

```text
2001:0db8:0000:0000:0000:0000:0000:0001
```

can become:

```text
2001:db8::1
```

### `::` Rule 🔥

`::` can replace **one or more consecutive groups of zeros**.

It can appear **only once** in an IPv6 address.

Example:

```text
2001:db8:0:0:0:0:0:1
        ↓
2001:db8::1
```

---

# 4. IPv6 Address Types ⭐⭐⭐⭐⭐

### Unicast

One interface.

```text
One → One
```

### Multicast

One sender → multiple interested receivers.

```text
One → Many
```

### Anycast

One sender → **nearest/best** member of a group according to routing.

```text
One → One of Many
```

🔥 IPv6 **does not use broadcast**.

---

# 5. IPv6 Header ⭐⭐⭐⭐⭐

IPv6 has a **fixed base header of 40 bytes**.

Important fields:

| Field               | Purpose                         |
| ------------------- | ------------------------------- |
| Version             | IPv6 = 6                        |
| Traffic Class       | Traffic/QoS-related handling    |
| Flow Label          | Identifies a flow               |
| Payload Length      | Length after base header        |
| Next Header         | Identifies next header/protocol |
| Hop Limit           | Limits forwarding hops          |
| Source Address      | 128-bit source                  |
| Destination Address | 128-bit destination             |

---

# 6. TTL → Hop Limit

IPv4:

```text
TTL
```

IPv6:

```text
Hop Limit
```

At each router:

```text
Hop Limit = Hop Limit − 1
```

When it reaches zero, the packet is discarded and an ICMPv6 error can be generated.

> **IPv6 Hop Limit ≈ IPv4 TTL**

---

# 7. Next Header ⭐⭐⭐⭐⭐

IPv6 replaces the IPv4 **Protocol** field with:

> **Next Header**

It identifies either:

* An IPv6 extension header
* An upper-layer protocol such as TCP/UDP/ICMPv6

Conceptually:

```text
IPv6 Header
     ↓
Next Header
     ↓
Extension Header
     ↓
TCP / UDP / ICMPv6
```

---

# 8. IPv6 Extension Headers

IPv6 uses extension headers for optional features rather than making the base header variable in length.

Examples include:

* Hop-by-Hop Options
* Routing
* Fragment
* Destination Options
* Authentication Header
* Encapsulating Security Payload

🔥 For GATE, understand the **concept** rather than memorizing every field.

---

# 9. Fragmentation ⭐⭐⭐⭐⭐

Very important difference:

### IPv4

Routers **can fragment** packets.

### IPv6

Routers **do not fragment** packets.

If fragmentation is needed, the **source** performs it using the IPv6 Fragment extension header.

```text
IPv6 Source
    ↓
Fragment if necessary
    ↓
Routers forward fragments
```

---

# 10. IPv6 Has No Header Checksum

IPv4:

```text
Header Checksum → Yes
```

IPv6:

```text
Base-header checksum → No
```

This reduces processing overhead at routers.

---

# 11. IPv6 Address Categories

Common IPv6 address ranges:

| Type           | Prefix      |
| -------------- | ----------- |
| Global Unicast | `2000::/3`  |
| Link-Local     | `FE80::/10` |
| Unique Local   | `FC00::/7`  |
| Multicast      | `FF00::/8`  |
| Loopback       | `::1/128`   |
| Unspecified    | `::/128`    |

### Important

```text
::1
```

= IPv6 loopback.

```text
::
```

= unspecified address.

---

# 12. IPv6 vs IPv4 🔥🔥🔥🔥🔥

| IPv4                     | IPv6                          |
| ------------------------ | ----------------------------- |
| 32-bit address           | 128-bit address               |
| Variable header: 20–60 B | Fixed base header: 40 B       |
| TTL                      | Hop Limit                     |
| Protocol                 | Next Header                   |
| Header checksum          | No base-header checksum       |
| Broadcast exists         | No broadcast                  |
| Router fragmentation     | Source fragmentation          |
| ARP                      | Neighbor Discovery via ICMPv6 |

---

# 🔥 GATE Traps

### Trap 1

**IPv6 address = 64 bits.**

❌

> IPv6 = **128 bits**

---

### Trap 2

**IPv6 supports broadcast.**

❌

> IPv6 uses **multicast** instead of broadcast.

---

### Trap 3

**IPv6 routers fragment packets.**

❌

> **Source** performs fragmentation.

---

### Trap 4

**IPv6 has a header checksum.**

❌

The IPv6 base header has **no header checksum**.

---

### Trap 5

**IPv6 uses TTL.**

❌

> IPv6 → **Hop Limit**

---

### Trap 6

`::` can appear multiple times.

❌

It can appear **only once** because otherwise the number of omitted zero groups would be ambiguous.

---

# ⚡ 30-Second Revision

```text
IPv6
 ↓
128-bit address
 ↓
8 × 16-bit hexadecimal groups

Header = 40 bytes

IPv4       → IPv6
TTL        → Hop Limit
Protocol   → Next Header
Broadcast  → No broadcast
Fragment   → Source only
Checksum   → No base-header checksum

Important:
::1        → Loopback
::         → Unspecified
FE80::/10  → Link-local
FF00::/8   → Multicast
2000::/3   → Global Unicast
```

### GATE Priority

**IPv4 vs IPv6 → 🔥🔥🔥🔥🔥**
**IPv6 addressing/compression → 🔥🔥🔥🔥🔥**
**IPv6 header → 🔥🔥🔥🔥**
**Fragmentation difference → 🔥🔥🔥🔥🔥**
**Address types → 🔥🔥🔥🔥**
