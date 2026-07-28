# JpaRepository

## What is `JpaRepository`?

`JpaRepository` is the **most commonly used repository interface** in Spring Data JPA. It extends `CrudRepository` and `PagingAndSortingRepository`, providing CRUD operations along with additional JPA-specific features like pagination, sorting, flushing, and batch operations.

> **In simple words:**
>
> `JpaRepository` gives you everything needed to interact with the database without writing SQL for most use cases.

---

# Why Do We Need `JpaRepository`?

Suppose you are building an Employee Management System.

You need to:

- Add employees
- Update employee details
- Delete employees
- View all employees
- Sort employees
- Paginate results

Instead of writing SQL for each operation:

```sql
SELECT * FROM employee
ORDER BY name;
```

You can simply write:

```java
repository.findAll(Sort.by("name"));
```

Spring Data JPA generates the SQL automatically.

---

# Repository Hierarchy

```
Repository
      │
      ▼
CrudRepository
      │
      ▼
PagingAndSortingRepository
      │
      ▼
JpaRepository
```

`JpaRepository` inherits all methods from its parent interfaces.

---

# Syntax

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

Where:

- `Employee` → Entity class
- `Long` → Primary key type

---

# How `JpaRepository` Works

```
Application

↓

JpaRepository

↓

Hibernate

↓

SQL

↓

Database
```

---

# CRUD Operations

## Save

```java
Employee employee = new Employee();

employee.setName("John");

repository.save(employee);
```

Generated SQL

```sql
INSERT INTO employee ...
```

---

## Find By ID

```java
Optional<Employee> employee =
        repository.findById(1L);
```

---

## Find All

```java
List<Employee> employees =
        repository.findAll();
```

Unlike `CrudRepository`, `findAll()` returns a **List** instead of an `Iterable`.

---

## Delete

```java
repository.deleteById(1L);
```

---

# Sorting

Sort employees by name.

```java
List<Employee> employees =
        repository.findAll(
                Sort.by("name"));
```

Descending order:

```java
repository.findAll(
        Sort.by(
            Sort.Direction.DESC,
            "salary"));
```

---

# Pagination

Retrieve only a specific page of data.

```java
Page<Employee> page =
        repository.findAll(
                PageRequest.of(0, 5));
```

Meaning:

```
Page Number = 0

Page Size = 5
```

Only five employees are returned.

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

This returns:

- First page
- 10 records
- Sorted by name

---

# Batch Save

Save multiple entities.

```java
repository.saveAll(employeeList);
```

---

# Batch Delete

```java
repository.deleteAll(employeeList);
```

or

```java
repository.deleteAll();
```

---

# Flush Changes

Immediately synchronize changes with the database.

```java
repository.flush();
```

Or

```java
repository.saveAndFlush(employee);
```

Normally, Hibernate waits until the transaction commits.

`flush()` forces SQL execution immediately.

---

# Common JpaRepository Methods

| Method | Description |
|---------|-------------|
| `save()` | Insert or Update |
| `saveAll()` | Save Multiple Records |
| `findById()` | Find by Primary Key |
| `findAll()` | Retrieve All Records |
| `deleteById()` | Delete by ID |
| `deleteAll()` | Delete All Records |
| `count()` | Count Records |
| `existsById()` | Check if Record Exists |
| `flush()` | Synchronize with Database |
| `saveAndFlush()` | Save and Flush Immediately |

---

# Custom Query Methods

Spring Data JPA creates queries from method names.

```java
List<Employee> findByDepartment(
        String department);
```

Generated SQL:

```sql
SELECT *
FROM employee
WHERE department = ?;
```

Multiple conditions:

```java
List<Employee>
findByDepartmentAndSalaryGreaterThan(

        String department,

        double salary
);
```

---

# Request Flow

```
Controller

↓

Service

↓

JpaRepository

↓

Hibernate

↓

Database
```

---

# Real-World Example

### Banking Application

Open an account.

```java
accountRepository.save(account);
```

Retrieve all accounts sorted by balance.

```java
accountRepository.findAll(
        Sort.by("balance"));
```

---

### E-Commerce Application

Display products page by page.

```java
productRepository.findAll(
        PageRequest.of(0, 20));
```

Show:

- First page
- 20 products

---

# JpaRepository vs CrudRepository

| JpaRepository | CrudRepository |
|----------------|----------------|
| Supports CRUD | Supports CRUD |
| Supports Pagination | No Pagination |
| Supports Sorting | No Sorting |
| Returns `List` from `findAll()` | Returns `Iterable` |
| Includes Flush Operations | No Flush Support |

---

# JpaRepository vs PagingAndSortingRepository

| JpaRepository | PagingAndSortingRepository |
|---------------|---------------------------|
| Pagination + Sorting + JPA Features | Pagination + Sorting Only |
| Flush Support | No Flush Support |
| Batch Operations | Limited Features |

---

# Advantages

- Complete CRUD support
- Built-in pagination
- Built-in sorting
- Batch operations
- Flush support
- Automatic SQL generation
- Most commonly used repository in Spring Boot

---

# Best Practices

- Prefer `JpaRepository` for most Spring Boot applications.
- Use pagination for large datasets.
- Use sorting instead of sorting data manually in Java.
- Use `saveAll()` for batch inserts.
- Avoid calling `flush()` unless immediate synchronization is required.
- Keep business logic in the Service layer.

---

# Interview Questions

### 1. What is `JpaRepository`?

`JpaRepository` is a Spring Data JPA interface that extends `CrudRepository` and `PagingAndSortingRepository`, providing CRUD operations along with pagination, sorting, and JPA-specific features.

---

### 2. Why is `JpaRepository` preferred over `CrudRepository`?

Because it provides additional features such as:

- Pagination
- Sorting
- Batch operations
- Flush methods

---

### 3. What is the return type of `findAll()` in `JpaRepository`?

```java
List<T>
```

---

### 4. What does `flush()` do?

`flush()` immediately synchronizes the persistence context with the database by executing pending SQL statements.

---

### 5. What is the difference between `save()` and `saveAndFlush()`?

- `save()` persists the entity, and SQL is executed when the transaction is committed.
- `saveAndFlush()` persists the entity and immediately executes the SQL.

---

# Quick Revision

- `JpaRepository` is the most commonly used Spring Data JPA repository.
- It extends `CrudRepository` and `PagingAndSortingRepository`.
- It supports CRUD operations, pagination, sorting, batch operations, and flushing.
- `findAll()` returns a `List`.
- Use `PageRequest` for pagination and `Sort` for sorting.
- Prefer `JpaRepository` for almost all Spring Boot projects.