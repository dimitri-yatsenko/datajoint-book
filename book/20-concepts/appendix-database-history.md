---
title: "Appendix: Database Revolutions"
---

This appendix provides historical context on the evolution of database systems, particularly the rise of NoSQL databases and the continued evolution of relational systems. This material complements Chapter 1 but isn't essential for understanding DataJoint.

## Data Models for Databases

Databases have evolved through various data models over the decades. As Guy Harrison outlines in his 2015 book, *Next Generation Databases* [@10.1007/978-1-4842-1329-2], the database industry has experienced three major revolutions:

1. **Pre-relational (1950-1972)**
2. **Relational (1972-2005)**
3. **The Next Generation (2005-future)**

The relational data model has had a profound impact, shaping the last two revolutions in database technology.
Initially, the industry embraced the relational model, which offered a structured, standardized way to organize and query data.
However, as data needs evolved, the limitations of the relational model prompted the rise of alternative approaches, leading to the NoSQL revolution in the early 2000s.

## The NoSQL Revolution

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

An example of this adaptability is the growing trend of using relational databases to streamline system architectures, as highlighted in articles like ["Just Use Postgres for Everything"](https://www.amazingcto.com/postgres-for-everything/).

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

## Why This Matters for Scientists

The database landscape's evolution shows that no single approach fits all needs. The rise and evolution of NoSQL demonstrates that:

1. **Specialization has value**: Different data models excel at different tasks
2. **Relational databases adapted**: Modern RDBMS incorporated lessons from NoSQL
3. **Mathematical rigor persists**: Relational theory's foundation remains relevant

For scientific computing, the relational model's mathematical rigor—combined with modern extensions like DataJoint's workflow awareness—provides the structure and guarantees that research demands. The NoSQL revolution taught us to question assumptions and specialize tools, but it also confirmed that relational theory's foundations were sound enough to evolve rather than be replaced.
