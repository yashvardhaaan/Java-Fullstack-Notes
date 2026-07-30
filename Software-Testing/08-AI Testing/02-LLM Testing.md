# LLM Testing (Large Language Model Testing)

> **Goal:** Learn how QA Engineers test Large Language Models (LLMs) like ChatGPT, Claude, Gemini, Llama, and enterprise AI assistants in real-world production systems.

---

# Why Should You Study LLM Testing?

Every AI application today is powered by an LLM.

Examples:

- ChatGPT
- Claude
- GitHub Copilot
- Cursor
- Gemini
- Perplexity
- AI Customer Support
- AI Resume Analyzer
- AI Medical Assistant

Companies need QA Engineers who know **how to verify the quality, correctness, and safety of these models.**

Traditional software testing is not enough because LLMs generate text rather than fixed outputs.

---

# Real World Example

Suppose your company builds an AI customer support chatbot.

User asks:

> My payment failed but money was deducted.

Expected response:

- Understand the issue
- Suggest checking bank confirmation
- Advise waiting if payment is pending
- Create support ticket if necessary

Instead the chatbot replies:

> Please reinstall your operating system.

Technically:

API returned 200 OK.

Backend works.

But the product is unusable.

This is exactly what LLM Testing catches.

---

# What is an LLM?

LLM stands for

**Large Language Model**

It is an AI model trained on massive amounts of text to predict the next token (word or subword).

Popular LLMs:

- GPT-4
- GPT-5
- Claude
- Gemini
- Llama
- Mistral
- DeepSeek

---

# How an LLM Works

```
User Prompt
      │
      ▼
Tokenizer
      │
      ▼
Tokens
      │
      ▼
Transformer Model
      │
      ▼
Probability Distribution
      │
      ▼
Generated Tokens
      │
      ▼
Final Response
```

QA engineers usually don't test the model internals—they test the behavior of the model.

---

# What Does a QA Engineer Test?

Instead of testing code only, QA tests the generated output.

Questions include:

- Is the answer correct?
- Is it complete?
- Is it safe?
- Is it understandable?
- Is it formatted correctly?
- Does it follow business rules?
- Is it grounded in company data?
- Does it remember previous context?

---

# Industry Architecture

```
User

↓

Frontend

↓

Backend

↓

LLM API

↓

Vector Database

↓

Tool Calling

↓

Database

↓

Response

↓

User
```

Possible testing points:

- UI
- API
- Prompt
- Retrieval
- Tool Calling
- Memory
- Output

---

# Important LLM Concepts

## Tokens

LLMs don't read words.

They read tokens.

Example:

```
ChatGPT is amazing.
```

becomes

```
Chat

GPT

is

amazing

.
```

Large prompts consume more tokens.

QA also verifies token usage.

---

## Context Window

Every model has a maximum memory.

Example

```
8K

32K

128K

200K
```

Questions to test:

Can it remember earlier conversation?

Does it forget information?

Does performance degrade?

---

## Temperature

Controls randomness.

```
Temperature = 0

↓

Predictable

Stable

Good for banking

-------------------

Temperature = 1.2

↓

Creative

Random

Good for writing
```

QA verifies responses under different temperatures.

---

## Top-P

Controls diversity.

Smaller values

↓

More predictable

Larger values

↓

More creative

---

## Streaming

Instead of waiting

```
Hello
```

appears immediately

and

```
How are you today?
```

continues.

QA verifies

- partial responses
- interruptions
- timeout handling

---

## Function Calling

Modern LLMs call APIs.

Example

User:

```
Book my flight.
```

LLM

↓

Flight API

↓

Available Flights

↓

LLM Response

QA verifies

- correct API selection
- parameters
- validation
- failures

---

## Tool Calling

Example

```
Calculator

Weather

Search

Database

Email

Calendar
```

QA verifies

- correct tool

- tool failure

- retry

- timeout

---

# Types of LLM Testing

## Functional Testing

Does the model answer correctly?

---

## Accuracy Testing

Is the answer factually correct?

---

## Consistency Testing

Same question

10 times

Does quality remain acceptable?

---

## Robustness Testing

Give

- spelling mistakes
- emojis
- mixed languages
- extra spaces

Does the model still understand?

---

## Context Testing

Conversation

```
User:

My name is Rahul.

...

After 20 prompts

↓

What's my name?
```

Correct answer?

---

## Memory Testing

Can the chatbot remember

- previous conversation

- preferences

- earlier tasks

---

## Formatting Testing

Expected

```
JSON
```

Did model return JSON?

Or plain text?

---

## Latency Testing

Measure

```
Prompt

↓

First token

↓

Last token
```

---

## Token Usage Testing

Measure

Input Tokens

Output Tokens

Total Cost

---

# Industry Testing Workflow

Requirement

↓

Prepare Prompt Set

↓

Run 1000 prompts

↓

Collect Responses

↓

Evaluate

↓

Categorize

Correct

Incorrect

Hallucination

Unsafe

Incomplete

↓

Create Report

↓

Developer Fixes

↓

Regression Testing

↓

Release

---

# Practical Exercise

Install

```
Ollama
```

Download

```
llama3
```

Run

```bash
ollama run llama3
```

Ask

```
What is Java?
```

Now ask

```
Explain Java like I am five years old.
```

Observe

- accuracy
- formatting
- latency
- consistency

Document everything.

---

# Practical Exercise 2

Ask

```
What is 245 × 923?
```

Compare

with calculator.

Repeat

20 calculations.

Measure

accuracy.

---

# Practical Exercise 3

Ask

```
Write valid JSON.
```

Verify

- valid syntax

- missing commas

- escaping

---

# Common Bugs

- Hallucination

- Wrong calculations

- Missing context

- Wrong formatting

- Incorrect JSON

- Incomplete response

- Timeout

- API failure

- Wrong tool selection

- Memory loss

---

# Industry Tools

Testing

- Promptfoo

- DeepEval

- LangSmith

- TruLens

Models

- OpenAI

- Ollama

- LM Studio

- Claude

- Gemini

Automation

- Playwright

- Selenium

- REST Assured

Monitoring

- Grafana

- Kibana

---

# Mini Project

Test a chatbot.

Create

100 prompts

Categories

- General Knowledge
- Mathematics
- Programming
- Banking
- Healthcare
- Travel

Create report.

Columns

| Prompt | Expected | Actual | Correct | Latency | Bug |

---

# Interview Questions

### What is an LLM?

### How is LLM testing different from API testing?

### What is temperature?

### What is Top-P?

### What is context window?

### What is tokenization?

### What should be tested in an LLM?

### How do you verify correctness?

### How do you detect hallucinations?

### What tools have you used?

---

# Quick Revision

✔ LLM predicts tokens.

✔ Same prompt may generate different responses.

✔ QA evaluates quality instead of only HTTP status codes.

✔ Context window affects memory.

✔ Temperature affects randomness.

✔ Tool Calling must be verified.

✔ Token usage affects cost.

✔ Latency affects user experience.

---

# Assignment

Using ChatGPT, Claude, Gemini, or Ollama:

Create a spreadsheet with **100 prompts** divided into:

- 20 General Knowledge
- 20 Programming
- 20 Mathematics
- 20 Logical Reasoning
- 20 Customer Support

For each prompt record:

- Prompt
- Expected Behavior
- Actual Response
- Accuracy (1–5)
- Latency
- Any Bugs Found

Analyze the results and summarize the most common failure patterns.

---

# Next Topic

➡ **03-Prompt Testing.md**