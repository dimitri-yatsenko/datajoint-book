---
title: DataJoint History
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---


```{image} ../images/cave-art.jpg
---
:alt: cave painting
:width: 600px
---
```

# Early Work at BCM
In the summer of 2008, I joined Dr. Andreas Tolias's new lab at Baylor College of Medicine's Department of Neuroscience.
The lab was focused on complex neurophysiology experiments.
A group of students and postdocs, including Alex Ecker, Philipp Berens, Andreas Hoenselaar, and R. James Cotton, had already started a MATLAB-based library called "Steinbruch," which used MySQL to link data through computational dependencies.

In the fall of 2009, I started thinking about how relational database could be adapted to scientific research.
I wanted to create a database system that could naturally reflect the complexities of a scientific study and be easy for a research team to use.
This led me to develop the first version of DataJoint for MATLAB, which I used in my neurophysiology experiments.

My goal was to design a database system based on strong principles, with a focus on data integrity and reliable transaction processing, with native support for computational dependencies and orchestration.
I noticed that mainstream database models lacked computational dependencies, so I created DataJoint to fill that gap.

By 2011, DataJoint was fully integrated into our lab's workflow, thanks to the early adopters Manolis Froudarakis and Jacob Reimer.
Dr. Tolias recognized its potential and supported its use, which led me to release DataJoint as an open-source project on [Google Code](https://code.google.com/archive/p/datajoint/).

# Gaining Recognition
By 2014, the year I defended my Ph.D. thesis, DataJoint had already spread beyond the lab and was used in research institutions worldwide.

Although I had started working on a Python version of DataJoint in 2011, significant progress was made when two other lab members, Edgar Y. Walker and Fabian Sinz, worked with me from 2014 to 2015 to create a full Python package.

My work at BCM coincided with the Tolias lab's participation in the [IARPA MICrONS project](https://www.iarpa.gov/research-programs/microns), which aimed to devise new forms of machine intelligence by learning the structure and function of biological neural networks. DataJoint’s ability to manage a large, multidisciplinary team made it an essential tool, further boosting its adoption.

# Consulting Business
In 2016, four members of the Tolias lab—Dimitri Yatsenko, Jacob Reimer, Edgar Y. Walker, and Andreas Tolias—started a company, Vathes LLC, to provide consluting services around DataJoint, providing data engineering services to research labs.
This was in response to DARPA-funded effort to commercialize neuroscience data tools.
In 2017, Vathes received a Phase I SBIR grant to explore the commercial potential of DataJoint. Edgar and Dimitri split their time between managing the company operations and their ongoing academic work.

By 2018, Vathes had added key members: Shan Shen, Thinh Nguyen, Chris Turner, and Raphael Guzman, who played crucial roles in developing DataJoint further and integrating it into the workflows of large labs that became our customers. Our growth, collaborations, and new team members helped shape our approach to data-driven projects. Collaborations with Prof. Carlos Brody and Prof. Karel Svoboda also significantly increased DataJoint's use.

# The DataJoint Platform
2020 was a turning point. A large 5-year NIH grant allowed us to develop [DataJoint Elements](https://datajoint.com/docs/elements)—a set of reference implementations of DataJoint pipelines for neurophysiology studies. Following this, there were key leadership changes, with Dr. Kabilar Gunalan leading the DataJoint Elements initiative.

In 2021, we rebranded the company as **DataJoint** to align with our core product, focusing on commercial tech for research collaboration. I took on a full-time role as CEO.
In 2022, the NIH awarded us a Phase II SBIR commercialization grant to build an online collaborative platform—[**DataJoint Works**](https://works.datajoint.com).
The effort to build the platform was led by Monty Kosma, who joined the company in 2022.
He later joined as a new co-founder and Presidents, as the company transformed from consulting to a product-focused company.

The DataJoint Works platform launched in 2024 and the first cohort of labs began operating their experiments using the platform.

Today, the company combines community-driven open-source development of core tools with a powerful online platform for hosting and operating DataJoint pipelines.

