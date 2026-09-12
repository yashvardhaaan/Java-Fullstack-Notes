Absolutely. We’ll follow the **exact filenames** in `07-LLM-APPLICATIONS` and make every note answer:

**What → Why → Where → How → When → Practical → Interview**

We’ll do **one file at a time**.

### `07-LLM-APPLICATIONS/01-prompt-engineering.md`

````md
# Prompt Engineering

## 1. What is Prompt Engineering?

Prompt engineering is the process of designing instructions/input so an LLM produces the **desired output**.

```text
User Requirement
      ↓
Well-designed Prompt
      ↓
LLM
      ↓
Useful Output
````

It is not about changing the model's parameters. It changes **what we ask and how we ask it**.

---

## 2. Why is it Needed?

LLMs are sensitive to the instructions and context they receive.

Poor prompt:

```text
"Explain SQL"
```

Better prompt:

```text
"Explain SQL joins to a beginner.
Use one simple example and a comparison table."
```

The second prompt gives the model:

* Task
* Audience
* Format
* Level of detail

---

## 3. Where is it Used?

Prompt engineering is used in:

* Chatbots
* AI assistants
* RAG applications
* Customer support
* Code generation
* Data extraction
* AI agents
* Content generation

---

## 4. How Does It Work?

A practical prompt can contain:

```text
Role
+
Task
+
Context
+
Constraints
+
Output Format
```

Example:

```text
You are a SQL tutor.

Task:
Explain INNER JOIN.

Context:
The learner is a beginner.

Constraints:
Keep it under 150 words.

Output:
Give explanation + SQL example.
```

---

## 5. Common Prompting Techniques

### Zero-Shot

Give the task without examples.

```text
"Classify this review as positive or negative."
```

### Few-Shot

Give examples before the actual task.

```text
"Good product" → Positive
"Terrible product" → Negative

"Excellent service" → ?
```

### Role Prompting

Give the model a role.

```text
"You are a senior Python developer."
```

### Structured Output

Specify the required format.

```text
Return JSON with:
{
  "name": "",
  "age": ""
}
```

---

## 6. When Should You Use Prompt Engineering?

Use it when:

* The model already has the required capability.
* You need better instructions.
* You need a specific output format.
* You want to control response style.
* You are building an LLM application quickly.

If prompting cannot reliably produce the required behavior, consider **RAG, tool calling, or fine-tuning** depending on the problem.

---

## 7. Practical Example

### Bad Prompt

```text
Extract customer information.
```

### Better Prompt

```text
Extract the following information from the text:

- Name
- Email
- Phone

Return only valid JSON.

Text:
"Contact Rahul at rahul@example.com
or call 9876543210."
```

Expected:

```json
{
  "name": "Rahul",
  "email": "rahul@example.com",
  "phone": "9876543210"
}
```

This is much easier for an application to consume.

---

## 8. Prompt Engineering in an Application

```text
Application
    ↓
Build Prompt
    ↓
Add User Input
    ↓
Send to LLM API
    ↓
Receive Response
    ↓
Validate / Process Output
```

Example:

```python
prompt = """
Extract the person's name and email.
Return only JSON.

Text:
Rahul can be contacted at rahul@example.com
"""

response = llm.generate(prompt)

print(response)
```

In production, the application should also validate the returned structure instead of blindly trusting model output.

---

## 9. Important Point

Prompt engineering is **not magic wording**.

Good prompts mainly provide:

```text
Clear task
+
Relevant context
+
Constraints
+
Expected format
```

---

## GATE / Interview Points

* Prompt engineering = designing effective inputs/instructions for an LLM.
* Zero-shot = no examples.
* Few-shot = examples are provided.
* Clear constraints improve consistency.
* Structured output is useful when LLM output is consumed by software.
* Prompt engineering does not modify model weights.

---

## Mental Model

> **Prompt Engineering = Tell the model exactly what you want, what context it should use, and what the output should look like.**

```

Next: `02-system-user-assistant-messages.md`
```
