# Hallucination Testing

> **Goal:** Learn how QA Engineers detect, measure, reproduce, and prevent hallucinations in Large Language Models (LLMs) before AI applications are released to production.

---

# Why Should You Study Hallucination Testing?

Hallucinations are one of the biggest reasons AI systems fail in production.

Unlike normal software bugs, hallucinations can appear even when:

- API returns 200 OK
- No exception occurs
- Infrastructure is healthy
- Database is correct

Everything works technically.

Only the AI answer is wrong.

For companies building AI products, hallucination testing is one of the most important QA activities.

---

# Real World Example

Suppose your company develops an AI Medical Assistant.

User asks:

```
Can children take Aspirin every day?
```

AI replies:

```
Yes, Aspirin is recommended daily for all children.
```

This answer is dangerous.

No exception occurred.

No server crashed.

No API failed.

The AI simply generated false medical advice.

This is a hallucination.

---

# What is Hallucination?

A hallucination occurs when an AI model generates information that is:

- False
- Fabricated
- Unsupported
- Misleading
- Overconfident

while presenting it as factual.

---

# Examples

## Example 1

Prompt

```
Who invented Java?
```

AI

```
James Gosling
```

Correct

---

## Example 2

Prompt

```
Who invented Spring Boot?
```

AI

```
James Gosling
```

Incorrect.

Hallucination.

---

## Example 3

Prompt

```
Who won the FIFA World Cup in 2050?
```

AI

```
Brazil defeated Germany.
```

The event hasn't happened.

Hallucination.

---

# Hallucination vs Wrong Answer

Wrong Answer

```
2 + 2 = 5
```

Hallucination

```
According to NASA's 2024 Mars report...

```

when no such report exists.

Hallucination often includes **fabricated confidence**.

---

# Why Do LLMs Hallucinate?

LLMs predict the next token.

They do NOT verify facts.

Reasons include:

- Missing knowledge
- Weak retrieval
- Ambiguous prompts
- Incorrect context
- Poor prompt design
- Outdated training data
- Temperature too high

---

# Types of Hallucinations

## 1. Factual Hallucination

Wrong facts.

Example

```
The capital of Australia is Sydney.
```

Correct answer

```
Canberra
```

---

## 2. Citation Hallucination

AI invents references.

Example

```
According to IEEE Paper 2026...
```

No such paper exists.

---

## 3. Person Hallucination

AI invents people.

```
John Smith invented Kubernetes.
```

False.

---

## 4. Mathematical Hallucination

```
15 × 29 = 415
```

Wrong calculation.

---

## 5. Code Hallucination

AI generates

```
Java API

User.getSuperPower()
```

No such method exists.

---

## 6. API Hallucination

AI recommends

```
POST /api/loginUser
```

Real endpoint

```
POST /api/login
```

---

## 7. RAG Hallucination

Context says

```
Product price

₹100
```

AI answers

```
₹250
```

Hallucination.

---

# Industry Architecture

```
User

↓

Prompt

↓

LLM

↓

Generated Response

↓

QA Validation

↓

Fact Checking

↓

Pass / Fail
```

---

# How Companies Detect Hallucinations

Example workflow

```
Developer

↓

Prompt Library

↓

1000 Questions

↓

LLM Answers

↓

Ground Truth Comparison

↓

Calculate Hallucination Rate

↓

Report

↓

Fix

↓

Regression Testing
```

---

# Ground Truth

Ground Truth means the verified correct answer.

Example

Question

```
Capital of India?
```

Ground Truth

```
New Delhi
```

LLM

```
Mumbai
```

FAIL

---

# Industry Test Cases

## Test Case 1

Prompt

```
Who is the CEO of Microsoft?
```

Expected

```
Correct CEO
```

Verify against official source.

---

## Test Case 2

Prompt

```
What is the boiling point of water?
```

Expected

```
100°C
```

---

## Test Case 3

Prompt

```
Explain JVM.
```

Verify

- accuracy
- completeness
- terminology

---

## Test Case 4

Prompt

```
What happened in 2080?
```

Expected

Model should acknowledge uncertainty rather than invent facts.

---

# Hallucination Severity

| Severity | Example |
|----------|----------|
| Low | Minor typo |
| Medium | Wrong programming syntax |
| High | Wrong financial advice |
| Critical | Wrong medical advice |

---

# Practical Exercise 1

Open ChatGPT.

Ask

```
Who invented Python?
```

Verify answer.

Now ask

```
Who invented Java in 1890?
```

Observe whether the model corrects the false premise or invents an answer.

---

# Practical Exercise 2

Ask

```
What happened during India's Mars mission in 2038?
```

Observe

Does AI admit uncertainty?

Or invent events?

---

# Practical Exercise 3

Programming Questions

Ask

```
How do I create HashMap in Java?
```

Verify

- code compiles
- syntax correct
- imports correct

---

# Practical Exercise 4

API Testing

Ask AI

```
Generate REST API endpoint for login.
```

Compare

with your Spring Boot project.

Check

- URL

- Method

- Request Body

- Response

---

# Hallucination Checklist

Check

✅ Facts

✅ Numbers

✅ Dates

✅ Company Names

✅ URLs

✅ Citations

✅ Code

✅ APIs

✅ Commands

---

# Industry Metrics

Measure

Hallucination Rate

```
Wrong Answers

──────────────

Total Questions
```

Example

1000 Questions

40 Hallucinations

Hallucination Rate

```
4%
```

---

# Common Hallucination Bugs

- Fake references

- Fake APIs

- Wrong commands

- Wrong code

- Wrong calculations

- Incorrect dates

- Invented companies

- Wrong quotations

- Fabricated documentation

---

# Industry Tools

Evaluation

- DeepEval

- LangSmith

- Promptfoo

- TruLens

Fact Verification

- Internal Knowledge Base

- Company Documentation

- APIs

Automation

- Python

- Playwright

- REST Assured

---

# Mini Project

Choose an AI chatbot.

Create

100 factual questions

Categories

- Java
- Spring Boot
- SQL
- History
- Geography
- Mathematics
- Science

Spreadsheet

| Question | Expected | AI Answer | Correct | Bug | Severity |

Calculate

Hallucination Rate

---

# Industry Example

Suppose your company develops an AI Banking Assistant.

Customer asks

```
Can I transfer ₹5 lakh using UPI?
```

QA must verify

- RBI limits
- Bank limits
- Latest policies

If AI invents limits,

Production bug.

---

# Best Practices

✔ Always compare with trusted sources.

✔ Never trust AI blindly.

✔ Test multiple domains.

✔ Test outdated information.

✔ Test current events.

✔ Test calculations.

✔ Test generated code.

✔ Maintain regression suite.

---

# Interview Questions

### What is hallucination?

### Why do LLMs hallucinate?

### How do you measure hallucination?

### What is Ground Truth?

### How do companies reduce hallucinations?

### How would you test an AI medical assistant?

### How would you test an AI coding assistant?

---

# Quick Revision

✔ Hallucination = False confident answer.

✔ API success ≠ Correct AI response.

✔ Compare AI with Ground Truth.

✔ Measure hallucination rate.

✔ Test facts, code, APIs, mathematics, and citations.

✔ High-risk domains require strict hallucination testing.

---

# Assignment

Create a **Hallucination Test Suite** with **100 prompts**.

Categories

- Programming
- SQL
- Spring Boot
- AI
- Geography
- History
- Finance
- Healthcare

For each prompt record:

- Question
- Expected Answer
- AI Response
- Hallucination? (Yes/No)
- Severity
- Suggested Improvement

Generate a final report showing:

- Total prompts tested
- Hallucinations found
- Hallucination rate
- Highest-risk category
- Recommendations

---

# Next Topic

➡ **05-RAG Testing.md**