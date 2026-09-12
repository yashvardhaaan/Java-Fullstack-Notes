### `02-transformer-overview.md`

````markdown
# Transformer Overview

## 1. Introduction

The Transformer is a neural network architecture designed primarily for sequence-to-sequence tasks such as:

- Machine Translation
- Text Generation
- Text Summarization
- Question Answering
- Text Classification
- Large Language Models (LLMs)

The Transformer was introduced in the 2017 research paper:

> "Attention Is All You Need"

The key idea is:

$$
\boxed{\text{Use Attention instead of Recurrence}}
$$

Unlike RNNs and LSTMs, the Transformer does not need to process tokens one by one.

---

# 2. Big Picture

A simplified Transformer looks like:

```text
Input Text
    ↓
Tokenization
    ↓
Token Embeddings
    ↓
Positional Information
    ↓
┌───────────────────────┐
│      ENCODER          │
│                       │
│ Self-Attention        │
│       ↓               │
│ Feed-Forward Network  │
│       ↓               │
│ Add & Normalize       │
└───────────┬───────────┘
            ↓
      Encoder Output
            ↓
┌───────────────────────┐
│      DECODER          │
│                       │
│ Masked Self-Attention │
│       ↓               │
│ Cross-Attention       │
│       ↓               │
│ Feed-Forward Network  │
└───────────┬───────────┘
            ↓
       Linear Layer
            ↓
          Softmax
            ↓
       Output Token
````

The original Transformer contains:

```text
Encoder + Decoder
```

---

# 3. Original Transformer Architecture

The original Transformer has:

```text
             ENCODER
        ┌───────────────┐
Input → │ Encoder Block │
        ├───────────────┤
        │ Encoder Block │
        ├───────────────┤
        │ Encoder Block │
        ├───────────────┤
        │     ...       │
        └───────┬───────┘
                │
                ▼
             DECODER
        ┌───────────────┐
        │ Decoder Block │
        ├───────────────┤
        │ Decoder Block │
        ├───────────────┤
        │ Decoder Block │
        ├───────────────┤
        │     ...       │
        └───────┬───────┘
                │
                ▼
          Output Tokens
```

The original paper used:

```text
Number of encoder layers = 6
Number of decoder layers = 6
```

---

# 4. Encoder

The encoder's job is to understand the input sequence.

For example:

```text
Input:

"I love machine learning"
```

The encoder converts it into contextual representations.

Conceptually:

```text
"I"       → contextual representation
"love"    → contextual representation
"machine" → contextual representation
"learning"→ contextual representation
```

The encoder does not directly generate the final translated sentence.

It produces representations that the decoder can use.

---

# 5. Decoder

The decoder generates the output sequence.

For example:

```text
Input:

"I love machine learning"

        ↓

Encoder

        ↓

Decoder

        ↓

"J'aime l'apprentissage automatique"
```

The decoder generates output tokens one at a time during inference.

Conceptually:

```text
<BOS>
  ↓
J'aime
  ↓
l'apprentissage
  ↓
automatique
  ↓
<EOS>
```

Where:

```text
<BOS> = Beginning Of Sequence
<EOS> = End Of Sequence
```

---

# 6. Encoder Block

A Transformer encoder block contains two major sublayers:

```text
Input
  ↓
Multi-Head Self-Attention
  ↓
Add & Norm
  ↓
Feed-Forward Network
  ↓
Add & Norm
  ↓
Output
```

More accurately:

```text
                 Input
                   │
                   ▼
          Multi-Head Attention
                   │
                   ▼
             Add + Norm
                   │
                   ▼
        Feed-Forward Network
                   │
                   ▼
             Add + Norm
                   │
                   ▼
                 Output
```

These components will be studied separately.

---

# 7. Decoder Block

A Transformer decoder block contains three major sublayers:

```text
Input
  ↓
Masked Multi-Head Self-Attention
  ↓
Add & Norm
  ↓
Cross-Attention
  ↓
Add & Norm
  ↓
Feed-Forward Network
  ↓
Add & Norm
  ↓
Output
```

The important difference is:

```text
Encoder:
Self-Attention
+
Feed-Forward

Decoder:
Masked Self-Attention
+
Cross-Attention
+
Feed-Forward
```

---

# 8. Why Does the Decoder Need Masked Attention?

Suppose the decoder is generating:

```text
"I love machine learning"
```

When predicting:

```text
machine
```

the decoder should not see:

```text
learning
```

because that would reveal the future.

Therefore, future tokens are masked.

Conceptually:

```text
I       ✓
love    ✓
machine ✓
learning ✗
```

This is called:

# Causal Masking

or

# Look-Ahead Masking

It ensures that the model only uses information that would actually be available during generation.

---

# 9. Cross-Attention

The decoder also needs information from the encoder.

Suppose:

```text
English:

"I love cats"
```

The encoder processes the English sentence.

The decoder generates:

```text
"J'aime les chats"
```

During generation, the decoder can attend to the encoder output.

Conceptually:

```text
             Encoder
                │
                │
                ▼
        Encoder Representations
                │
                │
                ▼
Decoder → Cross-Attention
                │
                ▼
          Output Token
```

Cross-attention allows the decoder to ask:

> Which parts of the input are relevant for generating the current output?

---

# 10. Self-Attention vs Cross-Attention

This distinction is extremely important.

## Self-Attention

Queries, keys and values come from the same sequence.

```text
X → Q
X → K
X → V
```

Therefore:

$$
Q = XW_Q
$$

$$
K = XW_K
$$

$$
V = XW_V
$$

---

## Cross-Attention

Queries come from the decoder.

Keys and values come from the encoder.

```text
Decoder → Q

Encoder → K
Encoder → V
```

Therefore:

$$
Q = X_{decoder}W_Q
$$

$$
K = X_{encoder}W_K
$$

$$
V = X_{encoder}W_V
$$

Then:

$$
Attention(Q,K,V)
=
softmax
\left(
\frac{QK^T}{\sqrt{d_k}}
\right)V
$$

---

# 11. Token Embeddings

Transformers cannot directly understand words as strings.

For example:

```text
"I love cats"
```

must first be converted into numerical representations.

This happens through embeddings.

Conceptually:

```text
"I"       → [0.21, -0.34, 0.87, ...]
"love"    → [0.51,  0.12, 0.42, ...]
"cats"    → [0.73, -0.15, 0.63, ...]
```

Suppose:

```text
Vocabulary size = 30,000
Embedding dimension = 512
```

The embedding matrix has shape:

$$
30000 \times 512
$$

---

# 12. Positional Information

Attention itself does not inherently know the order of tokens.

Consider:

```text
Dog bites man
```

and:

```text
Man bites dog
```

The words are almost the same, but the meaning is different.

Therefore, the model needs information about position.

Transformers add positional information to token embeddings.

Conceptually:

```text
Token Embedding
       +
Positional Encoding
       ↓
Transformer Input
```

For example:

```text
Token       Position
"I"            0
"love"         1
"cats"         2
```

Positional encoding will be covered in detail in:

```text
03-positional-encoding.md
```

---

# 13. Transformer Input

The encoder receives:

$$
X = TokenEmbedding + PositionalEncoding
$$

For example:

```text
Token Embedding
      +
Position Information
      ↓
Transformer Input
```

If:

```text
Sequence length = 5
d_model = 512
```

then:

```text
Input shape:

(5, 512)
```

For a batch:

```text
Batch size = 32

Input shape:

(32, 5, 512)
```

---

# 14. Multi-Head Attention

Instead of using a single attention mechanism, Transformers use:

# Multi-Head Attention

For example:

```text
Input
  ↓
┌──────────────────────────┐
│      Multi-Head          │
│       Attention          │
│                          │
│ Head 1                   │
│ Head 2                   │
│ Head 3                   │
│ ...                      │
│ Head 8                   │
└────────────┬─────────────┘
             ↓
         Concatenate
             ↓
        Output Projection
```

Multiple heads allow the model to learn different relationships between tokens.

For example, different heads may learn to focus on different types of relationships.

Important:

> It is not guaranteed that one specific head represents syntax and another represents semantics. The model learns whatever relationships are useful during training.

---

# 15. Feed-Forward Network

After attention, each token representation passes through a Feed-Forward Network.

Conceptually:

```text
Attention Output
       ↓
Linear Layer
       ↓
Activation
       ↓
Linear Layer
       ↓
Output
```

Mathematically:

$$
FFN(x)
=
W_2 \sigma(W_1x+b_1)+b_2
$$

In the original Transformer:

```text
d_model = 512
d_ff = 2048
```

So:

```text
512
 ↓
2048
 ↓
512
```

The feed-forward network is applied independently to each token position.

---

# 16. Residual Connections

Transformers use residual connections around sublayers.

Instead of:

```text
Input
 ↓
Attention
 ↓
Output
```

we use:

```text
Input ────────────────┐
  ↓                   │
Attention             │
  ↓                   │
  └──────── + ←───────┘
            ↓
          Output
```

Mathematically:

$$
Output = x + Sublayer(x)
$$

Residual connections help information and gradients flow through deep networks.

---

# 17. Layer Normalization

After/between Transformer sublayers, normalization is used.

Simplified structure:

```text
Input
  ↓
Sublayer
  ↓
Add Residual
  ↓
Layer Normalization
```

Layer normalization helps stabilize training.

The exact placement varies by Transformer architecture.

The original Transformer used:

```text
Sublayer
 ↓
Residual
 ↓
LayerNorm
```

Modern architectures often use:

```text
LayerNorm
 ↓
Sublayer
 ↓
Residual
```

This is commonly called:

```text
Post-Norm  → Original Transformer style

Pre-Norm   → Common in modern Transformers
```

---

# 18. Complete Encoder Block

Putting everything together:

```text
                    Input
                      │
                      ▼
             Multi-Head Attention
                      │
                      ▼
                Add Residual
                      │
                      ▼
                Layer Norm
                      │
                      ▼
             Feed-Forward Network
                      │
                      ▼
                Add Residual
                      │
                      ▼
                Layer Norm
                      │
                      ▼
                    Output
```

This entire structure is one:

# Transformer Encoder Block

Multiple blocks are stacked.

---

# 19. Stacking Encoder Blocks

Suppose we have 6 encoder layers.

```text
Input
  ↓
Encoder Layer 1
  ↓
Encoder Layer 2
  ↓
Encoder Layer 3
  ↓
Encoder Layer 4
  ↓
Encoder Layer 5
  ↓
Encoder Layer 6
  ↓
Encoder Output
```

The output of one encoder layer becomes the input of the next.

---

# 20. Complete Decoder Block

A decoder block is:

```text
                 Decoder Input
                       │
                       ▼
             Masked Self-Attention
                       │
                       ▼
                 Add + Norm
                       │
                       ▼
               Cross-Attention
                       ↑
                       │
                Encoder Output
                       │
                       ▼
                 Add + Norm
                       │
                       ▼
              Feed-Forward Network
                       │
                       ▼
                 Add + Norm
                       │
                       ▼
                  Output
```

---

# 21. Final Output Layer

The decoder produces a vector for every output position.

Suppose:

```text
d_model = 512
Vocabulary size = 30,000
```

The final linear layer maps:

```text
512 → 30,000
```

Mathematically:

$$
logits = hW + b
$$

where:

```text
h = decoder representation
```

Then Softmax converts logits into probabilities:

$$
P(token_i)
=
\frac{e^{z_i}}
{\sum_j e^{z_j}}
$$

Example:

```text
Output probabilities:

"cat"      → 0.05
"dog"      → 0.02
"machine"  → 0.01
"learning" → 0.80
"the"      → 0.12
```

The token with the highest probability may be selected.

---

# 22. End-to-End Example

Suppose we want:

```text
English → French
```

Input:

```text
"I love cats"
```

### Step 1: Tokenization

```text
"I" "love" "cats"
```

Depending on the tokenizer, these may be split into subword tokens.

---

### Step 2: Embedding

```text
"I"       → vector
"love"    → vector
"cats"    → vector
```

---

### Step 3: Positional Information

```text
Embedding + Position
```

---

### Step 4: Encoder

```text
Input
 ↓
Self-Attention
 ↓
Feed-Forward
 ↓
Self-Attention
 ↓
Feed-Forward
 ↓
...
 ↓
Encoder Output
```

---

### Step 5: Decoder

The decoder starts with:

```text
<BOS>
```

It predicts:

```text
J'aime
```

Then:

```text
<BOS> J'aime
```

predicts:

```text
les
```

Then:

```text
<BOS> J'aime les
```

predicts:

```text
chats
```

Finally:

```text
<EOS>
```

---

# 23. Training vs Inference

This distinction is very important.

## During Training

The target sequence is available.

Example:

```text
Input:
I love cats

Target:
J'aime les chats
```

The decoder can be trained using the known target sequence, while a causal mask prevents each position from seeing future target tokens.

This is commonly called:

# Teacher Forcing

---

## During Inference

The correct target sequence is not available.

The model generates tokens step by step:

```text
<BOS>
  ↓
J'aime
  ↓
les
  ↓
chats
  ↓
<EOS>
```

So inference is autoregressive.

---

# 24. Teacher Forcing Example

Suppose target is:

```text
J'aime les chats
```

During training:

```text
Decoder Input:

<BOS> J'aime les

Expected Output:

J'aime les chats
```

The model learns:

```text
<BOS>        → J'aime
<BOS> J'aime → les
<BOS> J'aime les → chats
```

The causal mask ensures:

```text
Position 1 cannot see Position 2
Position 2 cannot see Position 3
```

---

# 25. Practical PyTorch Example

PyTorch provides Transformer components.

```python
import torch
import torch.nn as nn

batch_size = 2
seq_len = 10
d_model = 512
num_heads = 8
num_layers = 6

encoder_layer = nn.TransformerEncoderLayer(
    d_model=d_model,
    nhead=num_heads,
    batch_first=True
)

encoder = nn.TransformerEncoder(
    encoder_layer,
    num_layers=num_layers
)

x = torch.randn(
    batch_size,
    seq_len,
    d_model
)

output = encoder(x)

print("Input shape:", x.shape)
print("Output shape:", output.shape)
```

Output:

```text
Input shape:  torch.Size([2, 10, 512])
Output shape: torch.Size([2, 10, 512])
```

The sequence length and model dimension remain the same.

---

# 26. Building a Simple Transformer Model

A simplified encoder-based model can be written as:

```python
import torch
import torch.nn as nn


class SimpleTransformer(nn.Module):

    def __init__(
        self,
        vocab_size,
        d_model=128,
        num_heads=4,
        num_layers=2
    ):
        super().__init__()

        self.embedding = nn.Embedding(
            vocab_size,
            d_model
        )

        encoder_layer = nn.TransformerEncoderLayer(
            d_model=d_model,
            nhead=num_heads,
            batch_first=True
        )

        self.encoder = nn.TransformerEncoder(
            encoder_layer,
            num_layers=num_layers
        )

        self.output = nn.Linear(
            d_model,
            vocab_size
        )

    def forward(self, x):

        # Token embeddings
        x = self.embedding(x)

        # Transformer encoder
        x = self.encoder(x)

        # Vocabulary prediction
        x = self.output(x)

        return x
```

---

# 27. Testing the Model

```python
vocab_size = 10000

model = SimpleTransformer(
    vocab_size=vocab_size,
    d_model=128,
    num_heads=4,
    num_layers=2
)

tokens = torch.randint(
    0,
    vocab_size,
    (2, 10)
)

logits = model(tokens)

print("Input:", tokens.shape)
print("Logits:", logits.shape)
```

Expected:

```text
Input:
[2, 10]

Logits:
[2, 10, 10000]
```

Interpretation:

```text
2      → batch size
10     → sequence length
10000  → vocabulary size
```

For every token position, the model predicts a probability distribution over the vocabulary.

---

# 28. Development Mental Model

When developing a Transformer model, think of the data flow as:

```text
Token IDs
   ↓
Embedding
   ↓
Position Information
   ↓
Transformer Layers
   ↓
Contextual Representations
   ↓
Linear Layer
   ↓
Logits
   ↓
Softmax
   ↓
Token Probabilities
```

For an LLM:

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
 ↓
Embeddings
 ↓
Positional Information
 ↓
Transformer Blocks
 ↓
Logits
 ↓
Next Token
```

---

# 29. Encoder vs Decoder

| Component             | Encoder                                  | Decoder         |
| --------------------- | ---------------------------------------- | --------------- |
| Self-Attention        | Yes                                      | Yes             |
| Masked Self-Attention | No                                       | Yes             |
| Cross-Attention       | Original encoder-decoder Transformer: No | Yes             |
| Feed-Forward          | Yes                                      | Yes             |
| Residual Connections  | Yes                                      | Yes             |
| Layer Normalization   | Yes                                      | Yes             |
| Main purpose          | Understand input                         | Generate output |

---

# 30. Original Transformer Hyperparameters

The original Transformer base model used approximately:

```text
N = 6 encoder layers
N = 6 decoder layers

d_model = 512

d_ff = 2048

number of attention heads = 8

d_k = 64

d_v = 64
```

Because:

$$
d_k = \frac{d_{model}}{h}
$$

Therefore:

$$
d_k = \frac{512}{8}
= 64
$$

---

# 31. Important Dimensions

Suppose:

```text
batch = 32
sequence length = 100
d_model = 512
heads = 8
```

Input:

$$
(32,100,512)
$$

Head dimension:

$$
d_{head} = \frac{512}{8}=64
$$

After splitting into heads:

```text
(32, 8, 100, 64)
```

Attention score matrix:

```text
(32, 8, 100, 100)
```

After attention:

```text
(32, 8, 100, 64)
```

Concatenate heads:

```text
(32, 100, 512)
```

Output projection:

```text
(32, 100, 512)
```

Understanding these shapes is extremely important for implementing Transformers.

---

# 32. Why Multiple Encoder/Decoder Layers?

One Transformer block can learn useful relationships.

Stacking many blocks allows the model to build increasingly complex representations.

Conceptually:

```text
Layer 1
 ↓
Basic relationships

Layer 2
 ↓
More contextual relationships

Layer 3
 ↓
Higher-level patterns

...

Layer N
 ↓
Rich contextual representation
```

The exact patterns learned by each layer are learned from data and are not fixed.

---

# 33. Transformer vs RNN

| Property               | RNN/LSTM                                             | Transformer                       |
| ---------------------- | ---------------------------------------------------- | --------------------------------- |
| Recurrence             | Yes                                                  | No core recurrence                |
| Token processing       | Sequential                                           | Highly parallel during training   |
| Long-range interaction | Through recurrent states                             | Direct through attention          |
| Parallel training      | Limited                                              | Excellent                         |
| Attention              | Optional                                             | Core mechanism                    |
| Sequence complexity    | Roughly linear in sequence length per recurrent step | Quadratic for full self-attention |
| GPU utilization        | More limited                                         | Very high                         |
| Modern LLM foundation  | Rare                                                 | Dominant                          |

---

# 34. GATE Important Points

### 1. Transformer was introduced in 2017

Paper:

```text
Attention Is All You Need
```

---

### 2. Original Transformer has

```text
Encoder + Decoder
```

---

### 3. Encoder uses

```text
Multi-Head Self-Attention
+
Feed-Forward Network
```

---

### 4. Decoder uses

```text
Masked Self-Attention
+
Cross-Attention
+
Feed-Forward Network
```

---

### 5. Attention allows direct token interaction.

---

### 6. Positional information is required because attention itself does not inherently encode sequence order.

---

### 7. Full self-attention has quadratic complexity with sequence length.

$$
O(n^2)
$$

---

### 8. Original Transformer Base

```text
d_model = 512
heads = 8
d_ff = 2048
encoder layers = 6
decoder layers = 6
```

---

### 9. Head dimension

$$
d_k = \frac{d_{model}}{h}
$$

For the original Base model:

$$
d_k = 512/8 = 64
$$

---

# 35. Interview Questions

## Q1. What is a Transformer?

A Transformer is a neural network architecture based primarily on attention mechanisms rather than recurrent computation.

---

## Q2. What are the two main components of the original Transformer?

```text
Encoder
Decoder
```

---

## Q3. What does the encoder do?

It converts the input sequence into contextual representations.

---

## Q4. What does the decoder do?

It generates the output sequence autoregressively.

---

## Q5. Why does the decoder use masking?

To prevent a token from attending to future output tokens during autoregressive generation.

---

## Q6. What is cross-attention?

Cross-attention allows decoder queries to attend to encoder keys and values.

```text
Q → Decoder

K,V → Encoder
```

---

## Q7. Why is positional encoding required?

Because self-attention alone does not inherently represent the order of tokens.

---

## Q8. What is the role of the feed-forward network?

It applies a nonlinear transformation independently to each token representation after attention.

---

## Q9. Why are residual connections used?

They help information and gradients flow through deep Transformer networks.

---

## Q10. Why is Transformer training highly parallelizable?

Because the encoder's self-attention can process all input positions together instead of requiring recurrent sequential computation.

---

# 36. Complete Mental Model

Remember the Transformer like this:

```text
                  TEXT
                   ↓
               Tokenizer
                   ↓
               Token IDs
                   ↓
               Embeddings
                   ↓
          Positional Information
                   ↓
          ┌─────────────────┐
          │    ENCODER      │
          │                 │
          │ Self-Attention  │
          │      ↓          │
          │ FFN             │
          │      ↓          │
          │ Add + Norm      │
          └────────┬────────┘
                   ↓
            Encoder Output
                   ↓
          ┌─────────────────┐
          │    DECODER      │
          │                 │
          │ Masked Attention│
          │      ↓          │
          │ Cross-Attention │
          │      ↓          │
          │ FFN             │
          │      ↓          │
          │ Add + Norm      │
          └────────┬────────┘
                   ↓
              Linear Layer
                   ↓
                 Logits
                   ↓
                Softmax
                   ↓
             Output Token
```

The entire Transformer can therefore be remembered as:

$$
\boxed{
Embedding
\rightarrow
Position
\rightarrow
Attention
\rightarrow
FFN
\rightarrow
Output
}
$$

For the original encoder-decoder Transformer:

$$
\boxed{
Encoder
\rightarrow
Decoder
\rightarrow
Output
}
$$

---

# 37. What We Learn Next

Now we understand the complete Transformer at a high level.

Next:

```text
03-positional-encoding.md
```

We will learn:

* Why position is necessary
* Why attention loses order information
* Sinusoidal positional encoding
* The mathematical formula
* Why sine and cosine are used
* Positional encoding dimensions
* Practical NumPy implementation
* PyTorch implementation
* Visualizing positional encodings
* GATE questions
* Interview questions

```
```
