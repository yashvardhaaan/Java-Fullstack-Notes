# Stack

## What is Stack?

A **Stack** is a linear data structure that follows the **LIFO (Last In, First Out)** principle.

This means the **last element added is the first one removed**.

> **Definition:** A Stack is a collection where insertion and deletion happen only at one end called the **Top**.

---

# Why Do We Need Stack?

Suppose you're editing a document.

Every action is stored.

```text
Type A

↓

Type B

↓

Type C
```

When you press **Undo**,

the last action (**Type C**) is removed first.

This is exactly how a Stack works.

---

# Real-World Example

Imagine a stack of plates.

```text
Top

↓

Plate 4

Plate 3

Plate 2

Plate 1
```

You can only

- Add a plate on top.
- Remove the top plate.

You cannot remove the middle plate directly.

---

# Stack Hierarchy

```text
Iterable
    │
Collection
    │
   List
    │
 Vector
    │
 Stack
```

`Stack` is a **legacy class** that extends `Vector`.

Nowadays,

Java developers usually prefer

```java
Deque<Integer> stack =
        new ArrayDeque<>();
```

for stack operations.

---

# Characteristics

- Follows LIFO
- Insert at Top
- Delete from Top
- Allows duplicate elements
- Allows null values (legacy `Stack`)
- Dynamic size

---

# Creating a Stack

Legacy Stack

```java
Stack<Integer> stack =
        new Stack<>();
```

Recommended

```java
Deque<Integer> stack =
        new ArrayDeque<>();
```

---

# Push Operation

Adds an element to the top.

```java
Stack<Integer> stack =
        new Stack<>();

stack.push(10);

stack.push(20);

stack.push(30);
```

Stack

```text
Top

↓

30

20

10
```

---

# Pop Operation

Removes the top element.

```java
stack.pop();
```

Before

```text
30

20

10
```

After

```text
20

10
```

Output

```text
30
```

---

# Peek Operation

Returns the top element without removing it.

```java
System.out.println(stack.peek());
```

Output

```text
20
```

Stack remains unchanged.

---

# Search Operation

Searches an element.

```java
stack.search(10);
```

Returns

```text
2
```

Position counting starts from the top.

---

# Empty Stack

```java
stack.empty();
```

Returns

```text
true
```

if the stack has no elements.

---

# Traversing a Stack

Using Enhanced For Loop

```java
for(Integer value : stack){

    System.out.println(value);

}
```

---

Using Iterator

```java
Iterator<Integer> itr =
        stack.iterator();

while(itr.hasNext()){

    System.out.println(itr.next());

}
```

---

# Common Methods

| Method | Description |
|---------|-------------|
| push() | Adds element |
| pop() | Removes top element |
| peek() | Returns top element |
| search() | Searches element |
| empty() | Checks if stack is empty |
| size() | Returns size |

---

# Memory Representation

Suppose

```java
stack.push(10);

stack.push(20);

stack.push(30);
```

Memory

```text
Top

↓

30

↓

20

↓

10
```

Only the top element can be accessed directly.

---

# Internal Working

Internally,

`Stack` extends `Vector`.

```text
Stack

↓

Vector

↓

Dynamic Array
```

When you call

```java
stack.push(40);
```

Internally

```text
Vector.addElement()

↓

Store Element

↓

Top Updated
```

Similarly,

```java
stack.pop();
```

Internally

```text
Return Top Element

↓

Remove Top

↓

Top Updated
```

---

# Time Complexity

| Operation | Complexity |
|------------|------------|
| push() | O(1) |
| pop() | O(1) |
| peek() | O(1) |
| search() | O(n) |

---

# Stack vs Queue

| Stack | Queue |
|--------|-------|
| LIFO | FIFO |
| One end | Two ends |
| push(), pop() | offer(), poll() |

---

# Stack vs ArrayList

| Stack | ArrayList |
|--------|-----------|
| LIFO | General List |
| Top operations | Index operations |
| Specialized | General-purpose |

---

# Why ArrayDeque is Preferred?

`Stack` is a legacy class.

`ArrayDeque` is

- Faster
- Not synchronized
- Better performance
- Recommended by Oracle

Example

```java
Deque<Integer> stack =
        new ArrayDeque<>();

stack.push(10);

stack.pop();
```

---

# Production Usage

Stacks are widely used in

- Undo/Redo
- Browser Back button
- Function Call Stack
- Expression Evaluation
- DFS (Depth First Search)
- Backtracking
- Compiler Parsing

Example

```text
main()

↓

login()

↓

validate()

↓

database()
```

Each method call is stored on the **Call Stack**.

---

# Advantages

- Fast insertion
- Fast deletion
- Simple implementation
- Efficient memory usage
- Ideal for LIFO problems

---

# Limitations

- Only top element is directly accessible
- Searching is linear
- Legacy implementation (`Stack`)
- Not suitable for random access

---

# Best Practices

✅ Prefer `ArrayDeque` instead of `Stack`.

✅ Use Stack only for LIFO problems.

✅ Check if the stack is empty before calling `pop()`.

```java
if(!stack.isEmpty()){

    stack.pop();

}
```

---

# Common Mistakes

❌ Calling

```java
stack.pop();
```

on an empty stack.

Throws

```text
EmptyStackException
```

---

❌ Using Stack where Queue is required.

---

❌ Using Stack for random access.

---

# Interview Questions

### 1. What is Stack?

A Stack is a linear data structure that follows the LIFO principle.

---

### 2. What does LIFO mean?

Last In, First Out.

The last inserted element is removed first.

---

### 3. What are the main Stack operations?

- push()
- pop()
- peek()

---

### 4. Which class does Stack extend?

`Vector`.

---

### 5. Why is Stack considered a legacy class?

Because Java recommends using `Deque` (`ArrayDeque`) instead for stack operations.

---

### 6. What is the time complexity of push()?

**O(1)**

---

### 7. What happens if pop() is called on an empty stack?

It throws

```text
EmptyStackException
```

---

### 8. What is the difference between pop() and peek()?

| pop() | peek() |
|--------|---------|
| Removes top element | Only returns top element |

---

### 9. Where is Stack used in Java internally?

The JVM uses a **Call Stack** to manage method calls.

---

### 10. Where is Stack used in real projects?

- Undo/Redo
- Browser history
- DFS
- Expression evaluation
- Backtracking
- Function call management

---

# Quick Revision

- Stack follows **LIFO**.
- Insert and delete happen at the **Top**.
- Main operations:
  - push()
  - pop()
  - peek()
- `Stack` extends `Vector`.
- Prefer `ArrayDeque` for new applications.
- Used in DFS, Undo, Browser Back, and JVM Call Stack.

---

# Keywords

- Stack
- LIFO
- push()
- pop()
- peek()
- Top
- Vector
- ArrayDeque
- Call Stack
- DFS
- Backtracking
- Java Collections
- O(1)