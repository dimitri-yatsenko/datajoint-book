---
title: Pipeline Projects
authors:
  - name: Dimitri Yatsenko
---

# Organizing a Data Pipeline Project

A DataJoint **data pipeline** is more than just a database—it is a structured system for managing scientific data, its dependencies, associated computations, and execution workflows. Before diving into schema and table design, it's important to understand how to organize the entire project.

This chapter describes the conventions for organizing a complete data pipeline project.

## Pipeline ≡ Git Repository

A DataJoint pipeline **SHALL** be implemented as a dedicated **Git repository** containing a Python package. This repository serves as the single source of truth for the entire pipeline definition, including:

- **Schema definitions** — Table structures and relationships
- **Computation logic** — The `make` methods for automated tables
- **Configuration** — Database connection and object storage settings
- **Dependencies** — Required packages and environment specifications
- **Documentation** — Usage guides and API references
- **Containerization** — Docker configurations for reproducible environments

The repository structure enables:

- **Version control** — Track all changes to the pipeline definition
- **Collaboration** — Multiple developers can work on the pipeline simultaneously
- **Reproducibility** — Any state of the pipeline can be reconstructed from its commit history
- **Deployment** — The pipeline can be installed as a Python package

## Pipeline ≡ Python Package

Within the Git repository, the pipeline is organized as a **Python package** located in `src/workflow/`. This follows the modern Python packaging convention of using a `src` layout, which prevents accidental imports from the local directory during development.

### Standard Project Structure

```
my_pipeline/
├── LICENSE                  # Project license (e.g., MIT, Apache 2.0)
├── README.md                # Project documentation
├── pyproject.toml           # Project metadata and configuration
├── .gitignore               # Git ignore patterns
│
├── src/
│   └── workflow/            # Python package directory
│       ├── __init__.py      # Package initialization
│       ├── subject.py       # subject schema module
│       ├── acquisition.py   # acquisition schema module
│       ├── processing.py    # processing schema module
│       └── analysis.py      # analysis schema module
│
├── notebooks/               # Jupyter notebooks for exploration and tutorials
│   ├── 01-data-entry.ipynb
│   ├── 02-queries.ipynb
│   └── 03-analysis.ipynb
│
├── docs/                    # Documentation sources
│   ├── index.md
│   ├── installation.md
│   └── api/
│
├── docker/                  # Docker configurations
│   ├── Dockerfile
│   ├── docker-compose.yaml
│   └── .env.example
│
└── tests/                   # Test suite
    ├── __init__.py
    └── test_pipeline.py
```

### Directory Purposes

| Directory | Purpose |
|-----------|---------|
| `src/workflow/` | Pipeline code — schema modules with table definitions |
| `notebooks/` | Interactive exploration, tutorials, and analysis notebooks |
| `docs/` | Sphinx or MkDocs documentation sources |
| `docker/` | Containerization for reproducible environments |
| `tests/` | Unit and integration tests |

## Database Schema ≡ Python Module

Each database schema in a DataJoint pipeline corresponds to a distinct Python module within `src/workflow/`. This one-to-one mapping is a fundamental convention:

| Database Construct | Python Construct |
|---|---|
| Database schema | Python module (`.py` file) |
| Database table | Python class |
| Schema name | Module name (conventionally similar) |

![Schema Design](../95-reference/figures/schema-illustration.png)
*Each database schema corresponds to a Python module containing related table definitions.*

Each module defines a `schema` property and uses it to declare tables. For details on creating schemas and tables, see [Create Schemas](010-schema.ipynb).

## Pipeline as a DAG of Modules

A DataJoint pipeline adheres to a **Directed Acyclic Graph (DAG)** structure at two levels:

![Pipeline Design](../95-reference/figures/pipeline-illustration.png)
*A pipeline forms a DAG where nodes are schema modules and edges represent dependencies (both Python imports and foreign key bundles).*

### 1. Table-Level DAG

Within each schema, tables form a DAG through their foreign key relationships. See [Foreign Keys](030-foreign-keys.ipynb) for details.

### 2. Module-Level DAG

The schemas themselves form a higher-level DAG, where:

- **Nodes** represent Python modules (database schemas)
- **Edges** represent dependencies between modules

These dependencies include:
- **Python import dependencies** — One module imports another
- **Foreign key bundles** — Tables in one schema reference tables in another schema

```python
# src/workflow/acquisition.py

import datajoint as dj
from . import subject  # Import dependency on upstream module

schema = dj.Schema('acquisition')

@schema
class Scan(dj.Manual):
    definition = """
    -> subject.Subject        # Foreign key to upstream schema
    scan_id : int
    ---
    scan_date : date
    """
```

### Visualizing the Pipeline

The `dj.Diagram` class can render the pipeline at multiple levels of detail:

- **Full detail** — All tables with their foreign key relationships
- **Schema level** — Schemas as grouped nodes with edges bundling the foreign keys between them

This high-level view makes it easy to understand the overall data flow in complex pipelines with many tables.

## Acyclicity Constraint

**Cyclic dependencies are strictly prohibited** at both levels:

1. **Within a schema** — Foreign keys between tables must form a DAG
2. **Between schemas** — Module imports and foreign keys must form a DAG

This constraint ensures:
- Unidirectional data flow throughout the pipeline
- Predictable dependency resolution
- Clean module imports without circular references

## Project Configuration with pyproject.toml

Each pipeline project uses a `pyproject.toml` file for configuration. This file defines:

1. **Project metadata** — Name, version, authors
2. **Dependencies** — Required packages including datajoint
3. **Object storage configuration** — Where large data objects are stored

### Example pyproject.toml

```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "my-pipeline"
version = "0.1.0"
description = "A DataJoint pipeline for neurophysiology experiments"
readme = "README.md"
license = {file = "LICENSE"}
authors = [
    {name = "Your Name", email = "your.email@example.com"}
]
requires-python = ">=3.9"
dependencies = [
    "datajoint>=0.14",
    "numpy",
    "scipy",
]

[project.optional-dependencies]
dev = [
    "pytest",
    "pytest-cov",
    "jupyter",
]
docs = [
    "sphinx",
    "myst-parser",
]

[tool.setuptools.packages.find]
where = ["src"]

[tool.datajoint]
# Object storage configuration
[tool.datajoint.stores.main]
protocol = "s3"
endpoint = "s3.amazonaws.com"
bucket = "my-pipeline-data"
location = "raw"

[tool.datajoint.stores.processed]
protocol = "s3"
endpoint = "s3.amazonaws.com"
bucket = "my-pipeline-data"
location = "processed"
```

### Object Storage Configuration

The `[tool.datajoint.stores]` section configures external storage for large data objects. Each store defines:

| Setting | Description |
|---------|-------------|
| `protocol` | Storage protocol (`s3`, `file`, etc.) |
| `endpoint` | Storage server endpoint |
| `bucket` | Bucket or root directory name |
| `location` | Subdirectory within the bucket |

Tables can reference specific stores for their `object` attributes:

```python
@schema
class Recording(dj.Imported):
    definition = """
    -> acquisition.Scan
    ---
    raw_data : object@main           # Stored in 'main' store
    """
```

## Docker Configuration

The `docker/` directory contains configurations for containerized deployment:

### docker/Dockerfile

```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python package
COPY pyproject.toml README.md LICENSE ./
COPY src/ ./src/
RUN pip install -e .

# Default command runs the worker
CMD ["python", "-m", "workflow.worker"]
```

### docker/docker-compose.yaml

```yaml
services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
    volumes:
      - mysql_data:/var/lib/mysql
    ports:
      - "3306:3306"

  minio:
    image: minio/minio
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: ${MINIO_ROOT_USER}
      MINIO_ROOT_PASSWORD: ${MINIO_ROOT_PASSWORD}
    volumes:
      - minio_data:/data
    ports:
      - "9000:9000"
      - "9001:9001"

  worker:
    build:
      context: ..
      dockerfile: docker/Dockerfile
    environment:
      DJ_HOST: db
      DJ_USER: root
      DJ_PASS: ${MYSQL_ROOT_PASSWORD}
    depends_on:
      - db
      - minio

volumes:
  mysql_data:
  minio_data:
```

## Best Practices

### 1. One Schema Per Module

Maintain strict correspondence between Python modules and database schemas. Never define multiple schemas in one module.

### 2. Clear Naming Conventions

- Schema names: lowercase with underscores (e.g., `subject_management`)
- Module names: lowercase, matching schema names where practical
- Table classes: CamelCase (e.g., `SubjectSession`)

### 3. Explicit Imports

Import upstream modules explicitly at the top of each module:

```python
from . import subject
from . import acquisition
```

### 4. Version Control Configuration

Store connection-independent configuration in `pyproject.toml`, but keep credentials and environment-specific settings in environment variables or local configuration files excluded from version control.

### 5. Use the src Layout

Place pipeline code in `src/workflow/` to:
- Prevent accidental imports from the project root
- Ensure tests run against the installed package
- Follow modern Python packaging conventions

## Summary

A well-organized DataJoint pipeline project:

1. Lives in a **Git repository** as the single source of truth
2. Contains a **LICENSE** file specifying usage terms
3. Places pipeline code in **`src/workflow/`** following Python packaging conventions
4. Maps each **database schema to a Python module** with a `schema` property
5. Forms a **DAG at both table and module levels**, with no cyclic dependencies
6. Configures **object storage in pyproject.toml** for large data management
7. Includes **notebooks/** for interactive exploration and tutorials
8. Provides **docs/** for comprehensive documentation
9. Contains **docker/** configurations for reproducible deployment

With the project structure in place, you're ready to define schemas and tables within `src/workflow/`.

:::{seealso}
- [Create Schemas](010-schema.ipynb) — Declaring schemas and the `schema` object
- [Create Tables](015-table.ipynb) — Defining tables within schemas
- [DataJoint Specs](../95-reference/SPECS_2_0.md) — Complete specification reference
:::
