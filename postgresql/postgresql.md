## Numeric types

## Monetory types

## Character types

## Binary types

## Date/Time types

## Boolean types

## Enumrated types

## Geometric types

## Network address types

## Text search types

## UUID types

## XML types

## JSON types

## Array types

## User-defined type

PostgreSQL allow you to create custom type (user-defined).

PostgreSQL provide two statements for create user-defined type.

- **CREATE DOMAIN:** Used to create user-defined type with constraint.

  The user who defines a domain becomes its owner.

  Domains are usefull for abstracting common constraints on fields into a single location for maintenance.

  `Ex:`

  Several tables might contain email address columns, all requiring the same CHECK constraint to verify the address syntax

  `Syntax:`

  ```sql
  -- use \dD command to display domain
  -- syntax
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

  <br />

- `A enum type:`

  Enumerated (enum) types are data types that comprise a static, ordered set of values.

  It is a second form of create type that creates an (ENUM) rated type.

  Enum types take a list of quoted labels, each of which must be less than `NAMEDATALEN` bytes long (64 bytes in a standard PostgreSQL build)

  ORDERING: The ordering of the values in an enum type is the order in which the values were listed when the type was created. All standard comparison operators and related aggregate functions are supported for enums.

  Each enumerated data type is separate and cannot be compared with other enumerated types.

  ```sql
  -- use \dT command to display all type

  -- syntax
  CREATE TYPE type_name AS ENUM(labels);

  -- exmaple
  CREATE TYPE days AS ENUM('sun','mon','tue','wed','thr','fri','sat');

  -- real world example
  CREATE TYPE mood AS ENUM('good','sad')
  CREATE TABLE person (
    name text,
    current_mood mood
  );
  INSERT INTO person VALUES ('Moe', 'happy');
  SELECT * FROM person WHERE day = 'happy';

  -- ordering
  INSERT INTO person VALUES ('Larry', 'sad');
  INSERT INTO person VALUES ('Curly', 'ok');
  SELECT * FROM person WHERE current_mood > 'sad';
  SELECT * FROM person WHERE current_mood > 'sad' ORDER BY current_mood;

  -- display
  SELECT enum_range(null::days); -- display all
  SELECT enum_first(null::days); -- first enum
  SELECT enum_range('mon',null::days) -- ('mon'...'sat');
  SELECT enum_range(null::days,'thr'); -- ('sun'...'thr');

  -- Alter
  ALTER TYPE days RENAME TO new_name;
  ALTER TYPE days OWNER TO current_user;
  ALTER TYPE days SET SCHEMA 'new_schema';
  ALTER TYPE days ADD VALUE 'SUN' BEFORE 'mon';
  ALTER TYPE days ADD VALUE 'SUN' AFTER 'mon';
  ALTER TYPE days RENAME VALUE 'old_Value' TO 'new_value';

  -- Drop
  DROP TYPE type_name;
  ```

- `A range type:`

  Range type are data types representing a range of values some element type (called the range's subtype).

  ```sql
  -- syntax
   CREATE TYPE age_range AS RANGE (
    subtype = int4,
    subtypmods = integer
  );

  -- Create a table to store age ranges
    CREATE TABLE age_groups (
        id SERIAL PRIMARY KEY,
        age_group age_range
    );

    -- Insert data into the table
    INSERT INTO age_groups (age_group) VALUES
        ('[18, 30]'),
        ('[31, 65]'),
        ('[66, 120]');

    -- Query data
    SELECT * FROM age_groups;
  ```
