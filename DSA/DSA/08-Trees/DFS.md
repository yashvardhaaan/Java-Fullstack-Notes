# Depth First Search (DFS)

## What is DFS?

**Depth First Search (DFS)** visits nodes by going **as deep as possible** into one branch before backtracking.

It uses **Recursion** (or a Stack).

Example:

```
        1
      /   \
     2     3
    / \   / \
   4   5 6   7
```

DFS has **3 types**:

1. Preorder (Root → Left → Right)
2. Inorder (Left → Root → Right)
3. Postorder (Left → Right → Root)

---

## 1. Preorder Traversal

### Order

```
Root → Left → Right
```

Example:

```
        1
      /   \
     2     3
    / \   / \
   4   5 6   7
```

Output:

```
1 2 4 5 3 6 7
```

### Java Code

```java
class Solution {

    public List<Integer> preorderTraversal(TreeNode root) {

        List<Integer> ans = new ArrayList<>();
        dfs(root, ans);
        return ans;
    }

    private void dfs(TreeNode node, List<Integer> ans) {

        if (node == null)
            return;

        ans.add(node.val);
        dfs(node.left, ans);
        dfs(node.right, ans);
    }
}
```

---

## 2. Inorder Traversal

### Order

```
Left → Root → Right
```

Output:

```
4 2 5 1 6 3 7
```

### Java Code

```java
class Solution {

    public List<Integer> inorderTraversal(TreeNode root) {

        List<Integer> ans = new ArrayList<>();
        dfs(root, ans);
        return ans;
    }

    private void dfs(TreeNode node, List<Integer> ans) {

        if (node == null)
            return;

        dfs(node.left, ans);
        ans.add(node.val);
        dfs(node.right, ans);
    }
}
```

---

## 3. Postorder Traversal

### Order

```
Left → Right → Root
```

Output:

```
4 5 2 6 7 3 1
```

### Java Code

```java
class Solution {

    public List<Integer> postorderTraversal(TreeNode root) {

        List<Integer> ans = new ArrayList<>();
        dfs(root, ans);
        return ans;
    }

    private void dfs(TreeNode node, List<Integer> ans) {

        if (node == null)
            return;

        dfs(node.left, ans);
        dfs(node.right, ans);
        ans.add(node.val);
    }
}
```

---

## Dry Run (Preorder)

Tree:

```
        1
      /   \
     2     3
    / \
   4   5
```

Traversal:

```
Visit 1
↓
Visit 2
↓
Visit 4
↑
Visit 5
↑
Visit 3
```

Output:

```
1 2 4 5 3
```

---

## Time Complexity

```
O(n)
```

Every node is visited exactly once.

---

## Space Complexity

```
O(h)
```

- **h** = Height of the tree
- Worst Case (Skewed Tree): **O(n)**
- Best Case (Balanced Tree): **O(log n)**

---

## Applications

- Tree Traversals
- Binary Search Tree operations
- Expression Trees
- Directory/File Systems
- Topological concepts (Graphs)

---

## Common Interview Questions

1. What is DFS?
2. Difference between BFS and DFS?
3. Difference between Preorder, Inorder, and Postorder?
4. Why does Inorder of a BST return sorted order?
5. What is the space complexity of recursive DFS?

---

## Required Imports

```java
import java.util.ArrayList;
import java.util.List;
```

---

## Quick Revision

- DFS = Go as deep as possible
- Uses Recursion (or Stack)
- Preorder = Root → Left → Right
- Inorder = Left → Root → Right
- Postorder = Left → Right → Root
- Time = O(n)
- Space = O(h)
```