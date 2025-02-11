# DataKit API

---

This document primarily describes the HTTP API interfaces exposed by DataKit.

## API Overview {#intro}

DataKit currently only supports HTTP interfaces, mainly involving data writing and data querying.

### Obtaining Remote DataKit Version via API {#api-get-dk-version}

There are two ways to get the version number:

- Request the DataKit ping interface: `curl http://ip:9529/v1/ping`
- In the response Header of each subsequent API request, obtain the current DataKit version through `X-DataKit`

## `/v1/write/:category` | `POST` {#api-v1-write}

This API is used for reporting various types of data (`category`) to DataKit. URL parameter descriptions are as follows:

**`category`**

- Type: string
- Required: N
- Default Value: -
- Description: Currently supports `metric,logging,rum,object,custom_object,keyevent`. For example, if using `metric`, the URL should be written as `/v1/write/metric`.

**`dry`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: bool
- Required: N
- Default Value: false
- Description: Test mode, it just POSTs the Point to DataKit but does not actually upload it to Guance.

**`echo`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: enum
- Required: N
- Default Value: -
- Description: Possible values are `lp/json/pbjson`. `lp` indicates that the uploaded Point will be represented in line protocol format in the returned Body; others are [standard JSON](apis.md#api-v1-write-body-json-protocol) and [PB-JSON](apis.md#api-v1-write-body-pbjson-protocol).

**`encoding`** [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

- Type: string
- Required: N
- Default Value: -
- Description: Supports four compression methods: `gzip`, `deflate`, `br`, and `zstd`. If this parameter is passed, DataKit automatically decompresses the request body.

**`global_election_tags`** [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)

- Type: bool
- Required: N
- Default Value: false
- Description: Whether to append [global election tags](datakit-conf.md#set-global-tag).

**`ignore_global_host_tags`** [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)

- Type: bool
- Required: N
- Default Value: false
- Description: Whether to ignore [global host tags](datakit-conf.md#set-global-tag) on DataKit. By default, all data written through this interface will carry global host tags.

**`input`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: string
- Required: N
- Default Value: `datakit-http`
- Description: Data source name, which will be displayed on Datakit monitor for debugging purposes.

**`loose`** [:octicons-tag-24: Version-1.4.11](changelog.md#cl-1.4.11)

- Type: bool
- Required: N
- Default Value: true
- Description: Loose mode, DataKit attempts to fix non-compliant Points.

**`precision`** [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

- Type: enum
- Required: N
- Default Value: -
- Description: Data precision (supports `n/u/ms/s/m/h`). If not provided, it automatically identifies timestamp precision.

**`source`**

- Type: string
- Required: N
- Default Value: -
- Description: If `source` (or corresponding *source.p*) is not specified or invalid, the uploaded Point data will not execute Pipeline.

**`strict`** [:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9)

- Type: bool
- Required: N
- Default Value: false
- Description: Strict mode, API directly returns an error for non-compliant line protocols and specifies the reason.

<!-- markdownlint-disable MD046 -->
???+ attention

    - The following parameters have been deprecated [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

        - `echo_line_proto`: Replaced by the `echo` parameter
        - `echo_json`: Replaced by the `echo` parameter

    - Although multiple parameters are of type bool, do not pass `false` values if you don't need to enable the corresponding option. The API only checks whether there is a value for the parameter, regardless of its content.
    - Automatic identification of time precision (`precision`) ([:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)) means guessing the possible time precision based on the input timestamp value. Mathematically, it cannot guarantee correctness but is sufficient for daily use. For example, for a timestamp like 1716544492, it would be considered seconds, while 1716544492000 would be milliseconds.
    - If no timestamp is included in the data point, the machine's timestamp where DataKit resides will be used.
    - Although binary format and any format are supported by the protocol, these two types of data are not yet supported for writing at the center. **Note this specifically**.
<!-- markdownlint-enable -->

### Body Description {#api-v1-write-body}

HTTP body supports line protocol and two forms of JSON.

#### Line Protocol Body {#api-v1-write-body-line-protocol}

A single line protocol entry looks like this:

```text
measurement,<tag-list> <field-list> timestamp
```

Multiple line protocol entries are separated by newlines:

```text
measurement_1,<tag-list> <field-list> timestamp
measurement_2,<tag-list> <field-list> timestamp
```

Where:

- `measurement` is the name of the Mearsurement set, representing a collection of Metrics, e.g., under the Mearsurement set name `disk`, there may be metrics like `free/used/total`.
- `<tag-list>` is a list of tags, separated by `,`. A single tag is in the form `key=value`, where `value` is treated as a string. In line protocol, `<tag-list>` is **optional**.
- `<field-list>` is a list of fields, separated by `,`. In line protocol, `<field-list>` is **required**. A single field is in the form `key=value`, with `value` varying by type:
    - int example: `some_int=42i`, i.e., appending an `i` after the integer value
    - uint example: `some_uint=42u`, i.e., appending a `u` after the integer value
    - float example: `some_float_1=3.14,some_float_2=3`, here `some_float_2` is an integer 3 but is still considered a float
    - string example: `some_string="hello world"`, string values need to be enclosed in `"`
    - bool example: `some_true=T,some_false=F`, `T/F` can also be represented as `t/f/true/false`
    - binary example: `some_binary="base-64-encode-string"b`, binary data (byte streams `[]byte`) needs base64 encoding to be represented in line protocol, similar to strings but with a trailing `b`
    - array example: `some_array=[1i,2i,3i]`, note that the type inside the array must be basic types (`int/uint/float/boolean/string/[]byte`, **no arrays**) and must be consistent, like `invalid_array=[1i,3.14,"string"]` is unsupported

- `timestamp` is an integer timestamp. By default, DataKit handles this timestamp in nanoseconds. If the original data is not in nanoseconds, specify the actual timestamp precision using the request parameter `precision`. In line protocol, `timestamp` is optional; if not present, DataKit uses the time when it receives the data as the current line protocol time.

Between these parts:

- `measurement` and `<tag-list>` are separated by `,`
- `<tag-list>` and `<field-list>` are separated by a single space
- `<field-list>` and `timestamp` are separated by a single space
- Lines starting with `#` in the line protocol are comments and are ignored by the parser

Here are some simple line protocol examples:

```text
# Standard example
some_measurement,host=my_host,region=my_region cpu_usage=0.01,memory_usage=1048576u 1710321406000000000

# Example without tags
some_measurement cpu_usage=0.01,memory_usage=1048576u 1710321406000000000

# Example without timestamp
some_measurement,host=my_host,region=my_region cpu_usage=0.01,memory_usage=1048576u

# Contains all basic types
some_measurement,host=my_host,region=my_region float=0.01,uint=1048576u,int=42i,string="my-host",boolean=T,binary="aGVsbG8="b,array=[1.414,3.14] 1710321406000000000
```

Special escaping for certain characters in field names and field values:

- In `measurement`, `,` needs to be escaped
- In tag keys and field keys, `=`, `,`, and spaces need to be escaped
- `\n` is not allowed in `measurement`, tag keys, and field keys
- `\n` is not allowed in tag values, but field values do not need to escape newlines
- If a field value is a string, any `"` within the string also needs to be escaped

#### JSON Body {#api-v1-write-body-json-protocol}

Compared to line protocol, JSON-formatted bodies require less escaping. Here is a simple JSON structure:

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
            "another-key": value # Here, value can be number/bool/string/list
        },

        "time": unix-timestamp
    },

    {
        # another-point...
    }
]
```

Below is a simple JSON example:

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

    This JSON structure, though simple, has several drawbacks:
    
    - It cannot distinguish between int/uint/float types, as JSON defaults to treating all numbers as floats. For example, for the number 42, JSON cannot determine if it is signed or unsigned.
    - It does not support binary (`[]byte`) data: although JSON encoding automatically represents `[]byte` as base64 strings in some cases, JSON itself has no binary type representation.
    - It cannot represent additional information about specific fields, such as units or metric types (gauge/count/...).
<!-- markdownlint-enable -->

#### PB-JSON Body {#api-v1-write-body-pbjson-protocol}

[:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0) · [:octicons-beaker-24: Experimental](index.md#experimental)

Due to the limitations of simple JSON, another JSON format is recommended, with the following structure:

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

Here, `x` has several options:

- `b`: Indicates that the `key` value is a boolean
- `d`: Indicates that the `key` value is a byte stream, possibly binary (`[]byte`), encoded in base64 in JSON
- `f`: Indicates that the `key` value is a floating-point type (float64)
- `i`: Indicates that the `key` value is a signed integer (int64)
- `s`: Indicates that the `key` value is a string type (string)
- `u`: Indicates that the `key` value is an unsigned integer (uint64)
- `a`: Indicates that the `key` value is a dynamic type (`any`), currently only supporting arrays. It has two secondary fields:
    - `@type`: string, fixed value `type.googleapis.com/point.Array`
    - `arr`: object array, each element is `{"x": <value>}`, where `x` is one of the basic types (`f/i/u/s/d/b`), excluding `a`. Each element's `x` must be consistent

<!-- markdownlint-disable MD046 -->
???+ warning

    Here, `i` and `u` as well as the `time` field value of each Point are represented as strings in JSON.
<!-- markdownlint-enable -->

Here is a concrete JSON example:

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

    - All Bodies, whether line protocol or other two JSON formats, are array structures, meaning each upload contains at least one Point.
    - For JSON-formatted Bodies, `Content-Type: application/json` must be specified in the Header, otherwise DataKit parses it as line protocol.
    - Support for arrays in fields requires [:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0) or later versions.
    - Compared to line protocol Bodies, JSON-formatted bodies perform worse, roughly 7~8 times slower.
<!-- markdownlint-enable -->

---

### Data Type Categories {#category}

DataKit mainly has the following data types (listed alphabetically):

| Abbreviation | Name               | URL Representation              | Description       |
| ---          | ---                | ---                             | ---               |
| CO           | `custom_object`    | `/v1/write/custom_object`       | Custom object data|
| E            | `keyevent`         | `/v1/write/keyevent`            | Event data        |
| L            | `logging`          | `/v1/write/logging`             | Log data          |
| M            | `metric`           | `/v1/write/metric`              | Time series data  |
| N            | `network`          | `/v1/write/network`             | Generally refers to eBPF data |
| O            | `object`           | `/v1/write/object`              | Object data       |
| P            | `profiling`        | `/v1/write/profiling`           | Profiling data    |
| R            | `rum`              | `/v1/write/rum`                 | RUM data          |
| S            | `security`         | `/v1/write/security`            | Security check data |
| T            | `tracing`          | `/v1/write/tracing`             | APM (Tracing) data|

---

### DataKit Data Structure Constraints {#point-limitation}

1. For all types of Points, if measurement is missing (or empty string), `measurement` is automatically set to `__default`.
1. For time series Points (M), fields cannot contain string values; DataKit automatically discards them.
1. For non-time series Points, tag keys and field keys cannot contain `.` characters; DataKit automatically replaces them with `_`.
1. For log Points (L), if the `status` field is missing (in both tags and fields), DataKit sets it to `unknown`.
1. For object Points (O/CO), if the `name` field is missing (in both tags and fields), DataKit sets it to `default`.
1. Tag and Field keys cannot be duplicated, i.e., the same key cannot appear in both Tags and Fields. Otherwise, which key value gets written is undefined.
1. Within Tags or Fields, duplicate keys are not allowed. Only one instance of a duplicate key is retained, and which one is undefined.
1. The number of Tags cannot exceed 256; exceeding this limit will truncate the excess Tags.
1. The number of Fields cannot exceed 1024; exceeding this limit will truncate the excess Fields.
1. Tag/Field Key length cannot exceed 256 bytes; exceeding this limit will truncate the excess.
1. Tag Value length cannot exceed 1024 bytes; exceeding this limit will truncate the excess.
1. Field Value length for strings or byte streams cannot exceed 32MB (32x1024x1024 bytes); exceeding this limit will truncate the excess.
1. If the field value is null (`null/nil`), the final behavior is undefined.

---

### Line Protocol Error Analysis {#line-proto-parse-error}

[:octicons-tag-24: Version-1.30.0](changelog.md#cl-1.30.0)

If the reported line protocol is incorrect, the DataKit API will return the corresponding error code and detailed error message.

Assume we send the following line protocol content via HTTP POST to DataKit. There are two errors in the second and fourth lines where `t2` lacks a tag value.

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

    To better display the JSON in the request result, you can use tools like [jq](https://jqlang.github.io/jq/download/){:target="_blank"}. For example, the complex `message` field can be extracted into plain text using jq:

    ```shell
    $ curl -s http://datakit-ip:9529/v1/write/logging --data-binary "@path/to/some/file.data" | jq -r .message
    invalid lineprotocol: unable to parse 'some2,t1=1,t2 f1=1i,f2=3'(pos: 29): missing tag value
    unable to parse 'some2,t1=1,t2 f1=1i,f2='(pos: 82): missing tag value
    with 2 point parse ok, 2 points failed. Origin data: "some1,t1=1,t2=v2 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=3\nsome3,t1=1,t2=v3 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=\n"
    ```
<!-- markdownlint-enable -->

The `message` expands to:

```not-set
invalid lineprotocol: unable to parse 'some2,t1=1,t2 f1=1i,f2=3'(pos: 29): missing tag value
unable to parse 'some2,t1=1,t2 f1=1i,f2='(pos: 82): missing tag value
with 2 point parse ok, 2 points failed. Origin data: "some1,t1=1,t2=v2 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=3\nsome3,t1=1,t2=v3 f1=1i,f2=3\nsome2,t1=1,t2 f1=1i,f2=\n"
```

Interpretation of `message`:

- Since there are two errors, the returned message contains two `unable to parse...` messages. After each error, the position offset (`pos`) of the original data is provided to aid in troubleshooting.
- The returned error message shows the number of successfully and unsuccessfully parsed points.
- `Origin data...` includes the original HTTP Body (if it contains binary data, it will be shown in hexadecimal form like `\x00\x32\x54...`).

In DataKit logs, if the line protocol is incorrect, the relevant content from this `message` will also be recorded.

### Verifying Uploaded Data {#review-post-point}

Regardless of the method used (`lp`/`pbjson`/`json`) to write data, DataKit attempts to correct the data. These corrections may not be expected, but we can review the final data using the `echo` parameter:

<!-- markdownlint-disable MD046 -->
=== "PB-JSON Format (`echo=pbjson`)"

    Compared to the other two, using [PB-JSON](apis.md#api-v1-write-body-pbjson-protocol) allows us to see the details and reasons for the corrections. If the Point structure is automatically corrected, the Point will include a `warns` field indicating the reason for the correction.

    For example, log data does not allow `.` in field keys, so DataKit automatically converts it to `_`. The reviewed JSON will include additional `warns` information:

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

=== "Standard JSON (`echo=json`)"

    Refer to [standard JSON format](apis.md#api-v1-write-body-json-protocol)

=== "Line Protocol (`echo=lp`)"

    Refer to [line protocol format](apis.md#api-v1-write-body-line-protocol)
<!-- markdownlint-enable -->

---

## `/v1/ping` {#api-ping}

Checks if DataKit is running at the target address and retrieves startup time and version information. Example:

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

Queries data using DQL (only queries data from the workspace where DataKit is located). Example:

``` http
POST /v1/query/raw HTTP/1.1
Content-Type: application/json

{
    "queries":[
        {
            "query": "cpu:(usage_idle) LIMIT 1",  # DQL query statement (required)
            "conditions": "",                     # Additional DQL query conditions
            "max_duration": "1d",                 # Maximum time range
            "max_point": 0,                       # Maximum point count
            "time_range": [],                     #
            "orderby": [],                        #
            "disable_slimit": true,               # Disable default SLimit, when true, no default SLimit value is added, otherwise SLimit 20 is forced
            "disable_multiple_field": true        # Disable multiple fields. When true, only single-field data (excluding time field) can be queried
        }
    ],
    "echo_explain":true
}
```

Parameter description

| Name                    | Description                                                                                                                                                                                                                         |
| :---                    | ---                                                                                                                                                                                                                                 |
| `conditions`            | Additional condition expression using DQL syntax, for example `hostname="cloudserver01" OR system="ubuntu"`. This is in `AND` relation with existing conditions in `query` and outer parentheses are added to avoid confusion                                               |
| `disable_multiple_field`| Whether to disable multiple fields. When true, only single-field data (excluding time field) can be queried, default is `false`                                                                                                     |
| `disable_slimit`        | Whether to disable default SLimit. When true, no default SLimit value is added, otherwise SLimit 20 is forced, default is `false`                                                                                                  |
| `echo_explain`          | Whether to return the final execution statement (in the `raw_query` field of the returned JSON data)                                                                                                                                |
| `highlight`             | Highlight search results                                                                                                                                                                                                            |
| `limit`                 | Limit the number of points returned per timeline, overriding any existing limit in DQL                                                                                                                                             |
| `max_duration`          | Restrict the maximum query time, supports units `ns/us/ms/s/m/h/d/w/y`, e.g., `3d` is 3 days, `2w` is 2 weeks, `1y` is 1 year. Default is 1 year, this parameter also restricts `time_range`                                           |
| `max_point`             | Restrict the maximum aggregation point count. When using aggregation functions, if the aggregation density is too low resulting in too many points, `(end_time-start_time)/max_point` calculates the new aggregation interval to replace it |
| `offset`                | Generally used with `limit` for pagination                                                                                                                                                                                          |
| `orderby`               | Specify `order by` parameters, format is `map[string]string` array, `key` is the field name to sort, `value` can only be sorting order `asc` or `desc`, e.g., `[ { "column01" : "asc" }, { "column02" : "desc" } ]`. This overrides the original `order by` in the query |
| `queries`               | Basic query module, containing the query statement and additional parameters                                                                                                                                                    |
| `query`                 | DQL query statement (DQL [documentation](../dql/define.md))                                                                                                                                          |
| `search_after`          | Deep pagination, first call with empty list: `"search_after": []`, after successful service-side response, reuse the returned list for subsequent queries via `search_after`                                                     |
| `slimit`                | Limit the number of timelines, overriding any existing `slimit` in DQL                                                                                                                                                            |
| `time_range`            | Restrict the time range, in timestamp format, unit millisecond, array size 2 of int, if only one element it is considered start time, overriding the original query time interval                                                                              |

Example of returned data:

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

Creates or updates object `labels`

`request body` description

| Parameter           | Description                                                                          | Type       |
| ---:                | ---                                                                                  | ---        |
| `object_class`      | Indicates the `object` type associated with `labels`, e.g., `HOST`                  | `string`   |
| `object_name`       | Indicates the `object` name associated with `labels`, e.g., `host-123`              | `string`   |
| `key`               | Indicates the specific field name of the `object` associated with `labels`, e.g., process name field `process_name` | `string`   |
| `value`             | Indicates the specific field value of the `object` associated with `labels`, e.g., process name `systemsoundserverd` | `void`     |
| `labels`            | List of `labels`, an array of `string`                                              | `[]string` |

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

Deletes object `labels`

`request body` description

| Parameter           | Description                                                                          | Type     |
| ---:                | ---                                                                                  | ---      |
| `object_class`      | Indicates the `object` type associated with `labels`, e.g., `HOST`                  | `string` |
| `object_name`       | Indicates the `object` name associated with `labels`, e.g., `host-123`              | `string` |
| `key`               | Indicates the specific field name of the `object` associated with `labels`, e.g., process name field `process_name` | `string` |
| `value`             | Indicates the specific field value of the `object` associated with `labels`, e.g., process name `systemsoundserverd` | `void`   |

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

Provides remote debugging capabilities for PL.

Error message `PlError` structure:

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

Error message JSON example:

```json
{
  "pos_chain": [
    { // Error generation location (script termination point)
      "file": "xx.p",    // Filename or file path
      "ln":   15,        // Line number
      "col":  29,        // Column number
      "pos":  576,       // Absolute character position in the text starting from 0
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
    "category": "<logging[metric, tracing, ...]>", # Pass log text for log category, line protocol text for other categories
    "data": [ base64("raw-logging-data1"), ... ], # Can be log or line protocol
    "data_type": "application/line-protocol",
    "encode": "@data character encoding",         # Default is utf8 encoding
    "benchmark": false                            # Whether to enable benchmark
}
```

Normal response example:

``` http
HTTP/1.1 200 OK

{
    "content": {
        "cost": "2.3ms",
        "benchmark": BenchmarkResult.String(), # Returns benchmark results
        "pl_errors": [],                       # List of PlError generated during script parsing or checking
        "plresults": [                         # Due