````md
# Common Tricky Questions — Computer Networks

## 1. TCP vs UDP: Which is faster?

**Usually UDP has lower overhead**, but saying "UDP is always faster" is wrong.

> UDP provides fewer transport mechanisms; application requirements determine actual performance.

---

## 2. Why is TCP called reliable?

TCP uses:

- Sequence numbers
- ACKs
- Retransmissions
- Timers
- Checksum
- Ordered delivery

> Reliability is achieved by detecting loss/errors and recovering from them.

---

## 3. Does TCP guarantee zero packet loss?

**No.**

TCP/IP networks can lose packets.

TCP detects loss and **retransmits** missing data.

```text
Packet lost
    ↓
TCP detects loss
    ↓
Retransmission
````

---

## 4. TCP Segment vs IP Packet vs Ethernet Frame

```text
Application Data
      ↓
TCP Segment
      ↓
IP Packet
      ↓
Ethernet Frame
```

| Unit    | Layer |
| ------- | ----- |
| Segment | L4    |
| Packet  | L3    |
| Frame   | L2    |
| Bits    | L1    |

🔥 Don't call an Ethernet frame an IP packet.

---

## 5. Does a switch use IP addresses?

A normal **Layer-2 switch forwards Ethernet frames using MAC addresses**.

```text
Switch → MAC
Router → IP
```

Layer-3 switches can also perform IP routing.

---

## 6. Does a router change the source/destination IP at every hop?

Normally **no**.

```text
Source IP ───────────────→ Destination IP
```

The Layer-2 MAC addresses generally change hop-by-hop.

```text
MAC → changes at each link
IP  → normally remains end-to-end
```

🔥 NAT is an exception because it intentionally changes IP addresses.

---

## 7. Does MAC address work across the Internet?

Not end-to-end.

MAC addresses are used for **local-link delivery**.

```text
Host → Router → Router → Server

MAC changes at each link
IP remains destination-oriented end-to-end
```

---

## 8. Why do we need both MAC and IP?

They solve different problems.

```text
MAC → Which device on this local link?
IP  → Which host/network across interconnected networks?
```

---

## 9. ARP for a remote server?

Suppose:

```text
PC → Router → Internet → Server
```

PC does **not** ARP for the server's MAC.

It ARPs for:

```text
Default Gateway's MAC
```

🔥 Very common interview question.

---

## 10. Is ARP a Layer-2 or Layer-3 protocol?

ARP is commonly described as operating **between L2 and L3** because it resolves an IPv4 address to a link-layer MAC address.

For interview purposes:

> ARP is associated with IPv4 and local-link address resolution.

---

## 11. Why can't a router forward an Ethernet broadcast?

Routers normally **do not forward Layer-2 broadcasts between interfaces**.

Example:

```text
LAN A ── Router ── LAN B

Broadcast on LAN A
       ✕
     LAN B
```

This is why DHCP across subnets may require a **DHCP relay**.

---

## 12. Why does Wi-Fi use CSMA/CA instead of CSMA/CD?

A wireless station generally cannot reliably detect a collision while transmitting.

Therefore Wi-Fi attempts to **avoid collisions**.

```text
Ethernet (traditional shared) → CSMA/CD
Wi-Fi                       → CSMA/CA
```

---

## 13. Why does Ethernet minimum frame size exist?

In traditional shared half-duplex Ethernet, the sender needed enough transmission time to detect a collision before finishing the frame.

This relates to the:

```text
Minimum frame size = 64 bytes
```

🔥 Modern switched full-duplex Ethernet normally doesn't have this collision-detection requirement.

---

## 14. Does every HTTP request create a new TCP connection?

**No.**

Persistent connections allow multiple HTTP requests/responses to use the same connection.

```text
TCP connection
 ├── Request 1
 ├── Request 2
 └── Request 3
```

HTTP/2 further multiplexes multiple streams over a connection.

---

## 15. HTTP/3 uses TCP?

**No.**

```text
HTTP/1.1 → TCP
HTTP/2   → TCP
HTTP/3   → QUIC → UDP
```

🔥 Extremely common modern interview question.

---

## 16. Is HTTP stateful?

HTTP itself is fundamentally **stateless**.

State can be implemented using:

* Cookies
* Sessions
* Tokens
* Application/database state

```text
HTTP → Stateless protocol
Application → Can maintain state
```

---

## 17. Cookie vs Session

### Cookie

Stored on the client/browser.

### Session

Usually state maintained on the server.

Common implementation:

```text
Browser
   ↓
Session ID (cookie)
   ↓
Server
   ↓
Session data
```

🔥 Cookie ≠ session.

---

## 18. JWT vs Session

### Session

```text
Client → Session ID → Server
                       ↓
                  Session Store
```

### JWT

```text
Client → JWT → Server
               ↓
          Verify token
```

JWT can carry claims and be verified without looking up session state, but JWT-based systems can still use server-side state.

🔥 **JWT ≠ automatically stateless.**

---

## 19. JWT encrypted?

**Not by default.**

Typical JWT:

```text
Header.Payload.Signature
```

The header and payload are Base64URL-encoded.

> Encoding ≠ encryption.

---

## 20. 401 vs 403 ⭐⭐⭐⭐⭐

```text
401 → Authentication problem
403 → Authenticated/recognized but not permitted
```

Easy memory:

> **401 = Who are you?**
> **403 = I know you, but you can't do this.**

---

## 21. GET vs POST

### GET

Used to retrieve a resource.

Generally:

* Safe
* Idempotent

### POST

Usually used to submit/create/process something.

Generally:

* Not safe
* Not inherently idempotent

🔥 POST is **not simply "create"**; it can have other semantics.

---

## 22. PUT vs PATCH

```text
PUT   → Replace representation/resource state
PATCH → Partial modification
```

🔥 PUT is idempotent by definition of its method semantics; PATCH is **not inherently idempotent**.

---

## 23. Authentication vs Authorization

```text
Authentication → WHO are you?
Authorization   → WHAT are you allowed to do?
```

Example:

```text
Login → Authentication
Admin access → Authorization
```

---

## 24. Encryption vs Hashing

```text
Encryption → reversible with appropriate key
Hashing    → one-way digest
```

Use:

```text
Encryption → confidentiality
Hash       → integrity/fingerprinting/password storage
```

🔥 Hashing is not encryption.

---

## 25. Symmetric vs Asymmetric Encryption

| Symmetric       | Asymmetric                                 |
| --------------- | ------------------------------------------ |
| Same secret key | Public + private key                       |
| Fast            | Generally slower                           |
| AES             | RSA/ECC                                    |
| Bulk encryption | Authentication/key-establishment use cases |

---

## 26. Digital Signature: Which key?

```text
Sender's private key → Sign
Sender's public key  → Verify
```

🔥 Do not reverse this.

---

## 27. HTTPS gives what?

HTTPS = HTTP + TLS.

Provides:

* Confidentiality
* Integrity
* Authentication

```text
HTTP
 ↓
TLS
 ↓
TCP
```

For HTTP/3:

```text
HTTP/3
 ↓
QUIC
 ↓
UDP
```

---

## 28. Does HTTPS hide the IP address?

**No.**

HTTPS protects application data, but network metadata such as IP addresses, timing and traffic volume can still be observable.

---

## 29. DNS TTL vs IP TTL

### DNS TTL

Controls caching lifetime.

### IP TTL

Limits packet lifetime by decreasing at routers.

```text
DNS TTL → Time
IP TTL  → Router hops
```

🔥 Same word, completely different purpose.

---

## 30. Does DNS use only UDP?

**No.**

```text
UDP 53 → common DNS queries
TCP 53 → also used when required
```

Traditional zone transfers use TCP.

---

## 31. DNS vs DHCP

| DNS            | DHCP                      |
| -------------- | ------------------------- |
| Resolves names | Configures hosts          |
| Domain → IP    | Provides IP/configuration |
| Port 53        | Ports 67/68               |

Example:

```text
DNS  → google.com → IP
DHCP → "Give my device an IP"
```

---

## 32. Routing vs Forwarding

```text
Routing   → determines path
Forwarding → sends packet to next hop
```

Think:

> **Routing = decision**
> **Forwarding = action**

---

## 33. Distance Vector vs Link State

| Distance Vector            | Link State                            |
| -------------------------- | ------------------------------------- |
| Neighbor information       | Topology information                  |
| Bellman-Ford               | Dijkstra                              |
| RIP                        | OSPF                                  |
| Count-to-infinity possible | Faster topology convergence generally |

Memory:

```text
DV → "How far?"
LS → "What topology?"
```

---

## 34. Flow Control vs Congestion Control ⭐⭐⭐⭐⭐

```text
Flow Control
→ Protect receiver

Congestion Control
→ Protect network
```

TCP:

```text
Effective Window = min(rwnd, cwnd)
```

---

## 35. What happens when TCP packet is lost?

TCP can detect loss through:

* Retransmission timeout
* Duplicate ACKs

Traditional Fast Retransmit:

```text
3 duplicate ACKs
       ↓
Retransmit missing segment
```

---

## 36. Transmission vs Propagation Delay

### Transmission

Time required to put bits onto the link:

```text
Tt = L / R
```

### Propagation

Time for signal to travel:

```text
Tp = Distance / Propagation Speed
```

🔥 Large packet → transmission delay increases.

🔥 Longer physical distance → propagation delay increases.

---

## 37. Bandwidth vs Throughput

```text
Bandwidth  → Maximum/theoretical capacity
Throughput → Actual achieved data rate
```

Example:

```text
Link capacity = 100 Mbps
Actual throughput = 72 Mbps
```

---

## 38. CDN vs Load Balancer

```text
CDN
→ geographically distributed caching/content delivery

Load Balancer
→ distributes traffic among backend servers
```

They can work together.

---

## 39. Reverse Proxy vs Forward Proxy

```text
Forward Proxy:
Client → Proxy → Internet

Reverse Proxy:
Client → Proxy → Backend
```

Memory:

> Forward proxy represents the **client**.
> Reverse proxy represents the **server**.

---

## 40. WebSocket vs HTTP

```text
HTTP:
Request → Response

WebSocket:
Client ←→ Server
```

WebSocket provides:

* Persistent connection
* Full-duplex communication
* Real-time communication

Initial connection uses an HTTP Upgrade handshake.

---

# 🔥 10 Questions You Should Be Able to Answer Instantly

### Q1. Which layer uses ports?

**Transport Layer.**

### Q2. Which layer uses MAC?

**Data Link Layer.**

### Q3. Which layer uses IP?

**Network Layer.**

### Q4. TCP handshake?

**SYN → SYN-ACK → ACK**

### Q5. TCP termination?

**FIN → ACK → FIN → ACK**

### Q6. ARP?

**IPv4 → MAC**

### Q7. DNS?

**Domain name → IP**

### Q8. DHCP?

**Automatic network configuration**

### Q9. Wi-Fi collision mechanism?

**CSMA/CA**

### Q10. Traditional shared Ethernet collision mechanism?

**CSMA/CD**

---

# ⚡ Interview Master Shortcut

```text
MAC     → Switch
IP      → Router
Port    → Process

ARP     → IP → MAC
DNS     → Name → IP
DHCP    → Network configuration

TCP     → Reliable + Ordered
UDP     → Lightweight + Datagram

HTTP    → Request/Response
HTTPS   → HTTP + TLS
WS      → Full Duplex

Flow    → Receiver
Congest → Network

CDN     → Cache/Edge
LB      → Backend distribution
Firewall→ Traffic filtering

DV      → Bellman-Ford
LS      → Dijkstra

IPv4    → 32-bit
IPv6    → 128-bit
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

Focus especially on **TCP, HTTP/HTTPS, DNS, ARP, IP, routing, switching, subnetting, flow/congestion control, security and WebSocket**.

```
```
