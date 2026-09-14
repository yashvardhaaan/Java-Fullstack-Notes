# 01 - Regular Expressions

## GATE CSE - Theory of Computation

---

# 1. What is a Regular Expression?

A Regular Expression (RE) is a notation used to describe a
Regular Language.

For alphabet Σ, basic regular expressions are:

1. ∅
2. ε
3. a, where a ∈ Σ

They can be combined using:

- Union        : R + S
- Concatenation: RS
- Kleene Star  : R*

---

# 2. Meaning of Basic Operators

## 2.1 Union (+)

R + S means:

L(R + S) = L(R) ∪ L(S)

Example:

R = a + b

Language:

{a, b}

---

## 2.2 Concatenation

RS means:

L(RS) = L(R)L(S)

Example:

R = a
S = b

RS = ab

Language:

{ab}

---

## 2.3 Kleene Star (*)

R* means zero or more occurrences of R.

L(R*) = {ε, R, RR, RRR, ...}

Example:

a*

= {ε, a, aa, aaa, ...}

---

# 3. Very Important GATE Concepts

## a*

Means:

zero or more a's

Includes ε.

---

## a+

Means:

one or more a's

a+ = aa*

---

## aa*

Means:

one or more a's

---

## a*a*

Since:

a*a* = a*

---

## (a+b)*

All strings over {a,b}.

Examples:

ε
a
b
ab
ba
aaa
aab
aba
...

---

## (a+b)

Only:

{a,b}

NOT:

{ε,a,b,...}

---

# 4. Operator Precedence

This is VERY important in GATE.

Highest → Lowest:

1. *
2. Concatenation
3. +

Therefore:

ab* + c

means:

(a(b*)) + c

NOT:

(ab)* + c

---

# 5. Important Equivalences

Memorize these.

## Identity

R + ∅ = R

Rε = R

---

## Star

R* = ε + RR*

R* = ε + R*R

---

## Idempotent Union

R + R = R

---

## Associativity

(R + S) + T = R + (S + T)

(RS)T = R(ST)

---

## Commutativity

Union is commutative:

R + S = S + R

BUT concatenation is NOT:

RS ≠ SR

Example:

ab ≠ ba

---

# 6. Important Star Tricks

## Trick 1

R*R* = R*

Because both represent any number of repetitions.

---

## Trick 2

(R*)* = R*

---

## Trick 3

ε + R* = R*

Because ε is already included in R*.

---

## Trick 4

∅* = ε

This is frequently tested.

Why?

Zero occurrences of ∅ are possible.

Therefore:

∅* = {ε}

---

## Trick 5

ε* = ε

---

## Trick 6

R + RR* = RR*

because:

RR* already contains R.

---

# 7. Language Identification

GATE frequently gives an RE and asks:

"What language does this represent?"

Always expand the expression logically.

---

## Example 1

RE:

(0+1)*

Language:

All binary strings.

Therefore:

L = {0,1}*

---

## Example 2

RE:

0*1*

Language:

All strings consisting of:

some 0's followed by some 1's.

Examples:

ε
0
00
1
11
001
000111

NOT:

010
101
1001

---

## Example 3

RE:

(0+1)*00(0+1)*

Language:

All binary strings containing 00 as a substring.

---

## Example 4

RE:

(0+1)*101(0+1)*

Language:

All strings containing 101 as a substring.

---

# 8. Substring vs Subsequence

VERY IMPORTANT.

## Substring

Characters must be consecutive.

Example:

101

contains 10 as substring.

---

## Subsequence

Characters do NOT need to be consecutive.

Example:

10101

contains 111? No.

But it contains 101 as a subsequence.

GATE often tests this distinction indirectly.

---

# 9. Regular Expressions for Common Languages

## 9.1 Strings ending in 0

(0+1)*0

---

## 9.2 Strings starting with 0

0(0+1)*

---

## 9.3 Strings starting and ending with 0

0(0+1)*0

But this misses the string:

0

If length 1 is allowed:

0((0+1)*0 + ε)

---

## 9.4 Strings containing at least one 0

(0+1)*0(0+1)*

---

## 9.5 Strings containing at least one 1

(0+1)*1(0+1)*

---

## 9.6 Strings containing both 0 and 1

(0+1)*0(0+1)*1(0+1)*
+
(0+1)*1(0+1)*0(0+1)*

---

# 10. Exactly One Occurrence

## Exactly one 1

0*10*

---

## Exactly two 1's

0*10*10*

---

## Exactly three 1's

0*10*10*10*

---

## Exactly k occurrences of 1

0*(10*)^k

---

# 11. At Least k Occurrences

## At least two 1's

(0+1)*1(0+1)*1(0+1)*

---

# 12. At Most One 1

0* + 0*10*

Can be written as:

0*(ε + 1)0*

---

# 13. Even Number of 1's

Very important.

Regular expression:

0*(10*10*)*

Alternative:

(0*10*1)*0*

---

# 14. Odd Number of 1's

Regular expression:

0*10*(10*10*)*

---

# 15. Even Number of 0's

1*(01*01*)*

---

# 16. Odd Number of 0's

1*01*(01*01*)*

---

# 17. Strings with No Consecutive 1's

One useful RE:

(0 + 10)*(ε + 1)

Examples:

ε
0
1
00
01
10
101
010
1010

NOT:

11
011
110

---

# 18. Strings with No Consecutive 0's

(1 + 01)*(ε + 0)

---

# 19. Strings Not Containing a Particular Substring

This is a common GATE pattern.

Example:

Strings over {0,1} that do NOT contain 00.

A useful RE:

(1 + 01)*(ε + 0)

The key idea:

Every 0 must either:

- occur after 1
- or be the final symbol

Therefore two 0's can never become adjacent.

---

# 20. Complement of a Regular Expression

Important:

There is generally NO simple operation like:

complement(R)

that can directly be written by changing symbols.

Correct method:

RE → NFA/DFA → complement DFA.

For a complete DFA:

1. Keep states unchanged.
2. Swap final and non-final states.

---

# 21. RE → NFA

Every regular expression can be converted into an NFA.

Important result:

RE ↔ NFA ↔ DFA

All describe exactly the Regular Languages.

---

# 22. Regular Language Equivalences

Memorize:

Regular Expression
        ⇅
NFA
        ⇅
DFA
        ⇅
Regular Grammar

All represent Regular Languages.

---

# 23. GATE Trick: Think in Terms of "What Must Be Remembered?"

Suppose:

L = { w | number of 1's is even }

The machine only needs to remember:

- Even
- Odd

Therefore:

2 states are enough.

---

Suppose:

L = { w | number of 1's ≡ 2 mod 5 }

Machine needs to remember:

0,1,2,3,4 mod 5

Therefore:

5 states.

### General Trick

For:

number of symbols ≡ k (mod n)

usually start with:

n states.

---

# 24. GATE Trick: Prefix/Suffix/Substring

### Starts with X

X + anything

### Ends with X

anything + X

### Contains X

anything + X + anything

For alphabet Σ:

Starts with X:

XΣ*

Ends with X:

Σ*X

Contains X:

Σ*XΣ*

---

# 25. Important Difference

## Contains 101

Σ*101Σ*

means:

101 occurs somewhere.

---

## Ends with 101

Σ*101

---

## Starts with 101

101Σ*

---

# 26. Finite Languages Are Regular

Every finite language is regular.

Example:

L = {01, 101, 111}

is regular.

RE:

01 + 101 + 111

---

# 27. Infinite Regular Languages

Examples:

a*

(0+1)*

0*1*

---

# 28. Empty Language vs ε

EXTREMELY IMPORTANT.

## ∅

Contains no strings.

L(∅) = ∅

---

## ε

Contains one string:

L(ε) = {ε}

---

Therefore:

∅ ≠ ε

---

# 29. Important GATE Trap

Compare:

∅*

and

ε*

Both are:

{ε}

Therefore:

∅* = ε* = ε

---

# 30. RE and DFA Question Strategy

When a DFA is given and an RE is asked:

### Step 1
Identify the meaning of each state.

### Step 2
Check the accepting state.

### Step 3
Look for:

- parity
- modulo
- substring
- prefix
- suffix
- count
- alternation

### Step 4
Translate the language into an RE.

Do NOT randomly try to derive an RE from transitions.

---

# 31. GATE PYQ PATTERNS

GATE repeatedly asks:

1. DFA → Regular Expression
2. Regular Expression → language
3. Identify equivalent RE
4. Count strings represented by an RE
5. NFA/DFA equivalence
6. Minimal DFA state count
7. Closure properties of regular languages
8. Strings containing/not containing a substring

Recent GATE papers continue to test RE/FA through equivalence, state counting,
language identification and automata conversion. 

---

# 32. PYQ 1 — GATE 1997 Pattern

Question concept:

Find the RE representing binary strings that do NOT contain
the substring 100.

### Solution Strategy

Do not try to list all valid strings.

Instead construct the language by tracking how close we are
to creating 100.

A DFA approach is often easier:

State 0:
No useful prefix matched.

State 1:
Last symbol was 1.

State 2:
Last symbols were 10.

State 3:
100 has occurred → dead state.

Then remove the dead state and derive the equivalent RE.

### GATE Trick

For:

"does not contain X"

build a DFA that tracks prefixes of X.

This is usually much easier than guessing the RE.

---

# 33. PYQ 2 — Recent GATE Pattern

GATE has asked questions where a DFA is given and several REs
are provided.

### Correct Approach

For every option:

1. Pick a short string accepted by the DFA.
2. Check whether the RE accepts it.
3. Pick a short string rejected by the DFA.
4. Check whether the RE rejects it.

You do NOT need to mathematically prove every option.

### Exam Trick

Use counterexamples.

One counterexample is enough to eliminate an option.

---

# 34. PYQ 3 — Counting Strings

Suppose:

R = b*ab*(ab*ab*)*

Question:

How many strings of length ≤ 4 belong to R?

### Trick

Understand the structure first.

The expression requires:

- at least one a
- the number of a's is even or follows the structure imposed by
  the repeated block

Then enumerate only strings of the required length.

### GATE Lesson

For counting questions:

DO NOT expand the entire RE.

First identify:

- minimum length
- mandatory symbols
- number of occurrences
- allowed positions

Then count.

---

# 35. PYQ 4 — NFA to DFA

If an NFA has n states, the equivalent DFA can have at most:

2^n states

For n = 6:

2^6 = 64

But the actual minimal DFA can be much smaller.

### GATE Trap

"Can have at most 2^n states"

does NOT mean:

"must have 2^n states."

---

# 36. PYQ 5 — Minimal DFA

Suppose a language requires remembering:

number of 1's modulo 4.

States:

q0 → remainder 0
q1 → remainder 1
q2 → remainder 2
q3 → remainder 3

Minimum:

4 states

### Trick

Modulo n → usually n states.

---

# 37. Most Important RE Identities for GATE

Memorize this table.

| Expression | Result |
|---|---|
| R + ∅ | R |
| Rε | R |
| R + R | R |
| R*R* | R* |
| (R*)* | R* |
| ∅* | ε |
| ε* | ε |
| R + RR* | RR* |
| R + ε | R + ε |
| R∅ | ∅ |

---

# 38. Common GATE Mistakes

## Mistake 1

Thinking:

a* = one or more a's

WRONG.

a* includes ε.

---

## Mistake 2

Thinking:

(a+b)* = a*b*

WRONG.

a*b* only allows all a's before all b's.

Example:

aba

belongs to (a+b)*

but does NOT belong to a*b*.

---

## Mistake 3

Thinking:

ab* = (ab)*

WRONG.

ab*:

a
ab
abb
abbb
...

(ab)*:

ε
ab
abab
ababab
...

---

## Mistake 4

Assuming concatenation is commutative.

ab ≠ ba

---

## Mistake 5

Confusing:

∅

with

ε

---

# 39. GATE One-Liners

### Q: Is every RE language regular?

YES.

### Q: Is every regular language represented by an RE?

YES.

### Q: Can an NFA recognize a language that DFA cannot?

NO.

### Q: Can RE represent non-regular language?

NO.

### Q: Is every finite language regular?

YES.

### Q: Is every infinite language non-regular?

NO.

### Q: Can a regular language be infinite?

YES.

Example:

a*

---

# 40. High-Yield GATE Checklist

Before moving to the next topic, you should be able to:

[ ] Interpret *
[ ] Interpret +
[ ] Interpret concatenation
[ ] Apply operator precedence
[ ] Distinguish ∅ and ε
[ ] Identify language represented by an RE
[ ] Write RE for prefix conditions
[ ] Write RE for suffix conditions
[ ] Write RE for substring conditions
[ ] Write RE for exact number of symbols
[ ] Write RE for even/odd occurrences
[ ] Understand modulo languages
[ ] Convert RE ↔ NFA conceptually
[ ] Understand NFA → DFA 2^n bound
[ ] Identify common equivalent REs
[ ] Solve DFA → RE questions
[ ] Count strings described by an RE

---

# 41. LAST-MINUTE REVISION

## Operators

+       → OR
ab      → concatenation
*       → zero or more

## Precedence

* > concatenation > +

## Essential

∅* = ε

ε* = ε

R*R* = R*

(R*)* = R*

R + ∅ = R

Rε = R

## Common Patterns

Starts with X:

XΣ*

Ends with X:

Σ*X

Contains X:

Σ*XΣ*

Exactly one 1:

0*10*

Exactly two 1s:

0*10*10*

Even number of 1s:

0*(10*10*)*

At least one 1:

Σ*1Σ*

## DFA State Trick

Modulo n → usually n states.

Even/odd → 2 states.

Substring tracking → states based on matched prefix.

NFA with n states → DFA has at most 2^n states.

---

# 42. GATE Strategy

For an RE question:

1. Understand the language.
2. Find mandatory symbols.
3. Determine whether the condition is:
   - prefix
   - suffix
   - substring
   - count
   - parity
   - modulo
4. Simplify using RE identities.
5. Test with short strings.
6. Use counterexamples to eliminate options.

Never expand a complicated RE blindly.
