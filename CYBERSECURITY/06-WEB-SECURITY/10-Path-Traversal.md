# `10-Path-Traversal.md`

# Path Traversal

## 1. First Principle

**Path Traversal** occurs when an attacker manipulates a file path supplied by the user to access files outside the application's intended directory.

The core problem:

> **User-controlled input must never be allowed to freely determine which filesystem path the server accesses.**

Example:

```text
https://example.com/download?file=report.pdf
```

Expected:

```text
/app/files/report.pdf
```

Attacker-controlled input might attempt:

```text
../../../../etc/passwd
```

Resulting path:

```text
/app/files/../../../../etc/passwd
```

which may resolve outside `/app/files`.

---

# 2. How Path Traversal Works

Typical vulnerable code:

```java
String filename = request.getParameter("file");

File file = new File("/app/uploads/" + filename);
```

The developer expects:

```text
file=photo.jpg
```

But the application accepts:

```text
file=../../secret.txt
```

The filesystem resolves:

```text
/app/uploads/../../secret.txt
```

to a location outside the intended directory.

### Common traversal sequences

```text
../
../../
../../../
```

Windows:

```text
..\ 
..\..\
```

Encoded forms may also appear:

```text
%2e%2e%2f
%2e%2e/
```

Attackers may use encoding to bypass simplistic filters.

---

# 3. Important Concepts

### `..`

Means:

```text
parent directory
```

Example:

```text
/home/app/uploads/../config.txt
```

becomes:

```text
/home/app/config.txt
```

### `.`

Means:

```text
current directory
```

### Absolute paths

Linux:

```text
/etc/passwd
```

Windows:

```text
C:\Windows\System32\
```

### Canonicalization

Converting different path representations into their normalized filesystem path.

Java:

```java
Path path = Paths.get(userInput).normalize();
```

But **normalization alone is not sufficient**. You must verify that the normalized path remains inside the intended directory.

---

# 4. Secure Implementation

Suppose files should only come from:

```text
/app/uploads
```

Use a trusted base directory:

```java
Path base = Paths.get("/app/uploads").toAbsolutePath().normalize();

Path requested = base.resolve(filename).normalize();

if (!requested.startsWith(base)) {
    throw new SecurityException("Invalid file path");
}
```

Then access the file:

```java
Files.readAllBytes(requested);
```

### Mental model

```text
User input
    ↓
Resolve against trusted base
    ↓
Normalize
    ↓
Check startsWith(base)
    ↓
Access file
```

---

# 5. Better Design: Use File IDs

Instead of allowing:

```text
/download?file=../../secret.txt
```

prefer:

```text
/download?id=83921
```

Backend:

```text
83921
 ↓
Database lookup
 ↓
Trusted internal filename/path
 ↓
Authorization check
 ↓
File access
```

This is generally safer than allowing arbitrary filenames.

---

# 6. Industry-Level Example

### Document Management System

A company has:

```text
GET /api/documents/download?file=invoice.pdf
```

The application stores:

```text
/var/app/documents/
```

Vulnerable implementation:

```java
Path path = Paths.get("/var/app/documents/" + file);
return Files.readAllBytes(path);
```

An attacker attempts to access:

```text
../../application.properties
```

Potential result:

```text
/var/app/application.properties
```

If the application can read it, sensitive configuration could be exposed.

Possible contents:

```text
spring.datasource.url=...
spring.datasource.username=...
API_KEY=...
```

The exact impact depends on permissions and what files are accessible.

---

# 7. Path Traversal vs File Upload

These are different vulnerabilities.

### Path Traversal

Attacker controls **where the application reads/writes**.

```text
/download?file=../../secret.txt
```

### Unrestricted File Upload

Attacker controls **what file gets uploaded**.

```text
/upload
```

A system can potentially have both vulnerabilities.

---

# 8. Path Traversal in File Uploads

Dangerous:

```java
Path destination =
    Paths.get("/uploads/" + userProvidedFilename);
```

An attacker-controlled filename could attempt to escape:

```text
../../some-location/file.txt
```

Secure applications should:

- Generate their own filenames.
- Store uploads outside sensitive application directories.
- Validate file type/content.
- Restrict permissions.
- Use a trusted storage abstraction.

Example:

```text
original filename:
profile.jpg

stored filename:
8f2a91c4-7b21-4c9a.jpg
```

The application doesn't need to trust the user's filename.

---

# 9. Authorization Still Matters

Even a valid path can expose another user's file.

Example:

```text
/download?id=1002
```

User A requests User B's document.

This is primarily an **authorization / IDOR/BOLA** problem.

Correct flow:

```text
Request
  ↓
Authenticate user
  ↓
Find requested resource
  ↓
Check ownership/authorization
  ↓
Resolve safe path
  ↓
Return file
```

Path validation and authorization solve different problems.

---

# 10. Common Developer Mistakes

### ❌ String concatenation

```java
"/uploads/" + filename
```

### ❌ Only checking for `../`

```java
if (filename.contains("../")) {
    reject();
}
```

This is not a reliable security boundary because path representations can vary.

### ❌ Relying only on URL encoding filters

Attackers may use alternate representations.

### ❌ Normalizing without containment check

```java
path.normalize();
```

Normalization does not automatically make a path safe.

### ❌ Trusting filenames

User-provided filenames should be treated as untrusted input.

---

# 11. Small Hands-On Lab

Create:

```text
security-lab/
├── files/
│   ├── public.txt
│   └── secret.txt
└── app/
```

Imagine the application is supposed to serve only:

```text
files/public.txt
```

Test how path resolution behaves with:

```text
public.txt
../secret.txt
../../secret.txt
```

In Java:

```java
Path base = Paths.get("files").toAbsolutePath().normalize();

String filename = "../secret.txt";

Path requested = base.resolve(filename).normalize();

System.out.println("Base: " + base);
System.out.println("Requested: " + requested);
System.out.println("Allowed: " + requested.startsWith(base));
```

The important security check is:

```java
requested.startsWith(base)
```

If `false`:

```text
Reject request
```

---

# 12. SOC Relevance

SOC analysts may see suspicious requests such as:

```text
GET /download?file=../../../../etc/passwd
```

or encoded variants.

Useful investigation questions:

```text
Which endpoint was targeted?
What parameter contained traversal?
Was the request successful?
What HTTP status was returned?
What file was accessed?
What process handled the request?
Did sensitive data leave the server?
Were multiple traversal attempts observed?
```

### Example detection

```text
GET /download?file=../../../../etc/passwd
            ^^^^^^^^^^^^^^^^^^^^^^^
            suspicious path traversal
```

A single request may be reconnaissance or a blocked attempt; multiple successful accesses with data exfiltration are more concerning.

---

# 13. Interview Questions

### Q1. What is Path Traversal?

An attack where user-controlled path input allows access outside the application's intended filesystem directory.

### Q2. What does `../` mean?

It refers to the parent directory.

### Q3. How do you prevent Path Traversal?

Use a trusted base directory, normalize the resolved path, verify it remains inside the base directory, and preferably avoid accepting arbitrary filesystem paths.

### Q4. Is input validation enough?

No. Validation is useful as defense-in-depth, but filesystem containment and authorization are more important.

### Q5. Does `normalize()` make a path secure?

No.

You must verify:

```java
normalizedPath.startsWith(trustedBase)
```

### Q6. Path Traversal vs IDOR?

**Path Traversal:** manipulating filesystem paths.

**IDOR/BOLA:** accessing another user's resource by manipulating an object identifier.

---

# 14. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| `..` | Parent directory |
| `.` | Current directory |
| Path Traversal | Escape intended filesystem directory |
| Canonicalization | Resolve path to normalized representation |
| `normalize()` | Simplifies path components |
| `startsWith(base)` | Containment check |
| File ID | Safer alternative to arbitrary filenames |
| IDOR/BOLA | Unauthorized resource access |
| Secure filename | Prefer server-generated names |

---

# 15. Core Mental Model

Remember:

```text
User input
    ↓
Never trust it as a filesystem path
    ↓
Trusted base directory
    ↓
Resolve
    ↓
Normalize
    ↓
Verify containment
    ↓
Authorization check
    ↓
Access file
```

**Best principle:**

> Don't let the user choose an arbitrary filesystem location.

---

## Next

```text
11-...
```

The next Web Security topic in your sequence is the one following **Path Traversal**.