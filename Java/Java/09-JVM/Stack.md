# Stack (JVM Memory)

## What is Stack?

The **Java Stack** is a JVM memory area used to store **method-related information** during program execution.

Every time a method is called, the JVM creates a **Stack Frame** and pushes it onto the stack.

When the method finishes, its Stack Frame is removed automatically.

> **Definition:** The Stack is a thread-specific memory area that stores method calls, local variables, parameters, and partial execution results.

---

# Why Do We Need Stack?

Imagine a program calling multiple methods.

```java
main();

↓

login();

↓

validate();

↓

checkPassword();
```

The JVM must remember:

- Which method is executing
- Local variables
- Where to return after a method finishes

The Stack performs this job.

---

# Real-World Example

Imagine a stack of plates.

```
Push Plate

↓

Push Plate

↓

Push Plate
```

To remove a plate,

```
Pop Plate

↓

Pop Plate

↓

Pop Plate
```

The **last plate placed is the first one removed**.

Similarly,

```
main()

↓

login()

↓

validate()

↓

return

↓

login()

↓

main()
```

---

# Stack Characteristics

- Thread-specific
- Stores Stack Frames
- Uses LIFO (Last In First Out)
- Automatically managed
- Very fast access

---

# What is Stored in Stack?

The Stack stores:

- Local Variables
- Method Parameters
- Method Calls
- Return Address
- Operand Stack (temporary values)

It does **not** store objects themselves.

---

# Stack Frame

Every method call creates a **Stack Frame**.

Example

```java
public void add() {

    int x = 10;

}
```

Memory

```
Stack

↓

+----------------+
| add() Frame    |
| x = 10         |
+----------------+
```

When `add()` finishes,

```
Stack

↓

Frame Removed
```

---

# Method Call Example

```java
public static void main(String[] args) {

    login();

}

static void login() {

    validate();

}

static void validate() {

}
```

Execution

```
main()

↓

login()

↓

validate()
```

Stack

```
Top

+------------------+
| validate()       |
+------------------+
| login()          |
+------------------+
| main()           |
+------------------+

Bottom
```

After `validate()` returns,

```
Top

+------------------+
| login()          |
+------------------+
| main()           |
+------------------+
```

---

# Local Variables

Example

```java
void test() {

    int x = 10;

    String name = "John";

}
```

Stored in Stack

```
Stack Frame

↓

x = 10

name (Reference)
```

Notice

```
name
```

is only a reference.

The actual String object is stored in the Heap.

---

# Parameters

Example

```java
void add(int a, int b){

}
```

Memory

```
Stack Frame

↓

a

↓

b
```

Parameters are stored inside the Stack Frame.

---

# Return Address

Suppose

```java
main()

↓

login()

↓

validate()
```

After

```
validate()
```

finishes,

the JVM must know where to return.

The Stack stores this return information automatically.

---

# Operand Stack

Each Stack Frame contains an **Operand Stack**.

It is used by the JVM to perform calculations.

Example

```java
int c = a + b;
```

Internally

```
Push a

↓

Push b

↓

Add

↓

Store Result
```

The Operand Stack is temporary and managed by the JVM.

---

# LIFO (Last In First Out)

Suppose

```java
main()

↓

A()

↓

B()

↓

C()
```

Execution

```
Push main

↓

Push A

↓

Push B

↓

Push C
```

Returning

```
Pop C

↓

Pop B

↓

Pop A

↓

Pop main
```

---

# Stack vs Heap

```java
Student s = new Student();
```

Memory

```
Stack

↓

Reference s

↓

Heap

↓

Student Object
```

Objects live in the Heap.

References live in the Stack.

---

# Thread-Specific Nature

Every thread has its own Stack.

```
Thread 1

↓

Stack 1

----------------

Thread 2

↓

Stack 2

----------------

Thread 3

↓

Stack 3
```

This prevents local variables of one thread from interfering with another.

---

# Stack Overflow Error

Suppose

```java
void test(){

    test();

}
```

The method calls itself forever.

```
test()

↓

test()

↓

test()

↓

test()

↓

...
```

Eventually,

the Stack becomes full.

Result

```
java.lang.StackOverflowError
```

---

# Recursion Example

```java
factorial(3)

↓

factorial(2)

↓

factorial(1)
```

Stack

```
Top

factorial(1)

↓

factorial(2)

↓

factorial(3)

↓

main()
```

After reaching the base case,

frames are removed one by one.

---

# Internal Working

Suppose

```java
Student s = new Student();

s.study();
```

Internally

```
main()

↓

Stack Frame

↓

Reference s

↓

Heap Object

↓

study()

↓

New Stack Frame

↓

Method Returns

↓

Frame Removed
```

---

# Production Usage

Every Java application uses the Stack.

Examples

- Spring Boot
- Hibernate
- Kafka
- Tomcat

Suppose a Spring Boot REST API receives a request.

```
HTTP Request

↓

Thread Created

↓

Stack Created

↓

Controller Method

↓

Service Method

↓

Repository Method

↓

Database

↓

Return

↓

Frames Removed
```

Each request has its own Stack because each request is usually handled by a separate thread.

---

# Advantages

- Very fast memory access
- Automatic cleanup
- Thread isolation
- Efficient method execution

---

# Limitations

- Fixed size
- StackOverflowError if exhausted
- Stores only method-related data

---

# Best Practices

✅ Avoid unnecessary deep recursion.

✅ Keep methods small and focused.

✅ Prefer iteration when recursion can become very deep.

✅ Understand that local variables disappear after the method returns.

---

# Common Mistakes

❌ Thinking objects are stored in the Stack.

Objects are stored in the Heap.

---

❌ Assuming one Stack is shared by all threads.

Each thread has its own Stack.

---

❌ Confusing local variables with object memory.

Primitive values are stored directly in the Stack Frame, while object variables store only references.

---

❌ Ignoring StackOverflowError caused by infinite recursion.

---

# Interview Questions

### 1. What is Stack Memory?

A thread-specific JVM memory area that stores method calls, local variables, parameters, and execution information.

---

### 2. What is a Stack Frame?

A Stack Frame is the memory created for each method call.

---

### 3. What is stored in the Stack?

- Local variables
- Method parameters
- Return addresses
- Operand Stack
- Object references

---

### 4. Are objects stored in the Stack?

No.

Objects are stored in the Heap.

Only references are stored in the Stack.

---

### 5. What is LIFO?

Last In, First Out.

The last method called is the first to return.

---

### 6. Does every thread have its own Stack?

Yes.

Each thread has its own independent Java Stack.

---

### 7. What causes StackOverflowError?

Excessive or infinite method calls, often due to deep or missing-base-case recursion.

---

### 8. What happens when a method returns?

Its Stack Frame is automatically removed from the Stack.

---

### 9. What is the Operand Stack?

A temporary area inside each Stack Frame used by the JVM to execute bytecode instructions and perform calculations.

---

### 10. Why is Stack memory faster than Heap memory?

Because it follows a simple LIFO structure, making memory allocation and deallocation very efficient.

---

# Quick Revision

- Stack is thread-specific.
- Stores:
  - Method calls
  - Local variables
  - Parameters
  - Return addresses
  - Operand Stack
  - Object references
- Uses LIFO.
- Every method call creates a Stack Frame.
- Frames are removed automatically.
- Infinite recursion causes `StackOverflowError`.

---

# Keywords

- Stack
- Stack Memory
- Stack Frame
- LIFO
- Local Variables
- Method Parameters
- Return Address
- Operand Stack
- Thread
- StackOverflowError
- Recursion
- JVM
- Heap Reference
- Method Call
```