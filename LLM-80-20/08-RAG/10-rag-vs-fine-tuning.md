# RAG vs Fine-Tuning

## 1. The basic idea

**RAG** and **fine-tuning** are two different ways of improving an AI application's behavior.

The simplest distinction:

```text
RAG
→ Give the model relevant information at runtime.

Fine-tuning
→ Modify the model's learned behavior using additional training.
```

Think:

```text
RAG
Question
   ↓
Retrieve information
   ↓
Give information to LLM
   ↓
Answer
```

versus:

```text
Fine-tuning
Training Dataset
   ↓
Train / Adapt Model
   ↓
Modified Model
   ↓
Question
   ↓
Answer
```

---

# 2. RAG

RAG stands for:

**Retrieval-Augmented Generation**

The model doesn't need to memorize your private documents.

Instead:

```text
Company Documents
      ↓
Vector Database
      ↓
Relevant Information
      ↓
LLM
      ↓
Answer
```

For example:

> "What is our company's leave policy?"

The application retrieves the company's current leave policy and provides it to the LLM.

---

# 3. Fine-tuning

Fine-tuning means taking an existing model and training it further on a specialized dataset.

Conceptually:

```text
Base Model
    +
Training Examples
    ↓
Fine-Tuning
    ↓
Adapted Model
```

For example, you might fine-tune a model to consistently produce:

```text
Specific output format
Specific writing style
Specific classification behavior
Specific task behavior
```

Fine-tuning is about changing model behavior rather than simply supplying external knowledge at inference time.

---

# 4. The most important distinction

Remember this:

> **RAG changes the context. Fine-tuning changes the model.**

RAG:

```text
Same Model
     +
Different Retrieved Context
     ↓
Different Answer
```

Fine-tuning:

```text
Adapted Model
     +
Question
     ↓
Different Behavior
```

---

# 5. Example: Company policies

Suppose your company has:

```text
employee-handbook.pdf
security-policy.pdf
leave-policy.pdf
```

These documents change frequently.

You generally don't want to retrain a model every time:

```text
Leave policy changes
       ↓
Retrain model?
```

Instead:

```text
Updated Document
      ↓
Re-index
      ↓
Vector DB
      ↓
Retrieve latest information
      ↓
LLM
```

This is a strong use case for RAG.

---

# 6. Example: Changing the model's style

Suppose you want an AI assistant to always produce:

```text
Summary
Root Cause
Impact
Fix
Prevention
```

You could potentially use fine-tuning to teach the model a consistent output behavior.

Conceptually:

```text
Training Examples
      ↓
Fine-Tuning
      ↓
Model learns desired behavior
```

This is different from retrieving company documents.

---

# 7. RAG is usually better for changing knowledge

Consider:

```text
Company Policies
Product Documentation
Pricing
Inventory
Customer Records
Internal Documentation
```

These can change frequently.

RAG works well because the knowledge can live outside the model.

```text
Updated Data
    ↓
Update Knowledge Base
    ↓
Retrieve at runtime
    ↓
LLM
```

You don't necessarily need to retrain the model.

---

# 8. Fine-tuning is usually better for behavior

Fine-tuning can be useful when you want the model to consistently perform a particular task.

Examples:

```text
Classification
Specific response format
Domain-specific style
Structured outputs
Specialized task behavior
```

Think:

```text
RAG
→ "What information should the model use?"

Fine-tuning
→ "How should the model behave?"
```

This is a useful mental shortcut.

---

# 9. Knowledge vs behavior

A common misconception is:

> "Fine-tuning is how I give the model my company's documents."

Not necessarily.

Suppose you have:

```text
10,000 company documents
```

and they change regularly.

Putting all of that knowledge into model weights through fine-tuning is generally not the most practical approach.

Instead:

```text
Documents
   ↓
RAG
   ↓
Relevant Context
   ↓
LLM
```

Fine-tuning is better suited to learning patterns of behavior from examples.

---

# 10. RAG architecture

```text
                 DOCUMENTS
                     │
                     ▼
                  Chunking
                     │
                     ▼
                 Embeddings
                     │
                     ▼
                Vector DB
                     │
                     │
User Question ───────┘
       │
       ▼
   Retrieval
       │
       ▼
Relevant Context
       │
       ▼
      LLM
       │
       ▼
    Answer
```

The model remains largely unchanged.

The **context changes**.

---

# 11. Fine-tuning architecture

```text
               Base Model
                   │
                   +
            Training Dataset
                   │
                   ▼
              Fine-Tuning
                   │
                   ▼
            Adapted Model
                   │
                   ▼
                Question
                   │
                   ▼
                Answer
```

The model's parameters are adapted during training.

---

# 12. RAG does not train the model

This is important.

When you perform:

```text
Question
 ↓
Retrieve documents
 ↓
Give documents to LLM
```

you are **not training the LLM**.

You're simply providing additional context during inference.

```text
Training
→ Changes model parameters

RAG
→ Changes runtime context
```

---

# 13. Fine-tuning does not automatically provide live knowledge

Suppose you fine-tune a model using:

```text
2025 company policy
```

Then the company changes the policy in 2026.

The model doesn't automatically know:

```text
2026 policy
```

You would need another training/update process.

RAG can instead retrieve the latest document.

```text
2025
 ↓
Old Document

2026
 ↓
Updated Document
 ↓
RAG retrieves latest version
```

---

# 14. RAG and hallucination

RAG can reduce hallucinations by providing relevant evidence.

Without RAG:

```text
Question
   ↓
LLM's learned knowledge
   ↓
Answer
```

With RAG:

```text
Question
   ↓
Retrieve Evidence
   ↓
LLM
   ↓
Grounded Answer
```

But:

> **RAG does not automatically eliminate hallucinations.**

The model can still:

* misunderstand context
* ignore retrieved information
* combine facts incorrectly
* generate unsupported claims

Therefore RAG needs evaluation and good prompting.

---

# 15. Fine-tuning and hallucination

Fine-tuning also does not automatically eliminate hallucinations.

Fine-tuning primarily changes model behavior.

It doesn't guarantee:

```text
100% factual answers
```

For factual, changing information, retrieval is often more appropriate.

---

# 16. When should you use RAG?

Use RAG when you need:

### 1. Private knowledge

```text
Company documents
Internal knowledge
Private databases
```

### 2. Frequently changing information

```text
Policies
Products
Pricing
Inventory
Documentation
```

### 3. Source citations

```text
Answer
+
Source
+
Page
```

### 4. Large external knowledge bases

```text
Thousands / millions of documents
```

### 5. Runtime information

```text
Current database records
Current internal documentation
```

---

# 17. When should you use fine-tuning?

Fine-tuning can be useful when you need:

### 1. Consistent behavior

```text
Always follow a specific response pattern
```

### 2. Specialized task performance

```text
Classification
Extraction
Specialized transformations
```

### 3. Consistent style

```text
Specific tone
Specific formatting
Specific domain style
```

### 4. Behavior that is difficult to achieve reliably through prompting

For example, if you have a large set of high-quality examples demonstrating exactly how the model should perform a task.

---

# 18. When should you use both?

This is very important.

You don't necessarily have to choose:

```text
RAG OR Fine-Tuning
```

You can use:

```text
RAG + Fine-Tuning
```

Example:

```text
Fine-Tuned Model
       +
Retrieved Company Context
       ↓
Answer
```

The fine-tuned model provides specialized behavior.

RAG provides current information.

---

# 19. Example: Enterprise support assistant

Imagine building an internal IT support assistant.

You want it to:

1. Follow your company's response format.
2. Use current IT documentation.
3. Give troubleshooting instructions.
4. Cite the relevant documentation.

You could use:

```text
Fine-Tuning
→ Teach response behavior

RAG
→ Retrieve current IT documentation
```

Architecture:

```text
                   User Question
                         │
                         ▼
                      RAG
                         │
                  Relevant Docs
                         │
                         ▼
                Fine-Tuned LLM
                         │
                         ▼
                      Answer
```

---

# 20. RAG vs fine-tuning table

| Feature                     | RAG                    | Fine-Tuning              |
| --------------------------- | ---------------------- | ------------------------ |
| Main purpose                | Add external knowledge | Adapt model behavior     |
| Changes model weights?      | No                     | Yes                      |
| Good for private documents? | Yes                    | Not usually by itself    |
| Good for changing data?     | Excellent              | Poor fit                 |
| Citations                   | Easy to implement      | Not inherent             |
| Updating knowledge          | Update data/index      | Retraining may be needed |
| Runtime retrieval           | Yes                    | No                       |
| Training required           | Usually no             | Yes                      |
| Can improve style?          | Limited                | Yes                      |
| Can improve task behavior?  | Limited                | Yes                      |
| Can be combined?            | Yes                    | Yes                      |

---

# 21. A simple decision framework

When you have a problem, ask:

### Question 1

> "Does the model need access to information that changes?"

If yes:

```text
RAG
```

---

### Question 2

> "Do I need the model to behave differently?"

If yes:

```text
Fine-Tuning
```

---

### Question 3

> "Do I need both?"

Then:

```text
RAG + Fine-Tuning
```

---

# 22. Example decision tree

```text
                 What is the problem?
                         │
             ┌───────────┴───────────┐
             ▼                       ▼
       Missing Knowledge       Wrong Behavior
             │                       │
             ▼                       ▼
            RAG                 Fine-Tuning
             │                       │
             └───────────┬───────────┘
                         ▼
                  Need both?
                         │
                         ▼
                    RAG + FT
```

---

# 23. RAG for current information

Suppose you build:

```text
Product Support AI
```

Your documentation changes every week.

RAG:

```text
New Documentation
      ↓
Re-index
      ↓
Available immediately
```

Fine-tuning:

```text
New Documentation
      ↓
Training Dataset
      ↓
Fine-Tuning
      ↓
New Model
```

RAG is generally much more convenient for frequently changing knowledge.

---

# 24. RAG for source attribution

Suppose the user asks:

> "What is our refund policy?"

RAG can retrieve:

```text
refund-policy.pdf
page 12
```

Then the application can produce:

```text
According to the refund policy, refunds are available
within 30 days of purchase.

Source:
refund-policy.pdf — Page 12
```

Fine-tuning doesn't inherently provide this retrieval-and-citation mechanism.

---

# 25. Fine-tuning for structured behavior

Suppose you want:

```text
Input:
Customer complaint
```

Output:

```json
{
  "category": "billing",
  "priority": "high",
  "sentiment": "negative"
}
```

You could potentially fine-tune a model using many examples.

The goal isn't to retrieve a document.

The goal is:

> **Learn a consistent mapping from input to desired output.**

---

# 26. RAG + structured output

However, RAG can also be combined with structured output.

Example:

```text
Question
   ↓
RAG
   ↓
Relevant Policy
   ↓
LLM
   ↓
JSON
```

So don't think:

```text
RAG = text only
Fine-tuning = structured output only
```

These are different dimensions.

---

# 27. RAG vs fine-tuning vs prompting

There are actually three major techniques:

```text
Prompting
RAG
Fine-Tuning
```

### Prompting

Tell the model how to behave.

```text
System Prompt
      +
Question
      ↓
LLM
```

### RAG

Give it external information.

```text
Question
      +
Retrieved Context
      ↓
LLM
```

### Fine-tuning

Train it on examples.

```text
Training Examples
      ↓
Adapt Model
      ↓
Question
      ↓
Answer
```

---

# 28. The three-layer mental model

Remember:

```text
                 AI APPLICATION
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
     Prompting         RAG        Fine-Tuning
        │              │              │
   Instructions    Knowledge       Behavior
```

Think:

```text
Prompting
→ Tell it what to do

RAG
→ Give it information

Fine-Tuning
→ Teach it a behavior
```

This is one of the most useful mental models for AI engineering.

---

# 29. Cost considerations

### RAG

Costs can include:

```text
Embedding
Vector storage
Retrieval
Reranking
LLM context tokens
```

### Fine-tuning

Costs can include:

```text
Training compute
Training data preparation
Model hosting
Model evaluation
Retraining when needed
```

The right choice depends on the application.

---

# 30. Latency considerations

RAG adds runtime steps:

```text
Query
 ↓
Embedding
 ↓
Retrieval
 ↓
Reranking
 ↓
LLM
```

Therefore it can add latency.

Fine-tuning may reduce some runtime complexity because the model's behavior is already adapted.

But a fine-tuned model still doesn't automatically have access to changing external information.

---

# 31. Updating the system

### RAG

```text
Document changes
      ↓
Re-index
      ↓
Done
```

### Fine-tuning

```text
New behavior/data
      ↓
Prepare dataset
      ↓
Fine-tune
      ↓
Evaluate
      ↓
Deploy new model
```

This is one of the biggest practical differences.

---

# 32. Security considerations

RAG has an important security advantage when implemented correctly:

You can control what information is retrieved.

For example:

```text
User A
 ↓
Authorized Documents
 ↓
RAG
```

User B:

```text
User B
 ↓
Different Authorized Documents
 ↓
RAG
```

The model can remain the same while the retrieved context changes.

This makes RAG useful for multi-user enterprise systems.

---

# 33. Fine-tuning private data

Be careful when using private company data for fine-tuning.

Once information is incorporated into model parameters, it isn't equivalent to having a clean external document store where individual records can simply be deleted or permission-filtered.

For enterprise applications, data governance and privacy requirements should therefore be considered carefully before fine-tuning on sensitive information.

---

# 34. RAG is not a replacement for fine-tuning

Sometimes people say:

> "You don't need fine-tuning because RAG exists."

That's too simplistic.

RAG and fine-tuning solve different problems.

```text
RAG
→ Knowledge retrieval

Fine-Tuning
→ Behavior adaptation
```

Both can be valuable.

---

# 35. Fine-tuning is not a replacement for RAG

Likewise:

> "Let's fine-tune the model with all our documents."

This is often a poor solution for frequently changing knowledge.

For example:

```text
Product catalog
Pricing
Inventory
Policies
Customer data
```

These are better treated as external data.

```text
External Data
     ↓
RAG / Database / API
     ↓
LLM
```

---

# 36. A practical enterprise architecture

A sophisticated enterprise AI system might look like:

```text
                       USER
                         │
                         ▼
                    AI ROUTER
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
         RAG            SQL            API
          │              │              │
          └──────────────┼──────────────┘
                         ▼
                  Specialized LLM
                         │
                         ▼
                      Answer
```

The LLM might also be fine-tuned for the organization's desired behavior.

```text
             RAG Context
                  +
          Fine-Tuned Model
                  ↓
               Answer
```

---

# 37. Common mistakes

## Mistake 1 — Using fine-tuning to store changing knowledge

Prefer RAG or a database for frequently changing information.

---

## Mistake 2 — Using RAG to teach behavior

If the problem is:

> "The model doesn't consistently follow our desired format."

First consider better prompting, structured outputs, or potentially fine-tuning.

---

## Mistake 3 — Thinking RAG eliminates hallucination

It doesn't.

---

## Mistake 4 — Thinking fine-tuning creates a database

It doesn't.

---

## Mistake 5 — Thinking RAG and fine-tuning are competitors

They solve different problems and can be combined.

---

# 38. What you should remember

The most important mental model:

```text
Prompting
   ↓
Tell the model what to do


RAG
   ↓
Give the model relevant information


Fine-Tuning
   ↓
Teach the model specialized behavior
```

Or even simpler:

```text
RAG
= Knowledge

Fine-Tuning
= Behavior
```

And:

```text
Changing Knowledge
       ↓
      RAG

Changing Behavior
       ↓
 Fine-Tuning
```

---

# 39. Interview questions

You should be able to answer:

1. What is RAG?
2. What is fine-tuning?
3. What is the difference between RAG and fine-tuning?
4. Does RAG change model weights?
5. Does fine-tuning provide real-time knowledge?
6. When should you use RAG?
7. When should you use fine-tuning?
8. Can RAG and fine-tuning be used together?
9. Why is RAG useful for changing information?
10. Why is fine-tuning useful for behavior?
11. Can fine-tuning eliminate hallucinations?
12. Can RAG eliminate hallucinations?
13. How does RAG support citations?
14. What is the difference between prompting, RAG, and fine-tuning?
15. How would you build an enterprise assistant using both RAG and fine-tuning?
16. Why might fine-tuning private documents be problematic for changing/access-controlled knowledge?
17. When would you choose RAG over fine-tuning?
18. When would you choose fine-tuning over RAG?
19. What happens when information in a RAG knowledge base changes?
20. What happens when behavior needs to change in a fine-tuned model?

---

# 40. Final mental model

```text
                       AI SYSTEM
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
      PROMPTING           RAG          FINE-TUNING
          │                │                │
          ▼                ▼                ▼
    Instructions       Knowledge        Behavior
          │                │                │
          └────────────────┼────────────────┘
                           ▼
                          LLM
                           │
                           ▼
                         Answer
```

**Core idea:**

> **Use RAG when the model needs access to external or changing knowledge. Use fine-tuning when you need to change or specialize the model's behavior. Use both when the application needs specialized behavior and current external knowledge.**

You now have the core **10-file RAG foundation**:

```text
01 — RAG Fundamentals
02 — Documents & Chunking
03 — Embeddings
04 — Vector Databases
05 — Similarity Search
06 — Cosine Similarity
07 — Retrieval
08 — Reranking
09 — RAG Pipeline
10 — RAG vs Fine-Tuning
```

This is enough to understand the **core mechanics of RAG**. The next level should move from theory into **building a practical RAG system** rather than adding endless concepts.
