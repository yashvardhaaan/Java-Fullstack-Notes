# `08-SQL-Injection.md`

# SQL Injection (SQLi)

## 1. First Principle

**SQL Injection occurs when untrusted user input is incorrectly combined with SQL code, allowing the input to change the intended database query.**

Mental model:

```text
User Input
    ↓
Application
    ↓
Unsafe SQL Construction
    ↓
Database interprets input as SQL
```

The core mistake is:

> **Treating data as executable SQL code.**

---

# 2. Normal SQL Query

Suppose an application needs a user by email.

```sql
SELECT id, name
FROM users
WHERE email = 'user@example.com';
```

The application should treat:

```text
user@example.com
```

as **data**.

---

# 3. Vulnerable Query Construction

A dangerous pattern is dynamically concatenating input into SQL:

```java
String query =
    "SELECT * FROM users WHERE email = '" + email + "'";
```

Conceptually:

```text
SQL code
   +
User input
   ↓
One SQL statement
```

If the input changes the structure of the SQL statement, the database may execute something different from what the developer intended.

---

# 4. Why SQL Injection Happens

The problem is **not SQL itself**.

The problem is unsafe construction of SQL.

```text
Safe:
SQL structure + parameterized data

Unsafe:
SQL structure + string concatenation + untrusted input
```

---

# 5. Parameterized Queries

The primary defense is a **parameterized query / prepared statement**.

Instead of:

```java
String query =
    "SELECT * FROM users WHERE email = '" + email + "'";
```

use:

```java
String query =
    "SELECT * FROM users WHERE email = ?";
```

Then bind the value separately:

```java
PreparedStatement ps =
    connection.prepareStatement(query);

ps.setString(1, email);
```

The database understands:

```text
SQL structure
+
Parameter value
```

as separate things.

---

# 6. Why Parameterization Works

Conceptually:

```text
             SQL
              +
        Parameter Value
              ↓
        Database Driver
              ↓
       SQL structure remains
       separate from data
```

Even if the input contains SQL-looking characters, it is treated as a parameter rather than automatically becoming part of the SQL command.

---

# 7. SQL Injection Types

Common categories include:

```text
In-band SQL Injection
Blind SQL Injection
Time-based SQL Injection
Error-based SQL Injection
```

---

# 8. In-Band SQL Injection

The attacker obtains results through the same application channel used for the attack.

Conceptually:

```text
Attacker
   ↓
Web Application
   ↓
Database
   ↓
Application response
   ↓
Attacker
```

Two common forms include:

```text
Error-based
Union-based
```

---

# 9. Error-Based SQL Injection

An application may accidentally expose database errors.

Example:

```text
Application
    ↓
Database error
    ↓
Detailed error returned to user
```

Database errors may reveal:

```text
Database type
Table names
Column names
Query structure
```

Therefore production applications should avoid exposing detailed database errors to users.

Instead:

```text
User
 ↓
Generic error message

Server logs
 ↓
Detailed diagnostic information
```

---

# 10. Blind SQL Injection

Sometimes the application doesn't return database results or errors.

The attacker instead observes differences in application behavior.

For example:

```text
Condition A
   ↓
Normal response

Condition B
   ↓
Different response
```

The attacker may infer information from those differences.

Blind SQLi can also involve timing behavior.

---

# 11. Time-Based SQL Injection

A vulnerable application may reveal information through response timing.

Conceptually:

```text
Input
 ↓
Database condition
 ↓
Different database processing time
 ↓
Different HTTP response time
```

Repeated observations may allow information to be inferred.

This is why secure parameterization is essential even when the application doesn't display database errors.

---

# 12. ORM Does Not Automatically Mean "No SQLi"

Frameworks such as:

```text
Hibernate
JPA
Spring Data JPA
```

provide strong abstractions.

But developers can still introduce vulnerabilities through:

```text
Native SQL
Dynamic queries
Unsafe string construction
Improper query building
```

Example:

```java
entityManager.createNativeQuery(
    "SELECT * FROM users WHERE name = '" + name + "'"
);
```

Using an ORM does not remove the need for secure query construction.

---

# 13. Spring Data JPA Example

Prefer parameterized repository queries.

For example:

```java
@Query("SELECT u FROM User u WHERE u.email = :email")
Optional<User> findByEmail(@Param("email") String email);
```

Here:

```text
:email
```

is treated as a parameter rather than concatenated SQL code.

For simple lookups, derived queries can be even cleaner:

```java
Optional<User> findByEmail(String email);
```

---

# 14. Industry Example — E-Commerce Search

Suppose your application has:

```text
GET /api/products?search=laptop
```

The backend searches the database.

Unsafe architecture:

```text
Search input
    ↓
String concatenation
    ↓
SQL query
    ↓
Database
```

Secure architecture:

```text
Search input
    ↓
Validation
    ↓
Parameterized query
    ↓
Database
```

---

# 15. SQL Injection Impact

Successful SQL injection can potentially affect:

```text
Confidentiality
→ Read unauthorized data

Integrity
→ Modify database records

Availability
→ Damage/disrupt database operations

Authentication
→ Potentially bypass application logic

Authorization
→ Potentially access unintended data
```

Impact depends heavily on:

```text
Database permissions
Application privileges
Query type
Database configuration
Network isolation
```

---

# 16. Least Privilege

The application's database account should have only the permissions it actually needs.

Bad architecture:

```text
Web Application
      ↓
Database
      ↓
Administrator account
```

Better:

```text
Web Application
      ↓
Restricted DB account
      ↓
Only required tables/operations
```

If SQL injection occurs, least privilege can significantly limit the damage.

---

# 17. Input Validation

Validation is useful but **not a replacement for parameterization**.

Example:

```text
Age
→ Must be an integer

Email
→ Expected email format
```

But don't rely on:

```text
"Remove dangerous SQL characters"
```

as your primary SQL injection defense.

Why?

Because SQL syntax is complex, and manually trying to identify every dangerous pattern is error-prone.

Use:

```text
Parameterized queries
+
Appropriate validation
```

---

# 18. Stored Procedures

Stored procedures can help in some architectures, but they are not automatically secure.

This can still be dangerous:

```text
Stored Procedure
      ↓
Dynamic SQL built unsafely
      ↓
SQL Injection
```

Security depends on how the procedure handles input.

---

# 19. SQL Injection vs XSS

| SQL Injection | XSS |
|---|---|
| Targets database/query layer | Targets browser/client |
| Input becomes SQL | Input becomes executable web content |
| Main defense: parameterization | Main defense: output encoding/safe DOM |
| Backend/database issue | Browser/application rendering issue |

Mental model:

```text
SQLi
User Input → SQL → Database

XSS
User Input → HTML/JS → Browser
```

---

# 20. Small Hands-On Lab

Use a deliberately vulnerable local application or training environment.

Create a database:

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT
);
```

Insert test data:

```sql
INSERT INTO users VALUES
(1, 'Alice', 'alice@example.com');

INSERT INTO users VALUES
(2, 'Bob', 'bob@example.com');
```

First understand the vulnerable pattern conceptually:

```text
SQL string
+
User input
```

Then implement the secure version using a parameterized query.

For Java/JDBC:

```java
String sql =
    "SELECT * FROM users WHERE email = ?";

PreparedStatement ps =
    connection.prepareStatement(sql);

ps.setString(1, email);
```

The goal is to understand **why the query structure remains separate from the input**.

---

# 21. Testing Methodology

For an authorized application-security assessment:

```text
1. Identify database-backed inputs
2. Find search/login/filter/API parameters
3. Determine how queries are constructed
4. Look for string concatenation
5. Review ORM/native query usage
6. Test safely in a controlled environment
7. Check application/database error handling
8. Verify parameterization
9. Review database privileges
```

For real systems, use authorized testing environments and avoid destructive database operations.

---

# 22. SOC Relevance

SQL injection can generate recognizable telemetry.

A SOC analyst may investigate:

```text
Repeated unusual requests
Database errors
Unexpected 4xx/5xx responses
Abnormal query patterns
Web-server/database communication anomalies
Unexpected data access
```

Example:

```text
Internet
   ↓
Web Server
   ↓
Many suspicious requests
   ↓
Database errors
   ↓
Unusual database activity
```

Correlation is important.

A single malformed request does not prove SQL injection.

---

# 23. Secure Architecture

A strong architecture looks like:

```text
User Input
    ↓
Input Validation
    ↓
Application Logic
    ↓
Parameterized Query
    ↓
Database
```

Plus:

```text
Least Privilege
+
Secure Error Handling
+
Logging/Monitoring
+
Network Segmentation
```

---

# 24. Common Mistakes

### ❌ String concatenation

```java
"SELECT ... WHERE id = " + id
```

Avoid for untrusted input.

### ❌ Blacklisting SQL keywords

Not a reliable primary defense.

### ❌ Assuming ORM makes everything secure

Unsafe native/dynamic queries can still be vulnerable.

### ❌ Running the application as DB administrator

Violates least privilege.

### ❌ Exposing database errors

Return safe messages to users and log detailed diagnostics securely.

### ❌ Relying only on input validation

Parameterization is the key defense.

---

# 25. Interview Questions

### Q1. What is SQL Injection?

A vulnerability where untrusted input changes the intended SQL query executed by the database.

### Q2. Primary defense?

```text
Parameterized queries / prepared statements
```

### Q3. Does input validation prevent SQL injection?

It can reduce risk, but it should not replace parameterized queries.

### Q4. Does using Hibernate/JPA eliminate SQL injection?

No. Unsafe native/dynamic queries can still introduce SQL injection.

### Q5. Why use least privilege?

To limit the impact if the application's database credentials are compromised or SQL injection occurs.

### Q6. What is blind SQL injection?

SQL injection where useful database information is inferred indirectly from application behavior rather than directly returned.

### Q7. What is error-based SQL injection?

An attack that uses database/application errors to infer information about the database or query.

---

# 26. Quick Cheat Sheet

```text
SQL Injection
→ Untrusted input changes SQL

Primary Defense
→ Parameterized queries

PreparedStatement
→ Separates SQL from data

ORM
→ Helpful, but not automatically secure

Validation
→ Additional defense

Least Privilege
→ Limit database permissions

Error Handling
→ Don't expose database internals

SQLi
→ Database layer

XSS
→ Browser layer
```

## Core Mental Model

```text
              USER INPUT
                  ↓
            ┌───────────┐
            │   CODE    │
            └─────┬─────┘
                  ↓
        ┌─────────┴─────────┐
        ↓                   ↓
 String Concatenation   Parameterized
        ↓                   ↓
   SQL + Data          SQL structure
   mixed together      + separate data
        ↓                   ↓
   SQL Injection          Safe ✓
```

**Next:** `09-Command-Injection.md`