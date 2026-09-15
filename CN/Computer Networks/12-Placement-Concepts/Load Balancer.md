````md id="load-balancer"
# Load Balancer

## 1. What is a Load Balancer?

A **load balancer** distributes incoming requests/traffic across multiple backend servers.

> **Load Balancer = distribute workload to avoid overloading one server.**

```text
              Clients
             ↙  ↓  ↘
        Load Balancer
         ↙    ↓    ↘
       S1     S2     S3
````

---

# 2. Why Load Balancing? ⭐⭐⭐⭐⭐

Without load balancing:

```text
1000 Requests
      ↓
   Server A
      ↓
   Overloaded
```

With load balancing:

```text
1000 Requests
      ↓
 Load Balancer
  ↙    ↓    ↘
 S1    S2    S3
```

Benefits:

* Scalability
* High availability
* Better resource utilization
* Fault tolerance
* Reduced overload

---

# 3. Load Balancing Algorithms ⭐⭐⭐⭐⭐

## 1️⃣ Round Robin

Requests are distributed sequentially.

```text
R1 → S1
R2 → S2
R3 → S3
R4 → S1
R5 → S2
```

Simple and common.

---

## 2️⃣ Weighted Round Robin

Servers receive different numbers of requests according to their weights.

```text
S1 → Weight 3
S2 → Weight 1
```

S1 receives approximately 3× the traffic of S2 under suitable conditions.

Useful when servers have different capacities.

---

## 3️⃣ Least Connections ⭐⭐⭐⭐⭐

Send the new request to the server with the **fewest active connections**.

```text
S1 → 10 connections
S2 →  4 connections
S3 →  7 connections

New request → S2
```

---

## 4️⃣ IP Hash

Uses client IP to determine the backend.

```text
Client IP
   ↓
Hash
   ↓
Backend Server
```

The same client may tend to reach the same backend.

Useful when some form of session affinity is needed.

---

# 4. Health Checks ⭐⭐⭐⭐⭐

Load balancers can periodically check whether backend servers are healthy.

```text
Load Balancer
   ↓
Health Check
   ↓
Server A → Healthy ✅
Server B → Failed ❌
Server C → Healthy ✅
```

Traffic is then sent only to suitable healthy servers.

🔥 Health checks are critical for **high availability**.

---

# 5. Active-Active vs Active-Passive

### Active-Active

Multiple servers actively handle traffic.

```text
LB
 ↓
S1 ← active
S2 ← active
S3 ← active
```

### Active-Passive

One system actively serves while another is ready to take over.

```text
Primary → Active
Backup  → Standby
```

If primary fails:

```text
Primary ❌
   ↓
Backup becomes active
```

---

# 6. Layer 4 vs Layer 7 Load Balancing ⭐⭐⭐⭐⭐

## L4 Load Balancer

Works using transport/network information.

Typical information:

* IP address
* TCP/UDP
* Port

```text
IP + TCP Port
      ↓
 Load Balancer
```

It doesn't need to understand the HTTP request itself.

---

## L7 Load Balancer

Understands application-level protocols such as HTTP.

Can route using:

* URL path
* Hostname
* HTTP headers
* Cookies

Example:

```text
/api/*
   ↓
API Server

/images/*
   ↓
Image Server
```

| L4                         | L7                           |
| -------------------------- | ---------------------------- |
| IP/TCP/UDP information     | HTTP/application information |
| Faster/simple processing   | More intelligent routing     |
| Less application awareness | Application-aware            |

🔥 **L7 can make decisions based on HTTP content.**

---

# 7. Load Balancer + Reverse Proxy ⭐⭐⭐⭐⭐

A reverse proxy can also perform load balancing.

```text
Client
   ↓
Reverse Proxy / Load Balancer
   ↓
S1  S2  S3
```

Therefore:

> **A reverse proxy can be a load balancer, but "reverse proxy" and "load balancer" describe different roles/concepts.**

---

# 8. Session Persistence / Sticky Sessions ⭐⭐⭐⭐

Sometimes a user should continue reaching the same backend.

```text
User A → S1
User A → S1
User A → S1
```

This is called:

**Session affinity / Sticky session**

Methods can include:

* Cookie-based affinity
* IP-based affinity

### Problem

Sticky sessions can make load distribution less flexible.

A shared session store can reduce the need for stickiness.

---

# 9. Load Balancer vs DNS Load Balancing ⭐⭐⭐⭐

### Load Balancer

Traffic reaches the load balancer first.

```text
Client
 ↓
LB
 ↓
Servers
```

### DNS-based distribution

DNS can return different IP addresses.

```text
Client
 ↓
DNS
 ↓
IP A / IP B / IP C
```

🔥 DNS-based distribution is **not the same as an L4/L7 load balancer**.

---

# 10. Load Balancer Failure

The load balancer itself can become a **single point of failure**.

Solution:

```text
        Clients
           ↓
    LB1       LB2
     ↓         ↓
       Backend
      Servers
```

Use redundant/load-balanced load balancers with appropriate failover mechanisms.

---

# 11. Common Architecture ⭐⭐⭐⭐⭐

```text
                 Internet
                    ↓
              Load Balancer
              ↙     ↓     ↘
            Web1   Web2   Web3
              ↘     ↓     ↙
              Application
                    ↓
                 Database
```

Typical scaling:

```text
Horizontal Scaling
       ↓
Add more servers
       ↓
Load Balancer distributes traffic
```

---

# 🔥 Interview / GATE Traps

1. **Load balancer distributes traffic across multiple servers.**
2. Round Robin → sequential distribution.
3. Weighted Round Robin → distribution based on weights.
4. Least Connections → server with fewest active connections.
5. IP Hash → routing based on client IP hash.
6. Health checks detect unavailable backends.
7. **L4 → IP/port/transport information.**
8. **L7 → application-level information such as HTTP path/headers.**
9. Reverse proxy can perform load balancing.
10. Reverse proxy ≠ load balancer in every implementation.
11. Sticky sessions = session affinity.
12. DNS load balancing ≠ dedicated L4/L7 load balancing.
13. Horizontal scaling → add more servers.
14. A load balancer can itself require redundancy to avoid becoming a single point of failure.

---

# ⚡ 30-Second Revision

```text
Clients
   ↓
Load Balancer
   ↓
┌──────┬──────┬──────┐
S1     S2     S3
```

### Algorithms

```text
Round Robin       → Sequential
Weighted RR       → Based on capacity/weight
Least Connections → Fewest active connections
IP Hash           → Client IP
```

### Layers

```text
L4 → IP + TCP/UDP + Port

L7 → HTTP + Path + Headers + Host
```

### Key idea

```text
More traffic
    ↓
More servers
    ↓
Load Balancer
    ↓
Horizontal Scalability
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```
```
