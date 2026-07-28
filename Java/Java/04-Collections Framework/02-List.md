# List Interface

## What is a List?

A **List** is an interface in the Java Collections Framework that stores elements in an **ordered sequence**.

A List:

- Maintains insertion order
- Allows duplicate elements
- Supports index-based access
- Allows null values (depending on implementation)

> **Definition:** A List is an ordered collection that allows duplicate elements and provides index-based access to its elements.

---

# Why Do We Need a List?

Suppose we want to store student names.

Without List

```java
String s1 = "John";
String s2 = "Alice";
String s3 = "Bob";
```

Managing many variables becomes difficult.

Instead,

```java
List<String> students =
        new ArrayList<>();
```

Now,

all students are stored in a single collection.

---

# Real-World Example

Imagine a train.

```text
Seat 0 → Rahul

Seat 1 → Amit

Seat 2 → Priya

Seat 3 → Rahul
```

Notice

- Every seat has an index.
- Duplicate names are allowed.
- Order is maintained.

A List works in the same way.

---

# List Hierarchy

```text
Iterable
    │
Collection
    │
   List
    │
 ┌──┼───────────────┐
 │  │               │
ArrayList     LinkedList
                    │
                 Stack (Legacy)
```

The `List` interface is implemented by multiple classes.

---

# Characteristics of List

- Ordered collection
- Duplicate elements allowed
- Index-based access
- Allows null values
- Dynamic size

---

# Creating a List

Always program to the interface.

```java
List<String> list =
        new ArrayList<>();
```

Instead of

```java
ArrayList<String> list =
        new ArrayList<>();
```

This makes it easier to switch implementations later.

---

# Adding Elements

```java
List<String> list =
        new ArrayList<>();

list.add("Java");

list.add("Python");

list.add("Java");
```

Output

```text
Java

Python

Java
```

Duplicates are allowed.

---

# Accessing Elements

```java
System.out.println(list.get(0));
```

Output

```text
Java
```

Access is based on the index.

---

# Updating Elements

```java
list.set(1, "Spring");
```

Before

```text
Java

Python

Java
```

After

```text
Java

Spring

Java
```

---

# Removing Elements

By index

```java
list.remove(0);
```

By object

```java
list.remove("Spring");
```

---

# List Size

```java
System.out.println(list.size());
```

Output

```text
2
```

---

# Checking Elements

Contains

```java
list.contains("Java");
```

Returns

```text
true
```

---

# Empty List

```java
list.isEmpty();
```

Returns

```text
true
```

if the list has no elements.

---

# Traversing a List

### Using for loop

```java
for(int i = 0; i < list.size(); i++){

    System.out.println(list.get(i));

}
```

---

### Using Enhanced for-loop

```java
for(String language : list){

    System.out.println(language);

}
```

---

### Using Iterator

```java
Iterator<String> itr =
        list.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

---

### Using forEach (Java 8)

```java
list.forEach(System.out::println);
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| add() | Adds an element |
| get() | Returns an element |
| set() | Updates an element |
| remove() | Removes an element |
| size() | Returns number of elements |
| contains() | Checks element |
| isEmpty() | Checks if empty |
| clear() | Removes all elements |

---

# Implementations of List

### ArrayList

- Dynamic Array
- Fast random access
- Slow insertion in the middle

---

### LinkedList

- Doubly Linked List
- Fast insertion/deletion
- Slow random access

---

### Stack

- LIFO
- Legacy class

---

# Array vs List

| Array | List |
|--------|------|
| Fixed size | Dynamic size |
| Stores primitives | Stores objects |
| Less flexible | More flexible |
| Few utility methods | Rich API |

---

# List vs Set

| List | Set |
|------|-----|
| Ordered | Order depends on implementation |
| Duplicates allowed | No duplicates |
| Index-based | No index |
| Multiple nulls not allowed (only one null depending on implementation) | Usually one null in HashSet |

> **Note:** A `List` can contain multiple `null` values. A `HashSet` allows at most one `null`.

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
List Interface

↓

ArrayList Object

↓

Dynamic Array

↓

Store Element
```

The interface defines **what** operations are available,

while the implementation decides **how** they are performed.

---

# Production Usage

Lists are used everywhere.

Examples

- Spring Boot
- Hibernate
- REST APIs
- JDBC
- Microservices

Example

```java
List<User> users =
        userRepository.findAll();
```

A repository usually returns a `List` of entities.

---

# Advantages

- Dynamic size
- Ordered data
- Duplicate elements
- Rich API
- Easy traversal

---

# Limitations

- Stores objects only (primitives require wrapper classes)
- Performance depends on implementation
- Wrong implementation can reduce efficiency

---

# Best Practices

✅ Declare variables using the `List` interface.

```java
List<String> list =
        new ArrayList<>();
```

---

✅ Choose the correct implementation.

- ArrayList → Frequent reading
- LinkedList → Frequent insertion/deletion

---

✅ Use Generics.

```java
List<Integer> numbers =
        new ArrayList<>();
```

---

# Common Mistakes

❌ Using raw types.

```java
ArrayList list =
        new ArrayList();
```

---

❌ Using LinkedList when random access is frequent.

---

❌ Forgetting that indexes start from **0**.

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

# Interview Questions

### 1. What is a List?

A List is an ordered collection that allows duplicate elements and supports index-based access.

---

### 2. Which classes implement the List interface?

- ArrayList
- LinkedList
- Stack (Legacy)
- Vector (Legacy)

---

### 3. Does List allow duplicates?

Yes.

---

### 4. Does List maintain insertion order?

Yes.

---

### 5. Can List contain null values?

Yes.

---

### 6. What is the difference between List and Set?

List allows duplicates and maintains order.

Set stores unique elements.

---

### 7. Which List implementation is best for random access?

ArrayList.

---

### 8. Which List implementation is best for frequent insertion and deletion?

LinkedList.

---

### 9. Why should we program to the List interface?

It provides flexibility to switch implementations without changing the rest of the code.

---

### 10. Where is List used in Spring Boot?

Lists are commonly used in repositories, services, controllers, DTOs, and API responses.

---

# Quick Revision

- List = Ordered collection.
- Allows duplicate elements.
- Supports index-based access.
- Dynamic size.
- Main implementations:
  - ArrayList
  - LinkedList
  - Stack (Legacy)
- Prefer `List` as the reference type.
- Use Generics for type safety.

---

# Keywords

- List
- Collection
- ArrayList
- LinkedList
- Stack
- Ordered Collection
- Duplicate Elements
- Index
- Iterator
- Generics
- Java Collections
- Spring Boot