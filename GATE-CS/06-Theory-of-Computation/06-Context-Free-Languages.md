# 06 - Context-Free Languages (CFL)

## GATE CSE - Theory of Computation

---

# 1. What is a Context-Free Language?

A language L is Context-Free if there exists a
Context-Free Grammar (CFG) G such that:

L = L(G)

Equivalent machine characterization:

L is CFL
⇔
Some PDA recognizes L.

Therefore:

CFG ⇔ PDA ⇔ CFL

---

# 2. Position in Chomsky Hierarchy

Regular Languages
        ⊂
Context-Free Languages
        ⊂
Context-Sensitive Languages
        ⊂
Recursively Enumerable Languages

Machines:

Finite Automaton
        ↓
Pushdown Automaton
        ↓
Linear Bounded Automaton
        ↓
Turing Machine

---

# 3. Most Important Inclusion

Every Regular Language is Context-Free.

Therefore:

REG ⊂ CFL

But:

Every CFL is NOT Regular.

Classic example:

L = {aⁿbⁿ | n ≥ 0}

is:

CFL = YES
Regular = NO

---

# 4. How to Identify a CFL?

A language is often CFL when a single stack
can maintain the required relationship.

Examples:

{aⁿbⁿ}

{aⁿb²ⁿ}

{wwᴿ}

Palindromes

But:

{aⁿbⁿcⁿ}

requires more independent counting
than a single stack can generally provide.

---

# 5. Important CFL Examples

## Example 1

L = {aⁿbⁿ | n ≥ 0}

CFL.

CFG:

S → aSb | ε

---

## Example 2

L = {aⁿb²ⁿ | n ≥ 0}

CFL.

CFG:

S → aSbb | ε

---

## Example 3

L = {a²ⁿbⁿ | n ≥ 0}

CFL.

CFG:

S → aaSb | ε

---

## Example 4

L = {wwᴿ | w ∈ {0,1}*}

CFL.

A PDA can push the first half
and pop while reading the reverse half.

---

# 6. Important NON-CFL Examples

## aⁿbⁿcⁿ

NOT CFL.

---

## ww

NOT CFL.

---

## {aⁿbⁿcⁿdⁿ}

NOT CFL.

---

## {ww | w ∈ {0,1}*}

NOT CFL.

---

# 7. Why aⁿbⁿcⁿ is Not CFL?

A PDA has one stack.

To recognize:

aⁿbⁿcⁿ

it would need to simultaneously preserve
two independent equality relationships:

#a = #b

and

#b = #c

A single stack cannot generally maintain both
relationships in the required manner.

Formal proof can be done using:

- CFL pumping lemma
- Ogden's lemma
- Closure properties

---

# 8. CFL Closure Properties

CFLs are CLOSED under:

1. Union
2. Concatenation
3. Kleene star

CFLs are NOT generally closed under:

1. Intersection
2. Complement
3. Difference

---

# 9. Very Important Special Property

Although CFLs are not closed under
intersection with CFLs:

CFL ∩ REGULAR = CFL

This is extremely important for GATE.

If:

L is CFL
R is Regular

then:

L ∩ R

is definitely CFL.

---

# 10. Why This Matters

Suppose we want to prove:

L is NOT CFL.

Assume:

L is CFL.

Choose a suitable regular language R.

Then:

L ∩ R

must be CFL.

If the intersection simplifies to a known
non-CFL language:

contradiction.

Therefore:

L is NOT CFL.

---

# 11. Closure-Based Proof Example

Suppose:

L = {aⁱbʲcᵏ | i=j OR j=k}

We want to show something about L.

A useful strategy is to intersect with a regular language
that forces one of the relationships.

The key GATE idea:

Use a REGULAR language as a filter.

---

# 12. CFL Pumping Lemma

The CFL pumping lemma is used to prove that
a language is NOT context-free.

If L is CFL, then there exists a pumping length p
such that every string z ∈ L with:

|z| ≥ p

can be written as:

z = uvwxy

such that:

1. |vwx| ≤ p
2. |vx| > 0
3. uvⁱwxⁱy ∈ L for every i ≥ 0

---

# 13. CFL Pumping Lemma

MEMORIZE:

z = uvwxy

Conditions:

|vwx| ≤ p

|vx| > 0

uvⁱwxⁱy ∈ L

for all i ≥ 0.

---

# 14. Regular vs CFL Pumping Lemma

## Regular

w = xyz

Pumping:

y

Condition:

|xy| ≤ p

---

## CFL

z = uvwxy

Pumping:

v and x

Condition:

|vwx| ≤ p

---

# 15. Most Important Difference

Regular pumping:

ONE pumped section:

y

CFL pumping:

TWO pumped sections:

v and x

They must be pumped together.

---

# 16. CFL Pumping Lemma Trick

The condition:

|vwx| ≤ p

means vwx is a short window.

If we choose a string with large blocks:

aaaa...bbbb...cccc...

then vwx cannot cover all three blocks.

This lets us analyze where v and x can occur.

---

# 17. Classic Proof: aⁿbⁿcⁿ

Assume:

L = {aⁿbⁿcⁿ}

is CFL.

Let pumping length be p.

Choose:

z = aᵖbᵖcᵖ

Since:

|vwx| ≤ p

the substring vwx can lie:

- entirely within a's
- entirely within b's
- entirely within c's
- across a/b boundary
- across b/c boundary

It cannot cover both boundaries.

---

# 18. Pumping Case

Suppose v and x affect only a's and b's.

Pump:

i = 0

or:

i = 2

The number of a's, b's and c's
will no longer all be equal.

Therefore:

uvⁱwxⁱy ∉ L

Contradiction.

Hence:

{aⁿbⁿcⁿ}

is NOT CFL.

---

# 19. GATE CFL Pumping Strategy

When proving non-CFL:

### Step 1

Assume L is CFL.

### Step 2

Choose pumping length p.

### Step 3

Choose a carefully designed string of length ≥ p.

### Step 4

Use:

|vwx| ≤ p

### Step 5

Classify possible positions of vwx.

### Step 6

Pump:

i = 0 or 2.

### Step 7

Show pumped string violates the language condition.

---

# 20. Important Quantifier Trap

You do NOT choose the decomposition
to make your proof easy.

The lemma says:

There exists a decomposition satisfying
the conditions.

To prove non-CFL, you must show that
EVERY valid decomposition fails for
some pumping value.

---

# 21. CFL Pumping Lemma Does NOT Prove CFL

If a language satisfies the CFL pumping lemma:

you cannot automatically conclude it is CFL.

The lemma is necessary, not sufficient.

---

# 22. Ogden's Lemma

Ogden's lemma is a stronger tool than
the ordinary CFL pumping lemma.

It allows us to mark positions in a string
before applying the pumping argument.

For GATE:

Know the purpose and basic idea.

Detailed proof techniques are usually
less important than recognizing when
pumping/closure should be used.

---

# 23. Ambiguity and CFL

A CFG can be ambiguous.

But:

Ambiguous grammar ≠ inherently ambiguous language.

A language is inherently ambiguous if
EVERY CFG generating it is ambiguous.

---

# 24. Deterministic CFL

DCFL = Deterministic Context-Free Language.

Recognized by:

DPDA.

Relationship:

DCFL ⊂ CFL

---

# 25. Important Difference

Every DCFL is CFL.

But every CFL is NOT DCFL.

Therefore:

DPDA is less powerful than NPDA.

---

# 26. CFL and Regular Language Intersection

Very important theorem:

CFL ∩ REGULAR = CFL

This is often used in proofs.

---

# 27. CFL and Complement

CFLs are NOT closed under complement.

Important contrast:

Regular languages:

Complement → CLOSED

CFL:

Complement → NOT CLOSED

---

# 28. CFL and Difference

CFLs are not generally closed under difference.

However:

CFL - REGULAR

is CFL.

Why?

L - R = L ∩ R̅

Since:

R̅ is regular

and:

CFL ∩ Regular = CFL.

---

# 29. CFL and Reversal

CFLs ARE closed under reversal.

If L is CFL:

Lᴿ is also CFL.

---

# 30. CFL Closure Table

| Operation | CFL |
|---|---|
| Union | CLOSED |
| Concatenation | CLOSED |
| Kleene Star | CLOSED |
| Reversal | CLOSED |
| Intersection | NOT generally closed |
| Complement | NOT generally closed |
| Difference | NOT generally closed |

Special:

CFL ∩ REGULAR = CFL

---

# 31. GATE Trap

Question:

L1 and L2 are CFL.
Is:

L1 ∩ L2

necessarily CFL?

NO.

---

# 32. Counterexample for CFL Intersection

Take:

L1 = {aⁱbⁱcʲ | i,j ≥ 0}

L2 = {aⁱbʲcʲ | i,j ≥ 0}

Both can be shown to be CFL.

Their intersection is:

L1 ∩ L2

= {aⁿbⁿcⁿ | n ≥ 0}

which is NOT CFL.

Therefore CFLs are not closed under intersection.

---

# 33. GATE Closure Trick

If the question says:

"L1 and L2 are CFL."

Do NOT automatically apply
regular-language closure rules.

Always check the CFL table.

---

# 34. CFL vs Regular

| Property | Regular | CFL |
|---|---|---|
| DFA | YES | Not all |
| NFA | YES | Not all |
| PDA | YES | YES |
| CFG | YES | YES |
| Union | Closed | Closed |
| Intersection | Closed | Not generally |
| Complement | Closed | Not generally |
| Concatenation | Closed | Closed |
| Star | Closed | Closed |
| Reversal | Closed | Closed |

---

# 35. Standard Language Classification

## L = {aⁿbⁿ}

Regular?

NO

CFL?

YES

---

## L = {aⁿbⁿcⁿ}

Regular?

NO

CFL?

NO

---

## L = {aⁿbᵐ}

Regular?

YES

CFL?

YES

---

## L = {wwᴿ}

Regular?

NO

CFL?

YES

---

## L = {ww}

Regular?

NO

CFL?

NO

---

# 36. GATE Trick: Count the Dependencies

Ask:

"How many independent relationships
must be remembered?"

One stack can handle certain nested/
matching relationships.

Multiple independent equalities often
indicate a non-CFL language.

---

# 37. Example

L = {aⁱbʲcᵏ | i=j}

Only relationship:

#a = #b

No constraint on c.

CFL.

A PDA can push for a's and pop for b's,
then ignore c's.

---

# 38. Example

L = {aⁱbʲcᵏ | j=k}

CFL.

Ignore a's.

Push b's.

Pop for c's.

---

# 39. Example

L = {aⁱbʲcᵏ | i=k}

This can also be CFL because
the PDA can store the a-count and
compare against c's, while b's
can be handled appropriately depending
on the ordering.

---

# 40. Example

L = {aⁱbʲcᵏ | i=j=k}

NOT CFL.

Three-way equality.

---

# 41. Example

L = {aⁱbʲcᵏ | i=j OR j=k}

This is CFL because:

L1 = {aⁱbⁱcᵏ}

is CFL,

L2 = {aⁱbʲcʲ}

is CFL,

and:

L = L1 ∪ L2

CFLs are closed under union.

---

# 42. Example

L = {aⁱbʲcᵏ | i=j AND j=k}

Equivalent to:

{aⁿbⁿcⁿ}

NOT CFL.

### Trick

OR is often easier than AND.

CFLs are closed under union,
but not general intersection.

---

# 43. CFL Pumping Lemma Boundary Trick

For:

aᵖbᵖcᵖ

because:

|vwx| ≤ p,

vwx cannot contain symbols from
all three blocks.

Therefore at least one block is
unaffected by pumping.

This is the key observation.

---

# 44. GATE PYQ PATTERN 1

Question:

Which language is CFL?

Look for:

- One matching relationship
- Palindrome/reversal structure
- Nested structure
- Context-free grammar possibility

Classic:

{aⁿbⁿ}

is CFL.

---

# 45. GATE PYQ PATTERN 2

Question:

Which language is NOT CFL?

Classic:

{aⁿbⁿcⁿ}

Answer:

NOT CFL.

---

# 46. GATE PYQ PATTERN 3

Question:

L1 and L2 are CFL.
What can be said about:

L1 ∪ L2?

Answer:

CFL.

---

# 47. GATE PYQ PATTERN 4

Question:

L1 and L2 are CFL.
What about:

L1 ∩ L2?

Answer:

Not necessarily CFL.

---

# 48. GATE PYQ PATTERN 5

Question:

L is CFL and R is regular.
What about:

L ∩ R?

Answer:

CFL.

---

# 49. GATE PYQ PATTERN 6

Question:

L is CFL.
What about:

Lᴿ?

Answer:

CFL.

---

# 50. GATE PYQ PATTERN 7

Question:

L is CFL.
What about:

L̅?

Answer:

Not necessarily CFL.

---

# 51. GATE PYQ PATTERN 8

Question:

A language satisfies CFL pumping lemma.
Is it necessarily CFL?

NO.

Necessary ≠ sufficient.

---

# 52. GATE PYQ PATTERN 9

Question:

Which machine recognizes all CFLs?

Answer:

NPDA.

Not DPDA.

---

# 53. GATE PYQ PATTERN 10

Question:

Which grammar can generate aⁿbⁿ?

Answer:

S → aSb | ε

---

# 54. GATE PYQ PATTERN 11

Question:

Which language is both regular and CFL?

EVERY regular language.

Because:

REG ⊂ CFL.

---

# 55. GATE PYQ PATTERN 12

Question:

Is every CFL regular?

NO.

Counterexample:

{aⁿbⁿ}

---

# 56. GATE PYQ PATTERN 13

Question:

Can a PDA recognize a regular language?

YES.

A PDA can ignore its stack.

---

# 57. GATE PYQ PATTERN 14

Question:

Can a DFA recognize every CFL?

NO.

DFA recognizes only regular languages.

---

# 58. GATE PYQ PATTERN 15

Question:

Which is more powerful:

DPDA or NPDA?

NPDA.

---

# 59. Advanced Trick: CFL ∩ Regular

Suppose:

L = {aⁿbⁿcᵐ}

and:

R = a*b*

Then:

L ∩ R

removes strings containing c's.

Therefore:

L ∩ R = {aⁿbⁿ}

which is CFL.

This illustrates why intersection with
a regular language is safe.

---

# 60. Advanced Trick: Proving NOT CFL

Use one of:

1. CFL pumping lemma
2. Closure properties
3. Ogden's lemma

For GATE, first try closure properties.

If a simple regular filter produces
a known non-CFL language,
that is often the fastest proof.

---

# 61. Known Non-CFL Languages

Memorize:

{aⁿbⁿcⁿ}

{ww | w ∈ {0,1}*}

{aⁿ | n is prime}

{aⁿbⁿcⁿdⁿ}

and many languages requiring
multiple independent comparisons.

---

# 62. Important Caution

Do not memorize:

"Three symbols = non-CFL."

This is WRONG.

Example:

a*b*c*

is regular and therefore CFL.

The problem is the RELATIONSHIP,
not the number of symbols.

---

# 63. Important Caution

Do not memorize:

"Counting = non-CFL."

For example:

{aⁿ | n is even}

is regular.

{aⁿ | n is divisible by 5}

is regular.

The problem is usually
unbounded equality/matching.

---

# 64. GATE Language-Recognition Strategy

When given a language:

### Step 1

Check if it is obviously regular.

Look for:

- fixed patterns
- modulo
- finite counting
- regular expression

If yes:

REGULAR → automatically CFL.

### Step 2

If not regular:

Check whether one stack can handle
the relationship.

If yes:

likely CFL.

### Step 3

If multiple independent equalities exist:

suspect non-CFL.

### Step 4

Use closure/pumping lemma to prove it.

---

# 65. Super High-Yield Table

| Language | Regular | CFL |
|---|---:|---:|
| a* | YES | YES |
| a*b* | YES | YES |
| aⁿbⁿ | NO | YES |
| aⁿbⁿcⁿ | NO | NO |
| ww | NO | NO |
| wwᴿ | NO | YES |
| Palindrome | NO | YES |
| aⁿbⁿc* | NO | YES |
| a*b*c* | YES | YES |
| Even number of a's | YES | YES |

---

# 66. 30-SECOND REVISION

CFL:

CFG ⇔ PDA

Regular ⊂ CFL.

CFL closed under:

Union
Concatenation
Star
Reversal

NOT generally closed under:

Intersection
Complement
Difference

But:

CFL ∩ Regular = CFL.

CFL pumping lemma:

z = uvwxy

|vwx| ≤ p

|vx| > 0

uvⁱwxⁱy ∈ L

for all i ≥ 0.

aⁿbⁿ:

CFL.

aⁿbⁿcⁿ:

NOT CFL.

ww:

NOT CFL.

wwᴿ:

CFL.

DPDA:

DCFL.

NPDA:

CFL.

---

# 67. FINAL GATE CHECKLIST

[ ] Definition of CFL
[ ] CFG ↔ PDA
[ ] Regular ⊂ CFL
[ ] CFL examples
[ ] Non-CFL examples
[ ] CFL closure properties
[ ] CFL ∩ Regular
[ ] CFL pumping lemma
[ ] Pumping lemma quantifiers
[ ] aⁿbⁿcⁿ proof
[ ] Closure-based non-CFL proofs
[ ] Ogden's lemma concept
[ ] DCFL
[ ] DPDA vs NPDA
[ ] ww vs wwᴿ
[ ] Standard CFL constructions
[ ] Language classification
[ ] GATE closure questions
[ ] GATE pumping questions
[ ] GATE language-identification questions

---

# 68. FINAL GATE MEMORY TRICKS

### Regular

FINITE MEMORY.

### CFL

ONE STACK.

### aⁿbⁿ

ONE equality → CFL.

### aⁿbⁿcⁿ

THREE equal counts → NOT CFL.

### wwᴿ

STACK FRIENDLY.

### ww

STACK UNFRIENDLY.

### CFL Union

YES.

### CFL Intersection

NOT GENERALLY.

### CFL ∩ Regular

YES.

### CFL Complement

NOT GENERALLY.

### CFL Reversal

YES.

### CFL Pumping

uvⁱwxⁱy.

### Regular Pumping

xyⁱz.
