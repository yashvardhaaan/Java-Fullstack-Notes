# HashSet

## What is a HashSet?

**HashSet** is a class in the Java Collections Framework that implements the **Set** interface.

It stores **unique elements** and uses a **Hash Table** internally for fast insertion, deletion, and searching.

A HashSet:

- Does not allow duplicate elements
- Does not maintain insertion order
- Allows one null value
- Provides very fast performance for most operations

> **Definition:** HashSet is an implementation of the Set interface that stores unique elements using a Hash Table.

---

# Why Do We Need HashSet?

Suppose you're storing registered email addresses.

```text
john@gmail.com

alice@gmail.com

john@gmail.com
```

Duplicate email addresses should not exist.

Instead,

```java
Set<String> emails =
        new HashSet<>();
```

Duplicate entries are automatically ignored.

---

# Real-World Example

Imagine a guest list for an event.

```text
Rahul

Amit

Priya

Rahul
```

A person's name should appear only once.

HashSet works the same way.

---

# Hierarchy

```text
Iterable
    │
Collection
    │
   Set
    │
 HashSet
```

---

# Characteristics

- No duplicate elements
- Unordered collection
- Dynamic size
- Allows one null value
- Fast insertion and searching
- Not synchronized

---

# Creating a HashSet

```java
Set<String> set =
        new HashSet<>();
```

or

```java
HashSet<String> set =
        new HashSet<>();
```

Preferred

```java
Set<String> set =
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

Duplicate values are ignored.

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

# Size

```java
System.out.println(set.size());
```

Output

```text
1
```

---

# Traversing a HashSet

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
| add() | Adds element |
| remove() | Removes element |
| contains() | Checks element |
| size() | Returns size |
| clear() | Removes all elements |
| isEmpty() | Checks if empty |

---

# Internal Working

HashSet internally uses a

```text
HashMap
```

Each element becomes the **key** of the HashMap.

A dummy value is stored internally.

```text
HashSet

↓

HashMap

↓

Key → Dummy Value
```

Example

```java
set.add("Java");
```

Internally

```text
"Java"

↓

HashMap.put("Java", PRESENT)
```

`PRESENT` is a constant dummy object used internally.

---

# Hashing Process

Suppose

```java
set.add("Apple");
```

Internally

```text
Object

↓

hashCode()

↓

Bucket Number

↓

Store Element
```

When searching

```text
Object

↓

hashCode()

↓

Same Bucket

↓

equals()

↓

Found
```

---

# Bucket Representation

```text
Bucket 0

↓

Java

Bucket 1

↓

Spring

Bucket 2

↓

SQL
```

Elements are stored in different buckets according to their hash value.

---

# Handling Duplicates

Suppose

```java
set.add("Java");

set.add("Java");
```

Internally

```text
hashCode()

↓

Same Bucket

↓

equals()

↓

Already Exists

↓

Ignored
```

No duplicate element is inserted.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| add() | O(1) Average |
| remove() | O(1) Average |
| contains() | O(1) Average |
| search | O(1) Average |

Worst case

```text
O(n)
```

This happens only when many elements collide into the same bucket.

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

HashSet

↓

HashMap

↓

Buckets

↓

Elements
```

---

# HashSet vs ArrayList

| HashSet | ArrayList |
|----------|-----------|
| No duplicates | Duplicates allowed |
| No order | Maintains insertion order |
| No index | Index-based |
| Fast searching | Linear searching |

---

# HashSet vs LinkedHashSet

| HashSet | LinkedHashSet |
|----------|---------------|
| No ordering | Insertion order maintained |
| Faster | Slightly slower |
| Uses Hash Table | Hash Table + Linked List |

---

# HashSet vs TreeSet

| HashSet | TreeSet |
|----------|----------|
| Unordered | Sorted |
| O(1) Average | O(log n) |
| Uses Hash Table | Uses Red-Black Tree |

---

# Production Usage

HashSet is widely used in

- Removing duplicate records
- User IDs
- Email validation
- Role management
- Caching
- Unique tags
- Fast lookups

Example

```java
Set<String> permissions =
        new HashSet<>();

permissions.add("READ");

permissions.add("WRITE");
```

---

# Advantages

- Very fast lookup
- No duplicates
- Dynamic size
- Efficient memory usage
- Simple API

---

# Limitations

- No insertion order
- No sorting
- No index access
- Not thread-safe

---

# Best Practices

✅ Use HashSet when ordering is not required.

---

✅ Override `equals()` and `hashCode()` correctly for custom objects.

---

✅ Use Generics.

```java
Set<Employee> employees =
        new HashSet<>();
```

---

# Common Mistakes

❌ Expecting insertion order.

HashSet does **not** maintain order.

---

❌ Forgetting to override `equals()` and `hashCode()`.

Duplicate custom objects may be stored incorrectly.

---

❌ Using HashSet when sorted data is needed.

Use TreeSet instead.

---

# Interview Questions

### 1. What is HashSet?

HashSet is an implementation of the Set interface that stores unique elements using a Hash Table.

---

### 2. Does HashSet allow duplicate elements?

No.

---

### 3. Does HashSet maintain insertion order?

No.

---

### 4. Does HashSet allow null values?

Yes.

Only one null value.

---

### 5. What data structure does HashSet use internally?

HashMap.

---

### 6. How does HashSet detect duplicates?

Using `hashCode()` and `equals()`.

---

### 7. What is the average time complexity of `add()`?

**O(1)**

---

### 8. Why should `equals()` and `hashCode()` be overridden?

To ensure duplicate custom objects are identified correctly.

---

### 9. Is HashSet thread-safe?

No.

---

### 10. Where is HashSet used in real-world applications?

- Removing duplicates
- User permissions
- Email validation
- Unique IDs
- Fast searching
- Caching

---

# Quick Revision

- HashSet implements the Set interface.
- Stores **unique elements**.
- Uses **HashMap** internally.
- No insertion order.
- One null value allowed.
- Uses `hashCode()` and `equals()`.
- Average complexity:
  - add() → O(1)
  - remove() → O(1)
  - contains() → O(1)
- Best choice for fast uniqueness checks.

---

# Keywords

- HashSet
- Set
- HashMap
- Hash Table
- Bucket
- hashCode()
- equals()
- Unique Elements
- No Duplicates
- Java Collections
- O(1)
```