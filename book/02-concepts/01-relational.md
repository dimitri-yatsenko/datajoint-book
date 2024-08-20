---
title: Relational Theory
date: 2024-08-20
authors:
  - name: Dimitri Yatsenko
---

# Origins of  Relational Theory

Relations are a key concept in mathematics, representing how different elements from one set are connected to elements of another set of elements.
Imagine you have two set: one set representing clinics and another representing animal species.
A relation between these two sets would indicate, for example, which clinics treat which species.

```{figure} ../images/relations.png
:name: relations
:width: 75 %
:alt: mathematical relations

Relations are mappings of elements of one set to elements of another domain (binary relations). Higher order relations map elements of three, four and and more sets.
```

This diagram illustrates two different relations between "Clinics" and "Species." On the left side, the relation shows Clinic 1 is connected to "Dog," Clinic 2 is connected to "Horse," and Clinic 3 is connected to both "Goat" and "Cow." On the right side, the relation changes: Clinic 1 is now connected to "Dog," "Cat," and "Goat," Clinic 2 is connected to "Dog" and "Horse," and Clinic 3 is connected to "Goat."
Each line connecting elements of the two sets is called a *tuple* and represents an ordered pairing of values from the corresponding domains.
Then a relation can be thought of as a set of tuples.
The number of tuples in a relation is called its *cardinality* and the number of domains participating in the relation is its *order*.
This diagram shows binary relations.
Relations can be binary, ternary, or of higher orders.

Mathematically, a relation between two sets \( A \) (e.g., clinics) and \( B \) (e.g., species) is a subset of their Cartesian product \( A $\times$ B \). This means the relation is a collection of ordered pairs \((a, b)\), where each \( a \) is an element from set \( A \), and each \( b \) is an element from set \( B \). In the context of the diagram, each pair represents a specific connection, such as (Clinic 1, Dog) or (Clinic 3, Cow).

These relations are not fixed and can change depending on the context or criteria, as shown by the two different values in the diagram. The flexibility and simplicity of relations make them a powerful tool for representing and analyzing connections in various domains.

The concept of relations has a rich history that dates back to the mid-19th century. The groundwork for relational theory was first laid by Augustus De Morgan, an English mathematician and logician, who introduced early ideas related to relations in his work on logic and algebra. De Morgan's contributions were instrumental in setting the stage for the formalization of relations in mathematics.

```{figure} ../images/demorgan.jpg
:name: Augustus De Morgan
:scale: 50 %

[Augustus De Morgan](https://en.wikipedia.org/wiki/Augustus_De_Morgan) developed the fundamental concepts of relational theory, including operations on relations.

```

The development of relational theory as a formal mathematical framework is largely credited to Georg Cantor, a German mathematician, in the late 19th century. Cantor is known as the father of set theory, which is the broader mathematical context in which relations are defined. His work provided a rigorous foundation for understanding how sets (collections of objects) interact with each other through relations.

Cantor's set theory introduced the idea that relations could be seen as subsets of Cartesian products, where the Cartesian product of two sets \( A \) and \( B \) is the set of all possible ordered pairs \((a, b)\) where \( a \) is from \( A \) and \( b \) is from \( B \). This formalization allowed for the systematic study of relations and their properties, leading to the development of modern mathematical logic, database theory, and many other fields.

```{figure} ../images/georg_cantor.jpg
:name: Georg Cantor
:scale: 50 %

[Georg Cantor](https://en.wikipedia.org/wiki/Georg_Cantor) reframed relations in the context of Set Theory
```

#  Mathematical Rigor
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

# Relational Database Model
The **relational data model** is the brainchild of the British-American mathematician and engineer [Edgar F. Codd.](https://amturing.acm.org/award_winners/codd_1000892.cfm), earning him the Turing Award.

Working at IBM, Codd explored the possibility of working on data using concepts from set theory  {cite:p}`codd_relational_1970`.
Codd was inspired by the concept of *set relations* and the \emph{calculus of relations} proposed by the British logician **Augustus De Morgan** and further developed by the American logician **Charles Sanders Peirce**  in the mid-XIX century {cite:p}`de1860syllabus`, {cite:p}`peirce1870description` --- theories rooted in well-established concepts of logic and set theory.
A mathematical **relation** is defined as a subset of the **Cartesian product** of multiple sets.
As with other types of sets in **set theory**, relations can be transformed and manipulated using set operators such as *union*, *intersection*, *difference*, *etc*.

```{figure} ../images/Ted-Codd.jpg
:name: Ted Codd

[Edgar F. Codd](https://en.wikipedia.org/wiki/Edgar_F._Codd) revolutionized database theory and practice by applying relational theory to data management and operations.
```

Codd's model was largely derived from relational theory but differed sufficiently in its basic definitions to make a new type of algebra.
The relational data model gave mathematicians a rigorous theory for optimizing data organization and storage and to construct queries.
Through the 1970s, before relational databases became practical, theorists derived fundamental rules for rigorous data organization and queries from first principles using mathematical proofs and derivations.
For this reason, early work on relational databases has an abstract academic feel to it with rather simple toy examples: the ubiquitous employees/departments, products/orders, and students/courses.
The design principles were defined through the rigorous but rather abstract principles, the **normal forms** {cite:p}`kent1983simple`.

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

:::{table} The difference in terminology  used in relational theory and relational databases.
:widths: auto
:align: center
|  Relational Theory | Database Programming  | Description  |
|:--|:--|:--|
| **Relation**                   | **Table** | A set of tuples that share the same attributes from each of the domains in the relation. |
| **Domain**   | **Data Type** | The set of permissible values that an attribute can take in any tuple of a relation.  |
| **Attribute**                  | **Column** | The positional values in the tuples of relation drawn from their corresponding domain.  |
| **Attribute value** | **Field** | The positional value in a specific tuple. |
| **Tuple**                      | **Record** or **Row**  | A single element of a relation, containing a value for each attribute.  |
:::

## Exercises

:::{tip} Exercise
Extend the `Clinic-Species` relation to a higher order, e.g. a ternary relation.
:::
:::{tip} A Solution
:class: dropdown
For example, you could add another domain for the treatments that clinics offer for each species.
This will form a ternary relation `Clinic-Species-Treatment`.
Think of another example.
:::

:::{tip} Exercise
Imagine that you have two binary relations: `Clinic-Species` and `Species-Treatment`

How can these two binary relations be joined into a ternary relation: `Clinic-Species-Treatment`?
What would the rules be for forming this result?
What will be the cardinality (number of elements) of the result?
:::

:::{tip}Exercise
Imagine that we decide to remove the do
What would be the rules for this operation?
How would the cardinality (number of elements) change in the result?
:::
