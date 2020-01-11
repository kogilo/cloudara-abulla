# Introduction
* How to read a combined data from 2 or more tables to a single result.
* 2 ways to do this:
  * `row-wise or vertically => UNION`
  * `column-wise or Horizontally => JOIN`

# Combining Query Results with the UNION Operator
* The UNION operator in SQL combines two result sets into one.
* It takes the rows returned by one `SELECT` statement and the rows returned by another `SELECT` statement, and it stacks them together.
* It combines them vertically.
* There are `two variations` of the UNION operator: `UNION ALL` and `UNION DISTINCT`.

## UNION ALL
* eg.
~~~~sql
SELECT id, name FROM fun.games;

SELECT id, name FROM toy.toys;
~~~~

* WIth `UNION ALL`
~~~~sql
SELECT id, name FROM fun.games
UNION ALL
SELECT id, name FROM toy.toys;
~~~~
* Another
~~~~sql
SELECT country FROM customers;
UNION ALL
SELECT country FROM offices;
~~~~

## UNION DISTINCT
* To eliminate duplicate, use `UNION DISTINCT`

~~~~sql
SELECT country FROM customers;
UNION DISTINCT
SELECT country FROM offices;
~~~~
* NB. Older version of Impala do not support `UNION DISTINCT`
* The SELECT statements on both sides of the UNION operator should have the same schema. In other words they should have the same number of columns and the pairs of corresponding columns should have the same names and the same data types, or at least the same high-level categories of data types, like both numeric or both character string
.
* To avoid column name problem with the same data type, you can use column alias.
~~~~sql
SELECT name, list_price AS price FROM fun.games
UNION ALL
SELECT name, price FROM toy.toys;
~~~~

~~~~sql
SELECT year FROM fly.flights
UNION DISTINCT
SELECT CAST(year AS INT) AS year FROM fun.games;
~~~~

### UNION
* Sometimes it is refered as clause in Documentation. But it is Operator.

# READING: Missing or Truncated Values from Type Conversion
* In queries that use `UNION` (and in other types of queries), you will sometimes need to use explicit type conversion (also called explicit casting) to convert a column (or a scalar value) from one data type to another. In most SQL dialects, this is done using the `cast` function. However, you need to be careful about a couple of things when using `cast`.

### Review: Explicit Type Conversion
* As you might recall, you can cast any numeric column to a character string column, like this:
~~~~sql
SELECT cast(list_price AS STRING) FROM games;
~~~~

* If you have a character string column whose values represent numbers, then you can cast it to a numeric column, like this:
~~~~sql
SELECT cast(year AS INT) FROM games;
~~~~
* Refer back to the video “Data Type Conversion” in Week 2 of this course if you need more of a refresher on the basics of data type conversion.

### Type Conversion Can Return Missing Values
* Under some circumstances, the cast function will return missing (NULL) values. A common situation in which this happens is when you have a character string column whose values do not represent numbers, and you try to convert it to a numeric column.

* For example, this query attempts to convert the character string values in the name column (values like `Monopoly` and `Scrabble`) to integer values:
~~~~sql
SELECT cast(name AS INT) FROM games;
~~~~
* When you run this query with Hive or Impala, it returns a column of NULL values, because there is no way to cast these character string values to known integer values.

* However, some other SQL engines have different ways of handling situations like this. If you use MySQL to cast a character string column as a numeric column, it returns zeros for the values that do not represent numbers (not NULLs like Hive and Impala). And PostgreSQL throws an error if you attempt to cast a character string that does not represent a number as a number. Also note that different SQL engines have different data types, so the data type name you use after the AS keyword in the cast function varies depending on the engine. For example, in MySQL you should use SIGNED INT instead of INT, and in MySQL and PostgreSQL you should use CHAR instead of STRING.

### Type Conversion Can Return Truncated Values
* Under some circumstances, the cast function will return truncated (cut off) values. A common situation in which this happens is when you convert decimal number values to integer values.

* For example, this query converts the decimal numbers in the list_price column (which have two digits after the decimal) to integer values:
~~~~sql
SELECT cast(list_price AS INT) FROM games;
~~~~
* When you run this query with Impala or Hive, it truncates (cuts off) the decimal point and the two digits after it. For example: 19.99 becomes 19.

However, in this situation, some other SQL engines round instead of truncating. When you run a query like this with MySQL or PostgreSQL, it rounds each decimal number value to the nearest integer value. For example: 19.99 becomes 20.


# Using ORDER BY and LIMIT with UNION

* The SELECT statements on both sides of a UNION operator, can use any of the clauses that you've learned about in this course, with two exceptions: the ORDER BY and LIMIT clauses.
### ORDER BY
* The way that the `ORDER BY` clause works when you use the UNION operator, differs depending on what SQL engine you're using.
* Here are some examples to demonstrate this.
* Say you wanted to return the `names` and `prices` of all the `games` from the `games table` and all the `toys` from the `toys table`.
* To do that, you would run a query like this:
~~~~sql
SELECT name, list_price AS price FROM games
UNION All
SELECT name, price FROM toys;
~~~~
* for Hive or impala , you need to add the name of the database like `fun.games`.
* Now, what if you wanted to return these rows in a specific order, say in ascending order by price; the lowest price at the top, the highest price at the bottom?

~~~~sql
SELECT name, list_price AS price FROM games
UNION All
SELECT name, price FROM toys
ORDER BY price;
~~~~


## LIMIT clause
  * No way to limit the number of row with UNION ALL


# READING

* You can use **`UNION ALL`** or **`UNION DISTINCT`** to combine three or more query results into a single result set. To do this, simply add another **UNION** operator after the final **SELECT** statement and add another **SELECT** statement after it. For example, the following query uses three SELECT statements, combined with two UNION ALL operators:

~~~~sql
SELECT color, 'red' AS component, red AS value

     FROM crayons

     WHERE color = 'Mauvelous'

UNION ALL

SELECT color, 'green' AS component, green AS value

     FROM crayons

     WHERE color = 'Mauvelous'

UNION ALL

SELECT color, 'blue' AS component, blue AS value

     FROM crayons

     WHERE color = 'Mauvelous';
~~~~

* This query returns the three component values **(red, green, blue)** of the color named **Mauvelous**, in three separate rows.

* Be sure to use a semicolon only at the very end.
* When using three or more **UNION** operators in one query, it’s a good idea to make them all UNION ALL or all UNION DISTINCT. Mixing the two different types of UNION operators in a single query is likely to cause confusion.

* The rules that apply when using a **UNION** to combine two results also apply in the case of three or more results:
    * The **SELECT** statements should have the same number of columns and the sets of corresponding columns should have the same names and the same high-level categories of data types. Use explicit casting and column aliases to ensure this.
    * You can use the **SELECT**, **FROM, WHERE, GROUP BY**, and **HAVING** clauses in each SELECT statement, but be careful about using the ORDER BY and LIMIT clauses. Check the documentation for the specific SQL engine you’re using, and run some simple tests to make sure you understand how it will interpret the **ORDER BY** and **LIMIT** clauses in **UNION** queries.

# Introduction to Joins
* Combine related data into one.
* It join them Horizontally.
* It matches the rows from the two tables.
* you specify what the relationship between the two tables is when you write the query.
* For example the toys and makers tables relate each other for the fact that each joy has a maker.
* Because the data is stored in normailzed separeate tables.


# Join Syntax
~~~~sql
SELECT *
  FROM toys JOIN makers;
~~~~

* The two tables can be from the same database or different databases.
* If they are from different database, you need to you `tablename.databasename`
* You need also the specify what the relation between the two table is so that they can match each other.
* To do this, use `ON` keyword followed by the relationship.
~~~~sql
SELECT *
  FROM toys JOIN makers
  ON toys.maker_id = makers.id;
~~~~
* The expression after `ON` keyword is called the `JOIN condition` .
* These corresponding keys sometimes called the ` join columns or join key columns.`
* Because it select all `(*)`, the query result bering the all columns.
* But you see the colum name `id` at two places.
* To avoid this you need to `explicitly ` write the columns you want.

~~~~sql
SELECT toys.id AS id, toys.name AS toy, price, maker_id, makers.name AS maker, city
  FROM toys JOIN makers
  ON toys.maker_id = makers.id;
~~~~
* NOTE: `toys.name AS toy, price` and `makers.name AS maker`.
* Shortcut to avoid typing name again.
* It is called `table alias`


~~~~sql
SELECT toys.id AS id, toys.name AS toy, price, maker_id, makers.name AS maker, city
  FROM toys AS t JOIN makers AS m
  ON toys.maker_id = makers.id;
~~~~
* Then you can replace the toys with t and makers with m in the above query.

~~~~sql
SELECT toys.id AS id, t.name AS toy, price, maker_id, m.name AS maker, city
  FROM toys AS t JOIN makers AS m
  ON t.maker_id = m.id;
~~~~

* It is optional but very useful.
*
## Quize

* Which of the following are valid join queries that Impala will run successfully on the VM? (For more information about the tables in the database, see the Data Reference reading.) Check all that apply.


SELECT DISTINCT carrier, f.tailnum AS tailnum,

        manufacturer, model, p.year AS year

    FROM fly.flights f JOIN fly.planes p

        ON f.tailnum = p.tailnum;

Correct
Correct. The AS keyword is not required when defining the table aliases, so this syntax is valid. Any ambiguous column references are disambiguated by prepending the table alias.

SELECT DISTINCT carrier, f.tailnum AS tailnum,

        manufacturer, model, p.year AS year

    FROM fly.flights f JOIN fly.planes p

        ON f.tailnum = p.tailnum;

is selected.This is correct.
Correct. The AS keyword is not required when defining the table aliases, so this syntax is valid. Any ambiguous column references are disambiguated by prepending the table alias.


SELECT DISTINCT carrier, f.tailnum AS tailnum,

        manufacturer, model, p.year AS year

    FROM fly.flights JOIN fly.planes

        ON f.tailnum = p.tailnum;

Un-selected is correct
SELECT DISTINCT carrier, f.tailnum AS tailnum,

        manufacturer, model, p.year AS year

    FROM fly.flights JOIN fly.planes

        ON f.tailnum = p.tailnum;

is not selected.This is correct.

SELECT DISTINCT carrier, tailnum, manufacturer, model, year

    FROM fly.flights AS f JOIN fly.planes AS p

        ON f.tailnum = p.tailnum;

Un-selected is correct
SELECT DISTINCT carrier, tailnum, manufacturer, model, year

    FROM fly.flights AS f JOIN fly.planes AS p

        ON f.tailnum = p.tailnum;

is not selected.This is correct.

SELECT DISTINCT fly.flights.carrier, fly.flights.tailnum,

        fly.planes.manufacturer, fly.planes.model, fly.planes.year

    FROM fly.flights JOIN fly.planes

        ON fly.flights.tailnum = fly.planes.tailnum;

Correct
Correct. This query is valid, despite the use of lengthy, repetitive table references which include the database name. This query would be improved by using table aliases.


* The example join query I showed in this video used only the `SELECT` clause and the `FROM` clause, but you can use `all of the other clauses` with a join query; there are no exceptions to this. And the aliases that you give to the tables in the `FROM clause`, you can use those in all the other clauses too, to resolve any ambiguity about which columns are from which tables.

## Quize

* Which of the following are valid join queries that Impala will run successfully on the VM? Check all that apply.


SELECT t.name AS game, m.name AS maker

    FROM toy.toys t JOIN toy.makers m

        ON t.maker_id = m.id

    ORDER BY t.name DESC;

Correct
Correct. It also would be valid to use the column alias game instead of the column reference t.name in the ORDER BY clause.

SELECT t.name AS game, m.name AS maker

    FROM toy.toys t JOIN toy.makers m

        ON t.maker_id = m.id

    ORDER BY t.name DESC;

is selected.This is correct.
Correct. It also would be valid to use the column alias game instead of the column reference t.name in the ORDER BY clause.


SELECT t.name, m.name AS maker

    FROM toy.toys JOIN toy.makers

        ON t.maker_id = m.id

    ORDER BY game;

Un-selected is correct
SELECT t.name, m.name AS maker

    FROM toy.toys JOIN toy.makers

        ON t.maker_id = m.id

    ORDER BY game;

is not selected.This is correct.

SELECT m.name AS maker, COUNT(*) AS number_of_toys

    FROM toy.toys t JOIN toy.makers m

        ON t.maker_id = m.id

    GROUP BY maker;

Correct
Correct. Impala allows use of aliases from the SELECT list in the GROUP BY clause.

SELECT m.name AS maker, COUNT(*) AS number_of_toys

    FROM toy.toys t JOIN toy.makers m

        ON t.maker_id = m.id

    GROUP BY maker;

is selected.This is correct.
Correct. Impala allows use of aliases from the SELECT list in the GROUP BY clause.


SELECT m.name AS maker, AVG(price) AS avg_price

    FROM toy.toys t JOIN toy.makers m

        ON t.maker_id = m.id

    GROUP BY maker

    ORDER BY avg_price;

Correct
Correct. Aliases set in the SELECT clause are allowed in the ORDER BY clause, and in Impala, they can also be used in the GROUP BY clause.

SELECT m.name AS maker, AVG(price) AS avg_price

    FROM toy.toys t JOIN toy.makers m

        ON t.maker_id = m.id

    GROUP BY maker

    ORDER BY avg_price;

is selected.This is correct.
Correct. Aliases set in the SELECT clause are allowed in the ORDER BY clause, and in Impala, they can also be used in the GROUP BY clause.


SELECT t.name AS game, m.name AS maker

    FROM toy.toys t JOIN toy.makers m

        ON t.maker_id = m.id

    WHERE maker = 'Hasbro';

Un-selected is correct

# Inner Joins
~~~~sql
SELECT t.name AS toy, m.name AS maker
FROM toys t JOIN makers m
ON t.maker_id = m.id;
~~~~
* In the `FROM` clause there are two table references separated by the keyword JOIN.
* In this example, the first column comes from the `toys table` and the second column comes from the `makers table` and each toy is in the same row as its maker.
* However, as you might have noticed, the maker `Mattel` is in the makers table but does not appear in the result of this join.
* The reason for this, as you might have inferred, is that none of the toys in the toys table are made by Mattel.
* Mattel is represented by maker_id 107 and none of the toys have maker_id 107.
* This is how joins work by default in SQL.
* For a row to be returned in the join result, it must match a row in the other table; rows without a match are not returned.
* This `default` type of join has a name: it's called an `inner join`.
* To understand why this is called an inner join, it helps to visualize the values in the columns we're joining on.
* These are the columns we're joining on.
* wo of the values, 105 and 106, are in both circles. Those values exist in both tables. However, one of these values, 107, is only in the right circle.
* That value exists only in the makers table.
So, when you use the keyword JOIN between the two table names like in this example, what the SQL engine performs is an inner join.
* But you can also explicitly specify that you want an inner join by using the keyword INNER before JOIN.
* It does not matter if you include the INNER keyword or leave it off.

* Review the contents of the employees and offices tables (see the Data Reference reading), and try to answer the following question without actually running the join query. (You can check your answers by running the query in Impala and viewing the result set.)
~~~~sql
SELECT first_name, last_name, city

    FROM employees e INNER JOIN offices o

        ON e.office_id = o.office_id;
~~~~

## Quize

* Which employees are included in the inner join result? Check all that apply.
  * Ambrosio Rojas
  * Val Snyder
  * Virginia Levitt
  * Sabahattin Tilki
  * Lujza Csizmadia

* Review the contents of the employees and offices tables (see the Data Reference reading), and try to answer the following question without actually running the join query. (You can check your answers by running the query in Impala and viewing the result set.)
~~~~sql
SELECT first_name, last_name, city

    FROM employees e INNER JOIN offices o

        ON e.office_id = o.office_id;

~~~~

* Which offices are included in the inner join result? Check all that apply.
  * Istanbul
  * Chicago
  * Rosario
  * Singapore

## Example

~~~~sql
SELECT t.name AS toy, m.name AS maker
  FROM makers m INNER JOIN toys t
  ON t.maker_id = m.id;
~~~~

## Example
~~~~sql
SELECT m.name AS maker, COUNT(t.name) AS num_toys
  FROM makers m INNER JOIN toys t
  ON t.maker_id = m.id
  GROUP BY maker;
~~~~
* This query is slightly more complex. It joins the same two tables, makers and toys, but this time it groups by maker and it uses the COUNT function to return the number of toys made by each maker. The trouble is, the result set totally excludes Mattel.
* What I would like in this case is for the result set to include Mattel with a count of zero, but since this is an inner join and there's no row in the toys table with maker_id 107, Mattel is simply excluded.
* Depending on how this result set was used, the absence of Mattel could be misleading; it could cause an oversight or a misinterpretation.
* This is just one example of a case where inner joins do not return the result you're looking for.
* In the next video, you'll learn how to solve this problem by using outer joins.

# Outer Joins
* I'll use the employee table and the offices table, both in the default database.
* These tables represent five different employees and four different offices.
* The relationship between these two tables represents which employees work at which offices.
* The columns with the corresponding values that can be matched to join the tables together are named office_id in both of the tables.
* There are `two` important things to notice in these tables.
  * `First`, there is one employee, Val, who has an office_id that does not exist in the offices table.
  * Val has office_id e, but there is no office with office_id e.
  * And `second`, there is one office, the Singapore office, that has no employees.
  * The Singapore office has office_id d, but none of the employees have office_id d.
  * It helps to use a Venn diagram to visualize this. You can see that the office_ids a, b, and c are in the inner region. They exist in both tables. But office_id e, that's Val's office_id, is found only in the employees table, the one on the left. And office_id d, for the Singapore office, that's found only in the offices table, the one on the right.
  * Before I talk about outer joins, first recall what an inner join does. It returns only the rows with join column values in the inner region.
  * In this example, office_ids a, b, and c are in this inner region; those values exist in both tables.

  ~~~~sql
  SELECT empl_id, first_name, o.office_id AS office_id, city
    FROM employees e INNER JOIN office o
    ON e.office_id = o.office_id;
  ~~~~

  * So when the SQL engine combines these two tables, it identifies their corresponding rows by matching their office_id values, and it merges the rows according to these matches.
  * And if it's an inner join, it returns only the rows that have matches. The rows that don't have matches, that's Val with office_id e and the Singapore office with office_id d, those are not returned by an inner join.
  * Outer joins handle non-matching rows differently.
  * There are `three types of outer joins`, and each one handles non-matching rows in a particular way.
  * In a left outer join, if there are rows in the left table with a join column value that does not exist in the right table, it returns them anyway. So in this example, a left outer join will include the employee Val in the result even though Val's office_id, e, does not match any of the office_ids in the offices table. In a right outer join, if there are rows in the right table with a join column value that does not exist in the left table, it returns them anyway. So a right outer join will include the Singapore office in the result, even though its office_id, d, does not match any of the office_ids in the employees table. And finally, in a `full outer join`, if there are rows in either of the tables with join column values that don't exist in the other table, it returns them anyway.
  * Now let's look at the SQL syntax for these three types of outer joins and see what exactly they return.
  * The syntax is the same as for an inner join, except that you replace INNER with LEFT OUTER, RIGHT OUTER, or FULL OUTER.
  ~~~~sql
  SELECT empl_id, first_name, o.office_id AS office_id, city
  FROM employees e LEFT OUTER JOIN offices o
  ON e.office_id = o.office_id;
  ~~~~
  * The office_id for Val also shows up as NULL in the result. That's because I used o.office_id in the SELECT list. If I change this to e.office_id, then that value will come from the employees table, so it's not NULL.

  ~~~~sql
  SELECT empl_id, first_name, e.office_id AS office_id, city
  FROM employees e LEFT OUTER JOIN offices o
  ON e.office_id = o.office_id;
  ~~~~
  * Next is the right outer join. The syntax is the same, except it's RIGHT instead of LEFT. Notice this time that the Singapore office is included in the result set even though none of the employees work there. In a right outer join, non-matching rows from the right table are returned.

  ~~~~sql
  SELECT empl_id, first_name, e.office_id AS office_id, city
  FROM employees e RIGHT OUTER JOIN offices o
  ON e.office_id = o.office_id;
  ~~~~

  * In the result row representing Singapore, the columns that come from the employees table, like empl_id and first_name, are NULL since there's no employee that matches this office. And office_id is also NULL because I used e.office_id in the SELECT list.
  * If I change this to o.office_id, then it's not NULL; It shows the value from the offices table.
  ~~~~sql
  SELECT empl_id, first_name, o.office_id AS office_id, city
  FROM employees e RIGHT OUTER JOIN offices o
  ON e.office_id = o.office_id;
  ~~~~
  * In left and right outer joins, the order of the table references in the FROM clause does matter, because the one and only difference between these two types of outer joins is which table has its non-matching rows included in the result.
  * In fact, right outer joins are very rarely used. Most people prefer to always use left outer joins, and just list the table with the non-matching rows that you want to return on the left side in the FROM clause.
  * The third and final type of outer join is the full outer join. Again, the syntax is the same except you use the keyword FULL. And notice how the rows representing the employee Val and the office in Singapore are included in the result set. In a full outer join, non-matching rows from both tables are returned.

  ~~~~sql
  SELECT empl_id, first_name, o.office_id AS office_id, city
  FROM employees e FULL OUTER JOIN offices o
  ON e.office_id = o.office_id;
  ~~~~
  * In a full outer join, non-matching rows from both tables are returned.

  ## Quize

  * Which FROM clauses could you use to return data about all the customers, even the ones who have not placed any orders? Select all that apply.

~~~~sql
FROM customers c RIGHT OUTER JOIN orders o ON c.cust_id = o.cust_id

Un-selected is correct
FROM customers c RIGHT OUTER JOIN orders o ON c.cust_id = o.cust_id

is not selected.This is correct.

FROM customers c LEFT OUTER JOIN orders o ON c.cust_id = o.cust_id

Correct
Correct. The left table in this case is customers, so the left outer join includes all rows from customers, even if there is no match in orders.

FROM customers c LEFT OUTER JOIN orders o ON c.cust_id = o.cust_id

is selected.This is correct.
Correct. The left table in this case is customers, so the left outer join includes all rows from customers, even if there is no match in orders.


FROM orders o LEFT OUTER JOIN customers c ON o.cust_id = c.cust_id

Un-selected is correct
FROM orders o LEFT OUTER JOIN customers c ON o.cust_id = c.cust_id

is not selected.This is correct.

FROM orders o RIGHT OUTER JOIN customers c ON o.cust_id = c.cust_id

Correct
Correct. The right table in this case is customers, so the right outer join includes all rows from customers, even if there is no match in orders.
~~~~
* By far the most common type of outer join you'll see in the real world is the left outer join. When you're joining two tables together, typically one of them is the main table, the one that represents the items or the units that you're analyzing. Often, you'll want all the rows from that main table to be included in the result, irrespective of whether they have matches in the other table. The most common thing to do in that case is specify the main table on the left side of the join and use a left outer join.
~~~~sql
SELECT city, COUNT(e.empl_id) AS num_employees
FROM offices o LEFT OUTER JOIN employees e
ON o.office_id = e.office_id
GROUP BY city;
~~~~
## Quize
* Which of the following queries returns only the employees whose office IDs do not match any office IDs found in the offices table?

~~~~sql
SELECT empl_id, first_name, last_name

    FROM employees e LEFT OUTER JOIN offices o

        ON e.office_id = o.office_id

    WHERE office_id IS NULL;


SELECT empl_id, first_name, last_name

    FROM offices o LEFT OUTER JOIN employees e

        ON e.office_id = o.office_id

    WHERE e.office_id IS NULL;


SELECT empl_id, first_name, last_name

    FROM offices o LEFT OUTER JOIN employees e

        ON e.office_id = o.office_id

    WHERE o.office_id IS NULL;


SELECT empl_id, first_name, last_name

    FROM employees e LEFT OUTER JOIN offices o

        ON e.office_id = o.office_id

    WHERE o.office_id IS NULL;


SELECT empl_id, first_name, last_name

    FROM employees e LEFT OUTER JOIN offices o

        ON e.office_id = o.office_id

    WHERE e.office_id IS NULL;

~~~~

* Some SQL engines do not support all three types of outer joins. MySQL supports left and right but not full. Some others only support left. Hive, Impala, and PostgreSQL do support all three. Also, many SQL engines allow you to leave off the OUTER keywords. So you can just write LEFT JOIN, or RIGHT JOIN, or FULL JOIN. I prefer to include the OUTER keyword just to be fully explicit about what kind of join it is.
