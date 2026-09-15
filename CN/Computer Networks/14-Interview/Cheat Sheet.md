````md
# Computer Networks — Interview Cheat Sheet

## 1. OSI Model ⭐⭐⭐⭐⭐

| Layer | Name | Key Concept | Examples |
|---|---|---|---|
| 7 | Application | Network services | HTTP, DNS, FTP, SMTP |
| 6 | Presentation | Translation, encryption, compression | TLS-related functions |
| 5 | Session | Session management | — |
| 4 | Transport | Process-to-process | TCP, UDP |
| 3 | Network | Routing, IP | IP, ICMP |
| 2 | Data Link | Frames, MAC | Ethernet, Wi-Fi |
| 1 | Physical | Bits/signals | Cable, fiber |

### Addressing

```text
MAC  → Layer 2 → Local/link delivery
IP   → Layer 3 → Host/network delivery
Port → Layer 4 → Process/application
````

---

# 2. TCP/IP Model

```text
Application
Transport
Internet
Network Access
```

Mapping:

```text
OSI 7+6+5 → Application
OSI 4     → Transport
OSI 3     → Internet
OSI 2+1   → Network Access
```

---

# 3. Encapsulation ⭐⭐⭐⭐⭐

```text
Application Data
      ↓
TCP Segment / UDP Datagram
      ↓
IP Packet
      ↓
Ethernet Frame
      ↓
Bits
```

Receiver performs the reverse:

```text
Bits → Frame → Packet → Segment → Data
```

---

# 4. TCP vs UDP ⭐⭐⭐⭐⭐

| TCP                  | UDP                            |
| -------------------- | ------------------------------ |
| Connection-oriented  | Connectionless                 |
| Reliable             | Best effort                    |
| Ordered              | No ordering guarantee          |
| ACK + retransmission | No ACK/retransmission          |
| Flow control         | No built-in flow control       |
| Congestion control   | No built-in congestion control |
| Byte stream          | Datagram                       |
| 20+ byte header      | 8-byte header                  |

### Interview answer

> **TCP provides reliable, ordered byte-stream communication, while UDP provides lightweight connectionless datagram communication.**

---

# 5. TCP 3-Way Handshake ⭐⭐⭐⭐⭐

```text
Client                    Server
  │                         │
  │──── SYN ───────────────>│
  │<─── SYN + ACK ──────────│
  │──── ACK ───────────────>│
  │                         │
       Connection established
```

Purpose:

* Establish connection
* Synchronize sequence numbers
* Confirm both directions are reachable

🔥 SYN consumes **1 sequence number**.

---

# 6. TCP Connection Termination

Usually 4 steps:

```text
FIN
 ↓
ACK
 ↓
FIN
 ↓
ACK
```

Why 4-way?

> TCP is full-duplex, so each direction is closed independently.

### FIN vs RST

```text
FIN → graceful termination
RST → abrupt/reset termination
```

---

# 7. TCP Reliability ⭐⭐⭐⭐⭐

TCP uses:

```text
Sequence Numbers
ACKs
Checksum
Retransmission
Timers
```

### ACK

TCP ACK generally means:

> **Next byte expected**

Example:

```text
Received bytes 1–100
ACK = 101
```

---

# 8. Flow Control vs Congestion Control ⭐⭐⭐⭐⭐

| Flow Control      | Congestion Control |
| ----------------- | ------------------ |
| Protects receiver | Protects network   |
| Receiver capacity | Network capacity   |
| `rwnd`            | `cwnd`             |

Effective TCP sending window:

```text
Effective Window = min(rwnd, cwnd)
```

🔥 Very common interview question.

---

# 9. TCP Congestion Control

### Slow Start

Approximately exponential growth:

```text
1 → 2 → 4 → 8 → 16 ...
```

### Congestion Avoidance

Approximately linear growth.

### AIMD

```text
Additive Increase
Multiplicative Decrease
```

---

# 10. IP Addressing ⭐⭐⭐⭐⭐

IPv4:

```text
32 bits
```

IPv6:

```text
128 bits
```

IPv4 example:

```text
192.168.1.10
```

IPv4 private ranges:

```text
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16
```

Loopback:

```text
127.0.0.1
```

---

# 11. Subnetting

For IPv4:

```text
Host bits = 32 − prefix
```

Total addresses:

```text
2^h
```

Traditional usable hosts:

```text
2^h − 2
```

Example:

```text
192.168.1.0/26

Host bits = 6
Addresses = 2^6 = 64
Usable = 62
```

🔥 `/24 → /26` creates **4 subnets**.

---

# 12. CIDR

CIDR allows arbitrary prefix lengths.

Example:

```text
192.168.1.0/24
192.168.2.0/24
192.168.3.0/24
192.168.4.0/24
```

Can potentially be summarized when properly aligned/contiguous.

### Longest Prefix Match

If multiple routes match:

> **Most specific prefix wins.**

---

# 13. ARP ⭐⭐⭐⭐⭐

ARP maps:

```text
IPv4 Address → MAC Address
```

Typical process:

```text
ARP Request → Broadcast
ARP Reply   → Unicast
```

🔥 For a remote destination:

```text
Host ARPs for → Default Gateway MAC
```

It does **not** ARP for the remote server's MAC.

---

# 14. Routing vs Forwarding ⭐⭐⭐⭐⭐

### Routing

Determines:

> **Which path should be used?**

### Forwarding

Actually:

> **Moves the packet to the next hop/interface.**

```text
Routing → path decision
Forwarding → packet movement
```

---

# 15. Routing Algorithms

| Type            | Algorithm    | Example |
| --------------- | ------------ | ------- |
| Distance Vector | Bellman-Ford | RIP     |
| Link State      | Dijkstra     | OSPF    |

### Distance Vector

```text
"What is the distance to destination?"
```

Problem:

```text
Count-to-infinity
```

### Link State

```text
"What's the network topology?"
```

Routers build topology information and run SPF.

---

# 16. IPv4 Fragmentation ⭐⭐⭐⭐

Important fields:

```text
Identification
DF
MF
Fragment Offset
```

Fragment offset is measured in:

```text
8-byte units
```

🔥 IPv4 routers may fragment packets.

🔥 IPv6 routers do **not** fragment packets.

---

# 17. IPv4 vs IPv6

| IPv4                 | IPv6                    |
| -------------------- | ----------------------- |
| 32-bit               | 128-bit                 |
| Header checksum      | No base-header checksum |
| Broadcast supported  | No broadcast            |
| Routers may fragment | Routers don't fragment  |
| ARP                  | NDP/ICMPv6              |
| TTL                  | Hop Limit               |

IPv6 base header:

```text
40 bytes
```

---

# 18. DNS ⭐⭐⭐⭐⭐

DNS:

```text
Domain Name ↔ IP Address
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

Important records:

```text
A      → IPv4
AAAA   → IPv6
CNAME  → Alias
MX     → Mail server
NS     → Name server
PTR    → Reverse DNS
```

DNS commonly:

```text
UDP 53
```

TCP 53 is also used when required, including traditional zone transfers.

---

# 19. HTTP ⭐⭐⭐⭐⭐

HTTP is:

```text
Request → Response
```

Common methods:

```text
GET
POST
PUT
PATCH
DELETE
HEAD
OPTIONS
```

Important:

```text
GET    → retrieve
POST   → submit/create
PUT    → replace
PATCH  → partial update
DELETE → delete
```

---

# 20. HTTP Status Codes

```text
1xx → Informational
2xx → Success
3xx → Redirection
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
401 → Authentication required/failed
403 → Forbidden
404 → Not Found
405 → Method Not Allowed
429 → Too Many Requests

500 → Internal Server Error
502 → Bad Gateway
503 → Service Unavailable
504 → Gateway Timeout
```

🔥

```text
401 → Who are you?
403 → I know you, but you can't do this.
```

---

# 21. HTTPS ⭐⭐⭐⭐⭐

```text
HTTPS = HTTP + TLS
```

Provides:

* Confidentiality
* Integrity
* Authentication

Typical:

```text
HTTPS → TCP 443
```

HTTP/3:

```text
HTTP/3
  ↓
QUIC
  ↓
UDP
```

---

# 22. Cookies vs Sessions vs JWT ⭐⭐⭐⭐⭐

### Cookie

Small data stored by browser.

```text
Server → Set-Cookie
Browser → Cookie
```

### Session

Server-side mechanism for maintaining user state.

```text
Browser → Session ID → Server
```

### JWT

Token containing claims:

```text
Header.Payload.Signature
```

🔥 JWT is **encoded**, not encrypted by default.

---

# 23. Authentication vs Authorization

```text
Authentication → WHO are you?
Authorization   → WHAT can you do?
```

Example:

```text
Login           → Authentication
Admin permission → Authorization
```

---

# 24. Hashing vs Encryption

| Hashing                | Encryption          |
| ---------------------- | ------------------- |
| One-way                | Reversible with key |
| Integrity/fingerprints | Confidentiality     |
| SHA-256                | AES/RSA             |
| No decryption          | Decryption possible |

🔥 Passwords should generally be stored using **salted password hashing**, not encryption/plaintext.

---

# 25. Symmetric vs Asymmetric Encryption

### Symmetric

```text
Same secret key
Encryption ↔ Decryption
```

Fast.

Examples:

```text
AES
```

### Asymmetric

```text
Public Key
Private Key
```

Examples:

```text
RSA
ECC
```

Used for authentication/key establishment and related cryptographic operations.

---

# 26. Digital Signature

```text
Private Key → Sign
Public Key  → Verify
```

Provides:

* Integrity
* Authentication
* Non-repudiation

🔥 Digital signature is **not encryption**.

---

# 27. Firewall ⭐⭐⭐⭐⭐

Firewall:

> Allows or blocks traffic according to security rules.

Can filter using:

```text
IP
Port
Protocol
Connection state
Application data
```

### Stateless

Examines packets independently.

### Stateful

Tracks connection state.

---

# 28. Proxy vs Reverse Proxy

### Forward Proxy

```text
Client → Proxy → Internet
```

Represents the **client**.

### Reverse Proxy

```text
Client → Reverse Proxy → Backend
```

Represents the **server/backend**.

Common functions:

* TLS termination
* Caching
* Routing
* Load balancing
* Security filtering

---

# 29. Load Balancer

Distributes traffic among backend servers.

```text
             ┌→ Server 1
Client → LB ─┼→ Server 2
             └→ Server 3
```

Algorithms:

```text
Round Robin
Weighted Round Robin
Least Connections
IP Hash
```

### L4 LB

Uses:

```text
IP + TCP/UDP + Port
```

### L7 LB

Can use:

```text
HTTP path
Host
Headers
Cookies
```

---

# 30. CDN ⭐⭐⭐⭐

**CDN = Content Delivery Network**

```text
User
 ↓
Nearby CDN Edge
 ↓
Cache
```

### Cache Hit

```text
Edge → Content
```

### Cache Miss

```text
Edge → Origin → Edge → User
```

Benefits:

* Lower latency
* Reduced origin load
* Better scalability
* Better content availability

🔥 CDN ≠ Load Balancer ≠ DNS.

---

# 31. WebSocket ⭐⭐⭐⭐⭐

Provides:

```text
Persistent + Full Duplex
```

```text
Client ←────────→ Server
```

Starts with HTTP Upgrade:

```text
HTTP Upgrade
     ↓
101 Switching Protocols
     ↓
WebSocket
```

Common:

```text
ws  → 80
wss → 443 + TLS
```

Used for:

* Chat
* Gaming
* Live notifications
* Real-time dashboards

---

# 32. Wi-Fi ⭐⭐⭐⭐

IEEE:

```text
802.11
```

Uses:

```text
CSMA/CA
```

Why not CSMA/CD?

> Wireless stations generally cannot reliably detect collisions while transmitting.

### Hidden Terminal

```text
A → B ← C

A and C cannot hear each other
```

RTS/CTS can help.

---

# 33. Ethernet ⭐⭐⭐⭐⭐

IEEE:

```text
802.3
```

Ethernet uses:

```text
MAC addresses
Frames
```

Modern switched Ethernet generally uses:

```text
Full Duplex
```

Therefore:

> Collisions are not normally present and CSMA/CD is not needed.

---

# 34. CSMA/CD vs CSMA/CA

| CSMA/CD                     | CSMA/CA                |
| --------------------------- | ---------------------- |
| Collision Detection         | Collision Avoidance    |
| Traditional shared Ethernet | Wi-Fi                  |
| Detect collision            | Try to avoid collision |
| Jam signal                  | ACK/random backoff     |

---

# 35. Physical Layer Delays ⭐⭐⭐⭐

### Transmission Delay

Time to push all bits onto link:

```text
Tt = L / R
```

### Propagation Delay

Time for signal to travel:

```text
Tp = Distance / Propagation Speed
```

🔥

```text
Transmission → depends on packet size + data rate
Propagation   → depends on distance + signal speed
```

---

# 36. Multiplexing

Combines multiple signals over one shared medium.

```text
Signals
 A
 B → MUX → Shared Link → DEMUX → A
 C                              → B
                                → C
```

Types:

```text
FDM → Frequency
TDM → Time
WDM → Wavelength
CDM → Code
```

🔥 WDM is particularly associated with **optical fiber**.

---

# 37. Common Port Numbers ⭐⭐⭐⭐⭐

| Protocol |    Port |
| -------- | ------: |
| FTP      |   20/21 |
| SSH      |      22 |
| SMTP     |      25 |
| DNS      |      53 |
| DHCP     |   67/68 |
| HTTP     |      80 |
| POP3     |     110 |
| IMAP     |     143 |
| HTTPS    |     443 |
| Telnet   |      23 |
| SNMP     | 161/162 |

Remember:

```text
SSH    → 22
DNS    → 53
HTTP   → 80
HTTPS  → 443
```

---

# 38. Common Interview One-Liners

### Hub vs Switch vs Router

```text
Hub    → L1 → Broadcasts signal to ports
Switch → L2 → MAC-based forwarding
Router → L3 → IP-based forwarding
```

### MAC vs IP

```text
MAC → local/link delivery
IP  → inter-network delivery
```

### Bandwidth vs Throughput

```text
Bandwidth → theoretical capacity
Throughput → actual achieved rate
```

### Latency

> Time taken for data to travel from source to destination.

### Packet vs Frame

```text
Packet → Network Layer
Frame  → Data Link Layer
```

---

# 🔥 Top 15 Interview Traps

1. **TCP is byte-stream, not message-oriented.**
2. **UDP has a checksum**; unreliable ≠ no error detection.
3. **ARP maps IPv4 → MAC**, not MAC → IPv4.
4. For remote destinations, ARP resolves the **next-hop gateway MAC**.
5. **DNS TTL ≠ IP TTL.**
6. **401 ≠ 403**.
7. **JWT is not encrypted by default.**
8. **Authentication ≠ authorization.**
9. **Flow control ≠ congestion control.**
10. **Routing ≠ forwarding.**
11. **Switch ≠ router.**
12. **CDN ≠ load balancer.**
13. **WebSocket is full-duplex.**
14. **IPv6 routers do not fragment packets.**
15. **Modern full-duplex Ethernet doesn't use CSMA/CD.**

---

# ⚡ Final 60-Second Revision

```text
OSI:
7 Application
6 Presentation
5 Session
4 Transport
3 Network
2 Data Link
1 Physical

Address:
MAC → L2
IP  → L3
Port → L4

TCP:
Reliable + Ordered + Byte Stream

UDP:
Connectionless + Datagram + Lightweight

TCP Handshake:
SYN → SYN/ACK → ACK

Termination:
FIN → ACK → FIN → ACK

DNS:
Name → IP

ARP:
IPv4 → MAC

Routing:
Path selection

Forwarding:
Packet movement

Flow Control:
Protect receiver

Congestion Control:
Protect network

HTTP:
Request ↔ Response

HTTPS:
HTTP + TLS

WebSocket:
Persistent + Full Duplex

CDN:
Cache + Edge + Lower latency

Firewall:
Allow/Block traffic

Proxy:
Represents client

Reverse Proxy:
Represents server

Load Balancer:
Distributes traffic

Ethernet:
802.3

Wi-Fi:
802.11 + CSMA/CA

IPv4:
32-bit

IPv6:
128-bit
```

### 🎯 Interview Priority

**⭐⭐⭐⭐⭐ Must know:**
TCP/UDP, OSI, HTTP/HTTPS, DNS, IP/subnetting, ARP, routing, switching, flow vs congestion control, authentication/authorization, WebSocket, load balancing.

**⭐⭐⭐⭐ Good to know:**
CDN, firewall, VPN, IPv6, CSMA/CA/CD, TLS, DHCP, cookies/JWT.

**⭐⭐⭐ Supporting:**
SNMP, Bluetooth, FTP/SMTP/POP3/IMAP, multiplexing, detailed physical-layer concepts.

```
```
