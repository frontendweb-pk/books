# User-defined type

PostgreSQL allow you to create custom type (user-defined).

PostgreSQL provide two statements for create user-defined type.

- **CREATE DOMAIN:** Used to create user-defined type with constraint.

  The user who defines a domain becomes its owner.

  Domains are usefull for abstracting common constraints on fields into a single location for maintenance.

  `Ex:`

  Several tables might contain email address columns, all requiring the same CHECK constraint to verify the address syntax

  `Syntax:`

  ```sql
  CREATE DOMAIN domain_name [ AS ] data_type
    [ COLLATE collation ]
    [ DEFAULT expresion ]
    [ constraint [...] ];

  -- Where constraint is
   [ CONSTRINT constraint_name ]
   [ NOT NULL | NULL | CHECK(expression) ]
  ```

  `Example:`

  ```sql
  -- CREATE
  CREATE DOMAIN validate_name AS VARCHAR NOT NULL CHECK(VALUE <> '');

  -- ALTER syntax
    ALTER DOMAIN name
        { SET DEFAULT expression | DROP DEFAULT }
    ALTER DOMAIN name
        { SET | DROP } NOT NULL
    ALTER DOMAIN name
        ADD domain_constraint [ NOT VALID ]
    ALTER DOMAIN name
        DROP CONSTRAINT [ IF EXISTS ] constraint_name [ RESTRICT | CASCADE ]
    ALTER DOMAIN name
        RENAME CONSTRAINT constraint_name TO new_constraint_name
    ALTER DOMAIN name
        VALIDATE CONSTRAINT constraint_name
    ALTER DOMAIN name
        OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
    ALTER DOMAIN name
        RENAME TO new_name
    ALTER DOMAIN name
        SET SCHEMA new_schema

  -- Drop domain
    DROP DOMAIN domain_name;


  -- Examples
  -- Rename domain
  ALTER DOMAIN validate_name RENAME TO validate;

  -- Set default
  ALTER DOMAIN validate SET DEFAULT '';
  -- Drop default
  ALTER DOMAIN validate DROP DEFAULT;

  -- Set not null
  ALTER DOMAIN validate SET NOT NULL;
  -- Drop not null
  ALTTER DOMAIN validate DROP NOT NULL;

  -- Set owner
  ALTER DOMAIN validate OWNER TO pkumar;
  -- Set schema
  ALTER DOMAIN validate SET SCHEMA schema_name;

  -- Add constraint
  ALTER DOMAIN zipcode ADD CONSTRAINT zipchk CHECK (char_length(VALUE) = 5);
  -- Drop constraint
  ALTER DOMAIN zipcode DROP CONSTRAINT zipchk;

  -- Drop domain
  DROP DOMAIN zipcode;
  DROP DOMAIN validate;
  ```
