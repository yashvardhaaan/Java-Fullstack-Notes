### `05-feed-forward-network.md`

````markdown
# Feed-Forward Network (FFN)

## 1. What is FFN?

The Feed-Forward Network is the second major component inside a Transformer block.

Simplified Transformer block:

```text
Input
  ↓
Multi-Head Attention
  ↓
Add & Norm
  ↓
Feed-Forward Network
  ↓
Add & Norm
  ↓
Output
````

FFN processes each token's representation independently.

---

## 2. Why Do We Need FFN?

Attention mainly answers:

> "Which other tokens should I pay attention to?"

FFN then transforms the information obtained from attention.

Think of it as:

```text
Attention
   ↓
Gather relevant information
   ↓
FFN
   ↓
Process / transform that information
```

So both are important:

```text
Attention → Communication between tokens
FFN       → Computation on each token
```

---

## 3. How Does FFN Work?

A basic Transformer FFN has two linear layers with an activation function between them.

```text
Input
  ↓
Linear Layer
  ↓
Activation
  ↓
Linear Layer
  ↓
Output
```

Formula:

$$
FFN(x)=W_2\sigma(W_1x+b_1)+b_2
$$

Where:

* $W_1$ = first weight matrix
* $W_2$ = second weight matrix
* $\sigma$ = activation function

---

## 4. Why Expand the Dimension?

Suppose:

```text
d_model = 512
```

The original Transformer uses:

```text
512 → 2048 → 512
```

So:

```text
Input
  ↓
512 dimensions
  ↓
2048 dimensions
  ↓
512 dimensions
  ↓
Output
```

The larger intermediate dimension gives the network more capacity to perform nonlinear transformations.

---

## 5. FFN Is Position-Wise

This is very important.

Suppose we have:

```text
"I love machine learning"
```

After attention:

```text
Token 1 → vector
Token 2 → vector
Token 3 → vector
Token 4 → vector
```

The same FFN is applied independently to every token:

```text
Token 1 → FFN → Output 1
Token 2 → FFN → Output 2
Token 3 → FFN → Output 3
Token 4 → FFN → Output 4
```

The FFN does NOT directly mix information between tokens.

Attention handles token-to-token communication.

---

## 6. Attention vs FFN

| Component      | Main Job                            |
| -------------- | ----------------------------------- |
| Self-Attention | Mix information between tokens      |
| FFN            | Transform each token representation |

Think:

```text
Attention = Communication
FFN       = Computation
```

This is one of the best ways to remember the Transformer block.

---

## 7. Where Is FFN Used in Industry?

FFNs are present in Transformer-based models such as:

```text
BERT
GPT-style models
T5
LLaMA
Vision Transformers
```

They are used in:

* Chatbots
* Search systems
* Text classification
* Translation
* Summarization
* Code generation
* Document understanding
* LLMs

In modern LLMs, the FFN/MLP component contains a very large portion of the model's parameters.

---

## 8. Practical PyTorch Example

A simple FFN:

```python
import torch
import torch.nn as nn

ffn = nn.Sequential(
    nn.Linear(128, 512),
    nn.GELU(),
    nn.Linear(512, 128)
)

x = torch.randn(2, 10, 128)

output = ffn(x)

print(output.shape)
```

Output:

```text
torch.Size([2, 10, 128])
```

The shape remains:

```text
(batch, sequence_length, d_model)
```

---

## 9. Why GELU/ReLU?

The activation function introduces non-linearity.

Without an activation:

```text
Linear → Linear
```

can effectively be represented as another linear transformation.

The activation makes the network more expressive.

Original Transformer:

```text
ReLU
```

Modern Transformers commonly use:

```text
GELU
SwiGLU
GEGLU
```

depending on the architecture.

---

## 10. FFN in an LLM

A simplified LLM block:

```text
Input
  ↓
Self-Attention
  ↓
Residual + Norm
  ↓
FFN / MLP
  ↓
Residual + Norm
  ↓
Next Transformer Block
```

For a large language model, this block is repeated many times.

Example:

```text
Token Embeddings
      ↓
Transformer Block 1
      ↓
Transformer Block 2
      ↓
Transformer Block 3
      ↓
...
      ↓
Transformer Block N
      ↓
Output
```

Every block contains an FFN/MLP.

---

## 11. Parameter Example

Suppose:

```text
d_model = 512
d_ff = 2048
```

The two main weight matrices are approximately:

```text
W1: 512 × 2048

W2: 2048 × 512
```

Total:

$$
512\times2048 + 2048\times512
$$

$$
=2,097,152
$$

So one FFN contains about:

```text
2.1 million weights
```

ignoring biases.

This is why FFN/MLP layers contribute significantly to Transformer model size.

---

## 12. Practical Development Example

Suppose you're building a text classifier.

After attention:

```text
Sentence
   ↓
Self-Attention
   ↓
Contextual token representations
```

The FFN transforms each representation:

```text
Token 1 → FFN
Token 2 → FFN
Token 3 → FFN
Token 4 → FFN
```

Then the model can use the resulting representations for:

```text
Classification
Generation
Prediction
```

---

## 13. Important Industry Insight

In modern LLMs, the FFN is often called:

```text
MLP
```

or:

```text
Feed-Forward / MLP block
```

Modern architectures may replace the simple FFN with gated variants such as:

```text
SwiGLU
GEGLU
```

These improve the transformation capacity of the block.

---

## 14. GATE / Interview Points

### Remember:

```text
FFN = Linear → Activation → Linear
```

Formula:

$$
FFN(x)=W_2\sigma(W_1x+b_1)+b_2
$$

Important:

```text
Attention → mixes information between tokens

FFN → processes each token independently
```

Original Transformer:

```text
d_model = 512
d_ff = 2048
```

So:

$$
512 \rightarrow 2048 \rightarrow 512
$$

---

## 15. One-Line Mental Model

> **Attention decides what information to gather; FFN transforms that information for each token.**

---

## Next

```text
06-residual-connections.md
```

Next we will learn **why Transformers add the original input back to the output of Attention and FFN, and why this is critical for training deep Transformers.**

```
```
