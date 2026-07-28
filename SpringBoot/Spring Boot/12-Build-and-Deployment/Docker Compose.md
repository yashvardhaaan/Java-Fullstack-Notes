# Docker Compose

## What is Docker Compose?

**Docker Compose** is a tool used to **define and run multiple Docker containers** using a single configuration file called **docker-compose.yml**.

Instead of starting each container manually, Docker Compose starts all required services with one command.

> **In simple words:**
>
> Docker Compose allows you to run an entire application (Backend + Database + Redis + etc.) using a single command.

---

# Why Do We Need Docker Compose?

Without Docker Compose

```
Start MySQL

↓

Start Redis

↓

Start Spring Boot

↓

Connect Networks

↓

Configure Ports

↓

Run Application
```

Everything is done manually.

---

With Docker Compose

```
docker compose up

↓

MySQL Started

↓

Redis Started

↓

Spring Boot Started

↓

Application Ready
```

Everything starts automatically.

---

# Real-World Example

Imagine an E-Commerce Application.

Components

```
Spring Boot

↓

MySQL

↓

Redis

↓

RabbitMQ
```

Instead of running four containers separately,

Docker Compose starts them all together.

---

# Docker Compose Architecture

```
docker-compose.yml

↓

Docker Compose

↓

Spring Boot Container

↓

MySQL Container

↓

Redis Container

↓

Application Running
```

---

# How Docker Compose Works

```
Read docker-compose.yml

↓

Create Network

↓

Create Volumes

↓

Create Containers

↓

Start Services

↓

Application Ready
```

---

# Install Docker Compose

Modern Docker Desktop already includes Docker Compose.

Check Version

```bash
docker compose version
```

---

# Basic docker-compose.yml

```yaml
version: "3.9"

services:

  app:
    image: my-spring-app

  mysql:
    image: mysql:8
```

---

# Docker Compose Structure

```
docker-compose.yml

├── services

├── volumes

└── networks
```

---

# Example: Spring Boot + MySQL

```yaml
version: "3.9"

services:

  app:

    build: .

    ports:

      - "8080:8080"

    depends_on:

      - mysql

    environment:

      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/demo

      SPRING_DATASOURCE_USERNAME: root

      SPRING_DATASOURCE_PASSWORD: password

  mysql:

    image: mysql:8

    environment:

      MYSQL_ROOT_PASSWORD: password

      MYSQL_DATABASE: demo

    ports:

      - "3306:3306"
```

---

# Service Communication

Containers communicate using service names.

```
Spring Boot

↓

mysql

↓

MySQL Container
```

Database URL

```properties
jdbc:mysql://mysql:3306/demo
```

Notice that **mysql** is the service name, not localhost.

---

# Build vs Image

Using Existing Image

```yaml
image: mysql:8
```

---

Building Your Own Image

```yaml
build: .
```

Docker Compose builds the Dockerfile automatically.

---

# Mapping Ports

```yaml
ports:

  - "8080:8080"
```

Meaning

```
Host

8080

↓

Container

8080
```

---

# Environment Variables

```yaml
environment:

  SPRING_PROFILES_ACTIVE: prod
```

Used for

- Database Credentials
- API Keys
- Spring Profiles

---

# depends_on

```yaml
depends_on:

  - mysql
```

Flow

```
MySQL

↓

Starts First

↓

Spring Boot

↓

Starts Next
```

> **Note:** `depends_on` controls startup order but does not wait until the database is fully ready.

---

# Volumes

Volumes store persistent data.

```yaml
volumes:

  mysql-data:
```

Mount Volume

```yaml
services:

  mysql:

    volumes:

      - mysql-data:/var/lib/mysql

volumes:

  mysql-data:
```

Without volumes

```
Container Deleted

↓

Database Lost
```

With volumes

```
Container Deleted

↓

Database Still Exists
```

---

# Networks

Docker Compose automatically creates a network.

```
Spring Boot

↓

Docker Network

↓

MySQL

↓

Redis
```

Containers communicate privately within this network.

---

# Common Docker Compose Commands

Start

```bash
docker compose up
```

---

Start in Background

```bash
docker compose up -d
```

---

Stop

```bash
docker compose down
```

---

View Containers

```bash
docker compose ps
```

---

View Logs

```bash
docker compose logs
```

---

Restart

```bash
docker compose restart
```

---

Build Again

```bash
docker compose up --build
```

---

# Docker Compose Workflow

```
Write docker-compose.yml

↓

docker compose up

↓

Images Downloaded

↓

Containers Created

↓

Application Starts
```

---

# Project Structure

```
project

├── Dockerfile

├── docker-compose.yml

├── pom.xml

└── src
```

---

# Spring Boot with Docker Compose

```
Spring Boot Source

↓

Dockerfile

↓

Docker Image

↓

docker-compose.yml

↓

Spring Boot Container

↓

MySQL Container

↓

Application Running
```

---

# Advantages

- Starts multiple containers with one command.
- Easy environment setup.
- Simplifies local development.
- Automatic networking.
- Persistent storage using volumes.
- Easy to share with teams.

---

# Disadvantages

- Mainly intended for single-host environments.
- Not suitable for large-scale container orchestration.
- Limited scaling compared to Kubernetes.

---

# Best Practices

- Keep secrets outside the Compose file.
- Use named volumes for databases.
- Use `depends_on` appropriately.
- Pin image versions (for example, `mysql:8.4` instead of `latest`).
- Use environment variables for configuration.
- Separate development and production Compose files if needed.

---

# Common Mistakes

❌ Using `localhost` inside containers.

❌ Not using volumes for databases.

❌ Hardcoding passwords.

❌ Forgetting to rebuild after Dockerfile changes.

❌ Using `latest` image tags in production.

---

# Real-World Example

## Spring Boot + MySQL

```
Spring Boot

↓

Docker Compose

↓

MySQL

↓

Application Running
```

---

## E-Commerce System

```
Spring Boot

↓

MySQL

↓

Redis

↓

RabbitMQ

↓

Docker Compose
```

Everything starts with

```bash
docker compose up -d
```

---

# Docker Compose vs Docker

| Docker | Docker Compose |
|---------|----------------|
| Manages one container | Manages multiple containers |
| Uses `docker run` | Uses `docker-compose.yml` |
| Manual networking | Automatic networking |
| Manual startup | Single-command startup |

---

# Docker Compose vs Kubernetes

| Docker Compose | Kubernetes |
|----------------|------------|
| Local Development | Production Orchestration |
| Single Machine | Multiple Machines |
| Simple | Advanced |
| Easy Setup | Highly Scalable |

---

# Interview Questions

### 1. What is Docker Compose?

Docker Compose is a tool used to define and run multi-container Docker applications using a YAML configuration file.

---

### 2. What is the purpose of `docker-compose.yml`?

It defines services, networks, volumes, ports, environment variables, and other configuration required to run the application.

---

### 3. What does `depends_on` do?

It controls the startup order of containers but does **not** guarantee that a dependent service is fully ready.

---

### 4. Why are volumes used?

Volumes provide persistent storage so that data is not lost when containers are removed or recreated.

---

### 5. Why shouldn't we use `localhost` inside Docker containers?

Each container has its own network namespace. Containers should communicate using the **service name** defined in `docker-compose.yml`.

---

### 6. What command starts all services?

```bash
docker compose up
```

---

### 7. How do you stop and remove containers created by Docker Compose?

```bash
docker compose down
```

---

# Quick Revision

- Docker Compose manages **multiple Docker containers**.
- Configuration is stored in **docker-compose.yml**.
- Start everything with `docker compose up`.
- Stop everything with `docker compose down`.
- Use **service names** for container-to-container communication.
- Use **volumes** for persistent database storage.
- Docker Compose automatically creates a network for all services.
- Ideal for local development and small deployments.