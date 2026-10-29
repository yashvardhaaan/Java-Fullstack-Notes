# `04-Attack-Surface.md`

```md
# Attack Surface

## 1. What is Attack Surface?

Attack surface is the total set of points where an attacker could potentially interact with or attack a system.

### First Principle

Ask:

> "Where can an attacker get in, send data, or influence the system?"

Examples:

- Login pages
- APIs
- Open ports
- Network services
- Cloud storage
- Employee laptops
- Mobile applications
- Third-party integrations

---

# 2. Simple Example

Consider a web application:

```text
Internet
   ↓
Website
   ↓
API
   ↓
Database
```

Possible attack surfaces:

```text
Website → XSS
API → Broken Access Control
Network → Open Ports
Database → Misconfiguration
Login → Credential Attack
```

Each exposed component increases the possible attack surface.

---

# 3. Types of Attack Surface

### 1. Digital Attack Surface

Technology exposed to attackers.

Examples:

- Websites
- APIs
- Servers
- Cloud services
- Open ports
- DNS
- Applications

### 2. Physical Attack Surface

Physical access points.

Examples:

- Office entrances
- Servers
- USB ports
- Network equipment
- Employee devices

### 3. Human Attack Surface

People who can be targeted.

Examples:

- Employees
- Administrators
- Developers
- Customers

Common attacks:

- Phishing
- Social engineering
- Credential theft

---

# 4. External vs Internal Attack Surface

### External Attack Surface

Accessible from outside the organization.

Example:

```text
Internet
   ↓
Public API
   ↓
Company System
```

Examples:

- Public website
- VPN
- Public API
- Mail server
- Cloud services

### Internal Attack Surface

Accessible after entering the internal environment.

Examples:

- Internal applications
- File servers
- Internal APIs
- Employee computers
- Databases

---

# 5. Real Industry Example

An organization has:

```text
20 Public Servers
15 APIs
50 Cloud Services
500 Employee Laptops
3 VPN Gateways
```

All of these can potentially become entry points.

An attacker may not directly attack the main application.

They might instead exploit:

> An old VPN server → gain access → move inside the network → compromise important systems.

Therefore:

> Security must consider the entire attack surface.

---

# 6. Attack Surface Reduction

Attack Surface Reduction (ASR) means reducing unnecessary exposure.

### Examples

Remove:

- Unused ports
- Unused services
- Unused accounts
- Unused applications
- Unnecessary permissions
- Public access to private resources

Example:

Instead of:

```text
Internet
   ↓
Database
```

Use:

```text
Internet
   ↓
Application
   ↓
Private Network
   ↓
Database
```

The database is no longer directly exposed to the internet.

---

# 7. Security Analyst Practical Approach

When assessing an organization:

### Step 1 — Discover

Identify:

- Domains
- Subdomains
- IP addresses
- Servers
- APIs
- Cloud assets
- Applications

### Step 2 — Identify Exposure

Ask:

> "Which assets are reachable by whom?"

### Step 3 — Find Weaknesses

Look for:

- Outdated software
- Misconfigurations
- Exposed services
- Weak authentication
- Unnecessary access

### Step 4 — Reduce Exposure

Examples:

- Close unused ports
- Remove unused services
- Restrict network access
- Patch systems
- Apply authentication
- Remove unnecessary public exposure

---

# 8. Attack Surface vs Attack Vector

These are different.

### Attack Surface

All possible points an attacker could target.

### Attack Vector

The specific method used to attack.

Example:

```text
Attack Surface:
Public login page

Attack Vector:
Credential stuffing
```

Another example:

```text
Attack Surface:
API endpoint

Attack Vector:
SQL Injection
```

---

# 9. Practical Example — Cloud

Suppose a company accidentally makes an object storage bucket public.

```text
Private Storage
      ↓
Misconfiguration
      ↓
Public Internet
      ↓
Attacker
```

The cloud storage became part of the organization's exposed attack surface.

Security control:

> Restrict public access and apply proper IAM permissions.

---

# 10. Key Takeaways

- Attack surface = all possible points an attacker can target.
- Every exposed service can increase attack surface.
- Attack surface includes technology, physical systems, and people.
- Reduce unnecessary exposure.
- Publicly exposed systems require stronger protection.
- Attack surface reduction is a major defensive security practice.
- You cannot secure what you don't know exists.

---

# Interview Questions

### Q1. What is an attack surface?

The total collection of points through which an attacker could potentially interact with or attack a system.

### Q2. What is attack surface reduction?

Reducing unnecessary exposure by removing or restricting unnecessary services, ports, accounts, applications, and access.

### Q3. What is the difference between attack surface and attack vector?

Attack surface represents possible targets or entry points; an attack vector is the specific technique used to exploit one.

### Q4. Give an example of attack surface reduction.

Closing an unused internet-facing port or removing public access from a private cloud resource.

### Q5. Why is asset discovery important?

Because an organization cannot properly secure systems and services that it does not know are exposed.
```