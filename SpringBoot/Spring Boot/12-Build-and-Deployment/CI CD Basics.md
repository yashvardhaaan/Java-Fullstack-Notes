# CI/CD Basics

## What is CI/CD?

**CI/CD** stands for:

- **CI** → Continuous Integration
- **CD** → Continuous Delivery / Continuous Deployment

CI/CD is a software development practice that automates the process of **building, testing, and deploying applications**.

> **In simple words:**
>
> Instead of manually building and deploying your application every time you make a change, CI/CD automatically performs these tasks whenever code is pushed to the repository.

---

# Why Do We Need CI/CD?

Without CI/CD

```
Developer

↓

Write Code

↓

Manual Build

↓

Manual Testing

↓

Manual Deployment

↓

Production
```

Problems

- Slow releases
- Human errors
- Inconsistent deployments
- Difficult rollbacks

---

With CI/CD

```
Developer

↓

Git Push

↓

Automatic Build

↓

Automatic Tests

↓

Automatic Deployment

↓

Production
```

Benefits

- Faster releases
- Reliable deployments
- Fewer bugs
- Improved collaboration

---

# What is Continuous Integration (CI)?

Continuous Integration means developers frequently merge their code into a shared repository.

Every commit automatically triggers:

- Build
- Unit Tests
- Static Code Analysis
- Security Checks

Flow

```
Developer

↓

Git Push

↓

CI Pipeline

↓

Build

↓

Test

↓

Success / Failure
```

If the build fails, developers are notified immediately.

---

# What is Continuous Delivery (CD)?

Continuous Delivery means the application is automatically prepared for deployment.

Deployment to production requires **manual approval**.

Flow

```
Build

↓

Tests

↓

Package

↓

Deploy to Staging

↓

Manual Approval

↓

Production
```

---

# What is Continuous Deployment?

Continuous Deployment goes one step further.

After all tests pass, the application is automatically deployed to production.

Flow

```
Code Push

↓

Build

↓

Tests

↓

Deploy

↓

Production
```

No manual approval is required.

---

# CI vs Continuous Delivery vs Continuous Deployment

| Feature | CI | Continuous Delivery | Continuous Deployment |
|----------|----|---------------------|-----------------------|
| Build Automation | ✅ | ✅ | ✅ |
| Automated Testing | ✅ | ✅ | ✅ |
| Deploy to Staging | ❌ | ✅ | ✅ |
| Manual Approval | ❌ | ✅ | ❌ |
| Automatic Production Deployment | ❌ | ❌ | ✅ |

---

# Complete CI/CD Pipeline

```
Developer

↓

Git Push

↓

Source Control (GitHub)

↓

CI Pipeline

↓

Compile

↓

Run Tests

↓

Code Quality Check

↓

Package Application

↓

Create Docker Image

↓

Push Image

↓

Deploy

↓

Production
```

---

# Typical Pipeline Stages

## 1. Source

```
GitHub

↓

Code Push
```

---

## 2. Build

Example

```bash
mvn clean package
```

Produces

```
target/

↓

application.jar
```

---

## 3. Test

Run

- Unit Tests
- Integration Tests
- API Tests

Example

```bash
mvn test
```

---

## 4. Code Quality

Common tools

- SonarQube
- Checkstyle
- PMD
- SpotBugs

Purpose

- Detect bugs
- Maintain coding standards
- Improve code quality

---

## 5. Package

Generate deployable artifact.

Example

```
application.jar
```

or

```
Docker Image
```

---

## 6. Deploy

Possible deployment targets

- Development
- Testing
- Staging
- Production

---

# Popular CI/CD Tools

| Tool | Purpose |
|------|----------|
| GitHub Actions | CI/CD Automation |
| Jenkins | Automation Server |
| GitLab CI/CD | Integrated CI/CD |
| Azure DevOps | Build & Deploy |
| CircleCI | Cloud CI/CD |
| Travis CI | Continuous Integration |
| AWS CodePipeline | AWS CI/CD |

---

# GitHub Actions Workflow

Project Structure

```
.github

└── workflows

    └── ci.yml
```

Example

```yaml
name: Spring Boot CI

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-java@v4
        with:
          java-version: '21'
          distribution: 'temurin'

      - run: mvn clean verify
```

---

# Jenkins Pipeline

```
GitHub

↓

Jenkins

↓

Build

↓

Test

↓

Deploy
```

Jenkins uses a `Jenkinsfile` to define the pipeline.

---

# CI/CD with Docker

```
Git Push

↓

Build Application

↓

Create Docker Image

↓

Push to Registry

↓

Deploy Container
```

---

# CI/CD with Spring Boot

```
Developer

↓

Git Push

↓

GitHub Actions

↓

Maven Build

↓

JUnit Tests

↓

Spring Boot JAR

↓

Docker Image

↓

Deploy
```

---

# Best Practices

- Commit code frequently.
- Keep builds fast.
- Automate testing.
- Never skip failed tests.
- Use separate environments (Dev, QA, Staging, Production).
- Store secrets securely.
- Version application artifacts.
- Monitor deployments.
- Roll back quickly if deployment fails.

---

# Common Mistakes

❌ Deploying without testing.

❌ Keeping long-running pipelines.

❌ Hardcoding passwords or API keys.

❌ Ignoring failed builds.

❌ Deploying directly to production without staging.

❌ Not using version control.

---

# Advantages

- Faster software delivery.
- Higher code quality.
- Reduced manual work.
- Faster bug detection.
- Consistent deployments.
- Improved team collaboration.
- Easy rollback and recovery.

---

# Real-World Example

## E-Commerce Application

```
Developer

↓

Push Code

↓

GitHub

↓

GitHub Actions

↓

Build

↓

Run Tests

↓

Create Docker Image

↓

Deploy to AWS

↓

Production
```

---

## Banking Application

```
Developer

↓

CI Pipeline

↓

Security Checks

↓

Unit Tests

↓

Integration Tests

↓

Manual Approval

↓

Production
```

Continuous Delivery is commonly used because manual approval is required before production deployment.

---

# Interview Questions

### 1. What is CI/CD?

CI/CD is a software development practice that automates building, testing, and deploying applications.

---

### 2. What is Continuous Integration?

Continuous Integration is the practice of automatically building and testing code whenever developers commit changes to a shared repository.

---

### 3. What is the difference between Continuous Delivery and Continuous Deployment?

- **Continuous Delivery** automatically prepares software for deployment but requires manual approval before production.
- **Continuous Deployment** automatically deploys to production once all checks pass.

---

### 4. What are the stages of a CI/CD pipeline?

Typical stages are:

- Source
- Build
- Test
- Code Quality
- Package
- Deploy
- Monitor

---

### 5. Which CI/CD tools are commonly used?

- GitHub Actions
- Jenkins
- GitLab CI/CD
- Azure DevOps
- CircleCI
- AWS CodePipeline

---

### 6. Why is CI/CD important?

It improves code quality, reduces manual effort, speeds up releases, and ensures reliable deployments.

---

### 7. How is CI/CD used with Spring Boot?

A typical Spring Boot pipeline builds the project using Maven or Gradle, runs automated tests, packages the application as a JAR or Docker image, and deploys it to a server or cloud platform.

---

# Quick Revision

- **CI** = Automatically Build + Test.
- **Continuous Delivery** = Ready for deployment after manual approval.
- **Continuous Deployment** = Automatically deploy to production.
- Typical pipeline: **Source → Build → Test → Package → Deploy → Monitor**.
- Popular tools: GitHub Actions, Jenkins, GitLab CI/CD, Azure DevOps, AWS CodePipeline.
- Always automate testing and keep secrets secure.
- CI/CD enables faster, safer, and more reliable software releases.