# Map Interface

## What is a Map?

A **Map** is an interface in the Java Collections Framework that stores data as **Key-Value pairs**.

Each key is associated with exactly one value.

> **Definition:** A Map is a collection that stores data in the form of **Key → Value** pairs, where each key is unique.

---

# Why Do We Need a Map?

Suppose we want to store student roll numbers and names.

Without Map

```text
101 → Rahul

102 → Amit

103 → Priya
```

Using two separate arrays is difficult.

```java
int[] rollNo = {101,102,103};

String[] names = {"Rahul","Amit","Priya"};
```

Instead,

```java
Map<Integer, String> students =
        new HashMap<>();
```

Everything is stored together.

---

# Real-World Example

Think about a dictionary.

```text
Apple

↓

A fruit

Banana

↓

A fruit
```

Every word (key) has a meaning (value).

Similarly,

```text
Key

↓

Value
```

---

# Map Hierarchy

Unlike List and Set,

Map does **not** extend the Collection interface.

```text
            Map
             │
   ┌─────────┼──────────┐
   │         │          │
HashMap LinkedHashMap TreeMap
             │
        Hashtable
```

---

# Characteristics

- Stores Key → Value pairs
- Keys are unique
- Values can be duplicated
- Fast searching using keys
- No index-based access
- Dynamic size

---

# Creating a Map

```java
Map<Integer, String> map =
        new HashMap<>();
```

Preferred

```java
Map<Integer, String> map =
        new HashMap<>();
```

instead of

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

# Duplicate Keys

```java
map.put(101, "Rahul");

map.put(101, "Rohan");
```

Output

```text
101 → Rohan
```

The old value is replaced.

---

# Duplicate Values

```java
map.put(101, "Rahul");

map.put(102, "Rahul");
```

Output

```text
101 → Rahul

102 → Rahul
```

Duplicate values are allowed.

---

# Accessing Values

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

# Common Methods

| Method | Description |
|---------|-------------|
| put() | Inserts key-value pair |
| get() | Returns value |
| remove() | Removes entry |
| containsKey() | Checks key |
| containsValue() | Checks value |
| size() | Returns size |
| isEmpty() | Checks if empty |
| clear() | Removes all entries |

---

# Traversing a Map

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

Suppose

```java
map.put(101, "Rahul");
```

Internally

```text
Key

↓

hashCode()

↓

Bucket

↓

Store Entry
```

Each entry contains

```text
Key

↓

Value
```

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

HashMap

↓

Buckets

↓

Key → Value
```

---

# Map Implementations

### HashMap

- Fastest
- No ordering
- Allows one null key

---

### LinkedHashMap

- Maintains insertion order
- Slightly slower

---

### TreeMap

- Sorted keys
- Uses Red-Black Tree

---

### Hashtable

- Thread-safe
- Legacy class

---

# HashMap vs LinkedHashMap vs TreeMap

| Feature | HashMap | LinkedHashMap | TreeMap |
|----------|----------|---------------|----------|
| Order | No | Insertion Order | Sorted |
| Null Key | One | One | No |
| Null Value | Yes | Yes | Yes |
| Complexity | O(1) | O(1) | O(log n) |

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| put() | O(1) Average |
| get() | O(1) Average |
| remove() | O(1) Average |
| containsKey() | O(1) Average |

TreeMap operations are **O(log n)**.

---

# Production Usage

Maps are used almost everywhere.

Examples

- User ID → User
- Product ID → Product
- JWT Claims
- HTTP Headers
- Configuration
- Database caching
- Session storage

Example

```java
Map<String, Object> response =
        new HashMap<>();
```

Used in REST APIs to return JSON responses.

---

# Advantages

- Fast searching
- Unique keys
- Dynamic size
- Rich API
- Flexible implementations

---

# Limitations

- No index access
- Duplicate keys not allowed
- Ordering depends on implementation
- Not thread-safe (HashMap)

---

# Best Practices

✅ Use `HashMap` for fast lookup.

---

✅ Use `LinkedHashMap` when insertion order matters.

---

✅ Use `TreeMap` when sorted keys are required.

---

✅ Always declare variables using the `Map` interface.

```java
Map<Integer, String> map =
        new HashMap<>();
```

---

# Common Mistakes

❌ Expecting duplicate keys.

```java
map.put(1, "A");

map.put(1, "B");
```

The second value replaces the first.

---

❌ Using `containsValue()` for searching keys.

Use `containsKey()` instead.

---

❌ Assuming HashMap maintains insertion order.

It does not.

---

# Interview Questions

### 1. What is a Map?

A Map stores data as Key-Value pairs.

---

### 2. Does Map allow duplicate keys?

No.

---

### 3. Does Map allow duplicate values?

Yes.

---

### 4. Does Map extend the Collection interface?

No.

---

### 5. Which are the common implementations of Map?

- HashMap
- LinkedHashMap
- TreeMap
- Hashtable

---

### 6. Which Map maintains insertion order?

LinkedHashMap.

---

### 7. Which Map stores keys in sorted order?

TreeMap.

---

### 8. Which Map is the fastest?

HashMap (average O(1)).

---

### 9. What is the difference between `containsKey()` and `containsValue()`?

- `containsKey()` checks whether a key exists.
- `containsValue()` checks whether a value exists.

---

### 10. Where is Map used in Spring Boot?

- Request parameters
- Response bodies
- Configuration
- JWT claims
- Session data
- Caching

---

# Quick Revision

- Map stores **Key → Value** pairs.
- Keys are unique.
- Values can be duplicated.
- Does not extend Collection.
- Main implementations:
  - HashMap
  - LinkedHashMap
  - TreeMap
  - Hashtable
- HashMap → Fastest.
- LinkedHashMap → Insertion order.
- TreeMap → Sorted keys.

---

# Keywords

- Map
- HashMap
- LinkedHashMap
- TreeMap
- Hashtable
- Key
- Value
- Hash Table
- Key-Value Pair
- put()
- get()
- containsKey()
- Java Collections
- O(1)
```