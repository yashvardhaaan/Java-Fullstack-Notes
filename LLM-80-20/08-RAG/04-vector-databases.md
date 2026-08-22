# Vector Databases

## 1. What is a vector database?

A **vector database** is a database designed to store and efficiently search **vector embeddings**.

In RAG, documents are converted into chunks, and each chunk is converted into an embedding.

```text
Document
   ↓
Chunk
   ↓
Embedding
   ↓
Vector
   ↓
Vector Database
```

When a user asks a question:

```text
User Question
      ↓
Embedding
      ↓
Query Vector
      ↓
Vector Database
      ↓
Similar Vectors
      ↓
Relevant Chunks
```

The vector database is therefore one of the main components responsible for **retrieval**.

---

# 2. Why do we need a vector database?

Suppose you have:

```text
1,000,000 document chunks
```

Each chunk has an embedding.

```text
Chunk 1 → [0.12, -0.43, ...]
Chunk 2 → [0.82,  0.11, ...]
Chunk 3 → [0.31, -0.22, ...]
...
Chunk 1,000,000 → [...]
```

A user asks:

> "How do I reset my password?"

The query becomes a vector.

The system needs to find which document vectors are most similar to the query.

A vector database provides infrastructure for doing this efficiently.

---

# 3. What does a vector database actually store?

A typical record contains more than just a vector.

Conceptually:

```text
{
    id: "chunk-123",

    text: "Users can reset their password from Settings...",

    embedding: [0.12, -0.43, 0.81, ...],

    metadata: {
        document: "security-policy.pdf",
        page: 15,
        section: "Password Reset"
    }
}
```

So you can think of a vector database record as:

```text
Vector DB Record
      │
      ├── ID
      ├── Text / Chunk
      ├── Embedding
      └── Metadata
```

---

# 4. Vector database vs normal database

A traditional relational database is optimized for structured data.

For example:

```text
users
--------------------------------
id | name | email | age
```

You might query:

```sql
SELECT *
FROM users
WHERE age > 20;
```

This is based on explicit values and conditions.

A vector database is optimized for questions like:

> "Which vectors are most similar to this vector?"

Conceptually:

```text
Query Vector
      ↓
Find nearest vectors
      ↓
Top K results
```

---

# 5. Vector search

The fundamental operation is **similarity search**.

Suppose:

```text
Query
  ↓
[0.20, 0.40, 0.70]
```

Database:

```text
Document A → [0.21, 0.41, 0.69]
Document B → [0.80, 0.10, 0.20]
Document C → [0.19, 0.38, 0.71]
```

The system calculates similarity.

Conceptually:

```text
Query → Document A = High
Query → Document B = Low
Query → Document C = High
```

The vector database returns the most relevant candidates.

---

# 6. Top-K retrieval

Usually you don't retrieve every matching vector.

You ask for the top `K`.

For example:

```text
top_k = 5
```

means:

> Return the 5 most similar results.

Example:

```text
Query
 ↓
Vector Search
 ↓
Top 5
 ↓
Chunk 12
Chunk 78
Chunk 91
Chunk 145
Chunk 302
```

These chunks can then be passed to later stages of the RAG pipeline.

---

# 7. Why can't we just use a normal database?

You actually **can**, depending on the scale and architecture.

For small systems, you could calculate similarity yourself.

But with millions of vectors, brute-force comparison can become expensive.

For example:

```text
Query
  ↓
Compare with
1
2
3
4
...
1,000,000 vectors
```

This becomes computationally expensive.

Vector databases use specialized indexing and search algorithms to make nearest-neighbor search much more efficient.

---

# 8. Approximate Nearest Neighbor search

One important concept is **ANN — Approximate Nearest Neighbor**.

Instead of guaranteeing that the mathematically exact nearest vector is found by comparing every vector, an ANN index searches intelligently to find very good candidates much faster.

Conceptually:

```text
Brute Force

Query
 ↓
Compare against everything
 ↓
Exact nearest neighbors
```

versus:

```text
ANN

Query
 ↓
Specialized index
 ↓
Search promising regions
 ↓
Very close nearest neighbors
```

The trade-off is:

```text
Speed ↑
Efficiency ↑
Potential exactness ↓
```

In practice, the speed advantage can be significant.

---

# 9. Vector indexes

A vector database uses specialized indexes to accelerate similarity search.

Common approaches include:

* HNSW
* IVF
* Product Quantization
* other approximate-nearest-neighbor techniques

You don't need to memorize the mathematics initially.

You should understand the basic idea:

> **A vector index organizes vectors so similar vectors can be found efficiently without scanning every vector.**

---

# 10. HNSW

**HNSW (Hierarchical Navigable Small World)** is a popular approximate nearest-neighbor indexing technique.

Conceptually, imagine vectors represented as nodes in a graph:

```text
       A -------- B
      /            \
     C ---- D ------ E
      \             /
       F -----------G
```

Similar vectors are connected.

Higher levels provide faster navigation across the space.

A simplified idea:

```text
Level 2
A -------------------- G

Level 1
A ----- C ----- E ----- G

Level 0
A - B - C - D - E - F - G
```

The search can navigate the graph rather than comparing every vector.

You don't need to implement HNSW from scratch.

You should know **what problem it solves**.

---

# 11. Metadata

Vectors aren't the only useful information.

You can attach metadata:

```text
{
    "document": "leave-policy.pdf",
    "department": "HR",
    "year": 2026,
    "page": 15,
    "access_level": "employee"
}
```

This allows the application to perform filtering.

---

# 12. Metadata filtering

Suppose your database contains:

```text
HR documents
Engineering documents
Finance documents
Legal documents
```

User asks:

> "What is the 2026 HR leave policy?"

Instead of searching every document:

```text
All vectors
    ↓
Vector search
```

you can first filter:

```text
department = "HR"
year = 2026
```

then perform vector search.

Conceptually:

```text
All Documents
      ↓
Metadata Filter
      ↓
HR + 2026
      ↓
Vector Search
      ↓
Top K
```

This is extremely important in enterprise RAG.

---

# 13. Metadata filtering and security

Metadata can also be used for access control.

Suppose:

```text
Document A → public
Document B → employees
Document C → administrators
```

A normal user should not retrieve Document C.

You can associate:

```text
access_level = "admin"
```

and restrict retrieval accordingly.

However:

> **Metadata filtering alone should not automatically be treated as a complete security architecture.**

Authorization should be enforced carefully at the application/data-access layer.

---

# 14. Vector database collections

Different vector databases use different terminology.

You may encounter:

```text
Collection
Index
Table
Namespace
Namespace + Index
```

The exact terminology depends on the database.

Conceptually, they represent organized groups of vectors.

For example:

```text
Knowledge Base
      │
      ├── HR
      ├── Engineering
      ├── Finance
      └── Security
```

The implementation depends on the chosen technology.

---

# 15. PostgreSQL + pgvector

You don't necessarily need a specialized vector database.

**PostgreSQL with pgvector** can store and search embeddings.

Conceptually:

```text
PostgreSQL
     +
pgvector
     ↓
Relational Data
     +
Vector Data
```

For example:

```sql
CREATE TABLE documents (
    id BIGSERIAL PRIMARY KEY,
    content TEXT,
    metadata JSONB,
    embedding VECTOR(...)
);
```

Then you can combine traditional database operations with vector search.

This can be very useful for applications that already use PostgreSQL.

---

# 16. Why pgvector is useful for learning

If you already understand SQL and PostgreSQL, pgvector is a very practical way to learn RAG.

Instead of immediately learning:

```text
Application
   +
PostgreSQL
   +
Vector DB
   +
Another infrastructure component
```

you can start with:

```text
Application
      +
PostgreSQL
      +
pgvector
```

You learn the core concepts without adding unnecessary infrastructure.

---

# 17. Popular vector databases

You may encounter:

```text
Pinecone
Qdrant
Weaviate
Milvus
Chroma
pgvector
```

There are also other systems with vector-search capabilities.

Don't try to learn all of them.

The important concepts are transferable:

```text
Embedding
   ↓
Storage
   ↓
Index
   ↓
Similarity Search
   ↓
Metadata Filtering
   ↓
Top K
```

Once you understand these, switching technologies becomes much easier.

---

# 18. Vector database is not the embedding model

This distinction is important.

### Embedding model

Converts:

```text
Text
 ↓
Vector
```

### Vector database

Stores and searches:

```text
Vector
 ↓
Similarity Search
 ↓
Relevant vectors
```

So:

```text
                RAG
                 │
        ┌────────┴────────┐
        ▼                 ▼
Embedding Model      Vector Database
        │                 │
 Text → Vector       Store/Search
```

They perform different jobs.

---

# 19. Vector database is not the retriever

Another important distinction.

The **vector database** provides the search capability.

The **retriever** is the application/component that decides how to retrieve information.

Conceptually:

```text
User Question
      ↓
Retriever
      ↓
Vector Database
      ↓
Search
      ↓
Results
```

A retriever may decide:

```text
top_k = 10
filter = department == "engineering"
similarity_threshold = ...
```

It can also combine multiple retrieval methods.

---

# 20. Vector database in the RAG architecture

The complete flow:

```text
                 INDEXING
                     │
                     ▼
                 Documents
                     │
                     ▼
                  Chunking
                     │
                     ▼
                 Embeddings
                     │
                     ▼
              Vector Database
                     │
═════════════════════╪═════════════════════
                     │
                    QUERY
                     │
                     ▼
                User Question
                     │
                     ▼
                 Embedding
                     │
                     ▼
                  Retriever
                     │
                     ▼
              Vector Database
                     │
                     ▼
                 Top K Chunks
                     │
                     ▼
                 Reranking
                     │
                     ▼
                    LLM
```

---

# 21. Similarity metrics

A vector database needs a way to determine how similar two vectors are.

Common measures include:

### Cosine similarity

Measures the angle between vectors.

```text
Similarity
   ↓
0 → very different
1 → very similar
```

The exact interpretation depends on normalization and implementation.

---

### Euclidean distance

Measures the geometric distance between vectors.

```text
A ●────────● B
      ↑
   distance
```

Smaller distance generally means more similar under that metric.

---

### Dot product

Calculates the product of corresponding vector components and sums them.

It is also commonly used in vector search.

You'll study similarity more deeply in:

```text
05-similarity-search.md
06-cosine-similarity.md
```

---

# 22. Vector database query

Conceptually, the application performs something like:

```text
query_vector = embed(
    "How do I reset my password?"
)

results = vector_db.search(
    query_vector,
    top_k = 5
)
```

The database returns something like:

```text
[
    {
        "content": "Users can reset passwords...",
        "score": 0.91
    },
    {
        "content": "Password requirements...",
        "score": 0.87
    }
]
```

The application can then pass the retrieved content to the LLM.

---

# 23. Score

A search result often includes a similarity or distance score.

For example:

```text
Chunk A → 0.92
Chunk B → 0.88
Chunk C → 0.73
Chunk D → 0.42
```

You can use scores for ranking.

Sometimes you may also apply a threshold:

```text
score >= threshold
```

to avoid returning obviously irrelevant results.

But:

> **Never assume a particular score always means the same thing across different models, metrics, and databases.**

Score calibration matters.

---

# 24. Vector search + keyword search

Vector search is powerful, but it isn't always enough.

Consider:

```text
"ERR_CONNECTION_RESET_1024"
```

Exact keyword matching can be extremely useful.

Semantic search might be better for:

```text
"Why does my connection keep getting reset?"
```

Therefore production systems may combine:

```text
Keyword Search
      +
Vector Search
      ↓
Hybrid Search
      ↓
Reranking
```

This is covered later.

---

# 25. What happens when documents change?

Suppose:

```text
old-policy.pdf
```

is replaced by:

```text
new-policy.pdf
```

The system may need to:

```text
Remove old chunks
      ↓
Process new document
      ↓
Chunk
      ↓
Embed
      ↓
Insert new vectors
```

This is part of **indexing and data freshness**.

A production RAG system therefore needs a strategy for:

* inserting documents
* updating documents
* deleting documents
* re-indexing documents
* versioning documents

---

# 26. Vector database limitations

A vector database doesn't solve every RAG problem.

It cannot fix:

```text
Bad document parsing
Bad chunking
Bad embeddings
Bad queries
Bad retrieval strategy
Bad prompts
Bad LLM behavior
```

Think:

```text
Bad Chunking
     ↓
Bad Embedding
     ↓
Bad Retrieval
     ↓
Vector DB returns bad context
```

A vector database is an infrastructure component, not the entire RAG system.

---

# 27. Common mistakes

### Mistake 1 — Thinking vector DB = RAG

It is only one component.

```text
RAG ≠ Vector Database
```

---

### Mistake 2 — Storing only vectors

You generally also need:

```text
text
metadata
document ID
chunk ID
source information
```

depending on your architecture.

---

### Mistake 3 — Ignoring metadata

Metadata is extremely useful for:

* filtering
* authorization
* citations
* debugging
* document management

---

### Mistake 4 — Assuming the highest similarity score is always correct

Similarity is not the same as factual correctness.

The result still needs to be evaluated.

---

### Mistake 5 — Using a vector database without understanding retrieval

Learn the underlying concepts instead of treating the database as a black box.

---

# 28. Practical architecture

A practical application could look like:

```text
                Backend
                   │
        ┌──────────┴──────────┐
        ▼                     ▼
   PostgreSQL             pgvector
        │                     │
 Structured Data       Vector Data
        │                     │
        └──────────┬──────────┘
                   │
                Retriever
                   │
                Reranker
                   │
                  LLM
                   │
                Response
```

This is one reason PostgreSQL + pgvector is a useful architecture to learn.

---

# 29. What you should remember

The simplest mental model:

> **A vector database stores embeddings and makes similarity-based retrieval efficient.**

Remember:

```text
Document
   ↓
Chunk
   ↓
Embedding
   ↓
Vector Database
```

Then:

```text
Question
   ↓
Embedding
   ↓
Vector Search
   ↓
Top-K Chunks
   ↓
Reranking
   ↓
LLM
```

And remember the distinction:

```text
Embedding Model
→ creates vectors

Vector Database
→ stores/searches vectors

Retriever
→ controls retrieval

Reranker
→ improves ordering/selection

LLM
→ generates the answer
```

---

# 30. Interview questions

You should be able to answer:

1. What is a vector database?
2. Why is a vector database used in RAG?
3. What does a vector database store?
4. How is a vector database different from PostgreSQL?
5. Can PostgreSQL be used for RAG?
6. What is pgvector?
7. What is vector similarity search?
8. What is Top-K?
9. What is approximate nearest-neighbor search?
10. What is HNSW?
11. Why are vector indexes needed?
12. What is metadata filtering?
13. How can metadata help with authorization?
14. What is the difference between a vector database and a retriever?
15. What is the difference between an embedding model and a vector database?
16. What happens when a document is updated?
17. Why isn't a vector database enough to build a good RAG system?
18. What are common vector databases?
19. Why might hybrid search be better than vector search alone?
20. What factors affect vector search quality?

---

# 31. Final mental model

Keep this picture in your head:

```text
                    DOCUMENTS
                        │
                        ▼
                     CHUNKS
                        │
                        ▼
                   EMBEDDINGS
                        │
                        ▼
              ┌───────────────────┐
              │   VECTOR DATABASE │
              │                   │
              │  Vector           │
              │  Text             │
              │  Metadata         │
              │  Index            │
              └─────────┬─────────┘
                        │
                        │ Search
                        ▼
                  RELEVANT CHUNKS
                        │
                        ▼
                    RERANKING
                        │
                        ▼
                       LLM
                        │
                        ▼
                     ANSWER
```

**Core idea:**

> A vector database is the searchable storage layer that allows a RAG system to efficiently find information based on semantic similarity.

Next: **`05-similarity-search.md`**.
