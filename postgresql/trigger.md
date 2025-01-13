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

- First, Create a trigger function using `CREATE FUNCION`.
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

```sql
-- DEPARTMENT TABLE
CREATE TABLE DEPARTMENT(
 dep_id SERIAL PRIMARY KEY,
 name VARCHAR(100) NOT NULL check(name <> ''),
 created_at TIMESTAMP not null default CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION check_name()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
	IF LENGTH(NEW.NAME) < 2 THEN
		RAISE EXCEPTION 'name must be 2 character long';
	END IF;

	RETURN NEW;
END;
$$;
CREATE TRIGGER department_check_name_trigger
BEFORE INSERT OR UPDATE
ON department
FOR EACH ROW
EXECUTE PROCEDURE check_name();

CREATE TABLE EMPLOYEES(
emp_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
dep_id INTEGER REFERENCES department (dep_id) ON DELETE CASCADE,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER employees_name_check_trigger
BEFORE INSERT OR UPDATE
on EMPLOYEES
FOR EACH ROW
EXECUTE PROCEDURE check_name();

-- view
CREATE VIEW department_employees
AS
	SELECT d.name as dep_name, e.name
	FROM department d
	JOIN employees e ON e.dep_id=d.dep_id;

CREATE OR REPLACE FUNCTION department_employees_fun()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
	DECLARE
		d_id int;

	BEGIN
		RAISE NOTICE 'perform % operation on department_employees view', TG_OP;
		RAISE NOTICE 'trigger name: %',TG_NAME;
		RAISE NOTICE 'trigger time: %',TG_WHEN;
		RAISE NOTICE 'trigger perform on: % table',TG_TABLE_NAME;

		IF TG_OP = 'INSERT' THEN

		    if NEW.dep_name ~* '^[a-z]{1}' then
				INSERT INTO department(name) VALUES(NEW.dep_name)
				RETURNING dep_id into d_id;
			ELSE
				SELECT NEW.dep_name into d_id;
			end if;

			INSERT INTO EMPLOYEES(name,dep_id)
			VALUES(NEW.name,d_id);

			RETURN NEW;
		ELSIF TG_OP = 'UPDATE' THEN
			RETURN NEW;
		ELSIF TG_OP = 'DELETE' THEN
			RETURN OLD;
		END IF;
	END;
$$;

CREATE TRIGGER department_employees_fun_trigger
INSTEAD OF INSERT OR UPDATE OR DELETE
ON department_employees
FOR EACH ROW
EXECUTE PROCEDURE department_employees_fun();

DROP TRIGGER department_employees_fun_trigger ON EMPLOYEES;

INSERT INTO department_employees(name,dep_name) values('Deepak kumar',4);

select * from department;
```
