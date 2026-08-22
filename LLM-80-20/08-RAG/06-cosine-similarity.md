# Cosine Similarity

## 1. What is cosine similarity?

**Cosine similarity** is a mathematical measure used to determine how similar two vectors are based on the **angle between them**.

In RAG, embeddings are represented as vectors.

Cosine similarity helps answer:

> **"How similar is the meaning represented by these two vectors?"**

Conceptually:

```text
Text A
  ↓
Embedding
  ↓
Vector A

Text B
  ↓
Embedding
  ↓
Vector B

Vector A + Vector B
        ↓
Cosine Similarity
        ↓
Similarity Score
```

---

# 2. Why is cosine similarity useful in RAG?

Suppose the user asks:

```text
"How do I reset my password?"
```

And your document contains:

```text
"Users can change their credentials through the account settings."
```

Their exact words are different, but their meanings may be similar.

After embedding:

```text
Question → Vector A

Document → Vector B
```

Cosine similarity compares the vectors.

```text
Vector A
    ↘
     ↘ small angle
      ↘
       Vector B
```

A small angle generally means the vectors point in similar directions.

Therefore:

```text
Small angle
     ↓
High cosine similarity
     ↓
Likely semantically similar
```

---

# 3. The basic intuition

Imagine vectors as arrows starting from the origin.

```text
             B
            ↗
           /
          /
         /
        /
       /
      ●────────────→ A
```

If two vectors point in almost the same direction:

```text
A →→→→→
B →→→→↗
```

they have high cosine similarity.

If they point in completely different directions:

```text
A →→→→→

B ↑
  ↑
  ↑
```

their cosine similarity is lower.

The important point:

> **Cosine similarity focuses on direction rather than simply the raw size of the vectors.**

---

# 4. The formula

The formula is:

```text
                 A · B
cos(A,B) = ───────────────
            ||A|| ||B||
```

Where:

```text
A · B
```

is the **dot product** of vectors A and B.

And:

```text
||A||
```

and:

```text
||B||
```

are the magnitudes (lengths) of the vectors.

You don't need to derive the formula every time you build RAG.

You should understand what the formula is measuring.

---

# 5. What does the score mean?

For normalized vectors, cosine similarity is commonly interpreted in the range:

```text
-1 → completely opposite direction
 0 → perpendicular / little directional similarity
+1 → same direction
```

For many modern text embedding applications, scores are often concentrated in a narrower positive range.

So don't interpret a particular score such as:

```text
0.8
```

as:

> "80% similarity."

That is not generally correct.

The score is meaningful relative to the embedding model, data, normalization, and retrieval setup.

---

# 6. Simple example

Consider two simple 2D vectors:

```text
A = [1, 0]

B = [1, 0]
```

They point in exactly the same direction.

Therefore:

```text
cos(A,B) = 1
```

Maximum similarity.

---

Now:

```text
A = [1, 0]

B = [-1, 0]
```

They point in opposite directions.

Therefore:

```text
cos(A,B) = -1
```

---

Now:

```text
A = [1, 0]

B = [0, 1]
```

They are perpendicular.

Therefore:

```text
cos(A,B) = 0
```

---

# 7. A more realistic example

Suppose:

```text
A = [1, 1]
B = [2, 2]
```

The vectors have different magnitudes:

```text
A → shorter arrow
B → longer arrow
```

But they point in exactly the same direction.

Cosine similarity is:

```text
1
```

This demonstrates an important property:

> **Cosine similarity cares about direction, not just vector magnitude.**

---

# 8. Why direction matters for embeddings

Embedding vectors can have many dimensions.

For example:

```text
[0.12, -0.44, 0.82, 0.19, ...]
```

You cannot visualize a 768-dimensional or 1536-dimensional vector directly.

But mathematically, the vector still has:

* a direction
* a magnitude

Cosine similarity allows us to compare their directions.

Conceptually:

```text
             Vector Space

                 Document A
                      ↗
                     /
                    /
                   /
                  ●
                 /
                ↗
        Query Vector
```

If the directions are similar, the embeddings may represent semantically related content.

---

# 9. Dot product

To understand cosine similarity, you need to understand the dot product.

For:

```text
A = [a₁, a₂, a₃]

B = [b₁, b₂, b₃]
```

the dot product is:

```text
A · B = a₁b₁ + a₂b₂ + a₃b₃
```

Example:

```text
A = [2, 3]

B = [4, 5]
```

Then:

```text
A · B
= (2 × 4) + (3 × 5)
= 8 + 15
= 23
```

The dot product is part of the cosine similarity calculation.

---

# 10. Vector magnitude

The magnitude of a vector represents its length.

For:

```text
A = [a₁, a₂]
```

the magnitude is:

```text
||A|| = √(a₁² + a₂²)
```

Example:

```text
A = [3, 4]
```

Then:

```text
||A|| = √(3² + 4²)
      = √25
      = 5
```

For high-dimensional embeddings, the same principle applies across all dimensions.

---

# 11. Complete cosine example

Take:

```text
A = [1, 0]

B = [1, 1]
```

### Step 1 — Dot product

```text
A · B
= (1 × 1) + (0 × 1)
= 1
```

### Step 2 — Magnitude of A

```text
||A|| = √(1² + 0²)
      = 1
```

### Step 3 — Magnitude of B

```text
||B|| = √(1² + 1²)
      = √2
```

### Step 4 — Cosine similarity

```text
cos(A,B)
= 1 / (1 × √2)

≈ 0.707
```

So the vectors have a positive directional similarity.

---

# 12. Cosine similarity vs Euclidean distance

These measure similarity differently.

### Cosine similarity

Focuses on:

```text
Direction
```

### Euclidean distance

Focuses on:

```text
Geometric distance
```

Example:

```text
A = [1, 1]

B = [2, 2]
```

Cosine similarity:

```text
1
```

because they point in the same direction.

But Euclidean distance is not zero because the vectors have different lengths.

Therefore:

```text
Cosine
→ Same direction

Euclidean
→ Physical distance
```

---

# 13. Cosine similarity vs dot product

These are closely related but not identical.

Cosine similarity:

```text
(A · B)
────────────
||A|| ||B||
```

Dot product:

```text
A · B
```

The cosine formula normalizes the dot product by vector magnitudes.

Therefore, the magnitude of vectors affects dot product more directly.

Cosine similarity focuses on directional alignment.

---

# 14. Normalized vectors

If vectors are normalized to unit length:

```text
||A|| = 1
||B|| = 1
```

then:

```text
cos(A,B) = A · B
```

So for normalized vectors:

```text
Cosine similarity
       ≈
Dot product
```

This is why some vector databases can use inner product / dot product search when embeddings are normalized.

---

# 15. Cosine similarity in RAG

Now connect the mathematics to the actual RAG pipeline.

### Step 1

Document:

```text
"Employees receive 20 days of annual leave."
```

↓

Embedding:

```text
Document Vector
```

### Step 2

User:

```text
"How many vacation days do employees get?"
```

↓

Embedding:

```text
Query Vector
```

### Step 3

Compare:

```text
Query Vector
      ↕
Document Vector
```

using cosine similarity.

### Step 4

Rank documents:

```text
Chunk A → 0.91
Chunk B → 0.72
Chunk C → 0.44
```

### Step 5

Retrieve the highest-ranked chunks.

```text
Top-K
 ↓
Relevant Context
 ↓
LLM
 ↓
Answer
```

---

# 16. Important: cosine similarity does not understand language

Cosine similarity itself does **not** understand:

* English
* Hindi
* Java
* React
* policies
* programming

It only compares vectors mathematically.

The semantic information comes from the **embedding model**.

This distinction is extremely important.

```text
Embedding Model
      ↓
Converts meaning → vectors

Cosine Similarity
      ↓
Compares vectors
```

So:

> **The embedding model creates the semantic representation; cosine similarity measures how aligned two representations are.**

---

# 17. Embedding model + cosine similarity

Think of them as two separate stages.

```text
"How do I reset my password?"
              ↓
       Embedding Model
              ↓
       [0.12, -0.44, ...]
              │
              │
              ▼
      Cosine Similarity
              ▲
              │
       [0.14, -0.41, ...]
              │
              ▲
       Document Embedding
```

The embedding model answers:

> "How should this text be represented numerically?"

Cosine similarity answers:

> "How aligned are these two numerical representations?"

---

# 18. Why cosine similarity is useful but not magic

Suppose your query is:

```text
"How do I reset my password?"
```

and the database contains:

```text
Chunk A:
"Password reset instructions..."

Chunk B:
"Passwords should contain at least 12 characters..."

Chunk C:
"Company holiday calendar..."
```

Similarity search might rank:

```text
A → 0.94
B → 0.87
C → 0.31
```

This is useful.

But Chunk B may still not answer the user's exact question.

Therefore:

```text
Similarity Search
        ↓
Candidate Results
        ↓
Reranking
        ↓
Best Context
```

Similarity is a **retrieval signal**, not a guarantee of correctness.

---

# 19. Similarity score is not confidence

This is a very important production concept.

Suppose:

```text
Chunk A → 0.93
```

It does **not** necessarily mean:

```text
93% chance the answer is correct
```

It means the vectors have a particular degree of similarity according to the chosen metric.

The score depends on:

```text
Embedding Model
       +
Data
       +
Metric
       +
Normalization
       +
Implementation
```

Therefore, don't blindly use:

```text
if score > 0.8:
    answer
```

without evaluating the system.

---

# 20. Similarity thresholds

You may sometimes use a threshold:

```text
threshold = 0.75
```

Conceptually:

```text
0.92 → Keep
0.87 → Keep
0.79 → Keep
0.61 → Reject
```

But thresholds should be selected using evaluation data.

A better approach is:

```text
Test Questions
      ↓
Run Retrieval
      ↓
Observe Scores
      ↓
Measure Relevant Results
      ↓
Choose Threshold
```

---

# 21. Cosine similarity and retrieval quality

A good RAG system requires more than choosing a metric.

Think:

```text
Document Quality
       ↓
Chunking
       ↓
Embedding Model
       ↓
Similarity Metric
       ↓
Retrieval
       ↓
Reranking
       ↓
LLM
```

Changing cosine similarity to another metric cannot fix:

```text
Bad chunking
Bad embeddings
Poor document parsing
Bad queries
Missing information
```

The entire pipeline matters.

---

# 22. Why you don't need deep mathematics initially

As an AI engineer building RAG systems, you should understand:

### Must know

* vectors
* dot product
* magnitude
* cosine similarity
* distance vs similarity
* normalization
* why vectors can represent semantic relationships

### Nice to know

* vector geometry
* high-dimensional spaces
* nearest-neighbor algorithms
* ANN indexing

### Not initially necessary

* deriving advanced vector-search algorithms
* implementing HNSW from scratch
* advanced linear algebra proofs

Your goal is to understand **what the mathematics is doing inside the system**.

---

# 23. Practical RAG example

Imagine:

```text
100,000 document chunks
```

Each has an embedding.

User asks:

```text
"What is the company's password policy?"
```

The system:

```text
Question
   ↓
Embedding
   ↓
Query Vector
   ↓
Vector Search
   ↓
Calculate similarity
   ↓
Rank results
   ↓
Top 20
   ↓
Reranker
   ↓
Top 5
   ↓
LLM
   ↓
Answer
```

Cosine similarity is one possible mechanism used during the vector-search stage.

---

# 24. Common mistakes

## Mistake 1 — Thinking cosine similarity understands text

It doesn't.

```text
Text meaning
   ↓
Embedding Model

Vector comparison
   ↓
Cosine Similarity
```

---

## Mistake 2 — Treating score as probability

```text
0.9 ≠ 90% correctness
```

---

## Mistake 3 — Assuming cosine is always the best metric

The appropriate metric depends on:

* embedding model
* normalization
* database
* retrieval task

---

## Mistake 4 — Thinking higher score always means better answer

Similarity measures vector alignment, not factual correctness.

---

## Mistake 5 — Over-focusing on mathematics

You don't need to become a mathematician to build RAG.

Understand the intuition and the role it plays in the pipeline.

---

# 25. What you should remember

The simplest mental model:

```text
Embedding A
     ↓
Vector A

Embedding B
     ↓
Vector B

Vector A + Vector B
        ↓
Cosine Similarity
        ↓
Similarity Score
```

The formula:

```text
                 A · B
cos(A,B) = ───────────────
            ||A|| ||B||
```

The interpretation:

```text
Same direction
      ↓
High similarity

Different direction
      ↓
Lower similarity
```

And in RAG:

```text
User Question
      ↓
Query Embedding
      ↓
Vector Search
      ↓
Cosine / other similarity measure
      ↓
Ranked Chunks
      ↓
Reranking
      ↓
LLM
      ↓
Answer
```

---

# 26. Interview questions

You should be able to answer:

1. What is cosine similarity?
2. Why is cosine similarity useful for embeddings?
3. What does cosine similarity measure?
4. What is the cosine similarity formula?
5. What is a dot product?
6. What is vector magnitude?
7. Why does cosine similarity focus on direction?
8. What is the difference between cosine similarity and Euclidean distance?
9. What is the difference between cosine similarity and dot product?
10. How does cosine similarity participate in RAG?
11. Does cosine similarity understand language?
12. Does a score of 0.9 mean 90% confidence?
13. What is vector normalization?
14. Why can cosine similarity be combined with reranking?
15. How would you choose a similarity threshold?
16. Is cosine similarity always the best metric?
17. How does embedding quality affect cosine similarity search?
18. Can cosine similarity guarantee that a retrieved chunk contains the correct answer?

---

# 27. Final mental model

```text
                TEXT
                 │
                 ▼
          EMBEDDING MODEL
                 │
                 ▼
              VECTOR
                 │
                 │
                 ▼
        ┌─────────────────┐
        │ VECTOR SEARCH    │
        │                 │
        │ Cosine Similarity│
        │ Dot Product      │
        │ Euclidean        │
        └────────┬────────┘
                 │
                 ▼
           RANKED RESULTS
                 │
                 ▼
              TOP-K
                 │
                 ▼
             RERANKING
                 │
                 ▼
              CONTEXT
                 │
                 ▼
                LLM
                 │
                 ▼
              ANSWER
```

**Core idea:**

> **Embeddings create the semantic vectors; cosine similarity compares their directions to help identify semantically related content.**

Next: **`07-retrieval.md`**.
