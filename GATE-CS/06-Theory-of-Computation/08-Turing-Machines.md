# 07 - Turing Machines (TM)

## GATE CSE - Theory of Computation

---

# 1. What is a Turing Machine?

A Turing Machine (TM) is a mathematical model of computation
with:

- Finite set of states
- Infinite/unbounded tape
- Read/write head
- Transition function

A TM is much more powerful than:

- DFA
- NFA
- PDA

---

# 2. Basic Components

A standard TM contains:

1. Input tape
2. Tape alphabet
3. Read/write head
4. Finite control
5. Blank symbol

The head can:

- Read
- Write
- Move Left
- Move Right

---

# 3. Formal Definition

A TM is commonly represented as:

M = (Q, Σ, Γ, δ, q0, B, F)

Where:

Q = finite set of states

Σ = input alphabet

Γ = tape alphabet

δ = transition function

q0 = initial state

B = blank symbol

F = set of final/accepting states

---

# 4. Tape Alphabet vs Input Alphabet

Very important.

Input alphabet:

Σ

contains symbols allowed in the input.

Tape alphabet:

Γ

contains symbols that may appear on the tape.

Therefore:

Σ ⊆ Γ

The tape alphabet can contain additional
working symbols.

---

# 5. Why Does a TM Need a Larger Tape Alphabet?

Suppose input is:

0011

The TM may need to mark symbols that
have already been processed.

For example:

X X 1 1

Here X is not necessarily an input symbol.

It is a tape symbol.

---

# 6. TM Transition Function

For a standard deterministic TM:

δ : Q × Γ → Q × Γ × {L,R}

Meaning:

Current state
+
current tape symbol

determines:

1. Next state
2. Symbol to write
3. Head movement

---

# 7. Important Difference from PDA

DFA:

δ : Q × Σ → Q

PDA:

depends on:
state + input + stack top

TM:

depends on:
state + tape symbol

and can:

READ + WRITE + MOVE.

---

# 8. GATE Trick

Whenever you see a TM transition:

δ(q, a) = (p, b, R)

read it as:

Current state = q

Read = a

Write = b

Move Right

Next state = p

---

# 9. Example

δ(q0, 0) = (q1, X, R)

Means:

If machine is in q0
and reads 0:

write X
move right
go to q1

---

# 10. TM Computation

A TM starts with the input written on the tape.

Example:

Input:

0011

Initially:

⊢ 0 0 1 1 B B B ...

The head starts at the first input symbol.

The tape is unbounded.

---

# 11. TM Head Movement

The head can move:

L or R

In the standard one-tape TM,
the head can generally move in either direction.

---

# 12. Can TM Stay in Place?

Depending on the formal definition:

Some models allow:

S = Stay

Others use only:

L/R

If Stay is allowed:

δ(q,a) = (p,b,S)

means:

write b
remain on the same tape cell
move to p.

For GATE, always follow the transition definition
given in the question.

---

# 13. Acceptance

A TM can:

- Accept
- Reject
- Loop forever

This is extremely important.

A TM does NOT necessarily halt
on every input.

---

# 14. Recognizer vs Decider

## Turing Recognizer

If:

w ∈ L

TM eventually accepts.

If:

w ∉ L

TM may:

- reject
OR
- loop forever.

---

## Turing Decider

A decider halts on EVERY input.

It:

- accepts strings in L
- rejects strings not in L

---

# 15. GATE Trick

Remember:

RECOGNIZER:

Yes → must eventually accept.

No → may reject OR loop.

DECIDER:

Yes → accept.

No → reject.

Both → HALT.

---

# 16. Decidable Language

A language is decidable if
some TM decides it.

Equivalent idea:

There exists a TM that halts on
every input and correctly answers
membership.

---

# 17. Turing-Recognizable Language

A language is Turing-recognizable if
some TM accepts every string in the language.

For strings outside the language,
the TM may not halt.

---

# 18. Important Relationship

Every decidable language is recognizable.

Therefore:

Decidable ⊆ Recognizable

But:

Not every recognizable language is decidable.

---

# 19. Halting Problem

The Halting Problem asks:

Given a TM M and input w,

will M eventually halt on w?

This problem is:

UNDECIDABLE.

---

# 20. Acceptance Problem

A classic undecidable problem:

A_TM

= {<M,w> | M accepts w}

is undecidable.

---

# 21. Halting Language

HALT_TM

= {<M,w> | M halts on w}

is undecidable.

But it is recognizable.

---

# 22. Important GATE Table

| Problem | Decidable? | Recognizable? |
|---|---:|---:|
| A_TM | NO | YES |
| HALT_TM | NO | YES |
| Empty language | YES | YES |
| Finite language | YES | YES |
| Regular language membership | YES | YES |

---

# 23. Why Halting Problem is Important

It is the foundation for many
undecidability proofs.

If a new problem can be reduced from
HALT_TM or A_TM,
it is usually undecidable.

---

# 24. Reduction

Reduction is used to transfer
difficulty from one problem to another.

If:

A ≤m B

and A is undecidable,

then B must also be undecidable.

Otherwise:

If B were decidable,

we could use the B-decider to decide A.

Contradiction.

---

# 25. GATE Reduction Trick

To prove:

B is undecidable

try:

Known undecidable problem A

↓ reduction

B

If A ≤ B:

B is at least as hard as A.

Therefore:

B is undecidable.

---

# 26. Direction of Reduction

VERY IMPORTANT.

To prove B is hard:

A ≤ B

where A is already known to be hard.

Think:

"Can I solve A if I had a solver for B?"

If YES:

A reduces to B.

Therefore B is at least as difficult as A.

---

# 27. Common Mistake

If:

A ≤ B

and A is decidable,

you CANNOT conclude B is decidable.

Reduction direction matters.

---

# 28. Universal Turing Machine

A Universal TM (UTM) can simulate
any other TM.

Input:

< M, w >

The universal TM simulates M on w.

This is the theoretical basis of
general-purpose computers.

---

# 29. TM Configuration

A TM configuration describes:

- Current state
- Tape contents
- Head position

A common notation:

u q v

means:

tape contains uv
and the head is positioned at
the first symbol of v,
with current state q.

Exact notation may vary.

---

# 30. Instantaneous Description

An instantaneous description (ID)
represents one complete configuration
of a TM during computation.

Example:

u q av

means:

current state = q
head reads a
tape content represented by uav.

---

# 31. TM Language Classes

A TM can recognize:

Recursively Enumerable Languages.

These are also called:

Turing-recognizable languages.

---

# 32. Decidable Languages

Decidable languages are a subset of
recursively enumerable languages.

Therefore:

DECIDABLE ⊂ RE

---

# 33. Chomsky Hierarchy

Regular
   ⊂
Context-Free
   ⊂
Context-Sensitive
   ⊂
Recursively Enumerable

Machines:

FA
↓
PDA
↓
LBA
↓
TM

---

# 34. TM vs PDA

PDA has:

one stack.

TM has:

read/write tape.

Therefore TM is more powerful.

A TM can simulate a PDA.

A PDA cannot simulate every TM.

---

# 35. TM vs DFA

A TM can simulate a DFA.

Therefore:

Regular languages are also TM-recognizable.

---

# 36. TM Variants

Common variants:

1. Multi-tape TM
2. Multi-track TM
3. Non-deterministic TM
4. Two-way infinite tape TM
5. Stay-put TM

For language recognition power,
these variants are equivalent to
the standard TM.

---

# 37. Multi-Tape TM

A multi-tape TM has multiple tapes,
each with its own head.

Example:

Tape 1 → input
Tape 2 → working memory
Tape 3 → auxiliary computation

It may be much faster,
but NOT more powerful in terms of
which languages it can recognize.

---

# 38. Multi-Tape TM

Important:

Multi-tape TM and single-tape TM
have the same computational power.

Difference is mainly efficiency.

---

# 39. Nondeterministic TM

An NTM may have multiple possible
transitions from the same configuration.

For language recognition:

NTM and DTM have the same
computational power.

This does NOT mean they have the
same time complexity.

---

# 40. GATE Trap

NTM is not more powerful than DTM
for language recognition.

Both recognize exactly:

Recursively Enumerable Languages.

---

# 41. Two-Way Infinite Tape

A TM with tape infinite in both directions
has the same computational power as
the standard one-way-infinite model.

---

# 42. Stay-Put TM

If a TM can move:

L, R, S

it has the same computational power
as a standard TM using only L/R.

---

# 43. TM for aⁿbⁿ

A TM can recognize:

L = {aⁿbⁿ | n ≥ 0}

Simple strategy:

1. Find an unmarked a.
2. Mark it X.
3. Move right and find an unmarked b.
4. Mark it Y.
5. Return left.
6. Repeat.
7. Accept if all symbols are matched.

---

# 44. TM for Palindrome

Strategy:

1. Mark leftmost unmarked symbol.
2. Move to rightmost unmarked symbol.
3. Compare.
4. If different → reject.
5. If same → mark.
6. Return to left.
7. Repeat.

---

# 45. GATE TM Design Trick

When designing a TM:

Use MARKERS.

Example:

a → X
b → Y

Markers allow the machine to remember
which symbols have already been processed.

---

# 46. TM for aⁿbⁿcⁿ

Unlike PDA:

TM CAN recognize:

{aⁿbⁿcⁿ | n ≥ 0}

Strategy:

Match:

one a
one b
one c

during repeated scans.

The TM can repeatedly move
left and right on its tape.

---

# 47. Important Comparison

| Language | FA | PDA | TM |
|---|---:|---:|---:|
| aⁿbⁿ | NO | YES | YES |
| aⁿbⁿcⁿ | NO | NO | YES |
| ww | NO | NO | YES |
| General computable language | NO | NO | YES |

---

# 48. Decidability vs Recognizability

Suppose a TM recognizes L.

For:

w ∈ L:

TM eventually accepts.

For:

w ∉ L:

TM may loop.

Therefore recognition alone
does not guarantee decidability.

---

# 49. Complement Relationship

Important theorem:

If L and its complement L̅
are both recognizable,

then L is decidable.

Why?

Run the two recognizers in parallel.

One of them must eventually accept.

Therefore membership can be decided.

---

# 50. GATE Trick

If:

L is recognizable
AND
L̅ is recognizable

then:

L is decidable.

This is a very important theorem.

---

# 51. If L is Decidable

Then:

L is recognizable.

And:

L̅ is also decidable.

Therefore:

L̅ is recognizable.

So:

Decidable languages are closed under complement.

---

# 52. Recognizable Languages

Recognizable languages are closed under:

- Union
- Intersection
- Concatenation
- Kleene star

But are NOT closed under complement.

---

# 53. Why Recognizable Not Closed Under Complement?

Suppose L is recognizable.

For strings in L:

accept eventually.

For strings not in L:

may loop.

Complement would require reliable
acceptance of all strings not in L.

That cannot always be guaranteed.

---

# 54. Decidable Language Closure

Decidable languages are closed under:

- Union
- Intersection
- Complement
- Difference
- Concatenation
- Kleene star
- Reversal

---

# 55. GATE Closure Table

| Operation | Decidable | Recognizable |
|---|---|---|
| Union | YES | YES |
| Intersection | YES | YES |
| Complement | YES | NO |
| Difference | YES | Not generally |
| Concatenation | YES | YES |
| Star | YES | YES |

---

# 56. Emptiness Problem

Question:

Given TM M,

is L(M) = ∅?

This is:

UNDECIDABLE.

---

# 57. Universality Problem

Question:

Does M accept every possible string?

That is:

L(M) = Σ*

This is:

UNDECIDABLE.

---

# 58. Equivalence Problem

Question:

Do two TMs recognize the same language?

L(M1) = L(M2)

This is:

UNDECIDABLE.

---

# 59. Finiteness Problem

Question:

Is L(M) finite?

For general TMs:

UNDECIDABLE.

---

# 60. Regular Language Problems Are Different

For DFA:

- Membership → decidable
- Emptiness → decidable
- Equivalence → decidable
- Finiteness → decidable
- Universality → decidable

Do NOT transfer TM undecidability
results blindly to DFA.

---

# 61. GATE PYQ PATTERN 1

Question:

Which of the following can a TM do?

Answer:

Read
Write
Move left/right
Use additional tape symbols
Loop forever

---

# 62. GATE PYQ PATTERN 2

Question:

What is the difference between
a recognizer and a decider?

Answer:

Recognizer may loop on NO instances.

Decider halts on every input.

---

# 63. GATE PYQ PATTERN 3

Question:

Is HALT_TM decidable?

NO.

It is recognizable but undecidable.

---

# 64. GATE PYQ PATTERN 4

Question:

Is A_TM decidable?

NO.

A_TM = {<M,w> | M accepts w}

is undecidable.

---

# 65. GATE PYQ PATTERN 5

Question:

If L and L̅ are recognizable,
what can be concluded?

L is decidable.

---

# 66. GATE PYQ PATTERN 6

Question:

Are multi-tape TMs more powerful
than single-tape TMs?

NO.

They are equivalent in computational power.

They can differ in efficiency.

---

# 67. GATE PYQ PATTERN 7

Question:

Is an NTM more powerful than a DTM?

For language recognition:

NO.

Both recognize the same class of languages.

---

# 68. GATE PYQ PATTERN 8

Question:

Can TM recognize aⁿbⁿcⁿ?

YES.

Unlike PDA, TM has sufficient memory
to repeatedly scan and mark the tape.

---

# 69. GATE PYQ PATTERN 9

Question:

What does:

δ(q,a) = (p,b,R)

mean?

Answer:

Read a
→ write b
→ move right
→ enter p.

---

# 70. GATE PYQ PATTERN 10

Question:

What is the maximum number of
states of a TM?

There is no fixed universal maximum.

A TM can have any finite number of states.

---

# 71. GATE PYQ PATTERN 11

Question:

What is the tape alphabet?

Answer:

All symbols that may appear on the tape,
including working/marker symbols.

---

# 72. GATE PYQ PATTERN 12

Question:

Can a TM move left after reading
the first input symbol?

Depending on the tape convention,
the boundary/start cell may impose restrictions.

Always follow the formal model given.

---

# 73. GATE PYQ PATTERN 13

Question:

If a TM accepts an input,
must it halt?

YES.

Acceptance means the machine eventually
enters an accepting condition.

---

# 74. GATE PYQ PATTERN 14

Question:

If a TM rejects an input,
must it halt?

For a recognizer:

No.

It may loop instead of explicitly rejecting.

For a decider:

Yes.

---

# 75. GATE PYQ PATTERN 15

Question:

Can an undecidable language be recognizable?

YES.

Classic example:

A_TM

and:

HALT_TM

---

# 76. Common GATE Mistakes

## Mistake 1

Every TM halts.

WRONG.

A TM may loop forever.

---

## Mistake 2

Recognizable = decidable.

WRONG.

Decidable ⊂ Recognizable.

---

## Mistake 3

NTM is more powerful than DTM.

WRONG for language recognition.

---

## Mistake 4

Multi-tape TM is more powerful.

WRONG.

Same language-recognition power.

---

## Mistake 5

aⁿbⁿcⁿ cannot be recognized by a TM.

WRONG.

TM CAN recognize it.

---

## Mistake 6

HALT_TM is not recognizable.

WRONG.

HALT_TM is recognizable but undecidable.

---

# 77. SUPER HIGH-YIELD TABLE

| Machine | Power |
|---|---|
| DFA | Regular |
| NFA | Regular |
| PDA | CFL |
| DPDA | DCFL |
| LBA | Context-Sensitive |
| TM | Recursively Enumerable |

---

# 78. Important Language Classes

REGULAR:

recognized by FA.

CFL:

recognized by PDA.

CSL:

recognized by LBA.

RE:

recognized by TM.

DECIDABLE:

recognized by a halting TM.

---

# 79. Decidable vs RE

DECIDABLE ⊂ RE

Every decidable language:

- recognizable
- complement recognizable
- complement decidable

But a recognizable language
may have an undecidable complement.

---

# 80. Halting Problem Trick

Whenever a question asks:

"Will this arbitrary TM halt?"

immediately think:

HALTING PROBLEM.

General case:

UNDECIDABLE.

---

# 81. Rice's Theorem

Very important for GATE.

Rice's theorem says:

Every non-trivial semantic property
of the language recognized by a TM
is undecidable.

---

# 82. What is a Semantic Property?

A property about:

L(M)

the language recognized by M.

Examples:

"Does M accept any string?"

"Is L(M) finite?"

"Is L(M) regular?"

"Does M accept every string?"

These are properties of the language,
not merely the syntax of the machine.

---

# 83. Non-Trivial Property

A property is non-trivial if:

Some TMs have the property

AND

Some TMs do not have the property.

Then Rice's theorem applies.

---

# 84. GATE Rice's Theorem Trick

If the question asks:

"Is the language recognized by a TM
regular?"

or:

"Is the language recognized by a TM
empty?"

or:

"Is the language recognized by a TM
finite?"

Think:

RICE → UNDECIDABLE

provided the property is non-trivial and semantic.

---

# 85. Rice's Theorem Does NOT Apply To

Properties about the actual encoding/syntax
of the TM.

Example:

"Does the TM have 10 states?"

This is not a semantic property of L(M).

It may be decidable directly from the encoding.

---

# 86. GATE Reduction vs Rice

Use:

### Rice's theorem

when the question is directly about
a non-trivial property of L(M).

### Reduction

when you need to construct a transformation
from a known undecidable problem.

---

# 87. Last-Minute Revision

TM:

Read + Write + Move.

Formal:

(Q,Σ,Γ,δ,q0,B,F)

Transition:

δ : Q × Γ → Q × Γ × {L,R}

Input alphabet:

Σ

Tape alphabet:

Γ

Σ ⊆ Γ

Recognizer:

may loop on NO.

Decider:

halts on ALL inputs.

---

# 88. Critical Undecidable Problems

HALT_TM → undecidable

A_TM → undecidable

E_TM → undecidable

EQ_TM → undecidable

FINITE_TM → undecidable

ALL_TM → undecidable

---

# 89. Important Recognizable Problems

A_TM → recognizable

HALT_TM → recognizable

Their complements:

not necessarily recognizable.

---

# 90. Closure Tricks

Decidable:

closed under complement.

Recognizable:

NOT closed under complement.

If:

L and L̅ are recognizable:

L is decidable.

---

# 91. TM Variants

Multi-tape → same power.

Nondeterministic TM → same power.

Two-way tape → same power.

Stay-put → same power.

---

# 92. GATE Memory Tricks

### TM

READ → WRITE → MOVE.

### Recognizer

YES → halt and accept.
NO → may loop.

### Decider

YES → halt accept.
NO → halt reject.

### HALT

"Will it stop?"

→ Undecidable.

### A_TM

"Will it accept?"

→ Undecidable.

### Rice

"Property of L(M)?"

→ Think undecidable.

### Multi-tape

Faster possible,
NOT more powerful.

---

# 93. FINAL GATE CHECKLIST

[ ] TM definition
[ ] TM components
[ ] Input alphabet
[ ] Tape alphabet
[ ] Blank symbol
[ ] Transition function
[ ] Read/write/move
[ ] TM configuration
[ ] Instantaneous description
[ ] Acceptance
[ ] Rejection
[ ] Infinite loop
[ ] Recognizer
[ ] Decider
[ ] Decidable language
[ ] Turing-recognizable language
[ ] Halting problem
[ ] A_TM
[ ] HALT_TM
[ ] Reductions
[ ] Reduction direction
[ ] Universal TM
[ ] Multi-tape TM
[ ] NTM
[ ] TM variants
[ ] TM language hierarchy
[ ] Closure properties
[ ] Rice's theorem
[ ] Semantic vs syntactic properties
[ ] GATE undecidability questions

---

# 94. 30-SECOND GATE REVISION

TM:

READ + WRITE + MOVE.

Σ:

input symbols.

Γ:

tape symbols.

Σ ⊆ Γ.

Recognizer:

may loop on non-members.

Decider:

always halts.

Decidable:

⊂ Recognizable.

HALT_TM:

undecidable + recognizable.

A_TM:

undecidable + recognizable.

If L and L̅ are recognizable:

L is decidable.

Multi-tape TM:

same power as single-tape.

NTM:

same recognition power as DTM.

Rice:

non-trivial semantic property of TM language
→ undecidable.

aⁿbⁿcⁿ:

TM can recognize.
