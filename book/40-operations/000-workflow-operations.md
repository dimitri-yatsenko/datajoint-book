# Workflow Operations

## Executing the Workflow

The previous sections established the **Relational Workflow Model** and schema design principles.
Your schema defines *what* entities exist, *how* they depend on each other, and *when* they are created in the workflow.
**Operations** are the actions that execute this workflow—populating your pipeline with actual data.

In DataJoint, operations fall into two categories:

1. **Manual operations** — Actions initiated *outside* the pipeline using `insert`, `delete`, and occasionally `update`
2. **Automatic operations** — Pipeline-driven population using `populate` for Imported and Computed tables

The term "manual" does not imply human involvement—it means the operation originates *external to the pipeline*.
A script that parses instrument files and inserts session records is performing manual operations, even though no human is involved.
The key distinction is *who initiates the action*: external processes (manual) versus the pipeline's own `populate` mechanism (automatic).

This distinction maps directly to the table tiers introduced in the [Relational Workflow Model](../20-concepts/05-workflows.md):

| Table Tier | How Data Enters | Typical Operations |
|------------|-----------------|-------------------|
| **Lookup** | Schema definition (`contents` property) | None—predefined |
| **Manual** | External to pipeline | `insert`, `delete` |
| **Imported** | Pipeline-driven acquisition | `populate` |
| **Computed** | Pipeline-driven computation | `populate` |

## Lookup Tables: Part of the Schema

**Lookup tables are not part of the workflow**—they are part of the schema definition itself.

Lookup tables contain reference data, controlled vocabularies, parameter sets, and configuration values that define the *context* in which the workflow operates.
This data is:

- Defined in the table class using the `contents` property
- Automatically present when the schema is activated
- Shared across all workflow executions

Examples include:
- Species names and codes
- Experimental protocols
- Processing parameter sets
- Instrument configurations

Because lookup data defines the problem space rather than recording workflow execution, it is specified declaratively as part of the table definition:

```python
@schema
class BlobParamSet(dj.Lookup):
    definition = """
    blob_paramset : int
    ---
    min_sigma : float
    max_sigma : float
    threshold : float
    """
    contents = [
        (1, 1.0, 5.0, 0.1),
        (2, 2.0, 10.0, 0.05),
    ]
```

When the schema is activated, an "empty" pipeline already has its lookup tables populated.
This ensures that reference data is always available and consistent across all installations of the pipeline.

## Manual Tables: The Workflow Entry Points

**Manual tables** are where new information enters the workflow from external sources.
The term "manual" refers to the data's origin—*outside the pipeline*—not to how it gets there.

Manual tables capture information that originates external to the computational pipeline:

- Experimental subjects and sessions
- Observations and annotations
- External system identifiers
- Curated selections and decisions

Data enters Manual tables through explicit `insert` operations from various sources:

- **Human entry**: Data entry forms, lab notebooks, manual curation
- **Automated scripts**: Parsing instrument files, syncing from external databases
- **External systems**: Laboratory information management systems (LIMS), scheduling software
- **Integration pipelines**: ETL processes that import data from other sources

Each insert into a Manual table potentially triggers downstream computations—this is the "data enters the system" event that drives the pipeline forward.
Whether a human clicks a button or a cron job runs a script, the effect is the same: new data enters the pipeline and becomes available for automatic processing.

## Automatic Population: The Workflow Engine

**Imported** and **Computed** tables are populated automatically through the `populate` mechanism.
This is the core of workflow automation in DataJoint.

When you call `populate()` on an auto-populated table, DataJoint:

1. Identifies what work is missing by examining upstream dependencies
2. Executes the table's `make()` method for each pending item
3. Wraps each computation in a transaction for integrity
4. Continues through all pending work, handling errors gracefully

This automation embodies the Relational Workflow Model's key principle: **the schema is an executable specification**.
You don't write scripts to orchestrate computations—you define dependencies, and the system figures out what to run.

```python
# The schema defines what should be computed
# populate() executes it
Detection.populate(display_progress=True)
```

## The Three Core Operations

### Insert: Adding Data

The `insert` operation adds new entities to Manual tables, representing new information entering the workflow from external sources.

```python
# Single row
Subject.insert1({"subject_id": "M001", "species": "mouse", "sex": "M"})

# Multiple rows
Session.insert([
    {"subject_id": "M001", "session_date": "2024-01-15"},
    {"subject_id": "M001", "session_date": "2024-01-16"},
])
```

### Delete: Removing Data with Cascade

The `delete` operation removes entities and **all their downstream dependents**.
This cascading behavior is fundamental to maintaining **computational validity**—the guarantee that derived data remains consistent with its inputs.

When you delete an entity:
- All entities that depend on it (via foreign keys) are also deleted
- This cascades through the entire dependency graph
- The result is a consistent database state

```python
# Deleting a session removes all its downstream analysis
(Session & {"subject_id": "M001", "session_date": "2024-01-15"}).delete()
```

Cascading delete is the primary mechanism for:
- **Correcting errors**: Delete incorrect upstream data; downstream results disappear automatically
- **Reprocessing**: Delete computed results to regenerate them with updated code
- **Data lifecycle**: Remove obsolete data and everything derived from it

### Update: Rare and Deliberate

The `update` operation modifies existing values **in place**.
In DataJoint, updates are deliberately rare because they can violate computational validity.

Consider: if you update an upstream value, downstream computed results become inconsistent—they were derived from the old value but now coexist with the new one.
The proper approach is usually **delete and reinsert**:

1. Delete the incorrect data (cascading removes dependent computations)
2. Insert the corrected data
3. Re-run `populate()` to regenerate downstream results

The `update1` method exists for cases where in-place correction is truly needed—typically for:
- Fixing typos in descriptive fields that don't affect computations
- Correcting metadata that has no downstream dependencies
- Administrative changes to non-scientific attributes

```python
# Use sparingly—only for corrections that don't affect downstream data
Subject.update1({"subject_id": "M001", "notes": "Corrected housing info"})
```

## The Workflow Execution Pattern

A typical DataJoint workflow follows this pattern:

```
┌─────────────────────────────────────────────────────────────┐
│  1. SCHEMA ACTIVATION                                       │
│     - Define tables and dependencies                        │
│     - Lookup tables are automatically populated (contents)  │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  2. EXTERNAL DATA ENTRY                                     │
│     - Insert subjects, sessions, trials into Manual tables  │
│     - Each insert is a potential trigger for downstream     │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  3. AUTOMATIC POPULATION                                    │
│     - Call populate() on Imported tables (data acquisition) │
│     - Call populate() on Computed tables (analysis)         │
│     - System determines order from dependency graph         │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  4. ITERATION                                               │
│     - New manual entries trigger new computations           │
│     - Errors corrected via delete + reinsert + repopulate   │
│     - Pipeline grows incrementally                          │
└─────────────────────────────────────────────────────────────┘
```

## Transactions and Integrity

All operations in DataJoint respect **ACID transactions** and **referential integrity**:

- **Inserts** verify that all referenced foreign keys exist
- **Deletes** cascade to maintain referential integrity
- **Populate** wraps each `make()` call in a transaction

This ensures that the database always represents a consistent state—there are no orphaned records, no dangling references, and no partially-completed computations visible to other users.

## Chapter Overview

The following chapters detail each operation:

- **[Insert](010-insert.ipynb)** — Adding data to Manual tables
- **[Delete](020-delete.ipynb)** — Removing data with cascading dependencies
- **[Updates](030-updates.ipynb)** — Rare in-place modifications
- **[Transactions](040-transactions.ipynb)** — ACID semantics and consistency
- **[Populate](050-populate.ipynb)** — Automatic workflow execution
- **[The `make` Method](055-make.ipynb)** — Defining computational logic
- **[Orchestration](060-orchestration.ipynb)** — Infrastructure for running at scale
