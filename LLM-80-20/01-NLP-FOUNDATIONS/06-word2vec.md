# Word2Vec

## 1. What is Word2Vec?

**Word2Vec** is a technique for learning **word embeddings** from text.

It was introduced by researchers at Google and became one of the most influential approaches for learning distributed representations of words.

The main idea is simple:

> **Words that appear in similar contexts should have similar vector representations.**

For example:

```text
"The cat drinks milk."

"The dog drinks milk."
```

Because `cat` and `dog` appear in similar contexts, Word2Vec can learn vectors where:

```text
cat ≈ dog
```

in the embedding space.

---

# 2. Why was Word2Vec important?

Before techniques such as Word2Vec, words were often represented using:

```text
One-hot encoding
```

For example:

```text
cat → [1, 0, 0, 0, ...]
dog → [0, 1, 0, 0, ...]
```

These representations tell us that the words are different, but they don't capture semantic relationships.

Word2Vec instead learns:

```text
cat → [0.21, -0.45, 0.72, ...]
dog → [0.19, -0.42, 0.69, ...]
```

Now the vectors can contain meaningful relationships.

---

# 3. The Core Idea

Word2Vec is based on the **distributional hypothesis**:

> **A word's meaning can be learned from the words that frequently appear around it.**

For example:

```text
The cat drinks milk.
The cat sleeps on the sofa.
The cat likes fish.
```

The word `cat` appears with words such as:

```text
drinks
milk
sleeps
sofa
likes
fish
```

Now consider:

```text
The dog drinks milk.
The dog sleeps on the sofa.
The dog likes fish.
```

`dog` appears in similar contexts.

Therefore, Word2Vec can learn that:

```text
cat ≈ dog
```

---

# 4. Word2Vec is Prediction-Based

A very important point:

> **Word2Vec learns word embeddings by solving a prediction task.**

Instead of directly telling the model:

```text
cat is similar to dog
```

we give it text and ask it to predict words from their contexts.

Through this prediction task, useful word representations emerge.

The basic idea is:

```text
Text
 ↓
Context relationships
 ↓
Prediction task
 ↓
Neural network training
 ↓
Learned word vectors
```

---

# 5. The Two Word2Vec Architectures

Word2Vec has two major approaches:

```text
Word2Vec
│
├── CBOW
│
└── Skip-gram
```

### CBOW

**Continuous Bag of Words**

Predict the target word from surrounding context words.

```text
Context → Target
```

### Skip-gram

Predict surrounding context words from the target word.

```text
Target → Context
```

These are the two concepts you must understand.

---

# 6. CBOW

CBOW stands for:

> **Continuous Bag of Words**

Its goal is:

> **Given surrounding words, predict the missing/target word.**

Suppose the sentence is:

```text
"The cat drinks milk."
```

We choose:

```text
"The cat ____ milk."
```

The model sees:

```text
Context:
cat
milk
```

and tries to predict:

```text
Target:
drinks
```

So:

```text
Context words
     ↓
    CBOW
     ↓
Target word
```

---

# 7. CBOW Example

Consider:

```text
"The cat drinks milk."
```

Suppose our context window is `2`.

For the target:

```text
drinks
```

the surrounding words could be:

```text
The
cat
milk
```

Depending on the exact window definition and preprocessing, the training example can be represented as:

```text
Context:
The
cat
milk

Target:
drinks
```

The model learns to predict:

```text
drinks
```

from its surrounding words.

---

# 8. What Does "Context Window" Mean?

A **context window** determines how many surrounding words are considered.

For example:

```text
"The cat drinks milk every morning."
```

If the target is:

```text
drinks
```

and the window size is `2`, we might consider:

```text
The
cat
milk
every
```

as context.

Conceptually:

```text
The   cat   [drinks]   milk   every
← context →  target  ← context →
```

The exact implementation depends on how the training examples are constructed.

---

# 9. CBOW Architecture

A simplified CBOW network looks like:

```text
Context Words
     │
     ▼
Token IDs
     │
     ▼
Embedding Layer
     │
     ▼
Combine Context Vectors
     │
     ▼
Output Layer
     │
     ▼
Probability Distribution
     │
     ▼
Predicted Word
```

For example:

```text
"The" + "cat" + "milk"
            ↓
          CBOW
            ↓
         "drinks"
```

---

# 10. Why is it called "Bag of Words"?

CBOW aggregates the context words without focusing heavily on their order within the context representation.

For example, conceptually:

```text
"The cat milk"
```

provides the same set of context words as:

```text
"milk cat The"
```

for the basic bag-of-context representation.

This is why it is called a **bag of words**.

The word order in the broader sentence is not represented in the same way that a Transformer explicitly models positional relationships.

---

# 11. Skip-gram

Skip-gram reverses the task.

Instead of:

```text
Context → Target
```

we do:

```text
Target → Context
```

Suppose:

```text
"The cat drinks milk."
```

Target:

```text
cat
```

The model tries to predict surrounding words:

```text
The
drinks
```

and potentially other nearby words depending on the context window.

So:

```text
Target word
     ↓
 Skip-gram
     ↓
Context words
```

---

# 12. Skip-gram Example

Sentence:

```text
"The cat drinks milk."
```

Target:

```text
cat
```

Possible training pairs:

```text
(cat, The)
(cat, drinks)
```

The model learns to predict context words given the target.

With more training examples:

```text
(cat, the)
(cat, drinks)
(cat, milk)
(dog, the)
(dog, drinks)
(dog, milk)
...
```

the model gradually learns useful representations.

---

# 13. CBOW vs Skip-gram

This is an important interview question.

| CBOW                                   | Skip-gram                              |
| -------------------------------------- | -------------------------------------- |
| Context → Target                       | Target → Context                       |
| Predicts a word from surrounding words | Predicts surrounding words from a word |
| Generally faster                       | Generally slower                       |
| Often works well for frequent words    | Can work well for rare words           |
| Uses multiple context words            | Starts with one target word            |

Remember:

```text
CBOW:
Context → Word

Skip-gram:
Word → Context
```

---

# 14. Word2Vec Training Example

Suppose the sentence is:

```text
"The cat drinks milk."
```

We choose a context window.

For Skip-gram, we can generate examples such as:

```text
(cat, The)
(cat, drinks)
(drinks, cat)
(drinks, milk)
```

Each pair becomes a training example.

The model learns to assign high probability to words that actually occur near the target.

---

# 15. The Neural Network

A simplified Word2Vec model can be visualized as:

```text
Input Word
    ↓
One-Hot / Token ID
    ↓
Embedding Layer
    ↓
Hidden Representation
    ↓
Output Layer
    ↓
Probability Distribution
```

Suppose the vocabulary contains:

```text
50,000 words
```

The output layer can conceptually produce:

```text
50,000 scores
```

representing how likely each vocabulary word is to be a context/target word.

---

# 16. Input and Output Representations

A simplified original formulation can be thought of as using one-hot representations.

For example:

```text
cat
 ↓
[0, 0, 1, 0, ...]
```

The network transforms this representation into a dense vector.

That dense vector is the learned embedding.

So:

```text
One-hot input
      ↓
Neural network
      ↓
Dense representation
      ↓
Prediction
```

The hidden-layer weights become the important learned word representations.

---

# 17. Where Does the Embedding Come From?

This is a common question.

Suppose the embedding dimension is:

```text
300
```

Then the model learns a vector like:

```text
cat →
[0.12, -0.43, 0.72, ..., 0.19]
```

The values are learned during training.

Training repeatedly adjusts the model so that words that occur in appropriate contexts receive better predictions.

The learned weights associated with the words become the word embeddings.

---

# 18. Training Objective

At a high level, Word2Vec tries to make:

```text
Real context word
        ↓
High predicted probability
```

and:

```text
Unrelated word
        ↓
Lower predicted probability
```

For example:

```text
Target: cat

Likely context:
dog
milk
animal
pet

Less likely:
database
keyboard
planet
```

After training on a large corpus, the embedding space captures useful relationships.

---

# 19. Why Similar Words Become Similar

Suppose the training data repeatedly contains:

```text
The cat eats food.
The cat sleeps.
The cat plays.

The dog eats food.
The dog sleeps.
The dog plays.
```

The prediction tasks for `cat` and `dog` are similar.

Therefore, their learned vectors can become similar.

Conceptually:

```text
cat → similar context patterns
dog → similar context patterns
```

which leads to:

```text
vector(cat) ≈ vector(dog)
```

---

# 20. Semantic Relationships

Word2Vec can learn relationships beyond simple similarity.

For example:

```text
king
queen
man
woman
```

A famous example is:

```text
king - man + woman ≈ queen
```

Conceptually:

```text
king
 ↓
remove "man" relationship
 ↓
add "woman" relationship
 ↓
queen
```

This demonstrates that some semantic relationships can appear as directions in vector space.

However, this should not be interpreted as a perfect universal arithmetic rule. It is an observed property of some learned embedding spaces.

---

# 21. Cosine Similarity

After learning embeddings, we can compare words using vector similarity.

A common metric is:

```text
Cosine Similarity
```

Formula:

[
\text{similarity}(A,B)
======================

\frac{A \cdot B}
{|A||B|}
]

Conceptually:

```text
cat ↔ dog
      ↓
high similarity

cat ↔ database
      ↓
lower similarity
```

The exact values depend on the trained model.

---

# 22. Negative Sampling

The original Word2Vec formulation can be computationally expensive if we calculate probabilities over an entire large vocabulary for every training example.

**Negative sampling** provides a more efficient training approach.

The idea is:

> Instead of predicting every word in the vocabulary, train the model to distinguish real word-context pairs from randomly selected negative pairs.

For example:

### Positive pair

```text
(cat, milk)
```

because they appear in a relevant context.

### Negative pair

```text
(cat, airplane)
```

if that pair was sampled as a negative example.

The model learns:

```text
Positive pair → score high
Negative pair → score low
```

---

# 23. Why Negative Sampling Helps

Suppose:

```text
Vocabulary = 100,000 words
```

Calculating a full probability distribution for every training example can be expensive.

Negative sampling allows us to work with:

```text
1 positive example
+
a small number of negative examples
```

instead of evaluating all 100,000 vocabulary items every time.

This makes training much more efficient.

---

# 24. Hierarchical Softmax

Another optimization associated with Word2Vec is:

**Hierarchical Softmax**

Instead of calculating a probability for every vocabulary item directly, it organizes vocabulary words into a tree structure.

Conceptually:

```text
              Root
             /    \
            /      \
         group A   group B
         /   \      /   \
       ...   ...  ...   ...
```

Prediction can then be performed through a path in the tree.

You don't need to know the implementation details for your 20/80 goal.

Just remember:

```text
Negative Sampling
and
Hierarchical Softmax
```

are efficiency techniques used in Word2Vec training.

---

# 25. Word2Vec Pipeline

The complete simplified pipeline is:

```text
Large Text Corpus
       ↓
Tokenization
       ↓
Create Context Pairs
       ↓
CBOW / Skip-gram
       ↓
Neural Network Training
       ↓
Update Weights
       ↓
Learned Embeddings
```

For Skip-gram:

```text
Text
 ↓
Target Word
 ↓
Predict Context Words
 ↓
Calculate Loss
 ↓
Update Weights
 ↓
Better Embeddings
```

---

# 26. Word2Vec vs GloVe

You have already learned GloVe, so this comparison is important.

| Word2Vec                                                | GloVe                                              |
| ------------------------------------------------------- | -------------------------------------------------- |
| Prediction-based                                        | Co-occurrence-based                                |
| Uses local context windows                              | Uses global co-occurrence statistics               |
| CBOW and Skip-gram                                      | Matrix/co-occurrence formulation                   |
| Learns embeddings through prediction                    | Learns embeddings from co-occurrence relationships |
| Efficient training techniques include negative sampling | Uses global corpus statistics                      |

Simplified:

```text
Word2Vec
"What word occurs around this word?"

GloVe
"How often do these words occur together globally?"
```

Both can produce useful word embeddings.

---

# 27. Word2Vec vs One-Hot Encoding

### One-hot:

```text
cat →
[0, 0, 1, 0, 0, ...]
```

It tells the model:

> This is token/category 3.

### Word2Vec:

```text
cat →
[0.21, -0.45, 0.72, ...]
```

It learns:

> This word has relationships with other words based on usage.

Therefore:

```text
One-Hot
   ↓
Identity

Word2Vec
   ↓
Learned representation
```

---

# 28. Word2Vec vs Modern LLMs

This distinction is very important.

### Word2Vec

Typically produces one vector per word:

```text
bank → vector
```

The representation doesn't fundamentally change based on the sentence.

### Modern Transformer

Can create context-dependent representations:

```text
I deposited money in the bank.

bank → representation A
```

versus:

```text
We sat near the river bank.

bank → representation B
```

Therefore:

```text
Word2Vec
→ Static embeddings

Transformer
→ Contextual representations
```

---

# 29. Limitations of Word2Vec

Word2Vec was extremely influential, but it has limitations.

### 1. One vector per word

Polysemous words are difficult.

```text
bank
```

has multiple meanings but typically one vector.

---

### 2. No strong sentence-level understanding

Word2Vec focuses on word-level relationships.

---

### 3. Limited handling of unseen words

Classic Word2Vec can struggle with words that were not present in the training vocabulary.

---

### 4. Context is local

Word2Vec uses a local context window.

It doesn't model long-range dependencies in the same way Transformers do.

---

### 5. Static embeddings

The same word generally gets the same vector regardless of context.

---

# 30. Why Word2Vec Still Matters

Even though modern LLMs use Transformers, Word2Vec is worth learning because it teaches several fundamental ideas:

```text
Words
 ↓
Context
 ↓
Prediction
 ↓
Learned vectors
 ↓
Semantic relationships
```

These ideas are foundational for understanding modern representation learning.

It also makes it easier to understand:

* Embeddings
* Semantic similarity
* Vector spaces
* RAG
* Vector databases
* Representation learning

---

# 31. Simple Example from Start to Finish

Consider:

```text
"The cat drinks milk."
```

### Step 1 — Tokenize

```text
["The", "cat", "drinks", "milk"]
```

### Step 2 — Choose target

Suppose:

```text
Target = "drinks"
```

### Step 3 — Select context

```text
Context = ["The", "cat", "milk"]
```

### Step 4 — Train CBOW

```text
["The", "cat", "milk"]
          ↓
        CBOW
          ↓
       "drinks"
```

### Step 5 — Calculate error

The model compares:

```text
Predicted word
```

with:

```text
Actual word = "drinks"
```

### Step 6 — Update weights

Backpropagation updates the network parameters.

### Step 7 — Repeat

This happens across enormous amounts of text.

Eventually, the model learns useful word vectors.

---

# 32. Skip-gram Version of the Same Example

Sentence:

```text
"The cat drinks milk."
```

Choose:

```text
Target = "cat"
```

Possible context words:

```text
"The"
"drinks"
```

Training examples:

```text
(cat, The)
(cat, drinks)
```

The model learns to predict the surrounding words from `cat`.

Repeated across huge amounts of text:

```text
Target word
    ↓
Predict context
    ↓
Update weights
    ↓
Learn embedding
```

---

# 33. The Most Important Mental Model

Remember:

```text
                 WORD2VEC
                    │
          ┌─────────┴─────────┐
          │                   │
        CBOW                Skip-gram
          │                   │
          ▼                   ▼
 Context → Word          Word → Context
          │                   │
          └─────────┬─────────┘
                    ↓
              Neural Network
                    ↓
              Learned Vectors
                    ↓
          Semantic Relationships
```

---

# 34. 80/20 Summary

You should remember these **10 things**:

1. **Word2Vec learns word embeddings from text.**

2. Its basic principle is the **distributional hypothesis**.

3. Words appearing in similar contexts tend to have similar vectors.

4. Word2Vec has two main architectures:

```text
CBOW
Skip-gram
```

5. **CBOW:**

```text
Context → Target Word
```

6. **Skip-gram:**

```text
Target Word → Context Words
```

7. Word2Vec is fundamentally **prediction-based**.

8. **Negative sampling** makes training more efficient.

9. Word2Vec produces mostly **static word embeddings**.

10. Modern Transformers improve on this by producing **contextual representations**.

---

# 35. Interview Answer

**Question: What is Word2Vec?**

> Word2Vec is a neural-network-based technique for learning dense word embeddings from text. It is based on the idea that words occurring in similar contexts tend to have similar representations. Word2Vec provides two architectures: CBOW, which predicts a target word from its surrounding context, and Skip-gram, which predicts surrounding context words from a target word. Techniques such as negative sampling make training more efficient. The resulting embeddings can capture semantic and syntactic relationships between words.

---

# 36. Most Important Comparison

```text
One-Hot
   ↓
"I know which word this is."

Word2Vec
   ↓
"I learned how this word relates to other words."

GloVe
   ↓
"I learned relationships from global co-occurrence statistics."

Transformer
   ↓
"I can represent a token based on its surrounding context."
```

This is the progression you should understand before moving into attention.

---

# 37. Next Topic

The next file in your sequence is:

```text
07-glove.md
```

You already have a basic understanding of GloVe. In that file, we'll go deeper into:

```text
Co-occurrence Matrix
        ↓
Global Statistics
        ↓
Word-Word Relationships
        ↓
GloVe Objective
        ↓
Learned Embeddings
```

and compare **GloVe vs Word2Vec** properly.
