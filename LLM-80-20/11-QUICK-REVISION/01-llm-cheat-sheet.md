### `11-QUICK-REVISION/01-llm-cheat-sheet.md`

````md
# LLM Cheat Sheet

## 1. What is an LLM?

**LLM (Large Language Model)** is a neural network trained on large amounts of text to predict and generate tokens.

```text
Text
 ↓
Tokenization
 ↓
Tokens
 ↓
Embeddings
 ↓
Transformer
 ↓
Next-token probabilities
 ↓
Generated text
````

---

## 2. Core LLM Concepts

```text
Token
Embedding
Parameters
Context Window
Logits
Softmax
Temperature
Inference
Autoregressive Generation
Transformer
Attention
```

---

## 3. Token

A **token** is a unit of text processed by the model.

Example:

```text
"I love Python"
      ↓
["I", " love", " Python"]
```

Important:

```text
Token ≠ Always one word
```

A word can be:

```text
One token
Multiple tokens
```

---

## 4. Embedding

An embedding converts a token into a numerical vector.

```text
Token
 ↓
Embedding
 ↓
[0.21, -0.45, 0.73, ...]
```

Purpose:

> Convert discrete tokens into continuous numerical representations that neural networks can process.

---

## 5. Parameters

**Parameters** are learned numerical values inside the model.

They are updated during training.

```text
Training
 ↓
Adjust Parameters
 ↓
Better Predictions
```

More parameters do **not automatically** mean a better model.

---

## 6. Context Window

The **context window** is the maximum amount of information the model can process in one request.

```text
System Prompt
+
User Input
+
Conversation
+
Retrieved Context
+
Tool Results
```

All consume context capacity.

Important:

```text
Context Window ≠ Long-Term Memory
```

---

## 7. Transformer

Modern LLMs are primarily based on the **Transformer architecture**.

Core components:

```text
Input
 ↓
Embedding
 ↓
Positional Information
 ↓
Attention
 ↓
Feed-Forward Network
 ↓
Residual + Normalization
 ↓
Repeated Layers
 ↓
Output
```

---

## 8. Attention

Attention allows a token to determine which other tokens are important.

Example:

```text
"The animal didn't cross the road because it was tired."
                                      ↑
                              What is "it"?
```

Attention helps the model use relevant context.

Basic formula:

```text
Attention(Q,K,V)
=
softmax(QKᵀ / √dₖ)V
```

Where:

```text
Q = Query
K = Key
V = Value
```

---

## 9. Multi-Head Attention

Instead of using one attention operation:

```text
Attention
```

the Transformer uses multiple attention heads:

```text
Head 1 → Syntax
Head 2 → Relationships
Head 3 → Context
...
```

Conceptually:

```text
Input
 ↓
Multiple Attention Heads
 ↓
Concatenate
 ↓
Linear Projection
```

---

## 10. Positional Information

Attention alone does not inherently know token order.

Positional information tells the model where tokens occur.

```text
"I love Python"

I       → Position 1
love    → Position 2
Python  → Position 3
```

Without positional information, token relationships would lose important ordering information.

---

## 11. Feed-Forward Network

After attention, each Transformer layer contains a feed-forward network.

Conceptually:

```text
x
 ↓
Linear
 ↓
Activation
 ↓
Linear
 ↓
Output
```

Its role is to transform the representation after attention.

---

## 12. Residual Connection

Residual connections help information and gradients flow through deep networks.

```text
x
 ↓
Layer
 ↓
F(x)
 ↓
F(x) + x
```

Formula:

```text
Output = x + F(x)
```

---

## 13. Layer Normalization

Layer normalization stabilizes neural network activations.

Conceptually:

```text
Input
 ↓
Normalize
 ↓
Transformer Layer
```

It helps make deep Transformer training more stable.

---

## 14. GPT

**GPT = Generative Pre-trained Transformer**

GPT-style models are generally:

```text
Transformer Decoder
+
Autoregressive Language Modeling
```

They generate text one token at a time.

```text
"The cat"
     ↓
Predict next token
     ↓
"sat"
     ↓
Predict next token
     ↓
"on"
```

---

## 15. Autoregressive Language Modeling

The model predicts the next token using previous tokens.

```text
Token₁
 ↓
Token₂
 ↓
Token₃
 ↓
Token₄
```

Mathematically:

```text
P(x₁, x₂, ..., xₙ)
=
Π P(xₜ | x₁, ..., xₜ₋₁)
```

---

## 16. Next-Token Prediction

Training objective:

```text
Previous Tokens
      ↓
LLM
      ↓
Predict Next Token
      ↓
Compare with Actual Token
      ↓
Loss
```

Example:

```text
Input:
"The capital of France is"

Target:
"Paris"
```

---

## 17. Logits

The final neural network output before softmax is called **logits**.

Example:

```text
Paris   → 8.2
London  → 5.1
Berlin  → 4.2
```

Higher logit generally means higher probability after softmax.

```text
Logits
 ↓
Softmax
 ↓
Probabilities
```

---

## 18. Softmax

Softmax converts logits into probabilities.

Formula:

```text
Pᵢ = eˣⁱ / Σeˣʲ
```

Example:

```text
Logits
 ↓
[2.0, 1.0, 0.5]
 ↓
Softmax
 ↓
[0.63, 0.23, 0.14]
```

Probabilities sum to:

```text
1
```

---

## 19. Temperature

Temperature controls how deterministic/random token selection is.

```text
Low Temperature
 ↓
More predictable
```

```text
High Temperature
 ↓
More diverse/random
```

Conceptually:

```text
Temperature ↓ → Distribution sharper
Temperature ↑ → Distribution flatter
```

---

## 20. Inference

**Inference** is using a trained model to generate predictions.

```text
Prompt
 ↓
Tokenizer
 ↓
Model
 ↓
Logits
 ↓
Sampling / Selection
 ↓
Next Token
 ↓
Repeat
 ↓
Final Output
```

Training:

```text
Learn parameters
```

Inference:

```text
Use learned parameters
```

---

## 21. Training vs Inference

| Training                  | Inference                    |
| ------------------------- | ---------------------------- |
| Learns parameters         | Uses learned parameters      |
| Requires loss calculation | Usually no parameter updates |
| Backpropagation           | Forward computation          |
| Very compute intensive    | Usually cheaper              |
| Produces trained model    | Produces predictions         |

---

## 22. Context Window vs Parameters

### Parameters

```text
Learned knowledge/capability
```

### Context

```text
Information provided during the current request
```

Example:

```text
Model:
70B parameters

Current prompt:
10,000 tokens
```

These represent completely different concepts.

---

## 23. LLM Generation

Complete generation flow:

```text
Prompt
 ↓
Tokenize
 ↓
Token Embeddings
 ↓
Transformer Layers
 ↓
Logits
 ↓
Softmax
 ↓
Token Selection
 ↓
Append Token
 ↓
Repeat
 ↓
Stop Token
 ↓
Output
```

---

## 24. Why Does an LLM Generate One Token at a Time?

Autoregressive models predict:

```text
P(next token | previous tokens)
```

Example:

```text
Input:
"I am learning"

Prediction:
"Python"

New context:
"I am learning Python"

Prediction:
"programming"
```

The generated token becomes part of the next input.

---

## 25. Pretraining

Pretraining teaches the model general language patterns using a large dataset.

```text
Large Text Dataset
       ↓
Tokenization
       ↓
Next-Token Prediction
       ↓
Loss
       ↓
Backpropagation
       ↓
Parameter Update
       ↓
Repeat
```

---

## 26. Cross-Entropy Loss

For next-token prediction, cross-entropy is commonly used.

Conceptually:

```text
Correct token probability ↑
        ↓
Loss ↓
```

For one correct class:

```text
Loss = -log(p_correct)
```

If:

```text
p_correct = 0.9
```

loss is low.

If:

```text
p_correct = 0.1
```

loss is high.

---

## 27. Gradient Descent

Gradient descent updates parameters to reduce loss.

```text
Parameters
 ↓
Forward Pass
 ↓
Loss
 ↓
Gradient
 ↓
Parameter Update
```

Basic update:

```text
θ_new = θ_old - η∇L
```

Where:

```text
θ = parameters
η = learning rate
L = loss
```

---

## 28. Fine-Tuning

Fine-tuning adapts a pretrained model to a specific task/domain.

```text
Pretrained LLM
      ↓
Task-specific Dataset
      ↓
Fine-Tuning
      ↓
Specialized Model
```

Examples:

```text
Customer support
Medical domain
Code generation
Classification
Instruction following
```

---

## 29. Alignment

Alignment attempts to make model behavior more useful, safe and consistent with desired instructions/preferences.

Common concepts:

```text
Instruction tuning
Preference optimization
RLHF
DPO
Safety training
```

Simplified:

```text
Pretraining
 ↓
Instruction/Preference Training
 ↓
Aligned Model
```

---

## 30. RAG

**RAG = Retrieval-Augmented Generation**

It provides external information to the LLM.

```text
Documents
 ↓
Chunking
 ↓
Embeddings
 ↓
Vector Database
 ↓
Retriever
 ↓
Relevant Context
 ↓
LLM
 ↓
Answer
```

Useful for:

* Private documents
* Company knowledge
* Frequently changing information
* Domain-specific knowledge

---

## 31. Tool Use

Tools give an LLM external capabilities.

```text
LLM
 ↓
Tool Call
 ↓
Application
 ↓
External Tool
 ↓
Tool Result
 ↓
LLM
```

Examples:

```text
Search
Calculator
Database
Weather API
Email
Code execution
```

---

## 32. AI Agent

An agent uses an LLM to achieve a goal through iterative actions.

```text
Goal
 ↓
LLM
 ↓
Decide
 ↓
Tool
 ↓
Observe
 ↓
LLM
 ↓
Decide Again
 ↓
...
 ↓
Finish
```

Core idea:

```text
Agent = LLM + Tools + State/Memory + Loop
```

---

## 33. Hallucination

Hallucination occurs when the model generates false or unsupported information.

```text
Question
 ↓
LLM
 ↓
Confident but unsupported answer
```

Reduction techniques:

```text
RAG
Tools
Trusted data
Grounding
Validation
Citations
Human review
```

Important:

```text
Model confidence ≠ Truth
```

---

## 34. LLM Evaluation

Evaluation measures how well the model/application performs.

Common metrics:

```text
Accuracy
Precision
Recall
F1
BLEU
ROUGE
Faithfulness
Relevance
Task Success
Latency
Cost
```

Evaluation loop:

```text
Dataset
 ↓
LLM
 ↓
Output
 ↓
Metrics
 ↓
Failure Analysis
 ↓
Improve
 ↓
Evaluate Again
```

---

## 35. Important LLM Architecture

```text
                  Input Text
                     ↓
                 Tokenizer
                     ↓
                 Embeddings
                     ↓
            Positional Information
                     ↓
          ┌─────────────────────┐
          │ Transformer Block   │
          │                     │
          │ Self-Attention      │
          │        ↓            │
          │ Feed Forward        │
          │        ↓            │
          │ Residual + Norm     │
          └──────────┬──────────┘
                     ↓
               Repeat Layers
                     ↓
                   Logits
                     ↓
                 Softmax
                     ↓
               Next Token
```

---

## 36. Most Important Formulas

### Attention

```text
Attention(Q,K,V)
=
softmax(QKᵀ / √dₖ)V
```

### Softmax

```text
Pᵢ = eˣⁱ / Σeˣʲ
```

### Cross-Entropy

```text
L = -log(p_correct)
```

### Gradient Descent

```text
θ_new = θ_old - η∇L
```

### F1

```text
F1 = 2PR / (P + R)
```

---

## 37. Quick Comparison

| Concept        | Meaning                                 |
| -------------- | --------------------------------------- |
| Token          | Unit processed by LLM                   |
| Embedding      | Numerical representation                |
| Parameter      | Learned model value                     |
| Logit          | Raw output score                        |
| Softmax        | Converts logits to probabilities        |
| Temperature    | Controls sampling randomness            |
| Context Window | Current information capacity            |
| Attention      | Determines relevant token relationships |
| Transformer    | Core neural architecture                |
| GPT            | Generative Pre-trained Transformer      |
| RAG            | Retrieves external knowledge            |
| Tool           | External capability                     |
| Agent          | Goal-oriented system using LLM + tools  |
| Hallucination  | False/unsupported output                |
| Evaluation     | Measures system quality                 |

---

## 38. Interview Quick Answers

### What is an LLM?

> A neural network trained on large-scale text to model token sequences and generate text.

### Why Transformer?

> It enables efficient parallel training and captures long-range dependencies using attention.

### Why attention?

> It allows tokens to dynamically use information from other relevant tokens.

### Why GPT?

> GPT uses a decoder-style Transformer with autoregressive next-token prediction for text generation.

### What is RAG?

> RAG retrieves relevant external information and provides it to the LLM as context before generation.

### What is hallucination?

> Generation of false, fabricated, or unsupported information.

### What is inference?

> Running a trained model to generate predictions without updating its parameters.

### What is an agent?

> A goal-oriented system that uses an LLM to decide actions, use tools, observe results, and iterate.

---

## 39. Final Mental Model

```text
                 LLM
                  │
        ┌─────────┴─────────┐
        ↓                   ↓
    Transformer          Training
        ↓                   ↓
    Attention          Loss + Backprop
        ↓
   Next Token
        ↓
   Generation
        │
        ├── RAG → External Knowledge
        ├── Tools → External Capabilities
        └── Agents → Goal-oriented Actions
```

## One-Line Revision

> **LLM = Transformer-based neural network that learns token patterns and generates text through autoregressive next-token prediction.**

```
```
