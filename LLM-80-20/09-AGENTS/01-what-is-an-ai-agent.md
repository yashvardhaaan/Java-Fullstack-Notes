### `09-AGENTS/01-what-is-an-ai-agent.md`

````md
# What is an AI Agent?

## 1. What is an AI Agent?

An **AI Agent** is a system that uses an LLM to:

- Understand a goal
- Decide what to do
- Use tools
- Observe results
- Take further actions
- Continue until the goal is completed

A normal LLM mainly follows:

```text
Input → LLM → Output
````

An agent follows:

```text
Goal
 ↓
LLM
 ↓
Decide
 ↓
Action / Tool
 ↓
Observe Result
 ↓
LLM
 ↓
Next Action
 ↓
...
 ↓
Goal Completed
```

---

## 2. Why Do We Need AI Agents?

A single LLM response is not enough for complex tasks.

Example:

> "Find the cheapest flight to Delhi, check the timings, and prepare an email with the details."

A normal LLM may only explain how to do it.

An agent can:

```text
Understand goal
    ↓
Search flights
    ↓
Compare prices
    ↓
Check timings
    ↓
Select suitable flight
    ↓
Generate email
```

Agents are useful when a task requires **multiple steps and decisions**.

---

## 3. Where Are AI Agents Used?

### Customer Support

```text
User question
 ↓
Search knowledge base
 ↓
Check customer account
 ↓
Resolve issue
```

### Coding Agents

```text
Understand issue
 ↓
Inspect code
 ↓
Modify code
 ↓
Run tests
 ↓
Fix errors
```

### Research Agents

```text
Research question
 ↓
Search web
 ↓
Read sources
 ↓
Extract information
 ↓
Compare
 ↓
Generate report
```

### Business Automation

```text
Read email
 ↓
Extract information
 ↓
Check database
 ↓
Create ticket
 ↓
Send response
```

---

## 4. How Does an AI Agent Work?

A basic agent has four important parts:

```text
┌───────────────┐
│     Goal      │
└───────┬───────┘
        ↓
┌───────────────┐
│      LLM      │
│  Decision     │
└───────┬───────┘
        ↓
┌───────────────┐
│     Tools     │
└───────┬───────┘
        ↓
┌───────────────┐
│   Observation │
└───────┬───────┘
        ↓
      LLM
```

The agent repeatedly uses this process.

---

## 5. Example

Suppose the user asks:

> "What is the weather in Pune and should I carry an umbrella?"

The agent can reason:

```text
Goal:
Answer weather question

 ↓

Need current weather
 ↓

Call weather tool
 ↓

Result:
Rain expected

 ↓

LLM interprets result
 ↓

Answer:
"Rain is expected, so carry an umbrella."
```

The important point is that the agent **interacts with an external environment/tool** instead of relying only on its internal model knowledge.

---

## 6. Agent vs Chatbot

| Chatbot                           | AI Agent                     |
| --------------------------------- | ---------------------------- |
| Mainly responds to messages       | Works toward a goal          |
| Usually simple request → response | Can perform multi-step tasks |
| Limited tool interaction          | Can use multiple tools       |
| Often reactive                    | Can decide next action       |
| Usually one main generation cycle | Can run an iterative loop    |

Example:

```text
Chatbot:
"What is the weather?"
→ Gives an answer

Agent:
"Plan my trip based on weather."
→ Checks weather
→ Checks transportation
→ Checks activities
→ Creates plan
```

---

## 7. Agent vs LLM

### LLM

```text
Question
 ↓
LLM
 ↓
Answer
```

### Agent

```text
Goal
 ↓
LLM
 ↓
Reason / Decide
 ↓
Tool
 ↓
Observe
 ↓
Reason / Decide
 ↓
Tool
 ↓
Final Answer
```

**LLM = intelligence component**

**Agent = system built around the LLM to achieve a goal**

---

## 8. Core Components of an Agent

### 1. LLM

Used for:

* Understanding
* Reasoning
* Decision making
* Generating responses

### 2. Tools

Give the agent external capabilities.

Examples:

```text
Search
Database
Calculator
Code execution
API
Email
```

### 3. Memory

Stores useful information across steps or conversations.

### 4. Planning

Breaks a complex goal into smaller tasks.

### 5. Agent Loop

Repeatedly:

```text
Think/Decide → Act → Observe → Decide
```

---

## 9. Simple Agent Example

```python
def agent(question):

    while True:

        decision = llm(question)

        if decision["action"] == "search":
            result = search_web(decision["query"])

            question = f"""
            Original task: {question}

            Search result:
            {result}

            Decide the next step.
            """

        elif decision["action"] == "finish":
            return decision["answer"]
```

Conceptually:

```text
LLM decides
   ↓
Tool executes
   ↓
Result returned
   ↓
LLM decides again
```

This repeated process is called the **agent loop**.

---

## 10. What Makes a System an Agent?

A system becomes more agent-like when it has:

```text
Goal
+
Decision making
+
Actions
+
Observations
+
Iteration
```

A simple API call:

```text
User → LLM → API → Answer
```

does not necessarily mean you have a sophisticated agent.

A system that can:

```text
Decide → Act → Observe → Decide → Act
```

is much more clearly agentic.

---

## 11. Important Limitation

An agent is **not magically autonomous**.

The application controls:

* Available tools
* Permissions
* Maximum steps
* Data access
* Execution environment
* Safety checks

For example:

```python
MAX_STEPS = 10
```

This prevents an agent from running indefinitely.

---

## 12. When Should You Use an Agent?

Use an agent when:

* The task has multiple steps
* The next action depends on previous results
* External tools are required
* The workflow cannot be completely predefined
* The system needs dynamic decision making

Do **not** use an agent when a simple deterministic workflow is enough.

Example:

```text
Fixed task:
Validate email → Save database → Send confirmation
```

A normal backend workflow may be better than an agent.

---

## 13. Agentic Workflow vs Agent

### Fixed Workflow

```text
Step 1 → Step 2 → Step 3 → Step 4
```

The developer decides the sequence.

### Agent

```text
Goal
 ↓
LLM decides next step
 ↓
Action
 ↓
Result
 ↓
LLM decides next step
```

The sequence can change based on observations.

---

## 14. Key Mental Model

Remember:

```text
LLM = Brain
Tools = Hands
Memory = Knowledge from previous interactions
Environment = Outside world
Agent Loop = Brain → Hands → Observation → Brain
```

---

## 15. GATE / Interview Points

* An AI agent is a system that uses an LLM to achieve a goal through iterative decision making and actions.
* Agents commonly use tools such as APIs, databases, search and code execution.
* The **agent loop** is typically:
  `Decide → Act → Observe → Decide`.
* LLM and agent are not the same.
* Tool use is a major component of agents.
* Memory can provide information from previous interactions.
* Planning can decompose complex tasks into smaller tasks.
* Agents should have limits such as maximum steps and tool permissions.
* Deterministic workflows are often preferable when the process is fixed.
* Agentic systems are useful when the next action depends on previous results.

---

## 16. One-Line Revision

> **AI Agent = LLM + Goal + Tools + Memory/Context + Decision Making + Iterative Action/Observation Loop.**

```
```
