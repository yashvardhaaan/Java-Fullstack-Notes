# TreeSet

## What is a TreeSet?

**TreeSet** is a class in the Java Collections Framework that implements the **Set** interface.

It stores **unique elements** in **sorted order**.

Unlike `HashSet` and `LinkedHashSet`, a TreeSet automatically sorts elements whenever they are added.

Internally, TreeSet uses a **Red-Black Tree**, which is a self-balancing Binary Search Tree.

> **Definition:** TreeSet is a Set implementation that stores unique elements in sorted order using a Red-Black Tree.

---

# Why Do We Need TreeSet?

Suppose you're storing student marks.

Without sorting

```text
85

60

95

75
```

Finding the highest or lowest mark becomes difficult.

Instead,

```java
Set<Integer> marks =
        new TreeSet<>();
```

Output

```text
60

75

85

95
```

The elements are automatically sorted.

---

# Real-World Example

Imagine a dictionary.

```text
Apple

Banana

Cat

Dog
```

Words are arranged alphabetically.

Similarly,

TreeSet stores elements in sorted order.

---

# Hierarchy

```text
Iterable
    │
Collection
    │
   Set
    │
 NavigableSet
    │
 SortedSet
    │
 TreeSet
```

TreeSet implements both

- SortedSet
- NavigableSet

---

# Characteristics

- Stores unique elements
- Automatically sorts elements
- Does not allow duplicate values
- Does not allow null values
- Slower than HashSet
- Uses Red-Black Tree
- Not synchronized

---

# Creating a TreeSet

```java
Set<Integer> set =
        new TreeSet<>();
```

or

```java
TreeSet<Integer> set =
        new TreeSet<>();
```

Preferred

```java
Set<Integer> set =
        new TreeSet<>();
```

---

# Adding Elements

```java
Set<Integer> set =
        new TreeSet<>();

set.add(50);

set.add(20);

set.add(80);

set.add(10);
```

Output

```text
10

20

50

80
```

Notice

Elements are sorted automatically.

---

# Duplicate Elements

```java
set.add(20);

set.add(20);
```

Output

```text
20
```

Duplicates are ignored.

---

# Removing Elements

```java
set.remove(50);
```

---

# Checking Elements

```java
set.contains(20);
```

Output

```text
true
```

---

# Traversing a TreeSet

### Enhanced For Loop

```java
for(Integer number : set){

    System.out.println(number);

}
```

Output

```text
10

20

50

80
```

---

### Iterator

```java
Iterator<Integer> itr =
        set.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

---

### Descending Order

```java
for(Integer number : set.descendingSet()){

    System.out.println(number);

}
```

Output

```text
80

50

20

10
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| add() | Adds element |
| remove() | Removes element |
| contains() | Checks element |
| first() | Returns smallest element |
| last() | Returns largest element |
| higher() | Returns next greater element |
| lower() | Returns next smaller element |
| ceiling() | Returns equal or greater element |
| floor() | Returns equal or smaller element |
| pollFirst() | Removes smallest element |
| pollLast() | Removes largest element |

---

# Internal Working

TreeSet internally uses

```text
TreeSet

↓

TreeMap

↓

Red-Black Tree
```

Each element becomes a key in an internal `TreeMap`.

---

# Red-Black Tree

Example

```text
        50
       /  \
     20    80
    / \    / \
  10 30 70 90
```

The tree remains balanced after every insertion and deletion.

This ensures efficient operations.

---

# Sorting Process

Suppose

```java
set.add(40);

set.add(10);

set.add(30);

set.add(20);
```

Internally

```text
Insert

↓

Compare

↓

Move Left / Right

↓

Insert

↓

Balance Tree
```

The tree automatically stays balanced.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| add() | O(log n) |
| remove() | O(log n) |
| contains() | O(log n) |
| first() | O(log n) |
| last() | O(log n) |

---

# HashSet vs LinkedHashSet vs TreeSet

| Feature | HashSet | LinkedHashSet | TreeSet |
|---------|----------|---------------|----------|
| Duplicate | No | No | No |
| Order | No | Insertion | Sorted |
| Internal DS | Hash Table | Hash Table + Linked List | Red-Black Tree |
| Complexity | O(1) | O(1) | O(log n) |
| Null | One | One | No |

---

# TreeSet vs ArrayList

| TreeSet | ArrayList |
|----------|-----------|
| Sorted | Insertion Order |
| No duplicates | Duplicates allowed |
| O(log n) search | O(n) search |
| Tree | Dynamic Array |

---

# Custom Sorting

TreeSet can use a Comparator.

Ascending

```java
TreeSet<Integer> set =
        new TreeSet<>();
```

Descending

```java
TreeSet<Integer> set =
        new TreeSet<>(Collections.reverseOrder());
```

Example

```java
set.add(10);

set.add(40);

set.add(20);
```

Output

```text
40

20

10
```

---

# Production Usage

TreeSet is commonly used in

- Leaderboards
- Rankings
- Scheduling systems
- Sorted reports
- Auto-complete systems
- Student rankings
- Financial applications

Example

```java
Set<Integer> rankings =
        new TreeSet<>();
```

---

# Advantages

- Automatically sorted
- No duplicate elements
- Efficient searching
- Rich navigation methods
- Balanced tree implementation

---

# Limitations

- Slower than HashSet
- No null values
- No index-based access
- More memory usage

---

# Best Practices

✅ Use TreeSet when sorted data is required.

---

✅ Use HashSet when sorting is not needed.

---

✅ Use Comparator for custom ordering.

---

# Common Mistakes

❌ Assuming TreeSet maintains insertion order.

It maintains **sorted order**, not insertion order.

---

❌ Adding null values.

```java
set.add(null);
```

Throws

```text
NullPointerException
```

---

❌ Storing objects without implementing Comparable or providing a Comparator.

May throw

```text
ClassCastException
```

---

# Interview Questions

### 1. What is TreeSet?

TreeSet is a Set implementation that stores unique elements in sorted order using a Red-Black Tree.

---

### 2. Does TreeSet allow duplicate elements?

No.

---

### 3. Does TreeSet maintain insertion order?

No.

It maintains sorted order.

---

### 4. What data structure does TreeSet use internally?

A Red-Black Tree (through TreeMap).

---

### 5. Does TreeSet allow null values?

No.

---

### 6. What is the time complexity of `add()`?

**O(log n)**

---

### 7. Which interfaces does TreeSet implement?

- SortedSet
- NavigableSet

---

### 8. How can you sort in descending order?

```java
TreeSet<Integer> set =
        new TreeSet<>(Collections.reverseOrder());
```

---

### 9. Why is TreeSet slower than HashSet?

Because maintaining a balanced tree requires **O(log n)** operations, while HashSet uses hashing with **O(1)** average time.

---

### 10. Where is TreeSet used in real-world applications?

- Rankings
- Leaderboards
- Sorted reports
- Scheduling systems
- Financial applications

---

# Quick Revision

- TreeSet implements the Set interface.
- Uses a **Red-Black Tree** internally.
- Stores unique elements.
- Maintains sorted order.
- No null values.
- Supports navigation methods like:
  - first()
  - last()
  - higher()
  - lower()
  - ceiling()
  - floor()
- Time complexity:
  - add() → O(log n)
  - remove() → O(log n)
  - contains() → O(log n)

---

# Keywords

- TreeSet
- Set
- SortedSet
- NavigableSet
- Red-Black Tree
- TreeMap
- Sorted Order
- Comparator
- Comparable
- first()
- last()
- higher()
- lower()
- O(log n)
- Java Collections
```