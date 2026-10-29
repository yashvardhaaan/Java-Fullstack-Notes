# `14-Insecure-Deserialization.md`

# Insecure Deserialization

## 1. First Principle

**Deserialization** is the process of converting stored/transmitted data back into an application object.

```text
Serialization:
Object → Data

Deserialization:
Data → Object
```

The security problem occurs when an application deserializes **untrusted data** without properly controlling what can be created or executed.

> **Never blindly deserialize attacker-controlled data.**

---

# 2. Serialization Example

Suppose Java has:

```java
class User {
    String name;
    String role;
}
```

Serialization:

```text
User object
    ↓
Serialized data
```

Later:

```text
Serialized data
    ↓
Deserialization
    ↓
User object
```

Serialization formats include:

```text
JSON
XML
Java serialization
YAML
Pickle
Binary protocols
```

Not all serialization formats have the same security risk.

---

# 3. Where the Vulnerability Happens

Dangerous flow:

```text
Internet
   ↓
Attacker-controlled serialized data
   ↓
Application
   ↓
Deserialization
   ↓
Object creation / method execution
```

Some serialization mechanisms can instantiate unexpected classes or trigger dangerous behavior during deserialization.

Potential impact can include:

```text
Data tampering
Authentication bypass
Denial of service
Remote Code Execution
```

Impact depends heavily on the language, serialization framework, classes available, and application configuration.

---

# 4. Java Serialization

Java provides native serialization mechanisms such as:

```java
ObjectOutputStream
ObjectInputStream
```

Example:

```java
ObjectInputStream in =
    new ObjectInputStream(inputStream);

Object obj = in.readObject();
```

The dangerous part is:

```text
readObject()
```

when the input is controlled by an attacker.

The application may deserialize an object graph that the developer never intended to accept.

---

# 5. Industry-Level Example

Imagine a web application stores user preferences in a serialized object:

```text
Cookie
   ↓
Serialized Java object
   ↓
Server
   ↓
ObjectInputStream
```

If the serialized value can be modified by the user:

```text
Attacker
   ↓
Modified serialized object
   ↓
Server deserialization
```

the attacker may potentially manipulate the object graph.

If dangerous gadget classes are available, the impact can become severe.

---

# 6. Gadget Chains

A **gadget** is an existing piece of code that can be triggered in an unexpected way during deserialization.

A **gadget chain** is a sequence of such operations:

```text
Untrusted serialized data
        ↓
Gadget A
        ↓
Gadget B
        ↓
Gadget C
        ↓
Dangerous operation
```

Important:

> The vulnerable application does not necessarily contain obviously malicious code.

The problem can arise from combining existing classes and behaviors into an unintended execution path.

---

# 7. Why RCE Can Occur

Conceptually:

```text
Attacker-controlled object
        ↓
Deserialization
        ↓
Gadget chain
        ↓
Dangerous method
        ↓
Potential code execution
```

However:

> **Insecure deserialization does not automatically mean RCE.**

The final impact depends on:

- Serialization framework
- Available classes
- Library versions
- Application privileges
- Security controls
- Runtime environment

---

# 8. JSON vs Native Serialization

A major design principle:

### Prefer simple data formats

For APIs:

```json
{
  "username": "Yash",
  "role": "user"
}
```

The application explicitly maps this data to an expected object.

This is generally easier to secure than accepting arbitrary native object graphs.

### Dangerous pattern

```text
Untrusted bytes
      ↓
Generic object deserializer
      ↓
Arbitrary object graph
```

### Better pattern

```text
Untrusted JSON
      ↓
Schema validation
      ↓
Expected DTO
      ↓
Application logic
```

---

# 9. Secure Java Design

Instead of:

```java
Object obj = objectInputStream.readObject();
```

prefer a controlled data format such as JSON:

```java
UserDto user = objectMapper.readValue(
    json,
    UserDto.class
);
```

Then validate:

```text
username
email
role
permissions
```

Do not allow clients to decide sensitive fields such as:

```json
{
  "role": "admin"
}
```

without authorization checks.

---

# 10. Deserialization ≠ Authorization

Suppose the client sends:

```json
{
  "username": "Yash",
  "role": "admin"
}
```

Even if the JSON is safely parsed, the application must not blindly trust:

```text
role = admin
```

Correct architecture:

```text
Input
 ↓
Parse
 ↓
Validate
 ↓
Authenticate
 ↓
Authorize
 ↓
Apply trusted server-side privileges
```

---

# 11. Common Locations

Look for serialization/deserialization in:

```text
Session storage
Cookies
Message queues
Caching systems
APIs
RPC frameworks
File imports
Database blobs
Application-to-application communication
```

Particularly important in:

```text
Java
PHP
Python
.NET
Ruby
```

because different ecosystems have different serialization mechanisms and historical vulnerabilities.

---

# 12. Integrity Protection

If an application absolutely must store serialized data client-side, it should prevent tampering.

Possible controls include:

```text
Digital signatures
HMAC
Authenticated encryption
Server-side storage
```

For example:

```text
Data
 ↓
HMAC
 ↓
Client
 ↓
Server
 ↓
Verify HMAC
 ↓
Deserialize/process
```

But integrity protection is **not a universal replacement for safe deserialization**.

Prefer avoiding dangerous native serialization formats when possible.

---

# 13. Small Hands-On Lab

Create a local Java application that demonstrates the difference between:

```text
ObjectInputStream
```

and:

```text
JSON → DTO
```

### Unsafe architecture

```text
HTTP request
    ↓
Serialized Java object
    ↓
ObjectInputStream
    ↓
Object
```

### Safer architecture

```text
HTTP request
    ↓
JSON
    ↓
Schema validation
    ↓
UserDto
```

Inspect the application and identify:

```text
✓ What data is trusted?
✓ Who controls the serialized input?
✓ Which classes can be instantiated?
✓ Are sensitive fields server-controlled?
✓ Can the format be replaced with JSON?
```

Keep the lab local and use harmless objects only.

---

# 14. SOC Relevance

Potential indicators include:

```text
Unexpected serialized-data payloads
Deserialization exceptions
Malformed object streams
Suspicious application errors
Unexpected child processes
Unexpected outbound connections
```

A particularly concerning sequence is:

```text
Suspicious request
      ↓
Deserialization error
      ↓
Unexpected process creation
```

For example:

```text
Web Server
    ↓
Unexpected Java child process
```

should be investigated in context.

Useful telemetry:

```text
HTTP logs
Application logs
Process creation
Network connections
Authentication events
File modifications
```

---

# 15. Common Developer Mistakes

### ❌ Deserializing untrusted Java objects

```java
readObject();
```

### ❌ Assuming serialization means security

Serialization is a data-format mechanism, not an authorization mechanism.

### ❌ Trusting client-controlled roles

```json
{
  "role": "admin"
}
```

must not grant privileges.

### ❌ Using outdated libraries

Known vulnerable dependencies can make gadget chains more likely.

### ❌ Ignoring dependency management

Keep serialization-related libraries patched.

---

# 16. Interview Questions

### Q1. What is deserialization?

Converting serialized data back into an application object.

### Q2. What is insecure deserialization?

Unsafe processing of untrusted serialized data that can cause unintended object creation or execution.

### Q3. What is a gadget chain?

A sequence of existing classes/methods that can be triggered through deserialization to perform an unintended operation.

### Q4. Can insecure deserialization cause RCE?

Yes, in some environments, depending on the available gadget chains and configuration.

### Q5. How can you prevent it?

- Avoid unsafe native serialization
- Prefer JSON/structured data
- Use DTOs
- Validate schemas
- Restrict permitted types
- Keep dependencies patched
- Apply authentication/authorization separately

---

# 17. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| Serialization | Object → Data |
| Deserialization | Data → Object |
| Insecure deserialization | Unsafe processing of untrusted serialized data |
| Gadget | Existing code usable during an unintended execution path |
| Gadget chain | Multiple gadgets chained together |
| RCE | Remote Code Execution |
| DTO | Controlled data-transfer object |
| Best defense | Avoid unsafe native deserialization |

---

# 18. Core Mental Model

```text
Untrusted Data
      ↓
Parse as simple data
      ↓
Validate schema
      ↓
Map to expected DTO
      ↓
Authorization
      ↓
Application logic
```

Avoid:

```text
Untrusted Data
      ↓
Generic Object Deserialization
      ↓
Arbitrary Object Graph
      ↓
Potential Gadget Chain
```

**Remember:**

> **Treat serialized data as untrusted input, not as a trusted application object.**

### Next

`15-HTTP-Request-Smuggling.md`