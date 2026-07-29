# Probability

## Definition

**Probability** is the measure of how likely an event is to occur.

The probability of an event always lies between

```
0

and

1
```

or

```
0%

to

100%
```

Formula

```
Probability

=

Number of Favorable Outcomes

────────────────────────────

Total Number of Possible Outcomes
```

Notation

```
P(E)
```

where

```
E

=

Event
```

---

# Why Learn This?

Probability helps in making decisions under uncertainty.

Applications include:

- **Software Engineering** – Randomized algorithms, hashing, and A/B testing.
- **Artificial Intelligence** – Bayesian models and probabilistic reasoning.
- **Data Science** – Predictive modeling and statistical inference.
- **Finance** – Risk assessment and investment analysis.
- **Healthcare** – Disease prediction and clinical research.
- **Weather Forecasting** – Predicting rainfall and temperature trends.

---

# Prerequisites

Before learning Probability, you should know:

- Fractions
- Percentages
- Permutations
- Combinations
- Basic Counting

---

# Basic Terminology

## Experiment

An action that produces outcomes.

Example

```
Rolling a die
```

---

## Outcome

A possible result of an experiment.

Example

```
Rolling

4
```

---

## Sample Space (S)

The set of all possible outcomes.

Example

Rolling one die

```
S

=

{1,2,3,4,5,6}
```

Number of outcomes

```
n(S)=6
```

---

## Event (E)

A subset of the sample space.

Example

Getting an even number

```
E

=

{2,4,6}
```

---

# Probability Formula

```
P(E)

=

n(E)

──────

n(S)
```

Example

Probability of getting an even number on a die.

```
Favorable Outcomes

=3
```

```
Total Outcomes

=6
```

```
P(E)

=3/6

=1/2
```

---

# Types of Events

## Simple Event

Contains only one outcome.

Example

```
Getting

5
```

---

## Compound Event

Contains multiple outcomes.

Example

```
Even Number

{2,4,6}
```

---

## Impossible Event

```
P(E)=0
```

Example

Getting

```
7
```

on a standard die.

---

## Certain Event

```
P(E)=1
```

Example

Getting a number less than

```
7
```

on a standard die.

---

# Complement of an Event

Formula

```
P(E')

=

1−P(E)
```

Example

If

```
P(A)=0.65
```

Then

```
P(A')

=0.35
```

---

# Addition Rule

## Mutually Exclusive Events

Formula

```
P(A∪B)

=

P(A)+P(B)
```

Example

Probability of getting

```
1

or

4
```

on a die.

```
1/6+1/6

=2/6

=1/3
```

---

## General Addition Rule

```
P(A∪B)

=

P(A)

+

P(B)

−

P(A∩B)
```

---

# Multiplication Rule

## Independent Events

Formula

```
P(A∩B)

=

P(A)

×

P(B)
```

Example

Two coin tosses

Probability of two heads

```
1/2×1/2

=1/4
```

---

## Dependent Events

Formula

```
P(A∩B)

=

P(A)

×

P(B|A)
```

where

```
P(B|A)
```

means probability of

```
B

given

A
```

---

# Conditional Probability

Formula

```
P(A|B)

=

P(A∩B)

────────

P(B)
```

Condition

```
P(B)>0
```

---

# Independent Events

Two events are independent if

```
P(A∩B)

=

P(A)×P(B)
```

Example

Rolling a die and tossing a coin.

---

# Mutually Exclusive Events

Two events cannot happen together.

Example

Getting

```
2

and

5
```

in one roll of a die.

---

# Important Formulae

## Basic Probability

```
P(E)

=

Favorable

────────

Total
```

---

## Complement

```
1−P(E)
```

---

## Addition Rule

```
P(A)+P(B)

−P(A∩B)
```

---

## Independent Events

```
P(A)×P(B)
```

---

## Conditional Probability

```
P(A∩B)

────────

P(B)
```

---

# Relationship Diagram

```
Experiment
      │
      ▼
Sample Space
      │
      ▼
Choose Event
      │
      ▼
Apply Formula
      │
      ▼
Probability
```

---

# Solving Strategy

```
Read Question
      │
      ▼
Find Sample Space
      │
      ▼
Find Favorable Outcomes
      │
      ▼
Choose Formula
      │
      ▼
Simplify
      │
      ▼
Answer
```

---

# Shortcuts & Tricks

### 1. Probability is always

```
0≤P(E)≤1
```

---

### 2. If all outcomes are equally likely,

Use

```
Favorable

──────

Total
```

---

### 3. "OR"

Usually indicates

```
Addition Rule
```

---

### 4. "AND"

Usually indicates

```
Multiplication Rule
```

---

### 5. "At least one"

Often easier to solve using the complement.

```
P(At least one)

=

1−P(None)
```

---

# Solved Examples

## Example 1

Find the probability of getting an odd number on a die.

Solution

```
Odd Numbers

={1,3,5}

=3 outcomes
```

```
P

=3/6

=1/2
```

Answer

```
1/2
```

---

## Example 2

A coin is tossed twice.

Find the probability of getting two heads.

Sample Space

```
HH

HT

TH

TT
```

Favorable Outcomes

```
HH
```

Probability

```
1/4
```

Answer

```
1/4
```

---

## Example 3

A card is drawn from a standard deck.

Find the probability of drawing an Ace.

Solution

```
Aces

=4
```

```
Cards

=52
```

```
P

=4/52

=1/13
```

Answer

```
1/13
```

---

## Example 4

If

```
P(A)=0.72
```

Find

```
P(A')
```

Solution

```
1−0.72

=0.28
```

Answer

```
0.28
```

---

# Common Mistakes

### Mistake 1

Using the wrong sample space.

---

### Mistake 2

Adding probabilities of events that are **not** mutually exclusive.

---

### Mistake 3

Ignoring replacement or non-replacement in card and ball problems.

---

### Mistake 4

Confusing independent and dependent events.

---

### Mistake 5

Forgetting to use the complement for "at least one" questions.

---

# Previous Year Question Pattern

Frequently tested concepts:

- Dice
- Coins
- Cards
- Conditional Probability
- Independent Events
- Complement Rule
- Probability with Permutations and Combinations

---

# Practice Questions (with Answers)

## Q1

A die is rolled once.

Find the probability of getting a prime number.

**Answer**

Prime numbers

```
{2,3,5}
```

```
3/6

=1/2
```

---

## Q2

A coin is tossed three times.

Find the probability of getting all heads.

**Answer**

```
1/8
```

---

## Q3

A card is drawn from a standard deck.

Find the probability of drawing a King.

**Answer**

```
4/52

=1/13
```

---

## Q4

A bag contains

```
5

red

and

7

blue
```

balls.

Find the probability of drawing a red ball.

**Answer**

```
5/12
```

---

## Q5

If

```
P(A)=0.45
```

Find

```
P(A')
```

**Answer**

```
0.55
```

---

# Quick Revision Sheet

| Concept | Formula |
|----------|---------|
| Basic Probability | Favorable Outcomes / Total Outcomes |
| Complement | P(A') = 1 − P(A) |
| Addition Rule | P(A ∪ B) = P(A) + P(B) − P(A ∩ B) |
| Independent Events | P(A ∩ B) = P(A) × P(B) |
| Conditional Probability | P(A\|B) = P(A ∩ B) / P(B) |
| Impossible Event | P = 0 |
| Certain Event | P = 1 |

---

# GATE 80/20 Summary

✅ Probability always lies between

```
0

and

1
```

✅ Memorize:

- **P(E) = Favorable / Total**
- **P(A') = 1 − P(A)**
- **Addition Rule**
- **Multiplication Rule**
- **Conditional Probability**

✅ Keywords:

- **OR → Addition**
- **AND → Multiplication**
- **At least one → Complement**

✅ Most aptitude questions involve **dice, coins, cards, bags, conditional probability, and independent events**.

---

# Next File

➡️ `18-Set-Theory.md`