# Password Encoder

## What is Password Encoder?

A **Password Encoder** is a Spring Security component used to **encrypt (hash)** passwords before storing them in the database and to **verify** passwords during login.

Instead of storing plain-text passwords, Spring Security stores an **encoded (hashed)** version.

> **In simple words:**
>
> A Password Encoder converts a readable password into an unreadable format so that even if the database is compromised, the original password cannot be easily discovered.

---

# Why Do We Need Password Encoder?

Suppose a user registers with:

```
Username : yash

Password : admin123
```

Without Password Encoder

Database

```
Username     Password

yash         admin123
```

Problems:

- Anyone with database access can see passwords.
- High security risk.
- Easy target for attackers.

---

With Password Encoder

Database

```
Username     Password

yash         $2a$10$G9J5P7...
```

Now the original password is hidden.

---

# Plain Text vs Encoded Password

| Plain Text | Encoded Password |
|------------|------------------|
| `admin123` | `$2a$10$G9J5P7L2...` |
| Easy to read | Impossible to understand directly |
| Unsafe | Secure |
| Never store | Recommended |

---

# Password Encoding Flow

```
User

↓

Enter Password

↓

PasswordEncoder

↓

Hash Password

↓

Store in Database
```

During Login

```
User

↓

Enter Password

↓

PasswordEncoder

↓

Compare Hash

↓

Authentication Success
```

---

# What is Hashing?

Hashing converts data into a fixed-length value.

Example:

```
Password

↓

Hash Function

↓

Encoded Password
```

Example

```
admin123

↓

BCrypt

↓

$2a$10$R8GhH1...
```

---

# Can We Decode a Password?

**No.**

Hashing is a **one-way** process.

```
Password

↓

Hash

↓

Stored
```

You **cannot** reverse it back to the original password.

Instead, during login Spring hashes the entered password again and compares both hashes.

---

# How Password Verification Works

Stored Password

```
$2a$10$ABCD123...
```

User enters

```
admin123
```

Spring performs

```
admin123

↓

BCrypt

↓

Generated Hash

↓

Compare

↓

Match?

↓

Login Success
```

---

# PasswordEncoder Interface

Spring Security provides:

```java
public interface PasswordEncoder {

    String encode(CharSequence rawPassword);

    boolean matches(
            CharSequence rawPassword,
            String encodedPassword
    );

}
```

Methods

| Method | Purpose |
|---------|----------|
| `encode()` | Hashes password |
| `matches()` | Verifies password |

---

# BCryptPasswordEncoder

The most commonly used implementation.

```java
PasswordEncoder encoder =
        new BCryptPasswordEncoder();
```

---

# Encoding Password

```java
PasswordEncoder encoder =
        new BCryptPasswordEncoder();

String password = "admin123";

String encodedPassword =
        encoder.encode(password);

System.out.println(encodedPassword);
```

Output

```
$2a$10$dK8HnP1...
```

Each execution generates a **different hash**.

---

# Why Does BCrypt Generate Different Hashes?

Because BCrypt uses a **random salt**.

Example

First encoding

```
admin123

↓

$2a$10$ABCD...
```

Second encoding

```
admin123

↓

$2a$10$XYZ...
```

Different hashes,

but both represent the same password.

---

# Verifying Password

```java
PasswordEncoder encoder =
        new BCryptPasswordEncoder();

String rawPassword = "admin123";

String encodedPassword =
        encoder.encode(rawPassword);

boolean result = encoder.matches(

        rawPassword,

        encodedPassword

);

System.out.println(result);
```

Output

```
true
```

---

# Configuring Password Encoder

```java
@Configuration
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {

        return new BCryptPasswordEncoder();

    }

}
```

Now Spring manages the PasswordEncoder bean.

---

# Using PasswordEncoder During Registration

```java
@Service
public class UserService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    public void register(User user) {

        user.setPassword(

                passwordEncoder.encode(

                        user.getPassword()

                )

        );

        repository.save(user);

    }

}
```

Password is encoded before saving.

---

# Using PasswordEncoder During Login

```
User Login

↓

Username

↓

Password

↓

Load User

↓

Compare Password

↓

Authentication Success
```

Spring internally calls

```java
passwordEncoder.matches(

        rawPassword,

        encodedPassword

);
```

---

# Common Password Encoders

| Encoder | Recommended |
|----------|-------------|
| BCryptPasswordEncoder | ✅ Yes |
| NoOpPasswordEncoder | ❌ No |
| Pbkdf2PasswordEncoder | ✅ Yes |
| SCryptPasswordEncoder | ✅ Yes |
| Argon2PasswordEncoder | ✅ Best for modern applications |

---

# BCrypt vs NoOp

| BCrypt | NoOp |
|---------|------|
| Encrypts passwords | Stores plain text |
| Secure | Not secure |
| Recommended | Only for testing |
| Production Ready | Never use in production |

---

# Password Encoding Architecture

```
User

↓

Registration

↓

PasswordEncoder

↓

BCrypt Hash

↓

Database
```

Login

```
User

↓

Enter Password

↓

PasswordEncoder.matches()

↓

Database Hash

↓

Authentication Result
```

---

# Real-World Example

## Banking Application

```
Customer

↓

Create Account

↓

PasswordEncoder

↓

Encrypted Password

↓

Database
```

---

## E-Commerce Website

```
Customer

↓

Register

↓

Encode Password

↓

Save User
```

---

## College Portal

```
Student

↓

Sign Up

↓

PasswordEncoder

↓

Database
```

---

# Advantages

- Protects user passwords.
- Prevents plain-text password storage.
- Integrates seamlessly with Spring Security.
- Supports multiple encoding algorithms.
- Makes applications more secure.

---

# Best Practices

- Always use `BCryptPasswordEncoder` or `Argon2PasswordEncoder`.
- Never store passwords in plain text.
- Never compare passwords manually.
- Let Spring Security handle password verification.
- Do not expose encoded passwords in API responses.
- Use a strong password policy for users.

---

# Interview Questions

### 1. What is PasswordEncoder?

PasswordEncoder is a Spring Security interface used to hash passwords and verify them during authentication.

---

### 2. Why should passwords be encoded?

To protect user credentials and prevent attackers from reading passwords if the database is compromised.

---

### 3. Which PasswordEncoder is most commonly used?

```java
BCryptPasswordEncoder
```

---

### 4. Can an encoded password be decoded?

No. Password hashing is a one-way process.

---

### 5. Which methods are provided by the PasswordEncoder interface?

```java
encode()

matches()
```

---

### 6. Why does BCrypt generate different hashes for the same password?

Because it uses a **random salt** for every encoding.

---

### 7. Should we compare passwords using `equals()`?

No.

Always use:

```java
passwordEncoder.matches(
        rawPassword,
        encodedPassword
);
```

---

# Quick Revision

- PasswordEncoder securely hashes passwords before storing them.
- Never store plain-text passwords.
- `BCryptPasswordEncoder` is the most commonly used implementation.
- Use `encode()` to hash passwords.
- Use `matches()` to verify passwords.
- BCrypt generates different hashes because it uses a random salt.
- Passwords are **hashed**, not encrypted, so they cannot be decoded.
- Always register `PasswordEncoder` as a Spring Bean and use it during user registration and login.