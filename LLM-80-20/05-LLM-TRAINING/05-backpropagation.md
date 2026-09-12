### `05-LLM-TRAINING/05-backpropagation.md`

````md id="b2g4n1"
# Backpropagation

## 1. What is Backpropagation?

**Backpropagation is the process of calculating how much each model parameter contributed to the error (loss).**

It calculates **gradients** using the chain rule.

```text
Input
 ↓
Forward Pass
 ↓
Prediction
 ↓
Loss
 ↓
Backpropagation
 ↓
Gradients
 ↓
Optimizer
 ↓
Updated Parameters
````

---

## 2. Why is Backpropagation Needed?

An LLM has millions or billions of parameters.

When the model makes a wrong prediction, we need to determine:

> Which parameters should change, and by how much?

Backpropagation provides this information through gradients.

---

## 3. How Does It Work?

### Forward Pass

Data moves through the network:

```text
Input → Layers → Prediction → Loss
```

### Backward Pass

The error moves backward:

```text
Loss
 ↓
Layer 3
 ↓
Layer 2
 ↓
Layer 1
```

At each parameter, the model calculates:

```text
∂Loss / ∂Parameter
```

This tells how the loss changes when that parameter changes.

---

## 4. Backpropagation + Gradient Descent

These are related but different.

```text
Backpropagation
→ Calculates gradients

Gradient Descent / Optimizer
→ Uses gradients to update parameters
```

Example:

```text
Loss
 ↓
backward()
 ↓
gradient
 ↓
optimizer.step()
 ↓
updated weights
```

---

## 5. Practical PyTorch Example

```python id="p8a5c4"
import torch

w = torch.tensor(2.0, requires_grad=True)

loss = w ** 2

loss.backward()

print(w.grad)
```

Output:

```text
tensor(4.)
```

Because:

```text
Loss = w²

d(Loss)/dw = 2w

At w = 2:

gradient = 4
```

---

## 6. Real Training Code

A simplified neural-network training step:

```python id="h5k9q2"
optimizer.zero_grad()

output = model(input)

loss = loss_function(output, target)

loss.backward()

optimizer.step()
```

Meaning:

```text
zero_grad()
→ Clear old gradients

model()
→ Forward pass

loss()
→ Calculate error

backward()
→ Calculate gradients

step()
→ Update parameters
```

---

## 7. Where is it Used?

Backpropagation is fundamental to training:

* LLMs
* Transformers
* CNNs
* RNNs
* Neural networks
* Deep learning models

For LLMs, it is used during **training**, not normal inference.

---

## 8. Important Problem: Vanishing Gradients

In very deep networks, gradients can become extremely small.

```text
Gradient
 ↓
0.1
 ↓
0.01
 ↓
0.001
 ↓
0.00001
```

Very small gradients make learning difficult.

Modern Transformer techniques such as:

* Residual connections
* Layer normalization
* Good initialization
* Modern optimizers

help make deep-network training more stable.

---

## GATE / Interview Points

* Backpropagation calculates gradients.
* It uses the **chain rule** of calculus.
* It works from output/loss toward earlier layers.
* `loss.backward()` computes gradients in PyTorch.
* The optimizer uses those gradients to update parameters.
* Backpropagation is part of training, not normal inference.

---

## Mental Model

> **Backpropagation tells every parameter how it should change to reduce the error.**

```

Next: `06-batch-epoch-and-iteration.md`
```
