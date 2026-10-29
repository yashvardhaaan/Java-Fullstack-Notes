# `13-XXE.md`

# XML External Entity (XXE)

## 1. First Principle

**XXE (XML External Entity)** occurs when an XML parser processes attacker-controlled external entities.

The core problem:

> **Never allow untrusted XML to resolve external entities unless there is a specific, controlled requirement.**

A vulnerable XML parser can potentially be abused to:

- Read local files
- Make server-side network requests
- Cause denial of service
- Expose sensitive information

---

# 2. What Is XML?

XML represents structured data:

```xml
<user>
    <name>Yash</name>
    <role>admin</role>
</user>
```

Applications may use XML for:

```text
SOAP APIs
SAML
Configuration files
Document formats
Enterprise integrations
Legacy APIs
```

An XML parser converts XML text into a structure the application can process.

---

# 3. What Is an External Entity?

XML supports entities that can reference external resources.

Conceptually:

```xml
<!DOCTYPE data [
  <!ENTITY example SYSTEM "external-resource">
]>
```

Then:

```xml
<user>&example;</user>
```

If the parser is configured to resolve external entities, it may retrieve the referenced resource.

This becomes dangerous when the XML itself is controlled by an attacker.

---

# 4. How XXE Happens

Typical flow:

```text
Attacker-controlled XML
        ↓
XML Parser
        ↓
External entity resolution
        ↓
Local file / network resource
        ↓
Sensitive data or internal request
```

The vulnerability usually comes from **unsafe XML parser configuration**, not XML itself.

---

# 5. Industry-Level Example

Suppose an enterprise application accepts XML:

```http
POST /api/customer
Content-Type: application/xml
```

Normal request:

```xml
<customer>
    <name>Yash</name>
    <email>user@example.com</email>
</customer>
```

The backend parses the XML.

If external entity processing is enabled, attacker-controlled XML could cause the parser to access resources that the application itself can access.

Potential impact:

```text
XXE
 ↓
Local file disclosure
or
Server-side network request
or
Denial of service
```

The actual impact depends on parser configuration and operating-system permissions.

---

# 6. XXE Can Lead to SSRF

There is an important connection between the two vulnerabilities.

```text
XXE
 ↓
External entity
 ↓
XML parser makes network request
 ↓
Internal service
```

Therefore:

```text
XXE → SSRF-like behavior
```

can occur in some vulnerable configurations.

---

# 7. XXE vs SSRF

| XXE | SSRF |
|---|---|
| Starts with XML processing | Starts with server-side request functionality |
| Abuses XML entity resolution | Abuses server network access |
| Requires XML parser behavior | Does not require XML |
| Can potentially cause SSRF | Directly causes server-side requests |

Mental model:

```text
XXE:
XML → Parser → External Resource
```

```text
SSRF:
Input → Server HTTP Client → Destination
```

---

# 8. Secure XML Parsing

The safest approach is:

> **Disable external entity processing and external DTDs when they are not required.**

For Java applications, parser configuration should explicitly prevent external resource resolution.

Conceptually:

```java
factory.setFeature(
    "http://xml.org/sax/features/external-general-entities",
    false
);

factory.setFeature(
    "http://xml.org/sax/features/external-parameter-entities",
    false
);
```

Also disable external DTD loading where supported.

The exact secure configuration depends on the XML parser/API being used, so don't blindly copy a configuration without understanding the parser version.

---

# 9. Java/Spring Boot Security

If your Spring Boot application processes XML through:

```text
DOM
SAX
SAXParserFactory
DocumentBuilderFactory
XMLInputFactory
JAXB
SOAP
```

check how external entities and DTDs are handled.

Security should be applied at the **parser configuration layer**.

Do not assume:

```text
"Spring Boot"
```

automatically makes every XML parser configuration safe.

---

# 10. Disable DTDs When Possible

If your application does not need DTD functionality:

```text
Disable DTD processing
```

This significantly reduces the XXE attack surface.

Security principle:

> **Disable functionality you do not need.**

This is an example of attack-surface reduction.

---

# 11. XML Bomb / Billion Laughs

XXE is also related to XML entity expansion attacks.

Conceptually:

```text
Entity A
   ↓
Entity B
   ↓
Entity C
   ↓
Huge expansion
```

A small XML document can potentially cause enormous memory/CPU consumption.

This can lead to:

```text
Memory exhaustion
CPU exhaustion
Application crash
Denial of service
```

Therefore secure XML processing should also consider:

- Entity expansion
- Input size
- Processing limits
- Parser resource limits

---

# 12. File Upload Connection

Some uploaded files may contain XML-based formats.

Examples include:

```text
SVG
XML
Certain office/document formats
SOAP messages
SAML documents
```

Therefore:

```text
File Upload
     ↓
XML parser
     ↓
Potential XXE
```

is an important security relationship.

---

# 13. Small Hands-On Lab

Create a local Java application that accepts XML:

```text
POST /xml
```

Start with harmless XML:

```xml
<user>
    <name>Yash</name>
</user>
```

Observe:

```text
HTTP request
    ↓
XML parser
    ↓
Java object
```

Then inspect your parser configuration.

Your objective is to verify:

```text
✓ External entities disabled
✓ External DTDs disabled
✓ Entity expansion controlled
✓ XML size limits configured
```

Do the experiment only against your own local application.

---

# 14. SOC Relevance

Potential indicators include:

```text
POST /api/xml
Content-Type: application/xml
```

followed by unusual XML structures containing:

```text
DOCTYPE
ENTITY
external references
```

Investigation:

```text
HTTP request
     ↓
XML parser errors?
     ↓
Unexpected file access?
     ↓
Unexpected outbound network request?
     ↓
Sensitive data exposure?
```

If an XML-processing service suddenly makes unusual outbound connections after receiving suspicious XML, investigate the possibility of XXE/SSRF behavior.

---

# 15. Common Developer Mistakes

### ❌ Assuming XML is harmless

XML is data, but parser features can introduce security risks.

### ❌ Enabling DTDs unnecessarily

If the application doesn't need them, disable them.

### ❌ Allowing external entities

External entity resolution expands the attack surface.

### ❌ Checking only application input

Security must also be enforced in the XML parser.

### ❌ Ignoring XML libraries

Third-party libraries may internally parse XML.

Always understand:

```text
Who parses the XML?
Which parser?
What configuration?
Are external resources enabled?
```

---

# 16. Interview Questions

### Q1. What is XXE?

A vulnerability caused by unsafe processing of XML external entities.

### Q2. What can XXE cause?

Potentially:

- Local file disclosure
- SSRF-like requests
- Sensitive information disclosure
- Denial of service

### Q3. How do you prevent XXE?

Disable:

```text
External entities
External DTDs
Unnecessary DTD processing
```

and apply XML resource limits.

### Q4. Is XXE the same as SSRF?

No.

XXE is an XML parser vulnerability that can sometimes produce SSRF-like behavior.

### Q5. What is an XML bomb?

An XML entity expansion technique that can cause excessive resource consumption and denial of service.

---

# 17. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| XXE | XML External Entity |
| DTD | Document Type Definition |
| Entity | Named XML substitution |
| External Entity | Entity referencing an external resource |
| XML Bomb | Excessive entity expansion |
| Main defense | Disable external entities/DTDs |
| SSRF connection | XXE can trigger server-side requests |
| DoS | Excessive XML processing can exhaust resources |

---

# 18. Core Mental Model

```text
Untrusted XML
     ↓
XML Parser
     ↓
Disable external entities
     ↓
Disable unnecessary DTDs
     ↓
Limit XML resources
     ↓
Parse safely
```

Remember:

> **The XML document is untrusted, and the parser must be configured accordingly.**

### Next

`14-Insecure-Deserialization.md`