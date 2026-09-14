# Protocols in TCP/IP

## 1. Big Picture

TCP/IP is a **protocol suite**, not a single protocol.

```text
Application
├── HTTP/HTTPS
├── DNS
├── FTP
├── SMTP
├── DHCP
└── SSH

Transport
├── TCP
└── UDP

Internet
├── IP
└── ICMP

Network Access
├── Ethernet
└── Wi-Fi
```

---

# 2. Application Layer Protocols ⭐⭐⭐⭐⭐

| Protocol  | Purpose               | Common Port |
| --------- | --------------------- | ----------: |
| **HTTP**  | Web                   |          80 |
| **HTTPS** | Secure web            |         443 |
| **DNS**   | Name resolution       |          53 |
| **FTP**   | File transfer         |       20/21 |
| **SMTP**  | Send/relay email      |      25/587 |
| **POP3**  | Email retrieval       |     110/995 |
| **IMAP**  | Email synchronization |     143/993 |
| **DHCP**  | Host configuration    |       67/68 |
| **SSH**   | Secure remote access  |          22 |

### High-priority GATE

**HTTP, DNS, FTP, SMTP, DHCP**

---

# 3. Transport Layer Protocols ⭐⭐⭐⭐⭐

## TCP

Provides:

* Reliable delivery
* Ordered byte stream
* Connection-oriented communication
* Flow control
* Congestion control
* Retransmission

```text
TCP → Reliable + Ordered
```

## UDP

Provides:

* Connectionless datagrams
* Low overhead
* No built-in delivery guarantee
* No built-in ordering guarantee

```text
UDP → Simple + Lightweight
```

---

# 4. Internet Layer Protocols ⭐⭐⭐⭐⭐

## IP

Main job:

> **Logical addressing + packet forwarding/routing across networks**

Versions:

* IPv4 → 32-bit
* IPv6 → 128-bit

---

## ICMP

Used for **error reporting and network diagnostics**.

Examples:

```text
ping
traceroute
```

### Important

> ICMP is carried directly inside IP packets; it is **not TCP or UDP**.

---

# 5. Network Access Protocols

Examples:

* Ethernet
* Wi-Fi
* PPP

Responsible for communication over the local link/physical medium.

```text
Frame + MAC + local transmission
```

---

# 6. How They Work Together ⭐⭐⭐⭐⭐

When you open a website:

```text
HTTP/HTTPS
     ↓
TCP* 
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
HTTP/HTTPS
```

*HTTP/3 uses **QUIC over UDP**, so don't memorize "HTTP always uses TCP."

---

# 7. Important Protocol Mapping 🔥

```text
HTTP  → Application
DNS   → Application
DHCP  → Application

TCP   → Transport
UDP   → Transport

IP    → Internet
ICMP  → Internet

Ethernet → Network Access
Wi-Fi    → Network Access
```

---

# 8. Port Numbers — Must Know

### Memorize these first:

```text
FTP   → 20/21
SSH   → 22
SMTP  → 25
DNS   → 53
DHCP  → 67/68
HTTP  → 80
POP3  → 110
IMAP  → 143
HTTPS → 443
```

### Trick

Don't memorize every port blindly. First understand:

> **Port number identifies a transport-layer endpoint/process.**

---

# 🔥 GATE Traps

### 1. DNS ≠ DHCP

```text
DNS  → Name ↔ IP resolution
DHCP → Network configuration
```

### 2. TCP ≠ IP

```text
TCP → L4
IP  → L3
```

### 3. ICMP ≠ TCP/UDP

ICMP is a network-layer protocol carried by IP.

### 4. HTTPS ≠ separate application protocol

Conceptually:

```text
HTTP + TLS → HTTPS
```

### 5. HTTP doesn't always mean TCP

HTTP/1.1 and HTTP/2 commonly use TCP, while **HTTP/3 uses QUIC over UDP**.

---

# ⚡ 30-Second Revision

```text
APPLICATION
HTTP  → Web
DNS   → Name resolution
FTP   → Files
SMTP  → Email sending
DHCP  → Configuration
SSH   → Remote login

TRANSPORT
TCP   → Reliable
UDP   → Lightweight

INTERNET
IP    → Addressing + Routing
ICMP  → Errors + Diagnostics

NETWORK ACCESS
Ethernet / Wi-Fi → Local transmission
```

### Core GATE memory

> **HTTP/DNS → Application**

> **TCP/UDP → Transport**

> **IP/ICMP → Internet**

> **Ethernet/Wi-Fi → Network Access**

**GATE Priority: ⭐⭐⭐⭐⭐**
**Placement Priority: ⭐⭐⭐⭐⭐**

Next: **`OSI vs TCP IP.md`**.
