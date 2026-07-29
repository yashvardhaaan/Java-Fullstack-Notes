# Conditional Probability

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Conditional Probability?

Many real-life probabilities depend on **additional information**.

Examples

- What is the probability that a student passes **given that they studied**?
- What is the probability that a packet is corrupted **given that network congestion occurred**?
- What is the probability of drawing an Ace **given that the card drawn is a Spade**?

These are solved using **Conditional Probability**.

---

# Intuition

Suppose you draw one card from a deck.

Initially

```
Total Cards

=

52
```

Now someone tells you

```
The card is a Spade.
```

Now your sample space changes.

```
Only Spades

=

13 Cards
```

Instead of considering all 52 cards,

you now consider only the **new sample space**.

This is the main idea behind Conditional Probability.

---

# Definition

Conditional Probability is the probability of an event occurring

**given that another event has already occurred.**

Notation

```
P(A|B)
```

Read as

```
Probability of A

Given

B
```

---

# Formula

```
          P(A∩B)

P(A|B)=------------

            P(B)
```

where

```
P(B)>0
```

This is the **most important formula**.

---

# Meaning of Symbols

```
A

↓

Required Event
```

---

```
B

↓

Given Event
```

---

```
A∩B

↓

Both A and B occur
```

---

# Intuition Behind the Formula

Originally

```
Sample Space

=

All Outcomes
```

After knowing

```
B happened
```

New Sample Space becomes

```
Only Event B
```

Therefore

```
Probability

=

Favorable Outcomes

------------------

Possible Outcomes
```

becomes

```
        A∩B

------------------

B
```

---

# Example 1

A fair die is rolled.

Find

```
P(Even | Number > 3)
```

Step 1

```
Numbers >3

=

{4,5,6}
```

New sample space

```
3 outcomes
```

Step 2

Even numbers

```
{4,6}
```

Answer

```
2/3
```

---

# Example 2

A card is drawn.

Find

```
P(Ace | Spade)
```

Spades

```
13 cards
```

Only one Ace of Spades

Answer

```
1/13
```

---

# Multiplication Rule

From the conditional probability formula

```
P(A∩B)

=

P(A|B)

×

P(B)
```

Similarly

```
P(A∩B)

=

P(B|A)

×

P(A)
```

Very Important.

---

# Independent Events

Two events are independent if

```
Occurrence of one

Does NOT Affect

the other.
```

Formula

```
P(A|B)

=

P(A)
```

Equivalent formula

```
P(A∩B)

=

P(A)

×

P(B)
```

---

# Dependent Events

Events are dependent if

```
Knowing one

Changes

the probability

of the other.
```

Example

Drawing two cards

```
Without Replacement
```

---

# Independent vs Dependent

| Independent | Dependent |
|-------------|-----------|
| No effect | Probability changes |
| `P(A∩B)=P(A)P(B)` | Multiplication rule with conditional probability |
| Coin tosses | Cards without replacement |

---

# Tree Diagram

Example

```
Start

│

├── Success

│      │

│      ├── Success

│      └── Failure

│

└── Failure

       │

       ├── Success

       └── Failure
```

Tree diagrams help solve conditional probability questions.

---

# Conditional Probability Table

| Formula | Meaning |
|----------|----------|
| `P(A|B)` | Probability of A given B |
| `P(B|A)` | Probability of B given A |

---

# Law of Total Probability

If

```
B₁

B₂

...

Bn
```

partition the sample space,

then

```
P(A)

=

Σ P(A|Bi)P(Bi)
```

Frequently used before Bayes' Theorem.

---

# Relationship with Bayes' Theorem

Conditional Probability leads directly to

```
Bayes' Theorem
```

which reverses conditional probabilities.

---

# Applications

Conditional Probability is used in

- Medical Diagnosis
- Spam Detection
- Machine Learning
- Artificial Intelligence
- Reliability Engineering
- Data Science
- Risk Analysis

---

# Common GATE PYQs

- Conditional Probability Formula
- Independent Events
- Multiplication Rule
- Cards
- Dice
- Tree Diagrams
- Law of Total Probability

---

# Quick Revision

✅ Conditional Probability

✅ Formula

✅ Multiplication Rule

✅ Independent Events

✅ Dependent Events

✅ Total Probability

---

# Common Mistakes

❌ Using

```
P(A)

instead of

P(A|B)
```

---

❌ Forgetting to change the sample space after the condition is given.

---

❌ Confusing independent and mutually exclusive events.

---

❌ Forgetting

```
P(B)>0
```

for conditional probability.

---

# Memory Tricks

### Conditional Probability

```
Condition

↓

New Sample Space
```

---

### Formula

```
Common Part

------------

Given Part
```

---

### Independent

```
No Effect

↓

Multiply Probabilities
```

---

### Dependent

```
Information

Changes

Probability
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `P(A|B)=P(A∩B)/P(B)` | Conditional Probability |
| `P(A∩B)=P(A|B)P(B)` | Multiplication Rule |
| `P(A∩B)=P(B|A)P(A)` | Alternative Form |
| `P(A∩B)=P(A)P(B)` | Independent Events |
| `P(A)=ΣP(A|Bi)P(Bi)` | Law of Total Probability |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Conditional Probability
- Multiplication Rule
- Independent Events
- Dependent Events
- Cards & Dice Problems
- Law of Total Probability

---

# Interview Corner

### Q1. What is Conditional Probability?

It is the probability of an event occurring **given that another event has already occurred**.

---

### Q2. What is the difference between independent and dependent events?

- **Independent Events:** One event does not affect the probability of the other.
- **Dependent Events:** Knowing one event changes the probability of the other.

---

### Q3. Why does the sample space change in Conditional Probability?

Because the given event has already occurred, only outcomes satisfying that event remain possible. Therefore, the **sample space is reduced**.

---

# GATE 80/20 Summary

### Must Remember

- ✅ Conditional Probability:

```
P(A|B)

=

P(A∩B)

--------

P(B)
```

- ✅ Multiplication Rule:

```
P(A∩B)

=

P(A|B)P(B)
```

- ✅ Independent Events:

```
P(A∩B)

=

P(A)P(B)
```

- ✅ Always **change the sample space** after the condition is given.
- ✅ Law of Total Probability is frequently combined with **Bayes' Theorem**.

---

# Next File

➡️ `35-Bayes-Theorem.md`