# Stored procedure

**Stored procedures** are **pre-compiled SQL statements** that reside on the database server.

A drawback of **user-defined function** that they can not execute **transactions**.

In other words, inside a `user-defind function` you can not `start` a `transaction`, and `commit` or `rollback` it.

`PostgreSQL11` introduced stored `procedures` that support `transactions`.

To define a new stored procedure you can use `CREATE OR REPLACE PROCEDURE` statement.

**`Purpose:`**

- `Efficency:` Execute complex operations faster by avoiding repeated parsing and compilation.
- `Modularity:` Encapsulate business logic, making code more organized and reusable.
- `Security:` Control access to data by granting permissions to specific stored procedures instead of individual tables.
- `Data integrity:` Ensure data consistency by enforcing business rules within the procedure.

```sql

-- list all procedure
\df -- psql

-- select statements
select routine_schema, routine_name
FROM information_schema.routine
WHERE routine_type='PROCEDURE';

-- syntax
CREATE OR REPLACE PROCEDURE procedure_name(param_list)
language plpgsql
AS $$
    DECLARE
        -- VARIABLES NAME
    BEGIN
        -- STORED PROCEDURE BODY
    END;
$$;

-- A procedure can accept 0 or more parameters.
-- you can use other procedural language for the stored procedure, such as SQL,C etc.
-- Prameter can have only 'in' and 'inout' more.
-- A stored procedure does not return value, you can not use [return expresson], but you can use only [return] to stop procedure
-- If you want to return value from procedure you can use parameter with [inout] mode.
```

```sql
-- example
 CREATE OR REPLACE PROCEDURE transfer_balance(
    sender int,
    receiver int,
    amount decimal
 )
 LANGUAGE plpgsql
 AS $$
 DECLARE
    -- declare variables here;

 BEGIN
    -- Transfer amount from sender to receiver acount.
    UPDATE account
    SET balance = balance - amount
    WHERE id=sender;

    -- SAVEPOINT saving_transaction;

    UPDATE account
    SET balance=balance + amount
    WHERE id=receiver;

    -- commit (once commint can not rollback)
    commit;
 END;
 $$;
```

`To call stored procedure:`

You can use `CALL` statement to call procuder.

```sql
-- syntax
call procedure_name(argument_list);

-- example
call transfer_balance(
    1,2,5000.00
)
```

## Drop procedure

`DROP PROCEDURE` statement deletes one or more stored procedure from a database.

```sql
-- syntax
drop procedure [if exists] procedure_name (argument_list)
[cascade | restrict]


```
