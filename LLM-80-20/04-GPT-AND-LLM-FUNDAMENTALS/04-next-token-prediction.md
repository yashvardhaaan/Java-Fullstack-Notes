### `04-next-token-prediction.md`

````md id="2g4v6q"
# Next Token Prediction

## 1. What is Next Token Prediction?

An LLM predicts the **most likely next token** based on the current context.

Example:

```text
"The sky is"
       ↓
Model
       ↓
blue
````

The model actually produces probabilities for many possible tokens:

```text
blue   → 0.70
clear  → 0.15
dark   → 0.05
...
```

---

## 2. Why Tokens Instead of Words?

LLMs work with **tokens**, not necessarily complete words.

Example:

```text
"playing"
```

could be represented as:

```text
"play" + "ing"
```

This allows the model to handle words it has not seen exactly during training.

---

## 3. How It Works

```text
Prompt
  ↓
Tokenizer
  ↓
Token IDs
  ↓
Transformer
  ↓
Logits
  ↓
Probabilities
  ↓
Select next token
```

Example:

```text
Input:
"I am going to"

Prediction:
"school"

New context:
"I am going to school"
```

Then it predicts the next token again.

---

## 4. Training Objective

The model is trained to minimize the difference between:

```text
Predicted next token
        vs
Actual next token
```

Usually this is done using **Cross-Entropy Loss**.

```text
Lower loss → Better next-token prediction
```

---

## 5. Where is it Used?

Next-token prediction powers:

* Chatbots
* Code completion
* Autocomplete
* Text generation
* AI assistants
* Email/document generation

For example, an IDE can predict:

```python
def calculate_total(
                    ↓
                price, tax
```

---

## 6. Important Point

The model doesn't simply choose the token with the highest probability every time.

Different **decoding strategies** can be used:

```text
Greedy
Sampling
Temperature
Top-K
Top-P
```

These control how predictable or diverse the generated output is.

---

## GATE / Interview Points

* LLMs output **logits** for possible next tokens.
* Softmax converts logits into probabilities.
* Training commonly uses **cross-entropy loss**.
* GPT-style models repeatedly perform next-token prediction.
* Next-token prediction is the fundamental objective behind autoregressive language generation.

---

## Mental Model

> **LLM generation = Predict the next token → add it to context → predict again.**

```

Next: `05-logits-and-probabilities.md`
```
