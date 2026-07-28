# Apache Kafka

## What is Apache Kafka?

**Apache Kafka** is a **distributed event streaming platform** used to publish, store, and process large volumes of real-time data.

It acts as a **Message Broker** between different applications or microservices.

Kafka is widely used for:

- Event-Driven Architecture
- Microservices Communication
- Real-Time Analytics
- Log Processing
- Notification Systems

> **In simple words:**
>
> Kafka is like a highly scalable post office where producers send messages and consumers receive them independently.

---

# Why Do We Need Kafka?

Imagine an E-Commerce application.

When an order is placed,

many services need to react.

Without Kafka

```
Order Service

↓

Payment Service

↓

Inventory Service

↓

Email Service

↓

Notification Service

↓

Analytics Service
```

Problems

- Tight coupling
- Slow processing
- Difficult to scale

---

With Kafka

```
Order Service

↓

Kafka

↓

Payment Service

Inventory Service

Email Service

Analytics Service

Notification Service
```

All services work independently.

---

# Real-World Example

Think of a newspaper company.

```
Publisher

↓

Newspaper

↓

Subscribers
```

The publisher prints one newspaper.

Thousands of subscribers receive it independently.

Kafka works in the same way.

---

# Kafka Architecture

```
Producer

↓

Kafka Broker

↓

Topic

↓

Consumer
```

---

# Main Components

## Producer

The Producer sends messages to Kafka.

Example

```
Order Service

↓

Order Created Event
```

---

## Broker

A Kafka Broker stores messages.

```
Producer

↓

Broker

↓

Store Messages
```

A Kafka cluster usually contains multiple brokers.

---

## Topic

A Topic is a logical category where messages are stored.

Examples

```
orders

payments

users

notifications
```

---

## Consumer

Consumers read messages from Topics.

Example

```
Kafka

↓

Email Service

↓

Send Email
```

---

# Kafka Message Flow

```
Producer

↓

Topic

↓

Kafka Broker

↓

Consumer

↓

Process Event
```

---

# Complete Architecture

```
          Producer

              │

              ▼

         Kafka Topic

              │

      ┌───────┴────────┐

      ▼                ▼

 Consumer A      Consumer B

      ▼                ▼

 Email Service   Inventory Service
```

---

# What is a Topic?

A Topic is similar to a folder.

```
Kafka

│

├── orders

├── payments

├── users

└── notifications
```

Messages are stored inside Topics.

---

# What is a Partition?

Each Topic is divided into multiple Partitions.

```
Orders Topic

│

├── Partition 0

├── Partition 1

└── Partition 2
```

Partitions allow Kafka to process messages in parallel.

---

# Why Partitions?

Without Partitions

```
One Queue

↓

Slow Processing
```

With Partitions

```
Partition 0

Partition 1

Partition 2

↓

Parallel Processing
```

Higher throughput.

---

# What is an Offset?

Every message has a unique number called an **Offset**.

```
Partition

↓

Offset 0

↓

Offset 1

↓

Offset 2

↓

Offset 3
```

Consumers use offsets to know which messages have already been processed.

---

# Consumer Group

Multiple Consumers can work together.

```
Topic

↓

Consumer Group

│

├── Consumer 1

├── Consumer 2

└── Consumer 3
```

Kafka distributes partitions among consumers.

---

# Kafka Request Flow

```
Producer

↓

Send Message

↓

Broker

↓

Store Message

↓

Consumer Reads

↓

Process Message
```

---

# Spring Boot with Kafka

Dependency

```xml
<dependency>

    <groupId>

        org.springframework.kafka

    </groupId>

    <artifactId>

        spring-kafka

    </artifactId>

</dependency>
```

---

# Kafka Configuration

```properties
spring.kafka.bootstrap-servers=localhost:9092

spring.kafka.consumer.group-id=order-group
```

---

# Kafka Producer Example

```java
@Service
public class OrderProducer {

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    public void publishOrder() {

        kafkaTemplate.send(

                "orders",

                "Order Created"

        );

    }

}
```

Flow

```
Order Service

↓

KafkaTemplate

↓

Orders Topic
```

---

# Kafka Consumer Example

```java
@Component
public class OrderConsumer {

    @KafkaListener(

            topics = "orders",

            groupId = "order-group"

    )
    public void consume(String message) {

        System.out.println(message);

    }

}
```

Flow

```
Orders Topic

↓

Consumer

↓

Business Logic
```

---

# Message Lifecycle

```
Producer

↓

Topic

↓

Partition

↓

Offset

↓

Consumer

↓

Acknowledgement
```

---

# Kafka Features

- High Throughput
- Distributed
- Fault Tolerant
- Durable Storage
- Horizontal Scalability
- Real-Time Streaming

---

# Kafka vs RabbitMQ

| Kafka | RabbitMQ |
|--------|----------|
| Distributed log | Message queue |
| Stores messages for a configurable retention period | Removes message after acknowledgement (typically) |
| High throughput | Lower throughput than Kafka for streaming workloads |
| Best for event streaming | Best for task queues |
| Uses Topics and Partitions | Uses Exchanges and Queues |

---

# Kafka vs REST API

| Kafka | REST API |
|--------|----------|
| Asynchronous | Synchronous |
| Event-based | Request-Response |
| Producer does not wait | Client waits for response |
| Highly scalable | Limited by synchronous communication |

---

# Common Use Cases

- Order Processing
- Payment Systems
- Banking Transactions
- Activity Logging
- Notification Systems
- IoT Devices
- Fraud Detection
- Real-Time Analytics

---

# Common Mistakes

❌ Creating too many Topics.

❌ Using only one partition for high traffic.

❌ Ignoring consumer groups.

❌ Sending very large messages.

❌ Not handling consumer failures.

---

# Real-World Example

## Banking Application

```
Money Transferred

↓

Kafka

↓

SMS Service

↓

Email Service

↓

Audit Service
```

---

## E-Commerce Website

```
Order Created

↓

Kafka

↓

Inventory Updated

↓

Payment Processed

↓

Email Sent
```

---

## Food Delivery App

```
Order Delivered

↓

Kafka

↓

Reward Points

↓

Notification

↓

Analytics
```

---

# Advantages

- Extremely scalable.
- High performance.
- Supports millions of events.
- Fault tolerant.
- Reliable message storage.
- Excellent for Event-Driven Architecture.

---

# Best Practices

- Create meaningful Topic names.
- Use multiple partitions for high throughput.
- Keep messages small.
- Handle duplicate messages safely.
- Monitor consumer lag.
- Use Consumer Groups for scalability.
- Secure Kafka clusters using authentication and encryption.

---

# Interview Questions

### 1. What is Apache Kafka?

Apache Kafka is a distributed event streaming platform used for publishing, storing, and processing real-time events.

---

### 2. What is a Kafka Topic?

A Topic is a logical category where producers publish messages and consumers read them.

---

### 3. Why are Partitions used?

Partitions allow Kafka to process messages in parallel, improving scalability and throughput.

---

### 4. What is an Offset?

An Offset is the unique position of a message within a partition. It helps consumers track which messages have been processed.

---

### 5. What is a Consumer Group?

A Consumer Group is a set of consumers that work together to process messages from a topic, with Kafka distributing partitions among them.

---

### 6. Which Spring Boot class is commonly used to publish Kafka messages?

```java
KafkaTemplate
```

---

### 7. What annotation is used to consume Kafka messages?

```java
@KafkaListener
```

---

# Quick Revision

- Apache Kafka is a distributed event streaming platform.
- Main components are Producer, Broker, Topic, Partition, Offset, and Consumer.
- Topics store messages, while Partitions enable parallel processing.
- Offsets identify individual messages within a partition.
- Consumer Groups improve scalability and load balancing.
- Spring Boot uses `KafkaTemplate` to send messages.
- `@KafkaListener` is used to consume messages.
- Kafka is widely used for microservices, event-driven systems, and real-time data processing.