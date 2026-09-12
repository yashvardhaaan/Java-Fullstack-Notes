### `04-multi-head-attention.md`

````markdown
# Multi-Head Attention

## 1. Introduction

In the previous topics, we learned about:

- Query (Q)
- Key (K)
- Value (V)
- Attention Scores
- Scaled Dot-Product Attention
- Softmax
- Self-Attention

Now we move to one of the most important components of the Transformer:

# Multi-Head Attention

The basic idea is:

> Instead of performing attention only once, perform attention multiple times in parallel using different learned projections.

---

# 2. Why Do We Need Multiple Heads?

Suppose we have the sentence:

```text
"The animal didn't cross the road because it was tired."
````

When the model processes:

```text
"it"
```

it may need to understand which earlier word "it" refers to.

Attention can help find this relationship.

But language contains many different types of relationships.

For example:

```text
"The cat sat on the mat."
```

A model may need to learn:

* grammatical relationships
* subject-object relationships
* nearby word relationships
* semantic relationships
* long-distance relationships

A single attention operation may not be enough to represent all of these relationships effectively.

Therefore, Transformers use multiple attention heads.

---

# 3. Single-Head Attention

We already know:

$$
Attention(Q,K,V)
=
softmax
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

Conceptually:

```text
Input
  ↓
Q, K, V
  ↓
Attention
  ↓
Output
```

This is one attention head.

---

# 4. Multi-Head Attention

Instead of one attention operation:

```text
Input
  ↓
Attention
  ↓
Output
```

we use:

```text
                 Input
                   │
        ┌──────────┼──────────┐
        ↓          ↓          ↓
      Head 1     Head 2     Head 3
        ↓          ↓          ↓
    Attention  Attention  Attention
        ↓          ↓          ↓
        └──────────┼──────────┘
                   ↓
              Concatenate
                   ↓
            Output Projection
                   ↓
                 Output
```

There can be many heads.

For example:

```text
8 heads
12 heads
16 heads
32 heads
```

depending on the model.

---

# 5. Core Formula

For each attention head:

$$
head_i
=
Attention
(QW_i^Q,
KW_i^K,
VW_i^V)
$$

The outputs are concatenated:

$$
MultiHead(Q,K,V)
=
Concat(head_1,\ldots,head_h)W^O
$$

Where:

* $h$ = number of attention heads
* $W_i^Q$ = Query projection for head $i$
* $W_i^K$ = Key projection for head $i$
* $W_i^V$ = Value projection for head $i$
* $W^O$ = output projection

---

# 6. What Does Each Head Learn?

Each head has its own learned projection matrices.

For example:

```text
Head 1
W1Q
W1K
W1V

Head 2
W2Q
W2K
W2V

Head 3
W3Q
W3K
W3V
```

Therefore, different heads can learn different patterns.

For example, during training one head might become sensitive to:

```text
nearby relationships
```

while another may learn:

```text
long-distance relationships
```

Another could learn:

```text
syntactic relationships
```

However:

> We should not assume that a particular head is guaranteed to represent syntax, semantics, etc. The model learns whatever representations are useful for the task.

---

# 7. Input Representation

Suppose:

```text
Sequence:

"I love machine learning"
```

After embedding and positional information:

```text
X
```

Assume:

```text
sequence length = 4
d_model = 512
```

Then:

$$
X \in \mathbb{R}^{4 \times 512}
$$

For a batch:

```text
batch size = 32
```

we have:

$$
X \in \mathbb{R}^{32 \times 4 \times 512}
$$

---

# 8. Splitting the Model Dimension

Suppose:

```text
d_model = 512
number of heads = 8
```

A common Transformer configuration uses:

$$
d_{head}
=
\frac{d_{model}}{h}
$$

Therefore:

$$
d_{head}
=
\frac{512}{8}
=
64
$$

So each head works with:

```text
64 dimensions
```

instead of all 512 dimensions.

---

# 9. Dimension Distribution

Suppose:

```text
d_model = 512
heads = 8
```

Then:

```text
512 dimensions
       ↓
┌──────┬──────┬──────┬──────┐
│ 64   │ 64   │ 64   │ 64   │
├──────┼──────┼──────┼──────┤
│ 64   │ 64   │ 64   │ 64   │
└──────┴──────┴──────┴──────┘
```

Each head receives:

```text
64 dimensions
```

Total:

$$
8 \times 64 = 512
$$

---

# 10. Important Clarification

Conceptually, we can think of splitting the model dimension into heads.

But in an actual implementation, we usually do not separately create eight independent neural networks.

Instead, we commonly use large projection matrices and reshape the result.

For example:

```text
X
 ↓
Linear projection
 ↓
Q
 ↓
Reshape
 ↓
Multiple heads
```

This is computationally efficient.

---

# 11. Query, Key and Value Projections

For self-attention:

$$
Q = XW^Q
$$

$$
K = XW^K
$$

$$
V = XW^V
$$

For multi-head attention, these projections contain information for all heads.

Suppose:

```text
X shape:

(batch, seq_len, d_model)
```

Then:

```text
Q shape:

(batch, seq_len, d_model)
```

and similarly:

```text
K shape:

(batch, seq_len, d_model)

V shape:

(batch, seq_len, d_model)
```

We then reshape them into separate heads.

---

# 12. Shape Transformation

Suppose:

```text
batch = 2
seq_len = 5
d_model = 512
heads = 8
```

Initial Q:

```text
(2, 5, 512)
```

Since:

$$
512 = 8 \times 64
$$

we reshape:

```text
(2, 5, 512)
        ↓
(2, 5, 8, 64)
```

Then transpose:

```text
(2, 8, 5, 64)
```

Now the tensor means:

```text
(batch, heads, sequence_length, head_dimension)
```

---

# 13. Why Transpose?

Attention requires matrix multiplication between Q and K.

We want:

```text
Q:

(batch, heads, seq_len, head_dim)
```

and:

```text
K:

(batch, heads, seq_len, head_dim)
```

To calculate:

$$
QK^T
$$

we transpose the last two dimensions of K:

```text
Kᵀ:

(batch, heads, head_dim, seq_len)
```

Then:

```text
Q × Kᵀ
```

gives:

```text
(batch, heads, seq_len, seq_len)
```

---

# 14. Attention Score Shape

Suppose:

```text
batch = 2
heads = 8
seq_len = 5
head_dim = 64
```

Q:

```text
(2, 8, 5, 64)
```

Kᵀ:

```text
(2, 8, 64, 5)
```

Therefore:

```text
Q × Kᵀ
```

results in:

```text
(2, 8, 5, 5)
```

This means:

```text
2 batches
8 heads
5 query positions
5 key positions
```

---

# 15. One Head's Attention Matrix

For one sequence with 5 tokens:

```text
        Key
       1  2  3  4  5

Q 1   [ .  .  .  .  . ]
u 2   [ .  .  .  .  . ]
e 3   [ .  .  .  .  . ]
r 4   [ .  .  .  .  . ]
y 5   [ .  .  .  .  . ]
```

Every query position compares against every key position.

Therefore:

$$
5 \times 5 = 25
$$

attention scores exist for one head.

With 8 heads:

```text
8 × 25 = 200
```

attention scores exist per sequence.

---

# 16. Attention for Each Head

Each head performs:

$$
head_i =
softmax
\left(
\frac{Q_iK_i^T}
{\sqrt{d_k}}
\right)V_i
$$

Suppose:

```text
Q_i = (5, 64)
K_i = (5, 64)
V_i = (5, 64)
```

Then:

```text
Q_i K_iᵀ

(5,64) × (64,5)
        ↓
      (5,5)
```

After Softmax:

```text
(5,5)
```

Multiply by V:

```text
(5,5) × (5,64)
        ↓
      (5,64)
```

Therefore each head produces:

```text
(5,64)
```

---

# 17. Concatenating the Heads

Suppose there are 8 heads:

```text
Head 1 → (5,64)
Head 2 → (5,64)
Head 3 → (5,64)
Head 4 → (5,64)
Head 5 → (5,64)
Head 6 → (5,64)
Head 7 → (5,64)
Head 8 → (5,64)
```

Concatenate them:

$$
5 \times (8 \times 64)
$$

Therefore:

```text
(5,512)
```

So:

```text
8 heads
   ↓
Concatenate
   ↓
512 dimensions
```

---

# 18. Output Projection

After concatenation, we apply another learned linear transformation.

$$
Output =
Concat(head_1,\ldots,head_h)W^O
$$

If:

```text
Concatenated output:

(5,512)
```

and:

```text
W^O:

(512,512)
```

then:

```text
(5,512) × (512,512)
          ↓
        (5,512)
```

The final output has the same model dimension:

```text
d_model = 512
```

---

# 19. Complete Data Flow

The complete process is:

```text
                   Input X
                      │
              ┌───────┴───────┐
              ↓       ↓       ↓
              Q       K       V
              │       │       │
              ↓       ↓       ↓
          Split into multiple heads
              │       │       │
        ┌─────┼───────┼───────┐
        ↓     ↓       ↓       ↓
      Head1 Head2   Head3    HeadN
        ↓     ↓       ↓       ↓
    Attention Attention ... Attention
        ↓     ↓       ↓       ↓
        └─────┼───────┼───────┘
              ↓
        Concatenate Heads
              ↓
       Output Projection
              ↓
            Output
```

---

# 20. Mathematical Summary

For head $i$:

$$
Q_i = XW_i^Q
$$

$$
K_i = XW_i^K
$$

$$
V_i = XW_i^V
$$

Then:

$$
head_i =
softmax
\left(
\frac{Q_iK_i^T}
{\sqrt{d_k}}
\right)V_i
$$

Finally:

$$
\boxed{
MultiHead(X)
=
Concat(head_1,\ldots,head_h)W^O
}
$$

---

# 21. Why Not Just Use One Large Attention?

An important question is:

> Why split the representation into multiple heads?

Multiple heads allow the model to perform different learned projections and therefore attend to information in different representation subspaces.

Conceptually:

```text
Head 1
→ Relationship A

Head 2
→ Relationship B

Head 3
→ Relationship C

Head 4
→ Relationship D
```

The outputs are then combined.

This gives the model multiple ways of representing contextual relationships.

---

# 22. Example

Consider:

```text
"The dog chased the cat because it was hungry."
```

The token:

```text
"it"
```

may need to determine what it refers to.

Different heads can learn different relationships:

```text
Head 1
"it" ↔ nearby words

Head 2
"it" ↔ possible subject

Head 3
"it" ↔ grammatical relationships

Head 4
"it" ↔ semantic relationships
```

Again, these are examples of what heads might learn, not fixed rules.

---

# 23. Practical NumPy Implementation

Let's implement multi-head self-attention from scratch.

```python
import numpy as np


def softmax(x, axis=-1):

    x = x - np.max(
        x,
        axis=axis,
        keepdims=True
    )

    exp_x = np.exp(x)

    return exp_x / np.sum(
        exp_x,
        axis=axis,
        keepdims=True
    )


class MultiHeadAttention:

    def __init__(
        self,
        d_model,
        num_heads
    ):

        assert d_model % num_heads == 0

        self.d_model = d_model
        self.num_heads = num_heads
        self.head_dim = d_model // num_heads

        self.Wq = np.random.randn(
            d_model,
            d_model
        ) * 0.01

        self.Wk = np.random.randn(
            d_model,
            d_model
        ) * 0.01

        self.Wv = np.random.randn(
            d_model,
            d_model
        ) * 0.01

        self.Wo = np.random.randn(
            d_model,
            d_model
        ) * 0.01

    def split_heads(self, x):

        seq_len = x.shape[0]

        x = x.reshape(
            seq_len,
            self.num_heads,
            self.head_dim
        )

        return x.transpose(1, 0, 2)

    def forward(self, x):

        # Linear projections
        Q = x @ self.Wq
        K = x @ self.Wk
        V = x @ self.Wv

        # Split into heads
        Q = self.split_heads(Q)
        K = self.split_heads(K)
        V = self.split_heads(V)

        # Attention
        scores = Q @ K.transpose(
            0, 2, 1
        )

        scores = scores / np.sqrt(
            self.head_dim
        )

        weights = softmax(
            scores,
            axis=-1
        )

        heads = weights @ V

        # Combine heads
        heads = heads.transpose(
            1, 0, 2
        )

        seq_len = x.shape[0]

        combined = heads.reshape(
            seq_len,
            self.d_model
        )

        # Output projection
        output = combined @ self.Wo

        return output
```

---

# 24. Test NumPy Implementation

```python
d_model = 128
num_heads = 4
seq_len = 5

x = np.random.randn(
    seq_len,
    d_model
)

mha = MultiHeadAttention(
    d_model=d_model,
    num_heads=num_heads
)

output = mha.forward(x)

print("Input shape:", x.shape)
print("Output shape:", output.shape)
```

Expected:

```text
Input shape:  (5, 128)
Output shape: (5, 128)
```

Notice:

```text
Input:
(5,128)

Output:
(5,128)
```

The sequence length and model dimension remain unchanged.

---

# 25. Understanding the NumPy Code

The most important part is:

```python
Q = x @ self.Wq
K = x @ self.Wk
V = x @ self.Wv
```

This creates:

```text
Q
K
V
```

Then:

```python
Q = self.split_heads(Q)
```

changes:

```text
(seq_len, d_model)
```

into:

```text
(num_heads, seq_len, head_dim)
```

Then:

```python
scores = Q @ K.transpose(0, 2, 1)
```

calculates:

$$
QK^T
$$

Then:

```python
scores = scores / np.sqrt(self.head_dim)
```

performs scaling.

Then:

```python
weights = softmax(scores, axis=-1)
```

converts scores into attention weights.

Finally:

```python
heads = weights @ V
```

calculates the weighted values.

---

# 26. PyTorch Implementation

Now let's implement the same idea in PyTorch.

```python
import torch
import torch.nn as nn
import math


class MultiHeadSelfAttention(nn.Module):

    def __init__(
        self,
        d_model,
        num_heads
    ):
        super().__init__()

        assert d_model % num_heads == 0

        self.d_model = d_model
        self.num_heads = num_heads
        self.head_dim = d_model // num_heads

        self.q_projection = nn.Linear(
            d_model,
            d_model
        )

        self.k_projection = nn.Linear(
            d_model,
            d_model
        )

        self.v_projection = nn.Linear(
            d_model,
            d_model
        )

        self.output_projection = nn.Linear(
            d_model,
            d_model
        )

    def forward(self, x):

        batch_size, seq_len, _ = x.shape

        Q = self.q_projection(x)
        K = self.k_projection(x)
        V = self.v_projection(x)

        # Split heads
        Q = Q.view(
            batch_size,
            seq_len,
            self.num_heads,
            self.head_dim
        )

        K = K.view(
            batch_size,
            seq_len,
            self.num_heads,
            self.head_dim
        )

        V = V.view(
            batch_size,
            seq_len,
            self.num_heads,
            self.head_dim
        )

        # Move heads before sequence dimension
        Q = Q.transpose(1, 2)
        K = K.transpose(1, 2)
        V = V.transpose(1, 2)

        # Attention scores
        scores = torch.matmul(
            Q,
            K.transpose(-2, -1)
        )

        scores = scores / math.sqrt(
            self.head_dim
        )

        # Attention weights
        weights = torch.softmax(
            scores,
            dim=-1
        )

        # Weighted values
        output = torch.matmul(
            weights,
            V
        )

        # Combine heads
        output = output.transpose(
            1,
            2
        )

        output = output.contiguous().view(
            batch_size,
            seq_len,
            self.d_model
        )

        # Output projection
        output = self.output_projection(
            output
        )

        return output
```

---

# 27. Testing the PyTorch Implementation

```python
batch_size = 2
seq_len = 10
d_model = 128
num_heads = 4

x = torch.randn(
    batch_size,
    seq_len,
    d_model
)

mha = MultiHeadSelfAttention(
    d_model=d_model,
    num_heads=num_heads
)

output = mha(x)

print("Input:", x.shape)
print("Output:", output.shape)
```

Output:

```text
Input:  torch.Size([2, 10, 128])
Output: torch.Size([2, 10, 128])
```

---

# 28. Shape Tracking

This is one of the most important things to understand.

Suppose:

```text
batch = 2
seq_len = 10
d_model = 128
heads = 4
```

Then:

$$
d_{head} = 128/4 = 32
$$

### Input

```text
(2, 10, 128)
```

### Q/K/V projection

```text
(2, 10, 128)
```

### Split heads

```text
(2, 10, 4, 32)
```

### Transpose

```text
(2, 4, 10, 32)
```

### Attention scores

```text
(2, 4, 10, 10)
```

### Attention output

```text
(2, 4, 10, 32)
```

### Combine heads

```text
(2, 10, 128)
```

### Output projection

```text
(2, 10, 128)
```

Remember this flow:

```text
(batch, seq, d_model)
        ↓
(batch, heads, seq, head_dim)
        ↓
(batch, heads, seq, seq)
        ↓
(batch, heads, seq, head_dim)
        ↓
(batch, seq, d_model)
```

---

# 29. Using PyTorch's Built-In Module

In real projects, you normally don't need to implement multi-head attention manually.

PyTorch provides:

```python
nn.MultiheadAttention
```

Example:

```python
import torch
import torch.nn as nn


d_model = 128
num_heads = 4

attention = nn.MultiheadAttention(
    embed_dim=d_model,
    num_heads=num_heads,
    batch_first=True
)

x = torch.randn(
    2,
    10,
    d_model
)

output, attention_weights = attention(
    x,
    x,
    x
)

print("Output:", output.shape)
print(
    "Attention weights:",
    attention_weights.shape
)
```

Typical result:

```text
Output:
[2, 10, 128]

Attention weights:
[2, 10, 10]
```

---

# 30. Why Is Attention Weight Shape Sometimes Different?

In our from-scratch implementation, attention weights have:

```text
(batch, heads, seq_len, seq_len)
```

For example:

```text
(2, 4, 10, 10)
```

But PyTorch's `MultiheadAttention` may return averaged attention weights by default:

```text
(batch, seq_len, seq_len)
```

If you want weights separately for every head:

```python
output, weights = attention(
    x,
    x,
    x,
    need_weights=True,
    average_attn_weights=False
)

print(weights.shape)
```

Now the shape is typically:

```text
[2, 4, 10, 10]
```

---

# 31. Practical Development Example

Suppose you're building a sentiment classifier.

Input:

```text
"The movie was surprisingly good"
```

Token representations:

```text
"The"
"movie"
"was"
"surprisingly"
"good"
```

The multi-head attention layer creates multiple contextual views.

Conceptually:

```text
Head 1
"The" ↔ "movie"

Head 2
"surprisingly" ↔ "good"

Head 3
"movie" ↔ "good"

Head 4
"was" ↔ "good"
```

The actual relationships are learned during training.

Then:

```text
Multiple heads
      ↓
Concatenate
      ↓
Output projection
      ↓
Contextual representation
      ↓
Classifier
      ↓
Positive
```

---

# 32. Small Classification Model

```python
import torch
import torch.nn as nn


class SentimentModel(nn.Module):

    def __init__(
        self,
        vocab_size,
        d_model=128,
        num_heads=4,
        num_classes=2
    ):
        super().__init__()

        self.embedding = nn.Embedding(
            vocab_size,
            d_model
        )

        self.attention = nn.MultiheadAttention(
            embed_dim=d_model,
            num_heads=num_heads,
            batch_first=True
        )

        self.classifier = nn.Linear(
            d_model,
            num_classes
        )

    def forward(self, tokens):

        x = self.embedding(tokens)

        attention_output, _ = self.attention(
            x,
            x,
            x
        )

        # Mean pooling
        x = attention_output.mean(
            dim=1
        )

        logits = self.classifier(x)

        return logits
```

Testing:

```python
vocab_size = 10000

model = SentimentModel(
    vocab_size=vocab_size
)

tokens = torch.randint(
    0,
    vocab_size,
    (4, 10)
)

logits = model(tokens)

print(logits.shape)
```

Output:

```text
torch.Size([4, 2])
```

Meaning:

```text
4 → batch size
2 → sentiment classes
```

---

# 33. Why Output Projection Is Needed

After concatenation, we get:

```text
head_1 || head_2 || ... || head_h
```

This creates:

```text
d_model
```

dimensions.

The output projection:

$$
W^O
$$

allows the model to mix information from different heads.

Conceptually:

```text
Head 1 ──┐
Head 2 ──┤
Head 3 ──┤
Head 4 ──┤
          ↓
     Concatenate
          ↓
     Output Linear
          ↓
       Combined
```

Without this learned projection, the model would have less flexibility in combining the head outputs.

---

# 34. Parameter Count

Suppose:

```text
d_model = 512
```

We have:

```text
WQ → 512 × 512
WK → 512 × 512
WV → 512 × 512
WO → 512 × 512
```

Ignoring biases:

$$
4 \times 512^2
$$

$$
=1,048,576
$$

So approximately:

```text
1.05 million parameters
```

The important point is that increasing the number of heads does not necessarily mean multiplying the total projection parameter count by the number of heads when the total model dimension stays fixed.

---

# 35. Number of Heads vs Head Dimension

Usually:

$$
d_{head}
=
\frac{d_{model}}{h}
$$

Therefore, if:

```text
d_model = 512
```

then:

| Heads | Head Dimension |
| ----: | -------------: |
|     1 |            512 |
|     2 |            256 |
|     4 |            128 |
|     8 |             64 |
|    16 |             32 |

A common requirement is:

$$
d_{model} \mod h = 0
$$

so that the dimensions can be evenly divided.

---

# 36. Does More Heads Always Mean Better?

No.

Increasing the number of heads does not automatically improve the model.

There is a trade-off involving:

* computational efficiency
* head dimension
* model architecture
* training data
* model size

For a fixed $d_{model}$:

```text
More heads
    ↓
Smaller head dimension
```

So the number of heads must be chosen appropriately.

---

# 37. Computational Complexity

Multi-head attention still has the same fundamental quadratic dependency on sequence length as standard full self-attention.

For sequence length $n$:

$$
O(n^2)
$$

The model dimension also contributes to computation.

A common high-level expression for attention computation is approximately:

$$
O(n^2d_{model})
$$

The important GATE-level idea is:

$$
\boxed{Attention \text{ is quadratic in sequence length}}
$$

---

# 38. Memory Complexity

The attention score matrix has shape:

```text
(batch, heads, seq_len, seq_len)
```

Therefore memory usage grows approximately as:

$$
O(n^2)
$$

with respect to sequence length.

Example:

```text
n = 100

100 × 100 = 10,000
```

```text
n = 1,000

1,000 × 1,000 = 1,000,000
```

```text
n = 10,000

10,000 × 10,000 = 100,000,000
```

This is one reason long-context Transformers are computationally expensive.

---

# 39. Common Mistakes

## Mistake 1: Forgetting the scaling factor

Incorrect:

$$
softmax(QK^T)V
$$

Standard scaled attention:

$$
softmax
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

---

## Mistake 2: Incorrect head dimension

If:

```text
d_model = 128
heads = 4
```

then:

$$
d_{head}=32
$$

Not:

```text
128
```

for each head.

---

## Mistake 3: Forgetting to transpose K

For:

```text
Q = (seq_len, head_dim)
K = (seq_len, head_dim)
```

we need:

```text
K.T = (head_dim, seq_len)
```

Then:

```text
Q @ K.T
```

produces:

```text
(seq_len, seq_len)
```

---

## Mistake 4: Forgetting to combine heads

After attention:

```text
(num_heads, seq_len, head_dim)
```

must eventually be combined into:

```text
(seq_len, d_model)
```

---

## Mistake 5: Assuming heads have fixed meanings

Do not say:

```text
Head 1 = grammar
Head 2 = semantics
Head 3 = nouns
```

as a guaranteed property.

The heads learn representations from training.

---

# 40. GATE Important Points

### Point 1

Multi-head attention performs multiple attention operations in parallel.

---

### Point 2

For head $i$:

$$
head_i =
Attention(QW_i^Q,KW_i^K,VW_i^V)
$$

---

### Point 3

Final output:

$$
MultiHead(Q,K,V)
=
Concat(head_1,\ldots,head_h)W^O
$$

---

### Point 4

Commonly:

$$
d_{head}=\frac{d_{model}}{h}
$$

---

### Point 5

For:

```text
d_model = 512
heads = 8
```

we get:

$$
d_{head}=64
$$

---

### Point 6

Attention score shape per head:

$$
(seq\_len,seq\_len)
$$

---

### Point 7

For a batch:

```text
(batch, heads, seq_len, seq_len)
```

---

### Point 8

Full self-attention has:

$$
O(n^2)
$$

sequence-length complexity.

---

### Point 9

The output projection mixes information from different heads.

---

### Point 10

The number of heads does not necessarily increase total projection parameters by a factor of the number of heads when $d_{model}$ remains fixed.

---

# 41. Interview Questions

## Q1. What is multi-head attention?

Multi-head attention performs multiple attention operations using different learned projections and combines their outputs.

---

## Q2. Why use multiple heads?

To allow the model to learn different relationships and representations in different learned subspaces.

---

## Q3. What is the formula for multi-head attention?

$$
MultiHead(Q,K,V)
=
Concat(head_1,\ldots,head_h)W^O
$$

where:

$$
head_i =
Attention(QW_i^Q,KW_i^K,VW_i^V)
$$

---

## Q4. If d_model = 512 and there are 8 heads, what is the head dimension?

$$
512/8=64
$$

---

## Q5. What is the shape of attention scores?

For one head:

$$
(seq\_len,seq\_len)
$$

For batched multi-head attention:

$$
(batch,heads,seq\_len,seq\_len)
$$

---

## Q6. Why do we concatenate heads?

To combine the information learned by all attention heads.

---

## Q7. Why do we use an output projection?

To learn how to mix the information from the different heads and map it back into the model dimension.

---

## Q8. Does increasing the number of heads always improve performance?

No.

More heads are not automatically better. The head dimension, model size, computation, and training setup all matter.

---

## Q9. Does multi-head attention remove the O(n²) problem?

No.

Full multi-head self-attention still has quadratic sequence-length complexity.

---

## Q10. What is the difference between self-attention and multi-head self-attention?

Self-attention describes the mechanism where Q, K and V come from the same sequence.

Multi-head self-attention performs that mechanism multiple times using different learned projections.

---

# 42. Mental Model

Remember multi-head attention as:

```text
              Input
                ↓
          Create Q, K, V
                ↓
        ┌───────┼───────┐
        ↓       ↓       ↓
      Head 1  Head 2  Head 3 ... Head N
        ↓       ↓       ↓
    Attention Attention Attention
        ↓       ↓       ↓
        └───────┼───────┘
                ↓
           Concatenate
                ↓
         Output Projection
                ↓
              Output
```

The key idea:

$$
\boxed{
Multiple\ Attention\ Heads
\rightarrow
Multiple\ Learned\ Representations
\rightarrow
Combine
}
$$

---

# 43. Complete Transformer Encoder So Far

We have now learned:

```text
Input Tokens
     ↓
Token Embedding
     ↓
Positional Encoding
     ↓
Multi-Head Self-Attention
     ↓
Residual Connection
     ↓
Layer Normalization
     ↓
Feed-Forward Network
     ↓
Residual Connection
     ↓
Layer Normalization
     ↓
Output
```

The components we have studied in detail are:

```text
✓ Self-Attention
✓ Positional Encoding
✓ Multi-Head Attention
```

We will next study the component that comes immediately after attention:

```text
Feed-Forward Network
```

---

# 44. What We Learn Next

Next file:

```text
05-feed-forward-network.md
```

We will learn:

* What is a Feed-Forward Network (FFN)?
* Why Transformers need FFN after attention
* The mathematical formula
* Linear → Activation → Linear
* d_model and d_ff
* Why d_ff is usually larger than d_model
* Position-wise FFN
* ReLU and GELU
* NumPy implementation
* PyTorch implementation
* Parameter calculation
* Practical development example
* GATE questions
* Interview questions

```
```
