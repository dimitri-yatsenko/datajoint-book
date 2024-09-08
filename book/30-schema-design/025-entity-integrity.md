# Entity Integrity

As databases must represent an accurate mapping between real-world entities and their digital representations for accurately representing data and its transformations, the first essential aspect of data integrity is *entity integrity*.

```{card}
**Entity integrity** is the gurantee of a 1:1 correspondence between real-world entities and their digital representations.

Each real-world entity must be represented by exactly one unique record in the database; conversely, each record must correspond to a single, distinct real-world entity.
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
* [Radio-frequency Identification for Animals](https://en.wikipedia.org/wiki/ISO_11784_and_ISO_11785) for implanted microchips in animals.
* [US Aircraft Registration numbers](https://www.faa.gov/licenses_certificates/aircraft_certification/aircraft_registry/forming_nnumber), the N-numbers seen on the tails, regulated by the FAA. 

These examples demonstrate that establishing a rigorous system for identification may require costly standardization efforts with many systems for enforcement and coordination.

When a science lab sets out to establish a data management process for its experiment, the first step is to establish a uniform system for identifying test subjects, experiments, protocols, and treatments.
Standard nomenclatures are established to standardize names across all institutions and labs must be aware of them and follow them.

# Entity Integrity in Schema Design

Several key aspects of relational database design contribute to maintaining entity integrity:

1. **Clear Table Definitions Reflecting Entity Types**

Each table in a relational database should clearly indicate the type of real-world entity it represents.
The table name plays a crucial role in conveying this information.
For instance, if a table is named `Person`, the database must enforce entity integrity for individuals, ensuring each record corresponds to a unique person.

However, if the table uses identifiers that do not ensure a 1:1 mapping to actual persons—such as cell phone numbers, which might be shared or changed—a more appropriate table name should be chosen, like `UserAccount`, to reflect the specific entity type being represented.
This clarity helps avoid confusion and ensures that the database design accurately mirrors the real-world relationships it models.

2. **Establish identification tracking**
For all entities track by the database, select a way to identify entities and track their identity overtime. 

3. **Choose Primary Keys and Unique Indexes**

Every table in a relational database must have a **primary key**, and the attributes of the primary key cannot be nullable. This requirement is essential for maintaining **entity integrity**, as it prevents the creation of records that cannot be uniquely identified.

In addition to the primary key, a table may have **secondary unique indexes** to help enforce a one-to-one correspondence between records and the real-world entities they represent. These unique indexes can be applied to other attributes that need to be unique across the table but are allowed to be nullable.

For example, in a `Person` table, unique indexes might be enforced on attributes like **email addresses**, **usernames**, **driver’s licenses**, **cellphone numbers**, or **Social Security numbers**. These indexes ensure that no duplicate entries exist for attributes that are intended to be unique, further supporting entity integrity.

## Looser Entity Integrity

Depending on the business needs, **entity integrity** requirements can vary. Some businesses may allow multiple digital identities per person, while others may tolerate multiple people sharing a single digital identity. Other businesses may require a strict one-to-one match between real-world entities and their digital representations.

- **Example 1: Gym Memberships**  
  A gym may enforce that no two people use the same membership (ensuring uniqueness per membership). However, they may not need to prevent an individual from opening multiple memberships, leading to looser enforcement of entity integrity.

- **Example 2: Grocery Store Discount Cards (2010s)**  
  An example of looser but sufficient entity integrity was the use of **grocery store discount cards** in the 2010s. Grocery stores issued discount cards to shoppers to qualify them for discounts, but they did not strictly enforce a one-to-one mapping between cards and individual shoppers. Instead, they gathered enough information to track general shopping habits while allowing for multiple people to use the same card or for individuals to use multiple cards.

This flexibility in entity integrity allows businesses to balance strict data rules with practical needs for customer management and data collection.


## Using Natural Keys

A table can be designed with a **natural primary key**, which is an identifier that exists in the real world. For example, a Social Security Number (SSN) can serve as a natural key for a person because it is a unique number used and recognized in real-world systems.

In some cases, a natural key already exists, or one can be specifically created for data management purposes and then introduced into the real world to be permanently associated with physical entities.

For instance, grocery and hardware stores use **SKU (Stock Keeping Unit)** numbers to track inventory. Each item is assigned an SKU, and store clerks can look it up for specific products.

Other common examples of natural keys include **phone numbers** and **email addresses**, which are often used as unique identifiers in phone apps and online services.

Phone numbers, in particular, have become popular as identifiers as mobile phones have evolved from being associated with homes or offices to being personal devices carried by individuals.

# Using Surrogate Keys

In many cases, it makes more sense to use a **surrogate key** as the primary key in a database. A surrogate key has no relationship to the real world and is used solely within the database for identification purposes. These keys are often generated automatically as an **auto-incrementing number** or a **random string** like a UUID (Universally Unique Identifier) or GUID (Globally Unique Identifier).

When using surrogate keys, entity integrity can still be maintained by using other unique attributes (such as secondary unique indexes) to help identify and match entities to their digital representations.

Surrogate keys are especially useful for entities that exist only in digital form (e.g., social media posts, email messages) and don’t need to be uniquely identified outside of the digital system. In these cases, surrogate keys are an appropriate and efficient choice.


# Practical Examples of Ensuring Entity Integrity
Consider the importance and challenges of entity integrity in the following scenarios.
Think what processes each organization needs to implement to establish and verify unique identification.
What unique indexes does the database need to enforce?

- **Students at a University:** Each student is uniquely identified by a student ID number assigned during enrollment, ensuring entity integrity by preventing duplicate student records
- **Kids at a Daycare Center:** A unique enrollment number or child ID can be assigned upon registration, ensuring consistent and unique representation of each child.
- **Airline Passengers:** Passengers can be uniquely identified by a booking reference number or frequent flyer number, ensuring accurate linkage of travel details to individual records.
- **Gym Members:** A unique membership ID assigned at joining ensures that each member’s activities are accurately recorded without duplication.
- **Online Video Game Players:** Each player is assigned a unique gamer tag or player ID, ensuring consistent and unique tracking of player interactions and achievements.
- **Posts on Facebook:** Each post is associated with a unique post ID, linking the content to the specific user and ensuring that each post is uniquely identified.
- **Mortgage Loans:** Each mortgage loan is identified by a unique loan number or mortgage ID, ensuring that all related transactions and documents are consistently linked.

# Summary
Entity integrity is a critical aspect of relational database design that ensures the accurate and consistent representation of real-world entities within a database. 
By implementing clear table definitions, enforcing primary keys and unique indexes, and ensuring mandatory primary keys, you can create robust databases that faithfully mirror the real-world entities and relationships they are intended to manage. 
This foundation of entity integrity supports reliable and accurate data management, enabling databases to function effectively in representing and maintaining the integrity of the data they store.