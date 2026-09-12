### `10-LLM-EVALUATION/05-llm-evaluation-pipeline.md`

````md
# LLM Evaluation Pipeline

## 1. What is an LLM Evaluation Pipeline?

An **LLM evaluation pipeline** is a systematic process used to test, measure, compare, and improve an LLM or LLM application.

Basic flow:

```text
Test Dataset
     ↓
LLM Application
     ↓
Generated Outputs
     ↓
Evaluation
     ↓
Metrics
     ↓
Failure Analysis
     ↓
Improvement
     ↓
Evaluate Again
````

---

## 2. Why is an Evaluation Pipeline Needed?

Manually checking every LLM response is:

* Slow
* Expensive
* Inconsistent
* Difficult to scale

An evaluation pipeline automates repeated testing.

Example:

```text
1000 test cases
      ↓
Run Model
      ↓
Evaluate
      ↓
Quality Score
```

It can also detect whether a new model/prompt is better than the previous version.

---

## 3. Main Stages

A typical pipeline contains:

```text
1. Define evaluation objective
2. Create evaluation dataset
3. Run LLM application
4. Collect outputs
5. Calculate metrics
6. Analyze failures
7. Compare versions
8. Deploy / improve
9. Monitor in production
```

---

## 4. Step 1 — Define What to Evaluate

First define what "good" means.

Example: Customer-support chatbot

```text
Correctness
Relevance
Helpfulness
Faithfulness
Safety
Latency
Cost
```

For an agent:

```text
Task success
Tool selection
Tool arguments
Number of steps
Final answer
```

The evaluation criteria must match the application's actual goal.

---

## 5. Step 2 — Create Evaluation Dataset

Create representative test cases.

Example:

```python
evaluation_data = [
    {
        "question": "What is the leave policy?",
        "expected": "Employees get 20 paid vacation days."
    },
    {
        "question": "How can I reset my password?",
        "expected": "Go to Settings → Security → Reset Password."
    }
]
```

A good dataset should contain:

* Common user queries
* Important edge cases
* Difficult cases
* Known failure cases
* Safety-sensitive cases

---

## 6. Step 3 — Run the LLM Application

Run every test case through the actual application.

```python
for item in evaluation_data:

    output = llm_app(item["question"])

    print(output)
```

For a RAG application:

```text
Question
 ↓
Retriever
 ↓
Context
 ↓
LLM
 ↓
Answer
```

For an agent:

```text
Question
 ↓
Agent
 ↓
Tools
 ↓
Observations
 ↓
Final Answer
```

Evaluate the system as it will actually run.

---

## 7. Step 4 — Collect Outputs

Store useful evaluation information.

Example:

```python
result = {
    "question": question,
    "expected": expected_answer,
    "actual": actual_answer,
    "latency": latency,
    "tokens": tokens
}
```

For RAG, also store:

```text
Retrieved documents
Chunks
Similarity scores
```

For agents, also store:

```text
Tool calls
Tool arguments
Tool results
Number of steps
```

---

## 8. Step 5 — Calculate Metrics

Choose metrics based on the task.

```text
Classification
→ Accuracy / Precision / Recall / F1

Text Generation
→ BLEU / ROUGE / Semantic Similarity

RAG
→ Retrieval Recall / Precision
→ Faithfulness
→ Relevance
→ Correctness

Agents
→ Task Success
→ Tool Accuracy
→ Step Efficiency

Production
→ Latency
→ Cost
→ Error Rate
```

---

## 9. Step 6 — Automated Evaluation

Some metrics can be calculated automatically.

Example:

```python
correct = 0

for item in evaluation_data:

    if item["actual"] == item["expected"]:
        correct += 1

accuracy = correct / len(evaluation_data)

print(accuracy)
```

Output:

```text
0.90
```

Therefore:

```text
Accuracy = 90%
```

---

## 10. Step 7 — LLM-as-a-Judge

For open-ended responses, another LLM can evaluate the output.

```text
Question
   ↓
Model Under Test
   ↓
Generated Answer
   ↓
Judge LLM
   ↓
Score + Reason
```

Example evaluation criteria:

```text
Correctness: 1–5
Relevance:   1–5
Helpfulness: 1–5
```

Example:

```json
{
  "correctness": 5,
  "relevance": 4,
  "helpfulness": 5
}
```

Important:

> LLM-as-a-judge is itself imperfect and should be validated, especially for important evaluations.

---

## 11. Step 8 — Human Evaluation

Humans can review a sample of outputs.

Example:

```text
1000 outputs
    ↓
Automated evaluation
    ↓
100 suspicious/important cases
    ↓
Human review
```

This is often more practical than manually checking everything.

Human evaluation is especially useful for:

* Subjective quality
* Safety
* Complex reasoning
* Ambiguous answers

---

## 12. Step 9 — Failure Analysis

A score alone does not explain why the system failed.

Example:

```text
Accuracy = 85%
```

Now inspect failures.

Possible causes:

```text
Wrong retrieval
Bad prompt
Hallucination
Tool failure
Incorrect reasoning
Missing data
Output formatting error
```

Failure analysis tells us **what needs to be improved**.

---

## 13. RAG Evaluation Pipeline

```text
Test Questions
      ↓
Retriever
      ↓
Retrieved Documents
      ↓
Evaluate Retrieval
      ↓
LLM
      ↓
Generated Answer
      ↓
Evaluate:
- Faithfulness
- Relevance
- Correctness
      ↓
Failure Analysis
```

Important:

> Do not evaluate only the final answer. Identify whether the problem occurred during retrieval or generation.

---

## 14. Agent Evaluation Pipeline

For an agent:

```text
Task
 ↓
Agent
 ↓
Decision
 ↓
Tool Call
 ↓
Tool Result
 ↓
Decision
 ↓
...
 ↓
Final Answer
```

Evaluate:

```text
Task success
Tool selection
Argument correctness
Tool execution
Number of steps
Final answer
Safety
```

Example:

```text
Expected:
search_web()

Actual:
send_email()

→ Tool selection failure
```

---

## 15. Step 10 — Regression Testing

Suppose we change the prompt.

### Version A

```text
Accuracy = 88%
```

### Version B

```text
Accuracy = 93%
```

Version B looks better.

But check all metrics:

```text
              Version A    Version B

Accuracy         88%          93%
Safety           98%          91%
Latency         1.5s         2.3s
Cost             ₹1           ₹3
```

Version B may not necessarily be better for production.

This is why evaluation should be **multi-dimensional**.

---

## 16. Evaluation Gate

A production pipeline can define minimum requirements:

```text
Accuracy     ≥ 90%
Faithfulness ≥ 95%
Safety       ≥ 99%
Latency      < 2 seconds
```

Then:

```text
New Version
     ↓
Evaluation
     ↓
All thresholds passed?
    ↙        ↘
  Yes         No
   ↓           ↓
Deploy      Reject / Improve
```

This can be integrated into CI/CD.

---

## 17. Evaluation in CI/CD

LLM applications can be tested whenever code or prompts change.

```text
Developer Change
       ↓
CI/CD
       ↓
Run Evaluation Dataset
       ↓
Calculate Metrics
       ↓
Pass?
   ↙       ↘
 Yes       No
 ↓          ↓
Deploy    Block
```

This prevents a new change from silently reducing quality.

---

## 18. Production Monitoring

Offline evaluation is not enough.

After deployment:

```text
Real Users
    ↓
LLM Application
    ↓
Logs / Traces
    ↓
Production Evaluation
    ↓
Quality Metrics
```

Monitor:

```text
Latency
Cost
Errors
User feedback
Hallucinations
Task success
Tool failures
```

---

## 19. Feedback Loop

A mature system follows:

```text
Build
 ↓
Evaluate
 ↓
Deploy
 ↓
Monitor
 ↓
Collect Failures
 ↓
Improve
 ↓
Evaluate Again
```

This is a continuous improvement loop.

---

## 20. Simple Evaluation Pipeline

```python
def evaluate(app, dataset):

    results = []

    for item in dataset:

        output = app(item["question"])

        score = evaluate_output(
            output,
            item["expected"]
        )

        results.append({
            "question": item["question"],
            "output": output,
            "score": score
        })

    return results
```

Then:

```python
results = evaluate(llm_app, evaluation_data)

average_score = sum(
    r["score"] for r in results
) / len(results)

print(average_score)
```

---

## 21. Evaluation Pipeline Architecture

```text
                    Evaluation Dataset
                           ↓
                    ┌─────────────┐
                    │ LLM System  │
                    └──────┬──────┘
                           ↓
                       Outputs
                           ↓
              ┌────────────┴────────────┐
              ↓                         ↓
       Automated Metrics          LLM Judge
              ↓                         ↓
              └────────────┬────────────┘
                           ↓
                    Human Review
                           ↓
                    Failure Analysis
                           ↓
                    Quality Report
                           ↓
                  Improve System
                           ↓
                    Evaluate Again
```

---

## 22. Important Principle

Do not optimize only for one metric.

Example:

```text
Model A:
Accuracy = 95%
Cost = ₹10/request

Model B:
Accuracy = 93%
Cost = ₹1/request
```

Depending on the application, Model B may be the better engineering choice.

Therefore evaluate:

```text
Quality
+
Safety
+
Latency
+
Cost
+
Reliability
```

---

## 23. What Should Be Stored?

For reproducible evaluation, store:

```text
Model version
Prompt version
Dataset version
Input
Output
Retrieved context
Tool calls
Metrics
Timestamp
```

This allows you to compare different versions accurately.

---

## 24. When Should You Run Evaluation?

Run evaluation:

```text
Before deployment
After prompt changes
After model changes
After RAG changes
After tool changes
After fine-tuning
After major code changes
During production
```

---

## 25. Key Mental Model

```text
Dataset
   ↓
Run System
   ↓
Measure
   ↓
Find Failures
   ↓
Improve
   ↓
Regression Test
   ↓
Deploy
   ↓
Monitor
   ↓
Repeat
```

---

## 26. GATE / Interview Points

* An evaluation pipeline systematically tests an LLM application.
* Start with a representative evaluation dataset.
* Run the actual application on the dataset.
* Collect outputs and relevant traces.
* Choose metrics according to the task.
* LLM-as-a-judge can evaluate open-ended outputs.
* Human evaluation is useful for subjective or high-risk cases.
* Failure analysis identifies the root cause of poor results.
* RAG evaluation should separate retrieval failures from generation failures.
* Agent evaluation should include tool selection, tool arguments and task success.
* Regression testing checks whether a change damages existing capabilities.
* Evaluation can be integrated into CI/CD.
* Production monitoring is required because offline datasets cannot cover every real-world input.
* Evaluate quality together with safety, latency, cost and reliability.

---

## 27. One-Line Revision

> **LLM Evaluation Pipeline = Dataset → Run LLM Application → Measure → Analyze Failures → Improve → Regression Test → Deploy → Monitor → Repeat.**

```
```
