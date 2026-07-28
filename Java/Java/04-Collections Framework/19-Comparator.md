# Comparator

## What is Comparator?

**Comparator** is an interface in Java that is used to define **custom sorting** for objects.

It is present in the

```text
java.util
```

package.

Unlike `Comparable`, a Comparator is **external to the class**, so you don't need to modify the original class.

> **Definition:** Comparator is an interface that provides custom sorting rules for objects using the `compare()` method.

---

# Why Do We Need Comparator?

Suppose we have Employee objects.

```text
ID    Name    Salary

101   Rahul   70000

102   Amit    50000

103   Priya   90000
```

We may want to sort by

- ID
- Name
- Salary

One class cannot have multiple `compareTo()` methods.

Comparator solves this problem.

---

# Real-World Example

Imagine a student database.

Sometimes you sort students by

```text
Name
```

Sometimes by

```text
Marks
```

Sometimes by

```text
Roll Number
```

Comparator allows different sorting rules without changing the Student class.

---

# Interface Declaration

```java
public interface Comparator<T> {

    int compare(T o1, T o2);

}
```

---

# Return Values of compare()

| Return Value | Meaning |
|--------------|---------|
| Negative | First object is smaller |
| Zero | Both objects are equal |
| Positive | First object is greater |

---

# Employee Class

```java
class Employee {

    int id;

    String name;

    int salary;

    Employee(int id, String name, int salary){

        this.id = id;

        this.name = name;

        this.salary = salary;

    }

}
```

---

# Sorting by ID

```java
Comparator<Employee> idComparator =
        (e1, e2) ->
            Integer.compare(e1.id, e2.id);

Collections.sort(employees, idComparator);
```

Output

```text
101

102

103
```

---

# Sorting by Name

```java
Comparator<Employee> nameComparator =
        (e1, e2) ->
            e1.name.compareTo(e2.name);

Collections.sort(employees, nameComparator);
```

Output

```text
Amit

Priya

Rahul
```

---

# Sorting by Salary

```java
Comparator<Employee> salaryComparator =
        (e1, e2) ->
            Integer.compare(e1.salary, e2.salary);

Collections.sort(employees, salaryComparator);
```

Output

```text
50000

70000

90000
```

---

# Descending Order

```java
Comparator<Employee> salaryComparator =
        (e1, e2) ->
            Integer.compare(e2.salary, e1.salary);
```

Output

```text
90000

70000

50000
```

---

# Using Anonymous Class

```java
Collections.sort(employees,
    new Comparator<Employee>() {

        @Override
        public int compare(Employee e1, Employee e2) {

            return Integer.compare(e1.id, e2.id);

        }

    });
```

---

# Using Lambda Expression

```java
Collections.sort(
    employees,
    (e1, e2) ->
        Integer.compare(e1.salary, e2.salary)
);
```

This is the preferred approach in Java 8+.

---

# Using Comparator Utility Methods

### comparing()

```java
employees.sort(
    Comparator.comparing(Employee::getName)
);
```

---

### comparingInt()

```java
employees.sort(
    Comparator.comparingInt(Employee::getSalary)
);
```

---

### reversed()

```java
employees.sort(
    Comparator.comparingInt(Employee::getSalary)
              .reversed()
);
```

---

### thenComparing()

Sort by salary, then by name.

```java
employees.sort(

    Comparator
        .comparingInt(Employee::getSalary)
        .thenComparing(Employee::getName)

);
```

---

# Internal Working

Suppose

```java
Collections.sort(employees, salaryComparator);
```

Internally

```text
Collections.sort()

↓

Comparator.compare()

↓

Compare Objects

↓

Swap

↓

Sorted List
```

The sorting algorithm repeatedly calls `compare()`.

---

# Comparator with TreeSet

```java
TreeSet<Employee> employees =
        new TreeSet<>(salaryComparator);
```

Internally

```text
Insert

↓

Comparator.compare()

↓

Find Position

↓

Store Object
```

---

# Comparator with TreeMap

```java
TreeMap<Employee, String> map =
        new TreeMap<>(salaryComparator);
```

Keys are sorted using the provided Comparator.

---

# Time Complexity

Sorting

```java
Collections.sort(list, comparator);
```

uses TimSort.

| Operation | Complexity |
|------------|------------|
| Sorting | O(n log n) |
| compare() | O(1) (usually) |

---

# Comparable vs Comparator

| Comparable | Comparator |
|------------|------------|
| Package: java.lang | Package: java.util |
| compareTo() | compare() |
| Natural ordering | Custom ordering |
| One sorting rule | Multiple sorting rules |
| Modify class | Separate object/class |

---

# Production Usage

Comparator is widely used in

- Employee management
- Student records
- E-commerce product sorting
- Banking applications
- Search results
- Leaderboards
- TreeSet
- TreeMap

Example

```java
employees.sort(
    Comparator.comparing(Employee::getSalary)
);
```

---

# Advantages

- Multiple sorting rules
- No need to modify the original class
- Reusable
- Supports lambda expressions
- Supports method references

---

# Limitations

- Slightly more code than Comparable
- Requires a Comparator object
- Can become complex for many sorting conditions

---

# Best Practices

✅ Use Comparator when multiple sorting criteria are required.

---

✅ Use lambda expressions in Java 8+.

---

✅ Use `Comparator.comparing()` for better readability.

---

✅ Chain multiple conditions using `thenComparing()`.

---

# Common Mistakes

❌ Using Comparable when different sorting rules are required.

Use Comparator instead.

---

❌ Returning

```java
return e1.salary - e2.salary;
```

Prefer

```java
return Integer.compare(e1.salary, e2.salary);
```

to avoid integer overflow.

---

❌ Writing long anonymous classes in Java 8+.

Prefer lambda expressions.

---

# Interview Questions

### 1. What is Comparator?

Comparator is an interface used to define custom sorting rules for objects.

---

### 2. Which package contains Comparator?

```text
java.util
```

---

### 3. Which method must be implemented?

```java
compare()
```

---

### 4. What are the return values of compare()?

- Negative → First object is smaller
- Zero → Objects are equal
- Positive → First object is greater

---

### 5. Can Comparator provide multiple sorting rules?

Yes.

---

### 6. Does Comparator require modifying the original class?

No.

---

### 7. Which classes use Comparator?

- Collections.sort()
- List.sort()
- Arrays.sort()
- TreeSet
- TreeMap

---

### 8. What is the difference between Comparable and Comparator?

Comparable provides one natural ordering, while Comparator provides multiple custom orderings.

---

### 9. Which sorting algorithm does Collections.sort() use?

TimSort.

---

### 10. When should Comparator be used?

When you need multiple or custom sorting rules without modifying the original class.

---

# Quick Revision

- Comparator is in `java.util`.
- Defines custom ordering.
- Requires `compare()`.
- Used by:
  - Collections.sort()
  - List.sort()
  - Arrays.sort()
  - TreeSet
  - TreeMap
- Supports multiple sorting rules.
- Java 8+ provides:
  - comparing()
  - comparingInt()
  - reversed()
  - thenComparing()
- Sorting complexity: **O(n log n)**.

---

# Keywords

- Comparator
- compare()
- Custom Ordering
- Collections.sort()
- List.sort()
- TreeSet
- TreeMap
- Lambda
- Method Reference
- comparing()
- thenComparing()
- reversed()
- java.util
- O(n log n)