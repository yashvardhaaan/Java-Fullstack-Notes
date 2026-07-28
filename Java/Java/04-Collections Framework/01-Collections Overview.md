# Collections Framework

## What is the Collections Framework?

The **Java Collections Framework (JCF)** is a set of **interfaces, classes, and algorithms** that help us store, organize, manipulate, and retrieve groups of objects efficiently.

Instead of creating our own data structures from scratch, Java provides ready-made implementations like:

- ArrayList
- LinkedList
- HashSet
- HashMap
- TreeSet
- TreeMap
- Queue
- Stack

> **Definition:** The Java Collections Framework is a unified architecture that provides interfaces and classes to store and manipulate collections of objects.

---

# Why Do We Need Collections?

Suppose we want to store 100 student names.

Without Collections

```java
String s1 = "John";
String s2 = "Alice";
String s3 = "Bob";
...
```

Managing hundreds of variables becomes difficult.

Instead,

```java
List<String> students = new ArrayList<>();
```

Now,

all students are stored in one collection.

---

# Real-World Example

Imagine a library.

```text
Library

↓

Bookshelf

↓

Books
```

The bookshelf stores many books in an organized way.

Similarly,

```text
Collection

↓

ArrayList

↓

Objects
```

Collections organize objects efficiently.

---

# Why Not Arrays?

Arrays have limitations.

```java
int[] arr = new int[5];
```

Problems

- Fixed size
- Cannot grow automatically
- Difficult insertion and deletion
- Limited utility methods

Collections solve these problems.

---

# Features of Collections Framework

- Dynamic size
- Easy insertion and deletion
- Built-in searching
- Built-in sorting
- Generic support
- Reusable algorithms
- Better code readability

---

# Collection Hierarchy

```text
                  Iterable
                      │
                 Collection
        ┌─────────┼─────────┐
        │         │         │
       List      Set      Queue
        │         │         │
  ┌─────┼─────┐   │      ┌──┴─────┐
  │     │     │   │      │        │
ArrayList LinkedList  HashSet  PriorityQueue
        │             │
      Stack      LinkedHashSet
                      │
                  TreeSet

Map (Separate Hierarchy)
        │
 ┌──────┼──────────┐
 │      │          │
HashMap LinkedHashMap TreeMap
        │
    Hashtable
```

Notice

`Map` is **not** part of the `Collection` interface.

It has its own hierarchy.

---

# Main Interfaces

The Collections Framework mainly consists of

- List
- Set
- Queue
- Map

---

# List

Stores

- Ordered elements
- Duplicate values
- Index-based data

Example

```java
List<String> list = new ArrayList<>();
```

Example Output

```text
Apple
Banana
Apple
```

Duplicates are allowed.

---

# Set

Stores

- Unique elements
- No duplicates

Example

```java
Set<Integer> set = new HashSet<>();
```

Output

```text
10
20
30
```

Duplicate values are ignored.

---

# Queue

Follows

```text
FIFO

First In

First Out
```

Example

```java
Queue<Integer> queue =
        new LinkedList<>();
```

Used in

- Scheduling
- BFS
- Printer queues

---

# Map

Stores

```text
Key → Value
```

Example

```java
Map<Integer,String> map =
        new HashMap<>();
```

Example

```text
101 → John

102 → Alice
```

Keys are unique.

Values can be duplicated.

---

# Generic Collections

Collections use Generics.

Example

```java
List<String> names =
        new ArrayList<>();
```

Benefits

- Type safety
- No explicit casting
- Compile-time checking

---

# Common Collection Classes

| Class | Description |
|--------|-------------|
| ArrayList | Dynamic array |
| LinkedList | Doubly linked list |
| Stack | LIFO collection |
| PriorityQueue | Priority-based queue |
| HashSet | Unordered unique elements |
| LinkedHashSet | Insertion order maintained |
| TreeSet | Sorted unique elements |
| HashMap | Key-value storage |
| LinkedHashMap | Ordered HashMap |
| TreeMap | Sorted Map |
| Hashtable | Thread-safe HashMap |

---

# Iterable Interface

Every Collection implements

```text
Iterable
```

This allows

```java
for(String name : names){

    System.out.println(name);

}
```

Enhanced for-loop works because of `Iterable`.

---

# Iterator

Collections are traversed using an Iterator.

```java
Iterator<String> itr =
        list.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

Iterator moves through elements one by one.

---

# Collections vs Collection

Many beginners confuse these.

| Collection | Collections |
|------------|-------------|
| Interface | Utility Class |
| Stores objects | Provides helper methods |
| Implemented by List, Set, Queue | Contains methods like `sort()`, `reverse()`, `shuffle()` |

---

# Internal Working

Suppose

```java
List<String> list =
        new ArrayList<>();

list.add("Java");
```

Internally

```text
ArrayList

↓

Dynamic Array

↓

Store Element

↓

Increase Size Automatically (if required)
```

Similarly,

```java
HashSet
```

Internally uses

```text
HashMap
```

---

# Production Usage

Collections are used in almost every Java application.

Examples

- Spring Boot
- Hibernate
- REST APIs
- JDBC
- Microservices
- Android Development

Example

```java
List<User> users =
        userRepository.findAll();
```

Spring Data JPA returns collections extensively.

---

# Advantages

- Dynamic resizing
- Easy searching
- Built-in sorting
- Generic support
- Better performance
- Rich API

---

# Limitations

- Stores objects, not primitive data types directly
- Choosing the wrong collection can reduce performance
- Some implementations are not thread-safe

---

# Best Practices

✅ Choose the correct collection based on the use case.

✅ Use Generics.

✅ Prefer interfaces over implementations.

Example

```java
List<String> list =
        new ArrayList<>();
```

instead of

```java
ArrayList<String> list =
        new ArrayList<>();
```

---

# Common Mistakes

❌ Using ArrayList when frequent insertions occur.

Use LinkedList instead.

---

❌ Using HashMap when sorted keys are needed.

Use TreeMap.

---

❌ Using HashSet when insertion order matters.

Use LinkedHashSet.

---

❌ Forgetting Generics.

Avoid

```java
ArrayList list = new ArrayList();
```

Use

```java
ArrayList<String> list =
        new ArrayList<>();
```

---

# Interview Questions

### 1. What is the Java Collections Framework?

A framework consisting of interfaces, classes, and algorithms used to store and manipulate groups of objects.

---

### 2. Why do we use Collections instead of Arrays?

Collections are dynamic, provide utility methods, and are easier to work with.

---

### 3. What are the main interfaces of the Collections Framework?

- List
- Set
- Queue
- Map

---

### 4. Is Map part of the Collection interface?

No.

Map belongs to a separate hierarchy.

---

### 5. What is Iterable?

An interface that allows collections to be traversed using the enhanced for-loop or Iterator.

---

### 6. What is the difference between Collection and Collections?

Collection is an interface.

Collections is a utility class.

---

### 7. Which collection allows duplicates?

List.

---

### 8. Which collection stores unique elements?

Set.

---

### 9. Which collection stores key-value pairs?

Map.

---

### 10. Where is the Collections Framework used in Spring Boot?

It is used in repositories, services, controllers, DTOs, entities, caching, and API responses.

---

# Quick Revision

- Collections Framework = Interfaces + Classes + Algorithms.
- Dynamic alternative to arrays.
- Main interfaces:
  - List
  - Set
  - Queue
  - Map
- Uses Generics.
- Supports Iterators.
- Provides sorting and searching utilities.
- Used in almost every Java application.

---

# Keywords

- Collections Framework
- Collection
- Collections
- Iterable
- Iterator
- List
- Set
- Queue
- Map
- Generics
- ArrayList
- HashMap
- HashSet
- TreeMap
- Spring Boot
```