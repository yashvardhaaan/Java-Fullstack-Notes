### `07-LLM-APPLICATIONS/03-llm-api.md`

````md id="k4n8q1"
# LLM API

## 1. What is an LLM API?

An **LLM API** allows an application to communicate with a language model over the internet.

Instead of running the LLM yourself:

```text
Your Application
      ↓
    API Request
      ↓
   LLM Server
      ↓
   API Response
      ↓
Your Application
````

---

## 2. Why Use an LLM API?

Running a large LLM yourself can require:

* Powerful GPUs
* Large GPU memory
* Model deployment infrastructure
* Scaling and monitoring

An API lets developers use a hosted model without managing the underlying infrastructure.

---

## 3. Where is it Used?

LLM APIs are used in:

* Chatbots
* Web applications
* Mobile apps
* RAG systems
* Coding assistants
* Customer support
* AI agents
* Document processing

Example:

```text
E-commerce Website
       ↓
Customer Question
       ↓
Backend
       ↓
LLM API
       ↓
Generated Answer
       ↓
Customer
```

---

## 4. How Does an LLM API Work?

A typical request contains:

```text
Model
+
Messages / Prompt
+
Generation settings
```

Example conceptually:

```python
request = {
    "model": "some-llm",
    "messages": [
        {
            "role": "user",
            "content": "Explain recursion simply."
        }
    ]
}
```

The application sends the request to the API.

The API returns the generated response.

---

## 5. Practical Example

Conceptual Python code:

```python
import requests

response = requests.post(
    "https://api.example.com/chat",
    headers={
        "Authorization": "Bearer API_KEY"
    },
    json={
        "model": "some-llm",
        "messages": [
            {
                "role": "user",
                "content": "What is Python?"
            }
        ]
    }
)

print(response.json())
```

In real applications, use the SDK/documentation provided by the LLM provider.

---

## 6. API Key

Most hosted LLM APIs require authentication.

```text
Application
    ↓
API Key
    ↓
LLM Provider
```

### Important

Never expose API keys in frontend code.

Bad:

```javascript
const API_KEY = "secret-key";
```

Better:

```text
Frontend
   ↓
Your Backend
   ↓
API Key stored securely
   ↓
LLM API
```

---

## 7. API Response

The response may contain:

```text
Generated text
Usage information
Model information
Finish reason
```

Your application can then:

```text
API Response
     ↓
Validate
     ↓
Process
     ↓
Show to User
```

---

## 8. Streaming

For long responses, an API can stream tokens/chunks as they are generated.

Without streaming:

```text
Request → Wait → Complete Response
```

With streaming:

```text
Request
  ↓
Token → Token → Token → Token
  ↓
Display progressively
```

Streaming is useful for chat interfaces because the user sees the response sooner.

---

## 9. When Should You Use an LLM API?

Use an API when:

* You want to integrate an LLM quickly.
* You don't want to manage GPU infrastructure.
* You need access to hosted models.
* Your application needs scalable inference.

Self-hosting may make sense when you need more control over infrastructure, privacy, latency, or cost at sufficient scale.

---

## 10. Production Considerations

A production LLM API integration should consider:

```text
Authentication
Rate limits
Timeouts
Retries
Error handling
Input validation
Output validation
Token/cost management
Logging & monitoring
```

Example:

```text
User
 ↓
Backend
 ↓
Validate Input
 ↓
LLM API
 ↓
Validate Output
 ↓
User
```

---

## GATE / Interview Points

* LLM API allows applications to access an LLM programmatically.
* Request usually contains a model and input/messages.
* API authentication is commonly required.
* API keys should be kept on the backend.
* Streaming improves perceived response latency.
* Production systems need error handling, rate-limit handling and output validation.
* API usage usually incurs usage-based cost depending on the provider/model.

---

## Mental Model

> **LLM API = A bridge that lets your application send input to a hosted LLM and receive its output.**

```

Next: `04-structured-output.md`
```
