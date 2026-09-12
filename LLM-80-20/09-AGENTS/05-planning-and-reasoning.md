### `09-AGENTS/05-planning-and-reasoning.md`

````md
# Planning and Reasoning

## 1. What is Planning?

**Planning** is the process of breaking a complex goal into smaller steps and deciding how those steps should be completed.

Example:

```text
Goal:
"Plan a 3-day trip to Delhi."

Plan:
1. Check travel options
2. Check hotels
3. Find places to visit
4. Estimate budget
5. Create itinerary
````

An agent can then execute these steps using tools.

---

## 2. Why is Planning Needed?

Simple tasks may require one step:

```text
"What is 25 × 48?"
        ↓
Calculator
        ↓
Answer
```

Complex tasks require multiple dependent steps:

```text
"Plan my trip."

Goal
 ↓
Find transport
 ↓
Find hotel
 ↓
Check activities
 ↓
Calculate budget
 ↓
Create itinerary
```

Planning helps the agent:

* Break down complex tasks
* Identify dependencies
* Choose appropriate tools
* Track progress
* Reduce unnecessary actions

---

## 3. What is Reasoning?

**Reasoning** is the process of using available information to decide what should happen next.

Example:

```text
Tool result:
Flight A = ₹8,000
Flight B = ₹6,500

User wants cheapest flight.

Reasoning:
₹6,500 < ₹8,000

Decision:
Choose Flight B
```

In an agent:

```text
Observe
   ↓
Reason
   ↓
Decide
   ↓
Act
```

---

## 4. Planning vs Reasoning

They are related but different.

| Planning               | Reasoning                             |
| ---------------------- | ------------------------------------- |
| Decides the steps      | Decides what follows from information |
| More future-oriented   | Often based on current information    |
| Breaks goal into tasks | Evaluates options/results             |
| "What should I do?"    | "What does this result mean?"         |

Think:

```text
Planning  = What steps should I take?

Reasoning  = What should I conclude/do based on what I know?
```

---

## 5. How Planning Works in an Agent

A basic process:

```text
User Goal
   ↓
Understand Goal
   ↓
Break into Tasks
   ↓
Determine Dependencies
   ↓
Execute Task
   ↓
Observe Result
   ↓
Update Plan
   ↓
Execute Next Task
   ↓
Finish
```

Important:

> A plan does not always remain fixed.

The agent may modify the plan after observing new information.

---

## 6. Example: Research Task

User:

> "Compare two companies and tell me which is better for a software engineer."

Possible plan:

```text
1. Collect company information
2. Find engineering roles
3. Compare salaries
4. Compare technology stack
5. Compare growth opportunities
6. Compare work environment
7. Generate recommendation
```

The agent may execute:

```text
Search
 ↓
Results
 ↓
Need more information
 ↓
Search again
 ↓
Compare
 ↓
Final recommendation
```

---

## 7. Static vs Dynamic Planning

### Static Planning

The complete plan is created before execution.

```text
Plan:
1 → 2 → 3 → 4
```

Useful when the task is predictable.

### Dynamic Planning

The agent decides or updates the next step based on results.

```text
Step 1
 ↓
Result
 ↓
Decide Step 2
 ↓
Result
 ↓
Decide Step 3
```

Dynamic planning is common in agentic systems.

---

## 8. Task Decomposition

A complex task can be divided into smaller tasks.

Example:

```text
Goal:
"Build a sales report."

        ↓

1. Get sales data
2. Clean data
3. Calculate metrics
4. Generate charts
5. Write summary
```

This is called **task decomposition**.

---

## 9. Dependencies

Some tasks depend on previous tasks.

Example:

```text
Get sales data
      ↓
Clean data
      ↓
Calculate revenue
      ↓
Generate report
```

You cannot reliably calculate revenue before obtaining the required data.

Another example:

```text
Search flights ─────┐
                    ↓
                Compare
                    ↓
                 Select
                    ↓
                  Book
```

The booking step depends on the selected flight.

---

## 10. Parallel Tasks

Some tasks can be performed independently.

Example:

```text
              ┌→ Search flights ─┐
Goal ─────────┤                  ├→ Compare
              └→ Search hotels ──┘
```

If the tasks do not depend on each other, they may be executed in parallel.

Benefits:

* Lower latency
* Better resource utilization

But parallel execution must be safe and supported by the tools.

---

## 11. Replanning

An agent should be able to change its plan when something fails.

Example:

```text
Plan:
Search API → Get results → Compare

Search API
    ↓
Failure
    ↓
Replan
    ↓
Use another search source
    ↓
Continue
```

This makes an agent more robust than a rigid workflow.

---

## 12. Reasoning from Tool Results

Example:

```text
Goal:
Find a cheap hotel.

Tool result:
Hotel A = ₹5,000
Hotel B = ₹3,500
Hotel C = ₹4,200
```

Agent reasoning:

```text
Minimum price = ₹3,500

Decision:
Select Hotel B
```

The important pattern is:

```text
Tool Result
    ↓
Interpretation
    ↓
Decision
    ↓
Next Action
```

---

## 13. Planning with an Agent Loop

Planning and the agent loop work together:

```text
Goal
 ↓
Plan
 ↓
Action
 ↓
Observation
 ↓
Reason
 ↓
Update Plan
 ↓
Action
 ↓
Observation
 ↓
Finish
```

Therefore:

```text
Planning = deciding the route

Agent Loop = repeatedly executing and updating that route
```

---

## 14. Simple Python Example

```python
def create_plan(goal):
    return [
        "collect_data",
        "analyze_data",
        "generate_report"
    ]


plan = create_plan("Create sales report")

for task in plan:
    result = execute_task(task)
    print(task, result)
```

This is a simple **predefined plan**.

A more agentic version can decide the next task dynamically:

```python
while not goal_completed:

    decision = llm(state)

    action = decision["action"]

    result = execute_tool(action)

    state = update_state(state, result)
```

---

## 15. Planning Approaches

### Plan-and-Execute

```text
Create complete plan
       ↓
Execute plan
```

### ReAct-style Approach

A common agent pattern is:

```text
Reason
 ↓
Act
 ↓
Observe
 ↓
Reason
 ↓
Act
```

It interleaves decision making with actions instead of requiring a complete plan upfront.

### Hierarchical Planning

Break a large goal into subgoals:

```text
Main Goal
   ↓
Subgoal A
   ↓
Tasks A1, A2

Subgoal B
   ↓
Tasks B1, B2
```

Useful for complex tasks.

---

## 16. Important Limitation

LLM reasoning is not guaranteed to be correct.

The agent can:

* Choose the wrong tool
* Create an incorrect plan
* Misinterpret tool results
* Repeat actions
* Hallucinate information

Therefore use:

```text
LLM reasoning
+
Tool validation
+
Business rules
+
Limits
+
Human approval when necessary
```

Do not treat an LLM's reasoning as automatically trustworthy.

---

## 17. When Should You Use Planning?

Planning is useful when:

* The task has multiple steps
* Steps have dependencies
* The agent needs multiple tools
* The task may require replanning
* The goal is complex

For a simple deterministic operation:

```text
Input → Validate → Save
```

a normal programmatic workflow is usually better.

---

## 18. Key Mental Model

```text
Planning:
"What steps are needed?"

Reasoning:
"What should I do based on what I know?"

Agent Loop:
"Execute → Observe → Decide → Repeat"
```

Together:

```text
Goal
 ↓
Plan
 ↓
Reason
 ↓
Act
 ↓
Observe
 ↓
Replan if needed
 ↓
Finish
```

---

## 19. GATE / Interview Points

* Planning decomposes a complex goal into smaller tasks.
* Reasoning evaluates information and determines what should happen next.
* Static planning creates a plan before execution.
* Dynamic planning updates the plan based on observations.
* Task decomposition breaks complex tasks into smaller subtasks.
* Dependencies determine the order of execution.
* Independent tasks may be executed in parallel.
* Replanning helps recover from failures or unexpected results.
* ReAct interleaves reasoning/decision making with actions and observations.
* LLM reasoning is not guaranteed to be correct.
* Deterministic workflows are preferable when the process is fixed.

---

## 20. One-Line Revision

> **Planning = break the goal into steps; Reasoning = decide what to do from available information; Agent = execute, observe, reason and replan until the goal is completed.**

```
```
