### `07-LLM-APPLICATIONS/04-structured-output.md`

````md
# Structured Output

## 1. What is Structured Output?

Structured output means forcing an LLM to return data in a **specific format**, such as JSON.

Instead of:

"Rahul is 21 years old and lives in Pune."

We want:

```json
{
  "name": "Rahul",
  "age": 21,
  "city": "Pune"
}
````

---

## 2. Why is it Needed?

LLMs normally generate free-form text.

But software needs predictable data.

```text
LLM
 ↓
Unstructured text
 ↓
Hard to process
```

Structured output:

```text
LLM
 ↓
JSON / Schema
 ↓
Application
 ↓
Easy to process
```

It is especially important when an LLM's response is consumed by another program.

---

## 3. Where is it Used?

Common applications:

* Data extraction
* RAG systems
* AI agents
* Customer support
* Resume parsing
* Invoice processing
* Classification
* Database operations
* Backend APIs

Example:

```text
Invoice
   ↓
LLM
   ↓
Structured JSON
   ↓
Database
```

---

## 4. How Does It Work?

Tell the model exactly what structure is required.

Example:

```text
Extract:
- name
- email
- phone

Return JSON only.
```

Input:

```text
"Contact Rahul at rahul@example.com
or call 9876543210."
```

Output:

```json
{
  "name": "Rahul",
  "email": "rahul@example.com",
  "phone": "9876543210"
}
```

For production systems, prefer **schema-constrained/structured-output features** provided by the model/API when available rather than relying only on prompting.

---

## 5. Schema

A schema defines what the output should contain.

Example:

```json
{
  "name": "string",
  "age": "integer",
  "email": "string"
}
```

The application can validate the LLM response against this expected structure.

---

## 6. Practical Python Example

Using Pydantic:

```python
from pydantic import BaseModel

class Person(BaseModel):
    name: str
    age: int
    email: str
```

The expected LLM response can then be validated against `Person`.

```text
LLM Response
     ↓
JSON
     ↓
Pydantic Validation
     ↓
Valid Data
```

If the response does not match the schema, the application can reject or retry it.

---

## 7. Structured Output vs Normal Output

### Normal

```text
"The customer is Rahul, age 21."
```

### Structured

```json
{
  "name": "Rahul",
  "age": 21
}
```

Structured output is much easier for code to consume.

---

## 8. When Should You Use It?

Use structured output when:

* Another program consumes the response.
* You need predictable fields.
* Data must be stored in a database.
* You are building an API.
* You need reliable extraction.
* You are building an AI agent.

For simple conversations, normal text is usually sufficient.

---

## 9. Industry Example

Resume-processing system:

```text
Resume PDF
    ↓
LLM
    ↓
Structured Output
    ↓
{
  name,
  skills,
  experience,
  education
}
    ↓
Database
```

This converts unstructured documents into application-ready data.

---

## GATE / Interview Points

* Structured output makes LLM responses machine-readable.
* JSON is a common format.
* Schemas define the expected structure.
* Validation is important because LLM output should not be blindly trusted.
* Structured output is useful for APIs, databases, extraction and agents.
* Prompting alone is less reliable than schema-constrained output when strict structure is required.

---

## Mental Model

> **Structured Output = Make the LLM return data in a format your software can reliably understand.**

```

Next: `05-streaming.md`
```
