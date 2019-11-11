* Popular applications in analytics and bI use SQL to retrieve/analyze data.
* SQL is often used to connect code to a variety of data sources.

#### The first video in this course listed several open source distributed SQL engines that are capable of querying extremely large datasets:

  * Apache Hive
  * Apache Impala
  * Presto
  * Apache Drill
# Using the Hue Query Editors
  * with the vm open, click on web browser.
  * click Hue
  * hue interfaces:
    * table browser - click the icon on the upper left conner, then under browser, click Table .
    * in the table browser, you can click Databases to see the existing datasets.
    * you can select the database you want.
    * then, you see the database in it.
    * click on the name of the table to see more detail of it.
    * you can click little i icon to set the detail(Columns, Details, Sample, analysis)
    * you can click Columns tap to see the Columns.
    * you can also click on sample of the data to see sample data
    * It is simple point and click action in the hue.
    * but in this course we go beyond that.
## another hue interface for query.
  * Click Query => Editor =>(Impala, Hive, MySQL, PostgreSQL).
  * You can click Impala to open query editor for Impala.
  * when you are in query editor, you can use the assist panel browse the Databases and Tables.if it is hidden you can click to show it.
  * Make sure that the SQL mode is active at the top of assist panel.
  * Click the query editor space,  at rigth of it, see another assistant panel.
  * Impala query editor is more faster than hive
  * NB the word Database refers to logical container or group of tables.
  * SQL engine in general is called DATABASE.
  * sometimes people use the word "schema" to refer to database. They are the same thing.

# Running SQL Utility Statements
  * Recall:
    * Hue:
      * Display existing Databases
      * Make database active
      * Display tables in database
      * Display columns in a table. ...Using point and click actions.
  * Here, we will start using SQL Utility Statements:
    * SHOW DATABASES;
      * - to check what database existing in the system.
      * - the see the actual databases.
      * you will be connected to one database, which the active or the current database.
      * in this case, when you run SHOW database for the first time, you will see the `default` database.
      * But they are not generally named default.
    * `USE databasename;`
      * To select the database you want.
      * but here, HUE does not support this.
      * Instead use point and click.
      * on the top right, click the current database and select the name of the database you want from the drop down list.
      * Or on the lift assistant panel, click the back arrow of the current database and select from that drop down list.
      * OR you can use the code `USE tablename;`
      * You can use ` SHOW TABLES; ` to see the list of tables.
    * Use `DESCRIBE databasename;`
      * use to see what columns are in a table.

# Running SQL SELECT Statements
## QUERY
  * A `SELECT` statement in the SQL language.
    * Click the Query button or Query dropdown to select the query editor you want to use. Enter the SELECT statement in the text box. Then run the statement by clicking the blue Execute arrow.
  * Impala query editor:
    * I know that the current database is `fun` and in it, there is a `game` table.
    ~~~~sql
    SELECT * FROM games;
    ~~~~
    * The data return after you run the above statement is called `RESULT SET`.
    * The order of the columns in a result set is determined by your query, or by the structure of the table you're querying. There's nothing random about the order of the column.
    * Recall that in the previous video, when I ran the statement, `"Describe games"` to see what columns were in the games table, that returned the names of the same column, in the same order from top to bottom, ID, name, inventor, and so on.
    * I also have the option to specify in the select statement which columns to return, and what order I want them in. I'll change, "Select star" to "Select name, year, inventor".
    ~~~~sql
    SELECT name, year, inventor
    FROM games
    ~~~~
    * So the order of the columns in a result set is deterministic, but the order of the rows is not. When you run a select statement using a distributed SQL engine, the order of the rows in the results set is arbitrary and unpredictable.

# Understanding Different SQL Interfaces
  * Besides Hue, there are a variety of other SQL query tools, sometimes called SQL clients, that can be set up to to work with Hive or Impala, as well as other SQL query engines.
  * one example, there's an open source one called `SQuirreL SQL Client` that's been around for a long time.
  * The two best known of these are ODBC and JDBC. These are two different interface standards that virtually any software can use to connect to virtually any SQL engine.
  * So,
    * User Interfaces:
      * Query utilities
      * Analytics and BI software
    * Interface standards:
      * ODBC
      * JDBC
    * Specialized Command -Line Interface(CLI)
      * Beeline - HIVE
      * Impala Shell - Impala.


* Apache Hive and Apache Impala are open source big data SQL engines that are the primary focus of this course and specialization, but you might be interested in learning or using some other SQL engines, as well.

* Two very popular SQL engines are MySQL (pronounced “my ess cue ell”) and PostgreSQL (pronounced “post gress cue ell”). Both are traditional open source relational database management systems (RDBMSs); they cannot work with really big data like Hive and Impala can, but they are often used to store small- to medium-sized data. You can run SELECT queries on that data, just like you can with Hive and Impala.

* In the VM, we have installed MySQL and PostgreSQL. All the tables from the default, fun, and wax databases in Hive and Impala have been loaded into tables in MySQL and PostgreSQL so you can query them there. The tables from the fly database in Hive and Impala have not been loaded into MySQL and PostgreSQL; those are only available to query with Hive or Impala.

* Hue has been configured with query editors for these other SQL engines also, so you can practice using them. You can access them from the Query drop-down menu. Click the down arrow beside the Query button, and choose which editor you want to use.

* When you first enter the editor, you need to switch to either the mydb database (for MySQL) or the public database (for PostgreSQL) by selecting it as the active database. MySQL doesn't really have a default database in Hue. It will not let you run any queries, even those that have no table references, if default is still the active database. PostgreSQL will still allow you to run queries, but it will be much easier if you switch databases.


# Overview of Beeline and Impala Shell
* `Beeline` is the command-line interface for Hive. Beeline is based on an open source utility called SQL line.
* It uses `JDBC` to connect to Hive
* You can use it interactively where you start up the Beeline shell, and then enter and run SQL statements in it, or you can use it as a batch tool to run a single SQL statement or a set of SQL statements, and then exit when it's finished.
*  Impala shell is the command-line interface for Impala.
* Impala shell actually doesn't use ODBC or JDBC to connect to Impala.
* It uses a different interface called `Apache Thrift`, but you don't need to know or understand that to use it.

# Using Beeline
  * with the vm running, open the terminal
  * type ` beeline -u jdbc:hive2://localhost:10000 -n training -p training ` , 'u' stand for url, 'n' for username, 'p' for password .
  * Once Beeline is started and connected to the hive server you should see a message that says connected to Apache Hive and you'll see a prompt to enter SQL statements.
  * The prompt includes the JDBC URL followed by a greater than sign.
  * Run the following:
  ~~~~sql
  SHOW DATABASES;
  ~~~~
* Unlike in hue where the semicolon is optional for a single statement.
* Change the current database:
~~~~sql
USE fun;
~~~~

* If you forget to terminate a statement with a semi-colon and you press enter. Then beeline treats it like an incomplete statement and moves to the next line so you can continue writing the statement on multiple lines.
* In addition to SQL statements, beeline also accepts special commands that begin with an exclamation mark.
* The only one you need to know about right now is the one to quit beeline which is exclamation mark quit. Or you can use the shorter version, exclamation mark Q.
~~~~sql
!q
~~~~

* or special commands like this you do not use the semicolon to terminate the command, you simply press enter to execute it.
*  If I press the up arrow key that recalls the previous command.
* if you append the name of a database after a slash at the end of the hive server URL, beeline will use that as the current database when it connects. I'll append /fun to the URL and press Enter to connect.

* beeline -u jdbc:hive2://localhost:10000/fun
* If I run the command SHOW TABLES. With a semi-colon at the end. I can see the tables in the fun database.

~~~~sql
SHOW TABLES
~~~~

* Now, I'll return all the columns and rows from the games table by running the query SELECT star FROM games.

~~~~sql
SELECT * FROM games;
~~~~

* To recall previously entered statements, use the Up arrow key.
* I'll recall the select statement and I'll change the star to name name, list price, that result set is narrow enough to print without wrapping.

~~~~sql
SELECT name, list_price FROM games;
~~~~

* To clear the screen in beeline use the key combination `Ctrl + L`.

* And finally I'll quit by again running the special command exclamation mark q  `!q`.
* Recall that in the hue query editors if a result set has more than 100 rows only 100 are returned and displayed. But here in beeline, when you execute a query the entire result set is returned and printed to the screen.
* Depending on the version of beeline you're using, control C might just cancel the query or it might cancel the query and exit beeline.

# Using Impala Shell
* With the VM running, open the terminal.
* To start Impala Shell, use the command `impala-shell`. You can specify arguments after this, but on the core VM none are required.
* In other environments you might need to include arguments. For example, you might need to use  `-i `to specify the host name and port of an `Impala daemon`.
* To see all the available arguments, also called options, you can use the ` -h `option, short for help, that prints a list of all the options, but does not start Impala Shell.
* One useful option is `-d `, which sets the current database on startup.
* If you don't specify it, then the current database after you start Impala Shell will be the default database.
* I'll specify ` -d fun `, then press "Enter" to start Impala Shell.
* Now you can enter and run SQL statements just like in Beeline, and results are displayed similarly.
* Like Beeline, Impala shell requires statements to be terminated with a semicolon.
* The command to quit Impala shell is different than in Beeline. It's the word `quit` with no exclamation mark before it, and in Impala shell you do need to terminate the quit command with a semicolon.

* A few more things they have in common. In both, you can clear the screen by pressing "Control+L". In both when you execute a query, the entire results set is returned and printed to the screen, not just 100 rows like in the You Query Editors. In both you can cancel a query by pressing "Control+C". Later in the course, you'll learn about more ways to use Beeline and Impala shell.
