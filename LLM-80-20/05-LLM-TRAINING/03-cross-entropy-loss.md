### `05-LLM-TRAINING/03-cross-entropy-loss.md`

````md
# Cross-Entropy Loss

## 1. What is Cross-Entropy Loss?

Cross-Entropy Loss measures **how different the model's predicted probabilities are from the correct answer**.

In LLM training, it tells us how well the model predicted the **correct next token**.

```text
Input Tokens
     ↓
LLM
     ↓
Predicted Probabilities
     ↓
Cross-Entropy Loss
     ↓
Backpropagation
````

---

## 2. Why is it Needed?

The model needs a numerical value that tells it:

> "How wrong was my prediction?"

Example:

Correct token:

```text
"Paris"
```

### Prediction 1

```text
Paris → 0.90
```

Loss → **Low**

### Prediction 2

```text
Paris → 0.05
```

Loss → **High**

So:

```text
Good prediction → Low loss
Bad prediction  → High loss
```

---

## 3. How Does It Work?

For the correct class/token:

```text
Loss = -log(P(correct token))
```

Example:

```text
P(correct token) = 0.9

Loss = -log(0.9)
     ≈ 0.105
```

If:

```text
P(correct token) = 0.1

Loss = -log(0.1)
     ≈ 2.303
```

Therefore, giving a high probability to the correct token produces a smaller loss.

---

## 4. In LLM Training

Suppose:

```text
Input:
"The capital of France is"

Correct next token:
"Paris"
```

The model produces:

```text
Paris → 0.70
London → 0.10
Rome → 0.05
...
```

Cross-entropy calculates the loss based mainly on the probability assigned to **Paris**.

Then:

```text
Loss
 ↓
Backpropagation
 ↓
Gradients
 ↓
Update Parameters
```

---

## 5. Practical PyTorch Example

```python
import torch
import torch.nn as nn

loss_fn = nn.CrossEntropyLoss()

logits = torch.tensor([
    [2.5, 0.5, 0.1]
])

target = torch.tensor([0])

loss = loss_fn(logits, target)

print(loss.item())
```

Important:

`CrossEntropyLoss` expects **raw logits**, not Softmax probabilities.

```text
Logits → CrossEntropyLoss
```

You normally do **not** apply Softmax manually before `nn.CrossEntropyLoss()`.

---

## 6. Why Logits Instead of Probabilities?

PyTorch's `CrossEntropyLoss` internally handles the equivalent of:

```text
LogSoftmax + Negative Log-Likelihood
```

So this is preferred:

```python
loss = loss_fn(logits, targets)
```

instead of:

```python
probs = torch.softmax(logits, dim=-1)
loss = loss_fn(probs, targets)   # Wrong usage
```

---

## 7. Where is it Used?

Cross-entropy is widely used in:

* LLM training
* Language modeling
* Image classification
* Text classification
* Multiclass classification

For LLMs:

```text
Prediction
    ↓
Cross-Entropy Loss
    ↓
Backpropagation
    ↓
Gradient Descent
    ↓
Better Parameters
```

---

## 8. GATE / Interview Points

* Cross-entropy measures prediction error for classification.
* LLMs commonly use it for next-token prediction.
* Lower loss generally means better prediction on the training objective.
* Correct token probability ↑ → loss ↓.
* Correct token probability ↓ → loss ↑.
* `CrossEntropyLoss` in PyTorch expects **raw logits**.
* Training uses loss to calculate gradients and update parameters.

---

## Mental Model

> **Cross-Entropy Loss tells the LLM how badly it predicted the correct next token.**

```

Next: `04-gradient-descent.md`
```
