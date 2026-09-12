# Attention Intuition

## 1. What Does Attention Actually Do?

The easiest way to understand attention is:

> **Attention lets a token decide which other tokens are useful for understanding it.**

Consider:

```text
"The cat drank the milk because it was thirsty."
```

What does **"it"** refer to?

Most likely:

```text
it → cat
```

Attention gives the model a mechanism to look at the other words and assign different importance to them.

---

# 2. Think of Attention Like a Search

Suppose the current word is:

```text
"it"
```

The model asks:

> "Which words in this sentence are useful for understanding `it`?"

It looks at:

```text
The   cat   drank   the   milk   because   it   was   thirsty
```

Conceptually, it might produce:

```text
The       → 0.02
cat       → 0.65  ← strong focus
drank     → 0.04
the       → 0.01
milk      → 0.08
because   → 0.03
it        → 0.05
was       → 0.03
thirsty   → 0.09
```

The exact values are learned by the model.

The important idea is:

```text
High weight  → pay more attention
Low weight   → pay less attention
```

---

# 3. Attention Is Context-Dependent

This is one of the most important ideas.

Consider the word:

```text
"bank"
```

### Sentence 1

```text
"I deposited money in the bank."
```

Here, the context suggests:

```text
bank → financial institution
```

### Sentence 2

```text
"We sat on the bank of the river."
```

Here:

```text
bank → side of a river
```

The word is the same, but the surrounding context is different.

Attention helps a model use surrounding tokens to construct a context-dependent representation.

---

# 4. Another Example

Consider:

```text
"The animal didn't cross the road because it was too tired."
```

For:

```text
"it"
```

the model should focus more on:

```text
animal
```

than on:

```text
road
```

Conceptually:

```text
The        0.02
animal     0.60  ← high
didn't     0.03
cross      0.02
the        0.01
road       0.08
because    0.04
it         0.05
was        0.04
too        0.02
tired      0.09
```

Attention is therefore a mechanism for **contextual information retrieval**.

---

# 5. A Useful Mental Model

Think of every token as having access to a table of information.

For the token `"it"`:

```text
                Relevance
The               low
animal            HIGH
didn't            low
cross             low
road              medium
because           low
it                low
was               low
too               low
tired             medium
```

The model then combines information from these tokens according to their weights.

```text
                Attention
                   ↓
The ───────────────┐
animal ────────────┤ HIGH
road ──────────────┤ MEDIUM
tired ─────────────┤ MEDIUM
... ───────────────┘
                   ↓
            Context representation
```

---

# 6. The Three Questions

Modern attention can be understood using three questions:

### Question 1 — What am I looking for?

This is the **Query (Q)**.

### Question 2 — What does each token offer / how do I match it?

This is represented by the **Key (K)**.

### Question 3 — What information should I actually retrieve?

This is the **Value (V)**.

So:

```text
Query → What am I looking for?
Key   → How relevant is this token?
Value → What information does this token provide?
```

We will study these formally in:

`03-query-key-value.md`

---

# 7. Simple Real-Life Analogy

Imagine searching for a restaurant.

You have a requirement:

```text
"I want an inexpensive Italian restaurant."
```

This is your **query**.

Each restaurant has searchable characteristics:

```text
Restaurant A:
Italian, ₹₹, Pizza

Restaurant B:
Indian, ₹, Vegetarian

Restaurant C:
Italian, ₹, Pasta
```

You compare your requirements with the available information.

Restaurant C matches strongly.

This is conceptually similar to attention:

```text
Query
  ↓
Compare with available information
  ↓
Calculate relevance
  ↓
Give higher weight to useful information
  ↓
Use that information
```

---

# 8. Practical Python Example

Let's create a very small attention system.

We will represent four words using toy vectors.

```python
import numpy as np

words = ["cat", "dog", "car", "animal"]

vectors = np.array([
    [1.0, 1.0],  # cat
    [1.0, 0.8],  # dog
    [0.1, 0.0],  # car
    [0.9, 0.9],  # animal
])
```

These vectors are deliberately tiny so that we can understand the calculations.

---

# 9. Create a Query

Suppose the current context needs information related to an **animal**.

```python
query = np.array([0.9, 0.9])
```

Now calculate similarity between the query and every word.

```python
scores = vectors @ query

for word, score in zip(words, scores):
    print(word, score)
```

Conceptually:

```text
cat     → high
dog     → high
car     → very low
animal  → high
```

So the model can distinguish relevant and irrelevant information.

---

# 10. Convert Scores to Weights

Use softmax:

```python
def softmax(x):
    exp_x = np.exp(x - np.max(x))
    return exp_x / exp_x.sum()

weights = softmax(scores)

for word, weight in zip(words, weights):
    print(f"{word}: {weight:.4f}")
```

The weights will add up to approximately:

```text
1.0
```

For example:

```text
cat      → 0.32
dog      → 0.28
car      → 0.08
animal   → 0.32
```

The actual numbers depend on the vectors.

---

# 11. Create the Context Vector

Now combine the vectors using the attention weights.

```python
context = weights @ vectors

print("Context:", context)
```

Mathematically:

$$
C = \sum_i \alpha_i V_i
$$

Where:

- $C$ = context vector
- $\alpha_i$ = attention weight
- $V_i$ = value vector

This is the heart of attention.

---

# 12. Complete Mini Example

```python
import numpy as np


def softmax(x):
    exp_x = np.exp(x - np.max(x))
    return exp_x / exp_x.sum()


words = ["cat", "dog", "car", "animal"]

values = np.array([
    [1.0, 1.0],
    [1.0, 0.8],
    [0.1, 0.0],
    [0.9, 0.9],
])

query = np.array([0.9, 0.9])

# 1. Calculate relevance scores
scores = values @ query

# 2. Convert scores into attention weights
weights = softmax(scores)

# 3. Weighted combination of values
context = weights @ values

print("Words:")
print(words)

print("\nScores:")
print(scores)

print("\nAttention weights:")
print(weights)

print("\nContext vector:")
print(context)
```

Pipeline:

```text
Query
  ↓
Similarity with tokens
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

# 13. Visualizing Attention

We can visualize attention as a matrix.

For example:

```text
              The   cat   drank   milk   it
it            .05  .70    .05    .10   .10
```

The row represents the token currently being processed.

The columns represent tokens it can attend to.

The largest value:

```text
cat → 0.70
```

means that, in this simplified example, `"it"` is strongly connected to `"cat"`.

---

# 14. Attention Is Usually Not Manually Assigned

A beginner might think:

```python
attention["cat"] = 0.7
```

But real neural networks do not use manually assigned values.

Instead:

```text
Training data
     ↓
Neural network
     ↓
Learn parameters
     ↓
Generate Q, K, V
     ↓
Calculate scores
     ↓
Attention weights
```

The attention patterns emerge from learned parameters.

---

# 15. Attention Does Not Mean Human-Like Understanding

Important:

> An attention weight is a mathematical quantity, not proof that the model "understands" a word exactly like a human.

Attention is one mechanism used to process relationships between representations.

Do not interpret every attention value as a perfect explanation of the model's reasoning.

---

# 16. Why Attention Changed NLP

Before attention:

```text
Long sequence
     ↓
Sequential processing
     ↓
Information must travel through many steps
```

With attention:

```text
Token
 ↓
Can directly interact with relevant tokens
 ↓
Contextual representation
```

This made modeling long-range relationships much more practical and eventually enabled the Transformer architecture.

---

# 17. Important Mathematical Intuition

The basic attention operation can be remembered as:

$$
\text{Attention}
=
\text{weighted information retrieval}
$$

More explicitly:

$$
\text{Output}
=
\sum_i
\text{AttentionWeight}_i
\times
\text{Value}_i
$$

And the attention weights come from comparing the query with keys.

The complete mathematical version comes later.

---

# 18. GATE / Interview Points

### Q1. What problem does attention solve?

It helps models handle relationships between tokens, especially **long-range dependencies**, by allowing them to dynamically focus on relevant information.

### Q2. Does attention treat every token equally?

**No.**

Different tokens receive different weights depending on the query and learned representations.

### Q3. Are attention weights fixed?

**No.**

They depend on the input representations and the query.

### Q4. What are the three components of modern attention?

```text
Q → Query
K → Key
V → Value
```

### Q5. What is the output of attention?

A weighted combination of value vectors.

---

# 19. One-Line Memory Trick

> **Attention = Ask → Match → Retrieve**

```text
QUERY
"What am I looking for?"
       ↓
KEY
"Which token matches?"
       ↓
WEIGHT
"How relevant is it?"
       ↓
VALUE
"What information should I take?"
```

---

# 20. Connection to the Next Topic

We now understand the intuition:

```text
Current token
      ↓
Look at other tokens
      ↓
Measure relevance
      ↓
Give weights
      ↓
Combine information
```

But we still need to answer:

> **What exactly are Query, Key, and Value?**

That is the next file:

`03-query-key-value.md`
