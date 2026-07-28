# Deploy to AWS

## What is AWS?

**AWS (Amazon Web Services)** is a cloud computing platform that provides services like:

- Virtual Servers (EC2)
- Storage (S3)
- Databases (RDS)
- Networking
- Load Balancers
- Monitoring
- Security

It allows you to deploy applications without owning physical servers.

> **In simple words:**
>
> AWS lets you rent computers over the internet to host your applications.

---

# Why Do We Deploy to AWS?

During development

```
Your Laptop

↓

Spring Boot Application

↓

localhost:8080
```

Only you can access it.

---

After deployment

```
Internet

↓

AWS Server

↓

Spring Boot Application

↓

Anyone can access it
```

---

# Common AWS Services for Spring Boot

| Service | Purpose |
|----------|----------|
| EC2 | Virtual Machine |
| S3 | File Storage |
| RDS | Managed Database |
| IAM | User & Permission Management |
| VPC | Private Network |
| ELB | Load Balancer |
| Route 53 | DNS Management |
| CloudWatch | Monitoring & Logs |
| ECR | Docker Image Registry |
| ECS | Container Deployment |

---

# AWS Architecture

```
User

↓

Internet

↓

Route 53

↓

Load Balancer

↓

EC2 Instance

↓

Spring Boot Application

↓

RDS Database
```

---

# Most Common Deployment Flow

```
Developer

↓

Build Application

↓

Create JAR

↓

Upload to EC2

↓

Run Spring Boot

↓

Application Live
```

---

# Step 1: Launch an EC2 Instance

Choose

- Ubuntu Linux
- Amazon Linux

Example

```
EC2

↓

Ubuntu 24.04

↓

t2.micro

↓

Public IP Assigned
```

---

# Step 2: Connect to EC2

Using SSH

```bash
ssh -i key.pem ubuntu@YOUR_PUBLIC_IP
```

---

# Step 3: Install Java

Check Java

```bash
java -version
```

Install Java (Ubuntu)

```bash
sudo apt update

sudo apt install openjdk-21-jdk
```

Verify

```bash
java -version
```

---

# Step 4: Upload Spring Boot JAR

Example

```bash
scp -i key.pem target/app.jar ubuntu@YOUR_PUBLIC_IP:/home/ubuntu
```

Now the JAR is available on the EC2 server.

---

# Step 5: Run the Application

```bash
java -jar app.jar
```

Application starts

```
Tomcat started

↓

Port 8080
```

---

# Step 6: Open Security Group

Allow inbound traffic

```
HTTP

Port 80
```

```
HTTPS

Port 443
```

```
Spring Boot

Port 8080
```

Without opening ports, users cannot access your application.

---

# Accessing the Application

```
Browser

↓

http://PUBLIC_IP:8080
```

Example

```
http://13.45.xx.xx:8080
```

---

# Running Application in Background

Instead of

```bash
java -jar app.jar
```

Use

```bash
nohup java -jar app.jar &
```

Check process

```bash
ps -ef
```

---

# Using systemd (Recommended)

Create a service

```
springboot.service
```

Start service

```bash
sudo systemctl start springboot
```

Enable on boot

```bash
sudo systemctl enable springboot
```

Check status

```bash
sudo systemctl status springboot
```

---

# Deploying with Nginx

Architecture

```
Internet

↓

Nginx

↓

Spring Boot

↓

Tomcat
```

Benefits

- Reverse Proxy
- HTTPS Support
- Load Balancing
- Better Security

---

# Using RDS Database

Instead of

```
MySQL

↓

Laptop
```

Use

```
Spring Boot

↓

AWS RDS

↓

MySQL/PostgreSQL
```

Example

```properties
spring.datasource.url=jdbc:mysql://RDS-ENDPOINT:3306/demo

spring.datasource.username=admin

spring.datasource.password=password
```

---

# Deploying Docker on AWS

Flow

```
Spring Boot

↓

Docker Image

↓

Push to ECR

↓

Run on ECS / EC2
```

---

# Deploy Using GitHub Actions

```
Developer

↓

Git Push

↓

GitHub Actions

↓

Build JAR

↓

Upload to EC2

↓

Restart Application
```

Deployment becomes fully automated.

---

# Monitoring

AWS CloudWatch monitors

- CPU Usage
- Memory
- Logs
- Network
- Disk Usage

---

# AWS Security Best Practices

- Use IAM users instead of the root account.
- Keep Security Groups restrictive.
- Disable password-based SSH login if possible.
- Use SSH keys.
- Enable HTTPS.
- Keep the operating system updated.
- Store secrets securely using AWS Secrets Manager or environment variables.

---

# Advantages

- Highly Scalable
- Reliable
- Global Infrastructure
- Pay-as-you-go
- Easy Backup
- High Availability
- Supports Auto Scaling

---

# Disadvantages

- Learning curve for beginners.
- Cost can increase if resources are not managed.
- Requires proper security configuration.

---

# Real-World Example

## E-Commerce Application

```
Customer

↓

Route 53

↓

Load Balancer

↓

EC2

↓

Spring Boot

↓

RDS
```

---

## Banking Application

```
Customer

↓

Load Balancer

↓

Multiple EC2 Instances

↓

Spring Boot

↓

RDS

↓

CloudWatch Monitoring
```

---

# Common Mistakes

❌ Leaving Security Groups open to everyone.

❌ Using the root AWS account for daily work.

❌ Hardcoding database passwords.

❌ Forgetting to open application ports.

❌ Running applications without a process manager.

❌ Ignoring monitoring and backups.

---

# Interview Questions

### 1. What is AWS?

AWS is Amazon's cloud platform that provides services like virtual machines, databases, storage, networking, and monitoring.

---

### 2. Which AWS service is commonly used to host a Spring Boot application?

**Amazon EC2**.

---

### 3. Which AWS service is used for managed relational databases?

**Amazon RDS**.

---

### 4. What is the purpose of a Security Group?

A Security Group acts as a virtual firewall that controls inbound and outbound traffic to AWS resources.

---

### 5. Why is Nginx commonly used with Spring Boot?

Nginx acts as a reverse proxy, supports HTTPS, improves security, and can distribute traffic across multiple application instances.

---

### 6. Why should `systemd` be used in production?

It automatically starts the application after a reboot, manages the process, and makes monitoring easier.

---

### 7. How can deployment be automated?

Using CI/CD tools like GitHub Actions, Jenkins, or AWS CodePipeline to build, test, and deploy the application automatically.

---

# Quick Revision

- AWS is a cloud platform for hosting applications.
- EC2 hosts the Spring Boot application.
- RDS hosts the database.
- Security Groups control network access.
- Nginx is commonly used as a reverse proxy.
- Use `systemd` to run Spring Boot as a service.
- Monitor applications using CloudWatch.
- Automate deployments using GitHub Actions or Jenkins.
- Never hardcode secrets or use the root AWS account for daily work.