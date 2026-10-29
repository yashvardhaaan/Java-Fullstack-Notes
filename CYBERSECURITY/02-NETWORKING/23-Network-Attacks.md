Absolutely. For your **Cybersecurity Analyst preparation**, network attacks should be a separate detailed note. I’ll keep it **practical and industry-oriented**, with:

**Attack → How it works → Impact → Prevention → Detection → Analyst response → Real example**

### `Network-Attacks.md`

```md
# Network Attacks

## 1. What is a Network Attack?

A network attack is an attempt to:

- Gain unauthorized access
- Steal information
- Modify traffic
- Disrupt services
- Move through a network
- Identify vulnerable systems

### First Principle

Every network attack generally targets one or more of:

```text
Confidentiality → Steal / Intercept data
Integrity       → Modify communication
Availability    → Disrupt services
Access          → Gain unauthorized entry
```

---

# 2. Network Attack Lifecycle

A typical network attack can follow:

```text
Reconnaissance
      ↓
Scanning
      ↓
Initial Access
      ↓
Exploitation
      ↓
Privilege / Credential Abuse
      ↓
Lateral Movement
      ↓
Data Access / Exfiltration
      ↓
Impact
```

A Security Analyst should therefore look for suspicious activity at every stage.

---

# 3. Network Scanning

## What?

Attackers scan networks to discover:

- Live hosts
- Open ports
- Running services
- Operating systems
- Network devices

### Example

An attacker discovers:

```text
Server
IP: 10.0.0.20

Open:
22  → SSH
80  → HTTP
443 → HTTPS
```

The attacker can then investigate whether these services contain vulnerabilities.

## Prevention

- Close unnecessary ports
- Disable unused services
- Use firewalls
- Restrict management interfaces
- Network segmentation
- Do not expose internal services directly to the internet

## Detection

Look for:

- Large numbers of connection attempts
- One source contacting many IP addresses
- One source contacting many ports
- Repeated failed connections
- Sequential port access

### SIEM Detection Logic

```text
IF
one source IP contacts
many destination ports
within a short period

THEN
generate possible port-scan alert
```

---

# 4. DoS / DDoS

## What?

A Denial-of-Service attack attempts to make a service unavailable.

### DoS

Attack originates from a single or limited source.

### DDoS

Attack originates from many distributed systems.

```text
         Attacker Network
        /      |      \
       /       |       \
   Bot       Bot      Bot
      \       |       /
       \      |      /
        Target Server
```

## Impact

- Website unavailable
- High bandwidth usage
- Server resource exhaustion
- Increased latency
- Business disruption

## Prevention

Use:

- Rate limiting
- DDoS protection services
- CDN
- Load balancing
- Traffic filtering
- Firewall rules
- Capacity planning
- Network redundancy

## Detection

Monitor:

- Traffic volume
- Requests per second
- Bandwidth utilization
- Connection counts
- CPU/memory usage
- Sudden traffic spikes

### Example Detection

Normal:

```text
500 requests/sec
```

Suddenly:

```text
100,000 requests/sec
```

This is a strong indicator of abnormal traffic.

## Analyst Response

```text
Detect spike
    ↓
Identify affected service
    ↓
Determine traffic source/type
    ↓
Apply filtering/rate limiting
    ↓
Activate DDoS protection
    ↓
Monitor recovery
```

---

# 5. Man-in-the-Middle (MITM)

## What?

An attacker positions themselves between two communicating parties.

Normal:

```text
Client  ←────────→  Server
```

MITM:

```text
Client
   ↓
Attacker
   ↓
Server
```

The attacker may attempt to observe or manipulate communication.

## Possible Impact

- Credential theft
- Session interception
- Data modification
- Information disclosure

## Prevention

- HTTPS/TLS
- Certificate validation
- Secure Wi-Fi
- VPN where appropriate
- Strong authentication
- Avoid insecure protocols
- Network segmentation

## Detection

Look for:

- Certificate warnings
- Unexpected certificates
- ARP anomalies
- Unexpected network gateways
- Duplicate IP/MAC relationships
- Suspicious DNS behavior

Network monitoring tools such as IDS/IPS and packet analysis can help investigate.

---

# 6. ARP Spoofing

## What?

ARP maps IP addresses to MAC addresses on local networks.

ARP spoofing abuses this mechanism to associate an attacker's MAC address with another host's IP address.

Conceptually:

```text
Victim
  ↓
"I want the gateway"

ARP table
  ↓
Attacker MAC
```

Traffic may then pass through the attacker.

## Impact

- Traffic interception
- MITM attacks
- Session theft
- Network disruption

## Prevention

- Dynamic ARP Inspection
- Secure switch configuration
- Network segmentation
- Static ARP entries where appropriate
- Network access control

## Detection

Monitor for:

- IP-to-MAC changes
- Duplicate IP addresses
- Unexpected gateway MAC changes
- ARP table anomalies

### Practical Analyst Check

Compare:

```text
Expected Gateway MAC
        vs
Observed Gateway MAC
```

Unexpected changes require investigation.

---

# 7. DNS Attacks

DNS translates domain names into IP addresses.

Example:

```text
example.com
     ↓
DNS
     ↓
93.x.x.x
```

Attackers may abuse DNS in several ways.

---

## DNS Spoofing

Attacker attempts to provide a false DNS response.

Example:

```text
bank.example
      ↓
False DNS Response
      ↓
Attacker-controlled destination
```

## DNS Tunneling

DNS queries can be abused to transfer data or communicate with malicious infrastructure.

## DNS Amplification

Attackers abuse DNS infrastructure to amplify traffic toward a target.

---

## Prevention

- Use trusted DNS resolvers
- DNS security monitoring
- DNSSEC where appropriate
- Restrict unnecessary external DNS access
- Network filtering
- Rate limiting

## Detection

Look for:

- Unusually long DNS queries
- High DNS query volume
- Frequent queries to suspicious domains
- Random-looking subdomains
- Unusual DNS response sizes
- DNS requests from systems that normally don't generate them

### SIEM Example

```text
IF
DNS query frequency suddenly increases
AND
domains are unusual or newly observed

THEN
investigate possible DNS abuse
```

---

# 8. DHCP Attacks

DHCP automatically provides network configuration.

An attacker may attempt to introduce a rogue DHCP server.

Normal:

```text
Client
  ↓
Legitimate DHCP
  ↓
IP + Gateway + DNS
```

Attack:

```text
Client
  ↓
Rogue DHCP Server
  ↓
Malicious Network Configuration
```

## Impact

- Traffic redirection
- Wrong DNS server
- Network disruption
- MITM opportunity

## Prevention

- DHCP Snooping
- Trusted switch ports
- Network access control
- Proper switch configuration

## Detection

Look for:

- Multiple DHCP servers
- Unexpected DHCP responses
- Clients receiving unusual gateways
- Unexpected DNS server addresses

---

# 9. MAC Flooding

Switches maintain MAC address tables.

An attacker may attempt to overwhelm the table with many MAC addresses.

If the switch cannot properly maintain the table, traffic handling can be affected.

## Impact

Potential traffic exposure and network disruption.

## Prevention

- Port security
- MAC address limits
- Switch security configuration
- Network segmentation

## Detection

Look for:

- Unusually high number of MAC addresses on one port
- Frequent MAC address changes
- Switch security alerts
- Port-security violations

---

# 10. VLAN Hopping

VLANs separate network traffic logically.

VLAN hopping attempts to access traffic belonging to another VLAN.

## Prevention

- Disable unnecessary trunking
- Explicitly configure trunk ports
- Avoid using native VLAN unnecessarily
- Proper VLAN configuration
- Switch hardening

## Detection

Look for:

- Unexpected trunk negotiation
- Unauthorized trunk ports
- VLAN configuration changes
- Suspicious traffic between VLANs

---

# 11. Credential Attacks Over the Network

Attackers may attempt to compromise accounts using network-accessible services.

Common examples:

- Brute force
- Password spraying
- Credential stuffing

---

## Brute Force

Repeatedly attempts many passwords against an account.

```text
Account
   ↑
Password attempt
Password attempt
Password attempt
...
```

## Password Spraying

Uses one or a small number of common passwords against many accounts.

Example:

```text
user1 → CommonPassword
user2 → CommonPassword
user3 → CommonPassword
user4 → CommonPassword
```

This can avoid some account-lockout mechanisms.

## Credential Stuffing

Uses previously leaked username/password combinations against another service.

---

## Prevention

- MFA
- Strong passwords
- Passwordless authentication where appropriate
- Account lockout/rate limiting
- Conditional access
- Disable legacy authentication
- Monitor authentication events

## Detection

Look for:

- Many failed logins
- One source attacking many accounts
- One account receiving many attempts
- Impossible travel
- Unusual login locations
- New device authentication

---

# 12. Session Hijacking

A session allows a user to remain authenticated after login.

If an attacker obtains a valid session token, they may attempt to use that session.

## Prevention

- HTTPS everywhere
- Secure cookies
- HttpOnly cookies
- SameSite cookies
- Session expiration
- Session rotation
- Re-authentication for sensitive actions
- MFA

## Detection

Look for:

- Same session used from unusual locations
- Sudden device changes
- Abnormal session behavior
- Multiple simultaneous locations
- Unusual API activity

---

# 13. Packet Sniffing

Packet sniffing means capturing network traffic.

Example:

```text
Client ─────── Network ─────── Server
                  ↑
               Capture
```

If communication is unencrypted, sensitive information may be exposed.

## Prevention

- TLS/HTTPS
- Secure VPN
- Encrypted protocols
- Secure Wi-Fi
- Network segmentation

## Detection

Packet capture itself can be difficult to detect directly.

Instead monitor for:

- Unauthorized network interfaces
- Promiscuous-mode indicators
- Suspicious network devices
- Unexpected traffic capture infrastructure

---

# 14. Network-Based Exploitation

Attackers may exploit vulnerable network-facing services.

Examples:

- Vulnerable VPN
- Vulnerable web server
- Vulnerable SSH service
- Vulnerable network appliance
- Outdated software

Attack flow:

```text
Internet
   ↓
Exposed Service
   ↓
Vulnerability
   ↓
Exploitation
   ↓
Unauthorized Access
```

## Prevention

- Patch management
- Vulnerability scanning
- Remove unnecessary services
- Firewall restrictions
- Secure configurations
- Network segmentation
- Strong authentication

## Detection

Monitor:

- IDS/IPS alerts
- Exploit signatures
- Unusual requests
- Unexpected process creation
- Suspicious outbound connections
- Authentication anomalies

---

# 15. Lateral Movement

After compromising one system, an attacker may attempt to move to other systems.

Example:

```text
Compromised Laptop
       ↓
Internal Server
       ↓
Database Server
       ↓
Domain Controller
```

## Prevention

- Network segmentation
- Least privilege
- MFA
- Privileged Access Management
- Disable unnecessary protocols
- Restrict administrative access

## Detection

Look for:

- New internal connections
- Unusual remote logins
- Administrative activity from normal workstations
- Unexpected SMB/RDP/SSH activity
- One account accessing many systems

---

# 16. Data Exfiltration

Data exfiltration is unauthorized transfer of data outside the organization.

Example:

```text
Internal Database
      ↓
Compromised System
      ↓
External Server
      ↓
Stolen Data
```

## Prevention

- Data Loss Prevention (DLP)
- Egress filtering
- Network segmentation
- Least privilege
- Encryption
- Access controls

## Detection

Look for:

- Large outbound transfers
- Unusual destinations
- Data transfer outside business hours
- Unexpected cloud-storage uploads
- Abnormal DNS traffic
- Unusual encrypted outbound connections

---

# 17. Network Attack Detection Stack

A professional SOC does not rely on one detection mechanism.

Typical architecture:

```text
Network Traffic
      ↓
Firewall Logs
      ↓
IDS / IPS
      ↓
DNS Logs
      ↓
VPN Logs
      ↓
Endpoint Logs
      ↓
Authentication Logs
      ↓
SIEM
      ↓
SOC Analyst
```

The SIEM correlates events from multiple sources.

---

# 18. Important Network Logs

A Security Analyst should understand:

### Firewall Logs

Useful for:

- Allowed connections
- Blocked connections
- Source IP
- Destination IP
- Port
- Protocol

### DNS Logs

Useful for:

- Domain lookups
- Suspicious domains
- DNS tunneling indicators
- Malware communication

### VPN Logs

Useful for:

- Login attempts
- Successful logins
- Source locations
- Devices
- Session duration

### IDS/IPS Logs

Useful for:

- Attack signatures
- Suspicious traffic
- Exploit attempts
- Scanning

### Authentication Logs

Useful for:

- Failed logins
- Successful logins
- Account attacks
- Privilege changes

---

# 19. Practical Detection Process

When a network alert appears:

```text
Alert
 ↓
Validate
 ↓
Identify Source
 ↓
Identify Destination
 ↓
Check Timeline
 ↓
Check Related Logs
 ↓
Determine Attack Type
 ↓
Determine Impact
 ↓
Contain
 ↓
Remediate
 ↓
Document
```

---

# 20. Example SOC Investigation

Alert:

```text
Multiple failed SSH login attempts
```

Analyst checks:

```text
Source IP
     ↓
Number of attempts
     ↓
Target systems
     ↓
Accounts targeted
     ↓
Successful login?
     ↓
Post-login activity?
```

If a successful login occurred after hundreds of failed attempts:

```text
Possible brute-force compromise
```

Next actions may include:

- Disable/secure affected account
- Block malicious source where appropriate
- Check successful sessions
- Review commands/processes
- Search for lateral movement
- Reset credentials
- Document the incident

---

# 21. Network Attack Prevention Checklist

## Network

- Firewall properly configured
- Network segmentation
- Unnecessary ports closed
- Secure remote access
- Secure Wi-Fi
- Network devices hardened

## Identity

- MFA
- Strong authentication
- Least privilege
- Privileged access management

## Systems

- Regular patching
- Vulnerability management
- Secure configurations
- Endpoint protection

## Monitoring

- Centralized logging
- IDS/IPS
- SIEM
- DNS monitoring
- Network traffic monitoring

## Data

- Encryption
- DLP
- Backups
- Egress controls

---

# 22. Detection vs Prevention

Remember:

```text
PREVENTION
   ↓
Stop the attack

DETECTION
   ↓
Identify the attack

RESPONSE
   ↓
Contain and investigate

RECOVERY
   ↓
Restore normal operations
```

A mature security program requires all four.

---

# 23. Quick Reference Table

| Attack | Main Goal | Prevention | Detection |
|---|---|---|---|
| Network Scanning | Discover systems | Firewall, reduce exposure | Connection/port patterns |
| DDoS | Disrupt service | DDoS protection, rate limiting | Traffic spikes |
| MITM | Intercept traffic | TLS, secure networks | Certificate/ARP anomalies |
| ARP Spoofing | Redirect local traffic | DHCP/ARP protections | MAC/IP anomalies |
| DNS Attacks | Redirect/abuse DNS | Secure DNS, filtering | Abnormal DNS patterns |
| DHCP Attack | Manipulate network config | DHCP Snooping | Rogue DHCP responses |
| MAC Flooding | Disrupt switching | Port security | MAC anomalies |
| VLAN Hopping | Cross VLAN boundaries | Secure switch configuration | VLAN/trunk anomalies |
| Brute Force | Obtain credentials | MFA, rate limiting | Failed-login patterns |
| Session Hijacking | Abuse session | Secure cookies, TLS | Abnormal session behavior |
| Packet Sniffing | Capture traffic | Encryption | Network anomalies |
| Lateral Movement | Move internally | Segmentation, least privilege | Unusual internal connections |
| Data Exfiltration | Steal data | DLP, egress controls | Large/unusual outbound traffic |

---

# 24. Key Analyst Mindset

Do not investigate an alert in isolation.

Always ask:

> Who initiated the connection?

> What was the destination?

> What service/port was involved?

> Was the connection successful?

> What happened immediately before and after it?

> Is this normal behavior for this user/device?

> Did the activity affect other systems?

> What is the business impact?

---

# 25. Key Takeaways

- Network attacks target confidentiality, integrity, availability, or access.
- Attackers commonly scan before attempting exploitation.
- Network segmentation limits lateral movement.
- Encryption protects data in transit.
- IDS/IPS helps detect suspicious network activity.
- SIEM correlates network, endpoint, authentication, and other logs.
- Prevention alone is insufficient.
- Detection, response, and recovery are equally important.
- The strongest detection comes from correlating multiple sources of evidence.
- A Security Analyst should always investigate the full timeline rather than a single alert.
```

### Practical tools you should learn alongside this

For a **Cyber Security Analyst** role, I would prioritize:

| Area | Tools to learn |
|---|---|
| Packet analysis | Wireshark |
| Network scanning/visibility | Nmap |
| IDS/IPS | Snort / Suricata |
| SIEM | Microsoft Sentinel / Splunk |
| Network traffic | Zeek |
| DNS analysis | Wireshark + DNS logs |
| Firewall analysis | pfSense / enterprise firewall concepts |
| Linux networking | `ip`, `ss`, `tcpdump`, `curl`, `dig` |
| Windows networking | `ipconfig`, `netstat`, PowerShell |
| Threat investigation | SIEM + Wireshark + endpoint logs |

**Important:** don't just memorize the attacks. For each one, practice the cycle:

```text
Generate/observe traffic
        ↓
Capture
        ↓
Identify indicators
        ↓
Detect the attack
        ↓
Investigate logs
        ↓
Apply prevention
        ↓
Verify the control
```

That is much closer to how you'll actually work as a **SOC/Cybersecurity Analyst**.