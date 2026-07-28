# RabbitMQ

## What is RabbitMQ?

**RabbitMQ** is an **open-source Message Broker** that enables applications and microservices to communicate asynchronously by sending and receiving messages.

Instead of applications communicating directly,

they communicate through RabbitMQ.

RabbitMQ is commonly used for:

- Asynchronous Processing
- Task Queues
- Background Jobs
- Microservices Communication
- Event-Driven Applications

> **In simple words:**
>
> RabbitMQ is like a post office where applications send messages to queues, and other applications receive and process them.

---

# Why Do We Need RabbitMQ?

Imagine an E-Commerce application.

When an order is placed,

many tasks need to happen.

Without RabbitMQ

```
Order Service

↓

Payment Service

↓

Inventory Service

↓

Email Service

↓

SMS Service
```

Problems

- Tight coupling
- Slow response
- One service failure affects others

---

With RabbitMQ

```
Order Service

↓

RabbitMQ

↓

Payment Service

Inventory Service

Email Service

SMS Service
```

Each service works independently.

---

# Real-World Example

Imagine a courier office.

```
Customer

↓

Courier Office

↓

Package Stored

↓

Delivery Person

↓

Receiver
```

The sender and receiver never communicate directly.

RabbitMQ works the same way.

---

# RabbitMQ Architecture

```
Producer

↓

Exchange

↓

Queue

↓

Consumer
```

---

# Main Components

## Producer

The Producer sends messages.

Example

```
Order Service

↓

Order Created
```

---

## Exchange

The Exchange receives messages from Producers and decides where to send them.

```
Producer

↓

Exchange

↓

Queue
```

The Exchange does not permanently store messages.

---

## Queue

A Queue stores messages until a Consumer processes them.

```
Queue

↓

Message 1

↓

Message 2

↓

Message 3
```

---

## Consumer

A Consumer receives and processes messages.

```
Queue

↓

Consumer

↓

Business Logic
```

---

# Message Flow

```
Producer

↓

Exchange

↓

Queue

↓

Consumer

↓

Acknowledgement
```

---

# Complete Architecture

```
          Producer

              │

              ▼

          Exchange

              │

      ┌───────┴────────┐

      ▼                ▼

   Queue A         Queue B

      ▼                ▼

 Email Service   SMS Service
```

---

# Why Do We Need Queues?

Without Queue

```
Producer

↓

Consumer Busy

↓

Message Lost
```

With Queue

```
Producer

↓

Queue

↓

Wait

↓

Consumer Processes Later
```

Messages remain safe until processed.

---

# What is an Exchange?

The Exchange decides how messages are routed.

```
Producer

↓

Exchange

↓

Correct Queue
```

It acts like a traffic controller.

---

# Types of Exchanges

| Exchange | Purpose |
|-----------|----------|
| Direct | Routes using exact routing key |
| Topic | Routes using pattern matching |
| Fanout | Sends message to all queues |
| Headers | Routes using message headers |

---

# Direct Exchange

```
Producer

↓

Exchange

↓

Queue with Matching Key
```

Example

```
Routing Key

↓

payment
```

Only the payment queue receives the message.

---

# Fanout Exchange

```
Producer

↓

Exchange

↓

Queue A

Queue B

Queue C
```

Every queue receives a copy.

Useful for notifications.

---

# Topic Exchange

Uses patterns.

Example

```
order.*

↓

order.created

order.updated
```

Useful for flexible routing.

---

# RabbitMQ Request Flow

```
Producer

↓

Exchange

↓

Queue

↓

Consumer

↓

Acknowledgement
```

---

# Spring Boot Dependency

```xml
<dependency>

    <groupId>

        org.springframework.boot

    </groupId>

    <artifactId>

        spring-boot-starter-amqp

    </artifactId>

</dependency>
```

---

# RabbitMQ Configuration

```properties
spring.rabbitmq.host=localhost

spring.rabbitmq.port=5672

spring.rabbitmq.username=guest

spring.rabbitmq.password=guest
```

---

# Producer Example

```java
@Service
public class OrderProducer {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void sendOrder() {

        rabbitTemplate.convertAndSend(

                "order.exchange",

                "order.created",

                "Order Created"

        );

    }

}
```

Flow

```
Producer

↓

RabbitTemplate

↓

Exchange

↓

Queue
```

---

# Consumer Example

```java
@Component
public class OrderConsumer {

    @RabbitListener(

            queues = "order.queue"

    )
    public void receive(

            String message

    ){

        System.out.println(message);

    }

}
```

Flow

```
Queue

↓

Consumer

↓

Process Message
```

---

# Message Lifecycle

```
Producer

↓

Exchange

↓

Queue

↓

Consumer

↓

Acknowledgement

↓

Message Removed
```

After successful acknowledgement,

RabbitMQ removes the message from the queue.

---

# Message Acknowledgement

```
Consumer

↓

Process Message

↓

ACK

↓

Remove Message
```

If processing fails,

the message can remain in the queue or be retried depending on the configuration.

---

# RabbitMQ Features

- Reliable Messaging
- Asynchronous Communication
- Message Routing
- Queue-Based Processing
- High Availability
- Fault Tolerance

---

# RabbitMQ vs Kafka

| RabbitMQ | Kafka |
|-----------|--------|
| Queue-based messaging | Distributed event streaming |
| Uses Exchanges and Queues | Uses Topics and Partitions |
| Best for task processing | Best for event streaming |
| Messages are typically removed after acknowledgement | Messages are retained based on retention policy |
| Lower latency for many queue workloads | Higher throughput for streaming workloads |

---

# RabbitMQ vs REST API

| RabbitMQ | REST API |
|-----------|----------|
| Asynchronous | Synchronous |
| Queue-based | Request-Response |
| Producer continues immediately | Client waits for response |
| Better for background jobs | Better for immediate responses |

---

# Common Use Cases

- Order Processing
- Email Sending
- SMS Notifications
- Payment Processing
- Background Jobs
- Image Processing
- Report Generation
- Task Scheduling

---

# Common Mistakes

❌ Creating unnecessary queues.

❌ Ignoring failed messages.

❌ Sending very large messages.

❌ Not configuring acknowledgements.

❌ Hardcoding queue names throughout the application.

---

# Real-World Example

## Banking Application

```
Money Transfer

↓

RabbitMQ

↓

SMS Queue

↓

Customer Notified
```

---

## E-Commerce Website

```
Order Created

↓

RabbitMQ

↓

Email Queue

↓

Confirmation Email
```

---

## Food Delivery App

```
Order Delivered

↓

RabbitMQ

↓

Reward Queue

↓

Reward Points Added
```

---

# Advantages

- Loose coupling.
- Reliable message delivery.
- Supports asynchronous communication.
- Easy integration with Spring Boot.
- Excellent for task queues.
- Supports multiple routing strategies.

---

# Best Practices

- Keep messages small.
- Use acknowledgements.
- Configure dead-letter queues for failed messages.
- Use meaningful exchange and queue names.
- Monitor queue size.
- Retry failed messages when appropriate.

---

# Interview Questions

### 1. What is RabbitMQ?

RabbitMQ is an open-source message broker that enables asynchronous communication using exchanges and queues.

---

### 2. What is a Queue?

A Queue temporarily stores messages until a consumer processes them.

---

### 3. What is an Exchange?

An Exchange receives messages from producers and routes them to one or more queues.

---

### 4. What is the purpose of message acknowledgement?

Acknowledgement informs RabbitMQ that the consumer has successfully processed the message, allowing it to be safely removed from the queue.

---

### 5. Which Spring Boot class is used to send RabbitMQ messages?

```java
RabbitTemplate
```

---

### 6. Which annotation is used to receive RabbitMQ messages?

```java
@RabbitListener
```

---

### 7. When should RabbitMQ be preferred over Kafka?

RabbitMQ is generally preferred for task queues, background job processing, and reliable request distribution, while Kafka is better suited for high-throughput event streaming and event-driven architectures.

---

# Quick Revision

- RabbitMQ is a message broker for asynchronous communication.
- Main components are Producer, Exchange, Queue, and Consumer.
- Exchanges route messages to queues.
- Queues store messages until consumers process them.
- `RabbitTemplate` sends messages.
- `@RabbitListener` receives messages.
- RabbitMQ is ideal for task queues and background processing.
- Message acknowledgements help ensure reliable delivery.