# 08 - Decidability and Undecidability

## GATE CSE - Theory of Computation

---

# 1. What is Decidability?

A language L is decidable if there exists a Turing Machine
that:

1. Accepts every string in L.
2. Rejects every string not in L.
3. HALTS on every input.

Therefore:

Decidable = A TM that always halts.

---

# 2. Decidable Language

If M is a decider for L:

w ∈ L
→ M accepts and halts.

w ∉ L
→ M rejects and halts.

There is NO infinite loop.

---

# 3. Turing-Recognizable Language

A language L is Turing-recognizable if there exists a TM M such that:

w ∈ L
→ M accepts.

For:

w ∉ L

M may:

- reject
OR
- loop forever.

---

# 4. Most Important Relationship

DECIDABLE ⊂ RECOGNIZABLE

Every decidable language is recognizable.

But:

Every recognizable language is NOT decidable.

---

# 5. GATE Memory Trick

DECIDER:

YES → HALT
NO → HALT

RECOGNIZER:

YES → HALT
NO → MAY LOOP

Remember:

"Decider decides both YES and NO."

---

# 6. Complement Relationship

If L is decidable:

L̅ is also decidable.

Therefore:

Decidable languages are closed under complement.

---

# 7. Recognizable Complement Theorem

If:

L is recognizable

AND

L̅ is recognizable

then:

L is decidable.

This is one of the MOST IMPORTANT GATE results.

---

# 8. Why?

Run the recognizer for L and
the recognizer for L̅ in parallel.

For any input w:

Either:

w ∈ L

OR:

w ∈ L̅

Therefore one recognizer must eventually accept.

So we can always halt.

Hence L is decidable.

---

# 9. Halting Problem

HALT_TM:

HALT_TM =
{<M,w> | M halts on input w}

Question:

"Does M halt on w?"

Answer:

UNDECIDABLE.

---

# 10. Is HALT_TM Recognizable?

YES.

Why?

Simulate M on w.

If M halts:

accept.

If M never halts:

our simulation also continues forever.

Therefore:

HALT_TM is recognizable but undecidable.

---

# 11. Acceptance Problem

A_TM:

A_TM =
{<M,w> | M accepts w}

Question:

"Does M accept w?"

This is:

UNDECIDABLE.

But:

A_TM is recognizable.

---

# 12. A_TM Recognition

Given:

<M,w>

Simulate M on w.

If M accepts:

accept.

If M rejects:

reject.

If M loops:

our recognizer loops.

Therefore:

A_TM is recognizable.

---

# 13. Important Table

| Language/Problem | Decidable | Recognizable |
|---|---:|---:|
| A_TM | NO | YES |
| HALT_TM | NO | YES |
| Regular language membership | YES | YES |
| CFG membership | YES | YES |
| DFA equivalence | YES | YES |
| TM equivalence | NO | NO in general |
| TM emptiness | NO | NO in general |

---

# 14. A_TM Complement

A̅_TM is:

{<M,w> | M does NOT accept w}

This includes:

- M rejects w
- M loops on w

A̅_TM is NOT recognizable.

Therefore:

A_TM is recognizable
but
A̅_TM is not recognizable.

---

# 15. GATE Trick

If:

L is recognizable
but
L̅ is NOT recognizable

then:

L is NOT decidable.

Because:

If L were decidable,
L̅ would also be decidable,
and therefore recognizable.

Contradiction.

---

# 16. Decidable Language Closure

Decidable languages are closed under:

- Union
- Intersection
- Complement
- Difference
- Concatenation
- Kleene star
- Reversal

---

# 17. Recognizable Language Closure

Recognizable languages are closed under:

- Union
- Intersection
- Concatenation
- Kleene star

They are NOT generally closed under:

- Complement
- Difference

---

# 18. GATE Closure Table

| Operation | Decidable | Recognizable |
|---|---|---|
| Union | YES | YES |
| Intersection | YES | YES |
| Complement | YES | NO |
| Difference | YES | NO |
| Concatenation | YES | YES |
| Star | YES | YES |
| Reversal | YES | YES |

---

# 19. Reduction

Reduction is one of the most important
undecidability techniques.

Suppose:

A ≤m B

This means:

A can be transformed into B.

If B had a decider,
then A could also be decided.

---

# 20. Reduction Direction

To prove B is undecidable:

Start with known undecidable A.

Show:

A ≤m B

Then:

B must be undecidable.

---

# 21. GATE Reduction Trick

Remember:

"HARD → TARGET"

Known hard problem
        ↓
     reduction
        ↓
Target problem

If target were easy/decidable,
the known hard problem would become easy.

Contradiction.

---

# 22. Example

Suppose:

A_TM ≤m X

Since:

A_TM is undecidable,

X must be undecidable.

---

# 23. Common Reduction Mistake

Suppose:

X ≤m A_TM

You CANNOT conclude:

X is undecidable

just because A_TM is undecidable.

X could be decidable.

The important direction is:

KNOWN UNDECIDABLE → TARGET

---

# 24. Mapping Reduction

Notation:

A ≤m B

means there is a computable function f such that:

x ∈ A
iff
f(x) ∈ B

Therefore:

x ∈ A ⇔ f(x) ∈ B

---

# 25. Reduction Composition

If:

A ≤ B

and:

B ≤ C

then:

A ≤ C

Reductions are transitive.

---

# 26. Decidability Through Reduction

If:

A ≤ B

and B is decidable,

then A is decidable.

Because:

Convert input for A
→ solve B.

---

# 27. Undecidability Through Reduction

If:

A is undecidable

and:

A ≤ B

then:

B is undecidable.

This is the most useful direction.

---

# 28. PCP

PCP = Post Correspondence Problem.

It is a classic undecidable problem.

Input:

A list of pairs of strings:

(x1,y1)
(x2,y2)
...
(xn,yn)

Question:

Is there a sequence of indices:

i1,i2,...,ik

such that:

xi1 xi2 ... xik
=
yi1 yi2 ... yik

?

---

# 29. PCP Example

Suppose tiles:

1. (a,ab)
2. (ba,a)

We need to determine whether some sequence
makes top and bottom strings equal.

The general PCP is:

UNDECIDABLE.

---

# 30. GATE PCP Trick

PCP asks:

"Can we choose tiles in some sequence
so that TOP = BOTTOM?"

Remember:

PCP → UNDECIDABLE.

---

# 31. Modified PCP

MPCP = Modified Post Correspondence Problem.

The first tile is required to be used first.

MPCP is also:

UNDECIDABLE.

---

# 32. PCP vs MPCP

| Problem | Decidable? |
|---|---|
| PCP | NO |
| MPCP | NO |

---

# 33. Rice's Theorem

Rice's theorem is a very high-yield
GATE concept.

Statement:

Every non-trivial semantic property
of the language recognized by a TM
is undecidable.

---

# 34. Semantic Property

A property that depends only on:

L(M)

and NOT on the particular implementation
of M.

Example:

"L(M) is empty."

This depends on the language.

---

# 35. Examples Covered by Rice's Theorem

For an arbitrary TM M:

"Is L(M) empty?"

UNDECIDABLE.

"Is L(M) finite?"

UNDECIDABLE.

"Is L(M) regular?"

UNDECIDABLE.

"Is L(M) context-free?"

UNDECIDABLE.

"Is L(M) = Σ*?"

UNDECIDABLE.

---

# 36. Non-Trivial Property

A property is non-trivial if:

Some TMs have it.

AND:

Some TMs do not have it.

Therefore Rice's theorem can apply.

---

# 37. Rice's Theorem Does NOT Apply To

Properties about the syntax/description
of the machine.

Examples:

"Does M have exactly 10 states?"

"Does M contain a transition from q1 to q2?"

"Does M have 5 tape symbols?"

These are properties of the machine encoding,
not of L(M).

---

# 38. GATE Rice Trick

Ask:

"Is the question about WHAT LANGUAGE
the TM recognizes?"

If YES:

Think:

RICE'S THEOREM.

If it is about:

states
transitions
encoding
number of symbols

Rice's theorem does NOT directly apply.

---

# 39. Empty Language Problem

E_TM:

E_TM =
{<M> | L(M) = ∅}

Question:

"Does M accept no strings?"

Undecidable.

By Rice's theorem:

"Language recognized by M is empty"
is a non-trivial semantic property.

---

# 40. Universal Language Problem

ALL_TM:

ALL_TM =
{<M> | L(M) = Σ*}

Question:

"Does M accept every string?"

Undecidable.

---

# 41. Finite Language Problem

FINITE_TM:

{<M> | L(M) is finite}

Undecidable.

---

# 42. Regularity Problem

REGULAR_TM:

{<M> | L(M) is regular}

Undecidable.

Even though:

Given a DFA,
regularity is automatic.

But for an arbitrary TM:

"Is its language regular?"

is undecidable.

---

# 43. Equivalence of TMs

EQ_TM:

{<M1,M2> | L(M1)=L(M2)}

is undecidable.

---

# 44. Important Comparison

For DFA:

Equivalence → DECIDABLE.

For TM:

Equivalence → UNDECIDABLE.

Do not transfer results between machine classes.

---

# 45. DFA vs TM Decision Problems

## DFA

Membership → decidable
Emptiness → decidable
Equivalence → decidable
Universality → decidable
Finiteness → decidable

## TM

Membership → recognizable
Acceptance → undecidable
Emptiness → undecidable
Equivalence → undecidable
Universality → undecidable
Finiteness → undecidable

---

# 46. CFG Decision Problems

Important GATE distinction.

For CFG:

Membership:
DECIDABLE.

Emptiness:
DECIDABLE.

Finiteness:
DECIDABLE.

Equivalence:
UNDECIDABLE.

Ambiguity:
UNDECIDABLE.

Universality:
UNDECIDABLE in general.

---

# 47. GATE Table

| Problem | DFA | CFG | TM |
|---|---|---|---|
| Membership | Decidable | Decidable | Undecidable |
| Emptiness | Decidable | Decidable | Undecidable |
| Equivalence | Decidable | Undecidable | Undecidable |
| Universality | Decidable | Undecidable | Undecidable |
| Finiteness | Decidable | Decidable | Undecidable |
| Ambiguity | N/A | Undecidable | N/A |

---

# 48. Diagonalization

Diagonalization is a foundational technique
used to prove undecidability.

Basic idea:

Construct an object that differs from
every candidate in a systematic way.

For TMs, it helps establish that
certain problems cannot have an algorithm.

---

# 49. Classic Contradiction Pattern

Assume a decider H exists for:

HALT_TM.

Construct another machine D that uses H
to behave oppositely on specially chosen input.

Then run D on itself.

This produces a contradiction.

Therefore:

H cannot exist.

Hence:

HALT_TM is undecidable.

---

# 50. Self-Reference Trick

A common undecidability pattern is:

"Run the machine on its own description."

This creates self-reference.

Examples:

M(<M>)

or:

D(<D>)

This is central to diagonalization proofs.

---

# 51. GATE Trick

When you see:

"machine runs on its own encoding"

think:

SELF-REFERENCE / DIAGONALIZATION.

Often associated with:

Halting Problem
Acceptance Problem
Undecidability.

---

# 52. Decidable vs Recognizable Hierarchy

Think:

                 RE
              /      \
     Decidable       Non-decidable
       languages      recognizable
                       languages

Every decidable language is recognizable.

Some recognizable languages are not decidable.

Some languages are not even recognizable.

---

# 53. Three Important Categories

## Category 1

Decidable:

L and L̅ recognizable.

---

## Category 2

Recognizable but undecidable:

L recognizable
L̅ not recognizable.

Example:

A_TM.

---

## Category 3

Not recognizable:

Neither suitable TM recognizer exists.

Example:

A̅_TM.

---

# 54. GATE Classification Trick

Given:

L recognizable?

Check whether a TM can eventually accept
every member.

Given:

L decidable?

Check whether it can always halt.

Given:

L̅ recognizable?

If both L and L̅ recognizable:

L is decidable.

---

# 55. Important Theorem

L is decidable

iff:

L is recognizable
AND
L̅ is recognizable.

This is a very useful characterization.

---

# 56. Another Important Result

If:

L is decidable,

then:

L̅ is decidable.

Therefore:

Decidable languages are closed under complement.

---

# 57. Rice's Theorem vs Reduction

Use Rice when:

The problem asks about a non-trivial
property of L(M).

Use reduction when:

You can directly transform
a known undecidable problem.

---

# 58. GATE PYQ PATTERN 1

Question:

Is A_TM decidable?

Answer:

NO.

It is recognizable but undecidable.

---

# 59. GATE PYQ PATTERN 2

Question:

Is HALT_TM decidable?

NO.

Recognizable but undecidable.

---

# 60. GATE PYQ PATTERN 3

Question:

If L and L̅ are recognizable,
what follows?

L is decidable.

---

# 61. GATE PYQ PATTERN 4

Question:

If L is decidable,
is L̅ decidable?

YES.

---

# 62. GATE PYQ PATTERN 5

Question:

If L is recognizable,
is L̅ necessarily recognizable?

NO.

---

# 63. GATE PYQ PATTERN 6

Question:

A ≤m B and A is undecidable.
What can be concluded?

B is undecidable.

---

# 64. GATE PYQ PATTERN 7

Question:

B ≤m A_TM.
Does this prove B undecidable?

NO.

Wrong reduction direction.

---

# 65. GATE PYQ PATTERN 8

Question:

Is PCP decidable?

NO.

---

# 66. GATE PYQ PATTERN 9

Question:

Does Rice's theorem apply to:

"Does M have exactly 10 states?"

NO.

This is a syntactic property.

---

# 67. GATE PYQ PATTERN 10

Question:

Does Rice's theorem apply to:

"Is L(M) regular?"

YES.

It is a semantic property.

Therefore:

UNDECIDABLE.

---

# 68. GATE PYQ PATTERN 11

Question:

"Is L(M) empty?"

Rice's theorem applies.

Answer:

UNDECIDABLE.

---

# 69. GATE PYQ PATTERN 12

Question:

"Does M accept at least one string?"

Equivalent to:

L(M) ≠ ∅

This is a non-trivial semantic property.

Therefore:

UNDECIDABLE.

---

# 70. GATE PYQ PATTERN 13

Question:

"Does M accept every string?"

Equivalent to:

L(M) = Σ*

Undecidable.

---

# 71. GATE PYQ PATTERN 14

Question:

"Is L(M) finite?"

Undecidable.

---

# 72. GATE PYQ PATTERN 15

Question:

"Is L(M) context-free?"

Undecidable for arbitrary TM M.

---

# 73. Common GATE Mistakes

## Mistake 1

Undecidable = not recognizable.

WRONG.

Some undecidable languages are recognizable.

---

## Mistake 2

Recognizable = decidable.

WRONG.

---

## Mistake 3

If A ≤ B and A is decidable,
B is decidable.

WRONG.

---

## Mistake 4

If B ≤ A and A is undecidable,
B is undecidable.

WRONG.

Reduction direction matters.

---

## Mistake 5

Rice applies to every property of a TM.

WRONG.

Only non-trivial semantic properties
of the recognized language.

---

## Mistake 6

PCP is decidable because we can
try all tile sequences.

WRONG.

Trying sequences may continue forever
if no solution exists.

---

# 74. PCP Search Trick

PCP is recognizable:

Enumerate all possible tile sequences:

1
2
3
1,1
1,2
2,1
2,2
...

For each sequence:

compare top and bottom.

If a solution exists:

eventually find it.

If no solution exists:

search continues forever.

Therefore PCP:

Recognizable but undecidable.

---

# 75. Important PCP Result

PCP:

Undecidable.

MPCP:

Undecidable.

PCP is often used as a starting point
for proving other problems undecidable.

---

# 76. Undecidability Proof Template

To prove X undecidable:

### Method 1: Reduction

1. Select known undecidable A.
2. Construct computable transformation f.
3. Show:

x ∈ A
iff
f(x) ∈ X

4. Assume X has a decider.
5. Use it to decide A.
6. Contradiction.

Therefore X is undecidable.

---

# 77. Rice's Theorem Template

To prove X undecidable:

### Step 1

Identify X as a property of L(M).

### Step 2

Check property is non-trivial.

### Step 3

Apply Rice's theorem.

Therefore:

X is undecidable.

---

# 78. GATE Fast Decision Tree

Given a problem about a machine:

### Is it a DFA?

Most standard questions are decidable.

### Is it a CFG?

Membership/emptiness/finiteness are decidable,
but equivalence/ambiguity can be undecidable.

### Is it an arbitrary TM?

Immediately check for:

- Halting
- Acceptance
- Empty language
- Universality
- Equivalence
- Finiteness
- Regularity
- CFL property

These are common undecidable problems.

---

# 79. Ultimate GATE Table

| Problem | Answer |
|---|---|
| HALT_TM | Undecidable, recognizable |
| A_TM | Undecidable, recognizable |
| A̅_TM | Not recognizable |
| PCP | Undecidable, recognizable |
| MPCP | Undecidable |
| E_TM | Undecidable |
| ALL_TM | Undecidable |
| FINITE_TM | Undecidable |
| EQ_TM | Undecidable |
| REGULAR_TM | Undecidable |
| CFL_TM | Undecidable |

---

# 80. LAST-MINUTE REVISION

## Decider

Halts on every input.

---

## Recognizer

Must accept members.

May loop on non-members.

---

## Key Relationship

Decidable ⊂ Recognizable.

---

## Characterization

L decidable
iff
L and L̅ recognizable.

---

## HALT_TM

Undecidable.

Recognizable.

---

## A_TM

Undecidable.

Recognizable.

---

## A̅_TM

Not recognizable.

---

## Reduction

To prove B undecidable:

A undecidable
AND
A ≤ B

⇒ B undecidable.

---

## Rice

Non-trivial semantic property
of L(M)

⇒ undecidable.

---

## PCP

Undecidable.

---

## MPCP

Undecidable.

---

# 81. 30-SECOND GATE MEMORY TRICKS

### Decider

"YES or NO, always stops."

### Recognizer

"YES stops; NO may run forever."

### HALT

"Will it stop?"

→ Undecidable.

### A_TM

"Will it accept?"

→ Undecidable.

### Rice

"Property of L(M)?"

→ Think undecidable.

### Reduction

"HARD → TARGET"

### PCP

"Can top = bottom?"

→ Undecidable.

### Both recognizable

L + L̅ recognizable

→ L decidable.

### TM variants

Usually same computational power.

---

# 82. FINAL GATE CHECKLIST

[ ] Decidable language
[ ] Turing-recognizable language
[ ] Decider vs recognizer
[ ] Complement theorem
[ ] A_TM
[ ] HALT_TM
[ ] Complement of A_TM
[ ] Reduction
[ ] Mapping reduction
[ ] Reduction direction
[ ] Reduction transitivity
[ ] PCP
[ ] MPCP
[ ] Diagonalization
[ ] Self-reference
[ ] Rice's theorem
[ ] Semantic property
[ ] Syntactic property
[ ] Empty language problem
[ ] Universal language problem
[ ] Finiteness problem
[ ] TM equivalence
[ ] Regularity of TM language
[ ] CFL property of TM language
[ ] Closure properties
[ ] GATE undecidability questions

---

# 83. FINAL GATE MASTER FORMULA

                         TURING MACHINES
                              |
              +---------------+---------------+
              |                               |
         DECIDABLE                      RECOGNIZABLE
              |                               |
       Always HALTS                   May NOT halt
              |                               |
              +---------------+---------------+
                              |
                    DECIDABLE ⊂ RE

If L and L̅ are recognizable:
                    ↓
                L is DECIDABLE

Known undecidable:
HALT_TM
A_TM
PCP
E_TM
ALL_TM
EQ_TM
FINITE_TM

Rice:
Non-trivial semantic property
of L(M)
        ↓
    UNDECIDABLE

Reduction:
Known undecidable A
        ↓
      A ≤ B
        ↓
B is UNDECIDABLE