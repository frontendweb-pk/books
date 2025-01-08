# Trigger

A trigger is a database object that automatically executes a function in response to an event such as
**INSERT, UPDATE,DELETE** OR **TRUNCATE**.

A trigger is a special `used-defined` function associated with a table.

To create a new trigger, you define a trigger function first and then bind the trigger function to a table.

The difference between a trigger and user-defined function that a trigger autometically invoke when a trigger event occurs.

`Types:`

PostgreSQL provide two types of trigger:

- Row-level triggers
- Statement-level triggers.

The difference between the two kinds are how many times the trigger is invoked and at what time.

`Example:`

If you isssue an `UPDATE` statement that modifies `20` rows, the row-level trigger invoked `20 times`, while the statement-level trigger will be invoked `1 time`.

You can specify whether the trigger is invoked before or after an event.

**List all triggers:**

```sql
SELECT * FROM pg_trigger;
-- OR
SELECT
    event_object_table AS table_name,
    trigger_name
FROM
    information_schema.triggers
GROUP BY
    table_name, trigger_name
ORDER BY
    table_name, trigger_name;
```

**`How to create trigger:`**

To create a new trigger.

- First, Create a trigger function using `CREATE TRIGGER`.
- Second, Bind the trigger to a table by using `CREATE TRIGGER`.

```sql
-- syntax
CREATE FUNCTION
```

**List of TG\_ Variables in PostgreSQL Trigger Functions:**

- `TG_NAME:` Name of the trigger that fired.

- `TG_WHEN:` Timing of the trigger: 'BEFORE', 'AFTER', or 'INSTEAD OF'.

- `TG_LEVEL:` Level at which the trigger fires: 'ROW' or 'STATEMENT'.

- `TG_OP:` Operation that triggered the function: 'INSERT', 'UPDATE', 'DELETE', or 'TRUNCATE'.

- `TG_RELID:` Object ID of the table that caused the trigger invocation.

- `TG_RELNAME:` Table name that caused the trigger invocation.

- `TG_TABLE_NAME:` Table name that caused the trigger invocation.

- `TG_TABLE_SCHEMA:` Schema of the table that caused the trigger invocation.

- `TG_NARGS:` Number of arguments given to the trigger function in the `CREATE TRIGGER` statement.

- `TG_ARGV:` Array of arguments from the `CREATE TRIGGER` statement.

These variables provide essential information within the trigger function's execution context, allowing you to perform actions based on the specific event and its details.
