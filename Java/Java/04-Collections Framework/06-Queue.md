# Queue

## What is a Queue?

A **Queue** is a linear data structure that follows the **FIFO (First In, First Out)** principle.

This means the **first element added is the first one removed**.

> **Definition:** A Queue is a collection where elements are inserted at the **rear (tail)** and removed from the **front (head)**.

---

# Why Do We Need a Queue?

Imagine people standing in a ticket line.

```text
Rahul

↓

Amit

↓

Priya
```

Rahul came first.

So Rahul gets the ticket first.

This is exactly how a Queue works.

---

# Real-World Example

Think about a printer.

```text
Document A

↓

Document B

↓

Document C
```

The first document sent to the printer is printed first.

Similarly,

Queues process requests in the order they arrive.

---

# Queue Hierarchy

```text
Iterable
    │
Collection
    │
   Queue
      │
 ┌────┼───────────────┐
 │    │               │
LinkedList      PriorityQueue
 │
ArrayDeque
```

`Queue` is an **interface**.

Common implementations are

- LinkedList
- ArrayDeque
- PriorityQueue

---

# Characteristics

- Follows FIFO
- Insert at Rear
- Remove from Front
- Duplicate elements allowed
- Dynamic size
- Usually does not support index-based access

---

# Creating a Queue

Using LinkedList

```java
Queue<Integer> queue =
        new LinkedList<>();
```

Using ArrayDeque (Recommended)

```java
Queue<Integer> queue =
        new ArrayDeque<>();
```

---

# Adding Elements

Using `offer()`

```java
Queue<Integer> queue =
        new LinkedList<>();

queue.offer(10);

queue.offer(20);

queue.offer(30);
```

Queue

```text
Front

↓

10 → 20 → 30

            ↑

          Rear
```

---

# Removing Elements

Using `poll()`

```java
queue.poll();
```

Before

```text
10 → 20 → 30
```

After

```text
20 → 30
```

Output

```text
10
```

---

# Viewing Front Element

Using `peek()`

```java
System.out.println(queue.peek());
```

Output

```text
20
```

The element is **not removed**.

---

# Traversing a Queue

Enhanced For Loop

```java
for(Integer value : queue){

    System.out.println(value);

}
```

---

Iterator

```java
Iterator<Integer> itr =
        queue.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| offer() | Inserts element |
| add() | Inserts element (throws exception if it fails) |
| poll() | Removes front element |
| remove() | Removes front element (throws exception if empty) |
| peek() | Returns front element |
| element() | Returns front element (throws exception if empty) |
| size() | Returns size |
| isEmpty() | Checks if queue is empty |

---

# offer() vs add()

| offer() | add() |
|----------|-------|
| Returns false if insertion fails | Throws exception if insertion fails |
| Preferred | Less commonly used |

---

# poll() vs remove()

| poll() | remove() |
|----------|-----------|
| Returns null if empty | Throws NoSuchElementException |

---

# peek() vs element()

| peek() | element() |
|----------|------------|
| Returns null if empty | Throws NoSuchElementException |

---

# Internal Working

Using LinkedList

```java
Queue<Integer> queue =
        new LinkedList<>();
```

Memory

```text
Front

↓

10

↓

20

↓

30

↓

Rear
```

New elements are inserted at the rear.

Elements are removed from the front.

---

# Queue Operations

Insert

```java
queue.offer(40);
```

```text
10 → 20 → 30 → 40
```

---

Remove

```java
queue.poll();
```

```text
20 → 30 → 40
```

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| offer() | O(1) |
| poll() | O(1) |
| peek() | O(1) |
| search | O(n) |

---

# Queue vs Stack

| Queue | Stack |
|--------|-------|
| FIFO | LIFO |
| Front & Rear | Top |
| offer(), poll() | push(), pop() |

---

# Queue vs List

| Queue | List |
|--------|------|
| FIFO | Ordered Collection |
| No index access | Index-based access |
| Queue operations | General operations |

---

# Common Queue Implementations

### LinkedList

- Implements Queue
- Doubly Linked List
- Allows null elements

---

### ArrayDeque

- Faster than LinkedList for queue operations
- No null elements allowed
- Recommended for most queue use cases

---

### PriorityQueue

- Elements are processed according to priority
- Does **not** follow insertion order

---

# Production Usage

Queues are heavily used in

- Print queues
- Task scheduling
- CPU scheduling
- BFS (Breadth First Search)
- Message queues
- Request processing
- Job scheduling

Example

```text
Incoming API Requests

↓

Queue

↓

Worker Threads

↓

Database
```

This helps process requests efficiently.

---

# Advantages

- Simple implementation
- Fast insertion
- Fast deletion
- Efficient for FIFO operations
- Widely used in scheduling

---

# Limitations

- No random access
- Search is linear
- Only front element can be removed

---

# Best Practices

✅ Prefer `ArrayDeque` for queue implementations.

```java
Queue<Integer> queue =
        new ArrayDeque<>();
```

---

✅ Use `offer()`, `poll()`, and `peek()` instead of `add()`, `remove()`, and `element()` when possible.

---

✅ Always check for empty queues if using methods that throw exceptions.

---

# Common Mistakes

❌ Using Queue when LIFO behavior is required.

Use a Stack instead.

---

❌ Calling

```java
queue.remove();
```

on an empty queue.

Throws

```text
NoSuchElementException
```

---

❌ Assuming PriorityQueue maintains insertion order.

It orders elements by priority instead.

---

# Interview Questions

### 1. What is a Queue?

A Queue is a linear data structure that follows the FIFO principle.

---

### 2. What does FIFO mean?

First In, First Out.

The first inserted element is removed first.

---

### 3. What are the main Queue operations?

- offer()
- poll()
- peek()

---

### 4. Which interface does Queue extend?

`Collection`.

---

### 5. What is the difference between `offer()` and `add()`?

`offer()` returns `false` if insertion fails, while `add()` throws an exception.

---

### 6. What is the difference between `poll()` and `remove()`?

`poll()` returns `null` if the queue is empty, while `remove()` throws `NoSuchElementException`.

---

### 7. Which Queue implementation is recommended for most use cases?

`ArrayDeque`.

---

### 8. Does Queue allow duplicate elements?

Yes.

---

### 9. Where is Queue used in real-world applications?

- Task scheduling
- BFS
- Printer queues
- Message queues
- API request processing

---

### 10. What is the difference between Queue and Stack?

Queue follows FIFO, while Stack follows LIFO.

---

# Quick Revision

- Queue follows **FIFO**.
- Insert at the **Rear**.
- Remove from the **Front**.
- Main operations:
  - offer()
  - poll()
  - peek()
- Common implementations:
  - LinkedList
  - ArrayDeque
  - PriorityQueue
- Prefer `ArrayDeque` for better performance.
- Used in scheduling, BFS, and request processing.

---

# Keywords

- Queue
- FIFO
- Front
- Rear
- offer()
- poll()
- peek()
- LinkedList
- ArrayDeque
- PriorityQueue
- Scheduling
- BFS
- Java Collections
- O(1)