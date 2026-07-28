# Hibernate

## What is Hibernate?

**Hibernate** is an **Object Relational Mapping (ORM) Framework** that implements the **JPA (Java Persistence API)** specification.

It automatically converts Java objects into database records and database records back into Java objects.

> **In simple words:**
>
> Hibernate acts as a translator between Java objects and the database.

---

# Why Do We Need Hibernate?

Without Hibernate, we need to:

- Write SQL queries
- Open database connections
- Execute SQL
- Convert ResultSet into Java objects
- Close database connections

Example using JDBC:

```java
Connection connection = DriverManager.getConnection(...);

PreparedStatement statement =
connection.prepareStatement(
"SELECT * FROM employee");

ResultSet result = statement.executeQuery();
```

Lots of repetitive code.

With Hibernate:

```java
employeeRepository.findAll();
```

Hibernate generates the SQL automatically.

---

# Hibernate Architecture

```
Spring Boot

↓

Spring Data JPA

↓

Hibernate

↓

JDBC

↓

Database
```

Hibernate sits between Java and the database.

---

# How Hibernate Works

```
Java Object

↓

Hibernate

↓

SQL

↓

Database

↓

Result

↓

Java Object
```

Example:

```java
employeeRepository.save(employee);
```

Hibernate generates:

```sql
INSERT INTO employee
(name, department)
VALUES
('John', 'IT');
```

---

# Hibernate and JPA

```
JPA
(Specification)

↓

Hibernate
(Implementation)

↓

Database
```

Think of it like:

```
Vehicle

↓

Car
```

- Vehicle = JPA
- Car = Hibernate

---

# Hibernate Features

- Automatic SQL generation
- Object Relational Mapping (ORM)
- Caching
- Lazy Loading
- Dirty Checking
- Transaction Management
- Database Independence
- HQL (Hibernate Query Language)

---

# Hibernate Components

## 1. Entity

Represents a database table.

```java
@Entity
public class Employee {

}
```

---

## 2. Session

The main interface used to interact with the database.

Common methods:

```java
save()

update()

delete()

get()

createQuery()
```

In Spring Boot, you usually don't use `Session` directly because Spring Data JPA manages it.

---

## 3. SessionFactory

Creates Hibernate Sessions.

```
SessionFactory

↓

Session

↓

Database
```

Normally, Spring Boot configures it automatically.

---

## 4. Transaction

Groups multiple database operations into a single unit of work.

```java
@Transactional
public void saveEmployee() {

}
```

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

}
```

Repository

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

Save

```java
employeeRepository.save(employee);
```

Hibernate generates:

```sql
INSERT INTO employee
(name)
VALUES
('John');
```

---

# CRUD with Hibernate

Create

```java
repository.save(employee);
```

Read

```java
repository.findById(id);
```

Update

```java
repository.save(employee);
```

Delete

```java
repository.deleteById(id);
```

Hibernate generates the required SQL automatically.

---

# Hibernate Lifecycle

```
Java Object

↓

Transient

↓

Persistent

↓

Detached

↓

Removed
```

### 1. Transient

Object exists only in memory.

```java
Employee employee = new Employee();
```

---

### 2. Persistent

Object is managed by Hibernate.

```java
session.save(employee);
```

---

### 3. Detached

Object is no longer managed by Hibernate.

Example:

```
Session Closed
```

---

### 4. Removed

Object is marked for deletion.

```java
session.remove(employee);
```

---

# Hibernate Caching

Hibernate uses caching to improve performance.

## First-Level Cache

- Enabled by default
- Exists per Session
- Cannot be disabled

```
Session

↓

Cache

↓

Database
```

---

## Second-Level Cache

- Shared across sessions
- Optional
- Requires configuration

Popular providers:

- Ehcache
- Hazelcast
- Infinispan

---

# Lazy Loading

Hibernate loads related data **only when required**.

Example:

```java
Employee employee = repository.findById(1L);
```

Departments are not loaded immediately.

They are loaded only when accessed.

---

# Eager Loading

Hibernate loads all related data immediately.

```
Employee

↓

Department

↓

Projects

↓

Address
```

Everything is fetched together.

---

# Request Flow

```
Spring Boot

↓

Repository

↓

Hibernate

↓

JDBC

↓

Database

↓

SQL Result

↓

Java Object
```

---

# Real-World Example

### Banking Application

```java
accountRepository.save(account);
```

Hibernate automatically creates the SQL:

```sql
INSERT INTO account ...
```

---

### E-Commerce Application

```java
productRepository.findById(100L);
```

Hibernate executes:

```sql
SELECT * FROM product
WHERE id = 100;
```

and converts the result into a `Product` object.

---

# Hibernate vs JPA

| Hibernate | JPA |
|------------|-----|
| Framework | Specification |
| Provides implementation | Defines rules |
| Can be used directly | Needs an implementation |
| Developed by Red Hat | Defined by Jakarta EE |

---

# Hibernate vs JDBC

| Hibernate | JDBC |
|------------|------|
| Automatic ORM | Manual Mapping |
| Generates SQL | Write SQL manually |
| Less Boilerplate | More Boilerplate |
| Object Oriented | SQL Oriented |

---

# Advantages

- Automatic SQL generation
- Less boilerplate code
- Database independent
- Powerful ORM support
- Built-in caching
- Supports transactions
- Easy integration with Spring Boot

---

# Best Practices

- Prefer Spring Data JPA over using Hibernate `Session` directly.
- Keep entities lightweight.
- Use lazy loading where appropriate.
- Avoid unnecessary database queries.
- Use `@Transactional` for database operations.
- Monitor generated SQL during development using:

```properties
spring.jpa.show-sql=true
```

---

# Interview Questions

### 1. What is Hibernate?

Hibernate is an ORM framework that implements the JPA specification and maps Java objects to relational database tables.

---

### 2. Is Hibernate a framework or specification?

Hibernate is a **framework**.

---

### 3. What is the difference between Hibernate and JPA?

- JPA is a specification.
- Hibernate is one of the implementations of JPA.

---

### 4. What is Hibernate's default cache?

The **First-Level Cache**, which is enabled by default and exists per Session.

---

### 5. What are the states of an entity in Hibernate?

- Transient
- Persistent
- Detached
- Removed

---

### 6. Does Hibernate generate SQL automatically?

Yes. Hibernate automatically generates SQL statements based on entity mappings and repository operations.

---

# Quick Revision

- Hibernate is an **ORM framework**.
- It implements the **JPA specification**.
- Hibernate automatically converts Java objects into database records.
- Spring Boot uses Hibernate as the default JPA implementation.
- Hibernate provides caching, lazy loading, transactions, and automatic SQL generation.
- Common entity states are **Transient**, **Persistent**, **Detached**, and **Removed**.
- In Spring Boot, you usually interact with Hibernate through **Spring Data JPA repositories** rather than directly using Hibernate `Session`.