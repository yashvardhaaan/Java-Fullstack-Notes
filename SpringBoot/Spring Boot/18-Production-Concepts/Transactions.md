# Transactions

## What is a Transaction?

A **Transaction** is a sequence of one or more database operations that are treated as **a single unit of work**.

A transaction ensures that **either all operations succeed or none of them are applied**.

> **In simple words:**
>
> A transaction means "Complete everything successfully, or undo everything."

---

# Why Do We Need Transactions?

Imagine a banking application.

A user transfers money.

```
Transfer $100

↓

Debit Account A

↓

Credit Account B
```

Suppose the debit succeeds but the credit fails.

Without Transaction

```
Debit Success

↓

Credit Failed

↓

Money Lost
```

This creates inconsistent data.

---

With Transaction

```
Debit

↓

Credit Failed

↓

Rollback

↓

Money Returned
```

The database remains consistent.

---

# Real-World Example

Imagine withdrawing cash from an ATM.

```
Insert Card

↓

Verify PIN

↓

Debit Account

↓

Dispense Cash

↓

Print Receipt
```

If cash cannot be dispensed,

the debit is cancelled.

This entire process is a transaction.

---

# Transaction Flow

```
Start Transaction

↓

Operation 1

↓

Operation 2

↓

Operation 3

↓

Success?

↓

Yes

↓

Commit

OR

↓

Rollback
```

---

# ACID Properties

A transaction follows the **ACID** principles.

| Property | Meaning |
|-----------|---------|
| Atomicity | All or Nothing |
| Consistency | Database remains valid |
| Isolation | Transactions don't interfere with each other |
| Durability | Committed data is permanently saved |

---

# Atomicity

Either every operation succeeds,

or every operation fails.

```
Debit

↓

Credit

↓

Both Success

OR

↓

Rollback Everything
```

---

# Consistency

The database should always remain valid.

Example

Before Transfer

```
Account A = $1000

Account B = $500

Total = $1500
```

After Transfer

```
Account A = $900

Account B = $600

Total = $1500
```

The total amount remains unchanged.

---

# Isolation

Multiple transactions should not interfere with each other.

```
Transaction A

↓

Processing

----------------

Transaction B

↓

Processing
```

Each transaction behaves independently according to the configured isolation level.

---

# Durability

After a transaction is committed,

the data is permanently stored.

```
Commit

↓

Power Failure

↓

Data Still Exists
```

---

# Spring Boot Transaction

Spring provides transaction management using

```java
@Transactional
```

Example

```java
@Service
public class BankService {

    @Transactional
    public void transfer(

            Long from,

            Long to,

            Double amount

    ) {

        // Debit

        // Credit

    }

}
```

---

# Transaction Request Flow

```
Client

↓

Controller

↓

Service

↓

@Transactional

↓

Repository

↓

Database

↓

Commit

↓

Response
```

---

# Commit

If every operation succeeds,

```
Start

↓

Insert

↓

Update

↓

Delete

↓

Commit
```

Changes are permanently saved.

---

# Rollback

If any operation fails,

```
Start

↓

Insert

↓

Update Failed

↓

Rollback
```

All previous changes are undone.

---

# Example

Without Transaction

```java
repositoryA.save(accountA);

throw new RuntimeException();

repositoryB.save(accountB);
```

Result

```
Account A Updated

↓

Exception

↓

Account B Not Updated
```

Inconsistent data.

---

With Transaction

```java
@Transactional
public void transfer(){

    repositoryA.save(accountA);

    throw new RuntimeException();

    repositoryB.save(accountB);

}
```

Result

```
Exception

↓

Rollback

↓

Nothing Saved
```

---

# Propagation

Propagation defines how nested transactions behave.

Common propagation types

| Propagation | Description |
|-------------|-------------|
| REQUIRED | Join existing transaction or create a new one (Default) |
| REQUIRES_NEW | Suspend current transaction and start a new one |
| SUPPORTS | Join if one exists, otherwise execute without a transaction |
| NOT_SUPPORTED | Execute without a transaction |
| MANDATORY | Must already have a transaction |
| NEVER | Must not have a transaction |
| NESTED | Creates a nested transaction (database support required) |

---

# Isolation Levels

Isolation levels control how concurrent transactions interact.

| Isolation Level | Description |
|-----------------|-------------|
| READ_UNCOMMITTED | Allows dirty reads |
| READ_COMMITTED | Prevents dirty reads (common default) |
| REPEATABLE_READ | Prevents dirty and non-repeatable reads |
| SERIALIZABLE | Highest isolation, strongest consistency, lowest concurrency |

---

# Configuring Transaction

```java
@Transactional(

        propagation = Propagation.REQUIRED,

        isolation = Isolation.READ_COMMITTED

)
public void process(){

}
```

---

# Rollback Rules

By default,

Spring rolls back transactions for **unchecked exceptions** (`RuntimeException` and subclasses).

Example

```java
@Transactional(
        rollbackFor = Exception.class
)
public void process()

        throws Exception {

}
```

This also rolls back for checked exceptions.

---

# Transaction Lifecycle

```
Start

↓

Execute SQL

↓

Success?

↓

Commit

OR

↓

Rollback

↓

End
```

---

# Transaction vs No Transaction

| With Transaction | Without Transaction |
|------------------|---------------------|
| All operations succeed or fail together | Partial updates possible |
| Consistent data | Inconsistent data |
| Supports rollback | No automatic rollback |

---

# Common Use Cases

- Money Transfer
- Order Placement
- Payment Processing
- Inventory Updates
- User Registration
- Booking Systems

---

# Common Mistakes

❌ Forgetting `@Transactional`.

❌ Performing long-running operations inside a transaction.

❌ Catching exceptions without rethrowing them, preventing rollback.

❌ Putting `@Transactional` on private methods (Spring AOP won't apply it).

❌ Calling a `@Transactional` method from another method in the same class (self-invocation bypasses the proxy).

---

# Real-World Example

## Banking Application

```
Debit Account

↓

Credit Account

↓

Commit

OR

↓

Rollback
```

---

## E-Commerce Website

```
Create Order

↓

Reduce Stock

↓

Create Payment

↓

Commit
```

---

## Food Delivery App

```
Create Order

↓

Reserve Delivery Partner

↓

Update Inventory

↓

Commit
```

---

# Advantages

- Ensures data consistency.
- Supports rollback.
- Maintains data integrity.
- Simplifies complex database operations.
- Improves application reliability.

---

# Best Practices

- Keep transactions as short as possible.
- Place `@Transactional` in the Service Layer.
- Avoid network or slow external API calls inside a transaction.
- Choose appropriate isolation levels based on business requirements.
- Handle exceptions correctly to allow rollback.
- Monitor transaction duration in production.

---

# Interview Questions

### 1. What is a Transaction?

A transaction is a group of database operations executed as a single unit of work where all operations succeed or all fail.

---

### 2. What are ACID properties?

- Atomicity
- Consistency
- Isolation
- Durability

---

### 3. Which annotation is used for transaction management in Spring Boot?

```java
@Transactional
```

---

### 4. What is the difference between Commit and Rollback?

- **Commit** permanently saves all changes.
- **Rollback** undoes all changes made during the transaction.

---

### 5. Why is `@Transactional` usually placed in the Service Layer?

Because the Service Layer contains business logic that often spans multiple database operations and must succeed or fail together.

---

### 6. Does Spring roll back transactions for checked exceptions by default?

No. By default, Spring rolls back only for unchecked exceptions (`RuntimeException`). Use `rollbackFor` to include checked exceptions.

---

### 7. What is the default propagation behavior in Spring?

```java
Propagation.REQUIRED
```

It joins an existing transaction or creates a new one if none exists.

---

# Quick Revision

- A Transaction is a single unit of work.
- It follows the ACID principles.
- Use `@Transactional` for transaction management.
- Successful execution results in **Commit**.
- Failures result in **Rollback**.
- Keep transactions short and place them in the Service Layer.
- Understand propagation and isolation levels for production applications.