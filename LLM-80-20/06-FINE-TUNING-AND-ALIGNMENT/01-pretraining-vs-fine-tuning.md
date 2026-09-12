### `06-FINE-TUNING-AND-ALIGNMENT/01-pretraining-vs-fine-tuning.md`

````md
# Pretraining vs Fine-Tuning

## 1. What is Pretraining?

Pretraining teaches a model **general language patterns and knowledge** using a very large dataset.

```text
Huge Dataset
     ↓
Pretraining
     ↓
Base LLM
````

The model learns things like:

* Language structure
* General knowledge
* Code patterns
* Relationships between words

---

## 2. What is Fine-Tuning?

Fine-tuning takes an already pretrained model and trains it further on a **smaller, specialized dataset**.

```text
Pretrained LLM
      ↓
Specialized Dataset
      ↓
Fine-Tuning
      ↓
Specialized Model
```

Example:

```text
Base LLM
   ↓
Customer-support conversations
   ↓
Customer-support model
```

---

## 3. Why Fine-Tune?

A pretrained model is general-purpose.

Fine-tuning can make it better at:

* Following a particular format
* A specific task
* A specific domain
* A particular style
* Instruction following

Example:

```text
General LLM
     ↓
Medical instruction dataset
     ↓
Model better adapted to medical tasks
```

Fine-tuning does **not automatically give a model new reliable knowledge**; it mainly changes its behavior/parameters based on the fine-tuning data.

---

## 4. Main Difference

| Pretraining                 | Fine-Tuning                    |
| --------------------------- | ------------------------------ |
| Very large dataset          | Smaller specialized dataset    |
| Learns general capabilities | Adapts capabilities            |
| Expensive                   | Usually much cheaper           |
| Creates base model          | Creates specialized model      |
| Usually done from scratch   | Starts from pretrained weights |

---

## 5. How Fine-Tuning Works

The process is similar to normal training:

```text
Fine-tuning Data
      ↓
Tokenization
      ↓
Pretrained Model
      ↓
Prediction
      ↓
Loss
      ↓
Backpropagation
      ↓
Parameter Updates
```

The difference is that the model **already has useful pretrained weights**.

---

## 6. Practical Example

Suppose we have a pretrained model and instruction data:

```python
data = [
    {
        "instruction": "Translate to French",
        "input": "Hello",
        "output": "Bonjour"
    },
    {
        "instruction": "Translate to French",
        "input": "Good morning",
        "output": "Bonjour"
    }
]
```

During fine-tuning, the model learns to produce the desired outputs for these types of instructions.

---

## 7. When to Use Which?

### Use Pretraining when:

```text
You want to build a foundation model
+ Have massive data
+ Have large compute resources
```

### Use Fine-Tuning when:

```text
A pretrained model already exists
+ You need specific behavior
+ You have a suitable specialized dataset
```

In most real-world applications, starting from a pretrained model is much more practical than training an LLM from scratch.

---

## 8. Industry Example

A company wants an AI assistant for customer support.

Instead of:

```text
Train LLM from scratch
```

they can use:

```text
Pretrained LLM
      ↓
Company support conversations
      ↓
Fine-tuning
      ↓
Customer-support model
```

Another common approach is **RAG**, where company documents are retrieved at inference time instead of putting all company knowledge into the model's weights.

---

## 9. GATE / Interview Points

* Pretraining creates a general/base model.
* Fine-tuning starts from pretrained weights.
* Pretraining needs much more data and compute.
* Fine-tuning uses a smaller, task/domain-specific dataset.
* Fine-tuning updates model parameters unless using a parameter-efficient method.
* Fine-tuning and RAG solve different problems.

---

## Mental Model

> **Pretraining = Teach the model generally.**
>
> **Fine-tuning = Adapt the pretrained model for a specific purpose.**

```

Next: `02-supervised-fine-tuning.md`
```
