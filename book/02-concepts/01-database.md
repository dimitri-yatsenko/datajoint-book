---
title: Database
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---


We begin with defining a few key terms.
These definitions may be more precise than most popular definitions provided by a casual search or by other textbooks and are used consistently through the book.

We will start with the terms for *database*, *database system*, and *database management system*:


```{card} Database 
A **database** is a systematically organized collection of data that evolves over time, serving as the central repository for an organization's critical information.
It supports essential operations by reflecting and enforcing the organization's rules and policies.
A database is typically accessible to various users through defined interfaces, ensuring that the data is available, consistent, and reliable. Often, it functions as the **system of record** serving as the designated  **single source of truth**, accurately representing both the current and often historical states of the organization's activities and decisions.
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

# Scientific Databases

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

