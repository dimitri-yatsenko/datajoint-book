---
title: Purpose
---

## What is DataJoint?

**DataJoint is a computational database language and platform that enables scientists to design, implement, and manage data operations for research by unifying data structures and analysis code.** It provides data integrity, automated computation, reproducibility, and seamless collaboration through a relational database approach that coordinates relational databases, code repositories, and object storage.

## Who This Book Is For

Scientists and engineers working with data-intensive research—neuroscience, machine learning, bioinformatics, or any field where data complexity demands rigor. We assume you know Python but have never touched databases. By the end of this book, you'll be fluent in both DataJoint and SQL, building robust data workflows using relational databases, Python code, Git, and object storage.

## Why This Book Exists

Most research starts with scripts, spreadsheets, and folder structures—an approach that works until it doesn't. For small projects with a single researcher, these ad-hoc methods suffice. But as data grows and teams expand, the cracks appear: lost data, irreproducible results, and pipelines that break whenever priorities shift.

This reality hit hard during **MICrONS (Machine Intelligence from Cortical Networks)** [@10.1038/s41586-025-08790-w], a nine-year effort to map brain circuitry that generated petabytes of data from electron microscopy, neurophysiology, and behavior. Traditional methods collapsed under this complexity. The project demanded something better: a framework that could maintain data integrity, track computational provenance, and enable a large team to collaborate effectively.

That framework was **DataJoint**—the tool that brings the rigor of relational databases to the dynamic, evolving world of scientific research. This book teaches you to build the same kind of robust, scalable data workflows, whether you're processing terabytes or gigabytes, working solo or in a team. 

```{admonition} Key Innovation
DataJoint treats computational dependencies as a first-class feature of the database. You define not just data structures, but entire processing pipelines—from raw inputs through intermediate steps to final results. Every computation is trackable, reproducible, and automatically managed. [@10.48550/arXiv.1807.11104]
```

## Databases as Workflows

Here's what makes DataJoint different: **your database schema IS your data processing pipeline**.

Traditional databases store and retrieve data. DataJoint does that too, but it also tracks what gets computed from what. Each table plays a specific role in your workflow:

- **Manual tables**: Source data entered by researchers
- **Imported tables**: Data acquired from instruments or external sources
- **Computed tables**: Results automatically derived from upstream data
- **Lookup tables**: Reference data and parameters

This workflow perspective shapes everything:

**Schema as a Map**: Your database diagram becomes a visual flowchart showing exactly how data moves from raw inputs to final results. Dependencies are explicit, not hidden in scattered scripts.

**Intelligent Diagrams**: Different table types get distinct visual styles. One glance tells you what's manual, what's automatic, and how everything connects.

**Provenance, Not Just Integrity**: Foreign keys mean more than "this ID exists." They mean "this result was computed FROM this input." When upstream data changes, DataJoint ensures you can't accidentally keep stale downstream results. This is why DataJoint emphasizes INSERT and DELETE over UPDATE—changing input data without recomputing outputs breaks your science, even if the database technically remains consistent.

For scientific computing, this workflow-centric design is transformative. Your database doesn't just store results—it guarantees they're valid, reproducible, and traceable back to their origins.

## The Goal: Rigorous Scientific Operations

This book teaches **Scientific Operations (SciOps)**—the practice of building reliable, efficient, and scalable data workflows. Think of it as DevOps for research: applying software engineering principles to scientific data pipelines.

Most research starts at "Level 1" maturity: ad-hoc scripts and manual processes. This book guides you through progressively more sophisticated approaches, from basic database design through automated pipelines and ultimately to AI-enabled workflows that accelerate discovery.

This progression isn't theoretical. We've worked with neuroinformatics leaders to define a practical roadmap for research operations [@10.48550/arXiv.2401.00077]. The ultimate goal: closed-loop studies where human insight and computational power work seamlessly together.

## Clarity as a Design Principle

Good code is written for humans first, machines second. This is doubly true for databases, where your schema becomes the shared mental model for your entire team.

DataJoint emphasizes clarity: your database structure should directly reflect your scientific logic. When designed well, a DataJoint schema becomes self-documenting—new team members can understand your workflow by simply looking at the diagram.

This book provides the skills to transform research operations: from fragile scripts to robust, queryable, collaborative systems. Not because you need enterprise-scale infrastructure, but because clear thinking and good design make science better.


## DataJoint and SQL: Two Languages, One Foundation

**SQL (Structured Query Language)** powers virtually every relational database. DataJoint wraps SQL in Pythonic syntax, automatically translating your code into optimized queries.

You could learn DataJoint without ever seeing SQL. But this book teaches both, side by side. You'll understand not just *what* works but *why*—and you'll be able to work directly with SQL when needed.

## AI and Domain Context

AI is transforming how we write code. This book explores how AI assistance impacts database design, computation, and queries—treating AI as a practical tool rather than a distant future.

Many examples come from neuroscience, reflecting DataJoint's origins. But the principles apply everywhere data is complex and pipelines are essential. Think of neuroscience examples as concrete illustrations of general patterns you'll adapt to your own field.

## Contributing

This book is a living document. Contributions, corrections, and suggestions are welcome—submit an issue on GitHub or contact me directly. All contributors will be acknowledged.

*— Dimitri Yatsenko, Principal Author*
