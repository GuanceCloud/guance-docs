# Reference Table

[:octicons-tag-24: Version-1.4.11](../datakit/changelog.md#cl-1.4.11) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

---

Through the Reference Table feature, Pipeline supports importing external data for data processing.

<!-- markdownlint-disable MD046 -->
???+ warning

    This feature consumes a significant amount of memory. For example, approximately 200MB of disk space (JSON file) is used for 1.5 million non-repeating rows (two string columns; one each of int, float, and bool types), with memory usage maintained at 950MB to 1.2GB, and peak memory usage during updates at 2.2GB to 2.7GB. You can configure `use_sqlite = true` to save data to disk.
<!-- markdownlint-enable -->

## Table Structure and Column Data Types {#table-struct}

The table structure is a two-dimensional table. Tables are distinguished by their names, and there must be at least one column. Elements within each column must have consistent data types, which must be one of int(int64), float(float64), string, or bool.

Setting primary keys for tables is not yet supported, but queries can be performed using any column, and the first row of all results will be returned as the query result. The following is an example of a table structure:

- Table name: `refer_table_abc`

- Column names (col1, col2, ...), column data types (int, float, ...), and row data:

| col1: int | col2: float | col3: string | col4: bool |
| ---       | ---         | ---          | ---        |
| 1         | 1.1         | "abc"        | true       |
| 2         | 3           | "def"        | false      |

## Importing Data from External Sources {#import}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Configure the reference table URL and pull interval (default interval is 5 minutes) in the configuration file `datakit.conf`
    
    ```toml
    [pipeline]
      refer_table_url = "http[s]://host:port/path/to/resource"
      refer_table_pull_interval = "5m"
      use_sqlite = false
      sqlite_mem_mode = false
    ```

=== "Kubernetes"

    [Refer here](../datakit/datakit-daemonset-deploy.md#env-reftab)

---

???+ warning

    Currently, the HTTP response Content-Type of the address specified by `refer_table_url` must be `Content-Type: application/json`.
<!-- markdownlint-enable -->

---

- Data consists of multiple tables represented as lists, where each table is a map with fields:

| Field Name   | Description     | Data Type   |
| ---          | ---             | ---         |
| table_name   | Table name      | string      |
| column_name  | All column names| [ ]string   |
| column_type  | Column data types, corresponding to column names, values range "int", "float", "string", "bool" | [ ]string |
| row_data     | Multiple row data, for int, float, bool types can use corresponding type data or convert to string representation; elements in []any need to correspond one-to-one with column names and column types | [ ][ ]any  |

- JSON structure:
  
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

When using SQLite to save data and setting `sqlite_mem_mode` to `true`, it uses SQLite's memory mode; the default is SQLite disk mode.

<!-- markdownlint-disable MD046 -->
???+ warning

    This feature is currently unsupported on windows-386.
<!-- markdownlint-enable -->

## Practical Example {#example}

Write the above JSON text into a file `test.json`, place it under */var/www/html* after installing NGINX via `apt` on Ubuntu18.04+

Execute `curl -v localhost/test.json` to test if the file can be retrieved via HTTP GET. The output should look like this:

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

Modify the value of `refer_table_url` in the configuration file `datakit.conf`:

```toml
[pipeline]
  refer_table_url = "http://localhost/test.json"
  refer_table_pull_interval = "5m"
  use_sqlite = false
  sqlite_mem_mode = false
```

Enter the Datakit *pipeline/logging* directory and create a test script `refer_table_for_test.p` with the following content:

```python
# Extract table name, column names, and column values from input
json(_, table)
json(_, key)
json(_, value)

# Query and append current column data, default is added to the data as a field
query_refer_table(table, key, value)
```

```shell
cd /usr/local/datakit/pipeline/logging

vim refer_table_for_test.p

datakit pipeline -P refer_table_for_test.p -T '{"table": "table_abc", "key": "col2", "value": 1234.0}' --date
```

From the following output, we can see that the columns col, col2, col3, col4 were successfully appended to the output result:

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