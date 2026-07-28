v# JPA Basics

## What is JPA?

**JPA (Java Persistence API)** is a **Java Specification** that provides a standard way to interact with relational databases using Java objects.

Instead of writing SQL queries for every database operation, JPA allows us to work with **Java objects**, and it automatically maps them to database tables.

> **In simple words:**
>
> JPA lets you save, update, delete, and retrieve Java objects from a database without writing most SQL manually.

---

# Why Do We Need JPA?

Without JPA, we have to write SQL for every operation.

Example:

```sql
INSERT INTO employee(name, department)
VALUES ('John', 'IT');
```

Then manually:

- Open database connection
- Execute SQL
- Convert ResultSet to Java Object
- Close connection

This leads to lots of boilerplate code.

With JPA:

```java
employeeRepository.save(employee);
```

JPA handles everything behind the scenes.

---

# What is Persistence?

**Persistence** means storing data permanently so that it remains available even after the application stops.

Example:

```
Java Object

↓

Database

↓

Stored Permanently
```

---

# What is ORM?

**ORM (Object Relational Mapping)** is the process of mapping Java objects to database tables.

Example:

Java Object

```java
Employee employee = new Employee();
```

↓

Database Table

| id | name | department |
|----|------|------------|
| 1 | John | IT |

Each object becomes a row in the table.

---

# JPA Architecture

```
Application

↓

JPA

↓

Hibernate

↓

JDBC

↓

Database
```

Here,

- JPA → Specification
- Hibernate → Implementation
- JDBC → Communicates with Database

---

# JPA is a Specification

JPA only defines **rules and interfaces**.

It does **not** provide an implementation.

Popular JPA implementations:

- Hibernate
- EclipseLink
- OpenJPA

In Spring Boot, **Hibernate** is the default implementation.

---

# How JPA Works

```
Java Object

↓

Entity Manager

↓

Hibernate

↓

SQL Query

↓

Database
```

Example:

```java
employeeRepository.save(employee);
```

Hibernate generates SQL automatically:

```sql
INSERT INTO employee
(name, department)
VALUES
('John', 'IT');
```

---

# JPA Components

## 1. Entity

Represents a database table.

```java
@Entity
public class Employee {

}
```

---

## 2. Repository

Provides CRUD operations.

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

---

## 3. EntityManager

Core interface used to manage entities.

Common operations:

- persist()
- merge()
- remove()
- find()

Usually, Spring Data JPA manages it for you.

---

## 4. Persistence Context

A cache that keeps track of managed entities.

```
Database

↓

Persistence Context

↓

Java Objects
```

This avoids unnecessary database queries.

---

# Basic Example

Entity

```java
@Entity
public class Employee {

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    private String department;

}
```

Repository

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

Service

```java
employeeRepository.save(employee);

employeeRepository.findAll();

employeeRepository.deleteById(1L);
```

---

# CRUD Using JPA

Create

```java
repository.save(employee);
```

Read

```java
repository.findById(1L);
```

Update

```java
repository.save(employee);
```

Delete

```java
repository.deleteById(1L);
```

---

# Request Flow

```
Spring Boot

↓

Repository

↓

JPA

↓

Hibernate

↓

JDBC

↓

Database
```

---

# Real-World Example

### Banking Application

When a customer opens an account:

```java
accountRepository.save(account);
```

Hibernate automatically generates the SQL to insert the account into the database.

---

### E-Commerce Application

Retrieve a product:

```java
productRepository.findById(10L);
```

JPA fetches the product from the database and converts it into a Java object.

---

# Advantages of JPA

- Reduces SQL writing
- Database-independent
- Supports Object Relational Mapping (ORM)
- Provides automatic CRUD operations
- Integrates seamlessly with Spring Boot
- Improves code readability and maintainability

---

# JPA vs JDBC

| JPA | JDBC |
|-----|------|
| High-level API | Low-level API |
| Uses Java Objects | Uses SQL directly |
| Automatic ORM | Manual Mapping |
| Less Boilerplate | More Boilerplate |
| Easier to Maintain | More Code |

---

# Best Practices

- Use JPA with Hibernate in Spring Boot.
- Keep Entity classes simple.
- Use repositories instead of `EntityManager` when using Spring Data JPA.
- Avoid writing native SQL unless necessary.
- Use transactions for database operations.

---

# Interview Questions

### 1. What is JPA?

JPA (Java Persistence API) is a Java specification for mapping Java objects to relational database tables and performing database operations.

---

### 2. Is JPA a framework?

No.

JPA is a **specification**. Hibernate is one of its implementations.

---

### 3. What is ORM?

ORM (Object Relational Mapping) maps Java objects to database tables and vice versa.

---

### 4. What is the default JPA implementation in Spring Boot?

**Hibernate**.

---

### 5. What is the difference between JPA and Hibernate?

- **JPA** defines the standard (Specification).
- **Hibernate** implements that standard and provides the actual functionality.

---

# Quick Revision

- JPA stands for **Java Persistence API**.
- It is a **specification**, not an implementation.
- Hibernate is the default JPA implementation in Spring Boot.
- JPA uses **ORM** to map Java objects to database tables.
- CRUD operations are performed using repositories.
- JPA reduces boilerplate code and minimizes manual SQL writing.