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

# Column Aliases
  * use to show to control the names of the columns in result sets.
  * So `Impala` names `literal` value columns using the literal value itself.
  ~~~~sql
  SELECT name, 5, list_price FROM games;
  ~~~~
  * Now  modify the select list to change the column reference list price into an expression, `list price plus five`.
  ~~~~sql
  SELECT name, 5, list_price + 5 FROM games;
  ~~~~
  * Impala names the columns generated by an expression using the expression.
  * The behavior of Hive though is different.
  * Go to Hive editor and paste the above and make sure that fun database is active:
  ~~~~sql
  SELECT name, 5, list_price + 5 FROM games;
  ~~~~
  * Hive gives names to unnamed columns in a different way. It names them underscore c1, then a number indicating which column it is. The leftmost column is zero, the next one is one and so on.
* try also:
~~~~sql
SELECT 5, name,  list_price + 5 FROM games;
~~~~
* Fortunately, there is a way to control the names of the columns in a result set. You can do this in a select statement by using Column `Aliases`.

* I'll return to the Impala Query Editor, and recall the previous query from the Query History. After the literal value five in the select list, I'll add space AS space shipping_fee. After the expression list price plus five, I'll add space AS space price_with_shipping, and I'll execute the query. Now, the names of the columns in the results set are these names I specified in the select list.

~~~~sql
SELECT name, 5, AS shipping_fee, list_price + 5 AS price_with_shipping FROM games;
~~~~

* You can also use column aliases with column references. The first column here name, already has a name, but I can use a column alias to give it a different name in the results set. In the select list after name, I'll add space AS space game_name.

~~~~sql
SELECT name AS game_name, 5, AS shipping_fee, list_price + 5 AS price_with_shipping FROM games;
~~~~

* With most SQL engines, the AS keyword before a column alias is optional. So I can remove the AS before each alias and execute the query again and it succeeds and gives the same result.

~~~~sql
SELECT name  game_name, 5,  shipping_fee, list_price + 5 price_with_shipping FROM games;
~~~~

* But using the AS keyword helps make select statements more easily readable.
* now, you can just remember a few simple rules.
  * You should use only letters, digits, and underscores in column aliases.
  * You should not use only digits.
  * you should not use words that have special meaning in SQL as the aliases.
  * For instance, you should not use the word `select` as a column alias.

# Built-In Functions
  * `round function`
    * rounds decimal numbers to the nearest whole number. I
    ~~~~sql
    SELECT name, round(list_price)
      FROM games;
    ~~~~
* Representation:
  * `function_name(argument)`
  * eg. `round(list_price)`
* Function names in SQL are typically not case sensitive, and by convention we write them in all lowercase.
* The round function is just one of many functions in SQL. Functions like round are often called built-in functions because they're built right into the SQL engine.
* When you use the round function with just one argument, then it rounds to the nearest whole number, to the nearest integer. So round 19.37 returns 19.
~~~~sql
SELECT round(19.37);
~~~~
* But you can also use the round function with two arguments. The second one specifies how many decimal places to round to.

~~~~sql
SELECT round(19.37, 1);
~~~~
* In addition to round, there are two related functions, `floor` and `ceil` for ceiling.
* Floor rounds `down to the nearest integer value` and ceil rounds `up to the nearest integer value`.
* So for example, ceil 19.37 returns 20, taking the ceiling of 19 point anything will return 20, and taking the floor of 19 point anything will return 19.
~~~~sql
ceil(19.37)
~~~~

~~~~sql
floor(19.37)
~~~~

* Another note about the round function. With positive numbers, if the number you're rounding is exactly in the middle, equally far from the rounded value above and the one below, then the round function will round to the one above.

* For example, 4.5 which is right in the middle between four and five, rounds to five.
~~~~sql
round(4.5)
~~~~

* But with negative numbers, it will round to the one below.
* For example, negative 4.5 rounds to negative five.
~~~~sql
round(-4.5)
~~~~
* Two other common mathematical functions are `ABS` and `SQRT`. ABS returns the `absolute value` of a number, SQRT returns the `square root` of a number. Both of these take just `one argument`.

* There is also the `pow` or power function, which returns the `first argument raised` to the `power of the second argument`.

~~~~sql
pow(x, y)
~~~~

* Raising a number to a power is also called exponentiation.

* Hive and Impala and many other SQL dialects, do not have an exponentiation operator. Instead, you use the pow or power function for exponentiation.
* The rand or random function, returns a pseudo-random decimal number between zero and one.
~~~~sql
0<= rand()<1
~~~~

* For example, to get a pseudo-random integer between one and 10, you could write an expression that takes the ceiling of rand times 10.
~~~~sql
ceil(rand() * 10)
~~~~

* There are many more mathematical functions including trigonometric and logarithmic functions.
* There are also other types of built-in functions, like string functions for working with character strings. See the reading to learn about those. Also, notice that the built-in functions I've talked about so far, return a column with the same number of rows as the table you're querying from. In other words, they do not reshape the data.

* There are many string functions available for use in SQL statements. These are useful for working with text or character string data types.
* length(str)
This returns an integer value equal to the number of characters in the string argument `str`.
#### Notes:

* The name of this function is different, depending on the SQL engine you're using. For example, some engines use `len(str)`  or `char_len(str)`. (The other functions described below have the same name across all the major SQL engines.)
* For Apache Hive and Apache Impala, use the `length` function; it works as described here.

* Examples:
~~~~sql
length('Common String Functions')
length(' Common String Functions ')
length('') = 0
~~~~

* reverse(str)
This returns the characters within the string argument str, but in the reverse order. Try it with your favorite palindrome!

* Examples:
~~~~sql
reverse('Common String Functions') = 'snoitcnuF gnirtS nommoC'

reverse('never odd or even') = 'neve ro ddo reven'
~~~~

* upper(str), lower(str)
  * These return the string str but with all characters converted either to uppercase or lowercase. These can be useful for doing case-insensitive string comparisons (by converting the string to be compared to one case, for example, WHERE upper(fname) = 'BOB' or WHERE lower(fname) = 'bob').

  Examples:

  * upper('Common String Functions') = 'COMMON STRING FUNCTIONS'

  * lower('Common String Functions') = 'common string functions'




# Data Type Conversion

* In some cases, you might need to convert one type of data to another, so you can apply an operator or function.
* For example, you might have some numeric values and some string values that you want to concatenate together into strings, or you might have a string column whose values actually represent numbers.
* Converting one data type to another is called type `conversion` or `casting`.
* Some SQL engines do most type conversions automatically, this is called `implicit casting`.
* Other engines require you to do type conversion manually, this is called `explicit casting`.
* The games table in the fun database has information about five board games including, the name of the game in the name column, and the minimum player age in the min age column. Say you want to concatenate these two columns together along with some literal string values to create a sentence like, blank game is more players age blank or older. You can do this with an expression like this using the concat function.
~~~~sql
SELECT concat(name, 'is for players age', min_age, 'or older')
~~~~
* But the concat function expects all its arguments to have a string data type, and the min age column has an integer data type. Some SQL engines including HIV will implicitly cast min age as a string column.
* Some SQL engines including HIV will implicitly cast min age as a string column. The query will run successfully and will return the expected results. But with other SQL engines including Impala, this query will fail. With engines like that, you need to modify the SQL statement to explicitly cast min_age as a string column.
* With engines like that, you need to modify the SQL statement to explicitly cast min_age as a string column.
* To do this, you use the cast function.

~~~~sql
SELECT concat(name, 'is for players age', cast(min_age AS STRING), 'or older');
~~~~

* Here's another example. In the games table there's a column named year, representing the year that each game was invented. The values in the year column are all four digit years, but it's actually a string of column. You can see this by looking at the column information a queue or by running the utility statement to describe games.

* Say you wanted to add some number to each of the years in the year column. For that, the column would need to be converted to a numeric type. Since the years are whole numbers, it would be the integer type. If you're using a SQL engine like Impala that requires explicit casting, then you can do this by changing the column reference year to cast year AS INT.

~~~~sql
SELECT cast(year AS INT);
~~~~

* The explicit casting syntax described in this video, works in HIV, Impala, and many other SQL engines. Some other engines support different syntax, for instance, there's a function named convert in some SQL dialects. So if this cast value as type syntax doesn't work with a specific engineer using, search for how to convert datatypes with that engine.

* It's a good practice to use explicit type conversion even if the SQL engine you're using can do it implicitly.


# The DISTINCT Keyword
* Distinct is a keyword you can insert right after the keyword select to modify what the select statement does.
* The distinct keyword makes this select statement, omit, duplicate rows from the results set.
~~~~sql
SELECT DISTINCT min_age FROM games;
~~~~
* This returns the distinct values, the unique values of the min_age column.
* You can also use distinct with two or more column references like in this example. SELECT DISTINCT min_age, max_players FROM games.
~~~~sql
SELECT DISTINCT min_age, max_players FROM games;
~~~~

* You can also use distinct with a select star query that returns all the columns.

~~~~sql
SELECT DISTINCT * FROM games;
~~~~
* This returns all the distinct full rows. This is useful for deduplicating the data in a table.
* If you know that there might be erroneous duplicate rows in a table, then you can run this statement, SELECT DISTINCT * FROM that table to return a result set that has any duplicates removed
* You can also use the distinct keyword with expressions in the select list, just the same way as you can use it with column references. For example, say you wanted to find the distinct decades when the games in the games table were invented.
* So to get all the distinct decades from the games table, you would use this statement shown here, SELECT DISTINCT concat substring of years starting at position one with length three and zero S FROM games.

~~~~sql
SELECT DISTINCT
  concat(substring(year, 1, 3), "0s")
  FROM games;
~~~~

* You cannot generally use the distinct keyword more than once in a select statement. It generally has to come right after the keyword, SELECT.

* Also a lesser known fact in SQL, the opposite of distinct is all. In fact, with most SQL engines you can use the keyword, ALL right after the keyword SELECT, but you don't need to because all is the default modifier of select. Selecting all the rows is what we've been doing all along, so it's unusual to explicitly include the keyword all after "Select".


# Introduction to the FROM Clause
* The FROM clause specifies which table the data you're querying should come from.
* the basic syntax of the form clause is very simple. It's just from table reference.

~~~~sql
FROM table_reference;
~~~~

* The current database needs to be the one that contains the table you're querying.
* So if you're querying a table in one of the non defaults databases, you need to remember first to connect to that database. Or to switch into that database by using the active database selector in ue or by running a ue's statement if you’re in a command line sequel interface. It's easy to forget to do this. You might have already stumbled on this when attempting to run queries in the VM.
* Or worse than that, you might forget to switch into the intended database, and the current database might have a table with the same name as the one you intended to be in. In that case, you might get a more cryptic error, or your query might succeed, but you'd be querying a completely different table than the one you thought you were querying. This has happened to me and caused me a lot of confusion.

* Fortunately there is a way to avoid this. Instead of using just the table name in the FROM clause, you can qualify the table name with the database name.
* The syntax for this is FROM databasename.tablename. For example, FROM fun.games.

~~~~sql

  FROM databasename.tablename;
~~~~

~~~~sql
* eg.
  FROM fun.games;
~~~~

# Identifiers
* The database names and table names you use in the FROM clause are types of identifiers. The column reference is used in the select list are also identifiers.
* There are some rules governing what is a valid identifier in SQL.
* There are some rules governing what is a valid identifier in SQL. The rules vary depending on what SQL engine you're using. But here is a stringent set of rules that should be safe to follow with any of the major SQL engines including Hive and Impala. Identifiers can consist of alphabetic characters, that's the letters a to z, digits, zero to nine and underscores.
* Other things like Unicode characters, punctuation, emoji, and so on should not be used in identifiers.
* The first character of an identifier should be a letter, a to z. The letters in identifiers should all be lowercase, and identifiers can be as short as one character long. The maximum length varies, but it's a good idea to limit them to 30 characters or fewer.
* There are also some particular words that you cannot use as an identifier even though they do follow these rules. These are called Reserved words. An example is the keyword SELECT. SELECT is a special keyword in SQL that signals the start of a clause.
* Other familiar keywords like FROM, AS, DISTINCT, SHOW, and USE, are also reserved words.
* For Hive and Impala, you can follow the provided links to see the full list of reserved words.

* These links are also included in the Resources area for this video.

[Impala Reserved Words](http://tiny.cloudera.com/impala-reserved-words)



[Hive Reserved Words](http://tiny.cloudera.com/hive-reserved-words)

* It is possible with most SQL engines to break some of the rules for identifiers. But to do this, you need to enclose the offending identifier in some quote characters.

* Hive, Impala, Presto, Drill, and MySQL, all use back ticks. But in Post SQL you use double quotes around identifiers.

~~~~sql
USE `use`;

USE "use"; # for  Post SQL
~~~~

* If someone has made the terrible choice of creating a database named 'use' containing a table named 'from' with a column named 'select' then to switch into that database and to query it you would need to enclose all the identifiers in back ticks as shown here. USE 'use' then SELECT 'select' FROM 'from'.
* another type of identifier, is the column aliases that you can use in SELECT list.
~~~~sql
SELECT `select` AS `as` FROM `from`;
~~~~

* With Hive and Impala and many other SQL engines, identifiers are case insensitive. That means, that the statement SELECT NAME FROM FUN.GAMES; in all capital letters will work exactly the same as SELECT name FROM fun. Games.

# Formatting SELECT Statements
* For longer statements, a convention is to put each clause on a new line and indent all the clauses after the first one with a tab or several spaces.
* Also, if there's an individual clause that's too long to fit on a single line, then you can split it up using new lines and use double indentation at the beginning of the lines that the cause continues onto. Here's an example. Notice that this statement has a very long SELECT list and it's been split up into three lines by adding new lines after some of the commas.

~~~~sql
SELECT name, AS name_of_games, inventor AS
  inventor_of_game, year AS year_game_invented, min_age AS yongest_player,
  min_players AS fewest_players, max_players AS most_players
  FROM fun.games;
~~~~


* Another thing you should keep in mind as you learn about the other clauses is that the order of the clauses in the SELECT statement is important. In general, you cannot go moving around the clauses. They need to be in the correct order or the SQL statement will be invalid.
* here are some exceptions to this. For example, HIVE will actually allow you to put the FROM clause before the SELECT clause, which is fine if you like to write SQL like the way Yoda speaks. But you should not generally do this.




# Honor Lesson

# Using Beeline in Non-Interactive Mode

* Recall that using Beeline or Impala Shell interactively means starting up the tool to get to a prompt, where you can enter SQL statements. You enter and run the SQL statements at the prompt and then exit when you are finished.
* Using Beeline or Impala Shell non-interactively means specifying what sequence statement or statements you want to run when you start up the tool.
* In non-interactive mode, the statements begin to execute automatically on start up. And the tool automatically exits when it's finished.
* In non-interactive mode, you are never presented with a prompt where you can enter SQL statements. Often the word batch is used as a synonym for non-interactive.
* Recall that Beeline is invoked at the operating system command line using the command Beeline followed by the necessary command line options and arguments.
~~~~sql
beeline -u jdbc:hive2://localhost:10000 -n training -p training
~~~~

* But to use it non-interactively, you need to specify additional options.

* One of those options is -e, which is short for execute. You use -e to specify a SQL statement that you want to execute directly on the command line.
* You use -e to specify a SQL statement that you want to execute directly on the command line.

~~~~sql
beeline -u jdbc:hive2://localhost:10000 -e 'SELECT * FROM fun.games'
~~~~

* Another option is -f, for file.
* You use -f to specify the path to a local file that contains one or more SQL statements. In this example, there are statements saved in the text file named `myquerry.sql`. In the file, you should terminate each statement with a semicolon.

~~~~sql
beeline -u jdbc:hive2://localhost:10000 -f myquerry.sql;
~~~~

* When you have multiple statements to execute, this -f file method is usually more practical than the -e method.
* In this example, the file extension is .sql, but it could be anything as long as the file is just a plain text file continuing SQL statements.
* For SQL, in general, it's customary to use the extension .sql. For Hive in particular, you'll often see `.hql` for Hive Query Language.
* Also to run the command in this example, you would need to have the file myquery.sql in your working directory, since it's specified just as a file name with no directory path.
* Using the option --silent=true suppresses all non-essential output. You should specify this before all the other options.
* It's common to use this together with the -e or -f option.
* In Beeline, many of the command line options are case sensitive. The options I showed here are all lowercase letters. Always use lowercase u in -u, lowercase e in -e, lowercase f in -f.

~~~~sql
beeline -u jdbc:hive2://localhost:10000 -e 'SELECT * FROM fun.games'
~~~~

* Go ahead and try these options for yourself. On the VM, recall that the URL after -u is jdbc:hive2://localhost:10000. And if you're querying tables that are not in the default database, then remember to specify the database.

Here are some commands for you to try in the VM. The $ means you should type this at your command line prompt, not within Beeline.

$ beeline -h

$ beeline -u jdbc:hive2://localhost:10000 -e 'SELECT * FROM fun.games'

$ beeline -u jdbc:hive2://localhost:10000 -e 'USE fun; SELECT * FROM games'

$ beeline -u jdbc:hive2://localhost:10000 --silent=true -e 'SELECT * FROM fun.games'

* `Before doing more commands, first create a file and put the following queries in it. You can create a file using vi (a text editor for the terminal) or gedit (a GUI editor). If you're not familiar with vi, you might want to use gedit. You can read more about vi first, if you prefer. Start vi using the command vi commands.sql; start gedit using the command gedit commands.sql. If you already have this file in the current directory, the command will open the file and you can edit it. Otherwise, when you save the file, it will save to your current directory (unless you specify otherwise).

USE fun;

SELECT * FROM games;

SELECT name, list_price, 0.8*list_price AS discounted_price FROM games;

Then try these commands. Compare what happens.

$ beeline -u jdbc:hive2://localhost:10000 -f commands.sql

$ beeline -u jdbc:hive2://localhost:10000 --silent=true -f commands.sql`


# Using Impala Shell in Non-Interactive Mode
* To specify a SQL statement that you want to execute directly on the command line, use the -q option for query.
* his is equivalent to B lines -e option, but with Impala Shell, it's q instead of e. After -q, you specify the SQL statement enclosed in quotes.

~~~~sql
impala-shell -q 'SELECT * FROM fun.games'
~~~~

* For a single statement, it's not necessary to terminate it with a semicolon. With two or more statements, separate them with semi-colons

* Another option is -f for file. You use -f to specify the path to a file that contains one or more SQL statements.

* In this example, the statements have been saved in the text file, myquery. sql in the current working directory.

~~~~sql
impala-shell -f myquery.sql
~~~~

* To suppress the messages, Impala Shell shows about query progress and so forth, use the - -quiet option.

~~~~sql
impala-shell --quiet -f myquery.sql
~~~~

* Command line options for Impala Shell are case sensitive. Be sure to use the ones described here in lowercase as shown here.


* One thing to keep in mind if you're using the -q option with Impala Shell or the equivalent -e option with B line is that the SQL statement you specify in the command line must be enclosed in quotes.
* Since the B line or Impala Shell command is being executed at the operating system command prompt, you need to follow the rules of your operating system shell for how to properly escape quotes. These rules can be complicated and it's easy to make a mistake. This is one of the reasons it's often easier to put the SQL statements in a file and use the -f option instead. Another benefit of putting your SQL statements in a file is that you can add comments to the file. Both HIVE and Impala support single line comments. These begin with two hyphens. HIVE and Impala will ignore everything from the double hyphen to the end of the line.
* Impala also supports multi-line comments using slash star to begin to comment and star slash to end it. HIVE does not support multiline comments.

* Here are some commands for you to try in the VM. The $ means you should type this at your command line prompt, not within Impala Shell.

$ impala-shell -h

$ impala-shell -q 'SELECT * FROM fun.games'

$ impala-shell -q 'USE fun; SELECT * FROM games'

$ impala-shell --quiet -q 'SELECT * FROM fun.games'

Before doing more commands, first create a file and put the following queries in it.  You can create a file using vi (a text editor for the terminal) or gedit (a GUI editor). If you're not familiar with vi, you might want to use gedit. You can read more about vi first, if you prefer. Start vi using the command vi commands.sql; start gedit using the command gedit commands.sql. If you already have this file in the current directory, the command will open the file and you can edit it. (The only difference is the comment lines.) Otherwise, when you save the file, it will save to your current directory (unless you specify otherwise).

-- First change the database

USE fun;

/* The first query shows all of the games table.

The second shows all the games with their price and a 20% off sale price.


SELECT * FROM games;

SELECT name, list_price, 0.8*list_price AS discounted_price FROM games;

Then try these commands. What happens with the comments in each case?

$ impala-shell -f commands.sql

$ impala-shell --quiet -f commands.sql



# Formatting the Output of Beeline and Impala Shell

  * By default, Beeline and Impala Shell render results that's in a table layout, using characters to draw the borders.
  * Hyphens, pipes, and plus signs. This is sometimes called pretty printing.
  * But sometimes you might want to print the result sets without these borders, maybe to make the results display more compactly in the terminal. Or maybe because you want to copy and paste the results into some other software or into a file.

  * Beeline and Impala Shell both have command line options that turn off pretty printing, and instead display the results as plain delimited text.
  * In your Beeline command, you specify dash output format equals, then a format mode. The default mode is table, that keeps the pretty printing on.

  * n your Beeline command, you specify dash output format equals, then a format mode. The default mode is table, that keeps the pretty printing on.

* Other modes include csv2 for comma separated values, and tsv2 for tab separated values. There was an older version of these without the number 2, but you should use the numeral ones with the number 2.


* Also, you need to specify this output format option before the dash e or dash f options.


~~~~sql
beeline -u .... --outputformat=csv2 -e 'SELECT * FROM fun.games'
~~~~

* You can use this output format options together with the option dash dash silent equals true to suppress non-essential output so your result doesn't get lost in all the messages.
* Another useful Beeline option is showHeader, with a capital H. This defaults to true which displays the header row with the column names at the top of your result. But if you’re copying the result of some other application or file, you might not need this header row. You can hide it by specifying dash dash show header equals false. This option also needs to be used before dash e or dash f.


* The formatting options for Impala Shell are specified differently than for Beeline. With Impala Shell, to disable pretty printing you use dash dash delimited. Or you can use the abbreviated version dash capital B.
* This by default prints tab separated text. You can change the delimiter by specifying the additional option dash dash output underscore delimiter.

~~~~sql
impala-shell --delimited --output_delimiter = ',' -q  'SELECT * FROM fun.games'
~~~~


* This makes Impala Shell output comma separated text. When you use the delimited option, Impala shell does not print the header row with the column names by default. This is the opposite of Beeline's default. To make Impala Shell print the header, use dash dash print underscore header.

~~~~sql
impala-shell --delimited --print_header -q  'SELECT * FROM fun.games'
~~~~



* Suppose you want your query results to output to the terminal in this format:

1,Monopoly,Elizabeth Magie,1903,8,2,6,19.99

2,Scrabble,Alfred Mosher Butts,1938,8,2,4,17.99

3,Clue,Anthony E. Pratt,1944,8,2,6,9.99

4,Candy Land,Eleanor Abbott,1948,3,2,4,7.99

5,Risk,Albert Lamorisse,1957,10,2,5,29.99

Which commands will produce this? Check all that apply.

~~~~sql
beeline -u jdbc:hive2://localhost:10000 --outputformat=csv2 --showHeader=false -e 'SELECT * FROM fun.games;'

impala-shell --delimited --output_delimiter=',' -q 'SELECT * FROM fun.games'
~~~~


# Saving Hive and Impala Query Results to a File
* With beeline, to capture query results into a file, you need to use a feature of the operating system shell called redirection. When Beeline is running, it actually writes two different streams. It writes messages and errors to the standard error stream, and it writes result sets to the standard output stream.
* But if you want to capture the results to a file, then you need to redirect the standard output screen to a file.
* You can do this using the greater than sign operator. In the Linux command shell, this greater than sign operator is an output redirection operator.
* At the end of your beeline command, append this operator followed by the path to the file where you want to capture the output.


~~~~sql
beeline -u jdbc:hive2://localhost:10000  -e 'SELECT * FROM fun.games' > file.txt

~~~~

* If you specify just a bare file name, then it writes a file with that name in the current working directory. If the file does not already exist, then it creates it. If the file does exist, then it overrides it.
* The example shown here, outputs the ID and name columns from the games table as comma separated text to the file games.csv.

~~~~sql
beeline -u jdbc:hive2://localhost:10000  -e 'SELECT id, name FROM fun.games' > games.csv

~~~~

* With impala-shell, there is no need to use redirection, because there is a command line option that captures results to a file. It's the -o option, o for output. After -o, you specify the path to the file where you want to save the output.

~~~~sql
impala-shell -q 'SELECT * FROM table' -o file.txt

~~~~

* You can use this option together with the delimited and output_delimiter options I described in the previous video to save delimited text with your choice of delimiter.

~~~~sql
impala-shell --delimited --output_delimiter=',' -q 'SELECT * FROM table' -o file.txt

~~~~

* And recall from the previous video that when you use the delimited option, impala-shell does not print the header row by default. To make impala-shell print the header with the column names, use the print_header option.



~~~~sql
impala-shell --delimited --output_delimiter=',' --print_header -q 'SELECT * FROM table' -o file.txt

~~~~

* eg

~~~~sql
impala-shell --delimited --output_delimiter=',' --print_header -q 'SELECT id, name FROM fun.games' -o games.csv

~~~~



* It's worth mentioning that you can also use hue to export query results to a file. After you execute a query in hue, click the export results button to the left of the results, then click the CSV option.

* There is also an option there to export the results as an Excel file. However, both of these options export only the first 100,000 rows.
* Finally, there's a Save button at the bottom of that menu, but please do not try to use that. That does something completely different that's beyond the scope of this course.

* Which is a correct command for saving query results as a comma-delimited file? Check all that apply. (Try these in the VM, and see what error messages say—you might learn something new to try!)

impala-shell -q 'SELECT id, name FROM fun.games' --delimited --output_delimiter=',' --print_header -o games.csv


beeline -u jdbc:hive2://localhost:10000 --outputformat=csv2 -e 'SELECT id, name FROM fun.games' > games.csv
