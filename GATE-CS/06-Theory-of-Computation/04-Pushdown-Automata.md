# 04 - Pushdown Automata (PDA)

## GATE CSE - Theory of Computation

---

# 1. What is a Pushdown Automaton?

A Pushdown Automaton (PDA) is a finite automaton
with an additional memory structure called a STACK.

PDA = FA + Stack

The stack gives PDA more memory than a finite automaton.

---

# 2. Why Do We Need PDA?

Finite Automata cannot recognize languages such as:

L = {aⁿbⁿ | n ≥ 0}

because a finite automaton cannot remember an arbitrary
number of a's.

A PDA can:

1. Push one symbol for every a.
2. Pop one symbol for every b.
3. Accept if the stack matches correctly.

---

# 3. PDA and CFG

Extremely important GATE relationship:

CFG ↔ PDA

A language is Context-Free iff it can be recognized
by some PDA.

Therefore:

Regular Languages ⊂ Context-Free Languages

FA recognizes Regular Languages.

PDA recognizes Context-Free Languages.

---

# 4. Formal Definition

A PDA is usually represented as:

M = (Q, Σ, Γ, δ, q0, Z0, F)

Where:

Q  = set of states
Σ  = input alphabet
Γ  = stack alphabet
δ  = transition function
q0 = initial state
Z0 = initial stack symbol
F  = final states

---

# 5. PDA Transition Function

For a nondeterministic PDA:

δ : Q × (Σ ∪ {ε}) × Γ
    → finite subsets of Q × Γ*

Meaning:

The transition depends on:

1. Current state
2. Current input symbol OR ε
3. Top stack symbol

---

# 6. PDA Transition Meaning

A transition:

δ(q, a, X) contains (p, γ)

means:

Current state = q
Input = a
Stack top = X

Then:

- consume a
- replace X with γ
- move to state p

---

# 7. Stack Operations

A PDA mainly performs:

### Push

Add symbols to stack.

### Pop

Remove the top symbol.

### Replace

Replace the top symbol with another sequence.

---

# 8. Important Stack Rule

Stack follows:

LIFO

Last In → First Out.

Therefore:

The most recently pushed symbol
is the first one popped.

---

# 9. PDA for aⁿbⁿ

Language:

L = {aⁿbⁿ | n ≥ 0}

Basic idea:

For every a:

PUSH A

For every b:

POP A

Example:

Input:

aaabbb

Stack:

After a:
A

After aa:
AA

After aaa:
AAA

Then b's remove them:

AA
A
ε

Accept.

---

# 10. GATE Trick

Whenever you see:

"equal number of something before and after something"

think:

PUSH → process first part
POP → process second part

Example:

aⁿbⁿ

a → push
b → pop

---

# 11. PDA for aⁿbᵐ

No equality requirement.

This is regular:

a*b*

Therefore:

A PDA is possible,
but a simple DFA is sufficient.

---

# 12. PDA for aⁿbⁿcⁿ

NOT context-free.

Therefore:

No PDA can recognize:

{aⁿbⁿcⁿ | n ≥ 0}

This is an important GATE question.

---

# 13. Why PDA Cannot Handle aⁿbⁿcⁿ?

A single stack cannot independently remember
both:

number of a's
and
number of b's

while also checking the number of c's.

Therefore:

{aⁿbⁿcⁿ}

is not CFL.

---

# 14. PDA for Palindromes

A PDA can recognize:

L = {wwᴿ | w ∈ Σ*}

Idea:

1. Push first half.
2. Guess the middle.
3. Pop while reading the second half.

The nondeterminism allows the PDA to guess
where the middle occurs.

---

# 15. Why Nondeterminism Helps?

For a palindrome:

There may be no delimiter indicating
where the first half ends.

An NPDA can guess the middle.

Example:

abba

Push:

a
b

Guess middle.

Then pop:

b
a

Stack becomes empty.

---

# 16. PDA for wcwᴿ

Language:

L = {wcwᴿ | w ∈ Σ*}

This is easier because c explicitly marks
the middle.

Before c:

push symbols.

After c:

pop matching symbols.

---

# 17. Acceptance Methods

A PDA can accept a language by:

1. Final state
2. Empty stack

These are equivalent in expressive power for NPDA.

---

# 18. Acceptance by Final State

Input is completely consumed and
PDA reaches a final state.

Stack contents may still exist.

Important:

EMPTY STACK IS NOT REQUIRED.

---

# 19. Acceptance by Empty Stack

Input is completely consumed and
stack becomes empty.

Final state is not necessarily required.

---

# 20. GATE Trap

Do NOT assume:

acceptance by final state = stack must be empty.

Wrong.

For final-state acceptance,
the stack can contain symbols.

---

# 21. Equivalence

For nondeterministic PDA:

Acceptance by empty stack
and
acceptance by final state

have the same expressive power.

Both recognize exactly CFLs.

---

# 22. Instantaneous Description (ID)

An instantaneous description represents
the current configuration of a PDA.

Common notation:

(q, w, α)

Where:

q = current state
w = remaining input
α = stack contents

---

# 23. Example ID

(q0, aabb, Z0)

means:

Current state = q0
Remaining input = aabb
Stack = Z0

---

# 24. PDA Computation

Example:

(q0, aaabbb, Z0)

After reading first a:

(q0, aabbb, AZ0)

After second a:

(q0, abbb, AAZ0)

After third a:

(q0, bbb, AAAZ0)

Then pop for every b.

---

# 25. GATE ID Trick

When tracing PDA:

Always track THREE things:

1. State
2. Remaining input
3. Stack

Never track only the stack.

---

# 26. Deterministic PDA (DPDA)

A DPDA has at most one valid transition
for a given configuration.

DPDA is less powerful than NPDA.

---

# 27. DPDA vs NPDA

| Feature | DPDA | NPDA |
|---|---|---|
| Deterministic | Yes | No |
| Nondeterministic choice | No | Yes |
| Recognizes all CFLs? | No | Yes |
| Expressive power | Less | More |

---

# 28. Important Result

Every language recognized by a DPDA is CFL.

But:

Not every CFL can be recognized by a DPDA.

---

# 29. DCFL

DCFL = Deterministic Context-Free Language.

These are languages recognized by DPDAs.

Important:

DCFL ⊂ CFL

---

# 30. Example of CFL That is Not DCFL

A classic example is:

{wwᴿ | w ∈ {0,1}*}

without a middle marker.

The PDA needs to guess where the middle is.

A deterministic PDA cannot generally do this.

---

# 31. DPDA Example

Language:

L = {0ⁿ1ⁿ | n ≥ 0}

can be recognized by a DPDA.

Because the boundary between 0's and 1's
is clear from the input symbols.

---

# 32. PDA Transition Priority

A transition may consume:

- input symbol
OR
- ε

This means PDA may change its state/stack
without consuming input.

---

# 33. ε-Transition

Example:

δ(q, ε, Z)

means:

The PDA can perform the transition without
reading an input symbol.

---

# 34. GATE Trap

ε-transition does NOT mean:

"push ε into the stack."

It means:

"consume no input."

The stack replacement is specified separately.

---

# 35. PDA Stack Direction

Always identify which side represents
the TOP of the stack.

Different textbooks use different notation.

For GATE questions:

Follow the stated transition convention.

---

# 36. PDA Construction Strategy

When constructing a PDA:

### Step 1

Identify what must be remembered.

### Step 2

Push that information onto stack.

### Step 3

Find the point where comparison begins.

### Step 4

Pop while matching.

### Step 5

Define acceptance condition.

---

# 37. Pattern: aⁿbⁿ

First section:

a's

Memory:

count of a's

Operation:

push

Second section:

b's

Operation:

pop

---

# 38. Pattern: aⁿb²ⁿ

For each a:

push TWO symbols.

For each b:

pop ONE symbol.

Then:

#b = 2#a

---

# 39. Pattern: a²ⁿbⁿ

For each a:

push one symbol for every TWO a's.

For every b:

pop one symbol.

Then:

#a = 2#b

---

# 40. Pattern: Equal Number of a and b in Arbitrary Order

Language:

L = {w | #a(w) = #b(w)}

A PDA can recognize this language.

Idea:

Use the stack to cancel unmatched symbols.

For example:

Read a → if top contains unmatched b, pop;
otherwise push a.

Read b → if top contains unmatched a, pop;
otherwise push b.

At the end:

empty stack → equal counts.

---

# 41. Important Caveat

The stack-cancellation idea works for
equal counts of two symbols.

Do not generalize it blindly to:

#a = #b = #c

because that language is not CFL in general
when arbitrary ordering constraints are involved.

---

# 42. PDA and Regular Languages

Every regular language is context-free.

Therefore:

Every regular language can be recognized by a PDA.

A PDA can simply ignore its stack and behave
like a finite automaton.

---

# 43. GATE Trick

If a language is regular:

It is automatically CFL.

Therefore:

Regular ⊂ CFL.

But the reverse is false.

---

# 44. CFG → PDA

Every CFG can be converted into a PDA.

Basic idea:

1. Put start variable S on stack.
2. Replace variables using productions.
3. Match terminals against input.
4. Pop matching terminals.

---

# 45. PDA → CFG

Every PDA can be converted into a CFG.

Therefore:

CFG and PDA have equivalent expressive power.

---

# 46. PDA vs FA

| Property | FA | PDA |
|---|---|---|
| Memory | Finite states | Stack |
| Regular languages | Yes | Yes |
| aⁿbⁿ | No | Yes |
| aⁿbⁿcⁿ | No | No |
| Palindromes | Limited cases | Yes |
| CFL | No | Yes |

---

# 47. PDA vs Turing Machine

PDA:

One stack.

Turing Machine:

Unbounded read/write tape.

Therefore:

TM is strictly more powerful.

---

# 48. Language Hierarchy

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

# 49. GATE PYQ PATTERN 1

Question:

Which machine recognizes:

L = {aⁿbⁿ | n ≥ 0}?

Answer:

PDA.

Why?

It needs unbounded memory to remember
the number of a's.

---

# 50. GATE PYQ PATTERN 2

Question:

Can a PDA recognize:

{aⁿbⁿcⁿ | n ≥ 0}?

Answer:

NO.

The language is not context-free.

---

# 51. GATE PYQ PATTERN 3

Question:

Which acceptance methods can an NPDA use?

Answer:

- Final state
- Empty stack

Both have equivalent expressive power.

---

# 52. GATE PYQ PATTERN 4

Question:

Does acceptance by final state require
empty stack?

Answer:

NO.

Only input consumption + final state matters.

---

# 53. GATE PYQ PATTERN 5

Question:

Which is more powerful:

DPDA or NPDA?

Answer:

NPDA.

NPDA recognizes all CFLs.

DPDA recognizes only DCFLs.

---

# 54. GATE PYQ PATTERN 6

Question:

Can every regular language be recognized
by a PDA?

YES.

The PDA can simply ignore its stack.

---

# 55. GATE PYQ PATTERN 7

Question:

Can every CFL be recognized by a DFA?

NO.

Example:

{aⁿbⁿ | n ≥ 0}

is CFL but not regular.

---

# 56. GATE PYQ PATTERN 8

Question:

What does:

δ(q, a, X) = {(p, YZ)}

mean?

Answer:

Current:

state q
input a
stack top X

After transition:

state p
input a consumed
X replaced by YZ

---

# 57. GATE PYQ PATTERN 9

Question:

What does:

δ(q, ε, X)

represent?

Answer:

A transition that does not consume
an input symbol.

It may still modify the stack.

---

# 58. GATE PYQ PATTERN 10

Question:

What is the ID:

(q, w, α)?

Answer:

q = current state
w = remaining input
α = current stack contents

---

# 59. PDA Construction Trick

When the language has:

### Equal quantities

Use push/pop.

### Reverse relationship

Use stack.

### Middle delimiter

Use delimiter to switch from push → pop.

### Unknown middle

Nondeterministically guess the middle.

### Three independent equal counts

Be suspicious:
likely not CFL.

---

# 60. Important Language Patterns

## aⁿbⁿ

CFL.

PDA possible.

---

## aⁿb²ⁿ

CFL.

PDA possible.

---

## a²ⁿbⁿ

CFL.

PDA possible.

---

## wwᴿ

CFL.

NPDA possible.

---

## wcwᴿ

CFL.

PDA possible.

---

## aⁿbⁿcⁿ

NOT CFL.

---

## ww

NOT CFL in general.

---

# 61. GATE Trap: ww vs wwᴿ

Very important.

### wwᴿ

Example:

0110

First half:

01

Second half:

10

Second half = reverse(first half).

CFL.

---

### ww

Example:

0101

Second half is exactly first half.

This language is NOT CFL in general.

---

# 62. GATE Trap: PDA Does NOT Mean "Any Counting"

A PDA can handle some counting relationships.

Example:

aⁿbⁿ

But not arbitrary multiple independent counts.

Example:

aⁿbⁿcⁿ

NOT CFL.

---

# 63. PDA Design for aⁿbⁿ

Typical states:

q0 = reading a's
q1 = reading b's
qf = accept

q0:

read a → push A

Then transition to q1.

q1:

read b + A → pop A

When input ends and stack reaches
bottom marker:

accept.

---

# 64. GATE Transition Trick

For a transition:

δ(q, a, A)

always read it as:

Current state
+
input being consumed
+
stack TOP

→

Next state
+
stack replacement

This avoids most PDA transition mistakes.

---

# 65. Empty Stack Acceptance

Suppose initial stack:

Z0

For acceptance by empty stack:

Eventually:

Z0 must also be removed.

Do not confuse:

"only A symbols removed"

with:

"stack is completely empty."

---

# 66. Final-State Acceptance

For final-state acceptance:

The PDA may reach:

(qf, ε, AZ0)

and still accept if qf is final.

The stack need NOT be empty.

---

# 67. GATE High-Yield Comparison

| Machine | Language Class |
|---|---|
| DFA | Regular |
| NFA | Regular |
| ε-NFA | Regular |
| DPDA | DCFL |
| NPDA | CFL |
| LBA | CSL |
| TM | RE |

---

# 68. Most Important Results

1. DFA = NFA = ε-NFA
2. NPDA = CFG
3. DPDA ⊂ NPDA
4. Regular ⊂ CFL
5. aⁿbⁿ is CFL but not regular
6. aⁿbⁿcⁿ is not CFL
7. NPDA final-state and empty-stack acceptance are equivalent
8. PDA has stack memory
9. PDA is more powerful than FA
10. TM is more powerful than PDA

---

# 69. Common GATE Mistakes

## Mistake 1

PDA can recognize aⁿbⁿcⁿ.

WRONG.

---

## Mistake 2

Final-state acceptance requires empty stack.

WRONG.

---

## Mistake 3

DPDA and NPDA have equal power.

WRONG.

NPDA is more powerful.

---

## Mistake 4

ε-transition consumes ε as a symbol.

WRONG.

It consumes no input.

---

## Mistake 5

ww is CFL because PDA can push w and compare.

WRONG.

A single stack cannot generally compare two
identical halves in the required order.

wwᴿ is the natural stack-friendly pattern.

---

# 70. LAST-MINUTE REVISION

PDA:

FA + Stack

Formal:

(Q,Σ,Γ,δ,q0,Z0,F)

Transition depends on:

state + input + stack top.

Stack:

LIFO.

aⁿbⁿ:

push a's → pop for b's.

NPDA:

all CFLs.

DPDA:

only DCFLs.

Acceptance:

final state OR empty stack.

For NPDA:

both have equivalent power.

CFG ↔ NPDA.

Regular ⊂ CFL.

aⁿbⁿ:

CFL.

aⁿbⁿcⁿ:

not CFL.

wwᴿ:

CFL.

ww:

not CFL.

---

# 71. GATE EXAM CHECKLIST

[ ] PDA definition
[ ] PDA transition function
[ ] Stack operations
[ ] Push/pop
[ ] ε-transition
[ ] Instantaneous description
[ ] PDA for aⁿbⁿ
[ ] PDA for aⁿb²ⁿ
[ ] PDA for palindromes
[ ] PDA for wcwᴿ
[ ] Final-state acceptance
[ ] Empty-stack acceptance
[ ] Equivalence of acceptance methods
[ ] DPDA
[ ] NPDA
[ ] DCFL
[ ] CFG ↔ PDA
[ ] PDA ↔ CFL
[ ] aⁿbⁿcⁿ
[ ] ww vs wwᴿ
[ ] GATE transition questions
[ ] GATE ID questions
[ ] GATE language-classification questions

---

# 72. 30-SECOND GATE TRICKS

Equal count:

PUSH → POP

Reverse:

STACK

Known middle:

delimiter switches PUSH → POP

Unknown middle:

NPDA guesses middle

Three equal blocks:

aⁿbⁿcⁿ → NOT CFL

Same half:

ww → NOT CFL

Reverse half:

wwᴿ → CFL

NPDA:

CFL

DPDA:

DCFL

Final state:

stack need not be empty

Empty stack:

final state need not be final
