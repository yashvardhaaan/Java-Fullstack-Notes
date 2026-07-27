# Binary Tree

## What is a Binary Tree?

A **Binary Tree** is a tree in which **each node can have at most two children**:
- Left Child
- Right Child

Example:
```
        1
      /   \
     2     3
    / \     \
   4   5     6
```

---

## Binary Tree Node (C++)

```cpp
struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;

    TreeNode(int x) {
        val = x;
        left = nullptr;
        right = nullptr;
    }
};
```

---

## Terminology

- **Root** → Topmost node
- **Parent** → Node having children
- **Child** → Node below a parent
- **Leaf Node** → Node with no children
- **Left Child** → Left subtree
- **Right Child** → Right subtree

---

## Types of Binary Trees

### 1. Full Binary Tree
Every node has either **0 or 2 children**.

```
      1
     / \
    2   3
```

---

### 2. Complete Binary Tree
All levels are completely filled except possibly the last, which is filled from **left to right**.

```
      1
     / \
    2   3
   / \  /
  4  5 6
```

---

### 3. Perfect Binary Tree
All internal nodes have **2 children** and **all leaves are at the same level**.

```
        1
      /   \
     2     3
    / \   / \
   4  5  6  7
```

---

### 4. Balanced Binary Tree
For every node:

```
|Height(Left) - Height(Right)| ≤ 1
```

Search operations are efficient.

---

### 5. Degenerate (Skewed) Binary Tree
Every node has only **one child**.

Left Skewed
```
    1
   /
  2
 /
3
```

Right Skewed
```
1
 \
  2
   \
    3
```

Worst-case height = **n - 1**

---

## Properties

- Maximum children = **2**
- Number of edges = **Nodes - 1**
- Height of single node tree = **0**
- Maximum nodes at level `L`:

```
2^L
```

(Level starts from **0**)

Example:
| Level | Max Nodes |
|------|-----------|
| 0 | 1 |
| 1 | 2 |
| 2 | 4 |
| 3 | 8 |

---

## Maximum Nodes

For height `h`:

```
Maximum Nodes = 2^(h+1) - 1
```

Example:

Height = 2

```
2^(2+1)-1 = 7
```

---

## Traversals

### DFS

1. Preorder (Root → Left → Right)
2. Inorder (Left → Root → Right)
3. Postorder (Left → Right → Root)

---

### BFS

Level Order Traversal

```
Visit level by level using Queue
```

---

## Time Complexity

| Operation | Complexity |
|-----------|------------|
| Traversal | O(n) |
| Search | O(n) |
| Insert | O(n) |
| Delete | O(n) |

---

## Where Binary Trees are Used?

- Binary Search Trees (BST)
- Heaps
- Expression Trees
- Huffman Coding
- Decision Trees
- File Systems

---

## Interview Questions

1. What is a Binary Tree?
2. Difference between Full, Complete and Perfect Binary Tree?
3. What is a Balanced Binary Tree?
4. What is a Skewed Binary Tree?
5. Difference between DFS and BFS?
6. Name the three DFS traversals.
7. Why is a Binary Tree different from a BST?

---

## Quick Revision

- Max 2 children
- Left & Right child
- Full → 0 or 2 children
- Complete → Last level filled left to right
- Perfect → All levels full
- Balanced → Height difference ≤ 1
- Skewed → One child only
- DFS → Pre, In, Post
- BFS → Level Order
- Traversal = O(n)
```