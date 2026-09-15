# 11 — B+ Trees

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**

B+ Trees are extremely important for GATE because questions commonly involve **order/fan-out, height, minimum/maximum keys, insertion, deletion, and range queries**.

> **First principle:** A B+ Tree keeps the **search structure in internal nodes** and stores the **actual record pointers at the leaf level**, with leaves linked for efficient sequential/range access.

---

# 1. B+ Tree Structure

Conceptually:

```text
                 [30 | 60]
                /    |    \
               /     |     \
        [10|20]   [30|40|50]   [60|70|80]
           ↓           ↓            ↓
        Records     Records      Records

Leaf nodes:
[10|20] → [30|40|50] → [60|70|80]
```

Important:

```text
Internal nodes → search keys + child pointers
Leaf nodes     → search keys + record/data pointers
Leaves         → linked
```

---

# 2. B-Tree vs B+ Tree ⭐⭐⭐⭐⭐

| B-Tree                                    | B+ Tree                                             |
| ----------------------------------------- | --------------------------------------------------- |
| Data pointers may occur in internal nodes | Data pointers stored at leaves                      |
| Search may finish at internal node        | Search normally reaches leaf                        |
| Leaves need not be linked                 | Leaves are linked                                   |
| Range search less convenient              | Excellent range search                              |
| Lower duplication of separator keys       | Separator keys can appear in internal + leaf levels |

🔥 **GATE Shortcut**

```text
B-Tree  → data can be internal
B+ Tree → data at leaves
```

---

# 3. Why Are Leaves Linked?

Suppose we need:

```sql
WHERE salary BETWEEN 50000 AND 70000
```

After finding `50000`:

```text
Leaf 1 → Leaf 2 → Leaf 3 → ...
```

The DBMS can simply scan the linked leaves.

Therefore:

> **B+ Tree is excellent for range queries.**

---

# 4. Fan-out / Order ⭐⭐⭐⭐⭐

Suppose a B+ Tree internal node can have at most:

```text
m children
```

Then it can have at most:

```text
m − 1 keys
```

So:

```text
Maximum fan-out = m
Maximum separator keys = m−1
```

🔥 Don't confuse:

```text
fan-out = children
keys = children − 1
```

---

# 5. Internal Node Structure

For `k` separator keys:

```text
P0 K1 P1 K2 P2 ... Kk Pk
```

Therefore:

```text
k keys → k+1 children
```

Example:

```text
[30 | 60]
 /    |    \
P0    P1    P2
```

2 keys → 3 children.

---

# 6. Leaf Node

Leaf nodes contain:

```text
search key + record pointer
```

and typically:

```text
next leaf pointer
```

Conceptually:

```text
[10 → R1 | 20 → R2] → [30 → R3 | 40 → R4]
```

---

# 7. Minimum Occupancy ⭐⭐⭐⭐⭐

For an order `m` B+ Tree, the exact minimum occupancy convention can vary by textbook/problem.

Under the common convention:

### Internal non-root node

```text
minimum children = ceil(m/2)
```

### Leaf

If a leaf can contain at most `m−1` entries:

```text
minimum entries = ceil((m−1)/2)
```

⚠️ **Very important GATE warning**

Different books define **order** differently for B+ Trees.

Some define order based on:

* maximum children of internal nodes
* maximum keys
* maximum pointers/entries

So **always inspect the definition given in the question**.

---

# 8. Root Exception

The root is special.

If root is an internal node:

```text
minimum children = 2
```

It can have fewer children than ordinary internal nodes.

If the root is also a leaf, it may contain fewer entries.

🔥 **GATE Trap**

Never apply the normal minimum-occupancy formula blindly to the root.

---

# 9. Height of B+ Tree ⭐⭐⭐⭐⭐

The major advantage is **high fan-out**.

If each internal node has approximately `m` children:

```text
height ≈ log_m(N)
```

where N represents the number of leaf-level entries/records under the assumptions of the question.

But for exact questions:

> Use the stated fan-out and occupancy constraints rather than blindly using the approximation.

---

# 10. Maximum Number of Leaf Entries

Suppose:

```text
m = maximum leaf entries
```

and:

```text
h = number of edges from root to leaf
```

If every internal node has maximum fan-out `f`, then:

```text
Number of leaves = f^h
```

Therefore:

```text
Maximum entries
=
f^h × (maximum entries per leaf)
```

🔥 Always distinguish:

```text
internal-node fan-out
```

from:

```text
leaf capacity
```

They need not be identical.

---

# 11. Minimum Number of Entries

Suppose:

```text
fmin = minimum children per internal node
emin = minimum entries per leaf
```

and height is `h`:

```text
Minimum leaves
=
2 × fmin^(h−1)
```

for `h ≥ 1`, because the root has minimum 2 children.

Then:

```text
Minimum data entries
=
2 × fmin^(h−1) × emin
```

assuming all leaves are at that depth and the standard occupancy model.

---

# 12. B+ Tree Search ⭐⭐⭐⭐⭐

To search for key `45`:

```text
             [30 | 60]
                 ↓
              middle
                 ↓
            [30|40|45|50]
                 ↓
              record
```

Search always proceeds down to a **leaf**.

Complexity:

```text
O(log N)
```

More importantly for DBMS:

```text
Few disk/page accesses
```

---

# 13. Insertion ⭐⭐⭐⭐⭐

Process:

```text
Find correct leaf
       ↓
Insert key
       ↓
Overflow?
       ↓
Split leaf
       ↓
Copy/promote separator
       ↓
May propagate upward
```

---

# 14. Leaf Split

Suppose a leaf becomes:

```text
[10 | 20 | 30 | 40 | 50]
```

Split:

```text
[10 | 20]     [30 | 40 | 50]
```

The separator is inserted into the parent.

Unlike ordinary B-Tree splitting, the data entry remains in the **leaf**.

🔥 **Important distinction**

In a B+ Tree, the separator in an internal node is used for navigation; the actual record remains at the leaf.

---

# 15. Internal Node Split

If the parent overflows:

```text
Parent overflow
      ↓
Split internal node
      ↓
Promote separator
      ↓
Possibly continue upward
```

Eventually:

```text
Root overflow
      ↓
New root
      ↓
Height increases
```

---

# 16. Deletion ⭐⭐⭐⭐

Basic process:

```text
Find leaf
   ↓
Delete entry
   ↓
Underflow?
   ↓
Borrow from sibling
OR
Merge
```

---

# 17. Borrowing

If sibling has enough entries:

```text
Deficient leaf ←→ sibling
```

Redistribute entries.

Parent separator may need updating.

---

# 18. Merging

If redistribution isn't possible:

```text
Leaf 1 + Leaf 2
       ↓
Merged leaf
```

Remove the corresponding separator from the parent.

This may cause parent underflow.

---

# 19. Root Shrink

If merging propagates to the root and the root has only one child:

```text
        Root
          |
        Child
```

The child can become the new root.

Therefore:

```text
height decreases by 1
```

---

# 20. Range Query ⭐⭐⭐⭐⭐

Suppose:

```sql
SELECT *
FROM Employee
WHERE salary >= 50000
AND salary <= 70000;
```

B+ Tree:

```text
Find 50000
    ↓
Leaf containing 50000
    ↓
Follow leaf links
    ↓
Stop after 70000
```

This is why B+ Trees are preferred for range queries.

---

# 21. Equality Query

For:

```sql
WHERE id = 500
```

B+ Tree also works efficiently:

```text
Root
 ↓
Internal
 ↓
Leaf
 ↓
Record
```

So:

```text
B+ Tree → equality + range
Hash     → mainly equality
```

---

# 22. B+ Tree Numerical Example

Suppose:

```text
Internal fan-out = 4
Leaf capacity = 3
```

Height:

```text
h = 2
```

where root is level 0 and leaves are level 2.

Maximum number of leaves:

```text
4² = 16
```

Maximum records:

```text
16 × 3 = 48
```

Therefore:

```text
Maximum = 48 records
```

---

# 23. Another Important Numerical

Suppose:

```text
Maximum fan-out = 5
Leaf capacity = 4
Height = 3
```

Root at level 0.

Leaves:

```text
5³ = 125
```

Maximum records:

```text
125 × 4
= 500
```

🔥 **GATE method**

Always draw:

```text
Level 0 → root
Level 1
Level 2
Level 3 → leaves
```

Then count branches.

---

# 24. Disk Access Calculation ⭐⭐⭐⭐⭐

If:

```text
Root
 ↓
Level 1
 ↓
Level 2
 ↓
Leaf
 ↓
Data
```

then the number of page accesses depends on what the question counts.

For a typical index lookup:

```text
Root page
+
internal pages
+
leaf page
+
possibly data page
```

So if there are 3 index levels:

```text
3 index-page accesses
```

and potentially:

```text
+ 1 data-page access
```

🔥 **GATE Trap**

Read the question carefully:

> Does it ask for **index accesses**, **data accesses**, or **total disk accesses**?

---

# 25. Why B+ Trees Have High Fan-out

Suppose one node can contain:

```text
100 pointers
```

Then:

```text
Level 1 → 100 children
Level 2 → 10,000 children
Level 3 → 1,000,000 children
```

Therefore even huge databases can have very small height.

> **High fan-out → low height → fewer disk I/Os.**

---

# 26. B+ Tree vs Hashing

| B+ Tree                            | Hash             |
| ---------------------------------- | ---------------- |
| Equality search                    | Excellent        |
| Range search                       | Excellent        |
| Ordered traversal                  | Excellent        |
| Exact lookup                       | Good             |
| Supports sequential leaf traversal | Yes              |
| Range queries                      | ❌ generally poor |

🔥 **Exam rule**

```text
Equality only → Hash can be excellent
Range/order   → B+ Tree
```

---

# 🧠 GATE PYQ Patterns

### Pattern 1 — Fan-out

Given:

```text
Order / maximum children
```

ask:

> Maximum number of children?

Directly use the definition supplied.

---

### Pattern 2 — Maximum records for given height

Given:

```text
fan-out
leaf capacity
height
```

Use:

```text
Number of leaves = fan-out^h
```

then:

```text
records = leaves × leaf capacity
```

provided the height convention matches the question.

---

### Pattern 3 — Minimum records

Given:

```text
minimum internal fan-out
minimum leaf occupancy
height
```

calculate the minimum number of leaves and multiply by minimum leaf entries.

---

### Pattern 4 — Insertion sequence

Given:

```text
10,20,30,40,...
```

construct the B+ Tree.

Remember:

```text
Leaf overflow
   ↓
split leaf
   ↓
separator goes to parent
```

---

### Pattern 5 — Range query

Question asks which structure is most appropriate for:

```sql
salary BETWEEN 50000 AND 60000
```

Answer:

> **B+ Tree / ordered index**

because linked leaves allow efficient sequential traversal.

---

### Pattern 6 — Height

Given number of records and fan-out, determine minimum height.

Use:

```text
capacity at height h
```

and find the smallest h such that:

```text
capacity ≥ required records
```

---

# 🔥 GATE Traps

1. **B+ Tree leaves are linked.**
2. Data/record pointers are generally at the **leaf level**.
3. Internal nodes primarily guide the search.
4. B+ Tree search normally reaches a leaf.
5. B+ Tree is excellent for **range queries**.
6. B+ Tree also supports equality searches.
7. High fan-out → small height.
8. Root has special minimum-occupancy rules.
9. Don't confuse **fan-out** with **number of keys**.
10. Don't confuse **internal-node capacity** with **leaf capacity**.
11. During leaf split, the data entries remain in leaves.
12. Parent separators are for navigation.
13. Root split increases height.
14. Root shrink can decrease height.
15. For disk-access questions, distinguish **index-page accesses** from **total accesses including data page**.
16. Always check how the question defines **order**.

---

# ⚡ 30-Second Revision

```text
B+ TREE
→ balanced multiway tree

INTERNAL NODE
→ separator keys + child pointers

LEAF
→ search keys + record/data pointers

LEAVES
→ linked

SEARCH
→ reaches leaf

INSERT
→ leaf
→ overflow
→ split
→ separator to parent

DELETE
→ leaf
→ underflow
→ borrow / merge

ROOT SPLIT
→ height +1

ROOT SHRINK
→ height −1

HIGH FAN-OUT
→ low height
→ fewer disk I/Os

B+ TREE
→ equality + range

HASH
→ mainly equality

RANGE QUERY
→ B+ Tree ⭐⭐⭐⭐⭐
```

## 🎯 GATE Priority

| Topic                   | Priority |
| ----------------------- | -------: |
| Fan-out/order           |    ⭐⭐⭐⭐⭐ |
| Height calculations     |    ⭐⭐⭐⭐⭐ |
| Maximum/minimum entries |    ⭐⭐⭐⭐⭐ |
| Insertion & splitting   |    ⭐⭐⭐⭐⭐ |
| Range queries           |    ⭐⭐⭐⭐⭐ |
| Disk I/O                |    ⭐⭐⭐⭐⭐ |
| B-Tree vs B+ Tree       |    ⭐⭐⭐⭐⭐ |
| Deletion/merging        |     ⭐⭐⭐⭐ |
| Leaf linkage            |     ⭐⭐⭐⭐ |

**Next: `12-Transactions.md`** — covering **ACID, transaction states, schedules, serializability, recoverability, and conflict/view concepts**.
