### `05-LLM-TRAINING/04-gradient-descent.md`

````md
# Gradient Descent

## 1. What is Gradient Descent?

Gradient Descent is an optimization algorithm used to **reduce the model's loss by updating its parameters**.

```text
Prediction
   ↓
Loss
   ↓
Gradient
   ↓
Gradient Descent
   ↓
Updated Parameters
````

---

## 2. Why is it Needed?

During training, the model makes mistakes.

Gradient Descent helps answer:

> "In which direction should the model's parameters change to reduce the loss?"

Goal:

```text
Loss ↓
Model performance ↑
```

---

## 3. How Does It Work?

Suppose a parameter is `w`.

The basic update rule is:

```text
w_new = w_old - learning_rate × gradient
```

The gradient tells us the direction of increase in loss.

So we move in the **opposite direction**.

```text
Gradient → Direction of increasing loss

Gradient Descent → Move opposite to it
```

---

## 4. Simple Example

Suppose:

```text
w = 5
gradient = 2
learning rate = 0.1
```

Then:

```text
w_new = 5 - (0.1 × 2)
      = 4.8
```

The parameter is updated from:

```text
5 → 4.8
```

---

## 5. Training Loop

A simplified LLM training process:

```text
Input
 ↓
Model
 ↓
Prediction
 ↓
Loss
 ↓
Backpropagation
 ↓
Gradients
 ↓
Gradient Descent
 ↓
Update Parameters
 ↓
Repeat
```

This happens millions/billions of times during large-scale training.

---

## 6. Learning Rate

The **learning rate** controls how large each parameter update is.

```text
Large learning rate
→ Large updates
→ Training may become unstable

Small learning rate
→ Small updates
→ Training may be very slow
```

Example:

```text
learning_rate = 0.001
```

Choosing a suitable learning rate is critical for successful training.

---

## 7. Practical PyTorch Example

```python
import torch

w = torch.tensor(5.0, requires_grad=True)

loss = w ** 2

loss.backward()

learning_rate = 0.1

with torch.no_grad():
    w -= learning_rate * w.grad

print(w)
```

In real neural networks, an optimizer such as `Adam` is normally used:

```python
optimizer.zero_grad()
loss.backward()
optimizer.step()
```

---

## 8. Gradient Descent in LLMs

LLMs have billions of parameters.

Training repeatedly:

```text
Calculate prediction
      ↓
Calculate loss
      ↓
Calculate gradients for parameters
      ↓
Update parameters
```

Over many iterations, the model's parameters are adjusted to reduce the training loss.

---

## 9. Where is it Used?

Gradient-based optimization is used to train:

* LLMs
* CNNs
* RNNs
* Transformers
* Classification models
* Most modern deep learning models

---

## GATE / Interview Points

* Gradient Descent minimizes a loss function.
* Gradient tells the direction of increasing loss.
* Parameters are updated in the opposite direction.
* Learning rate controls update size.
* Backpropagation calculates gradients.
* Optimizers such as **SGD and Adam** perform parameter updates.

### Remember

```text
Backpropagation → Calculate gradients
Gradient Descent → Use gradients to update parameters
```

---

## Mental Model

> **Gradient Descent = Keep adjusting model parameters in the direction that reduces loss.**

```

Next: `05-backpropagation.md`
```
