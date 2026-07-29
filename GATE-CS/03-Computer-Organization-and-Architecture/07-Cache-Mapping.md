# Cache Mapping

## Definition

**Cache Mapping** is the technique used to determine **where a particular block of Main Memory will be placed inside the Cache Memory**.

In simple words,

> Cache Mapping is the set of rules that decides **which cache line should store a particular memory block.**

Since **Cache Memory is much smaller than Main Memory**, it is impossible to store every memory block inside the cache simultaneously. Therefore, the processor needs an efficient method to decide where each memory block should be placed.

This method is called **Cache Mapping**.

---

## Real-World Example

Imagine a library with **10,000 books** but only **100 study desks**.

Students cannot keep all books on the desks because there isn't enough space.

Whenever a student needs a book, the librarian places that book on one of the available desks.

Now the librarian must answer two questions:

1. Which desk should the book be placed on?
2. If the desk is already occupied, which book should be removed?

These are exactly the problems solved by Cache Mapping.

```
Library (Main Memory)

10,000 Books

↓

Librarian (Cache Mapping)

↓

100 Study Desks (Cache)
```

The **books** represent **Memory Blocks**, and the **study desks** represent **Cache Lines**.

---

## Why Was Cache Mapping Needed?

Suppose a computer has

```
Main Memory = 16 GB

Cache Memory = 8 MB
```

The cache can hold only a very small fraction of the data stored in RAM.

Now imagine the CPU wants to access memory block **1250**.

Where should this block be stored in the cache?

Possible answers are

- Cache Line 0
- Cache Line 100
- Cache Line 350
- Cache Line 800

Without a placement rule, every memory access would require searching the entire cache.

That would be extremely slow and would defeat the purpose of having cache.

Cache Mapping provides a fixed strategy so that the processor can locate data quickly.

---

# The Fundamental Problem

Consider

```
Main Memory

1024 Blocks
```

```
Cache

64 Lines
```

Since

```
1024 > 64
```

many different memory blocks must share the same cache lines.

Example

```
Memory Block 0

↓

Cache Line ?
```

```
Memory Block 64

↓

Cache Line ?
```

```
Memory Block 128

↓

Cache Line ?
```

The processor must decide

- Which line to use
- How to find the block later
- What to replace if the line is occupied

These three questions form the basis of Cache Mapping.

---

# Prerequisites

Before learning cache mapping, you must understand four terms.

1. Memory Block
2. Cache Line
3. Tag
4. Address

Without these concepts, cache mapping numericals become confusing.

---

# What is a Memory Block?

## Definition

A **Memory Block** is a fixed-size group of consecutive bytes transferred between Main Memory and Cache Memory.

The CPU never transfers one byte at a time.

Instead, it transfers an entire block.

---

## Why Transfer Blocks Instead of Bytes?

Suppose the CPU accesses

```
Address 200
```

Due to **Spatial Locality**, it is highly likely that addresses

```
201

202

203
```

will also be accessed soon.

Instead of transferring one byte,

the processor transfers an entire block.

Example

```
Block Size = 16 Bytes

Addresses

200

201

202

...

215
```

All sixteen bytes are copied into the cache together.

This reduces future memory accesses.

---

## Real-World Example

Suppose you go to the supermarket to buy a bottle of water.

While you're there, you also buy bread, milk, eggs, and vegetables.

Why?

Because making one trip for every single item wastes time.

Similarly,

the processor fetches an entire memory block instead of one byte to reduce repeated trips to RAM.

---

# What is a Cache Line?

## Definition

A **Cache Line** is the smallest storage unit inside Cache Memory that stores exactly one Memory Block.

One cache line contains

- Data Block
- Tag
- Valid Bit
- (Sometimes Dirty Bit)

Example

```
+------------------------------------------+
| Tag | Valid | Dirty | Data Block        |
+------------------------------------------+
```

The data block contains the actual bytes copied from RAM.

---

## Why is it Called a Cache Line?

Historically, cache memory was organized into rows.

Each row stored one block of data.

These rows became known as **Cache Lines**.

Therefore,

```
Memory Block

↓

Stored Inside

↓

Cache Line
```

One cache line stores one memory block at a time.

---

# Memory Block vs Cache Line

Students often confuse these terms.

Remember

A **Memory Block** belongs to **Main Memory**.

A **Cache Line** belongs to **Cache Memory**.

Example

```
Main Memory

Block 25

↓

Copied Into

↓

Cache Line 6
```

They have the same size but exist in different memories.

---

# Block Size

The **Block Size** is the amount of data transferred between Main Memory and Cache in one operation.

Example

```
Block Size = 64 Bytes
```

Whenever the processor requests one byte from this block,

the entire 64-byte block is loaded into cache.

---

## Why Large Block Size Helps

Suppose block size is

```
1 Byte
```

The processor must access RAM repeatedly.

Now suppose

```
64 Bytes
```

Only one RAM access is required.

Future accesses become cache hits.

---

## Why Not Make the Block Very Large?

Suppose

```
Block Size = 4 KB
```

Problems

- Wasted cache space
- Longer transfer time
- Increased miss penalty
- Fewer cache lines

Therefore,

computer architects choose an optimal block size.

Modern processors commonly use cache lines of **64 Bytes**.

---

# Relationship Between Memory Blocks and Cache Lines

Example

```
Main Memory

16 Blocks

↓

Cache

4 Lines
```

```
Main Memory

Block 0

↓

Cache Line ?

Block 1

↓

Cache Line ?

Block 2

↓

Cache Line ?

...
```

Different cache mapping techniques decide where each block will be stored.

That is exactly what we will study next.

---

# Cache Address

Every byte in Main Memory has a unique address.

Suppose the CPU requests

```
Address = 100100110101₂
```

The cache does not use this address directly.

Instead, it divides the address into multiple fields.

Generally,

```
Address

↓

Tag

↓

Index

↓

Offset
```

Each field has a different purpose.

This division allows the processor to locate data quickly.

---

# Byte Offset (Block Offset)

## Definition

The **Offset** identifies the exact byte inside a memory block.

Suppose

```
Block Size = 16 Bytes
```

Then

```
2⁴ = 16
```

So,

```
Offset Bits = 4
```

These 4 bits identify which byte within the block is required.

Example

```
Offset

0000 → Byte 0

0001 → Byte 1

...

1111 → Byte 15
```

---

# Why is Offset Needed?

Suppose the cache already contains

```
Block

1000–1015
```

Now the CPU requests

```
Address 1007
```

The processor already knows which block is present.

It now needs to identify **which byte inside that block** should be read.

The Offset field provides this information.

---

# GATE Tip

Always calculate Offset bits first.

```
Offset Bits

=

log₂(Block Size in Bytes)
```

This is the first step in almost every cache numerical.

---

# Common Mistakes

❌ Confusing Memory Block with Cache Line.

❌ Assuming one cache line stores multiple blocks.

❌ Forgetting that Block Size is measured in **Bytes**, not Bits.

❌ Ignoring the Offset while solving address format questions.

❌ Assuming the CPU transfers only one byte from RAM.

---

# Next Section

**Direct Mapping**

We will learn:

- How memory blocks are assigned to cache lines.
- Address format (Tag | Index | Offset).
- Mapping formula.
- Complete GATE numericals.
- Hardware implementation.
- Advantages and disadvantages.