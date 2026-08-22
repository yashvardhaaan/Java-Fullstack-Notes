# Similarity Search

## 1. What is similarity search?

**Similarity search** is the process of finding the pieces of data that are most similar to a given query.

In RAG, the query and document chunks are represented as vectors.

```text
User Question
      ↓
Embedding Model
      ↓
Query Vector
      ↓
Similarity Search
      ↓
Most Similar Document Vectors
      ↓
Relevant Chunks
```

The core idea is:

> **Find the chunks whose meaning is closest to the user's question.**

---

# 2. Why does RAG need similarity search?

Suppose your knowledge base contains:

```text
Chunk 1 → Company holidays
Chunk 2 → Password policy
Chunk 3 → Employee leave
Chunk 4 → Laptop security
Chunk 5 → Office locations
```

The user asks:

> "How many vacation days do I get?"

The system needs to determine that:

```text
Chunk 3 → Employee leave
```

is more relevant than:

```text
Chunk 1 → Company holidays
Chunk 5 → Office locations
```

Similarity search performs this matching.

---

# 3. Semantic similarity

Similarity search in RAG usually works with **semantic meaning**.

Consider:

```text
Question:
"How do I change my password?"
```

Document:

```text
"Users can modify their credentials through account settings."
```

The words aren't identical, but the meanings are related.

Their embeddings may therefore be close:

```text
Question Vector
       │
       │ high similarity
       ▼
Document Vector
```

This is called **semantic search**.

---

# 4. The basic similarity-search pipeline

```text
                    INDEXING
                       │
                       ▼
                  Document Chunk
                       │
                       ▼
                  Embedding Model
                       │
                       ▼
                  Document Vector
                       │
                       ▼
                  Vector Database


                     QUERY
                       │
                       ▼
                  User Question
                       │
                       ▼
                  Embedding Model
                       │
                       ▼
                    Query Vector
                       │
                       ▼
                Similarity Search
                       │
                       ▼
                  Top-K Results
```

---

# 5. Query vector vs document vectors

Suppose we have:

```text
Query:
"How do I reset my password?"
```

After embedding:

```text
Query Vector
Q = [0.12, 0.45, 0.78, ...]
```

And the database contains:

```text
Document A
A = [0.11, 0.44, 0.79, ...]

Document B
B = [0.80, 0.10, 0.21, ...]

Document C
C = [0.13, 0.42, 0.76, ...]
```

The similarity calculation determines which vectors are closest to `Q`.

Conceptually:

```text
Q ↔ A → Very Similar
Q ↔ B → Not Similar
Q ↔ C → Very Similar
```

The database can then return A and C.

---

# 6. Similarity score

A similarity score indicates how closely two vectors match according to the chosen metric.

Example:

```text
Query
  ↓
Search
  ↓
────────────────────────
Chunk A → 0.94
Chunk B → 0.89
Chunk C → 0.71
Chunk D → 0.43
────────────────────────
```

The system can rank the chunks:

```text
1. Chunk A
2. Chunk B
3. Chunk C
4. Chunk D
```

The exact meaning of the score depends on:

* similarity metric
* embedding model
* vector normalization
* database implementation

Therefore, don't assume:

```text
0.9 = always 90% relevant
```

It doesn't work that way.

---

# 7. Top-K

One of the most important retrieval parameters is **K**.

If:

```text
K = 5
```

the system retrieves the five highest-ranked results.

```text
1 → Chunk 31
2 → Chunk 78
3 → Chunk 12
4 → Chunk 92
5 → Chunk 105
```

Conceptually:

```text
10,000 chunks
      ↓
Similarity Search
      ↓
Top 5
      ↓
LLM
```

Instead of sending all 10,000 chunks to the LLM.

---

# 8. Why Top-K matters

Suppose:

```text
K = 1
```

You retrieve only one chunk.

This may be insufficient if the answer requires multiple pieces of information.

If:

```text
K = 100
```

you may retrieve too much irrelevant information.

Therefore:

```text
Too Low K
   ↓
Missing context

Good K
   ↓
Relevant context

Too High K
   ↓
Noise + higher token usage
```

There is no universal perfect value.

You need to evaluate it for your application.

---

# 9. Similarity threshold

Another approach is to use a similarity threshold.

For example:

```text
threshold = 0.75
```

Then:

```text
Chunk A → 0.92 → Keep
Chunk B → 0.87 → Keep
Chunk C → 0.78 → Keep
Chunk D → 0.61 → Reject
```

This can prevent obviously irrelevant chunks from entering the context.

But thresholds must be calibrated.

A score of `0.75` from one embedding model may not have the same meaning as `0.75` from another.

---

# 10. Top-K vs threshold

These are different strategies.

### Top-K

Always return a fixed number.

```text
top_k = 5
```

Result:

```text
5 chunks
```

### Threshold

Return results only if they meet a relevance condition.

```text
score >= threshold
```

Result:

```text
Could be 0
Could be 2
Could be 10
```

### You can combine them

```text
Retrieve top 10
      ↓
Apply threshold
      ↓
Keep relevant results
      ↓
Rerank
      ↓
Top 5
```

---

# 11. Similarity metrics

There are several ways to measure vector similarity.

The major ones you should know are:

```text
Cosine Similarity
Euclidean Distance
Dot Product
```

### Cosine similarity

Measures the angle/directional similarity between vectors.

```text
A ↗
   \
    \ θ
     \
      ↗ B
```

### Euclidean distance

Measures geometric distance.

```text
A ●────────────● B
       distance
```

Smaller distance generally means greater similarity.

### Dot product

Measures the product of corresponding vector components and sums them.

The exact metric you should use depends on your embedding model and database configuration.

---

# 12. Cosine similarity

Cosine similarity is commonly used with embeddings.

The simplified formula is:

```text
                 A · B
cosine(A,B) = ─────────────
              ||A|| ||B||
```

Where:

```text
A · B
```

is the dot product.

And:

```text
||A||
```

is the magnitude of vector A.

The result represents how aligned the vectors are.

You'll study this in detail in:

```text
06-cosine-similarity.md
```

---

# 13. Euclidean distance

Euclidean distance is the ordinary geometric distance between two points.

For two vectors:

```text
A = [a1, a2]
B = [b1, b2]
```

the distance is:

```text
√((a1-b1)² + (a2-b2)²)
```

In higher-dimensional embedding spaces, the same idea extends across all dimensions.

Conceptually:

```text
Small distance
     ↓
More similar

Large distance
     ↓
Less similar
```

---

# 14. Dot product

For:

```text
A = [a1, a2, a3]
B = [b1, b2, b3]
```

the dot product is:

```text
A · B =
a1b1 + a2b2 + a3b3
```

It is commonly used in vector search systems.

For normalized vectors, dot product and cosine similarity are closely related.

You don't need to memorize the mathematics beyond understanding what it is doing.

---

# 15. Vector search is not keyword search

Consider:

```text
Question:
"How can I authenticate a request?"
```

Document:

```text
"JWT tokens are used to verify API requests."
```

Keyword search might look for:

```text
authenticate
```

while the document contains:

```text
verify
```

Semantic similarity can recognize the relationship.

Therefore:

```text
Keyword Search
→ lexical matching

Vector Search
→ semantic matching
```

Both have strengths.

---

# 16. Keyword search is still useful

Suppose the user searches:

```text
"ERR_AUTH_4017"
```

Exact matching is extremely useful.

A vector search might understand the general concept:

```text
authentication error
```

but exact keyword search is often better for:

* error codes
* product IDs
* usernames
* API names
* version numbers
* technical identifiers

This is why production systems often use **hybrid search**.

---

# 17. Hybrid search

Hybrid search combines multiple retrieval methods.

```text
                  User Query
                      │
            ┌─────────┴─────────┐
            ▼                   ▼
       Keyword Search      Vector Search
            │                   │
            └─────────┬─────────┘
                      ▼
               Combine Results
                      │
                      ▼
                  Reranking
                      │
                      ▼
                 Final Context
```

For example:

```text
Query:
"ERR_AUTH_4017 authentication failure"
```

Keyword search is good at:

```text
ERR_AUTH_4017
```

Vector search is good at:

```text
authentication failure
```

Combining them can improve retrieval.

---

# 18. Metadata filtering + similarity search

Similarity search can be combined with metadata filters.

Suppose your vector database contains:

```text
HR 2024
HR 2025
HR 2026
Engineering 2026
Finance 2026
```

User asks:

> "What is the 2026 HR leave policy?"

You can do:

```text
Metadata Filter
department = HR
year = 2026
        ↓
Vector Search
        ↓
Top-K
```

This is usually much better than searching the entire database.

---

# 19. Similarity search is not the same as retrieval

These concepts are related but not identical.

### Similarity search

Answers:

> Which vectors are closest to this query?

```text
Query Vector
     ↓
Vector Search
     ↓
Similar vectors
```

### Retrieval

Is the broader process of finding useful information for the query.

A retriever might combine:

```text
Vector Search
+
Keyword Search
+
Metadata Filtering
+
Query Rewriting
+
Other logic
```

Therefore:

```text
Similarity Search
        ↓
One retrieval mechanism

Retrieval
        ↓
Broader information-selection process
```

---

# 20. Search result ranking

Suppose the vector database returns:

```text
Chunk A → 0.91
Chunk B → 0.87
Chunk C → 0.84
Chunk D → 0.81
Chunk E → 0.79
```

The system can initially rank:

```text
A > B > C > D > E
```

But similarity alone doesn't always determine which chunk is best for the question.

For example:

```text
Chunk A
"Password security is important..."

Chunk B
"To reset your password, go to Settings → Security..."
```

Both may be semantically similar.

But B is more useful for:

> "How do I reset my password?"

This is one reason **reranking** exists.

---

# 21. Similarity search + reranking

A common architecture is:

```text
10,000 chunks
      ↓
Vector Search
      ↓
Top 50 candidates
      ↓
Reranker
      ↓
Top 5
      ↓
LLM
```

Why not directly retrieve only 5?

Because the initial vector search is optimized for efficient candidate generation.

The reranker can perform a more detailed relevance assessment over a smaller candidate set.

---

# 22. Similarity search and chunk quality

Similarity search cannot fix bad chunks.

Suppose:

```text
Document
   ↓
Bad Chunking
   ↓
Broken context
   ↓
Embeddings
   ↓
Similarity Search
```

Even if the similarity calculation is perfect, the retrieved chunk may not contain the complete answer.

Therefore:

```text
Good Chunking
      +
Good Embeddings
      +
Good Similarity Search
      ↓
Better Retrieval
```

---

# 23. Example: company knowledge assistant

Suppose your knowledge base contains 100,000 chunks.

User asks:

> "What is the process for requesting parental leave?"

### Step 1 — Embed query

```text
Question
   ↓
Embedding
   ↓
Query Vector
```

### Step 2 — Search

```text
100,000 chunks
      ↓
Vector Search
      ↓
Top 20
```

### Step 3 — Filter

Perhaps:

```text
department = HR
```

### Step 4 — Rerank

```text
20 candidates
      ↓
Reranker
      ↓
Top 5
```

### Step 5 — Generate

```text
Top 5 chunks
      +
User Question
      ↓
LLM
      ↓
Answer
```

---

# 24. The retrieval pipeline

A more complete production-style retrieval flow looks like:

```text
                    User Query
                         │
                         ▼
                  Query Processing
                         │
                         ▼
                ┌────────┴────────┐
                ▼                 ▼
          Keyword Search    Vector Search
                │                 │
                └────────┬────────┘
                         ▼
                    Merge Results
                         │
                         ▼
                 Metadata Filtering
                         │
                         ▼
                     Top-N
                         │
                         ▼
                    Reranking
                         │
                         ▼
                     Top-K
                         │
                         ▼
                    LLM Context
```

Not every RAG system needs every stage.

Start simple and add complexity when needed.

---

# 25. Common similarity-search mistakes

## Mistake 1 — Choosing Top-K randomly

Don't assume:

```text
top_k = 5
```

is automatically correct.

Evaluate it.

---

## Mistake 2 — Treating similarity score as probability

```text
0.90 ≠ 90% probability of correctness
```

It is a similarity/distance score, not necessarily confidence.

---

## Mistake 3 — Using vector search for everything

Exact identifiers may be better handled by keyword search.

---

## Mistake 4 — Ignoring metadata

Metadata can dramatically narrow the search space.

---

## Mistake 5 — Retrieving too many chunks

More context does not automatically mean better answers.

```text
More chunks
    ≠
Better answer
```

Irrelevant context can hurt generation quality.

---

## Mistake 6 — Ignoring evaluation

Always test retrieval with realistic questions.

---

# 26. How to evaluate similarity search

Create a test dataset:

```text
Question → Expected Relevant Chunks
```

Example:

```text
Question:
"How do I reset my password?"

Expected:
password-policy chunk
password-reset chunk
```

Run retrieval.

```text
Retrieved:
password-reset chunk
account-security chunk
holiday-policy chunk
```

Then evaluate:

```text
Did we retrieve the relevant chunks?
Did we retrieve irrelevant chunks?
Did we miss the best chunk?
```

This leads into retrieval metrics such as:

* Precision
* Recall
* Hit Rate
* MRR
* Recall@K
* Precision@K

You don't need to master all metrics immediately, but you should know why retrieval evaluation exists.

---

# 27. Important concept: Recall vs precision

Imagine the relevant chunks are:

```text
A, B, C
```

Your system retrieves:

```text
A, B, D, E
```

You found:

```text
A, B
```

but missed:

```text
C
```

and retrieved irrelevant:

```text
D, E
```

### Recall

How much of the relevant information did you retrieve?

```text
Relevant retrieved
───────────────────
All relevant
```

### Precision

How much of what you retrieved was actually relevant?

```text
Relevant retrieved
───────────────────
All retrieved
```

This distinction becomes important when tuning RAG.

---

# 28. Similarity search in one picture

```text
                     DOCUMENTS
                         │
                         ▼
                       Chunks
                         │
                         ▼
                    Embeddings
                         │
                         ▼
                  Vector Database
                         │
                         │
                         │
User Question            │
      │                  │
      ▼                  │
   Embedding             │
      │                  │
      ▼                  │
 Query Vector ───────────┤
                         ▼
                Similarity Search
                         │
                         ▼
                     Top-K
                         │
                         ▼
                  Relevant Chunks
                         │
                         ▼
                     Reranker
                         │
                         ▼
                        LLM
```

---

# 29. What you should remember

The core mental model:

> **Similarity search compares a query representation against stored representations and returns the most relevant candidates.**

Remember:

```text
Question
   ↓
Query Embedding
   ↓
Similarity Search
   ↓
Ranked Results
   ↓
Top-K
   ↓
Reranking
   ↓
Context
```

And remember these distinctions:

```text
Embedding
→ Represents meaning

Similarity Search
→ Finds similar vectors

Vector Database
→ Stores/searches vectors efficiently

Retriever
→ Controls information retrieval

Reranker
→ Improves relevance ordering

LLM
→ Generates the final answer
```

---

# 30. Interview questions

You should be able to answer:

1. What is similarity search?
2. Why is similarity search needed in RAG?
3. What is semantic search?
4. How does vector similarity work conceptually?
5. What is Top-K?
6. Why is Top-K important?
7. What happens if Top-K is too low?
8. What happens if Top-K is too high?
9. What is a similarity threshold?
10. What is the difference between Top-K and threshold filtering?
11. What are cosine similarity, Euclidean distance, and dot product?
12. What is approximate nearest-neighbor search?
13. Why is keyword search still useful?
14. What is hybrid search?
15. What is the difference between similarity search and retrieval?
16. Why can similarity search return irrelevant chunks?
17. Why is reranking useful?
18. What are precision and recall in retrieval?
19. How would you evaluate retrieval quality?
20. Why doesn't a higher similarity score guarantee a correct answer?

---

# 31. Final mental model

```text
                 USER QUESTION
                       │
                       ▼
                 Query Embedding
                       │
                       ▼
                ┌──────────────┐
                │ Vector Search│
                └──────┬───────┘
                       │
                ┌──────┴──────┐
                ▼             ▼
             Chunk A        Chunk B
             0.92           0.87
                │             │
                └──────┬──────┘
                       ▼
                    Top-K
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
                    Answer
```

**The key idea:** similarity search is the mechanism that turns your embedded knowledge base into something the RAG system can actually search.

Next: **`06-cosine-similarity.md`**.
