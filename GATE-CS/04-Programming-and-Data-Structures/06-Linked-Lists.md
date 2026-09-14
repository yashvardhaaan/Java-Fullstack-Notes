# 06 — Linked Lists.md

````md
# 06 — Linked Lists
## GATE CSE/IT Notes + Tricks + PYQ Patterns + Practice

---

# 1. What is a Linked List?

A **linked list** is a linear data structure in which elements are stored in separate memory locations and connected using pointers.

A node generally contains:

```text
+---------+---------+
|  Data   |  Next   |
+---------+---------+
````

For a singly linked list:

```text
HEAD
 ↓
[10|•] → [20|•] → [30|NULL]
```

Unlike arrays:

* Memory need not be contiguous.
* Size can grow/shrink dynamically.
* Random access is not efficient.

---

# 2. Node Structure in C

```c
struct Node {
    int data;
    struct Node *next;
};
```

Creating a node:

```c
struct Node *p;

p = (struct Node *)malloc(sizeof(struct Node));

p->data = 10;
p->next = NULL;
```

Important:

```c
p->data
```

is equivalent to:

```c
(*p).data
```

### GATE Trick

If:

```c
struct Node *p;
```

then:

```c
p->data
```

means:

```c
(*p).data
```

But:

```c
p.data
```

is invalid because `p` is a pointer.

---

# 3. Why Linked Lists?

## Advantages

1. Dynamic size.
2. Easy insertion/deletion.
3. No requirement for contiguous memory.
4. Useful for implementing stacks and queues.

## Disadvantages

1. No direct/random access.
2. Extra memory required for pointers.
3. Poor cache locality compared with arrays.
4. Pointer manipulation can cause bugs.

---

# 4. Array vs Linked List

| Feature              | Array      | Linked List    |
| -------------------- | ---------- | -------------- |
| Memory               | Contiguous | Non-contiguous |
| Random access        | O(1)       | O(n)           |
| Insert beginning     | O(n)       | O(1)           |
| Delete beginning     | O(n)       | O(1)           |
| Search               | O(n)       | O(n)           |
| Dynamic size         | Difficult  | Easy           |
| Extra pointer memory | No         | Yes            |
| Cache locality       | Good       | Usually poor   |

### GATE Shortcut

If question asks:

> Which structure supports O(1) random access?

Answer:

**Array**

Not linked list.

---

# 5. Singly Linked List

Each node contains:

```text
data + next
```

Example:

```text
HEAD
 ↓
10 → 20 → 30 → 40 → NULL
```

The last node has:

```c
next = NULL;
```

---

# 6. Traversal

Basic traversal:

```c
struct Node *temp = head;

while (temp != NULL) {
    printf("%d ", temp->data);
    temp = temp->next;
}
```

Complexity:

```text
Time  = O(n)
Space = O(1)
```

if no additional data structure is used.

### GATE Trick

For a singly linked list with `n` nodes:

```text
Traversal = O(n)
```

---

# 7. Searching

```c
temp = head;

while (temp != NULL) {
    if (temp->data == key)
        return 1;

    temp = temp->next;
}

return 0;
```

Worst-case:

```text
O(n)
```

because the element may be at the last node or absent.

---

# 8. Insertion at Beginning

Initial:

```text
HEAD
 ↓
10 → 20 → 30
```

Insert `5`.

```c
new->next = head;
head = new;
```

Result:

```text
HEAD
 ↓
5 → 10 → 20 → 30
```

Complexity:

```text
O(1)
```

### Important

Order matters.

Correct:

```c
new->next = head;
head = new;
```

Incorrect:

```c
head = new;
new->next = head;
```

The second version makes:

```text
new → new
```

and loses the original list.

---

# 9. Insertion at End

Without a tail pointer:

```text
O(n)
```

because we must reach the last node.

With a tail pointer:

```text
O(1)
```

if insertion only requires attaching the new node.

Example:

```text
HEAD                         TAIL
 ↓                            ↓
10 → 20 → 30 → NULL
```

Insert 40:

```c
tail->next = new;
tail = new;
```

---

# 10. Insertion After a Given Node

Suppose:

```text
10 → 20 → 30
```

Insert `25` after `20`.

Correct:

```c
new->next = p->next;
p->next = new;
```

Result:

```text
10 → 20 → 25 → 30
```

### GATE Trick

Always connect the new node to the old successor **before** changing the predecessor's link.

---

# 11. Deletion from Beginning

```c
temp = head;
head = head->next;
free(temp);
```

Complexity:

```text
O(1)
```

Example:

```text
10 → 20 → 30
```

After deletion:

```text
20 → 30
```

---

# 12. Deletion from End

For a singly linked list:

```text
O(n)
```

because we need the second-last node.

Example:

```text
10 → 20 → 30
```

Need:

```text
20 → NULL
```

and delete node 30.

---

# 13. Deletion of a Middle Node

Suppose:

```text
10 → 20 → 30 → 40
```

Delete 30.

Need:

```text
20->next = 40
```

Then free node 30.

```c
temp = p->next;
p->next = temp->next;
free(temp);
```

Result:

```text
10 → 20 → 40
```

---

# 14. Complexity of Singly Linked List

| Operation               | Complexity |
| ----------------------- | ---------: |
| Access ith node         |       O(n) |
| Search                  |       O(n) |
| Insert beginning        |       O(1) |
| Insert end without tail |       O(n) |
| Insert end with tail    |       O(1) |
| Delete beginning        |       O(1) |
| Delete end              |       O(n) |
| Delete after known node |       O(1) |

---

# 15. Doubly Linked List

Each node contains:

```text
+------+--------+------+
| prev |  data  | next |
+------+--------+------+
```

Example:

```text
NULL ← 10 ⇄ 20 ⇄ 30 → NULL
```

Node:

```c
struct Node {
    int data;
    struct Node *prev;
    struct Node *next;
};
```

---

# 16. Advantages of Doubly Linked List

Compared with singly linked lists:

* Can move in both directions.
* Deletion is easier when node pointer is known.
* Useful for:

  * browser history
  * undo/redo
  * deque
  * navigation systems

Disadvantage:

```text
Extra pointer = extra memory
```

---

# 17. Doubly Linked List Insertion

Insert `25` between `20` and `30`.

Initial:

```text
20 ⇄ 30
```

Required:

```text
20 ⇄ 25 ⇄ 30
```

Pointer updates:

```c
new->prev = p;
new->next = p->next;

p->next->prev = new;
p->next = new;
```

### GATE Trap

In a doubly linked list, modifying only `next` is insufficient.

Both:

```text
prev
next
```

links must remain consistent.

---

# 18. Circular Linked List

In a circular linked list:

```text
10 → 20 → 30
↑         ↓
└─────────┘
```

The last node points to the first node.

Therefore:

```c
last->next = head;
```

There is no:

```c
last->next = NULL;
```

---

# 19. Traversing Circular List

Do NOT use:

```c
while (temp != NULL)
```

because `temp` never becomes NULL.

Instead:

```c
temp = head;

do {
    printf("%d ", temp->data);
    temp = temp->next;
} while (temp != head);
```

---

# 20. Circular List Trick

If a circular linked list has a pointer to the **last node**, then:

```text
last->next
```

is the first node.

Therefore, both:

```text
first
last
```

can be accessed efficiently.

This makes circular linked lists useful for:

* round-robin scheduling
* circular queues
* repeated cyclic processing

---

# 21. Header Node / Sentinel Node

A linked list may contain a special node before the actual data nodes.

Example:

```text
HEADER → 10 → 20 → 30 → NULL
```

The header node may not contain normal data.

### Why use it?

It can simplify:

* insertion
* deletion
* handling empty lists
* boundary cases

---

# 22. Empty Linked List

Usually:

```c
head == NULL
```

means:

```text
List is empty
```

For a circular list, the representation may instead use:

```text
head == NULL
```

or another convention depending on implementation.

### GATE Rule

Always inspect the exact representation given in the question.

---

# 23. Reverse a Singly Linked List

Initial:

```text
10 → 20 → 30 → NULL
```

After reverse:

```text
30 → 20 → 10 → NULL
```

Standard iterative algorithm:

```c
prev = NULL;
curr = head;

while (curr != NULL) {
    next = curr->next;
    curr->next = prev;
    prev = curr;
    curr = next;
}

head = prev;
```

---

# 24. Reverse Algorithm — The 3 Pointer Rule

Remember:

```text
prev
curr
next
```

At every iteration:

```text
next = curr->next
curr->next = prev
prev = curr
curr = next
```

### GATE Shortcut

Never change:

```c
curr->next
```

before saving the original:

```c
curr->next
```

Otherwise the remaining list can be lost.

---

# 25. Reverse Example

Initial:

```text
10 → 20 → 30 → NULL
```

Initially:

```text
prev = NULL
curr = 10
```

Iteration 1:

```text
10 → NULL
prev = 10
curr = 20
```

Iteration 2:

```text
20 → 10 → NULL
prev = 20
curr = 30
```

Iteration 3:

```text
30 → 20 → 10 → NULL
```

Final:

```text
head = 30
```

Complexity:

```text
Time  = O(n)
Space = O(1)
```

---

# 26. Recursive Reverse

Conceptually:

```c
reverse(head->next);
```

Then:

```c
head->next->next = head;
head->next = NULL;
```

The recursive implementation takes:

```text
Time  = O(n)
Space = O(n)
```

because of the recursion call stack.

### GATE Trap

Iterative reverse:

```text
Auxiliary space = O(1)
```

Recursive reverse:

```text
Auxiliary stack space = O(n)
```

---

# 27. Find Middle of Linked List

Use two pointers:

```text
slow
fast
```

Algorithm:

```c
slow = head;
fast = head;

while (fast != NULL && fast->next != NULL) {
    slow = slow->next;
    fast = fast->next->next;
}
```

When `fast` reaches the end:

```text
slow = middle
```

---

# 28. Middle Trick

For:

```text
1 → 2 → 3 → 4 → 5
```

slow ends at:

```text
3
```

For:

```text
1 → 2 → 3 → 4
```

the result depends on initialization and loop condition.

Possible conventions give:

```text
2
```

or:

```text
3
```

### GATE Rule

For even-length lists, carefully simulate the exact code.

Never blindly assume which middle is returned.

---

# 29. Fast and Slow Pointer

This technique is extremely important for GATE.

Applications:

```text
1. Find middle
2. Detect cycle
3. Find cycle starting point
4. Split list
5. Some palindrome problems
```

---

# 30. Detect Cycle — Floyd's Algorithm

Suppose:

```text
1 → 2 → 3 → 4
        ↑   ↓
        └───┘
```

Use:

```text
slow = slow->next
fast = fast->next->next
```

If:

```text
slow == fast
```

then a cycle exists.

If:

```text
fast == NULL
```

or:

```text
fast->next == NULL
```

then no cycle exists.

Complexity:

```text
Time  = O(n)
Space = O(1)
```

---

# 31. Why Floyd's Algorithm Works

Inside a cycle:

```text
fast
```

moves 2 steps while:

```text
slow
```

moves 1 step.

Therefore, fast gains one node per iteration.

Eventually:

```text
fast == slow
```

if a cycle exists.

---

# 32. Finding Start of Cycle

After:

```text
slow == fast
```

set:

```c
slow = head;
```

Keep:

```c
slow = slow->next;
fast = fast->next;
```

The point where they meet is the cycle start.

### GATE Trick

Cycle detection and cycle-start detection are two separate stages.

---

# 33. Nth Node from End

Use two pointers.

For finding the nth node from the end:

```text
Move fast n nodes ahead.
Then move slow and fast together.
```

When:

```text
fast == NULL
```

then:

```text
slow = nth node from end
```

Complexity:

```text
O(n)
```

and:

```text
O(1)
```

extra space.

---

# 34. Example — 2nd Node from End

List:

```text
10 → 20 → 30 → 40 → 50
```

2nd from end:

```text
40
```

Two-pointer technique finds it in one traversal.

---

# 35. Intersection of Two Linked Lists

Consider:

```text
A: 1 → 2 ─┐
          ↓
          8 → 9 → NULL
          ↑
B: 5 → 6 ─┘
```

The lists intersect at:

```text
8
```

Important:

Intersection means **same node/address**, not merely equal data.

---

# 36. Intersection Trick

A common O(1)-space technique:

```text
p = headA
q = headB
```

When `p` reaches NULL:

```text
p = headB
```

When `q` reaches NULL:

```text
q = headA
```

Then move both one step.

Eventually:

```text
p == q
```

at the intersection node or NULL.

### GATE Trap

Do not compare:

```c
p->data == q->data
```

for actual node intersection.

Compare:

```c
p == q
```

---

# 37. Merge Two Sorted Linked Lists

Given:

```text
A: 1 → 4 → 7
B: 2 → 3 → 8
```

Merged:

```text
1 → 2 → 3 → 4 → 7 → 8
```

At each step:

```text
Choose smaller current node.
```

Complexity:

```text
O(n + m)
```

---

# 38. Palindrome Linked List

Example:

```text
1 → 2 → 3 → 2 → 1
```

is a palindrome.

A common O(1)-extra-space method:

```text
1. Find middle.
2. Reverse second half.
3. Compare first half and reversed second half.
```

Complexity:

```text
O(n) time
O(1) auxiliary space
```

---

# 39. Splitting a Linked List

Use:

```text
slow
fast
```

When fast reaches the end, slow is near the midpoint.

Then split:

```text
first half
second half
```

This is frequently used in:

```text
Merge Sort on linked lists
```

---

# 40. Merge Sort on Linked List

Steps:

```text
1. Find middle.
2. Split into two lists.
3. Recursively sort both.
4. Merge sorted lists.
```

Complexity:

```text
Time = O(n log n)
```

Linked lists are particularly suitable for merge sort because merging does not require shifting elements.

---

# 41. Why Merge Sort is Preferred for Linked Lists?

For arrays:

```text
Random access = O(1)
```

For linked lists:

```text
Random access = O(n)
```

Merge sort only requires sequential traversal and pointer manipulation.

Therefore:

```text
Merge Sort → very suitable for linked lists
```

---

# 42. Quick Sort vs Merge Sort on Linked List

Merge sort:

```text
O(n log n)
```

average/worst depending on implementation, with straightforward sequential access.

Quick sort can also be implemented, but linked-list partitioning is less naturally advantageous than array partitioning.

### GATE Focus

If asked for a natural efficient sorting technique for linked lists:

```text
Merge Sort
```

---

# 43. Stack Using Linked List

A stack can be implemented using the head as TOP.

```text
TOP
 ↓
30
 ↓
20
 ↓
10
```

Push:

```text
Insert at beginning
```

Pop:

```text
Delete from beginning
```

Both:

```text
O(1)
```

---

# 44. Queue Using Linked List

Maintain:

```text
front
rear
```

Example:

```text
front                   rear
 ↓                       ↓
10 → 20 → 30 → NULL
```

Enqueue:

```text
rear
```

Dequeue:

```text
front
```

Both can be:

```text
O(1)
```

if both pointers are maintained.

---

# 45. Linked List as Queue — GATE Trap

If only `front` is maintained:

```text
enqueue at rear = O(n)
```

If both:

```text
front + rear
```

are maintained:

```text
enqueue = O(1)
dequeue = O(1)
```

---

# 46. Pointer Arithmetic and Linked Lists

Pointer arithmetic is meaningful for arrays because array elements are contiguous.

Example:

```c
int a[5];
int *p = a;
p++;
```

moves to the next array element.

But linked-list nodes are not necessarily contiguous.

Therefore:

```c
p++
```

does NOT mean:

```text
next linked-list node
```

### Very Important GATE Trap

For linked lists:

```c
p = p->next;
```

moves to the next node.

Not:

```c
p++;
```

---

# 47. `.` vs `->`

If:

```c
struct Node x;
```

use:

```c
x.data
```

If:

```c
struct Node *p;
```

use:

```c
p->data
```

Remember:

```text
object       → .
pointer      → ->
```

---

# 48. `p->next->data`

Suppose:

```text
p → [10] → [20]
```

Then:

```c
p->next->data
```

means:

```text
data of the node after p
```

Result:

```text
20
```

Equivalent:

```c
(*((*p).next)).data
```

conceptually.

---

# 49. Important Pointer Evaluation

Given:

```text
p → 10 → 20 → 30
```

After:

```c
p = p->next;
```

Now:

```text
p → 20
```

After another:

```c
p = p->next;
```

Now:

```text
p → 30
```

### GATE Trick

When tracing pointer programs, redraw where every pointer points after each statement.

---

# 50. Common Linked List Mistake

Code:

```c
p = p->next;
free(p);
```

This does NOT delete the original node pointed to by `p`.

It first moves `p`.

If the intention was to free the old node:

```c
temp = p;
p = p->next;
free(temp);
```

---

# 51. Memory Allocation

Dynamic node:

```c
struct Node *newNode =
    (struct Node *)malloc(sizeof(struct Node));
```

After using the node:

```c
free(newNode);
```

Important concepts:

```text
malloc → allocates memory
free   → releases memory
```

---

# 52. Dangling Pointer

If:

```c
free(p);
```

then `p` still contains the old address.

Now `p` is a:

```text
dangling pointer
```

Avoid using:

```c
p->data
```

after:

```c
free(p);
```

unless `p` has been reassigned appropriately.

---

# 53. Memory Leak

If dynamically allocated memory is no longer reachable and is not freed:

```text
Memory leak
```

Example:

```c
p = malloc(...);
p = malloc(...);
```

The first allocation may become unreachable.

---

# 54. GATE PYQ Pattern — Pointer-Based List Traversal

A typical GATE question gives:

```c
p = head;

while(p != NULL) {
    ...
    p = p->next;
}
```

### How to solve

Draw:

```text
head
 ↓
N1 → N2 → N3 → NULL
```

Then simulate:

```text
p=N1
p=N2
p=N3
p=NULL
```

### Key idea

The number of loop iterations equals the number of nodes if `p` starts at head and advances exactly once per iteration.

---

# 55. GATE PYQ Pattern — Reverse Linked List

A common GATE-style question gives pointer assignments such as:

```c
temp = p->next;
p->next = q;
q = p;
p = temp;
```

### Trick

Recognize:

```text
temp
p
q
```

as the classic reverse-list pointer pattern.

Always draw arrows after each iteration.

---

# 56. GATE PYQ Pattern — Find Middle

Typical question:

```c
slow = head;
fast = head;

while (fast != NULL &&
       fast->next != NULL) {
    slow = slow->next;
    fast = fast->next->next;
}
```

Question:

> What does `slow` point to?

### Solution

Fast moves twice as fast.

Therefore when fast reaches the end:

```text
slow ≈ middle
```

For an even number of nodes, simulate the exact loop.

---

# 57. GATE PYQ Pattern — Cycle Detection

Typical question asks whether:

```c
slow = slow->next;
fast = fast->next->next;
```

will eventually make:

```c
slow == fast
```

### Answer

If the list contains a cycle:

```text
Yes
```

If no cycle:

```text
Fast eventually becomes NULL
```

---

# 58. GATE PYQ Pattern — Same Data vs Same Node

Suppose:

```text
A → [10] → [20]
B → [10] → [30]
```

The two `10`s may contain the same value but can be different nodes.

Therefore:

```text
same value ≠ same node
```

Node identity requires:

```c
A == B
```

when comparing pointers.

---

# 59. GATE PYQ Pattern — Circular List

Suppose:

```text
1 → 2 → 3
↑       ↓
└───────┘
```

If:

```c
p = head;
```

then repeated:

```c
p = p->next;
```

produces:

```text
1 → 2 → 3 → 1 → 2 → 3 → ...
```

It never reaches NULL.

### GATE Trick

Circular list + `while(p != NULL)`:

```text
Potential infinite loop
```

---

# 60. GATE PYQ Pattern — Doubly Linked List

Given:

```text
A ⇄ B ⇄ C
```

To remove B, links must become:

```text
A ⇄ C
```

Therefore:

```text
A.next = C
C.prev = A
```

Both directions must be updated.

---

# 61. GATE PYQ Pattern — Tail Pointer

A linked list has:

```text
head
tail
```

and insertion is performed at the end.

If `tail` is maintained:

```text
Insertion = O(1)
```

Without `tail`:

```text
Insertion = O(n)
```

assuming a singly linked list.

---

# 62. GATE PYQ Pattern — Delete Known Node

If a pointer directly points to the node to be deleted:

### Singly linked list

Normally we need the previous node to update:

```text
previous->next
```

unless the special "copy successor data" trick is applicable and the node is not the last node.

### Doubly linked list

The previous and next links are directly available:

```text
node->prev
node->next
```

so deletion is straightforward.

---

# 63. Famous Trick — Delete a Node Without Previous Pointer

Suppose:

```text
10 → 20 → 30 → 40
```

You have a pointer to node `20`.

Copy the next node:

```c
p->data = p->next->data;
p->next = p->next->next;
```

Result:

```text
10 → 30 → 40
```

### Limitation

Cannot normally be used for the last node because:

```text
p->next == NULL
```

---

# 64. Linked List Time Complexity Cheat Sheet

| Operation                 |                    Singly |      Doubly |
| ------------------------- | ------------------------: | ----------: |
| Access                    |                      O(n) |        O(n) |
| Search                    |                      O(n) |        O(n) |
| Insert beginning          |                      O(1) |        O(1) |
| Delete beginning          |                      O(1) |        O(1) |
| Insert after known node   |                      O(1) |        O(1) |
| Delete known node         | Usually O(n) to find prev |        O(1) |
| Insert end without tail   |                      O(n) |        O(n) |
| Insert end with tail      |                      O(1) |        O(1) |
| Delete end with only head |                      O(n) |        O(n) |
| Delete end with tail      |               O(n) singly | O(1) doubly |

---

# 65. Linked List vs Array — GATE Decision Table

Use **Array** when:

```text
Random access required
Known/fixed size
Cache locality important
```

Use **Linked List** when:

```text
Frequent insertion/deletion
Dynamic size
Random access not required
```

---

# 66. Important GATE Traps

## Trap 1

```text
Linked list provides O(1) access to ith element
```

❌ False.

It is:

```text
O(n)
```

---

## Trap 2

```text
p++ moves to next linked-list node
```

❌ False.

Use:

```c
p = p->next;
```

---

## Trap 3

```text
Circular linked list eventually reaches NULL
```

❌ False.

---

## Trap 4

```text
Same data means same node
```

❌ False.

---

## Trap 5

```text
Recursive reverse uses O(1) auxiliary space
```

❌ False.

Call stack:

```text
O(n)
```

---

## Trap 6

```text
Deleting a node is always O(1)
```

❌ Not necessarily.

Finding the node or predecessor may take:

```text
O(n)
```

---

# 67. Most Important Linked List Algorithms for GATE

Memorize these:

```text
1. Traversal
2. Search
3. Insert beginning
4. Insert end
5. Delete beginning
6. Delete end
7. Reverse
8. Find middle
9. Detect cycle
10. Find cycle start
11. Nth node from end
12. Merge sorted lists
13. Find intersection
14. Check palindrome
15. Split list
```

---

# 68. Fast Revision — Pointer Patterns

### Move one node

```c
p = p->next;
```

### Move two nodes

```c
p = p->next->next;
```

### Save next node

```c
next = p->next;
```

### Reverse

```c
next = curr->next;
curr->next = prev;
prev = curr;
curr = next;
```

### Middle

```c
slow = slow->next;
fast = fast->next->next;
```

### Cycle

```c
if (slow == fast)
```

---

# 69. GATE Problem-Solving Workflow

When a linked-list question appears:

### Step 1

Draw every node.

Example:

```text
10 → 20 → 30 → NULL
```

### Step 2

Mark every pointer.

```text
p → 20
q → 30
```

### Step 3

Execute one statement at a time.

### Step 4

After every pointer assignment, redraw the affected arrow.

### Step 5

Check for:

```text
NULL
cycle
lost node
dangling pointer
```

### Step 6

Only then calculate the output/complexity.

---

# 70. High-Yield GATE Formulas

### Singly linked list

```text
Access = O(n)
Search = O(n)
Insert front = O(1)
Delete front = O(1)
```

### With tail pointer

```text
Insert end = O(1)
```

### Doubly linked list

```text
Delete known node = O(1)
```

### Reverse

```text
Time = O(n)
Iterative auxiliary space = O(1)
Recursive auxiliary space = O(n)
```

### Floyd

```text
Cycle detection = O(n)
Extra space = O(1)
```

---

# 71. One-Minute Revision

```text
Array:
    Random access O(1)

Linked List:
    Random access O(n)

Singly:
    next

Doubly:
    prev + next

Circular:
    last->next = head

Stack using linked list:
    push/pop at head

Queue using linked list:
    front + rear

Reverse:
    prev, curr, next

Middle:
    slow + fast

Cycle:
    slow + fast

Intersection:
    compare addresses, not data

Merge:
    choose smaller node

Recursive:
    recursion stack counts as space
```

---

# 72. Final GATE Checklist

Before the exam, make sure you can solve:

* [ ] Singly linked-list traversal
* [ ] Insertion at beginning
* [ ] Insertion at end
* [ ] Insertion after a node
* [ ] Deletion at beginning
* [ ] Deletion at end
* [ ] Deletion of a middle node
* [ ] Doubly linked-list insertion/deletion
* [ ] Circular linked-list traversal
* [ ] Reverse a linked list
* [ ] Recursive reverse
* [ ] Find middle using slow/fast pointers
* [ ] Detect cycle using Floyd
* [ ] Find cycle starting point
* [ ] Find nth node from end
* [ ] Find intersection
* [ ] Merge sorted linked lists
* [ ] Check palindrome
* [ ] Stack using linked list
* [ ] Queue using linked list
* [ ] Analyze pointer-manipulation code
* [ ] Distinguish `.` and `->`
* [ ] Distinguish same data from same node
* [ ] Analyze malloc/free/dangling pointers

---

# 73. Final GATE Rules

```text
RULE 1:
Linked list does NOT provide random access.

RULE 2:
p->next means next linked-list node.

RULE 3:
p++ is pointer arithmetic, not linked-list traversal.

RULE 4:
Circular linked lists do not reach NULL.

RULE 5:
Slow + fast is one of the highest-value linked-list techniques.

RULE 6:
For reverse, remember:
prev → curr → next

RULE 7:
For doubly linked lists, update BOTH directions.

RULE 8:
Same value does not mean same node.

RULE 9:
Recursive algorithms consume call-stack space.

RULE 10:
Always simulate pointer questions with a diagram.
```

## GATE Priority

### 🔥🔥🔥 Very High

```text
Reverse linked list
Slow/fast pointers
Cycle detection
Pointer tracing
Insertion/deletion
Complexity
Singly vs doubly vs circular
```

### 🔥🔥 High

```text
Intersection
Nth node from end
Merge sorted lists
Palindrome
Queue/stack implementation
```

### 🔥 Medium

```text
Header nodes
Sentinel nodes
Memory allocation details
XOR linked lists
```

---

# END — 06 Linked Lists

```
```
