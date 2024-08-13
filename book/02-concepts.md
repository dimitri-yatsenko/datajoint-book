# Concepts  

## Database

The term "database" is often used loosely to mean any collection of data. But for this book, we’ll define it more clearly:

```{card} Database 
A **database** is a systematically organized collection of data that evolves over time, serving as the central repository for an organization's critical information.
It supports essential operations by reflecting and enforcing the organization's rules and policies.
A database is typically accessible to various users through defined interfaces, ensuring that the data is available, consistent, and reliable. Often, it functions as the system of record or single source of truth, accurately representing both the current and historical states of the organization's activities and decisions.
```

Databases are vital for the smooth and organized operation of diverse entities, from hotels and airlines to universities, banks, and research projects. They capture the current state of operations, enforce essential rules, enable valid transactions, and prevent errors or illegal actions.

You might wonder: aren’t databases also used for simpler tasks, like keeping a personal recipe book or an address list? While that's true, our definition focuses on the capabilities of a full-featured database system. For simpler needs, a tool like Google Sheets might suffice. However, for complex operations—such as managing a bank or an airline—a sophisticated database system is indispensable.

In essence, databases are designed to support the critical operations of data-driven organizations where multiple users collaborate effectively.

## Database Management System (DBMS)?

A Database Management System (DBMS) serves as the core engine that powers a database.
It defines and enforces the structure of the data, ensuring that the organization’s rules are consistently applied. A DBMS manages data storage, manipulation, and querying, while also safeguarding the data’s structure and integrity, particularly in environments with multiple concurrent users.

Consider an airline's database for flight schedules and ticket bookings. The airline must adhere to several key rules:

* A seat cannot be double-booked.
* Reservations are confirmed only after all details are verified and payment is processed.

A robust DBMS enforces such rules reliably, ensuring smooth operations.

Databases are dynamic, with data continuously updated by both users and systems. Even in the face of disruptions like power outages, errors, or cyberattacks, the DBMS should ensure that the system recovers quickly and returns to a stable state. For users, the database should function seamlessly, allowing actions to be performed without interference from others working on the system simultaneously.## Data Queries 


## Data Queries

*Data repositories* are a broad category within data management systems, primarily designed to deposit and fetch data.

```{card} Data retrieval
**Data Retrieval:** The process of fetching data from a *data repository* in its original, deposited form.
```

Databases, on the other hand, cater to a more diverse user base, each with distinct roles and interests pertaining to their organization or enterprise.  
Catering to these varied needs requires databases to facilitate *data queries*, allowing users to request specific sections of stored data, often in a format that diverges from its original storage format.

```{card} Data Query
A **data query** is a function applied to stored data; it extracts and presents a specified segment of the database's data tailored for a particular analysis.
The output often deviates from the original storage format.
Database systems are equipped with sophisticated tools for defining and executing these precise queries.
```

Consider a university as an example.
Students need functionalities to enroll in courses and view their academic records.
Instructors, on the other hand, require access to class lists and a platform to input student grades.
Meanwhile, a dean might wish to oversee the academic performance of every student within her department.
Each of these operations, though sourcing from the same foundational data, demands unique selections and combinations of the data.

In contemporary data-driven scientific research, data queries prove invaluable.
They enable researchers to select and aggregate specific data fragments essential for a given analysis or visualization, eliminating the need to retrieve the entirety of a dataset from its primary repository.

## Data Integrity 

Databases play a pivotal role in not just storing data, but also in ensuring that the stored data adheres to a particular structure and maintains its **integrity**.
This is crucial when databases are intended to mirror real-world processes and uphold specific business rules, especially when there are multiple concurrent interactions.

```{card} Data Integrity
**Data Integrity:** A database's ability to define, express, and enforce the rules for valid states of stored data
```

### Threats to Data Integrity

Databases need to be safeguarded against corruption. Such corruption can manifest in various forms, including:

- Invalid or incomplete data entry
- Loss of data
- Unwarranted alteration of data
- Misidentification or mismatch of data
- Data duplication
- Loss of references or linkages between data sets

Each of these threats can compromise the accuracy and reliability of the data, leading to incorrect analyses, misinformed decisions, and potential operational disruptions.

### Data Integrity in Databases

Relational databases excel in their ability to define valid states for entities stored in the database and in preventing deviations from valid states.

DataJoint in particular respects five primary forms of data integrity to address and counter these threats:

1. **Domain Integrity:** Ensures that all entries in a database column are within a defined set of valid values.
This can be achieved using data type restrictions, constraints, and enumerations.

2. **Completeness:** Guarantees that all necessary data is present in the database.
This ensures that there are no missing values that could lead to erroneous conclusions or operations.

3. **Entity Integrity:** Asserts that each entity (or row) in the database is uniquely adn reliably  matched to its real-world counterpart.
This typically requires a reliable system for identifying entities and their records.

4. **Referential Integrity:** Ensures that relationships between entities  in the database are maintained consistently.
This is often achieved using referential constraints that create a logical association  between entities.

5. **Compositional Integrity:** Guarantees that the composition of a data entity is maintained with all its constituent parts.
This may require implementing all-or-nothing (atomic) transactions that prevent partial results appearing due to errors or interrupted operations.

By adhering to these principles, DataJoint ensures that the data stored within its databases remains accurate, reliable, and representative of the real-world processes it is intended to reflect.

## Upholding Data Consistency in Databases

Databases are not merely storage systems; they should accurately represent an enterprise's current state.
This means that all users, irrespective of their interactions, should view and engage with the same data simultaneously.
This principle is known as **data consistency**.

```{card} Data Consistency
**Data Consistency:** A database's capability to present a singular, valid, and current version of its data to all users, even during concurrent access and modifications.
Successful read queries should reflect the database's most recent state, while successful writes should immediately influence all subsequent read actions.
```

Understanding data consistency becomes clearer when examining its breaches.
For instance, during early morning hours, I've observed my bank's website displaying the previous day's pending transactions, but the account balance doesn't reflect these changes until a couple of hours later.
This discrepancy between transaction views and account balances exemplifies data inconsistency.
Fortunately, such inconsistencies, in this case, seem to be confined to the web interface, as the system eventually reaches a consistent state.

Ensuring data consistency is straightforward in certain scenarios.
By avoiding conditions that might compromise it, consistency is preserved.
For example, if only one party generates data and the rest merely access it, the likelihood of conflicts leading to inconsistency is minimal.
Delayed queries still provide a consistent, albeit older, state.
This is typical in scientific projects, where one lab produces data while others analyze it.

Complexities arise when multiple entities, be they human or digital, access and modify data simultaneously.
Maintaining consistency amidst such concurrent interactions becomes challenging.
To achieve this, databases might temporarily limit access for some users during another's transaction or force users to resolve discrepancies before data integration.

Relational databases follow the ACID model, ensuring that operations are atomic, consistent, isolated, and durable.

```{card} ACID Model for Database Transactions
- **A**tomic
- **C**onsistent
- **I**solated
- **D**urable
```

Ensuring consistency becomes notably challenging in geographically dispersed systems with distributed data storage, especially when faced with slow or intermittent network connections.
Historically, it was believed that data systems spanning vast areas couldn't maintain consistency.
The **CAP Theorem** suggested that in such systems, there's an irreconcilable trade-off between system responsiveness (availability) and data consistency.

Traditional relational database systems, like Oracle, MySQL, and others, maintained strong consistency but weren't tailored for distributed setups. This limitation spurred the rise of **NoSQL** in the 2000s and 2010s, emphasizing responsiveness in distributed systems, albeit with weaker consistency.

However, recent advancements have bridged this gap. Modern distributed systems, like Spanner and CockroachDB, leverage data replication and consensus algorithms (e.g., Paxos, Raft) to offer high availability while maintaining strict consistency.

DataJoint adheres to the classic ACID consistency model, leveraging serializable transactions or the master-part relationship, detailed further in the "Transactions" section.

## Databases in Science

Neuroscience, a field rife with intricate data sets, often sees researchers navigating vast amounts of data while collaborating within extensive, multidisciplinary teams.
Given this complexity, the logical assumption would be that cutting-edge tools for data organization, manipulation, analysis, and querying would be central to their operations.
However, this isn't the prevailing reality.
Despite technological advancements, a significant portion of the scientific community still refrains from employing proper databases for their studies.
The predominant trend is to rely on shared data in the format of file repositories, systematically organized into folders under a uniform naming convention.
This leads to the pertinent question: Why this discernible hesitance towards databases?

```{card} Reasons for scientists' reluctance to use databases
Reasons Behind Scientists' Reluctance to Use Databases
^^^
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

