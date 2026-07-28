v# Profiles

## What are Profiles in Spring?

**Profiles** allow you to use **different configurations for different environments**, such as:

- Development (`dev`)
- Testing (`test`)
- Production (`prod`)

Only the configuration of the **active profile** is loaded.

> **In simple words:**
>
> Profiles let you run the **same application** with **different settings** for different environments.

---

# Why Do We Need Profiles?

Different environments require different configurations.

For example:

| Environment | Database |
|-------------|----------|
| Development | Local MySQL |
| Testing | H2 Database |
| Production | PostgreSQL |

Without Profiles, you would need to manually change the configuration every time.

Profiles solve this problem automatically.

---

# Example

## application.properties

```properties
spring.profiles.active=dev
```

This activates the **dev** profile.

---

# Profile-Specific Configuration Files

Spring supports separate configuration files.

```
application.properties

application-dev.properties

application-test.properties

application-prod.properties
```

Example:

### application-dev.properties

```properties
server.port=8080

spring.datasource.url=jdbc:mysql://localhost:3306/employees
```

---

### application-prod.properties

```properties
server.port=9090

spring.datasource.url=jdbc:postgresql://db-server:5432/employees
```

Spring loads the file based on the active profile.

---

# Activating a Profile

## Method 1: application.properties

```properties
spring.profiles.active=dev
```

---

## Method 2: Command Line

```bash
java -jar app.jar --spring.profiles.active=prod
```

---

## Method 3: Environment Variable

```
SPRING_PROFILES_ACTIVE=prod
```

---

# Using @Profile

You can create Beans for specific profiles.

```java
@Configuration
@Profile("dev")
public class DevConfig {

    @Bean
    public DataSource dataSource() {
        return new DevDataSource();
    }

}
```

This Bean is created **only** when the **dev** profile is active.

---

Another example:

```java
@Service
@Profile("prod")
public class ProductionEmailService {

}
```

This Bean is available only in the **prod** environment.

---

# Multiple Profiles

You can activate multiple profiles.

```properties
spring.profiles.active=dev,test
```

Both profiles become active.

---

# Default Profile

If no profile is specified, Spring uses the **default** profile.

You can define default profiles as needed, or rely on the built-in `default` profile.

---

# Checking Active Profiles

```java
@Autowired
private Environment environment;

public void displayProfiles() {

    String[] profiles = environment.getActiveProfiles();

    for (String profile : profiles) {
        System.out.println(profile);
    }

}
```

Output:

```
dev
```

---

# How Profiles Work

```
Application Starts
        │
        ▼
Read Active Profile
        │
        ▼
Load Profile Configuration
        │
        ▼
Create Profile-Specific Beans
        │
        ▼
Application Ready
```

---

# Real-World Example

Suppose your application runs in three environments.

### Development

```
Database → Local MySQL

Server → localhost

Debug → Enabled
```

---

### Testing

```
Database → H2

Server → Test Server

Debug → Enabled
```

---

### Production

```
Database → PostgreSQL

Server → Cloud Server

Debug → Disabled
```

Using Profiles, you don't change your Java code—only the active profile changes.

---

# Advantages

- Separate configuration for each environment
- Cleaner configuration management
- No manual configuration changes
- Easy deployment
- Better security for production settings

---

# Best Practices

- Create separate configuration files for each environment.
- Never store production secrets directly in source code.
- Use meaningful profile names like `dev`, `test`, and `prod`.
- Keep environment-specific settings outside business logic.

---

# Interview Questions

### 1. What are Profiles in Spring?

Profiles allow different configurations to be used for different environments like development, testing, and production.

---

### 2. How do you activate a profile?

Using:

```properties
spring.profiles.active=dev
```

or

```bash
java -jar app.jar --spring.profiles.active=prod
```

or the `SPRING_PROFILES_ACTIVE` environment variable.

---

### 3. What is `@Profile`?

`@Profile` is an annotation used to make a Bean available only for a specific profile.

---

### 4. Can multiple profiles be active?

Yes.

Example:

```properties
spring.profiles.active=dev,test
```

---

### 5. Why are Profiles important?

They allow the same application to run with different configurations for different environments without changing the code.

---

# Quick Revision

- Profiles provide environment-specific configurations.
- Common profiles are `dev`, `test`, and `prod`.
- Activate a profile using `spring.profiles.active`.
- Use `@Profile` to create Beans for specific environments.
- Store configuration in profile-specific property or YAML files.
- Profiles simplify deployment and configuration management.