# HashMap

## What is a HashMap?

**HashMap** is a class in the Java Collections Framework that implements the **Map** interface.

It stores data as **Key → Value** pairs and provides **very fast insertion, deletion, and searching** using a **Hash Table**.

A HashMap:

- Stores key-value pairs
- Keys are unique
- Values can be duplicated
- Allows one null key
- Allows multiple null values
- Does not maintain insertion order

> **Definition:** HashMap is an implementation of the Map interface that stores key-value pairs using a Hash Table.

---

# Why Do We Need HashMap?

Suppose we want to store employee IDs and names.

Without HashMap

```text
101 → Rahul

102 → Amit

103 → Priya
```

Using two separate arrays is difficult.

Instead,

```java
Map<Integer, String> employees =
        new HashMap<>();
```

Everything is stored together.

---

# Real-World Example

Imagine a phone contact list.

```text
Rahul

↓

9876543210

Amit

↓

9988776655
```

Every name (key) is associated with one phone number (value).

HashMap works in the same way.

---

# Hierarchy

```text
Map
 │
HashMap
```

---

# Characteristics

- Stores Key → Value pairs
- Keys are unique
- Values can be duplicated
- Allows one null key
- Allows multiple null values
- Does not maintain insertion order
- Not synchronized

---

# Creating a HashMap

```java
Map<Integer, String> map =
        new HashMap<>();
```

Preferred over

```java
HashMap<Integer, String> map =
        new HashMap<>();
```

---

# Adding Elements

```java
Map<Integer, String> map =
        new HashMap<>();

map.put(101, "Rahul");

map.put(102, "Amit");

map.put(103, "Priya");
```

Output

```text
101 → Rahul

102 → Amit

103 → Priya
```

---

# Updating Values

If the key already exists,

```java
map.put(101, "Rohan");
```

Output

```text
101 → Rohan
```

The old value is replaced.

---

# Getting Values

```java
System.out.println(map.get(101));
```

Output

```text
Rahul
```

---

# Removing Elements

```java
map.remove(102);
```

---

# Checking Keys

```java
map.containsKey(101);
```

Output

```text
true
```

---

# Checking Values

```java
map.containsValue("Rahul");
```

Output

```text
true
```

---

# Size

```java
System.out.println(map.size());
```

---

# Traversing a HashMap

### Using entrySet()

```java
for(Map.Entry<Integer, String> entry : map.entrySet()){

    System.out.println(
        entry.getKey() + " : " + entry.getValue()
    );

}
```

---

### Using keySet()

```java
for(Integer key : map.keySet()){

    System.out.println(key);

}
```

---

### Using values()

```java
for(String value : map.values()){

    System.out.println(value);

}
```

---

### Java 8 forEach

```java
map.forEach((key, value) ->
    System.out.println(key + " : " + value)
);
```

---

# Internal Working

HashMap internally uses a **Hash Table**.

When an entry is inserted,

```java
map.put(101, "Rahul");
```

Internally

```text
Key

↓

hashCode()

↓

Bucket Index

↓

Store Entry
```

Each entry stores

```text
Key

↓

Value

↓

Hash

↓

Next Node (if collision occurs)
```

---

# Bucket Representation

```text
Bucket 0

↓

101 → Rahul

Bucket 1

↓

102 → Amit

Bucket 2

↓

103 → Priya
```

Each bucket stores one or more entries.

---

# How Searching Works

Suppose

```java
map.get(102);
```

Internally

```text
Key

↓

hashCode()

↓

Bucket

↓

equals()

↓

Return Value
```

Searching is very fast because Java directly jumps to the correct bucket.

---

# Hash Collision

Sometimes two keys generate the same bucket.

Example

```text
Key A

↓

Bucket 5

Key B

↓

Bucket 5
```

Both entries are stored in the same bucket.

Java handles collisions using

- Linked List (Java 7)
- Linked List + Red-Black Tree (Java 8+, when many collisions occur)

---

# Treeification (Java 8)

If too many entries are stored in one bucket,

Java converts the linked list into a **Red-Black Tree**.

```text
Before

Bucket

↓

Node

↓

Node

↓

Node

↓

Node

↓

Node
```

After

```text
Bucket

↓

Red-Black Tree
```

This improves search performance.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| put() | O(1) Average |
| get() | O(1) Average |
| remove() | O(1) Average |
| containsKey() | O(1) Average |

Worst Case

```text
O(n)
```

With treeification (Java 8+), worst-case search becomes approximately **O(log n)** for heavily collided buckets.

---

# Memory Representation

```java
Map<Integer, String> map =
        new HashMap<>();
```

Memory

```text
Stack

↓

map

↓

Heap

↓

HashMap Object

↓

Bucket Array

↓

Entries
```

---

# HashMap vs Hashtable

| HashMap | Hashtable |
|----------|-----------|
| Not synchronized | Synchronized |
| Faster | Slower |
| One null key | No null key |
| Multiple null values | No null values |

---

# HashMap vs TreeMap

| HashMap | TreeMap |
|----------|----------|
| Unordered | Sorted |
| O(1) | O(log n) |
| Hash Table | Red-Black Tree |

---

# HashMap vs LinkedHashMap

| HashMap | LinkedHashMap |
|----------|---------------|
| No ordering | Maintains insertion order |
| Faster | Slightly slower |
| Hash Table | Hash Table + Linked List |

---

# Production Usage

HashMap is one of the most used collections in Java.

Examples

- Spring Boot services
- REST API responses
- JWT claims
- Database caching
- Session storage
- Configuration properties
- User information

Example

```java
Map<String, Object> response =
        new HashMap<>();

response.put("status", "success");

response.put("message", "User Created");
```

---

# Advantages

- Very fast lookup
- Dynamic size
- Easy to use
- Supports null key/value
- Rich API

---

# Limitations

- No insertion order
- Not sorted
- Not thread-safe
- No index-based access

---

# Best Practices

✅ Use immutable keys whenever possible.

---

✅ Override `equals()` and `hashCode()` for custom key objects.

---

✅ Use `containsKey()` before `get()` if `null` values are possible.

---

✅ Use `Map` as the reference type.

```java
Map<Integer, String> map =
        new HashMap<>();
```

---

# Common Mistakes

❌ Assuming HashMap maintains insertion order.

It does not.

---

❌ Forgetting to override `equals()` and `hashCode()` for custom keys.

---

❌ Using mutable objects as keys.

Changing the key after insertion can make it impossible to retrieve the value.

---

# Interview Questions

### 1. What is HashMap?

HashMap is a Map implementation that stores key-value pairs using a Hash Table.

---

### 2. Does HashMap allow duplicate keys?

No.

Duplicate keys replace the existing value.

---

### 3. Does HashMap allow duplicate values?

Yes.

---

### 4. Does HashMap allow null keys?

Yes.

Only one null key.

---

### 5. What data structure does HashMap use internally?

A Hash Table.

---

### 6. How does HashMap find an element?

Using `hashCode()` to locate the bucket and `equals()` to identify the correct key.

---

### 7. What happens during a collision?

Multiple entries are stored in the same bucket. In Java 8+, heavily collided buckets may be converted into a Red-Black Tree.

---

### 8. What is the average time complexity of `get()`?

**O(1)**

---

### 9. Is HashMap thread-safe?

No.

Use `ConcurrentHashMap` or synchronization for concurrent access.

---

### 10. Where is HashMap used in Spring Boot?

- API responses
- Configuration
- Session management
- JWT claims
- Caching
- Request/response data

---

# Quick Revision

- HashMap implements the Map interface.
- Stores **Key → Value** pairs.
- Uses a **Hash Table** internally.
- Unique keys.
- Duplicate values allowed.
- One null key.
- Multiple null values.
- Average complexity:
  - put() → O(1)
  - get() → O(1)
  - remove() → O(1)
- Java 8 converts heavily collided buckets into Red-Black Trees.

---

# Keywords

- HashMap
- Map
- Hash Table
- Bucket
- hashCode()
- equals()
- Collision
- Red-Black Tree
- Key-Value Pair
- put()
- get()
- containsKey()
- Java Collections
- O(1)
```