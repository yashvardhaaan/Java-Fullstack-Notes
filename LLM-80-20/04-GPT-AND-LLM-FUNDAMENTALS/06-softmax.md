### `06-softmax.md`

````md
# Softmax

## 1. What is Softmax?

**Softmax converts raw scores (logits) into probabilities.**

Example:

```text
Logits:
[2.0, 1.0, 0.1]

       ↓ Softmax

Probabilities:
[0.66, 0.24, 0.10]
````

The probabilities always add up to **1**.

---

## 2. Why is Softmax Used in LLMs?

An LLM produces a score for **every token in its vocabulary**.

```text
Transformer
    ↓
Logits
    ↓
Softmax
    ↓
Probability of every token
```

Example:

```text
"The cat is"

sleeping → 0.60
eating   → 0.25
running  → 0.10
blue     → 0.05
```

The model can then choose the next token.

---

## 3. Formula

For a logit `zᵢ`:

```text
softmax(zᵢ) = eᶻⁱ / Σ eᶻʲ
```

The exponential makes larger logits receive much larger probabilities.

---

## 4. Simple PyTorch Example

```python
import torch

logits = torch.tensor([2.0, 1.0, 0.1])

probs = torch.softmax(logits, dim=0)

print(probs)
print(probs.sum())
```

Output will be approximately:

```text
tensor([0.66, 0.24, 0.10])
tensor(1.)
```

---

## 5. Softmax vs Sigmoid

| Softmax                          | Sigmoid                          |
| -------------------------------- | -------------------------------- |
| Multiple classes                 | Usually binary/multi-label       |
| Outputs sum to 1                 | Each output is independent       |
| Common for next-token prediction | Common for binary classification |

---

## 6. Where Used in Industry?

Softmax is heavily used in:

* LLM token prediction
* Classification models
* Attention mechanisms
* Recommendation/ranking systems
* Neural network output layers

In an LLM:

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
Next token
```

---

## GATE / Interview Points

* Softmax converts logits into probabilities.
* Output values lie between `0` and `1`.
* All output probabilities sum to `1`.
* Larger logits generally produce larger probabilities.
* Softmax is used for next-token prediction.

---

## Mental Model

> **Softmax = Turn the model's raw scores into a probability distribution.**

```

Next: `07-temperature.md`
```
