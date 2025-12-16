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
- Recognize schema dimensions and their role in semantic matching
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

# Schema Dimensions

A **schema dimension** is created when a table defines a new primary key attribute directly, rather than inheriting it through a foreign key. Tables that introduce new primary key attributes are said to create new schema dimensions.

## Identifying Schema Dimensions

Consider this hierarchy:

```python
@schema
class Subject(dj.Manual):
    definition = """
    subject_id : varchar(12)   # NEW DIMENSION: defines subject identity
    ---
    species : varchar(30)
    """

@schema
class Session(dj.Manual):
    definition = """
    -> Subject                         # inherits subject_id dimension
    session : smallint unsigned        # NEW DIMENSION: defines session identity within subject
    ---
    session_date : date
    """

@schema
class Scan(dj.Manual):
    definition = """
    -> Session                         # inherits subject_id and session dimensions
    scan : smallint unsigned           # NEW DIMENSION: defines scan identity within session
    ---
    scan_time : time
    """
```

In this example:
- `Subject` creates the `subject_id` dimension
- `Session` inherits `subject_id` and creates the `session` dimension
- `Scan` inherits both `subject_id` and `session`, and creates the `scan` dimension

## Diagram Notation

In DataJoint diagrams, tables that introduce new schema dimensions have their names **underlined**. Tables that only inherit their primary key through foreign keys (without adding new attributes) are not underlined—they represent the same identity as their parent.

```{admonition} Underlined Names in Diagrams
:class: tip

When viewing a schema diagram:
- **Underlined table names** indicate tables that introduce new dimensions
- **Non-underlined table names** indicate tables whose identity is fully determined by their parent(s)

This visual distinction helps you quickly identify which tables define new entity types versus which extend existing ones.
```

## Why Schema Dimensions Matter

Schema dimensions are fundamental to how DataJoint performs **semantic matching** in queries. When you join tables or use one table to restrict another, DataJoint matches rows based on shared schema dimensions—not just attributes with the same name.

Two attributes match semantically when they:
1. Have the **same name**
2. Trace back to the **same original dimension** through foreign key chains

This is why `subject_id` in `Subject`, `Session`, and `Scan` all refer to the same dimension and will be matched in joins, while an unrelated `subject_id` in a completely separate table hierarchy would not match.

## Schema Dimensions and Auto-Populated Tables

Auto-populated tables (`dj.Computed` and `dj.Imported`) have a special constraint: **they cannot introduce new schema dimensions directly**. Their primary key must be fully determined by their upstream dependencies through foreign keys.

This constraint ensures that auto-populated tables compute results for entities that are already defined elsewhere in the pipeline. The `make` method receives a key from the key source (derived from parent tables), and the computation produces results for that specific key.

```python
@schema
class ProcessedScan(dj.Computed):
    definition = """
    -> Scan                    # inherits subject_id, session, scan dimensions
    ---                        # NO new primary key attributes allowed here
    processed_data : longblob
    quality_score : float
    """
```

However, **part tables can introduce new dimensions**. When a computation produces multiple related results (e.g., detecting multiple cells in an image), the part table can add a new dimension to distinguish them:

```python
@schema
class CellDetection(dj.Computed):
    definition = """
    -> Scan                    # master table inherits dimensions
    ---
    detection_method : varchar(60)
    """

    class Cell(dj.Part):
        definition = """
        -> master
        cell_id : smallint unsigned   # NEW DIMENSION: identifies cells within scan
        ---
        cell_x : float
        cell_y : float
        cell_type : varchar(30)
        """
```

In this example, `CellDetection` (the master) cannot introduce new dimensions, but `CellDetection.Cell` (the part table) introduces the `cell_id` dimension to identify individual detected cells.

```{admonition} Why This Constraint Exists
:class: note

This design ensures that:
- Computations are reproducible and traceable to their inputs
- The key source for auto-populated tables is well-defined
- New entity types are introduced through manual or lookup tables, not through automated computation
- Part tables handle the case where a single computation produces multiple output entities
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

1. **Semantic matching in joins** — When you join tables with `*`, DataJoint matches on shared schema dimensions, not just attribute names
2. **Semantic matching in restrictions** — When you restrict a table by another (`A & B`), matching is performed on shared schema dimensions
3. **Restrictions are efficient** — Queries by primary key use indexes for fast lookups
4. **Results always have primary keys** — Every query result is itself a valid relation with a well-defined primary key

```python
# Efficient: restriction by primary key
Mouse & {'ear_tag': 'M00142'}

# Join matches on shared schema dimensions
Subject * Session * Scan  # All three share the subject_id dimension

# The result of any query has a well-defined primary key
(Subject * Session).primary_key  # Combines dimensions from both tables
```

```{admonition} Semantic Matching via Schema Dimensions
:class: note

DataJoint's join and restriction operations differ from SQL's `NATURAL JOIN`. Two attributes are matched only when they belong to the **same schema dimension**:

1. They have the **same name** in both tables
2. They trace back to the **same original definition** through foreign key chains

This prevents accidental matches on attributes that happen to share a name but originate from different dimensions. For example, two tables might both have a `name` attribute, but if one refers to a person's name and the other to a course name, they represent different dimensions and will not be matched.

For details, see the [Join](../50-queries/040-join.ipynb) chapter.
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
| **Schema Dimensions** | New primary key attributes define dimensions; inherited attributes share them |
| **Semantic Matching** | Joins and restrictions match on shared schema dimensions |

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
