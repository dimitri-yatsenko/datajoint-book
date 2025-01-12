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

In the fall of 2009, I started thinking about how relational database principles could be adapted for scientific data analysis.
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

2020 was a pivotal year for us. With a significant 5-year NIH grant, we began developing [DataJoint Elements](https://datajoint.com/docs/elements)—a set of reference implementations for DataJoint pipelines in neurophysiology studies. This period also brought key leadership changes, including the addition of Dr. Kabilar Gunalan, who played a vital role in advancing the DataJoint Elements initiative.

In 2021, we rebranded the company as **DataJoint** to better align with our core product, shifting our focus toward commercial technology for research collaboration. During this time, I transitioned to a full-time role as CEO.

# The DataJoint Platform

In 2022, we were awarded a Phase II SBIR commercialization grant from the NIH to develop an innovative online collaborative platform: DataJoint Works. This marked a significant milestone in our journey, enabling us to expand our capabilities beyond traditional consulting services. Monty Kosma, who joined the company that year, spearheaded the development of the platform, bringing his vision and leadership to the forefront. Monty's contributions were instrumental, and he later became a co-founder and President, guiding DataJoint's transformation from a consulting firm into a product-focused enterprise.

The **DataJoint Works** platform officially launched in 2024, empowering the first cohort of labs to seamlessly operate their experiments using its robust and intuitive features. This milestone demonstrated the potential of DataJoint Works to revolutionize how scientific data is managed and shared, setting a strong foundation for its adoption across the research community.

In the fall of 2024, the company entered a new phase of growth with the addition of Jim Olson, a seasoned executive with a proven track record. Jim had previously served as CEO of Flywheel.io, a leading data operations platform, where he established himself as a visionary leader in the field. Joining DataJoint as CEO in December 2024, Jim brought fresh perspectives and strategic insights, positioning the company to scale its impact and reach new heights in the years ahead.

Today, DataJoint exemplifies a harmonious blend of community-driven open-source development and a powerful online platform for hosting and managing DataJoint pipelines. This dual approach ensures that our tools remain accessible, reliable, and continuously evolving, while providing researchers with a secure, collaborative environment to advance their work.
