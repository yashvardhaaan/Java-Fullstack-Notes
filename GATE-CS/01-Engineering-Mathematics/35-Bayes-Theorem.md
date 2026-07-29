# Bayes' Theorem

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Bayes' Theorem?

Sometimes we know

```
Effect

↓

Cause?
```

instead of

```
Cause

↓

Effect
```

For example

- A medical test is positive. What is the probability the person actually has the disease?
- An email is classified as spam. What is the probability it is truly spam?
- A network packet is corrupted. Which channel most likely sent it?

Bayes' Theorem helps us **reverse conditional probabilities**.

---

# Intuition

Suppose

```
95%
```

of infected people test positive.

A person tests positive.

Question:

```
What is the probability

that the person is infected?
```

Notice

We know

```
P(Test Positive | Disease)
```

But we want

```
P(Disease | Test Positive)
```

Bayes' Theorem converts one into the other.

---

# Definition

Bayes' Theorem calculates the probability of an event based on new evidence.

Notation

```
P(A|B)
```

where

```
A

↓

Required Event
```

```
B

↓

Observed Evidence
```

---

# Bayes' Formula

```
               P(B|A) × P(A)

P(A|B)

=

----------------------------

          P(B)
```

This is the **most important formula**.

---

# Expanded Formula

Using the Law of Total Probability,

```
                    P(B|A)P(A)

P(A|B)

=

----------------------------------------

P(B|A)P(A)+P(B|A')P(A')
```

where

```
A'

↓

Complement of A
```

This form is frequently used in GATE problems.

---

# Components of Bayes' Theorem

### Prior Probability

Initial belief.

```
P(A)
```

---

### Likelihood

Probability of evidence given the event.

```
P(B|A)
```

---

### Evidence

Overall probability of the observed evidence.

```
P(B)
```

---

### Posterior Probability

Updated probability after observing evidence.

```
P(A|B)
```

---

# Flow of Bayes' Theorem

```
Prior

↓

Observe Evidence

↓

Update Belief

↓

Posterior
```

---

# Example 1

A bag contains

```
3 Red

2 Blue
```

One ball is selected.

Given that the selected ball is **Red**,

find

```
P(Red | Selected is Red)
```

This is directly

```
1
```

(Simple illustration of conditional probability.)

---

# Example 2 (Medical Test)

Suppose

```
P(Disease)

=

0.01
```

```
P(Positive | Disease)

=

0.99
```

```
P(Positive | No Disease)

=

0.05
```

Find

```
P(Disease | Positive)
```

Using Bayes

```
                 0.99 × 0.01

----------------------------------------

0.99×0.01 + 0.05×0.99

≈

0.1667
```

Meaning

Even with a positive result,

the probability of actually having the disease is about

```
16.67%
```

because the disease itself is rare.

---

# Law of Total Probability

Bayes' Theorem depends on

```
P(B)
```

which is found using

```
P(B)

=

ΣP(B|Ai)P(Ai)
```

where

```
Ai
```

partition the sample space.

---

# Bayes' Theorem and Conditional Probability

Conditional Probability

```
Forward Direction
```

```
P(A|B)
```

---

Bayes' Theorem

```
Reverse Direction
```

```
P(B|A)

↓

P(A|B)
```

---

# Tree Diagram

```
Start

│

├── Disease

│      │

│      ├── Positive

│      └── Negative

│

└── No Disease

       │

       ├── Positive

       └── Negative
```

Bayes' Theorem works naturally with tree diagrams.

---

# Applications

Bayes' Theorem is widely used in

- Machine Learning
- Artificial Intelligence
- Spam Filtering
- Medical Diagnosis
- Recommendation Systems
- Search Engines
- Risk Analysis
- Robotics

---

# Bayes' Classifier

One of the most important Machine Learning algorithms.

```
Naive Bayes
```

uses Bayes' Theorem assuming feature independence.

Frequently asked in interviews.

---

# Relationship with Naive Bayes

```
Bayes' Theorem

↓

Probability Update

↓

Naive Bayes

↓

Classification
```

---

# Common GATE PYQs

- Bayes' Formula
- Prior Probability
- Posterior Probability
- Conditional Probability
- Medical Diagnosis Problems
- Total Probability
- Probability Trees

---

# Quick Revision

✅ Bayes' Theorem

✅ Prior

✅ Posterior

✅ Likelihood

✅ Evidence

✅ Total Probability

---

# Common Mistakes

❌ Confusing

```
P(A|B)

with

P(B|A)
```

They are **not the same**.

---

❌ Forgetting to calculate

```
P(B)
```

using the Law of Total Probability.

---

❌ Using the wrong complement

```
A'
```

---

❌ Mixing prior probability with posterior probability.

---

# Memory Tricks

### Bayes

```
Reverse

Conditional

Probability
```

---

### Formula

```
Likelihood

×

Prior

----------------

Evidence
```

---

### Order

```
Prior

↓

Evidence

↓

Posterior
```

---

### Remember

```
Posterior

=

Updated Belief
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `P(A|B)=P(B|A)P(A)/P(B)` | Bayes' Theorem |
| `P(B)=ΣP(B|Ai)P(Ai)` | Law of Total Probability |
| `P(A')=1-P(A)` | Complement Rule |
| `P(A∩B)=P(A|B)P(B)` | Multiplication Rule |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Bayes' Formula
- Posterior Probability
- Prior Probability
- Medical Test Problems
- Total Probability
- Conditional Probability

---

# Interview Corner

### Q1. What is Bayes' Theorem used for?

It is used to **update the probability of an event after observing new evidence**.

---

### Q2. What is the difference between Prior and Posterior Probability?

- **Prior Probability:** Initial probability before seeing evidence.
- **Posterior Probability:** Updated probability after considering the evidence.

---

### Q3. Why is Bayes' Theorem important in Machine Learning?

Algorithms like **Naive Bayes** use Bayes' Theorem to classify data efficiently by updating probabilities based on observed features.

---

# GATE 80/20 Summary

### Must Remember

- ✅ Bayes' Theorem:

```
               P(B|A)P(A)

P(A|B)

=

----------------

      P(B)
```

- ✅ Prior = Initial belief.
- ✅ Likelihood = Probability of evidence given the event.
- ✅ Posterior = Updated belief.
- ✅ Use the **Law of Total Probability** to compute `P(B)` when required.
- ✅ Bayes' Theorem is heavily used in **Machine Learning**, especially **Naive Bayes**.

---

# Engineering Mathematics Completed ✅

You have now completed the **Probability & Statistics** section and the entire **Engineering Mathematics** syllabus for GATE CSE, including:

### Linear Algebra
- ✅ Matrices
- ✅ Determinants
- ✅ System of Linear Equations
- ✅ Eigenvalues & Eigenvectors
- ✅ LU Decomposition

### Calculus
- ✅ Limits
- ✅ Continuity & Differentiability
- ✅ Maxima & Minima
- ✅ Mean Value Theorem
- ✅ Integration

### Probability & Statistics
- ✅ Random Variables
- ✅ Uniform Distribution
- ✅ Normal Distribution
- ✅ Exponential Distribution
- ✅ Poisson Distribution
- ✅ Binomial Distribution
- ✅ Mean, Median & Mode
- ✅ Standard Deviation
- ✅ Conditional Probability
- ✅ Bayes' Theorem

🎉 **Engineering Mathematics for GATE CSE is now complete.**