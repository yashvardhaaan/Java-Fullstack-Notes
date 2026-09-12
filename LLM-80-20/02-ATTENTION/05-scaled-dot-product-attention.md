## `05-scaled-dot-product-attention.md`

````md
# Scaled Dot-Product Attention

## 1. What Is Scaled Dot-Product Attention?

**Scaled Dot-Product Attention** is the attention mechanism used as the fundamental building block of the Transformer architecture.

The formula is:

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

It has four major steps:

```text
Q, K, V
   ↓
QKᵀ
   ↓
Divide by √dₖ
   ↓
Softmax
   ↓
Multiply by V
   ↓
Output
````

---

# 2. Why Is It Called "Scaled Dot-Product"?

The name tells us exactly what happens.

### Dot-Product

We calculate:

$$
QK^T
$$

This produces similarity scores.

### Scaled

We divide the scores by:

$$
\sqrt{d_k}
$$

where:

```text
dₖ = dimension of the Key vectors
```

Therefore:

```text
Scaled Dot-Product
        =
Dot Product
        ÷
√dₖ
```

---

# 3. Complete Formula

The complete equation is:

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

Let's understand every component:

| Component    | Meaning                      |
| ------------ | ---------------------------- |
| Q            | Queries                      |
| K            | Keys                         |
| V            | Values                       |
| $QK^T$       | Raw attention scores         |
| $d_k$        | Key dimension                |
| $\sqrt{d_k}$ | Scaling factor               |
| Softmax      | Converts scores into weights |
| $V$          | Information being retrieved  |

---

# 4. Why Do We Need Scaling?

This is one of the most important concepts in Transformer attention.

Suppose:

```text
Q = [q₁, q₂, ..., qₖ]

K = [k₁, k₂, ..., kₖ]
```

The dot product is:

$$
Q\cdot K
=
\sum_{i=1}^{d_k}q_i k_i
$$

As `dₖ` becomes larger, the dot product can become larger in magnitude.

For example:

```text
dₖ = 2
```

might produce:

```text
score ≈ 2
```

while:

```text
dₖ = 512
```

can produce much larger scores.

Large scores can create problems for softmax.

---

# 5. Softmax and Large Scores

Softmax is:

$$
\text{softmax}(x_i)
=
\frac{e^{x_i}}
{\sum_j e^{x_j}}
$$

Suppose we have:

```text
Scores:

[1, 2, 3]
```

Softmax produces a reasonably distributed result.

But consider:

```text
[1, 10, 100]
```

The largest value can dominate the result.

Conceptually:

```text
[1, 10, 100]

       ↓ softmax

[~0, ~0, ~1]
```

The distribution becomes extremely concentrated.

---

# 6. Why Is That a Problem?

During training, extremely large values can push softmax into regions where gradients become very small.

This can make optimization more difficult.

Therefore, instead of directly using:

$$
QK^T
$$

we use:

$$
\frac{QK^T}{\sqrt{d_k}}
$$

This keeps the scores at a more manageable scale.

---

# 7. Statistical Intuition

Assume the elements of Q and K are independent random variables with:

$$
E[q_i]=0
$$

$$
E[k_i]=0
$$

and:

$$
Var(q_i)=Var(k_i)=1
$$

The dot product is:

$$
Q\cdot K
=
\sum_{i=1}^{d_k}q_i k_i
$$

Each product has approximately unit variance.

The variance of the sum is approximately:

$$
Var(Q\cdot K)\approx d_k
$$

Therefore the standard deviation is approximately:

$$
\sqrt{d_k}
$$

So as `dₖ` increases:

```text
dₖ ↑
 ↓
variance of dot products ↑
 ↓
scores become larger
```

Dividing by:

$$
\sqrt{d_k}
$$

approximately normalizes the variance.

This is the mathematical motivation for scaling.

---

# 8. Example With Small Dimensions

Suppose:

```text
dₖ = 4
```

Then:

$$
\sqrt{d_k}
=
\sqrt4
=
2
$$

Suppose:

```text
QKᵀ = 8
```

Scaled score:

$$
\frac{8}{2}=4
$$

So:

```text
Raw score       = 8
Scaling factor  = 2
Scaled score    = 4
```

---

# 9. Example With dₖ = 64

Suppose:

```text
dₖ = 64
```

Then:

$$
\sqrt{64}=8
$$

If:

```text
QKᵀ = 40
```

then:

$$
\frac{40}{8}=5
$$

So:

```text
Raw score    = 40
Scaled score = 5
```

The score is reduced to a more manageable range.

---

# 10. Practical Python Example

Let's compare raw and scaled scores.

```python
import numpy as np

Q = np.array([
    [1.0, 2.0, 3.0, 4.0]
])

K = np.array([
    [2.0, 1.0, 2.0, 1.0]
])

raw_score = Q @ K.T

d_k = K.shape[-1]

scaled_score = raw_score / np.sqrt(d_k)

print("Raw score:")
print(raw_score)

print("\nScaled score:")
print(scaled_score)
```

Here:

```text
dₖ = 4
√dₖ = 2
```

Therefore:

```text
scaled score = raw score / 2
```

---

# 11. Softmax Function

Now let's see what happens after scaling.

```python
def softmax(x):
    exp_x = np.exp(x - np.max(x))
    return exp_x / exp_x.sum()
```

For example:

```python
scores = np.array([2.0, 4.0, 8.0])

print(softmax(scores))
```

The largest score receives the largest attention weight.

Scaling prevents the scores from becoming unnecessarily extreme as dimensions grow.

---

# 12. Comparing Different Dimensions

Let's experimentally see how dot products behave as dimensionality increases.

```python
import numpy as np

np.random.seed(42)

for d_k in [4, 16, 64, 256, 512]:
    Q = np.random.randn(1, d_k)
    K = np.random.randn(1, d_k)

    raw_score = Q @ K.T
    scaled_score = raw_score / np.sqrt(d_k)

    print(f"d_k = {d_k}")
    print("Raw:", raw_score.item())
    print("Scaled:", scaled_score.item())
    print()
```

The exact values change because the vectors are random.

The important concept is:

```text
As dimensionality grows,
the unscaled dot product can grow in magnitude.

Dividing by √dₖ controls this growth.
```

---

# 13. Full Scaled Attention Implementation

Now let's implement the entire mechanism.

```python
import numpy as np


def softmax(x):
    exp_x = np.exp(x - np.max(x, axis=-1, keepdims=True))
    return exp_x / exp_x.sum(axis=-1, keepdims=True)


def scaled_dot_product_attention(Q, K, V):
    # Step 1: Calculate raw scores
    scores = Q @ K.T

    # Step 2: Scale scores
    d_k = K.shape[-1]
    scaled_scores = scores / np.sqrt(d_k)

    # Step 3: Convert scores into attention weights
    weights = softmax(scaled_scores)

    # Step 4: Weighted sum of values
    output = weights @ V

    return output, weights, scaled_scores


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


output, weights, scores = scaled_dot_product_attention(Q, K, V)

print("Scaled Scores:")
print(scores)

print("\nAttention Weights:")
print(weights)

print("\nOutput:")
print(output)
```

---

# 14. Understand the Code Step-by-Step

The first operation:

```python
scores = Q @ K.T
```

means:

$$
S=QK^T
$$

Then:

```python
d_k = K.shape[-1]
```

gets the key dimension.

Then:

```python
scaled_scores = scores / np.sqrt(d_k)
```

implements:

$$
S_{scaled}
=
\frac{QK^T}{\sqrt{d_k}}
$$

Then:

```python
weights = softmax(scaled_scores)
```

implements:

$$
A=
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)
$$

Finally:

```python
output = weights @ V
```

implements:

$$
O=AV
$$

Combining everything:

$$
\boxed{
O=
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
}
$$

---

# 15. Manual Calculation

Let's calculate one complete example manually.

Suppose:

```text
Q = [1, 0]

K₁ = [1, 0]
K₂ = [0, 1]
```

and:

```text
dₖ = 2
```

---

## Step 1: Calculate raw scores

For K₁:

$$
Q\cdot K_1
=
(1)(1)+(0)(0)
=
1
$$

For K₂:

$$
Q\cdot K_2
=
(1)(0)+(0)(1)
=
0
$$

Therefore:

```text
Raw scores:

[1, 0]
```

---

## Step 2: Scale

Since:

$$
d_k=2
$$

we have:

$$
\sqrt{d_k}=\sqrt2
$$

Therefore:

$$
\left[
\frac{1}{\sqrt2},
\frac{0}{\sqrt2}
\right]
$$

Approximately:

```text
[0.707, 0]
```

---

## Step 3: Softmax

Apply:

$$
\text{softmax}([0.707,0])
$$

Approximately:

```text
[0.67, 0.33]
```

So the model gives:

```text
K₁ → ~67%
K₂ → ~33%
```

---

## Step 4: Multiply by Values

Suppose:

```text
V₁ = [10, 0]

V₂ = [0, 20]
```

Then:

$$
Output
=
0.67V_1+0.33V_2
$$

Approximately:

$$
=
0.67[10,0]+0.33[0,20]
$$

$$
=
[6.7,6.6]
$$

Therefore the output is approximately:

```text
[6.7, 6.6]
```

---

# 16. Why Not Divide by dₖ?

A natural question:

> Why $\sqrt{d_k}$ instead of $d_k$?

Because under the standard assumption that the components have zero mean and unit variance:

$$
Var(Q\cdot K)\approx d_k
$$

Therefore the standard deviation is:

$$
\sqrt{d_k}
$$

Dividing by the standard deviation is what keeps the score distribution at a more stable scale.

So:

```text
Variance       → dₖ

Standard deviation → √dₖ

Scaling factor → √dₖ
```

---

# 17. Important Difference: Normalization vs Scaling

Don't confuse these terms.

### Scaling

In attention:

$$
\frac{QK^T}{\sqrt{d_k}}
$$

We are controlling the magnitude of the dot-product scores.

### Softmax

Then:

$$
\text{softmax}(...)
$$

converts scores into a normalized distribution.

So the sequence is:

```text
Dot Product
     ↓
Scaling
     ↓
Softmax
```

---

# 18. Attention With and Without Scaling

Without scaling:

$$
\text{softmax}(QK^T)
$$

With scaling:

$$
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)
$$

Transformer attention uses the second form.

---

# 19. Shape Analysis

Suppose:

```text
Q = (n, dₖ)
K = (n, dₖ)
V = (n, dᵥ)
```

Then:

```text
Kᵀ = (dₖ, n)
```

Therefore:

$$
QK^T
$$

has shape:

$$
(n,d_k)(d_k,n)
=
(n,n)
$$

Scaling does not change the shape:

```text
(n, n)
```

Softmax also preserves the shape:

```text
(n, n)
```

Finally:

```text
(n, n) @ (n, dᵥ)
```

produces:

```text
(n, dᵥ)
```

Therefore:

```text
QKᵀ       → (n,n)
Scaled    → (n,n)
Softmax   → (n,n)
Output    → (n,dᵥ)
```

---

# 20. Visual Summary

```text
              Q
              ↓
           ┌─────┐
K ───────→ │ QKᵀ │
           └─────┘
              ↓
        Divide by √dₖ
              ↓
        Scaled Scores
              ↓
           Softmax
              ↓
      Attention Weights
              ↓
              ×
              ↓
              V
              ↓
       Attention Output
```

---

# 21. The Most Important Formula

Memorize:

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

Break it into four operations:

```text
1. QKᵀ
2. ÷ √dₖ
3. Softmax
4. × V
```

Memory trick:

> **Score → Scale → Softmax → Retrieve**

```text
QKᵀ
 ↓
Score
 ↓
Scale
 ↓
Softmax
 ↓
Weight
 ↓
V
 ↓
Output
```

---

# 22. GATE / Interview Points

### Q1. What is scaled dot-product attention?

It is an attention mechanism that calculates dot-product similarity between Q and K, scales it by $\sqrt{d_k}$, applies softmax, and uses the resulting weights to combine V.

$$
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

---

### Q2. Why divide by $\sqrt{d_k}$?

Because the variance of the dot product grows approximately with $d_k$, so its standard deviation grows approximately with $\sqrt{d_k}$. Scaling helps prevent excessively large scores.

---

### Q3. What happens if scores become very large?

Softmax becomes very peaked, which can lead to very small gradients and make optimization harder.

---

### Q4. Does scaling change the dimensions?

No.

```text
(n,n) / scalar → (n,n)
```

---

### Q5. Is scaling performed before or after softmax?

**Before softmax.**

Correct:

$$
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)
$$

Incorrect:

$$
\frac{
\text{softmax}(QK^T)
}{
\sqrt{d_k}
}
$$

---

### Q6. What does $d_k$ represent?

The dimensionality of each Key vector.

---

# 23. Common Mistakes

### Mistake 1

Writing:

$$
\frac{QK^T}{d_k}
$$

instead of:

$$
\frac{QK^T}{\sqrt{d_k}}
$$

---

### Mistake 2

Applying softmax before scaling:

```text
QKᵀ
 ↓
Softmax
 ↓
Divide by √dₖ
```

Wrong.

Correct:

```text
QKᵀ
 ↓
Divide by √dₖ
 ↓
Softmax
```

---

### Mistake 3

Thinking scaling changes the attention matrix size.

It doesn't.

```text
Before scaling → (n,n)
After scaling  → (n,n)
```

---

# 24. Practical Mini Project

Try changing `d_k` yourself.

```python
import numpy as np


def softmax(x):
    exp_x = np.exp(x - np.max(x, axis=-1, keepdims=True))
    return exp_x / exp_x.sum(axis=-1, keepdims=True)


for d_k in [2, 8, 32, 128]:

    Q = np.random.randn(1, d_k)
    K = np.random.randn(3, d_k)

    raw_scores = Q @ K.T

    scaled_scores = raw_scores / np.sqrt(d_k)

    raw_weights = softmax(raw_scores)
    scaled_weights = softmax(scaled_scores)

    print("=" * 50)
    print("d_k =", d_k)

    print("\nRaw scores:")
    print(raw_scores)

    print("\nScaled scores:")
    print(scaled_scores)

    print("\nRaw softmax:")
    print(raw_weights)

    print("\nScaled softmax:")
    print(scaled_weights)
```

### Experiment

Observe:

```text
dₖ increases
     ↓
raw scores can become larger
     ↓
scaling controls their magnitude
     ↓
softmax remains less extreme
```

This experiment is useful for understanding **why the scaling factor exists instead of simply memorizing the formula**.

---

# 25. Final Mental Model

Imagine:

```text
Q = question

K = labels used to find matching information

V = actual information
```

Then:

```text
Q × Kᵀ
    ↓
How relevant?
    ↓
÷ √dₖ
    ↓
Keep scores stable
    ↓
Softmax
    ↓
Convert to attention weights
    ↓
Weights × V
    ↓
Retrieve useful information
```

Therefore:

> **Scaled Dot-Product Attention = compare → stabilize → choose → combine**

---

# 26. Next Topic

We now understand the complete attention equation:

$$
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

The next important component is:

> **How does Softmax turn these scores into attention weights?**

Next:

`06-softmax-in-attention.md`

```
```
