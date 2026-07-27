# Lowest Common Ancestor (LCA)

## What is Lowest Common Ancestor?

The **Lowest Common Ancestor (LCA)** of two nodes is the **lowest (deepest) node** in the tree that has **both nodes as descendants**.

> A node can be a descendant of itself.

Example:

```
          3
        /   \
       5     1
      / \   / \
     6   2 0   8
        / \
       7   4
```

Examples:

- LCA(5, 1) = **3**
- LCA(6, 4) = **5**
- LCA(7, 4) = **2**

---

## Key Idea

At every node:

- If the current node is `null`, return `null`.
- If the current node is `p` or `q`, return the current node.
- Search in the left subtree.
- Search in the right subtree.
- If both left and right return non-null, the current node is the LCA.
- Otherwise, return the non-null result.

---

## Algorithm

1. If node is `null`, return `null`.
2. If node is `p` or `q`, return node.
3. Recursively search left subtree.
4. Recursively search right subtree.
5. If both return non-null → Current node is LCA.
6. Else return whichever side is non-null.

---

## Java Code

```java
class Solution {

    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {

        if (root == null || root == p || root == q)
            return root;

        TreeNode left = lowestCommonAncestor(root.left, p, q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);

        if (left != null && right != null)
            return root;

        return (left != null) ? left : right;
    }
}
```

---

## Dry Run

Tree:

```
          3
        /   \
       5     1
      / \
     6   2
        / \
       7   4
```

Find:

```
LCA(6, 4)
```

Steps:

- Search left subtree of 3 → Found 6 and 4
- Search right subtree of 3 → Not found
- At node 5:
  - Left returns 6
  - Right returns 4
- Both are non-null → **LCA = 5**

---

## Time Complexity

```
O(n)
```

Every node is visited at most once.

---

## Space Complexity

```
O(h)
```

- **h** = Height of the tree
- Balanced Tree → **O(log n)**
- Skewed Tree → **O(n)**

---

## Important Points

- LCA is the **deepest common ancestor**.
- A node can be the ancestor of itself.
- The LCA **does not have to be the root**.
- This solution works for a **general Binary Tree** (not specifically a BST).

---

## Interview Questions

1. What is the Lowest Common Ancestor?
2. Can a node be its own ancestor?
3. Why do we return the current node when it equals `p` or `q`?
4. Why is the current node the LCA when both left and right are non-null?
5. What are the time and space complexities?
6. How does the LCA solution for a BST differ from a Binary Tree?

---

## Quick Revision

- LCA = Deepest common ancestor of two nodes
- Base Case:
  - `root == null`
  - `root == p`
  - `root == q`
- Search both left and right subtrees
- Both non-null → Current node is LCA
- One non-null → Return that node
- Time = **O(n)**
- Space = **O(h)**