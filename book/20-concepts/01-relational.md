# Relational Model

## Origins of  Relational Theory

Relations are a key concept in mathematics, representing how different elements from one set are connected to elements of another set. When two sets are of elements are related to each other, this forms a *second-order* or *binary* relation. Higher orders are also possible: third, fourth, and $n^{th}$ order relations.

If you are conversant in Set Theory, then an $n^{th}$ order relation is formally defined as a subset of a Cartesian product of $n$ sets. 
Many useful operations can be modeled as operations on such relations.

Imagine two sets: one set representing clinics and another representing animal species.
A relation between these two sets would indicate, for example, which clinics treat which species.

```{figure} ../images/relations.png
:name: relations
:width: 75 %
:alt: mathematical relations

Relations are mappings of elements of one set to elements of another domain (binary relations). Higher order relations map elements of three, four and and more sets.
```

This diagram illustrates two different relations between "Clinics" and "Species."
On the left side, the relation shows Clinic 1 is connected to "goat," Clinic 2 is connected to "dog," and Clinic 3 is connected to both "goat" and "cow."
On the right side, the relation changes: Clinic 1 is now connected to "dog," "horse," and "goat," Clinic 2 is connected to "dog" and "horse," and Clinic 3 is connected to "goat."
Each line connecting elements of the two sets is called a **tuple** and represents an ordered pairing of values from the corresponding domains.
Then a relation can be thought of as a set of tuples.
The number of tuples in a relation is called its *cardinality* and the number of domains participating in the relation is its *order*.
This diagram shows binary relations.
Relations can be binary, ternary, or of higher orders.

Mathematically, a relation between two sets: $A$ (e.g., *clinics*) and $B$ (e.g., *species*) is a subset of their Cartesian product $A \times B$.
This means the relation is a collection of ordered pairs $a, b$, where each $a$ is an element from set $A$, and each $b$ is an element from set $B$.
In the context of the diagram, each pair represents a specific connection, such as (Clinic 1, Dog) or (Clinic 3, Cow).

These relations are not fixed and can change depending on the context or criteria, as shown by the two different values in the diagram. The flexibility and simplicity of relations make them a powerful tool for representing and analyzing connections in various domains.

The concept of relations has a rich history that dates back to the mid-19th century. The groundwork for relational theory was first laid by Augustus De Morgan, an English mathematician and logician, who introduced early ideas related to relations in his work on logic and algebra. De Morgan's contributions were instrumental in setting the stage for the formalization of relations in mathematics.

```{figure} ../images/demorgan.jpg
:name: Augustus De Morgan
:width: 300px

[Augustus De Morgan](https://en.wikipedia.org/wiki/Augustus_De_Morgan) (1806-1871) developed the original fundamental concepts of relational theory, including operations on relations.
```

The development of relational theory as a formal mathematical framework is largely credited to Georg Cantor, a German mathematician, in the late 19th century. Cantor is known as the father of set theory, which is the broader mathematical context in which relations are defined. His work provided a rigorous foundation for understanding how sets (collections of objects) interact with each other through relations.

Cantor's set theory introduced the idea that relations could be seen as subsets of Cartesian products, where the Cartesian product of two sets $A$ and $B$ is the set of all possible ordered pairs $(a, b)$ where $a$ is from $A$ and $b$ is from $B$. This formalization allowed for the systematic study of relations and their properties, leading to the development of modern mathematical logic, database theory, and many other fields.

```{figure} ../images/georg_cantor.jpg
:name: Georg Cantor
:width: 300px

[Georg Cantor](https://en.wikipedia.org/wiki/Georg_Cantor) (1845-1918) reframed relations in the context of Set Theory
```

##  Mathematical Foundations
Relational theory is not just a mathematical curiosity; it is a powerful tool that underpins many important concepts in mathematics and computer science. The ability to describe and analyze how different objects are connected is fundamental to many areas of study.

One of the most important applications of relational theory is in the concept of **functions**. A function is a specific type of relation where each element in the domain (the first set) is associated with exactly one element in the codomain (the second set). Functions are essential in nearly every area of mathematics, from calculus to linear algebra.

Relational theory is a superset of **graph theory**, where relationships between objects can be visualized as graphs.
A directed graph can be thought of as a binary relation between a set of vertices and the same set of vertices again.
Each tuple in such relation represents an edge in the graph.
Graph theory helps in understanding complex networks, such as social networks, computer networks, and even biological networks.
Thus theorems discovered or proven in relational theory also apply to graphs.

Relational theory also extends to concepts like **equivalence relations** and **order relations**. Equivalence relations partition a set into disjoint subsets called equivalence classes, while order relations arrange elements in a sequence. These concepts are fundamental in areas such as algebra, topology, and analysis.

Relational theory has been shown to deeply interconnected to  **first-order logic** and **predicate calculus** at the foundations of mathematics and logic.
Relational theory, which focuses on the study of relations between elements of sets, forms the basis for the predicates used in first-order logic and predicate calculus.
In first-order logic, predicates represent relations, and the logical statements describe how these relations interact.
The equivalence between relational theory and first-order logic was notably formalized by Alfred Tarski in the 1930s.
Tarski demonstrated that every relation can be described by a formula in first-order logic, establishing a profound connection between these mathematical frameworks that has since underpinned much of modern theoretical computer science and logic.

## Relational Algebra and Calculus

**Relational algebra** is a set of operations that can be used to transform relations in a formal way.
It provides the foundation for querying relational databases, allowing us to combine, modify, and retrieve data stored in tables (relations).

Examples of relational operators:

- **Selection (σ):** Selects tuples from a relation that satisfy a given condition.
- **Projection (π):** Selects specific attributes from a relation.
- **Union (∪):** Combines the tuples from two relations into a single relation.
- **Set Difference (−):** Returns the tuples that are in one relation but not in another.
- **Cartesian Product (×):** Combines every tuple from one relation with every tuple from another.
- **Rename (ρ):** Renames the attributes of a relation.
- **Join (⨝):** Combines related tuples from two relations based on a common attribute.

Such operators together represent an algebra: ways to transform relations into other relations.
Some operators are binary, i.e. they accept two relations as inputs to produce another relation as output.
The operators are *algebraically closed*, i.e. the operators take relations as inputs and produce relations as outputs.
This means elementary operators can be combined in sophisticated ways to compose complex expressions.
**Algebraic closure** is an important concept behind the expressive power of relational operators.

To illustrate a relational operator, let’s consider the **union operator (∪)** using the two relational values from the diagram. The union of these two relations would combine all the connections from both diagrams into a single relation.

In the first value (left side of the diagram), we have the following connections:

- Clinic 1 → Dog
- Clinic 2 → Horse
- Clinic 3 → Goat, Cow

In the second value (right side of the diagram), the connections are:

- Clinic 1 → Dog, Cat, Goat
- Clinic 2 → Dog, Horse
- Clinic 3 → Goat

The union of these two relations would include all the connections:

- Clinic 1 → Dog, Cat, Goat
- Clinic 2 → Dog, Horse
- Clinic 3 → Goat, Cow

This operation effectively merges the connections from both sets of values, providing a comprehensive view of all possible relations between clinics and species.

Relational algebra, with its powerful operators, allows us to query and manipulate data in a structured and efficient way, forming the backbone of modern database systems. By understanding and applying these operators, we can perform complex data analysis and retrieval tasks with precision and clarity.

Another formal language for deriving new relations from scratch or from from other  relations is **relational calculus**. 
Rather than using relational operators, it relies on a *set-building notation* to generate relations.

:::{note}
The query notation of the SQL programming language combines concepts from both relational algebra and relational calculus.
However, DataJoint's query language is based purely on relational algebra.
:::

## Relational Database Model
The **relational data model** is the brainchild of the British-American mathematician and engineer [Edgar F. Codd.](https://amturing.acm.org/award_winners/codd_1000892.cfm), earning him the prestigeous Turing Award in 1981.

Working at IBM, Codd explored the possibility of translating the mathematic rigor of relational theory into powerful system for large-scale data management and operation [@10.1145/362384.362685].

```{figure} ../images/Ted-Codd.jpg
:name: Edgar F. Codd
:width: 300px

[Edgar F. Codd](https://en.wikipedia.org/wiki/Edgar_F._Codd) (1923-2003) revolutionized database theory and practice by translating the mathematical theory of relations to data management and operations.
```

Codd's model was derived from relational theory but differed sufficiently in its basic definitions to give birth to a new type of algebra.
The relational data model gave mathematicians a rigorous theory for optimizing data organization and storage and to construct queries.
Through the 1970s, before relational databases became practical, theorists derived fundamental rules for rigorous data organization and queries from first principles using mathematical proofs and derivations.
For this reason, early work on relational databases has an abstract academic feel to it with rather simple toy examples: the ubiquitous employees/departments, products/orders, and students/courses.
The design principles were defined through the rigorous but rather abstract principles, the **normal forms** [@10.1145/358024.358054].

The relational data model is one of the most powerful and precise ways to store and manage structured data.
At its core, this model organizes all data into tables--representing mathematical relations---where each table consists of rows (representing mathematical *tuples*) and columns (often called *attributes*).

The relational model is built on several key principles, including:

- **Data Representation:** All data is represented in the form of simple tables, with each table having a unique name and a well-defined structure.
- **Domain Constraints:** Each column in a table is associated with a specific domain (or *datatype*, a set of possible values), ensuring that the data entered is valid.
- **Uniqueness Constraints:** ensure that each row in a table is unique, enforced through a primary key.
- **Referential Constraints:** ensure that relationships between tables remain consistent, enforced through foreign keys.
- **Declarative Queries:** The model allows users to write queries that specify *what* data they want rather than *how* the database will retrieve it.

The most common way to interact with relational databases is through the Structured Query Language (SQL).
SQL is a language specifically designed to define, manipulate, and query data within relational databases.
It includes sublanguages for defining data structure, manipulating data, and querying data.

When speaking with database programmers and computer scientists, you will often run into different terminologies.
Practical database programmers speak of tables and rows while theoretical data modelers may describe the same things as *relations* and *tuples*.

:::{table} The difference in terminology  used in relational theory and relational databases.
:widths: auto
:align: center
|  Relational Theory | Database Programming & SQL  | Description  |
|:--|:--|:--|
| **Relation**                   | **Table** | A set of tuples that share the same attributes from each of the domains in the relation. |
| **Domain**   | **Data Type** | The set of permissible values that an attribute can take in any tuple of a relation.  |
| **Attribute**                  | **Column** | The positional values in the tuples of relation drawn from their corresponding domain.  |
| **Attribute value** | **Field** | The positional value in a specific tuple. |
| **Tuple**                      | **Record** or **Row**  | A single element of a relation, containing a value for each attribute.  |
:::

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
