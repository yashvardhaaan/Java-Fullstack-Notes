### `08-parameters.md`

````md
# Parameters

## 1. What are Parameters?

**Parameters are the learned numerical values inside a neural network.**

They are adjusted during training so the model becomes better at its task.

```text
Training Data
     ↓
LLM
     ↓
Update Parameters
     ↓
Better Predictions
````

---

## 2. Simple Example

A neural network contains weights and biases:

```text
Input → Weights → Output
```

These weights are parameters learned during training.

In an LLM, there are **billions of parameters** spread across its layers.

---

## 3. What Does "7B Model" Mean?

If someone says:

```text
7B parameters
```

it means the model has approximately:

```text
7 billion parameters
```

Similarly:

```text
1B  → 1 billion
7B  → 7 billion
70B → 70 billion
```

---

## 4. More Parameters = Better?

**Not necessarily.**

Model quality depends on several factors:

* Number of parameters
* Training data quality
* Training method
* Model architecture
* Amount of compute
* Fine-tuning/alignment

A smaller, well-trained model can outperform a larger poorly trained model on some tasks.

---

## 5. Parameters vs Hyperparameters

### Parameters

Learned automatically during training.

```text
Weights
Biases
```

### Hyperparameters

Chosen by developers during training.

Examples:

```text
Learning rate
Batch size
Number of layers
Number of attention heads
```

---

## 6. Parameters vs Tokens

These are completely different:

```text
Parameters → What the model learns

Tokens → What the model processes
```

Example:

```text
LLM
├── 7B parameters
└── Processes input/output tokens
```

---

## 7. Why Parameters Matter in Industry?

Parameters affect:

* Model size
* Memory requirements
* Training cost
* Inference cost
* Hardware requirements
* Potential model capability

For example, deploying a large LLM may require GPUs with significant memory.

Techniques such as **quantization** can reduce memory requirements.

---

## GATE / Interview Points

* Parameters are learned during training.
* Weights and biases are examples of parameters.
* `7B` means approximately 7 billion parameters.
* More parameters do not automatically mean a better model.
* Parameters are different from tokens.
* Hyperparameters are chosen by the developer; parameters are learned by the model.

---

## Mental Model

> **Parameters = The numbers the model learns during training to make better predictions.**

```

Next: `09-inference.md`
```
