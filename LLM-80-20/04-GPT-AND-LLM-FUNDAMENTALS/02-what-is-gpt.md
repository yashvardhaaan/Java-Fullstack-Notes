### `02-what-is-gpt.md`

````md
# What is GPT?

## 1. What is GPT?

**GPT = Generative Pre-trained Transformer**

It is a family of language models designed primarily to **generate text by predicting the next token**.

```text
Prompt
  ↓
GPT
  ↓
Next-token prediction
  ↓
Generated text
````

---

## 2. What does GPT mean?

### Generative

It can generate new content.

Examples:

* Text
* Code
* Summaries
* Answers

### Pre-trained

The model is trained on large datasets **before** being used for a specific application.

### Transformer

It uses the **Transformer architecture**, particularly decoder-style Transformer blocks in GPT-style models.

---

## 3. How does GPT generate text?

Example:

```text
Input:
"The sun rises in the"

Prediction:
"east"
```

Then the model uses the new token:

```text
"The sun rises in the east"
```

and predicts the next token.

This continues until the response is complete.

---

## 4. GPT Architecture

Simplified GPT:

```text
Text
 ↓
Tokenizer
 ↓
Token Embeddings
 ↓
Positional Information
 ↓
Transformer Blocks
 ├── Self-Attention
 ├── LayerNorm
 ├── Feed-Forward Network
 └── Residual Connections
 ↓
Logits
 ↓
Probabilities
 ↓
Next Token
```

---

## 5. GPT vs BERT

| GPT                   | BERT                         |
| --------------------- | ---------------------------- |
| Decoder-only          | Encoder-only                 |
| Mainly generation     | Mainly understanding         |
| Uses causal attention | Uses bidirectional attention |
| Next-token prediction | Masked-token prediction      |

Example:

```text
GPT  → Generate a response
BERT → Understand/classify text
```

---

## 6. Where is GPT Used?

GPT-style models are used for:

* AI chatbots
* Coding assistants
* Text generation
* Summarization
* Question answering
* AI agents
* Content generation
* Natural-language interfaces

---

## 7. Important Concept

GPT does not "think" by retrieving a complete answer from a database.

At a basic level, generation happens through repeated:

```text
Context
   ↓
Predict next token
   ↓
Add token to context
   ↓
Predict next token
   ↓
Repeat
```

---

## Mental Model

> **GPT = A pre-trained Transformer that generates text by repeatedly predicting the next token.**

```

Next: `03-autoregressive-language-modeling.md`
```
