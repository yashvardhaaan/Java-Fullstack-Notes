# `18-Clickjacking.md`

# Clickjacking

## 1. First Principle

**Clickjacking** is an attack where a victim is tricked into clicking on a hidden or disguised element from another website.

The attacker attempts to make the victim believe they are clicking:

```text
"Play Video"
```

while they are actually clicking:

```text
"Delete Account"
```

The core problem:

> **A sensitive webpage can potentially be embedded inside an attacker's page and trick the user into interacting with it.**

---

# 2. How Clickjacking Works

Conceptually:

```text
Victim
  ↓
Attacker Website
  ↓
Invisible/transparent iframe
  ↓
Target Website
```

The target website might contain:

```text
Delete account
Transfer money
Change email
Approve transaction
```

The attacker places the target page underneath a visible interface.

The victim thinks they are clicking the attacker's UI.

---

# 3. Simple Example

Imagine a legitimate website:

```text
https://bank.example/settings
```

with:

```text
[ Delete Account ]
```

An attacker creates:

```text
https://attacker.example
```

and attempts to embed the bank page:

```html
<iframe src="https://bank.example/settings"></iframe>
```

If the target allows framing and the attacker can manipulate the presentation, the victim may unknowingly interact with the embedded page.

---

# 4. Why Authentication Matters

Suppose the victim is already logged into:

```text
https://bank.example
```

The browser may automatically include the victim's authentication state when interacting with the embedded page, depending on the authentication mechanism and browser cookie policies.

Therefore:

```text
Victim logged in
       ↓
Attacker page
       ↓
Embedded trusted website
       ↓
Victim performs unintended action
```

Clickjacking generally relies on **tricking the victim into performing an action**; it does not simply give the attacker the victim's password.

---

# 5. Industry-Level Example

### Admin Panel

A company has:

```text
https://admin.company.com/users
```

An administrator is logged in.

There is a sensitive button:

```text
[ Disable User ]
```

If the admin page can be framed by an attacker-controlled site, an attacker could potentially construct a deceptive page that encourages the administrator to click at a carefully chosen location.

Potential impact:

```text
Clickjacking
    ↓
Administrator interaction
    ↓
Unintended action
    ↓
Account/business impact
```

This is why administrative and financial actions should have strong additional protections.

---

# 6. Main Defense: `Content-Security-Policy`

Modern applications should use:

```http
Content-Security-Policy: frame-ancestors 'none'
```

This means:

> Do not allow this page to be embedded in a frame.

If legitimate embedding is required:

```http
Content-Security-Policy: frame-ancestors 'self'
```

or explicitly trusted origins can be specified.

Example:

```http
Content-Security-Policy: frame-ancestors https://trusted.example
```

This is one of the primary modern defenses against clickjacking.

---

# 7. `X-Frame-Options`

Another important header is:

```http
X-Frame-Options: DENY
```

This prevents framing.

Other value:

```http
X-Frame-Options: SAMEORIGIN
```

allows framing by pages from the same origin.

### Important

For modern applications:

> **CSP `frame-ancestors` is generally the preferred and more flexible control.**

`X-Frame-Options` remains useful as a compatibility defense.

---

# 8. Spring Security Example

For a Spring Boot application using Spring Security:

```java
http
    .headers(headers -> headers
        .frameOptions(frame -> frame.deny())
    );
```

This can produce:

```http
X-Frame-Options: DENY
```

For applications that intentionally allow framing, configure the policy according to the actual trusted origins rather than simply disabling the protection.

---

# 9. Clickjacking vs CSRF

They are related but different.

| Clickjacking | CSRF |
|---|---|
| Tricks the victim into clicking | Tricks browser into sending request |
| Visual deception is central | Request forgery is central |
| Often involves iframe/UI manipulation | Often involves hidden forms/requests |
| User interaction is commonly required | User interaction may not be required |

Mental model:

```text
Clickjacking:
Attacker → Deceptive UI → Victim click → Target action
```

```text
CSRF:
Attacker → Crafted request → Victim browser → Target action
```

A real application can potentially have **both vulnerabilities**.

---

# 10. Same-Origin Policy Connection

Clickjacking does not require the attacker to read the contents of the framed page.

Remember:

> **Reading and interacting are different security boundaries.**

The attacker may be unable to access the iframe's DOM because of the Same-Origin Policy, while still attempting to trick the victim into interacting with the framed page.

This is one reason SOP alone does not prevent clickjacking.

---

# 11. Frame-Busting JavaScript

Older applications sometimes used JavaScript such as:

```javascript
if (window.top !== window.self) {
    window.top.location = window.self.location;
}
```

This is known as **frame busting**.

However, client-side frame-busting is not the preferred security mechanism.

Prefer:

```http
Content-Security-Policy: frame-ancestors 'none'
```

and/or:

```http
X-Frame-Options: DENY
```

because the browser enforces these controls at the security-policy level.

---

# 12. Sensitive Actions Need Defense in Depth

Even with clickjacking protections, sensitive actions should have additional safeguards.

For example:

```text
Delete account
      ↓
Re-authentication
      ↓
Confirmation
      ↓
CSRF protection
      ↓
Authorization
      ↓
Action
```

For financial operations:

```text
Payment
  ↓
Authentication
  ↓
Authorization
  ↓
Transaction confirmation
  ↓
Transaction
```

Clickjacking protection should be one layer, not the only security control.

---

# 13. Small Hands-On Lab

Create a local application:

```text
localhost:8080
```

Create a second page:

```text
localhost:3000
```

Try embedding the first application:

```html
<iframe
    src="http://localhost:8080">
</iframe>
```

Inspect the response headers:

```text
Content-Security-Policy
X-Frame-Options
```

Use browser DevTools:

```text
Network
  ↓
Select page request
  ↓
Response Headers
```

Then configure:

```http
Content-Security-Policy: frame-ancestors 'none'
```

Reload the iframe.

The browser should prevent the page from being framed.

---

# 14. SOC Relevance

SOC analysts may investigate:

```text
Content-Security-Policy violations
Unexpected framing attempts
Suspicious external referrers
Unexpected embedded application traffic
```

Useful logs:

```text
Web server logs
CSP reports
WAF logs
Browser security telemetry
Authentication logs
```

For a suspected attack:

```text
Identify target page
      ↓
Determine whether framing was allowed
      ↓
Check whether victim interaction occurred
      ↓
Check resulting state-changing requests
      ↓
Determine business impact
```

A framing attempt alone does not prove successful exploitation.

---

# 15. Common Developer Mistakes

### ❌ No anti-framing policy

Sensitive pages can potentially be embedded by arbitrary origins.

### ❌ Disabling frame protection globally

For example, unnecessarily removing:

```text
X-Frame-Options
```

### ❌ Relying only on JavaScript frame busting

Server/browser security headers are stronger.

### ❌ Protecting only the homepage

Sensitive pages should also be protected.

### ❌ Forgetting legitimate embedding requirements

Some applications intentionally use iframes.

In that case, define explicit trusted origins:

```http
Content-Security-Policy: frame-ancestors https://trusted.example
```

rather than allowing everyone.

---

# 16. Interview Questions

### Q1. What is Clickjacking?

An attack where a victim is deceived into interacting with a hidden or disguised interface, often involving a framed legitimate website.

### Q2. How do you prevent Clickjacking?

Primarily:

```http
Content-Security-Policy: frame-ancestors 'none'
```

and, where appropriate:

```http
X-Frame-Options: DENY
```

### Q3. Does Same-Origin Policy prevent Clickjacking?

No. SOP prevents unauthorized cross-origin reading/manipulation of the iframe's contents, but it does not by itself prevent framing.

### Q4. Is `X-Frame-Options` still useful?

Yes, especially for compatibility, but CSP `frame-ancestors` provides more flexible modern control.

### Q5. Is Clickjacking the same as CSRF?

No. Clickjacking primarily uses **visual deception and user interaction**, while CSRF primarily abuses the victim browser's authenticated requests.

---

# 17. Quick Cheat Sheet

| Control | Purpose |
|---|---|
| Clickjacking | Tricks user into unintended interaction |
| `<iframe>` | Common framing mechanism |
| CSP | Browser security policy |
| `frame-ancestors` | Controls who can frame a page |
| `X-Frame-Options` | Legacy/compatibility anti-framing header |
| `DENY` | Prevent framing |
| `SAMEORIGIN` | Allow same-origin framing |
| SOP | Restricts cross-origin page access |
| CSRF | Unauthorized state-changing request |

---

# 18. Core Mental Model

```text
Attacker Website
      ↓
Attempts to frame trusted website
      ↓
Victim sees deceptive interface
      ↓
Victim clicks
      ↓
Trusted website receives interaction
```

Defense:

```text
Trusted Website
      ↓
CSP frame-ancestors
      ↓
Browser blocks unauthorized framing
      ↓
Clickjacking prevented
```

**Remember:**

> **If a sensitive page should never appear inside another website, explicitly tell the browser that it must not be framed.**

### Next

`19-Open-Redirect.md`