---
title: Data Models
date: 2024-08-22
authors:
  - name: Dimitri Yatsenko
---

# Definition
```{card} Data Model
A *data model* is a conceptual framework that defines how data is organized, represented, and transformed. It gives us the components for creating blueprints for the structure and operations of data management systems, ensuring consistency and efficiency in data handling.

Data management systems are built to accommodate these models, allowing us to manage data according to the principles laid out by the model. If you're studying data science or engineering, you’ve likely encountered different data models, each providing a unique approach to organizing and manipulating data.

A data model is defined by considering the following key aspects:
* What are the fundamental elements used to structure the data?
* What operations are available for defining, creating, and manipulating the data?
* What mechanisms exist to enforce the structure and rules governing valid data interactions?
```

Innovations in data models have spurred progress by creating new mental tools for us to think about data and to communicate with machines and with each other.
Scientists and engineers who become well-versed in effective data models can collaborate more efficiently because they share a common conceptual framework.

:::{hint} What data models do you already know?
Before moving forward, take a moment to consider the different data models you're already familiar with. 
Describe a common data model by naming the building blocks that the model uses to represent and manipulate data.
What are the key operations for creating, modifying, and querying data within this data model?
What constraints does the model impose to reduce errors?
:::

# Examples of Data Models

## Example: Binary File

The data model of a binary file is the simplest and least constrained, consisting of a continuous sequence of bits (1s and 0s). These bits are typically grouped into bytes (8 bits each) for basic structure, but beyond this, binary files have no inherent organization or meaning. The interpretation of the data within a binary file is entirely dependent on the application that reads it.

The operations supported by a binary file are minimal:
- **Reading and Writing Bits/Bytes**: You can read or modify the individual bits or bytes at specific locations within the file.
- **Changing File Length**: You can increase or decrease the file's length by adding or removing bits/bytes.

Binary files serve as a flexible, low-level data storage format, allowing applications to store any type of data without predefined structure, making them ideal for storing raw data, executable programs, or proprietary file formats.

## Example: Hierarchical File System

A hierarchical file system organizes data in a tree-like structure, where each file is stored within a directory (also known as a folder), and directories can contain other directories, forming a hierarchy. This model provides a logical and organized way to manage files on storage devices.

- **Files**: The basic unit of data storage, each file contains a sequence of bytes and is identified by a unique name within its directory.
- **Directories**: Directories (or folders) serve as containers for files and other directories, allowing for a nested structure. Each directory can hold multiple files and subdirectories.
- **Paths**: The location of a file or directory is specified by a path, which traces the route through the directory hierarchy, starting from the root directory.

Hierarchical file systems support a range of operations, including:
- **Creating, Renaming, and Deleting Files/Directories**: Users can create new files and directories, rename them, or remove them.
- **Navigating the Hierarchy**: Users can move through directories using paths to access files and subdirectories.
- **Reading and Writing Files**: Files can be opened for reading or writing, allowing users to view or modify the contents.
- **Managing Permissions**: File systems often include mechanisms for setting permissions, controlling who can read, write, or execute files.

The hierarchical file system is one of the most familiar data models to scientists, who often think of data primarily in such terms. This model provides an organized way to store and retrieve data, making it easier to manage large collections of files across multiple directories.

## Examples: Variables in programming languages

The Variable-Based Data Model is fundamental to how most programming languages like JavaScript, C++, R, Julia, and Python handle data. In this model, variables act as containers or references that store data values, allowing programmers to manipulate and interact with data easily:

- **Variables**: Named containers that hold data, which can be of various types such as numbers, text, or more complex structures like arrays and objects.

- **Data Types**: Variables can store different types of data, including:
  - **Primitive Types**: Simple data like numbers, booleans, and strings.
  - **Composite Types**: complex data structures such as arrays (ordered collections), dictionaries (key-value pairs), objects, and myriad others.

- **Operations**: Variables support diverse operations, including:
  - **Assignment**: Storing or updating a value in a variable.
  - **Arithmetic and Logic**: Performing calculations or logical comparisons.
  - **Function Calls**: Passing variables to functions for processing.

Programming languages differ vastly in how they constrain operations on variables. For example, a language can be strongly typed, restricting what values can be assigned to a variable.

## Example: Spreadsheet

Electronic spreadsheets are among the most widely used tools for data management and analysis across business, science, and everyday household tasks.

The first spreadsheet program, VisiCalc, launched in 1979, played a key role in the commercial success of the Apple II personal computer and helped establish Apple as a major player in the tech industry. Similarly, Lotus 1-2-3, developed for the IBM PC, became another "killer app" that drove the adoption of personal computers in the business world. Today, proficiency in spreadsheet software like Microsoft Excel or Google Sheets is essential for business professionals and data scientists alike.

But what exactly is the data model behind spreadsheets? What makes up a spreadsheet, and how do users interact with it?

The data model of a spreadsheet is straightforward and user-friendly, enabling intuitive interactions:

1. **Grid of Cells**: Spreadsheets organize data in a rectangular grid, where each cell is identified by its position (e.g., A1, B2). This simple structure allows users to easily locate and manipulate data.

2. **Values or Formulas**: Each cell in a spreadsheet can hold a value (such as text, numbers, or dates), a formula that references other cells, or remain empty. Formulas automatically update when referenced cells change, which can trigger further updates across the spreadsheet.

Users interact with spreadsheets by manually entering data or formulas into specific cells. When the content of a cell changes, any related formulas recalculate automatically, often leading to cascading updates throughout the sheet.

In addition to basic data entry, spreadsheets offer a wide range of features, including formatting options and the ability to create charts, making them versatile tools for data analysis and presentation.

## Example: Dataframes

DataFrames are a fundamental data structure used in data analysis and manipulation, particularly in the fields of data science, statistics, and machine learning. They provide a powerful and flexible way to work with structured data, similar to tables in relational databases or spreadsheets, but with additional capabilities that make them ideal for complex data operations.

A DataFrame is essentially a two-dimensional, labeled data structure with columns of potentially different types. It can be thought of as a table where each column can contain different types of data (e.g., integers, floats, strings). DataFrames are most commonly associated with libraries like `Pandas` in Python and `DataFrames.jl` in Julia.

The concept of DataFrames originated from the statistical programming language R, where DataFrames have been a core data structure for many years.
The idea was later adopted and popularized in the Python ecosystem with the Pandas library, introduced by Wes McKinney in 2008.
Pandas DataFrames have since become a staple in data science, allowing users to perform complex data manipulations with ease.

DataFrames are used extensively in data analysis tasks, including:

- **Data Cleaning**: Handling missing data, filtering, and transforming data into a usable format.
- **Exploratory Data Analysis (EDA)**: Summarizing and visualizing data to uncover patterns, trends, and relationships.
- **Data Transformation**: Applying mathematical and statistical operations, merging, and reshaping data.
- **Machine Learning**: Preparing and processing datasets for training machine learning models.

The data model of a DataFrame is both simple and flexible:

1. **Rows and Columns**: A DataFrame is composed of rows and columns, similar to a spreadsheet or a database table. Each row represents a single observation, and each column represents a variable or feature of the data.

2. **Labeled Axes**: Unlike basic two-dimensional arrays, DataFrames have labeled axes. This means that each row and column can have a label (e.g., row indices and column names), making it easier to access and manipulate data based on labels rather than just numerical indices.

3. **Heterogeneous Data Types**: Each column in a DataFrame can contain data of different types. For example, one column might store integers, another strings, and yet another floating-point numbers. This flexibility allows DataFrames to handle complex datasets with varied data types.

4. **Indexing**: DataFrames support both integer-based and label-based indexing, allowing users to access data using row/column indices or labels. This makes data access intuitive and efficient.

DataFrames support a wide range of operations, making them a powerful tool for data manipulation:

- **Selection and Filtering**: Users can select specific rows and columns, filter data based on conditions, and access subsets of the data.

- **Aggregation and Grouping**: DataFrames allow for grouping data by one or more columns and applying aggregate functions (e.g., sum, mean, count) to summarize data.

- **Data Transformation**: Users can apply functions to columns or rows, perform mathematical operations, and reshape the DataFrame (e.g., pivoting, melting).

- **Merging and Joining**: DataFrames support merging and joining operations, similar to SQL joins, allowing users to combine multiple DataFrames based on common keys.

- **Handling Missing Data**: DataFrames provide functions for detecting, filling, or dropping missing data, which is essential in preparing datasets for analysis.

- **I/O Operations**: DataFrames can easily read from and write to various file formats, including CSV, Excel, JSON, and SQL databases.

DataFrames have become an essential tool in modern data analysis, providing a structured yet flexible way to handle and manipulate data. Their ability to work with heterogeneous data types, combined with a rich set of operations, makes them ideal for tasks ranging from simple data exploration to complex data transformations and machine learning preparation. Whether in Python, R, or Julia, DataFrames have become a cornerstone of data science workflows.

## Example: Relational Data Model 
The rest of this  book is about the relational data model and we introduce it properly in following sections.

## Example: Document Data Model (JSON and BSON)

The Document Data Model, commonly exemplified by JSON (JavaScript Object Notation), organizes data as key-value pairs within structured documents. This flexible, text-based format is widely used for data interchange between systems, particularly in web applications and APIs.

### History
- **1999**: JSON was developed by Douglas Crockford as a lightweight data interchange format. The goal was to create a simple, human-readable format that could easily be parsed and generated by machines.

- **2001**: JSON began to gain popularity as it was adopted for use in web applications, particularly with the rise of AJAX (Asynchronous JavaScript and XML), which allowed for dynamic content updates in web pages without requiring a full page reload.

- **2005**: JSON was officially standardized as [ECMA-404](https://ecma-international.org/publications-and-standards/standards/ecma-404/) by the Ecma International organization, solidifying its status as a reliable and widely accepted data format.

- **2013**: JSON received its IETF standardization as [RFC 7159](https://datatracker.ietf.org/doc/html/rfc7159), further cementing its role in data interchange across a wide range of applications.

- **Present**: JSON is now the de facto standard for data exchange in web APIs, configuration files, and NoSQL databases, due to its simplicity, flexibility, and wide support across programming languages.

### Structure

- **Key-Value Pairs**: The fundamental building block of JSON is the key-value pair. Each key is a string, and it maps to a value, which can be a primitive type (such as a number or string) or a more complex type (such as an object or array).

- **Objects**: Objects in JSON are collections of key-value pairs, enclosed in curly braces `{}`. Each key within an object is unique, and the values can be of any valid JSON type.

- **Arrays**: Arrays are ordered lists of values, enclosed in square brackets `[]`. The values within an array can be of different types, including other arrays or objects, making JSON highly flexible for representing complex data structures.

- **Primitive Types**: JSON supports simple data types such as:
  - **Numbers**: Represent both integers and floating-point numbers.
  - **Strings**: Text data enclosed in double quotes.
  - **Booleans**: `true` or `false`.
  - **Null**: Represents an empty or non-existent value.

### Supported Operations

The Document Data Model supports a variety of operations, including:

- **Data Serialization and Deserialization**: JSON data can be easily converted (serialized) into a string format for storage or transmission and then converted back (deserialized) into objects for use within a program.

- **Nested Structures**: JSON supports nested objects and arrays, allowing for the representation of hierarchical data structures.

- **Data Exchange**: JSON is widely used for transmitting data between a server and a web application, due to its lightweight and readable format.

- **Parsing and Querying**: JSON data can be parsed into native data structures in most programming languages, and tools like JSONPath can be used to query specific parts of a JSON document.

### Common Uses

The JSON data model is widely used in various scenarios, particularly in web development and data interchange:

- **APIs**: JSON is the de facto standard for data exchange in RESTful APIs, enabling communication between clients and servers.
- **Configuration Files**: JSON is often used for configuration files, storing settings in a structured, human-readable format.
- **NoSQL Databases**: Many NoSQL databases, like MongoDB, use a JSON-like format (BSON) to store documents, allowing for flexible schema design and dynamic data storage.

The Document Data Model, with JSON as its most common implementation, offers flexibility and simplicity for handling structured data, making it an ideal choice for many modern applications.

## Example: Key-Value Data Model

The Key-Value Data Model is a simple and efficient way of storing, retrieving, and managing data, where each piece of data is stored as a pair consisting of a unique key and its associated value. This model is particularly popular in scenarios where fast data access and scalability are critical.

### Historical Background

The Key-Value Data Model has its roots in early database systems but gained significant prominence with the rise of NoSQL databases in the late 2000s. As web applications grew in complexity and scale, traditional relational databases struggled to keep up with the demand for fast, distributed, and scalable data storage. This led to the development and adoption of key-value stores, which offered a more flexible and efficient approach to handling large-scale, distributed data.

### Structure

- **Keys**: Unique identifiers that are used to retrieve the associated values. Keys are typically simple data types like strings or integers.

- **Values**: The actual data associated with the key. Values can be of any type, from simple data types like strings and numbers to more complex types like JSON objects or binary data.

The simplicity of this model allows for extremely fast lookups, as the database can quickly find the value associated with a given key without the need for complex queries or joins.

### Supported Operations

The Key-Value Data Model supports a limited but powerful set of operations:

- **Put/Set**: Stores a value associated with a specific key. If the key already exists, its value is updated.
  
- **Get**: Retrieves the value associated with a specific key. If the key does not exist, the operation returns a null or error.

- **Delete**: Removes the key-value pair from the store, freeing up space and removing the associated data.

- **Existence Check**: Determines whether a specific key exists in the store.

These operations are typically executed in constant time, making key-value stores highly efficient for many applications.

### Prominent Implementations

The Key-Value Data Model has been implemented in several prominent systems, particularly in the realm of NoSQL databases:

- **Redis**: An in-memory key-value store known for its speed and support for complex data structures like lists, sets, and hashes. Redis is widely used for caching, real-time analytics, and message brokering.

- **Amazon DynamoDB**: A fully managed key-value and document database service provided by Amazon Web Services (AWS). It is designed for high availability and scalability, making it ideal for web-scale applications.

- **Riak**: A distributed key-value store that emphasizes availability and fault tolerance. Riak is often used in scenarios requiring distributed data storage with a strong emphasis on reliability.

- **Couchbase**: A NoSQL database that combines the simplicity of a key-value store with the power of a document store, supporting both key-value operations and complex queries.

### Common Uses

The Key-Value Data Model is particularly well-suited for:

- **Caching**: Storing frequently accessed data for rapid retrieval, reducing load on the primary database.
  
- **Session Management**: Maintaining user session information in web applications, where fast access and scalability are essential.

- **Configuration Management**: Storing configuration settings that need to be quickly retrieved by applications at runtime.

- **Real-Time Analytics**: Handling large volumes of data that require fast read and write operations, such as in monitoring and analytics applications.

The Key-Value Data Model’s simplicity, speed, and scalability make it a fundamental tool in modern computing, particularly for applications that require quick access to data and need to scale horizontally across distributed systems.

## Example: Graph Data Model

The Graph Data Model is designed to represent and manage complex relationships between data entities. Unlike traditional data models that focus on storing data in tables or documents, the graph data model emphasizes the connections (or edges) between data points (or nodes). This model is particularly well-suited for scenarios where understanding and traversing relationships is crucial.

### Historical Background

The roots of the Graph Data Model can be traced back to the field of mathematics, specifically graph theory, which was first formalized in the 18th century by the Swiss mathematician Leonhard Euler. Euler's solution to the famous **Königsberg Bridge Problem** in 1736 is often regarded as the founding moment of graph theory. The problem involved finding a path that would cross each of the seven bridges in Königsberg exactly once, leading Euler to develop a new type of mathematical structure: the graph.

In the 20th century, graph theory found applications in computer science, particularly in areas like network analysis, operations research, and the study of algorithms. The concept of representing and traversing relationships as graphs naturally extended to data modeling, especially as the need to model complex relationships in data became more prominent.

The rise of the internet and social networks in the late 1990s and early 2000s fueled the development of graph databases. These systems were designed to efficiently handle and query large-scale graphs, where traditional relational databases struggled due to the complexity of joins and the dynamic nature of relationships. This led to the development and popularization of dedicated graph databases like Neo4j, which emerged in the mid-2000s as one of the first native graph database systems.

Today, the Graph Data Model is integral to many modern applications, from social networks and recommendation systems to knowledge graphs and biological network analysis.

### Structure

- **Nodes (Vertices)**: The fundamental units in a graph, nodes represent entities or objects in the data model. Each node can store various attributes or properties, such as a name, age, or category, depending on the application.

- **Edges**: Edges are the connections between nodes and represent relationships between the entities. For example, an edge might represent a friendship between two people or a link between two web pages. Edges can be directed (one-way) or undirected (two-way), and like nodes, they can also have properties (e.g., the type or strength of a relationship).

- **Properties**: Both nodes and edges can have properties—key-value pairs that provide additional information about the node or edge. For example, a node representing a person might have properties like "name" and "age," while an edge representing a friendship might have a property like "since" to indicate how long the friendship has existed.

- **Graph**: A graph is a collection of nodes and edges. Graphs can be simple, representing basic relationships, or highly complex, with numerous interconnected nodes and edges, forming intricate networks.

### Supported Operations

The Graph Data Model supports a wide range of operations, particularly focused on traversing and analyzing relationships:

- **Traversal**: Moving through the graph by following edges from one node to another. Traversal is fundamental to graph operations, allowing you to explore connections and paths within the graph.

- **Pathfinding**: Finding a path or the shortest path between two nodes. This is crucial for applications like navigation, social networks, and recommendation systems.

- **Subgraph Extraction**: Extracting a portion of the graph that satisfies certain criteria, such as all nodes connected within a certain distance or all nodes with specific properties.

- **Graph Queries**: Querying the graph to find nodes, edges, or subgraphs that meet specific conditions. This can involve complex patterns and conditions, making graph databases particularly powerful for querying relational data.

- **Graph Algorithms**: Running algorithms specifically designed for graphs, such as finding the shortest path, detecting cycles, or identifying clusters and communities within the graph.

### Common Uses

The Graph Data Model is highly versatile and is used in a variety of applications where relationships and connections are critical:

- **Social Networks**: Representing users and their relationships, such as friendships, followers, or connections. Social networks heavily rely on graph models to recommend new connections, analyze communities, and understand user behavior.

- **Recommendation Systems**: Suggesting products, movies, or content based on the relationships between users, items, and preferences. Graphs are used to model user behavior and find patterns that lead to better recommendations.

- **Network and IT Management**: Representing and analyzing the relationships within a network, such as routers, switches, and connections, to ensure efficient operation and quick problem detection.

- **Biological Networks**: Modeling complex relationships in biological systems, such as protein-protein interactions, gene networks, or ecological food webs.

- **Knowledge Graphs**: Structuring and querying large sets of knowledge, such as Wikipedia or Google Knowledge Graph, where entities and their relationships are modeled to provide more relevant search results and insights.

### Prominent Implementations

Several database systems and tools are designed to work specifically with the Graph Data Model:

- **Neo4j**: One of the most popular graph databases, Neo4j allows users to store and query graph data efficiently, with a focus on high performance for complex graph queries.

- **Amazon Neptune**: A fully managed graph database service by AWS, designed to handle both property graphs and RDF (Resource Description Framework) graphs.

- **OrientDB**: A multi-model database that supports both graph and document models, offering flexibility for applications that require both types of data representation.

- **ArangoDB**: A multi-model database that supports graph, document, and key-value data models, providing a versatile solution for different types of data.

The Graph Data Model is powerful for applications where relationships are as important as the data itself, offering a way to model and analyze complex networks of interconnected entities.


# Schema vs. Schemaless Data Models

Two broad families of data models are distinguished by whether or not they support **schemas**: specifications of data structure apart from any instance of the data. 
**Structured data models** provide a data definition language (DDL) for defining schemas. Schemas are then used for enforcing or validating structure in the data written into the database. Relational databases are the prime example of structured data with elaborate schemas capable of expressing complex relationships between entities.
These two approaches represent different philosophies in how data structure is defined, managed, and validated.

```{card} Schema
A **schema** is the detailed formal specification of data structure in a database that exists separately from any sample of the data.
Structured data models provide ways to define a schema explicitly.
Unstructured or self-describing data models do not rely on schemas; instead, they communicate data structure through examples, using samples of data.
```

**Self-describing** or **schemaless** data models allow instances of the data to define their own structure.
Many common file formats such as JSON, YAML, and HDF5 contain self-describing data: the names of entities, their attributes names and types, and their hierarchical relationships are encoded in each instance of the data.
Both structured and schemaless data formats can be attractive in various scenarios. Schemaless approaches may be more suitable for exploratory analysis where each data instance may differ in structure. Structured approaches become necessary for large-scale automated operations for uniformity and efficiency.

## Structured Data Models

In structured data models, the structure of the data is defined separately from the data itself. This predefined structure is known as a **schema**. A schema acts as a blueprint for the data, specifying the types of data that can be stored, the relationships between different data elements, and any constraints or rules that must be followed. 

- **Schema**: A schema defines the organization of data within the model, including the fields, data types, and relationships between them. It provides a rigid framework that ensures consistency and integrity of the data. For example, in a relational database, the schema would define tables, columns, data types (e.g., integers, strings), and relationships (e.g., foreign keys) between tables.

- **Validation**: One of the key benefits of having a schema is the ability to validate data before it is stored. The schema serves as a gatekeeper, allowing only data that conforms to the predefined structure to be accepted. This ensures that the data remains consistent, predictable, and reliable. If data does not match the schema, it can be rejected or corrected before being saved.

- **Example**: The quintessential example of a structured data model is the **relational database model**, where data is organized into tables with clearly defined columns and relationships. Each table has a schema that dictates what kind of data it can hold, ensuring that every entry conforms to the expected format.

## Self-Describing (Schemaless) Data Models

In contrast, self-describing or schemaless data models do not require a predefined schema. Instead, the structure of the data is embedded within the data itself, allowing for greater flexibility and adaptability.

- **Self-Describing Structure**: In self-describing data models, each piece of data carries its own structure. This means that the structure of the data can vary from one entry to another, without the need for a strict, overarching schema. The structure is inferred from the data itself, making these models highly flexible and adaptable to changing data requirements.

- **Flexibility**: The primary advantage of self-describing models is their flexibility. Since there is no rigid schema, new types of data can be added or existing structures can be modified without needing to overhaul the entire database. This makes self-describing models particularly useful in environments where the data is diverse or evolving rapidly.

- **Example**: A common example of a self-describing data model is **JSON (JavaScript Object Notation)**. In JSON, data is stored as key-value pairs, where the structure is defined within each data entry. This allows for varying structures within the same dataset, enabling a more dynamic and flexible approach to data management.

## Choosing Between Structured and Schemaless Models

The choice between using a structured or schemaless data model often depends on the specific needs of the application:

- **When to Use Structured Models**: If data consistency, integrity, and the ability to enforce rules and relationships are paramount, a structured model with a well-defined schema is ideal. This is common in financial systems, enterprise databases, and other scenarios where data must adhere to strict standards.

- **When to Use Schemaless Models**: If flexibility, rapid development, and the ability to handle diverse or changing data are more important, a self-describing or schemaless model may be better suited. This is typical in web applications, content management systems, and scenarios where the data structure is likely to evolve over time.

Both approaches have their strengths and are often used together in hybrid systems, where some data is managed with a strict schema and other data is stored more flexibly.

# Data Models in Science
Business enterprises have long relied on structured databases to maintain data integrity and consistency, as any breakdown in these areas can lead to serious financial and operational consequences.
In these environments, relational databases and SQL are the dominant tools. 

In contrast, scientific research often takes a less structured approach to data management.
The experimental nature of science leads researchers to favor flexible, schemaless, unstructured data models.
These models allow for the rapid collection of data without the constraints of a predefined structure, making them particularly appealing when the data requirements are not fully understood at the outset.

However, this flexibility comes at a cost.
When it comes time to publish or share findings, scientists often encounter challenges with heterogeneous datasets that lack consistency and standardization.
To address this, researchers may develop "data standards" to impose rules and guidelines on these unstructured models, ensuring that data can be effectively shared and understood.
For example, the [Brain Imaging Data Structure (BIDS)](https://bids.neuroimaging.io) standard imposes a uniform structure on files and folders used in neuroimaging studies [@10.1038/sdata.2016.44].
Similarly, the [Neurodata Without Borders (NWB)](https://www.nwb.org/) standard imposes structure on top of the flexible HDF5 data model commonly used in neuroscience research [@10.7554/eLife.78362].
Both of these standards enforce structure by using programming interfaces that validate and access the datasets, ensuring that the data adheres to a consistent format despite the underlying unstructured model.

While these standards help bring order to unstructured data, they often introduce additional complexity and require significant effort to enforce.

## Scientific Integrity Depends on Data Integrity 

In recent years, concerns about scientific integrity have brought greater attention to proper data management serving as the foundation for reproducible science and valid findings.
As science becomes more complex and interconnected, meticulous data handling—including reproducibility and data provenance—has become critical.
Proper data management ensures that research findings can be reliably reproduced, which is essential for validating results and building on previous work.
Moreover, maintaining clear records of **data provenance**—the detailed history of how data is collected, processed, and analyzed—provides transparency and accountability, helping to prevent issues such as data manipulation and fostering trust in scientific outcomes.
As the volume of data increases and research becomes more collaborative, the emphasis on reproducibility and provenance is not just a best practice; it is a necessity for advancing knowledge, maintaining public trust, and ensuring the long-term credibility of science.

There is now a strong case for the use of structured data models in science, models that enforce data integrity from the outset.
Structured models, which come with predefined schemas, allow the organization of data to evolve alongside the research.
As studies progress and new insights are gained, schemas can be adjusted to reflect the emerging structure and logic of the study.
This approach not only ensures consistency and integrity but also simplifies data sharing and publication.

**DataJoint** is built on the principle that even in rapidly evolving projects, explicitly structuring data is crucial for maintaining integrity and consistency.
This structure is essential for effective collaboration while still allowing the data to adapt quickly as the project progresses.
By adopting structured data models that are flexible enough to evolve, scientists can enjoy the best of both worlds—retaining the freedom to explore and experiment while ensuring that their data remains organized, consistent, and ready for dissemination.

:::{hint} Execrise
1. Think of additional data models you might be familiar with in terms of their basic constructs, operations, and data integrity rules.
What data models govern the following data formats:  CSV, XML, MATLAB files, HDF5, YAML, *etc*?
:::
