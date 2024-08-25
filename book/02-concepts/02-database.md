---
title: Databases
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Definition
In this book, we will use the term *database* in a more specialized sense than what you might find through a casual search or in other texts.
Our definition is stricter, emphasizing the critical role of databases in complex operations.

```{card} Database
A **database** is a dynamic, systematically organized collection of data that plays an integral role in a real-world enterprise.
It supports the enterprise’s operations and is accessed by a variety of users in different ways. Examples of enterprises that rely on databases include hotels, airlines, stores, hospitals, universities, banks, and scientific experiments.

The database not only tracks the current state of the enterprise’s processes but also enforces essential *business rules*, ensuring that only valid transactions occur and preventing errors or inconsistencies. It serves as the **system of record**, the **single source of truth**, accurately reflecting the current state and ongoing activities.

**Key traits of databases**:
- Structured data reflects the logic of the enterprise’s operations
- Supports the organization’s operations by reflecting and enforcing its rules and constraints (data integrity)
- Ability to evolve over time
- Facilitates distributed, concurrent access by multiple users
- Centralized data consistency, appearing as a single source of data even if physically distributed, reflecting all changes
- Allows specific and precise queries through various interfaces for different users
```

You might ask: aren’t databases also used for simpler tasks, like keeping a personal recipe book or an address list? While that’s true, our definition focuses on the capabilities of a full-featured database system, which are essential for more complex operations. For simpler needs, an electronic spreadsheet or a collection of shared files might be sufficient. However, when managing something as intricate as a bank or an airline, a comprehensive database system becomes indispensable.

Databases are crucial for the smooth and organized operation of various entities, from hotels and airlines to universities, banks, and research projects. They ensure that processes are accurately tracked, essential rules are enforced, and only valid transactions are allowed, thereby preventing errors or illegal actions.

In summary, databases are designed to support the critical operations of data-driven organizations, enabling effective collaboration among multiple users.

```{card} Database Management Systems (DBMS)
A Database Management System is a software system that serves as the computational engine powering a database.
It defines and enforces the structure of the data, ensuring that the organization’s rules are consistently applied.
A DBMS manages data storage and efficiently executes data updates and queries while safeguarding the data’s structure and integrity, particularly in environments with multiple concurrent users.
```
Consider an airline's database for flight schedules and ticket bookings. The airline must adhere to several key rules:

* A seat cannot be booked by two passengers for the same flight.
* A seat is considered reserved only after all details are verified and payment is processed.

A robust DBMS enforces such rules reliably, ensuring smooth operations, while interacting with multiple users and systems at once.

Databases are dynamic, with data continuously updated by both users and systems. Even in the face of disruptions like power outages, errors, or cyberattacks, the DBMS ensures that the system recovers quickly and returns to a stable state. For users, the database should function seamlessly, allowing actions to be performed without interference from others working on the system simultaneously.

# Data Models for Databases

Databases have evolved through various data models over the decades. As Guy Harrison outlines in his 2015 book, *Next Generation Databases* [@10.1007/978-1-4842-1329-2], the database industry has experienced three major revolutions:

1. **Pre-relational (1950-1972)**
2. **Relational (1972-2005)**
3. **The Next Generation (2005-future)**

The relational data model has had a profound impact, shaping the last two revolutions in database technology.
Initially, the industry embraced the relational model, which offered a structured, standardized way to organize and query data.
However, as data needs evolved, the limitations of the relational model prompted the rise of alternative approaches, leading to the NOSQL revolution in the early 2000s.

## The NOSQL Revolution

The NOSQL movement emerged in response to several key challenges:

- **Scalability:** The need to scale databases beyond the capabilities of existing relational database management systems (RDBMS) at the time.
- **Diverse Data Structures:** The necessity to represent data structures that are difficult to express in relational terms, such as graphs, JSON documents, and data streams.
- **Simplicity:** The demand for simpler data models where the complexity of relational databases was unnecessary, such as key-value stores.

This revolution led to an explosion of new database architectures, each tailored to specific use cases that traditional relational databases struggled to address.

## Evolution of Relational Databases

Despite the rise of NoSQL, relational databases have not remained static.
They have evolved to incorporate new capabilities for scalability and versatility.
Modern relational database management systems (RDBMS) are now highly adaptable, accommodating diverse data models and handling a wide range of data management tasks.
In many cases, they can replace a variety of specialized software systems, simplifying system design.

An example of this adaptability is the growing trend of using relational databases to streamline system architectures, as highlighted in articles like [“Just Use Postgres for Everything”](https://www.amazingcto.com/postgres-for-everything/).

:::{iframe} https://www.youtube.com/embed/lYsQ_riVC4Y
:width: 100%
Just use Postgres for everything
:::

## Scalable Architectures in Relational Databases

To meet the growing demand for scalable architectures, relational databases have evolved to incorporate distributed systems. These systems use consensus algorithms, such as Paxos and [Raft](https://www.usenix.org/conference/atc14/technical-sessions/presentation/ongaro), to ensure data consistency across globally distributed, high-performance databases. Notable examples of these advanced systems include Google Spanner [@10.1145/3035918.3056103] and CockroachDB [@10.1145/3318464.3386134].

Since its meteoric rise between 2008 and 2015, the term "NoSQL" has gradually fallen out of favor, as it no longer effectively describes the diverse landscape of modern databases. Today, we operate in a world with multiple data models, where the relational model remains dominant due to its mathematical rigor and versatility. However, it now coexists with more specialized and simpler models that cater to specific use cases.

## Current Landscape of Database Models

The website [DB-Engines Ranking](https://db-engines.com/en/ranking) tracks the popularity of various database management systems. While the relational data model continues to dominate, many popular databases now support multiple data models, allowing for deviations from strict relational structures.

Notably, the two most popular open-source relational databases, MySQL (along with its sister MariaDB) and PostgreSQL, remain at the forefront of this evolving landscape.
