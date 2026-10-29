# `12-SSRF.md`

# Server-Side Request Forgery (SSRF)

## 1. First Principle

**SSRF** occurs when an attacker can influence a server to make a network request to a destination the attacker should not be able to access directly.

The core problem:

> **The server has network access and trust that the attacker does not have.**

Normal:

```text
User → Web Server → Public API
```

SSRF:

```text
Attacker → Web Server → Internal Service
                         ↑
                    unintended access
```

---

# 2. How SSRF Works

Consider an application that fetches an image from a URL:

```http
POST /api/fetch-image
Content-Type: application/json
```

```json
{
  "url": "https://example.com/image.jpg"
}
```

Backend:

```java
URL url = new URL(userProvidedUrl);
```

The application expects a public image URL.

But if arbitrary destinations are accepted, the server may be tricked into requesting:

```text
http://internal-service/
```

The attacker may not have direct access:

```text
Attacker ──X──> Internal Service
```

but the server might:

```text
Attacker → Web App → Internal Service
```

---

# 3. Why SSRF Is Dangerous

Servers often have access to resources unavailable from the public Internet:

```text
Internal APIs
Databases
Admin panels
Monitoring services
Private network hosts
Cloud metadata services
```

Possible impact:

```text
SSRF
 ↓
Internal service access
 ↓
Information disclosure
 ↓
Credential/token exposure
 ↓
Further compromise
```

The actual impact depends on network architecture and permissions.

---

# 4. Common SSRF Targets

During authorized testing, applications should be protected against requests targeting:

```text
localhost
127.0.0.1
::1
```

Private IPv4 ranges include:

```text
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16
```

Also consider:

```text
Internal DNS names
Internal service names
Unexpected ports
Cloud metadata endpoints
```

The important point is not to rely on blocking only one address such as `127.0.0.1`.

---

# 5. Industry-Level Example

### Webhook Tester

Suppose a SaaS application provides:

```text
POST /api/webhook/test
```

with:

```json
{
  "url": "https://customer.example.com/webhook"
}
```

The backend sends a test request:

```text
Application
    ↓
HTTP client
    ↓
Customer webhook
```

If arbitrary URLs are accepted:

```text
Application
    ↓
Attacker-controlled destination
    ↓
Internal network
```

The webhook feature has potentially become an SSRF attack surface.

Common SSRF-prone features include:

- Webhook testing
- URL previews
- Image import
- PDF generation
- Screenshot services
- Feed importers
- External API proxies
- Link unfurling

---

# 6. SSRF vs CSRF

These vulnerabilities are different.

| SSRF | CSRF |
|---|---|
| Server makes the request | Victim's browser makes the request |
| Abuses server network access | Abuses browser authentication |
| Often targets internal services | Often targets state-changing endpoints |
| Server-side vulnerability | Browser-based attack |

Mental model:

```text
SSRF:
Attacker → Server → Target
```

```text
CSRF:
Attacker → Victim Browser → Target
```

---

# 7. Main Defense: Allowlisting

The strongest approach is usually to allow only destinations the application actually needs.

For example:

```text
Allowed:
https://api.partner.example
https://images.example-cdn.com
```

Reject unexpected destinations.

Conceptually:

```java
if (!allowedHost(host)) {
    throw new SecurityException("Destination not allowed");
}
```

Prefer:

```text
Allow known destinations
```

over trying to maintain an enormous blacklist of dangerous destinations.

---

# 8. Validate the Complete Destination

Do not validate only the URL string.

Consider:

```text
Scheme
Hostname
Port
DNS resolution
Resolved IP
Redirect destination
```

A secure flow is:

```text
User URL
   ↓
Parse URL
   ↓
Validate scheme
   ↓
Validate hostname
   ↓
Resolve DNS
   ↓
Validate resolved IP
   ↓
Make request
   ↓
Validate redirects
```

For example, only permitting:

```text
https://
```

may be preferable to allowing arbitrary schemes.

---

# 9. DNS Rebinding

One important SSRF complication is **DNS rebinding**.

Conceptually:

```text
approved.example.com
        ↓
DNS lookup
        ↓
Initially resolves to allowed IP
        ↓
Later resolves to internal IP
```

Therefore:

> Validating only the hostname is not always enough.

The application and network architecture need to account for the destination actually being contacted.

---

# 10. Redirects

Suppose the application accepts:

```text
https://trusted.example
```

but that server redirects the HTTP client elsewhere.

Potential flow:

```text
Trusted URL
    ↓
HTTP 302
    ↓
Unexpected destination
```

Therefore, applications that follow redirects should validate the destination of redirects as well.

---

# 11. Network-Level Defense

Application validation should not be your only defense.

Use network controls such as:

```text
Egress firewall rules
Network segmentation
Private subnet controls
Proxy restrictions
Cloud security groups
```

Example:

```text
Internet-facing Web Server
          ↓
    Restricted egress
          ↓
Only required external APIs
```

The application should not automatically have unrestricted access to every internal network.

---

# 12. Cloud SSRF

SSRF is especially important in cloud environments.

Cloud workloads may expose a **metadata service** containing infrastructure information and, depending on configuration, temporary credentials.

Therefore cloud environments should use:

- Least-privilege IAM
- Metadata-service protections
- Restricted network access
- Workload identity
- Egress filtering
- SSRF-resistant application design

Important principle:

> **Never assume that an internal cloud endpoint is harmless simply because it isn't publicly reachable.**

---

# 13. Blind SSRF

Sometimes the attacker cannot see the response from the server.

Example:

```text
Application
   ↓
Server-side request
   ↓
External endpoint
```

The attacker only knows that the request happened.

This is called:

**Blind SSRF**

Detection may involve:

```text
DNS activity
HTTP logs
Network telemetry
Timing differences
Application logs
```

---

# 14. Secure Architecture

Instead of:

```text
User URL
   ↓
Application
   ↓
Any destination
```

prefer:

```text
User URL
   ↓
URL validation
   ↓
Destination allowlist
   ↓
IP/network validation
   ↓
Restricted outbound proxy
   ↓
Approved destination
```

An outbound proxy can provide another centralized security boundary.

---

# 15. Small Hands-On Lab

Build two local services:

```text
web-app
   ↓
internal-service
```

The web application exposes:

```text
GET /fetch?url=<URL>
```

The learning goal is to understand:

```text
Browser
   ↓
web-app
   ↓
internal-service
```

Then add protections:

```text
✓ Allow only HTTPS
✓ Allow only approved hosts
✓ Reject private/internal destinations
✓ Validate resolved IP
✓ Validate redirects
✓ Restrict outbound network access
```

Keep the lab entirely on your own machine or authorized environment.

---

# 16. SOC Relevance

A SOC analyst might notice requests such as:

```text
GET /fetch?url=http://localhost/
```

or attempts involving:

```text
127.0.0.1
private IP addresses
internal DNS names
unexpected ports
cloud metadata endpoints
```

Investigation:

```text
1. Identify the vulnerable endpoint
2. Identify the supplied destination
3. Determine whether the request succeeded
4. Check outbound network logs
5. Determine what response/data was returned
6. Check for credential exposure
7. Investigate subsequent activity
```

A blocked SSRF attempt is not automatically a compromise.

Successful access to sensitive internal resources is much more significant.

---

# 17. Common Developer Mistakes

### ❌ Accept arbitrary URLs

```java
client.get(userProvidedUrl);
```

### ❌ Block only `127.0.0.1`

There are many ways to represent or reach internal destinations.

### ❌ Validate hostname only

DNS resolution and actual IP destinations matter.

### ❌ Ignore redirects

A trusted URL may redirect elsewhere.

### ❌ Rely only on application filtering

Network-level egress restrictions provide important defense in depth.

### ❌ Give the application unnecessary network access

Least privilege should apply to network connectivity too.

---

# 18. Interview Questions

### Q1. What is SSRF?

A vulnerability where an attacker causes a server to make an unintended request to an attacker-influenced or unauthorized destination.

### Q2. Why is SSRF dangerous?

The server may be able to access internal systems that the attacker cannot reach directly.

### Q3. What is Blind SSRF?

The server makes the request, but the attacker cannot directly observe the response.

### Q4. How do you prevent SSRF?

Use:

- Destination allowlists
- Strict URL parsing
- Scheme/host/port validation
- Resolved-IP validation
- Redirect validation
- Egress filtering
- Network segmentation
- Least privilege

### Q5. Why is cloud SSRF important?

A vulnerable server may have access to sensitive cloud infrastructure endpoints and potentially temporary credentials.

---

# 19. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| SSRF | Server makes attacker-influenced request |
| Blind SSRF | Request occurs without visible response |
| Allowlist | Permit only approved destinations |
| Egress filtering | Control outbound connections |
| DNS rebinding | DNS resolution changes to an unexpected destination |
| Redirect validation | Validate every redirect destination |
| Metadata service | Cloud infrastructure endpoint |
| Network segmentation | Limit reachable systems |
| Least privilege | Give server only required network access |

---

# 20. Core Mental Model

```text
User-controlled URL
        ↓
     Parse
        ↓
Validate scheme/host/port
        ↓
Resolve destination
        ↓
Block unauthorized networks
        ↓
Validate redirects
        ↓
Restricted network egress
        ↓
Make request
```

The key question is:

> **"What can this server reach that the attacker cannot?"**

That is the heart of SSRF.

---

### Next

`13-XXE.md`