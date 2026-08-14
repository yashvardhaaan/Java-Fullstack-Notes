# What is NLP?

## 1. Definition

**NLP (Natural Language Processing)** is a field of **Artificial Intelligence (AI)** that enables computers to process, understand, interpret, and generate human language.

Human language is called **natural language** because it is the language humans naturally use to communicate, such as:

* English
* Hindi
* Marathi
* Tamil
* French
* Japanese

The main problem NLP solves is:

> **How can we make computers work with human language?**

Computers fundamentally process numbers, while humans communicate using words, sentences, and meaning.

Therefore, NLP provides techniques to convert human language into representations that computers and machine-learning models can process.

---

## 2. NLP in the AI hierarchy

NLP is a subfield of Artificial Intelligence.

```text
Artificial Intelligence
│
├── Machine Learning
│   │
│   └── Deep Learning
│
├── Computer Vision
│
├── Robotics
│
└── Natural Language Processing
    │
    ├── Text Classification
    ├── Machine Translation
    ├── Sentiment Analysis
    ├── Question Answering
    ├── Text Summarization
    └── Language Generation
```

Modern NLP heavily uses **Machine Learning**, **Deep Learning**, and especially **Transformers**.

---

## 3. Why do we need NLP?

Humans communicate primarily through language.

We want computers to perform tasks such as:

* Understand questions
* Translate languages
* Summarize documents
* Analyze opinions
* Search documents
* Answer questions
* Generate text
* Detect spam
* Extract information
* Have conversations with users

For example:

```text
User:
"What is the capital of France?"

        ↓

NLP system

        ↓

Understands the question

        ↓

"Paris"
```

---

## 4. Examples of NLP

### 4.1 Chatbots

Chatbots process human language and generate responses.

Examples:

* Customer support bots
* Virtual assistants
* LLM-based assistants

Basic flow:

```text
User message
     ↓
Language processing
     ↓
Model
     ↓
Response
```

---

### 4.2 Machine Translation

NLP can translate text from one language to another.

```text
English:
"I am going home."

        ↓

Hindi:
"मैं घर जा रहा हूँ।"
```

The system needs to understand the meaning of the original sentence before generating an appropriate translation.

---

### 4.3 Sentiment Analysis

Sentiment analysis determines the opinion or emotional polarity of text.

Example:

```text
"This phone is amazing!"

        ↓

Positive
```

Another example:

```text
"This phone is terrible."

        ↓

Negative
```

A common classification is:

```text
Positive
Negative
Neutral
```

---

### 4.4 Spam Detection

NLP can classify messages.

```text
"Congratulations! You won $1,000!"

        ↓

Spam
```

While:

```text
"Your meeting is scheduled for 3 PM."

        ↓

Not Spam
```

---

### 4.5 Text Summarization

NLP can transform a long document into a shorter summary.

```text
Long document
      ↓
NLP model
      ↓
Short summary
```

---

### 4.6 Question Answering

A system receives a question and produces an answer.

```text
Question:
"What is the largest planet?"

        ↓

Model

        ↓

"Jupiter"
```

---

## 5. Why is human language difficult?

Human language is much more complicated than it appears.

A computer needs to deal with:

* Ambiguity
* Context
* Word relationships
* Different meanings
* Slang
* Sarcasm
* Spelling variations
* Different languages
* Grammar
* Long-range dependencies

---

## 6. Ambiguity

A word can have multiple meanings.

Consider:

> "I went to the bank."

What does **bank** mean?

It could mean:

```text
Bank → Financial institution
```

or:

```text
Bank → Side of a river
```

The surrounding words and context are required to determine the correct meaning.

This is one of the fundamental challenges in NLP.

---

## 7. Context

The meaning of a word often depends on its surrounding words.

Consider:

> "I deposited money in the bank."

Here, **bank** clearly refers to a financial institution.

But:

> "The boat reached the river bank."

Here, **bank** refers to the side of a river.

Therefore:

```text
Word alone
   ↓
May be ambiguous

Word + Context
   ↓
Better understanding
```

This idea of **context** becomes extremely important when we study:

* Word embeddings
* Attention
* Transformers
* LLMs

---

## 8. Word order matters

Consider:

> "Dog bites man."

and:

> "Man bites dog."

Both sentences contain the same words.

But their meanings are different because the **relationships between the words are different**.

Therefore, an NLP system cannot simply treat a sentence as an unordered collection of words.

It needs to understand relationships between tokens.

This leads to the importance of:

> **Context + word relationships + position**

These concepts eventually lead us to **self-attention and Transformers**.

---

## 9. NLP and Machine Learning

Early NLP systems often relied on manually written rules.

For example:

```text
IF message contains "free money"
THEN classify as spam
```

This approach does not scale well.

There are millions of ways people can express the same idea.

Instead, Machine Learning allows a model to learn patterns from data.

For example:

```text
"I love this movie"       → Positive
"This movie is amazing"   → Positive
"I hate this movie"       → Negative
"This movie is terrible"  → Negative
```

After learning from many examples, the model can classify new sentences.

```text
"The movie was fantastic."

        ↓

Positive
```

---

## 10. Traditional NLP pipeline

A simplified traditional NLP pipeline looks like:

```text
Raw Text
   ↓
Text Cleaning
   ↓
Tokenization
   ↓
Feature Extraction
   ↓
Machine Learning Model
   ↓
Prediction
```

For example:

```text
"I love this movie!"

        ↓

Tokenization

        ↓

["I", "love", "this", "movie"]

        ↓

Feature representation

        ↓

ML model

        ↓

Positive
```

---

## 11. Traditional NLP techniques

Before modern deep-learning models, NLP commonly used techniques such as:

### Tokenization

Breaking text into smaller units.

```text
"I love NLP"

↓

["I", "love", "NLP"]
```

### Stop-word removal

Removing commonly occurring words when appropriate.

Example:

```text
"I am going to the store"

↓

"going store"
```

This technique was common in traditional NLP pipelines, although modern LLM systems generally don't rely on this kind of preprocessing.

### Stemming

Reducing words to a simpler root form.

```text
playing
played
plays

↓

play
```

### Lemmatization

Reducing words to their dictionary/base form while considering language rules.

```text
better → good
running → run
```

### TF-IDF

A statistical technique used to represent the importance of words in documents.

---

## 12. Traditional NLP vs Modern NLP

### Traditional NLP

```text
Text
 ↓
Tokenization
 ↓
Manual feature engineering
 ↓
TF-IDF / other features
 ↓
ML algorithm
 ↓
Output
```

Typical algorithms:

* Naive Bayes
* Logistic Regression
* Support Vector Machine

---

### Deep Learning NLP

```text
Text
 ↓
Tokenization
 ↓
Embeddings
 ↓
Neural Network
 ↓
Output
```

Models included:

* RNN
* LSTM
* GRU
* CNN

---

### Modern Transformer-based NLP

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
 ↓
Embeddings
 ↓
Transformer
 ↓
Output
```

Examples:

* BERT
* GPT
* T5
* Modern LLMs

---

## 13. The evolution of NLP

A useful way to remember the evolution is:

```text
Rule-Based Systems
        ↓
Statistical NLP
        ↓
Machine Learning
        ↓
Deep Learning
        ↓
RNN / LSTM
        ↓
Attention
        ↓
Transformers
        ↓
Large Language Models
```

You do not need to memorize every historical model.

The important transition is:

```text
Rules
  ↓
Learned patterns
  ↓
Neural representations
  ↓
Attention
  ↓
Transformers
  ↓
LLMs
```

---

# 14. What is an NLP model actually trying to learn?

At a high level, an NLP model tries to learn patterns in language.

For example, after seeing many sentences:

```text
"The cat is sleeping."

"The cat is eating."

"The dog is sleeping."

"The dog is eating."
```

the model learns relationships such as:

* cat and dog can occur in similar contexts
* sleeping and eating can occur after animals
* words have relationships with surrounding words

Modern language models learn much more complex patterns from enormous datasets.

---

# 15. NLP and LLMs

This is especially important for understanding your LLM roadmap.

**LLM = Large Language Model**

An LLM is a machine-learning model trained on large amounts of text to learn patterns in language.

A simplified LLM pipeline is:

```text
Text
 ↓
Tokenization
 ↓
Token IDs
 ↓
Embeddings
 ↓
Transformer
 ↓
Logits
 ↓
Probabilities
 ↓
Next Token
```

The model can repeatedly predict tokens to generate text.

For example:

```text
Input:
"The capital of France is"

        ↓

Model predicts:

"Paris"
```

Then the generated token can become part of the next input.

---

# 16. NLP → Transformer → LLM

The concepts you are going to learn can be connected like this:

```text
NLP
│
├── Tokenization
│
├── Vocabulary
│
├── Embeddings
│
└── Context
        ↓
    Attention
        ↓
   Self-Attention
        ↓
    Transformer
        ↓
       GPT
        ↓
       LLM
```

Therefore, the topics in this folder are not random.

They build the foundation required to understand how an LLM works.

---

# 17. Important NLP tasks

You should recognize these terms:

| Task                     | Purpose                    |
| ------------------------ | -------------------------- |
| Text Classification      | Assign a category to text  |
| Sentiment Analysis       | Determine sentiment        |
| Named Entity Recognition | Identify entities          |
| Machine Translation      | Translate languages        |
| Text Summarization       | Shorten documents          |
| Question Answering       | Answer questions           |
| Text Generation          | Generate text              |
| Information Extraction   | Extract useful information |
| Semantic Search          | Search based on meaning    |
| Language Modeling        | Learn patterns in language |

---

# 18. Key terminology

### Corpus

A **corpus** is a collection of text used for NLP research or model training.

Example:

```text
Millions of books
+
Web pages
+
Articles
+
Documents
=
Large text corpus
```

---

### Token

A token is a unit produced by a tokenizer.

Depending on the tokenizer, a token can represent:

* A word
* Part of a word
* A character
* Punctuation
* Special symbols

---

### Vocabulary

The set of tokens known by a tokenizer/model.

---

### Embedding

A numerical vector representation of a token or piece of text.

Example:

```text
"cat"

↓

[0.21, -0.45, 0.72, ...]
```

---

### Context

The surrounding information that helps determine meaning.

---

### Language Model

A model that learns patterns in language and can assign probabilities to token sequences.

Modern autoregressive LLMs use this capability to predict the next token.

---

# 19. The most important idea

Don't think:

> "NLP means computers understand English."

A better understanding is:

> **NLP is the collection of computational techniques used to represent, process, analyze, understand, and generate human language.**

Modern NLP models don't necessarily "understand" language exactly as humans do. They learn statistical and semantic patterns from data and use those learned representations to perform language tasks.

---

# 20. 80/20 Summary

If you remember only these points, you have understood the important part of this file:

### 1.

**NLP = Natural Language Processing.**

It is a field of AI concerned with human language.

### 2.

Computers need language to be converted into numerical representations.

```text
Text
 ↓
Tokens
 ↓
Numbers / vectors
```

### 3.

**Context matters.**

```text
Word + Context → Meaning
```

### 4.

Traditional NLP used techniques such as:

```text
Tokenization
Stemming
Lemmatization
TF-IDF
```

### 5.

Modern NLP uses deep learning and especially **Transformers**.

### 6.

LLMs are a major modern application of NLP.

### 7.

A simplified modern LLM pipeline is:

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
 ↓
Embeddings
 ↓
Transformer
 ↓
Next-token prediction
 ↓
Generated text
```

---

# 21. Interview Answer

**Question: What is NLP?**

> Natural Language Processing is a field of Artificial Intelligence that enables computers to process, analyze, understand, and generate human language. Traditional NLP relied on techniques such as tokenization, stemming, TF-IDF, and machine-learning algorithms. Modern NLP uses deep-learning architectures, particularly Transformers, which form the foundation of models such as BERT and GPT. Large Language Models use these techniques to learn language patterns from large amounts of data and generate text through next-token prediction.

---

# 22. Next Topic

The next file in the sequence is:

```text
02-tokens-and-tokenization.md
```

The key question it will answer is:

> **How does an LLM convert human text such as "I love artificial intelligence" into numbers that a neural network can process?**
