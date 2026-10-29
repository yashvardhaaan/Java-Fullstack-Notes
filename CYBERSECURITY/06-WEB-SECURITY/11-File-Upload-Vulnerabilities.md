# `11-File-Upload-Vulnerabilities.md`

# File Upload Vulnerabilities

## 1. First Principle

File upload functionality allows users to send files to a server.

The security problem is:

> **Never trust an uploaded file simply because the user says what type it is.**

Example:

```text
Browser
   ↓
POST /upload
   ↓
Web Server
   ↓
File Storage
```

An attacker may try to upload:

- Malicious scripts
- Executable files
- Oversized files
- Files with misleading extensions
- Files designed to overwrite existing files
- Malicious HTML/SVG content

---

# 2. How File Upload Works

Typical request:

```http
POST /upload
Content-Type: multipart/form-data
```

The server receives:

```text
filename = profile.jpg
content = image bytes
```

A vulnerable application might simply do:

```java
Path path = Paths.get("/uploads/" + filename);
Files.copy(inputStream, path);
```

This trusts:

```text
filename
file extension
file content
storage location
```

All of these require security controls.

---

# 3. Major File Upload Risks

### 1. Unrestricted file type

Application accepts:

```text
.exe
.jsp
.php
.html
.svg
```

when it only intended images.

### 2. Path traversal

Filename:

```text
../../important.txt
```

can attempt to escape the upload directory.

### 3. Stored XSS

Uploading malicious HTML/SVG and serving it from the application's origin can potentially execute JavaScript in a victim's browser.

### 4. Malware storage

The server can become a malware-hosting location.

### 5. DoS

Extremely large or resource-intensive files can consume:

```text
Disk
CPU
Memory
Bandwidth
```

### 6. File overwrite

Predictable filenames may allow one upload to overwrite another.

---

# 4. Extension Validation

A weak approach:

```java
if (filename.endsWith(".jpg")) {
    allow();
}
```

This should **not** be your primary security boundary.

Attackers may manipulate filenames or extensions.

Instead, combine:

```text
Extension validation
+
MIME/content validation
+
File signature validation
+
Size limits
+
Safe storage
```

---

# 5. MIME Type vs File Signature

### MIME type

Example:

```text
image/jpeg
image/png
application/pdf
```

But MIME information can sometimes be supplied or influenced by the client.

### File signature / magic bytes

Many file formats begin with recognizable bytes.

For example, JPEG files commonly begin with:

```text
FF D8 FF
```

Therefore:

```text
Filename
   ↓
MIME type
   ↓
File signature
   ↓
Application-specific validation
```

Using multiple checks provides stronger defense.

---

# 6. Generate Server-Side Filenames

Avoid storing files using the original filename:

```text
profile.jpg
```

Prefer:

```text
8f7c2d91-3a2e-4e21.jpg
```

For example:

```java
String storedName = UUID.randomUUID() + ".jpg";
```

Benefits:

- Prevents filename collisions
- Reduces path manipulation risk
- Hides original filenames
- Makes predictable file replacement harder

The original filename can be stored separately as metadata if needed.

---

# 7. Store Uploads Outside Executable Locations

A safer architecture:

```text
Application
    ↓
Upload validation
    ↓
Object storage / dedicated file storage
```

For example:

```text
Application
   ↓
S3 / Blob Storage
```

rather than:

```text
Application
   ↓
Web server executable directory
```

The uploaded file should ideally **not be directly executable by the web server**.

---

# 8. Industry-Level Example

### E-Commerce Profile Image

User uploads:

```text
profile.jpg
```

Secure flow:

```text
Upload
 ↓
Authentication
 ↓
Authorization
 ↓
Size check
 ↓
File type validation
 ↓
Content/signature validation
 ↓
Generate random filename
 ↓
Store outside executable web directory
 ↓
Serve safely
```

Example:

```text
Original:
my-photo.jpg

Stored:
f82a1c7d-91e2-4f0a.jpg
```

Database:

```text
user_id | original_name | stored_name
101     | my-photo.jpg  | f82a1c7d-91e2-4f0a.jpg
```

---

# 9. Upload Authorization

Validation alone is not enough.

Consider:

```http
POST /users/1001/profile
```

User A should not be able to upload files into User B's account.

Correct flow:

```text
Authenticate
    ↓
Identify user
    ↓
Check authorization
    ↓
Validate file
    ↓
Store file
```

---

# 10. File Size Limits

Always establish limits.

Example:

```text
Profile image: 5 MB
PDF document: 20 MB
```

Enforce limits at multiple layers where appropriate:

```text
Reverse proxy
      ↓
Web server
      ↓
Application
      ↓
Storage
```

This reduces resource-exhaustion attacks.

---

# 11. Safe Storage Architecture

A production architecture could look like:

```text
                Internet
                   ↓
             Reverse Proxy
                   ↓
              Web Server
                   ↓
           Upload Validation
             ↙          ↘
        Antivirus       Metadata
             ↓
          Storage
             ↓
       Object Storage
```

For sensitive environments, uploaded files may also be scanned asynchronously before becoming available.

---

# 12. File Upload + Path Traversal

These vulnerabilities can combine.

Dangerous:

```java
Path path = Paths.get("/uploads/" + filename);
```

An attacker-controlled filename could attempt:

```text
../../some-file
```

Safer:

```java
Path base = Paths.get("/uploads")
                 .toAbsolutePath()
                 .normalize();

Path target = base.resolve(filename).normalize();

if (!target.startsWith(base)) {
    throw new SecurityException("Invalid filename");
}
```

Even better:

> Generate the storage filename yourself.

---

# 13. File Upload + XSS

Suppose the application allows:

```text
.svg
.html
```

and serves uploaded files from:

```text
https://example.com/uploads/
```

A malicious HTML/SVG file could potentially execute browser-side code when opened.

Therefore:

- Don't allow unnecessary active content.
- Use correct `Content-Type`.
- Consider `Content-Disposition: attachment`.
- Store untrusted content on a separate origin when appropriate.
- Apply appropriate browser security headers.

---

# 14. Spring Boot Example

For a profile image:

```java
@PostMapping("/profile")
public ResponseEntity<?> upload(
        @RequestParam("file") MultipartFile file) {

    if (file.isEmpty()) {
        return ResponseEntity.badRequest().build();
    }

    if (file.getSize() > 5 * 1024 * 1024) {
        return ResponseEntity.badRequest().build();
    }

    String storedName = UUID.randomUUID() + ".jpg";

    // Validate actual content before storing
    // Store in dedicated storage

    return ResponseEntity.ok().build();
}
```

The important part is that **file validation must happen before trusting or storing the file**.

---

# 15. Small Hands-On Lab

Build a local Spring Boot endpoint:

```http
POST /upload
```

Test with:

```text
photo.jpg
document.pdf
large-file
wrong-extension
```

Observe:

```text
Filename
Content-Type
File size
File signature
Storage filename
Storage location
```

Implement these controls:

```text
✓ Maximum file size
✓ Allowed file types
✓ Content validation
✓ Random server-generated filename
✓ Dedicated upload directory
✓ Path containment
```

Then inspect the resulting files on disk.

---

# 16. SOC Relevance

SOC analysts should investigate suspicious upload activity such as:

```text
POST /upload
```

followed by:

```text
.exe
.jsp
.php
.svg
.html
```

or unusually large files.

Look for:

```text
Repeated upload attempts
Unusual extensions
Large uploads
Uploads followed by HTTP requests to the uploaded file
Unexpected server-side processes
Outbound network connections
Multiple failed validation attempts
```

A particularly important sequence is:

```text
Upload suspicious file
       ↓
Request uploaded file
       ↓
Server executes unexpected process
```

That can indicate a serious compromise.

---

# 17. Common Developer Mistakes

### ❌ Trusting extension

```text
.jpg = automatically safe
```

### ❌ Trusting `Content-Type`

```text
Content-Type: image/jpeg
```

does not by itself prove the content is a JPEG.

### ❌ Keeping original filename

```text
../../file.txt
```

can create additional risk.

### ❌ Storing uploads in executable directories

This increases the potential impact of malicious uploads.

### ❌ No size limit

Can lead to resource exhaustion.

### ❌ No authorization

Any authenticated user may potentially upload into another user's resources.

---

# 18. Interview Questions

### Q1. What are the major risks of file uploads?

Unrestricted file types, malware, XSS, path traversal, file overwrite, and resource exhaustion.

### Q2. Why is checking `.jpg` enough?

It isn't. Extensions can be manipulated.

### Q3. What is a safer filename strategy?

Generate a server-side random identifier such as a UUID.

### Q4. Where should uploaded files be stored?

Prefer dedicated/object storage or a non-executable location isolated from application code.

### Q5. Why are file signatures useful?

They provide information about the actual file format rather than relying only on user-controlled metadata.

### Q6. How can file upload cause XSS?

If active content such as HTML/SVG is uploaded and later served in a browser under a trusted origin.

---

# 19. Quick Cheat Sheet

| Control | Purpose |
|---|---|
| Authentication | Identify uploader |
| Authorization | Ensure user can upload there |
| Extension allowlist | Restrict expected formats |
| MIME validation | Additional type check |
| Magic-byte validation | Check actual file format |
| Size limit | Prevent resource exhaustion |
| Random filename | Prevent collisions/path manipulation |
| Dedicated storage | Isolate uploads |
| Non-executable storage | Prevent server-side execution |
| Malware scanning | Detect malicious content |
| Separate origin | Reduce browser-side impact |

---

# 20. Core Mental Model

```text
Untrusted File
      ↓
Authenticate
      ↓
Authorize
      ↓
Size validation
      ↓
Type/content validation
      ↓
Generate safe filename
      ↓
Store outside executable application paths
      ↓
Serve safely
```

**Remember:**

> **A file upload is not just a file-transfer feature; it is an input-validation and storage-security boundary.**

### Next

```text
12-SSRF.md
```