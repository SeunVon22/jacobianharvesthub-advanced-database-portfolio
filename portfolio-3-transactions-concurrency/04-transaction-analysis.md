# Portfolio 3: Transactions and Concurrency

## Case Study

This exercise uses Jacobian HarvestHub Limited, an agricultural e-commerce and distribution platform. Inventory consistency is important when multiple orders may involve the same product.

## 1. Commit Demonstration

A transaction reduced Fresh Tomatoes inventory from 100 to 98. The update was committed using `COMMIT`, and a subsequent query confirmed that the new quantity persisted.

**Result:** Successful commit; stock remained at 98.

## 2. Rollback Demonstration

A separate transaction temporarily reduced inventory from 98 to 93. The transaction was cancelled using `ROLLBACK`. A subsequent query confirmed that the stock returned to 98.

**Result:** The uncommitted update was undone.

## 3. Concurrency Control

The concurrency exercise uses PostgreSQL's `SELECT ... FOR UPDATE` to lock the Fresh Tomatoes inventory row. A second database session attempts to update the same row while the first transaction holds the lock.

The expected behaviour is that the second update waits until the first transaction commits or rolls back. This demonstrates how row-level locking coordinates concurrent modifications.

**Result:** Record the observed behaviour, session outputs, and final inventory quantity after completing the test.

## Conclusion

The exercises demonstrate transaction boundaries, persistence through commit, cancellation through rollback, and row-level locking for concurrent inventory access. These mechanisms help protect data consistency in database applications.
