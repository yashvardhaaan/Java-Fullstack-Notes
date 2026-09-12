## `06-softmax-in-attention.md`

````md
# Softmax in Attention

## 1. What Is Softmax?

**Softmax** converts a list of numerical scores into a probability-like distribution.

In attention, softmax converts:

```text
Raw / scaled attention scores
            ↓
      Attention weights
````

The weights have two important properties:

1. Every weight is between 0 and 1.
2. All weights in a row add up to 1.

---

# 2. Where Does Softmax Come in Attention?

Recall the complete formula:

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

The pipeline is:

```text
Q
 ↓
QKᵀ
 ↓
Raw Scores
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

Therefore:

> **Softmax converts attention scores into attention weights.**

---

# 3. Why Do We Need Softmax?

Suppose the attention scores are:

```text
[2, 5, 1]
```

These numbers tell us relative relevance, but they are not convenient weights.

They:

* do not sum to 1
* can be negative
* don't directly represent a distribution

Softmax converts them into something like:

```text
[0.047, 0.943, 0.010]
```

Now:

```text
0.047 + 0.943 + 0.010 ≈ 1
```

So we can interpret them as:

```text
Token 1 → 4.7% attention
Token 2 → 94.3% attention
Token 3 → 1.0% attention
```

---

# 4. Softmax Formula

For a vector:

$$
x=[x_1,x_2,\ldots,x_n]
$$

softmax for element $i$ is:

$$
\boxed{
\text{softmax}(x_i)
=
\frac{e^{x_i}}
{\sum_{j=1}^{n}e^{x_j}}
}
$$

The exponential function makes larger scores receive disproportionately larger weights.

---

# 5. Simple Example

Suppose:

```text
scores = [1, 2, 3]
```

First calculate exponentials:

$$
e^1\approx2.718
$$

$$
e^2\approx7.389
$$

$$
e^3\approx20.086
$$

Sum:

$$
2.718+7.389+20.086
=
30.193
$$

Now:

### First value

$$
\frac{2.718}{30.193}
\approx0.090
$$

### Second value

$$
\frac{7.389}{30.193}
\approx0.245
$$

### Third value

$$
\frac{20.086}{30.193}
\approx0.665
$$

Therefore:

```text
softmax([1,2,3])
≈
[0.090, 0.245, 0.665]
```

Check:

```text
0.090 + 0.245 + 0.665 = 1.000
```

---

# 6. Why Exponential?

Softmax uses:

$$
e^x
$$

because exponential growth amplifies differences between scores.

Compare:

```text
Scores:
[1, 2, 3]
```

Difference between 1 and 3:

```text
2
```

After exponential:

```text
e¹ ≈ 2.7
e³ ≈ 20.1
```

The difference becomes much larger.

Therefore, the highest-scoring token receives more attention.

---

# 7. Attention Example

Suppose a token has attention scores:

```text
[1, 2, 4]
```

The model considers three other tokens.

```text
Token A → score 1
Token B → score 2
Token C → score 4
```

Softmax converts this into approximately:

```text
Token A → 0.042
Token B → 0.114
Token C → 0.844
```

Therefore:

```text
Token C receives the most attention.
```

This does **not** mean the model completely ignores the other tokens.

It gives them smaller weights.

---

# 8. Softmax Is Applied Row-Wise

This is very important for self-attention.

Suppose:

```text
Scores =
[
 [1, 2, 3],
 [2, 1, 0],
 [4, 2, 1]
]
```

Softmax is applied independently to each row:

```text
Row 1 → softmax([1,2,3])

Row 2 → softmax([2,1,0])

Row 3 → softmax([4,2,1])
```

Result:

```text
Attention weights =
[
 [ ... , ... , ... ],
 [ ... , ... , ... ],
 [ ... , ... , ... ]
]
```

Each row sums to 1.

---

# 9. Why Row-Wise?

Each row represents one Query.

For example:

```text
             Key 1   Key 2   Key 3

Query 1       1       2       3
Query 2       2       1       0
Query 3       4       2       1
```

Query 1 asks:

> How much should I attend to each key?

So its weights must sum to 1.

Query 2 has its own distribution.

Query 3 has its own distribution.

Therefore:

```text
Each Query
    ↓
gets its own attention distribution
```

---

# 10. Practical Python Implementation

Let's implement softmax from scratch.

```python
import numpy as np


def softmax(x):
    exp_x = np.exp(x)
    return exp_x / np.sum(exp_x)


scores = np.array([1.0, 2.0, 3.0])

weights = softmax(scores)

print("Scores:")
print(scores)

print("\nWeights:")
print(weights)

print("\nSum:")
print(weights.sum())
```

Expected output is approximately:

```text
Scores:
[1. 2. 3.]

Weights:
[0.0900 0.2447 0.6652]

Sum:
1.0
```

---

# 11. Numerically Stable Softmax

The previous implementation works for small values, but there is a problem.

Suppose:

```text
scores = [1000, 1001, 1002]
```

Calculating:

```python
np.exp(1000)
```

can overflow.

A standard solution is to subtract the maximum value before exponentiation.

```python
def softmax(x):
    x = x - np.max(x)
    exp_x = np.exp(x)
    return exp_x / exp_x.sum()
```

For:

```text
[1000, 1001, 1002]
```

we first transform it into:

```text
[-2, -1, 0]
```

The relative differences remain exactly the same.

Then:

```text
exp(-2)
exp(-1)
exp(0)
```

are safe to calculate.

---

# 12. Why Can We Subtract the Maximum?

This is an important mathematical property.

Softmax is invariant to adding or subtracting the same constant.

Suppose:

$$
x=[1,2,3]
$$

Subtract 3:

$$
x'=[-2,-1,0]
$$

Then:

$$
\text{softmax}(x)
=
\text{softmax}(x')
$$

Why?

Because:

$$
\frac{e^{x_i-c}}
{\sum_j e^{x_j-c}}
$$

can be rewritten as:

$$
\frac{e^{x_i}e^{-c}}
{\sum_j e^{x_j}e^{-c}}
$$

The common factor cancels.

Therefore:

$$
\boxed{
\text{softmax}(x)
=
\text{softmax}(x-\max(x))
}
$$

This is the standard numerical-stability trick.

---

# 13. Practical Stable Softmax

Use this implementation in your projects:

```python
import numpy as np


def softmax(x):
    shifted_x = x - np.max(x)
    exp_x = np.exp(shifted_x)
    return exp_x / np.sum(exp_x)


scores = np.array([1000.0, 1001.0, 1002.0])

weights = softmax(scores)

print(weights)
print(weights.sum())
```

You should get approximately:

```text
[0.0900 0.2447 0.6652]
1.0
```

Even though the original values were very large.

---

# 14. Softmax in a Matrix

In attention, we need softmax independently for every query.

Example:

```python
import numpy as np


def softmax(x):
    x = x - np.max(x, axis=-1, keepdims=True)
    exp_x = np.exp(x)
    return exp_x / np.sum(exp_x, axis=-1, keepdims=True)


scores = np.array([
    [1.0, 2.0, 3.0],
    [2.0, 1.0, 0.0],
    [4.0, 2.0, 1.0]
])

weights = softmax(scores)

print(weights)
print("\nRow sums:")
print(weights.sum(axis=-1))
```

Output:

```text
Row sums:
[1. 1. 1.]
```

Notice:

```text
Every row sums to 1.
```

---

# 15. Complete Attention Example

Now let's connect everything.

```python
import numpy as np


def softmax(x):
    x = x - np.max(x, axis=-1, keepdims=True)
    exp_x = np.exp(x)
    return exp_x / np.sum(exp_x, axis=-1, keepdims=True)


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


# 1. Calculate raw scores
scores = Q @ K.T

# 2. Scale
d_k = K.shape[-1]
scaled_scores = scores / np.sqrt(d_k)

# 3. Softmax
weights = softmax(scaled_scores)

# 4. Weighted sum
output = weights @ V


print("Raw Scores:")
print(scores)

print("\nScaled Scores:")
print(scaled_scores)

print("\nAttention Weights:")
print(weights)

print("\nOutput:")
print(output)
```

The flow is:

```text
QKᵀ
 ↓
Raw scores
 ↓
÷ √dₖ
 ↓
Scaled scores
 ↓
Softmax
 ↓
Attention weights
 ↓
× V
 ↓
Output
```

---

# 16. What Does a Weight Actually Mean?

Suppose:

```text
Attention weights:

[0.1, 0.7, 0.2]
```

and values are:

```text
V₁ = [10, 0]

V₂ = [0, 20]

V₃ = [5, 5]
```

Then:

$$
Output
=
0.1V_1+0.7V_2+0.2V_3
$$

Calculate:

$$
0.1[10,0]
=
[1,0]
$$

$$
0.7[0,20]
=
[0,14]
$$

$$
0.2[5,5]
=
[1,1]
$$

Therefore:

$$
Output=[2,15]
$$

So the second value contributes the most because it received the largest attention weight.

---

# 17. Attention as a Weighted Average

Because:

$$
\sum_i\alpha_i=1
$$

and:

$$
\alpha_i\geq0
$$

the attention output:

$$
O=\sum_i\alpha_iV_i
$$

can be viewed as a **weighted average / weighted combination** of the values.

Example:

```text
Weights:
[0.2, 0.5, 0.3]

Values:
V₁
V₂
V₃
```

Then:

```text
Output =
0.2V₁ +
0.5V₂ +
0.3V₃
```

---

# 18. What Happens When Scores Are Equal?

Suppose:

```text
scores = [2, 2, 2]
```

Softmax gives:

```text
[1/3, 1/3, 1/3]
```

Approximately:

```text
[0.333, 0.333, 0.333]
```

So all tokens receive equal attention.

This makes sense because all scores are identical.

---

# 19. What Happens When One Score Is Much Larger?

Suppose:

```text
scores = [1, 1, 10]
```

Softmax produces approximately:

```text
[0.0001, 0.0001, 0.9998]
```

So almost all attention goes to the third token.

This demonstrates why extremely large scores can cause softmax to become very concentrated.

That is one reason **scaling by $\sqrt{d_k}$** is important.

---

# 20. Temperature Connection

A generalized softmax can use a temperature parameter:

$$
\text{softmax}
\left(
\frac{x}{T}
\right)
$$

where `T` is temperature.

### Low temperature

```text
T ↓
 ↓
distribution becomes sharper
```

### High temperature

```text
T ↑
 ↓
distribution becomes softer
```

In standard Transformer attention, the scaling factor:

$$
\frac{1}{\sqrt{d_k}}
$$

plays a related role in controlling the magnitude of logits before softmax.

Do not confuse this with all uses of temperature in language-model sampling; they are related mathematically but serve different purposes.

---

# 21. Softmax vs Sigmoid

These are often confused.

### Softmax

Used when outputs form a distribution across multiple choices.

Example:

```text
[0.1, 0.7, 0.2]
```

The values sum to 1.

### Sigmoid

Maps an individual value independently into:

```text
0 to 1
```

It does not force multiple outputs to sum to 1.

In attention, we use:

```text
Softmax
```

because we want a distribution of attention across keys.

---

# 22. Why Softmax Is Useful for Attention

Softmax gives us:

### 1. Non-negative weights

```text
αᵢ ≥ 0
```

### 2. Normalized weights

$$
\sum_i\alpha_i=1
$$

### 3. Differentiability

Softmax is differentiable, so the attention mechanism can be trained using gradient-based optimization.

### 4. Relative emphasis

Higher scores receive higher weights.

---

# 23. Shape Understanding

Suppose there are:

```text
n = 4 tokens
```

Then:

```text
QKᵀ
```

has shape:

```text
(4, 4)
```

For example:

```text
[
 [s11, s12, s13, s14],
 [s21, s22, s23, s24],
 [s31, s32, s33, s34],
 [s41, s42, s43, s44]
]
```

Softmax is applied across each row:

```text
[
 [w11, w12, w13, w14],
 [w21, w22, w23, w24],
 [w31, w32, w33, w34],
 [w41, w42, w43, w44]
]
```

Every row satisfies:

$$
\sum_jw_{ij}=1
$$

---

# 24. Attention Weight Matrix

The resulting matrix is often called the **attention weight matrix** or **attention distribution**.

Example:

```text
             Key 1   Key 2   Key 3

Query 1       0.70    0.20    0.10

Query 2       0.10    0.80    0.10

Query 3       0.20    0.20    0.60
```

Interpretation:

```text
Query 1 → mainly attends to Key 1

Query 2 → mainly attends to Key 2

Query 3 → mainly attends to Key 3
```

---

# 25. Complete Mathematical Derivation

Start with:

$$
Q,K,V
$$

### Step 1 — Dot product

$$
S=QK^T
$$

### Step 2 — Scale

$$
S'=\frac{QK^T}{\sqrt{d_k}}
$$

### Step 3 — Softmax

$$
A=
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)
$$

### Step 4 — Weighted values

$$
O=AV
$$

Therefore:

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

# 26. Practical Mini Experiment

Try changing the scores:

```python
import numpy as np


def softmax(x):
    x = x - np.max(x)
    exp_x = np.exp(x)
    return exp_x / exp_x.sum()


experiments = [
    np.array([1.0, 1.0, 1.0]),
    np.array([1.0, 2.0, 3.0]),
    np.array([1.0, 1.0, 10.0]),
    np.array([10.0, 10.0, 10.0])
]


for scores in experiments:

    weights = softmax(scores)

    print("=" * 40)
    print("Scores:", scores)
    print("Weights:", weights)
    print("Sum:", weights.sum())
```

Observe:

```text
Equal scores
    ↓
Equal attention

Small differences
    ↓
Moderate preference

Large differences
    ↓
Very concentrated attention
```

---

# 27. Important Numerical Stability Rule

Never casually write:

```python
np.exp(x) / np.sum(np.exp(x))
```

for production numerical code without considering overflow.

Prefer:

```python
def softmax(x):
    x = x - np.max(x, axis=-1, keepdims=True)
    exp_x = np.exp(x)
    return exp_x / np.sum(exp_x, axis=-1, keepdims=True)
```

Or, when using a deep-learning framework, use its optimized softmax/log-softmax functions.

---

# 28. GATE / Interview Questions

## Q1. What does softmax do in attention?

It converts scaled attention scores into normalized attention weights.

---

## Q2. Do attention weights sum to 1?

Yes, across the key dimension for each query.

$$
\sum_j\alpha_{ij}=1
$$

---

## Q3. Can attention weights be negative?

After softmax:

**No.**

$$
\alpha_i\geq0
$$

---

## Q4. Why is softmax applied after scaling?

The correct order is:

```text
QKᵀ
 ↓
÷ √dₖ
 ↓
Softmax
```

Scaling controls the magnitude of the logits before softmax.

---

## Q5. Why subtract the maximum before softmax?

For **numerical stability**.

It prevents exponential overflow while leaving the softmax result unchanged.

---

## Q6. What happens if all scores are equal?

All attention weights are equal.

For `n` keys:

$$
\alpha_i=\frac1n
$$

---

## Q7. What happens if one score is much larger?

Its softmax weight approaches 1, while the others approach 0.

---

# 29. Common Mistakes

### Mistake 1

Thinking softmax produces the final attention output.

It doesn't.

```text
Softmax
 ↓
Attention weights
 ↓
× V
 ↓
Output
```

---

### Mistake 2

Applying softmax to the entire matrix at once.

For standard attention, softmax is applied **row-wise across keys**.

---

### Mistake 3

Thinking attention weights can be negative.

After softmax:

```text
weight ≥ 0
```

---

### Mistake 4

Forgetting numerical stability.

Prefer:

```python
x - np.max(x)
```

before exponentiation.

---

# 30. One-Line Memory Trick

> **Softmax = Turn scores into a normalized attention distribution.**

```text
Scores
  ↓
Exponentiate
  ↓
Normalize
  ↓
Weights
  ↓
Weighted Values
  ↓
Output
```

---

# 31. Complete Attention Formula to Memorize

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

Remember it as:

```text
Q × Kᵀ
   ↓
Score
   ↓
Scale
   ↓
Softmax
   ↓
Weight
   ↓
× V
   ↓
Output
```

---

# 32. What We Know So Far

We have now built the attention mechanism piece by piece:

```text
01 Why Attention?
       ↓
02 Attention Intuition
       ↓
03 Query, Key, Value
       ↓
04 Attention Score
       ↓
05 Scaled Dot-Product Attention
       ↓
06 Softmax
```

The next major concept is:

> **How do tokens actually attend to other tokens within the same sentence?**

This is called:

# Self-Attention

Next file:

`07-self-attention.md`

```
```
