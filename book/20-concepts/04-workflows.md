---
title: Relational Workflows
---

# Relational Workflows

## The Problem DataJoint Solves

Traditional relational databases excel at storing and querying data but struggle with scientific workflows. When you update an input measurement, downstream analyses become stale. When you want to process new data, you must manually track dependencies and run computations in the correct order. When someone asks "how was this result computed?", you rely on external documentation that may be out of date.

**DataJoint solves these problems by treating your database schema as an executable workflow specification.** Your table definitions don't just describe data structure—they prescribe how data flows through your pipeline, when computations run, and how results depend on inputs.

## The Relational Workflow Model

The previous chapters established that traditional relational databases, despite their mathematical rigor and practical power, lack computational workflow semantics. The Relational Workflow Model addresses this fundamental gap.

This represents the third major paradigm for relational databases:

1. **Codd (1970)**: Mathematical foundations—relational algebra, functional dependencies, declarative queries
2. **Chen (1976)**: Conceptual modeling—entities, relationships, visual design
3. **Yatsenko (2009-present)**: Computational workflows—tables as workflow steps, dependencies as computations, schema as executable specification

Each paradigm builds on the previous while adding new dimensions. Chen's Entity-Relationship Model didn't replace Codd's mathematics—it made them more accessible. Similarly, the Relational Workflow Model doesn't replace either predecessor—it extends them with computational semantics essential for scientific pipelines.

### The Workflow Model Subsumes ERM

A critical property: **each paradigm subsumes its predecessors without loss**.

The Relational Workflow Model preserves all Entity-Relationship concepts:
- **Entities** → Workflow entities (with temporal semantics)
- **Relationships** → Dependencies (with computational semantics)
- **Cardinality** → Foreign key constraints
- **Optionality** → Foreign key constraints, NULLable attributes.

The difference is emphasis:

**ERM asks**: "What entity types exist and how are they related?"

**Workflow Model asks**: "When and how are entities created in the pipeline?"

You can still model everything from ERM—customers, orders, products. The workflow model adds: When is each created? What's the dependency? This makes it a true generalization, not an alternative approach.

## Core Workflow Concepts

### Workflow Entities: Data with Context

Unlike traditional database records, **workflow entities** are created at specific workflow steps. You know not just *what* they are, but *when* and *how* they came to exist.

**Example**: A `FilteredRecording` isn't just data—it's the result of applying filtering to a `Recording` at a specific time. This temporal and computational context is intrinsic to the entity.

### Computational Dependencies: Beyond Foreign Keys

A **computational dependency** means "this was computed FROM that using a specific process"—stronger than a foreign key.

**Foreign key**: `NeuralUnit` references `Recording` (these are associated)

**Computational dependency**: `NeuralUnit` was *computed from* `Recording` (must recompute if Recording changes)

This distinction ensures computational validity: results correspond to their current inputs, not outdated data.

### Workflow DAG: Valid Execution Order

Computational dependencies form a **directed acyclic graph**:
- **Directed**: Dependencies point from inputs to outputs
- **Acyclic**: No circular dependencies (prevents infinite loops)

This guarantees deterministic execution order, enables parallel processing, and ensures clear provenance.

## Key DataJoint Innovations

### Mixing Manual and Automated Steps

Scientific workflows combine human operations (design experiments, assess quality) with computational operations (process signals, compute statistics).

DataJoint makes this explicit through **population control**:

**Explicit INSERT** (you control):
- Manual tables: Human observations, decisions, assessments
- Lookup tables: Reference data defined at schema design

**Automatic via make()** (DataJoint controls):
- Imported tables: Automated data acquisition from instruments
- Computed tables: Automated processing and analysis

```python
# Manual: You INSERT explicitly
Session.insert1({'session_id': 101, 'subject_id': 'mouse_042'})

# Computed: You define make(), DataJoint calls it
@schema
class FilteredRecording(dj.Computed):
    definition = """-> Recording ..."""
    
    def make(self, key):
        raw = (Recording & key).fetch1()
        filtered = apply_filter(raw)
        self.insert1({**key, 'filtered_data': filtered})

# Execute workflow
FilteredRecording.populate()  # DataJoint calls make() automatically
```

### Table Tiers: Visual Workflow Language

DataJoint uses four table tiers, each with distinct visual representation:

```{list-table}
:header-rows: 1
:widths: 15 25 15 45

* - Tier
  - Population
  - Visual
  - Role
* - **Lookup**
  - `contents` attribute (schema design)
  - Gray rectangle
  - Reference data, controlled vocabularies
* - **Manual**
  - Explicit INSERT (you control)
  - Green rectangle
  - Human-controlled entry points
* - **Imported**
  - Automatic via `make()`
  - Blue oval
  - Automated data acquisition
* - **Computed**
  - Automatic via `make()`
  - Red oval
  - Automated processing
```

**Shape encodes behavior**:
- Rectangle = explicit INSERT or contents
- Oval = automatic via make()

**Color encodes role**:
- Gray = schema design (lookups)
- Green = human operations (manual)
- Blue = acquisition (imported)
- Red = processing (computed)

### Workflow Execution: populate() and make()

For automatic tables (Imported/Computed), you define `make()` methods. DataJoint calls them automatically:

```python
# You define what to compute
def make(self, key):
    input_data = (UpstreamTable & key).fetch1()
    result = process(input_data)
    self.insert1({**key, 'result': result})

# DataJoint handles execution
MyTable.populate()  # Finds missing work, calls make(), handles errors
```

When you call `populate()`:
1. DataJoint identifies missing work (which keys need computing)
2. Checks dependencies (are upstream data ready?)
3. Calls `make()` for each missing entry
4. Tracks errors and allows retry
5. Supports parallel execution across workers

### Lookup Tables: Schema Design

**Lookup tables** are unique—they're part of schema design, not workflow operations.

```python
@schema
class Species(dj.Lookup):
    definition = """
    species: varchar(32)
    ---
    common_name: varchar(64)
    """
    
    # Contents defined at schema declaration
    contents = [
        ('mouse', 'House mouse'),
        ('rat', 'Norway rat')
    ]
```

When you declare the schema, lookup tables populate automatically. The database is "empty" for workflow purposes, but lookups contain reference data.

**Use lookup for**:
- Stable reference data (rarely changes)
- Controlled vocabularies (species codes, measurement units)
- Community standards (brain atlases, ISO codes)
- Design-time decisions (algorithm parameter sets)

**Use manual for**:
- Observations during operations
- Content that grows with workflow execution
- Data unique to each database instance

### Diagramming: Executable Specifications

DataJoint diagrams encode operational behavior:

```
        ┌──────────┐
        │  Species │ [Lookup - Gray Rectangle]
        └─────┬────┘
              │
              ↓
        ┌──────────┐
        │ Subject  │ [Manual - Green Rectangle]
        └─────┬────┘
              │
              ↓
        ┌──────────┐
        │ Session  │ [Manual - Green Rectangle]
        └─────┬────┘
              │
              ↓
        ╭──────────╮
        │Recording │ [Imported - Blue Oval]
        ╰─────┬────╯
              │
              ↓
        ╭──────────╮
        │ Filtered │ [Computed - Red Oval]
        ╰──────────╯
```

One glance reveals:
- Entry points (rectangles)
- Automated steps (ovals)
- Data flow (arrows)
- Workflow stages (colors)

### Master-Part: Group Integrity

Some entities consist of parts that form a cohesive group. Sessions have Trials. Surveys have Questions.

**Master-part relationships** maintain group integrity:

```python
@schema
class Session(dj.Manual):
    definition = """
    session_id: int
    ---
    session_date: date
    """
    
    class Trial(dj.Part):
        definition = """
        -> master
        trial_id: int
        ---
        outcome: enum('success', 'failure')
        """
```

Properties:
- Trials inherit Session's primary key
- Can't create Trials without Session
- Deleting Session deletes all its Trials
- Visual: bold outline in diagrams

Use when parts have exclusive ownership, no independent meaning, and create/delete with master.

### Relationships from Workflow Convergence

Traditional ERM explicitly models relationships as separate concepts. The workflow model lets them emerge naturally from convergence points.

**Example**: Person-Language proficiency

```python
@schema
class Person(dj.Manual):
    definition = """
    person_id: int
    ---
    name: varchar(64)
    """

@schema
class Language(dj.Lookup):
    definition = """
    language: char(2)  # ISO 639-1 code
    ---
    name: varchar(64)
    """
    contents = [
        ('en', 'English'),
        ('es', 'Spanish'),
        ('fr', 'French')
    ]

@schema
class Proficiency(dj.Manual):
    definition = """
    -> Person
    -> Language
    ---
    level: enum('beginner', 'intermediate', 'advanced')
    assessed_date: date
    """
```

`Proficiency` isn't an artificial junction table—it's a genuine workflow step: "Record a person's proficiency in a language." The many-to-many relationship between Person and Language emerges because there's a concrete operation involving both.

All ERM expressiveness is preserved (cardinality, optionality, attributes), plus you gain workflow semantics.

## Why This Matters for Science

Traditional databases maintain **referential integrity** (no orphaned records) but not **computational validity** (results consistent with inputs).

The Relational Workflow Model enforces both:

**Referential integrity**: Foreign keys prevent orphaned data

**Computational validity**: If inputs change, dependent results must be recomputed or deleted

**Example**: You discover Recording #42 was corrupted.

Traditional approach:
1. Update Recording #42
2. Old analyses still exist (referential integrity maintained)
3. But they're computed from wrong data (computational validity violated)

DataJoint approach:
1. Delete Recording #42 (cascades to all dependent analyses)
2. Insert corrected Recording #42
3. Call `populate()` (automatically recomputes everything)

This ensures every result corresponds to its current inputs—essential for reproducible science.

## The Transformation

**Before DataJoint**: "I have scripts that process data. I hope I ran them in the right order with the right versions."

**After DataJoint**: "I have a database schema that specifies my workflow. DataJoint executes it correctly, tracks provenance automatically, and guarantees computational validity."

This chapter introduced concepts intuitively. The next sections show how to build them:

- **Schema Design**: Declare tables, dependencies, and computations
- **Computations**: Execute workflows, handle errors, parallelize
- **Data Operations**: Insert, query, and maintain workflow data
- **Examples**: Complete working pipelines in various domains

## Exercises

### Exercise 4.1: Visual Language

Look at any DataJoint diagram:
- Identify entry points (where you provide data)
- Trace automated processing chains
- Find convergence points (multiple dependencies)

### Exercise 4.2: Table Tiers

For a workflow you know:
- What would be Lookup? (design-time reference data)
- What would be Manual? (human observations)
- What would be Imported? (automated acquisition)
- What would be Computed? (automated processing)

### Exercise 4.3: Computational Validity

Why delete-and-recompute instead of update?
- What breaks if you UPDATE a computed result?
- How does cascading delete maintain validity?
- When is UPDATE appropriate?

### Exercise 4.4: Relationships

Take an ERM many-to-many relationship:
- How would you express it as a workflow convergence point?
- What workflow step does the junction table represent?
- What temporal information can you add?

### Exercise 4.5: Design

Design a simple workflow:
- Weather stations → hourly readings → daily statistics
- Identify tiers for each table
- Draw the diagram with correct shapes/colors
- Write pseudocode for one `make()` method

:::{admonition} See Complete Examples
:class: seealso

The Examples section contains fully executable workflows:
- **Research Lab**: Neuroscience recording and analysis
- **Fractals**: Computational image generation pipeline
- **Languages**: ISO standards and proficiency tracking
- **University**: Academic records and relationships

Each demonstrates the concepts introduced in this chapter with working code.
:::
