### `06-FINE-TUNING-AND-ALIGNMENT/05-dpo.md`

````md id="m7k3q2"
# DPO — Direct Preference Optimization

## 1. What is DPO?

**DPO (Direct Preference Optimization)** is a technique for aligning an LLM using **human preference data**.

Instead of training a separate reward model and then doing reinforcement learning, DPO directly trains the LLM to prefer the better response.

```text
Preference Data
     ↓
Chosen Response + Rejected Response
     ↓
DPO Training
     ↓
Aligned LLM
````

---

## 2. Why is DPO Needed?

Suppose the model produces two answers:

```text
Question:
"Explain recursion."

Answer A → Clear and correct
Answer B → Confusing
```

Human preference:

```text
Chosen   → A
Rejected → B
```

DPO teaches the model to assign a **higher probability to A than B**.

---

## 3. How Does DPO Work?

Training data contains pairs:

```text
Prompt
  ├── Chosen response
  └── Rejected response
```

Example:

```json
{
  "prompt": "Explain AI simply.",
  "chosen": "AI allows computers to perform tasks that normally require human intelligence.",
  "rejected": "AI is computational intelligence involving complex algorithms."
}
```

During training, DPO encourages:

```text
P(chosen | prompt) ↑
P(rejected | prompt) ↓
```

---

## 4. DPO vs RLHF

### Traditional RLHF

```text
Human Preferences
       ↓
Reward Model
       ↓
Reinforcement Learning
       ↓
Aligned LLM
```

### DPO

```text
Human Preferences
       ↓
Direct Preference Optimization
       ↓
Aligned LLM
```

DPO removes the need for a separately trained reward model and the RL optimization stage used in the traditional RLHF pipeline.

---

## 5. Why is DPO Popular?

DPO can be:

* Simpler to implement
* Easier to train
* More computationally practical
* Stable for many preference-alignment tasks

It is useful when you already have **chosen vs rejected response pairs**.

---

## 6. Where is DPO Used?

DPO can be used for:

* Chatbot alignment
* Instruction following
* Response quality improvement
* Style preference
* Safety behavior
* Domain-specific assistant behavior

Typical pipeline:

```text
Pretraining
    ↓
SFT
    ↓
Preference Data
    ↓
DPO
    ↓
Aligned Model
```

---

## 7. Practical Example

A preference dataset might look like:

```python
data = {
    "prompt": "Write a professional email.",
    "chosen": "Dear Sir, I am writing to...",
    "rejected": "Hey! Just wanted to tell you..."
}
```

DPO trains the model to prefer the `chosen` response for that prompt.

---

## 8. Key Difference

```text
SFT:
"Here is the correct answer."

DPO:
"Between these two answers, humans prefer this one."
```

This makes DPO especially useful for learning **preferences**, rather than simply copying supervised examples.

---

## GATE / Interview Points

* DPO = Direct Preference Optimization.
* Uses preference pairs: **chosen vs rejected**.
* Directly optimizes the policy/model using preference data.
* Does not require a separate reward model like traditional RLHF.
* Commonly used after SFT for alignment.
* DPO is an alternative to the traditional RLHF optimization stage.

---

## Mental Model

> **DPO = Teach the model to prefer the human-selected good response over the rejected response.**

```

Next: `06-lora-and-peft.md`
```
