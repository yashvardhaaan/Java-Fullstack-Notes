````md id="jwt"
# JWT (JSON Web Token)

## 1. What is JWT?

**JWT = JSON Web Token**

A compact, digitally signed token used to securely transmit claims between parties.

> **JWT is commonly used for authentication/authorization in web APIs.**

Example:

```text
Client
  ↓ Login
Server
  ↓ JWT
Client
  ↓ JWT with requests
Server
  ↓ Verify JWT
Access granted/denied
````

---

# 2. Structure of JWT ⭐⭐⭐⭐⭐

JWT has **3 parts** separated by dots:

```text
HEADER.PAYLOAD.SIGNATURE
```

Example:

```text
eyJ... . eyJ... . Sfl...
```

### 1️⃣ Header

Contains metadata such as:

```json
{
  "alg": "RS256",
  "typ": "JWT"
}
```

### 2️⃣ Payload

Contains **claims**.

```json
{
  "sub": "123",
  "role": "admin",
  "exp": 1790000000
}
```

### 3️⃣ Signature

Used to verify that the token was created by a trusted party and was not modified.

```text
Header + "." + Payload
        ↓
      Sign
        ↓
   Signature
```

🔥 **JWT is not encrypted by default.**

---

# 3. JWT Encoding ⭐⭐⭐⭐⭐

Header and payload are typically **Base64URL-encoded**, not encrypted.

Therefore:

```text
JWT
 ↓
Decode payload
 ↓
Read claims
```

Anyone possessing the token can generally decode its header/payload.

❌ Do NOT put passwords, private keys, or sensitive secrets inside the payload.

> **Encoding ≠ Encryption**

---

# 4. JWT Signature ⭐⭐⭐⭐⭐

Signature protects the integrity of the token.

Conceptually:

```text
Header + Payload
       ↓
   Cryptographic
     algorithm
       ↓
    Signature
```

Server verifies:

```text
Received JWT
     ↓
Verify Signature
     ↓
Valid?
 ┌───┴───┐
Yes      No
 ↓        ↓
Accept   Reject
```

---

# 5. HS vs RS ⭐⭐⭐⭐⭐

### HS256

Uses **one shared secret**.

```text
Server A ─── Shared Secret ─── Server B
```

Same secret is used to create and verify signatures.

### RS256

Uses **asymmetric cryptography**.

```text
Private Key → Sign
Public Key  → Verify
```

| HS256                     | RS256                          |
| ------------------------- | ------------------------------ |
| Symmetric                 | Asymmetric                     |
| Shared secret             | Public/private key             |
| Sign + verify with secret | Private signs, public verifies |

---

# 6. Important JWT Claims ⭐⭐⭐⭐⭐

### `iss` — Issuer

Who issued the token?

### `sub` — Subject

Who/what does the token represent?

### `aud` — Audience

Who is the token intended for?

### `exp` — Expiration

When does the token expire?

### `iat` — Issued At

When was it issued?

### `nbf` — Not Before

Token should not be accepted before this time.

### `jti` — JWT ID

Unique identifier for the token.

🔥 `exp` is especially important for token lifetime.

---

# 7. Access Token vs Refresh Token ⭐⭐⭐⭐⭐

### Access Token

Short-lived token used to access APIs.

```text
Client → Access Token → API
```

### Refresh Token

Used to obtain a new access token after it expires.

```text
Refresh Token
      ↓
Authorization Server
      ↓
New Access Token
```

Typical pattern:

```text
Short-lived Access Token
          +
Longer-lived Refresh Token
```

🔥 Refresh tokens require careful protection.

---

# 8. JWT vs Session ⭐⭐⭐⭐⭐

### Session

```text
Client
  ↓
Session ID
  ↓
Server
  ↓
Session Store
```

Server maintains session state.

### JWT

```text
Client
  ↓
JWT
  ↓
Server verifies token
```

Token carries claims.

| Session                            | JWT                                   |
| ---------------------------------- | ------------------------------------- |
| Session state commonly server-side | Claims carried in token               |
| Client usually stores session ID   | Client stores token                   |
| Easy server-side invalidation      | Revocation requires additional design |
| Often cookie-based                 | Header or cookie possible             |

🔥 **JWT ≠ automatically stateless.**
An application can still maintain state such as revocation lists or refresh-token records.

---

# 9. JWT in Authorization

JWT can contain claims such as:

```json
{
  "sub": "123",
  "role": "admin"
}
```

Server can use the verified claims for authorization.

```text
JWT
 ↓
Verify signature + claims
 ↓
User = 123
Role = admin
 ↓
Authorization
 ↓
ALLOW
```

🔥 A client must **not be trusted simply because it claims `"role": "admin"`**. The signature and validation must be correct.

---

# 10. JWT Validation ⭐⭐⭐⭐⭐

Server should validate more than just the signature.

Important checks include:

```text
Signature ✓
Expiration ✓
Issuer ✓
Audience ✓
Not-before ✓
Algorithm/policy ✓
```

Then:

```text
Valid JWT
   ↓
Authenticated identity
   ↓
Authorization
```

---

# 11. Where Can JWT Be Stored?

Common choices:

### Authorization Header

```http
Authorization: Bearer <JWT>
```

### Cookie

JWT can also be stored in a cookie with appropriate security attributes.

```http
Set-Cookie: token=...; Secure; HttpOnly; SameSite=Lax
```

There is **no universally best storage choice**; security depends on the application architecture and threat model.

---

# 12. JWT Security Problems

### Token Theft

If attacker obtains a valid token:

```text
Attacker
   ↓
Valid JWT
   ↓
API
```

They may impersonate the token's subject until it expires or is otherwise invalidated.

### Mitigations

* HTTPS
* Short access-token lifetime
* Secure storage
* Proper audience/issuer validation
* Refresh-token protection
* Token rotation/revocation strategies

---

# 13. JWT vs OAuth 2.0 ⭐⭐⭐⭐⭐

These are **not the same thing**.

### JWT

A **token format**.

### OAuth 2.0

An **authorization framework**.

```text
OAuth 2.0
   ↓
Defines authorization flows
   ↓
Can use different token formats
```

JWT may be used as an OAuth access token, but OAuth does **not require JWT**.

---

# 🔥 Interview / GATE Traps

1. **JWT = JSON Web Token.**
2. Structure = **Header.Payload.Signature**.
3. JWT payload is typically **encoded, not encrypted**.
4. Anyone holding a JWT can generally decode its payload.
5. Signature provides integrity/authenticity when properly verified.
6. **HS256 → shared secret.**
7. **RS256 → private key signs, public key verifies.**
8. `exp` → expiration.
9. `iss` → issuer.
10. `sub` → subject.
11. `aud` → audience.
12. Access token ≠ refresh token.
13. JWT ≠ session.
14. JWT ≠ OAuth.
15. OAuth 2.0 does not require JWT.
16. Never trust JWT claims without validating the token.
17. HTTPS is still required to protect tokens in transit.

---

# ⚡ 30-Second Revision

```text
JWT
 ↓
Header.Payload.Signature

Header
 ↓
Algorithm + Type

Payload
 ↓
Claims

Signature
 ↓
Integrity + Authenticity
```

```text
HS256
 ↓
Shared Secret

RS256
 ↓
Private Key → Sign
Public Key  → Verify
```

```text
Access Token
 ↓
Short-lived API access

Refresh Token
 ↓
Get new access token
```

```text
JWT → Token Format
OAuth → Authorization Framework
Session → Server-side state mechanism
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐⭐

```
```
