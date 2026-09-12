### `06-FINE-TUNING-AND-ALIGNMENT/04-rlhf.md`

````md id="j6m4p2"
# RLHF — Reinforcement Learning from Human Feedback

## 1. What is RLHF?

**RLHF** is a method used to align an LLM with **human preferences**.

Instead of only asking:

> "Did the model predict the correct token?"

we also ask:

> "Which response do humans prefer?"

```text
Base / Instruction-Tuned LLM
          ↓
     Generate Answers
          ↓
     Human Preferences
          ↓
    Reward Model
          ↓
 Reinforcement Learning
          ↓
    Aligned LLM
````

---

## 2. Why is RLHF Needed?

An LLM can generate a grammatically correct answer that humans don't like.

Example:

```text
Question:
"Explain AI simply."
```

Response A:

```text
AI is a field of computational intelligence...
```

Response B:

```text
AI means making computers perform tasks
that normally require human intelligence.
```

Humans may prefer **B** because it is clearer and more useful.

RLHF helps the model learn these preferences.

---

## 3. How Does RLHF Work?

A simplified RLHF pipeline:

### Step 1 — Generate Responses

The model generates multiple answers.

```text
Question
   ↓
LLM
   ↓
Response A
Response B
Response C
```

### Step 2 — Human Ranking

Humans rank the responses:

```text
B > A > C
```

This creates preference data.

### Step 3 — Train Reward Model

A separate model learns:

```text
Good response → Higher reward
Bad response  → Lower reward
```

### Step 4 — Optimize the LLM

The LLM is optimized to produce responses that receive higher rewards.

---

## 4. Reward Model

The reward model takes an answer and produces a score.

```text
Question + Response
        ↓
   Reward Model
        ↓
      Score
```

Example:

```text
Response A → 0.4
Response B → 0.9
```

The model learns to prefer responses similar to those humans ranked highly.

---

## 5. Where is RLHF Used?

RLHF has been an important approach for aligning conversational LLMs.

It can improve:

* Helpfulness
* Following instructions
* Response quality
* Safety behavior
* Human preference alignment

It is particularly relevant when building **general-purpose AI assistants**.

---

## 6. RLHF vs SFT

| SFT                          | RLHF                                      |
| ---------------------------- | ----------------------------------------- |
| Uses example answers         | Uses preference feedback                  |
| "This is the desired answer" | "Humans prefer this answer"               |
| Supervised learning          | Reinforcement-learning-based optimization |
| Teaches desired behavior     | Further aligns behavior with preferences  |

Typical simplified pipeline:

```text
Pretraining
    ↓
SFT / Instruction Tuning
    ↓
RLHF
    ↓
Aligned Model
```

---

## 7. Important Practical Point

RLHF is **not simply training on human-written answers**.

The key idea is:

```text
Human preferences
       ↓
Preference signal
       ↓
Optimize model behavior
```

Modern LLM alignment can also use other approaches, such as **DPO (Direct Preference Optimization)** and related preference-optimization methods.

---

## GATE / Interview Points

* RLHF = Reinforcement Learning from Human Feedback.
* It aligns model behavior with human preferences.
* Human rankings can be used to create preference data.
* A reward model can learn human preferences.
* RLHF is generally applied after pretraining and often after SFT.
* RLHF and SFT are different stages/methods.

---

## Mental Model

> **SFT shows the model good answers; RLHF teaches it which kinds of answers humans prefer.**

```

Next: `05-dpo.md`
```
