
# Portfolio 5: Distributed and Cloud Database Exercise

## 1. Objective

This practical demonstrates distributed database concepts using
MongoDB replica sets running in Docker containers. The case study
is Jacobian HarvestHub Limited, an agricultural e-commerce and
distribution platform.

The objectives are to configure a multi-node replica set, verify
data replication, observe primary election after node failure, and
explain the relationship between replication, availability, and
consistency.

## 2. Environment

- Operating system: Windows
- Container platform: Docker Desktop
- Database: MongoDB 8.0 container image
- Replica set name: rs0
- Number of database nodes: 3
- Container network: harvesthub-net
- Demo database: harvesthub_distributed_demo
- Test collection: replication_test

## 3. Architecture

Three MongoDB instances run as separate Docker containers on a
dedicated bridge network.

- mongo1: initially configured as primary
- mongo2: secondary, later elected primary during the failure test
- mongo3: secondary

The containers use separate named volumes for persistent database
storage. MongoDB replication copies data between replica-set
members.

## 4. Implementation

The Docker Compose configuration starts three MongoDB instances
with replica-set support enabled. The replica set was initialised
with the name rs0 and the members mongo1:27017, mongo2:27017,
and mongo3:27017.

The initial status check showed mongo1 as PRIMARY and mongo2 and
mongo3 as SECONDARY.

A test document representing Organic Maize was inserted into the
replication_test collection on the primary. The document contained
the product name, category, price, quantity available, and creation
timestamp.

The document was then queried from both secondary nodes. Both
queries returned the same document and identifier as the primary
insert.

## 5. Failure and Recovery Test

The original primary was stopped using Docker. The replica-set
status subsequently showed mongo2 as PRIMARY and mongo3 as
SECONDARY, while mongo1 was reported as not reachable/healthy.

The original mongo1 container was restarted. The subsequent
status check showed mongo1 as SECONDARY, mongo2 as PRIMARY, and
mongo3 as SECONDARY.

This demonstrates primary election and node recovery in the
configured local replica set.

## 6. Evidence

Screenshots are stored in the evidence directory. They should
include the initial replica-set status, successful primary insert,
secondary reads, failover result, and recovery status.

## 7. Limitations

This was a local Docker demonstration, not a production cloud
deployment. The practical did not implement sharding, geographic
replication, production authentication, replica-set keyfile
security, or a managed cloud database service.

The results demonstrate the behaviour observed during this test;
they do not establish availability guarantees under every possible
failure condition.
