# `02-CIA-Triad.md`

```md
# CIA Triad

The CIA Triad is the foundation of information security.

CIA stands for:

- Confidentiality
- Integrity
- Availability

The goal is to ensure that information is:

> Seen only by authorized people → Not changed improperly → Available when needed

---

# 1. Confidentiality

## What?

Confidentiality means preventing unauthorized people from accessing information.

### First Principle

> "Who is allowed to see this data?"

### Example

A bank customer should only be able to see their own account details.

### Common Controls

- Authentication
- Authorization
- Encryption
- Access control
- Data masking

### Industry Example

A company stores employee salaries in a database.

Only HR and authorized management should access salary information.

If every employee can view it:

> Confidentiality is violated.

---

# 2. Integrity

## What?

Integrity means ensuring that data is accurate, trustworthy, and not modified without authorization.

### First Principle

> "Can I trust that this data has not been improperly changed?"

### Example

An online payment:

```text
Original amount: ₹5,000
        ↓
Transaction
        ↓
Final amount: ₹5,000
```

An attacker changing it to ₹50,000 would be an integrity violation.

### Common Controls

- Hashing
- Digital signatures
- Access control
- File integrity monitoring
- Audit logs

### Industry Example

A company's database contains:

```text
Employee Salary = ₹60,000
```

An unauthorized modification changes it to:

```text
Employee Salary = ₹6,00,000
```

The integrity of the data has been compromised.

---

# 3. Availability

## What?

Availability means authorized users can access systems and data when required.

### First Principle

> "Can the authorized user access the service when they need it?"

### Example

If a banking application goes down during working hours, users cannot perform transactions.

This is an availability problem.

### Common Controls

- Backups
- Redundant servers
- Load balancing
- Disaster recovery
- Failover systems
- DDoS protection
- Monitoring

---

# 4. One System — Three Problems

Consider an e-commerce application.

```text
Customer
   ↓
Web Application
   ↓
API
   ↓
Database
```

### Confidentiality Attack

Attacker accesses another customer's personal information.

### Integrity Attack

Attacker changes the price of a product.

### Availability Attack

Attacker floods the website with traffic and makes it unavailable.

---

# 5. CIA in Real Industry

| CIA | Failure | Example |
|---|---|---|
| Confidentiality | Unauthorized disclosure | Customer data leaked |
| Integrity | Unauthorized modification | Bank balance changed |
| Availability | Service unavailable | Banking website down |

---

# 6. CIA Trade-offs

Security decisions can involve trade-offs.

Example:

Strong encryption can improve:

> Confidentiality

But encryption/decryption can introduce some performance overhead.

Similarly:

Very strict access controls can improve security but may make legitimate access more difficult.

Therefore:

> Security must balance protection with usability and business requirements.

---

# 7. Practical Security Analyst Approach

When investigating an incident, ask:

### Confidentiality

Was sensitive information exposed?

### Integrity

Was any data modified?

### Availability

Was any service disrupted?

This helps determine the **impact of an incident**.

---

# 8. Simple Incident Example

Suppose an attacker compromises a company's server.

They:

1. Download customer records.
2. Modify some records.
3. Shut down the application.

Impact:

```text
Download data → Confidentiality compromised

Modify records → Integrity compromised

Shutdown application → Availability compromised
```

One attack can violate all three parts of the CIA Triad.

---

# 9. Easy Memory Trick

Remember:

```text
C → Can unauthorized people SEE it?
I → Is the data still CORRECT?
A → Can authorized users ACCESS it?
```

---

# 10. Interview Questions

### Q1. What is the CIA Triad?

The CIA Triad consists of Confidentiality, Integrity, and Availability. It represents the three fundamental objectives of information security.

### Q2. Give an example of confidentiality violation.

Unauthorized access to customer personal information.

### Q3. Give an example of integrity violation.

An attacker modifying a bank transaction amount without authorization.

### Q4. Give an example of availability violation.

A DDoS attack making a company's website inaccessible.

### Q5. Can one attack affect all three?

Yes. For example, a ransomware attack can expose data, modify/encrypt files, and make systems unavailable.

---

# Key Takeaways

- CIA is the foundation of security.
- Confidentiality protects information from unauthorized access.
- Integrity protects information from unauthorized modification.
- Availability ensures systems remain accessible.
- Security controls are designed to protect one or more CIA objectives.
- Always evaluate a security incident through the CIA lens.
```