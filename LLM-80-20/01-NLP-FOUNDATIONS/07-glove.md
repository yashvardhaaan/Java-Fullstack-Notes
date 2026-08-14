# GloVe

## 1. What is GloVe?

**GloVe** stands for:

> **Global Vectors for Word Representation**

GloVe is a technique for learning **word embeddings** from large collections of text.

It was developed at **Stanford University**.

The main idea is:

> **Words that have similar patterns of co-occurrence with other words should have similar vector representations.**

For example, suppose a corpus contains:

```text
The cat drinks milk.
The dog drinks milk.
The cat eats fish.
The dog eats fish.
```

The words:

```text
cat
dog
```

occur with similar words such as:

```text
drinks
milk
eats
fish
```

GloVe can therefore learn similar vectors for `cat` and `dog`.

---

# 2. Why was GloVe created?

Before word embeddings, words were often represented using sparse representations such as:

```text
cat → [0, 0, 1, 0, ...]
```

This tells us which word it is, but not how the word relates to other words.

GloVe attempts to represent words in a continuous vector space:

```text
cat → [0.21, -0.45, 0.72, ...]
dog → [0.19, -0.42, 0.69, ...]
```

Now we can calculate relationships between the vectors.

---

# 3. The Key Idea Behind GloVe

The most important thing to understand is:

> **GloVe learns word vectors using global word co-occurrence statistics.**

There are two important words here:

### Word

A token or word in the vocabulary.

### Co-occurrence

How often two words appear near each other in a corpus.

For example:

```text
"The cat drinks milk."
```

Here:

```text
cat
```

co-occurs with:

```text
the
drinks
milk
```

If this pattern happens repeatedly throughout a large corpus, GloVe uses that information.

---

# 4. What is a Corpus?

A **corpus** is a large collection of text.

For example:

```text
Books
+
Articles
+
Web pages
+
Documents
+
Other text
=
Corpus
```

GloVe analyzes this corpus to understand how words occur together.

Conceptually:

```text
Large Corpus
     ↓
Count word co-occurrences
     ↓
Build statistics
     ↓
Learn word vectors
```

---

# 5. What is Co-occurrence?

**Co-occurrence** means that two words appear near each other within some context window.

Suppose:

```text
"The cat drinks milk."
```

If our context window is 2, then when considering:

```text
cat
```

we might consider nearby words such as:

```text
the
drinks
```

The model counts these relationships across the entire corpus.

---

# 6. Simple Co-occurrence Example

Suppose our corpus contains:

```text
The cat drinks milk.
The cat eats fish.
The dog drinks milk.
The dog eats fish.
```

We can observe relationships such as:

```text
cat  ↔ drinks
cat  ↔ milk
cat  ↔ eats
cat  ↔ fish

dog  ↔ drinks
dog  ↔ milk
dog  ↔ eats
dog  ↔ fish
```

Because `cat` and `dog` have similar co-occurrence patterns, their embeddings can become similar.

---

# 7. Co-occurrence Matrix

One of the central concepts in GloVe is the **word-word co-occurrence matrix**.

Suppose our vocabulary is:

```text
cat
dog
milk
fish
car
```

We can create a matrix that records how often words occur near each other.

A simplified example:

```text
          cat   dog   milk  fish  car
cat        0     5      8     6    0
dog        5     0      7     5    0
milk       8     7      0     2    0
fish       6     5      2     0    0
car        0     0      0     0    0
```

The numbers are illustrative.

For example:

```text
X(cat, milk) = 8
```

could mean:

> `cat` and `milk` occurred together 8 times within the chosen context definition.

---

# 8. What Does the Matrix Tell Us?

The matrix captures relationships between words.

For example:

```text
cat → [0, 5, 8, 6, 0]
dog → [5, 0, 7, 5, 0]
```

These rows are similar.

Therefore:

```text
cat ≈ dog
```

in the learned representation.

But:

```text
car → [0, 0, 0, 0, ...]
```

has a very different pattern.

So:

```text
cat ↔ dog
```

may have a stronger relationship than:

```text
cat ↔ car
```

---

# 9. Why is Global Information Important?

This is the major idea behind the name **GloVe**.

Word2Vec learns primarily through local prediction tasks.

GloVe explicitly uses statistics collected across the entire corpus.

Think of it like this:

### Word2Vec

```text
Look at a word
      ↓
Look at nearby context
      ↓
Predict
      ↓
Update vectors
```

### GloVe

```text
Entire corpus
      ↓
Collect co-occurrence statistics
      ↓
Build global matrix
      ↓
Learn vectors
```

This distinction is important.

---

# 10. The GloVe Pipeline

A simplified GloVe pipeline is:

```text
Large Text Corpus
       ↓
Choose Vocabulary
       ↓
Choose Context Window
       ↓
Count Co-occurrences
       ↓
Build Co-occurrence Matrix
       ↓
Learn Word Vectors
       ↓
Word Embeddings
```

---

# 11. Context Window

GloVe needs to define what counts as a neighboring word.

Suppose:

```text
"The cat drinks milk every morning."
```

If the context window is 2, then for:

```text
drinks
```

nearby words could include:

```text
cat
milk
every
```

depending on the exact indexing/window convention.

The window determines which word pairs contribute to the co-occurrence statistics.

---

# 12. Co-occurrence Counts

Suppose the corpus contains:

```text
cat milk
cat milk
cat fish
dog milk
dog fish
```

We might get:

```text
cat ↔ milk = 2
cat ↔ fish = 1

dog ↔ milk = 1
dog ↔ fish = 1
```

These counts become part of the co-occurrence matrix.

The actual GloVe implementation uses weighted context information, but the basic intuition is simply:

> **Count how frequently words occur together.**

---

# 13. Why Raw Frequency Isn't Enough

Suppose a word appears frequently with another word.

That tells us something.

But simply looking at raw counts isn't always enough to understand the meaning of a relationship.

Consider:

```text
ice
steam
```

Both can occur with:

```text
water
```

But their relationships with other words can distinguish their meanings.

GloVe uses the **patterns of co-occurrence** to learn meaningful representations.

---

# 14. The Important Idea of Ratios

One of the interesting ideas in GloVe is that **ratios of co-occurrence probabilities can reveal relationships**.

Suppose we consider:

```text
ice
steam
```

and compare their relationships with:

```text
solid
gas
water
```

Conceptually, the ratio:

```text
P(solid | ice)
----------------
P(solid | steam)
```

may be very different from:

```text
P(water | ice)
----------------
P(water | steam)
```

These differences help distinguish semantic relationships.

You don't need to calculate these manually for your 20/80 goal.

The important idea is:

> **GloVe learns meaning from how co-occurrence relationships differ between words.**

---

# 15. GloVe Objective

GloVe tries to learn vectors such that their relationships reflect the observed co-occurrence statistics.

Let:

```text
X_ij
```

represent the number of times word `j` occurs in the context of word `i`.

GloVe learns:

```text
w_i
```

for the word and:

```text
w_j
```

for the context.

It also learns bias terms.

The simplified objective is:

[
w_i^T \tilde{w}_j + b_i + \tilde{b}*j
\approx
\log(X*{ij})
]

Where:

* (w_i) = word vector
* (\tilde{w}_j) = context vector
* (b_i) = word bias
* (\tilde{b}_j) = context bias
* (X_{ij}) = co-occurrence count

The important idea is:

> **The model tries to make vector relationships correspond to the logarithm of co-occurrence counts.**

---

# 16. Why Logarithm?

Co-occurrence counts can become very large.

For example:

```text
10
100
1,000
10,000
1,000,000
```

Using the logarithm compresses this range.

For example:

```text
log(10)
log(100)
log(1000)
```

grow much more slowly than the raw counts.

GloVe therefore models:

```text
log(co-occurrence count)
```

rather than directly trying to reproduce enormous raw counts.

---

# 17. GloVe Loss Function

GloVe minimizes a weighted loss.

A simplified form is:

[
J =
\sum_{i,j}
f(X_{ij})
\left(
w_i^T\tilde{w}_j
+
b_i
+
\tilde{b}_j
-----------

\log X_{ij}
\right)^2
]

You don't need to memorize this formula.

Understand the structure:

```text
Predicted relationship
        ↓
Compare with
        ↓
Observed co-occurrence relationship
        ↓
Calculate error
        ↓
Update vectors
```

---

# 18. Why is There a Weighting Function?

Not all co-occurrence counts should have equal influence.

Very rare pairs can be noisy.

Extremely frequent pairs can dominate training.

GloVe therefore uses a weighting function:

```text
f(X_ij)
```

to control how much each co-occurrence contributes to the loss.

The goal is to prevent very frequent or extremely rare relationships from overwhelming the training process.

For the 20/80 rule, remember:

> **GloVe uses a weighting function so that different co-occurrence counts contribute appropriately to training.**

---

# 19. Word Vectors and Context Vectors

During GloVe training, there are typically two sets of vectors:

```text
Word vectors
Context vectors
```

Conceptually:

```text
Word:
cat → w_cat

Context:
milk → w̃_milk
```

GloVe learns both.

After training, these representations can be combined to obtain the final word embeddings.

A common approach is:

```text
Final embedding
=
word vector
+
context vector
```

The exact implementation can vary.

---

# 20. How Does GloVe Learn Similar Words?

Suppose:

```text
cat
dog
```

have similar co-occurrence patterns.

Their vectors need to satisfy similar relationships with other context words.

Therefore:

```text
cat vector
      ↓
similar relationships

dog vector
      ↓
similar relationships
```

which can result in:

```text
vector(cat) ≈ vector(dog)
```

---

# 21. Semantic Relationships

GloVe can learn relationships such as:

```text
king
queen
man
woman
```

and:

```text
Paris
France
Tokyo
Japan
```

Because these relationships appear in the co-occurrence structure of language.

This can lead to vector relationships such as:

[
king - man + woman \approx queen
]

Again, this is an observed property of some trained embedding spaces rather than a guaranteed mathematical rule.

---

# 22. GloVe Example

Suppose our corpus contains:

```text
The king rules the kingdom.
The queen rules the kingdom.
The king is a man.
The queen is a woman.
```

The co-occurrence patterns contain relationships involving:

```text
king
queen
man
woman
rules
kingdom
```

GloVe tries to represent these relationships in a vector space.

After training, the vectors can contain meaningful directions.

Conceptually:

```text
king → male + royal
queen → female + royal
man → male
woman → female
```

These are not literal labels stored in individual vector dimensions.

They emerge from relationships in the vector space.

---

# 23. GloVe vs Word2Vec

This is one of the most important comparisons.

| Word2Vec                               | GloVe                                       |
| -------------------------------------- | ------------------------------------------- |
| Prediction-based                       | Co-occurrence-based                         |
| Uses local context during training     | Uses global co-occurrence statistics        |
| CBOW                                   | Matrix/statistical objective                |
| Skip-gram                              | Global word-context information             |
| Can use negative sampling              | Uses weighted co-occurrence loss            |
| Learns word vectors through prediction | Learns vectors from co-occurrence structure |

Simplified:

```text
Word2Vec:
"What word should appear here?"

GloVe:
"How are these words related across the corpus?"
```

---

# 24. Word2Vec and GloVe Have Something in Common

Despite their differences, both are based on a similar fundamental idea:

> **Words used in similar contexts should have similar representations.**

Both produce:

```text
Word
 ↓
Dense Vector
```

Both can support:

```text
Similarity
Classification
Clustering
Semantic Search
```

---

# 25. GloVe vs One-Hot Encoding

### One-hot

```text
cat →
[0, 0, 1, 0, 0]
```

Only identifies the word.

### GloVe

```text
cat →
[0.21, -0.45, 0.72, ...]
```

Encodes learned relationships.

Therefore:

```text
One-hot
    ↓
Identity

GloVe
    ↓
Learned semantic representation
```

---

# 26. GloVe vs Modern LLM Embeddings

GloVe produces **static embeddings**.

For example:

```text
bank → one vector
```

The vector does not fundamentally change depending on the sentence.

Modern Transformer models can create contextual representations.

For example:

```text
"I deposited money in the bank."

bank → representation A
```

and:

```text
"We sat beside the river bank."

bank → representation B
```

Therefore:

```text
GloVe
→ Static word representation

Transformer
→ Context-dependent representation
```

---

# 27. Why GloVe Was Important

GloVe demonstrated how powerful global corpus statistics could be for learning word representations.

It provided:

* Dense word vectors
* Semantic relationships
* Syntactic relationships
* Efficient representations
* Useful pretrained embeddings

GloVe embeddings became widely used in NLP systems before Transformer-based representations became dominant.

---

# 28. Limitations of GloVe

### 1. Static representation

A word generally has one vector.

```text
bank → one vector
```

This is problematic for words with multiple meanings.

---

### 2. Context limitations

It doesn't dynamically change representation based on sentence context.

---

### 3. Vocabulary limitations

A word not represented in the learned vocabulary can be difficult to handle.

---

### 4. No deep sentence-level understanding

GloVe represents word relationships but isn't a generative language model.

---

### 5. No next-token generation

GloVe doesn't work like GPT.

It gives embeddings.

It doesn't generate paragraphs.

---

# 29. GloVe is NOT an LLM

This distinction is extremely important.

GloVe:

```text
Text Corpus
 ↓
Co-occurrence Statistics
 ↓
Word Vectors
```

GPT/LLM:

```text
Text
 ↓
Tokens
 ↓
Transformer
 ↓
Next-token Prediction
 ↓
Generated Text
```

GloVe is an **embedding method**.

GPT is a **generative language model architecture/model family**.

---

# 30. GloVe and RAG

GloVe is historically important, but modern RAG systems usually use specialized modern embedding models rather than classic GloVe vectors.

The RAG idea is:

```text
Documents
 ↓
Embedding Model
 ↓
Vectors
 ↓
Vector Database
```

Then:

```text
Question
 ↓
Embedding Model
 ↓
Query Vector
 ↓
Similarity Search
 ↓
Relevant Documents
 ↓
LLM
```

GloVe helps you understand the general concept of turning language into vectors, even though modern production RAG systems typically use more advanced embedding models.

---

# 31. Complete GloVe Pipeline

Remember this:

```text
              LARGE CORPUS
                   │
                   ▼
             TOKENIZATION
                   │
                   ▼
          CONTEXT WINDOW
                   │
                   ▼
       CO-OCCURRENCE COUNTING
                   │
                   ▼
       CO-OCCURRENCE MATRIX
                   │
                   ▼
        GLOVE TRAINING OBJECTIVE
                   │
                   ▼
             OPTIMIZATION
                   │
                   ▼
            WORD VECTORS
                   │
                   ▼
          SEMANTIC RELATIONSHIPS
```

---

# 32. GloVe Mathematical Intuition

Don't get stuck on the equations.

The entire idea can be reduced to:

```text
Observed:
How often do words occur together?

        ↓

Learn:
Which vectors reproduce those relationships?

        ↓

Result:
Vectors that encode word relationships
```

More formally:

```text
Co-occurrence count
        ↓
log(co-occurrence)
        ↓
Target relationship
        ↓
Vector dot product + biases
        ↓
Minimize error
        ↓
Better embeddings
```

---

# 33. 80/20 Summary

Remember these **10 points**:

1. **GloVe = Global Vectors for Word Representation.**

2. GloVe is a **word embedding technique**, not an LLM.

3. It learns embeddings using **global word co-occurrence statistics**.

4. A **co-occurrence matrix** records how frequently words occur near each other.

5. GloVe tries to make relationships between vectors reflect co-occurrence statistics.

6. It uses the logarithm of co-occurrence counts in its objective.

7. It uses a weighting function to control the contribution of different co-occurrences.

8. GloVe can capture semantic and syntactic relationships.

9. GloVe produces mostly **static word embeddings**.

10. Modern Transformers provide **contextual representations**, which overcome an important limitation of classic embeddings.

---

# 34. Interview Answer

**Question: What is GloVe?**

> GloVe, or Global Vectors for Word Representation, is a word-embedding technique that learns dense vector representations from global word co-occurrence statistics in a corpus. It first builds a word-word co-occurrence matrix and then learns word and context vectors such that their relationships approximate the logarithm of observed co-occurrence counts. Unlike one-hot encoding, GloVe vectors can capture semantic and syntactic relationships between words. However, GloVe produces static embeddings, so the representation of a word does not dynamically change based on its sentence context like modern Transformer-based representations.

---

# 35. Word2Vec vs GloVe — Final Mental Model

```text
                  WORD EMBEDDINGS
                        │
              ┌─────────┴─────────┐
              │                   │
           Word2Vec             GloVe
              │                   │
              ▼                   ▼
        Prediction            Co-occurrence
          based                  based
              │                   │
       ┌──────┴──────┐            │
       │             │            │
      CBOW        Skip-gram       │
       │             │            │
       └──────┬──────┘            │
              │                   │
              └─────────┬─────────┘
                        ▼
                 Dense Vectors
                        │
                        ▼
               Word Relationships
```

And the bigger evolution is:

```text
One-Hot
   ↓
Word2Vec / GloVe
   ↓
Contextual Embeddings
   ↓
Transformers
   ↓
LLMs
```

---

# 36. Next Topic

The next file is:

```text
08-context-and-word-meaning.md
```

This is the **last file in your NLP Foundations folder**.

It will answer a very important question:

> **Why isn't knowing the meaning of individual words enough, and why does an LLM need to understand the context in which a word appears?**

That concept will directly prepare you for the next folder:

```text
02-ATTENTION/
```

where we start learning **Attention and Self-Attention**.
