# Context and Word Meaning

## 1. Why is Context Important?

A word by itself does not always have a single meaning.

Consider:

> **bank**

What does `bank` mean?

It could mean:

```text id="f8g2u1"
Bank → Financial institution
```

or:

```text id="0m8k9d"
Bank → Side of a river
```

The word itself is identical.

The **context** determines the intended meaning.

Therefore:

> **To understand language, we often need to understand words in relation to the words around them.**

This idea is fundamental to modern NLP and especially to **Transformers and LLMs**.

---

# 2. What is Context?

**Context** is the surrounding information that helps determine the meaning of something.

For language, context can include:

* Words before a word
* Words after a word
* The sentence
* Previous sentences
* The entire conversation
* The topic
* The situation

For example:

```text id="w8f5q1"
I deposited money in the bank.
```

The words:

```text id="j4w7a2"
deposited
money
```

strongly suggest that `bank` means a financial institution.

Compare:

```text id="x6n3p9"
We sat beside the river bank.
```

The words:

```text id="r2k8m4"
river
sat
beside
```

suggest that `bank` means the side of a river.

---

# 3. Same Word, Different Meaning

Consider the word:

> **bat**

It can mean:

```text id="7r2c5m"
A flying animal
```

or:

```text id="5v9k1a"
A piece of sports equipment
```

Compare:

```text id="q8w2e6"
The bat flew out of the cave.
```

Here:

```text id="7x1m9p"
bat → animal
```

Now:

```text id="k3p6s8"
He hit the ball with the bat.
```

Here:

```text id="n4d7q2"
bat → sports equipment
```

The surrounding words disambiguate the meaning.

---

# 4. Word Meaning Is Not Always Fixed

A common beginner mistake is to think:

```text id="z3k6m8"
Word → One fixed meaning
```

Natural language doesn't work that way.

A better model is:

```text id="y5q2n7"
Word + Context
       ↓
Intended Meaning
```

For example:

```text id="b7m1c4"
bank
+
money
+
deposit
       ↓
financial institution
```

while:

```text id="d9r4t6"
bank
+
river
+
shore
       ↓
side of a river
```

---

# 5. Polysemy

**Polysemy** means that a word has multiple related meanings.

For example:

```text id="h2k7p9"
paper
```

can refer to:

* The physical material
* An academic research paper
* A newspaper
* An examination paper

The intended meaning depends on context.

---

# 6. Homonymy

**Homonyms** are words that have the same form but different meanings.

For example:

```text id="m4v8s2"
bat
```

can refer to:

* An animal
* Sports equipment

Again, context is required.

---

# 7. Context Can Exist at Different Levels

Context isn't limited to the immediately surrounding words.

There are several levels.

## Word-level context

Words immediately around the target.

```text id="k8p3d1"
The cat drinks milk.
          ↑
       context
```

---

## Sentence-level context

The entire sentence.

```text id="p7m2q9"
I went to the bank to deposit my salary.
```

The whole sentence helps determine `bank`.

---

## Document-level context

Previous sentences can matter.

```text id="c5n8r3"
John went to the hospital.

He needed an operation.
```

The word `he` refers to John.

The previous sentence provides context.

---

## Conversation-level context

In a chatbot, previous messages matter.

```text id="v4k9s1"
User:
Who is Albert Einstein?

Assistant:
Albert Einstein was a physicist...

User:
When was he born?
```

The word `he` refers to Albert Einstein.

The model needs conversation context to answer correctly.

---

# 8. Pronouns and Context

Pronouns are a simple example of why context matters.

Consider:

> "John went to the store because he needed milk."

Who does `he` refer to?

```text id="p1r6v8"
he → John
```

Now:

> "Sarah spoke to John because he needed help."

Here:

```text id="u3k7m2"
he → John
```

Understanding pronouns requires relationships between words.

---

# 9. Word Order Matters

Consider:

```text id="m9v2k4"
Dog bites man.
```

and:

```text id="r6t1p8"
Man bites dog.
```

Both contain:

```text id="x4c8n5"
dog
man
bites
```

But the meaning is different.

Why?

Because the relationships and positions of the words changed.

Therefore:

> **Language is not simply a bag of words.**

Word order matters.

---

# 10. Bag of Words Limitation

A traditional **Bag of Words** representation treats text largely as a collection of word counts.

For example:

```text id="q5w8e1"
"dog bites man"
```

and:

```text id="n3k7p2"
"man bites dog"
```

contain the same words.

A basic bag-of-words representation could therefore be identical:

```text id="f8m2c6"
dog → 1
bites → 1
man → 1
```

But the meanings are different.

This demonstrates a major limitation:

> **Counting words alone does not capture word relationships and order.**

---

# 11. Context and Word Embeddings

Traditional word embeddings such as **Word2Vec** and **GloVe** capture relationships between words based on their usage across a corpus.

For example:

```text id="v6p3q8"
cat → vector A
dog → vector B
```

Because they occur in similar contexts, their vectors can be similar.

However, classic Word2Vec and GloVe generally assign a single vector to a word.

For example:

```text id="c2r7m9"
bank → one vector
```

This creates a problem.

The word `bank` has multiple meanings.

---

# 12. Static Embeddings

Word2Vec and GloVe are generally considered **static word embeddings**.

That means:

```text id="x7n4p1"
bank
 ↓
one learned vector
```

Whether the sentence is:

```text id="m3k8q2"
I deposited money in the bank.
```

or:

```text id="r9v5c6"
We sat beside the river bank.
```

the underlying static word embedding for `bank` is essentially the same.

The embedding itself doesn't dynamically change according to the sentence.

---

# 13. Contextual Representations

Modern Transformer models solve this differently.

Instead of assigning exactly one representation to a word regardless of context, the model can create a representation influenced by the surrounding tokens.

For example:

```text id="a6p2r8"
I deposited money in the bank.
```

The representation of `bank` is influenced by:

```text id="n7c4m1"
deposited
money
```

while:

```text id="q8v3s5"
We sat beside the river bank.
```

causes the representation of `bank` to be influenced by:

```text id="t2k9d6"
river
sat
beside
```

Conceptually:

```text id="y4p7m2"
bank + financial context
        ↓
representation A
```

and:

```text id="c8r1n5"
bank + river context
        ↓
representation B
```

This is called a **contextual representation**.

---

# 14. Why Transformers Are Important

The major question becomes:

> **How can a model determine which surrounding words are important for understanding a particular word?**

This is where **attention** comes in.

For example:

```text id="h7m3q9"
I deposited money in the bank.
                    ↑
                   bank
```

The model needs to recognize that:

```text id="p2r8v4"
money
deposited
```

are relevant to understanding `bank`.

Attention allows tokens to assign different levels of importance to other tokens.

Conceptually:

```text id="w6c1m9"
bank
 ↓
looks at surrounding tokens
 ↓
identifies relevant information
 ↓
creates contextual representation
```

This is the bridge to the next folder.

---

# 15. Self-Attention

**Self-attention** allows tokens in a sequence to interact with other tokens in the same sequence.

For example:

```text id="b5n2q7"
The animal didn't cross the road because it was tired.
```

What does `it` refer to?

Likely:

```text id="f8m4c1"
animal
```

The model needs to establish a relationship between:

```text id="x7q2m6"
it ↔ animal
```

Self-attention helps the model calculate relationships between tokens.

---

# 16. Context Is Not Just "Nearby Words"

Context can extend over long distances.

Consider:

```text id="r4p8m1"
The boy went to the restaurant.
He ordered a pizza.
After eating it, he paid the bill and left.
```

The word:

```text id="u3k7n5"
He
```

requires information from an earlier sentence.

Similarly:

```text id="v6c2q9"
it
```

could refer to:

```text id="m8r1p4"
pizza
```

Understanding such relationships requires more than looking at only the immediately adjacent words.

This becomes a major challenge for language models.

---

# 17. Long-Range Dependencies

A **long-range dependency** occurs when understanding one part of a sentence requires information from another part that may be far away.

Example:

```text id="k2m7v9"
The student who studied for several months
and practiced every day finally passed
the difficult examination.
```

To understand:

```text id="a4p8c1"
passed
```

the model needs to understand who passed:

```text id="z6n3r5"
student
```

and that relationship spans multiple words.

Modern Transformers are particularly effective at modeling such relationships.

---

# 18. Context in LLMs

For an LLM, context can be much larger than one sentence.

Suppose a conversation contains:

```text id="c8m4p2"
User:
My name is Yash.

Assistant:
Nice to meet you.

User:
What is my name?
```

The model needs the previous conversation to answer:

```text id="q7r1n6"
Yash
```

The relevant information exists in the **context window**.

So:

```text id="n5v8m3"
Context
=
Information available to the model while generating a response
```

---

# 19. Context Window

The **context window** is the amount of tokenized information a model can process as context for a particular generation.

Conceptually:

```text id="m1q7v4"
┌─────────────────────────────────┐
│ System instructions             │
│ Previous conversation           │
│ User message                    │
│ Retrieved documents             │
│ Other input                     │
└─────────────────────────────────┘
              ↓
          Transformer
              ↓
        Next-token prediction
```

The exact maximum context size depends on the model.

The important idea is:

> **The model can only directly use information that is available within its context.**

---

# 20. Context and LLM Generation

Suppose the user asks:

> "What is the capital of France?"

The model receives something like:

```text id="q8n3m5"
"What is the capital of France?"
```

It processes the tokens and predicts the next token.

Conceptually:

```text id="a5r2v9"
What is the capital of France?
                ↓
            Transformer
                ↓
           Probability
                ↓
              Paris
```

For a longer conversation:

```text id="j7m4c1"
Previous messages
       +
Current question
       ↓
    Context
       ↓
   Transformer
       ↓
   Next-token prediction
```

---

# 21. Context and Attention Are Different Concepts

Don't confuse them.

### Context

The information surrounding a token or available to the model.

### Attention

A mechanism that allows the model to determine how strongly different tokens should interact.

So:

```text id="r8p3m6"
Context
   ↓
Information available
```

while:

```text id="v2k7n4"
Attention
   ↓
How information from different tokens is combined
```

This distinction is very important.

---

# 22. Context and Self-Attention

Consider:

```text id="z6m1q8"
The cat sat on the mat because it was tired.
```

For the token:

```text id="e3r7p2"
it
```

the model may need to relate it to:

```text id="s9c4n5"
cat
```

Self-attention provides a mechanism for doing this.

Conceptually:

```text id="f8q2m7"
        "it"
         │
         │ attention
         ▼
       "cat"
```

In reality, the model considers many tokens and learns attention patterns through training.

---

# 23. Multiple Attention Relationships

A token doesn't necessarily attend to only one other token.

For example:

```text id="k5m8r2"
The cat drinks milk because it is hungry.
```

The model may need relationships involving:

```text id="p3n7c1"
it
↓
cat

hungry
↓
cat / it / broader sentence context
```

Different attention heads can learn different kinds of relationships.

This leads to **multi-head attention**, which we will study later.

---

# 24. Context and Ambiguity

Context is especially useful for ambiguous words.

Example:

```text id="y4c8m2"
I need to charge my phone.
```

Here:

```text id="h7n3p9"
charge → put energy into battery
```

But:

```text id="r6m1q5"
The police will charge him with theft.
```

Here:

```text id="w8k2c4"
charge → formally accuse
```

Same word.

Different context.

Different meaning.

---

# 25. Context and Sentiment

Context can also change sentiment.

Consider:

> "This phone is sick!"

Depending on context, `sick` could mean:

```text id="j3r7m8"
Negative:
The person is physically ill.
```

or slang:

```text id="c9p2v6"
Positive:
The phone is extremely impressive.
```

Understanding this requires context and knowledge of language usage.

---

# 26. Context and Negation

Negation is another important example.

Compare:

```text id="m7q2c5"
I like this movie.
```

with:

```text id="v4n8r1"
I don't like this movie.
```

The word:

```text id="f6p3k9"
don't
```

changes the meaning of the sentence.

A good NLP system must understand relationships between words rather than simply counting them.

---

# 27. Context and Meaning: A Useful Formula

A useful mental model is:

```text id="b9m4q7"
Meaning
   ≈
Word
+
Context
+
Relationships
```

For modern language models:

```text id="c5r8n2"
Token representation
   ↓
Context
   ↓
Attention
   ↓
Contextual representation
```

---

# 28. From Static Embeddings to Transformers

Now we can see the evolution:

```text id="q2m7v4"
One-Hot
   ↓
No semantic relationship

Word2Vec / GloVe
   ↓
Static semantic relationships

Contextual Models
   ↓
Meaning depends on context

Transformers
   ↓
Self-attention models token relationships

LLMs
   ↓
Large-scale Transformer language models
```

This is the conceptual journey you are following.

---

# 29. Why Attention Was Needed

Traditional word embeddings give us:

```text id="r5c8n1"
bank → one vector
```

But we want:

```text id="m7q2v4"
"I deposited money in the bank."

bank
 ↓
financial meaning
```

and:

```text id="p3n9c6"
"We sat beside the river bank."

bank
 ↓
river-side meaning
```

Therefore, the representation needs to incorporate surrounding information.

Attention provides a mechanism to do this.

---

# 30. Context → Attention → Transformer

This is the most important connection in this file:

```text id="v8m3q1"
                 CONTEXT
                    ↓
        "Which other tokens matter?"
                    ↓
                 ATTENTION
                    ↓
       Combine information from tokens
                    ↓
             SELF-ATTENTION
                    ↓
              TRANSFORMER
                    ↓
        Contextual representations
                    ↓
                   LLM
```

---

# 31. 80/20 Summary

Remember these points:

1. **Context helps determine meaning.**

2. The same word can have different meanings in different contexts.

3. Word order matters.

4. Bag-of-Words representations lose important relationships.

5. Word2Vec and GloVe provide useful but generally **static** word representations.

6. Modern Transformers create **contextual representations**.

7. **Self-attention** allows tokens to interact with other tokens in the sequence.

8. Context can exist at multiple levels:

```text
Word
Sentence
Document
Conversation
```

9. The **context window** determines how much tokenized information is available to the model.

10. Understanding context is one of the key reasons **Transformers and attention** became so important.

---

# 32. Interview Answer

**Question: Why is context important in NLP?**

> Context is important because the meaning of a word often depends on the surrounding words and the broader situation. For example, the word "bank" can refer to a financial institution or the side of a river depending on the sentence. Traditional static embeddings such as Word2Vec and GloVe assign essentially one vector to a word, which limits their ability to represent different meanings. Transformer models address this by using self-attention to incorporate information from surrounding tokens and create context-dependent representations.

---

# 33. Final Mental Model

You should now have this progression in your head:

```text id="q7m2v9"
             LANGUAGE
                 │
                 ▼
              TOKENS
                 │
                 ▼
          TOKEN REPRESENTATION
                 │
                 ▼
           WORD EMBEDDINGS
                 │
                 ▼
              CONTEXT
                 │
                 ▼
             ATTENTION
                 │
                 ▼
          SELF-ATTENTION
                 │
                 ▼
            TRANSFORMER
                 │
                 ▼
               GPT
                 │
                 ▼
                LLM
```

The next folder is the **most important part of your LLM 20/80 roadmap**:

```text
02-ATTENTION/
```

The first file is:

```text
01-why-attention.md
```

The key question we'll answer is:

> **Why did NLP need Attention in the first place, and what problem does Attention solve?**
