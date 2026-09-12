### `10-LLM-EVALUATION/02-evaluation-metrics.md`

````md id="4j5m1a"
# Evaluation Metrics

## 1. What are Evaluation Metrics?

**Evaluation metrics** are measurable values used to determine how well an LLM or LLM application performs.

Example:

```text
100 test questions
      ↓
LLM
      ↓
90 correct answers
      ↓
Accuracy = 90%
````

Different tasks require different metrics.

---

## 2. Why Do We Need Different Metrics?

There is no single metric that works well for every LLM task.

Example:

```text
Classification → Accuracy / Precision / Recall / F1
Text Generation → BLEU / ROUGE
RAG → Faithfulness / Context Relevance
LLM Chat → Helpfulness / Relevance / Correctness
Production → Latency / Cost / Error Rate
```

---

## 3. Accuracy

**Accuracy** measures the percentage of predictions that are correct.

Formula:

```text
Accuracy = Correct Predictions / Total Predictions
```

Example:

```text
100 questions
90 correct

Accuracy = 90 / 100
         = 90%
```

Best suited for:

* Classification
* Multiple-choice tasks
* Exact-answer tasks

Problem:

Accuracy may not work well for open-ended answers.

---

## 4. Precision

**Precision** answers:

> Of everything the model predicted as positive, how much was actually positive?

Formula:

```text
Precision = TP / (TP + FP)
```

Where:

```text
TP = True Positive
FP = False Positive
```

Example:

```text
Model marked 20 emails as spam.

15 were actually spam.

Precision = 15 / 20
          = 75%
```

High precision means fewer false positives.

---

## 5. Recall

**Recall** answers:

> Of all actual positive cases, how many did the model find?

Formula:

```text
Recall = TP / (TP + FN)
```

Where:

```text
FN = False Negative
```

Example:

```text
100 actual spam emails
Model detected 80

Recall = 80 / 100
       = 80%
```

High recall means fewer important cases are missed.

---

## 6. F1 Score

F1 combines precision and recall.

Formula:

```text
F1 = 2 × (Precision × Recall)
       / (Precision + Recall)
```

Example:

```text
Precision = 0.80
Recall    = 0.60

F1 = 2 × (0.80 × 0.60) / (0.80 + 0.60)
   ≈ 0.686
```

F1 is useful when both false positives and false negatives matter.

---

## 7. Precision vs Recall

Remember:

```text
Precision → Don't make too many false positive predictions.

Recall → Don't miss too many actual positive cases.
```

Example:

```text
Medical screening:
High recall may be important
because missing a real case can be costly.

Spam filtering:
High precision may be important
because legitimate emails should not be marked as spam.
```

---

## 8. BLEU

**BLEU (Bilingual Evaluation Understudy)** measures similarity between generated text and reference text, mainly using n-gram overlap.

Example:

```text
Reference:
"The cat is sitting on the mat."

Generated:
"The cat sits on the mat."
```

BLEU checks overlapping word sequences.

Commonly associated with:

* Machine translation
* Text generation evaluation

Limitation:

> Similar wording does not always mean the answer is semantically correct.

---

## 9. ROUGE

**ROUGE (Recall-Oriented Understudy for Gisting Evaluation)** measures overlap between generated text and reference text.

Common variants:

```text
ROUGE-1 → Unigram overlap
ROUGE-2 → Bigram overlap
ROUGE-L → Longest common subsequence
```

Commonly used for:

* Summarization
* Text generation

Example:

```text
Reference:
"Python is a programming language."

Generated:
"Python is a popular programming language."

High word overlap → relatively high ROUGE
```

---

## 10. BLEU vs ROUGE

| BLEU                                   | ROUGE                                  |
| -------------------------------------- | -------------------------------------- |
| Precision-oriented                     | Recall-oriented                        |
| Common in translation                  | Common in summarization                |
| Measures n-gram overlap                | Measures n-gram/LCS overlap            |
| Compares generated text with reference | Compares generated text with reference |

Important:

> Both are lexical-overlap metrics and may not fully capture meaning.

---

## 11. Semantic Similarity

Two answers can use different words but have the same meaning.

Example:

```text
Answer A:
"Python is a programming language."

Answer B:
"Python is a language used to write computer programs."
```

Word overlap may be different, but semantic meaning is similar.

Embedding-based evaluation can measure semantic similarity.

```text
Text
 ↓
Embedding Model
 ↓
Vector
 ↓
Similarity
```

A common measure is **cosine similarity**.

---

## 12. Cosine Similarity

Cosine similarity measures the angle between two vectors.

Formula:

```text
cos(θ) = (A · B) / (||A|| ||B||)
```

Typical interpretation:

```text
+1 → Very similar direction
 0 → Unrelated/orthogonal
-1 → Opposite direction
```

For embedding-based text comparison, higher cosine similarity generally indicates greater semantic similarity.

---

## 13. Faithfulness

**Faithfulness** checks whether an answer is supported by the provided context.

This is especially important in RAG.

Example:

```text
Context:
"The company has 500 employees."

Answer:
"The company has 500 employees."

Faithful → ✓
```

If the answer says:

```text
"The company has 5,000 employees."

Faithful → ✗
```

The answer may sound reasonable but is unsupported by the context.

---

## 14. Relevance

**Relevance** measures whether the response actually addresses the user's question.

Example:

```text
Question:
"What is recursion?"

Relevant:
"Recursion is a technique where a function calls itself."

Irrelevant:
"Python was created by Guido van Rossum."
```

A response can be factually correct but still irrelevant.

---

## 15. Helpfulness

**Helpfulness** measures whether the answer is useful for accomplishing the user's goal.

Example:

```text
User:
"How do I fix a Python IndexError?"

Poor:
"IndexError is an exception."

Better:
"Check whether the index is within the list length..."
```

Helpfulness is often evaluated using human ratings or an LLM judge.

---

## 16. Hallucination Rate

A hallucination occurs when an LLM generates information that is false or unsupported.

Example:

```text
Question:
"Who invented X?"

LLM:
Invented by John Smith in 1982.

Actual:
No evidence for this claim.
```

A system can track:

```text
Hallucinated Responses
----------------------
Total Evaluated Responses
```

Lower hallucination is generally better.

---

## 17. Tool-Calling Metrics

For agents, evaluate tool behavior.

Important metrics include:

```text
Tool selection accuracy
Argument accuracy
Tool success rate
Task completion rate
Number of tool calls
```

Example:

```text
100 tool calls
95 correctly selected tools

Tool Selection Accuracy = 95%
```

---

## 18. Task Success Rate

For agentic applications, an important metric is:

```text
Task Success Rate =
Successfully Completed Tasks
---------------------------
Total Tasks
```

Example:

```text
100 tasks
85 completed successfully

Task Success Rate = 85%
```

This can be more meaningful than evaluating only the final text.

---

## 19. Latency

**Latency** is the time taken to produce a response.

Example:

```text
Request → 1.8 seconds → Response
```

Important measurements:

```text
Time to First Token (TTFT)
Total response time
Tool latency
Retrieval latency
```

For interactive applications, lower latency is usually desirable.

---

## 20. Cost

LLM applications also need cost metrics.

Example:

```text
Input tokens
+
Output tokens
+
Tool/API costs
```

A system might be:

```text
Quality = 95%
Cost = ₹10/request
```

Another:

```text
Quality = 94%
Cost = ₹2/request
```

The second system may be preferable depending on requirements.

---

## 21. Evaluation Metrics by Application

| Application    | Useful Metrics                             |
| -------------- | ------------------------------------------ |
| Classification | Accuracy, Precision, Recall, F1            |
| Translation    | BLEU, semantic similarity                  |
| Summarization  | ROUGE, factuality                          |
| RAG            | Faithfulness, relevance, retrieval quality |
| Chatbot        | Helpfulness, correctness, relevance        |
| Agent          | Task success, tool accuracy, steps         |
| Production     | Latency, cost, error rate                  |

---

## 22. Metric ≠ Evaluation Method

Do not confuse these concepts.

### Metric

What are we measuring?

```text
Accuracy
F1
Latency
Faithfulness
Cost
```

### Evaluation Method

How are we measuring it?

```text
Human evaluation
Automated evaluation
LLM-as-a-judge
Reference-based evaluation
```

Think:

```text
Metric = What?

Method = How?
```

---

## 23. Practical Evaluation Pipeline

```text
Test Dataset
     ↓
Run LLM
     ↓
Collect Outputs
     ↓
Calculate Metrics
     ↓
Analyze Failures
     ↓
Improve System
     ↓
Run Evaluation Again
```

Example:

```text
Version A:
Accuracy = 88%

Version B:
Accuracy = 93%

Version B appears better.
```

But also check:

```text
Safety
Latency
Cost
Hallucination
```

A higher accuracy alone does not guarantee a better production system.

---

## 24. Key Mental Model

```text
Task
 ↓
Choose appropriate metric
 ↓
Evaluate
 ↓
Find weaknesses
 ↓
Improve
 ↓
Evaluate again
```

The metric must match the actual goal of the application.

---

## 25. GATE / Interview Points

* Accuracy = correct predictions / total predictions.
* Precision focuses on false positives.
* Recall focuses on false negatives.
* F1 is the harmonic mean of precision and recall.
* BLEU is commonly used for machine translation.
* ROUGE is commonly used for summarization.
* BLEU/ROUGE rely heavily on text overlap and may not capture semantic meaning completely.
* Cosine similarity can compare embedding vectors.
* Faithfulness checks whether an answer is supported by provided context.
* Relevance checks whether the answer addresses the question.
* Agent evaluation should include task success and tool behavior.
* Latency and cost are important production metrics.
* No single metric is sufficient for evaluating all LLM applications.

---

## 26. One-Line Revision

> **Evaluation Metrics = Quantitative measures such as Accuracy, F1, ROUGE, Faithfulness, Task Success, Latency and Cost used to determine how well an LLM system performs.**

```
```
