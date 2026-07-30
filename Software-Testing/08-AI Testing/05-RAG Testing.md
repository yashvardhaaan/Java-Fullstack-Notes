# RAG Testing (Retrieval-Augmented Generation Testing)

> **Goal:** Learn how QA Engineers test Retrieval-Augmented Generation (RAG) systems to ensure the AI retrieves the correct information from a knowledge base before generating an accurate response.

---

# Why Should You Study RAG Testing?

Most enterprise AI applications do **not** rely only on the LLM's training data.

Instead, they retrieve company-specific information from:

- PDFs
- Internal Documentation
- Databases
- Knowledge Bases
- Product Manuals
- Policies
- SOPs
- SharePoint
- Confluence
- Notion

This architecture is called **Retrieval-Augmented Generation (RAG).**

Companies like Microsoft, Salesforce, ServiceNow, Atlassian, TraceLink, Amazon, and OpenAI use RAG extensively.

As a QA Engineer, your responsibility is to verify that:

- Correct documents are retrieved.
- Correct chunks are selected.
- AI doesn't invent information.
- AI cites the right source.

---

# Real World Example

Suppose TraceLink has an internal policy document.

Question

```
How many days of paid leave do employees receive?
```

Knowledge Base says

```
20 Paid Leaves
```

AI replies

```
Employees receive 30 paid leaves.
```

The LLM itself is fine.

The bug is in the retrieval process.

---

# What is RAG?

RAG stands for

**Retrieval-Augmented Generation**

Instead of answering directly,

the AI first searches company data.

Then generates the answer.

---

# Traditional LLM

```
User

↓

LLM

↓

Answer
```

Only model knowledge is used.

---

# RAG System

```
User

↓

Retriever

↓

Knowledge Base

↓

Relevant Documents

↓

LLM

↓

Answer
```

---

# Complete RAG Architecture

```
                Documents

        PDF

        Word

        Website

        Database

             │

             ▼

Text Extraction

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

             ▼

Retriever

             │

             ▼

LLM

             │

             ▼

Generated Answer
```

QA can test every stage.

---

# Components of RAG

## 1. Documents

Source of truth.

Examples

- Employee Handbook
- Product Documentation
- Medical Guidelines
- Banking Rules

---

## 2. Chunking

Large documents are divided into small pieces.

Example

```
100 Page PDF

↓

500 Chunks
```

Poor chunking

↓

Wrong retrieval.

---

## 3. Embeddings

Each chunk becomes a vector.

```
Text

↓

Embedding

↓

Vector
```

QA doesn't verify embedding math,

but verifies retrieval quality.

---

## 4. Vector Database

Stores embeddings.

Examples

- Pinecone
- ChromaDB
- Weaviate
- Milvus
- FAISS

---

## 5. Retriever

Searches the vector database.

Returns

Top K documents.

---

## 6. Generator

LLM combines

Prompt

+

Retrieved Context

↓

Final Answer

---

# What Does a QA Engineer Test?

- Correct retrieval
- Missing retrieval
- Duplicate retrieval
- Wrong chunk
- Wrong citation
- Hallucination
- Latency
- Ranking
- Context quality

---

# Industry Workflow

Developer uploads documents

↓

Embedding generated

↓

Stored in Vector Database

↓

QA prepares test queries

↓

Retriever returns documents

↓

LLM generates answer

↓

QA validates answer

↓

Regression Testing

↓

Release

---

# Test Cases

## Retrieval Accuracy

Question

```
How many casual leaves are available?
```

Expected

Correct HR document retrieved.

---

## Wrong Document Retrieval

Question

```
Leave policy
```

Retrieved

```
Network Security Policy
```

FAIL

---

## Missing Context

Question

```
How to reset password?
```

No document retrieved.

FAIL

---

## Duplicate Retrieval

Retriever returns

Same document

5 times.

FAIL

---

## Citation Testing

Expected

```
Employee Handbook Page 25
```

Actual

```
No citation
```

FAIL

---

## Multi-document Retrieval

Question

```
Compare Leave Policy and Work From Home Policy.
```

Expected

Retrieve both documents.

---

# Common RAG Bugs

- Wrong document
- Missing chunk
- Duplicate chunk
- Incorrect ranking
- Hallucinated answer
- Missing citation
- Outdated document
- Broken embedding
- Vector DB failure

---

# Chunk Testing

Suppose

```
Employee Handbook

100 pages
```

Chunk Size

```
500 Characters
```

QA verifies

- No sentence cut in half

- Important context preserved

- Headings included

---

# Retrieval Testing

Question

```
How can I apply for leave?
```

Verify

Retrieved chunk actually contains

Leave Policy.

---

# Citation Testing

Expected

```
Source

Employee Handbook

Page 21
```

Verify

- Citation exists

- Page number correct

- Document correct

---

# Ranking Testing

Retriever returns

```
Document A

Document B

Document C
```

Verify

Most relevant document appears first.

---

# Practical Exercise 1

Create a PDF

```
Company Policy
```

Upload

into a RAG chatbot.

Ask

```
What is the leave policy?
```

Verify

Correct paragraph retrieved.

---

# Practical Exercise 2

Ask

```
What is the office timing?
```

Modify PDF.

Upload again.

Verify

Updated answer.

---

# Practical Exercise 3

Remove the document.

Ask

same question.

Expected

AI should admit

No information available.

Not hallucinate.

---

# Practical Exercise 4

Create two PDFs.

One

```
HR Policy
```

One

```
Travel Policy
```

Ask

```
How do I book business travel?
```

Verify

Correct document selected.

---

# Industry Metrics

## Retrieval Accuracy

```
Correct Retrievals

───────────────

Total Queries
```

---

## Citation Accuracy

```
Correct Citations

──────────────

Total Responses
```

---

## Hallucination Rate

```
Hallucinated Responses

────────────────────

Total Queries
```

---

## Latency

Measure

Question

↓

Retriever

↓

LLM

↓

Final Response

---

# Industry Tools

Frameworks

- LangChain
- LlamaIndex
- Haystack

Vector Databases

- Pinecone
- ChromaDB
- Weaviate
- Milvus
- FAISS

Evaluation

- LangSmith
- DeepEval
- Promptfoo
- TruLens

Automation

- Playwright
- REST Assured

---

# Mini Project

Build a simple RAG chatbot using

- LangChain
- Ollama
- ChromaDB

Upload

Employee Handbook

Create

100 test questions.

Spreadsheet

| Question | Expected Document | Retrieved Document | Citation | Correct | Bug |

Calculate

- Retrieval Accuracy
- Citation Accuracy
- Hallucination Rate

---

# Industry Example

Suppose TraceLink uploads

```
Serialization Guide.pdf
```

Employee asks

```
How do I create a shipment?
```

QA verifies

- Correct document retrieved
- Correct section selected
- Correct answer generated
- Proper citation displayed
- No hallucination

---

# Best Practices

✔ Test retrieval before testing generation.

✔ Verify citations.

✔ Test outdated documents.

✔ Test duplicate documents.

✔ Test missing documents.

✔ Test large PDFs.

✔ Test multilingual documents.

✔ Regression test after every document update.

---

# Interview Questions

### What is RAG?

### Why is RAG better than using only an LLM?

### What is a Vector Database?

### What is Chunking?

### What are Embeddings?

### How do you test retrieval quality?

### How do you detect RAG hallucinations?

### How would you test a PDF chatbot?

### What metrics would you measure in a RAG system?

---

# Quick Revision

✔ RAG = Retrieval + Generation.

✔ AI first retrieves documents, then generates answers.

✔ QA verifies retrieval quality before generation quality.

✔ Test chunks, citations, rankings, and retrieved context.

✔ Hallucination often results from poor retrieval.

---

# Assignment

Build or use any RAG chatbot (LangChain, Ollama, ChatGPT with uploaded documents, etc.).

Prepare:

- 100 user questions
- Expected source document
- Expected answer
- Actual answer
- Retrieved document
- Citation
- Pass/Fail
- Bug Type

Finally create a **RAG Evaluation Report** containing:

- Retrieval Accuracy
- Citation Accuracy
- Hallucination Rate
- Average Response Time
- Top 10 Bugs Found
- Recommendations

---

# Next Topic

➡ **06-AI Agent Testing.md**