---
title: Pipeline Projects
authors:
  - name: Dimitri Yatsenko
---

# Organizing a Data Pipeline Project

A DataJoint **data pipeline** is more than just a database—it is a structured system for managing scientific data, its dependencies, associated computations, and execution workflows. The project structure ensures that data, computations, and their interdependencies are organized, traceable, and reproducible.

This chapter describes the conventions for organizing a complete data pipeline project.

## Pipeline ≡ Git Repository

A DataJoint pipeline **SHALL** be implemented as a dedicated **Git repository** containing a Python package. This repository serves as the single source of truth for the entire pipeline definition, including:

- **Schema definitions** — Table structures and relationships
- **Computation logic** — The `make` methods for automated tables
- **Configuration** — Database connection and object storage settings
- **Dependencies** — Required packages and environment specifications

The repository structure enables:

- **Version control** — Track all changes to the pipeline definition
- **Collaboration** — Multiple developers can work on the pipeline simultaneously
- **Reproducibility** — Any state of the pipeline can be reconstructed from its commit history
- **Deployment** — The pipeline can be installed as a Python package

## Pipeline ≡ Python Package

Within the Git repository, the pipeline is organized as a **Python package**. The package name typically matches the project name and contains modules corresponding to database schemas.

### Example Project Structure

```
my_pipeline/
├── pyproject.toml           # Project metadata and configuration
├── README.md                # Project documentation
├── .gitignore               # Git ignore patterns
│
├── my_pipeline/             # Python package directory
│   ├── __init__.py          # Package initialization
│   ├── subject.py           # subject schema module
│   ├── acquisition.py       # acquisition schema module
│   ├── processing.py        # processing schema module
│   └── analysis.py          # analysis schema module
│
└── tests/                   # Test suite
    └── test_pipeline.py
```

## Database Schema ≡ Python Module

Each database schema in a DataJoint pipeline **SHALL** correspond to a distinct Python module. This one-to-one mapping is a fundamental convention:

| Database Construct | Python Construct |
|---|---|
| Database schema | Python module (`.py` file) |
| Database table | Python class |
| Schema name | Module name (conventionally similar) |

### The `schema` Property

Each module **MUST** define a `schema` property that creates the schema namespace:

```python
# my_pipeline/subject.py

import datajoint as dj

schema = dj.Schema('subject')

@schema
class Subject(dj.Manual):
    definition = """
    subject_id : int
    ---
    subject_name : varchar(100)
    species : varchar(50)
    """

@schema
class SubjectNote(dj.Manual):
    definition = """
    -> Subject
    note_date : date
    ---
    note : varchar(1000)
    """
```

The `schema` property serves multiple purposes:

1. **Decorator** — Used as `@schema` to associate table classes with the database schema
2. **Diagram generation** — Enables visualization of all tables in the schema
3. **Schema operations** — Provides methods for schema-level operations (e.g., `schema.drop()`)

## Pipeline as a DAG of Modules

A DataJoint pipeline adheres to a **Directed Acyclic Graph (DAG)** structure at two levels:

### 1. Table-Level DAG

Within each schema, tables form a DAG through their foreign key relationships:

```python
# Tables within a schema form a DAG
@schema
class Session(dj.Manual):
    definition = """
    -> Subject
    session_id : int
    ---
    session_date : date
    """
```

### 2. Module-Level DAG

The schemas themselves form a higher-level DAG, where:

- **Nodes** represent Python modules (database schemas)
- **Edges** represent dependencies between modules

These dependencies include:
- **Python import dependencies** — One module imports another
- **Foreign key bundles** — Tables in one schema reference tables in another schema

```python
# my_pipeline/acquisition.py

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
    scan_notes : varchar(500)
    """
```

### Visualizing the Module-Level DAG

The pipeline can be visualized as a high-level diagram showing schemas as nodes and their dependencies as edges. Each edge represents a bundle of foreign key relationships between the tables of the connected schemas:

```
┌─────────────┐
│   subject   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ acquisition │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ processing  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  analysis   │
└─────────────┘
```

The `dj.Diagram` class can render this view, showing schemas as grouped nodes with edges bundling the foreign keys between them.

## Acyclicity Constraint

**Cyclic dependencies are strictly prohibited** at both levels:

1. **Within a schema** — Foreign keys between tables must form a DAG
2. **Between schemas** — Module imports and foreign keys must form a DAG

This constraint ensures:
- Unidirectional data flow throughout the pipeline
- Predictable dependency resolution
- Clean module imports without circular references

```python
# VALID: Downstream imports upstream
# processing.py imports acquisition.py
# acquisition.py imports subject.py

# INVALID: Circular imports
# subject.py imports analysis.py (which imports processing.py, which imports subject.py)
```

## Project Configuration with pyproject.toml

Each pipeline project uses a `pyproject.toml` file for configuration. This file defines:

1. **Project metadata** — Name, version, authors
2. **Dependencies** — Required packages including datajoint
3. **Object storage configuration** — Where large data objects are stored

### Example pyproject.toml

```toml
[project]
name = "my_pipeline"
version = "0.1.0"
description = "A DataJoint pipeline for neurophysiology experiments"
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
]

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

@schema
class ProcessedRecording(dj.Computed):
    definition = """
    -> Recording
    ---
    processed_data : object@processed  # Stored in 'processed' store
    """
```

## Module Dependency Example

Here is a complete example showing how modules depend on each other:

### subject.py (upstream, no dependencies)

```python
import datajoint as dj

schema = dj.Schema('subject')

@schema
class Subject(dj.Manual):
    definition = """
    subject_id : int
    ---
    subject_name : varchar(100)
    """
```

### acquisition.py (depends on subject)

```python
import datajoint as dj
from . import subject

schema = dj.Schema('acquisition')

@schema
class Session(dj.Manual):
    definition = """
    -> subject.Subject
    session_id : int
    ---
    session_date : date
    """

@schema
class Scan(dj.Imported):
    definition = """
    -> Session
    scan_idx : int
    ---
    scan_data : object@main
    """
```

### processing.py (depends on acquisition)

```python
import datajoint as dj
from . import acquisition

schema = dj.Schema('processing')

@schema
class ProcessedScan(dj.Computed):
    definition = """
    -> acquisition.Scan
    ---
    processed_data : object@processed
    quality_score : float
    """

    def make(self, key):
        # Fetch raw data from upstream table
        scan_data = (acquisition.Scan & key).fetch1('scan_data')

        # Process the data
        processed = self.process(scan_data)
        quality = self.compute_quality(processed)

        # Insert results
        self.insert1({**key,
                      'processed_data': processed,
                      'quality_score': quality})
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

### 4. Document Dependencies

Use docstrings to document the schema's role and its dependencies:

```python
"""
Processing schema for neural signal analysis.

Dependencies:
    - acquisition: Source of raw recording data

Provides:
    - ProcessedRecording: Filtered and normalized signals
    - SpikeDetection: Detected spike events
"""
```

### 5. Version Control Configuration

Store connection-independent configuration in `pyproject.toml`, but keep credentials and environment-specific settings in environment variables or local configuration files excluded from version control.

## Summary

A well-organized DataJoint pipeline project:

1. Lives in a **Git repository** as the single source of truth
2. Is structured as a **Python package** with installable dependencies
3. Maps each **database schema to a Python module** with a `schema` property
4. Forms a **DAG at both table and module levels**, with no cyclic dependencies
5. Configures **object storage in pyproject.toml** for large data management
6. Enables **pipeline visualization** showing schemas and their foreign key bundles

This structure ensures that pipelines are reproducible, maintainable, and can scale with growing data and team sizes.

:::{seealso}
- [Schema Definition](../30-design/010-schema.ipynb) — Creating and managing schemas
- [Orchestration](060-orchestration.ipynb) — Running pipelines at scale
- [DataJoint Specs](../95-reference/SPECS_2_0.md) — Complete specification reference
:::
