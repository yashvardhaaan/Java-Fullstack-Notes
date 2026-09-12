## `03-query-key-value.md`

````md
# Query, Key, Value (Q, K, V)

## 1. What Are Query, Key, and Value?

The **Query, Key, Value (QKV)** mechanism is the core idea behind modern attention.

A simple intuition:

- **Query (Q)** → What am I looking for?
- **Key (K)** → What information do I contain / how can I be matched?
- **Value (V)** → What information should I actually provide?

Think of it like a search system:

```text
Query
  ↓
Search / Compare with Keys
  ↓
Find relevant Keys
  ↓
Retrieve their Values
  ↓
Weighted combination
  ↓
Attention output
````

---

# 2. Real-Life Analogy: Library

Imagine you enter a library and ask:

> "Find books about machine learning."

Your request is the:

```text
QUERY
```

Each book has metadata:

```text
Book A:
Title: Introduction to Physics
Keywords: physics, mechanics

Book B:
Title: Machine Learning Basics
Keywords: machine learning, AI

Book C:
Title: Deep Learning
Keywords: neural networks, AI
```

The keywords act like:

```text
KEYS
```

You find the books that match your query.

Then you retrieve the actual book information:

```text
VALUES
```

So:

```text
Query → What am I looking for?
Key   → How do I match it?
Value → What information do I retrieve?
```

---

# 3. Why Do We Need Three Things?

A common beginner question is:

> Why can't we just compare the words directly?

Because attention needs to perform two different jobs:

### Job 1: Determine relevance

```text
Query ↔ Key
```

This tells us:

> "How relevant is this token?"

### Job 2: Retrieve information

```text
Attention weights × Values
```

This tells us:

> "What information should I use?"

Therefore:

```text
Q + K → relevance
V     → information
```

---

# 4. Sentence Example

Consider:

```text
"The cat drank milk because it was thirsty."
```

Suppose we are processing:

```text
"it"
```

The model wants to determine what information is relevant to `"it"`.

The query associated with `"it"` can be thought of as:

```text
Q_it
```

Every token has a key:

```text
K_the
K_cat
K_drank
K_milk
K_because
K_it
K_was
K_thirsty
```

The query is compared with every key:

```text
Q_it · K_the
Q_it · K_cat
Q_it · K_drank
Q_it · K_milk
...
```

Suppose the scores are:

```text
the       → 0.2
cat       → 4.5   ← strong match
drank     → 0.5
milk      → 1.2
because   → 0.3
it        → 0.8
was       → 0.4
thirsty   → 1.5
```

After softmax, the scores become attention weights.

The model can then retrieve information from the corresponding values.

---

# 5. The Core Formula

The basic attention formula is:

$$
\text{Attention}(Q,K,V)
=
\text{softmax}(QK^T)V
$$

This is the simplified form.

Later we will add scaling:

$$
\text{Attention}(Q,K,V)
=
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

We will study that in:

`05-scaled-dot-product-attention.md`

---

# 6. Understanding Q, K, V Mathematically

Suppose we have 3 tokens.

Each token is represented by an embedding:

```text
X =
[
  x1
  x2
  x3
]
```

We create Q, K, and V using learned weight matrices.

```text
Q = XW_Q

K = XW_K

V = XW_V
```

Where:

* `X` = input embeddings
* `W_Q` = query weight matrix
* `W_K` = key weight matrix
* `W_V` = value weight matrix

These weight matrices are **learned during training**.

---

# 7. Important Insight

The input token representation:

```text
X
```

is transformed into three different representations:

```text
             X
          /  |  \
         /   |   \
        ↓    ↓    ↓
       Q     K     V
```

Each serves a different purpose.

```text
Q → used for asking
K → used for matching
V → used for retrieving
```

---

# 8. Practical Example With Matrices

Let's build a tiny attention system.

We will use:

```text
3 tokens
2-dimensional embeddings
```

Our input matrix:

```python
import numpy as np

X = np.array([
    [1.0, 0.0],   # token 1
    [0.0, 1.0],   # token 2
    [1.0, 1.0],   # token 3
])

print(X)
```

Output:

```text
[[1. 0.]
 [0. 1.]
 [1. 1.]]
```

---

# 9. Define Learned Weight Matrices

For simplicity, we will use small matrices.

```python
W_Q = np.array([
    [1.0, 0.0],
    [0.0, 1.0]
])

W_K = np.array([
    [1.0, 0.0],
    [0.0, 1.0]
])

W_V = np.array([
    [1.0, 0.0],
    [0.0, 1.0]
])
```

In a real Transformer, these matrices are learned parameters.

Here they are identity matrices so that we can easily see what's happening.

---

# 10. Calculate Q, K, V

Use:

$$
Q = XW_Q
$$

$$
K = XW_K
$$

$$
V = XW_V
$$

Python:

```python
Q = X @ W_Q
K = X @ W_K
V = X @ W_V

print("Q:")
print(Q)

print("K:")
print(K)

print("V:")
print(V)
```

Since our matrices are identity matrices:

```text
Q =
[[1. 0.]
 [0. 1.]
 [1. 1.]]

K =
[[1. 0.]
 [0. 1.]
 [1. 1.]]

V =
[[1. 0.]
 [0. 1.]
 [1. 1.]]
```

---

# 11. Calculate Attention Scores

Now compare every query with every key.

Formula:

$$
S = QK^T
$$

Python:

```python
scores = Q @ K.T

print(scores)
```

Let's calculate manually.

We have:

```text
Q =
[1 0]
[0 1]
[1 1]
```

and:

```text
Kᵀ =
[1 0 1]
[0 1 1]
```

Therefore:

```text
QKᵀ =

[1 0] × [1 0 1]
[0 1]   [0 1 1]
[1 1]
```

Result:

```text
[
 [1, 0, 1],
 [0, 1, 1],
 [1, 1, 2]
]
```

So:

```text
scores =
[[1, 0, 1],
 [0, 1, 1],
 [1, 1, 2]]
```

---

# 12. What Does the Score Matrix Mean?

The matrix:

```text
[[1, 0, 1],
 [0, 1, 1],
 [1, 1, 2]]
```

can be interpreted as:

```text
             Key 1   Key 2   Key 3

Query 1        1       0       1

Query 2        0       1       1

Query 3        1       1       2
```

For Query 3:

```text
[1, 1, 2]
```

the strongest match is:

```text
Key 3 → score 2
```

So Query 3 is most similar to Key 3.

---

# 13. Why Dot Product?

We use:

$$
QK^T
$$

because the dot product measures similarity between vectors.

For two vectors:

```text
A = [a1, a2]

B = [b1, b2]
```

their dot product is:

$$
A \cdot B = a_1b_1 + a_2b_2
$$

Example:

```text
[1, 1] · [1, 1]

= 1×1 + 1×1

= 2
```

Higher dot product generally means stronger alignment.

---

# 14. Convert Scores Into Attention Weights

Raw scores are not yet probabilities.

We apply softmax row-wise.

```python
def softmax(x):
    exp_x = np.exp(x - np.max(x, axis=-1, keepdims=True))
    return exp_x / exp_x.sum(axis=-1, keepdims=True)


attention_weights = softmax(scores)

print(attention_weights)
```

Each row sums to 1.

Conceptually:

```text
Query 1:
[0.422, 0.155, 0.422]

Query 2:
[0.155, 0.422, 0.422]

Query 3:
[0.212, 0.212, 0.576]
```

The exact values come from softmax.

Notice Query 3 gives the highest weight to Key 3.

---

# 15. Retrieve Information From Values

Now:

$$
Output = AttentionWeights \times V
$$

Python:

```python
output = attention_weights @ V

print(output)
```

This produces a new representation for every token.

The output contains information gathered from other tokens according to their attention weights.

---

# 16. Complete Practical Implementation

```python
import numpy as np


def softmax(x):
    exp_x = np.exp(x - np.max(x, axis=-1, keepdims=True))
    return exp_x / exp_x.sum(axis=-1, keepdims=True)


# Input embeddings
X = np.array([
    [1.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0],
])


# Learned projection matrices
W_Q = np.array([
    [1.0, 0.0],
    [0.0, 1.0]
])

W_K = np.array([
    [1.0, 0.0],
    [0.0, 1.0]
])

W_V = np.array([
    [1.0, 0.0],
    [0.0, 1.0]
])


# Step 1: Create Q, K, V
Q = X @ W_Q
K = X @ W_K
V = X @ W_V


# Step 2: Calculate attention scores
scores = Q @ K.T


# Step 3: Convert scores into weights
attention_weights = softmax(scores)


# Step 4: Weighted combination of values
output = attention_weights @ V


print("Q:")
print(Q)

print("\nK:")
print(K)

print("\nV:")
print(V)

print("\nAttention Scores:")
print(scores)

print("\nAttention Weights:")
print(attention_weights)

print("\nAttention Output:")
print(output)
```

---

# 17. The Entire Process

Memorize this pipeline:

```text
Input Embeddings
       ↓
      X
    / | \
   ↓  ↓  ↓
  Q   K   V
   \  /
    \/
  QKᵀ
   ↓
Scores
   ↓
Softmax
   ↓
Attention Weights
   ↓
Weights × V
   ↓
Attention Output
```

Or in one equation:

$$
\boxed{
\text{Attention}(Q,K,V)
=
\text{softmax}(QK^T)V
}
$$

---

# 18. Why Q and K Are Separate From V

This is extremely important.

Suppose a token contains a lot of information.

We don't necessarily want to use all of that information to decide whether the token is relevant.

Therefore:

```text
Q/K → decide relevance

V   → provide information
```

Think:

```text
Q: "What am I searching for?"

K: "Do I match that search?"

V: "Here is the information I contain."
```

---

# 19. Self-Attention Connection

In **self-attention**, Q, K, and V all originate from the same input:

```text
X
│
├──→ Q = XWQ
├──→ K = XWK
└──→ V = XWV
```

Therefore:

```text
same input
     ↓
Q, K, V
     ↓
self-attention
```

This allows tokens in a sequence to interact with one another.

We will study self-attention in:

`07-self-attention.md`

---

# 20. Important Dimensions

Suppose:

```text
X shape = (n, d_model)
```

where:

* `n` = number of tokens
* `d_model` = embedding dimension

Suppose:

```text
W_Q shape = (d_model, d_k)

W_K shape = (d_model, d_k)

W_V shape = (d_model, d_v)
```

Then:

```text
Q shape = (n, d_k)

K shape = (n, d_k)

V shape = (n, d_v)
```

Now:

```text
Q @ K.T
```

has shape:

```text
(n, d_k) @ (d_k, n)
```

giving:

```text
(n, n)
```

This is the **attention score matrix**.

Then:

```text
(n, n) @ (n, d_v)
```

gives:

```text
(n, d_v)
```

So the output has one vector per input token.

---

# 21. Shape Trick

Remember:

```text
X       → (n, d_model)

Q       → (n, d_k)
K       → (n, d_k)
V       → (n, d_v)

QKᵀ     → (n, n)

Softmax → (n, n)

Weights × V
          ↓
        (n, d_v)
```

This is extremely useful for debugging Transformer code.

---

# 22. Common Beginner Mistakes

### Mistake 1

Thinking:

```text
Q = words
K = words
V = words
```

Not exactly.

Q, K, and V are **learned projections of representations**:

$$
Q=XW_Q
$$

$$
K=XW_K
$$

$$
V=XW_V
$$

---

### Mistake 2

Thinking Q, K, and V are three different sentences.

No.

In self-attention, they generally come from the **same input sequence**.

---

### Mistake 3

Thinking attention weights are the final output.

No.

```text
Scores
 ↓
Softmax
 ↓
Attention weights
 ↓
Weighted sum with V
 ↓
Output
```

---

### Mistake 4

Forgetting the transpose.

Attention scores use:

$$
QK^T
$$

not simply:

$$
QK
$$

because the dimensions must align and we want every query compared with every key.

---

# 23. GATE / Interview Questions

### Q1. What are Q, K, and V?

```text
Q → Query
K → Key
V → Value
```

Query and Key determine relevance; Value carries the information that is aggregated.

---

### Q2. How are Q, K, V generated?

$$
Q=XW_Q
$$

$$
K=XW_K
$$

$$
V=XW_V
$$

---

### Q3. What is the attention score matrix?

$$
QK^T
$$

before scaling and softmax.

---

### Q4. What is the shape of QKᵀ?

If there are `n` tokens:

$$
QK^T \in \mathbb{R}^{n\times n}
$$

---

### Q5. Why is the score matrix `n × n`?

Because every query compares itself with **every key**.

```text
n queries × n keys
```

---

# 24. One-Line Memory Trick

> **Q asks, K matches, V gives.**

```text
Q → "What do I need?"
K → "How well do you match?"
V → "Here's the information."
```

Then:

```text
Q × Kᵀ
    ↓
Scores
    ↓
Softmax
    ↓
Weights
    ↓
× V
    ↓
Output
```

---

# 25. Next Topic

We now know:

```text
Q → Query
K → Key
V → Value
```

and:

$$
QK^T
$$

produces relevance scores.

But we haven't deeply studied:

> **What exactly does the dot product score mean, and why does it measure similarity?**

That is the next file:

`04-attention-score.md`

```
```
