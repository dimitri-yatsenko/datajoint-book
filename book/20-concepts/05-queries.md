---
title: Data Queries
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Data Queries
In the context of data management, it’s important to distinguish between data retrieval and data queries.

**Data repositories** are a broad category of systems designed primarily for storing and retrieving data. These repositories, such as Dropbox or Google Drive, offer basic functionalities like authentication and access control for sharing data, but they don't provide advanced tools for manipulating or analyzing the data.

```{card} Data retrieval
**Data retrieval** refers to the process of retrieving data from a **data repository** in its original form, exactly as it was deposited.
```

In contrast, databases are designed to serve a more diverse group of users, each with different roles and needs within an organization or enterprise. To accommodate these varying requirements, databases support data queries, which allow users to request specific portions of the stored data. These queries often present the data in a format that differs from how it was originally stored, tailored to the user’s specific needs.

```{card} Data Query
A **data query** is a function applied to stored data that extracts and presents a specific segment of the database's information for a particular analysis.
The output often differs from the original storage format, providing customized views of the data.
```

For example, consider a university setting:
* Students need to enroll in courses and view their academic records.
* Instructors require access to class lists and a platform to input grades.
* Deans may need to oversee the academic performance of all students within their departments.

Although these tasks rely on the same underlying data, each requires a different selection and combination of that data, tailored to the specific needs of the user.

In modern data-driven scientific research, data queries enable researchers to select and aggregate specific data fragments necessary for their analysis or visualization.
This targeted approach eliminates the need to retrieve entire datasets from their primary repository, making the process more efficient and focused.
