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
CREATE ROLE role_name WITH options;

-- WITH is optional
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
