# Database normalization 

**Database normalization** is a set of principles for designing databases with clarity and logical rigor. 
Normalized designs communicate the mapping between real-world entities and their representations in database design. 

The term database normalization derives from relational database theory: 
It applies to a data model where all data are represented as collections of related tables. 
It may not apply equally to other data models.

```{note}
In a normalized design, each row of a given table describes a distinct entity, and no two rows in that table represent different types of entities.
```

The table name (and its documentation) must clearly indicate what entity type is represented by the table's rows. We follow the convention whereby the table name must describe in singular form what each row represents. Thus a table describing database users might be named `User`.
Each table must have a primary key: the attributes that uniquely identify each entity in the table and in the real world. 
Besides the primary key, each table may have secondary attributes. The secondary attributes must directly describe the entities of the table's class. In fully-normalized designs, the secondary attributes apply to each entity.

## Example of unnormalized designs
SQL does not enforce normalization and most database tutorials are full of unnormalized designs. For example, SQL allows defining tables with no primary key, which allows storing duplicate entries. DataJoint table definition syntax presumes the existence of a primary key: one must only indicate the separation between the primary attributes comprising the primary key and the secondary attributes. 
Leaving SQL behind, I will show a few unnormalized designs using DataJoint table definition notation and then normalize the design. 
For example, consider a table for representing items in a shopping cart for an e-commerce site.

```
:: ShoppingCart
order_number : int
item : int
---
purchase_date : date
buyer_full_name : varchar(16)
buyer_address : varchar(1000)
buyer_email : varchar(120)
item_description : varchar(1000)
item_price : numeric(8, 2)
item_quantity : int
total_amount : numeric(8, 2)
```

Here, the first line starting with :: specifies the table name. 
Subsequent lines describe the table columns (entity attributes) with the colon : separating the attribute name from its data type. 
The dashes --- separate the attributes in the primary key from the secondary attributes below.
Such designs are typical for DataJoint newbies.
What is wrong with this design? 
The typical novice mistake is to put too much information in the same table, mixing information about different entities in the same table. This table contains information describing multiple entities: orders, items, and buyers, all in one. 
How would you fix this design?

## Fixing it
Database normalization requires splitting unnormalized tables into multiple tables where each table describes its separate entity type. We separate the representations of the order, items, and items in the order. We will also establish dependencies between them.
Then we describe items that might be included in different orders. We will assume that the item price is specific for each order and will omit it from the item table. Then the only secondary field is `item_description`. 

```
::Item 
item : int
---
item_description : varchar(1000)
```

Then let's represent the general information about the order, not pertaining to each item:
```
::Order
order_number : int
---
purchase_date : date
buyer_full_name : varchar(16)
buyer_address : varchar(1000)
buyer_email : varchar(120)
total_amount : numeric(8, 2)
```

Finally, we specify the items in the order in a separate table, OrderItem . This table associates each item, its price and quantity, to the order.

```
::OrderItem
-> Order
-> Item
---
item_quantity : int
item_price : numeric(8, 2)
item_quantity : int
```

Note the use of dependencies -> Order and -> Item . Dependencies include the primary attributes of the referenced tables in the new table. Without them, we would need to replicate 

```
::OrderItem
order_number : int     # use dependency instead
item : int             # use dependency instead
---
item_quantity : int
item_price : numeric(8, 2)
item_quantity : int
```

We can now plot the schema diagram:

## Is the normalized design better?

## Relationship to the classical normal forms 
