# Associations Intro

#### Objectives

- Explain the following types of associations:
	- One to one
	- One to many
	- Many to many

Up until now we have created a single squirrels table, and we could execute CRUD operations on them. This is pretty cool but we probably want more data to play with.

For example, our squirrels might want to own one or more food, and we might want to reflect their relationship in our tables.

Let's have a think. How should we structure our tables? We already had a single table of squirrels:

> DRAW THE FOLLOWING

```
squirrels
id,
name,
hibernate,
age
```

If we were to have a table of food, it could look something like this:

```
food
id,
name,
type
```

But how can we explicitly state that there is a relationship between the 2 tables?

The most straightforward way to do this is to add another column to our food table, and referring to the name of the owner.

```
food
id,
name,
type,
squirrel_name
```

This way, we can try to search for food with a certain owner name like such:

```sql
SELECT * FROM food WHERE squirrel_name = 'Luna';
```

However, there are problems. What happens if I make a typo in either the squirrels name column, or the food squirrel_name column? No chance of me ever finding it. Not to mention that 2 squirrels might have matching names, or one Character might get married, change name, therefore losing reference to their food!


What could be used that is explicit, unique, and will not be modified by the user? The ID field!

Currently it can be modified by the user and we do not tell SQL to make sure that the IDs are unique. We can change that by setting our ID field to be something SQL calls a PRIMARY KEY. More about that a bit later - for now, let's just say that the main identifier of our tables will be also called a primary key.

```
food
id,
name,
type,
character_id // UPDATED, connect it with squirrels ID field
```

And to make it even more foolproof, we can tell SQL that all referenced character_id MUST exist in the squirrels table.

This is also called a foreign key, because a foreign tables primary key is being referenced in this column.

In SQL, when we start to have multiple tables, we relate a data ( this is why we call SQL a relational database ) row to one or more data rows in another table. There are a few different relationships that we can establish:

- One to one
- One to many
- Many to many

## One to one

In a one-to-one relationship, a given row in one database table is linked to one and only one other row in another table.

#### customers table

| columns | id | first\_name | last\_name | billing\_address\_id |
|---|---|---|---|---|
| 1st row: |Primary key| Mark | Smith | ID of Stirling address from billing_addresses table - foreign key|

#### billing_addresses table

| columns | id | street | city | postcode | customer\_id |
|---|---|---|---|---|---|
|1st row: |Primary key| Windsor Place | Stirling | FK8 2HY | ID of Mark from customers table - foreign key|


## One to many

Now we can start working with multiple tables. How would we model a relationship where one musician plays in one band, but the band has many musicians?

We might have a musicians table.

#### musicians table

| id | first\_name | last\_name |
|---|---|---|
|Primary key| Dave | Grohl |

We may also have a bands table.

#### bands table

| id | name | formed\_on |
|---|---|---|
|Primary key| Nirvana | 1987 |

Now we can setup a one to many association. We can say one band row is associated to many musician rows.  With this setup, we use the band_id as the FOREIGN KEY. We use this foreign key to reference the ID of the associated row in the other table.

So, we would add this column to our musicians:

#### musicians table

| id | first\_name | last\_name | band_id |
|---|---|---|---|
|Primary key| Dave | Grohl | ID of Nirvana from bands table|

## Many to Many

But wait - we just realised that a musician can play in many bands too, not just in one. How should we change our database setup to represent this?

Putting a foreign key in each table would make it a one-to-one relationship. Putting a foreign key in one of them would make it a one-to-many relationship.

Our solution is adding a third table, a join or junction table! Each entry in this join table should include the band's id and the musician's id, thus representing the relationship between one musician and one band - but we can have many of this kind of relationship!
The table can be named bands_musicians, because they will contain both of their ID's, unless we can give them a better name that represents the relationship better.

#### musicians_bands table

| id | band\_id | musician\_id |
|---|---|---|
|Primary key| ID of Nirvana | ID of Dave Grohl |
|Primary key| ID of Foo Fighters | ID of Dave Grohl |

Therefore each and every entry in this table would map to a member of a band. We can add more members of Foo Fighters with more rows in our musicians_bands, but we can also put Dave Grohl in other bands!
Of course we can have multiple rows in it, representing multiple members, creating a nice model of a many-to-many relationship!

## PAIRED TASK:

Model the following associations, including the datatypes

- CUSTOMERS & CUSTOMER_DETAILS
- BASKETBALL TEAMS & PLAYERS
- QUIDDITCH PLAYERS & BROOMSTICKS
- ORDERED ITEMS & CUSTOMERS

> Note: Quidditch players & Broomsticks can be both a one to one, or a one to many!