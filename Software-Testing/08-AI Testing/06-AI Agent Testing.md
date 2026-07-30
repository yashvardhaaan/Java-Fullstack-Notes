# AI Agent Testing

> **Goal:** Learn how QA Engineers test AI Agents that can reason, plan, remember, use tools, and perform multi-step tasks autonomously in production systems.

---

# Why Should You Study AI Agent Testing?

Traditional chatbots only answer questions.

AI Agents can:

- Search the web
- Call APIs
- Read databases
- Execute workflows
- Send emails
- Book meetings
- Generate reports
- Write code
- Perform multiple tasks automatically

Because AI Agents perform **actions**, testing them is much more challenging than testing normal chatbots.

Today companies like Microsoft, OpenAI, Google, Salesforce, ServiceNow, Atlassian, Amazon, and many startups are building AI Agents.

---

# Real World Example

Suppose you build an AI Travel Agent.

User asks

```
Book me the cheapest flight from Pune to Bangalore
for tomorrow morning and email me the ticket.
```

The AI Agent should

- Understand the request
- Search available flights
- Compare prices
- Select the cheapest
- Book ticket
- Generate itinerary
- Send email

QA must verify every step.

---

# What is an AI Agent?

An AI Agent is an AI system capable of:

- Planning
- Decision Making
- Tool Usage
- Memory
- Reasoning
- Executing Tasks
- Learning from Context

Unlike LLMs, AI Agents don't just answer questions.

They perform actions.

---

# AI Chatbot vs AI Agent

| Chatbot | AI Agent |
|----------|-----------|
| Answers questions | Performs tasks |
| No planning | Plans execution |
| Usually no tools | Uses multiple tools |
| Mostly one response | Multi-step workflow |
| Limited memory | Long-term memory possible |
| Passive | Goal-oriented |

---

# AI Agent Architecture

```
               User

                 │

                 ▼

          AI Agent

                 │

     ┌───────────┼────────────┐

     ▼           ▼            ▼

 Planner      Memory       Reasoner

     │

     ▼

 Tool Selector

     │

     ▼

 APIs / Database / Search /
 Email / Calendar / Payment

     │

     ▼

 Observation

     │

     ▼

 Final Response
```

QA may need to validate every component.

---

# AI Agent Workflow

User

↓

Goal Understanding

↓

Task Planning

↓

Tool Selection

↓

Execute Tool

↓

Observe Result

↓

Reason Again

↓

Repeat if Needed

↓

Final Response

---

# Components of an AI Agent

## Planner

Breaks large tasks into smaller tasks.

Example

```
Book Flight

↓

Search Flights

↓

Compare Prices

↓

Book

↓

Email Ticket
```

QA verifies

- Correct planning
- Correct task order

---

## Memory

Stores information.

Example

```
User prefers window seat.
```

Later

```
Book flight.

↓

Window seat selected automatically.
```

QA verifies memory retrieval.

---

## Tool Calling

Agent uses external tools.

Examples

- Search
- Calculator
- Weather API
- Email API
- Payment API
- Database

QA verifies

- Correct tool
- Correct parameters
- Correct sequence

---

## Reasoning

Agent decides

```
Should I search?

Should I calculate?

Should I ask user?
```

QA verifies

Logical decision making.

---

## Reflection

Some AI Agents verify their own answer.

```
Answer

↓

Review

↓

Improve

↓

Return
```

QA verifies

- Better quality
- No infinite loop

---

# Types of AI Agent Testing

## Functional Testing

Can the agent complete the requested task?

---

## Workflow Testing

Are all workflow steps executed correctly?

---

## Tool Testing

Did the correct tool execute?

---

## Planning Testing

Was the task broken into logical steps?

---

## Memory Testing

Did the agent remember previous interactions?

---

## Failure Recovery Testing

What happens if one tool fails?

---

## Multi-Step Testing

Can the agent complete long workflows?

---

## Permission Testing

Can the agent access unauthorized resources?

---

# Industry Workflow

Requirement

↓

Developer creates AI Agent

↓

QA prepares workflow scenarios

↓

Execute agent

↓

Observe every step

↓

Compare expected workflow

↓

Report failures

↓

Regression Testing

↓

Production

---

# Practical Test Cases

## Test Case 1

Prompt

```
Calculate

25 × 48
```

Expected

Calculator tool should be used.

---

## Test Case 2

Prompt

```
Send an email to HR.
```

Expected

Email API called.

---

## Test Case 3

Prompt

```
Search latest Java version.
```

Expected

Search tool called.

---

## Test Case 4

Prompt

```
Book meeting tomorrow.
```

Expected

Calendar API.

---

## Test Case 5

Prompt

```
Generate report and email manager.
```

Expected

Report

↓

Email

↓

Success

---

# Tool Calling Validation

Verify

- Tool selected
- Correct parameters
- Correct response
- Retry if failure
- Timeout handling
- Authentication

---

# Memory Testing

Conversation

```
My name is Rahul.

I work in Pune.

I like Java.
```

Later

```
Where do I work?
```

Expected

```
Pune
```

---

# Workflow Validation

Expected

```
Receive Task

↓

Plan

↓

Choose Tool

↓

Execute

↓

Verify

↓

Return Answer
```

Check every stage.

---

# Failure Testing

Weather API

↓

Returns 500 Error

Expected

Agent should

- Retry

or

- Inform user

Not crash.

---

# Infinite Loop Testing

Bug

```
Think

↓

Think

↓

Think

↓

Think

↓

Never finishes
```

QA verifies

Maximum iteration limits.

---

# Timeout Testing

Search Tool

↓

Takes 30 seconds.

Expected

Graceful timeout.

---

# Multi-Agent Testing

Example

Travel Agent

↓

Flight Agent

↓

Hotel Agent

↓

Payment Agent

↓

Notification Agent

QA verifies

Communication between agents.

---

# Common AI Agent Bugs

- Wrong tool selected
- Wrong task order
- Memory lost
- Infinite loop
- Duplicate execution
- Missing execution
- Wrong API
- Timeout
- Authorization failure
- Incorrect reasoning

---

# Practical Exercise 1

Install

CrewAI

or

LangGraph

Create

Simple Research Agent.

Observe

Workflow.

---

# Practical Exercise 2

Create

Calculator Agent.

Verify

Calculator called

instead of LLM math.

---

# Practical Exercise 3

Disable one tool.

Expected

Agent should

Handle error gracefully.

---

# Practical Exercise 4

Ask

```
Search weather

then email me.
```

Verify

Search

↓

Email

Correct sequence.

---

# Industry Metrics

Task Success Rate

```
Completed Tasks

──────────────

Total Tasks
```

---

Tool Accuracy

```
Correct Tool Calls

────────────────

Total Tool Calls
```

---

Workflow Accuracy

```
Correct Workflows

────────────────

Total Workflows
```

---

Average Response Time

Measure

Task

↓

Completion

---

# Industry Tools

AI Frameworks

- LangGraph
- CrewAI
- AutoGen
- Semantic Kernel
- OpenAI Agents SDK

Testing

- Promptfoo
- DeepEval
- LangSmith

Automation

- Playwright
- Selenium
- REST Assured

Monitoring

- Grafana
- Kibana

---

# Mini Project

Build a simple AI Travel Agent.

Functions

- Search Flights
- Search Hotels
- Weather
- Email

Prepare

50 workflow test cases.

Spreadsheet

| Scenario | Expected Workflow | Actual Workflow | Pass | Bug |

---

# Industry Example

Suppose TraceLink develops an AI Supply Chain Assistant.

User asks

```
Find delayed shipments,
generate a report,
and notify the warehouse manager.
```

QA verifies

- Shipment service called
- Correct data retrieved
- Report generated
- Notification sent
- No duplicate actions
- Workflow completed successfully

---

# Best Practices

✔ Test every workflow step.

✔ Verify tool selection.

✔ Test tool failures.

✔ Validate reasoning.

✔ Test memory.

✔ Prevent infinite loops.

✔ Test authorization.

✔ Automate regression workflows.

---

# Interview Questions

### What is an AI Agent?

### How is an AI Agent different from an LLM?

### What is Tool Calling?

### What is Planning?

### What is Reflection?

### How would you test an AI Travel Agent?

### How would you test memory?

### How would you test workflow failures?

### How do you test multiple AI Agents?

---

# Quick Revision

✔ AI Agents perform tasks.

✔ They plan before acting.

✔ They use external tools.

✔ QA validates planning, reasoning, memory, and tool execution.

✔ Workflow testing is more important than simple response testing.

✔ Tool failures must be handled gracefully.

---

# Assignment

Build or use an AI Agent (CrewAI, LangGraph, OpenAI Agents SDK, or similar).

Create **50 workflow test cases** covering:

- Normal workflows
- Tool failures
- Timeout scenarios
- Memory validation
- Authorization failures
- Multi-step tasks

Prepare a report including:

- Task Success Rate
- Workflow Accuracy
- Tool Call Accuracy
- Average Response Time
- Bugs Found
- Recommendations

---

# Next Topic

➡ **07-Bias Testing.md**