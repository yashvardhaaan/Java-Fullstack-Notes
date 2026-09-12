## `07-self-attention.md`

````md
# Self-Attention

## 1. What Is Self-Attention?

**Self-attention** is an attention mechanism where tokens in the **same input sequence** interact with one another.

In simple words:

> **Self-attention allows every token to look at other tokens in the same sentence and decide which ones are useful for understanding its context.**

Example:

```text
"The cat drank milk because it was thirsty."
````

When processing:

```text
"it"
```

the model can look at:

```text
The
cat
drank
milk
because
it
was
thirsty
```

and determine which tokens are relevant.

---

# 2. Why Is It Called "Self"-Attention?

It is called **self-attention** because:

```text
Q, K, V
```

are all generated from the **same input sequence**.

```text
                 Input X
                /   |   \
               ↓    ↓    ↓
              Q     K     V
               \    |    /
                \   |   /
                 Attention
```

Mathematically:

$$
Q=XW_Q
$$

$$
K=XW_K
$$

$$
V=XW_V
$$

All three originate from `X`.

---

# 3. Example

Consider:

```text
"The dog chased the ball because it was excited."
```

Suppose the current token is:

```text
"it"
```

The model can compare its query with the keys of every token:

```text
it → The
it → dog
it → chased
it → the
it → ball
it → because
it → it
it → was
it → excited
```

Conceptually:

```text
"The"       → low
"dog"       → HIGH
"chased"    → low
"the"       → low
"ball"      → medium
"because"   → low
"it"        → low
"was"       → low
"excited"   → medium
```

The attention mechanism can therefore construct a contextual representation of `"it"`.

---

# 4. Self-Attention vs Normal Attention

The word "attention" is broader.

### Self-Attention

Q, K and V come from the same sequence.

```text
Sequence X
   ↓
Q K V
   ↓
Self-Attention
```

### Cross-Attention

Q comes from one sequence while K and V come from another.

```text
Sequence A → Q
                  ↓
               Attention
                  ↑
Sequence B → K,V
```

Cross-attention is important in encoder-decoder Transformers.

For now, focus on self-attention.

---

# 5. Example: Translation

Suppose an encoder processes:

```text
"I love cats"
```

A decoder generating:

```text
"J'aime les chats"
```

may use cross-attention to look at the encoder's representations.

But inside the encoder itself:

```text
"I"
"love"
"cats"
```

can interact with one another using **self-attention**.

Therefore:

```text
Encoder Self-Attention
        ↓
tokens interact within source sentence
```

and:

```text
Decoder Cross-Attention
        ↓
decoder looks at encoder representations
```

---

# 6. The Basic Self-Attention Formula

The standard formula is:

$$
\boxed{
\text{SelfAttention}(X)
=
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
}
$$

where:

$$
Q=XW_Q
$$

$$
K=XW_K
$$

$$
V=XW_V
$$

Therefore:

$$
\boxed{
\text{SelfAttention}(X)
=
\text{softmax}
\left(
\frac{(XW_Q)(XW_K)^T}
{\sqrt{d_k}}
\right)
(XW_V)
}
$$

---

# 7. Complete Pipeline

The self-attention process is:

```text
Input Embeddings X
        ↓
   ┌────┼────┐
   ↓    ↓    ↓
   Q    K    V
   ↓    ↓
   QKᵀ
     ↓
Scale by √dₖ
     ↓
   Softmax
     ↓
Attention Weights
     ↓
   × V
     ↓
Self-Attention Output
```

---

# 8. Why Self-Attention Is Powerful

Consider:

```text
"The animal didn't cross the road because it was tired."
```

The representation of:

```text
"it"
```

can use information from:

```text
animal
```

and:

```text
tired
```

to create a context-aware representation.

So instead of representing a word independently:

```text
it → fixed representation
```

we can obtain:

```text
it
 ↓
look at context
 ↓
contextual representation
```

This is one of the fundamental ideas behind modern NLP.

---

# 9. Token Representations Change With Context

Consider the word:

```text
"bank"
```

### Sentence 1

```text
"I deposited money in the bank."
```

Self-attention allows `"bank"` to interact with:

```text
deposited
money
```

This provides financial context.

### Sentence 2

```text
"We sat near the bank of the river."
```

Now `"bank"` can interact strongly with:

```text
river
sat
```

This provides a different context.

Therefore, self-attention helps create:

```text
context-dependent representations
```

---

# 10. Practical Example: Three Tokens

Let's build self-attention from scratch.

Suppose:

```text
Tokens:

["I", "love", "NLP"]
```

Their toy embeddings are:

```python
import numpy as np

X = np.array([
    [1.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0]
])
```

So:

```text
X =
[
 [1, 0]
 [0, 1]
 [1, 1]
]
```

---

# 11. Create Q, K, V

Define the projection matrices:

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

Now:

```python
Q = X @ W_Q
K = X @ W_K
V = X @ W_V
```

Since we used identity matrices:

```text
Q = X
K = X
V = X
```

In real Transformers, these matrices are learned and are not generally identity matrices.

---

# 12. Calculate Scores

Use:

$$
S=QK^T
$$

Python:

```python
scores = Q @ K.T

print(scores)
```

Result:

```text
[
 [1, 0, 1],
 [0, 1, 1],
 [1, 1, 2]
]
```

This means:

```text
             I    love    NLP

I            1      0      1

love         0      1      1

NLP          1      1      2
```

Every token has compared itself with **every token**.

---

# 13. Scale the Scores

The key dimension is:

```text
dₖ = 2
```

Therefore:

$$
\sqrt{d_k}=\sqrt2
$$

Calculate:

```python
scaled_scores = scores / np.sqrt(K.shape[-1])

print(scaled_scores)
```

---

# 14. Apply Softmax

Define stable softmax:

```python
def softmax(x):
    x = x - np.max(x, axis=-1, keepdims=True)
    exp_x = np.exp(x)
    return exp_x / np.sum(exp_x, axis=-1, keepdims=True)
```

Then:

```python
attention_weights = softmax(scaled_scores)

print(attention_weights)
```

Each row represents one token's attention distribution.

For example:

```text
             I       love       NLP

I          0.40      0.20      0.40

love       0.20      0.40      0.40

NLP        0.26      0.26      0.48
```

The exact values depend on the scores.

---

# 15. Multiply by V

Finally:

$$
Output=AttentionWeights\times V
$$

Python:

```python
output = attention_weights @ V

print(output)
```

Now every token has a new representation containing information gathered from the other tokens.

---

# 16. Complete Self-Attention Code

```python
import numpy as np


def softmax(x):
    x = x - np.max(x, axis=-1, keepdims=True)
    exp_x = np.exp(x)
    return exp_x / np.sum(exp_x, axis=-1, keepdims=True)


def self_attention(X, W_Q, W_K, W_V):

    # Step 1: Create Q, K, V
    Q = X @ W_Q
    K = X @ W_K
    V = X @ W_V

    # Step 2: Calculate attention scores
    scores = Q @ K.T

    # Step 3: Scale
    d_k = K.shape[-1]
    scaled_scores = scores / np.sqrt(d_k)

    # Step 4: Softmax
    weights = softmax(scaled_scores)

    # Step 5: Weighted combination of values
    output = weights @ V

    return output, weights, Q, K, V


# Input embeddings
X = np.array([
    [1.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0]
])


# Projection matrices
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


output, weights, Q, K, V = self_attention(
    X,
    W_Q,
    W_K,
    W_V
)


print("Q:")
print(Q)

print("\nK:")
print(K)

print("\nV:")
print(V)

print("\nAttention Weights:")
print(weights)

print("\nOutput:")
print(output)
```

---

# 17. Understanding the Matrix

Suppose the attention matrix is:

```text
[
 [0.4, 0.2, 0.4],
 [0.2, 0.4, 0.4],
 [0.26, 0.26, 0.48]
]
```

Interpretation:

```text
Row 1 → how token 1 attends to every token

Row 2 → how token 2 attends to every token

Row 3 → how token 3 attends to every token
```

Therefore:

```text
Rows = Queries
Columns = Keys
```

This is an extremely important fact.

---

# 18. Self-Attention Creates Token-to-Token Relationships

For `n` tokens:

```text
Token 1 → Token 1, Token 2, ..., Token n

Token 2 → Token 1, Token 2, ..., Token n

...

Token n → Token 1, Token 2, ..., Token n
```

Therefore:

```text
n queries × n keys
```

produces:

$$
n\times n
$$

attention scores.

---

# 19. Complexity

If there are `n` tokens:

```text
QKᵀ
```

requires approximately:

$$
O(n^2d_k)
$$

operations.

The important dependency on sequence length is:

$$
\boxed{O(n^2)}
$$

because every token can interact with every other token.

Example:

```text
10 tokens
→ 100 pairwise interactions

100 tokens
→ 10,000 interactions

1,000 tokens
→ 1,000,000 interactions
```

This quadratic behavior becomes important for long-context models.

---

# 20. Self-Attention Is Parallelizable

RNN:

```text
Token 1
   ↓
Token 2
   ↓
Token 3
   ↓
Token 4
```

The sequence is processed step-by-step.

Self-attention can calculate relationships using matrix operations:

```text
Q @ K.T
```

Therefore many token interactions can be computed in parallel on GPUs/TPUs.

This is one major reason Transformers became so successful.

---

# 21. Self-Attention vs RNN

| Feature                           | RNN                      | Self-Attention                    |
| --------------------------------- | ------------------------ | --------------------------------- |
| Processing                        | Sequential               | Highly parallelizable             |
| Long-range relationships          | More difficult           | Direct token-to-token interaction |
| Main mechanism                    | Hidden state             | Attention                         |
| Parallel training                 | Limited                  | Strong                            |
| Sequence interaction              | Through recurrent steps  | Direct pairwise attention         |
| Complexity w.r.t. sequence length | Roughly linear per layer | Quadratic attention matrix        |

The comparison depends on implementation details, but this captures the core conceptual difference.

---

# 22. Self-Attention Is Not the Same as Multi-Head Attention

These terms are related but different.

### Self-Attention

Describes **where Q, K, V come from**:

```text
same sequence
    ↓
Q, K, V
    ↓
self-attention
```

### Multi-Head Attention

Describes using **multiple attention heads** in parallel.

```text
Input
 ↓
Head 1
Head 2
Head 3
Head 4
 ↓
Concatenate
 ↓
Output projection
```

We will study multi-head attention later.

---

# 23. Causal / Masked Self-Attention

Self-attention does not always allow every token to see every other token.

In autoregressive language models, a token generally must not see future tokens during training.

Example:

```text
"I love machine learning"
```

When predicting:

```text
"machine"
```

the model can see:

```text
I
love
machine
```

but should not use:

```text
learning
```

because that is future information.

This is achieved using a **causal mask**.

---

# 24. Causal Attention Matrix

Suppose there are four tokens.

Without a mask:

```text
[
 [1, 1, 1, 1],
 [1, 1, 1, 1],
 [1, 1, 1, 1],
 [1, 1, 1, 1]
]
```

Every token can attend everywhere.

With causal masking:

```text
[
 [1, 0, 0, 0],
 [1, 1, 0, 0],
 [1, 1, 1, 0],
 [1, 1, 1, 1]
]
```

The upper-right portion is blocked.

Before softmax, masked positions are usually assigned:

$$
-\infty
$$

so their softmax probability becomes approximately:

$$
0
$$

---

# 25. Practical Causal Mask

```python
import numpy as np

n = 4

mask = np.tril(np.ones((n, n)))

print(mask)
```

Output:

```text
[
 [1, 0, 0, 0],
 [1, 1, 0, 0],
 [1, 1, 1, 0],
 [1, 1, 1, 1]
]
```

Convert blocked positions into `-inf`:

```python
scores = np.array([
    [1.0, 2.0, 3.0, 4.0],
    [1.0, 2.0, 3.0, 4.0],
    [1.0, 2.0, 3.0, 4.0],
    [1.0, 2.0, 3.0, 4.0]
])

causal_mask = np.triu(
    np.ones((n, n)),
    k=1
).astype(bool)

scores[causal_mask] = -np.inf

print(scores)
```

Result:

```text
[
 [1, -∞, -∞, -∞],
 [1,  2, -∞, -∞],
 [1,  2,  3, -∞],
 [1,  2,  3,  4]
]
```

Then softmax gives zero probability to the masked positions.

---

# 26. Encoder Self-Attention vs Decoder Self-Attention

### Encoder

Usually uses **bidirectional self-attention**.

A token can attend to tokens before and after it.

```text
←──── Token ────→
```

### Autoregressive Decoder

Uses **causal self-attention**.

A token can attend only to itself and previous tokens.

```text
Previous ← Token
```

It cannot attend to future tokens.

---

# 27. Important Concept: Contextualization

One of the most important results of self-attention is:

> A token's representation can incorporate information from other tokens.

Before self-attention:

```text
"bank"
 ↓
embedding
```

After self-attention:

```text
"bank"
 ↓
looks at context
 ↓
contextual representation
```

This is why Transformer representations are highly context-dependent.

---

# 28. A Simple Visualization

Sentence:

```text
The cat sat on the mat
```

Suppose we look at `"cat"`.

The attention distribution might conceptually look like:

```text
The   cat   sat   on   the   mat
 ↓     ↓     ↓    ↓    ↓     ↓
0.1   0.5   0.1  0.05 0.05  0.2
```

The model is not necessarily saying:

```text
"cat is definitely related to these words."
```

Instead, these values represent learned attention interactions for that particular layer/head/input.

---

# 29. Important Warning About Attention Interpretation

Attention weights are useful for understanding the mechanism, but:

> **Attention weights should not automatically be treated as a complete explanation of a model's reasoning.**

A model can use information through many layers and heads.

Therefore:

```text
High attention
≠
complete explanation of model reasoning
```

---

# 30. Full Mathematical Derivation

Start with input:

$$
X
$$

Generate projections:

$$
Q=XW_Q
$$

$$
K=XW_K
$$

$$
V=XW_V
$$

Calculate scores:

$$
S=QK^T
$$

Scale:

$$
S'=\frac{S}{\sqrt{d_k}}
$$

Apply softmax:

$$
A=\text{softmax}(S')
$$

Multiply by values:

$$
O=AV
$$

Therefore:

$$
\boxed{
O=
\text{softmax}
\left(
\frac{(XW_Q)(XW_K)^T}
{\sqrt{d_k}}
\right)
XW_V
}
$$

This is the mathematical foundation of self-attention.

---

# 31. Shape Analysis

Suppose:

```text
X = (n, d_model)
```

and:

```text
W_Q = (d_model, d_k)

W_K = (d_model, d_k)

W_V = (d_model, d_v)
```

Then:

```text
Q = XW_Q
  = (n, d_k)

K = XW_K
  = (n, d_k)

V = XW_V
  = (n, d_v)
```

Now:

```text
QKᵀ
```

has:

```text
(n, d_k) × (d_k, n)
```

giving:

```text
(n, n)
```

Then:

```text
(n, n) × (n, d_v)
```

gives:

```text
(n, d_v)
```

Therefore:

```text
X       → (n, d_model)

Q       → (n, d_k)
K       → (n, d_k)
V       → (n, d_v)

QKᵀ     → (n, n)

Output  → (n, d_v)
```

---

# 32. GATE / Interview Questions

## Q1. What is self-attention?

A mechanism where each token in a sequence can attend to other tokens in the same sequence.

---

## Q2. Why is it called self-attention?

Because Q, K and V are generated from the same input sequence.

---

## Q3. What is the formula?

$$
\boxed{
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
}
$$

---

## Q4. How are Q, K and V generated?

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

## Q5. What is the shape of the attention matrix for n tokens?

$$
n\times n
$$

---

## Q6. Why is the attention matrix n × n?

Because every query compares with every key.

```text
n queries × n keys
```

---

## Q7. What is the main advantage over RNNs?

Self-attention provides direct token-to-token interactions and is highly parallelizable during computation.

---

## Q8. What is causal self-attention?

Self-attention where future tokens are masked so a token cannot attend to future positions.

---

## Q9. What is the difference between self-attention and cross-attention?

```text
Self-attention:
Q, K, V → same sequence

Cross-attention:
Q → one sequence
K,V → another sequence
```

---

# 33. Common Mistakes

### Mistake 1

Thinking self-attention means a token only attends to itself.

Wrong.

"Self" means the attention is performed **within the same sequence**.

A token can attend to other tokens.

---

### Mistake 2

Thinking Q, K and V are different sentences.

Wrong.

In self-attention:

```text
same X
 ↓
Q, K, V
```

---

### Mistake 3

Thinking attention is always bidirectional.

Not necessarily.

```text
Encoder → usually bidirectional

Autoregressive decoder → causal/masked
```

---

### Mistake 4

Confusing self-attention with multi-head attention.

```text
Self-attention → type/source of attention

Multi-head → multiple attention mechanisms/heads in parallel
```

---

### Mistake 5

Forgetting the scaling factor.

Standard scaled self-attention:

$$
\text{softmax}
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

---

# 34. Practical Mini Project

Modify the code and experiment with different sentences represented by toy embeddings.

```python
import numpy as np


def softmax(x):
    x = x - np.max(x, axis=-1, keepdims=True)
    exp_x = np.exp(x)
    return exp_x / np.sum(exp_x, axis=-1, keepdims=True)


def self_attention(X):

    d_model = X.shape[-1]

    # Simple projections
    W_Q = np.random.randn(d_model, d_model)
    W_K = np.random.randn(d_model, d_model)
    W_V = np.random.randn(d_model, d_model)

    Q = X @ W_Q
    K = X @ W_K
    V = X @ W_V

    scores = Q @ K.T

    scores = scores / np.sqrt(K.shape[-1])

    weights = softmax(scores)

    output = weights @ V

    return output, weights


np.random.seed(42)

X = np.array([
    [1.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0]
])

output, weights = self_attention(X)

print("Attention Weights:")
print(weights)

print("\nOutput:")
print(output)
```

Try changing:

```python
X
```

and observe how the attention matrix changes.

---

# 35. Final Mental Model

Remember self-attention as:

```text
One sentence
     ↓
Every token creates
Q, K, V
     ↓
Every Query compares
with every Key
     ↓
Attention Scores
     ↓
Scale
     ↓
Softmax
     ↓
Attention Weights
     ↓
Retrieve information
from Values
     ↓
Contextual representations
```

The key idea:

> **Every token can use information from other tokens in the same sequence to build a context-aware representation.**

---

# 36. Attention Topics Completed

We have now covered:

```text
01. Why Attention?
        ↓
02. Attention Intuition
        ↓
03. Query, Key, Value
        ↓
04. Attention Score
        ↓
05. Scaled Dot-Product Attention
        ↓
06. Softmax in Attention
        ↓
07. Self-Attention
```

The next major topic is:

# Multi-Head Attention

Instead of using only one attention mechanism, Transformers use **multiple attention heads** so different heads can learn different types of relationships.

Next file:

`08-multi-head-attention.md`

```
```
