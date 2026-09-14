# 03 - Context-Free Grammars (CFG)

## GATE CSE - Theory of Computation

---

# 1. What is a Grammar?

A grammar is a formal system used to generate strings of a language.

A grammar is represented as:

G = (V, T, P, S)

Where:

V = Variables / Non-terminals
T = Terminals
P = Production rules
S = Start symbol

Important:

V ∩ T = ∅

---

# 2. Context-Free Grammar

A grammar is Context-Free if every production has the form:

A → α

where:

A is a single non-terminal

and

α ∈ (V ∪ T)*

Example:

S → aSb
S → ε

This is a CFG.

---

# 3. Why is it called Context-Free?

The replacement of A does not depend on the symbols
surrounding A.

Example:

A → a

A can be replaced by a regardless of its context.

---

# 4. CFG Example

Grammar:

S → aSb | ε

Generate:

S
⇒ ε

S
⇒ aSb
⇒ ab

S
⇒ aSb
⇒ aaSbb
⇒ aabb

S
⇒ aaSbb
⇒ aaεbb
⇒ aabb

Therefore:

L(G) = {aⁿbⁿ | n ≥ 0}

---

# 5. Derivation

A derivation is a sequence of applications of production rules
starting from the start symbol.

Example:

S → aSb
S → ε

Derivation of aabb:

S
⇒ aSb
⇒ aaSbb
⇒ aaεbb
⇒ aabb

---

# 6. Sentential Form

Any string derived from S during the derivation is called
a sentential form.

Example:

S
⇒ aSb
⇒ aaSbb
⇒ aabb

All are sentential forms.

---

# 7. Sentence

A sentence is a string consisting ONLY of terminals
derived from the start symbol.

Example:

aabb

is a sentence.

aSbb

is NOT a sentence because S is still present.

---

# 8. Leftmost Derivation

In leftmost derivation:

Always replace the LEFTMOST non-terminal first.

Example:

S → AB
A → a
B → b

Leftmost:

S
⇒ AB
⇒ aB
⇒ ab

---

# 9. Rightmost Derivation

Always replace the RIGHTMOST non-terminal first.

Example:

S → AB
A → a
B → b

Rightmost:

S
⇒ AB
⇒ Ab
⇒ ab

---

# 10. GATE Trick

For a leftmost derivation:

Underline/find the leftmost non-terminal.

Replace ONLY that one.

For rightmost:

Find the rightmost non-terminal.

Replace ONLY that one.

---

# 11. Parse Tree

A parse tree represents the hierarchical structure
of a derivation.

Properties:

- Root = Start symbol
- Internal nodes = Non-terminals
- Leaves = Terminals or ε
- Reading leaves from left to right gives the generated string

---

# 12. Parse Tree Example

Grammar:

S → aSb | ε

For:

aabb

Structure:

        S
      / | \
     a  S  b
       /|\
      a S b
        |
        ε

Leaves:

a a ε b b

Ignoring ε:

aabb

---

# 13. Ambiguous Grammar

A CFG is ambiguous if there exists at least one string
having:

- Two different parse trees

OR

- Two different leftmost derivations

OR

- Two different rightmost derivations

---

# 14. Important Equivalence

For a CFG:

Two different parse trees
⇔
Two different leftmost derivations

for the same string.

This is a very important GATE fact.

---

# 15. Classic Ambiguous Grammar

E → E + E
E → E * E
E → id

Consider:

id + id * id

It can be interpreted as:

(id + id) * id

OR:

id + (id * id)

Therefore grammar is ambiguous.

---

# 16. Ambiguity Trick

If asked:

"Is this grammar ambiguous?"

Do NOT try to prove that every string is ambiguous.

You only need:

ONE string

with two different parse trees.

---

# 17. Unambiguous Expression Grammar

A standard grammar:

E → E + T | T
T → T * F | F
F → (E) | id

This enforces:

* has higher precedence than +

and parentheses override precedence.

---

# 18. Operator Precedence

For:

id + id * id

the usual interpretation is:

id + (id * id)

because:

* > +

A grammar must be designed accordingly if
unambiguous parsing is required.

---

# 19. Associativity

Expression:

a - b - c

usually means:

(a - b) - c

This is left associativity.

Grammar:

E → E - T | T

typically produces left associativity.

---

# 20. CFG for aⁿbⁿ

Language:

L = {aⁿbⁿ | n ≥ 0}

Grammar:

S → aSb | ε

---

# 21. CFG for aⁿbⁿcⁿ?

Language:

L = {aⁿbⁿcⁿ | n ≥ 0}

This language is NOT context-free.

This is extremely important.

Do NOT attempt:

S → aSbSc

and assume it works.

---

# 22. CFG for Equal Number of a and b

Language:

L = {w ∈ {a,b}* | #a(w) = #b(w)}

A CFG exists.

One possible grammar:

S → aSbS
  | bSaS
  | ε

The order can be arbitrary.

Examples:

ε
ab
ba
aabb
abab
baba
abba

---

# 23. CFG for Palindrome

For alphabet {a,b}:

S → aSa
  | bSb
  | a
  | b
  | ε

This generates palindromes.

Examples:

ε
a
b
aa
bb
aba
bab
abba
baab

---

# 24. CFG for Even-Length Palindromes

S → aSa
  | bSb
  | ε

---

# 25. CFG for Odd-Length Palindromes

S → aSa
  | bSb
  | a
  | b

---

# 26. CFG for aⁿbᵐ

Language:

a*b*

Grammar:

S → AB
A → aA | ε
B → bB | ε

---

# 27. CFG for aⁿbⁿ

S → aSb | ε

Key idea:

One recursive step adds:

one a
+
one b

Therefore counts remain equal.

---

# 28. CFG for aⁿb²ⁿ

S → aSbb | ε

Each recursion:

adds 1 a
adds 2 b

Therefore:

#b = 2#a

---

# 29. CFG for a²ⁿbⁿ

S → aaSb | ε

Each recursion:

adds 2 a
adds 1 b

Therefore:

#a = 2#b

---

# 30. CFG for aⁿbⁿ⁺¹

S → aSb | b

Each recursion adds:

1 a
1 b

Base contains one extra b.

Therefore:

b = a + 1

---

# 31. GATE Trick for CFG Construction

Look at the required relationship.

If:

#a = #b

add:

a ... b

If:

#a = 2#b

add:

aa ... b

If:

#b = 2#a

add:

a ... bb

---

# 32. Normal Forms

Important normal forms:

1. Chomsky Normal Form (CNF)
2. Greibach Normal Form (GNF)

---

# 33. Chomsky Normal Form

A CFG is in CNF if productions are generally of the form:

A → BC

or

A → a

and optionally:

S → ε

if ε belongs to the language.

Here:

A, B, C = non-terminals
a = terminal

---

# 34. CNF Restrictions

Allowed:

A → BC
A → a

Special case:

S → ε

Not allowed:

A → B
A → aB
A → ABC
A → ε

except the permitted start-symbol ε production.

---

# 35. CNF Example

Convert:

A → aBC

into CNF.

Introduce:

X → BC

Then:

A → aX

But A → aX is still not CNF.

Introduce:

Y → a

Then:

A → YX

So:

Y → a
X → BC
A → YX

---

# 36. GATE CNF Trick

If RHS has length > 2:

break it into binary productions.

Example:

A → BCD

Use:

X → CD
A → BX

---

# 37. Greibach Normal Form

GNF productions generally have the form:

A → aα

where:

a = terminal

α = zero or more non-terminals.

Examples:

A → a
A → aBC
A → bA

---

# 38. CNF vs GNF

| CNF | GNF |
|---|---|
| A → BC | A → aα |
| A → a | Starts with terminal |
| Binary RHS | Terminal first |

---

# 39. Nullable Variable

A variable A is nullable if:

A ⇒* ε

Example:

S → AB
A → ε
B → b

A is nullable.

---

# 40. Finding Nullable Variables

Start with variables having:

A → ε

Then repeatedly find variables whose RHS consists
entirely of nullable variables.

Example:

A → ε
B → A
C → AB

Then:

A nullable
B nullable
C nullable

---

# 41. Unit Production

A production of the form:

A → B

where both A and B are non-terminals.

Example:

A → B

is a unit production.

---

# 42. Useless Symbols

A symbol is useless if it is:

1. Non-generating
OR
2. Unreachable

---

# 43. Generating Symbol

A variable is generating if it can derive
a string consisting only of terminals.

Example:

A → aA | b

A is generating because:

A ⇒ b

---

# 44. Reachable Symbol

A symbol is reachable if it can occur in a derivation
starting from S.

---

# 45. Useless Symbol Trick

To remove useless symbols:

### Step 1

Remove non-generating symbols.

### Step 2

Remove unreachable symbols.

---

# 46. Left Recursion

A grammar is left recursive if:

A ⇒+ Aα

Immediate left recursion:

A → Aα | β

Example:

E → E + T | T

is left recursive.

---

# 47. Removing Immediate Left Recursion

Given:

A → Aα | β

Convert to:

A → βA'
A' → αA' | ε

---

# 48. Example

E → E + T | T

becomes:

E → TE'
E' → +TE' | ε

---

# 49. GATE Trick

If you see:

A → Aα | β

immediately remember:

A → βA'
A' → αA' | ε

---

# 50. Leftmost vs Rightmost Derivation

Important distinction:

Leftmost:
replace leftmost variable.

Rightmost:
replace rightmost variable.

Both can generate the same string.

---

# 51. Parse Tree vs Derivation

Different derivation orders can produce the SAME parse tree.

Therefore:

Different derivations do not automatically mean ambiguity.

For ambiguity, we need:

two distinct leftmost derivations
for the same string

which correspond to different parse trees.

---

# 52. GATE Ambiguity Trap

Suppose two derivations differ only because
you expanded different non-terminals first.

That alone does NOT prove ambiguity.

Example:

S → AB
A → a
B → b

Derivation 1:

S ⇒ AB ⇒ aB ⇒ ab

Derivation 2:

S ⇒ AB ⇒ Ab ⇒ ab

These are different derivation sequences,
but grammar is NOT ambiguous.

There is only one parse tree.

---

# 53. Inherently Ambiguous Language

Some CFLs are inherently ambiguous.

Meaning:

Every CFG generating that language is ambiguous.

This is an advanced GATE concept.

Remember:

An ambiguous grammar does NOT mean
the language itself is inherently ambiguous.

---

# 54. CFG and PDA Relationship

Very important:

CFG ↔ PDA

A language is context-free iff
some PDA accepts it.

Therefore:

CFG and PDA have the same expressive power.

---

# 55. Chomsky Hierarchy

From most restrictive to most powerful:

Regular
↓
Context-Free
↓
Context-Sensitive
↓
Recursively Enumerable

Corresponding machines:

FA
↓
PDA
↓
LBA
↓
Turing Machine

---

# 56. Inclusion

Every regular language is context-free.

Therefore:

REGULAR ⊂ CFL

But:

Every CFL is NOT regular.

Example:

{aⁿbⁿ | n ≥ 0}

is CFL but not regular.

---

# 57. Important Examples

## Regular + CFL

a*b*

Regular.

---

## CFL but not Regular

{aⁿbⁿ | n ≥ 0}

---

## Not CFL

{aⁿbⁿcⁿ | n ≥ 0}

---

# 58. GATE Language Identification Trick

When you see:

aⁿbⁿ

think:

CFL, not regular.

When you see:

aⁿbⁿcⁿ

think:

not CFL.

When you see:

aⁿbⁿaⁿ

usually suspect non-CFL.

---

# 59. CFL Closure Properties

Context-free languages are closed under:

- Union
- Concatenation
- Kleene star

BUT NOT generally closed under:

- Intersection
- Complement
- Difference

---

# 60. Very Important Comparison

Regular Languages:

closed under intersection.

CFL:

NOT closed under intersection in general.

However:

CFL ∩ REGULAR = CFL

If L is CFL and R is Regular:

L ∩ R is CFL.

---

# 61. GATE PYQ PATTERN 1

Question:

Which grammar generates:

L = {aⁿbⁿ | n ≥ 0}?

Correct:

S → aSb | ε

### Trick

Every recursion contributes one a and one b.

---

# 62. GATE PYQ PATTERN 2

Question:

Determine whether a grammar is ambiguous.

### Method

1. Find a short candidate string.
2. Try two different parse structures.
3. Produce two leftmost derivations.
4. If successful → ambiguous.

### Fast Candidate

For expression grammars, try:

id + id * id

or:

id + id + id

---

# 63. GATE PYQ PATTERN 3

Question:

Which production violates CNF?

Check RHS.

Valid:

A → BC
A → a

Invalid:

A → BCDE
A → aB
A → B
A → ε

(with the usual S → ε exception).

---

# 64. GATE PYQ PATTERN 4

Question:

How many parse trees exist for an ambiguous grammar?

Do not confuse:

number of derivation sequences

with:

number of parse trees.

Ambiguity is about parse trees.

---

# 65. GATE PYQ PATTERN 5

Question:

Which symbols are useless?

### Method

Mark generating variables first.

Then determine reachability from S.

Anything remaining useless.

---

# 66. GATE PYQ PATTERN 6

Question:

Which language is NOT context-free?

Classic answer:

{aⁿbⁿcⁿ | n ≥ 0}

Reason:

A single PDA stack cannot simultaneously enforce
three equal independent counts.

---

# 67. GATE PYQ PATTERN 7

Question:

Which statement is correct?

"Every regular language is context-free."

TRUE.

But:

"Every context-free language is regular."

FALSE.

---

# 68. GATE PYQ PATTERN 8

Question:

CFL ∩ Regular = ?

Answer:

CFL.

This is a useful special closure property.

---

# 69. Common GATE Mistakes

## Mistake 1

Different derivations = ambiguity.

WRONG.

Need different parse trees.

---

## Mistake 2

aⁿbⁿcⁿ is CFL.

WRONG.

It is not CFL.

---

## Mistake 3

CFLs are closed under intersection.

WRONG.

Not in general.

---

## Mistake 4

A → BC is not CFG.

WRONG.

It is a valid CFG production.

---

## Mistake 5

A → ε is never allowed.

WRONG.

It is allowed in a CFG.

It is restricted in normal forms such as CNF.

---

# 70. High-Yield GATE Table

| Concept | Remember |
|---|---|
| CFG | A → α |
| Leftmost | Replace leftmost variable |
| Rightmost | Replace rightmost variable |
| Ambiguous | Two parse trees |
| CNF | A→BC or A→a |
| GNF | A→aα |
| Unit production | A→B |
| Nullable | A⇒*ε |
| Left recursion | A⇒+Aα |
| CFG ↔ PDA | Same power |
| REG ⊂ CFL | Yes |
| aⁿbⁿ | CFL, not regular |
| aⁿbⁿcⁿ | Not CFL |
| CFL ∪ CFL | CFL |
| CFL concatenation | CFL |
| CFL* | CFL |
| CFL ∩ CFL | Not necessarily CFL |
| CFL complement | Not necessarily CFL |

---

# 71. MUST-MEMORIZE CFGs

## aⁿbⁿ

S → aSb | ε

---

## aⁿb²ⁿ

S → aSbb | ε

---

## a²ⁿbⁿ

S → aaSb | ε

---

## Palindrome

S → aSa | bSb | a | b | ε

---

## Even palindrome

S → aSa | bSb | ε

---

## a*b*

S → AB
A → aA | ε
B → bB | ε

---

# 72. 30-SECOND REVISION

Grammar:

G = (V,T,P,S)

CFG:

A → α

Leftmost:
leftmost variable first.

Rightmost:
rightmost variable first.

Ambiguous:

≥ 2 parse trees for one string.

CNF:

A → BC
A → a

GNF:

A → aα

Nullable:

A ⇒* ε

Unit:

A → B

Useless:

non-generating OR unreachable.

CFG ↔ PDA.

Regular ⊂ CFL.

aⁿbⁿ:

CFL.

aⁿbⁿcⁿ:

not CFL.

CFL closed:

Union
Concatenation
Star

Not generally closed:

Intersection
Complement
Difference

---

# 73. FINAL GATE CHECKLIST

[ ] CFG definition
[ ] Grammar components
[ ] Derivation
[ ] Sentential form
[ ] Sentence
[ ] Leftmost derivation
[ ] Rightmost derivation
[ ] Parse tree
[ ] Ambiguity
[ ] Expression grammar
[ ] CNF
[ ] GNF
[ ] Nullable variables
[ ] Unit productions
[ ] Useless symbols
[ ] Generating symbols
[ ] Reachable symbols
[ ] Left recursion
[ ] Removing left recursion
[ ] CFG ↔ PDA
[ ] CFL closure properties
[ ] Standard CFG constructions
[ ] aⁿbⁿ
[ ] Palindromes
[ ] aⁿb²ⁿ
[ ] aⁿbⁿcⁿ
[ ] GATE ambiguity questions
[ ] GATE CNF questions
[ ] GATE language-identification questions