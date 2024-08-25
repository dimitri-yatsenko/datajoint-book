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

# Data models for databases
Databases have been built on a variety of data models. 
As Guy Harrison describes in his 2015 book "Next Generation Databases" [@10.1007/978-1-4842-1329-2], the database industry has undergone three major revolutions:
1. Pre-relational (1950-1972)
2. Relational (1972-2005)
3. The Next Generation (2005-future)

The impact of the relational data model has been so great that the last two revolutions in databases have been defined by first embracing and then diverging from the relational model.

The NOSQL revolution, starting in the early 2000s, was propelled by a few factors:
 * The need to scale databases beyond the capabilities of the existing relational database management systems at the time. 
 * The need to represent data structures that are difficult to express in relational constructs: e.g. vectors, JSON documents, data streams.
 * The need for simpler data models where relational databases were simply overkill of complexity: e.g. key-value stores.

This led to an explosion of new database architectures. 

In the meantime, relational databases did not stay in place, adopted new capabilities for scalability and versatility.

A modern relational database management system can accommodate diverse data models and serve a variaty of data handling jobs that can reasonably replace a variety of software systems.  

A number of articles describe how one can simplify system design replacing many components with a relatioanl datababse: [Just use Postgres for everything](https://www.amazingcto.com/postgres-for-everything/):

:::{iframe} https://www.youtube.com/watch?v=lYsQ_riVC4Y
:width: 50%
Just use Postgres for everything
:::

The website https://db-engines.com/en/ranking keeps track of the most popular DBMS. 
The relational data model dominates, although many of the popular database systems support other models, allowing for deviations from the relational data model.
