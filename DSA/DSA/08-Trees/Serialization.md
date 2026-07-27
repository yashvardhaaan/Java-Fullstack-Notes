# Serialize and Deserialize Binary Tree

## What is Serialization?

**Serialization** is the process of converting a **Binary Tree** into a string so it can be:

- Stored in a file
- Sent over a network
- Saved in a database

---

## What is Deserialization?

**Deserialization** is the process of converting the serialized string back into the original Binary Tree.

---

## Why is it Needed?

Serialization is commonly used in:

- Saving tree data
- Network communication
- Databases
- Caching systems
- File storage

---

## Example

Original Tree:

```
        1
      /   \
     2     3
          / \
         4   5
```

Serialized String (Level Order):

```
1,2,3,null,null,4,5,null,null,null,null
```

`null` represents a missing child.

---

## Key Idea

### Serialization

- Traverse the tree using **BFS (Queue)**.
- Store every node value.
- Store `"null"` for missing children.

### Deserialization

- Read values one by one.
- Create nodes.
- Connect left and right children using a queue.

---

## Serialization (Java)

```java
class Codec {

    public String serialize(TreeNode root) {

        if (root == null)
            return "";

        StringBuilder sb = new StringBuilder();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {

            TreeNode node = queue.poll();

            if (node == null) {
                sb.append("null,");
                continue;
            }

            sb.append(node.val).append(",");

            queue.offer(node.left);
            queue.offer(node.right);
        }

        return sb.toString();
    }
}
```

---

## Deserialization (Java)

```java
class Codec {

    public TreeNode deserialize(String data) {

        if (data.isEmpty())
            return null;

        String[] values = data.split(",");

        TreeNode root = new TreeNode(Integer.parseInt(values[0]));
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        int i = 1;

        while (!queue.isEmpty()) {

            TreeNode current = queue.poll();

            if (!values[i].equals("null")) {
                current.left = new TreeNode(Integer.parseInt(values[i]));
                queue.offer(current.left);
            }
            i++;

            if (!values[i].equals("null")) {
                current.right = new TreeNode(Integer.parseInt(values[i]));
                queue.offer(current.right);
            }
            i++;
        }

        return root;
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
```

Serialization:

```
Queue → [1]

Output:
1,

Queue → [2,3]

Output:
1,2,3,

Queue → [null,null,null,null]

Output:
1,2,3,null,null,null,null,
```

---

## Time Complexity

### Serialization

```
O(n)
```

### Deserialization

```
O(n)
```

---

## Space Complexity

```
O(n)
```

Queue and serialized data both require extra space.

---

## Important Points

- Serialization converts a tree into a string.
- Deserialization reconstructs the original tree.
- `"null"` is required to preserve the tree structure.
- BFS (Queue) is the most common approach.
- DFS (Preorder) can also be used for serialization.

---

## Interview Questions

1. What is serialization?
2. Why do we store `"null"` values?
3. Can serialization be done using DFS?
4. What is the time complexity?
5. Why is deserialization possible only if the structure is preserved?

---

## Quick Revision

- Serialize = Tree → String
- Deserialize = String → Tree
- Use Queue (BFS)
- Store `"null"` for missing children
- Time = **O(n)**
- Space = **O(n)**