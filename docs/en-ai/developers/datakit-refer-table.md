# Reference Table

[:octicons-tag-24: Version-1.4.11](../datakit/changelog.md#cl-1.4.11) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

Through the Reference Table feature, Pipeline supports importing external data for data processing.

<!-- markdownlint-disable MD046 -->
???+ warning

    This feature consumes a significant amount of memory. For example, 1.5 million rows of non-repeating data (JSON file) with two string columns and one column each of int, float, and bool types occupy about 200MB on disk. The memory usage remains between 950MB to 1.2GB, with peak memory usage during updates ranging from 2.2GB to 2.7GB. You can configure `use_sqlite = true` to save the data to disk.
<!-- markdownlint-enable -->

## Table Structure and Column Data Types {#table-struct}

The table structure is a two-dimensional table. Tables are distinguished by their names and must contain at least one column. Elements within each column must have consistent data types, which must be one of int(int64), float(float64), string, or bool.

Currently, setting a primary key for the table is not supported, but queries can be performed using any column, and the first row of all query results will be returned as the result. Below is an example of a table structure:

- Table name: `refer_table_abc`

- Column names (col1, col2, ...), column data types (int, float, ...), and row data:

| col1: int | col2: float | col3: string | col4: bool |
| ---       | ---         | ---          | ---        |
| 1         | 1.1         | "abc"        | true       |
| 2         | 3           | "def"        | false      |

## Importing Data from External Sources {#import}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Configure the reference table URL and pull interval (default interval is 5 minutes) in the configuration file `datakit.conf`.
    
    ```toml
    [pipeline]
      refer_table_url = "http[s]://host:port/path/to/resource"
      refer_table_pull_interval = "5m"
      use_sqlite = false
      sqlite_mem_mode = false
    ```

=== "Kubernetes"

    [See here](../datakit/datakit-daemonset-deploy.md#env-reftab)

---

???+ warning

    Currently, the HTTP response Content-Type of the URL specified by `refer_table_url` must be `Content-Type: application/json`.
<!-- markdownlint-enable -->

---

- Data consists of multiple tables represented as lists, where each table is a map. The fields in the map are:

| Field Name   | table_name | column_name | column_type                                                         | row_data                                                                                                             |
| ---          | ---        | --          | --                                                                  | ---                                                                                                                  |
| Description  | Table Name | All Column Names | Column Data Types, corresponding to column names, with values "int", "float", "string", "bool" | Multiple row data; for int, float, and bool types, you can use the corresponding type data or represent it as a string; elements in []any must correspond one-to-one with column names and column types |
| Data Type    | string     | [ ]string   | [ ]string                                                           | [ ][ ]any                                                                                                            |

- JSON Structure:
  
```json
[
    {
        "table_name":  string,
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
            ["a", 123, "123", "false"],
            ["ab", "1234.", "123", true],
            ["ab", "1234.", "1235", "false"]
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

To save imported data to an SQLite database, simply set `use_sqlite` to `true`:

```toml
[pipeline]
    refer_table_url = "http[s]://host:port/path/to/resource"
    refer_table_pull_interval = "5m"
    use_sqlite = true
    sqlite_mem_mode = false
```

When using SQLite to save data, if the above `sqlite_mem_mode` is set to `true`, SQLite's memory mode will be used; by default, it uses SQLite's disk mode.

<!-- markdownlint-disable MD046 -->
???+ warning

    This feature is currently unsupported on windows-386.
<!-- markdownlint-enable -->

## Practical Example {#example}

Write the above JSON text into a file named `test.json`. After installing NGINX using `apt` on Ubuntu 18.04+ and placing the file under */var/www/html*,

execute `curl -v localhost/test.json` to test whether the file can be retrieved via HTTP GET. The output should look like this:

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

Modify the value of `refer_table_url` in the configuration file `datakit.conf` to:

```toml
[pipeline]
  refer_table_url = "http://localhost/test.json"
  refer_table_pull_interval = "5m"
  use_sqlite = false
  sqlite_mem_mode = false
```

Enter the Datakit *pipeline/logging* directory and create a test script `refer_table_for_test.p`, then write the following content into it:

```python
# Extract table name, column name, and column value from input
json(_, table)
json(_, key)
json(_, value)

# Query and append the current column data, defaulting to adding it as a field to the data
query_refer_table(table, key, value)
```

```shell
cd /usr/local/datakit/pipeline/logging

vim refer_table_for_test.p

datakit pipeline -P refer_table_for_test.p -T '{"table": "table_abc", "key": "col2", "value": 1234.0}' --date
```

From the following output, it can be seen that the columns col, col2, col3, and col4 from the table were successfully appended to the output result:

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