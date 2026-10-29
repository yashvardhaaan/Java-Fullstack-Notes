# `06-Digital-Signatures.md`

# Digital Signatures — Cryptography Notes

## 1. First Principle

A **digital signature** proves that data was signed using a particular **private key** and that the signed data has not been modified.

Mental model:

```text
Message
   ↓
Hash
   ↓
Sign with Private Key
   ↓
Digital Signature
```

The receiver verifies it using the corresponding **public key**:

```text
Message + Signature + Public Key
              ↓
          Verification
              ↓
         Valid / Invalid
```

---

# 2. What Does a Digital Signature Provide?

Digital signatures primarily provide:

### Integrity

Was the message modified?

```text
Original Message
      ↓
     Sign
      ↓
    Message
      ↓
   Modified?
      ↓
Signature verification fails
```

### Authentication

Can the signature be verified using the expected public key?

### Evidence of signing

A valid signature can provide evidence that the holder of the corresponding private key signed the data, subject to correct key management and system assumptions.

---

# 3. Digital Signature vs Encryption

These are different operations.

### Encryption

Goal:

```text
Confidentiality
```

```text
Data
 ↓
Recipient's Public Key
 ↓
Ciphertext
 ↓
Recipient's Private Key
 ↓
Data
```

### Digital Signature

Goal:

```text
Integrity + Authentication
```

```text
Data
 ↓
Sender's Private Key
 ↓
Signature
 ↓
Receiver verifies with Public Key
```

A digital signature does **not automatically hide the message**.

---

# 4. How It Works

Signing:

```text
Large Message
      ↓
Hash Function
      ↓
Message Digest
      ↓
Private Key
      ↓
Digital Signature
```

Verification:

```text
Received Message
      ↓
Hash
      ↓
Digest A

Signature
      ↓
Public Key
      ↓
Digest B

Digest A == Digest B
      ↓
Valid
```

This is why hashing and digital signatures work closely together.

---

# 5. Example

Suppose a software vendor releases:

```text
software.exe
```

The vendor signs it with its private key.

```text
software.exe
     ↓
Digital Signature
```

Your system has the vendor's trusted public key.

```text
software.exe
     +
signature
     +
trusted public key
     ↓
Verify
```

If verification succeeds:

```text
Signature valid
```

If the file was modified:

```text
Signature invalid
```

---

# 6. Industry Example — Software Code Signing

Code signing is widely used to establish trust in software.

```text
Developer
   ↓
Build Software
   ↓
Hash Software
   ↓
Sign using Private Key
   ↓
Signed Software
   ↓
User downloads it
   ↓
OS verifies signature
```

Windows, browsers, mobile platforms, and enterprise security tools can use code-signing information when evaluating software.

### Security benefit

If an attacker modifies the signed executable:

```text
Original Software
       ↓
Attacker modifies file
       ↓
Signature no longer matches
       ↓
Verification fails
```

---

# 7. Industry Example — Document Signing

Suppose a company signs a PDF contract digitally.

```text
Contract
   ↓
Hash
   ↓
Digital Signature
   ↓
Signed Document
```

Later:

```text
Signed Document
      ↓
Verify Signature
      ↓
Valid?
```

If someone changes:

```text
₹50,000
```

to:

```text
₹5,00,000
```

the document's content changes and signature verification should fail.

---

# 8. Common Signature Algorithms

Common public-key signature technologies include:

```text
RSA-PSS
ECDSA
Ed25519
```

### RSA-PSS

Modern RSA signature scheme with strong security properties when correctly implemented.

### ECDSA

Elliptic-curve digital signature algorithm.

### Ed25519

Modern elliptic-curve signature scheme known for efficient implementation and strong security when used correctly.

---

# 9. Digital Signature vs HMAC

This is an important interview question.

### HMAC

```text
Sender + Shared Secret
        ↓
       HMAC
```

Both parties need the **same secret key**.

### Digital Signature

```text
Sender
   ↓
Private Key → Signature

Receiver
   ↓
Public Key → Verification
```

The receiver does not need the sender's private key.

| HMAC | Digital Signature |
|---|---|
| Shared secret | Public/private key |
| Symmetric | Asymmetric |
| Fast | Generally more computationally expensive |
| Both parties know secret | Private key remains with signer |
| API integrity/authentication | Software signing, certificates, documents |

---

# 10. Industry-Level Cybersecurity Scenario

### Scenario

A company downloads an executable from a vendor.

The SOC notices:

```text
VendorApp.exe
Publisher: Unknown
Signature: Invalid
```

The analyst should investigate:

```text
File
 ↓
Digital signature
 ↓
Signer identity
 ↓
Certificate chain
 ↓
Certificate validity
 ↓
File hash
 ↓
Threat intelligence
 ↓
Source of download
```

An invalid signature does **not automatically prove malware**, but it is an important security signal.

---

# 11. Certificate vs Digital Signature

Don't confuse them.

### Digital Signature

A cryptographic mechanism used to sign data.

### Certificate

A digitally signed structure that binds an identity to a public key.

Simplified:

```text
Certificate
   ↓
Identity
   +
Public Key
   +
Issuer's Signature
```

Certificates are central to **PKI** and TLS.

We'll cover this in:

```text
07-PKI.md
08-Certificates.md
```

---

# 12. Small Hands-On Lab — File Signing Concept

On Windows, you can inspect whether an executable has a digital signature.

PowerShell:

```powershell
Get-AuthenticodeSignature .\program.exe
```

Important fields include:

```text
Status
SignerCertificate
```

For example:

```text
Status: Valid
```

means the signature verification succeeded under the system's trust rules.

You can also inspect a file hash:

```powershell
Get-FileHash .\program.exe -Algorithm SHA256
```

Now you have two different pieces of evidence:

```text
Hash
→ What content is this?

Signature
→ Who signed it / is the signature valid?
```

---

# 13. Practical SOC Investigation

Suppose an endpoint downloads:

```text
update.exe
```

Investigation:

```text
1. Calculate SHA-256
        ↓
2. Check digital signature
        ↓
3. Identify signer
        ↓
4. Check certificate chain
        ↓
5. Check file origin
        ↓
6. Check process behavior
        ↓
7. Check network connections
```

This is much stronger than simply asking:

> "Does the filename look legitimate?"

---

# 14. Private Key Protection

The security of a digital signature depends heavily on the private key.

If:

```text
Vendor Private Key
        ↓
Compromised
```

an attacker may potentially create signatures that appear to originate from the legitimate signer.

Therefore private signing keys should be protected using appropriate controls such as:

- HSMs
- Secure key stores
- Access controls
- MFA for administration
- Key rotation/revocation procedures
- Auditing

---

# 15. Common Mistakes

### ❌ Sharing private signing keys

```text
Private Key → SECRET
```

### ❌ Assuming a valid signature means the software is completely safe

A legitimate signer can sign vulnerable or compromised software.

### ❌ Confusing hashing with signing

```text
Hash
→ Integrity digest

Signature
→ Cryptographic proof associated with a private key
```

### ❌ Trusting an unknown public key

You must establish that the public key belongs to the expected entity.

---

# 16. Interview Questions

### Q1. What is a digital signature?

A cryptographic mechanism using a private key to sign data so that others can verify the signature using the corresponding public key.

### Q2. What does a digital signature provide?

Primarily:

```text
Integrity
Authentication
Evidence associated with signing
```

### Q3. Does a digital signature encrypt the data?

No. Signing and encryption are separate operations.

### Q4. Which key signs the data?

```text
Private Key
```

### Q5. Which key verifies the signature?

```text
Public Key
```

### Q6. What is code signing?

Using digital signatures to establish authenticity/integrity of software and related artifacts.

### Q7. HMAC vs digital signature?

```text
HMAC
→ Shared secret

Digital Signature
→ Private/public key pair
```

---

# 17. Quick Cheat Sheet

```text
Digital Signature
→ Sign with private key
→ Verify with public key

Provides
→ Integrity
→ Authentication
→ Evidence associated with signing

Signing
→ Hash message
→ Create signature

Verification
→ Hash received message
→ Verify signature
→ Compare cryptographic result

Algorithms
→ RSA-PSS
→ ECDSA
→ Ed25519

HMAC
→ Shared secret

Digital Signature
→ Private/public key pair

Code Signing
→ Software authenticity/integrity

Private Key
→ Must be protected
```

## Core Mental Model

```text
                 DIGITAL SIGNATURE
                         ↓
                    Message
                         ↓
                       Hash
                         ↓
                   Private Key
                         ↓
                     Signature
                         ↓
        ┌────────────────┴────────────────┐
        ↓                                 ↓
   Original Message                  Signature
        +                                 +
        └──────────────┬──────────────────┘
                       ↓
                   Public Key
                       ↓
                  Verification
                       ↓
                 Valid / Invalid
```

**Next:** `07-PKI.md`