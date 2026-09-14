### `11-QUICK-REVISION/02-transformer-cheat-sheet.md`

````md
# Transformer Cheat Sheet

## 1. What is a Transformer?

A **Transformer** is a neural network architecture based mainly on **attention mechanisms**, designed to process sequences efficiently.

Introduced in the paper:

> **"Attention Is All You Need" (2017)**

Core idea:

```text
Input
 ↓
Embedding
 ↓
Positional Information
 ↓
Attention
 ↓
Feed-Forward Network
 ↓
Residual + Layer Normalization
 ↓
Repeated Transformer Blocks
 ↓
Output
````

---

## 2. Why Transformers?

RNN/LSTM limitations:

```text
RNN/LSTM
 ↓
Sequential processing
 ↓
Slow training
 ↓
Difficulty with long-range dependencies
```

Transformer:

```text
Transformer
 ↓
Attention
 ↓
Parallel processing during training
 ↓
Better long-range dependency handling
```

---

## 3. Transformer Architecture

Original Transformer:

```text
                Input
                  ↓
             Encoder
                  ↓
             Decoder
                  ↓
               Output
```

```text
┌─────────────────────────┐
│        Encoder          │
│                         │
│ Self-Attention          │
│      ↓                  │
│ Feed-Forward            │
│      ↓                  │
│ Add & Norm              │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│        Decoder          │
│                         │
│ Masked Self-Attention   │
│      ↓                  │
│ Cross-Attention         │
│      ↓                  │
│ Feed-Forward            │
│      ↓                  │
│ Add & Norm              │
└─────────────────────────┘
```

---

## 4. Transformer Variants

### Encoder-only

```text
Input → Encoder → Representation
```

Examples:

```text
BERT
```

Good for:

* Classification
* Understanding
* Embeddings
* Sentence representation

---

### Decoder-only

```text
Input → Decoder → Next Token
```

Examples:

```text
GPT-style models
```

Good for:

* Text generation
* Chat
* Code generation
* Autoregressive language modeling

---

### Encoder-Decoder

```text
Input
 ↓
Encoder
 ↓
Decoder
 ↓
Output
```

Examples:

```text
T5
Original Transformer
```

Good for:

* Translation
* Summarization
* Sequence-to-sequence tasks

---

## 5. Token Embeddings

Tokens are converted into vectors.

```text
"cat"
 ↓
Tokenizer
 ↓
Token ID
 ↓
Embedding
 ↓
[0.21, -0.13, 0.72, ...]
```

The model operates on numerical vectors, not raw words.

---

## 6. Positional Encoding

Self-attention does not inherently encode token order.

Therefore positional information is added.

```text
Token Embedding
       +
Positional Encoding
       ↓
Transformer Input
```

Example:

```text
"I love Python"

I       → Position 1
love    → Position 2
Python  → Position 3
```

Common approaches:

```text
Sinusoidal positional encoding
Learned positional embeddings
Rotary Position Embeddings (RoPE)
```

---

## 7. Self-Attention

Self-attention allows each token to interact with other tokens in the same sequence.

Example:

```text
"The animal crossed the road because it was tired."
                                          ↑
```

Attention helps determine what `"it"` refers to from the surrounding context.

---

## 8. Query, Key, Value

Each input representation is projected into:

```text
Q = Query
K = Key
V = Value
```

Intuition:

```text
Query → What information am I looking for?

Key   → What information do I contain?

Value → What information should I provide?
```

---

## 9. Attention Formula

Scaled dot-product attention:

```text
Attention(Q,K,V)
=
softmax(QKᵀ / √dₖ)V
```

Steps:

```text
Q × Kᵀ
   ↓
Similarity scores
   ↓
Scale by √dₖ
   ↓
Softmax
   ↓
Attention weights
   ↓
Weighted sum of V
```

---

## 10. Why Divide by √dₖ?

When the key/query dimension becomes large, dot products can become large.

Large values can make softmax extremely sharp.

Scaling by:

```text
√dₖ
```

helps keep the values in a more manageable range and improves training stability.

---

## 11. Attention Example

Suppose:

```text
"The cat drank the milk because it was thirsty."
```

For the token:

```text
"it"
```

attention may assign stronger weights to relevant tokens such as:

```text
cat
thirsty
```

The model combines information from the sequence to create a better representation.

---

## 12. Multi-Head Attention

Instead of performing one attention operation, Transformers use multiple attention heads.

```text
Input
 ↓
┌────────┬────────┬────────┐
│ Head 1 │ Head 2 │ Head 3 │ ...
└────────┴────────┴────────┘
 ↓
Concatenate
 ↓
Linear Projection
```

Different heads can learn different relationships.

Conceptually:

```text
Head 1 → Syntax
Head 2 → Relationships
Head 3 → Long-range dependency
...
```

These interpretations are illustrative; heads are not explicitly assigned these roles.

---

## 13. Feed-Forward Network

Each Transformer block also contains a position-wise feed-forward network.

Typical structure:

```text
x
 ↓
Linear
 ↓
Activation
 ↓
Linear
 ↓
Output
```

Conceptually:

```text
FFN(x) = W₂ σ(W₁x + b₁) + b₂
```

The attention layer mixes information between tokens.

The FFN transforms each token representation independently.

---

## 14. Residual Connection

Residual connections add the input back to the transformed output.

```text
x
 ↓
Transformer Sub-layer
 ↓
F(x)
 ↓
F(x) + x
```

Formula:

```text
Output = x + F(x)
```

Benefits:

* Better gradient flow
* Easier optimization
* Helps train deep networks

---

## 15. Layer Normalization

Layer normalization stabilizes activations.

Conceptually:

```text
Input
 ↓
Sub-layer
 ↓
Residual Connection
 ↓
LayerNorm
```

Transformer implementations commonly use either:

```text
Post-LN
```

or:

```text
Pre-LN
```

Modern deep Transformer architectures often use **Pre-LN-style designs** for training stability.

---

## 16. Encoder Block

A simplified encoder block:

```text
Input
 ↓
Multi-Head Self-Attention
 ↓
Add + LayerNorm
 ↓
Feed-Forward Network
 ↓
Add + LayerNorm
 ↓
Output
```

---

## 17. Decoder Block

A simplified original Transformer decoder block:

```text
Input
 ↓
Masked Multi-Head Self-Attention
 ↓
Add + LayerNorm
 ↓
Cross-Attention
 ↓
Add + LayerNorm
 ↓
Feed-Forward Network
 ↓
Add + LayerNorm
 ↓
Output
```

---

## 18. Masked Self-Attention

Decoder-only autoregressive models must not see future tokens during prediction.

Example:

```text
Tokens:

I     love     Python
```

When predicting `"Python"`:

```text
I       → visible
love    → visible
Python  → target
future  → hidden
```

Conceptually:

```text
[1 0 0]
[1 1 0]
[1 1 1]
```

This is called a **causal mask**.

---

## 19. Cross-Attention

Cross-attention allows the decoder to attend to encoder outputs.

```text
Encoder Output
      ↓
      K,V
      ↓
Decoder Query
      ↓
Cross-Attention
```

Used in encoder-decoder Transformers.

Example:

```text
English sentence
      ↓
Encoder
      ↓
Representation
      ↓
Decoder
      ↓
French translation
```

Decoder-only GPT models generally do **not** use encoder-decoder cross-attention.

---

## 20. Transformer vs RNN

| Transformer                           | RNN                                      |
| ------------------------------------- | ---------------------------------------- |
| Attention-based                       | Recurrent                                |
| Parallelizable during training        | Sequential dependency                    |
| Handles long-range relationships well | Long-range dependencies can be difficult |
| High compute/memory for attention     | Sequential processing                    |
| Foundation of modern LLMs             | Older sequence modeling approach         |

---

## 21. Self-Attention Complexity

For sequence length `n`, standard self-attention has approximately:

```text
O(n²)
```

attention-score complexity.

Why?

```text
Q × Kᵀ
```

creates an `n × n` attention matrix.

Example:

```text
1,000 tokens
→ 1,000 × 1,000 attention relationships
```

This is one reason long-context Transformers can be computationally expensive.

---

## 22. Transformer Training

For a GPT-style model:

```text
Training Text
 ↓
Tokenization
 ↓
Input Tokens
 ↓
Transformer
 ↓
Logits
 ↓
Next-Token Prediction
 ↓
Cross-Entropy Loss
 ↓
Backpropagation
 ↓
Parameter Update
```

Repeat over many batches.

---

## 23. Transformer Inference

During generation:

```text
Prompt
 ↓
Tokenizer
 ↓
Transformer
 ↓
Logits
 ↓
Softmax / Sampling
 ↓
Next Token
 ↓
Append Token
 ↓
Transformer
 ↓
Next Token
 ↓
...
```

For autoregressive generation, the model repeatedly predicts the next token.

---

## 24. KV Cache

During autoregressive inference, previous attention keys and values can be cached.

```text
Previous tokens
      ↓
K,V stored in cache
      ↓
New token
      ↓
Compute attention using cached K,V
```

This avoids recomputing the same K/V representations for previous tokens at every generation step.

Result:

```text
Lower generation computation
        ↓
Faster inference
```

KV cache consumes memory, so long contexts can require substantial GPU memory.

---

## 25. Transformer Block Mental Model

Remember:

```text
Input
  ↓
Attention
  ↓
"Which other tokens are important?"
  ↓
Feed-Forward
  ↓
"Transform this representation"
  ↓
Residual + Normalization
  ↓
Output
```

---

## 26. Important Dimensions

Suppose:

```text
Sequence length = 512
Model dimension d_model = 768
Number of heads = 12
```

Then:

```text
Head dimension:

d_head = d_model / number_of_heads

         = 768 / 12

         = 64
```

For standard multi-head attention, each head works with its own projected subspace of dimension `d_head`.

---

## 27. Complete GPT-Style Architecture

```text
                Input Text
                    ↓
                Tokenizer
                    ↓
              Token Embeddings
                    +
             Positional Method
                    ↓
          ┌───────────────────┐
          │ Transformer Block │
          │                   │
          │ Causal Attention  │
          │       ↓           │
          │ FFN               │
          │       ↓           │
          │ Residual + Norm   │
          └─────────┬─────────┘
                    ↓
               Repeat N times
                    ↓
                Final Norm
                    ↓
               Linear Head
                    ↓
                  Logits
                    ↓
                Softmax
                    ↓
               Next Token
```

---

## 28. Most Important Formulas

### Attention

```text
Attention(Q,K,V)
=
softmax(QKᵀ / √dₖ)V
```

### Head Dimension

```text
d_head = d_model / h
```

where:

```text
h = number of attention heads
```

### FFN

```text
FFN(x) = W₂ σ(W₁x + b₁) + b₂
```

### Residual

```text
Output = x + F(x)
```

### Attention Complexity

```text
O(n²)
```

with respect to sequence length for standard self-attention.

---

## 29. Common Interview Questions

### Why is attention scaled?

> To prevent large dot products from making the softmax distribution excessively sharp and difficult to train.

### Why multiple attention heads?

> To allow the model to learn different relationships/subspaces between tokens simultaneously.

### Why positional encoding?

> Self-attention alone does not inherently represent token order, so positional information is added.

### Why residual connections?

> They improve gradient flow and make deep networks easier to optimize.

### Why LayerNorm?

> It stabilizes activations and improves training.

### Why causal masking in GPT?

> To prevent the model from using future tokens when predicting the current next token.

### What is cross-attention?

> Attention where queries come from one sequence/component and keys/values come from another, commonly used between decoder and encoder outputs.

### Why is self-attention O(n²)?

> Because attention computes interactions between pairs of positions, producing an n × n attention matrix.

### What is KV cache?

> A cache of previously computed attention keys and values used to speed up autoregressive generation.

---

## 30. Quick Comparison

| Component              | Purpose                                     |
| ---------------------- | ------------------------------------------- |
| Embedding              | Token → vector                              |
| Positional information | Represents token order/position             |
| Self-Attention         | Mixes information across tokens             |
| Multi-Head Attention   | Multiple attention projections              |
| Causal Mask            | Prevents access to future tokens            |
| Cross-Attention        | Connects decoder to encoder representations |
| FFN                    | Transforms token representations            |
| Residual               | Improves information/gradient flow          |
| LayerNorm              | Stabilizes activations                      |
| KV Cache               | Speeds autoregressive inference             |
| Linear Head            | Hidden state → logits                       |
| Softmax                | Logits → probabilities                      |

---

## 31. One-Line Revision

> **Transformer = Embeddings + Positional Information + Attention + FFN + Residual Connections + Normalization, stacked into layers to model relationships between tokens efficiently.**

```
```
