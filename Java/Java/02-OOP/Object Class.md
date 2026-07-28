# Object Class

## What is the Object Class?

The **Object** class is the **root (top-most) class** of the Java class hierarchy.

Every class in Java **directly or indirectly** extends the `Object` class.

> **Definition:** The `Object` class is the superclass of all Java classes and provides common methods that every object inherits.

---

# Why Do We Need the Object Class?

Imagine every Java class had to implement basic methods like:

- `toString()`
- `equals()`
- `hashCode()`
- `clone()`

That would lead to code duplication.

Instead,

Java provides these common methods in one place.

```text
Object

↓

Animal

↓

Dog
```

Now,

`Dog` automatically inherits all methods from `Object`.

---

# Real-World Example

Imagine a company.

```text
Employee

↓

Developer

Tester

Manager
```

Every employee has common properties like

- Employee ID
- Name

Similarly,

every Java object has common methods from the `Object` class.

---

# Class Hierarchy

```text
                Object
                   │
        ┌──────────┴──────────┐
        │                     │
     Animal               Vehicle
        │                     │
      Dog                  Car
```

No matter which class you create,

it eventually inherits from `Object`.

---

# Syntax

```java
class Student{

}
```

Internally,

Java treats it as

```java
class Student extends Object{

}
```

The compiler automatically adds `extends Object`.

---

# Common Methods of Object Class

| Method | Purpose |
|---------|---------|
| `toString()` | Returns string representation |
| `equals()` | Compares objects |
| `hashCode()` | Returns hash value |
| `getClass()` | Returns runtime class |
| `clone()` | Creates object copy |
| `wait()` | Makes thread wait |
| `notify()` | Wakes one waiting thread |
| `notifyAll()` | Wakes all waiting threads |

---

# toString()

Returns a string representation of an object.

Example

```java
class Student{

}
```

Usage

```java
Student s = new Student();

System.out.println(s);
```

Output

```text
Student@3f99bd52
```

This output contains

- Class name
- Hash code (in hexadecimal)

---

# Overriding toString()

```java
class Student{

    String name = "John";

    @Override

    public String toString(){

        return name;

    }

}
```

Usage

```java
System.out.println(new Student());
```

Output

```text
John
```

This makes objects easier to read while debugging.

---

# equals()

Compares two objects.

Example

```java
String a = new String("Java");

String b = new String("Java");

System.out.println(a.equals(b));
```

Output

```text
true
```

`equals()` compares object content (when overridden appropriately).

---

# == vs equals()

```java
String a = new String("Java");

String b = new String("Java");
```

```text
==

↓

Compares References

equals()

↓

Compares Contents
```

Example

```java
System.out.println(a == b);      // false

System.out.println(a.equals(b)); // true
```

---

# Overriding equals()

```java
class Student{

    int id;

    Student(int id){

        this.id = id;

    }

    @Override

    public boolean equals(Object obj){

        Student s = (Student) obj;

        return this.id == s.id;

    }

}
```

Usage

```java
Student s1 = new Student(1);

Student s2 = new Student(1);

System.out.println(s1.equals(s2));
```

Output

```text
true
```

---

# hashCode()

Returns an integer hash value.

Example

```java
Student s = new Student(1);

System.out.println(s.hashCode());
```

Objects that are equal should return the same hash code.

---

# equals() and hashCode() Contract

If

```java
a.equals(b) == true
```

Then

```java
a.hashCode() == b.hashCode()
```

This is important for

- `HashMap`
- `HashSet`
- `Hashtable`

---

# getClass()

Returns the runtime class of an object.

Example

```java
Student s = new Student();

System.out.println(s.getClass());
```

Output

```text
class Student
```

---

# clone()

Creates a copy of an object.

```java
class Student implements Cloneable{

    @Override

    protected Object clone()
            throws CloneNotSupportedException{

        return super.clone();

    }

}
```

Usage

```java
Student s2 = (Student) s1.clone();
```

`clone()` performs a **shallow copy** by default.

---

# wait(), notify(), notifyAll()

These methods are used in **Multithreading**.

```java
wait();
```

Pauses the current thread.

```java
notify();
```

Wakes one waiting thread.

```java
notifyAll();
```

Wakes all waiting threads.

These methods must be called inside a synchronized context.

---

# Memory Representation

```java
Student s = new Student();
```

Memory

```text
Stack

↓

s

↓

Heap

↓

Student Object

↓

Object Methods

↓

Student Methods
```

Every object automatically has Object class functionality.

---

# Internal Working

Suppose

```java
Student s = new Student();

System.out.println(s);
```

Internally

```text
println()

↓

Calls

↓

toString()

↓

Returns String

↓

Prints Output
```

Similarly,

```java
map.put(key, value);
```

Internally

```text
hashCode()

↓

Bucket Selection

↓

equals()

↓

Collision Check
```

---

# Production Usage

The `Object` class is used throughout Java.

Examples

- Collections Framework
- Spring Boot
- Hibernate
- Logging
- HashMap
- HashSet

Spring Boot Example

```java
@Entity

public class User{

    private Long id;

    private String username;

}
```

Developers often override

- `equals()`
- `hashCode()`
- `toString()`

for proper entity behavior.

---

# Advantages

- Common functionality for all objects
- Supports polymorphism
- Enables collections to work efficiently
- Simplifies debugging
- Provides runtime information

---

# Limitations

- Default `equals()` compares references only.
- Default `toString()` is not user-friendly.
- `clone()` is considered difficult to use correctly in many cases.

---

# Best Practices

✅ Override `toString()` for readable output.

✅ Override both `equals()` and `hashCode()` together.

✅ Use `Objects.equals()` to avoid `NullPointerException`.

✅ Prefer copy constructors or factory methods over `clone()` in modern Java.

---

# Common Mistakes

❌ Overriding `equals()` without overriding `hashCode()`.

---

❌ Using `==` to compare object contents.

---

❌ Assuming `clone()` performs a deep copy.

It performs a shallow copy unless implemented otherwise.

---

❌ Calling `wait()` or `notify()` outside a synchronized block or method.

---

# Interview Questions

### 1. What is the Object class?

The `Object` class is the root superclass of all Java classes.

---

### 2. Which class is the parent of every Java class?

`java.lang.Object`

---

### 3. What is the difference between `==` and `equals()`?

| `==` | `equals()` |
|------|------------|
| Compares references | Compares object content (if overridden) |

---

### 4. Why should `equals()` and `hashCode()` be overridden together?

Because equal objects must return the same hash code for collections like `HashMap` and `HashSet` to work correctly.

---

### 5. What does `toString()` do?

It returns a string representation of an object.

---

### 6. What is `getClass()` used for?

It returns the runtime class of an object.

---

### 7. What kind of copy does `clone()` create?

A shallow copy by default.

---

### 8. What are `wait()`, `notify()`, and `notifyAll()` used for?

They are used for thread communication in multithreading.

---

### 9. Why is `Object` important in Spring Boot?

Frameworks rely on methods like `equals()`, `hashCode()`, and `toString()` for entity management, logging, caching, and collections.

---

### 10. Which Object methods are most commonly overridden?

- `toString()`
- `equals()`
- `hashCode()`

---

# Quick Revision

- `Object` is the root class of Java.
- Every class implicitly extends `Object`.
- Important methods:
  - `toString()`
  - `equals()`
  - `hashCode()`
  - `getClass()`
  - `clone()`
  - `wait()`
  - `notify()`
  - `notifyAll()`
- Override `equals()` and `hashCode()` together.
- Prefer overriding `toString()` for readable output.

---

# Keywords

- Object Class
- toString()
- equals()
- hashCode()
- getClass()
- clone()
- wait()
- notify()
- notifyAll()
- Root Class
- Java OOP
- HashMap
- HashSet
- Spring Boot
```