### `03-positional-encoding.md`

````markdown
# Positional Encoding

## 1. Introduction

Transformers use self-attention to understand relationships between tokens.

However, self-attention by itself does not inherently know the order of tokens.

Consider:

```text
"I love dogs"
````

and:

```text
"Dogs love I"
```

The same words are present, but their order is different.

For NLP, order is extremely important.

Therefore, Transformers need a mechanism to provide information about the position of each token.

This mechanism is called:

# Positional Encoding

---

# 2. Why Does Attention Need Position?

Suppose the sentence is:

```text
I love machine learning
```

The tokens are:

```text
I
love
machine
learning
```

Their positions are:

```text
I         → 0
love      → 1
machine   → 2
learning  → 3
```

The Transformer needs to know both:

```text
What is the token?
+
Where is the token?
```

Therefore:

```text
Token Embedding
       +
Positional Encoding
       ↓
Transformer Input
```

---

# 3. Token Embedding Alone Is Not Enough

Suppose the token:

```text
"dog"
```

has embedding:

```text
[0.2, 0.7, -0.1, 0.5]
```

If `"dog"` appears at different positions:

```text
The dog runs
      ↑
   position 1
```

and:

```text
Dog runs quickly
↑
position 0
```

the token embedding itself may be the same.

Therefore, we need to add position information.

---

# 4. Basic Idea

Suppose:

```text
Token Embedding:

dog → [0.2, 0.7, -0.1, 0.5]
```

and positional encoding for position 1 is:

```text
[0.1, 0.3, 0.2, 0.4]
```

Then:

```text
Final Representation
=
Token Embedding
+
Positional Encoding
```

Therefore:

```text
[0.2, 0.7, -0.1, 0.5]
+
[0.1, 0.3,  0.2, 0.4]
--------------------------------
[0.3, 1.0,  0.1, 0.9]
```

The Transformer now receives both:

```text
Semantic information
+
Position information
```

---

# 5. Two Major Approaches

There are two common ways to represent position.

## 1. Fixed Positional Encoding

The original Transformer used:

```text
Sinusoidal Positional Encoding
```

It is calculated using sine and cosine functions.

---

## 2. Learned Positional Embeddings

Instead of calculating the positions using a fixed formula, the model learns position vectors during training.

Modern Transformer architectures may use learned positional embeddings or other positional mechanisms.

In this file, we first study the original:

# Sinusoidal Positional Encoding

---

# 6. Sinusoidal Positional Encoding

The original Transformer paper proposed:

$$
PE_{(pos,2i)}
=
\sin
\left(
\frac{pos}{10000^{2i/d_{model}}}
\right)
$$

and:

$$
PE_{(pos,2i+1)}
=
\cos
\left(
\frac{pos}{10000^{2i/d_{model}}}
\right)
$$

Where:

* $pos$ = position of the token
* $i$ = dimension index
* $d_{model}$ = embedding dimension
* $2i$ = even dimension
* $2i+1$ = odd dimension

---

# 7. Understanding the Formula

The formula looks complicated, but the idea is simple.

For every token position:

```text
Position
   ↓
Generate a vector
   ↓
Add it to token embedding
```

Example:

```text
Position 0 → positional vector
Position 1 → positional vector
Position 2 → positional vector
Position 3 → positional vector
```

Each position receives a unique pattern of values.

---

# 8. Even and Odd Dimensions

The Transformer alternates between sine and cosine.

For example:

```text
Dimension:

0 → sin
1 → cos
2 → sin
3 → cos
4 → sin
5 → cos
...
```

So:

```text
Even dimensions → sine
Odd dimensions  → cosine
```

---

# 9. Small Example

Suppose:

```text
d_model = 4
```

Then each position gets 4 values.

Conceptually:

```text
Position 0:

[sin(...), cos(...), sin(...), cos(...)]
```

Position 1:

```text
[sin(...), cos(...), sin(...), cos(...)]
```

Position 2:

```text
[sin(...), cos(...), sin(...), cos(...)]
```

Each position has a different pattern.

---

# 10. Why Sine and Cosine?

Using sine and cosine gives the model smooth positional patterns.

Nearby positions have related representations.

For example:

```text
Position 10
     ↓
Position 11
     ↓
Position 12
```

Their positional encodings change smoothly.

This can help the model learn relative relationships between positions.

---

# 11. Different Frequencies

An important idea is that different dimensions use different frequencies.

Conceptually:

```text
Dimension 0 → high-frequency pattern
Dimension 1 → high-frequency pattern

Dimension 2 → lower-frequency pattern
Dimension 3 → lower-frequency pattern

Dimension 4 → even lower-frequency pattern
...
```

Therefore, the positional vector contains information at multiple scales.

You can think of it like:

```text
Fast-changing dimensions
        +
Slow-changing dimensions
        ↓
Unique position representation
```

---

# 12. Why Different Frequencies Matter

Suppose we only used one sine wave.

Then positions could eventually have similar values because sine is periodic.

But using many dimensions with different frequencies creates a much richer positional pattern.

Conceptually:

```text
Position
   ↓
┌─────────────────────────┐
│ Frequency 1             │
│ Frequency 2             │
│ Frequency 3             │
│ Frequency 4             │
│ ...                     │
└─────────────────────────┘
   ↓
Position Representation
```

---

# 13. Visual Intuition

Imagine positional encoding as a fingerprint for each position.

```text
Position 0
[0.00, 1.00, 0.00, 1.00, ...]

Position 1
[0.84, 0.54, 0.01, 1.00, ...]

Position 2
[0.91, -0.42, 0.02, 1.00, ...]

Position 3
[0.14, -0.99, 0.03, 1.00, ...]
```

The exact values depend on the dimension and formula.

The important idea is:

```text
Position 0 ≠ Position 1 ≠ Position 2
```

---

# 14. Position Matrix

Suppose:

```text
Sequence length = 4
d_model = 6
```

Then the positional encoding matrix has shape:

$$
(4,6)
$$

Conceptually:

```text
             Dimensions
          0    1    2    3    4    5

Pos 0    [ .    .    .    .    .    . ]
Pos 1    [ .    .    .    .    .    . ]
Pos 2    [ .    .    .    .    .    . ]
Pos 3    [ .    .    .    .    .    . ]
```

General shape:

$$
(sequence\_length,d_{model})
$$

---

# 15. Adding Positional Encoding

Suppose:

```text
Token embeddings:

X
shape = (sequence_length, d_model)
```

and:

```text
Positional Encoding:

PE
shape = (sequence_length, d_model)
```

Then:

$$
X_{input}=X+PE
$$

The shapes must match.

Example:

```text
X:

(10, 512)

PE:

(10, 512)

Result:

(10, 512)
```

---

# 16. Batch Dimension

In practical development, we usually have batches.

Suppose:

```text
batch_size = 32
sequence_length = 100
d_model = 512
```

Token embeddings:

```text
(32, 100, 512)
```

Positional encoding:

```text
(100, 512)
```

The same positional encoding can be added to every sequence in the batch through broadcasting.

Conceptually:

```text
Batch 1 ──┐
Batch 2 ──┤
Batch 3 ──┤ → Same position pattern
...       │
Batch 32 ─┘
```

Result:

```text
(32, 100, 512)
```

---

# 17. NumPy Implementation

Let's implement sinusoidal positional encoding from scratch.

```python
import numpy as np


def positional_encoding(seq_len, d_model):

    pe = np.zeros((seq_len, d_model))

    for pos in range(seq_len):

        for i in range(0, d_model, 2):

            denominator = 10000 ** (i / d_model)

            pe[pos, i] = np.sin(
                pos / denominator
            )

            if i + 1 < d_model:
                pe[pos, i + 1] = np.cos(
                    pos / denominator
                )

    return pe
```

---

# 18. Test the Implementation

```python
seq_len = 10
d_model = 8

pe = positional_encoding(
    seq_len,
    d_model
)

print(pe)
print("Shape:", pe.shape)
```

Output shape:

```text
(10, 8)
```

Meaning:

```text
10 positions
8 dimensions per position
```

---

# 19. Vectorized NumPy Implementation

The nested loops are useful for learning, but production code should generally avoid unnecessary Python loops.

A vectorized implementation:

```python
import numpy as np


def positional_encoding(seq_len, d_model):

    positions = np.arange(seq_len)[:, np.newaxis]

    dimensions = np.arange(d_model)[np.newaxis, :]

    angle_rates = 1 / np.power(
        10000,
        (2 * (dimensions // 2)) / d_model
    )

    angle_rads = positions * angle_rates

    pe = np.zeros_like(
        angle_rads,
        dtype=np.float64
    )

    pe[:, 0::2] = np.sin(
        angle_rads[:, 0::2]
    )

    pe[:, 1::2] = np.cos(
        angle_rads[:, 1::2]
    )

    return pe
```

Test:

```python
pe = positional_encoding(
    seq_len=10,
    d_model=8
)

print(pe.shape)
```

Output:

```text
(10, 8)
```

---

# 20. Visualizing Positional Encoding

Visualization is one of the best ways to understand positional encoding.

```python
import matplotlib.pyplot as plt

seq_len = 100
d_model = 64

pe = positional_encoding(
    seq_len,
    d_model
)

plt.figure(figsize=(12, 6))

plt.imshow(
    pe,
    aspect="auto"
)

plt.xlabel("Embedding Dimension")
plt.ylabel("Position")
plt.title("Sinusoidal Positional Encoding")

plt.show()
```

You will see patterns changing across:

```text
Position
     ↓

┌───────────────────────────┐
│ waves / patterns          │
│ waves / patterns          │
│ waves / patterns          │
│ ...                       │
└───────────────────────────┘
       → dimensions
```

Different dimensions change at different rates.

---

# 21. Complete Embedding Pipeline

Suppose:

```text
Input:

"I love NLP"
```

After tokenization:

```text
[12, 54, 87]
```

Token embedding:

```text
Embedding
   ↓
(3, 512)
```

Positional encoding:

```text
PE
   ↓
(3, 512)
```

Add:

```text
Embedding + PE
   ↓
(3, 512)
```

Then send to Transformer:

```text
(3, 512)
   ↓
Multi-Head Attention
```

---

# 22. PyTorch Implementation From Scratch

Let's implement sinusoidal positional encoding using PyTorch.

```python
import torch
import math


class PositionalEncoding(torch.nn.Module):

    def __init__(
        self,
        d_model,
        max_len=5000
    ):
        super().__init__()

        pe = torch.zeros(
            max_len,
            d_model
        )

        position = torch.arange(
            0,
            max_len,
            dtype=torch.float
        ).unsqueeze(1)

        div_term = torch.exp(
            torch.arange(
                0,
                d_model,
                2
            ).float()
            * (-math.log(10000.0) / d_model)
        )

        pe[:, 0::2] = torch.sin(
            position * div_term
        )

        pe[:, 1::2] = torch.cos(
            position * div_term
        )

        pe = pe.unsqueeze(0)

        self.register_buffer(
            "pe",
            pe
        )

    def forward(self, x):

        seq_len = x.size(1)

        return x + self.pe[:, :seq_len]
```

---

# 23. Why register_buffer()?

In PyTorch:

```python
self.register_buffer(
    "pe",
    pe
)
```

means:

* `pe` is stored with the model
* it is moved to GPU with the model
* it is saved in the model's state
* it is not a trainable parameter

This is appropriate because sinusoidal positional encoding is fixed.

---

# 24. Testing PyTorch Positional Encoding

```python
import torch

batch_size = 2
seq_len = 10
d_model = 128

x = torch.randn(
    batch_size,
    seq_len,
    d_model
)

pos_encoding = PositionalEncoding(
    d_model=d_model,
    max_len=500
)

output = pos_encoding(x)

print("Input:", x.shape)
print("Output:", output.shape)
```

Output:

```text
Input:  torch.Size([2, 10, 128])
Output: torch.Size([2, 10, 128])
```

The shape does not change.

Only the values change.

---

# 25. Learned Positional Embeddings

Instead of calculating positions using sine and cosine, we can learn them.

For example:

```python
import torch
import torch.nn as nn


max_seq_len = 512
d_model = 128

position_embedding = nn.Embedding(
    max_seq_len,
    d_model
)
```

Then:

```python
positions = torch.arange(
    seq_len
)

position_vectors = position_embedding(
    positions
)
```

These vectors are trainable.

---

# 26. Learned Position Example

Suppose:

```text
Position 0
→ learnable vector

Position 1
→ learnable vector

Position 2
→ learnable vector
```

During training:

```text
Position Embeddings
        ↓
Gradient Descent
        ↓
Updated Position Embeddings
```

Unlike sinusoidal encoding, the values are learned from the training data.

---

# 27. Sinusoidal vs Learned

| Feature                                              | Sinusoidal     | Learned             |
| ---------------------------------------------------- | -------------- | ------------------- |
| Values fixed?                                        | Yes            | No                  |
| Trainable?                                           | No             | Yes                 |
| Requires embedding parameters?                       | No             | Yes                 |
| Used in original Transformer?                        | Yes            | No                  |
| Can represent positions using deterministic formula? | Yes            | No                  |
| Common in modern models?                             | Less universal | Common historically |

Modern Transformers can also use other positional methods such as:

```text
RoPE
ALiBi
Relative Position Bias
```

These are important for modern LLMs but are beyond the basic original Transformer architecture.

---

# 28. Why Can't We Just Give Position Numbers?

One might think:

```text
Token → Position

"I"       → 0
"love"    → 1
"machine" → 2
```

Why not simply add:

```text
0
1
2
3
```

to the embeddings?

Because a scalar position number does not provide a rich representation of position across the embedding dimensions.

For example:

```text
Position 10
```

is simply:

```text
10
```

But positional encoding provides a vector:

```text
[0.54, -0.84, 0.01, 0.99, ...]
```

This provides much richer information.

---

# 29. Why Not One-Hot Encode Position?

We could theoretically represent:

```text
Position 0 → [1,0,0,0,...]
Position 1 → [0,1,0,0,...]
Position 2 → [0,0,1,0,...]
```

But this has disadvantages:

* requires large vectors
* does not naturally represent relationships between positions
* inefficient for large sequence lengths

Sinusoidal encodings provide compact continuous representations.

---

# 30. Relative Position Intuition

Absolute position tells us:

```text
"machine" is at position 2
```

But often what matters is:

```text
"machine" is 2 positions before "learning"
```

Relative position information can be very useful.

This motivated later techniques such as:

```text
Relative Position Encoding
RoPE
ALiBi
```

Modern LLMs often use more advanced positional mechanisms than the original sinusoidal approach.

---

# 31. Important Mathematical Property

Sinusoidal encodings use:

$$
\sin
\left(
\frac{pos}{10000^{2i/d}}
\right)
$$

and:

$$
\cos
\left(
\frac{pos}{10000^{2i/d}}
\right)
$$

Different dimensions therefore have different wavelengths.

Conceptually:

```text
Dimension

0 → short wavelength
1 → short wavelength

2 → longer wavelength
3 → longer wavelength

4 → even longer wavelength
5 → even longer wavelength
```

This allows the encoding to contain information about position at multiple scales.

---

# 32. Shape Example

Suppose:

```text
batch_size = 32
seq_len = 128
d_model = 512
```

Token embedding:

```text
(32, 128, 512)
```

Positional encoding:

```text
(128, 512)
```

After broadcasting:

```text
(32, 128, 512)
```

Addition:

```text
(32, 128, 512)
+
(32, 128, 512)
----------------
(32, 128, 512)
```

The Transformer receives:

```text
(32, 128, 512)
```

---

# 33. Practical Development Example

Let's create a small text representation pipeline.

```python
import torch
import torch.nn as nn


class TransformerInput(nn.Module):

    def __init__(
        self,
        vocab_size,
        d_model,
        max_len
    ):
        super().__init__()

        self.embedding = nn.Embedding(
            vocab_size,
            d_model
        )

        self.position_embedding = nn.Embedding(
            max_len,
            d_model
        )

    def forward(self, tokens):

        batch_size, seq_len = tokens.shape

        positions = torch.arange(
            seq_len,
            device=tokens.device
        )

        token_vectors = self.embedding(
            tokens
        )

        position_vectors = self.position_embedding(
            positions
        )

        return token_vectors + position_vectors
```

---

# 34. Test the Pipeline

```python
vocab_size = 10000
d_model = 128
max_len = 512

model = TransformerInput(
    vocab_size,
    d_model,
    max_len
)

tokens = torch.tensor([
    [10, 20, 30, 40],
    [15, 25, 35, 45]
])

output = model(tokens)

print("Tokens:", tokens.shape)
print("Output:", output.shape)
```

Output:

```text
Tokens: torch.Size([2, 4])
Output: torch.Size([2, 4, 128])
```

Meaning:

```text
2   → batch size
4   → sequence length
128 → embedding dimension
```

---

# 35. Important Development Rule

Always make sure:

```text
Token embedding dimension
=
Positional encoding dimension
=
d_model
```

For example:

```text
Embedding → 512
Position  → 512
Transformer → 512
```

Correct.

But:

```text
Embedding → 512
Position  → 128
```

cannot be directly added.

You would get a shape mismatch.

---

# 36. Common Mistakes

## Mistake 1: Forgetting positional information

Using:

```text
Token Embedding
      ↓
Attention
```

without a suitable positional mechanism can make order difficult to represent.

---

## Mistake 2: Wrong dimensions

Incorrect:

```text
Embedding: 512
PE:        256
```

Correct:

```text
Embedding: 512
PE:        512
```

---

## Mistake 3: Confusing position with token ID

These are different.

```text
Token ID:

"cat" → 1532
```

Position:

```text
"cat" appears at position 4
```

So:

```text
Token ID ≠ Position
```

---

## Mistake 4: Assuming all modern Transformers use sinusoidal encoding

They don't.

Modern architectures use different approaches, including:

```text
Learned embeddings
RoPE
Relative position methods
ALiBi
```

---

# 37. GATE Important Points

### Point 1

Self-attention alone does not inherently encode token order.

---

### Point 2

Positional encoding is added to token embeddings.

$$
X = Embedding + PE
$$

---

### Point 3

Original Transformer uses sinusoidal positional encoding.

---

### Point 4

Even dimensions use sine:

$$
PE_{(pos,2i)}
=
\sin
\left(
\frac{pos}{10000^{2i/d}}
\right)
$$

---

### Point 5

Odd dimensions use cosine:

$$
PE_{(pos,2i+1)}
=
\cos
\left(
\frac{pos}{10000^{2i/d}}
\right)
$$

---

### Point 6

Positional encoding has shape:

$$
(sequence\ length,d_{model})
$$

---

### Point 7

For batch input:

```text
Input:
(batch, seq_len, d_model)

PE:
(seq_len, d_model)
```

Broadcasting allows addition.

---

### Point 8

Sinusoidal positional encoding is fixed and does not contain trainable parameters.

---

# 38. Interview Questions

## Q1. Why is positional encoding needed?

Because self-attention does not inherently know the order of tokens.

---

## Q2. What is added to token embeddings?

Positional information.

In the original Transformer:

$$
Embedding + Sinusoidal\ Positional\ Encoding
$$

---

## Q3. What functions are used in sinusoidal positional encoding?

```text
Sine
Cosine
```

---

## Q4. Which dimensions use sine?

Even dimensions.

---

## Q5. Which dimensions use cosine?

Odd dimensions.

---

## Q6. Is sinusoidal positional encoding trainable?

No.

It is calculated using a fixed mathematical formula.

---

## Q7. What is the shape of positional encoding?

For a sequence:

$$
(seq\_len,d_{model})
$$

---

## Q8. What is the difference between token embedding and positional encoding?

Token embedding represents:

```text
What the token means
```

Positional encoding represents:

```text
Where the token occurs
```

---

## Q9. Can Transformers work without sinusoidal positional encoding?

Yes, if another suitable positional mechanism is used.

For example:

```text
Learned positional embeddings
RoPE
Relative positional methods
```

---

## Q10. Do modern LLMs necessarily use the original sinusoidal encoding?

No.

Many modern LLMs use alternative positional mechanisms such as RoPE.

---

# 39. Mental Model

Remember positional encoding as:

```text
Token
  ↓
"What am I?"
  ↓
Token Embedding

Position
  ↓
"Where am I?"
  ↓
Positional Encoding

        ↓

Embedding + Position
        ↓
Transformer
```

The core equation:

$$
\boxed{
Transformer\ Input
=
Token\ Embedding
+
Positional\ Encoding
}
$$

---

# 40. Complete Flow

```text
"I love machine learning"
          ↓
      Tokenization
          ↓
   [12, 45, 78, 91]
          ↓
   Token Embeddings
          ↓
   Position Information
          ↓
Embedding + Position
          ↓
   Transformer Block
          ↓
   Self-Attention
          ↓
Feed-Forward Network
          ↓
      Output
```

---

# 41. What We Learn Next

Now we have covered:

```text
01-why-rnn-lstm-were-not-enough.md
02-transformer-overview.md
03-positional-encoding.md  ← Current
```

Next:

```text
04-multi-head-attention.md
```

We will learn:

* Why one attention head is not enough
* Multi-head attention intuition
* Multiple representation subspaces
* Q, K, V for each head
* Head dimensions
* Splitting embeddings into heads
* Concatenating heads
* Output projection
* Complete mathematical formula
* Tensor shapes
* NumPy implementation from scratch
* PyTorch implementation
* Practical development example
* GATE questions
* Interview questions

```
```
