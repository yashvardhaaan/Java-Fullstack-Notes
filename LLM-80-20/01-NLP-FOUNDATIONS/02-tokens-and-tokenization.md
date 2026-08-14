# Tokens and Tokenization

## 1. What is a Token?

A **token** is a unit of text that a language model processes.

A token can be:

* A complete word
* Part of a word
* A character
* Punctuation
* A number
* A special symbol

For example, the sentence:

```text
I love NLP.
```

might be tokenized as:

```text
["I", "love", "NLP", "."]
```

But modern LLMs usually use **subword tokenization**, so the exact result depends on the tokenizer.

---

# 2. Why do we need Tokens?

Neural networks cannot directly process text such as:

```text
"I love NLP"
```

They work with numerical values.

Therefore, we need a pipeline:

```text
Human Text
    ↓
Tokenization
    ↓
Tokens
    ↓
Token IDs
    ↓
Embeddings
    ↓
Neural Network
```

For example:

```text
"I love NLP"

     ↓

["I", "love", "NLP"]

     ↓

[27, 5432, 8921]

     ↓

Vectors

     ↓

Transformer
```

Tokenization is therefore one of the first important steps in an LLM.

---

# 3. Tokenization

**Tokenization** is the process of dividing text into smaller units called **tokens**.

Example:

```text
"I love programming"
```

could become:

```text
["I", "love", "programming"]
```

However, modern LLMs usually don't simply split text by spaces.

For example:

```text
"unhappiness"
```

could potentially be split into:

```text
["un", "happiness"]
```

or:

```text
["un", "happi", "ness"]
```

The exact result depends on the tokenizer.

---

# 4. Why not simply use words?

At first, it seems natural to create one token for every word.

For example:

```text
I
love
cat
dog
computer
programming
...
```

But this creates a major problem.

Human languages contain an enormous number of possible words.

There are:

* Different forms of words
* Names
* Technical terms
* Misspellings
* New words
* Slang
* Foreign words
* Compound words

A vocabulary containing every possible word would become extremely large.

---

# 5. The Unknown Word Problem

Suppose a vocabulary contains:

```text
cat
dog
computer
program
```

Now the model encounters:

```text
"ChatGPT"
```

If `"ChatGPT"` isn't in the vocabulary, what should the model do?

A traditional word-level tokenizer might use:

```text
<UNK>
```

where `<UNK>` means **unknown token**.

This loses information.

Subword tokenization solves much of this problem.

---

# 6. Subword Tokenization

Instead of treating every word as one indivisible unit, we can break words into smaller pieces.

For example:

```text
unbelievable
```

might be represented as:

```text
["un", "believ", "able"]
```

Now the model can potentially recognize parts of unfamiliar words.

For example:

```text
unhappy
```

might contain:

```text
un + happy
```

Even if the complete word is uncommon, the pieces may be familiar.

---

# 7. Why Subword Tokenization is Powerful

Consider these words:

```text
play
played
playing
player
playful
```

A word-level tokenizer might need separate vocabulary entries:

```text
play
played
playing
player
playful
```

A subword tokenizer can potentially reuse pieces:

```text
play
ing
ed
er
ful
```

Conceptually:

```text
playing
   ↓
play + ing
```

This allows the vocabulary to be more efficient.

---

# 8. Common Tokenization Approaches

There are several important tokenization approaches.

You should know these names:

1. Word-level tokenization
2. Character-level tokenization
3. Subword tokenization
4. Byte-level tokenization

Modern LLMs commonly use variants of **subword or byte-level tokenization**.

---

# 9. Word-Level Tokenization

Word-level tokenization treats each word as a token.

Example:

```text
"I love artificial intelligence"
```

becomes:

```text
["I", "love", "artificial", "intelligence"]
```

### Advantages

* Simple
* Easy to understand
* Tokens have clear meanings

### Problems

Vocabulary becomes very large.

Also, unknown words become a problem.

```text
Known word → token
Unknown word → <UNK>
```

---

# 10. Character-Level Tokenization

Character-level tokenization treats individual characters as tokens.

Example:

```text
"cat"
```

becomes:

```text
["c", "a", "t"]
```

### Advantages

It can represent virtually any word.

There is no major unknown-word problem.

### Problems

Sequences become very long.

For example:

```text
"transformer"
```

requires many character tokens instead of one or a few subword tokens.

Longer sequences mean more computation.

---

# 11. Subword Tokenization

Subword tokenization is a compromise between word-level and character-level tokenization.

Example:

```text
"unhappiness"
```

might become:

```text
["un", "happi", "ness"]
```

The exact split depends on the tokenizer.

### Advantages

* Smaller vocabulary
* Handles rare words
* Handles unknown words better
* Efficient representation
* Reuses common word pieces

This is why subword tokenization became extremely important in modern NLP.

---

# 12. Byte-Level Tokenization

Some modern tokenizers operate at the **byte level**.

The important idea is that text can ultimately be represented using bytes.

This helps tokenizers handle:

* Uncommon words
* New words
* Special characters
* Different languages
* Emojis
* Misspellings

Byte-level approaches can avoid having to explicitly include every possible character or word in the vocabulary.

---

# 13. Tokenizer Vocabulary

A tokenizer has a **vocabulary**.

The vocabulary maps tokens to numerical IDs.

For example:

```text
Token       ID

"I"         27
"love"      5432
"cat"       8921
"ing"       1024
"."         13
```

These numbers are called **token IDs**.

Important:

> The token ID itself does not represent the meaning of the token.

For example:

```text
cat → 8921
dog → 1204
```

The fact that `8921` and `1204` are different numbers does not mean anything semantic.

The semantic representation comes later through **embeddings**.

---

# 14. Tokenization Example

Suppose we have:

```text
I love programming.
```

A simplified tokenizer might produce:

```text
["I", "love", "programming", "."]
```

Then the tokenizer maps each token to an ID:

```text
["I", "love", "programming", "."]
```

becomes:

```text
[27, 5432, 7128, 13]
```

The actual numbers depend on the tokenizer.

Then the model receives:

```text
[27, 5432, 7128, 13]
```

rather than the original text.

---

# 15. Special Tokens

Tokenizers can contain special tokens that aren't ordinary words.

Examples include:

```text
<BOS>
<EOS>
<PAD>
<UNK>
```

### BOS

**Beginning Of Sequence**

Marks the beginning of a sequence.

```text
<BOS> I love NLP
```

### EOS

**End Of Sequence**

Marks the end.

```text
I love NLP <EOS>
```

### PAD

**Padding token**

Used to make sequences the same length when required.

### UNK

**Unknown token**

Used by some tokenization approaches when a token cannot be represented.

Modern tokenizers vary in which special tokens they use.

---

# 16. Padding

Suppose we have two sequences:

```text
"I love NLP"

"I love artificial intelligence"
```

They contain different numbers of tokens.

Some neural-network operations require sequences in a batch to have compatible lengths.

We can add padding:

```text
["I", "love", "NLP", "<PAD>", "<PAD>"]

["I", "love", "artificial", "intelligence", "<PAD>"]
```

The model can use an **attention mask** to avoid treating padding as meaningful content.

---

# 17. Attention Mask

An attention mask tells the model which tokens should be considered.

For example:

```text
Tokens:
I    love    NLP    PAD    PAD

Mask:
1     1       1      0      0
```

Where:

```text
1 → valid token
0 → padding / ignored position
```

For autoregressive LLMs, there is another important concept called a **causal mask**, which prevents a token from looking at future tokens during training.

We will study this later when we learn Transformers and self-attention.

---

# 18. Token Count

An important concept when working with LLMs is **token count**.

For example:

```text
Text:
"I love artificial intelligence."
```

might contain several tokens.

The exact number depends on the tokenizer.

Therefore:

> **1 word ≠ necessarily 1 token.**

This is extremely important.

For example:

```text
Words ≠ Tokens
```

A single word can become:

```text
1 token
```

or:

```text
2 tokens
```

or:

```text
many tokens
```

depending on the word and tokenizer.

---

# 19. Why Token Count Matters

Token count affects:

* Context-window usage
* API cost
* Memory usage
* Computation
* Generation length
* Training efficiency

For example, if a model has a context window of a certain number of tokens, the model cannot simply accept an unlimited number of words.

The limit is measured in **tokens**.

---

# 20. Tokenization and Context Window

Suppose an LLM supports:

```text
100,000 tokens
```

This means its context is measured in tokens, not words.

The context can contain:

```text
System instructions
+
User messages
+
Previous conversation
+
Documents
+
Generated tokens
```

The total must fit within the model's supported context.

---

# 21. Tokenization in an LLM

A simplified LLM pipeline is:

```text
User Text
   ↓
Tokenizer
   ↓
Tokens
   ↓
Token IDs
   ↓
Embedding Layer
   ↓
Transformer
   ↓
Logits
   ↓
Probabilities
   ↓
Next Token
```

For example:

```text
"I love AI"
```

might become:

```text
Tokens
↓
["I", "love", "AI"]

↓
Token IDs
↓
[27, 5432, 9821]

↓
Embeddings
↓
Vectors

↓
Transformer
```

This is one of the most important pipelines to understand before studying Transformers.

---

# 22. Token IDs vs Embeddings

This distinction is extremely important.

### Token ID

A token ID is simply an index.

```text
cat → 8921
```

It tells us:

> "The token at vocabulary index 8921 is cat."

It does not itself contain semantic meaning.

---

### Embedding

The embedding layer converts the token ID into a vector.

Conceptually:

```text
8921
 ↓
Embedding lookup
 ↓
[0.21, -0.45, 0.72, ...]
```

This vector is what the neural network can use as a learned representation.

Therefore:

```text
Token
 ↓
Token ID
 ↓
Embedding vector
```

---

# 23. Tokenization is not Understanding

An important distinction:

> **Tokenization does not understand language.**

It simply converts text into tokens according to the tokenizer's rules.

For example:

```text
"dog"
```

might become:

```text
["dog"]
```

and:

```text
"dogs"
```

might become:

```text
["dog", "s"]
```

The tokenizer isn't deciding that dogs are animals.

It is only creating a representation that the model can process.

Semantic information is learned by the neural network during training.

---

# 24. Different Tokenizers

Different models can use different tokenizers.

Therefore, the same sentence can produce different token sequences depending on the model.

Conceptually:

```text
Sentence
   ↓
Tokenizer A
   ↓
Tokens A
```

while:

```text
Same sentence
   ↓
Tokenizer B
   ↓
Tokens B
```

The tokenization doesn't have to be identical.

This is why token counts can differ between different LLMs.

---

# 25. Important Tokenization Algorithms

You should recognize these names:

### BPE

**Byte Pair Encoding**

A widely used subword tokenization approach.

Basic idea:

> Start with small units and repeatedly merge frequently occurring pairs.

---

### WordPiece

A subword tokenization method associated with models such as BERT.

---

### Unigram

A tokenization approach that selects subword units based on a probabilistic model.

---

### SentencePiece

A tokenizer framework commonly used with models such as T5 and other systems.

SentencePiece can implement approaches such as:

* BPE
* Unigram

You do not need to memorize the complete algorithms yet.

For your 20/80 goal, understand the purpose and basic idea.

---

# 26. BPE — Basic Intuition

Suppose the training corpus frequently contains:

```text
play
playing
played
player
```

The tokenizer can learn common pieces.

Conceptually:

```text
play
+
ing
+
ed
+
er
```

Then it can reuse these pieces.

The actual BPE algorithm involves repeated frequency-based merging of symbols/subwords.

The important idea is:

> **Frequently occurring pieces can become tokens.**

---

# 27. Why LLMs Use Tokenization

Tokenization gives us a practical compromise.

We want:

```text
Small vocabulary
+
Ability to represent arbitrary text
+
Reasonably short sequences
```

Word-level tokenization gives:

```text
Short sequences
but
Huge vocabulary
```

Character-level tokenization gives:

```text
Small vocabulary
but
Very long sequences
```

Subword tokenization provides a balance:

```text
Moderate vocabulary
+
Reasonable sequence length
+
Good handling of rare words
```

---

# 28. The Complete Picture

Remember this pipeline:

```text
                 HUMAN LANGUAGE
                       │
                       ▼
                "I love NLP."
                       │
                       ▼
                  TOKENIZER
                       │
                       ▼
             ["I", "love", "NLP", "."]
                       │
                       ▼
                  TOKEN IDs
                       │
                       ▼
                 [27, 5432, ...]
                       │
                       ▼
               EMBEDDING LAYER
                       │
                       ▼
                 VECTOR REPRESENTATIONS
                       │
                       ▼
                  TRANSFORMER
                       │
                       ▼
                     LOGITS
                       │
                       ▼
                  PROBABILITIES
                       │
                       ▼
                  NEXT TOKEN
```

This is the bridge from **human language to neural networks**.

---

# 29. 80/20 Summary

Remember these points:

### 1. Token

A token is a unit of text processed by a model.

### 2. Tokenization

The process of converting text into tokens.

```text
Text → Tokens
```

### 3. Token ID

A numerical index assigned to a token.

```text
Token → Token ID
```

### 4. Embedding

A learned vector representation associated with a token.

```text
Token ID → Embedding Vector
```

### 5. One word is not necessarily one token.

```text
Word ≠ Token
```

### 6. Modern LLMs commonly use subword/byte-level approaches.

### 7. Token count matters because context windows and computation are measured in tokens.

### 8. Tokenization itself does not understand meaning.

The model learns language patterns through training.

---

# 30. One-Minute Interview Explanation

> **Tokenization is the process of converting text into smaller units called tokens so that a language model can process them. Tokens may represent complete words, subwords, characters, punctuation, or other symbols depending on the tokenizer. Each token is mapped to a numerical token ID, which is then converted into a learned embedding vector before being processed by the neural network. Modern LLMs commonly use subword or byte-level tokenization because it provides a good balance between vocabulary size and sequence length while handling rare or previously unseen words effectively.**

---

# 31. Next Topic

The next file is:

```text
03-vocabulary-and-token-ids.md
```

That file will focus specifically on:

```text
Vocabulary
    ↓
Token → ID mapping
    ↓
Token IDs
    ↓
Embedding lookup
```

This distinction is important because **token IDs are not the same thing as embeddings**.
