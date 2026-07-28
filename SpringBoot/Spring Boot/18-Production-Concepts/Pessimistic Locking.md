# Pessimistic Locking

## What is Pessimistic Locking?

**Pessimistic Locking** is a concurrency control mechanism where a database **locks a record as soon as a transaction starts modifying it**.

While the record is locked:

- Other transactions cannot modify it.
- Depending on the lock type, other transactions may also be prevented from reading it.

> **In simple words:**
>
> Pessimistic Locking assumes conflicts are likely, so it locks the data before anyone else can modify it.

---

# Why Do We Need Pessimistic Locking?

Imagine two users trying to book the **last available movie ticket**.

Without Locking

```
User A

↓

Seat Available

---------------------

User B

↓

Seat Available

---------------------

User A Books

↓

User B Books

↓

Two Bookings

↓

Only One Seat
```

Problem

- Duplicate booking
- Data inconsistency

---

With Pessimistic Locking

```
User A

↓

Lock Seat

↓

Book Seat

↓

Unlock

---------------------

User B

↓

Wait

↓

Seat Already Booked
```

Only one booking succeeds.

---

# Real-World Example

Imagine using an ATM.

```
Customer Uses ATM

↓

Machine Locked

↓

Transaction Complete

↓

Next Customer Uses ATM
```

Only one customer can use the ATM at a time.

Pessimistic Locking works similarly.

---

# How Pessimistic Locking Works

```
Transaction Starts

↓

Lock Record

↓

Read Data

↓

Update Data

↓

Commit

↓

Unlock Record
```

---

# Database Example

Before Update

| ID | Product | Stock |
|----|---------|-------|
| 1 | Laptop | 5 |

---

Transaction A

```
Read Product

↓

Lock Row

↓

Update Stock

↓

Commit

↓

Unlock
```

---

Transaction B

```
Read Product

↓

Wait

↓

Row Unlocks

↓

Continue
```

---

# Spring Boot Implementation

JPA supports Pessimistic Locking using the `@Lock` annotation.

```java
@Repository
public interface ProductRepository

        extends JpaRepository<Product, Long> {

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    Optional<Product> findById(Long id);

}
```

Whenever this method is called,

the selected row is locked for writing.

---

# Lock Types

## PESSIMISTIC_READ

Allows multiple reads but blocks updates.

```
Read

↓

Read

↓

Update Waits
```

---

## PESSIMISTIC_WRITE

Blocks both reads (depending on the database) and writes until the transaction finishes.

```
Write Lock

↓

Other Writes Wait

↓

Commit

↓

Continue
```

---

## PESSIMISTIC_FORCE_INCREMENT

Locks the row and increments the version field when the transaction completes.

Mostly used together with versioned entities.

---

# Request Flow

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database

↓

Lock Record

↓

Update

↓

Commit

↓

Unlock
```

---

# SQL Generated

Hibernate may generate SQL similar to

```sql
SELECT *

FROM product

WHERE id = 1

FOR UPDATE;
```

`FOR UPDATE` tells the database to lock the selected row.

---

# Transaction Requirement

Pessimistic Locking should be used inside a transaction.

```java
@Transactional
public void updateProduct(

        Long id

){

    Product product =

            repository.findById(id)

                    .orElseThrow();

    product.setPrice(500.0);

}
```

The lock is released when the transaction commits or rolls back.

---

# Lock Lifecycle

```
Start Transaction

↓

Acquire Lock

↓

Business Logic

↓

Commit

↓

Release Lock
```

---

# Without vs With Pessimistic Locking

Without

```
User A

↓

Update

↓

User B

↓

Update

↓

Conflict
```

---

With

```
User A

↓

Lock

↓

Update

↓

Commit

↓

Unlock

↓

User B Continues
```

---

# Pessimistic vs Optimistic Locking

| Pessimistic Locking | Optimistic Locking |
|---------------------|--------------------|
| Locks data immediately | Checks version during update |
| Better for frequent conflicts | Better for rare conflicts |
| May block other users | No blocking during reads |
| Lower concurrency | Higher concurrency |
| Uses database locks | Uses `@Version` |

---

# Common Use Cases

- Banking Transactions
- Ticket Booking
- Flight Reservation
- Hotel Booking
- Inventory Management
- Wallet Balance Updates

---

# Advantages

- Prevents concurrent updates.
- Eliminates lost updates.
- Suitable for high-conflict scenarios.
- Ensures strong data consistency.

---

# Disadvantages

- Lower performance.
- Users may wait for locks to be released.
- Can reduce application scalability.
- Risk of deadlocks if locks are acquired improperly.

---

# Deadlock Example

Transaction A

```
Lock Product

↓

Wait for Order
```

Transaction B

```
Lock Order

↓

Wait for Product
```

Result

```
Deadlock
```

The database usually detects the deadlock and rolls back one transaction.

---

# Best Practices

- Keep transactions as short as possible.
- Lock only the rows you need.
- Always use `@Transactional`.
- Use Pessimistic Locking only when conflicts are expected.
- Handle lock timeout and deadlock exceptions properly.

---

# Common Mistakes

❌ Locking more rows than necessary.

❌ Keeping transactions open for a long time.

❌ Using Pessimistic Locking everywhere.

❌ Ignoring deadlocks.

❌ Forgetting to use `@Transactional`.

---

# Real-World Example

## Banking Application

```
Transfer Money

↓

Lock Account

↓

Update Balance

↓

Commit

↓

Unlock
```

---

## E-Commerce Website

```
Buy Last Product

↓

Lock Inventory

↓

Reduce Stock

↓

Commit
```

---

## Food Delivery App

```
Assign Delivery Partner

↓

Lock Order

↓

Assign Driver

↓

Unlock
```

---

# Interview Questions

### 1. What is Pessimistic Locking?

Pessimistic Locking locks a database record before updating it, preventing other transactions from modifying it until the lock is released.

---

### 2. Which annotation is used for Pessimistic Locking in Spring Data JPA?

```java
@Lock(LockModeType.PESSIMISTIC_WRITE)
```

---

### 3. Which SQL statement is commonly used internally?

```sql
SELECT ... FOR UPDATE
```

---

### 4. When should Pessimistic Locking be used?

When concurrent update conflicts are expected frequently, such as in banking, booking, or inventory systems.

---

### 5. What is the difference between `PESSIMISTIC_READ` and `PESSIMISTIC_WRITE`?

- `PESSIMISTIC_READ` allows concurrent reads but blocks updates.
- `PESSIMISTIC_WRITE` locks the row for updates and prevents conflicting writes.

---

### 6. What is a deadlock?

A deadlock occurs when two or more transactions wait indefinitely for each other to release locks.

---

### 7. What is the main disadvantage of Pessimistic Locking?

It reduces concurrency because transactions may have to wait for locks to be released.

---

# Quick Revision

- Pessimistic Locking locks data before updating it.
- It is implemented using `@Lock` with `LockModeType`.
- `PESSIMISTIC_WRITE` is the most commonly used lock mode.
- Hibernate typically generates `SELECT ... FOR UPDATE`.
- Always use it within a `@Transactional` method.
- Best for applications with frequent update conflicts.
- Be careful of deadlocks and long-running transactions.