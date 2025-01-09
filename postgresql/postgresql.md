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

- **CREATE TYPE:**

  `CREATE TYPE` Statemet allow you to create a data type for use in the current database. the user who defines the type become the `owner`.

  There are five forms of `CREATE TYPE`,

  - A composite type.
  - A enum type.
  - A range type.
  - A base type.
  - A shell type.

- `A composite type:`

  It is a first form of `CREATE TYPE`, The composite type specified by a list of attribute names and data types.

  To create a coposite type you must have 'USAGE' privilege on all attributes.

  ```sql
  -- syntax
  CREATE TYPE film_info AS (film_title varchar, film_release_year int);

  -- exmaple
  CREATE FUNCTION get_film()
  RETURNS SETOF film_info
  AS $$
      SELECT title, release_year::int FROM film;
  $$ LANGUAGE SQL;

  -- Alter
  -- Rename
  ALTER TYPE film_info RENAME TO new_name;
  -- Add attribute
  ALTER TYPE film_info ADD ATTRIBUTE film_rental_rate decimal(4,2);
  -- Drop attribute
  ALTER TYPE film_info DROP ATTRIBUTE film_release_year;
  -- Change owner
  ALTER TYPE film_info OWNER TO new_name;
  -- Change schema
  ALTER TYPE film_info SET SCHEMA new_schema;
  -- Rename attribute
  ALTER TYPE film_info RENAME ATTRIBUTE film_rental_rate TO 'rental_reate';
  -- Cange type
  ALTER TYPE film_info ALTER ATTRIBUTE SET TYPE data_type [COLLATE collation] [CASCATE | RESTRICT] -- COLLATE "en_US" or any
  ```

- ```sql
    -- syntax
    CREATE TYPE type_name AS (
    INPUT = input_function,
    OUTPUT = output_function
    [ , RECEIVE = receive_function ]
    [ , SEND = send_function ]
    [ , TYPMOD_IN = type_modifier_input_function ]
    [ , TYPMOD_OUT = type_modifier_output_function ]
    [ , ANALYZE = analyze_function ]
    [ , SUBSCRIPT = subscript_function ]
    [ , INTERNALLENGTH = { internallength | VARIABLE } ]
    [ , PASSEDBYVALUE ]
    [ , ALIGNMENT = alignment ]
    [ , STORAGE = storage ]
    [ , LIKE = like_type ]
    [ , CATEGORY = category ]
    [ , PREFERRED = preferred ]
    [ , DEFAULT = default ]
    [ , ELEMENT = element ]
    [ , DELIMITER = delimiter ]
    [ , COLLATABLE = collatable ]
  )

    -- example
    CREATE TYPE film_info AS (
        film_id int,
        film_tile varchar,
        film_release_year int
    );
  ```
