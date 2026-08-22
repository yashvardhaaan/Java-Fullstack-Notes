# What is RAG?

## 1. What is RAG?

**RAG (Retrieval-Augmented Generation)** is a technique where an LLM retrieves relevant information from an external knowledge source and uses that information to generate an answer.

Instead of asking an LLM to answer only from what it already knows:

```text
User Question
      ↓
     LLM
      ↓
   Answer
```

RAG adds a retrieval step:

```text
User Question
      ↓
   Retrieval
      ↓
Relevant Information
      ↓
     LLM
      ↓
   Answer
```

The core idea is:

> **Find the right information first, then ask the LLM to reason over that information.**

---

# 2. Why do we need RAG?

An LLM has several limitations.

### Problem 1 — Knowledge can be outdated

An LLM may not know about information created after its training data.

For example:

```text
"What is our company's 2026 leave policy?"
```

The model cannot reliably answer if that policy is stored in an internal document that it has never seen.

RAG can retrieve the company's latest policy.

---

### Problem 2 — Private information

Suppose a company has:

```text
HR policies
Engineering documentation
Customer data
Product documentation
Internal wikis
Database records
```

The LLM normally does not know this private information.

RAG allows the application to retrieve relevant private information at runtime.

---

### Problem 3 — Hallucination

An LLM can sometimes generate information that sounds convincing but is incorrect.

RAG provides relevant context:

```text
Question
   ↓
Retrieve trusted information
   ↓
Give information to LLM
   ↓
Generate answer from context
```

This can significantly improve grounding.

RAG does **not** guarantee zero hallucinations.

---

### Problem 4 — Updating knowledge

Suppose a company changes its policy.

With RAG:

```text
Old document
     ↓
Replace/update document
     ↓
Re-index
     ↓
Future questions retrieve new information
```

You don't necessarily need to retrain the LLM.

---

# 3. RAG vs normal LLM

### Normal LLM

```text
User
 ↓
Question
 ↓
LLM
 ↓
Answer
```

The model primarily relies on its learned parameters and whatever context you provide directly.

### RAG

```text
User
 ↓
Question
 ↓
Retriever
 ↓
Relevant Documents
 ↓
LLM
 ↓
Answer
```

The important addition is the **retriever**.

---

# 4. The complete RAG architecture

A practical RAG system has two major pipelines.

## A. Indexing pipeline

This happens when you prepare your knowledge.

```text
Documents
    ↓
Document Loading
    ↓
Cleaning
    ↓
Chunking
    ↓
Embedding
    ↓
Vector Database
```

Example:

```text
company-policy.pdf
       ↓
   extract text
       ↓
     chunks
       ↓
   embeddings
       ↓
   Vector DB
```

The purpose is to make your documents searchable.

---

## B. Query pipeline

This happens when a user asks a question.

```text
User Question
      ↓
Query Processing
      ↓
Embedding
      ↓
Vector Search
      ↓
Relevant Chunks
      ↓
Reranking
      ↓
Context
      ↓
Prompt
      ↓
LLM
      ↓
Answer
```

This is the actual runtime RAG process.

---

# 5. Example

Imagine an organization has these documents:

```text
documents/
├── employee-handbook.pdf
├── leave-policy.pdf
├── engineering-guide.pdf
└── security-policy.pdf
```

A user asks:

> "How many days of parental leave can an employee take?"

The system doesn't normally send all four documents to the LLM.

Instead:

```text
Question
   ↓
Search knowledge base
   ↓
Find relevant chunks
   ↓
leave-policy.pdf
   ↓
Relevant text
   ↓
LLM
   ↓
Answer
```

The LLM receives something conceptually like:

```text
System:
Answer using the provided context.

Context:
[Relevant section from leave-policy.pdf]

Question:
How many days of parental leave can an employee take?
```

Then the LLM generates the response.

---

# 6. What exactly does RAG retrieve?

RAG doesn't necessarily retrieve an entire document.

Usually, documents are divided into smaller pieces called **chunks**.

For example:

```text
Large PDF
   ↓
─────────────────────
Chunk 1
Chunk 2
Chunk 3
Chunk 4
Chunk 5
...
Chunk 100
─────────────────────
```

When the user asks a question, the system searches these chunks and retrieves the most relevant ones.

This is why **chunking, embeddings, similarity search, and retrieval** are fundamental RAG concepts.

---

# 7. What is an embedding doing here?

An embedding converts text into a numerical vector.

For example:

```text
"How do I reset my password?"
            ↓
      Embedding Model
            ↓
[0.12, -0.42, 0.81, ...]
```

A document chunk is also converted into a vector.

```text
"Users can reset their password from Settings..."
            ↓
      Embedding Model
            ↓
[0.10, -0.39, 0.79, ...]
```

Similar meanings tend to produce vectors that are close according to the chosen similarity measure.

This allows the system to search for **meaning**, rather than only exact words.

You will study embeddings in:

```text
02-embeddings-for-rag.md
```

---

# 8. Where does the information live?

The processed document chunks and their embeddings are commonly stored in a vector-capable database.

Examples include:

```text
PostgreSQL + pgvector
Pinecone
Weaviate
Qdrant
Milvus
Chroma
```

Conceptually:

```text
Chunk
  +
Embedding
  +
Metadata
      ↓
Vector Database
```

Example metadata:

```text
{
    "document": "leave-policy.pdf",
    "department": "HR",
    "year": 2026,
    "page": 12
}
```

Metadata can later be used for filtering.

---

# 9. RAG does NOT train the LLM

This is one of the most important concepts.

### RAG

```text
Knowledge
   ↓
External data
   ↓
Retrieve at runtime
   ↓
LLM
```

### Fine-tuning

```text
Training data
   ↓
Training process
   ↓
Model parameters change
```

RAG does not normally modify the LLM's weights.

It provides additional information to the LLM during inference.

---

# 10. RAG vs Fine-tuning

| RAG                                           | Fine-tuning                                        |
| --------------------------------------------- | -------------------------------------------------- |
| Adds external knowledge at runtime            | Changes model behavior through training            |
| Good for changing knowledge                   | Good for behavior/style/task adaptation            |
| Knowledge can be updated by changing the data | Updating knowledge may require additional training |
| Can provide retrieved sources                 | Does not inherently provide sources                |
| Uses retrieval infrastructure                 | Uses training infrastructure                       |
| Useful for private/company knowledge          | Useful for specialized behavior                    |

A system can also use **both**.

```text
Fine-tuned model
       +
RAG
       ↓
Specialized RAG application
```

---

# 11. RAG is more than a vector database

A common beginner misconception is:

> "RAG means putting PDFs into a vector database."

That is only part of the system.

A real RAG pipeline can contain:

```text
Document ingestion
        ↓
Document processing
        ↓
Chunking
        ↓
Embeddings
        ↓
Vector storage
        ↓
Query processing
        ↓
Retrieval
        ↓
Hybrid search
        ↓
Reranking
        ↓
Context construction
        ↓
Prompt construction
        ↓
LLM
        ↓
Answer
        ↓
Evaluation
```

Each component can affect the final answer.

---

# 12. The two most important RAG pipelines

Always keep these two diagrams in your head.

## Indexing

```text
Documents
    ↓
Load
    ↓
Clean
    ↓
Chunk
    ↓
Embed
    ↓
Store
```

This prepares the knowledge base.

## Query

```text
Question
    ↓
Process Query
    ↓
Embed Query
    ↓
Retrieve
    ↓
Rerank
    ↓
Build Context
    ↓
Prompt LLM
    ↓
Generate Answer
```

This answers the user's question.

---

# 13. Why retrieval quality matters

Suppose the correct chunk is:

```text
Chunk 57
```

But retrieval returns:

```text
Chunk 12
Chunk 31
Chunk 44
```

The LLM may produce a poor answer even if the LLM itself is extremely capable.

This leads to an important principle:

> **A better LLM cannot completely compensate for bad retrieval.**

RAG quality depends on multiple stages.

```text
Document Quality
       ↓
Chunking Quality
       ↓
Embedding Quality
       ↓
Retrieval Quality
       ↓
Reranking Quality
       ↓
Context Quality
       ↓
LLM Generation
       ↓
Final Answer
```

---

# 14. RAG does not automatically eliminate hallucinations

RAG can ground an LLM in retrieved information, but hallucinations can still occur.

For example:

```text
Wrong retrieval
      ↓
Wrong context
      ↓
LLM
      ↓
Wrong answer
```

Or:

```text
Correct context
      ↓
LLM misunderstands context
      ↓
Wrong answer
```

Therefore, production RAG requires:

* good retrieval
* good prompts
* source attribution
* evaluation
* access control
* monitoring
* hallucination detection/mitigation

---

# 15. Where is RAG used?

RAG is useful when an application needs to answer questions using external or changing information.

### Enterprise knowledge assistant

```text
Company documents
      ↓
RAG
      ↓
Employee assistant
```

### Customer support

```text
Product documentation
+
Troubleshooting guides
+
FAQs
      ↓
RAG
      ↓
Support assistant
```

### Developer assistant

```text
GitHub repositories
+
API documentation
+
Architecture docs
      ↓
RAG
      ↓
Coding assistant
```

### Legal/document assistant

```text
Contracts
+
Policies
+
Regulations
      ↓
RAG
      ↓
Question answering
```

### Research assistant

```text
Research papers
+
Reports
+
Articles
      ↓
RAG
      ↓
Research assistant
```

---

# 16. RAG with databases

RAG doesn't have to work only with PDFs.

The knowledge source can be:

```text
PDF
DOCX
Markdown
HTML
Web pages
GitHub
SQL database
NoSQL database
API
Internal wiki
Cloud storage
```

The important question is:

> **How can the system retrieve the right information when the user asks a question?**

---

# 17. RAG and structured data

Not every question should be answered through vector search.

Suppose the user asks:

> "What is the current balance of customer 1024?"

That information might be better retrieved directly from a database.

```text
User Question
      ↓
Question Router
      ├──→ Vector Search
      │
      ├──→ SQL Database
      │
      └──→ API
```

Modern AI systems can therefore combine:

```text
RAG
+
SQL
+
APIs
+
LLM
+
Tools
```

This becomes especially important in **agentic enterprise AI systems**.

---

# 18. RAG limitations

RAG is not always the best solution.

Problems can include:

### Poor chunking

```text
Bad chunks
    ↓
Bad retrieval
    ↓
Bad answer
```

### Poor embeddings

```text
Poor representation
    ↓
Poor similarity search
```

### Too much context

Giving the LLM too many irrelevant chunks can make the answer worse.

### Missing information

If the required information isn't in the knowledge base, retrieval cannot magically find it.

### Security problems

A user should not be able to retrieve documents they are not authorized to access.

### Data freshness

If documents aren't updated or re-indexed correctly, the system can retrieve outdated information.

---

# 19. The RAG mental model

Remember this:

```text
RAG = Retrieve + Augment + Generate
```

### Retrieve

Find relevant information.

```text
Question
   ↓
Search
   ↓
Relevant chunks
```

### Augment

Add the retrieved information to the LLM's context.

```text
Question
+
Retrieved Context
      ↓
    Prompt
```

### Generate

The LLM generates the answer using that context.

```text
Prompt
  ↓
LLM
  ↓
Answer
```

Therefore:

```text
              RAG
               │
       ┌───────┼────────┐
       ▼       ▼        ▼
    Retrieve  Augment  Generate
       │       │        │
    Search   Context    LLM
       │       │        │
       └───────┴────────┘
                ↓
             Answer
```

---

# 20. What you should be able to explain after this file

You should be able to answer these questions without memorizing a definition:

1. What problem does RAG solve?
2. Why can't we simply use an LLM?
3. What is the difference between RAG and fine-tuning?
4. What happens when a user asks a question in a RAG system?
5. What is the indexing pipeline?
6. What is the query pipeline?
7. Why are documents chunked?
8. Why are embeddings needed?
9. Why do we need a vector database?
10. What does retrieval do?
11. What does reranking do?
12. Why doesn't RAG completely eliminate hallucinations?
13. Why is retrieval quality important?
14. Can RAG use databases and APIs instead of PDFs?
15. What are the major limitations of RAG?

If you can explain these **in your own words**, move to:

```text
02-embeddings-for-rag.md
```
