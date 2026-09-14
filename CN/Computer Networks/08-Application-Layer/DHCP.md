````md id="dhcp-gate"
# DHCP — Dynamic Host Configuration Protocol

## 1. Definition

**DHCP** automatically provides network configuration to a host.

> DHCP = **Automatic IP configuration**

A DHCP server can provide:

- IP address
- Subnet mask/prefix
- Default gateway
- DNS server
- Lease duration
- Other configuration options

---

# 2. Why DHCP? ⭐⭐⭐⭐⭐

Without DHCP, a host may need manual configuration:

```text
IP address
Subnet mask
Gateway
DNS
````

With DHCP:

```text
Host
 ↓
DHCP
 ↓
Automatic configuration
```

---

# 3. DHCP Uses UDP ⭐⭐⭐⭐⭐

DHCP uses:

```text
UDP
```

Ports:

```text
Server → UDP 67
Client → UDP 68
```

🔥 Remember:

> **DHCP server = 67, DHCP client = 68**

---

# 4. DORA Process ⭐⭐⭐⭐⭐

The classic DHCP exchange is:

```text
D → O → R → A
```

### D — Discover

Client broadcasts:

```text
Client ── DHCP Discover ──→ Network
```

Client is essentially asking:

> "Is there a DHCP server available?"

---

### O — Offer

DHCP server responds:

```text
Server ── DHCP Offer ──→ Client
```

The offer may contain:

* Proposed IP address
* Lease information
* Network configuration

---

### R — Request

Client broadcasts a DHCP Request:

```text
Client ── DHCP Request ──→ Network
```

It indicates which offered configuration the client wants.

---

### A — ACK

Server confirms:

```text
Server ── DHCP ACK ──→ Client
```

The client can now use the assigned configuration.

---

# 5. DORA Diagram ⭐⭐⭐⭐⭐

```text
Client                         DHCP Server

   |                                |
   |------ DHCP DISCOVER ---------->|
   |                                |
   |<------- DHCP OFFER ------------|
   |                                |
   |------ DHCP REQUEST ----------->|
   |                                |
   |<------- DHCP ACK --------------|
   |                                |
      Configuration obtained
```

---

# 6. Why Does DHCP Use Broadcast?

A new client may initially have:

```text
No IP address
No knowledge of DHCP server
```

Therefore it can use broadcast mechanisms on the local network to discover DHCP servers.

Typical initial communication:

```text
0.0.0.0
   ↓
255.255.255.255
```

🔥 GATE concept:

> DHCP allows a host to obtain an IP configuration **before it has a usable IP address**.

---

# 7. DHCP Lease ⭐⭐⭐⭐⭐

DHCP normally assigns an address for a **limited lease period**.

```text
IP assigned
    ↓
Lease timer
    ↓
Renewal
```

The client generally attempts to renew before the lease expires.

If the lease is not renewed, the address may eventually become available for reassignment.

---

# 8. DHCP Relay ⭐⭐⭐⭐

DHCP discovery uses broadcast, but routers normally do **not forward ordinary broadcasts** between subnets.

Therefore, organizations can use a:

> **DHCP Relay Agent**

```text
Client
  ↓
Broadcast
  ↓
DHCP Relay
  ↓
Router/IP network
  ↓
DHCP Server
```

This allows one centralized DHCP server to serve multiple networks.

---

# 9. DHCP vs DNS ⭐⭐⭐⭐⭐

Do not confuse them.

| DHCP                           | DNS                |
| ------------------------------ | ------------------ |
| Provides network configuration | Resolves names     |
| Assigns IP configuration       | Domain ↔ IP        |
| UDP 67/68                      | Usually UDP/TCP 53 |
| DORA                           | DNS query/response |

Example:

```text
DHCP
 ↓
"What IP/configuration should I use?"

DNS
 ↓
"What IP belongs to example.com?"
```

---

# 10. DHCP vs Static IP

### Static

Administrator manually configures:

```text
IP
Mask
Gateway
DNS
```

### DHCP

Server automatically provides configuration.

```text
Host → DHCP → Configuration
```

---

# 🔥 GATE Traps

### Trap 1

DHCP uses TCP.

❌

> DHCP uses **UDP**.

---

### Trap 2

DHCP server uses port 68.

❌

```text
Server → 67
Client → 68
```

---

### Trap 3

DORA means:

```text
Discover → Offer → Request → ACK
```

✅

---

### Trap 4

Router forwards DHCP broadcast normally.

❌

> DHCP Relay is commonly used to forward DHCP requests across subnets.

---

### Trap 5

DHCP only assigns an IP address.

❌

It can provide several configuration parameters such as subnet mask, gateway and DNS server.

---

### Trap 6

DHCP address assignment is always permanent.

❌

> DHCP commonly uses **leases**.

---

# ⚡ 30-Second Revision

```text
DHCP
 ↓
Automatic network configuration

Protocol = UDP

Server = 67
Client = 68

DORA:
D → Discover
O → Offer
R → Request
A → ACK

Uses:
✓ IP address
✓ Subnet mask/prefix
✓ Gateway
✓ DNS
✓ Lease information

Across subnets:
DHCP Relay
```

### 🔥 Must Remember

> **DORA + UDP + 67/68 + DHCP Relay + Lease**

### GATE Priority

**🔥🔥🔥🔥 — Very High**

Most important:

1. DORA sequence
2. UDP ports 67/68
3. DHCP broadcast
4. DHCP relay
5. Lease/renewal
6. DHCP vs DNS

```
```
