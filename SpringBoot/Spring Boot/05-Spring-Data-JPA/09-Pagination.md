# Pagination

## What is Pagination?

**Pagination** is the process of dividing a large dataset into **smaller pages** instead of loading all records at once.

For example, instead of displaying **10,000 employees** at once, we display:

- Page 1 → 10 records
- Page 2 → 10 records
- Page 3 → 10 records

> **In simple words:**
>
> Pagination loads only a small portion of data at a time, improving performance and user experience.

---

# Why Do We Need Pagination?

Imagine an Employee table with **1,000,000 records**.

Without pagination:

```sql
SELECT *
FROM employee;
```

Problems:

- Loads all records into memory
- Slow response
- High memory usage
- Poor user experience

With pagination:

```sql
SELECT *
FROM employee
LIMIT 10 OFFSET 0;
```

Only 10 records are fetched.

---

# Real-World Example

### Amazon

Instead of showing millions of products:

```
Page 1

↓

20 Products

↓

Next Page

↓

20 More Products
```

---

### YouTube

```
Videos

↓

First 20 Videos

↓

Scroll

↓

Next 20 Videos
```

---

# How Pagination Works

```
Client

↓

Page Number + Page Size

↓

Spring Data JPA

↓

Database

↓

Only Required Records
```

---

# Pagination in Spring Data JPA

Spring Data JPA provides pagination using:

- `Page`
- `Pageable`
- `PageRequest`

---

# Repository Example

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

No additional code is required.

---

# Creating a Pageable Object

```java
Pageable pageable =
        PageRequest.of(0, 10);
```

Meaning:

```
Page Number = 0

Page Size = 10
```

---

# Fetch Paginated Data

```java
Page<Employee> page =
        repository.findAll(
                PageRequest.of(0, 10));
```

This retrieves:

- First page
- 10 employees

---

# Understanding Page Numbers

| Page Number | Records |
|-------------|---------|
| 0 | 1 - 10 |
| 1 | 11 - 20 |
| 2 | 21 - 30 |
| 3 | 31 - 40 |

> **Note:** Page numbering starts from **0**, not 1.

---

# SQL Generated

```java
PageRequest.of(1, 5);
```

Hibernate generates SQL similar to:

```sql
SELECT *
FROM employee
LIMIT 5 OFFSET 5;
```

Meaning:

```
Skip first 5 records

↓

Return next 5 records
```

---

# Accessing Page Data

```java
Page<Employee> page =
        repository.findAll(
                PageRequest.of(0, 10));

List<Employee> employees =
        page.getContent();
```

`getContent()` returns the records for the current page.

---

# Useful Page Methods

```java
page.getContent();

page.getTotalPages();

page.getTotalElements();

page.getNumber();

page.getSize();

page.hasNext();

page.hasPrevious();

page.isFirst();

page.isLast();
```

---

# Example

```java
Page<Employee> page =
        repository.findAll(
                PageRequest.of(0, 5));

System.out.println(page.getContent());

System.out.println(page.getTotalPages());

System.out.println(page.getTotalElements());

System.out.println(page.hasNext());
```

---

# Pagination with Sorting

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
- 10 employees
- Sorted by name

---

# Descending Sort

```java
Page<Employee> page =
        repository.findAll(

                PageRequest.of(
                        0,
                        10,
                        Sort.by(
                                Sort.Direction.DESC,
                                "salary"))

        );
```

Highest salary appears first.

---

# Pagination with Custom Query

Repository

```java
@Query("""
       SELECT e
       FROM Employee e
       WHERE e.department = :department
       """)
Page<Employee> findByDepartment(

        @Param("department")
        String department,

        Pageable pageable
);
```

Usage

```java
Page<Employee> page =
repository.findByDepartment(

        "IT",

        PageRequest.of(0, 5)

);
```

---

# REST API Example

```java
@GetMapping("/employees")
public Page<Employee> getEmployees(

        @RequestParam int page,

        @RequestParam int size

) {

    return repository.findAll(
            PageRequest.of(page, size));

}
```

Request

```
GET /employees?page=0&size=10
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

PageRequest

↓

Hibernate

↓

Database

↓

Page<Employee>
```

---

# Pagination vs Fetch All

| Pagination | Fetch All |
|------------|-----------|
| Loads required records only | Loads every record |
| Faster | Slower for large datasets |
| Uses less memory | Uses more memory |
| Recommended for APIs | Suitable only for small datasets |

---

# Page vs Slice

| Page | Slice |
|------|-------|
| Knows total pages | Doesn't know total pages |
| Executes COUNT query | No COUNT query |
| Slightly slower | Faster |
| Used in most APIs | Used for infinite scrolling |

---

# Real-World Example

### Banking Application

Display transactions.

```
Page 1

↓

10 Transactions

↓

Next Page

↓

10 More Transactions
```

---

### E-Commerce Application

```
Products

↓

20 Products

↓

Next Page

↓

20 More Products
```

---

# Advantages

- Faster database queries
- Better application performance
- Lower memory consumption
- Improves user experience
- Suitable for APIs and large datasets

---

# Best Practices

- Always use pagination for large datasets.
- Keep page sizes reasonable (e.g., 10–100 records).
- Combine pagination with sorting.
- Validate page number and page size received from users.
- Avoid returning huge datasets in REST APIs.

---

# Interview Questions

### 1. What is Pagination?

Pagination is the process of dividing a large dataset into smaller pages to improve performance and reduce memory usage.

---

### 2. Which classes are used for Pagination in Spring Data JPA?

- `Page`
- `Pageable`
- `PageRequest`

---

### 3. What is the difference between `Page` and `Pageable`?

- `Pageable` defines the pagination request (page number, size, sorting).
- `Page` contains the paginated results along with metadata.

---

### 4. Does page numbering start from 0 or 1?

Page numbering starts from **0**.

---

### 5. What is the difference between `Page` and `Slice`?

- `Page` provides total pages and total records by executing a COUNT query.
- `Slice` only knows whether more data exists, making it more efficient for infinite scrolling.

---

# Quick Revision

- Pagination divides large datasets into smaller pages.
- Spring Data JPA uses `Page`, `Pageable`, and `PageRequest`.
- `PageRequest.of(page, size)` creates a pagination request.
- `Page` contains records and pagination metadata.
- Page numbering starts from **0**.
- Combine pagination with sorting for better performance and user experience.