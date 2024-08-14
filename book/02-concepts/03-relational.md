---
title: Relational Theory
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Definition of Relations

Relations are a key concept in mathematics, representing how different elements from one set are connected to elements of another set. Imagine you have two groups: one group representing clinics and another representing animal species. A relation between these two groups would show which clinics treat which species.

```{figure} ../images/relations.png
---
:name: mathematical relations
---
```

This diagram illustrates two different relations between "Clinics" and "Species." On the left side, the relation shows Clinic 1 is connected to "Dog," Clinic 2 is connected to "Horse," and Clinic 3 is connected to both "Goat" and "Cow." On the right side, the relation changes: Clinic 1 is now connected to "Dog," "Cat," and "Goat," Clinic 2 is connected to "Dog" and "Horse," and Clinic 3 is connected to "Goat."

Mathematically, a relation between two sets \( A \) (e.g., clinics) and \( B \) (e.g., species) is a subset of their Cartesian product \( A $\times$ B \). This means the relation is a collection of ordered pairs \((a, b)\), where each \( a \) is an element from set \( A \), and each \( b \) is an element from set \( B \). In the context of the diagram, each pair represents a specific connection, such as (Clinic 1, Dog) or (Clinic 3, Cow).

These relations are not fixed and can change depending on the context or criteria, as shown by the two different values in the diagram. The flexibility and simplicity of relations make them a powerful tool for representing and analyzing connections in various domains.

# The History of Relational theory

The concept of relations has a rich history that dates back to the mid-19th century. The groundwork for relational theory was first laid by Augustus De Morgan, an English mathematician and logician, who introduced early ideas related to relations in his work on logic and algebra. De Morgan's contributions were instrumental in setting the stage for the formalization of relations in mathematics.

The development of relational theory as a formal mathematical framework is largely credited to Georg Cantor, a German mathematician, in the late 19th century. Cantor is known as the father of set theory, which is the broader mathematical context in which relations are defined. His work provided a rigorous foundation for understanding how sets (collections of objects) interact with each other through relations.

Cantor's set theory introduced the idea that relations could be seen as subsets of Cartesian products, where the Cartesian product of two sets \( A \) and \( B \) is the set of all possible ordered pairs \((a, b)\) where \( a \) is from \( A \) and \( b \) is from \( B \). This formalization allowed for the systematic study of relations and their properties, leading to the development of modern mathematical logic, database theory, and many other fields.

# The Mathematical Power of Relational Theory

Relational theory is not just a mathematical curiosity; it is a powerful tool that underpins many important concepts in mathematics and computer science. The ability to describe and analyze how different objects are connected is fundamental to many areas of study.

One of the most important applications of relational theory is in the concept of **functions**. A function is a specific type of relation where each element in the domain (the first set) is associated with exactly one element in the codomain (the second set). Functions are essential in nearly every area of mathematics, from calculus to linear algebra.

Relational theory is also crucial in **graph theory**, where relations between objects can be visualized as graphs. In a graph, the objects are represented as vertices, and the relations between them are represented as edges. This visualization helps in understanding complex networks, such as social networks, computer networks, and even biological networks.

Moreover, relational theory is the foundation of **database systems**. The relational model of databases, developed by Edgar F. Codd in the 1970s, uses relations (tables) to organize and query data efficiently. The power of relational databases lies in their ability to handle large amounts of data while maintaining the integrity and accessibility of the information through well-defined relations.

Relational theory also extends to concepts like **equivalence relations** and **order relations**. Equivalence relations partition a set into disjoint subsets called equivalence classes, while order relations arrange elements in a sequence. These concepts are fundamental in areas such as algebra, topology, and analysis.

# Relational Algebra

Relational algebra is a set of operations that can be used to manipulate and query relations in a formal way. It provides the foundation for querying relational databases, allowing us to combine, modify, and retrieve data stored in tables (relations).

The basic operations in relational algebra include:

- **Selection (σ):** Selects rows from a relation that satisfy a given condition.
- **Projection (π):** Selects specific columns from a relation.
- **Union (∪):** Combines the tuples from two relations into a single relation.
- **Set Difference (−):** Returns the tuples that are in one relation but not in another.
- **Cartesian Product (×):** Combines every tuple from one relation with every tuple from another.
- **Rename (ρ):** Renames the attributes of a relation.
- **Join (⨝):** Combines related tuples from two relations based on a common attribute.

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

:::{table} The difference in terminology  used in relational theory and relational databases.
:widths: auto
:align: center
|  Theory | Databases  | Description  |
|:--|:--|:--|
| **Relation**                   | **Table** | A set of tuples that share the same attributes from each of the domains in the relation. |
| **Domain**   | **Data Type** | The set of permissible values that an attribute can take in any tuple of a relation.  |
| **Attribute**                  | **Column** | A specific property or characteristic of a relation, representing a data type for each value.      |
| **Attribute value** | **Field** | The value of an attribute in a specific tuple.
| **Tuple**                      | **Record** or **Row**                                | A single entry in a relation, consisting of a set of attribute values.                             |
:::
