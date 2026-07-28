# Deque (Double Ended Queue)

## What is a Deque?

**Deque** stands for **Double Ended Queue**.

It is an interface in the Java Collections Framework that allows **insertion and deletion from both the front and the rear**.

Unlike a normal Queue, a Deque can work as both a:

- Queue (FIFO)
- Stack (LIFO)

> **Definition:** A Deque is a linear collection that supports adding and removing elements from both ends efficiently.

---

# Why Do We Need Deque?

Suppose we have a browser history.

You can

- Go Forward
- Go Back

Both operations happen from different ends.

A normal Queue cannot efficiently support this.

Deque solves this problem.

---

# Real-World Example

Imagine a train.

```text
Front

↓

Coach 1

Coach 2

Coach 3

↑

Rear
```

You can

- Attach a coach at the front
- Attach a coach at the rear
- Remove from the front
- Remove from the rear

This is exactly how a Deque works.

---

# Hierarchy

```text
Iterable
    │
Collection
    │
   Queue
      │
    Deque
      │
 ┌────┴──────────┐
 │               │
ArrayDeque   LinkedList
```

Common implementations are

- ArrayDeque
- LinkedList

---

# Characteristics

- Double-ended insertion
- Double-ended deletion
- Dynamic size
- Duplicate elements allowed
- Usually does not allow null elements (ArrayDeque)
- Can behave as both Queue and Stack
- Not synchronized

---

# Creating a Deque

Using ArrayDeque

```java
Deque<Integer> deque =
        new ArrayDeque<>();
```

Using LinkedList

```java
Deque<Integer> deque =
        new LinkedList<>();
```

Preferred

```java
Deque<Integer> deque =
        new ArrayDeque<>();
```

---

# Adding Elements

Add at Front

```java
deque.addFirst(10);

deque.addFirst(20);
```

Deque

```text
Front

↓

20 → 10

↑

Rear
```

---

Add at Rear

```java
deque.addLast(30);

deque.addLast(40);
```

Deque

```text
Front

↓

20 → 10 → 30 → 40

                   ↑

                 Rear
```

---

# Removing Elements

Remove from Front

```java
deque.removeFirst();
```

Output

```text
20
```

Remaining

```text
10 → 30 → 40
```

---

Remove from Rear

```java
deque.removeLast();
```

Output

```text
40
```

Remaining

```text
10 → 30
```

---

# Viewing Elements

Front

```java
System.out.println(deque.peekFirst());
```

Output

```text
10
```

---

Rear

```java
System.out.println(deque.peekLast());
```

Output

```text
30
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| addFirst() | Insert at front |
| addLast() | Insert at rear |
| offerFirst() | Insert at front |
| offerLast() | Insert at rear |
| removeFirst() | Remove front |
| removeLast() | Remove rear |
| pollFirst() | Remove front safely |
| pollLast() | Remove rear safely |
| peekFirst() | View front |
| peekLast() | View rear |

---

# Using Deque as Queue

FIFO

```java
Deque<Integer> deque =
        new ArrayDeque<>();

deque.offerLast(10);

deque.offerLast(20);

deque.offerLast(30);

System.out.println(deque.pollFirst());
```

Output

```text
10
```

---

# Using Deque as Stack

LIFO

```java
Deque<Integer> deque =
        new ArrayDeque<>();

deque.push(10);

deque.push(20);

deque.push(30);

System.out.println(deque.pop());
```

Output

```text
30
```

---

# Internal Working

### ArrayDeque

Internally uses a **Resizable Circular Array**.

```text
Front

↓

10

20

30

↑

Rear
```

When the array becomes full,

it automatically creates a larger array.

---

### LinkedList

Stores elements as

```text
Previous

↓

Data

↓

Next
```

using a Doubly Linked List.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| addFirst() | O(1) |
| addLast() | O(1) |
| removeFirst() | O(1) |
| removeLast() | O(1) |
| peekFirst() | O(1) |
| peekLast() | O(1) |

---

# Queue vs Deque

| Queue | Deque |
|--------|-------|
| Insert at rear | Insert at both ends |
| Remove from front | Remove from both ends |
| FIFO | FIFO or LIFO |

---

# Stack vs Deque

| Stack | Deque |
|--------|-------|
| Legacy class | Modern interface |
| LIFO only | FIFO and LIFO |
| Extends Vector | Separate interface |

Oracle recommends using **Deque** instead of the legacy `Stack` class.

---

# ArrayDeque vs LinkedList

| ArrayDeque | LinkedList |
|-------------|------------|
| Circular Array | Doubly Linked List |
| Faster | Slightly slower |
| Less memory | More memory |
| No null values | Allows null values |

---

# Production Usage

Deque is widely used in

- Browser history
- Undo/Redo
- Sliding Window Algorithm
- BFS
- DFS
- LRU Cache
- Task scheduling

Example

```text
Recent Pages

↓

Deque

↓

Back / Forward Navigation
```

---

# Advantages

- Fast insertion
- Fast deletion
- Can work as Queue
- Can work as Stack
- Efficient implementation

---

# Limitations

- No random index access
- Search is O(n)
- Not thread-safe

---

# Best Practices

✅ Prefer `ArrayDeque` over `Stack`.

---

✅ Use `offerFirst()` and `offerLast()` when possible.

---

✅ Use `pollFirst()` instead of `removeFirst()` if the deque may be empty.

---

# Common Mistakes

❌ Using `removeFirst()` on an empty deque.

Throws

```text
NoSuchElementException
```

Use

```java
pollFirst();
```

instead.

---

❌ Using `ArrayDeque` to store null values.

```java
deque.add(null);
```

Throws

```text
NullPointerException
```

---

❌ Using Deque when random index access is needed.

Use `ArrayList` instead.

---

# Interview Questions

### 1. What is a Deque?

A Deque is a double-ended queue that allows insertion and deletion from both ends.

---

### 2. What does Deque stand for?

Double Ended Queue.

---

### 3. Which interfaces does Deque extend?

It extends the `Queue` interface.

---

### 4. Which are the common implementations of Deque?

- ArrayDeque
- LinkedList

---

### 5. Can Deque be used as a Stack?

Yes.

Using `push()`, `pop()`, and `peek()`.

---

### 6. Can Deque be used as a Queue?

Yes.

Using `offerLast()` and `pollFirst()`.

---

### 7. Which implementation is faster?

`ArrayDeque` is generally faster than `LinkedList`.

---

### 8. Does ArrayDeque allow null values?

No.

---

### 9. What is the time complexity of insertion and deletion?

**O(1)** at both ends.

---

### 10. Where is Deque used in real-world applications?

- Browser history
- Undo/Redo
- Sliding Window
- LRU Cache
- BFS
- DFS
- Scheduling

---

# Quick Revision

- Deque = Double Ended Queue.
- Extends `Queue`.
- Insert and remove from both ends.
- Can work as:
  - Queue (FIFO)
  - Stack (LIFO)
- Common implementations:
  - ArrayDeque
  - LinkedList
- Prefer `ArrayDeque`.
- Most operations are **O(1)**.

---

# Keywords

- Deque
- Double Ended Queue
- ArrayDeque
- LinkedList
- FIFO
- LIFO
- addFirst()
- addLast()
- removeFirst()
- removeLast()
- push()
- pop()
- Queue
- Stack
- Java Collections