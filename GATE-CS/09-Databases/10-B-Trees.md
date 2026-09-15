# 10 — B-Trees

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**

B-Trees are balanced multiway search trees used for **efficient disk-based searching, insertion, and deletion**.

> **First principle:** A B-Tree keeps many keys in each node, making the tree **short**, so the number of disk accesses is small.

---

# 1. Why B-Trees?

A binary search tree can become tall:

```text
1
 \
  2
   \
    3
     \
      4
```

Large height → many disk accesses.

B-Tree:

```text
          [20 | 40 | 60]
        /     |     |     \
      ...    ...   ...    ...
```

One node contains **multiple keys and children**.

Therefore:

```text
More keys/node
      ↓
Smaller height
      ↓
Fewer disk I/Os
```

---

# 2. Properties of B-Tree ⭐⭐⭐⭐⭐

A B-Tree is:

* Balanced
* Multiway
* Search tree
* Dynamically maintained
* All leaves at the same level

🔥 **Most important**

> **All leaves are at the same depth.**

---

# 3. Order of a B-Tree

This is a major GATE trap.

If a B-Tree has **order m**:

### Maximum children

```text id="7brq31"
m
```

### Maximum keys

```text id="r0y6vz"
m - 1
```

### Minimum children for a non-root internal node

```text id="h8m4tp"
ceil(m/2)
```

### Minimum keys for a non-root node

```text id="e6n2ck"
ceil(m/2) - 1
```

---

# 4. Example: Order 5

For:

```text id="7k2f1v"
m = 5
```

Maximum:

```text id="x6r8qb"
Children = 5
Keys = 4
```

Minimum non-root:

```text id="0y9q2a"
Children = ceil(5/2) = 3
Keys = 2
```

So every non-root internal node has:

```text id="g8s0ki"
2 to 4 keys
3 to 5 children
```

---

# 5. Root Exception ⭐⭐⭐⭐⭐

The root is special.

If the root is not a leaf:

```text id="q4v8fz"
minimum children = 2
```

It can have fewer keys than the normal minimum.

If the root is itself a leaf:

```text id="0b4k1n"
it may contain as few as 1 key
```

🔥 **GATE Trap**

Never blindly apply:

```text id="7w5p2x"
ceil(m/2)-1
```

to the root.

---

# 6. Node Structure

For `k` keys:

```text id="j3f7r2"
P0 K1 P1 K2 P2 ... Kk Pk
```

A node containing `k` keys has:

```text id="0m5z8s"
k + 1 children
```

for an internal node.

Example:

```text id="0r9q4m"
[20 | 40 | 60]
 /    |    |   \
P0   P1   P2   P3
```

---

# 7. Search in B-Tree

Suppose:

```text id="2m8w4n"
          [30 | 60]
         /    |    \
       ...   ...   ...
```

To search `45`:

```text id="5y8v2r"
45 > 30
45 < 60
```

Go to middle child.

At each level:

```text id="b1q7ma"
compare
  ↓
choose child
  ↓
next level
```

Since the tree is balanced:

```text id="f6t3s8"
Search complexity = O(log_m N)
```

More commonly expressed asymptotically as:

```text id="9x8c1m"
O(log N)
```

but the **base reflects the high branching factor**.

---

# 8. Height of B-Tree ⭐⭐⭐⭐⭐

Because each node can have many children, height is small.

Approximate:

```text id="2e0x2y"
h ≈ log_m N
```

For exact GATE problems, use the **minimum/maximum occupancy formulas**, rather than blindly applying this approximation.

---

# 9. Maximum Number of Keys

For order `m` and height `h`, assuming root is at level 0:

Maximum children:

```text id="9kwm4j"
m
```

Maximum keys per node:

```text id="h4q5sz"
m - 1
```

Number of nodes at levels:

```text id="w7m0vq"
1 + m + m² + ... + m^h
```

Maximum number of keys:

```text id="2i8v1f"
(m - 1)(1 + m + m² + ... + m^h)
```

Using geometric series:

```text id="6w1n3b"
Maximum keys
= m^(h+1) - 1
```

🔥 Very useful GATE formula.

---

# 10. Minimum Number of Keys for a Given Height ⭐⭐⭐⭐⭐

For height `h` and order `m`:

Root has minimum:

```text id="c4n8y2"
1 key
2 children
```

Every other internal node has:

```text id="z5p1km"
ceil(m/2) children
```

Let:

```text id="m7h3x0"
t = ceil(m/2)
```

Then minimum number of keys for height `h`:

```text id="w9q2s5"
1 + 2(t - 1)
  + 2t(t - 1)
  + ...
```

A compact expression is:

```text id="r2v6k8"
Minimum keys
=
2t^h - 1
```

where:

```text id="9p4a7c"
t = ceil(m/2)
```

assuming the standard B-tree definition and `h ≥ 1`.

---

# 11. B-Tree Insertion ⭐⭐⭐⭐⭐

Insertion always occurs at a **leaf**.

Basic process:

```text id="5u3w1e"
Find leaf
   ↓
Insert key in sorted order
   ↓
Overflow?
   ↓
Split node
   ↓
Promote middle key
```

---

# 12. Node Overflow

For order `m`:

Maximum keys:

```text id="5z6y3n"
m - 1
```

If insertion causes:

```text id="k7q8x4"
m keys
```

→ overflow.

Then split.

---

# 13. Splitting

Suppose a node has:

```text id="1a5m8q"
[10 | 20 | 30 | 40 | 50]
```

The middle key is promoted:

```text id="5v7q0s"
          [30]
         /    \
 [10|20]      [40|50]
```

The exact promoted key depends on the implementation/convention, so follow the convention specified in the question.

🔥 **GATE Trap**

> Splitting a node increases the number of nodes and may propagate upward.

---

# 14. Root Split

If the root overflows:

```text id="9q4m6j"
Old root
   ↓
Split
   ↓
New root created
```

Therefore:

> **Tree height increases by 1 only when the root splits.**

🔥 Extremely important.

---

# 15. B-Tree Deletion

Deletion is more complicated.

Basic idea:

```text id="0g4h2n"
Delete key
   ↓
Underflow?
   ↓
Borrow from sibling
OR
Merge with sibling
```

---

# 16. Deletion from Leaf

If removing a key still leaves enough keys:

```text id="h3j6v9"
Simply delete.
```

If underflow occurs:

```text id="k2p7d4"
Borrow
OR
Merge
```

---

# 17. Borrowing

Suppose one node has too few keys and its sibling has extra keys.

Redistribute through the parent:

```text id="c7x1p0"
        Parent
       /      \
   deficient  sibling
```

A key moves through the parent to restore minimum occupancy.

---

# 18. Merging

If borrowing isn't possible:

```text id="1f8v3q"
Node + separator key + sibling
             ↓
          merged node
```

The parent loses a key.

This can cause underflow in the parent.

Therefore merging may propagate upward.

---

# 19. Root Shrink

If after merging the root loses all its keys:

```text id="7v1x5c"
       Root
        ↓
     merged child
```

The child becomes the new root.

Therefore:

> **B-Tree height can decrease by 1 when the root shrinks.**

---

# 20. B-Tree Search Complexity

For `N` keys:

```text id="6j0v4k"
Search = O(log N)
```

Insertion:

```text id="1q9x7m"
O(log N)
```

Deletion:

```text id="p5s8d2"
O(log N)
```

The practical advantage is the small number of **disk/page accesses**.

---

# 21. B-Tree vs Binary Search Tree

| B-Tree                        | BST                     |
| ----------------------------- | ----------------------- |
| Multiple keys/node            | One key/node            |
| Multiple children             | ≤ 2 children            |
| Balanced                      | May become skewed       |
| Designed for external storage | Usually memory-oriented |
| Low height                    | Potentially high height |

---

# 22. B-Tree vs B+ Tree

You need this distinction before the next topic.

| B-Tree                                            | B+ Tree                                |
| ------------------------------------------------- | -------------------------------------- |
| Records/data pointers may exist in internal nodes | Data pointers typically only at leaves |
| Search may terminate at internal node             | Search reaches leaf                    |
| Leaves may not need linked-list structure         | Leaves are usually linked              |
| Range queries less convenient                     | Excellent range queries                |

🔥 **GATE Shortcut**

```text
B-Tree
→ data can be in internal nodes

B+ Tree
→ data pointers at leaves
→ leaves linked
```

---

# 23. Why B-Trees Are Good for Databases

Disk access is expensive.

Suppose:

```text id="z0w7a2"
One node = one disk page
```

A B-Tree can store hundreds of keys in one page.

Therefore:

```text id="4m3v8q"
Huge number of records
        ↓
small tree height
        ↓
few page accesses
```

This is the fundamental reason for using B-Trees/B+ Trees.

---

# 🧠 GATE PYQ Patterns

### Pattern 1 — Order and node capacity

Given:

```text id="5d8q1x"
B-Tree order = m
```

ask:

* maximum keys
* minimum keys
* maximum children
* minimum children

Immediately write:

```text id="2h4s7v"
Max children = m
Max keys     = m−1

Min children = ceil(m/2)
Min keys     = ceil(m/2)−1
```

for non-root nodes.

---

### Pattern 2 — Maximum keys for height

Given order `m` and height `h`:

```text id="z8y1q5"
Maximum keys = m^(h+1) − 1
```

Example:

```text id="p4k7n2"
m = 3
h = 2
```

```text id="a8w5s0"
Maximum keys
= 3³ − 1
= 26
```

---

### Pattern 3 — Minimum keys for height

Use:

```text id="5r2c9m"
t = ceil(m/2)

Minimum keys = 2t^h − 1
```

Example:

```text id="4y8m1q"
m = 4
h = 2
```

```text id="0f6p3w"
t = ceil(4/2) = 2

Minimum keys
= 2(2²) − 1
= 7
```

---

### Pattern 4 — Insertion sequence

GATE may provide:

```text id="v9s1k5"
10, 20, 30, 40, 50...
```

and ask for the resulting tree.

Do:

```text id="2z6q8a"
Insert
 ↓
Check overflow
 ↓
Split
 ↓
Promote middle
 ↓
Repeat
```

---

### Pattern 5 — Height change

Question:

> When does B-Tree height increase?

Answer:

> **When the root splits.**

When does height decrease?

> **When the root becomes empty after a merge and its child becomes the new root.**

---

# 🔥 GATE Traps

1. **Order m ≠ maximum number of keys.**
2. Order `m` → maximum **m children**, **m−1 keys**.
3. Minimum occupancy formulas normally exclude the root.
4. Root has special rules.
5. All leaves are at the same level.
6. Insertion is ultimately performed at a leaf.
7. Overflow → split.
8. Split → middle separator is promoted.
9. Root split → height increases.
10. Merge can propagate upward.
11. Root shrink → height decreases.
12. B-Tree is not the same as BST.
13. B+ Tree is not the same as B-Tree.
14. B-Trees reduce disk I/O mainly through **high fan-out and low height**.
15. For numerical questions, carefully determine whether **height starts at 0 or 1**.

---

# ⚡ 30-Second Revision

```text id="b8c2q4"
B-TREE
→ balanced multiway search tree
→ all leaves same level

ORDER = m

MAX CHILDREN
= m

MAX KEYS
= m−1

MIN CHILDREN
= ceil(m/2)       [non-root]

MIN KEYS
= ceil(m/2)−1     [non-root]

MAX KEYS FOR HEIGHT h
= m^(h+1) − 1

Let t = ceil(m/2)

MIN KEYS FOR HEIGHT h
= 2t^h − 1

INSERT
→ leaf
→ overflow
→ split
→ promote middle

DELETE
→ remove
→ underflow
→ borrow OR merge

ROOT SPLIT
→ height +1

ROOT SHRINK
→ height −1

B-TREE
→ data may exist in internal nodes

B+ TREE
→ data pointers at leaves
→ linked leaves
```

## 🎯 GATE Priority

| Topic                           | Priority |
| ------------------------------- | -------: |
| Order / min-max keys & children |    ⭐⭐⭐⭐⭐ |
| Height calculations             |    ⭐⭐⭐⭐⭐ |
| Insertion & splitting           |    ⭐⭐⭐⭐⭐ |
| Deletion / merging              |     ⭐⭐⭐⭐ |
| Disk I/O reasoning              |     ⭐⭐⭐⭐ |
| B-Tree vs B+ Tree               |    ⭐⭐⭐⭐⭐ |

**Next: `11-B+ Trees.md`** — particularly important for **fan-out, height, range queries, leaf linkage, and numerical problems.**
