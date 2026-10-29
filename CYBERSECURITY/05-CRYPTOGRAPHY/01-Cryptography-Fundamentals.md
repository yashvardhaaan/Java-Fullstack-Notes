Yes. I’ll follow **exactly this sequence**, one `.md` file at a time.

```text
05-CRYPTOGRAPHY
│
├── 01-Cryptography-Fundamentals.md
├── 02-Symmetric-Encryption.md
├── 03-Asymmetric-Encryption.md
├── 04-Hashing.md
├── 05-Salt-Pepper.md
├── 06-Digital-Signatures.md
├── 07-PKI.md
├── 08-Certificates.md
├── 09-TLS-Handshake.md
├── 10-RSA.md
├── 11-AES.md
├── 12-HMAC.md
└── 13-Cryptographic-Attacks.md
```

### Format I'll use for every file

1. **First Principle**
2. **Core concept**
3. **How it works**
4. **Important algorithms/terms**
5. **Industry-level practical example**
6. **Cybersecurity/SOC relevance**
7. **Small hands-on lab**
8. **Interview questions**
9. **Quick cheat sheet**

I'll keep it **concise but technically solid**—no unnecessary 500-line notes. The practical examples will be based on things you'll actually encounter in **web applications, APIs, authentication, cloud, SOC, and enterprise security**.

---

# `01-Cryptography-Fundamentals.md`

# Cryptography Fundamentals

## 1. First Principle

Cryptography is the science of protecting information using mathematical techniques.

The basic model is:

```text
Plaintext
   ↓
Encryption Algorithm + Key
   ↓
Ciphertext
   ↓
Decryption Algorithm + Key
   ↓
Plaintext
```

Example:

```text
"Transfer ₹10,000"
        ↓
   Encryption
        ↓
"8F2A91C..."
        ↓
   Decryption
        ↓
"Transfer ₹10,000"
```

The goal is not simply to "hide data."

Cryptography provides several security properties.

---

# 2. Four Major Security Goals

## Confidentiality

Only authorized parties can read the data.

```text
User A ── encrypted data ──→ User B
             ↓
          Attacker
             ↓
        Cannot read it
```

Example:

- HTTPS
- Encrypted database fields
- VPN traffic

---

## Integrity

Detect whether data was modified.

```text
Original:
"Pay ₹1000"

Modified:
"Pay ₹9000"

       ↓

Integrity check
       ↓
Modification detected
```

Common mechanisms:

- Hashes
- HMAC
- Digital signatures

---

## Authentication

Verify who a party is.

Example:

```text
Client
  ↓
Prove identity
  ↓
Server verifies
  ↓
Authenticated
```

Examples:

- Certificates
- Digital signatures
- Authentication protocols

---

## Non-Repudiation

Provides evidence that a particular party authorized/signed data, depending on the system and legal/technical context.

Digital signatures are commonly used for this purpose.

---

# 3. Encryption

Encryption transforms readable data into unreadable ciphertext.

```text
Plaintext
   ↓
Encryption
   ↓
Ciphertext
```

Decryption reverses the process.

```text
Ciphertext
   ↓
Decryption
   ↓
Plaintext
```

A **key** controls the cryptographic operation.

---

# 4. Key

A key is cryptographic secret material used by an algorithm.

Example concept:

```text
Plaintext + Key
      ↓
   Algorithm
      ↓
  Ciphertext
```

Security should primarily depend on protecting the key—not hiding the algorithm.

This is an important principle known as **Kerckhoffs's principle**:

> A cryptosystem should remain secure even when the algorithm is publicly known; the key must remain secret.

---

# 5. Symmetric vs Asymmetric Cryptography

Two major categories:

```text
Cryptography
│
├── Symmetric
│   └── Same secret key
│
└── Asymmetric
    └── Public + private key
```

### Symmetric

```text
Encrypt ── Same Key ── Decrypt
```

Examples:

- AES
- ChaCha20

Fast and suitable for large amounts of data.

### Asymmetric

```text
Public Key
    ↓
Encryption / Verification

Private Key
    ↓
Decryption / Signing
```

Examples:

- RSA
- ECC

Generally slower and commonly used for key exchange, authentication, and digital signatures rather than bulk data encryption.

---

# 6. Hashing Is Different

A cryptographic hash is **not encryption**.

```text
Input
  ↓
Hash Function
  ↓
Fixed-size Hash
```

Example:

```text
"hello"
   ↓
SHA-256
   ↓
2cf24dba...
```

You normally don't decrypt a hash.

Hashes are useful for:

- Integrity checking
- Password verification systems
- File identification
- Digital signatures
- Security investigations

---

# 7. Encoding Is Not Encryption

This is a common beginner mistake.

### Encoding

Designed for data representation/transport.

Example:

```text
Hello
 ↓
Base64
 ↓
SGVsbG8=
```

Anyone can decode it.

### Encryption

Designed to provide confidentiality.

```text
Plaintext
 ↓
Encryption + Secret Key
 ↓
Ciphertext
```

Without the required key, recovering the plaintext should be computationally difficult.

---

# 8. Industry Example — HTTPS

When you visit:

```text
https://bank.example
```

multiple cryptographic mechanisms work together.

Simplified:

```text
Browser
   ↓
TLS
   ↓
Certificate authentication
   ↓
Key establishment
   ↓
Symmetric session encryption
   ↓
Encrypted application traffic
```

For modern TLS, asymmetric/public-key cryptography is primarily used for authentication and establishing cryptographic secrets, while symmetric cryptography protects the bulk application data because it is much faster.

---

# 9. Industry Example — Password Storage

A secure application should **not** normally store:

```text
username: yash
password: MyPassword123
```

as plaintext.

Instead, password-specific password hashing algorithms such as:

- Argon2id
- bcrypt
- scrypt

are used with appropriate parameters.

Conceptually:

```text
Password
   ↓
Password Hashing
   ↓
Stored Password Verifier
```

When logging in:

```text
Entered Password
       ↓
Same verification process
       ↓
Compare with stored verifier
       ↓
Login allowed / denied
```

Do not confuse password hashing with general-purpose hashes such as SHA-256.

---

# 10. Industry Example — API Security

Suppose a payment API sends:

```json
{
  "amount": 5000,
  "orderId": "ORD123"
}
```

HTTPS protects the communication channel.

For certain API designs, additional mechanisms such as HMAC or digital signatures may authenticate requests or protect their integrity.

The architecture could be:

```text
Client
   ↓
HTTPS/TLS
   ↓
API Gateway
   ↓
Application
   ↓
Database
```

Different cryptographic mechanisms can protect different parts of this architecture.

---

# 11. Cybersecurity Scenario

### Situation

A SOC analyst finds:

```text
File:
invoice.exe

SHA-256:
A1B2C3...
```

The analyst can calculate the file's hash and compare it with:

- Threat intelligence
- Malware databases
- Known-good software inventories

Important:

> A hash identifies/represents the exact input for that hash function; it does not prove that a file is safe by itself.

---

# 12. Small Hands-On Lab

### Calculate a SHA-256 hash in Windows

PowerShell:

```powershell
Get-FileHash .\test.txt -Algorithm SHA256
```

This calculates the SHA-256 digest of `test.txt`.

---

### Linux

```bash
sha256sum test.txt
```

You can modify the file and run the command again.

You'll observe:

```text
Original file
    ↓
Hash A

Modify one character
    ↓
Hash B
```

The resulting digest changes substantially.

This demonstrates the **avalanche effect**.

---

# 13. Important Properties of Cryptographic Hashes

A secure cryptographic hash should provide properties such as:

### Preimage resistance

Given:

```text
Hash → ?
```

It should be computationally difficult to find the original input.

### Collision resistance

It should be difficult to find:

```text
Input A ≠ Input B

but:

Hash(A) = Hash(B)
```

### Avalanche effect

Small input changes should produce substantially different outputs.

---

# 14. Cryptography in a Real Application

A modern web application may use several cryptographic mechanisms simultaneously:

```text
User Login
    ↓
Password Hashing
    ↓
Authentication

HTTPS
    ↓
TLS
    ↓
Encrypted communication

JWT / Session
    ↓
Authentication state

Database
    ↓
Encryption where required

API Request
    ↓
HMAC / Signature where required
```

There is **no single cryptographic algorithm that solves every security problem**.

---

# 15. Common Mistakes

### ❌ Using Base64 as encryption

```text
Base64 ≠ Encryption
```

### ❌ Storing plaintext passwords

Use an appropriate password hashing scheme.

### ❌ Creating your own encryption algorithm

Use well-reviewed standard cryptographic algorithms.

### ❌ Hardcoding encryption keys

Bad:

```java
String key = "MySecret123";
```

Prefer secure secret/key management.

### ❌ Using outdated algorithms

Avoid obsolete algorithms such as:

```text
MD5
SHA-1
DES
RC4
```

for new security designs where stronger modern alternatives are appropriate.

---

# 16. Interview Questions

### Q1. What is cryptography?

The use of mathematical techniques to protect information and provide properties such as confidentiality, integrity, authentication, and related security guarantees.

### Q2. Encryption vs hashing?

```text
Encryption
→ Reversible with appropriate key

Hashing
→ One-way cryptographic transformation
```

### Q3. Symmetric vs asymmetric?

```text
Symmetric
→ Same secret key
→ Fast

Asymmetric
→ Public/private key pair
→ Slower
→ Authentication/key establishment/signatures
```

### Q4. Is Base64 encryption?

No. Base64 is an encoding mechanism.

### Q5. Why shouldn't passwords simply be SHA-256 hashed?

General-purpose hashes are designed to be fast. Password hashing should deliberately be expensive and use algorithms such as Argon2id, bcrypt, or scrypt with appropriate parameters.

### Q6. What is a cryptographic key?

Secret or private cryptographic material that controls an encryption, decryption, signing, or related cryptographic operation.

---

# 17. Quick Cheat Sheet

```text
Cryptography
→ Protect information using mathematical techniques

Confidentiality
→ Prevent unauthorized reading

Integrity
→ Detect unauthorized modification

Authentication
→ Verify identity

Non-repudiation
→ Evidence associated with signing/authorization

Encryption
→ Plaintext ↔ Ciphertext using keys

Symmetric
→ Same secret key

Asymmetric
→ Public + private key

Hash
→ One-way digest

Encoding
→ Representation/transport, not security

AES
→ Symmetric encryption

RSA
→ Asymmetric cryptography

SHA-256
→ Cryptographic hash

HMAC
→ Keyed integrity/authentication mechanism

TLS
→ Protects network communication
```

## Core Mental Model

```text
                  CRYPTOGRAPHY
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
    Encryption       Hashing       Signatures
        ↓              ↓              ↓
 Confidentiality   Integrity      Authentication
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                Secure Systems
```

**Next:** `02-Symmetric-Encryption.md`