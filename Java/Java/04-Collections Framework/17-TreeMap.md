# TreeMap

## What is a TreeMap?

**TreeMap** is a class in the Java Collections Framework that implements the **Map** interface.

It stores data as **Key → Value** pairs and automatically keeps the **keys sorted**.

Unlike `HashMap` and `LinkedHashMap`, a TreeMap stores entries according to the **natural ordering of keys** or a **Comparator**.

Internally, TreeMap uses a **Red-Black Tree**, which is a self-balancing Binary Search Tree.

> **Definition:** TreeMap is a Map implementation that stores key-value pairs in sorted order using a Red-Black Tree.

---

# Why Do We Need TreeMap?

Suppose you're storing student marks.

Without sorting

```text
103 → Rahul

101 → Amit

102 → Priya
```

Finding data in sorted order is difficult.

Instead,

```java
Map<Integer, String> students =
        new TreeMap<>();
```

Output

```text
101 → Amit

102 → Priya

103 → Rahul
```

The keys are automatically sorted.

---

# Real-World Example

Imagine a dictionary.

```text
Apple

↓

Meaning

Ball

↓

Meaning

Cat

↓

Meaning
```

Words are arranged alphabetically.

Similarly,

TreeMap stores entries in sorted key order.

---

# Hierarchy

```text
Map
 │
NavigableMap
 │
SortedMap
 │
TreeMap
```

TreeMap implements

- SortedMap
- NavigableMap

---

# Characteristics

- Stores Key → Value pairs
- Keys are unique
- Values can be duplicated
- Automatically sorts keys
- Uses Red-Black Tree
- Does not allow null keys
- Allows multiple null values
- Not synchronized

---

# Creating a TreeMap

```java
Map<Integer, String> map =
        new TreeMap<>();
```

or

```java
TreeMap<Integer, String> map =
        new TreeMap<>();
```

Preferred

```java
Map<Integer, String> map =
        new TreeMap<>();
```

---

# Adding Elements

```java
Map<Integer, String> map =
        new TreeMap<>();

map.put(103, "Rahul");

map.put(101, "Amit");

map.put(102, "Priya");
```

Output

```text
101 → Amit

102 → Priya

103 → Rahul
```

The keys are sorted automatically.

---

# Updating Values

```java
map.put(102, "Rohan");
```

Output

```text
102 → Rohan
```

The value is updated while the key remains in its sorted position.

---

# Getting Values

```java
System.out.println(map.get(101));
```

Output

```text
Amit
```

---

# Removing Elements

```java
map.remove(103);
```

---

# Checking Keys

```java
map.containsKey(102);
```

Output

```text
true
```

---

# Checking Values

```java
map.containsValue("Rohan");
```

Output

```text
true
```

---

# Traversing a TreeMap

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
101 : Amit

102 : Priya

103 : Rahul
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

# Common Methods

| Method | Description |
|---------|-------------|
| put() | Inserts key-value pair |
| get() | Returns value |
| remove() | Removes entry |
| firstKey() | Returns smallest key |
| lastKey() | Returns largest key |
| higherKey() | Returns next greater key |
| lowerKey() | Returns next smaller key |
| ceilingKey() | Returns equal or greater key |
| floorKey() | Returns equal or smaller key |
| pollFirstEntry() | Removes first entry |
| pollLastEntry() | Removes last entry |

---

# Internal Working

TreeMap internally uses

```text
TreeMap

↓

Red-Black Tree
```

Whenever a new key is inserted,

```java
map.put(50, "Java");
```

Internally

```text
Compare Key

↓

Move Left / Right

↓

Insert Node

↓

Balance Tree
```

The tree always remains balanced.

---

# Red-Black Tree Representation

```text
        50
       /  \
     30    70
    / \    / \
   20 40 60 80
```

Searching, insertion, and deletion remain efficient because the tree stays balanced.

---

# Custom Sorting

TreeMap can use a Comparator.

Ascending

```java
TreeMap<Integer, String> map =
        new TreeMap<>();
```

Descending

```java
TreeMap<Integer, String> map =
        new TreeMap<>(Collections.reverseOrder());
```

Output

```text
103

102

101
```

---

# Null Handling

TreeMap does **not** allow null keys.

```java
map.put(null, "Java");
```

Throws

```text
NullPointerException
```

However,

null values are allowed.

```java
map.put(101, null);
```

This is valid.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| put() | O(log n) |
| get() | O(log n) |
| remove() | O(log n) |
| containsKey() | O(log n) |
| firstKey() | O(log n) |
| lastKey() | O(log n) |

---

# HashMap vs LinkedHashMap vs TreeMap

| Feature | HashMap | LinkedHashMap | TreeMap |
|----------|----------|---------------|----------|
| Order | No | Insertion Order | Sorted Keys |
| Internal DS | Hash Table | Hash Table + Linked List | Red-Black Tree |
| Complexity | O(1) | O(1) | O(log n) |
| Null Key | One | One | No |
| Null Values | Yes | Yes | Yes |

---

# TreeMap vs Hashtable

| TreeMap | Hashtable |
|----------|-----------|
| Sorted Keys | No Ordering |
| O(log n) | O(1) |
| Not Synchronized | Synchronized |
| Null Values Allowed | Null Values Not Allowed |

---

# Production Usage

TreeMap is commonly used in

- Student rankings
- Leaderboards
- Banking reports
- Stock market applications
- Scheduling systems
- Financial reports
- Sorted configuration data

Example

```java
Map<Integer, String> rankings =
        new TreeMap<>();
```

---

# Advantages

- Automatically sorts keys
- Efficient searching
- Rich navigation methods
- No duplicate keys
- Balanced tree implementation

---

# Limitations

- Slower than HashMap
- No null keys
- More memory usage
- Not thread-safe

---

# Best Practices

✅ Use TreeMap when sorted keys are required.

---

✅ Use HashMap when sorting is not needed.

---

✅ Use Comparator for custom sorting.

---

✅ Use immutable keys whenever possible.

---

# Common Mistakes

❌ Assuming TreeMap maintains insertion order.

It maintains **sorted order**, not insertion order.

---

❌ Adding null keys.

Throws `NullPointerException`.

---

❌ Using custom objects as keys without implementing `Comparable` or providing a `Comparator`.

May throw `ClassCastException`.

---

# Interview Questions

### 1. What is TreeMap?

TreeMap is a Map implementation that stores key-value pairs in sorted order using a Red-Black Tree.

---

### 2. Does TreeMap allow duplicate keys?

No.

---

### 3. Does TreeMap maintain insertion order?

No.

It maintains sorted order based on keys.

---

### 4. What data structure does TreeMap use internally?

A Red-Black Tree.

---

### 5. Does TreeMap allow null keys?

No.

---

### 6. Does TreeMap allow null values?

Yes.

---

### 7. What is the time complexity of `put()`?

**O(log n)**

---

### 8. How can you sort TreeMap in descending order?

```java
TreeMap<Integer, String> map =
        new TreeMap<>(Collections.reverseOrder());
```

---

### 9. Why is TreeMap slower than HashMap?

Because maintaining a balanced tree requires **O(log n)** operations.

---

### 10. Where is TreeMap used in Spring Boot?

- Sorted reports
- Ranking systems
- Analytics
- Financial data
- Scheduling applications

---

# Quick Revision

- TreeMap implements the Map interface.
- Stores **Key → Value** pairs.
- Uses a **Red-Black Tree** internally.
- Automatically sorts keys.
- Keys are unique.
- Duplicate values allowed.
- No null keys.
- Null values allowed.
- Average complexity:
  - put() → O(log n)
  - get() → O(log n)
  - remove() → O(log n)

---

# Keywords

- TreeMap
- Map
- SortedMap
- NavigableMap
- Red-Black Tree
- Comparator
- Comparable
- Sorted Keys
- Key-Value Pair
- firstKey()
- lastKey()
- higherKey()
- lowerKey()
- Java Collections
- O(log n)