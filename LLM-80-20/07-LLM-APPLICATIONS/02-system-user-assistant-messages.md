### `07-LLM-APPLICATIONS/02-system-user-assistant-messages.md`

````md id="x4p8q2"
# System, User and Assistant Messages

## 1. What are Messages?

Chat-based LLM applications usually structure conversations into different message roles:

```text
System
  ↓
User
  ↓
Assistant
  ↓
User
  ↓
Assistant
````

Each role has a different purpose.

---

## 2. What is a System Message?

A **system message** defines the model's overall behavior, rules, or role.

Example:

```text
"You are a helpful Python tutor.
Give simple explanations and examples."
```

### Why?

It provides instructions that should guide the assistant throughout the conversation.

### Where?

Commonly used in:

* Chatbots
* AI assistants
* Customer support
* Enterprise applications
* AI agents

---

## 3. What is a User Message?

The **user message** contains the actual request or input.

Example:

```text
"Explain Python lists."
```

The application sends this to the model along with relevant system/context messages.

---

## 4. What is an Assistant Message?

The **assistant message** is the model's response.

Example:

```text
"Python lists are ordered collections..."
```

In a multi-turn conversation, previous assistant responses can also become part of the context.

---

## 5. How Do They Work Together?

Example:

```text
System:
"You are a programming tutor."

User:
"Explain recursion."

Assistant:
"Recursion is when a function calls itself..."
```

The model uses the available conversation context to generate the assistant response.

---

## 6. Practical API Example

A typical chat API request conceptually looks like:

```python
messages = [
    {
        "role": "system",
        "content": "You are a helpful Python tutor."
    },
    {
        "role": "user",
        "content": "Explain recursion simply."
    }
]
```

The LLM receives these messages and generates an assistant response.

---

## 7. Why Separate the Roles?

Separating roles makes application instructions clearer.

```text
System
→ Application-level behavior

User
→ User's request

Assistant
→ Model's response
```

For example, an application can keep:

```text
System:
"Always answer in JSON."

User:
"Extract the customer's email."
```

The model can then be instructed to return structured output.

---

## 8. When Should You Use a System Message?

Use it when your application needs **consistent behavior across requests**.

Example:

```text
Customer Support Bot

System:
"You are a customer-support assistant.
Be concise and professional."
```

Every user request can then follow the same general behavior.

---

## 9. Multi-Turn Conversation

A conversation can contain many messages:

```text
System
   ↓
User
   ↓
Assistant
   ↓
User
   ↓
Assistant
```

Previous messages may be included in the model's context so the assistant can respond based on the conversation history.

However, the conversation must fit within the model's available context window.

---

## 10. Practical Application Architecture

```text
Frontend
   ↓
User Message
   ↓
Backend
   ↓
Build Message List
   ├── System instructions
   ├── Conversation history
   └── Current user message
   ↓
LLM API
   ↓
Assistant Response
   ↓
Frontend
```

The backend commonly controls the system instructions and how conversation history is assembled.

---

## GATE / Interview Points

* **System** → Defines application/model behavior.
* **User** → Contains the user's request.
* **Assistant** → Contains the model's response.
* Multiple messages form the conversation context.
* Previous messages consume context-window tokens.
* Message roles are important when building chat-based LLM applications.

---

## Mental Model

> **System = How to behave**
>
> **User = What I want**
>
> **Assistant = What the model answers**

```

Next: `03-llm-api.md`
```
