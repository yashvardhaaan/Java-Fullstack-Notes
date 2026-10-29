# `11-Windows-Hardening.md`

# Windows Hardening — Cybersecurity Notes

## 1. First Principle

**Windows hardening** means reducing the attack surface of a Windows system.

Think of a Windows machine as:

```text
Windows System
      ↓
Many Users + Services + Ports + Applications + Features
      ↓
Potential Attack Surface
      ↓
Hardening
      ↓
Reduce unnecessary exposure
      ↓
Better Security
```

The goal is **not** to make everything inaccessible.

The goal is:

> **Allow what is required and remove, restrict, or monitor what is unnecessary.**

---

# 2. Attack Surface

The **attack surface** is everything an attacker could potentially interact with.

Examples:

```text
User Accounts
Open Ports
Network Services
Applications
PowerShell
RDP
SMB
Scheduled Tasks
Browser
Drivers
Firewall Rules
Unused Features
```

Mental model:

```text
More unnecessary exposure
        ↓
Larger attack surface
        ↓
More opportunities for attack
```

Hardening attempts to reduce this.

---

# 3. Principle of Least Privilege

Users and applications should have only the permissions they actually need.

Bad:

```text
Every employee
      ↓
Administrator
```

Better:

```text
Employee
   ↓
Standard User
   ↓
Only required permissions
```

For applications:

```text
Application
     ↓
Required permissions only
```

This limits the damage if an account or application is compromised.

---

# 4. Account Hardening

Review local accounts:

```powershell
Get-LocalUser
```

Check local administrators:

```powershell
Get-LocalGroupMember Administrators
```

Look for:

- Unknown accounts
- Unused accounts
- Unexpected administrators
- Old service accounts

Disable an unused account when appropriate:

```powershell
Disable-LocalUser -Name "username"
```

⚠️ Don't disable accounts blindly. Verify that the account isn't required by Windows, an application, or an organization's management system.

---

# 5. Password Security

Good password policy should encourage:

- Long passwords
- Unique passwords
- Protection against reused credentials
- Appropriate lockout controls

In domain environments, organizations can centrally configure password policies through Group Policy or identity-management controls.

The objective is:

```text
Weak / reused password
        ↓
Credential compromise
        ↓
Potential account takeover
```

---

# 6. Windows Firewall

Windows Defender Firewall controls network traffic based on configured rules.

Check firewall profiles:

```powershell
Get-NetFirewallProfile
```

Check firewall rules:

```powershell
Get-NetFirewallRule
```

Find enabled inbound rules:

```powershell
Get-NetFirewallRule -Direction Inbound -Enabled True
```

Mental model:

```text
Network Traffic
      ↓
Firewall Rule
      ↓
Allow / Block
```

A firewall should block unnecessary exposure while allowing required business traffic.

---

# 7. Network Exposure

Check listening TCP connections:

```powershell
Get-NetTCPConnection -State Listen
```

You can investigate a suspicious listening port:

```text
Port
 ↓
Owning Process
 ↓
Executable
 ↓
Service
 ↓
Why is it listening?
```

For example:

```powershell
Get-NetTCPConnection -State Listen
```

Then investigate the associated process.

The important question isn't simply:

> "Is this port open?"

It is:

> **"Why is this service listening, and should it be?"**

---

# 8. Remove Unnecessary Services

List services:

```powershell
Get-Service
```

Find running services:

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

Investigate a specific service:

```powershell
Get-Service -Name "Spooler"
```

Before disabling a service:

```text
Identify service
      ↓
Understand purpose
      ↓
Check dependencies
      ↓
Confirm it is unnecessary
      ↓
Disable/change configuration
```

⚠️ Disabling Windows services randomly can break the operating system or applications.

---

# 9. Patch Management

One of the most important hardening activities is keeping systems updated.

Conceptually:

```text
Vulnerability
     ↓
Security Update
     ↓
Patch System
     ↓
Reduced Exploitation Risk
```

Check Windows update history through:

**Settings → Windows Update → Update history**

Enterprise environments commonly use centralized patch-management systems.

---

# 10. Microsoft Defender

Microsoft Defender provides built-in security capabilities including malware protection.

Check Defender status:

```powershell
Get-MpComputerStatus
```

This can show information such as:

- Antivirus status
- Real-time protection
- Antispyware status
- Engine information

Check Defender preferences:

```powershell
Get-MpPreference
```

The exact output varies by Windows configuration.

---

# 11. Real-Time Protection

Real-time protection helps detect malicious files and activity as they occur.

Conceptually:

```text
File / Process Activity
        ↓
Defender
        ↓
Detection
        ↓
Allow / Block / Alert
```

Avoid disabling security controls simply to make software run. If something is blocked, investigate why and use appropriate organizational exceptions rather than weakening the entire system.

---

# 12. PowerShell Hardening

PowerShell is extremely useful for administrators but can also be abused by attackers.

Security teams should consider:

- PowerShell logging
- Script Block Logging
- Module logging where appropriate
- Controlled administrative access
- Monitoring suspicious PowerShell execution

Investigate PowerShell processes:

```powershell
Get-Process powershell,pwsh -ErrorAction SilentlyContinue
```

Look for suspicious characteristics such as:

```text
Encoded commands
Unusual parent process
Unexpected user
Execution from temporary directories
Suspicious downloads
```

A PowerShell process isn't automatically malicious.

**Context matters.**

---

# 13. RDP Hardening

RDP is useful for remote administration but can become an attack surface.

Hardening approaches include:

- Restrict RDP exposure
- Use VPN or controlled access paths
- Require strong authentication
- Use MFA where supported
- Restrict which users can connect
- Monitor failed and successful RDP logons
- Avoid exposing RDP directly to the public Internet

Remember:

```text
Internet
   ↓
RDP directly exposed
   ↓
Large attack surface
```

Better:

```text
Internet
   ↓
Controlled access / VPN
   ↓
RDP
```

---

# 14. SMB Hardening

SMB is commonly used for Windows file and printer sharing.

Security concerns include:

- Unnecessary SMB exposure
- Weak permissions
- Legacy SMB configurations
- Excessive network access

Check SMB configuration:

```powershell
Get-SmbServerConfiguration
```

Check SMB shares:

```powershell
Get-SmbShare
```

Security principle:

```text
Required share
    ↓
Correct permissions
    ↓
Restricted network access
```

---

# 15. User Account Control — UAC

**UAC** helps prevent applications from silently performing administrative actions.

Conceptually:

```text
Application requests privileged action
            ↓
UAC
            ↓
User approval / credential prompt
            ↓
Administrative action
```

UAC should generally remain enabled.

---

# 16. Secure Configuration

Hardening should include reviewing:

```text
Accounts
↓
Groups
↓
Services
↓
Firewall
↓
Applications
↓
RDP
↓
SMB
↓
PowerShell
↓
Defender
↓
Updates
↓
Logging
```

This creates a layered defense.

---

# 17. Logging and Monitoring

Hardening isn't only about prevention.

You also need visibility.

Important logs include:

```text
Security
System
Application
PowerShell
Defender
```

For example:

```powershell
Get-WinEvent -LogName Security -MaxEvents 10
```

Security logs allow analysts to investigate:

- Logons
- Failed logons
- Account changes
- Privilege changes
- Process activity

---

# 18. Practical Hardening Scenario

Imagine a Windows workstation has:

```text
Administrator account
RDP enabled
Unused services
Old software
Weak firewall configuration
Limited logging
```

A hardening process might look like:

```text
1. Patch Windows
        ↓
2. Remove unnecessary software
        ↓
3. Review administrator accounts
        ↓
4. Apply least privilege
        ↓
5. Review services
        ↓
6. Restrict RDP
        ↓
7. Review firewall
        ↓
8. Enable security logging
        ↓
9. Verify Defender
        ↓
10. Continuously monitor
```

---

# 19. Small Hands-On Audit Lab

Run these commands on your own Windows machine.

### Users

```powershell
Get-LocalUser
```

### Administrators

```powershell
Get-LocalGroupMember Administrators
```

### Services

```powershell
Get-Service
```

### Listening ports

```powershell
Get-NetTCPConnection -State Listen
```

### Firewall

```powershell
Get-NetFirewallProfile
```

### Defender

```powershell
Get-MpComputerStatus
```

### SMB shares

```powershell
Get-SmbShare
```

### PowerShell processes

```powershell
Get-Process powershell,pwsh -ErrorAction SilentlyContinue
```

Create a simple security inventory:

```text
Users
 ↓
Admins
 ↓
Services
 ↓
Listening Ports
 ↓
Firewall
 ↓
Defender
 ↓
SMB
 ↓
PowerShell
```

Then ask:

> **"What is unnecessary, excessive, outdated, or exposed?"**

---

# 20. Hardening vs Monitoring

These are different.

### Hardening

Prevent or reduce attacks.

```text
Firewall
Least privilege
Patching
MFA
Restricted RDP
```

### Monitoring

Detect attacks.

```text
Event Logs
EDR
SIEM
Alerts
Network monitoring
```

Strong security uses both:

```text
Hardening
   +
Monitoring
   +
Incident Response
```

---

# 21. Defense-in-Depth

Never rely on a single security control.

Example:

```text
Strong Password
      +
MFA
      +
Least Privilege
      +
Firewall
      +
Defender
      +
Patching
      +
Logging
      +
Monitoring
```

If one control fails, others can still reduce the impact.

---

# 22. Interview Questions

### Q1. What is Windows hardening?

Reducing unnecessary attack surface and strengthening security configurations on Windows systems.

### Q2. What is least privilege?

Giving users, applications, and services only the permissions required to perform their tasks.

### Q3. Why is patching important?

Security updates fix vulnerabilities that could otherwise be exploited.

### Q4. Why should RDP be restricted?

Exposed RDP can become an entry point for unauthorized remote access and credential attacks.

### Q5. What does Windows Firewall do?

Controls network traffic according to configured firewall rules.

### Q6. Why is PowerShell important for security?

It is a powerful administrative tool that can be legitimately used by administrators but is also frequently abused by attackers.

### Q7. What is defense-in-depth?

Using multiple independent security controls so that failure of one control doesn't result in complete compromise.

---

# 23. Quick Cheat Sheet

```text
Windows Hardening
→ Reduce attack surface

Least Privilege
→ Minimum required permissions

Get-LocalUser
→ Local users

Get-LocalGroupMember Administrators
→ Local administrators

Get-Service
→ Windows services

Get-NetTCPConnection -State Listen
→ Listening TCP connections

Get-NetFirewallProfile
→ Firewall profiles

Get-NetFirewallRule
→ Firewall rules

Get-MpComputerStatus
→ Defender status

Get-SmbShare
→ SMB shares

Get-WinEvent
→ Windows event logs

RDP
→ Restrict and monitor

SMB
→ Restrict unnecessary exposure

Patching
→ Reduce known vulnerability risk

MFA
→ Stronger authentication

Defense-in-depth
→ Multiple security layers
```

## Core Mental Model

```text
          WINDOWS SYSTEM
                ↓
       ┌────────┴────────┐
       ↓                 ↓
   Attack Surface    Security Controls
       ↓                 ↓
 Accounts              MFA
 Services              Firewall
 Ports                 Defender
 Apps                  Patching
 RDP                   Least Privilege
 PowerShell            Logging
       ↓                 ↓
       └────────┬────────┘
                ↓
          Reduced Risk
                ↓
         Continuous Monitoring
```

# Windows Security Section Complete

You now have the complete sequence:

```text
01 Windows Internals
02 Users & Groups
03 NTFS Permissions
04 Processes & Services
05 Event Logs
06 PowerShell Security
07 Registry
08 Active Directory
09 Kerberos
10 Windows Authentication
11 Windows Hardening
```

This gives you a strong **Windows security foundation for SOC/Cybersecurity Analyst work**.