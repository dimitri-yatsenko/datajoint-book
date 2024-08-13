---
title: Preface
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

# Preface

## Purpose
This book aims to clearly explain the basics of relational database programming, especially focusing on scientific data that requires calculations.

### The Basics of Scientific Database Programming
This guide provides an introduction to database programming in scientific settings. You'll learn how databases can help organize and manage the complex data involved in collaborative scientific research.

Scientific databases are known for handling large numerical datasets and complex data structures. But it's not just about storing data. The data needs to work smoothly with the computational algorithms that process and interpret it. This requires effective code management and automation of computations across different computing systems.

### Relational Databases: SQL and DataJoint
There are many ways to manage data, but relational databases are highly regarded for their structured approach. They help maintain data accuracy and offer powerful tools for querying data. The main language used in relational databases is SQL, which covers data definition, querying, modification, and procedural tasks.

SQL, developed in the 70s and 80s, is still widely used, but it can be complex. That’s where DataJoint comes in—a modern take on the relational model, tailored for the scientific community. Like SQL, DataJoint also has tools for defining, manipulating, and querying data. The beauty of DataJoint is its simplicity, making it easier to learn database programming without getting too deep into SQL’s complexities.

This guide explains the principles and uses of relational databases, with a focus on DataJoint, and occasionally comparing it with SQL. It includes theoretical concepts, practical examples, exercises, and resources.

### Target Audience
This book is designed for anyone interested in learning the fundemantals  of relational database programming, focusing on solid theoretical foundations. 

### Contributions
We welcome your contributions to this book as reviewers and contributors.
Your contributions will be gratefully acknowledged.


## History 

```{image} ./images/cave-art.jpg
---
:alt: cave painting
:width: 600px
---
```

### The Beginning of DataJoint
In the fall of 2009, while I was a graduate student at Baylor College of Medicine (BCM), I started thinking about how database programming could be customized for scientific research. I wanted to create a database system that could naturally reflect the complexities of a scientific study and be easy for a research team to use. This led me to develop the first version of DataJoint for MATLAB, which I used in my neurophysiology experiments.

### Early Work at BCM
I was part of Dr. Andreas S. Tolias's new lab in BCM's Department of Neuroscience in 2008. The lab was focused on managing the complex data from neurophysiology experiments. A group of students and postdocs, including Alex Ecker, Philipp Berens, Andreas Hoenselaar, and R. James Cotton, had already started a MATLAB-based library called "Steinbruch," which used MySQL to link data through computational dependencies.

My goal was to design a database system based on strong principles, with a focus on data integrity and reliable transaction processing. I noticed that mainstream database models lacked computational dependencies, so I created DataJoint to fill that gap.

By 2011, DataJoint was fully integrated into our lab's workflow, thanks to early users like Manolis Froudarakis and Jacob Reimer. Dr. Tolias recognized its potential and supported its use, which led me to release DataJoint as an open-source project on [Google Code](https://code.google.com/archive/p/datajoint/).

### Gaining Recognition
By 2014, the year I completed my thesis, DataJoint had spread beyond our lab and was being used in research institutions worldwide. The first neuroscience papers using DataJoint were published by labs led by Laura Busse and Steffen Katzner at the University of Tübingen, Germany, in 2013.

Although I had started working on a Python version of DataJoint in 2011, significant progress was made when two other lab members, Edgar Y. Walker and Fabian Sinz, worked with me from 2014 to 2015 to create a full Python package.

My work at BCM coincided with the Tolias lab's participation in the [IARPA MICrONS project](https://www.iarpa.gov/research-programs/microns), which aimed to understand machine intelligence from cortical networks. DataJoint’s ability to manage a large, multidisciplinary team made it an essential tool, further boosting its adoption.

### Starting a Business
In 2016, four members of the Tolias lab—Dimitri Yatsenko, Jacob Reimer, Edgar Y. Walker, and Dr. Andreas S. Tolias—started a company called Vathes LLC. This was in response to DARPA's push to commercialize neuroscience data tools. In 2017, Vathes received a Phase I SBIR grant to explore the commercial potential of DataJoint. Edgar and I split our time between managing the company and our academic work.

By 2018, we had added key members: Shan Shen, Thinh Nguyen, Chris Turner, and Raphael Guzman, who played crucial roles in developing DataJoint further and integrating it into the workflows of large labs that became our customers. Our growth, collaborations, and new team members helped shape our approach to data-driven projects. Collaborations with Prof. Carlos Brody and Prof. Karel Svoboda also significantly increased DataJoint's use.

### A Major Shift
2020 was a turning point. A large 5-year NIH grant allowed us to develop [DataJoint Elements](https://datajoint.com/docs/elements)—a set of reference implementations of DataJoint pipelines for neurophysiology studies. Following this, there were key leadership changes, with Dr. Kabilar Gunalan leading the DataJoint Elements initiative.

In 2021, we rebranded the company as **DataJoint** to align with our core product, focusing on commercial tech for research collaboration. I took on a full-time role as CEO. 
In 2022, the NIH awarded us a Phase II SBIR commercialization grant to build an online collaborative platform—[**DataJoint Works**](https://works.datajoint.com).
The effort to build the platform was led by Monty Kosma, who joined the company in 2022. 
He later joined as a new co-founder and Presidents, as the company transformed from consulting to a product-focused company.


Today, the company combines community-driven open-source development of core tools with a powerful online platform for hosting and operating DataJoint pipelines.

