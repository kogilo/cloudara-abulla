# Introduction
* Clauses previously covered:
  - SELECT :-`specifies what columns should be returned to your query result. `
  - FROM :- `specifies where the data you're querying should come from.`
  - WHERE:- `filters the individual rows of data based on some conditions.`
  - GROUP BY:- `splits data into groups`
  - HAVING : - `filters the data based on aggregates`

* Two more Clauses in this week:
  - ORDER BY
  - LIMIT
  - `These clauses enable you to control the arrangement and number of the rows in a result set`

## Introduction to the ORDER BY Clause
* The order by clause takes the result from all the earlier clauses, select, from, where, and to group by, and it arranges those rows, sorts them in a specific order before returning them to you.
* Eg. Order the result set by id:
~~~~sql
SELECT * FROM games ORDER BY id;
~~~~
* by list_price
~~~~sql
SELECT * FROM games ORDER BY list_price;
~~~~

~~~~sql
SELECT * FROM games ORDER BY max_players;
~~~~

## QUIZ

* Which games might be in the second row of the result set returned by running the query below? Check all that apply. 
  ~~~~sql
  SELECT * FROM games ORDER BY min_age;
  ~~~~

`
Scrabble

Correct
Correct. Candy Land has the lowest min_age (3) so it is returned in the first row. The next lowest min_age is 8, which is the min_age for Scrabble, so it could be in the second row. (Others with the same min_age might also be in that row. Because the value of the ordering column is tied, the sequence of those rows in the result set is arbitrary.)

Scrabble

is selected.This is correct.
Correct. Candy Land has the lowest min_age (3) so it is returned in the first row. The next lowest min_age is 8, which is the min_age for Scrabble, so it could be in the second row. (Others with the same min_age might also be in that row. Because the value of the ordering column is tied, the sequence of those rows in the result set is arbitrary.)


Candy Land

Un-selected is correct
Candy Land

is not selected.This is correct.

Monopoly

Correct
Correct. Candy Land has the lowest min_age (3) so it is returned in the first row. The next lowest min_age is 8, which is the min_age for Monopoly, so it could be in the second row. (Others with the same min_age might also be in that row. Because the value of the ordering column is tied, the sequence of those rows in the result set is arbitrary.)

Monopoly

is selected.This is correct.
Correct. Candy Land has the lowest min_age (3) so it is returned in the first row. The next lowest min_age is 8, which is the min_age for Monopoly, so it could be in the second row. (Others with the same min_age might also be in that row. Because the value of the ordering column is tied, the sequence of those rows in the result set is arbitrary.)


Risk

Un-selected is correct
Risk

is not selected.This is correct.

Clue

Correct
Correct. Candy Land has the lowest min_age (3) so it is returned in the first row. The next lowest min_age is 8, which is the min_age for Clue, so it could be in the second row. (Others with the same min_age might also be in that row. Because the value of the ordering column is tied, the sequence of those rows in the result set is arbitrary.)
`

* You can include more than one column in the ORDER BY clause:

~~~~sql
SELECT * FROM games ORDER BY max_players, list_price;
~~~~


* With some other clauses;
~~~~sql
SELECT shop, SUM(qty) FROM inventory
      WHERE price IS NOT NULL
      GROUP BY shop
      ORDER BY shop;
~~~~

## Controlling Sort Order
* Ascending - returned by default.=> from `smallest` to the `largest`
~~~~sql
SELECT * FROM games ORDER BY list_price;
--the cheapest will be at the top
~~~~
* Descending - from `Z to A`

~~~~sql
SELECT * FROM games ORDER BY list_price DESC;
--the most expensive product will be at the top
~~~~
* You can also use the keyword `ASC`. But since it  happen by default, it will hac=ve no no impact.
~~~~sql
SELECT * FROM games ORDER BY list_price ASC;
--the most expensive product will be at the top
~~~~


## Quiz
* Select all the statements that return the same result as `SELECT * FROM crayons ORDER BY red`; If you are uncertain of your answers, run the queries to check.

~~~~sql
SELECT * FROM crayons ORDER BY -red DESC;
SELECT * FROM crayons ORDER BY red ASC;
~~~~

* When order by multiple columns, you need to specify:
~~~~sql
SELECT name, max_players, list_price FROM games
    ORDER BY max_players DESC, list_price ASC;
    --Here `ASC` is included just for clearity.
~~~~

## QUIZ
* Run the following query with Impala and use the result set to answer the question below:
~~~~sql
SELECT * FROM wax.crayons ORDER BY pack DESC, red DESC, green ASC;
~~~~
* In the result set, which crayon color is represented in the second row from the top?
  - `C​anary`
## Ordering Expressions

* The following expression compute the saturation of the colors:

~~~~sql
SELECT *
  FROM crayon
  ORDER BY (greatest(red, green, blue) - least(red, green, blue))/
            greatest(red, green, blue) DESC;
~~~~

* OR use the `aliase`

~~~~sql
SELECT  (greatest(red, green, blue) - least(red, green, blue))/
          greatest(red, green, blue) AS saturation
  FROM crayon
  ORDER BY saturation DESC;
~~~~

### QUIZ
* Write and run a SQL query to determine which color in the crayons table has the lowest saturation value, excluding Black and White. The expression to compute saturation is

(greatest(red, green, blue) - least(red, green, blue)) / greatest(red, green, blue)

~~~~sql
SELECT color, (greatest(red, green, blue) - least(red, green, blue))/
          greatest(red, green, blue) AS saturation
  FROM crayon
  ORDER BY saturation ASC;
~~~~
* Timberwolf


# Reading

https://www.coursera.org/learn/cloudera-big-data-analysis-sql-queries/supplement/gcKn6/ordering-by-string-columns

## Missing Values in Ordered Results

* For ~`Impala` and `PostgreSQL` `NULL` values is sorted as the highest values.
* Example:
~~~~sql
SELECT shop, game, price
  FROM inventory
  ORDER BY price;
  --NULL value is at the bottom
~~~~

~~~~sql
SELECT shop, game, price
  FROM inventory
  ORDER BY price DESC;
  --NULL value is at the top
~~~~

* But `HIVE and MYSQL` do the opposite.
~~~~sql
SELECT shop, game, price
  FROM inventory
  ORDER BY price;
  --NULL value is at the Top
~~~~


~~~~sql
SELECT shop, game, price
  FROM inventory
  ORDER BY price DESC;
  --NULL value is at the bottom

~~~

* `NULLS FIRST` or `NULLS LAST`

~~~~sql
SELECT shop, game, price
  FROM inventory
  ORDER BY price NULLS FIRST;
  --NULL value is at the bottom

~~~

* For more columns

~~~~sql
SELECT shop, game, aisle, price
  FROM inventory
  ORDER BY aisle DESC NULLS LAST, price ASC NULLS FIRST;
~~~
* HIVE and MYSQL do not support the above.
~~~~sql
SELECT shop, game, price
    FROM inventory
    ORDER BY price IS NULL ASC, price;

~~~~

* OR `remove the rows that contain the NULL values`

* But this may cause you to lost meaningful part of the data.

# Using ORDER BY with Hive and Impala
* `HIVE Limitations`
  - With HIVE, the columns used in the ORDER BY clause must be included in the result set.
  - eg. the follwing is not working:

  ~~~~sql
  SELECT shop, game FROM inventory ORDER BY price;
  --b/c price is not incuded in the SELECT list
  ~~~~
  * Now corrected.
  ~~~~sql
  SELECT shop, game, price FROM inventory ORDER BY price;
  --b/c price is not incuded in the SELECT list
  --OR
  SELECT * FROM inventory ORDER BY price;
  ~~~~

  * With expression, is not working also
  ~~~~sql
  SELECT shop, game FROM inventory ORDER BY qty * price;

  ~~~~

  * Now corrected:

  ~~~~sql
  SELECT shop, game, qty, price FROM inventory ORDER BY qty * price;
  --OR
  SELECT * FROM inventory ORDER BY qty * price;
  ~~~~

  * OR using alias

  ~~~~sql
  SELECT shop, game, qty * price AS qty_time_price FROM inventory ORDER BY qty_time_price;
  ~~~~


  ## Shortcut in Impala

  ~~~~sql
  SELECT shop, game, price FROM inventory ORDER BY 3; --to order by price.
  ~~~~

# Introduction to the LIMIT Clause
* To limit the row:
~~~~sql
SELECT * FROM flights LIMIT 5;
~~~~

* The follwing finds the carriers, the airlines that have at least 5,000 flights with an air time of seven hours or longer and the limit clause limits the results to 10 rows. But notice that the results set has only four rows.

~~~~sql
SELECT carrier, COUNT(*)
      FROM flights
      WHERE air_time >= 7 * 60
      GROUP BY carrier
      HAVING COUNT(*) > 5000
      LIMIT 10;
~~~~

* The LIMIT clause should come after all the other clauses.
* `LIMIT non-negative integer literal`

* Select the valid SQL queries. Check all that apply.


SELECT month, AVG(dep_delay) AS avg_dep_delay  FROM flights

    WHERE origin = 'SFO'

    LIMIT 100

    GROUP BY month

    HAVING avg_dep_delay > 15;


SELECT month, AVG(dep_delay) AS avg_dep_delay  FROM flights

    LIMIT 1000

    WHERE origin = 'SFO'

    GROUP BY month

    HAVING avg_dep_delay > 15;


SELECT month, AVG(dep_delay) AS avg_dep_delay  FROM flights

    WHERE origin = 'SFO'

    GROUP BY month

    HAVING avg_dep_delay > 15

    LIMIT -10000;


SELECT month, AVG(dep_delay) AS avg_dep_delay, 10 AS row_limit  FROM flights

    WHERE origin = 'SFO'

    GROUP BY month

    HAVING avg_dep_delay > 15

    LIMIT row_limit;


SELECT month, AVG(dep_delay) AS avg_dep_delay  FROM flights

    WHERE origin = 'SFO'

    GROUP BY month

    HAVING avg_dep_delay > 15

    LIMIT 1;

# When to Use the LIMIT Clause
* When you want to look the dataset.
~~~~sql
SELECT * FROM flights lIMIT 5;
~~~~
* when you have written a SELECT statement but you don't know how many rows will return and you don't want all of the rows to be returned.
~~~~sql
SELECT * FROM flights lIMIT 5;
~~~~

* Say, you're using a BI or Data Visualization Tool, and you want to use it to draw a map showing all the routes represented in the flights table, all the origin and destination pairs with lines connecting them, and you want the lines to vary in thickness based on how many flights flew on that route.
~~~~sql
SELECT origin, dest, COUNT(*) AS num_flights
      FROM flights
      GROUP BY origin, dest
      lIMIT 1000;
~~~~

~~~~sql
SELECT origin, dest, COUNT(*) AS num_flights
      FROM flights
      GROUP BY origin, dest
      HAVING num_flights >= 20000
      lIMIT 1000;
~~~~

* LIMIT also reduce the load your are putting in SQL engine.

* NB. LIMIT - Rows picked arbitraily

## Quiz
* Select the appropriate uses for the LIMIT clause. Check all that apply:


Reduce the compute resources used by the SQL engine

Correct
Correct. Limiting the output can also reduce the amount of resources needed.

Reduce the compute resources used by the SQL engine

is selected.This is correct.
Correct. Limiting the output can also reduce the amount of resources needed.


Protect against returning an unexpectedly large number of rows

Correct
Correct. When you are unsure how many rows you'll be returning, and there's a possibility of getting more than you want (such as when you're outputting to your terminal screen), using LIMIT provides some safety.

Protect against returning an unexpectedly large number of rows

is selected.This is correct.
Correct. When you are unsure how many rows you'll be returning, and there's a possibility of getting more than you want (such as when you're outputting to your terminal screen), using LIMIT provides some safety.


Return a few rows from a table to inspect some of the values

Correct
Correct. Using LIMIT is a good way to inspect a few rows' worth of values from a table.

Return a few rows from a table to inspect some of the values

is selected.This is correct.
Correct. Using LIMIT is a good way to inspect a few rows' worth of values from a table.


Randomly sample from a large table

Un-selected is correct
Randomly sample from a large table

is not selected.This is correct.

Filter individual rows based on conditions

Un-selected is correct  




# Using LIMIT with ORDER BY

* Who are the one hundred highest-spending customers?
* Who are the ten lowest-performing salespeople?

* Here's an example of this. Here's a query that returns the ten routes in the flights table that have the longest average air time.
~~~~sql
SELECT origin, dest,
      AVG(air_time) AS count_air_time
    FROM flights
    GROUP BY origin, dest
    ORDER BY avg_air_time DESC NULLS LAST
    LIMIT 10;
~~~~
* This query is called `TOP-N QUERY`
* Or it might be called `BOTTOM-N QUERY`
*

## Quiz
* Now, write and run a new query with Impala that displays only the two combinations of airline (carrier) and airport (origin) had the quickest flights (smallest average air_time) from New York City to Honolulu. The three New York City airports are EWR, JFK, and LGA. Honolulu airport is HNL.

Select the two correct answers:


American (AA) flights from LaGuardia (LGA)


Continental (CO) flights from Newark (EWR)


Delta (DL) flights from Newark (EWR)


Delta (DL) flights from Kennedy (JFK)


Hawaiian (HL) flights from Kennedy (JFK)


United (UA) flights from Newark (EWR)



* Now, write and run a new query with Impala that displays only the two combinations of airline (carrier) and airport (origin) had the quickest flights (smallest average air_time) from New York City to Honolulu. The three New York City airports are EWR, JFK, and LGA. Honolulu airport is HNL.

Select the two correct answers:


American (AA) flights from LaGuardia (LGA)


Continental (CO) flights from Newark (EWR)


Delta (DL) flights from Newark (EWR)


Delta (DL) flights from Kennedy (JFK)


Hawaiian (HL) flights from Kennedy (JFK)


United (UA) flights from Newark (EWR)



* Top three highest-performing salespeople

~~~~sql
SELECT salesperson, SUM(amount) as total_sales
    FROM sales
    WHERE year = 2018
    GROUP BY salesperson
    ORDER BY total_sales DESC
    LIMIT 3;
~~~~

* But see the problem:
~~~~sql
SELECT salesperson, SUM(amount) as total_sales
    FROM sales
    WHERE year = 2018
    GROUP BY salesperson
    ORDER BY total_sales DESC
    LIMIT 5;
~~~~

* The example in this video showed that the routes in the flights table that have the longest average air time are the ones from the New York City airports to Honolulu. The query used in that example was
~~~~sql
SELECT origin, dest,

​    ​    AVG(air_time) AS avg_air_time,

​    ​    COUNT(air_time) AS count_air_time

​    FROM flights

​    GROUP BY origin, dest

​    ORDER BY avg_air_time DESC NULLS LAST

​    LIMIT 10;
~~~~


# Using LIMIT for Pagination
* limit           offset
  100              0
  100              100
  100              200

  * LIMIT limit
    - Impala, postgresQL: `LIMIT limit OFFSET offset`
    - Newer version of Hive: `LiMIT offset, limit`

    - MySQL supports both syntaxes

* Which clause should you use with Impala to return rows 151 through 200 of a result set?


LIMIT 151,200


LIMIT 50 OFFSET 150


LIMIT 50 OFFSET 151


OFFSET 151 LIMIT 200


LIMIT 200 OFFSET 50


OFFSET 151,200

* Without ORDER BY, order is arbitrary and unpredicatble
* Pagination then might duplicate or miss rows
Solution: Always use ORDER BY to arrange rows for pagination.
* Impala and some others require ORDER BY when using LIMIT and OFFSET
* some SQL engines do not require it.

### Quiz
* Which of the following pairs of Impala queries is the best choice for paginating the rows of the crayons table into two pages with 60 row 2s each?


SELECT * FROM crayons ORDER BY pack LIMIT 60 OFFSET 0;

SELECT * FROM crayons ORDER BY pack LIMIT 60 OFFSET 60;


SELECT * FROM crayons LIMIT 60 OFFSET 0 ORDER BY color;

SELECT * FROM crayons LIMIT 60 OFFSET 60 ORDER BY color;


SELECT * FROM crayons LIMIT 60 OFFSET 0;

SELECT * FROM crayons LIMIT 60 OFFSET 60;


SELECT * FROM crayons ORDER BY color LIMIT 60 OFFSET 0;

SELECT * FROM crayons ORDER BY color LIMIT 60 OFFSET 0;

`SELECT * FROM crayons ORDER BY color LIMIT 60 OFFSET 60;`

Correct
Correct. The values in the color column are unique, so the ordering is completely determined by using that column in the ORDER BY clause; and the LIMIT clause must come after the ORDER BY clause.

# Review
* Syntatic Order
  * SELECT
  * FROM
  * WHERE
  * GROUP BY
  * HAVING
  * ORDER BY  
  * LIMIT
* So what a SQL engine does when it runs a select statement is, first, it executes the from clause, which tells it which table the data should come from. It reads the data from that table, and if there's a where clause it uses the conditions specified there to filter the individual rows of data as it reads them in. Then once it's done reading the data in, if there's a group by clause, the SQL engine uses the grouping columns specified there to split the data into groups. Next, if there's a having clause, it computes the aggregate expressions there and uses those to filter the groups. Only then does the select list get executed to create the columns that will be returned in the results set. Next, if there's an order by clause, the SQL engine uses the columns specified there to arrange the rows of the result set. Finally, if there's a limit clause, the SQL engine uses that to specify the maximum number of rows that can be returned.



# Honor
## How to Effectively Use the Hive and Impala Documentation
* There are two way to learn Documentation: `bad way` and   `good way`.
* The `bad way` is `opening the documentation and try to browse over all the things to learn`. This is bad way for many people.
* This is because you will be overwhelmed by the resources you are reading.
* The `good way` to use the documentation is as a reference.
* You need to search for keyword. eg. `ADD_MONTHS`

# Tips for Using the Hive Documentation
* go to : `https://hive.apache.org/`
* click : `Language Manual`
* All the topic relevent to this course can be found under the `Select`.
* Click the link under `Data Retrieval: Queries`
* Under this page there are important links like  `join and union` and `operation`
* Click on `LanguageManual UDF`. This is the must used place.


### Quiz

* Which of these functions can be used to find the day of the week from a timestamp value? Consult the Hive Language Manual to help you answer this.
  * `extract`
* `Correct. You can use extract(dayofweek from timestamp) to get a number for the day of the week (with 1 meaning Sunday).`

# Tips for Using the Impala Documentation
* Go to `Impala SQL Language Reference`
* click `SQL statments`
* Click the link for `SELECT`
* Using search engine
. eg Go to google and write ' impala CASE expression'
* Click the first result
* Modify the url: replace the 5-4.x with `latest` or the number for the version you want.
