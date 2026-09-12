### `09-AGENTS/04-agent-memory.md`

````md
# Agent Memory

## 1. What is Agent Memory?

**Agent memory** is the mechanism that allows an AI agent to retain and use information from previous interactions or previous steps.

Without memory:

```text
User → Agent → Answer
````

With memory:

```text
User
 ↓
Agent
 ↓
Memory
 ↓
Context
 ↓
Agent
 ↓
Answer
```

Memory helps an agent maintain **context, state, preferences, and previous results**.

---

## 2. Why is Memory Needed?

Consider:

```text
User:
"My name is Rahul."

Later:

User:
"What is my name?"
```

Without memory, the agent may not know.

With memory:

```text
"My name is Rahul"
        ↓
Stored
        ↓
Later retrieved
        ↓
Agent: "Your name is Rahul."
```

Memory is especially useful for:

* Multi-turn conversations
* Long-running tasks
* User preferences
* Previous tool results
* Agent state

---

## 3. Types of Agent Memory

### A. Short-Term Memory

Stores information needed during the current task/conversation.

Example:

```text
User:
Book a flight to Delhi.

Agent:
Which date?

User:
25 September.

Agent:
Which class?

User:
Economy.
```

The agent needs previous messages to understand:

```text
Destination = Delhi
Date = 25 September
Class = Economy
```

This is short-term conversational context.

---

### B. Long-Term Memory

Stores information that may be useful across future conversations.

Example:

```text
User:
"I prefer Python for programming."

Future conversation:

Agent:
Provides Python examples by default.
```

Long-term memory can store useful preferences or facts when the application is designed to do so.

---

### C. Episodic Memory

Stores information about **past events or experiences**.

Example:

```text
Previous task:
Agent researched a company's financial report.
```

Later:

```text
Agent can refer to that previous research.
```

Think:

```text
Episodic = What happened?
```

---

### D. Semantic Memory

Stores general facts or knowledge.

Example:

```text
User preference:
Preferred programming language = Python
```

Think:

```text
Semantic = What is known?
```

---

## 4. Memory vs Context Window

These are different.

### Context Window

Information currently provided to the LLM.

```text
Prompt
+
Conversation history
+
Retrieved information
```

### Memory

Information stored outside the immediate model context and retrieved when needed.

```text
Memory Store
     ↓
Retrieve relevant information
     ↓
Add to context
     ↓
LLM
```

Think:

```text
Context = What the model can see now

Memory = What the application can remember and retrieve later
```

---

## 5. How Agent Memory Works

Typical architecture:

```text
User
 ↓
Agent
 ↓
Retrieve relevant memory
 ↓
Build context
 ↓
LLM
 ↓
Response
 ↓
Store useful information
```

Example:

```text
User:
"I prefer vegetarian restaurants."

        ↓

Memory Store:
preference = vegetarian

        ↓

Future request:
"Find me a restaurant."

        ↓

Retrieve preference

        ↓

Agent:
Searches vegetarian restaurants
```

---

## 6. Simple Memory Implementation

A very basic memory can be a dictionary:

```python
memory = {}

def save_memory(key, value):
    memory[key] = value

def get_memory(key):
    return memory.get(key)

save_memory("language", "Python")

print(get_memory("language"))
```

Output:

```text
Python
```

Real systems usually use persistent storage instead of an in-memory dictionary.

---

## 7. Memory with a Database

A database can store structured memory:

```text
User ID
Preference
Value
Timestamp
```

Example:

```text
user_123
language
Python
```

Architecture:

```text
Agent
 ↓
Memory Service
 ↓
Database
```

Possible technologies:

```text
PostgreSQL
Redis
Document databases
Vector databases
```

The correct storage depends on the type of memory and retrieval requirement.

---

## 8. Vector Memory

For semantic retrieval, information can be converted into embeddings.

```text
Memory
 ↓
Embedding Model
 ↓
Vector
 ↓
Vector Database
```

Later:

```text
New Query
 ↓
Embedding
 ↓
Similarity Search
 ↓
Relevant Memories
 ↓
LLM
```

Example:

```text
Stored:
"I prefer short explanations."

Query:
"Explain transformers."

 ↓

Semantic retrieval

 ↓

Memory:
User prefers short explanations.

 ↓

LLM:
Provides a concise explanation.
```

---

## 9. Memory in an Agent Loop

Memory can be part of every iteration:

```text
Goal
 ↓
Retrieve Memory
 ↓
LLM Decision
 ↓
Tool
 ↓
Observation
 ↓
Update Memory/State
 ↓
LLM Decision
 ↓
...
```

Example:

```text
Goal:
Plan a trip

 ↓

Memory:
User prefers budget travel

 ↓

Search flights

 ↓

Observation:
Flight A = ₹8,000

 ↓

Remember result

 ↓

Search hotels

 ↓

Use previous information

 ↓

Final plan
```

---

## 10. Memory vs Agent State

These are related but different.

### Agent State

Information required to manage the **current execution**.

```text
Current step
Tool results
Task status
Intermediate data
```

### Memory

Information that can be retained and reused beyond the immediate step/task.

```text
User preferences
Past interactions
Previous experiences
Useful facts
```

Think:

```text
State  = What is happening now?

Memory = What should be remembered?
```

---

## 11. Memory Management

An agent should not store everything.

Bad approach:

```text
Store every message forever
```

Problems:

* Storage cost
* Privacy risks
* Irrelevant information
* Retrieval noise
* Larger context

Better approach:

```text
Interaction
 ↓
Determine importance
 ↓
Store useful information
 ↓
Retrieve only when relevant
```

---

## 12. Memory Retrieval

When a new request arrives:

```text
Query
 ↓
Search memory
 ↓
Rank relevant memories
 ↓
Select useful memories
 ↓
Add to LLM context
```

The agent should retrieve **relevant** memories rather than dumping the entire history into the prompt.

---

## 13. Important Security Considerations

Memory can contain sensitive information.

Therefore use:

* Access control
* Data minimization
* Encryption where appropriate
* Retention policies
* User controls
* Secure storage
* Memory validation

Never assume that every piece of conversation should be permanently stored.

---

## 14. When Should You Use Memory?

Use memory when:

* Conversations span multiple turns
* Tasks continue over time
* User preferences matter
* Previous results are useful
* The agent needs persistent state

You may not need long-term memory for:

```text
One-shot question
Simple calculation
Static response
```

---

## 15. Practical Architecture

```text
                 ┌───────────────┐
                 │     User      │
                 └───────┬───────┘
                         ↓
                 ┌───────────────┐
                 │     Agent     │
                 └───────┬───────┘
                         ↓
                 Retrieve Memory
                         ↓
                 ┌───────────────┐
                 │      LLM      │
                 └───────┬───────┘
                         ↓
                    Tool / Action
                         ↓
                    Observation
                         ↓
                  Update Memory
                         ↓
                       User
```

---

## 16. Key Mental Model

```text
Short-Term Memory
      ↓
Current context

Long-Term Memory
      ↓
Persistent useful information

Agent State
      ↓
Current task execution
```

Remember:

> **Memory is not simply "putting the entire chat history into the prompt."**

It is the controlled process of **storing, retrieving, and using relevant information**.

---

## 17. GATE / Interview Points

* Agent memory allows information to persist across interactions or agent steps.
* Short-term memory is mainly current conversational/task context.
* Long-term memory persists useful information for future interactions.
* Agent state describes the current execution.
* Memory and context window are different concepts.
* Vector databases can support semantic memory retrieval.
* Memory retrieval should return relevant information, not everything.
* Storing unnecessary information increases cost and privacy risk.
* Memory systems need access control and retention policies.
* Memory is useful for personalization and long-running agents.

---

## 18. One-Line Revision

> **Agent Memory = Store useful information → retrieve relevant information when needed → provide it to the agent as context for better decisions.**

```
```
