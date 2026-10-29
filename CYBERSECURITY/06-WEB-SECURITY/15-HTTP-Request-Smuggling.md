# `15-HTTP-Request-Smuggling.md`

# HTTP Request Smuggling

## 1. First Principle

**HTTP Request Smuggling (HRS)** occurs when different components in a web request chain interpret the boundaries of an HTTP request differently.

Typical architecture:

```text
Client
  ↓
CDN / Load Balancer
  ↓
Reverse Proxy
  ↓
Web Server
  ↓
Application
```

The core problem:

> **If two HTTP components disagree about where one request ends and the next begins, an attacker may be able to manipulate how requests are interpreted.**

---

# 2. Why It Happens

HTTP requests can use mechanisms such as:

```text
Content-Length
Transfer-Encoding: chunked
```

If a frontend and backend interpret these differently, their view of the request boundary can become inconsistent.

Conceptually:

```text
Frontend sees:

Request A
──────────

Backend sees:

Request A
──────
Request B
──
```

That disagreement is the foundation of request smuggling.

---

# 3. The Request Chain

Consider:

```text
Internet
   ↓
CDN
   ↓
Reverse Proxy
   ↓
Application Server
```

Suppose the proxy decides:

```text
"This HTTP request ends here."
```

while the backend decides:

```text
"No, there is additional request data."
```

The remaining bytes may be interpreted as another HTTP request.

This is sometimes called **request desynchronization**.

---

# 4. Content-Length and Transfer-Encoding

### Content-Length

Tells the receiver how many bytes belong to the request body.

Example:

```http
Content-Length: 25
```

Conceptually:

```text
Headers
   ↓
25 bytes of body
```

### Transfer-Encoding: chunked

The body is transmitted using chunks rather than a single declared length.

Conceptually:

```text
chunk size
chunk data
chunk size
chunk data
0
```

The problem occurs when different components prioritize or interpret these mechanisms differently.

---

# 5. Common Smuggling Classes

You may encounter names such as:

### CL.TE

Frontend and backend disagree because one relies on:

```text
Content-Length
```

while the other processes:

```text
Transfer-Encoding
```

### TE.CL

The reverse interpretation.

### TE.TE

Both support `Transfer-Encoding`, but interpret or normalize the header differently.

The exact behavior depends on the specific proxy/server implementations.

---

# 6. Industry-Level Example

Imagine an online banking application:

```text
Client
  ↓
Cloud Load Balancer
  ↓
Reverse Proxy
  ↓
Banking API
```

A request-smuggling vulnerability could potentially cause the frontend and backend to become desynchronized.

Possible consequences include:

```text
Request Smuggling
      ↓
Request confusion
      ↓
Authentication/authorization boundary problems
      ↓
Cache poisoning
      ↓
Potential unauthorized request processing
```

The exact impact depends on the infrastructure.

---

# 7. Why It Can Be Serious

Potential consequences include:

### Request routing confusion

A request may reach an unintended backend handler.

### Cache poisoning

A maliciously constructed request can potentially cause a proxy/cache to store an unexpected response.

### Security-control bypass

Frontend security checks may apply to one interpretation while the backend processes another.

### Credential/session impact

In some architectures, desynchronization can interfere with how subsequent requests are associated with connections.

### Internal request manipulation

Under certain conditions, attacker-controlled data may influence how another request is interpreted.

---

# 8. HTTP/1.1 Connection Reuse

Request smuggling is particularly relevant when HTTP/1.1 connections are reused:

```text
Client
   ↓
Persistent TCP connection
   ↓
Proxy
   ↓
Backend
```

Multiple requests may travel through the same connection.

If request boundaries become inconsistent:

```text
Request A | Request B | Request C
```

one component may interpret them differently.

This is why connection handling is important.

---

# 9. HTTP/2 Considerations

HTTP/2 uses a different framing mechanism and is generally less directly exposed to classic HTTP/1.1 request-boundary ambiguity.

However, real deployments often involve protocol conversion:

```text
Browser
  ↓ HTTP/2
Proxy
  ↓ HTTP/1.1
Backend
```

This creates an important security boundary.

> **Protocol translation must be handled consistently and securely.**

HTTP/2-specific request-smuggling issues can also exist, particularly around translation and normalization.

---

# 10. How to Prevent It

### 1. Keep frontend and backend parsing consistent

Use well-supported, patched versions of:

```text
CDN
Load balancer
Reverse proxy
Web server
Application server
```

### 2. Reject ambiguous requests

Requests containing conflicting or malformed framing information should generally be rejected rather than interpreted differently.

### 3. Normalize HTTP handling

Ensure all components agree on:

```text
Headers
Transfer-Encoding
Content-Length
HTTP versions
Connection behavior
```

### 4. Patch infrastructure

Request smuggling is often an **infrastructure-level** problem.

---

# 11. Reverse Proxy Configuration

Common components to understand:

```text
Nginx
Apache HTTP Server
HAProxy
Envoy
Cloud load balancers
CDNs
Application servers
```

A secure architecture requires compatible HTTP parsing behavior across the entire chain.

---

# 12. Safe Testing Methodology

For authorized testing:

```text
1. Map the request chain
2. Identify proxy/CDN/backend versions
3. Compare HTTP parsing behavior
4. Check for conflicting framing
5. Use a dedicated test environment
6. Monitor proxy and backend logs
7. Verify request boundaries
```

Do **not** test request-smuggling payloads against systems you don't own or have explicit authorization to assess, because malformed requests can affect other users sharing a connection or proxy.

---

# 13. Small Hands-On Lab

Create a local architecture:

```text
Client
  ↓
Reverse Proxy
  ↓
Local Web Server
```

For example:

```text
localhost:8080
      ↓
localhost:8081
```

Generate normal requests and observe:

```text
Proxy access log
Backend access log
```

The objective is to understand whether both components agree about:

```text
Request method
Headers
Body length
Request boundaries
Connection reuse
```

Then inspect the configuration of both components for:

```text
HTTP/1.1 handling
HTTP/2 → HTTP/1.1 conversion
Content-Length handling
Transfer-Encoding handling
Malformed-request rejection
```

---

# 14. SOC Relevance

Request smuggling can be difficult to detect because the malicious request may not look like a traditional exploit.

Useful telemetry:

```text
Proxy logs
Load-balancer logs
Web-server logs
Backend logs
Connection identifiers
Request timing
HTTP status codes
```

Look for inconsistencies such as:

```text
Proxy:
1 request

Backend:
2 requests
```

or:

```text
Frontend logs:
GET /public

Backend logs:
GET /public
POST /unexpected
```

Unexpected discrepancies between frontend and backend request counts can be a useful investigation signal.

---

# 15. Common Developer/Infrastructure Mistakes

### ❌ Different HTTP parsers with inconsistent behavior

```text
CDN → Proxy → Backend
```

Each component may interpret requests differently.

### ❌ Ignoring conflicting headers

Ambiguous framing should be rejected.

### ❌ Running outdated proxies

Security fixes in HTTP parsing are important.

### ❌ Assuming HTTP/2 automatically eliminates the problem

Protocol conversion can reintroduce parsing boundaries.

### ❌ Testing only the application

Request smuggling often exists in the **network/application infrastructure**, not application code itself.

---

# 16. Interview Questions

### Q1. What is HTTP Request Smuggling?

An attack that exploits differences in how HTTP components determine request boundaries.

### Q2. What causes it?

Usually inconsistent handling of HTTP message framing, especially around:

```text
Content-Length
Transfer-Encoding
```

### Q3. What is CL.TE?

A situation where the frontend and backend use different mechanisms to determine the request boundary, commonly Content-Length vs Transfer-Encoding.

### Q4. What can request smuggling lead to?

Potentially:

- Request desynchronization
- Cache poisoning
- Security-control bypass
- Request routing problems
- Unauthorized request processing

### Q5. Where should you look for this vulnerability?

Across the complete request chain:

```text
CDN
 ↓
Load Balancer
 ↓
Reverse Proxy
 ↓
Web Server
 ↓
Application Server
```

---

# 17. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| HTTP Request Smuggling | Exploiting request-boundary disagreement |
| Request Desynchronization | Frontend/backend lose request-boundary agreement |
| Content-Length | Specifies body length |
| Transfer-Encoding | Defines transfer framing |
| CL.TE | Different CL/TE interpretation |
| TE.CL | Reverse interpretation |
| Proxy | Intermediate HTTP component |
| Cache Poisoning | Manipulating cached responses |
| HTTP/2 Translation | HTTP/2 ↔ HTTP/1.1 security boundary |

---

# 18. Core Mental Model

Think of the HTTP chain as a group of people reading the same letter:

```text
Client
  ↓
Proxy:   "Request ends here."
  ↓
Backend: "No, it ends later."
```

That disagreement is the vulnerability.

Secure architecture:

```text
Client
  ↓
CDN
  ↓
Proxy
  ↓
Backend
  ↓
Everyone agrees on request boundaries
```

**Remember:**

> **HTTP Request Smuggling is fundamentally a disagreement between HTTP components about where a request starts and ends.**

### Next

`16-Race-Conditions.md`