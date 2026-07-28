# Specifications

## What are Specifications?

**Specifications** are a feature of Spring Data JPA that allows you to build **dynamic and reusable database queries** programmatically.

Instead of writing multiple query methods or complex JPQL, you can create query conditions dynamically based on user input.

> **In simple words:**
>
> Specifications allow you to build SQL queries dynamically at runtime.

---

# Why Do We Need Specifications?

Suppose an Employee Search page has filters like:

- Department
- Salary
- Experience
- City

Without Specifications, you may create many repository methods:

```java
findByDepartment()

findBySalaryGreaterThan()

findByDepartmentAndSalaryGreaterThan()

findByDepartmentAndCity()

findByDepartmentAndSalaryGreaterThanAndCity()
```

As filters increase, the number of methods grows rapidly.

With Specifications:

```java
searchEmployees(
    department,
    salary,
    city
);
```

Only one dynamic query is required.

---

# Real-World Example

Imagine an Amazon search page.

Filters:

- Brand
- Price
- Rating
- Category
- Availability

Users can select any combination of filters.

Specifications generate the required query dynamically.

---

# How Specifications Work

```
Client Filters

↓

Specification

↓

Criteria API

↓

Hibernate

↓

SQL

↓

Database
```

---

# Prerequisites

Your repository must extend `JpaSpecificationExecutor`.

```java
public interface EmployeeRepository
        extends JpaRepository<Employee, Long>,
                JpaSpecificationExecutor<Employee> {

}
```

Now the repository supports Specifications.

---

# Creating a Specification

```java
public class EmployeeSpecification {

    public static Specification<Employee>
    hasDepartment(String department) {

        return (root, query, builder) ->

                builder.equal(
                        root.get("department"),
                        department
                );
    }

}
```

---

# Using the Specification

```java
List<Employee> employees =

repository.findAll(

    EmployeeSpecification
        .hasDepartment("IT")

);
```

Generated SQL

```sql
SELECT *
FROM employee
WHERE department = 'IT';
```

---

# Salary Specification

```java
public static Specification<Employee>
salaryGreaterThan(double salary) {

    return (root, query, builder) ->

            builder.greaterThan(
                    root.get("salary"),
                    salary
            );
}
```

Usage

```java
repository.findAll(

    EmployeeSpecification
        .salaryGreaterThan(50000)

);
```

---

# City Specification

```java
public static Specification<Employee>
hasCity(String city) {

    return (root, query, builder) ->

            builder.equal(
                    root.get("city"),
                    city
            );
}
```

---

# Combining Specifications

Department AND Salary

```java
Specification<Employee> specification =

Specification

.where(

EmployeeSpecification.hasDepartment("IT")

)

.and(

EmployeeSpecification.salaryGreaterThan(50000)

);
```

Usage

```java
repository.findAll(specification);
```

Generated SQL

```sql
SELECT *
FROM employee
WHERE department='IT'
AND salary > 50000;
```

---

# OR Condition

```java
Specification<Employee> specification =

Specification

.where(

EmployeeSpecification.hasDepartment("IT")

)

.or(

EmployeeSpecification.hasDepartment("HR")

);
```

Generated SQL

```sql
WHERE department='IT'

OR department='HR'
```

---

# LIKE Query

```java
public static Specification<Employee>
nameContains(String keyword) {

    return (root, query, builder) ->

            builder.like(

                    root.get("name"),

                    "%" + keyword + "%"

            );
}
```

Usage

```java
repository.findAll(

EmployeeSpecification
    .nameContains("John")

);
```

---

# Greater Than

```java
builder.greaterThan(
        root.get("salary"),
        60000
);
```

---

# Less Than

```java
builder.lessThan(
        root.get("salary"),
        50000
);
```

---

# Between

```java
builder.between(

        root.get("salary"),

        50000,

        100000
);
```

---

# IN Query

```java
root.get("department")
    .in(List.of("IT", "HR"));
```

---

# Complete Example

```java
Specification<Employee> specification =

Specification

.where(

EmployeeSpecification.hasDepartment("IT")

)

.and(

EmployeeSpecification.salaryGreaterThan(50000)

)

.and(

EmployeeSpecification.hasCity("Pune")

);

List<Employee> employees =

repository.findAll(specification);
```

---

# REST API Example

```java
@GetMapping("/employees")
public List<Employee> search(

        @RequestParam String department,

        @RequestParam double salary

) {

    Specification<Employee> specification =

            Specification

            .where(
                EmployeeSpecification
                    .hasDepartment(department)
            )

            .and(
                EmployeeSpecification
                    .salaryGreaterThan(salary)
            );

    return repository.findAll(specification);
}
```

Request

```
GET /employees?department=IT&salary=50000
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

Specification

↓

Criteria API

↓

Hibernate

↓

SQL

↓

Database
```

---

# Specification vs JPQL

| Specification | JPQL |
|--------------|------|
| Dynamic Queries | Static Queries |
| Programmatic | String-Based |
| Easy to Combine | Harder for Many Conditions |
| Best for Search Filters | Best for Fixed Queries |

---

# Specification vs Derived Query

| Specification | Derived Query |
|--------------|---------------|
| Dynamic | Static |
| Handles Multiple Filters | Many Methods Needed |
| Reusable | Less Flexible |

---

# Common CriteriaBuilder Methods

| Method | Purpose |
|---------|---------|
| `equal()` | Equals |
| `notEqual()` | Not Equals |
| `greaterThan()` | Greater Than |
| `lessThan()` | Less Than |
| `between()` | Between Values |
| `like()` | LIKE Query |
| `and()` | AND Condition |
| `or()` | OR Condition |
| `in()` | IN Clause |

---

# Real-World Example

### Banking Application

Search accounts by:

- Branch
- Balance
- Account Type
- Status

Any combination of filters can be applied dynamically using Specifications.

---

### E-Commerce Application

Search products by:

- Category
- Price
- Brand
- Rating
- Availability

Instead of writing dozens of repository methods, Specifications generate the required query dynamically.

---

# Advantages

- Dynamic query generation
- Reusable query conditions
- Easy to combine filters
- Type-safe using Criteria API
- Reduces duplicate repository methods
- Ideal for search and filtering features

---

# Best Practices

- Use Specifications for dynamic search screens.
- Keep each Specification focused on a single condition.
- Combine Specifications using `and()` and `or()`.
- Place Specification classes in a separate package (e.g., `specification`).
- Use derived queries or JPQL for simple, fixed queries.

---

# Interview Questions

### 1. What are Specifications in Spring Data JPA?

Specifications are a way to create dynamic and reusable database queries using the JPA Criteria API.

---

### 2. Which interface enables Specification support?

```java
JpaSpecificationExecutor<T>
```

---

### 3. Why are Specifications preferred for search filters?

Because they allow dynamic query creation based on user-selected filters without creating many repository methods.

---

### 4. Can multiple Specifications be combined?

Yes.

```java
Specification.where(spec1)
             .and(spec2)
             .or(spec3);
```

---

### 5. What is the role of `CriteriaBuilder`?

`CriteriaBuilder` provides methods such as `equal()`, `like()`, `greaterThan()`, and `between()` to build query conditions programmatically.

---

# Quick Revision

- Specifications create **dynamic database queries**.
- They are built using the **JPA Criteria API**.
- Repository must extend `JpaSpecificationExecutor`.
- Combine conditions using `and()` and `or()`.
- Use Specifications for complex search and filtering functionality.
- Prefer Specifications over multiple repository methods when queries are dynamic.