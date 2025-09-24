# Primary Key

The **primary key** is the cornerstone of relational database design, serving as the unique identifier for each record in a table. It ensures **entity integrity**—the guarantee of a one-to-one correspondence between real-world entities and their digital representations in the database.

```{card}
**Primary Key** is a column or combination of columns that uniquely identifies each row in a table. 

In DataJoint, each table must have a primary key. This applies to both tables stored in the database as well as tables resulting from queries.

**Entity integrity** is the guarantee of a 1:1 correspondence between real-world entities and their digital representations.

Within the domain governed by the data management process, each real-world entity must be represented by exactly one unique record in the database; conversely, each record must correspond to a single, distinct real-world entity.
```

Imagine what kinds of difficulties would arise if entity integrity broke down in the systems you interact with every day.
* For example, what would happen if your university or company HR department had two different identifies for you in their records?
* What would happen your HR department occasionally updated your records with another person's information?  
* What if the same ocurred in your dentist's office?

Without entity integrity, it is impossible to maintain other aspects of integrity within the database.
For example, a foreign key relationship assumes that every referenced entity exists uniquely and correctly in the database—an assumption that can only hold true if entity integrity is enforced.

# Challenges to Entity Integrity
It is perhaps no coincidence that the word *integrity* is synonymous with *honesty* and entity integrity often relies on the the participants' knowledge, honesty, trust, transparency, and open communication.
However, for large and complex data operations, entity integrity must be designed into the system.

The challenge of ensuring entity integrity lies in the fact that it cannot be fully solved by the database system alone.
A reliable system for identifying objects in the real world must be established outside the database to ensure that each entity has a unique and persistent identifier that can be consistently used across all related data records by all participants.

This requires setting up a disciplined process outside the database.

## The Three Questions of Entity Integrity

When designing a database system, you must be able to answer three fundamental questions about entity integrity:

1. **How do I prevent duplicate records?** - Ensure that the same real-world entity cannot be represented by multiple database records.

2. **How do I prevent entities sharing the same record?** - Ensure that different real-world entities cannot be represented by the same database record.

3. **How do I match entities?** - When a real-world entity comes to you, how do you find its corresponding record in the database?

### Example: Laboratory Mice Database

Consider a neuroscience laboratory that needs to track mice used in experiments:

**Question 1: How do I prevent duplicate records?**
- Each mouse gets a unique ear tag number when it arrives at the lab
- The database enforces that no two mice can have the same ear tag number
- Before inserting a new mouse record, the system checks if that ear tag already exists

**Question 2: How do I prevent entities sharing the same record?**
- Each ear tag number can only be assigned to one mouse
- If a mouse dies and the ear tag is reused, the old record must be properly archived or marked as inactive

**Question 3: How do I match entities?**
- When a researcher brings a mouse to the lab, they can look up the mouse by its ear tag number
- The database can quickly find the mouse's record using the ear tag as the primary key
- All related experiment records can be linked to this mouse through the ear tag

## Entity Integrity in Practice

The three questions of entity integrity must be answered not just in theory, but in practice through your database design and business processes.

### Example: University Student Database

**Question 1: How do I prevent duplicate records?**
- Each student gets a unique student ID number when they enroll
- The database enforces that no two students can have the same student ID
- Before inserting a new student record, the system checks if that student ID already exists

**Question 2: How do I prevent entities sharing the same record?**
- Each student ID can only be assigned to one person
- If a student graduates and the ID is reused years later, the old record must be properly archived

**Question 3: How do I match entities?**
- When a student comes to the registrar's office, they can look up their record by student ID
- The database can quickly find the student's record using the student ID as the primary key
- All related records (grades, courses, payments) can be linked to this student through the student ID

### Example: Laboratory Animal Database

**Question 1: How do I prevent duplicate records?**
- Each animal gets a unique ear tag or microchip ID when it arrives at the lab
- The database enforces that no two animals can have the same ID
- Before inserting a new animal record, the system checks if that ID already exists

**Question 2: How do I prevent entities sharing the same record?**
- Each ID can only be assigned to one animal
- If an animal dies and the ID is reused, the old record must be properly archived or marked as inactive

**Question 3: How do I match entities?**
- When a researcher brings an animal to the lab, they can look up the animal by its ID
- The database can quickly find the animal's record using the ID as the primary key
- All related experiment records can be linked to this animal through the ID

If you can answer these three questions clearly for your domain, then you have designed for entity integrity.

For example, establishing the Social Security system in the United States required a reliable identification of workers by all employers to report their income across their entire careers.
For this purpose, in 1936, the Federal Government established a new process to ensure that each US worker would be assigned a unique number, the Social Security Number (SSN).
The SSN would be assigned at birth or at entering the country for employment and no person would be allowed to have two such numbers. 
Establishing and enforcing such a system is not easy and takes a considerable effort.
The SSN allows for the accurate and consistent representation of individuals across various government databases, ensuring that each person is correctly identified. 

**Question**: Why do you think the US government did not have the need to assign unique identifiers to tax payers when it began levying federal taxes in 1913?

**Question**: What abuses would become possible if a person could obtain two SSNs or if two persons could share the same SSN?

**Learn more** about the history and uses of the SSN:
  * [History of establishing the SSN.](https://www.ssa.gov/history/ssn/firstcard.html)
  * [How the SSN works.](https://www.ssa.gov/policy/docs/ssb/v69n2/v69n2p55.html)
  * [IRS timeline.](https://www.irs.gov/irs-history-timeline)

Similar rigor is required for identifying other objects in the real world:
  * [Vehicle Identification Number](https://www.iso.org/standard/52200.html), regulated by the International Organization for Standardization.
  * [Radio-Frequency Identification for Animals](https://en.wikipedia.org/wiki/ISO_11784_and_ISO_11785) for implanted microchips in animals.
  * [US Aircraft Registration numbers](https://www.faa.gov/licenses_certificates/aircraft_certification/aircraft_registry/forming_nnumber), the N-numbers seen on the tails, regulated by the FAA. 

These examples demonstrate that establishing a rigorous system for identification may require costly standardization efforts with many systems for enforcement and coordination.

When a science lab sets out to establish a data management process for its experiment, the first step is to establish a uniform system for identifying test subjects, experiments, protocols, and treatments.
Standard nomenclatures are established to standardize names across all institutions and labs must be aware of them and follow them.

# Entity Integrity in Schema Design

Several key aspects of relational database design contribute to maintaining entity integrity:

## Step 1. Determine Entity Types

Each table in a relational database should clearly indicate the type of real-world entity it represents.
The table name plays a crucial role in conveying this information.
For instance, if a table is named `Person`, the database must enforce entity integrity for individuals, ensuring each record corresponds to a unique person.

However, if the table uses identifiers that do not ensure a 1:1 mapping to actual persons—such as cell phone numbers, which might be shared or changed—a more appropriate table name should be chosen, like `UserAccount`, to reflect the specific entity type being represented.
This clarity helps avoid confusion and ensures that the database design accurately mirrors the real-world relationships it models.

## Step 2. Establish Entity Identification 
For all entities tracked by the database, determine how the entities will be identified in the physical world.
This may require establishing and enforcing an identification system.

## Step 3. Define Primary Keys and Secondary Unique Indexes

Every table in a relational database must have a **primary key**, and the attributes of the primary key cannot be nullable. This requirement is essential for maintaining **entity integrity**, as it prevents the creation of records that cannot be uniquely identified.

In addition to the primary key, a table may have **secondary unique indexes** to help enforce a one-to-one correspondence between records and the real-world entities they represent. These unique indexes can be applied to other attributes that need to be unique across the table but are allowed to be nullable.

For example, in a `Person` table, unique indexes might be enforced on attributes like **email addresses**, **usernames**, **driver’s licenses**, **cellphone numbers**, or **Social Security numbers**. These indexes ensure that no duplicate entries exist for attributes that are intended to be unique, further supporting entity integrity.

## Looser Entity Integrity

Depending on the business needs, **entity integrity** requirements can vary. Some businesses may allow multiple digital identities per person, while others may tolerate multiple people sharing a single digital identity. Other businesses may require a strict one-to-one match between real-world entities and their digital representations.

### Example 1: Gym Memberships

A gym may enforce that no two people use the same membership (ensuring uniqueness per membership). However, they may not need to prevent an individual from opening multiple memberships, leading to looser enforcement of entity integrity.

**Gym's Entity Integrity Policy:**
- ✅ **Prevent**: Two people sharing the same membership
- ❌ **Allow**: One person having multiple memberships
- **Reasoning**: They want to track individual usage patterns but don't mind duplicate memberships for revenue

### Example 2: Grocery Store Discount Cards (2010s)

Grocery stores issued discount cards to shoppers to qualify them for discounts, but they did not strictly enforce a one-to-one mapping between cards and individual shoppers.

**Grocery Store's Entity Integrity Policy:**
- ✅ **Allow**: Multiple people using the same card
- ✅ **Allow**: One person using multiple cards
- **Reasoning**: Primary goal is data collection for marketing, not strict individual tracking

**Why this works for grocery stores:**
- They care more about **purchase patterns** than individual identity
- Multiple family members can share one card
- Customers can get multiple cards for different households
- The data is still valuable for inventory and marketing decisions

### Example 3: Airline Security (Strict Entity Integrity)

Airlines require **absolute entity integrity** because:
- **Security**: Must verify passenger identity matches ticket holder
- **Safety**: Need to know exactly who is on each flight
- **Legal**: Required by government regulations

**Airline's Entity Integrity Policy:**
- ❌ **Prevent**: Two people sharing the same ticket
- ❌ **Prevent**: One person having multiple identities
- **Enforcement**: Photo ID verification, biometric checks, government databases

This flexibility in entity integrity allows businesses to balance strict data rules with practical needs for customer management and data collection.


## Using Natural Keys

A table can be designed with a **natural primary key**, which is an identifier that exists in the real world. For example, a Social Security Number (SSN) can serve as a natural key for a person because it is a unique number used and recognized in real-world systems.

In some cases, a natural key already exists, or one can be specifically created for data management purposes and then introduced into the real world to be permanently associated with physical entities.

For instance, grocery and hardware stores use **SKU (Stock Keeping Unit)** numbers to track inventory. Each item is assigned an SKU, and store clerks can look it up for specific products.

Other common examples of natural keys include **phone numbers** and **email addresses**, which are often used as unique identifiers in phone apps and online services.

Phone numbers, in particular, have become popular as identifiers as mobile phones have evolved from being associated with homes or offices to being personal devices carried by individuals.

# Composite Primary Keys

Sometimes, a single column cannot uniquely identify a record. In these cases, we use a **composite primary key**—a primary key made up of multiple columns that together uniquely identify each row.

## Example: U.S. House of Representatives

Consider tracking U.S. representatives. A single district number (like "District 1") is not sufficient because there are multiple District 1s across different states. To uniquely identify a representative, you need both the **state** and the **district number**.

(DataJoint)
```python
@schema
class USRepresentative(dj.Manual):
    definition = """
    state : char(2)
    district : tinyint unsigned
    ---
    name : varchar(60)
    party : char(1)
    phone : varchar(20)
    office_room : varchar(20)
    """
```
(Equivalent SQL)
```sql
CREATE TABLE us_representative (
    state CHAR(2) NOT NULL,
    district TINYINT UNSIGNED NOT NULL,
    name VARCHAR(60) NOT NULL,
    party CHAR(1) NOT NULL,
    phone VARCHAR(20),
    office_room VARCHAR(20),
    PRIMARY KEY (state, district)
);
```

The composite primary key `(state, district)` ensures that:
- No two representatives can have the same state-district combination
- Each representative is uniquely identified by their state and district
- The table accurately represents the real-world constraint that each congressional district belongs to exactly one state

## Example: Boston Marathon Champions

For tracking marathon champions, you need both the **year** and the **division** (men's or women's) to uniquely identify each champion.

::::{tab-set}
::: {tab-item} DataJoint
```python
@schema
class MarathonChampion(dj.Manual):
    definition = """
    year : int
    division : enum('men', 'women')
    ---
    name : varchar(60)
    country : char(2)
    time_in_seconds : decimal(8,3)
    """
```
:::
::: {tab-item} SQL
```sql
CREATE TABLE marathon_champions (
    year YEAR NOT NULL,
    division ENUM('men', 'women') NOT NULL,
    name VARCHAR(60) NOT NULL,
    country CHAR(2) NOT NULL,
    time_in_seconds DECIMAL(8,3) NOT NULL,
    PRIMARY KEY (year, division)
);
```
:::
::::
This design ensures that each year has exactly one men's champion and one women's champion, preventing duplicate entries for the same year-division combination.

## When to Use Composite Primary Keys

Use composite primary keys when:
- **Multiple attributes together** uniquely identify an entity
- **Single attributes are insufficient** for unique identification
- **Real-world constraints** require multiple pieces of information for identification
- **Natural business rules** dictate that combinations must be unique

# Using Surrogate Keys

In many cases, it makes more sense to use a **surrogate key** as the primary key in a database. A surrogate key has no relationship to the real world and is used solely within the database for identification purposes. These keys are often generated automatically as an **auto-incrementing number** or a **random string** like a UUID (Universally Unique Identifier) or GUID (Globally Unique Identifier).

When using surrogate keys, entity integrity can still be maintained by using other unique attributes (such as secondary unique indexes) to help identify and match entities to their digital representations.

Surrogate keys are especially useful for entities that exist only in digital form (e.g., social media posts, email messages) and don't need to be uniquely identified outside of the digital system. In these cases, surrogate keys are an appropriate and efficient choice.

## Universally Unique Identifiers (UUIDs)

**UUIDs** (Universally Unique Identifiers) are 128-bit identifiers that are designed to be globally unique across time and space. They are standardized by RFC 4122 and provide a reliable way to generate surrogate keys without coordination between different systems.

### UUID Format

UUIDs are typically represented as hexadecimal strings in the format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`

For example: `550e8400-e29b-41d4-a716-446655440000`

This format uses 32 hexadecimal digits (128 bits total) arranged in groups of 8-4-4-4-12 characters, separated by hyphens.

### UUID Types

There are several types of UUIDs, each with different characteristics:

#### UUID1: Time-based UUIDs

UUID1 generates identifiers based on:
- **Timestamp**: Current time (60-bit timestamp)
- **Node ID**: MAC address of the network interface (48 bits)
- **Clock sequence**: Sequence number to handle clock rollbacks (14 bits)

```python
import uuid

# Generate UUID1
uuid1_value = uuid.uuid1()
print(uuid1_value)  # e.g., 6ba7b810-9dad-11d1-80b4-00c04fd430c8
```

**Characteristics:**
- **Sequential**: UUIDs generated close in time will be similar
- **Sortable**: Can be used for ordering records by creation time
- **Traceable**: Contains information about the computer that generated it
- **Collision-resistant**: Very low probability of duplicates

**Use cases:**
- Database primary keys where ordering matters
- Log entries
- Event tracking systems

#### UUID4: Random UUIDs

UUID4 generates purely random identifiers:

```python
# Generate UUID4
uuid4_value = uuid.uuid4()
print(uuid4_value)  # e.g., f47ac10b-58cc-4372-a567-0e02b2c3d479
```

**Characteristics:**
- **Random**: No predictable pattern
- **Not sortable**: Random values don't maintain chronological order
- **Anonymous**: No information about the generating system
- **Collision-resistant**: Extremely low probability of duplicates

**Use cases:**
- Anonymous identifiers
- Session tokens
- API keys
- Any case where you don't need ordering

#### UUID3 and UUID5: Name-based UUIDs

UUID3 and UUID5 generate deterministic identifiers based on a namespace and a name:

```python
# Define a namespace (typically another UUID)
namespace = uuid.uuid4()

# Generate UUID5 (recommended over UUID3)
uuid5_value = uuid.uuid5(namespace, "neuroscience")
print(uuid5_value)  # Same result every time for same namespace + name

# Generate UUID3 (uses MD5 hash)
uuid3_value = uuid.uuid3(namespace, "neuroscience")
print(uuid3_value)  # Different from UUID5 but also deterministic
```

**Characteristics:**
- **Deterministic**: Same input always produces same UUID
- **Hierarchical**: Can create structured identifier systems
- **Collision-resistant**: Different names produce different UUIDs
- **Reproducible**: Same namespace + name = same UUID

**Use cases:**
- Hierarchical data structures
- Content-addressable systems
- Topic categorization
- File system identifiers

### Practical UUID Examples

#### Example 1: Social Media Posts
(DataJoint)
```python
@schema
class Post(dj.Manual):
    definition = """
    post_id : uuid
    ---
    -> User
    content : varchar(1024)
    created_at = CURRENT_TIMESTAMP : timestamp
    updated_at = CURRENT_TIMESTAMP : timestamp
    visibility : enum('public', 'friends', 'private')
    """
```
(Equivalent SQL)
```sql
CREATE TABLE posts (
    post_id CHAR(36) PRIMARY KEY,  -- UUID as string
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert with UUID4 (random)
INSERT INTO posts (post_id, user_id, content) 
VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 123, 'Hello world!');
```

#### Example 2: Hierarchical Categories

```python
import uuid

# Create a hierarchical category system
root_namespace = uuid.uuid4()

# Generate consistent IDs for categories
science_id = uuid.uuid5(root_namespace, "science")
biology_id = uuid.uuid5(science_id, "biology")
neuroscience_id = uuid.uuid5(biology_id, "neuroscience")

print(f"Science: {science_id}")
print(f"Biology: {biology_id}")
print(f"Neuroscience: {neuroscience_id}")
```

#### Example 3: File Management System

(DataJoint)
```python
@schema
class File(dj.Manual):
    definition = """
    file_id : uuid
    ---
    original_name : varchar(255)
    file_path : varchar(500)
    file_size : bigint unsigned
    upload_date = CURRENT_TIMESTAMP : timestamp
    """
```
(Equivalent SQL)
```sql
CREATE TABLE files (
    file_id binary(16) PRIMARY KEY,
    original_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size BIGINT UNSIGNED NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    PRIMARY KEY (file_id)
);
```
**Inserting data**
Below is the code for inserting an entry into the `File` table.
(DataJoint)
```python
File.insert1((uuid.uuid1(), 'document.pdf', '/uploads/doc.pdf', 1024000))
```

(Equivalent SQL)
```sql
INSERT INTO files (file_id, original_name, file_path, file_size)
VALUES (UUID_TO_BIN(UUID()), 'document.pdf', '/uploads/doc.pdf', 1024000);
```

```sql
-- MySQL
-- Using UUID1 for sortable file IDs
INSERT INTO files (file_id, original_name, file_path, file_size)
VALUES (UUID_TO_BIN('6ba7b810-9dad-11d1-80b4-00c04fd430c8'), 'document.pdf', '/uploads/doc.pdf', 1024000);
```

### Choosing the Right UUID Type

| UUID Type | When to Use | Advantages | Disadvantages |
|-----------|-------------|------------|--------------|
| **UUID1** | Need chronological ordering | Sortable, traceable | Contains system info |
| **UUID4** | Need random identifiers | Anonymous, simple | Not sortable |
| **UUID3/5** | Need deterministic IDs | Reproducible, hierarchical | Requires namespace management |

### Database Support for UUIDs

Different databases handle UUIDs differently:

- **PostgreSQL**: Native UUID type
- **MySQL**: CHAR(36) or BINARY(16)
- **SQLite**: TEXT or BLOB
- **SQL Server**: UNIQUEIDENTIFIER type

(DataJoint)
```python
@schema
class User(dj.Manual):
    definition = """
    user_id : uuid
    ---
    username : varchar(50)
    """
```

(Equivalent SQL)
```sql
-- MySQL
CREATE TABLE user (
    user_id BINARY(16),
    username VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id)
);

-- PostgreSQL
CREATE TABLE user (
    user_id UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) NOT NULL
);
```


# Practical Examples of Ensuring Entity Integrity

Consider the importance and challenges of entity integrity in the following scenarios. Each organization must implement specific processes to establish and verify unique identification.

## University Students

**Entity Type**: Individual students  
**Primary Key**: Student ID number  
**Identification Process**:
- Assigned unique ID during first enrollment
- Cross-referenced with government ID (driver's license, passport)
- Photo ID verification for campus access
- Regular verification against enrollment records

**Database Design**:
```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    ssn CHAR(11) UNIQUE,  -- Secondary unique index
    email VARCHAR(100) UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    enrollment_date DATE NOT NULL
);
```

**Challenges**: Students may change names (marriage), addresses, or contact information. The student ID remains constant.

## Daycare Center Children

**Entity Type**: Individual children  
**Primary Key**: Child ID number  
**Identification Process**:
- Unique ID assigned at registration
- Parent/guardian verification required
- Photo documentation for pickup authorization
- Emergency contact verification

**Database Design**:
```sql
CREATE TABLE child (
    child_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    parent_guardian_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    photo_path VARCHAR(255),
    UNIQUE INDEX (first_name, last_name, birth_date)
);
```

**Challenges**: Children grow and change appearance. Parents may divorce or change custody arrangements.

## Airline Bookings

**Entity Type**: Individual passengers  
**Primary Key**: Booking reference number  
**Identification Process**:
- Government-issued photo ID verification
- Biometric checks at security
- Cross-reference with government watch lists
- Real-time verification against booking system

**Database Design**:
(DataJoint)
```python
@schema
class Booking(dj.Manual):
    definition = """
    booking_ref : char(6)
    ---
    -> Passenger
    -> [unique] FlightSeat
    """
```
(Equivalent SQL)
```sql
CREATE TABLE booking (
    booking_ref CHAR(6) PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_number VARCHAR(6) NOT NULL,
    flight_date DATE NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    PRIMARY KEY (booking_ref),
    FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id),
    FOREIGN KEY (flight_number, flight_date, seat_number) REFERENCES flight_seat(flight_number, flight_date, seat_number)
    UNIQUE INDEX (flight_number, flight_date, seat_number));
```

**Challenges**: Passengers may have multiple forms of ID, name changes, or international travel requirements.

## Gym Members

**Entity Type**: Membership accounts  
**Primary Key**: Membership ID  
**Identification Process**:
- Photo ID verification at signup
- Photo stored for access control
- Payment method verification
- Regular membership renewal

**Database Design**:
(DataJoint)
```python
@schema
class Membership(dj.Manual):
    definition = """
    member_id : int
    ---
    member_name : varchar(100)
    phone : varchar(20)
    email : varchar(100)
    start_date : date
    end_date : date
    photo_path : varchar(255)
    """
```
(Equivalent SQL)
```sql
CREATE TABLE membership (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    photo_path VARCHAR(255),
    PRIMARY KEY (member_id)
    UNIQUE INDEX (phone),
    UNIQUE INDEX (email),
);
```
**Challenges**: Members may share memberships (family plans), change contact information, or cancel/reactivate memberships.

## Online Video Game Players

**Entity Type**: Player accounts  
**Primary Key**: Player ID (UUID)  
**Identification Process**:
- Email verification for account creation
- Username uniqueness check
- Optional phone number verification
- Anti-cheat system monitoring

**Database Design**:
(DataJoint)
```python
@schema 
class Player(dj.Manual):
    definition = """
    player_id : uuid
    ---
    username : varchar(30)
    email = null : varchar(100)
    phone = null : varchar(20)
    registration_date : date
    account_status : enum('active', 'suspended', 'banned')
    last_login : timestamp
    account_status = "active" : enum('active', 'suspended', 'banned') DEFAULT 'active'
    UNIQUE INDEX (username)
    UNIQUE INDEX (email)
    UNIQUE INDEX (phone)
    """
```

(Equivalent SQL)
```sql
CREATE TABLE players (
    player_id BINARY(16) PRIMARY KEY,  -- UUID
    username VARCHAR(30) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    registration_date DATE NOT NULL,
    account_status ENUM('active', 'suspended', 'banned') DEFAULT 'active',
    UNIQUE INDEX (username),
    UNIQUE INDEX (email),
    UNIQUE INDEX (phone),
    PRIMARY KEY (player_id)
);
```

**Challenges**: Players may create multiple accounts, share accounts, or use different devices.

## Social Media Posts

**Entity Type**: Individual posts  
**Primary Key**: Post ID (UUID)  
**Identification Process**:
- Automatic UUID generation
- User authentication verification
- Content moderation checks
- Timestamp recording

**Database Design**:
(DataJoint)
```python
@schema
class Post(dj.Manual):
    definition = """
    post_id : uuid
    ---
    -> User
    content : varchar(1024)
    created_at = CURRENT_TIMESTAMP : timestamp
    updated_at = CURRENT_TIMESTAMP : timestamp
    visibility : enum('public', 'friends', 'private')
    """
```
(Equivalent SQL)
```sql
CREATE TABLE post (
    post_id BINARY(16) PRIMARY KEY,  -- UUID4
    user_id INT NOT NULL,
    content varchar(1024) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    visibility ENUM('public', 'friends', 'private') DEFAULT 'public',
    PRIMARY KEY (post_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);
```

**Challenges**: Posts may be edited, deleted, or shared across platforms.

## Mortgage Loans

**Entity Type**: Individual loan accounts  
**Primary Key**: Loan number  
**Identification Process**:
- Borrower identity verification
- Credit check and income verification
- Property appraisal and title search
- Legal documentation review

**Database Design**:
DataJoint
```python
@schema
class Loan(dj.Manual):
    definition = """
    loan_number : varchar(20)
    ---
    -> Borrower
    property_address : varchar(255)
    loan_amount : decimal(15,2)
    interest_rate : decimal(5,4)
    term_months : int
    origination_date : date
    maturity_date : date
    """
```

Equivalent SQL:
```sql
CREATE TABLE loan (
    loan_number VARCHAR(20) PRIMARY KEY,
    borrower_ssn CHAR(11) NOT NULL,
    property_address varchar(255) NOT NULL,
    loan_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,4) NOT NULL,
    term_months INT NOT NULL,
    origination_date DATE NOT NULL,
    maturity_date DATE NOT NULL,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (borrower_ssn) REFERENCES borrower(borrower_ssn));
```


**Challenges**: Borrowers may refinance, modify loans, or transfer property ownership.

## Key Takeaways

Each scenario demonstrates different levels of entity integrity requirements:

1. **Strict Integrity** (Airlines, Banks): Government-level verification required
2. **Moderate Integrity** (Universities, Daycare): Photo ID and documentation verification
3. **Flexible Integrity** (Gyms, Games): Basic verification with some tolerance for sharing
4. **Digital-Only Integrity** (Social Media): Automated systems with minimal real-world verification

The choice of primary key and identification process depends on:
- **Business requirements**
- **Legal/regulatory constraints**
- **Security needs**
- **User experience considerations**
- **Cost of verification processes**

# Summary

The **primary key** is the foundation of relational database design, ensuring **entity integrity**—the guarantee of a one-to-one correspondence between real-world entities and their digital representations in the database.

## Key Concepts Covered

1. **Primary Key Definition**: A column or combination of columns that uniquely identifies each row in a table
2. **Entity Integrity**: The principle that each real-world entity must be represented by exactly one unique record
3. **Natural Keys**: Identifiers that exist in the real world (SSN, phone numbers, email addresses)
4. **Surrogate Keys**: Database-generated identifiers with no real-world meaning (auto-increment, UUIDs)
5. **Composite Primary Keys**: Multi-column primary keys for complex identification scenarios
6. **UUIDs**: Universally Unique Identifiers with different types (UUID1, UUID3, UUID4, UUID5) for various use cases
7. **Normalization Principle**: Each table should represent one distinct entity class
8. **Business Context**: Different organizations require different levels of entity integrity based on their needs

## Design Principles

- **Choose appropriate primary keys** based on business requirements and identification processes
- **Separate different entity types** into different tables following normalization principles
- **Use secondary unique indexes** to enforce additional uniqueness constraints
- **Consider the trade-offs** between natural keys and surrogate keys
- **Implement appropriate verification processes** to maintain entity integrity in the real world

By implementing these principles, you can create robust databases that faithfully mirror the real-world entities and relationships they are intended to manage, supporting reliable and accurate data management across various business contexts.
