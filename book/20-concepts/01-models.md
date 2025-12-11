---
title: Data Models
---

The previous chapter introduced databases as dynamic systems that enforce rules, maintain integrity, and provide secure, concurrent access. But what principles guide how we organize data within a database? That's where **data models** come in.

## Why Data Models Matter

Every time you organize data, you're using a data model—whether you realize it or not. When you create a spreadsheet, write a Python dictionary, or save files in folders, you're working within the constraints and capabilities of that model's structure.

For scientists managing complex, evolving datasets, choosing the right data model is crucial. The wrong choice can lead to inconsistent data, irreproducible results, and pipelines that break as your project grows. The right choice provides clarity, integrity, and scalability.

This chapter introduces data models conceptually, explores the critical distinction between metadata and schemas, then focuses on why relational databases—and specifically DataJoint's approach to them—are particularly well-suited for scientific research.

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

DataJoint's *Relational Workflow Model* reinterprets relational database theory through the lens of **human and computational workflows**. While rooted in classical relational concepts, DataJoint introduces new constructs and semantics specifically designed for scientific computing, where tracking provenance and maintaining computational validity are as important as storing and querying data.

:::{hint} What data models do you already know?
Before moving forward, take a moment to consider the different data models you're already familiar with. Perhaps you've worked with a spreadsheet, a database, or a programming language but didn't know that they were distinct data models.

Describe a common data model by naming the building blocks that the model uses to represent and manipulate data. What are the key operations for creating, modifying, and querying data within this data model? What constraints does the model impose to reduce errors?
:::

## Schema vs. Schemaless Data Models

Two broad families of data models are distinguished by whether or not they support **schemas**: specifications of data structure apart from any instance of the data. 

```{card} Schema
A **schema** is the detailed formal specification of data structure in a database that exists separately from any sample of the data.
Structured data models provide ways to define a schema explicitly.
Unstructured or self-describing data models do not rely on schemas; instead, they communicate data structure through examples, using samples of data.
```

These two approaches represent different philosophies in how data structure is defined, managed, and validated. Understanding this distinction is crucial for appreciating what structured data models provide and when each approach is appropriate.

### Structured Data Models

In structured data models, the structure of the data is defined separately from the data itself. This predefined structure is known as a **schema**. A schema acts as a blueprint for the data, specifying the types of data that can be stored, the relationships between different data elements, and any constraints or rules that must be followed.

**Structured data models** provide a data definition language (DDL) for defining schemas. Schemas are then used for enforcing or validating structure in the data written into the database. Relational databases are the prime example of structured data with elaborate schemas capable of expressing complex relationships between entities.

- **Schema as Blueprint**: A schema defines the organization of data within the model, including the fields, data types, and relationships between them. It provides a rigid framework that ensures consistency and integrity of the data. For example, in a relational database, the schema would define tables, columns, data types (e.g., integers, strings), and relationships (e.g., foreign keys) between tables.

- **Validation**: One of the key benefits of having a schema is the ability to validate data before it is stored. The schema serves as a gatekeeper, allowing only data that conforms to the predefined structure to be accepted. This ensures that the data remains consistent, predictable, and reliable. If data does not match the schema, it can be rejected or corrected before being saved.

- **Example**: The quintessential example of a structured data model is the **relational database model**, where data is organized into tables with clearly defined columns and relationships. Each table has a schema that dictates what kind of data it can hold, ensuring that every entry conforms to the expected format.

### Self-Describing (Schemaless) Data Models

In contrast, self-describing or schemaless data models do not require a predefined schema. Instead, the structure of the data is embedded within the data itself, allowing for greater flexibility and adaptability.

**Self-describing** or **schemaless** data models allow instances of the data to define their own structure. Many common file formats such as JSON, YAML, and HDF5 contain self-describing data: the names of entities, their attributes names and types, and their hierarchical relationships are encoded in each instance of the data.

- **Self-Describing Structure**: In self-describing data models, each piece of data carries its own structure. This means that the structure of the data can vary from one entry to another, without the need for a strict, overarching schema. The structure is inferred from the data itself, making these models highly flexible and adaptable to changing data requirements.

- **Flexibility**: The primary advantage of self-describing models is their flexibility. Since there is no rigid schema, new types of data can be added or existing structures can be modified without needing to overhaul the entire database. This makes self-describing models particularly useful in environments where the data is diverse or evolving rapidly.

- **Example**: A common example of a self-describing data model is **JSON (JavaScript Object Notation)**. In JSON, data is stored as key-value pairs, where the structure is defined within each data entry. This allows for varying structures within the same dataset, enabling a more dynamic and flexible approach to data management.

### Choosing Between Structured and Schemaless Models

Both structured and schemaless data formats can be attractive in various scenarios. The choice between using a structured or schemaless data model often depends on the specific needs of the application:

**Use structured models when:**
- Data consistency and integrity are paramount
- Relationships must be enforced automatically
- Multiple users need guaranteed consistent views
- The cost of data errors is high
- Provenance and reproducibility are essential

**Use schemaless models when:**
- Rapid ingestion of diverse data is the priority
- Data structure is genuinely unknown or rapidly evolving
- Exploration and discovery are primary goals
- Some inconsistency is tolerable during initial phases

Both approaches have their strengths and are often used together in hybrid systems, where some data is managed with a strict schema and other data is stored more flexibly.

## Metadata vs. Schema: Describing vs. Enforcing

Understanding the difference between metadata and schemas is crucial for appreciating what structured data models provide. Both help us understand data, but in fundamentally different ways. This distinction has become particularly important in the AI era, where some advocate for flexible, metadata-rich approaches over structured schemas.

### What Metadata Provides

**Metadata**—data about the data—is undoubtedly valuable. It provides context, aids discoverability, and tracks provenance. Metadata tags and describes relationships externally. A tag might state that dataset A relates to dataset B, but this description often exists separately and relies on consistent human interpretation or application logic.

Think of metadata like tagging a passenger with her desired destination and putting name tags on her luggage. This provides useful context for her journey—you know where she wants to go and can identify her bags. The tags are helpful, informative, and make the system more understandable.

### What Schemas Enforce

A formal schema expresses and enforces relationships as an intrinsic, verifiable part of the data system. Foreign key constraints don't just describe a link; they actively prevent data operations that would violate that link, ensuring referential integrity is maintained by the database itself.

**A schema is what guarantees her assigned seat on the correct flight**, preventing someone else from taking it, and ensuring that her luggage makes the same transfers. The database won't allow her seat to be double-booked, won't let her board without a valid ticket, and won't let her luggage transfer to a different destination. These aren't suggestions or documentation—they're enforced rules.

### Active Enforcement vs. Passive Description

The key distinction is between **active enforcement** and **passive description**:

**Metadata implies relationships:**
- "This analysis was performed on dataset X" (external description)
- "These files belong to experiment Y" (human-maintained association)
- "This result came from subject Z" (documentation in comments or logs)

If you delete dataset X, experiment Y, or subject Z, the metadata doesn't stop you. Your tags now point to nothing, but nothing prevents this inconsistency.

**Schemas enforce relationships:**
- Foreign keys prevent orphaned records automatically
- Data type constraints reject invalid values before storage
- Uniqueness constraints guarantee no duplicates
- Referential integrity ensures all connections remain valid
- Cascade rules specify what happens when dependencies change

If you try to delete dataset X while analysis results depend on it, the database refuses: "Cannot delete—dependent data exists." The system actively protects your data integrity.

### A Scientific Example

Consider a scientific workflow where analysis results depend on raw measurements:

**With metadata only:**
```
measurement_042.dat  (raw data file)
analysis_result.csv  (contains: "source_file: measurement_042.dat")
```

You tag the analysis result with the measurement filename. But if someone deletes `measurement_042.dat`, your tag still points to something that no longer exists. The connection is broken, and nothing warned you. Your published results now reference non-existent source data.

**With schema enforcement:**
```sql
CREATE TABLE Measurement (
    measurement_id INT PRIMARY KEY,
    file_path VARCHAR(255),
    ...
);

CREATE TABLE AnalysisResult (
    result_id INT PRIMARY KEY,
    measurement_id INT NOT NULL,
    ...
    FOREIGN KEY (measurement_id) 
        REFERENCES Measurement(measurement_id)
        ON DELETE RESTRICT
);
```

Now if someone tries to delete the measurement while results depend on it, the database refuses. The system actively protects your data integrity. If you need to delete the measurement, you must first handle the dependent results—either delete them too (CASCADE) or update them to reference corrected data.

### The AI Era: Structure Still Matters

Some argue that AI favors unstructured data and metadata over schemas, framing structure as "rigidity." But this "rigidity" is precisely what ensures **data integrity**—the accuracy, consistency, and reliability of data.

An AI analyzing unstructured data with metadata is like a detective sifting through a disorganized pile of notes, photos, and objects at a crime scene. Insights are possible, but finding connections is slow and prone to misinterpretation. An AI working with well-structured data is like that same detective using neatly organized evidence logs, lab reports, and timestamped witness statements. Connections are clearer, verification is easier, and conclusions are far more reliable.

The rise of AI does not fundamentally alter the basic tradeoffs between schema-on-write and schema-on-read approaches. While AI algorithms can certainly process and find patterns in unstructured data, **the need for verifiable, consistent, and reliable data remains critical**, especially in science where reproducibility and provenance are non-negotiable.

### Schemas as Verifiable Understanding

What does it mean to truly "understand" the relationships within data? One could argue that this understanding is achieved precisely through the act of constructing a schema.

The relational model provides a rich set of mathematical and logical constructs—tables, attributes, domains, primary keys, foreign keys—to formally express discovered relationships. A schema isn't just documentation of what you think the relationships are; it's a formal specification that the database actively maintains and enforces.

Indeed, AI itself might leverage relational concepts. An AI system analyzing vast unstructured data could express its discovered understanding of underlying relationships by constructing a relational schema—defining entities, attributes, and dependencies it has inferred. This would provide a formal, verifiable representation of the AI's findings, transforming implicit patterns into explicit, testable structures that can be validated against ground truth.

### When Each Approach Works

The choice between metadata-centric and schema-enforced approaches depends on your requirements:

**Use metadata and flexible formats when:**
- Rapid ingestion of diverse data is paramount
- Data structure is genuinely unknown or rapidly evolving
- Some inconsistency is tolerable
- Exploration and discovery are the primary goals
- You're in early research phases where understanding is still forming

**Use schemas and structured models when:**
- Data integrity is non-negotiable
- Relationships must remain valid as data evolves
- Multiple users need consistent views of the data
- Provenance and reproducibility are essential
- The cost of errors is high (scientific research, healthcare, finance)
- You're moving from exploration to production workflows

For scientific computing, the need for reproducible, traceable results makes schema-enforced integrity essential. You can't publish findings if you're uncertain whether your results still correspond to the correct source data. This is why DataJoint emphasizes schemas that explicitly capture computational dependencies alongside data relationships.

## Essential Examples of Data Models

To understand the range of data models and appreciate why relational databases are well-suited for scientific work, let's examine four contrasting examples that illustrate the spectrum from unstructured to highly structured approaches.

### Example: Binary Files

The data model of a binary file is the simplest and least constrained, consisting of a continuous sequence of bits (1s and 0s). These bits are typically grouped into bytes (8 bits each) for basic structure, but beyond this, binary files have no inherent organization or meaning. The interpretation of the data within a binary file is entirely dependent on the application that reads it.

The operations supported by a binary file are minimal:
- **Reading and Writing Bits/Bytes**: You can read or modify the individual bits or bytes at specific locations within the file.
- **Changing File Length**: You can increase or decrease the file's length by adding or removing bits/bytes.

Binary files serve as a flexible, low-level data storage format, allowing applications to store any type of data without predefined structure, making them ideal for storing raw data, executable programs, or proprietary file formats. However, this complete lack of structure means no integrity guarantees—you can write anything anywhere, and nothing prevents corruption or inconsistency.

### Example: Spreadsheets

Electronic spreadsheets are among the most widely used tools for data management and analysis across business, science, and everyday household tasks. The first spreadsheet program, VisiCalc, launched in 1979, played a key role in the commercial success of personal computers.

The data model of a spreadsheet is straightforward and user-friendly, enabling intuitive interactions:

1. **Grid of Cells**: Spreadsheets organize data in a rectangular grid, where each cell is identified by its position (e.g., A1, B2). This simple structure allows users to easily locate and manipulate data.

2. **Values or Formulas**: Each cell in a spreadsheet can hold a value (such as text, numbers, or dates), a formula that references other cells, or remain empty. Formulas automatically update when referenced cells change, which can trigger further updates across the spreadsheet.

Users interact with spreadsheets by manually entering data or formulas into specific cells. When the content of a cell changes, any related formulas recalculate automatically, often leading to cascading updates throughout the sheet.

In addition to basic data entry, spreadsheets offer a wide range of features, including formatting options and the ability to create charts, making them versatile tools for data analysis and presentation.

**Limitations for Scientific Workflows**: While spreadsheets are intuitive and widely accessible, they have significant limitations for complex scientific work:
- **No data type enforcement**: You can type anything into any cell
- **Fragile dependencies**: Formulas break easily when rows/columns are inserted or deleted
- **No version control**: Tracking changes requires external systems
- **Limited scalability**: Performance degrades with large datasets
- **No separation of data and computation**: Formulas are mixed with data, making workflows hard to reproduce

Most importantly, spreadsheets provide no referential integrity. If cell B2 contains `=A2*1.5` and you delete row 2, the formula becomes `#REF!`—an error, but one that doesn't prevent you from saving the corrupted spreadsheet. There's no enforcement of computational dependencies.

### Example: Relational Databases

The **relational data model**, introduced by Edgar F. Codd in 1970, revolutionized data management by organizing data into tables (relations) with well-defined relationships. This model emphasizes data integrity, consistency, and powerful query capabilities through a formal mathematical foundation.

The relational model organizes all data into tables representing mathematical relations, where each table consists of rows (representing mathematical *tuples*) and columns (often called *attributes*). Key principles include data type constraints, uniqueness enforcement through primary keys, referential integrity through foreign keys, and declarative queries. The next chapter explores these principles in depth.

The most common way to interact with relational databases is through the Structured Query Language (SQL), a language specifically designed to define, manipulate, and query data within relational databases.

**Why This Model Dominates**: The relational model's mathematical rigor provides:
- **Provable properties** about query optimization
- **Formal guarantees** about data integrity
- **A declarative query language** (SQL) that separates "what" from "how"
- **Decades of optimization** making it highly efficient
- **Active enforcement** of relationships and constraints

Unlike spreadsheets where formulas can break silently, or metadata that only describes relationships, relational databases actively prevent invalid states from occurring.

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

The Document Data Model, with JSON as its most common implementation, offers flexibility and simplicity for handling structured data. This makes it ideal for applications where rapid development and schema flexibility are prioritized over strict data integrity guarantees. However, JSON provides no built-in referential integrity—relationships between documents are maintained by application logic, not by the storage system itself.

## Data Models in Science

Business enterprises have long relied on structured databases to maintain data integrity and consistency, as any breakdown in these areas can lead to serious financial and operational consequences. In these environments, relational databases and SQL are the dominant tools. 

In contrast, scientific research often takes a less structured approach to data management. The experimental nature of science leads researchers to favor flexible, schemaless, unstructured data models. These models allow for the rapid collection of data without the constraints of a predefined structure, making them particularly appealing when the data requirements are not fully understood at the outset.

However, this flexibility comes at a cost.

### The Metadata Approach: Standards on Flexible Formats

When it comes time to publish or share findings, scientists often encounter challenges with heterogeneous datasets that lack consistency and standardization. To address this, researchers develop "data standards" to impose rules and guidelines on unstructured models, ensuring that data can be effectively shared and understood.

For example, the [Brain Imaging Data Structure (BIDS)](https://bids.neuroimaging.io) standard imposes a uniform structure on files and folders used in neuroimaging studies [@10.1038/sdata.2016.44]. Similarly, the [Neurodata Without Borders (NWB)](https://www.nwb.org/) standard imposes structure on top of the flexible HDF5 data model commonly used in neuroscience research [@10.7554/eLife.78362].

Both of these standards enforce structure by using programming interfaces that validate and access the datasets, ensuring that the data adheres to a consistent format despite the underlying unstructured model. While these standards help bring order to unstructured data, they represent a **metadata-based approach**—they describe and validate structure but don't actively enforce relationships through the storage system itself.

### The Hybrid Reality in Practice

Many modern scientific data systems employ a hybrid approach similar to industry practices:

**Data Lakes for Ingestion:** Raw data from instruments and experiments is initially captured in flexible formats—a schema-on-read "staging area" or data lake. This allows rapid collection of diverse data types without upfront structuring. Like dumping all building materials onto a plot, this provides maximum flexibility for incorporating new and unexpected data types.

**Structured Systems for Analysis:** For reliable analytics, reproducible results, and publishable findings, selected data is processed, cleaned, validated, and loaded into structured, schema-on-write systems. This is where databases or data warehouses come in, providing the integrity guarantees that rigorous science demands. Like constructing a building using detailed architectural blueprints, this ensures stability and predictability.

**Emerging Lakehouses:** The data lakehouse architecture aims to combine both approaches, offering flexibility for storing diverse raw data while incorporating the data management, governance, and integrity features traditionally associated with databases.

The key insight: while initial ingestion might be flexible (schema-on-read), there's often a subsequent step where structure (schema-on-write) is applied to ensure integrity and reliability for critical downstream uses. The choice often reflects the project's ambition: an unstructured approach might allow constructing many simple cabins faster, whereas only a structured, planned approach can produce the Burj Khalifa.

### Scientific Integrity Depends on Data Integrity 

In recent years, concerns about scientific integrity have brought greater attention to proper data management as the foundation for reproducible science and valid findings. As science becomes more complex and interconnected, meticulous data handling—including reproducibility and data provenance—has become critical.

**Data provenance**—the detailed history of how data is collected, processed, and analyzed—provides transparency and accountability. But provenance tracked through metadata alone can break:
- Tags pointing to deleted files
- Descriptions of outdated relationships
- Manual records that fall out of sync with actual data
- No automatic notification when source data changes

**Schema-enforced provenance** provides stronger guarantees. When your database schema explicitly captures that "Result X was computed from Input Y," the system can:
- Prevent you from deleting Input Y while Result X still exists
- Automatically identify when Result X needs recomputation because Input Y changed
- Track the exact version and parameters used to compute X from Y
- Guarantee that every result has valid, existing source data

As the volume of data increases and research becomes more collaborative, the emphasis on reproducibility and provenance is not just a best practice; it is a necessity for advancing knowledge, maintaining public trust, and ensuring the long-term credibility of science.

### From Flexibility to Rigor: The Scientific Maturity Arc

There is now a strong case for structured data models in science—models that enforce data integrity from the outset. This doesn't mean abandoning flexibility during exploration, but rather recognizing that as research matures, structure becomes essential:

**Early Exploration:** Flexible, metadata-rich approaches work well when you're discovering what questions to ask and what data structures make sense. You don't want to commit to a schema before you understand your domain.

**Mature Workflows:** Once you understand your workflow, structured schemas ensure that data remains consistent, relationships stay valid, and results are reproducible as your project scales. The upfront cost of defining structure pays dividends in reliability.

**Collaborative Science:** When multiple researchers work with shared data, schema enforcement prevents conflicts and ensures everyone sees consistent results. Metadata-based conventions rely on everyone following the rules; schema enforcement makes compliance automatic.

**Publication and Sharing:** Published results demand reproducibility. Schema-enforced provenance provides mathematical guarantees that results correspond to their claimed sources.

Structured models, which come with predefined schemas, allow the organization of data to evolve alongside the research. As studies progress and new insights are gained, schemas can be adjusted to reflect the emerging structure and logic of the study. This approach not only ensures consistency and integrity but also simplifies data sharing and publication.

### The Computational Workflow Gap

However, traditional structured databases, designed primarily for business transactions, don't naturally capture the **computational workflows** central to scientific research. 

Science isn't just about storing data—it's about transforming raw observations into analyzed results through defined processing steps. Traditional relational databases can store both inputs and outputs, but they treat them equivalently. They can't express:

- **"This result was computed from this input"**: Foreign keys say "this result references this input" but not "this result was derived by applying computation C to input I"
- **"When input changes, recompute all dependent results"**: The database knows relationships exist but not that they represent computational dependencies requiring recomputation
- **"Run this analysis automatically when new data arrives"**: There's no mechanism for "when a new input appears, automatically compute its results"
- **"Track which code version and parameters produced this result"**: Provenance requires external systems; it's not part of the data model

This is where DataJoint's reinterpretation of relational databases becomes essential. By treating computational dependencies as first-class schema elements, DataJoint provides the mathematical rigor of structured data while capturing the workflow semantics that science requires.

## DataJoint: Bridging the Gap

**DataJoint** addresses the computational workflow gap by reinterpreting relational databases specifically for scientific computing. While built on Codd's relational theory, DataJoint introduces a fundamentally different perspective: **databases as computational workflows that mix manual and automated steps**.

The key innovation is treating the **schema itself as the workflow specification**. Table definitions don't just describe data structure—they prescribe how data flows through your pipeline, when computations run, and how results depend on inputs. When upstream data changes, downstream results are automatically invalidated, ensuring that every analysis reflects current inputs.

This transforms ad-hoc research workflows into **rigorous, reproducible scientific operations**, bridging the gap between exploratory science and production-grade data management. The Relational Workflows chapter explores this paradigm in detail.

## Moving Forward: The Relational Foundation

The next chapter introduces the relational model in depth—its mathematical foundations, operations, and why it provides such a powerful framework for data management. We'll see how this model's rigor and expressiveness make it ideal for scientific computing, especially when extended with workflow awareness as DataJoint does.

## Exercises

1. **Metadata vs. Schema**: Think of a data relationship in your research (e.g., "analysis results depend on raw measurements"). How would you represent this with metadata alone? Now design a schema with foreign keys. What can the schema prevent that metadata cannot?

2. **Data Model Comparison**: Compare spreadsheets and relational databases for a scientific workflow you know. What works well in spreadsheets for exploratory analysis? At what point do their limitations become problematic? What would a database provide?

3. **Schema Evolution**: Consider a research project that evolves over time. You start with simple measurements but later add complex multi-part observations. How would you handle this in: (a) a metadata-rich file system, (b) a relational database schema? What are the trade-offs?

4. **AI and Structure**: Find an example where AI is used with unstructured data in your field. How might having structured data with schemas improve or hinder the AI analysis? Consider both the exploration phase and the production phase.

5. **Standards in Your Field**: Identify a data standard in your field (like BIDS or NWB in neuroscience). Is it schema-based or metadata-based? What relationships does it describe vs. enforce? How well does it support computational workflows?

6. **Workflow Dependencies**: Map out a simple analysis workflow from your research with 3-4 steps. For each step, identify: What creates this data (manual/automated)? What does it depend on? What would happen if upstream data changed? How do you currently ensure consistency?
