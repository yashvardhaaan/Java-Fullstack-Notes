# Collections Utility Class

## What is Collections?

**Collections** is a utility class in the Java Collections Framework.

It belongs to the

```text
java.util
```

package.

It provides **static methods** to perform operations on collections like:

- Sorting
- Searching
- Reversing
- Shuffling
- Finding maximum/minimum
- Synchronization
- Creating immutable collections

> **Definition:** Collections is a utility class that provides static methods to perform common operations on Java collections.

---

# Why Do We Need Collections?

Suppose you have a list of numbers.

```text
40

10

30

20
```

Without Collections,

you have to write your own sorting algorithm.

Instead,

```java
Collections.sort(list);
```

Java sorts the list automatically.

---

# Real-World Example

Imagine a deck of playing cards.

You may want to

- Shuffle cards
- Sort cards
- Reverse cards

Collections provides methods for all these operations.

---

# Collections vs Collection

| Collection | Collections |
|------------|-------------|
| Interface | Utility Class |
| Stores data | Performs operations |
| Implemented by List, Set, Queue | Contains static methods |
| Objects are created | Cannot be instantiated |

---

# Common Methods

| Method | Description |
|---------|-------------|
| sort() | Sorts a collection |
| reverse() | Reverses elements |
| shuffle() | Randomly shuffles elements |
| binarySearch() | Searches sorted list |
| max() | Finds maximum element |
| min() | Finds minimum element |
| frequency() | Counts occurrences |
| swap() | Swaps two elements |
| fill() | Replaces all elements |
| copy() | Copies one list to another |
| rotate() | Rotates elements |
| synchronizedList() | Creates synchronized list |
| unmodifiableList() | Creates read-only list |

---

# Sorting

```java
List<Integer> numbers = new ArrayList<>();

numbers.add(40);

numbers.add(10);

numbers.add(30);

numbers.add(20);

Collections.sort(numbers);

System.out.println(numbers);
```

Output

```text
[10, 20, 30, 40]
```

---

# Reverse Sorting

```java
Collections.sort(
        numbers,
        Collections.reverseOrder()
);
```

Output

```text
[40, 30, 20, 10]
```

---

# Reversing a List

```java
Collections.reverse(numbers);
```

Before

```text
[10, 20, 30, 40]
```

After

```text
[40, 30, 20, 10]
```

---

# Shuffling

```java
Collections.shuffle(numbers);
```

Output

```text
[20, 40, 10, 30]
```

Output changes every time.

---

# Binary Search

The list must be sorted.

```java
Collections.sort(numbers);

int index =
        Collections.binarySearch(numbers, 30);

System.out.println(index);
```

Output

```text
2
```

---

# Maximum Element

```java
int max =
        Collections.max(numbers);

System.out.println(max);
```

Output

```text
40
```

---

# Minimum Element

```java
int min =
        Collections.min(numbers);

System.out.println(min);
```

Output

```text
10
```

---

# Frequency

```java
List<String> list =
        Arrays.asList(
            "Java",
            "Spring",
            "Java"
        );

int count =
        Collections.frequency(
            list,
            "Java"
        );

System.out.println(count);
```

Output

```text
2
```

---

# Swapping Elements

```java
Collections.swap(numbers, 0, 2);
```

Before

```text
[10, 20, 30, 40]
```

After

```text
[30, 20, 10, 40]
```

---

# Filling Elements

```java
Collections.fill(numbers, 100);
```

Output

```text
[100, 100, 100, 100]
```

---

# Copying a List

```java
List<Integer> source =
        Arrays.asList(10, 20, 30);

List<Integer> destination =
        new ArrayList<>(
            Arrays.asList(0, 0, 0)
        );

Collections.copy(destination, source);

System.out.println(destination);
```

Output

```text
[10, 20, 30]
```

> **Note:** The destination list must already have at least the same size as the source list.

---

# Rotating Elements

```java
Collections.rotate(numbers, 2);
```

Before

```text
[10, 20, 30, 40]
```

After

```text
[30, 40, 10, 20]
```

---

# Synchronized List

```java
List<Integer> list =
        Collections.synchronizedList(
            new ArrayList<>()
        );
```

Useful when multiple threads access the same list.

---

# Unmodifiable List

```java
List<String> list =
        Collections.unmodifiableList(
            Arrays.asList(
                "Java",
                "Spring"
            )
        );
```

Trying to modify it

```java
list.add("SQL");
```

Throws

```text
UnsupportedOperationException
```

---

# Internal Working

Suppose

```java
Collections.sort(numbers);
```

Internally

```text
Collections.sort()

↓

TimSort

↓

Compare Elements

↓

Swap

↓

Sorted List
```

---

# Time Complexity

| Method | Complexity |
|---------|------------|
| sort() | O(n log n) |
| binarySearch() | O(log n) |
| reverse() | O(n) |
| shuffle() | O(n) |
| max() | O(n) |
| min() | O(n) |
| frequency() | O(n) |
| fill() | O(n) |
| rotate() | O(n) |
| swap() | O(1) |

---

# Production Usage

Collections utility methods are widely used in

- Sorting API responses
- Ranking systems
- Search features
- Data processing
- Caching
- Report generation
- Banking applications

Example

```java
Collections.sort(employeeList);
```

---

# Advantages

- Ready-made utility methods
- Reduces code
- Efficient implementations
- Easy to use
- Well-tested

---

# Limitations

- Most methods work only on collections
- Some methods require mutable collections
- `binarySearch()` requires sorted data

---

# Best Practices

✅ Use `Collections.sort()` instead of writing your own sorting algorithm.

---

✅ Sort the list before using `binarySearch()`.

---

✅ Use `Collections.unmodifiableList()` for read-only data.

---

✅ Use `Collections.synchronizedList()` only when thread safety is required.

---

# Common Mistakes

❌ Calling `binarySearch()` on an unsorted list.

Results are undefined.

---

❌ Using `Collections.copy()` with an empty destination list.

The destination list must already contain enough elements.

---

❌ Modifying an unmodifiable collection.

Throws

```text
UnsupportedOperationException
```

---

# Interview Questions

### 1. What is Collections?

Collections is a utility class that provides static methods for performing operations on collections.

---

### 2. Which package contains Collections?

```text
java.util
```

---

### 3. What is the difference between Collection and Collections?

- Collection is an interface.
- Collections is a utility class.

---

### 4. Which sorting algorithm does `Collections.sort()` use?

TimSort.

---

### 5. What is the time complexity of `Collections.sort()`?

**O(n log n)**

---

### 6. What is the time complexity of `Collections.binarySearch()`?

**O(log n)**

---

### 7. Can `Collections.shuffle()` guarantee the same order every time?

No.

It randomizes the order.

---

### 8. What happens if you modify an unmodifiable list?

`UnsupportedOperationException` is thrown.

---

### 9. When should `Collections.synchronizedList()` be used?

When multiple threads access the same list.

---

### 10. Where is the Collections utility class used?

- Sorting
- Searching
- Reversing
- Shuffling
- Data processing
- API development

---

# Quick Revision

- Collections is a utility class.
- Located in `java.util`.
- Contains only static methods.
- Common methods:
  - sort()
  - reverse()
  - shuffle()
  - binarySearch()
  - max()
  - min()
  - frequency()
  - swap()
  - fill()
  - copy()
  - rotate()
  - synchronizedList()
  - unmodifiableList()
- `Collections.sort()` uses TimSort.
- `binarySearch()` requires a sorted list.

---

# Keywords

- Collections
- Collection
- Utility Class
- sort()
- reverse()
- shuffle()
- binarySearch()
- max()
- min()
- frequency()
- rotate()
- copy()
- synchronizedList()
- unmodifiableList()
- TimSort
- java.util
- O(n log n)