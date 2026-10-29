# `05-Security-Controls.md`

```md
# Security Controls

## 1. What is a Security Control?

A security control is a safeguard used to:

- Prevent attacks
- Detect attacks
- Reduce damage
- Recover from incidents

### First Principle

Ask:

> "What can we put in place to reduce the risk?"

Example:

```text
Threat
   ↓
Vulnerability
   ↓
Security Control
   ↓
Reduced Risk
```

---

# 2. Three Main Types of Controls

## Preventive Controls

Designed to stop an incident before it happens.

Examples:

- Firewall
- MFA
- Strong passwords
- Access control
- Encryption
- Security patches

Example:

MFA prevents an attacker from accessing an account using only a stolen password.

---

## Detective Controls

Designed to identify suspicious activity or incidents.

Examples:

- SIEM
- IDS
- Security monitoring
- Audit logs
- File integrity monitoring

Example:

A SIEM detects multiple failed login attempts from an unusual location.

---

## Corrective Controls

Designed to reduce damage and restore normal operation after an incident.

Examples:

- Backups
- Disaster recovery
- Incident response
- Malware removal
- System restoration

Example:

Ransomware encrypts a server.

The company restores the data from a clean backup.

---

# 3. Other Important Control Categories

## Technical Controls

Implemented using technology.

Examples:

- Firewall
- Antivirus/EDR
- Encryption
- MFA
- IDS/IPS
- Access control

## Administrative Controls

Policies and procedures created by the organization.

Examples:

- Password policy
- Security policy
- Incident response policy
- Risk assessment
- Security training

## Physical Controls

Protect physical systems and locations.

Examples:

- CCTV
- Door locks
- Security guards
- Biometric access
- Server-room access control

---

# 4. Example — Protecting a Web Application

Suppose a company has an online banking application.

Possible controls:

| Risk | Security Control |
|---|---|
| Stolen password | MFA |
| SQL Injection | Secure coding + WAF |
| Unauthorized access | Authorization |
| Data theft | Encryption |
| Malware | EDR |
| DDoS | DDoS protection |
| Data loss | Backups |
| Suspicious activity | SIEM |

Security is therefore not based on one tool.

> Multiple controls work together.

---

# 5. Defense in Layers

A good security architecture does not depend on a single control.

Example:

```text
Internet
   ↓
Firewall
   ↓
WAF
   ↓
Application
   ↓
Authentication
   ↓
Authorization
   ↓
Database
   ↓
Encryption
   ↓
Monitoring
   ↓
Backup
```

If one control fails, other controls can still reduce the impact.

---

# 6. Security Control Selection

A security analyst should not simply ask:

> "Which security tool should we buy?"

Instead ask:

1. What asset are we protecting?
2. What threat are we concerned about?
3. What vulnerability exists?
4. What is the risk?
5. Which control reduces that risk?
6. Is the control cost-effective?
7. How will we verify that it works?

---

# 7. Real Industry Example

A company discovers that employees are frequently targeted by phishing attacks.

Possible controls:

### Preventive

- Email filtering
- MFA
- Security awareness training

### Detective

- Email security monitoring
- Suspicious-login detection
- SIEM alerts

### Corrective

- Disable compromised accounts
- Reset credentials
- Incident response
- Restore affected systems

This creates multiple layers of protection.

---

# 8. Control vs Tool

A **control** is the security measure.

A **tool** is technology that may implement the control.

Example:

```text
Control:
Detect suspicious network traffic

Possible Tools:
IDS
IPS
SIEM
Network monitoring platform
```

Do not confuse:

> Security objective ≠ Security tool

---

# 9. Practical Security Analyst Workflow

```text
Identify Asset
      ↓
Identify Risk
      ↓
Select Control
      ↓
Implement Control
      ↓
Monitor Control
      ↓
Test Effectiveness
      ↓
Improve
```

Security controls should be continuously reviewed.

A control that worked six months ago may become ineffective because:

- Systems changed
- New vulnerabilities appeared
- Attack techniques evolved
- Business requirements changed

---

# 10. Key Takeaways

- Security controls reduce security risk.
- Preventive controls try to stop attacks.
- Detective controls identify suspicious activity.
- Corrective controls help recover from incidents.
- Controls can be technical, administrative, or physical.
- Organizations should use multiple controls together.
- A security tool is not the same thing as a security control.
- Controls should be tested and continuously improved.

---

# Interview Questions

### Q1. What is a security control?

A safeguard implemented to prevent, detect, respond to, or reduce the impact of security threats.

### Q2. What is a preventive control?

A control designed to prevent a security incident from occurring.

Example: MFA.

### Q3. What is a detective control?

A control designed to detect suspicious activity or security incidents.

Example: SIEM.

### Q4. What is a corrective control?

A control designed to restore systems or reduce damage after an incident.

Example: Backup restoration.

### Q5. What are the three broad categories of security controls?

- Technical
- Administrative
- Physical

### Q6. Why do organizations use multiple controls?

Because no single security control is perfect. Multiple controls provide layered protection and reduce the chance that one failure results in a successful attack.
```