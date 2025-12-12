---
title: Databases
---

## What is a Database?

```{card} Database
A **database** is a dynamic (i.e. *time-varying*), systematically organized collection of data that plays an integral role in the operation of an enterprise.
It supports the enterprise's operations and is accessed by a variety of users in different ways. Examples of enterprises that rely on databases include hotels, airlines, stores, hospitals, universities, banks, and scientific studies.

The database not only tracks the current state of the enterprise's processes but also enforces essential *business rules*, ensuring that only valid transactions occur and preventing errors or inconsistencies. It serves as the **system of record**, the **single source of truth**, accurately reflecting the current state and ongoing activities.

**Key traits of databases**:
- Structured data reflects the logic of the enterprise's operations
- Supports the organization's operations by reflecting and enforcing its rules and constraints (data integrity)
- **Precise access control ensures only authorized users can view or modify specific data**
- Ability to evolve over time
- Facilitates distributed, concurrent access by multiple users
- Centralized data consistency, appearing as a single source of data even if physically distributed, reflecting all changes
- Allows specific and precise queries through various interfaces for different users
```

Databases are crucial for the smooth and organized operation of various entities, from hotels and airlines to universities, banks, and research projects. They ensure that processes are accurately tracked, essential rules are enforced, only valid transactions are allowed, and **sensitive data is protected** from unauthorized access. This combination of data integrity and data security makes databases indispensable for any operation where data reliability and confidentiality matter.

## Database Management Systems (DBMS)

```{card} Database Management System
A Database Management System (DBMS) is a software system that serves as the computational engine powering a database.
It defines and enforces the structure of the data, ensuring that the organization's rules are consistently applied.
A DBMS manages data storage and efficiently executes data updates and queries while safeguarding the data's structure and integrity, particularly in environments with multiple concurrent users.

**Critically, a DBMS also manages user authentication and authorization**, controlling who can access which data and what operations they can perform.
```

Consider an airline's database for flight schedules and ticket bookings. The airline must adhere to several key rules:

* A seat cannot be booked by two passengers for the same flight
* A seat is considered reserved only after all details are verified and payment is processed
* **Only authorized ticketing agents can modify reservations**
* **Passengers can view only their own booking information**
* **Financial data is accessible only to accounting staff**

A robust DBMS enforces such rules reliably, ensuring smooth operations while interacting with multiple users and systems at once. The same system that prevents double-booking also prevents unauthorized access to passenger records.

Databases are dynamic, with data continuously updated by both users and systems. Even in the face of disruptions like power outages, errors, or cyberattacks, the DBMS ensures that the system recovers quickly and returns to a stable state. For users, the database should function seamlessly, allowing actions to be performed without interference from others working on the system simultaneously—**while ensuring they can only perform actions they're authorized to do**.

## Data Security and Access Management

One of the most critical features distinguishing databases from simple file storage is **precise access control**. In scientific research, healthcare, finance, and many other domains, not all data should be accessible to all users.

### Authentication and Authorization

Before you can work with a database, you must **authentication**—prove your identity with a username and password. Once authenticated, the database enforces **authorization** rules that determine what you can do:

- **Read**: View specific tables or columns
- **Write**: Add new data to certain tables  
- **Modify**: Change existing data (where permitted)
- **Delete**: Remove data (if authorized)

For example, in a research lab database:
- A principal investigator might have full access to all experimental data
- A graduate student might read and write only to their assigned experiments
- An external collaborator might have read-only access to published results
- An undergraduate assistant might only insert data for specific protocols

### Why Database-Level Security Matters

Without centralized access control, you'd need to implement security restrictions in every script, notebook, and application that touches your data. If someone writes a new analysis program, they'd need to correctly re-implement all security logic—a recipe for errors and breaches.

Database-level security means the database itself enforces these rules uniformly, regardless of how users connect. This is especially important for:

- **Regulatory compliance**: HIPAA for patient data, GDPR for personal information
- **Collaborative research**: Different partners may have access to different datasets  
- **Sensitive data**: Unpublished results, proprietary information, personally identifiable data
- **Accountability**: Knowing who accessed or modified what data, and when

## Database Architecture

Modern databases typically separate data management from data use through distinct architectural roles. Understanding these roles helps clarify how databases maintain consistency and security across multiple users and applications.

### Common Architectures

**Server-client architecture** (most common): A database server program manages all data operations, while client programs (your scripts, applications, notebooks) connect to request data or submit changes. The server enforces all rules and access permissions consistently for every client. This is like a library where the librarian (server) manages the books and enforces checkout policies, while patrons (clients) request materials.
The two most popular open-source relational database systems: MySQL and PostgreSQL implement a server-client architecture.

**Embedded databases**: The database engine runs within your application itself—no separate server. This works for single-user applications like mobile apps or desktop software, but doesn't support multiple users accessing shared data simultaneously.
SQLite is a common embedded database @10.14778/3554821.3554842.

**Distributed Databases**: Data and processing are spread across multiple servers working together. This provides high availability and can handle massive scale, but adds significant complexity. Systems like Google Spanner, Amazon DynamoDB, and CockroachDB use this approach.

For collaborative scientific research, the server-client architecture dominates because it naturally supports multiple researchers working with shared data while maintaining consistent integrity and security rules.

### Why Architectural Separation Matters

Separating data management from data use provides critical advantages:

**Centralized Control**: All data lives in one managed location. Updates are immediately visible to everyone. There's no confusion about which copy of the data is current.

**Consistent Rules**: The database enforces integrity constraints and access permissions uniformly. Whether you connect through Python, R, a web interface, or a command-line tool, the same rules apply.

**Specialized Optimization**: The database system focuses exclusively on efficient, reliable data management—fast queries, safe concurrent access, automatic backups. Your applications focus on research logic and user interfaces.

**Language Independence**: The same database serves Python scripts, R analyses, web dashboards, and automated pipelines. Each tool does what it does best, all working with the same reliable, secure data.

## Preview: DataJoint and This Book

This book focuses on **DataJoint**, a framework that extends relational databases specifically for scientific workflows. DataJoint builds on the solid foundation of relational theory while adding capabilities essential for research: automated computation, data provenance, and reproducibility.

The relational data model—introduced by Edgar F. Codd in 1970—revolutionized data management by organizing data into tables with well-defined relationships. This model has dominated database systems for over five decades due to its mathematical rigor and versatility. Modern relational databases like MySQL and PostgreSQL continue to evolve, incorporating new capabilities for scalability and security while maintaining the core principles that make them reliable and powerful.

The following chapters build the conceptual foundation you need to understand DataJoint's approach:
- **Data Models**: What data models are and why schemas matter for scientific work
- **Relational Theory**: The mathematical foundations that make relational databases powerful
- **Relational Practice**: Hands-on experience with database operations
- **Relational Workflows**: How DataJoint extends relational theory for computational pipelines
- **Scientific Data Pipelines**: How workflows scale into complete research data operations systems

By the end, you'll understand both the mathematical foundations and their practical application to your research.
