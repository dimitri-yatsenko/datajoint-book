# Normalization

Normalization is a fundamental principle in relational database design that ensures data integrity, eliminates redundancy, and creates maintainable schemas. Understanding normalization helps you design databases that are robust, efficient, and accurately represent your domain.

## The Purpose of Normalization

Normalization addresses several critical problems that arise in poorly designed databases:

### Problems Solved by Normalization

**1. Update Anomalies**
```
Bad Design: Storing employee department info in every project record
┌────────────┬──────────┬────────────┬─────────────┐
│ project_id │ emp_name │ dept_name  │ dept_phone  │
├────────────┼──────────┼────────────┼─────────────┤
│ P1         │ Alice    │ Engineering│ 555-0100    │
│ P2         │ Alice    │ Engineering│ 555-0100    │  ← Redundant!
│ P3         │ Alice    │ Engineering│ 555-0100    │  ← Redundant!
└────────────┴──────────┴────────────┴─────────────┘

Problem: If department phone changes, must update multiple rows
Risk: Updates might be missed, creating inconsistencies
```

**2. Insertion Anomalies**
```
Bad Design: Cannot add a department without having projects
Problem: Department information only exists in project records
Result: Cannot represent departments that have no active projects
```

**3. Deletion Anomalies**
```
Bad Design: Deleting last project removes department information
Problem: Department data is tied to project existence
Result: Lose department records when all projects complete
```

**4. Data Redundancy**
```
Bad Design: Same information repeated in multiple rows
Problem: Wastes storage space
Result: Increases database size unnecessarily
```

### Benefits of Normalization

When properly normalized, databases achieve:

* **Data Integrity**: Each fact is stored in exactly one place
* **Consistency**: Updates propagate correctly without anomalies
* **Maintainability**: Changes are localized to specific tables
* **Clarity**: Schema structure reflects real-world entities clearly
* **Query Correctness**: Relationships are explicitly defined and enforced

## Classical Normalization: Codd's Normal Forms

Edgar F. Codd, the inventor of the relational model, developed a formal theory of normalization based on **functional dependencies** between attributes. His work established a progression of "normal forms"—increasingly strict rules for database design.

### Historical Context

Codd introduced normalization in the early 1970s, **before** the Entity-Relationship (ER) model was developed by Peter Chen in 1976. At that time, database design was primarily concerned with:
- Mathematical properties of relations (tables)
- Functional dependencies between attribute domains
- Decomposition of relations to eliminate anomalies

The conceptual framework of "entities" and "relationships" came later, providing a more intuitive way to think about normalization.

### The Classical Normal Forms

Codd and his successors defined a series of normal forms, each addressing specific types of problems:

#### First Normal Form (1NF)

**Rule**: All attributes must contain atomic (indivisible) values—no repeating groups or arrays.

**Violation Example**:
```
┌────────────┬─────────────────────────┐
│ student_id │ courses                 │
├────────────┼─────────────────────────┤
│ 1          │ Math, Physics, Chemistry│  ← NOT atomic!
└────────────┴─────────────────────────┘
```

**Normalized (1NF)**:
```
┌────────────┬───────────┐
│ student_id │ course    │
├────────────┼───────────┤
│ 1          │ Math      │
│ 1          │ Physics   │
│ 1          │ Chemistry │
└────────────┴───────────┘
```

#### Second Normal Form (2NF)

**Rule**: Must be in 1NF, and all non-key attributes must depend on the **entire** primary key (not just part of it).

**Violation Example** (composite primary key: student_id, course_id):
```
┌────────────┬───────────┬──────────────┬──────────────┐
│ student_id │ course_id │ student_name │ course_title │
├────────────┼───────────┼──────────────┼──────────────┤
│ 1          │ CS101     │ Alice        │ Databases    │
│ 1          │ CS102     │ Alice        │ Algorithms   │  ← Alice repeated!
└────────────┴───────────┴──────────────┴──────────────┘

Problem: student_name depends only on student_id (part of PK)
Problem: course_title depends only on course_id (part of PK)
```

**Normalized (2NF)**:
```
Student table:          Course table:           Enrollment table:
┌────────────┬──────┐   ┌───────────┬──────┐   ┌────────────┬───────────┐
│ student_id │ name │   │ course_id │ title│   │ student_id │ course_id │
├────────────┼──────┤   ├───────────┼──────┤   ├────────────┼───────────┤
│ 1          │ Alice│   │ CS101     │ DB   │   │ 1          │ CS101     │
│ 2          │ Bob  │   │ CS102     │ Algo │   │ 1          │ CS102     │
└────────────┴──────┘   └───────────┴──────┘   └────────────┴───────────┘
```

#### Third Normal Form (3NF)

**Rule**: Must be in 2NF, and no non-key attribute depends on another non-key attribute (no transitive dependencies).

**Violation Example**:
```
┌────────────┬──────┬─────────┬────────────┐
│ student_id │ name │ dept_id │ dept_name  │
├────────────┼──────┼─────────┼────────────┤
│ 1          │ Alice│ CS      │ Comp Sci   │
│ 2          │ Bob  │ CS      │ Comp Sci   │  ← Dept name repeated!
└────────────┴──────┴─────────┴────────────┘

Problem: dept_name depends on dept_id, which depends on student_id
This is a transitive dependency: student_id → dept_id → dept_name
```

**Normalized (3NF)**:
```
Student table:                Department table:
┌────────────┬──────┬─────────┐   ┌─────────┬──────────┐
│ student_id │ name │ dept_id │   │ dept_id │ name     │
├────────────┼──────┼─────────┤   ├─────────┼──────────┤
│ 1          │ Alice│ CS      │   │ CS      │ Comp Sci │
│ 2          │ Bob  │ CS      │   │ MATH    │ Math     │
└────────────┴──────┴─────────┘   └─────────┴──────────┘
```

### Functional Dependencies

The classical normal forms are rooted in the concept of **functional dependencies**:

A functional dependency `A → B` means:
- "Attribute A functionally determines attribute B"
- If you know A, you can determine B uniquely
- Example: `student_id → student_name` (student ID determines name)

**Normalization process**:
1. Identify all functional dependencies
2. Decompose relations to eliminate:
   - Partial dependencies (violate 2NF)
   - Transitive dependencies (violate 3NF)
3. Each resulting relation contains attributes that depend on the primary key

**The famous mnemonic**: "Every non-key attribute must depend on the key, the whole key, and nothing but the key, so help me Codd!"

This mathematical approach, while rigorous, can be complex and difficult to apply intuitively.

## DataJoint's Entity-Centric Normalization

DataJoint takes a different, more intuitive approach to normalization that emerged after the development of the Entity-Relationship model. Rather than focusing on functional dependencies between attribute domains, DataJoint emphasizes **entities and their attributes**.

### The DataJoint Normalization Principle

> **Every relation (table) must represent a well-defined entity type, and all attributes in that table must describe that entity type directly and only that entity type.**

This principle guides schema design, ensuring that each table represents a coherent entity type.

### What This Means in Practice

#### Rule 1: One Entity Type Per Table

Each table should represent exactly one class or type of entity:

**Good (Normalized)**:
```python
@schema
class Professor(dj.Manual):
    definition = """
    professor_id : int
    ---
    name : varchar(100)
    hire_date : date
    """

@schema
class Office(dj.Manual):
    definition = """
    office_number : varchar(10)
    ---
    building : varchar(50)
    phone : varchar(20)
    """
```

**Bad (Not Normalized)**:
```python
@schema
class Professor(dj.Manual):
    definition = """
    professor_id : int
    ---
    name : varchar(100)
    hire_date : date
    office_number : varchar(10)   # Describes office, not professor!
    office_building : varchar(50)  # Describes office, not professor!
    office_phone : varchar(20)     # Describes office, not professor!
    """
```

**Why it's bad**: The office attributes describe the office, not the professor. A professor might change offices, but the office's building and phone don't change. These are properties of the office entity, not the professor entity.

#### Rule 2: All Attributes Must Describe ONLY That Entity

Every attribute in a table should be an intrinsic property of the entity represented by that table's primary key:

**Questions to ask**:
- Does this attribute describe the entity identified by this row's primary key?
- Would this attribute still apply if the entity's relationships changed?
- Is this attribute a permanent property of this entity?

**Example: Customer and Account**

```python
# Good: Attributes describe the customer
@schema
class Customer(dj.Manual):
    definition = """
    customer_id : int
    ---
    name : varchar(100)           # Property of customer
    date_of_birth : date          # Property of customer
    social_security : varchar(11) # Property of customer
    """

# Good: Attributes describe the account
@schema
class Account(dj.Manual):
    definition = """
    account_number : int
    ---
    -> Customer
    open_date : date              # Property of account
    balance : decimal(10,2)       # Property of account
    account_type : varchar(20)    # Property of account
    """
```

The foreign key `-> Customer` is not an attribute OF the account—it's a **relationship** between account and customer. The account belongs to a customer, but the customer's identity is not a property of the account itself.

#### Rule 3: Relationships in Separate Tables When Needed

When entities relate to each other, sometimes that relationship itself needs to be represented as a separate entity:

**Example: Professor Office Assignment**

```python
@schema
class Professor(dj.Manual):
    definition = """
    professor_id : int
    ---
    name : varchar(100)
    hire_date : date
    """

@schema
class Office(dj.Manual):
    definition = """
    office_number : varchar(10)
    ---
    building : varchar(50)
    phone : varchar(20)
    """

@schema
class ProfessorOfficeAssignment(dj.Manual):
    definition = """
    -> Professor
    ---
    -> Office
    assignment_date : date        # Property of the ASSIGNMENT
    """
```

**Why separate?**:
- The assignment is not a property of the professor (professors can change offices)
- The assignment is not a property of the office (offices can be reassigned)
- The assignment is an entity in itself, with its own properties (assignment_date)

### Normalization Requires Segregation

The process of normalization often requires **breaking a single table into multiple tables**, segregating information into distinct entity types:

#### Example: Denormalized Design

```python
# BAD: Mixing customer, account, and transaction data
@schema
class CustomerAccountTransaction(dj.Manual):
    definition = """
    transaction_id : int
    ---
    customer_name : varchar(100)      # Customer property
    customer_email : varchar(100)     # Customer property
    account_number : int              # Account identity
    account_type : varchar(20)        # Account property
    transaction_amount : decimal(10,2)# Transaction property
    transaction_date : date           # Transaction property
    """
```

**Problems**:
- Customer info repeated for every transaction (redundancy)
- Account info repeated for every transaction (redundancy)
- Can't have customers without transactions (insertion anomaly)
- Can't have accounts without transactions (insertion anomaly)

#### Normalized Design

```python
@schema
class Customer(dj.Manual):
    definition = """
    customer_id : int
    ---
    name : varchar(100)
    email : varchar(100)
    """

@schema
class Account(dj.Manual):
    definition = """
    account_number : int
    ---
    -> Customer
    account_type : varchar(20)
    """

@schema
class Transaction(dj.Manual):
    definition = """
    transaction_id : int
    ---
    -> Account
    amount : decimal(10,2)
    transaction_date : date
    """
```

**Benefits**:
- Each entity type is separate (Customer, Account, Transaction)
- No redundancy (customer info stored once)
- Can have customers without accounts, accounts without transactions
- Each table contains only attributes of that entity type

## Comparing Classical and DataJoint Normalization

### Classical Approach: Functional Dependencies

**Focus**: Mathematical properties of relations
**Question**: "What attributes determine what other attributes?"
**Method**: Identify functional dependencies, decompose to eliminate violations

**Example analysis**:
```
Relation: (student_id, course_id, student_name, dept_id, dept_name)

Functional dependencies:
- student_id → student_name, dept_id
- dept_id → dept_name
- course_id → (nothing in this relation)

Violations:
- Partial dependency: student_name depends on part of PK (violates 2NF)
- Transitive dependency: student_id → dept_id → dept_name (violates 3NF)

Decomposition:
- Student(student_id, student_name, dept_id)
- Department(dept_id, dept_name)
- Enrollment(student_id, course_id)
```

**Complexity**: Requires formal analysis of all functional dependencies. Can be difficult to apply intuitively.

### DataJoint Approach: Entity-Centric Normalization

**Focus**: Entities and their intrinsic properties
**Question**: "Does each attribute describe the entity identified by this row's primary key?"
**Method**: Design tables so each represents one entity type with only its own attributes

**Example analysis**:
```
Ask: What entity types do we have?
- Students (identified by student_id)
- Departments (identified by dept_id)
- Courses (identified by course_id)
- Enrollments (relationships between students and courses)

Design:
- Student table: Contains only student properties
- Department table: Contains only department properties
- Course table: Contains only course properties
- Enrollment table: Relates students to courses
```

**Simplicity**: Think about entities and what properties belong to them. Much more intuitive than analyzing functional dependencies.

### The Key Insight

Both approaches lead to the same result, but through different reasoning:

**Classical normalization**: "Eliminate functional dependency violations"
**DataJoint normalization**: "Separate distinct entity types"

DataJoint's approach is easier to understand and apply because it maps directly to how we conceptualize domains: as collections of entities with properties, not as collections of attributes with dependencies.

## Immutability and Workflow: Core Design Principles

DataJoint's normalization philosophy extends beyond avoiding redundancy—it fundamentally shapes how you think about data manipulation and schema evolution. Two principles are central: **immutability of tuples** and **schemas as workflows**.

### Principle 1: Entities as Immutable Tuples

A well-normalized DataJoint schema is designed so that all data manipulations are accomplished through **insert and delete operations only**, without requiring updates to existing rows.

#### Rows as Immutable Objects

**Concept**: Each row (tuple) in a table represents an immutable entity. Once created, the entity cannot be modified—only created or destroyed.

**Operations allowed**:
- ✅ **INSERT**: Create a new entity
- ✅ **DELETE**: Remove an entity
- ❌ **UPDATE**: Modify an existing entity's attributes (avoided)

**Why immutability?**

1. **Referential integrity operates on entire tuples**: Foreign keys establish relationships between complete rows, not individual attributes. When you reference a parent row, you're referencing its entire identity.

2. **History preservation**: Immutable records create an audit trail. Instead of updating a value, you delete the old record and insert a new one with the changed value.

3. **Consistency with constraints**: All constraints (foreign keys, unique indexes) relate entire tuples. Updates can violate constraints in subtle ways that inserts and deletes handle explicitly.

4. **Parallel processing**: Immutable data can be safely read by multiple processes without locks or race conditions.

#### Example: Mutable vs. Immutable Design

**Bad Design (Requires Updates)**:
```python
@schema
class Mouse(dj.Manual):
    definition = """
    mouse_id : int
    ---
    date_of_birth : date
    sex : enum('M', 'F')
    cage_id : int                 # ✗ Will change over time!
    current_weight : decimal(5,2) # ✗ Changes frequently!
    """

# Typical operation: UPDATE mouse SET cage_id = 42 WHERE mouse_id = 1
# Problem: Requires modifying existing row
```

**Good Design (Insert/Delete Only)**:
```python
@schema
class Mouse(dj.Manual):
    definition = """
    mouse_id : int
    ---
    date_of_birth : date          # ✓ Permanent property
    sex : enum('M', 'F')          # ✓ Permanent property
    """

@schema
class Cage(dj.Manual):
    definition = """
    cage_id : int
    ---
    location : varchar(50)        # ✓ Property of cage
    size : varchar(20)            # ✓ Property of cage
    """

@schema
class CageAssignment(dj.Manual):
    definition = """
    -> Mouse
    start_date : date
    ---
    -> Cage
    """

# Relocating a mouse: DELETE old assignment, INSERT new assignment
# No updates needed—immutable records
```

#### Why This Works

**Foreign keys relate entire tuples**:
```python
# When CageAssignment references Mouse:
-> Mouse

# It references the ENTIRE mouse entity (all its attributes together)
# Not just mouse_id in isolation
# The relationship is to the tuple: (mouse_id, date_of_birth, sex)
```

**Benefits**:
- Foreign key constraints check entire tuple existence
- No risk of partial updates breaking references
- Relationship semantics are clear: "this assignment relates to this specific mouse entity"

### Principle 2: Schemas as Workflows with Data Dependencies

DataJoint views schemas as **directed workflows** where downstream data depends on and is potentially derived from upstream data. This has profound implications for normalization.

#### Downstream Data Depends on Upstream Data

In a workflow schema:
- **Upstream tables**: Independent entities, source data
- **Downstream tables**: Derived results, computed values, dependent entities

**Critical insight**: Updating a secondary attribute in an upstream table may **invalidate** downstream data that was computed or derived from it.

#### Example: Data Invalidation

```
    RawImage                    ← Upstream: source data
       ↓
   PreprocessedImage            ← Derived from RawImage
       ↓
   SegmentedCells               ← Derived from PreprocessedImage
       ↓
   CellActivity                 ← Analyzed from SegmentedCells
```

**Scenario**: You discover an error in `RawImage` preprocessing parameters

**If you UPDATE `RawImage`**:
- ✗ All downstream data (`PreprocessedImage`, `SegmentedCells`, `CellActivity`) is now invalid
- ✗ No automatic mechanism to detect or fix the inconsistency
- ✗ Results may be incorrect, and you might not notice

**If you DELETE and INSERT**:
- ✓ Foreign key constraint violation: Can't delete `RawImage` while downstream data exists
- ✓ Forces you to delete entire pipeline downstream
- ✓ Then reinsert and recompute—ensures consistency
- ✓ Makes data dependencies explicit and enforceable

#### Why Updates Are Dangerous in Workflows

**Updates bypass referential integrity**:
```python
# Update doesn't trigger foreign key checks on dependent data
UPDATE raw_image SET brightness = 1.5 WHERE image_id = 42;

# But this image_id = 42 is referenced by downstream tables!
# Those downstream results are now based on outdated input
# No error raised, no warning given
```

**Delete-and-insert makes dependencies explicit**:
```python
# Try to delete
Mouse.delete()  # Raises error if CageAssignment references it

# Must delete downstream first
CageAssignment.delete()  # Delete dependent data
Mouse.delete()           # Then delete source

# Or use cascade delete (if configured)
Mouse.delete_quick()     # Deletes mouse and all dependent data
```

### Design Principle: Permanent vs. Changeable Attributes

A crucial normalization decision: **What attributes can change over time?**

#### The Rule

**Separate changeable attributes into their own entity tables**: Associate only **permanent, intrinsic attributes** with each entity.

**Permanent attributes**: Properties that are fixed once the entity is created
**Changeable attributes**: Properties that may be updated during the entity's lifetime

#### Example 1: Animal Housing (from Lecture)

**Bad Design**:
```python
@schema
class Mouse(dj.Manual):
    definition = """
    mouse_id : int
    ---
    date_of_birth : date          # ✓ Permanent
    sex : enum('M', 'F')          # ✓ Permanent
    cage_id : int                 # ✗ CHANGEABLE! Mouse can be relocated
    """

# Problem: When mouse is relocated, must UPDATE the mouse table
# This modifies the mouse entity, but location is not intrinsic to the mouse
```

**Good Design**:
```python
@schema
class Mouse(dj.Manual):
    definition = """
    mouse_id : int
    ---
    date_of_birth : date          # ✓ Permanent property of mouse
    sex : enum('M', 'F')          # ✓ Permanent property of mouse
    """

@schema
class Cage(dj.Manual):
    definition = """
    cage_id : int
    ---
    location : varchar(50)        # ✓ Property of cage
    capacity : int                # ✓ Property of cage
    """

@schema
class CageAssignment(dj.Manual):
    definition = """
    -> Mouse
    assignment_date : date        # When assignment started
    ---
    -> Cage
    """

# Relocating a mouse:
# 1. DELETE from CageAssignment WHERE mouse_id = X
# 2. INSERT into CageAssignment (mouse_id, cage_id, assignment_date) VALUES (X, Y, today)
# No updates—mouse entity remains immutable
```

**Why this is better**:
- Mouse entity is truly immutable (permanent attributes only)
- Cage assignment is a separate entity (the relationship)
- History can be preserved (keep old assignments, add new ones)
- No updates needed—just insert/delete operations

#### Example 2: Employee Department Assignment

**Bad Design**:
```python
@schema
class Employee(dj.Manual):
    definition = """
    employee_id : int
    ---
    name : varchar(100)           # ✓ Permanent (rarely changes)
    hire_date : date              # ✓ Permanent
    department_id : int           # ✗ CHANGEABLE! Employee can transfer
    """

# Problem: Employee transfers require UPDATE
# Modifies the employee entity unnecessarily
```

**Good Design**:
```python
@schema
class Employee(dj.Manual):
    definition = """
    employee_id : int
    ---
    name : varchar(100)
    hire_date : date
    """

@schema
class Department(dj.Manual):
    definition = """
    department_id : int
    ---
    department_name : varchar(100)
    """

@schema
class DepartmentAssignment(dj.Manual):
    definition = """
    -> Employee
    assignment_date : date
    ---
    -> Department
    """

# Employee transfers:
# 1. End current assignment (DELETE or add end_date)
# 2. Create new assignment (INSERT)
# Employee entity never modified
```

#### Example 3: Product Pricing

**Bad Design**:
```python
@schema
class Product(dj.Manual):
    definition = """
    product_id : int
    ---
    name : varchar(100)           # ✓ Permanent
    description : varchar(500)    # ✓ Permanent
    current_price : decimal(10,2) # ✗ CHANGEABLE! Prices fluctuate
    """

# Problem: Price changes require UPDATE
# Loses price history
```

**Good Design**:
```python
@schema
class Product(dj.Manual):
    definition = """
    product_id : int
    ---
    name : varchar(100)           # ✓ Permanent
    description : varchar(500)    # ✓ Permanent
    """

@schema
class ProductPrice(dj.Manual):
    definition = """
    -> Product
    effective_date : date
    ---
    price : decimal(10,2)         # ✓ Price at this date
    """

# Price changes: INSERT new ProductPrice record
# Preserves history, no updates needed
```

### The Temporal Evolution Design Rule

**Design Rule**: Think about the typical evolution of your data over time. Attributes that change should be modeled as separate entities.

**Questions to ask**:
1. Will this attribute ever change during the entity's lifetime?
2. If it changes, does the entity become "a different entity" or just "the same entity with updated info"?
3. Do I need to preserve history of changes?

**Decision tree**:
```
Is this attribute permanent for the entity's lifetime?
│
├─ YES ──→ Include in entity table
│          Example: Mouse.date_of_birth, Mouse.sex
│
└─ NO ───→ Create separate association/time-series table
           Example: CageAssignment, WeightMeasurement
```

### How This Relates to Workflows

In DataJoint's workflow view:

```
Mouse (permanent properties)
  ↓
CageAssignment (current relationship)
  ↓
Experiment (depends on current housing)
  ↓
Recording (depends on experiment conditions)
  ↓
Analysis (derived from recording)
```

**If you UPDATE Mouse to change cage_id**:
- All downstream data (Experiment, Recording, Analysis) is now inconsistent
- No automatic detection of the problem
- Data integrity is silently violated

**If you use separate CageAssignment table**:
- Cage changes are explicit INSERT/DELETE operations
- If housing conditions are referenced downstream, they're captured at that point in time
- Downstream data remains valid (it captured the housing at time of experiment)
- Data lineage is preserved

### Practical Guidelines for Immutable Design

#### ✓ DO: Model Time-Varying Properties as Separate Entities

**Good patterns**:
```python
# Weight measurements over time
@schema
class WeightMeasurement(dj.Manual):
    definition = """
    -> Mouse
    measurement_date : date
    ---
    weight : decimal(5,2)
    """

# Location history
@schema  
class LocationHistory(dj.Manual):
    definition = """
    -> Animal
    start_date : date
    ---
    -> Location
    end_date = null : date
    """

# Price history
@schema
class PriceHistory(dj.Manual):
    definition = """
    -> Product
    effective_date : date
    ---
    price : decimal(10,2)
    """
```

#### ✗ DON'T: Put Changeable State in Entity Tables

**Avoid**:
```python
@schema
class Mouse(dj.Manual):
    definition = """
    mouse_id : int
    ---
    current_cage : int            # ✗ Will change
    current_weight : decimal(5,2) # ✗ Changes over time
    last_experiment_date : date   # ✗ Changes
    """
```

#### ✓ DO: Think About What Makes an Entity's Identity

**Permanent identity attributes**:
- Properties that define what the entity fundamentally IS
- Would not change without making it a "different entity"
- Examples: date_of_birth, sex, species, genotype, serial_number

**Changeable state attributes**:
- Properties that describe the entity's current state
- Can change while entity remains "the same entity"
- Examples: location, weight, status, assigned_to

### Real-World Example: Laboratory Animal Management

Let's apply these principles to a complete example:

**Poor Design (Update-Heavy)**:
```python
@schema
class Animal(dj.Manual):
    definition = """
    animal_id : int
    ---
    species : varchar(50)         # Permanent
    date_of_birth : date          # Permanent
    sex : enum('M', 'F')          # Permanent
    cage_id : int                 # ✗ Changeable (relocation)
    current_weight : decimal(5,2) # ✗ Changeable (grows)
    health_status : varchar(20)   # ✗ Changeable (gets sick, recovers)
    """

# Typical operations require UPDATES:
UPDATE animal SET cage_id = 42 WHERE animal_id = 1;
UPDATE animal SET current_weight = 32.5 WHERE animal_id = 1;
UPDATE animal SET health_status = 'sick' WHERE animal_id = 1;
```

**Problems**:
- Lose history (what cage was the animal in last week?)
- Update anomalies (might update weight but forget to update measurement date)
- Referential integrity doesn't help (updates bypass foreign key checks)

**Well-Normalized Design (Insert/Delete Only)**:
```python
@schema
class Animal(dj.Manual):
    definition = """
    animal_id : int
    ---
    species : varchar(50)         # ✓ Permanent
    date_of_birth : date          # ✓ Permanent  
    sex : enum('M', 'F')          # ✓ Permanent
    genotype : varchar(50)        # ✓ Permanent
    """

@schema
class Cage(dj.Manual):
    definition = """
    cage_id : int
    ---
    location : varchar(50)
    rack : varchar(20)
    capacity : int
    """

@schema
class CageAssignment(dj.Manual):
    definition = """
    -> Animal
    start_date : date
    ---
    -> Cage
    end_date = null : date
    """

@schema
class WeightMeasurement(dj.Manual):
    definition = """
    -> Animal
    measurement_date : datetime
    ---
    weight : decimal(5,2)
    measured_by : varchar(50)
    """

@schema
class HealthCheck(dj.Manual):
    definition = """
    -> Animal  
    check_date : datetime
    ---
    health_status : enum('healthy', 'sick', 'injured', 'recovering')
    notes : varchar(500)
    veterinarian : varchar(100)
    """

# Operations are INSERT/DELETE only:
# Relocate animal: INSERT into CageAssignment (new assignment)
# Record weight: INSERT into WeightMeasurement (new measurement)
# Health update: INSERT into HealthCheck (new check record)
```

**Advantages**:
- ✅ Complete history preserved
- ✅ Each measurement is an immutable record
- ✅ Can query historical states ("where was mouse X on date Y?")
- ✅ No update anomalies possible
- ✅ Each table represents a clear entity type
- ✅ Downstream data remains valid (captured state at specific time)

### Principle 2: Updates Invalidate Downstream Data

In DataJoint's workflow model, data flows from upstream (independent entities) to downstream (derived/computed entities):

```
Upstream (Source)
    ↓
Intermediate  
    ↓
Downstream (Derived)
```

**The problem with updates**: If you update upstream data, all downstream data that was computed from the old values becomes invalid.

#### Example: Image Processing Pipeline

```python
@schema
class RawImage(dj.Manual):
    definition = """
    image_id : int
    ---
    image_data : longblob
    acquisition_settings : varchar(200)  # Parameters used
    """

@schema
class ProcessedImage(dj.Computed):
    definition = """
    -> RawImage
    ---
    processed_data : longblob
    processing_timestamp : timestamp
    """
    
    def make(self, key):
        # Uses RawImage.acquisition_settings to process
        raw = (RawImage & key).fetch1()
        processed = process_with_settings(raw)
        self.insert1({**key, 'processed_data': processed})

@schema
class CellSegmentation(dj.Computed):
    definition = """
    -> ProcessedImage
    ---
    cell_count : int
    segmentation_mask : longblob
    """
    
    def make(self, key):
        # Derives from ProcessedImage
        processed = (ProcessedImage & key).fetch1()
        cells = segment_cells(processed)
        self.insert1({**key, **cells})
```

**Scenario**: You discover `acquisition_settings` was recorded incorrectly

**If you UPDATE**:
```python
# BAD: Update upstream data
(RawImage & {'image_id': 42}).update1({'acquisition_settings': 'corrected'})

# Result:
# - ProcessedImage still has old processing (based on wrong settings)
# - CellSegmentation still has old segmentation (based on wrong processing)
# - NO ERROR RAISED
# - Data is silently inconsistent
```

**If you DELETE and INSERT**:
```python
# GOOD: Delete and reinsert
(RawImage & {'image_id': 42}).delete()  
# ↑ BLOCKED by foreign key! Must delete downstream first

# Proper workflow:
(CellSegmentation & {'image_id': 42}).delete()  # Delete furthest downstream
(ProcessedImage & {'image_id': 42}).delete()    # Delete intermediate
(RawImage & {'image_id': 42}).delete()          # Delete source

# Reinsert with corrected data
RawImage.insert1({'image_id': 42, 'acquisition_settings': 'corrected', ...})

# Recompute downstream (automatically or manually)
ProcessedImage.populate({'image_id': 42})       # Recomputes with new settings
CellSegmentation.populate({'image_id': 42})     # Recomputes from new processing

# Result: All data is consistent throughout pipeline
```

### The Design Question: "Can This Change?"

For every attribute in your schema, ask:

**"If this attribute's value changes, does it represent the same entity or a different snapshot/state of the entity?"**

#### Examples of Permanent Attributes (Include in Entity Table)

**Mouse**:
- `date_of_birth` — Never changes
- `sex` — Never changes (for most species)
- `genotype` — Fixed at birth
- `animal_id` — Permanent identifier

**Person**:
- `date_of_birth` — Fixed
- `social_security_number` — Fixed (in practice)
- `place_of_birth` — Fixed

**Product**:
- `manufacturer` — Part of product definition
- `model_number` — Defines the product
- `release_date` — When product was introduced

#### Examples of Changeable Attributes (Separate Entity Table)

**Mouse**:
- `cage_id` → Create `CageAssignment` table
- `weight` → Create `WeightMeasurement` table  
- `health_status` → Create `HealthCheck` table

**Person**:
- `address` → Create `Address` table with start/end dates
- `employer` → Create `Employment` table
- `phone_number` → Create `ContactInfo` table

**Product**:
- `price` → Create `ProductPrice` table with effective dates
- `inventory_count` → Create `InventorySnapshot` table
- `supplier` → Create `SupplierContract` table

### Workflow Consistency Example

Consider an experimental workflow:

```python
@schema
class Experiment(dj.Manual):
    definition = """
    experiment_id : int
    ---
    -> Animal          # References animal at time of experiment
    -> Cage            # References cage at time of experiment
    experiment_date : date
    """

@schema
class Recording(dj.Computed):
    definition = """
    -> Experiment
    ---
    recording_data : longblob
    """

@schema
class Analysis(dj.Computed):
    definition = """
    -> Recording
    ---
    result : float
    """
```

**Scenario**: After experiment, animal is relocated to different cage

**If cage_id was in Animal table and you UPDATE**:
- Experiment now incorrectly shows animal was in the new cage
- Historical record is corrupted
- Can't reproduce the experiment conditions

**With separate CageAssignment table**:
- Experiment captures the cage assignment at that point in time
- Animal can be relocated without affecting past experiments
- Historical integrity preserved
- Data lineage is accurate

### The Immutability Contract

When you design with immutability in mind:

1. **Entities are eternal** (once created, their identity and permanent properties never change)
2. **Relationships evolve** (associations can be created and destroyed)
3. **Time-series are append-only** (measurements accumulate, never modified)
4. **Derived data is reproducible** (delete and recompute from source)

**This contract ensures**:
- Referential integrity is never violated
- Data lineage is always traceable
- Historical records are immutable
- Downstream dependencies are explicit and enforceable

## Normalization in Schema Design

When designing a DataJoint schema, apply the normalization principle at each table:

### Step 1: Identify Entity Types

Ask: "What are the things (entities) in my domain?"

**Example domain**: University course management
- Students
- Professors  
- Courses
- Departments
- Enrollments (student taking a course)
- Course Offerings (course taught in a specific semester)

### Step 2: For Each Entity, List Its Intrinsic Properties

**Intrinsic properties**: Attributes that describe the entity itself, regardless of its relationships

```python
@schema
class Student(dj.Manual):
    definition = """
    student_id : int
    ---
    name : varchar(100)           # ✓ Property of student
    date_of_birth : date          # ✓ Property of student
    email : varchar(100)          # ✓ Property of student
    # NOT: major_name              ✗ Property of major, not student
    # NOT: advisor_name            ✗ Property of professor, not student
    """
```

### Step 3: Represent Relationships Separately

When entities relate to each other, the relationship may need its own table:

```python
@schema
class Student(dj.Manual):
    definition = """
    student_id : int
    ---
    name : varchar(100)
    """

@schema
class Major(dj.Manual):
    definition = """
    major_code : varchar(10)
    ---
    major_name : varchar(100)
    department : varchar(50)
    """

@schema
class StudentMajor(dj.Manual):
    definition = """
    -> Student
    ---
    -> Major
    declaration_date : date       # Property of the RELATIONSHIP
    """
```

The `declaration_date` is not a property of the student or the major—it's a property of the relationship between them.

## Practical Normalization Guidelines

When designing DataJoint schemas, follow these practical rules:

### ✓ DO: Separate Entities from Relationships

**Good**:
```python
@schema
class Employee(dj.Manual):
    definition = """
    employee_id : int
    ---
    name : varchar(100)
    """

@schema
class Project(dj.Manual):
    definition = """
    project_id : int
    ---
    title : varchar(200)
    """

@schema
class Assignment(dj.Manual):
    definition = """
    -> Employee
    -> Project
    ---
    percent_effort : decimal(4,1)
    """
```

### ✗ DON'T: Mix Entity Properties from Different Entity Types

**Bad**:
```python
@schema
class Employee(dj.Manual):
    definition = """
    employee_id : int
    ---
    name : varchar(100)
    office_building : varchar(50)     # ✗ Property of office!
    office_phone : varchar(20)        # ✗ Property of office!
    current_project_title : varchar(200)  # ✗ Property of project!
    """
```

### ✓ DO: Use Foreign Keys for Relationships

**Good**:
```python
@schema
class Employee(dj.Manual):
    definition = """
    employee_id : int
    ---
    name : varchar(100)
    """

@schema
class Office(dj.Manual):
    definition = """
    office_number : varchar(10)
    ---
    building : varchar(50)
    phone : varchar(20)
    """

@schema
class EmployeeOffice(dj.Manual):
    definition = """
    -> Employee
    ---
    -> Office
    assignment_date : date
    """
```

### ✗ DON'T: Embed Related Entity Data

**Bad**:
```python
@schema
class Order(dj.Manual):
    definition = """
    order_id : int
    ---
    customer_name : varchar(100)      # ✗ Embed customer data
    customer_email : varchar(100)     # ✗ Redundant
    product_name : varchar(200)       # ✗ Embed product data
    product_price : decimal(10,2)     # ✗ Redundant
    """
```

**Good**: Use foreign keys and join when needed
```python
@schema
class Order(dj.Manual):
    definition = """
    order_id : int
    ---
    -> Customer
    -> Product
    order_date : date
    quantity : int
    """

# Get customer and product info when needed:
Order * Customer * Product
```

## Normalization Trade-offs

While normalization eliminates anomalies, it requires joining tables to retrieve related information.

### The Trade-off

**Highly normalized** (many small tables):
- ✅ No redundancy
- ✅ No update anomalies
- ✅ Clear entity separation
- ❌ Requires joins for queries
- ❌ More tables to manage

**Denormalized** (few large tables):
- ✅ Fewer joins needed
- ✅ Faster for certain queries
- ❌ Data redundancy
- ❌ Update anomalies
- ❌ Larger storage footprint

### DataJoint's Position

DataJoint strongly favors **full normalization** because:

1. **Foreign keys are efficient**: Primary key indexes make joins fast
2. **Solid lines enable direct joins**: Cascading primary keys reduce join complexity
3. **Integrity matters more than speed**: Correctness over convenience
4. **Storage is cheap, consistency is expensive**: Data errors cost more than disk space

**Design philosophy**: Normalize fully, then optimize queries if needed (not the other way around).

## Special Cases and Exceptions

### When Mild Denormalization Might Be Acceptable

In certain scenarios, you might choose to denormalize slightly:

**1. Computed Aggregates (Cached Results)**:
```python
@schema
class Customer(dj.Manual):
    definition = """
    customer_id : int
    ---
    name : varchar(100)
    """

@schema
class CustomerStats(dj.Computed):
    definition = """
    -> Customer
    ---
    total_orders : int         # Cached count
    lifetime_value : decimal(10,2)  # Cached sum
    last_order_date : date     # Cached max
    """
```

**Justification**: These are computed from other tables but cached for performance. They're still "about" the customer entity.

**2. Lookup Values (Denormalized for Readability)**:
```python
@schema
class Enrollment(dj.Manual):
    definition = """
    -> Student
    -> Course
    ---
    grade : char(1)
    grade_points : decimal(3,2)  # Could be computed from grade
    """
```

**Justification**: `grade_points` is functionally dependent on `grade`, but storing it avoids repeated lookups.

### The Guiding Question

When unsure whether to include an attribute:

**Ask**: "Is this attribute an intrinsic, permanent property of the entity identified by this row's primary key, or is it a property of some other entity?"

- If it describes this entity → Include it
- If it describes a related entity → Foreign key to that entity
- If it describes a relationship → Separate relationship table

## Examples: Normalized vs. Denormalized

### Example 1: Product Catalog

**Denormalized (Bad)**:
```python
@schema
class Product(dj.Manual):
    definition = """
    product_id : int
    ---
    product_name : varchar(100)
    category_name : varchar(50)       # ✗ Property of category
    category_description : varchar(200) # ✗ Property of category
    manufacturer_name : varchar(100)   # ✗ Property of manufacturer
    manufacturer_country : varchar(50) # ✗ Property of manufacturer
    """
```

**Normalized (Good)**:
```python
@schema
class Category(dj.Manual):
    definition = """
    category_id : int
    ---
    category_name : varchar(50)
    description : varchar(200)
    """

@schema
class Manufacturer(dj.Manual):
    definition = """
    manufacturer_id : int
    ---
    name : varchar(100)
    country : varchar(50)
    """

@schema
class Product(dj.Manual):
    definition = """
    product_id : int
    ---
    product_name : varchar(100)
    -> Category
    -> Manufacturer
    """
```

### Example 2: Course Enrollment

**Denormalized (Bad)**:
```python
@schema
class Enrollment(dj.Manual):
    definition = """
    enrollment_id : int
    ---
    student_name : varchar(100)       # ✗ Property of student
    student_email : varchar(100)      # ✗ Property of student
    course_title : varchar(200)       # ✗ Property of course
    course_credits : int              # ✗ Property of course
    professor_name : varchar(100)     # ✗ Property of professor
    """
```

**Normalized (Good)**:
```python
@schema
class Student(dj.Manual):
    definition = """
    student_id : int
    ---
    name : varchar(100)
    email : varchar(100)
    """

@schema
class Course(dj.Manual):
    definition = """
    course_id : int
    ---
    title : varchar(200)
    credits : int
    """

@schema
class CourseOffering(dj.Manual):
    definition = """
    -> Course
    semester : varchar(20)
    year : int
    ---
    -> Professor
    """

@schema
class Enrollment(dj.Manual):
    definition = """
    -> Student
    -> CourseOffering
    ---
    grade : char(1)
    """
```

## The "Nothing But The Entity" Rule

A helpful way to remember DataJoint's normalization principle:

> **"Each table should contain attributes about the entity, the whole entity, and nothing but the entity."**

This is a variation of the classical mnemonic "the key, the whole key, and nothing but the key," but focused on entities rather than functional dependencies.

**Applied**:
- **The entity**: All attributes must describe the entity identified by the primary key
- **The whole entity**: Include all relevant intrinsic properties (don't split unnecessarily)
- **Nothing but the entity**: Exclude properties of related entities (use foreign keys instead)

## Normalization Examples in Context

### Example: Scientific Experiment Database

**Following DataJoint normalization**:

```python
@schema
class Animal(dj.Manual):
    definition = """
    animal_id : int
    ---
    species : varchar(50)        # ✓ Property of animal
    date_of_birth : date         # ✓ Property of animal
    sex : enum('M', 'F')         # ✓ Property of animal
    # NOT: cage_location          ✗ Property of housing assignment
    # NOT: current_weight         ✗ Property of specific measurement
    """

@schema
class Cage(dj.Manual):
    definition = """
    cage_id : int
    ---
    location : varchar(50)       # ✓ Property of cage
    size : varchar(20)           # ✓ Property of cage
    """

@schema
class Housing(dj.Manual):
    definition = """
    -> Animal
    ---
    -> Cage
    start_date : date            # ✓ Property of housing assignment
    """

@schema
class WeightMeasurement(dj.Manual):
    definition = """
    -> Animal
    measurement_date : date
    ---
    weight : decimal(5,2)        # ✓ Property of this measurement
    """
```

**Why this is normalized**:
- Animal table: Only permanent properties of animals
- Cage table: Only properties of cages
- Housing: The relationship (assignment) with its own property (start_date)
- WeightMeasurement: Time-series data, each measurement is an entity

### Example: Social Network

```python
@schema
class User(dj.Manual):
    definition = """
    user_id : int
    ---
    username : varchar(50)        # ✓ Property of user
    email : varchar(100)          # ✓ Property of user
    join_date : date              # ✓ Property of user
    # NOT: friend_count           ✗ Computed from relationships
    # NOT: last_post_text         ✗ Property of post
    """

@schema
class Post(dj.Manual):
    definition = """
    post_id : int
    ---
    -> User                       # Who created the post
    post_text : varchar(1000)    # ✓ Property of post
    post_date : date             # ✓ Property of post
    # NOT: author_name            ✗ Property of user (use join)
    """

@schema
class Friendship(dj.Manual):
    definition = """
    -> User.proj(user_a='user_id')
    -> User.proj(user_b='user_id')
    ---
    friendship_date : date        # ✓ Property of relationship
    """
```

## Summary

### Classical Normalization (Codd)
- **Foundation**: Functional dependencies between attributes
- **Goal**: Eliminate update, insertion, deletion anomalies
- **Method**: Decompose relations based on dependency analysis
- **Era**: Pre-Entity-Relationship model (early 1970s)
- **Focus**: Mathematical properties of relations

### DataJoint Normalization
- **Foundation**: Entities and their intrinsic properties
- **Goal**: Separate distinct entity types, eliminate redundancy
- **Method**: Design tables to represent one entity type each
- **Era**: Post-ER model (leverages conceptual clarity)
- **Focus**: Semantic meaning of entities and relationships
- **Key principles**: Immutability of tuples, schemas as workflows, permanent vs. changeable attributes

### The Unified Principle

> **Every table must have a well-defined entity type, and all attributes must describe that entity type directly.**

When this principle is followed:
- Update anomalies are eliminated (each fact stored once)
- Insertion anomalies are eliminated (entities can exist independently)
- Deletion anomalies are eliminated (deleting one entity doesn't affect others)
- Schema structure is clear (one entity type per table)
- Data integrity is maintained through immutable tuples and explicit dependencies

### Practical Application

When designing or reviewing a schema:

1. **For each table, ask**: "What entity type does this table represent?"
2. **For each attribute, ask**: "Is this an intrinsic property of that entity?"
3. **If no**: Move the attribute to its proper entity table or create a relationship table

This intuitive approach achieves the same rigor as classical normal forms but is much easier to apply in practice, especially in complex scientific and computational workflows.

