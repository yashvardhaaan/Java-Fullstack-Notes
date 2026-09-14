# Protocol Stack

## 1. What is a Protocol Stack?

A **protocol stack** is a set of networking protocols organized in layers, where each layer performs a specific function and works with the layers above/below it.

```text
Application → HTTP, DNS
Transport   → TCP, UDP
Internet    → IP, ICMP
Network     → Ethernet, Wi-Fi
```

### First principle

> **No single protocol does everything. Multiple protocols cooperate, each solving one part of communication.**

---

# 2. Why a Stack?

Imagine sending a web request:

```text
HTTP
 ↓
TCP
 ↓
IP
 ↓
Ethernet
```

Each protocol handles a different problem:

| Protocol | Problem solved                       |
| -------- | ------------------------------------ |
| HTTP     | Web/application communication        |
| TCP      | Reliable process-to-process delivery |
| IP       | Delivery across networks             |
| Ethernet | Local-link transmission              |

This combination is a **protocol stack**.

---

# 3. TCP/IP Protocol Stack ⭐⭐⭐⭐⭐

```text
┌─────────────────────┐
│ Application         │ → HTTP, DNS, FTP, SMTP
├─────────────────────┤
│ Transport           │ → TCP, UDP
├─────────────────────┤
│ Internet            │ → IP, ICMP
├─────────────────────┤
│ Network Access      │ → Ethernet, Wi-Fi
└─────────────────────┘
```

---

# 4. How Protocols Work Together

Suppose a browser requests a webpage.

```text
HTTP
 ↓
TCP
 ↓
IP
 ↓
Ethernet/Wi-Fi
```

At the receiver:

```text
Ethernet/Wi-Fi
 ↓
IP
 ↓
TCP
 ↓
HTTP
```

This is **encapsulation + decapsulation**.

---

# 5. Protocol Dependency

Higher-layer protocols use the services of lower layers.

```text
HTTP
 ↓ uses
TCP
 ↓ uses
IP
 ↓ uses
Ethernet
```

For example:

> HTTP doesn't need to know how Ethernet physically transmits bits.

This is **layering/abstraction**.

---

# 6. Same-Layer Communication

The corresponding protocol entities on different hosts are **peers**.

```text
Host A                     Host B

HTTP  ←── HTTP rules ──→  HTTP
TCP   ←── TCP rules ───→  TCP
IP    ←── IP rules ─────→ IP
```

The actual data, however, travels through the lower layers.

---

# 7. Encapsulation Example ⭐⭐⭐⭐⭐

Application generates:

```text
HTTP Data
```

TCP adds a header:

```text
[TCP Header][HTTP Data]
```

IP adds a header:

```text
[IP Header][TCP Header][HTTP Data]
```

Ethernet adds its header/trailer:

```text
[Ethernet Header][IP Header][TCP Header][HTTP Data][FCS]
```

Then it becomes bits/signals for transmission.

---

# 8. Important Protocol Relationships

### Web

```text
HTTP/HTTPS
    ↓
TCP* 
    ↓
IP
    ↓
Ethernet/Wi-Fi
```

### DNS

```text
DNS
 ↓
UDP/TCP*
 ↓
IP
 ↓
Ethernet/Wi-Fi
```

*Modern protocols can use different transports; for example, HTTP/3 uses QUIC over UDP.

---

# 🔥 GATE Traps

### Trap 1

**TCP/IP stack ≠ only TCP + IP.**

It contains many protocols.

---

### Trap 2

A protocol stack is **not the same thing as an OSI model**.

```text
OSI → reference model
TCP/IP → practical protocol suite + layered architecture
```

---

### Trap 3

Protocols in different layers don't perform the same job.

```text
TCP → Transport
IP → Internet
Ethernet → Network Access
```

---

# ⚡ Quick Revision

```text
PROTOCOL STACK

Application → HTTP / DNS
      ↓
Transport   → TCP / UDP
      ↓
Internet    → IP / ICMP
      ↓
Network     → Ethernet / Wi-Fi
```

### Remember

> **Stack = multiple protocols working together layer by layer.**

### GATE Priority: ⭐⭐⭐⭐

Focus on **layer → protocol mapping + encapsulation + how protocols cooperate**.
