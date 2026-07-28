# Optimistic Locking

## What is Optimistic Locking?

**Optimistic Locking** is a concurrency control mechanism that allows **multiple users to read and modify the same data simultaneously**, but prevents one user's changes from accidentally overwriting another user's changes.

It works by maintaining a **version number** (or timestamp) for each record.

If another transaction updates the record before you save your changes, the update fails.

> **In simple words:**
>
> Optimistic Locking assumes conflicts are rare. It checks before saving whether someone else has already modified the data.

---

# Why Do We Need Optimistic Locking?

Imagine two users editing the same profile.

Without Optimistic Locking

```
User A

↓

Read User

↓

Edit Name

---------------------

User B

↓

Read User

↓

Edit Email

---------------------

User A Saves

↓

User B Saves

↓

User A Changes Lost
```

Problem

- Lost updates
- Data inconsistency
- Incorrect information

---

With Optimistic Locking

```
User A

↓

Read Version 1

--------------------

User B

↓

Read Version 1

--------------------

User A Saves

↓

Version Becomes 2

--------------------

User B Saves

↓

Version Mismatch

↓

Update Rejected
```

No data is overwritten accidentally.

---

# Real-World Example

Imagine editing a Google Doc.

```
Open Document

↓

Someone Else Updates

↓

You Try to Save

↓

Conflict Detected
```

The application asks you to refresh before saving.

Optimistic Locking works similarly.

---

# How Optimistic Locking Works

```
Read Record

↓

Read Version

↓

Modify Data

↓

Save

↓

Version Same?

↓

Yes

↓

Update Record

↓

Increase Version

OR

↓

No

↓

Throw Exception
```

---

# Database Example

Before Update

| ID | Name | Version |
|----|------|----------|
| 1 | John | 1 |

---

User A reads

```
Version = 1
```

User B also reads

```
Version = 1
```

---

User A updates

| ID | Name | Version |
|----|------|----------|
| 1 | Johnny | 2 |

Version automatically increases.

---

User B tries to update

```
Expected Version = 1

Current Version = 2

↓

Conflict

↓

Update Rejected
```

---

# Spring Boot Implementation

JPA provides Optimistic Locking using the `@Version` annotation.

```java
@Entity
public class Product {

    @Id
    private Long id;

    private String name;

    private Double price;

    @Version
    private Integer version;

}
```

---

# What Happens Internally?

Hibernate generates SQL similar to:

```sql
UPDATE product

SET

price = 500,

version = version + 1

WHERE

id = 1

AND version = 2;
```

If no row matches the expected version,

```
0 Rows Updated

↓

Conflict Detected
```

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

Version Check

↓

Update Successful

OR

↓

Conflict
```

---

# Exception

If another transaction has already updated the record,

Hibernate throws

```text
OptimisticLockException
```

or, in Spring,

```text
ObjectOptimisticLockingFailureException
```

---

# Handling the Exception

```java
try {

    repository.save(product);

} catch (

    ObjectOptimisticLockingFailureException ex

) {

    // Inform the client

}
```

Usually, the client is asked to reload the latest data.

---

# Version Flow

```
Version 1

↓

Update

↓

Version 2

↓

Update

↓

Version 3

↓

Update

↓

Version 4
```

Every successful update increments the version.

---

# Optimistic Locking vs No Locking

Without Locking

```
User A Save

↓

User B Save

↓

Last Save Wins
```

---

With Optimistic Locking

```
User A Save

↓

Version Updated

↓

User B Save

↓

Conflict

↓

Retry
```

---

# Optimistic vs Pessimistic Locking

| Optimistic Locking | Pessimistic Locking |
|--------------------|---------------------|
| No database lock while reading | Locks the record immediately |
| Better performance | More waiting |
| Best when conflicts are rare | Best when conflicts are frequent |
| Detects conflicts during update | Prevents conflicts before update |

---

# Common Use Cases

- User Profile Updates
- Product Inventory
- Banking Records
- Employee Information
- Online Forms
- Order Management

---

# Advantages

- Better performance.
- High scalability.
- No long-running database locks.
- Prevents lost updates.
- Suitable for web applications.

---

# Disadvantages

- Updates may fail due to version conflicts.
- Clients may need to retry operations.
- Not ideal when many users frequently update the same record.

---

# Best Practices

- Use `@Version` for entities that are updated by multiple users.
- Catch and handle optimistic locking exceptions gracefully.
- Ask users to refresh data before retrying.
- Keep transactions short.
- Use Optimistic Locking when update conflicts are uncommon.

---

# Common Mistakes

❌ Forgetting to add the `@Version` field.

❌ Ignoring `OptimisticLockException`.

❌ Using Optimistic Locking for highly contested records.

❌ Catching the exception but silently ignoring it.

❌ Using long-running transactions.

---

# Real-World Example

## Banking Application

```
Update Account Details

↓

Version Check

↓

Conflict?

↓

Yes

↓

Reject Update
```

---

## E-Commerce Website

```
Admin Updates Product

↓

Version Updated

↓

Second Admin Saves

↓

Conflict Detected
```

---

## Food Delivery App

```
Restaurant Updates Menu

↓

Another Manager Updates

↓

Version Conflict

↓

Retry
```

---

# Interview Questions

### 1. What is Optimistic Locking?

Optimistic Locking is a concurrency control mechanism that detects conflicting updates using a version field instead of locking the record while it is being read.

---

### 2. Which annotation enables Optimistic Locking in JPA?

```java
@Version
```

---

### 3. What happens when two users update the same record?

The first update succeeds and increments the version. The second update fails because its version is outdated.

---

### 4. Which exception is thrown when a version conflict occurs?

- `OptimisticLockException` (JPA)
- `ObjectOptimisticLockingFailureException` (Spring)

---

### 5. Why is it called "Optimistic"?

Because it assumes update conflicts are rare and only checks for them when saving.

---

### 6. When should Optimistic Locking be used?

When read operations are much more frequent than updates and concurrent update conflicts are relatively uncommon.

---

### 7. What is the main advantage of Optimistic Locking?

It provides better performance by avoiding database locks while still preventing lost updates.

---

# Quick Revision

- Optimistic Locking prevents lost updates.
- It uses a version field (`@Version`) to detect conflicts.
- Every successful update increments the version.
- If versions don't match, the update fails.
- No database lock is held while reading data.
- Best for applications with many reads and few update conflicts.
- Handle optimistic locking exceptions and allow users to retry.