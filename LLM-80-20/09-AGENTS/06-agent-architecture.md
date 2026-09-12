### `09-AGENTS/06-agent-architecture.md`

````md
# Agent Architecture

## 1. What is Agent Architecture?

**Agent architecture** is the design of the components and flow that allow an AI agent to understand a goal, make decisions, use tools, maintain state/memory, and complete a task.

A simple LLM application:

```text
User → LLM → Answer
````

An agent architecture:

```text
User
 ↓
Agent
 ├── LLM
 ├── Memory / State
 ├── Planning / Reasoning
 ├── Tools
 └── Environment
      ↓
   Result
      ↓
   Agent Loop
      ↓
   Final Answer
```

---

## 2. Why is Agent Architecture Needed?

Real-world tasks require more than text generation.

Example:

> "Check my emails, find the important ones, summarize them, and create tasks for me."

The agent may need:

```text
Read emails
 ↓
Filter important emails
 ↓
Summarize
 ↓
Identify tasks
 ↓
Create tasks
 ↓
Confirm completion
```

Architecture defines how these components work together reliably.

---

## 3. Core Components

A typical agent contains:

```text
┌──────────────────────────┐
│          Agent           │
│                          │
│  ┌──────┐   ┌─────────┐  │
│  │ LLM  │   │ Memory  │  │
│  └──────┘   └─────────┘  │
│                          │
│  ┌──────┐   ┌─────────┐  │
│  │Tools │   │ Planner │  │
│  └──────┘   └─────────┘  │
│                          │
│       Agent Loop         │
└──────────────────────────┘
```

### Main components

1. **LLM** → reasoning and generation
2. **Tools** → external capabilities
3. **Memory** → retained information
4. **State** → current task information
5. **Planner** → task decomposition
6. **Agent Loop** → repeated decision/action cycle
7. **Environment** → external systems

---

## 4. Basic Agent Architecture

```text
                 User Goal
                    ↓
              ┌───────────┐
              │    LLM    │
              └─────┬─────┘
                    ↓
               Decide Action
                    ↓
              ┌───────────┐
              │   Tools   │
              └─────┬─────┘
                    ↓
             External System
                    ↓
               Tool Result
                    ↓
              ┌───────────┐
              │    LLM    │
              └─────┬─────┘
                    ↓
             Goal Completed?
               ↙         ↘
             No           Yes
             ↓             ↓
          Continue       Answer
```

---

## 5. LLM Layer

The LLM acts as the decision-making component.

It can:

* Understand the user's goal
* Select tools
* Generate tool arguments
* Interpret tool results
* Decide the next step
* Generate the final response

Example:

```text
User:
"Find the weather in Pune."

LLM:
Tool required → get_weather
Arguments → city="Pune"
```

The LLM does not directly execute the tool.

---

## 6. Tool Layer

Tools give the agent external capabilities.

Examples:

```text
Search
Database
Calculator
Weather API
Code execution
Email
Calendar
Payment API
```

Architecture:

```text
LLM
 ↓
Tool Call
 ↓
Tool Runtime
 ↓
External System
 ↓
Tool Result
 ↓
LLM
```

Tools should have:

* Clear descriptions
* Input schemas
* Validation
* Authorization
* Error handling

---

## 7. Memory and State Layer

### State

Stores information required for the current task.

```text
Current task
Tool results
Current step
Intermediate outputs
```

### Memory

Stores information that may be useful later.

```text
User preferences
Past interactions
Useful facts
Previous experiences
```

Architecture:

```text
              Agent
                ↓
        ┌───────┴────────┐
        ↓                ↓
      State            Memory
        ↓                ↓
        └───────┬────────┘
                ↓
               LLM
```

---

## 8. Planning Layer

The planner decides how a complex goal can be completed.

Example:

```text
Goal:
"Research a company."

Plan:
1. Find company information
2. Find recent financial results
3. Compare with previous year
4. Summarize findings
```

The plan can be:

### Fixed

```text
Step 1 → Step 2 → Step 3
```

### Dynamic

```text
Step 1
 ↓
Observe
 ↓
Decide Step 2
 ↓
Observe
 ↓
Decide Step 3
```

---

## 9. Agent Loop

The agent loop connects all components.

```text
Goal
 ↓
Retrieve State/Memory
 ↓
LLM Decision
 ↓
Tool/Action
 ↓
Observation
 ↓
Update State
 ↓
LLM Decision
 ↓
...
 ↓
Finish
```

This is the heart of an agentic system.

---

## 10. Complete Architecture

```text
                         USER
                           ↓
                    ┌────────────┐
                    │  Frontend  │
                    └─────┬──────┘
                          ↓
                    ┌────────────┐
                    │  Backend   │
                    └─────┬──────┘
                          ↓
                ┌─────────────────────┐
                │       AGENT         │
                │                     │
                │  ┌───────────────┐  │
                │  │      LLM      │  │
                │  └───────┬───────┘  │
                │          ↓          │
                │      Decision       │
                │          ↓          │
                │  ┌───────────────┐  │
                │  │     Tools     │  │
                │  └───────┬───────┘  │
                │          ↓          │
                │     Observation    │
                │          ↓          │
                │  ┌───────────────┐  │
                │  │ State/Memory  │  │
                │  └───────────────┘  │
                └──────────┬──────────┘
                           ↓
                      Final Answer
```

---

## 11. Example: Customer Support Agent

User:

> "My order hasn't arrived. Please check it."

Architecture:

```text
User
 ↓
Agent
 ↓
Identify required information
 ↓
get_order_details()
 ↓
Order Database
 ↓
Order status
 ↓
LLM interprets result
 ↓
Need shipment information?
 ↓
get_shipping_status()
 ↓
Shipping API
 ↓
Final response
```

The agent may dynamically decide whether another tool is necessary.

---

## 12. Multi-Agent Architecture

Sometimes one agent is not enough.

Multiple specialized agents can collaborate.

```text
                    User
                      ↓
                Orchestrator
                /     |      \
               ↓      ↓       ↓
          Research   Coding   Data
           Agent     Agent    Agent
               \      |       /
                \     |      /
                  ↓   ↓   ↓
                  Final Result
```

Example:

```text
Research Agent → gathers information
Coding Agent   → writes code
Review Agent   → checks output
```

This is called a **multi-agent system**.

---

## 13. Single-Agent vs Multi-Agent

| Single Agent         | Multi-Agent                              |
| -------------------- | ---------------------------------------- |
| One main agent       | Multiple specialized agents              |
| Simpler architecture | More complex                             |
| Easier to debug      | Coordination required                    |
| Lower overhead       | More communication/cost                  |
| Good for many tasks  | Useful for complex specialized workflows |

Do not use multiple agents simply because it sounds advanced.

Use them when specialization or independent workflows provide a real benefit.

---

## 14. Agent Architecture with RAG

An agent can also use RAG.

```text
User
 ↓
Agent
 ↓
LLM
 ↓
Need knowledge?
 ↓
Retriever
 ↓
Vector Database
 ↓
Relevant Documents
 ↓
LLM
 ↓
Tool/action if required
 ↓
Final Answer
```

Therefore:

```text
RAG = Knowledge retrieval capability

Tool = External capability/action

Agent = Decision-making system that can use them
```

---

## 15. Production Concerns

A production agent needs more than an LLM and tools.

Important components:

### Security

```text
Authentication
Authorization
Input validation
Tool permissions
```

### Reliability

```text
Timeouts
Retries
Fallbacks
Error handling
```

### Cost Control

```text
Token limits
Model selection
Tool-call limits
Maximum agent steps
```

### Observability

```text
Logs
Traces
Latency
Token usage
Tool calls
Errors
```

---

## 16. Guardrails

Guardrails restrict unsafe or invalid agent behavior.

Example:

```text
Agent wants to delete database record
              ↓
          Guardrail
              ↓
       User confirmation
              ↓
          Execute
```

Guardrails can enforce:

* Allowed tools
* Allowed arguments
* Maximum steps
* Spending limits
* Data access policies
* Human approval

---

## 17. Simple Agent Skeleton

```python
def run_agent(goal):

    state = {
        "goal": goal,
        "history": []
    }

    for step in range(10):

        decision = llm(state)

        if decision["action"] == "finish":
            return decision["answer"]

        tool_name = decision["tool"]
        arguments = decision["arguments"]

        validate_tool_call(tool_name, arguments)

        result = execute_tool(tool_name, arguments)

        state["history"].append({
            "action": decision,
            "result": result
        })

    return "Maximum agent steps reached."
```

Core idea:

```text
LLM
 ↓
Decision
 ↓
Validation
 ↓
Tool
 ↓
Result
 ↓
State Update
 ↓
LLM
```

---

## 18. When Should You Use an Agent Architecture?

Use an agent when:

* The task is multi-step
* The next action depends on previous results
* Multiple tools are required
* Dynamic decision making is useful
* The workflow cannot easily be hard-coded

Do not use an agent when:

```text
Input → Fixed Processing → Output
```

is sufficient.

A deterministic workflow is often:

* Cheaper
* Faster
* Easier to test
* Easier to control

---

## 19. Key Mental Model

```text
                 ┌─────────┐
                 │   Goal  │
                 └────┬────┘
                      ↓
                 ┌─────────┐
                 │   LLM   │
                 └────┬────┘
                      ↓
                   Decide
                      ↓
                 ┌─────────┐
                 │  Tools  │
                 └────┬────┘
                      ↓
                  Observe
                      ↓
                 ┌─────────┐
                 │  State  │
                 └────┬────┘
                      ↓
                     LLM
                      ↓
                    Repeat
```

Remember:

> **Agent architecture is the complete system around the LLM that enables goal-directed decision making, tool use, memory/state, and iterative execution.**

---

## 20. GATE / Interview Points

* An agent architecture combines LLM, tools, state, memory, planning and an agent loop.
* The LLM decides what action should happen next.
* The application/tool runtime executes the action.
* Tool results become observations for the next decision.
* State stores information needed during the current execution.
* Memory stores information that may be useful later.
* Agents can use RAG as a knowledge-retrieval capability.
* Multi-agent systems use multiple specialized agents.
* Guardrails restrict unsafe or invalid actions.
* Production agents need authentication, authorization, logging, limits and error handling.
* Deterministic workflows are preferable when the workflow is fixed.
* Agent architectures are most useful for dynamic, multi-step tasks.

---

## 21. One-Line Revision

> **Agent Architecture = LLM + Planning/Reasoning + Tools + State/Memory + Agent Loop + Guardrails working together to achieve a goal.**

```
```
