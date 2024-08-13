---
title: Development Environment
date: 2024-08-12
---

This book focuses on programming scientific databases with integrated computations, all implemented using the most popular scientific programming language today — [Python](https://www.python.org/).

Designed to be fully executable, this book adheres to the standards of the [Executable Books Project](https://executablebooks.org/). The entire development environment, including all dependencies, is containerized using Docker and DevContainer.

The main [GitHub repository](https://github.com/dimitri-yatsenko/datajoint-book) for this book includes a DevContainer setup that provides a complete development environment to run all examples and exercises. This environment is pre-configured with:

- A MySQL database server running within the container
- MyST for generating the book
- Python and Jupyter for programming examples
- The DataJoint client library
- Essential scientific programming libraries

There are two primary methods to build and activate the DevContainer:

1. Using [Visual Studio Code](https://code.visualstudio.com/docs/devcontainers/tutorial)
2. Using [GitHub CodeSpaces](https://docs.github.com/en/codespaces/getting-started/quickstart)

Detailed instructions for working with DevContainers are available in the documentation for MyST, Visual Studio Code, and GitHub CodeSpaces. Readers are encouraged to explore these resources to learn how to set up and operate the environment.

All the tools used in this book are free, open-source, and adhere to good software governance principles, making them a robust foundation for any scientific data engineering project.

While the setup provided in this book is streamlined for educational purposes, it's important to note that real-world database setup, operations, and maintenance can be complex. Any large-scale, collaborative project will require significant investment in infrastructure and operational support.

