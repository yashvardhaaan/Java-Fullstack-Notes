### `05-LLM-TRAINING/06-batch-epoch-and-iteration.md`

````md
# Batch, Epoch and Iteration

## 1. What are They?

These terms describe **how training data is processed during model training**.

```text
Dataset
   ↓
Split into Batches
   ↓
Model Training
   ↓
Repeat for Epochs
````

---

## 2. Batch

A **batch** is a small group of training examples processed together.

Example:

```text
Dataset = 10,000 examples
Batch size = 100

1 batch → 100 examples
```

Why use batches?

* Full dataset may not fit in GPU memory.
* Parallel processing is faster.
* Gives more efficient GPU utilization.

---

## 3. Iteration / Step

One **iteration** (training step) means processing **one batch** and usually performing one optimizer update.

Example:

```text
Batch 1 → Forward → Loss → Backprop → Update
Batch 2 → Forward → Loss → Backprop → Update
Batch 3 → Forward → Loss → Backprop → Update
```

Each batch represents one training step.

---

## 4. Epoch

One **epoch** means the model has processed the entire training dataset once.

Example:

```text
Dataset = 10,000 examples
Batch size = 100

Iterations per epoch = 10,000 / 100
                     = 100
```

So:

```text
1 Epoch = 100 Iterations
```

If training runs for 3 epochs:

```text
100 × 3 = 300 iterations
```

---

## 5. How They Work Together

```text
                Dataset
                   ↓
        ┌────────────────────┐
        │ Batch 1 → Update   │
        │ Batch 2 → Update   │
        │ Batch 3 → Update   │
        │       ...          │
        │ Batch 100 → Update │
        └────────────────────┘
                   ↓
                1 Epoch
                   ↓
              Repeat again
```

---

## 6. Practical PyTorch Example

```python
for epoch in range(3):

    for batch in dataloader:

        output = model(batch)

        loss = loss_function(output, target)

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
```

Here:

```text
3 → Number of epochs
batch → Current batch
optimizer.step() → Parameter update
```

---

## 7. Why Batch Size Matters?

### Small Batch

```text
Less GPU memory
More updates
Can be noisier
```

### Large Batch

```text
More GPU memory
Fewer updates per epoch
Better GPU parallelism
```

The best batch size depends on the model, hardware, and training setup.

---

## 8. LLM Training

For large LLMs, training is usually measured in **tokens**, not just examples.

Example:

```text
Training data
     ↓
Millions/Billions/Trillions of tokens
     ↓
Batches of tokens
     ↓
Training steps
```

Large-scale LLM training may also use **gradient accumulation** when the desired effective batch size is too large to fit in GPU memory at once.

---

## 9. Industry Usage

These concepts are important when:

* Training an LLM
* Choosing GPU memory requirements
* Calculating training steps
* Monitoring training progress
* Tuning batch size
* Estimating training cost

---

## GATE / Interview Points

```text
Batch      → Group of training examples
Iteration  → One batch training step/update
Epoch      → One complete pass through dataset
```

For:

```text
N = Number of examples
B = Batch size
```

Approximately:

```text
Iterations per epoch = N / B
```

If `N` is not exactly divisible by `B`, the final smaller batch may also be processed depending on the DataLoader configuration.

---

## Mental Model

> **Batch = how much data at once, Iteration = one update, Epoch = one complete pass through the dataset.**

```

Next: `07-learning-rate-and-schedulers.md`
```
