# Introduction
* In the previous week's lessons, you ran some simple  `SELECT statements`, but you did not yet use the SELECT statement to do `data analysis`.
* You just use it to do some simple data retrieval. Data retrieval is important and it's definitely something you'll do with the SELECT statement, but what the SELECT statement can do goes far beyond just data retrieval.
* Data analysis is when you try to answer questions using the data or you tried to discover things in the data like patterns and outliers.
* Sometimes the term `data mining` is used to refer to the practice of discovering things in the data, but I'll stick to the broader more popular term, data analysis. To do data analysis, you need to do more than just to retrieve data, you also need to `manipulate` or `transform` data in different ways.
* These two terms, to `manipulate and transform`, refer broadly and generically to any operations performed on data.
* I'm not talking about changing the existing data in the tables. I'm talking about reading the existing data from the tables essentially making a copy of it and then manipulating the copy, and returning the manipulated copy as the result.
* So for this entire course, you can consider the data in the tables to be immutable, it cannot be altered or modified in place.
* Throughout this course you will never alter or modify the data in the tables.
* Also, this word manipulate or manipulation has some negative connotations in common use like currency manipulation or psychological manipulation. It can be used to mean falsify or modify unfairly. But in the context of SQL and data analysis, it has no negative connotations, it just means to perform some operations on data to generate a result.
* So typically, the practice of data analysis is prompted by questions or by the need to make decisions that are informed by the data.

# SQL SELECT Building Blocks
  * A `SELECT statement` is made up of one or more clauses.
  * The order in which I'll teach them matches their correct order within a SELECT statement.
  ~~~~sql
  SELECT ...
    FROM ...
    WHERE ...
    GROUP BY ...
    HAVING ...
    ORDER BY ...
    LIMIT ...;
  ~~~~

  * `SELECT` clause:- specifies `what columns` should be returned in your query result.
  * `FROM` clause:- specifies `where` the `data` you are querying should come from.
  * `WHERE` clause:-  `filters` the `rows` of the data based on one or more conditions.
  * `GROUP BY` clause and the `related topic of aggregation`:- can be used to split the data into groups and then reduce each group down to a single value.
  * `HAVING` clause:- which filters the data based on aggregates.
  * `ORDER BY` clause, which sorts or arranges the results of a query.
  * `LIMIT` clause, which controls `how many rows` a query can return.
  * Most of what I'll teach is applicable to any SQL engine; Hive and Impala, other big data SQL engines, and traditional relational database systems.
  * But there are some differences in the SELECT syntax across the dialect of SQL that these different engines use.



# Introduction to the SELECT List
  * A `SELECT` statement begins with the keyword `SELECT`. The part of the statement starting at the beginning with the keywords SELECT and ending before the keyword `FROM` is called the SELECT clause.
  ~~~~sql
  SELECT ... FROM tablename;
  ~~~~
  * Everything that comes after the keyword SELECT in this clause is called the `SELECT list`.
  * In the statement, `SELECT name, year, inventor FROM games`, the `SELECT list` is `name, year, inventor`.
  * It's to specify what columns should be returned in the result set.
  * In a `SELECT list`, the `asterisk` symbol which is universally pronounced `"star"`, has the special meaning `all the columns`.
  * If you want to return some but not all of the columns, then instead of using the star, you use a list of the column names separated by commas.
  * When you do this, then the order of the columns in the results set is determined by the order of the column names in the SELECT list.
  * Always remember that the order of the columns in a result set is deterministic, but the order of the rows is arbitrary.
  * Here are a couple of examples that will not work:
  ~~~sql  
  SELECT *;
  ~~~~
  * with no FROM clause. Star means all the columns, but there is no table for the columns to come from.
  ~~~~sql
  SELECT name, year, inventor;
  ~~~~
  * with no FROM clause. This again will fail because name, year, and inventor are column references, but the source of these columns is not specified.

  * Here are a couple of examples that will work.
  ~~~~sql
  SELECT 42;
  ~~~~
  * This returns a single row and a single column containing the integer number 42. Because 42 is a literal value not a reference to a column in a table, the statement will run successfully in many SQL engines.
  ~~~~sql
  SELECT 'foo', 'bar';
  ~~~~
  * The quoted strings foo and bar here are both literal string values. The statement returns a single row with two columns containing the three character strings, foo and bar.
  * The single quotes around these strings tell the SQL engine to interpret them as literal strings, not column references.
  In both of these examples that have no FROM clause, the resultant has just one row. Whenever you omit the FROM clause, the SQL engine acts like you're querying an imaginary table with one row and no columns.
* You can also mix column references and literal values in the SELECT list. But when you do this, you need a FROM clause to specify what table the columns should come from.
* For example,
~~~~sql
SELECT 'Board Game', name, list_price FROM games;
~~~~

* The single quotes around Board Game mean that it's a literal string, but name and list_price with no quotes around them are both column references.
* The result of this statement has five rows, that's the number of rows in the games table, and it includes the name and list_price columns from the games table.
* It also has the literal string value Board Game in the first column repeated in every row.
* This is what happens when you use literal values in the SELECT list with a FROM clause. The number of rows in the result is controlled by the table in the FROM clause and the literal value is repeated in all these rows.

# Expressions and Operators

* you'll learn how the `select list` can also include `expressions`.
* An `expression` in SQL is a `combination of literal values, column references, operators, and functions`. I'll demonstrate this with a simple example. The games table in the fun database has a column named list_price. Say I wanted to return the names of these games and their list prices, but with a five dollar shipping fee added to the price.

~~~~sql
SELECT name, list_price + 5
  FROM games;
~~~~

* This one uses a function instead of an operator.
~~~~sql
SELECT name, round(list_price)
FROM games;
~~~~

* he round function rounds the decimal numbers to the nearest whole number. So in this case, it rounds each list_price to the nearest dollar, 19.99 rounds to 20, 17.99 rounds to 18, and so on.
* Round is an example of a `built-in function`.
* he plus sign is of course the addition operator. It adds together numeric values.
* In addition to the plus sign, the other common arithmetic operators are the `minus` sign for `subtraction`, the `asterisk` for `multiplication`, the `front slash` for `division`, and the `percent` sign which is the `modulo` operator.
* Plus and minus can both be used as unary operators or binary operators.
* `Unary` means having only one `operand`, or only `one argument`.
* Here's an example of the minus sign being used as a unary operator.
~~~~sql
SELECT name, -list_price
  FROM games;
~~~~
* The minus sign before list_price flips the sign of the numbers in this column, and since all these numbers are positive, they're all changed to negative in the results set.

* There's only one operand in this expression list_price, and the operator, the minus sign comes before it.
* You can also use the plus sign in this way as a unary operator before a numeric operand, but it just returns the numeric column with its sign unchanged.
* All four of the common arithmetic operators can be used as binary operators, meaning that there's an operand on both sides of the operator: the left and right sides.
* So for example, using the games table, you could use any of these expressions:
  * `2 + 5`
  * `max_players - min_players`
  * `list_price /y 2`
  * `1.05 * list_price`
  * `list_price % 1`
  * `These are all valid expressions`.
* In Hive, and Impala, and MySQL, and some other SQL engines, the division operator, the front slash, always performs decimal division.


# Data Types

* Non-numeric operand with arithmetic Operators
  * 'hello' + 5
  * name /2
  * -name
  * inventor * list_price

* None of these expressions will work.
* So using arithmetic operators forces us to think about the datatype of columns and a literal values. Datatypes in SQL is a very rich topic.
* In this course, every column and literal value you'll work with, will fall into two high-level categories of data types, numeric and character.

### numeric
  * Integer Data Types
    * TINYINT: - 128 to 127
    * SMALLINT: - -32, 768 to3 32767
    * INT:- -2147, 483648 to 2147, 483647
    * BIGINT:- -9.2 quintillion to 9.2 quintillion
  * Decimal Data types
    * DECIMAL
    * FLOAT
    * DOUBLE
  * Signed
    * represent postive and negative numbers (and zero)
  * Unsigned
    * represent positive numbers (and zero)
### character
  * STRING
  * CHAR
  * VARCHAR





  *
