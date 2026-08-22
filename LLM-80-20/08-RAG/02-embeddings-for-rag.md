# Embeddings for RAG

## 1. What is an embedding?

An **embedding** is a numerical representation of data—usually text—that captures semantic meaning.

For example:

```text
"How do I reset my password?"
```

can be converted into something conceptually like:

```text
[0.12, -0.45, 0.78, 0.21, ...]
```

This list of numbers is called a **vector**.

The actual vector may contain hundreds or thousands of dimensions depending on the embedding model.

The important idea is:

> **Embedding converts meaning into a mathematical representation that machines can compare.**

---

# 2. Why does RAG need embeddings?

A user doesn't necessarily use the same words as the document.

Suppose your document says:

```text
Users can change their credentials from the account settings page.
```

The user asks:

```text
"Where can I reset my password?"
```

There is not an exact word match.

But the two sentences are semantically related.

Embeddings allow the system to represent both pieces of text in vector space:

```text
User Question
      ↓
Embedding
      ↓
Query Vector


Document Chunk
      ↓
Embedding
      ↓
Document Vector
```

The system can then compare the vectors.

---

# 3. Keyword search vs semantic search

Consider:

```text
Document:
"Employees may modify their credentials from account settings."

Question:
"How can I change my password?"
```

### Keyword search

It may look for:

```text
change
password
```

The document doesn't contain those exact words.

It may therefore miss the relevant information.

### Semantic search

The embedding model represents the meaning of both texts.

```text
"change my password"
        ↓
   similar meaning
        ↓
"modify credentials"
```

This allows semantic search to find the relevant document.

---

# 4. Embedding pipeline

The basic process is:

```text
Text
 ↓
Embedding Model
 ↓
Vector
```

For RAG:

```text
Document Chunk
       ↓
Embedding Model
       ↓
Document Vector
       ↓
Vector Database
```

When the user asks a question:

```text
User Question
       ↓
Embedding Model
       ↓
Query Vector
       ↓
Vector Database
       ↓
Similar Document Vectors
```

This is the foundation of vector retrieval.

---

# 5. Document embeddings

Suppose your document is:

```text
"Employees receive 20 days of annual leave."
```

The embedding model converts it into:

```text
[0.17, -0.32, 0.81, 0.44, ...]
```

The exact numbers don't matter to us.

What matters is that the vector represents information about the text's semantic meaning.

Another document:

```text
"Employees receive 10 days of sick leave."
```

will have another vector.

```text
Annual leave
     ↓
[0.17, -0.32, 0.81, ...]

Sick leave
     ↓
[0.61,  0.11, 0.23, ...]
```

---

# 6. Query embeddings

When the user asks:

```text
"How many vacation days do employees get?"
```

the question is also converted into an embedding.

```text
User Question
      ↓
Embedding Model
      ↓
Query Vector
```

The vector database then searches for document vectors that are similar to the query vector.

Conceptually:

```text
Query Vector
     │
     ├──── Document A → Similarity: 0.91
     ├──── Document B → Similarity: 0.72
     ├──── Document C → Similarity: 0.38
     └──── Document D → Similarity: 0.21
```

The system can retrieve the highest-ranked documents.

---

# 7. Embeddings are not the answer

An embedding model does **not** normally generate the final answer.

This distinction is important.

```text
Embedding Model
       ↓
Converts text → vectors
```

Whereas:

```text
LLM
 ↓
Generates text
```

A typical RAG system uses both:

```text
                 RAG
                  │
        ┌─────────┴─────────┐
        ▼                   ▼
Embedding Model            LLM
        │                   │
   Search meaning       Generate answer
```

---

# 8. Embedding model vs LLM

They have different jobs.

| Component       | Main purpose              |
| --------------- | ------------------------- |
| Embedding model | Convert text into vectors |
| Vector database | Store/search vectors      |
| Retriever       | Find relevant information |
| LLM             | Generate the final answer |

Think of it as:

```text
Embedding Model → "Where is the relevant information?"
LLM             → "What should I say about it?"
```

---

# 9. Vector dimensions

An embedding is represented as a vector with a fixed number of dimensions.

For example:

```text
[0.12, 0.44, -0.18, 0.72]
```

This example has:

```text
4 dimensions
```

Real embedding models commonly produce much larger vectors.

For example:

```text
768 dimensions
1024 dimensions
1536 dimensions
3072 dimensions
```

The number depends on the model.

You should **not assume that more dimensions automatically means better embeddings**.

Embedding quality depends on the model, data, language, task, and retrieval setup.

---

# 10. What does a dimension mean?

Don't think of:

```text
dimension 1 = happiness
dimension 2 = technology
dimension 3 = employee
```

That is generally not how embeddings should be interpreted.

The dimensions collectively represent learned features of the data.

For practical RAG development:

> **Treat the embedding vector as a mathematical representation rather than something humans manually interpret dimension by dimension.**

---

# 11. Similar meanings should be close

Imagine a simplified 2D vector space:

```text
                  Dogs
                   ●
                  /
                 /
        Animals ●
               /
              /
             ● Cats


                               Cars ●
```

Texts with related meanings tend to be positioned closer together according to the embedding model.

For example:

```text
"How do I fix my car?"
```

and:

```text
"My vehicle has a mechanical problem."
```

may be represented as semantically related vectors.

While:

```text
"How do I bake a cake?"
```

would likely be located farther away.

This is the intuition behind semantic search.

---

# 12. Similarity is not the same as equality

Suppose:

```text
A = "How do I reset my password?"

B = "Where can I change my credentials?"
```

They are not identical sentences.

But their meanings may be similar.

Embeddings allow the system to calculate a **similarity score**.

Conceptually:

```text
A ↔ B
Similarity = High
```

Whereas:

```text
A ↔ "What is the weather today?"
Similarity = Low
```

The actual similarity calculation is covered in:

```text
06-cosine-similarity.md
```

---

# 13. The embedding model must be the same

Suppose you create document embeddings using:

```text
Embedding Model A
```

Then later create the query embedding using:

```text
Embedding Model B
```

This can cause problems because the vectors may not exist in the same embedding space.

The normal approach is:

```text
Documents
    ↓
Embedding Model A
    ↓
Vectors
    ↓
Vector Database


User Query
    ↓
Embedding Model A
    ↓
Query Vector
    ↓
Search
```

The embedding model used for indexing and querying should be compatible.

---

# 14. Embedding models

There are many embedding models.

Examples include models from:

* OpenAI
* Cohere
* Google
* Hugging Face
* Voyage
* open-source embedding models

The important thing is not memorizing every model.

Instead, understand how to evaluate one.

Consider:

```text
Embedding Model
       ↓
Retrieval Quality
       ↓
RAG Quality
```

A poor embedding model can result in poor retrieval.

---

# 15. Choosing an embedding model

When selecting an embedding model, consider:

### 1. Retrieval quality

Does it find relevant information?

### 2. Language support

Does it work well with the languages in your documents?

### 3. Domain

Does it work well with:

```text
general text
technical documentation
legal documents
medical documents
code
```

depending on your use case?

### 4. Latency

How quickly can it generate embeddings?

### 5. Cost

Is it an API model or locally hosted model?

### 6. Vector dimensions

Larger vectors can affect storage and search costs.

### 7. Deployment

Can it run locally?

Can it run on your infrastructure?

---

# 16. Embedding documents during indexing

Suppose you have:

```text
company-policy.pdf
```

The indexing process might look like:

```text
PDF
 ↓
Extract text
 ↓
Chunk
 ↓
Chunk 1 ──→ Embedding
Chunk 2 ──→ Embedding
Chunk 3 ──→ Embedding
Chunk 4 ──→ Embedding
 ↓
Store vectors
```

The vector database might conceptually contain:

```text
{
    "text": "Employees receive 20 days...",
    "embedding": [0.12, -0.45, ...],
    "metadata": {
        "document": "company-policy.pdf",
        "page": 10
    }
}
```

---

# 17. Embedding the user query

When the user asks:

```text
"How many vacation days do employees receive?"
```

the application performs:

```text
Question
   ↓
Embedding Model
   ↓
Query Vector
   ↓
Vector Database
   ↓
Similarity Search
   ↓
Top relevant chunks
```

Notice that the **same embedding process** is used for the query.

---

# 18. Why chunking happens before embedding

You generally don't want to embed a massive 200-page document as one giant vector.

Instead:

```text
200-page PDF
      ↓
     Chunks
      ↓
Chunk 1 → Vector
Chunk 2 → Vector
Chunk 3 → Vector
...
Chunk N → Vector
```

This allows retrieval to return the specific portion relevant to the user's question.

This is why:

```text
Chunking
   +
Embeddings
   +
Vector Search
```

work together.

---

# 19. Embeddings and metadata

An embedding usually isn't stored alone.

A vector database record can contain:

```text
{
    "id": "chunk-123",

    "text": "Employees receive 20 days...",

    "embedding": [0.12, -0.45, ...],

    "metadata": {
        "document": "leave-policy.pdf",
        "page": 10,
        "department": "HR",
        "year": 2026
    }
}
```

This becomes useful when you want to filter retrieval.

For example:

```text
department = "HR"
year = 2026
```

Then perform semantic search over the filtered data.

---

# 20. Embeddings for text are not limited to RAG

Embeddings are useful in many systems.

### Semantic search

```text
Question
 ↓
Embedding
 ↓
Search
```

### Recommendation systems

```text
User preferences
      ↓
Embedding
      ↓
Similar products/content
```

### Clustering

```text
Documents
   ↓
Embeddings
   ↓
Group similar documents
```

### Duplicate detection

```text
Text A
 ↓
Embedding

Text B
 ↓
Embedding

Compare
 ↓
Similar?
```

### Classification

Embeddings can also be used as representations for downstream ML systems.

---

# 21. Important limitation

Embeddings don't understand everything perfectly.

For example:

```text
"Apple"
```

could refer to:

```text
Apple the company
```

or:

```text
apple the fruit
```

Context matters.

A good embedding model can represent context better, but semantic retrieval is still imperfect.

Therefore:

```text
Embedding
   ↓
Candidate retrieval
   ↓
Reranking
   ↓
LLM
```

is often better than relying on embeddings alone.

---

# 22. Embedding vs keyword search

### Keyword search

Looks primarily for matching terms.

```text
"JWT authentication"
```

may find documents containing:

```text
JWT
authentication
```

### Embedding search

Looks for semantic relationships.

```text
"How do I authenticate API requests?"
```

could retrieve:

```text
"JWT authentication implementation"
```

even if the exact wording differs.

### Best approach

In many production systems:

```text
Keyword Search
      +
Vector Search
      ↓
Hybrid Search
      ↓
Reranking
```

You will study hybrid search in:

```text
05-similarity-search.md
```

---

# 23. The complete embedding flow

Remember this diagram:

```text
             INDEXING
                 │
                 ▼
            Document
                 │
                 ▼
              Chunk
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
          Vector Database
                 │
                 ▼
        Similar Documents
```

This is one of the most important diagrams in RAG.

---

# 24. Practical example

Suppose you are building a **company knowledge assistant**.

Documents:

```text
engineering-guide.pdf
leave-policy.pdf
security-policy.pdf
```

After processing:

```text
Chunk 1 → embedding → Vector DB
Chunk 2 → embedding → Vector DB
Chunk 3 → embedding → Vector DB
...
```

User asks:

```text
"What should I do if my laptop is compromised?"
```

The query is embedded:

```text
Question
   ↓
Embedding
   ↓
Query Vector
```

The vector database finds:

```text
security-policy.pdf
```

relevant chunks.

Those chunks are then passed to the LLM.

```text
Query
  +
Retrieved Chunks
  ↓
LLM
  ↓
Answer
```

---

# 25. What you should remember

The simplest mental model is:

```text
Text
 ↓
Embedding Model
 ↓
Vector
 ↓
Similarity Search
 ↓
Relevant Text
```

For RAG:

```text
Documents
 ↓
Chunks
 ↓
Embeddings
 ↓
Vector Database

User Question
 ↓
Query Embedding
 ↓
Vector Search
 ↓
Relevant Chunks
 ↓
LLM
 ↓
Answer
```

### Remember these five points

1. **Embedding = numerical representation of meaning.**
2. **Documents and queries are both embedded.**
3. **Vectors allow semantic similarity search.**
4. **The embedding model is different from the LLM that generates the answer.**
5. **Good embeddings improve retrieval, but embeddings alone do not make a good RAG system.**

---

# 26. Interview questions

You should be able to answer:

1. What is an embedding?
2. Why are embeddings used in RAG?
3. What is a vector?
4. What is semantic search?
5. What is the difference between embeddings and an LLM?
6. Why do we embed documents?
7. Why do we embed user queries?
8. Why should query and document embeddings be compatible?
9. What are embedding dimensions?
10. Does more dimensionality always mean better embeddings?
11. How do you choose an embedding model?
12. Why do we chunk documents before embedding?
13. What information is stored alongside an embedding?
14. What is the difference between keyword and semantic search?
15. Can embeddings be used outside RAG?

If you can explain **why a RAG system converts both the document chunks and the user's question into vectors**, you understand the fundamental purpose of embeddings.

Next:

```text
03-document-chunking.md
```
