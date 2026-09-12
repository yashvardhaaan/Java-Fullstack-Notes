### `06-residual-connections.md`

````markdown
# Residual Connections

## 1. What is a Residual Connection?

A residual connection, or skip connection, adds the original input of a layer to its output.

Instead of:

Input → Layer → Output

we use:

Input ───────────────┐
  ↓                  │
Layer                │
  ↓                  │
  └─────── + ←───────┘
           ↓
         Output

Formula:

Output = x + F(x)

Where:

- x = original input
- F(x) = output of the layer

---

## 2. Why Does Transformer Use It?

Transformers contain many layers.

For example:

```text
Input
 ↓
Transformer Block 1
 ↓
Transformer Block 2
 ↓
Transformer Block 3
 ↓
...
 ↓
Transformer Block 32
````

As networks become deeper, training becomes difficult.

Residual connections provide a direct path for information and gradients to flow through the network.

---

## 3. Residual Connection in Transformer

A Transformer applies residual connections around major sublayers.

For example:

```text
Input
  ↓
Multi-Head Attention
  ↓
  + ←──────── Input
  ↓
LayerNorm
  ↓
Output
```

Then:

```text
Attention Output
      ↓
     FFN
      ↓
      + ←──── Attention Block Input
      ↓
  LayerNorm
```

So conceptually:

```text
x → Attention → + → Norm
│                ↑
└────────────────┘
```

and:

```text
x → FFN → + → Norm
│          ↑
└──────────┘
```

---

## 4. Simple Intuition

Imagine a student already knows something.

Instead of forcing a new layer to completely recreate the information, the layer only needs to learn the useful change.

Instead of learning:

```text
Output = F(x)
```

the network learns:

```text
Output = x + F(x)
```

So:

```text
Original information
       +
New information
       ↓
Improved representation
```

---

## 5. Why Is It Useful?

Residual connections mainly help with:

* Training deep neural networks
* Gradient flow
* Preventing degradation as depth increases
* Preserving useful information

The key idea:

> A layer can learn a modification to the existing representation instead of having to rebuild the entire representation.

---

## 6. Gradient Intuition

Without a residual connection:

```text
x
 ↓
Layer 1
 ↓
Layer 2
 ↓
Layer 3
 ↓
...
```

The gradient must pass through every layer.

With residual connections:

```text
x ──────────────────────────────┐
 ↓                             │
Layer                          │
 ↓                             │
 └────────────── + ←───────────┘
```

There is a direct path from later layers back toward earlier layers.

This helps gradients propagate through deep networks.

---

## 7. Where Is It Used in Industry?

Residual connections are fundamental to modern deep learning.

They are used in:

```text
Transformers
BERT
GPT-style LLMs
LLaMA
Vision Transformers
ResNet
```

They are especially important when models contain many stacked layers.

For example:

```text
GPT-style LLM
      ↓
Many Transformer Blocks
      ↓
Each block uses residual connections
```

---

## 8. Practical PyTorch Example

A simple residual block:

```python
import torch
import torch.nn as nn

class ResidualBlock(nn.Module):

    def __init__(self, d_model):
        super().__init__()

        self.layer = nn.Linear(
            d_model,
            d_model
        )

    def forward(self, x):

        return x + self.layer(x)


x = torch.randn(2, 10, 128)

model = ResidualBlock(128)

output = model(x)

print(output.shape)
```

Output:

```text
torch.Size([2, 10, 128])
```

The input and output dimensions must be compatible for direct addition.

---

## 9. Residual Connection with Attention

Conceptually:

```python
attention_output = attention(x)

output = x + attention_output
```

Then normalization:

```python
output = layer_norm(output)
```

So:

```python
x = layer_norm(
    x + attention(x)
)
```

This is the basic idea behind a Transformer sublayer.

---

## 10. Residual Connection with FFN

Similarly:

```python
ffn_output = ffn(x)

output = x + ffn_output
```

Then:

```python
output = layer_norm(output)
```

Conceptually:

```python
x = layer_norm(
    x + ffn(x)
)
```

---

## 11. Post-Norm vs Pre-Norm

There are two common arrangements.

### Original Transformer — Post-Norm

```text
x
 ↓
Attention
 ↓
Add x
 ↓
LayerNorm
```

Formula:

```text
LayerNorm(x + Attention(x))
```

### Modern Transformers — often Pre-Norm

```text
x
 ↓
LayerNorm
 ↓
Attention
 ↓
Add x
```

Formula:

```text
x + Attention(LayerNorm(x))
```

Modern large Transformers commonly use Pre-Norm because it can make optimization of deep models easier.

---

## 12. Important Dimension Rule

For:

```text
x + F(x)
```

the dimensions must match.

Example:

```text
x        = (batch, seq_len, 512)

F(x)     = (batch, seq_len, 512)
```

Addition is valid:

```text
(2, 10, 512)
+
(2, 10, 512)
=
(2, 10, 512)
```

If:

```text
x        = (2, 10, 512)

F(x)     = (2, 10, 256)
```

direct addition is not possible.

---

## 13. Industry Mental Model

Think of a Transformer block as:

```text
                    Input
                      │
          ┌───────────┴───────────┐
          ↓                       │
     Attention                    │
          ↓                       │
          + ←─────────────────────┘
          ↓
        Norm
          ↓
          ┌───────────┐
          ↓           │
         FFN          │
          ↓           │
          + ←─────────┘
          ↓
        Norm
          ↓
        Output
```

Residual connections are the `+` operations.

---

## 14. GATE / Interview Points

### Remember:

Residual connection:

$$
\boxed{Output=x+F(x)}
$$

Main purpose:

```text
Better gradient flow
+
Preserve information
+
Enable deep networks
```

In Transformers, residual connections are used around:

```text
Multi-Head Attention
Feed-Forward Network
```

Important:

```text
x and F(x) must have compatible dimensions.
```

---

## 15. One-Line Mental Model

> **Residual connections let a Transformer preserve the existing representation while learning useful changes to it.**

---

## Next

```text
07-layer-normalization.md
```

Next we will learn **what Layer Normalization does, why Transformers need it, and how Pre-Norm and Post-Norm differ.**

```
```
