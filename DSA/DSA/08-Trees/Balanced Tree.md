# Balanced Binary Tree

## What is a Balanced Binary Tree?

A **Balanced Binary Tree** is a binary tree in which, for **every node**, the height difference between its left and right subtrees is **at most 1**.

```
| Height(Left) - Height(Right) | ≤ 1
```

Example (Balanced):

```
        1
      /   \
     2     3
    / \     \
   4   5     6
```

---

## Why is it Important?

A balanced tree keeps its height small, making operations like:

- Search
- Insert
- Delete

much faster.

---

## Balanced vs Unbalanced

### Balanced Tree

```
        4
      /   \
     2     6
    / \   / \
   1  3  5  7
```

Height = **O(log n)**

---

### Unbalanced Tree

```
1
 \
  2
   \
    3
     \
      4
```

Height = **O(n)**

---

## Balance Factor

The **Balance Factor (BF)** of a node is:

```
Balance Factor = Height(Left) - Height(Right)
```

A node is balanced if:

```
BF = -1, 0, or 1
```

Examples:

| Left Height | Right Height | BF | Balanced? |
|-------------|-------------:|---:|:---------:|
| 3 | 3 | 0 | ✅ |
| 4 | 3 | 1 | ✅ |
| 3 | 4 | -1 | ✅ |
| 5 | 3 | 2 | ❌ |

---

## How to Check?

For every node:

1. Find the height of the left subtree.
2. Find the height of the right subtree.
3. Calculate the difference.
4. If the difference is greater than 1, the tree is **not balanced**.

---

## Java Code

```java
class Solution {

    public boolean isBalanced(TreeNode root) {
        return height(root) != -1;
    }

    private int height(TreeNode node) {

        if (node == null)
            return 0;

        int left = height(node.left);
        if (left == -1)
            return -1;

        int right = height(node.right);
        if (right == -1)
            return -1;

        if (Math.abs(left - right) > 1)
            return -1;

        return Math.max(left, right) + 1;
    }
}
```

---

## Time Complexity

```
O(n)
```

Each node is visited only once.

---

## Space Complexity

```
O(h)
```

- **h** = Height of the tree
- Balanced Tree → **O(log n)**
- Skewed Tree → **O(n)**

---

## Real-World Examples

- AVL Tree
- Red-Black Tree
- Database Indexes
- File Systems

---

## Interview Questions

1. What is a Balanced Binary Tree?
2. What is the Balance Factor?
3. Why are balanced trees faster?
4. What is the time complexity to check if a tree is balanced?
5. Name two self-balancing BSTs.

---

## Quick Revision

- Height difference ≤ 1
- Balance Factor = Height(Left) − Height(Right)
- Balanced if BF = -1, 0, or 1
- Search, Insert, Delete ≈ **O(log n)** (when balanced)
- Time to check balance = **O(n)**
- Space = **O(h)**