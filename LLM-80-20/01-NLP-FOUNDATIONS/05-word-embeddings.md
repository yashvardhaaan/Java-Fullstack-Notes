# Word Embeddings

## 1. What is a Word Embedding?

A **word embedding** is a numerical vector representation of a word that captures useful information about its meaning and relationships with other words.

Instead of representing:

```text
cat
```

as a simple category:

```text
[0, 0, 1, 0, 0, ...]
```

we represent it as a dense vector:

```text
[0.21, -0.45, 0.72, 0.14, ...]
```

The important idea is:

> **Words with similar meanings or similar usage tend to have similar representations in the embedding space.**

For example, conceptually:

```text
cat → [0.80, 0.75, 0.10, ...]
dog → [0.78, 0.73, 0.12, ...]
car → [0.10, 0.20, 0.90, ...]
```

The vectors for `cat` and `dog` can be closer to each other than either is to `car`.

---

# 2. Why Do We Need Word Embeddings?

We already learned that one-hot encoding has problems.

For example:

```text
cat → [1, 0, 0, 0]
dog → [0, 1, 0, 0]
car → [0, 0, 1, 0]
```

This tells us that the words are different categories.

But it doesn't tell us:

```text
cat and dog → related
cat and car → less related
```

A useful language representation should capture relationships.

Word embeddings solve this by representing words as points in a continuous mathematical space.

---

# 3. The Core Idea

The central idea behind word embeddings is:

> **Words that occur in similar contexts tend to have similar meanings.**

Consider:

```text
The cat is eating food.

The dog is eating food.
```

The words:

```text
cat
dog
```

appear in very similar contexts.

A model can therefore learn that they are related.

Another example:

```text
The car is driving on the road.

The vehicle is driving on the road.
```

The model can learn a relationship between:

```text
car
vehicle
```

This is called **distributional semantics**.

---

# 4. Distributional Hypothesis

A fundamental idea in NLP is:

> **You can learn something about the meaning of a word by looking at the words that occur around it.**

For example:

```text
The cat drinks milk.

The dog drinks milk.

The kitten drinks milk.
```

The words:

```text
cat
dog
kitten
```

occur in similar contexts.

Therefore, their learned representations can become similar.

This idea is the foundation of many word-embedding techniques.

---

# 5. From Words to Vectors

Suppose we have:

```text
cat
dog
king
queen
car
```

We might represent them as vectors:

```text
cat   → [0.80, 0.75, 0.10, 0.20]
dog   → [0.78, 0.73, 0.12, 0.18]
king  → [0.65, 0.30, 0.85, 0.40]
queen → [0.63, 0.32, 0.83, 0.42]
car   → [0.10, 0.20, 0.05, 0.90]
```

These numbers are illustrative.

The actual dimensions don't normally have simple human-readable meanings.

The important thing is that **relationships between vectors can encode relationships between words**.

---

# 6. What Does an Embedding Dimension Mean?

Suppose an embedding has:

```text
300 dimensions
```

A word might be represented as:

```text
[0.12, -0.45, 0.73, ..., 0.21]
```

You should NOT assume:

```text
Dimension 1 = friendliness
Dimension 2 = gender
Dimension 3 = size
```

Instead, information is generally distributed across many dimensions.

The model learns useful representations during training.

---

# 7. Dense Vectors

Word embeddings are usually **dense vectors**.

Example:

```text
[0.21, -0.45, 0.72, 0.14, -0.33]
```

Compare this with a one-hot vector:

```text
[0, 0, 0, 1, 0]
```

### One-hot

```text
Sparse
High-dimensional
Mostly zeros
No learned semantic relationships
```

### Embedding

```text
Dense
Usually lower-dimensional
Learned values
Can capture relationships
```

---

# 8. Embedding Dimension

The number of values in an embedding is its **embedding dimension**.

For example:

```text
Embedding dimension = 100

cat →
[0.21, -0.45, ..., 0.17]
```

contains 100 numbers.

Another model might use:

```text
Embedding dimension = 300
```

or:

```text
Embedding dimension = 768
```

or another size.

Larger dimensions can provide more representational capacity, but they also require more computation and memory.

---

# 9. Vocabulary and Embedding Matrix

Suppose:

```text
Vocabulary size = 10,000
Embedding dimension = 300
```

The model can maintain an embedding matrix:

```text
10,000 × 300
```

Conceptually:

```text
              300 dimensions
        ┌────────────────────────┐
Token 0 │ vector                 │
Token 1 │ vector                 │
Token 2 │ vector                 │
Token 3 │ vector                 │
 ...    │ ...                    │
Token 9999│ vector               │
        └────────────────────────┘
```

Each row corresponds to one token.

Therefore:

```text
Token ID
   ↓
Select row from embedding matrix
   ↓
Embedding vector
```

---

# 10. How Are Embeddings Learned?

This is the most important question.

Embeddings are generally **learned from data**.

Suppose the training data contains:

```text
The cat drinks milk.

The dog drinks milk.

The cat sleeps.

The dog sleeps.
```

The model repeatedly sees relationships between words.

During training:

```text
Text
 ↓
Prediction task
 ↓
Calculate error
 ↓
Backpropagation
 ↓
Update parameters
```

The embedding values are updated along with the other model parameters.

After a large amount of training, useful relationships can emerge.

---

# 11. Context Creates Meaning

Consider the word:

```text
bank
```

It can mean different things.

### Context 1

```text
I deposited money in the bank.
```

### Context 2

```text
We sat on the river bank.
```

Traditional word embeddings such as classic Word2Vec and GloVe generally assign a single vector to a word type.

So the word:

```text
bank
```

has one learned vector.

This is one limitation of traditional static word embeddings.

Modern Transformer models can create **context-dependent representations**, where the representation of `bank` can change depending on the surrounding sentence.

This distinction becomes very important later.

---

# 12. Static vs Contextual Embeddings

## Static Embeddings

Methods such as:

* Word2Vec
* GloVe

typically assign one vector to each word/token.

Conceptually:

```text
bank → [0.21, 0.45, ...]
```

Regardless of the sentence.

---

## Contextual Embeddings

Modern Transformer-based models can produce representations that depend on context.

For example:

```text
"I deposited money at the bank."

bank → vector A
```

while:

```text
"We sat beside the river bank."

bank → vector B
```

The representation can differ because the context differs.

This is one major reason modern Transformer models are more powerful than classic static embeddings.

---

# 13. Similarity Between Embeddings

Once words are represented as vectors, we can calculate how similar they are.

A common method is:

**Cosine similarity**

It measures the angle between two vectors.

Conceptually:

```text
Similarity(cat, dog) → high

Similarity(cat, car) → lower
```

A common formula is:

[
\text{cosine similarity}(A,B)
=============================

\frac{A \cdot B}
{|A||B|}
]

Where:

* `A` = embedding vector of word 1
* `B` = embedding vector of word 2
* `A · B` = dot product
* `||A||` = magnitude of A
* `||B||` = magnitude of B

You don't need to memorize the formula immediately.

Understand the idea:

> **Cosine similarity tells us how similarly two vectors point in the embedding space.**

---

# 14. Example of Cosine Similarity

Suppose:

```text
cat = [0.8, 0.7]

dog = [0.7, 0.6]

car = [0.1, 0.9]
```

The vectors for:

```text
cat
dog
```

point in similar directions.

Therefore:

```text
cosine_similarity(cat, dog)
```

is relatively high.

The direction of:

```text
car
```

is different, so:

```text
cosine_similarity(cat, car)
```

can be lower.

---

# 15. Embedding Space

Imagine a two-dimensional space.

```text
                 animals
                    ↑
                    │
          dog ●     │
             ● cat  │
                    │
                    │
                    │
                    │        ● car
                    │
────────────────────┼──────────────→
```

The actual embedding spaces have many more dimensions, but visualization helps.

Words that have similar usage patterns may appear closer together.

For example:

```text
cat ─ dog ─ puppy
```

could form a cluster.

And:

```text
car ─ truck ─ vehicle
```

could form another.

---

# 16. Semantic Relationships

Embeddings can capture more than simple synonymy.

They can encode relationships such as:

```text
king ↔ queen
man ↔ woman
Paris ↔ France
Tokyo ↔ Japan
```

One famous property associated with some word embeddings is vector arithmetic.

For example:

```text
king - man + woman ≈ queen
```

This does NOT mean that the model explicitly stores a rule:

```text
king = male queen
```

Rather, relationships can emerge geometrically in the learned vector space.

---

# 17. Word Embeddings vs One-Hot Encoding

| Property             | One-Hot                   | Word Embedding            |
| -------------------- | ------------------------- | ------------------------- |
| Representation       | Sparse                    | Dense                     |
| Dimension            | Vocabulary size           | Chosen embedding size     |
| Semantic information | No                        | Can capture it            |
| Values               | 0/1                       | Learned continuous values |
| Similarity           | Not meaningful            | Can be meaningful         |
| Learned from data    | No                        | Yes                       |
| Memory efficiency    | Poor for large vocabulary | Better                    |

---

# 18. How Word2Vec Creates Embeddings

One important family of word embeddings is **Word2Vec**.

The basic idea is:

> Learn word representations by predicting relationships between words and their contexts.

Two major Word2Vec approaches are:

### CBOW

**Continuous Bag of Words**

Predict the target word from surrounding context.

```text
"The cat ___ milk"

Context:
"The cat"

        ↓

Predict:

"drinks"
```

---

### Skip-gram

Predict surrounding context words from a target word.

```text
Target:
"cat"

        ↓

Predict surrounding words:

"the"
"animal"
"sleeps"
...
```

We'll study Word2Vec in the next relevant file.

---

# 19. How GloVe Creates Embeddings

**GloVe = Global Vectors for Word Representation**

GloVe uses **global word co-occurrence statistics**.

It builds a word co-occurrence matrix.

Conceptually:

```text
             cat   dog   milk   car
cat           -     5      8     0
dog           5     -      7     0
milk          8     7      -     0
car           0     0      0     -
```

The model learns vectors that capture information from these co-occurrence patterns.

The key distinction:

```text
Word2Vec
→ prediction-based

GloVe
→ global co-occurrence-based
```

---

# 20. Word Embeddings and Neural Networks

Embeddings provide a useful interface between language and neural networks.

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
 ↓
Embedding Layer
 ↓
Dense Vectors
 ↓
Neural Network
```

For an older NLP model:

```text
Text
 ↓
Tokenization
 ↓
Word Embeddings
 ↓
RNN / LSTM / CNN
 ↓
Prediction
```

For a modern LLM:

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
 ↓
Token Embeddings
 ↓
Transformer
 ↓
Output
```

---

# 21. Word Embeddings vs LLM Embeddings

This distinction is useful.

### Classic Word Embeddings

Examples:

* Word2Vec
* GloVe
* FastText

Usually provide a relatively fixed representation for each word/token.

```text
cat → vector
```

---

### Modern LLM Representations

Transformers create representations influenced by context.

```text
"The cat is sleeping."

cat → contextual representation A
```

while:

```text
"The cat scanned the computer."

cat → contextual representation B
```

The exact representations depend on the model and layer.

---

# 22. Why Word Embeddings Were a Major Breakthrough

Before distributed word representations, words were often represented as discrete categories.

```text
cat → [0,0,1,0,...]
```

Embeddings changed this into:

```text
cat → [0.21, -0.45, 0.72, ...]
```

Now the model can operate in a continuous vector space.

This allows:

* Similarity calculations
* Clustering
* Semantic search
* Classification
* Relationship analysis
* Better neural-network representations

---

# 23. Limitations of Traditional Word Embeddings

Classic embeddings are powerful, but they have limitations.

### 1. One vector per word

```text
bank → one vector
```

But `bank` has multiple meanings.

---

### 2. Limited context awareness

The same vector is used in different sentences.

---

### 3. Out-of-vocabulary problems

Some approaches struggle with completely unseen words.

FastText addresses this partly by using character/subword information.

---

### 4. Bias

Embeddings trained on human-generated text can learn unwanted biases present in the training data.

This is an important issue in real-world NLP systems.

---

# 24. Word Embeddings in Semantic Search

Embeddings are extremely useful for search.

Suppose a user searches:

```text
"How do I reset my password?"
```

A traditional keyword search might focus heavily on exact words.

An embedding-based system can represent the query as a vector:

```text
Query
 ↓
Embedding
 ↓
[0.21, -0.44, ...]
```

Documents can also be converted into vectors.

Then the system can find documents whose vectors are similar to the query.

```text
User Query
    ↓
Embedding
    ↓
Vector Search
    ↓
Similar Documents
```

This becomes extremely important when we study **RAG**.

---

# 25. Embeddings in RAG

RAG systems use embeddings to retrieve relevant information.

The basic pipeline is:

```text
Documents
    ↓
Chunking
    ↓
Embedding Model
    ↓
Vectors
    ↓
Vector Database
```

Then:

```text
User Question
    ↓
Embedding Model
    ↓
Query Vector
    ↓
Similarity Search
    ↓
Relevant Chunks
    ↓
LLM
    ↓
Answer
```

So understanding embeddings now will help you understand RAG later.

---

# 26. Embedding Model vs LLM

An **embedding model** converts text into vectors.

An **LLM** is generally designed for language modeling and generation, although modern models can also expose useful embeddings or be paired with separate embedding models.

For example:

```text
Embedding Model

Text
 ↓
Vector
```

while:

```text
Generative LLM

Text
 ↓
Next-token prediction
 ↓
Generated text
```

Different models can therefore serve different purposes.

---

# 27. The Complete Picture

You should now understand the progression:

```text
WORD
 ↓
Tokenization
 ↓
Token ID
 ↓
Embedding
 ↓
Vector
 ↓
Similarity / Neural Network
```

For modern LLMs:

```text
TEXT
 ↓
TOKENIZATION
 ↓
TOKEN IDs
 ↓
TOKEN EMBEDDINGS
 ↓
POSITION INFORMATION
 ↓
SELF-ATTENTION
 ↓
TRANSFORMER
 ↓
NEXT-TOKEN PREDICTION
```

The transition from:

```text
words → numbers
```

is one of the fundamental ideas in NLP.

---

# 28. 80/20 Summary

Remember these points:

1. **Word embedding = numerical vector representation of a word/token.**

2. Embeddings are generally **dense vectors**.

3. They are learned from data.

4. Words used in similar contexts can obtain similar representations.

5. This is based on the **distributional hypothesis**.

6. **Word2Vec** learns embeddings using prediction-based objectives.

7. **GloVe** learns embeddings using global word co-occurrence statistics.

8. **Cosine similarity** can measure similarity between vectors.

9. Traditional embeddings are generally **static**.

10. Transformer models produce **contextual representations**.

11. Embeddings are extremely important for:

```text
Semantic Search
RAG
Classification
Recommendation
Clustering
NLP models
```

---

# 29. Interview Answer

**Question: What is a word embedding?**

> A word embedding is a dense numerical vector representation of a word or token that is learned from data. Unlike one-hot encoding, embeddings can capture useful semantic and syntactic relationships between words because words appearing in similar contexts tend to have similar representations. Popular traditional embedding methods include Word2Vec and GloVe. Modern Transformer-based models go further by producing contextual representations whose meaning can change depending on surrounding text.

---

# 30. Mental Model

Remember this:

```text
             ONE-HOT
                │
                │
       "Which word is this?"
                │
                ▼
        Sparse representation
                │
                │
                ▼
           EMBEDDINGS
                │
                │
        "What relationships
          does it have?"
                │
                ▼
        Dense representation
                │
                ▼
       Word2Vec / GloVe
                │
                ▼
         Modern Transformers
                │
                ▼
      Contextual Representations
```

---

# 31. Next Topic

The next file is:

```text
06-word2vec.md
```

There we will study **Word2Vec**, including:

```text
Word2Vec
   │
   ├── CBOW
   │
   └── Skip-gram
```

and understand **how a neural network can actually learn word embeddings from surrounding words**.
