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
- Ability to evolve over time
- Facilitates distributed, concurrent access by multiple users
- Centralized data consistency, appearing as a single source of data even if physically distributed, reflecting all changes
- Allows specific and precise queries through various interfaces for different users
```

Databases are crucial for the smooth and organized operation of various entities, from hotels and airlines to universities, banks, and research projects. They ensure that processes are accurately tracked, essential rules are enforced, and only valid transactions are allowed, thereby preventing errors or inconsistencies. Databases are designed to support the critical operations of data-driven organizations, enabling effective collaboration among multiple users.

## Database Management Systems (DBMS)

```{card} Database Management System
A Database Management System is a software system that serves as the computational engine powering a database.
It defines and enforces the structure of the data, ensuring that the organization's rules are consistently applied.
A DBMS manages data storage and efficiently executes data updates and queries while safeguarding the data's structure and integrity, particularly in environments with multiple concurrent users.
```

Consider an airline's database for flight schedules and ticket bookings. The airline must adhere to several key rules:

* A seat cannot be booked by two passengers for the same flight.
* A seat is considered reserved only after all details are verified and payment is processed.

A robust DBMS enforces such rules reliably, ensuring smooth operations while interacting with multiple users and systems at once.

Databases are dynamic, with data continuously updated by both users and systems. Even in the face of disruptions like power outages, errors, or cyberattacks, the DBMS ensures that the system recovers quickly and returns to a stable state. For users, the database should function seamlessly, allowing actions to be performed without interference from others working on the system simultaneously.

## Preview: DataJoint and This Book

This book focuses on **DataJoint**, a framework that extends relational databases specifically for scientific workflows. DataJoint builds on the solid foundation of relational theory while adding capabilities essential for research: automated computation, data provenance, and reproducibility.

The relational data model—introduced by Edgar F. Codd in 1970—revolutionized data management by organizing data into tables with well-defined relationships. This model has dominated database systems for over five decades due to its mathematical rigor and versatility. Modern relational databases like MySQL and PostgreSQL continue to evolve, incorporating new capabilities for scalability while maintaining the core principles that make them reliable and powerful.

DataJoint extends this proven foundation with workflow-aware capabilities that scientific computing requires. We'll first introduce relational database concepts and operations, then show how DataJoint transforms these concepts into a powerful tool for scientific computing. By the end, you'll understand both the mathematical foundations and their practical application to your research.

The next chapters explore what data models are, why the relational model is particularly well-suited for scientific work, and how DataJoint builds on relational theory to support the computational workflows central to modern research.
