# PostgreSQL views

A views is a named query stored in a `PostgreSQL database server`.

A view is defined based on `one` and `more` tables wich are known as `base table`, and the query that defines the view is referred to as a defining query.

After creating view you can query data from it as you would from a regular table.

`Behind the schenes:`

PostgreSQL will rewrite the query against the view and its defining qeury, executing it to retrieve data from the base tables.

- A view is a virtual table that doesn't store data (except materialized view).
- It is a saved SQL query that defines a result set.

`Advantage:`

- `Data abstraction:` Hide the complexity of underlying tables.
- `Data security:` Restrict access to specific rows and columns.
- `Data independence:` Changes to underlying tables don't always affect view definitions.
- `Query simplification:` Create compex queries as simple view.
- `Improved redability:` Make complex queries more understandable.

## Create views

The `CREATE VIEW` statement used to create a new view.

```sql
-- display the view info in psql
\d+ view_name;

-- syntax
CREATE VIEW view_name
AS
  query;


-- Create simple view
CREATE VIEW contact_view AS
SELECT first_name,  last_name,  email
FROM customer;

-- Create complex view
CREATE VIEW film_actor_category
AS
SELECT f.title as film, a.first_name || a.last_name as actor,
l.name, C.NAME as category FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id)
JOIN language as l  USING(language_id)
JOIN film_category USING(film_id)
JOIN CATEGORY C USING(category_id);

-- Create a view based on another view
CREATE VIEW animation_film
AS
SELECT *
FROM film_actor_category
WHERE category='Animation';
```

`Query from view:`

```sql
-- syntax
SELECT * FROM view_name;

-- example
SELECT * FROM film_actor_category;

SELECT * FROM animation_film;
```

`Replacing a view:`

To change the defining query of a view, you use the `CREATE OR REPLACE VIEW` statement.

```sql
-- syntax
CREATE OR REPLACE view_name
AS
    query;
```

If the view already exists, the statement replaces the existing view; otherwise, it creates a new view.

```sql
-- change the contact_view defining query
CREATE OR REPLACE VIEW contact_view AS
SELECT
  first_name,
  last_name,
  email,
  phone
FROM
  customer
INNER JOIN address USING (address_id);
```

## Drop view

The `DROP VIEW` statement allow you to remove view from the databse server.

```sql
-- syntax
DROP VIEW [IF EXISTS] view_name
[CASCADE | RESTRICT]
```

`Steps:`

- `First,` specify the view name which you want to remove.
- `Second,` use `if exists` to prevent an error if the view doesn't exist.
- `Third,` use `CASCADE` option to remove dependent object along with view or the `RESTRICT`
  option to reject the removal of the view.

`Droping multiple views:`

```sql
DROP VIEW IF EXISTS view1,view2, view3, ...
[CASCADE | RESTRICT];

-- To execute the DROP VIEW statement, you need to be the owner of the view or have a DROP privilege on it.
```

## Updatable view

A view can be updatable if it meets certain conditions. this means that you can `insert, update and delete` data from the underlying table via the view.

`Conditions:`

- `First,` The defining query of the view must have exactly one entry in the `FORM` clause,
  Which can be a table and another updatable view.

- `Second,` The defining query must not contain one of the following clauses at the top level.

  - GROUP BY
  - HAVING
  - LIMIT
  - OFFSET FETCH
  - DISTINCT
  - WITH
  - UNION
  - INTERSECT
  - EXCEPT

- `Third,` The section list of the defining query must not contain any:

  - Window functions
  - Set-returing function.
  - Aggregate functions.

An `updatable` view may contain both `updatable` and `non-updatable` columns. If you attempt to modify a `non-updatable` column, `PostgreSQL` will raise an `error`.

`Setting up a sample table:`

```sql
CREATE TABLE cities (
    id SERIAL PRIMARY KEY ,
    name VARCHAR(255),
    population INT,
    country VARCHAR(50)
);

INSERT INTO cities (name, population, country)
VALUES
    ('New York', 8419600, 'US'),
    ('Los Angeles', 3999759, 'US'),
    ('Chicago', 2716000, 'US'),
    ('Houston', 2323000, 'US'),
    ('London', 8982000, 'UK'),
    ('Manchester', 547627, 'UK'),
    ('Birmingham', 1141816, 'UK'),
    ('Glasgow', 633120, 'UK'),
    ('San Francisco', 884363, 'US'),
    ('Seattle', 744955, 'US'),
    ('Liverpool', 498042, 'UK'),
    ('Leeds', 789194, 'UK'),
    ('Austin', 978908, 'US'),
    ('Boston', 694583, 'US'),
    ('Manchester', 547627, 'UK'),
    ('Sheffield', 584853, 'UK'),
    ('Philadelphia', 1584138, 'US'),
    ('Phoenix', 1680992, 'US'),
    ('Bristol', 463377, 'UK'),
    ('Detroit', 673104, 'US');

SELECT * FROM cities;
```

`Create an updatable views:`

```sql
-- creat [city_us] view
CREATE VIEW city_us
AS
    SELECT *
    FROM cities
    WHERE country='US';

-- insert new row
INSERT INTO city_us(name,population,country)
VALUES ('San Jose', 983459, 'US');

-- check new entry available in both
SELECT * FROM CITIES;
SELECT * FROM city_us;


-- update data
UPDATE city_us
SET population = 1000000
WHERE name = 'New York';

-- delete data
DELETE FROM city_us
WHERE id = 21;
```

## WITH CHECK OPTION

A simple view can be `updatable`.

To ensure that any data modification made through a view adheres to certain conditions in the view's definition, you use the `WITH CHECK OPTION` clause.

Typically, you specify the `WITH CHECK OPTION` when creating a view using the `CREATE VIEW` statement:

```sql
-- syntax
CREATE VIEW view_name AS
query
WITH CHECK OPTION;
```

When you create a view `WITH CHECK OPTION`, PostgreSQL will ensure that you can only modify data of the view that satisfies the condition in the view’s defining query (query).

`Scope of check:`

In PostgreSQL, you can specify a scope of check.

- `LOCAL:`

  The LOCAL scope restricts the check option enforcement to the current view only. It does not enforce the check to the views that the current view is based on.

  ```sql
  CREATE VIEW view_name AS
  query
  WITH LOCAL CHECK OPTION;
  ```

- `CASCADE:`

  The `CASCADED` scope extends the check option enforcement to all underlying views of the current view.

  ```sql
  CREATE VIEW view_name AS
  query
  WITH CASCADED CHECK OPTION;
  ```
