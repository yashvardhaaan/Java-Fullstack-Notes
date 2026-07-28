# Records & Sealed Classes (Java 16 & Java 17)

## What are Records?

A **Record** is a special type of class introduced in **Java 16** that is used to store immutable data.

Instead of writing lots of boilerplate code (constructors, getters, `equals()`, `hashCode()`, `toString()`), Java automatically generates it for us.

> **Definition:** A Record is a concise way to create immutable data carrier classes.

---

# Why Do We Need Records?

Before Records, creating a simple class required lots of code.

```java
class Student {

    private final int id;
    private final String name;

    public Student(int id, String name){
        this.id = id;
        this.name = name;
    }

    public int getId(){
        return id;
    }

    public String getName(){
        return name;
    }

    @Override
    public String toString(){
        return id + " " + name;
    }

}
```

With Records

```java
record Student(int id, String name){}
```

Java automatically generates everything.

---

# Real-World Example

Imagine an Aadhaar card.

```
Aadhaar Card

↓

Stores Data

↓

Cannot Be Changed Easily
```

Similarly,

```
Record

↓

Stores Data

↓

Immutable
```

---

# Record Syntax

```java
record Student(int id, String name){}
```

Creating an Object

```java
Student student =

new Student(1, "Yash");
```

---

# Automatically Generated

Java generates

- Constructor
- Getter methods
- equals()
- hashCode()
- toString()

Example

```java
student.id();

student.name();

System.out.println(student);
```

Output

```text
Student[id=1, name=Yash]
```

---

# Custom Constructor

Records can have constructors.

```java
record Student(int id, String name){

    public Student{

        if(id <= 0){

            throw new IllegalArgumentException();

        }

    }

}
```

This is called a **Compact Constructor**.

---

# Adding Methods

Records can contain methods.

```java
record Student(int id, String name){

    public String display(){

        return id + " " + name;

    }

}
```

---

# Limitations of Records

❌ Cannot extend another class.

❌ Cannot have mutable instance fields.

❌ Automatically extends `java.lang.Record`.

---

# Internal Working

```text
Record

↓

Compiler

↓

Generates

Constructor

↓

Getters

↓

equals()

↓

hashCode()

↓

toString()
```

---

# What are Sealed Classes?

A **Sealed Class** is a class that restricts **which classes can extend or implement it**.

Introduced in **Java 17**.

> **Definition:** A Sealed Class controls inheritance by allowing only specific subclasses.

---

# Why Do We Need Sealed Classes?

Normally

```java
class Vehicle{

}
```

Anyone can extend it.

```java
class Car extends Vehicle{}

class Bike extends Vehicle{}

class Truck extends Vehicle{}

class Anything extends Vehicle{}
```

Sometimes we want to allow only specific subclasses.

Sealed Classes solve this problem.

---

# Syntax

```java
public sealed class Vehicle

permits Car, Bike{

}
```

Only

```java
Car
Bike
```

can extend `Vehicle`.

---

# Extending a Sealed Class

A permitted subclass must choose one of three modifiers.

### final

Cannot be extended.

```java
final class Car

extends Vehicle{

}
```

---

### sealed

Can restrict inheritance further.

```java
sealed class Bike

extends Vehicle

permits SportsBike{

}
```

---

### non-sealed

Removes the restriction.

```java
non-sealed class Truck

extends Vehicle{

}
```

Now anyone can extend `Truck`.

---

# Sealed Class Hierarchy

```text
Vehicle (sealed)

│

├── Car (final)

│

├── Bike (sealed)

│      │

│      └── SportsBike

│

└── Truck (non-sealed)

       │

       └── Any Class
```

---

# Records vs Normal Classes

| Record | Class |
|---------|-------|
| Immutable | Mutable or Immutable |
| Less code | More boilerplate |
| Data carrier | General purpose |
| Auto-generated methods | Manual methods |

---

# Sealed Class vs Final Class

| Sealed | Final |
|----------|--------|
| Allows selected subclasses | No subclass allowed |
| Controlled inheritance | No inheritance |
| Flexible | Completely restricted |

---

# Production Usage

## Records

Used in

- DTOs
- API Requests
- API Responses
- Configuration Objects
- Immutable Data

Example

```java
record UserResponse(

Long id,

String name

){}
```

Very common in Spring Boot REST APIs.

---

## Sealed Classes

Used in

- Payment Systems
- State Machines
- Banking
- Compiler Design
- Domain Models

Example

```java
sealed interface Payment

permits CardPayment,
CashPayment,
UpiPayment{

}
```

---

# Advantages of Records

- Very little code
- Immutable
- Thread-safe
- Cleaner APIs
- Auto-generated methods

---

# Advantages of Sealed Classes

- Controlled inheritance
- Better security
- Easier maintenance
- Better domain modeling

---

# Limitations

### Records

- Immutable only
- Cannot extend other classes
- Not suitable for mutable entities (for example, JPA entities)

### Sealed Classes

- Requires Java 17+
- Needs explicit `permits` declarations (unless permitted classes are in the same compilation unit)

---

# Best Practices

✅ Use Records for immutable DTOs.

✅ Use Sealed Classes when only a fixed set of subclasses should exist.

✅ Use `final` if subclasses should not be extended.

✅ Use `non-sealed` only when open inheritance is required.

---

# Common Mistakes

❌ Using Records for mutable JPA entities.

---

❌ Forgetting that Record fields are immutable.

---

❌ Using Sealed Classes when normal inheritance is sufficient.

---

❌ Forgetting to declare subclasses as `final`, `sealed`, or `non-sealed`.

---

# Interview Questions

### 1. What is a Record?

A Record is an immutable data carrier class that automatically generates constructors, accessors, `equals()`, `hashCode()`, and `toString()`.

---

### 2. Why were Records introduced?

To reduce boilerplate code for classes whose primary purpose is to hold data.

---

### 3. Can a Record extend another class?

No.

A Record implicitly extends `java.lang.Record`.

---

### 4. Can a Record have methods?

Yes.

It can contain constructors, static methods, and instance methods.

---

### 5. What is a Compact Constructor?

A constructor without parameter declarations, used mainly for validation.

---

### 6. What is a Sealed Class?

A class that restricts which classes are allowed to extend or implement it.

---

### 7. What are the three modifiers for subclasses of a Sealed Class?

- `final`
- `sealed`
- `non-sealed`

---

### 8. What is the difference between a Sealed Class and a Final Class?

A Final Class allows no subclasses, whereas a Sealed Class allows only selected subclasses.

---

### 9. Where are Records used in Spring Boot?

They are commonly used for DTOs, request bodies, response bodies, and immutable configuration objects.

---

### 10. Where are Sealed Classes useful?

They are useful for modeling restricted hierarchies such as payment methods, shapes, workflow states, and compiler abstract syntax trees.

---

# Quick Revision

### Records

- Introduced in Java 16
- Immutable
- Less boilerplate
- Auto-generated methods
- Great for DTOs

### Sealed Classes

- Introduced in Java 17
- Restrict inheritance
- Uses `permits`
- Subclasses must be `final`, `sealed`, or `non-sealed`

---

# Keywords

- Record
- Immutable
- Compact Constructor
- DTO
- Sealed Class
- permits
- final
- sealed
- non-sealed
- Controlled Inheritance
- Java 16
- Java 17