# Native Queries

## What are Native Queries?

A **Native Query** is an SQL query written in the **database's native SQL syntax** instead of JPQL.

Unlike JPQL, Native Queries work directly with:

- Database Tables
- Database Columns

instead of:

- Entity Classes
- Entity Fields

> **In simple words:**
>
> Native Queries allow you to execute raw SQL inside Spring Data JPA.

---

# Why Do We Need Native Queries?

JPQL is sufficient for most applications, but sometimes we need:

- Complex SQL queries
- Database-specific functions
- Stored Procedures
- Common Table Expressions (CTE)
- Window Functions
- Optimized SQL

In such cases, Native Queries are the preferred choice.

---

# SQL vs JPQL vs Native Query

## SQL

```sql
SELECT *
FROM employee;
```

Runs directly on the database.

---

## JPQL

```jpql
SELECT e
FROM Employee e
```

Uses Entity names and fields.

Hibernate converts it to SQL.

---

## Native Query

```java
@Query(
    value = "SELECT * FROM employee",
    nativeQuery = true
)
```

Runs exactly as written.

---

# How Native Queries Work

```
Native SQL

↓

Spring Data JPA

↓

Database

↓

Result

↓

Entity Object
```

Unlike JPQL, Hibernate does **not** convert the query.

---

# Writing a Native Query

```java
@Query(
    value = "SELECT * FROM employee",
    nativeQuery = true
)
List<Employee> findAllEmployees();
```

Generated SQL

```sql
SELECT *
FROM employee;
```

The SQL is executed directly.

---

# Fetch Records by Condition

```java
@Query(
    value = """
            SELECT *
            FROM employee
            WHERE department = :department
            """,
    nativeQuery = true
)
List<Employee> findByDepartment(

        @Param("department")
        String department
);
```

Usage

```java
repository.findByDepartment("IT");
```

---

# Multiple Conditions

```java
@Query(
    value = """
            SELECT *
            FROM employee
            WHERE department = :department
            AND salary > :salary
            """,
    nativeQuery = true
)
List<Employee> findEmployees(

        @Param("department")
        String department,

        @Param("salary")
        double salary
);
```

---

# Fetch Single Record

```java
@Query(
    value = """
            SELECT *
            FROM employee
            WHERE id = :id
            """,
    nativeQuery = true
)
Employee findEmployee(
        @Param("id") Long id);
```

---

# Insert Query

```java
@Modifying
@Transactional
@Query(
    value = """
            INSERT INTO employee
            (name, department, salary)
            VALUES
            (:name, :department, :salary)
            """,
    nativeQuery = true
)
void insertEmployee(

        @Param("name") String name,

        @Param("department") String department,

        @Param("salary") double salary
);
```

---

# Update Query

```java
@Modifying
@Transactional
@Query(
    value = """
            UPDATE employee
            SET salary = :salary
            WHERE id = :id
            """,
    nativeQuery = true
)
void updateSalary(

        @Param("id") Long id,

        @Param("salary") double salary
);
```

---

# Delete Query

```java
@Modifying
@Transactional
@Query(
    value = """
            DELETE
            FROM employee
            WHERE id = :id
            """,
    nativeQuery = true
)
void deleteEmployee(
        @Param("id") Long id);
```

---

# Aggregate Functions

Count employees.

```java
@Query(
    value = """
            SELECT COUNT(*)
            FROM employee
            """,
    nativeQuery = true
)
long countEmployees();
```

Maximum salary.

```java
@Query(
    value = """
            SELECT MAX(salary)
            FROM employee
            """,
    nativeQuery = true
)
double highestSalary();
```

Average salary.

```java
@Query(
    value = """
            SELECT AVG(salary)
            FROM employee
            """,
    nativeQuery = true
)
double averageSalary();
```

---

# Sorting

```java
@Query(
    value = """
            SELECT *
            FROM employee
            ORDER BY salary DESC
            """,
    nativeQuery = true
)
List<Employee> highestPaidEmployees();
```

---

# LIKE Query

```java
@Query(
    value = """
            SELECT *
            FROM employee
            WHERE name LIKE %:name%
            """,
    nativeQuery = true
)
List<Employee> searchEmployees(
        @Param("name")
        String name);
```

Example

```
John

↓

Matches

John

Johnny

Johnson
```

---

# IN Query

```java
@Query(
    value = """
            SELECT *
            FROM employee
            WHERE department
            IN (:departments)
            """,
    nativeQuery = true
)
List<Employee> findEmployees(

        @Param("departments")
        List<String> departments
);
```

---

# Using Database Functions

Native Queries allow database-specific functions.

Example (MySQL)

```java
@Query(
    value = """
            SELECT NOW()
            """,
    nativeQuery = true
)
String currentTime();
```

Example (PostgreSQL)

```java
@Query(
    value = """
            SELECT CURRENT_DATE
            """,
    nativeQuery = true
)
String currentDate();
```

---

# Native Query Request Flow

```
Controller

↓

Service

↓

Repository

↓

Native SQL

↓

Database

↓

Result

↓

Entity
```

---

# Native Query vs JPQL

| Native Query | JPQL |
|--------------|------|
| Uses SQL | Uses JPQL |
| Uses Tables | Uses Entities |
| Uses Columns | Uses Entity Fields |
| Database Specific | Database Independent |
| Faster for Complex Queries | Easier to Maintain |

---

# Native Query vs Derived Query

| Native Query | Derived Query |
|--------------|---------------|
| SQL Written Manually | Generated Automatically |
| More Flexible | Easier to Use |
| Suitable for Complex Queries | Suitable for Simple Queries |

---

# Real-World Example

### Banking Application

Find accounts with balance greater than a specified value.

```java
@Query(
    value = """
            SELECT *
            FROM account
            WHERE balance > :balance
            """,
    nativeQuery = true
)
```

---

### E-Commerce Application

Retrieve the top 10 best-selling products.

```java
@Query(
    value = """
            SELECT *
            FROM product
            ORDER BY sold_count DESC
            LIMIT 10
            """,
    nativeQuery = true
)
```

---

# Advantages

- Supports complex SQL queries
- Supports database-specific features
- Better for optimized SQL
- Can use stored procedures and database functions
- Gives full control over SQL

---

# Disadvantages

- Database dependent
- Less portable across different databases
- Harder to maintain than JPQL
- Requires SQL knowledge

---

# Best Practices

- Prefer JPQL for most business queries.
- Use Native Queries only when JPQL cannot express the required query efficiently.
- Always use named parameters (`:name`) instead of concatenating values.
- Use `@Modifying` for INSERT, UPDATE, and DELETE operations.
- Keep SQL readable and well formatted.

---

# Interview Questions

### 1. What is a Native Query?

A Native Query is a raw SQL query executed directly on the database using Spring Data JPA.

---

### 2. How do you write a Native Query?

Using the `@Query` annotation with `nativeQuery = true`.

```java
@Query(
    value = "SELECT * FROM employee",
    nativeQuery = true
)
```

---

### 3. What is the difference between JPQL and Native Query?

- JPQL uses Entity classes and fields.
- Native Query uses database tables and columns.

---

### 4. When should you use Native Queries?

Use Native Queries when:

- Complex SQL is required
- Database-specific features are needed
- JPQL cannot express the required query efficiently

---

### 5. Can Native Queries return Entity objects?

Yes. If the selected columns match the entity mapping, Spring Data JPA automatically maps the result to Entity objects.

---

# Quick Revision

- Native Queries use **raw SQL** instead of JPQL.
- Enable them using `@Query(nativeQuery = true)`.
- They work with **database tables and columns**.
- Use `@Modifying` and `@Transactional` for INSERT, UPDATE, and DELETE operations.
- Prefer JPQL for portability and Native Queries only for complex or database-specific requirements.v