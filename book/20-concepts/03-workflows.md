# Databases as Workflows


## Three Views of the Relational Model

The relational data model, while powerful, offers considerable flexibility that can be both a blessing and a curse. This flexibility has led to the development of three distinct conceptual frameworks for understanding and applying relational databases. While these approaches share the same underlying syntax (tables, primary keys, foreign keys, etc.), they provide fundamentally different **semantics** that lead to distinct approaches to database design, data manipulation, and query formation.

### The Mathematical View: Predicate Calculus and Functional Dependencies

The **mathematical view** of the relational model, championed by Edgar F. Codd, is rooted in **predicate calculus** and **set theory**. This approach treats relations as mathematical predicates—statements about variables that can be determined to be true or false.

#### Core Definitions

**Relation as Predicate**: A table (relation) represents a logical predicate; it contains the complete set of all facts (propositions) that make the predicate true.

**Tuple as Proposition**: Each row (tuple) is a specific set of attribute values that asserts a true proposition for the predicate. For example, if a table's predicate is "Employee $x$ works on Project $y$," the row (Alice, P1) asserts: "Employee Alice works on Project P1."

**Functional Dependencies**: The core concept is the functional dependency: attribute `A` functionally determines attribute `B` (written `A → B`) if knowing the value of `A` allows you to determine the unique value of `B`.

#### Design Philosophy

The mathematical approach frames database design as deciding **which predicates should become base relations (stored tables)** so that:
- All other valid true propositions can be **most easily and efficiently derived** through relational operations
- The total number of stored facts is minimized to reduce redundancy
- The chance of making mistakes in creating true propositions (data anomalies) is minimized

**Normalization Principle**: "Every non-key attribute must depend on the key, the whole key, and nothing but the key."

#### Characteristics
- **Abstract**: Reasons about predicates and functional dependencies, not real-world entities
- **Mathematical**: Provides formal, rigorous definitions and proofs
- **Attribute-centric**: Focuses on relationships between attributes
- **Prescriptive**: Provides clear rules (normal forms) to check compliance

### The Entity-Relationship View: Domain Modeling

The **entity-relationship view**, introduced by Peter Chen in 1976, revolutionized how we think about database design by shifting from abstract mathematical concepts to concrete domain modeling: @10.1145/320434.320440, @10.1007/978-3-642-59412-0_17

```{figure} ../images/PChen.jpeg
:name: Peter Chen
:width: 300

Peter Chen, born in 1943, Taiwanese-American computer scientist, inventor of the Entity-Relationship Model.
```

#### Core Definitions

**Entity Set**: An unordered collection of identifiable items (entities) that share the same attributes and are distinguished by a primary key.

**Relationship Set**: A collection of associations that link entities from different entity sets, defined by referential constraints (foreign keys).

**Entity Type**: A well-defined category of things in the domain (e.g., Student, Course, Department).

#### Design Philosophy

The entity-relationship approach frames database design as identifying **what entity types exist** in the domain and **how they relate to each other**.

**Entity Normalization Principle**: "Each table represents exactly one well-defined entity type, identified by the table's primary key. All non-key attributes must describe that entity type directly, completely, and non-optionally."

#### Characteristics
- **Concrete**: Starts with recognizable entities in the domain
- **Intuitive**: Maps to how people naturally think about their domain
- **Entity-centric**: Focuses on identifying entity types and their properties
- **Constructive**: Provides guidance on how to decompose a domain

```{figure} ../images/employee-project-erd.svg
:align: center 

Entity-relationship diagram in Chen ER notation.
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

### The Entity-Workflow View: Temporal and Operational Modeling

The **entity-workflow view**, pioneered by DataJoint, extends entity normalization with a sequential dimension: the **Entity-Workflow Model**. While traditional ERM focuses on **what entities exist**, DataJoint emphasizes **when and how entities are created** through workflow execution.

#### Core Definitions

**Workflow Entity**: An entity that is created at a specific step in a workflow, representing an artifact of workflow execution.

**Workflow Dependency**: A foreign key relationship that not only ensures referential integrity but also prescribes the order of operations (parent must be created before child).

**Workflow Step**: A distinct phase in a workflow where specific entity types are created.

**Directed Acyclic Graph (DAG)**: The schema structure that represents valid workflow execution sequences, prohibiting circular dependencies.

#### Design Philosophy

The entity-workflow approach frames database design as mapping **workflow steps to tables** and ensuring **temporal coherence** in entity creation.

**Workflow Normalization Principle**: "Every table represents an entity type that is created at a specific step in a workflow, and all attributes describe that entity as it exists at that workflow step."

#### Characteristics
- **Temporal**: Views entities as artifacts created by operations
- **Operational**: Focuses on workflow sequence and dependencies
- **Workflow-centric**: Emphasizes when/how entities are created
- **Immutability-oriented**: Treats workflow artifacts as immutable once created

```{figure} ../images/employee-project-datajoint.svg
:align: center

DataJoint diagram for the same design
```

### Semantic Differences and Convergence

While all three views rely on the same underlying constructs (tables, data types, primary keys, foreign keys), they provide fundamentally different **semantics**:

#### Different Semantics

| Aspect | Mathematical View | Entity-Relationship View | Entity-Workflow View |
|--------|------------------|-------------------------|---------------------|
| **Core Question** | "What functional dependencies exist?" | "What entity types exist?" | "When/how are entities created?" |
| **Foreign Keys** | Referential integrity constraints | Entity relationship mappings | Workflow dependency + referential integrity |
| **Time Dimension** | Not addressed | Not central | Fundamental |
| **Design Method** | Identify dependencies, decompose | Identify entities, separate entity types | Identify workflow steps, separate by workflow steps |
| **Reasoning Style** | Abstract, mathematical | Concrete, intuitive | Temporal, operational |

#### Convergent Results

Despite their different conceptual foundations, all three approaches **converge on the same practical principles**:

1. **Elimination of Anomalies**: All approaches identify and eliminate update, insertion, and deletion anomalies
2. **Reduction of Redundancy**: Each approach minimizes data duplication through proper decomposition
3. **Clear Structure**: All lead to schemas that reflect domain organization
4. **Data Integrity**: Each approach ensures consistency through appropriate constraints

#### Practical Implications

**For Database Design**:
- **Mathematical**: Start with functional dependency analysis
- **Entity-Relationship**: Start with entity identification
- **Entity-Workflow**: Start with workflow step identification

**For Data Manipulation**:
- **Mathematical**: Focus on maintaining functional dependency integrity
- **Entity-Relationship**: Focus on maintaining entity coherence
- **Entity-Workflow**: Focus on maintaining workflow sequence integrity

**For Query Formation**:
- **Mathematical**: Use relational algebra operations
- **Entity-Relationship**: Use entity relationship traversal
- **Entity-Workflow**: Use workflow dependency traversal

### Choosing Your Perspective

The choice of perspective depends on your context and needs:

- **Mathematical View**: Best for theoretical foundations, automated schema verification, and formal analysis
- **Entity-Relationship View**: Best for initial schema design, domain modeling, and intuitive understanding
- **Entity-Workflow View**: Best for computational workflows, scientific data pipelines, and temporal data management

All three approaches lead to robust, maintainable schemas that accurately represent your domain, but they provide different lenses for understanding what makes a schema well-designed.

## Diagramming Notations and Implementation Gaps

An important distinction between the three views lies in their support for **diagramming notations** and the **alignment between conceptual design and implementation**.

### Diagramming Support

**Mathematical View**: The mathematical approach provides **no diagramming notation**. It relies purely on functional dependency analysis and abstract reasoning about attribute relationships. Designers must work with dependency diagrams and normalization theory without visual schema representations.

**Entity-Relationship View**: ERM introduced **comprehensive diagramming notation** through Entity-Relationship diagrams (ERDs). These diagrams provide:
- Visual representation of entity types and their attributes
- Clear depiction of relationships between entities
- Multiple notation styles (Chen notation, Crow's Foot notation)
- Standardized symbols for cardinality and participation

**Entity-Workflow View**: DataJoint provides **integrated diagramming notation** through schema diagrams that:
- Visualize workflow dependencies using solid/dashed lines
- Show primary and secondary dependencies clearly
- Represent the DAG structure of workflow execution
- Integrate seamlessly with the data definition language

### The Conceptual-Implementation Gap

A significant challenge in current database practice stems from the **mismatch between conceptual design and implementation**:

**ERM Dominance in Conceptual Design**: The Entity-Relationship Model has become the **dominant approach for conceptual database design**. Most database textbooks, design methodologies, and modeling tools are based on ERM principles. Designers naturally think in terms of entities and relationships.

**SQL's Mathematical Foundation**: However, SQL and most relational database systems are designed around the **mathematical semantics** of Codd's original model. SQL queries operate on relations as mathematical predicates, not as entity sets. This creates a fundamental disconnect:

- **Conceptual Design**: "What entities exist and how do they relate?"
- **SQL Implementation**: "What functional dependencies exist and how can they be queried?"

**The Gap**: This mismatch creates several problems:
- **Translation Complexity**: Converting ERM designs to SQL schemas requires mental translation between entity concepts and relational predicates
- **Query Complexity**: SQL queries often don't naturally express entity relationships, requiring complex joins and subqueries
- **Maintenance Challenges**: Changes in entity understanding don't map directly to SQL schema modifications
- **Learning Curve**: Developers must master both ERM concepts and SQL's mathematical semantics

### DataJoint's Unified Approach

DataJoint addresses this gap by providing **unified diagramming, definition, and query languages** that all support the Entity-Workflow Model:

**Unified Design Language**: 
- Schema diagrams directly represent the data definition
- Arrow notation (`->`) in definitions corresponds to arrows in diagrams
- No translation needed between conceptual design and implementation

**Unified Query Language**:
- Queries operate on entity sets, not abstract relations
- Entity relationships are expressed through foreign key traversal
- Query results maintain entity normalization properties

**Unified Workflow Semantics**:
- Diagrams show workflow dependencies
- Definitions enforce workflow order through foreign keys
- Queries respect workflow execution sequences

**Practical Benefits**:
- **Seamless Design-to-Implementation**: No conceptual gap between design and code
- **Intuitive Query Formation**: Queries naturally express entity relationships
- **Consistent Semantics**: Same entity-workflow concepts throughout the entire development process
- **Reduced Learning Curve**: Single conceptual framework for design, implementation, and querying

This unified approach eliminates the traditional disconnect between conceptual modeling and practical implementation, making database development more intuitive and consistent.

## DataJoint Implementation: Bridging Theory and Practice

DataJoint represents a practical implementation of the entity-workflow view, developed over a decade of neuroscience research to address the specific challenges of scientific data pipelines [@10.48550/arXiv.1807.11104].

### Key Implementation Features

**1. Entity Normalization Enforcement**
- Every table represents exactly one entity type with consistent attributes
- Primary keys uniquely identify entity instances
- Reduces redundancy and eliminates data anomalies through intuitive entity-based reasoning

**2. Simplified Schema Definition**
- Schema definition language more expressive than SQL
- Dependencies explicitly declared using arrow notation (`->`)
- Dependency structure enforced as acyclic directed graph (DAG)

**3. Integrated Query Algebra**
- Five core operators: restrict, join, project, aggregate, and union
- Algebraic closure allows seamless operator combination
- Maintains operational entity normalization in query results

**4. Workflow-Centric Design**
- Database treated as data pipeline where each table defines a workflow step
- Foreign keys represent both referential integrity and workflow dependencies
- Schema diagrams visualize workflow dependencies using solid/dashed lines

**5. Homologous Attribute Logic**
- Binary operations require attributes to share the same origin
- Eliminates ambiguity of natural joins in SQL
- Ensures predictable and consistent query results

**6. Scientific Workflow Optimization**
- Ideal for computational workflows and scientific experiments
- MATLAB and Python libraries transpile DataJoint queries to SQL
- Bridges gap between scientific programming and relational databases

### Practical Benefits

DataJoint's implementation demonstrates how the entity-workflow view translates into practical advantages:

- **Conceptual Clarity**: Entity-based reasoning makes schema design intuitive
- **Workflow Integrity**: DAG structure prevents circular dependencies and ensures valid operation sequences  
- **Data Consistency**: Immutable workflow artifacts maintain data integrity
- **Collaborative Development**: Researchers without database expertise can effectively collaborate on data pipelines
- **Scientific Provenance**: Natural preservation of workflow execution history

# Exercises

1.  Extend the binary relation  `Clinic-Species` to a higher order, e.g. a ternary relation.

:::{hint} Possible soluton 

Add a third domain, `Treatment`, for the treatments that clinics offer for each species.
This will allow forming a ternary relation `Clinic-Species-Treatment`.

Now think of yet another way to extend the relation to a higher order.
:::

2. Imagine that you have two binary relations: `Clinic-Species` and `Species-Treatment`.
How can these two binary relations be joined into a ternary relation: `Clinic-Species-Treatment`?
What would the rules be for forming this result?
What will be the cardinality (number of tuples) of the result?

3. Imagine that we decide to remove the domain `Species` from the relation `Clinic-Species-Treatment`, producing a new binary relation `Clinic-Treatment`.  How will the number of tuples be affected? What will be the 
What would be the rules for this operation?
How would the cardinality (number of elements) change in the result?

4. Work through the example of a database model in Chen's EM notation in @10.1093/jamia/ocx033.  
  What are its entities and relationships? Explain what operations this database supports.

5. Work through the example of an multiplayer online role-playing game  database model in Chen's EM notation listed on the [ERM Wikipedia page](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model#Crow's_foot_notation)

5. Learn to create diagrams in Crow's Foot notation using Mermaid: https://mermaid.js.org/syntax/entityRelationshipDiagram.html
