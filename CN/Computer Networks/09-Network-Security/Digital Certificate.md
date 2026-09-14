````md id="digital-certificate"
# Digital Certificate

## 1. What is a Digital Certificate?

A **digital certificate** is an electronic document that binds an **identity to a public key**.

> **Certificate = Identity ↔ Public Key**

Example:

```text
Website: example.com
        ↓
Digital Certificate
        ↓
Public Key + Identity information
        ↓
Signed by CA
````

---

# 2. Why Do We Need Certificates? ⭐⭐⭐⭐⭐

Suppose a server sends you its public key.

How do you know the key actually belongs to that server?

An attacker could send their own public key.

```text
Without Certificate:

Client → "Give me your public key"
Server → Public Key

Attacker could replace it → MITM
```

A certificate provides a trusted way to associate:

**Server identity → Public key**

---

# 3. Certificate Authority (CA) ⭐⭐⭐⭐⭐

**CA = Certificate Authority**

A trusted organization that issues/signs digital certificates.

```text
        CA
        ↓
   Signs Certificate
        ↓
 ┌──────────────────┐
 │ example.com      │
 │ Public Key       │
 │ Validity         │
 │ CA Signature     │
 └──────────────────┘
```

Examples of certificate-related CAs include organizations such as DigiCert, Let's Encrypt, etc.

---

# 4. What Does a Certificate Contain?

Important information includes:

* Subject/identity
* Subject's public key
* Issuer (CA)
* Validity period
* Serial number
* Signature algorithm
* CA's digital signature
* Extensions such as permitted names/usages

### 🔥 Most Important

**Certificate contains a public key, NOT the private key.**

---

# 5. Certificate Chain ⭐⭐⭐⭐⭐

Trust is often established through a chain:

```text
Root CA
   ↓
Intermediate CA
   ↓
Server Certificate
   ↓
example.com
```

### Root CA

Trusted by the operating system/browser.

### Intermediate CA

Issues certificates on behalf of the root.

### Server Certificate

Identifies the actual server/domain.

> **Trust flows from a trusted root through the chain to the server certificate.**

---

# 6. How Browser Verifies a Certificate

When visiting HTTPS:

```text
1. Server sends certificate
          ↓
2. Browser checks:
   • Domain/name
   • Validity period
   • Certificate chain
   • CA signatures
   • Key usage/extensions
          ↓
3. Valid?
      ↓
   Continue TLS
```

If validation fails, the browser may show a certificate warning.

---

# 7. Digital Signature of Certificate ⭐⭐⭐⭐⭐

The CA digitally signs the certificate.

Conceptually:

```text
Certificate Data
      ↓
     Hash
      ↓
Sign with CA Private Key
      ↓
CA Digital Signature
```

Browser verifies it using the **CA's trusted public key**.

```text
CA Signature
     ↓
Verify with CA Public Key
     ↓
Valid / Invalid
```

🔥 **CA private key signs. CA public key verifies.**

---

# 8. Certificate vs Public Key

These are **not the same thing**.

| Public Key                        | Digital Certificate                 |
| --------------------------------- | ----------------------------------- |
| Cryptographic key                 | Electronic document                 |
| Used for crypto operations        | Binds identity to public key        |
| Doesn't inherently prove identity | Provides identity/trust information |
| Part of certificate               | Contains public key                 |

---

# 9. Certificate vs Digital Signature

| Certificate                  | Digital Signature                |
| ---------------------------- | -------------------------------- |
| Binds identity to public key | Proves integrity/authorship      |
| Issued/signed by CA          | Created by signer                |
| Used for trust               | Used for signing/verification    |
| Contains public key          | Signature is cryptographic proof |

---

# 10. Certificate in HTTPS ⭐⭐⭐⭐⭐

Simplified TLS flow:

```text
Client
  ↓
Connect to HTTPS server
  ↓
Server sends Certificate
  ↓
Client verifies certificate
  ↓
Secure key establishment
  ↓
Symmetric encryption
  ↓
Encrypted HTTP data
```

So certificates mainly solve the **authentication/trust** problem.

TLS then establishes a secure channel.

---

# 11. Certificate Expiration

Certificates have a validity period:

```text
Not Before ───────────── Not After
```

If expired:

❌ Certificate validation fails.

This is why websites need certificates renewed before expiration.

---

# 12. Revocation ⭐⭐⭐⭐

A certificate may need to be invalidated before its expiration.

Reasons:

* Private key compromised
* Certificate issued incorrectly
* Domain ownership changes

Common mechanisms:

### CRL

**Certificate Revocation List**

A list of revoked certificates.

### OCSP

**Online Certificate Status Protocol**

Allows checking certificate status with an OCSP responder.

---

# 🔥 GATE Traps

1. **Digital certificate binds identity to a public key.**
2. Certificate contains the **public key**, not private key.
3. **CA signs certificates.**
4. CA's **private key → sign**.
5. CA's **public key → verify**.
6. Certificate ≠ public key.
7. Certificate ≠ digital signature.
8. Root CA is generally a trust anchor.
9. Intermediate CA can issue/sign end-entity certificates.
10. Certificate expiration can cause HTTPS validation failure.
11. CRL and OCSP are used for **revocation/status checking**.
12. Certificates help prevent MITM by authenticating the public key's identity binding.

---

# ⚡ 30-Second Revision

```text
Digital Certificate
        ↓
Identity ↔ Public Key
        ↓
Signed by CA
        ↓
Browser verifies CA signature
        ↓
Trust established
        ↓
TLS secure communication
```

### Key relationships

```text
CA Private Key → Sign certificate
CA Public Key  → Verify certificate

Server Private Key → Prove possession / TLS operations
Server Public Key  → Included in certificate
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
