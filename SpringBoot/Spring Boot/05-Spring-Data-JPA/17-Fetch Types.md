# Fetch Types (`FetchType`)

## What is Fetch Type?

**Fetch Type** determines **when Hibernate should load related entities** from the database.

Whenever two entities have a relationship, Hibernate needs to decide:

- Should the related data be loaded immediately?
- Or should it be loaded only when needed?

This behavior is controlled using `FetchType`.

> **In simple words:**
>
> Fetch Type controls **when related data is fetched from the database**.

---

# Why Do We Need Fetch Types?

Suppose an Employee belongs to a Department.

```java
Employee

↓

Department
```

When loading an Employee, should Hibernate also load the Department?

There are two possibilities:

- Load immediately (**EAGER**)
- Load only when accessed (**LAZY**)

---

# Types of Fetching

Spring Data JPA provides two fetch types:

| Fetch Type | Description |
|------------|-------------|
| `FetchType.EAGER` | Load related entity immediately |
| `FetchType.LAZY` | Load related entity only when required |

---

# How Fetching Works

```
Database

↓

Employee

↓

Department

↓

Hibernate

↓

Application
```

Hibernate decides when to fetch the Department based on the configured fetch type.

---

# FetchType.EAGER

With **EAGER**, Hibernate loads the parent entity **and** all related entities immediately.

Example

```java
@ManyToOne(fetch = FetchType.EAGER)
private Department department;
```

---

## Flow

```
Load Employee

↓

Immediately Load Department

↓

Return Employee
```

---

## Generated SQL

Employee Query

```sql
SELECT *
FROM employee
WHERE id = 1;
```

Department Query

```sql
SELECT *
FROM department
WHERE id = 10;
```

Both queries are executed immediately.

---

# FetchType.LAZY

With **LAZY**, Hibernate loads only the requested entity.

Related entities are loaded only when accessed.

Example

```java
@ManyToOne(fetch = FetchType.LAZY)
private Department department;
```

---

## Flow

```
Load Employee

↓

Return Employee

↓

department.getName()

↓

Now Load Department
```

---

## Generated SQL

Initially

```sql
SELECT *
FROM employee
WHERE id = 1;
```

Later

```sql
SELECT *
FROM department
WHERE id = 10;
```

The second query executes only when the department is accessed.

---

# Example

Employee Entity

```java
@Entity
public class Employee {

    @Id
    private Long id;

    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    private Department department;

}
```

Usage

```java
Employee employee =
        repository.findById(1L).get();

System.out.println(employee.getName());
```

Only the Employee is loaded.

When we access:

```java
employee.getDepartment().getName();
```

Hibernate fetches the Department.

---

# Default Fetch Types

| Relationship | Default Fetch Type |
|--------------|--------------------|
| `@OneToOne` | `EAGER` |
| `@ManyToOne` | `EAGER` |
| `@OneToMany` | `LAZY` |
| `@ManyToMany` | `LAZY` |

---

# Why Collections Use LAZY

Suppose one Department has:

```
5000 Employees
```

If Hibernate always loaded employees automatically:

```
Department

↓

5000 Employees

↓

Huge Memory Usage
```

Using LAZY avoids unnecessary data loading.

---

# LazyInitializationException

One common issue with LAZY loading is:

```java
Employee employee =
        repository.findById(1L).get();

return employee;
```

Later

```java
employee.getDepartment().getName();
```

If the Hibernate session has already closed:

```
LazyInitializationException
```

---

# Solutions

### 1. Access Within Transaction

```java
@Transactional
public Employee getEmployee() {

    Employee employee =
            repository.findById(1L).get();

    employee.getDepartment().getName();

    return employee;
}
```

---

### 2. Use JOIN FETCH

```java
@Query("""
       SELECT e
       FROM Employee e
       JOIN FETCH e.department
       WHERE e.id = :id
       """)
Employee findEmployee(Long id);
```

Both Employee and Department are loaded in one query.

---

### 3. Use DTO Projection

Instead of returning entities:

```java
public record EmployeeDTO(

        String name,

        String department

) {}
```

Fetch only the required fields.

---

# Fetching Flow

## EAGER

```
Employee

↓

Department

↓

Response
```

Everything loads immediately.

---

## LAZY

```
Employee

↓

Response

↓

Department Accessed

↓

Department Loaded
```

---

# Performance Comparison

| EAGER | LAZY |
|--------|-------|
| Loads immediately | Loads only when needed |
| More database queries initially | Queries executed on demand |
| Higher memory usage | Lower memory usage |
| Simpler to use | Better performance for large datasets |

---

# N+1 Query Problem

Suppose:

```
100 Employees

↓

Each Employee

↓

Department
```

With LAZY:

```
1 Query

+

100 Additional Queries

=

101 Queries
```

This is called the **N+1 Query Problem**.

---

# Solution for N+1

Use **Fetch Join**.

```java
SELECT e

FROM Employee e

JOIN FETCH e.department
```

Only one query is executed.

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

Entity
```

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

Load Customer first.

Load Transactions only when the user opens the transaction history.

---

### E-Commerce Application

```
Product

↓

Reviews
```

Initially load only product details.

Load reviews only when the customer views them.

---

# EAGER vs LAZY

| EAGER | LAZY |
|--------|-------|
| Immediate Loading | Delayed Loading |
| More Memory Usage | Less Memory Usage |
| May Fetch Unused Data | Fetches Only Required Data |
| Default for `@ManyToOne` | Default for Collections |

---

# Advantages of LAZY

- Better performance
- Lower memory consumption
- Loads only required data
- Ideal for large applications

---

# Best Practices

- Prefer `FetchType.LAZY` unless immediate loading is required.
- Avoid changing all relationships to `EAGER`.
- Use `JOIN FETCH` to avoid the N+1 query problem.
- Use DTOs in REST APIs instead of exposing entities directly.
- Access lazy-loaded entities within an active transaction.

---

# Interview Questions

### 1. What is Fetch Type?

Fetch Type determines when related entities are loaded from the database.

---

### 2. What are the two fetch types?

- `FetchType.EAGER`
- `FetchType.LAZY`

---

### 3. What are the default fetch types?

- `@OneToOne` → `EAGER`
- `@ManyToOne` → `EAGER`
- `@OneToMany` → `LAZY`
- `@ManyToMany` → `LAZY`

---

### 4. What is `LazyInitializationException`?

It occurs when a lazy-loaded entity is accessed after the Hibernate session has been closed.

---

### 5. What is the N+1 Query Problem?

It occurs when one query loads parent entities and additional queries are executed for each related entity, resulting in many unnecessary database calls.

---

# Quick Revision

- Fetch Type controls **when related entities are loaded**.
- `EAGER` loads related data immediately.
- `LAZY` loads related data only when accessed.
- Collections (`@OneToMany`, `@ManyToMany`) use `LAZY` by default.
- Single-valued relationships (`@OneToOne`, `@ManyToOne`) use `EAGER` by default.
- Prefer `LAZY` in production for better performance.
- Use `JOIN FETCH` to avoid the N+1 query problem.
- Use DTOs to prevent unnecessary entity loading and serialization issues.