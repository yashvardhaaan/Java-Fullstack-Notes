# Docker

## What is Docker?

**Docker** is a platform that allows developers to **build, package, ship, and run applications inside lightweight containers**.

A container includes:

- Application Code
- Runtime
- Libraries
- Dependencies
- Configuration

> **In simple words:**
>
> Docker packages your application along with everything it needs, so it runs the same way on every machine.

---

# Why Do We Need Docker?

Without Docker

```
Developer Laptop

↓

Java 21

↓

MySQL 8

↓

Application Works

↓

Production Server

↓

Different Java Version

↓

Application Fails
```

Problems

- "Works on my machine" issue
- Dependency conflicts
- Different environments

---

With Docker

```
Application

↓

Docker Image

↓

Docker Container

↓

Runs Everywhere
```

Same application.

Same environment.

Same behavior.

---

# Virtual Machine vs Docker

## Virtual Machine

```
Hardware

↓

Operating System

↓

Hypervisor

↓

Guest OS

↓

Application
```

Each VM has its own Operating System.

---

## Docker

```
Hardware

↓

Host Operating System

↓

Docker Engine

↓

Containers

↓

Application
```

Containers share the Host OS kernel.

---

# Docker Architecture

```
Docker Client

↓

Docker Engine

↓

Docker Image

↓

Docker Container
```

---

# Docker Components

## Docker Engine

Runs and manages containers.

---

## Docker Image

Blueprint of an application.

Example

```
Spring Boot

+

Java 21

+

Dependencies

↓

Docker Image
```

---

## Docker Container

A running instance of a Docker Image.

```
Docker Image

↓

Run

↓

Docker Container
```

---

## Docker Hub

A cloud repository that stores Docker images.

Popular Images

- mysql
- postgres
- redis
- nginx
- openjdk
- eclipse-temurin

---

# Docker Workflow

```
Application

↓

Dockerfile

↓

Docker Build

↓

Docker Image

↓

Docker Run

↓

Docker Container
```

---

# Installing Docker

Verify Installation

```bash
docker --version
```

Check Running Containers

```bash
docker ps
```

---

# Dockerfile

A **Dockerfile** contains instructions to build a Docker Image.

Example

```dockerfile
FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY target/app.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
```

---

# Building Docker Image

```bash
docker build -t springboot-app .
```

Explanation

```
docker build

↓

Dockerfile

↓

Image Created
```

---

# Viewing Images

```bash
docker images
```

Example Output

```
REPOSITORY        TAG

springboot-app    latest
```

---

# Running Container

```bash
docker run -p 8080:8080 springboot-app
```

Flow

```
Docker Image

↓

Docker Container

↓

Application Running
```

---

# Run in Background

```bash
docker run -d -p 8080:8080 springboot-app
```

---

# Naming Containers

```bash
docker run

--name spring-app

-p 8080:8080

springboot-app
```

---

# View Running Containers

```bash
docker ps
```

View All Containers

```bash
docker ps -a
```

---

# Stop Container

```bash
docker stop container-id
```

---

# Start Container

```bash
docker start container-id
```

---

# Restart Container

```bash
docker restart container-id
```

---

# Remove Container

```bash
docker rm container-id
```

---

# Remove Image

```bash
docker rmi image-id
```

---

# View Logs

```bash
docker logs container-id
```

---

# Execute Command Inside Container

```bash
docker exec -it container-id bash
```

---

# Port Mapping

```
Host

8080

↓

Container

8080
```

Example

```bash
docker run -p 8080:8080 springboot-app
```

---

# Volume Mapping

Without Volume

```
Container Deleted

↓

Data Lost
```

---

With Volume

```
Container Deleted

↓

Data Saved
```

Example

```bash
docker run

-v mysql-data:/var/lib/mysql

mysql
```

---

# Docker Network

```
Spring Boot Container

↓

Docker Network

↓

MySQL Container

↓

Redis Container
```

Containers communicate using their container or service names.

---

# Spring Boot with Docker

```
Spring Boot Project

↓

mvn clean package

↓

app.jar

↓

Docker Build

↓

Docker Image

↓

Docker Run

↓

Application Live
```

---

# Docker Commands Cheat Sheet

Build Image

```bash
docker build -t app .
```

Run Container

```bash
docker run app
```

Run with Port

```bash
docker run -p 8080:8080 app
```

Run Detached

```bash
docker run -d app
```

Stop Container

```bash
docker stop container-id
```

Remove Container

```bash
docker rm container-id
```

List Images

```bash
docker images
```

List Containers

```bash
docker ps
```

View Logs

```bash
docker logs container-id
```

---

# Docker Lifecycle

```
Dockerfile

↓

Build Image

↓

Run Container

↓

Stop Container

↓

Remove Container
```

---

# Advantages

- Consistent environments.
- Lightweight compared to Virtual Machines.
- Fast startup.
- Easy deployment.
- Easy scaling.
- Platform independent.

---

# Disadvantages

- Shares host operating system kernel.
- Persistent storage requires volumes.
- Containers are isolated but not as strongly as VMs.

---

# Best Practices

- Keep images small.
- Use official base images.
- Pin image versions instead of using `latest`.
- Store secrets outside the image.
- Use multi-stage builds.
- Keep one main process per container.
- Use volumes for persistent data.

---

# Common Mistakes

❌ Using `latest` tag in production.

❌ Running containers as the root user.

❌ Storing passwords inside Dockerfiles.

❌ Creating unnecessarily large images.

❌ Forgetting to expose required ports.

❌ Not using volumes for databases.

---

# Docker vs Virtual Machine

| Docker | Virtual Machine |
|----------|----------------|
| Lightweight | Heavy |
| Fast Startup | Slow Startup |
| Shares Host OS | Separate Guest OS |
| Less Memory | More Memory |
| Containers | Virtual Machines |

---

# Docker Image vs Container

| Image | Container |
|--------|-----------|
| Blueprint | Running Instance |
| Read-only | Read/Write |
| Used to Create Containers | Executes the Application |

---

# Real-World Example

## Spring Boot + MySQL

```
Spring Boot

↓

Docker Image

↓

Docker Container

↓

MySQL Container

↓

Application Running
```

---

## Microservices

```
User Service

↓

Docker

↓

Order Service

↓

Docker

↓

Payment Service

↓

Docker
```

Each microservice runs in its own container.

---

# Interview Questions

### 1. What is Docker?

Docker is a containerization platform used to package applications and their dependencies into portable containers.

---

### 2. What is the difference between an Image and a Container?

An **Image** is a blueprint, while a **Container** is a running instance of that image.

---

### 3. What is a Dockerfile?

A Dockerfile is a text file containing instructions to build a Docker image.

---

### 4. Why is Docker preferred over Virtual Machines?

Docker is lightweight, starts faster, uses fewer resources, and provides consistent environments.

---

### 5. What is Docker Hub?

Docker Hub is a cloud repository for storing and sharing Docker images.

---

### 6. Why are volumes used?

Volumes provide persistent storage so data is not lost when containers are recreated.

---

### 7. What command builds a Docker image?

```bash
docker build -t app .
```

---

### 8. What command runs a container?

```bash
docker run app
```

---

### 9. How do you view running containers?

```bash
docker ps
```

---

### 10. How do containers communicate with each other?

Containers communicate through Docker networks using container or service names.

---

# Quick Revision

- Docker packages applications into **containers**.
- A **Docker Image** is a blueprint.
- A **Docker Container** is a running image.
- A **Dockerfile** defines how to build an image.
- Docker Hub stores container images.
- Use **volumes** for persistent storage.
- Use **networks** for container communication.
- Build with `docker build`.
- Run with `docker run`.
- View running containers using `docker ps`.
- Docker provides consistent environments across development, testing, and production.