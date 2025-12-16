---
title: Primary Keys
authors:
  - name: Dimitri Yatsenko
date: 2025-10-31
---

# Primary Keys: Ensuring Entity Integrity

In the [Tables](015-table.ipynb) chapter, we learned that attributes above the `---` line form the **primary key**. But why does this matter? The primary key is the cornerstone of **entity integrity**—the guarantee that each real-world entity corresponds to exactly one database record, and vice versa.

```{admonition} Learning Objectives
:class: note

By the end of this chapter, you will:
- Understand entity integrity and its importance
- Apply the "three questions" framework for designing primary keys
- Choose between natural keys and surrogate keys
- Understand when keys become composite (multiple attributes)
- Design primary keys that reflect real-world identification systems
```

# What is a Primary Key?

A **primary key** is a column or combination of columns that uniquely identifies each row in a table.

```{card} Primary Key Requirements
In DataJoint, every table must have a primary key. Primary key attributes:
- Cannot be NULL
- Must be unique across all rows
- Cannot be changed after insertion (immutable)
- Are declared above the `---` line in the table definition
```

# Entity Integrity: The Core Concept

**Entity integrity** ensures a one-to-one correspondence between real-world entities and their database records:

- Each real-world entity → exactly one database record
- Each database record → exactly one real-world entity

Without entity integrity, databases become unreliable:

| Integrity Failure | Consequence |
|-------------------|-------------|
| Same entity, multiple records | Fragmented data, conflicting information |
| Multiple entities, same record | Mixed data, privacy violations |
| Cannot match entity to record | Lost data, broken workflows |

**Example:** If your university had two student records for you, your transcript might show incomplete courses, financial aid could be miscalculated, and graduation requirements might be incorrectly tracked.

# The Three Questions of Entity Integrity

When designing a primary key, you must answer three questions:

1. **How do I prevent duplicate records?** — Ensure the same entity cannot appear twice
2. **How do I prevent record sharing?** — Ensure different entities cannot share a record
3. **How do I match entities to records?** — When an entity arrives, how do I find its record?

## Example: Laboratory Mouse Database

Consider a neuroscience lab tracking mice:

| Question | Answer |
|----------|--------|
| Prevent duplicates? | Each mouse gets a unique ear tag at arrival; database rejects duplicate tags |
| Prevent sharing? | Ear tags are never reused; retired tags are archived |
| Match entities? | Read the ear tag → look up record by primary key |

```python
@schema
class Mouse(dj.Manual):
    definition = """
    ear_tag : char(6)   # unique ear tag (e.g., 'M00142')
    ---
    date_of_birth : date
    sex : enum('M', 'F', 'U')
    strain : varchar(50)
    """
```

The database enforces the first two questions automatically through the primary key constraint. The third question requires a **physical identification system**—ear tags, barcodes, or RFID chips that link physical entities to database records.

```{admonition} Entity Integrity Requires Real-World Systems
:class: important

The database can enforce uniqueness, but cannot create it. You must establish identification systems *outside* the database:
- Laboratory animals: ear tags, microchips
- Students: ID cards, student numbers
- Products: SKUs, barcodes
- Citizens: government IDs, SSNs

The primary key in the database mirrors and enforces the real-world identification system.
```

# Types of Primary Keys

Primary keys can be classified along two independent dimensions:

1. **Origin**: Natural keys (from the real world) vs. Surrogate keys (artificially created)
2. **Composition**: Simple keys (one attribute) vs. Composite keys (multiple attributes)

These dimensions are independent—a natural key can be simple or composite, and so can a surrogate key.

## Natural Keys

A **natural key** is an identifier that exists in the real world independently of the database.

**Examples of simple natural keys:**
- ISBN (for books)
- VIN (for vehicles)
- Social Security Number (for US persons)

**Examples of composite natural keys:**
- (State, District) for U.S. Congressional Districts
- (Country, Postal Code) for geographic regions
- (Building, Room Number) for rooms

**Advantages:**
- Meaningful to users
- Already established and enforced externally
- No need to generate new identifiers

**Disadvantages:**
- May change (email addresses, phone numbers)
- May not exist for all entities
- Privacy concerns (SSN)
- Format inconsistencies

```python
@schema
class Book(dj.Manual):
    definition = """
    isbn : char(13)   # International Standard Book Number
    ---
    title : varchar(255)
    author : varchar(100)
    publication_year : year
    """
```

**Example: Composite Natural Key**

A district number alone isn't unique (every state has a "District 1"). The natural identifier requires both state and district:

```python
@schema
class CongressionalDistrict(dj.Manual):
    definition = """
    state : char(2)              # two-letter state code
    district : tinyint unsigned  # district number within state
    ---
    representative : varchar(100)
    party : enum('D', 'R', 'I')
    """
```

## Surrogate Keys

A **surrogate key** is an artificial identifier created solely for the database, with no inherent real-world meaning.

**Advantages:**
- Always available (don't depend on external systems)
- Compact and efficient (integers)
- Immutable (won't change like email addresses)
- No privacy concerns

**Disadvantages:**
- Meaningless to users without additional context
- Requires secondary indexes for natural lookups

```{admonition} Explicitly Defined Surrogate Keys
:class: important

In DataJoint, we prefer explicitly defined surrogate keys over auto-generated ones. When you create an entity like a "session," you should explicitly specify its identifier:

```python
@schema
class Session(dj.Manual):
    definition = """
    -> Subject
    session : smallint unsigned  # session number for this subject
    ---
    session_date : date
    notes : varchar(1000)
    """
```

This approach:
- Prevents accidental duplicate entries when code is run multiple times
- Makes the identifier meaningful (e.g., "session 1", "session 2" for each subject)
- Maintains entity integrity by requiring users to think about what they're inserting

Avoid using `auto_increment` for identifiers, as it can lead to entity integrity violations when users accidentally insert duplicate records representing the same real-world entity.
```

## Composite Keys in Hierarchical Relationships

Composite primary keys commonly arise when tables inherit foreign keys as part of their primary key. This creates hierarchical relationships where child entities are identified within the context of their parent.

```python
@schema
class Subject(dj.Manual):
    definition = """
    subject_id : varchar(12)   # subject identifier
    ---
    species : varchar(30)
    """

@schema
class Session(dj.Manual):
    definition = """
    -> Subject
    session : smallint unsigned  # session number within subject
    ---
    session_date : date
    """
```

In this example, `Session` has a composite primary key `(subject_id, session)`. Each session is uniquely identified by *which subject* and *which session number*. This pattern is covered in detail in the [Relationships](050-relationships.ipynb) chapter.

```{seealso}
For detailed coverage of composite keys through foreign key inheritance and hierarchical relationships, see [Relationships](050-relationships.ipynb).
```

# Choosing the Right Primary Key Strategy

| Scenario | Recommended Approach |
|----------|---------------------|
| Established external ID system exists | Use the natural key |
| Entity naturally identified by multiple attributes | Use composite natural key |
| Entity identified within parent context | Inherit foreign key + add local identifier |
| No natural identifier exists | Create explicit surrogate key |
| Privacy-sensitive context | Surrogate key (not natural) |

## Decision Framework

```{mermaid}
flowchart TD
    A[New Table] --> B{Reliable external ID?}
    B -->|Yes, single attribute| C[Simple Natural Key]
    B -->|Yes, multiple attributes| D[Composite Natural Key]
    B -->|No| E{Part of hierarchy?}
    E -->|Yes| F[FK + Local Identifier]
    E -->|No| G[Explicit Surrogate Key]
```

```{admonition} Avoid Auto-Increment
:class: warning

While many databases offer auto-increment for generating keys, DataJoint workflows avoid this pattern. Auto-increment can lead to entity integrity violations when users accidentally run insertion code multiple times, creating duplicate records for the same real-world entity. Always explicitly define your identifiers.
```

# Entity Integrity Varies by Context

Different applications require different levels of entity integrity:

| Level | Example | Enforcement |
|-------|---------|-------------|
| **Strict** | Airlines, banks | Government ID verification, biometrics |
| **Moderate** | Universities, hospitals | Photo ID, documentation |
| **Flexible** | Gyms, loyalty programs | Basic verification, some sharing tolerated |
| **Minimal** | Social media | Email verification only |

**Example: Strict vs. Flexible**

An airline *must* know exactly who boards each flight (strict entity integrity). A grocery store loyalty program may not care if family members share a card (flexible entity integrity).

Design your primary keys to match your application's integrity requirements—don't over-engineer for scenarios that don't matter to your domain.

# Primary Keys in DataJoint Queries

Primary keys have special significance in DataJoint queries:

1. **Semantic matching in joins** — When you join tables with `*`, DataJoint uses *semantic matching*: attributes are matched when they share both the same name and trace to the same original definition through foreign key dependencies
2. **Restrictions are efficient** — Queries by primary key use indexes for fast lookups
3. **Results always have primary keys** — Every query result is itself a valid relation with a primary key

```python
# Efficient: restriction by primary key
Mouse & {'ear_tag': 'M00142'}

# The result of any query has a well-defined primary key
(Mouse * Session).primary_key  # Combines keys based on semantic matching
```

```{admonition} Semantic Matching
:class: note

DataJoint's join differs from SQL's `NATURAL JOIN`. Two attributes are matched only when:
1. They have the **same name** in both tables
2. They trace to the **same original definition** through foreign key chains

This prevents accidental joins on attributes that happen to share a name but have different meanings. For details, see the [Join](../50-queries/040-join.ipynb) chapter.
```

# Summary

Primary keys are the foundation of entity integrity in relational databases:

| Concept | Key Points |
|---------|------------|
| **Entity Integrity** | 1:1 correspondence between entities and records |
| **Three Questions** | Prevent duplicates, prevent sharing, enable matching |
| **Natural Keys** | Real-world identifiers (ISBN, SSN); can be simple or composite |
| **Surrogate Keys** | Explicitly defined identifiers when no natural key exists |
| **Composite Keys** | Multiple attributes forming the key (applies to both natural and surrogate) |

```{admonition} Design Principles
:class: tip

1. **Mirror reality** — Primary keys should reflect how entities are identified in the real world
2. **Enforce externally** — Establish identification systems outside the database
3. **Define explicitly** — Avoid auto-increment; always specify identifiers explicitly to maintain entity integrity
4. **Keep it simple** — Don't over-engineer; use the simplest key that works
```

```{admonition} Next Steps
:class: note

Now that you understand how primary keys ensure entity integrity, the next chapters explore:
- **[Lookup Tables](020-lookup-tables.ipynb)** — Reference data with pre-populated primary keys
- **[Foreign Keys](030-foreign-keys.ipynb)** — How primary keys enable referential integrity across tables
```
