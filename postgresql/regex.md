# Regular expression

Regular expression can be used for `search`, `match` and `replace` pattern in string.

There are three separate approaches for pattern matching in `PostgreSQL`.

- `LIKE:` Like operator
- `SIMILAR TO:` The more recent `SIMILAR TO`.
- `POSIX-style regular expression:`

`Expressions:`

- `^:` Anchors the match at the beginning of the string.
- `$:` Anchors the match at the end of the string.
- `.:` Match any single character (except for the new line).
- `*:` Matches `0` or `more` repetitions of the preceding character or group.
- `+:` Matches `1` or `more` repetitions of the preceding character or group.
- `?:` Matches `0` or `1` occurance of the preceding character or group.

- `[]:` Denotes a character class (e.g., [A-Za-z] matches any letter).
- `|:` Denotes an OR condition (e.g., a|b matches either 'a' or 'b').
- `():` Groups expressions (e.g., (abc)+ matches one or more occurrences of 'abc').
- `\d:` Matches any digit (equivalent to [0-9]).
- `\w:` Matches any word character (letters, digits, or underscores).
- `\s:` Matches any whitespace character.

`Key operators:`

- `~ Match regular expresson:`
  Used to match if a string matches a regular expression, the operator is case-sensitive.

  ```sql
  -- syntax
  SELECT * FROM table_name
  WHERE column_name ~ 'expressoin';

  -- select all actor whose first name start with [aeiou]
  SELECT * FROM actor
  WHERE first_name ~ '^[AEIOUaeiou]';
  ```

- `~* Match regular expression case-sensitive:`
  This is similar to `~` but perform case-sensitive.

  ```sql
    SELECT * FROM employees WHERE name ~* 'john';
  ```

- `!~ Does not match regular expression:`
  Used to check if a string does not match regular expression.

  ```sql
  -- This will select actor whose name contains non-alphabetic characters.;
  SELECT * FROM actor
  WHERE first_name ~! '^[A-Za-z]+$';
  ```

- `!~* (Does not match regular expression, case-insensitive):`

  ```sql
  SELECT * FROM actor WHERE name !~* 'john';
  -- This will select actor whose name does not contain "john" (case-insensitive).
  ```

- `regexp_matches(find matches of a regular expression):`
  Returns an array of all matches found in a string.

  ```sql
  SELECT regexp_matches('abc123def', '\d+', 'g');
  ```

- `regexp_replace (Replace part of a string based on a regular expression):`
  Replaces the portion of the string that matches the regular expression with a replacement.

  ```sql
  -- This will replace 123 with 456, returning 'abc456def'.
  SELECT regexp_replace('abc123def', '\d+', '345');
  ```

  - `regexp_split_to_array (Split a string into an array based on a regular expression):`
    Splits a string based on a regular expression pattern and returns an array of substrings.

  ```sql
  -- This will return {"apple", "banana", "orange"}.
  SELECT regexp_split_to_array('apple,banana,orange', ',');
  ```

  - `regexp_split_to_table (Split a string into rows based on a regular expression):`
    Similar to regexp_split_to_array, but returns each substring as a row.

  ```sql
  -- This will return {"apple", "banana", "orange"}.
  SELECT regexp_split_to_table('apple,banana,orange', ',');
  ```

**`Examples:`**

```sql
-- replace all vowels with *
SELECT regexp_replace('Hello World','[aeiou]','*','g')
```
