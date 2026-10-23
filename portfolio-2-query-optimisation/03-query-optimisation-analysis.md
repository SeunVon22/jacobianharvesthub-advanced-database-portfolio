# Query Processing and Optimisation Analysis

## Objective

The objective was to examine PostgreSQL's execution plan for a customer-order lookup and evaluate whether an index on `customer_order.customer_id` changed the query plan.

## Baseline execution plan

Before adding the custom index, PostgreSQL used:
- An index scan on `customer` using the unique email index.
- An index scan on `customer` using the primary-key index.
- A sequential scan on `customer_order`.
- A nested-loop join.

The measured execution time was 0.114 ms, with one row returned.

## Indexing experiment

The following index was created:

```sql
CREATE INDEX idx_customer_order_customer_id
ON customer_order (customer_id);
```

After creating the index, the query was executed again using `EXPLAIN ANALYZE`.

PostgreSQL continued to use a sequential scan on `customer_order`. The measured execution time was 0.097 ms, with one row returned.

## Interpretation

The execution time decreased by 0.017 ms in the second run, but this difference is too small to establish a reliable performance improvement. The query plan did not change the access method used for `customer_order`.

The table contains only three orders, so a sequential scan is reasonable. For a larger table, an index on `customer_order.customer_id` may become beneficial when queries frequently retrieve orders belonging to a particular customer.

## Conclusion

This experiment demonstrates that indexes should be evaluated against actual query workloads. An index can provide a useful access path, but PostgreSQL's query planner decides whether to use it. Performance conclusions should be based on repeatable measurements and execution-plan evidence rather than a single timing result.
