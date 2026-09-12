### `09-AGENTS/03-tools-and-function-calling.md`

````md
# Tools and Function Calling

## 1. What is Function Calling?

**Function calling** is a mechanism that allows an LLM to request a specific function/tool using structured arguments.

Instead of generating:

```text
"Please check the weather in Pune."
````

the model can generate a structured request:

```json
{
  "name": "get_weather",
  "arguments": {
    "city": "Pune"
  }
}
```

The application then executes the function.

---

## 2. Why is Function Calling Needed?

LLMs cannot directly perform arbitrary external actions.

For example:

```text
LLM
 ↓
"I should check the weather."
```

The LLM itself does not automatically access the weather API.

Instead:

```text
LLM
 ↓
Tool Call
 ↓
Application
 ↓
Weather API
 ↓
Result
 ↓
LLM
```

This makes LLM applications capable of interacting with external systems.

---

## 3. What is a Tool?

A **tool** is an external capability available to the LLM.

Examples:

```text
Search
Calculator
Weather API
Database
Code execution
Email
Calendar
Payment system
```

A tool generally has:

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

---

## 4. How Function Calling Works

Typical flow:

```text
User
 ↓
LLM
 ↓
Decides tool is required
 ↓
Generates structured tool call
 ↓
Application validates call
 ↓
Application executes tool
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

        ↓

LLM:
get_weather(city="Pune")

        ↓

Application:
Execute weather API

        ↓

Tool:
28°C, Sunny

        ↓

LLM:
"The weather in Pune is 28°C and sunny."
```

---

## 5. Tool Schema

The LLM needs to know what tools are available.

Example:

```json
{
  "name": "get_weather",
  "description": "Get current weather for a city",
  "parameters": {
    "type": "object",
    "properties": {
      "city": {
        "type": "string"
      }
    },
    "required": ["city"]
  }
}
```

The schema tells the model:

```text
What the tool does
What inputs it accepts
What type each input should have
Which inputs are required
```

---

## 6. Simple Python Example

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

name = tool_call["name"]
arguments = tool_call["arguments"]

result = tools[name](**arguments)

print(result)
```

Output:

```text
{'city': 'Pune', 'temperature': 28}
```

---

## 7. Multiple Tools

An agent can have multiple tools:

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
"25 × 48"
      ↓
calculate()

"Weather in Pune?"
      ↓
get_weather()

"Find latest AI news"
      ↓
search_web()
```

---

## 8. Function Calling vs Tool Execution

This distinction is important.

### Function Calling

The LLM produces:

```text
Tool name + Arguments
```

Example:

```json
{
  "name": "calculate",
  "arguments": {
    "expression": "25 * 48"
  }
}
```

### Tool Execution

The application actually runs:

```python
calculate("25 * 48")
```

Therefore:

```text
Function Calling = LLM requests an action

Tool Execution = Application performs the action
```

---

## 9. Tool Result

After execution, the result is sent back to the LLM.

```text
LLM
 ↓
calculate("25 * 48")
 ↓
Tool
 ↓
1200
 ↓
LLM
 ↓
"25 × 48 = 1200"
```

The tool result becomes part of the model's context for generating the final response or deciding the next action.

---

## 10. Tool Calling in an Agent

Function calling becomes especially useful in agents.

```text
Goal
 ↓
LLM
 ↓
Function Call
 ↓
Tool
 ↓
Result
 ↓
LLM
 ↓
Another Function Call
 ↓
Tool
 ↓
Result
 ↓
LLM
 ↓
Final Answer
```

Example:

```text
"Find the cheapest flight and email me."

LLM
 ↓
search_flights()
 ↓
Results
 ↓
LLM
 ↓
select_flight()
 ↓
Selected flight
 ↓
LLM
 ↓
send_email()
 ↓
Success
```

---

## 11. Tool Validation

Never blindly execute model-generated arguments.

Example:

```python
city = arguments.get("city")

if not isinstance(city, str):
    raise ValueError("Invalid city")
```

For important tools, validate:

```text
Input type
Required fields
Allowed values
User permissions
Business rules
```

---

## 12. Authorization

Tool access should depend on user permissions.

Example:

```text
User
 ↓
Can view account?
 ↓
YES → get_account()
NO  → Reject
```

Do not assume that because the LLM requested a tool, the user is authorized to use it.

---

## 13. Sensitive Tools

Some tools can cause real-world consequences.

Examples:

```text
Transfer money
Delete database record
Send email
Purchase product
Book flight
Change account settings
```

For these, use:

```text
LLM
 ↓
Tool request
 ↓
Validation
 ↓
User confirmation
 ↓
Execution
```

---

## 14. Error Handling

Tools can fail.

```python
try:
    result = tools[name](**arguments)
except Exception:
    result = {
        "error": "Tool execution failed"
    }
```

The agent can then decide:

```text
Retry
  OR
Use another tool
  OR
Ask user
  OR
Stop
```

Retries should have limits.

---

## 15. Tool Use vs Function Calling vs Agent

```text
Function Calling
        ↓
Structured request for a tool

Tool Use
        ↓
Using external capabilities

Agent
        ↓
Repeatedly deciding + using tools
        ↓
to achieve a goal
```

Think:

```text
Function Calling = Interface
Tool Use         = Capability
Agent            = Goal-oriented system
```

---

## 16. When Should You Use Function Calling?

Use it when:

* LLM needs external data
* LLM needs to perform an action
* Output must follow a structured tool schema
* Multiple tools are available
* Building an agent

Examples:

```text
Weather → get_weather()
Database → query_database()
Search → search_web()
Email → send_email()
Calculator → calculate()
```

---

## 17. Key Mental Model

```text
LLM
 ↓
"Which tool should I call?"
 ↓
Function Call
 ↓
Application
 ↓
Tool Execution
 ↓
Tool Result
 ↓
LLM
```

The most important point:

> **The LLM requests the tool; the application/runtime executes the tool.**

---

## 18. GATE / Interview Points

* Function calling lets an LLM generate structured requests for external functions/tools.
* A tool has a name, description and input schema.
* The application executes the requested function.
* Tool results are returned to the LLM.
* Function calling is not the same as tool execution.
* Validate model-generated arguments before execution.
* Authentication and authorization are required for protected tools.
* Sensitive operations may require human confirmation.
* Multiple tools allow an agent to dynamically choose capabilities.
* Tool calls can be chained inside an agent loop.
* Error handling and retry limits are important.

---

## 19. One-Line Revision

> **Function Calling = LLM produces a structured tool request → application validates and executes it → result goes back to the LLM.**

```
```
