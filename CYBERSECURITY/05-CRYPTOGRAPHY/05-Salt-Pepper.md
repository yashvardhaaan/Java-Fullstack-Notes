# `05-Salt-Pepper.md`

# Salt & Pepper — Password Security

## 1. First Principle

Passwords should **never be stored as plaintext**.

Instead:

```text
User Password
     ↓
Salt + Password
     ↓
Password Hashing Function
     ↓
Password Verifier
     ↓
Database
```

A **salt** and a **pepper** are additional protections designed to make password attacks harder.

---

# 2. Why Salt Is Needed

Suppose two users choose the same password:

```text
User A → Password123
User B → Password123
```

Without salts:

```text
Hash(Password123)
        ↓
Same Hash
```

An attacker immediately knows the users have the same password.

With unique salts:

```text
Password123 + Salt-A → Hash-A

Password123 + Salt-B → Hash-B
```

Now the stored values are different.

---

# 3. What Is a Salt?

A **salt** is a unique, randomly generated value associated with a password.

Conceptually:

```text
Password
   +
Random Salt
   ↓
Password Hashing Algorithm
   ↓
Password Verifier
```

Example:

```text
Password = "Password123"

Salt A = "7f91..."
        ↓
Hash A

Salt B = "a82c..."
        ↓
Hash B
```

### Important

A salt is **not required to be secret**.

It can normally be stored alongside the password verifier.

---

# 4. Why Salts Stop Precomputed Attacks

Attackers can create large precomputed tables of common password hashes, historically called **rainbow tables**.

Without salts:

```text
Password123
     ↓
Known Hash
     ↓
Match
```

With unique salts:

```text
Password123 + Salt-A
       ↓
Unique Hash

Password123 + Salt-B
       ↓
Different Hash
```

The attacker can't simply reuse one precomputed hash for every account.

---

# 5. Salt Does NOT Make Weak Passwords Strong

Important distinction:

```text
Weak Password
+
Salt
=
Still Weak Password
```

A salt mainly prevents efficient reuse of precomputed results and makes identical passwords produce different stored values.

You still need:

- Strong password policy
- MFA
- Rate limiting
- Secure password hashing

---

# 6. What Is a Pepper?

A **pepper** is an additional secret value used in password verification.

Conceptually:

```text
Password
   +
Salt
   +
Secret Pepper
   ↓
Password Hashing
   ↓
Verifier
```

Unlike a salt:

```text
Salt
→ Usually stored with password verifier

Pepper
→ Kept secret separately
```

The pepper might be protected using a:

- Secrets manager
- HSM
- KMS
- Secure application configuration

---

# 7. Salt vs Pepper

| Property | Salt | Pepper |
|---|---|---|
| Unique per password | Yes | Usually shared secret |
| Secret? | No | Yes |
| Stored with verifier? | Commonly yes | No |
| Main purpose | Defeat precomputation / identical hashes | Add secret protection |
| Storage | Database | Separate secret-management system |

Mental model:

```text
Password
   +
Salt ───────→ Database
   +
Pepper ─────→ Secret Store
```

---

# 8. Industry-Level Example

Imagine a web application:

```text
User
 ↓
Login
 ↓
Application Server
 ↓
Password Verification
```

Database contains:

```text
username
password_verifier
salt
```

The application also has access to a secret pepper:

```text
Application
     ↓
Secrets Manager
     ↓
Pepper
```

Verification conceptually becomes:

```text
Entered Password
       +
Stored Salt
       +
Secret Pepper
       ↓
Password Hashing
       ↓
Compare with stored verifier
```

The exact construction should be designed according to the password-hashing library's documented scheme rather than inventing a custom formula.

---

# 9. What Happens if Database Is Stolen?

### Without Salt

```text
Database stolen
      ↓
Hash database
      ↓
Precomputed attacks
      ↓
Passwords potentially recovered faster
```

### With Unique Salts

```text
Database stolen
      ↓
Unique salt per account
      ↓
Attacker must perform separate password guesses
      ↓
Precomputed reuse becomes much less useful
```

### With Pepper

```text
Database stolen
      ↓
Pepper NOT in database
      ↓
Attacker still needs secret pepper
```

A pepper can therefore provide an additional defense, but it must be managed carefully.

---

# 10. Industry Security Scenario

### Scenario

A company discovers:

```text
users.db
```

was exfiltrated.

The database contains:

```text
username
salt
password verifier
```

The security team immediately:

1. Determines which password-hashing algorithm was used.
2. Checks its parameters.
3. Determines whether salts are unique.
4. Determines whether a pepper is used.
5. Assesses password strength and likely cracking risk.
6. Forces password resets if appropriate.
7. Investigates how the database was accessed.
8. Reviews authentication logs for suspicious activity.

Important:

> A stolen password database is a security incident even when passwords are properly hashed.

---

# 11. Password Hashing Algorithms

Use password-specific algorithms such as:

```text
Argon2id
bcrypt
scrypt
```

### Argon2id

A modern password hashing option designed to make password cracking more expensive, including through memory usage.

### bcrypt

A widely deployed password hashing algorithm.

### scrypt

Designed to make large-scale password cracking more resource-intensive.

Avoid using:

```text
MD5(password)
SHA1(password)
SHA256(password)
```

directly as password-storage schemes.

---

# 12. Small Hands-On Lab

You can safely demonstrate the concept with Python and `bcrypt`.

Install:

```bash
pip install bcrypt
```

Example:

```python
import bcrypt

password = b"MyStrongPassword!"

hashed = bcrypt.hashpw(password, bcrypt.gensalt())

print("Stored verifier:", hashed)

print(
    bcrypt.checkpw(password, hashed)
)
```

### What happens?

```text
Password
   ↓
bcrypt
   ↓
Salt generated
   ↓
Password verifier
   ↓
Database
```

Then:

```text
Entered Password
      ↓
bcrypt verification
      ↓
True / False
```

You don't manually create the salt here—the library handles it.

---

# 13. Observe Different Salts

Run:

```python
import bcrypt

password = b"MyStrongPassword!"

print(bcrypt.hashpw(password, bcrypt.gensalt()))
print(bcrypt.hashpw(password, bcrypt.gensalt()))
```

Even though the password is identical:

```text
Password
   ↓
Salt A → Hash A

Password
   ↓
Salt B → Hash B
```

The resulting stored values should be different.

Yet both can successfully verify the same password.

---

# 14. Common Mistakes

### ❌ Storing plaintext passwords

```text
password = "Password123"
```

Never store this.

### ❌ Using plain SHA-256

```text
SHA256(password)
```

Too fast for password storage.

### ❌ Using one global salt

Each password should have its own unique salt.

### ❌ Storing pepper in the database

That defeats the purpose of keeping the pepper separate.

### ❌ Inventing your own password hashing scheme

Use a well-reviewed password hashing library.

### ❌ Assuming hashing alone solves authentication security

Also consider:

```text
MFA
Rate limiting
Account lockout
Credential monitoring
Secure session management
```

---

# 15. SOC / Incident Response Relevance

When investigating a credential breach, ask:

```text
Which hashing algorithm?
        ↓
What parameters?
        ↓
Unique salts?
        ↓
Pepper?
        ↓
Database exposed?
        ↓
Application secrets exposed?
        ↓
Could passwords be cracked?
        ↓
Were accounts accessed?
```

This helps estimate the actual risk.

---

# 16. Interview Questions

### Q1. What is a salt?

A unique random value combined with a password during password hashing.

### Q2. Does a salt need to be secret?

No. It is normally stored alongside the password verifier.

### Q3. What is a pepper?

A secret value used as an additional input to password verification and stored separately from the database.

### Q4. Why use salts?

To prevent identical passwords from producing identical stored values and to make precomputed attacks much less effective.

### Q5. Why shouldn't SHA-256 be used directly for passwords?

Because it is designed to be fast, making large numbers of password guesses relatively efficient.

### Q6. Name password hashing algorithms.

```text
Argon2id
bcrypt
scrypt
```

### Q7. Where should a pepper be stored?

Preferably in a secure secrets-management system such as an appropriate KMS, HSM, or secrets manager.

---

# 17. Quick Cheat Sheet

```text
Salt
→ Unique random value
→ Usually stored with verifier
→ Not secret

Pepper
→ Secret additional value
→ Stored separately
→ Must remain secret

Password Storage
→ Password + Salt (+ Pepper where appropriate)
→ Password Hashing Algorithm
→ Stored Verifier

Recommended
→ Argon2id
→ bcrypt
→ scrypt

Avoid
→ Plaintext passwords
→ MD5(password)
→ SHA1(password)
→ SHA256(password)

Salt
→ Defeats precomputed reuse

Pepper
→ Adds protection if database is stolen
```

## Core Mental Model

```text
                  PASSWORD
                      ↓
              ┌───────┴───────┐
              ↓               ↓
            SALT            PEPPER
          Public-ish          Secret
              ↓               ↓
              └───────┬───────┘
                      ↓
            Password Hashing
                      ↓
               Verifier
                      ↓
                  Database

Pepper → Separate Secret Store
```

**Next:** `06-Digital-Signatures.md`