### `10-LLM-EVALUATION/01-why-evaluate-llms.md`

````md
# Why Evaluate LLMs?

## 1. What is LLM Evaluation?

**LLM evaluation** is the process of measuring how well an LLM or LLM application performs a specific task.

Example:

```text
Question
   ↓
LLM
   ↓
Answer
   ↓
Evaluation
   ↓
Is the answer correct, relevant and safe?
````

Evaluation helps determine whether the system is actually working as expected.

---

## 2. Why Do We Need Evaluation?

An LLM can produce an answer that:

* Sounds convincing but is wrong
* Contains hallucinations
* Ignores instructions
* Uses irrelevant information
* Produces inconsistent results
* Leaks sensitive information
* Uses tools incorrectly

Therefore:

> **A fluent answer does not necessarily mean a correct answer.**

Example:

```text
Question:
"What is 2 + 2?"

LLM:
"5"

Fluent?        Yes
Correct?       No
```

Evaluation detects this difference.

---

## 3. Where is LLM Evaluation Used?

### Before Deployment

```text
Model
 ↓
Evaluation Dataset
 ↓
Metrics
 ↓
Pass / Fail
 ↓
Deploy?
```

### After Deployment

Production systems are continuously monitored:

```text
Real User Requests
       ↓
LLM Application
       ↓
Evaluation / Monitoring
       ↓
Quality Metrics
```

Evaluation is therefore needed throughout the lifecycle.

---

## 4. What Should We Evaluate?

Different applications require different criteria.

### Correctness

Is the answer factually correct?

### Relevance

Does the answer address the user's question?

### Helpfulness

Does the answer actually solve the user's problem?

### Faithfulness

Is the answer supported by the provided context?

### Safety

Does the model avoid harmful or unauthorized behavior?

### Consistency

Does it behave reliably across similar inputs?

### Latency

How quickly does it respond?

### Cost

How many tokens/API resources are being consumed?

---

## 5. Example

Suppose we build a customer-support chatbot.

User:

> "How can I reset my password?"

Expected answer:

```text
Go to Settings → Security → Reset Password.
```

LLM output:

```text
Go to Settings → Security → Reset Password.
```

Evaluation:

```text
Correctness   → ✓
Relevance     → ✓
Helpfulness   → ✓
```

Another output:

```text
Contact your bank to reset your password.
```

Evaluation:

```text
Correctness   → ✗
Relevance     → ✗
```

Even though the sentence is grammatically correct, the system fails the task.

---

## 6. Evaluation Dataset

An evaluation dataset contains test cases used to measure the system.

Example:

```python
evaluation_data = [
    {
        "question": "What is 2 + 2?",
        "expected": "4"
    },
    {
        "question": "What is the capital of France?",
        "expected": "Paris"
    }
]
```

Then:

```text
Test Cases
    ↓
LLM
    ↓
Predicted Answers
    ↓
Compare with Expected Results
    ↓
Score
```

A good evaluation dataset should represent real use cases and important failure cases.

---

## 7. Offline vs Online Evaluation

### Offline Evaluation

Tests the system using a fixed dataset.

```text
Evaluation Dataset
       ↓
LLM
       ↓
Metrics
```

Useful before deployment.

### Online Evaluation

Evaluates real production interactions.

```text
Real Users
    ↓
Production System
    ↓
Monitoring / Evaluation
```

Useful for detecting problems that do not appear in the test dataset.

---

## 8. Human Evaluation

Humans manually judge model outputs.

Example:

```text
Question:
Explain recursion.

Answer A:
Clear and correct explanation.

Answer B:
Technically correct but confusing.
```

A human evaluator can rate:

```text
Correctness: 5/5
Clarity:     4/5
Helpfulness: 5/5
```

### Advantages

* Can evaluate subjective quality
* Good for complex tasks

### Disadvantages

* Expensive
* Slow
* Evaluators may disagree

---

## 9. Automated Evaluation

Software automatically calculates scores.

Example:

```text
Expected Answer:
Paris

LLM Answer:
Paris

Score = 1
```

Useful for:

* Large test sets
* Regression testing
* Frequent evaluation
* CI/CD pipelines

However, automated metrics may not perfectly capture human quality.

---

## 10. LLM-as-a-Judge

Another LLM can evaluate an LLM's output.

```text
User Question
      ↓
Model A
      ↓
Answer
      ↓
Model B (Judge)
      ↓
Score + Explanation
```

Example:

```text
Judge:
Correctness = 4/5
Relevance = 5/5
```

This is useful for evaluating open-ended responses, but the judge itself can be biased or incorrect.

Therefore, important evaluations should use carefully designed criteria and, where appropriate, human validation.

---

## 11. Evaluation for RAG

For a RAG application, we may need to evaluate:

```text
Retrieval
    ↓
Did we retrieve the correct documents?
    ↓
Generation
    ↓
Did the LLM answer using those documents?
```

Important concepts:

```text
Retrieval quality
Faithfulness
Answer relevance
```

Example:

```text
Retrieved Context:
"Company leave policy = 20 days"

LLM:
"Employees receive 20 days of leave."

Faithful → ✓
```

If the model says:

```text
"Employees receive 30 days."
```

then the answer is not faithful to the retrieved context.

---

## 12. Evaluation for Agents

Agents require additional evaluation.

Check:

```text
Tool selection
Tool arguments
Planning
Number of steps
Final answer
Safety
```

Example:

```text
User:
"Check my account balance."

Agent should:

1. Authenticate user
2. Call account tool
3. Read balance
4. Respond
```

If it calls an unrelated tool:

```text
send_email()
```

the agent has failed even if its final text looks reasonable.

---

## 13. Regression Testing

Suppose we improve a prompt.

Before:

```text
Accuracy = 85%
```

After:

```text
Accuracy = 91%
```

But perhaps another capability became worse:

```text
Safety = 98% → 90%
```

Evaluation catches such regressions.

Typical process:

```text
Change Prompt / Model / RAG
          ↓
Run Evaluation Dataset
          ↓
Compare with Previous Version
          ↓
Deploy if acceptable
```

---

## 14. Evaluation in Production

A production evaluation pipeline can look like:

```text
                User
                  ↓
             LLM Application
                  ↓
              Response
                  ↓
        ┌─────────┴─────────┐
        ↓                   ↓
   User Feedback        Automated Eval
        ↓                   ↓
        └─────────┬─────────┘
                  ↓
             Quality Data
                  ↓
             Improvement
```

This creates a feedback loop:

```text
Build → Evaluate → Deploy → Monitor → Improve
```

---

## 15. Why Traditional Accuracy is Not Always Enough

For classification:

```text
Prediction = Cat
Actual     = Cat

Accuracy = easy to calculate
```

For open-ended text:

```text
Question:
"Explain TCP."

There can be many correct answers.
```

Therefore, LLM evaluation often requires multiple dimensions:

```text
Correctness
+
Relevance
+
Helpfulness
+
Safety
+
Faithfulness
```

---

## 16. Evaluation Metrics vs Evaluation Methods

### Metrics

What is being measured?

```text
Accuracy
Precision
Recall
F1
BLEU
ROUGE
Latency
Cost
```

### Methods

How is it measured?

```text
Human evaluation
Automated evaluation
LLM-as-a-judge
Reference-based evaluation
Reference-free evaluation
```

Think:

```text
Metric = What do we measure?

Method = How do we measure it?
```

---

## 17. When Should You Evaluate?

Evaluation should happen:

```text
Before training
Before deployment
After model changes
After prompt changes
After RAG changes
After tool changes
During production
```

Especially evaluate after changing:

* Model
* Prompt
* System instructions
* Retrieval strategy
* Tools
* Fine-tuning
* Application logic

---

## 18. Practical Example

Imagine a chatbot has 100 test questions.

```python
questions = [
    "What is Python?",
    "What is recursion?",
    "What is an API?",
]
```

Run the model:

```text
100 questions
     ↓
100 answers
     ↓
Evaluation
     ↓
92 correct
```

Then:

```text
Accuracy = 92 / 100 = 92%
```

After changing the prompt:

```text
Before = 92%
After  = 95%
```

The new version appears better on this evaluation set.

But always check other important dimensions too.

---

## 19. Key Mental Model

Remember:

```text
LLM Output
    ↓
Evaluation
    ↓
Measure Quality
    ↓
Find Failures
    ↓
Improve System
    ↓
Evaluate Again
```

Evaluation is not just about giving the model a score.

It is a **feedback mechanism for improving the complete LLM application**.

---

## 20. GATE / Interview Points

* LLM evaluation measures the quality and reliability of an LLM/application.
* Fluent output does not guarantee correctness.
* Common evaluation dimensions include correctness, relevance, helpfulness, faithfulness and safety.
* Offline evaluation uses a fixed test dataset.
* Online evaluation uses production interactions.
* Human evaluation is flexible but expensive.
* Automated evaluation is scalable but may miss subjective quality.
* LLM-as-a-judge uses another LLM to evaluate outputs.
* RAG systems require evaluation of both retrieval and generation.
* Agents require evaluation of tool selection, arguments, planning and final results.
* Regression testing checks whether changes improve one capability without damaging another.
* Evaluation should be repeated after model, prompt, RAG or tool changes.

---

## 21. One-Line Revision

> **LLM Evaluation = Systematically measure model/application quality → identify failures → improve → test again.**

```
```
