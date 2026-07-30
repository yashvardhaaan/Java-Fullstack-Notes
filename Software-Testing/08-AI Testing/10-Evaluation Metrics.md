# Evaluation Metrics for AI Systems

> **Goal:** Learn how QA Engineers evaluate AI systems using objective metrics instead of relying only on human judgment. This chapter covers the metrics used by companies like OpenAI, Anthropic, Google, Microsoft, Amazon, Meta, and enterprise AI teams.

---

# Why Should You Study Evaluation Metrics?

Traditional software testing is straightforward.

Example

```
Input

2 + 2

↓

Expected Output

4
```

Pass or Fail.

AI is different.

Example

```
Explain Java.
```

There isn't only one correct answer.

Many different answers can be correct.

So how do companies decide whether an AI model is good?

They use **Evaluation Metrics**.

---

# Real World Example

Suppose your company develops an AI Customer Support Assistant.

Prompt

```
How do I reset my password?
```

Model A

```
Go to Settings → Security → Reset Password.
```

Model B

```
Open Profile Settings, select Change Password,
verify OTP and save.
```

Both may be correct.

Instead of checking exact wording,

QA measures

- Correctness
- Completeness
- Groundedness
- Latency
- Cost
- Safety

---

# What are Evaluation Metrics?

Evaluation Metrics are measurable indicators used to determine the quality of AI responses.

Instead of asking

```
Is this response good?
```

Companies ask

```
How accurate?

How complete?

How fast?

How safe?

How consistent?
```

---

# AI Evaluation Pipeline

```
User Prompt

↓

LLM

↓

Generated Response

↓

Evaluation

↓

Metrics

↓

Score

↓

Report
```

---

# Types of Evaluation

## Human Evaluation

Humans read responses.

Give ratings.

Example

```
Accuracy

★★★★☆
```

Advantages

- High quality

Disadvantages

- Expensive
- Slow
- Subjective

---

## Automated Evaluation

Software evaluates responses automatically.

Advantages

- Fast
- Cheap
- Repeatable

Disadvantages

- Cannot understand everything

Most companies combine both.

---

# Core Evaluation Metrics

## 1. Accuracy

Question

```
Capital of India?
```

Expected

```
New Delhi
```

Model

```
New Delhi
```

Accuracy

100%

---

## 2. Correctness

Checks whether information is factually correct.

Example

```
Java was created by James Gosling.
```

Correct.

---

## 3. Completeness

Prompt

```
Explain JVM.
```

Incomplete

```
JVM runs Java.
```

Complete

- Definition
- Components
- Memory
- Class Loader
- Execution Engine

---

## 4. Relevance

Prompt

```
Explain Spring Boot.
```

Model explains

```
Python Flask
```

Low relevance.

---

## 5. Consistency

Run

Same prompt

20 times.

Do answers remain consistently good?

---

## 6. Groundedness

Very important for RAG.

Retrieved Document

```
Leave Policy

20 Days
```

Model

```
20 Days
```

Grounded.

Model

```
35 Days
```

Not grounded.

---

## 7. Faithfulness

Checks whether the AI answer is supported by retrieved documents.

No invented information.

---

## 8. Hallucination Rate

```
Hallucinated Answers

────────────────────

Total Responses
```

Example

1000 Questions

25 Hallucinations

Rate

```
2.5%
```

---

## 9. Safety Score

Measures

- Toxicity
- Harmful advice
- Unsafe content
- Bias

Higher score

↓

Safer AI.

---

## 10. Bias Score

Measures fairness across

- Gender
- Age
- Language
- Nationality

---

## 11. Response Time

```
Prompt

↓

First Token

↓

Last Token
```

Measure

- Average latency
- Maximum latency

---

## 12. Token Usage

```
Input Tokens

+

Output Tokens

=

Total Tokens
```

More tokens

↓

Higher cost.

---

## 13. Cost per Request

Example

```
1000 Tokens

↓

₹0.40
```

Companies monitor

Monthly AI cost.

---

## 14. Tool Calling Accuracy

Agent should

Choose

Correct Tool.

```
Correct Tool Calls

────────────────

Total Tool Calls
```

---

## 15. Retrieval Accuracy

For RAG

```
Correct Retrievals

────────────────

Total Queries
```

---

## 16. Citation Accuracy

Expected

```
Employee Handbook

Page 24
```

Verify

- Document
- Page
- Source

---

## 17. Workflow Success Rate

For AI Agents

```
Successful Tasks

────────────────

Total Tasks
```

---

# Traditional NLP Metrics

These are still used in research and some production pipelines.

---

## BLEU

Measures overlap between generated text and reference text.

Useful for

- Machine Translation
- Text Generation

Higher BLEU

↓

Better similarity.

---

## ROUGE

Measures overlap of important words.

Mostly used for

- Summarization

---

## METEOR

Considers

- Synonyms
- Word order

Better than BLEU for some tasks.

---

## BERTScore

Uses semantic similarity instead of exact word matching.

More suitable for modern LLMs.

---

# LLM-as-a-Judge

Modern evaluation technique.

Instead of humans,

another LLM evaluates.

Example

```
Prompt

↓

Candidate Answer

↓

GPT-5

↓

Score
```

Companies use this to reduce manual effort, but still validate critical cases with human review.

---

# Evaluation Scorecard

Example

| Metric | Score |
|---------|-------|
| Accuracy | 96% |
| Groundedness | 94% |
| Hallucination Rate | 2% |
| Safety | 99% |
| Bias | Low |
| Average Latency | 1.8 s |
| Retrieval Accuracy | 95% |

---

# Industry Workflow

Requirements

↓

Prepare Evaluation Dataset

↓

Run AI

↓

Collect Responses

↓

Automatic Evaluation

↓

Human Review

↓

Generate Metrics

↓

Regression Testing

↓

Release

---

# Practical Exercise 1

Ask

```
Explain JVM.
```

Evaluate

- Accuracy
- Completeness
- Relevance
- Formatting

Give each category

Score

1–5.

---

# Practical Exercise 2

Create

20 programming questions.

Compare

ChatGPT

vs

Gemini

Measure

- Accuracy
- Latency
- Completeness

---

# Practical Exercise 3

Upload a PDF to a RAG chatbot.

Ask

20 questions.

Measure

- Retrieval Accuracy
- Citation Accuracy
- Groundedness

---

# Practical Exercise 4

Test an AI Agent.

Measure

- Workflow Success
- Tool Accuracy
- Response Time

---

# Common Evaluation Mistakes

- Measuring only accuracy
- Ignoring latency
- Ignoring hallucinations
- Ignoring cost
- Small evaluation datasets
- No regression testing
- No human review for high-risk domains

---

# Industry Tools

Evaluation

- DeepEval
- Promptfoo
- LangSmith
- TruLens
- Ragas

Monitoring

- Langfuse
- Weights & Biases
- Arize AI

Automation

- Playwright
- REST Assured
- Selenium

Data Analysis

- Python
- Pandas
- Jupyter Notebook

---

# Mini Project

Evaluate an AI FAQ Chatbot.

Prepare

100 user questions.

For every response record

| Prompt | Accuracy | Grounded | Safe | Latency | Cost | Pass |

Generate

- Overall Accuracy
- Hallucination Rate
- Retrieval Accuracy
- Average Latency
- Average Cost
- Final Quality Score

Create a dashboard summarizing the results.

---

# Industry Example

Suppose TraceLink develops an AI assistant for pharmaceutical supply chains.

QA creates an evaluation dataset of **500 real customer questions**.

After running the assistant, the team measures:

- Accuracy of answers
- Retrieval Accuracy
- Citation Accuracy
- Hallucination Rate
- Safety Score
- Average Response Time
- Tool Call Success Rate

Only after these metrics meet predefined quality thresholds is the release approved.

---

# Best Practices

✔ Define metrics before development begins.

✔ Build a representative evaluation dataset.

✔ Combine automated evaluation with human review.

✔ Track metrics after every model or prompt update.

✔ Monitor production metrics continuously.

✔ Include latency and cost, not just accuracy.

✔ Keep historical evaluation reports for comparison.

---

# Interview Questions

### What are Evaluation Metrics?

### Why isn't accuracy alone enough for LLM evaluation?

### What is Groundedness?

### What is Faithfulness?

### What is Retrieval Accuracy?

### What is BLEU?

### What is ROUGE?

### What is BERTScore?

### What is LLM-as-a-Judge?

### Which metrics would you monitor in production?

---

# Quick Revision

✔ AI evaluation is multi-dimensional.

✔ Measure Accuracy, Completeness, Groundedness, Faithfulness, Safety, Latency, Cost, and Consistency.

✔ RAG systems require Retrieval and Citation Accuracy.

✔ AI Agents require Workflow Success and Tool Accuracy.

✔ Combine automated evaluation with human review for the best results.

---

# Assignment

Evaluate **three different LLMs** (for example, ChatGPT, Gemini, and an open-source model like Llama via Ollama).

Prepare **100 prompts** across categories:

- Programming
- Mathematics
- General Knowledge
- Customer Support
- RAG (if available)

For each response record:

- Accuracy
- Completeness
- Groundedness
- Safety
- Latency
- Token Usage
- Cost (if applicable)

Finally prepare an **AI Evaluation Report** containing:

- Overall Accuracy
- Hallucination Rate
- Retrieval Accuracy
- Average Latency
- Cost Analysis
- Strengths and Weaknesses of each model
- Recommendation for production use

---

# Next Topic

➡ **11-AI Test Cases.md**