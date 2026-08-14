# One-Hot Encoding

## 1. What is One-Hot Encoding?

**One-hot encoding** is a way of representing categorical values as numerical vectors.

In NLP, it can be used to represent tokens as vectors so that machine-learning models can process them.

The basic idea is:

> **Give every token a unique position in a vector and put `1` at that position and `0` everywhere else.**

For example, suppose our vocabulary is:

```text
cat
dog
car
apple
```

We can assign positions:

```text
cat   → position 0
dog   → position 1
car   → position 2
apple → position 3
```

Then:

```text
cat → [1, 0, 0, 0]
dog → [0, 1, 0, 0]
car → [0, 0, 1, 0]
apple → [0, 0, 0, 1]
```

Only one position contains `1`.

That's why it is called **one-hot**.

---

# 2. Why do we need numerical representation?

A computer cannot directly perform neural-network calculations on:

```text
"cat"
```

We need a numerical representation.

One-hot encoding provides one possible representation:

```text
"cat"
   ↓
[1, 0, 0, 0]
```

The model can now perform mathematical operations on the representation.

---

# 3. Simple Example

Suppose our vocabulary contains five tokens:

```text
Vocabulary:

0 → cat
1 → dog
2 → car
3 → apple
4 → computer
```

The one-hot representations are:

```text
cat      → [1, 0, 0, 0, 0]

dog      → [0, 1, 0, 0, 0]

car      → [0, 0, 1, 0, 0]

apple    → [0, 0, 0, 1, 0]

computer → [0, 0, 0, 0, 1]
```

Notice the vector has exactly **5 dimensions**, because there are 5 vocabulary items.

---

# 4. How One-Hot Encoding is Created

Suppose:

```text
Vocabulary size = 5
```

and:

```text
cat → ID 0
```

Create a vector with 5 positions:

```text
[0, 0, 0, 0, 0]
```

Put `1` at the position corresponding to the token ID:

```text
[1, 0, 0, 0, 0]
```

Therefore:

```text
Token ID → One-hot vector
```

For example:

```text
ID 2

↓

[0, 0, 1, 0, 0]
```

---

# 5. One-Hot Encoding and Token IDs

These are different concepts.

Suppose:

```text
cat → token ID 2
```

The token ID is simply:

```text
2
```

The one-hot representation is:

```text
[0, 0, 1, 0, 0]
```

Therefore:

```text
Token
 ↓
Token ID
 ↓
One-hot vector
```

However, modern LLMs generally don't feed one-hot vectors directly into the Transformer. Instead, token IDs are used to look up learned embeddings.

---

# 6. One-Hot Encoding vs Token ID

### Token ID

```text
cat → 2
```

It is just an index.

### One-hot vector

```text
cat → [0, 0, 1, 0, 0]
```

It represents the token using a vector.

### Embedding

```text
cat → [0.21, -0.45, 0.72, ...]
```

It is a learned dense representation.

So:

```text
Token ID
   ↓
One-Hot Representation
   ↓
Could theoretically be transformed into an embedding
```

But in practical neural-network implementations, we usually use an **embedding lookup** directly from the token ID rather than explicitly constructing a one-hot vector.

---

# 7. The Biggest Problem: High Dimensionality

One-hot encoding works well for small vocabularies.

But imagine an LLM vocabulary has:

```text
50,000 tokens
```

Then every token needs a vector with:

```text
50,000 dimensions
```

For example:

```text
cat →

[0, 0, 0, 0, 0, ...,
 1,
 0, 0, 0, ...]
```

There are 50,000 values.

Only **one value is 1**.

The other:

```text
49,999 values = 0
```

This is extremely inefficient.

---

# 8. Sparse Representation

One-hot vectors are called **sparse vectors** because most values are zero.

For example:

```text
[0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
```

Only one element is non-zero.

For a vocabulary of 50,000:

```text
[0, 0, 0, ..., 1, ..., 0]
```

there is only one `1`.

This means one-hot representations contain very little useful information per dimension.

---

# 9. No Semantic Meaning

This is an even bigger problem.

Suppose:

```text
cat → [1, 0, 0, 0]

dog → [0, 1, 0, 0]

car → [0, 0, 1, 0]
```

The vectors don't tell us that:

```text
cat
```

and:

```text
dog
```

are semantically related.

They are simply different categories.

In fact, the mathematical distance between every pair of different one-hot vectors is identical.

For example:

```text
cat = [1, 0, 0]
dog = [0, 1, 0]
car = [0, 0, 1]
```

The distance between:

```text
cat ↔ dog
```

is the same as:

```text
cat ↔ car
```

There is no concept of:

```text
cat ≈ dog
```

in the one-hot representation.

---

# 10. Why is this a problem for NLP?

Language contains relationships.

For example:

```text
cat ↔ dog
king ↔ queen
Paris ↔ France
car ↔ vehicle
```

We want our numerical representations to capture these relationships.

One-hot encoding cannot naturally represent them.

It only tells us:

```text
cat = category 1
dog = category 2
car = category 3
```

It does not tell us:

```text
cat and dog are both animals.
```

---

# 11. One-Hot Encoding and Similarity

Suppose:

```text
cat = [1, 0, 0, 0]
dog = [0, 1, 0, 0]
```

Their dot product is:

```text
cat · dog

= (1×0) + (0×1) + (0×0) + (0×0)

= 0
```

Similarly:

```text
cat · car = 0
```

Therefore, one-hot vectors don't naturally express semantic similarity.

---

# 12. One-Hot Encoding is Categorical

One-hot encoding is excellent for representing categories.

For example:

```text
Color:

Red
Blue
Green
```

can become:

```text
Red   → [1, 0, 0]
Blue  → [0, 1, 0]
Green → [0, 0, 1]
```

The representation tells us which category is present.

It does not tell us that:

```text
Red
```

is more similar to:

```text
Blue
```

than to:

```text
Green
```

unless some additional representation provides that information.

---

# 13. One-Hot Encoding in NLP

Historically, NLP systems could represent words using one-hot vectors.

For example:

```text
Vocabulary:

cat
dog
fish
car
```

Then:

```text
cat → [1, 0, 0, 0]

dog → [0, 1, 0, 0]

fish → [0, 0, 1, 0]

car → [0, 0, 0, 1]
```

This gives every word a unique representation.

But it doesn't capture relationships between words.

This led to better representations such as:

* Word2Vec
* GloVe
* FastText
* Learned embedding layers

---

# 14. One-Hot Encoding → Embeddings

The important evolution is:

```text
One-Hot Encoding
       ↓
Sparse
       ↓
High-dimensional
       ↓
No semantic relationships
       ↓
Word Embeddings
       ↓
Dense
       ↓
Lower-dimensional
       ↓
Learned semantic relationships
```

For example:

### One-hot

```text
cat →

[0, 0, 0, 1, 0, 0, ...]
```

Maybe 50,000 dimensions.

### Embedding

```text
cat →

[0.21, -0.45, 0.72, 0.14, ...]
```

Maybe 300 dimensions.

The embedding is much more compact and can learn useful relationships.

---

# 15. Dense vs Sparse

This distinction is important.

## Sparse vector

Most values are zero.

Example:

```text
[0, 0, 0, 1, 0, 0, 0]
```

This is a one-hot vector.

---

## Dense vector

Most values are non-zero.

Example:

```text
[0.21, -0.45, 0.72, 0.14, -0.33]
```

This is similar to the type of representation used by embeddings.

---

# 16. One-Hot vs Embedding

| Property             | One-Hot                     | Embedding                 |
| -------------------- | --------------------------- | ------------------------- |
| Representation       | Sparse                      | Dense                     |
| Dimensions           | Vocabulary size             | Usually much smaller      |
| Semantic information | No                          | Can capture it            |
| Values               | Mostly 0/1                  | Learned continuous values |
| Similarity           | Not meaningful              | Can be meaningful         |
| Memory efficiency    | Poor for large vocabularies | Better                    |
| Used in modern LLMs  | Not directly as input       | Yes                       |

---

# 17. How Embeddings Solve the Problem

Suppose we have:

```text
cat
dog
car
```

A learned embedding could look conceptually like:

```text
cat → [0.80, 0.75, 0.10]

dog → [0.78, 0.73, 0.12]

car → [0.10, 0.20, 0.90]
```

Notice:

```text
cat ≈ dog
```

while:

```text
cat ≠ car
```

The model can learn such relationships from data.

The actual dimensions do not literally mean:

```text
dimension 1 = animal
dimension 2 = friendliness
dimension 3 = vehicle
```

The learned representation is distributed across dimensions.

---

# 18. One-Hot and the Embedding Matrix

There is an important mathematical connection.

Suppose the one-hot vector is:

```text
x = [0, 0, 1, 0]
```

and we have an embedding matrix:

```text
E
```

Then:

```text
xE
```

selects the embedding corresponding to that token.

For example:

```text
x = [0, 0, 1, 0]
```

selects the third row of `E`.

Conceptually:

```text
One-hot vector
      ↓
Multiply by embedding matrix
      ↓
Embedding vector
```

This is mathematically equivalent to an embedding lookup.

However, in actual implementations, we normally don't explicitly construct the huge one-hot vector because that would be inefficient.

Instead:

```text
Token ID
   ↓
Embedding lookup
   ↓
Embedding vector
```

---

# 19. Why Token IDs Are Used Directly

Suppose:

```text
Vocabulary = 50,000
Embedding dimension = 768
```

A one-hot vector would contain:

```text
50,000 values
```

But only one is non-zero.

Instead of creating:

```text
[0, 0, 0, ..., 1, ..., 0]
```

we simply say:

```text
Token ID = 12,345
```

and retrieve:

```text
EmbeddingMatrix[12,345]
```

This is much more efficient.

So the practical pipeline is:

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
 ↓
Embedding lookup
 ↓
Dense vectors
```

not:

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
 ↓
Huge one-hot vectors
 ↓
Embedding matrix
```

---

# 20. Important Mathematical Idea

Let:

```text
V = vocabulary size
```

and:

```text
D = embedding dimension
```

Then the embedding matrix has shape:

```text
V × D
```

For example:

```text
V = 50,000
D = 768
```

Embedding matrix:

```text
50,000 × 768
```

A one-hot vector has shape:

```text
1 × 50,000
```

Multiplying:

```text
(1 × 50,000)
        ×
(50,000 × 768)

        ↓

(1 × 768)
```

So the result is a 768-dimensional embedding.

This is why one-hot encoding can be viewed as a conceptual way of selecting a row from an embedding matrix.

---

# 21. One-Hot Encoding and LLMs

Modern LLMs don't normally use explicit one-hot vectors as their input representation.

The practical flow is:

```text
User Text
    ↓
Tokenizer
    ↓
Token IDs
    ↓
Embedding Lookup
    ↓
Token Embeddings
    ↓
Transformer
```

One-hot encoding is still useful for understanding **why embeddings are needed** and how categorical tokens can mathematically map to learned vectors.

---

# 22. One-Hot vs Token ID vs Embedding

This distinction is extremely important.

### Token

```text
"cat"
```

### Token ID

```text
1532
```

### One-hot representation

```text
[0, 0, 0, ..., 1, ..., 0]
```

### Embedding

```text
[0.21, -0.45, 0.72, ...]
```

So:

```text
            TEXT
              ↓
            TOKEN
              ↓
          TOKEN ID
          /       \
         /         \
   One-Hot       Lookup
      ↓             ↓
  Sparse         Embedding
   Vector          Vector
```

In modern LLM implementations, the **lookup path** is what matters.

---

# 23. Example from Start to Finish

Suppose our vocabulary is:

```text
0 → I
1 → love
2 → cats
3 → dogs
4 → cars
```

Input:

```text
"I love cats"
```

### Step 1 — Tokens

```text
["I", "love", "cats"]
```

### Step 2 — Token IDs

```text
[0, 1, 2]
```

### Step 3 — One-hot representation

```text
I     → [1, 0, 0, 0, 0]

love  → [0, 1, 0, 0, 0]

cats  → [0, 0, 1, 0, 0]
```

### Step 4 — Embedding lookup

Each token ID selects a learned vector:

```text
I     → vector₁
love  → vector₂
cats  → vector₃
```

### Step 5 — Transformer

```text
[vector₁, vector₂, vector₃]
             ↓
        Transformer
```

---

# 24. Limitations of One-Hot Encoding

### Problem 1 — High dimensionality

Vocabulary size determines vector size.

```text
50,000 vocabulary
→
50,000-dimensional vector
```

---

### Problem 2 — Sparsity

Only one value is non-zero.

```text
[0, 0, 0, 1, 0, 0, ...]
```

---

### Problem 3 — No semantic similarity

```text
cat ≠ dog
```

and the representation doesn't naturally indicate that they are related.

---

### Problem 4 — Poor scalability

As vocabulary grows:

```text
Vocabulary ↑
      ↓
Vector dimensions ↑
      ↓
Memory/computation ↑
```

---

# 25. Why Embeddings Became Important

One-hot encoding answers:

> **Which token is this?**

Embeddings can additionally learn:

> **What kind of relationships does this token have with other tokens?**

This is a major conceptual transition in NLP.

```text
One-Hot
   ↓
Identity
   ↓
"Which category?"

Embedding
   ↓
Learned representation
   ↓
"What relationships exist?"
```

This leads directly to:

```text
05-word-embeddings.md
```

where we'll study **Word Embeddings**, including how methods such as **Word2Vec and GloVe** represent words as dense vectors.

---

# 26. 80/20 Summary

Remember these points:

1. **One-hot encoding** represents a token using a vector containing one `1` and the rest `0`.

2. The vector dimension equals the vocabulary size.

3. One-hot vectors are **sparse**.

4. One-hot encoding does not naturally represent semantic similarity.

5. Large vocabularies make one-hot vectors inefficient.

6. **Embeddings** provide dense, learned representations.

7. In practice, modern LLMs usually use:

```text
Token ID
   ↓
Embedding Lookup
   ↓
Embedding Vector
```

8. Mathematically, an embedding lookup is closely related to multiplying a one-hot vector by an embedding matrix.

---

# 27. Interview Answer

**Question: Why is one-hot encoding not suitable for modern NLP?**

> One-hot encoding represents each token as a sparse vector whose dimension equals the vocabulary size. Although it uniquely identifies each token, it does not capture semantic relationships between words and becomes inefficient for large vocabularies. Modern NLP therefore uses dense learned representations called embeddings. Instead of explicitly creating one-hot vectors, models typically use token IDs to perform an embedding lookup, which produces a compact vector representation that can capture useful relationships between tokens.

---

# 28. Mental Model

Remember:

```text
                 TOKEN
                   │
                   ▼
                TOKEN ID
                   │
          ┌────────┴────────┐
          │                 │
          ▼                 ▼
      ONE-HOT          EMBEDDING LOOKUP
          │                 │
          ▼                 ▼
   Sparse Vector       Dense Vector
   Huge dimension      Smaller dimension
   No semantics        Learned semantics
```

The next file is:

```text
05-word-embeddings.md
```

There we'll answer the important question:

> **How can a vector actually represent the meaning and relationships of a word?**
