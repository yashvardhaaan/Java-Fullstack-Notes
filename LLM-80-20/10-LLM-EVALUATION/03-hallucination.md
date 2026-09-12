### `10-LLM-EVALUATION/03-hallucination.md`

````md
# Hallucination

## 1. What is Hallucination?

**Hallucination** occurs when an LLM generates information that is false, fabricated, or unsupported by the available evidence.

Example:

```text
User:
Who invented XYZ technology?

LLM:
It was invented by John Smith in 1985.

Reality:
No evidence that this person invented it.
````

The answer may sound confident and grammatically correct but still be wrong.

---

## 2. Why Do LLMs Hallucinate?

An LLM is fundamentally trained to predict likely tokens.

```text
Previous Context
      ↓
Probability Distribution
      ↓
Next Token
      ↓
Next Token
      ↓
...
```

It is not a database that automatically verifies every statement against reality.

Common causes:

* Missing information
* Ambiguous questions
* Outdated knowledge
* Poor-quality context
* Incorrect retrieved documents
* Pressure to provide an answer
* Long or confusing prompts
* Model limitations

---

## 3. Types of Hallucination

### A. Factual Hallucination

The model provides a fact that is false.

```text
"Tokyo is the capital of China."
```

Reality:

```text
Tokyo → Japan
Beijing → China
```

---

### B. Fabricated Information

The model invents information.

Examples:

```text
Fake research paper
Fake citation
Fake person
Fake statistic
Fake API
```

Example:

```text
"According to a 2024 MIT study..."
```

If the study does not exist, this is a hallucination.

---

### C. Contextual Hallucination

The answer contradicts or goes beyond the supplied context.

Context:

```text
Company has 500 employees.
```

LLM:

```text
Company has 5,000 employees.
```

The answer is unsupported by the provided context.

---

### D. Instruction Hallucination

The model claims that it performed an action when it did not.

Example:

```text
"I have sent the email."
```

But no email tool was actually executed.

This is especially dangerous in agentic systems.

---

## 4. Hallucination in RAG

RAG can reduce hallucinations but does **not automatically eliminate them**.

```text
Documents
   ↓
Retriever
   ↓
Relevant Context
   ↓
LLM
   ↓
Answer
```

Potential failures:

```text
Bad retrieval
     ↓
Wrong context
     ↓
Wrong answer
```

Or:

```text
Correct context
     ↓
LLM ignores context
     ↓
Unsupported answer
```

Therefore RAG systems need evaluation of both:

```text
Retrieval quality
+
Answer faithfulness
```

---

## 5. Faithfulness

**Faithfulness** asks:

> Is the generated answer supported by the provided context?

Example:

```text
Context:
"Apple sold 10 million units."

Answer:
"Apple sold 10 million units."

→ Faithful
```

But:

```text
Context:
"Apple sold 10 million units."

Answer:
"Apple sold 20 million units."

→ Not faithful
```

Faithfulness is particularly important for RAG applications.

---

## 6. How to Reduce Hallucinations?

### 1. Use RAG

Provide relevant external information.

```text
Question
 ↓
Retrieve trusted documents
 ↓
LLM
 ↓
Answer
```

---

### 2. Improve the Prompt

Tell the model to use only the supplied information.

Example:

```text
Answer only using the provided context.

If the answer is not present,
say "I don't know."
```

This can reduce unsupported answers, although it is not a perfect guarantee.

---

### 3. Use Trusted Sources

Poor input can produce poor output.

```text
Bad Data → Bad Context → Bad Answer
```

Use:

* Verified documents
* Trusted APIs
* Reliable databases
* Up-to-date sources

---

### 4. Require Citations

For knowledge applications, require the system to provide supporting sources.

```text
Answer
 ↓
Supporting document
 ↓
Citation
```

This makes unsupported claims easier to detect.

---

### 5. Validate Outputs

For structured applications, validate model output before returning or executing it.

```python
result = llm_output

if not is_valid(result):
    reject_or_retry(result)
```

---

### 6. Use Tools

For information that requires current or exact data:

```text
LLM
 ↓
Tool/API
 ↓
Current Data
 ↓
LLM
```

Example:

```text
"What is today's stock price?"
```

A live market-data tool is more appropriate than relying only on model memory.

---

### 7. Human Verification

For high-risk applications:

```text
LLM Answer
    ↓
Human Review
    ↓
Final Decision
```

Examples:

* Medical
* Legal
* Financial
* Security-critical systems

---

## 7. Hallucination vs Uncertainty

A model may not know something.

Good behavior:

```text
"I don't have enough information to answer this reliably."
```

Bad behavior:

```text
"Here is a confident answer..."
```

when the information is unknown.

A good LLM application should allow the model to **abstain** when evidence is insufficient.

---

## 8. Detection

Hallucinations can be detected using:

### Reference Answers

Compare output with a known correct answer.

```text
Expected → Paris
Generated → Paris
```

### Grounding Checks

Compare the answer against retrieved context.

```text
Context
  ↓
Answer
  ↓
Supported?
```

### Human Evaluation

Humans verify factual correctness.

### LLM-as-a-Judge

Another model evaluates whether claims are supported.

### External Verification

Use trusted APIs/databases/search sources to verify claims.

---

## 9. Hallucination in Agents

Hallucination can affect tool usage too.

Example:

```text
User:
"Check my bank balance."

Agent:
"I checked your balance. You have ₹50,000."

Problem:
No banking tool was called.
```

This is dangerous because the agent is claiming an action that never happened.

Correct architecture:

```text
User
 ↓
Agent
 ↓
Banking Tool
 ↓
Actual Result
 ↓
LLM
 ↓
Response
```

The application should record actual tool execution rather than trusting the model's claim.

---

## 10. Hallucination vs Tool Error

These are different.

### Hallucination

The model invents information.

```text
LLM → Fake result
```

### Tool Error

The external tool fails or returns incorrect data.

```text
LLM → Tool
       ↓
   API Failure
```

A robust application should handle both.

---

## 11. Practical Example

Suppose a RAG chatbot receives:

```text
Context:
The company provides 20 paid vacation days per year.
```

Question:

```text
"How many paid vacation days do employees get?"
```

Correct:

```text
"Employees get 20 paid vacation days per year."
```

Hallucinated:

```text
"Employees get 30 paid vacation days per year."
```

Unsupported:

```text
"Employees also receive unlimited sick leave."
```

The last statement may be true or false in reality, but it is **not supported by the provided context**.

---

## 12. Hallucination Rate

A simple evaluation measure can be:

```text
Hallucination Rate =
Hallucinated Responses
----------------------
Total Evaluated Responses
```

Example:

```text
100 responses
8 contain hallucinations

Hallucination Rate = 8%
```

Lower is generally better.

For serious applications, define precisely what counts as a hallucination and evaluate at the claim level when appropriate.

---

## 13. Grounded Generation

**Grounded generation** means generating answers based on trusted evidence.

```text
Trusted Data
     ↓
Retrieve
     ↓
Relevant Context
     ↓
LLM
     ↓
Grounded Answer
```

Common approaches:

```text
RAG
+
Tool/API calls
+
Database queries
+
Citations
```

---

## 14. Important Principle

Remember:

```text
LLM confidence ≠ factual correctness
```

A model can say:

```text
"Absolutely! The answer is..."
```

and still be wrong.

Therefore production systems should rely on:

```text
Evidence
+
Validation
+
Evaluation
```

rather than confidence alone.

---

## 15. When is Hallucination Especially Dangerous?

High-risk cases include:

```text
Medical advice
Legal information
Financial decisions
Security systems
Database modification
Payments
Real-world actions
```

For these systems use stronger controls:

```text
Trusted data
+
Tool verification
+
Validation
+
Human approval when required
```

---

## 16. Key Mental Model

```text
LLM
 ↓
Generates probable answer
 ↓
Is there evidence?
 ↓
YES → Verify / Ground → Answer
NO  → Abstain / Ask / Retrieve
```

The goal is not simply:

> "Make the LLM never hallucinate."

The practical goal is:

> **Design the system so unsupported information is minimized, detected, and prevented from causing harm.**

---

## 17. GATE / Interview Points

* Hallucination is false, fabricated, or unsupported model output.
* LLMs generate probable tokens; they do not automatically fact-check every statement.
* RAG can reduce hallucination but does not eliminate it.
* Faithfulness measures whether an answer is supported by provided context.
* Better retrieval improves grounding.
* Prompting can encourage the model to abstain when evidence is missing.
* Tool/API access can provide current and verifiable information.
* Output validation helps detect invalid responses.
* Human review is important for high-risk applications.
* An agent claiming it performed an action without actually calling the tool is a serious failure.
* Hallucination rate can be used as an evaluation metric.
* Model confidence should not be treated as proof of correctness.

---

## 18. One-Line Revision

> **Hallucination = LLM produces false or unsupported information; reduce it using trusted data, RAG/tools, good prompting, validation, evaluation, and appropriate human verification.**

```
```
