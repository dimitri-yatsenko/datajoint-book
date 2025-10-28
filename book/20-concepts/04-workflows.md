# Chapter 4: Relational Workflows - A New Data Model

## The Problem DataJoint Solves

In the previous chapter, we saw how traditional relational databases excel at storing and querying data but struggle with scientific workflows. When you update an input measurement, downstream analyses become stale. When you want to process new data, you must manually track dependencies and run computations in the correct order. When someone asks "how was this result computed?", you rely on external documentation that may be out of date.

**DataJoint solves these problems by treating your database schema as an executable workflow specification.** Your table definitions don't just describe data structure—they prescribe how data flows through your pipeline, when computations run, and how results depend on inputs.

This chapter introduces the Relational Workflow Model—a conceptual framework that extends relational theory to treat databases as executable workflow specifications rather than passive storage systems.

## The Relational Workflow Model: Third Paradigm for Relational Thinking

The previous chapters established that traditional relational databases, despite their mathematical rigor and practical power, lack computational workflow semantics. The Relational Workflow Model addresses this fundamental gap.

This represents the third major paradigm for relational databases:

**1. Codd (1970): Mathematical foundations**
   - Relational algebra and calculus
   - Functional dependencies and normal forms
   - Declarative query languages

**2. Chen (1976): Conceptual modeling**
   - Entities and relationships as design primitives
   - Visual diagramming (ERDs)
   - Intuitive mapping from domain to implementation

**3. Yatsenko (2009-present): Computational workflows**
   - Tables as workflow steps
   - Dependencies as computational relationships
   - Schema as executable specification

Each paradigm builds on the previous while adding new dimensions. Chen's Entity-Relationship Model didn't replace Codd's mathematical foundations—it made them more accessible and practical. Similarly, the Relational Workflow Model doesn't replace either predecessor. It extends them by adding computational semantics essential for scientific data pipelines.

### The Workflow Model Subsumes ERM

A critical property of this progression: **each paradigm subsumes its predecessors without loss**.

Chen's Entity-Relationship Model didn't abandon Codd's relational algebra—it provided a conceptual layer on top of it. You can express any ERM design in relational algebra, and the mathematical properties still hold.

Similarly, the Relational Workflow Model doesn't abandon entity-relationship thinking—**it subsumes and extends it**. Every concept from ERM remains valid and expressible:

- **Entities** → Workflow entities (with added temporal semantics)
- **Relationships** → Dependencies (with added computational semantics)
- **Cardinality** → Foreign key constraints (one-to-many, many-to-many)
- **Optionality** → NULL constraints and foreign key specifications

The difference is emphasis and interpretation, not capability:

**ERM emphasis**: "What entity types exist and how are they related?"
- Cardinality: one-to-many, many-to-many
- Optionality: required vs. optional relationships
- Static structure: entities exist timelessly

**Workflow emphasis**: "When and how are entities created in the pipeline?"
- Dependencies: which workflow steps produce inputs for other steps
- Temporal order: what must exist before what can be computed
- Dynamic process: entities are workflow artifacts

**You can still model everything from ERM**—a Customer entity, an Order entity, and their one-to-many relationship. The workflow model simply adds: "When does a Customer get created? (Manual entry.) When does an Order get created? (Manual entry or computed from shopping cart.) What's the workflow dependency?"

For domains without computational workflows (like traditional business databases), the workflow model reduces to standard ERM plus temporal awareness. You haven't lost anything—you've gained the ability to express computational semantics when they matter.

This subsumption property is essential: **the workflow model is a true generalization**, not an alternative approach that trades off against ERM.

### Scope of This Chapter

This chapter introduces workflow concepts intuitively, preparing you to understand DataJoint's design decisions. The formal machinery comes later:

- **Schema Design section**: Provides formal syntax for declaring workflow tables, specifying dependencies, and defining computations
- **Computations section**: Shows operational mechanics of workflow execution, validation, and error handling
- **Data Operations section**: Demonstrates working with workflow-aware data while preserving validity

By the end of this chapter, you'll understand *what* makes workflow databases different and *why* those differences matter for scientific computing. Subsequent sections show *how* to build them.

## Comparing the Three Paradigms

The three paradigms for relational thinking each add capabilities while preserving what came before:

| Aspect | Mathematical (Codd) | Entity-Relationship (Chen) | **Relational Workflow (Yatsenko)** |
|--------|---------------------|----------------------------|-------------------------------------|
| **Year Introduced** | 1970 | 1976 | **2009-present** |
| **Primary Innovation** | Formal mathematical foundation | Intuitive conceptual modeling | **Computational workflow semantics** |
| **Core Question** | "What functional dependencies exist?" | "What entity types and relationships exist?" | **"When and how are entities created?"** |
| **Key Constructs** | Relations, tuples, attributes, functional dependencies | Entities, relationships, cardinality, optionality | **Workflow entities, computational dependencies, table tiers, DAG** |
| **Design Focus** | Minimizing redundancy through normalization | Mapping domain concepts to database structure | **Specifying data flow through processing pipeline** |
| **Diagramming** | None (purely mathematical) | Entity-Relationship Diagrams (ERDs) | **Integrated workflow diagrams with tier colors** |
| **Time Dimension** | Not addressed | Not central | **Fundamental (when entities are created)** |
| **Computational Semantics** | Not addressed | Not addressed | **First-class schema elements** |
| **Relationships** | Captured through foreign keys | Explicit design primitive with cardinality/optionality | **Emerge from workflow convergence points** |
| **Implementation Gap** | High (abstract theory → SQL) | Moderate (ERD → SQL requires translation) | **Minimal (schema is executable specification)** |
| **Query Language** | Relational algebra/calculus | SQL (via translation from ERM) | **Relational algebra with workflow semantics** |
| **Data Modification** | INSERT, UPDATE, DELETE equally privileged | INSERT, UPDATE, DELETE equally privileged | **INSERT/DELETE primary; UPDATE restricted** |
| **Data Population** | Direct INSERT/UPDATE/DELETE | Direct INSERT/UPDATE/DELETE | **Tiered: Explicit INSERT (Manual/Lookup) vs. Automatic via make() (Imported/Computed)** |
| **Integrity Guarantees** | Functional dependencies, key constraints | Referential integrity, cardinality constraints | **Referential + computational validity** |
| **Subsumes Previous?** | N/A (first paradigm) | Yes (ERM expressed in relational algebra) | **Yes (ERM + workflow semantics)** |
| **Learning Curve** | Steep (mathematical abstraction) | Moderate (intuitive design, complex SQL) | **Gentle (unified design/implementation)** |
| **Best For** | Theoretical analysis, query optimization | Conceptual database design | **Scientific workflows, data pipelines** |
| **Adopted By** | Database theorists, researchers | Database designers worldwide | **Scientific computing, research labs** |

### The Progression: Each Paradigm Preserves and Extends

**Codd → Chen**:
- Preserved: All mathematical properties, relational algebra operations
- Added: Intuitive entities/relationships, visual design, domain-centric thinking
- Lost: Nothing—ERM is expressible in relational algebra

**Chen → Yatsenko**:
- Preserved: All entity/relationship concepts, cardinality, optionality
- Added: Temporal semantics, computational dependencies, workflow execution
- Lost: Nothing—ERM fully expressible in workflow model

This is not three competing approaches—it's three levels of a coherent intellectual framework, where each level adds expressiveness without sacrificing what came before.

### When Each Paradigm Shines

**Use Codd's mathematical view when**:
- Proving properties about query equivalence
- Reasoning about normalization
- Optimizing query execution
- Teaching database theory

**Use Chen's ERM when**:
- Designing static data structures
- Communicating with domain experts
- Planning database schemas
- Documenting existing systems

**Use Yatsenko's Workflow Model when**:
- Building data processing pipelines
- Ensuring computational reproducibility
- Tracking data provenance
- Coordinating automated and manual steps
- Collaborating on evolving research workflows

All three remain valuable. The workflow model doesn't replace its predecessors—it provides an additional lens that's particularly powerful for scientific computing while remaining compatible with traditional database uses.

## Core Workflow Concepts

The Relational Workflow Model introduces four fundamental concepts that transform how we think about database design and implementation. These concepts work together to create a unified framework where databases actively manage computational pipelines, not just store results.

### Workflow Entities: Data with Temporal Semantics

Unlike traditional database records that exist timelessly, **workflow entities** are created at specific workflow steps. We know not just *what* they are, but *when* and *how* they came to exist.

**Traditional database thinking**: A record in `NeuralUnit` table contains spike rate data

**Workflow thinking**: A `NeuralUnit` entity is the result of applying spike sorting to a `Recording` at a specific time

This temporal dimension isn't metadata—it's intrinsic to the entity. When you query `NeuralUnit`, you're not just retrieving data; you're accessing the outputs of a specific computational step in your workflow.

**Example from neuroscience pipeline:**
```
Session (manual entry)
    ↓
Recording (imported from instruments)
    ↓
FilteredRecording (computed: bandpass filtering)
    ↓
SpikeSorting (computed: spike detection algorithm)
    ↓
NeuronStatistics (computed: statistical analysis)
```

Each entity exists because a workflow step created it. `NeuronStatistics` isn't just associated with `SpikeSorting`—it was *derived from* it through a specific computation.

:::{note}
The Schema Design section provides formal syntax for declaring workflow entities and specifying their creation logic through `make()` methods. You'll see exactly how to implement tables that capture temporal and computational semantics.
:::

### Computational Dependencies: Beyond Foreign Keys

A **computational dependency** means "this data was computed FROM that data using a specific process." This is fundamentally different from—and stronger than—a foreign key relationship.

**Foreign key semantics:**
- `NeuralUnit` references `Recording`
- Meaning: These records are associated
- Enforcement: `Recording` must exist (referential integrity)
- Permitted: Update either independently

**Computational dependency semantics:**
- `NeuralUnit` is computed from `Recording`
- Meaning: `NeuralUnit` was derived by analyzing `Recording`
- Enforcement: `Recording` must exist AND `NeuralUnit` must be recomputed if `Recording` changes
- Constraint: Cannot UPDATE `NeuralUnit` without recomputation (immutability)

This distinction is crucial for scientific integrity. With foreign keys alone, you can:
1. Update `Recording` (fix an error)
2. Keep the old `NeuralUnit` (now computed from incorrect data)
3. Have a valid database (referential integrity maintained)
4. But invalid science (results don't match their inputs)

Computational dependencies prevent this by enforcing **computational validity**: if you change inputs, dependent outputs must be recomputed or deleted.

:::{note}
The Computations section shows how DataJoint enforces computational dependencies through the `populate()` mechanism and cascade operations. You'll see how the system automatically maintains computational validity as data evolves.
:::

### Workflow Steps: Organizing by Role

A **workflow step** represents a distinct phase where specific entity types are created. Scientific workflows naturally mix human operations (observations, decisions, quality assessments) with computational operations (signal processing, statistical analysis, image segmentation).

DataJoint makes this distinction explicit through **table tiers**, which determine both visual representation and operational behavior. The key distinction isn't truly "human vs. computational"—it's **explicit INSERT control vs. automatic workflow execution**.

### Directed Acyclic Graph (DAG): Ensuring Valid Execution

Computational dependencies form a **directed acyclic graph (DAG)**:

**Directed**: Dependencies point from inputs to outputs, showing information flow

**Acyclic**: No circular dependencies that would cause infinite loops

This structure provides critical guarantees:

1. **Deterministic execution order**: Topological sorting of the DAG determines a valid sequence for computing all results
2. **Parallel execution opportunities**: Independent branches can process simultaneously
3. **Resumable computation**: If execution fails, you can restart from any point without recomputing valid results
4. **Clear provenance**: Tracing backward through the DAG reveals the complete lineage of any result

**Why acyclic matters:**

Imagine if `FilteredRecording` depended on `SpikeSorting` and `SpikeSorting` depended on `FilteredRecording`. How would you compute either one? Which comes first? The circular dependency makes execution impossible.

DataJoint validates DAG structure during schema compilation, catching circular dependencies before they cause problems. This prevents entire classes of workflow errors that would be difficult to debug at runtime.

:::{note}
The Schema Design section shows how DataJoint validates DAG structure when you declare your schema. The Computations section explains how topological ordering determines execution sequence and enables parallel processing.
:::

### The Fundamental Shift

These four concepts work together to fundamentally reconceptualize what database schemas mean:

**Traditional View**: Schema defines data structure
- Tables store records
- Foreign keys relate records
- Queries retrieve records

**Workflow View**: Schema defines data structure + computational pipeline
- Tables represent workflow steps
- Dependencies specify computations
- Queries trace provenance

This isn't just different terminology—it's a different mental model that changes how you design, implement, and reason about databases for scientific computing.

## Key DataJoint Innovations

The Relational Workflow Model introduces several innovations that transform how we design and implement databases for scientific computing. This section introduces these concepts at a high level—enough to understand the paradigm shift. The Schema Design and Computations sections provide detailed syntax, implementation patterns, and operational mechanics.

### Mixing Manual and Automated Steps

Scientific workflows naturally combine human operations with computational operations. A researcher designs an experiment (human), instruments collect data (automated), algorithms process the data (automated), and experts interpret results (human).

Traditional databases treat all data the same way—whether manually entered or computed, it's just rows in tables. The workflow model makes the distinction explicit and enforces it systematically.

#### The Fundamental Split: Control of Population

DataJoint divides tables into two operational categories based on **who controls data insertion**:

**1. Explicitly Populated Tables (Manual and Lookup)**
- You write INSERT statements in your code
- You decide when and how data enters
- DataJoint never automatically populates these
- Typical uses: human observations, reference data, external imports

**2. Automatically Populated Tables (Imported and Computed)**
- You define `make()` methods specifying how to create entries
- DataJoint calls `make()` automatically when dependencies are satisfied
- You never directly INSERT (except within `make()`)
- Typical uses: data acquisition, signal processing, statistical analysis

This split isn't arbitrary—it reflects operational reality:

**What researchers control**: Which subjects to study, which experiments to run, which parameters to use, quality assessments and decisions

**What systems execute**: Import recordings from instruments, filter signals, detect events, compute statistics, generate visualizations

#### A Complete Example: Neuroscience Recording Pipeline

Consider a workflow for analyzing neural recordings:

**Manual steps (you INSERT explicitly):**
```python
# You decide which subjects and experiments
Subject.insert1({'subject_id': 'mouse_042', 'species': 'mus_musculus'})
Session.insert1({'session_id': 101, 'subject_id': 'mouse_042', 
                 'session_date': '2024-10-28'})
```

**Automated steps (DataJoint calls make()):**
```python
# You define how to import/process
@schema
class Recording(dj.Imported):
    definition = """
    -> Session
    ---
    recording_file: filepath
    """
    def make(self, key):
        # Import from instrument
        filepath = import_from_instrument(key)
        self.insert1({**key, 'recording_file': filepath})

@schema
class FilteredRecording(dj.Computed):
    definition = """
    -> Recording
    ---
    filtered_data: blob
    """
    def make(self, key):
        # Process the recording
        raw = (Recording & key).fetch1('recording_file')
        filtered = apply_filter(raw)
        self.insert1({**key, 'filtered_data': filtered})

# Execute the workflow
Recording.populate()         # DataJoint calls make() for each Session
FilteredRecording.populate() # DataJoint calls make() for each Recording
```

**The transformation**: Instead of remembering to run import scripts, then processing scripts, in the right order, for the right data—you define what should happen (`make()` methods), and DataJoint orchestrates execution automatically.

#### Why This Matters

**1. Explicit workflow structure**: Looking at table declarations, you immediately see what's manual vs. automatic

**2. Automatic dependency management**: DataJoint won't try to filter recordings before they're imported

**3. Reproducibility**: The `make()` methods are your processing logic—version controlled, documented, reproducible

**4. Parallel execution**: DataJoint can run multiple `make()` calls simultaneously on different workers

**5. Error handling**: Failed `make()` calls are tracked; you can retry without corrupting data

**6. Provenance**: You know exactly how each entry was created (either explicit INSERT or specific `make()` method)

The Schema Design section shows the exact syntax for declaring these table types and defining `make()` methods. The Computations section explains how `populate()` orchestrates workflow execution.

:::{admonition} See It In Action
:class: seealso

The **Research Lab** example (Examples section) shows a complete neuroscience workflow mixing manual experiment logging with automated data import and processing.

The **Fractals** example demonstrates a purely computational pipeline where all steps after initial parameter entry are automated.
:::

### Table Tiers: Organizing Workflow Roles

DataJoint formalizes the manual/automatic distinction through **table tiers**—a classification that determines both visual representation and operational behavior.

#### The Four Table Tiers

**Lookup Tables** - Reference data and parameters (Part of schema design)
- **Population**: Defined in `contents` attribute, populated at schema declaration
- **Typical content**: Species names, stimulus types, algorithm parameters, controlled vocabularies
- **When populated**: Automatically when schema is declared
- **Visual representation**: Gray rectangle
- **Example**: Species codes, measurement units, experimental conditions

**Manual Tables** - Human-controlled entry points
- **Population**: Explicit INSERT (you control)
- **Typical content**: Experimental sessions, subject information, quality assessments, expert decisions
- **When populated**: When humans perform actions or make observations
- **Visual representation**: Green rectangle
- **Example**: Recording sessions, behavioral annotations, equipment configurations

**Imported Tables** - Automated data acquisition
- **Population**: Automatic via `make()` (DataJoint controls)
- **Typical content**: Raw recordings, tracking data, external database imports, file metadata
- **When populated**: Automatically when upstream Manual/Lookup entries exist
- **Visual representation**: Blue oval
- **Example**: Neural recordings from electrophysiology rig, video files from cameras

**Computed Tables** - Automated processing
- **Population**: Automatic via `make()` (DataJoint controls)
- **Typical content**: Filtered signals, detected events, statistical analyses, derived results
- **When populated**: Automatically when upstream data exists
- **Visual representation**: Red oval
- **Example**: Spike-sorted neurons, motion-corrected videos, summary statistics

#### Visual Language: Shape and Color

The visual representation encodes operational behavior:

**Shape indicates population mechanism:**
- **Rectangle**: You write INSERT statements (Manual) or define contents (Lookup)
- **Oval**: DataJoint calls `make()` (Imported, Computed)

**Color indicates workflow role:**
- **Gray**: Reference/parameter data (Lookup - part of schema design)
- **Green**: Human-controlled entry (Manual - workflow operations)
- **Blue**: Automated acquisition (Imported - workflow automation)
- **Red**: Automated processing (Computed - workflow automation)

#### A Complete Workflow Visualization

```
┌──────────┐
│  Species │  [Lookup - Gray Rectangle] - Reference data
└─────┬────┘
      │
      ↓
┌──────────┐
│ Subject  │  [Manual - Green Rectangle] - Human enters subject info
└─────┬────┘
      │
      ↓
┌──────────┐
│ Session  │  [Manual - Green Rectangle] - Human logs experiment
└─────┬────┘
      │
      ↓
╭──────────╮
│Recording │  [Imported - Blue Oval] - Auto import from instrument
╰─────┬────╯
      │
      ↓
╭──────────╮
│ Filtered │  [Computed - Red Oval] - Auto signal processing
╰─────┬────╯
      │
      ↓
╭──────────╮
│  Spikes  │  [Computed - Red Oval] - Auto spike detection
╰─────┬────╯
```

**Reading this diagram:**
- Rectangles (Species, Subject, Session): You provide data explicitly
- Ovals (Recording, Filtered, Spikes): DataJoint calls `make()` automatically
- Gray: Reference information (schema design)
- Green: Where humans control the workflow (workflow operations)
- Blue → Red: Data flows from acquisition through processing

**One glance reveals:**
- Entry points: Where you need to provide data (rectangles)
- Automation: What happens automatically (ovals)
- Computational flow: Direction of data transformation (arrows)
- Workflow stages: Acquisition (blue) → Processing (red)

#### Choosing the Right Tier

**Use Lookup when**:
- Data is stable reference information defined at design time
- Values are reused across many other entities
- Content is part of schema design, not workflow operations
- Changes represent schema evolution, not data collection

**Use Manual when**:
- Humans perform the action (observation, decision, assessment)
- Data comes from external sources you control the timing of
- You need to decide when and what to insert
- Content grows with workflow execution

**Use Imported when**:
- Data acquisition is automated but depends on external sources
- Files need to be read or external systems queried
- Import logic is substantial (file parsing, API calls)
- The step involves acquisition rather than computation

**Use Computed when**:
- Results are derived purely from upstream database data
- Computation is deterministic (same inputs → same outputs)
- Processing is algorithmic (no human decision required)
- The step involves transformation rather than acquisition

The boundaries can be subtle. The key questions: "Who/what controls when this data is created?" If you do (via explicit INSERT), use Manual. If it's part of design (stable reference data), use Lookup. If the workflow does (via automatic execution), use Imported/Computed.

:::{admonition} See It In Action
:class: seealso

The **Sales** example shows a business workflow with mostly Manual tables (orders, customers) and a few Computed tables (order totals, monthly summaries).

The **Research Lab** example demonstrates all four tiers working together in a scientific workflow.

The **Allen CCF** example uses Lookup tables extensively for anatomical reference data.
:::

### Lookup Tables: Schema Design, Not Workflow Data

**Lookup tables** occupy a unique position in DataJoint: they're populated as part of **schema design**, not during workflow execution. This fundamental distinction separates them from all other table tiers.

#### The Key Distinction: Design vs. Operation

**All other tables** (Manual, Imported, Computed):
- Populated during workflow operations
- Content changes as research progresses
- Represent dynamic, evolving data
- Empty database → populated through use

**Lookup tables**:
- Populated as part of schema declaration
- Content defined in the table class itself
- Represent static reference information
- Empty database → lookup tables already populated

When you declare a schema for a new database instance, lookup tables are populated immediately. The database is still considered "empty" for workflow purposes—no subjects, no sessions, no experiments—but all lookup tables contain their reference data.

#### Declaration Pattern: The `contents` Attribute

Unlike other tables where you use `insert()` to add data, lookup tables define their contents directly in the class:

```python
@schema
class Species(dj.Lookup):
    definition = """
    species: varchar(32)   # standard species code
    ---
    common_name: varchar(64)
    scientific_name: varchar(128)
    """
    
    # Contents defined as part of schema design
    contents = [
        {'species': 'mouse', 'common_name': 'House mouse',
         'scientific_name': 'Mus musculus'},
        {'species': 'rat', 'common_name': 'Norway rat',
         'scientific_name': 'Rattus norvegicus'},
        {'species': 'human', 'common_name': 'Human',
         'scientific_name': 'Homo sapiens'}
    ]
```

The `@schema` decorator:
1. Creates the table in the database
2. Populates it from the `contents` attribute
3. Ensures contents stay synchronized across instances

#### What Belongs in Lookup Tables

Lookup tables contain information that is:

**1. Part of design, not observations**
- Species codes (defined before experiments begin)
- Measurement units (standardized values)
- Experimental condition types (designed protocol options)
- Algorithm parameter sets (analysis design choices)

**2. Stable reference data**
- Changes rarely (months/years, not days/weeks)
- Updated as part of schema evolution, not daily operations
- Same across all database instances using this schema

**3. Controlled vocabularies**
- Prevents typos and inconsistencies
- Ensures everyone uses the same codes
- Provides semantic meaning to identifiers

**4. Community standards**
- Brain region atlases (Allen CCF)
- Gene nomenclature (official symbols)
- Language codes (ISO 639)
- Country codes (ISO 3166)

#### Examples from Different Domains

**Neuroscience - Brain Regions (Allen CCF)**
```python
@schema
class BrainRegion(dj.Lookup):
    definition = """
    region_id: int           # Allen CCF structure ID
    ---
    acronym: varchar(32)
    name: varchar(255)
    parent_id: int          # hierarchical structure
    color_hex: varchar(7)   # visualization color
    """
    
    contents = [
        (997, 'root', 'Root', 0, '#FFFFFF'),
        (688, 'OLF', 'Olfactory areas', 997, '#A9A9A9'),
        (315, 'HPF', 'Hippocampal formation', 997, '#FF0000'),
        # ... more regions from Allen CCF
    ]
```

**Education - Letter Grades**
```python
@schema
class LetterGrade(dj.Lookup):
    definition = """
    grade_letter: char(2)
    ---
    grade_point: decimal(3,2)
    """
    
    contents = [
        ('A', 4.00),
        ('A-', 3.67),
        ('B+', 3.33),
        ('B', 3.00),
        # ... full grading scale
    ]
```

**Signal Processing - Filter Parameters**
```python
@schema
class FilterParams(dj.Lookup):
    definition = """
    filter_id: int
    ---
    filter_type: enum('bandpass', 'lowpass', 'highpass')
    low_cutoff: float   # Hz
    high_cutoff: float  # Hz
    order: int
    """
    
    contents = [
        (1, 'bandpass', 300, 3000, 4),
        (2, 'bandpass', 500, 5000, 4),
        (3, 'lowpass', 0, 5000, 2),
        # ... predefined filter configurations
    ]
```

#### Lookup vs. Manual: A Critical Distinction

The line between Lookup and Manual can seem subtle, but the distinction matters:

**Use Lookup when**:
- Values are defined as part of experimental/analysis design
- Content is stable and rarely changes
- Same values used across many database instances
- Changes represent schema evolution, not data collection

**Use Manual when**:
- Values are observations or decisions made during operations
- Content grows continuously with workflow execution
- Each database instance has unique content
- Changes represent ongoing research activity

**Example: Experimental Protocols**

```python
# Lookup: Protocol types (design-time decision)
@schema
class ProtocolType(dj.Lookup):
    definition = """
    protocol_type: varchar(32)
    ---
    description: varchar(255)
    """
    contents = [
        ('visual_tuning', 'Measure orientation/direction selectivity'),
        ('spontaneous', 'Spontaneous activity recording'),
        ('optogenetic', 'Light-evoked responses')
    ]

# Manual: Specific protocol instances (operation-time data)
@schema
class Protocol(dj.Manual):
    definition = """
    protocol_id: int
    -> ProtocolType
    ---
    parameters: longblob
    created_date: date
    created_by: varchar(64)
    """
```

The protocol *types* are design decisions (Lookup). Specific protocol *instances* with particular parameters are workflow data (Manual).

#### Updating Lookup Tables: Schema Evolution

Although technically you can modify lookup table contents after initial population, **this should be rare** and treated as schema evolution:

```python
# Adding a new species (schema evolution)
Species.insert1({
    'species': 'zebrafish',
    'common_name': 'Zebrafish',
    'scientific_name': 'Danio rerio'
})
```

**When to update lookup tables**:
- Adding new reference values to support new research directions
- Correcting errors in standard reference data
- Incorporating updated community standards (new brain atlas version)
- Expanding controlled vocabularies

**When NOT to update lookup tables**:
- During normal workflow operations
- Frequently (daily/weekly)
- Differently across database instances

Frequent updates suggest the table should be Manual, not Lookup.

#### Benefits of the Lookup Pattern

**1. Schema portability**: Copy the schema code to a new database → lookup tables automatically populated

**2. Version control**: Lookup table contents are in your code repository, versioned with your schema

**3. Consistency across instances**: All databases using this schema have identical reference data

**4. Clear separation**: Design-time decisions (lookups) distinct from runtime data (manual/imported/computed)

**5. Documentation**: Lookup contents document valid values directly in the schema code

**6. Referential integrity**: Other tables reference lookups, ensuring only valid values are used

:::{admonition} See It In Action
:class: seealso

The **Languages** example demonstrates ISO 639-1 codes and CEFR levels as lookup tables.

The **Allen CCF** example shows incorporating a complete hierarchical brain atlas as interconnected lookup tables.

The **University** example uses lookup tables for academic departments and degree programs.

The **Elements** example (Schema Design section) includes the complete periodic table as a lookup table with 60+ elements.
:::

:::{note}
The Schema Design section provides complete syntax for declaring lookup tables, including how to structure the `contents` attribute for different data types, how to handle NULL values, and patterns for hierarchical lookups (like brain region hierarchies).
:::

### Workflow Execution: populate() and make()

The workflow model's power comes from **automatic execution**—DataJoint determines what needs computing and orchestrates the work.

#### The Two-Method Pattern

For Imported and Computed tables, you define two things:

**1. Table Definition** - What data to store
```python
@schema
class FilteredRecording(dj.Computed):
    definition = """
    -> Recording
    ---
    filtered_data: blob
    filter_params: varchar(255)
    """
```

**2. make() Method** - How to create entries
```python
    def make(self, key):
        # Fetch upstream data
        raw = (Recording & key).fetch1('recording_file')
        
        # Perform computation
        filtered = apply_bandpass_filter(raw, 300, 3000)
        
        # Insert result
        self.insert1({
            **key,
            'filtered_data': filtered,
            'filter_params': 'bandpass_300-3000Hz'
        })
```

#### How populate() Works

When you call `populate()`, DataJoint:

1. **Identifies missing work**: Which upstream entries don't have corresponding downstream entries?
2. **Checks dependencies**: Are all required dependencies satisfied?
3. **Calls make()**: For each missing entry with satisfied dependencies
4. **Tracks results**: Success → mark complete; Failure → log error
5. **Repeats**: Continue until all possible work is done

**Example:**

```python
# You've inserted 10 new Sessions
Session.insert(new_sessions)

# Execute the workflow
Recording.populate()         # Imports recordings for all 10 sessions
FilteredRecording.populate() # Filters all recordings
SpikeSorting.populate()      # Sorts spikes in all filtered recordings
NeuronStats.populate()       # Computes stats for all detected neurons
```

DataJoint automatically:
- Processes sessions in any order (they're independent)
- Skips sessions where recordings already exist
- Handles errors (logs failures, continues with others)
- Can parallelize across multiple workers

#### The make() Method Contract

Your `make()` method receives a `key` dictionary identifying which entry to create:

```python
def make(self, key):
    # key = {'session_id': 101} for example
    
    # 1. Fetch upstream data using the key
    data = (UpstreamTable & key).fetch1()
    
    # 2. Perform your computation
    result = process(data)
    
    # 3. Insert exactly one entry with this key
    self.insert1({**key, 'result': result})
```

**Rules**:
- Must fetch data using the provided key
- Must insert exactly one entry matching that key
- Should be deterministic (same inputs → same outputs)
- Should handle errors gracefully (raise exceptions, don't insert partial results)

#### Error Handling

If `make()` raises an exception:
- DataJoint catches it and logs the error
- No partial data is inserted (transaction rolled back)
- Other entries continue processing
- You can retry failed entries later

```python
# Retry failed computations
FilteredRecording.populate(reserve_jobs=True)

# See what failed
FilteredRecording.populate(display_progress=True)
```

#### Parallel Execution

DataJoint can run multiple `make()` calls simultaneously:

```python
# Run on 4 parallel workers
FilteredRecording.populate(reserve_jobs=True, processes=4)
```

This works safely because:
- Each `make()` call processes one independent key
- Database transactions prevent conflicts
- Job reservation prevents duplicate work

#### Progressive Execution

You don't need to populate the entire pipeline at once:

```python
# Import recordings, process later
Recording.populate()

# Some time later, after verifying imports look good
FilteredRecording.populate()

# Even later, after adjusting spike sorting parameters
SpikeSorting.populate()
```

The workflow executes progressively, always maintaining consistency—no downstream entry exists without its upstream dependencies.

#### When to Call populate()

**Typical patterns**:

**Manual trigger**: After inserting new manual data
```python
Session.insert(new_sessions)
Recording.populate()  # Process new sessions
```

**Scheduled execution**: Cron job or scheduled task
```python
# Every hour, process any new data
pipeline.populate_all()  # Populate all tables in order
```

**Interactive development**: During analysis
```python
# Add a new analysis, compute for existing data
NeuronStats.populate()
```

**Continuous processing**: Long-running worker
```python
# Worker continuously checks for new work
while True:
    Recording.populate(reserve_jobs=True, processes=4)
    time.sleep(60)
```

#### The Transformation

**Before DataJoint**: "Let me check which sessions don't have processed data... run import_script.py with these IDs... wait for it to finish... check for errors... now run filter_script.py..."

**With DataJoint**: "`populate()` and DataJoint handles everything—finds missing work, executes in order, handles errors, parallelizes, and tracks progress."

The Computations section provides detailed coverage of `populate()` mechanics, error handling strategies, parallel execution patterns, and monitoring tools.

:::{admonition} See It In Action
:class: seealso

The **Fractals** example demonstrates a computational pipeline with multiple stages of automatic processing.

The **Research Lab** example shows typical interactive use of `populate()` during research.
:::

### Diagramming Notation: Visual Workflow Language

DataJoint diagrams are not just documentation—they're **visual representations of executable specifications**. The notation encodes both structure and operational behavior.

#### Basic Elements

**Tables (Nodes)**

Shape indicates population mechanism:
```
┌──────────┐
│ Manual   │  Rectangle = Explicit INSERT or contents attribute
│  Table   │
└──────────┘

╭──────────╮
│Automatic │  Oval = Automatic via make()
│  Table   │
╰──────────╯
```

Color indicates workflow role:
```
┌──────────┐
│  Lookup  │  Gray = Reference data (schema design)
└──────────┘

┌──────────┐
│  Manual  │  Green = Human-controlled entry (workflow operations)
└──────────┘

╭──────────╮
│ Imported │  Blue = Automated acquisition (workflow automation)
╰──────────╯

╭──────────╮
│ Computed │  Red = Automated processing (workflow automation)
╰──────────╯
```

**Dependencies (Edges)**

Arrows show workflow dependencies:
```
┌─────────┐
│ Session │
└────┬────┘
     │
     ↓        Solid arrow = Required dependency
╭──────────╮  (foreign key, NOT NULL)
│Recording │
╰──────────╯

┌─────────┐
│ Session │
└────┬────┘
     ╎
     ↓        Dashed arrow = Optional dependency
╭──────────╮  (foreign key, nullable)
│Recording │
╰──────────╯
```

#### Reading Dependencies

**Dependency direction**: Arrow points from upstream to downstream
- Upstream: Must exist first
- Downstream: Depends on upstream

**Multiple dependencies**: Convergence point
```
┌─────────┐     ┌──────────┐
│ Session │     │ Protocol │
└────┬────┘     └────┬─────┘
     │               │
     └───────┬───────┘
             ↓
      ╭──────────╮
      │Recording │
      ╰──────────╯
```
Recording depends on both Session and Protocol.

**Branching dependencies**: One source, multiple dependents
```
      ┌─────────┐
      │Recording│
      └────┬────┘
           │
      ┌────┴────┐
      │         │
      ↓         ↓
╭──────────╮ ╭──────────╮
│ Filtered │ │ Tracking │
╰──────────╯ ╰──────────╯
```
Both Filtered and Tracking depend on Recording.

#### Complete Workflow Example

```
        ┌──────────┐
        │  Species │ [Lookup - Reference]
        └─────┬────┘
              │
              ↓
        ┌──────────┐
        │ Subject  │ [Manual - Human entry]
        └─────┬────┘
              │
        ┌─────┴─────┐
        │           │
        ↓           ↓
  ┌──────────┐ ┌──────────┐
  │ Session  │ │Genotype  │ [Manual - Human entry]
  └─────┬────┘ └──────────┘
        │
        ↓
  ╭──────────╮
  │Recording │ [Imported - From instrument]
  ╰─────┬────╯
        │
        ↓
  ╭──────────╮
  │ Filtered │ [Computed - Signal processing]
  ╰─────┬────╯
        │
        ↓
  ╭──────────╮
  │  Spikes  │ [Computed - Event detection]
  ╰─────┬────╯
        │
        ↓
  ╭──────────╮
  │  Units   │ [Computed - Clustering]
  ╰──────────╯
```

**Reading this diagram:**

**Data entry points** (rectangles):
- Species: Reference data (setup once)
- Subject, Session, Genotype: Human-controlled entry

**Automated pipeline** (ovals):
- Recording: Auto-import when Session exists
- Filtered → Spikes → Units: Automatic processing chain

**Workflow execution**:
1. Insert Species (reference data)
2. Insert Subjects with their Species
3. Insert Sessions and Genotypes for Subjects
4. Call `populate()`: Recording → Filtered → Spikes → Units executes automatically

**Dependencies**:
- Subject requires Species (controlled vocabulary)
- Session and Genotype require Subject (which animal?)
- Recording requires Session (when was data collected?)
- Each processing step requires its immediate upstream

#### Advanced Notation

**Master-Part Relationships** (covered in next section):
```
┌──────────┐
│ Session  │ [Master]
└─────┬────┘
      │
      ↓
╔═════════════╗
║Session.Trial║ [Part - Bold outline]
╚═════════════╝
```
Bold outline indicates part table (group integrity).

**Self-References**:
```
┌──────────┐
│BrainRegion│
│    ⟲     │ [Arrow pointing back to self]
└──────────┘
```
Self-reference for hierarchical structures.

#### Generating Diagrams

DataJoint generates diagrams automatically from your schema:

```python
import datajoint as dj
schema = dj.Schema('my_database')

# Diagram of entire schema
dj.Diagram(schema)

# Diagram of specific table and dependencies
dj.Diagram(FilteredRecording)

# Diagram with depth control
dj.Diagram(FilteredRecording).draw(max_width=3)
```

The diagrams are always synchronized with the actual schema—they can't become outdated documentation.

#### Why Visual Language Matters

**1. Immediate comprehension**: One glance shows workflow structure

**2. Design validation**: Spot problems (circular dependencies, missing steps) visually

**3. Communication**: Non-programmers can understand the workflow

**4. Documentation**: Diagrams are always current (generated from live schema)

**5. Debugging**: Trace data flow visually when investigating issues

**6. Onboarding**: New team members understand the system quickly

The visual notation isn't decorative—it's a **formal language encoding operational behavior**. Shape, color, and arrows directly determine how DataJoint executes your workflow.

:::{admonition} See It In Action
:class: seealso

All examples in the Examples section include complete workflow diagrams showing the notation in practice.

The **Research Lab** example demonstrates a typical neuroscience workflow diagram.

The **Allen CCF** example shows how hierarchical lookups are diagrammed.
:::

### Master-Part Relationships: Managing Group Integrity

Some entities naturally consist of multiple parts that form a cohesive group. A Session consists of Trials. A Survey consists of Questions. An Experiment consists of Conditions.

**Master-part relationships** provide a formal mechanism for maintaining the integrity of these grouped entities.

#### The Problem: Group Integrity

Consider experimental trials within a session:

**Naive approach** (separate tables):
```python
@schema
class Session(dj.Manual):
    session_id: int
    session_date: date

@schema
class Trial(dj.Manual):
    -> Session
    trial_id: int
    ---
    outcome: enum('success', 'failure')
```

**Problem**: If you delete a Session, what happens to its Trials?
- With `CASCADE`: Trials delete automatically (might be desired)
- Without `CASCADE`: Can't delete Session with existing Trials (might be too restrictive)
- Either way, Trials have independent existence from Session

But conceptually, **Trials don't have independent existence**—they're parts of a Session. A Session without Trials is incomplete; Trials without a Session are meaningless.

#### The Solution: Master-Part Pattern

DataJoint formalizes grouped entities through **part tables**:

```python
@schema
class Session(dj.Manual):
    session_id: int
    ---
    session_date: date
    
    class Trial(dj.Part):
        definition = """
        -> master
        trial_id: int
        ---
        outcome: enum('success', 'failure')
        """
```

**Key properties**:

**1. Nested declaration**: `Trial` is declared inside `Session` class

**2. `-> master` dependency**: Part automatically inherits master's primary key

**3. Group integrity**: Can't have parts without master; deleting master deletes all parts

**4. Visual distinction**: Part tables shown with bold outline in diagrams

#### When to Use Master-Part

Use master-part when:

**1. Exclusive ownership**: Parts belong exclusively to one master
- Trials belong to exactly one Session
- Survey Questions belong to exactly one Survey
- Experimental Conditions belong to exactly one Experiment

**2. Simultaneous creation/deletion**: Parts are created and removed with master
- Deleting a Session should delete its Trials
- Deleting a Survey should delete its Questions

**3. No independent meaning**: Parts don't make sense without their master
- A Trial without knowing which Session it belongs to is meaningless
- A Question without knowing which Survey it's part of lacks context

**4. Repeated structure**: Multiple instances of the same structure pattern
- Every Session has Trials (same structure, different data)
- Every Survey has Questions (same structure, different content)

#### Example: Multi-Site Recording

A recording session with multiple probe sites:

```python
@schema
class Session(dj.Manual):
    session_id: int
    ---
    session_date: date
    
    class Probe(dj.Part):
        definition = """
        -> master
        probe_id: int
        ---
        brain_region: varchar(32)
        depth: float  # mm
        """

@schema
class Recording(dj.Imported):
    definition = """
    -> Session
    ---
    recording_file: filepath
    """
    
    class Channel(dj.Part):
        definition = """
        -> master
        -> Session.Probe
        channel_id: int
        ---
        signal: longblob
        """
```

**Structure**:
- Each Session has multiple Probes (master-part)
- Each Recording has multiple Channels (master-part)
- Channels reference which Probe they came from

**Integrity guarantees**:
- Can't create Probes without a Session
- Can't create Channels without a Recording
- Deleting a Session deletes all its Probes
- Deleting a Recording deletes all its Channels

#### Querying Master-Part

Access parts through the master:

```python
# Get all trials for session 101
trials = (Session.Trial & {'session_id': 101}).fetch()

# Count trials per session
trial_counts = Session.Trial.aggr(Session, n='count(*)')

# Get sessions with more than 100 trials
busy_sessions = Session & (Session.Trial.aggr(Session, n='count(*)') & 'n > 100')
```

The part table includes the master's primary key automatically, so joins work naturally.

#### Visual Representation

In diagrams, part tables have bold outlines:

```
┌──────────┐
│ Session  │ [Master]
└─────┬────┘
      │
      ↓
╔═════════════╗
║Session.Trial║ [Part - Bold outline]
╚═════════════╝
```

The bold outline signals: "This has special group integrity with its master."

#### Master-Part vs. Regular Dependencies

**Use master-part when**:
- Parts are owned exclusively by master
- Parts have no meaning without master
- Create/delete together

**Use regular foreign key when**:
- Entities have independent existence
- Many-to-many relationships possible
- Entities might outlive their references

**Example**:
```python
# Master-part: Trials belong exclusively to Session
class Session(dj.Manual):
    class Trial(dj.Part):
        ...

# Regular dependency: Session references Subject (many Sessions per Subject)
class Session(dj.Manual):
    -> Subject  # Foreign key, not part table
    ...
```

#### Benefits of Master-Part

**1. Group integrity**: Master and parts stay synchronized automatically

**2. Clearer semantics**: Code explicitly shows grouping relationships

**3. Simplified deletion**: Delete master, parts go automatically

**4. Better organization**: Related tables grouped in code structure

**5. Documentation**: Visual distinction in diagrams makes structure obvious

The Schema Design section shows the complete syntax for declaring part tables, including advanced patterns like parts of computed tables and multi-level hierarchies.

:::{admonition} See It In Action
:class: seealso

The **Research Lab** example uses master-part for Session.Trial relationships.

The **University** example demonstrates master-part for Course.Section and Course.Prerequisite.

The **Fractals** example shows computational tables with parts (Fractal.Image and Fractal.Analysis).
:::

## Relationships Emerge from Workflow Convergence

One of the most elegant aspects of the Relational Workflow Model is how it handles relationships between entities. Unlike traditional Entity-Relationship modeling, which requires explicit notation and concepts for relationships, **DataJoint allows relationships to emerge naturally from the convergence of workflows**.

This approach eliminates the artificial distinction between entities and relationships that has long complicated database design, while preserving full expressiveness.

### The Traditional ERM Approach

In classical Entity-Relationship modeling, you explicitly identify three distinct concepts:

**Example: Language proficiency**
- **Entities**: Person, Language
- **Relationship**: "SpeaksLanguage" (connecting Person to Language)
- **Cardinality**: Many-to-many (one person speaks multiple languages; one language is spoken by multiple people)
- **Attributes of relationship**: Proficiency level, certification date

The implementation typically requires:
1. Person table
2. Language table
3. Junction table (PersonLanguage) representing the relationship

The relationship is a separate concept that must be explicitly modeled, diagrammed, and implemented.

### The Workflow Approach

DataJoint takes a fundamentally different approach. Instead of treating `Proficiency` as an artificial junction table representing a relationship, **it represents the actual workflow step** of assessing or recording language proficiency.

```python
# Workflow thinking
@schema
class Person(dj.Manual):
    person_id: int
    name: str
    
@schema
class Language(dj.Lookup):
    language: str
    language_family: str

@schema
class Proficiency(dj.Manual):
    -> Person
    -> Language
    ---
    level: enum('beginner', 'intermediate', 'advanced', 'native')
    assessed_date: date
```

**What's happening conceptually:**

`Proficiency` isn't an artificial construct to represent the relationship between Person and Language. It's a genuine workflow step: "Record a person's proficiency in a language."

This step naturally requires:
- Which person? (→ Person)
- Which language? (→ Language)
- What level? (proficiency attributes)
- When assessed? (temporal information)

The many-to-many relationship between Person and Language **emerges** from this workflow step. You don't model it separately—it exists because there's a concrete workflow operation that involves both entities.

### Expressiveness: Nothing Is Lost

Can you express the same information as traditional ERM? Absolutely.

**Cardinality**: The foreign keys capture exactly the same constraints
- Person can have multiple Proficiency entries (one person, many languages)
- Language can have multiple Proficiency entries (one language, many people)
- Many-to-many relationship is implicit in the structure

**Optionality**:
- If proficiency is required: Foreign keys are NOT NULL (default)
- If proficiency is optional: Foreign keys are nullable (explicit)

**Relationship attributes**:
- Level, assessed_date, etc. are attributes of the Proficiency table
- Same as traditional junction table attributes

**Additional semantics**:
- When was this proficiency recorded? (temporal)
- How was it assessed? (could add assessment_method)
- Who verified it? (could add -> Assessor)

The workflow model expresses everything ERM does, plus computational and temporal semantics ERM cannot capture.

### Querying Relationships Naturally

When you want to query the relationship, you simply query the convergence point:

```python
# "Show me all people who speak French"
Person * Proficiency & {'language': 'French'}

# "Show me all languages spoken by this person"
Language * Proficiency & {'person_id': 42}

# "Show me native speakers of Romance languages"
Person * Proficiency * Language & 'level="native"' & 'language_family="Romance"'
```

The system understands these entities are related through the workflow and joins them appropriately. You don't need to specify join conditions or worry about ambiguous column names—the workflow structure defines valid paths through the data.

### When Relationships Aren't Workflow Steps

What if you have a true static relationship with no workflow semantics?

**Example**: A person has a birth country. There's no "workflow step" here—it's just a fact.

```python
@schema
class Person(dj.Manual):
    person_id: int
    -> Country  # Foreign key to Country table
    name: str
    birth_date: date
```

This is perfectly valid in the workflow model. The foreign key expresses a relationship without implying computation. Person is a Manual table (human-entered data), and the relationship to Country is just part of the Person entity's attributes.

**The workflow model doesn't force everything to be computational**—it accommodates both static relationships (as in traditional ERM) and computational dependencies (new capability).

### The Elegant Result

By viewing relationships as workflow convergence points rather than separate artifacts:

1. **Simpler conceptual model**: One fewer concept to track (no "relationship" as separate thing)
2. **Natural workflow expression**: Junction tables have meaning beyond "these things are related"
3. **Full ERM expressiveness**: All cardinality, optionality, and attributes preserved
4. **Added workflow semantics**: Temporal and computational context when it exists
5. **Cleaner queries**: Follow workflow paths instead of specifying arbitrary joins

The workflow model **subsumes** entity-relationship thinking. Everything you could express in ERM, you can express here—with the added power to capture computational dependencies when they matter.

This is not a tradeoff or alternative approach. It's a generalization that reduces to traditional ERM when computational semantics aren't needed, and extends beyond it when they are.

## The DataJoint Implementation: Theory Made Practical

**DataJoint** represents the practical embodiment of the Relational Workflow Model, developed over a decade of neuroscience research.

### The Schema as Executable Specification

The Relational Workflow Model introduces a profound shift in perspective: the database schema itself becomes an executable specification of your workflow. This represents a fundamental departure from traditional database design, where conceptual modeling, implementation, and documentation are separate activities requiring translation between different representations.

When you define a DataJoint schema, you accomplish four critical tasks simultaneously:

**1. Design the conceptual model**: Identify what workflow steps exist in your domain

**2. Implement the database structure**: Define tables, attributes, and foreign keys that capture these workflow steps

**3. Specify the computations**: Define `make()` methods that specify how each workflow step transforms its inputs into outputs

**4. Document the pipeline**: The schema itself serves as the complete documentation of your workflow

This unified approach eliminates the traditional separation between conceptual design and implementation. Rather than drawing an ER diagram and then translating it into SQL tables—a process prone to errors and inconsistencies—you write a schema that directly expresses both the conceptual model and its implementation. When you generate a diagram, it's derived from the actual working schema, ensuring that your documentation is never out of sync with your implementation.

### Table Tiers: Workflow Roles Made Explicit

DataJoint's four table tiers (Lookup, Manual, Imported, Computed) aren't just organizational conveniences—they fundamentally shape how you think about data flow and responsibility within your system.

This tiered structure creates a natural dependency hierarchy that reflects the logical flow of information through your workflow. Computed tables depend on imported or manual tables for their input data, which in turn may depend on lookup tables for reference information. This creates a directed acyclic graph (DAG) that makes the workflow structure explicit and prevents circular dependencies that could lead to infinite loops or logical inconsistencies.

The visual representation of this structure through color-coded diagrams provides immediate insight into your workflow. At a glance, you can see where data enters your system and trace how it flows through each processing step.

### Immutability and Computational Validity

The Relational Workflow Model introduces a crucial distinction between transactional consistency and computational validity that fundamentally changes how we think about data integrity.

Traditional databases focus primarily on transactional consistency, ensuring that concurrent updates don't corrupt data through mechanisms like locking and isolation. While this is essential for preventing race conditions, it doesn't address a deeper problem that arises in computational workflows: ensuring that downstream results remain consistent with their upstream inputs.

DataJoint addresses this challenge through its approach to immutability and cascade operations. When you delete an entity in DataJoint, the system doesn't simply remove that single record—it cascades the delete to all dependent entities throughout the workflow. This behavior isn't just cleanup; it's enforcing computational validity by recognizing that if the inputs are gone, any results based on those inputs become meaningless and must be removed.

The process of correcting data illustrates this principle beautifully. When you discover an error in upstream data, you don't simply update the problematic record. Instead, you delete the entire downstream pipeline that was computed from the incorrect data, reinsert the corrected data, and then recompute the entire dependent chain. This ensures that every result in your database represents a consistent computation from valid inputs.

The `populate()` operation embodies this workflow philosophy perfectly. Rather than requiring you to manually track dependencies and orchestrate computations, your schema defines what needs to be computed, and DataJoint figures out how to execute it. The system identifies missing work, computes results in the correct order, and maintains integrity throughout the process—all while supporting parallel execution and resumable computation for efficiency.

### Query Algebra with Workflow Semantics

The Relational Workflow Model transforms query formation from a low-level table manipulation exercise into a high-level workflow navigation process.

DataJoint queries operate at a fundamentally different level of abstraction. Rather than manipulating tables directly, queries are defined with respect to workflow semantics, where operations understand the entity types and dependencies declared in your schema. This workflow-aware approach enables a remarkably elegant solution: just five operators provide a complete query algebra that handles all the complexity of scientific data analysis.

The five core operators each serve distinct workflow purposes:
- **Restriction (`&`)**: Filters entities based on conditions
- **Join (`*`)**: Combines entities from converging workflow paths
- **Projection (`.proj()`)**: Selects and computes attributes
- **Aggregation (`.aggr()`)**: Summarizes across entity groups
- **Union**: Combines entities from parallel workflow branches

These operators maintain algebraic closure, meaning they take entity sets as inputs and produce entity sets as outputs, enabling arbitrary composition of complex queries. More importantly, they preserve entity integrity—query results remain valid entity sets rather than arbitrary row collections.

The workflow-aware nature of these operators eliminates many of the pitfalls that plague traditional SQL queries. Unlike SQL's natural joins that can produce unexpected results when tables share column names coincidentally, DataJoint operators respect the dependency structure declared in your schema.

### Practical Benefits

The Relational Workflow Model delivers a comprehensive set of advantages that address the fundamental challenges that have plagued database design and implementation for decades.

The most immediate benefit is the seamless integration between design and implementation. There's no conceptual gap between how you think about your workflow and how you express it in code. Queries naturally express entity relationships because the query language operates on the same conceptual framework as your schema design.

The workflow integrity provided by the DAG structure prevents circular dependencies and ensures valid operation sequences, eliminating entire classes of errors that can occur in traditional database designs. Data consistency is maintained through immutable workflow artifacts that preserve the integrity of computational results. This immutability approach naturally preserves scientific provenance, creating a complete audit trail of how results were generated without requiring additional tracking systems.

Perhaps most importantly, the Relational Workflow Model enables effective collaborative development. Researchers without database expertise can contribute meaningfully to data pipelines because the workflow semantics map directly to their domain understanding. The computational validity ensures that downstream results remain consistent with upstream inputs, while automatic pipeline execution means that your schema defines what needs to be computed, and DataJoint figures out how to execute it efficiently.

## Why the Relational Workflow Model Matters

The mathematical rigor of relational theory might seem abstract, but it provides precisely what scientific research needs: **a formal framework for ensuring data integrity and enabling complex queries**.

### The Scientific Case for Relational Databases

**Data Integrity Through Constraints**: Referential integrity prevents orphaned data and inconsistent relationships—critical when each data point represents hours of expensive experiments or computation. Foreign keys ensure that relationships between entities remain valid, primary keys guarantee uniqueness, and data type constraints prevent invalid values from entering the system.

Think of integrity constraints as quality control checks that happen automatically, constantly, for every data operation. Unlike metadata-based approaches where integrity relies on everyone following conventions, schema-enforced integrity is guaranteed by the system.

**Declarative Queries**: SQL's declarative nature means you specify *what* you want, not *how* to get it. This maps naturally to scientific questions: "Show me all neurons with firing rate > 10Hz" rather than writing loops and conditionals. The database optimizer determines the most efficient execution plan, freeing you to focus on your scientific questions rather than implementation details.

**Mathematical Foundation Enables Optimization**: Query optimizers can automatically find efficient execution plans because the mathematical properties of relational algebra enable formal reasoning about query equivalence. Two queries that ask for the same data can be proven mathematically equivalent, allowing the system to choose the fastest approach.

**Structured Flexibility**: Schemas can evolve as your understanding grows. Unlike rigid file formats, databases allow controlled schema evolution while maintaining integrity. You can add new tables, modify existing structures, and migrate data systematically.

**Concurrent Access and Consistency**: Multiple researchers can work with the same data simultaneously without conflicts. The database ensures that everyone sees a consistent view of the data, handles concurrent updates safely through transactions, and prevents race conditions that could corrupt your results.

**Scalability**: Relational databases can handle datasets from megabytes to petabytes. As your research grows, the database scales with you, maintaining performance through indexing, query optimization, and efficient storage management.

### From Theory to Practice: The DataJoint Extension

Traditional relational databases excel at storage and retrieval but weren't designed for the computational workflows central to research. The Relational Workflow Model extends relational theory with workflow semantics—turning your database schema into an executable specification of your scientific pipeline while preserving all the benefits of relational rigor.

The key insight: Your database schema becomes your workflow specification. Tables represent workflow steps, foreign keys express computational dependencies, and the system ensures that results remain valid as data evolves. This transforms databases from passive storage systems into active workflow managers that understand the computational nature of scientific work.

DataJoint doesn't abandon relational theory—it extends it. All of Codd's mathematical foundations remain:
- Relations as sets of tuples
- Relational algebra operations
- Referential integrity through foreign keys
- Declarative queries

But DataJoint adds new layers:
- **Table tiers** that distinguish manual, imported, and computed data
- **Computational dependencies** captured in the schema
- **Automatic populate() operations** that maintain workflow validity
- **Immutability as default** preserving provenance
- **Schema as workflow specification** making dependencies explicit

The result is a system with the mathematical rigor of relational databases plus the workflow awareness that scientific computing requires.

### Backward Compatibility: Static Domains Still Work

An important property of the Relational Workflow Model: **it doesn't force workflow thinking on domains where it doesn't apply**.

Consider a traditional business database: Customers, Orders, Products, and OrderItems. There's minimal computational workflow here—mostly static entities and relationships:

```python
@schema
class Customer(dj.Manual):
    customer_id: int
    name: str
    email: str

@schema
class Product(dj.Lookup):
    product_id: int
    name: str
    price: decimal

@schema
class Order(dj.Manual):
    order_id: int
    -> Customer
    order_date: date

@schema
class OrderItem(dj.Manual):
    -> Order
    -> Product
    quantity: int
```

This is perfectly valid workflow model usage. It's essentially traditional ERM:
- **Entities**: Customer, Product, Order, OrderItem
- **Relationships**: Customer has Orders (one-to-many), Order contains Products (many-to-many via OrderItem)
- **Cardinality**: Expressed through foreign keys exactly as in traditional databases

The workflow model adds:
- Temporal awareness: When was this order created? (order_date plus system timestamps)
- Tier classification: Manual (human-entered), Lookup (reference data)
- Immutability preference: Orders aren't typically updated after creation anyway

But if you need traditional UPDATE semantics (e.g., correcting a customer's email), DataJoint supports that for Manual tables where it makes sense.

**The workflow model reduces to traditional ERM plus temporal awareness when computational semantics aren't needed.** You can use DataJoint for traditional database applications—you simply won't leverage its computational features.

This backward compatibility is crucial: **adoption doesn't require wholesale reconceptualization**. Start with familiar entity-relationship thinking, add workflow semantics where they matter, and the system handles both gracefully.

## From Concepts to Implementation

You now understand the Relational Workflow Model conceptually. Let's summarize what you've learned and preview what comes next.

### What You Now Know

**The paradigm shift**: Databases can be workflow engines, not just storage systems. Your schema becomes an executable specification of your data pipeline.

**Four foundational concepts**:
1. **Workflow entities**: Data with temporal and computational context
2. **Computational dependencies**: Relationships that enforce "computed from" semantics
3. **Workflow steps**: Tables organized by their role in the pipeline
4. **DAG structure**: Ensuring valid, deterministic execution

**Key DataJoint innovations**:
- **Table tiers** (Lookup, Manual, Imported, Computed) organize workflow roles
- **Lookup tables** are part of schema design, populated at declaration
- **Manual tables** use explicit INSERT for human-controlled entry
- **Imported/Computed tables** use `make()` methods called by `populate()`
- **Immutability** preserves provenance and prevents silent invalidation
- **Computational validity** ensures results correspond to current inputs
- **Visual diagrams** encode operational behavior through shape and color
- **Master-part relationships** maintain group integrity for naturally grouped entities
- **Relationships emerge** from workflow convergence rather than being modeled separately

**Why this matters**: Traditional databases maintain referential integrity (no orphaned records) but not computational validity (results consistent with inputs). The Relational Workflow Model enforces both.

### What Comes Next: Making It Real

The conceptual foundation is in place. The next sections provide the formal machinery and practical skills.

**Schema Design** shows you how to:
- Declare tables with workflow tiers using DataJoint decorators
- Specify computational dependencies through foreign keys with enhanced semantics
- Define computation logic in `make()` methods that the system executes automatically
- Populate lookup tables using the `contents` attribute
- Create master-part relationships for grouped entities
- Validate DAG structure during schema compilation to catch errors early
- Use proper naming conventions and organizational patterns
- Handle complex dependencies including optional references and multi-way joins

You'll move from understanding "tables represent workflow steps" to actually declaring those tables in Python code.

**Computations** shows you how DataJoint:
- Executes workflows with `populate()` to automatically compute missing results
- Maintains computational validity through cascade operations when data changes
- Handles errors gracefully and enables resumable computation
- Parallelizes workflow execution across multiple workers for efficiency
- Tracks computation status and provides monitoring capabilities
- Manages transactions to ensure atomic updates
- Supports different computation strategies (all-at-once vs. progressive)
- Handles complex scenarios like parameter sweeps and conditional processing

You'll see the workflow model in action—how conceptual principles become operational guarantees.

**Data Operations** shows you how to:
- Insert data into appropriate workflow tiers respecting dependencies
- Query across workflow stages using relational algebra with workflow semantics
- Update data while preserving computational validity (delete and recompute, not silent updates)
- Use the five core query operators (restriction, join, projection, aggregation, union)
- Export results with full provenance information
- Navigate your workflow interactively to explore data and debug issues
- Fetch data efficiently for analysis
- Integrate DataJoint with pandas, numpy, and other scientific Python tools

You'll learn to work with workflow-aware databases in your daily research.

**Queries** provides deep coverage of:
- Relational algebra fundamentals applied to workflows
- Query composition and optimization
- Advanced restriction patterns
- Complex joins and projections
- Aggregation across workflow stages
- Subquery patterns
- Query performance optimization

**Computation** details advanced topics:
- Distributed computing strategies
- Job management and scheduling
- Error recovery patterns
- Monitoring and logging
- Performance tuning
- Integration with cluster computing systems

**Interfaces** explores:
- Python API patterns and best practices
- Jupyter notebook integration
- Web interfaces and dashboards
- REST APIs for data access
- Integration with analysis frameworks
- Visualization tools

**Examples** provides complete, executable workflows:
- **Research Lab**: Neuroscience recording and analysis pipeline
- **Sales**: Business database with computed aggregations
- **Nations**: Geographic and demographic data
- **University**: Academic records with complex relationships
- **Languages**: ISO standards as lookup tables, proficiency tracking
- **Management**: Hierarchical organizational structures
- **Allen CCF**: Real-world brain atlas integration
- **Fractals**: Computational image generation and analysis pipeline

Each example demonstrates different aspects of the workflow model in concrete, working code.

### The Transformation

By the end of these sections, you'll be able to:

**Before**: "I have scripts that process data files. I hope I ran them in the right order with the right versions."

**After**: "I have a database schema that specifies my workflow. DataJoint executes it correctly, tracks provenance automatically, and guarantees computational validity."

This is the transformation from ad-hoc scripts to robust data pipelines—from hoping your results are valid to knowing they are.

The conceptual foundation is complete. Let's make it real.

## Exercises

These exercises use examples from the Examples section. Each example is a complete, executable DataJoint schema with detailed explanations.

### Exercise 1: Identifying Table Tiers

Open the **Research Lab** example diagram.

a) Identify which tables are Manual, Imported, Computed, and Lookup based on their visual representation.

b) For each Manual table, what triggers data insertion? (What human action or event?)

c) For each Computed table, what upstream data does it depend on?

d) If you insert a new Session, trace through the diagram: what automated processing would occur when you call `populate()`?

:::{hint}
Look at node shapes (rectangle vs. oval) and colors (gray, green, blue, red).
:::

### Exercise 2: Understanding populate() and make()

Using the **Fractals** example:

a) Examine the `make()` method for `FractalImage`. What computation does it perform?

b) If you insert 10 new parameter sets into `FractalParams`, how many times will `FractalImage.make()` be called when you run `FractalImage.populate()`?

c) What happens if `make()` fails for one parameter set? Can the others still process?

d) Modify the `make()` method to add a progress print statement. Re-run `populate()` and observe the execution.

:::{hint}
The `make()` method receives one `key` at a time and inserts one entry.
:::

### Exercise 3: Lookup Tables and Controlled Vocabulary

Using the **Languages** example:

a) Identify all lookup tables in the schema. What reference data do they contain?

b) Why is `Language` a Lookup table rather than Manual?

c) What prevents someone from entering an invalid language code into `Proficiency`?

d) Add a new language to the `Language` lookup table. What other tables are affected?

:::{hint}
Lookup tables define valid values that other tables reference via foreign keys.
:::

### Exercise 4: Workflow Dependencies

Using the **Nations** example:

a) Draw the dependency graph showing which tables depend on which.

b) Identify the "root" tables (no dependencies) and "leaf" tables (nothing depends on them).

c) If you wanted to add population growth statistics as a computed table, what would it depend on?

d) Explain why `Continent` should be a Lookup table rather than Manual.

:::{hint}
Follow the arrows in the diagram. Dependencies point from required data to dependent data.
:::

### Exercise 5: Master-Part Relationships

Using the **University** example:

a) Identify all master-part relationships in the schema.

b) Why is `Course.Section` a part table rather than a separate table with a foreign key to `Course`?

c) What happens when you delete a Course that has Sections?

d) Could `Enrollment` be a part table of `Student`? Why or why not?

:::{hint}
Master-part is for exclusive ownership where parts have no meaning without their master.
:::

### Exercise 6: Mixing Manual and Automated Steps

Using the **Research Lab** example:

a) List all the manual steps a researcher must perform (explicit INSERTs).

b) List all the automated steps that occur via `populate()`.

c) Design a new analysis table (pick any analysis). Should it be Imported or Computed? Why?

d) If you wanted to add quality control checks before filtering, would that be Manual or Computed?

:::{hint}
Manual = explicit INSERT you control. Imported/Computed = make() DataJoint calls automatically.
:::

### Exercise 7: Reading Diagrams

For each example (Research Lab, Sales, Nations, University, Languages):

a) Without looking at code, describe the workflow in plain English using only the diagram.

b) Identify entry points (where data enters the system).

c) Identify automated processing chains (sequences of computed tables).

d) Find convergence points (tables that depend on multiple upstream tables).

:::{hint}
Shape + color + arrows tell the complete story.
:::

### Exercise 8: Relationships as Workflow Convergence

Using the **Languages** example with Person, Language, and Proficiency:

a) Explain how the many-to-many relationship between Person and Language emerges from the Proficiency table rather than being explicitly modeled.

b) What workflow step does Proficiency represent?

c) Write queries (in plain English) to find: (i) all people who speak Spanish, (ii) all languages spoken by a specific person, (iii) all intermediate-level speakers of any language.

d) How would you model this same scenario in traditional ERM? What additional concepts would you need?

:::{hint}
The relationship exists because there's a concrete workflow operation (proficiency assessment) that involves both entities.
:::

### Exercise 9: Computational Validity

Consider this scenario in the **Research Lab** example:

A researcher discovers that Recording #42 was corrupted due to an instrument malfunction. The raw data file needs to be replaced with a corrected version.

a) What happens to FilteredRecording, SpikeSorting, and NeuronStats entries that depend on Recording #42?

b) Walk through the steps to fix this problem while maintaining computational validity.

c) Why is it important to delete downstream results rather than just updating the Recording entry?

d) After reinserting the corrected Recording, how do you regenerate all downstream analyses?

:::{hint}
Computational validity means results must correspond to their current inputs.
:::

### Exercise 10: Design Your Own

Design a DataJoint schema for one of these scenarios:

a) **Weather monitoring**: Stations collect temperature/humidity/pressure readings hourly. Compute daily statistics and identify anomalies.

b) **Recipe database**: Ingredients, recipes, user ratings. Compute average ratings and popular ingredient combinations.

c) **Fitness tracking**: Users log workouts (type, duration, intensity). Compute weekly summaries and progress trends.

For your design:
- Identify Lookup, Manual, Imported, and Computed tables
- Draw the dependency diagram with correct shapes and colors
- Specify what triggers each Computed table's `make()` method
- Identify any master-part relationships
- Write pseudocode for at least one `make()` method

:::{hint}
Start by identifying: What do humans enter? What gets computed automatically? What reference data is needed?
:::

### Exercise 11: Lookup vs. Manual Decision

For each scenario, decide whether the table should be Lookup or Manual, and explain why:

a) A table of experimental protocol types (e.g., "visual_tuning", "spontaneous", "optogenetic") with descriptions

b) A table recording which protocol was used for each experimental session

c) A table of country codes (ISO 3166) with country names

d) A table recording where each research participant was born

e) A table of standardized test names (e.g., "SAT", "GRE", "MCAT") with scoring ranges

f) A table recording individual students' test scores

:::{hint}
Lookup = design-time reference data. Manual = operation-time observations.
:::

### Exercise 12: Schema Evolution

Consider the **Research Lab** schema. You need to add support for:
- Two-photon calcium imaging (new recording type)
- Cell segmentation (new processing step between Recording and analysis)
- Region-of-interest tracking across sessions

a) What new tables would you add? What tier would each be?

b) How do these new tables integrate with existing dependencies?

c) Would any existing tables need modification?

d) Draw the updated dependency diagram.

:::{hint}
New capabilities usually mean new Imported or Computed tables that fit into the existing DAG.
:::

### Exercise 13: The DAG Validation

Consider these proposed dependencies. Which would DataJoint reject and why?

a) `Session → Recording → FilteredRecording → Session` (circular)

b) `Session → Recording` and `Session → FilteredRecording` and `Recording → FilteredRecording` (redundant but valid)

c) `Recording → SpikeSorting` and `SpikeSorting → Recording` (circular)

d) `Session → Recording → [FilteredRecording, MotionCorrection]` where both filtered and corrected depend on recording (branching)

:::{hint}
DAG = Directed Acyclic Graph. Circular dependencies violate acyclicity.
:::

### Exercise 14: Subsumption of ERM

Take a traditional Entity-Relationship diagram from a database textbook or online resource.

a) Identify all entities and relationships in the ERM diagram.

b) Redesign it as a DataJoint workflow schema. Which entities become Manual tables? What becomes Computed?

c) Show how the ERM relationships (cardinality, optionality) are expressed through DataJoint foreign keys.

d) What workflow semantics can you add that weren't in the original ERM design?

:::{hint}
Every ERM concept has a DataJoint equivalent. The workflow model adds temporal and computational dimensions.
:::

### Exercise 15: Real-World Application

Think about your own research or work domain:

a) Identify a workflow you currently manage with scripts or manual processes.

b) Map it to DataJoint table tiers: what would be Lookup, Manual, Imported, Computed?

c) Draw a workflow diagram with proper shapes and colors.

d) Identify the key benefits DataJoint would provide for your specific use case.

e) What challenges do you anticipate in adopting this approach?

:::{hint}
Start with entry points (what data do you currently provide manually?) and work forward through transformations.
:::

---

## Moving Forward

This chapter introduced the Relational Workflow Model conceptually, establishing it as the third major paradigm for relational databases. You've seen:

- How the workflow model **subsumes ERM** without loss of expressiveness
- Why **computational dependencies** differ fundamentally from foreign keys
- How **table tiers** organize workflow roles and determine operational behavior
- Why **lookup tables** belong to schema design, not workflow operations
- How **populate() and make()** enable automatic workflow execution
- Why **diagramming notation** encodes executable specifications
- How **master-part relationships** maintain group integrity
- How **relationships emerge** from workflow convergence naturally

The next sections transform these concepts into practical skills. You'll learn the exact syntax for declaring workflows, the mechanics of executing them, and the patterns for querying workflow-aware data effectively.

The journey from concepts to code begins with Schema Design, where you'll see how to declare everything introduced in this chapter: table tiers, dependencies, computations, lookups, and part tables. The abstract becomes concrete, and the paradigm becomes a tool you can use.
