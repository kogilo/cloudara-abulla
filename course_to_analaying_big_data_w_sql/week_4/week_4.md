# Introduction
* We will learn about two more `SELECT` clauses: `GROUP BY` and `HAVING`
* To use these clauses you need to understand what `aggregation` is.

# Introduction to Aggregation
* Aggregation is:- `is the act of taking multiple values and reducing them down to a single value.`
* `Two` of the simplest forms of aggregation, are `counting` and `adding`.
  * Counting: simply mean `counting how many rows`.
  * Adding: Sum of values. eg. summing salary.
  * => The result in these two cases is call `aggregate`
  * Counting and adding are not the only:
  * Computing the `Average` (mean)
  * Finding the `minimum` (lowest value)
  * Finding the `maximum` (highest value)
  * next, see the built-in functions in SQL for computing all of these.
# Common Aggregate Functions
* Function Name
  * `COUNT`
* Function Description
  * Count rows
* Example Invocation
~~~~sql
COUNT(*)
~~~~

* Function Name
  * `SUM`
* Function Description
  * Add all supplied values and return results.
* Example Invocation
~~~~sql
SUM(salary)
~~~~


* Function Name
  * `AVG`
* Function Description
  * Return the average of all supplied values.
* Example Invocation
~~~~sql
AVG(salary)
~~~~

* Function Name
  * `MIN`
* Function Description
  * Return the lowest values
* Example Invocation
~~~~sql
MIN(salary)
~~~~

* Function Name
  * `MAX`
* Function Description
  * Return the highest values
* Example Invocation
~~~~sql
MAX(salary)
~~~~

* They are case `insensitive` but for conventional we use Capital case.   

# Using Aggregate Functions in the SELECT Statement

* The most basic way to use the aggregate functions is the use them in the `SELECT` statement.
* To count rows from `employees` table:
~~~~sql
SELECT COUNT(*) FROM employees;
~~~~
* You can use the column alias to give a name to the column that's returned.
~~~~sql
SELECT COUNT(*) AS num_rows FROM employees;
~~~~

~~~~sql
SELECT SUM(salary) FROM employees;
~~~~

~~~~sql
SELECT SUM(salary) AS salary_total FROM employees;
~~~~

* `COUNT(*)` and `SUM(salary)` are called `aggregate Expressions`.

*  You can include two or more aggregate expressions in the select list:
~~~~sql
SELECT MIN(salary) AS lowest_salary, MAX(salary) AS highest_salary
FROM employees;
~~~~

* More complex example
~~~~sql
SELECT MAX(salary) - MIN(salary) AS salary_spread, FROM employees;
~~~~

* another: if there is `0.062` Payroll tax:
~~~~sql
SELECT round(SUM(salary) * 0.062) AS total_tax FROM employees;
~~~~


* Also
~~~~sql
SELECT SUM(round(salary * 0.062)) AS total_tax FROM employees;
~~~~

## Example
* If 1 US dollar is equivalent to 66.75 Indian rupees, what is the average list price of the games in the fun.games table in Indian rupees, rounded to two places after the decimal? Use the VM to calculate this.
~~~~sql
SELECT round(AVG(list_price * 66.75), 2) AS avg_price_in_rupee FROM fun.games;
~~~~

* `Aggregate expressions`: Combine values from multiple rows.
* `Non-aggregate or scalar expressions`: Return one value per row.
* Valid mixing of aggregate and scalar operations.
~~~~sql
round(AVG(list_price))
SUM(salary * 0.062)
~~~~
* Invalid mixing of aggregate and scalar operations.
~~~~sql
SELECT salary - AVG(salary) FROM employees;

SELECT first_name, SUM(salary) FROM employees;
~~~~

* Which of the following statements are valid? Check all that apply.

~~~~sql
SELECT 1.06 * SUM(price) FROM fun.inventory;

Correct
Correct. In this case, the single aggregated value will be multiplied by the scalar, still returning a single value.

SELECT 1.06 * SUM(price) FROM fun.inventory;

is selected.This is correct.
Correct. In this case, the single aggregated value will be multiplied by the scalar, still returning a single value.

SELECT qty * SUM(price) FROM fun.inventory;

Un-selected is correct
SELECT qty * SUM(price) FROM fun.inventory;

is not selected.This is correct.

SELECT game, SUM(price) FROM fun.inventory;

Un-selected is correct
~~~~

### You can also use `WHERE Clause` in the aggregate expressions

* example
~~~~sql
SELECT COUNT(*) FROM employees WHERE salary > 30000;
~~~~
* However: `Do not use aggregate expressions in the WHERE Clause`
## Quiz
* The flights dataset includes the `distance` (in `miles`) and `time` (in `minutes`) in the air for the included flights. Write and run a query to find the `average air speed`, in `miles per hour`, of only those flights that were in the air for `longer than 60 minutes`. Report to the `nearest mile per hour`. (Hints: Speed is distance divided by time. Remember that the time is in minutes, and this problem asks for speed in miles per hour. Your answer should be an integer.)
  * Solution:
    * 1hr = 60 minutes => 1 minute = 1hr/60 minutes
    * Statement:
    ~~~~sql
    SELECT round(AVG(distance/(air_time/60))) as avg_speed FROM fly.flights
    WHERE air_time>60;
    ~~~~

# Interpreting Aggregates: `Populations` and `Samples`
    * When you compute aggregates of columns in a real-world dataset, you need to be mindful of whether the dataset describes a `population` or a `sample`. There are implications for your conclusions and how you might want to phrase them.

### The Difference Between Populations and Samples
* Some datasets have a row describing each and every item in a population. An example of this is a table of customers, which has one row for each customer. In a dataset like this, every customer is described in the data. The population is `all the business’s customers`, so the dataset contains the full `population`.
* Other datasets describe a sample from a larger population. An example of this is data collected from a `survey or poll`. Typically, the respondents to a survey or poll comprise only a `small proportion` of the population they are drawn from. For example, if you took a survey of people in Brazil, you might have `1000 survey respondents` (the sample), but you'll use those 1000 respondents to represent the 200 million people who live in Brazil (the population).

* In many cases, it is impractical or impossible to collect data describing an entire population. This is true even when the population is fairly small. For example, a company that manufactures airplane wings needs to perform tests to determine the amount of force that the wings can endure before breaking. They cannot test every wing they manufacture, because testing a wing requires breaking it. So they must test a small sample of the wings, and they must take care to ensure that the sample is representative of the full population.
* None of the datasets on the VM describe samples, but many real-world datasets do.
#### Phrasing Conclusions Appropriately
* When you analyze a dataset that describes a sample, it’s important `to phrase your observations appropriately`. In particular, you should make it clear whether a `sample or a population` is involved, and you should describe that sample or population accurately so the results are `not overgeneralized`.
#### Example Scenario

* Imagine you were querying a dataset that described `300 responses` to a survey of North American air travelers. Your query results showed that `79%` of the 300 respondents would prefer traveling by high-speed rail over traveling by plane.
#### Inappropriate Conclusions
* The following conclusion is inappropriate because it conflates the sample with the population:
  * `“79% of North American air travelers prefer traveling by high-speed rail over traveling by plane.”`
* The following conclusion is even worse; it does not describe the population correctly and it overgeneralizes the results:
  * `“79% of North Americans prefer traveling by high-speed rail over traveling by plane.”`
#### Appropriate Conclusions
* The following conclusion is appropriate:
  * `“79% of respondents to a survey of North American air travelers said they prefer traveling by high-speed rail over traveling by plane.” `
* The following conclusion is appropriate if you are confident that the sample is representative of the population:
  * `“Our survey results suggest that 79% of North American air travelers prefer traveling by high-speed rail over traveling by plane.”`
## Aggregate Functions for Samples
* Depending on what SQL engine you’re using, you might have noticed some built-in aggregate functions with `“_samp” or “_pop” in their names. For purposes of this course, you should disregard these functions. They are described in a later course in this specialization.`

# The least and greatest Functions
* Two built-in functions that often cause confusion are the `least` and `greatest` functions. These are often confused with `MIN` and `MAX`.
* `MIN` and `MAX` are aggregate functions. They return the `minimum` or `maximum` value within a column.
* `least` and `greatest` are non-aggregate functions. They return the smallest or largest of the `arguments` that are passed to them.

* For example, the query:
~~~~sql
SELECT MAX(red), MAX(green), MAX(blue) FROM crayons;
~~~~
* aggregates the full crayons table (which has 120 rows) down to a result set with just one row. The three columns in the result set give `the largest value of red`, `the largest value of green`, and `the largest value of blue` that exist in the full table.

* Whereas the query:
~~~~sql
SELECT greatest(red, green, blue) FROM crayons;
~~~~
* returns a result with 120 rows. Each row in the result set gives the largest of the three RGB values (red, green, blue) that make up each crayon color.

* The least and greatest functions are available in many (but not all) SQL engines.
* One unusual aspect of the `least` and `greatest` functions is that they can take a very large number of arguments. Recall that there are a few other functions like this (including `concat`,`concat_ws`, and `coalesce`).

# Introduction to the `GROUP BY` Clause
* All the examples of aggregation that we have seen in the previous lesson, returned to result set with only `one row`.
* But what if you want to aggregate subsets of the table and return a result that gives aggregates for each of the subsets?
* Example:
  * `How many employees are there in total?`
~~~~sql
SELECT COUNT(*)
  FROM employees;
~~~~
  * How many employees are there in each office?

  ~~~~sql
  SELECT COUNT(*)
    FROM employees
    GROUP BY office_id;
  ~~~~

  * To give you explicit count:
  ~~~~sql
  SELECT office_id, COUNT(*)
    FROM employees
    GROUP BY office_id;
  ~~~~
  * with column alias :
  ~~~~sql
  SELECT office_id,
    COUNT(*) AS num_employees
    FROM employees
    GROUP BY office_id;
  ~~~~

### Qize
* Here is a portion of the `fun.games` table. The table has `8 columns`, but not all are shown (for space considerations).
* How many columns and rows does the result of this query have?
~~~~sql
SELECT min_age, COUNT(*) FROM fun.games GROUP BY min_age;
~~~~
* Please attempt to answer this question without actually running the query.

* You can use the G`ROUP BY` clause together with the `WHERE` clause in a SELECT statement. The WHERE clause, if you use it, always `comes before` the GROUP BY clause.
* Example:
  * How many employees with a salary of more than 35000 are there in each office?

  ~~~~sql
  SELECT office_id, COUNT(*)
    FROM employees
    WHERE salary > 35000
    GROUP BY office_id;
  ~~~~

  * Quiz
    * Run the following query on the VM using Impala. Then use the result set to answer the following question:
    ~~~~sql
    SELECT min_age, COUNT(*)
      FROM fun.games
      WHERE list_price > 10
      GROUP BY min_age;
    ~~~~
    * AN. `The WHERE clause filters out the row representing Candy Land (because it costs less than 10 dollars) before the data is grouped and aggregated. The absence of a row with min_age = 3 indicates that zero games with a list price greater than $10 have min_age = 3.`



# Choosing an Aggregate Function and Grouping Column
