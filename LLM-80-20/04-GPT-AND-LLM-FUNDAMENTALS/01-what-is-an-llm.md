Great. We’ll continue with **04-GPT-AND-LLM-FUNDAMENTALS**, one file at a time, in the same short and practical style.

### `01-what-is-an-llm.md`

````md
# What is an LLM?

## 1. What is an LLM?

**LLM = Large Language Model**

It is a neural network trained on a huge amount of text to learn patterns in language.

Its main job is to predict:

> **What token is likely to come next?**

Example:

```text
The capital of India is → Delhi
````

---

## 2. Why is it called "Large"?

Usually because it has:

* Large number of parameters
* Large training datasets
* Large computational requirements

Examples include GPT-style models, LLaMA-style models, and other modern language models.

---

## 3. How does an LLM work?

Simplified:

```text
Text
 ↓
Tokenization
 ↓
Token Embeddings
 ↓
Transformer Layers
 ↓
Next-token probabilities
 ↓
Select next token
 ↓
Repeat
 ↓
Generated text
```

The Transformer is the **core architecture** behind most modern LLMs.

---

## 4. What does an LLM actually learn?

It does not simply store sentences like a database.

During training, it learns statistical patterns and relationships between tokens.

For example:

```text
"Python is a ___"

→ programming language
```

It learns such relationships from enormous amounts of training data.

---

## 5. Where are LLMs used in Industry?

LLMs are used for:

* Chatbots
* Code generation
* Document summarization
* Customer support
* Search and RAG
* Text classification
* Content generation
* AI agents
* Data extraction

Example:

```text
Customer message
       ↓
      LLM
       ↓
Understand + Generate
       ↓
Customer Support Response
```

---

## 6. LLM vs Traditional NLP

| Traditional NLP                    | LLM                                 |
| ---------------------------------- | ----------------------------------- |
| Often task-specific                | General-purpose                     |
| Smaller models                     | Very large models                   |
| Requires more task-specific design | Can perform many tasks from prompts |
| Limited context                    | Large context windows               |

---

## 7. Important Point

An LLM does **not directly generate a complete answer at once**.

It generally generates:

```text
Token 1 → Token 2 → Token 3 → Token 4 → ...
```

This is called **autoregressive generation** in decoder-based LLMs.

---

## Mental Model

> **LLM = A large Transformer-based model trained to understand patterns in language and predict tokens.**

```

Next: `02-what-is-gpt.md`
```
