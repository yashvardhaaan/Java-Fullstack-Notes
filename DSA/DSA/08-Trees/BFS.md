# Breadth First Search (BFS) / Level Order Traversal

## What is BFS?

**Breadth First Search (BFS)** visits the tree **level by level** from **left to right**.

It uses a **Queue (FIFO)**.

Example:

```
        1
      /   \
     2     3
    / \   / \
   4   5 6   7
```

BFS Output:

```
1 2 3 4 5 6 7
```

---

## Idea

1. Put the **root** into the queue.
2. Remove the front node.
3. Visit the node.
4. Add its left child.
5. Add its right child.
6. Repeat until the queue becomes empty.

---

## Algorithm

```
Queue ← Root

while Queue is not empty
    node = Queue.front()
    Queue.pop()

    Visit(node)

    if node->left exists
        Queue.push(node->left)

    if node->right exists
        Queue.push(node->right)
```

---

# Breadth First Search (BFS) / Level Order Traversal

## What is BFS?

**Breadth First Search (BFS)** visits the tree **level by level** from **left to right**.

It uses a **Queue (FIFO)**.

Example:

```
        1
      /   \
     2     3
    / \   / \
   4   5 6   7
```

BFS Output:

```
1 2 3 4 5 6 7
```

---

## Idea

1. Put the **root** into the queue.
2. Remove the front node.
3. Visit the node.
4. Add its left child.
5. Add its right child.
6. Repeat until the queue becomes empty.

---

## Algorithm

```
Queue ← Root

while Queue is not empty
    node = Queue.front()
    Queue.pop()

    Visit(node)

    if node->left exists
        Queue.push(node->left)

    if node->right exists
        Queue.push(node->right)
```

---

```java
class Solution {

    public List<Integer> bfs(TreeNode root) {

        List<Integer> ans = new ArrayList<>();

        if (root == null)
            return ans;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {

            TreeNode node = queue.poll();
            ans.add(node.val);

            if (node.left != null)
                queue.offer(node.left);

            if (node.right != null)
                queue.offer(node.right);
        }

        return ans;
    }
}
```

---

## Dry Run

Tree:

```
        1
      /   \
     2     3
    / \     \
   4   5     6
```

| Queue | Output |
|--------|--------|
| 1 | - |
| 2 3 | 1 |
| 3 4 5 | 1 2 |
| 4 5 6 | 1 2 3 |
| 5 6 | 1 2 3 4 |
| 6 | 1 2 3 4 5 |
| Empty | 1 2 3 4 5 6 |

---

## Time Complexity

```
O(n)
```

Every node is visited exactly once.

---

## Space Complexity

```
O(n)
```

Queue may store all nodes of one level.

---

## Applications

- Level Order Traversal
- Finding shortest path in an unweighted graph
- Binary Tree Level Order problems
- Finding minimum depth
- Tree serialization

---

## Common Interview Questions

1. Why is Queue used in BFS?
2. Difference between BFS and DFS?
3. Time and Space Complexity?
4. How do you print level by level?
5. Where is BFS used in real life?

---

## Quick Revision

- BFS = Level Order Traversal
- Uses Queue (FIFO)
- Visit level by level
- Push Left → Push Right
- Time = O(n)
- Space = O(n)
- Queue stores nodes to visit next

---

## Dry Run

Tree:

```
        1
      /   \
     2     3
    / \     \
   4   5     6
```

| Queue | Output |
|--------|--------|
| 1 | - |
| 2 3 | 1 |
| 3 4 5 | 1 2 |
| 4 5 6 | 1 2 3 |
| 5 6 | 1 2 3 4 |
| 6 | 1 2 3 4 5 |
| Empty | 1 2 3 4 5 6 |

---

## Time Complexity

```
O(n)
```

Every node is visited exactly once.

---

## Space Complexity

```
O(n)
```

Queue may store all nodes of one level.

---

## Applications

- Level Order Traversal
- Finding shortest path in an unweighted graph
- Binary Tree Level Order problems
- Finding minimum depth
- Tree serialization

---

## Common Interview Questions

1. Why is Queue used in BFS?
2. Difference between BFS and DFS?
3. Time and Space Complexity?
4. How do you print level by level?
5. Where is BFS used in real life?

---

## Quick Revision

- BFS = Level Order Traversal
- Uses Queue (FIFO)
- Visit level by level
- Push Left → Push Right
- Time = O(n)
- Space = O(n)
- Queue stores nodes to visit next