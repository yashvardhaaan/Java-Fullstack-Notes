````md id="authentication"
# Authentication

## 1. What is Authentication?

**Authentication = verifying WHO you are.**

> Authentication answers: **"Are you really the person/entity you claim to be?"**

Example:
```text
Username → "Who are you?"
Password  → "Prove it."
````

---

## 2. Authentication Factors ⭐⭐⭐⭐⭐

### 1️⃣ Something you know

* Password
* PIN
* Security question

### 2️⃣ Something you have

* OTP device
* Smartphone
* Smart card
* Security token

### 3️⃣ Something you are

* Fingerprint
* Face
* Iris
* Voice

### 4️⃣ Somewhere you are

* Location-based authentication

### 5️⃣ Something you do

* Typing pattern
* Behavioral biometrics

---

## 3. Single-Factor vs Multi-Factor

### Single-Factor Authentication

Uses **one factor**.

```text
Password
   ↓
Authenticated
```

### Multi-Factor Authentication (MFA)

Uses **two or more different factor categories**.

Example:

```text
Password       → Something you know
       +
OTP from phone → Something you have
       ↓
     MFA
```

🔥 Two passwords are still **one factor category**.

---

## 4. Authentication vs Authorization ⭐⭐⭐⭐⭐

| Authentication    | Authorization                  |
| ----------------- | ------------------------------ |
| Who are you?      | What can you access?           |
| Verifies identity | Determines permissions         |
| Happens first     | Usually follows authentication |
| Login             | Access control                 |

Example:

```text
Login with password
       ↓
Authentication
       ↓
"Yash is authenticated"
       ↓
Authorization
       ↓
"Yash can read this file"
```

> **AuthN = Identity**
> **AuthZ = Permission**

---

# 5. Password Authentication

Basic process:

```text
User → Username + Password → Server
                              ↓
                         Verify credentials
                              ↓
                         Allow / Deny
```

### ⚠️ Password Storage

Servers should **not store plaintext passwords**.

Instead, use:

```text
Password
   ↓
Password Hash + Salt
   ↓
Stored
```

### Salt

A **random value added to a password before hashing**.

```text
Password + Salt
      ↓
    Hash
      ↓
   Stored
```

Salt helps defend against precomputed/rainbow-table attacks.

---

# 6. OTP ⭐⭐⭐⭐

**OTP = One-Time Password**

A code intended to be used only once or for a short validity period.

Examples:

* SMS OTP
* Authenticator-app code
* Hardware token

### Important

OTP improves authentication security but **SMS OTP is not immune to attacks** such as SIM swapping or phishing.

---

# 7. Challenge-Response Authentication ⭐⭐⭐⭐

Instead of sending the secret directly, the server sends a **challenge**.

```text
Server → Random Challenge
Client → Response based on secret + challenge
Server → Verify response
```

### Advantage

The secret itself need not be transmitted over the network.

### Example

**CHAP** uses challenge-response authentication.

---

# 8. Certificate-Based Authentication ⭐⭐⭐⭐⭐

Digital certificates can bind an **identity to a public key**.

```text
Certificate
     ↓
Identity + Public Key
     ↓
Signed by CA
```

Used heavily in:

* TLS/HTTPS
* Enterprise authentication
* PKI

---

# 9. Public-Key Authentication ⭐⭐⭐⭐⭐

Commonly used by SSH.

```text
Client
Private Key 🔐
     ↓
Proves possession
     ↓
Server verifies using
Public Key
```

🔥 **Private key should never be shared.**

---

# 10. Authentication Protocols

| Protocol       | Main idea                                               |
| -------------- | ------------------------------------------------------- |
| PAP            | Username/password, weak                                 |
| CHAP           | Challenge-response                                      |
| Kerberos       | Ticket-based authentication                             |
| OAuth 2.0      | Authorization framework                                 |
| OpenID Connect | Authentication/identity layer on OAuth 2.0              |
| TLS            | Secure channel + server authentication via certificates |

### ⚠️ Important distinction

**OAuth ≠ authentication protocol by itself.**

OAuth primarily deals with **authorization/delegated access**.

---

# 11. Kerberos ⭐⭐⭐⭐⭐

Kerberos provides **network authentication using tickets**.

Main entities:

```text
Client
   ↓
Authentication Server (AS)
   ↓
Ticket Granting Ticket (TGT)
   ↓
Ticket Granting Server (TGS)
   ↓
Service Ticket
   ↓
Application Server
```

### Key idea

User does not repeatedly send the password to every service.

Kerberos relies heavily on **symmetric-key cryptography** and a trusted **KDC (Key Distribution Center)**.

---

# 12. Authentication Attacks

| Attack              | Idea                                               |
| ------------------- | -------------------------------------------------- |
| Brute force         | Try many passwords                                 |
| Dictionary          | Try common passwords                               |
| Credential stuffing | Reuse leaked username/password pairs               |
| Phishing            | Trick user into giving credentials                 |
| Replay              | Reuse captured authentication data                 |
| MITM                | Intercept/alter communication                      |
| Password spraying   | Try one/few common passwords against many accounts |

---

# 🔥 GATE Traps

* **Authentication → WHO**
* **Authorization → WHAT you're allowed to do**
* MFA requires **different factor categories**, not merely multiple credentials.
* Password should not be stored in plaintext.
* **Salt ≠ encryption key**.
* OTP is generally short-lived/one-time.
* CHAP → challenge-response.
* Kerberos → ticket-based authentication.
* OAuth → authorization/delegated access.
* Digital certificate → binds identity to a public key.
* Private key must remain secret.

---

# ⚡ 30-Second Revision

```text
Authentication
      ↓
    WHO?

Factors:
Know → Password/PIN
Have → Phone/Token
Are  → Fingerprint/Face

MFA
 ↓
2+ different factor categories

Password
 ↓
Salt + Password
 ↓
Hash
 ↓
Store

CHAP
 ↓
Challenge → Response

Kerberos
 ↓
Tickets + KDC

Certificate
 ↓
Identity ↔ Public Key
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
