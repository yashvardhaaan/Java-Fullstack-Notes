# ArrayList

## What is an ArrayList?

**ArrayList** is a class in the Java Collections Framework that implements the **List** interface.

Internally, it uses a **dynamic array**, which automatically grows when more elements are added.

An ArrayList:

- Maintains insertion order
- Allows duplicate elements
- Supports fast index-based access
- Allows null values
- Has dynamic size

> **Definition:** ArrayList is a resizable array implementation of the List interface that provides fast random access to elements.

---

# Why Do We Need ArrayList?

Suppose we use an array.

```java
String[] names = new String[3];
```

Problems

- Fixed size
- Cannot grow automatically
- Manual resizing required

Instead,

```java
List<String> names =
        new ArrayList<>();
```

The ArrayList automatically increases its capacity whenever needed.

---

# Real-World Example

Imagine a notebook.

```text
Page 0 → Java

Page 1 → Spring

Page 2 → SQL
```

Whenever the notebook becomes full,

you simply add more pages.

Similarly,

ArrayList automatically expands when full.

---

# Hierarchy

```text
Iterable
    │
Collection
    │
   List
    │
ArrayList
```

---

# Characteristics

- Ordered collection
- Dynamic size
- Duplicate elements allowed
- Fast random access
- Allows null values
- Not synchronized

---

# Creating an ArrayList

```java
List<String> list =
        new ArrayList<>();
```

or

```java
ArrayList<String> list =
        new ArrayList<>();
```

The first approach is preferred.

---

# Adding Elements

```java
List<String> list =
        new ArrayList<>();

list.add("Java");

list.add("Spring");

list.add("Java");
```

Output

```text
Java

Spring

Java
```

Duplicates are allowed.

---

# Accessing Elements

```java
System.out.println(list.get(1));
```

Output

```text
Spring
```

Time Complexity

```text
O(1)
```

---

# Updating Elements

```java
list.set(1, "Spring Boot");
```

Before

```text
Java

Spring

Java
```

After

```text
Java

Spring Boot

Java
```

---

# Removing Elements

By index

```java
list.remove(1);
```

By object

```java
list.remove("Java");
```

---

# Traversing an ArrayList

### For Loop

```java
for(int i = 0; i < list.size(); i++){

    System.out.println(list.get(i));

}
```

---

### Enhanced For Loop

```java
for(String language : list){

    System.out.println(language);

}
```

---

### Iterator

```java
Iterator<String> itr =
        list.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

---

### Java 8 forEach

```java
list.forEach(System.out::println);
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| add() | Adds an element |
| get() | Returns element |
| set() | Updates element |
| remove() | Removes element |
| contains() | Checks element |
| size() | Returns size |
| clear() | Removes all elements |
| isEmpty() | Checks if empty |

---

# Internal Working

Initially

```java
ArrayList<Integer> list =
        new ArrayList<>();
```

Internally

```text
Capacity = 10

┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
│   │   │   │   │   │   │   │   │   │   │
└───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
```

Java creates an internal array.

---

# Dynamic Resizing

Suppose capacity becomes full.

```text
Old Capacity = 10
```

When another element is added,

ArrayList creates a larger array.

```text
New Capacity = Old + (Old / 2)

10

↓

15
```

Internally

```text
Old Array

↓

Create Bigger Array

↓

Copy Elements

↓

Delete Old Array
```

This resizing is automatic.

---

# Capacity vs Size

Many beginners confuse these.

| Capacity | Size |
|----------|------|
| Total space available | Number of stored elements |

Example

```text
Capacity = 10

Size = 3
```

Three elements are stored,

but space exists for ten.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| get() | O(1) |
| set() | O(1) |
| add() (end) | O(1) Average |
| add() (middle) | O(n) |
| remove() (middle) | O(n) |
| search | O(n) |

---

# Memory Representation

```java
List<String> list =
        new ArrayList<>();
```

Memory

```text
Stack

↓

list

↓

Heap

↓

ArrayList Object

↓

Internal Array

↓

Elements
```

---

# Array vs ArrayList

| Array | ArrayList |
|--------|-----------|
| Fixed size | Dynamic size |
| Stores primitives directly | Stores objects |
| No built-in methods | Rich API |
| Faster for fixed data | Flexible |

---

# ArrayList vs LinkedList

| ArrayList | LinkedList |
|------------|------------|
| Dynamic Array | Doubly Linked List |
| Fast random access | Slow random access |
| Slow insertion in middle | Fast insertion in middle |
| Less memory | More memory |

---

# ArrayList vs Vector

| ArrayList | Vector |
|------------|--------|
| Not synchronized | Synchronized |
| Faster | Slower |
| Preferred | Legacy class |

---

# Production Usage

ArrayList is one of the most commonly used collections.

Examples

- Spring Boot
- REST APIs
- Hibernate
- DTOs
- API Responses

Example

```java
List<User> users =
        userRepository.findAll();
```

Repository methods often return an `ArrayList` or `List`.

---

# Advantages

- Fast random access
- Dynamic resizing
- Ordered collection
- Easy traversal
- Rich API

---

# Limitations

- Slow insertion in the middle
- Slow deletion in the middle
- Stores objects only
- Not thread-safe

---

# Best Practices

✅ Use the `List` interface.

```java
List<String> list =
        new ArrayList<>();
```

---

✅ Specify initial capacity if size is known.

```java
new ArrayList<>(100);
```

This reduces resizing operations.

---

✅ Use ArrayList when reads are more frequent than insertions.

---

# Common Mistakes

❌ Using ArrayList for frequent insertions at the beginning.

Use LinkedList instead.

---

❌ Confusing capacity with size.

---

❌ Accessing an invalid index.

```java
list.get(100);
```

Throws

```text
IndexOutOfBoundsException
```

---

❌ Forgetting Generics.

```java
ArrayList list =
        new ArrayList();
```

Use

```java
ArrayList<String> list =
        new ArrayList<>();
```

---

# Interview Questions

### 1. What is ArrayList?

ArrayList is a dynamic array implementation of the List interface.

---

### 2. Does ArrayList allow duplicates?

Yes.

---

### 3. Does ArrayList maintain insertion order?

Yes.

---

### 4. What is the default capacity of an ArrayList?

An empty `ArrayList` starts with an empty internal array. On the **first add**, Java allocates a default capacity of **10**.

---

### 5. How does ArrayList grow?

It creates a larger array (typically **1.5×** the old capacity) and copies existing elements into it.

---

### 6. Why is `get()` fast?

Because ArrayList uses an internal array, allowing direct index access.

---

### 7. Why are insertions in the middle slow?

Because elements after the insertion point must be shifted.

---

### 8. Is ArrayList thread-safe?

No.

Use `Collections.synchronizedList()` or `CopyOnWriteArrayList` if thread safety is required.

---

### 9. What is the difference between capacity and size?

Capacity is the allocated storage.

Size is the number of elements currently stored.

---

### 10. Where is ArrayList used in Spring Boot?

It is commonly used for repository results, DTO collections, service responses, and REST API responses.

---

# Quick Revision

- ArrayList implements the List interface.
- Uses a dynamic array internally.
- Maintains insertion order.
- Allows duplicate and null elements.
- Fast random access (`O(1)`).
- Slow insertion/deletion in the middle (`O(n)`).
- Not synchronized.
- Capacity grows automatically.

---

# Keywords

- ArrayList
- List
- Dynamic Array
- Capacity
- Size
- Random Access
- Generics
- Collection Framework
- Java
- Spring Boot
- O(1)
- O(n)