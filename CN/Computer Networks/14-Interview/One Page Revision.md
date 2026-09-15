````md id="one-page-cn-revision"
# Computer Networks — One Page Revision

## 🔹 OSI Model

```text
7 Application    → HTTP, DNS, FTP
6 Presentation   → Encryption, compression, translation
5 Session        → Session management
4 Transport      → TCP, UDP, ports
3 Network        → IP, routing
2 Data Link      → MAC, frames, Ethernet
1 Physical       → Bits, signals, cables
````

### Addressing

```text
MAC  → L2 → Local/link delivery
IP   → L3 → Inter-network delivery
Port → L4 → Process identification
```

---

# 🔹 Encapsulation

```text
Application Data
      ↓
Segment / Datagram
      ↓
IP Packet
      ↓
Frame
      ↓
Bits
```

---

# 🔹 Devices

```text
Repeater → L1 → Regenerate signal
Hub      → L1 → Send to all ports
Switch   → L2 → MAC → Frame
Router   → L3 → IP → Packet
Gateway  → Protocol/application boundary
```

🔥 Switch separates collision domains.
🔥 Router separates broadcast domains.

---

# 🔹 TCP vs UDP

| TCP                 | UDP                            |
| ------------------- | ------------------------------ |
| Connection-oriented | Connectionless                 |
| Reliable            | Best effort                    |
| Ordered             | No ordering guarantee          |
| Byte stream         | Datagram                       |
| ACK/retransmission  | No built-in ACK/retransmission |
| Flow control        | No built-in flow control       |
| Congestion control  | No built-in congestion control |
| 20–60 B header      | 8 B header                     |

```text
TCP → Reliable byte stream
UDP → Lightweight datagrams
```

---

# 🔹 TCP Handshake

```text
Client              Server
  │── SYN ──────────→│
  │←─ SYN + ACK ─────│
  │── ACK ──────────→│
```

🔥 SYN consumes 1 sequence number.

### Termination

```text
FIN → ACK → FIN → ACK
```

**FIN = graceful**
**RST = abrupt**

---

# 🔹 TCP Reliability

```text
Sequence Numbers
ACKs
Checksum
Retransmission
Timers
```

ACK generally means:

> **Next byte expected**

### Loss detection

```text
Timeout
Duplicate ACKs
```

Traditional Fast Retransmit:

```text
3 duplicate ACKs → retransmission
```

---

# 🔹 Flow vs Congestion Control

```text
Flow Control
→ Protect receiver
→ rwnd

Congestion Control
→ Protect network
→ cwnd
```

```text
Effective Window = min(rwnd, cwnd)
```

### Congestion Control

```text
Slow Start       → approximately exponential
Congestion Avoid → approximately linear
AIMD             → Additive Increase, Multiplicative Decrease
```

---

# 🔹 IP

### IPv4

```text
32 bits
```

### IPv6

```text
128 bits
```

### Important IPv4 ranges

```text
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16     → Private

127.0.0.0/8        → Loopback
169.254.0.0/16     → Link-local
```

---

# 🔹 Subnetting

```text
Host bits = 32 − prefix
Addresses = 2^h
Traditional usable = 2^h − 2
```

Example:

```text
/26
Host bits = 6
Addresses = 64
Usable = 62
```

### CIDR

```text
192.168.1.0/24
       ↑
   24 network bits
```

🔥 Longest Prefix Match → most specific route wins.

---

# 🔹 ARP

```text
IPv4 Address → MAC Address
```

```text
Request → Broadcast
Reply   → Usually Unicast
```

Remote destination:

```text
Host → ARP for Default Gateway MAC
```

🔥 Not remote server MAC.

---

# 🔹 Routing

```text
Routing   → Determines path
Forwarding → Sends packet to next hop
```

| Type            | Algorithm    | Protocol |
| --------------- | ------------ | -------- |
| Distance Vector | Bellman-Ford | RIP      |
| Link State      | Dijkstra     | OSPF     |

```text
DV → Neighbor information
LS → Network topology
```

DV problem:

```text
Count-to-infinity
```

---

# 🔹 IPv4 Fragmentation

Important fields:

```text
Identification
DF
MF
Fragment Offset
```

```text
Fragment Offset → 8-byte units
```

🔥 IPv4 routers may fragment.
🔥 IPv6 routers do not fragment.

---

# 🔹 TTL

```text
Router → TTL − 1
```

When TTL reaches zero:

```text
Discard + ICMP Time Exceeded
```

Used by **traceroute**.

---

# 🔹 ICMP

Used for:

* Error reporting
* Diagnostics
* Control/informational messages

```text
Ping       → Echo Request/Reply
Traceroute → Time Exceeded
```

🔥 ICMP does not use TCP/UDP ports.

---

# 🔹 IPv6

```text
128-bit address
40-byte base header
No broadcast
No base-header checksum
```

Important:

```text
::1       → Loopback
::/128    → Unspecified
fe80::/10 → Link-local
```

```text
IPv4 → ARP
IPv6 → NDP / ICMPv6
```

---

# 🔹 DNS

```text
Domain → IP
```

Resolution:

```text
Client
 ↓
Recursive Resolver
 ↓
Root
 ↓
TLD
 ↓
Authoritative Server
 ↓
IP
```

### Records

```text
A      → IPv4
AAAA   → IPv6
CNAME  → Alias
MX     → Mail
NS     → Name Server
PTR    → Reverse DNS
```

```text
DNS TTL → Cache lifetime
IP TTL  → Hop limitation
```

🔥 DNS commonly uses UDP 53, but TCP 53 is also used.

---

# 🔹 DHCP

Automatically provides:

* IP
* Subnet configuration
* Gateway
* DNS
* Lease

### DORA

```text
Discover → Offer → Request → ACK
```

```text
Server → UDP 67
Client → UDP 68
```

---

# 🔹 HTTP

```text
Request → Response
```

Methods:

```text
GET    → Retrieve
POST   → Submit/Create
PUT    → Replace
PATCH  → Partial update
DELETE → Delete
HEAD   → Headers only
OPTIONS→ Options/capabilities
```

### Status Codes

```text
1xx → Information
2xx → Success
3xx → Redirect
4xx → Client/request error
5xx → Server error
```

Important:

```text
200 → OK
201 → Created
204 → No Content

301 → Permanent redirect
302 → Temporary redirect
304 → Not Modified

400 → Bad Request
401 → Authentication problem
403 → Forbidden
404 → Not Found
405 → Method Not Allowed
429 → Too Many Requests

500 → Internal Server Error
502 → Bad Gateway
503 → Service Unavailable
504 → Gateway Timeout
```

🔥 **401 = authentication**
🔥 **403 = authorization/permission**

---

# 🔹 HTTPS

```text
HTTPS = HTTP + TLS
```

Provides:

```text
Confidentiality
Integrity
Authentication
```

```text
HTTPS → TCP 443
```

HTTP/3:

```text
HTTP/3 → QUIC → UDP
```

---

# 🔹 Cookies / Sessions / JWT

### Cookie

```text
Browser-stored data
```

### Session

```text
Session ID → Server-side state
```

### JWT

```text
Header.Payload.Signature
```

🔥 JWT is **not encrypted by default**.

---

# 🔹 Authentication / Authorization

```text
Authentication → WHO?
Authorization   → WHAT?
```

Example:

```text
Login       → Authentication
Admin access → Authorization
```

---

# 🔹 Cryptography

### Symmetric

```text
Same secret key
Fast
AES
```

### Asymmetric

```text
Public + Private key
RSA / ECC
```

### Hash

```text
Input → Fixed-size digest
SHA-256
```

🔥 Hash ≠ encryption.

### Digital Signature

```text
Private Key → Sign
Public Key  → Verify
```

Provides:

```text
Integrity
Authentication
Non-repudiation
```

---

# 🔹 Firewall

```text
Firewall → Allow / Block traffic according to rules
```

### Stateless

```text
Packet-by-packet
```

### Stateful

```text
Tracks connection state
```

---

# 🔹 Proxy

### Forward Proxy

```text
Client → Proxy → Internet
```

Represents client.

### Reverse Proxy

```text
Client → Reverse Proxy → Backend
```

Represents server/backend.

---

# 🔹 Load Balancer

```text
Client
  ↓
Load Balancer
 ├── Server 1
 ├── Server 2
 └── Server 3
```

Algorithms:

```text
Round Robin
Weighted Round Robin
Least Connections
IP Hash
```

```text
L4 → IP + Port + TCP/UDP
L7 → HTTP path/host/headers etc.
```

---

# 🔹 CDN

```text
User
 ↓
Nearby Edge
 ↓
Cache
```

```text
Cache HIT  → Serve cached content
Cache MISS → Fetch from origin
```

Benefits:

```text
Lower latency
Less origin load
Better scalability
```

---

# 🔹 WebSocket

```text
Persistent + Full Duplex
```

```text
Client ←────────→ Server
```

Starts with:

```text
HTTP Upgrade
     ↓
101 Switching Protocols
     ↓
WebSocket
```

```text
ws  → 80
wss → 443 + TLS
```

---

# 🔹 Ethernet / Wi-Fi

### Ethernet

```text
IEEE 802.3
MAC + Frames
```

Modern switched Ethernet:

```text
Full Duplex
→ Normally no collisions
→ CSMA/CD not needed
```

### Wi-Fi

```text
IEEE 802.11
CSMA/CA
```

Why CA?

> Wireless stations generally cannot reliably detect collisions while transmitting.

---

# 🔹 CSMA/CD vs CSMA/CA

```text
CSMA/CD → Collision Detection → Traditional Ethernet
CSMA/CA → Collision Avoidance → Wi-Fi
```

Wi-Fi hidden terminal:

```text
A → B ← C
```

RTS/CTS can help.

---

# 🔹 Physical Layer Delays

### Transmission

```text
Tt = L / R
```

Depends on:

* Packet size
* Data rate

### Propagation

```text
Tp = Distance / Propagation Speed
```

Depends on:

* Distance
* Signal propagation speed

🔥 Transmission ≠ propagation delay.

---

# 🔹 Multiplexing

```text
MUX → Combine
DEMUX → Separate
```

```text
FDM → Frequency
TDM → Time
WDM → Wavelength
CDM → Code
```

🔥 WDM → Optical fiber.

---

# 🔹 Important Ports

| Protocol |    Port |
| -------- | ------: |
| FTP      |   20/21 |
| SSH      |      22 |
| Telnet   |      23 |
| SMTP     |      25 |
| DNS      |      53 |
| DHCP     |   67/68 |
| HTTP     |      80 |
| POP3     |     110 |
| IMAP     |     143 |
| HTTPS    |     443 |
| SNMP     | 161/162 |

---

# 🔥 Top Interview Traps

```text
ARP       → IPv4 → MAC
DNS       → Name → IP
DHCP      → Network configuration

TCP       → Byte stream
UDP       → Datagram

MAC       → Local/link
IP        → Inter-network
Port      → Process

Routing   → Path decision
Forwarding→ Packet movement

rwnd      → Receiver
cwnd      → Network

401       → Authentication
403       → Authorization

DNS TTL   → Cache lifetime
IP TTL    → Hop limitation

CDN       → Edge caching
LB        → Traffic distribution

WebSocket → Full duplex

IPv4      → 32-bit
IPv6      → 128-bit

Ethernet  → 802.3
Wi-Fi     → 802.11
```

---

# ⚡ 10 Things to Memorize Before Interview

1. **OSI layers + functions**
2. **TCP 3-way handshake**
3. **TCP 4-way termination**
4. **TCP vs UDP**
5. **Flow vs congestion control**
6. **DNS resolution**
7. **ARP**
8. **Subnetting/CIDR**
9. **HTTP → HTTPS → WebSocket**
10. **Hub → Switch → Router**

---

## 🎯 Priority

**Interview:** ⭐⭐⭐⭐⭐
**GATE revision:** ⭐⭐⭐⭐

> If you can explain every item on this page **without looking at notes**, your Computer Networks fundamentals are interview-ready.

```

**Next: `Real World Examples.md`**.
```
