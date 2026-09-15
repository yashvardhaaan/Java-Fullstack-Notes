# 09 — Indexing

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**

Indexing is one of the most important DBMS topics for GATE, especially **dense vs sparse index, primary vs secondary index, multilevel indexing, clustered index, and index calculations**.

> **First principle:** An index is an auxiliary structure that helps the DBMS **find records/pages without scanning the entire file**.

---

# 1. What is an Index?

Suppose the data file contains:

```text
Roll    Name
101     A
102     B
103     C
...
10000   Z
```

Instead of scanning every record:

```text
Search
  ↓
Index
  ↓
Data block
  ↓
Record
```

The index stores:

```text
Search key → pointer
```

Example:

```text
101 → Block 1
201 → Block 2
301 → Block 3
```

---

# 2. Search Key

The **search key** is the attribute(s) used to search the index.

Example:

```text
Student(Roll, Name, Branch)
```

An index can be built on:

```text
Roll
Name
Branch
(Roll, Branch)
```

⚠️ **GATE Trap**

> Search key does **not necessarily mean candidate key**.

An index search key can contain duplicate values.

---

# 3. Dense Index ⭐⭐⭐⭐⭐

A dense index contains an index entry for **every search-key value / record**, depending on the exact organization.

Example:

```text
Data:
10 A
20 B
30 C
40 D
```

Dense index:

```text
10 → pointer
20 → pointer
30 → pointer
40 → pointer
```

### Advantage

Fast lookup.

### Disadvantage

Requires more index space.

---

# 4. Sparse Index ⭐⭐⭐⭐⭐

A sparse index contains entries for **only some search-key values**, commonly one entry per data block.

Example:

```text
Block 1 → records 10,20,30
Block 2 → records 40,50,60
Block 3 → records 70,80,90
```

Sparse index:

```text
10 → Block 1
40 → Block 2
70 → Block 3
```

The DBMS then searches within the identified block.

---

# 5. Dense vs Sparse

| Dense                        | Sparse                          |
| ---------------------------- | ------------------------------- |
| More entries                 | Fewer entries                   |
| More space                   | Less space                      |
| Faster/direct lookup         | Additional search within block  |
| Can work with unordered data | Generally requires ordered data |

🔥 **GATE Shortcut**

```text
Dense  → every
Sparse → some
```

---

# 6. Primary Index ⭐⭐⭐⭐⭐

A **primary index** is built on the ordering key of an ordered data file.

Typically:

```text
Data file sorted by primary key
             ↓
        Primary index
```

A primary index is generally **sparse**.

Example:

```text
Data file

Block 1: 10 15 18
Block 2: 25 30 32
Block 3: 40 45 49
```

Primary index:

```text
10 → Block 1
25 → Block 2
40 → Block 3
```

🔥 **Classic GATE fact**

> **Primary index → ordered file → generally sparse.**

---

# 7. Clustering Index

A clustering index is based on an attribute according to which the records are physically grouped.

Example:

```text
Department

CSE
CSE
CSE
ECE
ECE
ME
ME
ME
```

A clustering index can point to the beginning of each cluster.

```text
CSE → first CSE block
ECE → first ECE block
ME  → first ME block
```

The clustering attribute does **not necessarily have to be unique**.

---

# 8. Secondary Index ⭐⭐⭐⭐⭐

An index on a field that is **not the ordering field** of the data file.

Example:

```text
Data file ordered by RollNo

RollNo   Name
101      Amit
102      Ravi
103      Amit
```

Index on `Name`:

```text
Amit → pointers
Ravi → pointer
```

This is a **secondary index**.

---

# 9. Secondary Index is Usually Dense

Because the data file isn't ordered on the secondary search key, direct sparse indexing isn't generally possible.

Therefore:

> Secondary indexes are generally **dense**.

🔥 **Memory**

```text
Primary   → sparse
Secondary → dense
```

This is a very common GATE question.

---

# 10. Primary vs Secondary Index

| Primary Index                | Secondary Index                     |
| ---------------------------- | ----------------------------------- |
| Based on ordering key        | Not based on ordering key           |
| Data file ordered on key     | File need not be ordered on it      |
| Generally sparse             | Generally dense                     |
| Usually one primary ordering | Multiple secondary indexes possible |

---

# 11. Multilevel Index ⭐⭐⭐⭐⭐

Suppose the index itself becomes too large.

Then:

```text
Data
 ↑
Level 1 index
 ↑
Level 2 index
 ↑
Level 3 index
```

The higher-level index indexes the lower-level index.

Example:

```text
Level 3
   ↓
Level 2
   ↓
Level 1
   ↓
Data blocks
```

This reduces the number of disk accesses needed to locate the target.

---

# 12. Why Multilevel Index?

Suppose:

```text
Data blocks = 1,000,000
```

A single huge index may itself occupy thousands of blocks.

Instead:

```text
Top index
   ↓
smaller index
   ↓
smaller index
   ↓
data
```

Each level reduces the search space.

---

# 13. Index Blocking Factor ⭐⭐⭐⭐⭐

Suppose:

```text
Index entry size = 20 bytes
Block size = 100 bytes
```

Then:

```text
Index blocking factor
= floor(100/20)
= 5
```

So each index block stores:

```text
5 entries
```

---

# 14. Number of Index Blocks

If there are:

```text
N index entries
```

and:

```text
bfr_index = number of entries/index block
```

then:

```text
Number of index blocks
=
ceil(N / bfr_index)
```

---

# 15. Multilevel Index Calculation

Suppose:

```text
Number of entries = 10,000
Index blocking factor = 100
```

Level 1:

```text
10000 / 100 = 100 blocks
```

Level 2:

```text
100 / 100 = 1 block
```

So:

```text
Level 2
   ↓
Level 1
   ↓
Data
```

Search requires approximately:

```text
2 index-block accesses + 1 data-block access
```

depending on the exact assumptions in the question.

🔥 **GATE Trap**

Always carefully check whether the question counts:

* index block accesses only
* index + data block accesses
* root access separately

---

# 16. Dense Index Entry Count

Suppose:

```text
N = 10,000 records
```

If there is one index entry per record:

```text
Index entries = 10,000
```

If each entry is:

```text
20 bytes
```

and block size:

```text
100 bytes
```

then:

```text
bfr = 5
```

and:

```text
index blocks = 10000/5
             = 2000
```

---

# 17. Sparse Index Entry Count

Suppose:

```text
Data blocks = 500
```

and sparse index contains one entry per block.

Then:

```text
Index entries = 500
```

🔥 **Shortcut**

If the question says:

> sparse index with one entry per block

then:

```text
number of index entries = number of data blocks
```

---

# 18. Dense vs Sparse Numerical

Suppose:

```text
10,000 records
100 records/block
```

Therefore:

```text
Data blocks = 100
```

### Dense index

One entry per record:

```text
10,000 entries
```

### Sparse index

One entry per block:

```text
100 entries
```

Huge difference.

---

# 19. Clustered Index

Don't confuse:

```text
Clustering index
```

with:

```text
Clustered index
```

The central idea is physical ordering/grouping of data according to the indexed attribute.

Example:

```text
Dept = CSE
Dept = CSE
Dept = CSE
Dept = ECE
Dept = ECE
```

Records belonging to the same value are physically clustered.

---

# 20. Composite Index

Index can use multiple attributes.

Example:

```sql id="9jy1by"
CREATE INDEX idx_student
ON Student(Branch, Marks);
```

This creates a composite index on:

```text
(Branch, Marks)
```

🔥 Important concept:

> Order of attributes matters.

An index on:

```text
(A,B)
```

is not generally equivalent to:

```text
(B,A)
```

---

# 21. B-Tree/B+ Tree vs Traditional Indexing

The earlier indexing concepts explain **what an index is**.

B-Trees and B+ Trees explain **how large dynamic indexes can be implemented efficiently**.

Think:

```text
Index
  ↓
Possible implementation
  ↓
B-Tree / B+ Tree
```

These are covered in the next two files.

---

# 22. Index Advantages

### Faster search

```text
Full scan
→ many blocks
```

versus:

```text
Index
→ target block
```

### Faster range queries

Especially with ordered indexes.

### Faster joins

Indexes on join attributes can reduce search cost.

---

# 23. Index Disadvantages

Indexes require:

* Additional storage
* Maintenance during insertion
* Maintenance during deletion
* Maintenance during updates

Therefore:

> More indexes ≠ always better.

---

# 24. When Hashing Beats Indexing

For exact equality:

```sql id="j2e2s4"
WHERE roll = 100
```

hashing can be excellent.

For range:

```sql id="68qf2n"
WHERE roll BETWEEN 100 AND 200
```

ordered indexes such as B+ trees are usually better.

🔥 **Remember**

```text
Equality → Hash
Range    → B+ Tree
```

---

# 🧠 GATE PYQ Patterns

GATE frequently asks indexing questions in numerical form.

### Pattern 1 — Dense vs Sparse

Given:

```text
records
records/block
```

find the number of:

```text
dense index entries
sparse index entries
```

Remember:

```text
Dense  → records/search-key values
Sparse → blocks
```

---

### Pattern 2 — Index block calculation

Given:

```text
block size
index entry size
number of entries
```

Calculate:

```text
bfr_index = floor(block size / entry size)

index blocks = ceil(entries / bfr_index)
```

---

### Pattern 3 — Multilevel index

Given:

```text
data blocks
index blocking factor
```

find how many index levels are required.

Repeatedly divide:

```text
N
↓
ceil(N/bfr)
↓
ceil(previous/bfr)
↓
...
```

until:

```text
1 block
```

---

### Pattern 4 — Primary vs Secondary

Typical conceptual question:

> Which index is generally sparse?

**Primary index.**

> Which is generally dense?

**Secondary index.**

---

### Pattern 5 — Best index for range query

Question:

```sql id="0p0a1w"
WHERE salary >= 50000
AND salary <= 70000
```

Think:

> **Ordered index / B+ Tree**, not hash.

---

# 🔥 GATE Traps

1. **Primary index is generally sparse.**
2. **Secondary index is generally dense.**
3. Sparse indexing generally requires an ordered data file.
4. Dense index has more entries than sparse index.
5. Sparse does NOT mean one entry per arbitrary random record; commonly one per block.
6. Search key does not have to be a candidate key.
7. Secondary index can be built on a non-unique attribute.
8. Multiple secondary indexes can exist.
9. Index itself occupies disk blocks.
10. Large indexes can require multilevel indexing.
11. Calculate index blocking factor using **index-entry size**, not record size.
12. `(A,B)` index ≠ `(B,A)` index.
13. Hashing is poor for range queries.
14. B+ trees are excellent for equality **and** range queries.
15. Index improves search but introduces update/storage overhead.

---

# ⚡ 30-Second Revision

```text
INDEX
→ search key + pointer

DENSE
→ entry for every record/search-key value

SPARSE
→ fewer entries
→ commonly one per data block

PRIMARY INDEX
→ ordered data file
→ generally sparse

SECONDARY INDEX
→ non-ordering field
→ generally dense

CLUSTERING INDEX
→ records physically grouped by search key

MULTILEVEL
→ index over index

INDEX BFR
= floor(block size / index-entry size)

INDEX BLOCKS
= ceil(index entries / index BFR)

EQUALITY
→ Hash

RANGE
→ B+ Tree / ordered index

INDEX
→ faster search
→ extra storage + maintenance
```

## 🎯 GATE Priority

| Topic                     | Priority |
| ------------------------- | -------: |
| Dense vs Sparse           |    ⭐⭐⭐⭐⭐ |
| Primary vs Secondary      |    ⭐⭐⭐⭐⭐ |
| Index calculations        |    ⭐⭐⭐⭐⭐ |
| Multilevel indexing       |    ⭐⭐⭐⭐⭐ |
| Block access calculations |    ⭐⭐⭐⭐⭐ |
| Clustering index          |     ⭐⭐⭐⭐ |
| Composite indexes         |      ⭐⭐⭐ |
| Index advantages/cost     |      ⭐⭐⭐ |

**Next: `10-B-Trees.md`** — this is another high-priority GATE topic, especially **order, height, minimum/maximum keys, insertion and deletion**.
