# Vocabulary and Token IDs

## 1. What is a Vocabulary?

In NLP, a **vocabulary** is the collection of tokens that a tokenizer knows how to recognize and represent.

Think of it as a dictionary that maps:

```text
Token → Number
```

For example, a very small vocabulary could look like:

```text
Token          Token ID
-----------------------
<UNK>          0
<PAD>          1
I              2
love           3
NLP            4
the            5
cat            6
dog            7
.              8
```

The actual vocabulary of a modern LLM is much larger.

---

# 2. Why does an LLM need a Vocabulary?

A neural network cannot directly process:

```text
"I love NLP"
```

It needs numerical input.

The vocabulary provides a mapping between text units and numbers.

```text
Text
 ↓
Tokenizer
 ↓
Tokens
 ↓
Vocabulary lookup
 ↓
Token IDs
```

For example:

```text
"I love NLP"

     ↓

["I", "love", "NLP"]

     ↓

[2, 3, 4]
```

The numbers `2`, `3`, and `4` are **token IDs**.

---

# 3. What is a Token ID?

A **token ID** is a numerical identifier assigned to a token in the vocabulary.

For example:

```text
Token       Token ID

I              2
love           3
NLP            4
```

Therefore:

```text
"I love NLP"
```

becomes:

```text
[2, 3, 4]
```

These IDs are simply indices.

They do **not** directly represent the meaning of the words.

---

# 4. Token ID is NOT a Meaning

This is one of the most important concepts.

Suppose:

```text
cat → 1532
dog → 7821
```

It would be wrong to think:

> "1532 means cat and 7821 means dog."

The numbers are just identifiers.

There is no inherent mathematical meaning in:

```text
1532
```

or:

```text
7821
```

The model learns useful representations through an **embedding layer**.

So:

```text
Token ID
   ↓
Embedding lookup
   ↓
Vector
```

---

# 5. Vocabulary as a Dictionary

You can think of the vocabulary as a dictionary:

```text
"I"       → 2
"love"    → 3
"AI"      → 4
"cat"     → 5
"dog"     → 6
```

And the reverse mapping can be:

```text
2 → "I"
3 → "love"
4 → "AI"
5 → "cat"
6 → "dog"
```

So a tokenizer generally needs to support two directions:

```text
Token → ID
ID → Token
```

---

# 6. Tokenization vs Vocabulary

These two concepts are related but different.

### Tokenization

Determines how text is split.

```text
"I love NLP"

↓

["I", "love", "NLP"]
```

### Vocabulary

Contains the available tokens and their IDs.

```text
"I"   → 27
"love" → 5432
"NLP" → 8921
```

Therefore:

```text
Tokenization
= How text is divided

Vocabulary
= Which tokens exist and their IDs
```

---

# 7. Complete Process

Let's combine the concepts.

Input:

```text
"I love AI"
```

### Step 1 — Tokenization

```text
["I", "love", "AI"]
```

### Step 2 — Vocabulary lookup

Suppose:

```text
I     → 27
love  → 5432
AI    → 9821
```

### Step 3 — Token IDs

```text
[27, 5432, 9821]
```

### Step 4 — Embedding lookup

The model converts each ID into a vector:

```text
27
 ↓
[0.12, -0.44, 0.81, ...]

5432
 ↓
[0.32, 0.17, -0.61, ...]

9821
 ↓
[-0.14, 0.75, 0.22, ...]
```

Now the neural network can process these vectors.

---

# 8. Vocabulary Size

**Vocabulary size** means the total number of tokens in the vocabulary.

For example:

```text
Vocabulary size = 10,000
```

means the tokenizer has 10,000 token entries.

If:

```text
Vocabulary size = 50,000
```

there are 50,000 possible token IDs.

The IDs would typically range from:

```text
0 → 49,999
```

assuming zero-based indexing.

---

# 9. Why not have an enormous vocabulary?

It might seem like we should simply create a vocabulary containing every possible word.

But that causes problems.

Languages contain:

* Millions of possible word forms
* Names
* Technical terms
* Slang
* New words
* Misspellings
* Words from different languages

A huge vocabulary would make the model's embedding table and output layer much larger.

Therefore, tokenizers use subword approaches.

For example:

```text
"unbelievable"
```

can be represented using smaller pieces instead of requiring one unique token for the entire word.

---

# 10. Vocabulary and Subword Tokens

Modern LLM vocabularies often contain subword tokens.

For example, conceptually:

```text
play
playing
player
played
```

could use reusable pieces such as:

```text
play
ing
er
ed
```

This means the vocabulary doesn't need a separate token for every possible word form.

The tokenizer can combine existing pieces.

```text
playing
 ↓
play + ing
```

The exact tokenization depends on the tokenizer.

---

# 11. Special Tokens

A vocabulary can also contain special tokens.

Common examples include:

```text
<PAD>
<UNK>
<BOS>
<EOS>
```

### `<PAD>`

Padding token.

Used when sequences need to be made the same length.

### `<UNK>`

Unknown token.

Represents text that the tokenizer cannot represent directly.

### `<BOS>`

Beginning of sequence.

Marks the start of a sequence.

### `<EOS>`

End of sequence.

Marks the end of a sequence.

Modern LLMs may use different special tokens depending on their architecture and tokenizer.

---

# 12. Padding Example

Suppose we have:

```text
"I love AI"
```

and:

```text
"I love artificial intelligence"
```

Their lengths are different.

We might represent them as:

```text
["I", "love", "AI", "<PAD>"]

["I", "love", "artificial", "intelligence"]
```

Then:

```text
["I", "love", "AI", "<PAD>"]
```

could become:

```text
[27, 5432, 9821, 1]
```

where:

```text
1 = <PAD>
```

The model can use an attention mask so that padding does not contribute meaningful information.

---

# 13. Token IDs and Embeddings

This is probably the most important distinction in this file.

Consider:

```text
cat → 1532
```

The token ID is:

```text
1532
```

But the embedding could be:

```text
[0.21, -0.45, 0.72, 0.14, ...]
```

So:

```text
Token
 ↓
Token ID
 ↓
Embedding Vector
```

The embedding vector contains the learned numerical representation used by the neural network.

---

# 14. The Embedding Matrix

The embedding layer can be thought of as a large matrix.

Suppose:

```text
Vocabulary size = 10,000
Embedding dimension = 768
```

Then the embedding matrix has approximately:

```text
10,000 × 768
```

values.

Conceptually:

```text
                Embedding dimensions
             1    2    3    4   ... 768
           ┌─────────────────────────────┐
Token 0    │ .12 .45 -.22 .81 ...       │
Token 1    │ .33 .17  .71 .04 ...       │
Token 2    │ .81 -.1  .42 .63 ...       │
Token 3    │ .15 .88 -.32 .21 ...       │
...        │                             │
Token 9999 │ .42 .11  .71 .92 ...       │
           └─────────────────────────────┘
```

Each row corresponds to a token ID.

Therefore:

```text
Token ID
   ↓
Select corresponding row
   ↓
Embedding vector
```

---

# 15. Example of Embedding Lookup

Suppose:

```text
Vocabulary size = 5
Embedding dimension = 4
```

The embedding matrix could conceptually be:

```text
ID  Token     Vector

0   <PAD>     [0.0, 0.0, 0.0, 0.0]
1   cat       [0.2, 0.7, 0.1, 0.4]
2   dog       [0.3, 0.6, 0.2, 0.5]
3   love      [0.8, 0.1, 0.5, 0.2]
4   AI        [0.4, 0.9, 0.3, 0.7]
```

If the input contains:

```text
cat
```

the token ID is:

```text
1
```

The embedding lookup selects row `1`:

```text
[0.2, 0.7, 0.1, 0.4]
```

---

# 16. Important: Embeddings are Learned

The embedding vectors are not manually written.

During training, the model adjusts them using gradient-based optimization.

Initially, the vectors can be essentially random.

During training:

```text
Training
   ↓
Loss calculation
   ↓
Backpropagation
   ↓
Gradient updates
   ↓
Embedding values change
```

Over time, the model learns useful representations.

This is why embeddings can capture relationships between tokens.

---

# 17. Vocabulary and the Output Layer

There is another important connection.

When an autoregressive LLM predicts the next token, it eventually produces a score for **every possible token in the vocabulary**.

Suppose:

```text
Vocabulary size = 50,000
```

The model can produce approximately:

```text
50,000 logits
```

for the next-token prediction.

Conceptually:

```text
Transformer output
       ↓
Output layer
       ↓
50,000 logits
       ↓
Softmax
       ↓
50,000 probabilities
```

For example:

```text
Token       Probability

Paris       0.72
London      0.08
Berlin      0.04
Rome        0.03
...
```

The model then chooses or samples a next token.

---

# 18. Vocabulary Size Affects the Model

Vocabulary size affects several parts of an LLM.

### Embedding matrix

Larger vocabulary:

```text
More token embeddings
```

### Output layer

Larger vocabulary:

```text
More possible next-token scores
```

### Tokenization efficiency

A good tokenizer should represent text efficiently.

Too few tokens:

```text
Longer sequences
```

Too many tokens:

```text
Large vocabulary
```

Therefore, tokenizer design is an important engineering decision.

---

# 19. Token IDs Have No Semantic Order

This is a common misunderstanding.

Suppose:

```text
cat → 100
dog → 101
car → 102
```

It does NOT mean:

```text
dog is closer to cat
```

because:

```text
101 - 100 = 1
```

The numerical distance between token IDs is meaningless.

The semantic relationships are represented in the **embedding vectors**, not the token IDs.

For example:

```text
cat → [0.21, 0.45, -0.12, ...]
dog → [0.22, 0.43, -0.10, ...]
car → [-0.71, 0.12, 0.83, ...]
```

The embedding space can contain meaningful relationships.

---

# 20. Token IDs are Categorical Identifiers

A token ID is essentially a category identifier.

Similar to:

```text
India → 1
USA   → 2
Japan → 3
```

The fact that:

```text
Japan = 3
```

doesn't mean Japan is "larger" than India.

Likewise:

```text
cat = 100
dog = 101
```

doesn't mean dog is mathematically close to cat.

The embedding layer provides the learned representation.

---

# 21. Vocabulary → Embedding → Transformer

This is the important chain:

```text
Text
 ↓
Tokenizer
 ↓
Tokens
 ↓
Vocabulary
 ↓
Token IDs
 ↓
Embedding Matrix
 ↓
Embedding Vectors
 ↓
Transformer
```

For example:

```text
"I love AI"

     ↓

["I", "love", "AI"]

     ↓

[27, 5432, 9821]

     ↓

Embedding lookup

     ↓

[
  vector(I),
  vector(love),
  vector(AI)
]

     ↓

Transformer
```

---

# 22. Vocabulary vs Dictionary

A normal dictionary maps:

```text
word → definition
```

A tokenizer vocabulary maps:

```text
token → ID
```

For example:

```text
Dictionary:

cat → a small domesticated animal
```

while:

```text
Tokenizer vocabulary:

cat → 1532
```

The tokenizer vocabulary doesn't define what "cat" means.

The model learns language patterns through training.

---

# 23. How the Vocabulary is Created

A simplified process looks like:

```text
Large Text Dataset
       ↓
Tokenizer training
       ↓
Find useful token/subword patterns
       ↓
Build vocabulary
       ↓
Assign IDs
```

For a subword tokenizer, frequently useful pieces can become vocabulary entries.

For example:

```text
"ing"
"tion"
"pre"
"un"
"computer"
...
```

The exact vocabulary depends on the tokenizer and training process.

---

# 24. Example: Complete Journey

Let's follow:

```text
"I love programming"
```

### Step 1 — Raw text

```text
"I love programming"
```

### Step 2 — Tokenization

Potentially:

```text
["I", "love", "programming"]
```

### Step 3 — Vocabulary lookup

Suppose:

```text
I            → 27
love         → 5432
programming  → 7128
```

### Step 4 — Token IDs

```text
[27, 5432, 7128]
```

### Step 5 — Embedding lookup

```text
27   → vector₁
5432 → vector₂
7128 → vector₃
```

### Step 6 — Transformer

```text
[vector₁, vector₂, vector₃]
          ↓
      Transformer
```

### Step 7 — Prediction

The model eventually produces probabilities for possible next tokens.

```text
" I love programming ..."

possible next tokens:

"in"       → probability
"because"  → probability
"and"      → probability
"."        → probability
...
```

---

# 25. The Most Important Distinction

Remember this chain:

```text
TEXT
 ↓
TOKEN
 ↓
TOKEN ID
 ↓
EMBEDDING
```

Each one is different.

### Text

Human-readable:

```text
"cat"
```

### Token

A unit recognized by the tokenizer:

```text
"cat"
```

### Token ID

Numerical identifier:

```text
1532
```

### Embedding

Learned vector:

```text
[0.21, -0.45, 0.72, ...]
```

---

# 26. 80/20 Summary

Remember these:

1. **Vocabulary** = collection of tokens known by the tokenizer.

2. **Token ID** = numerical identifier assigned to a token.

3. Token IDs are **not semantic representations**.

4. The model uses an **embedding matrix** to convert token IDs into vectors.

5. The basic pipeline is:

```text
Text
 ↓
Tokens
 ↓
Token IDs
 ↓
Embeddings
 ↓
Transformer
```

6. Vocabulary size affects the embedding matrix and output layer.

7. Modern tokenizers often use subword/byte-level approaches.

8. When predicting the next token, an LLM produces scores for possible tokens in its vocabulary.

---

# 27. Interview Answer

**Question: What is a vocabulary and what are token IDs?**

> A vocabulary is the collection of tokens recognized by a tokenizer. Each token is assigned a unique numerical identifier called a token ID. The token ID itself has no semantic meaning; it is simply an index into structures such as the embedding matrix. During processing, token IDs are mapped to learned embedding vectors, which are then passed to the Transformer. The vocabulary size also determines the number of possible tokens that the model can predict at the output.

---

# 28. Mental Model

Keep this picture in your head:

```text
              HUMAN TEXT
                   │
                   ▼
             "I love AI"
                   │
                   ▼
              TOKENIZER
                   │
                   ▼
          ["I", "love", "AI"]
                   │
                   ▼
             VOCABULARY
                   │
                   ▼
            [27, 5432, 9821]
                   │
                   ▼
          TOKEN ID → EMBEDDING
                   │
                   ▼
       [[...], [...], [...]]
                   │
                   ▼
             TRANSFORMER
```

The next file is:

```text
04-one-hot-encoding.md
```

There we will understand **why we don't simply represent every token using a vector like `[0, 0, 1, 0, 0]`**, and why embeddings are a much better representation for NLP.
