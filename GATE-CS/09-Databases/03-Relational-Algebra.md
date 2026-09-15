````md id="relational-algebra"
# 03 — Relational Algebra

## 1. What is Relational Algebra? ⭐⭐⭐⭐⭐

**Relational Algebra (RA)** is a **procedural query language** for relations.

> It tells **how** to obtain the required result.

Input:

```text
Relation(s)
````

Output:

```text
Relation
```

🔥 **Relational Algebra is closed under its operations.**

```text
Relation → RA Operation → Relation
```

---

# 2. Basic Operators ⭐⭐⭐⭐⭐

The fundamental operators are:

```text
Selection     σ
Projection    π
Union         ∪
Set Difference −
Cartesian Product ×
Rename        ρ
```

Other important derived operators:

```text
Intersection  ∩
Join          ⋈
Division       ÷
```

---

# 3. Selection — σ ⭐⭐⭐⭐⭐

Selection chooses **rows/tuples** satisfying a condition.

```text
σ condition (R)
```

Example:

```text
Student
+-----+-------+-----+
| ID  | Name  | Age |
+-----+-------+-----+
| 1   | A     | 20  |
| 2   | B     | 25  |
| 3   | C     | 20  |
+-----+-------+-----+
```

Query:

```text
σ Age = 20 (Student)
```

Result:

```text
1 A 20
3 C 20
```

🔥 **Selection = Rows**

---

# 4. Projection — π ⭐⭐⭐⭐⭐

Projection chooses **columns/attributes**.

```text
π attributes (R)
```

Example:

```text
π Name, Age (Student)
```

Result:

```text
A 20
B 25
C 20
```

If duplicate tuples result, classical relational algebra removes duplicates because relations are sets.

Example:

```text
Student
A 20
B 20
C 25
```

```text
π Age(Student)
```

Result:

```text
20
25
```

🔥 **Projection = Columns + duplicate elimination**

---

# 5. Selection vs Projection ⭐⭐⭐⭐⭐

| Selection      | Projection         |
| -------------- | ------------------ |
| `σ`            | `π`                |
| Rows           | Columns            |
| Filters tuples | Chooses attributes |
| Condition      | Attribute list     |

Memory:

```text id="c7n2tu"
σ → Select rows
π → Pick columns
```

---

# 6. Union — ∪ ⭐⭐⭐⭐⭐

Combines tuples from two relations.

```text
R ∪ S
```

### Requirement: Union Compatibility

Relations must have:

1. Same number of attributes
2. Corresponding attributes have compatible domains

Example:

```text id="4e2s9s"
R(A,B)
S(A,B)
```

Then:

```text
R ∪ S
```

is valid.

🔥 Union removes duplicates.

---

# 7. Set Difference — − ⭐⭐⭐⭐⭐

```text
R − S
```

Means:

> Tuples present in R but **not** in S.

Example:

```text id="z17q7u"
R = {1,2,3}
S = {2,3,4}

R − S = {1}
```

🔥 Difference is **not commutative**.

```text
R − S ≠ S − R
```

---

# 8. Intersection — ∩ ⭐⭐⭐⭐

Returns common tuples.

```text
R ∩ S
```

Example:

```text id="w2g0uy"
R = {1,2,3}
S = {2,3,4}

R ∩ S = {2,3}
```

Intersection requires union compatibility.

---

# 9. Cartesian Product — × ⭐⭐⭐⭐⭐

Combines **every tuple of R with every tuple of S**.

```text
R × S
```

If:

```text
|R| = m
|S| = n
```

then:

```text
|R × S| = m × n
```

If:

```text
degree(R) = r
degree(S) = s
```

then:

```text
degree(R × S) = r + s
```

🔥 Extremely important numerical formula.

---

# 10. Example of Cartesian Product

```text
R
A
B

S
1
2
3
```

Then:

```text
R × S
```

gives:

```text
A 1
A 2
A 3
B 1
B 2
B 3
```

Total:

```text
2 × 3 = 6 tuples
```

---

# 11. Rename — ρ ⭐⭐⭐⭐

Rename a relation or attributes.

```text
ρ NewName(R)
```

Example:

```text
ρ Employee(E)
```

Useful when:

* Same relation appears multiple times
* Self-join
* Need attribute renaming

---

# 12. Join — ⋈ ⭐⭐⭐⭐⭐

Join combines related tuples from two relations.

Conceptually:

```text
Join = Cartesian Product + Selection
```

For a theta join:

```text
R ⋈condition S
=
σcondition(R × S)
```

🔥 Very important GATE relation.

---

# 13. Theta Join

Join using any comparison:

```text
=
<
>
≤
≥
≠
```

Example:

```text
R ⋈ R.A > S.B S
```

---

# 14. Equi Join

Theta join where the condition uses equality.

```text
R.A = S.B
```

Example:

```text id="l9j7x4"
Employee ⋈ Employee.DeptID = Department.DeptID Department
```

---

# 15. Natural Join ⭐⭐⭐⭐⭐

Natural join automatically joins relations using **same-named common attributes**.

```text
R ⋈ S
```

Common attributes appear **only once** in the result.

Example:

```text id="m9q6zq"
Employee
+-----+------+--------+
| EID | Name | DeptID |
+-----+------+--------+

Department
+--------+----------+
| DeptID | DeptName |
+--------+----------+
```

Natural join:

```text
Employee ⋈ Department
```

Result:

```text
EID | Name | DeptID | DeptName
```

🔥 `DeptID` appears once.

---

# 16. Natural Join Trap ⭐⭐⭐⭐⭐

Natural join is based on:

> **Same attribute names**, not merely same values.

If:

```text
R(A,B)
S(B,C)
```

then:

```text
R ⋈ S
```

joins using `B`.

If there are multiple common attribute names:

```text
R(A,B,C)
S(B,C,D)
```

natural join uses:

```text
B AND C
```

🔥 It is **not** just one common column.

---

# 17. Outer Joins ⭐⭐⭐⭐

Outer joins preserve tuples that don't find a match.

### Left Outer Join

```text
R ⟕ S
```

Keeps all tuples of **R**.

### Right Outer Join

```text
R ⟖ S
```

Keeps all tuples of **S**.

### Full Outer Join

```text
R ⟗ S
```

Keeps unmatched tuples from both sides.

Missing attributes are represented by `NULL` in SQL-style representations.

---

# 18. Division — ÷ ⭐⭐⭐⭐⭐

Division is one of the most important **tricky GATE operators**.

Used for queries involving:

> **"For all"**

Example:

```text
StudentCourse(Student, Course)
Required(Course)
```

Question:

> Find students who have completed **ALL required courses**.

Conceptually:

```text
StudentCourse ÷ Required
```

Result:

```text
Students satisfying all required courses
```

🔥 **Division → ALL**

---

# 19. Division Example

Suppose:

```text
Enroll
+---------+--------+
| Student | Course |
+---------+--------+
| A       | C1     |
| A       | C2     |
| B       | C1     |
| C       | C1     |
| C       | C2     |
+---------+--------+
```

Required:

```text
C1
C2
```

Then:

```text
Enroll ÷ Required
```

Result:

```text
A
C
```

because A and C have **both** courses.

---

# 20. Division Trick ⭐⭐⭐⭐⭐

Whenever question says:

```text
ALL
EVERY
EACH
FOR EVERY
```

Think:

```text
÷
```

Example:

> Students who completed **every** course.

→ Division.

---

# 21. Selection Conditions ⭐⭐⭐⭐

Selection can use:

```text
AND
OR
NOT
```

Example:

```text
σ Age > 20 AND Dept = 'CSE'(Student)
```

---

# 22. Cascading Selections ⭐⭐⭐⭐

```text
σ A>10 AND B<20(R)
```

can be written as:

```text
σ A>10(σ B<20(R))
```

For conjunctive conditions, selections can often be pushed down.

🔥 This becomes important for **query optimization**.

---

# 23. Selection Commutativity ⭐⭐⭐⭐⭐

For appropriate predicates:

```text
σc1(σc2(R))
=
σc2(σc1(R))
```

So:

```text
σ Age>20(σ Dept='CSE'(R))
```

is equivalent to:

```text
σ Dept='CSE'(σ Age>20(R))
```

---

# 24. Projection Cascading ⭐⭐⭐⭐

```text
πA(πA,B(R))
```

can be simplified to:

```text
πA(R)
```

But:

🔥 You cannot arbitrarily remove attributes needed by a later operation.

---

# 25. Selection + Projection

Example:

> Find names of students whose age > 20.

```text
π Name (
    σ Age > 20(Student)
)
```

Correct order:

```text
Student
 ↓
Selection
 ↓
Projection
 ↓
Answer
```

Can also be written with equivalent transformations in some cases, but the condition attributes must remain available.

---

# 26. Relational Algebra is Procedural ⭐⭐⭐⭐⭐

### Relational Algebra

> **How** to get the result.

Example:

```text
π Name(σ Age>20(Student))
```

### Relational Calculus

> **What** result is required.

🔥

```text
Algebra  → Procedural
Calculus → Non-procedural / Declarative
```

---

# 27. Relational Algebra vs SQL ⭐⭐⭐⭐⭐

| Relational Algebra                                    | SQL                                           |
| ----------------------------------------------------- | --------------------------------------------- |
| Formal/procedural algebra                             | Practical query language                      |
| Set-oriented                                          | Often bag-oriented by default                 |
| Operators like σ, π, ⋈                                | SELECT, FROM, WHERE, JOIN                     |
| Duplicate elimination inherent in classical relations | Duplicates generally retained unless DISTINCT |

Example:

```text
RA:
π Name(Student)

SQL:
SELECT DISTINCT Name
FROM Student;
```

---

# 28. GATE Pattern — Cardinality of Operations ⭐⭐⭐⭐⭐

Suppose:

```text
|R| = 10
|S| = 20
```

Then:

```text
|R × S| = 10 × 20 = 200
```

For joins:

```text
|R ⋈ S|
```

cannot generally be determined from only `|R|` and `|S|`.

🔥 Join cardinality depends on **data and join condition**.

---

# 29. GATE Pattern — Selection Cardinality

If:

```text
R = 100 tuples
```

then:

```text
|σcondition(R)| ≤ 100
```

Selection cannot increase the number of tuples.

Possible result:

```text
0 ≤ |σ(R)| ≤ |R|
```

---

# 30. GATE Pattern — Projection Cardinality ⭐⭐⭐⭐⭐

Projection can remove duplicates.

Therefore:

```text
|πA(R)| ≤ |R|
```

It cannot increase cardinality in classical relational algebra.

Example:

```text id="rj0w7h"
R:
A
1
1
2
3
```

Then:

```text
πA(R)
```

gives:

```text
1
2
3
```

---

# 31. GATE Pattern — Cartesian Product

Given:

```text
R(A,B)
S(C,D,E)
```

and:

```text
|R| = 5
|S| = 10
```

Then:

```text
Degree(R × S) = 2 + 3 = 5
Cardinality(R × S) = 5 × 10 = 50
```

🔥 Frequently tested numerical pattern.

---

# 32. GATE Pattern — Union

Given:

```text
|R| = 50
|S| = 40
```

Then:

```text
|R ∪ S| ≤ 90
```

More precisely:

```text
max(50,40) ≤ |R∪S| ≤ 90
```

So:

```text
40 ≤ |R∪S| ≤ 90
```

depending on overlap.

---

# 33. GATE Pattern — Difference

For:

```text
|R| = 50
|S| = 20
```

we know:

```text
0 ≤ |R-S| ≤ 50
```

If `S ⊆ R`, then:

```text
|R-S| = 30
```

But without more information, exact cardinality cannot be determined.

---

# 34. GATE PYQ Pattern — Query Translation ⭐⭐⭐⭐⭐

Typical question gives:

```text
Student(SID, Name, Dept)
Course(CID, Title)
Enroll(SID, CID)
```

Question:

> Find names of CSE students enrolled in DBMS.

Think:

```text
Student
   ↓
σ Dept='CSE'
   ↓
Join Enroll
   ↓
Join Course
   ↓
σ Title='DBMS'
   ↓
π Name
```

Possible expression:

```text
π Name
(
  σ Dept='CSE' AND Title='DBMS'
  (
    Student ⋈ Enroll ⋈ Course
  )
)
```

🔥 First identify the required tables, then relationships, then filters, finally required columns.

---

# 35. GATE PYQ Pattern — "ALL" Queries ⭐⭐⭐⭐⭐

Question:

> Find suppliers who supply **all** parts.

Look for:

```text
Division
```

Pattern:

```text
Supplies(Supplier, Part)
RequiredParts(Part)
```

Then:

```text
Supplies ÷ RequiredParts
```

---

# 36. GATE PYQ Pattern — Equivalent Expressions ⭐⭐⭐⭐⭐

GATE may give multiple relational algebra expressions and ask:

> Which expressions are equivalent?

Know these:

### Selection cascade

```text
σc1 AND c2(R)
=
σc1(σc2(R))
```

### Selection commutativity

```text
σc1(σc2(R))
=
σc2(σc1(R))
```

### Cartesian + selection

```text
σcondition(R × S)
=
R ⋈condition S
```

🔥 These are high-value equivalences.

---

# 37. GATE PYQ Pattern — Natural Join

Given:

```text
R(A,B,C)
S(B,C,D)
```

Natural join condition:

```text
R.B = S.B
AND
R.C = S.C
```

Result attributes:

```text
A, B, C, D
```

not:

```text
A,B,C,B,C,D
```

🔥 Common mistake: forgetting duplicate common attributes are merged.

---

# 38. 🔥 Operator Cheat Sheet

| Symbol | Operation    | Think      |
| ------ | ------------ | ---------- |
| `σ`    | Selection    | Rows       |
| `π`    | Projection   | Columns    |
| `∪`    | Union        | Combine    |
| `−`    | Difference   | Remove     |
| `×`    | Cartesian    | Every pair |
| `ρ`    | Rename       | Rename     |
| `⋈`    | Join         | Match      |
| `∩`    | Intersection | Common     |
| `÷`    | Division     | ALL        |

---

# 🔥 GATE Traps

* ❌ Selection does not select columns → **rows**.
* ❌ Projection does not select rows → **columns**.
* ❌ Projection can eliminate duplicates.
* ❌ Union requires compatible relations.
* ❌ Difference is not commutative.
* ❌ Cartesian product multiplies cardinalities.
* ❌ Join cardinality cannot generally be calculated as `|R| × |S|`.
* ❌ Natural join uses **same-named attributes**.
* ❌ Natural join removes duplicate copies of common attributes.
* ❌ Division usually represents **ALL/EVERY** conditions.
* ❌ Classical relational algebra is set-based.
* ❌ SQL does not automatically behave exactly like classical relational algebra because duplicates are normally retained.
* ❌ `R ⋈ S` is not always the same as `R × S`.
* ❌ Degree of `R × S` = sum of degrees.
* ❌ Cardinality of `R × S` = product of cardinalities.

---

# ⚡ 30-Second Revision

```text
σ → Rows
π → Columns

∪ → Combine
− → R but not S
∩ → Common

× → Every possible pair

⋈ → Matching tuples
ρ → Rename

÷ → ALL / EVERY
```

### Cardinality

```text
Selection:
|σ(R)| ≤ |R|

Projection:
|π(R)| ≤ |R|

Cartesian:
|R×S| = |R| × |S|

Union:
max(|R|,|S|) ≤ |R∪S| ≤ |R|+|S|
```

### Key Equivalences

```text
σc1 AND c2(R)
=
σc1(σc2(R))

σc1(σc2(R))
=
σc2(σc1(R))

σcondition(R×S)
=
R ⋈condition S
```

### Mental Trick

```text
FILTER rows    → σ
CHOOSE columns → π
COMBINE        → ∪
REMOVE         → −
EVERY PAIR     → ×
MATCH          → ⋈
ALL            → ÷
```

---

# 🎯 GATE Priority

| Topic                  | Priority |
| ---------------------- | -------: |
| Selection / Projection |    ⭐⭐⭐⭐⭐ |
| Join                   |    ⭐⭐⭐⭐⭐ |
| Division               |    ⭐⭐⭐⭐⭐ |
| Cartesian Product      |    ⭐⭐⭐⭐⭐ |
| Query Translation      |    ⭐⭐⭐⭐⭐ |
| Equivalent Expressions |    ⭐⭐⭐⭐⭐ |
| Cardinality Questions  |    ⭐⭐⭐⭐⭐ |
| Set Operations         |     ⭐⭐⭐⭐ |
| Rename                 |      ⭐⭐⭐ |
| Outer Join             |      ⭐⭐⭐ |

## Overall GATE Priority: ⭐⭐⭐⭐⭐

> **Relational Algebra is one of the highest-scoring DBMS areas in GATE.** Master **σ, π, joins, division, cardinality, equivalence rules, and query translation** first.

**Next: `04-Tuple-Calculus.md`**

```
```
