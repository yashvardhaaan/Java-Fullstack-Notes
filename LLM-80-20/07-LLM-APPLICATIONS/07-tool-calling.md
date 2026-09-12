### `07-LLM-APPLICATIONS/07-tool-use.md`

````md
# Tool Use

## 1. What is Tool Use?

**Tool Use** means allowing an LLM to use external tools to get information or perform actions.

Examples:
- Web search
- Calculator
- Database query
- Weather API
- Code execution
- Send email
- Create support ticket
- Book an appointment

The LLM decides **which tool to use and what arguments to provide**, while the application/tool runtime actually executes it.

---

## 2. Why is Tool Use Needed?

An LLM alone has limitations:

- Knowledge may be outdated
- Cannot directly access private databases
- Cannot perform real-world actions
- Cannot reliably perform complex calculations
- Cannot access external APIs by itself

Tool use connects the LLM to the **outside world**.

```text
LLM Knowledge
     +
External Tools
     ↓
More capable application
````

---

## 3. Where is Tool Use Used?

### Information Retrieval

```text
LLM → Search API → Latest information
```

### Business Applications

```text
LLM → Database → Customer information
```

### Automation

```text
LLM → Email API → Send email
```

### AI Agents

```text
LLM → Tool → Result → LLM → Another Tool → Final answer
```

---

## 4. How Does Tool Use Work?

Typical flow:

```text
User
  ↓
LLM
  ↓
Decides whether a tool is required
  ↓
Generates tool name + arguments
  ↓
Application executes the tool
  ↓
Tool result
  ↓
LLM
  ↓
Final response
```

Example:

```text
User:
"What is the weather in Pune?"

LLM:
Use get_weather(city="Pune")

Application:
Calls weather API

Tool:
28°C, Sunny

LLM:
"The weather in Pune is 28°C and sunny."
```

---

## 5. Tool Definition

A tool normally contains:

```text
Name
Description
Input schema
Implementation
```

Example:

```python
def get_weather(city):
    return {
        "city": city,
        "temperature": 28,
        "condition": "Sunny"
    }
```

Tool description:

```text
Name:
get_weather

Description:
Get current weather for a city.

Input:
city: string
```

The model uses this information to decide when and how to call the tool.

---

## 6. Simple Tool Router

```python
def get_weather(city):
    return {
        "city": city,
        "temperature": 28
    }


tools = {
    "get_weather": get_weather
}

tool_call = {
    "name": "get_weather",
    "arguments": {
        "city": "Pune"
    }
}

tool = tools[tool_call["name"]]

result = tool(**tool_call["arguments"])

print(result)
```

Output:

```text
{'city': 'Pune', 'temperature': 28}
```

---

## 7. Tool Use vs Function Calling

These terms are related but not identical.

| Function Calling                        | Tool Use                                      |
| --------------------------------------- | --------------------------------------------- |
| Mechanism/interface                     | Broader concept                               |
| Produces structured function/tool calls | LLM uses external capabilities                |
| Usually returns name + arguments        | Includes the complete tool execution workflow |
| Part of modern LLM APIs                 | Used to build agents and applications         |

Think:

```text
Function Calling = How the LLM requests a tool

Tool Use = Request + Execution + Result + Continued reasoning
```

---

## 8. Tool Use vs RAG

| RAG                                 | Tool Use                                    |
| ----------------------------------- | ------------------------------------------- |
| Mainly retrieves information        | Retrieves information or performs actions   |
| Usually searches a knowledge source | Can call APIs, databases, calculators, etc. |
| Commonly read-only                  | Can be read-only or action-oriented         |
| Example: search company documents   | Example: create a support ticket            |

Important:

```text
Search database → can be RAG
Search API      → can be Tool Use
Send email      → Tool Use
```

---

## 9. Multiple Tools

An application can provide many tools:

```python
tools = {
    "get_weather": get_weather,
    "calculate": calculate,
    "search_web": search_web,
    "get_customer": get_customer
}
```

The LLM chooses the appropriate tool.

Example:

```text
User:
"What is 25 × 48?"

LLM → calculate()

User:
"What is today's weather?"

LLM → get_weather()

User:
"Find the latest news."

LLM → search_web()
```

---

## 10. Tool Chaining

Tools can be used sequentially.

Example:

```text
User:
"Find the cheapest flight and email me the details."

LLM
 ↓
Search flight API
 ↓
Compare results
 ↓
Select cheapest flight
 ↓
Email tool
 ↓
Send email
 ↓
Final response
```

This is an important building block of **AI agents**.

---

## 11. Important Safety Rules

Never blindly execute model-generated actions.

Use:

### Input validation

Check tool arguments.

### Authorization

Verify that the user is allowed to perform the action.

### Least privilege

Give tools only the permissions they need.

### Confirmation

Ask before sensitive actions.

```text
"Send ₹50,000 to X?"
        ↓
User confirmation
        ↓
Execute
```

### Error handling

```python
try:
    result = tool(**arguments)
except Exception:
    result = {"error": "Tool failed"}
```

Also use:

* Timeouts
* Logging/auditing
* Rate limits
* Output validation

---

## 12. When Should You Use Tool Use?

Use tools when:

* Information must be current
* External data is required
* Private data is required
* A real-world action must be performed
* Accurate computation is required
* The application needs automation

Avoid unnecessary tool calls when the LLM can answer reliably from its existing knowledge.

---

## 13. Real-World Architecture

```text
                  ┌──────────────┐
                  │     User     │
                  └──────┬───────┘
                         ↓
                  ┌──────────────┐
                  │     LLM      │
                  └──────┬───────┘
                         ↓
                  Tool Decision
                         ↓
              ┌──────────┴──────────┐
              ↓          ↓           ↓
           Search      Database     API
              ↓          ↓           ↓
              └──────────┬───────────┘
                         ↓
                    Tool Result
                         ↓
                        LLM
                         ↓
                   Final Answer
```

---

## 14. Key Mental Model

```text
LLM = Brain
Tool = Capability
Tool Runtime = Hands
Tool Result = New Information
```

The LLM does **not automatically execute arbitrary tools**.

The application/runtime executes the tool and sends the result back to the LLM.

---

## 15. GATE / Interview Points

* Tool use allows LLMs to interact with external systems.
* The model generally selects the tool and generates arguments.
* The application executes the tool.
* Function calling is a structured mechanism for requesting tool execution.
* Tool use can be read-only or action-oriented.
* Tool chaining is commonly used in AI agents.
* Validate tool inputs and outputs.
* Authorization and least privilege are important for security.
* Sensitive actions should generally require confirmation.
* Tool use can provide current information that may not exist in the model's training data.

---

## 16. One-Line Revision

> **Tool Use = LLM decides what external capability is needed → application executes the tool → result is returned to the LLM → LLM continues the task.**

```

**Next:** `08-RAG` — send the screenshot of that folder so I can follow the **exact filenames** rather than guessing.
```
