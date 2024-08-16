---
title: Data Integrity
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Data Integrity
Databases are not merely storage systems: they should accurately represent the current state of affairs in a dynamic organization with many participing agents, rules, and concurrent processes.
The database supporting an organization must do more than store data; it must ensure that data are structured and all transformation follow organizational rules.

```{card} Challenges to data integrity
**Data Integrity** describes the ability of a database to define, express, and enforce the rules for valid data states and transformations.
^^^

Under the stress of concurrent interactions by many agents, databases must safeguarded the data against confusion and corruption. 

Such corruption can manifest in various forms, including:

- Invalid or incomplete data entry
- Loss of data
- Unwarranted alteration of data
- Misidentification or mismatch of data
- Data duplication
- Loss of references or linkages between data sets

Each of these threats can compromise the accuracy and reliability of the data, leading to incorrect analyses, misinformed decisions, and potential operational disruptions.
```
The art of database 

# Data Integrity in Relational Databases
Relational databases provide the richest set of tools for defining and enforcing **data integrity costraints**.
The art of database design is the translation of the rules of the real-world enterprise into the language of data intergrity constraints offered by the data model.

In this course, we learn to apply several types of data integrity constraints:

1. **Domain Integrity:** ensures that all entries in a database column are within a defined set of valid values.
This can be achieved using data type restrictions, constraints, and enumerations.

2. **Completeness:** guarantees that all necessary data is present in the database.
This ensures that there are no missing values that could lead to erroneous conclusions or operations.

3. **Entity Integrity:** asserts that each entity (or row) in the database is uniquely adn reliably  matched to its real-world counterpart.
This typically requires a reliable system for identifying entities and their records.

4. **Referential Integrity:** Ensures that relationships between entities  in the database are maintained consistently.
This is often achieved using referential constraints that create a logical association  between entities.

5. **Compositional Integrity:** Guarantees that the composition of a data entity is maintained with all its constituent parts.
This may require implementing all-or-nothing (atomic) transactions that prevent partial results appearing due to errors or interrupted operations.

6. **Data consistency:** ensures a singular, valid, and current version of its data to all users, even during concurrent access and modifications.

By adhering to these principles, DataJoint ensures that the data stored within its databases remains accurate, reliable, and representative of the real-world processes it is intended to reflect.

