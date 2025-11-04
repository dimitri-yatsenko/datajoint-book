# Relational Workflows

## The Problem DataJoint Solves

In the previous chapter, we saw how traditional relational databases excel at storing and querying data but struggle with scientific workflows. When you update an input measurement, downstream analyses become stale. When you want to process new data, you must manually track dependencies and run computations in the correct order. When someone asks "how was this result computed?", you rely on external documentation that may be out of date.

**DataJoint solves these problems by treating your database schema as an executable workflow specification.** Your table definitions don't just describe data structure—they prescribe how data flows through your pipeline, when computations run, and how results depend on inputs.

This chapter introduces the Relational Workflow Model—a fundamental extension of relational theory that makes databases workflow-aware while preserving all the mathematical rigor of Codd's model.

## A New Paradigm for Relational Databases

This book introduces a paradigm shift in how we think about relational database design and implementation: the **Relational Workflow Model**. This model is embodied by DataJoint and affects how we think about database design, data manipulation, and query formation. The key insight of the Relational Workflow Model is that the database schema itself becomes an executable specification of your workflow. In this chapter, we introduce key concepts of relational workflows and contrast this model with traditional approaches to database modeling and implementation.

The relational data model, while powerful, offers considerable semantic flexibility that can be both a blessing and a curse. This flexibility has led to the development of distinct conceptual frameworks for understanding and applying relational principles in database design and operations. While these approaches share common underlying constructs (tables, data types, primary keys, foreign keys, etc.), they operate on fundamentally different semantics that lead to distinct approaches to database design, data manipulation, and query formation.

## Comparing the Three Paradigms

Before diving deep into the Relational Workflow Model, let's see how it compares to the two major approaches we've discussed:

| Aspect | Mathematical (Codd) | Entity-Relationship (Chen) | **Relational Workflow (Yatsenko)** |
|--------|-------------------|-------------------------|-------------------------------|
| **Core Question** | "What functional dependencies exist?" | "What entity types exist?" | **"When/how are entities created?"** |
| **Diagramming** | None | Comprehensive ERDs | **Integrated workflow diagrams** |
| **Time Dimension** | Not addressed | Not central | **Fundamental** |
| **Implementation Gap** | High (abstract to SQL) | High (ERM to SQL) | **None (unified approach)** |
| **Workflow Support** | None | None | **Native workflow modeling** |
| **Learning Curve** | Steep (mathematical) | Moderate (intuitive design, complex SQL) | **Gentle (unified concepts)** |

## The Mathematical Foundation: Codd's Predicate Calculus Approach

### Core Concepts
The **mathematical view** of the relational model, championed by Edgar F. Codd, is rooted in **predicate calculus**, **first-order logic**, and **set theory**. This approach treats relations as mathematical predicates—statements about variables that can be determined to be true or false.

**Relation as Predicate**: In the mathematical view of relational databases, a table (relation) represents a logical predicate; it contains the complete set of all facts (propositions) that make the predicate true. For example, the table "EmployeeProject" represents the predicate "Employee $x$ works on Project $y$."

**Tuple as Proposition**: Each row (tuple) is a specific set of attribute values that asserts a true proposition for the predicate. For example, if a table's predicate is "Employee $x$ works on Project $y$," the row `(Alice, P1)` asserts the truth: "Employee Alice works on Project P1."

**Functional Dependencies between Attributes**: The core concept is the functional dependency: attribute `A` functionally determines attribute `B` (written `A → B`) if knowing the value of `A` allows you to determine the unique value of `B`. For example, the attribute `department` functionally determines the attribute `department_chair` because knowing the department name allows you to determine the unique name of the department chair. Functional dependencies are helpful for reasoning about the structure of the database and for performing queries.

Then the database can be viewed as a collection of predicates and a minimal complete set of true propositions from which all other true propositions can be derived. Data queries are viewed as logical inferences using the rules of predicate calculus. *Relational algebra* and *relational calculus* provide set of operations that can be used to perform these inferences. Under the Closed World Assumption (CWA), the database is assumed to contain all true propositions and all other propositions are assumed to be false. CWA is a simplifying assumption that allows us to reason about the data in the database in a more precise way.

Then the question of database design is to choose a minimal complete set of true propositions from which all other true propositions can be effectively derived. This is the problem of *database normalization*, a collection of design principles—called *normal forms*—that ensure data integrity and maintainability and makes databases more amenable to analysis and inference.

SQL—the primary language for defining and querying relational databases—is based on the mathematical semantics of the relational model. However, in practice, even most experienced database programmers hardly rely on the mathematical semantics of the relational model.
Educational materials typically use more intuitive design methodologies and then teach how to translate the conceptual design into SQL.

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

Or using an explicit association table:
:::{figure}
:align: center
```{mermaid}
---
title: Crow's Foot notation.
---
erDiagram
    EMPLOYEE ||--o{ ASSIGNMENT : works-on
    ASSIGNMENT }o--|| PROJECT : assigned-to
```
Equivalent ERD with an explicit association entity (ASSIGNMENT).
:::


### Limitations

Despite its remarkable success in making database design more intuitive and accessible, the Entity-Relationship Model suffers from several fundamental gaps that have become increasingly problematic as database applications have grown more complex and collaborative.

The most significant limitation is the conceptual-implementation mismatch that has plagued database development for decades. While ERM has become the dominant approach for conceptual database design, SQL and most relational database systems operate on the mathematical semantics of Codd's original model. This creates a fundamental disconnect between how designers think about their domains (in terms of entities and relationships) and how they must express their designs in code (in terms of tables, columns, and constraints). The elegant conceptual models must be manually translated into SQL's lower-level primitives, a process that is prone to errors and often results in implementations that don't fully capture the original design intent.

A related problem is the lack of temporal dimension in ERM. The model focuses on "what entities exist" and "how they relate to each other" but provides no framework for understanding "when entities are created" or "how they evolve over time." This static view of relationships becomes problematic in modern applications where the timing and sequence of operations are critical. Scientific workflows, business processes, and data pipelines all require understanding not just what exists, but when and how it came to exist.

The static nature of ERM relationships also limits its applicability to operational systems. Relationships are treated as static connections between entities rather than as dynamic, operational processes. This makes it difficult to model workflows where relationships represent information flow, computational dependencies, or temporal sequences of operations.

Finally, the translation complexity between ERM designs and SQL implementations creates a significant barrier to effective database development. Converting ERM designs to SQL schemas requires mental translation between entity concepts and relational predicates, a process that demands expertise in both domains and often results in implementations that lose the clarity and elegance of the original conceptual design.

## The Relational Workflow Model: A Paradigm Shift

The **Relational Workflow Model**, pioneered by DataJoint, represents a fundamental evolution that addresses the limitations of both previous approaches while building on their strengths.

### Revolutionary Core Concepts

The Relational Workflow Model introduces four fundamental concepts that transform how we think about database design and implementation. These concepts work together to create a unified framework that addresses the limitations of both mathematical and entity-relationship approaches.

The first concept is the **Workflow Entity**, which represents an entity created at a specific step in a workflow. Unlike traditional entities that exist independently, workflow entities are artifacts of workflow execution—they represent the products of specific operations or processes. This temporal dimension is crucial because it allows us to understand not just what exists, but when and how it came to exist.

**Workflow Dependencies** extend the traditional concept of foreign keys by adding operational semantics. While foreign keys in traditional databases ensure referential integrity, workflow dependencies also prescribe the order of operations by requiring that parent entities must be created before child entities. This creates a natural sequencing mechanism that ensures workflows execute in the correct order and maintains computational validity throughout the process.

**Workflow Steps** represent distinct phases in a workflow where specific entity types are created. Each step has a clear purpose and responsibility, whether it's data acquisition, human input, computational processing, or decision-making. This step-based organization makes workflows explicit and understandable, enabling effective collaboration and maintenance.

Finally, the **Directed Acyclic Graph (DAG)** structure represents valid workflow execution sequences and prohibits circular dependencies. This mathematical property ensures that workflows can always be executed without infinite loops or logical contradictions, while also providing a clear framework for understanding dependencies and enabling efficient parallel execution.

### The Workflow Normalization Principle

> **"Every table represents an entity type that is created at a specific step in a workflow, and all attributes describe that entity as it exists at that workflow step."**

This principle extends entity normalization with temporal and operational dimensions, creating a unified framework for design, implementation, and querying.

### Why the Relational Workflow Model Matters

The Relational Workflow Model addresses the fundamental challenges that have plagued relational database practice for decades, providing solutions that are both theoretically sound and practically effective. These solutions emerge naturally from the workflow-centric approach, creating a unified system that eliminates traditional gaps between design and implementation.

The first major advantage is **unified design and implementation**. Unlike the ERM-SQL gap that has frustrated database developers for decades, DataJoint provides unified diagramming, definition, and query languages that all operate on the same conceptual framework. Schema diagrams directly represent data definitions, arrow notation in definitions corresponds to arrows in diagrams, queries operate on entity sets rather than abstract relations, and no translation is needed between conceptual design and implementation. This eliminates the mental overhead of switching between different conceptual frameworks and reduces the likelihood of implementation errors.

The model's **temporal and operational awareness** addresses a critical limitation of traditional approaches. While ERM focuses on "what entities exist," the Relational Workflow Model asks "when and how are entities created?" This temporal dimension is crucial for scientific workflows where data processing follows strict sequences, business processes where operations must occur in specific orders, and data pipelines where each step depends on previous steps. The model naturally captures the dynamic, operational nature of modern database applications.

**Immutability and provenance** are built into the model's foundation. Workflow artifacts are treated as immutable once created, naturally preserving workflow execution history, data provenance, audit trails, and enabling reproducible science. This approach eliminates the need for separate provenance tracking systems and ensures that every result can be traced back to its source data and the exact process that produced it.

Finally, **workflow integrity** is maintained through the DAG structure, which ensures no circular dependencies, valid operation sequences, explicit workflow dependencies, and enforced temporal order. This mathematical foundation provides guarantees that are impossible to achieve with traditional approaches while enabling efficient parallel execution and resumable computation.

```{figure} ../images/employee-project-datajoint.svg
:align: center

DataJoint diagram showing workflow dependencies
```

## The DataJoint Implementation: Theory Made Practical

DataJoint represents the practical embodiment of the Relational Workflow Model, developed over a decade of neuroscience research [@10.48550/arXiv.1807.11104].

### The Schema as Executable Specification

The Relational Workflow Model introduces a profound shift in perspective: the database schema itself becomes an executable specification of your workflow. This represents a fundamental departure from traditional database design, where conceptual modeling, implementation, and documentation are separate activities requiring translation between different representations.

When you define a DataJoint schema, you accomplish four critical tasks simultaneously. First, you design the conceptual model by identifying what workflow steps exist in your domain. Second, you implement the database structure by defining tables, attributes, and foreign keys that capture these workflow steps. Third, you specify the computations through `make()` methods that define how each workflow step transforms its inputs into outputs. Finally, you document the pipeline because the schema itself serves as the complete documentation of your workflow.

This unified approach eliminates the traditional separation between conceptual design and implementation. Rather than drawing an ER diagram and then translating it into SQL tables—a process prone to errors and inconsistencies—you write a schema that directly expresses both the conceptual model and its implementation. When you generate a diagram, it's derived from the actual working schema, ensuring that your documentation is never out of sync with your implementation.

### Table Tiers: Workflow Roles

DataJoint introduces a sophisticated classification system called table tiers that organizes entity sets according to their specific role in the workflow. This classification goes far beyond simple organizational convenience—it fundamentally shapes how you think about data flow and responsibility within your system.

The four table tiers each represent a distinct type of workflow activity. Lookup tables contain reference data and parameters, such as controlled vocabularies and constants that provide the foundational knowledge for your workflow. Manual tables capture human-entered data, including observations and decisions that require expert judgment or domain knowledge. Imported tables handle automated data acquisition from instruments, files, or external systems. Finally, computed tables perform automated processing, generating derived results and analyses from the data collected in other tiers.

This tiered structure creates a natural dependency hierarchy that reflects the logical flow of information through your workflow. Computed tables depend on imported or manual tables for their input data, which in turn may depend on lookup tables for reference information. This creates a directed acyclic graph (DAG) that makes the workflow structure explicit and prevents circular dependencies that could lead to infinite loops or logical inconsistencies.

The visual representation of this structure through color-coded diagrams provides immediate insight into your workflow. Green represents manual tables where human expertise enters the system, blue shows imported tables where automated data acquisition occurs, red indicates computed tables where algorithmic processing happens, and gray denotes lookup tables containing reference information. At a glance, you can see where data enters your system and trace how it flows through each processing step.

### Relationships Emerge from Workflow Convergence

One of the most elegant aspects of the Relational Workflow Model is how it handles relationships between entities. Unlike traditional Entity-Relationship modeling, which requires explicit notation and concepts for relationships, DataJoint allows relationships to emerge naturally from the convergence of workflows. This approach eliminates the artificial distinction between entities and relationships that has long complicated database design.

Consider the example of language proficiency, where we need to model the relationship between people and the languages they speak. In traditional ERM, you would identify three distinct concepts: Person and Language as entities, and "SpeaksLanguage" as a relationship connecting them. The implementation typically involves creating a junction table that artificially represents this relationship.

DataJoint takes a fundamentally different approach. Instead of treating `Proficiency` as an artificial junction table, it represents the actual workflow step of assessing or recording language proficiency. This step naturally requires both a Person and a Language as inputs, creating the association through the workflow itself rather than through explicit relationship modeling.

This workflow-centric approach makes relationships implicit rather than explicit. A person "relates to" languages not because of an abstract relationship concept, but because there exists a concrete workflow step involving both entities. When you want to query this relationship, you simply query the convergence point: `Person * Proficiency * Language`. The system understands these entities are related through the workflow and joins them appropriately, without requiring you to specify join conditions or worry about ambiguous column names.

### Immutability and Computational Validity

The Relational Workflow Model introduces a crucial distinction between transactional consistency and computational validity that fundamentally changes how we think about data integrity. Traditional databases focus primarily on transactional consistency, ensuring that concurrent updates don't corrupt data through mechanisms like locking and isolation. While this is essential for preventing race conditions, it doesn't address a deeper problem that arises in computational workflows: ensuring that downstream results remain consistent with their upstream inputs.

DataJoint addresses this challenge through its approach to immutability and cascade operations. When you delete an entity in DataJoint, the system doesn't simply remove that single record—it cascades the delete to all dependent entities throughout the workflow. This behavior isn't just cleanup; it's enforcing computational validity by recognizing that if the inputs are gone, any results based on those inputs become meaningless and must be removed.

The process of correcting data illustrates this principle beautifully. When you discover an error in upstream data, you don't simply update the problematic record. Instead, you delete the entire downstream pipeline that was computed from the incorrect data, reinsert the corrected data, and then recompute the entire dependent chain. This ensures that every result in your database represents a consistent computation from valid inputs.

The `populate()` operation embodies this workflow philosophy perfectly. Rather than requiring you to manually track dependencies and orchestrate computations, your schema defines what needs to be computed, and DataJoint figures out how to execute it. The system identifies missing work, computes results in the correct order, and maintains integrity throughout the process—all while supporting parallel execution and resumable computation for efficiency.

### Query Algebra with Workflow Semantics

The Relational Workflow Model transforms query formation from a low-level table manipulation exercise into a high-level workflow navigation process. Traditional SQL requires you to think in terms of low-level table operations: JOINs on arbitrary columns, WHERE clauses with complex predicates, and subqueries that reference tables multiple times. While this approach works, it demands careful attention to maintain consistency and often obscures the underlying workflow logic.

DataJoint queries operate at a fundamentally different level of abstraction. Rather than manipulating tables directly, queries are defined with respect to workflow semantics, where operations understand the entity types and dependencies declared in your schema. This workflow-aware approach enables a remarkably elegant solution: just five operators provide a complete query algebra that handles all the complexity of scientific data analysis.

The five core operators each serve distinct workflow purposes. Restriction (`&`) filters entities based on conditions, allowing you to focus on specific subsets of your data. Join (`*`) combines entities from converging workflow paths, naturally expressing how different workflow branches come together. Projection (`.proj()`) selects and computes attributes, transforming data as it flows through the workflow. Aggregation (`.aggr()`) summarizes across entity groups, enabling statistical analysis and reporting. Finally, Union combines entities from parallel workflow branches, allowing you to merge results from different processing paths.

These operators maintain algebraic closure, meaning they take entity sets as inputs and produce entity sets as outputs, enabling arbitrary composition of complex queries. More importantly, they preserve entity integrity—query results remain valid entity sets rather than arbitrary row collections, making them suitable for further operations and maintaining the workflow semantics throughout the query process.

The workflow-aware nature of these operators eliminates many of the pitfalls that plague traditional SQL queries. Unlike SQL's natural joins that can produce unexpected results when tables share column names coincidentally, DataJoint operators respect the dependency structure declared in your schema. When you join `Person * Proficiency * Language`, the system knows these entities are related through the workflow and joins them appropriately, without requiring you to specify join conditions or worry about ambiguous attribute names.

### Practical Benefits

The Relational Workflow Model delivers a comprehensive set of advantages that address the fundamental challenges that have plagued database design and implementation for decades. These benefits emerge naturally from the workflow-centric approach, creating a unified system that eliminates traditional gaps between design and implementation.

The most immediate benefit is the seamless integration between design and implementation. There's no conceptual gap between how you think about your workflow and how you express it in code. Queries naturally express entity relationships because the query language operates on the same conceptual framework as your schema design. This intuitive query formation reduces the learning curve and makes complex data analysis accessible to domain experts who may not have extensive database programming experience.

The workflow integrity provided by the DAG structure prevents circular dependencies and ensures valid operation sequences, eliminating entire classes of errors that can occur in traditional database designs. Data consistency is maintained through immutable workflow artifacts that preserve the integrity of computational results. This immutability approach naturally preserves scientific provenance, creating a complete audit trail of how results were generated without requiring additional tracking systems.

Perhaps most importantly, the Relational Workflow Model enables effective collaborative development. Researchers without database expertise can contribute meaningfully to data pipelines because the workflow semantics map directly to their domain understanding. The computational validity ensures that downstream results remain consistent with upstream inputs, while automatic pipeline execution means that your schema defines what needs to be computed, and DataJoint figures out how to execute it efficiently.

## From Transactions to Transformations

The Relational Workflow Model represents a fundamental conceptual shift in how we think about relational databases, moving from a storage-centric view to a transformation-centric view. This shift is captured in the contrast between traditional database thinking and the workflow approach.

In the traditional view, tables store data, rows are records, and foreign keys enforce consistency. Updates modify state, schemas organize storage, and queries retrieve data. The focus is on concurrent transactions and maintaining consistency during simultaneous access. This perspective treats the database as a passive storage system that responds to queries and updates.

The workflow view fundamentally reimagines these concepts. Entity sets become workflow steps, entities are execution instances, and dependencies specify information flow. Computations create new states rather than modifying existing ones, schemas specify pipelines rather than just organizing storage, and queries trace provenance rather than simply retrieving data. The focus shifts from concurrent transactions to reproducible transformations.

This conceptual shift makes DataJoint feel less like a traditional database and more like a workflow engine with persistent state—one that maintains perfect computational validity while supporting the flexibility that scientists and data engineers need. The system becomes an active participant in your computational process rather than just a passive repository for your results.

## Harmonizing with Relational Theory

The Relational Workflow Model doesn't abandon the mathematical foundations of relational theory—it extends them in ways that make them more practical and accessible for modern computational workflows. This extension maintains the rigor of Codd's original model while adding the operational semantics needed for scientific and data engineering applications.

The model preserves all the essential elements of relational theory. Relations remain sets of tuples, maintaining the mathematical foundation that enables formal reasoning about data operations. The core relational algebra operations—join, restrict, project, aggregate, and union—are all present and functional, ensuring that the powerful query capabilities of relational databases remain available. Referential integrity through foreign keys continues to enforce consistency, and declarative queries maintain the separation between what you want and how to get it.

However, the Relational Workflow Model adds crucial extensions that address the limitations of traditional relational databases for computational workflows. Table tiers classify workflow roles, providing semantic meaning to different types of operations. Computational semantics through `make()` methods enable the database to understand and execute transformations. The dependency structure as a DAG ensures valid workflow execution sequences. Immutability becomes the default, preserving computational validity. The `populate()` operation enables automatic execution of workflows, and provenance awareness is built into the system rather than added as an afterthought.

This combination makes DataJoint a specialized dialect of the relational model, optimized for computational workflows while maintaining mathematical rigor. It's not a departure from relational theory but rather an evolution that makes relational databases truly suitable for the complex, temporal, and collaborative nature of modern data science and engineering.

## The Future of Database Design

The Relational Workflow Model represents more than an incremental improvement—it's a **paradigm shift** that addresses fundamental limitations in how we think about and implement relational databases.

### Why This Matters Now

The timing for the Relational Workflow Model couldn't be more critical, as several converging trends make traditional database approaches increasingly inadequate for modern computational needs.

Scientific computing has experienced an explosion of data-intensive research that demands workflow-aware database systems capable of handling complex data pipelines with temporal dependencies. Traditional databases, designed for transactional workloads, struggle to maintain computational validity across multi-step analyses where each step depends on the integrity of previous steps.

Business process management has evolved beyond simple data storage to require databases that can model and enforce business process sequences, not just store static relationships. Modern enterprises need systems that understand the temporal and operational aspects of their workflows, ensuring that processes execute in the correct order and maintain consistency throughout.

The rise of data engineering has created new challenges that traditional databases weren't designed to address. Data pipelines, ETL processes, and streaming data all require databases that understand workflow semantics rather than just providing storage and retrieval capabilities. The complexity of modern data engineering demands systems that can orchestrate computations and maintain provenance automatically.

Finally, collaborative development has become the norm rather than the exception. Teams need unified frameworks that eliminate the traditional gap between conceptual design and implementation, enabling domain experts to contribute effectively to data systems without requiring extensive database programming expertise.

### The Path Forward

This book demonstrates how the Relational Workflow Model, embodied in DataJoint, provides a comprehensive solution to the challenges facing modern database design and implementation. The model offers a unified conceptual framework that seamlessly integrates database design, implementation, and querying into a single coherent system. This eliminates the traditional gaps between conceptual modeling and practical implementation that have plagued database development for decades.

The Relational Workflow Model provides native support for temporal and operational aspects that previous models either ignored or handled inadequately. This includes workflow dependencies, computational validity, and automatic pipeline execution—capabilities that are essential for modern scientific computing and data engineering but were never properly addressed by traditional relational databases.

The practical tools provided by DataJoint eliminate the traditional design-implementation gap through unified diagramming, definition, and query languages that all operate on the same conceptual framework. This creates a foundation for the next generation of database applications that can handle the complexity, collaboration, and computational requirements of modern data science and engineering.

The Relational Workflow Model isn't just another approach to relational databases—it's the evolution that makes relational databases truly fit for modern computational workflows and collaborative data science. It represents the maturation of relational theory from its transactional origins to its full potential as a framework for computational workflows.

## Exercises

1. Work through the example of a database model in Chen's EM notation in @10.1093/jamia/ocx033.  
  What are its entities and relationships? Explain what operations this database supports.

2. Work through the example of an multiplayer online role-playing game  database model in Chen's EM notation listed on the [ERM Wikipedia page](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model#Crow's_foot_notation)

3. Learn to create ER diagrams in Crow's Foot notation for using Mermaid: https://mermaid.js.org/syntax/entityRelationshipDiagram.html

2. **Identify workflow steps**: Take a process you're familiar with (analyzing survey data, processing images). Break it into steps and identify which would be Manual, Imported, or Computed tables. What are the dependencies?

3. **Relationships as convergence**: Look at the Language example. Explain how the person-language relationship emerges from workflow convergence rather than being explicitly modeled as in ERM.

4. **Trace provenance**: Using the neuroscience pipeline example, trace backward from `NeuronStatistics` to identify all upstream entities it depends on. Now trace forward from `Session` to see what would be affected if you deleted a session.

5. **Immutability vs updates**: Think of a scenario where you'd use UPDATE in a traditional database (correcting a data entry error). How would you handle this in DataJoint's immutable model? When does delete-and-reinsert make sense?

6. **Schema as specification**: Compare designing a database with the traditional ERM approach (draw ER diagram → translate to SQL) versus DataJoint (write schema directly). What are the advantages and disadvantages of each?

7. **Normalization reframed**: Take the poorly designed Mouse table from the Normalization chapter (with changeable cage and weight attributes). Explain how applying DataJoint's entity-centric principles leads to a better design, without needing to analyze functional dependencies.
