### `07-LLM-APPLICATIONS/06-function-calling.md`

````md id="a7k2p9"
# Function Calling

## 1. What is Function Calling?

**Function calling** allows an LLM to request that an application execute a specific function/tool.

The LLM does not directly execute your code.

```text
User
 ↓
LLM
 ↓
Tool / Function Call
 ↓
Your Application executes function
 ↓
Result sent back to LLM
 ↓
Final Response
````

---

## 2. Why is it Needed?

An LLM by itself mainly generates text.

It cannot automatically:

* Check your database
* Book a ticket
* Get live weather
* Send an email
* Query your company's API

Function calling connects the LLM to **real-world actions and data**.

---

## 3. Where is it Used?

Common applications:

* AI agents
* Customer-support bots
* Database assistants
* Booking systems
* E-commerce
* Banking assistants
* RAG systems
* Automation tools

Example:

```text
User:
"What is the weather in Pune?"

        ↓

LLM decides:
call get_weather()

        ↓

Weather API

        ↓

Result:
28°C

        ↓

LLM

        ↓

"It's 28°C in Pune."
```

---

## 4. How Does Function Calling Work?

Suppose we provide this tool:

```python
def get_weather(city):
    ...
```

The model is given the tool's name, description, and input schema.

User asks:

```text
"What is the weather in Pune?"
```

The LLM may produce a structured tool call:

```json
{
  "name": "get_weather",
  "arguments": {
    "city": "Pune"
  }
}
```

Your application executes it:

```python
result = get_weather("Pune")
```

Then the result is sent back to the LLM.

```text
Tool Result
    ↓
LLM
    ↓
Natural-language answer
```

---

## 5. Important Point

The LLM **decides when and how to call the tool**, but your application controls the actual execution.

```text
LLM
→ "I need get_weather(Pune)"

Application
→ Actually calls the weather service
```

This separation is important for security and control.

---

## 6. Practical Example

```python
def get_user_balance(user_id):
    return 5000

# LLM requests:
tool_call = {
    "name": "get_user_balance",
    "arguments": {
        "user_id": "123"
    }
}

# Application executes the function
result = get_user_balance("123")

print(result)
```

A production system should validate the arguments and authorize the operation before executing sensitive tools.

---

## 7. Function Calling vs Normal Prompting

### Normal Prompt

```text
"What is my bank balance?"
```

The LLM cannot know the live balance just from the prompt.

### Function Calling

```text
User
 ↓
LLM
 ↓
get_balance()
 ↓
Bank System
 ↓
Balance
 ↓
LLM
 ↓
Answer
```

Now the model can use real-time application data.

---

## 8. Function Calling vs RAG

```text
RAG
→ Retrieve information

Function Calling
→ Execute a function / perform an action
```

Example:

```text
RAG:
"Find the company's refund policy."

Function:
"Create a refund request."
```

They can also be combined in one application.

---

## 9. When Should You Use Function Calling?

Use it when the LLM needs to:

* Access external data
* Call APIs
* Query databases
* Perform actions
* Interact with software tools
* Work as an AI agent

Do **not** give an LLM unrestricted access to sensitive functions.

---

## 10. Industry Architecture

```text
                 ┌── Weather API
                 │
User → LLM → Tool Router
                 │
                 ├── Database
                 │
                 ├── Search API
                 │
                 └── Business API
                       ↓
                  Tool Result
                       ↓
                      LLM
                       ↓
                   User Answer
```

This is a fundamental building block of **AI agents**.

---

## GATE / Interview Points

* Function calling connects an LLM with external functions/tools.
* The model generates a structured request for a tool.
* The application executes the actual function.
* Tool results can be passed back to the LLM.
* Useful for real-time data and actions.
* Validate and authorize tool calls before executing sensitive operations.
* Function calling is a key component of agentic LLM applications.

---

## Mental Model

> **Function Calling = LLM decides which tool is needed; your application executes the tool and returns the result.**

```

Next: `07-tool-use.md`
```
