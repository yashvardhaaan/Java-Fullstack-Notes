### `10-LLM-EVALUATION/04-rag-evaluation.md`

````md
# RAG Evaluation

## 1. What is RAG Evaluation?

**RAG evaluation** measures how well a Retrieval-Augmented Generation system:

1. Retrieves the right information
2. Uses that information correctly
3. Produces a relevant and accurate answer

```text
Question
   ↓
Retriever
   ↓
Retrieved Documents
   ↓
LLM
   ↓
Answer
   ↓
Evaluation
````

RAG evaluation should therefore evaluate both:

```text
Retrieval Quality + Generation Quality
```

---

## 2. Why Do We Need RAG Evaluation?

A RAG system can fail in multiple places.

### Failure 1: Wrong Retrieval

```text
Question
 ↓
Retriever
 ↓
Wrong documents
 ↓
LLM
 ↓
Wrong answer
```

### Failure 2: Correct Retrieval, Wrong Answer

```text
Question
 ↓
Correct documents
 ↓
LLM ignores/misinterprets context
 ↓
Wrong answer
```

### Failure 3: Irrelevant Context

```text
Question
 ↓
Retriever
 ↓
Too much irrelevant information
 ↓
LLM
 ↓
Poor answer
```

Therefore, testing only the final answer is not enough.

---

## 3. RAG Evaluation Pipeline

```text
                  Question
                     ↓
                Retriever
                     ↓
             Retrieved Context
                     ↓
                     LLM
                     ↓
                  Answer
                     ↓
              ┌──────┴──────┐
              ↓             ↓
       Retrieval Eval   Generation Eval
```

---

## 4. Main RAG Evaluation Dimensions

Important dimensions include:

```text
Retrieval Quality
Context Relevance
Context Recall
Faithfulness
Answer Relevance
Answer Correctness
```

---

# 5. Context Relevance

## What?

Context relevance measures whether the retrieved documents are relevant to the user's question.

Example:

```text
Question:
"What is the company's leave policy?"

Retrieved:
Document about leave policy
→ Relevant ✓
```

If the system retrieves:

```text
Document about company cafeteria
→ Irrelevant ✗
```

the retrieval system is performing poorly.

---

## Why?

Irrelevant context can confuse the LLM and increase:

* Token usage
* Latency
* Incorrect answers

---

# 6. Context Recall

## What?

Context recall asks:

> Did the retriever find the important information needed to answer the question?

Example:

```text
Question:
"What are the eligibility requirements for the scholarship?"

Required information:
1. GPA requirement
2. Income requirement
3. Application deadline
```

Retrieved context contains:

```text
GPA requirement
Income requirement
```

but misses:

```text
Application deadline
```

Context recall is incomplete.

---

# 7. Precision of Retrieval

Retrieval precision asks:

> Of the retrieved documents, how many are actually relevant?

Example:

```text
Retrieved documents = 10
Relevant documents = 8

Precision = 8 / 10
          = 80%
```

High precision means less irrelevant context.

---

# 8. Recall of Retrieval

Retrieval recall asks:

> Of all relevant documents, how many did we retrieve?

Example:

```text
Relevant documents = 10
Retrieved relevant documents = 7

Recall = 7 / 10
       = 70%
```

High recall means fewer useful documents are missed.

---

# 9. Precision vs Recall

Remember:

```text
Precision:
"Are the retrieved documents relevant?"

Recall:
"Did we retrieve the important documents?"
```

Example:

```text
100 documents
 ↓
Retriever selects 10
 ↓
8 are relevant
```

Then:

```text
Precision = 8/10 = 80%
```

If there are 20 relevant documents overall:

```text
Recall = 8/20 = 40%
```

---

# 10. Faithfulness

## What?

**Faithfulness** checks whether the generated answer is supported by the retrieved context.

Example:

```text
Context:
"The company provides 20 vacation days."

Answer:
"Employees receive 20 vacation days."

→ Faithful ✓
```

But:

```text
Context:
"The company provides 20 vacation days."

Answer:
"Employees receive 30 vacation days."

→ Not faithful ✗
```

---

# 11. Answer Relevance

Answer relevance checks:

> Does the answer actually address the user's question?

Example:

```text
Question:
"What is the company's leave policy?"

Good:
"The company provides 20 paid vacation days."

Poor:
"The company was founded in 1998."
```

The second statement might be factually correct but is irrelevant.

---

# 12. Answer Correctness

Answer correctness checks whether the final answer is actually correct.

Example:

```text
Expected:
20 vacation days

Generated:
20 vacation days

→ Correct ✓
```

Incorrect:

```text
Expected:
20 vacation days

Generated:
30 vacation days

→ Incorrect ✗
```

Correctness can be evaluated using:

* Reference answers
* Ground-truth data
* Human evaluation
* LLM-as-a-judge

---

# 13. Faithfulness vs Correctness

These are not exactly the same.

### Faithfulness

Is the answer supported by the retrieved context?

### Correctness

Is the answer actually correct?

Example:

```text
Actual fact:
20 vacation days

Retrieved document:
Incorrectly says 30 days

LLM:
"Employees get 30 days."
```

The answer may be:

```text
Faithful to retrieved context → Yes
Actually correct             → No
```

This distinction is extremely important in RAG evaluation.

---

# 14. Retrieval Failure vs Generation Failure

### Retrieval Failure

```text
Question
 ↓
Retriever
 ↓
Wrong / Missing Context
 ↓
LLM
```

Problem is primarily in retrieval.

### Generation Failure

```text
Question
 ↓
Retriever
 ↓
Correct Context
 ↓
LLM
 ↓
Wrong Answer
```

Problem is primarily in generation.

This separation helps debugging.

---

# 15. Top-K Evaluation

RAG retrievers often return the top `K` documents.

Example:

```python
results = retriever.search(
    query,
    top_k=5
)
```

Evaluation can compare:

```text
Top-1
Top-3
Top-5
Top-10
```

Increasing `K` may improve recall but can also introduce more irrelevant context.

Therefore:

```text
Higher K ≠ Always Better
```

---

# 16. MRR

**Mean Reciprocal Rank (MRR)** measures how high the first relevant result appears.

For one query:

```text
Relevant document at rank 1

RR = 1/1 = 1
```

If the first relevant document is at rank 4:

```text
RR = 1/4 = 0.25
```

For multiple queries:

```text
MRR = Average Reciprocal Rank
```

Higher MRR means relevant results tend to appear earlier.

---

# 17. Recall@K

**Recall@K** measures how many relevant items are retrieved within the top K results.

Example:

```text
Relevant documents = 5

Top-10 retrieval:
4 relevant documents found
```

Then:

```text
Recall@10 = 4/5 = 80%
```

Useful for evaluating retrievers.

---

# 18. RAG Evaluation Example

Suppose:

```text
Question:
"What is the company's leave policy?"
```

Retriever returns:

```text
Document 1 → Leave policy ✓
Document 2 → Salary policy
Document 3 → Office timings
Document 4 → Leave policy ✓
```

Evaluation:

```text
Context relevance → Good
Retrieval precision → 2/4 = 50%
```

LLM produces:

```text
"Employees receive 20 paid vacation days."
```

If the retrieved document supports this:

```text
Faithfulness → ✓
Answer relevance → ✓
```

If the ground truth is also 20 days:

```text
Answer correctness → ✓
```

---

# 19. RAG Evaluation Workflow

```text
Test Questions
      ↓
Run Retriever
      ↓
Evaluate Retrieved Documents
      ↓
Run LLM
      ↓
Evaluate Generated Answers
      ↓
Analyze Failures
      ↓
Improve Retriever / Prompt / Model
      ↓
Evaluate Again
```

---

# 20. What to Improve Based on Failure?

### Low Retrieval Recall

Try:

```text
Better embeddings
Better chunking
Hybrid search
Query rewriting
Increase K
Better metadata filtering
```

### Low Retrieval Precision

Try:

```text
Better ranking
Smaller K
Reranking
Better filters
Better chunking
```

### Low Faithfulness

Try:

```text
Better context
Stronger grounding instructions
Citations
Output validation
Better model
```

### Low Answer Relevance

Try:

```text
Better prompt
Better context
Query understanding
Output formatting
```

---

# 21. Practical RAG Evaluation Example

```python
def evaluate_rag(question, expected_answer):

    documents = retriever.search(question, top_k=5)

    context = "\n".join(documents)

    answer = llm.generate(
        f"""
        Answer using only the following context:

        {context}

        Question:
        {question}
        """
    )

    return {
        "question": question,
        "answer": answer,
        "documents": documents,
        "expected": expected_answer
    }
```

Then evaluate:

```text
Retrieved Documents
        ↓
Retrieval Metrics

Generated Answer
        ↓
Faithfulness
Relevance
Correctness
```

---

# 22. RAG Evaluation Dataset

A useful evaluation dataset can contain:

```python
evaluation_data = [
    {
        "question": "What is the leave policy?",
        "expected_answer": "20 paid vacation days",
        "relevant_documents": ["leave_policy.pdf"]
    }
]
```

This gives you a reference for both:

```text
Retrieval
+
Generation
```

---

# 23. Important Principle

Do not evaluate only:

```text
"Is the final answer good?"
```

Instead ask:

```text
1. Did we retrieve the right information?
2. Did we retrieve enough information?
3. Was the context relevant?
4. Did the LLM stay grounded in the context?
5. Is the final answer correct?
6. Is the answer relevant?
```

This makes debugging much easier.

---

# 24. Key Mental Model

```text
                 RAG
                  ↓
        ┌─────────┴─────────┐
        ↓                   ↓
   Retrieval             Generation
        ↓                   ↓
 Precision              Faithfulness
 Recall                 Relevance
 MRR                    Correctness
 Recall@K
```

Remember:

> **Good RAG = Retrieve the right information + Generate an answer supported by that information.**

---

# 25. GATE / Interview Points

* RAG evaluation must evaluate both retrieval and generation.
* Retrieval precision measures how many retrieved documents are relevant.
* Retrieval recall measures how many relevant documents were retrieved.
* Recall@K evaluates retrieval performance within the top K results.
* MRR rewards relevant documents appearing near the top of the ranking.
* Context relevance checks whether retrieved information is useful for the query.
* Faithfulness checks whether the generated answer is supported by retrieved context.
* Answer correctness checks whether the final answer is actually correct.
* Faithfulness and correctness are different.
* Retrieval failure and generation failure should be diagnosed separately.
* Increasing `K` can improve recall but may add irrelevant context.
* RAG evaluation datasets should contain representative questions and, where possible, ground-truth answers/relevant documents.
* Improving RAG may require better chunking, embeddings, retrieval, reranking, prompting or generation.

---

# 26. One-Line Revision

> **RAG Evaluation = Measure retrieval quality (precision/recall/ranking) + generation quality (faithfulness/relevance/correctness) to find where the RAG pipeline fails.**

```
```
