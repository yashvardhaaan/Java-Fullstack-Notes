# `08-Certificates.md`

# Digital Certificates — Cryptography Notes

## 1. First Principle

A **digital certificate** binds an identity to a public key.

Think of it as:

```text
Identity
   +
Public Key
   +
CA's Digital Signature
   ↓
Digital Certificate
```

The certificate answers:

> **"How can I trust that this public key belongs to this server/domain/entity?"**

---

# 2. What a Certificate Contains

A typical X.509 certificate contains information such as:

```text
Certificate
├── Subject
├── Issuer
├── Public Key
├── Serial Number
├── Valid From
├── Valid To
├── Key Usage
├── Extended Key Usage
├── Subject Alternative Name (SAN)
└── CA Digital Signature
```

---

# 3. Subject

The **Subject** identifies the entity associated with the certificate.

Historically, a certificate might contain:

```text
CN=example.com
```

But for modern TLS hostname validation, **Subject Alternative Name (SAN)** is the important field.

Example:

```text
DNS:example.com
DNS:www.example.com
```

---

# 4. Issuer

The **Issuer** identifies the CA that issued the certificate.

Example:

```text
Subject:
example.com

Issuer:
Example Intermediate CA
```

Think:

```text
Website Certificate
       ↑
   signed by
       ↑
Intermediate CA
```

---

# 5. Validity Period

Certificates contain:

```text
Not Before
Not After
```

Example:

```text
Valid From:
01 Jan 2026

Valid To:
01 Jan 2027
```

A certificate outside its validity period may fail validation.

---

# 6. Subject Alternative Name — SAN

SAN is extremely important in modern HTTPS.

Example:

```text
Subject Alternative Name:
DNS:example.com
DNS:api.example.com
DNS:*.example.com
```

If you connect to:

```text
api.example.com
```

the certificate needs an appropriate SAN covering that hostname.

### Important

Don't rely only on:

```text
CN=example.com
```

Modern hostname verification uses SAN.

---

# 7. Certificate Chain

A certificate usually forms a chain:

```text
Root CA
   ↓
Intermediate CA
   ↓
Server Certificate
```

The operating system/browser trusts the root.

The intermediate signs the server certificate.

Therefore:

```text
Trusted Root
     ↓
Intermediate
     ↓
Server Certificate
     ↓
example.com
```

---

# 8. TLS Certificate Validation

When you visit an HTTPS website, the browser performs checks including:

```text
Certificate received
       ↓
Is hostname covered?
       ↓
Is certificate valid in time?
       ↓
Is signature valid?
       ↓
Does chain lead to trusted root?
       ↓
Are relevant key usages valid?
       ↓
Certificate accepted
```

If validation fails, the browser may display a certificate warning.

---

# 9. Industry Example — Expired Certificate

Imagine an organization's API certificate expires:

```text
api.company.com
       ↓
Certificate expired
       ↓
Clients reject connection
       ↓
API becomes unavailable
```

This is both an **availability** and security-management issue.

Production teams therefore monitor certificate expiration before it becomes a problem.

---

# 10. Industry Example — Certificate Mismatch

Suppose you visit:

```text
https://bank.example
```

but the certificate only contains:

```text
DNS:attacker.example
```

The hostname doesn't match.

Conceptually:

```text
Requested:
bank.example

Certificate:
attacker.example

        ↓

Hostname validation fails
```

This protects users against many forms of impersonation.

---

# 11. Self-Signed Certificates

A self-signed certificate is signed by itself rather than by a publicly trusted CA.

```text
Certificate
    ↓
Signed by itself
```

They are common in:

- Development
- Testing
- Internal infrastructure

Example:

```text
Developer Laptop
      ↓
Self-signed certificate
      ↓
Local HTTPS
```

A self-signed certificate isn't automatically malicious.

The question is:

> **Should this certificate be trusted in this environment?**

---

# 12. Wildcard Certificates

Example:

```text
*.example.com
```

may cover:

```text
www.example.com
api.example.com
mail.example.com
```

but wildcard rules have limitations and don't automatically cover every possible hostname.

Security teams should carefully control wildcard private keys because one compromised wildcard key can affect multiple services.

---

# 13. Key Usage and Extended Key Usage

Certificates can specify what the associated key is intended for.

Examples:

```text
Key Usage:
Digital Signature
Key Encipherment
```

Extended Key Usage may include:

```text
TLS Web Server Authentication
TLS Web Client Authentication
Code Signing
Email Protection
```

This prevents a certificate from being used outside its intended purpose where the relying system enforces those constraints.

---

# 14. Industry Security Scenario — Compromised Certificate

Suppose:

```text
Company Web Server
        ↓
Private Key stolen
        ↓
Certificate potentially compromised
```

Incident response:

```text
1. Investigate key exposure
        ↓
2. Revoke certificate if appropriate
        ↓
3. Generate new key pair
        ↓
4. Obtain new certificate
        ↓
5. Deploy new certificate
        ↓
6. Investigate possible unauthorized use
```

**Generating a new certificate with the same compromised private key does not solve the underlying problem.**

Generate a new key pair.

---

# 15. Inspect a Certificate with OpenSSL

Run:

```bash
openssl s_client -connect example.com:443 -servername example.com
```

This can show the server's TLS certificate and certificate chain.

To inspect a saved certificate:

```bash
openssl x509 -in certificate.pem -text -noout
```

Meaning:

```text
openssl x509
→ Work with X.509 certificates

-in
→ Input certificate

-text
→ Human-readable details

-noout
→ Don't output the encoded certificate
```

---

# 16. Windows Certificate Inspection

PowerShell:

```powershell
Get-ChildItem Cert:\CurrentUser\My
```

View certificate details:

```powershell
Get-ChildItem Cert:\CurrentUser\My |
    Format-List Subject,Issuer,NotBefore,NotAfter,Thumbprint
```

This is useful for quickly checking:

```text
Subject
Issuer
Validity
Thumbprint
```

---

# 17. Certificate Thumbprint

A certificate has a fingerprint/thumbprint that can help identify a specific certificate.

Example:

```text
Thumbprint:
A1B2C3D4...
```

In incident response, you may compare:

```text
Expected Certificate Thumbprint
            ↓
Observed Certificate Thumbprint
            ↓
Match / Mismatch
```

The exact fingerprinting algorithm and platform terminology should be considered when comparing certificates.

---

# 18. SOC Investigation Example

An analyst receives an alert:

```text
Certificate changed on production API
```

Investigation:

```text
New Certificate
      ↓
Subject / SAN
      ↓
Issuer
      ↓
Validity
      ↓
Public Key
      ↓
Thumbprint
      ↓
Who deployed it?
      ↓
Was deployment authorized?
```

If an unexpected certificate appears:

```text
Certificate Change
       +
Unauthorized Deployment
       +
Private Key Exposure
```

this could indicate a serious security incident.

---

# 19. Certificate vs Public Key

Don't confuse them.

### Public Key

```text
Mathematical cryptographic key
```

### Certificate

```text
Identity
+
Public Key
+
Metadata
+
Issuer's signature
```

Therefore:

```text
Public Key ≠ Certificate
```

A certificate is a trusted container/binding around a public key and identity information.

---

# 20. Small Hands-On Lab

Inspect a public HTTPS certificate:

```bash
openssl s_client \
-connect example.com:443 \
-servername example.com
```

Look for:

```text
Subject
Issuer
Validity
Public Key
Certificate Chain
```

Then answer:

```text
1. Who issued the certificate?
2. What hostname does it cover?
3. When does it expire?
4. Which CA chain does it belong to?
```

This is similar to the information a security analyst may inspect during a TLS investigation.

---

# 21. Common Mistakes

### ❌ Checking only the certificate expiration

A certificate can be valid but belong to the wrong hostname.

### ❌ Trusting any CA

Trust depends on the system's configured trust store and security policy.

### ❌ Reusing compromised private keys

Generate a new key pair.

### ❌ Assuming self-signed = malicious

Internal systems may legitimately use self-signed certificates.

### ❌ Ignoring SAN

Modern TLS hostname validation relies heavily on SAN.

---

# 22. Interview Questions

### Q1. What is a digital certificate?

A digitally signed structure that binds an identity to a public key.

### Q2. What is X.509?

A widely used standard for digital certificates and related PKI structures.

### Q3. What is SAN?

**Subject Alternative Name**, used to specify identities such as DNS names covered by a certificate.

### Q4. What is the Issuer?

The CA or entity that issued/signed the certificate.

### Q5. What is a certificate chain?

A chain connecting an end-entity certificate through intermediate CAs to a trusted root CA.

### Q6. What is a self-signed certificate?

A certificate signed by its own key rather than by a separate trusted CA.

### Q7. What happens if a private key is compromised?

The associated certificate may need to be revoked and replaced with a new certificate using a newly generated key pair.

---

# 23. Quick Cheat Sheet

```text
Certificate
→ Identity + Public Key + CA Signature

X.509
→ Common certificate standard

Subject
→ Certificate identity

SAN
→ Modern hostname identities

Issuer
→ Certificate issuer/CA

Not Before / Not After
→ Validity period

Root CA
→ Trust anchor

Intermediate CA
→ Issues end-entity certificates

Self-Signed
→ Signed by itself

Key Usage
→ Permitted cryptographic purpose

Thumbprint
→ Certificate fingerprint/identifier

Private Key
→ Must remain secret

TLS
→ Uses certificates for authentication
```

## Core Mental Model

```text
                 X.509 CERTIFICATE
                         ↓
        ┌────────────────┼────────────────┐
        ↓                ↓                ↓
     Identity        Public Key         Metadata
        ↓                ↓                ↓
        └────────────────┼────────────────┘
                         ↓
                   CA Signature
                         ↓
                 Certificate Chain
                         ↓
                    Trust Decision
                         ↓
              Secure TLS Connection
```

**Next:** `09-TLS-Handshake.md`