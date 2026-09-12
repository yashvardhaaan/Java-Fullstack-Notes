### `09-transformer-decoder.md`

````md
# Transformer Decoder

## 1. What is a Transformer Decoder?

A Transformer Decoder is used to **generate output tokens step-by-step**.

Example:

```text
Input:  "What is AI?"
Output: "AI is a field of computer science..."
````

The decoder predicts the next token based on the tokens generated so far.

---

## 2. Main Components

A typical decoder layer contains:

```text
Previous Tokens
      ↓
Masked Self-Attention
      ↓
Add & Norm
      ↓
Cross-Attention (if encoder-decoder model)
      ↓
Add & Norm
      ↓
Feed-Forward Network
      ↓
Add & Norm
```

---

## 3. Why Masked Self-Attention?

The decoder must **not see future tokens**.

Example:

```text
I love machine ___
```

While predicting the next word, it should not see the answer beforehand.

The attention mask makes it possible:

```text
I       → can see I
love    → can see I, love
machine → can see I, love, machine
```

This is called **causal/masked attention**.

---

## 4. Decoder in GPT

GPT-style models are **decoder-only Transformers**.

```text
Input tokens
     ↓
Token Embeddings
     ↓
Transformer Decoder Blocks
     ↓
Linear Layer
     ↓
Softmax
     ↓
Next Token
```

Example:

```text
"The capital of France is"
                    ↓
                  "Paris"
```

The predicted token is added to the sequence and the process continues.

---

## 5. Encoder-Decoder vs Decoder-Only

### Encoder-Decoder

Used when input needs to be transformed into another sequence.

Examples:

* Translation
* Text summarization
* T5
* Original Transformer

```text
Input → Encoder → Decoder → Output
```

### Decoder-Only

Used mainly for text generation.

Examples:

* GPT-style LLMs
* Chatbots
* Code generation

```text
Prompt → Decoder → Generated Text
```

---

## 6. Where Used in Industry?

Decoder Transformers are used for:

* Chatbots
* Code generation
* Text generation
* Autocomplete
* AI assistants
* Content generation
* Reasoning models

For example:

```text
User Prompt
    ↓
LLM Decoder
    ↓
Token prediction
    ↓
Next token
    ↓
Next token
    ↓
Final response
```

---

## 7. Simple PyTorch Example

```python
import torch
import torch.nn as nn

decoder_layer = nn.TransformerDecoderLayer(
    d_model=128,
    nhead=8,
    batch_first=True
)

decoder = nn.TransformerDecoder(
    decoder_layer,
    num_layers=4
)

target = torch.randn(2, 10, 128)
memory = torch.randn(2, 12, 128)

output = decoder(target, memory)

print(output.shape)
```

Output:

```text
torch.Size([2, 10, 128])
```

---

## 8. GATE / Interview Points

* Decoder is mainly responsible for **generation**.
* Uses **masked self-attention** for autoregressive generation.
* GPT uses a **decoder-only architecture**.
* Original Transformer uses both encoder and decoder.
* Encoder-decoder models can use **cross-attention**.
* Decoder predicts tokens **one step at a time** during generation.

---

## Mental Model

> **Transformer Decoder = Generate the next token using previously available information.**

Next: `10-complete-transformer.md`

```
```
