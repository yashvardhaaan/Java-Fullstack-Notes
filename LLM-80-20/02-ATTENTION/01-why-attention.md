# Why Attention?

## 1. The Problem Before Attention

Before Transformers, NLP commonly used sequence models such as:

- RNN
- LSTM
- GRU

These models processed a sentence **sequentially**, one token at a time.

Example:

```text
"The cat sat on the mat because it was tired."
```

To understand what **"it"** refers to, the model may need information from an earlier token:

```text
The cat ----------------------> it
```

The farther apart the relevant words are, the harder it can become for a sequential model to preserve the required information.

---

# 2. RNN's Basic Idea

An RNN maintains a hidden state.

```text
x1 → RNN → h1
          ↓
x2 → RNN → h2
          ↓
x3 → RNN → h3
          ↓
...
```

Mathematically:

$$
h_t = f(x_t, h_{t-1})
$$

Where:

- $x_t$ = current input
- $h_{t-1}$ = previous hidden state
- $h_t$ = current hidden state

The important limitation is:

> Information from earlier tokens must pass through many sequential steps to influence a later token.

---

# 3. Long-Range Dependency Problem

Consider:

```text
"The students who studied very hard for the examination throughout the entire semester passed it."
```

Suppose the model is trying to understand:

```text
"it"
```

The relevant information may be far away.

A sequential model has to carry information through many intermediate states.

```text
student
   ↓
who
   ↓
studied
   ↓
very
   ↓
hard
   ↓
...
   ↓
it
```

This creates a **long-range dependency** problem.

---

# 4. Information Bottleneck

A simple way to visualize an encoder-decoder RNN is:

```text
Input sentence
     ↓
RNN
     ↓
Final hidden state
     ↓
Decoder
     ↓
Output sentence
```

The entire input may be compressed into a limited hidden representation.

For long sequences, this can become an information bottleneck.

### Key idea

Instead of forcing the decoder to depend only on one final representation:

> Let the decoder look at the relevant parts of the input directly.

This idea leads to **Attention**.

---

# 5. Attention: The Core Idea

Attention allows a model to assign different importance to different tokens.

Example:

```text
"The cat sat on the mat because it was tired."
```

When processing:

```text
"it"
```

the model might assign importance approximately like:

```text
The       0.02
cat       0.70  ← important
sat       0.03
on        0.01
the       0.02
mat       0.05
because   0.03
it        0.04
was       0.03
tired     0.07
```

The exact values are learned by the model.

The important concept is:

```text
Current token
     ↓
Look at other tokens
     ↓
Assign importance
     ↓
Combine useful information
```

---

# 6. Without Attention vs With Attention

## Without Attention

```text
Input
 ↓
RNN
 ↓
One final representation
 ↓
Decoder
 ↓
Output
```

Potential problem:

```text
Long input
    ↓
Information compression
    ↓
Important information may be difficult to preserve
```

## With Attention

```text
Input tokens
 ↓
Representations
 ↓
Attention
 ↓
Select/reweight useful information
 ↓
Output
```

The model can dynamically focus on different parts of the sequence.

---

# 7. Practical Example

Let's build a tiny attention mechanism ourselves.

We will start with a simplified example where the words are represented by vectors.

```python
import numpy as np

words = ["I", "love", "machine", "learning"]

vectors = np.array([
    [1.0, 0.0],  # I
    [0.0, 1.0],  # love
    [1.0, 1.0],  # machine
    [0.8, 0.9],  # learning
])

print(vectors)
```

Output:

```text
[[1.  0. ]
 [0.  1. ]
 [1.  1. ]
 [0.8 0.9]]
```

These vectors are only toy representations.

Real models learn much larger embeddings.

---

# 8. A Simple Similarity Score

Suppose our current query is:

```python
query = np.array([0.9, 1.0])
```

We can compare the query with every word using a dot product.

```python
scores = vectors @ query

print(scores)
```

Conceptually:

```text
I          → lower similarity
love       → medium similarity
machine    → high similarity
learning   → high similarity
```

The score tells us:

> How relevant is each token to the current query?

This is the basic idea behind attention scoring.

---

# 9. Convert Scores into Weights

Raw scores are not convenient as probabilities.

We can use **softmax**.

```python
def softmax(x):
    exp_x = np.exp(x - np.max(x))
    return exp_x / exp_x.sum()

weights = softmax(scores)

print(weights)
print(weights.sum())
```

The weights will:

- be positive
- sum to 1

Example:

```text
I          → 0.05
love       → 0.10
machine    → 0.40
learning   → 0.45

Total      → 1.00
```

The exact numbers depend on the vectors.

---

# 10. Create the Attention Output

Now calculate a weighted combination of the word vectors.

```python
context = weights @ vectors

print(context)
```

Mathematically:

$$
\text{Context} =
\sum_i \alpha_i V_i
$$

Where:

- $V_i$ = value/vector of token $i$
- $\alpha_i$ = attention weight

So instead of treating every token equally:

```text
Token 1 → equal importance
Token 2 → equal importance
Token 3 → equal importance
...
```

we get:

```text
Token 1 → low importance
Token 2 → medium importance
Token 3 → high importance
Token 4 → high importance
```

---

# 11. Complete Mini Attention Example

Here is the complete toy implementation:

```python
import numpy as np


def softmax(x):
    exp_x = np.exp(x - np.max(x))
    return exp_x / exp_x.sum()


words = ["I", "love", "machine", "learning"]

values = np.array([
    [1.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0],
    [0.8, 0.9],
])

query = np.array([0.9, 1.0])

# Step 1: Calculate relevance scores
scores = values @ query

# Step 2: Convert scores into attention weights
weights = softmax(scores)

# Step 3: Weighted sum
context = weights @ values

print("Words:", words)
print("Scores:", scores)
print("Attention weights:", weights)
print("Context vector:", context)
```

The pipeline is:

```text
Query
  ↓
Compare with tokens
  ↓
Scores
  ↓
Softmax
  ↓
Attention weights
  ↓
Weighted sum
  ↓
Context vector
```

---

# 12. Why This Is Powerful

Attention solves an important conceptual problem:

### Old approach

```text
"I need to remember everything in one hidden state."
```

### Attention approach

```text
"I can look at the relevant information when I need it."
```

This makes it much easier for neural networks to model relationships between distant tokens.

---

# 13. Attention Is Not Just "Finding Important Words"

A common misconception is:

> Attention simply finds important words.

More accurately:

> Attention computes a weighted interaction between a query and a set of key/value representations.

The weights depend on the current query.

Therefore, **the same token can receive different attention weights depending on what the model is currently trying to represent.**

---

# 14. Connection to Query, Key, Value

The modern attention mechanism uses three concepts:

```text
Query (Q)
Key   (K)
Value (V)
```

A simplified view:

```text
             Keys
              ↓
Query → Similarity scores
              ↓
           Softmax
              ↓
        Attention weights
              ↓
           Values
              ↓
          Output
```

This is the foundation for the next files:

```text
01-why-attention.md
        ↓
02-attention-intuition.md
        ↓
03-query-key-value.md
        ↓
04-attention-score.md
        ↓
05-scaled-dot-product-attention.md
        ↓
06-softmax-in-attention.md
        ↓
07-self-attention.md
```

---

# 15. Why Transformers Need Attention

Transformers remove the need for recurrence as the primary way of processing token relationships.

Instead of:

```text
Token 1 → Token 2 → Token 3 → Token 4
```

attention allows relationships such as:

```text
Token 1 ──────────────→ Token 4
Token 2 ─────→ Token 4
Token 3 ─────────→ Token 4
```

This enables much more direct modeling of relationships between tokens.

---

# 16. Exam / Interview Points

### Remember these:

1. **RNNs process sequences sequentially.**
2. Long sequences can create **long-range dependency** problems.
3. Attention allows a model to focus on different parts of the input.
4. Attention produces **weights** representing the relevance of tokens for a query.
5. Attention output is a **weighted combination of value vectors**.
6. Modern attention is based on **Query, Key, and Value**.
7. Softmax converts attention scores into normalized weights.
8. Attention is a fundamental component of **Transformers**.

---

# 17. One-Line Memory Trick

> **Attention = "Look where it matters."**

```text
Query
  ↓
Which information do I need?
  ↓
Score every token
  ↓
Give useful tokens more weight
  ↓
Combine their information
```

---

# 18. Next Step

After understanding **why attention is needed**, the next question is:

> **How does attention actually decide what to focus on?**

That is the purpose of:

`02-attention-intuition.md`
