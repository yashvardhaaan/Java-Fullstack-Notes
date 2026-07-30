# Introduction to AI Testing

> **Goal:** Understand what AI Testing is, why it is different from traditional software testing, and how AI products are tested in real companies.

---

# Why Should You Study AI Testing?

Artificial Intelligence is becoming part of almost every software product.

Today companies are integrating AI into:

- Customer Support
- Healthcare
- Banking
- Coding Assistants
- Search Engines
- Education
- Recruitment
- Cybersecurity

Unlike traditional software, AI systems **do not always produce the same output for the same input**.

Because of this, traditional software testing techniques alone are not enough.

Companies such as OpenAI, Microsoft, Google, Amazon, Meta, Anthropic, TraceLink, Salesforce, and many startups now hire engineers who understand **AI Quality Assurance (AI QA)**.

If you know Java, Spring Boot, Selenium, API Testing, and AI Testing, you become a much stronger Software Development Engineer in Test (SDET) or AI QA Engineer.

---

# Real World Example

Imagine a banking chatbot.

Customer asks:

> "How can I transfer ₹20,000 to another account?"

The chatbot should explain the correct procedure.

Now imagine the chatbot replies:

> "Transfer money using your ATM PIN through email."

This answer is completely incorrect.

Traditional software testing might say:

- API returned HTTP 200 ✅

But AI testing asks:

- Is the answer factually correct?
- Is the answer safe?
- Is the answer complete?
- Is the answer understandable?
- Could this harm the customer?

These are AI Testing problems.

---

# What is AI Testing?

AI Testing is the process of verifying that an Artificial Intelligence system behaves correctly, safely, reliably, and consistently under different situations.

Unlike traditional software testing, AI testing evaluates:

- Accuracy
- Safety
- Reliability
- Fairness
- Performance
- Robustness
- Hallucinations
- Bias
- Toxicity

---

# Traditional Software vs AI Software

| Traditional Software | AI Software |
|----------------------|------------|
| Rule Based | Probability Based |
| Same input → Same output | Same input may produce different outputs |
| Easy to verify | Difficult to verify |
| Fixed logic | Learned behavior |
| Mostly deterministic | Non-deterministic |
| Functional correctness | Correctness + Quality + Safety |

---

# Why Traditional Testing Is Not Enough

Suppose a login API returns:

```text
200 OK
```

The test passes.

Now suppose ChatGPT answers:

> The capital of Australia is Sydney.

The API also returns:

```text
200 OK
```

Traditional testing says:

PASS

AI testing says:

FAIL

Because the answer is incorrect.

---

# Goals of AI Testing

A QA Engineer tries to answer questions like:

- Is the answer correct?
- Is the answer complete?
- Is the answer harmful?
- Is the answer biased?
- Is the answer offensive?
- Is the answer reproducible?
- Is the answer grounded in trusted data?
- Does it follow business rules?

---

# Types of AI Applications

You may test:

- Chatbots
- AI Assistants
- AI Agents
- Recommendation Systems
- Fraud Detection
- Resume Screening
- Medical Diagnosis
- OCR Systems
- Voice Assistants
- Image Generation
- Code Generation
- Document Search (RAG)

Each requires different testing strategies.

---

# AI Testing Life Cycle

```text
Requirement Analysis
        │
        ▼
Understand AI Feature
        │
        ▼
Prepare Test Strategy
        │
        ▼
Create Prompt Library
        │
        ▼
Prepare Test Cases
        │
        ▼
Run AI Tests
        │
        ▼
Evaluate Output
        │
        ▼
Report Bugs
        │
        ▼
Regression Testing
        │
        ▼
Release
```

---

# Industry AI Architecture

```text
User
   │
   ▼
Frontend
   │
   ▼
Backend API
   │
   ▼
LLM
(ChatGPT/Llama/Claude)
   │
   ▼
Database
Vector Database
Tools
Memory
Functions
   │
   ▼
Response
```

A QA engineer may test every layer.

---

# What Does an AI QA Engineer Test?

## UI

- Buttons
- Forms
- Chat interface

---

## Backend

- APIs
- Authentication
- Database

---

## AI

- Prompt quality
- Hallucination
- Bias
- Toxicity
- Context retention
- Memory
- Tool calling
- RAG retrieval
- Latency

---

# Skills Required

Technical:

- Java
- Selenium
- Playwright
- REST APIs
- SQL
- Git
- Docker

AI:

- Prompt Engineering
- LLM Basics
- RAG
- Vector Databases
- AI Agents

Testing:

- Manual Testing
- Automation Testing
- API Testing
- Database Testing
- Performance Testing

---

# Industry Workflow

Suppose OpenAI releases a new chatbot.

Developer

↓

Implements feature

↓

QA receives requirement

↓

Creates prompt library

↓

Runs thousands of prompts

↓

Measures

- Accuracy
- Latency
- Cost
- Safety
- Hallucination

↓

Reports failures

↓

Developer fixes issues

↓

Regression Testing

↓

Production

---

# Common AI Bugs

- Hallucinations
- Wrong calculations
- Missing context
- Prompt injection
- Unsafe responses
- Toxic language
- Slow responses
- Tool failure
- Infinite reasoning loops
- Incorrect citations

---

# Industry Tools

Testing

- Selenium
- Playwright
- Postman
- REST Assured

AI

- OpenAI
- Ollama
- LM Studio
- LangChain
- LangGraph
- CrewAI

Evaluation

- LangSmith
- DeepEval
- Promptfoo
- TruLens

Documentation

- Jira
- Confluence
- Notion

---

# Practical Exercise

Install Ollama.

Download Llama 3.

Run:

```bash
ollama run llama3
```

Ask:

```
Who is the Prime Minister of India?
```

Now ask:

```
What is the capital of Mars?
```

Observe:

- Correct answer
- Incorrect answer
- Hallucinated answer

Document your observations.

---

# Mini Project

Test an AI chatbot.

Prepare:

- 20 prompts
- Expected behavior
- Actual behavior
- Bug reports
- Suggestions for improvement

---

# Common Mistakes

- Only checking if API returns 200 OK.
- Ignoring factual correctness.
- Not testing edge cases.
- Forgetting safety testing.
- Testing only happy paths.
- Not documenting prompts.
- Ignoring response consistency.

---

# Interview Questions

### What is AI Testing?

### How is AI Testing different from Software Testing?

### What is hallucination?

### What is prompt testing?

### What is bias testing?

### What metrics do you use to evaluate an LLM?

### What tools have you used for AI testing?

---

# Quick Revision

✔ AI is probabilistic.

✔ Same prompt can generate different outputs.

✔ AI testing focuses on correctness, safety, and reliability.

✔ Traditional testing is not enough.

✔ Prompt quality is part of testing.

✔ AI QA Engineers evaluate outputs, not just APIs.

---

# Assignment

Choose one chatbot:

- ChatGPT
- Gemini
- Claude
- Perplexity

Create:

- 30 prompts
- 10 functional tests
- 10 edge cases
- 10 negative tests

Document all results.

---

# Next Topic

➡ **02-LLM Testing.md**