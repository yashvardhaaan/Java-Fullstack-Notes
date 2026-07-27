# Binary Search Tree (BST)

## What is a Binary Search Tree?

A **Binary Search Tree (BST)** is a Binary Tree where:

- All nodes in the **left subtree** are **smaller** than the current node.
- All nodes in the **right subtree** are **greater** than the current node.
- Both left and right subtrees are also BSTs.

Example:

```
        8
      /   \
     3     10
    / \      \
   1   6      14
      / \     /
     4   7   13
```

---

## BST Property

For every node:

```
Left Subtree < Root < Right Subtree
```

---

## Binary Tree vs BST

| Binary Tree | Binary Search Tree |
|-------------|--------------------|
| No ordering rule | Follows ordering rule |
| Search takes O(n) | Search takes O(log n) average |
| Any arrangement | Left < Root < Right |

---

## BST Node (C++)

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

## Operations

### 1. Search

Compare with current node:
- Equal → Found
- Smaller → Go Left
- Greater → Go Right

Example: Search 7

```
        8
      /
     3
      \
       6
        \
         7
```

Path:

```
8 → 3 → 6 → 7
```

Average Time: **O(log n)**

Worst Case: **O(n)**

---

### 2. Insert

- Compare value with current node.
- Go left or right.
- Insert at the first NULL position.

Example: Insert 5

Before:

```
      8
     /
    3
     \
      6
```

After:

```
      8
     /
    3
     \
      6
     /
    5
```

---

### 3. Delete

### Case 1: Leaf Node

Delete directly.

```
    8
   /
  3
```

Delete 3

```
8
```

---

### Case 2: One Child

Connect parent directly to the child.

Before:

```
    8
   /
  3
   \
    5
```

After deleting 3:

```
    8
   /
  5
```

---

### Case 3: Two Children

Replace the node with its **Inorder Successor** (smallest node in right subtree), then delete that successor.

Example:

```
        8
      /   \
     3     10
          /
         9
```

Delete 8

Result:

```
        9
      /   \
     3     10
```

---

## Inorder Traversal

**Important Property**

Inorder traversal of a BST always gives **sorted order**.

Example:

```
        5
      /   \
     3     7
    / \   / \
   2  4  6  8
```

Inorder:

```
2 3 4 5 6 7 8
```

---

## Time Complexity

| Operation | Average | Worst |
|-----------|---------|--------|
| Search | O(log n) | O(n) |
| Insert | O(log n) | O(n) |
| Delete | O(log n) | O(n) |
| Traversal | O(n) | O(n) |

Worst case occurs when the BST becomes **skewed**.

---

## Applications

- Fast Searching
- Dictionaries
- Phone Contacts
- Database Indexing (concept)
- Ordered Data Storage

---

## Interview Questions

1. What is a BST?
2. Difference between Binary Tree and BST?
3. Why is Inorder Traversal sorted in BST?
4. Explain the three deletion cases.
5. What is an Inorder Successor?
6. Why does a BST become O(n)?
7. How can a skewed BST be avoided? (Using AVL/Red-Black Trees)

---

## Quick Revision

- Left < Root < Right
- Inorder = Sorted
- Search → Compare and move left/right
- Insert → Insert at NULL
- Delete:
  - Leaf → Remove
  - One Child → Connect child
  - Two Children → Replace with Inorder Successor
- Average Time = O(log n)
- Worst Time = O(n) (Skewed BST)