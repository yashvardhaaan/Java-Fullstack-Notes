# `07-PKI.md`

# Public Key Infrastructure (PKI)

## 1. First Principle

**PKI is the system used to create, manage, validate, and revoke digital certificates and public keys.**

The problem PKI solves is:

> **How do I know that a public key actually belongs to the website, server, person, or organization claiming to own it?**

Without PKI:

```text
Server
  ↓
"This is my public key"
  ↓
Client
  ↓
"How do I know this key belongs to the real server?"
```

With PKI:

```text
Server Public Key
       ↓
Certificate
       ↓
Trusted Certificate Authority
       ↓
Client verifies trust
```

---

# 2. Core PKI Components

The main components are:

```text id="yqcv07"
                 PKI
                  │
      ┌───────────┼───────────┐
      ↓           ↓           ↓
     CA          RA       Certificates
      ↓                       ↓
  Issues/              Bind identity
  signs certs           to public key
```

### CA — Certificate Authority

A trusted organization/system that issues and signs certificates.

Examples include:

- DigiCert
- GlobalSign
- Let's Encrypt

---

### RA — Registration Authority

Helps verify the identity or certificate request before a certificate is issued.

Conceptually:

```text
Applicant
   ↓
RA / Validation
   ↓
CA
   ↓
Certificate
```

---

# 3. Digital Certificate

A certificate essentially says:

```text
"This public key belongs to this identity/domain,
and a trusted CA has signed this statement."
```

Simplified:

```text id="8b1ubc"
Certificate
 ├── Subject / Identity
 ├── Public Key
 ├── Validity Period
 ├── Issuer
 ├── Serial Number
 └── CA Digital Signature
```

---

# 4. Certificate Chain of Trust

A browser usually doesn't blindly trust every certificate.

Instead, trust is established through a chain:

```text id="b6n8r6"
Root CA
   ↓ signs
Intermediate CA
   ↓ signs
Website Certificate
   ↓
example.com
```

The browser/OS trusts certain **Root CAs**.

Therefore:

```text
Root CA
   ↓
Trusted
   ↓
Intermediate CA
   ↓
Website Certificate
   ↓
Website Identity
```

---

# 5. Root CA

A **Root CA** is at the top of a certificate trust chain.

Its certificate is generally trusted directly by operating systems and browsers through their trusted root stores.

Example:

```text id="7id1vp"
Trusted Root
      ↓
Intermediate CA
      ↓
example.com Certificate
```

Root CA private keys are therefore extremely sensitive.

---

# 6. Intermediate CA

Instead of having the Root CA sign every website certificate directly:

```text id="q3l8ye"
Root CA
   ↓
Intermediate CA
   ↓
Website Certificate
```

This provides separation and limits the exposure of the root signing key.

If an intermediate CA is compromised, it can be revoked without necessarily replacing the entire root trust anchor.

---

# 7. Industry Example — HTTPS

When you visit:

```text id="d7f5fz"
https://bank.example
```

the server presents its TLS certificate.

Your browser checks things such as:

```text id="8oh0d6"
1. Certificate is for the requested domain
2. Certificate is within validity period
3. Certificate chain leads to a trusted root
4. Signatures are valid
5. Certificate has not been revoked according to applicable checks
```

If validation succeeds:

```text id="7q4pdu"
Certificate Trusted
        ↓
Server Identity Established
        ↓
TLS Session Continues
```

---

# 8. What If PKI Didn't Exist?

Imagine an attacker intercepts your connection.

```text id="s4zjjv"
You
 ↓
Attacker
 ↓
Real Website
```

The attacker could attempt to present their own public key.

Without a trusted mechanism for validating identity:

```text
Fake Public Key
      ↓
"Trust me, I'm the bank"
```

PKI helps prevent this by requiring the certificate to chain to a trusted authority and match the expected identity.

---

# 9. Certificate Revocation

Certificates sometimes need to be invalidated before their expiration date.

Reasons include:

- Private key compromise
- Certificate issued incorrectly
- Domain ownership changes
- Organization requests revocation

Common mechanisms include:

```text id="l8e1r0"
CRL
OCSP
```

### CRL

**Certificate Revocation List**

A list of revoked certificates.

### OCSP

**Online Certificate Status Protocol**

Allows systems to query certificate status.

Modern systems may also use mechanisms such as **OCSP stapling**.

---

# 10. Industry-Level Security Scenario

### Scenario

A company's TLS private key is accidentally exposed.

```text id="8x4v1b"
Private Key Compromised
        ↓
Certificate no longer trustworthy
        ↓
Revoke certificate
        ↓
Generate new key pair
        ↓
Obtain new certificate
        ↓
Deploy
        ↓
Investigate possible misuse
```

This is why certificate and private-key management is an important operational security responsibility.

---

# 11. Inspect a Website Certificate

In a browser, click the **padlock/security icon** next to an HTTPS website and inspect the certificate.

Look for:

```text id="l3f8hc"
Subject
Issuer
Validity
Public Key
Certificate Chain
```

You can also use OpenSSL from a terminal for TLS certificate inspection.

Example:

```bash id="7yqj1f"
openssl s_client -connect example.com:443 -servername example.com
```

This connects to the TLS service and displays certificate/TLS information.

---

# 12. Windows Certificate Store

Windows maintains certificate stores.

PowerShell can inspect certificates.

Current user's personal certificates:

```powershell id="z0jzj4"
Get-ChildItem Cert:\CurrentUser\My
```

Trusted root certificates:

```powershell id="r8l5tg"
Get-ChildItem Cert:\LocalMachine\Root
```

Conceptually:

```text id="4w3cbd"
Certificate Store
       ↓
Trusted / Personal / Intermediate Certificates
```

⚠️ Don't remove certificates from system trust stores unless you understand the organizational impact.

---

# 13. PKI in Enterprise

Enterprise environments can operate their own internal PKI.

Example:

```text id="qgyt5a"
Enterprise Root CA
        ↓
Intermediate CA
        ↓
 ┌──────┼───────┐
 ↓      ↓       ↓
VPN   Servers  Devices
```

Internal PKI can issue certificates for:

- Internal websites
- VPN
- Wi-Fi authentication
- Servers
- Devices
- User authentication
- Code signing

---

# 14. SOC / Security Relevance

A security analyst may investigate:

```text id="w8ip74"
Expired Certificate
Invalid Certificate
Unexpected Certificate
Self-Signed Certificate
Certificate Mismatch
Compromised Private Key
Unknown CA
Suspicious Internal CA
```

Example:

```text id="5t4q3c"
Internal Server
      ↓
Unexpected Certificate
      ↓
Unknown Issuer
      ↓
Investigate
```

Don't automatically classify a self-signed certificate as malicious. Internal environments legitimately use them in some situations.

---

# 15. Small Hands-On Lab

### Inspect local certificates

Windows:

```powershell id="7r5a9g"
Get-ChildItem Cert:\CurrentUser\My
```

View trusted roots:

```powershell id="b1i0qv"
Get-ChildItem Cert:\LocalMachine\Root
```

### Inspect a public TLS service

```bash id="x6bqpx"
openssl s_client -connect example.com:443 -servername example.com
```

Look for:

```text id="6e0e6c"
Subject
Issuer
Validity
Certificate chain
```

The goal is to understand the relationship:

```text id="9c9f4d"
Certificate
    ↓
Issuer
    ↓
Intermediate
    ↓
Trusted Root
```

---

# 16. Common Mistakes

### ❌ Trusting any certificate

A certificate must chain to an appropriate trusted authority and match the intended identity.

### ❌ Sharing private keys

```text id="x4i0we"
Private Key → SECRET
```

### ❌ Ignoring expiration

Expired certificates can break services.

### ❌ Ignoring revocation

Compromised certificates may need immediate revocation.

### ❌ Assuming HTTPS means the website itself is trustworthy

HTTPS primarily establishes a secure authenticated connection to the identified endpoint. It does **not** guarantee that the website's business, content, or application is safe.

---

# 17. Interview Questions

### Q1. What is PKI?

A framework for managing public keys, digital certificates, identities, and trust relationships.

### Q2. What is a CA?

A Certificate Authority that issues and signs certificates.

### Q3. What is a certificate?

A digitally signed structure that binds an identity to a public key.

### Q4. What is a certificate chain?

A hierarchy linking an end-entity certificate through intermediate CA certificates to a trusted root CA.

### Q5. What is a Root CA?

A trusted certificate authority at the top of a certificate chain.

### Q6. What is certificate revocation?

Invalidating a certificate before its normal expiration.

### Q7. CRL vs OCSP?

```text id="v1b6zj"
CRL
→ List of revoked certificates

OCSP
→ Query certificate status
```

---

# 18. Quick Cheat Sheet

```text
PKI
→ Public-key trust infrastructure

CA
→ Certificate Authority

RA
→ Registration Authority

Certificate
→ Identity + Public Key + CA Signature

Root CA
→ Trust anchor

Intermediate CA
→ Issues/signs end-entity certificates

Certificate Chain
→ Root → Intermediate → Website

CRL
→ Certificate Revocation List

OCSP
→ Certificate status protocol

Private Key
→ Must remain secret

HTTPS
→ Uses certificates + TLS

Enterprise PKI
→ Internal certificate infrastructure
```

## Core Mental Model

```text
                    PKI
                     ↓
                Root CA
                     ↓
            Intermediate CA
                     ↓
              Certificate
                     ↓
          Identity + Public Key
                     ↓
             Certificate Check
                     ↓
          Trusted / Not Trusted
                     ↓
              Secure Connection
```

**Next:** `08-Certificates.md`