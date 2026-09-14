````md id="firewall"
# Firewall

## 1. What is a Firewall?

A **firewall** is a security mechanism that **allows or blocks network traffic according to predefined rules**.

> **Firewall = Traffic filter**

```text
Internet
   ↓
[ FIREWALL ]
   ↓
Internal Network
````

---

# 2. Why Firewall?

A firewall can control traffic based on:

* Source IP
* Destination IP
* Port number
* Protocol
* Connection state
* Application/content (in advanced firewalls)

Example:

```text
Allow TCP 443  → HTTPS
Block TCP 23   → Telnet
```

---

# 3. Packet Filtering Firewall ⭐⭐⭐⭐⭐

Examines packet headers.

Typical fields:

```text
Source IP
Destination IP
Source Port
Destination Port
Protocol
```

Example:

```text
IF destination port = 23
THEN BLOCK
```

### Advantages

* Fast
* Simple

### Limitation

* Limited understanding of application content
* Basic filters may not track connection state

---

# 4. Stateless Firewall

Each packet is evaluated **independently**.

```text
Packet 1 → Check rule → Allow/Block
Packet 2 → Check rule → Allow/Block
Packet 3 → Check rule → Allow/Block
```

It does not maintain connection state.

---

# 5. Stateful Firewall ⭐⭐⭐⭐⭐

Maintains information about **active connections/sessions**.

Example:

```text
Client → Server
   SYN
   ↓
Firewall records connection
   ↓
Established connection
   ↓
Return traffic can be recognized
```

### Key difference

| Stateless           | Stateful              |
| ------------------- | --------------------- |
| Packet-by-packet    | Tracks connections    |
| No connection state | Maintains state table |
| Simpler             | More intelligent      |
| Less context        | More context          |

🔥 **GATE favorite distinction.**

---

# 6. Application-Level / Proxy Firewall ⭐⭐⭐⭐

Works at the **application layer**.

Instead of directly forwarding traffic:

```text
Client → Proxy Firewall → Server
```

It can inspect application-level information.

Examples:

* HTTP requests
* URLs
* Application commands

### Advantage

More detailed inspection.

### Disadvantage

More processing overhead.

---

# 7. Next-Generation Firewall (NGFW)

Advanced firewall may combine:

* Stateful inspection
* Application awareness
* Deep packet inspection
* Intrusion prevention
* User/identity awareness
* Content filtering

> NGFW goes beyond simple IP/port filtering.

---

# 8. Firewall vs Router ⭐⭐⭐⭐⭐

| Router                     | Firewall                           |
| -------------------------- | ---------------------------------- |
| Primarily forwards packets | Primarily enforces security policy |
| Uses routing table         | Uses security rules                |
| Determines next hop        | Allows/blocks traffic              |
| Security may be secondary  | Security is primary purpose        |

A device can perform **both routing and firewall functions**.

---

# 9. Firewall vs IDS vs IPS ⭐⭐⭐⭐⭐

### Firewall

```text
Traffic → Rule check → Allow / Block
```

### IDS — Intrusion Detection System

**Detects and alerts** about suspicious activity.

```text
Traffic → IDS → Alert
```

### IPS — Intrusion Prevention System

**Detects and actively blocks/prevents** suspicious traffic.

```text
Traffic → IPS → Detect → Block
```

| System   | Main action            |
| -------- | ---------------------- |
| Firewall | Enforce traffic policy |
| IDS      | Detect + alert         |
| IPS      | Detect + prevent       |

---

# 10. DMZ ⭐⭐⭐⭐

**DMZ = Demilitarized Zone**

A separate network segment for publicly accessible services.

Example:

```text
             Internet
                ↓
           [ Firewall ]
            ↙       ↘
         DMZ       Internal
          ↓           ↓
       Web Server   Database
```

Typical public-facing servers:

* Web server
* Mail server
* DNS server

### Goal

If a public server is compromised, the attacker should have **limited direct access to the internal network**.

---

# 11. Firewall Rules

Rules commonly have:

```text
Source
Destination
Protocol
Port
Action
```

Example:

```text
Source:      Any
Destination: Web Server
Protocol:    TCP
Port:        443
Action:      ALLOW
```

🔥 Rule ordering can matter.

Many firewalls evaluate rules **top-to-bottom** until a matching rule is found.

---

# 🔥 GATE Traps

1. Firewall primarily **filters/enforces traffic policy**.
2. Packet filtering can use **IP, port, protocol**.
3. **Stateless → no connection state.**
4. **Stateful → tracks active connections.**
5. Application/proxy firewall can inspect application-level information.
6. **IDS detects/alerts; IPS detects and blocks.**
7. DMZ is used to isolate publicly accessible services from the internal network.
8. Firewall ≠ router, although one device can perform both functions.
9. Blocking TCP port 23 blocks traditional Telnet traffic, not "all remote login."
10. A firewall does not automatically prevent every type of attack.

---

# ⚡ 30-Second Revision

```text
Firewall
   ↓
Traffic Filtering

Stateless
   ↓
Packet-by-packet

Stateful
   ↓
Connection tracking

Application Firewall
   ↓
Application-level inspection

IDS
   ↓
Detect + Alert

IPS
   ↓
Detect + Block

DMZ
   ↓
Public services
   ↓
Isolated from internal network
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
