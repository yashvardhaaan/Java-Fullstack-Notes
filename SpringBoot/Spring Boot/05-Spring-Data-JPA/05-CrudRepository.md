# CrudRepository

## What is `CrudRepository`?

`CrudRepository` is a Spring Data interface that provides **basic CRUD (Create, Read, Update, Delete)** operations for an Entity.

Instead of writing SQL queries, you can use built-in methods provided by `CrudRepository`.

> **In simple words:**
>
> `CrudRepository` gives you ready-made methods to save, retrieve, update, and delete data from the database.

---

# Why Do We Need `CrudRepository`?

Without `CrudRepository`, we would need to write SQL for every operation.

Example:

```sql
INSERT INTO employee(name)
VALUES ('John');
```

```sql
SELECT * FROM employee;
```

```sql
DELETE FROM employee
WHERE id = 1;
```

With `CrudRepository`:

```java
repository.save(employee);

repository.findAll();

repository.deleteById(1L);
```

Spring automatically performs these operations.

---

# Hierarchy

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

Every higher interface inherits the functionality of the previous one.

---

# Syntax

```java
public interface EmployeeRepository
        extends CrudRepository<Employee, Long> {

}
```

Where:

- `Employee` → Entity class
- `Long` → Primary key type

---

# How `CrudRepository` Works

```
Application

↓

CrudRepository

↓

Hibernate

↓

SQL

↓

Database
```

Example:

```java
repository.save(employee);
```

Hibernate generates:

```sql
INSERT INTO employee
(name)
VALUES
('John');
```

---

# Common CRUD Methods

## 1. Save

```java
Employee employee = new Employee();

employee.setName("John");

repository.save(employee);
```

Generated SQL

```sql
INSERT INTO employee ...
```

If the entity already exists, `save()` performs an **UPDATE**.

---

## 2. Find By ID

```java
Optional<Employee> employee =
        repository.findById(1L);
```

Generated SQL

```sql
SELECT *
FROM employee
WHERE id = 1;
```

---

## 3. Find All

```java
Iterable<Employee> employees =
        repository.findAll();
```

Generated SQL

```sql
SELECT *
FROM employee;
```

---

## 4. Delete By ID

```java
repository.deleteById(1L);
```

Generated SQL

```sql
DELETE
FROM employee
WHERE id = 1;
```

---

## 5. Delete Entity

```java
repository.delete(employee);
```

Deletes the specified entity.

---

## 6. Count

```java
long total = repository.count();
```

Generated SQL

```sql
SELECT COUNT(*)
FROM employee;
```

---

## 7. Exists

```java
boolean exists =
        repository.existsById(1L);
```

Returns:

```
true
```

or

```
false
```

---

# Complete CRUD Example

Repository

```java
public interface EmployeeRepository
        extends CrudRepository<Employee, Long> {

}
```

Service

```java
Employee employee = new Employee();

employee.setName("John");

repository.save(employee);

repository.findAll();

repository.findById(1L);

repository.deleteById(1L);
```

---

# Built-in Methods

| Method | Purpose |
|---------|----------|
| `save()` | Insert or Update |
| `saveAll()` | Save Multiple Records |
| `findById()` | Find by Primary Key |
| `findAll()` | Fetch All Records |
| `findAllById()` | Fetch Multiple Records |
| `delete()` | Delete Entity |
| `deleteById()` | Delete by ID |
| `deleteAll()` | Delete All Records |
| `count()` | Count Records |
| `existsById()` | Check Record Exists |

---

# Request Flow

```
Controller

↓

Service

↓

CrudRepository

↓

Hibernate

↓

Database
```

---

# Real-World Example

### Banking Application

Create an account.

```java
accountRepository.save(account);
```

Find account.

```java
accountRepository.findById(1001L);
```

Delete account.

```java
accountRepository.deleteById(1001L);
```

---

### E-Commerce Application

Save product.

```java
productRepository.save(product);
```

Fetch all products.

```java
productRepository.findAll();
```

Delete product.

```java
productRepository.delete(product);
```

---

# CrudRepository vs JpaRepository

| CrudRepository | JpaRepository |
|----------------|---------------|
| Basic CRUD operations | CRUD + JPA-specific features |
| No pagination support | Supports pagination |
| No sorting support | Supports sorting |
| Smaller API | Richer API |

`JpaRepository` extends `CrudRepository`, so it includes all CRUD methods.

---

# CrudRepository vs Repository

| Repository | CrudRepository |
|------------|----------------|
| Marker interface | Provides CRUD methods |
| No built-in methods | Built-in CRUD methods |

---

# Advantages

- Eliminates boilerplate SQL
- Built-in CRUD methods
- Easy to use
- Automatically implemented by Spring
- Integrates with Hibernate

---

# Best Practices

- Use `CrudRepository` for applications that only need basic CRUD operations.
- Prefer `JpaRepository` for most Spring Boot applications because it also supports pagination, sorting, and additional JPA features.
- Keep business logic in the Service layer.
- Validate data before saving.

---

# Interview Questions

### 1. What is `CrudRepository`?

`CrudRepository` is a Spring Data interface that provides basic CRUD operations for an entity.

---

### 2. Does `CrudRepository` provide an implementation?

No. Spring Data JPA automatically generates the implementation at runtime.

---

### 3. What is the return type of `findById()`?

```java
Optional<T>
```

---

### 4. Can `save()` perform both INSERT and UPDATE?

Yes.

- If the entity is new, it performs an **INSERT**.
- If the entity already exists, it performs an **UPDATE**.

---

### 5. What is the difference between `CrudRepository` and `JpaRepository`?

- `CrudRepository` provides only basic CRUD operations.
- `JpaRepository` extends `CrudRepository` and adds pagination, sorting, batch operations, and other JPA-specific features.

---

# Quick Revision

- `CrudRepository` provides basic CRUD operations.
- It extends the `Repository` interface.
- Spring automatically generates its implementation.
- Common methods include `save()`, `findById()`, `findAll()`, `deleteById()`, `count()`, and `existsById()`.
- `save()` performs both insert and update operations.
- In modern Spring Boot applications, `JpaRepository` is generally preferred because it offers all CRUD functionality plus additional features.