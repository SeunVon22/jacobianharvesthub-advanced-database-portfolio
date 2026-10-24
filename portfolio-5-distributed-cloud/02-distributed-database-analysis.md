
# Distributed Database Analysis: Jacobian HarvestHub Limited

## 1. Introduction

Jacobian HarvestHub Limited operates an agricultural marketplace
that connects suppliers and customers. As the platform grows, its
database must support reliable product access, order processing,
inventory updates, and business continuity.

A distributed database design can improve resilience and support
growth by distributing database responsibilities across multiple
nodes. However, distribution introduces additional complexity in
data consistency, network communication, operations, and security.

## 2. Replication

Replication maintains copies of data across multiple database
nodes. In the practical exercise, a MongoDB replica set was
configured with three members: one primary and two secondaries.

The primary accepted the test write, and the Organic Maize
document was subsequently retrieved from both secondary members.
When the original primary was stopped, another member was elected
primary. After the original node was restarted, it rejoined as a
secondary.

For HarvestHub, replication can improve read availability and
provide additional copies of data. Replication is not a substitute
for backups, and it does not guarantee that every acknowledged
write will survive every possible failure. Write concern, journaling,
replication lag, and failure scenarios must be considered.

## 3. Sharding and Partitioning

Sharding divides a dataset across multiple database partitions
or shards. It can distribute storage and query workloads as the
platform grows.

A potential HarvestHub design could partition order records using
a carefully selected shard key. The key should distribute writes
and storage effectively while supporting common query patterns.

For example, a customer identifier combined with an appropriate
partitioning strategy could support customer-specific order
queries. A monotonically increasing key can create write hotspots
in some designs, so shard-key selection must be evaluated against
actual workloads.

Sharding was analysed conceptually in this portfolio; it was not
implemented in the three-node replica-set demonstration.
Replication and sharding solve different problems and may be
combined in a larger deployment.

## 4. Consistency and Availability

Consistency concerns whether reads observe data according to the
system's defined ordering and guarantees. Availability concerns
whether the system can continue responding to requests.

In MongoDB, read preference influences which replica-set members
serve reads. Reading from a secondary can return data that has
not yet caught up with the latest primary write. Write concern
affects the acknowledgement guarantees for writes.

HarvestHub must be especially careful with inventory updates.
Two customers must not both successfully purchase the last unit
because of concurrent requests or stale stock information.
Appropriate atomic updates, write concern, and application-level
transaction design are important.

## 5. Partition Tolerance and CAP

The CAP theorem describes trade-offs when a network partition
prevents nodes from communicating reliably. During a partition,
a distributed system must make design choices that affect
consistency and availability.

The CAP theorem should not be interpreted as meaning that every
database permanently chooses only two properties. Behaviour
depends on the failure scenario and the guarantees required by
specific operations.

For HarvestHub, inventory and payment workflows may require
stronger consistency guarantees than product catalogue reads,
where slightly stale information may sometimes be tolerable.

## 6. Cloud Deployment Considerations

A production deployment could use a managed database service or
a securely operated database cluster in a cloud environment.

The design should consider:

- Multiple availability zones where supported.
- Private networking and restricted database access.
- Authentication, least-privilege permissions, and encryption.
- Automated backups and tested restoration procedures.
- Monitoring, alerting, replication lag, and storage capacity.
- Disaster recovery objectives and recovery-time requirements.
- Network latency, cloud costs, and operational responsibilities.

The Docker implementation in this portfolio ran locally. No
managed cloud deployment was performed, so cloud deployment
remains a proposed design rather than a verified implementation.

## 7. Conclusion

The practical demonstrated a three-member MongoDB replica set,
successful replication of a test document, primary election after
the original primary was stopped, and recovery of the original
member.

The exercise illustrates how replication supports redundancy
and recovery while also highlighting the importance of voting
majority, consistency guarantees, security, and operational
testing. Sharding and cloud deployment remain future design
considerations for a growing HarvestHub platform.
