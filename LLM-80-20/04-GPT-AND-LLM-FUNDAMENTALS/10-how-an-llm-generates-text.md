### `10-how-an-llm-generates-text.md`

````md id="5p3g8u"
# How an LLM Generates Text

## 1. Basic Process

An LLM generates text **one token at a time**.

```text
Prompt
  ↓
Tokenization
  ↓
Transformer
  ↓
Logits
  ↓
Softmax
  ↓
Select next token
  ↓
Add token to context
  ↓
Repeat
````

---

## 2. Example

Suppose the prompt is:

```text
"I love"
```

The model predicts:

```text
"I love" → "AI"
```

Now the context becomes:

```text
"I love AI"
```

The model predicts again:

```text
"I love AI" → "because"
```

Then:

```text
"I love AI because" → "it"
```

This continues until the model decides to stop.

---

## 3. What Happens Inside?

For every generation step:

### Step 1 — Tokenize

```text
"I love AI"
     ↓
[Token IDs]
```

### Step 2 — Transformer

The tokens pass through multiple Transformer layers.

```text
Tokens
  ↓
Self-Attention
  ↓
Feed-Forward Network
  ↓
More Transformer Layers
```

### Step 3 — Logits

The final layer produces a score for every possible next token.

```text
blue → 2.5
AI   → 5.1
the  → 3.2
```

### Step 4 — Softmax

Scores become probabilities.

```text
AI   → 0.70
the  → 0.20
blue → 0.10
```

### Step 5 — Token Selection

A decoding strategy selects the next token.

```text
Selected → "AI"
```

Then the process repeats.

---

## 4. Why Does Generation Take Time?

For a typical autoregressive LLM, tokens are generated sequentially:

```text
Token 1
   ↓
Token 2
   ↓
Token 3
   ↓
Token 4
   ↓
...
```

Therefore, generating a long response requires many generation steps.

---

## 5. Where is This Used?

This process powers:

* ChatGPT-style chatbots
* Code generation
* AI assistants
* Autocomplete
* RAG answer generation
* AI agents
* Content generation

---

## 6. Training vs Generation

During training:

```text
Predict next token
       ↓
Compare with actual token
       ↓
Calculate loss
       ↓
Update parameters
```

During generation:

```text
Predict next token
       ↓
Select token
       ↓
Continue
```

The model's parameters are **not normally updated during inference**.

---

## 7. Important Terms

```text
Token       → Small unit of text
Logit       → Raw score for a token
Probability → Likelihood after Softmax
Context     → Tokens currently available to the model
Inference   → Running the trained model
Decoding    → Choosing the next token
```

---

## GATE / Interview Points

* LLMs generate text autoregressively.
* Generation happens token-by-token.
* Transformer produces logits.
* Softmax converts logits into probabilities.
* A decoding strategy selects the next token.
* The selected token is added to the context.
* The process repeats until a stopping condition is reached.

---

## Mental Model

> **LLM text generation = Predict → Select → Append → Repeat.**

```

**That completes `04-GPT-AND-LLM-FUNDAMENTALS`.**
```
