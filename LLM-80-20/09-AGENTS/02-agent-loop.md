### `09-AGENTS/02-agent-loop.md`

````md
# Agent Loop

## 1. What is an Agent Loop?

An **agent loop** is the repeated process through which an AI agent:

```text
Understand Goal
      ↓
Decide
      ↓
Act
      ↓
Observe Result
      ↓
Decide Again
      ↓
...
      ↓
Finish
````

The loop allows an agent to perform **multi-step tasks** instead of generating only one response.

---

## 2. Why is the Agent Loop Needed?

Many tasks cannot be solved in one step.

Example:

> "Find the best laptop under ₹80,000 and compare 3 options."

The agent may need to:

```text
Understand requirements
        ↓
Search products
        ↓
Collect results
        ↓
Compare specifications
        ↓
Check prices
        ↓
Generate recommendation
```

The result of one step influences the next step.

---

## 3. Basic Agent Loop

```text
┌────────────────────┐
│       Goal         │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│   LLM Decision     │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│   Execute Action   │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│    Observe Result  │
└─────────┬──────────┘
          ↓
     Goal complete?
       ↙       ↘
     No         Yes
     ↓           ↓
   LLM        Final Answer
```

---

## 4. Four Main Stages

### 1. Decide

The LLM determines what should happen next.

```text
"I need current weather information."
```

### 2. Act

The agent calls an appropriate tool.

```text
get_weather("Pune")
```

### 3. Observe

The tool returns a result.

```text
Temperature: 28°C
Condition: Rain
```

### 4. Decide Again

The LLM uses the result to determine the next step.

```text
"Rain is expected → recommend carrying an umbrella."
```

---

## 5. Practical Example

User:

> "Check the weather in Pune and tell me whether I should carry an umbrella."

Agent loop:

```text
Goal
 ↓
Need current weather
 ↓
Call weather tool
 ↓
Weather:
Rain expected
 ↓
Analyze result
 ↓
Goal completed
 ↓
Final answer
```

Notice that the LLM does not need to call another tool after receiving enough information.

---

## 6. Multi-Step Example

User:

> "Research a company and summarize its latest financial performance."

Possible loop:

```text
Goal
 ↓
Search company
 ↓
Observe results
 ↓
Find financial report
 ↓
Observe report
 ↓
Extract revenue/profit
 ↓
Need comparison?
 ↓
Search previous period
 ↓
Compare
 ↓
Generate summary
```

The exact sequence can change based on what the agent discovers.

---

## 7. Simple Python Implementation

```python
def agent(goal):

    state = goal

    for step in range(10):

        decision = llm(state)

        if decision["action"] == "finish":
            return decision["answer"]

        if decision["action"] == "search":
            result = search_web(decision["query"])

        elif decision["action"] == "calculate":
            result = calculate(decision["expression"])

        else:
            result = "Unknown action"

        state = f"""
        Goal:
        {goal}

        Previous decision:
        {decision}

        Tool result:
        {result}

        Decide the next step.
        """

    return "Agent stopped: maximum steps reached."
```

Important:

```python
for step in range(10):
```

prevents an infinite loop.

---

## 8. Why Maximum Steps Matter?

An agent could potentially keep doing:

```text
Tool → Result → Tool → Result → ...
```

without reaching the goal.

Therefore production systems usually enforce limits:

```text
Maximum steps
Maximum execution time
Maximum cost
Maximum tool calls
```

Example:

```python
MAX_STEPS = 10
```

---

## 9. Agent State

The agent needs information about what has happened so far.

Example:

```python
state = {
    "goal": "Find cheapest flight",
    "observations": [],
    "actions": [],
    "final_answer": None
}
```

After a tool call:

```text
State
 ↓
Action
 ↓
Tool result
 ↓
Updated State
 ↓
Next decision
```

State is especially important for long-running or multi-step agents.

---

## 10. Stop Conditions

An agent needs a clear condition for termination.

Common conditions:

### Goal completed

```text
Required information found
```

### LLM says finish

```text
action = "finish"
```

### Maximum steps reached

```text
10 steps completed
```

### Tool failure

```text
Critical tool unavailable
```

### Budget exceeded

```text
Maximum token/API cost reached
```

---

## 11. Agent Loop vs Normal Workflow

### Normal Workflow

```text
Step 1 → Step 2 → Step 3 → Step 4
```

The developer defines the sequence.

### Agent Loop

```text
Goal
 ↓
LLM decides
 ↓
Action
 ↓
Observation
 ↓
LLM decides next action
```

The next action can depend on the previous result.

---

## 12. Agent Loop vs Chat Loop

A chat loop:

```text
User → LLM → User → LLM
```

An agent loop:

```text
Goal
 ↓
LLM
 ↓
Tool
 ↓
Observation
 ↓
LLM
 ↓
Tool
 ↓
Observation
 ↓
Final answer
```

The key difference is **autonomous multi-step action within the application workflow**.

---

## 13. Error Handling

Tools can fail.

```python
try:
    result = tool(**arguments)
except Exception as e:
    result = {
        "error": str(e)
    }
```

The agent can then decide:

```text
Tool failed
 ↓
Retry?
 ↓
Use another tool?
 ↓
Ask user?
 ↓
Stop?
```

Never allow uncontrolled retries.

---

## 14. Human-in-the-Loop

Some actions should require user approval.

Example:

```text
Agent:
"I found the correct flight."

 ↓

Agent:
"Book this flight for ₹12,500?"

 ↓

User confirms

 ↓

Booking tool executes
```

This is important for:

* Payments
* Purchases
* Sending messages
* Deleting data
* Account changes
* Other irreversible actions

---

## 15. Key Mental Model

Remember:

```text
DECIDE
  ↓
ACT
  ↓
OBSERVE
  ↓
DECIDE
  ↓
ACT
  ↓
OBSERVE
  ↓
FINISH
```

This is the **core loop behind many AI agents**.

---

## 16. GATE / Interview Points

* Agent loop enables multi-step problem solving.
* Basic cycle:
  `Decide → Act → Observe → Decide`.
* Tools provide the action capability.
* Tool results become new information for the next decision.
* Agent state stores relevant information from previous steps.
* Agents need termination conditions.
* Maximum steps prevent infinite loops.
* Time and cost limits are important in production.
* Tool failures require error handling and controlled retries.
* Human approval should be used for sensitive or irreversible actions.
* A fixed workflow has a predefined sequence; an agent loop can dynamically choose the next action.

---

## 17. One-Line Revision

> **Agent Loop = LLM decides the next action → tool/environment executes it → result is observed → LLM decides again until the goal is completed.**

```
```
