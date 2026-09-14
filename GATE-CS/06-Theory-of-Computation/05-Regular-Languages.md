# 05 - Regular Languages

## GATE CSE - Theory of Computation

---

# 1. What is a Regular Language?

A language is called Regular if it can be represented by:

1. Regular Expression (RE)
2. DFA
3. NFA
4. ε-NFA
5. Regular Grammar

Therefore:

RE ⇔ DFA ⇔ NFA ⇔ Regular Grammar

All have exactly the same expressive power.

---

# 2. Formal Definition

A language L is regular if there exists a finite automaton M such that:

L = L(M)

Equivalently, there exists a regular expression R such that:

L = L(R)

---

# 3. Regular Language Examples

## Example 1

L = {0,1}*

Regular.

It contains every binary string.

RE:

(0+1)*

---

## Example 2

L = {0ⁿ1ᵐ | n,m ≥ 0}

Regular.

RE:

0*1*

---

## Example 3

L = {0ⁿ1ⁿ | n ≥ 0}

NOT regular.

This requires remembering an arbitrary number of 0s.

---

# 4. Most Important GATE Idea

Ask:

"Does the language require unbounded memory?"

If YES:

It may be non-regular.

If a finite amount of information is enough:

It is likely regular.

---

# 5. Finite Automaton Memory

A DFA has only a finite number of states.

Therefore it can remember only a finite amount of information.

It can remember:

- parity
- modulo
- fixed-length suffix
- fixed-length prefix
- whether a fixed substring occurred

But it cannot remember:

- arbitrary equal counts
- arbitrary matching numbers
- arbitrary nesting

---

# 6. Classic Regular Languages

## Even number of 1s

Regular.

Only need:

Even / Odd

2 states.

---

## Number of 1s divisible by 5

Regular.

Need to remember:

0,1,2,3,4 mod 5

5 states.

---

## Strings ending in 101

Regular.

Only a finite suffix needs to be remembered.

---

## Strings containing 101

Regular.

Once 101 is found, remember that fact permanently.

---

# 7. Classic Non-Regular Languages

## aⁿbⁿ

NOT regular.

---

## aⁿbⁿcⁿ

NOT regular.

Also not context-free.

---

## ww

NOT regular.

---

## wwᴿ

It is context-free, but NOT regular.

---

# 8. Closure Properties of Regular Languages

This is one of the MOST IMPORTANT GATE topics.

If L1 and L2 are regular, then the following are also regular:

- Union
- Intersection
- Complement
- Difference
- Concatenation
- Kleene star
- Kleene plus
- Reversal

---

# 9. Union

If:

L1 and L2 are regular

then:

L1 ∪ L2

is regular.

Construction:

Use ε-NFA or product automaton.

---

# 10. Intersection

If:

L1 and L2 are regular

then:

L1 ∩ L2

is regular.

Use product DFA.

Number of possible product states:

|Q1| × |Q2|

---

# 11. Product DFA

Suppose:

DFA1 has n states
DFA2 has m states

Product DFA has at most:

n × m states.

A product state is:

(qi, qj)

---

# 12. Intersection Trick

For:

L1 ∩ L2

Accept only if:

q1 = final
AND
q2 = final.

Therefore:

AND → both final.

---

# 13. Union Trick

For:

L1 ∪ L2

Accept if:

q1 is final
OR
q2 is final.

Therefore:

OR → at least one final.

---

# 14. Difference

For:

L1 - L2

Accept when:

q1 is final
AND
q2 is NOT final.

---

# 15. Symmetric Difference

L1 Δ L2

means:

strings belonging to exactly one language.

Accept when:

one component is final
and the other is not.

This is XOR.

---

# 16. Complement

If L is regular:

L̅

is also regular.

For a COMPLETE DFA:

swap:

final ↔ non-final

---

# 17. GATE Complement Trap

You cannot blindly swap final/non-final states
if the DFA is incomplete.

First add a dead state.

Then swap final and non-final states.

---

# 18. Concatenation

If L1 and L2 are regular:

L1L2

is regular.

Construction:

NFA can be built by adding ε-transitions
from final states of L1 to start state of L2.

---

# 19. Kleene Star

If L is regular:

L*

is regular.

Construction:

Add a new start/final state and ε-transitions
to the original automaton.

---

# 20. Kleene Plus

L+ = LL*

Therefore:

If L is regular:

L+ is regular.

---

# 21. Reversal

If L is regular:

Lᴿ

is also regular.

Construction:

1. Reverse every transition.
2. Original start becomes final.
3. Create new start state.
4. Add ε-transition to original final states.

---

# 22. Homomorphism

Regular languages are closed under homomorphism.

If:

h : Σ* → Δ*

is a homomorphism

and L is regular,

then:

h(L)

is regular.

---

# 23. Inverse Homomorphism

Regular languages are also closed under
inverse homomorphism.

Therefore:

h⁻¹(L)

is regular if L is regular.

---

# 24. GATE Closure Property Table

| Operation | Regular Languages |
|---|---|
| Union | Closed |
| Intersection | Closed |
| Complement | Closed |
| Difference | Closed |
| Concatenation | Closed |
| Kleene Star | Closed |
| Kleene Plus | Closed |
| Reversal | Closed |
| Homomorphism | Closed |
| Inverse Homomorphism | Closed |

MEMORIZE THIS TABLE.

---

# 25. Important Contrast With CFL

Regular languages:

Intersection → CLOSED

CFL:

Intersection → NOT CLOSED in general.

This difference is frequently tested.

---

# 26. Regular Language and Complement

If:

L = strings containing 00

then:

L̅ = strings NOT containing 00.

Since regular languages are closed under complement:

L̅ is also regular.

---

# 27. Regular Language and Difference

If:

L1 and L2 are regular,

then:

L1 - L2

is regular.

Because:

L1 - L2 = L1 ∩ L̅2

Both operations preserve regularity.

---

# 28. Proving a Language is NOT Regular

Main GATE tools:

1. Pumping Lemma
2. Myhill-Nerode Theorem
3. Closure properties

---

# 29. Pumping Lemma

If L is regular, then there exists a pumping length p
such that every sufficiently long string w ∈ L can be written:

w = xyz

such that:

1. |xy| ≤ p
2. |y| > 0
3. xyⁱz ∈ L for every i ≥ 0

---

# 30. Pumping Lemma Conditions

MEMORIZE:

|xy| ≤ p

|y| > 0

xyⁱz ∈ L for all i ≥ 0

---

# 31. GATE Pumping Lemma Trick

The most important condition:

|xy| ≤ p

This tells us:

x and y occur inside the FIRST p symbols.

Choose the string so that this forces y
to have a predictable form.

---

# 32. Classic Example

L = {0ⁿ1ⁿ | n ≥ 0}

Assume L is regular.

Let pumping length = p.

Choose:

w = 0ᵖ1ᵖ

Since:

|xy| ≤ p

x and y are entirely inside the first block of 0s.

Therefore:

y = 0ᵏ

where k > 0.

Pump down:

i = 0

Then:

xz = 0ᵖ⁻ᵏ1ᵖ

Number of 0s ≠ number of 1s.

Therefore:

xz ∉ L

Contradiction.

Hence:

L is NOT regular.

---

# 33. Pumping Lemma Proof Structure

Always write:

### Step 1

Assume L is regular.

### Step 2

Let p be the pumping length.

### Step 3

Choose w ∈ L with |w| ≥ p.

### Step 4

Consider ANY valid decomposition:

w = xyz

satisfying:

|xy| ≤ p
|y| > 0

### Step 5

Determine y.

### Step 6

Choose a suitable i.

Usually:

i = 0

or:

i = 2

### Step 7

Show:

xyⁱz ∉ L

### Step 8

Contradiction.

Therefore L is not regular.

---

# 34. VERY IMPORTANT Quantifier Trick

Pumping lemma says:

There EXISTS a valid decomposition.

To disprove regularity, you must show:

For EVERY valid decomposition,

there exists some i such that
the pumped string is not in L.

---

# 35. Common Pumping Lemma Mistake

Wrong approach:

"I choose a convenient decomposition."

This is not sufficient.

The decomposition is chosen by the adversary.

You must handle every valid decomposition.

---

# 36. Another Classic Example

L = {0ⁿ1ⁿ2ⁿ | n ≥ 0}

Choose:

w = 0ᵖ1ᵖ2ᵖ

Since |xy| ≤ p:

y consists only of 0s.

Pump y:

number of 0s changes,
but number of 1s and 2s does not.

Therefore string leaves the language.

Hence non-regular.

---

# 37. Pumping Lemma Does NOT Prove Regularity

Very important:

If you cannot find a contradiction using
the pumping lemma,

you CANNOT conclude the language is regular.

Pumping lemma is mainly useful for proving:

NOT REGULAR.

---

# 38. Myhill-Nerode Theorem

A language L is regular iff it has
a FINITE number of equivalence classes
under the Myhill-Nerode relation.

Two strings x and y are equivalent if:

for every z:

xz ∈ L ⇔ yz ∈ L

---

# 39. Myhill-Nerode Intuition

Two prefixes are different if there is
some suffix that distinguishes them.

If infinitely many prefixes require
different future behavior:

Language is NOT regular.

---

# 40. Myhill-Nerode Example

L = {0ⁿ1ⁿ | n ≥ 0}

Consider prefixes:

ε
0
00
000
...

For any i ≠ j:

Choose suffix:

z = 1ⁱ

Then:

0ⁱ1ⁱ ∈ L

but:

0ʲ1ⁱ ∉ L

Therefore every 0ⁱ is distinguishable.

There are infinitely many equivalence classes.

Hence L is NOT regular.

---

# 41. GATE Myhill-Nerode Trick

To prove non-regularity:

Find infinitely many strings:

x1, x2, x3, ...

such that every pair is distinguishable.

For xi and xj:

find a suffix z such that:

xi z ∈ L

but:

xj z ∉ L

Then L is not regular.

---

# 42. Minimal DFA and Myhill-Nerode

Extremely important:

Number of states in the minimal DFA
equals the number of Myhill-Nerode equivalence classes.

Therefore:

Minimal DFA states
=
Number of distinguishable residual behaviors.

---

# 43. GATE State-Minimization Trick

If the question asks:

"What is the minimum number of DFA states?"

Think:

How many different kinds of prefixes
must the machine remember?

Each distinct future behavior needs
a different state.

---

# 44. Residual Language

For a string x:

x⁻¹L = {z | xz ∈ L}

This is the set of suffixes that can follow x
while remaining in L.

Two strings with the same residual behavior
can correspond to the same DFA state.

---

# 45. Infinite Residuals = Non-Regular

If a language has infinitely many distinct
left quotients/residual languages:

L is NOT regular.

---

# 46. Finite Languages

Every finite language is regular.

Example:

L = {ab, baa, 101}

Regular expression:

ab + baa + 101

---

# 47. Infinite Does NOT Mean Non-Regular

Examples:

a*

(0+1)*

0*1*

All are infinite regular languages.

---

# 48. GATE Trick

Never classify a language based only on:

"finite/infinite."

The correct question is:

"Does it require unbounded memory?"

---

# 49. Unary Languages

A unary alphabet contains one symbol.

Example:

Σ = {a}

Languages such as:

{a²ⁿ | n ≥ 0}

are regular.

A DFA only needs two states:

even / odd.

---

# 50. Unary Regular Language Trick

For a unary language:

eventually the DFA enters a cycle.

Therefore membership often becomes:

finite prefix + repeating cycle.

This is called:

Ultimately periodic behavior.

---

# 51. Important Theorem

Every regular language has a DFA.

Every DFA has finitely many states.

Therefore:

Regular languages have finite-state behavior.

---

# 52. Pumping Length and DFA States

If a DFA has n states,
then any string of length ≥ n
causes some state to repeat.

By the pigeonhole principle:

Among n+1 visited states,
at least two are the same.

Therefore a loop exists.

This is the basis of the pumping idea for regular languages.

---

# 53. DFA Loop Trick

If a DFA has n states and reads a string
of length ≥ n:

Some state repeats.

Therefore:

A cycle exists.

This can be useful for questions involving
long strings and repeated patterns.

---

# 54. Regular Language Equivalence

Two regular expressions are equivalent if:

L(R1) = L(R2)

To disprove equivalence:

Find one string accepted by one but not the other.

---

# 55. GATE Counterexample Trick

Suppose options are:

R1
R2
R3
R4

and question asks which is equivalent to R.

Do not prove all mathematically.

Test:

ε
short strings
boundary cases
strings that distinguish the expressions.

One counterexample eliminates an option.

---

# 56. DFA Equivalence

Two DFAs are equivalent if they accept
exactly the same language.

One method:

Construct product automaton and check
whether there exists a reachable pair
where exactly one component is final.

If such a pair exists:

NOT equivalent.

---

# 57. Regular Grammar

A right-linear grammar has productions such as:

A → aB
A → a
A → ε

A left-linear grammar can have:

A → Ba
A → a
A → ε

These generate regular languages.

---

# 58. GATE Trap

A general CFG is more powerful than
a regular grammar.

But:

Every regular grammar is a CFG.

Therefore:

Regular Grammar ⊂ CFG

in expressive power.

---

# 59. Important Hierarchy

Regular Languages
    ⊂
Context-Free Languages
    ⊂
Context-Sensitive Languages
    ⊂
Recursively Enumerable Languages

Machines:

FA
↓
PDA
↓
LBA
↓
TM

---

# 60. Closure-Based Non-Regularity Proof

Closure properties can simplify proofs.

Suppose you assume L is regular.

Apply an operation that preserves regularity
and obtain a known non-regular language.

Contradiction.

---

# 61. Example of Closure Trick

Suppose:

L = {strings with equal numbers of 0 and 1
     and all 0s before all 1s}

If L were regular,
intersect it with:

0*1*

This gives:

{0ⁿ1ⁿ | n ≥ 0}

which is non-regular.

Therefore the original language cannot be regular.

---

# 62. GATE Closure Trick

To prove L is NOT regular:

1. Assume L is regular.
2. Choose a known regular language R.
3. Compute L ∩ R.
4. Simplify.
5. If result is known non-regular:
   contradiction.

This is often easier than pumping lemma.

---

# 63. Known Non-Regular Languages

Memorize:

{aⁿbⁿ | n ≥ 0}

{aⁿbⁿcⁿ | n ≥ 0}

{ww | w ∈ Σ*}

{wwᴿ | w ∈ Σ*, |Σ| ≥ 2}

{0ⁿ | n is prime}

are common examples of non-regular languages.

---

# 64. Important Correction

Not every counting property is non-regular.

Example:

"number of 1s is even"

is regular.

"number of 1s is divisible by 7"

is regular.

Because only a finite remainder needs to be remembered.

---

# 65. GATE Trick: Finite vs Unbounded Counting

### Finite threshold

"At least 5 ones"

REGULAR.

Only need to remember:

0,1,2,3,4,5+

---

### Exact arbitrary equality

"#0 = #1"

usually NON-REGULAR for unrestricted strings.

---

### Modulo

"#1 ≡ 2 mod 5"

REGULAR.

Only 5 states are needed.

---

# 66. Fixed-Length Conditions

"Third symbol is 1"

REGULAR.

"Last 5 symbols are 10101"

REGULAR.

"Contains exactly three 0s"

REGULAR.

All require only finite memory.

---

# 67. Unbounded Matching

Conditions such as:

same number of 0s and 1s
in a structured order

may require unbounded memory.

Classic:

0ⁿ1ⁿ

NON-REGULAR.

---

# 68. GATE PYQ PATTERN 1

Question:

Which operation does NOT preserve regularity?

For regular languages:

Union → YES
Intersection → YES
Complement → YES
Concatenation → YES
Star → YES
Reversal → YES

Therefore none of these is a valid "not closed"
operation.

Be careful if an unfamiliar operation is given.

---

# 69. GATE PYQ PATTERN 2

Question:

L1 and L2 are regular.
What about:

L1 ∩ L2?

Answer:

Regular.

Use product DFA.

---

# 70. GATE PYQ PATTERN 3

Question:

DFA1 has 4 states.
DFA2 has 7 states.

Maximum states in product DFA:

4 × 7 = 28

Actual reachable states may be fewer.

---

# 71. GATE PYQ PATTERN 4

Question:

Can a regular language have infinitely many strings?

YES.

Example:

Σ*

---

# 72. GATE PYQ PATTERN 5

Question:

Can a finite language be non-regular?

NO.

Every finite language is regular.

---

# 73. GATE PYQ PATTERN 6

Question:

Is:

L = {0ⁿ1ⁿ}

regular?

NO.

Use pumping lemma or Myhill-Nerode.

---

# 74. GATE PYQ PATTERN 7

Question:

Is:

L = {w | number of 1s is divisible by 3}

regular?

YES.

Use 3 states representing:

0 mod 3
1 mod 3
2 mod 3

---

# 75. GATE PYQ PATTERN 8

Question:

What is the minimum DFA size for
strings whose number of 1s is congruent to
2 modulo 5?

Answer:

5 states.

---

# 76. GATE PYQ PATTERN 9

Question:

Which proof method is appropriate for
showing a language is not regular?

Possible:

- Pumping lemma
- Myhill-Nerode
- Closure properties

All can be used depending on the language.

---

# 77. GATE PYQ PATTERN 10

Question:

If a language satisfies the pumping lemma,
is it necessarily regular?

NO.

This is a classic trap.

The pumping lemma gives a necessary condition,
not a sufficient condition.

---

# 78. Pumping Lemma: Necessary vs Sufficient

If L is regular:

→ L satisfies pumping lemma.

But:

L satisfies pumping lemma

does NOT imply:

L is regular.

Therefore:

Pumping lemma is NOT an "if and only if" test.

---

# 79. Myhill-Nerode: Necessary and Sufficient

Unlike pumping lemma:

L is regular

IFF

L has finitely many Myhill-Nerode equivalence classes.

This is a complete characterization.

---

# 80. GATE High-Yield Comparison

| Property | Pumping Lemma | Myhill-Nerode |
|---|---|---|
| Proves non-regularity | Yes | Yes |
| Proves regularity | No | Yes |
| Necessary | Yes | Yes |
| Sufficient | No | Yes |
| Based on | Pumping | Distinguishability |

---

# 81. Common GATE Mistakes

## Mistake 1

Infinite language = non-regular.

WRONG.

---

## Mistake 2

Pumping lemma proves regularity.

WRONG.

---

## Mistake 3

If one decomposition fails pumping,
language is non-regular.

Be careful with quantifiers.

You need to show failure for EVERY valid decomposition.

---

## Mistake 4

CFL and regular languages have the same
closure properties.

WRONG.

---

## Mistake 5

Minimum DFA states = number of states
in the given DFA.

WRONG.

Given DFA may not be minimal.

---

# 82. Super High-Yield Table

| Language/Property | Regular? |
|---|---|
| a* | YES |
| (a+b)* | YES |
| a*b* | YES |
| aⁿbⁿ | NO |
| aⁿbⁿcⁿ | NO |
| Even # of 1s | YES |
| Odd # of 1s | YES |
| #1 divisible by 5 | YES |
| Exactly 5 ones | YES |
| At least 5 ones | YES |
| Contains 101 | YES |
| Ends with 101 | YES |
| Palindrome | NO (general case) |
| ww | NO |
| wwᴿ | NO for alphabet size ≥2 |
| Finite language | YES |

---

# 83. 30-SECOND GATE REVISION

Regular:

RE = DFA = NFA = ε-NFA.

Regular languages are closed under:

Union
Intersection
Complement
Difference
Concatenation
Star
Plus
Reversal
Homomorphism
Inverse homomorphism

Product DFA:

|Q1| × |Q2|

Complement:

Complete DFA → swap final/non-final.

Pumping lemma:

|xy| ≤ p
|y| > 0
xyⁱz ∈ L

Pumping lemma:

necessary, NOT sufficient.

Myhill-Nerode:

finite equivalence classes
⇔
regular.

Minimum DFA states:

number of Myhill-Nerode classes.

Modulo n:

usually n states.

Finite language:

always regular.

Infinite language:

may or may not be regular.

---

# 84. FINAL GATE CHECKLIST

[ ] Definition of regular language
[ ] DFA/NFA/RE equivalence
[ ] Finite-state memory concept
[ ] Regular vs non-regular examples
[ ] Closure properties
[ ] Product construction
[ ] Complement
[ ] Difference
[ ] Reversal
[ ] Homomorphism
[ ] Inverse homomorphism
[ ] Pumping lemma
[ ] Pumping lemma quantifiers
[ ] Pumping lemma proof
[ ] Myhill-Nerode theorem
[ ] Distinguishable strings
[ ] Minimal DFA
[ ] Residual languages
[ ] Regular grammar
[ ] Modulo-state trick
[ ] Finite vs infinite languages
[ ] Closure-based proofs
[ ] GATE PYQ patterns