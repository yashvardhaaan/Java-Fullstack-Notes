# Annotation Processing (Java)

## What is Annotation Processing?

**Annotation Processing** is a mechanism in Java that reads annotations during **compile time** and can generate new source code, validate code, or perform other compile-time tasks.

Unlike Reflection, Annotation Processing happens **before the program runs**.

> **Definition:** Annotation Processing is the process of analyzing annotations at compile time and generating code or performing validation.

---

# Why Do We Need Annotation Processing?

Suppose every Java class needs:

- Getters
- Setters
- Constructors
- Builder
- equals()
- hashCode()

Writing them manually is repetitive.

Without Annotation Processing

```java
class Student {

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
```

With Lombok

```java
@Getter
@Setter

class Student {

    private String name;

}
```

During compilation, Lombok automatically generates the getter and setter methods.

---

# Real-World Example

Imagine a factory.

```
Blueprint

↓

Machine Reads Blueprint

↓

Automatically Builds Product
```

Similarly,

```
Java Source Code

↓

Annotations

↓

Annotation Processor

↓

Generated Java Code

↓

Compilation
```

---

# Compile-Time vs Runtime

```text
Compile Time

↓

Annotation Processing

↓

.class File

↓

Run Program

↓

Reflection (Optional)
```

Annotation Processing happens **before** the application starts.

Reflection happens **while** the application is running.

---

# How Annotation Processing Works

```text
Java Source Code

↓

Compiler (javac)

↓

Annotation Processor

↓

Reads Annotations

↓

Generates Source Files

↓

Compiler Compiles Generated Files

↓

.class Files
```

---

# Annotation Processor

An Annotation Processor is a Java class that extends

```java
AbstractProcessor
```

Example

```java
public class MyProcessor

extends AbstractProcessor {

}
```

The processor is executed automatically during compilation.

---

# Processing Rounds

Annotation Processing may happen in multiple rounds.

```text
Round 1

↓

Generate New Source Files

↓

Round 2

↓

Process Newly Generated Files

↓

Compilation Complete
```

The compiler continues processing until no new source files are generated.

---

# Generated Code

Example

Source Code

```java
@Getter

class Student {

    private String name;

}
```

Generated Code

```java
class Student {

    private String name;

    public String getName() {

        return name;

    }

}
```

The developer never writes the generated method.

---

# Common Annotation Processing Libraries

## Lombok

Generates

- Getters
- Setters
- Constructors
- Builder
- toString()
- equals()
- hashCode()

Example

```java
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
```

---

## MapStruct

Generates object mapping code.

Example

```java
@Mapper

interface UserMapper {

}
```

Automatically generates

```text
User

↓

UserDTO
```

conversion code.

---

## AutoValue

Google library for generating immutable value classes.

Example

```java
@AutoValue

abstract class Employee {

}
```

---

## Dagger

Uses Annotation Processing to generate dependency injection code.

---

# Java Compiler API

Annotation Processing is supported by the Java Compiler (`javac`).

Important package

```java
javax.annotation.processing
```

Common classes

- AbstractProcessor
- Processor
- ProcessingEnvironment
- RoundEnvironment

---

# Supported Annotation Types

A processor specifies which annotations it handles.

Example

```java
@SupportedAnnotationTypes(

"com.example.Author"

)
```

---

# Supported Java Version

```java
@SupportedSourceVersion(

SourceVersion.RELEASE_21

)
```

Specifies the Java version supported by the processor.

---

# Internal Working

Suppose

```java
@Getter

class Student {

}
```

Internally

```text
Source Code

↓

javac

↓

Annotation Processor

↓

Read Annotation

↓

Generate Java Code

↓

Compile Generated Code

↓

.class File
```

The generated code becomes part of the final compiled application.

---

# Annotation Processing vs Reflection

| Annotation Processing | Reflection |
|----------------------|------------|
| Compile time | Runtime |
| Generates code | Reads existing code |
| Faster at runtime | Runtime overhead |
| Uses `javac` | Uses JVM |
| Used by Lombok | Used by Spring |

---

# Production Usage

Annotation Processing is used by many Java libraries.

## Lombok

```java
@Getter

@Setter

@Builder

@Data
```

Generates boilerplate code.

---

## MapStruct

```java
@Mapper
```

Generates mapping classes.

---

## Dagger

Generates dependency injection code.

---

## AutoValue

Generates immutable objects.

---

## Micronaut

Generates dependency injection metadata during compilation to reduce runtime reflection.

---

# Advantages

- Reduces boilerplate code
- Compile-time validation
- Faster runtime
- Generates efficient code
- Improves developer productivity

---

# Limitations

- More complex to implement
- Build process becomes more complex
- Generated code can make debugging harder
- Requires build tool support (Maven/Gradle)

---

# Best Practices

✅ Prefer well-tested libraries like Lombok and MapStruct.

✅ Keep custom processors focused on one responsibility.

✅ Review generated code when debugging.

✅ Use Annotation Processing for compile-time tasks, not runtime behavior.

---

# Common Mistakes

❌ Confusing Annotation Processing with Reflection.

---

❌ Expecting processors to run at runtime.

---

❌ Writing processors for problems that don't require code generation.

---

❌ Forgetting to enable annotation processing in the IDE.

---

# Interview Questions

### 1. What is Annotation Processing?

It is the process of reading annotations during compilation to generate code or validate source code.

---

### 2. When does Annotation Processing happen?

During **compile time**.

---

### 3. Which class is commonly extended to create an Annotation Processor?

```java
AbstractProcessor
```

---

### 4. Which package provides Annotation Processing APIs?

```java
javax.annotation.processing
```

---

### 5. What is the difference between Reflection and Annotation Processing?

- Annotation Processing works at compile time.
- Reflection works at runtime.

---

### 6. Does Annotation Processing generate Java code?

Yes.

It can generate Java source files and other resources.

---

### 7. Name some libraries that use Annotation Processing.

- Lombok
- MapStruct
- AutoValue
- Dagger

---

### 8. Does Spring Boot mainly use Reflection or Annotation Processing?

Spring Boot primarily uses **Reflection** at runtime, although some Spring ecosystem projects and related tools use annotation processing for specific compile-time optimizations.

---

### 9. Why is Lombok fast at runtime?

Because the required methods are generated during compilation, so no runtime generation is needed.

---

### 10. Can we write our own Annotation Processor?

Yes.

By extending `AbstractProcessor` and registering the processor with the Java compiler.

---

# Quick Revision

- Annotation Processing = Compile-time annotation handling.
- Runs inside `javac`.
- Reads annotations.
- Can generate source code.
- Can validate code.
- Uses `AbstractProcessor`.
- Common libraries:
  - Lombok
  - MapStruct
  - AutoValue
  - Dagger
- Different from Reflection.
- Improves runtime performance by shifting work to compile time.

---

# Keywords

- Annotation Processing
- AbstractProcessor
- Processor
- javac
- Compile Time
- Reflection
- Lombok
- MapStruct
- AutoValue
- Dagger
- ProcessingEnvironment
- RoundEnvironment
- Generated Code
- Java Compiler API
- javax.annotation.processing
```