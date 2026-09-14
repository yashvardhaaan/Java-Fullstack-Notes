# Binary Heap — GATE CSE Notes

````md
# Binary Heap
## GATE CSE/IT Notes + Tricks + PYQ Patterns + Practice

---

# 1. What is a Binary Heap?

A **binary heap** is a binary tree that satisfies two properties:

1. **Shape property**
2. **Heap-order property**

A binary heap is always a:

```text
Complete Binary Tree
````

---

# 2. Two Types of Binary Heap

There are two main types:

```text
1. Max Heap
2. Min Heap
```

---

# 3. Max Heap

In a max heap:

```text
Parent >= Children
```

Example:

```text
          50
        /    \
       30     40
      /  \   /  \
     10  20 35  25
```

The largest element is always at:

```text
ROOT
```

Therefore:

```text
max = root
```

---

# 4. Min Heap

In a min heap:

```text
Parent <= Children
```

Example:

```text
          10
        /    \
       20     15
      /  \   /  \
     30  40 25  35
```

The smallest element is always at:

```text
ROOT
```

Therefore:

```text
min = root
```

---

# 5. Very Important — Heap is NOT BST

Do not confuse:

```text
Binary Heap
```

with:

```text
Binary Search Tree
```

### BST

```text
Left subtree < Root < Right subtree
```

### Max Heap

```text
Parent >= children
```

There is no requirement that:

```text
left subtree < right subtree
```

---

# 6. Example: Max Heap

Consider:

```text
          100
        /     \
       50      80
      / \     / \
     20 30   40 60
```

This is a max heap because every parent is greater than or equal to its children.

But:

```text
50 < 80
```

and:

```text
20 < 30
```

There is no BST-style ordering between entire subtrees.

---

# 7. Shape Property

A binary heap must be a:

```text
COMPLETE BINARY TREE
```

Meaning:

* Every level except possibly the last is completely filled.
* The last level is filled from left to right.

Example:

```text
          A
        /   \
       B     C
      / \   /
     D   E F
```

This is complete.

---

# 8. Invalid Heap Shape

```text
          A
        /   \
       B     C
      /       \
     D         E
```

The last level is not filled from left to right.

Therefore:

```text
NOT a complete binary tree
```

and hence it cannot be a standard binary heap.

---

# 9. Array Representation

Because a heap is complete, it can be efficiently stored in an array.

Example:

```text
          50
        /    \
       30     40
      /  \   /
     10  20 35
```

Array:

```text
[50, 30, 40, 10, 20, 35]
```

No explicit pointers are required.

---

# 10. 0-Based Indexing

For an element at index:

```text
i
```

### Left child

```text
2i + 1
```

### Right child

```text
2i + 2
```

### Parent

```text
floor((i-1)/2)
```

---

# 11. Example — 0-Based Index

Array:

```text
Index:  0   1   2   3   4   5
Value: 50  30  40  10  20  35
```

For node at:

```text
i = 2
```

Left child:

```text
2(2)+1 = 5
```

Right child:

```text
2(2)+2 = 6
```

Therefore:

```text
left = index 5
right = index 6
```

Index 6 does not exist here.

---

# 12. 1-Based Indexing

If root is stored at index 1:

### Left child

```text
2i
```

### Right child

```text
2i + 1
```

### Parent

```text
floor(i/2)
```

---

# 13. GATE Indexing Trick

Always first check:

```text
Is root at index 0 or index 1?
```

Then use the appropriate formula.

### 0-based

```text
L = 2i+1
R = 2i+2
P = floor((i-1)/2)
```

### 1-based

```text
L = 2i
R = 2i+1
P = floor(i/2)
```

---

# 14. Height of Binary Heap

For `n` elements, a complete binary tree has height:

```text
floor(log2 n)
```

when height is measured in edges.

Example:

```text
n = 8
```

Height:

```text
floor(log2 8)
= 3
```

---

# 15. Number of Nodes at Each Level

For level `i`, maximum nodes:

```text
2^i
```

assuming root is level 0.

Therefore:

```text
Level 0 → 1
Level 1 → 2
Level 2 → 4
Level 3 → 8
```

---

# 16. Height Bound

For a binary heap with `n` elements:

```text
height = Θ(log n)
```

This is extremely important.

Therefore operations that move an element along a root-to-leaf path are generally:

```text
O(log n)
```

---

# 17. Heap Operations

Important operations:

```text
1. Find maximum/minimum
2. Insert
3. Delete root
4. Heapify
5. Build heap
```

---

# 18. Find Maximum in Max Heap

The maximum is at:

```text
root
```

Therefore:

```text
Time = O(1)
```

---

# 19. Find Minimum in Min Heap

The minimum is at:

```text
root
```

Therefore:

```text
Time = O(1)
```

---

# 20. Finding Arbitrary Element

Suppose we have a max heap and want to find:

```text
25
```

There is no efficient BST-like path for an arbitrary key.

Worst case:

```text
O(n)
```

### GATE Trap

Heap gives:

```text
O(1) → min/max at root
```

but not:

```text
O(log n) → arbitrary search
```

---

# 21. Insert into Binary Heap

Suppose max heap:

```text
          50
        /    \
       30     40
      / \
     10 20
```

Insert:

```text
60
```

---

# 22. Step 1 — Insert at End

Because heap must remain complete, insert at the next available position:

```text
          50
        /    \
       30     40
      / \    /
     10 20  60
```

Now heap property is violated:

```text
60 > 40
```

---

# 23. Step 2 — Heapify Up

Compare with parent:

```text
60 > 40
```

Swap:

```text
          50
        /    \
       30     60
      / \    /
     10 20  40
```

Again:

```text
60 > 50
```

Swap:

```text
          60
        /    \
       30     50
      / \    /
     10 20  40
```

Heap restored.

---

# 24. Insert Complexity

New element can move from leaf to root.

Height:

```text
O(log n)
```

Therefore:

```text
Insertion = O(log n)
```

---

# 25. Delete Root

For max heap:

```text
delete maximum
```

For min heap:

```text
delete minimum
```

Suppose:

```text
          50
        /    \
       30     40
      / \    /
     10 20  35
```

Delete root `50`.

---

# 26. Delete Root — Step 1

Replace root with last element:

```text
          35
        /    \
       30     40
      / \
     10 20
```

Now heap property is violated:

```text
35 < 40
```

---

# 27. Delete Root — Step 2

Perform:

```text
Heapify Down
```

Compare 35 with children:

```text
30
40
```

For max heap, choose the larger child:

```text
40
```

Swap:

```text
          40
        /    \
       30     35
      / \
     10 20
```

Heap restored.

---

# 28. Delete Root Complexity

The element may move from root to leaf.

Therefore:

```text
O(log n)
```

---

# 29. Heapify Up vs Heapify Down

### Heapify Up

Used after:

```text
Insertion
```

Direction:

```text
Leaf → Root
```

### Heapify Down

Used after:

```text
Delete root
```

Direction:

```text
Root → Leaf
```

### GATE Shortcut

```text
INSERT → UP
DELETE ROOT → DOWN
```

---

# 30. Build Heap

Given an arbitrary array:

```text
[4, 10, 3, 5, 1]
```

we may convert it into a heap.

There are two approaches.

### Approach 1

Insert each element one by one.

Complexity:

```text
O(n log n)
```

### Approach 2

Bottom-up heap construction.

Complexity:

```text
O(n)
```

---

# 31. Bottom-Up Build Heap

Start from the last internal node.

For 0-based indexing:

```text
last internal node =
floor(n/2) - 1
```

Then heapify downward toward the root.

---

# 32. Example

Array:

```text
[4, 10, 3, 5, 1]
```

Indices:

```text
0  1  2  3  4
4 10  3  5  1
```

Last internal node:

```text
floor(5/2)-1
= 2-1
= 1
```

So start from index:

```text
1
```

then:

```text
0
```

---

# 33. Why Build Heap is O(n)?

A common mistake is:

```text
n nodes × O(log n)
= O(n log n)
```

This overestimates the work.

Most nodes are near the leaves and require very little heapification.

Only a small number of nodes can move large distances.

Therefore:

```text
Bottom-up Build Heap = O(n)
```

---

# 34. GATE PYQ Pattern — Build Heap

Question:

> What is the time complexity of constructing a binary heap from an arbitrary array using bottom-up heapification?

Answer:

```text
O(n)
```

### Remember

```text
Repeated insertion → O(n log n)

Bottom-up heapify → O(n)
```

This distinction is frequently tested.

---

# 35. Max Heap Example

Array:

```text
[50, 30, 40, 10, 20, 35]
```

Check:

```text
50 ≥ 30, 40
30 ≥ 10, 20
40 ≥ 35
```

Therefore it is a:

```text
MAX HEAP
```

---

# 36. Is Every Complete Binary Tree a Heap?

No.

Example:

```text
          10
        /    \
       50     20
```

Shape:

```text
Complete
```

But max-heap property:

```text
10 >= 50
```

is false.

Therefore:

```text
Complete tree ≠ necessarily heap
```

---

# 37. Is Every Heap a Complete Binary Tree?

For a standard binary heap:

```text
YES
```

A binary heap must be complete.

---

# 38. Heap Sort

Heap sort uses a binary heap to sort an array.

For ascending order:

```text
Use Max Heap
```

For descending order:

```text
Use Min Heap
```

---

# 39. Heap Sort — Ascending

Suppose:

```text
[4, 1, 3, 2]
```

Build max heap.

Largest element becomes root.

Then:

```text
Swap root with last.
Reduce heap size.
Heapify down.
```

Repeat.

Final result:

```text
[1, 2, 3, 4]
```

---

# 40. Heap Sort Complexity

Build heap:

```text
O(n)
```

Then perform approximately:

```text
n
```

root removals.

Each removal:

```text
O(log n)
```

Therefore:

```text
O(n log n)
```

overall.

---

# 41. Heap Sort Space

Standard in-place heap sort:

```text
Auxiliary array space = O(1)
```

However, the algorithm is:

```text
Not stable
```

in its standard form.

---

# 42. Priority Queue

A binary heap is commonly used to implement a priority queue.

In a max-priority queue:

```text
highest priority = maximum key
```

In a min-priority queue:

```text
highest priority = minimum key
```

---

# 43. Priority Queue Operations

For binary heap:

```text
Insert        = O(log n)
Peek          = O(1)
Extract Max   = O(log n)
Extract Min   = O(log n)
```

depending on heap type.

---

# 44. Heap and Priority Queue

Think:

```text
Priority Queue
       ↓
Common implementation
       ↓
Binary Heap
```

Applications:

```text
Dijkstra
Prim
CPU scheduling
Event simulation
Task scheduling
```

---

# 45. Heap in Dijkstra

Dijkstra repeatedly needs:

```text
vertex with minimum tentative distance
```

A min-priority queue / min heap can efficiently provide it.

Typical complexity with binary heap:

```text
O(E log V)
```

or:

```text
O((V+E) log V)
```

depending on implementation details.

---

# 46. Heap in Prim

Prim repeatedly selects:

```text
minimum-weight edge/key
```

A min-priority queue is commonly used.

Typical complexity:

```text
O(E log V)
```

with adjacency list and binary heap.

---

# 47. Complete Binary Tree Node Count

For height `h`:

Maximum number of nodes:

```text
2^(h+1) - 1
```

For a complete binary tree, the number of nodes can vary between:

```text
2^h
```

and:

```text
2^(h+1)-1
```

for height `h`, assuming height measured in edges.

---

# 48. Number of Leaves in Heap

For a binary heap stored in a 0-based array:

Leaves begin at:

```text
floor(n/2)
```

through:

```text
n-1
```

Therefore number of leaves:

```text
n - floor(n/2)
```

which equals:

```text
ceil(n/2)
```

---

# 49. GATE Trick — Number of Leaves

For `n` heap elements:

```text
Leaves = ceil(n/2)
```

Example:

```text
n = 10
```

Leaves:

```text
ceil(10/2)
= 5
```

---

# 50. Number of Internal Nodes

For a binary heap with `n` nodes:

```text
Internal nodes = floor(n/2)
```

For:

```text
n = 10
```

internal nodes:

```text
5
```

leaves:

```text
5
```

For:

```text
n = 11
```

internal nodes:

```text
5
```

leaves:

```text
6
```

---

# 51. GATE PYQ Pattern — Heap Leaves

Question:

> A binary heap contains 15 elements. How many leaf nodes does it have?

Use:

```text
ceil(n/2)
```

Therefore:

```text
ceil(15/2)
= 8
```

Answer:

```text
8 leaves
```

---

# 52. GATE PYQ Pattern — Parent Index

For a 0-based heap:

```text
i = 10
```

Parent:

```text
floor((10-1)/2)
= floor(9/2)
= 4
```

Therefore:

```text
parent index = 4
```

---

# 53. GATE PYQ Pattern — Children

For:

```text
i = 7
```

0-based heap:

```text
left = 2(7)+1
     = 15

right = 2(7)+2
      = 16
```

If the heap has fewer than 17 elements, these children may not exist.

---

# 54. GATE PYQ Pattern — Maximum in Min Heap

Suppose a min heap has:

```text
n
```

elements.

Question:

> Where can the maximum element be?

It is NOT necessarily at the root.

In a min heap:

```text
Parent <= children
```

Therefore the maximum must be among:

```text
leaf nodes
```

Worst-case search:

```text
O(n)
```

because there can be Θ(n) leaves.

---

# 55. GATE Trick — Maximum in Min Heap

In a min heap:

```text
Minimum → root
Maximum → some leaf
```

In a max heap:

```text
Maximum → root
Minimum → some leaf
```

This is a very important GATE concept.

---

# 56. Finding Second Largest in Max Heap

Largest:

```text
root
```

The second-largest element must be one of the root's children.

Therefore:

```text
Second largest = max(left child, right child)
```

for a max heap with at least two children.

---

# 57. GATE Trick — Second Largest

In a max heap:

```text
Largest = root
Second largest = maximum among root's children
```

Do NOT search the entire heap.

---

# 58. Finding Second Smallest

In a min heap:

```text
Smallest = root
Second smallest = minimum among root's children
```

---

# 59. Can Heap Be Used for Sorting?

Yes.

Heap sort:

```text
Heap
+
Repeated extraction
=
Sorted array
```

Complexity:

```text
O(n log n)
```

---

# 60. Heap Property vs Shape Property

Always check both.

### Shape

```text
Complete binary tree
```

### Order

Max heap:

```text
Parent >= children
```

Min heap:

```text
Parent <= children
```

A structure is a heap only when:

```text
Shape + Order
```

are satisfied.

---

# 61. Heapify

Heapify means restoring heap order in a subtree assuming the subtrees are already heaps.

For max heap:

```text
If root < larger child:
    swap
    continue downward
```

For min heap:

```text
If root > smaller child:
    swap
    continue downward
```

---

# 62. Max-Heapify Pseudocode

```c
MAX_HEAPIFY(A, i, n)
{
    l = 2*i + 1;
    r = 2*i + 2;

    largest = i;

    if (l < n && A[l] > A[largest])
        largest = l;

    if (r < n && A[r] > A[largest])
        largest = r;

    if (largest != i) {
        swap(A[i], A[largest]);
        MAX_HEAPIFY(A, largest, n);
    }
}
```

---

# 63. Heapify Complexity

A single heapify operation can move down by the height of the tree.

Therefore:

```text
Heapify = O(log n)
```

---

# 64. Build Heap Pseudocode

```c
for (i = floor(n/2)-1; i >= 0; i--)
    heapify(A, i, n);
```

Important:

```text
Start from last internal node.
Move toward root.
```

---

# 65. Why Start at n/2 - 1?

For 0-based indexing:

```text
left child = 2i+1
```

A node is internal if it has at least one child.

For the last internal node:

```text
2i + 1 < n
```

Therefore:

```text
i < (n-1)/2
```

The largest integer satisfying this is:

```text
floor(n/2)-1
```

---

# 66. GATE PYQ Pattern — Build Heap Starting Index

For:

```text
n = 12
```

last internal node:

```text
floor(12/2)-1
= 6-1
= 5
```

Therefore bottom-up heapify starts at:

```text
index 5
```

then:

```text
4,3,2,1,0
```

---

# 67. Heap Height Example

If:

```text
n = 31
```

height:

```text
floor(log₂31)
= 4
```

If:

```text
n = 32
```

height:

```text
floor(log₂32)
= 5
```

---

# 68. Important Heap Complexity Table

| Operation            | Binary Heap |
| -------------------- | ----------: |
| Find max in max heap |        O(1) |
| Find min in min heap |        O(1) |
| Insert               |    O(log n) |
| Delete root          |    O(log n) |
| Heapify              |    O(log n) |
| Build heap           |        O(n) |
| Search arbitrary key |        O(n) |
| Heap sort            |  O(n log n) |

---

# 69. Heap vs Array

A heap is stored in an array, but:

```text
Heap ≠ ordinary sorted array
```

Example max heap:

```text
[50, 30, 40, 10, 20, 35]
```

This is NOT globally sorted.

Only parent-child relationships are guaranteed.

---

# 70. Heap vs Sorted Array

Sorted array:

```text
10 20 30 40 50
```

Every element has global ordering.

Heap:

```text
50 30 40 10 20 35
```

Only heap order is guaranteed.

---

# 71. Heap Is Complete but Not Perfect

Example:

```text
          50
        /    \
       30     40
      / \    /
     10 20  35
```

This is:

```text
Complete
```

but:

```text
Not perfect
```

because the last level is not completely filled.

Yet it can still be a valid heap.

---

# 72. Heap and Stability

Heap sort is:

```text
Not stable
```

Why?

Heap operations can move equal-key elements across each other.

Therefore relative order of equal keys is not guaranteed.

---

# 73. Heap and In-Place Property

Heap sort can be performed:

```text
In-place
```

using:

```text
O(1)
```

auxiliary array space.

This is one of its major theoretical advantages.

---

# 74. GATE Comparison — Merge vs Heap

### Merge Sort

```text
O(n log n)
Stable
O(n) auxiliary space
```

### Heap Sort

```text
O(n log n)
Not stable
O(1) auxiliary space
```

Therefore:

> Need worst-case O(n log n) and O(1) extra space?

Think:

```text
Heap Sort
```

---

# 75. GATE Comparison — Quick vs Heap

Quick sort:

```text
Average = O(n log n)
Worst = O(n²)
```

Heap sort:

```text
Worst = O(n log n)
```

Therefore if the question specifically asks for guaranteed worst-case:

```text
Heap Sort
```

---

# 76. GATE PYQ Pattern — Identify Max Heap

Given:

```text
[90, 70, 80, 20, 60, 50]
```

Check:

```text
90 >= 70,80
70 >= 20,60
80 >= 50
```

Therefore:

```text
Valid max heap
```

---

# 77. GATE PYQ Pattern — Identify Invalid Max Heap

Given:

```text
[50, 70, 40]
```

Tree:

```text
       50
      /  \
     70   40
```

Since:

```text
50 < 70
```

max-heap property fails.

Therefore:

```text
Not a max heap
```

---

# 78. GATE PYQ Pattern — Is Complete Tree a Heap?

Given:

```text
       10
      /  \
     20   30
```

It is complete.

But for min heap:

```text
10 <= 20
10 <= 30
```

So it is a:

```text
Min Heap
```

For max heap:

```text
10 >= 20
```

is false.

Therefore:

```text
Not a max heap
```

---

# 79. GATE PYQ Pattern — Delete Maximum

Given max heap:

```text
        100
       /   \
      50    80
     / \    /
    20 30  60
```

Delete 100.

Replace root with last node:

```text
        60
       /  \
      50   80
     / \
    20 30
```

Since:

```text
60 < 80
```

swap:

```text
        80
       /  \
      50   60
     / \
    20 30
```

Final root:

```text
80
```

---

# 80. GATE PYQ Pattern — Insert into Max Heap

Heap:

```text
        50
       /  \
      30   40
```

Insert:

```text
60
```

First:

```text
        50
       /  \
      30   40
     /
    60
```

Compare:

```text
60 > 30
```

Swap:

```text
        50
       /  \
      60   40
```

Then:

```text
60 > 50
```

Swap:

```text
        60
       /  \
      50   40
```

---

# 81. GATE PYQ Pattern — Leaves

Heap has:

```text
n = 20
```

Number of leaves:

```text
ceil(20/2)
= 10
```

Number of internal nodes:

```text
floor(20/2)
= 10
```

---

# 82. GATE PYQ Pattern — Maximum in Min Heap

A min heap contains:

```text
n = 31
```

The maximum element must be in a leaf.

Number of leaves:

```text
ceil(31/2)
= 16
```

Therefore maximum can be found by checking at most:

```text
16
```

leaf nodes.

Worst-case:

```text
O(n)
```

---

# 83. GATE PYQ Pattern — Second Largest

Max heap:

```text
        100
       /   \
      90    80
```

Second largest:

```text
max(90,80)
= 90
```

---

# 84. GATE PYQ Pattern — Heap Height

Heap contains:

```text
n = 100
```

Height:

```text
floor(log₂100)
= 6
```

because:

```text
2^6 = 64
2^7 = 128
```

Thus:

```text
height = 6
```

---

# 85. GATE PYQ Pattern — Build Heap

For an array of:

```text
1000 elements
```

bottom-up construction:

```text
O(1000)
= O(n)
```

Not:

```text
O(n log n)
```

---

# 86. Heap Applications

Binary heaps are used in:

```text
Priority queues
Dijkstra's algorithm
Prim's algorithm
Heap sort
CPU scheduling
Event simulation
K-way merging
Top-K problems
```

---

# 87. Top-K Problems

Suppose we need:

```text
K largest elements
```

A heap can be used efficiently.

For example, maintain a:

```text
Min Heap of size K
```

while scanning the input.

Complexity commonly:

```text
O(n log k)
```

---

# 88. Why Min Heap for K Largest?

Maintain the current K largest elements.

The smallest among these K elements should be easy to remove.

A:

```text
Min Heap
```

keeps the smallest of the selected elements at the root.

If a new element is larger than the root:

```text
remove root
insert new element
```

---

# 89. K Smallest

For K smallest elements, commonly maintain:

```text
Max Heap of size K
```

because the largest among the current K smallest should be easy to remove.

---

# 90. GATE Heap Decision Rules

```text
Need maximum quickly:
Max Heap

Need minimum quickly:
Min Heap

Need priority queue:
Heap

Need O(n log n) worst-case sort:
Heap Sort

Need O(1) extra space sorting:
Heap Sort

Need build heap:
Bottom-up = O(n)

Need arbitrary search:
Heap is not efficient → O(n)
```

---

# 91. Most Important Formulas

```text
0-based:

left(i)  = 2i+1
right(i) = 2i+2
parent(i)= floor((i-1)/2)

1-based:

left(i)  = 2i
right(i) = 2i+1
parent(i)= floor(i/2)

Height:
floor(log₂ n)

Leaves:
ceil(n/2)

Internal nodes:
floor(n/2)

Build heap:
O(n)

Heapify:
O(log n)

Insert:
O(log n)

Delete root:
O(log n)

Peek:
O(1)

Heap sort:
O(n log n)
```

---

# 92. One-Minute Revision

```text
BINARY HEAP:

1. Complete binary tree.
2. Stored efficiently in an array.

MAX HEAP:
Parent >= children.
Maximum at root.

MIN HEAP:
Parent <= children.
Minimum at root.

INSERT:
Add at end → heapify up.

DELETE ROOT:
Replace with last → heapify down.

BUILD HEAP:
Bottom-up → O(n).

HEAPIFY:
O(log n).

SEARCH:
O(n).

HEAP SORT:
O(n log n).

SPACE:
O(1) for in-place heap sort.

LEAVES:
ceil(n/2).

INTERNAL:
floor(n/2).

HEIGHT:
floor(log₂ n).
```

---

# 93. Final GATE Checklist

* [ ] Max heap
* [ ] Min heap
* [ ] Complete binary tree
* [ ] Heap array representation
* [ ] 0-based indexing
* [ ] 1-based indexing
* [ ] Parent/child formulas
* [ ] Heap height
* [ ] Heapify up
* [ ] Heapify down
* [ ] Insertion
* [ ] Root deletion
* [ ] Bottom-up build heap
* [ ] O(n) build heap proof/intution
* [ ] Heap sort
* [ ] Priority queue
* [ ] Number of leaves
* [ ] Number of internal nodes
* [ ] Maximum/minimum location
* [ ] Second largest/smallest
* [ ] Heap vs BST
* [ ] Heap vs complete tree
* [ ] Dijkstra using heap
* [ ] Prim using heap
* [ ] Top-K using heap

---

# 94. Final GATE Rules

RULE 1:
A binary heap must be a complete binary tree.

RULE 2:
Max heap:
parent >= children.

RULE 3:
Min heap:
parent <= children.

RULE 4:
Max element in max heap = root.

RULE 5:
Min element in min heap = root.

RULE 6:
Arbitrary search in heap can take O(n).

RULE 7:
Insertion:
place at end, then heapify up.

RULE 8:
Delete root:
replace by last element, then heapify down.

RULE 9:
Heapify = O(log n).

RULE 10:
Build heap using bottom-up heapification = O(n).

RULE 11:
Repeated insertion to build heap = O(n log n).

RULE 12:
For 0-based indexing:
left = 2i+1,
right = 2i+2.

RULE 13:
For 1-based indexing:
left = 2i,
right = 2i+1.

RULE 14:
Number of leaves = ceil(n/2).

RULE 15:
Number of internal nodes = floor(n/2).

RULE 16:
Height of heap = floor(log₂ n).

RULE 17:
Second largest in max heap is one of root's children.

RULE 18:
Maximum in a min heap must be a leaf.

RULE 19:
Heap sort = O(n log n).

RULE 20:
Standard heap sort is in-place but not stable.

RULE 21:
Heap is not a BST.

RULE 22:
Complete tree does not automatically mean heap.

RULE 23:
For K largest → commonly use min heap of size K.

RULE 24:
For K smallest → commonly use max heap of size K.

RULE 25:
Always check BOTH:
shape property + heap-order property.

```

# END — Binary Heap
```
