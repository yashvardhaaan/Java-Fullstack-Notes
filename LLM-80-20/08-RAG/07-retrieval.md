# Retrieval

## 1. What is retrieval?

**Retrieval** is the process of finding and selecting information from a knowledge base that is relevant to a user's question.

In RAG:

```text
User Question
      ↓
    Query
      ↓
   Retrieval
      ↓
Relevant Chunks
      ↓
     LLM
      ↓
   Answer
```

The fundamental purpose of retrieval is:

> **Give the LLM the right information before asking it to generate an answer.**

---

# 2. Why is retrieval important?

Imagine your knowledge base contains:

```text
100,000 document chunks
```

The user asks:

> "How do I reset my company password?"

You cannot realistically give all 100,000 chunks to the LLM.

Instead:

```text
100,000 chunks
      ↓
   Retrieval
      ↓
   20 relevant candidates
      ↓
   Reranking
      ↓
   5 best chunks
      ↓
      LLM
```

Therefore:

> **Retrieval reduces a huge knowledge base into a small amount of useful context.**

---

# 3. Retrieval is more than vector search

This distinction is important.

A beginner often thinks:

```text
RAG Retrieval = Vector Search
```

But retrieval is broader.

A retriever can use:

```text
Vector Search
Keyword Search
Metadata Filtering
Hybrid Search
Query Rewriting
Query Expansion
Reranking
Access Control
```

Conceptually:

```text
                  RETRIEVAL
                      │
       ┌──────────────┼──────────────┐
       ▼              ▼              ▼
 Vector Search   Keyword Search   Filters
       │              │              │
       └──────────────┼──────────────┘
                      ▼
                  Candidates
                      │
                      ▼
                  Reranking
                      │
                      ▼
               Relevant Context
```

---

# 4. Basic retrieval pipeline

The simplest RAG retriever looks like:

```text
User Question
      ↓
Embedding
      ↓
Vector Search
      ↓
Top-K Chunks
      ↓
LLM
```

Example:

```text
Question:
"How many annual leave days do employees get?"

        ↓

Query Embedding

        ↓

Vector Search

        ↓

Chunk 23
Chunk 87
Chunk 102
Chunk 456

        ↓

LLM
```

---

# 5. Retrieval starts with the query

The quality of retrieval depends heavily on the quality of the user's query.

Consider:

```text
"what about that?"
```

A vector search system may not know what "that" means.

But:

```text
"How many days of annual leave can a full-time employee take?"
```

contains much more useful information.

Therefore, modern RAG systems may perform **query transformation** before retrieval.

---

# 6. Query transformation

**Query transformation** means changing the user's original query into a form that is easier to retrieve against.

Example:

```text
User:
"What about parental leave?"
```

The application may transform it into:

```text
"What is the company's parental leave policy for employees?"
```

Then:

```text
Original Query
      ↓
Query Transformation
      ↓
Improved Query
      ↓
Retrieval
```

This can improve retrieval quality.

---

# 7. Query rewriting

Query rewriting creates a better search query from the user's original question.

Example:

```text
Original:
"How does it work?"

Rewritten:
"How does JWT authentication work in the company's API?"
```

This is especially useful in conversational systems.

Example:

```text
User:
"What is JWT?"

Assistant:
"JWT is a token format..."

User:
"How does it expire?"
```

The second question is ambiguous by itself.

A query rewriter can transform:

```text
"How does it expire?"
```

into:

```text
"How does a JWT token expire?"
```

Then retrieval becomes much more effective.

---

# 8. Query expansion

Sometimes one query can be expanded into multiple related queries.

For example:

```text
Original:
"How do I fix login problems?"
```

Could become:

```text
Query 1:
"How do I troubleshoot login failures?"

Query 2:
"What causes authentication errors?"

Query 3:
"How do I troubleshoot password authentication?"
```

Each query can retrieve different relevant chunks.

The results can then be combined.

```text
             Original Query
                   ↓
             Query Expansion
              /     |      \
             ↓      ↓       ↓
          Search  Search   Search
             \      |       /
              \     |      /
               ↓    ↓     ↓
              Combined Results
```

This can increase recall.

---

# 9. Multi-query retrieval

Multi-query retrieval is closely related to query expansion.

Suppose the user asks:

> "What are the requirements for deploying the application?"

The system could generate:

```text
Query 1:
"Application deployment requirements"

Query 2:
"Production deployment prerequisites"

Query 3:
"Required infrastructure for deployment"
```

Then:

```text
Query 1 → Results A
Query 2 → Results B
Query 3 → Results C

A + B + C
    ↓
Deduplicate
    ↓
Rerank
    ↓
Final Context
```

This can find information that a single query might miss.

---

# 10. Retrieval recall

One of the most important retrieval concepts is **recall**.

Suppose the knowledge base contains three chunks that are relevant:

```text
A
B
C
```

Your retriever returns:

```text
A
B
D
E
```

You found:

```text
A
B
```

but missed:

```text
C
```

Retrieval recall asks:

> **How much of the relevant information did we successfully retrieve?**

Conceptually:

```text
Relevant chunks retrieved
───────────────────────────
All relevant chunks
```

High recall means the system is less likely to miss useful information.

---

# 11. Retrieval precision

Precision asks a different question:

> **How much of what we retrieved was actually relevant?**

Suppose:

```text
Retrieved:
A
B
C
D
E

Relevant:
A
B
```

Then:

```text
Relevant retrieved
───────────────────
All retrieved
```

gives retrieval precision.

A good retriever tries to balance:

```text
Recall
+
Precision
```

---

# 12. Recall vs precision

Think of it this way:

### High recall

```text
Find almost everything relevant
```

But you may also retrieve lots of irrelevant information.

### High precision

```text
Most retrieved results are relevant
```

But you might miss some useful information.

In RAG:

```text
Too little retrieval
      ↓
Miss important information

Too much retrieval
      ↓
Add irrelevant context
```

The goal is useful context.

---

# 13. Top-K retrieval

A retriever commonly uses `K`.

Example:

```text
top_k = 10
```

means:

```text
Search
  ↓
10 candidate chunks
```

But the `K` used during initial retrieval doesn't necessarily equal the final number of chunks sent to the LLM.

A common architecture is:

```text
Vector Search
    ↓
Top 50
    ↓
Reranker
    ↓
Top 5
    ↓
LLM
```

This allows broad candidate retrieval followed by more precise selection.

---

# 14. Retrieval threshold

You can also use a relevance threshold.

Conceptually:

```text
Retrieve candidates
      ↓
Score
      ↓
Remove results below threshold
```

For example:

```text
Chunk A → high
Chunk B → high
Chunk C → medium
Chunk D → very low
```

You might remove D.

But thresholds should be determined experimentally because similarity scores aren't universal confidence values.

---

# 15. Metadata filtering

Retrieval can use metadata to narrow the search.

Suppose your knowledge base contains:

```text
HR
Engineering
Finance
Legal
```

User asks:

> "What is the 2026 HR leave policy?"

Instead of:

```text
Search all documents
```

you can apply:

```text
department = HR
year = 2026
```

then search.

```text
All Documents
      ↓
Metadata Filter
      ↓
HR + 2026
      ↓
Vector Search
      ↓
Relevant Chunks
```

This is especially important in enterprise RAG.

---

# 16. Access-controlled retrieval

Imagine your system contains:

```text
Public Documents
Employee Documents
Manager Documents
Admin Documents
```

A user should only retrieve documents they are authorized to access.

Therefore retrieval should consider permissions.

```text
User
 ↓
Identity
 ↓
Authorization Rules
 ↓
Allowed Documents
 ↓
Retrieval
 ↓
Relevant Chunks
```

This is critical in enterprise systems.

Never rely on the LLM itself to decide whether a user is authorized to see a document.

---

# 17. Hybrid retrieval

Pure vector search isn't always enough.

Consider:

```text
"ERR_CONNECTION_RESET_1024"
```

Keyword search is excellent for exact identifiers.

Semantic search is excellent for conceptual queries such as:

```text
"Why does my network connection keep resetting?"
```

Therefore:

```text
                 Query
                   │
          ┌────────┴────────┐
          ▼                 ▼
   Keyword Search      Vector Search
          │                 │
          └────────┬────────┘
                   ▼
              Merge Results
                   ↓
               Reranking
                   ↓
              Final Context
```

This is called **hybrid retrieval/search**.

---

# 18. Reranking

Retrieval often happens in two stages.

### Stage 1 — Candidate retrieval

Fast search:

```text
100,000 chunks
      ↓
Top 50
```

### Stage 2 — Reranking

More detailed relevance evaluation:

```text
50 candidates
      ↓
Reranker
      ↓
Top 5
```

Therefore:

```text
Retriever
→ Finds candidates

Reranker
→ Determines which candidates are most relevant
```

You will study reranking in:

```text
08-reranking.md
```

---

# 19. Why retrieval can fail

Retrieval can fail even if the LLM is excellent.

### Failure 1 — Bad chunking

```text
Relevant information
      ↓
Split incorrectly
      ↓
Retriever cannot find complete context
```

### Failure 2 — Poor embeddings

The embedding model doesn't represent the meaning well enough.

### Failure 3 — Poor query

The user's question is ambiguous.

### Failure 4 — Wrong metadata filter

You accidentally exclude the correct document.

### Failure 5 — Keyword mismatch

The user uses different words from the document.

### Failure 6 — Missing information

The knowledge base simply doesn't contain the answer.

### Failure 7 — Too much noise

The retriever returns too many irrelevant chunks.

---

# 20. Retrieval failure vs generation failure

This distinction is extremely important for debugging RAG.

Suppose the final answer is wrong.

There are two major possibilities.

### Retrieval failure

The correct information was never given to the LLM.

```text
Question
   ↓
Bad Retrieval
   ↓
Wrong Context
   ↓
LLM
   ↓
Wrong Answer
```

### Generation failure

The correct information was retrieved, but the LLM produced the wrong answer.

```text
Question
   ↓
Correct Retrieval
   ↓
Correct Context
   ↓
LLM misunderstands
   ↓
Wrong Answer
```

This distinction helps you debug the system.

---

# 21. How to debug retrieval

Suppose the user asks:

> "How many days of parental leave are available?"

The final answer is incorrect.

Don't immediately change the LLM.

First inspect:

```text
1. What was the original query?
2. What query was actually searched?
3. What chunks were retrieved?
4. What were their scores?
5. Were the correct chunks present?
6. Were metadata filters applied?
7. Did reranking remove the correct chunk?
8. Was the correct context sent to the LLM?
```

This gives you a systematic debugging process.

---

# 22. Retrieval observability

A production RAG system should log retrieval information.

For example:

```text
query:
"How many parental leave days?"

retrieved_chunks:
[
    {
        id: "chunk-102",
        score: 0.91,
        document: "leave-policy.pdf"
    },
    {
        id: "chunk-204",
        score: 0.87,
        document: "employee-handbook.pdf"
    }
]
```

This allows developers to investigate why an answer was generated.

---

# 23. Retrieval evaluation

Create a test dataset.

```text
Question
   ↓
Expected Relevant Documents
```

Example:

```text
Question:
"What is the parental leave policy?"

Expected:
leave-policy.pdf
```

Run retrieval.

```text
Retrieved:
leave-policy.pdf
employee-handbook.pdf
holiday-policy.pdf
```

Now measure:

```text
Did we retrieve the correct document?
How many relevant chunks were found?
How many irrelevant chunks were returned?
```

This is much better than manually testing one question.

---

# 24. Retrieval metrics

You should know these concepts:

### Recall@K

How often is the relevant information found within the top K results?

```text
Recall@5
```

means:

> Was the relevant information found within the top 5 results?

---

### Precision@K

How many of the top K results are relevant?

```text
Precision@5
```

asks:

> How many of the first 5 results were actually relevant?

---

### MRR

**Mean Reciprocal Rank** considers where the first relevant result appears.

Example:

```text
Result 1 → irrelevant
Result 2 → irrelevant
Result 3 → relevant
```

The relevant result appears at position 3.

A higher-ranked relevant result produces a better reciprocal-rank score.

You don't need to memorize the formula initially.

Understand what it measures:

> **How early does the system retrieve a relevant result?**

---

# 25. Query routing

Not every question should use the same retrieval mechanism.

Suppose your system contains:

```text
Company Documents
SQL Database
External APIs
```

The question:

> "What is the leave policy?"

might use:

```text
RAG
```

The question:

> "What is customer 1024's current balance?"

might use:

```text
SQL
```

The question:

> "What is today's exchange rate?"

might use:

```text
External API
```

Therefore:

```text
                     User Query
                         ↓
                    Query Router
                ┌────────┼────────┐
                ▼        ▼        ▼
               RAG      SQL      API
```

This is a powerful pattern for enterprise AI.

---

# 26. Retrieval vs agentic systems

In a simple RAG system:

```text
Question
 ↓
Retrieve
 ↓
LLM
 ↓
Answer
```

In an agentic system:

```text
Question
 ↓
Agent
 ↓
Decide what information is needed
 ↓
Search / SQL / API / Tool
 ↓
Observe result
 ↓
Search again if necessary
 ↓
LLM
 ↓
Answer
```

The retrieval concept remains the same:

> **Find useful information for the current task.**

---

# 27. A practical retrieval architecture

A realistic retrieval pipeline might look like:

```text
                         USER QUERY
                              │
                              ▼
                       Query Rewriting
                              │
                              ▼
                    Metadata / ACL Filter
                              │
                              ▼
                 ┌────────────┴────────────┐
                 ▼                         ▼
          Keyword Search             Vector Search
                 │                         │
                 └────────────┬────────────┘
                              ▼
                         Merge Results
                              │
                              ▼
                         Top-N Candidates
                              │
                              ▼
                           Reranker
                              │
                              ▼
                         Top-K Context
                              │
                              ▼
                             LLM
                              │
                              ▼
                           Answer
```

Not every application needs all of these components.

Start simple:

```text
Query
 ↓
Vector Search
 ↓
Top-K
 ↓
LLM
```

Then add complexity when evaluation shows it is needed.

---

# 28. Retrieval is an information-selection problem

Think of your knowledge base as:

```text
1,000,000 pieces of information
```

The user asks:

```text
"What do I need to deploy this application?"
```

The retrieval system's job is:

```text
1,000,000 pieces
       ↓
Find useful information
       ↓
Remove irrelevant information
       ↓
Rank useful information
       ↓
Provide best context to LLM
```

This is the heart of RAG.

---

# 29. Common mistakes

## Mistake 1 — Assuming vector search is enough

Real retrieval can combine:

```text
Vector
+
Keyword
+
Metadata
+
Query transformation
+
Reranking
```

---

## Mistake 2 — Sending too many chunks to the LLM

More context isn't automatically better.

```text
More context
    ≠
Better answer
```

---

## Mistake 3 — Ignoring query quality

A bad query can produce bad retrieval.

---

## Mistake 4 — Ignoring permissions

Users should retrieve only information they are authorized to access.

---

## Mistake 5 — Debugging only the LLM

If the answer is wrong:

```text
Check retrieval first.
```

---

## Mistake 6 — Not evaluating retrieval independently

You should be able to determine:

```text
Did retrieval fail?
or
Did generation fail?
```

---

# 30. What you should remember

The simplest mental model:

```text
                    USER
                     │
                     ▼
                  QUESTION
                     │
                     ▼
             QUERY PROCESSING
                     │
                     ▼
                 RETRIEVAL
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
       Vector     Keyword    Metadata
       Search     Search      Filter
          │          │          │
          └──────────┼──────────┘
                     ▼
                 Candidates
                     │
                     ▼
                 Reranking
                     │
                     ▼
              Relevant Context
                     │
                     ▼
                    LLM
                     │
                     ▼
                  ANSWER
```

Remember these distinctions:

```text
Similarity Search
→ Finds similar vectors

Retrieval
→ Finds useful information

Reranking
→ Improves ordering/selection

LLM
→ Generates the response
```

---

# 31. Interview questions

You should be able to answer:

1. What is retrieval in RAG?
2. Why is retrieval necessary?
3. Is retrieval the same as vector search?
4. What is query transformation?
5. What is query rewriting?
6. What is query expansion?
7. What is multi-query retrieval?
8. What is Top-K retrieval?
9. What is a similarity threshold?
10. What is hybrid retrieval?
11. Why is metadata filtering useful?
12. How does access control affect retrieval?
13. What is retrieval precision?
14. What is retrieval recall?
15. What is Recall@K?
16. What is Precision@K?
17. What is MRR?
18. How would you debug a RAG system that gives an incorrect answer?
19. How do you distinguish retrieval failure from generation failure?
20. Why isn't retrieving more chunks always better?
21. What is query routing?
22. When would you use SQL instead of RAG?
23. How can retrieval be evaluated?
24. How can retrieval quality be improved?

---

# 32. Final mental model

```text
                    KNOWLEDGE BASE
                          │
                          │
                          ▼
                    ┌───────────┐
                    │ Retrieval │
                    └─────┬─────┘
                          │
             ┌────────────┼────────────┐
             ▼            ▼            ▼
          Semantic      Keyword      Metadata
           Search       Search        Filter
             │            │            │
             └────────────┼────────────┘
                          ▼
                     Candidates
                          │
                          ▼
                      Reranking
                          │
                          ▼
                   Relevant Context
                          │
                          ▼
                         LLM
                          │
                          ▼
                       ANSWER
```

**Core idea:**

> **Retrieval is the process of selecting the right information from your knowledge base so the LLM has the evidence it needs to answer the user's question.**

Next: **`08-reranking.md`**.
