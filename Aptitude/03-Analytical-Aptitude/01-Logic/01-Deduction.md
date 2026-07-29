# Deduction

## Definition

**Deduction** is a logical reasoning process in which a conclusion is drawn from one or more **general statements (premises)**.

If the premises are true and the reasoning is valid, then the conclusion **must** be true.

General Form

```
General Rule

↓

Specific Case

↓

Certain Conclusion
```

Example

```
All programmers write code.

Alice is a programmer.

↓

Alice writes code.
```

---

# Why Learn This?

Deductive reasoning is used wherever decisions must be made based on established rules.

Applications include:

- **Software Engineering** – Program verification, debugging, and rule-based systems.
- **Artificial Intelligence** – Expert systems and knowledge inference.
- **Cybersecurity** – Access control and policy enforcement.
- **Law** – Applying legal rules to specific cases.
- **Medical Diagnosis** – Inferring diseases from known symptoms.
- **Business** – Policy-based decision making.

---

# Prerequisites

Before learning Deduction, you should know:

- Basic English comprehension
- Logical Statements
- Sets (Helpful)
- Conditional Statements (If–Then)

---

# Core Concepts

## Premise

A statement that is assumed to be true.

Example

```
All birds have wings.
```

---

## Conclusion

A statement logically derived from the premises.

Example

```
A sparrow has wings.
```

---

## Argument

An argument consists of:

```
Premises

+

Conclusion
```

---

# Structure of Deductive Reasoning

```
Premise 1

↓

Premise 2

↓

Apply Logic

↓

Conclusion
```

---

# Types of Deductive Arguments

## Universal Statement

Applies to every member of a group.

Example

```
All cats are mammals.
```

---

## Particular Statement

Applies to one or some members.

Example

```
Some students are athletes.
```

---

## Conditional Statement

Uses an "If...Then..." relationship.

Example

```
If it rains,

the ground becomes wet.
```

---

# Common Logical Keywords

| Keyword | Meaning |
|----------|---------|
| All | Every member |
| Some | At least one |
| No | None |
| Only | Restricts membership |
| If | Condition |
| Then | Result |

---

# Rules of Deduction

## Rule 1

If

```
All A are B

A belongs to A
```

Then

```
A belongs to B
```

Example

```
All doctors are educated.

Riya is a doctor.

↓

Riya is educated.
```

---

## Rule 2

If

```
No A are B
```

Then

```
An object cannot belong to both A and B.
```

Example

```
No fish are birds.

↓

A fish cannot be a bird.
```

---

## Rule 3

If

```
Some A are B
```

Then

```
At least one A is B.
```

It does **not** mean

```
All A are B.
```

---

## Rule 4

If

```
Only A are B
```

Then

```
B belongs only to A.
```

Example

```
Only teachers enter this room.

↓

Anyone inside must be a teacher.
```

---

# Venn Diagram Interpretation

## All A are B

```
   _________
  /         \
 |   _____   |
 |  |  A  |  |
 |  |_____|  |
 |     B     |
  \_________/
```

---

## No A are B

```
 ( A )   ( B )
```

No overlap.

---

## Some A are B

```
   (A)
   /\
  /  \
 /____\
 \    /
  \  /
   \/
  (B)
```

Overlap exists.

---

# Important Rules

### All

```
All A are B

↓

Every A is inside B
```

---

### Some

```
Some A are B

↓

Minimum one overlap
```

---

### No

```
No A are B

↓

No overlap
```

---

### Only

```
Only A are B

↓

B implies A
```

---

# Solving Strategy

```
Read Statements
      │
      ▼
Identify Keywords
(All, Some, No, Only)
      │
      ▼
Draw Venn Diagram
(if needed)
      │
      ▼
Check Every Conclusion
      │
      ▼
Mark
True / False / Cannot be Determined
```

---

# Shortcuts & Tricks

### 1. "All"

Think

```
Subset
```

---

### 2. "Some"

Means

```
At least one

NOT

All
```

---

### 3. "No"

Think

```
Separate Circles
```

---

### 4. "Only"

Reverse the relationship.

Example

```
Only doctors prescribe medicine.

↓

Anyone prescribing medicine is a doctor.
```

---

### 5. Never Assume Extra Information

Only use what is given.

---

# Solved Examples

## Example 1

Statements

```
All engineers are graduates.

Rahul is an engineer.
```

Conclusion

```
Rahul is a graduate.
```

Solution

```
Engineer

↓

Graduate
```

Answer

```
True
```

---

## Example 2

Statements

```
Some students are athletes.
```

Conclusion

```
All students are athletes.
```

Answer

```
False
```

Reason

```
"Some"

does not mean

"All"
```

---

## Example 3

Statements

```
No reptiles are mammals.
```

Conclusion

```
A crocodile cannot be both.
```

Answer

```
True
```

---

## Example 4

Statements

```
Only managers have access.
```

Conclusion

```
A person with access is a manager.
```

Answer

```
True
```

---

# Common Mistakes

### Mistake 1

Treating

```
Some

=

All
```

---

### Mistake 2

Adding assumptions not given in the question.

---

### Mistake 3

Ignoring the meaning of

```
Only
```

---

### Mistake 4

Confusing

```
All A are B

with

All B are A
```

---

### Mistake 5

Making conclusions from insufficient information.

---

# Previous Year Question Pattern

Frequently tested concepts:

- Universal Statements
- Particular Statements
- Venn Diagram Questions
- Conditional Reasoning
- Statement-Based Conclusions
- "Only" and "Some" Logic

---

# Practice Questions (with Answers)

## Q1

Statements

```
All apples are fruits.

All fruits are plants.
```

Conclusion

```
All apples are plants.
```

**Answer**

```
True
```

---

## Q2

Statements

```
Some books are magazines.
```

Conclusion

```
All books are magazines.
```

**Answer**

```
False
```

---

## Q3

Statements

```
No dogs are cats.
```

Conclusion

```
A dog cannot be a cat.
```

**Answer**

```
True
```

---

## Q4

Statements

```
Only members may vote.
```

Conclusion

```
Everyone who votes is a member.
```

**Answer**

```
True
```

---

## Q5

Statements

```
Some teachers are writers.
```

Conclusion

```
Some writers are teachers.
```

**Answer**

```
True
```

---

# Quick Revision Sheet

| Keyword | Meaning |
|----------|---------|
| All | Every member |
| Some | At least one |
| No | No overlap |
| Only | Reverse the relationship |
| If...Then | Conditional statement |

---

# GATE 80/20 Summary

✅ Memorize the meanings of:

- **All**
- **Some**
- **No**
- **Only**

✅ Use **Venn diagrams** whenever relationships are difficult to visualize.

✅ Remember:

- **All A are B ≠ All B are A**
- **Some ≠ All**
- **No** means zero overlap.
- **Only** reverses the direction of implication.

✅ Never use outside knowledge—base every conclusion **only on the given statements**.

✅ Most analytical aptitude questions involve **statement-conclusion reasoning, Venn diagrams, and logical deduction**.

---

# Next File

➡️ `02-Induction.md`