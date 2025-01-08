# PL/pgSQL

PL/pgSQL is a procedural language that add many procedureal elements.

- control structure.
- loops.
- and complex computations.

to extend standard SQL.

It allows you to develop complex `functions` and stored `procedures` in PostgreSQL that may not be possible using pain SQL.

**Pros:**

- Easy to learn and simple to use.
- The user-defined function and stored procedure can be used like any built-in functions and stored procedure.
- Inherit all user-defined types,functions and operators.
- It has many features that allow you to create complex function and stored procedure.

**Designed to:**

- Create user-defined `functions`, stored `procedure` and `triggers`.
- Extend standard SQL by adding `control structure`, `loops`, `case` and `if-else`.

SQL is a query language helps to manage data in database. However, PostgreSQL only execute SQL statements individually.

**Dollar-Quoted String Constants ($$):**

It allows you to construct strings that contain single quotes without a need to escape them.

```sql
-- syntax
$tag$<string_constant>$tag$

-- examples

-- simple string
SELECT 'hello world';

-- you need to escape it by doubling up the single quote:
SELECT 'I''am a developer';

-- solve this adding $$ dollar quoted string
select $$i'am a developer$$;
```

**Annonymouse block:**

```sql
-- syntax
do
$$
 DECARE
    -- VARIABLES
 BEGIN
    -- BODY
 END;
$$;


-- example
do
$$
 declare
    x int=0;
 begin
    select COUNT(*) into x
    FROM actor;
    raise notice 'total actors are %',x;
 end;
$$

```

**Block structure:**

```sql
-- syntax

```

**User defined function:**

```sql
-- syntax
CREATE OR REPLACE FUNCTION function_name(param_list)
RETURNS data_type
LANGUAGE PLPGSQL
AS $$
    -- FUNCTION BODY
$$;
-- create user-defined function
CREATE OR REPLACE FUNCTION get_total_actors()
RETURNS INT
LANGUAGE PLPGSQL
AS $$
    DECLARE
        -- declare variable
         x int =0;
    BEGIN
        -- count total actor and add in x
        SELECT COUNT(*) INTO x
        FROM ACTOR;

        -- raise notice
        raise notice 'total actors %',x;

        -- return total actor
        RETURN x;
    END;
$$;
```
