# Introduction
  * `SELECT ...FROM tablename; `
  * The 'SELECT' is the required part of the SELECT clause and the FROM clause is required to query actual rows of data from tables.
  * This week is all above the: SELECT...FROM tablename `WHERE..;` .. the WHERE Clause.
  * => `which filters the rows of data based on some specified conditions.`
  * Topic included:
    * WHERE...
      * Boolean Data Types
      * Boolean Expressions
      * Logical Operators
      * conditional Functions

* Objectives
  * Construct query statments that filter results
  * Use comparison Operators, logical Operators, and conditionalfunctions in Expressions
  * Create queries with desired handling of NULL values.

# About the Datasets
  * In this week we are going to query the bigger database, the `wax-a little and larger one`. Then the database in the `fly, which is much larger`.

  ## wax Database:
    * Has one table `crayons`
    * This table describe `120 crayons colors`
    * columns names:  `color, hexadecimal code and its red, green and blue values, which each range between zero and 255. , pack `
## fly Database:
  * 4 tables:
    * airlines
    * airports
    * flights
    * planes
    * see the reading.

# Introduction to the WHERE Clause
~~~~sql
SELECT ... FROM tablename WHERE ...
~~~~
* Filter raw data based on one or more conditions.
* Test which rows meet certain criteria and which one don't
* Has no effect on which columns is return.
* it is optional
* the WHERE Clause is really where you start data analysis.
* It is because you can use it the answer the questions such `in which row is the data analysis is true`.
* each condition are the question asking about the data and the result you get back conatin the answers to that question ready for you to interpret.
* Eg. `Which game has priced below 1 dollar?`



# Using Expressions in the WHERE Clause
* Expressions in `SELECT` list:
  * Becomes column in result
  * Multiple Expressions
  * Different data Types allowed.
* Expressions in `WHERE` list:
  * Filters rows in result
  * Only one expression
  * Expression must be Boolean
* Example
~~~~sql
SELECT name
  FROM fun.games
  WHERE list_price < 10;
~~~~
* It would be nice to see what the list price are:
~~~~sql
SELECT name, list_price
  FROM fun.games
  WHERE list_price < 10;
~~~~

* Another ex. `Which games were invented by Elizabeth Magie?`
~~~~sql
SELECT name
  FROM fun.games
  WHERE inventor = 'Elizabeth Magie';
~~~~
* Which games are suitable for a child age 7?
~~~~sql
SELECT name, min_age
  FROM fun.games
  WHERE min_age <= 7;
~~~~

* Write and run a query on the wax.crayons table to find all the crayon colors with a value for the column red that is less than 110. How many rows are returned?
~~~~sql
SELECT color
  FROM wax.crayons
  WHERE red < 110;
~~~~


# Comparison Operators
  * Binary Operators: `meaning that there's an operand on both sides of the operator, and all of these work across all the major SQL engines. `
    * `=` test for equality.
    * `!=` not equal, test for inequality or `<>`
    * ` <` or `>` typically used with numeric  operators.
    * `<=` or `>=`

* eg. `Which of the following crayon colors have exactly the same red and green values? Use the VM to query the wax.crayons table. Check all that apply`.

~~~~SQL
SELECT color
  FROM wax.crayons
  WHERE red = green
~~~~

* How many of the crayon colors have more blue than red in the R-G-B color model?
~~~~SQL
SELECT color, blue, red
  FROM wax.crayons
  WHERE blue > red;
~~~~


# This doesn't work
~~~~SQL
SELECT color, red + green + blue AS rgb_sum
  FROM wax.crayons
  WHERE rgb > 650;    
~~~~

# This work
  * `The reason is that SQL engines process the WHERE Clause before they compute the expressions in the select list.`
~~~~SQL
SELECT color, red + green + blue AS rgb_sum
  FROM wax.crayons
  WHERE  red + green + blue > 650;    
~~~~


~~~~SQL
SELECT color, red + green + blue > 650 AS light
  FROM wax.crayons;    
~~~~



# Data Types and Precision

* use `round Functions`

~~~~sql
round(1.0/3, 5)
~~~~



# Logical Operators
## AND or OR -are binary logical operators
* you can use what are called `logical operators` to combine multiple smaller boolean expressions or sub-expressions into a single boolean expression
* What if you're looking to buy a game that six people can play and you have $10 to spend on it.

~~~~sql
SELECT * FROM fun.games
  WHERE max_players >= 6 AND list_price <= 10;
~~~~

* What if you're looking for a game to play with no specific number of players in mind but you only have $10 to spend on it.

~~~~sql
SELECT * FROM fun.games
  WHERE max_players <= 10 OR name = 'Monopoly';
~~~~


### Unary logical operator
* NOT
* eg. `Return all the games except Risk. `
~~~~sql
SELECT * FROM fun.games
  WHERE NOT name = 'Risk';
~~~~
* OR
~~~~sql
SELECT * FROM fun.games
    WHERE name != 'Risk';
~~~~


### Order of operations
  * the Order are => `NOT, AND, OR`


* For example, if you want to return all the games except Candy Land and Risk, you might write expressions like these.

~~~~sql
SELECT * FROM fun.games
    WHERE NOT name = 'Candy Lang' AND name = 'Risk';
~~~~

~~~~sql
SELECT * FROM fun.games
    WHERE NOT name = 'Candy Lang' OR name = 'Risk';
~~~~

* => `So both of those statements return results that are not what you're looking for.`
* Here is the correct one.


~~~~sql
SELECT * FROM fun.games
    WHERE NOT name = 'Candy Lang' NOT name = 'Risk';
~~~~

~~~~sql
SELECT * FROM fun.games
    WHERE  name != 'Candy Lang' AND name != 'Risk';
~~~~


* OR

~~~~sql
SELECT * FROM fun.games
    WHERE NOT  (name = 'Candy Lang' OR name = 'Risk');
~~~~

* You're looking to buy a game that's six people can play and you have $10 to spend on it, but you already own Monopoly, so that's an option too.

~~~~sql
SELECT * FROM fun.games
    WHERE list_price <= 10 OR name  = 'Monopoly' AND max_players >= 6 ;
~~~~

* NOT CORRECT

* CORRECT

~~~sql
SELECT * FROM fun.games
    WHERE (list_price <= 10 OR name  = 'Monopoly') AND max_players >= 6 ;
~~~~


# Other Relational Operators
  * `IN` and `BETWEEN` operators
  * The IN operator compares the operand on the left side to a set of operands on the right side. It returns true if the operand on the left matches any value in the set on the right.


  ~~~sql
  SELECT * FROM fun.games
      WHERE name IN ('Monopoly', 'Clue', 'Risk');
  ~~~~

  * The ff give the same result but not more readable.
  ~~~sql
  SELECT * FROM fun.games
      WHERE name = 'Monopoly' OR name= 'Clue' or name= 'Risk');
  ~~~~


  * The `BETWEEN` operator compares the operand on the left side to a lower bound and an upper bound both specified on the right side.
  * Here's an example, this statement filters the games table by the min_age column, returning only the rows in which min_age is greater than or equal to eight and less than or equal to 10.

  ~~~sql
  SELECT * FROM fun.games
      WHERE min_age BETWEEN 8 AND 10;
  ~~~~

  * The BETWEEN operator is typically used with numeric operands like in this example, you can use it with non-numeric operands like character strings, but I would not recommend doing that yet.

  * You could get the same result by using two comparison operators combined with an AND. In this example, it would be min_age greater than or equal to eight AND mean_age less than or equal to 10. But using the BETWEEN operator is typically more concise and more readable.

  ~~~sql
  SELECT * FROM fun.games
      WHERE min_age > 8 AND min_age <= 10;
  ~~~~


  * One case where the BETWEEN operator is useful, is when you want to check a numeric value for approximate equality with some margin of error allowed.

  SELECT 1/3 BETWEEN 0.3332 AND 0.3334;


  * NOT IN: true when no matches exist
  * NOT BETWEEN: true when outside the range.


# Working with Missing Values

## Understanding Missing Values
* For example, if the price of some board game is unknown, then it's impossible to determine whether that price is less than $10. Maybe it's less, maybe it's more, maybe it's exactly $10, you have no way of knowing.
* Life would be easier if you never had to work with missing values. But the reality is that many datasets have them, and as a data analyst, you'll need to handle them properly.
* `In SQL, a null value is a value that's missing or unknown.`
* Tables with NULL Values
  * default: `offices`
  * fun: `inventory`, `card_rank`
* NULL value can meant => `not applicable, unknown, undefined`

* There are many datasets in the real world that have more missing values than non missing values. These are referred to as sparse datasets.
* try writing a query to find this flight in the flights table. It was on January 15th, 2009, the carrier is US, the flight number is 1549, and the origin airport is LGA. After you write and run a query that returns that row, take a look at which column values are missing in this row.
* missing values can make it impossible to determine whether some conditions are true or false.
~~~~sql
SELECT * FROM fun.inventory
WHERE price < 10
~~~~

* This query will return a results including these items with missing values.
* Null constraints can prevent data with null values from being loaded into the database in the first place, but distributed SQL engines like Hive and Impala, do not generally support these constraints.

## Handling Missing Values
* You cannot test for NULL using =, <, >, ...
* The following are not working:
~~~~sql
SELECT * FROM inventory WHERE price = NULL;

SELECT * FROM inventory WHERE price != NULL;
~~~~

* Any value compared to NULL evaluates to null
* Examples:
~~~~sql
5 = NULL  => NULL
5 != NULL => NULL
5 < NULL => NULL
NULL = NULL => NULL
NULL != NULL => NULL
~~~~
* The best way to understand these is to remember that null means some unknown value.


* Use column `IS NULL` to check for NULL values,
* Or use column `IS NOT NULL` to check for non-NULL values.

* Example to return the row with `price = NULL`
~~~~sql
SELECT * FROM fun.inventory WHERE price IS NULL;
~~~~
* When you want the rows where price is not NULL.
~~~~sql
SELECT * FROM fun.inventory WHERE price IS NOT NULL;
~~~~

* Comparisons that accommodate Null
  * ` IS DISTINCT FROM `
  * ` IS NOT DISTINCT FROM `
* See the example:
  * `offices` table has 4 rows representing 4 different offices;
  * What if you want to write a query to filter office not in `Illinois`?
  * You may write:
~~~~sql
SELECT * FROM default.office
WHERE state_province != 'Illinois';
~~~~
* This will exclude the `office in Singapore` which as no state_province.
* This is where the `DISTINCT FROM` is useful.
~~~~sql
SELECT * FROM default.office
WHERE state_province Is DISTINCT FROM 'Illinois';
~~~~
* Seeeee..
~~~~sql
NULL != not-NULL value => NULL
NULL IS DISTINCT FROM non-NULL => true
~~~~

* Negation
~~~~sql
NULL = non-NULL value  => NULL
NULL IS NOT DISTINCT FROM non-NULL => false

NULL = NULL => NULL
NULL IS NOT DISTINCT FROM NULL => true
~~~~

* Short hand operators
`<=>`




## Conditional Functions
* `if`
* Example:
~~~~sql
SELECT shop, game,
  if(price IS NULL, 8.99, price)
  AS correct_price
FROM fun.inventory;
~~~~
* Check each row to test if the price is nULL. If found to be NULL, then replace it with 8.99.
* Anther example:
~~~~sql
SELECT shop, game,
  if(price > 10,
  'high price',
  'low or missing price')
  AS price_catagory
FROM fun.inventory;
~~~~
* If the price is not less than 10, return `high price` and if it is less than 10, return `low or missing price`
* if clause used to return one or two different expression.

* `CASE` takes many arguments
  * Example

~~~~sql
SELECT shop, game, price,
  CASE WHEN price IS NULL THEN
          'missing price'
      WHEN price > 10 THEN
          'high price'
      ELSE 'low price'
  END AS price_catagory
FROM fun.inventory;
~~~~


* `nullif` takes 2 arguments
* example
~~~~sql
SELECT distance / nullif(air_time, 0) * 60 AS avg_speed
FROM fly.flights;
~~~~

* `ifnull`
~~~~sql
SELECT ifnull(air_time, 340)  AS air_tiome-no_nulls
FROM fly.flights
WHERE origin = 'EWR' AND dest = 'SFO';
~~~~
* Replace the null value with `340`

* `coalesce` can take any number of agru   and it return the values of the first argument if it is not null.

* Example
~~~~sql
SELECT coalesce(arr_time, sced_arr_time) AS real_or_sched_arr_time
FROM fly.flights;
~~~~





# Using Variables with Beeline and Impala Shell

## Variable Substitution
### Using `HIVE`
~~~~sql
-- return the list price of the game
SELECT list_price FROM fun.games WHERE name = 'Monopoly';

-- return the prices of the game at game shops
SELECT shop, price FROM fun.games WHERE name = 'Monopoly';
~~~~
* Variable Substitution come in place here.

~~~~sql
-- set a Variable containing the name of the game
SET hivevar:game=Monopoly; --no space after SET
-- return the list price of the game
SELECT list_price FROM fun.games WHERE name = '${hivevar:game}';
-- return the prices of the game at game shops
SELECT shop, price FROM fun.games WHERE name = 'Monopoly';

~~~~
* `beeline -u .... -f game_prices.sql`
* Then when you execute the statements in the SQL file using the Beeline command with the dash f option. Hive replaces each instance of this dollar sign curly brace hivevar placeholder with the value that's assigned to the variable. In other words, it substitutes the assigned value in each of these places.


* When you have a sql statment in a file but you want to run it many times;

* `hex_color.sql`
~~~~sql
SELECT hex FROM wax.crayons WHERE color = 'Red';
~~~~
* If you want the run this same query with different color, it will be cumbersome.
~~~~sql
SELECT hex FROM wax.crayons WHERE color = 'Orange';

SELECT hex FROM wax.crayons WHERE color = 'Yellow';

SELECT hex FROM wax.crayons WHERE color = 'Green';
~~~~

* Use variable Substitution:

~~~~sql
SELECT hex FROM wax.crayons WHERE color = '${hivevar:color}';
~~~~
* Then, use commend line argument:
~~~~sql
beeline -u ...  --hivevar color="Red" -f hex_color.sql

beeline -u ...  --hivevar color="Orange" -f hex_color.sql

beeline -u ...  --hivevar color="Yellow" -f hex_color.sql
~~~~


* You can also use different variables
~~~~sql
SELECT color FROM wax.crayons
  WHERE red = ${hivevar:red} AND
        green = ${hivevar:green} AND
        blue = ${hivevar:blue};
~~~~
~~~~sql
beeline -u ... --hivevar red="238" \
              --hivevar green="32" \
             --hivevar blue="77" \
              -f color_from_rgb.sql    
~~~~


* With Impala sheel --- use var

~~~~sql
SELECT hex FROM wax.crayons WHERE color = '${var:color}';
~~~~

~~~~sql
impala-sheel --var color="Purple Mountains\' Majesty"/
-f hex_color.sql
~~~~


Which commands correctly pass a string parameter called month to a Beeline or Impala Shell query that runs the file report.sql? (Assume the variable is appropriately defined in report.sql.) Check all that apply.

~~~~sql
$ beeline -u jdbc:hive2://localhost:10000  --var month="January" -f report.sql

Un-selected is correct

$ impala-shell  --var month="January" -f report.sql

Correct
Correct. This will run the file using "January" in place of the parameter month.


$ impala-shell  -v month="January" -f report.sql

Un-selected is correct

$ beeline -u jdbc:hive2://localhost:10000  -h month="January" -f report.sql

Un-selected is correct

$ impala-shell  --impalavar month="January" -f report.sql

Un-selected is correct

$ beeline -u jdbc:hive2://localhost:10000  --hivevar month="January" -f report.sql

Correct
Correct. This will run the file using "January" in place of the parameter month.
~~~~


# Calling Beeline and Impala Shell from Scripts
* shell Scripts sometimes callled `BASH SCRIPT`




#!/bin/bash
impala-shell \
--quiet \
--delimited \
--output_delimiter=','\
--print_header \
-q 'SELECT * FROM fly.flights
WHERE air_time =0;' \
-o zero_air_time.csv
mail \
-a zero_air_time.csv \
-s 'flights with zero air_time' \
'Do you know why zero_air_time is zero in these rows?'


* Then use:
`chmod 755 email_results.sh` at commend line
* You can execute a shell script
  * At the command line
  `/.email_results.sh`

  * Using a scheduler
  * From another script or application
    * in Python
     import subprocess
     subprocess.call(['./email_results.sh'])

* To try this on the VM:
  * Create email_results.sh, replacing the email address with your own
  * Run the chmod command
  * Run the script
    Note: whether the email is sent depends ou your configurations.

* When invoking commands in a script:
  * Enter the commands as you would in the command line
  -whether for Beeline or Impala shell
  * Use Linux commands to process results.


  # Book to read.
  Shell Scripting
  bash
  bask pocket reference

  grep
  sed & awk



  Which will properly use either Beeline or Impala Shell to run a SQL query from within a shell script? Check all that apply.


$ beeline -u jdbc:hive2://localhost:10000 -s 'SELECT * FROM db.table_name'

Un-selected is correct

$ impala-shell -f 'SELECT * FROM db.table_name'

Un-selected is correct

$ beeline -u jdbc:hive2://localhost:10000 -f 'SELECT * FROM db.table_name'

Un-selected is correct

$ beeline -u jdbc:hive2://localhost:10000 -e 'SELECT * FROM db.table_name'

Correct
Correct. To run the query from within a shell script, use the same command as you would from the command line. For Beeline, use the -e option.


$ impala-shell -q 'SELECT * FROM db.table_name'

Correct
Correct. To run the query from within a shell script, use the same command as you would from the command line. For Impala Shell, use the -q option.


$ impala-shell -s 'SELECT * FROM db.table_name'

Un-selected is correct



Suppose that, as you are working, you need to run a bash script query_script.sh with a SQL query in it. (That is, you want to run it now, not schedule it for later.) You have never run this script before. Which of the following is necessary to run the script? Check all that apply. (Note that the order provided might not match the order in which you need to proceed.)


Run the script from the command line using $ ./query_script.sh (assuming it is in your current directory)

Correct
Correct. This is the command to run a bash script.


Run the script from the Impala Shell or Beeline shell using BASH query_script.sh; (assuming it is in your current directory)

Un-selected is correct

Give permission to the script using chmod

Correct
Correct. All bash scripts (with or without SQL commands) must have permission to execute. The chmod command can provide that permission.


Use the root or superuser privileges when issuing the run command, so the script has permissions to run

Un-selected is correct

Run the script from the Impala Shell or Beeline shell using RUN query_script.sh; (assuming it is in your current directory)

Un-selected is correct

Run the script from the command line using $ bash query_script.sh (assuming it is in your current directory)

Un-selected is correct
