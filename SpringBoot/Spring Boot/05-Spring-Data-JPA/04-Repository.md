# Repository

## What is a Repository?

A **Repository** is a Spring Data JPA component that acts as a bridge between the **application** and the **database**.

It provides methods to perform database operations without writing SQL.

> **In simple words:**
>
> A Repository is responsible for saving, retrieving, updating, and deleting data from the database.

---

# Why Do We Need a Repository?

Without a Repository, we would have to:

- Open database connections
- Write SQL queries
- Execute queries
- Convert database records into Java objects
- Close connections

Example (JDBC):

```java
Connection connection = DriverManager.getConnection(...);

PreparedStatement statement =
connection.prepareStatement(
"SELECT * FROM employee");
```

Lots of repetitive code.

With Spring Data JPA:

```java
employeeRepository.findAll();
```

Everything is handled automatically.

---

# Repository in Spring Boot Architecture

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
```

The Repository communicates with Hibernate, which generates SQL and interacts with the database.

---

# How Repository Works

```
Java Method

↓

Repository

↓

Hibernate

↓

SQL

↓

Database
```

Example:

```java
employeeRepository.save(employee);
```

Hibernate automatically generates:

```sql
INSERT INTO employee
(name)
VALUES
('John');
```

---

# Creating a Repository

```java
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

Here:

- `Employee` → Entity class
- `Long` → Type of primary key

Spring automatically creates the implementation at runtime.

---

# Why Interface Instead of Class?

We only write:

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long> {

}
```

Spring Data JPA generates the implementation automatically.

No need to write:

```java
class EmployeeRepositoryImpl {

}
```

---

# Using Repository

## Save Data

```java
Employee employee = new Employee();

employee.setName("John");

employeeRepository.save(employee);
```

---

## Fetch All Data

```java
List<Employee> employees =
        employeeRepository.findAll();
```

---

## Fetch by ID

```java
Employee employee =
        employeeRepository.findById(1L)
                          .orElse(null);
```

---

## Delete Data

```java
employeeRepository.deleteById(1L);
```

---

# Common Repository Methods

| Method | Description |
|---------|-------------|
| `save()` | Insert or Update |
| `findById()` | Find by Primary Key |
| `findAll()` | Retrieve All Records |
| `deleteById()` | Delete by Primary Key |
| `existsById()` | Check if Record Exists |
| `count()` | Count Total Records |

---

# Custom Query Methods

Spring Data JPA can generate queries from method names.

Example:

```java
List<Employee> findByDepartment(
        String department);
```

Spring automatically generates SQL similar to:

```sql
SELECT *
FROM employee
WHERE department = ?;
```

---

# Multiple Conditions

```java
List<Employee> findByDepartmentAndSalaryGreaterThan(
        String department,
        double salary);
```

Spring generates the query automatically.

---

# Repository Flow

```
employeeRepository.save(employee)

↓

Spring Data JPA

↓

Hibernate

↓

SQL

↓

Database
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

Repository

↓

Hibernate

↓

Database

↓

Response
```

---

# Real-World Example

### Banking Application

Save a new account.

```java
accountRepository.save(account);
```

Find an account.

```java
accountRepository.findById(1001L);
```

Delete an account.

```java
accountRepository.deleteById(1001L);
```

---

### E-Commerce Application

Find all products.

```java
productRepository.findAll();
```

Search products by category.

```java
productRepository.findByCategory("Laptop");
```

---

# Repository vs DAO

| Repository | DAO |
|------------|-----|
| Spring Data JPA concept | Traditional Design Pattern |
| Less boilerplate code | More manual code |
| Auto-generated implementation | Developer writes implementation |
| Supports query methods | SQL written manually |

---

# Repository vs EntityManager

| Repository | EntityManager |
|------------|---------------|
| High-level abstraction | Low-level JPA API |
| Easier to use | More flexible but verbose |
| Recommended for most applications | Used for complex/custom operations |

---

# Advantages

- Eliminates boilerplate database code
- Automatic implementation generation
- Supports CRUD operations
- Supports pagination and sorting
- Supports custom query methods
- Integrates seamlessly with Spring Boot

---

# Best Practices

- Keep repositories focused only on database operations.
- Place business logic in the Service layer.
- Use descriptive method names for derived queries.
- Prefer repository methods over native SQL whenever possible.
- Use custom queries only when repository methods are insufficient.

---

# Interview Questions

### 1. What is a Repository?

A Repository is a Spring Data JPA component that provides an abstraction over database operations and interacts with the database through JPA.

---

### 2. Why is a Repository an interface?

Spring Data JPA automatically generates its implementation at runtime, so developers only define the interface.

---

### 3. What is the difference between Repository and DAO?

A Repository is a higher-level abstraction provided by Spring Data JPA, while a DAO is a traditional design pattern where developers manually implement database operations.

---

### 4. Can Spring Data JPA generate queries automatically?

Yes. It can generate SQL queries based on repository method names like:

```java
findByDepartment(String department)
```

---

### 5. Does a Repository communicate directly with the database?

No. The Repository communicates with **Hibernate (JPA implementation)**, which generates SQL and interacts with the database.

---

# Quick Revision

- A **Repository** acts as a bridge between the application and the database.
- It provides built-in CRUD operations.
- Spring automatically creates repository implementations.
- Repository interfaces usually extend `JpaRepository` or `CrudRepository`.
- It supports derived query methods, pagination, sorting, and custom queries.
- Keep repositories responsible only for data access.