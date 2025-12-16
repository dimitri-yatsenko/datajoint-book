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
- Choose between natural keys, composite keys, and surrogate keys
- Know when to use auto-increment IDs vs. UUIDs
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

## Natural Keys

A **natural key** is an identifier that exists in the real world independently of the database.

**Examples:**
- Social Security Number (for US persons)
- ISBN (for books)
- VIN (for vehicles)
- Email address (for user accounts)

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

## Composite Primary Keys

When no single attribute uniquely identifies an entity, use a **composite primary key**—multiple attributes that together provide uniqueness.

**Example: U.S. Congressional Districts**

A district number alone isn't unique (every state has a "District 1"). You need both state and district:

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

**Example: Course Enrollment**

A student can enroll in many courses; a course has many students. The enrollment is uniquely identified by the combination:

```python
@schema
class Enrollment(dj.Manual):
    definition = """
    -> Student
    -> Course
    ---
    enrollment_date : date
    grade = null : decimal(3,2)
    """
```

```{admonition} When to Use Composite Keys
:class: tip

Use composite primary keys when:
- The entity is defined by a *relationship* between other entities
- Multiple attributes together form the natural identifier
- A single surrogate key would obscure the entity's meaning
```

## Surrogate Keys

A **surrogate key** is an artificial identifier created solely for the database, with no real-world meaning.

**Common surrogate key types:**
- Auto-incrementing integers (`1, 2, 3, ...`)
- UUIDs (Universally Unique Identifiers)

**Advantages:**
- Always available (don't depend on external systems)
- Compact and efficient (integers)
- Immutable (won't change like email addresses)
- No privacy concerns

**Disadvantages:**
- Meaningless to users
- Requires secondary indexes for natural lookups
- Auto-increment reveals insertion order (security concern in some contexts)

### Auto-Increment Keys

The simplest surrogate key is an auto-incrementing integer:

```python
@schema
class Experiment(dj.Manual):
    definition = """
    experiment_id : int auto_increment
    ---
    experiment_date : date
    protocol : varchar(100)
    notes : varchar(1000)
    """
```

The database automatically assigns the next available integer when you insert without specifying the key.

### UUIDs

**UUIDs** (Universally Unique Identifiers) are 128-bit identifiers designed to be globally unique without coordination:

```python
@schema
class Session(dj.Manual):
    definition = """
    session_id : uuid
    ---
    -> Subject
    session_datetime : datetime
    """
```

**When to use UUIDs instead of auto-increment:**
- Distributed systems (multiple servers inserting simultaneously)
- Data merging from multiple sources
- Security (don't reveal record count or insertion order)
- Entities created before database insertion (offline/mobile apps)

```{seealso}
For detailed UUID implementation, including UUID types (UUID1, UUID4, UUID5) and DataJoint examples, see [UUIDs](../85-special-topics/025-uuid.ipynb).
```

# Choosing the Right Primary Key Strategy

| Scenario | Recommended Key Type |
|----------|---------------------|
| Established external ID system | Natural key |
| Entity defined by relationships | Composite key |
| Simple sequential records | Auto-increment |
| Distributed/merged data | UUID |
| Privacy-sensitive context | Surrogate (not natural) |

## Decision Framework

```{mermaid}
flowchart TD
    A[New Table] --> B{Reliable external ID?}
    B -->|Yes| C[Natural Key]
    B -->|No| D{Defined by relationships?}
    D -->|Yes| E[Composite Key]
    D -->|No| F{Distributed system?}
    F -->|Yes| G[UUID]
    F -->|No| H[Auto-increment]
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

1. **Joins match on primary keys** — When you join tables with `*`, DataJoint matches on shared primary key attributes
2. **Restrictions are efficient** — Queries by primary key use indexes for fast lookups
3. **Results always have primary keys** — Every query result is itself a valid relation with a primary key

```python
# Efficient: restriction by primary key
Mouse & {'ear_tag': 'M00142'}

# The result of any query has a well-defined primary key
(Mouse * Session).primary_key  # ['ear_tag', 'session_id']
```

# Summary

Primary keys are the foundation of entity integrity in relational databases:

| Concept | Key Points |
|---------|------------|
| **Entity Integrity** | 1:1 correspondence between entities and records |
| **Three Questions** | Prevent duplicates, prevent sharing, enable matching |
| **Natural Keys** | Real-world identifiers (ISBN, SSN, email) |
| **Composite Keys** | Multiple attributes for relationship-based entities |
| **Surrogate Keys** | Database-generated (auto-increment, UUID) |

```{admonition} Design Principles
:class: tip

1. **Mirror reality** — Primary keys should reflect how entities are identified in the real world
2. **Enforce externally** — Establish identification systems outside the database
3. **Match requirements** — Choose key type based on your integrity needs
4. **Keep it simple** — Don't over-engineer; use the simplest key that works
```

```{admonition} Next Steps
:class: note

Now that you understand how primary keys ensure entity integrity, the next chapters explore:
- **[Lookup Tables](020-lookup-tables.ipynb)** — Reference data with pre-populated primary keys
- **[Foreign Keys](030-foreign-keys.ipynb)** — How primary keys enable referential integrity across tables
```
