# 05 — Queues.md

````md
# 05 — Queues: GATE CSE Notes, Tricks & PYQ Explanations

> **Target:** GATE CSE/IT  
> **Focus:** Queue ADT, FIFO, implementation, circular queue, deque, priority queue, queue using stacks, stack using queues, complexity, and GATE PYQ patterns.

---

# 0. GATE Strategy for Queues

Queue is a very important Data Structures topic.

The main idea is:

```text
Queue
  ↓
FIFO
  ↓
Insertion → Rear
Deletion  → Front
  ↓
Circular Queue
  ↓
Deque
  ↓
Priority Queue
  ↓
BFS
  ↓
Scheduling
````

GATE commonly asks:

* FIFO behavior
* Enqueue/dequeue sequences
* Queue implementation using arrays
* Circular queues
* Front/rear conditions
* Queue overflow/underflow
* Queue using linked lists
* Queue using stacks
* Stack using queues
* Deque
* Priority queue
* BFS
* Complexity
* Circular queue capacity
* Output-tracing questions

---

# 1. What is a Queue?

A queue is a linear data structure that follows:

> **FIFO — First In, First Out**

The element inserted first is removed first.

Example:

```text
10 → 20 → 30
↑          ↑
FRONT      REAR
```

If we perform:

```text
dequeue()
```

then:

```text
10
```

is removed.

---

# 2. Queue Operations

Main operations:

```text
enqueue()
dequeue()
front()
rear()
isEmpty()
isFull()
```

---

# 3. Enqueue

`enqueue(x)` inserts an element at the:

```text
REAR
```

Example:

```text
Before:

FRONT          REAR
 ↓               ↓
10 → 20 → 30
```

After:

```text
enqueue(40)

FRONT                 REAR
 ↓                      ↓
10 → 20 → 30 → 40
```

---

# 4. Dequeue

`dequeue()` removes an element from the:

```text
FRONT
```

Example:

```text
FRONT          REAR
 ↓               ↓
10 → 20 → 30
```

After dequeue:

```text
20 → 30
↑      ↑
F      R
```

Removed element:

```text
10
```

---

# 5. Queue ADT

Queue is an:

> **Abstract Data Type**

The ADT specifies operations:

```text
enqueue
dequeue
front
rear
```

but does not specify how the queue must be implemented.

Possible implementations:

```text
Array
Linked List
Circular Array
```

---

# 6. Queue vs Stack

| Feature               | Stack         | Queue         |
| --------------------- | ------------- | ------------- |
| Principle             | LIFO          | FIFO          |
| Insert                | Top           | Rear          |
| Delete                | Top           | Front         |
| Example               | Function call | Printer queue |
| Traversal application | DFS           | BFS           |

Golden memory trick:

```text
STACK → Last comes out first

QUEUE → First comes out first
```

---

# 7. Simple Array Queue

Suppose:

```c
int q[5];
int front = 0;
int rear = -1;
```

Initially:

```text
front = 0
rear = -1
```

Enqueue:

```c
q[++rear] = x;
```

Dequeue:

```c
x = q[front++];
```

---

# 8. Problem with Simple Array Queue

Suppose array size is:

```text
5
```

Perform:

```text
enqueue(10)
enqueue(20)
enqueue(30)
enqueue(40)
enqueue(50)
```

Array:

```text
10 20 30 40 50
```

Now dequeue three times:

```text
10
20
30
```

Logically:

```text
40 50
```

are still present.

But `rear` has reached the end of the array.

A simple implementation may incorrectly report:

```text
Queue Full
```

even though there is unused space at the beginning.

This is called:

> **False Overflow**

---

# 9. False Overflow

The unused positions created by dequeues cannot be reused in a simple linear-array implementation.

Example:

```text
[ ][ ][ ][40][50]
 ↑           ↑
unused       rear
```

There is free space, but the rear cannot move further right.

Solution:

> **Circular Queue**

---

# 10. Circular Queue

A circular queue treats the array as if the last position connects back to the first.

Conceptually:

```text
       +----------------+
       ↓                |
[0] [1] [2] [3] [4] ←--+
```

After the last index:

```text
n-1
```

we return to:

```text
0
```

---

# 11. Circular Queue Formula

For an array of size `n`:

```text
next position
=
(index + 1) % n
```

This is one of the most important GATE formulas.

Example:

```text
n = 5
```

If:

```text
index = 4
```

then:

```text
(4+1)%5
= 0
```

Therefore the next position is:

```text
0
```

---

# 12. Circular Queue Example

Array size:

```text
5
```

Suppose:

```text
FRONT = 2
REAR  = 4
```

Queue:

```text
index:
0  1  2  3  4

      30 40 50
      ↑      ↑
    FRONT   REAR
```

After inserting another element:

```text
rear = (4+1)%5
     = 0
```

So:

```text
index 0
```

is reused.

---

# 13. Circular Queue Structure

Example:

```text
Array:

+----+----+----+----+----+
| 60 |    | 30 | 40 | 50 |
+----+----+----+----+----+
  ↑           ↑
 REAR       FRONT
```

Logical order is:

```text
30 → 40 → 50 → 60
```

not physical left-to-right order.

## GATE Trick

In a circular queue:

> **Physical order and logical queue order can differ.**

---

# 14. Circular Queue Enqueue

General formula:

```text
rear = (rear + 1) % n
```

Then:

```text
queue[rear] = x
```

---

# 15. Circular Queue Dequeue

General formula:

```text
front = (front + 1) % n
```

Then the old front element is removed.

---

# 16. Circular Queue Full Condition

There are multiple implementations.

One common implementation deliberately leaves one slot empty.

Then:

```text
(rear + 1) % n == front
```

means:

```text
FULL
```

This implementation can store:

```text
n-1
```

elements.

---

# 17. Circular Queue Empty Condition

For the common implementation:

```text
front == rear
```

may represent empty.

This convention goes together with the one-unused-slot approach.

## GATE Warning

Circular queue implementations can use different conventions.

Always inspect:

```text
initial front
initial rear
full condition
empty condition
```

before solving.

---

# 18. Circular Queue Capacity

If array size is:

```text
n
```

and one slot is deliberately left unused:

```text
maximum elements = n-1
```

Example:

```text
n = 10
```

capacity:

```text
9
```

---

# 19. Another Circular Queue Convention

A circular queue can store all `n` positions if we maintain an additional variable such as:

```text
count
```

Then:

```text
count == 0
```

means empty.

and:

```text
count == n
```

means full.

Therefore:

```text
capacity = n
```

## GATE Trick

Do not blindly assume:

```text
capacity = n-1
```

Check the implementation.

---

# 20. Circular Queue Using Count

Suppose:

```text
count = 0
front = 0
rear = 0
```

On enqueue:

```text
queue[rear] = x
rear = (rear+1)%n
count++
```

On dequeue:

```text
x = queue[front]
front = (front+1)%n
count--
```

Conditions:

```text
count == 0 → Empty
count == n → Full
```

---

# 21. Queue Using Linked List

A linked-list queue usually maintains:

```text
front
rear
```

Example:

```text
FRONT                         REAR
 ↓                              ↓
10 → 20 → 30 → 40 → NULL
```

Enqueue:

```text
insert at rear
```

Dequeue:

```text
delete from front
```

Both can be:

```text
Θ(1)
```

---

# 22. Why Maintain Both Front and Rear?

If only `front` is maintained:

```text
enqueue
```

may require traversal to the end.

That gives:

```text
Θ(n)
```

Instead maintain:

```text
front
rear
```

Then:

```text
enqueue → Θ(1)
dequeue → Θ(1)
```

---

# 23. Queue Complexity

Using a proper linked-list implementation:

| Operation | Complexity |
| --------- | ---------: |
| Enqueue   |       Θ(1) |
| Dequeue   |       Θ(1) |
| Front     |       Θ(1) |
| Rear      |       Θ(1) |
| isEmpty   |       Θ(1) |

Using a circular array:

```text
enqueue → Θ(1)
dequeue → Θ(1)
```

---

# 24. Queue Overflow

Overflow occurs when attempting:

```text
enqueue
```

on a full queue.

For the one-empty-slot circular queue:

```text
(rear+1)%n == front
```

means:

```text
FULL
```

---

# 25. Queue Underflow

Underflow occurs when:

```text
dequeue
```

is performed on an empty queue.

For a count-based implementation:

```text
count == 0
```

means empty.

---

# 26. Queue Example

Operations:

```text
enqueue(10)
enqueue(20)
enqueue(30)
dequeue()
enqueue(40)
dequeue()
```

Trace:

```text
enqueue 10
→ [10]

enqueue 20
→ [10,20]

enqueue 30
→ [10,20,30]

dequeue
→ removes 10
→ [20,30]

enqueue 40
→ [20,30,40]

dequeue
→ removes 20
→ [30,40]
```

Final queue:

```text
30 → 40
```

---

# 27. GATE Queue Trace Trick

Always maintain:

```text
FRONT
REAR
```

and record the logical order.

Do not rely only on the physical array layout in circular queues.

---

# 28. Deque

Deque means:

> **Double Ended Queue**

It allows insertion and deletion at both ends.

Operations:

```text
insertFront
insertRear
deleteFront
deleteRear
```

Example:

```text
FRONT                 REAR
 ↓                      ↓
10 → 20 → 30 → 40
```

Possible:

```text
insertFront(5)
```

and:

```text
deleteRear()
```

---

# 29. Input-Restricted Deque

In an input-restricted deque:

```text
Insertion → only one end
Deletion  → both ends
```

---

# 30. Output-Restricted Deque

In an output-restricted deque:

```text
Insertion → both ends
Deletion  → only one end
```

## GATE Trick

Remember:

```text
Input restricted
→ insertion restricted

Output restricted
→ deletion restricted
```

---

# 31. Priority Queue

In a priority queue, deletion is based on:

> **Priority**

not simply arrival order.

Example:

```text
(A, priority 3)
(B, priority 1)
(C, priority 5)
```

If larger number means higher priority:

```text
C
A
B
```

will be served in that order.

---

# 32. Priority Queue vs Normal Queue

Normal queue:

```text
FIFO
```

Priority queue:

```text
Highest/lowest priority first
```

depending on the implementation.

If two elements have the same priority, the behavior may depend on whether the implementation is stable.

---

# 33. Priority Queue Implementations

Possible implementations:

```text
Unsorted array
Sorted array
Linked list
Heap
```

For a binary heap:

```text
insert → Θ(log n)
delete highest/lowest priority → Θ(log n)
peek → Θ(1)
```

Building a heap from `n` elements:

```text
Θ(n)
```

using bottom-up heap construction.

---

# 34. Queue and BFS

Breadth First Search uses:

> **Queue**

Why?

BFS processes vertices level by level.

Example:

```text
Level 0:
A

Level 1:
B C

Level 2:
D E F
```

The queue stores vertices in the order they are discovered.

---

# 35. BFS Queue Example

Graph:

```text
A
├── B
└── C
```

Start:

```text
enqueue(A)
```

Queue:

```text
A
```

Dequeue `A`.

Discover:

```text
B
C
```

Queue:

```text
B → C
```

Then:

```text
dequeue B
dequeue C
```

This produces level-order traversal.

---

# 36. BFS Complexity

Using adjacency lists:

```text
Θ(V+E)
```

where:

```text
V = number of vertices
E = number of edges
```

Queue space can be:

```text
Θ(V)
```

in the worst case.

---

# 37. Queue in Scheduling

Queues are used in:

```text
CPU scheduling
Printer scheduling
Network packet buffering
I/O buffering
Process management
```

A normal FIFO queue is appropriate when jobs are served in arrival order.

Priority scheduling instead uses a:

```text
Priority Queue
```

---

# 38. Queue Using Two Stacks

A queue can be implemented using two stacks:

```text
S1
S2
```

### Enqueue

Push into:

```text
S1
```

### Dequeue

If `S2` is empty:

```text
move all elements:
S1 → S2
```

Then pop from:

```text
S2
```

---

# 39. Why Two Stacks Produce FIFO

Suppose enqueue:

```text
1
2
3
```

S1:

```text
TOP
 ↓
3
2
1
```

Move everything to S2:

```text
TOP
 ↓
1
2
3
```

Now:

```text
pop S2
```

returns:

```text
1
```

which is FIFO.

---

# 40. Complexity of Queue Using Two Stacks

Enqueue:

```text
Θ(1)
```

Dequeue:

* If S2 is non-empty → `Θ(1)`
* If S2 is empty → may be `Θ(n)`

But amortized over a sequence:

```text
Θ(1) per operation
```

---

# 41. Amortized Analysis Trick

Suppose `n` elements are transferred:

```text
S1 → S2
```

Each element is transferred only once before being dequeued.

Therefore across many operations:

```text
total transfer work = O(n)
```

So average cost per operation:

```text
O(1)
```

This is called:

> **Amortized O(1)**

---

# 42. Stack Using Two Queues

A stack can be implemented using two queues.

Two common strategies:

### Push costly

```text
push → Θ(n)
pop  → Θ(1)
```

### Pop costly

```text
push → Θ(1)
pop  → Θ(n)
```

Depending on implementation.

---

# 43. Queue Using One Stack?

A queue can technically be simulated recursively or with additional mechanisms, but the standard GATE construction is:

```text
Two Stacks
```

for clean FIFO simulation.

Similarly:

```text
Stack
→ Two Queues
```

is the standard reverse simulation.

---

# 44. Circular Queue — Detailed Example

Array size:

```text
5
```

Initially:

```text
front = 0
rear = 0
```

using the one-empty-slot convention.

Queue is empty.

Enqueue `10`:

```text
q[rear] = 10
rear = (rear+1)%5
```

So:

```text
rear = 1
```

Enqueue `20`:

```text
rear = 2
```

Enqueue `30`:

```text
rear = 3
```

Queue contains:

```text
10 20 30
```

---

# 45. Circular Queue Deletion Example

Suppose:

```text
front = 0
rear = 3
```

Queue:

```text
10 20 30
```

Dequeue:

```text
front = (0+1)%5
     = 1
```

Now logical queue:

```text
20 30
```

---

# 46. Circular Wrap-Around

Continue:

```text
enqueue 40
enqueue 50
```

Eventually rear reaches the last position.

Next enqueue uses:

```text
(rear+1)%5
```

which wraps to:

```text
0
```

This is the main advantage of circular queues.

---

# 47. GATE Circular Queue Trick

Whenever you see:

```text
(i+1)%n
```

think:

> **Circular movement**

Whenever you see:

```text
(i-1+n)%n
```

think:

> **Move one position backward circularly**

Example:

```text
i = 0
n = 5
```

then:

```text
(0-1+5)%5
= 4
```

So previous position of `0` is `4`.

---

# 48. Circular Queue Logical Order

Suppose:

```text
n = 5
```

Physical array:

```text
[40][50][ ][20][30]
 ↑           ↑
rear        front
```

Logical queue order:

```text
20 → 30 → 40 → 50
```

not:

```text
40 → 50 → 20 → 30
```

## GATE Trick

Follow:

```text
front
→ next
→ next
→ ...
→ rear
```

using modulo arithmetic.

---

# 49. GATE PYQ Pattern 1 — Basic Queue

Operations:

```text
enqueue(1)
enqueue(2)
enqueue(3)
dequeue()
enqueue(4)
dequeue()
```

Trace:

```text
1
1 2
1 2 3
→ remove 1
2 3
2 3 4
→ remove 2
3 4
```

Final:

```text
3 4
```

Dequeued values:

```text
1, 2
```

---

# 50. GATE PYQ Pattern 2 — FIFO Output

Input operations:

```text
enqueue(10)
enqueue(20)
enqueue(30)
dequeue()
dequeue()
```

Output:

```text
10
20
```

because:

```text
first in → first out
```

---

# 51. GATE PYQ Pattern 3 — Circular Index

Given:

```text
n = 8
rear = 7
```

Next rear:

```text
(rear+1)%n
=
(7+1)%8
=
0
```

Answer:

```text
0
```

---

# 52. GATE PYQ Pattern 4 — Circular Previous

Given:

```text
n = 8
front = 0
```

Previous circular index:

```text
(front-1+n)%n
```

```text
= (0-1+8)%8
= 7
```

Answer:

```text
7
```

---

# 53. GATE PYQ Pattern 5 — False Overflow

Array size:

```text
5
```

Perform:

```text
enqueue 1
enqueue 2
enqueue 3
enqueue 4
enqueue 5
dequeue
dequeue
```

Now:

```text
3 4 5
```

are present.

There are two unused positions at the beginning, but a simple linear queue may still have:

```text
rear = 4
```

and cannot insert another element.

This is:

> **False Overflow**

Circular queue solves it.

---

# 54. GATE PYQ Pattern 6 — Circular Capacity

Array size:

```text
10
```

One slot is intentionally unused.

Maximum number of stored elements:

```text
10-1
= 9
```

Answer:

```text
9
```

---

# 55. GATE PYQ Pattern 7 — Count-Based Queue

Array size:

```text
10
```

If the implementation maintains:

```text
count
```

and allows all positions:

```text
count = 0 → empty
count = 10 → full
```

Maximum capacity:

```text
10
```

## Trick

The answer depends on the implementation convention.

---

# 56. GATE PYQ Pattern 8 — Queue Using Two Stacks

Enqueue:

```text
1
2
3
```

S1:

```text
3
2
1
```

Move to S2:

```text
1
2
3
```

Dequeue:

```text
1
```

Next dequeue:

```text
2
```

Therefore FIFO is maintained.

---

# 57. GATE PYQ Pattern 9 — Amortized Queue

Suppose:

```text
100 elements
```

are moved from S1 to S2.

Each element moves:

```text
once
```

Therefore total movement:

```text
100
```

not:

```text
100×100
```

Across the entire sequence:

```text
Θ(n)
```

transfer work.

---

# 58. GATE PYQ Pattern 10 — BFS

For graph traversal:

```text
A
├── B
├── C
└── D
```

BFS uses:

```text
Queue
```

Starting from `A`:

```text
enqueue A
dequeue A
enqueue B,C,D
```

Then process:

```text
B
C
D
```

This gives level-order behavior.

---

# 59. GATE PYQ Pattern 11 — DFS vs BFS

Question:

> Which data structure is normally used for BFS?

Answer:

```text
Queue
```

For DFS:

```text
Stack
```

Memory trick:

```text
BFS → Broad → Queue
DFS → Deep → Stack
```

---

# 60. GATE PYQ Pattern 12 — Deque

A deque supports:

```text
insertFront
insertRear
deleteFront
deleteRear
```

Therefore it can behave like:

```text
Stack
```

and:

```text
Queue
```

depending on which operations are used.

---

# 61. GATE PYQ Pattern 13 — Input Restricted Deque

If insertion is allowed only at:

```text
rear
```

but deletion is allowed at:

```text
front + rear
```

this is:

> **Input-restricted deque**

---

# 62. GATE PYQ Pattern 14 — Output Restricted Deque

If insertion is allowed at:

```text
front + rear
```

but deletion is allowed only at:

```text
front
```

this is:

> **Output-restricted deque**

---

# 63. GATE PYQ Pattern 15 — Priority Queue

Elements:

```text
A → priority 2
B → priority 5
C → priority 1
```

If larger priority number means higher priority:

```text
B
A
C
```

will be removed in that order.

The important point:

```text
priority > arrival order
```

---

# 64. GATE PYQ Pattern 16 — Priority Queue with Heap

For a binary heap:

```text
insert → Θ(log n)
delete root → Θ(log n)
peek root → Θ(1)
```

Building heap using bottom-up heapify:

```text
Θ(n)
```

This distinction is frequently tested.

---

# 65. GATE PYQ Pattern 17 — Queue Front/Rear

Suppose:

```text
Queue:
10 20 30
```

Then:

```text
front = 10
rear  = 30
```

After:

```text
dequeue()
```

we get:

```text
front = 20
rear  = 30
```

After another:

```text
dequeue()
```

we get:

```text
front = 30
rear  = 30
```

depending on the implementation's pointer convention.

---

# 66. GATE PYQ Pattern 18 — Empty Queue After Last Dequeue

Suppose queue contains:

```text
10
```

Perform:

```text
dequeue()
```

Now:

```text
queue = empty
```

Any further:

```text
dequeue()
```

causes:

```text
Underflow
```

---

# 67. GATE PYQ Pattern 19 — Queue Complexity

A queue implemented using a linked list with:

```text
front pointer
rear pointer
```

has:

```text
enqueue = Θ(1)
dequeue = Θ(1)
```

If only a front pointer is maintained and insertion occurs at the tail of a singly linked list:

```text
enqueue = Θ(n)
```

because traversal may be required.

---

# 68. GATE PYQ Pattern 20 — Circular Queue Complexity

Circular queue operations:

```text
enqueue
dequeue
```

use modulo arithmetic and pointer updates.

Therefore:

```text
enqueue = Θ(1)
dequeue = Θ(1)
```

Circular queues do not require shifting elements.

---

# 69. Why Circular Queue is Better

Linear array queue:

```text
dequeue
→ front moves
→ unused positions accumulate
```

Circular queue:

```text
dequeue
→ front moves circularly
→ old positions can be reused
```

Therefore circular queues use array space more efficiently.

---

# 70. Queue and Memory

Array queue:

```text
Θ(n)
```

space.

Linked-list queue:

```text
Θ(n)
```

space.

Circular queue:

```text
Θ(n)
```

space.

The difference is mainly:

```text
implementation
+
memory utilization
+
operation details
```

---

# 71. Queue and Producer-Consumer

Queues are fundamental to producer-consumer systems.

Example:

```text
Producer
   ↓
[ Queue ]
   ↓
Consumer
```

Producer adds items:

```text
enqueue
```

Consumer removes items:

```text
dequeue
```

This is useful for:

```text
buffering
I/O
networking
concurrent systems
```

---

# 72. Bounded Queue

A bounded queue has a fixed maximum capacity.

Example:

```text
capacity = 100
```

If all 100 positions are occupied:

```text
enqueue
```

cannot proceed until space becomes available.

This is commonly implemented with:

```text
circular array
```

---

# 73. Unbounded Queue

Conceptually, an unbounded queue has no fixed maximum size, subject to available memory.

A linked-list implementation can grow as nodes are added.

But actual systems are still limited by:

```text
available memory
```

---

# 74. Queue as ADT vs Implementation

Important distinction:

```text
Queue
```

defines:

```text
FIFO behavior
```

while:

```text
Circular Array
Linked List
```

define:

```text
Implementation
```

GATE may ask which property belongs to the ADT versus implementation.

---

# 75. Queue Important Formula Sheet

## Circular next

```text
next(i) = (i+1)%n
```

## Circular previous

```text
prev(i) = (i-1+n)%n
```

## One-empty-slot full condition

```text
(rear+1)%n == front
```

## Count-based empty

```text
count == 0
```

## Count-based full

```text
count == n
```

---

# 76. Queue Important Complexity Sheet

```text
Simple queue:
    enqueue → Θ(1)
    dequeue → Θ(1)

Circular queue:
    enqueue → Θ(1)
    dequeue → Θ(1)

Linked-list queue:
    enqueue → Θ(1)
    dequeue → Θ(1)

BFS:
    Θ(V+E)

Queue using two stacks:
    worst individual transfer → Θ(n)
    amortized → Θ(1)

Priority queue using binary heap:
    insert → Θ(log n)
    delete → Θ(log n)
    peek → Θ(1)
```

---

# 77. GATE Common Traps

## Trap 1 — FIFO confusion

Queue:

```text
1 2 3
```

does NOT remove `3` first.

It removes:

```text
1
```

---

## Trap 2 — Front vs Rear

```text
enqueue → rear
dequeue → front
```

---

## Trap 3 — Circular capacity

Do not automatically assume:

```text
capacity = n-1
```

Check whether:

```text
count
```

or another full/empty mechanism is used.

---

## Trap 4 — Physical order

Circular queue may look physically scrambled.

Always follow:

```text
front → circular next → ... → rear
```

---

## Trap 5 — Amortized complexity

A single dequeue from a two-stack queue can be:

```text
Θ(n)
```

but amortized complexity can be:

```text
Θ(1)
```

---

# 78. GATE Question-Solving Workflow

Whenever you see a queue question:

### Step 1

Identify:

```text
FIFO
```

### Step 2

Mark:

```text
FRONT
REAR
```

### Step 3

For every:

```text
enqueue
```

update:

```text
REAR
```

### Step 4

For every:

```text
dequeue
```

update:

```text
FRONT
```

### Step 5

If circular:

```text
index = (index+1)%n
```

### Step 6

Check the exact:

```text
empty condition
full condition
```

### Step 7

For BFS:

```text
Queue
```

### Step 8

For priority queue:

```text
priority determines removal
```

### Step 9

For two-stack implementation:

```text
consider amortized cost
```

---

# 79. Queue vs Circular Queue

| Feature               | Linear Array Queue | Circular Queue |
| --------------------- | ------------------ | -------------- |
| Wrap around           | No                 | Yes            |
| Reuse freed positions | Poor               | Yes            |
| False overflow        | Possible           | Avoided        |
| Enqueue               | Θ(1)               | Θ(1)           |
| Dequeue               | Θ(1)               | Θ(1)           |
| Typical use           | Simple cases       | Buffers        |

---

# 80. Queue vs Deque

| Feature        | Queue | Deque    |
| -------------- | ----- | -------- |
| Insert front   | No    | Yes      |
| Insert rear    | Yes   | Yes      |
| Delete front   | Yes   | Yes      |
| Delete rear    | No    | Yes      |
| Main principle | FIFO  | Flexible |

---

# 81. Queue vs Priority Queue

| Feature                | Queue                     | Priority Queue          |
| ---------------------- | ------------------------- | ----------------------- |
| Ordering               | Arrival                   | Priority                |
| Principle              | FIFO                      | Priority-based          |
| Typical implementation | Array/List/Circular Queue | Heap                    |
| Peek                   | Front                     | Highest/lowest priority |

---

# 82. Rapid Revision

```text
QUEUE

Principle:
    FIFO

Insertion:
    REAR

Deletion:
    FRONT

enqueue:
    insert at rear

dequeue:
    remove from front

Full:
    depends on implementation

Empty:
    depends on implementation

Circular next:
    (i+1)%n

Circular previous:
    (i-1+n)%n

One-slot-unused full:
    (rear+1)%n == front

One-slot-unused capacity:
    n-1

Count-based capacity:
    n

False overflow:
    linear array queue

Circular queue:
    reuses freed positions

Linked-list queue:
    front + rear pointers

BFS:
    Queue

DFS:
    Stack

Deque:
    insertion/deletion at both ends

Input-restricted deque:
    insertion restricted

Output-restricted deque:
    deletion restricted

Priority Queue:
    priority determines service

Heap priority queue:
    insert = Θ(log n)
    delete = Θ(log n)
    peek = Θ(1)

Two stacks → Queue:
    amortized Θ(1)

Queue → Stack:
    two queues
```

---

# 83. Final GATE Checklist

Before considering Queues complete:

* [ ] Queue definition
* [ ] FIFO
* [ ] Queue ADT
* [ ] Enqueue
* [ ] Dequeue
* [ ] Front
* [ ] Rear
* [ ] Overflow
* [ ] Underflow
* [ ] Array implementation
* [ ] Linked-list implementation
* [ ] False overflow
* [ ] Circular queue
* [ ] Modulo arithmetic
* [ ] Circular queue capacity
* [ ] Full condition
* [ ] Empty condition
* [ ] Count-based circular queue
* [ ] Deque
* [ ] Input-restricted deque
* [ ] Output-restricted deque
* [ ] Priority queue
* [ ] Heap implementation
* [ ] BFS
* [ ] Queue using two stacks
* [ ] Stack using two queues
* [ ] Amortized analysis
* [ ] Producer-consumer
* [ ] Bounded queue
* [ ] Queue complexity
* [ ] Circular queue tracing
* [ ] PYQ-style output tracing

---

# 84. Final GATE Rules

Whenever you see a queue question, immediately ask:

```text
1. Is it FIFO?

2. Where is insertion happening?
   → REAR

3. Where is deletion happening?
   → FRONT

4. Is the queue circular?

5. If circular:
   next = (i+1)%n

6. What exact full condition is being used?

7. What exact empty condition is being used?

8. Is one slot intentionally unused?

9. Is there a count variable?

10. Is this BFS?
    → Queue

11. Is this priority-based?
    → Priority Queue

12. Is it a deque?
    → Both ends matter

13. Is a queue implemented using stacks?
    → Check amortized complexity
```

> **GATE Master Trick:**
> In queue questions, never assume the meaning of `front` and `rear` from memory alone. First identify the implementation convention, then trace the operations.

```
```
