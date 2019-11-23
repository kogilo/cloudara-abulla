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
