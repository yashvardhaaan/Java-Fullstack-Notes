Yes. From now on, I’ll make each note **theory + practical**, and every topic will answer:

**What? → Why? → How? → Where used? → Practical example → Interview/GATE points**

We’ll continue **one `.md` file at a time**.

### `05-LLM-TRAINING/01-training-data.md`

````md
# Training Data

## 1. What is Training Data?

Training data is the collection of text, code, documents, conversations, and other information used to **teach an LLM patterns in language**.

Example:

```text
Training Data
     ↓
Text / Code / Documents
     ↓
LLM Training
     ↓
Learned Parameters
````

The model learns by seeing many examples and trying to predict the next token.

---

## 2. Why is Training Data Important?

The quality of an LLM depends heavily on its training data.

Good data can help the model learn:

* Language
* Facts
* Reasoning patterns
* Programming
* Different writing styles
* Domain-specific knowledge

Poor-quality data can cause:

* Incorrect information
* Bias
* Duplicate learning
* Poor language understanding
* Unwanted behavior

### Simple rule

> **Garbage data → Garbage model**

---

## 3. What Can Training Data Contain?

Typical LLM datasets may contain:

```text
Books
Web pages
Articles
Wikipedia
Research papers
Code
Documentation
Questions & Answers
Conversations
```

The exact dataset depends on the model and its intended use.

---

## 4. How is Training Data Prepared?

Raw data usually cannot be directly used.

A simplified pipeline is:

```text
Raw Data
   ↓
Collection
   ↓
Cleaning
   ↓
Deduplication
   ↓
Filtering
   ↓
Tokenization
   ↓
Training Dataset
```

### Example

Raw web data:

```text
"This is a useful article..."
"This is a useful article..."
Spam / advertisements
Broken HTML
```

After processing:

```text
Clean useful text
        ↓
Remove duplicates
        ↓
Remove unwanted content
        ↓
Tokenize
        ↓
Training
```

---

## 5. Why Remove Duplicate Data?

Suppose the same document appears 1,000 times.

```text
Document A
Document A
Document A
...
```

The model may see that information far more often than intended.

**Deduplication** reduces unnecessary repetition and can improve training efficiency.

---

## 6. Where is Training Data Used?

Training data is used during the **training phase**, not normally during inference.

```text
Training:

Dataset → Model → Learn Parameters

Inference:

Prompt → Trained Model → Response
```

Once training is complete, the model uses its learned parameters to generate responses.

---

## 7. Practical Example

Imagine we want to train a small language model on programming data.

Dataset:

```python
data = [
    "Python is a programming language.",
    "Python uses indentation.",
    "A function is defined using def."
]
```

A training example can be created by predicting the next token.

```text
Input:
"Python is a"

Target:
"programming"
```

Another:

```text
Input:
"A function is defined using"

Target:
"def"
```

The model repeatedly learns from examples like these.

---

## 8. Practical Dataset Preparation

A simple example:

```python
documents = [
    "Python is a programming language.",
    "Python is a programming language.",
    "This is useful documentation."
]

# Remove duplicates
documents = list(set(documents))

print(documents)
```

In real LLM projects, preprocessing is much more sophisticated and may include:

* Language filtering
* Quality filtering
* PII removal
* Spam filtering
* Deduplication
* Toxic-content filtering
* Document normalization

---

## 9. Training Data vs Fine-Tuning Data

These are different.

### Pretraining Data

Usually very large and diverse.

```text
Internet + Books + Code + Documents
             ↓
          Pretraining
             ↓
       Base LLM
```

### Fine-Tuning Data

Usually smaller and focused on a specific behavior/task.

```text
Instruction + Answer examples
             ↓
         Fine-tuning
             ↓
      Specialized Model
```

---

## 10. Industry Usage

Training-data engineering is a major part of LLM development.

Companies spend significant effort on:

* Building datasets
* Cleaning web data
* Removing duplicates
* Filtering low-quality content
* Creating high-quality instruction datasets
* Creating domain-specific datasets

For example, a company building a **medical-document LLM** may need carefully selected domain data rather than simply using random internet text.

---

## GATE / Interview Points

* Training data is the data used to learn model parameters.
* Data quality strongly affects model quality.
* Common preprocessing includes cleaning, filtering and deduplication.
* Pretraining generally uses large and diverse datasets.
* Fine-tuning generally uses smaller, task-specific datasets.
* Training data is different from inference input.
* Tokenization converts text into tokens before the model processes it.

---

## Mental Model

> **Training data is what the model learns from; better-quality data generally leads to better learning.**

```

Next: `02-pretraining.md`
```
