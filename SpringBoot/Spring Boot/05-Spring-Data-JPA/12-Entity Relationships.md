# Entity Relationships

## What are Entity Relationships?

In a real-world application, one database table is often related to another.

For example:

- One Customer can place many Orders.
- One Department has many Employees.
- One Student can enroll in many Courses.

In Spring Data JPA, these relationships are represented using **Entity Relationships**.

> **In simple words:**
>
> Entity Relationships define how two or more entities are connected in the database.

---

# Why Do We Need Entity Relationships?

Suppose we have two tables:

## Employee

| id | name |
|----|------|
| 1 | John |
| 2 | Alice |

## Department

| id | department |
|----|------------|
| 10 | IT |
| 20 | HR |

Each employee belongs to a department.

Instead of storing department information repeatedly, we create a relationship.

This:

- Reduces data duplication
- Maintains data consistency
- Makes querying easier

---

# Real-World Example

## Banking System

```
Customer

↓

Multiple Accounts

↓

Multiple Transactions
```

---

## E-Commerce

```
Customer

↓

Orders

↓

Order Items

↓

Products
```

Everything is connected through relationships.

---

# Types of Entity Relationships

Spring Data JPA supports four main relationship types:

| Relationship | Annotation |
|--------------|------------|
| One-to-One | `@OneToOne` |
| One-to-Many | `@OneToMany` |
| Many-to-One | `@ManyToOne` |
| Many-to-Many | `@ManyToMany` |

---

# One-to-One (1:1)

One record is related to exactly one record.

Example:

```
Person

↓

Passport
```

Each person has one passport.

Each passport belongs to one person.

```
Person
 1 -------- 1 Passport
```

---

# One-to-Many (1:N)

One record is related to multiple records.

Example:

```
Department

↓

Employees
```

One department has many employees.

```
Department

1 -------- N Employees
```

---

# Many-to-One (N:1)

Multiple records are related to one record.

Example:

```
Employees

↓

Department
```

Many employees belong to one department.

```
Employees N -------- 1 Department
```

---

# Many-to-Many (N:N)

Many records are related to many records.

Example:

```
Students

↓

Courses
```

A student can enroll in multiple courses.

A course can have multiple students.

```
Students

N -------- N Courses
```

A separate **join table** is created to maintain this relationship.

---

# Relationship Annotations

| Annotation | Purpose |
|------------|----------|
| `@OneToOne` | One object maps to one object |
| `@OneToMany` | One object maps to many objects |
| `@ManyToOne` | Many objects map to one object |
| `@ManyToMany` | Many objects map to many objects |
| `@JoinColumn` | Specifies the foreign key column |
| `@JoinTable` | Creates a join table for many-to-many relationships |

---

# Foreign Key

Relationships are maintained using a **Foreign Key**.

Example

## Department

| id | name |
|----|------|
| 1 | IT |
| 2 | HR |

## Employee

| id | name | department_id |
|----|------|---------------|
| 10 | John | 1 |
| 11 | Alice | 1 |
| 12 | Bob | 2 |

`department_id` is the **foreign key** that links the tables.

---

# Example Entity Relationship

Department Entity

```java
@Entity
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

}
```

Employee Entity

```java
@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

}
```

---

# How Hibernate Handles Relationships

```
Java Entities

↓

Relationship Annotations

↓

Hibernate

↓

Foreign Keys

↓

Database Tables
```

Hibernate automatically creates the foreign key based on the annotations.

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

Database

↓

Related Data
```

---

# Database Representation

```
Department
+----+------+
| id | name |
+----+------+
| 1  | IT   |
| 2  | HR   |
+----+------+

Employee
+----+-------+---------------+
| id | name  | department_id |
+----+-------+---------------+
|10  | John  | 1             |
|11  | Alice | 1             |
|12  | Bob   | 2             |
+----+-------+---------------+
```

---

# Bidirectional vs Unidirectional Relationships

## Unidirectional

Only one entity knows about the relationship.

```
Employee

↓

Department
```

Employee can access Department, but Department cannot access Employees.

---

## Bidirectional

Both entities know about each other.

```
Department

↕️

Employees
```

Department can access employees.

Employee can access department.

---

# Owning Side vs Inverse Side

In a bidirectional relationship:

- **Owning Side** manages the foreign key.
- **Inverse Side** references the relationship using `mappedBy`.

Example

```java
@OneToMany(mappedBy = "department")
private List<Employee> employees;
```

Here:

- `Employee` is the owning side.
- `Department` is the inverse side.

---

# Common Relationship Problems

### Infinite JSON Recursion

Example:

```
Department

↓

Employees

↓

Department

↓

Employees
```

When converting entities to JSON, this can cause an infinite loop.

Common solutions:

- `@JsonIgnore`
- `@JsonManagedReference`
- `@JsonBackReference`
- DTOs (recommended)

---

### LazyInitializationException

Occurs when:

- Lazy-loaded data is accessed after the Hibernate session is closed.

Solutions:

- Fetch data within the transaction.
- Use `JOIN FETCH` when appropriate.
- Use DTO projections.

---

# Real-World Example

### Banking Application

```
Customer

↓

Accounts

↓

Transactions
```

Relationships:

- Customer → Accounts → One-to-Many
- Account → Customer → Many-to-One

---

### University Management System

```
Student

↓

Courses

↓

Professors
```

Relationships:

- Student ↔ Course → Many-to-Many
- Professor → Course → One-to-Many

---

# Advantages

- Reduces duplicate data
- Maintains referential integrity
- Simplifies querying related data
- Represents real-world relationships naturally
- Automatically managed by Hibernate

---

# Best Practices

- Choose the correct relationship type based on the business requirement.
- Prefer **LAZY** fetching for collections unless eager loading is necessary.
- Avoid exposing entities directly in REST APIs; use DTOs.
- Keep relationships as simple as possible.
- Use bidirectional relationships only when both directions are required.

---

# Interview Questions

### 1. What are Entity Relationships?

Entity Relationships define how two or more entities are connected in the database using foreign keys.

---

### 2. What are the four relationship types in JPA?

- `@OneToOne`
- `@OneToMany`
- `@ManyToOne`
- `@ManyToMany`

---

### 3. What is a Foreign Key?

A foreign key is a column that references the primary key of another table to establish a relationship.

---

### 4. What is the difference between unidirectional and bidirectional relationships?

- **Unidirectional:** One entity knows about the relationship.
- **Bidirectional:** Both entities know about the relationship.

---

### 5. What does `mappedBy` do?

`mappedBy` identifies the inverse side of a bidirectional relationship and indicates that the foreign key is managed by the owning side.

---

# Quick Revision

- Entity Relationships connect database tables using foreign keys.
- JPA supports four relationship types:
  - `@OneToOne`
  - `@OneToMany`
  - `@ManyToOne`
  - `@ManyToMany`
- Use `@JoinColumn` to define foreign keys.
- Use `mappedBy` in bidirectional relationships.
- Prefer LAZY fetching for collections.
- Use DTOs to avoid JSON recursion and improve API design.