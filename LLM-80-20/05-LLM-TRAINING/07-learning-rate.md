### `05-LLM-TRAINING/07-learning-rate-and-schedulers.md`

````md id="3y8r2p"
# Learning Rate and Schedulers

## 1. What is Learning Rate?

The **learning rate (LR)** controls how much the model's parameters change during each optimizer update.

```text
New Weight = Old Weight - Learning Rate × Gradient
````

Example:

```text
Learning rate = 0.001
```

A larger LR makes bigger updates; a smaller LR makes smaller updates.

---

## 2. Why is Learning Rate Important?

### Too Large

```text
Loss
 ↓
2.0
 ↓
5.0
 ↓
10.0
```

Training can become unstable or diverge.

### Too Small

```text
Loss
 ↓
2.00
 ↓
1.99
 ↓
1.98
```

Training becomes very slow.

### Good Learning Rate

The model gradually moves toward a lower-loss solution.

```text
Loss ↓↓↓
```

---

## 3. What is a Learning Rate Scheduler?

A **learning rate scheduler changes the learning rate during training**.

Instead of keeping:

```text
LR = 0.001
```

for the entire training process, it may gradually reduce it.

```text
Training Start
LR = 0.001
      ↓
LR = 0.0005
      ↓
LR = 0.0001
      ↓
Training End
```

---

## 4. Why Reduce the Learning Rate?

At the beginning:

```text
Large steps → Learn quickly
```

Later:

```text
Smaller steps → Fine-tune the parameters
```

This can make optimization more stable.

---

## 5. Common Schedulers

### Step Decay

Reduce LR after a fixed number of epochs.

```text
0.001 → 0.0001 → 0.00001
```

### Cosine Decay

Learning rate gradually follows a cosine-shaped schedule.

Common in modern deep-learning training.

### Warmup

Start with a small LR and gradually increase it.

```text
Small LR
   ↓
Increase
   ↓
Peak LR
   ↓
Decay
```

Warmup is especially useful in large Transformer/LLM training.

---

## 6. Practical PyTorch Example

```python
optimizer = torch.optim.AdamW(
    model.parameters(),
    lr=1e-4
)

scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(
    optimizer,
    T_max=100
)

for epoch in range(100):

    train_model()

    optimizer.step()
    scheduler.step()
```

The scheduler changes the learning rate according to the selected schedule.

---

## 7. Learning Rate in LLM Training

LLM training commonly uses carefully designed schedules such as:

```text
Warmup
   ↓
Peak Learning Rate
   ↓
Learning Rate Decay
```

This is important because LLMs have **billions of parameters**, so unstable updates can make training extremely expensive or fail completely.

---

## 8. Industry Usage

Learning-rate scheduling is important when:

* Training Transformers
* Pretraining LLMs
* Fine-tuning models
* Training large neural networks
* Stabilizing optimization

Developers monitor:

```text
Learning Rate
Loss
Gradient Norm
Validation Performance
```

to determine whether training is behaving correctly.

---

## GATE / Interview Points

* Learning rate controls parameter update size.
* Too high → unstable/diverging training.
* Too low → very slow training.
* Scheduler changes LR during training.
* Warmup gradually increases LR at the beginning.
* Decay gradually reduces LR later.
* `AdamW` is commonly used for Transformer training.

---

## Mental Model

> **Learning Rate = How big a step should the model take while learning?**
>
> **Scheduler = How should that step size change during training?**

```

Next: `08-adam-and-adamw.md`
```
