---
title: Data Models
---

## Why Data Models Matter

Every time you organize data, you're using a data model—whether you realize it or not. When you create a spreadsheet, write a Python dictionary, or save files in folders, you're working within the constraints and capabilities of that model's structure.

For scientists managing complex, evolving datasets, choosing the right data model is crucial. The wrong choice can lead to inconsistent data, irreproducible results, and pipelines that break as your project grows. The right choice provides clarity, integrity, and scalability.

This chapter introduces data models conceptually, then focuses on why relational databases—and specifically DataJoint's approach to them—are particularly well-suited for scientific research.

## Definition

```{card} Data Model
A *data model* is a conceptual framework that defines how data is organized, represented, and transformed. It gives us the components for creating blueprints for the structure and operations of data management systems, ensuring consistency and efficiency in data handling.

Data management systems are built to accommodate these models, allowing us to manage data according to the principles laid out by the model. If you're studying data science or engineering, you've likely encountered different data models, each providing a unique approach to organizing and manipulating data.

A data model is defined by considering the following key aspects:
* What are the fundamental elements used to structure the data?
* What operations are available for defining, creating, and manipulating the data?
* What mechanisms exist to enforce the structure and rules governing valid data interactions?
```

Innovations in data models have spurred progress by creating new mental tools for us to think about data and to communicate with machines and with each other. Scientists and engineers who become well-versed in effective data models can collaborate more efficiently because they share a common conceptual framework.

DataJoint's *Entity-Workflow Model* reinterprets relational database theory through the lens of **human and computational workflows**. While rooted in classical relational concepts, DataJoint introduces new constructs and semantics specifically designed for scientific computing, where tracking provenance and maintaining computational validity are as important as storing and querying data.

:::{hint} What data models do you already know?
Before moving forward, take a moment to consider the different data models you're already familiar with. Perhaps you've worked with a spreadsheet, a database, or a programming language but didn't know that they were distinct data models.
Describe a common data model by naming the building blocks that the model uses to represent and manipulate data.
What are the key operations for creating, modifying, and querying data within this data model?
What constraints does the model impose to reduce errors?
:::

## Schema vs. Schemaless Data Models

Two broad families of data models are distinguished by whether or not they support **schemas**: specifications of data structure apart from any instance of the data. 

```{card} Schema
A **schema** is the detailed formal specification of data structure in a database that exists separately from any sample of the data.
Structured data models provide ways to define a schema explicitly.
Unstructured or self-describing data models do not rely on schemas; instead, they communicate data structure through examples, using samples of data.
```

These two approaches represent different philosophies in how data structure is defined, managed, and validated.

### Structured Data Models

In structured data models, the structure of the data is defined separately from the data itself. This predefined structure is known as a **schema**. A schema acts as a blueprint for the data, specifying the types of data that can be stored, the relationships between different data elements, and any constraints or rules that must be followed.

**Structured data models** provide a data definition language (DDL) for defining schemas. Schemas are then used for enforcing or validating structure in the data written into the database. Relational databases are the prime example of structured data with elaborate schemas capable of expressing complex relationships between entities.

- **Schema as Blueprint**: A schema defines the organization of data within the model, including the fields, data types, and relationships between them. It provides a rigid framework that ensures consistency and integrity of the data. For example, in a relational database, the schema would define tables, columns, data types (e.g., integers, strings), and relationships (e.g., foreign keys) between tables.

- **Validation**: One of the key benefits of having a schema is the ability to validate data before it is stored. The schema serves as a gatekeeper, allowing only data that conforms to the predefined structure to be accepted. This ensures that the data remains consistent, predictable, and reliable. If data does not match the schema, it can be rejected or corrected before being saved.

- **Example**: The quintessential example of a structured data model is the **relational database model**, where data is organized into tables with clearly defined columns and relationships. Each table has a schema that dictates what kind of data it can hold, ensuring that every entry conforms to the expected format.

### Self-Describing (Schemaless) Data Models

In contrast, self-describing or schemaless data models do not require a predefined schema. Instead, the structure of the data is embedded within the data itself, allowing for greater flexibility and adaptability.

**Self-describing** or **schemaless** data models allow instances of the data to define their own structure.
Many common file formats such as JSON, YAML, and HDF5 contain self-describing data: the names of entities, their attributes names and types, and their hierarchical relationships are encoded in each instance of the data.

- **Self-Describing Structure**: In self-describing data models, each piece of data carries its own structure. This means that the structure of the data can vary from one entry to another, without the need for a strict, overarching schema. The structure is inferred from the data itself, making these models highly flexible and adaptable to changing data requirements.

- **Flexibility**: The primary advantage of self-describing models is their flexibility. Since there is no rigid schema, new types of data can be added or existing structures can be modified without needing to overhaul the entire database. This makes self-describing models particularly useful in environments where the data is diverse or evolving rapidly.

- **Example**: A common example of a self-describing data model is **JSON (JavaScript Object Notation)**. In JSON, data is stored as key-value pairs, where the structure is defined within each data entry. This allows for varying structures within the same dataset, enabling a more dynamic and flexible approach to data management.

### Choosing Between Structured and Schemaless Models

Both structured and schemaless data formats can be attractive in various scenarios. Schemaless approaches may be more suitable for exploratory analysis where each data instance may differ in structure. Structured approaches become necessary for large-scale automated operations for uniformity and efficiency.

The choice between using a structured or schemaless data model often depends on the specific needs of the application:

- **When to Use Structured Models**: If data consistency, integrity, and the ability to enforce rules and relationships are paramount, a structured model with a well-defined schema is ideal. This is common in financial systems, enterprise databases, and other scenarios where data must adhere to strict standards.

- **When to Use Schemaless Models**: If flexibility, rapid development, and the ability to handle diverse or changing data are more important, a self-describing or schemaless model may be better suited. This is typical in web applications, content management systems, and scenarios where the data structure is likely to evolve over time.

Both approaches have their strengths and are often used together in hybrid systems, where some data is managed with a strict schema and other data is stored more flexibly.

## Essential Examples of Data Models

To understand the range of data models and appreciate why relational databases are well-suited for scientific work, let's examine four contrasting examples.

### Example: Binary Files

The data model of a binary file is the simplest and least constrained, consisting of a continuous sequence of bits (1s and 0s). These bits are typically grouped into bytes (8 bits each) for basic structure, but beyond this, binary files have no inherent organization or meaning. The interpretation of the data within a binary file is entirely dependent on the application that reads it.

The operations supported by a binary file are minimal:
- **Reading and Writing Bits/Bytes**: You can read or modify the individual bits or bytes at specific locations within the file.
- **Changing File Length**: You can increase or decrease the file's length by adding or removing bits/bytes.

Binary files serve as a flexible, low-level data storage format, allowing applications to store any type of data without predefined structure, making them ideal for storing raw data, executable programs, or proprietary file formats.

### Example: Spreadsheets

Electronic spreadsheets are among the most widely used tools for data management and analysis across business, science, and everyday household tasks. The first spreadsheet program, VisiCalc, launched in 1979, played a key role in the commercial success of personal computers.

The data model of a spreadsheet is straightforward and user-friendly, enabling intuitive interactions:

1. **Grid of Cells**: Spreadsheets organize data in a rectangular grid, where each cell is identified by its position (e.g., A1, B2). This simple structure allows users to easily locate and manipulate data.

2. **Values or Formulas**: Each cell in a spreadsheet can hold a value (such as text, numbers, or dates), a formula that references other cells, or remain empty. Formulas automatically update when referenced cells change, which can trigger further updates across the spreadsheet.

Users interact with spreadsheets by manually entering data or formulas into specific cells. When the content of a cell changes, any related formulas recalculate automatically, often leading to cascading updates throughout the sheet.

In addition to basic data entry, spreadsheets offer a wide range of features, including formatting options and the ability to create charts, making them versatile tools for data analysis and presentation.

**Limitations for Scientific Workflows**: While spreadsheets are intuitive and widely accessible, they have significant limitations for complex scientific work:
- No enforcement of data types or constraints
- Formulas are implicit dependencies, easily broken
- No version control or collaboration features
- Limited scalability for large datasets
- No separation between data and computation

### Example: Relational Databases

The **relational data model**, introduced by Edgar F. Codd in 1970, revolutionized data management by organizing data into tables (relations) with well-defined relationships. This model emphasizes data integrity, consistency, and powerful query capabilities through a formal mathematical foundation.

The relational model organizes all data into tables representing mathematical relations, where each table consists of rows (representing mathematical *tuples*) and columns (often called *attributes*).

The relational model is built on several key principles:

- **Data Representation**: All data is represented in the form of simple tables, with each table having a unique name and a well-defined structure.
- **Domain Constraints**: Each column in a table is associated with a specific domain (or *datatype*, a set of possible values), ensuring that the data entered is valid.
- **Uniqueness Constraints**: Ensure that each row in a table is unique, enforced through a primary key.
- **Referential Constraints**: Ensure that relationships between tables remain consistent, enforced through foreign keys.
- **Declarative Queries**: The model allows users to write queries that specify *what* data they want rather than *how* the database will retrieve it.

The most common way to interact with relational databases is through the Structured Query Language (SQL), a language specifically designed to define, manipulate, and query data within relational databases.

**Why This Model Dominates**: The relational model's mathematical rigor provides:
- Provable properties about query optimization
- Formal guarantees about data integrity
- A declarative query language (SQL) that separates "what" from "how"
- Decades of optimization making it highly efficient

The rest of this book focuses on the relational model, but specifically through **DataJoint**—a modern interpretation that extends classical relational theory to explicitly support computational workflows. We introduce these concepts properly in following sections.

### Example: Document Databases (JSON)

The Document Data Model, commonly exemplified by JSON (JavaScript Object Notation), organizes data as key-value pairs within structured documents. This flexible, text-based format is widely used for data interchange between systems, particularly in web applications and APIs.

#### Structure

- **Key-Value Pairs**: The fundamental building block of JSON is the key-value pair. Each key is a string, and it maps to a value, which can be a primitive type (such as a number or string) or a more complex type (such as an object or array).

- **Objects**: Objects in JSON are collections of key-value pairs, enclosed in curly braces `{}`. Each key within an object is unique, and the values can be of any valid JSON type.

- **Arrays**: Arrays are ordered lists of values, enclosed in square brackets `[]`. The values within an array can be of different types, including other arrays or objects, making JSON highly flexible for representing complex data structures.

- **Primitive Types**: JSON supports simple data types such as numbers, strings, booleans (`true` or `false`), and `null` (represents an empty or non-existent value).

#### Common Uses

- **APIs**: JSON is the de facto standard for data exchange in RESTful APIs, enabling communication between clients and servers.
- **Configuration Files**: JSON is often used for configuration files, storing settings in a structured, human-readable format.
- **NoSQL Databases**: Many NoSQL databases, like MongoDB, use a JSON-like format (BSON) to store documents, allowing for flexible schema design and dynamic data storage.

The Document Data Model, with JSON as its most common implementation, offers flexibility and simplicity for handling structured data, making it an ideal choice for many modern applications where rapid development and schema flexibility are prioritized over strict data integrity guarantees.

## Data Models in Science

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

### Scientific Integrity Depends on Data Integrity 

In recent years, concerns about scientific integrity have brought greater attention to proper data management serving as the foundation for reproducible science and valid findings.
As science becomes more complex and interconnected, meticulous data handling—including reproducibility and data provenance—has become critical.
Proper data management ensures that research findings can be reliably reproduced, which is essential for validating results and building on previous work.
Moreover, maintaining clear records of **data provenance**—the detailed history of how data is collected, processed, and analyzed—provides transparency and accountability, helping to prevent issues such as data manipulation and fostering trust in scientific outcomes.
As the volume of data increases and research becomes more collaborative, the emphasis on reproducibility and provenance is not just a best practice; it is a necessity for advancing knowledge, maintaining public trust, and ensuring the long-term credibility of science.

There is now a strong case for the use of structured data models in science, models that enforce data integrity from the outset.
Structured models, which come with predefined schemas, allow the organization of data to evolve alongside the research.
As studies progress and new insights are gained, schemas can be adjusted to reflect the emerging structure and logic of the study.
This approach not only ensures consistency and integrity but also simplifies data sharing and publication.

However, traditional structured databases, designed primarily for business transactions, don't naturally capture the **computational workflows** central to scientific research. Science isn't just about storing data—it's about transforming raw observations into analyzed results through defined processing steps. This is where DataJoint's reinterpretation of relational databases becomes essential.

## DataJoint: Relational Databases as Computational Workflows

**DataJoint** represents a distinctive reinterpretation of the relational data model, specifically designed for scientific computing. While built on Codd's relational theory, DataJoint introduces a fundamentally different perspective: **databases as computational workflows that mix manual and automated steps**.

### Key Innovation: Workflows, Not Just Storage

Traditional relational databases focus on **storing and retrieving data**. DataJoint extends this to explicitly model **computational pipelines** with provenance tracking and computational validity. What makes DataJoint unique is treating the **schema itself as the workflow specification**.

```
Session (manual) 
    ↓
Recording (imported from instruments)
    ↓
FilteredRecording (computed automatically)
    ↓
SpikeSorting (computed automatically)
    ↓
NeuronStatistics (computed automatically)
```

This isn't just documentation—it's the actual dependency structure enforced by the database. When upstream data changes, downstream results **must** be recomputed or deleted. There's no way to silently invalidate the pipeline.

This transforms ad-hoc research workflows into **rigorous, reproducible scientific operations**, bridging the gap between exploratory science and production-grade data management.

### DataJoint as a Distinct Data Model

While rooted in relational theory, DataJoint constitutes a **distinct data model** because it:

1. **Redefines the purpose**: From data storage → workflow specification
2. **Introduces new constructs**: Table types with computational roles (Manual, Imported, Computed, Lookup)
3. **Changes operational semantics**: Immutability as the default, UPDATE as exception
4. **Adds new operations**: `populate()` for automatic computation
5. **Enforces new constraints**: Computational validity, not just relational consistency

DataJoint demonstrates that data discipline can start early in research projects, even during fast-evolving exploratory phases. By providing structured, workflow-aware data management that can evolve alongside the science, DataJoint offers researchers the best of both worlds: the freedom to explore and the rigor to ensure their findings remain valid and reproducible.

## Moving Forward: The Relational Foundation

The next chapter introduces the relational model in depth—its mathematical foundations, operations, and why it provides such a powerful framework for data management. We'll see how this model's rigor and expressiveness make it ideal for scientific computing, especially when extended with workflow awareness as DataJoint does.

## Exercises

1. Think of additional data models you might be familiar with in terms of their basic constructs, operations, and data integrity rules. Consider: CSV files, XML, MATLAB files, HDF5, YAML. What are their fundamental elements, operations, and constraints?

2. Compare spreadsheets and relational databases for a scientific workflow you know. What works well in spreadsheets? What breaks down as complexity grows?

3. Find a data standard in your field (like BIDS or NWB in neuroscience). How does it impose structure on flexible formats? What are the trade-offs?

4. Identify a workflow in your own research. What data is manually entered? What's computed? How do you currently ensure downstream results stay consistent with upstream data?
