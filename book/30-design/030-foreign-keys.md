---
title: Foreign Keys
---

# Foreign Keys: Ensuring Referential Integrity

While **entity integrity** ensures that each record uniquely represents a real-world entity, **referential integrity** ensures that *relationships between* entities are valid and consistent.
A foreign key guarantees that you won't have an employee assigned to a non-existent department or a task associated with a deleted project.

**Referential integrity is impossible without entity integrity.** You must first have a reliable way to identify unique entities before you can define relationships between them.

```{admonition} Learning Objectives
:class: note

By the end of this chapter, you will:
- Understand referential integrity and how foreign keys enforce it
- Learn the five effects of foreign keys on database operations
- Master foreign key modifier syntax: `nullable` and `unique`
- Understand when modifiers can and cannot be applied
- Design tables that properly express relationship constraints
```

# What is a Foreign Key?

A **foreign key** is a column (or set of columns) in a child table that references the primary key of a parent table.
This link establishes a relationship between entities and enforces referential integrity by ensuring that references point to valid records.

```{card} Foreign Key Characteristics
In DataJoint, foreign keys:
- Always reference the **primary key** of the parent table
- Automatically inherit the parent's primary key attributes (name and datatype)
- Create both a **referential constraint** and a **workflow dependency**
- Can be placed in the primary key (above `---`) or as secondary attributes (below `---`)
```

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Title(dj.Lookup):
    definition = """
    title_code : char(8)       # job title code
    ---
    full_title : varchar(120)  # full title description
    """

@schema
class Employee(dj.Manual):
    definition = """
    person_id : int            # employee identifier
    ---
    first_name : varchar(30)
    last_name : varchar(30)
    -> Title                   # foreign key to Title
    """
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE title (
    title_code CHAR(8) NOT NULL COMMENT 'job title code',
    full_title VARCHAR(120) NOT NULL COMMENT 'full title description',
    PRIMARY KEY (title_code)
);

CREATE TABLE employee (
    person_id INT NOT NULL COMMENT 'employee identifier',
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    title_code CHAR(8) NOT NULL,
    PRIMARY KEY (person_id),
    FOREIGN KEY (title_code) REFERENCES title(title_code)
);
```
````
`````

The arrow `-> Title` in DataJoint creates a foreign key from `Employee` (child) to `Title` (parent).
Notice how the SQL version requires explicit repetition of the column name and datatype—DataJoint handles this automatically.

# Referential Integrity + Workflow Dependencies

In DataJoint, foreign keys serve a **dual role** that extends beyond traditional relational databases:

1. **Referential integrity** (like traditional databases): Ensures that child records reference existing parent records
2. **Workflow dependencies** (DataJoint's addition): Prescribes the order of operations—the parent must exist before the child can reference it

This transforms the schema into a **directed acyclic graph (DAG)** representing valid workflow execution sequences.
The foreign key `-> Title` in `Employee` not only ensures that each employee has a valid title, but also establishes that titles must be created before employees can be assigned to them.

```{seealso}
For more on how DataJoint extends foreign keys with workflow semantics, see [Relational Workflows](../20-concepts/05-workflows.md).
```

```{admonition} A Logical Constraint, Not a Physical Pointer
:class: tip

A revolutionary concept in the relational model is that a foreign key is **not a physical pointer** to a location on disk.
Instead, it is a **logical constraint** enforced at runtime.

When you insert a row into a child table, the database doesn't follow a pre-existing "link."
It performs a search on the parent table to verify that a matching primary key exists.
If found, the insert succeeds; otherwise, it is rejected.

This differs fundamentally from other data models like HDF5, where data is often linked by direct pointers or paths.
The logical nature of foreign keys gives relational databases their flexibility and integrity.
```

# The Five Effects of a Foreign Key

Foreign keys impose important constraints on data operations.
Understanding these effects is essential for designing schemas that maintain integrity.

## Effect 1: Schema Embedding

When a foreign key is declared, the primary key columns from the parent become embedded in the child table with **matching names and datatypes**.

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Employee(dj.Manual):
    definition = """
    person_id : int
    ---
    first_name : varchar(30)
    last_name : varchar(30)
    -> Title                   # embeds title_code with type char(8)
    """

# The Employee table now contains:
# person_id (int) - primary key
# first_name (varchar(30))
# last_name (varchar(30))
# title_code (char(8)) - inherited from Title
```
````
````{tab-item} SQL
:sync: sql
```sql
-- The foreign key requires explicit column definition
CREATE TABLE employee (
    person_id INT NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    title_code CHAR(8) NOT NULL,  -- must match Title's primary key type
    PRIMARY KEY (person_id),
    FOREIGN KEY (title_code) REFERENCES title(title_code)
);
```
````
`````

## Effect 2: Insert Restriction on Child

A foreign key ensures that no "orphaned" records are created.
An insert into the child table succeeds only if the foreign key value corresponds to an existing primary key in the parent.

**The rule**: Inserts are restricted in the **child**, not the parent.
You can always add new job titles, but you cannot add an employee with a `title_code` that doesn't exist in `Title`.

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
# This works - 'Web-Dev1' exists in Title
Employee.insert1((1, 'Mark', 'Sommers', 'Web-Dev1'))

# This fails - 'BizDev' does not exist in Title
Employee.insert1((2, 'Brenda', 'Means', 'BizDev'))
# IntegrityError: Cannot add or update a child row:
#   a foreign key constraint fails
```
````
````{tab-item} SQL
:sync: sql
```sql
-- This works - 'Web-Dev1' exists in title
INSERT INTO employee (person_id, first_name, last_name, title_code)
VALUES (1, 'Mark', 'Sommers', 'Web-Dev1');

-- This fails - 'BizDev' does not exist in title
INSERT INTO employee (person_id, first_name, last_name, title_code)
VALUES (2, 'Brenda', 'Means', 'BizDev');
-- ERROR: Cannot add or update a child row:
--   a foreign key constraint fails
```
````
`````

**In DataJoint, this enforces workflow order**: The parent entity must be created before the child entity can reference it.

## Effect 3: Delete Restriction on Parent

To prevent broken relationships, a parent record cannot be deleted if any child records still reference it.

**The rule**: Deletes are restricted in the **parent**, not the child.
You can always delete an employee, but you cannot delete a title if employees still have that title.

In standard SQL, this would fail with a constraint error.
DataJoint implements **cascading delete**—it warns you that deleting the parent will also delete all dependent child records, which can cascade through many levels of a deep hierarchy.

**In DataJoint, this maintains workflow consistency**: When you delete a parent entity, all downstream workflow artifacts that depend on it are also deleted.
This ensures computational validity—if the inputs are gone, any results based on those inputs must be removed.

## Effect 4: Update Restriction on Keys

Updates to a parent's primary key or a child's foreign key are restricted to maintain referential integrity.

DataJoint does not support updating primary key values, as this risks breaking referential integrity in complex scientific workflows.
The preferred pattern is to **delete the old record and insert a new one** with the updated information.

**In DataJoint, this preserves workflow immutability**: Workflow artifacts are treated as immutable once created.
If upstream data changes, the workflow must be re-executed from that point forward.

## Effect 5: Automatic Index Creation

A secondary index is automatically created on the foreign key columns in the child table.
This index accelerates:

1. **Delete operations**: Fast lookup of child records when checking if parent can be deleted
2. **Join operations**: Efficient matching of foreign keys to primary keys
3. **Constraint validation**: Quick verification during inserts

You don't need to create this index manually—the database system handles it automatically when the foreign key is declared.

# Foreign Key Modifiers

DataJoint provides two modifiers that alter foreign key behavior: `nullable` and `unique`.
These modifiers control whether the relationship is optional and whether it enforces uniqueness.

## The `nullable` Modifier

By default, foreign key attributes are **required** (NOT NULL)—every child record must reference a valid parent.
The `nullable` modifier makes the relationship **optional**, allowing child records to exist without a parent reference.

```{card} Nullable Foreign Key Syntax
`-> [nullable] ParentTable`

This creates foreign key attributes that accept NULL values, indicating "no associated parent."
```

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Account(dj.Manual):
    definition = """
    account_id : int unsigned     # account identifier
    ---
    -> [nullable] Customer        # optional owner - can be NULL
    open_date : date
    balance : decimal(10,2)
    """

# Accounts can exist without an owner
Account.insert1({
    'account_id': 1001,
    'customer_id': None,          # NULL - no owner assigned
    'open_date': '2024-01-15',
    'balance': 0.00
})
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE account (
    account_id INT UNSIGNED NOT NULL COMMENT 'account identifier',
    customer_id INT UNSIGNED NULL,  -- allows NULL values
    open_date DATE NOT NULL,
    balance DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (account_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Accounts can exist without an owner
INSERT INTO account (account_id, customer_id, open_date, balance)
VALUES (1001, NULL, '2024-01-15', 0.00);
```
````
`````

**Use cases for nullable foreign keys:**
- Accounts that may not yet have an assigned owner
- Products that may not have a designated supplier
- Tasks that have not yet been assigned to an employee

````{admonition} Primary Key Foreign Keys Cannot Be Nullable
:class: warning

Foreign keys that are part of the **primary key** (declared above the `---` line) **cannot be made nullable**.
Primary key attributes must always have values—they identify the entity.

```python
# INVALID - primary key foreign keys cannot be nullable
@schema
class Session(dj.Manual):
    definition = """
    -> [nullable] Subject     # ERROR: primary key cannot be NULL
    session : int
    ---
    session_date : date
    """
```

Only foreign keys in **secondary attributes** (below the `---` line) can be nullable.
````

## The `unique` Modifier

By default, a secondary foreign key allows **many-to-one** relationships—multiple child records can reference the same parent.
The `unique` modifier restricts this to **one-to-one**—at most one child can reference each parent.

```{card} Unique Foreign Key Syntax
`-> [unique] ParentTable`

This adds a unique constraint on the foreign key attributes, ensuring each parent is referenced by at most one child.
```

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Employee(dj.Manual):
    definition = """
    employee_id : int unsigned
    ---
    full_name : varchar(60)
    """

@schema
class ParkingSpot(dj.Manual):
    definition = """
    spot_number : int unsigned    # parking spot identifier
    ---
    -> [unique] Employee          # at most one spot per employee
    location : varchar(30)
    """

# Each employee can have at most one parking spot
ParkingSpot.insert1({
    'spot_number': 101,
    'employee_id': 1,
    'location': 'Garage A'
})

# This would fail - employee 1 already has a spot
ParkingSpot.insert1({
    'spot_number': 102,
    'employee_id': 1,            # ERROR: duplicate entry
    'location': 'Garage B'
})
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE employee (
    employee_id INT UNSIGNED NOT NULL,
    full_name VARCHAR(60) NOT NULL,
    PRIMARY KEY (employee_id)
);

CREATE TABLE parking_spot (
    spot_number INT UNSIGNED NOT NULL COMMENT 'parking spot identifier',
    employee_id INT UNSIGNED NOT NULL,
    location VARCHAR(30) NOT NULL,
    PRIMARY KEY (spot_number),
    UNIQUE KEY (employee_id),    -- unique constraint on foreign key
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);
```
````
`````

**Use cases for unique foreign keys:**
- Parking spots assigned to employees (one spot per employee)
- Primary contact person for a department
- Default billing address for a customer

## Combining Modifiers

The `nullable` and `unique` modifiers can be combined to create an **optional one-to-one** relationship:

```{card} Combined Modifier Syntax
`-> [nullable, unique] ParentTable` or `-> [unique, nullable] ParentTable`

This creates an optional relationship where each parent can be referenced by at most one child (or none).
```

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Account(dj.Manual):
    definition = """
    account_id : int unsigned
    ---
    -> [nullable, unique] Customer   # optional, one account per customer max
    open_date : date
    """

# Account without owner
Account.insert1({'account_id': 1, 'customer_id': None, 'open_date': '2024-01-01'})

# Account with owner - customer 100
Account.insert1({'account_id': 2, 'customer_id': 100, 'open_date': '2024-01-02'})

# This fails - customer 100 already has an account
Account.insert1({'account_id': 3, 'customer_id': 100, 'open_date': '2024-01-03'})
# IntegrityError: Duplicate entry '100' for key 'customer_id'
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE account (
    account_id INT UNSIGNED NOT NULL,
    customer_id INT UNSIGNED NULL,      -- nullable
    open_date DATE NOT NULL,
    PRIMARY KEY (account_id),
    UNIQUE KEY (customer_id),           -- unique (NULLs don't violate uniqueness)
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
```
````
`````

```{admonition} NULL Values and Unique Constraints
:class: note

In SQL, NULL values are **not considered equal** for uniqueness purposes.
Multiple rows can have NULL in a column with a unique constraint—only non-NULL values must be unique.

This is why `[nullable, unique]` works as expected: many accounts can have no owner (NULL), but each customer can own at most one account.
```

# Modifier Summary

| Modifier | Placement | Effect | Use Case |
|----------|-----------|--------|----------|
| (none) | Secondary | Required many-to-one | Default: every child references exactly one parent |
| `nullable` | Secondary only | Optional many-to-one | Child may exist without parent reference |
| `unique` | Secondary | Required one-to-one | Each parent referenced by at most one child |
| `nullable, unique` | Secondary only | Optional one-to-one | Optional relationship, but exclusive if present |

```{admonition} Modifiers Apply Only to Secondary Foreign Keys
:class: important

Foreign keys in the **primary key** (above `---`):
- Cannot use `nullable` (primary keys cannot be NULL)
- The `unique` modifier is redundant (primary keys are already unique)

Modifiers are meaningful only for foreign keys declared as **secondary attributes** (below `---`).
```

# Foreign Key Placement

Where you place a foreign key—above or below the `---` line—fundamentally changes its meaning:

| Placement | Primary Key? | Relationship | Line Style in Diagram |
|-----------|--------------|--------------|----------------------|
| Above `---` (only FK) | Yes, entire PK | One-to-one (extension) | Thick solid |
| Above `---` (with other attrs) | Yes, part of PK | One-to-many (containment) | Thin solid |
| Below `---` | No | One-to-many (reference) | Dashed |
| Below `---` + `unique` | No | One-to-one (reference) | Dashed |

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
# Foreign key IS the entire primary key (thick solid line)
@schema
class CustomerPreferences(dj.Manual):
    definition = """
    -> Customer              # customer_id IS the primary key
    ---
    theme : varchar(20)
    """

# Foreign key is PART OF primary key (thin solid line)
@schema
class CustomerAccount(dj.Manual):
    definition = """
    -> Customer              # customer_id is part of primary key
    account_num : int        # together they form the primary key
    ---
    balance : decimal(10,2)
    """

# Foreign key is a secondary attribute (dashed line)
@schema
class Order(dj.Manual):
    definition = """
    order_id : int           # order_id is the primary key
    ---
    -> Customer              # customer_id is a secondary attribute
    order_date : date
    """
```
````
````{tab-item} SQL
:sync: sql
```sql
-- Foreign key IS the entire primary key
CREATE TABLE customer_preferences (
    customer_id INT NOT NULL,
    theme VARCHAR(20) NOT NULL,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Foreign key is PART OF primary key
CREATE TABLE customer_account (
    customer_id INT NOT NULL,
    account_num INT NOT NULL,
    balance DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (customer_id, account_num),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Foreign key is a secondary attribute
CREATE TABLE order_ (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
```
````
`````

```{seealso}
For detailed coverage of relationship patterns created by different foreign key placements, see [Relationships](050-relationships.ipynb).
For visual representation of these relationships, see [Diagramming](060-diagrams.ipynb).
```

# Association Tables: Many-to-Many Relationships

A single foreign key creates a one-to-many (or one-to-one) relationship.
To model **many-to-many** relationships, use an **association table** with foreign keys to both entities:

`````{tab-set}
````{tab-item} DataJoint
:sync: datajoint
```python
@schema
class Person(dj.Manual):
    definition = """
    person_id : int
    ---
    name : varchar(60)
    """

@schema
class Language(dj.Lookup):
    definition = """
    lang_code : char(4)
    ---
    language_name : varchar(30)
    """

@schema
class Fluency(dj.Manual):
    definition = """
    -> Person                # part of primary key
    -> Language              # part of primary key
    ---
    fluency_level : enum('beginner', 'intermediate', 'fluent')
    """
```
````
````{tab-item} SQL
:sync: sql
```sql
CREATE TABLE person (
    person_id INT NOT NULL,
    name VARCHAR(60) NOT NULL,
    PRIMARY KEY (person_id)
);

CREATE TABLE language (
    lang_code CHAR(4) NOT NULL,
    language_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (lang_code)
);

CREATE TABLE fluency (
    person_id INT NOT NULL,
    lang_code CHAR(4) NOT NULL,
    fluency_level ENUM('beginner', 'intermediate', 'fluent') NOT NULL,
    PRIMARY KEY (person_id, lang_code),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (lang_code) REFERENCES language(lang_code)
);
```
````
`````

The `Fluency` table has a **composite primary key** combining both foreign keys.
This allows:
- Each person to speak multiple languages
- Each language to be spoken by multiple people
- Each person-language combination to appear at most once

```{seealso}
For more association table patterns and variations, see [Relationships](050-relationships.ipynb).
```

# Summary

Foreign keys ensure referential integrity by linking child tables to parent tables.
In DataJoint, they also establish **workflow dependencies** that prescribe the order of operations.

| Effect | Description |
|--------|-------------|
| **Schema Embedding** | Parent's primary key attributes are added to child table |
| **Insert Restriction** | Child inserts require valid parent reference |
| **Delete Restriction** | Parent deletes cascade to remove dependent children |
| **Update Restriction** | Primary/foreign key values cannot be updated in place |
| **Index Creation** | Automatic index on foreign key for performance |

| Modifier | Syntax | Effect | Restriction |
|----------|--------|--------|-------------|
| `nullable` | `-> [nullable] Parent` | Allows NULL (no parent) | Secondary attributes only |
| `unique` | `-> [unique] Parent` | One-to-one relationship | Secondary attributes only |
| Both | `-> [nullable, unique] Parent` | Optional one-to-one | Secondary attributes only |

```{admonition} Key Principles
:class: tip

1. **Primary key foreign keys cannot be nullable** — They define entity identity
2. **Modifiers apply only to secondary foreign keys** — Foreign keys in the primary key have fixed behavior
3. **Diagrams don't show modifiers** — Check table definitions for nullable and unique constraints
4. **Foreign keys transform schemas into DAGs** — They prescribe workflow execution order
```

```{admonition} Next Steps
:class: note

Now that you understand foreign keys and their modifiers:
- **[Relationships](050-relationships.ipynb)** — Explore relationship patterns: one-to-one, one-to-many, many-to-many
- **[Diagramming](060-diagrams.ipynb)** — Learn to read and interpret schema diagrams
```
