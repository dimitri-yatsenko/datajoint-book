---
title: Data Models
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Definition
```{card} Data Model
A *data model* is a particular way of thinking about data. 
A particular model is defined by answering the following questions:
* What is the data made of? What are the basic constructs for creating and manipulating the data?
* What are the basic operations for defining, creating, and manipulating the data?
* What tools exist for defining and enforcing data integrity: the rules for valid data interactions and for preventing invalid operaitons?
```

# Examples of Data Models
:::{note} Thought
Before proceeding, think of several different data models you are already familiar with.
Describe a common model in terms of the building blocks for representing and manipulating data.
What are the principal operations for creating, manipulating, and querying data in this model?
:::

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

## Example: Document Data Model (JSON and BSON)

The Document Data Model, commonly exemplified by JSON (JavaScript Object Notation), organizes data as key-value pairs within structured documents. This flexible, text-based format is widely used for data interchange between systems, particularly in web applications and APIs.

### History
- **1999**: JSON was developed by Douglas Crockford as a lightweight data interchange format. The goal was to create a simple, human-readable format that could easily be parsed and generated by machines.

- **2001**: JSON began to gain popularity as it was adopted for use in web applications, particularly with the rise of AJAX (Asynchronous JavaScript and XML), which allowed for dynamic content updates in web pages without requiring a full page reload.

- **2005**: JSON was officially standardized as ECMA-404 by the Ecma International organization, solidifying its status as a reliable and widely accepted data format.

- **2013**: JSON received its IETF standardization as RFC 7159, further cementing its role in data interchange across a wide range of applications.

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

# Schema vs. Schemaless Data Models

Data models can generally be categorized into two broad types: **structured** and **self-describing** (often referred to as schemaless). These two approaches represent different philosophies in how data structure is defined, managed, and validated.

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

# Data models in science
While business world gravitates toward structured data models to strictly enforce business order

Neuroscience, a field rife with intricate datasets, often sees researchers navigating vast amounts of data while collaborating within extensive, multidisciplinary teams.
Given this complexity, the logical assumption would be that cutting-edge tools for data organization, manipulation, analysis, and querying would be central to their operations.
However, this isn't the prevailing reality.
Despite technological advancements, a significant portion of the scientific community still refrains from employing proper databases for their studies.
The predominant trend is to rely on shared data in the format of file repositories, systematically organized into folders under a uniform naming convention.
This leads to the pertinent question: Why this discernible hesitance towards databases?

```{card} Reasons for scientists' reluctance to use databases

Gray *et al.* in their 2005 technical report titled "Scientific Data Management in the Coming Decade" {cite:p}`gray_scientific_2005` delved deep to unearth the reasons underpinning this avoidance:

* Perceived lack of tangible benefits.
* Absence of efficient visualization/plotting tools.
* A belief in the sufficiency of their programming language for data management.
* Incompatibility with specific data types like arrays, spatial data, text, etc.
* Mismatch with their data access patterns.
* Concerns over speed and efficiency.
* Inability to manipulate database data using regular application programs.
* The cost implications of hiring database administrators.
```

These apprehensions are valid.
Traditional database systems were primarily sculpted keeping in mind sectors like business, commerce, and web applications, not scientific computing.
For scientists, there's a clear need for a system that offers more—more flexibility, support for unique scientific data types, and capabilities tailored for distributed computation and visualization.

## The Limitations of File-based Systems

The aforementioned concerns naturally lead one to ponder: What, if any, are the drawbacks of simply organizing data as a structured file repository?
When do file systems falter?

Files, in essence, are nothing but sequences of bytes tagged with specific names.
They inherently lack structure or any meta-information.
While they can be systematically arranged with discerning naming conventions into structured folders, the onus of adhering to any structural framework lies externally.
Numerous *data standards*, such as [BIDS](https://bids.neuroimaging.io/) for brain imaging, essentially define their guidelines based on specific file/folder structures.
But therein lies a challenge—the filesystem itself doesn't enforce this structure, necessitating the creation of separate data standards.
The filesystem essentially passes on the challenge of efficient operations to the end processes that engage with them.
To efficiently navigate data organized in files, there's a need for distinct efforts in crafting access patterns, generating indices for swift searches, and scripting common queries.
In scenarios of shared distributed projects, there's also the added logistical challenge of data transfers, ensuring data integrity during concurrent access and modifications, and optimizing data operations.

# Exercises
As an exercise, describe other models you are familiar with in terms of its basic constructs, operations, and data integrity rules.
For example, what data models  are used by the following:

* HDF5 or .MAT files
* Graph databases
* Vector database
* Document database e.g. MongoDB
