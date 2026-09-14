# 📘 Pumping Lemma — GATE CSE Notes

## 1. What is Pumping Lemma?

The **Pumping Lemma** gives a necessary property that every language in a particular class must satisfy.

For GATE, remember two versions:

1. **Pumping Lemma for Regular Languages**
2. **Pumping Lemma for Context-Free Languages (CFL)**

> ⚠️ Most GATE questions use Pumping Lemma to prove that a language is **NOT regular** or **NOT context-free**.

---

# 2. Pumping Lemma for Regular Languages

If `L` is regular, then there exists a constant `p` called the **pumping length** such that every string `w ∈ L` with

$$
|w|\ge p
$$

can be divided as:

$$
w=xyz
$$

such that:

### Conditions

$$
\boxed{|xy|\le p}
$$

$$
\boxed{|y|>0}
$$

$$
\boxed{xy^iz\in L \quad \forall i\ge0}
$$

### GATE Memory Trick

Remember:

> **R-PL = XYZ + First P + Y non-empty + Pump Y**

```text
        w = xyz
        ↓
      |xy| ≤ p
      |y| > 0
      xyⁱz ∈ L for every i ≥ 0
```

---

# 3. Most Important Trick

The condition

$$
|xy|\le p
$$

means that **x and y lie within the first p symbols**.

Therefore, you can control where `y` occurs.

### Example

Consider:

$$
L=\{a^nb^n:n\ge0\}
$$

Assume `L` is regular.

Choose:

$$
w=a^pb^p
$$

Since:

$$
|xy|\le p
$$

both `x` and `y` consist only of `a`s.

So:

$$
y=a^k,\quad k>0
$$

Pump down with `i=0`:

$$
xz=a^{p-k}b^p
$$

Clearly:

$$
p-k\ne p
$$

Therefore:

$$
xz\notin L
$$

Contradiction.

Hence:

$$
\boxed{L\text{ is not regular}}
$$

---

# 4. The Most Important GATE Rule

When proving **non-regularity**:

### Step 1

Assume:

$$
L\text{ is regular}
$$

### Step 2

Take pumping length `p`.

### Step 3

Choose a string `w ∈ L` with:

$$
|w|\ge p
$$

### Step 4

Use:

$$
w=xyz
$$

and **consider every valid decomposition** satisfying the lemma.

### Step 5

Choose a pumping value, usually:

$$
\boxed{i=0}
$$

or

$$
\boxed{i=2}
$$

### Step 6

Show:

$$
xy^iz\notin L
$$

### Step 7

Contradiction → language is not regular.

---

# 5. ⚠️ Biggest Pumping Lemma Trap

You **cannot choose `x,y,z` arbitrarily**.

For proving non-regularity:

> You must show that **for every valid decomposition**, some pumping value makes the string leave the language.

### Wrong reasoning ❌

> "Let `y = a^k`, therefore..."

without proving why `y` must consist of `a`s.

### Correct reasoning ✅

Because:

$$
|xy|\le p
$$

and the first `p` symbols are all `a`, therefore:

$$
y=a^k,\quad k>0
$$

---

# 6. Classic GATE Example

Consider:

$$
L=\{a^nb^n:n\ge0\}
$$

Choose:

$$
w=a^pb^p
$$

Since `y` occurs within first `p` characters:

$$
y=a^k
$$

where:

$$
k>0
$$

Pump:

$$
i=0
$$

Then:

$$
xy^0z=xz
$$

Number of `a`s becomes:

$$
p-k
$$

Number of `b`s remains:

$$
p
$$

So:

$$
xz=a^{p-k}b^p
$$

Therefore:

$$
xz\notin L
$$

Hence:

$$
\boxed{L\text{ is not regular}}
$$

---

# 7. Another Important Example

$$
L=\{a^nb^mc^n:n,m\ge0\}
$$

Assume regular.

Choose:

$$
w=a^pb^pc^p
$$

Since:

$$
|xy|\le p
$$

`y` contains only `a`s.

Thus:

$$
y=a^k
$$

Pump down:

$$
xz=a^{p-k}b^pc^p
$$

Now:

$$
\#a\ne\#c
$$

Therefore:

$$
xz\notin L
$$

Hence:

$$
\boxed{L\text{ is not regular}}
$$

---

# 8. When Pumping Lemma is NOT Useful

Very important:

### Pumping Lemma can prove:

$$
\boxed{\text{NOT Regular}}
$$

But satisfying the pumping lemma **does NOT prove regularity**.

So:

```text
Language satisfies Pumping Lemma
          ↓
      NOT enough
          ↓
Cannot conclude Regular
```

### GATE Trap

If a language satisfies the pumping lemma, it **may still be non-regular**.

For proving regularity, use:

* DFA/NFA
* Regular Expression
* Closure properties
* Myhill–Nerode
* Regular grammar

---

# 9. Pumping Lemma vs Myhill-Nerode

| Pumping Lemma                       | Myhill-Nerode                           |
| ----------------------------------- | --------------------------------------- |
| Mainly used to prove non-regularity | Can prove regularity AND non-regularity |
| Necessary condition                 | Exact characterization                  |
| Can become complicated              | Often cleaner                           |
| Choose pumping length               | Find distinguishable strings            |

### GATE Trick

If pumping lemma becomes messy, think:

$$
\boxed{\text{Myhill-Nerode}}
$$

---

# 10. Pumping Lemma for CFL

If `L` is context-free, there exists a pumping length `p` such that every sufficiently long string `z ∈ L` can be written as:

$$
\boxed{z=uvwxy}
$$

such that:

### Conditions

$$
|vwx|\le p
$$

$$
|vx|>0
$$

and:

$$
\boxed{uv^iwx^iy\in L\quad\forall i\ge0}
$$

### Memory Trick

Regular:

$$
\boxed{XYZ}
$$

CFL:

$$
\boxed{UVWXY}
$$

And:

```text
Regular → pump ONE piece: y
CFL     → pump TWO pieces: v and x
```

---

# 11. CFL Pumping Lemma Example

Consider:

$$
L=\{a^nb^nc^n:n\ge0\}
$$

Assume `L` is CFL.

Choose:

$$
z=a^pb^pc^p
$$

CFL pumping lemma gives:

$$
z=uvwxy
$$

with:

$$
|vwx|\le p
$$

Because each block has length `p`, `vwx` cannot cover all three blocks.

Therefore, `v` and `x` can affect at most **two adjacent regions**.

Pump using:

$$
i=0
$$

or:

$$
i=2
$$

The equality:

$$
\#a=\#b=\#c
$$

will be destroyed.

Therefore:

$$
\boxed{L\text{ is not CFL}}
$$

---

# 12. Super Important CFL Trick

For:

$$
a^nb^nc^n
$$

the key observation is:

$$
\boxed{|vwx|\le p}
$$

while each block has length `p`.

Therefore `vwx` cannot simultaneously contain:

```text
a's + b's + c's
```

This is one of the most common CFL pumping arguments.

---

# 13. Regular vs CFL Pumping Lemma

| Property            | Regular | CFL         |      |   |     |      |
| ------------------- | ------- | ----------- | ---- | - | --- | ---- |
| Decomposition       | `xyz`   | `uvwxy`     |      |   |     |      |
| Pumped parts        | `y`     | `v` and `x` |      |   |     |      |
| Main restriction    | `       | xy          | ≤ p` | ` | vwx | ≤ p` |
| Non-empty condition | `       | y           | > 0` | ` | vx  | > 0` |
| Pumping             | `xyⁱz`  | `uvⁱwxⁱy`   |      |   |     |      |

### One-line memory

$$
\boxed{\text{Regular: }XYZ}
$$

$$
\boxed{\text{CFL: }UVWXY}
$$

---

# 14. High-Yield Languages

### Usually prove NOT Regular

$$
\{a^nb^n\}
$$

$$
\{a^nb^na^n\}
$$

$$
\{ww:w\in\Sigma^*\}
$$

$$
\{a^nb^mc^n\}
$$

$$
\{0^n1^n\}
$$

---

### Usually prove NOT CFL

$$
\boxed{\{a^nb^nc^n:n\ge0\}}
$$

$$
\boxed{\{ww:n\ge0\}}
$$

$$
\boxed{\{a^ib^jc^k:i=j=k\}}
$$

$$
\boxed{\{a^nb^na^nb^n\}}
$$

---

# 15. GATE Question Pattern

### Type 1 — Find valid decomposition

Given:

$$
w=a^pb^p
$$

find possible `x,y,z`.

Use:

$$
|xy|\le p
$$

Therefore `y` must occur among first `p` symbols.

---

### Type 2 — Find pumping value

Usually test:

$$
\boxed{i=0}
$$

then:

$$
\boxed{i=2}
$$

These are the easiest.

---

### Type 3 — Determine whether language is regular

Use:

* Pumping Lemma
* DFA construction
* Closure
* Myhill-Nerode

---

### Type 4 — Determine whether language is CFL

Use:

* CFG construction
* PDA construction
* CFL closure properties
* CFL pumping lemma

---

# 16. ⚡ GATE Shortcut Table

| Language                                     | Classification             |
| -------------------------------------------- | -------------------------- |
| `{aⁿbⁿ}`                                     | CFL, not regular           |
| `{aⁿbⁿcⁿ}`                                   | Not CFL                    |
| `{aⁿbⁿaⁿ}`                                   | Not CFL                    |
| `{aⁿbᵐ}`                                     | Regular                    |
| `{aⁿbᵐcᵏ}`                                   | Regular                    |
| `{wwᴿ}`                                      | CFL                        |
| `{ww}`                                       | Not CFL                    |
| `{aⁿ}`                                       | Regular                    |
| `{aⁿ : n is prime}`                          | Not regular, hence not CFL |
| Finite language                              | Regular                    |
| Any language over unary alphabet that is CFL | Regular                    |

---

# 17. 🔥 PYQ-Wise Concepts to Master

GATE repeatedly tests:

1. **Choosing the correct pumping length**
2. **Understanding `|xy| ≤ p`**
3. **Identifying what `y` can contain**
4. **Choosing `i=0` or `i=2`**
5. **Whether pumping lemma proves regularity**
6. **Regular vs CFL pumping lemma**
7. **Finding whether a language is regular/CFL**
8. **Combining pumping lemma with closure properties**

### Most important trap

$$
\boxed{\text{Pumping Lemma is a necessary condition, not a sufficient condition}}
$$

---

# 18. 🧠 30-Second Revision

### Regular

```text
L regular
   ↓
∃ p
   ↓
w = xyz
   ↓
|xy| ≤ p
|y| > 0
   ↓
xyⁱz ∈ L ∀ i≥0
```

### CFL

```text
L CFL
   ↓
∃ p
   ↓
z = uvwxy
   ↓
|vwx| ≤ p
|vx| > 0
   ↓
uvⁱwxⁱy ∈ L ∀ i≥0
```

### Golden rule

> **To prove NOT regular/CFL, assume it is regular/CFL, choose a smart string, consider every valid decomposition, pump, and create a contradiction.**

### ⭐ GATE Priority

**VERY HIGH** — Pumping Lemma is one of the most important tools for Regular Languages and CFL questions.
