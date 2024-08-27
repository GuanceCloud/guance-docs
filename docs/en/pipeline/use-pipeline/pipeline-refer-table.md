
# Reference Table

[:octicons-tag-24: Version-1.4.11](../../datakit/changelog.md#cl-1.4.11) ·
[:octicons-beaker-24: Experimental](../../datakit/index.md#experimental)

---


With the Reference Table feature, Pipeline supports importing external data for data processing.

<!-- markdownlint-disable MD046 -->
???+ warning

    This feature consumes a higher amount of memory. As an example, referencing 1.5 million rows of disk usage is approximately 200MB (JSON file) for non-duplicate data (two string columns; one column each for int, float, and bool), the memory usage remains between 950MB to 1.2GB, with peak memory usage during updates ranging from 2.2GB to 2.7GB. You can configure `use_sqlite = true` to save data to the disk.
<!-- markdownlint-enable -->

## Table Structure and Column Data Types {#table-struct}

The table structure is a two-dimensional table, distinguished from other tables by the table name, and must contain at least one column. The data type of elements within each column must be consistent and must be one of int(int64), float(float64), string, or bool.

There is currently no support for setting a primary key for the table, but you can query through any column and the first row of all the results found will be used as the query result. The following is an example of a table structure:

- Table name: `refer_table_abc`

- Column names(col1, col2, ...), column data types(int, float, ...), row data:

| col1: int | col2: float | col3: string | col4: bool |
| ---       | ---         | ---          | ---        |
| 1         | 1.1         | "abc"        | true       |
| 2         | 3           | "def"        | false     |

## Importing Data from External Sources {#import}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    In the configuration file `datakit.conf`, configure the reference table URL and the pull interval (default is 5 minutes)
    
    ```toml
    [pipeline]
      refer_table_url = "http[s]://host:port/path/to/resource"
      refer_table_pull_interval = "5m"
      use_sqlite = false
      sqlite_mem_mode = false
    ```

=== "Kubernetes"

    [See here](../../datakit/datakit-daemonset-deploy.md#env-reftab)

---

???+ warning

    At present, the address specified by refer_table_url must have the HTTP response Content-Type set to `Content-Type: application/json`.
<!-- markdownlint-enable -->

---

- Data consists of multiple tables in a list, with each table composed of a map, and the fields in the map are:

| Field Name   | table_name | column_name | column_type                                                         | row_data                                                                                                             |
| ---          | ---         | ---          | ---                                                                  | ---                                                                                                                  |
| Description  | Table Name  | All Column Names | Column Data Types, must correspond with the column names, values range "int", "float", "string", "bool" | Multiple rows of data, for int, float, bool types, you can use corresponding type data or convert to string representation; elements in []any must correspond to the column names and types |

- JSON Structure:
  
```json
[
    {
        "table_name": string,
        "column_name": []string{},
        "column_type": []string{},
        "row_data": [
            []any{},
            ...
        ]
    },
    ...
]
```

- Example:

```json
[
    {
        "table_name": "table_abc",
        "column_name": ["col", "col2", "col3", "col4"],
        "column_type": ["string", "float", "int", "bool"],
        "row_data": [
            ["a", 123, "123", false],
            ["ab", "1234.", "123", true],
            ["ab", "1234.", "1235", false]
        ]
    },
    {
        "table_name": "table_ijk",
        "column_name": ["name", "id"],
        "column_type": ["string", "string"],
        "row_data": [
            ["a", "12"],
            ["a", "123"],
            ["ab", "1234"]
        ]
    }
]
```

## Using SQLite to Save Imported Data {#sqlite}

To save the imported data into an SQLite database, simply configure `use_sqlite` to `true`:

```toml
[pipeline]
    refer_table_url = "http[s]://host:port/path/to/resource"
    refer_table_pull_interval = "5m"
    use_sqlite = true
    sqlite_mem_mode = false
```

When using SQLite to save data, and the above `sqlite_mem_mode` is set to `true`, SQLite's memory mode will be used; the default is SQLite disk mode.

<!-- markdownlint-disable MD046 -->
???+ warning

    This feature is currently not supported under windows-386.
<!-- markdownlint-enable -->

## Practical Example {#example}

Write the above JSON text into a file named `test.json`, and after installing NGINX on Ubuntu18.04+ using `apt`, place the file in the */var/www/html* directory.

Execute `curl -v localhost/test.json` to test whether the file can be retrieved via HTTP GET. The output result should be roughly as follows:

```txt
...
< Content-Type: application/json
< Content-Length: 522
< Last-Modified: Tue, 16 Aug 2022 06:20:52 GMT
< Connection: keep-alive
< ETag: "62fb3744-20a"
< Accept-Ranges: bytes
< 
[
    {
        "table_name": "table_abc",
        "column_name": ["col", "col2", "col3", "col4"],
        "column_type": ["string", "float", "int", "bool"],
        "row_data": [
...
```

In the configuration file `datakit.conf`, modify the refer_table_url to:

```toml
[pipeline]
  refer_table_url = "http://localhost/test.json" 
  refer_table_pull_interval = "5m"
  use_sqlite = false
  sqlite_mem_mode = false
```

Navigate to the Datakit *pipeline/logging* directory and create a test script `refer_table_for_test.p`, and write the following content:

```python
# Extract the table name, column name, and column value from the input
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column, default to add to the data as a field
query_refer_table(table, key, value)
```

```shell
cd /usr/local/datakit/pipeline/logging

vim refer_table_for_test.p

datakit pipeline -P refer_table_for_test.p -T '{"table": "table_abc", "key": "col2", "value": 1234.0}' --date
```

From the following output results, it can be known that the columns col, col2, col3, col4 of the table were successfully appended to the output results:



```shell
2022-08-16T15:02:14.150+0800  DEBUG  refer-table  refertable/cli.go:26  performing request[method GET url http://localhost/test.json]
{
  "col": "ab",
  "col2": 1234,
  "col3": 123,
  "col4": true,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T15:02:14.158452592+08:00",
  "value": 1234
}
```
