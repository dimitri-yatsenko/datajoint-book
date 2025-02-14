---
title: Relational Theory
date: 2024-08-20
authors:
  - name: Dimitri Yatsenko
---

# Origins of  Relational Theory

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

#  Mathematical Foundations
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

# Relational Algebra and Calculus

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

# Relational Database Model
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

# The Entity-Relationship Model

The relational data model, while powerful, offers a lot of flexibility that can be both a blessing and a curse. Experienced developers with strong conceptual skills can use this freedom to create highly effective database designs. However, this same flexibility can lead to a wide range of incompatible approaches to schema design and data queries, making it challenging for others to follow best practices and achieve proficiency.

To address this challenge, [Peter Chen](https://en.wikipedia.org/wiki/Peter_Chen), a Taiwanese-born American computer scientist with a Ph.D. from Harvard, introduced the Entity-Relationship Model (ERM) in 1976: @10.1145/320434.320440, @10.1007/978-3-642-59412-0_17.
His work on the ERM has had a lasting impact on the field, providing a systematic way to model real-world relationships and convert them into database schemas.

```{figure} ../images/PChen.jpeg
:name: Peter Chen
:width: 300

Peter Chen, born in 1943, Taiwanese-American computer scientist, inventor of the Entity-Relationship Model.
```
The ERM is based on the intuitive idea that the world can be understood in terms of *entities* (things we want to track) and the *relationships* between them.
It prescribes a method for mapping this understanding directly into relational database concepts, making it easier to design and communicate database schemas.

In ERM, the concept of a *relation* is most replaced with those of *entity sets* and *relationship sets*. 

The ERM provides:

1. **A General Approach for Problem Analysis and Conceptual Modeling:** The ERM offers a structured way to analyze problems and model them conceptually before diving into schema design. This ensures that the database accurately reflects the real-world relationships it’s meant to represent.
   
2. **Diagramming Notation for Schema Design:** The ERM introduces a visual way to represent entities, their attributes, and the relationships between them. These diagrams, known as ER diagrams, are invaluable tools for database designers, helping them visualize and communicate their designs effectively.

3. **Guidelines for Composing Meaningful Queries:** The ERM not only helps with schema design but also provides a method for forming valid data queries. These queries rely on foreign keys to match entities through the relationships they participate in, ensuring that the data retrieved is both accurate and meaningful.

An **entity set** in the ERM is an unordered collection of identifiable items (entities) that share the same attributes and are distinguished by a primary key.
These entity sets can participate in relationships with other entity sets, forming the backbone of a relational database.

A **relationship set** in the ERM is a collection of associations that link entities from different entity sets. These associations are defined by referential constraints, also known as foreign keys, which ensure that relationships between entities are maintained consistently.

Although the ERM is best known for its approach to schema design, it also plays a crucial role in query formation. By relying on foreign keys and clearly defined relationships, queries can accurately retrieve data based on the connections between entities.

ERM diagrams have become an essential tool for database designers, enabling clear communication between designers, clients, and management. By providing a structured, visual approach to database design, the ERM has made it easier to build databases that are both effective and easy to understand.

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

:::{figure}
```{mermaid}
---
title: Crow's Foot notation.
---
erDiagram
    EMPLOYEE ||--o{ EMP-PROJ : works-for
    PROJECT ||--o{ EMP-PROJ  : is-run-by 
```
Entity-relationship diagram in Crow's Foot notation, including an explicit relationship set. 
:::

```{figure} ../images/employee-project-datajoint.svg
:align: center

DataJoint diagram for the same design
```


# The DataJoint Model
DataJoint is a conceptual refinement of the relational data model offering a more expressive and rigorous framework for database programming [@10.48550/arXiv.1807.11104].
The DataJoint model facilitates clear conceptual modeling, efficient schema design, and precise and flexible data queries. The model has emerged over a decade of continuous development of complex data pipelines for neuroscience experiments [@10.1101/031658]. DataJoint has allowed researchers with no prior knowledge of databases to collaborate effectively on common data pipelines sustaining data integrity and supporting flexible access. DataJoint is currently implemented as client libraries in MATLAB and Python. These libraries work by transpiling DataJoint queries into SQL before passing them on to conventional relational database systems that serve as the backend, in combination with bulk storage systems for storing large contiguous data objects.

DataJoint solves a major dilemma in how relational databases are taught today:

Compared to SQL and ERM, the DataJoint model focuses on **conceptual clarity, efficiency, and workflow management**. By enforcing **entity normalization**, simplifying dependency declarations, offering a rich query algebra, and visualizing relationships through schema diagrams, DataJoint makes relational database programming more intuitive and robust for complex data pipelines.

## 1. **Entity Normalization**  
- DataJoint enforces **entity normalization**, ensuring that every entity set (table) is well-defined, with each element belonging to the same type, sharing the same attributes, and distinguished by the same primary key.
- This principle reduces redundancy and avoids data anomalies, similar to Boyce-Codd Normal Form, but with a more intuitive structure than traditional SQL.

## 2. **Simplified Schema Definition and Dependency Management**  
- DataJoint introduces a **schema definition language** that is more expressive and less error-prone than SQL.  
- Dependencies are explicitly declared using **arrow notation (->)**, making referential constraints easier to understand and visualize.
- The dependency structure is enforced as an **acyclic directed graph**, which simplifies workflows by preventing circular dependencies.

## 3. **Integrated Query Operators producing a Relational Algebra**  
- DataJoint introduces **five query operators** (restrict, join, project, aggregate, and union) with algebraic closure, allowing them to be combined seamlessly.  
- These operators are designed to maintain **operational entity normalization**, ensuring query outputs remain valid entity sets.

## 4. **Diagramming Notation for Conceptual Clarity**  
- DataJoint’s **schema diagrams** simplify the representation of relationships between entity sets compared to ERM diagrams.  
- Relationships are expressed as dependencies between entity sets, which are visualized using solid or dashed lines for **primary** and **secondary dependencies**, respectively.

## 5. **Unified Logic for Binary Operators**  
- DataJoint simplifies **binary operations** by requiring attributes involved in joins or comparisons to be **homologous** (i.e., sharing the same origin).  
- This avoids the ambiguity and pitfalls of **natural joins** in SQL, ensuring more predictable query results.

## 6. **Optimized Data Pipelines for Scientific Workflows**  
- DataJoint treats the database as a **data pipeline** where each entity set defines a step in the workflow. This makes it ideal for **scientific experiments** and **complex data processing**, such as in neuroscience.
- Its **MATLAB and Python libraries** transpile DataJoint queries into SQL, bridging the gap between scientific programming and relational databases.

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
