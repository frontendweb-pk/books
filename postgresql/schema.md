# PostgreSQl Schema

In PostgreSQL, a schema is a named collection of database object, including

- Tables
- Indexes
- Views
- Data Types
- Functions
- Procedures
- Operators
- Sequences
- Triggers
- Materialized Views
- Domains
- Aggregates
- Collations
- Foreign Tables

and many more.

A schema allows you to organize and namespace objects within a database.

`Access and object in Schema:`

```sql
-- syntax
schema_name.object_name

-- example
SELECT * FROM public.users; -- public is schema
```
