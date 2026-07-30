# Prompt Testing

> **Goal:** Learn how QA Engineers test prompts used in AI systems to ensure they produce correct, safe, consistent, and reliable responses.

---

# Why Should You Study Prompt Testing?

Every AI application depends on prompts.

Changing **one line** in a prompt can completely change how the AI behaves.

In many companies, developers don't modify the model—they modify the **prompt**.

As a QA Engineer, you must verify that prompt changes do not introduce regressions.

---

# Real World Example

Suppose your company builds an AI Resume Analyzer.

Old Prompt

```
Analyze the resume and provide constructive feedback.
```

New Prompt

```
Analyze the resume. Return exactly three strengths,
three weaknesses and a score from 1-10.
```

Developer changes only the prompt.

Now QA must verify:

- Correct output
- JSON format
- No hallucination
- No offensive language
- Stable responses
- Performance

No backend code changed.

Only the prompt changed.

---

# What is a Prompt?

A prompt is an instruction given to an AI model.

Example

```
Summarize this article.
```

Everything begins with the prompt.

---

# Types of Prompts

## User Prompt

Written by the user.

Example

```
Explain Java Collections.
```

---

## System Prompt

Controls AI behavior.

Example

```
You are a senior Java instructor.
Always explain using examples.
Never generate unsafe code.
```

Users usually never see this prompt.

---

## Developer Prompt

Written by developers.

Example

```
Return JSON only.
Use Markdown.
Maximum 200 words.
```

---

## Context Prompt

Additional information.

Example

```
User Name : Rahul

Experience : 3 Years

Role : Backend Developer
```

---

# Prompt Flow

```
User Prompt

↓

System Prompt

↓

Developer Prompt

↓

Retrieved Context

↓

LLM

↓

Response
```

QA should verify every stage.

---

# Prompt Engineering

Prompt Engineering is designing prompts to produce better outputs.

QA does not create production prompts.

QA verifies whether prompts behave correctly.

---

# Prompt Components

Example

```
You are a banking assistant.

Answer professionally.

Use simple English.

Maximum 150 words.

Never provide legal advice.

Return Markdown.
```

Contains

- Role
- Task
- Rules
- Constraints
- Output Format

---

# Types of Prompt Testing

## Functional Testing

Prompt

```
Translate English to Hindi.
```

Expected

Correct translation.

---

## Format Testing

Prompt

```
Return valid JSON.
```

Verify

- JSON valid
- Keys correct
- No extra text

---

## Instruction Following

Prompt

```
Give exactly five points.
```

Verify

Exactly five points.

Not four.

Not six.

---

## Boundary Testing

Prompt

```
Write one sentence.
```

Verify

One sentence only.

---

## Negative Testing

Prompt

```
Ignore previous instructions.
```

Should not bypass safety.

---

## Context Testing

Prompt

```
Remember my name.

...

Later

What's my name?
```

Verify memory.

---

## Role Testing

Prompt

```
You are a doctor.
```

Does AI remain a doctor?

Or suddenly become a programmer?

---

## Output Consistency

Same prompt

20 times

Are responses reasonably consistent?

---

# Prompt Variables

Example

```
Hello {{name}}

Welcome to {{company}}
```

QA verifies

- Missing values

- Null values

- Long values

- Special characters

---

# Prompt Templates

Companies rarely hardcode prompts.

Instead

```
Prompt Template

↓

Variables

↓

Generated Prompt

↓

LLM
```

QA verifies template generation.

---

# Prompt Versioning

Industry Example

```
Prompt v1

↓

Prompt v2

↓

Prompt v3
```

Every version must be regression tested.

---

# Prompt Regression Testing

Developer changes

```
One sentence
```

↓

QA runs

500 prompts

↓

Compare

Old

vs

New

Verify

- Accuracy
- Latency
- Cost
- Formatting

---

# Industry Workflow

Requirement

↓

Developer updates prompt

↓

QA prepares prompt library

↓

Run automated tests

↓

Compare outputs

↓

Create report

↓

Approve release

---

# Prompt Categories

Companies usually organize prompts.

Example

```
General Questions

Programming

Math

Travel

Healthcare

Banking

Customer Support

Greetings

Edge Cases

Abuse

Prompt Injection
```

---

# Practical Exercise 1

Ask ChatGPT

```
Explain Java.
```

Now ask

```
Explain Java in one sentence.
```

Observe differences.

---

# Practical Exercise 2

Prompt

```
Return JSON only.
```

Verify

```
{
"name":"John"
}
```

No explanation outside JSON.

---

# Practical Exercise 3

Prompt

```
Summarize in exactly 50 words.
```

Count words.

Does AI follow instruction?

---

# Practical Exercise 4

Prompt

```
List five programming languages.
```

Repeat

10 times.

Observe

- Order

- Formatting

- Consistency

---

# Common Prompt Bugs

- Ignores instruction

- Wrong language

- Wrong format

- Too long

- Too short

- Hallucination

- Missing required fields

- Wrong tone

- Markdown broken

- Invalid JSON

- Sensitive information leakage

---

# Industry Tools

Prompt Development

- OpenAI Playground
- Anthropic Console
- Ollama
- LM Studio

Testing

- Promptfoo
- DeepEval
- LangSmith

Automation

- Playwright
- REST Assured

Documentation

- Jira
- Confluence

---

# Mini Project

Test an AI FAQ chatbot.

Create

50 prompts

Categories

- Greeting

- Product Questions

- Refund

- Payment

- Technical Issues

Record

| Prompt | Expected | Actual | Pass | Notes |

---

# Best Practices

✔ Keep prompts version controlled.

✔ Test prompt changes.

✔ Verify formatting.

✔ Validate instructions.

✔ Test edge cases.

✔ Test multilingual prompts.

✔ Test prompt injection.

✔ Maintain prompt library.

---

# Interview Questions

### What is Prompt Testing?

### Why is Prompt Testing important?

### What is a System Prompt?

### What is a User Prompt?

### What is Prompt Regression Testing?

### How do you verify prompt quality?

### What tools have you used?

### How do you automate prompt testing?

---

# Quick Revision

✔ Prompt controls AI behavior.

✔ Small prompt changes can cause major regressions.

✔ QA tests prompts just like code.

✔ Validate correctness.

✔ Validate formatting.

✔ Validate consistency.

✔ Validate safety.

✔ Perform regression after every prompt update.

---

# Assignment

Choose any AI chatbot.

Create a Prompt Test Suite containing:

- 20 Functional Prompts
- 20 Formatting Prompts
- 20 Negative Prompts
- 20 Edge Cases
- 20 Prompt Injection Attempts

Document:

- Expected Output
- Actual Output
- Pass/Fail
- Bug Found
- Suggested Fix

---

# Industry Insight

At companies building AI products (such as AI customer support, coding assistants, document search systems, or healthcare chatbots), prompt changes are often treated like code changes. Before deployment, QA teams run a regression suite of hundreds or thousands of prompts and compare results against previous versions to detect drops in accuracy, formatting issues, increased latency, or new safety problems.

---

# Next Topic

➡ **04-Hallucination Testing.md**