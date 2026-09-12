## `04-attention-score.md`

````md
# Attention Score

## 1. What Is an Attention Score?

An **attention score** tells us how strongly a Query (Q) is related to a Key (K).

In simple words:

> **Attention score = How relevant is this Key to this Query?**

The most common attention score used in Transformers is the **dot product**:

$$
\boxed{
\text{score}(Q,K)=QK^T
}
$$

This score is calculated **before softmax**.

---

# 2. Where Does the Attention Score Fit?

The complete attention process is:

```text
Input
  ↓
Q, K, V
  ↓
QKᵀ
  ↓
Attention Scores
  ↓
Scaling
  ↓
Softmax
  ↓
Attention Weights
  ↓
Weighted Sum with V
  ↓
Output
````

So:

```text
QKᵀ = attention scores
```

---

# 3. Why Compare Query and Key?

Suppose we have:

```text
"The cat drank milk because it was thirsty."
```

When processing:

```text
"it"
```

we want to determine which other tokens are relevant.

The query for `"it"` is compared with the keys of all tokens:

```text
Q_it · K_the
Q_it · K_cat
Q_it · K_drank
Q_it · K_milk
Q_it · K_because
Q_it · K_it
Q_it · K_was
Q_it · K_thirsty
```

Each comparison produces one score.

Conceptually:

```text
               Score

the             0.2
cat             4.8   ← strong relationship
drank           0.4
milk            1.1
because         0.3
it              0.7
was             0.2
thirsty         1.4
```

Higher score → stronger alignment.

---

# 4. Dot Product

For two vectors:

$$
Q=[q_1,q_2,...,q_d]
$$

and

$$
K=[k_1,k_2,...,k_d]
$$

the dot product is:

$$
Q\cdot K
=
q_1k_1+q_2k_2+\cdots+q_dk_d
$$

For two-dimensional vectors:

```text
Q = [2, 3]

K = [4, 5]
```

Then:

$$
Q\cdot K
=
(2)(4)+(3)(5)
$$

$$
=8+15
$$

$$
=23
$$

So the attention score is:

```text
23
```

---

# 5. Why Does Dot Product Measure Similarity?

Consider:

```text
Q = [1, 1]

K₁ = [1, 1]

K₂ = [1, -1]
```

Calculate:

$$
Q\cdot K_1
=
1(1)+1(1)
=
2
$$

But:

$$
Q\cdot K_2
=
1(1)+1(-1)
=
0
$$

Therefore:

```text
Q · K₁ = 2
Q · K₂ = 0
```

`K₁` is more aligned with `Q`.

Geometrically:

$$
Q\cdot K
=
|Q||K|\cos(\theta)
$$

where:

* $|Q|$ = magnitude of Q
* $|K|$ = magnitude of K
* $\theta$ = angle between Q and K

---

# 6. Geometric Intuition

The dot product depends on the angle between vectors.

### Same direction

```text
Q  ─────────→
K  ─────────→
```

Angle ≈ 0°

```text
cos(0°) = 1
```

Large positive dot product.

---

### Perpendicular

```text
       K
       ↑
       |
       |
       +────────→ Q
```

Angle = 90°

```text
cos(90°) = 0
```

Dot product ≈ 0.

---

### Opposite direction

```text
Q  ─────────→

K  ←─────────
```

Angle ≈ 180°

```text
cos(180°) = -1
```

Negative dot product.

---

# 7. Important Point: Magnitude Also Matters

The dot product is:

$$
Q\cdot K=|Q||K|\cos(\theta)
$$

Therefore, it depends on **both**:

1. Direction
2. Magnitude

This is important because very large vectors can produce very large scores.

That becomes a problem when the dimensionality increases.

This is one reason Transformers use **scaled dot-product attention**.

We will study that in:

`05-scaled-dot-product-attention.md`

---

# 8. Single Query Example

Suppose:

```text
Q = [1, 2]
```

and we have three keys:

```text
K₁ = [1, 1]
K₂ = [2, 0]
K₃ = [0, 2]
```

Calculate the scores.

### Score 1

$$
Q\cdot K_1
=
(1)(1)+(2)(1)
=
3
$$

### Score 2

$$
Q\cdot K_2
=
(1)(2)+(2)(0)
=
2
$$

### Score 3

$$
Q\cdot K_3
=
(1)(0)+(2)(2)
=
4
$$

Therefore:

```text
K₁ → 3
K₂ → 2
K₃ → 4
```

The strongest match is:

```text
K₃
```

---

# 9. Practical Python Example

Let's calculate the same thing using NumPy.

```python
import numpy as np

Q = np.array([1, 2])

K1 = np.array([1, 1])
K2 = np.array([2, 0])
K3 = np.array([0, 2])

score1 = Q @ K1
score2 = Q @ K2
score3 = Q @ K3

print("Score K1:", score1)
print("Score K2:", score2)
print("Score K3:", score3)
```

Output:

```text
Score K1: 3
Score K2: 2
Score K3: 4
```

Therefore:

```text
K3 has the highest attention score.
```

---

# 10. Multiple Queries and Keys

In a Transformer, we don't normally have only one query.

Suppose:

```text
Q =
[
  q₁
  q₂
  q₃
]
```

and:

```text
K =
[
  k₁
  k₂
  k₃
]
```

We want every query compared with every key.

Therefore:

```text
          K1    K2    K3

Q1       ?     ?     ?

Q2       ?     ?     ?

Q3       ?     ?     ?
```

This produces a:

$$
3\times3
$$

score matrix.

---

# 11. Matrix Multiplication

Instead of calculating every dot product manually, we use:

$$
\boxed{
S=QK^T
}
$$

Example:

```text
Q =
[
  [1, 0]
  [0, 1]
  [1, 1]
]
```

and:

```text
K =
[
  [1, 0]
  [0, 1]
  [1, 1]
]
```

Then:

```text
Kᵀ =
[
  [1, 0, 1]
  [0, 1, 1]
]
```

Therefore:

```text
QKᵀ =
[
  [1, 0, 1]
  [0, 1, 1]
  [1, 1, 2]
]
```

So:

```text
Scores =
[
  [1, 0, 1]
  [0, 1, 1]
  [1, 1, 2]
]
```

---

# 12. Understanding the Score Matrix

The rows represent **queries**.

The columns represent **keys**.

```text
             Key 1   Key 2   Key 3

Query 1        1       0       1

Query 2        0       1       1

Query 3        1       1       2
```

For Query 1:

```text
[1, 0, 1]
```

The strongest matches are:

```text
Key 1
Key 3
```

For Query 2:

```text
[0, 1, 1]
```

The strongest matches are:

```text
Key 2
Key 3
```

For Query 3:

```text
[1, 1, 2]
```

The strongest match is:

```text
Key 3
```

---

# 13. Practical Matrix Implementation

```python
import numpy as np

Q = np.array([
    [1, 0],
    [0, 1],
    [1, 1]
])

K = np.array([
    [1, 0],
    [0, 1],
    [1, 1]
])

scores = Q @ K.T

print("Attention Scores:")
print(scores)
```

Output:

```text
Attention Scores:
[[1 0 1]
 [0 1 1]
 [1 1 2]]
```

---

# 14. From Score to Attention Weight

An attention score is **not yet an attention probability**.

For example:

```text
Scores:

[1, 0, 2]
```

These values don't sum to 1.

We apply softmax:

$$
\alpha_i
=
\frac{e^{s_i}}
{\sum_j e^{s_j}}
$$

Example:

```python
import numpy as np

scores = np.array([1.0, 0.0, 2.0])

weights = np.exp(scores) / np.exp(scores).sum()

print(weights)
print(weights.sum())
```

The result will approximately be:

```text
[0.2447, 0.0900, 0.6652]
```

Notice:

```text
Score 2 → highest weight
```

So:

```text
Raw scores
    ↓
Softmax
    ↓
Normalized attention weights
```

The softmax operation is covered in detail in:

`06-softmax-in-attention.md`

---

# 15. Score vs Weight

This distinction is extremely important.

### Attention Score

Usually:

$$
QK^T
$$

Example:

```text
[1, 0, 2]
```

### Attention Weight

After softmax:

```text
[0.2447, 0.0900, 0.6652]
```

Therefore:

```text
QKᵀ
 ↓
Scores
 ↓
Softmax
 ↓
Weights
```

Do not call the raw dot products "attention weights."

---

# 16. Why Scaling Is Necessary

Suppose the vectors have a large dimension.

For example:

```text
dₖ = 512
```

The dot product contains many terms:

$$
Q\cdot K
=
q_1k_1+q_2k_2+\cdots+q_{512}k_{512}
$$

The resulting values can become large.

Large values passed into softmax can make the distribution extremely sharp.

Example:

```text
Scores:

[2, 4, 20]
```

Softmax may give almost all the probability to the largest value.

This can make gradients very small and training less effective.

The Transformer therefore scales the scores:

$$
\boxed{
\frac{QK^T}{\sqrt{d_k}}
}
$$

This is called **scaled dot-product attention**.

---

# 17. Practical Demonstration of Scaling

```python
import numpy as np

Q = np.random.randn(4, 64)
K = np.random.randn(4, 64)

raw_scores = Q @ K.T

d_k = K.shape[-1]

scaled_scores = raw_scores / np.sqrt(d_k)

print("Raw scores:")
print(raw_scores)

print("\nScaled scores:")
print(scaled_scores)
```

The scaled values are smaller in magnitude.

The next topic explains exactly **why we divide by $\sqrt{d_k}$**.

---

# 18. Attention Score Pipeline

The complete calculation is:

```text
Q
 \
  \
   → Dot Product → Raw Scores
  /
K
 ↓
Divide by √dₖ
 ↓
Scaled Scores
 ↓
Softmax
 ↓
Attention Weights
 ↓
Multiply by V
 ↓
Output
```

Mathematically:

$$
\boxed{
\text{Attention}(Q,K,V)
=
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
}
$$

---

# 19. Complete Practical Example

```python
import numpy as np


def softmax(x):
    exp_x = np.exp(x - np.max(x, axis=-1, keepdims=True))
    return exp_x / exp_x.sum(axis=-1, keepdims=True)


# Three tokens, each with dimension 2
Q = np.array([
    [1.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0]
])

K = np.array([
    [1.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0]
])

V = np.array([
    [10.0, 0.0],
    [0.0, 20.0],
    [10.0, 20.0]
])


# Step 1: Raw attention scores
scores = Q @ K.T

# Step 2: Scale
d_k = K.shape[-1]
scaled_scores = scores / np.sqrt(d_k)

# Step 3: Softmax
weights = softmax(scaled_scores)

# Step 4: Weighted sum of values
output = weights @ V


print("Raw Scores:")
print(scores)

print("\nScaled Scores:")
print(scaled_scores)

print("\nAttention Weights:")
print(weights)

print("\nAttention Output:")
print(output)
```

---

# 20. Shape Understanding

Suppose:

```text
Q shape = (n, dₖ)

K shape = (n, dₖ)
```

Then:

```text
Kᵀ shape = (dₖ, n)
```

Therefore:

```text
Q @ Kᵀ

(n, dₖ) @ (dₖ, n)

        ↓

      (n, n)
```

So:

$$
\boxed{
QK^T \rightarrow n\times n
}
$$

This means every query gets a score against every key.

---

# 21. Computational Cost

If there are `n` tokens and key/query dimension is `dₖ`:

$$
QK^T
$$

requires approximately:

$$
O(n^2d_k)
$$

operations.

The important part is:

$$
O(n^2)
$$

with respect to sequence length.

Why?

Because:

```text
n queries × n keys
```

creates:

```text
n² pairwise interactions
```

This becomes important when dealing with very long sequences.

---

# 22. GATE / Interview Points

### Q1. What is the attention score?

The similarity between a Query and a Key, commonly calculated using a dot product.

$$
QK^T
$$

---

### Q2. What does a high score indicate?

A high score indicates stronger alignment between a query and a key.

---

### Q3. What is the difference between score and weight?

```text
Score  → before softmax
Weight  → after softmax
```

---

### Q4. Why use QKᵀ?

It efficiently calculates the similarity between every query and every key.

---

### Q5. What is the shape of QKᵀ?

For `n` tokens:

$$
n\times n
$$

---

### Q6. Why divide by √dₖ?

To prevent dot-product values from becoming excessively large as the dimensionality increases, helping keep softmax in a useful range for training.

---

# 23. Common Mistakes

### Mistake 1

Thinking:

```text
QKᵀ = final attention
```

No.

It is only the **raw score matrix**.

---

### Mistake 2

Thinking:

```text
scores = probabilities
```

No.

Softmax converts scores into normalized weights.

---

### Mistake 3

Forgetting scaling in the Transformer formula.

The standard scaled dot-product attention is:

$$
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

---

### Mistake 4

Thinking the score compares only corresponding tokens.

It doesn't.

For `n` tokens:

```text
Every Query
     ↓
compares with
     ↓
Every Key
```

---

# 24. One-Line Memory Trick

> **Attention Score = Query × Key similarity**

```text
Q
 ↓
compare
 ↓
K
 ↓
score
 ↓
scale
 ↓
softmax
 ↓
weight
 ↓
V
```

---

# 25. Next Topic

We now understand:

```text
QKᵀ
 ↓
Raw attention scores
```

But an important question remains:

> **Why exactly do Transformers divide the scores by √dₖ?**

This leads to:

`05-scaled-dot-product-attention.md`

```
```
