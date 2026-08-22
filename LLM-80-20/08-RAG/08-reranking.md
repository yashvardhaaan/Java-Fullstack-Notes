# Reranking

## 1. What is reranking?

**Reranking** is the process of taking an initial set of retrieved documents and reordering them based on how relevant they are to the user's specific question.

The basic idea is:

```text
Knowledge Base
      ↓
Initial Retrieval
      ↓
Many Candidate Chunks
      ↓
Reranker
      ↓
Best Chunks
      ↓
LLM
```

The important distinction is:

> **Retrieval finds possible candidates; reranking determines which candidates are most relevant.**

---

# 2. Why do we need reranking?

Suppose your knowledge base contains:

```text
100,000 chunks
```

The user asks:

> "How do I reset my company password?"

Your vector search might retrieve:

```text
Chunk A → Password security
Chunk B → Password reset instructions
Chunk C → Account security
Chunk D → Authentication
Chunk E → Company security policy
```

All five may be semantically related.

But:

```text
Chunk B
```

may contain the exact instructions the user needs.

Reranking helps identify this.

```text
Initial Search
      ↓
A
B
C
D
E
      ↓
Reranker
      ↓
B
A
C
E
D
```

---

# 3. Retrieval vs reranking

This distinction is extremely important.

### Retrieval

Usually optimized for:

```text
Speed + broad candidate discovery
```

Example:

```text
100,000 chunks
      ↓
Vector Search
      ↓
Top 50
```

### Reranking

Usually optimized for:

```text
Relevance + precise ordering
```

Example:

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
→ "Which documents might be relevant?"

Reranker
→ "Which of these are actually the most relevant?"
```

---

# 4. The two-stage retrieval architecture

A common RAG architecture is:

```text
                    USER QUERY
                         │
                         ▼
                  Query Embedding
                         │
                         ▼
                 Initial Retrieval
                         │
                         ▼
                  Top 20 / 50 / 100
                         │
                         ▼
                     Reranker
                         │
                         ▼
                     Top 3 / 5
                         │
                         ▼
                       LLM
                         │
                         ▼
                      Answer
```

This is called **two-stage retrieval**.

---

# 5. Why not use the reranker on the entire database?

Suppose:

```text
1,000,000 chunks
```

If a powerful reranker evaluates every chunk:

```text
1,000,000
      ↓
Reranker
      ↓
Very expensive
Very slow
```

Instead:

```text
1,000,000 chunks
      ↓
Fast Retriever
      ↓
50 candidates
      ↓
Reranker
      ↓
5 best
```

The initial retriever reduces the search space.

The reranker performs deeper relevance evaluation on a small set.

---

# 6. What does a reranker actually do?

Suppose the user asks:

```text
"How can I reset my password?"
```

Initial retrieval:

```text
Chunk A:
"Password security requirements..."

Chunk B:
"To reset your password, open Settings..."

Chunk C:
"Authentication uses JWT..."

Chunk D:
"Employees must change passwords every 90 days..."
```

All of them may have reasonable semantic similarity.

A reranker evaluates the **relationship between the exact query and each candidate**.

It might produce:

```text
Chunk B → 0.97
Chunk A → 0.81
Chunk D → 0.74
Chunk C → 0.61
```

The final ordering becomes:

```text
1. Chunk B
2. Chunk A
3. Chunk D
4. Chunk C
```

---

# 7. Why vector similarity alone may not be enough

Vector similarity gives you a useful first approximation.

But semantic similarity doesn't necessarily mean:

> "This chunk directly answers the question."

Example:

```text
Question:
"How do I reset my password?"
```

Two retrieved chunks:

```text
Chunk A:
"Passwords are an important part of account security."

Chunk B:
"Go to Settings → Security → Reset Password."
```

Both are about passwords.

But Chunk B is much more relevant.

A reranker can distinguish between:

```text
Related to the topic
```

and:

```text
Directly relevant to the question
```

---

# 8. Cross-encoder reranking

One common reranking approach uses a **cross-encoder**.

Instead of independently embedding the query and document:

```text
Query
 ↓
Embedding

Document
 ↓
Embedding

Compare vectors
```

a cross-encoder considers the query and candidate together.

Conceptually:

```text
Query + Document
       ↓
  Cross-Encoder
       ↓
 Relevance Score
```

Example:

```text
Query:
"How do I reset my password?"

Candidate:
"Users can reset passwords from Settings → Security."

        ↓

     Reranker

        ↓

Relevance = High
```

This allows the model to examine the relationship between the two texts more deeply.

---

# 9. Bi-encoder vs cross-encoder

This distinction is useful for understanding why RAG often uses two stages.

### Bi-encoder / embedding model

The query and document are encoded separately.

```text
Query
 ↓
Vector A

Document
 ↓
Vector B

A ↔ B
```

This is efficient because document embeddings can be created ahead of time.

### Cross-encoder

The query and document are evaluated together.

```text
Query
   +
Document
   ↓
Cross-Encoder
   ↓
Relevance Score
```

This can be more precise but is more computationally expensive.

---

# 10. Why embeddings are fast for retrieval

Suppose you have:

```text
1 million document chunks
```

You can precompute:

```text
Document 1 → Embedding
Document 2 → Embedding
...
Document 1,000,000 → Embedding
```

and store them.

When the user asks a question:

```text
Question
 ↓
Embedding
 ↓
Fast vector search
```

You don't have to run a large model against every document.

This makes candidate retrieval efficient.

---

# 11. Why reranking is slower

A cross-encoder might need to evaluate:

```text
Query + Chunk 1
Query + Chunk 2
Query + Chunk 3
...
```

For many candidates.

Therefore:

```text
100,000 chunks
   ↓
Fast retrieval
   ↓
50 chunks
   ↓
Expensive reranking
   ↓
5 chunks
```

This is the practical trade-off.

---

# 12. Candidate generation

The initial retrieval stage is sometimes called **candidate generation**.

Its job is:

> Find a reasonably broad set of potentially relevant chunks.

For example:

```text
100,000 chunks
      ↓
Candidate Generator
      ↓
Top 50
```

The candidate set should ideally contain the correct information.

If the correct chunk is not retrieved at this stage:

```text
Retriever misses correct chunk
      ↓
Reranker never sees it
      ↓
Reranker cannot recover it
```

This is a critical concept.

---

# 13. Reranking cannot recover missing documents

Suppose the correct answer is in:

```text
Chunk 999
```

But initial retrieval returns:

```text
Chunk 10
Chunk 20
Chunk 30
Chunk 40
Chunk 50
```

The reranker can only reorder:

```text
10, 20, 30, 40, 50
```

It cannot magically discover Chunk 999.

Therefore:

> **The initial retriever must have sufficient recall for reranking to be useful.**

---

# 14. Retrieval recall vs reranking precision

This gives you an important RAG design principle.

### Initial retrieval

Optimize for:

```text
Recall
```

You want the correct information to be somewhere in the candidate set.

### Reranking

Optimize for:

```text
Precision
```

You want the most useful information near the top.

Conceptually:

```text
                  RAG RETRIEVAL

              Broad Retrieval
                    │
                    ▼
                 High Recall
                    │
                    ▼
               Candidate Set
                    │
                    ▼
                 Reranking
                    │
                    ▼
                High Precision
                    │
                    ▼
              Final Context
```

This is one of the most important concepts in practical RAG.

---

# 15. Top-K at different stages

Don't confuse the different K values.

For example:

```text
Vector Search
     ↓
Top 50
     ↓
Reranking
     ↓
Top 10
     ↓
Context selection
     ↓
Top 5
     ↓
LLM
```

You can have different numbers at different stages.

Example:

```text
retrieval_k = 50
rerank_k = 10
context_k = 5
```

The exact values depend on the application.

---

# 16. Reranking and context quality

Suppose you send 20 chunks to the LLM:

```text
20 chunks
```

Only 5 may actually be useful.

The remaining 15 add noise.

Reranking helps produce:

```text
20 candidates
      ↓
5 strongest chunks
      ↓
LLM
```

This can improve:

* context relevance
* answer quality
* token efficiency
* latency
* cost

---

# 17. Reranking and token cost

LLM context can become expensive.

Suppose:

```text
Chunk = 500 tokens
```

If you send:

```text
20 chunks
```

you have approximately:

```text
20 × 500 = 10,000 tokens
```

of retrieved context before considering the question, instructions, and generated answer.

If reranking lets you use:

```text
5 chunks
```

then:

```text
5 × 500 = 2,500 tokens
```

This can significantly reduce context size.

The exact cost depends on the model and application, but the principle is:

> **Better retrieval can reduce unnecessary context.**

---

# 18. Reranking with hybrid search

Reranking becomes especially useful when you combine retrieval methods.

```text
                     Query
                       │
              ┌────────┴────────┐
              ▼                 ▼
        Keyword Search     Vector Search
              │                 │
              └────────┬────────┘
                       ▼
                 Combined Results
                       │
                       ▼
                    Reranker
                       │
                       ▼
                  Best Chunks
                       │
                       ▼
                      LLM
```

The reranker can provide a common relevance ordering across candidates from different retrieval systems.

---

# 19. Reranking with metadata filters

You can apply metadata filters before reranking.

Example:

```text
User:
"What is the 2026 HR leave policy?"
```

First:

```text
department = HR
year = 2026
```

Then:

```text
Vector Search
      ↓
Top 50
      ↓
Reranking
      ↓
Top 5
```

This avoids wasting reranking resources on documents that the user shouldn't or doesn't need to see.

---

# 20. Reranking and access control

Security must be considered carefully.

A secure architecture should ensure unauthorized documents are excluded before they can become part of the LLM context.

Conceptually:

```text
User
 ↓
Identity / Permissions
 ↓
Authorized Document Scope
 ↓
Retrieval
 ↓
Reranking
 ↓
Context
 ↓
LLM
```

The LLM should not be responsible for enforcing document permissions.

---

# 21. Reranking models

You may encounter different kinds of rerankers:

```text
Cross-encoder rerankers
LLM-based rerankers
Specialized reranking models
```

Examples of technologies/models you may encounter include:

```text
Cohere Rerank
BGE Reranker
Jina Reranker
Cross-encoder models
```

You do not need to memorize every available model.

Understand the general architecture.

---

# 22. LLM-based reranking

An LLM can also be used to judge candidate relevance.

Conceptually:

```text
Question
+
Candidate Chunk
      ↓
LLM
      ↓
Relevance Judgment
```

For example:

```text
Question:
"How do I reset my password?"

Candidate:
"Users can reset their password from Settings."

LLM:
Highly relevant
```

However, using a large LLM for every candidate can be expensive and slow.

Therefore, specialized rerankers are often preferable for high-volume retrieval.

---

# 23. Reranking vs generation

Do not confuse these.

### Reranker

```text
Query + Candidate
       ↓
Relevance Score
```

### LLM generator

```text
Query + Context
       ↓
Generated Answer
```

The reranker does not normally write the final answer.

```text
Retriever
   ↓
Reranker
   ↓
LLM
   ↓
Answer
```

---

# 24. Reranking example

Suppose:

```text
Knowledge Base = 50,000 chunks
```

User asks:

> "What is the process for requesting parental leave?"

### Step 1 — Query embedding

```text
Question
   ↓
Embedding
```

### Step 2 — Initial retrieval

```text
50,000 chunks
      ↓
Vector Search
      ↓
Top 50
```

### Step 3 — Reranking

```text
50 candidates
      ↓
Reranker
      ↓
Rank by relevance
```

Result:

```text
1. parental-leave-policy.md
2. employee-handbook.md
3. HR-benefits.md
4. leave-faq.md
5. attendance-policy.md
```

### Step 4 — Context selection

```text
Top 5
   ↓
Context
```

### Step 5 — LLM

```text
Question + Context
        ↓
       LLM
        ↓
      Answer
```

---

# 25. A deeper example

Suppose initial retrieval produces:

```text
Chunk A:
"Employees are eligible for various types of leave."

Chunk B:
"Parental leave requests must be submitted through HR."

Chunk C:
"Annual leave requests require manager approval."

Chunk D:
"Parental leave is available for eligible employees."

Chunk E:
"Employees should notify their manager about planned absences."
```

Question:

> "How do I request parental leave?"

Initial retrieval may consider all five relevant.

But reranking might produce:

```text
B → 0.97
D → 0.92
E → 0.81
A → 0.68
C → 0.41
```

The system then provides B and D to the LLM.

This improves the quality of the context.

---

# 26. Reranking and the "lost in the middle" problem

When an LLM receives a very large context, information placed in the middle of the context may sometimes receive less effective attention than information near the beginning or end.

This is one reason retrieval systems try to:

```text
Retrieve relevant chunks
      ↓
Rank them
      ↓
Select a small context
      ↓
Place the strongest evidence appropriately
```

Therefore, better ranking can help not only retrieval precision but also context organization.

---

# 27. Reranking does not fix bad retrieval completely

Remember:

```text
Bad retrieval
     ↓
Wrong candidate set
     ↓
Reranker
     ↓
Still wrong
```

The reranker depends on the initial retrieval stage.

The complete system therefore needs:

```text
Good chunking
+
Good embeddings
+
Good retrieval recall
+
Good reranking
+
Good context construction
```

---

# 28. How to evaluate a reranker

Create test questions with relevant documents.

Example:

```text
Question:
"How do I request parental leave?"

Relevant:
Chunk B
Chunk D
```

Initial retrieval:

```text
B
D
A
E
C
```

Reranking:

```text
B
D
A
E
C
```

You can evaluate whether the relevant chunks move toward the top.

Useful metrics include:

```text
MRR
NDCG
Precision@K
Recall@K
Hit Rate
```

You don't need to memorize all formulas initially.

Understand:

> **Did reranking place the most relevant information near the top?**

---

# 29. NDCG

You may encounter **NDCG (Normalized Discounted Cumulative Gain)** when evaluating ranking systems.

The basic idea is:

> A relevant result appearing near the top is better than the same relevant result appearing much lower.

For example:

```text
Ranking A:

1 → Highly relevant
2 → Relevant
3 → Irrelevant
```

is better than:

```text
Ranking B:

1 → Irrelevant
2 → Irrelevant
3 → Highly relevant
```

NDCG takes both **relevance** and **position** into account.

You don't need the mathematical derivation for basic RAG development.

---

# 30. Common mistakes

## Mistake 1 — Thinking reranking replaces retrieval

It doesn't.

```text
Retrieval
→ Candidate generation

Reranking
→ Candidate ordering
```

---

## Mistake 2 — Reranking too many documents

This increases:

* latency
* compute
* cost

Use initial retrieval to reduce candidates first.

---

## Mistake 3 — Sending every retrieved chunk to the LLM

Reranking exists partly to help select the strongest context.

---

## Mistake 4 — Assuming reranking can recover missing information

It cannot rank a chunk it never received.

---

## Mistake 5 — Ignoring retrieval recall

If the correct chunk isn't in the candidate set, reranking cannot help.

---

## Mistake 6 — Using an expensive LLM reranker unnecessarily

A specialized reranker may be more appropriate for high-volume systems.

---

# 31. When should you use reranking?

Reranking is particularly useful when:

```text
Large Knowledge Base
        +
Many Similar Documents
        +
High Retrieval Precision Requirements
```

For example:

* enterprise documentation
* legal documents
* technical documentation
* customer support
* research systems
* large internal knowledge bases

For a tiny prototype with 100 chunks, you may not need it.

---

# 32. Simple RAG vs advanced RAG

### Simple RAG

```text
Question
   ↓
Embedding
   ↓
Vector Search
   ↓
Top-K
   ↓
LLM
```

### Advanced RAG

```text
Question
   ↓
Query Rewriting
   ↓
Metadata / ACL Filtering
   ↓
Hybrid Retrieval
   ↓
Top-N Candidates
   ↓
Reranking
   ↓
Context Selection
   ↓
LLM
   ↓
Answer
```

You should first understand simple RAG.

Then add reranking when retrieval evaluation shows that it is useful.

---

# 33. What you should remember

The simplest mental model:

```text
Large Knowledge Base
        ↓
Fast Retrieval
        ↓
Candidate Chunks
        ↓
Reranker
        ↓
Most Relevant Chunks
        ↓
LLM
        ↓
Answer
```

The key principle:

> **Retrieval aims for broad coverage; reranking aims for precise relevance.**

Remember:

```text
Retriever
→ Find candidates

Reranker
→ Rank candidates

LLM
→ Generate answer
```

And:

```text
If correct chunk is NOT retrieved
        ↓
Reranker cannot recover it
```

Therefore:

> **Good reranking requires good initial retrieval recall.**

---

# 34. Interview questions

You should be able to answer:

1. What is reranking?
2. Why is reranking needed in RAG?
3. What is the difference between retrieval and reranking?
4. What is two-stage retrieval?
5. Why not rerank the entire knowledge base?
6. What is candidate generation?
7. What is a cross-encoder?
8. What is the difference between a bi-encoder and a cross-encoder?
9. Why are embedding models faster for initial retrieval?
10. Why are rerankers generally more computationally expensive?
11. Can a reranker find a document missed by the retriever?
12. Why should initial retrieval optimize for recall?
13. Why should reranking optimize for precision?
14. What is Top-N vs Top-K in a retrieval pipeline?
15. How does reranking reduce context noise?
16. How can reranking reduce LLM token usage?
17. What is hybrid retrieval + reranking?
18. What is NDCG?
19. How would you evaluate a reranker?
20. When would you not need a reranker?

---

# 35. Final mental model

```text
                       USER QUERY
                            │
                            ▼
                    Query Embedding
                            │
                            ▼
                  ┌─────────────────┐
                  │ Initial Retrieval│
                  └────────┬────────┘
                           │
                     100,000 chunks
                           │
                           ▼
                      Top 50
                           │
                           ▼
                    ┌────────────┐
                    │  Reranker  │
                    └─────┬──────┘
                          │
                       Top 5
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

> **Reranking is the second-stage relevance filter that takes a broad set of retrieved candidates and identifies the most useful ones for the exact user query.**

Next: **`09-rag-pipeline.md`**.
