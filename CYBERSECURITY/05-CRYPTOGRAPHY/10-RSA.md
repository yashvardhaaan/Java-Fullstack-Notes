# `10-RSA.md`

# RSA — Cryptography Notes

## 1. First Principle

**RSA** is an asymmetric cryptographic algorithm based on a public/private key pair.

Mental model:

```text
Public Key
    ↓
Anyone can use it

Private Key
    ↓
Only owner should control it
```

RSA can be used for:

- Encryption
- Digital signatures
- Authentication
- Key transport in older TLS configurations

---

# 2. RSA Key Pair

An RSA key pair contains:

```text
Public Key
+
Private Key
```

The public key can be distributed.

The private key must remain secret.

```text
              RSA Key Pair
             /            \
       Public Key       Private Key
          ↓                 ↓
     Share freely       Protect carefully
```

---

# 3. RSA for Encryption

Suppose Alice wants to send Bob a secret.

Bob gives Alice his **public key**.

```text
Alice
  ↓
Bob's Public Key
  ↓
Encrypted Data
  ↓
Internet
  ↓
Bob's Private Key
  ↓
Plaintext
```

Only Bob's private key should be able to recover the protected message.

---

# 4. RSA for Digital Signatures

RSA can also work in the opposite conceptual direction.

```text
Message
   ↓
Hash
   ↓
Private Key
   ↓
Digital Signature
```

Anyone with the corresponding public key can verify the signature.

```text
Signature
    ↓
Public Key
    ↓
Valid / Invalid
```

This provides:

```text
Integrity
+
Authentication of the signer
```

when the public key is properly associated with the claimed identity.

---

# 5. How RSA Works — Simplified

RSA relies on mathematical properties involving very large prime numbers.

During key generation:

```text
Choose large primes
      ↓
Generate RSA parameters
      ↓
Create public key
      +
Create private key
```

The security relies on the difficulty of certain mathematical problems, especially factoring a sufficiently large RSA modulus.

You don't need to manually perform these calculations in practical cybersecurity work.

Libraries perform them safely.

---

# 6. RSA Key Components

An RSA public key is conceptually based on:

```text
(n, e)
```

An RSA private key contains additional secret mathematical parameters, including:

```text
d
```

Where:

- `n` = RSA modulus
- `e` = public exponent
- `d` = private exponent

Common public exponent:

```text
65537
```

---

# 7. RSA Key Size

Common RSA key sizes include:

```text
2048 bits
3072 bits
4096 bits
```

For modern systems:

```text
RSA-2048
```

is still widely encountered.

Larger keys generally increase computational cost.

ECC-based algorithms can provide comparable security with much smaller keys, which is one reason modern systems often prefer elliptic-curve cryptography where appropriate.

---

# 8. RSA Padding Is Extremely Important

Never implement raw RSA encryption yourself.

Modern RSA encryption should use a secure padding scheme such as:

```text
RSA-OAEP
```

For signatures, modern applications should generally use:

```text
RSA-PSS
```

Avoid:

```text
"Textbook RSA"
```

because raw RSA does not provide the security properties required by real applications.

### Important distinction

```text
RSA-OAEP
→ Encryption

RSA-PSS
→ Digital Signature
```

---

# 9. RSA vs AES

| RSA | AES |
|---|---|
| Asymmetric | Symmetric |
| Public/private keys | Shared secret key |
| Computationally expensive | Very fast |
| Authentication/key establishment use cases | Bulk data encryption |
| Larger keys | 128/192/256-bit keys |

Therefore, applications normally don't encrypt gigabytes of data directly with RSA.

Instead:

```text
RSA / ECDH
     ↓
Establish or protect symmetric key
     ↓
AES
     ↓
Encrypt actual data
```

---

# 10. Industry-Level Example — Encrypting an API Secret

Imagine a cloud service needs to send a small secret to another service.

The receiving service has:

```text
Private Key → stored securely
Public Key  → distributed
```

The sender can use the public key with an appropriate RSA encryption scheme such as OAEP.

The receiver uses the private key to recover the secret.

In production:

```text
Private Key
     ↓
KMS / HSM / Secret Management
```

rather than:

```text
private_key.pem
```

sitting casually inside a Git repository.

---

# 11. SOC Scenario — Exposed RSA Private Key

Suppose an analyst discovers:

```text
id="server-private-key.pem"
```

inside a public Git repository.

Treat this as a potentially serious security incident.

Possible response:

```text
1. Revoke/replace affected credentials or certificates
2. Generate a new key pair
3. Remove exposed key from active systems
4. Check Git history and exposure scope
5. Review authentication/access logs
6. Determine whether the key was used
7. Rotate dependent secrets if necessary
```

Deleting the file from the latest commit alone does **not** necessarily remove it from Git history.

---

# 12. RSA in TLS

Historically, TLS could use RSA for key transport.

Modern TLS 1.3 removed RSA key transport.

Modern TLS commonly uses:

```text
ECDHE
   ↓
Shared Secret
   ↓
Symmetric Session Keys
```

The server's RSA certificate key may still be used for **authentication/signatures**, but it is not used to encrypt all HTTPS traffic.

This distinction is important in interviews.

---

# 13. Generate an RSA Key Pair with OpenSSL

Generate a private key:

```bash
openssl genpkey -algorithm RSA \
  -pkeyopt rsa_keygen_bits:2048 \
  -out private.pem
```

Meaning:

```text
genpkey
→ Generate a private key

-algorithm RSA
→ Use RSA

rsa_keygen_bits:2048
→ 2048-bit RSA key

-out private.pem
→ Save private key
```

Extract the public key:

```bash
openssl pkey -in private.pem -pubout -out public.pem
```

You now have:

```text
private.pem
public.pem
```

---

# 14. Inspect the Key

```bash
openssl pkey -in private.pem -text -noout
```

For the public key:

```bash
openssl pkey -pubin -in public.pem -text -noout
```

**Never share a real production private key while doing experiments.**

---

# 15. Small RSA Encryption Lab

Create a small test file:

```bash
echo "Hello RSA" > message.txt
```

Encrypt using RSA-OAEP:

```bash
openssl pkeyutl \
  -encrypt \
  -pubin \
  -inkey public.pem \
  -in message.txt \
  -out encrypted.bin \
  -pkeyopt rsa_padding_mode:oaep
```

Decrypt:

```bash
openssl pkeyutl \
  -decrypt \
  -inkey private.pem \
  -in encrypted.bin \
  -out decrypted.txt \
  -pkeyopt rsa_padding_mode:oaep
```

Check:

```bash
cat decrypted.txt
```

You should get:

```text
Hello RSA
```

### Important

RSA is intended for relatively small data or key-wrapping use cases.

For large files, use **hybrid encryption**:

```text
Random AES Key
      ↓
AES encrypts large file
      ↓
RSA protects AES Key
```

---

# 16. RSA Digital Signature Lab

Create a hash/signature:

```bash
openssl dgst -sha256 \
  -sign private.pem \
  -out signature.bin \
  message.txt
```

Verify:

```bash
openssl dgst -sha256 \
  -verify public.pem \
  -signature signature.bin \
  message.txt
```

Expected result:

```text
Verified OK
```

If the file changes:

```text
message.txt
   ↓
Modified
   ↓
Signature verification
   ↓
Failure
```

---

# 17. Common RSA Mistakes

### ❌ Using small keys

Prefer modern security recommendations.

### ❌ Raw RSA

Don't use textbook RSA.

### ❌ Wrong padding

Use appropriate modern padding such as:

```text
OAEP → encryption
PSS  → signatures
```

### ❌ Encrypting huge files directly

Use hybrid encryption.

### ❌ Storing private keys in Git

Use secure key-management systems.

### ❌ Sharing private keys

A private key is a secret credential.

---

# 18. Cybersecurity / SOC Relevance

RSA appears in:

```text
TLS certificates
SSH
Digital signatures
Code signing
PKI
Enterprise authentication
Secure key exchange/wrapping
```

During investigations, analysts may encounter:

```text
RSA certificate
RSA public key
RSA signature
Private-key exposure
Certificate changes
Weak/legacy RSA configuration
```

---

# 19. Interview Questions

### Q1. What is RSA?

An asymmetric cryptographic algorithm using a public/private key pair.

### Q2. Can RSA encrypt large files efficiently?

No. RSA is computationally expensive and designed for relatively small data/key protection. Hybrid encryption is preferred.

### Q3. What is RSA-OAEP?

A modern padding scheme used with RSA encryption.

### Q4. What is RSA-PSS?

A modern padding scheme used for RSA digital signatures.

### Q5. Why is the private key important?

Anyone possessing it may be able to impersonate the key owner or decrypt protected material, depending on its use.

### Q6. Is RSA used to encrypt all HTTPS traffic?

No. HTTPS uses symmetric session encryption for application data. Modern TLS commonly uses ECDHE for key establishment.

### Q7. What happens if an RSA private key is leaked?

Treat it as a credential compromise: determine scope, rotate/revoke affected credentials or certificates, and investigate potential use.

---

# 20. Quick Cheat Sheet

```text
RSA
→ Asymmetric cryptography

Public Key
→ Can be distributed

Private Key
→ Must remain secret

RSA-OAEP
→ RSA encryption padding

RSA-PSS
→ RSA signature padding

RSA-2048
→ Commonly encountered key size

AES
→ Fast bulk encryption

Hybrid Encryption
→ RSA protects AES key
→ AES protects actual data

TLS 1.3
→ Does not use RSA key transport

Private Key Exposure
→ Rotate/revoke + investigate
```

## Core Mental Model

```text
             RSA
          /       \
     Public       Private
       Key          Key
        ↓            ↓
   Encryption     Signing
        ↓            ↓
   OAEP            PSS
```

**Next:** `11-AES.md`