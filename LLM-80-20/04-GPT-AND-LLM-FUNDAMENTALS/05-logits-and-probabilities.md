### `05-logits-and-probabilities.md`

````md
# Logits and Probabilities

## 1. What are Logits?

**Logits are the raw scores produced by the LLM for every possible next token.**

Example:

```text
Input: "The sky is"

Token      Logit
blue        5.2
green       2.1
dark        1.4
red         0.8
````

Higher logit = model considers that token more likely.

---

## 2. From Logits to Probabilities

Logits are converted into probabilities using **Softmax**.

```text
Logits
  ↓
Softmax
  ↓
Probabilities
```

Example:

```text
blue   → 0.80
green  → 0.10
dark   → 0.06
red    → 0.04
```

All probabilities add up to **1**.

---

## 3. Why Not Directly Use Logits?

Logits can be any real number:

```text
-5, 2.4, 10, 100...
```

They don't represent probabilities.

Softmax converts them into a valid probability distribution:

```text
0 ≤ probability ≤ 1
```

---

## 4. Simple PyTorch Example

```python
import torch

logits = torch.tensor([5.2, 2.1, 1.4, 0.8])

probabilities = torch.softmax(logits, dim=0)

print(probabilities)
print(probabilities.sum())
```

The sum will be approximately:

```text
1.0
```

---

## 5. How LLM Generation Uses This

```text
Prompt
  ↓
Transformer
  ↓
Logits
  ↓
Softmax
  ↓
Token probabilities
  ↓
Decoding strategy
  ↓
Next token
```

For example:

```text
"The sky is"

blue → 80%
clear → 10%
dark → 6%
red → 4%
```

The model then selects a token according to the decoding method.

---

## 6. Where Used in Industry?

Logits and probabilities are used whenever an LLM needs to:

* Generate text
* Generate code
* Rank possible tokens
* Calculate confidence-like scores
* Perform token sampling

They are also important when implementing **temperature, Top-K and Top-P sampling**.

---

## GATE / Interview Points

* **Logits = raw model scores.**
* **Softmax = converts logits into probabilities.**
* Highest logit gives the highest probability.
* Probabilities sum to 1.
* Temperature can modify logits before Softmax.

---

## Mental Model

> **Logits tell the model's preference; Softmax turns that preference into probabilities.**

```

Next: `06-softmax.md`
```
