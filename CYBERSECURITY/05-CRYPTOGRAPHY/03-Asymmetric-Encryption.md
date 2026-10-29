# `03-Asymmetric-Encryption.md`

# Asymmetric Encryption

## 1. First Principle

**Asymmetric cryptography** uses a **pair of mathematically related keys**:

```text
Public Key  → Can be shared
Private Key → Must remain secret
```

Mental model:

```text
             Key Pair
                ↓
       ┌────────┴────────┐
       ↓                 ↓
  Public Key        Private Key
  Share freely       Keep secret
```

Unlike symmetric encryption:

```text
Symmetric
→ One shared secret key

Asymmetric
→ Public + Private key
```

---

# 2. Why Asymmetric Cryptography Exists

The major problem with symmetric encryption is:

> **How do two parties securely exchange a secret key?**

Imagine:

```text
Alice ───────────────→ Bob
        Internet
```

Alice and Bob don't initially share a secret.

Asymmetric cryptography allows them to establish trust or protect information using public/private keys.

---

# 3. Encryption with Public/Private Keys

A simplified encryption model:

```text
Sender
   ↓
Encrypt using recipient's Public Key
   ↓
Ciphertext
   ↓
Decrypt using recipient's Private Key
   ↓
Recipient
```

Example:

```text
Alice
 ↓
Bob's Public Key
 ↓
Encrypted message
 ↓
Bob's Private Key
 ↓
Original message
```

Only Bob should possess the private key.

---

# 4. Digital Signatures

Asymmetric cryptography is also used for **digital signatures**.

Here the direction is conceptually reversed:

```text
Message
   ↓
Hash
   ↓
Sign using Private Key
   ↓
Digital Signature
```

The recipient uses the public key to verify:

```text
Signature
   +
Public Key
   +
Message
   ↓
Valid / Invalid
```

This provides important security properties such as:

- Authentication
- Integrity
- Evidence of signing

---

# 5. Important Algorithms

Common asymmetric cryptographic systems include:

```text
RSA
ECC
ECDSA
EdDSA
Diffie-Hellman
ECDH
```

They don't all serve exactly the same purpose.

| Technology | Common use |
|---|---|
| RSA | Encryption/signatures, legacy & current systems |
| ECDSA | Digital signatures |
| Ed25519 | Digital signatures |
| DH | Key exchange |
| ECDH | Elliptic-curve key exchange |

---

# 6. Asymmetric vs Symmetric

| Feature | Symmetric | Asymmetric |
|---|---|---|
| Keys | One shared secret | Public + private |
| Speed | Fast | Generally slower |
| Bulk data | Excellent | Usually inefficient |
| Key distribution | Difficult | Easier for public keys |
| Signatures | No | Yes |
| Examples | AES, ChaCha20 | RSA, ECC |

This leads to an important industry pattern:

```text
Asymmetric Cryptography
        ↓
Authentication / Key Establishment
        ↓
Symmetric Session Key
        ↓
Bulk Data Encryption
```

---

# 7. Industry Example — HTTPS

When you connect to:

```text
https://example.com
```

TLS uses public-key cryptography to authenticate the server and establish cryptographic secrets.

Then:

```text
Browser
   ↓
TLS Handshake
   ↓
Certificate / Authentication
   ↓
Key Establishment
   ↓
Symmetric Session Keys
   ↓
Encrypted Application Traffic
```

Why not use RSA to encrypt every HTTP packet?

Because asymmetric operations are generally much more computationally expensive than symmetric encryption.

---

# 8. Diffie-Hellman Key Exchange

**Diffie-Hellman (DH)** allows two parties to establish a shared secret over an insecure network.

Conceptually:

```text
Alice                         Bob
  │                             │
  │──── Public information ────→│
  │                             │
  │──── Key exchange ──────────→│
  │                             │
  └──── Shared Secret ──────────┘
```

The important idea:

> Alice and Bob can derive the same shared secret without directly sending that secret across the network.

That shared secret can then be used to derive symmetric encryption keys.

---

# 9. Forward Secrecy

Modern TLS commonly uses **ephemeral Diffie-Hellman**, such as ECDHE, to provide **forward secrecy**.

Conceptually:

```text
Session 1 → Temporary key
Session 2 → Different temporary key
Session 3 → Different temporary key
```

If a long-term private key is compromised later, previously captured sessions can remain protected when forward secrecy is correctly implemented.

This is a major reason modern TLS prefers ephemeral key exchange.

---

# 10. Industry Example — SSH

SSH uses public-key cryptography for authentication and key establishment.

A common workflow:

```text
Client
   ↓
SSH Server
   ↓
Server identity verification
   ↓
Key exchange
   ↓
Encrypted session
```

For public-key authentication:

```text
Private Key → Client
Public Key  → Server
```

The client proves possession of the private key without sending the private key to the server.

---

# 11. Practical Cybersecurity Scenario

### Scenario

An organization discovers an employee's SSH private key was accidentally exposed.

For example:

```text
id_rsa
```

was uploaded to a public repository.

This is serious because:

```text
Private Key Exposed
       ↓
Attacker may authenticate as key owner
       ↓
Potential unauthorized server access
```

Incident response should include:

```text
1. Revoke/remove the key from authorized systems
2. Generate a new key pair
3. Replace the public key
4. Investigate authentication logs
5. Determine whether the exposed key was used
```

Simply deleting the file from the repository is not enough if the private key was already exposed.

---

# 12. Small Hands-On Lab — SSH Keys

Generate an SSH key pair:

```bash
ssh-keygen -t ed25519
```

This creates a key pair such as:

```text
Private key → ~/.ssh/id_ed25519
Public key  → ~/.ssh/id_ed25519.pub
```

Check the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

### Important

Never share:

```text
~/.ssh/id_ed25519
```

The `.pub` file is designed to be shared.

Mental model:

```text
Private Key
→ Secret

Public Key
→ Shareable
```

---

# 13. Key Management

The cryptographic algorithm can be strong, but poor key management can destroy security.

Bad:

```text
Private Key
    ↓
GitHub
    ↓
Publicly accessible
```

Better:

```text
Private Key
    ↓
Secure storage
    ↓
Restricted access
    ↓
Rotation / revocation
```

Enterprise environments may use:

- HSMs
- Cloud KMS
- Certificate management systems
- Secrets managers

---

# 14. Common Mistakes

### ❌ Sharing private keys

```text
Private key ≠ shareable
```

### ❌ Encrypting everything with asymmetric encryption

Use symmetric encryption for bulk data.

### ❌ Trusting any public key

You must know that the public key actually belongs to the intended entity.

This is where **PKI and certificates** become important.

### ❌ Using weak/obsolete algorithms

Cryptographic algorithm choice should follow current standards and organizational requirements.

---

# 15. Cybersecurity/SOC Relevance

As a security analyst, asymmetric cryptography appears in:

```text
HTTPS/TLS
SSH
VPNs
Digital signatures
Certificates
Code signing
Email security
PKI
Cloud infrastructure
Identity systems
```

When investigating a cryptographic incident, ask:

```text
Which key?
     ↓
Who owns it?
     ↓
Where is it stored?
     ↓
Was it exposed?
     ↓
Was it used?
     ↓
Can it be revoked/rotated?
```

---

# 16. Interview Questions

### Q1. What is asymmetric encryption?

A cryptographic system using a related public/private key pair.

### Q2. What is the difference between the keys?

```text
Public Key
→ Can be shared

Private Key
→ Must remain secret
```

### Q3. Why is asymmetric cryptography slower?

Its mathematical operations are generally more computationally expensive than symmetric encryption.

### Q4. Where is asymmetric cryptography used?

- TLS
- SSH
- Digital signatures
- Key exchange
- Certificates
- Code signing

### Q5. What is Diffie-Hellman?

A key-exchange mechanism that allows parties to establish a shared secret over an insecure channel.

### Q6. What is forward secrecy?

A property where compromise of a long-term key does not expose previously established session keys when ephemeral key exchange is used correctly.

---

# 17. Quick Cheat Sheet

```text
Asymmetric Cryptography
→ Public + Private key

Public Key
→ Shareable

Private Key
→ Secret

RSA
→ Encryption/signatures

ECC
→ Public-key cryptography family

ECDSA
→ Digital signatures

Ed25519
→ Digital signatures

DH
→ Key exchange

ECDH
→ Elliptic-curve key exchange

ECDHE
→ Ephemeral key exchange + forward secrecy

TLS
→ Uses asymmetric cryptography for authentication/key establishment
   and symmetric cryptography for bulk data
```

## Core Mental Model

```text
             ASYMMETRIC CRYPTOGRAPHY
                       ↓
              Public + Private Key
                 /           \
                ↓             ↓
        Authentication      Key Exchange
                ↓             ↓
         Digital Signature   Shared Secret
                              ↓
                       Symmetric Encryption
                              ↓
                         Secure Session
```

**Next:** `04-Hashing.md`