### `06-FINE-TUNING-AND-ALIGNMENT/03-instruction-tuning.md`

````md
# Instruction Tuning

## 1. What is Instruction Tuning?

Instruction tuning is the process of fine-tuning an LLM on **instruction → response examples** so that it becomes better at following user instructions.

```text
Pretrained LLM
      ↓
Instruction + Good Response Examples
      ↓
Instruction Tuning
      ↓
Instruction-Following LLM
````

---

## 2. Why is it Needed?

A pretrained model learns language patterns, but it may not naturally behave like an assistant.

Example:

```text
User:
"Explain recursion in simple words."

Desired:
"Recursion is when a function calls itself..."
```

Instruction tuning teaches the model to understand the **task requested by the user** and produce an appropriate response.

---

## 3. How Does It Work?

Training data contains many different tasks:

```text
Instruction → Response

"Summarize this text" → Summary
"Translate to Hindi" → Translation
"Write Python code" → Code
"Explain TCP" → Explanation
```

The model is fine-tuned to generate the expected response.

```text
Instruction
    ↓
Tokenizer
    ↓
Transformer
    ↓
Predicted Response
    ↓
Loss
    ↓
Backpropagation
    ↓
Updated Parameters
```

---

## 4. Instruction Tuning vs SFT

Instruction tuning is commonly implemented using **Supervised Fine-Tuning (SFT)**.

```text
SFT
↓
Training method

Instruction tuning
↓
Using instruction-response data to teach instruction following
```

So they are closely related, but not exactly the same term.

---

## 5. Example Dataset

```json
{
  "instruction": "Convert 10 km to meters.",
  "response": "10 km = 10,000 meters."
}
```

Another example:

```json
{
  "instruction": "Write a Python function to add two numbers.",
  "response": "def add(a, b):\n    return a + b"
}
```

A large collection of such examples teaches the model different instruction-following behaviors.

---

## 6. Where is it Used?

Instruction tuning is important for:

* Chatbots
* AI assistants
* Coding assistants
* Customer-support systems
* Document assistants
* General-purpose LLMs

Typical development flow:

```text
Pretraining
    ↓
Base Model
    ↓
Instruction Tuning / SFT
    ↓
Instruction-Following Model
    ↓
Alignment
```

---

## 7. Practical Example

Imagine a company wants an internal assistant that follows a specific response format.

Training example:

```text
Instruction:
"Summarize the incident in 3 bullet points."

Response:
"- Server went down.
 - Database connection failed.
 - Service restored after restart."
```

After training on many examples, the model becomes better at producing responses in that format.

---

## 8. Important Limitation

Instruction tuning does **not guarantee that every answer is correct**.

It mainly improves:

```text
Instruction following
Response format
Task behavior
```

It does not automatically make the model a perfect source of factual knowledge.

For changing or private information, techniques such as **RAG** can be used alongside an instruction-tuned model.

---

## GATE / Interview Points

* Instruction tuning teaches an LLM to follow human instructions.
* It commonly uses SFT with instruction-response pairs.
* It happens after pretraining.
* It improves task following and response behavior.
* High-quality instruction datasets are important.
* Instruction tuning is different from RLHF; RLHF uses human preference signals for further alignment.

---

## Mental Model

> **Instruction tuning = Teach the pretrained LLM how humans expect it to respond to instructions.**

```

Next: `04-rlhf.md`
```
