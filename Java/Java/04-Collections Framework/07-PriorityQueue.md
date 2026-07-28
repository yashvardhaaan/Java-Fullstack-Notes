# PriorityQueue

## What is a PriorityQueue?

A **PriorityQueue** is a class in the Java Collections Framework that implements the **Queue** interface.

Unlike a normal Queue, elements are **not processed in the order they are inserted**.

Instead, they are processed according to their **priority**.

By default:

- Smallest element has the highest priority (Min Heap)
- Elements are automatically sorted internally

> **Definition:** A PriorityQueue is a queue where elements are ordered based on their natural ordering or a custom comparator.

---

# Why Do We Need PriorityQueue?

Imagine a hospital.

Patients are treated based on the severity of their condition.

```text
Critical Patient

↓

Serious Patient

↓

Normal Patient
```

Even if the normal patient arrived first,

the critical patient gets treated first.

This is exactly how a PriorityQueue works.

---

# Real-World Example

Suppose jobs have priorities.

```text
Job A → Priority 5

Job B → Priority 1

Job C → Priority 3
```

Execution order

```text
Job B

↓

Job C

↓

Job A
```

Smaller priority value is processed first.

---

# Hierarchy

```text
Iterable
    │
Collection
    │
   Queue
      │
PriorityQueue
```

---

# Characteristics

- Orders elements automatically
- Duplicate elements allowed
- Does not maintain insertion order
- Does not allow null values
- Based on Heap
- Not synchronized

---

# Creating a PriorityQueue

```java
PriorityQueue<Integer> pq =
        new PriorityQueue<>();
```

or

```java
Queue<Integer> pq =
        new PriorityQueue<>();
```

Preferred

```java
Queue<Integer> pq =
        new PriorityQueue<>();
```

---

# Adding Elements

```java
Queue<Integer> pq =
        new PriorityQueue<>();

pq.offer(30);

pq.offer(10);

pq.offer(20);
```

Internally

```text
10

20

30
```

Even though 30 was inserted first,

10 comes first because it has higher priority.

---

# Removing Elements

```java
System.out.println(pq.poll());
```

Output

```text
10
```

Remaining

```text
20

30
```

---

# Viewing the Highest Priority Element

```java
System.out.println(pq.peek());
```

Output

```text
20
```

The element is not removed.

---

# Traversing a PriorityQueue

Enhanced For Loop

```java
for(Integer value : pq){

    System.out.println(value);

}
```

> **Note:** The iteration order is **not guaranteed to be sorted**.

To retrieve elements in priority order, repeatedly call `poll()`.

```java
while(!pq.isEmpty()){

    System.out.println(pq.poll());

}
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| offer() | Adds element |
| add() | Adds element |
| poll() | Removes highest priority element |
| remove() | Removes highest priority element |
| peek() | Returns highest priority element |
| element() | Returns highest priority element |
| size() | Returns size |
| isEmpty() | Checks if empty |
| clear() | Removes all elements |

---

# Internal Working

PriorityQueue is implemented using a **Binary Heap**.

By default,

Java uses a **Min Heap**.

```text
        10
       /  \
     20    30
    /
   40
```

The smallest element is always at the root.

---

# Heap Property

Every parent node is

```text
≤
```

its child nodes.

Example

```text
        5
      /   \
     8     9
    / \
   20 15
```

The root always contains the smallest element.

---

# Max Heap

To create a Max Heap,

use a comparator.

```java
PriorityQueue<Integer> pq =
        new PriorityQueue<>(Collections.reverseOrder());
```

Example

```java
pq.offer(10);
pq.offer(50);
pq.offer(20);
```

Removal order

```text
50

20

10
```

Largest element is removed first.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| offer() | O(log n) |
| poll() | O(log n) |
| peek() | O(1) |
| search | O(n) |

---

# Queue vs PriorityQueue

| Queue | PriorityQueue |
|--------|---------------|
| FIFO | Priority-based |
| Insertion order maintained | Priority order maintained |
| Uses Front & Rear | Uses Heap |

---

# PriorityQueue vs ArrayDeque

| PriorityQueue | ArrayDeque |
|---------------|------------|
| Priority-based | FIFO |
| Heap | Circular Array |
| Sorted internally | Insertion order |

---

# PriorityQueue with Custom Objects

Suppose we have a Student class.

```java
class Student{

    int marks;

    Student(int marks){

        this.marks = marks;

    }

}
```

Sort using Comparator.

```java
PriorityQueue<Student> pq =
    new PriorityQueue<>(
        (a, b) -> b.marks - a.marks
    );
```

Students with higher marks will come first.

---

# Production Usage

PriorityQueue is widely used in

- CPU Scheduling
- Task Scheduling
- Dijkstra's Algorithm
- Prim's Algorithm
- A* Search
- Event Scheduling
- Load Balancing

Example

```text
Incoming Tasks

↓

PriorityQueue

↓

Highest Priority Task

↓

Worker
```

---

# Advantages

- Automatic ordering
- Fast retrieval of highest priority element
- Efficient heap implementation
- Dynamic size
- Excellent for scheduling problems

---

# Limitations

- No random access
- No guaranteed sorted iteration
- Slower insertion than a normal Queue
- Does not allow null elements

---

# Best Practices

✅ Use PriorityQueue for priority-based processing.

---

✅ Use Comparator for custom ordering.

```java
PriorityQueue<Employee> pq =
    new PriorityQueue<>(
        Comparator.comparing(Employee::getSalary)
    );
```

---

✅ Use `poll()` to retrieve elements in priority order.

---

# Common Mistakes

❌ Assuming iteration is sorted.

```java
for(Integer x : pq)
```

does **not** guarantee sorted order.

---

❌ Expecting FIFO behavior.

PriorityQueue ignores insertion order.

---

❌ Adding null values.

```java
pq.offer(null);
```

Throws

```text
NullPointerException
```

---

# Interview Questions

### 1. What is a PriorityQueue?

A PriorityQueue is a queue that processes elements according to their priority instead of insertion order.

---

### 2. What data structure does PriorityQueue use internally?

A Binary Heap (Min Heap by default).

---

### 3. Does PriorityQueue maintain insertion order?

No.

---

### 4. Does PriorityQueue allow duplicate elements?

Yes.

---

### 5. Does PriorityQueue allow null values?

No.

---

### 6. What is the default ordering?

Natural ordering (Min Heap).

---

### 7. How do you create a Max Heap?

```java
PriorityQueue<Integer> pq =
        new PriorityQueue<>(Collections.reverseOrder());
```

---

### 8. What is the time complexity of `offer()`?

**O(log n)**

---

### 9. What is the time complexity of `peek()`?

**O(1)**

---

### 10. Where is PriorityQueue used in real-world applications?

- CPU scheduling
- Task scheduling
- Dijkstra's algorithm
- Event scheduling
- Load balancing
- Path-finding algorithms

---

# Quick Revision

- Implements the `Queue` interface.
- Uses a **Binary Heap** internally.
- Default is **Min Heap**.
- Does not maintain insertion order.
- Allows duplicate elements.
- Does not allow null values.
- `offer()` → **O(log n)**
- `poll()` → **O(log n)**
- `peek()` → **O(1)**
- Used in scheduling and graph algorithms.

---

# Keywords

- PriorityQueue
- Queue
- Binary Heap
- Min Heap
- Max Heap
- Comparator
- Natural Ordering
- offer()
- poll()
- peek()
- Dijkstra
- CPU Scheduling
- Java Collections
- O(log n)