# 07 — COMPILER DESIGN

## 04 — Runtime Environments — GATE CSE Notes

> **GATE Priority: ⭐⭐⭐⭐ HIGH**
>
> Focus on **activation records, stack/heap/static allocation, procedure calls, control link, access link, parameter passing, recursion, dynamic/static scope, and storage allocation**.

---

# 1. What is a Runtime Environment?

The **runtime environment** is the set of mechanisms used to manage a program while it is executing.

It manages:

* Memory
* Variables
* Procedure/function calls
* Parameters
* Return values
* Activation records
* Dynamic storage
* Scope/access information

Basic view:

```text
Source Program
      ↓
Compiler
      ↓
Executable
      ↓
Runtime Environment
      ↓
Program Execution
```

---

# 2. Runtime Memory Organization

A typical process memory layout:

```text
Higher Address
┌─────────────────────┐
│        Stack        │
│         ↓           │
├─────────────────────┤
│                     │
│    Free Space       │
│                     │
├─────────────────────┤
│         ↑           │
│        Heap         │
├─────────────────────┤
│   Static / Global   │
├─────────────────────┤
│   Code / Text       │
└─────────────────────┘
Lower Address
```

### GATE

Remember:

$$
\boxed{\text{Stack → function calls}}
$$

$$
\boxed{\text{Heap → dynamic allocation}}
$$

$$
\boxed{\text{Static area → global/static data}}
$$

---

# 3. Storage Allocation Strategies

There are three major approaches:

$$
\boxed{\text{Static Allocation}}
$$

$$
\boxed{\text{Stack Allocation}}
$$

$$
\boxed{\text{Heap Allocation}}
$$

---

# 4. Static Allocation

Memory is allocated before execution or in a fixed manner.

Variables have fixed storage locations.

Suitable when:

* Number of variables is known
* Lifetimes are fixed
* Recursion is not required for automatic activations

Example:

```c
int x;
int y;
```

---

# 5. Problem with Static Allocation

Consider recursion:

```c
void f() {
    int x;
    f();
}
```

Every call to `f()` needs a separate `x`.

Static allocation cannot conveniently provide a new independent activation for every recursive call.

Therefore:

$$
\boxed{\text{Recursion → requires dynamic activation storage}}
$$

usually stack allocation.

---

# 6. Stack Allocation

When a function/procedure is called, an **activation record** is pushed onto the stack.

When it returns, the activation record is removed.

```text id="r1j5f4"
Call f()
   ↓
Push activation record
   ↓
Execute f()
   ↓
Return
   ↓
Pop activation record
```

---

# 7. Activation

An **activation** is an execution of a procedure/function.

If:

```c
f();
f();
```

there are two activations of `f`, occurring sequentially.

With recursion:

```c
f() {
    f();
}
```

multiple activations of `f` can exist simultaneously.

---

# 8. Activation Record

An **activation record** (stack frame) contains information required for one procedure activation.

Typical components:

```text id="8u6q6r"
┌────────────────────────┐
│ Actual parameters      │
├────────────────────────┤
│ Return value           │
├────────────────────────┤
│ Return address          │
├────────────────────────┤
│ Control link            │
├────────────────────────┤
│ Access link             │
├────────────────────────┤
│ Saved machine status   │
├────────────────────────┤
│ Local variables        │
├────────────────────────┤
│ Temporaries             │
└────────────────────────┘
```

Exact layout varies by compiler/architecture.

---

# 9. 🔥 GATE Important Components

### Return Address

Where execution continues after the function returns.

$$
\boxed{\text{Return address → caller's continuation}}
$$

---

### Control Link

Points to the activation record of the **caller**.

$$
\boxed{\text{Control link → dynamic caller}}
$$

---

### Access Link

Used to access non-local variables under **lexical/static scoping**.

$$
\boxed{\text{Access link → lexical parent}}
$$

This distinction is extremely important.

---

# 10. Control Link vs Access Link

| Link         | Points toward  | Used for                         |
| ------------ | -------------- | -------------------------------- |
| Control link | Dynamic caller | Calling sequence / dynamic chain |
| Access link  | Lexical parent | Accessing non-local variables    |

### 🔥 Memory Trick

> **Control = Who called me?**

> **Access = Where am I nested?**

---

# 11. Dynamic Chain

Follow the control links:

```text id="1v4d3x"
AR of C
   ↓ control link
AR of B
   ↓ control link
AR of A
```

This forms the:

$$
\boxed{\text{Dynamic chain}}
$$

It represents the sequence of active calls.

---

# 12. Static Chain

Follow the access links:

```text id="h8q7s0"
Nested procedure
      ↓ access link
Lexical parent
      ↓ access link
Outer lexical scope
```

This is the:

$$
\boxed{\text{Static chain}}
$$

It represents lexical nesting.

---

# 13. Static vs Dynamic Scoping

🔥 **Very important GATE topic.**

### Static / Lexical Scoping

Binding is determined from the **program text**.

You can determine the relevant declaration by examining lexical nesting.

---

### Dynamic Scoping

Binding depends on the **runtime call sequence**.

You follow the active call chain.

---

# 14. Example of Static Scoping

```c
int x = 10;

void A() {
    int x = 20;
    B();
}

void B() {
    printf("%d", x);
}
```

Under lexical/static scoping, `B` uses the `x` associated with its lexical environment.

If `B` is declared at global scope, it refers to the global `x`.

Therefore:

$$
\boxed{10}
$$

---

# 15. Dynamic Scoping

Under dynamic scoping, when `B()` executes after being called by `A()`:

```text id="hskp0u"
B
↓
caller = A
↓
A has x = 20
```

So `B` may resolve `x` to:

$$
\boxed{20}
$$

---

# 16. 🔥 GATE Trick

### Static scope

Look at:

$$
\boxed{\text{Program structure}}
$$

### Dynamic scope

Look at:

$$
\boxed{\text{Call sequence}}
$$

---

# 17. Heap Allocation

The heap is used for dynamically allocated objects whose lifetimes are not necessarily tied to a single procedure activation.

Example:

```c
int *p = malloc(sizeof(int));
```

The dynamically allocated object is placed in heap storage.

---

# 18. Why Heap?

Heap allocation is useful when:

* Object size is determined at runtime
* Lifetime extends beyond a function activation
* Objects are dynamically created/deleted
* Data structures such as linked lists and trees are required

---

# 19. Stack vs Heap

| Stack                                | Heap                                    |
| ------------------------------------ | --------------------------------------- |
| Function activations                 | Dynamic objects                         |
| Usually automatic                    | Explicit/GC-managed                     |
| LIFO behavior                        | General allocation                      |
| Fast allocation/deallocation         | More complex                            |
| Local variables commonly live here   | `malloc/new` objects commonly live here |
| Function return often releases frame | Object lifetime may be independent      |

---

# 20. Procedure Call Sequence

A function call typically involves:

### Caller

1. Evaluate arguments
2. Pass arguments
3. Save required state
4. Transfer control

### Callee

1. Create activation record
2. Save/register setup
3. Initialize local variables
4. Execute body

### Return

1. Produce return value
2. Restore state
3. Remove activation record
4. Transfer control to return address

---

# 21. Caller vs Callee

```text id="e0z7xw"
Caller
  |
  | call
  ↓
Callee
  |
  | return
  ↓
Caller
```

### GATE Questions

May ask which entity:

* evaluates parameters
* saves registers
* creates frame
* restores frame
* handles return address

Exact responsibilities can vary by calling convention, so rely on the convention stated in the question.

---

# 22. Parameter Passing

Important mechanisms include:

1. Call by value
2. Call by reference
3. Copy-in/copy-out
4. Call by name

---

# 23. Call by Value

The value of the argument is copied into the parameter.

Example:

```c
void f(int x) {
    x = 20;
}

int a = 10;
f(a);
```

After:

$$
a=10
$$

Changing `x` does not change `a`.

---

# 24. Call by Reference

The parameter refers to the original variable/object.

```text id="y4u4gz"
a
↑
|
x
```

If:

```text id="6h5b5w"
x = 20
```

then the caller's `a` may also become:

$$
\boxed{20}
$$

---

# 25. Copy-In / Copy-Out

Also called **value-result**.

Two stages:

### Entry

Copy actual argument into formal parameter:

$$
actual\rightarrow formal
$$

### Return

Copy formal back:

$$
formal\rightarrow actual
$$

Example:

```text id="m3n9qj"
Call:
a = 10

copy-in:
x = 10

inside:
x = 20

copy-out:
a = 20
```

---

# 26. 🔥 Copy-In/Copy-Out Trap

Aliasing can create surprising results.

Suppose:

```text id="9n8bqk"
f(a, a)
```

and both parameters are modified.

Both formal parameters copy their values from the same actual variable.

On return, which copy is written last can determine the final value.

### GATE

If the question involves:

$$
f(x,x)
$$

under value-result:

$$
\boxed{\text{Order of copy-out can matter}}
$$

---

# 27. Call by Name

Call-by-name behaves roughly like textual substitution/evaluation of the argument when needed, historically associated with **Algol**.

It is often explained using **thunks**.

A thunk delays evaluation of an argument until it is accessed.

---

# 28. Recursion and Activation Records

Consider:

```c
int fact(int n) {
    if(n == 0)
        return 1;
    return n * fact(n-1);
}
```

For:

$$
fact(3)
$$

activation records exist for:

```text id="0yqfmx"
fact(3)
fact(2)
fact(1)
fact(0)
```

Stack grows with each recursive call.

Maximum simultaneous activations:

$$
\boxed{4}
$$

---

# 29. GATE Recursion Trick

For:

$$
f(n)\rightarrow f(n-1)
$$

maximum stack depth is generally proportional to the recursion depth.

For `fact(n)`:

$$
\boxed{\text{Depth}=n+1}
$$

if the base case is `fact(0)`.

---

# 30. Tail Recursion

A recursive call is **tail recursive** if it is the final operation of the function.

Example:

```c
f(n) {
    if(n == 0) return;
    f(n-1);
}
```

The recursive call is the final action.

Tail recursion can often be optimized into iteration.

$$
\boxed{\text{Tail-call optimization → potentially constant stack space}}
$$

provided the implementation performs that optimization.

---

# 31. Static Allocation vs Stack vs Heap

| Property        | Static                 | Stack                  | Heap         |
| --------------- | ---------------------- | ---------------------- | ------------ |
| Allocation time | Before/runtime startup | Procedure call         | Runtime      |
| Lifetime        | Usually entire program | Activation lifetime    | Arbitrary    |
| Recursion       | Poor fit               | Excellent              | Possible     |
| Dynamic objects | Poor fit               | Limited                | Excellent    |
| Typical use     | Globals/statics        | Local variables/frames | Dynamic data |

---

# 32. Activation Record — Typical Order

A simplified activation record can contain:

```text id="qf78q2"
Parameters
Return value
Control link
Access link
Saved registers
Local variables
Temporaries
```

**Do not memorize a universal physical order.**

GATE questions generally test **what each field means**, rather than a particular machine's exact stack layout.

---

# 33. Non-Local Variable Access

Suppose:

```text id="xw6l6c"
A
└── B
    └── C
```

`C` wants a variable declared in `A`.

Using a static chain:

```text id="9c7f0q"
C
 ↓ access link
B
 ↓ access link
A
```

The runtime can traverse the chain to find the declaration.

---

# 34. Static Chain Access Cost

If a nested procedure is at lexical depth `d` relative to the declaration, the runtime may need to follow multiple access links.

Conceptually:

$$
\boxed{\text{Access cost} \propto \text{static nesting distance}}
$$

unless a different implementation such as a display is used.

---

# 35. Display

A **display** is an alternative to a static chain for accessing non-local variables.

It maintains pointers to activation records at different lexical nesting levels.

Example:

```text id="m8r8y5"
Display[0] → level 0 activation
Display[1] → level 1 activation
Display[2] → level 2 activation
```

Then access to an outer-level variable can be more direct.

---

# 36. Static Chain vs Display

| Static Chain                            | Display                                             |
| --------------------------------------- | --------------------------------------------------- |
| Follow links one by one                 | Direct indexing by nesting level                    |
| Access time depends on nesting distance | Faster non-local access in suitable implementations |
| Simpler concept                         | Requires display maintenance                        |

---

# 37. 🔥 GATE Trick

If question says:

> Access non-local variable in nested procedures

Think:

$$
\boxed{\text{Access link / Static chain}}
$$

If it specifically mentions:

> Array of pointers indexed by lexical level

Think:

$$
\boxed{\text{Display}}
$$

---

# 38. PYQ Pattern — Activation Records

A common GATE-style question gives:

```text
main → A → B → C
```

and asks:

> What is the dynamic chain when executing C?

Answer:

```text id="5x0cx0"
C → B → A → main
```

because the dynamic chain follows **callers**.

---

# 39. PYQ Pattern — Static Chain

Suppose lexical nesting is:

```text id="l0v1xx"
A
└── B
    └── C
```

Even if `C` is called through some different runtime path, its access link follows its **lexical parent**:

```text id="oz4c6v"
C → B → A
```

### Key difference

$$
\boxed{\text{Dynamic chain = actual calls}}
$$

$$
\boxed{\text{Static chain = lexical nesting}}
$$

---

# 40. PYQ Pattern — Scope

Given:

```c
int x = 10;

void f() {
    int x = 20;
    g();
}

void g() {
    printf("%d", x);
}
```

Question:

> What does `g()` print under static vs dynamic scope?

Static:

$$
\boxed{10}
$$

Dynamic:

$$
\boxed{20}
$$

This is a classic conceptual pattern.

---

# 41. PYQ Pattern — Recursion

If:

```c
f(5)
```

calls:

```text
f(4)
f(3)
f(2)
f(1)
f(0)
```

then maximum simultaneous activation records:

$$
\boxed{6}
$$

assuming `f(0)` creates an activation before returning.

---

# 42. PYQ Pattern — Parameter Passing

Given:

```text id="m6a6h2"
x = 10

call f(x)

inside f:
x = 20
```

### Call by value

Original:

$$
\boxed{x=10}
$$

### Call by reference

Original:

$$
\boxed{x=20}
$$

### Value-result

Original becomes `20` after copy-out, assuming no aliasing complication.

---

# 43. PYQ Pattern — Heap vs Stack

Question:

> Which structure is appropriate for objects whose lifetime is independent of function activation?

Answer:

$$
\boxed{\text{Heap}}
$$

---

# 44. Common GATE Traps

### ❌ Trap 1

> Control link points to lexical parent.

False.

$$
\boxed{\text{Control link → caller}}
$$

---

### ❌ Trap 2

> Access link points to caller.

False.

$$
\boxed{\text{Access link → lexical parent}}
$$

---

### ❌ Trap 3

> Recursion can be handled using only static allocation.

Generally false for ordinary recursive activations.

---

### ❌ Trap 4

> Heap follows LIFO allocation.

False.

Heap allocation is general-purpose; it does not inherently follow stack LIFO discipline.

---

### ❌ Trap 5

> Tail recursion always uses O(1) stack.

Not necessarily.

It can use O(1) stack **if tail-call optimization is performed**.

---

# 45. 🎯 GATE Must-Memorize Table

| Concept           | Remember                     |
| ----------------- | ---------------------------- |
| Activation        | One execution of a procedure |
| Activation record | Stack frame for activation   |
| Control link      | Dynamic caller               |
| Access link       | Lexical parent               |
| Dynamic chain     | Control links                |
| Static chain      | Access links                 |
| Static scope      | Program structure            |
| Dynamic scope     | Runtime call chain           |
| Stack             | Function activations         |
| Heap              | Dynamic objects              |
| Static area       | Globals/statics              |
| Display           | Direct lexical-level access  |
| Call by value     | Copy value                   |
| Call by reference | Refer to original            |
| Value-result      | Copy in + copy out           |
| Recursion         | Multiple active frames       |
| Tail recursion    | Recursive call at end        |

---

# 🧠 30-Second Revision

```text id="xv3o9q"
             RUNTIME ENVIRONMENT
                     |
       ┌─────────────┼──────────────┐
       ↓             ↓              ↓
    STATIC         STACK           HEAP
       |             |              |
 globals/statics  calls/frames   dynamic objects
```

### Activation Record

```text id="s6g6l2"
Parameters
Return information
Control link
Access link
Saved state
Local variables
Temporaries
```

### Most important:

$$
\boxed{Control\ Link=Caller}
$$

$$
\boxed{Access\ Link=Lexical\ Parent}
$$

$$
\boxed{Dynamic\ Chain=Call\ Sequence}
$$

$$
\boxed{Static\ Chain=Lexical\ Nesting}
$$

$$
\boxed{Stack=Activations}
$$

$$
\boxed{Heap=Dynamic\ Allocation}
$$

---

# 🔥 Final GATE Checklist

* [ ] Runtime environment
* [ ] Static allocation
* [ ] Stack allocation
* [ ] Heap allocation
* [ ] Activation
* [ ] Activation record
* [ ] Return address
* [ ] Control link
* [ ] Access link
* [ ] Dynamic chain
* [ ] Static chain
* [ ] Static vs dynamic scoping
* [ ] Recursion and stack frames
* [ ] Tail recursion
* [ ] Display
* [ ] Parameter passing
* [ ] Call by value
* [ ] Call by reference
* [ ] Copy-in/copy-out
* [ ] Call by name
* [ ] Non-local variable access

## ⭐ Highest-yield facts

$$
\boxed{\text{Control link → dynamic caller}}
$$

$$
\boxed{\text{Access link → lexical parent}}
$$

$$
\boxed{\text{Static scope → program text}}
$$

$$
\boxed{\text{Dynamic scope → call sequence}}
$$

$$
\boxed{\text{Recursion → multiple activation records}}
$$

**Next: `05-Intermediate-Code-Generation.md`**.
