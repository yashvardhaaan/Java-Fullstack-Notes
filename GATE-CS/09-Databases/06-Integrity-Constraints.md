# 06 — Integrity Constraints

> **GATE Priority: ⭐⭐⭐⭐ HIGH**

Integrity constraints ensure that **invalid or inconsistent data cannot enter the database**.

> **First principle:** Constraints define the rules that every valid database state must satisfy.

---

# 1. Types of Integrity Constraints

The most important for GATE:

1. **Domain constraint**
2. **Key constraint**
3. **Entity integrity**
4. **Referential integrity**

SQL also provides constraints such as:

```text
PRIMARY KEY
FOREIGN KEY
UNIQUE
NOT NULL
CHECK
DEFAULT
```

---

# 2. Domain Constraint

An attribute must contain values from its allowed **domain**.

Example:

```sql
CREATE TABLE Student (
    age INT CHECK(age >= 0)
);
```

If:

```text
age = -5
```

→ violates the constraint.

### Examples

```text
Age       → integer
Gender    → allowed set of values
Salary    → positive number
Name      → character string
```

🔥 **GATE Trick**

> **Domain = what values are allowed in an attribute.**

---

# 3. Key Constraint

A key must uniquely identify tuples.

Suppose:

```text
Student(RollNo, Name, Branch)
```

If `RollNo` is a candidate key:

```text
RollNo
101
102
103
```

No two tuples can have the same `RollNo`.

---

# 4. Super Key

A set of attributes that uniquely identifies a tuple.

Example:

```text
Student(Roll, Name, Branch)
```

If `Roll` uniquely identifies students:

```text
{Roll}
{Roll, Name}
{Roll, Branch}
{Roll, Name, Branch}
```

are all superkeys.

---

# 5. Candidate Key

A **minimal superkey**.

If:

```text
{Roll, Name}
```

uniquely identifies tuples but `Roll` alone is sufficient, then:

```text
{Roll, Name}
```

is NOT a candidate key.

🔥 **GATE definition**

> Candidate key = **minimal** superkey, not necessarily smallest by number of attributes.

---

# 6. Primary Key

One candidate key chosen as the main identifier.

```sql
CREATE TABLE Student (
    roll INT PRIMARY KEY
);
```

Properties:

* Unique
* Cannot contain NULL
* One primary-key constraint per table

---

# 7. UNIQUE

```sql
CREATE TABLE Student (
    email VARCHAR(50) UNIQUE
);
```

Ensures values are unique.

### Primary Key vs UNIQUE

| Primary Key                | UNIQUE                               |
| -------------------------- | ------------------------------------ |
| Uniquely identifies tuples | Enforces uniqueness                  |
| Cannot be NULL             | NULL handling differs by DBMS        |
| One primary-key constraint | Multiple UNIQUE constraints possible |

⚠️ For GATE, do not assume `UNIQUE` and `PRIMARY KEY` are identical.

---

# 8. Entity Integrity Constraint ⭐⭐⭐⭐⭐

**Primary key cannot be NULL.**

Why?

If primary key were NULL:

```text
Which tuple does this identify?
```

There would be no valid identity.

Therefore:

```text
PRIMARY KEY → NOT NULL + UNIQUE
```

🔥 **GATE Shortcut**

> **Entity integrity = PK cannot be NULL.**

---

# 9. Referential Integrity ⭐⭐⭐⭐⭐

Deals with **foreign keys**.

Suppose:

```text
Department
-----------
dept_id  ← Primary Key
1
2
3
```

and:

```text
Employee
-----------
emp_id
dept_id  ← Foreign Key
```

If an employee has:

```text
dept_id = 5
```

but Department 5 does not exist:

→ **referential integrity violation**.

---

# 10. Foreign Key

A foreign key references a candidate/primary key of another relation.

```sql
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    dept_id INT,
    FOREIGN KEY(dept_id)
        REFERENCES Department(dept_id)
);
```

Conceptually:

```text
Employee.dept_id
       ↓
Department.dept_id
```

---

# 11. Can Foreign Key Be NULL?

**Yes**, unless `NOT NULL` is also specified.

Example:

```sql
dept_id INT,
FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
```

`dept_id = NULL` can be allowed.

Why?

NULL means:

> There is no known referenced value.

🔥 **GATE Trap**

> **Primary key → NULL not allowed.**
> **Foreign key → NULL may be allowed.**

---

# 12. Foreign Key Rule

For every **non-NULL** foreign-key value:

```text
FK value must exist in referenced key
```

Example:

```text
Department.dept_id = {10,20,30}

Employee.dept_id = {10,20,NULL}
```

✅ valid

But:

```text
Employee.dept_id = {10,20,40}
```

❌ invalid because `40` does not exist.

---

# 13. Referential Actions

When a referenced tuple is deleted/updated, SQL can specify what happens.

```sql
FOREIGN KEY(dept_id)
REFERENCES Department(dept_id)
ON DELETE CASCADE
```

Important actions:

```text
CASCADE
SET NULL
SET DEFAULT
RESTRICT / NO ACTION
```

---

## CASCADE

If parent is deleted:

```text
Parent deleted
      ↓
Related child tuples deleted
```

Example:

```text
Delete Department 10
       ↓
Delete Employees belonging to 10
```

---

## SET NULL

```text
Parent deleted
      ↓
Child FK becomes NULL
```

Requires the FK column to permit NULL.

---

## RESTRICT / NO ACTION

Prevents the operation if dependent tuples exist.

---

# 14. CHECK Constraint

Restricts values according to a condition.

```sql
CREATE TABLE Employee (
    salary INT CHECK(salary > 0)
);
```

Invalid:

```text
salary = -100
```

---

# 15. NOT NULL

```sql
name VARCHAR(30) NOT NULL
```

Prevents NULL.

🔥 Difference:

```text
PRIMARY KEY → UNIQUE + NOT NULL
NOT NULL     → only prevents NULL
```

`NOT NULL` does **not** imply uniqueness.

---

# 16. DEFAULT

```sql
CREATE TABLE Employee (
    country VARCHAR(20) DEFAULT 'India'
);
```

If no value is supplied, the default may be used.

---

# 17. Composite Key

A key can contain multiple attributes.

Example:

```text
Enrollment(StudentID, CourseID)
```

Suppose:

```text
StudentID CourseID
1         DBMS
1         CN
2         DBMS
```

`StudentID` alone isn't unique.

`CourseID` alone isn't unique.

But:

```text
(StudentID, CourseID)
```

can uniquely identify an enrollment.

🔥 **Trap**

> Composite key does NOT mean every individual attribute is unique.

---

# 18. Entity vs Referential Integrity

| Constraint            | Main idea                            |
| --------------------- | ------------------------------------ |
| Entity integrity      | PK cannot be NULL                    |
| Referential integrity | FK must reference valid key          |
| Domain integrity      | Values must belong to allowed domain |
| Key constraint        | Key values uniquely identify tuples  |

### Memory trick

```text
DOMAIN → valid values
KEY → unique identity
ENTITY → PK cannot be NULL
REFERENTIAL → FK must refer correctly
```

---

# 19. Constraint Checking Example

Suppose:

```text
Department(dept_id)
10
20
```

Employee:

```text
emp_id | dept_id
1      | 10
2      | 20
3      | 30
4      | NULL
```

Assume `dept_id` is FK.

Then:

```text
1 → valid
2 → valid
3 → INVALID
4 → valid
```

because:

```text
30 doesn't exist
NULL can be allowed
```

---

# 20. Deletion Problem

Suppose:

```text
Department
10

Employee
1 → 10
2 → 10
```

Now:

```sql
DELETE FROM Department
WHERE dept_id = 10;
```

What happens depends on the referential action.

### CASCADE

```text
Department 10 deleted
Employee 1 deleted
Employee 2 deleted
```

### SET NULL

```text
Department 10 deleted
Employee 1.dept_id → NULL
Employee 2.dept_id → NULL
```

### RESTRICT

```text
DELETE rejected
```

---

# 🔥 GATE Traps

### Trap 1

```text
Candidate key = any unique attribute
```

❌ Wrong.

Candidate key = **minimal superkey**.

---

### Trap 2

```text
Foreign key must always be unique
```

❌ Wrong.

Many tuples can have the same FK.

```text
Emp1 → Dept10
Emp2 → Dept10
Emp3 → Dept10
```

Perfectly valid.

---

### Trap 3

```text
Foreign key cannot be NULL
```

❌ Not necessarily.

It can be NULL unless prohibited.

---

### Trap 4

```text
Primary key can contain NULL
```

❌ Never.

---

### Trap 5

```text
Composite key means individual attributes are unique
```

❌ Wrong.

Only the **combination** needs to be unique.

---

### Trap 6

```text
FK value must always match a parent value
```

⚠️ More precisely:

> Every **non-NULL** FK value must match a referenced key value.

---

### Trap 7

```text
UNIQUE = PRIMARY KEY
```

❌ Not exactly.

Primary key also has entity-integrity semantics.

---

# 🧠 GATE PYQ Patterns

GATE frequently asks integrity-constraint questions through **schema + insertion/deletion/update scenarios**, rather than simply asking definitions.

### Pattern 1 — Identify violated constraint

Given:

```text
R(A,B)
S(B,C)
```

with `S.B` referencing `R.B`, an inserted tuple in `S` whose `B` value doesn't exist in `R` violates:

> **Referential integrity**

---

### Pattern 2 — NULL and keys

Question gives several possible relations containing NULL and asks which violates integrity.

Remember:

```text
PK = NULL → violation
FK = NULL → potentially valid
```

---

### Pattern 3 — Cascading operations

Given:

```sql
ON DELETE CASCADE
```

GATE can ask how many tuples remain after deleting a parent tuple.

Always trace:

```text
Parent deletion
      ↓
Referencing child tuples
      ↓
CASCADE → delete them
```

---

### Pattern 4 — Candidate key vs primary key

Given functional dependencies or a relation schema, determine:

```text
candidate key
primary key
foreign key
prime attributes
```

This often connects **Integrity Constraints + Normalization + Functional Dependencies**.

---

### Pattern 5 — Constraint preservation after operation

Given an `INSERT`, `UPDATE`, or `DELETE`, determine whether the resulting database state is valid.

Use:

```text
1. Domain?
2. Key uniqueness?
3. PK NULL?
4. FK reference valid?
```

---

# 🎯 GATE Solving Algorithm

Whenever you see a constraint question:

```text
             Given operation
                    ↓
        ┌───────────┼───────────┐
        ↓           ↓           ↓
      INSERT      UPDATE      DELETE
        ↓           ↓           ↓
   Check domain   Check key   Check FK
   Check PK       Check FK    Check action
   Check FK
```

For an inserted tuple:

```text
Domain → Key → PK NULL → FK
```

---

# ⚡ 30-Second Revision

```text
DOMAIN
→ allowed values

SUPER KEY
→ uniquely identifies tuple

CANDIDATE KEY
→ minimal superkey

PRIMARY KEY
→ chosen candidate key
→ UNIQUE + NOT NULL

ENTITY INTEGRITY
→ PK cannot be NULL

FOREIGN KEY
→ references key in another relation

REFERENTIAL INTEGRITY
→ non-NULL FK must have matching referenced value

FK can be NULL
→ unless NOT NULL specified

CHECK
→ condition on values

UNIQUE
→ uniqueness, but not equivalent to PK

CASCADE
→ propagate delete/update

SET NULL
→ child FK becomes NULL

RESTRICT
→ reject operation if dependency exists
```

## 📌 GATE Priority

| Topic                        | Priority |
| ---------------------------- | -------: |
| Primary/Candidate/Super Keys |    ⭐⭐⭐⭐⭐ |
| Referential Integrity        |    ⭐⭐⭐⭐⭐ |
| Foreign Keys                 |    ⭐⭐⭐⭐⭐ |
| NULL with constraints        |    ⭐⭐⭐⭐⭐ |
| CASCADE / SET NULL           |     ⭐⭐⭐⭐ |
| Domain constraints           |      ⭐⭐⭐ |
| CHECK / DEFAULT              |      ⭐⭐⭐ |
| DDL constraint syntax        |       ⭐⭐ |

**Next: `07-Normal-Forms.md` — one of the highest-weight DBMS topics for GATE.**
