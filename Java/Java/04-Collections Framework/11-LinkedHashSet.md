# LinkedHashSet

## What is a LinkedHashSet?

**LinkedHashSet** is a class in the Java Collections Framework that implements the **Set** interface.

It stores **unique elements** like `HashSet` but also **maintains the insertion order**.

Internally, it uses:

- Hash Table
- Doubly Linked List

> **Definition:** LinkedHashSet is a HashSet that maintains the order in which elements are inserted.

---

# Why Do We Need LinkedHashSet?

Suppose you're displaying recently visited pages.

```text
Home

Products

Cart

Profile
```

The order matters.

A HashSet may display them in any order.

Instead,

```java
Set<String> pages =
        new LinkedHashSet<>();
```

The pages appear exactly in the order they were added.

---

# Real-World Example

Imagine guests entering a hall.

```text
Rahul

↓

Amit

↓

Priya
```

The attendance list should show people in the same order they entered.

LinkedHashSet behaves exactly like this.

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
    │
LinkedHashSet
```

LinkedHashSet extends `HashSet`.

---

# Characteristics

- No duplicate elements
- Maintains insertion order
- Dynamic size
- Allows one null value
- Slightly slower than HashSet
- Not synchronized

---

# Creating a LinkedHashSet

```java
Set<String> set =
        new LinkedHashSet<>();
```

or

```java
LinkedHashSet<String> set =
        new LinkedHashSet<>();
```

Preferred

```java
Set<String> set =
        new LinkedHashSet<>();
```

---

# Adding Elements

```java
Set<String> set =
        new LinkedHashSet<>();

set.add("Java");

set.add("Spring");

set.add("SQL");

set.add("Java");
```

Output

```text
Java

Spring

SQL
```

Duplicate `"Java"` is ignored.

Insertion order is preserved.

---

# Removing Elements

```java
set.remove("Spring");
```

---

# Checking Elements

```java
set.contains("SQL");
```

Output

```text
true
```

---

# Traversing a LinkedHashSet

### Enhanced For Loop

```java
for(String language : set){

    System.out.println(language);

}
```

Output

```text
Java

Spring

SQL
```

Notice that the insertion order is maintained.

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

LinkedHashSet internally uses

```text
LinkedHashSet

↓

LinkedHashMap

↓

Hash Table

+

Doubly Linked List
```

The Hash Table provides fast searching.

The Linked List maintains insertion order.

---

# Memory Representation

Suppose

```java
set.add("Java");

set.add("Spring");

set.add("SQL");
```

Internally

```text
Hash Table

↓

Java

Spring

SQL

↓

Linked List

Java ↔ Spring ↔ SQL
```

Both structures work together.

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

Only one `"Java"` is stored.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| add() | O(1) Average |
| remove() | O(1) Average |
| contains() | O(1) Average |
| search | O(1) Average |

Performance is slightly slower than `HashSet` because of maintaining the linked list.

---

# HashSet vs LinkedHashSet

| HashSet | LinkedHashSet |
|----------|---------------|
| No order | Maintains insertion order |
| Faster | Slightly slower |
| Hash Table | Hash Table + Linked List |
| One null | One null |

---

# LinkedHashSet vs TreeSet

| LinkedHashSet | TreeSet |
|---------------|----------|
| Insertion order | Sorted order |
| O(1) Average | O(log n) |
| Hash Table | Red-Black Tree |

---

# Production Usage

LinkedHashSet is commonly used in

- Recently viewed products
- Browser history
- Ordered unique records
- Menu items
- Navigation history
- Caching
- API responses where duplicates must be removed but order should remain

Example

```java
Set<String> recentSearches =
        new LinkedHashSet<>();
```

---

# Advantages

- Maintains insertion order
- No duplicate elements
- Fast searching
- Dynamic size
- Easy traversal

---

# Limitations

- Slightly slower than HashSet
- No sorting
- No index-based access
- Not thread-safe

---

# Best Practices

✅ Use LinkedHashSet when insertion order matters.

---

✅ Use HashSet if ordering is not required.

---

✅ Override `equals()` and `hashCode()` for custom objects.

---

# Common Mistakes

❌ Expecting sorted order.

LinkedHashSet maintains insertion order, **not sorted order**.

---

❌ Forgetting to override `equals()` and `hashCode()`.

Custom objects may appear duplicated.

---

❌ Using LinkedHashSet when TreeSet is required.

TreeSet should be used for sorted data.

---

# Interview Questions

### 1. What is LinkedHashSet?

LinkedHashSet is a Set implementation that maintains insertion order while storing unique elements.

---

### 2. Does LinkedHashSet allow duplicates?

No.

---

### 3. Does LinkedHashSet maintain insertion order?

Yes.

---

### 4. Does LinkedHashSet allow null values?

Yes.

Only one null value.

---

### 5. What does LinkedHashSet use internally?

A Hash Table and a Doubly Linked List (implemented via `LinkedHashMap`).

---

### 6. Which is faster, HashSet or LinkedHashSet?

HashSet is slightly faster because it doesn't maintain insertion order.

---

### 7. Does LinkedHashSet sort elements?

No.

It preserves insertion order.

---

### 8. What is the average time complexity of `add()`?

**O(1)**

---

### 9. Why should `equals()` and `hashCode()` be overridden?

To correctly identify duplicate custom objects.

---

### 10. Where is LinkedHashSet used in real-world applications?

- Browser history
- Recently viewed items
- Ordered unique records
- Navigation menus
- API responses

---

# Quick Revision

- LinkedHashSet implements the Set interface.
- Stores unique elements.
- Maintains insertion order.
- Uses a Hash Table + Doubly Linked List internally.
- Allows one null value.
- Average complexity:
  - add() → O(1)
  - remove() → O(1)
  - contains() → O(1)
- Best when uniqueness and insertion order are both required.

---

# Keywords

- LinkedHashSet
- Set
- LinkedHashMap
- Hash Table
- Doubly Linked List
- Insertion Order
- Unique Elements
- hashCode()
- equals()
- Java Collections
- O(1)