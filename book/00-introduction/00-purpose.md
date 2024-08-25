---
title: Purpose
date: 2024-08-22
authors:
  - name: Dimitri Yatsenko
---

# Purpose

## Introducing DataJoint 

Primarily, this book is a comprehensive introduction to DataJoint for Python—a specialized framework for implementing scientific data pipelines that manage data and orchestrate computations in collaborative studies.
At its core, DataJoint is an enhancement of the traditional relational database model.
As such, it enables scientists, data engineers, and programmers to design and query relational databases.
But its main innovation is its introduction of computational dependencies as a first-class citizen in the relational database, allowing researchers to define, execute, and reproduce data processing pipelines with precision and efficiency. 

DataJoint empowers scientists to describe not just the structure of their data, but also the sequence of computations that transform raw data into meaningful results. This language integrates data storage, processing, and analysis into a unified system, ensuring that each step in the research process is transparent, reproducible, and easy to manage.

By formalizing the relationships between data and computations, DataJoint eliminates the need for ad-hoc scripting and manual data wrangling, enabling researchers to focus on the scientific questions that matter most. Whether dealing with simple experiments or large-scale collaborative projects, DataJoint provides the tools necessary to handle data complexity, maintain data integrity, and foster collaboration across teams.

This book provides a clear and accessible introduction to the core concepts of relational database programming in the context of data science and research applications, such as neuroscience and machine learning, where complex computations are involved.  
THe book is written to allow scientists and engineers to build a solid understanding of relational database programming from scratch. We assume that the reader is proficient in Python but assume no prior database experence. 

## DataJoint and SQL: A Close Relationship

SQL, or Structured Query Language, is the standard language used to manage and manipulate relational databases. Developed in the 1970s by IBM researchers, SQL allows users to create, read, update, and delete data stored in tables, making it an essential tool for handling structured data.

DataJoint is built on the same relational theory as SQL but takes it a step further by using modern syntax directly from Python. DataJoint statements are automatically transpiled into SQL, meaning that while you write in Python, the underlying database operations are carried out using SQL. This approach combines the power of relational databases with the convenience of Python, making it accessible to scientists, data engineers, and programmers.

Just like SQL, DataJoint provides all the functionality needed to design databases, populate them with data, and query the results. However, with DataJoint, you can define not just the data structure, but also the sequence of computations that process and analyze your data, integrating storage and computation in a single framework.

One of the unique advantages of using DataJoint is that practitioners can become proficient in relational database concepts without ever writing SQL directly. By working within DataJoint, users naturally develop a deep understanding of relational databases and how to manage complex data workflows.

To make this book a comprehensive introduction to databases, we will also teach the equivalent SQL concepts and syntax alongside DataJoint. Throughout the chapters, you'll find executable examples and clear explanations of how SQL and DataJoint work together. As a result, not only will you learn how to use DataJoint effectively, but you'll also gain a solid foundation in SQL programming.

# Scientific Operations 
Review what it takes to operate a scientific project: @10.48550/arXiv.2401.00077

# Focus on Neuroscience

While the tools and concepts in this book are applicable to any computationally intensive field, DataJoint has its roots and most widespread applications in systems neuroscience. The development of DataJoint was closely tied to the needs of neuroscience research, and much of the support for this work has come from neuroscience-focused funding sources.

As a result, some of the examples in this book will naturally have a neuroscience focus. However, these examples are chosen to illustrate broader principles and techniques that can be adapted to a wide range of scientific disciplines.

# Contributions

I welcome and appreciate your contributions to this book, whether as a reviewer or as a contributor.
All contributions will be gratefully acknowledged.
Please feel free to contact me directly or submit an issue in the book's GitHub repository.
