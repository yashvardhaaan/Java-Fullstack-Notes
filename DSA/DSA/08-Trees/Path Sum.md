# Path Sum

## What is Path Sum?

Given the **root** of a binary tree and an integer **targetSum**, determine whether there exists a **root-to-leaf path** such that the sum of all node values equals **targetSum**.

A **leaf node** is a node with **no left and right child**.

Example:

```
          5
        /   \
       4     8
      /     / \
     11    13  4
    /  \         \
   7    2         1
```

Target Sum = **22**

Path:

```
5 → 4 → 11 → 2
```

Sum:

```
5 + 4 + 11 + 2 = 22
```

Answer:

```
true
```

---

## Key Idea

- Start from the root.
- Subtract the current node's value from `targetSum`.
- Move to the left and right child.
- If you reach a **leaf node** and the remaining sum equals the leaf's value, return `true`.

---

## Algorithm

1. If the node is `null`, return `false`.
2. If the node is a leaf:
   - Check if `targetSum == node.val`.
3. Recursively check:
   - Left subtree
   - Right subtree
4. Return `true` if either subtree returns `true`.

---

## Java Code

```java
class Solution {

    public boolean hasPathSum(TreeNode root, int targetSum) {

        if (root == null)
            return false;

        if (root.left == null && root.right == null)
            return targetSum == root.val;

        return hasPathSum(root.left, targetSum - root.val)
                || hasPathSum(root.right, targetSum - root.val);
    }
}
```

---

## Dry Run

Tree:

```
          5
        /   \
       4     8
      /     / \
     11    13  4
    /  \
   7    2
```

Target:

```
22
```

Steps:

```
22 - 5 = 17
17 - 4 = 13
13 - 11 = 2
2 - 2 = 0
```

Reached a leaf node with remaining sum = **0**

Answer:

```
true
```

---

## Time Complexity

```
O(n)
```

Each node is visited at most once.

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

- Path must start from the **root**.
- Path must end at a **leaf node**.
- Every node in the path contributes to the sum.
- DFS (Recursion) is commonly used.

---

## Interview Questions

1. What is a root-to-leaf path?
2. Why do we subtract the current node's value?
3. Why must the path end at a leaf node?
4. What happens if the root is `null`?
5. What are the time and space complexities?

---

## Quick Revision

- Root → Leaf path
- Target = Sum of node values
- Subtract current node value at each step
- At leaf: Check `targetSum == node.val`
- DFS + Recursion
- Time = **O(n)**
- Space = **O(h)**