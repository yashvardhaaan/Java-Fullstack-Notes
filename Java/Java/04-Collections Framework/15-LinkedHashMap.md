# LinkedHashMap

## What is a LinkedHashMap?

**LinkedHashMap** is a class in the Java Collections Framework that implements the **Map** interface.

It stores data as **Key → Value** pairs like `HashMap`, but it also **maintains the insertion order** of entries.

Internally, it uses:

- Hash Table
- Doubly Linked List

> **Definition:** LinkedHashMap is a HashMap that maintains the order in which key-value pairs are inserted.

---

# Why Do We Need LinkedHashMap?

Suppose you're storing recently viewed products.

```text
Laptop

↓

Phone

↓

Headphones

↓

Watch
```

The order in which users viewed products should remain the same.

Using

```java
Map<Integer, String> products =
        new LinkedHashMap<>();
```

preserves the insertion order.

---

# Real-World Example

Imagine a browser history.

```text
Google

↓

YouTube

↓

GitHub

↓

ChatGPT
```

The history should appear in the order the websites were visited.

LinkedHashMap works the same way.

---

# Hierarchy

```text
Map
 │
HashMap
 │
LinkedHashMap
```

LinkedHashMap extends `HashMap`.

---

# Characteristics

- Stores Key → Value pairs
- Maintains insertion order
- Keys are unique
- Values can be duplicated
- Allows one null key
- Allows multiple null values
- Slightly slower than HashMap
- Not synchronized

---

# Creating a LinkedHashMap

```java
Map<Integer, String> map =
        new LinkedHashMap<>();
```

or

```java
LinkedHashMap<Integer, String> map =
        new LinkedHashMap<>();
```

Preferred

```java
Map<Integer, String> map =
        new LinkedHashMap<>();
```

---

# Adding Elements

```java
Map<Integer, String> map =
        new LinkedHashMap<>();

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

Entries appear in the same order they were inserted.

---

# Updating Values

```java
map.put(102, "Rohan");
```

Output

```text
101 → Rahul

102 → Rohan

103 → Priya
```

Updating a value does **not** change its position.

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

# Traversing a LinkedHashMap

### Using entrySet()

```java
for(Map.Entry<Integer, String> entry : map.entrySet()){

    System.out.println(
        entry.getKey() + " : " + entry.getValue()
    );

}
```

Output

```text
101 : Rahul

102 : Amit

103 : Priya
```

Notice that insertion order is maintained.

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

# Common Methods

| Method | Description |
|---------|-------------|
| put() | Inserts key-value pair |
| get() | Returns value |
| remove() | Removes entry |
| containsKey() | Checks key |
| containsValue() | Checks value |
| size() | Returns size |
| clear() | Removes all entries |
| isEmpty() | Checks if empty |

---

# Internal Working

LinkedHashMap internally uses

```text
Hash Table

+

Doubly Linked List
```

The Hash Table provides fast lookup.

The Doubly Linked List maintains insertion order.

---

# Memory Representation

Suppose

```java
map.put(101, "Rahul");

map.put(102, "Amit");

map.put(103, "Priya");
```

Internally

```text
Hash Table

↓

101 → Rahul

102 → Amit

103 → Priya

↓

Linked List

101 ↔ 102 ↔ 103
```

Both structures work together.

---

# Access Order Mode

By default,

LinkedHashMap maintains **insertion order**.

It can also maintain **access order**.

```java
Map<Integer, String> map =
        new LinkedHashMap<>(16, 0.75f, true);
```

Now, whenever an entry is accessed,

```java
map.get(101);
```

that entry moves to the end.

This feature is useful for implementing **LRU (Least Recently Used) Cache**.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| put() | O(1) Average |
| get() | O(1) Average |
| remove() | O(1) Average |
| containsKey() | O(1) Average |

Slightly slower than HashMap because it maintains the linked list.

---

# HashMap vs LinkedHashMap

| Feature | HashMap | LinkedHashMap |
|----------|----------|---------------|
| Order | No | Insertion Order |
| Internal DS | Hash Table | Hash Table + Linked List |
| Complexity | O(1) | O(1) |
| Null Key | One | One |
| Null Values | Yes | Yes |

---

# LinkedHashMap vs TreeMap

| LinkedHashMap | TreeMap |
|---------------|----------|
| Insertion Order | Sorted Keys |
| O(1) | O(log n) |
| Hash Table | Red-Black Tree |

---

# Production Usage

LinkedHashMap is commonly used in

- LRU Cache
- Browser history
- Recently viewed products
- Ordered API responses
- Configuration files
- JSON serialization where field order matters

Example

```java
Map<String, Object> response =
        new LinkedHashMap<>();

response.put("status", "success");

response.put("message", "User Created");

response.put("data", user);
```

The JSON response preserves the insertion order.

---

# Advantages

- Maintains insertion order
- Fast lookup
- Supports null key/value
- Dynamic size
- Easy iteration

---

# Limitations

- Slightly slower than HashMap
- Not sorted
- Not thread-safe
- Uses slightly more memory

---

# Best Practices

✅ Use LinkedHashMap when insertion order matters.

---

✅ Use access-order mode for implementing LRU Cache.

---

✅ Use `Map` as the reference type.

```java
Map<Integer, String> map =
        new LinkedHashMap<>();
```

---

# Common Mistakes

❌ Assuming LinkedHashMap sorts keys.

It preserves insertion order, **not sorted order**.

---

❌ Using LinkedHashMap when ordering is not needed.

HashMap is generally a better choice for maximum performance.

---

❌ Assuming updates change entry order.

Updating an existing value does **not** move the entry unless access-order mode is enabled.

---

# Interview Questions

### 1. What is LinkedHashMap?

LinkedHashMap is a Map implementation that maintains insertion order using a Hash Table and a Doubly Linked List.

---

### 2. Does LinkedHashMap allow duplicate keys?

No.

---

### 3. Does LinkedHashMap maintain insertion order?

Yes.

---

### 4. Does LinkedHashMap allow null keys?

Yes.

One null key.

---

### 5. What data structures does LinkedHashMap use internally?

A Hash Table and a Doubly Linked List.

---

### 6. Which is faster, HashMap or LinkedHashMap?

HashMap is slightly faster.

---

### 7. Can LinkedHashMap maintain access order?

Yes.

Using

```java
new LinkedHashMap<>(16, 0.75f, true);
```

---

### 8. What is the average time complexity of `get()`?

**O(1)**

---

### 9. What is LinkedHashMap mainly used for?

Maintaining insertion order and implementing LRU Cache.

---

### 10. Where is LinkedHashMap used in Spring Boot?

- Ordered JSON responses
- Configuration
- Caching
- Session data
- API responses

---

# Quick Revision

- LinkedHashMap implements the Map interface.
- Stores **Key → Value** pairs.
- Maintains insertion order.
- Uses a Hash Table + Doubly Linked List.
- One null key.
- Multiple null values.
- Supports access-order mode for LRU Cache.
- Average complexity:
  - put() → O(1)
  - get() → O(1)
  - remove() → O(1)

---

# Keywords

- LinkedHashMap
- Map
- Hash Table
- Doubly Linked List
- Insertion Order
- Access Order
- LRU Cache
- Key-Value Pair
- put()
- get()
- containsKey()
- Java Collections
- O(1)