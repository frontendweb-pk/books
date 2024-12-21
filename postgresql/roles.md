# Roles

`PostgreSQL` uses the concept of `roles` to represent `user` accounts. It doesn’t use the concept of `users` like other database systems.

Typically, roles that can log in to the PostgreSQL server are called login `roles`. They are equivalent to `user` accounts in other database systems.

When `roles` contain other roles, they are referred to as `group roles`.

`Note:`

PostgreSQL combined the users and groups into roles since version 8.1

## CREATE ROLE statement

Use `CREATE ROLE` statement.

```sql
-- syntax
CREATE ROLE role_name
```

When you create a `role`, it is valid for all databases within the database server (or client).

`Example:`

```sql
-- create role pkumar
CREATE ROLE pkumar;
```

`To retrieve all roles:`

```sql
-- display all rolename
SELECT rolname FROM pg_roles;

-- In psql,
-- you can use the \du command to show all roles that you create including the postgres role in the current PostgreSQL server:
\du
```

`Note:`

- The roles whose names start with `pg_` are system roles.
- The `postgres` is a `superuser` role created by the `PostgreSQL` installer.

<br />

**`Login access to a role`**

To allow the login access to a role in the PostgreSQL server, you need to add the `LOGIN` attribute to it.

```sql
-- syntax
CREATE ROLE role_name
WITH -- optional
options;

-- options
CREATE ROLE role_name WITH
    LOGIN -- Allow the role to loing in to db,
    PASSWORD 'my_password' -- Set password for role,
    VALID UNTIL '2025-12-31' -- Set expiration date.,
    INHERIT -- Inherit privilege from other roles.,
    CREATEDB -- Allow the role to create new db. ,
    CREATEROLE -- Allow the role to create new role,
    SUPERUSER -- Grants the role all privilege.
    CONNECTION LIMIT connection_count;

```

`Create login role:`

Creating `pkumar` role that has the login privilege and initial password;

```sql
CREATE ROLE pkumar
LOGIN
PASSWORD '12345';

-- login in psql
psql -U pkumar -d blogs
```

**`Create superuser role:`**

The `superuser` role has all permissions within the `PostgreSQL` server.

Notice that only a `superuser` role can create another `superuser` role.

```sql
-- syntax
CREATE ROLE role_name
SUPERUSER
LOGIN
PASSWORD 'user_defined_passwor';
```

**`Create roles with database creation permission:`**

If you want to create roles that have the `database` creation `privilege`, you can use the `CREATEDB` attribute:

```sql
-- syntax
CREATE ROLE role_name
CREATEDB
LOGIN
PASSWORD 'user_defined_password';
```

**`Create roles with a validity period:`**

To set a date and time after which the role’s password is no longer valid, you use the `VALID UNTIL` attribute:

```sql
-- syntax
VALID UNTIL 'timestamp';

-- example
CREATE ROLE pkumar
WITH
CREATEDB -- createdb privilege
LOGIN
PASSWORD '1234' -- user defined password
VALID UNTIL '2026-01-01'; -- valid only till '1 jan 26'

```

After one second tick in 2026, the password of pkumar is no longer valid.

**`Create role with connection limit:`**

To specify the number of concurrent connections a role can make, you use the `CONNECTION LIMIT` attribute:

```sql
-- syntax
CONNECTION LIMIT connection_count;

-- example
CREATE ROLE pkumar
WITH -- optional
CREATEDB -- create db privilege
LOGIN
PASSWORD '12345' -- user defined password
VALID UNTIL '2026-01-01' -- valid until 2026
CONNECTION LIMIT 100 -- 100 concurrent connections
;
```

## GRANT

The `GRANT` statement to grant privileges on database object to a role.

After creating a `role` with the `LOGIN` attribute, the role can `log in` to the `PostgreSQL` database server.

However, it cannot do anything to the database objects like `tables`, `views`, `functions`, etc. For example, the `role` cannot select data from a `table` or `execute` a specific `function`.

To allow a `role` to interact with `database` objects, you need to `grant` privileges on the database objects to the role using the `GRANT` statement.

```sql
-- syntax
GRANT privilege_list | ALL
ON table_name
ON role_name;
```

- `Object Privileges:`

  - `SELECT:` Read data from a table, view, or foreign table.
  - `INSERT:` Insert new rows into a table.
  - `UPDATE:` Modify existing rows in a table.
  - `DELETE:` Delete rows from a table.
  - `TRUNCATE:` Remove all rows from a table.
  - `REFERENCES:` Create foreign key constraints referencing the table.
  - `TRIGGER:` Create triggers on the table.
  - `CREATE:` Create objects within the schema (e.g., tables, views, functions).
  - `CONNECT:` Connect to the database.
  - `TEMPORARY:` Create temporary tables.
  - `EXECUTE:` Execute functions.
  - `USAGE:` Grant the right to use a schema, sequence, language, or type.
  - `SET:` Set session parameters.
  - `ALTER:` SYSTEM: Alter system-wide parameters.
  - `MAINTAIN:` Perform maintenance operations on the object.
  - `USAGE:`(on a column): Use the column in expressions (e.g., in WHERE clauses).

- `Schema Privileges:`

  - `USAGE:` Use the schema and its objects.
  - `CREATE:` Create objects within the schema.

- `Database Privileges:`

  - `CONNECT:` Connect to the database.
  - `TEMPORARY:` Create temporary tables within the database.
  - `CREATE:` Create objects within the database.

- `Role Privileges:`

  The name of the `role` itself: `Grants` membership in the role, allowing the grantee to inherit privileges from the role.

- `Other Privileges:`

  - `ALL PRIVILEGES:` Grant all available privileges for the object type.
  - `WITH GRANT OPTION:` Allow the grantee to further grant the privilege to other roles.
