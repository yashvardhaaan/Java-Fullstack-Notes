# `09-Command-Injection.md`

# Command Injection

## 1. First Principle

**Command Injection occurs when untrusted user input is incorporated into an operating-system command and the attacker can influence what commands the server executes.**

Mental model:

```text
User Input
    ↓
Application
    ↓
OS Command
    ↓
Operating System
```

The core mistake is:

> **Treating untrusted input as part of a command instead of ordinary data.**

---

# 2. Normal Example

Suppose a server provides a network diagnostic feature:

```text
User enters:
example.com
```

Application executes something conceptually like:

```text
ping example.com
```

The intended input is:

```text
example.com
```

The danger occurs when the application constructs shell commands by concatenating untrusted input.

```text
Command = "ping " + userInput
```

---

# 3. Why Command Injection Happens

Unsafe architecture:

```text
User Input
    ↓
String Concatenation
    ↓
Shell Command
    ↓
OS
```

Secure architecture:

```text
Validated Input
    ↓
Safe API / Process Execution
    ↓
Specific Program
```

The best defense is often to **avoid invoking a shell entirely**.

---

# 4. Command Injection vs SQL Injection

They follow a similar fundamental principle but target different interpreters.

| SQL Injection | Command Injection |
|---|---|
| Targets database | Targets operating system |
| Input becomes SQL | Input becomes OS command |
| Use parameterized queries | Avoid shell + validate arguments |
| Database compromise | Potential server compromise |

Mental model:

```text
SQLi:
Input → SQL → Database

Command Injection:
Input → Command → OS
```

---

# 5. Dangerous Java Example

A dangerous pattern is:

```java
String command = "ping " + hostname;
Runtime.getRuntime().exec(command);
```

The problem is allowing external input to directly influence command execution.

Even when `Runtime.exec()` is used, developers should carefully understand how arguments are parsed and whether a shell is involved.

The safest approach is generally to avoid shell interpretation and pass fixed executable arguments separately.

---

# 6. Safer Java Approach

For a controlled diagnostic function:

```java
ProcessBuilder process =
    new ProcessBuilder("ping", "-c", "4", hostname);

Process p = process.start();
```

Conceptually:

```text
Executable
   ↓
ping

Arguments
   ↓
-c
4
hostname
```

rather than constructing one shell command string.

Still validate `hostname` according to the application's expected format.

---

# 7. Shell Injection

Shells interpret special syntax.

Examples of shell metacharacters include concepts such as:

```text
;
&
|
$
`
>
<
```

If untrusted input reaches a shell without proper controls, the shell may interpret syntax rather than treating the input as simple data.

Therefore:

```text
User Input
   ↓
Shell
```

is a high-risk boundary.

---

# 8. Industry Example — Image Processing

Imagine an application accepts:

```text
filename = photo.jpg
```

and executes an image-processing utility.

Unsafe design:

```text
"convert " + filename + " output.png"
```

Better:

```text
Fixed executable
+
Validated filename
+
Separate arguments
```

Even better:

```text
Application
   ↓
Trusted image-processing library
```

when a suitable library can perform the operation without spawning a shell.

---

# 9. Industry Example — File Compression

Suppose a web application allows users to create ZIP archives.

Bad architecture:

```text
User filename
     ↓
Shell command
     ↓
zip ...
```

Better:

```text
User filename
     ↓
Validate filename/path
     ↓
Application/library API
     ↓
Create archive
```

Avoiding the shell removes an entire class of command-injection risks.

---

# 10. Input Validation

Validation should match the expected input.

For example, if the application expects a hostname:

```text
example.com
```

validate that the value is actually a hostname according to your application's requirements.

Don't rely on:

```text
"Remove dangerous characters"
```

as the primary defense.

Prefer:

```text
Allow expected format
+
Reject unexpected input
```

This is called **allowlisting**.

---

# 11. Avoid the Shell

One of the strongest defenses:

```text
❌ User Input
      ↓
   /bin/sh
      ↓
   Command
```

Prefer:

```text
✓ Application
      ↓
Specific executable
      +
Separate arguments
```

For example:

```java
new ProcessBuilder(
    "ping",
    "-c",
    "4",
    validatedHostname
);
```

The exact command and options depend on the operating system.

---

# 12. OS Differences

Command execution differs across operating systems.

Linux commonly uses:

```text
/bin/sh
/bin/bash
```

Windows commonly uses:

```text
cmd.exe
PowerShell
```

Therefore, an application that is safe on one platform isn't automatically safe on another if it constructs shell commands differently.

Security testing must consider the actual deployment environment.

---

# 13. Path Traversal vs Command Injection

These are different vulnerabilities.

### Path Traversal

Attacker manipulates a file path:

```text
Application
   ↓
Unexpected file path
   ↓
Unauthorized file access
```

### Command Injection

Attacker influences an operating-system command:

```text
Application
   ↓
Unexpected command syntax
   ↓
OS executes unintended command
```

They can sometimes appear together in poorly designed file-processing applications.

---

# 14. Impact

Successful command injection can potentially lead to:

```text
Command execution
File access
Data theft
Credential exposure
Application compromise
Persistence
Lateral movement
System disruption
```

Impact depends heavily on the privileges of the application process.

---

# 15. Least Privilege

Suppose the web application runs as:

```text
root
```

A command-injection vulnerability could have extremely serious consequences.

Better:

```text
Web Application
      ↓
Restricted OS account
      ↓
Minimum permissions
```

For example:

```text
Cannot modify system files
Cannot access unrelated secrets
Cannot install software
Cannot administer the system
```

Least privilege reduces blast radius.

---

# 16. Container Security

Running an application inside a container can provide an additional isolation boundary.

For example:

```text
Internet
   ↓
Web Application
   ↓
Container
   ↓
Restricted permissions
```

But:

> Containers are not a replacement for secure coding.

A vulnerable application inside a container can still be compromised.

Use:

```text
Secure coding
+
Least privilege
+
Container isolation
+
Network restrictions
```

---

# 17. Small Hands-On Lab

Use a local machine or intentionally vulnerable training application.

Create a simple Java program:

```java
String hostname = "example.com";

ProcessBuilder process =
    new ProcessBuilder("ping", "-c", "2", hostname);

Process p = process.start();

int exitCode = p.waitFor();

System.out.println("Exit code: " + exitCode);
```

Understand the separation:

```text
Program:
ping

Arguments:
-c
2
example.com
```

Now compare this conceptually with:

```text
"ping " + userInput
```

The security goal is to prevent user input from becoming arbitrary shell syntax.

---

# 18. Secure Testing Methodology

For an application you own or are authorized to test:

```text
1. Identify features that execute OS utilities
2. Find user-controlled parameters
3. Determine whether a shell is involved
4. Review how arguments are passed
5. Check allowlist validation
6. Review process privileges
7. Check application logs
8. Test only in a controlled environment
```

Examples of features worth reviewing:

```text
Ping/diagnostics
File conversion
Archive creation
PDF generation
Video processing
Git integration
Backup tools
System utilities
```

---

# 19. SOC Relevance

Command injection can produce strong host-level indicators.

For example:

```text
Web Server Process
      ↓
Unexpected Child Process
      ↓
Shell
      ↓
Unusual Utility
```

A SOC analyst might investigate:

```text
Parent process
Child process
Command-line arguments
User/account
Timestamp
Network connections
File modifications
```

A suspicious process tree might conceptually look like:

```text
Web Server
   ↓
Shell
   ↓
Unexpected Utility
```

This is often more useful than looking at the HTTP request alone.

---

# 20. Industry-Level SOC Example

Suppose:

```text
Spring Boot Application
        ↓
Unexpected shell process
        ↓
Outbound network connection
```

The SOC should correlate:

```text
HTTP logs
+
Application logs
+
Process creation telemetry
+
Network connections
+
File activity
```

This can help determine whether the event represents:

```text
Normal application behavior
vs
Potential command injection
vs
Compromised server
```

---

# 21. Common Mistakes

### ❌ Building shell commands with string concatenation

```java
"ping " + userInput
```

### ❌ Relying only on blacklist filtering

Rejecting a few known characters is fragile.

### ❌ Running applications as root/Administrator

Increases impact.

### ❌ Assuming containers solve command injection

They only provide additional isolation.

### ❌ Allowing unnecessary OS commands

If functionality doesn't require shell execution, don't provide it.

### ❌ Exposing command output directly to users

This can reveal sensitive system information.

---

# 22. Interview Questions

### Q1. What is command injection?

A vulnerability where attacker-controlled input influences operating-system command execution.

### Q2. How is it different from SQL injection?

```text
SQLi
→ Database interpreter

Command Injection
→ Operating-system command interpreter
```

### Q3. Best defense?

Avoid shell execution where possible and use safe process APIs with fixed executables, separate arguments, and strict validation.

### Q4. Why is least privilege important?

It limits what an attacker can do if command execution is achieved.

### Q5. Is input validation enough?

No. Use safe APIs and avoid shell interpretation.

### Q6. Why can command injection be serious?

Because the vulnerable application may execute attacker-controlled operations with the application's OS privileges.

---

# 23. Quick Cheat Sheet

```text
Command Injection
→ Untrusted input influences OS commands

Main Risk
→ Arbitrary command execution

Best Defense
→ Avoid shell

Prefer
→ Safe process APIs
→ Separate arguments
→ Allowlist validation
→ Least privilege

Avoid
→ Shell + string concatenation

Impact
→ File access
→ Data theft
→ Server compromise
→ Lateral movement
```

## Core Mental Model

```text
              USER INPUT
                   ↓
            ┌─────────────┐
            │ APPLICATION │
            └──────┬──────┘
                   ↓
          ┌─────────────────┐
          │  SAFE PROCESS   │
          │     API         │
          └────────┬────────┘
                   ↓
             Fixed Program
                   +
            Valid Arguments
                   ↓
                 OS
```

**Next:** `10-Path-Traversal.md`