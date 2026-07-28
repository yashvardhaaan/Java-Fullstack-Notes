# Cascade Types (`CascadeType`)

## What is Cascade Type?

**Cascade Type** determines **whether an operation performed on a parent entity should automatically be applied to its related child entities**.

For example:

- Save a Department
- Automatically save all Employees

Instead of saving every entity individually, Hibernate performs the operation automatically.

> **In simple words:**
>
> Cascade tells Hibernate to perform the same operation on related entities.

---

# Why Do We Need Cascade Types?

Suppose a Department has multiple Employees.

Without Cascade:

```java
departmentRepository.save(department);

employeeRepository.save(employee1);

employeeRepository.save(employee2);
```

You must save each entity separately.

With Cascade:

```java
departmentRepository.save(department);
```

Hibernate automatically saves all related employees.

---

# How Cascade Works

```
Department

↓

Save

↓

Hibernate

↓

Employees

↓

Database
```

The operation propagates from the parent to its children.

---

# Types of Cascade

| Cascade Type | Purpose |
|--------------|---------|
| `PERSIST` | Save child entities |
| `MERGE` | Update child entities |
| `REMOVE` | Delete child entities |
| `REFRESH` | Refresh child entities |
| `DETACH` | Detach child entities |
| `ALL` | Apply all cascade operations |

---

# CascadeType.PERSIST

When the parent is saved, all child entities are saved automatically.

Example

```java
@OneToMany(
        mappedBy = "department",
        cascade = CascadeType.PERSIST
)
private List<Employee> employees;
```

---

## Saving Data

```java
Department department = new Department();
department.setName("IT");

Employee employee = new Employee();
employee.setName("John");

employee.setDepartment(department);

department.setEmployees(
        List.of(employee)
);

departmentRepository.save(department);
```

Generated SQL

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

# CascadeType.MERGE

When the parent entity is updated, the child entities are also updated.

Example

```java
@OneToMany(
        mappedBy = "department",
        cascade = CascadeType.MERGE
)
private List<Employee> employees;
```

Update

```java
department.setName("Engineering");

employee.setName("Alice");

departmentRepository.save(department);
```

Both entities are updated.

---

# CascadeType.REMOVE

Deleting the parent automatically deletes all child entities.

Example

```java
@OneToMany(
        mappedBy = "department",
        cascade = CascadeType.REMOVE
)
private List<Employee> employees;
```

Delete

```java
departmentRepository.delete(department);
```

Generated SQL

```sql
DELETE FROM employee;

DELETE FROM department;
```

---

# CascadeType.REFRESH

Reloads both parent and child entities from the database.

Example

```java
@OneToMany(
        cascade = CascadeType.REFRESH
)
private List<Employee> employees;
```

Usage

```java
entityManager.refresh(department);
```

Hibernate discards local changes and reloads the latest values from the database.

---

# CascadeType.DETACH

Removes both parent and child entities from the persistence context.

Example

```java
@OneToMany(
        cascade = CascadeType.DETACH
)
private List<Employee> employees;
```

Usage

```java
entityManager.detach(department);
```

Now Hibernate no longer tracks changes to the department or its employees.

---

# CascadeType.ALL

Applies every cascade operation.

```java
@OneToMany(

        mappedBy = "department",

        cascade = CascadeType.ALL

)
private List<Employee> employees;
```

Equivalent to

```java
cascade = {

    CascadeType.PERSIST,

    CascadeType.MERGE,

    CascadeType.REMOVE,

    CascadeType.REFRESH,

    CascadeType.DETACH

}
```

---

# Request Flow

```
Parent Entity

↓

Operation

↓

Cascade

↓

Child Entities

↓

Hibernate

↓

Database
```

---

# Example with One-to-One

```java
@OneToOne(

        cascade = CascadeType.ALL

)
@JoinColumn(name = "passport_id")
private Passport passport;
```

Saving the Person automatically saves the Passport.

---

# Example with Many-to-One

```java
@ManyToOne(
        cascade = CascadeType.PERSIST
)
@JoinColumn(name = "department_id")
private Department department;
```

> **Note:** Be careful when using cascade with `@ManyToOne`, because multiple child entities may share the same parent.

---

# Cascade vs orphanRemoval

## Cascade REMOVE

```java
cascade = CascadeType.REMOVE
```

Deletes child entities **when the parent entity is deleted**.

---

## orphanRemoval

```java
@OneToMany(
        orphanRemoval = true
)
```

Deletes a child entity **when it is removed from the parent's collection**, even if the parent still exists.

Example

```java
department.getEmployees().remove(employee);
```

The removed employee is deleted from the database.

---

# CascadeType.ALL vs Individual Cascade Types

| `CascadeType.ALL` | Individual Types |
|-------------------|------------------|
| Applies all operations | Applies selected operations |
| Easier to configure | More control |
| May cascade unwanted operations | Safer in complex applications |

---

# Cascade vs Fetch Type

| Cascade | Fetch |
|----------|-------|
| Controls operations | Controls loading |
| Save, Update, Delete | Load related entities |
| Uses `CascadeType` | Uses `FetchType` |

---

# Real-World Example

### Banking Application

```
Customer

↓

Accounts
```

Saving a new customer automatically saves all newly created accounts.

---

### E-Commerce Application

```
Order

↓

Order Items
```

Deleting an order automatically deletes its associated order items.

---

### Hospital System

```
Patient

↓

Medical Records
```

Saving a patient automatically saves the related medical records.

---

# Advantages

- Reduces boilerplate code
- Automatically manages related entities
- Maintains data consistency
- Simplifies parent-child operations
- Reduces manual repository calls

---

# Best Practices

- Use `CascadeType.PERSIST` when child entities should be saved with the parent.
- Use `CascadeType.MERGE` for synchronized updates.
- Use `CascadeType.REMOVE` only when child entities should not exist without the parent.
- Avoid `CascadeType.REMOVE` on `@ManyToOne` because the parent may be shared.
- Use `CascadeType.ALL` only when the child's lifecycle is completely dependent on the parent.
- Use `orphanRemoval = true` for true parent-child ownership.

---

# Interview Questions

### 1. What is Cascade Type?

Cascade Type determines whether operations performed on a parent entity are automatically propagated to its related child entities.

---

### 2. What are the different Cascade Types?

- `PERSIST`
- `MERGE`
- `REMOVE`
- `REFRESH`
- `DETACH`
- `ALL`

---

### 3. What does `CascadeType.ALL` do?

It applies all cascade operations (`PERSIST`, `MERGE`, `REMOVE`, `REFRESH`, and `DETACH`) to related entities.

---

### 4. What is the difference between `CascadeType.REMOVE` and `orphanRemoval`?

- `CascadeType.REMOVE` deletes child entities when the **parent is deleted**.
- `orphanRemoval` deletes a child entity when it is **removed from the parent's collection**, even if the parent still exists.

---

### 5. What is the difference between Cascade Type and Fetch Type?

- **Cascade Type** controls operations such as save, update, and delete.
- **Fetch Type** controls when related entities are loaded from the database.

---

# Quick Revision

- Cascade Types propagate operations from parent entities to child entities.
- Available types are `PERSIST`, `MERGE`, `REMOVE`, `REFRESH`, `DETACH`, and `ALL`.
- `CascadeType.ALL` includes all cascade operations.
- `CascadeType.REMOVE` deletes children when the parent is deleted.
- `orphanRemoval` deletes children removed from the parent's collection.
- Cascade Type manages **operations**, while Fetch Type manages **loading**.
- Use cascade carefully, especially with shared entities like `@ManyToOne`.