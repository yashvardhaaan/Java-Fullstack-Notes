# RAG Pipeline

## 1. What is a RAG pipeline?

A **RAG pipeline** is the complete sequence of steps that takes information from external data sources, retrieves the relevant information for a user's question, and gives that information to an LLM to generate an answer.

The complete mental model is:

```text
Documents
    ↓
Ingestion
    ↓
Chunking
    ↓
Embeddings
    ↓
Vector Database
    ↓
User Query
    ↓
Retrieval
    ↓
Reranking
    ↓
Context
    ↓
LLM
    ↓
Answer
```

A practical RAG system actually consists of **two major pipelines**:

```text
1. Indexing Pipeline
2. Query Pipeline
```

Understanding this distinction is extremely important.

---

# 2. The two RAG pipelines

## Indexing pipeline

The indexing pipeline prepares your knowledge base.

```text
Documents
    ↓
Load
    ↓
Parse
    ↓
Clean
    ↓
Chunk
    ↓
Embed
    ↓
Store
```

This usually happens before users ask questions.

---

## Query pipeline

The query pipeline answers user questions.

```text
User Question
      ↓
Query Processing
      ↓
Retrieval
      ↓
Reranking
      ↓
Context Construction
      ↓
LLM
      ↓
Answer
```

Together:

```text
             INDEXING
                │
                ▼
            Documents
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
════════════════╪════════════════
                │
               QUERY
                │
                ▼
          User Question
                │
                ▼
           Retrieval
                │
                ▼
           Reranking
                │
                ▼
             Context
                │
                ▼
               LLM
                │
                ▼
             Answer
```

---

# 3. Indexing pipeline

Let's understand the first half.

Suppose your company has:

```text
documents/
├── employee-handbook.pdf
├── security-policy.pdf
├── engineering-guide.md
└── deployment-guide.md
```

These documents need to become searchable.

---

# 4. Step 1 — Document ingestion

**Ingestion** means bringing external data into your RAG system.

Sources can include:

```text
PDF
DOCX
Markdown
HTML
Web pages
GitHub
Databases
Cloud storage
Internal wiki
APIs
```

Conceptually:

```text
External Sources
       ↓
Document Loaders
       ↓
Raw Documents
```

For example:

```text
security-policy.pdf
       ↓
PDF Loader
       ↓
Extracted Text
```

---

# 5. Step 2 — Parsing and cleaning

Raw documents often contain unwanted information.

For example:

```text
PDF
 ↓
Headers
Footers
Page numbers
Whitespace
Broken text
Tables
Navigation
```

The system may need to clean and normalize the content.

```text
Raw Document
      ↓
Parser
      ↓
Cleaner
      ↓
Useful Content
```

Good parsing is important because:

```text
Bad parsing
    ↓
Bad chunks
    ↓
Bad embeddings
    ↓
Bad retrieval
    ↓
Bad answer
```

---

# 6. Step 3 — Chunking

The cleaned document is split into meaningful pieces.

```text
Document
   ↓
Chunking
   ↓
Chunk 1
Chunk 2
Chunk 3
...
Chunk N
```

Each chunk should contain enough information to be useful when retrieved.

For example:

```text
Chunk 1
---------
Authentication

JWT tokens are used for API authentication...


Chunk 2
---------
Refresh Tokens

Refresh tokens allow clients to obtain...
```

Chunking strategy depends on the type of data.

---

# 7. Step 4 — Metadata

Each chunk should usually carry metadata.

Example:

```text
{
    "text": "JWT tokens are used...",
    "metadata": {
        "document": "security-guide.pdf",
        "page": 15,
        "section": "Authentication",
        "department": "Engineering",
        "year": 2026
    }
}
```

Metadata is useful for:

* filtering
* citations
* access control
* debugging
* document management
* source attribution

---

# 8. Step 5 — Embeddings

Each chunk is converted into a vector.

```text
Chunk
  ↓
Embedding Model
  ↓
Vector
```

Example:

```text
"JWT tokens are used for authentication."
                 ↓
           Embedding Model
                 ↓
      [0.12, -0.44, 0.81, ...]
```

This allows semantic search later.

---

# 9. Step 6 — Store in vector database

The chunks, embeddings, and metadata are stored.

Conceptually:

```text
Vector Database
────────────────────────────
Chunk
Embedding
Metadata
Document ID
Chunk ID
────────────────────────────
```

Example:

```text
{
    "id": "chunk-123",
    "text": "JWT tokens...",
    "embedding": [0.12, -0.44, ...],
    "metadata": {
        "document": "security-guide.pdf",
        "page": 15
    }
}
```

Now the knowledge base is ready for retrieval.

---

# 10. The indexing pipeline together

```text
                 DOCUMENTS
                     │
                     ▼
                 INGESTION
                     │
                     ▼
                   PARSE
                     │
                     ▼
                  CLEAN
                     │
                     ▼
                 CHUNKING
                     │
                     ▼
                 METADATA
                     │
                     ▼
                EMBEDDINGS
                     │
                     ▼
              VECTOR DATABASE
```

This is the **offline/data preparation side** of RAG.

---

# 11. Query pipeline

Now a user asks:

> "How do I reset my company password?"

The query pipeline begins.

```text
User
 ↓
Question
 ↓
Query Pipeline
```

---

# 12. Step 1 — Query processing

The raw user question may need processing.

For example:

```text
"how do I reset it?"
```

could be ambiguous.

A query transformation system might rewrite it as:

```text
"How does an employee reset their company password?"
```

Possible query processing techniques include:

* query rewriting
* query expansion
* conversation-aware rewriting
* query decomposition

Not every system needs these.

---

# 13. Step 2 — Query embedding

The question is converted into an embedding.

```text
User Question
      ↓
Embedding Model
      ↓
Query Vector
```

For example:

```text
"How do I reset my password?"
                ↓
[0.14, -0.41, 0.79, ...]
```

The query vector can now be compared with document vectors.

---

# 14. Step 3 — Retrieval

The retriever searches the knowledge base.

```text
Query Vector
      ↓
Vector Database
      ↓
Similarity Search
      ↓
Top-N Candidates
```

For example:

```text
Chunk 31 → 0.93
Chunk 78 → 0.89
Chunk 102 → 0.85
Chunk 144 → 0.82
...
```

The system retrieves the strongest candidates.

---

# 15. Step 4 — Metadata filtering

You may also apply metadata filters.

Suppose:

```text
department = Engineering
year = 2026
```

The retrieval process becomes:

```text
All Documents
      ↓
Metadata / Permission Filter
      ↓
Allowed Documents
      ↓
Vector Search
      ↓
Candidates
```

This is especially important for enterprise systems.

---

# 16. Step 5 — Hybrid search

A production system may combine:

```text
Keyword Search
        +
Vector Search
```

For example:

```text
                Query
                  │
          ┌───────┴───────┐
          ▼               ▼
      Keyword          Vector
       Search           Search
          │               │
          └───────┬───────┘
                  ▼
             Combined
              Results
```

This can improve retrieval for both:

* exact terms
* semantic concepts

---

# 17. Step 6 — Reranking

Initial retrieval may return:

```text
50 candidates
```

A reranker then evaluates them more precisely.

```text
50 candidates
      ↓
   Reranker
      ↓
Top 5
```

For example:

```text
1. Password Reset Instructions
2. Account Security
3. Password Policy
4. Authentication
5. Employee Security
```

Now the system has a much better context set.

---

# 18. Step 7 — Context construction

The retrieved chunks need to be assembled into context for the LLM.

For example:

```text
SYSTEM:
Answer using the provided company documentation.

CONTEXT:

[Source: security-policy.pdf, page 15]

Users can reset their password from
Settings → Security → Reset Password.

[Source: employee-handbook.pdf, page 22]

Employees must follow the company's
password security requirements.

QUESTION:

How do I reset my company password?
```

This is called **context construction**.

The retrieved information is not simply thrown into the LLM randomly.

The application decides:

* which chunks to include
* their order
* how to label sources
* how much context to provide

---

# 19. Step 8 — Prompt construction

The application combines:

```text
System Instructions
        +
Retrieved Context
        +
User Question
```

Conceptually:

```text
System Prompt
      +
Context
      +
Question
      ↓
Final Prompt
```

For example:

```text
You are a company support assistant.

Use only the provided context.

Context:
[retrieved company documentation]

Question:
How do I reset my company password?
```

The LLM then receives this prompt.

---

# 20. Step 9 — LLM generation

The LLM uses:

```text
Question
+
Retrieved Context
+
Instructions
```

to generate the answer.

```text
Context
   +
Question
   ↓
  LLM
   ↓
Answer
```

Example:

> "You can reset your company password by going to Settings → Security → Reset Password."

---

# 21. Step 10 — Citations

A good RAG application can return the sources used to generate the answer.

For example:

```text
Answer:
You can reset your password from Settings → Security.

Sources:
- security-policy.pdf, page 15
- employee-handbook.pdf, page 22
```

This improves:

* trust
* transparency
* debugging
* verification

The application must preserve source metadata throughout the pipeline.

---

# 22. The complete query pipeline

```text
                   USER QUESTION
                         │
                         ▼
                 Query Processing
                         │
                         ▼
                  Query Embedding
                         │
                         ▼
               Metadata / ACL Filter
                         │
                         ▼
              ┌──────────┴──────────┐
              ▼                     ▼
        Keyword Search         Vector Search
              │                     │
              └──────────┬──────────┘
                         ▼
                  Merge Candidates
                         │
                         ▼
                      Reranking
                         │
                         ▼
                   Context Selection
                         │
                         ▼
                  Prompt Construction
                         │
                         ▼
                        LLM
                         │
                         ▼
                      Answer
                         │
                         ▼
                     Citations
```

Not every RAG system needs every step.

---

# 23. Complete RAG architecture

Putting both pipelines together:

```text
                    INDEXING PIPELINE

Documents
    │
    ▼
Ingestion
    │
    ▼
Parsing
    │
    ▼
Cleaning
    │
    ▼
Chunking
    │
    ▼
Metadata
    │
    ▼
Embeddings
    │
    ▼
Vector Database
    │
    │
════╪══════════════════════════════════════════
    │
    │
                    QUERY PIPELINE
    │
    ▼
User Question
    │
    ▼
Query Processing
    │
    ▼
Query Embedding
    │
    ▼
Retrieval
    │
    ▼
Reranking
    │
    ▼
Context Construction
    │
    ▼
Prompt
    │
    ▼
LLM
    │
    ▼
Answer
    │
    ▼
Citations
```

This is the architecture you should be able to draw in an interview.

---

# 24. Offline vs online processing

Another important distinction:

### Offline / ingestion

Usually happens when documents are added or updated.

```text
Document
 ↓
Chunk
 ↓
Embed
 ↓
Store
```

It doesn't need to happen for every user question.

### Online / query

Happens whenever a user asks something.

```text
Question
 ↓
Retrieve
 ↓
Rerank
 ↓
LLM
 ↓
Answer
```

This distinction matters for system design.

---

# 25. Document updates

Suppose the company updates:

```text
leave-policy.pdf
```

The indexing pipeline needs to process the new version.

```text
New Document
      ↓
Parse
      ↓
Chunk
      ↓
Embed
      ↓
Update Vector DB
```

Depending on the architecture, old chunks may need to be removed or versioned.

This is how RAG can work with changing knowledge.

---

# 26. Multiple data sources

A production RAG system may have multiple sources.

```text
                    Knowledge
                       │
        ┌──────────────┼───────────────┐
        ▼              ▼               ▼
       PDFs          GitHub           SQL
        │              │               │
        └──────────────┼───────────────┘
                       ▼
                Unified Retrieval
                       │
                       ▼
                      LLM
```

The retrieval layer can combine information from different sources.

---

# 27. RAG does not have to use only a vector database

A sophisticated system may retrieve from:

```text
Vector DB
SQL Database
Search Engine
Graph Database
APIs
File Storage
External Web
```

For example:

```text
User:
"What is customer 123's current subscription?"

        ↓

Query Router

        ↓

Customer Database
        ↓
Current Subscription
```

Whereas:

```text
User:
"How does our refund policy work?"

        ↓

RAG
        ↓
Company Documentation
```

This is why modern enterprise AI often combines RAG with **tool calling and agents**.

---

# 28. RAG pipeline with tools

A more advanced architecture:

```text
                         USER
                           │
                           ▼
                       AI SYSTEM
                           │
                           ▼
                    Query / Intent
                         Router
                           │
          ┌────────────────┼────────────────┐
          ▼                ▼                ▼
        RAG              SQL              API
          │                │                │
          └────────────────┼────────────────┘
                           ▼
                         LLM
                           │
                           ▼
                        Answer
```

The LLM can decide which information source is appropriate.

---

# 29. Failure points in a RAG pipeline

Every stage can fail.

```text
Document Parsing
       ↓
      FAIL

Chunking
       ↓
      FAIL

Embedding
       ↓
      FAIL

Retrieval
       ↓
      FAIL

Reranking
       ↓
      FAIL

Context Construction
       ↓
      FAIL

LLM Generation
       ↓
      FAIL
```

This is why debugging RAG requires understanding the entire pipeline.

---

# 30. Retrieval failure

Example:

```text
Question:
"What is the parental leave policy?"
```

But retrieval returns:

```text
Holiday policy
Attendance policy
Password policy
```

The LLM never received the correct information.

This is a **retrieval problem**, not necessarily an LLM problem.

---

# 31. Generation failure

Suppose retrieval returns:

```text
Parental Leave Policy:
Employees receive 20 days...
```

But the LLM answers:

> "Employees receive 10 days."

Now retrieval was successful.

The problem occurred during generation/reasoning.

This distinction is critical.

---

# 32. Context failure

Suppose retrieval finds the correct chunk:

```text
Chunk A
```

but the application accidentally excludes it while constructing the final prompt.

```text
Retrieval
   ↓
Correct Chunk
   ↓
Bad Context Construction
   ↓
LLM
   ↓
Wrong Answer
```

This is a separate failure stage.

---

# 33. RAG evaluation

A complete RAG system should be evaluated at multiple levels.

### Retrieval

```text
Did we find the right information?
```

Metrics include:

* Recall@K
* Precision@K
* Hit Rate
* MRR
* NDCG

### Generation

```text
Did the LLM produce a correct answer?
```

Evaluate:

* answer relevance
* faithfulness
* groundedness
* factual correctness

### End-to-end

```text
Did the user receive a useful answer?
```

---

# 34. RAG observability

Production RAG systems should make it possible to inspect:

```text
User Query
     ↓
Rewritten Query
     ↓
Retrieved Chunks
     ↓
Scores
     ↓
Reranked Chunks
     ↓
Final Context
     ↓
Prompt
     ↓
LLM Response
```

This makes debugging possible.

Without observability:

```text
Wrong Answer
    ↓
???
```

With observability:

```text
Wrong Answer
    ↓
Retriever missed correct chunk
    ↓
Fix retrieval
```

---

# 35. Latency

Every pipeline stage contributes latency.

```text
Query Processing
      +
Embedding
      +
Vector Search
      +
Reranking
      +
LLM
      ↓
Total Latency
```

For example:

```text
Embedding      → 50 ms
Retrieval      → 30 ms
Reranking      → 100 ms
LLM            → 800 ms
```

Total is roughly:

```text
980 ms
```

The exact values depend on the system.

Production engineering involves balancing:

```text
Quality
+
Latency
+
Cost
```

---

# 36. Cost

RAG has costs at multiple stages.

### Indexing

```text
Documents
 ↓
Embedding
 ↓
Storage
```

### Query

```text
Query Embedding
+
Reranking
+
LLM Input Tokens
+
LLM Output Tokens
```

Reducing unnecessary context can reduce LLM costs.

This is one reason retrieval and reranking matter.

---

# 37. Security

Enterprise RAG requires security throughout the pipeline.

Important concerns include:

```text
Authentication
Authorization
Document permissions
Prompt injection
Data leakage
Sensitive information
Audit logging
Tenant isolation
```

A critical principle:

> **Never assume that because the LLM is instructed not to reveal a document, the document is secure.**

Authorization should happen before sensitive information reaches the model.

---

# 38. Multi-tenant RAG

Suppose your application serves:

```text
Company A
Company B
Company C
```

Their documents must not leak across tenants.

Conceptually:

```text
Tenant A
  ↓
Tenant A documents


Tenant B
  ↓
Tenant B documents
```

Retrieval must respect tenant boundaries.

This is an important production concern for SaaS applications.

---

# 39. Simple RAG implementation

A basic implementation can be:

```text
Documents
    ↓
Chunk
    ↓
Embedding
    ↓
pgvector
    ↓
User Question
    ↓
Embedding
    ↓
Similarity Search
    ↓
Top 5 Chunks
    ↓
Prompt
    ↓
LLM
    ↓
Answer
```

This is enough to build your first RAG application.

Do not start with every advanced technique.

---

# 40. Advanced RAG implementation

Once the simple system works:

```text
Documents
    ↓
Parsing
    ↓
Structure-aware Chunking
    ↓
Embeddings
    ↓
Vector DB
    │
    │
User Query
    ↓
Query Rewriting
    ↓
ACL / Metadata Filtering
    ↓
Hybrid Search
    ↓
Top 50
    ↓
Reranking
    ↓
Top 5
    ↓
Context Compression
    ↓
Prompt
    ↓
LLM
    ↓
Answer + Citations
    ↓
Evaluation / Monitoring
```

This is closer to a production-grade architecture.

---

# 41. The 80/20 implementation path

Don't build the advanced version first.

### Level 1 — Basic RAG

```text
Chunk
 ↓
Embed
 ↓
Vector DB
 ↓
Retrieve
 ↓
LLM
```

### Level 2 — Better retrieval

```text
Metadata Filtering
+
Hybrid Search
+
Reranking
```

### Level 3 — Production

```text
Evaluation
+
Observability
+
Security
+
Caching
+
Monitoring
+
Data Updates
```

### Level 4 — Enterprise AI

```text
RAG
+
SQL
+
APIs
+
Tools
+
Agents
+
Workflow
```

This progression is much easier to learn than trying to understand everything at once.

---

# 42. The most important architecture to memorize

For interviews and system design, remember this:

```text
                    ┌──────────────────┐
                    │     DOCUMENTS    │
                    └────────┬─────────┘
                             │
                       INGESTION
                             │
                         CHUNKING
                             │
                        EMBEDDING
                             │
                             ▼
                    ┌──────────────────┐
                    │   VECTOR DB      │
                    └────────┬─────────┘
                             │
═════════════════════════════╪═════════════════════════════
                             │
                         USER QUERY
                             │
                             ▼
                    QUERY PROCESSING
                             │
                             ▼
                        RETRIEVAL
                             │
                             ▼
                        RERANKING
                             │
                             ▼
                    CONTEXT BUILDING
                             │
                             ▼
                           PROMPT
                             │
                             ▼
                            LLM
                             │
                             ▼
                          ANSWER
```

---

# 43. What you should remember

If you remember only one thing from this file, remember:

```text
                 INDEXING
                    │
Documents → Chunks → Embeddings → Vector DB
                                      │
══════════════════════════════════════╪════════
                                      │
                                    QUERY
                                      │
Question → Retrieval → Reranking → Context → LLM → Answer
```

The indexing pipeline **prepares knowledge**.

The query pipeline **uses that knowledge**.

---

# 44. Interview questions

You should be able to answer:

1. What is a RAG pipeline?
2. What is the indexing pipeline?
3. What is the query pipeline?
4. What is the difference between offline and online processing?
5. What happens when a document is added?
6. What happens when a user asks a question?
7. Where does chunking happen?
8. Where does embedding happen?
9. Where does retrieval happen?
10. Where does reranking happen?
11. How is retrieved context passed to the LLM?
12. How do citations work?
13. What happens if retrieval fails?
14. What happens if generation fails?
15. How would you debug a wrong RAG answer?
16. How do metadata filters fit into the pipeline?
17. Where does hybrid search fit?
18. Where does access control happen?
19. How do document updates work?
20. How do you evaluate a RAG pipeline?
21. What contributes to RAG latency?
22. What contributes to RAG cost?
23. How would you build a simple RAG system?
24. How would you evolve it into a production system?
25. Can RAG retrieve from SQL databases and APIs?

---

# 45. Final mental model

```text
                        RAG
                         │
          ┌──────────────┴──────────────┐
          │                             │
          ▼                             ▼
     INDEXING                         QUERY
          │                             │
          ▼                             ▼
      Documents                     Question
          │                             │
       Chunking                  Query Processing
          │                             │
      Embeddings                    Retrieval
          │                             │
          ▼                         Reranking
      Vector DB                        │
          │                             ▼
          │                         Context
          │                             │
          └─────────────────────────────┤
                                        ▼
                                       LLM
                                        │
                                        ▼
                                      Answer
```

**Core idea:**

> **A RAG pipeline prepares external knowledge during indexing, retrieves the most relevant knowledge at query time, and gives that knowledge to an LLM to generate a grounded response.**

Next: **`10-rag-vs-fine-tuning.md`**.
