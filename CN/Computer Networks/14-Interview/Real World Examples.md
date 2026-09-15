````md id="real-world-cn"
# Computer Networks — Real World Examples

## 1. Opening a Website ⭐⭐⭐⭐⭐

Suppose you open:

```text
https://example.com
````

Actual flow:

```text
Browser
   ↓
DNS → Find IP
   ↓
TCP → Establish connection
   ↓
TLS → Secure connection
   ↓
HTTP → Request webpage
   ↓
Server → Response
   ↓
Browser → Render page
```

### Remember

```text
DNS → Where?
TCP → Reliable connection
TLS → Secure
HTTP → Request/response
```

---

# 2. Sending a Message in WhatsApp/Chat App ⭐⭐⭐⭐⭐

```text
Your Phone
    ↓
Wi-Fi / Mobile Network
    ↓
Internet
    ↓
Server
    ↓
Receiver's Phone
```

For real-time communication, applications can use mechanisms such as:

```text
WebSocket / QUIC / application-specific protocols
```

The exact protocol depends on the application's architecture.

### Network concepts involved

* IP addressing
* Routing
* Encryption
* Transport protocols
* Authentication
* Servers/CDNs

---

# 3. Watching YouTube/Netflix

```text
User
 ↓
DNS
 ↓
CDN Edge
 ↓
Video chunks
 ↓
Player
```

Instead of every user downloading video directly from one origin server:

```text
Many Users
    ↓
 CDN Edge Servers
    ↓
Cached Content
```

### Why CDN?

* Lower latency
* Reduced origin load
* Better scalability
* Better content delivery

🔥 **Video streaming is a classic CDN use case.**

---

# 4. Online Banking

Simplified:

```text
Browser/App
    ↓
HTTPS
    ↓
Firewall / Reverse Proxy
    ↓
Load Balancer
    ↓
Application Servers
    ↓
Database
```

### Concepts involved

* HTTPS/TLS → confidentiality + integrity + authentication
* Authentication → verify user
* Authorization → check permissions
* Firewall → filter traffic
* Load balancer → distribute requests
* Database → store application data

---

# 5. Logging into a Website

```text
User
 ↓
Login Request
 ↓
Authentication Server
 ↓
Session/JWT
 ↓
Future Requests
```

Example session-based architecture:

```text
Browser
   ↓
Session Cookie
   ↓
Server
   ↓
Session Store
```

🔥 Cookie stores the **session identifier**, not necessarily the complete session data.

---

# 6. Accessing a Website from Home Wi-Fi ⭐⭐⭐⭐⭐

```text
Laptop
 ↓
Wi-Fi Router
 ↓
ISP
 ↓
Internet
 ↓
Destination Server
```

Your home router commonly performs:

```text
DHCP
NAT
Routing
Firewall functions
```

Example:

```text
Laptop:
192.168.1.10

        ↓ NAT

Public IP:
203.x.x.x
```

---

# 7. What Happens When Two Computers Are on Same LAN?

```text
PC1
 ↓
Switch
 ↓
PC2
```

PC1 needs PC2's MAC address for local Ethernet delivery.

If it knows PC2's IPv4 address but not its MAC:

```text
ARP Request
     ↓
Broadcast
     ↓
PC2
     ↓
ARP Reply
     ↓
MAC learned
```

Then:

```text
PC1 → Ethernet Frame → PC2
```

---

# 8. Communication with a Remote Server ⭐⭐⭐⭐⭐

Suppose:

```text
PC → example.com
```

The server is outside the local network.

```text
PC
 ↓
Default Gateway
 ↓
Router
 ↓
Internet
 ↓
Destination Network
 ↓
Server
```

PC uses ARP for:

> **The MAC address of its next-hop gateway.**

🔥 It does not need the remote server's MAC address.

---

# 9. Sending an Email

Simplified:

```text
Sender
 ↓
SMTP
 ↓
Sender Mail Server
 ↓
DNS MX lookup
 ↓
Recipient Mail Server
 ↓
Mailbox
```

SMTP is primarily used for:

```text
Sending / relaying email
```

For reading email:

```text
POP3 / IMAP
```

---

# 10. Loading Images/CSS/JavaScript

When a webpage loads:

```text
HTML
 ↓
Browser discovers:
 ├── image
 ├── CSS
 ├── JavaScript
 └── fonts
```

These resources can often be served from a CDN:

```text
Browser
 ↓
CDN Edge
 ↓
Cache HIT
 ↓
Resource
```

🔥 This reduces repeated requests to the origin.

---

# 11. Online Multiplayer Game 🎮

Typical architecture:

```text
Player A
   ↓
Internet
   ↓
Game Server
   ↑
Internet
   ↑
Player B
```

Important requirements:

* Low latency
* Fast updates
* Server synchronization
* Congestion handling
* Authentication

UDP is commonly useful for latency-sensitive traffic, but the actual protocol depends on the game.

---

# 12. Video Call

```text
Phone A
   ↕
Internet
   ↕
Media Infrastructure
   ↕
Phone B
```

Requirements:

* Low latency
* Real-time transmission
* Audio/video synchronization
* Packet-loss handling
* Encryption

Real-time applications often prefer transports/protocols that avoid excessive retransmission delays.

---

# 13. Company Network

Typical enterprise network:

```text
                  Internet
                     │
                 Firewall
                     │
              Reverse Proxy
                     │
              Load Balancer
                /    |    \
             Server Server Server
```

Internal users:

```text
PC
 ↓
Switch
 ↓
Router
 ↓
Firewall
 ↓
Internet
```

---

# 14. VLAN in an Office

Suppose one physical switch serves:

```text
VLAN 10 → Employees
VLAN 20 → Finance
VLAN 30 → Guests
```

Although the same physical infrastructure is used:

```text
VLAN 10 ≠ VLAN 20 ≠ VLAN 30
```

They are separate Layer-2 broadcast domains.

Communication between VLANs requires Layer-3 routing.

---

# 15. Office Wi-Fi

```text
Laptop
   ↓
Wi-Fi
   ↓
Access Point
   ↓
Switch
   ↓
Router
   ↓
Internet
```

Wi-Fi uses:

```text
IEEE 802.11
CSMA/CA
```

If two stations cannot hear each other:

```text
A → AP ← C
```

This is the **hidden terminal problem**.

RTS/CTS can help.

---

# 16. Connecting to Wi-Fi for the First Time

Simplified:

```text
Device
 ↓
Wi-Fi association/authentication
 ↓
DHCP
 ↓
IP address obtained
 ↓
Default gateway + DNS obtained
 ↓
Internet access
```

Example:

```text
IP      → 192.168.1.20
Gateway → 192.168.1.1
DNS     → DNS resolver
```

---

# 17. Mobile Phone Switching Towers

When moving:

```text
Cell A
  ↓
Cell B
  ↓
Cell C
```

The mobile network performs **handover** between cells.

```text
Phone
 ↓
Base Station A
 ↓
Handover
 ↓
Base Station B
```

Goal:

> Maintain connectivity while the user moves.

---

# 18. Accessing a Server Through a Load Balancer

```text
1000 Users
     ↓
Load Balancer
 ┌───┼───┐
 ↓   ↓   ↓
 S1  S2  S3
```

The load balancer may use:

* Round Robin
* Weighted Round Robin
* Least Connections
* IP Hash

Health checks can remove failed servers from service.

---

# 19. Reverse Proxy in a Web Application

```text
Internet
    ↓
Nginx / Reverse Proxy
    ↓
Application Servers
```

The reverse proxy can:

* Terminate TLS
* Route requests
* Cache content
* Load balance
* Apply filtering/rate limits

🔥 Reverse proxy represents the **backend**, not the client.

---

# 20. CDN + Load Balancer Together ⭐⭐⭐⭐⭐

Large application:

```text
                 Users
                   ↓
                  CDN
                   ↓
              Load Balancer
               /    |    \
              S1    S2    S3
```

### CDN

Handles/cache-delivers content close to users.

### Load Balancer

Distributes requests among backend servers.

They solve different problems and can work together.

---

# 21. DNS-Based Website Access

When you type:

```text
www.example.com
```

The browser needs an IP address.

```text
Domain
  ↓
DNS Resolver
  ↓
IP
  ↓
Connection
```

🔥 DNS is like a **name-resolution system**, not the actual web server.

---

# 22. Traceroute

You want to know the path to a server:

```text
Computer
 ↓
Router 1
 ↓
Router 2
 ↓
Router 3
 ↓
Server
```

Traceroute sends packets with controlled TTL/Hop Limit values.

```text
TTL = 1 → Router 1
TTL = 2 → Router 2
TTL = 3 → Router 3
```

Routers whose TTL expires can generate ICMP Time Exceeded messages.

---

# 23. Ping

Ping checks reachability using ICMP Echo messages.

```text
Computer
   │
   │ Echo Request
   ↓
Server
   │
   │ Echo Reply
   ↓
Computer
```

🔥 Ping does **not use TCP or UDP**.

---

# 24. Firewall Blocking Traffic

Suppose:

```text
Client → Server : TCP 22
```

Firewall rule:

```text
BLOCK TCP port 22
```

Result:

```text
Client ──X──→ Server
```

Firewall rules can consider:

* Source IP
* Destination IP
* Port
* Protocol
* Connection state
* Application characteristics

---

# 25. VPN for Remote Employee

Employee at home:

```text
Laptop
   ↓
Internet
   ↓
VPN Tunnel
   ↓
Company Network
```

The VPN creates a logical tunnel over the public network.

Depending on the VPN technology, traffic can be encrypted and authenticated.

---

# 26. NAT in Home Router

Multiple devices:

```text
Phone     192.168.1.10
Laptop    192.168.1.11
TV        192.168.1.12
             ↓
          NAT/PAT
             ↓
       Public IP
             ↓
          Internet
```

PAT/NAPT can distinguish simultaneous connections using port mappings.

---

# 27. WebSocket Chat

Normal HTTP:

```text
Client → Request
Server → Response
```

WebSocket:

```text
Client ←────────→ Server
```

The server can push a new message immediately without waiting for a new HTTP request.

---

# 28. Cache Hit vs Cache Miss

Suppose:

```text
GET /logo.png
```

### Cache Hit

```text
User → CDN → logo.png
```

Fast.

### Cache Miss

```text
User → CDN → Origin
              ↓
          logo.png
              ↓
             CDN
              ↓
             User
```

The CDN may cache the response for future requests according to its caching rules.

---

# 29. TCP Packet Loss in Real Life

Suppose:

```text
Segment 1 ✓
Segment 2 ✗
Segment 3 ✓
```

Receiver may generate duplicate ACKs for the missing data.

```text
Duplicate ACKs
      ↓
Fast Retransmit
      ↓
Segment 2 retransmitted
```

A retransmission timeout is another loss-detection mechanism.

---

# 30. Big Picture: Complete Web Request ⭐⭐⭐⭐⭐

```text
                 USER
                   │
                   ↓
                 DNS
                   │
                   ↓
              CDN / Edge
                   │
                   ↓
            Load Balancer
                   │
                   ↓
           Reverse Proxy
                   │
                   ↓
          Application Server
                   │
                   ↓
                Database
```

Across the network:

```text
Application
    ↓
TCP / QUIC
    ↓
IP
    ↓
Ethernet / Wi-Fi
    ↓
Physical Medium
```

Security:

```text
HTTPS / TLS
Firewall
Authentication
Authorization
```

---

# 🔥 Real-World Mapping

| Real-world requirement             | Networking concept   |
| ---------------------------------- | -------------------- |
| Find server IP                     | DNS                  |
| Find local MAC                     | ARP                  |
| Automatic IP configuration         | DHCP                 |
| Reliable delivery                  | TCP                  |
| Lightweight datagrams              | UDP                  |
| Secure web traffic                 | HTTPS/TLS            |
| Real-time two-way communication    | WebSocket            |
| Deliver content near users         | CDN                  |
| Distribute backend requests        | Load Balancer        |
| Filter traffic                     | Firewall             |
| Remote private access              | VPN                  |
| Connect different networks         | Router               |
| Connect devices in LAN             | Switch               |
| Wireless LAN                       | Wi-Fi                |
| Find network path                  | Routing / Traceroute |
| Check reachability                 | Ping / ICMP          |
| Translate private/public addresses | NAT                  |

---

# ⚡ Final Mental Model

```text
DNS
↓
"Where is it?"

ARP
↓
"What MAC do I use on this local link?"

Router
↓
"Which next hop?"

Switch
↓
"Which local port?"

TCP
↓
"How do I reliably deliver bytes?"

UDP
↓
"How do I send lightweight datagrams?"

TLS
↓
"How do I secure the communication?"

HTTP
↓
"What resource/action?"

CDN
↓
"Can I serve it closer to the user?"

Load Balancer
↓
"Which backend should handle it?"

Firewall
↓
"Should this traffic be allowed?"
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**Interview:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐

> The most important interview skill is not memorizing protocols separately; it is being able to **connect them together in a real-world flow**.

```

**Interview section complete.**
```
