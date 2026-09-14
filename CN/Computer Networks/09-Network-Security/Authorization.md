````md id="authorization"
# Authorization

## 1. What is Authorization?

**Authorization = deciding what an authenticated user is allowed to do.**

> Authentication = **Who are you?**  
> Authorization = **What can you do?**

```text
User
 ↓
Authentication
 ↓
Identity verified
 ↓
Authorization
 ↓
Permission granted/denied
````

---

## 2. Example

Suppose a user logs into a banking application.

```text
Username + Password
        ↓
 Authentication
        ↓
     "User A"
        ↓
 Authorization
        ↓
Can view balance?     → YES
Can transfer money?   → YES
Can delete account?   → NO
```

---

# 3. Access Control ⭐⭐⭐⭐⭐

Authorization is implemented through **access control**.

A basic access-control decision considers:

```text
Subject + Resource + Action
          ↓
    Access Decision
```

Example:

| Subject | Resource | Action | Result |
| ------- | -------- | ------ | ------ |
| Alice   | File A   | Read   | Allow  |
| Alice   | File A   | Delete | Deny   |
| Admin   | File A   | Delete | Allow  |

---

# 4. Access Control Models ⭐⭐⭐⭐⭐

## 1️⃣ DAC — Discretionary Access Control

The **owner** controls access to a resource.

Example:

```text
Alice owns file.txt
       ↓
Alice decides
who can read/write it
```

Common in traditional file permissions.

### Key idea

**Owner decides.**

---

## 2️⃣ MAC — Mandatory Access Control

Access is controlled by a **central security policy**, not by the resource owner.

Resources/users have security labels.

Example:

```text
User → SECRET
File → TOP SECRET
       ↓
Security policy
       ↓
Access decision
```

Common in high-security environments.

### Key idea

**System/security policy decides.**

---

## 3️⃣ RBAC — Role-Based Access Control ⭐⭐⭐⭐⭐

Permissions are assigned to **roles**, and users are assigned to roles.

```text
User
 ↓
Role
 ↓
Permissions
```

Example:

```text
Yash → Developer → Read Code + Commit Code

Manager → Manager Role → Approve Requests
```

### Advantage

Easy to manage in organizations.

> **RBAC = permissions → roles → users**

---

## 4️⃣ ABAC — Attribute-Based Access Control ⭐⭐⭐⭐

Access depends on attributes.

Attributes may include:

* User
* Resource
* Action
* Location
* Time
* Device
* Department

Example:

```text
User = Employee
Resource = Company Data
Location = Office
Time = Working Hours
       ↓
      ALLOW
```

### Key idea

**ABAC = policy based on attributes.**

---

# 5. DAC vs MAC vs RBAC vs ABAC

| Model | Decision based on      |
| ----- | ---------------------- |
| DAC   | Resource owner         |
| MAC   | Security policy/labels |
| RBAC  | Role                   |
| ABAC  | Attributes + policies  |

🔥 **Very important for interviews.**

---

# 6. Principle of Least Privilege ⭐⭐⭐⭐⭐

Give a user/process **only the permissions required** to perform its job.

Example:

```text
Web server
   ↓
Needs READ access
   ↓
Do NOT give DELETE/ADMIN access
```

### Why?

If an account is compromised:

**Less privilege → less damage.**

---

# 7. Privilege Escalation

Attacker gains permissions greater than originally authorized.

### Types

**Vertical privilege escalation**

```text
Normal User
    ↓
Administrator
```

**Horizontal privilege escalation**

```text
User A
 ↓
Access User B's resources
```

### Remember

* Vertical → **higher privilege**
* Horizontal → **another user's same-level resources**

---

# 8. Access Control List (ACL) ⭐⭐⭐⭐⭐

ACL specifies **who can access what and how**.

Example:

```text
File A
 ├── Alice → Read + Write
 ├── Bob   → Read
 └── Eve   → Deny
```

Common permissions:

* Read
* Write
* Execute
* Delete

---

# 9. ACL vs Capability

### ACL

Associated with the **resource**.

```text
Resource
   ↓
Who can access me?
```

### Capability

Associated with the **subject/user/process**.

```text
User/Process
   ↓
What resources can I access?
```

| ACL                  | Capability         |
| -------------------- | ------------------ |
| Resource-centric     | Subject-centric    |
| Who can access this? | What can I access? |

---

# 10. Authentication vs Authorization ⭐⭐⭐⭐⭐

```text
Authentication
      ↓
     WHO?
      ↓
Identity established
      ↓
Authorization
      ↓
     WHAT?
      ↓
Permissions checked
```

Example:

**Login** → Authentication

**Opening admin dashboard** → Authorization

---

# 🔥 GATE Traps

* Authentication ≠ Authorization.
* Authentication identifies the user.
* Authorization determines permissions.
* **DAC → owner controls**
* **MAC → security policy/labels**
* **RBAC → roles**
* **ABAC → attributes**
* Least privilege minimizes permissions.
* Vertical escalation → higher privileges.
* Horizontal escalation → another user's resources.
* ACL is **resource-centric**.
* Capability is generally **subject-centric**.
* Authorization normally occurs **after authentication**.

---

# ⚡ 30-Second Revision

```text
Authorization
      ↓
"What can you do?"

Access Control
      ↓
DAC → Owner
MAC → Mandatory policy
RBAC → Role
ABAC → Attributes

Least Privilege
      ↓
Minimum required permissions

Privilege Escalation
      ↓
Vertical → Higher privilege
Horizontal → Another user's resources

ACL
      ↓
Resource → Who can access?
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
