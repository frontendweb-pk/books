# Sequelize

Sequelize is a promise-based `Nodejs ORM tools` for `postgres, MySQL, MariaDB, Microsoft SQL Server, Oracle Database, Amzon Redshift and Snowflake's Data Cloud`.

**`Installation:`**

```ts
// postgres installation
npm install pg sequelize pg-hstore;
```

**`Connect to a database:`**

```ts
import { Sequelize } from "sequelize";

// syntax
export const any_identifier_name = new Sequelize(
  db_name,
  db_user,
  db_password,
  {
    host: host_name,
    port: port_name,
    dialect: "postgres",
    logging: console.log,
  }
);

// example
export const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASS,
  {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    dialect: "postgres",
    logging: console.log,
  }
);
```

**`Test the connection:`**

You can use the `.authenticate()` function to test if the connection is OK:

```ts
// anonymous function
(async () => {
  try {
    await sequelize.authenticate();
    console.log("Connection has been established successfully.");
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
})();
```

**`Closing the connection:`**

equelize will keep the connection open by default, and use the same connection for all queries. If you need to close the connection, call sequelize.close().

```ts
// close the current connection
await sequelize.close();
```

`Note:`

Once you called `sequelize.close()`

## Models

The models are the essence of sequelize, A model is an abstraction that represents a table in database.
