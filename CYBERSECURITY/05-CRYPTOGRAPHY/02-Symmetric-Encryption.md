# `02-Symmetric-Encryption.md`

# Symmetric Encryption

## 1. First Principle

**Symmetric encryption** uses the **same secret key** to encrypt and decrypt data.

```text
Plaintext
    ↓
Encryption + Secret Key
    ↓
Ciphertext
    ↓
Decryption + Same Secret Key
    ↓
Plaintext
```

Example:

```text
"Salary = ₹50,000"
       ↓
    AES + Key
       ↓
"8F7A91C..."
       ↓
    AES + Key
       ↓
"Salary = ₹50,000"
```

The biggest challenge is:

> **How do both parties securely obtain the same secret key?**

This is called the **key-distribution problem**.

---

# 2. Why Symmetric Encryption Is Important

Symmetric encryption is extremely fast compared with public-key cryptography.

Therefore it is commonly used for:

- HTTPS/TLS application data
- Disk encryption
- Database encryption
- File encryption
- VPN traffic
- Backup encryption
- Cloud storage encryption

Mental model:

```text
Large Amount of Data
        ↓
Symmetric Encryption
        ↓
Fast + Efficient
```

---

# 3. Important Algorithms

Common modern symmetric algorithms include:

### AES

**Advanced Encryption Standard**

Widely used in:

- TLS
- Disk encryption
- Cloud services
- Applications

Common key sizes:

```text
AES-128
AES-192
AES-256
```

### ChaCha20

Another modern symmetric cipher, often paired with **Poly1305** for authenticated encryption.

---

# 4. Block Cipher vs Stream Cipher

## Block Cipher

Processes data in fixed-size blocks.

Example:

```text
AES
```

AES uses:

```text
128-bit block size
```

The key can be:

```text
128 / 192 / 256 bits
```

---

## Stream Cipher

Conceptually encrypts a stream of data using a generated keystream.

Example:

```text
ChaCha20
```

Mental model:

```text
Block Cipher
→ Data blocks

Stream Cipher
→ Data stream
```

---

# 5. Encryption Mode Matters

Using AES alone isn't enough.

AES needs an appropriate **mode of operation**.

Common modes:

```text
CBC
GCM
CTR
ECB
```

For modern application encryption, **AES-GCM** is particularly important because it provides authenticated encryption.

---

# 6. AES-GCM

AES-GCM provides:

```text
Confidentiality
      +
Integrity / Authentication
```

Conceptually:

```text
Plaintext
   +
Secret Key
   +
Nonce
   ↓
AES-GCM
   ↓
Ciphertext + Authentication Tag
```

The authentication tag allows the receiver to detect tampering.

This is called **AEAD**:

> Authenticated Encryption with Associated Data.

---

# 7. Nonce / IV

A nonce is additional input used during encryption.

For AES-GCM:

> **Never reuse the same nonce with the same key.**

Conceptually:

```text
Key = K

Nonce A → Encryption 1
Nonce B → Encryption 2
Nonce C → Encryption 3
```

Reusing a nonce incorrectly can seriously compromise security.

This is one of the most important practical rules in symmetric cryptography.

---

# 8. ECB — Why It Is Dangerous

ECB encrypts identical plaintext blocks into identical ciphertext blocks.

Conceptually:

```text
Plaintext:
AAAA
AAAA
AAAA

ECB:
XXXX
XXXX
XXXX
```

Patterns can remain visible.

Therefore:

> **Do not use AES-ECB for general-purpose secure application encryption.**

Prefer an authenticated encryption mode such as:

```text
AES-GCM
```

---

# 9. CBC

CBC was historically widely used.

It requires an IV and appropriate integrity protection.

The major practical lesson:

> **Encryption alone does not automatically provide integrity.**

For modern applications, authenticated encryption such as AES-GCM is generally preferable when available.

---

# 10. Industry Example — Database Encryption

Suppose an application stores sensitive information:

```text
Customer
 ├── Name
 ├── Email
 └── Sensitive Data
```

Instead of storing sensitive data directly:

```text
Sensitive Data
      ↓
AES-GCM
      ↓
Ciphertext
```

The encryption key should **not** be stored beside the encrypted data in plaintext.

A production architecture might use:

```text
Application
     ↓
Key Management System
     ↓
Encryption Key
     ↓
Encrypt Data
```

Examples of enterprise key-management services include cloud KMS/HSM systems.

---

# 11. Industry Example — HTTPS

TLS uses asymmetric cryptography for authentication/key establishment and symmetric cryptography for efficiently protecting application traffic.

Simplified:

```text
Browser
   ↓
TLS Handshake
   ↓
Establish Session Keys
   ↓
Symmetric Encryption
   ↓
Large HTTPS Data Transfer
```

Why?

Because symmetric encryption is efficient for large amounts of data.

---

# 12. Key Management

The encryption algorithm can be strong but the system can still be insecure if the key is poorly managed.

Bad:

```java
String key = "password123";
```

Better architecture:

```text
Application
    ↓
Secrets / KMS
    ↓
Encryption Key
```

Important key-management practices:

- Don't hardcode keys
- Don't commit keys to Git
- Restrict key access
- Rotate keys appropriately
- Audit key usage
- Use secure key-management systems

---

# 13. Industry Security Scenario

### Scenario

A developer accidentally commits:

```text
AES_KEY=MySuperSecretKey
```

to a public Git repository.

Even if the application uses AES-256 correctly:

```text
Strong Algorithm
       +
Compromised Key
       =
Compromised Security
```

The correct response is to:

```text
Revoke/rotate exposed key
        ↓
Investigate usage
        ↓
Remove secret from source control/history where appropriate
        ↓
Deploy new secret
        ↓
Review access logs
```

**Changing the code alone is not enough if the old key was exposed.**

---

# 14. Small Hands-On Lab

Python's standard `cryptography` package can demonstrate authenticated symmetric encryption.

Install:

```bash
pip install cryptography
```

Example:

```python
from cryptography.fernet import Fernet

key = Fernet.generate_key()
cipher = Fernet(key)

message = b"Confidential data"

encrypted = cipher.encrypt(message)
decrypted = cipher.decrypt(encrypted)

print(encrypted)
print(decrypted)
```

### What happens?

```text
generate_key()
    ↓
Create secret key

encrypt()
    ↓
Plaintext → Ciphertext

decrypt()
    ↓
Ciphertext → Plaintext
```

Fernet is a high-level authenticated encryption construction; it is useful for learning, while production designs should choose cryptographic primitives and key management based on the application's requirements.

---

# 15. SOC / Cybersecurity Relevance

As a cybersecurity analyst, you may encounter:

```text
Encrypted files
Encrypted network traffic
Disk encryption
Database encryption
Ransomware
TLS traffic
Cloud KMS
Secrets management
```

You need to distinguish:

```text
Legitimate Encryption
        vs
Malicious Encryption
```

For example:

```text
HTTPS traffic
→ Normally expected

Sudden mass encryption of user files
→ Potential ransomware behavior
```

Encryption itself is not malicious.

**Context and behavior matter.**

---

# 16. Common Mistakes

### ❌ Using ECB

```text
AES-ECB
```

Avoid for general secure application encryption.

### ❌ Reusing GCM nonces

```text
Same Key + Same Nonce
→ Dangerous
```

### ❌ Hardcoding keys

```text
API_KEY = "secret"
```

### ❌ Storing keys with ciphertext

Don't simply do:

```text
database
├── encrypted_data
└── plaintext_key
```

### ❌ Assuming encryption provides integrity

Some encryption modes do not authenticate the ciphertext.

Prefer authenticated encryption such as:

```text
AES-GCM
ChaCha20-Poly1305
```

when appropriate.

---

# 17. Interview Questions

### Q1. What is symmetric encryption?

Encryption where the same secret key is used for encryption and decryption.

### Q2. Why is symmetric encryption fast?

It is computationally efficient and suitable for processing large amounts of data.

### Q3. Give examples.

```text
AES
ChaCha20
```

### Q4. What is AES-GCM?

An authenticated encryption mode using AES that provides confidentiality and integrity/authentication.

### Q5. What is a nonce?

A value used as additional input to cryptographic operations. In schemes such as GCM, nonce uniqueness with a given key is critical.

### Q6. Why is ECB insecure?

It can reveal patterns because identical plaintext blocks produce identical ciphertext blocks.

### Q7. What is the biggest practical challenge with symmetric encryption?

Secure key distribution and key management.

---

# 18. Quick Cheat Sheet

```text
Symmetric Encryption
→ Same secret key

AES
→ Common symmetric block cipher

AES-128 / 192 / 256
→ AES key sizes

AES
→ 128-bit block size

GCM
→ Authenticated encryption mode

AEAD
→ Encryption + authentication/integrity

Nonce
→ Additional cryptographic input
→ Must be used correctly; GCM nonce reuse is dangerous

ECB
→ Avoid for general secure encryption

Key Management
→ Protect, restrict, rotate, audit keys

HTTPS
→ Uses symmetric encryption for bulk traffic after TLS establishes keys

Modern Choices
→ AES-GCM
→ ChaCha20-Poly1305
```

## Core Mental Model

```text
                Symmetric Encryption
                        ↓
                  Secret Key
                        ↓
        ┌───────────────┴───────────────┐
        ↓                               ↓
     Encrypt                          Decrypt
        ↓                               ↓
    Plaintext → Ciphertext → Plaintext
                        ↓
                 Secure Key Management
```

**Next:** `03-Asymmetric-Encryption.md`