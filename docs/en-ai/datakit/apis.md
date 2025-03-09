# DataKit API

---

This document mainly describes the HTTP API interfaces exposed by DataKit.

## API Overview {#intro}

DataKit currently only supports HTTP interfaces, mainly involving data writing and data querying.

### Getting the Remote DataKit Version via API {#api-get-dk-version}

There are two ways to obtain the version number:

- Request the DataKit ping interface: `curl http://ip:9529/v1/ping`
- In the response Header of each API request below, you can get the current DataKit version through `X-DataKit`

## `/v1/write/:category` | `POST` {#api-v1-write}

This API is used to report various types of data (`category`) to DataKit. The URL parameter descriptions are as follows:

**`category`**

- Type: string
- Required: N
- Default value: -
- Description: Currently only supports `metric, logging, rum, object, custom_object, keyevent`. For example, if using `metric`, the URL should be written as `/v1/write/metric`

**`dry`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: bool
- Required: N
- Default value: false
- Description: Test mode, it just POSTs the Point to Datakit but does not actually upload it to Guance

**`echo`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: enum
- Required: N
- Default value: -
- Description: Optional values `lp/json/pbjson`. `lp` indicates that the uploaded Point is represented in line protocol form in the returned Body. The following are [ordinary JSON](apis.md#api-v1-write-body-json-protocol) and [PB-JSON](apis.md#api-v1-write-body-pbjson-protocol)

**`encoding`** [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

- Type: string
- Required: N
- Default value: -
- Description: Supports four compression methods: `gzip`, `deflate`, `br`, and `zstd`. If this parameter is passed, DataKit will automatically decompress the request body.

**`global_election_tags`** [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)

- Type: bool
- Required: N
- Default value: false
- Description: Whether to append [global election tags](datakit-conf.md#set-global-tag)

**`ignore_global_host_tags`** [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)

- Type: bool
- Required: N
- Default value: false
- Description: Whether to ignore [global host tags](datakit-conf.md#set-global-tag) on DataKit. By default, all data written by this interface will carry global host tags.

**`input`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: string
- Required: N
- Default value: `datakit-http`
- Description: Data source name, which will be displayed on the Datakit monitor for debugging purposes

**`loose`** [:octicons-tag-24: Version-1.4.11](changelog.md#cl-1.4.11)

- Type: bool
- Required: N
- Default value: true
- Description: Loose mode, DataKit will attempt to fix non-compliant Points

**`precision`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: enum
- Required: N
- Default value: -
- Description: Data precision (supports `n/u/ms/s/m/h`). If this parameter is not provided, it automatically identifies the timestamp precision.

**`source`**

- Type: string
- Required: N
- Default value: -
- Description: If `source` (or corresponding *source.p*) is not specified or invalid, the uploaded Point data will not execute the Pipeline

**`strict`** [:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9)

- Type: bool
- Required: N
- Default value: false
- Description: Strict mode, for some non-compliant line protocols, the API directly returns an error and informs the specific reason

<!-- markdownlint-disable MD046 -->
???+ attention

    - The following parameters have been deprecated [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

        - `echo_line_proto` : Replaced by `echo` parameter
        - `echo_json`       : Replaced by `echo` parameter

    - Although multiple parameters are of type bool, do not pass `false` if the corresponding option is not needed. The API only checks whether the corresponding parameter has a value, regardless of its content.
    - Automatic identification of time precision (`precision`) ([:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)) means guessing the possible time precision based on the input timestamp value. Mathematically, it cannot guarantee correctness, but it is sufficient for daily use. For example, for the timestamp 1716544492, it is judged as seconds, and 1716544492000 is judged as milliseconds, etc.
    - If the data point does not contain a timestamp, the machine's local timestamp where DataKit resides is used.
    - Although the current protocol supports binary format and any format, these two types of data are not yet supported for writing. **Special Note**.
<!-- markdownlint-enable -->

### Body Description {#api-v1-write-body}

The HTTP body supports line protocol and two forms of JSON.

#### Line Protocol Body {#api-v1-write-body-line-protocol}

A single line protocol entry looks like this:

```text
measurement,<tag-list> <field-list> timestamp
```

Multiple line protocols are separated by newlines:

```text
measurement_1,<tag-list> <field-list> timestamp
measurement_2,<tag-list> <field-list> timestamp
```

Where:

- `measurement` is the name of the Mearsurement set, representing a collection of Metrics, such as `disk` might have `free/used/total`, etc.,
- `<tag-list>` is a list of tags, separated by `,`. A single tag format is `key=value`, where `value` is treated as a string. In the line protocol, `<tag-list>` is **optional**
- `<field-list>` is a list of fields, separated by `,`. In the line protocol, `<field-list>` is **required**. Single field format is `key=value`, with `value` depending on its type:
    - int example: `some_int=42i`, i.e., append `i` after the integer value
    - uint example: `some_uint=42u`, i.e., append `u` after the integer value
    - float example: `some_float_1=3.14,some_float_2=3`, here `some_float_2` is an integer 3 but is still considered a float
    - string example: `some_string="hello world"`, string values need to be enclosed in `"`
    - bool example: `some_true=T,some_false=F`, here `T/F` can also be represented as `t/f/true/false`
    - binary example: `some_binary="base-64-encode-string"b`, binary data (byte streams `[]byte`) needs to be base64 encoded to be represented in the line protocol, similar to strings but with an additional `b` to identify it
    - array example: `some_array=[1i,2i,3i]`, note that types within the array can only be basic types (`int/uint/float/boolean/string/[]byte`, **no arrays**), and their types must be consistent. Arrays like `invalid_array=[1i,3.14,"string"]` are not supported
- `timestamp` is an integer timestamp, by default DataKit handles this timestamp in nanoseconds. If the original data is not in nanoseconds, specify the actual timestamp precision via the request parameter `precision`. In the line protocol, `timestamp` is optional; if the data does not include a timestamp, DataKit uses the reception time as the current line protocol time.

Between these parts:

- `measurement` and `<tag-list>` are separated by `,`
- `<tag-list>` and `<field-list>` are separated by a single space
- `<field-list>` and `timestamp` are separated by a single space
- Lines starting with `#` in the line protocol are comments and are ignored by the parser

Here are some simple examples of line protocol entries:

```text
# Ordinary example
some_measurement,host=my_host,region=my_region cpu_usage=0.01,memory_usage=1048576u 1710321406000000000

# Example without tags
some_measurement cpu_usage=0.01,memory_usage=1048576u 1710321406000000000

# Example without timestamp
some_measurement,host=my_host,region=my_region cpu_usage=0.01,memory_usage=1048576u

# Contains all basic types
some_measurement,host=my_host,region=my_region float=0.01,uint=1048576u,int=42i,string="my-host",boolean=T,binary="aGVsbG8="b,array=[1.414,3.14] 1710321406000000000
```

Some special escapes for field names and field values:

- `,` in `measurement` needs to be escaped
- `=` and `,` and spaces in tag keys and field keys need to be escaped
- `\n` is not allowed in `measurement`, tag keys, and field keys
- `\n` is not allowed in tag values, but it does not need to be escaped in field values
- If field value is a string, any `"` character needs to be escaped

#### JSON Body {#api-v1-write-body-json-protocol}

Compared to line protocol, JSON-formatted bodies require less escaping. A simple JSON structure is as follows:

```json
[
    {
        "measurement": "Mearsurement set name",

        "tags": {
            "key": "value",
            "another-key": "value"
        },

        "fields": {
            "key": value,
            "another-key": value # Here value can be number/bool/string/list
        },

        "time": unix-timestamp
    },

    {
        # another-point...
    }
]
```

Here is a simple JSON example:

```json
[
  {
    "measurement": "abc",
    "tags": {
      "t1": "b",
      "t2": "d"
    },
    "fields": {
      "f1": 123,
      "f2": 3.4,
      "f3": "strval"
    },
    "time": 1624550216000000000
  },
  {
    "measurement": "def",
    "tags": {
      "t1": "b",
      "t2": "d"
    },
    "fields": {
      "f1": 123,
      "f2": 3.4,
      "f3": "strval",
      "f4": false,
      "f5": [1, 2, 3, 4],
      "f6": ["str1", "str2", "str3"]
    },
    "time": 1624550216000000000
  }
]
```

<!-- markdownlint-disable MD046 -->
???+ warning

    Although this JSON structure is simple, it has several drawbacks:
    
    - It cannot distinguish between `int/uint/float` numeric types. For example, all numbers are handled as floats by JSON, so for a number like 42, JSON cannot determine if it is signed or unsigned.
    - It does not support binary (`[]byte`) data representation. While certain cases may automatically encode `[]byte` as base64 strings, JSON itself lacks a binary type.
    - It cannot represent additional information about specific fields, such as units or metric types (gauge/count/...).
<!-- markdownlint-enable -->

#### PB-JSON Body {#api-v1-write-body-pbjson-protocol}

[:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0) · [:octicons-beaker-24: Experimental](index.md#experimental)

Due to the limitations of simple JSON, it is recommended to use another JSON format. Its structure is as follows:

```json
[
  {
    "name": "point-1", # Mearsurement set name
    "fields": [...], # Specific field list, including Field and Tag
    "time": "1709523668830398000"
  },
  {
    # another point...
  }
]
```

The structure of a single field is as follows:

```json
{
  "key"    : "field-name",        # Field name (required)
  "x"      : <value>,             # Field value, type depends on x (required)
  "type"   : "<COUNT/GAUGE/...>", # Metric type (optional)
  "unit"   : "<kb/s/...>"         # Metric unit (optional)
  "is_tag" : true/false           # Whether it is a tag (optional)
}
```

Here `x` has several options listed below:

- `b`: Indicates that the value of this `key` is a boolean
- `d`: Indicates that the value of this `key` is a byte stream, possibly binary (`[]byte`), in JSON it must be base64 encoded
- `f`: Indicates that the value of this `key` is a floating-point type (float64)
- `i`: Indicates that the value of this `key` is a signed integer (int64)
- `s`: Indicates that the value of this `key` is a string type (string)
- `u`: Indicates that the value of this `key` is an unsigned integer (uint64)
- `a`: Indicates that the value of this `key` is a dynamic type (`any`), currently it only supports arrays. It has two secondary fields:
    - `@type`: string, fixed value `type.googleapis.com/point.Array`
    - `arr`: Array of objects, each element is of the form `{"x": <value>}`, where `x` is one of the basic types (`f/i/u/s/d/b`), but not `a`. Each element's `x` must be consistent

<!-- markdownlint-disable MD046 -->
???+ warning

    Here `i` and `u` as well as the `time` field of each Point are represented as strings in JSON
<!-- markdownlint-enable -->

Here is a specific JSON example:

```json
[
  {
    "name": "abc",
    "fields": [
      {
        "key": "say",
        "s": "hello"
      },
      {
        "key": "some-flag",
        "b": false
      },
      {
        "key": "binary-data",
        "d": "aGVsbG8gd29ybGQ="
      },
      {
        "key": "int-arr",
        "a": {
          "@type": "type.googleapis.com/point.Array",
          "arr": [
            { "i": "1" },
            { "i": "2" },
            { "i": "3" }
          ]
        }
      },
      {
        "key": "large-int",
        "i": "1234567890"
      },
      {
        "key": "large-bytes",
        "u": "1234567890",
        "type": "COUNT",
        "unit": "kb"
      },
      {
        "key": "some-tag",
        "s": "v1",
        "is_tag": true
      },
      {
        "key": "pi",
        "f": 3.14
      }
    ],
    "time": "1709523668830398000"
  }
]
```

---

<!-- markdownlint-disable MD046 -->
???+ attention

    - All Bodies, whether line protocol or other two JSON formats, are array structures, meaning at least one Point must be uploaded per submission.
    - For JSON-formatted Bodies, the `Content-Type: application/json` header must be set in the request; otherwise, DataKit parses it as line protocol.
    - Support for arrays in fields requires [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0) or higher (including) versions.
    - Compared to line protocol Bodies, JSON-formatted Bodies perform worse, approximately 7~8 times slower.
<!-- markdownlint-enable -->

---

### Data Types Classification {#category}

DataKit mainly includes the following data types (sorted alphabetically):

| Abbreviation | Name            | URL Representation                  | Description               |
| ---  | ---             | ---                       | ---                |
| CO   | `custom_object` | `/v1/write/custom_object` | Custom object data     |
| E    | `keyevent`      | `/v1/write/keyevent`      | Event data         |
| L    | `logging`       | `/v1/write/logging`       | Log data           |
| M    | `metric`        | `/v1/write/metric`        | Time Series data           |
| N    | `network`       | `/v1/write/network`       | Generally refers to eBPF data   |
| O    | `object`        | `/v1/write/object`        | Object data           |
| P    | `profiling`     | `/v1/write/profiling`     | Profiling data     |
| R    | `rum`           | `/v1/write/rum`           | RUM data           |
| S    | `security`      | `/v1/write/security`      | Security Check data       |
| T    | `tracing`       | `/v1/write/tracing`       | APM (Tracing) data |

---

### DataKit Data Structure Constraints {#point-limitation}

1. For all types of Points, if the measurement (or empty string) is missing, it automatically completes the `measurement` value to `__default`.
1. For Time Series Points (M), fields must not contain string values; DataKit will discard them automatically.
1. For non-Time Series Points, tag keys and field keys must not contain `.` characters; DataKit will replace them with `_`.
1. For Log Points (L), if the `status` field is missing (i.e., neither in tags nor fields), DataKit will set it to `unknown`.
1. For Object Points (O/CO), if the `name` field is missing (i.e., neither in tags nor fields), DataKit will set it to `default`.
1. Tag and Field keys must not be duplicated, i.e., the same key cannot appear in both Tags and Fields. Otherwise, the result is undefined.
1. Within Tags or Fields, duplicate keys are not allowed. Only one will be retained, and which one is undefined.
1. The number of Tags must not exceed 256; excess Tags will be truncated.
1. The number of Fields must not exceed 1024; excess Fields will be truncated.
1. Tag/Field Key length must not exceed 256 bytes; excess length will be truncated.
1. Tag Value length must not exceed 1024 bytes; excess length will be truncated.
1. Field Value length for strings or byte streams must not exceed 32M (32x1024x1024) bytes; excess length will be truncated.
1. If the field value is null (`null/nil`), the behavior is undefined.

---

### Line Protocol Error Analysis {#line-proto-parse-error}

[:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

If there is an error in the reported line protocol, the DataKit API will return the corresponding error code and detailed error information.

Assume we send the following line protocol content via HTTP POST to DataKit. This line protocol has two errors: the second and fourth lines are missing tag values for `t2`.

```not-set
# path/to/some/file.data
some1,t1=1,t2=v2 f1=1i,f2=3
some2,t1=1,t2 f1=1i,f2=3
some3,t1=1,t2=v3 f1=1i,f2=3
some2,t1=1,t2 f1=1i,f2=
```

```shell
$ curl -s http://datakit-ip:9529/v1/write/logging --data-binary "@path/to/some/file.data"

{
  "error_code": "datakit.invalidLinePoint",
  "message": "invalid lineprotocol: unable to parse 'some2,t1=1,t2 f1=1i,f2=3'(pos: 29): missing tag value\nunable to parse 'some2,t1=1,t2 f1=1i,f2='(pos: 82): missing tag value\nwith 2 point parse ok, 2 points failed. Origin data: \"some1,t1=1,t2=v2 f1=1i,f2=3\\nsome2,t1=1,t2 f1=1i,f2=3\\nsome3,t1=1,t2=v3 f1=1i,f2=3\\nsome2,t1=1,t2 f1=1i,f2=\\n\""
}
```

<!-- markdownlint-disable MD046 -->
???+ tips

    To better display the JSON in the request result, you can use tools like [jq](https://jqlang.github.io/jq/download/){:target="_blank"}. For example, you can extract the plain text from the complex `message` field directly using jq:

    ```shell
    $ curl -s http://datakit-ip:9529/v1/write/logging --data-binary "@path/to/some/file.data" | jq -r .message
    invalid lineprotocol: unable to parse 'some2,t1=1,t2 f1=1i,f2=3'(pos: 29): missing tag value
    unable to parse 'some2,t1=1,t2 f1=1i,f2='(pos: 82): missing tag value
    with 2 point parse ok, 2 points failed. Origin data: "some1,t1=1,t2=v2 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=3\nsome3,t1=1,t2=v3 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=\n"
    ```
<!-- markdownlint-enable -->

Here `message` expands to:

```not-set
invalid lineprotocol: unable to parse 'some2,t1=1,t2 f1=1i,f2=3'(pos: 29): missing tag value
unable to parse 'some2,t1=1,t2 f1=1i,f2='(pos: 82): missing tag value
with 2 point parse ok, 2 points failed. Origin data: "some1,t1=1,t2=v2 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=3\nsome3,t1=1,t2=v3 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=\n"
```

Interpretation of `message`:

- Since there are two errors, the returned information contains two `unable to parse...` messages. After each error, the position offset (`pos`) of the original data is provided for easier troubleshooting.
- The returned error message shows the number of successfully parsed and failed points.
- `Origin data...` includes the original HTTP Body (if it contains binary data, it will be shown in hexadecimal form like `\x00\x32\x54...`).

In DataKit logs, if the line protocol is incorrect, it will also record the relevant content of the `message`.

### Verify Uploaded Data {#review-post-point}

Regardless of the method used (`lp`/`pbjson`/`json`) to write data, DataKit will *attempt to correct the data*. These corrections may not be expected, but we can review the final data using the `echo` parameter:

<!-- markdownlint-disable MD046 -->
=== "PB-JSON Format (`echo=pbjson`)"

    Compared to the other two, using [PB-JSON](apis.md#api-v1-write-body-pbjson-protocol) can reveal details and reasons for corrections. If the Point structure is automatically corrected, the Point will have a `warns` field indicating the reason for correction.
    
    For example, log data does not allow `.` in field keys, and DataKit will automatically convert it to `_`. In this case, the reviewed JSON will include additional `warns` information:


    ```json
    [
       {
           "name": "...",
           "fields": [...],
           "time": "...",
           "warns": [
             {
                 "type": "dot_in_key",
                 "message": "invalid field key `some.field`: found `.'"
             }
           ]
       }
    ]
    ```

=== "Ordinary JSON (`echo=json`)"

    Refer to [Ordinary JSON Format](apis.md#api-v1-write-body-json-protocol)

=== "Line Protocol (`echo=lp`)"

    Refer to [Line Protocol Format](apis.md#api-v1-write-body-line-protocol)
<!-- markdownlint-enable -->

---

## `/v1/ping` {#api-ping}

Check if DataKit is running at the target address and retrieve the DataKit start time and version information. Example:

``` http
GET /v1/ping HTTP/1.1

HTTP/1.1 200 OK

{
  "content":{
    "version":"1.1.6-rc0",
    "uptime":"1.022205003s"
  }
}
```

## `/v1/lasterror` {#api-lasterror}

Used to report external collector errors. Example:

``` http
POST /v1/lasterror HTTP/1.1
Content-Type: application/json

{
  "input":"redis",
  "source":"us-east-9xwha",
  "err_content":"Cache avalanche"
}
```

## `/v1/query/raw` {#api-raw-query}

Use DQL to query data (only queries data from the workspace where the DataKit resides). Example:

``` http
POST /v1/query/raw HTTP/1.1
Content-Type: application/json

{
    "queries":[
        {
            "query": "cpu:(usage_idle) LIMIT 1",  # DQL query statement (required)
            "conditions": "",                     # Additional DQL query conditions
            "max_duration": "1d",                 # Maximum time range
            "max_point": 0,                       # Maximum number of points
            "time_range": [],                     #
            "orderby": [],                        #
            "disable_slimit": true,               # Disable default SLimit, when true, no default SLimit value will be added, otherwise SLimit 20 will be forced
            "disable_multiple_field": true        # Disable multiple fields. When true, only single-field data can be queried (excluding the time field)
        }
    ],
    "echo_explain":true
}
```

Parameter description

| Name                     | Description                                                                                                                                                                                                                         |
| :---                     | ---                                                                                                                                                                                                                          |
| `conditions`             | Additional condition expression using DQL syntax, for example `hostname="cloudserver01" OR system="ubuntu"`. This is in `AND` relation with existing `query` conditions and will be enclosed in parentheses to avoid confusion                                                          |
| `disable_multiple_field` | Whether to disable multiple fields. When true, only single-field data can be queried (excluding the time field), default is `false`                                                                                                                                     |
| `disable_slimit`         | Whether to disable default SLimit, when true, no default SLimit value will be added, otherwise SLimit 20 will be forced, default is `false`                                                                                                                          |
| `echo_explain`           | Whether to return the final execution statement (in the `raw_query` field of the returned JSON data)                                                                                                                                                                  |
| `highlight`              | Highlight search results                                                                                                                                                                                                                 |
| `limit`                  | Limit the number of points returned for a single timeline, overriding any existing limit in the DQL                                                                                                                                                                          |
| `max_duration`           | Limit the maximum query time, supports units `ns/us/ms/s/m/h/d/w/y`, for example `3d` is 3 days, `2w` is 2 weeks, `1y` is 1 year. Default is 1 year, this parameter also limits the `time_range` parameter                                                                           |
| `max_point`              | Limit the maximum aggregation points. When using aggregation functions, if the aggregation density is too low leading to too many points, it will replace the aggregation interval with `(end_time-start_time)/max_point`                                                                                          |
| `offset`                 | Generally used with `limit` for pagination                                                                                                                                                                                          |
| `orderby`                | Specify `order by` parameters, in the format of `map[string]string` array, `key` is the field name to sort, `value` can only be sorting order `asc` or `desc`, for example `[ { "column01" : "asc" }, { "column02" : "desc" } ]`. This will override the original `order by` in the query |
| `queries`                | Basic query module, including query statements and additional parameters                                                                                                                                                                                     |
| `query`                  | DQL query statement (DQL [documentation](../dql/define.md))                                                                                                                                                                                 |
| `search_after`           | Deep pagination, first call with an empty list: `"search_after": []`, after successful service response, reuse the returned list values for subsequent queries                                                                                                                     |
| `slimit`                 | Limit the number of timelines, overrides any existing `slimit` in the DQL                                                                                                                                                                                 |
| `time_range`             | Limit the time range, using timestamp format in milliseconds, array size of 2 integers. If only one element exists, it is considered the start time, overriding the original query time interval                                                                                            |

Return data example:

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "content": [
        {
            "series": [
                {
                    "name": "cpu",
                    "columns": [
                        "time",
                        "usage_idle"
                    ],
                    "values": [
                        [
                            1608612960000,
                            99.59595959596913
                        ]
                    ]
                }
            ],
            "cost": "25.093363ms",
            "raw_query": "SELECT \"usage_idle\" FROM \"cpu\" LIMIT 1",
        }
    ]
}
```

## `/v1/object/labels` | `POST` {#api-object-labels}

Create or update object `labels`

`request body` description

| Parameter           | Description                                                                          | Type       |
| ---:           | ---                                                                           | ---        |
| `object_class` | Represents the `object` type associated with the `labels`, such as `HOST`                               | `string`   |
| `object_name`  | Represents the `object` name associated with the `labels`, such as `host-123`                           | `string`   |
| `key`          | Represents the specific field name of the `object` associated with the `labels`, such as process name field `process_name`     | `string`   |
| `value`        | Represents the specific field value of the `object` associated with the `labels`, such as process name `systemsoundserverd` | `void`     |
| `labels`       | List of `labels`, an array of `string`s                                             | `[]string` |

Request example:

``` shell
curl -XPOST "127.0.0.1:9529/v1/object/labels" \
    -H 'Content-Type: application/json'  \
    -d'{
            "object_class": "host_processes",
            "object_name": "ubuntu20-dev_49392",
            "key": "host",
            "value": "ubuntu20-dev",
            "labels": ["l1","l2"]
        }'
```

Successful response example:

``` json
status_code: 200
{
    "content": {
        "_id": "375370265b0641xxxxxxxxxxxxxxxxxxxxxxxxxx"
    }
}
```

Failed response example:

``` json
status_code: 500
{
    "errorCode":"some-internal-error"
}
```

## `/v1/object/labels` | `DELETE` {#api-delete-object-labels}

Delete object `labels`

`request body` description

| Parameter           | Description                                                                          | Type     |
| ---:           | ---                                                                           | ---      |
| `object_class` | Represents the `object` type associated with the `labels`, such as `HOST`                               | `string` |
| `object_name`  | Represents the `object` name associated with the `labels`, such as `host-123`                           | `string` |
| `key`          | Represents the specific field name of the `object` associated with the `labels`, such as process name field `process_name`     | `string` |
| `value`        | Represents the specific field value of the `object` associated with the `labels`, such as process name `systemsoundserverd` | `void`   |

Request example:

``` shell
curl -XPOST "127.0.0.1:9529/v1/object/labels"  \
    -H 'Content-Type: application/json'  \
    -d'{
            "object_class": "host_processes",
            "object_name": "ubuntu20-dev_49392",
            "key": "host",
            "value": "ubuntu20-dev"
        }'
```

Successful response example:

``` json
status_code: 200
{
    "content": {
        "msg": "delete success!"
    }
}
```

Failed response example:

``` json
status_code: 500
{
    "errorCode": "some-internal-error"
}
```

## `/v1/pipeline/debug` | `POST` {#api-debug-pl}

Provides remote debugging functionality for PL.

Error information `PlError` structure:

```go
type Position struct {
    File string `json:"file"`
    Ln   int    `json:"ln"`
    Col  int    `json:"col"`
    Pos  int    `json:"pos"`
}

type PlError struct {
    PosChain []Position `json:"pos_chain"`
    Err      string     `json:"error"`
}
```

Error information JSON example:

```json
{
  "pos_chain": [
    { // Error generation location (script termination point)
      "file": "xx.p",    // Filename or file path
      "ln":   15,        // Line number
      "col":  29,        // Column number
      "pos":  576,       // Absolute position of the character in the text starting from 0
    },
    ... ,
    { // Starting point of the call chain
      "file": "b.p",
      "ln":   1,
      "col":  1,
      "pos":  0,
    },
  ],
  "error": "error msg"
}
```

Request example:

``` http
POST /v1/pipeline/debug
Content-Type: application/json

{
    "pipeline": {
      "<caregory>": {
        "<script_name>": <base64("pipeline-source-code")>
      }
    },
    "script_name": "<script_name>",
    "category": "<logging[metric, tracing, ...]>", # For log category, provide log text, for other categories provide line protocol text
    "data": [ base64("raw-logging-data1"), ... ], # Can be log or line protocol
    "data_type": "application/line-protocol",
    "encode": "@data character encoding",         # Default is utf8 encoding
    "benchmark": false                    # Whether to enable benchmark
}
```

Normal response example:

``` http
HTTP/1.``` http
1.1 200 OK

{
    "content": {
        "cost": "2.3ms",
        "benchmark": BenchmarkResult.String(), # Returns benchmark results
        "pl_errors": [],                       # List of PlError generated during script parsing or checking
        "plresults": [                         # Since logs can be multi-line, multiple split results are returned here
            {
                "point": {
                  "name" : "can be Mearsurement set name, log source, etc.",
                  "tags": { "key": "val", "other-key": "other-val"},
                  "fields": { "f1": 1, "f2": "abc", "f3": 1.2 }
                  "time": 1644380607,   # Unix timestamp (seconds), frontend can convert it to a readable date
                  "time_ns": 421869748, # Remaining nanoseconds for precise date conversion, complete nanosecond timestamp is 1644380607421869748
                }
                "dropped": false,  # Whether marked as pending discard during pipeline execution
                "run_error": null  # If no error, value is null
            },
            {  another-result },
            ...
        ]
    }
}
```

Error response example:

``` http
HTTP Code: 400

{
    "error_code": "datakit.invalidCategory",
    "message": "invalid category"
}
```

## `/v1/dialtesting/debug` | `POST` {#api-debug-dt}

Provides remote debugging functionality for Dial Testing, which can be controlled via [environment variables](../integrations/dialtesting.md#env) to disable network dialing.

Request example:

``` http
POST /v1/dialtesting/debug
Content-Type: application/json

{
    "task_type" : "http",//"http","tcp","icmp","websocket","multi"
    "task" : {
        "name"               : "",
        "method"             : "",
        "url"                : "",
        "post_url"           : "",
        "cur_status"         : "",
        "frequency"          : "",
        "enable_traceroute"  : true, // true means checked, only applicable for tcp and icmp
        "success_when_logic" : "",
        "SuccessWhen"        : []*HTTPSuccess ,
        "tags"               : map[string]string ,
        "labels"             : []string,
        "advance_options"    : *HTTPAdvanceOption,
    },
    "variables": {
      "variable_uuid": {
       "name": "token",
       "value": "token" 
      }
    }
}
```

Normal response example:

``` http
HTTP/1.1 200 OK

{
    "content": {
        "cost": "2.3ms",
        "status": "success", # success/fail
        "error_msg": "",
        "traceroute":[
          {
              "total"    : 3,
              "failed"   : 0,
              "loss"     : 0,
              "avg_cost" : 0,
              "min_cost" : 2,
              "max_cost" : 3,
              "std_cost" : 33,
              "items" : [
                  {
                      "ip"            : "127.0.0.1",
                      "response_time" : 33
                  }
              ]
         }
        ],
        "fields": {
          "config_vars": "",
          "url": "",
          "task": "",
          "post_script_variables": "{\"a\":1}"
        }
    }
}
```

Error response example:

``` http
HTTP Code: 400

{
    "error_code": "datakit.invalidClass",
    "message": "invalid class"
}
```

## `/v1/sourcemap` | `PUT` {#api-sourcemap-upload}

[:octicons-tag-24: Version-1.12.0](changelog.md#cl-1.12.0)

Upload sourcemap files, this interface requires enabling the [RUM collector](../integrations/rum.md).

Request parameter description.

| Parameter | Description                                                            | Type     |
| ---: | --- | --- |
| `token` | `datakit.conf` configuration's `dataway` address token                      | `string` |
| `app_id` | Unique ID identifier for user access application, such as `test-sourcemap`                            | `string` |
| `env` | Application deployment environment, such as `prod`                                                  | `string` |
| `version` | Application version, such as `1.0.0`                                                 | `string` |
| `platform` | Application type, optional values `web/miniapp/android/ios`, default `web`                | `string` |

Request example:

``` shell
curl -X PUT "http://localhost:9529/v1/sourcemap?app_id=test_sourcemap&env=production&version=1.0.0&token=tkn_xxxxx&platform=web" \
-F "file=@./sourcemap.zip" \
-H "Content-Type: multipart/form-data"
```

Successful response example:

``` json
{
  "content": "uploaded to [/path/to/datakit/data/rum/web/test_sourcemap-production-1.0.0.zip]!",
  "errorMsg": "",
  "success": true
}
```

Failed response example:

``` json
{
  "content": null,
  "errorMsg": "app_id not found",
  "success": false
}
```

## `/v1/sourcemap` | `DELETE` {#api-sourcemap-delete}

[:octicons-tag-24: Version-1.16.0](changelog.md#cl-1.16.0)

Delete sourcemap files, this interface requires enabling the [RUM collector](../integrations/rum.md).

Request parameter description.

| Parameter       | Description                                                    | Type     |
| ---:       | ---                                                     | ---      |
| `token`    | `datakit.conf` configuration's `dataway` address token    | `string` |
| `app_id`   | Unique ID identifier for user access application, such as `test-sourcemap`           | `string` |
| `env`      | Application deployment environment, such as `prod`                               | `string` |
| `version`  | Application version, such as `1.0.0`                                  | `string` |
| `platform` | Application type, optional values `web/miniapp/android/ios`, default `web` | `string` |

Request example:

``` shell
curl -X DELETE "http://localhost:9529/v1/sourcemap?app_id=test_sourcemap&env=production&version=1.0.0&token=tkn_xxxxx&platform=web"
```

Successful response example:

``` json
{
  "content":"deleted [/path/to/datakit/data/rum/web/test_sourcemap-production-1.0.0.zip]!",
  "errorMsg":"",
  "success":true
}
```

Failed response example:

``` json
{
  "content": null,
  "errorMsg": "delete sourcemap file [/path/to/datakit/data/rum/web/test_sourcemap-production-1.0.0.zip] failed: remove /path/to/datakit/data/rum/web/test_sourcemap-production-1.0.0.zip: no such file or directory",
  "success": false
}
```

## `/v1/sourcemap/check` | `GET` {#api-sourcemap-check}

[:octicons-tag-24: Version-1.16.0](changelog.md#cl-1.16.0)

Verify if the sourcemap file is correctly configured, this interface requires enabling the [RUM collector](../integrations/rum.md).

Request parameter description.

| Parameter          | Description                                                    | Type     |
| ---:          | ---                                                     | ---      |
| `error_stack` | Error stack information                                        | `string` |
| `app_id`      | Unique ID identifier for user access application, such as `test-sourcemap`           | `string` |
| `env`         | Application deployment environment, such as `prod`                               | `string` |
| `version`     | Application version, such as `1.0.0`                                  | `string` |
| `platform`    | Application type, optional values `web/miniapp/android/ios`, default `web` | `string` |

Request example:

``` shell
curl "http://localhost:9529/v1/sourcemap/check?app_id=test_sourcemap&env=production&version=1.0.0&error_stack=at%20test%20%40%20http%3A%2F%2Flocalhost%3A8080%2Fmain.min.js%3A1%3A48"
```

Successful response example:

``` json
{
  "content": {
    "error_stack": "at test @ main.js:6:6",
    "original_error_stack": "at test @ http://localhost:8080/main.min.js:1:48"
  },
  "errorMsg": "",
  "success": true
}

```

Failed response example:

``` json
{
  "content": {
    "error_stack": "at test @ http://localhost:8080/main.min.js:1:483",
    "original_error_stack": "at test @ http://localhost:8080/main.min.js:1:483"
  },
  "errorMsg": "fetch original source information failed, make sure sourcemap file [main.min.js.map] is valid",
  "success": false
}

```

## `/metrics` | `GET` {#api-metrics}

Retrieve Prometheus metrics exposed by DataKit.

## `/v1/global/host/tags` | `GET` {#api-global-host-tags-get}

Get global-host-tags.

Request example:

``` shell
curl 127.0.0.1:9529/v1/global/host/tags
```

Successful response example:

``` json
status_code: 200
Response: {
    "host-tags": {
        "h": "h",
        "host": "host-name"
    }
}
```

## `/v1/global/host/tags` | `POST` {#api-global-host-tags-post}

Create or update global-host-tags.

Request example:

``` shell
curl -X POST "127.0.0.1:9529/v1/global/host/tags?tag1=v1&tag2=v2"
```

Successful response example:

``` json
status_code: 200
Response: {
    "dataway-tags": {
        "e": "e",
        "h": "h",
        "tag1": "v1",
        "tag2": "v2",
        "host": "host-name"
    },
    "election-tags": {
        "e": "e"
    },
    "host-tags": {
        "h": "h",
        "tag1": "v1",
        "tag2": "v2",
        "host": "host-name"
    }
}
```

After successful modification, if in host mode, the changes will be persisted to the `datakit.conf` configuration file.

## `/v1/global/host/tags` | `DELETE` {#api-global-host-tags-delete}

Delete some global-host-tags.

Request example:

``` shell
curl -X DELETE "127.0.0.1:9529/v1/global/host/tags?tags=tag1,tag3"
```

Successful response example:

``` json
status_code: 200
Response: {
    "dataway-tags": {
        "e": "e",
        "h": "h",
        "host": "host-name"
    },
    "election-tags": {
        "e": "e"
    },
    "host-tags": {
        "h": "h",
        "host": "host-name"
    }
}
```

After successful modification, if in host mode, the changes will be persisted to the `datakit.conf` configuration file.

## `/v1/global/election/tags` | `GET` {#api-global-election-tags-get}

Get global-election-tags.

Request example:

``` shell
curl 127.0.0.1:9529/v1/global/election/tags
```

Successful response example:

``` json
status_code: 200
Response: {
    "election-tags": {
        "e": "e"
    }
}
```

## `/v1/global/election/tags` | `POST` {#api-global-election-tags-post}

Create or update global-election-tags.

Request example:

``` shell
curl -X POST "127.0.0.1:9529/v1/global/election/tags?tag1=v1&tag2=v2"
```

Successful response example:

``` json
status_code: 200
Response: {
    "dataway-tags": {
        "e": "e",
        "h": "h",
        "tag1": "v1",
        "tag2": "v2",
        "host": "host-name"
    },
    "election-tags": {
        "tag1": "v1",
        "tag2": "v2",
        "e": "e"
    },
    "host-tags": {
        "h": "h",
        "host": "host-name"
    }
}
```

After successful modification, if in host mode, the changes will be persisted to the `datakit.conf` configuration file.

When `global-election-enable = false` globally, this command is prohibited, failed response example:

``` json
status_code: 500
Response: {
    "message": "Can't use this command when global-election is false."
}
```

## `/v1/global/election/tags` | `DELETE` {#api-global-election-tags-delete}

Delete some global-election-tags.

Request example:

``` shell
curl -X DELETE "127.0.0.1:9529/v1/global/election/tags?tags=tag1,tag3"
```

Successful response example:

``` json
status_code: 200
Response: {
    "dataway-tags": {
        "e": "e",
        "h": "h",
        "host": "host-name"
    },
    "election-tags": {
        "e": "e"
    },
    "host-tags": {
        "h": "h",
        "host": "host-name"
    }
}
```

After successful modification, if in host mode, the changes will be persisted to the `datakit.conf` configuration file.

When `global-election-enable = false` globally, this command is prohibited, failed response example:

``` json
status_code: 500
Response: {
    "message": "Can't use this command when global-election is false."
}
```

## Further Reading {#more-reading}

- [API Access Configuration](datakit-conf.md#config-http-server)
- [API Rate Limiting Configuration](datakit-conf.md#set-http-api-limit)
- [API Security Control](../integrations/rum.md#security-setting)
```