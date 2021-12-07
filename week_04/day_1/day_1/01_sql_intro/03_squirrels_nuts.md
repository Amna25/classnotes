## Modeling a one to many relationship

Let's create a table to store the food of our squirrels.

food will have

* name
* type
type
We will worry about the squirrels later

> Ask the students to determine what type these columns will be.

Let's add a new table at the top of our file and comment out the queries we wrote earlier.

```sql
-- spring_watch.sql
DROP TABLE food; -- Above DROP TABLE squirrels
-- Just below CREATE TABLE squirrels

CREATE TABLE food (
  id SERIAL,
  name VARCHAR(255),
  type VARCHAR(255)
);
```

```zsh
# terminal
psql -d spring_watch -f spring_watch.sql;
```

Aside: You will often see 255 used because it's the largest number of characters that can be counted with an 8-bit number. It maximises the use of the 8-bit count, without frivolously requiring another whole byte to count the characters above 255. We'll come back to binary another time.

```sql
-- spring_watch.sql
INSERT INTO food (type, name, quantity) VALUES ('brazil', 'nut', 10);
INSERT INTO food (type, name, quantity) VALUES ('pumpkin', 'seed', 4);

SELECT * FROM food;
```

```zsh
# terminal
psql -d spring_watch -f spring_watch.sql
```

```sql
# psql terminal
SELECT * FROM food;
```

[Task:] Add a food

# Constraints

We can add "constraints" to our table definition, which will validate the data we try to enter against some basic rules.

* A food must have a type and a hilt metal

```sql
-- spring_watch.sql

CREATE TABLE food (
  id SERIAL,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(255) NOT NULL
);
```

```zsh
# terminal
psql -d spring_watch -f spring_watch.sql
```

Let's try to insert some invalid data.

```sql
# spring_watch.sql
INSERT INTO food (type) VALUES ('hazel');
```

```zsh
# terminal
psql -d spring_watch -f spring_watch.sql
```

## Primary Keys

We already discussed associating food and squirrels by adding the owner's name to the food table. We came to the conclusion that using the owner's ID is the better solution.

If we want to use an ID, it's important that we make sure that every row has an ID. Currently, we could set the ID field of our food to be null or a duplicate value.

```sql
-- spring_watch.sql
UPDATE food SET ID = 1;
```

> Ask if anybody can remember what we mentioned earlier that can solve this

The way we can make sure that his will never happen is to ask SQL to set our ID column to be the table's PRIMARY KEY.

A primary key is a column that uniquely defines a record. A primary key column cannot contain a NULL value. A table can have only one primary key. So we are explicitly saying that we want our ID field to be our main identifier for the rows in the table.

```sql
-- spring_watch.sql

CREATE TABLE squirrels (
  id SERIAL PRIMARY KEY, #updated
  name VARCHAR(255),
  hibernate BOOLEAN,
  age INT
);

CREATE TABLE food (
  id SERIAL PRIMARY KEY, # updated
  name VARCHAR(255) NOT NULL,
  type VARCHAR(255) NOT NULL
);

```

```zsh
# terminal
psql -d spring_watch -f spring_watch.sql
```

Now we can't alter it like we just did.

```sql
UPDATE food SET ID = 1;
```

## Foreign Keys

The last thing we want to do is to reflect the relationship between our squirrels and our food!

We can now use this primary key as an identifier in another table. When we do this we refer to it as a 'foreign key'. It's simply a primary key from another table.

> draw this on the board (one to many)

```sql
-- spring_watch.sql
CREATE TABLE food (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(255) NOT NULL,
  squirrel_id INT REFERENCES squirrels(id), 
);
```

We can see that the squirrels table now has a serial id and the food table now has a "references squirrel(id)" statement. Our squirrel_id is a reference to the primary key in the squirrels table.

Foreign keys are generally named according to the convention "table_name_singular_id", unless another name makes more 'sense' (but it would always have `_id` to indicate it's a foreign key).

Now, before we do anything else - what happens if we change the order of the drops and run this again? Because food now depends on squirrels, if we want to delete the squirrel table we must remove any tables that depend on it's primary keys.

Otherwise we'd end up with a whole bunch of zombie references to it. Let's fix that up and put it back in the correct sequence.

If we inspect our newly created rows, we can see the ids of the squirrels. Let's use these to modify the creation of the food.

```sql
-- spring_watch.sql
SELECT * FROM squirrels; --find the ids - depending on who got deleted 1 should be gone...

-- Now update the 2 previous food, by adding the squirrel_id to them

INSERT INTO food (name, type, quantity, squirrel_id) VALUES ('brazil', 'nut', 5, 2);

INSERT INTO food (name, type, quantity, squirrel_id) VALUES ('pumpkin', 'seed', 10, 1);
```

```zsh
# terminal
psql -d spring_watch -f spring_watch.sql
```

What happens if we try to add a food with a squirrel id that doesn't exist?

```sql
-- spring_watch.sql
INSERT INTO food (type, name, quantity, squirrel_id) VALUES ('hazel', 'nut', 5, 2097);
```

We get an error, as we might expect:

```
psql:spring_watch.sql:24: ERROR:  insert or update on table "food" violates foreign key constraint "food_squirrel_id_fkey"
```

PSQL expects that the `squirrel_id` field of `food` will contain an `INT` which `REFERENCES` the primary key of another table - the `id` column of `squirrels`. This `squirrel_id` column therefore contains a **foreign key**.

When we try to `INSERT INTO food` some data, including a `INT` that _doesn't_ correspond to any `id` field in `squirrels`, we get an error. The constraint of a foreign key is that its value must also exist somewhere in the column of the other table, and `1138` is not an `id` of any squirrel. We have violated the foreign key constraint, which is what the error tells us.

## Conclusion

This is what we call a One to Many relationship. Each food has ONE owner (`squirrel`). A squirrel can have MANY `food`, as different rows in the food table can have the same `squirrel_id`.

As a final step, lets add one more food to Anakin/Darth Vader, then lets find all food that he has!

```sql
INSERT INTO food (name, type, squirrel_id, squirrel_id) VALUES ('pine','nut', 50, 2);

SELECT * FROM food WHERE squirrel_id = 2;
```
