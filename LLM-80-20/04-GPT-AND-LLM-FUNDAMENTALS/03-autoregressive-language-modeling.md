### `03-autoregressive-language-modeling.md`

````md
# Autoregressive Language Modeling

## 1. What is it?

**Autoregressive language modeling** means predicting the next token using the tokens that have already appeared.

Example:

```text
"I am learning"
       ↓
Predict → "AI"
````

Then:

```text
"I am learning AI"
       ↓
Predict → "with"
```

This continues token by token.

---

## 2. Why "Autoregressive"?

The model's previous output becomes part of the input for the next prediction.

```text
Context
  ↓
Predict token
  ↓
Add token to context
  ↓
Predict next token
  ↓
Repeat
```

---

## 3. Training

During training, the model is given a sequence and learns to predict the next token.

Example:

```text
Input:  I love machine
Target: love machine learning
```

Each position learns to predict the token immediately after it.

A **causal mask** prevents the model from looking at future tokens.

```text
I → can see only past/current tokens
love → can see I, love
machine → can see I, love, machine
```

---

## 4. Where is it Used?

Autoregressive modeling is the basic generation mechanism behind many **decoder-only LLMs**, such as GPT-style models.

Industry applications:

* Chatbots
* Code completion
* Text generation
* Autocomplete
* AI assistants
* Story/content generation

---

## 5. Simple Example

```python
text = "I love machine"

# Model predicts:
next_token = "learning"

text += " " + next_token

print(text)
```

In a real LLM, the model calculates probabilities for many possible next tokens and selects one according to the decoding strategy.

---

## 6. Key Difference

```text
Autoregressive:
Use previous tokens → predict next token

Non-autoregressive:
Try to predict multiple tokens without depending
on previously generated tokens
```

GPT-style generation is primarily **autoregressive**.

---

## GATE / Interview Points

* Predicts the next token from previous tokens.
* Uses **causal/masked self-attention**.
* Previous predictions become future inputs.
* It is the foundation of decoder-only LLM generation.
* Training and inference both involve next-token prediction.

---

## Mental Model

> **Autoregressive = Generate one token, add it to the context, then predict the next token.**

```

Next: `04-next-token-prediction.md`
```
