# 08 — File Organization

> **GATE Priority: ⭐⭐⭐⭐ HIGH**

File organization deals with **how records are physically stored on secondary storage**.

> **First principle:** The goal is to arrange records so that the required operations—search, insertion, deletion, sequential access—are efficient.

---

# 1. Basic Terminology

### Record

A collection of related fields representing one tuple.

### Block / Page

Unit of data transferred between disk and main memory.

### File

Collection of records.

Typical hierarchy:

```text
Database
   ↓
File
   ↓
Block / Page
   ↓
Record
   ↓
Fields
```

🔥 **GATE Trap**

The DBMS generally transfers data between disk and memory in **blocks/pages**, not individual records.

---

# 2. Fixed-Length Records

Every record has the same size.

Example:

```text
Student
Roll : 4 bytes
Age  : 4 bytes
Marks: 4 bytes
```

Record size:

```text
4 + 4 + 4 = 12 bytes
```

If block size = 100 bytes:

```text
Blocking factor = floor(100 / 12)
                = 8 records/block
```

---

# 3. Blocking Factor ⭐⭐⭐⭐⭐

**Blocking factor (bfr)**:

```text
bfr = floor(Block size / Record size)
```

Example:

```text
Block = 4096 bytes
Record = 100 bytes
```

```text
bfr = floor(4096/100)
    = 40
```

Therefore:

```text
40 records/block
```

---

# 4. Number of Blocks

If:

```text
N = number of records
bfr = blocking factor
```

then:

```text
Number of blocks = ceil(N / bfr)
```

Example:

```text
N = 1000
bfr = 40
```

```text
Blocks = ceil(1000/40)
       = 25
```

---

# 5. Spanned vs Unspanned Records

## Unspanned

A record cannot cross block boundaries.

```text
Block 1
┌──────────────┐
│ Record       │
└──────────────┘

Block 2
┌──────────────┐
│ Record       │
└──────────────┘
```

If remaining space is insufficient for the next record, that space may be wasted.

---

## Spanned

A record can cross block boundaries.

```text
Block 1
┌──────────────┐
│ Record part  │
└───────┬──────┘
        ↓
Block 2
┌───────┴──────┐
│ Record rest  │
└──────────────┘
```

🔥 **GATE Trick**

> **Spanned → better space utilization**
> **Unspanned → simpler record access**

---

# 6. Heap / Unordered File Organization ⭐⭐⭐⭐⭐

Records are stored without any particular ordering.

```text
[Record 5]
[Record 1]
[Record 9]
[Record 3]
[Record 7]
```

### Advantages

* Very simple
* Fast insertion
* Good when records are frequently inserted

### Disadvantages

* Searching can require scanning many blocks
* Poor for ordered/range queries

### Search

Without an index:

```text
Worst case ≈ all blocks
```

---

# 7. Sequential / Ordered File Organization

Records are stored according to a search key.

Example:

```text
10
20
30
40
50
60
```

### Advantages

* Efficient sequential processing
* Good for range queries
* Can support binary search if physical organization permits

### Disadvantages

* Insertion can be expensive
* Deletion may require reorganization
* Maintaining order costs time

🔥 **GATE Comparison**

```text
Heap → insertion
Sorted → searching/range access
```

---

# 8. Hash File Organization ⭐⭐⭐⭐⭐

A hash function determines where a record should be stored.

```text
h(key) → bucket
```

Example:

```text
h(25) = 3
```

So record with key 25 goes to bucket 3.

---

# 9. Hash Collision

Two different keys may map to the same bucket.

```text
h(10) = 4
h(20) = 4
```

This is a **collision**.

Collision handling may use:

* Overflow buckets
* Chaining
* Open addressing (in general hashing contexts)

---

# 10. Static Hashing

Number of buckets is fixed.

```text
h(key) → fixed bucket
```

Problem:

As the file grows, overflow can increase.

---

# 11. Dynamic Hashing

Number of buckets can grow/shrink.

Important concepts:

* Extendible hashing
* Linear hashing

These are generally more important when studying indexing/hashing in depth.

---

# 12. Hashing vs Sequential Organization

| Feature            | Hash      | Sequential     |
| ------------------ | --------- | -------------- |
| Exact-match search | ⭐⭐⭐⭐⭐     | ⭐⭐⭐            |
| Range search       | ⭐         | ⭐⭐⭐⭐⭐          |
| Sequential access  | ⭐⭐        | ⭐⭐⭐⭐⭐          |
| Average insertion  | Good      | More expensive |
| Equality queries   | Excellent | Good           |

🔥 **GATE Trick**

> Hashing is excellent for **equality**, poor for **range**.

Example:

```sql
WHERE roll = 100
```

→ Hashing is excellent.

```sql
WHERE roll BETWEEN 100 AND 200
```

→ Ordered/index structure is better.

---

# 13. File Organization Comparison

| Organization | Search         | Insert | Range |
| ------------ | -------------- | ------ | ----- |
| Heap         | Poor           | ⭐⭐⭐⭐⭐  | Poor  |
| Sorted       | Good           | Poor   | ⭐⭐⭐⭐⭐ |
| Hash         | ⭐⭐⭐⭐⭐ equality | Good   | Poor  |

Remember:

```text
Heap   → INSERT
Sorted → RANGE
Hash   → EQUALITY
```

---

# 14. Record Insertion

## Heap file

Usually place the new record wherever free space exists.

```text
Free space
   ↓
insert record
```

Very efficient.

## Sorted file

Must preserve ordering.

May require:

```text
shift records
```

or:

```text
overflow area
```

Therefore insertion is more expensive.

---

# 15. Record Deletion

Deletion can create holes:

```text
R1
R2
DELETED
R4
```

The DBMS may later perform:

* Compaction
* Reorganization
* Free-space management

---

# 16. Search Cost in Blocks ⭐⭐⭐⭐⭐

GATE often asks the number of **block accesses**, not just comparisons.

Suppose:

```text
N records
bfr = records/block
```

Then:

```text
B = ceil(N/bfr)
```

If an unordered file must be scanned:

```text
Worst case = B block accesses
```

Average successful search is approximately:

```text
B/2
```

assuming uniform distribution and one matching record.

---

# 17. Binary Search on Ordered File

For a sorted file with:

```text
B = number of blocks
```

block-level binary search requires approximately:

```text
ceil(log₂ B)
```

block accesses.

🔥 **Important**

Don't blindly use:

```text
log₂(number of records)
```

when the question is asking **block accesses**.

---

# 18. Primary vs Secondary Storage

DBMS file organization is mainly concerned with **secondary storage** because disk/SSD access is much slower than memory access.

Conceptually:

```text
CPU
 ↓
RAM
 ↓
Disk/SSD
```

The major performance cost in traditional DBMS questions is often:

> **Number of disk/page I/Os.**

---

# 19. Blocking Factor Numerical

Suppose:

```text
Block size = 1024 bytes
Record size = 100 bytes
Records = 10,000
```

### Step 1

```text
bfr = floor(1024/100)
    = 10
```

### Step 2

```text
Blocks = ceil(10000/10)
       = 1000
```

So a full sequential scan requires:

```text
1000 block accesses
```

---

# 20. Variable-Length Records

Records can have different sizes.

Example:

```text
Student 1 → 50 bytes
Student 2 → 100 bytes
Student 3 → 70 bytes
```

Managing them requires additional information such as:

* Record offsets
* Length information
* Slot directories

---

# 21. Slotted Page

Very important concept for variable-length records.

Conceptually:

```text
Page
┌─────────────────────┐
│ Header              │
│ Slot 1              │
│ Slot 2              │
│ Slot 3              │
│                     │
│       Records       │
│                     │
└─────────────────────┘
```

A slot directory maps a record identifier to its physical location.

### Advantage

Records can move within the page while their **slot number remains stable**.

---

# 22. Dense vs Sparse Storage Concept

This becomes especially important with indexing.

### Dense

An entry exists for:

```text
every search-key value / record
```

### Sparse

Entries exist only for:

```text
some search-key values
```

A sparse structure generally requires the data file to be **ordered** on the search key.

🔥 **GATE Trick**

> Sparse index → usually requires ordered data file.

---

# 23. File Organization vs Indexing

Do not confuse them.

### File organization

Determines:

> **How the actual records are stored.**

### Index

Determines:

> **How we quickly locate those records.**

Example:

```text
Data file
   ↓
Records stored on disk

Index
   ↓
Pointers → records/pages
```

---

# 🧠 GATE PYQ Patterns

### Pattern 1 — Blocking factor

Given:

```text
Block size
Record size
Number of records
```

find:

```text
records/block
number of blocks
```

Use:

```text
bfr = floor(B/R)
blocks = ceil(N/bfr)
```

---

### Pattern 2 — Number of block accesses

Given an unordered file:

```text
N records
B blocks
```

questions may ask:

* best case
* worst case
* average case

For linear search:

```text
Best ≈ 1
Worst = B
Average ≈ B/2
```

assuming one matching record and uniform placement.

---

### Pattern 3 — Choose appropriate organization

Question:

> Which organization is best for frequent exact-match searches?

Answer:

**Hashing**

Question:

> Which is better for range queries?

Answer:

**Ordered/indexed organization**

Question:

> Which gives simplest/faster insertion?

Answer:

**Heap**

---

### Pattern 4 — Spanned vs unspanned

Given:

```text
block size
record size
number of records
```

determine the number of blocks under:

* spanned organization
* unspanned organization

The key is whether a record is allowed to cross the block boundary.

---

### Pattern 5 — Block vs record access

If:

```text
1000 records
100 records/block
```

don't answer 500 comparisons if the question asks disk accesses.

Instead:

```text
10 blocks
```

and reason in **block I/O**.

---

# 🔥 GATE Traps

1. Disk I/O is measured primarily in **blocks/pages**.
2. `floor()` is used for blocking factor.
3. `ceil()` is used for number of blocks.
4. Heap → easiest/faster insertion.
5. Hash → equality search.
6. Hash → poor range queries.
7. Sorted → excellent range queries.
8. Sorted → insertion is expensive.
9. Spanned → record can cross block boundary.
10. Unspanned → record cannot cross block boundary.
11. Sparse index generally requires ordered data.
12. File organization ≠ index.
13. For binary search, if searching blocks, use **number of blocks**, not records.
14. Collision occurs when different keys map to the same bucket.
15. Dynamic hashing can expand as data grows.

---

# ⚡ 30-Second Revision

```text
BLOCKING FACTOR
= floor(Block size / Record size)

NUMBER OF BLOCKS
= ceil(Number of records / blocking factor)

HEAP
→ unordered
→ fastest/simple insertion

SORTED
→ ordered
→ good range search
→ expensive insertion

HASH
→ h(key) → bucket
→ excellent equality search
→ poor range search

SPANNED
→ record may cross blocks

UNSPANNED
→ record stays within one block

LINEAR SEARCH
Best ≈ 1 block
Worst = B blocks
Average ≈ B/2

BINARY SEARCH
≈ ceil(log₂ B) block accesses

SPARSE
→ usually needs ordered data

FILE ORGANIZATION
→ physical arrangement of records

INDEX
→ structure for fast record location
```

## 🎯 GATE Priority

| Topic                                | Priority |
| ------------------------------------ | -------: |
| Blocking factor & block calculations |    ⭐⭐⭐⭐⭐ |
| Disk/block access calculations       |    ⭐⭐⭐⭐⭐ |
| Heap/Sorted/Hash comparison          |    ⭐⭐⭐⭐⭐ |
| Spanned vs Unspanned                 |     ⭐⭐⭐⭐ |
| Hashing & collisions                 |     ⭐⭐⭐⭐ |
| Variable-length records              |      ⭐⭐⭐ |
| Slotted pages                        |      ⭐⭐⭐ |
| File vs Index distinction            |     ⭐⭐⭐⭐ |

**Next: `09-Indexing.md`**
