# Trees - Basics

## What is a Tree?
A **Tree** is a hierarchical (parent-child) data structure made up of **nodes** connected by **edges**.

Example:
```
        A
      /   \
     B     C
    / \     \
   D   E     F
```

---

## Terminology

- **Node** → A single element in a tree.
- **Root** → Topmost node (A).
- **Parent** → Node having children.
- **Child** → Node connected below a parent.
- **Leaf Node** → Node with no children (D, E, F).
- **Edge** → Connection between two nodes.
- **Sibling** → Nodes with the same parent (B and C).
- **Subtree** → Tree formed from any node and its descendants.

---

## Important Terms

### Degree
Number of children of a node.

Example:
- Degree of A = 2
- Degree of C = 1

### Depth
Number of edges from the **root** to a node.

Example:
- Depth of A = 0
- Depth of D = 2

### Height of a Node
Longest path (in edges) from that node to a leaf.

Example:
- Height of D = 0
- Height of B = 1
- Height of A = 2

### Height of Tree
Height of the root node.

---

## Types of Trees

- Binary Tree
- Binary Search Tree (BST)
- AVL Tree
- Heap
- Trie
- Segment Tree

---

## Why Trees?

Trees are used for:
- File systems
- Database indexing
- Search operations
- Expression evaluation
- Routing
- Hierarchical data

---

## Binary Tree

A tree where every node has **at most 2 children**:
- Left Child
- Right Child

Example:
```
      10
     /  \
    5   20
```

---

## Time Complexity

| Operation | Complexity |
|-----------|------------|
| Traversal | O(n) |
| Search (General Tree) | O(n) |
| Search (BST Average) | O(log n) |

---

## Interview Questions

1. What is a tree?
2. Difference between Tree and Graph?
3. What is Root, Leaf, Parent and Child?
4. What is Height vs Depth?
5. What is a Binary Tree?
6. What is a Subtree?
7. Why are trees used?

---

## Quick Revision

- Tree = Hierarchical structure
- Root = Top node
- Leaf = No children
- Edge = Connection
- Height = Longest path to leaf
- Depth = Distance from root
- Binary Tree = Max 2 children
- Traversal = Visit every node