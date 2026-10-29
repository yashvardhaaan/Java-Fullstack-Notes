# `13-Cryptographic-Attacks.md`

# Cryptographic Attacks

## 1. First Principle

Cryptography is usually broken in practice **not by directly defeating the mathematics**, but by exploiting:

```text
Weak algorithms
+
Weak keys
+
Bad implementation
+
Poor key management
+
Incorrect configuration
+
Human mistakes
```

Mental model:

```text
Strong Algorithm
       ↓
Bad Implementation
       ↓
Still Vulnerable
```

---

# 2. Brute-Force Attack

An attacker tries many possible keys/passwords until one works.

Example:

```text
Password:
000000
000001
000002
...
```

Protection:

```text
Strong passwords
+
Rate limiting
+
MFA
+
Strong cryptographic keys
+
Password hashing
```

---

# 3. Dictionary Attack

Instead of trying every possible combination, attackers try common passwords.

Examples:

```text
password
admin
welcome
qwerty
companyname123
```

For password storage, use:

```text
Argon2id
bcrypt
scrypt
```

with unique salts.

---

# 4. Rainbow Table Attack

A rainbow table contains precomputed password-hash relationships.

Without salts:

```text
password
   ↓
hash
```

The same password produces the same hash.

With unique salts:

```text
password + salt A → hash A
password + salt B → hash B
```

This makes large precomputed tables much less useful.

---

# 5. Collision Attack

A collision occurs when two different inputs produce the same hash.

```text
Message A ──→ Hash X
Message B ──→ Hash X
```

For cryptographic security, collision resistance is important.

Historically problematic algorithms:

```text
MD5
SHA-1
```

Modern systems generally use:

```text
SHA-256
SHA-384
SHA-512
SHA-3
```

---

# 6. Birthday Attack

The birthday paradox explains why collisions can become more likely than intuition suggests.

For an ideal `n`-bit hash, collision searching has roughly:

```text
2^(n/2)
```

complexity.

Therefore:

```text
128-bit hash
→ roughly 2^64 collision work

256-bit hash
→ roughly 2^128 collision work
```

This is one reason modern cryptographic systems use sufficiently large hash outputs.

---

# 7. Man-in-the-Middle Attack

An attacker positions themselves between two communicating parties.

```text
Client
  ↓
Attacker
  ↓
Server
```

Without proper authentication, the attacker may attempt to intercept or modify communication.

TLS helps prevent this through:

```text
Certificates
+
Certificate validation
+
Authenticated key establishment
+
Integrity protection
```

---

# 8. Replay Attack

An attacker captures a legitimate message:

```text
Request + Valid Authentication
```

and sends it again later.

The cryptography may still be valid.

Example:

```text
Transfer ₹5000
```

captured and replayed.

Defenses include:

```text
Nonce
Timestamp
Sequence number
Request ID
Replay detection
```

---

# 9. Padding Oracle Attack

Some older or incorrectly implemented encryption systems reveal information through their responses to invalid ciphertext.

Conceptually:

```text
Attacker
   ↓
Modified ciphertext
   ↓
Server
   ↓
Different error/behavior
```

The attacker repeatedly observes these differences to extract information.

Historical example:

```text
CBC padding oracle attacks
```

Protection:

```text
Use modern authenticated encryption
+
Avoid distinguishable error behavior
+
Use well-tested cryptographic libraries
```

AES-GCM is commonly preferred over manually implemented CBC encryption.

---

# 10. Bleichenbacher Attack

A famous attack against vulnerable RSA implementations.

It targets RSA encryption with insecure PKCS#1 v1.5 handling and can exploit differences in how a server responds to invalid ciphertext.

Simplified:

```text
Ciphertext
    ↓
Server
    ↓
Different response
    ↓
Information leak
    ↓
Repeated queries
```

Modern systems should use appropriate RSA-OAEP for RSA encryption and avoid vulnerable legacy constructions.

---

# 11. Weak Random Number Generation

Cryptographic keys require unpredictable randomness.

Bad:

```python
import random
```

for security-sensitive key generation.

Use a cryptographically secure random generator provided by the operating system or cryptographic library.

Weak randomness can lead to:

```text
Predictable keys
+
Predictable tokens
+
Compromised encryption
```

---

# 12. Key-Reuse Problems

Keys should be used according to their intended cryptographic purpose.

A major example is AES-GCM nonce reuse:

```text
Same key
+
Same nonce
+
Multiple messages
```

This can seriously compromise security.

General rule:

```text
Follow the cryptographic library/protocol's
key and nonce lifecycle requirements.
```

---

# 13. Side-Channel Attacks

Sometimes attackers don't attack the mathematical algorithm directly.

They observe physical or implementation-related information:

```text
Timing
Power consumption
Cache behavior
Memory access
Electromagnetic leakage
```

Example:

```text
Secret-dependent operation
        ↓
Different execution timing
        ↓
Attacker observes timing
        ↓
Information about secret
```

Protection includes:

```text
Constant-time implementations
+
Hardened cryptographic libraries
+
Secure hardware
```

---

# 14. Timing Attack

A timing attack analyzes how long an operation takes.

For example:

```text
Input A → 10.1 ms
Input B → 10.8 ms
Input C → 11.4 ms
```

If timing depends on secret information, repeated measurements may reveal information.

This is why security-sensitive comparisons should use appropriate constant-time comparison functions.

For example:

```python
hmac.compare_digest(a, b)
```

---

# 15. Downgrade Attack

An attacker attempts to force a system to use a weaker protocol or algorithm.

Example:

```text
Strong TLS
     ↓
Attacker interferes
     ↓
Try weaker TLS version/cipher
```

Defenses:

```text
Disable obsolete protocols
+
Use secure cipher suites
+
Keep systems updated
```

For modern HTTPS, prefer TLS 1.2/1.3 according to organizational requirements, with TLS 1.3 generally preferred where supported.

---

# 16. Cryptographic Misconfiguration

Sometimes the algorithm is strong but configuration is weak.

Example:

```text
AES
```

sounds secure.

But:

```text
AES-ECB
```

is still a poor application choice.

Similarly:

```text
RSA
```

can be secure when properly configured, but vulnerable legacy padding or insufficient key protection can undermine it.

**Algorithm name alone does not prove security.**

---

# 17. Key-Management Attack

An attacker may not need to break encryption.

They can steal the key.

Example:

```text
Strong AES-256
       ↓
Key stored in GitHub
       ↓
Attacker obtains key
       ↓
Encryption compromised
```

Therefore:

```text
Cryptography
+
Key Management
```

must be treated together.

Use:

```text
KMS
HSM
Secret Manager
Access controls
Key rotation
Audit logs
```

where appropriate.

---

# 18. Industry-Level Example — Ransomware

Ransomware commonly uses cryptography legitimately designed for confidentiality but abuses it against victims.

Typical architecture may involve:

```text
Random symmetric key
        ↓
Encrypt files
        ↓
Asymmetric cryptography protects
the symmetric key
```

Why hybrid encryption?

```text
Symmetric encryption
→ Fast for thousands of files

Asymmetric encryption
→ Protects the encryption key
```

SOC indicators may include:

```text
Mass file modifications
+
Unusual process
+
New file extensions
+
Backup deletion
+
High disk activity
```

The cryptography itself is not the detection signal; the **behavior surrounding its use** is.

---

# 19. Industry-Level Example — Compromised TLS Private Key

Suppose a company's TLS private key is exposed.

Potential impact:

```text
Private key compromise
        ↓
Certificate/key trust affected
        ↓
Potential impersonation risk
```

Response:

```text
1. Determine exposure
2. Revoke/replace certificate where appropriate
3. Generate a new key pair
4. Deploy new certificate
5. Investigate access/logs
6. Remove exposed key
7. Review related credentials
```

---

# 20. Small Defensive Lab

Check a file hash:

### Linux

```bash
sha256sum message.txt
```

Modify the file:

```bash
echo "modified" >> message.txt
```

Calculate again:

```bash
sha256sum message.txt
```

The digest should change.

This demonstrates the **avalanche effect** and why hashes are useful for integrity checking.

---

# 21. Cryptographic Attack Cheat Sheet

| Attack | Main Target | Typical Defense |
|---|---|---|
| Brute force | Keys/passwords | Strong secrets, rate limits |
| Dictionary | Weak passwords | Strong password policy + KDF |
| Rainbow table | Unsalted hashes | Unique salts |
| Collision | Weak hashes | SHA-256/SHA-3 |
| MITM | Communication | TLS + authentication |
| Replay | Valid captured messages | Nonce/timestamp |
| Padding oracle | Bad encryption implementation | AEAD, secure libraries |
| Bleichenbacher | Vulnerable RSA padding | RSA-OAEP |
| Timing | Implementation | Constant-time code |
| Weak RNG | Key generation | CSPRNG |
| Downgrade | Protocol negotiation | Disable legacy protocols |
| Key theft | Key management | KMS/HSM/secrets management |

---

# 22. Interview Questions

### Q1. Can strong encryption still be hacked?

Yes. Attackers may target keys, implementation, configuration, randomness, or users instead of breaking the mathematical algorithm.

### Q2. Why are salts used?

To make password hashes unique and prevent attackers from efficiently reusing precomputed hash tables.

### Q3. What is a replay attack?

Reusing a previously captured valid message or request.

### Q4. What is a padding oracle?

A vulnerability where an application's response to invalidly padded ciphertext leaks information that can help an attacker recover plaintext or manipulate ciphertext.

### Q5. Why is AES-GCM preferred over manually implemented CBC encryption?

GCM provides authenticated encryption and avoids many common integrity-design mistakes.

### Q6. What is a side-channel attack?

An attack that extracts information from implementation behavior such as timing, cache activity, or power consumption.

### Q7. What is the biggest practical cryptography mistake?

Often **poor key management or incorrect implementation**, rather than choosing a fundamentally broken modern algorithm.

---

# 23. Quick Cheat Sheet

```text
Brute Force
→ Try many possibilities

Dictionary
→ Try likely passwords

Rainbow Table
→ Precomputed hashes

Collision
→ Two inputs → same hash

MITM
→ Intercept communication

Replay
→ Reuse captured valid request

Padding Oracle
→ Error/behavior leaks crypto information

Timing Attack
→ Execution time leaks information

Weak RNG
→ Predictable keys/tokens

Downgrade
→ Force weaker security

Key Theft
→ Steal the secret instead of breaking crypto
```

## Core Mental Model

```text
              CRYPTOGRAPHIC SECURITY
                       |
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
    Algorithm      Implementation   Key Management
        ↓              ↓              ↓
      AES            Bugs           Leaked key
      RSA          Oracles          Poor storage
      SHA          Timing           Weak access
        │              │              │
        └──────────────┴──────────────┘
                       ↓
                 Overall Security
```

**Cryptography section complete.**