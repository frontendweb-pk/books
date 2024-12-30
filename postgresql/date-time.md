# PostgreSQL Date time

PostgreSQL offers the sevaral data type to handle date.

`DATE:`

This data type allow you to store date data. it uses `4 bytes` to store data value. the `lowest` and `highest` value of the `DATE` data type are `4713 BC` and `5874897 AD`, respectively.

When storing a date value, PostgreSQL uses the `yyyy-mm-dd` format. It also uses the same format for `inserting data` into a `DATE` column.

```sql
    -- example
    CREATE TABLE users(
        user_id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        dob DATE NOT NULL,
        insert_at DATE NOT NULL DEFAULT CURRENT_DATE
    );
    -- CURRENT_DATE as the default value of the column using a DEFAULT constraint.
```

**`Important function:`**

```sql
-- Get the current date and time
SELECT NOW();

-- use :: cast operator to extract date and time
-- Get the date part only
SELECT NOW()::date;

-- Get the time part only
SELECT NOW()::time;


-- A quick way to get the current date to use CURRENT_DATE function:
SELECT CURRENT_DATE;

-- Change format using TO_CHAR(date,format) function
SELECT TO_CHAR(NOW()::date, 'dd/mm/yyyy');
```

`TIME:`
`INTERVAL:`
`TIMESTAMP:`
