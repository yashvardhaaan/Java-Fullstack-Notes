# JPQL (Java Persistence Query Language)

## What is JPQL?

**JPQL (Java Persistence Query Language)** is an **object-oriented query language** used to query **Entity objects** instead of database tables.

Unlike SQL, JPQL works with:

- Entity Classes
- Entity Fields

instead of:

- Database Tables
- Database Columns

> **In simple words:**
>
> JPQL allows you to query Java objects instead of writing SQL for database tables.

---

# Why Do We Need JPQL?

Suppose we have an Entity:

```java
@Entity
public class Employee {

    @Id
    private Long id;

    private String name;

    private String department;

}
```

Database Table:

```
employee
```

Instead of writing SQL:

```sql
SELECT *
FROM employee
WHERE department = 'IT';
```

We write JPQL:

```jpql
SELECT e
FROM Employee e
WHERE e.department = 'IT'
```

Notice:

- **Employee** → Entity Name
- **department** → Java Field

Not the table or column names.

---

# SQL vs JPQL

## SQL

```sql
SELECT *
FROM employee
WHERE department='IT';
```

Works with:

- Tables
- Columns

---

## JPQL

```jpql
SELECT e
FROM Employee e
WHERE e.department='IT';
```

Works with:

- Entity
- Entity Fields

---

# How JPQL Works

```
JPQL

↓

Hibernate

↓

SQL

↓

Database
```

Example

```jpql
SELECT e
FROM Employee e
```

Hibernate converts it into:

```sql
SELECT *
FROM employee;
```

---

# Writing JPQL in Spring Data JPA

Use the `@Query` annotation.

```java
@Query("SELECT e FROM Employee e")
List<Employee> getEmployees();
```

---

# Fetch All Records

```java
@Query("SELECT e FROM Employee e")
List<Employee> findAllEmployees();
```

Equivalent SQL:

```sql
SELECT *
FROM employee;
```

---

# Fetch by Condition

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.department = :department
       """)
List<Employee> findByDepartment(
        @Param("department")
        String department);
```

Usage

```java
repository.findByDepartment("IT");
```

---

# Multiple Conditions

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.department = :department
       AND e.salary > :salary
       """)
List<Employee> findEmployees(

        @Param("department")
        String department,

        @Param("salary")
        double salary);
```

---

# Fetch Single Record

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.id = :id
       """)
Employee findEmployee(
        @Param("id") Long id);
```

---

# Sorting

```java
@Query("""
       SELECT e
       FROM Employee e
       ORDER BY e.salary DESC
       """)
List<Employee> highestSalary();
```

Ascending

```jpql
ORDER BY e.name ASC
```

Descending

```jpql
ORDER BY e.salary DESC
```

---

# Aggregate Functions

## Count

```java
@Query("""
       SELECT COUNT(e)
       FROM Employee e
       """)
long countEmployees();
```

---

## Average Salary

```java
@Query("""
       SELECT AVG(e.salary)
       FROM Employee e
       """)
Double averageSalary();
```

---

## Maximum Salary

```java
@Query("""
       SELECT MAX(e.salary)
       FROM Employee e
       """)
Double maxSalary();
```

---

## Minimum Salary

```java
@Query("""
       SELECT MIN(e.salary)
       FROM Employee e
       """)
Double minSalary();
```

---

## Sum

```java
@Query("""
       SELECT SUM(e.salary)
       FROM Employee e
       """)
Double totalSalary();
```

---

# LIKE Query

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.name LIKE %:name%
       """)
List<Employee> searchByName(
        @Param("name")
        String name);
```

Example

```
John

↓

Matches

John

Johnson

Johnny
```

---

# IN Query

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.department IN :departments
       """)
List<Employee> findEmployees(

        @Param("departments")
        List<String> departments);
```

---

# UPDATE Query

```java
@Modifying
@Transactional
@Query("""
       UPDATE Employee e
       SET e.salary = :salary
       WHERE e.id = :id
       """)
void updateSalary(

        @Param("id") Long id,

        @Param("salary") double salary);
```

---

# DELETE Query

```java
@Modifying
@Transactional
@Query("""
       DELETE FROM Employee e
       WHERE e.id = :id
       """)
void deleteEmployee(
        @Param("id") Long id);
```

---

# Named Parameters

Recommended approach.

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.department = :dept
       """)
List<Employee> getEmployees(
        @Param("dept")
        String department);
```

Avoid positional parameters when possible.

---

# JPQL Request Flow

```
Controller

↓

Service

↓

Repository

↓

JPQL

↓

Hibernate

↓

SQL

↓

Database
```

---

# JPQL vs SQL

| JPQL | SQL |
|------|-----|
| Uses Entity Names | Uses Table Names |
| Uses Entity Fields | Uses Column Names |
| Database Independent | Database Specific |
| Object-Oriented | Table-Oriented |

---

# JPQL vs Native Query

| JPQL | Native Query |
|------|--------------|
| Database Independent | Database Specific |
| Uses Entities | Uses Tables |
| Easier to Maintain | More Flexible |
| Recommended for Most Cases | Used for Complex SQL |

---

# Real-World Example

### Banking Application

Retrieve all savings accounts.

```java
@Query("""
       SELECT a
       FROM Account a
       WHERE a.accountType='SAVINGS'
       """)
```

---

### E-Commerce Application

Find products by category.

```java
@Query("""
       SELECT p
       FROM Product p
       WHERE p.category=:category
       """)
```

---

# Advantages

- Object-oriented querying
- Database independent
- Easier to maintain
- Supports joins and aggregate functions
- Integrates seamlessly with Spring Data JPA

---

# Best Practices

- Prefer derived query methods for simple queries.
- Use JPQL when derived query methods become complex.
- Use named parameters (`:name`) instead of positional parameters.
- Use `@Modifying` for UPDATE and DELETE queries.
- Keep JPQL readable and concise.

---

# Interview Questions

### 1. What is JPQL?

JPQL (Java Persistence Query Language) is an object-oriented query language that queries **Entity objects** instead of database tables.

---

### 2. What is the difference between JPQL and SQL?

- JPQL uses **Entity classes and fields**.
- SQL uses **database tables and columns**.

---

### 3. Which annotation is used to write JPQL?

```java
@Query
```

---

### 4. Why is `@Modifying` required?

`@Modifying` tells Spring Data JPA that the query modifies data (UPDATE or DELETE) instead of retrieving it.

---

### 5. Can JPQL perform JOIN operations?

Yes. JPQL supports INNER JOIN, LEFT JOIN, FETCH JOIN, and other join operations using entity relationships.

---

# Quick Revision

- JPQL stands for **Java Persistence Query Language**.
- It queries **Entity objects**, not database tables.
- Use `@Query` to write JPQL in Spring Data JPA.
- Use named parameters with `@Param`.
- Use `@Modifying` and `@Transactional` for UPDATE and DELETE queries.
- Prefer JPQL over native SQL unless database-specific features are required.