````md id="reverse-proxy"
# Reverse Proxy

## 1. What is a Reverse Proxy?

A **reverse proxy** is a server placed in front of backend servers that receives client requests and forwards them to the appropriate backend.

> **Reverse Proxy = Client sees one entry point; proxy hides/represents backend servers.**

```text
Client
   ↓
Reverse Proxy
   ↓
Backend Servers
 ┌───┼───┐
 ↓   ↓   ↓
S1  S2  S3
````

---

# 2. Why Use a Reverse Proxy? ⭐⭐⭐⭐⭐

Main purposes:

* Load balancing
* TLS termination
* Caching
* Security/filtering
* Routing requests
* Hiding backend infrastructure
* Compression

---

# 3. Reverse Proxy vs Forward Proxy ⭐⭐⭐⭐⭐

This is a **very common interview question**.

### Forward Proxy

Acts on behalf of the **client**.

```text
Client
  ↓
Forward Proxy
  ↓
Internet
  ↓
Server
```

The server sees the proxy rather than directly seeing the client in the normal proxy model.

### Reverse Proxy

Acts on behalf of the **server/backend**.

```text
Client
  ↓
Reverse Proxy
  ↓
Backend Server
```

The client communicates with the reverse proxy as the public endpoint.

| Forward Proxy                       | Reverse Proxy                          |
| ----------------------------------- | -------------------------------------- |
| Represents client                   | Represents server/backend              |
| Client-side role                    | Server-side role                       |
| Controls/forwards outgoing requests | Receives incoming requests             |
| Example: corporate web proxy        | Example: Nginx in front of app servers |

🔥 Memory trick:

```text
Forward → protects/represents CLIENT
Reverse → protects/represents SERVER
```

---

# 4. Reverse Proxy + Load Balancer ⭐⭐⭐⭐⭐

A reverse proxy can distribute requests among multiple backend servers.

```text
             Reverse Proxy
                  ↓
       ┌──────────┼──────────┐
       ↓          ↓          ↓
    Server A   Server B   Server C
```

Example:

```text
Request 1 → Server A
Request 2 → Server B
Request 3 → Server C
```

This improves:

* Scalability
* Availability
* Resource utilization

> **A load balancer can be implemented as part of a reverse-proxy architecture.**

---

# 5. TLS Termination ⭐⭐⭐⭐⭐

A reverse proxy can terminate TLS.

```text
Client
  │ HTTPS
  ↓
Reverse Proxy
  │ HTTP/HTTPS
  ↓
Backend
```

The reverse proxy:

1. Receives HTTPS
2. Decrypts TLS
3. Forwards request to backend

This is called **TLS termination**.

### Why?

Centralizes:

* Certificates
* TLS configuration
* Encryption/decryption

🔥 Backend communication may still use HTTPS if end-to-end encryption is required.

---

# 6. Request Routing ⭐⭐⭐⭐⭐

Reverse proxies can route requests based on:

* Hostname
* URL path
* Headers
* Other rules

Example:

```text
api.example.com
       ↓
   API Server

www.example.com
       ↓
   Web Server
```

Or:

```text
/api/*
   ↓
API backend

/images/*
   ↓
Image server
```

---

# 7. Caching ⭐⭐⭐⭐

Reverse proxy can cache frequently requested content.

```text
Client
  ↓
Reverse Proxy
  ↓
Cache HIT?
 ┌──────┴──────┐
Yes            No
 ↓              ↓
Return        Backend
cache         request
```

### Benefit

* Lower backend load
* Faster responses
* Reduced bandwidth usage

---

# 8. Security ⭐⭐⭐⭐⭐

Reverse proxy can act as a security boundary.

It can provide:

* Request filtering
* Rate limiting
* IP allow/deny rules
* WAF integration
* TLS handling
* Hiding internal server addresses/topology

```text
Internet
   ↓
Reverse Proxy
   ↓
Private Backend
```

🔥 Hiding the backend does **not** automatically make it secure. Proper access controls are still required.

---

# 9. Reverse Proxy vs API Gateway ⭐⭐⭐⭐

They overlap, but an API gateway usually provides **more API-specific functionality**.

| Reverse Proxy      | API Gateway                              |
| ------------------ | ---------------------------------------- |
| Traffic forwarding | API traffic management                   |
| Load balancing     | Authentication/authorization integration |
| TLS termination    | Rate limiting/quotas                     |
| Caching            | API routing/versioning                   |
| Basic filtering    | API-specific policies                    |

An API gateway is often implemented using or alongside reverse-proxy functionality.

---

# 10. Common Reverse Proxy Software

Examples:

* Nginx
* HAProxy
* Envoy
* Apache HTTP Server

These can perform reverse-proxy and/or load-balancing functions depending on configuration.

---

# 🔥 Interview / GATE Traps

1. **Reverse proxy represents/protects backend servers.**
2. **Forward proxy represents clients.**
3. Reverse proxy sits between **clients and backend servers**.
4. Reverse proxy can perform **load balancing**.
5. Reverse proxy can perform **TLS termination**.
6. TLS termination at proxy does not necessarily mean backend traffic is encrypted.
7. Reverse proxy can perform caching.
8. Reverse proxy can route using hostname/path/etc.
9. Reverse proxy can improve security but is **not automatically a firewall**.
10. API gateway and reverse proxy overlap but are not identical concepts.
11. A reverse proxy can hide backend topology from external clients.
12. **Load balancer and reverse proxy are related but not synonymous.**

---

# ⚡ 30-Second Revision

```text
Client
   ↓
Reverse Proxy
   ↓
Backend Servers
```

### Functions

```text
Reverse Proxy
 ├── Load Balancing
 ├── TLS Termination
 ├── Caching
 ├── Routing
 ├── Rate Limiting
 └── Security Filtering
```

### Most important distinction

```text
Forward Proxy → Client side
Reverse Proxy → Server side
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```
```
