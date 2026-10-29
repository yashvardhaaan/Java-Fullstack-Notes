
# `06-Defense-in-Depth.md`

```md
# Defense in Depth

## 1. What is Defense in Depth?

Defense in Depth means using **multiple layers of security controls** so that if one control fails, other controls can still protect the system.

### First Principle

> "Never depend on a single security control."

Example:

```text
Attacker
   ↓
Firewall
   ↓
WAF
   ↓
Authentication
   ↓
Authorization
   ↓
Application
   ↓
Database
   ↓
Encryption
   ↓
Monitoring
```

---

# 2. Why Is It Necessary?

No security control is perfect.

Example:

An attacker steals a user's password.

If the company only uses passwords:

```text
Stolen Password
      ↓
Account Compromised
```

With multiple layers:

```text
Stolen Password
      ↓
MFA
      ↓
Attacker Blocked
```

Even if the first control fails, another control can stop the attack.

---

# 3. Layers of Defense

A typical organization may have:

### Layer 1 — Physical Security

Protect physical infrastructure.

Examples:

- CCTV
- Door access control
- Security guards
- Locked server rooms

### Layer 2 — Network Security

Protect network communication.

Examples:

- Firewall
- IDS/IPS
- Network segmentation
- VPN

### Layer 3 — Endpoint Security

Protect computers and devices.

Examples:

- Antivirus
- EDR
- Host firewall
- Patch management

### Layer 4 — Application Security

Protect applications.

Examples:

- Secure coding
- Input validation
- WAF
- Authentication
- Authorization

### Layer 5 — Data Security

Protect information itself.

Examples:

- Encryption
- Data masking
- Access control
- Backups

### Layer 6 — Monitoring

Detect attacks and suspicious behavior.

Examples:

- SIEM
- Logs
- Alerts
- Security monitoring

---

# 4. Real Industry Example

Consider an online banking system.

```text
Customer
   ↓
Internet
   ↓
Firewall
   ↓
WAF
   ↓
Login + MFA
   ↓
Authorization
   ↓
Banking Application
   ↓
Database
```

Suppose an attacker bypasses the firewall.

They still face:

- WAF
- Authentication
- MFA
- Authorization
- Database access controls
- Monitoring

This is defense in depth.

---

# 5. Defense in Depth vs Single Control

### Weak Design

```text
Internet
   ↓
Firewall
   ↓
Application
```

If the firewall is misconfigured, the system may be exposed.

### Stronger Design

```text
Internet
   ↓
Firewall
   ↓
WAF
   ↓
Authentication
   ↓
Authorization
   ↓
Application
   ↓
Database Controls
   ↓
Monitoring
```

Multiple controls provide multiple opportunities to stop or detect an attack.

---

# 6. Practical Security Analyst Approach

When reviewing a system, ask:

1. What is the first security layer?
2. What happens if it fails?
3. What is the next layer?
4. Can an attacker bypass multiple layers?
5. Are critical assets isolated?
6. Are failures being detected?

The important question is:

> "If one control fails, what protects the system next?"

---

# 7. Real Example — Ransomware

Suppose ransomware reaches an employee laptop.

Possible defense layers:

```text
Email Filtering
      ↓
Endpoint Protection
      ↓
Application Controls
      ↓
Network Segmentation
      ↓
SIEM Detection
      ↓
Incident Response
      ↓
Backups
```

Even if malware reaches the endpoint, segmentation can prevent lateral movement and backups can help recover data.

---

# 8. Important Principle

Defense in depth is not:

> "Buy more security tools."

It is:

> "Design multiple independent layers that reduce the probability and impact of an attack."

Too many overlapping tools without proper configuration can create complexity without improving security.

---

# 9. Key Takeaways

- Defense in depth uses multiple security layers.
- No single security control should be trusted completely.
- Layers can include physical, network, endpoint, application, data, and monitoring controls.
- Controls should complement each other.
- The failure of one control should not immediately compromise the entire system.
- Good defense in depth reduces both attack probability and attack impact.

---

# Interview Questions

### Q1. What is defense in depth?

A security strategy that uses multiple layers of controls so that failure of one control does not result in complete system compromise.

### Q2. Give an example.

Firewall + MFA + authorization + endpoint protection + monitoring + backups.

### Q3. Why is defense in depth important?

Because every individual security control can fail, be bypassed, or be misconfigured.

### Q4. Is defense in depth just using many security tools?

No. It is about strategically designing complementary security layers to reduce risk.

### Q5. What happens if one security layer fails?

Other security layers should prevent, detect, contain, or help recover from the attack.
```