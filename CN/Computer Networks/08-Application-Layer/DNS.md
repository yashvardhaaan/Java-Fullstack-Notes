````md id="dns-gate"
# DNS — Domain Name System

## 1. Definition

**DNS** converts human-readable domain names into IP addresses.

> DNS = **Name → IP address**

Example:

```text
www.google.com
      ↓
    DNS
      ↓
142.x.x.x
````

It can also perform reverse resolution:

```text
IP Address → Domain Name
```

---

# 2. Why DNS is Needed ⭐⭐⭐⭐⭐

Humans prefer:

```text
www.example.com
```

Networks communicate using:

```text
IP address
```

DNS acts as the distributed naming system connecting the two.

---

# 3. DNS Hierarchy ⭐⭐⭐⭐⭐

DNS is hierarchical:

```text
                    Root
                     .
                     |
            ┌────────┴────────┐
           .com              .org
            |
         example
            |
          www
```

Example:

```text
www.example.com
│   │       │
│   │       └── TLD
│   └────────── Domain
└────────────── Host/Subdomain
```

### Important levels

```text
Root
 ↓
TLD
 ↓
Authoritative domain/server
 ↓
Host name
```

---

# 4. DNS Servers ⭐⭐⭐⭐⭐

### 1. Root DNS Server

Knows where to find the appropriate **TLD servers**.

```text
Root
 ↓
.com server
```

### 2. TLD Server

Handles domains under a top-level domain.

Examples:

```text
.com
.org
.in
```

It directs the resolver toward the **authoritative server**.

### 3. Authoritative DNS Server

Contains the authoritative DNS records for a domain.

Example:

```text
example.com → IP address
```

### 4. Recursive Resolver

Receives the client's DNS query and performs the lookup on the client's behalf.

Often provided by:

* ISP
* Organization
* Public DNS service

---

# 5. DNS Resolution ⭐⭐⭐⭐⭐

Suppose you request:

```text
www.example.com
```

Typical recursive lookup:

```text
Client
  ↓
Recursive Resolver
  ↓
Root
  ↓
TLD (.com)
  ↓
Authoritative DNS
  ↓
IP address
  ↓
Resolver
  ↓
Client
```

---

# 6. Recursive vs Iterative Query ⭐⭐⭐⭐⭐

### Recursive

Client asks resolver:

> "Find the IP for me."

Resolver is responsible for obtaining the final answer.

```text
Client → Resolver
          ↓
      Root → TLD → Authoritative
          ↓
       Answer
```

### Iterative

A DNS server gives the best information it currently has, often a referral.

```text
Resolver → Root
Root → "Ask .com"

Resolver → .com
.com → "Ask authoritative server"

Resolver → Authoritative
Authoritative → IP
```

🔥 **GATE Trap:**

> Recursive = server performs lookup on behalf of requester.
> Iterative = server returns a referral/best information.

---

# 7. DNS Caching ⭐⭐⭐⭐⭐

DNS responses can be cached.

```text
First lookup
Client → Resolver → DNS hierarchy

Later lookup
Client → Resolver → Cached answer
```

This reduces:

* Query latency
* DNS traffic
* Load on DNS servers

Caching duration is controlled by:

> **TTL (Time To Live)** in DNS records.

⚠️ DNS TTL is different from **IP packet TTL**.

---

# 8. DNS Records ⭐⭐⭐⭐⭐

| Record | Purpose                           |
| ------ | --------------------------------- |
| A      | Domain → IPv4 address             |
| AAAA   | Domain → IPv6 address             |
| CNAME  | Alias → canonical name            |
| MX     | Mail server for domain            |
| NS     | Authoritative name server         |
| PTR    | Reverse DNS                       |
| TXT    | Arbitrary text/policy information |
| SOA    | Zone's authoritative information  |

### Important

```text
A     → IPv4
AAAA  → IPv6
MX    → Mail
CNAME → Alias
PTR   → Reverse lookup
NS    → Name server
```

---

# 9. DNS Port ⭐⭐⭐⭐⭐

DNS commonly uses:

```text
UDP → Port 53
TCP → Port 53
```

### Why UDP?

Normal DNS queries are commonly sent over UDP because of its low overhead.

### When TCP?

TCP can be used for situations such as:

* Zone transfers
* Responses that require TCP
* DNS operations where TCP is selected/required

Modern DNS can also use other transports such as DNS over TLS/HTTPS, but the traditional DNS service is associated with port 53.

---

# 10. Forward vs Reverse Lookup

### Forward Lookup

```text
Domain → IP
```

Uses:

```text
A / AAAA
```

### Reverse Lookup

```text
IP → Domain
```

Uses:

```text
PTR
```

---

# 11. DNS Zone Transfer ⭐⭐⭐

Used to replicate DNS zone information between DNS servers.

Common types:

```text
AXFR → Full zone transfer
IXFR → Incremental zone transfer
```

TCP is traditionally used for zone transfers.

---

# 12. DNS Name Resolution Example

```text
User enters:

www.example.com
        ↓
Browser/OS checks local cache
        ↓
Recursive resolver
        ↓
Root
        ↓
.com TLD
        ↓
Authoritative server
        ↓
A/AAAA record
        ↓
IP address
        ↓
Client connects to server
```

---

# 🔥 GATE Traps

### Trap 1

DNS only converts domain names to IPv4.

❌

DNS can return IPv4 **and IPv6**.

```text
A     → IPv4
AAAA  → IPv6
```

---

### Trap 2

DNS always uses TCP.

❌

Traditional DNS commonly uses **UDP 53**, while TCP 53 is also used in specific cases.

---

### Trap 3

DNS TTL and IP TTL are the same.

❌

```text
DNS TTL → Cache lifetime
IP TTL  → Limits packet lifetime/hops
```

---

### Trap 4

CNAME directly stores an IP address.

❌

> CNAME points to another **domain name**.

---

### Trap 5

MX record stores the client's IP.

❌

> MX identifies **mail servers** for a domain.

---

### Trap 6

PTR performs forward lookup.

❌

> PTR → **reverse DNS lookup**

---

# ⚡ 30-Second Revision

```text
DNS
 ↓
Domain Name ↔ IP Address

Hierarchy:
Root
 ↓
TLD
 ↓
Authoritative Server

Query:
Client → Recursive Resolver
                ↓
          Root → TLD → Authoritative

Records:
A     → IPv4
AAAA  → IPv6
CNAME → Alias
MX    → Mail
NS    → Name Server
PTR   → Reverse DNS

Traditional DNS:
UDP 53
TCP 53
```

### 🔥 Must Remember

> **A = IPv4, AAAA = IPv6, MX = Mail, CNAME = Alias, PTR = Reverse**

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Focus on:

1. DNS hierarchy
2. Recursive vs iterative queries
3. DNS caching + TTL
4. DNS records
5. UDP/TCP port 53
6. DNS resolution numericals/sequence questions

```
```
