# Databases as Workflows

## A Historical Rift

The history of relational databases reveals a curious disconnect. Edgar F. Codd's relational model (1970) provided mathematical rigor for data organization. Peter Chen's Entity-Relationship Model (1976) made database design intuitive by thinking in terms of entities and relationships. Yet SQL, the dominant query language that emerged in the late 1970s, never fully embraced either framework.

**The ERM became the most successful conceptual framework for designing relational schemas**, helping generations of database designers think clearly about their domains. Database textbooks teach students to draw ER diagrams, identify entities and relationships, then translate them into SQL tables. But this is where the disconnect happens: **SQL provides no native constructs for entities or relationships**. It knows only tables, columns, and constraints. The elegant conceptual models must be manually translated into SQL's lower-level primitives.

Similarly, while **Codd's normal forms** (1NF, 2NF, 3NF, BCNF) provide the theoretical foundation for eliminating redundancy and anomalies, they prove difficult to apply in practice. Ask most database engineers how they normalize schemas, and few will describe analyzing functional dependencies or systematically applying normal forms. Instead, they rely on intuition, patterns, and experience—often arriving at correct designs without consciously applying the formal theory.

This rift between elegant theory and practical implementation has persisted for decades. **DataJoint bridges this gap** by reinterpreting the relational model through a lens that makes conceptual design, normalization, and implementation inseparable.

## From Storage to Workflow

The relational model views databases as systems for **storing and querying data**. The ERM adds the conceptual layer of **entities and relationships**. DataJoint takes a further step: **reinterpreting databases as specifications for human and computational workflows**.

In this view, each entity set represents not just a collection of data, but a **step in a process**—a task to be performed, a computation to be executed, or a decision to be made. Dependencies between entity sets represent information flow through a computational pipeline.

Consider a neuroscience experiment:

```
Subject (manual entry)
    ↓
Session (manual entry)
    ↓
Recording (automated import)
    ↓
FilteredSignal (computed)
    ↓
SpikeEvents (computed)
    ↓
NeuronStatistics (computed)
```

Each entity set is a workflow step with a specific purpose. The schema doesn't just organize data—it specifies the entire experimental and analytical pipeline, including who does what and what depends on what.

## The Schema as Executable Specification

This shift in perspective has a profound implication: **the database schema itself becomes an executable specification** of your workflow.

When you define a DataJoint schema, you simultaneously:
- **Design** the conceptual model (what are the workflow steps?)
- **Implement** the database structure (tables, attributes, foreign keys)
- **Specify** the computations (through `make()` methods)
- **Document** the pipeline (the schema IS the documentation)

There is **no separate conceptual design phase** preceding implementation. You don't draw an ER diagram, then translate it into SQL tables. The schema you write directly expresses both the conceptual model and its implementation. When you generate a diagram, it's derived from the actual working schema, never out of sync.

This unification eliminates translation errors and keeps design, implementation, and documentation in perfect harmony.

## Table Tiers: Workflow Roles

DataJoint introduces **table tiers** that classify entity sets by their role in the workflow:

- **Lookup tables**: Reference data and parameters (controlled vocabularies, constants)
- **Manual tables**: Human-entered data (observations, decisions requiring expertise)
- **Imported tables**: Automated data acquisition (instrument readings, file imports)
- **Computed tables**: Automated processing (derived results, analyses)

These tiers aren't just organizational—they specify **who or what performs each step** and establish a dependency hierarchy. Computed tables depend on Imported or Manual tables, which may depend on Lookup tables. This creates a directed acyclic graph (DAG) that makes the workflow structure explicit.

The color-coded diagrams make this immediately visible: green for Manual tables, blue for Imported, red for Computed, gray for Lookup. At a glance, you see where data enters the system and how it flows through processing steps.

## Relationships Emerge from Workflow Convergence

Unlike ERM, **DataJoint has no special notation or concept for relationships**. Instead, relationships emerge naturally where workflows converge.

Consider language proficiency:

```
Person (Manual)    Language (Lookup)
    ↓                    ↓
    └───> Proficiency <─┘
          (Manual)
```

In ERM, you might model:
- **Entities**: Person, Language  
- **Relationship**: "SpeaksLanguage" (connecting Person to Language)
- **Implementation**: Create a junction table

In DataJoint, there's no separate "relationship" concept. `Proficiency` is simply a workflow step that requires both a Person and a Language. It's not an artificial junction table—it represents the actual task of assessing or recording language proficiency, creating the association.

**Relationships are implicit, not explicit.** A person "relates to" languages because there exists a workflow step (`Proficiency`) involving both entities. You query the relationship by querying the convergence point: `Person * Proficiency * Language`.

This makes DataJoint's model **more literal**: it shows exactly what tables exist and their dependencies, without introducing abstract concepts that require translation.

## Redefining Normalization

The classical approach to normalization—analyzing functional dependencies and applying normal forms—proves difficult in practice. In decades of designing scientific data pipelines, we've found that engineers rarely apply Codd's formal methods consciously, even when they arrive at well-normalized schemas.

**DataJoint reframes normalization** through an entity-centric lens that maps naturally to how we conceptualize domains:

> **"Each table contains attributes about the entity, the whole entity, and nothing but the entity."**

This leads to three practical principles (detailed in the Normalization chapter):

1. **One entity type per table**: Don't mix different kinds of things
2. **Attributes describe only that entity**: Each attribute is intrinsic to the entity it describes
3. **Separate changeable attributes**: Time-varying properties become separate entities

These principles naturally lead to schemas where:
- Entities are **immutable** (created and destroyed, not modified)
- Changes are represented through **INSERT and DELETE**, not UPDATE
- **History is preserved** automatically
- **Data dependencies are explicit** through foreign keys

The workflow perspective explains why: in a computational pipeline, updating upstream data silently invalidates downstream results. Deletion forces you to recompute the entire dependent chain, maintaining computational validity.

This entity-workflow view of normalization is more intuitive than analyzing functional dependencies, yet achieves the same rigorous results.

## Immutability and Computational Validity

Traditional databases emphasize **transactional consistency**: ensuring concurrent updates don't corrupt data. DataJoint adds **computational validity**: ensuring downstream results remain consistent with their upstream inputs.

When you delete an entity, DataJoint **cascades the delete** to all dependent entities. This isn't just cleanup—it's enforcing computational validity. If the inputs are gone, results based on them become meaningless and must be removed.

When you reinsert corrected data, you explicitly **recompute the pipeline**:

```python
# Delete invalidates entire downstream pipeline
(Recording & key).delete()

# Reinsert with corrections
Recording.insert1(corrected_data)

# Recompute dependencies
FilteredSignal.populate(key)
SpikeEvents.populate(key)
NeuronStatistics.populate(key)
```

The `populate()` operation embodies the workflow philosophy: **your schema defines what needs to be computed, and DataJoint figures out how to execute it**. It identifies missing work, computes results, and maintains integrity—all while supporting parallel execution and resumable computation.

## Provenance: Built-In, Not Added On

In the entity-workflow model, **provenance is automatic**. Every entity knows exactly what it depends on because dependencies are declared in the schema and enforced by foreign keys.

Tracing backward answers: "Where did this result come from?" Tracing forward answers: "What will be affected if I change this?" The workflow structure makes both trivial—no special provenance tracking system needed.

This is crucial for scientific reproducibility. Combined with version-controlled `make()` methods, every result can be traced back to its source data and the exact code that produced it.

## From Transactions to Transformations

DataJoint represents a conceptual shift in how we think about relational databases:

| Traditional View | DataJoint Workflow View |
|:---|:---|
| Tables store data | Entity sets are workflow steps |
| Rows are records | Entities are execution instances |
| Foreign keys enforce consistency | Dependencies specify information flow |
| Updates modify state | Computations create new states |
| Schema organizes storage | Schema specifies pipeline |
| Queries retrieve data | Queries trace provenance |
| Focus: concurrent transactions | Focus: reproducible transformations |

This shift makes DataJoint feel less like a traditional database and more like a **workflow engine with persistent state**—one that maintains perfect computational validity while supporting the flexibility scientists need.

## Harmonizing with Relational Theory

DataJoint doesn't abandon relational foundations—it extends them:

**Maintains:**
- Relations as sets of tuples
- Relational algebra (join, restrict, project, aggregate, union)
- Referential integrity through foreign keys
- Declarative queries

**Adds:**
- Table tiers classifying workflow roles
- Computational semantics through `make()` methods
- Dependency structure as a DAG
- Immutability as the default
- `populate()` for automatic execution
- Provenance awareness built-in

This makes DataJoint a **specialized dialect** of the relational model, optimized for computational workflows while maintaining mathematical rigor.

## A Complete and Practical Model

Unlike theoretical frameworks that require separate implementations, **DataJoint is a complete, practical model with a reference implementation in Python**. It's not just a conceptual approach—it's a working system that unifies all aspects of database interaction within the workflow paradigm.

### Unified Operations

DataJoint provides a single, coherent framework for:

- **Defining schemas**: Write table definitions that simultaneously specify conceptual model, database structure, and computations
- **Diagramming workflows**: Generate visual representations automatically from the schema itself
- **Manipulating data**: Insert, delete, and (rarely) update entities using operations aligned with workflow semantics
- **Querying data**: Compose queries that navigate the workflow structure
- **Automating computations**: Execute pipelines with `populate()`, leveraging parallel processing and error handling

All of these capabilities are integrated. You don't use separate tools for design, documentation, data manipulation, and analysis—they're all part of the same model expressed in Python code.

### Query Algebra with Workflow Semantics

Traditional SQL defines queries in terms of low-level table operations: JOINs on arbitrary columns, WHERE clauses with complex predicates, subqueries that reference tables multiple times. This works but requires careful attention to maintain consistency.

**DataJoint queries are defined with respect to workflow semantics.** Operations understand the entity types and dependencies declared in your schema. This allows a remarkably small set of operators—just **five**—to provide a complete algebra:

1. **Restriction** (`&`): Filter entities based on conditions
2. **Join** (`*`): Combine entities from converging workflow paths  
3. **Projection** (`.proj()`): Select and compute attributes
4. **Aggregation** (`.aggr()`): Summarize across entity groups
5. **Union**: Combine entities from parallel workflow branches

These operators maintain **algebraic closure**: they take entity sets as inputs and produce entity sets as outputs, so they can be composed arbitrarily. More importantly, they preserve **entity integrity**—query results remain valid entity sets, not arbitrary row collections.

Unlike SQL's natural joins that can produce unexpected results when tables share column names coincidentally, DataJoint operators respect the dependency structure. When you join `Person * Proficiency * Language`, the system knows these are related through the workflow and joins them appropriately. There's no ambiguity about which attributes should match—the foreign key declarations in the schema define this unambiguously.

This workflow-aware query model means:
- **Queries are more concise**: No need to specify join conditions explicitly when following workflow paths
- **Queries are more reliable**: Can't accidentally join on wrong attributes
- **Results stay normalized**: Query outputs maintain entity integrity, suitable for further operations
- **Semantics are clearer**: Reading a query reveals its meaning in terms of workflow navigation

The five operators, combined with understanding of your workflow structure, provide all the expressive power needed for complex scientific queries while maintaining conceptual clarity and operational safety.

## Why This Matters for Science

Traditional relational databases were designed for **transactions**: banking, retail, airlines. Science needs databases that support **computational pipelines** with evolving analyses.

The entity-workflow model addresses scientific needs:

**Evolving analyses**: Add new computed tables representing new methods without disrupting existing pipelines

**Comparing approaches**: Immutability lets you run multiple analysis methods side-by-side

**Collaborative work**: Multiple researchers work on different workflow steps; the schema coordinates their contributions

**Reproducibility**: The schema itself documents your methods; computational validity ensures results stay consistent

**Publication**: Share your workflow as executable code that others can reproduce exactly

## Conclusion: Structure and Process Unified

The DataJoint model represents an evolution in how we conceptualize relational databases. By viewing entity sets as workflow steps, dependencies as information flow, and schemas as executable specifications, we create databases that:

- **Enforce computational validity**, not just relational consistency
- **Document provenance automatically**, not as an afterthought  
- **Enable reproducible science**, not just reproducible storage
- **Coordinate collaborative work**, not just concurrent access
- **Evolve with understanding**, not require complete upfront design

When you design a DataJoint schema, you're not just organizing data—you're **choreographing a workflow**. Each entity set is a step in a process, each dependency a passing of information, and the schema itself a **specification for how observations become insights**.

This bridges the historical rift between elegant theory and practical implementation. Conceptual design, normalization, and executable code become one unified activity. The result is databases that truly understand your work, not just store your data.

**This is the power of viewing relational databases as computational workflows: structure and process become one.**

## Exercises

1. **Identify workflow steps**: Take a process you're familiar with (making coffee, analyzing survey data, processing images). Break it into steps and identify which would be Manual, Imported, or Computed tables. What are the dependencies?

2. **Relationships as convergence**: Look at the Language example. Explain how the person-language relationship emerges from workflow convergence rather than being explicitly modeled as in ERM.

3. **Trace provenance**: Using the neuroscience pipeline example, trace backward from `NeuronStatistics` to identify all upstream entities it depends on. Now trace forward from `Session` to see what would be affected if you deleted a session.

4. **Immutability vs updates**: Think of a scenario where you'd use UPDATE in a traditional database (correcting a data entry error). How would you handle this in DataJoint's immutable model? When does delete-and-reinsert make sense?

5. **Schema as specification**: Compare designing a database with the traditional ERM approach (draw ER diagram → translate to SQL) versus DataJoint (write schema directly). What are the advantages and disadvantages of each?

6. **Normalization reframed**: Take the poorly designed Mouse table from the Normalization chapter (with changeable cage and weight attributes). Explain how applying DataJoint's entity-centric principles leads to a better design, without needing to analyze functional dependencies.

