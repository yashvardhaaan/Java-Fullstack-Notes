# `16-Race-Conditions.md`

# Race Conditions

## 1. First Principle

A **race condition** occurs when the security or correctness of a system depends on the timing/order of concurrent operations.

The core problem:

> **Two operations access or modify shared state at nearly the same time, and the final result depends on which operation wins the race.**

Example:

```text
User A ──┐
         ├──> Shared resource
User B ──┘
```

If both requests can change the same state without proper synchronization, unexpected behavior can occur.

---

# 2. Simple Example

Suppose an account has:

```text
Balance = ₹1000
```

Two withdrawals happen simultaneously:

```text
Request A: withdraw ₹800
Request B: withdraw ₹800
```

Both requests may read:

```text
Balance = ₹1000
```

Then both decide:

```text
₹1000 >= ₹800 → allowed
```

Result:

```text
₹1000 - ₹800 - ₹800 = -₹600
```

The application intended to prevent this.

This is a **race condition**.

---

# 3. Time-of-Check vs Time-of-Use

A common race-condition pattern is:

**TOCTOU — Time Of Check To Time Of Use**

Example:

```text
Check:
"Is this file safe?"
        ↓
Time passes
        ↓
Use:
"Open the file"
```

If the resource changes between the check and use:

```text
Check → Resource changes → Use
```

the security decision may no longer be valid.

---

# 4. Industry-Level Example

### E-Commerce Inventory

Suppose:

```text
Stock = 1
```

Two users click **Buy** simultaneously.

Without proper concurrency control:

```text
User A → Check stock → 1 available
User B → Check stock → 1 available

User A → Purchase
User B → Purchase
```

The system sold:

```text
2 items
```

when only:

```text
1 item
```

was available.

This can cause:

- Financial loss
- Incorrect inventory
- Duplicate transactions
- Business logic bypass

---

# 5. Security Example: Coupon

Suppose a coupon should only be used once.

Database:

```text
coupon_used = false
```

Two requests arrive:

```text
Request A → Check → false
Request B → Check → false
```

Both continue:

```text
Request A → Apply discount
Request B → Apply discount
```

The attacker receives the discount twice.

This is sometimes called a **race-condition business logic vulnerability**.

---

# 6. Common Race-Condition Targets

Race conditions can affect:

```text
Payment processing
Coupon redemption
Inventory
Account balances
Password reset
Email verification
Password changes
File operations
Permissions
Rate limits
Session management
Voting systems
Transaction processing
```

---

# 7. Race Conditions in Web Applications

Typical flow:

```text
HTTP Request A ──┐
                 ├──> Application → Database
HTTP Request B ──┘
```

The application may appear correct when requests arrive sequentially:

```text
A → complete
B → complete
```

But fail when concurrent:

```text
A ────────┐
          ├── shared state
B ────────┘
```

This is why concurrency testing is important.

---

# 8. Secure Approach: Atomic Operations

Instead of:

```text
1. Read stock
2. Check stock > 0
3. Decrease stock
```

use an atomic database operation:

```sql
UPDATE products
SET stock = stock - 1
WHERE id = 10
  AND stock > 0;
```

Then check the affected rows:

```text
1 row updated → purchase allowed
0 rows updated → sold out
```

The database performs the critical operation atomically.

---

# 9. Database Transactions

Transactions help maintain consistency.

Conceptually:

```text
BEGIN
   ↓
Check/update state
   ↓
Commit
```

If something fails:

```text
ROLLBACK
```

Important transaction concepts:

```text
Atomicity
Consistency
Isolation
Durability
```

These are the **ACID** properties.

---

# 10. Optimistic Locking

A common approach for web applications is optimistic locking.

Example database:

```text
id | stock | version
10 | 5     | 7
```

Application reads:

```text
stock = 5
version = 7
```

Update:

```sql
UPDATE products
SET stock = 4,
    version = 8
WHERE id = 10
AND version = 7;
```

If another transaction already changed the row:

```text
version != 7
```

and the update fails.

This detects concurrent modification.

---

# 11. Pessimistic Locking

Another approach is to lock the database row while performing a critical operation.

Conceptually:

```text
Transaction A
    ↓
Lock row
    ↓
Update
    ↓
Commit
    ↓
Unlock

Transaction B
    ↓
Wait
```

Useful when contention is high or strict serialization is required.

---

# 12. Java / Spring Boot

Spring transactions:

```java
@Transactional
public void purchase(Long productId) {
    // database operations
}
```

For concurrency-sensitive operations, the transaction boundary must be combined with an appropriate database locking/atomic-update strategy.

Simply adding `@Transactional` does **not automatically solve every race condition**.

---

# 13. Distributed Systems

Race conditions become harder when multiple application instances exist:

```text
             Load Balancer
             /     |     \
            ↓      ↓      ↓
         Server A Server B Server C
             \      |      /
                 Database
```

A Java `synchronized` block on Server A cannot synchronize Server B.

For distributed systems, consider:

```text
Database transactions
Atomic database operations
Optimistic locking
Distributed locks
Idempotency keys
Queues
```

depending on the problem.

---

# 14. Idempotency

For payment APIs, clients may accidentally retry:

```http
POST /payment
Idempotency-Key: abc123
```

The server records:

```text
abc123 → payment result
```

If the same request arrives again:

```text
abc123
```

the server returns the existing result rather than creating another payment.

This helps prevent duplicate operations caused by retries and concurrency.

---

# 15. Small Hands-On Lab

Create a Spring Boot endpoint:

```text
POST /coupon/redeem
```

Database:

```text
coupon_code = SAVE100
used = false
```

Send two requests concurrently.

Observe:

```text
Request A → accepted
Request B → accepted
```

if the implementation is vulnerable.

Then implement an atomic database update:

```sql
UPDATE coupons
SET used = true
WHERE code = 'SAVE100'
AND used = false;
```

Check:

```text
1 row affected → successful redemption
0 rows affected → already used
```

Run the concurrent requests again.

Expected:

```text
Request A → success
Request B → rejected
```

---

# 16. SOC Relevance

Race conditions may not produce obvious malicious payloads.

Look for:

```text
Multiple identical requests
Very close timestamps
Repeated transaction IDs
Duplicate payments
Repeated coupon redemption
Inventory going negative
Unexpected account-state transitions
```

Example:

```text
10:15:01.100 → POST /coupon/redeem
10:15:01.102 → POST /coupon/redeem
```

Two nearly simultaneous requests from the same account deserve investigation when the resulting state is inconsistent.

---

# 17. Common Developer Mistakes

### ❌ Check then update without atomicity

```text
if (stock > 0)
    stock--;
```

### ❌ Assuming `synchronized` solves distributed races

It only synchronizes threads within the relevant process/JVM.

### ❌ Relying only on application memory

Multiple servers do not share normal process memory.

### ❌ No idempotency for financial operations

Retries can create duplicate transactions.

### ❌ Assuming `@Transactional` solves everything

Transactions provide important guarantees, but the isolation level and actual database operations still matter.

---

# 18. Interview Questions

### Q1. What is a race condition?

A vulnerability or correctness issue where concurrent operations produce an unintended result because execution timing affects shared state.

### Q2. What is TOCTOU?

**Time Of Check To Time Of Use** — a resource changes between a security check and its subsequent use.

### Q3. How can race conditions be prevented?

Depending on the problem:

- Atomic database operations
- Transactions
- Optimistic locking
- Pessimistic locking
- Distributed locks
- Idempotency
- Queues

### Q4. Does `synchronized` solve all race conditions?

No. It only coordinates threads within the relevant JVM/process.

### Q5. Why are race conditions important in security?

They can bypass business rules such as:

```text
Only once
Only one item
Only sufficient balance
Only authorized transition
```

---

# 19. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| Race condition | Result depends on timing of concurrent operations |
| TOCTOU | Check and use happen at different times |
| Atomic operation | Operation completes as one indivisible action |
| Transaction | Groups database operations with consistency guarantees |
| Optimistic locking | Detect conflicting updates |
| Pessimistic locking | Prevent concurrent modification using locks |
| Idempotency | Repeated request produces one logical result |
| Distributed race | Race across multiple application instances |

---

# 20. Core Mental Model

Think:

```text
Check
  ↓
Time passes
  ↓
State changes
  ↓
Use
```

If security depends on the state remaining unchanged, you have a potential race condition.

Safer:

```text
Request
   ↓
Atomic operation / transaction
   ↓
Consistent state
   ↓
Result
```

**Remember:**

> **If two requests can change the same security-sensitive state at the same time, ask: "What happens if they arrive simultaneously?"**

### Next

`17-Clickjacking.md`