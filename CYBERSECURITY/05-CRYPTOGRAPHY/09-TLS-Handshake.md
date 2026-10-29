# `09-TLS-Handshake.md`

# TLS Handshake — Cryptography Notes

## 1. First Principle

**TLS (Transport Layer Security)** establishes a secure connection between a client and server.

It provides:

```text id="4c4p5r"
Confidentiality
+
Integrity
+
Server Authentication
```

Simplified:

```text id="k1t0h7"
Browser
   ↓
TLS Handshake
   ↓
Verify Server
   ↓
Establish Session Keys
   ↓
Encrypted Communication
```

---

# 2. Why Do We Need TLS?

Without TLS:

```text id="f3z0e9"
Browser ─── HTTP ───→ Server
              ↓
           Attacker
              ↓
        Can potentially
        observe/modify traffic
```

With TLS:

```text id="q8j1wa"
Browser ─── TLS ───→ Server
              ↓
       Encrypted Traffic
```

This is why:

```text id="q0u1w8"
http://
```

is generally replaced by:

```text id="k3u4q1"
https://
```

for security-sensitive web traffic.

---

# 3. High-Level TLS Flow

A simplified modern TLS 1.3 flow:

```text id="1o8h2y"
Client
  │
  │ ClientHello
  ↓
Server
  │
  │ ServerHello + Certificate
  ↓
Client
  │
  │ Key Exchange
  ↓
Both sides derive session keys
  │
  ↓
Encrypted Application Data
```

The actual TLS 1.3 handshake contains additional details, but this is the important mental model.

---

# 4. Step 1 — ClientHello

The browser sends a **ClientHello**.

It contains information such as:

- Supported TLS versions
- Supported cipher suites
- Random/nonce-related values
- Key-share information
- Server Name Indication (SNI), when used

Conceptually:

```text id="i4ay12"
Client
 ↓
"I support these TLS capabilities"
```

---

# 5. Step 2 — ServerHello

The server responds with parameters selected from the client's supported options.

Conceptually:

```text id="7kgy58"
Client capabilities
       ↓
Server chooses compatible parameters
       ↓
ServerHello
```

The server also sends information needed for authentication and key establishment.

---

# 6. Step 3 — Server Certificate

The server provides its certificate chain.

```text id="j6x1wb"
Server
  ↓
Certificate
  ↓
Public Key + Identity + CA signatures
```

The client validates things such as:

```text id="g4r7af"
Hostname
Validity
Certificate chain
Signature
Trust
```

If validation fails, the browser may show a certificate warning.

---

# 7. Step 4 — Key Exchange

Modern TLS commonly uses ephemeral Diffie-Hellman mechanisms such as **ECDHE**.

Conceptually:

```text id="9i1o4b"
Client Key Share
       +
Server Key Share
       ↓
Shared Secret
```

The shared secret isn't simply sent across the network.

Both sides derive the necessary session keys from the handshake.

---

# 8. Step 5 — Session Keys

After successful key establishment:

```text id="iy7e2k"
Shared Secret
      ↓
TLS Key Derivation
      ↓
Session Keys
```

These symmetric keys protect application traffic.

This gives us the important pattern:

```text id="8k5z6s"
Asymmetric / Key Exchange
          ↓
      Establish Keys
          ↓
Symmetric Encryption
          ↓
   Bulk Application Data
```

---

# 9. Step 6 — Encrypted Application Data

Once the handshake establishes the required keys:

```text id="m8a7x1"
HTTP Request
     ↓
TLS Encryption
     ↓
Encrypted TLS Record
     ↓
Internet
     ↓
TLS Decryption
     ↓
HTTP Request
```

Modern TLS commonly uses authenticated encryption such as:

```text id="9u3r8n"
AES-GCM
ChaCha20-Poly1305
```

---

# 10. Why TLS Uses Both Asymmetric and Symmetric Cryptography

This is a very common interview question.

### Asymmetric cryptography

Used for:

- Authentication
- Key establishment
- Digital signatures

### Symmetric cryptography

Used for:

- Bulk application data

Why?

```text id="w3a6fy"
Asymmetric
→ More computationally expensive

Symmetric
→ Much faster
```

Therefore:

```text id="6qk9h1"
TLS Handshake
      ↓
Public-key authentication / key exchange
      ↓
Session keys
      ↓
Symmetric encryption
```

---

# 11. Forward Secrecy

TLS 1.3 commonly uses ephemeral key exchange.

Conceptually:

```text id="2s9t7x"
Session 1 → Temporary Key A
Session 2 → Temporary Key B
Session 3 → Temporary Key C
```

If the server's long-term authentication private key is compromised later, previously captured sessions can remain protected when forward secrecy was correctly used.

This is called:

**Forward Secrecy**

---

# 12. Industry-Level Example — Banking Website

You open:

```text id="3k7x9v"
https://bank.example
```

The process is approximately:

```text id="z5y2m8"
Browser
   ↓
ClientHello
   ↓
Bank Server
   ↓
ServerHello + Certificate
   ↓
Certificate Validation
   ↓
ECDHE Key Exchange
   ↓
Session Keys
   ↓
Encrypted HTTPS Traffic
```

Your login credentials and application data are then protected by the established TLS session.

---

# 13. Industry Security Scenario

### Scenario

A SOC analyst receives an alert:

```text id="l7h3f0"
TLS Certificate Changed
```

The analyst checks:

```text id="w1x8cz"
Certificate
 ↓
Issuer
 ↓
SAN
 ↓
Validity
 ↓
Public Key
 ↓
Thumbprint
 ↓
Deployment/change record
```

If the certificate was changed by an authorized deployment:

```text id="5k3x2d"
Expected change
```

If there is no legitimate change:

```text id="r7m5v2"
Unexpected certificate
       +
Unauthorized deployment
       ↓
Investigate potential compromise
```

---

# 14. TLS Inspection with OpenSSL

You can inspect a TLS connection:

```bash id="7v4d2m"
openssl s_client -connect example.com:443 -servername example.com
```

Useful information includes:

```text id="0z7h9f"
Certificate
Issuer
TLS Version
Cipher
Certificate Chain
```

To inspect supported TLS information, tools such as OpenSSL and dedicated TLS scanners can be used in authorized environments.

---

# 15. Check HTTPS with Browser

Open a legitimate HTTPS website.

Click the browser's:

```text id="8c4p2r"
Security / Lock icon
```

Inspect:

```text id="j2w8k6"
Certificate
Issuer
Validity
Connection security
```

This gives you practical exposure to the same PKI concepts from the previous files.

---

# 16. TLS 1.2 vs TLS 1.3

| TLS 1.2 | TLS 1.3 |
|---|---|
| Older modern standard | Newer standard |
| More handshake complexity | Simplified handshake |
| Supports many older cipher choices | Removes many legacy options |
| Still widely encountered | Preferred where supported |
| Can provide forward secrecy | Designed around modern key exchange |

For modern deployments:

> **Prefer TLS 1.3 where supported, while securely configuring TLS 1.2 when compatibility requires it.**

Avoid obsolete protocols such as:

```text id="l7x3v5"
SSLv2
SSLv3
TLS 1.0
TLS 1.1
```

for modern secure deployments.

---

# 17. Common TLS Attacks / Weaknesses

You should understand these concepts:

### Certificate Validation Failure

If clients don't properly validate certificates, attackers may impersonate servers.

### Downgrade Attacks

Attempting to force communication onto weaker protocols or algorithms.

### Weak Cipher Configuration

Using obsolete or weak cryptographic algorithms.

### Private Key Compromise

If a server's private key is compromised, certificate trust and authentication may be affected.

### TLS Misconfiguration

Examples:

```text id="6h8s9f"
Expired certificate
Wrong hostname
Incomplete chain
Weak protocol
Weak cipher
Incorrect trust configuration
```

---

# 18. SOC Investigation Model

When investigating TLS:

```text id="8x5v3q"
Connection
    ↓
Destination
    ↓
TLS Version
    ↓
Certificate
    ↓
Issuer
    ↓
Hostname/SAN
    ↓
Cipher / Key Exchange
    ↓
Expected or suspicious?
```

Don't assume:

```text id="s9k4l2"
Encrypted traffic = malicious
```

Attackers can use HTTPS just like legitimate applications.

The important question is:

> **What is communicating, with whom, and is the behavior expected?**

---

# 19. Small Hands-On Lab

Run:

```bash id="e8s2f6"
openssl s_client -connect example.com:443 -servername example.com
```

Identify:

```text id="w2m6r8"
1. TLS version
2. Certificate subject
3. Certificate issuer
4. Certificate validity
5. Certificate chain
6. Negotiated cipher
```

Then connect to a different legitimate HTTPS site and compare the results.

---

# 20. Interview Questions

### Q1. What is TLS?

A protocol that provides secure communication using authentication, key establishment, encryption, and integrity protection.

### Q2. Why is HTTPS secure?

HTTPS uses HTTP over TLS, providing an authenticated and cryptographically protected communication channel when TLS is correctly configured and certificate validation succeeds.

### Q3. Why does TLS use symmetric encryption?

Because symmetric encryption is efficient for protecting large amounts of application data.

### Q4. Why is a certificate needed?

To bind a server identity to a public key through a trusted PKI mechanism.

### Q5. What is forward secrecy?

Protection for past sessions against later compromise of long-term authentication keys when ephemeral key exchange is used correctly.

### Q6. What is ECDHE?

Elliptic Curve Diffie-Hellman Ephemeral, a key-exchange mechanism commonly used to provide forward secrecy.

### Q7. What should you check when a TLS certificate changes unexpectedly?

```text id="4q1h8x"
Issuer
SAN
Validity
Public key
Thumbprint
Deployment history
Server configuration
```

---

# 21. Quick Cheat Sheet

```text id="t4x8h3"
TLS
→ Secure communication protocol

HTTPS
→ HTTP over TLS

ClientHello
→ Client capabilities + key-share information

ServerHello
→ Server-selected parameters

Certificate
→ Server identity/public-key binding

ECDHE
→ Key exchange + forward secrecy

Session Key
→ Symmetric key used for application traffic

AES-GCM
→ Authenticated encryption

ChaCha20-Poly1305
→ Authenticated encryption

TLS 1.3
→ Modern TLS version

OpenSSL
→ Useful TLS inspection tool

Certificate Validation
→ Identity + chain + validity + hostname
```

## Core Mental Model

```text id="9z6t3p"
                    TLS
                     ↓
                ClientHello
                     ↓
                ServerHello
                     ↓
               Certificate
                     ↓
             Certificate Check
                     ↓
              Key Exchange
                     ↓
              Session Keys
                     ↓
          Symmetric Encryption
                     ↓
           Secure HTTPS Traffic
```

**Next:** `10-RSA.md`