# Set Interface

## What is a Set?

A **Set** is an interface in the Java Collections Framework that stores **unique elements**.

Unlike a List, a Set **does not allow duplicate values**.

> **Definition:** A Set is a collection that stores unique elements and prevents duplicate entries.

---

# Why Do We Need a Set?

Suppose you're storing employee IDs.

```text
101

102

103

101
```

Having duplicate IDs is incorrect.

Instead,

```java
Set<Integer> ids =
        new HashSet<>();
```

The duplicate value is automatically ignored.

---

# Real-World Example

Imagine a classroom attendance sheet.

```text
Rahul

Amit

Priya

Rahul
```

A student's name should appear only once.

A Set behaves the same way.

---

# Hierarchy

```text
Iterable
    │
Collection
    │
   Set
    │
 ┌──┼───────────────┐
 │  │               │
HashSet     LinkedHashSet
                    │
                 TreeSet
```

The Set interface has multiple implementations.

---

# Characteristics

- No duplicate elements
- Dynamic size
- No index-based access
- Allows one null value (HashSet and LinkedHashSet)
- Ordering depends on the implementation

---

# Creating a Set

```java
Set<String> set =
        new HashSet<>();
```

Preferred

```java
Set<String> set =
        new HashSet<>();
```

instead of

```java
HashSet<String> set =
        new HashSet<>();
```

---

# Adding Elements

```java
Set<String> set =
        new HashSet<>();

set.add("Java");

set.add("Spring");

set.add("Java");
```

Output

```text
Java

Spring
```

The duplicate `"Java"` is ignored.

---

# Removing Elements

```java
set.remove("Java");
```

---

# Checking an Element

```java
set.contains("Spring");
```

Output

```text
true
```

---

# Size of Set

```java
System.out.println(set.size());
```

Output

```text
1
```

---

# Traversing a Set

### Enhanced For Loop

```java
for(String language : set){

    System.out.println(language);

}
```

---

### Iterator

```java
Iterator<String> itr =
        set.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

---

### Java 8 forEach

```java
set.forEach(System.out::println);
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| add() | Adds an element |
| remove() | Removes an element |
| contains() | Checks element |
| size() | Returns size |
| clear() | Removes all elements |
| isEmpty() | Checks if empty |

---

# Internal Working

Suppose

```java
Set<Integer> set =
        new HashSet<>();

set.add(10);

set.add(20);

set.add(10);
```

Internally

```text
10

↓

20

↓

Duplicate?

↓

Ignored
```

The Set checks whether the element already exists before storing it.

---

# Set Implementations

### HashSet

- Fastest
- No ordering
- Uses Hash Table

---

### LinkedHashSet

- Maintains insertion order
- Slightly slower than HashSet

---

### TreeSet

- Stores elements in sorted order
- Uses Red-Black Tree

---

# List vs Set

| List | Set |
|------|-----|
| Duplicates allowed | No duplicates |
| Ordered | Depends on implementation |
| Index-based | No index |
| Multiple nulls allowed | One null (HashSet/LinkedHashSet), none in TreeSet |

---

# HashSet vs LinkedHashSet vs TreeSet

| Feature | HashSet | LinkedHashSet | TreeSet |
|---------|----------|---------------|----------|
| Ordering | No | Insertion Order | Sorted |
| Duplicate | No | No | No |
| Null | One | One | No |
| Performance | Fastest | Fast | Slower |

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| add() | O(1) Average |
| remove() | O(1) Average |
| contains() | O(1) Average |
| search | O(1) Average |

> **Note:** TreeSet operations are **O(log n)** because it is based on a Red-Black Tree.

---

# Memory Representation

```java
Set<Integer> set =
        new HashSet<>();
```

Memory

```text
Stack

↓

set

↓

Heap

↓

HashSet Object

↓

Hash Table

↓

Elements
```

---

# Production Usage

Sets are commonly used for

- Removing duplicates
- Unique user IDs
- Tags
- Permissions
- Roles
- Email validation
- Caching

Example

```java
Set<String> roles =
        Set.of("ADMIN", "USER");
```

---

# Advantages

- Prevents duplicate elements
- Fast searching
- Dynamic size
- Rich API
- Efficient lookups

---

# Limitations

- No index-based access
- Ordering depends on implementation
- Cannot store duplicate elements

---

# Best Practices

✅ Use `HashSet` when ordering is not important.

---

✅ Use `LinkedHashSet` when insertion order matters.

---

✅ Use `TreeSet` when sorted data is required.

---

✅ Declare variables using the Set interface.

```java
Set<Integer> numbers =
        new HashSet<>();
```

---

# Common Mistakes

❌ Expecting duplicates.

```java
set.add(10);

set.add(10);
```

Only one value is stored.

---

❌ Using Set when index access is needed.

Use a List instead.

---

❌ Assuming HashSet maintains insertion order.

It does not.

---

# Interview Questions

### 1. What is a Set?

A Set is a collection that stores unique elements.

---

### 2. Does Set allow duplicates?

No.

---

### 3. Which interface does Set extend?

`Collection`.

---

### 4. What are the main implementations of Set?

- HashSet
- LinkedHashSet
- TreeSet

---

### 5. Does Set support index-based access?

No.

---

### 6. Which Set implementation maintains insertion order?

LinkedHashSet.

---

### 7. Which Set implementation stores sorted elements?

TreeSet.

---

### 8. Which Set implementation is fastest?

HashSet.

---

### 9. Can Set store null values?

- HashSet → One null
- LinkedHashSet → One null
- TreeSet → No null

---

### 10. Where is Set used in Spring Boot?

Sets are commonly used for user roles, permissions, tags, unique IDs, and removing duplicate data.

---

# Quick Revision

- Set stores **unique elements**.
- No duplicate values.
- No index-based access.
- Main implementations:
  - HashSet
  - LinkedHashSet
  - TreeSet
- HashSet → Fastest.
- LinkedHashSet → Insertion order.
- TreeSet → Sorted order.
- Used to remove duplicates efficiently.

---

# Keywords

- Set
- HashSet
- LinkedHashSet
- TreeSet
- Unique Elements
- Collection
- Hash Table
- Red-Black Tree
- No Duplicates
- Java Collections
- O(1)
- O(log n)