---
title: Prerequisites
date: 2024-08-12
authors:
  - name: Dimitri Yatsenko
---

Coding examples in this book require the following components:

- [ ] A MySQL server
- [ ] MySQL user name and password
- [ ] MySQL user privileges to create and drop schemas and tables, insert/update/delete data from tables.
- [ ] Python programming language
- [ ] Integrated Developer Environment (e.g. VSCode or PyCharm) and/or [Jupyter](https://jupyter.org)
- [ ] The DataJoint Python client library
- [ ] Object storage for large data objects (e.g. Minio or Ceph).
- [ ] IPython SQL magic 

# Using DevContainer
If you are using the DevContainer for this textbook, you are all set. All these required components are already configured.
This will not allow you to run a sizeable project but will be sufficient for the tutorial exercises.

# On DataJoint Works
For real projects, you can go to https://datajoint.com to request a comprehensive digital environment for implementing and operating collaborative data pipelines, either in the cloud or in local infrastructure. 

DataJoint Works provides an integrated research environment that combines:
* code management
* user access management
* database operations
* automated computations
* electronic lab notebooks
* data navigation and exploration 
* performance monitoring and optimization
* backups and recovery
* data export and publishing

The platform comes with technical support to address any issues with the setup and configuration.

# Do-It-Yourself 
If you must set up a DataJoint pipeline using your own engineering resources and infrastructure, you can definitely do it!
The tools are published in open source.
This requires substantial skills in systems administration and database administration to set up all operations.
You can begin by reverse engineering the DevContainer for this book and refer to the tutorials and documentation for each software component.
