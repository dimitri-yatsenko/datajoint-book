---
title: Database
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Definition
We begin by defining a few key concepts.
These definitions may be more precise and strict than those found by a casual search or even by other textbooks.
We will use these terms consistently the book.

We will start with the terms for *database*, *database system*, and *database management system*:


```{card} Database
A **database** is a systematically organized collection of data that evolves over time, serving as the central repository for an organization's critical information.
It supports essential operations by reflecting and enforcing the organization's rules and policies.
A database is typically accessible to various users through defined interfaces, ensuring that the data is available, consistent, and reliable. Often, it functions as the **system of record** serving as the designated  **single source of truth**, accurately representing both the current and often historical states of the organization's activities and decisions.

**Key traits**:
- structured
- centralized (data consistency) — appears as a single copy even if physically distibuted
- can evolve over time
- supports operations of an organization, reflecting and eforcing its rules and constraints (data integrity)
- support distributed, concurrent access
- support specific and precise queries through various interfaces to different users
```

Databases are vital for the smooth and organized operation of diverse entities, from hotels and airlines to universities, banks, and research projects. They capture the current state of operations, enforce essential rules, enable valid transactions, and prevent errors or illegal actions.

You might wonder: aren’t databases also used for simpler tasks, like keeping a personal recipe book or an address list? While that's true, our definition focuses on the capabilities of a full-featured database system. For simpler needs, a tool like Google Sheets might suffice. However, for complex operations—such as managing a bank or an airline—a sophisticated database system is indispensable.

In essence, databases are designed to support the critical operations of data-driven organizations where multiple users collaborate effectively.

```{card} Database Management System (DBMS)
A Database Management System (DBMS) serves as the core engine that powers a database.
It defines and enforces the structure of the data, ensuring that the organization’s rules are consistently applied. A DBMS manages data storage, manipulation, and querying, while also safeguarding the data’s structure and integrity, particularly in environments with multiple concurrent users.
```

Consider an airline's database for flight schedules and ticket bookings. The airline must adhere to several key rules:

* A seat cannot be double-booked.
* Reservations are confirmed only after all details are verified and payment is processed.

A robust DBMS enforces such rules reliably, ensuring smooth operations.

Databases are dynamic, with data continuously updated by both users and systems. Even in the face of disruptions like power outages, errors, or cyberattacks, the DBMS should ensure that the system recovers quickly and returns to a stable state. For users, the database should function seamlessly, allowing actions to be performed without interference from others working on the system simultaneously.

# Data models 

# Server-Client Architecture

