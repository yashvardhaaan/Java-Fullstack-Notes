# Hashtable

## What is a Hashtable?

**Hashtable** is a class in the Java Collections Framework that implements the **Map** interface.

It stores data as **Key → Value** pairs and is **thread-safe** because all its methods are synchronized.

Hashtable was introduced in **Java 1.0** and is considered a **legacy collection**. Today, it has mostly been replaced by **HashMap** and **ConcurrentHashMap**.

> **Definition:** Hashtable is a synchronized implementation of the Map interface that stores key-value pairs using a Hash Table.

---

# Why Do We Need Hashtable?

Suppose multiple threads are updating a shared map.

Without synchronization,

```text
Thread A

↓

Updating Balance

Thread B

↓

Updating Balance
```

Both threads may modify the data at the same time, causing inconsistent results.

Hashtable synchronizes every operation to prevent this.

---

# Real-World Example

Imagine a library register.

Only one librarian can update the register at a time.

```text
Librarian 1

↓

Register

↓

Librarian 2 waits
```

Hashtable works similarly by allowing only one thread to modify the map at a time.

---

# Hierarchy

```text
Map
 │
Hashtable
```

---

# Characteristics

- Stores Key → Value pairs
- Keys are unique
- Values can be duplicated
- Thread-safe
- All methods are synchronized
- Does not maintain insertion order
- Does NOT allow null keys
- Does NOT allow null values
- Slower than HashMap

---

# Creating a Hashtable

```java
Map<Integer, String> table =
        new Hashtable<>();
```

or

```java
Hashtable<Integer, String> table =
        new Hashtable<>();
```

Preferred

```java
Map<Integer, String> table =
        new Hashtable<>();
```

---

# Adding Elements

```java
Map<Integer, String> table =
        new Hashtable<>();

table.put(101, "Rahul");

table.put(102, "Amit");

table.put(103, "Priya");
```

---

# Getting Elements

```java
System.out.println(table.get(101));
```

Output

```text
Rahul
```

---

# Updating Values

```java
table.put(101, "Rohan");
```

Output

```text
101 → Rohan
```

---

# Removing Elements

```java
table.remove(102);
```

---

# Checking Keys

```java
table.containsKey(101);
```

Output

```text
true
```

---

# Checking Values

```java
table.containsValue("Rahul");
```

Output

```text
true
```

---

# Traversing a Hashtable

### Using entrySet()

```java
for(Map.Entry<Integer, String> entry : table.entrySet()){

    System.out.println(
        entry.getKey() + " : " + entry.getValue()
    );

}
```

---

### Using keySet()

```java
for(Integer key : table.keySet()){

    System.out.println(key);

}
```

---

### Using values()

```java
for(String value : table.values()){

    System.out.println(value);

}
```

---

### Java 8 forEach

```java
table.forEach((key, value) ->
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

Hashtable internally uses a **Hash Table**.

When an entry is inserted,

```java
table.put(101, "Rahul");
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

Unlike HashMap,

every public method is synchronized.

```text
Thread

↓

Lock Hashtable

↓

Perform Operation

↓

Release Lock
```

Only one thread can execute a synchronized method at a time.

---

# Null Handling

Hashtable does **not** allow null keys.

```java
table.put(null, "Rahul");
```

Throws

```text
NullPointerException
```

It also does **not** allow null values.

```java
table.put(101, null);
```

Throws

```text
NullPointerException
```

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| put() | O(1) Average |
| get() | O(1) Average |
| remove() | O(1) Average |
| containsKey() | O(1) Average |

Due to synchronization, operations are slower than HashMap.

---

# Hashtable vs HashMap

| Feature | Hashtable | HashMap |
|----------|-----------|----------|
| Thread-safe | Yes | No |
| Synchronized | Yes | No |
| Null Key | No | One |
| Null Values | No | Yes |
| Performance | Slower | Faster |
| Introduced | Java 1.0 | Java 1.2 |

---

# Hashtable vs ConcurrentHashMap

| Hashtable | ConcurrentHashMap |
|------------|-------------------|
| Entire table is locked | Only part of the map is locked |
| Slower | Faster |
| Legacy class | Modern class |
| Synchronized methods | Fine-grained locking |

---

# Production Usage

Today, Hashtable is **rarely used** in modern applications.

Most developers use:

- HashMap (single-threaded)
- ConcurrentHashMap (multi-threaded)

You may still find Hashtable in:

- Legacy enterprise applications
- Old Java libraries
- Older APIs

---

# Advantages

- Thread-safe
- Easy to use
- Prevents concurrent modification issues
- Simple API

---

# Limitations

- Slower due to synchronization
- No null keys
- No null values
- Does not maintain insertion order
- Legacy class

---

# Best Practices

✅ Prefer HashMap for single-threaded applications.

---

✅ Prefer ConcurrentHashMap for multi-threaded applications.

---

✅ Use Hashtable only when maintaining legacy code.

---

# Common Mistakes

❌ Using Hashtable in new projects.

Prefer `ConcurrentHashMap` instead.

---

❌ Expecting insertion order.

Hashtable does not maintain any order.

---

❌ Inserting null keys or values.

Both throw `NullPointerException`.

---

# Interview Questions

### 1. What is Hashtable?

Hashtable is a synchronized implementation of the Map interface that stores key-value pairs using a Hash Table.

---

### 2. Is Hashtable thread-safe?

Yes.

All public methods are synchronized.

---

### 3. Does Hashtable allow null keys?

No.

---

### 4. Does Hashtable allow null values?

No.

---

### 5. Which is faster, HashMap or Hashtable?

HashMap.

---

### 6. Why is Hashtable slower?

Because every operation is synchronized.

---

### 7. Is Hashtable still used today?

Mostly in legacy applications.

Modern applications prefer `ConcurrentHashMap`.

---

### 8. What is the average time complexity of `put()`?

**O(1)**

---

### 9. What is the difference between Hashtable and ConcurrentHashMap?

ConcurrentHashMap provides better performance using fine-grained locking instead of locking the entire map.

---

### 10. When should you use Hashtable?

Only when working with legacy code that specifically requires it.

---

# Quick Revision

- Hashtable implements the Map interface.
- Stores **Key → Value** pairs.
- Uses a Hash Table.
- Thread-safe.
- All methods are synchronized.
- No null keys.
- No null values.
- Does not maintain insertion order.
- Average complexity:
  - put() → O(1)
  - get() → O(1)
  - remove() → O(1)
- Modern replacement: `ConcurrentHashMap`.

---

# Keywords

- Hashtable
- Map
- Hash Table
- Thread-safe
- Synchronized
- Legacy Collection
- ConcurrentHashMap
- Key-Value Pair
- put()
- get()
- NullPointerException
- Java Collections
- O(1)