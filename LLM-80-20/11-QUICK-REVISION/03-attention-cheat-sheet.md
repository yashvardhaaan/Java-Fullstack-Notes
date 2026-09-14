### `11-QUICK-REVISION/03-attention-cheat-sheet.md`

````md
# Attention Cheat Sheet

## 1. What is Attention?

**Attention** allows a model to determine which parts of the input are important when processing a particular token.

Example:

```text
"The animal didn't cross the road because it was tired."
                                                    ↑
                                                 "it"
````

Attention helps the model use relevant surrounding information to understand relationships.

---

## 2. Why Attention?

Before attention, sequence models such as RNNs/LSTMs processed information sequentially.

Problems:

```text
Long sequence
     ↓
Information must pass through many steps
     ↓
Long-range dependencies become difficult
```

Attention provides a direct mechanism for relating different positions.

```text
Token A ─────────→ Token B
Token C ─────────→ Token B
Token D ─────────→ Token B
```

---

## 3. Core Idea

For each token:

```text
"What other tokens should I pay attention to?"
```

The model calculates a weight for other tokens.

Example:

```text
Token:
"it"

Attention weights:

animal → 0.50
road   → 0.10
tired  → 0.30
the    → 0.10
```

The exact values are learned/calculated by the model.

---

# 4. Query, Key, Value

Attention uses three vectors:

```text
Q = Query
K = Key
V = Value
```

Intuition:

```text
Query → What information am I looking for?

Key   → What information does each token offer?

Value → What information should be passed forward?
```

Example:

```text
Query
  ↓
Compare with Keys
  ↓
Attention Scores
  ↓
Weights
  ↓
Weighted Values
```

---

## 5. Attention Formula

Scaled dot-product attention:

```text
Attention(Q, K, V)
=
softmax(QKᵀ / √dₖ)V
```

This is one of the most important Transformer formulas.

---

## 6. Step-by-Step Attention

### Step 1: Calculate Q, K, V

Input representation:

```text
X
 ↓
Linear projections
 ↓
Q, K, V
```

```text
Q = XWQ
K = XWK
V = XWV
```

---

### Step 2: Calculate Similarity

Calculate:

```text
QKᵀ
```

This produces attention scores.

Conceptually:

```text
Query × Key
     ↓
How relevant is this key?
```

---

### Step 3: Scale

```text
QKᵀ / √dₖ
```

Why?

Large dot products can make softmax excessively sharp.

Scaling improves numerical/training stability.

---

### Step 4: Softmax

```text
Scores
  ↓
Softmax
  ↓
Attention Weights
```

Example:

```text
[2.0, 1.0, 0.5]
      ↓
[0.63, 0.23, 0.14]
```

Weights sum to approximately:

```text
1
```

---

### Step 5: Weighted Sum of Values

```text
Attention Weights
        ×
       Values
        ↓
New Representation
```

Formula:

```text
Output = AttentionWeights × V
```

---

# 7. Complete Attention Flow

```text
Input X
  ↓
┌───────┬───────┬───────┐
│  WQ   │  WK   │  WV   │
└───┬───┴───┬───┴───┬───┘
    ↓       ↓       ↓
    Q       K       V
    │       │
    └── QKᵀ ┘
         ↓
     Scale √dₖ
         ↓
      Softmax
         ↓
 Attention Weights
         ↓
   × V
         ↓
      Output
```

---

# 8. Self-Attention

**Self-attention** means Q, K and V are derived from the same input sequence.

```text
Input
 ↓
Q, K, V
 ↓
Self-Attention
 ↓
Output
```

Example:

```text
"The cat drank milk because it was hungry."
```

Every token can potentially interact with other tokens.

---

# 9. Cross-Attention

In **cross-attention**, Q comes from one sequence while K and V come from another.

```text
Sequence A
    ↓
    Q

Sequence B
    ↓
   K, V

    ↓
Cross-Attention
```

Commonly used in encoder-decoder Transformers.

Example:

```text
English sentence
      ↓
Encoder
      ↓
K, V

Decoder
 ↓
Q
 ↓
Cross-Attention
```

---

# 10. Self-Attention vs Cross-Attention

| Self-Attention                     | Cross-Attention                                   |
| ---------------------------------- | ------------------------------------------------- |
| Q, K, V from same sequence         | Q and K/V from different sources                  |
| Tokens interact within a sequence  | One component attends to another                  |
| Used in encoder and decoder blocks | Common in encoder-decoder models                  |
| GPT uses causal self-attention     | Original Transformer decoder uses cross-attention |

---

# 11. Causal / Masked Attention

GPT-style models use **causal self-attention**.

The model must not see future tokens while predicting the next token.

Example:

```text
Tokens:

I     love     Python
```

When predicting:

```text
Python
```

the model can use:

```text
I
love
```

but not future tokens.

Mask:

```text
[1 0 0]
[1 1 0]
[1 1 1]
```

Conceptually:

```text
Allowed → 1
Blocked → 0
```

---

# 12. Why Causal Masking?

Without masking:

```text
Input:
"I love Python"
```

When predicting `"Python"`, the model could directly look at `"Python"`.

That would cause **information leakage** during training.

Causal masking ensures:

```text
Prediction at position t
        ↓
Uses only positions ≤ t
```

---

# 13. Multi-Head Attention

Instead of one attention operation, Transformers use multiple attention heads.

```text
Input
  ↓
┌────────┬────────┬────────┐
│ Head 1 │ Head 2 │ Head 3 │ ...
└────────┴────────┴────────┘
  ↓
Concatenate
  ↓
Linear Projection
  ↓
Output
```

Each head has its own Q/K/V projections.

---

# 14. Why Multiple Heads?

Different heads can learn different relationships or representation subspaces.

For example, one head may learn strong relationships related to:

```text
Syntax
```

while another may capture:

```text
Long-range relationships
```

These are conceptual examples; the model does not explicitly label heads with these roles.

---

# 15. Multi-Head Attention Formula

For each head:

```text
headᵢ =
Attention(Qᵢ, Kᵢ, Vᵢ)
```

Then:

```text
MultiHead(Q,K,V)
=
Concat(head₁, head₂, ..., headₕ)Wᴼ
```

Where:

```text
h = number of attention heads
```

---

# 16. Head Dimension

If:

```text
d_model = 768
number of heads = 12
```

then:

```text
d_head = d_model / h

        = 768 / 12

        = 64
```

Each attention head operates in a 64-dimensional projected space in this example.

---

# 17. Why Scale by √dₖ?

Suppose Q and K contain many dimensions.

Their dot product can become large as dimensionality increases.

Large values can cause:

```text
Large scores
   ↓
Softmax becomes very peaked
   ↓
Small gradients
   ↓
Difficult optimization
```

Therefore:

```text
QKᵀ
 ↓
divide by √dₖ
 ↓
softmax
```

---

# 18. Attention Matrix

For a sequence of `n` tokens:

```text
QKᵀ
```

produces an:

```text
n × n
```

matrix.

Example:

```text
3 tokens:

        I   love   Python
I       ✓
love    ✓    ✓
Python  ✓    ✓       ✓
```

For causal attention, future positions are masked.

---

# 19. Attention Complexity

Standard self-attention has approximately:

```text
O(n²)
```

complexity with respect to sequence length `n`.

Why?

Because every token can interact with every other token.

```text
n tokens
 ↓
n × n attention scores
```

Example:

```text
1,000 tokens
→ 1,000 × 1,000 relationships
```

This is a major challenge for very long contexts.

---

# 20. Attention and Context

Attention allows the model to dynamically select useful information from the current context.

```text
Large Context
     ↓
Attention
     ↓
Relevant Information
     ↓
Updated Representation
```

Attention is therefore a key mechanism for contextual understanding.

---

# 21. Attention Is Not the Same as Memory

Attention:

```text
Uses information currently available in context
```

Memory:

```text
Stores/retrieves information outside the immediate context
```

Example:

```text
Attention → Which words in this prompt matter?

Memory → What should the application remember from previous interactions?
```

---

# 22. Attention Is Not RAG

RAG retrieves external information before/around generation.

```text
Question
 ↓
Retriever
 ↓
Documents
 ↓
LLM
```

Attention operates inside the Transformer:

```text
Tokens
 ↓
Attention
 ↓
Contextual representations
```

Therefore:

```text
RAG       = External retrieval mechanism
Attention = Neural network mechanism
```

---

# 23. Attention Example

Sentence:

```text
"The dog chased the ball because it was excited."
```

For:

```text
"it"
```

the model calculates attention relationships with other tokens.

Conceptually:

```text
dog       → high
chased    → medium
ball      → low
excited   → high
```

The weighted information helps create the representation of `"it"`.

The exact learned attention pattern should not be interpreted as a guaranteed explanation of the model's reasoning.

---

# 24. KV Cache

During autoregressive generation, previous keys and values can be cached.

```text
Previous tokens
      ↓
Computed K, V
      ↓
KV Cache
      ↓
New token
      ↓
Attention
```

Without caching:

```text
Repeatedly recompute previous K,V
```

With caching:

```text
Reuse previous K,V
```

Benefits:

```text
Lower repeated computation
Faster token generation
```

Trade-off:

```text
Higher memory usage
```

---

# 25. Attention in Encoder vs Decoder

### Encoder

Typically uses:

```text
Bidirectional Self-Attention
```

Each token can attend to other tokens in the input.

### Decoder

For autoregressive generation:

```text
Causal Self-Attention
```

A token can attend only to earlier/current positions.

Original encoder-decoder Transformer decoder also has:

```text
Cross-Attention
```

---

# 26. Attention Pipeline

```text
Input
 ↓
Embedding
 ↓
Q, K, V
 ↓
QKᵀ
 ↓
Scale
 ↓
Mask (if causal)
 ↓
Softmax
 ↓
Attention Weights
 ↓
Weighted V
 ↓
Attention Output
 ↓
Feed-Forward Network
```

---

# 27. Important Formulas

### Q, K, V

```text
Q = XWQ
K = XWK
V = XWV
```

### Attention

```text
Attention(Q,K,V)
=
softmax(QKᵀ / √dₖ)V
```

### Multi-Head Attention

```text
MultiHead
=
Concat(head₁,...,headₕ)Wᴼ
```

### Head Dimension

```text
d_head = d_model / h
```

### Complexity

```text
O(n²)
```

---

# 28. Quick Comparison

| Concept              | Meaning                                               |
| -------------------- | ----------------------------------------------------- |
| Query                | What information am I looking for?                    |
| Key                  | What information does a token represent for matching? |
| Value                | Information passed from the token                     |
| Self-Attention       | Q/K/V from same sequence                              |
| Cross-Attention      | Q and K/V from different sources                      |
| Causal Attention     | Prevents access to future tokens                      |
| Multi-Head Attention | Multiple attention projections                        |
| Attention Weight     | Importance assigned to a token                        |
| KV Cache             | Stores previous K/V during generation                 |
| `√dₖ`                | Scaling factor                                        |
| `O(n²)`              | Standard self-attention sequence-length complexity    |

---

# 29. Common Interview Questions

### What is attention?

> A mechanism that computes weighted interactions between tokens so each token can incorporate relevant information from other positions.

### Why Q, K and V?

> Queries determine what to look for, keys determine how tokens are matched, and values provide the information that is aggregated.

### Why softmax?

> It converts attention scores into normalized weights.

### Why divide by √dₖ?

> To control the scale of dot products and prevent softmax from becoming excessively peaked.

### Why multi-head attention?

> To learn multiple relationships/subspaces in parallel.

### Why causal masking?

> To prevent a decoder from seeing future tokens during autoregressive prediction.

### Why is attention O(n²)?

> Because standard self-attention computes pairwise interactions between sequence positions.

### What is cross-attention?

> Attention where queries come from one source and keys/values come from another.

### What is KV cache?

> A cache of previous keys and values used to avoid recomputing them during autoregressive generation.

---

# 30. One-Line Revision

> **Attention = Calculate Q-K similarity → scale → softmax into weights → weighted sum of V, allowing each token to use relevant information from other tokens.**

```
```
