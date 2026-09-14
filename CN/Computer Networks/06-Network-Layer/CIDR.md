# CIDR

## 1. What is CIDR?

**CIDR = Classless Inter-Domain Routing**

CIDR allows IP networks to use **arbitrary prefix lengths** instead of fixed Class A/B/C boundaries.

> **CIDR = Prefix-based IP addressing**

Example:

```text
192.168.10.0/20
```

`/20` means:

```text
20 bits → network/prefix
12 bits → host
```

---

# 2. Why CIDR?

Classful addressing wastes IP addresses.

Example:

A Class C network traditionally provides:

```text
256 addresses
```

But if an organization needs 1000 addresses, one Class C is insufficient, while a Class B provides far more than necessary.

CIDR allows a more appropriate prefix size.

---

# 3. CIDR Notation ⭐⭐⭐⭐⭐

Format:

```text
IP address / prefix length
```

Examples:

```text
10.0.0.0/8
172.16.0.0/16
192.168.1.0/24
192.168.1.0/27
```

For IPv4:

```text
Host bits = 32 − prefix length
```

---

# 4. Number of Addresses

If prefix length is `/n`:

```text
Host bits = 32 − n
```

Therefore:

```text
Total addresses = 2^(32−n)
```

Example:

```text
192.168.1.0/27
```

Host bits:

```text
32 − 27 = 5
```

Addresses:

```text
2⁵ = 32
```

Traditional usable hosts:

```text
32 − 2 = 30
```

---

# 5. CIDR vs Classful Addressing

| Classful       | CIDR                     |
| -------------- | ------------------------ |
| Fixed classes  | Flexible prefix          |
| A `/8`         | Any prefix such as `/13` |
| B `/16`        | `/19`, `/20`, etc.       |
| C `/24`        | `/27`, `/28`, etc.       |
| Less efficient | More efficient           |
| Older approach | Modern approach          |

🔥 **Modern IP routing uses CIDR rather than relying on classes.**

---

# 6. CIDR and Route Aggregation ⭐⭐⭐⭐⭐

CIDR can combine multiple contiguous networks into a **single larger route**.

This is called:

* Route aggregation
* Route summarization
* Supernetting

Example:

```text id="r6w0ag"
192.168.0.0/24
192.168.1.0/24
192.168.2.0/24
192.168.3.0/24
```

Can be summarized as:

```text id="f1i8q3"
192.168.0.0/22
```

Why?

Four `/24` networks contain:

```text
4 × 256 = 1024 addresses
```

And:

```text
1024 = 2¹⁰
```

So host bits = 10:

```text
32 − 10 = /22
```

---

# 7. Route Aggregation Conditions 🔥

For proper CIDR aggregation, networks should generally be:

1. **Contiguous**
2. **Same size**
3. **Properly aligned**

Example:

```text id="z4q2d4"
192.168.0.0/24
192.168.1.0/24
192.168.2.0/24
192.168.3.0/24
```

Good → `/22`.

But arbitrary unrelated networks cannot simply be combined.

---

# 8. Longest Prefix Matching ⭐⭐⭐⭐⭐

A router may have multiple matching routes.

It chooses the route with the:

> **Longest matching prefix.**

Example routing table:

```text id="j4t9ar"
10.0.0.0/8
10.1.0.0/16
10.1.2.0/24
```

Destination:

```text
10.1.2.50
```

All three match.

Router chooses:

```text
10.1.2.0/24
```

because `/24` is the **longest prefix**.

### Trick

> **More prefix bits = more specific route.**

---

# 9. CIDR Numerical Shortcut 🔥

Suppose:

```text
192.168.10.0/28
```

Host bits:

```text
32 − 28 = 4
```

Total:

```text
2⁴ = 16
```

Block size:

```text
16
```

Ranges:

```text
0–15
16–31
32–47
48–63
...
```

So:

```text
192.168.10.0/28
Network   = .0
Broadcast = .15
```

---

# 10. CIDR vs Subnetting

They are closely related but not identical.

### Subnetting

```text
One network
     ↓
Smaller networks
```

### CIDR

Provides **classless prefix-based addressing**, and also enables **route aggregation**.

So:

> Subnetting focuses on **dividing networks**.
> CIDR focuses on **flexible prefixes and scalable routing/addressing**.

---

# 🔥 GATE Traps

### Trap 1

`/24` means 24 host bits.

❌

```text
/24 → 24 network bits
       8 host bits
```

---

### Trap 2

CIDR only means subnetting.

❌

CIDR also enables **route aggregation/summarization**.

---

### Trap 3

Router chooses the route with the smallest prefix.

❌

It chooses the **longest matching prefix**.

```text
/24 > /20 > /16 > /8
```

in specificity.

---

### Trap 4

Four `/24` networks always combine into `/22`.

❌ Only when they satisfy the required **contiguity/alignment** conditions.

---

# ⚡ 30-Second Revision

```text
CIDR
 ↓
Classless addressing
 ↓
IP/prefix notation

Host bits = 32 − n
Addresses = 2^(32−n)

CIDR enables:
├── Flexible subnet sizes
├── Route aggregation
└── Longest Prefix Matching

LPM:
More prefix bits
      ↓
More specific route
      ↓
Router prefers it
```

### GATE Priority

**CIDR calculations → 🔥🔥🔥🔥🔥**
**Longest Prefix Matching → 🔥🔥🔥🔥🔥**
**Route aggregation → 🔥🔥🔥🔥🔥**
**CIDR vs classful → 🔥🔥🔥🔥**



