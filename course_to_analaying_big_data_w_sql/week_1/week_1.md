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
      *
