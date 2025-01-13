-- SEQUENCE
/**
What is sequence?

Sequence is a database object that allows you to generate a sequence of unique integers.
Typically, you use a sequence to generate a unique identifier for a primary key in a table.

Sequences are based on "bigint", so the range cannot exceed the range of an "eight-byte integer".

To list all sequence in psql
\ds

or

SELECT relname FROM pg_class WHERE relkind = 'S';


-- syntax for create
CREATE [ { TEMPORARY | TEMP } | UNLOGGED ] SEQUENCE [ IF NOT EXITS ] sequence_name
	[ AS { SMALLINT | INT | BIGINT } ]
	[ INCREMENT [BY] increment]
	[ MINVALUE minvalue | NO MINVALUE ]
	[ MAXVALUE maxvalue | NO MAXVALUE ]
	[ START [WITH] start]
	[ CACHE cache]
	[ [NO] CYELE ]
	[ OWNED BY { table.column_name | NONE } ]

** OWNER **
Owner will be the who is issueing the command.

** SCHEMA **
If a schema name is given then the sequence is created in the specified schema. Otherwise it is created in the current schema. 

Temporary sequences exist in a special schema, so a schema name cannot be given when creating a temporary sequence.

** FUNCTION **
After a sequence is created, you use the functions [nextval], [currval], [setval] AND [lastval] to operate on the sequence.

** TEMPORARY OR TEMP **
If specified, the sequence object is created only for this session, and is autometically dropped on session exit. 

** UNLOGGGED **
If specified, the sequence is created as unlogged sequence. Changes to unlogged sequences are not written to the write-ahead-log(WAL). 
They are not crash-safe: an unlogged sequence is autometically reset to its inital state after crash or unclean shutdown. 
Unlogged sequence are not replicated to standby server.

This option is mainly intended for sequences associated with unlogged table via identity columns or serial column.

** CACHE **
The optional clause CACHE specifies how many sequence numbers are to be preallocated and store in memory for faster access.
The minimum value is 1 (only one value can be generated at a time, i.e., no cache), and this is alos the default.

** CYCLE | NO CYCLE **
The CYCLE option allows the sequence to wrap around when the maxvalue or minvalue has been reached by an ascending or descending sequence respectively.

** OWNED BY [table_name.column_name | NONE] ** 
The OWNED BY option causes the sequence to be associated with a specific table column, such that if that column (or its whole table) is dropped, 
the sequence will be automatically dropped as well.

-- syntax for alter
ALTER SEQUENCE sequence_name
	[ AS data_type ]
	[ INCREMENT [BY] increment]
	[ MINVALUE minvalue | NO MINVALUE ]
	[ MAXVALUE maxvalue | NO MAXVALUE ]
	[ START [WITH] start]
	[ CACHE cache]
	[ [NO] CYELE ]
	[ OWNED BY { table.column_name | NONE } ]
ALTER SEQUENCE [IF EXISTS] name OWNER TO {NEW_OWNER | CURRENT_ROLE | CURRENT_USER | SESSION_USER}
ALTER SEQUENCE [IF EXISTS] name RENAME TO new_name;
ALTER SEQUENCE [IF EXISTS] name SET SCHEMA new_schema;

-- syntax for drop sequence
DROP SEQUENCE sequence_name;
*/

-- CREATE SEQUENCE serial
CREATE SEQUENCE serial START WITH 1;
SELECT nextval('serial') -- 1.. so on

-- CREATE AN ASCENDING SEQUENCE
CREATE SEQUENCE seq_inc_by_5 INCREMENT 5 START 1;
SELECT nextval('seq_inc_by_5');

-- CREATE AN descending SEQUENCE
CREATE SEQUENCE three INCREMENT -1 MINVALUE 1 MAXVALUE 3 START 3 CYCLE;
SELECT nextval('three'); -- you will see the number starting from 3, 2, 1 and back to 3, 2, 1, and so on:

-- CREATE SEQUENCE ASSOCIATED WITH TABLE COLUMN
CREATE SEQUENCE order_item_id OWNED BY order_details.item_id;

-- RENAME SEQUENCE
ALTER SEQUENCE serial RENAME TO serial_next;

-- ALTER TO start from 1 and set maxvalue 10
ALTER SEQUENCE serial START WITH 1 MAXVALUE 10;
SELECT nextval('serial'); -- THROW ERROR AFTER REACHED 10

-- ALTER TO SET CACHE 10 VALUES
ALTER SEQUENCE serial CACHE 10;

-- RESTART FROM 1
ALTER SEQUENCE serial RESTART WITH 1;

-- alter to set no max value
ALTER SEQUENCE serial START WITH 1 NO MAXVALUE;

-- SET SCHEMA
ALTER SEQUENCE serial SET SCHEMA schema_name;

-- ALTER SEQUENCE AS new data type
ALTER SEQUENCE serial AS BIGINT;

-- ALTER SEQUENCE CYCLE | NO CYCLE
-- Allow "my_sequence" to cycle when it reaches its max value
ALTER SEQUENCE serial CYCLE;

-- Disallow "my_sequence" from cycling
ALTER SEQUENCE my_sequence NO CYCLE;


-- FUNCTIONS
SELECT nextval('serial');
SELECT currval('serial');
SELECT setval('serial',5); -- set the current value to 5

-- RETRIEVE SEQUENCE INFO
-- pg_sequences: system catalog: You can query the pg_sequences catalog to retrieve details about all sequences in the database.
SELECT schemaname, sequencename, last_value, increment_by, min_value, max_value, cycle
FROM pg_sequences
WHERE schemaname = 'public';

/**
Why use sequence?

** Ensures uniqueness: **
Sequences guarantee unique numeric values, which are particularly useful for primary keys.

** Automatic incrementation: **
Sequence values are automatically incremented without the need for manual intervention.

** Performance: **
Sequences are efficient for generating large numbers and handle concurrent access effectively

*/

