---
title: Development Environment
---
This book is designed to teach database programming for scientific operations, using the most popular scientific programming language today—[Python](https://www.python.org/).

### Executable Book Format

Following the standards of the [Executable Books Project](https://executablebooks.org/), this book is fully executable. The entire development environment, including all dependencies, is containerized using Docker and DevContainer, ensuring that all examples and exercises can be run seamlessly.

### Using DevContainer

The main [GitHub repository](https://github.com/dimitri-yatsenko/datajoint-book) for this book includes a DevContainer setup that provides a complete development environment. This environment is pre-configured with:

- A MySQL database server
- Minio server for storing large objects
- MyST for generating the book
- Python and Jupyter for programming examples
- MySQL client and IPython SQL Magic for executing SQL commands
- The DataJoint client library
- Essential scientific programming libraries

If you use DevContainer for this book, everything you need is already set up. This configuration is sufficient for the tutorial exercises but may not be robust enough for large-scale, real-world collaborative projects.

### Setting Up DevContainer

There are two main methods to build and activate the DevContainer:

1. **Using [Visual Studio Code](https://code.visualstudio.com/docs/devcontainers/tutorial)**
2. **Using [GitHub CodeSpaces](https://docs.github.com/en/codespaces/getting-started/quickstart)**

Detailed instructions for working with DevContainers can be found in the documentation for MyST, Visual Studio Code, and GitHub CodeSpaces. Readers are encouraged to explore these resources for guidance on setting up and operating the environment.

### The DataJoint Cloud Platform

For real-life projects, consider setting up an account on [the DataJoint cloud platform](https://datajoint.com). This platform provides the computational infrastructure and programming environment needed to implement collaborative data pipelines, either in the cloud or on local infrastructure. The DataJoint cloud platform integrates:

- Code management
- User access management
- Database operations
- Automated computations
- Electronic lab notebooks and visualization dashboards
- Data navigation and exploration
- Performance monitoring and optimization
- Backups and recovery
- Data export and publishing

The platform also offers technical support for setup and configuration issues.

### Do-It-Yourself Setup

If you prefer to set up a DataJoint pipeline using your own resources, the tools are open source and available for you to use. However, this requires substantial skills in systems administration and database management. You can start by reverse-engineering the DevContainer provided with this book and referring to the tutorials and documentation for each software component.

To run the coding examples in this book on your own setup, you'll need:

- A MySQL server with user accounts and appropriate privileges
- Object storage for large data objects (e.g., Minio or Ceph)
- Python programming language
- An Integrated Development Environment (IDE) like VSCode or PyCharm, or [Jupyter](https://jupyter.org)
- Python libraries for scientific computations and the DataJoint Python client
- IPython SQL magic

While the setup provided in this book is streamlined for educational purposes, real-world database operations can be complex and may require significant infrastructure and support.
