# One-to-One Relationship (`@OneToOne`)

## What is a One-to-One Relationship?

A **One-to-One (1:1)** relationship means **one record in one table is associated with exactly one record in another table**.

In Spring Data JPA, this relationship is created using the `@OneToOne` annotation.

> **In simple words:**
>
> One object is linked to only one other object.

---

# Why Do We Need a One-to-One Relationship?

Suppose every employee has exactly one company ID card.

Instead of storing ID card details in the Employee table, we create a separate table and connect them.

This:

- Reduces duplicate data
- Keeps the database normalized
- Improves maintainability

---

# Real-World Examples

### Employee → ID Card

```
Employee

↓

ID Card
```

One employee has one ID card.

---

### Person → Passport

```
Person

↓

Passport
```

One passport belongs to one person.

---

### User → Profile

```
User

↓

Profile
```

Each user has one profile.

---

# Database Representation

## Employee Table

| id | name |
|----|------|
| 1 | John |
| 2 | Alice |

---

## ID Card Table

| id | card_number | employee_id |
|----|-------------|-------------|
| 10 | EMP101 | 1 |
| 11 | EMP102 | 2 |

`employee_id` is the **foreign key**.

---

# How One-to-One Works

```
Employee

1 -------- 1

ID Card
```

Each employee has only one ID card.

Each ID card belongs to only one employee.

---

# Unidirectional One-to-One

Only the Employee knows about the ID Card.

## IDCard Entity

```java
@Entity
public class IDCard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String cardNumber;

}
```

---

## Employee Entity

```java
@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToOne
    @JoinColumn(name = "id_card_id")
    private IDCard idCard;

}
```

---

# Generated Tables

Employee

| id | name | id_card_id |
|----|------|------------|
| 1 | John | 10 |

IDCard

| id | card_number |
|----|-------------|
| 10 | EMP101 |

---

# `@JoinColumn`

```java
@JoinColumn(name = "id_card_id")
```

It specifies the foreign key column.

Generated SQL

```sql
ALTER TABLE employee

ADD COLUMN id_card_id BIGINT;
```

---

# Bidirectional One-to-One

Sometimes both entities should know about each other.

Employee

```java
@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToOne
    @JoinColumn(name = "id_card_id")
    private IDCard idCard;

}
```

---

IDCard

```java
@Entity
public class IDCard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String cardNumber;

    @OneToOne(mappedBy = "idCard")
    private Employee employee;

}
```

---

# What is `mappedBy`?

```java
@OneToOne(mappedBy = "idCard")
```

`mappedBy` tells Hibernate that:

- The relationship is already managed by the `Employee` entity.
- Do **not** create another foreign key.

---

# Owning Side vs Inverse Side

```
Employee

↓

@JoinColumn

↓

Foreign Key

↓

ID Card
```

- **Owning Side** → Contains `@JoinColumn`
- **Inverse Side** → Uses `mappedBy`

Only the owning side updates the foreign key.

---

# Cascade Operations

Save employee and ID card together.

```java
@OneToOne(cascade = CascadeType.ALL)
@JoinColumn(name = "id_card_id")
private IDCard idCard;
```

Now:

```java
employeeRepository.save(employee);
```

also saves the ID card automatically.

---

# Fetch Types

Default fetch type for `@OneToOne` is:

```java
FetchType.EAGER
```

Meaning:

```
Load Employee

↓

Automatically Load ID Card
```

Lazy loading:

```java
@OneToOne(fetch = FetchType.LAZY)
```

---

# Saving Data

```java
IDCard card = new IDCard();
card.setCardNumber("EMP101");

Employee employee = new Employee();
employee.setName("John");
employee.setIdCard(card);

repository.save(employee);
```

---

# Generated SQL

```sql
INSERT INTO id_card
(card_number)
VALUES
('EMP101');

INSERT INTO employee
(name, id_card_id)
VALUES
('John', 1);
```

---

# Request Flow

```
Controller

↓

Service

↓

Repository

↓

Hibernate

↓

Employee Table

↓

ID Card Table
```

---

# Real-World Example

### Banking Application

```
Customer

↓

KYC Details
```

Each customer has one KYC record.

---

### Hospital System

```
Patient

↓

Medical Record
```

Each patient has one medical record.

---

# One-to-One vs One-to-Many

| One-to-One | One-to-Many |
|------------|-------------|
| One record maps to one record | One record maps to many records |
| One foreign key | One foreign key used by many rows |
| Example: User → Profile | Example: Department → Employees |

---

# Advantages

- Eliminates duplicate information
- Maintains normalized database design
- Easy to manage related data
- Automatically managed by Hibernate

---

# Best Practices

- Use `@JoinColumn` on the owning side.
- Use `mappedBy` for bidirectional relationships.
- Prefer `FetchType.LAZY` unless eager loading is necessary.
- Use `CascadeType.ALL` only when the child entity depends entirely on the parent.
- Use DTOs in REST APIs to avoid serialization issues.

---

# Interview Questions

### 1. What is a One-to-One relationship?

A One-to-One relationship means one entity is associated with exactly one other entity.

---

### 2. Which annotation is used?

```java
@OneToOne
```

---

### 3. What is `@JoinColumn`?

It specifies the foreign key column that maintains the relationship.

---

### 4. What is `mappedBy`?

`mappedBy` marks the inverse side of a bidirectional relationship and indicates that the owning side manages the foreign key.

---

### 5. What is the default fetch type for `@OneToOne`?

```java
FetchType.EAGER
```

---

# Quick Revision

- `@OneToOne` creates a one-to-one relationship between two entities.
- Use `@JoinColumn` to define the foreign key.
- Use `mappedBy` in bidirectional relationships.
- The owning side contains `@JoinColumn`.
- Default fetch type is `EAGER`.
- Use `CascadeType.ALL` when parent and child should be persisted together.