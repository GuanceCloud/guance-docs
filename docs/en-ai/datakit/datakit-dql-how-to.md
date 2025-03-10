# Query Data via DQL
---

DataKit supports executing DQL queries in an interactive manner. In interactive mode, DataKit features auto-completion for statements:

> Use `datakit help dql` to get more command-line parameter help.

```shell
datakit dql      # or datakit -Q
```

<figure markdown>
  ![](https://static.guance.com/images/datakit/dk-dql-gif.gif){ width="800" }
  <figcaption> Example of Interactive DQL Execution </figcaption>
</figure>

Tips:

- Input `echo_explain` to see the backend query statement.
- To avoid displaying too many `nil` results, you can toggle with `disable_nil/enable_nil`.
- Supports fuzzy search for query statements; for example, typing `echo` or `exp` will bring up suggestions for `echo_explain`, and you can select from the dropdown using the Tab key.
- DataKit automatically saves the history of previously executed DQL queries (up to 5000 entries), which you can navigate using the up and down arrow keys.

> Note: On Windows, run `datakit dql` in Powershell.

## Execute a Single DQL Query {#dql-once}

Regarding DQL queries, DataKit supports running a single DQL statement:

```shell
# Execute a single query statement
datakit dql --run 'cpu limit 1'

# Write the execution result to a CSV file
datakit dql --run 'O::HOST:(os, message)' --csv="path/to/your.csv"

# Force overwrite an existing CSV file
datakit dql --run 'O::HOST:(os, message)' --csv /path/to/xxx.csv --force

# Display the query results in the terminal while writing to a CSV file
datakit dql --run 'O::HOST:(os, message)' --csv="path/to/your.csv" --vvv
```

Example of the exported CSV file format:

```shell
name,active,available,available_percent,free,host,time
mem,2016870400,2079637504,24.210166931152344,80498688,achen.local,1635242524385
mem,2007961600,2032476160,23.661136627197266,30900224,achen.local,1635242534385
mem,2014437376,2077097984,24.18060302734375,73502720,achen.local,1635242544382
```

Note:

- The first column is the name of the queried Measurement.
- Subsequent columns represent the corresponding data fields of the collector.
- If a field is empty, the corresponding column will also be empty.

## JSONify DQL Query Results {#json-result}

Output results in JSON format. However, in JSON mode, some statistical information such as the number of returned rows and time taken will not be included (to ensure JSON can be parsed directly).

```shell
datakit dql --run 'O::HOST:(os, message)' --json

# If the field value is a JSON string, it will be automatically beautified (note: the `--auto-json` option is invalid in JSON mode (`--json`))
datakit dql --run 'O::HOST:(os, message)' --auto-json
-----------------[ r1.HOST.s1 ]-----------------
message ----- json -----  # JSON starts here, where `message` is the field name
{
  "host": {
    "meta": {
      "host_name": "www",
  ....                    # Long text omitted here
  "config": {
    "ip": "10.100.64.120",
    "enable_dca": false,
    "http_listen": "localhost:9529",
    "api_token": "tkn_f2b9920f05d84d6bb5b14d9d39db1dd3"
  }
}
----- end of json -----   # JSON ends here
     os 'darwin'
   time 2021-09-13 16:56:22 +0800 CST
---------
8 rows, 1 series, cost 4ms
```

## Query Data from Specific Workspaces {#query-on-wksp}

Query data from other workspaces by specifying different Tokens:

```shell
datakit dql --run 'O::HOST:(os, message)' --token <your-token>
```