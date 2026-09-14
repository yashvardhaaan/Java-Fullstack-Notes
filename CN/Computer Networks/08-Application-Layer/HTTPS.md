````md id="https-gate"
# HTTPS — HyperText Transfer Protocol Secure

## 1. Definition

**HTTPS = HTTP + TLS**

It provides secure communication between a client and web server.

> HTTPS protects HTTP data using **encryption, authentication, and integrity**.

```text
Client
  ↓
HTTPS
  ↓
TLS
  ↓
TCP
  ↓
IP
  ↓
Server
````

For HTTP/3:

```text
HTTP/3
  ↓
QUIC
  ↓
UDP
```

---

# 2. HTTPS Port ⭐⭐⭐⭐⭐

```text
HTTP  → Port 80
HTTPS → Port 443
```

🔥 **443 = HTTPS**

---

# 3. What Security Does HTTPS Provide? ⭐⭐⭐⭐⭐

HTTPS/TLS provides three major properties:

| Property        | Meaning                            |
| --------------- | ---------------------------------- |
| Confidentiality | Others cannot read encrypted data  |
| Integrity       | Detects modification/tampering     |
| Authentication  | Helps verify the server's identity |

```text
HTTPS
 ├── Confidentiality
 ├── Integrity
 └── Authentication
```

---

# 4. HTTP vs HTTPS

| HTTP                             | HTTPS                                   |
| -------------------------------- | --------------------------------------- |
| Not encrypted by HTTP itself     | Protected by TLS                        |
| Port 80                          | Port 443                                |
| Data can be observed more easily | Data is encrypted in transit            |
| No TLS server authentication     | TLS certificate can authenticate server |
| HTTP                             | HTTP + TLS                              |

---

# 5. TLS Certificate ⭐⭐⭐⭐⭐

When connecting to an HTTPS website, the server presents a **digital certificate**.

The certificate generally contains information such as:

* Server/domain identity
* Public key
* Certificate authority information
* Validity period
* Digital signature

The browser verifies the certificate using its trusted **Certificate Authority (CA)** chain.

Conceptually:

```text
Server
  ↓
Certificate
  ↓
Browser verifies CA/signature/domain
  ↓
Trusted connection
```

---

# 6. Public-Key vs Symmetric Encryption ⭐⭐⭐⭐⭐

HTTPS/TLS uses both types of cryptography.

### Public-Key Cryptography

Uses:

```text
Public Key
Private Key
```

Useful for authentication and establishing secure keying material.

### Symmetric Cryptography

Uses:

```text
Same secret key
```

It is much more efficient for bulk data encryption.

Conceptually:

```text
TLS Handshake
      ↓
Secure keys established
      ↓
Symmetric encryption
      ↓
Actual HTTP data
```

🔥 Important:

> Public-key cryptography is computationally expensive; symmetric encryption is efficient for bulk data.

---

# 7. TLS Handshake — Basic Idea ⭐⭐⭐⭐⭐

Simplified view:

```text
Client                         Server
  |                              |
  |------ ClientHello ---------->|
  |                              |
  |<----- ServerHello ------------|
  |<----- Certificate ------------|
  |                              |
  |   Key establishment/authentication
  |                              |
  |====== Encrypted Data =======>|
```

Modern TLS, especially **TLS 1.3**, has a more specific handshake and typically establishes keys with ephemeral Diffie-Hellman methods.

For GATE, understand the **purpose** rather than treating the simplified diagram as an exact packet sequence.

---

# 8. Digital Certificate vs Encryption ⭐⭐⭐⭐

A common confusion:

### Certificate

Helps answer:

> **"Who am I communicating with?"**

### Encryption

Helps answer:

> **"Can someone else read the data?"**

So:

```text
Certificate → Authentication
Encryption  → Confidentiality
TLS integrity mechanisms → Integrity
```

---

# 9. Does HTTPS Hide Everything? 🔥🔥🔥

No.

HTTPS encrypts HTTP contents in transit, but network observers may still learn some metadata depending on the protocol, network and configuration.

For example, they may observe:

* Source/destination IP addresses
* Traffic timing
* Traffic volume

DNS may also reveal domain information unless protected separately.

---

# 10. HTTPS and DNS Are Different

Do not confuse:

```text
DNS
 ↓
Find IP address
```

with:

```text
HTTPS
 ↓
Secure HTTP communication
```

A typical sequence:

```text
Domain name
    ↓
DNS resolution
    ↓
IP address
    ↓
TCP/QUIC connection
    ↓
TLS security
    ↓
HTTP communication
```

---

# 11. HTTPS and TLS Version ⭐⭐⭐⭐

Historically, HTTPS was commonly described as:

```text
HTTP
 ↓
TLS
 ↓
TCP
```

Modern web:

```text
HTTP/1.1 → TLS → TCP
HTTP/2   → TLS → TCP
HTTP/3   → QUIC → UDP
```

🔥 Do not memorize **HTTPS = TCP** as an absolute rule.

---

# 🔥 GATE Traps

### Trap 1

HTTPS is a completely separate application protocol.

❌

> HTTPS is **HTTP secured using TLS**.

---

### Trap 2

HTTPS uses port 80.

❌

> HTTPS → **443**

---

### Trap 3

HTTPS provides only encryption.

❌

TLS also provides **authentication and integrity protection**.

---

### Trap 4

The certificate itself encrypts all HTTP data.

❌

The certificate primarily supports **authentication and key establishment**; efficient symmetric cryptography is used for bulk traffic.

---

### Trap 5

HTTPS hides the destination IP address.

❌

Encryption does not normally hide IP addressing from the network.

---

### Trap 6

HTTPS always uses TCP.

❌

HTTP/3 uses:

```text
HTTP/3 → QUIC → UDP
```

---

# ⚡ 30-Second Revision

```text
HTTPS
  =
HTTP + TLS

Port = 443

Provides:
✓ Confidentiality
✓ Integrity
✓ Authentication

TLS:
Public-key mechanisms
        ↓
Secure key establishment
        ↓
Symmetric encryption
        ↓
Bulk HTTP data
```

### Must Remember

```text
HTTP   → 80
HTTPS  → 443

HTTP/1.1 → TCP
HTTP/2   → TCP
HTTP/3   → QUIC → UDP
```

### GATE Priority

**🔥🔥🔥🔥 — Very High**

Focus on:

1. HTTP vs HTTPS
2. TLS purpose
3. Certificate and CA
4. Symmetric vs asymmetric cryptography
5. HTTPS port 443
6. HTTP/3 + QUIC + UDP

```
```
