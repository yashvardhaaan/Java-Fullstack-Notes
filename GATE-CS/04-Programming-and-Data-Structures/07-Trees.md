# 07 — Trees.md

````md
# 07 — Trees
## GATE CSE/IT Notes + Tricks + PYQ Patterns + Practice

---

# 1. What is a Tree?

A **tree** is a connected hierarchical data structure with no cycles.

Example:

```text
             A
           /   \
          B     C
         / \   / \
        D   E F   G
````

Important:

* A tree with `n` vertices has exactly `n - 1` edges.
* There is exactly one simple path between any two vertices.
* A tree is connected and acyclic.

---

# 2. Basic Terminology

### Root

Topmost node.

```text
A
```

### Parent

Node immediately above another node.

```text
A
|
B
```

A is parent of B.

### Child

Node immediately below another node.

B is child of A.

### Siblings

Nodes having the same parent.

```text
    A
   / \
  B   C
```

B and C are siblings.

---

# 3. Leaf Node

A node having no children is called a **leaf**.

Example:

```text
        A
       / \
      B   C
     / \
    D   E
```

Leaves:

```text
C, D, E
```

---

# 4. Internal Node

A node having at least one child is an internal/non-leaf node.

For:

```text
        A
       / \
      B   C
     / \
    D   E
```

Internal nodes:

```text
A, B
```

---

# 5. Degree of a Node

Degree of a node = number of children.

Example:

```text
        A
      / | \
     B  C  D
```

Degree of A:

```text
3
```

For a leaf:

```text
degree = 0
```

---

# 6. Degree of a Tree

The degree of a tree is the maximum degree of any node in the tree.

Example:

```text
       A
     / | \
    B  C  D
```

Degree of tree:

```text
3
```

---

# 7. Depth of a Node

Depth = number of edges from root to that node.

Using:

```text
             A
           /   \
          B     C
         / \
        D   E
```

Depth:

```text
A = 0
B = 1
C = 1
D = 2
E = 2
```

### GATE Trick

Depth is based on:

```text
ROOT → NODE
```

Count **edges**, not nodes.

---

# 8. Height of a Node

Height of a node = number of edges on the longest downward path from that node to a leaf.

For:

```text
        A
       /
      B
     /
    C
```

```text
height(C) = 0
height(B) = 1
height(A) = 2
```

---

# 9. Height of Tree

Height of tree = height of root.

Equivalent:

```text
maximum depth of any node
```

Example:

```text
        A
       / \
      B   C
     /
    D
```

Maximum depth:

```text
D = 2
```

Therefore:

```text
Tree height = 2
```

---

# 10. GATE Height Trap

Some questions define root level as:

```text
level(root) = 0
```

Others may use:

```text
level(root) = 1
```

Therefore always check the definition.

If root level = 0:

```text
height in edges = maximum level
```

---

# 11. Ancestor and Descendant

For:

```text
        A
       /
      B
     /
    C
```

A is ancestor of:

```text
B, C
```

B is ancestor of:

```text
C
```

C is descendant of:

```text
A, B
```

---

# 12. Subtree

For:

```text
        A
       / \
      B   C
     / \
    D   E
```

Subtree rooted at B:

```text
      B
     / \
    D   E
```

---

# 13. Binary Tree

A binary tree is a tree in which each node has at most two children.

They are called:

```text
left child
right child
```

Example:

```text
        A
       / \
      B   C
```

A node can have:

```text
0 children
1 child
2 children
```

but never more than 2.

---

# 14. Types of Binary Trees

Important for GATE:

1. Full binary tree
2. Complete binary tree
3. Perfect binary tree
4. Balanced binary tree
5. Degenerate/skewed tree
6. Binary Search Tree

---

# 15. Full Binary Tree

A full binary tree is one where every node has either:

```text
0 children
OR
2 children
```

No node has exactly one child.

Example:

```text
        A
       / \
      B   C
         / \
        D   E
```

Valid full binary tree.

---

# 16. Full Binary Tree Formula

Let:

```text
I = number of internal nodes
L = number of leaves
```

For a full binary tree:

```text
L = I + 1
```

Total nodes:

```text
N = 2I + 1
```

Therefore:

```text
I = (N - 1)/2
L = (N + 1)/2
```

### GATE Shortcut

If a binary tree is explicitly **full**:

```text
Leaves = Internal nodes + 1
```

---

# 17. Complete Binary Tree

A complete binary tree has:

* Every level completely filled except possibly the last.
* Last level is filled from **left to right**.

Example:

```text
        A
       / \
      B   C
     / \  /
    D  E F
```

This is complete.

---

# 18. Complete Tree vs Full Tree

Do not confuse them.

### Full

Every node has:

```text
0 or 2 children
```

### Complete

Last level:

```text
filled from left to right
```

A complete tree may contain a node with only one child.

---

# 19. Perfect Binary Tree

A perfect binary tree has:

* Every internal node has exactly 2 children.
* All leaves are at the same level.

Example:

```text
          A
        /   \
       B     C
      / \   / \
     D  E  F  G
```

---

# 20. Perfect Binary Tree Formulas

If height is `h` and root is at height 0:

Total nodes:

```text
N = 2^(h+1) - 1
```

Leaves:

```text
L = 2^h
```

Internal nodes:

```text
I = 2^h - 1
```

Edges:

```text
E = N - 1
```

---

# 21. Example

Perfect binary tree with:

```text
h = 3
```

Total nodes:

```text
2^(3+1) - 1
= 16 - 1
= 15
```

Leaves:

```text
2^3 = 8
```

---

# 22. Maximum Nodes at Level

For a binary tree:

```text
level = i
```

maximum number of nodes:

```text
2^i
```

assuming root is at level 0.

Therefore:

```text
level 0 → 1
level 1 → 2
level 2 → 4
level 3 → 8
```

---

# 23. Maximum Nodes in Binary Tree of Height h

Maximum:

```text
2^(h+1) - 1
```

because:

```text
1 + 2 + 4 + ... + 2^h
```

is a geometric series.

---

# 24. Minimum Nodes for Height h

A binary tree can be completely skewed.

Therefore minimum nodes:

```text
h + 1
```

Example:

```text
A
 \
  B
   \
    C
     \
      D
```

Height:

```text
3
```

Nodes:

```text
4 = h + 1
```

---

# 25. Height Bounds for Binary Tree

For `N` nodes:

Minimum possible height:

```text
ceil(log2(N + 1)) - 1
```

Maximum possible height:

```text
N - 1
```

assuming height is measured in edges.

### GATE Shortcut

```text
Minimum height → balanced/perfect-like
Maximum height → skewed
```

---

# 26. Skewed Binary Tree

Every node has only one child.

Example:

```text
A
 \
  B
   \
    C
     \
      D
```

Height:

```text
N - 1
```

This behaves like a linked list.

---

# 27. Binary Tree Representation

## Linked Representation

```c
struct Node {
    int data;
    struct Node *left;
    struct Node *right;
};
```

Example:

```text
       A
      / \
     B   C
```

Each node stores:

```text
data
left pointer
right pointer
```

---

# 28. Array Representation

Binary trees can be represented using arrays, especially complete binary trees.

Using **0-based indexing**:

For node at index `i`:

```text
left child  = 2i + 1
right child = 2i + 2
parent      = floor((i - 1)/2)
```

---

# 29. 1-Based Indexing

If root is at index 1:

```text
left child  = 2i
right child = 2i + 1
parent      = floor(i/2)
```

### GATE Trap

Do not mix:

```text
0-based formulas
```

with:

```text
1-based formulas
```

---

# 30. Tree Traversals

Four important traversals:

```text
Preorder
Inorder
Postorder
Level order
```

For:

```text
        A
       / \
      B   C
     / \
    D   E
```

---

# 31. Preorder

Order:

```text
ROOT → LEFT → RIGHT
```

For the example:

```text
A B D E C
```

Mnemonic:

```text
PRE = ROOT first
```

---

# 32. Inorder

Order:

```text
LEFT → ROOT → RIGHT
```

Example:

```text
D B E A C
```

Mnemonic:

```text
IN = ROOT in the middle
```

---

# 33. Postorder

Order:

```text
LEFT → RIGHT → ROOT
```

Example:

```text
D E B C A
```

Mnemonic:

```text
POST = ROOT last
```

---

# 34. Level Order

Visit nodes level by level.

Example:

```text
        A
       / \
      B   C
     / \
    D   E
```

Level order:

```text
A B C D E
```

Usually implemented using:

```text
Queue
```

---

# 35. Traversal Memory Trick

Remember:

```text
Preorder:
ROOT LEFT RIGHT

Inorder:
LEFT ROOT RIGHT

Postorder:
LEFT RIGHT ROOT
```

Only the position of:

```text
ROOT
```

changes.

---

# 36. Traversal PYQ Pattern

Given:

```text
        1
       / \
      2   3
     / \
    4   5
```

### Preorder

```text
1 2 4 5 3
```

### Inorder

```text
4 2 5 1 3
```

### Postorder

```text
4 5 2 3 1
```

### Level order

```text
1 2 3 4 5
```

---

# 37. Inorder Traversal of BST

One of the most important GATE facts:

> Inorder traversal of a Binary Search Tree produces sorted order.

Example:

```text
        50
       /  \
      30   70
     / \   / \
    20 40 60 80
```

Inorder:

```text
20 30 40 50 60 70 80
```

Therefore:

```text
BST + inorder = sorted sequence
```

---

# 38. Binary Search Tree (BST)

A Binary Search Tree satisfies:

```text
All keys in left subtree < root
All keys in right subtree > root
```

assuming distinct keys.

Example:

```text
        50
       /  \
      30   70
     / \   / \
    20 40 60 80
```

---

# 39. BST Search

At every node:

```text
key < node
→ go left
```

```text
key > node
→ go right
```

```text
key == node
→ found
```

---

# 40. BST Complexity

For height `h`:

```text
Search = O(h)
Insert = O(h)
Delete = O(h)
```

Balanced BST:

```text
h = O(log n)
```

Therefore:

```text
Search = O(log n)
Insert = O(log n)
Delete = O(log n)
```

Worst-case skewed BST:

```text
h = O(n)
```

Therefore:

```text
Search = O(n)
```

---

# 41. BST Insertion

Insert:

```text
65
```

into:

```text
        50
       /  \
      30   70
```

Since:

```text
65 > 50
65 < 70
```

insert:

```text
        50
       /  \
      30   70
          /
         65
```

---

# 42. BST Minimum

Minimum value is obtained by repeatedly going:

```text
LEFT
```

Example:

```text
        50
       /
      30
     /
    20
```

Minimum:

```text
20
```

---

# 43. BST Maximum

Maximum value is obtained by repeatedly going:

```text
RIGHT
```

---

# 44. BST Successor

For a node, its inorder successor is the next larger key.

If the node has a right subtree:

```text
successor = minimum of right subtree
```

Example:

```text
       50
         \
          70
         /
        60
```

Successor of 50:

```text
60
```

---

# 45. BST Predecessor

If a node has a left subtree:

```text
predecessor = maximum of left subtree
```

Example:

```text
        50
       /
      30
        \
         40
```

Predecessor of 50:

```text
40
```

---

# 46. BST Deletion

Three cases.

## Case 1 — Leaf

Delete directly.

```text
    50
   /
  30
```

Delete 30:

```text
50
```

---

# 47. BST Deletion — One Child

Example:

```text
    50
   /
  30
    \
     40
```

Delete 30.

Connect parent directly to child:

```text
50
/
40
```

---

# 48. BST Deletion — Two Children

Example:

```text
       50
      /  \
     30   70
         / \
        60 80
```

Delete 70.

Replace with either:

```text
inorder successor
```

or:

```text
inorder predecessor
```

For successor:

```text
60
```

---

# 49. GATE BST Deletion Trick

Two-child deletion:

```text
Successor = minimum of right subtree
```

or:

```text
Predecessor = maximum of left subtree
```

Both produce a valid BST.

---

# 50. BST Construction from Insertion Sequence

Suppose values are inserted in this order:

```text
50, 30, 70, 20, 40
```

Start:

```text
50
```

30:

```text
  50
 /
30
```

70:

```text
  50
 /  \
30   70
```

20:

```text
    50
   /  \
  30   70
 /
20
```

40:

```text
    50
   /  \
  30   70
 / \
20 40
```

---

# 51. GATE PYQ Pattern — BST Insertion Order

Given a sequence of keys and asked to construct a BST:

### Method

Insert one key at a time.

For every key:

```text
smaller → left
larger → right
```

Do not sort the sequence first.

The insertion order matters.

---

# 52. Same BST from Different Sequences

Different insertion sequences can produce the same BST.

Example:

```text
50, 30, 70, 20, 40
```

and:

```text
50, 70, 30, 40, 20
```

can produce the same structure.

### GATE Idea

The root must appear first.

Relative ordering of elements within left/right subtrees matters.

---

# 53. Number of Binary Trees from Inorder + Preorder

For distinct keys:

```text
Inorder + Preorder
```

uniquely determines the binary tree.

Similarly:

```text
Inorder + Postorder
```

uniquely determines the tree.

But:

```text
Preorder + Postorder
```

does NOT generally uniquely determine a binary tree.

---

# 54. Important Traversal Fact

For a binary tree with distinct nodes:

```text
Inorder + Preorder → unique tree
Inorder + Postorder → unique tree
```

But:

```text
Preorder + Postorder → not necessarily unique
```

### GATE Trap

Do not say any two traversals always uniquely determine the tree.

Inorder is the key traversal for uniqueness.

---

# 55. Full Binary Tree and Preorder + Postorder

For a **full binary tree**, preorder and postorder together can determine the tree structure under the usual distinct-node setting.

Why?

Every internal node has exactly two children, eliminating the ambiguity caused by a single-child node.

---

# 56. AVL Tree

AVL tree is a self-balancing Binary Search Tree.

Balance factor:

```text
BF = height(left subtree) - height(right subtree)
```

For every node:

```text
BF ∈ {-1, 0, +1}
```

---

# 57. AVL Balance Factor

Example:

```text
        30
       /  \
      20   40
```

If both subtrees have equal height:

```text
BF = 0
```

If left is one level taller:

```text
BF = +1
```

If right is one level taller:

```text
BF = -1
```

---

# 58. AVL Violations

If:

```text
|BF| > 1
```

the node is unbalanced.

Possible rotations:

```text
LL
RR
LR
RL
```

---

# 59. LL Rotation

Insertion occurs in:

```text
Left subtree of Left child
```

Perform:

```text
Right rotation
```

Example:

```text
      30
     /
    20
   /
  10
```

After right rotation:

```text
      20
     /  \
    10   30
```

---

# 60. RR Rotation

Insertion occurs in:

```text
Right subtree of Right child
```

Perform:

```text
Left rotation
```

Example:

```text
10
  \
   20
     \
      30
```

After rotation:

```text
      20
     /  \
    10   30
```

---

# 61. LR Rotation

Insertion occurs in:

```text
Left subtree of Right? 
```

More precisely:

```text
Left subtree of Left child
```

No — that is LL.

LR means:

```text
Left subtree of the Right? 
```

The correct structural description is:

```text
Right subtree of Left child
```

Example:

```text
      30
     /
    10
      \
       20
```

Perform:

```text
Left rotation on 10
then right rotation on 30
```

Result:

```text
      20
     /  \
    10   30
```

---

# 62. RL Rotation

RL means:

```text
Left subtree of Right child
```

Example:

```text
10
  \
   30
  /
 20
```

Perform:

```text
Right rotation on 30
then left rotation on 10
```

Result:

```text
      20
     /  \
    10   30
```

---

# 63. AVL Rotation Memory Trick

```text
LL → Right rotation
RR → Left rotation

LR → Left + Right
RL → Right + Left
```

For double rotations:

```text
First rotate child side,
then rotate unbalanced node.
```

---

# 64. AVL Complexity

Because AVL remains balanced:

```text
Search = O(log n)
Insert = O(log n)
Delete = O(log n)
```

Height:

```text
O(log n)
```

---

# 65. Heap

A heap is a **complete binary tree** satisfying the heap-order property.

Two types:

```text
Max Heap
Min Heap
```

---

# 66. Max Heap

Every parent is:

```text
≥ its children
```

Example:

```text
       50
      /  \
     30   40
    / \
   10 20
```

Maximum element is at root.

---

# 67. Min Heap

Every parent is:

```text
≤ its children
```

Minimum element is at root.

---

# 68. Heap vs BST

| Feature              | Heap     | BST                      |
| -------------------- | -------- | ------------------------ |
| Shape                | Complete | Not necessarily complete |
| Root                 | Min/max  | Depends on keys          |
| Search arbitrary key | O(n)     | O(h)                     |
| Insert               | O(log n) | O(h)                     |
| Delete root          | O(log n) | Depends                  |
| Get min/max          | O(1)     | O(h) generally           |
| Sorted inorder       | No       | Yes                      |

### GATE Trap

A heap is **not** a BST.

---

# 69. Heap Array Representation

For 0-based array:

```text
left(i)  = 2i + 1
right(i) = 2i + 2
parent(i) = floor((i-1)/2)
```

For 1-based:

```text
left(i)  = 2i
right(i) = 2i + 1
parent(i) = floor(i/2)
```

---

# 70. Build Heap

Given an arbitrary array:

```text
[...]
```

Build heap using bottom-up heapify.

Important complexity:

```text
Build Heap = O(n)
```

### GATE Trap

Do NOT say:

```text
Build heap = O(n log n)
```

for the standard bottom-up heap construction.

---

# 71. Heap Insertion

Insert at the next available position to preserve completeness.

Then:

```text
Bubble Up / Heapify Up
```

until heap property is restored.

Complexity:

```text
O(log n)
```

---

# 72. Heap Deletion

Usually deletion refers to deleting the root.

Steps:

```text
1. Replace root with last element.
2. Remove last element.
3. Heapify down.
```

Complexity:

```text
O(log n)
```

---

# 73. Priority Queue

A priority queue removes elements according to priority rather than arrival order.

Heap is commonly used.

For binary heap:

```text
Insert      = O(log n)
Delete max  = O(log n)
Delete min  = O(log n)
Peek        = O(1)
```

depending on heap type.

---

# 74. Heap Sort

Steps:

```text
1. Build heap.
2. Repeatedly remove root.
3. Restore heap.
```

Complexity:

```text
O(n log n)
```

Worst case:

```text
O(n log n)
```

Extra array space:

```text
O(1)
```

for standard in-place heap sort.

---

# 75. Tree Traversal Complexity

For a tree with `n` nodes:

```text
Preorder  = O(n)
Inorder   = O(n)
Postorder = O(n)
Level     = O(n)
```

Every node is processed a constant number of times.

---

# 76. Recursive Traversal Space

Recursive DFS traversal requires call stack proportional to tree height:

```text
O(h)
```

For balanced tree:

```text
h = O(log n)
```

For skewed tree:

```text
h = O(n)
```

Therefore:

```text
Balanced → O(log n)
Skewed   → O(n)
```

---

# 77. Level Order Space

Level-order traversal uses a queue.

Worst-case queue size can be:

```text
O(n)
```

For a wide tree.

Therefore:

```text
Time  = O(n)
Space = O(n)
```

---

# 78. Tree Height and Recursion

For recursive tree algorithms, always ask:

```text
What is h?
```

Then:

```text
Recursive stack = O(h)
```

If tree is balanced:

```text
O(log n)
```

If skewed:

```text
O(n)
```

---

# 79. GATE PYQ Pattern — Traversal Identification

If a sequence is generated by:

```text
Root → Left → Right
```

answer:

```text
Preorder
```

If:

```text
Left → Root → Right
```

answer:

```text
Inorder
```

If:

```text
Left → Right → Root
```

answer:

```text
Postorder
```

---

# 80. GATE PYQ Pattern — BST Sorted Traversal

Question:

> Which traversal of a BST gives sorted order?

Answer:

```text
Inorder
```

For ascending order:

```text
Left → Root → Right
```

For descending order:

```text
Right → Root → Left
```

---

# 81. GATE PYQ Pattern — Number of Edges

If a tree has:

```text
n nodes
```

then:

```text
edges = n - 1
```

This applies to:

```text
Any tree
```

not just binary trees.

---

# 82. GATE PYQ Pattern — Full Binary Tree

If a full binary tree has:

```text
I internal nodes
```

then:

```text
L = I + 1
```

and:

```text
N = 2I + 1
```

Example:

```text
I = 10
```

Then:

```text
L = 11
N = 21
```

---

# 83. GATE PYQ Pattern — Perfect Tree

Given height:

```text
h = 5
```

Perfect binary tree:

```text
Nodes = 2^(6) - 1 = 63
Leaves = 2^5 = 32
```

---

# 84. GATE PYQ Pattern — Height Bounds

Given:

```text
n = 15
```

Binary tree minimum height:

```text
ceil(log2(16)) - 1
= 4 - 1
= 3
```

Maximum height:

```text
15 - 1
= 14
```

---

# 85. GATE PYQ Pattern — Array Indexing

For 0-based heap:

```text
i = 4
```

Left child:

```text
2(4)+1 = 9
```

Right child:

```text
2(4)+2 = 10
```

Parent:

```text
floor((4-1)/2)
= 1
```

---

# 86. GATE PYQ Pattern — Complete Tree

Given an array representation of a complete binary tree:

```text
[10, 20, 30, 40, 50, 60]
```

Tree:

```text
          10
        /    \
       20     30
      / \    /
     40 50  60
```

The last level is filled:

```text
left → right
```

---

# 87. GATE PYQ Pattern — BST Complexity

Question:

> What is the worst-case search complexity in a BST with n nodes?

If the tree becomes:

```text
skewed
```

then:

```text
height = n - 1
```

Therefore:

```text
Search = O(n)
```

---

# 88. GATE PYQ Pattern — Balanced BST

For a balanced BST:

```text
height = O(log n)
```

Therefore:

```text
Search = O(log n)
Insertion = O(log n)
Deletion = O(log n)
```

---

# 89. GATE PYQ Pattern — AVL Balance

Suppose:

```text
height(left) = 4
height(right) = 2
```

Balance factor:

```text
BF = 4 - 2
   = 2
```

Therefore:

```text
Unbalanced
```

An AVL node must have:

```text
BF = -1, 0, +1
```

---

# 90. Important Tree Relationships

For a binary tree:

```text
Maximum nodes at level i = 2^i
```

Maximum nodes with height h:

```text
2^(h+1)-1
```

Minimum nodes with height h:

```text
h+1
```

Any tree with n nodes:

```text
edges = n-1
```

---

# 91. Binary Tree Cheat Sheet

```text
FULL:
0 or 2 children

COMPLETE:
last level left-filled

PERFECT:
all internal nodes have 2 children
all leaves same level

SKEWED:
each node has at most one child

BST:
left < root < right

AVL:
BST + balance factor ∈ {-1,0,+1}

HEAP:
complete tree + heap order
```

---

# 92. Traversal Cheat Sheet

```text
PREORDER:
Root Left Right

INORDER:
Left Root Right

POSTORDER:
Left Right Root

LEVEL ORDER:
Level by level
```

Mnemonic:

```text
PRE  → Root before children
IN   → Root between children
POST → Root after children
```

---

# 93. Heap Cheat Sheet

```text
MAX HEAP:
parent ≥ children

MIN HEAP:
parent ≤ children

Shape:
Complete binary tree

Insert:
O(log n)

Delete root:
O(log n)

Peek:
O(1)

Build heap:
O(n)

Heap sort:
O(n log n)
```

---

# 94. BST Cheat Sheet

```text
Search:
O(h)

Insert:
O(h)

Delete:
O(h)

Balanced:
h = O(log n)

Worst case:
h = O(n)

Minimum:
leftmost

Maximum:
rightmost

Successor:
minimum of right subtree

Predecessor:
maximum of left subtree

Sorted traversal:
inorder
```

---

# 95. Most Important GATE Topics

### 🔥🔥🔥 Very High Priority

```text
Binary tree properties
Tree traversals
BST
BST insertion/deletion
Tree height
Full/complete/perfect trees
Heap
Heap array indexing
Heapify
AVL rotations
```

### 🔥🔥 High Priority

```text
Successor/predecessor
Traversal reconstruction
Level-order traversal
Recursive tree complexity
Number of possible trees
```

---

# 96. GATE Exam Strategy

When given a tree diagram:

### Step 1

Identify:

```text
Root
```

### Step 2

Mark:

```text
left subtree
right subtree
```

### Step 3

If traversal is asked:

```text
Write Root/Left/Right order first.
```

### Step 4

If BST:

```text
Compare key with current node.
```

### Step 5

If heap:

```text
Check completeness + parent-child relation.
```

### Step 6

For complexity:

```text
Think in terms of height h.
```

---

# 97. Final GATE Rules

```text
RULE 1:
A tree with n nodes has n-1 edges.

RULE 2:
Preorder = Root Left Right.

RULE 3:
Inorder = Left Root Right.

RULE 4:
Postorder = Left Right Root.

RULE 5:
Inorder traversal of BST gives sorted order.

RULE 6:
BST operations are O(h), not always O(log n).

RULE 7:
Skewed BST has O(n) height.

RULE 8:
Balanced BST has O(log n) height.

RULE 9:
Full binary tree:
Leaves = Internal nodes + 1.

RULE 10:
Perfect binary tree:
Nodes = 2^(h+1)-1.

RULE 11:
Complete binary tree is filled left-to-right at last level.

RULE 12:
Heap must be complete.

RULE 13:
Build heap using bottom-up heapify = O(n).

RULE 14:
AVL balance factor must be -1, 0, or +1.

RULE 15:
LL → Right rotation.
RR → Left rotation.

RULE 16:
Recursive tree traversal space = O(h).

RULE 17:
Always check whether indexing is 0-based or 1-based.

RULE 18:
Do not confuse Heap with BST.
```

---

# 98. Final Revision Table

| Topic                       | Must Remember          |
| --------------------------- | ---------------------- |
| Tree edges                  | n - 1                  |
| Binary max nodes at level i | 2^i                    |
| Binary max nodes height h   | 2^(h+1)-1              |
| Binary min nodes height h   | h+1                    |
| Full tree                   | 0 or 2 children        |
| Complete tree               | Last level left-filled |
| Perfect tree                | All levels full        |
| BST inorder                 | Sorted                 |
| BST operation               | O(h)                   |
| Balanced BST                | O(log n)               |
| Skewed BST                  | O(n)                   |
| Heap shape                  | Complete               |
| Build heap                  | O(n)                   |
| Heap insertion              | O(log n)               |
| Heap root deletion          | O(log n)               |
| AVL BF                      | -1, 0, +1              |
| LL                          | Right rotation         |
| RR                          | Left rotation          |
| Level order                 | Queue                  |

---

# END — 07 Trees

```
```
