# `07-Linux-Networking.md`

# Linux Networking

## 1. First Principle

A network allows processes on different systems to communicate.

Think of communication as:

```text
Application
    ↓
Socket
    ↓
Port
    ↓
IP Address
    ↓
Network Interface
    ↓
Network
```

Example:

```text
Browser
   ↓
TCP connection
   ↓
443
   ↓
192.168.1.10
   ↓
Internet
```

For cybersecurity, the key questions are:

> **Who is communicating with whom, on which port, using which protocol?**

---

# 2. IP Address

An IP address identifies a device/interface on a network.

Check your addresses:

```bash
ip addr
```

Short form:

```bash
ip a
```

Example:

```text
inet 192.168.1.20/24
```

Here:

```text
192.168.1.20 → IP address
/24           → network prefix
```

---

# 3. Network Interfaces

List interfaces:

```bash
ip link
```

Common interfaces:

```text
lo       → Loopback
eth0     → Ethernet
ens33    → Ethernet
wlan0    → Wi-Fi
```

Check loopback:

```bash
ip addr show lo
```

Typical:

```text
127.0.0.1
```

`127.0.0.1` means **this machine itself**.

---

# 4. MAC Address

A MAC address identifies a network interface at the link layer.

```bash
ip link
```

Example:

```text
link/ether 00:11:22:33:44:55
```

Cybersecurity relevance:

- device identification
- network monitoring
- ARP investigations
- network access control

---

# 5. Routing

Your system needs to know:

> Where should this packet go?

View routing table:

```bash
ip route
```

Example:

```text
default via 192.168.1.1 dev eth0
192.168.1.0/24 dev eth0
```

Meaning:

```text
192.168.1.0/24
      ↓
Local network

Everything else
      ↓
192.168.1.1
      ↓
Default gateway
```

---

# 6. Test Connectivity

Use:

```bash
ping 8.8.8.8
```

It tests basic IP connectivity using ICMP.

Test a domain:

```bash
ping google.com
```

If this works, you have both:

```text
Network connectivity
        +
DNS resolution
```

But `ping` being blocked doesn't necessarily mean the host is unreachable.

---

# 7. DNS

DNS converts names into IP addresses.

```text
google.com
     ↓
IP address
```

Query DNS:

```bash
dig google.com
```

or:

```bash
nslookup google.com
```

Example:

```bash
dig google.com
```

Look for:

```text
ANSWER SECTION
```

You may see an `A` record containing an IPv4 address.

---

# 8. Ports

An IP identifies the host.

A **port identifies a network service/application endpoint**.

Common ports:

| Port | Service |
|---:|---|
| 22 | SSH |
| 25 | SMTP |
| 53 | DNS |
| 80 | HTTP |
| 443 | HTTPS |
| 3306 | MySQL |
| 5432 | PostgreSQL |
| 6379 | Redis |

Think:

```text
IP address = Which machine?
Port = Which service?
```

---

# 9. Listening Ports

Find services listening for connections:

```bash
ss -lnt
```

Meaning:

```text
-l → listening
-n → numeric addresses/ports
-t → TCP
```

Include processes:

```bash
sudo ss -lntp
```

Example:

```text
LISTEN 0 128 0.0.0.0:22
```

`0.0.0.0:22` means the service is listening on port 22 on all IPv4 interfaces.

---

# 10. TCP vs UDP

### TCP

Connection-oriented.

```text
Client
  ↓
Connection
  ↓
Server
  ↓
Data
```

Used by many applications such as:

- HTTPS
- SSH
- SMTP

### UDP

Connectionless and lightweight.

Commonly used by:

- DNS
- DHCP
- streaming/real-time applications

View UDP listeners:

```bash
ss -lun
```

---

# 11. Active Connections

View TCP connections:

```bash
ss -tn
```

Include process information:

```bash
sudo ss -tnp
```

Example:

```text
ESTAB  0  0  192.168.1.20:50000  93.184.216.34:443
```

Interpretation:

```text
Local IP:Port
        ↓
192.168.1.20:50000

Remote IP:Port
        ↓
93.184.216.34:443
```

The remote service is using HTTPS.

---

# 12. Network States

Common TCP states:

| State | Meaning |
|---|---|
| `LISTEN` | Waiting for connections |
| `ESTAB` | Connection established |
| `TIME-WAIT` | Waiting before closing completely |
| `CLOSE-WAIT` | Remote side closed connection |

For security analysts:

```text
LISTEN
   ↓
What service is exposed?
```

and:

```text
ESTAB
   ↓
Who is this machine communicating with?
```

---

# 13. Curl

`curl` is useful for testing HTTP/HTTPS.

```bash
curl https://example.com
```

Get only headers:

```bash
curl -I https://example.com
```

Follow redirects:

```bash
curl -L https://example.com
```

Verbose connection information:

```bash
curl -v https://example.com
```

Cybersecurity uses:

- API testing
- HTTP troubleshooting
- response inspection
- security testing

---

# 14. Traceroute

See the path toward a destination:

```bash
traceroute google.com
```

On some systems:

```bash
tracepath google.com
```

Conceptually:

```text
Your PC
  ↓
Router
  ↓
ISP
  ↓
Internet routers
  ↓
Destination
```

Useful for network troubleshooting.

---

# 15. ARP / Neighbor Discovery

For IPv4, systems use ARP to associate:

```text
IP address
    ↓
MAC address
```

View neighbors:

```bash
ip neigh
```

Example:

```text
192.168.1.1 dev eth0 lladdr aa:bb:cc:dd:ee:ff REACHABLE
```

This tells you the MAC address associated with the local gateway.

---

# 16. Network Troubleshooting Mental Model

When something cannot connect:

```text
1. Interface?
      ↓
2. IP address?
      ↓
3. Routing?
      ↓
4. DNS?
      ↓
5. Port?
      ↓
6. Firewall?
      ↓
7. Application?
```

Useful commands:

```bash
ip addr
ip route
ping <IP>
dig <domain>
ss -lntp
curl -v <URL>
```

---

# 17. Cybersecurity Scenario

Suppose you find a suspicious process:

```text
PID 2500
```

First identify it:

```bash
ps -fp 2500
```

Then check its network connections:

```bash
sudo ss -tnp
```

You discover:

```text
python3 → 203.0.113.50:4444
```

Now investigate:

```text
Which process?
      ↓
Which user?
      ↓
Which executable?
      ↓
Which remote IP?
      ↓
Which port?
      ↓
Why is it communicating?
```

A suspicious outbound connection can be an indicator of:

- command-and-control communication
- data exfiltration
- unauthorized remote access
- malware activity

**A connection alone is not proof of compromise.** It needs investigation and context.

---

# 18. Basic Network Exposure Audit

Check listening TCP services:

```bash
sudo ss -lntp
```

Check UDP:

```bash
sudo ss -lunp
```

Then create a simple inventory:

```text
Port 22  → SSH
Port 80  → Web server
Port 5432 → PostgreSQL
```

Ask:

> Does every exposed service need to be accessible?

This is the foundation of **attack-surface reduction**.

---

# 19. Firewall

A firewall controls network traffic according to rules.

On systems using UFW:

```bash
sudo ufw status
```

Enable it:

```bash
sudo ufw enable
```

Allow SSH:

```bash
sudo ufw allow 22/tcp
```

Allow HTTP:

```bash
sudo ufw allow 80/tcp
```

Remove a rule:

```bash
sudo ufw delete allow 80/tcp
```

**Be careful with firewall changes over SSH**, because a bad rule can disconnect you.

---

# 20. Small Practical Lab

### Step 1 — Find your IP

```bash
ip addr
```

### Step 2 — Find your gateway

```bash
ip route
```

### Step 3 — Test connectivity

```bash
ping 8.8.8.8
```

### Step 4 — Test DNS

```bash
dig google.com
```

### Step 5 — Find listening ports

```bash
sudo ss -lntp
```

### Step 6 — Test HTTPS

```bash
curl -I https://example.com
```

### Step 7 — Check network neighbors

```bash
ip neigh
```

You have now performed a basic Linux network investigation.

---

# 21. Important Commands

```bash
ip addr
ip link
ip route
ip neigh

ping <IP>
dig <domain>
nslookup <domain>

ss -lnt
ss -lntp
ss -tnp
ss -lunp

curl <URL>
curl -I <URL>
curl -v <URL>

traceroute <domain>
tracepath <domain>

sudo ufw status
```

---

# 22. Interview Questions

### Q1. Difference between IP and port?

```text
IP   → identifies the host/interface
Port → identifies the service endpoint
```

### Q2. What is `ss`?

A Linux utility for viewing sockets, listening ports, and network connections.

### Q3. What does `ss -lntp` show?

```text
-l → listening
-n → numeric
-t → TCP
-p → process
```

### Q4. What is DNS?

A system that resolves domain names to IP addresses and other DNS records.

### Q5. How would you investigate a suspicious outbound connection?

```text
ss -tnp
   ↓
Identify PID
   ↓
ps -fp PID
   ↓
Identify executable
   ↓
Check user
   ↓
Check destination IP/port
   ↓
Investigate whether communication is legitimate
```

---

# 23. Quick Cheat Sheet

```bash
# Interface / IP
ip addr
ip link

# Routing
ip route

# Connectivity
ping 8.8.8.8

# DNS
dig google.com

# Listening ports
sudo ss -lntp

# Active connections
sudo ss -tnp

# UDP
sudo ss -lunp

# HTTP testing
curl -I https://example.com
curl -v https://example.com

# Network neighbors
ip neigh

# Firewall
sudo ufw status
```

## Core Mental Model

```text
Process
   ↓
Socket
   ↓
Protocol
   ↓
IP
   ↓
Port
   ↓
Remote Host
```

For a cybersecurity analyst, Linux networking is mainly about being able to answer:

> **What is communicating, where is it communicating, through which port/protocol, and is that communication expected?**

**Next:** `08-Linux-Logs.md`