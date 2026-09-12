You're right — the screenshot shows the actual sequence. We should **not add extra files like Temperature or Top-K/Top-P**. We continue with the files shown.

### `07-context-window.md`

````md
# Context Window

## 1. What is a Context Window?

The **context window** is the maximum amount of information an LLM can process at one time.

It is measured in **tokens**.

```text
Prompt + Previous conversation + Other input
                    ↓
              Context Window
                    ↓
                   LLM
````

---

## 2. Simple Example

If a model has a context window of:

```text
128K tokens
```

it can process roughly up to 128,000 tokens of input context at once.

This includes things like:

* User prompt
* Previous messages
* Documents
* Code
* Retrieved RAG chunks

---

## 3. Why is Context Window Important?

Suppose you give an LLM a large document:

```text
100-page document
       ↓
     LLM
       ↓
Question about page 80
```

If the relevant information fits inside the model's context, the model can use it directly.

If the input exceeds the context limit, some information must be removed, truncated, or handled separately.

---

## 4. Context Window ≠ Memory

These are different concepts.

```text
Context Window
→ Information available in the current request

Memory
→ Information stored/retrieved across interactions
```

An LLM does not automatically have unlimited memory of everything it has ever seen.

---

## 5. Context Window in RAG

RAG systems retrieve only relevant information instead of sending an entire database.

```text
User Question
     ↓
Vector Search
     ↓
Relevant Documents
     ↓
Context Window
     ↓
LLM
     ↓
Answer
```

This helps use the context window efficiently.

---

## 6. Industry Usage

Context windows matter when building:

* Chatbots
* RAG systems
* Coding assistants
* Document analysis systems
* AI agents
* Long conversations

For example, when building a RAG application, developers must decide **how much retrieved text to put into the LLM's context**.

Too little → useful information may be missing.

Too much → unnecessary tokens and higher cost/latency.

---

## 7. Important Point

Context window is usually measured in **tokens, not words**.

```text
Characters → Tokens → Context Window
```

The exact number of words represented by a token count depends on the language and text.

---

## GATE / Interview Points

* Context window = maximum tokens the model can process in one context.
* It includes input/context provided to the model.
* Larger context allows more information to be processed.
* Context window is different from model parameters.
* RAG helps select relevant information to fit within the context.

---

## Mental Model

> **Context Window = The amount of information the LLM can "see" at one time.**

```

Next: `08-parameters.md`
```
