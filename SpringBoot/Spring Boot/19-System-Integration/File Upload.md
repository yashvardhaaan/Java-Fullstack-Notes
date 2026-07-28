# File Upload

## What is File Upload?

**File Upload** is the process of allowing users to send files from their device to a server.

Common examples include:

- Profile Pictures
- Documents
- PDFs
- Videos
- Images
- Excel Files
- ZIP Files

> **In simple words:**
>
> File Upload allows users to transfer files from their computer or mobile device to your application.

---

# Why Do We Need File Upload?

Imagine a job portal.

Without File Upload

```
Candidate

↓

Cannot Upload Resume

↓

Application Incomplete
```

---

With File Upload

```
Candidate

↓

Upload Resume

↓

Server Stores File

↓

Recruiter Downloads Resume
```

---

# Real-World Example

When updating your WhatsApp profile picture,

```
Choose Image

↓

Upload

↓

Server Stores Image

↓

Visible to Friends
```

This is File Upload.

---

# File Upload Architecture

```
Client

↓

Controller

↓

Service

↓

Storage

↓

Database (Metadata)
```

---

# How File Upload Works

```
User Selects File

↓

Browser Sends Request

↓

Spring Boot Receives File

↓

Validate File

↓

Store File

↓

Return Success
```

---

# Multipart Request

Files are uploaded using

```
multipart/form-data
```

Example

```
POST /upload

Content-Type:

multipart/form-data
```

---

# Required Dependency

Spring Boot Web already supports file uploads.

No additional dependency is required beyond:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

---

# MultipartFile

Spring Boot represents uploaded files using

```java
MultipartFile
```

It provides methods like:

- `getOriginalFilename()`
- `getContentType()`
- `getSize()`
- `getBytes()`
- `transferTo()`

---

# Controller Example

```java
@RestController
public class FileController {

    @PostMapping("/upload")
    public String upload(

            @RequestParam MultipartFile file

    ){

        return file.getOriginalFilename();

    }

}
```

---

# Service Example

```java
@Service
public class FileService {

    public void upload(

            MultipartFile file

    ) throws IOException {

        Path path = Path.of(

                "uploads",

                file.getOriginalFilename()

        );

        Files.copy(

                file.getInputStream(),

                path

        );

    }

}
```

---

# Request Flow

```
Client

↓

Select File

↓

Multipart Request

↓

Controller

↓

Service

↓

Storage

↓

Response
```

---

# File Storage Options

## Local Storage

```
Application

↓

uploads/

↓

image.jpg
```

Suitable for development and small applications.

---

## Database

```
Application

↓

Database

↓

BLOB
```

Stores file data directly in the database.

Suitable for small files.

---

## Cloud Storage

```
Application

↓

AWS S3

↓

Azure Blob

↓

Google Cloud Storage
```

Best for production systems.

---

# Validation

Always validate uploaded files.

Common validations

- File Size
- File Type
- File Name
- MIME Type
- Virus Scan

Example

```java
if(file.isEmpty()){

    throw new RuntimeException(

            "File is empty"

    );

}
```

---

# Limiting File Size

```properties
spring.servlet.multipart.max-file-size=10MB

spring.servlet.multipart.max-request-size=20MB
```

---

# Supported File Types

Examples

```
image/png

image/jpeg

application/pdf

application/zip

application/vnd.ms-excel
```

---

# Download Flow

```
Client

↓

Download Request

↓

Controller

↓

Storage

↓

File Returned
```

---

# File Upload Lifecycle

```
Choose File

↓

Upload

↓

Validate

↓

Store

↓

Save Metadata

↓

Success Response
```

---

# Saving Metadata

Usually,

only the file location is stored in the database.

Example

```
ID

File Name

Content Type

File Size

File Path
```

The actual file is stored separately.

---

# Common Use Cases

- Resume Upload
- Profile Picture
- Product Images
- Invoice PDFs
- Medical Reports
- Video Uploads

---

# Advantages

- Easy document management.
- Supports multiple file types.
- Improves user experience.
- Can integrate with cloud storage.
- Efficient file sharing.

---

# Disadvantages

- Large files consume storage.
- Uploads require validation.
- Security risks if unchecked.
- Additional storage costs.

---

# Best Practices

- Validate file type and size.
- Rename uploaded files to avoid name collisions.
- Store files outside the application's source directory.
- Use cloud storage for production.
- Scan uploaded files for malware.
- Restrict access to sensitive files.
- Store only file metadata in the database when possible.

---

# Common Mistakes

❌ Trusting the original file name.

❌ Allowing unlimited file size.

❌ Accepting every file type.

❌ Storing sensitive uploads in publicly accessible folders.

❌ Not validating MIME types.

---

# Real-World Example

## Banking Application

```
Upload KYC Document

↓

Validate

↓

Store Securely
```

---

## E-Commerce Website

```
Seller Uploads Product Image

↓

Store

↓

Display Product
```

---

## Job Portal

```
Candidate Uploads Resume

↓

Save File

↓

Recruiter Downloads
```

---

# Interview Questions

### 1. What is `MultipartFile`?

`MultipartFile` is Spring Boot's interface that represents an uploaded file received in a `multipart/form-data` request.

---

### 2. Which content type is used for file uploads?

```
multipart/form-data
```

---

### 3. Where can uploaded files be stored?

- Local File System
- Database (BLOB)
- Cloud Storage (AWS S3, Azure Blob, Google Cloud Storage)

---

### 4. Why should uploaded files be validated?

To prevent invalid, oversized, malicious, or unsupported files from being stored.

---

### 5. How can the maximum upload size be configured?

```properties
spring.servlet.multipart.max-file-size=10MB

spring.servlet.multipart.max-request-size=20MB
```

---

### 6. Should file names from users be trusted?

No. They should be sanitized or replaced with unique names (such as UUIDs) to prevent conflicts and security issues.

---

### 7. Why is cloud storage preferred in production?

It provides scalability, durability, high availability, and easier file management compared to local storage.

---

# Quick Revision

- File Upload uses `multipart/form-data`.
- Spring Boot represents uploaded files with `MultipartFile`.
- Validate file size, type, and content before storing.
- Store files locally, in a database, or in cloud storage.
- Save only file metadata in the database whenever possible.
- Configure upload size limits.
- Rename files and secure storage locations for production.