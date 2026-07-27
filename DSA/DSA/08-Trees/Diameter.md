# Diameter of a Binary Tree

## What is Diameter?

The **Diameter of a Binary Tree** is the **longest path between any two nodes** in the tree.

> **Note:** The path **may or may not pass through the root**.

The diameter is measured in **number of edges**.

Example:

```
        1
       / \
      2   3
     / \
    4   5
```

Longest Path:

```
4 → 2 → 1 → 3
```

Diameter = **3 edges**

---

## Key Idea

For every node:

```
Diameter through that node =
Height(Left) + Height(Right)
```

Keep track of the maximum diameter while calculating heights.

---

## Algorithm

1. Find the height of the left subtree.
2. Find the height of the right subtree.
3. Calculate:

```
leftHeight + rightHeight
```

4. Update the maximum diameter.
5. Return the height of the current node.

---

## Java Code

```java
class Solution {

    private int diameter = 0;

    public int diameterOfBinaryTree(TreeNode root) {
        height(root);
        return diameter;
    }

    private int height(TreeNode node) {

        if (node == null)
            return 0;

        int left = height(node.left);
        int right = height(node.right);

        diameter = Math.max(diameter, left + right);

        return Math.max(left, right) + 1;
    }
}
```

---

## Dry Run

Tree:

```
        1
       / \
      2   3
     / \
    4   5
```

| Node | Left Height | Right Height | Diameter |
|------|------------:|-------------:|---------:|
| 4 | 0 | 0 | 0 |
| 5 | 0 | 0 | 0 |
| 2 | 1 | 1 | 2 |
| 3 | 0 | 0 | 0 |
| 1 | 2 | 1 | **3** |

Final Answer:

```
Diameter = 3
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

## Important Points

- Diameter is measured in **edges**, not nodes.
- Longest path can start and end at **any two nodes**.
- The path **does not have to pass through the root**.
- Height is calculated recursively.

---

## Interview Questions

1. What is the diameter of a binary tree?
2. Is diameter measured in nodes or edges?
3. Does the diameter always pass through the root?
4. Why do we calculate height while finding the diameter?
5. What are the time and space complexities?

---

## Quick Revision

- Diameter = Longest path between any two nodes
- Measured in **edges**
- Formula:
  - `Diameter = Left Height + Right Height`
- Use DFS to calculate heights
- Update maximum diameter at every node
- Time = **O(n)**
- Space = **O(h)**