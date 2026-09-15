# `08-CPU-Scheduling.md`

# CPU Scheduling — GATE CSE 2027

## 1. What is CPU Scheduling?

**CPU scheduling** decides **which ready process/thread gets the CPU next**.

```text
Ready Queue
    ↓
 CPU Scheduler
    ↓
 Selected Process
    ↓
   CPU
```

> **CPU scheduling = selecting the next process for execution.**

---

# 2. Why CPU Scheduling?

Suppose:

```text
P1 → waiting for I/O
P2 → Ready
P3 → Ready
```

Instead of keeping CPU idle:

```text
CPU → P2
```

The objective is to keep the CPU and system resources efficiently utilized.

---

# 3. Important Scheduling Terms ⭐⭐⭐⭐⭐

## Arrival Time (AT)

Time at which a process enters the ready queue.

## Burst Time (BT)

Amount of CPU time required by the process.

## Completion Time (CT)

Time at which process finishes execution.

## Turnaround Time (TAT)

Total time from arrival until completion.

$$
\boxed{TAT=CT-AT}
$$

## Waiting Time (WT)

Time spent waiting in the ready queue.

$$
\boxed{WT=TAT-BT}
$$

Therefore:

$$
\boxed{WT=CT-AT-BT}
$$

## Response Time (RT)

Time from arrival until the process gets the CPU **for the first time**.

$$
\boxed{RT=First\ Start\ Time-AT}
$$

---

# 4. The Most Important Formula Set 🔥

Memorize:

$$
\boxed{TAT=CT-AT}
$$

$$
\boxed{WT=TAT-BT}
$$

Therefore:

$$
\boxed{WT=CT-AT-BT}
$$

And:

$$
\boxed{RT=First\ CPU\ Start-AT}
$$

### 🔥 GATE Trap

Waiting time and response time are **not the same**.

---

# 5. Example

Process:

```text
AT = 2
BT = 5
CT = 10
```

Turnaround:

$$
TAT=10-2=8
$$

Waiting:

$$
WT=8-5=3
$$

If first execution begins at time 4:

$$
RT=4-2=2
$$

Therefore:

```text
TAT = 8
WT  = 3
RT  = 2
```

---

# 6. Preemptive vs Non-Preemptive ⭐⭐⭐⭐⭐

## Non-Preemptive

Once a process gets the CPU, it keeps it until:

* completion
* blocking/I/O
* voluntary release

Examples:

```text
FCFS
Non-preemptive SJF
Non-preemptive Priority
```

---

## Preemptive

OS can forcibly take CPU from a running process.

Examples:

```text
Round Robin
SRTF
Preemptive Priority
```

### 🔥 Shortcut

```text
Preemptive → CPU can be taken away
Non-preemptive → process keeps CPU
```

---

# 7. FCFS — First Come First Serve ⭐⭐⭐⭐⭐

Processes execute according to arrival order.

Example:

```text
P1 → P2 → P3
```

If all arrive at time 0:

```text
P1 BT=5
P2 BT=3
P3 BT=2
```

Gantt chart:

```text
0    5    8    10
| P1 | P2 | P3 |
```

Completion times:

```text
P1 = 5
P2 = 8
P3 = 10
```

Waiting times:

```text
P1 = 0
P2 = 5
P3 = 8
```

Average WT:

$$
\frac{0+5+8}{3}
=
\boxed{\frac{13}{3}}
$$

---

# 8. FCFS Properties

### Advantages

* Simple
* Easy to implement
* Fair in arrival order

### Disadvantage

Can suffer from:

$$
\boxed{\text{Convoy Effect}}
$$

---

# 9. Convoy Effect ⭐⭐⭐⭐⭐

A long CPU-bound process can make many short processes wait behind it.

Example:

```text
P1 = 100 ms
P2 = 2 ms
P3 = 2 ms
P4 = 2 ms
```

FCFS:

```text
P1 → P2 → P3 → P4
```

Short processes suffer huge waiting times.

### Memory trick

> **Long process + FCFS = convoy**

---

# 10. SJF — Shortest Job First ⭐⭐⭐⭐⭐

Select the process with the **smallest CPU burst time**.

Example:

```text
P1 = 8
P2 = 4
P3 = 2
```

Order:

```text
P3 → P2 → P1
```

### Key property

If all burst times are known, **non-preemptive SJF minimizes average waiting time** among the available jobs under the usual assumptions.

### 🔥 GATE Favorite

> SJF gives minimum average waiting time.

---

# 11. SJF Problem

The OS usually does not know the exact future CPU burst time.

Therefore it estimates the next burst.

A common exponential averaging formula is:

$$
\boxed{\tau_{n+1}=\alpha t_n+(1-\alpha)\tau_n}
$$

where:

* \(t_n\) = actual previous CPU burst
* \(\tau_n\) = previous predicted burst
* \(\alpha\in[0,1]\)

---

# 12. SRTF — Shortest Remaining Time First ⭐⭐⭐⭐⭐

SRTF is the **preemptive version of SJF**.

At every relevant arrival/comparison:

> Process with the smallest remaining CPU time gets the CPU.

Example:

```text
P1 starts
P2 arrives with shorter remaining time
        ↓
P1 preempted
P2 runs
```

### Shortcut

```text
SJF  → shortest burst
SRTF → shortest remaining burst
```

---

# 13. Priority Scheduling ⭐⭐⭐⭐⭐

Each process has a priority.

CPU goes to the highest-priority process according to the system's convention.

### Important

Some systems define:

```text
smaller number = higher priority
```

Others may use:

```text
larger number = higher priority
```

### 🔥 GATE Trap

Always check the question's priority convention.

---

# 14. Starvation in Priority Scheduling

Suppose high-priority processes continuously arrive:

```text
P1 low priority → waiting
P2 high → runs
P3 high → runs
P4 high → runs
...
```

P1 may wait indefinitely.

$$
\boxed{\text{Starvation}}
$$

---

# 15. Aging ⭐⭐⭐⭐⭐

**Aging** gradually increases the priority of a waiting process.

```text
Waiting longer
      ↓
Priority increases
      ↓
Eventually gets CPU
```

### Purpose

$$
\boxed{\text{Prevent starvation}}
$$

### 🔥 GATE Shortcut

```text
Starvation → Aging
```

---

# 16. Round Robin ⭐⭐⭐⭐⭐

Round Robin (RR) is a **preemptive** scheduling algorithm.

Each process gets a fixed:

$$
\boxed{\text{Time Quantum}}
$$

Example:

```text
Quantum = 2
```

Processes:

```text
P1 = 5
P2 = 3
P3 = 2
```

Possible schedule:

```text
0  2  4  6  8  9  10
|P1|P2|P3|P1|P2|P1|
```

---

# 17. Time Quantum Effect ⭐⭐⭐⭐⭐

### Very large quantum

Round Robin approaches:

$$
\boxed{FCFS}
$$

### Very small quantum

More frequent context switching.

Therefore:

```text
Quantum ↑ → RR behaves more like FCFS
Quantum ↓ → more context-switch overhead
```

### 🔥 GATE Favorite

This relationship is frequently tested conceptually.

---

# 18. Round Robin and Response Time

RR is particularly suitable for **interactive/time-sharing systems** because each ready process gets CPU periodically.

It generally provides good response behavior compared with FCFS.

---

# 19. Multilevel Queue Scheduling ⭐⭐⭐⭐

Ready queue is divided into separate queues.

Example:

```text
System Processes
Interactive Processes
Batch Processes
```

Each queue may use a different scheduling algorithm.

```text
Queue 1 → RR
Queue 2 → FCFS
Queue 3 → FCFS
```

Queues may also have fixed priorities.

---

# 20. Multilevel Feedback Queue — MLFQ ⭐⭐⭐⭐⭐

Unlike multilevel queue, processes can **move between queues**.

```text
High priority
     ↓
   Q0 (small quantum)
     ↓
   Q1 (larger quantum)
     ↓
   Q2 (FCFS)
```

A process using too much CPU may move down.

A waiting process may be promoted.

### Advantage

Can balance:

* response time
* throughput
* starvation prevention

### 🔥 Difference

```text
Multilevel Queue
→ fixed queue assignment

MLFQ
→ processes can move between queues
```

---

# 21. Scheduling Algorithm Comparison

| Algorithm   | Preemptive? | Main idea                  |                            Starvation? |
| ----------- | ----------: | -------------------------- | -------------------------------------: |
| FCFS        |          No | Arrival order              |                             Usually no |
| SJF         |          No | Shortest burst             |                          Yes, possible |
| SRTF        |         Yes | Shortest remaining         |                          Yes, possible |
| Priority    |      Either | Highest priority           |                                    Yes |
| Round Robin |         Yes | Time quantum               | Generally designed to avoid starvation |
| MLFQ        |         Yes | Multiple queues + feedback |                      Depends on policy |

---

# 22. Throughput ⭐⭐⭐⭐

**Throughput** = number of processes completed per unit time.

$$
\boxed{
Throughput=
\frac{\text{Number of completed processes}}
{\text{Total elapsed time}}
}
$$

Higher throughput is generally desirable.

---

# 23. CPU Utilization

Percentage of time CPU is busy.

$$
\boxed{
CPU\ Utilization=
\frac{CPU\ Busy\ Time}{Total\ Time}\times100
}
$$

Higher utilization is generally desirable.

---

# 24. Scheduling Goals ⭐⭐⭐⭐⭐

Common objectives:

### Maximize

```text
CPU utilization
Throughput
```

### Minimize

```text
Turnaround time
Waiting time
Response time
```

### Important

Different scheduling algorithms optimize different objectives.

---

# 25. Gantt Chart — GATE Numerical Method ⭐⭐⭐⭐⭐

Whenever scheduling information is given:

### Step 1

Write:

```text
Process | AT | BT | Priority
```

### Step 2

Draw Gantt chart.

### Step 3

Calculate:

$$
CT
$$

### Step 4

Calculate:

$$
TAT=CT-AT
$$

### Step 5

Calculate:

$$
WT=TAT-BT
$$

### Step 6

Calculate:

$$
RT=FirstStart-AT
$$

### Step 7

Take averages if required.

---

# 26. Example — FCFS Numerical

Processes:

| Process | AT | BT |
| ------- | -: | -: |
| P1      |  0 |  5 |
| P2      |  1 |  3 |
| P3      |  2 |  2 |

FCFS:

```text
0      5      8      10
|  P1  |  P2  | P3  |
```

### Completion

```text
P1 = 5
P2 = 8
P3 = 10
```

### TAT

$$
P1=5-0=5
$$

$$
P2=8-1=7
$$

$$
P3=10-2=8
$$

### WT

$$
P1=5-5=0
$$

$$
P2=7-3=4
$$

$$
P3=8-2=6
$$

Average waiting:

$$
\frac{0+4+6}{3}
=
\boxed{\frac{10}{3}}
$$

---

# 27. Important Identity ⭐⭐⭐⭐⭐

For every process:

$$
\boxed{TAT=WT+BT}
$$

assuming waiting time excludes CPU execution time.

Thus:

$$
\boxed{WT=TAT-BT}
$$

This is one of the easiest marks in GATE numericals.

---

# 28. CPU Idle Time

Suppose no process is available.

Then:

```text
CPU → IDLE
```

Example:

```text
P1 arrives at 3
```

CPU:

```text
0    3
| IDLE |
```

Then P1 starts at 3.

### 🔥 GATE Trap

Do **not** assume the first process starts at time 0 if its arrival time is later.

---

# 29. Context Switch Overhead

Suppose:

```text
P1 → context switch → P2
```

If context-switch time is \(C\):

```text
P1 | CS | P2
```

That overhead consumes CPU time but does not contribute to process burst execution.

### 🔥 GATE Trap

If context-switch overhead is given, **include it in the Gantt chart**.

---

# 30. SJF vs SRTF

| SJF                                | SRTF                            |
| ---------------------------------- | ------------------------------- |
| Non-preemptive                     | Preemptive                      |
| Chooses shortest burst             | Chooses shortest remaining time |
| Running process normally continues | Can be preempted                |
| May have starvation                | May have starvation             |

---

# 31. FCFS vs Round Robin

| FCFS            | RR                          |
| --------------- | --------------------------- |
| Non-preemptive  | Preemptive                  |
| Arrival order   | Circular ready queue        |
| No time quantum | Fixed time quantum          |
| Convoy effect   | Better interactive response |
| Simple          | Context-switch overhead     |

---

# 32. GATE PYQ Pattern — Time Quantum

Question:

> If the time quantum in Round Robin is made very large, what does RR approach?

$$
\boxed{FCFS}
$$

If quantum becomes extremely small:

> Context-switch overhead becomes significant.

---

# 33. GATE PYQ Pattern — SJF

Question:

> Which scheduling algorithm minimizes average waiting time when all jobs are available and burst times are known?

$$
\boxed{\text{SJF}}
$$

### 🔥 Qualification

This statement is under the standard scheduling assumptions.

---

# 34. GATE PYQ Pattern — Aging

Question:

> Which technique prevents starvation in priority scheduling?

$$
\boxed{\text{Aging}}
$$

---

# 35. GATE PYQ Pattern — Waiting Time

Given:

```text
AT = 2
BT = 7
CT = 15
```

Then:

$$
TAT=15-2=13
$$

$$
WT=13-7=\boxed{6}
$$

---

# 36. GATE PYQ Pattern — Response Time

If:

```text
AT = 4
First execution = 9
```

then:

$$
RT=9-4
$$

$$
\boxed{5}
$$

### 🔥 Trap

Response time uses **first CPU allocation**, not completion.

---

# 37. GATE PYQ Pattern — Preemption

Suppose P1 is running:

```text
P1 BT = 10
```

At time 3, P2 arrives with shorter remaining time.

Under SRTF:

```text
P1 → preempted
P2 → executes
```

Under non-preemptive SJF:

```text
P1 → continues
P2 → waits
```

---

# 38. GATE PYQ Pattern — Convoy Effect

Question:

> A long CPU-bound process delays many short processes under FCFS. What phenomenon is this?

$$
\boxed{\text{Convoy Effect}}
$$

---

# 39. GATE PYQ Pattern — CPU Utilization

Suppose CPU is busy for:

$$
90\text{ ms}
$$

during:

$$
100\text{ ms}
$$

Then:

$$
CPU\ Utilization
=
\frac{90}{100}\times100
$$

$$
\boxed{90\%}
$$

---

# 🔥 GATE Traps

### Trap 1

```text
Waiting Time = Turnaround Time
```

❌

$$
WT=TAT-BT
$$

---

### Trap 2

```text
Response Time = Turnaround Time
```

❌ Response time ends at **first execution**, not completion.

---

### Trap 3

> SJF is always preemptive.

❌ SJF is classically **non-preemptive**.

Preemptive version:

$$
\boxed{SRTF}
$$

---

### Trap 4

> Round Robin is non-preemptive.

❌ RR is preemptive.

---

### Trap 5

> Very small quantum always improves performance.

❌ Context-switch overhead can become large.

---

### Trap 6

> Very large RR quantum gives a completely different scheduling behavior.

❌ It approaches FCFS.

---

### Trap 7

> Aging increases CPU burst.

❌ Aging increases **priority** of waiting processes.

---

### Trap 8

> MLFQ and Multilevel Queue are identical.

❌ MLFQ allows movement between queues.

---

### Trap 9

> CPU always starts at time 0.

❌ Not if no process has arrived.

---

### Trap 10

> Context-switch time is part of process burst time.

❌ It is scheduling overhead unless the question defines it otherwise.

---

# 🎯 GATE Priority

| Topic                         | Priority |
| ----------------------------- | -------: |
| Gantt-chart numericals        |    ⭐⭐⭐⭐⭐ |
| FCFS                          |    ⭐⭐⭐⭐⭐ |
| SJF                           |    ⭐⭐⭐⭐⭐ |
| SRTF                          |    ⭐⭐⭐⭐⭐ |
| Round Robin                   |    ⭐⭐⭐⭐⭐ |
| Waiting/TAT/Response formulas |    ⭐⭐⭐⭐⭐ |
| Priority scheduling           |    ⭐⭐⭐⭐⭐ |
| Aging/starvation              |    ⭐⭐⭐⭐⭐ |
| Context-switch overhead       |    ⭐⭐⭐⭐⭐ |
| Multilevel Queue              |      ⭐⭐⭐ |
| MLFQ                          |     ⭐⭐⭐⭐ |
| CPU utilization/throughput    |     ⭐⭐⭐⭐ |

---

# 🧠 GATE Mental Model

```text
                 CPU Scheduling
                       |
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
      FCFS            SJF          Priority
        |              |              |
    arrival         shortest       highest
      order          burst         priority
                       |
                      SRTF
                       |
               shortest remaining

                  Round Robin
                       |
                  Time Quantum

                   Starvation
                       |
                     Aging
```

For every numerical:

```text
AT + BT + Algorithm
       ↓
  Gantt Chart
       ↓
      CT
       ↓
TAT = CT - AT
       ↓
WT = TAT - BT
       ↓
RT = First Start - AT
```

---

# ⚡ 30-Second Revision

```text
CPU Scheduling:
→ choose next ready process

AT = Arrival Time
BT = Burst Time
CT = Completion Time

TAT = CT - AT
WT  = TAT - BT
WT  = CT - AT - BT
RT  = First Start - AT

FCFS:
→ arrival order
→ non-preemptive
→ convoy effect

SJF:
→ shortest burst
→ non-preemptive
→ minimum average waiting time
→ can cause starvation

SRTF:
→ preemptive SJF
→ shortest remaining time

Priority:
→ highest priority first
→ starvation possible
→ Aging prevents starvation

Round Robin:
→ preemptive
→ time quantum
→ large quantum → FCFS
→ tiny quantum → high context-switch overhead

MLQ:
→ fixed queue assignment

MLFQ:
→ processes can move between queues

Maximize:
→ CPU utilization
→ Throughput

Minimize:
→ Waiting time
→ Turnaround time
→ Response time
```

### ⭐ GATE Priority: **5/5**

## 🔥 The formulas you should know by heart

$$
\boxed{TAT=CT-AT}
$$

$$
\boxed{WT=TAT-BT}
$$

$$
\boxed{RT=First\ CPU\ Start-AT}
$$

And the algorithm mapping:

$$
\boxed{SJF\rightarrow shortest\ burst}
$$

$$
\boxed{SRTF\rightarrow shortest\ remaining}
$$

$$
\boxed{RR\rightarrow time\ quantum}
$$

$$
\boxed{Priority\ starvation\rightarrow Aging}
$$

➡️ **Next: `09-IO-Scheduling.md`**
