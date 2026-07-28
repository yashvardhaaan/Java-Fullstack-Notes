# Sorting

## What is Sorting?

**Sorting** is the process of arranging data in a specific order, such as:

- Ascending (A → Z, Small → Large)
- Descending (Z → A, Large → Small)

Spring Data JPA provides built-in support for sorting records without writing SQL.

> **In simple words:**
>
> Sorting allows you to retrieve data in an ordered manner based on one or more fields.

---

# Why Do We Need Sorting?

Imagine an Employee table.

| ID | Name | Salary |
|----|------|---------|
| 3 | Charlie | 70000 |
| 1 | Alice | 90000 |
| 2 | Bob | 60000 |

Without sorting:

```
Charlie

Alice

Bob
```

Not easy to analyze.

With sorting by name:

```
Alice

Bob

Charlie
```

Or by salary (highest first):

```
90000

70000

60000
```

---

# Real-World Example

### Amazon

Products can be sorted by:

- Price: Low to High
- Price: High to Low
- Customer Rating
- Newest Arrivals

---

### YouTube

Videos can be sorted by:

- Most Viewed
- Upload Date
- Popularity

---

# How Sorting Works

```
Client

↓

Sorting Field

↓

Spring Data JPA

↓

Hibernate

↓

ORDER BY

↓

Database

↓

Sorted Records
```

---

# Sorting in Spring Data JPA

Spring Data JPA provides the `Sort` class.

```java
Sort.by("name");
```

This generates SQL similar to:

```sql
ORDER BY name ASC;
```

---

# Repository Example

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

No additional methods are required for basic sorting.

---

# Ascending Sort

```java
List<Employee> employees =
        repository.findAll(
                Sort.by("name"));
```

Generated SQL

```sql
SELECT *
FROM employee
ORDER BY name ASC;
```

---

# Descending Sort

```java
List<Employee> employees =
        repository.findAll(

                Sort.by(
                        Sort.Direction.DESC,
                        "salary")

);
```

Generated SQL

```sql
SELECT *
FROM employee
ORDER BY salary DESC;
```

---

# Multiple Field Sorting

Sort by department first and then by salary.

```java
List<Employee> employees =
        repository.findAll(

                Sort.by("department")
                    .and(Sort.by("salary"))

);
```

Generated SQL

```sql
SELECT *
FROM employee
ORDER BY department ASC,
         salary ASC;
```

---

# Mixed Sorting

Department ascending and salary descending.

```java
Sort sort = Sort.by("department")
        .ascending()
        .and(
            Sort.by("salary")
                .descending()
        );

List<Employee> employees =
        repository.findAll(sort);
```

---

# Sorting with Pagination

```java
Page<Employee> page =
        repository.findAll(

                PageRequest.of(
                        0,
                        10,
                        Sort.by("name"))

);
```

Returns:

- First page
- 10 records
- Sorted by name

---

# Custom Query with Sorting

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.department = :department
       """)
List<Employee> findEmployees(

        @Param("department")
        String department,

        Sort sort
);
```

Usage

```java
repository.findEmployees(

        "IT",

        Sort.by("salary")
);
```

---

# Sorting by Multiple Fields

```java
Sort sort = Sort.by("department")
        .ascending()
        .and(
            Sort.by("name")
                .ascending()
        )
        .and(
            Sort.by("salary")
                .descending()
        );

repository.findAll(sort);
```

Generated SQL

```sql
ORDER BY department ASC,
         name ASC,
         salary DESC;
```

---

# REST API Example

```java
@GetMapping("/employees")
public List<Employee> getEmployees(

        @RequestParam String sortBy,

        @RequestParam String direction

) {

    Sort sort = direction.equalsIgnoreCase("desc")

            ? Sort.by(sortBy).descending()

            : Sort.by(sortBy).ascending();

    return repository.findAll(sort);
}
```

Request

```
GET /employees?sortBy=salary&direction=desc
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

JpaRepository

↓

Sort

↓

Hibernate

↓

ORDER BY

↓

Database
```

---

# Sorting vs Pagination

| Sorting | Pagination |
|----------|------------|
| Arranges records | Divides records into pages |
| Uses `Sort` | Uses `PageRequest` |
| Can be used independently | Often combined with sorting |

---

# Sort vs ORDER BY

| Spring Data JPA | SQL |
|-----------------|-----|
| `Sort.by("name")` | `ORDER BY name ASC` |
| `Sort.by("salary").descending()` | `ORDER BY salary DESC` |

---

# Real-World Example

### Banking Application

Display transactions:

- Latest first
- Highest amount first

```java
repository.findAll(
        Sort.by("transactionDate")
            .descending());
```

---

### E-Commerce Application

Display products:

- Cheapest first

```java
repository.findAll(
        Sort.by("price"));
```

Best-selling products:

```java
repository.findAll(
        Sort.by("soldCount")
            .descending());
```

---

# Advantages

- Easy to implement
- No manual SQL required
- Supports multiple fields
- Integrates with pagination
- Database performs sorting efficiently

---

# Best Practices

- Let the database perform sorting instead of sorting in Java.
- Combine sorting with pagination for better performance.
- Validate sorting fields received from API requests.
- Avoid sorting on unindexed columns for very large tables.
- Use meaningful field names that exist in the Entity.

---

# Interview Questions

### 1. What is Sorting?

Sorting is the process of arranging records in ascending or descending order based on one or more fields.

---

### 2. Which class is used for Sorting in Spring Data JPA?

```java
Sort
```

---

### 3. How do you sort records in descending order?

```java
repository.findAll(
        Sort.by("salary")
            .descending());
```

---

### 4. Can Sorting be combined with Pagination?

Yes.

```java
PageRequest.of(
        0,
        10,
        Sort.by("name"));
```

---

### 5. Can you sort by multiple fields?

Yes.

```java
Sort.by("department")
    .and(Sort.by("salary"));
```

---

# Quick Revision

- Sorting arranges records in ascending or descending order.
- Spring Data JPA provides the `Sort` class.
- `Sort.by("field")` performs ascending sorting by default.
- Use `.descending()` for descending order.
- Multiple fields can be sorted using `.and()`.
- Sorting is commonly combined with pagination using `PageRequest`.
- Prefer database-level sorting for better performance.