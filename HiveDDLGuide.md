# Apache Hive DDL

We will be making reference to the [Apache Hive Language Manual](https://hive.apache.org/docs/latest/language/languagemanual/). Consider it our "Hive Textbook"

Apache Hive is a scalable data warehousing technology built on Apache Hadoop. Hive comes 
with a metastore service that maintains metadata so that users can run any number of queries 
on \[previously\] created tables. However, data processing technologies such as MapReduce and Pig do 
not have built-in metadata service, so users must define a schema each time they want to run a query.

Balaswamy Vaddeman 2016

```sql
CREATE EXTERNAL TABLE salaries_titles (
emp_no STRING,
first_name STRING, 
last_name STRING,
gender STRING,
salary FLOAT,
salary_from_date DATE,
salary_to_date DATE,
title_from_date DATE,
title_to_date DATE,
title STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar"     = "'",
    "escapeChar"    = "\\" 
)
LOCATION 'gs://YOUR_STORAGE_BUCKET/empsal_raw/'
;
```

## Creating a Partitioned Hive Table
When creating a new partitioned table in Hive, your are met with some challenges. If you are creating a single column partition, it is always advisable to place the partition columns at the end of your table. In this example, our partitioning column is also the last column in the raw data so we don't need to manipulate the data prior to the creation of a partitioned table. In other cases, you'll have no choice but to manipulate an external table and create some new data in the distributed store that conforms to hive's expectation. 

Here is how you'd do that:

```sql
INSERT OVERWRITE DIRECTORY 'gs://YOUR_STORAGE_BUCKET/emp_sal_staging/'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar"     = "'",
    "escapeChar"    = "\\" 
)
STORED AS TEXTFILE
SELECT title, emp_no, first_name, last_name, gender, salary, salary_from_date, salary_to_date, title_from_date, title_to_date
FROM salaries_titles;
```
Note the SELECT list... compare to the salaries_titles table definition.
```sh
# Examine the contents of this output directory

gcloud storage ls 'gs://YOUR_STORAGE_BUCKET/emp_sal_staging/'
```

## Create a partitioned version of the salaries_titles table

Note that the titles column is missing. Also note that this is a managed table, and that there is no LOCATION clause in the statement

```sql
CREATE TABLE IF NOT EXISTS partitioned_salaries_titles (
emp_no STRING,
first_name STRING,
last_name STRING,
gender STRING, 
salary INT,
salary_from_date DATE,
salary_to_date DATE,
title_from_date DATE,
title_to_date DATE
)
PARTITIONED BY (title STRING)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;
```

Once you've successfully done this, try running:
```sql
SHOW PARTITIONS partitioned_salaries_titles;
DESCRIBE FORMATTED partitioned_salaries_titles;
```

## Loading Data into a Partitioned Table
See the [Hive language manual on loading files into tables for full details.](https://hive.apache.org/docs/latest/language/languagemanual-dml/#loading-files-into-tables)
Hive does not do any transformation while loading data into tables. Load operations are currently 
pure copy/move operations that move datafiles into locations corresponding to Hive tables.

To achieve this we'll write:
```sql
LOAD DATA INPATH 'gs://YOUR_STORAGE_BUCKET/empsal_raw/' INTO TABLE partitioned_salaries_titles;
```

If this works, try, from any terminal with gcloud initialized:

```sh
gcloud storage ls gs://YOUR_STORAGE_BUCKET/hive-warehouse/employees.db/partitioned_salaries_titles
```

In beeline try: 
```sql
SHOW PARTITIONS partitioned_salaries_titles;
```
What do you see now?

### Note:
```sql
CREATE TABLE tab1 (col1 int, col2 int) PARTITIONED BY (col3 int) STORED AS ORC;
LOAD DATA LOCAL INPATH 'filepath' INTO TABLE tab1;
```
Here, partition information is missing which would otherwise give an error, however, if the file(s) located at 
filepath conform to the table schema such that each row ends with partition column(s) then the load will rewrite into an INSERT AS SELECT job.