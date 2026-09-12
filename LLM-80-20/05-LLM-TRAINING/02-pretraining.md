### `05-LLM-TRAINING/02-pretraining.md`

````md
# Pretraining

## 1. What is Pretraining?

Pretraining is the **first major training stage** where an LLM learns general language patterns from a very large dataset.

```text
Huge Dataset
     ↓
Next-Token Prediction
     ↓
Loss
     ↓
Backpropagation
     ↓
Update Parameters
     ↓
Repeat billions of times
````

The result is a **base/foundation model**.

---

## 2. Why is Pretraining Needed?

Before an LLM can follow instructions effectively, it needs to learn basic patterns such as:

* Grammar
* Vocabulary
* Language relationships
* Facts and concepts
* Code patterns
* Contextual relationships

Example:

```text
"The sun rises in the ___"

Model learns:
"east"
```

After seeing huge amounts of data, the model develops general language capabilities.

---

## 3. How Does Pretraining Work?

A simplified training step:

```text
Text
 ↓
Tokenization
 ↓
Input Tokens
 ↓
Transformer
 ↓
Predict Next Token
 ↓
Calculate Loss
 ↓
Backpropagation
 ↓
Update Weights
```

This process is repeated over enormous amounts of training data.

---

## 4. Example

Training sequence:

```text
"The cat is sitting"
```

The model can learn:

```text
Input: "The"
Target: "cat"

Input: "The cat"
Target: "is"

Input: "The cat is"
Target: "sitting"
```

The model compares its predictions with the actual next tokens and updates its parameters.

---

## 5. Pretraining vs Fine-Tuning

### Pretraining

```text
Huge + diverse data
        ↓
General knowledge/language ability
        ↓
Base Model
```

### Fine-Tuning

```text
Smaller + specialized dataset
        ↓
Specific behavior/task
        ↓
Specialized Model
```

So:

> **Pretraining teaches general language patterns; fine-tuning adapts the model for specific behavior.**

---

## 6. Practical Example

A simplified PyTorch training loop:

```python
for input_ids, target_ids in dataloader:

    logits = model(input_ids)

    loss = loss_function(
        logits.view(-1, vocab_size),
        target_ids.view(-1)
    )

    optimizer.zero_grad()
    loss.backward()
    optimizer.step()
```

Important:

```text
loss.backward()
→ calculates gradients

optimizer.step()
→ updates parameters
```

This connects directly to:

* Cross-entropy loss
* Gradient descent
* Backpropagation

---

## 7. Where is Pretraining Used?

Pretraining is used to create **foundation models** that can later be adapted for:

* Chatbots
* Coding assistants
* Search
* RAG
* AI agents
* Translation
* Domain-specific applications

A company may start with a pretrained base model and then fine-tune or align it for its product.

---

## 8. Why is Pretraining Expensive?

Large models require:

* Huge datasets
* Powerful GPUs/TPUs
* Large memory
* Distributed training
* Long training time
* High electricity and infrastructure costs

This is why companies usually **do not train a large LLM from scratch** for every application.

They often start with an existing foundation model.

---

## GATE / Interview Points

* Pretraining is the initial large-scale training stage.
* Usually uses self-supervised learning.
* Next-token prediction is a common objective for decoder-based LLMs.
* Training updates model parameters.
* Pretraining produces a base/foundation model.
* Fine-tuning happens after pretraining.
* Pretraining requires significant compute and data.

---

## Mental Model

> **Pretraining = Teach a model general language ability using massive amounts of data before specializing it.**

```

Next: `03-cross-entropy-loss.md`
```
