````md id="relational-model"
# 02 — Relational Model

## 1. What is the Relational Model? ⭐⭐⭐⭐⭐

The **Relational Model** represents data using **relations (tables)**.

```text
Student
+--------+-------+-----+
| RollNo | Name  | Age |
+--------+-------+-----+
| 101    | Yash  | 22  |
| 102    | Rahul | 21  |
+--------+-------+-----+
````

> **Relation = Table, Tuple = Row, Attribute = Column**

---

# 2. Basic Terminology ⭐⭐⭐⭐⭐

| Relational Term   | Table Term             |
| ----------------- | ---------------------- |
| Relation          | Table                  |
| Tuple             | Row                    |
| Attribute         | Column                 |
| Domain            | Allowed values         |
| Relation Schema   | Table structure        |
| Relation Instance | Current table contents |
| Degree            | Number of attributes   |
| Cardinality       | Number of tuples       |

### Example

```text
Student(RollNo, Name, Age)
```

If the table contains 100 students and 3 columns:

```text
Degree     = 3
Cardinality = 100
```

🔥 **Degree = columns**
🔥 **Cardinality = rows**

---

# 3. Relation Schema vs Relation Instance ⭐⭐⭐⭐⭐

### Schema

Defines the structure.

```text
Student(RollNo, Name, Age)
```

### Instance

Actual data at a particular moment.

```text
101, Yash, 22
102, Rahul, 21
```

```text
Schema   → Structure
Instance → Current data
```

🔥 Schema changes rarely; instance changes frequently.

---

# 4. Domain ⭐⭐⭐⭐

A **domain** is the set of valid values for an attribute.

Example:

```text
Age → {0, 1, 2, ..., 150}
```

```text
Gender → {M, F, ...}
```

More precisely:

> Domain specifies the allowable values/constraints for an attribute.

---

# 5. Properties of a Relation ⭐⭐⭐⭐⭐

In the classical relational model:

### 1. Values are atomic

Each cell contains a single atomic value.

```text
❌ Phone = {9876, 8765}
```

Instead:

```text
StudentPhone
+--------+----------+
| SID    | Phone    |
+--------+----------+
```

This connects directly to **1NF**.

---

### 2. No duplicate tuples

A relation is a **set of tuples**, so duplicate tuples are not allowed in the classical relational model.

🔥 SQL is different because SQL tables can contain duplicate rows unless constrained otherwise.

---

### 3. Order of rows doesn't matter

```text
A
B
C
```

and

```text
C
A
B
```

represent the same relation.

---

### 4. Order of attributes doesn't determine meaning

Attributes are identified by their names.

---

# 6. Null Values ⭐⭐⭐⭐⭐

`NULL` means **missing/unknown/not applicable**, depending on context.

It is **not**:

```text
0
```

and not:

```text
''
```

and not:

```text
FALSE
```

🔥 SQL uses **three-valued logic** because of NULL:

```text
TRUE
FALSE
UNKNOWN
```

Example:

```sql
WHERE Age = 20
```

If `Age = NULL`, the comparison is **UNKNOWN**, not TRUE.

---

# 7. Keys ⭐⭐⭐⭐⭐

Keys are extremely important for GATE.

---

## Super Key

A set of attributes that **uniquely identifies** each tuple.

Example:

```text
Student(RollNo, Email, Name)
```

Possible super keys:

```text
{RollNo}
{Email}
{RollNo, Name}
{RollNo, Email}
```

🔥 A super key can contain **extra attributes**.

---

# 8. Candidate Key ⭐⭐⭐⭐⭐

A **minimal super key**.

Example:

```text
{RollNo}
{Email}
```

Both uniquely identify students.

Therefore both are candidate keys.

```text
Candidate Key = Minimal Super Key
```

🔥 Minimal means **no attribute can be removed while retaining uniqueness**.

---

# 9. Primary Key ⭐⭐⭐⭐⭐

One candidate key selected as the primary key.

Example:

```text
Student(
    RollNo,   ← Primary Key
    Email,
    Name
)
```

Properties:

* Unique
* No NULL in standard relational/SQL primary-key semantics

---

# 10. Alternate Key

Candidate keys **not selected** as the primary key.

Example:

```text
Candidate Keys:
{RollNo}
{Email}
```

Choose:

```text
Primary Key = RollNo
```

Then:

```text
Alternate Key = Email
```

---

# 11. Foreign Key ⭐⭐⭐⭐⭐

A foreign key is an attribute/set of attributes in one relation that references a candidate/primary key of another relation under referential-integrity rules.

Example:

```text
Department
+-----+------+
| DID | Name |
+-----+------+

Employee
+-----+------+-----+
| EID | Name | DID |
+-----+------+-----+
              ↑
           Foreign Key
```

```text
Employee.DID
      ↓
Department.DID
```

---

# 12. Composite Key ⭐⭐⭐⭐

A key consisting of multiple attributes.

Example:

```text
Enroll(SID, CID, Grade)
```

A student can enroll in many courses and a course can have many students.

```text
Primary Key = (SID, CID)
```

This is a **composite key**.

---

# 13. Prime vs Non-Prime Attribute ⭐⭐⭐⭐⭐

### Prime Attribute

An attribute that belongs to **at least one candidate key**.

### Non-Prime Attribute

An attribute that belongs to **no candidate key**.

Example:

```text
R(A, B, C, D)
Candidate Keys:
AB
AC
```

Prime attributes:

```text
A, B, C
```

Non-prime:

```text
D
```

🔥 Extremely important for **functional dependencies and normalization**.

---

# 14. Super Key vs Candidate Key ⭐⭐⭐⭐⭐

```text
Super Key
   ↓
May contain extra attributes

Candidate Key
   ↓
Minimal Super Key
```

Example:

```text
Candidate key = {RollNo}

{RollNo, Name}
```

is a super key but **not** a candidate key.

---

# 15. Foreign Key Traps ⭐⭐⭐⭐⭐

A foreign key:

* Can reference another relation.
* Is used for referential integrity.
* Can contain duplicate values.
* May contain NULL depending on schema/constraints.
* Does not have to be unique.

Example:

```text
Department
D1
D2

Employee
E1 → D1
E2 → D1
E3 → D2
```

Multiple employees can reference the same department.

🔥 **Foreign key ≠ candidate key.**

---

# 16. Integrity Constraints ⭐⭐⭐⭐⭐

Main constraints:

```text
Domain Constraint
Key Constraint
Entity Integrity
Referential Integrity
```

### Domain Constraint

Values must belong to the allowed domain.

### Key Constraint

No two tuples can have the same candidate-key value.

### Entity Integrity

Primary key cannot be NULL.

### Referential Integrity

A foreign-key value must correspond to an appropriate referenced key value, unless NULL is permitted.

---

# 17. Entity Integrity vs Referential Integrity

```text
Entity Integrity
→ Primary Key
→ Cannot be NULL

Referential Integrity
→ Foreign Key
→ Must reference valid key value
```

🔥 Easy GATE question.

---

# 18. Relational Schema

Written as:

```text
Student(RollNo, Name, Age, DeptID)
```

Where:

```text
Student → Relation name
RollNo  → Attribute
Name    → Attribute
Age     → Attribute
DeptID  → Attribute
```

A relation schema can also be formally represented as:

```text
R(A1, A2, ..., An)
```

---

# 19. Degree and Cardinality ⭐⭐⭐⭐⭐

Suppose:

```text
R(A, B, C, D)
```

contains 50 tuples.

Then:

```text
Degree      = 4
Cardinality = 50
```

🔥 Memory:

> **Degree = dimensions/columns**
> **Cardinality = count of tuples/rows**

---

# 20. Relational Model vs ER Model

| ER Model         | Relational Model                                  |
| ---------------- | ------------------------------------------------- |
| Entity           | Relation/table                                    |
| Attribute        | Attribute/column                                  |
| Entity instance  | Tuple/row                                         |
| Relationship     | Foreign key / separate relation depending mapping |
| Conceptual model | Logical data model                                |

---

# 21. Relational Model vs SQL ⭐⭐⭐⭐

Do not assume they are identical.

### Classical relational model

```text
Relation = set of tuples
```

Therefore:

```text
No duplicate tuples
```

### SQL

SQL commonly uses **bags/multisets by default** for query results.

Therefore duplicates can occur unless `DISTINCT` or constraints remove/prevent them.

```sql
SELECT DISTINCT Name
FROM Student;
```

🔥 **Relational algebra is set-based; SQL is often bag-based by default.**

---

# 22. GATE PYQ Pattern 1 — Keys ⭐⭐⭐⭐⭐

Typical question:

> Given a relation and functional dependencies, find the number of candidate keys.

Example:

```text
R(A,B,C,D)

A → B
B → C
C → D
```

Find candidate key.

### Trick

Start with attributes that **never appear on RHS**.

RHS:

```text
B, C, D
```

Not on RHS:

```text
A
```

Therefore `A` must be present in every candidate key.

Closure:

```text
A+
= {A}
→ B
→ C
→ D
= {A,B,C,D}
```

Therefore:

```text
Candidate Key = A
```

🔥 This technique becomes extremely important in the **Functional Dependency / Normalization** section.

---

# 23. GATE PYQ Pattern 2 — Candidate Key Count ⭐⭐⭐⭐⭐

Typical pattern:

```text
R(A,B,C,D,E)

AB → C
C → D
D → E
```

Find candidate key.

Start:

```text
(AB)+
```

```text
AB
 ↓
C
 ↓
D
 ↓
E
```

Therefore:

```text
(AB)+ = ABCDE
```

So:

```text
AB = Candidate Key
```

provided neither `A` nor `B` alone determines all attributes.

---

# 24. GATE PYQ Pattern 3 — Prime Attributes ⭐⭐⭐⭐⭐

Given:

```text
R(A,B,C,D)
Candidate Keys:
AB
CD
```

Then:

```text
Prime:
A, B, C, D

Non-prime:
None
```

If:

```text
Candidate Keys:
AB
```

then:

```text
Prime:
A, B

Non-prime:
C, D
```

🔥 Prime depends on **candidate keys**, not just the chosen primary key.

---

# 25. GATE PYQ Pattern 4 — Super Key Count ⭐⭐⭐⭐⭐

Suppose a relation has:

```text
n attributes
```

and there is a **single candidate key containing k attributes**, with no other candidate keys.

Every superset of that candidate key is a super key.

Number of superkeys:

```text
2^(n-k)
```

### Example

```text
R(A,B,C,D,E)
Candidate key = AB
```

Superkeys contain:

```text
AB
```

Remaining attributes:

```text
C,D,E
```

Each may be included or excluded:

```text
2^3 = 8 superkeys
```

🔥 This formula applies only when the candidate-key structure is appropriately known; with multiple candidate keys, simply summing can double-count.

---

# 26. GATE PYQ Pattern 5 — Foreign Key

Typical question:

> Which constraint ensures that a foreign-key value corresponds to a referenced key?

Answer:

**Referential integrity.**

```text
Employee.DeptID
       ↓
Department.DeptID
```

---

# 27. GATE PYQ Pattern 6 — Degree/Cardinality

Given:

```text
R(A,B,C,D,E)
```

with 100 tuples:

```text
Degree = 5
Cardinality = 100
```

🔥 Very easy marks.

---

# 28. 🔥 GATE Tricks

### Trick 1

```text
Degree → Number of attributes
```

### Trick 2

```text
Cardinality → Number of tuples
```

### Trick 3

```text
Candidate Key
= Minimal Super Key
```

### Trick 4

```text
Every Candidate Key → Super Key
But
Every Super Key ❌ Candidate Key
```

### Trick 5

```text
Prime attribute
= Part of ANY candidate key
```

### Trick 6

```text
Primary Key
= One selected candidate key
```

### Trick 7

```text
Other candidate keys
= Alternate keys
```

### Trick 8

```text
Primary Key → Entity Integrity
Foreign Key → Referential Integrity
```

### Trick 9

```text
Foreign Key
≠ necessarily unique
≠ necessarily primary key
```

### Trick 10

```text
Classical Relation
→ Set
→ No duplicate tuples
```

---

# 🔥 GATE Traps

* ❌ Degree is not the number of rows.
* ❌ Cardinality is not the number of columns.
* ❌ Every super key is not a candidate key.
* ❌ Primary key is not the only candidate key.
* ❌ Prime attribute is not necessarily part of the primary key.
* ❌ Foreign key does not have to be unique.
* ❌ Foreign key may be NULL if the schema permits it.
* ❌ Candidate key must be minimal.
* ❌ SQL tables/results can contain duplicates by default.
* ❌ NULL is not equal to 0 or an empty string.
* ❌ `NULL = NULL` is not TRUE in SQL's three-valued logic.

---

# ⚡ 30-Second Revision

```text
RELATIONAL MODEL
        ↓
     Relation
        ↓
      Table
   ┌────┴────┐
Tuple      Attribute
 Row         Column
```

### Key hierarchy

```text
Super Key
    ↓ minimal
Candidate Key
    ↓ selected
Primary Key

Other candidate keys
       ↓
Alternate Keys
```

### Constraints

```text
Domain
  ↓
Valid values

Primary Key
  ↓
Entity Integrity

Foreign Key
  ↓
Referential Integrity
```

### Must Remember

```text
Degree      → Columns
Cardinality → Rows

Candidate Key = Minimal Super Key

Prime Attribute
= Appears in at least one Candidate Key

Foreign Key
= References another relation's candidate/primary key

Classical Relation
= Set of tuples
```

---

# 🎯 GATE Priority

| Topic                             | Priority |
| --------------------------------- | -------: |
| Candidate Keys / Super Keys       |    ⭐⭐⭐⭐⭐ |
| Functional Dependencies + Closure |    ⭐⭐⭐⭐⭐ |
| Prime/Non-prime Attributes        |    ⭐⭐⭐⭐⭐ |
| Integrity Constraints             |    ⭐⭐⭐⭐⭐ |
| Relational Algebra connection     |     ⭐⭐⭐⭐ |
| Degree/Cardinality                |     ⭐⭐⭐⭐ |
| NULL / 3-valued logic             |     ⭐⭐⭐⭐ |
| ER → Relational Mapping           |     ⭐⭐⭐⭐ |

### Overall

**GATE Priority: ⭐⭐⭐⭐⭐**

> For GATE, the most important part of the Relational Model is **keys + functional dependencies + closure + integrity constraints**. These concepts directly feed into **Relational Algebra and Normalization**, so master them before moving ahead.

**Next: `03-Relational-Algebra.md`**

```
```
