# Entity Integrity
**Entity integrity** is the gurantee provided by the database of a 1:1 correspondence between real-world entities and their digital representations.
As such, it is a prerequite for all other aspects of data integrity.

For entity integrity, each real-world entity must be represented by exactly one unique record in the database; conversely, each record must correspond to a single, distinct real-world entity.

Imagine what kinds of difficulties would arise if entity integrity broke down in the systems you interact with every day.
For example, what would happen if your university or HR department had two different identifies for you in their records?
What would happen if they occasionally updated your records with another person's information?  
What if the same ocurred in your dentist's office?

Without entity integrity, it is impossible to maintain other aspects of integrity within the database.
For example, a foreign key relationship assumes that every referenced entity exists uniquely and correctly in the database—an assumption that can only hold true if entity integrity is enforced.

# Challenges to Entity Integrity
The challenge of ensuring entity integrity lies in the fact that it cannot be fully solved by the database system alone.
A reliable system for identifying objects in the real world must be established outside the database to ensure that each entity has a unique and persistent identifier that can be consistently used across all related data records by all participants.

This requires setting up a disciplined process outside the database.

For example, establishing the Social Security system in the United States required a reliable identification of workers by all employers to report their income across their entire careers.
For this purpose, in 1936, the Federal Government established a new process to ensure that each US worker would be assigned a unique number, the Social Security Number (SSN).
The SSN would be assigned at birth or at entering the country for employment and no person would be allowed to have two such numbers. 
Establishing and enforcing such a system is not easy and takes a considerable effort.
The SSN allows for the accurate and consistent representation of individuals across various government databases, ensuring that each person is correctly identified. 

**Question**: Why didn't the US government need to assign unique identifiers to tax payers when it began levying federal taxes in 1913?

**Question**: What abuses would become possible if a person could obtain two SSNs or if two persons could share the same SSN?

**Learn more** about the history and uses of the SSN:
  * [History of establishing SSN.](https://www.ssa.gov/history/ssn/firstcard.html)
  * [How the SSN works.](https://www.ssa.gov/policy/docs/ssb/v69n2/v69n2p55.html)
  * [IRS timeline.](https://www.irs.gov/irs-history-timeline)

Similar rigor is required for identifying other objects in the real world:
* VIN for all vehicles
* Animal identification number for pets and domestic animals
* Registration numbers for aircraft

In summary, designing a database may need to begin with designing good identification processes in the enterprise that it supports.

When a neuroscience lab sets out to establish a data management process, the first thing it needs to do is to establish a uniform system to identify test subjects, experiments, and protocols.

# Entity Integrity in Schema Design

Several key aspects of relational database design contribute to maintaining entity integrity:

1. **Clear Table Definitions Reflecting Entity Types**

Each table in a relational database should clearly indicate the type of real-world entity it represents.
The table name plays a crucial role in conveying this information.
For instance, if a table is named `Person`, the database must enforce entity integrity for individuals, ensuring each record corresponds to a unique person.

However, if the table uses identifiers that do not ensure a 1:1 mapping to actual persons—such as cell phone numbers, which might be shared or changed—a more appropriate table name should be chosen, like `UserAccount`, to reflect the specific entity type being represented.
This clarity helps avoid confusion and ensures that the database design accurately mirrors the real-world relationships it models.

2. **Primary Keys and Unique Indexes**

Every table in a relational database must have a primary key, and the primary key attributes cannot be nullable. This requirement is crucial for maintaining entity integrity, as it prevents the creation of records that cannot be uniquely identified.
The table may haveother unique indexes that enforce a 1:1 correspondence between records and the real-world entities they represent.
Secondary unique indexes can enforce uniqueness on other attributes that need to be unique across the table but may be nullable.
For example, for the `Person` table, unique indexes can be enforced on email addresses, usernames, drivers licenses, cellphone numebrs, or social security numbers.
These indexes ensure no duplicate entries for attributes intended to be unique, further supporting entity integrity.

Depending on the business needs, entity integrity may be loosened.
One business may tolerate multiple digital identities per person while another may allow multiple persons sharing a digital identities. 
Other business would require strict 1:1 match.
These requirements would lead to different approaches to managing identities and enforcing entity integrity.

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
