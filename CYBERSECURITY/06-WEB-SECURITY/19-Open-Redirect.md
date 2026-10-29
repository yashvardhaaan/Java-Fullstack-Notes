# `19-Open-Redirect.md`

# Open Redirect

## 1. First Principle

An **Open Redirect** occurs when a web application redirects users to a URL that an attacker can control.

The core problem:

> **The application should not blindly trust user-controlled redirect destinations.**

Example:

```text
https://example.com/login?next=https://attacker.example
```

If the application redirects without validating `next`:

```text
User
 ↓
example.com
 ↓
attacker.example
```

---

# 2. How Redirects Work

HTTP uses redirect status codes such as:

```http
HTTP/1.1 302 Found
Location: https://example.com/dashboard
```

The browser receives:

```text
302
 ↓
Location header
 ↓
Browser requests new URL
```

Redirects are commonly used for:

```text
Login
Logout
OAuth flows
Payment flows
Language selection
Post-login navigation
URL shortening
```

---

# 3. Vulnerable Example

Suppose:

```text
GET /login?next=/dashboard
```

After successful login:

```text
302 Found
Location: /dashboard
```

This is reasonable.

But if the application accepts:

```text
GET /login?next=https://attacker.example
```

and responds:

```http
Location: https://attacker.example
```

the application has an open redirect.

---

# 4. Why Open Redirect Is Dangerous

Open Redirect is often considered lower severity by itself, but it can become useful in larger attack chains.

Potential abuse includes:

```text
Open Redirect
     ↓
Phishing
```

or:

```text
Open Redirect
     ↓
OAuth redirect manipulation
     ↓
Potential credential/token impact
```

or:

```text
Trusted domain
     ↓
Redirect
     ↓
Malicious destination
```

The trusted domain can make a malicious link appear more legitimate.

---

# 5. Industry-Level Example

### Login System

Suppose:

```text
https://company.example/login?returnUrl=/dashboard
```

The application uses:

```text
returnUrl
```

after authentication.

An attacker creates:

```text
https://company.example/login?returnUrl=https://attacker.example/login
```

The victim sees a URL beginning with:

```text
company.example
```

After interacting with the application, they may be redirected to the attacker-controlled site.

The attacker may use this for phishing or as part of a more complex attack.

---

# 6. Secure Redirects

### Best approach: allow relative paths

Instead of allowing arbitrary URLs:

```text
https://example.com
https://attacker.example
```

allow:

```text
/dashboard
/orders
/profile
```

Example:

```java
if (!returnUrl.startsWith("/")) {
    throw new IllegalArgumentException("Invalid redirect");
}
```

However, simplistic checks like this can still be bypassed depending on how the URL is later parsed.

A proper URL/path parser and allowlist is preferable.

---

# 7. Allowlist Trusted Destinations

If external redirects are genuinely required:

```text
Allowed:
https://trusted.partner.example
https://payments.example
```

Reject everything else.

Conceptually:

```text
User URL
   ↓
Parse
   ↓
Validate scheme
   ↓
Validate host
   ↓
Compare against allowlist
   ↓
Redirect
```

---

# 8. Dangerous Validation

Avoid checking only:

```text
url.contains("example.com")
```

because:

```text
https://example.com.attacker.example
```

contains the string but is not:

```text
example.com
```

Similarly, URL parsing can produce surprising results when applications use poorly designed string checks.

Security decision should be based on the **parsed hostname/origin**, not a substring.

---

# 9. Open Redirect and OAuth

OAuth/OIDC flows use redirect URIs:

```text
User
 ↓
Application
 ↓
Authorization Server
 ↓
redirect_uri
 ↓
Application
```

The authorization server should only redirect to **registered redirect URIs**.

A poorly designed redirect flow can create security problems if attacker-controlled destinations are accepted.

Therefore:

```text
Registered redirect URI
        ↓
Exact/strict validation
        ↓
Authorization response
```

is safer than:

```text
User-controlled redirect URI
```

---

# 10. Open Redirect vs SSRF

These are very different.

| Open Redirect | SSRF |
|---|---|
| Browser is redirected | Server makes request |
| Usually client-side navigation | Server-side network request |
| Attacker controls destination | Attacker influences server destination |
| Commonly used for phishing | Can reach internal services |

Mental model:

```text
Open Redirect:
User → Trusted Website → Attacker Website
```

```text
SSRF:
Attacker → Server → Internal Service
```

---

# 11. Open Redirect vs CSRF

Open Redirect:

```text
User
 ↓
Redirect
 ↓
Another website
```

CSRF:

```text
Attacker
 ↓
Victim browser
 ↓
State-changing request
```

An open redirect can sometimes participate in an attack chain involving other vulnerabilities, but it is not itself CSRF.

---

# 12. Small Hands-On Lab

Create a local endpoint:

```text
GET /redirect?url=/dashboard
```

Safe:

```text
/redirect?url=/dashboard
```

Expected:

```http
302
Location: /dashboard
```

Then test your application design with:

```text
https://example.com
https://attacker.example
```

The objective is to ensure arbitrary external destinations are rejected.

Inspect:

```text
Network
 ↓
302 response
 ↓
Location header
```

Then implement:

```text
✓ Relative-path allowlist
or
✓ Explicit trusted-origin allowlist
```

---

# 13. SOC Relevance

SOC analysts may encounter suspicious URLs such as:

```text
https://company.example/login?next=https://attacker.example
```

Investigate:

```text
Who generated the URL?
Which endpoint performs the redirect?
Was the destination external?
Was the user authenticated?
Was the redirect part of an OAuth flow?
Was there subsequent phishing activity?
```

Open redirects are particularly relevant when investigating phishing campaigns that abuse legitimate domains.

---

# 14. Common Developer Mistakes

### ❌ Trusting `next` directly

```java
return "redirect:" + next;
```

### ❌ Using substring matching

```text
contains("company.com")
```

### ❌ Allowing arbitrary external redirect URLs

If the application doesn't need them, don't support them.

### ❌ Ignoring OAuth redirect validation

Redirect URIs should be tightly controlled.

### ❌ Assuming open redirect is harmless

It can become useful when combined with phishing, OAuth, or other vulnerabilities.

---

# 15. Interview Questions

### Q1. What is an Open Redirect?

A vulnerability where an application redirects users to an attacker-controlled destination.

### Q2. Why is it dangerous?

It can facilitate phishing and can sometimes become part of larger attack chains.

### Q3. How do you prevent it?

Prefer:

```text
Relative paths
```

or use a strict allowlist of trusted destinations.

### Q4. Why is substring validation unsafe?

Because an attacker can register or construct a different hostname that merely contains the trusted string.

### Q5. Where is Open Redirect especially important?

Authentication and OAuth/OIDC redirect flows.

---

# 16. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| Open Redirect | User-controlled redirect destination |
| `Location` | HTTP response header specifying redirect target |
| `301/302/303/307/308` | Common redirect status codes |
| Relative URL | `/dashboard` |
| Allowlist | Explicitly approved destinations |
| OAuth redirect URI | Callback destination used during authorization |
| Main defense | Strict destination validation |

---

# 17. Core Mental Model

```text
User-controlled redirect
        ↓
Parse destination
        ↓
Is it a safe relative path?
        ↓
OR
        ↓
Is the origin explicitly trusted?
        ↓
YES → Redirect
NO  → Reject
```

**Remember:**

> **Never let a user-controlled URL automatically become a redirect destination.**

### Next

`20-Security-Misconfiguration.md`