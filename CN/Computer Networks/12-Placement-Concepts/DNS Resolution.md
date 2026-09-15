````md id="dns-resolution"
# DNS Resolution

## 1. What is DNS Resolution?

**DNS Resolution** is the process of converting a domain name into its corresponding IP address.

```text
www.example.com
       ↓
      DNS
       ↓
93.184.x.x
````

> Humans use names; networks ultimately communicate using IP addresses.

---

## 2. DNS Resolution Flow ⭐⭐⭐⭐⭐

Typical process:

```text
Browser
   ↓
Local DNS Cache
   ↓
Recursive DNS Resolver
   ↓
Root DNS Server
   ↓
TLD DNS Server
   ↓
Authoritative DNS Server
   ↓
IP Address
```

Example:

```text
www.example.com
      ↓
Root → .com → example.com → IP
```

---

## 3. Recursive DNS Resolver ⭐⭐⭐⭐⭐

The **recursive resolver** performs the lookup on behalf of the client.

```text
Client
  ↓
Recursive Resolver
  ↓
Root
  ↓
TLD
  ↓
Authoritative
  ↓
IP
```

The resolver then returns the answer to the client and can cache it.

---

## 4. Root → TLD → Authoritative ⭐⭐⭐⭐⭐

### Root Server

Knows where to find TLD servers.

```text
Root
 ↓
.com
.net
.org
...
```

### TLD Server

Handles a top-level domain such as:

```text
.com
.org
.in
```

It directs the resolver toward the authoritative server for the requested domain.

### Authoritative DNS Server

Contains the authoritative DNS records for the domain.

Example:

```text
example.com
   ↓
A record
   ↓
IP address
```

---

## 5. Recursive vs Iterative ⭐⭐⭐⭐⭐

### Recursive

Resolver asks another server:

> "Find the final answer for me."

### Iterative

Server responds with the best information it has, often a referral.

```text
Resolver → Root
Root → Ask TLD

Resolver → TLD
TLD → Ask Authoritative

Resolver → Authoritative
Authoritative → IP
```

🔥 Client usually makes a recursive request to its resolver, while the resolver may perform iterative queries.

---

## 6. DNS Caching ⭐⭐⭐⭐⭐

DNS results are cached to avoid repeated lookups.

```text
First request:
Client → Resolver → DNS hierarchy → IP

Later request:
Client → Resolver Cache → IP
```

### TTL

**DNS TTL = how long a DNS answer may be cached** (subject to resolver/cache rules).

🔥 DNS TTL is different from **IPv4 TTL**.

| DNS TTL          | IP TTL                     |
| ---------------- | -------------------------- |
| Cache lifetime   | Limits packet lifetime     |
| DNS              | Network layer              |
| Measured in time | Decremented per router hop |

---

## 7. Important DNS Records ⭐⭐⭐⭐⭐

| Record | Purpose                    |
| ------ | -------------------------- |
| A      | Domain → IPv4              |
| AAAA   | Domain → IPv6              |
| CNAME  | Alias → canonical name     |
| MX     | Mail server                |
| NS     | Authoritative name server  |
| PTR    | IP → domain name           |
| TXT    | Text/policy information    |
| SOA    | Zone authority information |

🔥 **A = IPv4, AAAA = IPv6**

---

## 8. Forward vs Reverse DNS

### Forward DNS

```text
Domain → IP
```

Uses:

* A
* AAAA

### Reverse DNS

```text
IP → Domain
```

Uses:

* **PTR**

---

## 9. DNS Transport ⭐⭐⭐⭐⭐

Traditional DNS commonly uses:

```text
UDP port 53
```

TCP port 53 is also used, notably for:

* Zone transfers
* Responses requiring TCP
* Other cases where TCP is selected/required

🔥 **DNS is not exclusively UDP.**

---

## 10. DNS Zone Transfer ⭐⭐⭐

Used to replicate DNS zone information between DNS servers.

### AXFR

Full zone transfer.

### IXFR

Incremental zone transfer.

Traditionally uses **TCP 53**.

---

## 11. DNS Resolution Example

Suppose you enter:

```text
www.example.com
```

Simplified:

```text
1. Browser checks cache
        ↓
2. OS/resolver cache
        ↓
3. Recursive DNS resolver
        ↓
4. Root
        ↓
5. .com TLD
        ↓
6. Authoritative server
        ↓
7. A/AAAA record
        ↓
8. IP returned
        ↓
9. Browser connects to server
```

---

# 🔥 GATE / Placement Traps

1. **DNS converts names to IP addresses.**
2. A → IPv4.
3. AAAA → IPv6.
4. PTR → reverse DNS.
5. MX → mail server.
6. CNAME → alias.
7. Root does **not normally provide the final IP**; it directs toward the appropriate TLD.
8. TLD server directs toward the authoritative server.
9. Authoritative server provides authoritative records.
10. Recursive resolver works on behalf of the client.
11. DNS commonly uses **UDP 53**, but can use TCP 53.
12. DNS TTL ≠ IP TTL.
13. DNS caching reduces lookup traffic and latency.
14. DNS is an **application-layer** protocol.
15. Reverse DNS = IP → name.

---

# ⚡ 30-Second Revision

```text
Domain
  ↓
Recursive Resolver
  ↓
Root
  ↓
TLD
  ↓
Authoritative
  ↓
IP
```

### Must Remember

```text
A     → IPv4
AAAA  → IPv6
CNAME → Alias
MX    → Mail
NS    → Name Server
PTR   → Reverse DNS
```

```text
DNS
↓
UDP 53 commonly
TCP 53 when needed / zone transfers
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```

### 📌 Placement Concepts folder complete

You have now covered all **12 Placement Concepts**:

1. HTTP Methods
2. HTTP Status Codes
3. Cookies
4. Sessions
5. JWT
6. REST API
7. CORS
8. Reverse Proxy
9. Load Balancer
10. CDN
11. WebSocket
12. DNS Resolution
```
