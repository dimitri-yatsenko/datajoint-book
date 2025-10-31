---
title: Data Integrity
date: 2025-10-31
authors:
  - name: Dimitri Yatsenko
---

# Why Data Integrity Matters

Imagine a neuroscience lab where recording sessions are tracked in a database. Without proper safeguards, you might encounter:
- An experiment record pointing to a non-existent mouse
- Two different experiments claiming the same unique identifier
- A recording session missing its timestamp
- Concurrent processes writing conflicting data simultaneously

Each scenario represents a failure of **data integrity** — the database's ability to maintain accurate, consistent, and reliable data that faithfully represents reality.

```{card} The Challenge
**Data Integrity** is the ability of a database to define, express, and enforce rules for valid data states and transformations.
^^^

Scientific databases face unique challenges:
- **Multiple users** entering data concurrently
- **Long-running experiments** generating data over months or years
- **Complex relationships** between experimental entities
- **Evolving protocols** requiring schema updates
- **Collaborative teams** with different data entry practices

Without robust integrity mechanisms, these challenges lead to:
- Invalid or incomplete data entry
- Loss of data during updates
- Unwarranted alteration of historical records
- Misidentification or mismatch of experimental subjects
- Data duplication across tables
- Broken references between related datasets
```

# From Real-World Rules to Database Constraints

The core challenge of database design is translating organizational rules into enforceable constraints. Consider a simple example:

**Lab Rule:** "Each mouse must have a unique ID, and every recording session must reference a valid mouse."

**Database Implementation:**
- Mouse table with **primary key** constraint (entity integrity)
- RecordingSession table with **foreign key** to Mouse (referential integrity)
- Mouse ID **cannot be null** (completeness)
- Recording timestamp **must be datetime type** (domain integrity)

Relational databases excel at expressing and enforcing such rules through **integrity constraints** — declarative rules that the database automatically enforces.

# Types of Data Integrity Constraints

This section introduces six fundamental types of integrity constraints. Each will be covered in detail in subsequent chapters, with DataJoint implementation examples.

## 1. Domain Integrity
**Ensures values are within valid ranges and types.**

Domain integrity restricts attribute values to predefined valid sets using:
- **Data types**: `int`, `float`, `varchar`, `date`, `enum`
- **Range constraints**: `unsigned`, `decimal(10,2)`
- **Pattern matching**: Regular expressions for formatted strings

**Example:** Recording temperature must be between 20-25°C.

**Covered in:** [Tables](015-table.ipynb) — Data type specification

---

## 2. Completeness
**Guarantees required data is present.**

Completeness prevents missing values that could invalidate analyses:
- **Required fields** cannot be left empty (non-nullable)
- **Default values** provide sensible fallbacks
- **NOT NULL constraints** enforce data presence

**Example:** Every experiment must have a start date.

**Covered in:** 
- [Tables](015-table.ipynb) — Required vs. optional attributes
- [Default Values](020-default-values.ipynb) — Handling optional data

---

## 3. Entity Integrity
**Each entity has a unique, reliable identifier.**

Entity integrity ensures one-to-one mapping between database records and real-world entities:
- **Primary keys** uniquely identify each row
- **Uniqueness constraints** prevent duplicates
- **Identification strategies** (auto-increment, UUIDs, natural keys)

**Example:** Each mouse has exactly one unique ID.

**Covered in:**
- [Primary Keys](025-primary-key.md) — Identification strategies
- [UUID](030-uuid.ipynb) — Universally unique identifiers

---

## 4. Referential Integrity
**Relationships between entities remain consistent.**

Referential integrity maintains logical associations across tables:
- **Foreign keys** link related records
- **Cascade operations** propagate changes
- **Referential constraints** prevent orphaned records

**Example:** A recording session cannot reference a non-existent mouse.

**Covered in:**
- [Foreign Keys](035-foreign-keys.ipynb) — Cross-table relationships
- [Relationships](050-relationships.ipynb) — Dependency patterns

---

## 5. Compositional Integrity
**Complex entities remain complete with all parts.**

Compositional integrity ensures multi-part entities are never partially stored:
- **Transactions** bundle multiple operations
- **Atomicity** guarantees all-or-nothing completion
- **Part tables** maintain parent-child relationships

**Example:** An imaging session's metadata and all acquired frames are stored together or not at all.

**Covered in:** 
- [Part Tables](055-part-tables.ipynb) — Hierarchical compositions
- [Transactions](../operations/045-transactions.ipynb) — Atomic operations

---

## 6. Consistency
**All users see the same valid data state.**

Consistency provides a unified view during concurrent access:
- **Isolation levels** control transaction visibility
- **Locking mechanisms** prevent conflicting updates
- **ACID properties** guarantee reliable state transitions

**Example:** Two researchers inserting experiments simultaneously don't create duplicates.

**Covered in:** 
- [Concurrency](../operations/050-concurrency.ipynb) — Multi-user operations
- [Transactions](../operations/045-transactions.ipynb) — ACID guarantees

# The Power of Declarative Constraints

Unlike application-level validation (checking rules in Python code), database constraints are:

1. **Always enforced** — Cannot be bypassed by any application
2. **Automatically checked** — No developer implementation needed
3. **Concurrent-safe** — Work correctly with multiple users
4. **Self-documenting** — Schema explicitly declares rules
5. **Performance-optimized** — Database engine enforces efficiently

**Example Contrast:**

```python
# Application-level (fragile)
if mouse_id not in existing_mice:
    raise ValueError("Invalid mouse ID")
# Can be bypassed by other applications

# Database-level (robust)
# RecordingSession.mouse → FOREIGN KEY → Mouse.mouse_id
# Automatically enforced for all applications
```

# DataJoint's Approach to Integrity

DataJoint builds on SQL's integrity mechanisms with additional features:

- **Automatic foreign keys** from table dependencies
- **Cascading deletes** that respect data pipelines
- **Transaction management** for atomic operations
- **Schema validation** catching errors before database creation
- **Entity relationships** expressed in intuitive Python syntax

As you progress through the following chapters, you'll see how DataJoint implements each integrity type through concise, expressive table declarations.

---

```{admonition} Next Steps
:class: tip

Now that you understand *why* integrity matters, the following chapters show *how* to implement each constraint type:

1. **[Tables](015-table.ipynb)** — Basic structure with domain integrity
2. **[Primary Keys](025-primary-key.md)** — Entity integrity through unique identification
3. **[Foreign Keys](035-foreign-keys.ipynb)** — Referential integrity across tables

Each chapter builds on these foundational integrity concepts.
```
