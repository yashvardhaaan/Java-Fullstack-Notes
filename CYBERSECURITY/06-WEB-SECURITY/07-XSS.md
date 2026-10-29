# `07-XSS.md`

# Cross-Site Scripting (XSS)

## 1. First Principle

**XSS occurs when attacker-controlled content is interpreted by a browser as executable code instead of ordinary data.**

Mental model:

```text
Attacker Input
     ↓
Web Application
     ↓
Unsafe Output
     ↓
Browser
     ↓
Unexpected JavaScript Execution
```

The core problem is:

> **Untrusted data is treated as executable content.**

---

# 2. Why XSS Is Dangerous

Depending on the application's architecture, successful XSS can allow an attacker to:

```text
Read sensitive page data
Perform actions as the victim
Modify page content
Steal non-HttpOnly tokens/data
Interact with APIs available to the page
Phish the user inside a trusted origin
```

XSS is especially dangerous because the malicious code executes in the **security context of the vulnerable website**.

---

# 3. Main Types of XSS

There are three important categories:

```text
Stored XSS
Reflected XSS
DOM-based XSS
```

---

# 4. Stored XSS

The malicious input is stored by the application and later displayed to users.

Example:

```text id="x4z7k3"
Attacker
   ↓
Comment field
   ↓
Database
   ↓
Application displays comment
   ↓
Victim's browser
   ↓
Script executes
```

Common locations:

```text
Comments
Profiles
Forum posts
Product reviews
Support tickets
Chat messages
```

Stored XSS can be particularly serious because multiple users may encounter the malicious content.

---

# 5. Reflected XSS

The malicious input comes from the request and is immediately reflected into the response.

Example:

```text id="2ly6wt"
Search:
https://example.com/search?q=<input>
```

Application:

```text
Search results for: <input>
```

If the application places the input into HTML unsafely, the browser may interpret it as markup/code.

Flow:

```text id="v7q8v3"
Attacker-controlled URL
        ↓
Server
        ↓
Reflected into HTML
        ↓
Victim Browser
```

---

# 6. DOM-Based XSS

DOM XSS can occur entirely in client-side JavaScript.

Example concept:

```javascript id="q7b8jm"
const value = location.hash.substring(1);

document.getElementById("output").innerHTML = value;
```

If attacker-controlled data reaches an unsafe DOM sink:

```text id="l2az4a"
URL Input
   ↓
JavaScript
   ↓
innerHTML
   ↓
Browser interprets content
```

The server may never see the malicious input.

---

# 7. Source and Sink

A useful way to understand DOM XSS is:

### Source

Where attacker-controlled data enters:

```text id="k6f6lo"
location
URL parameters
document.referrer
postMessage data
Web storage
```

### Sink

Where data is interpreted unsafely:

```text id="7d3c3w"
innerHTML
outerHTML
document.write()
eval()
```

Mental model:

```text id="5g5j3m"
Untrusted Source
      ↓
Data flows through code
      ↓
Dangerous Sink
      ↓
XSS
```

---

# 8. Safe vs Unsafe DOM Manipulation

Potentially unsafe:

```javascript id="5jap2k"
element.innerHTML = userInput;
```

Safer for plain text:

```javascript id="f0u8s7"
element.textContent = userInput;
```

The difference is important:

```text id="6pk5ps"
innerHTML
→ Interprets HTML

textContent
→ Treats content as text
```

---

# 9. Industry Example — Product Review

Suppose an e-commerce application allows:

```text
Product Review:
"Great product!"
```

The application stores it and later renders reviews.

If the application does not properly encode/sanitize untrusted content:

```text id="2x9q4z"
Attacker input
      ↓
Database
      ↓
Product page
      ↓
Victim browser
```

This can become stored XSS.

The impact may extend to users with privileged roles, making stored XSS particularly important in admin interfaces.

---

# 10. XSS and Cookies

Suppose an application uses:

```http
Set-Cookie: session=abc123; HttpOnly; Secure
```

`HttpOnly` prevents normal JavaScript from directly reading the cookie.

Therefore:

```javascript
document.cookie
```

cannot normally access an `HttpOnly` session cookie.

But:

> **HttpOnly does not make XSS harmless.**

Injected JavaScript may still perform actions that the page itself is authorized to perform.

Therefore the correct defense is to **prevent XSS**, not simply rely on `HttpOnly`.

---

# 11. XSS and CSRF

XSS and CSRF can interact.

For example:

```text id="q9g4ts"
XSS
 ↓
Malicious JavaScript executes
 ↓
Application requests
 ↓
CSRF protections may be undermined
```

A successful XSS vulnerability can therefore have a broader impact than a standalone CSRF issue.

This is one reason input handling and output encoding are so important.

---

# 12. Output Encoding

One of the most important XSS defenses is **context-aware output encoding**.

If user input should appear as plain HTML text:

```text id="gk0qnd"
User Input
   ↓
HTML encoding
   ↓
Browser displays as text
```

For example, characters such as:

```text id="4m0nbe"
<
>
"
'
&
```

may need appropriate encoding depending on the output context.

---

# 13. Context Matters

Encoding must match where the data is inserted.

Different contexts include:

```text id="w7xqk5"
HTML body
HTML attribute
JavaScript
CSS
URL
```

A value safely encoded for one context may not be safe for another.

Therefore:

> Use framework-provided contextual escaping rather than manually creating your own encoding scheme.

---

# 14. Input Validation vs Output Encoding

These are not the same.

### Input validation

Checks whether input follows expected rules.

Example:

```text
Username:
Only letters, numbers, underscore
```

### Output encoding

Ensures data is safely represented in its output context.

A strong design commonly uses both:

```text id="q8j8dj"
Validate input
      +
Encode output
```

---

# 15. Sanitization

Sometimes an application intentionally allows HTML.

For example:

```text id="jv6y0p"
Rich-text editor
```

Simply escaping all HTML would destroy the intended formatting.

A sanitizer can remove dangerous constructs while allowing a controlled subset of HTML.

Use a **well-tested sanitization library** rather than writing your own HTML sanitizer.

---

# 16. Content Security Policy

**CSP** is an additional browser security layer.

Example:

```http id="l1t7sa"
Content-Security-Policy:
default-src 'self';
script-src 'self'
```

A CSP can restrict where scripts and other resources may be loaded from.

Conceptually:

```text id="fr0zj5"
XSS vulnerability
      ↓
Injected script attempts execution
      ↓
CSP policy
      ↓
Browser may block it
```

CSP is **defense in depth**, not a replacement for fixing the XSS vulnerability.

---

# 17. Industry Example — React

Modern frameworks such as React automatically escape many values rendered through normal JSX.

Example:

```jsx id="m0u2jc"
<div>{userInput}</div>
```

Normally, user input is treated as text rather than arbitrary HTML.

But developers can bypass these protections.

For example:

```jsx id="n7q0ax"
<div dangerouslySetInnerHTML={{__html: userInput}} />
```

This should only be used with appropriately sanitized trusted content.

Framework security features help, but developers can still introduce vulnerabilities.

---

# 18. Industry Example — Spring Boot + Thymeleaf

A server-side application might render:

```html
<p th:text="${username}"></p>
```

This is designed for text output.

Developers should be careful with mechanisms intended to render raw HTML.

General principle:

```text id="cvp6c8"
Default escaping
→ Prefer

Raw HTML rendering
→ Only with controlled/sanitized content
```

---

# 19. Small Hands-On Lab

Use an application you own or a deliberately vulnerable training application.

Create a simple input:

```text id="r9m3bq"
Name: <test>
```

Display it using:

```javascript id="2q2w3r"
element.textContent = input;
```

Observe that it appears as text.

Then understand the difference with:

```javascript id="8l9qgk"
element.innerHTML = input;
```

Do **not** test malicious payloads against systems you do not own or have explicit authorization to assess.

The goal is to understand the unsafe data flow:

```text id="r7a5n3"
User Input
   ↓
DOM Sink
   ↓
Browser Interpretation
```

---

# 20. XSS Testing Methodology

When reviewing an application you are authorized to test:

```text id="r3z1o4"
1. Identify user-controlled input
2. Track where it is stored
3. Find where it is rendered
4. Determine the output context
5. Check whether framework escaping occurs
6. Identify dangerous DOM sinks
7. Check sanitization where HTML is intentionally allowed
8. Review CSP as defense in depth
```

Focus on **data flow**, not memorizing payloads.

---

# 21. SOC Relevance

SOC analysts may investigate:

```text id="s3m5kg"
Suspicious script execution
Unexpected DOM changes
CSP violation reports
Web application alerts
Compromised user sessions
Malicious content stored in application fields
```

Example:

```text id="5s8r2a"
Attacker submits suspicious content
        ↓
Application stores it
        ↓
Admin opens affected page
        ↓
Unexpected script execution
        ↓
Potential account compromise
```

Correlate:

```text id="p2o3kq"
Web logs
+
Application logs
+
Authentication events
+
CSP reports
+
Endpoint/browser telemetry
```

---

# 22. Common Mistakes

### ❌ Trusting user input

All external input should be considered untrusted.

### ❌ Using `innerHTML` unnecessarily

Prefer:

```javascript
textContent
```

for plain text.

### ❌ Disabling framework escaping

Only bypass escaping when there is a clear, controlled requirement.

### ❌ Relying only on CSP

CSP is defense in depth.

### ❌ Assuming HttpOnly prevents XSS

It only prevents normal JavaScript access to the cookie.

### ❌ Writing your own HTML sanitizer

Use established security libraries.

---

# 23. Interview Questions

### Q1. What is XSS?

A vulnerability where attacker-controlled content is executed/interpreted as code in a victim's browser.

### Q2. Types of XSS?

```text
Stored
Reflected
DOM-based
```

### Q3. Stored vs reflected XSS?

```text
Stored
→ Malicious input persists in the application

Reflected
→ Input is reflected immediately in a response
```

### Q4. What is DOM XSS?

XSS caused by unsafe client-side handling of attacker-controlled data.

### Q5. How do you prevent XSS?

```text
Output encoding
+
Safe DOM APIs
+
Input validation
+
HTML sanitization where required
+
CSP
```

### Q6. Does HttpOnly prevent XSS?

No. It prevents normal JavaScript access to the cookie but does not prevent script execution.

### Q7. What is CSP?

A browser security policy restricting which resources/scripts a page can load or execute.

---

# 24. Quick Cheat Sheet

```text
XSS
→ Untrusted data becomes executable content

Types
→ Stored
→ Reflected
→ DOM-based

Source
→ Attacker-controlled data

Sink
→ Dangerous operation receiving that data

Safer DOM
→ textContent

Risky DOM
→ innerHTML

Defenses
→ Output encoding
→ Input validation
→ Sanitization
→ Safe framework APIs
→ CSP

HttpOnly
→ Protects cookie from normal JS access
→ Does NOT prevent XSS
```

## Core Mental Model

```text
              UNTRUSTED INPUT
                     ↓
              Application Code
                     ↓
            ┌────────┴────────┐
            ↓                 ↓
      Safe Handling       Unsafe Sink
            ↓                 ↓
        Plain Text            XSS
                              ↓
                     Browser Executes
                     Attacker Content
```

**Next:** `08-SQL-Injection.md`