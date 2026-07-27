# Binary Tree Traversals

## What is Tree Traversal?

**Tree Traversal** is the process of **visiting every node exactly once** in a tree.

There are **4 main traversals**:

1. Preorder (DFS)
2. Inorder (DFS)
3. Postorder (DFS)
4. Level Order (BFS)

---

## Example Tree

```
        1
      /   \
     2     3
    / \   / \
   4   5 6   7
```

---

# 1. Preorder Traversal

## Order

```
Root → Left → Right
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
        preorder(root, ans);
        return ans;
    }

    private void preorder(TreeNode node, List<Integer> ans) {

        if (node == null)
            return;

        ans.add(node.val);
        preorder(node.left, ans);
        preorder(node.right, ans);
    }
}
```

---

# 2. Inorder Traversal

## Order

```
Left → Root → Right
```

Output:

```
4 2 5 1 6 3 7
```

> **Important:** Inorder traversal of a **BST** always gives **sorted order**.

### Java Code

```java
class Solution {

    public List<Integer> inorderTraversal(TreeNode root) {

        List<Integer> ans = new ArrayList<>();
        inorder(root, ans);
        return ans;
    }

    private void inorder(TreeNode node, List<Integer> ans) {

        if (node == null)
            return;

        inorder(node.left, ans);
        ans.add(node.val);
        inorder(node.right, ans);
    }
}
```

---

# 3. Postorder Traversal

## Order

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
        postorder(root, ans);
        return ans;
    }

    private void postorder(TreeNode node, List<Integer> ans) {

        if (node == null)
            return;

        postorder(node.left, ans);
        postorder(node.right, ans);
        ans.add(node.val);
    }
}
```

---

# 4. Level Order Traversal (BFS)

## Order

Visit nodes **level by level** from left to right.

Output:

```
1 2 3 4 5 6 7
```

### Java Code

```java
class Solution {

    public List<List<Integer>> levelOrder(TreeNode root) {

        List<List<Integer>> ans = new ArrayList<>();

        if (root == null)
            return ans;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {

            int size = queue.size();
            List<Integer> level = new ArrayList<>();

            for (int i = 0; i < size; i++) {

                TreeNode node = queue.poll();
                level.add(node.val);

                if (node.left != null)
                    queue.offer(node.left);

                if (node.right != null)
                    queue.offer(node.right);
            }

            ans.add(level);
        }

        return ans;
    }
}
```

---

## Traversal Comparison

| Traversal | Order | Uses |
|-----------|-------|------|
| Preorder | Root → Left → Right | Copy tree, Serialization |
| Inorder | Left → Root → Right | BST gives sorted order |
| Postorder | Left → Right → Root | Delete tree, Calculate size/height |
| Level Order | Level by Level | BFS, Shortest path, Level-wise problems |

---

## Time Complexity

| Traversal | Time | Space |
|-----------|------|--------|
| Preorder | O(n) | O(h) |
| Inorder | O(n) | O(h) |
| Postorder | O(n) | O(h) |
| Level Order | O(n) | O(n) |

- **n** = Number of nodes
- **h** = Height of the tree

---

## Interview Questions

1. What is tree traversal?
2. Difference between DFS and BFS?
3. Explain Preorder, Inorder, and Postorder.
4. Which traversal gives sorted order in a BST?
5. Why does BFS use a Queue?
6. Why does DFS use Recursion (or a Stack)?
7. What are the time and space complexities of each traversal?

---

## Quick Revision

- **Preorder** = Root → Left → Right
- **Inorder** = Left → Root → Right
- **Postorder** = Left → Right → Root
- **Level Order** = BFS using Queue
- DFS uses **Recursion/Stack**
- BFS uses **Queue**
- All traversals take **O(n)** time
- Inorder of a **BST** returns **sorted order**