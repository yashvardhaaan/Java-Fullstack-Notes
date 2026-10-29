# `04-Hashing.md`

# Hashing — Cryptography Notes

## 1. First Principle

A **cryptographic hash function** converts input data of any size into a fixed-size output called a **hash/digest**.

```text
Any Data
   ↓
Hash Function
   ↓
Fixed-Length Digest
```

Example:

```text
"Hello"
   ↓
SHA-256
   ↓
185f8db32271fe25...
```

The important property is:

> **The same input should produce the same hash, but finding the original input from a secure hash should be computationally difficult.**

---

# 2. Hashing ≠ Encryption

This is one of the most important concepts.

### Encryption

```text
Plaintext
   ↓
Encryption + Key
   ↓
Ciphertext
   ↓
Decryption + Key
   ↓
Plaintext
```

### Hashing

```text
Input
  ↓
Hash Function
  ↓
Digest
```

There is normally **no decryption operation** for a cryptographic hash.

---

# 3. Important Properties

## Deterministic

Same input:

```text
SHA256("hello")
```

always produces the same digest.

---

## One-Way / Preimage Resistant

Given:

```text
Hash → ?
```

it should be computationally difficult to recover the original input.

---

## Avalanche Effect

Changing even one character should produce a substantially different digest.

```text
hello
 ↓
Hash A

Hello
 ↓
Hash B
```

Hash A and Hash B should look completely different.

---

## Collision Resistance

A collision occurs when:

```text
Input A ≠ Input B

but

Hash(A) = Hash(B)
```

A secure cryptographic hash should make finding such collisions computationally difficult.

---

# 4. Common Hash Algorithms

| Algorithm | Security Status |
|---|---|
| MD5 | ❌ Broken for cryptographic security |
| SHA-1 | ❌ Collision-broken |
| SHA-256 | ✅ Widely used |
| SHA-384 | ✅ Widely used |
| SHA-512 | ✅ Widely used |
| SHA-3 | ✅ Modern alternative |

For new security-sensitive designs, use an appropriate modern algorithm rather than MD5 or SHA-1.

---

# 5. SHA-256

**SHA-256** belongs to the SHA-2 family.

It produces:

```text
256-bit digest
```

or:

```text
32 bytes
```

or:

```text
64 hexadecimal characters
```

Example:

```text
Input:
Hello

SHA-256:
185f8db32271fe25f561a6fc938b2e264306ec304eda518007d1764826381969
```

---

# 6. Industry Example — File Integrity

Suppose a company distributes:

```text
software.exe
```

The vendor publishes its SHA-256 hash.

You download the file and calculate:

```powershell
Get-FileHash .\software.exe -Algorithm SHA256
```

Then compare:

```text
Vendor Hash
     ↓
Your Hash
     ↓
Match?
```

If they match, the file's content matches the published digest.

Important:

> A matching hash alone does not prove that the vendor/source is trustworthy. You must trust the source of the expected hash.

---

# 7. Cybersecurity Example — Malware Investigation

A SOC analyst receives:

```text
suspicious.exe
```

They calculate:

```powershell
Get-FileHash .\suspicious.exe -Algorithm SHA256
```

Suppose the result is:

```text
A8F91C...
```

The analyst can search the hash in approved threat-intelligence systems.

Conceptually:

```text
Suspicious File
      ↓
SHA-256
      ↓
File Hash
      ↓
Threat Intelligence
      ↓
Known malicious?
```

A hash is useful as an **indicator of compromise (IOC)**.

---

# 8. Hashing Passwords

Passwords should not normally be stored as plaintext.

Bad:

```text
username: yash
password: MyPassword123
```

Better:

```text
Password
   ↓
Password Hashing Algorithm
   ↓
Password Verifier
```

However, don't simply use:

```text
SHA-256(password)
```

for password storage.

Why?

Because SHA-256 is extremely fast.

Attackers can test huge numbers of password guesses quickly.

Instead use password-specific algorithms such as:

```text
Argon2id
bcrypt
scrypt
```

These are deliberately designed to make password guessing more expensive.

---

# 9. Password Verification

Suppose the database contains a password verifier.

During login:

```text
User enters password
        ↓
Password hashing function
        ↓
Calculated verifier
        ↓
Compare with stored verifier
        ↓
Match → Login allowed
```

The application doesn't need to store the original plaintext password.

---

# 10. Salt

A **salt** is a unique random value associated with a password before password hashing.

Conceptually:

```text
Password + Unique Salt
          ↓
Password Hashing
          ↓
Stored Verifier
```

Example:

```text
User A
Password: hello123
Salt: X7K2...
       ↓
Hash

User B
Password: hello123
Salt: P9Q4...
       ↓
Different hash
```

Salts are covered in detail in:

**`05-Salt-Pepper.md`**

---

# 11. Hashing vs HMAC

These are different.

### Hash

```text
Data
 ↓
SHA-256
 ↓
Digest
```

Anyone who has the data can calculate the same hash.

### HMAC

```text
Data + Secret Key
       ↓
      HMAC
       ↓
Authentication Tag
```

Only someone with the secret key can generate a valid HMAC.

This makes HMAC useful for message authentication.

---

# 12. Industry Example — API Integrity

Imagine an internal API sends:

```json
{
  "userId": 101,
  "amount": 5000
}
```

A plain SHA-256 hash doesn't prove who created the message because anyone can calculate it.

An HMAC can provide:

```text
Message + Shared Secret
        ↓
       HMAC
        ↓
Server verifies
```

We'll cover HMAC in:

**`12-HMAC.md`**

---

# 13. Small Hands-On Lab — Windows

Create a file:

```powershell
"Cybersecurity Lab" | Out-File test.txt
```

Calculate SHA-256:

```powershell
Get-FileHash .\test.txt -Algorithm SHA256
```

Modify the file:

```powershell
"Cybersecurity Lab!" | Out-File test.txt
```

Calculate again:

```powershell
Get-FileHash .\test.txt -Algorithm SHA256
```

You'll see a substantially different digest.

---

# 14. Linux Lab

```bash
echo "Cybersecurity Lab" > test.txt
```

Calculate:

```bash
sha256sum test.txt
```

Modify:

```bash
echo "Cybersecurity Lab!" > test.txt
```

Calculate again:

```bash
sha256sum test.txt
```

This demonstrates the avalanche effect.

---

# 15. Industry Scenario — Software Supply Chain

Imagine your company downloads:

```text
application.zip
```

from a vendor.

The vendor publishes:

```text
SHA-256:
ABC123...
```

Your security process calculates:

```text
Downloaded File
      ↓
SHA-256
      ↓
ABC123...
      ↓
Compare with trusted vendor value
```

If different:

```text
Hash mismatch
     ↓
Do NOT deploy immediately
     ↓
Investigate source/integrity
```

Possible reasons include:

- Corrupted download
- Different software version
- Incorrect expected hash
- Tampering

---

# 16. Hashes in Digital Signatures

Digital signatures typically don't sign huge files directly.

Instead:

```text
Large File
   ↓
Hash
   ↓
Digest
   ↓
Digital Signature
```

Verification:

```text
File
 ↓
Hash
 ↓
Compare with signed digest
```

This makes signatures efficient for large data.

---

# 17. Common Mistakes

### ❌ MD5 for security

MD5 has practical collision weaknesses.

### ❌ SHA-1 for new security designs

SHA-1 collision attacks make it unsuitable for modern cryptographic security.

### ❌ SHA-256 directly for passwords

It's too fast for password storage.

Use:

```text
Argon2id
bcrypt
scrypt
```

### ❌ Thinking a hash is encryption

```text
Hash ≠ Encryption
```

### ❌ Thinking a matching hash proves authenticity

A hash verifies content against a trusted expected digest; it doesn't establish trust in the expected digest itself.

---

# 18. SOC / Cybersecurity Relevance

Hashes are everywhere in security operations:

```text
Malware Identification
        ↓
File Hash

Threat Intelligence
        ↓
Hash IOC

Digital Forensics
        ↓
Evidence Integrity

Software Security
        ↓
Package Verification

Incident Response
        ↓
File Comparison
```

Common IOC format:

```text
SHA-256:
9f86d081884c7d65...
```

---

# 19. Interview Questions

### Q1. What is hashing?

A one-way cryptographic transformation that produces a fixed-size digest from input data.

### Q2. Is hashing reversible?

A secure cryptographic hash is designed to be computationally infeasible to reverse.

### Q3. What is SHA-256?

A SHA-2 cryptographic hash function producing a 256-bit digest.

### Q4. Why is MD5 insecure?

It has practical collision weaknesses.

### Q5. Why shouldn't SHA-256 be used directly for passwords?

It is too fast, making large-scale password guessing more efficient.

### Q6. What should be used for password hashing?

Appropriate password hashing algorithms such as:

```text
Argon2id
bcrypt
scrypt
```

### Q7. What is a collision?

Two different inputs producing the same hash.

### Q8. How are hashes used in SOC?

They are commonly used as file identifiers and indicators of compromise.

---

# 20. Quick Cheat Sheet

```text
Hash
→ Fixed-size digest

SHA-256
→ 256-bit hash

Hash ≠ Encryption
→ Normally no decryption

Avalanche Effect
→ Small input change → major digest change

Collision
→ Different inputs → same digest

MD5
→ Broken for cryptographic security

SHA-1
→ Collision-broken / avoid for new security designs

Password Hashing
→ Argon2id / bcrypt / scrypt

File Investigation
→ Get-FileHash

Linux
→ sha256sum

IOC
→ Hash can identify known malicious files

HMAC
→ Hash + Secret Key
```

## Core Mental Model

```text
                    HASHING
                       ↓
                 Input Data
                       ↓
                 Hash Function
                       ↓
                  Fixed Digest
                       ↓
       ┌───────────────┼───────────────┐
       ↓               ↓               ↓
    Integrity        File IOC       Signatures
       ↓               ↓               ↓
   Verification   Malware Search   Authentication
```

**Next:** `05-Salt-Pepper.md`