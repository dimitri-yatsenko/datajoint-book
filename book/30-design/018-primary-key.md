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

Imagine what kinds of difficulties would arise if entity integrity broke down in the systems you interact with every day:

- What would happen if your university or company HR department had two different identifiers for you in their records?
- What would happen if your HR department occasionally updated your records with another person's information?
- What if the same occurred in your dentist's office?

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

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
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
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE mouse (
    ear_tag CHAR(6) NOT NULL COMMENT 'unique ear tag (e.g., M00142)',
    date_of_birth DATE NOT NULL,
    sex ENUM('M', 'F', 'U') NOT NULL,
    strain VARCHAR(50) NOT NULL,
    PRIMARY KEY (ear_tag)
);
```
````
`````

## Example: University Student Database

Consider a university registrar's office tracking students:

| Question | Answer |
|----------|--------|
| Prevent duplicates? | Each student gets a unique ID at enrollment; verification against existing records using name, date of birth, and government ID |
| Prevent sharing? | Photo ID cards issued; IDs are never reused even after graduation |
| Match entities? | Student presents ID card → look up record by student ID |

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Student(dj.Manual):
    definition = """
    student_id : char(8)   # unique student ID (e.g., 'S2024001')
    ---
    first_name : varchar(50)
    last_name : varchar(50)
    date_of_birth : date
    enrollment_date : date
    """
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE student (
    student_id CHAR(8) NOT NULL COMMENT 'unique student ID (e.g., S2024001)',
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id)
);
```
````
`````

Notice how both examples follow the same pattern: a real-world identification system (ear tags, student IDs) enables the three questions to be answered consistently.

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

```{admonition} Historical Example: The Social Security Number
:class: note dropdown

Establishing the Social Security system in the United States required reliable identification of workers by all employers to report their income across their entire careers. For this purpose, in 1936, the Federal Government established a new process to ensure that each US worker would be assigned a unique number—the Social Security Number (SSN).

The SSN would be assigned at birth or upon entering the country for employment, and no person would be allowed to have two such numbers. Establishing and enforcing such a system is not easy and takes considerable effort.

**Questions to consider:**
- Why do you think the US government did not need to assign unique identifiers to taxpayers when it began levying federal taxes in 1913?
- What abuses would become possible if a person could obtain two SSNs, or if two persons could share the same SSN?

**Learn more** about the history and uses of the SSN:
- [History of establishing the SSN](https://www.ssa.gov/history/ssn/firstcard.html)
- [How the SSN works](https://www.ssa.gov/policy/docs/ssb/v69n2/v69n2p55.html)
- [IRS timeline](https://www.irs.gov/irs-history-timeline)
```

# Types of Primary Keys

Primary keys can be classified along two independent dimensions:

1. **Usage**: Natural keys (used in the real world) vs. Surrogate keys (used only inside the database)
2. **Composition**: Simple keys (one attribute) vs. Composite keys (multiple attributes)

These dimensions are independent—a natural key can be simple or composite, and so can a surrogate key.

## Natural Keys

A **natural key** is an identifier used *outside* the database to refer to entities in the real world. The defining characteristic is that the key requires a **real-world mechanism** to establish and maintain the permanent association between entities and their identifiers.

Natural keys may originate from:
- External standards (ISBN for books, VIN for vehicles)
- Government systems (SSN, passport numbers)
- Institutional systems (student IDs, employee numbers)
- Laboratory systems (animal IDs generated by colony management software)

Even when a database or management system *generates* the identifier, if that identifier is then used in the real world to refer to the entity—printed on labels, written in lab notebooks, referenced in conversations—it functions as a natural key.

**Example: Laboratory Animal IDs**

A colony management system might generate animal IDs like `M00142`. Once that ID is printed on an ear tag and attached to a mouse, it becomes the natural key. The real-world mechanism (the ear tag) maintains the association between the physical mouse and its identifier.

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Mouse(dj.Manual):
    definition = """
    animal_id : char(6)   # colony-assigned ID (e.g., 'M00142')
    ---
    date_of_birth : date
    sex : enum('M', 'F', 'U')
    strain : varchar(50)
    """
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE mouse (
    animal_id CHAR(6) NOT NULL COMMENT 'colony-assigned ID (e.g., M00142)',
    date_of_birth DATE NOT NULL,
    sex ENUM('M', 'F', 'U') NOT NULL,
    strain VARCHAR(50) NOT NULL,
    PRIMARY KEY (animal_id)
);
```
````
`````

**Examples of composite natural keys:**
- (State, District) for U.S. Congressional Districts
- (Building, Room Number) for rooms
- (Subject, Session) when session numbers are recorded in lab notebooks

**Advantages:**
- Meaningful to users—they can discuss and search for entities by their key
- Enables matching between database records and physical entities
- Already established and enforced by external systems

**Disadvantages:**
- Requires reliable real-world identification systems
- May change (though ideally should not)
- Privacy concerns for personal identifiers
- Format inconsistencies across sources

```{admonition} Real-World Identification Standards
:class: seealso dropdown

Establishing rigorous identification systems often requires costly standardization efforts with many systems for enforcement and coordination. Examples include:

- [Vehicle Identification Number (VIN)](https://www.iso.org/standard/52200.html) — regulated by the International Organization for Standardization
- [Radio-Frequency Identification for Animals (ISO 11784/11785)](https://en.wikipedia.org/wiki/ISO_11784_and_ISO_11785) — standards for implanted microchips in animals
- [US Aircraft Registration Numbers](https://www.faa.gov/licenses_certificates/aircraft_certification/aircraft_registry/forming_nnumber) — the N-numbers seen on aircraft tails, regulated by the FAA

When a science lab establishes a data management process, the first step is often to establish a uniform system for identifying test subjects, experiments, protocols, and treatments. Standard nomenclatures exist to standardize names across institutions, and labs must be aware of them and follow them.
```

## Surrogate Keys

A **surrogate key** is an identifier used *primarily inside* the database, with minimal or no exposure to end users. Users typically don't search for entities by surrogate keys or use them in conversation.

**Examples:**
- Internal post IDs on social media (users search by content, not by ID)
- Database row identifiers that never appear in user interfaces
- System-generated UUIDs for internal tracking

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class InternalRecord(dj.Manual):
    definition = """
    record_id : int unsigned   # internal identifier, not exposed to users
    ---
    created_timestamp : timestamp
    data : longblob
    """
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE internal_record (
    record_id INT UNSIGNED NOT NULL COMMENT 'internal identifier, not exposed to users',
    created_timestamp TIMESTAMP NOT NULL,
    data LONGBLOB NOT NULL,
    PRIMARY KEY (record_id)
);
```
````
`````

**Key distinction from natural keys:** Surrogate keys don't require external identification systems because users don't need to match physical entities to records by these keys. The database maintains uniqueness, but the key itself isn't used for entity identification in the real world.

**When surrogate keys are appropriate:**
- Entities that exist only within the system (no physical counterpart)
- Privacy-sensitive contexts where natural identifiers shouldn't be stored
- Internal system records that users never reference directly

``````{admonition} No Default Values in Primary Keys
:class: important

**DataJoint prohibits default values for primary key attributes.** Every primary key value must be explicitly provided by the client when inserting a new record. This includes prohibiting the use of `auto_increment`, which is commonly used in other frameworks.

This design enforces entity integrity at the point of data entry:

- **Explicit identification required**: The client must communicate the identifying information for each new entity. This forces users to think about entity identity *before* insertion.
- **Prevents communication errors**: If a client fails to provide a key value, the insertion fails rather than silently creating a record with a generated key that may not correspond to the intended entity.
- **Prevents duplicate entities**: Running the same insertion code multiple times with the same explicit key produces an error (duplicate key) rather than creating multiple records for the same entity.

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
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

# Explicit key required - this is the DataJoint way
Session.insert1({'subject_id': 'M001', 'session': 1, 'session_date': '2024-01-15', 'notes': ''})

# Running the same insert again produces a duplicate key error, not a second record
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE session (
    subject_id VARCHAR(12) NOT NULL,
    session SMALLINT UNSIGNED NOT NULL COMMENT 'session number for this subject',
    session_date DATE NOT NULL,
    notes VARCHAR(1000) NOT NULL,
    PRIMARY KEY (subject_id, session),
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

-- Explicit key required
INSERT INTO session (subject_id, session, session_date, notes)
VALUES ('M001', 1, '2024-01-15', '');

-- Running the same insert again produces a duplicate key error, not a second record
```
````
`````

**Generating surrogate keys**: Since DataJoint requires explicit key values, how do you generate unique surrogate keys? Use client-side generation methods:

- **UUIDs and related systems**: Generate universally unique identifiers client-side before insertion. UUIDs (UUID1, UUID4, UUID5), ULIDs (sortable), and NANOIDs (compact) all provide collision-resistant unique identifiers. See [UUIDs](../85-special-topics/025-uuid.ipynb) for implementation details and guidance on choosing the right type.
- **Client-side counters**: Query the current maximum value and increment before insertion.
- **External ID services**: Use institutional or laboratory ID assignment systems that generate unique identifiers.

These approaches maintain DataJoint's requirement for explicit key specification while providing unique identifiers for surrogate keys.
``````

## Composite Keys in Hierarchical Relationships

Composite primary keys commonly arise when tables inherit foreign keys as part of their primary key. This creates hierarchical relationships where child entities are identified within the context of their parent.

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
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
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE subject (
    subject_id VARCHAR(12) NOT NULL COMMENT 'subject identifier',
    species VARCHAR(30) NOT NULL,
    PRIMARY KEY (subject_id)
);

CREATE TABLE session (
    subject_id VARCHAR(12) NOT NULL COMMENT 'subject identifier',
    session SMALLINT UNSIGNED NOT NULL COMMENT 'session number within subject',
    session_date DATE NOT NULL,
    PRIMARY KEY (subject_id, session),
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);
```
````
`````

In this example, `Session` has a composite primary key `(subject_id, session)`. Each session is uniquely identified by *which subject* and *which session number*. This pattern is covered in detail in the [Relationships](050-relationships.ipynb) chapter.

```{seealso}
For detailed coverage of composite keys through foreign key inheritance and hierarchical relationships, see [Relationships](050-relationships.ipynb).
```

# Schema Dimensions

A **schema dimension** is created when a table defines a new primary key attribute directly, rather than inheriting it through a foreign key. Tables that introduce new primary key attributes are said to create new schema dimensions.

## Identifying Schema Dimensions

Consider this hierarchy:

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
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
````
````{tab-item} SQL
:sync: sql
```sql
-- NEW DIMENSION: defines subject identity
CREATE TABLE subject (
    subject_id VARCHAR(12) NOT NULL COMMENT 'defines subject identity',
    species VARCHAR(30) NOT NULL,
    PRIMARY KEY (subject_id)
);

-- inherits subject_id dimension; NEW DIMENSION: session
CREATE TABLE session (
    subject_id VARCHAR(12) NOT NULL,
    session SMALLINT UNSIGNED NOT NULL COMMENT 'defines session identity within subject',
    session_date DATE NOT NULL,
    PRIMARY KEY (subject_id, session),
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

-- inherits subject_id and session dimensions; NEW DIMENSION: scan
CREATE TABLE scan (
    subject_id VARCHAR(12) NOT NULL,
    session SMALLINT UNSIGNED NOT NULL,
    scan SMALLINT UNSIGNED NOT NULL COMMENT 'defines scan identity within session',
    scan_time TIME NOT NULL,
    PRIMARY KEY (subject_id, session, scan),
    FOREIGN KEY (subject_id, session) REFERENCES session(subject_id, session)
);
```
````
`````

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

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
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
````
````{tab-item} SQL
:sync: sql
```sql
-- Primary key inherits all dimensions from scan; no new dimensions added
CREATE TABLE processed_scan (
    subject_id VARCHAR(12) NOT NULL,
    session SMALLINT UNSIGNED NOT NULL,
    scan SMALLINT UNSIGNED NOT NULL,
    processed_data LONGBLOB NOT NULL,
    quality_score FLOAT NOT NULL,
    PRIMARY KEY (subject_id, session, scan),
    FOREIGN KEY (subject_id, session, scan) REFERENCES scan(subject_id, session, scan)
);
```
````
`````

However, **part tables can introduce new dimensions**. When a computation produces multiple related results (e.g., detecting multiple cells in an image), the part table can add a new dimension to distinguish them:

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
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
````
````{tab-item} SQL
:sync: sql
```sql
-- Master table: inherits dimensions from scan
CREATE TABLE cell_detection (
    subject_id VARCHAR(12) NOT NULL,
    session SMALLINT UNSIGNED NOT NULL,
    scan SMALLINT UNSIGNED NOT NULL,
    detection_method VARCHAR(60) NOT NULL,
    PRIMARY KEY (subject_id, session, scan),
    FOREIGN KEY (subject_id, session, scan) REFERENCES scan(subject_id, session, scan)
);

-- Part table: adds cell_id as NEW DIMENSION
CREATE TABLE cell_detection__cell (
    subject_id VARCHAR(12) NOT NULL,
    session SMALLINT UNSIGNED NOT NULL,
    scan SMALLINT UNSIGNED NOT NULL,
    cell_id SMALLINT UNSIGNED NOT NULL COMMENT 'identifies cells within scan',
    cell_x FLOAT NOT NULL,
    cell_y FLOAT NOT NULL,
    cell_type VARCHAR(30) NOT NULL,
    PRIMARY KEY (subject_id, session, scan, cell_id),
    FOREIGN KEY (subject_id, session, scan) REFERENCES cell_detection(subject_id, session, scan)
);
```
````
`````

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

```{admonition} No Default Values in Primary Keys
:class: warning

DataJoint prohibits default values (including `auto_increment`) for primary key attributes. All key values must be explicitly provided at insertion. See [No Default Values in Primary Keys](#no-default-values-in-primary-keys) above for details and alternatives.
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

## Partial Entity Integrity

Sometimes only **one direction** of entity integrity is required:

- **Record → Entity (uniqueness)**: Each record corresponds to at most one entity, but an entity might have multiple records
- **Entity → Record (completeness)**: Each entity has a record, but records might be shared

**Example:** A social media platform might ensure that each user account is tied to exactly one person (preventing account sharing), but not prevent a person from creating multiple accounts. This is partial entity integrity—the record-to-entity direction is enforced, but not entity-to-record.

For many applications, partial integrity is sufficient. Design your primary keys to match your actual requirements—don't over-engineer for scenarios that don't matter to your domain.

## Entity Integrity Without Natural Keys

When no natural key can be established—no external identifier exists and no real-world mechanism can maintain the entity-to-record association—full entity integrity is still possible but requires a **multi-step identification process**.

Consider a scenario where anonymous survey responses must be linked to follow-up surveys from the same respondent:

1. **Generate a unique token** at the time of first response
2. **Provide the token** to the respondent (email, printed card, etc.)
3. **Require the token** for follow-up responses
4. **Trust the process** to maintain the association

The database ensures uniqueness of records through the primary key, but **matching records to real-world entities requires comprehensive process design** outside the database. The token becomes a natural key only if the external process reliably maintains the association.

```{admonition} The Database's Role
:class: note

The database can only ensure:
- **Uniqueness**: No two records share the same primary key
- **Referential integrity**: Foreign keys point to valid records

What the database *cannot* ensure:
- That a given record corresponds to the intended real-world entity
- That an entity doesn't have multiple records (unless enforced externally)

Entity integrity for real-world entities always requires some external identification process—whether it's ear tags on mice, ID cards for students, or carefully designed token systems.
```

# Primary Keys in DataJoint Queries

Primary keys have special significance in DataJoint queries:

1. **Semantic matching in joins** — When you join tables with `*`, DataJoint matches on shared schema dimensions, not just attribute names
2. **Semantic matching in restrictions** — When you restrict a table by another (`A & B`), matching is performed on shared schema dimensions
3. **Restrictions are efficient** — Queries by primary key use indexes for fast lookups
4. **Results always have primary keys** — Every query result is itself a valid relation with a well-defined primary key

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
# Efficient: restriction by primary key
Mouse & {'ear_tag': 'M00142'}

# Join matches on shared schema dimensions
Subject * Session * Scan  # All three share the subject_id dimension

# The result of any query has a well-defined primary key
(Subject * Session).primary_key  # Combines dimensions from both tables
```
````
````{tab-item} SQL
:sync: sql
```sql
-- Efficient: restriction by primary key
SELECT * FROM mouse WHERE ear_tag = 'M00142';

-- Join matches on shared schema dimensions
SELECT * FROM subject
    NATURAL JOIN session
    NATURAL JOIN scan;

-- Combined primary key from joined tables: (subject_id, session, scan)
```
````
`````

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
| **Entity Integrity** | 1:1 correspondence between entities and records; requires external processes |
| **Three Questions** | Prevent duplicates, prevent sharing, enable matching |
| **Natural Keys** | Identifiers used in the real world to refer to entities; require external association mechanisms |
| **Surrogate Keys** | Identifiers used only inside the database; not exposed to users |
| **Composite Keys** | Multiple attributes forming the key (applies to both natural and surrogate) |
| **Partial Integrity** | Sometimes only one direction of entity-record correspondence is needed |
| **Schema Dimensions** | New primary key attributes define dimensions; inherited attributes share them |
| **Semantic Matching** | Joins and restrictions match on shared schema dimensions |

```{admonition} Design Principles
:class: tip

1. **Design external processes** — The database ensures uniqueness; you must design processes to match entities to records
2. **Use natural keys when possible** — If identifiers are used in the real world, use them as primary keys
3. **Define explicitly** — Avoid auto-increment; always specify identifiers explicitly to maintain entity integrity
4. **Match requirements** — Don't over-engineer; partial entity integrity may be sufficient for your application
```

```{admonition} Next Steps
:class: note

Now that you understand how primary keys ensure entity integrity, the next chapters explore:
- **[Lookup Tables](020-lookup-tables.ipynb)** — Reference data with pre-populated primary keys
- **[Foreign Keys](030-foreign-keys.ipynb)** — How primary keys enable referential integrity across tables
```
