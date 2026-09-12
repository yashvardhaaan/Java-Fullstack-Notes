### `08-transformer-encoder.md`

````md
# Transformer Encoder

## 1. What is a Transformer Encoder?

A Transformer Encoder takes an input sequence and creates a **context-aware representation** of every token.

Example:

> "The bank is near the river."

The encoder understands that **bank** is related to the river, so its representation depends on the surrounding words.

---

## 2. Main Components

A Transformer Encoder layer mainly contains:

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
````

Multiple encoder layers can be stacked together.

---

## 3. Why is Self-Attention Important?

Each token can look at other tokens in the sequence.

Example:

```text
"The animal didn't cross the road because it was tired."
```

Attention helps determine what **"it"** refers to using the surrounding context.

---

## 4. Encoder Example

Input:

```text
"I love machine learning"
```

The encoder converts it into contextual representations:

```text
I       → representation
love    → representation
machine → representation
learning→ representation
```

Each representation contains information from other relevant tokens.

---

## 5. Where is it Used in Industry?

Encoder-based Transformers are especially useful for **understanding text**.

Examples:

* **BERT** → text understanding
* **Sentence Transformers** → semantic search
* **Document classification**
* **Sentiment analysis**
* **Named Entity Recognition (NER)**
* **Semantic similarity**
* **Search engines**
* **RAG systems** → creating embeddings for retrieval

Typical industry flow:

```text
User Query
   ↓
Encoder
   ↓
Embedding
   ↓
Vector Database
   ↓
Relevant Documents
```

---

## 6. Simple PyTorch Example

```python
import torch
import torch.nn as nn

encoder_layer = nn.TransformerEncoderLayer(
    d_model=128,
    nhead=8,
    batch_first=True
)

encoder = nn.TransformerEncoder(
    encoder_layer,
    num_layers=4
)

x = torch.randn(2, 10, 128)

output = encoder(x)

print(output.shape)
```

Output:

```text
torch.Size([2, 10, 128])
```

The shape remains the same, but the representations become **context-aware**.

---

## 7. Encoder vs Decoder

| Encoder                        | Decoder                    |
| ------------------------------ | -------------------------- |
| Understands input              | Generates output           |
| Uses self-attention            | Uses masked self-attention |
| Common in BERT                 | Common in GPT              |
| Good for classification/search | Good for text generation   |

---

## 8. GATE / Interview Points

* Encoder uses **self-attention**.
* Every token can attend to other input tokens.
* Encoder output is **contextual representation**.
* Multiple encoder layers can be stacked.
* `d_model` = embedding/hidden dimension.
* `nhead` = number of attention heads.
* Encoder is commonly used for **understanding**, not autoregressive generation.

---

## Mental Model

> **Transformer Encoder = Convert a sequence into context-aware representations.**

Next: `09-transformer-decoder.md`

```
```
