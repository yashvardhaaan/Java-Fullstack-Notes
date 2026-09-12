### `07-LLM-APPLICATIONS/05-streaming.md`

````md
# Streaming

## 1. What is Streaming?

**Streaming** means sending the LLM's response to the user **as it is generated**, instead of waiting for the complete response.

### Without Streaming

```text
User
 ↓
LLM generates entire response
 ↓
Complete response
 ↓
User sees it
````

### With Streaming

```text
User
 ↓
LLM
 ↓
Token → Token → Token → Token
 ↓      ↓      ↓      ↓
User sees response progressively
```

---

## 2. Why is Streaming Needed?

LLMs can take time to generate long responses.

Without streaming:

```text
Request → [wait 5 seconds] → Full response
```

With streaming:

```text
Request → "The" → "capital" → "of" → "India" → ...
```

The total generation time may not disappear, but **perceived latency** becomes much better.

---

## 3. Where is Streaming Used?

Common examples:

* Chatbots
* AI assistants
* Coding assistants
* Customer-support applications
* AI writing tools
* Voice/interactive AI systems

Chat interfaces commonly stream generated text so users can start reading immediately.

---

## 4. How Does It Work?

The backend keeps the connection open and receives generated chunks/tokens.

```text
Frontend
   ↓
Backend
   ↓
LLM API
   ↓
Chunk 1
Chunk 2
Chunk 3
Chunk 4
   ↓
Frontend displays progressively
```

A common web approach is **Server-Sent Events (SSE)**, although other streaming mechanisms can also be used.

---

## 5. Practical Example

Conceptually:

```python
for chunk in llm_stream(prompt):
    print(chunk, end="", flush=True)
```

Instead of waiting for:

```text
"Artificial intelligence is..."
```

the application might receive:

```text
"Artificial"
" intelligence"
" is"
...
```

and display each chunk immediately.

---

## 6. Streaming in a Chat Application

```text
User
 ↓
"Explain Transformers"
 ↓
Backend
 ↓
LLM API
 ↓
"The"
 ↓
"Transformer"
 ↓
"is"
 ↓
"an"
 ↓
"architecture..."
 ↓
Browser displays continuously
```

The frontend updates the same message as new chunks arrive.

---

## 7. When Should You Use Streaming?

Use streaming when:

* Responses are long.
* Users expect interactive responses.
* Perceived latency matters.
* You are building a chat interface.
* You want users to see progress immediately.

For short responses, streaming may not provide much benefit.

---

## 8. Important Practical Considerations

Streaming introduces additional application complexity.

Your system should handle:

```text
Connection errors
Partial responses
Timeouts
Cancellation
Final response assembly
```

For example, if the user presses **Stop**, the backend should cancel generation when supported.

---

## 9. Streaming vs Batch Response

| Normal Response               | Streaming                           |
| ----------------------------- | ----------------------------------- |
| Complete response at once     | Chunks arrive progressively         |
| Simple implementation         | More complex                        |
| Higher perceived waiting time | Lower perceived waiting time        |
| Good for short responses      | Good for long interactive responses |

---

## GATE / Interview Points

* Streaming sends generated output progressively.
* It improves **perceived latency**.
* It does not necessarily make the model generate tokens faster.
* Common in chat applications.
* Backend and frontend must handle partial responses.
* SSE is one common mechanism for HTTP-based streaming.

---

## Mental Model

> **Streaming = Don't make the user wait for the whole answer; show the answer as the LLM generates it.**

```

Next: `06-function-calling.md`
```
