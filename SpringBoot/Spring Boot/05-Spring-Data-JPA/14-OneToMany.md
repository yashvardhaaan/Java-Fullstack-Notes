# One-to-Many Relationship (`@OneToMany`)

## What is a One-to-Many Relationship?

A **One-to-Many (1:N)** relationship means **one record in one table is associated with multiple records in another table**.

In Spring Data JPA, this relationship is created using the `@OneToMany` annotation.

> **In simple words:**
>
> One object can own multiple objects.

---

# Why Do We Need a One-to-Many Relationship?

Suppose a company has multiple employees.

Instead of storing employee information inside the company table, we create separate tables and connect them.

This:

- Avoids duplicate data
- Maintains normalization
- Makes data easier to manage

---

# Real-World Examples

### Department → Employees

```
Department

↓

Employees
```

One department has many employees.

---

### Customer → Orders

```
Customer

↓

Orders
```

One customer can place many orders.

---

### Blog → Comments

```
Blog

↓

Comments
```

One blog post can have many comments.

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

`department_id` is the foreign key.

---

# How One-to-Many Works

```
Department

1 -------- N

Employees
```

One department contains many employees.

Each employee belongs to one department.

---

# Bidirectional One-to-Many (Recommended)

## Department Entity

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

# Why `mappedBy`?

```java
@OneToMany(mappedBy = "department")
```

`mappedBy` tells Hibernate:

- Employee owns the relationship.
- Department only references it.
- Do not create another foreign key.

---

# Owning Side vs Inverse Side

```
Department

↓

@OneToMany
(mappedBy)

↓

Employee

↓

@JoinColumn

↓

Foreign Key
```

- **Owning Side** → Employee (`@ManyToOne`)
- **Inverse Side** → Department (`@OneToMany(mappedBy = ...)`)

Only the owning side updates the foreign key.

---

# Unidirectional One-to-Many

```java
@OneToMany
@JoinColumn(name = "department_id")
private List<Employee> employees;
```

Although supported, this approach is **less common** because it may generate unnecessary SQL operations.

Most real-world applications prefer the bidirectional mapping.

---

# Cascade Operations

```java
@OneToMany(
        mappedBy = "department",
        cascade = CascadeType.ALL
)
private List<Employee> employees;
```

Now saving the department also saves all employees.

```java
departmentRepository.save(department);
```

---

# Fetch Type

Default fetch type for `@OneToMany` is:

```java
FetchType.LAZY
```

Meaning:

```
Load Department

↓

Employees are NOT loaded immediately
```

Employees are fetched only when accessed.

Example

```java
department.getEmployees();
```

---

# Saving Data

```java
Department department = new Department();
department.setName("IT");

Employee e1 = new Employee();
e1.setName("John");
e1.setDepartment(department);

Employee e2 = new Employee();
e2.setName("Alice");
e2.setDepartment(department);

department.setEmployees(
        List.of(e1, e2)
);

departmentRepository.save(department);
```

---

# Generated SQL

```sql
INSERT INTO department(name)
VALUES ('IT');
```

```sql
INSERT INTO employee(name, department_id)
VALUES ('John', 1);
```

```sql
INSERT INTO employee(name, department_id)
VALUES ('Alice', 1);
```

---

# Removing an Employee

```java
department.getEmployees().remove(employee);
```

To automatically delete the removed employee from the database:

```java
@OneToMany(
        mappedBy = "department",
        orphanRemoval = true
)
```

`orphanRemoval = true` deletes child records that are no longer associated with the parent.

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

Department

↓

Employees
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

# One-to-Many vs Many-to-One

| One-to-Many | Many-to-One |
|--------------|-------------|
| One parent has many children | Many children belong to one parent |
| Parent holds a collection | Child holds one parent reference |
| Example: Department → Employees | Example: Employee → Department |

---

# Real-World Example

### Banking Application

```
Customer

↓

Accounts
```

One customer owns multiple bank accounts.

---

### E-Commerce Application

```
Order

↓

Order Items
```

One order contains multiple order items.

---

### University System

```
Teacher

↓

Students
```

One teacher teaches many students.

---

# Advantages

- Represents real-world parent-child relationships
- Reduces duplicate data
- Supports cascading operations
- Easy to retrieve child records
- Managed automatically by Hibernate

---

# Best Practices

- Prefer bidirectional mapping when both entities need access to each other.
- The `@ManyToOne` side should own the relationship.
- Keep `@OneToMany` collections `LAZY` loaded.
- Use `orphanRemoval = true` when child records should be deleted after removal.
- Use DTOs in REST APIs to avoid infinite JSON recursion.

---

# Interview Questions

### 1. What is a One-to-Many relationship?

A One-to-Many relationship means one parent entity is associated with multiple child entities.

---

### 2. Which annotation is used?

```java
@OneToMany
```

---

### 3. What is the default fetch type for `@OneToMany`?

```java
FetchType.LAZY
```

---

### 4. Which side owns the relationship?

The `@ManyToOne` side (child entity) owns the relationship because it contains the foreign key using `@JoinColumn`.

---

### 5. What does `orphanRemoval = true` do?

It automatically deletes child entities from the database when they are removed from the parent's collection.

---

# Quick Revision

- `@OneToMany` represents one parent with many child entities.
- The foreign key is stored on the `@ManyToOne` side.
- Use `mappedBy` to define the inverse side.
- Default fetch type is `LAZY`.
- Use `CascadeType.ALL` for cascading operations.
- Use `orphanRemoval = true` to automatically delete orphan child records.
- Prefer bidirectional mapping for most production applications.