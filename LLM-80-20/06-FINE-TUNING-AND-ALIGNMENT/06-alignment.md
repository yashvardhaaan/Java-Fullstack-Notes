You're correct — the screenshot clearly shows the exact structure. We already covered `01`–`05`, and **`06-alignment.md` is the final file** in this folder.

### `06-FINE-TUNING-AND-ALIGNMENT/06-alignment.md`

````md
# Alignment

## 1. What is Alignment?

**Alignment** is the process of making an LLM's behavior match **human goals, preferences, and safety requirements**.

A pretrained model learns language:

```text
Pretraining
    ↓
Base LLM
````

Alignment teaches it how it should behave:

```text
Base LLM
    ↓
SFT / Instruction Tuning
    ↓
Preference Optimization
    ↓
Aligned LLM
```

---

## 2. Why is Alignment Needed?

A model can generate fluent text but still:

* Ignore instructions
* Give unsafe responses
* Be unnecessarily rude
* Produce unhelpful answers
* Follow the wrong interpretation of a request

Alignment tries to make the model:

```text
Helpful
+ Safe
+ Instruction-following
+ Consistent
```

---

## 3. How is an LLM Aligned?

A simplified pipeline:

```text
Pretraining
     ↓
Base Model
     ↓
Supervised Fine-Tuning
     ↓
Instruction-Following Model
     ↓
Human Preference Data
     ↓
RLHF / DPO
     ↓
Aligned Model
```

Different LLMs can use different alignment techniques.

---

## 4. SFT vs RLHF vs DPO

### SFT

Uses examples of desired responses.

```text
Instruction → Good Answer
```

### RLHF

Uses human preferences to optimize model behavior.

```text
Response A vs Response B
        ↓
Human Preference
        ↓
Reward / Optimization
```

### DPO

Directly learns from preference pairs.

```text
Prompt
 ├── Chosen Response
 └── Rejected Response
        ↓
       DPO
        ↓
Aligned Model
```

---

## 5. Practical Example

Suppose an assistant receives:

```text
"Write a professional email asking for leave."
```

An aligned model should understand:

```text
Professional tone
+
Follow user's request
+
Useful response
```

Instead of producing:

```text
Random
Off-topic
or inappropriate output
```

Alignment improves the probability of the preferred behavior.

---

## 6. Where is Alignment Used?

Alignment is important for:

* Chatbots
* AI assistants
* Coding assistants
* Customer-support systems
* Enterprise AI
* AI agents

Especially when the model interacts directly with users.

---

## 7. Important Point

**Alignment does not mean the model becomes perfectly correct.**

An aligned model can still:

* Hallucinate
* Make reasoning mistakes
* Give outdated information
* Misinterpret a request

Alignment mainly focuses on **behavior and preferences**, not guaranteeing factual correctness.

---

## 8. Industry Perspective

A simplified modern LLM development process:

```text
Large-scale Pretraining
        ↓
Base LLM
        ↓
SFT / Instruction Tuning
        ↓
Preference Optimization
        ↓
Safety Evaluation
        ↓
Deployment
```

Companies also use evaluations and monitoring after deployment to identify undesirable behavior.

---

## GATE / Interview Points

* Alignment makes model behavior better match human goals/preferences.
* Alignment usually happens after pretraining.
* SFT teaches desired instruction-following behavior.
* RLHF uses human feedback/preferences.
* DPO directly optimizes from preference pairs.
* Alignment does not guarantee factual correctness.
* Safety and helpfulness are important alignment objectives.

---

## Mental Model

> **Pretraining teaches the model what it can do; alignment teaches it how it should behave.**

```

**That completes `06-FINE-TUNING-AND-ALIGNMENT`.**
```
