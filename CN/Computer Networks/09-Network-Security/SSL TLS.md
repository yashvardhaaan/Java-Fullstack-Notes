````md id="ssl-tls"
# SSL / TLS

## 1. What is SSL/TLS?

**TLS (Transport Layer Security)** is a security protocol used to protect communication over a network.

It provides:

- 🔒 Confidentiality
- 🛡️ Integrity
- 👤 Authentication

> **HTTPS = HTTP + TLS**

**SSL** is the older predecessor of TLS and is obsolete/insecure. Modern systems use TLS.

---

# 2. Why TLS is Needed ⭐⭐⭐⭐⭐

Without TLS:

```text
Client ─────── Plaintext ─────── Server
                  ↑
               Attacker
````

An attacker could:

* Read data
* Modify data
* Impersonate the server

With TLS:

```text
Client ═════ Encrypted + Authenticated ═════ Server
```

---

# 3. TLS Provides

| Security property     | TLS mechanism                       |
| --------------------- | ----------------------------------- |
| Confidentiality       | Symmetric encryption                |
| Integrity             | AEAD/MAC mechanisms                 |
| Server authentication | Digital certificate                 |
| Key establishment     | Public-key/key-agreement mechanisms |

🔥 TLS normally combines **asymmetric + symmetric cryptography**.

---

# 4. TLS Handshake ⭐⭐⭐⭐⭐

The handshake establishes the security parameters and keys.

Simplified:

```text
Client                         Server
  │                              │
  │──── ClientHello ────────────→│
  │                              │
  │←──── ServerHello ────────────│
  │←──── Certificate ────────────│
  │                              │
  │──── Key establishment ──────→│
  │                              │
  │════ Encrypted communication ═│
```

The exact TLS 1.3 handshake is more specific, but this is the important GATE-level flow.

---

# 5. Certificate in TLS ⭐⭐⭐⭐⭐

Server sends its certificate.

```text
Server
  ↓
Certificate
  ↓
Identity + Public Key
  ↓
CA signature
```

Client verifies:

* Certificate validity
* Domain/identity
* Certificate chain
* CA signature
* Relevant extensions

If valid → server identity can be trusted.

---

# 6. Key Establishment

TLS needs a shared secret/session key for efficient encryption.

Modern TLS commonly uses **ephemeral Diffie-Hellman** key exchange.

```text
Client + Server
      ↓
Key Agreement
      ↓
Shared Secret
      ↓
Session Keys
```

🔥 Important:

**Diffie-Hellman establishes a shared secret; it does not by itself authenticate the server.**

The certificate/signature provides authentication.

---

# 7. Symmetric Encryption for Data ⭐⭐⭐⭐⭐

After the handshake:

```text
Shared Session Keys
       ↓
Symmetric Encryption
       ↓
Bulk Application Data
```

Why?

Symmetric encryption is much faster than public-key cryptography.

Modern TLS commonly uses AEAD algorithms such as:

* AES-GCM
* ChaCha20-Poly1305

AEAD provides encryption **and** integrity/authentication of the protected data.

---

# 8. HTTPS + TLS

Typical stack:

### HTTP/1.1 or HTTP/2

```text
HTTP
 ↓
TLS
 ↓
TCP
 ↓
IP
 ↓
Ethernet/Wi-Fi
```

### HTTP/3

```text
HTTP/3
 ↓
QUIC
 ↓
UDP
 ↓
IP
```

🔥 **HTTP/3 does NOT use TCP.**

---

# 9. TLS vs SSL

| SSL                  | TLS                              |
| -------------------- | -------------------------------- |
| Older protocol       | Modern successor                 |
| SSLv2/SSLv3 obsolete | TLS 1.2/1.3 widely used          |
| Insecure             | Secure when correctly configured |

> **Never say HTTPS uses SSL as the modern protocol. It uses TLS.**

---

# 10. TLS 1.2 vs TLS 1.3 ⭐⭐⭐⭐

### TLS 1.2

* Older but still widely encountered
* More handshake/key-exchange options

### TLS 1.3

* Simplified handshake
* Removes many obsolete/weak cryptographic options
* Typically fewer round trips
* Uses modern cryptographic mechanisms

🔥 For modern security, **TLS 1.3 is preferred**.

---

# 11. What TLS Does NOT Guarantee

TLS secures the communication channel, but it does not automatically guarantee:

* The website itself is honest
* The application has no vulnerabilities
* The endpoint is malware-free
* All metadata is hidden

For example, an observer may still learn information such as:

```text
IP address
Timing
Traffic volume
```

depending on the protocol and deployment.

---

# 12. TLS Authentication

In normal HTTPS:

```text
Client
  ↓
Authenticates Server
  ↓
Server Certificate
```

Client authentication can also be performed using **client certificates** in mutual TLS (mTLS).

```text
Client Certificate + Server Certificate
              ↓
       Mutual Authentication
```

---

# 🔥 GATE Traps

1. **HTTPS = HTTP + TLS**
2. SSL is obsolete; modern systems use TLS.
3. TLS provides **confidentiality + integrity + authentication**.
4. Certificate authenticates/binds the server's identity to its public key.
5. Certificate does **not** contain the private key.
6. Modern TLS commonly uses asymmetric/key-agreement mechanisms for establishing keys.
7. Bulk data is encrypted using **symmetric cryptography**.
8. Basic Diffie-Hellman alone does not authenticate the server.
9. **HTTP/3 → QUIC → UDP**, not TCP.
10. TLS does not hide all network metadata.
11. TLS 1.3 is newer and generally preferred over TLS 1.2.
12. mTLS can authenticate **both client and server**.

---

# ⚡ 30-Second Revision

```text
HTTPS
  ↓
HTTP + TLS
  ↓
TLS Handshake
  ↓
Server Certificate
  ↓
Authenticate Server
  ↓
Key Agreement
  ↓
Session Keys
  ↓
Symmetric Encryption
  ↓
Secure HTTP Data
```

### Remember

```text
Certificate → Authentication
DH           → Key Agreement
AES-GCM      → Fast encrypted data
TLS          → Secure communication
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
