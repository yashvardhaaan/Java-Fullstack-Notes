# `11-Virtual-Memory.md`

# Virtual Memory — GATE CSE 2027

## 1. What is Virtual Memory? ⭐⭐⭐⭐⭐

**Virtual memory** allows a process to execute even when its entire address space is **not present in physical RAM**.

> Only the required portions of a process need to be in RAM.

```text
Process
  ↓
Virtual Address Space
  ↓
Only required pages
  ↓
RAM
```

The remaining pages can stay on secondary storage.

---

# 2. Why Virtual Memory?

Without virtual memory:

```text
Entire process → RAM
```

With virtual memory:

```text
Large process
     ↓
Some pages → RAM
Some pages → Disk
```

### Benefits

* Run programs larger than available RAM
* Better multiprogramming
* Efficient RAM utilization
* Process isolation/protection

---

# 3. Demand Paging ⭐⭐⭐⭐⭐

In **demand paging**, a page is loaded into RAM **only when it is actually needed**.

Initially:

```text
Page 0 → RAM
Page 1 → Disk
Page 2 → Disk
Page 3 → RAM
```

If CPU references Page 2:

```text
Page 2 not in RAM
      ↓
Page Fault
      ↓
Load Page 2 from Disk
      ↓
Update Page Table
      ↓
Restart instruction
```

---

# 4. Page Fault ⭐⭐⭐⭐⭐

A **page fault** occurs when a process references a page that is not currently present in physical memory.

Page-table entry usually contains a:

$$
\boxed{\text{Valid/Present bit}}
$$

Example:

```text
Valid = 1 → page is in RAM
Valid = 0 → page is not in RAM
```

### 🔥 Important

Page fault is **not necessarily an error**.

It is a normal mechanism of virtual memory.

---

# 5. Page Fault Handling ⭐⭐⭐⭐⭐

When a page fault occurs:

```text
1. CPU references page
        ↓
2. Page not present
        ↓
3. Trap to OS
        ↓
4. Check whether reference is legal
        ↓
5. Find free frame
        ↓
6. If necessary, select victim page
        ↓
7. Read required page from disk
        ↓
8. Update page table
        ↓
9. Restart instruction
```

### 🔥 GATE Trap

> Page fault is handled by the **OS**, not directly by the user process.

---

# 6. Demand Paging vs Demand Segmentation

| Demand Paging         | Demand Segmentation      |
| --------------------- | ------------------------ |
| Loads pages on demand | Loads segments on demand |
| Fixed-size units      | Variable-size units      |
| Page fault            | Segment fault            |

For GATE, **demand paging + page replacement** is much more important.

---

# 7. Page Replacement ⭐⭐⭐⭐⭐

What happens if:

```text
Page fault occurs
+
No free frame exists?
```

The OS must remove one existing page.

That page is called the:

$$
\boxed{\text{Victim page}}
$$

Then:

```text
Victim page → Disk
Required page → RAM
```

---

# 8. Page Replacement Algorithms

Important algorithms:

1. FIFO
2. Optimal
3. LRU
4. Second Chance / Clock
5. LFU/MFU — lower priority

For GATE:

$$
\boxed{FIFO,\ Optimal,\ LRU}
$$

are the most important.

---

# 9. FIFO Page Replacement ⭐⭐⭐⭐⭐

**First In First Out**

Replace the page that entered memory first.

Think:

> **Oldest page leaves first.**

Example with 3 frames:

Reference:

```text
1 2 3 4
```

After:

```text
1 → [1]
2 → [1 2]
3 → [1 2 3]
4 → replace 1
```

Result:

```text
[4 2 3]
```

---

# 10. FIFO Queue Trick

Maintain a queue:

```text
Oldest → Newest

[1, 2, 3]
 ↑
victim
```

After replacing 1 with 4:

```text
[2, 3, 4]
```

Next victim:

$$
\boxed{2}
$$

---

# 11. Optimal Page Replacement ⭐⭐⭐⭐⭐

Replace the page whose **next use is farthest in the future**.

Example:

```text
Current:
[1, 2, 3]

Future references:
1 ... 2 ... 3
```

If:

```text
1 → used soon
2 → used later
3 → never used again
```

replace:

$$
\boxed{3}
$$

### Key fact

Optimal gives the **minimum possible number of page faults** for a given reference string and number of frames.

---

# 12. Why Optimal is Theoretical

The OS cannot know the exact future memory references of a program.

Therefore:

$$
\boxed{\text{Optimal is not practically implementable}}
$$

It is mainly used as a benchmark.

---

# 13. LRU ⭐⭐⭐⭐⭐

**Least Recently Used**

Replace the page that has **not been used for the longest time in the past**.

> Optimal looks into the **future**; LRU looks into the **past**.

Example:

```text
Pages:
[1, 2, 3]

Recent history:
... 1 2 1 3
```

If 2 was used least recently:

$$
\boxed{2\rightarrow victim}
$$

---

# 14. FIFO vs LRU vs Optimal

| Algorithm | Victim                      |
| --------- | --------------------------- |
| FIFO      | Oldest arrival              |
| Optimal   | Farthest future use         |
| LRU       | Longest time since last use |

### Memory trick

```text
FIFO → Arrival
LRU → Past
OPT → Future
```

---

# 15. Page Fault Calculation ⭐⭐⭐⭐⭐

Given:

```text
Reference string:
1 2 3 1 4 2
```

Frames:

$$
3
$$

Create a frame table:

```text
Reference | Frame contents | Fault?
```

For each reference:

1. Check whether page is already present.
2. If yes → **hit**
3. If no → **fault**
4. If frames full → apply replacement algorithm.

### 🔥 GATE Rule

**Never count a hit as a page fault.**

---

# 16. Example — FIFO

Reference string:

```text
1 2 3 1 4 2
```

Number of frames:

$$
3
$$

### Step-by-step

```text
1 → [1 - -]   F
2 → [1 2 -]   F
3 → [1 2 3]   F
1 → [1 2 3]   H
4 → [4 2 3]   F
2 → [4 2 3]   H
```

Total:

$$
\boxed{4\text{ page faults}}
$$

---

# 17. Belady's Anomaly ⭐⭐⭐⭐⭐🔥

Normally, increasing the number of frames should reduce page faults.

But with some algorithms:

$$
\boxed{\text{More frames can cause MORE page faults}}
$$

This is called:

$$
\boxed{\text{Belady's Anomaly}}
$$

### Classic case

FIFO can exhibit Belady's anomaly.

LRU and Optimal do **not**.

---

# 18. Stack Algorithms ⭐⭐⭐⭐⭐

A **stack algorithm** has the property that the pages present with \(n\) frames are always a subset of those present with \(n+1\) frames.

Therefore:

$$
\boxed{\text{No Belady's anomaly}}
$$

Examples:

* LRU
* Optimal

### 🔥 GATE shortcut

```text
FIFO → anomaly possible
LRU → no anomaly
Optimal → no anomaly
```

---

# 19. Second Chance Algorithm ⭐⭐⭐⭐

Second Chance is a modification of FIFO.

Each page has a:

$$
\boxed{\text{Reference bit}}
$$

Usually:

```text
R = 0 → replace it
R = 1 → give second chance
```

If \(R=1\):

```text
R ← 0
page moved/passed
```

Then inspect the next page.

---

# 20. Clock Algorithm ⭐⭐⭐⭐

Clock is an efficient implementation of Second Chance.

Pages are arranged circularly:

```text
        [P1]
      ↙      ↘
   [P4]      [P2]
      ↖      ↗
        [P3]
```

A pointer moves around the circle.

### Rule

```text
R = 0 → replace
R = 1 → set R=0 and move ahead
```

---

# 21. Reference Bit

The hardware may set the reference bit when a page is accessed.

```text
Page accessed
     ↓
Reference bit = 1
```

The OS can periodically clear it.

This helps approximate LRU.

---

# 22. Dirty / Modify Bit ⭐⭐⭐⭐⭐

A page can also have a **dirty bit**.

```text
Dirty = 0 → page unchanged
Dirty = 1 → page modified
```

If a dirty page is evicted:

$$
\boxed{\text{Must write it back to disk}}
$$

If clean:

$$
\boxed{\text{May discard it directly}}
$$

### 🔥 GATE Trap

> Every evicted page must be written to disk.

❌ No.

Only a modified/dirty page needs to be written back.

---

# 23. Page Table Entry Bits

A PTE may contain:

```text
+--------------------------------+
| Frame | Valid | Dirty | Ref | Protection |
+--------------------------------+
```

### Important:

| Bit           | Meaning                  |
| ------------- | ------------------------ |
| Valid/Present | Page currently in memory |
| Dirty         | Page modified            |
| Reference     | Page accessed            |
| Protection    | R/W/X permissions        |

---

# 24. Effective Access Time ⭐⭐⭐⭐⭐

Page faults are extremely expensive because disk/SSD access is much slower than RAM.

Suppose:

* Memory access time = \(M\)
* Page fault rate = \(p\)
* Page fault service time = \(F\)

Approximate:

$$
\boxed{
EAT=(1-p)M+pF
}
$$

If \(F\) includes the normal memory access appropriately, use the exact convention given in the question.

### 🔥 GATE

Even a **tiny page-fault probability** can significantly increase average access time because:

$$
F\gg M
$$

---

# 25. TLB ⭐⭐⭐⭐⭐

**Translation Lookaside Buffer (TLB)** is a small, fast cache storing recent page-table entries.

Purpose:

$$
\boxed{\text{Speed up virtual → physical address translation}}
$$

Without TLB:

```text
CPU
 ↓
Page Table
 ↓
Physical Memory
```

With TLB:

```text
CPU
 ↓
TLB
 ├── Hit → Frame found
 └── Miss → Page Table
```

---

# 26. TLB Hit

If required page-table entry is in TLB:

$$
\boxed{\text{TLB hit}}
$$

Translation is fast.

---

# 27. TLB Miss

If entry is not in TLB:

```text
TLB miss
 ↓
Access page table
 ↓
Obtain frame number
 ↓
Update TLB
 ↓
Access actual memory
```

### 🔥 GATE Trap

> TLB miss = page fault.

❌ Completely different.

```text
TLB miss → translation cache miss
Page fault → page not in RAM
```

---

# 28. TLB Hit Ratio ⭐⭐⭐⭐⭐

Let:

$$
h=\text{TLB hit ratio}
$$

Then:

$$
1-h=\text{TLB miss ratio}
$$

Suppose:

* TLB lookup = \(T\)
* Memory access = \(M\)

If TLB hit:

$$
T+M
$$

If TLB miss:

$$
T+M+M
$$

Therefore:

$$
\boxed{
EAT=h(T+M)+(1-h)(T+2M)
}
$$

Simplified:

$$
\boxed{EAT=T+(2-h)M}
$$

assuming one page-table memory access plus one actual memory access.

---

# 29. TLB + Page Fault

There are actually multiple possibilities:

```text
TLB Hit
  ↓
Page present → memory access
```

or:

```text
TLB Miss
  ↓
Page Table
  ↓
Present?
 ├── Yes → memory
 └── No → Page Fault
```

### 🔥 GATE

Keep these concepts separate:

$$
\boxed{TLB\ Miss\neq Page\ Fault}
$$

---

# 30. Demand Paging + TLB

Full process:

```text
Virtual Address
      ↓
   TLB lookup
      ↓
 ┌────┴─────┐
Hit        Miss
 ↓           ↓
Frame     Page Table
 ↓           ↓
Memory    Present?
          ┌──┴──┐
         Yes    No
          ↓      ↓
       Memory  Page Fault
```

---

# 31. Thrashing ⭐⭐⭐⭐⭐

**Thrashing** occurs when the system spends most of its time handling page faults rather than executing processes.

```text
Too few frames
      ↓
Many page faults
      ↓
More disk I/O
      ↓
Less CPU execution
      ↓
More page faults
```

Result:

$$
\boxed{\text{CPU utilization decreases}}
$$

---

# 32. Cause of Thrashing

Common cause:

$$
\boxed{\text{Insufficient frames}}
$$

especially when too many processes compete for memory.

---

# 33. Working Set ⭐⭐⭐⭐

A process's **working set** is the set of pages it is actively using during a recent time interval.

If a process receives enough frames for its working set:

$$
\boxed{\text{Page faults decrease}}
$$

If not:

$$
\boxed{\text{Thrashing may occur}}
$$

---

# 34. Local vs Global Page Replacement ⭐⭐⭐⭐

### Local Replacement

A process can replace only its own pages.

```text
P1 → P1 pages only
P2 → P2 pages only
```

### Global Replacement

A process can select a victim from pages belonging to other processes.

### 🔥 GATE

```text
Local → restricted to same process
Global → can use frames from other processes
```

---

# 35. Demand Paging vs Pre-Paging

### Demand Paging

Load page **only when referenced**.

### Pre-Paging

Load pages that are **expected to be needed** before they are referenced.

```text
Demand:
Reference → Load

Pre-page:
Predict → Load → Reference
```

Pre-paging can reduce page faults if prediction is good.

---

# 36. Page Replacement vs Page Allocation

Don't confuse:

### Page Replacement

**Which page should be removed?**

Examples:

* FIFO
* LRU
* Optimal

### Frame Allocation

**How many frames should each process receive?**

Examples:

* Equal allocation
* Proportional allocation

---

# 37. Equal Allocation

Suppose:

```text
Frames = 100
Processes = 4
```

Each process gets:

$$
\boxed{25}
$$

---

# 38. Proportional Allocation

Frames allocated according to process size.

If:

```text
P1 = 10 pages
P2 = 30 pages
```

Total:

$$
40
$$

If 80 frames are available:

$$
P1=\frac{10}{40}\times80=20
$$

$$
P2=\frac{30}{40}\times80=60
$$

---

# 39. Page Fault Frequency ⭐⭐⭐⭐

Page-fault frequency can be used to control frame allocation.

```text
High page-fault rate
       ↓
Give process more frames
```

```text
Low page-fault rate
       ↓
May reduce frames
```

Goal:

$$
\boxed{\text{Keep page faults within acceptable range}}
$$

---

# 40. GATE Numerical Strategy — Page Replacement ⭐⭐⭐⭐⭐

For a reference string:

### Step 1

Write frame rows.

### Step 2

Process references from left to right.

### Step 3

Mark:

```text
F = Fault
H = Hit
```

### Step 4

On fault with full frames, apply the specified algorithm.

### Step 5

Count only F.

### 🔥 Don't make this mistake

When replacing a page:

> The new page becomes the **most recent** page for LRU.

---

# 41. LRU Shortcut

For LRU, look backward from the current reference.

Among pages currently in memory:

> The one whose previous occurrence is **farthest back** is the victim.

If a page has never appeared before:

$$
\boxed{\text{Treat it as least recently used}}
$$

---

# 42. Optimal Shortcut

Look forward.

For each page currently in memory:

```text
When will it be used next?
```

* Never used again → best victim
* Otherwise → farthest next occurrence

---

# 43. FIFO Shortcut

Ignore how recently a page was used.

Only track:

$$
\boxed{\text{Arrival order}}
$$

A page can be accessed repeatedly and still be the next FIFO victim.

---

# 44. GATE PYQ Pattern — Belady's Anomaly ⭐⭐⭐⭐⭐

Question type:

> Which page replacement algorithm can exhibit Belady's anomaly?

Answer:

$$
\boxed{\text{FIFO}}
$$

### Important

Belady's anomaly means:

$$
Frames\uparrow \not\Rightarrow Faults\downarrow
$$

for FIFO.

---

# 45. GATE PYQ Pattern — Optimal

Question:

> Which replacement algorithm produces the minimum number of page faults for a known reference string?

$$
\boxed{\text{Optimal}}
$$

Reason:

It chooses the page whose next reference occurs farthest in the future.

---

# 46. GATE PYQ Pattern — Dirty Bit

Question:

> A page is removed from memory. When must it be written back to disk?

Answer:

$$
\boxed{\text{When the page is dirty/modified}}
$$

A clean page can generally be discarded without writing it back.

---

# 47. GATE PYQ Pattern — Thrashing

Question:

> A system has very high page-fault rate and very low CPU utilization. What is the likely problem?

$$
\boxed{\text{Thrashing}}
$$

---

# 48. GATE PYQ Pattern — TLB

Question:

> What is the main purpose of TLB?

$$
\boxed{\text{Cache page-table translations}}
$$

Not:

* caching ordinary data
* replacing the page table
* replacing RAM

---

# 49. GATE PYQ Pattern — TLB Miss vs Page Fault

```text
TLB miss
→ Entry not in TLB
→ Page may still be in RAM

Page fault
→ Page is not in RAM
```

Therefore:

$$
\boxed{\text{TLB miss does NOT imply page fault}}
$$

---

# 🔥 GATE Traps

### Trap 1

> Optimal uses the least recently used page.

❌ LRU does that.

---

### Trap 2

> LRU looks at future references.

❌ LRU looks at past references.

---

### Trap 3

> FIFO considers recent accesses.

❌ FIFO considers arrival order.

---

### Trap 4

> More frames always means fewer page faults.

❌ FIFO can exhibit Belady's anomaly.

---

### Trap 5

> LRU exhibits Belady's anomaly.

❌ LRU is a stack algorithm.

---

### Trap 6

> Page fault means invalid program.

❌ A page fault can be a normal demand-paging event.

---

### Trap 7

> TLB miss means page is absent from RAM.

❌ TLB only caches translations.

---

### Trap 8

> Every replaced page is written to disk.

❌ Only modified/dirty pages need write-back.

---

### Trap 9

> Thrashing means CPU is overloaded.

❌ Thrashing is primarily excessive paging/page faults.

---

### Trap 10

> Optimal is used in real OS page replacement.

❌ Exact future references are unknown.

---

# 🎯 GATE Priority

| Topic                 | Priority |
| --------------------- | -------: |
| Page Replacement      |    ⭐⭐⭐⭐⭐ |
| FIFO                  |    ⭐⭐⭐⭐⭐ |
| LRU                   |    ⭐⭐⭐⭐⭐ |
| Optimal               |    ⭐⭐⭐⭐⭐ |
| Belady's Anomaly      |    ⭐⭐⭐⭐⭐ |
| Page Fault Numericals |    ⭐⭐⭐⭐⭐ |
| TLB                   |    ⭐⭐⭐⭐⭐ |
| Effective Access Time |    ⭐⭐⭐⭐⭐ |
| Demand Paging         |    ⭐⭐⭐⭐⭐ |
| Thrashing             |    ⭐⭐⭐⭐⭐ |
| Working Set           |     ⭐⭐⭐⭐ |
| Second Chance/Clock   |     ⭐⭐⭐⭐ |
| Dirty/Reference bits  |    ⭐⭐⭐⭐⭐ |
| Frame Allocation      |     ⭐⭐⭐⭐ |
| Pre-paging            |      ⭐⭐⭐ |
| LFU/MFU               |       ⭐⭐ |

---

# 🧠 GATE Mental Model

```text
                 VIRTUAL MEMORY
                       |
              ┌────────┴────────┐
              ↓                 ↓
        Demand Paging        TLB
              |                 |
         Page Fault       Translation Cache
              |
       ┌──────┴──────┐
       ↓             ↓
 Free Frame       No Free Frame
                     |
               Page Replacement
                     |
        ┌────────────┼───────────┐
        ↓            ↓           ↓
      FIFO          LRU       Optimal
        |
   Belady possible
```

---

# ⚡ 30-Second Revision

```text
Virtual Memory:
→ Process need not be completely in RAM

Demand Paging:
→ Load page only when referenced

Page Fault:
→ Required page not in RAM

Page Replacement:
→ Needed when page fault + no free frame

FIFO:
→ Oldest page
→ Belady's anomaly possible

LRU:
→ Least recently used
→ No Belady anomaly

Optimal:
→ Farthest future use
→ Minimum possible faults
→ Not practically implementable

Second Chance:
→ FIFO + reference bit

Clock:
→ Circular Second Chance

Valid bit:
→ Is page in RAM?

Dirty bit:
→ Has page been modified?

Reference bit:
→ Has page been accessed?

TLB:
→ Cache of page-table entries

TLB miss ≠ Page fault

Thrashing:
→ Excessive page faults
→ CPU utilization falls

Working set:
→ Pages actively needed by process

Local replacement:
→ Victim from same process

Global replacement:
→ Victim can come from other processes
```

## 🔥 Absolute GATE Memorization

$$
\boxed{FIFO\rightarrow Belady\ possible}
$$

$$
\boxed{LRU,\ Optimal\rightarrow No\ Belady}
$$

$$
\boxed{Optimal\rightarrow Minimum\ page\ faults}
$$

$$
\boxed{TLB\rightarrow Translation\ cache}
$$

$$
\boxed{Dirty=1\rightarrow Write\ back\ on\ eviction}
$$

$$
\boxed{Too\ few\ frames\rightarrow Thrashing}
$$

### ⭐ GATE Priority: **5/5**

➡️ **Next: `12-File-Systems.md`**
