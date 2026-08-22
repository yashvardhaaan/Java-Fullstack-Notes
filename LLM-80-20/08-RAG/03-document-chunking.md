# Document Chunking

## 1. What is document chunking?

**Document chunking** is the process of breaking a large document into smaller pieces called **chunks** before storing them in a RAG system.

Instead of treating this:

```text
200-page PDF
```

as one piece of information, we divide it:

```text
200-page PDF
      ↓
 ┌──────────┐
 │ Chunk 1  │
 ├──────────┤
 │ Chunk 2  │
 ├──────────┤
 │ Chunk 3  │
 ├──────────┤
 │   ...    │
 ├──────────┤
 │ Chunk N  │
 └──────────┘
```

These chunks are then embedded and stored in the vector database.

The basic pipeline is:

```text
Document
   ↓
Extract text
   ↓
Clean text
   ↓
Chunk text
   ↓
Create embeddings
   ↓
Store in vector DB
```

---

# 2. Why do we need chunking?

There are three major reasons.

## Reason 1 — Documents are too large

A document may contain thousands or millions of tokens.

You don't want to send the entire document to the LLM for every question.

Instead:

```text
Large Document
      ↓
Small relevant chunks
      ↓
LLM
```

---

## Reason 2 — Retrieval needs useful units of information

Suppose a 100-page document contains:

```text
Page 1 → Introduction
Page 20 → Authentication
Page 50 → Database
Page 80 → Deployment
```

User asks:

> "How does authentication work?"

You want to retrieve the authentication section rather than the entire 100-page document.

```text
100-page document
       ↓
    Chunking
       ↓
Authentication chunks
       ↓
     Retrieval
       ↓
       LLM
```

---

## Reason 3 — Better retrieval

If chunks are too large:

```text
Large Chunk
 ├── relevant information
 ├── unrelated information
 ├── unrelated information
 └── unrelated information
```

The retrieved context contains lots of noise.

If chunks are too small:

```text
Chunk A → "Authentication uses"
Chunk B → "JWT tokens for"
Chunk C → "API authorization."
```

The meaning may be split across chunks.

Therefore:

> **Good chunking tries to preserve meaningful information while keeping chunks small enough for effective retrieval.**

---

# 3. Chunking in the RAG pipeline

Chunking happens during **indexing**, before embeddings are created.

```text
                INDEXING
                   │
                   ▼
               Document
                   │
                   ▼
              Text Extraction
                   │
                   ▼
                Chunking
                   │
          ┌────────┼────────┐
          ▼        ▼        ▼
       Chunk 1  Chunk 2  Chunk 3
          │        │        │
          ▼        ▼        ▼
       Embedding Embedding Embedding
          │        │        │
          └────────┼────────┘
                   ▼
              Vector DB
```

This means:

> **Chunking determines what units your retrieval system can find.**

---

# 4. What is a chunk?

A chunk is a piece of the original document.

For example:

```text
Original:

"JSON Web Tokens are commonly used for stateless
authentication. The server generates a token after
successful authentication. The client sends the
token with subsequent requests."
```

A chunk might be:

```text
"JSON Web Tokens are commonly used for stateless
authentication. The server generates a token after
successful authentication."
```

Another chunk:

```text
"The client sends the token with subsequent requests."
```

The exact boundaries depend on the chunking strategy.

---

# 5. Chunk size

**Chunk size** determines approximately how much text goes into each chunk.

For example:

```text
Chunk size = 500 tokens
```

means each chunk is approximately 500 tokens.

Conceptually:

```text
Document
│
├── 500 tokens
├── 500 tokens
├── 500 tokens
├── 500 tokens
└── ...
```

There is no universal perfect chunk size.

The correct size depends on:

* document type
* content structure
* embedding model
* retrieval method
* query type
* context window
* application requirements

---

# 6. Tokens vs characters vs words

Chunking can be based on different units.

### Characters

```text
Chunk = 2000 characters
```

### Words

```text
Chunk = 400 words
```

### Tokens

```text
Chunk = 500 tokens
```

Tokens are particularly useful when working with LLMs because LLM context limits are measured in tokens.

However, character-based or structure-aware chunking can also be useful.

---

# 7. Chunk overlap

One of the most important chunking concepts is **overlap**.

Suppose:

```text
Chunk size = 500 tokens
Overlap = 50 tokens
```

Then:

```text
Chunk 1
────────────────────────────────
tokens 1 → 500
                         │
                         │ 50-token overlap
                         ▼
                    Chunk 2
                    ────────────────────────────────
                    tokens 451 → 950
```

The next chunk starts before the previous chunk completely ends.

---

# 8. Why do we need overlap?

Consider:

```text
Chunk 1:
"The authentication process starts when the
user provides their credentials..."

Chunk 2:
"...the server validates the credentials and
generates a JWT token."
```

The complete concept spans the boundary.

Without overlap, the system may retrieve only half of the information.

With overlap:

```text
Chunk 1
   ↘
    Shared context
   ↗
Chunk 2
```

the important context is more likely to remain available.

---

# 9. Chunk overlap has a trade-off

More overlap is not always better.

Suppose:

```text
Chunk size = 500
Overlap = 400
```

You will store lots of duplicated information.

```text
Chunk 1 → 1–500
Chunk 2 → 101–600
Chunk 3 → 201–700
```

This causes:

* more storage
* more embeddings
* more processing
* duplicate retrieval results
* potentially more irrelevant context

Therefore:

> **Overlap should preserve context, not create unnecessary duplication.**

---

# 10. Fixed-size chunking

The simplest strategy is to split text into chunks of approximately equal size.

Example:

```text
Document
    ↓
500-token chunks
    ↓
Chunk 1
Chunk 2
Chunk 3
...
```

### Advantages

* simple
* predictable
* easy to implement
* fast

### Problems

It can split information in the middle of:

* sentences
* paragraphs
* lists
* code blocks
* tables

Example:

```text
Chunk 1:
"The server authenticates the user and"

Chunk 2:
"generates a JWT token."
```

The boundary is not ideal.

---

# 11. Recursive chunking

A more practical approach is to try larger natural boundaries first.

Conceptually:

```text
Document
   ↓
Paragraph
   ↓
Sentence
   ↓
Words
   ↓
Characters
```

The splitter attempts to keep meaningful structures together while respecting the maximum chunk size.

For example:

```text
Document
  ↓
Sections
  ↓
Paragraphs
  ↓
Sentences
```

This is commonly more useful than blindly cutting every N characters.

---

# 12. Sentence-based chunking

Another strategy is to split based on sentences.

Example:

```text
Sentence 1
Sentence 2
Sentence 3
Sentence 4
```

Then combine sentences until the desired chunk size is reached.

```text
Chunk 1:
Sentence 1
Sentence 2
Sentence 3

Chunk 2:
Sentence 4
Sentence 5
Sentence 6
```

This preserves sentence boundaries.

---

# 13. Paragraph-based chunking

Paragraphs often represent complete ideas.

```text
Paragraph 1 → Chunk
Paragraph 2 → Chunk
Paragraph 3 → Chunk
```

This can work well for:

* articles
* documentation
* policies
* reports

But a paragraph may sometimes be too large or too small.

---

# 14. Structure-aware chunking

This is particularly important for technical documentation.

Suppose you have:

```text
# Authentication

## JWT

JWT is used for authentication.

## Refresh Tokens

Refresh tokens are used to obtain...
```

A good chunking strategy should preserve the structure.

For example:

```text
Chunk:
Title: Authentication
Section: JWT

JWT is used for authentication...
```

The heading provides valuable context.

---

# 15. Why metadata matters during chunking

When creating a chunk, don't only store the text.

Store useful metadata too.

For example:

```text
{
    "text": "JWT tokens are used...",
    "metadata": {
        "document": "security-guide.pdf",
        "page": 15,
        "section": "Authentication",
        "heading": "JWT",
        "chunk_id": 42
    }
}
```

This helps with:

* filtering
* citations
* debugging
* tracing retrieved information
* displaying sources to users

---

# 16. PDF chunking

PDFs are particularly difficult.

A PDF may contain:

```text
Text
Tables
Images
Headers
Footers
Columns
Page numbers
Code
Charts
```

Simply extracting all text and splitting every 500 characters can destroy the original structure.

For example:

```text
Original:

Table
Employee | Leave
Alice    | 20
Bob      | 15
```

Poor extraction might become:

```text
Employee Leave Alice 20 Bob 15
```

Now the relationships may be unclear.

Therefore:

> **Document parsing is often as important as chunking.**

---

# 17. Markdown chunking

Markdown is easier because it already contains structure.

Example:

```text
# Authentication

Introduction...

## JWT

JWT explanation...

## Refresh Tokens

Refresh token explanation...
```

You can preserve:

```text
document
 └── heading
      └── subsection
           └── content
```

This makes Markdown particularly convenient for RAG knowledge bases.

---

# 18. Code chunking

Code should not always be chunked like normal text.

Consider:

```java
public class UserService {

    public User getUser(Long id) {
        ...
    }
}
```

Splitting randomly could produce:

```text
Chunk 1:
public class UserService {

Chunk 2:
public User getUser(Long id) {
```

which destroys useful context.

For code, it is often better to chunk around:

* classes
* methods
* functions
* modules
* files

while preserving relevant imports and context.

---

# 19. Tables

Tables require special handling.

Suppose:

```text
| Model | Price | Range |
|-------|-------|-------|
| A     | 10    | 100   |
| B     | 20    | 200   |
```

A naive text splitter may destroy the table structure.

For questions such as:

> "What is the range of Model B?"

you need the retrieved representation to preserve the relationship between:

```text
Model B → Range → 200
```

This is why structured document parsing matters in production RAG.

---

# 20. Semantic chunking

**Semantic chunking** tries to divide text based on changes in meaning rather than simply counting tokens.

Conceptually:

```text
Paragraph 1
Paragraph 2
Paragraph 3
       ↓
Same topic
       ↓
Chunk 1


Paragraph 4
Paragraph 5
       ↓
New topic
       ↓
Chunk 2
```

The goal is:

> **Keep information that belongs together in the same chunk.**

This can improve retrieval in some use cases, but it may be more computationally expensive than simple chunking.

---

# 21. Chunking is a retrieval problem

This is one of the most important ideas.

Don't ask:

> "What chunk size does everyone use?"

Ask:

> **"What chunking strategy helps my retriever find the information required to answer my users' questions?"**

For example:

### API documentation

You may want:

```text
Endpoint
Parameters
Request
Response
Example
```

kept together.

### Legal documents

You may want:

```text
Section
Clause
Subclause
```

preserved.

### Source code

You may want:

```text
Class
Method
Dependencies
```

preserved.

### Company policies

You may want:

```text
Policy
Section
Rules
Exceptions
```

preserved.

---

# 22. Chunk size trade-off

Think of chunk size like this:

```text
Too Small
   ↓
Missing context
Fragmented information
Poor answers


Good Size
   ↓
Relevant information
Enough context
Efficient retrieval


Too Large
   ↓
Irrelevant information
More tokens
More expensive prompts
Lower retrieval precision
```

There is no universal perfect number.

You should test your data.

---

# 23. Chunking and retrieval quality

Suppose the correct answer requires:

```text
Chunk 10 + Chunk 11
```

but your chunking creates:

```text
Chunk 10 → first half
Chunk 11 → unrelated information
Chunk 12 → second half
```

Retrieval becomes harder.

Therefore:

```text
Good Chunking
      ↓
Better Retrieval
      ↓
Better Context
      ↓
Better Answer
```

---

# 24. Chunking and embeddings work together

Remember:

```text
Document
   ↓
Chunking
   ↓
Chunks
   ↓
Embedding
   ↓
Vectors
   ↓
Vector DB
```

You are not embedding the original document as one giant object.

You are generally embedding individual chunks.

Therefore the chunk becomes the **retrievable unit**.

---

# 25. Practical example

Imagine your company has:

```text
security-policy.md
```

It contains:

```text
# Security Policy

## Password Policy

Passwords must contain...

## MFA

Employees must enable MFA...

## Device Security

Company laptops must...
```

A structure-aware chunker might create:

```text
Chunk 1
---------
Security Policy
Password Policy

Passwords must contain...


Chunk 2
---------
Security Policy
MFA

Employees must enable MFA...


Chunk 3
---------
Security Policy
Device Security

Company laptops must...
```

Now a question:

```text
"What is the MFA requirement?"
```

can retrieve:

```text
Chunk 2
```

instead of the entire document.

---

# 26. Practical chunking workflow

A production-style ingestion pipeline may look like:

```text
             Document
                 ↓
          Document Loader
                 ↓
         Text Extraction
                 ↓
              Cleaning
                 ↓
       Structure Detection
                 ↓
             Chunking
                 ↓
          Add Metadata
                 ↓
           Embedding
                 ↓
          Vector Database
```

Notice that chunking isn't necessarily the first operation.

You first need usable content.

---

# 27. Common chunking mistakes

## Mistake 1 — Using one chunk size everywhere

```text
PDF → 500 tokens
Markdown → 500 tokens
Code → 500 tokens
Tables → 500 tokens
```

Different data types have different structures.

---

## Mistake 2 — Ignoring document structure

Randomly splitting headings from their content can reduce retrieval quality.

---

## Mistake 3 — Excessive overlap

This creates duplicate information and increases cost.

---

## Mistake 4 — Chunks without metadata

Without metadata, debugging and citations become harder.

---

## Mistake 5 — Never evaluating chunking

Changing chunking strategy can dramatically change retrieval quality.

Don't assume a strategy works.

Test it.

---

# 28. How to choose chunking strategy

Use this decision process:

```text
What type of data?
        ↓
 ┌──────┼─────────┐
 ▼      ▼         ▼
Docs   Code     Tables
 │      │         │
 ▼      ▼         ▼
Structure-aware   Specialized parsing
 │
 ▼
Choose chunk size
 │
 ▼
Choose overlap
 │
 ▼
Evaluate retrieval
 │
 ▼
Adjust
```

The final decision should be based on **retrieval performance**, not a popular default.

---

# 29. What you should remember

The core idea:

> **Chunking converts large documents into meaningful, retrievable units.**

Remember this pipeline:

```text
Large Document
      ↓
Extract
      ↓
Clean
      ↓
Chunk
      ↓
Metadata
      ↓
Embed
      ↓
Vector DB
```

And remember:

```text
Too Small
    → insufficient context

Too Large
    → too much irrelevant context

Good Chunk
    → enough information to answer a question
```

The most important principle is:

> **Chunk according to the structure and retrieval needs of your data.**

---

# 30. Interview questions

You should be able to answer:

1. What is document chunking?
2. Why is chunking necessary in RAG?
3. What happens if chunks are too large?
4. What happens if chunks are too small?
5. What is chunk overlap?
6. Why is overlap useful?
7. Why can excessive overlap be harmful?
8. What is fixed-size chunking?
9. What is recursive chunking?
10. What is semantic chunking?
11. Why should document structure be preserved?
12. How would you chunk Markdown documentation?
13. How would you chunk source code?
14. Why are PDFs difficult to chunk?
15. Why should chunks contain metadata?
16. How would you choose a chunk size?
17. How would you evaluate whether your chunking strategy is good?
18. Why does chunking affect retrieval quality?

---

# 31. Final mental model

```text
             DOCUMENT
                 │
                 ▼
          Extract / Parse
                 │
                 ▼
              Clean
                 │
                 ▼
             CHUNKING
                 │
        ┌────────┼────────┐
        ▼        ▼        ▼
      Chunk    Chunk    Chunk
        │        │        │
        ▼        ▼        ▼
    Metadata  Metadata  Metadata
        │        │        │
        └────────┼────────┘
                 ▼
             EMBEDDING
                 │
                 ▼
           VECTOR DATABASE
                 │
                 ▼
             RETRIEVAL
```

The key relationship is:

**Document structure → Chunking → Embeddings → Retrieval quality.**

Next:

`04-vector-databases.md`
