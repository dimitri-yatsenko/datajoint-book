---
title: Data Model
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Definition
```{card} Data Model
A *data model* is a particular way of thinking about data. 
A particular model is defined by answering the following questions:
* What is the data made of? What are the basic constructs for creating and manipulating the data?
* What are the basic operations for defining, creating, and manipulating the data?
* What tools exist for defining and enforcing data integrity: the rules for valid data interactions and for preventing invalid operaitons?
```

:::note Thought
Before proceeding, think of the data models you are already familiar with.
What are the building blocks for data in this model?
What are the principal operations for creating, manipulating, and querying data in this model?
:::

# Example: Binary File
The simplest and least structured data model is that of a data file. 
A file is simply a string of bits (1s and 0s). 
For a tiny bit of structure, the bits are grouped into bytes (8 bits).
The operations that a file supports are: changing the values of the bits and the length of the file.

# Example: File System

### Example: Spreadsheets

Electronic spreadsheets are among the most widely used tools for data management and analysis across business, science, and everyday household tasks.

The first spreadsheet program, VisiCalc, launched in 1979, played a key role in the commercial success of the Apple II personal computer and helped establish Apple as a major player in the tech industry. Similarly, Lotus 1-2-3, developed for the IBM PC, became another "killer app" that drove the adoption of personal computers in the business world. Today, proficiency in spreadsheet software like Microsoft Excel or Google Sheets is essential for business professionals and data scientists alike.

But what exactly is the data model behind spreadsheets? What makes up a spreadsheet, and how do users interact with it?

The data model of a spreadsheet is straightforward and user-friendly, enabling intuitive interactions:

1. **Grid of Cells**: Spreadsheets organize data in a rectangular grid, where each cell is identified by its position (e.g., A1, B2). This simple structure allows users to easily locate and manipulate data.

2. **Values or Formulas**: Each cell in a spreadsheet can hold a value (such as text, numbers, or dates), a formula that references other cells, or remain empty. Formulas automatically update when referenced cells change, which can trigger further updates across the spreadsheet.

Users interact with spreadsheets by manually entering data or formulas into specific cells. When the content of a cell changes, any related formulas recalculate automatically, often leading to cascading updates throughout the sheet.

In addition to basic data entry, spreadsheets offer a wide range of features, including formatting options and the ability to create charts, making them versatile tools for data analysis and presentation.

# Example: Dataframes

DataFrames are a fundamental data structure used in data analysis and manipulation, particularly in the fields of data science, statistics, and machine learning. They provide a powerful and flexible way to work with structured data, similar to tables in relational databases or spreadsheets, but with additional capabilities that make them ideal for complex data operations.

A DataFrame is essentially a two-dimensional, labeled data structure with columns of potentially different types. It can be thought of as a table where each column can contain different types of data (e.g., integers, floats, strings). DataFrames are most commonly associated with libraries like `Pandas` in Python and `DataFrames.jl` in Julia.

The concept of DataFrames originated from the statistical programming language R, where DataFrames have been a core data structure for many years.
The idea was later adopted and popularized in the Python ecosystem with the Pandas library, introduced by Wes McKinney in 2008.
Pandas DataFrames have since become a staple in data science, allowing users to perform complex data manipulations with ease.

DataFrames are used extensively in data analysis tasks, including:

- **Data Cleaning**: Handling missing data, filtering, and transforming data into a usable format.
- **Exploratory Data Analysis (EDA)**: Summarizing and visualizing data to uncover patterns, trends, and relationships.
- **Data Transformation**: Applying mathematical and statistical operations, merging, and reshaping data.
- **Machine Learning**: Preparing and processing datasets for training machine learning models.

The data model of a DataFrame is both simple and flexible:

1. **Rows and Columns**: A DataFrame is composed of rows and columns, similar to a spreadsheet or a database table. Each row represents a single observation, and each column represents a variable or feature of the data.

2. **Labeled Axes**: Unlike basic two-dimensional arrays, DataFrames have labeled axes. This means that each row and column can have a label (e.g., row indices and column names), making it easier to access and manipulate data based on labels rather than just numerical indices.

3. **Heterogeneous Data Types**: Each column in a DataFrame can contain data of different types. For example, one column might store integers, another strings, and yet another floating-point numbers. This flexibility allows DataFrames to handle complex datasets with varied data types.

4. **Indexing**: DataFrames support both integer-based and label-based indexing, allowing users to access data using row/column indices or labels. This makes data access intuitive and efficient.

DataFrames support a wide range of operations, making them a powerful tool for data manipulation:

- **Selection and Filtering**: Users can select specific rows and columns, filter data based on conditions, and access subsets of the data.

- **Aggregation and Grouping**: DataFrames allow for grouping data by one or more columns and applying aggregate functions (e.g., sum, mean, count) to summarize data.

- **Data Transformation**: Users can apply functions to columns or rows, perform mathematical operations, and reshape the DataFrame (e.g., pivoting, melting).

- **Merging and Joining**: DataFrames support merging and joining operations, similar to SQL joins, allowing users to combine multiple DataFrames based on common keys.

- **Handling Missing Data**: DataFrames provide functions for detecting, filling, or dropping missing data, which is essential in preparing datasets for analysis.

- **I/O Operations**: DataFrames can easily read from and write to various file formats, including CSV, Excel, JSON, and SQL databases.

DataFrames have become an essential tool in modern data analysis, providing a structured yet flexible way to handle and manipulate data. Their ability to work with heterogeneous data types, combined with a rich set of operations, makes them ideal for tasks ranging from simple data exploration to complex data transformations and machine learning preparation. Whether in Python, R, or Julia, DataFrames have become a cornerstone of data science workflows.


# Example: Object Model

# Schema
Data models can be divided into structured and self-describing.

# Exercise
As an exercise, describe other models you are familiar with in terms of its basic constructs, operations, and data integrity rules.
For example, what data models  are used by the following:

* HDF5 or .MAT files
* Graph databases (
* Vector database
* Document database e.g. MongoDB
