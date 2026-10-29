# `11-AES.md`

# AES — Advanced Encryption Standard

## 1. First Principle

**AES is a symmetric encryption algorithm.**

The same secret key is used to encrypt and decrypt data.

```text
Plaintext
   ↓
AES + Secret Key
   ↓
Ciphertext
   ↓
AES + Same Secret Key
   ↓
Plaintext
```

AES is one of the most widely used encryption algorithms in modern systems.

---

# 2. Why AES Is Important

AES is designed for **fast bulk encryption**.

It is used in:

```text
HTTPS
VPNs
Wi-Fi security
Disk encryption
Database encryption
Cloud storage
Messaging systems
File encryption
```

Unlike RSA, AES can efficiently encrypt large amounts of data.

---

# 3. AES Key Sizes

AES supports:

```text
AES-128 → 128-bit key
AES-192 → 192-bit key
AES-256 → 256-bit key
```

Important:

> AES-256 is not automatically "better" for every application. It provides a larger security margin but can have slightly higher computational cost.

AES-128 is already considered cryptographically strong for many applications.

---

# 4. AES Is a Block Cipher

AES processes data in fixed-size blocks:

```text
AES block size = 128 bits = 16 bytes
```

The key size can vary:

```text
128 / 192 / 256 bits
```

Notice:

```text
Key size ≠ Block size
```

---

# 5. AES Modes of Operation

AES itself encrypts individual blocks.

A **mode of operation** defines how AES is used to encrypt larger messages.

Common modes:

```text
ECB
CBC
CTR
GCM
```

---

# 6. ECB — Avoid It

ECB encrypts identical plaintext blocks into identical ciphertext blocks.

```text
Same plaintext
      ↓
Same ciphertext
```

This can reveal patterns.

Therefore:

```text
❌ AES-ECB
```

should generally not be used for application encryption.

---

# 7. CBC

CBC chains blocks together using an IV.

Conceptually:

```text
Plaintext
   ↓
XOR with previous block / IV
   ↓
AES
   ↓
Ciphertext
```

CBC requires careful implementation and **does not inherently provide integrity/authentication**.

Modern applications generally prefer authenticated encryption such as AES-GCM.

---

# 8. AES-GCM

**AES-GCM** is one of the most important AES modes for modern cybersecurity.

GCM provides:

```text
Confidentiality
+
Integrity
+
Authentication of ciphertext
```

This makes it an **AEAD** mode:

> Authenticated Encryption with Associated Data

Conceptually:

```text
Plaintext
    ↓
 AES-GCM
    ↓
Ciphertext + Authentication Tag
```

---

# 9. Authentication Tag

The authentication tag helps detect modification.

Example:

```text
Original ciphertext
       ↓
Verification
       ↓
Valid ✓
```

If an attacker modifies the ciphertext:

```text
Modified ciphertext
       ↓
Verification
       ↓
Invalid ✗
```

The application should reject the modified data.

---

# 10. Nonce / IV

AES-GCM requires a nonce.

A critical rule:

> **Never reuse the same nonce with the same AES-GCM key.**

Bad:

```text
Key = K
Nonce = N

Message 1 → K + N
Message 2 → K + N   ❌
```

Good:

```text
Key = K

Message 1 → unique nonce
Message 2 → different nonce
Message 3 → different nonce
```

Nonce management is one of the most important practical AES security considerations.

---

# 11. AES-GCM in a Web Application

Suppose an application stores sensitive information.

```text
User Data
   ↓
AES-GCM
   ↓
Encrypted Data
+
Nonce
+
Authentication Tag
```

The encryption key should **not** be stored directly in source code:

```java
String key = "my-secret-key";   // ❌
```

Instead, use appropriate secret-management infrastructure such as:

```text
KMS
HSM
Secret Manager
Environment-managed secrets
```

---

# 12. Industry Example — Database Encryption

Suppose an application stores sensitive customer information.

Instead of storing:

```text
PAN: 1234567890123456
```

the application can encrypt sensitive fields.

Conceptually:

```text
Sensitive Data
      ↓
AES-GCM
      ↓
Ciphertext + Nonce + Tag
      ↓
Database
```

When authorized access occurs:

```text
Database
   ↓
Decrypt
   ↓
Application
   ↓
Authorized user
```

Encryption does **not** replace access control.

---

# 13. Industry Example — Full Disk Encryption

Operating systems can use encryption to protect data if a laptop or drive is stolen.

Conceptually:

```text
Disk Data
   ↓
Encryption
   ↓
Encrypted Storage
```

Examples include:

```text
BitLocker
FileVault
LUKS
```

If an attacker removes the physical drive, the stored data remains protected without the required key/recovery mechanism.

---

# 14. AES + RSA Hybrid Encryption

A common real-world architecture combines asymmetric and symmetric cryptography.

```text
             Random AES Key
                  ↓
        ┌─────────┴─────────┐
        ↓                   ↓
   AES-GCM              RSA-OAEP
        ↓                   ↓
 Encrypt Data        Encrypt AES Key
        ↓                   ↓
 Ciphertext          Encrypted AES Key
```

This works because:

```text
AES
→ Fast

RSA
→ Useful for protecting small secrets/keys
```

This is a fundamental cryptographic architecture.

---

# 15. Small Python Lab

Using a high-level authenticated-encryption library:

```python
from cryptography.fernet import Fernet

key = Fernet.generate_key()

cipher = Fernet(key)

message = b"Sensitive information"

encrypted = cipher.encrypt(message)

decrypted = cipher.decrypt(encrypted)

print(encrypted)
print(decrypted.decode())
```

Output conceptually:

```text
Encrypted: b'gAAAAA...'
Decrypted: Sensitive information
```

Fernet is a higher-level construction rather than direct raw AES-GCM usage, but it is useful for understanding application-level authenticated encryption.

---

# 16. AES Security Mistakes

### ❌ Hardcoding keys

```text
AES_KEY = "123456"
```

### ❌ Reusing GCM nonces

Especially dangerous.

### ❌ Using ECB

```text
AES-ECB ❌
```

### ❌ Encrypting without integrity protection

Prefer:

```text
AES-GCM
```

or another authenticated-encryption construction.

### ❌ Using weak/randomly generated keys

Keys must come from a cryptographically secure random source.

### ❌ Losing the key

Strong encryption is useless if the legitimate application cannot recover its key.

---

# 17. AES vs RSA

| Feature | AES | RSA |
|---|---|---|
| Type | Symmetric | Asymmetric |
| Keys | One secret key | Public + private |
| Speed | Very fast | Much slower |
| Large data | Excellent | Poor choice |
| Typical use | Bulk encryption | Key protection/signatures |
| Example | AES-GCM | RSA-OAEP/PSS |

Typical architecture:

```text
RSA/ECDH
   ↓
Securely establish AES key
   ↓
AES-GCM
   ↓
Encrypt application data
```

---

# 18. SOC Relevance

A SOC analyst may encounter:

```text
Encrypted files
AES-encrypted traffic
VPN traffic
Disk encryption
Encrypted database fields
Ransomware encryption
Application encryption
```

Important distinction:

> **Encryption itself is not malicious.**

For example:

```text
HTTPS traffic
```

is normally legitimate encryption.

But:

```text
Massive file modifications
+
Rapid encryption
+
Unusual process
+
Deletion of backups
```

could indicate ransomware activity.

The analyst must correlate encryption with **behavior and context**.

---

# 19. Small SOC Investigation Example

Suppose a workstation suddenly shows:

```text
Thousands of files modified
Unknown process running
File extensions changed
Files become unreadable
Backup snapshots deleted
```

The presence of encryption alone isn't enough.

But the combination strongly suggests potentially malicious encryption behavior.

Possible defensive actions:

```text
1. Isolate endpoint
2. Identify responsible process
3. Preserve relevant logs
4. Check process execution history
5. Investigate account activity
6. Determine affected files/systems
7. Begin incident-response procedure
```

---

# 20. Interview Questions

### Q1. What is AES?

A symmetric block cipher used for efficient encryption of data.

### Q2. What is the AES block size?

```text
128 bits
```

### Q3. What key sizes does AES support?

```text
128, 192, 256 bits
```

### Q4. Why is AES-GCM preferred over ECB?

AES-GCM provides authenticated encryption, while ECB leaks plaintext patterns and provides no integrity protection.

### Q5. What is a nonce?

A value used with encryption to ensure cryptographic uniqueness. In AES-GCM, nonce reuse with the same key must be avoided.

### Q6. Why use AES instead of RSA for large files?

AES is much faster and designed for efficient bulk encryption.

### Q7. What does GCM provide?

```text
Confidentiality
+
Integrity/authentication
```

### Q8. What is AEAD?

**Authenticated Encryption with Associated Data** — encryption that also protects ciphertext integrity and can authenticate additional unencrypted data.

---

# 21. Quick Cheat Sheet

```text
AES
→ Symmetric block cipher

Block size
→ 128 bits

Key sizes
→ 128 / 192 / 256 bits

AES-GCM
→ Modern authenticated encryption

ECB
→ Avoid

Nonce reuse in GCM
→ Critical security failure

AES
→ Bulk encryption

RSA/ECC
→ Key establishment / key protection / signatures

AEAD
→ Encryption + integrity/authentication
```

## Core Mental Model

```text
             AES
              ↓
       Fast symmetric
          encryption
              ↓
      ┌───────┴───────┐
      ↓               ↓
 Confidentiality   Integrity
                   (with GCM)
```

**Next:** `12-HMAC.md`