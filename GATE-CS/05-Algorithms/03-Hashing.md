# 03 — Hashing

# 1. THEORY

## 1.1 What is Hashing?

**Hashing** is a technique used to map a key to a location in a hash table using a **hash function**.

$$
\boxed{index=h(key)}
$$

Example:

```text
Hash table size = 10

h(k) = k mod 10
```

For:

```text
k = 27
```

$$
h(27)=27\bmod10=7
$$

So `27` is stored at index `7`.

---

# 2. HASH TABLE

A hash table consists of:

```text
Key
 ↓
Hash Function
 ↓
Index
 ↓
Hash Table
```

Example:

```text
h(k) = k mod 7
```

| Key | Hash |
| --: | ---: |
|  10 |    3 |
|  15 |    1 |
|  22 |    1 |
|  30 |    2 |

Notice:

```text
15 → 1
22 → 1
```

Two different keys map to the same location.

This is called a **collision**.

---

# 3. COLLISION ⭐⭐⭐⭐⭐

A collision occurs when:

$$
h(k_1)=h(k_2)
$$

for:

$$
k_1\ne k_2
$$

Example:

```text
h(k)=k mod 10

12 → 2
22 → 2
32 → 2
```

All three collide.

### GATE Trick

A collision is **not** an error.

It is an expected situation that must be handled by the hashing technique.

---

# 4. LOAD FACTOR ⭐⭐⭐⭐⭐

Load factor is:

$$
\boxed{\alpha=\frac{n}{m}}
$$

where:

* `n` = number of stored keys
* `m` = number of slots/buckets

Example:

```text
n = 7
m = 10
```

$$
\alpha=\frac7{10}=0.7
$$

---

## Important

For **open addressing**:

$$
\boxed{\alpha<1}
$$

because every key must occupy a table slot.

For **separate chaining**:

$$
\boxed{\alpha\text{ can be greater than }1}
$$

because a bucket can contain multiple keys.

### GATE Trap 🔥

> Load factor can never exceed 1.

❌ False for chaining.

---

# 5. GOOD HASH FUNCTION

A good hash function should distribute keys as uniformly as possible.

Ideal:

```text
Few collisions
+
Uniform distribution
+
Fast computation
```

A commonly used hash function:

$$
h(k)=k\bmod m
$$

where `m` is table size.

---

# 6. COLLISION RESOLUTION

The two major methods are:

### 1. Separate Chaining

```text
Bucket
 ↓
Linked List
```

### 2. Open Addressing

All keys are stored directly inside the hash table.

Common open-addressing techniques:

* Linear Probing
* Quadratic Probing
* Double Hashing

---

# 7. SEPARATE CHAINING ⭐⭐⭐⭐

Each hash-table slot contains a list of elements.

Example:

```text
h(k)=k mod 5
```

Insert:

```text
10 → 0
15 → 0
20 → 0
7  → 2
```

Table:

```text
0 → 10 → 15 → 20
1 →
2 → 7
3 →
4 →
```

---

## Complexity

Average:

$$
\boxed{O(1)}
$$

for search/insert/delete under a good hash function and controlled load factor.

Worst case:

$$
\boxed{O(n)}
$$

if all keys collide.

---

# 8. ADVANTAGES OF CHAINING

* Load factor can exceed 1.
* Deletion is relatively easy.
* No primary clustering in the open-addressing sense.
* Table does not need an empty slot for every key.

### Disadvantage

Extra memory is required for pointers/nodes.

---

# 9. LINEAR PROBING ⭐⭐⭐⭐⭐

Linear probing is an **open addressing** technique.

If the original position is occupied, check the next position.

Formula:

$$
\boxed{h_i(k)=(h(k)+i)\bmod m}
$$

where:

$$
i=0,1,2,\ldots
$$

Example:

```text
m = 7
h(k)=k mod 7
```

Insert `10`:

$$
10\bmod7=3
$$

Store at:

```text
3
```

Insert `17`:

$$
17\bmod7=3
$$

Collision.

Check:

```text
4
```

If free → store at `4`.

---

# 10. PRIMARY CLUSTERING ⭐⭐⭐⭐⭐

Linear probing suffers from:

$$
\boxed{\text{Primary Clustering}}
$$

A cluster of consecutive occupied slots forms.

Example:

```text
[ ][X][X][X][X][ ][ ]
     ← cluster →
```

New keys are increasingly likely to join this cluster.

### GATE Memory

```text
Linear Probing
       ↓
Primary Clustering
```

---

# 11. QUADRATIC PROBING

Instead of checking consecutive positions, use quadratic jumps.

Formula:

$$
\boxed{h_i(k)=(h(k)+c_1i+c_2i^2)\bmod m}
$$

Common simplified form:

$$
h_i(k)=(h(k)+i^2)\bmod m
$$

Positions might be:

```text
h
h+1
h+4
h+9
...
```

### Advantage

Reduces **primary clustering**.

### Important

Quadratic probing can still suffer from:

$$
\boxed{\text{Secondary Clustering}}
$$

---

# 12. SECONDARY CLUSTERING

Two keys with the same initial hash value follow the same probing sequence in quadratic probing.

Therefore:

```text
Same initial hash
        ↓
Same probe sequence
        ↓
Secondary clustering
```

### GATE Memory 🔥

| Technique         | Clustering           |
| ----------------- | -------------------- |
| Linear Probing    | Primary              |
| Quadratic Probing | Secondary            |
| Double Hashing    | Much less clustering |

---

# 13. DOUBLE HASHING ⭐⭐⭐⭐⭐

Uses a second hash function to determine the step size.

Formula:

$$
\boxed{h_i(k)=(h_1(k)+i\,h_2(k))\bmod m}
$$

Example:

$$
h_1(k)=k\bmod m
$$

$$
h_2(k)=1+(k\bmod(m-1))
$$

Different keys can therefore have different probe sequences.

### Advantage

It reduces both:

* Primary clustering
* Secondary clustering

compared with linear/quadratic probing.

---

# 14. OPEN ADDRESSING

In open addressing:

> Every element is stored directly in the hash table.

Therefore:

$$
\boxed{\alpha\le1}
$$

Usually we require:

$$
\boxed{\alpha<1}
$$

for successful operation.

### Important

When the table is full:

```text
No empty slot
↓
Cannot insert another key
```

---

# 15. DELETION IN OPEN ADDRESSING ⭐⭐⭐⭐

Deletion is tricky.

Suppose:

```text
10 → index 2
17 → index 3
24 → index 4
```

If we simply delete `17`:

```text
2 → 10
3 → EMPTY
4 → 24
```

Searching for `24` may stop at index `3` and incorrectly conclude that `24` doesn't exist.

Therefore we use a special marker:

```text
DELETED
```

rather than treating the slot as completely empty.

### GATE Trap

> Deleting an element in linear probing is always done by making the slot empty.

❌ Incorrect.

---

# 16. HASH TABLE SEARCH COMPLEXITY ⭐⭐⭐⭐⭐

Under good hashing:

### Average

$$
\boxed{O(1)}
$$

### Worst Case

$$
\boxed{O(n)}
$$

Worst case occurs when many/all keys collide.

### GATE Trap

> Hashing always provides O(1) search.

❌ False.

Correct:

$$
\boxed{\text{Expected/Average }O(1),\quad \text{Worst }O(n)}
$$

---

# 17. INSERTION COMPLEXITY

| Method            | Average | Worst |
| ----------------- | ------: | ----: |
| Chaining          |    O(1) |  O(n) |
| Linear Probing    |    O(1) |  O(n) |
| Quadratic Probing |    O(1) |  O(n) |
| Double Hashing    |    O(1) |  O(n) |

Assuming a good hash function and reasonable load factor for the average case.

---

# 18. SUCCESSFUL SEARCH vs UNSUCCESSFUL SEARCH

In open addressing, the number of probes differs between successful and unsuccessful searches.

As load factor:

$$
\alpha\rightarrow1
$$

the number of probes increases significantly.

### GATE Insight

High load factor:

```text
More occupied slots
↓
More collisions
↓
More probes
↓
Slower search
```

---

# 19. PERFECT HASHING

A perfect hash function maps each key to a unique position.

For a given set of keys:

$$
k_1\ne k_2
\Rightarrow
h(k_1)\ne h(k_2)
$$

Therefore:

```text
Collision = 0
```

Perfect hashing is particularly useful for **static sets of keys**.

---

# 20. UNIVERSAL HASHING

Universal hashing uses a family of hash functions rather than relying on a single fixed hash function.

The idea is to reduce the likelihood of bad collision patterns.

GATE generally focuses more on the **concept** than implementation details.

---

# 21. HASHING vs BST ⭐⭐⭐

| Feature           | Hash Table | Balanced BST |
| ----------------- | ---------- | ------------ |
| Average search    | O(1)       | O(log n)     |
| Worst search      | O(n)       | O(log n)     |
| Ordered traversal | ❌          | ✅            |
| Range queries     | Poor       | Good         |
| Exact lookup      | Excellent  | Good         |

### GATE Trick

If the question asks:

> "Find an exact key quickly"

think:

$$
\boxed{\text{Hashing}}
$$

If it asks:

> "Find all values between x and y"

think:

$$
\boxed{\text{BST / ordered structure}}
$$

---

# 22. HASHING TRICKS 🧠🔥

## Trick 1

```text
Open Addressing
→ α < 1
```

```text
Chaining
→ α can > 1
```

---

## Trick 2

```text
Linear Probing
→ Primary Clustering
```

---

## Trick 3

```text
Quadratic Probing
→ Reduces Primary
→ Secondary Clustering possible
```

---

## Trick 4

```text
Double Hashing
→ Different probe sequences
→ Best clustering behavior among common probing methods
```

---

## Trick 5

If:

$$
n>m
$$

then open addressing is impossible.

But chaining can still work.

Example:

```text
n = 15
m = 10
```

Open addressing:

```text
❌ Impossible
```

Chaining:

```text
✅ Possible
α = 1.5
```

---

# 23. PYQ-STYLE QUESTION 1 — Load Factor

A hash table has `20` slots and contains `15` keys.

Find the load factor.

### Solution

$$
\alpha=\frac{n}{m}
$$

$$
=\frac{15}{20}
$$

$$
\boxed{\alpha=0.75}
$$

---

# 24. PYQ-STYLE QUESTION 2 — Chaining

A hash table has `10` buckets and stores `25` keys using separate chaining.

What is the load factor?

### Solution

$$
\alpha=\frac{25}{10}
$$

$$
\boxed{2.5}
$$

### Important

This is completely valid because:

$$
\boxed{\alpha>1}
$$

is allowed in chaining.

---

# 25. PYQ-STYLE QUESTION 3 — Linear Probing ⭐⭐⭐⭐⭐

Hash table size:

```text
m = 10
```

Hash function:

$$
h(k)=k\bmod10
$$

Insert:

```text
23, 43, 13
```

Using linear probing, where will they be stored?

### Step 1

For `23`:

$$
23\bmod10=3
$$

Store:

```text
index 3 → 23
```

### Step 2

For `43`:

$$
43\bmod10=3
$$

Collision.

Try index `4`.

```text
index 4 → 43
```

### Step 3

For `13`:

$$
13\bmod10=3
$$

Collision at `3`.

Then:

```text
4 → occupied
5 → free
```

Therefore:

```text
index 5 → 13
```

### Final

```text
3 → 23
4 → 43
5 → 13
```

This is an example of **primary clustering**.

---

# 26. PYQ-STYLE QUESTION 4 — Probing

Which collision-resolution technique suffers from primary clustering?

A. Linear probing
B. Quadratic probing
C. Double hashing
D. Separate chaining

### Answer

$$
\boxed{\text{A. Linear probing}}
$$

---

# 27. PYQ-STYLE QUESTION 5 — Secondary Clustering

Which technique can suffer from secondary clustering?

A. Linear probing
B. Quadratic probing
C. Double hashing
D. Chaining

### Answer

$$
\boxed{\text{B. Quadratic probing}}
$$

### Why?

Keys with the same initial hash value follow the same quadratic probe sequence.

---

# 28. PYQ-STYLE QUESTION 6 — Worst Case

What is the worst-case search complexity in a hash table containing `n` elements?

### Answer

$$
\boxed{O(n)}
$$

### Why?

If all keys map to the same location:

```text
k1 → bucket
k2 → bucket
k3 → bucket
...
kn → bucket
```

we may have to inspect all `n` elements.

---

# 29. PYQ-STYLE QUESTION 7 — Open Addressing

A hash table uses open addressing and has `10` slots.

Can it store `12` elements?

### Answer

$$
\boxed{\text{No}}
$$

Because:

$$
\alpha=\frac{12}{10}=1.2
$$

and open addressing requires:

$$
\boxed{\alpha<1}
$$

---

# 30. PYQ-STYLE QUESTION 8 — Hash Function

Given:

$$
h(k)=k\bmod7
$$

Which keys collide?

```text
10, 17, 24, 31
```

### Solution

```text
10 mod 7 = 3
17 mod 7 = 3
24 mod 7 = 3
31 mod 7 = 3
```

Therefore:

$$
\boxed{10,17,24,31}
$$

all collide.

---

# 31. PYQ-STYLE QUESTION 9 — Deletion

Why can't a deleted slot in linear probing always be marked as `EMPTY`?

### Answer

Because it can prematurely terminate a later search.

Example:

```text
10 → 2
17 → 3
24 → 4
```

Delete `17`.

If index `3` becomes `EMPTY`, searching for `24` may do:

```text
2 → 10
3 → EMPTY
```

and incorrectly conclude that `24` is absent.

Therefore use:

```text
DELETED / TOMBSTONE
```

---

# 32. GATE QUICK REVISION ⚡

```text
HASHING
↓
key → hash function → index
```

```text
COLLISION
↓
h(k1) = h(k2)
where k1 ≠ k2
```

```text
LOAD FACTOR
↓
α = n/m
```

```text
CHAINING
↓
α can > 1
```

```text
OPEN ADDRESSING
↓
α < 1
```

```text
LINEAR PROBING
↓
(h(k)+i) mod m
↓
Primary Clustering
```

```text
QUADRATIC PROBING
↓
h(k)+c₁i+c₂i²
↓
Secondary Clustering possible
```

```text
DOUBLE HASHING
↓
h₁(k)+i h₂(k)
↓
Less clustering
```

```text
AVERAGE HASH SEARCH
↓
O(1)
```

```text
WORST HASH SEARCH
↓
O(n)
```

---

# 33. 🔥 GATE MUST-MEMORIZE TABLE

| Concept              | Answer                                            |
| -------------------- | ------------------------------------------------- |
| Load factor          | `n/m`                                             |
| Chaining α           | Can be > 1                                        |
| Open addressing α    | < 1                                               |
| Linear probing       | Primary clustering                                |
| Quadratic probing    | Secondary clustering                              |
| Double hashing       | Minimizes clustering among common probing methods |
| Average hash search  | O(1)                                              |
| Worst hash search    | O(n)                                              |
| Perfect hashing      | No collisions for given key set                   |
| Deletion in probing  | Use tombstone/deleted marker                      |
| Exact lookup         | Hashing                                           |
| Ordered/range search | BST                                               |
| `h(k)=k mod m`       | Division method                                   |
| Collision            | Same hash index for different keys                |

### 🧠 Ultimate GATE Chain

$$
\boxed{\text{Hashing}\rightarrow\text{Collision}\rightarrow\text{Load Factor}\rightarrow\text{Collision Resolution}}
$$

and:

$$
\boxed{\text{Linear}\rightarrow\text{Primary}}
$$

$$
\boxed{\text{Quadratic}\rightarrow\text{Secondary}}
$$

$$
\boxed{\text{Double Hashing}\rightarrow\text{Different Probe Sequences}}
$$

**Next: `04-Time-Complexity.md` — asymptotic notation, Big-O/Ω/Θ, recurrences, loops, logarithms, Master Theorem, GATE tricks + PYQs.**
