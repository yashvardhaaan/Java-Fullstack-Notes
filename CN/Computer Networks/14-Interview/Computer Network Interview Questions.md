````md id="cn-interview-questions"
# Computer Network Interview Questions

## 1. What is a computer network?

A **computer network** is a collection of interconnected devices that communicate and share resources using communication protocols.

> Network = Devices + Links + Protocols.

---

## 2. What is a protocol?

A protocol is a set of rules governing communication between network entities.

It defines:

- Syntax → format
- Semantics → meaning
- Timing → when/how fast data is exchanged

---

## 3. What happens when you type a URL in a browser? ⭐⭐⭐⭐⭐

Example:

```text
https://example.com
````

Simplified flow:

```text
URL
 ↓
DNS Resolution
 ↓
IP Address
 ↓
TCP Connection
 ↓
TLS Handshake
 ↓
HTTP Request
 ↓
Server Response
 ↓
Browser renders page
```

For HTTP/3:

```text
DNS
 ↓
QUIC
 ↓
UDP
 ↓
HTTP/3
```

🔥 This is one of the most important placement questions.

---

# 4. What is the difference between MAC and IP address?

| MAC                             | IP                            |
| ------------------------------- | ----------------------------- |
| Layer 2                         | Layer 3                       |
| Link/local address              | Logical/inter-network address |
| Used by switches                | Used by routers               |
| Usually 48-bit Ethernet address | IPv4 32-bit / IPv6 128-bit    |

```text
MAC → local delivery
IP  → inter-network delivery
```

---

# 5. Why do we need IP if we already have MAC?

MAC addresses are designed for **local-link delivery**.

IP provides a logical addressing scheme that supports communication across multiple interconnected networks.

```text
Host A
 ↓
Router
 ↓
Router
 ↓
Host B
```

MAC addresses change hop-by-hop, while the destination IP normally identifies the final host.

---

# 6. What is the difference between hub, switch and router? ⭐⭐⭐⭐⭐

```text
Hub    → L1 → broadcasts signal
Switch → L2 → MAC-based forwarding
Router → L3 → IP-based forwarding
```

| Device | Main Address | Main Unit    |
| ------ | ------------ | ------------ |
| Hub    | None         | Bits/signals |
| Switch | MAC          | Frame        |
| Router | IP           | Packet       |

---

# 7. What is a broadcast domain?

A **broadcast domain** is the set of devices that can receive a Layer-2 broadcast.

```text
Switch
 ├── PC1
 ├── PC2
 └── PC3
```

Normally one VLAN = one broadcast domain.

🔥 A router interface separates broadcast domains.

---

# 8. What is a collision domain?

A collision domain is a network segment in which simultaneous transmissions can collide.

### Hub

All connected devices share one collision domain.

### Switch

Each switch port is normally a separate collision domain.

```text
Hub → One shared collision domain
Switch → Separate collision domain per port
```

Modern full-duplex switched Ethernet normally has no collisions.

---

# 9. What is VLAN? ⭐⭐⭐⭐

**VLAN = Virtual Local Area Network**

It logically divides a physical switch network into separate Layer-2 broadcast domains.

```text
Physical Switch
 ├── VLAN 10 → PCs
 └── VLAN 20 → Servers
```

Devices in different VLANs generally require **Layer-3 routing** to communicate.

---

# 10. What is subnetting?

Subnetting divides a larger IP network into smaller logical networks.

```text
192.168.1.0/24
       ↓
   subnetting
       ↓
multiple smaller networks
```

Benefits:

* Efficient address usage
* Smaller broadcast domains
* Better organization
* Routing scalability

---

# 11. What is CIDR?

**CIDR = Classless Inter-Domain Routing**

It uses prefix notation:

```text
192.168.1.0/24
```

The `/24` means:

```text
24 network bits
8 host bits
```

CIDR also enables route aggregation.

---

# 12. What is ARP? ⭐⭐⭐⭐⭐

ARP resolves:

```text
IPv4 address → MAC address
```

Typical exchange:

```text
ARP Request → Broadcast
ARP Reply   → Unicast
```

For a remote destination:

```text
Host → ARP for gateway MAC
```

Not the remote server's MAC.

---

# 13. What is DNS?

DNS translates domain names into network addresses.

```text
google.com
    ↓
DNS
    ↓
IP address
```

Important records:

```text
A     → IPv4
AAAA  → IPv6
MX    → Mail server
CNAME → Alias
PTR   → Reverse DNS
```

---

# 14. DNS recursive vs iterative query

### Recursive

> "Give me the final answer."

### Iterative

> "I don't have the final answer, but here is where you should look next."

Typical:

```text
Client → Recursive Resolver
Resolver → Root → TLD → Authoritative
```

---

# 15. What is DHCP? ⭐⭐⭐⭐

DHCP automatically provides network configuration such as:

* IP address
* Subnet mask/prefix
* Default gateway
* DNS server
* Lease information

### DORA

```text
Discover
   ↓
Offer
   ↓
Request
   ↓
ACK
```

Uses UDP:

```text
Server → 67
Client → 68
```

---

# 16. TCP 3-way handshake? ⭐⭐⭐⭐⭐

```text
Client                  Server

 SYN ──────────────────→
     ←──────── SYN+ACK
 ACK ──────────────────→
```

Purpose:

* Establish connection
* Synchronize sequence numbers
* Confirm bidirectional communication

---

# 17. Why is TCP handshake 3-way and not 2-way?

Two messages are insufficient for both sides to reliably confirm that the other side has received the required information and can communicate using the synchronized sequence numbers.

```text
SYN
 ↓
SYN-ACK
 ↓
ACK
```

The third ACK confirms receipt of the server's SYN.

---

# 18. Why TCP termination usually requires 4 messages?

TCP is full-duplex.

Each direction is closed independently:

```text
FIN
 ↓
ACK
 ↓
FIN
 ↓
ACK
```

Therefore one side can stop sending while still receiving.

---

# 19. What is TIME_WAIT?

TIME_WAIT is a TCP state maintained by the endpoint that actively closes the connection.

Main purposes:

1. Allow delayed old segments to expire.
2. Allow retransmission of the final ACK if the peer retransmits its FIN.

🔥 Don't say TIME_WAIT simply means "waiting for the server."

---

# 20. TCP sequence number vs ACK number

### Sequence number

Identifies the position of transmitted bytes in the TCP byte stream.

### ACK number

Generally indicates:

> The next byte expected.

Example:

```text
Received bytes 1000–1999
ACK = 2000
```

---

# 21. What is flow control?

Flow control prevents a fast sender from overwhelming a slow receiver.

TCP uses:

```text
rwnd = receiver advertised window
```

---

# 22. What is congestion control?

Congestion control prevents excessive traffic from overwhelming the network.

TCP uses:

```text
cwnd = congestion window
```

Effective sending window:

```text
min(rwnd, cwnd)
```

🔥

```text
Flow control     → Receiver
Congestion control → Network
```

---

# 23. What happens when a TCP segment is lost?

TCP can detect loss through:

* Timeout
* Duplicate ACKs

Traditional Fast Retransmit:

```text
3 duplicate ACKs
       ↓
Retransmit
```

---

# 24. TCP byte stream means what?

TCP treats application data as a continuous sequence of bytes.

It **does not preserve application message boundaries**.

If application sends:

```text
"HELLO"
"WORLD"
```

Receiver may read:

```text
"HELLOW"
"ORLD"
```

or another grouping.

🔥 TCP is **byte-stream oriented**.

---

# 25. UDP preserves message boundaries?

**Yes.**

Each UDP datagram is a separate message unit.

```text
send("ABC")
send("XYZ")

→ receiver receives separate datagrams
```

---

# 26. What is MTU?

**MTU = Maximum Transmission Unit**

It is the maximum IP packet size that can normally be carried in one link-layer frame without fragmentation on that link.

Common Ethernet MTU:

```text
1500 bytes
```

🔥 MTU ≠ Ethernet frame size.

---

# 27. What is fragmentation?

Fragmentation divides an IP packet into smaller fragments when required by IPv4 forwarding conditions.

IPv4 uses:

```text
Identification
DF
MF
Fragment Offset
```

Fragment offset uses:

```text
8-byte units
```

IPv6 routers do not fragment packets.

---

# 28. What is TTL?

IPv4 **TTL = Time To Live**.

A router normally decrements TTL by 1.

```text
TTL = 3
 ↓ Router
TTL = 2
 ↓ Router
TTL = 1
 ↓ Router
TTL = 0
 ↓
Discard
```

An ICMP Time Exceeded message can be generated.

🔥 TTL prevents packets from circulating forever.

---

# 29. How does traceroute work? ⭐⭐⭐⭐⭐

Traceroute manipulates TTL/Hop Limit values to cause intermediate routers to generate expiration messages.

Simplified:

```text
TTL=1 → Router 1 responds
TTL=2 → Router 2 responds
TTL=3 → Router 3 responds
...
```

It discovers the path hop-by-hop.

---

# 30. What is ICMP?

**ICMP = Internet Control Message Protocol**

Used for:

* Error reporting
* Diagnostics
* Control/informational messages

Examples:

```text
Ping       → Echo Request/Reply
Traceroute → Time Exceeded
```

🔥 ICMP does not use TCP/UDP ports.

---

# 31. Ping uses TCP or UDP?

**Neither.**

Ping uses:

```text
ICMP Echo Request
ICMP Echo Reply
```

---

# 32. What is a default gateway?

The default gateway is the router/next-hop device used when the destination is not on the local network.

```text
PC
 ↓
Default Gateway
 ↓
Other networks
```

---

# 33. What is longest prefix matching? ⭐⭐⭐⭐⭐

If multiple routing-table entries match a destination, the route with the **longest/more specific prefix** is selected.

Example:

```text
10.0.0.0/8
10.1.0.0/16
10.1.2.0/24
```

Destination:

```text
10.1.2.50
```

Matches all three.

Choose:

```text
10.1.2.0/24
```

because `/24` is most specific.

---

# 34. Distance Vector vs Link State

```text
Distance Vector → Bellman-Ford → RIP
Link State      → Dijkstra     → OSPF
```

### DV

Routers exchange distance information with neighbors.

### LS

Routers build a topology database and calculate shortest paths.

---

# 35. What is NAT?

**NAT = Network Address Translation**

It translates IP addressing information, commonly between private and public address spaces.

Example:

```text
Private network
192.168.1.10
      ↓
    NAT
      ↓
Public IP
```

Common home NAT also translates port information, often called **PAT/NAPT**.

---

# 36. Private IP vs Public IP

### Private IP

Used inside private networks.

Important IPv4 ranges:

```text
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16
```

### Public IP

Globally routable address space used for Internet communication.

🔥 Private IP addresses are not directly Internet-routable as ordinary public destinations.

---

# 37. What is a VPN?

A VPN creates a logical connection/tunnel across an underlying network.

```text
User
 ↓
Encrypted VPN Tunnel
 ↓
Private Network
```

Important:

> Tunneling and encryption are related but not identical concepts.

---

# 38. Firewall vs Router

### Router

Primarily forwards packets between networks.

### Firewall

Enforces security rules to allow/block traffic.

A single device can perform both functions.

---

# 39. Stateful vs Stateless Firewall

### Stateless

Examines packets independently.

### Stateful

Tracks connection/session state.

```text
Stateful:
SYN → connection tracked
ACK → related to state
```

---

# 40. What is a proxy?

A proxy acts as an intermediary.

### Forward Proxy

```text
Client → Proxy → Internet
```

Represents the client.

### Reverse Proxy

```text
Client → Reverse Proxy → Server
```

Represents the backend/server.

---

# 41. What is a CDN?

A CDN uses geographically distributed edge servers to deliver content closer to users.

```text
User
 ↓
Nearby CDN Edge
 ↓
Cache
```

Benefits:

* Lower latency
* Reduced origin load
* Better scalability

---

# 42. What is WebSocket?

WebSocket provides:

```text
Persistent + Full Duplex
```

```text
Client ←────────→ Server
```

Typical applications:

* Chat
* Gaming
* Live notifications
* Real-time dashboards

---

# 43. What is CSMA/CD?

Used historically with shared/half-duplex Ethernet.

```text
Sense
 ↓
Transmit
 ↓
Detect collision
 ↓
Backoff
 ↓
Retry
```

Modern full-duplex switched Ethernet normally doesn't use it.

---

# 44. What is CSMA/CA?

Used by Wi-Fi.

```text
Sense
 ↓
Random Backoff
 ↓
Transmit
 ↓
ACK
```

Wireless uses collision **avoidance** rather than traditional collision detection.

---

# 45. What is the hidden terminal problem?

Consider:

```text
A → B ← C
```

A and C cannot hear each other but both can communicate with B.

A and C may transmit simultaneously, causing a collision at B.

**RTS/CTS** can help mitigate this problem.

---

# 46. What is the difference between authentication and authorization?

```text
Authentication → Who are you?
Authorization   → What can you do?
```

Example:

```text
Login → Authentication
Read admin page → Authorization
```

---

# 47. What does HTTPS provide?

HTTPS = HTTP + TLS.

Provides:

```text
Confidentiality
Integrity
Authentication
```

Typical HTTPS:

```text
TCP 443
```

---

# 48. What is a digital certificate?

A digital certificate binds:

```text
Identity ↔ Public Key
```

It is issued/signed by a trusted Certificate Authority.

🔥 Certificate ≠ private key.

---

# 49. What is a digital signature?

```text
Private Key → Sign
Public Key  → Verify
```

Provides:

* Integrity
* Authentication
* Non-repudiation

---

# 50. What happens when a browser accesses HTTPS?

Simplified:

```text
DNS
 ↓
TCP connection
 ↓
TLS handshake
 ↓
Certificate validation
 ↓
Session keys established
 ↓
Encrypted HTTP communication
```

🔥 Modern TLS details are more sophisticated, but this is the correct interview-level flow.

---

# 🔥 Rapid-Fire Questions

| Question         | Answer                              |
| ---------------- | ----------------------------------- |
| TCP layer?       | Transport                           |
| IP layer?        | Network                             |
| MAC layer?       | Data Link                           |
| Port layer?      | Transport                           |
| ARP?             | IPv4 → MAC                          |
| DNS?             | Name → IP                           |
| DHCP?            | Automatic network configuration     |
| Ping?            | ICMP                                |
| TCP handshake?   | SYN → SYN-ACK → ACK                 |
| TCP termination? | Usually 4-way                       |
| TCP reliable?    | Yes                                 |
| UDP reliable?    | No                                  |
| TCP data type?   | Byte stream                         |
| UDP data type?   | Datagram                            |
| IPv4 size?       | 32-bit                              |
| IPv6 size?       | 128-bit                             |
| Ethernet?        | 802.3                               |
| Wi-Fi?           | 802.11                              |
| HTTPS?           | HTTP + TLS                          |
| DNS port?        | 53                                  |
| HTTP port?       | 80                                  |
| HTTPS port?      | 443                                 |
| SSH port?        | 22                                  |
| DHCP ports?      | 67/68                               |
| SMTP?            | Email sending/relay                 |
| POP3?            | Email retrieval                     |
| IMAP?            | Server-based email access/sync      |
| FTP?             | File transfer                       |
| WebSocket?       | Full-duplex real-time communication |

---

# 🎯 Highest-Priority Interview Questions

### Must Master ⭐⭐⭐⭐⭐

1. Explain what happens when you enter a URL.
2. TCP 3-way handshake.
3. TCP 4-way termination.
4. TCP vs UDP.
5. Flow control vs congestion control.
6. MAC vs IP.
7. Hub vs switch vs router.
8. ARP and remote destination behavior.
9. DNS resolution.
10. Routing vs forwarding.
11. Subnetting/CIDR.
12. HTTP vs HTTPS.
13. Authentication vs authorization.
14. Cookie vs session vs JWT.
15. WebSocket vs HTTP.
16. CDN vs load balancer.
17. CSMA/CD vs CSMA/CA.
18. IPv4 vs IPv6.
19. TCP reliability.
20. What happens when a packet is lost?

---

# ⚡ Interview Answer Formula

For almost any networking question, answer in this order:

```text
1. Definition
      ↓
2. Layer
      ↓
3. How it works
      ↓
4. Example
      ↓
5. Important limitation/trap
```

Example:

> **ARP** is an address-resolution protocol associated with IPv4. It maps an IPv4 address to a MAC address on the local link. The request is typically broadcast and the reply is typically unicast. For a remote destination, the host resolves the default gateway's MAC rather than the remote server's MAC.

```

### 🎯 Priority
**Placement:** ⭐⭐⭐⭐⭐  
**GATE:** ⭐⭐⭐⭐

**Next file: `One Page Revision.md`**.
```
