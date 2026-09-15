# 07 — Normal Forms

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**

Normalization is one of the **most important DBMS topics for GATE**.
You must be strong in **Functional Dependencies, candidate keys, attribute closure, 2NF, 3NF, BCNF, lossless decomposition, and dependency preservation**.

---

# 1. Why Normalization?

Poorly designed tables cause:

### Insertion anomaly

Cannot insert some information without unrelated information.

### Deletion anomaly

Deleting one fact accidentally removes another fact.

### Update anomaly

Same information exists in multiple places and must be updated repeatedly.

> **First principle:** Normalization reduces **redundancy and anomalies** by decomposing relations using dependencies.

---

# 2. Functional Dependency (FD)

An FD:

```text id="xqj5v1"
X → Y
```

means:

> If two tuples have the same X value, they must have the same Y value.

Example:

```text id="y1e8so"
RollNo → StudentName
```

A student roll number determines the student's name.

---

# 3. Trivial Functional Dependency

`X → Y` is trivial if:

```text id="vpr6nq"
Y ⊆ X
```

Example:

```text id="4c8qv3"
AB → A
AB → B
```

are trivial.

🔥 **GATE Trick**

> RHS already contained in LHS → **trivial FD**.

---

# 4. Attribute Closure ⭐⭐⭐⭐⭐

Closure of X:

```text id="2zv3lo"
X+
```

= all attributes functionally determined by X.

### Example

Relation:

```text id="wqj5g4"
R(A,B,C,D)
```

FDs:

```text id="9p7xsy"
A → B
B → C
C → D
```

Find `A+`.

Start:

```text id="4w4k9v"
A+ = {A}
```

Using `A → B`:

```text id="8k1fby"
A+ = {A,B}
```

Using `B → C`:

```text id="6oz4p2"
A+ = {A,B,C}
```

Using `C → D`:

```text id="zj64cv"
A+ = {A,B,C,D}
```

Therefore:

```text id="dshn4a"
A+ = ABCD
```

So A is a **superkey**.

If no proper subset of A is a superkey:

→ A is a **candidate key**.

---

# 5. Candidate Key Using Closure

For relation:

```text id="q3xxb6"
R(A,B,C,D)
```

If:

```text id="k3c2bm"
A+ = ABCD
```

then:

```text id="w2cz1x"
A → all attributes
```

Therefore A is a superkey.

If A is a single attribute:

> A is automatically minimal.

So A is a candidate key.

---

# 6. Prime vs Non-Prime Attributes

### Prime attribute

Appears in **at least one candidate key**.

### Non-prime attribute

Does not appear in any candidate key.

Example:

```text id="f0lq4m"
Candidate keys = {AB, CD}
```

Then:

```text id="kw4p5b"
A,B,C,D → prime
```

Everything else → non-prime.

🔥 **GATE Trap**

> An attribute being part of a superkey is NOT enough to make it prime.
> It must belong to a **candidate key**.

---

# 7. Armstrong's Axioms ⭐⭐⭐⭐⭐

Three fundamental inference rules:

### Reflexivity

If:

```text id="90i8zw"
Y ⊆ X
```

then:

```text id="2a7bqk"
X → Y
```

---

### Augmentation

If:

```text id="zh2v3f"
X → Y
```

then:

```text id="5x0qyw"
XZ → YZ
```

---

### Transitivity

If:

```text id="k0y4ft"
X → Y
Y → Z
```

then:

```text id="rqj2nb"
X → Z
```

---

# 8. Useful Derived Rules

### Union

```text id="l1qjvb"
X → Y
X → Z
────────
X → YZ
```

### Decomposition

```text id="5v1f2k"
X → YZ
────────
X → Y
X → Z
```

### Pseudotransitivity

```text id="l4gq54"
X → Y
WY → Z
────────
WX → Z
```

🔥 GATE often gives FDs and asks whether another FD is implied.

---

# 9. 1NF

A relation is in **First Normal Form (1NF)** when attributes contain atomic values.

Example violating 1NF:

```text id="0pk7hw"
Student
Roll | Phone
1    | 9876, 8765
```

Multiple phone values in one cell → not atomic.

Correct design:

```text id="2n8g3j"
Roll | Phone
1    | 9876
1    | 8765
```

> **1NF → atomic attributes.**

---

# 10. 2NF ⭐⭐⭐⭐

A relation is in 2NF if:

1. It is in **1NF**
2. No non-prime attribute is **partially dependent** on a candidate key.

### Partial dependency

Suppose:

```text id="j5m2wq"
Candidate key = {A,B}

A → C
```

and C is non-prime.

Then:

```text id="7o6e5u"
AB → C
A  → C
```

C depends on only **part of the composite key**.

Therefore → **violates 2NF**.

---

# 11. Important 2NF Trick

If **every candidate key is a single attribute**, the relation is automatically in 2NF.

Why?

A single attribute has no proper non-empty subset.

🔥 **GATE Shortcut**

> **No composite candidate key → automatically 2NF** (assuming 1NF).

---

# 12. 3NF ⭐⭐⭐⭐⭐

A relation is in 3NF if for every non-trivial FD:

```text id="d4s5gc"
X → A
```

at least one is true:

1. X is a **superkey**, OR
2. A is a **prime attribute**.

This is the formal GATE definition.

---

# 13. 3NF Easy Understanding

A common way to remember:

> No non-prime attribute should depend transitively on a candidate key.

Example:

```text id="t4d0b4"
A → B
B → C
```

Suppose:

```text id="6b8q4c"
A = candidate key
C = non-prime
```

Then:

```text id="5xk1h0"
A → B → C
```

C is transitively dependent on A.

→ violates 3NF if B isn't a superkey.

---

# 14. BCNF ⭐⭐⭐⭐⭐

A relation is in BCNF if for **every non-trivial FD**:

```text id="c3j4de"
X → Y
```

X must be a **superkey**.

That's it.

> **BCNF is stricter than 3NF.**

---

# 15. 3NF vs BCNF

| 3NF                             | BCNF                           |
| ------------------------------- | ------------------------------ |
| X is superkey **OR** Y is prime | X **must** be superkey         |
| Weaker                          | Stronger                       |
| Every BCNF relation is 3NF      | Not every 3NF relation is BCNF |

🔥 **Most important distinction**

Consider:

```text id="3f2g0p"
A → B
```

If:

* A is not a superkey
* B is prime

Then:

```text id="2l6y5r"
3NF → satisfied
BCNF → violated
```

---

# 16. Example: 3NF but Not BCNF

Consider:

```text id="4v5gub"
R(A,B,C)
```

FDs:

```text id="h1f8d7"
AB → C
C → B
```

Candidate keys:

```text id="1k5c7r"
AB
AC
```

Therefore:

```text id="0o2x8d"
A,B,C are all prime
```

For:

```text id="n4d8p9"
C → B
```

C is not a superkey.

So:

```text id="0j7c6q"
BCNF ❌
```

But B is prime.

Therefore:

```text id="f4r8gk"
3NF ✅
```

🔥 Classic GATE pattern.

---

# 17. Normal Form Hierarchy

```text id="f0u1at"
BCNF
  ↓
3NF
  ↓
2NF
  ↓
1NF
```

Therefore:

```text id="2hj8yw"
BCNF ⇒ 3NF ⇒ 2NF ⇒ 1NF
```

But reverse implication is **not guaranteed**.

---

# 18. Lossless Decomposition ⭐⭐⭐⭐⭐

Suppose:

```text id="q1e6pu"
R → R1, R2
```

A decomposition is **lossless** if joining the decomposed relations reconstructs exactly the original relation.

No spurious tuples should appear.

---

# 19. Binary Lossless-Join Test

For decomposition:

```text id="6m1g9a"
R → R1, R2
```

It is lossless if:

```text id="9u4xw5"
(R1 ∩ R2) → R1
```

OR

```text id="s8y0j1"
(R1 ∩ R2) → R2
```

with respect to F⁺.

🔥 **GATE Formula**

> Common attributes must functionally determine **one complete decomposed relation**.

---

# 20. Example of Lossless Decomposition

```text id="zq9s6n"
R(A,B,C)
```

FD:

```text id="a2f5y6"
A → B
```

Decompose:

```text id="4w2n7e"
R1(A,B)
R2(A,C)
```

Common attributes:

```text id="5d8v0k"
R1 ∩ R2 = {A}
```

And:

```text id="q0m4s8"
A → AB
```

because A → B.

Therefore decomposition is:

```text id="2y4s9w"
LOSSLESS
```

---

# 21. Dependency Preservation ⭐⭐⭐⭐⭐

A decomposition is dependency preserving if all original FDs can be enforced by checking the decomposed relations **without joining them**.

> **First principle:** You should not need to reconstruct the original table just to check an FD.

---

# 22. Lossless vs Dependency Preserving

These are **different properties**.

| Property              | Meaning                                   |
| --------------------- | ----------------------------------------- |
| Lossless              | No information/spurious tuples after join |
| Dependency preserving | FDs can be checked locally                |

A decomposition may be:

```text id="c8m4xv"
Lossless + dependency preserving
Lossless + not dependency preserving
```

Do NOT assume one implies the other.

---

# 23. Minimal / Canonical Cover ⭐⭐⭐⭐

Used when simplifying a set of FDs.

Typical steps:

### Step 1

Make RHS single attribute.

```text id="4y7z2a"
A → BC
```

becomes:

```text id="s5d1k9"
A → B
A → C
```

### Step 2

Remove extraneous attributes from LHS.

### Step 3

Remove redundant FDs.

---

# 24. Extraneous Attribute

Example:

```text id="1y7m3c"
AB → C
```

If:

```text id="b8p5j0"
A → C
```

already follows from FDs, B may be extraneous.

GATE often asks:

> Is an attribute extraneous in an FD?

Use **closure** to test it.

---

# 25. 🔥 GATE Normalization Workflow

When given:

```text id="q5f7g1"
R(A,B,C,D...)
FDs
```

Do this:

### Step 1 — Find candidate keys

Calculate closures.

```text id="8v0p2c"
X+ = ?
```

### Step 2 — Mark prime attributes

Attributes appearing in candidate keys.

### Step 3 — Check 2NF

Look for:

```text id="9g1q4v"
partial dependency
```

### Step 4 — Check 3NF

For each FD:

```text id="2x7k0m"
X → A
```

check:

```text id="0r5c8q"
X is superkey?
OR
A is prime?
```

### Step 5 — Check BCNF

Check:

```text id="9m4v6s"
X is superkey?
```

for **every** non-trivial FD.

---

# 🧠 GATE PYQ Patterns

GATE repeatedly tests normalization through **FD closure, candidate-key determination, normal-form identification, decomposition, and lossless/dependency-preserving properties**.

### Pattern 1 — Candidate key

Given:

```text id="4q6z9p"
R(A,B,C,D)
A → B
B → C
C → D
```

Find candidate key.

```text id="2s7d5m"
A+ = ABCD
```

Therefore:

```text id="h8m3q1"
A = candidate key
```

---

### Pattern 2 — Highest normal form

Given FDs and candidate keys, determine whether relation is:

```text id="8y1q4e"
1NF
2NF
3NF
BCNF
```

**Most important trick:**

For 3NF:

```text id="7w3j5p"
X superkey OR RHS prime
```

For BCNF:

```text id="v2m8c4"
X superkey
```

---

### Pattern 3 — Lossless decomposition

Given:

```text id="a9k3p7"
R → R1, R2
```

find:

```text id="e7x1m4"
R1 ∩ R2
```

and check whether it determines R1 or R2.

---

### Pattern 4 — Dependency preservation

Given several decomposed relations, determine whether each original FD can be derived using only the projected dependencies.

---

### Pattern 5 — 3NF vs BCNF

This is a favorite conceptual trap:

```text id="3u8h2s"
R ∈ 3NF
BUT
R ∉ BCNF
```

is absolutely possible.

---

# 🔥 GATE Traps

1. **Candidate key ≠ superkey**
2. Candidate key must be **minimal**.
3. Prime = belongs to **some candidate key**.
4. No composite candidate key → automatically 2NF.
5. 3NF uses **OR**:

   ```text
   superkey OR prime RHS
   ```
6. BCNF uses **AND-like requirement**:

   ```text
   determinant must be superkey
   ```
7. BCNF ⇒ 3NF, but 3NF ⇏ BCNF.
8. Lossless ≠ dependency preserving.
9. `X → Y` is trivial if `Y ⊆ X`.
10. Closure is the main tool for finding candidate keys.
11. For binary lossless decomposition:

```text
common attributes → determine R1 OR R2
```

12. Partial dependency matters only when a candidate key is **composite**.
13. A non-prime RHS can still satisfy 3NF if the LHS is a superkey.
14. Do not check only the given FDs blindly; implied FDs can matter for some normal-form reasoning.

---

# ⚡ 30-Second Revision

```text
FD
X → Y
same X → same Y

X+
→ all attributes determined by X

SUPERKEY
→ X+ = all attributes

CANDIDATE KEY
→ minimal superkey

PRIME
→ appears in a candidate key

1NF
→ atomic values

2NF
→ 1NF + no partial dependency of
   non-prime attribute on candidate key

3NF
→ X → A:
   X is superkey OR A is prime

BCNF
→ X → A:
   X MUST be superkey

BCNF ⇒ 3NF ⇒ 2NF ⇒ 1NF

LOSSLESS
→ decomposition reconstructs original
   without spurious tuples

DEPENDENCY PRESERVING
→ FDs can be checked without join

CLOSURE
→ most important tool
```

## 🎯 GATE Priority

| Topic                   | Priority |
| ----------------------- | -------: |
| Functional Dependencies |    ⭐⭐⭐⭐⭐ |
| Attribute Closure       |    ⭐⭐⭐⭐⭐ |
| Candidate Keys          |    ⭐⭐⭐⭐⭐ |
| 3NF                     |    ⭐⭐⭐⭐⭐ |
| BCNF                    |    ⭐⭐⭐⭐⭐ |
| Lossless Decomposition  |    ⭐⭐⭐⭐⭐ |
| Dependency Preservation |    ⭐⭐⭐⭐⭐ |
| 2NF                     |     ⭐⭐⭐⭐ |
| Minimal/Canonical Cover |     ⭐⭐⭐⭐ |
| 1NF                     |      ⭐⭐⭐ |

> **If you master only one DBMS block deeply for GATE, make it: `FD → Closure → Candidate Keys → 2NF → 3NF → BCNF → Decomposition`.**

**Next: `08-File-Organization.md`**
