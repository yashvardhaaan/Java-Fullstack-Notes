# 02 - Finite Automata

## GATE CSE - Theory of Computation

---

# 1. What is Finite Automata?

A Finite Automaton (FA) is a mathematical model used to recognize
Regular Languages.

A finite automaton has:

- Finite number of states
- Input alphabet
- Transition function
- Initial state
- Set of final/accepting states

Formal representation:

M = (Q, Σ, δ, q0, F)

Where:

Q  = finite set of states
Σ  = input alphabet
δ  = transition function
q0 = initial state
F  = set of final states

---

# 2. Types of Finite Automata

Main types:

1. DFA
2. NFA
3. ε-NFA

All three recognize exactly the Regular Languages.

Therefore:

DFA = NFA = ε-NFA = Regular Expression

in terms of expressive power.

---

# 3. DFA

DFA = Deterministic Finite Automaton.

Transition function:

δ : Q × Σ → Q

For every:

state + input symbol

there must be exactly ONE next state.

---

# 4. DFA Properties

For every state q and symbol a:

δ(q,a) must be defined.

Therefore:

Each state has exactly |Σ| outgoing transitions.

If:

|Q| = n
|Σ| = m

Then a complete DFA has:

n × m

transitions.

---

# 5. GATE Trick

If a DFA has:

5 states
alphabet = {0,1}

Number of transitions:

5 × 2 = 10

NOT 2^5.

---

# 6. NFA

NFA = Non-deterministic Finite Automaton.

Transition function:

δ : Q × Σ → 2^Q

For one:

state + symbol

there may be:

- zero next states
- one next state
- multiple next states

---

# 7. DFA vs NFA

| Feature | DFA | NFA |
|---|---|---|
| Next state | Exactly one | Zero/one/many |
| ε transition | No | No |
| Transition function | Q×Σ → Q | Q×Σ → 2^Q |
| Multiple paths | No | Yes |
| Expressive power | Regular | Regular |

---

# 8. ε-NFA

ε-NFA allows transitions without consuming input.

Example:

q0 --ε--> q1

The machine can move from q0 to q1
without reading a symbol.

---

# 9. ε-Closure

Very important for GATE.

ε-closure(q):

Set of all states reachable from q using
zero or more ε transitions.

Important:

q itself is ALWAYS included.

Therefore:

q ∈ ε-closure(q)

---

# 10. Example

Suppose:

q0 --ε--> q1
q1 --ε--> q2

Then:

ε-closure(q0)
= {q0,q1,q2}

ε-closure(q1)
= {q1,q2}

ε-closure(q2)
= {q2}

---

# 11. GATE Trap

ε-closure(q) does NOT mean:

"states reachable using exactly one ε transition."

It means:

zero OR more ε transitions.

---

# 12. Language Accepted by DFA

A string is accepted if:

1. Start at q0.
2. Consume the entire string.
3. End in an accepting state.

If final state is non-final:

string rejected.

---

# 13. DFA Acceptance Example

Suppose:

q0 = initial
q1 = final

Transitions:

q0 --0--> q1
q1 --0--> q0

Then:

ε → reject
0 → accept
00 → reject
000 → accept

Therefore the DFA recognizes:

strings containing an odd number of 0s.

---

# 14. State Meaning Trick

Whenever a DFA is given:

DO NOT immediately follow every transition.

First ask:

"What does each state mean?"

Example:

q0 → even number of 1s
q1 → odd number of 1s

Then:

q0 is final

means:

Even number of 1s accepted.

This makes many GATE questions very easy.

---

# 15. DFA for Even Number of 1s

States:

qE = even
qO = odd

Initially:

qE

Reading 1:

qE → qO
qO → qE

Reading 0:

state remains unchanged.

Final:

qE

Only 2 states are required.

---

# 16. DFA for Odd Number of 1s

Same DFA.

Only accepting state changes:

qO = final

---

# 17. DFA for Number of 1s mod 3

States:

q0 → count ≡ 0 mod 3
q1 → count ≡ 1 mod 3
q2 → count ≡ 2 mod 3

Reading 1:

q0 → q1
q1 → q2
q2 → q0

Reading 0:

state remains unchanged.

For remainder 0:

q0 is final.

---

# 18. GATE State-Count Trick

If language requires remembering:

count modulo n

then normally:

n states are required.

Examples:

Even/odd:

2 states

mod 3:

3 states

mod 5:

5 states

---

# 19. DFA for Strings Ending in 01

Need to remember the relevant suffix.

States:

q0 = nothing useful
q1 = last symbol is 0
q2 = last two symbols are 01

q2 is final.

---

# 20. DFA for Strings Containing 01

States:

q0 = 01 not seen
q1 = 0 has been seen as possible beginning
q2 = 01 found

q2 is an accepting trap state.

Once 01 occurs:

remain in q2.

---

# 21. Trap/Dead State

A trap state is a state from which acceptance
cannot be reached.

Usually:

δ(qtrap,a) = qtrap

for every symbol a.

---

# 22. GATE Trap

A trap state does NOT necessarily mean:

"the language rejects everything from here."

It means:

once entered, the machine can never leave.

Whether it is accepting or rejecting depends on the problem.

---

# 23. DFA State Equivalence

Two states are equivalent if:

for every possible input string,

they either both accept or both reject.

Equivalent states can be merged.

This is the basis of DFA minimization.

---

# 24. DFA Minimization

Standard procedure:

## Step 1

Remove unreachable states.

## Step 2

Divide states into:

Final
Non-final

## Step 3

Refine partitions according to transitions.

## Step 4

Merge equivalent states.

---

# 25. Initial Partition

Suppose:

Q = {q0,q1,q2,q3}

Final:

{q2,q3}

Non-final:

{q0,q1}

Initial partition:

P0 = {{q0,q1},{q2,q3}}

---

# 26. Distinguishable States

Two states are distinguishable if there exists
some string w such that:

δ*(p,w) is final

but

δ*(q,w) is non-final

(or vice versa).

That string is called a distinguishing string.

---

# 27. Fast Minimization Trick

If one state is final and another is non-final:

They are immediately distinguishable.

Use:

w = ε

because:

δ*(q,ε) = q

---

# 28. Table-Filling Method

For every pair of states:

### Step 1

Mark pairs where:

one state is final
and the other is non-final.

### Step 2

For each unmarked pair (p,q):

if for some symbol a:

(δ(p,a), δ(q,a))

is already marked,

then mark (p,q).

### Step 3

Unmarked pairs are equivalent.

---

# 29. Very Important GATE Trick

Do NOT minimize blindly.

First:

REMOVE UNREACHABLE STATES.

An unreachable state can never affect the language.

---

# 30. NFA → DFA

This is one of the most important GATE topics.

If NFA has:

n states

equivalent DFA can have at most:

2^n states.

This is called:

Subset Construction.

---

# 31. Why 2^n?

Each DFA state represents a SET of NFA states.

For n NFA states:

Number of possible subsets:

2^n

Therefore maximum:

2^n DFA states.

---

# 32. Example

NFA has 3 states:

{q0,q1,q2}

Possible subsets:

∅
{q0}
{q1}
{q2}
{q0,q1}
{q0,q2}
{q1,q2}
{q0,q1,q2}

Total:

2^3 = 8

---

# 33. GATE Trap

An NFA with n states does NOT necessarily produce
2^n states in the DFA.

2^n is only the maximum possible number.

The reachable subsets may be much fewer.

---

# 34. ε-NFA → DFA

For ε-NFA, use:

ε-closure

Procedure:

### Step 1

Start DFA state:

ε-closure(q0)

### Step 2

For input a:

move = all states reachable using a.

### Step 3

Take:

ε-closure(move)

### Step 4

Repeat until no new subsets appear.

---

# 35. Formula

For subset S:

δD(S,a)

=

ε-closure(
    move(S,a)
)

This is extremely important.

---

# 36. Final States in Subset Construction

A DFA subset is final if:

it contains AT LEAST ONE final state of the NFA.

Example:

NFA final:

q2

Then:

{q0,q2}

is a DFA final state.

---

# 37. GATE Trap

A DFA subset is NOT final only when:

"all states are final."

Only ONE NFA final state inside the subset is sufficient.

---

# 38. DFA → NFA

Every DFA is already an NFA.

Therefore:

DFA can be converted to NFA
without changing the states.

---

# 39. NFA → RE

Can be done using:

1. State elimination
2. GNFA method
3. Arden's theorem

---

# 40. Arden's Theorem

Very important.

If:

X = AX + B

and ε ∉ A

then:

X = A*B

Similarly:

X = XA + B

then:

X = BA*

under the corresponding condition.

---

# 41. Arden's Theorem Trick

Pattern:

X = AX + B

Answer:

X = A*B

Pattern:

X = XA + B

Answer:

X = BA*

Remember:

Coefficient on LEFT → star before B.

Coefficient on RIGHT → star after B.

---

# 42. DFA → RE Strategy

Assign a variable to each state.

Write equations based on incoming transitions.

Then solve using Arden's theorem.

This is often faster than state elimination
for small GATE questions.

---

# 43. Closure Properties

Regular languages are closed under:

- Union
- Intersection
- Complement
- Difference
- Concatenation
- Kleene star
- Reversal

Also:

- Homomorphism
- Inverse homomorphism

---

# 44. Important GATE Result

If:

L1 and L2 are regular

then:

L1 ∪ L2 is regular

L1 ∩ L2 is regular

L1 - L2 is regular

L1L2 is regular

L1* is regular

L1^R is regular

---

# 45. Complement Trick

To find complement of a DFA language:

1. DFA must be COMPLETE.
2. Swap final and non-final states.

### GATE Trap

If DFA is incomplete:

First add a dead state.

Then complement.

---

# 46. Product Automaton

For:

L1 ∩ L2

Construct states:

(q1,q2)

Transition:

δ((q1,q2),a)
=
(δ1(q1,a),δ2(q2,a))

For intersection:

both states must be final.

---

# 47. Union Using Product DFA

For:

L1 ∪ L2

A product state is final if:

q1 is final OR q2 is final.

---

# 48. Difference

For:

L1 - L2

Product state is final when:

q1 is final
AND
q2 is NOT final.

---

# 49. Symmetric Difference

For:

L1 Δ L2

Accept when exactly one is final.

Equivalent to XOR.

---

# 50. Regular Language Testing

If a DFA/NFA/RE is given, first determine:

"What property is being checked?"

Common properties:

- Number of symbols
- Parity
- Modulo
- Prefix
- Suffix
- Substring
- Alternation

This often reveals the answer immediately.

---

# 51. GATE PYQ PATTERN 1

Question type:

An NFA has n states.
What is the maximum number of states in an equivalent DFA?

Answer:

2^n

### Example

n = 4

Maximum:

2^4 = 16

### Trap

Do not answer n.

---

# 52. GATE PYQ PATTERN 2

Question type:

An ε-NFA has n states.
What is the maximum number of DFA states?

Answer:

At most 2^n.

ε transitions do not change the theoretical upper bound.

---

# 53. GATE PYQ PATTERN 3

Question type:

Which states can be merged during minimization?

Answer:

Equivalent states.

### Quick Test

If:

one state is final
and another is non-final

they can NEVER be merged.

---

# 54. GATE PYQ PATTERN 4

Question type:

A DFA has n states and alphabet size k.
How many transitions does a complete DFA have?

Answer:

n × k

Example:

n = 7
k = 3

Transitions:

21

---

# 55. GATE PYQ PATTERN 5

Question type:

Which strings are accepted by a given DFA?

### Fast Method

Create a small table:

| Input | State sequence | Final? |
|---|---|---|
| ε | q0 | Yes/No |
| 0 | q0→... | Yes/No |
| 1 | q0→... | Yes/No |
| 01 | ... | Yes/No |

Use short strings to identify the language.

---

# 56. GATE PYQ PATTERN 6

Question type:

Find minimum number of states for:

L = {w | number of 1s is divisible by 4}

Answer:

4 states.

Why?

Need to remember:

0 mod 4
1 mod 4
2 mod 4
3 mod 4

---

# 57. GATE PYQ PATTERN 7

Question type:

Minimum states for strings ending with a fixed pattern.

Example:

Strings ending with 101.

Track the longest suffix that is also
a prefix of 101.

Typical states:

ε
1
10
101

Therefore a DFA can be constructed with
4 relevant states.

---

# 58. GATE PYQ PATTERN 8

Question type:

Find the ε-closure of a state.

### Method

Start with the state itself.

Then repeatedly follow only ε transitions.

Stop when no new state is found.

Never follow 0/1/etc. while computing ε-closure.

---

# 59. GATE PYQ PATTERN 9

Question:

If an NFA has 5 states, can equivalent DFA have
32 states?

YES.

Because:

2^5 = 32

But it is NOT guaranteed.

---

# 60. GATE PYQ PATTERN 10

Question:

Can a DFA recognize a language that an NFA cannot?

NO.

Both recognize exactly regular languages.

The difference is computational representation,
not expressive power.

---

# 61. Important Comparisons

## DFA vs NFA

DFA:
one path for each input.

NFA:
many possible paths.

Acceptance:

DFA:
the unique path must end in final state.

NFA:
at least one possible path must end in final state.

---

# 62. NFA Acceptance Trick

For an NFA:

"OR" interpretation.

If ANY path accepts:

string accepted.

You do NOT need all paths to accept.

---

# 63. DFA Acceptance Trick

For DFA:

exactly one computation path exists.

So simply follow the transitions.

---

# 64. Most Common GATE Traps

### Trap 1

NFA is more powerful than DFA.

WRONG.

---

### Trap 2

2^n DFA states are always produced.

WRONG.

Maximum is 2^n.

---

### Trap 3

ε is an input symbol.

WRONG.

ε represents empty string / no input consumption.

---

### Trap 4

ε-closure excludes the original state.

WRONG.

The original state is always included.

---

### Trap 5

Complement means simply change final states.

Incomplete DFA can cause problems.

First make it complete.

---

### Trap 6

All unreachable states matter.

WRONG.

Remove them before minimization.

---

# 65. Super Important Formulas

### Complete DFA transitions

|Q| × |Σ|

---

### NFA → DFA upper bound

2^|Q|

---

### Product construction

|Q1| × |Q2|

---

### ε-closure

Zero or more ε transitions.

---

### Intersection

Both components final.

---

### Union

At least one component final.

---

# 66. GATE Exam Tricks

## Trick 1 — Use Language Meaning

Do not simulate a DFA for every option.

Understand what states represent.

---

## Trick 2 — Counterexample

For equivalence questions:

Find one string accepted by one
and rejected by another.

Done.

---

## Trick 3 — Shortest Strings First

Try:

ε
0
1
00
01
10
11

before testing long strings.

---

## Trick 4 — Minimize Before Counting

If asked about minimum states:

Remove unreachable states first.

Then merge equivalent states.

---

## Trick 5 — Modulo = Memory

If the machine must remember remainder mod n:

think n states.

---

# 67. Last-Minute Revision Sheet

## DFA

δ : Q × Σ → Q

Exactly one transition.

---

## NFA

δ : Q × Σ → 2^Q

Zero/one/multiple transitions.

---

## ε-NFA

Allows ε transitions.

---

## ε-closure

Zero or more ε moves.

Includes starting state.

---

## NFA → DFA

Subset construction.

Maximum:

2^n

---

## DFA Minimization

1. Remove unreachable states.
2. Separate final/non-final.
3. Refine partitions.
4. Merge equivalent states.

---

## Complement

Complete DFA + swap final/non-final.

---

## Intersection

Product automaton.

Final = both final.

---

## Union

Product automaton.

Final = either final.

---

## Difference

Final = first final AND second non-final.

---

## Modulo

mod n → usually n states.

---

# 68. Final GATE Checklist

[ ] DFA definition
[ ] NFA definition
[ ] ε-NFA
[ ] DFA vs NFA
[ ] Acceptance conditions
[ ] ε-closure
[ ] Subset construction
[ ] 2^n upper bound
[ ] DFA minimization
[ ] Equivalent states
[ ] Distinguishable states
[ ] Trap states
[ ] Reachable states
[ ] DFA complement
[ ] Product automaton
[ ] Intersection
[ ] Union
[ ] Difference
[ ] Reversal
[ ] Arden's theorem
[ ] DFA → RE
[ ] RE → NFA
[ ] Modulo-state trick
[ ] Parity-state trick

---

# 69. 30-SECOND GATE REVISION

DFA:
one transition.

NFA:
zero/one/many transitions.

ε-NFA:
can move without consuming input.

All three:
same expressive power.

NFA n states:
DFA ≤ 2^n.

Complete DFA:
transitions = |Q||Σ|.

ε-closure:
zero or more ε moves + original state.

Minimization:
remove unreachable → partition → refine → merge.

Complement:
complete first → swap final/non-final.

Intersection:
product DFA + BOTH final.

Union:
product DFA + EITHER final.

Modulo n:
usually n states.

Equivalent states:
same acceptance behavior for every possible suffix.
