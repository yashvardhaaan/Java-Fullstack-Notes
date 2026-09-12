### `06-FINE-TUNING-AND-ALIGNMENT/02-supervised-fine-tuning.md`

````md
# Supervised Fine-Tuning (SFT)

## 1. What is SFT?

**Supervised Fine-Tuning (SFT)** trains a pretrained LLM using examples where the **desired output is already provided**.

```text
Pretrained LLM
      ↓
Instruction + Correct Answer
      ↓
Fine-Tuning
      ↓
Better instruction following
````

---

## 2. Why is SFT Needed?

A base LLM mainly learns:

> "Predict the next token."

But we want it to behave like an assistant:

```text
User: Explain photosynthesis simply.

Assistant: Photosynthesis is the process...
```

SFT teaches the model how to respond to instructions in the desired way.

---

## 3. What Does Training Data Look Like?

Typical SFT data contains:

```text
Instruction → Desired Response
```

Example:

```json
{
  "instruction": "What is Python?",
  "response": "Python is a high-level programming language."
}
```

Thousands or millions of such examples can be used for fine-tuning.

---

## 4. How Does SFT Work?

The training process is similar to normal language-model training:

```text
Instruction + Response
        ↓
     Tokenize
        ↓
Pretrained Model
        ↓
Predict Response Tokens
        ↓
Calculate Loss
        ↓
Backpropagation
        ↓
Update Parameters
```

The model learns to assign higher probability to the desired response.

---

## 5. Example

Training example:

```text
Instruction:
"Translate 'Hello' to French."

Target:
"Bonjour."
```

The model learns to generate:

```text
"Bonjour."
```

for similar instructions.

---

## 6. Practical PyTorch Idea

A simplified training step:

```python
output = model(input_ids)

loss = loss_fn(
    output.view(-1, vocab_size),
    target_ids.view(-1)
)

optimizer.zero_grad()
loss.backward()
optimizer.step()
```

In practice, the dataset is formatted into token sequences and the loss is typically focused on the **assistant/target portion** rather than the instruction tokens.

---

## 7. Where is SFT Used?

SFT is commonly used to build:

* Chat assistants
* Coding assistants
* Customer-support models
* Domain-specific assistants
* Instruction-following models

Example:

```text
Base LLM
   ↓
High-quality instruction/answer dataset
   ↓
SFT
   ↓
Instruction-following model
```

---

## 8. SFT vs Pretraining

| Pretraining                      | SFT                                 |
| -------------------------------- | ----------------------------------- |
| Huge general dataset             | Smaller curated dataset             |
| Learns general language patterns | Learns desired behavior             |
| Very expensive                   | Comparatively cheaper               |
| Creates base model               | Creates instruction-following model |

---

## 9. Important Limitation

SFT learns from the examples provided.

If the training examples contain:

```text
Wrong answers
Bad formatting
Unwanted behavior
```

the model can learn those patterns too.

Therefore, **high-quality training examples are extremely important**.

---

## GATE / Interview Points

* SFT = Supervised Fine-Tuning.
* Starts from a pretrained model.
* Uses input-output examples.
* Teaches instruction following and desired response behavior.
* Uses a supervised training loss.
* Usually comes after pretraining.
* Dataset quality strongly affects the resulting model.

---

## Mental Model

> **SFT = Show the pretrained model examples of good answers and train it to reproduce that behavior.**

```

Next: `03-instruction-tuning.md`
```
