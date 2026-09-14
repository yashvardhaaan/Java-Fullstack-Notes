````md
# Cryptography Basics

## 1. What is Cryptography?

Cryptography = techniques used to protect information from unauthorized access or modification.

### 🔑 CIA Goals

| Goal | Meaning | Example |
|---|---|---|
| Confidentiality | Only authorized people can read data | Encryption |
| Integrity | Data is not altered | Hash / MAC |
| Authentication | Verify identity | Digital signature / certificates |
| Non-repudiation | Sender cannot easily deny an action | Digital signature |

> **Encryption hides data; hashing verifies data integrity; signatures provide authentication + integrity + non-repudiation.**

---

## 2. Plaintext vs Ciphertext

**Plaintext** → original readable data

**Encryption** → converts plaintext into ciphertext

**Decryption** → converts ciphertext back into plaintext

```text
Plaintext
   ↓ Encryption + Key
Ciphertext
   ↓ Decryption + Key
Plaintext
````

---

# 3. Symmetric Encryption ⭐⭐⭐⭐⭐

Same secret key is used for encryption and decryption.

```text
        Same Key
          ↓
Plaintext → Encryption → Ciphertext
Ciphertext → Decryption → Plaintext
```

### Examples

* AES ⭐
* DES
* 3DES

### Advantages

* Very fast
* Suitable for large amounts of data

### Problem

**How do sender and receiver securely share the secret key?**

---

# 4. Asymmetric Encryption ⭐⭐⭐⭐⭐

Uses a **key pair**:

* Public key → can be shared
* Private key → kept secret

Examples:

* RSA
* ECC
* Diffie-Hellman → key agreement, not ordinary encryption

### Basic idea

```text
Public Key  → encrypt
Private Key → decrypt
```

This is useful when confidentiality is required.

### Important

If **A encrypts using B's public key**:

```text
A → Encrypt with B's Public Key
      ↓
   Ciphertext
      ↓
B → Decrypt with B's Private Key
```

Only B's private key can decrypt it.

---

# 5. Symmetric vs Asymmetric

| Feature          | Symmetric    | Asymmetric          |
| ---------------- | ------------ | ------------------- |
| Keys             | 1 shared key | Public + private    |
| Speed            | Fast         | Slower              |
| Large data       | Excellent    | Usually inefficient |
| Key distribution | Difficult    | Easier              |
| Examples         | AES          | RSA, ECC            |

🔥 **Real systems often use both.**

Example TLS:

```text
Asymmetric cryptography
        ↓
Establish/authenticate keys
        ↓
Symmetric cryptography
        ↓
Encrypt bulk data
```

---

# 6. Hashing ⭐⭐⭐⭐⭐

Hash function converts arbitrary-size input into a fixed-size output.

```text
Input → Hash Function → Hash/Digest
```

Example:

```text
"Hello" → SHA-256 → 256-bit digest
```

### Properties

* One-way in practical design
* Fixed-size output
* Small input change → significantly different hash
* Collision resistance is important

Examples:

* SHA-256 ✅
* SHA-3 ✅
* MD5 ❌ for security
* SHA-1 ❌ for collision-resistant security

### Hash ≠ Encryption

| Hashing                         | Encryption          |
| ------------------------------- | ------------------- |
| One-way                         | Reversible with key |
| No decryption                   | Can decrypt         |
| Integrity/password applications | Confidentiality     |

---

# 7. MAC — Message Authentication Code ⭐⭐⭐⭐

MAC provides:

**Integrity + Authentication**

It uses a **shared secret key**.

```text
Message + Secret Key
        ↓
       MAC
```

Receiver uses the same secret key to verify it.

Example:

* HMAC-SHA256

### MAC vs Hash

**Hash:**

```text
Message → Hash
```

**MAC:**

```text
Message + Secret Key → MAC
```

Therefore, a plain hash alone does **not** authenticate the sender.

---

# 8. Digital Signature ⭐⭐⭐⭐⭐

Digital signature provides:

* Authentication
* Integrity
* Non-repudiation

Conceptually:

```text
Message
   ↓ Hash
Digest
   ↓ Sign with Private Key
Digital Signature
```

Receiver:

```text
Signature
   ↓ Verify with Public Key
Valid / Invalid
```

### Key rule

**Signing → Private Key**

**Verification → Public Key**

🔥 Very important GATE trap.

---

# 9. Digital Signature vs Encryption

| Purpose          | Key used                 |
| ---------------- | ------------------------ |
| Encrypt for B    | B's **Public Key**       |
| Decrypt          | B's **Private Key**      |
| Sign             | Sender's **Private Key** |
| Verify signature | Sender's **Public Key**  |

> **Public key → confidentiality for its owner**
> **Private key → signature by its owner**

---

# 10. Diffie-Hellman ⭐⭐⭐⭐

Used for **secure key agreement**.

It allows two parties to establish a shared secret over an insecure channel.

```text
Alice                    Bob
  │                        │
  │──── public values ────│
  │                        │
  │  exchange information  │
  │                        │
  └──── Shared Secret ─────┘
```

### Important

Diffie-Hellman itself does **not authenticate** the parties.

Therefore, basic DH is vulnerable to:

**Man-in-the-Middle (MITM)** attack.

Authentication mechanisms such as certificates/signatures can solve this.

---

# 11. Common Attacks

| Attack            | Idea                                    |
| ----------------- | --------------------------------------- |
| Brute force       | Try many keys/passwords                 |
| MITM              | Attacker intercepts communication       |
| Replay            | Reuse previously captured valid message |
| Dictionary attack | Try common passwords                    |
| Phishing          | Trick user into revealing information   |
| DoS               | Make service unavailable                |

---

# 🔥 GATE Traps

1. **AES = symmetric encryption**
2. **RSA/ECC = asymmetric cryptography**
3. **Diffie-Hellman = key agreement**
4. **Hash ≠ encryption**
5. **Hash alone does not authenticate**
6. **MAC = integrity + authentication**
7. **Digital signature = authentication + integrity + non-repudiation**
8. **Signing uses private key**
9. **Signature verification uses public key**
10. **Encryption for B uses B's public key**
11. **Decryption by B uses B's private key**
12. Basic Diffie-Hellman does **not** provide authentication.
13. Symmetric encryption is much faster for bulk data.

---

# ⚡ 30-Second Revision

```text
AES
 ↓
Symmetric → same secret key → FAST

RSA / ECC
 ↓
Asymmetric → public + private key

Hash
 ↓
Integrity

MAC
 ↓
Integrity + Authentication

Digital Signature
 ↓
Authentication + Integrity + Non-repudiation

Diffie-Hellman
 ↓
Key Agreement
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
