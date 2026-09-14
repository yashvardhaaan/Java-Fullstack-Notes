````md id="vpn"
# VPN

## 1. What is a VPN?

**VPN = Virtual Private Network**

A VPN creates a **secure logical connection (tunnel)** over an untrusted/public network.

> **VPN = private communication over a public network.**

```text
Without VPN:

Client ───────── Internet ───────── Server


With VPN:

Client ═════ Encrypted Tunnel ═════ VPN Server
              Internet
````

---

# 2. Why VPN?

Main goals:

* 🔒 Confidentiality
* 🛡️ Integrity
* 👤 Authentication
* Secure access to private networks

Example:

```text
Employee
   ↓
Internet
   ↓
VPN
   ↓
Company Network
   ↓
Internal Server
```

The employee can securely access internal resources remotely.

---

# 3. VPN Tunneling ⭐⭐⭐⭐⭐

A VPN encapsulates traffic inside another packet/tunnel.

Conceptually:

```text
Original Packet
      ↓
Encapsulation + Security
      ↓
VPN Packet
      ↓
Internet
      ↓
VPN Gateway
      ↓
Decapsulation
      ↓
Original Packet
```

> **Tunneling ≠ necessarily encryption.**
> A tunnel describes encapsulation; security protocols provide encryption/authentication.

---

# 4. Remote-Access VPN

Connects an **individual user/device** to a private network.

```text
Laptop
   ↓
Internet
   ↓
VPN Gateway
   ↓
Company LAN
```

Common for:

* Remote employees
* Secure access to office resources

---

# 5. Site-to-Site VPN ⭐⭐⭐⭐

Connects **two networks** through a VPN tunnel.

```text
Office A
   │
VPN Gateway
   ║
   ║ Secure Tunnel
   ║
VPN Gateway
   │
Office B
```

Users inside both networks can communicate through the tunnel.

### Difference

| Remote Access     | Site-to-Site             |
| ----------------- | ------------------------ |
| User ↔ Network    | Network ↔ Network        |
| Individual client | VPN gateways             |
| Remote employee   | Branch-office connection |

---

# 6. VPN Gateway

A **VPN gateway** terminates/establishes the VPN tunnel.

```text
Client
   ↓
VPN Gateway
   ↓
Private Network
```

It may perform:

* Authentication
* Encryption/decryption
* Encapsulation/decapsulation
* Access control

---

# 7. IPsec VPN ⭐⭐⭐⭐⭐

**IPsec = Internet Protocol Security**

A suite of protocols/mechanisms for securing IP communication.

Important components:

### AH — Authentication Header

Provides:

* Integrity
* Authentication

But **does not provide encryption**.

### ESP — Encapsulating Security Payload

Provides:

* Confidentiality
* Integrity/authentication (when configured)

🔥 **ESP is the commonly important IPsec component for encrypted VPNs.**

---

# 8. Tunnel Mode vs Transport Mode ⭐⭐⭐⭐⭐

## Transport Mode

Protects the **IP payload**, while the original IP header remains.

```text id="h8a4j9"
Original IP Header | Protected Payload
```

Commonly associated with host-to-host communication.

---

## Tunnel Mode

Encapsulates the **entire original IP packet**.

```text id="8zq3j4"
New IP Header | Protected [Original IP Header + Payload]
```

Commonly used in **site-to-site VPNs** and gateway-based VPNs.

🔥 Remember:

> **Tunnel mode → entire original IP packet is encapsulated.**

---

# 9. VPN Protocols / Technologies

Common technologies include:

* IPsec
* OpenVPN
* WireGuard
* TLS-based VPN solutions

### Important distinction

**IPsec operates at the IP/network layer.**

TLS operates above TCP/UDP at the transport/application boundary depending on the implementation.

---

# 10. VPN vs Proxy ⭐⭐⭐⭐

| VPN                                                                          | Proxy                                        |
| ---------------------------------------------------------------------------- | -------------------------------------------- |
| Can protect traffic from the device/network stack depending on configuration | Usually handles specific application traffic |
| Commonly creates a tunnel                                                    | Acts as intermediary                         |
| Often provides encryption                                                    | Encryption depends on proxy protocol         |
| Used for secure private-network access                                       | Often used for forwarding/filtering          |

🔥 Don't assume every proxy encrypts traffic.

---

# 11. VPN vs Firewall

They solve different problems.

```text
VPN
 ↓
Secure tunnel / private connectivity

Firewall
 ↓
Allow / block traffic according to policy
```

A VPN gateway and firewall can exist in the same device.

---

# 12. Important VPN Terms

### Tunneling

Encapsulating traffic through another logical path.

### Encryption

Makes data unreadable without the required key.

### Authentication

Verifies communicating entities.

### VPN Gateway

Endpoint that establishes/terminates VPN tunnels.

### Split Tunneling

Only selected traffic goes through VPN.

```text
Company traffic → VPN
Internet traffic → Direct Internet
```

### Full Tunnel

Most/all traffic is routed through VPN.

```text
All traffic → VPN → Internet/company network
```

---

# 🔥 GATE Traps

1. **VPN = secure/private logical connection over a public network.**
2. Tunneling means **encapsulation**; tunneling alone does not guarantee encryption.
3. **Remote-access VPN → user ↔ private network.**
4. **Site-to-site VPN → network ↔ network.**
5. **IPsec → Network Layer/IP security.**
6. **AH → authentication + integrity, no encryption.**
7. **ESP → encryption + integrity/authentication capabilities.**
8. **Tunnel mode → entire original IP packet encapsulated.**
9. Transport mode does not encapsulate the entire original IP packet.
10. VPN ≠ firewall.
11. VPN ≠ proxy.
12. Split tunneling sends only selected traffic through the VPN.

---

# ⚡ 30-Second Revision

```text
VPN
 ↓
Secure logical tunnel
 ↓
Public Internet
 ↓
Private communication

Types:
Remote Access → User ↔ Network
Site-to-Site   → Network ↔ Network

IPsec:
AH   → Integrity + Authentication
ESP  → Encryption + Integrity/Auth

Modes:
Transport → Protect payload
Tunnel    → Protect/encapsulate entire IP packet
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐

```

**09 – Network Security completed.**
```
