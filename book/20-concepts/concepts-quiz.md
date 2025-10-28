# Knowledge Check: Concepts

This assessment covers Chapters 0-4 of the Database Concepts section. Questions include both single-answer and multiple-answer formats.

**Instructions:**
- **Single-answer questions [SA]**: Select the ONE best answer
- **Multiple-answer questions [MA]**: Select ALL that apply
- Click "Show Answer" to reveal the correct answer and explanation

**Scoring:** 70 points maximum
- Single Answer: 40 questions (1 point each)
- Multiple Answer: 15 questions (2 points each if all correct)

---

## Chapter 0: Databases

### Question 1.1 [SA]
What is the primary distinguishing feature of a database compared to simple file storage?

A) Databases are larger in size  
B) Databases enforce business rules and ensure data integrity  
C) Databases use binary file formats  
D) Databases require internet connectivity

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The key distinction is that databases actively enforce rules and maintain integrity, not just store data. They ensure valid transactions and prevent inconsistencies.
```

---

### Question 1.2 [MA]
Which of the following are key traits of databases? (Select all that apply)

A) Structured data reflects the logic of operations  
B) Data cannot be modified once entered  
C) Supports distributed, concurrent access by multiple users  
D) Allows specific and precise queries  
E) Requires all data to be numeric

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D

**Explanation:** Databases organize data logically (A), support concurrent access (C), and enable precise querying (D). However, data can be modified (B is false), and databases handle all data types, not just numeric (E is false).
```

---

### Question 1.3 [SA]
What role does a Database Management System (DBMS) play?

A) It's the physical hardware that stores data  
B) It's a backup system for databases  
C) It's the software engine that defines structure, enforces rules, and executes queries  
D) It's a user interface for data entry

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** A DBMS is the computational engine that defines and enforces data structure, manages storage, and executes queries while maintaining integrity.
```

---

### Question 1.4 [SA]
In the airline booking example, why is a DBMS essential?

A) To make the website look attractive  
B) To enforce rules like "a seat cannot be double-booked" reliably  
C) To store passenger names alphabetically  
D) To print boarding passes

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The DBMS actively enforces business rules (like preventing double-booking) automatically, which is critical for operational integrity.
```

---

## Chapter 1: Data Models

### Question 2.1 [SA]
What is a data model?

A) A physical database server  
B) A conceptual framework defining how data is organized, represented, and transformed  
C) A specific database implementation  
D) A programming language for databases

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** A data model is the conceptual framework—the principles and constructs—for organizing and working with data, not the implementation itself.
```

---

### Question 2.2 [SA]
What is a schema?

A) A sample of actual data  
B) A database query  
C) A formal specification of data structure that exists separately from the data  
D) A programming language

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** A schema is the formal specification of structure (tables, columns, types, relationships) defined separately from any actual data instances.
```

---

### Question 2.3 [MA]
Which statements correctly describe the difference between structured and schemaless data models? (Select all that apply)

A) Structured models define schema before storing data  
B) Schemaless models have no structure at all  
C) Schemaless models embed structure within each data instance  
D) Structured models validate data against predefined rules  
E) Schemaless models are always better for scientific research

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D

**Explanation:** Structured models use predefined schemas (A) that validate data (D). Schemaless models do have structure, but it's self-describing within the data (C), not enforced externally. Neither approach is universally "better"—they serve different purposes (E is false).
```

---

### Question 2.4 [SA]
What is the key difference between metadata and schemas?

A) Metadata is newer technology than schemas  
B) Metadata describes relationships externally; schemas enforce them actively  
C) Schemas are only used for small datasets  
D) They are the same thing with different names

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Metadata provides descriptive information but relies on external interpretation. Schemas actively enforce structure and relationships through the database system itself.
```

---

### Question 2.5 [SA]
Using the passenger/luggage analogy from the book, what does a schema represent?

A) Destination tags on luggage  
B) The passenger's travel preferences  
C) The assigned seat that's guaranteed and can't be double-booked  
D) The passenger's name tag

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** The schema (assigned seat) provides active enforcement—preventing double-booking and ensuring the passenger and luggage travel together. Tags (metadata) just provide information.
```

---

### Question 2.6 [MA]
Which data models were discussed as essential examples in the book? (Select all that apply)

A) Binary files  
B) Spreadsheets  
C) Relational databases  
D) JSON/Document databases  
E) Quantum databases

```{admonition} Show Answer
:class: dropdown

**Answer:** A, B, C, D

**Explanation:** The book covers binary files (baseline), spreadsheets (familiar), relational (focus), and JSON (modern alternative). Quantum databases were not discussed.
```

---

### Question 2.7 [SA]
What is a major limitation of spreadsheets for complex scientific workflows?

A) They can't display numbers  
B) They have no referential integrity or workflow enforcement  
C) They're too expensive  
D) They only work on Windows

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Spreadsheets lack referential integrity—formulas can break when rows are deleted, and there's no enforcement of computational dependencies.
```

---

### Question 2.8 [MA]
According to the book, when should you use structured, schema-enforced approaches? (Select all that apply)

A) When data integrity is non-negotiable  
B) When relationships must remain valid as data evolves  
C) When exploring completely unknown data structures  
D) When provenance and reproducibility are essential  
E) When rapid prototyping with no quality concerns

```{admonition} Show Answer
:class: dropdown

**Answer:** A, B, D

**Explanation:** Structured approaches are essential when integrity (A), valid relationships (B), and provenance (D) matter. For pure exploration (C) or when quality doesn't matter (E), flexible approaches may suffice.
```

---

### Question 2.9 [SA]
What analogy did the book use to compare AI working with unstructured vs. structured data?

A) A teacher grading random vs. organized essays  
B) A detective with disorganized vs. organized evidence  
C) A chef with mixed vs. separated ingredients  
D) A musician with random vs. sheet music

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The book compared unstructured data to a detective sifting through a disorganized crime scene, versus structured data like organized evidence logs and reports.
```

---

### Question 2.10 [MA]
What challenges do scientists face with flexible, unstructured data approaches? (Select all that apply)

A) Heterogeneous datasets lacking consistency  
B) Difficulty sharing and publishing data  
C) Inability to store any data  
D) Need for "data standards" imposed afterward  
E) Too much structure limiting creativity

```{admonition} Show Answer
:class: dropdown

**Answer:** A, B, D

**Explanation:** Flexible approaches lead to heterogeneous data (A) that's hard to share (B), requiring standards after the fact (D). They can store data fine (C is false), and the problem is too little structure, not too much (E is false).
```

---

### Question 2.11 [SA]
What distinguishes DataJoint from traditional relational databases?

A) DataJoint uses a completely different type of database  
B) DataJoint treats computational dependencies as first-class schema elements  
C) DataJoint doesn't use SQL at all  
D) DataJoint is only for spreadsheets

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** DataJoint extends relational theory by making computational dependencies explicit in the schema, not just data relationships.
```

---

## Chapter 2: Relational Model

### Question 3.1 [SA]
In relational theory, what is a relation?

A) A foreign key constraint  
B) A subset of a Cartesian product of sets (a set of tuples)  
C) A database query  
D) A connection between two databases

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Mathematically, a relation is a subset of a Cartesian product—a set of tuples where each tuple is an ordered combination of values from the participating domains.
```

---

### Question 3.2 [SA]
What is the cardinality of a relation?

A) The number of domains (attributes) in the relation  
B) The number of tuples (rows) in the relation  
C) The size in megabytes  
D) The number of foreign keys

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Cardinality refers to the number of tuples (rows) in the relation. The number of domains is called the "order" or "degree."
```

---

### Question 3.3 [MA]
Which mathematicians laid the foundations for relational theory? (Select all that apply)

A) Augustus De Morgan  
B) Albert Einstein  
C) Georg Cantor  
D) Edgar F. Codd  
E) Isaac Newton

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D

**Explanation:** De Morgan developed early relational concepts, Cantor formalized set theory, and Codd applied these to database theory. Einstein and Newton worked in physics, not database foundations.
```

---

### Question 3.4 [SA]
What was Edgar F. Codd's major contribution?

A) Inventing the computer  
B) Translating mathematical relational theory into a practical data management system  
C) Creating the first spreadsheet  
D) Developing the Internet

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Codd formalized the relational data model by applying set theory and predicate logic to data management, creating a rigorous mathematical foundation for databases.
```

---

### Question 3.5 [SA]
What is algebraic closure in relational algebra?

A) Databases must be closed on weekends  
B) Operations on relations produce relations, enabling composition  
C) Tables must have fixed sizes  
D) Queries must complete quickly

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Algebraic closure means operators take relations as inputs and produce relations as outputs, allowing operations to be composed into complex expressions.
```

---

### Question 3.6 [MA]
Which are examples of relational algebra operators? (Select all that apply)

A) Selection (σ)  
B) Projection (π)  
C) Compilation  
D) Join (⋈)  
E) Debugging

```{admonition} Show Answer
:class: dropdown

**Answer:** A, B, D

**Explanation:** Selection, projection, and join are fundamental relational algebra operators. Compilation and debugging are programming concepts, not relational operations.
```

---

### Question 3.7 [SA]
Who introduced the Entity-Relationship Model (ERM)?

A) Edgar F. Codd  
B) Peter Chen  
C) Bill Gates  
D) Tim Berners-Lee

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Peter Chen introduced the Entity-Relationship Model in 1976 as a conceptual approach to database design.
```

---

### Question 3.8 [SA]
What problem does the Entity-Relationship Model solve?

A) Making databases faster  
B) Providing an intuitive, visual way to design databases before implementation  
C) Replacing relational databases  
D) Eliminating the need for SQL

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The ERM provides a conceptual modeling layer with visual diagrams (ERDs) that help designers think about entities and relationships before implementing in SQL.
```

---

### Question 3.9 [MA]
What are the "three levels of abstraction" in relational database thinking? (Select all that apply)

A) Mathematical foundation (Codd)  
B) Physical hardware  
C) Conceptual modeling (Chen - ERM)  
D) Implementation language (SQL)  
E) User interface design

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D

**Explanation:** The three levels are: mathematical theory (Codd's relational algebra), conceptual design (Chen's ERM), and implementation (SQL). Hardware and UI are not part of this framework.
```

---

### Question 3.10 [SA]
Why does the book argue that structured approaches emerged from "mathematical rigor, not rigidity"?

A) To justify bureaucracy  
B) To show that schemas provide provable properties and formal guarantees  
C) To make databases more complex  
D) To eliminate all flexibility

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The mathematical foundations enable provable query optimization, formal integrity guarantees, and principled evolution—practical benefits, not arbitrary restrictions.
```

---

### Question 3.11 [MA]
What practical benefits do mathematical foundations provide for scientific research? (Select all that apply)

A) Query optimizers can prove query equivalence  
B) Constraints provide guaranteed integrity  
C) Eliminates need for any planning  
D) Declarative queries map to scientific questions  
E) Schemas can be evolved with mathematical backing

```{admonition} Show Answer
:class: dropdown

**Answer:** A, B, D, E

**Explanation:** Mathematical foundations enable proven optimization (A), guaranteed integrity (B), declarative expression (D), and principled evolution (E). They don't eliminate planning needs (C).
```

---

### Question 3.12 [SA]
What is referential integrity?

A) Making sure column names are spelled correctly  
B) Ensuring relationships between tables remain valid (foreign keys exist)  
C) Backing up the database regularly  
D) Running queries quickly

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Referential integrity, enforced by foreign keys, ensures that references between tables remain valid—you can't have orphaned records.
```

---

### Question 3.13 [MA]
According to the book, what capabilities are missing from traditional relational databases for computational workflows? (Select all that apply)

A) "This result was computed FROM this input" semantics  
B) Storing large amounts of data  
C) Automatic recomputation when inputs change  
D) Running queries  
E) Tracking which code version produced results

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, E

**Explanation:** Traditional databases can store data (B) and run queries (D) fine, but lack computational dependency semantics (A), automatic recomputation (C), and built-in provenance tracking (E).
```

---

## Chapter 3: Relational Databases in Practice

### Question 4.1 [SA]
In the research lab database example, what does a foreign key in the Experiment table referencing Researcher accomplish?

A) It stores the researcher's email  
B) It ensures every experiment is linked to an existing researcher  
C) It makes queries run faster  
D) It deletes old experiments

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The foreign key constraint ensures referential integrity—you can't create an experiment referencing a non-existent researcher.
```

---

### Question 4.2 [SA]
What does the `ON DELETE CASCADE` clause do?

A) Speeds up delete operations  
B) Prevents any deletions  
C) Automatically removes dependent records when parent is deleted  
D) Sends an email notification

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** CASCADE means when you delete a parent record, all child records that depend on it are automatically deleted too.
```

---

### Question 4.3 [SA]
In the quality control scenario where Recording #1 had incorrect amplifier gain, what problem did the traditional database approach reveal?

A) The database was too slow  
B) There's no automatic tracking that NeuralUnit depends computationally on Recording  
C) The database couldn't store the correction  
D) SQL syntax was too complex

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The database knows NeuralUnit references Recording (foreign key), but doesn't know the spike rates were *computed from* the recording and need recomputation when it changes.
```

---

### Question 4.4 [MA]
What operations did the book demonstrate in the SQL section? (Select all that apply)

A) SELECT with WHERE clauses  
B) JOIN to combine related tables  
C) INSERT to add new records  
D) TIME TRAVEL to past states  
E) UPDATE to modify existing data

```{admonition} Show Answer
:class: dropdown

**Answer:** A, B, C, E

**Explanation:** The chapter covered SELECT (A), JOIN (B), INSERT (C), and UPDATE (E). Time travel is not a standard SQL operation (D).
```

---

### Question 4.5 [SA]
Why is UPDATE problematic for derived data in scientific workflows?

A) UPDATE is too slow  
B) UPDATE requires special permissions  
C) UPDATE can modify computed results without recomputing, breaking provenance  
D) UPDATE only works on small tables

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** You can UPDATE a computed result without actually recomputing it, silently breaking the connection between the result and its source data.
```

---

### Question 4.6 [MA]
What's missing from traditional relational databases for scientific workflows? (Select all that apply)

A) Temporal semantics (when/how data was created)  
B) The ability to store data  
C) Computational dependencies (this was derived from that)  
D) Automatic execution when inputs are ready  
E) Sending emails

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D

**Explanation:** Traditional databases lack temporal awareness (A), computational dependency tracking (C), and automatic execution (D). They can store data fine (B), and email is not a database feature (E).
```

---

### Question 4.7 [SA]
In an Entity-Relationship Diagram using Crow's Foot notation, what does `||--o{` mean?

A) One-to-one relationship  
B) Many-to-many relationship  
C) One-to-many relationship (one on left, many on right)  
D) The database is broken

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** In Crow's Foot notation, `||` means "exactly one" and `o{` means "zero or many," indicating a one-to-many relationship.
```

---

### Question 4.8 [SA]
What is the proper order for inserting data when foreign keys exist?

A) Any order is fine  
B) Parent entities must be inserted before child entities  
C) Child entities must be inserted before parent entities  
D) All data must be inserted simultaneously

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Foreign key constraints require that referenced records exist, so parents must be inserted before children.
```

---

## Chapter 4: Relational Workflows

### Question 5.1 [SA]
What is the core innovation of the Relational Workflow Model?

A) Replacing SQL with a new language  
B) Making databases faster  
C) Treating the database schema as an executable workflow specification  
D) Eliminating all constraints

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** The schema itself specifies the workflow—what depends on what, what's computed how, creating an executable specification, not just a data structure.
```

---

### Question 5.2 [MA]
What are the four fundamental concepts of the Relational Workflow Model? (Select all that apply)

A) Workflow Entity  
B) Shopping Cart  
C) Workflow Dependencies  
D) Workflow Steps  
E) Directed Acyclic Graph (DAG)

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D, E

**Explanation:** The four concepts are: Workflow Entity (A), Workflow Dependencies (C), Workflow Steps (D), and DAG structure (E). Shopping Cart is not a database concept (B).
```

---

### Question 5.3 [SA]
What distinguishes a "workflow entity" from a traditional entity?

A) Workflow entities are larger  
B) Workflow entities are created at a specific step in a workflow  
C) Workflow entities cannot have foreign keys  
D) Workflow entities are only text

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Workflow entities are artifacts of workflow execution—they exist because a specific workflow step created them.
```

---

### Question 5.4 [SA]
What is a Directed Acyclic Graph (DAG)?

A) A graph with cycles  
B) A graph with no direction  
C) A graph with directed edges and no cycles  
D) A type of chart for presentations

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** A DAG has directed edges (arrows showing dependencies) but no cycles (no circular dependencies), ensuring workflows can execute without infinite loops.
```

---

### Question 5.5 [MA]
What are the four table tiers in DataJoint? (Select all that apply)

A) Lookup tables  
B) Shopping tables  
C) Manual tables  
D) Imported tables  
E) Computed tables

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D, E

**Explanation:** DataJoint's four tiers are: Lookup (reference data), Manual (human-entered), Imported (from instruments), and Computed (derived). "Shopping tables" is not a tier.
```

---

### Question 5.6 [SA]
In DataJoint's visual representation, what color represents computed tables?

A) Green  
B) Blue  
C) Red  
D) Gray

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** Red indicates computed tables (automated processing), green is manual, blue is imported, gray is lookup.
```

---

### Question 5.7 [SA]
How does DataJoint handle relationships differently from traditional ERM?

A) DataJoint doesn't allow relationships  
B) Relationships emerge from workflow convergence, not explicit junction tables  
C) DataJoint requires manual relationship definition  
D) Relationships must be defined twice

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** In DataJoint, relationships emerge naturally when workflows converge—you don't need explicit "relationship" concepts or junction tables.
```

---

### Question 5.8 [SA]
What is "computational validity" in DataJoint?

A) Code must compile without errors  
B) Results must remain consistent with their current inputs  
C) Queries must return quickly  
D) All tables must be the same size

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Computational validity means if Result R was computed from Input I, then R must correspond to the current state of I (or both must be deleted/recomputed together).
```

---

### Question 5.9 [SA]
What happens in DataJoint when you delete an upstream entity?

A) Nothing—the database allows it  
B) Only that entity is deleted  
C) The operation cascades to delete all dependent downstream entities  
D) The database crashes

```{admonition} Show Answer
:class: dropdown

**Answer:** C

**Explanation:** DataJoint enforces computational validity by cascading deletes to remove all dependent entities, preventing orphaned results.
```

---

### Question 5.10 [SA]
What is the proper way to correct an error in upstream data in DataJoint?

A) Just UPDATE the wrong value  
B) Delete the incorrect data (cascading to dependents), reinsert corrected data, recompute  
C) Keep the error and document it  
D) Create a duplicate entry

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** To maintain computational validity, delete the error (which cascades), insert the correction, then recompute—ensuring all results reflect corrected inputs.
```

---

### Question 5.11 [SA]
What does the `populate()` operation do in DataJoint?

A) Fills tables with random data  
B) Automatically identifies missing work and computes results in correct order  
C) Deletes old data  
D) Backs up the database

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** `populate()` finds what needs computing based on the schema dependencies and executes computations in the correct order automatically.
```

---

### Question 5.12 [MA]
What are the five core query operators in DataJoint? (Select all that apply)

A) Restriction (&)  
B) Compilation  
C) Join (*)  
D) Projection (.proj())  
E) Aggregation (.aggr())  
F) Union  
G) Deletion

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D, E, F

**Explanation:** The five operators are: Restriction (A), Join (C), Projection (D), Aggregation (E), and Union (F). Compilation and deletion are not query operators.
```

---

### Question 5.13 [SA]
Why does DataJoint emphasize immutability by default?

A) To make the database read-only  
B) To preserve workflow execution history and provenance  
C) To save disk space  
D) To make queries faster

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Immutability preserves provenance—you can always trace results back to inputs. Changes happen via delete-and-reinsert, maintaining computational validity.
```

---

### Question 5.14 [SA]
What does "schema as executable specification" mean?

A) The schema includes JavaScript code  
B) The schema defines both structure AND how computations flow  
C) The schema can be run as a program  
D) The schema is written in Python

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** The schema specifies not just data structure, but the entire workflow: what depends on what, what's computed how, creating an executable specification.
```

---

### Question 5.15 [MA]
How does the Relational Workflow Model address ERM's limitations? (Select all that apply)

A) Adds temporal dimension (when entities are created)  
B) Eliminates all foreign keys  
C) Treats relationships as workflow convergence  
D) Provides unified design-implementation (no translation gap)  
E) Makes databases slower but more accurate

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D

**Explanation:** The Workflow Model adds temporal awareness (A), handles relationships through convergence (C), and unifies design/implementation (D). It keeps foreign keys (B is false) and doesn't sacrifice performance (E is false).
```

---

### Question 5.16 [SA]
What does the book mean by "from transactions to transformations"?

A) Databases should process credit cards  
B) A shift from storage-centric to transformation-centric thinking  
C) SQL should be replaced  
D) Databases should transform into spreadsheets

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** This represents the conceptual shift from thinking of databases as storage systems to thinking of them as workflow engines that transform data through computational steps.
```

---

## Comprehensive Questions

### Question 6.1 [MA]
Which statements accurately describe the progression from metadata to schemas to workflows? (Select all that apply)

A) Metadata describes relationships externally  
B) Schemas enforce relationships through the database  
C) Workflows add computational dependencies to schemas  
D) Each level replaces the previous one  
E) All three approaches can work together

```{admonition} Show Answer
:class: dropdown

**Answer:** A, B, C, E

**Explanation:** Metadata describes (A), schemas enforce (B), workflows add computational semantics (C), and they complement each other (E). They don't replace each other (D is false)—they serve different purposes.
```

---

### Question 6.2 [SA]
A scientist discovers that a raw measurement file was corrupted. In a DataJoint workflow, what's the proper response?

A) UPDATE all dependent results to mark them as questionable  
B) Delete the corrupt measurement (cascading to all results), fix the file, reinsert, and repopulate  
C) Keep the corrupt data and add a note  
D) Only fix the measurement and hope results are still valid

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** DataJoint's approach: delete the corrupt data (cascading to maintain computational validity), insert corrected data, then recompute everything—ensuring all results reflect valid inputs.
```

---

### Question 6.3 [MA]
What advantages does DataJoint provide over traditional relational databases for scientific computing? (Select all that apply)

A) Faster raw query performance  
B) Explicit computational dependencies in schema  
C) Automatic recomputation when inputs change  
D) Built-in provenance tracking  
E) No need for any documentation

```{admonition} Show Answer
:class: dropdown

**Answer:** B, C, D

**Explanation:** DataJoint adds computational dependencies (B), automatic recomputation (C), and provenance tracking (D) to relational foundations. Raw performance is similar (A), and documentation is still valuable (E is false).
```

---

### Question 6.4 [SA]
If you see this in a DataJoint diagram: `Session → Recording → Analysis`, what does it mean?

A) These are three unrelated tables  
B) Recording depends on Session; Analysis depends on Recording  
C) You must query them in alphabetical order  
D) They have the same structure

```{admonition} Show Answer
:class: dropdown

**Answer:** B

**Explanation:** Arrows represent dependencies: Recording is created from Session data, Analysis is computed from Recording data—a workflow pipeline.
```

---

### Question 6.5 [MA]
Why is the mathematical foundation of relational databases important for science? (Select all that apply)

A) It enables provable query optimization  
B) It makes databases more expensive  
C) It provides formal integrity guarantees  
D) It supports declarative queries matching scientific questions  
E) It eliminates all human judgment

```{admonition} Show Answer
:class: dropdown

**Answer:** A, C, D

**Explanation:** Mathematical foundations enable proven optimization (A), formal guarantees (C), and declarative expression (D). They don't increase cost (B) or eliminate judgment (E).
```

---

## Scoring Guide

```{list-table} Grade Scale
:header-rows: 1
:widths: 20 20 60

* - Score Range
  - Percentage
  - Assessment
* - 63-70 points
  - 90-100%
  - Excellent mastery of database concepts
* - 56-62 points
  - 80-89%
  - Good understanding with minor gaps
* - 49-55 points
  - 70-79%
  - Adequate comprehension, review some topics
* - 42-48 points
  - 60-69%
  - Basic familiarity, significant review needed
* - Below 42
  - <60%
  - Comprehensive review recommended
```

**Total Points:** 70
- Single Answer: 40 questions × 1 point = 40 points
- Multiple Answer: 15 questions × 2 points = 30 points

**Topic Coverage:**
- Chapter 0 (Databases): 6% (4 questions)
- Chapter 1 (Data Models): 28% (11 questions)
- Chapter 2 (Relational Model): 24% (13 questions)
- Chapter 3 (Practical Implementation): 15% (8 questions)
- Chapter 4 (Workflow Model): 24% (16 questions)
- Synthesis Questions: 3% (3 questions)


---

### Question 1.3 [Single Answer]
What role does a Database Management System (DBMS) play?

A) It's the physical hardware that stores data
B) It's a backup system for databases
C) It's the software engine that defines structure, enforces rules, and executes queries
D) It's a user interface for data entry

**Answer:** C

**Explanation:** A DBMS is the computational engine that defines and enforces data structure, manages storage, and executes queries while maintaining integrity.

---

### Question 1.4 [Single Answer]
In the airline booking example, why is a DBMS essential?

A) To make the website look attractive
B) To enforce rules like "a seat cannot be double-booked" reliably
C) To store passenger names alphabetically
D) To print boarding passes

**Answer:** B

**Explanation:** The DBMS actively enforces business rules (like preventing double-booking) automatically, which is critical for operational integrity.

---

## Chapter 1: Data Models

### Question 2.1 [Single Answer]
What is a data model?

A) A physical database server
B) A conceptual framework defining how data is organized, represented, and transformed
C) A specific database implementation
D) A programming language for databases

**Answer:** B

**Explanation:** A data model is the conceptual framework—the principles and constructs—for organizing and working with data, not the implementation itself.

---

### Question 2.2 [Single Answer]
What is a schema?

A) A sample of actual data
B) A database query
C) A formal specification of data structure that exists separately from the data
D) A programming language

**Answer:** C

**Explanation:** A schema is the formal specification of structure (tables, columns, types, relationships) defined separately from any actual data instances.

---

### Question 2.3 [MA]
Which statements correctly describe the difference between structured and schemaless data models? (Select all that apply)

A) Structured models define schema before storing data
B) Schemaless models have no structure at all
C) Schemaless models embed structure within each data instance
D) Structured models validate data against predefined rules
E) Schemaless models are always better for scientific research

**Answer:** A, C, D

**Explanation:** Structured models use predefined schemas (A) that validate data (D). Schemaless models do have structure, but it's self-describing within the data (C), not enforced externally. Neither approach is universally "better"—they serve different purposes (E is false).

---

### Question 2.4 [Single Answer]
What is the key difference between metadata and schemas?

A) Metadata is newer technology than schemas
B) Metadata describes relationships externally; schemas enforce them actively
C) Schemas are only used for small datasets
D) They are the same thing with different names

**Answer:** B

**Explanation:** Metadata provides descriptive information but relies on external interpretation. Schemas actively enforce structure and relationships through the database system itself.

---

### Question 2.5 [Single Answer]
Using the passenger/luggage analogy from the book, what does a schema represent?

A) Destination tags on luggage
B) The passenger's travel preferences
C) The assigned seat that's guaranteed and can't be double-booked
D) The passenger's name tag

**Answer:** C

**Explanation:** The schema (assigned seat) provides active enforcement—preventing double-booking and ensuring the passenger and luggage travel together. Tags (metadata) just provide information.

---

### Question 2.6 [MA]
Which data models were discussed as essential examples in the book? (Select all that apply)

A) Binary files
B) Spreadsheets
C) Relational databases
D) JSON/Document databases
E) Quantum databases

**Answer:** A, B, C, D

**Explanation:** The book covers binary files (baseline), spreadsheets (familiar), relational (focus), and JSON (modern alternative). Quantum databases were not discussed.

---

### Question 2.7 [Single Answer]
What is a major limitation of spreadsheets for complex scientific workflows?

A) They can't display numbers
B) They have no referential integrity or workflow enforcement
C) They're too expensive
D) They only work on Windows

**Answer:** B

**Explanation:** Spreadsheets lack referential integrity—formulas can break when rows are deleted, and there's no enforcement of computational dependencies.

---

### Question 2.8 [MA]
According to the book, when should you use structured, schema-enforced approaches? (Select all that apply)

A) When data integrity is non-negotiable
B) When relationships must remain valid as data evolves
C) When exploring completely unknown data structures
D) When provenance and reproducibility are essential
E) When rapid prototyping with no quality concerns

**Answer:** A, B, D

**Explanation:** Structured approaches are essential when integrity (A), valid relationships (B), and provenance (D) matter. For pure exploration (C) or when quality doesn't matter (E), flexible approaches may suffice.

---

### Question 2.9 [Single Answer]
What analogy did the book use to compare AI working with unstructured vs. structured data?

A) A teacher grading random vs. organized essays
B) A detective with disorganized vs. organized evidence
C) A chef with mixed vs. separated ingredients
D) A musician with random vs. sheet music

**Answer:** B

**Explanation:** The book compared unstructured data to a detective sifting through a disorganized crime scene, versus structured data like organized evidence logs and reports.

---

### Question 2.10 [MA]
What challenges do scientists face with flexible, unstructured data approaches? (Select all that apply)

A) Heterogeneous datasets lacking consistency
B) Difficulty sharing and publishing data
C) Inability to store any data
D) Need for "data standards" imposed afterward
E) Too much structure limiting creativity

**Answer:** A, B, D

**Explanation:** Flexible approaches lead to heterogeneous data (A) that's hard to share (B), requiring standards after the fact (D). They can store data fine (C is false), and the problem is too little structure, not too much (E is false).

---

### Question 2.11 [Single Answer]
What distinguishes DataJoint from traditional relational databases?

A) DataJoint uses a completely different type of database
B) DataJoint treats computational dependencies as first-class schema elements
C) DataJoint doesn't use SQL at all
D) DataJoint is only for spreadsheets

**Answer:** B

**Explanation:** DataJoint extends relational theory by making computational dependencies explicit in the schema, not just data relationships.

---

## Chapter 2: Relational Model

### Question 3.1 [Single Answer]
In relational theory, what is a relation?

A) A foreign key constraint
B) A subset of a Cartesian product of sets (a set of tuples)
C) A database query
D) A connection between two databases

**Answer:** B

**Explanation:** Mathematically, a relation is a subset of a Cartesian product—a set of tuples where each tuple is an ordered combination of values from the participating domains.

---

### Question 3.2 [Single Answer]
What is the cardinality of a relation?

A) The number of domains (attributes) in the relation
B) The number of tuples (rows) in the relation
C) The size in megabytes
D) The number of foreign keys

**Answer:** B

**Explanation:** Cardinality refers to the number of tuples (rows) in the relation. The number of domains is called the "order" or "degree."

---

### Question 3.3 [MA]
Which mathematicians laid the foundations for relational theory? (Select all that apply)

A) Augustus De Morgan
B) Albert Einstein
C) Georg Cantor
D) Edgar F. Codd
E) Isaac Newton

**Answer:** A, C, D

**Explanation:** De Morgan developed early relational concepts, Cantor formalized set theory, and Codd applied these to database theory. Einstein and Newton worked in physics, not database foundations.

---

### Question 3.4 [Single Answer]
What was Edgar F. Codd's major contribution?

A) Inventing the computer
B) Translating mathematical relational theory into a practical data management system
C) Creating the first spreadsheet
D) Developing the Internet

**Answer:** B

**Explanation:** Codd formalized the relational data model by applying set theory and predicate logic to data management, creating a rigorous mathematical foundation for databases.

---

### Question 3.5 [Single Answer]
What is algebraic closure in relational algebra?

A) Databases must be closed on weekends
B) Operations on relations produce relations, enabling composition
C) Tables must have fixed sizes
D) Queries must complete quickly

**Answer:** B

**Explanation:** Algebraic closure means operators take relations as inputs and produce relations as outputs, allowing operations to be composed into complex expressions.

---

### Question 3.6 [MA]
Which are examples of relational algebra operators? (Select all that apply)

A) Selection (σ)
B) Projection (π)
C) Compilation
D) Join (⋈)
E) Debugging

**Answer:** A, B, D

**Explanation:** Selection, projection, and join are fundamental relational algebra operators. Compilation and debugging are programming concepts, not relational operations.

---

### Question 3.7 [Single Answer]
Who introduced the Entity-Relationship Model (ERM)?

A) Edgar F. Codd
B) Peter Chen
C) Bill Gates
D) Tim Berners-Lee

**Answer:** B

**Explanation:** Peter Chen introduced the Entity-Relationship Model in 1976 as a conceptual approach to database design.

---

### Question 3.8 [Single Answer]
What problem does the Entity-Relationship Model solve?

A) Making databases faster
B) Providing an intuitive, visual way to design databases before implementation
C) Replacing relational databases
D) Eliminating the need for SQL

**Answer:** B

**Explanation:** The ERM provides a conceptual modeling layer with visual diagrams (ERDs) that help designers think about entities and relationships before implementing in SQL.

---

### Question 3.9 [MA]
What are the "three levels of abstraction" in relational database thinking? (Select all that apply)

A) Mathematical foundation (Codd)
B) Physical hardware
C) Conceptual modeling (Chen - ERM)
D) Implementation language (SQL)
E) User interface design

**Answer:** A, C, D

**Explanation:** The three levels are: mathematical theory (Codd's relational algebra), conceptual design (Chen's ERM), and implementation (SQL). Hardware and UI are not part of this framework.

---

### Question 3.10 [Single Answer]
Why does the book argue that structured approaches emerged from "mathematical rigor, not rigidity"?

A) To justify bureaucracy
B) To show that schemas provide provable properties and formal guarantees
C) To make databases more complex
D) To eliminate all flexibility

**Answer:** B

**Explanation:** The mathematical foundations enable provable query optimization, formal integrity guarantees, and principled evolution—practical benefits, not arbitrary restrictions.

---

### Question 3.11 [MA]
What practical benefits do mathematical foundations provide for scientific research? (Select all that apply)

A) Query optimizers can prove query equivalence
B) Constraints provide guaranteed integrity
C) Eliminates need for any planning
D) Declarative queries map to scientific questions
E) Schemas can be evolved with mathematical backing

**Answer:** A, B, D, E

**Explanation:** Mathematical foundations enable proven optimization (A), guaranteed integrity (B), declarative expression (D), and principled evolution (E). They don't eliminate planning needs (C).

---

### Question 3.12 [Single Answer]
What is referential integrity?

A) Making sure column names are spelled correctly
B) Ensuring relationships between tables remain valid (foreign keys exist)
C) Backing up the database regularly
D) Running queries quickly

**Answer:** B

**Explanation:** Referential integrity, enforced by foreign keys, ensures that references between tables remain valid—you can't have orphaned records.

---

### Question 3.13 [MA]
According to the book, what capabilities are missing from traditional relational databases for computational workflows? (Select all that apply)

A) "This result was computed FROM this input" semantics
B) Storing large amounts of data
C) Automatic recomputation when inputs change
D) Running queries
E) Tracking which code version produced results

**Answer:** A, C, E

**Explanation:** Traditional databases can store data (B) and run queries (D) fine, but lack computational dependency semantics (A), automatic recomputation (C), and built-in provenance tracking (E).

---

## Chapter 3: Relational Databases in Practice

### Question 4.1 [Single Answer]
In the research lab database example, what does a foreign key in the Experiment table referencing Researcher accomplish?

A) It stores the researcher's email
B) It ensures every experiment is linked to an existing researcher
C) It makes queries run faster
D) It deletes old experiments

**Answer:** B

**Explanation:** The foreign key constraint ensures referential integrity—you can't create an experiment referencing a non-existent researcher.

---

### Question 4.2 [Single Answer]
What does the `ON DELETE CASCADE` clause do?

A) Speeds up delete operations
B) Prevents any deletions
C) Automatically removes dependent records when parent is deleted
D) Sends an email notification

**Answer:** C

**Explanation:** CASCADE means when you delete a parent record, all child records that depend on it are automatically deleted too.

---

### Question 4.3 [Single Answer]
In the quality control scenario where Recording #1 had incorrect amplifier gain, what problem did the traditional database approach reveal?

A) The database was too slow
B) There's no automatic tracking that NeuralUnit depends computationally on Recording
C) The database couldn't store the correction
D) SQL syntax was too complex

**Answer:** B

**Explanation:** The database knows NeuralUnit references Recording (foreign key), but doesn't know the spike rates were *computed from* the recording and need recomputation when it changes.

---

### Question 4.4 [MA]
What operations did the book demonstrate in the SQL section? (Select all that apply)

A) SELECT with WHERE clauses
B) JOIN to combine related tables
C) INSERT to add new records
D) TIME TRAVEL to past states
E) UPDATE to modify existing data

**Answer:** A, B, C, E

**Explanation:** The chapter covered SELECT (A), JOIN (B), INSERT (C), and UPDATE (E). Time travel is not a standard SQL operation (D).

---

### Question 4.5 [Single Answer]
Why is UPDATE problematic for derived data in scientific workflows?

A) UPDATE is too slow
B) UPDATE requires special permissions
C) UPDATE can modify computed results without recomputing, breaking provenance
D) UPDATE only works on small tables

**Answer:** C

**Explanation:** You can UPDATE a computed result without actually recomputing it, silently breaking the connection between the result and its source data.

---

### Question 4.6 [MA]
What's missing from traditional relational databases for scientific workflows? (Select all that apply)

A) Temporal semantics (when/how data was created)
B) The ability to store data
C) Computational dependencies (this was derived from that)
D) Automatic execution when inputs are ready
E) Sending emails

**Answer:** A, C, D

**Explanation:** Traditional databases lack temporal awareness (A), computational dependency tracking (C), and automatic execution (D). They can store data fine (B), and email is not a database feature (E).

---

### Question 4.7 [Single Answer]
In an Entity-Relationship Diagram using Crow's Foot notation, what does `||--o{` mean?

A) One-to-one relationship
B) Many-to-many relationship
C) One-to-many relationship (one on left, many on right)
D) The database is broken

**Answer:** C

**Explanation:** In Crow's Foot notation, `||` means "exactly one" and `o{` means "zero or many," indicating a one-to-many relationship.

---

### Question 4.8 [Single Answer]
What is the proper order for inserting data when foreign keys exist?

A) Any order is fine
B) Parent entities must be inserted before child entities
C) Child entities must be inserted before parent entities
D) All data must be inserted simultaneously

**Answer:** B

**Explanation:** Foreign key constraints require that referenced records exist, so parents must be inserted before children.

---

## Chapter 4: Relational Workflows

### Question 5.1 [Single Answer]
What is the core innovation of the Relational Workflow Model?

A) Replacing SQL with a new language
B) Making databases faster
C) Treating the database schema as an executable workflow specification
D) Eliminating all constraints

**Answer:** C

**Explanation:** The schema itself specifies the workflow—what depends on what, what's computed how, creating an executable specification, not just a data structure.

---

### Question 5.2 [MA]
What are the four fundamental concepts of the Relational Workflow Model? (Select all that apply)

A) Workflow Entity
B) Shopping Cart
C) Workflow Dependencies
D) Workflow Steps
E) Directed Acyclic Graph (DAG)

**Answer:** A, C, D, E

**Explanation:** The four concepts are: Workflow Entity (A), Workflow Dependencies (C), Workflow Steps (D), and DAG structure (E). Shopping Cart is not a database concept (B).

---

### Question 5.3 [Single Answer]
What distinguishes a "workflow entity" from a traditional entity?

A) Workflow entities are larger
B) Workflow entities are created at a specific step in a workflow
C) Workflow entities cannot have foreign keys
D) Workflow entities are only text

**Answer:** B

**Explanation:** Workflow entities are artifacts of workflow execution—they exist because a specific workflow step created them.

---

### Question 5.4 [Single Answer]
What is a Directed Acyclic Graph (DAG)?

A) A graph with cycles
B) A graph with no direction
C) A graph with directed edges and no cycles
D) A type of chart for presentations

**Answer:** C

**Explanation:** A DAG has directed edges (arrows showing dependencies) but no cycles (no circular dependencies), ensuring workflows can execute without infinite loops.

---

### Question 5.5 [MA]
What are the four table tiers in DataJoint? (Select all that apply)

A) Lookup tables
B) Shopping tables
C) Manual tables
D) Imported tables
E) Computed tables

**Answer:** A, C, D, E

**Explanation:** DataJoint's four tiers are: Lookup (reference data), Manual (human-entered), Imported (from instruments), and Computed (derived). "Shopping tables" is not a tier.

---

### Question 5.6 [Single Answer]
In DataJoint's visual representation, what color represents computed tables?

A) Green
B) Blue
C) Red
D) Gray

**Answer:** C

**Explanation:** Red indicates computed tables (automated processing), green is manual, blue is imported, gray is lookup.

---

### Question 5.7 [Single Answer]
How does DataJoint handle relationships differently from traditional ERM?

A) DataJoint doesn't allow relationships
B) Relationships emerge from workflow convergence, not explicit junction tables
C) DataJoint requires manual relationship definition
D) Relationships must be defined twice

**Answer:** B

**Explanation:** In DataJoint, relationships emerge naturally when workflows converge—you don't need explicit "relationship" concepts or junction tables.

---

### Question 5.8 [Single Answer]
What is "computational validity" in DataJoint?

A) Code must compile without errors
B) Results must remain consistent with their current inputs
C) Queries must return quickly
D) All tables must be the same size

**Answer:** B

**Explanation:** Computational validity means if Result R was computed from Input I, then R must correspond to the current state of I (or both must be deleted/recomputed together).

---

### Question 5.9 [Single Answer]
What happens in DataJoint when you delete an upstream entity?

A) Nothing—the database allows it
B) Only that entity is deleted
C) The operation cascades to delete all dependent downstream entities
D) The database crashes

**Answer:** C

**Explanation:** DataJoint enforces computational validity by cascading deletes to remove all dependent entities, preventing orphaned results.

---

### Question 5.10 [Single Answer]
What is the proper way to correct an error in upstream data in DataJoint?

A) Just UPDATE the wrong value
B) Delete the incorrect data (cascading to dependents), reinsert corrected data, recompute
C) Keep the error and document it
D) Create a duplicate entry

**Answer:** B

**Explanation:** To maintain computational validity, delete the error (which cascades), insert the correction, then recompute—ensuring all results reflect corrected inputs.

---

### Question 5.11 [Single Answer]
What does the `populate()` operation do in DataJoint?

A) Fills tables with random data
B) Automatically identifies missing work and computes results in correct order
C) Deletes old data
D) Backs up the database

**Answer:** B

**Explanation:** `populate()` finds what needs computing based on the schema dependencies and executes computations in the correct order automatically.

---

### Question 5.12 [MA]
What are the five core query operators in DataJoint? (Select all that apply)

A) Restriction (&)
B) Compilation
C) Join (*)
D) Projection (.proj())
E) Aggregation (.aggr())
F) Union
G) Deletion

**Answer:** A, C, D, E, F

**Explanation:** The five operators are: Restriction (A), Join (C), Projection (D), Aggregation (E), and Union (F). Compilation and deletion are not query operators.

---

### Question 5.13 [Single Answer]
Why does DataJoint emphasize immutability by default?

A) To make the database read-only
B) To preserve workflow execution history and provenance
C) To save disk space
D) To make queries faster

**Answer:** B

**Explanation:** Immutability preserves provenance—you can always trace results back to inputs. Changes happen via delete-and-reinsert, maintaining computational validity.

---

### Question 5.14 [Single Answer]
What does "schema as executable specification" mean?

A) The schema includes JavaScript code
B) The schema defines both structure AND how computations flow
C) The schema can be run as a program
D) The schema is written in Python

**Answer:** B

**Explanation:** The schema specifies not just data structure, but the entire workflow: what depends on what, what's computed how, creating an executable specification.

---

### Question 5.15 [MA]
How does the Relational Workflow Model address ERM's limitations? (Select all that apply)

A) Adds temporal dimension (when entities are created)
B) Eliminates all foreign keys
C) Treats relationships as workflow convergence
D) Provides unified design-implementation (no translation gap)
E) Makes databases slower but more accurate

**Answer:** A, C, D

**Explanation:** The Workflow Model adds temporal awareness (A), handles relationships through convergence (C), and unifies design/implementation (D). It keeps foreign keys (B is false) and doesn't sacrifice performance (E is false).

---

### Question 5.16 [Single Answer]
What does the book mean by "from transactions to transformations"?

A) Databases should process credit cards
B) A shift from storage-centric to transformation-centric thinking
C) SQL should be replaced
D) Databases should transform into spreadsheets

**Answer:** B

**Explanation:** This represents the conceptual shift from thinking of databases as storage systems to thinking of them as workflow engines that transform data through computational steps.

---

## Comprehensive Questions

### Question 6.1 [MA]
Which statements accurately describe the progression from metadata to schemas to workflows? (Select all that apply)

A) Metadata describes relationships externally
B) Schemas enforce relationships through the database
C) Workflows add computational dependencies to schemas
D) Each level replaces the previous one
E) All three approaches can work together

**Answer:** A, B, C, E

**Explanation:** Metadata describes (A), schemas enforce (B), workflows add computational semantics (C), and they complement each other (E). They don't replace each other (D is false)—they serve different purposes.

---

### Question 6.2 [Single Answer]
A scientist discovers that a raw measurement file was corrupted. In a DataJoint workflow, what's the proper response?

A) UPDATE all dependent results to mark them as questionable
B) Delete the corrupt measurement (cascading to all results), fix the file, reinsert, and repopulate
C) Keep the corrupt data and add a note
D) Only fix the measurement and hope results are still valid

**Answer:** B

**Explanation:** DataJoint's approach: delete the corrupt data (cascading to maintain computational validity), insert corrected data, then recompute everything—ensuring all results reflect valid inputs.

---

### Question 6.3 [MA]
What advantages does DataJoint provide over traditional relational databases for scientific computing? (Select all that apply)

A) Faster raw query performance
B) Explicit computational dependencies in schema
C) Automatic recomputation when inputs change
D) Built-in provenance tracking
E) No need for any documentation

**Answer:** B, C, D

**Explanation:** DataJoint adds computational dependencies (B), automatic recomputation (C), and provenance tracking (D) to relational foundations. Raw performance is similar (A), and documentation is still valuable (E is false).

---

### Question 6.4 [Single Answer]
If you see this in a DataJoint diagram: `Session → Recording → Analysis`, what does it mean?

A) These are three unrelated tables
B) Recording depends on Session; Analysis depends on Recording
C) You must query them in alphabetical order
D) They have the same structure

**Answer:** B

**Explanation:** Arrows represent dependencies: Recording is created from Session data, Analysis is computed from Recording data—a workflow pipeline.

---

### Question 6.5 [MA]
Why is the mathematical foundation of relational databases important for science? (Select all that apply)

A) It enables provable query optimization
B) It makes databases more expensive
C) It provides formal integrity guarantees
D) It supports declarative queries matching scientific questions
E) It eliminates all human judgment

**Answer:** A, C, D

**Explanation:** Mathematical foundations enable proven optimization (A), formal guarantees (C), and declarative expression (D). They don't increase cost (B) or eliminate judgment (E).

---

## Answer Key Summary

**Chapter 0 (Databases):** 1.1-B, 1.2-ACD, 1.3-C, 1.4-B

**Chapter 1 (Data Models):** 2.1-B, 2.2-C, 2.3-ACD, 2.4-B, 2.5-C, 2.6-ABCD, 2.7-B, 2.8-ABD, 2.9-B, 2.10-ABD, 2.11-B

**Chapter 2 (Relational):** 3.1-B, 3.2-B, 3.3-ACD, 3.4-B, 3.5-B, 3.6-ABD, 3.7-B, 3.8-B, 3.9-ACD, 3.10-B, 3.11-ABDE, 3.12-B, 3.13-ACE

**Chapter 3 (Practice):** 4.1-B, 4.2-C, 4.3-B, 4.4-ABCE, 4.5-C, 4.6-ACD, 4.7-C, 4.8-B

**Chapter 4 (Workflows):** 5.1-C, 5.2-ACDE, 5.3-B, 5.4-C, 5.5-ACDE, 5.6-C, 5.7-B, 5.8-B, 5.9-C, 5.10-B, 5.11-B, 5.12-ACDEF, 5.13-B, 5.14-B, 5.15-ACD, 5.16-B

**Comprehensive:** 6.1-ABCE, 6.2-B, 6.3-BCD, 6.4-B, 6.5-ACD

---

## Scoring Guide

**Total Questions:** 55
- Single Answer: 40 questions (1 point each)
- Multiple Answer: 15 questions (2 points each if all correct)
- **Maximum Score:** 70 points

**Grade Scale:**
- 90-100% (63-70): Excellent mastery
- 80-89% (56-62): Good understanding
- 70-79% (49-55): Adequate comprehension
- 60-69% (42-48): Basic familiarity
- Below 60% (<42): Review recommended

**Topic Coverage:**
- Databases fundamentals: 6%
- Data models: 28%
- Relational theory: 24%
- Practical implementation: 15%
- Workflow model: 24%
- Synthesis: 3%
