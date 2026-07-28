# URL & URLConnection (Java Networking)

## What is a URL?

A **URL (Uniform Resource Locator)** is the address of a resource available on the Internet.

Just as every house has an address, every web resource has a URL.

> **Definition:** A URL is the complete address used to locate and access a resource on a network.

Example

```text
https://www.google.com/search?q=java
```

---

# Why Do We Need URL?

Suppose you want to open Google's homepage.

Without a URL, your browser wouldn't know where to go.

A URL tells the browser:

- Which protocol to use
- Which server to contact
- Which resource to request

---

# Real-World Example

Imagine sending a letter.

```text
Letter

↓

House Address

↓

Post Office

↓

Receiver
```

Similarly,

```text
Browser

↓

URL

↓

Internet

↓

Web Server

↓

Response
```

---

# Parts of a URL

Example

```text
https://www.google.com:443/search?q=java
```

Breakdown

```text
https://

↓

Protocol

www.google.com

↓

Host

443

↓

Port

/search

↓

Path

?q=java

↓

Query Parameter
```

---

# URL Structure

```text
Protocol://Host:Port/Path?Query
```

Example

```text
https://example.com:443/api/users?id=10
```

---

# URL Class

Java provides the

```java
java.net.URL
```

class.

Create a URL

```java
URL url =

new URL(

"https://www.google.com"

);
```

---

# Reading URL Information

```java
System.out.println(

url.getProtocol()

);
```

Output

```text
https
```

---

Host

```java
url.getHost();
```

Output

```text
www.google.com
```

---

Port

```java
url.getPort();
```

Returns

```text
443
```

(or `-1` if the default port is implied in the URL string).

---

Path

```java
url.getPath();
```

Output

```text
/search
```

---

Query

```java
url.getQuery();
```

Output

```text
q=java
```

---

# URI vs URL

| URI | URL |
|------|-----|
| Identifies a resource | Identifies and locates a resource |
| Can be a name | Always contains location information |
| Broader concept | Specialized type of URI |

Example

URI

```text
urn:isbn:9780134685991
```

URL

```text
https://example.com/books
```

Every URL is a URI, but not every URI is a URL.

---

# What is URLConnection?

`URLConnection` is a Java class used to establish a connection with the resource represented by a URL.

It allows Java programs to:

- Read data
- Write data (if supported)
- Read headers
- Set timeouts

---

# Creating URLConnection

```java
URL url =

new URL(

"https://example.com"

);

URLConnection connection =

url.openConnection();
```

---

# Opening a Connection

```java
connection.connect();
```

This establishes the network connection.

---

# Reading Data

```java
InputStream input =

connection.getInputStream();
```

The returned `InputStream` can be used to read the response.

---

# Reading Response

```java
BufferedReader reader =

new BufferedReader(

new InputStreamReader(

connection.getInputStream()

)

);

String line;

while((line = reader.readLine()) != null){

    System.out.println(line);

}
```

---

# Reading Headers

Content Type

```java
connection.getContentType();
```

Content Length

```java
connection.getContentLength();
```

Date

```java
connection.getDate();
```

---

# Setting Timeouts

Connection Timeout

```java
connection.setConnectTimeout(

5000

);
```

Read Timeout

```java
connection.setReadTimeout(

5000

);
```

The values are in milliseconds.

---

# HttpURLConnection

`HttpURLConnection` extends `URLConnection` and is specifically designed for HTTP and HTTPS communication.

```java
URL url =

new URL(

"https://example.com"

);

HttpURLConnection connection =

(HttpURLConnection)

url.openConnection();
```

---

# HTTP Methods

Specify the request method.

GET

```java
connection.setRequestMethod(

"GET"

);
```

POST

```java
connection.setRequestMethod(

"POST"

);
```

PUT

```java
connection.setRequestMethod(

"PUT"

);
```

DELETE

```java
connection.setRequestMethod(

"DELETE"

);
```

---

# Setting Request Headers

```java
connection.setRequestProperty(

"Accept",

"application/json"

);
```

Example

```java
connection.setRequestProperty(

"User-Agent",

"MyApp"

);
```

---

# Getting Response Code

```java
int code =

connection.getResponseCode();

System.out.println(code);
```

Output

```text
200
```

---

# Internal Working

Suppose Java accesses

```text
https://example.com
```

Internally

```text
Java Program

↓

URL Object

↓

URLConnection

↓

TCP Connection

↓

HTTP Request

↓

Web Server

↓

HTTP Response

↓

InputStream

↓

Application
```

---

# URL vs URLConnection

| URL | URLConnection |
|------|---------------|
| Represents an address | Represents a network connection |
| Stores URL information | Sends and receives data |
| No communication | Performs communication |

---

# Production Usage

`URL` and `URLConnection` are used in:

- Downloading files
- Reading web pages
- Calling REST APIs (legacy code)
- Connecting to web services
- Java networking utilities

Example

```text
Java App

↓

URL

↓

URLConnection

↓

REST API

↓

JSON Response
```

> **Note:** In modern Java (Java 11+), the `HttpClient` API is generally preferred over `HttpURLConnection` for new applications.

---

# Advantages

- Simple API
- Built into Java
- Supports multiple protocols
- Easy to read remote resources

---

# Limitations

- Older API design
- Verbose code
- Less convenient than Java 11 `HttpClient`
- Limited support for modern HTTP features

---

# Best Practices

✅ Close streams using try-with-resources.

✅ Set connection and read timeouts.

✅ Check the HTTP response code before processing the response.

✅ Prefer Java 11 `HttpClient` for new projects.

---

# Common Mistakes

❌ Forgetting to close streams.

---

❌ Ignoring timeouts.

---

❌ Reading the response without checking the status code.

---

❌ Using `URLConnection` for new applications when `HttpClient` provides a cleaner alternative.

---

# Interview Questions

### 1. What is a URL?

A URL (Uniform Resource Locator) is the address of a resource on a network.

---

### 2. What is the difference between URI and URL?

- URI identifies a resource.
- URL identifies and locates a resource.

---

### 3. What is URLConnection?

A Java class that establishes a connection to the resource represented by a URL.

---

### 4. What is HttpURLConnection?

A subclass of `URLConnection` designed specifically for HTTP and HTTPS communication.

---

### 5. How do you open a connection?

```java
URLConnection connection =
url.openConnection();
```

---

### 6. How do you read data from a URL?

Using the `InputStream` returned by `connection.getInputStream()`.

---

### 7. Why are timeouts important?

They prevent the application from waiting indefinitely if the server is slow or unreachable.

---

### 8. How do you set an HTTP request method?

```java
connection.setRequestMethod("GET");
```

(or `"POST"`, `"PUT"`, `"DELETE"`).

---

### 9. Does Spring Boot use URLConnection internally?

Not typically. Modern Spring applications commonly use clients such as **RestTemplate** (older) or **WebClient** (recommended for reactive applications), and Java applications can also use the Java 11+ `HttpClient`.

---

### 10. Which API is recommended for modern Java applications?

The **Java 11 `HttpClient` API**.

---

# Quick Revision

- URL = Address of a resource.
- URL format:
  - Protocol
  - Host
  - Port
  - Path
  - Query
- `URL` stores address information.
- `URLConnection` communicates with the resource.
- `HttpURLConnection` supports HTTP requests.
- Can:
  - Read data
  - Read headers
  - Set timeouts
  - Send HTTP methods
- Java 11 `HttpClient` is preferred for new applications.

---

# Keywords

- URL
- URI
- URLConnection
- HttpURLConnection
- Protocol
- Host
- Port
- Path
- Query
- InputStream
- HTTP
- HTTPS
- GET
- POST
- Timeout
- Java Networking