# Comparable

## What is Comparable?

**Comparable** is an interface in Java that is used to define the **natural ordering** of objects.

It is present in the

```text
java.lang
```

package.

When a class implements Comparable, it must override the

```java
compareTo()
```

method.

> **Definition:** Comparable is an interface that allows objects of a class to be compared and sorted in their natural order.

---

# Why Do We Need Comparable?

Suppose we have a list of employees.

```text
Rahul

Amit

Priya
```

How should Java sort them?

- By ID?
- By Name?
- By Salary?

Java doesn't know.

We tell Java the default sorting rule by implementing Comparable.

---

# Real-World Example

Imagine students are ranked based on marks.

```text
95

82

70

60
```

Sorting happens naturally from lowest to highest.

Comparable defines this natural ordering.

---

# Interface Declaration

```java
public interface Comparable<T> {

    int compareTo(T o);

}
```

---

# Return Values of compareTo()

| Return Value | Meaning |
|--------------|---------|
| Negative | Current object is smaller |
| Zero | Objects are equal |
| Positive | Current object is greater |

---

# Creating a Comparable Class

```java
class Employee implements Comparable<Employee> {

    int id;

    Employee(int id) {

        this.id = id;

    }

    @Override
    public int compareTo(Employee other) {

        return this.id - other.id;

    }

}
```

Now Java knows how to compare Employee objects.

---

# Sorting Objects

```java
List<Employee> employees = new ArrayList<>();

employees.add(new Employee(103));

employees.add(new Employee(101));

employees.add(new Employee(102));

Collections.sort(employees);
```

Output

```text
101

102

103
```

---

# Sorting Strings

```java
List<String> names = new ArrayList<>();

names.add("Rahul");

names.add("Amit");

names.add("Priya");

Collections.sort(names);
```

Output

```text
Amit

Priya

Rahul
```

`String` already implements Comparable.

---

# Sorting Numbers

```java
List<Integer> numbers = new ArrayList<>();

numbers.add(50);

numbers.add(10);

numbers.add(30);

Collections.sort(numbers);
```

Output

```text
10

30

50
```

`Integer` also implements Comparable.

---

# Sorting by Name

```java
class Employee implements Comparable<Employee> {

    String name;

    Employee(String name) {

        this.name = name;

    }

    @Override
    public int compareTo(Employee other) {

        return this.name.compareTo(other.name);

    }

}
```

Output

```text
Amit

Priya

Rahul
```

---

# Descending Order

```java
@Override
public int compareTo(Employee other) {

    return other.id - this.id;

}
```

Output

```text
103

102

101
```

---

# Internal Working

Suppose

```java
Collections.sort(employees);
```

Internally

```text
Collections.sort()

↓

compareTo()

↓

Compare Objects

↓

Swap

↓

Sorted List
```

The sorting algorithm repeatedly calls `compareTo()` to determine the order of objects.

---

# Comparable with TreeSet

```java
TreeSet<Employee> employees =
        new TreeSet<>();
```

Whenever a new object is added,

```text
Insert

↓

compareTo()

↓

Find Position

↓

Store Object
```

TreeSet uses `compareTo()` to maintain sorted order.

---

# Comparable with TreeMap

```java
TreeMap<Employee, String> map =
        new TreeMap<>();
```

Keys are sorted using `compareTo()`.

---

# Time Complexity

Sorting

```java
Collections.sort(list);
```

uses TimSort.

| Operation | Complexity |
|------------|------------|
| Sorting | O(n log n) |
| compareTo() | O(1) (usually) |

---

# Comparable vs Comparator

| Comparable | Comparator |
|------------|------------|
| Package: java.lang | Package: java.util |
| Natural ordering | Custom ordering |
| compareTo() | compare() |
| One sorting rule | Multiple sorting rules |
| Class modified | Separate class/object |

---

# Production Usage

Comparable is commonly used in

- Student rankings
- Employee IDs
- Product IDs
- Banking transactions
- TreeSet
- TreeMap
- Default sorting

Example

```java
Collections.sort(employees);
```

---

# Advantages

- Simple to implement
- Natural ordering
- Works with Collections.sort()
- Used automatically by TreeSet and TreeMap
- No extra Comparator object needed

---

# Limitations

- Only one natural ordering
- Requires modifying the class
- Not suitable for multiple sorting rules

---

# Best Practices

✅ Use Comparable for the default sorting order.

---

✅ Keep `compareTo()` consistent with `equals()` whenever possible.

---

✅ Use `Integer.compare()` instead of subtraction for numeric comparisons to avoid integer overflow.

```java
@Override
public int compareTo(Employee other) {

    return Integer.compare(this.id, other.id);

}
```

---

# Common Mistakes

❌ Returning

```java
return this.id - other.id;
```

This can overflow for very large integers.

Prefer

```java
return Integer.compare(this.id, other.id);
```

---

❌ Forgetting to implement Comparable before storing custom objects in TreeSet.

May throw

```text
ClassCastException
```

---

❌ Using Comparable when multiple sorting criteria are needed.

Use Comparator instead.

---

# Interview Questions

### 1. What is Comparable?

Comparable is an interface that defines the natural ordering of objects.

---

### 2. Which package contains Comparable?

```text
java.lang
```

---

### 3. Which method must be implemented?

```java
compareTo()
```

---

### 4. What are the return values of compareTo()?

- Negative → Smaller
- Zero → Equal
- Positive → Greater

---

### 5. Which classes already implement Comparable?

- String
- Integer
- Double
- Character
- LocalDate
- Many other Java built-in classes

---

### 6. Which collection classes use Comparable?

- TreeSet
- TreeMap
- Collections.sort()
- Arrays.sort()

---

### 7. Can Comparable provide multiple sorting rules?

No.

It defines only one natural ordering.

---

### 8. Which sorting algorithm does Collections.sort() use?

TimSort.

---

### 9. Why should Integer.compare() be preferred over subtraction?

It avoids integer overflow.

---

### 10. When should Comparable be used?

When a class has one default or natural sorting order.

---

# Quick Revision

- Comparable is in `java.lang`.
- Defines natural ordering.
- Requires `compareTo()`.
- Used by:
  - Collections.sort()
  - Arrays.sort()
  - TreeSet
  - TreeMap
- One sorting rule.
- Prefer `Integer.compare()` for numeric comparisons.
- Sorting complexity: **O(n log n)**.

---

# Keywords

- Comparable
- compareTo()
- Natural Ordering
- Collections.sort()
- TreeSet
- TreeMap
- TimSort
- Integer.compare()
- java.lang
- O(n log n)