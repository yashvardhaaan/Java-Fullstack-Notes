# Entity

## What is an Entity?

An **Entity** is a Java class that represents a **table in the database**.

Each object (instance) of the entity represents **one row (record)** in that table.

An entity is marked using the `@Entity` annotation.

> **In simple words:**
>
> An Entity is a Java class that maps directly to a database table.

---

# Why Do We Need an Entity?

Without an Entity, Hibernate doesn't know:

- Which class should be stored in the database?
- Which table should it use?
- Which fields become columns?

Entity mapping solves this problem.

---

# Real-World Example

Suppose we have a table:

## Employee Table

| id | name | department | salary |
|----|------|------------|---------|
| 1 | John | IT | 60000 |
| 2 | Alice | HR | 55000 |

Equivalent Java Entity:

```java
@Entity
public class Employee {

    @Id
    private Long id;

    private String name;

    private String department;

    private double salary;

}
```

Each object becomes one row in the table.

---

# Basic Syntax

```java
@Entity
public class Employee {

}
```

Spring Boot automatically maps this class to a database table.

---

# How Entity Works

```
Java Object

↓

@Entity

↓

Hibernate

↓

Database Table
```

---

# Creating an Entity

```java
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Employee {

    @Id
    private Long id;

    private String name;

    private String department;

    private double salary;

}
```

---

# Primary Key

Every entity must have a **Primary Key**.

Use:

```java
@Id
```

Example:

```java
@Id
private Long id;
```

Without a primary key, Hibernate cannot uniquely identify a record.

---

# Auto Generated IDs

Instead of assigning IDs manually:

```java
@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;
```

Now the database automatically generates IDs.

Example:

| id | name |
|----|------|
| 1 | John |
| 2 | Alice |
| 3 | Bob |

---

# Custom Table Name

By default,

Class Name:

```java
Employee
```

↓

Table Name:

```
employee
```

To specify a custom name:

```java
@Entity
@Table(name = "employees")
public class Employee {

}
```

Now Hibernate maps to:

```
employees
```

---

# Custom Column Name

By default,

```java
private String department;
```

↓

Column:

```
department
```

Custom name:

```java
@Column(name = "dept_name")
private String department;
```

Database:

| dept_name |
|------------|
| IT |

---

# Column Constraints

```java
@Column(
        nullable = false,
        unique = true,
        length = 100
)
private String email;
```

Meaning:

- Cannot be NULL
- Must be unique
- Maximum length = 100

---

# Ignoring a Field

Suppose a field should not be stored.

```java
@Transient
private int age;
```

Hibernate ignores this field.

---

# Complete Entity Example

```java
import jakarta.persistence.*;

@Entity
@Table(name = "employees")
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(name = "dept_name")
    private String department;

    private double salary;

    @Transient
    private int age;

    // Getters

    // Setters

    // Constructors

}
```

---

# Entity Lifecycle

```
New Object

↓

Transient

↓

save()

↓

Persistent

↓

Session Closed

↓

Detached

↓

delete()

↓

Removed
```

---

# Entity with Repository

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

Save:

```java
Employee employee = new Employee();

employee.setName("John");

employeeRepository.save(employee);
```

Hibernate generates:

```sql
INSERT INTO employees
(name)
VALUES
('John');
```

---

# Request Flow

```
Java Object

↓

@Entity

↓

Repository

↓

Hibernate

↓

SQL

↓

Database
```

---

# Common Entity Annotations

| Annotation | Purpose |
|------------|----------|
| `@Entity` | Marks a class as an Entity |
| `@Table` | Specifies table name |
| `@Id` | Primary Key |
| `@GeneratedValue` | Auto-generates primary key |
| `@Column` | Configures column properties |
| `@Transient` | Excludes field from database |
| `@Lob` | Stores large objects (TEXT/BLOB) |
| `@Enumerated` | Stores enum values |

---

# Real-World Example

### Banking Application

```java
@Entity
public class Account {

    @Id
    private Long accountNumber;

    private String accountHolder;

    private double balance;

}
```

Each account object becomes one row in the `account` table.

---

### E-Commerce Application

```java
@Entity
public class Product {

    @Id
    private Long id;

    private String name;

    private double price;

}
```

Each product object maps to one record in the `product` table.

---

# Best Practices

- Every entity must have a primary key.
- Use `@GeneratedValue` for auto-generated IDs.
- Use meaningful table and column names.
- Keep entities focused on persistence.
- Use DTOs for API requests and responses instead of exposing entities directly.
- Avoid putting business logic inside entity classes.

---

# Interview Questions

### 1. What is an Entity?

An Entity is a Java class that represents a table in the database.

---

### 2. Which annotation is used to mark an Entity?

```java
@Entity
```

---

### 3. Why is `@Id` mandatory?

Because every entity must have a unique identifier (primary key) so Hibernate can identify each record.

---

### 4. What does `@GeneratedValue` do?

It tells Hibernate to generate the primary key automatically.

---

### 5. What is `@Transient`?

`@Transient` marks a field that should not be stored in the database.

---

### 6. Can an entity have a different table name than the class name?

Yes.

```java
@Table(name = "employees")
```

---

# Quick Revision

- An **Entity** represents a database table.
- Each entity object corresponds to one row in the table.
- Use `@Entity` to mark the class.
- Use `@Id` for the primary key.
- Use `@GeneratedValue` for auto-generated IDs.
- Use `@Table` and `@Column` to customize table and column names.
- Use `@Transient` to exclude fields from persistence.
- Entities are managed by Hibernate and persisted using Spring Data JPA repositories.