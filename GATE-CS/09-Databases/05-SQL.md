# 05 — SQL

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**

SQL is one of the most important DBMS areas in GATE. Focus especially on **query evaluation, NULL, GROUP BY/HAVING, joins, subqueries, EXISTS/NOT EXISTS, ANY/ALL**.

---

## 1. What is SQL?

**SQL (Structured Query Language)** is a declarative language used to define, manipulate and query relational databases.

> **First principle:** SQL tells the DBMS **what data you want**, not how to retrieve it.

---

# 2. SQL Command Categories

| Category | Purpose          | Examples                              |
| -------- | ---------------- | ------------------------------------- |
| **DDL**  | Define structure | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| **DML**  | Modify data      | `INSERT`, `UPDATE`, `DELETE`          |
| **DQL**  | Query data       | `SELECT`                              |
| **DCL**  | Permissions      | `GRANT`, `REVOKE`                     |
| **TCL**  | Transactions     | `COMMIT`, `ROLLBACK`, `SAVEPOINT`     |

🔥 **GATE Trap**

`SELECT` is commonly treated separately as **DQL**, although some classifications include it under DML.

---

# 3. Basic SELECT

```sql
SELECT column1, column2
FROM R
WHERE condition;
```

Example:

```sql
SELECT name
FROM Student
WHERE marks > 80;
```

Execution conceptually:

```text
FROM
 ↓
WHERE
 ↓
GROUP BY
 ↓
HAVING
 ↓
SELECT
 ↓
DISTINCT
 ↓
ORDER BY
```

⚠️ This is the **logical processing idea**, not necessarily the physical execution order.

---

# 4. DISTINCT

```sql
SELECT DISTINCT name
FROM Student;
```

Removes duplicate result tuples.

Example:

```text
Student
name
----
A
A
B
```

Result:

```text
A
B
```

🔥 **Trap**

SQL normally follows **bag/multiset semantics**, so duplicates are allowed unless removed using `DISTINCT`.

---

# 5. WHERE

Filters individual rows.

```sql
SELECT *
FROM Student
WHERE marks > 70;
```

Common operators:

```text
=   <>   !=   <   >   <=   >=
AND OR NOT
BETWEEN
IN
LIKE
IS NULL
IS NOT NULL
```

### BETWEEN

```sql
WHERE marks BETWEEN 60 AND 80
```

means:

```text
60 ≤ marks ≤ 80
```

Both boundaries are **included**.

---

# 6. NULL — 🔥 VERY IMPORTANT

`NULL` means **unknown/missing value**.

It is NOT:

```text
0
''
FALSE
```

Never write:

```sql
WHERE salary = NULL
```

Correct:

```sql
WHERE salary IS NULL
```

or

```sql
WHERE salary IS NOT NULL
```

---

## 3-Valued Logic

SQL uses:

```text
TRUE
FALSE
UNKNOWN
```

Example:

```sql
NULL > 10
```

→ `UNKNOWN`

A row is selected by `WHERE` only when the condition evaluates to **TRUE**.

Therefore:

```sql
WHERE salary > 50000
```

does not select rows where `salary = NULL`.

---

## Important NULL Logic

| Expression       | Result  |
| ---------------- | ------- |
| `NULL = NULL`    | UNKNOWN |
| `NULL <> NULL`   | UNKNOWN |
| `NULL > 5`       | UNKNOWN |
| `NULL AND TRUE`  | UNKNOWN |
| `NULL AND FALSE` | FALSE   |
| `NULL OR TRUE`   | TRUE    |
| `NULL OR FALSE`  | UNKNOWN |
| `NOT UNKNOWN`    | UNKNOWN |

🔥 **GATE Trick**

Remember:

> **FALSE kills AND; TRUE kills OR.**

---

# 7. Aggregate Functions

Main functions:

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

Example:

```sql
SELECT AVG(salary)
FROM Employee;
```

### NULL behavior

For a column:

```sql
COUNT(column)
```

→ counts **non-NULL values**

while:

```sql
COUNT(*)
```

→ counts **rows**

Example:

| id | salary |
| -- | -----: |
| 1  |    100 |
| 2  |   NULL |
| 3  |    200 |

```sql
COUNT(*)       → 3
COUNT(salary)  → 2
SUM(salary)    → 300
AVG(salary)    → 150
```

🔥 **Extremely important GATE trap**

> `COUNT(*) ≠ COUNT(column)` when NULL exists.

---

# 8. GROUP BY

Groups rows having the same value.

```sql
SELECT deptId, COUNT(*)
FROM Employee
GROUP BY deptId;
```

Example:

```text
Employee

dept salary
A    10
A    20
B    30
```

Result:

```text
A  2
B  1
```

---

# 9. HAVING

`WHERE` → filters **rows**

`HAVING` → filters **groups**

Example:

```sql
SELECT deptId, COUNT(*)
FROM Employee
GROUP BY deptId
HAVING COUNT(*) > 5;
```

### 🔥 Difference

| WHERE                          | HAVING                  |
| ------------------------------ | ----------------------- |
| Before grouping                | After grouping          |
| Filters rows                   | Filters groups          |
| Usually no aggregate condition | Commonly uses aggregate |

---

## Important GATE Fact

`HAVING` can appear **without `GROUP BY`**.

Example:

```sql
SELECT COUNT(*)
FROM Student
HAVING COUNT(*) > 10;
```

The entire table can be treated as one group.

A GATE 2012 question specifically tested whether `HAVING` requires `GROUP BY`; it does **not**. ([ExamSIDE][1])

---

# 10. ORDER BY

Used to sort the final result.

```sql
SELECT name, salary
FROM Employee
ORDER BY salary;
```

Default:

```text
ASC
```

Descending:

```sql
ORDER BY salary DESC;
```

Multiple attributes:

```sql
ORDER BY deptId ASC, salary DESC;
```

---

# 11. Joins

## INNER JOIN

Returns matching rows.

```sql
SELECT *
FROM Student S
INNER JOIN Performance P
ON S.roll = P.roll;
```

Only matching tuples.

---

## LEFT OUTER JOIN

Returns:

```text
all rows from LEFT
+
matching rows from RIGHT
```

Unmatched right-side attributes become `NULL`.

---

## RIGHT OUTER JOIN

Returns:

```text
all rows from RIGHT
+
matching rows from LEFT
```

---

## FULL OUTER JOIN

Returns:

```text
all rows from both tables
```

Unmatched attributes become `NULL`.

### 🔥 GATE Trick

Think:

```text
INNER → intersection
LEFT  → everything from left
RIGHT → everything from right
FULL  → everything from both
```

A GATE 2018 question tested which join result is guaranteed to contain the outputs of the other three: **FULL OUTER JOIN**. ([ExamSIDE][1])

---

# 12. Natural Join

```sql
R NATURAL JOIN S
```

Automatically joins attributes having the **same name**.

Duplicate join attributes appear only once.

🔥 **Trap**

Natural join depends on **attribute names**, not merely compatible values.

---

# 13. Self Join

A table can be joined with itself.

Example:

```sql
SELECT E.name, M.name
FROM Employee E
JOIN Employee M
ON E.manager_id = M.emp_id;
```

Here:

```text
E → employee
M → manager
```

Both refer to the same table.

---

# 14. Subqueries

A query inside another query.

```sql
SELECT name
FROM Employee
WHERE salary >
      (SELECT AVG(salary)
       FROM Employee);
```

---

# 15. Scalar Subquery

Returns **one value**.

```sql
salary > (
    SELECT AVG(salary)
    FROM Employee
)
```

If a scalar subquery returns multiple rows → error.

---

# 16. IN

```sql
WHERE deptId IN
      (SELECT deptId
       FROM Department
       WHERE location = 'Pune');
```

Means:

> Is the value present in the subquery result?

---

# 17. EXISTS

Checks whether the subquery produces **at least one row**.

```sql
SELECT E.name
FROM Employee E
WHERE EXISTS
(
    SELECT *
    FROM Department D
    WHERE D.deptId = E.deptId
);
```

Important:

> `EXISTS` cares about **existence**, not the actual selected values.

Therefore:

```sql
EXISTS (SELECT salary ...)
```

and

```sql
EXISTS (SELECT 1 ...)
```

can behave identically if their row-generation conditions are identical.

---

# 18. NOT EXISTS

Means:

> There does NOT exist a matching tuple.

Example:

```sql
SELECT E.name
FROM Employee E
WHERE NOT EXISTS
(
    SELECT *
    FROM Project P
    WHERE P.empId = E.empId
);
```

Returns employees who work on **no project**.

🔥 **GATE Mental Mapping**

```text
EXISTS     → ∃
NOT EXISTS → ¬∃
```

This connects directly with Tuple Calculus.

---

# 19. Correlated Subquery

A subquery that refers to an outer query variable.

```sql
SELECT E.name
FROM Employee E
WHERE E.salary >
(
    SELECT AVG(S.salary)
    FROM Employee S
    WHERE S.deptId = E.deptId
);
```

`E.deptId` comes from the outer query.

Therefore it is **correlated**.

### Uncorrelated

```sql
SELECT AVG(salary)
FROM Employee;
```

No reference to outer query.

---

# 20. ANY / SOME

```sql
x > ANY(S)
```

means:

> `x` is greater than **at least one** value in S.

Therefore:

```text
x > ANY(S)
```

roughly behaves like:

```text
x > MIN(S)
```

when S is non-empty.

---

# 21. ALL

```sql
x > ALL(S)
```

means:

> `x` is greater than **every** value in S.

Therefore:

```text
x > ALL(S)
```

roughly behaves like:

```text
x > MAX(S)
```

when S is non-empty.

### 🔥 Easy memory

```text
ANY → at least one
ALL → every one
```

Example:

```text
S = {10,20,30}

x > ANY(S)
```

requires:

```text
x > 10
```

whereas

```text
x > ALL(S)
```

requires:

```text
x > 30
```

---

# 22. NOT IN — 🔥 Dangerous NULL Trap

Suppose:

```text
S = {10, 20, NULL}
```

Then:

```sql
x NOT IN (10,20,NULL)
```

can produce **UNKNOWN**, rather than TRUE.

Therefore:

> `NOT IN` + NULL can produce unexpected results.

Often safer conceptually:

```sql
NOT EXISTS
```

---

# 23. Set Operations

SQL supports:

```text
UNION
INTERSECT
EXCEPT
```

Oracle commonly uses:

```text
MINUS
```

### UNION

```sql
R UNION S
```

Combines results and removes duplicates.

### UNION ALL

```sql
R UNION ALL S
```

Keeps duplicates.

### INTERSECT

Returns common tuples.

### EXCEPT

Returns tuples in first query but not second.

---

# 24. Set Compatibility

For:

```sql
R UNION S
```

the corresponding query results must have compatible structure.

Think:

```text
same number of columns
compatible corresponding domains
```

---

# 25. INSERT

```sql
INSERT INTO Student
VALUES (1, 'Rahul', 80);
```

Can specify columns:

```sql
INSERT INTO Student(roll, name, marks)
VALUES (1, 'Rahul', 80);
```

---

# 26. UPDATE

```sql
UPDATE Student
SET marks = 90
WHERE roll = 1;
```

🔥 **Trap**

Without `WHERE`:

```sql
UPDATE Student
SET marks = 90;
```

→ **all rows are updated.**

---

# 27. DELETE

```sql
DELETE FROM Student
WHERE roll = 1;
```

Without `WHERE`:

```sql
DELETE FROM Student;
```

→ all rows are deleted.

The table structure remains.

---

# 28. DELETE vs DROP vs TRUNCATE

| Command  | Rows                      | Table structure |
| -------- | ------------------------- | --------------- |
| DELETE   | Deletes selected/all rows | Remains         |
| TRUNCATE | Removes all rows          | Remains         |
| DROP     | Removes table             | Removed         |

For GATE, remember the conceptual distinction.

---

# 29. SQL ↔ Relational Algebra

| SQL              | Relational Algebra    |
| ---------------- | --------------------- |
| `WHERE`          | Selection `σ`         |
| `SELECT columns` | Projection `π`        |
| `JOIN`           | `⋈`                   |
| `UNION`          | `∪`                   |
| `INTERSECT`      | `∩`                   |
| `EXCEPT`         | `−`                   |
| `FROM R,S`       | Cartesian product `×` |

🔥 Important:

```sql
SELECT DISTINCT A
FROM R
```

is closer to relational algebra projection because RA removes duplicates.

Normal SQL:

```sql
SELECT A
FROM R
```

may retain duplicates.

---

# 30. Most Important Query Pattern

### Employees earning above average

```sql
SELECT name
FROM Employee
WHERE salary >
      (SELECT AVG(salary)
       FROM Employee);
```

Mental pattern:

```text
calculate aggregate
        ↓
compare each row
```

---

# 31. Department-wise maximum salary

```sql
SELECT deptId, MAX(salary)
FROM Employee
GROUP BY deptId;
```

---

# 32. Departments having > 5 employees

```sql
SELECT deptId
FROM Employee
GROUP BY deptId
HAVING COUNT(*) > 5;
```

🔥 Remember:

```text
WHERE COUNT(*) > 5   ❌
HAVING COUNT(*) > 5  ✅
```

---

# 33. Students having no registration

```sql
SELECT S.name
FROM Student S
WHERE NOT EXISTS
(
    SELECT *
    FROM Registration R
    WHERE R.roll = S.roll
);
```

Mental translation:

```text
NOT EXISTS → find things with NO matching tuple
```

---

# 34. GATE Query-Solving Method

When a SQL question gives an actual table:

### Step 1

Apply `FROM` / joins.

### Step 2

Apply `WHERE`.

### Step 3

Calculate groups using `GROUP BY`.

### Step 4

Apply `HAVING`.

### Step 5

Evaluate `SELECT`.

### Step 6

Apply `DISTINCT`.

### Step 7

Check `ORDER BY` if relevant.

For nested queries:

```text
Inner query
    ↓
Determine its result
    ↓
Substitute mentally
    ↓
Outer query
```

---

# 🔥 GATE Traps

1. `NULL = NULL` → **UNKNOWN**
2. Use `IS NULL`, not `= NULL`.
3. `COUNT(*)` counts rows.
4. `COUNT(column)` ignores NULL.
5. `WHERE` filters rows.
6. `HAVING` filters groups.
7. `HAVING` can exist without `GROUP BY`.
8. `FULL OUTER JOIN` contains unmatched rows from both sides.
9. `EXISTS` only checks whether at least one row exists.
10. `ANY` → at least one.
11. `ALL` → every value.
12. `NOT IN` with NULL is dangerous.
13. SQL normally permits duplicates.
14. `UNION` removes duplicates.
15. `UNION ALL` preserves duplicates.
16. `DELETE` without `WHERE` deletes all rows but keeps the table.
17. A correlated subquery references the outer query.
18. `BETWEEN` is inclusive.
19. Natural join uses same-named attributes.
20. `COUNT(*)` and `COUNT(column)` differ when NULL exists.

---

# 🧠 PYQ Patterns

Based on the GATE SQL question archive, SQL has appeared repeatedly in both **1-mark and 2-mark** questions, with especially strong emphasis on query evaluation, joins, aggregates, subqueries, and `EXISTS`. ([ExamSIDE][1])

### Pattern 1 — Query output

Given:

```sql
SELECT *
FROM Student
WHERE gender = 'F'
AND marks > 65;
```

GATE 2023 asked exactly this style of question; the answer was **2 rows**. ([ExamSIDE][2])

**Technique:** evaluate each row against every condition.

---

### Pattern 2 — GROUP BY + aggregate

GATE 2021 Set 2 used:

```sql
SELECT deptId, COUNT(*)
FROM emp
WHERE gender = 'female'
AND salary > (SELECT AVG(salary) FROM emp)
GROUP BY deptId;
```

This tests:

```text
subquery
+
aggregate
+
WHERE
+
GROUP BY
```

([ExamSIDE][1])

---

### Pattern 3 — EXISTS

GATE 2010 asked a query using:

```sql
EXISTS (
    SELECT *
    FROM Passenger
    WHERE ...
)
```

The key is to check whether **at least one matching tuple exists**. ([ExamSIDE][1])

---

### Pattern 4 — ANY vs NOT EXISTS

GATE 2007 compared:

```sql
NOT EXISTS (...)
```

with

```sql
salary > ANY (...)
```

This is a classic test of the difference between **existential conditions and comparisons against a set**. ([ExamSIDE][1])

---

### Pattern 5 — Correlated subquery

GATE 2005 included:

```sql
SELECT title
FROM book B
WHERE
(
    SELECT COUNT(*)
    FROM book T
    WHERE T.price > B.price
) < 5;
```

Because `T` refers to outer tuple `B`, this is a **correlated subquery**. It asks for books having fewer than 5 books priced higher than them. ([ExamSIDE][1])

---

### Pattern 6 — Recent GATE SQL

GATE 2025 Set 1 included a sports-league SQL numerical question involving multiple relations and an aggregate; the answer was **26**. ([ExamSIDE][3])

**Takeaway:** recent GATE continues to test **actual query execution**, not just SQL syntax.

---

# ⚡ 30-Second Revision

```text
WHERE       → rows
GROUP BY    → groups
HAVING      → groups after grouping
SELECT      → requested columns
DISTINCT    → remove duplicates

COUNT(*)    → all rows
COUNT(A)    → non-NULL A

EXISTS      → ∃
NOT EXISTS  → ¬∃
ANY         → at least one
ALL         → every

INNER       → matching
LEFT        → all left
RIGHT       → all right
FULL        → all both

UNION       → combine + remove duplicates
UNION ALL   → combine + keep duplicates

NULL        → UNKNOWN
NULL = NULL → UNKNOWN

BETWEEN     → inclusive

NOT IN + NULL → ⚠️

SQL         → generally bag semantics
RA          → set semantics
```

## 🎯 GATE Priority

| SQL Area              | Priority |
| --------------------- | -------: |
| Query evaluation      |    ⭐⭐⭐⭐⭐ |
| NULL / 3-valued logic |    ⭐⭐⭐⭐⭐ |
| GROUP BY / HAVING     |    ⭐⭐⭐⭐⭐ |
| Subqueries            |    ⭐⭐⭐⭐⭐ |
| EXISTS / NOT EXISTS   |    ⭐⭐⭐⭐⭐ |
| Joins                 |    ⭐⭐⭐⭐⭐ |
| Aggregate functions   |    ⭐⭐⭐⭐⭐ |
| ANY / ALL             |     ⭐⭐⭐⭐ |
| Correlated subqueries |     ⭐⭐⭐⭐ |
| Set operations        |     ⭐⭐⭐⭐ |
| Basic DDL/DML syntax  |       ⭐⭐ |

**SQL is a must-master topic for GATE DBMS.**

Next file: **`06-Integrity-Constraints.md`**.

[1]: https://questions.examside.com/past-years/gate/gate-cse/database-management-system/structured-query-language?utm_source=chatgpt.com "Structured Query Language | Database Management System | GATE CSE Previous Year Questions - ExamSIDE.Com"
[2]: https://questions.examside.com/past-years/gate/question/pconsider-the-following-database-tables-of-a-sports-league-gate-cse-theory-of-computation-finite-automata-and-regular-language-w5sam31abuonqgt5?utm_source=chatgpt.com "GATE CSE 2025 Set 1 | Structured Query Language Question 2 | Database Management System | GATE CSE - ExamSIDE.com"
[3]: https://questions.examside.com/past-years/year-wise/gate/gate-cse/gate-cse-2025-set-1/m7wyas2a?utm_source=chatgpt.com "GATE CSE 2025 Set 1 | GATE CSE Year Wise Previous Years Questions - ExamSIDE.Com"
