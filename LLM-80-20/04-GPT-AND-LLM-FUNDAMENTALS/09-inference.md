### `09-inference.md`

````md
# Inference

## 1. What is Inference?

**Inference is the process of using a trained model to make predictions or generate output.**

Training:

```text
Data → Model → Learn Parameters
````

Inference:

```text
Input → Trained Model → Output
```

---

## 2. LLM Inference

For an LLM:

```text
Prompt
  ↓
Tokenization
  ↓
Transformer
  ↓
Logits
  ↓
Token Selection
  ↓
Next Token
  ↓
Repeat
```

Example:

```text
Input:
"India's capital is"

Model:
"Delhi"
```

---

## 3. Training vs Inference

| Training                       | Inference                        |
| ------------------------------ | -------------------------------- |
| Learns parameters              | Uses learned parameters          |
| Requires large compute         | Usually less compute             |
| Weights are updated            | Weights are not updated          |
| Usually done before deployment | Happens when users send requests |

---

## 4. Why is Inference Important?

In real-world AI applications, users interact with the model during inference.

Example:

```text
User
 ↓
API Request
 ↓
LLM Inference
 ↓
Response
 ↓
User
```

Inference speed directly affects **user experience**.

---

## 5. Important Inference Metrics

### Latency

How long it takes to produce a response.

### Throughput

How many requests/tokens the system can process in a given time.

### Cost

How much compute is required for each request.

---

## 6. Where Used in Industry?

Inference happens whenever a deployed AI model is used:

* Chatbots
* AI coding tools
* RAG applications
* Recommendation systems
* Document processing
* AI agents
* Voice assistants

---

## 7. Inference Optimization

Companies use techniques such as:

* Quantization
* KV caching
* Batching
* Smaller models
* GPU acceleration
* Model distillation

The goal is:

```text
Lower latency
+ Lower cost
+ Good quality
```

---

## GATE / Interview Points

* Inference = using a trained model to produce predictions.
* Model parameters are generally not updated during inference.
* LLM inference generates tokens sequentially.
* Latency and throughput are important deployment metrics.
* Inference optimization reduces cost and response time.

---

## Mental Model

> **Training teaches the model; inference uses what it learned.**

```

Next: `10-how-an-llm-generates-text.md`
```
