# Relational Workflows

## A New Paradigm for Relational Databases

The relational data model, while powerful, offers considerable semantic flexibility that can be both a blessing and a curse. This flexibility has led to the development of distinct conceptual frameworks for understanding and applying relational principles in database design and operations. While these approaches share common underlying constructs (tables, data types, primary keys, foreign keys, etc.), they operate on fundamentally different semantics that lead to distinct approaches to database design, data manipulation, and query formation.

This book introduces a paradigm shift in how we think about relational database design and implementation: the **Relational Workflow Model**. This model is embodied by DataJoint and affects how we think about database design, data manipulation, and query formation.

To understand the significance of the Relational Workflow Model, we must first examine the two dominant paradigms that preceded it and their inherent limitations.

## The Mathematical Foundation: Codd's Predicate Calculus Approach

### Core Concepts
The **mathematical view** of the relational model, championed by Edgar F. Codd, is rooted in **predicate calculus**, **first-order logic**, and **set theory**. This approach treats relations as mathematical predicates—statements about variables that can be determined to be true or false.

**Relation as Predicate**: In the mathematical view of relational databases, a table (relation) represents a logical predicate; it contains the complete set of all facts (propositions) that make the predicate true. For example, the table "EmployeeProject" represents the predicate "Employee $x$ works on Project $y$."

**Tuple as Proposition**: Each row (tuple) is a specific set of attribute values that asserts a true proposition for the predicate. For example, if a table's predicate is "Employee $x$ works on Project $y$," the row `(Alice, P1)` asserts the truth: "Employee Alice works on Project P1."

**Functional Dependencies between Attributes**: The core concept is the functional dependency: attribute `A` functionally determines attribute `B` (written `A → B`)  if knowing the value of `A` allows you to determine the unique value of `B`. For example, the attribute `department` functionally determines the attribute `department_chair` because knowing the department name allows you to determine the unique name of the department chair. Functional dependencies are helpful for reasoning about the structure of the database and for performing queries.

Then the database can be viewed as a collection of predicates and a mininmal complete set of true propositions from which all other true propositions can be derived. Data queries are viewed as logical inferences using the rules of predicate calculus. *Relational algebra* and *relational calculus* provide set of operations that can be used to perform these inferences. Under the Closed World Assumption (CWA), the database is assumed to contain all true propositions and all other propositions are assumed to be false. CWA is a simplifying assumption that allows us to reason about the data in the database in a more precise way.

Then the question of database design is to choose a minimal complete set of true propositions from which all other true propositions can be effectively derived. This is the problem of *database normalization*, a collection of design principles—called *normal forms*—that ensure data integrity and maintainability and makes databases more amenable to analysis and inference.

SQL—the primary language for defining and querying relational databases—is based on the mathematical semantics of the relational model. However, in practice, even most experienced database programmers hardly rely on the mathematical semantics of the relational model. Educational materials typically use more intuitive design methodologies and then teach how to translate the conceptual design into SQL. 

### Limitations

While mathematically rigorous, Codd's mathematical semantics approach suffers from several practical limitations:

- **Abstract Reasoning**: Requires thinking in terms of predicates and functional dependencies rather than intuitive domain concepts
- **Learning Curve**: Demands mastery of formal mathematical concepts that don't map to real-world thinking
- **No Diagramming Notation**: Designers must work with abstract dependency analysis without visual representations

As a result, even most proficient database programmers are rarely aware of the mathematical semantics of the relational model and design principles such as Codd's normal forms. They use on more intuitive design methodologies and then translate them into SQL.

## The Entity-Relationship Revolution

Today, most common aproaches to database design are based on the Entity-Relationship Model (ERM), which shifts the focus from abstract mathematical reasoning to concrete domain modeling.
Introduced by MIT professor Peter Chen [@10.1145/320434.320440], the ERM models the domain of interest as a collection of entities and relationships between them [@10.1007/978-3-642-59412-0_17].

```{figure} ../images/PChen.jpeg
:name: Peter Chen
:width: 300

Peter Chen, born in 1943, Taiwanese-American computer scientist, inventor of the Entity-Relationship Model.
```

### Core Concepts
The key insight of the ERM is that the relational model can be viewed through the lens of entities and relationships between them.
Tables in the database represent either sets of well-defined entity sets of the same type or relationships between entities, mapping the database schema to them domain of interest. 
Foreign keys between tables define the cardinality and optionality of the relationships between entity sets.

One of ERM's most significant contributions is the ability to visualize the database schema as an Entity-Relationship Diagram (ERD).
Several different notations have been developed, including Chen's original notation with rectangles and diamonds as well as Crow's Foot notation (see below).

```{figure} ../images/employee-project-erd.svg
:align: center 
```

:::{figure}
:align: center
```{mermaid}
---
title: Crow's Foot notation.
---
erDiagram
    EMPLOYEE }o--o{ PROJECT : assigned-to
```
Entity-relationship diagram in [Crow's Foot notation](https://mermaid.js.org/syntax/entityRelationshipDiagram.html).
:::

### Limitations

Despite its success, ERM still suffers from fundamental gaps:

- **Conceptual-Implementation Mismatch**: ERM dominates design, but SQL operates on mathematical semantics
- **No Temporal Dimension**: Doesn't address when or how entities are created
- **Static Relationships**: Treats relationships as static rather than operational
- **Translation Complexity**: Converting ERM designs to SQL requires mental translation between entity concepts and relational predicates

## The Relational Workflow Model: A Paradigm Shift

The **Relational Workflow Model**, pioneered by DataJoint, represents a fundamental evolution that addresses the limitations of both previous approaches while building on their strengths.

### Revolutionary Core Concepts

**Workflow Entity**: An entity created at a specific step in a workflow, representing an artifact of workflow execution.

**Workflow Dependency**: A foreign key relationship that ensures both referential integrity and prescribes operation order (parent must be created before child).

**Workflow Step**: A distinct phase where specific entity types are created.

**Directed Acyclic Graph (DAG)**: The schema structure representing valid workflow execution sequences.

### The Workflow Normalization Principle

> **"Every table represents an entity type that is created at a specific step in a workflow, and all attributes describe that entity as it exists at that workflow step."**

This principle extends entity normalization with temporal and operational dimensions, creating a unified framework for design, implementation, and querying.

### Why the Relational Workflow Model Matters

The Relational Workflow Model addresses the fundamental challenges that have plagued relational database practice:

#### 1. **Unified Design and Implementation**

Unlike the ERM-SQL gap, DataJoint provides **unified diagramming, definition, and query languages**:

- **Schema diagrams** directly represent data definitions
- **Arrow notation (`->`)** in definitions corresponds to arrows in diagrams  
- **Queries** operate on entity sets, not abstract relations
- **No translation** needed between conceptual design and implementation

#### 2. **Temporal and Operational Awareness**

While ERM focuses on "what entities exist," the Relational Workflow Model asks "when and how are entities created?" This temporal dimension is crucial for:

- **Scientific Workflows**: Where data processing follows strict sequences
- **Business Processes**: Where operations must occur in specific orders
- **Data Pipelines**: Where each step depends on previous steps

#### 3. **Immutability and Provenance**

The model treats workflow artifacts as **immutable once created**, naturally preserving:
- **Workflow execution history**
- **Data provenance**
- **Audit trails**
- **Reproducible science**

#### 4. **Workflow Integrity**

The DAG structure ensures:
- **No circular dependencies**
- **Valid operation sequences**
- **Explicit workflow dependencies**
- **Enforced temporal order**

```{figure} ../images/employee-project-datajoint.svg
:align: center

DataJoint diagram showing workflow dependencies
```

## Comparing the Three Paradigms

| Aspect | Mathematical (Codd) | Entity-Relationship (Chen) | **Relational Workflow (Yatsenko)** |
|--------|-------------------|-------------------------|-------------------------------|
| **Core Question** | "What functional dependencies exist?" | "What entity types exist?" | **"When/how are entities created?"** |
| **Diagramming** | None | Comprehensive ERDs | **Integrated workflow diagrams** |
| **Time Dimension** | Not addressed | Not central | **Fundamental** |
| **Implementation Gap** | High (abstract to SQL) | High (ERM to SQL) | **None (unified approach)** |
| **Workflow Support** | None | None | **Native workflow modeling** |
| **Learning Curve** | Steep (mathematical) | Moderate (intuitive design, complex SQL) | **Gentle (unified concepts)** |

## The DataJoint Implementation: Theory Made Practical

DataJoint represents the practical embodiment of the Relational Workflow Model, developed over a decade of neuroscience research [@10.48550/arXiv.1807.11104].

### The Schema as Executable Specification

The Relational Workflow Model has a profound implication: **the database schema itself becomes an executable specification** of your workflow.

When you define a DataJoint schema, you simultaneously:
- **Design** the conceptual model (what are the workflow steps?)
- **Implement** the database structure (tables, attributes, foreign keys)
- **Specify** the computations (through `make()` methods)
- **Document** the pipeline (the schema IS the documentation)

There is **no separate conceptual design phase** preceding implementation. You don't draw an ER diagram, then translate it into SQL tables. The schema you write directly expresses both the conceptual model and its implementation. When you generate a diagram, it's derived from the actual working schema, never out of sync.

### Table Tiers: Workflow Roles

DataJoint introduces **table tiers** that classify entity sets by their role in the workflow:

- **Lookup tables**: Reference data and parameters (controlled vocabularies, constants)
- **Manual tables**: Human-entered data (observations, decisions requiring expertise)
- **Imported tables**: Automated data acquisition (instrument readings, file imports)
- **Computed tables**: Automated processing (derived results, analyses)

These tiers aren't just organizational—they specify **who or what performs each step** and establish a dependency hierarchy. Computed tables depend on Imported or Manual tables, which may depend on Lookup tables. This creates a directed acyclic graph (DAG) that makes the workflow structure explicit.

The color-coded diagrams make this immediately visible: green for Manual tables, blue for Imported, red for Computed, gray for Lookup. At a glance, you see where data enters the system and how it flows through processing steps.

### Relationships Emerge from Workflow Convergence

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

### Immutability and Computational Validity

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

### Query Algebra with Workflow Semantics

Traditional SQL defines queries in terms of low-level table operations: JOINs on arbitrary columns, WHERE clauses with complex predicates, subqueries that reference tables multiple times. This works but requires careful attention to maintain consistency.

**DataJoint queries are defined with respect to workflow semantics.** Operations understand the entity types and dependencies declared in your schema. This allows a remarkably small set of operators—just **five**—to provide a complete algebra:

1. **Restriction** (`&`): Filter entities based on conditions
2. **Join** (`*`): Combine entities from converging workflow paths  
3. **Projection** (`.proj()`): Select and compute attributes
4. **Aggregation** (`.aggr()`): Summarize across entity groups
5. **Union**: Combine entities from parallel workflow branches

These operators maintain **algebraic closure**: they take entity sets as inputs and produce entity sets as outputs, so they can be composed arbitrarily. More importantly, they preserve **entity integrity**—query results remain valid entity sets, not arbitrary row collections.

Unlike SQL's natural joins that can produce unexpected results when tables share column names coincidentally, DataJoint operators respect the dependency structure. When you join `Person * Proficiency * Language`, the system knows these are related through the workflow and joins them appropriately.

### Practical Benefits

The Relational Workflow Model delivers unprecedented advantages:

- **Seamless Design-to-Implementation**: No conceptual gap between design and code
- **Intuitive Query Formation**: Queries naturally express entity relationships
- **Workflow Integrity**: DAG structure prevents circular dependencies
- **Data Consistency**: Immutable workflow artifacts maintain integrity
- **Collaborative Development**: Researchers without database expertise can collaborate effectively
- **Scientific Provenance**: Natural preservation of workflow execution history
- **Computational Validity**: Downstream results remain consistent with upstream inputs
- **Automatic Pipeline Execution**: Schema defines what to compute, DataJoint figures out how

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

## The Future of Database Design

The Relational Workflow Model represents more than an incremental improvement—it's a **paradigm shift** that addresses fundamental limitations in how we think about and implement relational databases.

### Why This Matters Now

**Scientific Computing**: The explosion of data-intensive research demands workflow-aware database systems that can handle complex data pipelines with temporal dependencies.

**Business Process Management**: Modern enterprises need databases that can model and enforce business process sequences, not just store static relationships.

**Data Engineering**: The rise of data pipelines, ETL processes, and streaming data requires databases that understand workflow semantics.

**Collaborative Development**: Teams need unified frameworks that eliminate the traditional gap between conceptual design and implementation.

### The Path Forward

This book demonstrates how the Relational Workflow Model, embodied in DataJoint, provides:

1. **A unified conceptual framework** for database design, implementation, and querying
2. **Native support for temporal and operational aspects** that previous models ignored
3. **Practical tools** that eliminate the traditional design-implementation gap
4. **A foundation** for the next generation of database applications

The Relational Workflow Model isn't just another approach to relational databases—it's the evolution that makes relational databases truly fit for modern computational workflows and collaborative data science.

## Exercises

1. **Identify workflow steps**: Take a process you're familiar with (analyzing survey data, processing images). Break it into steps and identify which would be Manual, Imported, or Computed tables. What are the dependencies?

2. **Relationships as convergence**: Look at the Language example. Explain how the person-language relationship emerges from workflow convergence rather than being explicitly modeled as in ERM.

3. **Trace provenance**: Using the neuroscience pipeline example, trace backward from `NeuronStatistics` to identify all upstream entities it depends on. Now trace forward from `Session` to see what would be affected if you deleted a session.

4. **Immutability vs updates**: Think of a scenario where you'd use UPDATE in a traditional database (correcting a data entry error). How would you handle this in DataJoint's immutable model? When does delete-and-reinsert make sense?

5. **Schema as specification**: Compare designing a database with the traditional ERM approach (draw ER diagram → translate to SQL) versus DataJoint (write schema directly). What are the advantages and disadvantages of each?

6. **Normalization reframed**: Take the poorly designed Mouse table from the Normalization chapter (with changeable cage and weight attributes). Explain how applying DataJoint's entity-centric principles leads to a better design, without needing to analyze functional dependencies.