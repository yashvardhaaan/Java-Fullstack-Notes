# Many-to-One Relationship (`@ManyToOne`)

## What is a Many-to-One Relationship?

A **Many-to-One (N:1)** relationship means **multiple records in one table are associated with a single record in another table**.

In Spring Data JPA, this relationship is created using the `@ManyToOne` annotation.

> **In simple words:**
>
> Many objects can belong to one parent object.

---

# Why Do We Need a Many-to-One Relationship?

Suppose a company has many employees.

Instead of storing department information repeatedly in every employee record, we create a separate Department table and link employees to it.

This:

- Reduces duplicate data
- Improves database normalization
- Makes updates easier

---

# Real-World Examples

### Employees → Department

```
Employees

↓

Department
```

Many employees belong to one department.

---

### Orders → Customer

```
Orders

↓

Customer
```

Many orders belong to one customer.

---

### Books → Author

```
Books

↓

Author
```

Many books can be written by one author.

---

# Database Representation

## Department Table

| id | name |
|----|------|
| 1 | IT |
| 2 | HR |

---

## Employee Table

| id | name | department_id |
|----|------|---------------|
| 10 | John | 1 |
| 11 | Alice | 1 |
| 12 | Bob | 2 |

The `department_id` column is the **foreign key**.

---

# How Many-to-One Works

```
Employees

N -------- 1

Department
```

Many employees reference the same department.

---

# Entity Example

## Department Entity

```java
@Entity
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

}
```

---

## Employee Entity

```java
@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

}
```

---

# Understanding `@JoinColumn`

```java
@JoinColumn(name = "department_id")
```

This tells Hibernate:

- Create a foreign key column named `department_id`.
- Store the referenced department ID in this column.

Generated SQL

```sql
ALTER TABLE employee

ADD COLUMN department_id BIGINT;
```

---

# Owning Side

The `@ManyToOne` side is **always the owning side** because it contains the foreign key.

```
Employee

↓

@ManyToOne

↓

@JoinColumn

↓

Foreign Key

↓

Department
```

The owning side is responsible for updating the relationship in the database.

---

# Bidirectional Relationship

Department Entity

```java
@Entity
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToMany(mappedBy = "department")
    private List<Employee> employees;

}
```

---

Employee Entity

```java
@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

}
```

---

# Saving Data

```java
Department department = new Department();
department.setName("IT");

Employee employee = new Employee();
employee.setName("John");
employee.setDepartment(department);

departmentRepository.save(department);
employeeRepository.save(employee);
```

---

# Generated SQL

```sql
INSERT INTO department(name)
VALUES ('IT');
```

```sql
INSERT INTO employee
(name, department_id)
VALUES
('John', 1);
```

---

# Fetch Type

The default fetch type for `@ManyToOne` is:

```java
FetchType.EAGER
```

Meaning:

```
Load Employee

↓

Automatically Load Department
```

To improve performance for large applications:

```java
@ManyToOne(fetch = FetchType.LAZY)
```

Now the department is loaded only when needed.

---

# Cascade Operations

```java
@ManyToOne(
        cascade = CascadeType.PERSIST
)
@JoinColumn(name = "department_id")
private Department department;
```

Common cascade types:

- `PERSIST`
- `MERGE`
- `REMOVE`
- `REFRESH`
- `DETACH`
- `ALL`

> **Note:** Avoid using `CascadeType.REMOVE` on `@ManyToOne` because deleting one employee should not delete the shared department.

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

Employee Table

↓

Department Table
```

---

# Database Structure

```
Department
+----+------+
| id | name |
+----+------+
| 1  | IT   |
| 2  | HR   |
+----+------+

Employee
+----+-------+---------------+
| id | name  | department_id |
+----+-------+---------------+
|10  | John  | 1             |
|11  | Alice | 1             |
|12  | Bob   | 2             |
+----+-------+---------------+
```

---

# Many-to-One vs One-to-One

| Many-to-One | One-to-One |
|--------------|------------|
| Many children share one parent | One child belongs to one parent |
| Foreign key may appear in many rows | Foreign key is unique |
| Example: Employee → Department | Example: User → Profile |

---

# Many-to-One vs One-to-Many

| Many-to-One | One-to-Many |
|--------------|-------------|
| Child references parent | Parent contains collection of children |
| Owning side | Inverse side (usually) |
| Stores foreign key | Does not store foreign key |

---

# Real-World Example

### Banking Application

```
Accounts

↓

Customer
```

Many bank accounts belong to one customer.

---

### E-Commerce Application

```
Orders

↓

Customer
```

Many orders belong to one customer.

---

### University Management System

```
Students

↓

Department
```

Many students belong to one department.

---

# Advantages

- Eliminates duplicate data
- Maintains referential integrity
- Represents real-world relationships
- Easy to query parent information
- Automatically managed by Hibernate

---

# Best Practices

- Use `@JoinColumn` to define the foreign key.
- Prefer `FetchType.LAZY` in production unless eager loading is necessary.
- Avoid `CascadeType.REMOVE` on `@ManyToOne`.
- Keep the parent entity independent of child lifecycle unless required.
- Use DTOs for REST APIs to avoid unnecessary entity loading.

---

# Interview Questions

### 1. What is a Many-to-One relationship?

A Many-to-One relationship means multiple child entities are associated with a single parent entity.

---

### 2. Which annotation is used?

```java
@ManyToOne
```

---

### 3. Which side owns the relationship?

The `@ManyToOne` side owns the relationship because it contains the foreign key using `@JoinColumn`.

---

### 4. What is the default fetch type for `@ManyToOne`?

```java
FetchType.EAGER
```

---

### 5. Why should `CascadeType.REMOVE` generally be avoided on `@ManyToOne`?

Because multiple child entities may reference the same parent. Deleting one child should not delete the shared parent.

---

# Quick Revision

- `@ManyToOne` represents many child entities linked to one parent entity.
- The foreign key is stored in the child table.
- Use `@JoinColumn` to define the foreign key.
- The `@ManyToOne` side is the owning side.
- Default fetch type is `EAGER`.
- Prefer `FetchType.LAZY` for better performance in production.
- Avoid `CascadeType.REMOVE` on shared parent entities.