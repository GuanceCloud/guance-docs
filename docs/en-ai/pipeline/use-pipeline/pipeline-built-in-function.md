# Built-in Functions {#functions}
---

Function parameter description:

- In function parameters, anonymous parameters (`_`) refer to the original input text data.
- JSON paths are directly represented as `x.y.z` without any additional decoration. For example, in `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`, the JSON path `a.third` indicates that the data to be operated on is `abc`.
- The relative order of all function parameters is fixed, and the engine will perform specific checks on them.
- All `key` parameters mentioned below refer to keys generated after initial extraction (through `grok()` or `json()`).
- JSON paths for processing support identifier notation and cannot use strings; if generating a new key, strings must be used.


## Function List {#function-list}

### `add_key()` {#fn-add-key}

Function prototype: `fn add_key(key, value)`

Function description: Adds a field to the point.

Function parameters

- `key`: Name of the new key
- `value`: Value of the key

Example:

```python
# Input data: {"age": 17, "name": "zhangsan", "height": 180}

# Processing script
add_key(city, "shanghai")

# Processing result
{
    "age": 17,
    "height": 180,
    "name": "zhangsan",
    "city": "shanghai"
}
```


### `add_pattern()` {#fn-add-pattern}

Function prototype: `fn add_pattern(name: str, pattern: str)`

Function description: Creates a custom grok pattern. Grok patterns have scope limitations, such as producing a new scope within `if else` statements, where this pattern is only valid within this scope. This function cannot override grok patterns that already exist in the same or previous scope.

Parameters:

- `name`: Pattern name
- `pattern`: Custom pattern content

Example:

```python
# Input data: "11,abc,end1", "22,abc,end1", "33,abc,end3"

# Pipeline script
add_pattern("aa", "\\d{2}")
grok(_, "%{aa:aa}")
if false {

} else {
    add_pattern("bb", "[a-z]{3}")
    if aa == "11" {
        add_pattern("cc", "end1")
        grok(_, "%{aa:aa},%{bb:bb},%{cc:cc}")
    } elif aa == "22" {
        # Using pattern cc here will cause a compilation failure: no pattern found for %{cc}
        grok(_, "%{aa:aa},%{bb:bb},%{INT:cc}")
    } elif aa == "33" {
        add_pattern("bb", "[\\d]{5}") # Overriding bb fails here
        add_pattern("cc", "end3")
        grok(_, "%{aa:aa},%{bb:bb},%{cc:cc}")
    }
}

# Processing result
{
    "aa":      "11"
    "bb":      "abc"
    "cc":      "end1"
    "message": "11,abc,end1"
}
{
    "aa":      "22"
    "message": "22,abc,end1"
}
{
    "aa":      "33"
    "bb":      "abc"
    "cc":      "end3"
    "message": "33,abc,end3"
}
```


### `adjust_timezone()` {#fn-adjust-timezone}

Function prototype: `fn adjust_timezone(key: int, minute: int)`

Function parameters

- `key`: Nanosecond timestamp, like the timestamp obtained from the `default_time(time)` function
- `minute`: The allowed number of minutes beyond the current time for the return value (integer), with a range of [0, 15], defaulting to 2 minutes

Function description: Adjusts the input timestamp so that the difference between it and the timestamp at the time of function execution falls within (-60+minute, minute] minutes; not applicable to data with a time difference exceeding this range, which would otherwise result in incorrect data. Calculation process:

1. Add hours to the value of `key` to bring it within the current hour
2. Calculate the minute difference between the two at this point, with both minute values ranging from [0, 60), and the difference ranging from (-60,0] and [0, 60)
3. If the difference is less than or equal to -60 + minute, add 1 hour; if greater than minute, subtract 1 hour
4. With the default value of minute being 2, the difference range is allowed to be (-58, 2]; if the current time is 11:10, the log time is 3:12:00.001, the final result is 10:12:00.001; if the current time is 11:59:1.000, the log time is 3:01:1.000, the final result is 12:01:1.000

Example:

```json
# Input 1 
{
    "time":"11 Jul 2022 12:49:20.937", 
    "second":2,
    "third":"abc",
    "forth":true
}
```

Script:

```python
json(_, time)      # Extract the time field (if the container timezone is UTC+0000)
default_time(time) # Convert the extracted time field into a timestamp
                   # Parse timezone-less data using the local timezone UTC+0800/UTC+0900... 
adjust_timezone(time)
                   # Automatically (re-)select timezone and calibrate time deviation
```

Executing `datakit pipeline -P <name>.p -F <input_file_name> --date`:

```json
# Output 1
{
  "message": "{\n    \"time\":\"11 Jul 2022 12:49:20.937\",\n    \"second\":2,\n    \"third\":\"abc\",\n    \"forth\":true\n}",
  "status": "unknown",
  "time": "2022-07-11T20:49:20.937+08:00"
}
```

Local time: `2022-07-11T20:55:10.521+08:00`

Parsing with only `default_time` according to the default local timezone (UTC+8) results in:

- Result for Input 1: `2022-07-11T12:49:20.937+08:00`

Using `adjust_timezone` results in:

- Result for Input 1: `2022-07-11T20:49:20.937+08:00`


### `agg_create()` {#fn-agg-create}

Function prototype: `fn agg_create(bucket: str, on_interval: str = "60s", on_count: int = 0, keep_value: bool = false, const_tags: map[string]string = nil, category: str = "M")`

Function description: Creates a Mearsurement for aggregation, setting either `on_interval` or `on_count` as the aggregation period. After aggregation, aggregated data is uploaded, and you can choose whether to retain the last aggregation data; this function is not suitable for central Pipeline.

Function parameters:

- `bucket`: String type, serving as the name of the aggregated Metrics set. If this bucket has already been created, the function does not perform any operation.
- `on_interval`: Default value `"60s"`, sets the aggregation period based on time, unit `s`, effective when value is greater than `0`; cannot be used simultaneously with `on_count` less than or equal to 0.
- `on_count`: Default value `0`, sets the aggregation period based on the number of processed points, effective when value is greater than `0`.
- `keep_value`: Default value `false`.
- `const_tags`: Custom tags, default empty.
- `category`: Data category for aggregated data, optional parameter, default value `"M"`, indicating Metrics data.

Example:

```python
agg_create("cpu_agg_info", on_interval = "30s")
```


### `agg_metric()` {#fn-agg-metric}

Function prototype: `fn agg_metric(bucket: str, new_field: str, agg_fn: str, agg_by: []string, agg_field: str, category: str = "M")`

Function description: Automatically takes values from fields named in the input data and uses them as tags for aggregated data, storing these aggregated data in the corresponding bucket; this function is not suitable for central Pipeline.

Function parameters:

- `bucket`: String type, the bucket corresponding to the Mearsurement set created by the `agg_create` function; if this bucket has not been created, the function does not perform any operation.
- `new_field`: Metric name in the aggregated data, with data type `float`.
- `agg_fn`: Aggregation function, can be one of `"avg"`,`"sum"`,`"min"`,`"max"`,`"set"`.
- `agg_by`: Fields named in the input data that will serve as tags for the aggregated data; these fields' values can only be string-type data.
- `agg_field`: Field name in the input data, automatically retrieves field values for aggregation.
- `category`: Data category for aggregated data, optional parameter, default value `"M"`, indicating Metrics data.

Example:

For logging category data:

Continuous multiple inputs:

- Sample Log One: `{"a": 1}`
- Sample Log Two: `{"a": 2}`

Script:

```python
agg_create("cpu_agg_info", on_interval="10s", const_tags={"tag1":"value_user_define_tag"})

set_tag("tag1", "value1")

field1 = load_json(_)

field1 = field1["a"]

agg_metric("cpu_agg_info", "agg_field_1", "sum", ["tag1", "host"], "field1")
```

Metric output:

```json
{
    "host": "your_hostname",
    "tag1": "value1",
    "agg_field_1": 3
}
```


### `append()` {#fn-append}

Function prototype: `fn append(arr, elem) arr`

Function description: Adds element `elem` to the end of array `arr`.

Parameters:

- `arr`: Array to which elements are added.
- `elem`: Element to be added.

Example:

```python
# Example 1
abc = ["1", "2"]
abc = append(abc, 5.1)
# abc = ["1", "2", 5.1]

# Example 2
a = [1, 2]
b = [3, 4]
c = append(a, b)
# c = [1, 2, [3, 4]]
```


### `b64dec()` {#fn-b64dec}

Function prototype: `fn b64dec(key: str)`

Function description: Decodes the string data obtained from the specified field using base64

Function parameters

- `key`: Field to be extracted

Example:

```python
# Input data {"str": "aGVsbG8sIHdvcmxk"}
json(_, `str`)
b64enc(`str`)

# Processing result
# {
#   "str": "hello, world"
# }
```


### `b64enc()` {#fn-b64enc}

Function prototype: `fn b64enc(key: str)`

Function description: Encodes the string data obtained from the specified field using base64

Function parameters

- `key`: Field to be extracted

Example:

```python
# Input data {"str": "hello, world"}
json(_, `str`)
b64enc(`str`)

# Processing result
# {
#   "str": "aGVsbG8sIHdvcmxk"
# }
```


### `cache_get()` {#fn-cache-get}

Function prototype: `fn cache_get(key: str) nil|str`

Function description: Retrieves the value corresponding to the key from the cache

Parameter:

- `key`: Key

Example:

```python
a = cache_get("a")
add_key(abc, a)
```


### `cache_set()` {#fn-cache-set}

Function prototype: `fn cache_set(key: str, value: str, expiration: int) nil`

Function description: Saves key-value pairs to the cache

Parameters:

- `key`: Key (required)
- `value`: Value (required)
- `expiration`: Expiration time (default=100s)

Example:

```python
a = cache_set("a", "123")
a = cache_get("a")
add_key(abc, a)
```


### `cast()` {#fn-cast}

Function prototype: `fn cast(key, dst_type: str)`

Function description: Converts the value of `key` to the specified type

Function parameters

- `key`: An extracted field
- `type`: Target type, supports `\"str\", \"float\", \"int\", \"bool\"`, target types should be enclosed in double quotes in English state

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) 
cast(first, "str")

# Processing result
{
  "first": "1"
}
```


### `cidr()` {#fn-cidr}

Function prototype: `fn cidr(ip: str, prefix: str) bool`

Function description: Determines whether an IP is within a CIDR block

Function parameters

- `ip`: IP address
- `prefix`: IP prefix, such as `192.0.2.1/24`

Example:

```python
# Input data:

# Processing script

ip = "192.0.2.233"
if cidr(ip, "192.0.2.1/24") {
    add_key(ip_prefix, "192.0.2.1/24")
}

# Processing result
{
  "ip_prefix": "192.0.2.1/24"
}
```


### `conv_traceid_w3c_to_dd()`  {#fn-conv-traceid-w3c-to-dd}

Function prototype: `fn conv_traceid_w3c_to_dd(key)`

Function description: Converts a hexadecimal encoded 128-bit/64-bit W3C Trace ID string (length 32 characters or 16 characters) to a decimal encoded 64-bit DataDog Trace ID string.

Function parameters

- `key`: 128-bit/64-bit Trace ID to be converted

Example:

```python

# Script input:

"18962fdd9eea517f2ae0771ea69d6e16"

# Script:

grok(_, "%{NOTSPACE:trace_id}")

conv_traceid_w3c_to_dd(trace_id)

# Result:

{
    "trace_id": "3089600317904219670",
}

```


### `cover()` {#fn-cover}

Function prototype: `fn cover(key: str, range: list)`

Function description: Performs data masking on the string data obtained from the specified field according to the range.

Function parameters

- `key`: Field to be extracted
- `range`: Masking string index range (`[start,end]`). `start` and `end` both support negative indices to express tracing back from the tail. A reasonable interval is sufficient; if `end` exceeds the maximum length of the string, it defaults to the maximum length.

Example:

```python
# Input data {"str": "13789123014"}
json(_, `str`)
cover(`str`, [8, 9])

# Input data {"abc": "13789123014"}
json(_, abc)
cover(abc, [2, 4])
```


### `create_point()` {#fn-create-point}

Function prototype: `fn create_point(name, tags, fields, ts = 0, category = "M", after_use = "")`

Function description: Creates new data and outputs it. This function is not suitable for central Pipeline.

Function parameters:

- `name`: Point name, considered as the name of a Metrics set, log source, etc.
- `tags`: Data labels
- `fields`: Data fields
- `ts`: Optional parameter, Unix nanosecond timestamp, default is current time
- `category`: Optional parameter, data category, supports category names and abbreviations, e.g., Metrics can be filled as `M` or `metric`, logs as `L` or `logging`
- `after_use`: Optional parameter, executes specified pl script on the created point after creation; if the original data type is L, and the created data category is M, the executed script is still under the L category


Example:

```py
# Input
'''
{"a": "b"}
'''
fields = load_json(_)
create_point("name_pt", {"a": "b"}, fields)
```


### `datetime()` {#fn-datetime}

Function prototype: `fn datetime(key, precision: str, fmt: str, tz: str = "")`

Function description: Converts a timestamp to a specified date format

Function parameters:

- `key`: Extracted timestamp
- `precision`: Timestamp precision (s, ms, us, ns)
- `fmt`: Date format, provides built-in date formats and supports custom date formats
- `tz`: Time zone (optional parameter), converts the timestamp to the specified time zone, defaults to the host's time zone

Built-in date formats:

| Built-in Format | Date                                  | Description                      |
| ---             | ---                                   | ---                              |
| "ANSI-C"        | "Mon Jan _2 15:04:05 2006"            |                                   |
| "UnixDate"      | "Mon Jan _2 15:04:05 MST 2006"        |                                   |
| "RubyDate"      | "Mon Jan 02 15:04:05 -0700 2006"      |                                   |
| "RFC822"        | "02 Jan 06 15:04 MST"                 |                                   |
| "RFC822Z"       | "02 Jan 06 15:04 -0700"               | RFC822 with numeric zone         |
| "RFC850"        | "Monday, 02-Jan-06 15:04:05 MST"      |                                   |
| "RFC1123"       | "Mon, 02 Jan 2006 15:04:05 MST"       |                                   |
| "RFC1123Z"      | "Mon, 02 Jan 2006 15:04:05 -0700"     | RFC1123 with numeric zone        |
| "RFC3339"       | "2006-01-02T15:04:05Z07:00"           |                                   |
| "RFC3339Nano"   | "2006-01-02T15:04:05.999999999Z07:00" |                                   |
| "Kitchen"       | "3:04PM"                              |                                   |

Custom date formats:

Can customize output date format through combinations of placeholders

| Character | Example | Description                                                          |
| ---       | ---     | ---                                                                  |
| a         | %a      | Abbreviated weekday, such as `Wed`                                   |
| A         | %A      | Full weekday, such as `Wednesday`                                    |
| b         | %b      | Abbreviated month, such as `Mar`                                     |
| B         | %B      | Full month, such as `March`                                          |
| C         | %c      | Century, current year divided by 100                                 |
| **d**     | %d      | Day of the month; range `[01, 31]`                                   |
| e         | %e      | Day of the month; range `[1, 31]`, padded with spaces                |
| **H**     | %H      | Hour using 24-hour clock; range `[00, 23]`                           |
| I         | %I      | Hour using 12-hour clock; range `[01, 12]`                           |
| j         | %j      | Day of the year, range `[001, 365]`                                  |
| k         | %k      | Hour using 24-hour clock; range `[0, 23]`                            |
| l         | %l      | Hour using 12-hour clock; range `[1, 12]`, padded with spaces        |
| **m**     | %m      | Month, range `[01, 12]`                                              |
| **M**     | %M      | Minute, range `[00, 59]`                                             |
| n         | %n      | Represents newline `\n`                                              |
| p         | %p      | `AM` or `PM`                                                         |
| P         | %P      | `am` or `pm`                                                         |
| s         | %s      | Seconds since 1970-01-01 00:00:00 UTC                                |
| **S**     | %S      | Seconds, range `[00, 60]`                                            |
| t         | %t      | Represents tab `\t`                                                  |
| u         | %u      | Weekday, Monday is 1, range `[1, 7]`                                 |
| w         | %w      | Weekday, Sunday is 0, range `[0, 6]`                                 |
| y         | %y      | Year, range `[00, 99]`                                               |
| **Y**     | %Y      | Decimal representation of the year                                   |
| **z**     | %z      | RFC 822/ISO 8601:1988 style timezone (such as `-0600` or `+0100`)    |
| Z         | %Z      | Timezone abbreviation, such as `CST`                                 |
| %         | %%      | Represents character `%`                                             |

Examples:

```python
# Input data:
#    {
#        "a":{
#            "timestamp": "1610960605000",
#            "second":2
#        },
#        "age":47
#    }

# Processing script
json(_, a.timestamp)
datetime(a.timestamp, 'ms', 'RFC3339')
```

```python
# Processing script
ts = timestamp()
datetime(ts, 'ns', fmt='%Y-%m-%d %H:%M:%S', tz="UTC")

# Output
{
  "ts": "2023-03-08 06:43:39"
}
```

```python
# Processing script
ts = timestamp()
datetime(ts, 'ns', '%m/%d/%y  %H:%M:%S %z', "Asia/Tokyo")

# Output
{
  "ts": "03/08/23  15:44:59 +0900"
}
```


### `decode()` {#fn-decode}

Function prototype: `fn decode(text: str, text_encode: str)`

Function description: Converts `text` to UTF8 encoding to handle original logs that are not UTF8 encoded. Currently supports utf-16le/utf-16be/gbk/gb18030 (these encoding names must be lowercase)

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```


### `default_time()` {#fn-defalt-time}

Function prototype: `fn default_time(key: str, timezone: str = "")`

Function description: Uses the extracted field as the final data timestamp

Function parameters

- `key`: Specified key, data type of the key must be string
- `timezone`: Specifies the timezone used for formatting the time text, optional parameter, defaults to the current system timezone, timezone examples `+8/-8/+8:30`

Supported formatted times for processing data

<!-- markdownlint-disable MD038 -->
| Date Format                                           | Date Format                                                | Date Format                                       | Date Format                          |
| -----                                              | ----                                                    | ----                                           | ----                              |
| `2014-04-26 17:24:37.3186369`                      | `May 8, 2009 5:57:51 PM`                                | `2012-08-03 18:31:59.257000000`                | `oct 7, 1970`                     |
| `2014-04-26 17:24:37.123`                          | `oct 7, '70`                                            | `2013-04-01 22:43`                             | `oct. 7, 1970`                    |
| `2013-04-01 22:43:22`                              | `oct. 7, 70`                                            | `2014-12-16 06:20:00 UTC`                      | `Mon Jan  2 15:04:05 2006`        |
| `2014-12-16 06:20:00 GMT`                          | `Mon Jan  2 15:04:05 MST 2006`                          | `2014-04-26 05:24:37 PM`                       | `Mon Jan 02 15:04:05 -0700 2006`  |
| `2014-04-26 13:13:43 +0800`                        | `Monday, 02-Jan-06 15:04:05 MST`                        | `2014-04-26 13:13:43 +0800 +08`                | `Mon, 02 Jan 2006 15:04:05 MST`   |
| `2014-04-26 13:13:44 +09:00`                       | `Tue, 11 Jul 2017 16:28:13 +0200 (CEST)`                | `2012-08-03 18:31:59.257000000 +0000 UTC`      | `Mon, 02 Jan 2006 15:04:05 -0700` |
| `2015-09-30 18:48:56.35272715 +0000 UTC`           | `Thu, 4 Jan 2018 17:53:36 +0000`                        | `2015-02-18 00:12:00 +0000 GMT`                | `Mon 30 Sep 2018 09:09:09 PM UTC` |
| `2015-02-18 00:12:00 +0000 UTC`                    | `Mon Aug 10 15:44:11 UTC+0100 2015`                     | `2015-02-08 03:02:00 +0300 MSK m=+0.000000001` | `Thu, 4 Jan 2018 17:53:36 +0000`  |
| `2015-02-08 03:02:00.001 +0300 MSK m=+0.000000001` | `Fri Jul 03 2015 18:04:07 GMT+0100 (GMT Daylight Time)` | `2017-07-19 03:21:51+00:00`                    | `September 17, 2012 10:09am`      |
| `2014-04-26`                                       | `September 17, 2012 at 10:09am PST-08`                  | `2014-04`                                      | `September 17, 2012, 10:10:09`    |
| `2014`                                             | `2014:3:31`                                             | `2014-05-11 08:20:13,787`                      | `2014:03:31`                      |
| `3.31.2014`                                        | `2014:4:8 22:05`                                        | `03.31.2014`                                   | `2014:04:08 22:05`                |
| `08.21.71`                                         | `2014:04:2 03:00:51`                                    | `2014.03`                                      | `2014:4:02 03:00:51`              |
| `2014.03.30`                                       | `2012:03:19 10:11:59`                                   | `20140601`                                     | `2012:03:19 10:11:59.3186369`     |
| `20140722105203`                                   | `2014 年 04 月 08 日 `                                  | `1332151919`                                   | `2006-01-02T15:04:05+0000`        |
| `1384216367189`                                    | `2009-08-12T22:15:09-07:00`                             | `1384216367111222`                             | `2009-08-12T22:15:09`             |
| `1384216367111222333`                              | `2009-08-12T22:15:09Z`                                  |
<!-- markdownlint-enable -->

JSON extraction example:

```python
# Original json
{
    "time":"06/Jan/2017:16:16:37 +0000",
    "second":2,
    "third":"abc",
    "forth":true
}

# Pipeline script
json(_, time)      # Extract the time field
default_time(time) # Convert the extracted time field to a timestamp

# Processing result
{
  "time": 1483719397000000000,
}
```

Text extraction example:

```python
# Original log text
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms

# Pipeline script
grok(_, '%{TIMESTAMP_ISO8601:log_time}')   # Extract log time and name the field log_time
default_time(log_time)                     # Convert the extracted log_time field to a timestamp

# Processing result
{
  "log_time": 1610358231887000000,
}

# For logging collected data, it is best to name the time field as time; otherwise, the logging collector will fill in the current time
rename("time", log_time)

# Processing result
{
  "time": 1610358231887000000,
}
```



### `delete()` {#fn-delete}

Function prototype: `fn delete(src: map[string]any, key: str)`

Function description: Deletes the `key` from the JSON map

```python

# Input
# {"a": "b", "b":[0, {"c": "d"}], "e": 1}

# Script
j_map = load_json(_)

delete(j_map["b"][-1], "c")

delete(j_map, "a")

add_key("j_map", j_map)

# Result:
# {
#   "j_map": "{\"b\":[0,{}],\"e\":1}",
# }
```


### `drop()` {#fn-drop}

Function prototype: `fn drop()`

Function description: Discards the entire log and does not upload it

```python
# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
if str_a == "2"{
  drop()
  exit()
}
json(_, str_b)

# Extracted data(drop: true, cost: 30.02µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a": "2"
# }
```



### `drop_key()` {#fn-drop-key}

Function prototype: `fn drop_key(key)`

Function description: Deletes the extracted field

Function parameters:

- `key`: Name of the field to be deleted

Example:

```python
# data = "{\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}"

# Processing script
json(_, age,)
json(_, name)
json(_, height)
drop_key(height)

# Processing result
{
    "age": 17,
    "name": "zhangsan"
}
```



### `drop_origin_data()` {#fn-drop-origin-data}

Function prototype: `fn drop_origin_data()`

Function description: Discards the initial text, otherwise the initial text is placed in the message field

Example:

```python
# Input data: {"age": 17, "name": "zhangsan", "height": 180}

# Remove message content from the result set
drop_origin_data()
```



### `duration_precision()` {#fn-duration-precision}

Function prototype: `fn duration_precision(key, old_precision: str, new_precision: str)`

Function description: Converts the precision of a duration, specifying the current precision and target precision. Supports conversion between s, ms, us, ns.

```python
# in << {"ts":12345}
json(_, ts)
cast(ts, "int")
duration_precision(ts, "ms", "ns")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "{\"ts\":12345}",
#   "ts": 12345000000
# }
```


### `exit()` {#fn-exit}

Function prototype: `fn exit()`

Function description: Ends the parsing of the current log line. If the `drop()` function is not called, it still outputs the parsed part.

```python
# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
if str_a == "2"{
  exit()
}
json(_, str_b)

# Extracted data(drop: false, cost: 48.233µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a": "2"
# }
```



### `format_int()` {#fn-format-int}

Function prototype: `fn format_int(val: int, base: int) str`

Function description: Converts a numerical value to a string of the specified base.

Parameters:

- `val