# Transactions

Databases are not merely storage systems; they should accurately represent an enterprise's current state.
This means that all users, irrespective of their interactions, should view and engage with the same data simultaneously.
This principle is known as **data consistency**.

```{card} Data Consistency
**Data Consistency:** A database's capability to present a singular, valid, and current version of its data to all users, even during concurrent access and modifications.
Successful read queries should reflect the database's most recent state, while successful writes should immediately influence all subsequent read actions.
```
The underlying data may be distributed and true consistency may be deferred but the system

Understanding data consistency becomes clearer when examining its breaches.
For instance, during early morning hours, I've observed my bank's website displaying the previous day's pending transactions, but the account balance doesn't reflect these changes until a couple of hours later.
This discrepancy between transaction views and account balances exemplifies data inconsistency.
Fortunately, such inconsistencies, in this case, seem to be confined to the web interface, as the system eventually reaches a consistent state.

Ensuring data consistency is straightforward in certain scenarios.
By avoiding conditions that might compromise it, consistency is preserved.
For example, if only one party generates data and the rest merely access it, the likelihood of conflicts leading to inconsistency is minimal.
Delayed queries still provide a consistent, albeit older, state.
This is typical in scientific projects, where one lab produces data while others analyze it.

Complexities arise when multiple entities, be they human or digital, access and modify data simultaneously.
Maintaining consistency amidst such concurrent interactions becomes challenging.
To achieve this, databases might temporarily limit access for some users during another's transaction or force users to resolve discrepancies before data integration.

Modern relational databases adhere to the **ACID model** to maintain consistency:

```{card} ACID Model for Database Transactions
- **A**tomic
- **C**onsistent
- **I**solated
- **D**urable
```

Ensuring consistency becomes notably challenging in geographically dispersed systems with distributed data storage, especially when faced with slow or intermittent network connections.
Historically, it was believed that data systems spanning vast areas couldn't maintain consistency.
The **CAP Theorem** suggested that in such systems, there's an irreconcilable trade-off between system responsiveness (availability) and data consistency.

Traditional relational database systems, like Oracle, MySQL, and others, maintained strong consistency but weren't tailored for distributed setups. This limitation spurred the rise of **NoSQL** in the 2000s and 2010s, emphasizing responsiveness in distributed systems, albeit with weaker consistency.

However, recent advancements have bridged this gap. Modern distributed systems, like Spanner and CockroachDB, leverage data replication and consensus algorithms (e.g., Paxos, Raft) to offer high availability while maintaining strict consistency.

DataJoint adheres to the classic ACID consistency model, leveraging serializable transactions or the master-part relationship, detailed further in the "Transactions" section.
