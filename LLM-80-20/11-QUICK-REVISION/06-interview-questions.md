### `11-QUICK-REVISION/06-llm-training-cheat-sheet.md`

````md
# LLM Training Cheat Sheet

## 1. What is LLM Training?

LLM training is the process of adjusting model parameters so the model becomes better at predicting tokens.

```text
Training Data
     ↓
Tokenization
     ↓
Transformer
     ↓
Next-Token Prediction
     ↓
Loss
     ↓
Backpropagation
     ↓
Gradient Descent
     ↓
Update Parameters
     ↓
Repeat
````

---

## 2. Main Stages of LLM Development

```text
Pretraining
    ↓
Instruction Tuning
    ↓
Alignment
    ↓
Evaluation
    ↓
Deployment
```

### Pretraining

Learns general language patterns from large-scale data.

### Instruction Tuning

Teaches the model to follow instructions.

### Alignment

Optimizes behavior according to desired preferences, safety and usefulness.

---

## 3. Pretraining

Typical objective:

> Predict the next token.

Example:

```text
Input:
"The capital of India is"

Target:
"New"
```

More generally:

```text
Previous Tokens
      ↓
Model
      ↓
Probability of Next Token
      ↓
Compare with Actual Token
      ↓
Loss
```

---

## 4. Training Dataset

Training data can contain:

```text
Books
Web pages
Code
Articles
Documents
Conversations
Educational material
```

Important:

```text
More data ≠ Automatically better model
```

Data quality, diversity, filtering and deduplication matter.

---

## 5. Tokenization

Raw text is converted into tokens.

```text
Text
 ↓
Tokenizer
 ↓
Token IDs
```

Example:

```text
"I love Python"

↓
[Token₁, Token₂, Token₃]
```

The exact tokens depend on the tokenizer.

---

## 6. Forward Pass

During a forward pass:

```text
Input Tokens
     ↓
Embeddings
     ↓
Transformer Layers
     ↓
Logits
     ↓
Predicted Distribution
```

No parameter update happens during the forward pass itself.

---

## 7. Logits

The model produces raw scores called **logits**.

Example:

```text
Paris   → 8.2
London  → 5.1
Berlin  → 4.7
```

Then:

```text
Logits
 ↓
Softmax
 ↓
Probabilities
```

---

## 8. Cross-Entropy Loss

The training objective commonly uses cross-entropy loss.

For one correct target token:

```text
Loss = -log(p_correct)
```

Example:

```text
p_correct = 0.9
→ Low loss
```

```text
p_correct = 0.1
→ High loss
```

Goal:

```text
Minimize Loss
```

---

## 9. Backpropagation

Backpropagation calculates how each parameter contributed to the loss.

```text
Loss
 ↓
Gradients
 ↓
Parameters
```

It uses the chain rule to compute derivatives.

Important:

```text
Backpropagation → Calculates gradients
Gradient Descent → Uses gradients to update parameters
```

---

## 10. Gradient Descent

Parameters are updated in the direction that reduces loss.

Formula:

```text
θ_new = θ_old - η∇L
```

Where:

```text
θ = Parameters
η = Learning Rate
∇L = Gradient of Loss
```

---

## 11. Learning Rate

Learning rate controls the size of parameter updates.

```text
Too Large
 ↓
Training may become unstable
```

```text
Too Small
 ↓
Training becomes very slow
```

Good learning rate:

```text
Stable + Efficient convergence
```

---

## 12. Batch

A **batch** is a group of training examples processed together.

Example:

```text
Dataset = 1,000,000 examples

Batch size = 32
```

The model processes:

```text
32 examples
 ↓
Calculate loss
 ↓
Gradient
 ↓
Update
```

Then the next batch is processed.

---

## 13. Iteration / Step

One training iteration generally means one parameter update based on one batch.

```text
1 Batch
   ↓
Forward
   ↓
Loss
   ↓
Backward
   ↓
Parameter Update
```

That is one training step/iteration.

---

## 14. Epoch

An **epoch** is one complete pass through the training dataset.

Example:

```text
1,000 examples
Batch size = 100
```

Approximately:

```text
10 batches
=
1 epoch
```

If training for 3 epochs:

```text
3 × 10
=
30 iterations
```

Ignoring details such as dropped/partial batches.

---

## 15. Batch vs Iteration vs Epoch

| Term           | Meaning                           |
| -------------- | --------------------------------- |
| Batch          | Group of training examples        |
| Iteration/Step | One parameter-update step         |
| Epoch          | One complete pass through dataset |

Mental model:

```text
Dataset
 ↓
Batches
 ↓
Iterations
 ↓
Epoch
```

---

## 16. GPU

LLM training requires massive matrix operations.

GPUs are effective because they can perform many parallel operations.

```text
LLM Training
     ↓
Matrix Operations
     ↓
GPU
     ↓
Parallel Computation
```

Large models may require:

```text
Multiple GPUs
Multiple Machines
Distributed Training
```

---

## 17. GPU Memory

GPU memory stores things such as:

```text
Model Parameters
Activations
Gradients
Optimizer States
KV/cache-related inference data
```

During training, memory requirements are much larger than just storing the model weights.

---

## 18. Mixed Precision

Training can use lower-precision numerical formats such as:

```text
FP32
FP16
BF16
```

Benefits:

```text
Lower memory usage
+
Faster computation
```

BF16 is commonly useful for modern deep-learning training because it provides a large dynamic range while using fewer bits than FP32.

---

## 19. Optimizers

An optimizer determines how parameters are updated using gradients.

Common optimizer:

```text
Adam
AdamW
```

Simplified:

```text
Gradient
   ↓
Optimizer
   ↓
Parameter Update
```

AdamW is commonly used for Transformer/LLM training.

---

## 20. Learning Rate Schedule

The learning rate can change during training.

Example:

```text
Learning Rate
      ↓
Warmup
      ↓
Higher Learning Rate
      ↓
Decay
      ↓
Lower Learning Rate
```

Why?

```text
Warmup → Stable early training
Decay  → More controlled convergence
```

---

## 21. Overfitting

Overfitting occurs when the model learns the training data too specifically and performs poorly on unseen data.

```text
Training Performance
       ↑
Very High

Validation Performance
       ↓
Poor
```

For large-scale pretraining, the data regime and objective differ from traditional small supervised-learning settings, but generalization remains important.

---

## 22. Training vs Validation Data

### Training Data

Used to update parameters.

### Validation Data

Used to evaluate the model during development without updating parameters from those examples.

```text
Training Data
     ↓
Parameter Updates

Validation Data
     ↓
Evaluation
```

---

## 23. Distributed Training

Very large models may not fit on one GPU.

Training can be distributed across multiple GPUs.

Common concepts:

```text
Data Parallelism
Tensor Parallelism
Pipeline Parallelism
```

### Data Parallelism

Different GPUs process different batches.

```text
GPU 1 → Batch A
GPU 2 → Batch B
GPU 3 → Batch C
```

### Tensor Parallelism

A model's computation is split across GPUs.

### Pipeline Parallelism

Different model layers are placed on different GPUs.

---

## 24. Training Pipeline

```text
Raw Data
   ↓
Cleaning
   ↓
Filtering
   ↓
Deduplication
   ↓
Tokenization
   ↓
Batching
   ↓
GPU Training
   ↓
Forward Pass
   ↓
Loss
   ↓
Backpropagation
   ↓
Optimizer
   ↓
Parameter Update
   ↓
Checkpoint
   ↓
Evaluation
```

---

## 25. Checkpoints

A checkpoint stores the model's training state.

It can contain:

```text
Model weights
Optimizer state
Training step
Learning-rate state
```

Why?

```text
Training Failure
     ↓
Load Checkpoint
     ↓
Continue Training
```

Checkpoints can also be used to compare model states during training.

---

## 26. Pretraining vs Fine-Tuning

### Pretraining

```text
Huge General Dataset
        ↓
Base Model
```

Goal:

```text
General language capability
```

### Fine-Tuning

```text
Pretrained Model
        ↓
Smaller Specialized Dataset
        ↓
Adapted Model
```

Goal:

```text
Task / Domain / Behavior adaptation
```

---

## 27. Instruction Tuning

Instruction tuning trains the model on instruction-response examples.

Example:

```text
Instruction:
"Explain recursion."

Response:
"Recursion is a technique where a function calls itself..."
```

Pipeline:

```text
Pretrained Model
      ↓
Instruction Dataset
      ↓
Fine-Tuning
      ↓
Instruction-Following Model
```

---

## 28. Alignment

Alignment aims to make model behavior more useful, safe and consistent with desired preferences.

Common concepts:

```text
RLHF
DPO
Preference Optimization
Safety Training
```

Simplified:

```text
Pretraining
     ↓
Instruction Tuning
     ↓
Preference / Alignment Training
     ↓
Aligned Model
```

---

## 29. Training vs Inference

| Training                 | Inference                           |
| ------------------------ | ----------------------------------- |
| Updates parameters       | Normally does not update parameters |
| Requires backpropagation | Mainly forward computation          |
| Uses optimizer           | Uses decoding/sampling              |
| High compute requirement | Usually cheaper per request         |
| Learns from data         | Generates predictions               |

---

## 30. Why Training is Expensive

Large-scale LLM training requires:

```text
Huge Dataset
+
Large Model
+
Many Matrix Operations
+
Large GPU Memory
+
Many Training Steps
+
Distributed Infrastructure
```

Therefore cost comes from:

```text
Compute
+
Memory
+
Storage
+
Networking
+
Electricity
+
Engineering Infrastructure
```

---

## 31. Simple Training Loop

```python
for batch in dataset:

    output = model(batch)

    loss = calculate_loss(
        output,
        batch.target
    )

    optimizer.zero_grad()

    loss.backward()

    optimizer.step()
```

Conceptually:

```text
Forward
 ↓
Loss
 ↓
Backward
 ↓
Update
 ↓
Repeat
```

---

## 32. What Happens to Parameters?

Suppose a parameter is:

```text
θ = 0.50
```

Gradient:

```text
∇L = 0.20
```

Learning rate:

```text
η = 0.01
```

Simplified gradient descent:

```text
θ_new
= 0.50 - (0.01 × 0.20)
= 0.498
```

The real optimizer may use additional state and transformations, but the core idea is the same.

---

## 33. Training Data Quality

Bad data can negatively affect model quality.

```text
Low-quality data
      ↓
Poor training signal
      ↓
Poor model behavior
```

Important preprocessing:

```text
Deduplication
Filtering
Quality scoring
Language filtering
PII/safety filtering
Contamination checks
```

---

## 34. Data Contamination

Data contamination occurs when evaluation/test information is present in training data.

Example:

```text
Training Data
     +
Test Question
     ↓
Model already encountered test content
```

Then evaluation may overestimate generalization.

Therefore benchmark contamination should be considered when interpreting results.

---

## 35. Perplexity

**Perplexity** is a common language-model evaluation metric related to average token prediction uncertainty.

Conceptually:

```text
Lower Perplexity
      ↓
Better next-token prediction
```

For average negative log-likelihood:

```text
PPL = exp(average NLL)
```

Perplexity is useful for language-model evaluation, but lower perplexity does not automatically mean better instruction following, safety or real-world usefulness.

---

## 36. Training Mental Model

```text
Data
 ↓
Tokens
 ↓
Transformer
 ↓
Prediction
 ↓
Loss
 ↓
Gradient
 ↓
Optimizer
 ↓
Parameter Update
 ↓
Repeat billions/trillions of times
```

---

## 37. Most Important Terms

```text
Pretraining
Next-token prediction
Tokenization
Parameters
Loss
Cross-Entropy
Backpropagation
Gradient Descent
Learning Rate
Batch
Iteration
Epoch
Optimizer
GPU
Mixed Precision
Checkpoint
Distributed Training
Fine-Tuning
Instruction Tuning
Alignment
Perplexity
```

---

## 38. Common Interview Questions

### How is an LLM trained?

> Typically through large-scale next-token prediction, where cross-entropy loss is computed and backpropagation plus an optimizer update the model parameters.

### What is backpropagation?

> The process of calculating gradients of the loss with respect to model parameters using the chain rule.

### Backpropagation vs gradient descent?

> Backpropagation computes gradients; gradient-based optimization uses those gradients to update parameters.

### What is an epoch?

> One complete pass through the training dataset.

### What is a batch?

> A group of training examples processed together.

### What is an iteration?

> One training step, typically corresponding to one batch and one parameter update.

### Why GPUs?

> LLM training consists heavily of parallel matrix operations, which GPUs execute efficiently.

### Why mixed precision?

> To reduce memory usage and accelerate computation while maintaining sufficient numerical stability.

### Why distributed training?

> Very large models and datasets may require more compute and memory than one GPU can provide.

### What is pretraining?

> Training a general-purpose base model on large-scale data, commonly using next-token prediction.

### What is fine-tuning?

> Further training of a pretrained model on a specialized dataset to adapt its behavior or capabilities.

### What is perplexity?

> A metric derived from the model's likelihood of the observed tokens; lower values generally indicate better next-token predictive performance on the evaluated data.

---

## 39. One-Line Revision

> **LLM Training = Tokenized data → Transformer → Next-token prediction → Loss → Backpropagation → Optimizer → Parameter update → Repeat at massive scale.**

```
```
