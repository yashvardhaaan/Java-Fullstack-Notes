# Subnetting

## 1. What is Subnetting?

**Subnetting** means dividing one larger IP network into multiple smaller networks called **subnets**.

```text
Large Network
      ↓
 ┌────┬────┬────┬────┐
 S1   S2   S3   S4
```

> **Subnetting = Borrow host bits to create more networks.**

---

# 2. Why Subnetting?

Main reasons:

* Efficient IP address usage
* Reduce broadcast domain size
* Better network organization
* Improved network management

---

# 3. Borrowing Host Bits ⭐⭐⭐⭐⭐

Suppose:

```text
192.168.1.0/24
```

Original:

```text
Network bits = 24
Host bits    = 8
```

Borrow 2 host bits:

```text
/24 → /26
```

Now:

```text
Network bits = 26
Host bits    = 6
```

---

# 4. Number of Subnets

If `s` bits are borrowed:

```text
Number of subnets = 2^s
```

Example:

```text
/24 → /26
```

Borrowed:

```text
26 − 24 = 2 bits
```

Therefore:

```text
2² = 4 subnets
```

---

# 5. Hosts per Subnet ⭐⭐⭐⭐⭐

If `h` host bits remain:

```text
Total addresses = 2^h
```

Traditional usable hosts:

```text
Usable hosts = 2^h − 2
```

For `/26`:

```text
h = 32 − 26 = 6

Total = 2⁶ = 64
Usable = 64 − 2 = 62
```

---

# 6. Example — `/24 → /26`

Network:

```text
192.168.1.0/24
```

New prefix:

```text
/26
```

Block size:

```text
256 − 192 = 64
```

Therefore:

```text
Subnet 1 → 192.168.1.0   – 63
Subnet 2 → 192.168.1.64  – 127
Subnet 3 → 192.168.1.128 – 191
Subnet 4 → 192.168.1.192 – 255
```

### Table

| Subnet | Network | Broadcast | Usable Hosts  |
| ------ | ------- | --------- | ------------- |
| 1      | `.0`    | `.63`     | `.1 – .62`    |
| 2      | `.64`   | `.127`    | `.65 – .126`  |
| 3      | `.128`  | `.191`    | `.129 – .190` |
| 4      | `.192`  | `.255`    | `.193 – .254` |

---

# 7. Block Size Trick 🔥

For the subnetted octet:

```text
Block Size = 256 − Mask Value
```

Example:

```text
/26
Mask = 255.255.255.192
```

Therefore:

```text
256 − 192 = 64
```

Subnets start at:

```text
0, 64, 128, 192
```

---

# 8. Find Network Address Quickly

Example:

```text
IP = 192.168.1.140/26
```

Mask:

```text
255.255.255.192
```

Block size:

```text
64
```

Ranges:

```text
0–63
64–127
128–191
192–255
```

`140` falls in:

```text
128–191
```

Therefore:

```text
Network   = 192.168.1.128
Broadcast = 192.168.1.191
```

Usable:

```text
192.168.1.129 – 192.168.1.190
```

🔥 **This is one of the fastest methods for GATE numericals.**

---

# 9. Subnetting vs Supernetting

| Subnetting                     | Supernetting                     |
| ------------------------------ | -------------------------------- |
| One network → smaller networks | Multiple networks → larger block |
| Borrow host bits               | Reduce network-prefix length     |
| More subnets                   | Fewer larger routes              |
| `/24 → /26`                    | `/24 + /24 → larger aggregate`   |

CIDR enables flexible prefix lengths and route aggregation.

---

# 10. VLSM ⭐⭐⭐⭐

**VLSM = Variable Length Subnet Mask**

Different subnets can have **different prefix lengths**.

Example:

```text
Network
├── Department A → /25
├── Department B → /26
└── Department C → /28
```

This avoids wasting addresses.

---

# 🔥 GATE Traps

### Trap 1

Borrowing more bits gives:

```text
More subnets
Less hosts per subnet
```

---

### Trap 2

For `/26`:

```text
Host bits = 6
```

Not 26.

```text
Host bits = 32 − prefix
```

---

### Trap 3

`/26` does NOT mean 26 hosts.

It means:

```text
26 network bits
6 host bits
```

---

### Trap 4

For traditional subnet calculations:

```text
Usable hosts = 2^h − 2
```

But `/31` and `/32` have special uses, so don't blindly apply this rule there.

---

# ⚡ 30-Second Revision

```text
SUBNETTING
     ↓
Divide network into smaller networks
     ↓
Borrow host bits

Borrow s bits:
Subnets = 2^s

Remaining h bits:
Addresses = 2^h
Typical usable = 2^h − 2

Block Size:
256 − mask value

Example:
/24 → /26

Borrowed = 2
Subnets = 4
Host bits = 6
Addresses/subnet = 64
Usable = 62

VLSM:
Different subnet sizes
```

### GATE Priority

**Subnet calculation → 🔥🔥🔥🔥🔥**
**Network/Broadcast finding → 🔥🔥🔥🔥🔥**
**Block-size method → 🔥🔥🔥🔥🔥**
**VLSM → 🔥🔥🔥🔥**
