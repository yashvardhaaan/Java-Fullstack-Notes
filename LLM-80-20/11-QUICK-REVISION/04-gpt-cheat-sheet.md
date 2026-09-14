### `11-QUICK-REVISION/04-gpt-cheat-sheet.md`

````md
# GPT Cheat Sheet

## 1. What is GPT?

**GPT = Generative Pre-trained Transformer**

GPT is a family of language models based on the **Transformer architecture**, typically using a decoder-only architecture for autoregressive text generation.

```text
GPT
├── Generative
├── Pre-trained
└── Transformer
````

---

## 2. What Does Each Word Mean?

### Generative

The model generates new text.

```text
Prompt
 ↓
GPT
 ↓
Generated tokens
```

### Pre-trained

The model is trained on large-scale data before being adapted or used for downstream tasks.

### Transformer

The model uses Transformer blocks based heavily on self-attention.

---

## 3. GPT Architecture

Simplified GPT architecture:

```text
Input Text
    ↓
Tokenizer
    ↓
Token IDs
    ↓
Token Embeddings
    +
Positional Information
    ↓
┌─────────────────────┐
│ Transformer Block   │
│                     │
│ Causal Attention    │
│        ↓            │
│ Feed-Forward        │
│        ↓            │
│ Residual + Norm     │
└─────────┬───────────┘
          ↓
     Repeat N times
          ↓
      Final Norm
          ↓
    Linear Projection
          ↓
        Logits
          ↓
       Softmax
          ↓
    Next Token
```

---

## 4. Why is GPT Decoder-Only?

GPT is designed for **autoregressive generation**.

It predicts:

```text
P(next token | previous tokens)
```

Example:

```text
"The capital of France is"
                ↓
              Paris
```

The model does not need a separate encoder to generate the next token.

---

## 5. Autoregressive Generation

GPT generates text one token at a time.

Example:

```text
Input:
"I am learning"

        ↓

Predict:
"AI"

        ↓

"I am learning AI"

        ↓

Predict:
"engineering"

        ↓

"I am learning AI engineering"
```

Mathematically:

```text
P(x₁, x₂, ..., xₙ)
=
∏ P(xₜ | x₁, ..., xₜ₋₁)
```

---

## 6. Causal Attention

GPT uses **causal/masked self-attention**.

A token cannot attend to future tokens.

Example:

```text
I     love     Python
↓
When predicting "Python":

I       → visible
love    → visible
Python  → target
future  → hidden
```

Mask concept:

```text
[1 0 0]
[1 1 0]
[1 1 1]
```

This prevents future-token information leakage.

---

## 7. GPT Training

GPT is commonly pretrained using next-token prediction.

```text
Training Text
      ↓
Tokenization
      ↓
Input Tokens
      ↓
GPT
      ↓
Predict Next Token
      ↓
Cross-Entropy Loss
      ↓
Backpropagation
      ↓
Update Parameters
```

This process is repeated over a large training corpus.

---

## 8. Example of Next-Token Training

Text:

```text
"The sun rises in the east"
```

Training examples can be created from the sequence:

```text
Input:
"The"

Target:
"sun"
```

```text
Input:
"The sun"

Target:
"rises"
```

```text
Input:
"The sun rises"

Target:
"in"
```

```text
Input:
"The sun rises in"

Target:
"the"
```

The model learns to predict the next token from preceding tokens.

---

## 9. GPT Inference

Inference means using the trained model to generate output.

```text
Prompt
 ↓
Tokenizer
 ↓
GPT
 ↓
Logits
 ↓
Sampling / Selection
 ↓
Next Token
 ↓
Append Token
 ↓
GPT again
 ↓
Next Token
 ↓
...
 ↓
Stop
```

---

## 10. Logits and Softmax

GPT's final layer produces **logits**.

Example:

```text
Paris   → 8.2
London  → 5.4
Berlin  → 4.7
```

Softmax converts logits into probabilities.

```text
Logits
  ↓
Softmax
  ↓
Probabilities
```

Then a decoding strategy selects the next token.

---

## 11. Temperature

Temperature controls the sharpness of the probability distribution during sampling.

```text
Low temperature
    ↓
More deterministic
```

```text
High temperature
    ↓
More diverse
```

Conceptually:

```text
Temperature ↓ → Distribution becomes sharper
Temperature ↑ → Distribution becomes flatter
```

---

## 12. Token Selection

After probabilities are calculated, the next token can be selected using different decoding strategies.

### Greedy Decoding

Select the highest-probability token.

```text
A → 0.70
B → 0.20
C → 0.10

Choose A
```

### Sampling

Randomly sample according to probabilities.

### Top-k

Only consider the `k` highest-probability tokens.

```text
Top-3:
A
B
C
```

### Top-p / Nucleus Sampling

Select the smallest set of tokens whose cumulative probability reaches `p`.

```text
p = 0.90
```

The candidate set can change at every generation step.

---

## 13. Context Window

GPT can only process a finite amount of context per request.

```text
System instructions
+
Conversation
+
User input
+
Retrieved context
+
Tool results
```

All contribute to the context.

Important:

```text
Context Window ≠ Model Parameters
```

---

## 14. Parameters

GPT models contain learned parameters.

Parameters are updated during training:

```text
Training
 ↓
Loss
 ↓
Gradients
 ↓
Parameter Updates
```

A parameter count describes the number of learned values in the model.

More parameters do not automatically guarantee better performance.

---

## 15. GPT vs BERT

| GPT                              | BERT                                               |
| -------------------------------- | -------------------------------------------------- |
| Decoder-only style               | Encoder-only                                       |
| Autoregressive                   | Typically masked-language-model pretraining        |
| Designed strongly for generation | Designed strongly for representation/understanding |
| Causal attention                 | Bidirectional attention during encoding            |
| Text generation                  | Classification, embeddings, understanding          |

Simple mental model:

```text
GPT  → Generate
BERT → Understand / Represent
```

This is a simplification; both can support more tasks through adaptation.

---

## 16. GPT vs Original Transformer

### Original Transformer

```text
Encoder + Decoder
```

Mainly designed for sequence-to-sequence tasks such as translation.

### GPT

```text
Decoder-only
```

Designed around autoregressive language modeling.

```text
Original Transformer:
Input → Encoder → Decoder → Output

GPT:
Prompt → Decoder Stack → Next Token
```

---

## 17. GPT vs RAG

GPT:

```text
Prompt
 ↓
Model
 ↓
Generated answer
```

RAG:

```text
Question
 ↓
Retriever
 ↓
External Documents
 ↓
GPT/LLM
 ↓
Grounded Answer
```

RAG is an **application architecture**, not a replacement for the language model.

---

## 18. GPT vs Fine-Tuning

### Pretraining

Teaches general language capabilities.

```text
Large Dataset
 ↓
Pretraining
 ↓
Base Model
```

### Fine-Tuning

Adapts the model using additional task/domain data.

```text
Base Model
 ↓
Task-specific Dataset
 ↓
Fine-Tuning
 ↓
Specialized Model
```

### Prompting

Changes the instructions without changing model parameters.

```text
Same Model
+
Different Prompt
```

---

## 19. GPT Generation Pipeline

```text
User Prompt
    ↓
Tokenization
    ↓
Token IDs
    ↓
Embeddings
    ↓
Transformer Blocks
    ↓
Causal Self-Attention
    ↓
Feed-Forward Networks
    ↓
Final Hidden State
    ↓
Linear Output Layer
    ↓
Logits
    ↓
Softmax / Decoding
    ↓
Next Token
    ↓
Repeat
```

---

## 20. KV Cache

During autoregressive generation, GPT can cache previously calculated keys and values.

```text
Previous Tokens
      ↓
K,V computed
      ↓
KV Cache
      ↓
New Token
      ↓
Attention uses cached K,V
```

Benefits:

```text
Less repeated computation
        ↓
Faster generation
```

Trade-off:

```text
Faster inference
+
Higher memory usage
```

---

## 21. GPT and Context

Suppose:

```text
Prompt:
"Explain recursion using Python."
```

The model processes the prompt and predicts:

```text
"Recursion"
```

Then the context becomes approximately:

```text
"Explain recursion using Python. Recursion ..."
```

The model predicts the next token again.

This continues until:

```text
Stop token
OR
Maximum output length
OR
Application-defined stopping condition
```

---

## 22. GPT Training vs Inference

| Training               | Inference                   |
| ---------------------- | --------------------------- |
| Learns parameters      | Uses learned parameters     |
| Calculates loss        | Generates predictions       |
| Backpropagation        | Mainly forward computation  |
| Parameter updates      | No normal parameter updates |
| Very compute intensive | Usually cheaper per request |

---

## 23. GPT Limitations

GPT-style models can suffer from:

```text
Hallucination
Knowledge cutoff/outdated information
Context limitations
Reasoning errors
Bias
Prompt sensitivity
High inference cost
Latency
```

Solutions can include:

```text
RAG
Tool use
Better prompting
Fine-tuning
Guardrails
Evaluation
Human verification
```

---

## 24. GPT in an LLM Application

A production application is usually more than GPT itself:

```text
                 User
                   ↓
                Frontend
                   ↓
                Backend
                   ↓
       ┌───────────┼───────────┐
       ↓           ↓           ↓
     Memory       RAG        Tools
       ↓           ↓           ↓
       └───────────┼───────────┘
                   ↓
                  GPT
                   ↓
              Validation
                   ↓
                Response
```

GPT is the model component inside the larger application.

---

## 25. Most Important Formulas

### Autoregressive Probability

```text
P(x₁,...,xₙ)
=
∏ P(xₜ | x₁,...,xₜ₋₁)
```

### Attention

```text
Attention(Q,K,V)
=
softmax(QKᵀ / √dₖ)V
```

### Cross-Entropy for Correct Token

```text
L = -log(p_correct)
```

### Gradient Descent

```text
θ_new = θ_old - η∇L
```

---

## 26. Quick Comparison

| Concept          | Meaning                                      |
| ---------------- | -------------------------------------------- |
| GPT              | Generative Pre-trained Transformer           |
| Token            | Unit processed by the model                  |
| Context          | Information available for current generation |
| Parameter        | Learned model value                          |
| Logit            | Raw output score                             |
| Softmax          | Converts logits to probabilities             |
| Temperature      | Controls sampling distribution               |
| Causal Attention | Prevents future-token access                 |
| KV Cache         | Speeds autoregressive generation             |
| Pretraining      | Learns general language patterns             |
| Fine-tuning      | Adapts a pretrained model                    |
| RAG              | Adds external retrieved context              |
| Tool Use         | Gives external capabilities                  |
| Agent            | Uses LLM + tools + loop toward a goal        |

---

## 27. Common Interview Questions

### What does GPT stand for?

> Generative Pre-trained Transformer.

### Why is GPT autoregressive?

> Because it predicts the next token using previously available tokens.

### Why does GPT use causal masking?

> To prevent future tokens from being visible during autoregressive prediction.

### Is GPT an encoder or decoder?

> GPT-style architectures are decoder-only Transformers.

### What is the GPT training objective?

> Commonly next-token prediction optimized using cross-entropy loss.

### What is the difference between GPT and BERT?

> GPT is decoder-only and autoregressive, while BERT is encoder-only and uses bidirectional context during its standard masked-language-model pretraining.

### What happens during GPT inference?

> The model predicts a next-token distribution, selects a token using a decoding strategy, appends it to the context, and repeats.

### What is KV cache?

> Cached attention keys and values from previous tokens used to reduce repeated computation during autoregressive generation.

### Does RAG change the GPT model parameters?

> No. RAG normally supplies retrieved information as additional context without changing the model weights.

### Does prompting change GPT parameters?

> No. Prompting changes the input/instructions, not the model weights.

---

## 28. Final Mental Model

```text
                 GPT
                  ↓
        Decoder-Only Transformer
                  ↓
          Causal Self-Attention
                  ↓
         Next-Token Prediction
                  ↓
               Logits
                  ↓
         Decoding / Sampling
                  ↓
             Next Token
                  ↓
                Repeat
```

## One-Line Revision

> **GPT = Decoder-only Transformer trained primarily with autoregressive next-token prediction and used to generate text token by token.**

```
```
