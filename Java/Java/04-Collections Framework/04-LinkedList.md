# LinkedList

## What is a LinkedList?

**LinkedList** is a class in the Java Collections Framework that implements both the **List** and **Deque** interfaces.

Unlike `ArrayList`, LinkedList **does not store elements in a continuous array**.

Instead, it stores elements as **nodes** connected using links (references).

A LinkedList:

- Maintains insertion order
- Allows duplicate elements
- Allows null values
- Supports fast insertion and deletion
- Supports both List and Queue operations

> **Definition:** LinkedList is a doubly linked list implementation of the List and Deque interfaces that stores elements as linked nodes.

---

# Why Do We Need LinkedList?

Suppose we have an ArrayList.

```java
ArrayList<Integer> list =
        new ArrayList<>();
```

Insert an element at index 0.

```java
list.add(0, 100);
```

Internally,

every element shifts one position.

```text
10 20 30 40

↓

100 10 20 30 40
```

Many elements are moved.

This becomes slow for large collections.

LinkedList avoids shifting by changing links.

---

# Real-World Example

Imagine a train.

```text
Engine

↓

Coach 1

↓

Coach 2

↓

Coach 3
```

Each coach knows

- Previous coach
- Next coach

Removing one coach only changes the links.

Similarly,

LinkedList stores elements as connected nodes.

---

# Hierarchy

```text
Iterable
    │
Collection
    │
   List
    │
LinkedList
```

Also

```text
Deque
   │
LinkedList
```

LinkedList can work as

- List
- Queue
- Deque
- Stack

---

# Characteristics

- Ordered collection
- Duplicate elements allowed
- Dynamic size
- Fast insertion
- Fast deletion
- Slow random access
- Allows null values
- Not synchronized

---

# Creating a LinkedList

```java
List<String> list =
        new LinkedList<>();
```

or

```java
LinkedList<String> list =
        new LinkedList<>();
```

Preferred

```java
List<String> list =
        new LinkedList<>();
```

---

# Adding Elements

```java
List<String> list =
        new LinkedList<>();

list.add("Java");

list.add("Spring");

list.add("Java");
```

Output

```text
Java

Spring

Java
```

Duplicates are allowed.

---

# Accessing Elements

```java
System.out.println(list.get(1));
```

Output

```text
Spring
```

Unlike ArrayList,

LinkedList must traverse the nodes.

---

# Updating Elements

```java
list.set(1, "Spring Boot");
```

Output

```text
Java

Spring Boot

Java
```

---

# Removing Elements

By index

```java
list.remove(1);
```

By object

```java
list.remove("Java");
```

---

# Traversing a LinkedList

### For Loop

```java
for(int i = 0; i < list.size(); i++){

    System.out.println(list.get(i));

}
```

---

### Enhanced For Loop

```java
for(String s : list){

    System.out.println(s);

}
```

---

### Iterator

```java
Iterator<String> itr =
        list.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

---

### Java 8 forEach

```java
list.forEach(System.out::println);
```

---

# Internal Structure

Each node stores

```text
Previous

↓

Data

↓

Next
```

A LinkedList is a **Doubly Linked List**.

---

# Memory Representation

Suppose

```java
LinkedList<Integer> list =
        new LinkedList<>();
```

After adding

```java
10

20

30
```

Memory

```text
Head

↓

┌──────────────┐
│null│10│ •────┼────────┐
└──────────────┘        │
                        ▼
                 ┌──────────────┐
                 │ • │20│ •─────┼──────┐
                 └──────────────┘      │
                                       ▼
                                ┌──────────────┐
                                │ • │30│ null │
                                └──────────────┘

Tail
```

Each node stores

- Previous reference
- Data
- Next reference

---

# How Insertion Works

Insert

```java
list.add(1,15);
```

Before

```text
10

↓

20

↓

30
```

After

```text
10

↓

15

↓

20

↓

30
```

Only references are updated.

No shifting occurs.

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| get() | O(n) |
| add() at end | O(1) |
| add() at beginning | O(1) |
| add() in middle | O(n)* |
| remove() at beginning | O(1) |
| remove() at end | O(1) |
| search | O(n) |

> *Finding the insertion position takes O(n). Once found, updating links is O(1).

---

# ArrayList vs LinkedList

| ArrayList | LinkedList |
|------------|------------|
| Dynamic Array | Doubly Linked List |
| Fast get() | Slow get() |
| Slow insertion | Fast insertion |
| Less memory | More memory |
| Better cache locality | Poor cache locality |

---

# LinkedList vs Array

| Array | LinkedList |
|--------|------------|
| Fixed size | Dynamic |
| Fast access | Slow access |
| Difficult insertion | Easy insertion |

---

# Queue Operations

LinkedList implements Queue.

```java
Queue<Integer> queue =
        new LinkedList<>();

queue.offer(10);

queue.offer(20);

queue.poll();
```

---

# Stack Operations

LinkedList also supports Stack operations.

```java
LinkedList<Integer> stack =
        new LinkedList<>();

stack.push(10);

stack.push(20);

stack.pop();
```

---

# Internal Working

Suppose

```java
list.addFirst(100);
```

Internally

```text
Create Node

↓

New Node.next = Old Head

↓

Old Head.prev = New Node

↓

Head = New Node
```

Only references change.

Elements are **not shifted**.

---

# Production Usage

LinkedList is used when

- Frequent insertions
- Frequent deletions
- Queue implementation
- Deque implementation
- Browser history
- Undo/Redo systems

Spring applications often use queues internally where LinkedList can be an implementation choice.

---

# Advantages

- Fast insertion
- Fast deletion
- Dynamic size
- No shifting
- Implements List and Deque

---

# Limitations

- Slow random access
- More memory usage
- Poor cache locality
- Extra references increase overhead

---

# Best Practices

✅ Use LinkedList when insertions/deletions are frequent.

✅ Use ArrayList when random access is frequent.

✅ Use the `List` interface whenever possible.

```java
List<Integer> list =
        new LinkedList<>();
```

---

# Common Mistakes

❌ Using LinkedList for heavy index-based access.

```java
list.get(i);
```

inside a loop is inefficient.

---

❌ Assuming LinkedList is always faster.

It depends on the operation.

---

❌ Ignoring memory overhead.

Each node stores two extra references.

---

# Interview Questions

### 1. What is LinkedList?

LinkedList is a doubly linked list implementation of the List and Deque interfaces.

---

### 2. How does LinkedList store data?

Using nodes connected through previous and next references.

---

### 3. Does LinkedList allow duplicates?

Yes.

---

### 4. Does LinkedList maintain insertion order?

Yes.

---

### 5. Which is faster for random access?

ArrayList.

---

### 6. Which is faster for insertion and deletion?

LinkedList.

---

### 7. Why is LinkedList slower for `get()`?

Because it must traverse nodes to reach the required index.

---

### 8. Does LinkedList implement Queue?

Yes.

It implements both `List` and `Deque`, so it can be used as a Queue.

---

### 9. Is LinkedList synchronized?

No.

It is not thread-safe.

---

### 10. Where is LinkedList used in real projects?

It is commonly used in queues, deques, undo/redo functionality, browser history, and applications with frequent insertions and deletions.

---

# Quick Revision

- LinkedList uses a **Doubly Linked List**.
- Implements **List** and **Deque**.
- Maintains insertion order.
- Allows duplicates and null values.
- Fast insertion and deletion.
- Slow random access.
- Each node stores:
  - Previous reference
  - Data
  - Next reference
- Best for applications with frequent insertions/deletions.

---

# Keywords

- LinkedList
- Doubly Linked List
- Node
- Previous Pointer
- Next Pointer
- List
- Deque
- Queue
- Stack
- Dynamic Collection
- Java Collections
- Spring Boot
- O(1)
- O(n)