# Built-in Functions {#functions}
---

### Function Parameter Explanation:

- In function parameters, anonymous parameters (`_`) refer to the original input text data.
- JSON paths are directly represented as `x.y.z` without any additional decoration. For example, in `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`, the JSON path `a.third` indicates that the data to be operated on is `abc`.
- The relative order of all function parameters is fixed, and the engine will perform specific checks on them.
- All `key` parameters mentioned below refer to keys generated after initial extraction (through `grok()` or `json()`).
- The path for processing JSON supports identifier notation and cannot use strings. If generating a new key, strings must be used.

## Function List {#function-list}

### `add_key()` {#fn-add-key}

Function prototype: `fn add_key(key, value)`

Function description: Add a field to the point

Function parameters:

- `key`: Name of the new key
- `value`: Value of the key

Example:

```python
# Input data: {"age": 17, "name": "zhangsan", "height": 180}

# Processing script
add_key("city", "shanghai")

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

Function description: Create a custom grok pattern. Grok patterns have scope limitations; if created within an `if else` statement, the pattern is only valid within that scope. This function cannot override grok patterns that already exist in the same or previous scope.

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
        # Using pattern cc here will cause compilation failure: no pattern found for %{cc}
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

Function parameters:

- `key`: Nanosecond timestamp, such as the timestamp obtained after processing by the `default_time(time)` function.
- `minute`: An integer allowing the return value to exceed the current time by minutes, with a range of [0, 15], defaulting to 2 minutes.

Function description: Adjusts the input timestamp so that the difference between it and the execution timestamp of the function falls within (-60+minute, minute]. Data outside this range may lead to incorrect results. Calculation process:

1. Add hours to the value of `key` to place it within the current hour.
2. Calculate the minute difference at this point; both minute values range from [0, 60), and the difference ranges from (-60,0] and [0, 60).
3. If the difference is less than or equal to -60 + minute, add 1 hour; if greater than minute, subtract 1 hour.
4. With a default `minute` value of 2, the allowed difference range is (-58, 2]; if the current time is 11:10 and the log time is 3:12:00.001, the final result is 10:12:00.001; if the current time is 11:59:1.000 and the log time is 3:01:1.000, the final result is 12:01:1.000.

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
json(_, time)      # Extract the time field (if the container's timezone is UTC+0000)
default_time(time) # Convert the extracted time field to a timestamp
                   # (parse timezone-less data using local timezone UTC+0800/UTC+0900... etc.)
adjust_timezone(time)
                   # Automatically (re)select timezone, calibrate time deviation
```

Execute `datakit pipeline -P <name>.p -F <input_file_name>  --date`:

```json
# Output 1
{
  "message": "{\n    \"time\":\"11 Jul 2022 12:49:20.937\",\n    \"second\":2,\n    \"third\":\"abc\",\n    \"forth\":true\n}",
  "status": "unknown",
  "time": "2022-07-11T20:49:20.937+08:00"
}
```

Local time: `2022-07-11T20:55:10.521+08:00`

Using only `default_time` parsed according to the default local timezone (UTC+8):

- Result for Input 1: `2022-07-11T12:49:20.937+08:00`

After using `adjust_timezone`:

- Result for Input 1: `2022-07-11T20:49:20.937+08:00`


### `agg_create()` {#fn-agg-create}

Function prototype: `fn agg_create(bucket: str, on_interval: str = "60s", on_count: int = 0, keep_value: bool = false, const_tags: map[string]string = nil, category: str = "M")`

Function description: Create a Mearsurement for aggregation, set the aggregation period using `on_interval` or `on_count`. After aggregation, upload aggregated data, choosing whether to retain the last aggregation data; this function is not applicable to central Pipelines.

Function parameters:

- `bucket`: String type, as the name of the Mearsurement for the aggregated metrics. If this bucket has already been created, the function does nothing.
- `on_interval`: Default value `60s`, sets the aggregation period based on time, unit `s`, effective when the value is greater than `0`; cannot be used simultaneously with `on_count` less than or equal to 0.
- `on_count`: Default value `0`, sets the aggregation period based on the number of processed points, effective when the value is greater than `0`.
- `keep_value`: Default value `false`.
- `const_tags`: Custom tags, default empty.
- `category`: Category of aggregated data, optional parameter, default value "M", indicating metric category data.

Example:

```python
agg_create("cpu_agg_info", on_interval = "30s")
```


### `agg_metric()` {#fn-agg-metric}

Function prototype: `fn agg_metric(bucket: str, new_field: str, agg_fn: str, agg_by: []string, agg_field: str, category: str = "M")`

Function description: Automatically takes the value of the specified field name from the input data and uses it as tag for aggregated data, storing these aggregated data in the corresponding bucket; this function is not applicable to central Pipelines.

Function parameters:

- `bucket`: String type, the bucket corresponding to the Mearsurement created by the `agg_create` function. If this bucket has not been created, the function does nothing.
- `new_field`: Metric name in the aggregated data, whose data type is `float`.
- `agg_fn`: Aggregation function, can be one of `"avg"`,`"sum"`,`"min"`,`"max"`,`"set"`.
- `agg_by`: Field names from the input data, which will be used as tags for the aggregated data; these fields' values can only be string data.
- `agg_field`: Field name from the input data, automatically retrieves field values for aggregation.
- `category`: Category of aggregated data, optional parameter, default value "M", indicating metric category data.

Example:

For log category data:

Multiple consecutive inputs:

- Sample log one: `{"a": 1}`
- Sample log two: `{"a": 2}`

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

Function description: Append element `elem` to the end of array `arr`.

Parameters:

- `arr`: Array to append elements to.
- `elem`: Element to append.

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

Function description: Decode the base64 encoded string data obtained from the specified field.

Function parameters

- `key`: Target field to decode

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

Function description: Encode the string data obtained from the specified field into base64.

Function parameters

- `key`: Target field to encode

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

Function description: Retrieve the value associated with the key from the cache.

Parameter:

- `key`: Key

Example:

```python
a = cache_get("a")
add_key(abc, a)
```


### `cache_set()` {#fn-cache-set}

Function prototype: `fn cache_set(key: str, value: str, expiration: int) nil`

Function description: Save the key-value pair to the cache.

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

Function description: Convert the value of `key` to the specified type.

Function parameters

- `key`: An already extracted field
- `type`: Target type, supporting `"str"`, `"float"`, `"int"`, `"bool"`; target types need to be enclosed in double quotes in English state

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

Function description: Determine if the IP is within a certain CIDR block.

Function parameters

- `ip`: IP address
- `prefix`: IP prefix, e.g., `192.0.2.1/24`

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

Function description: Convert a hexadecimal-encoded 128-bit/64-bit W3C Trace ID string (length 32 characters or 16 characters) to a decimal-encoded 64-bit DataDog Trace ID string.

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

Function description: Mask the data of the specified field according to the specified range.

Function parameters

- `key`: Target field to mask
- `range`: Index range for masking the string ( `[start,end]` ), `start` and `end` support negative indices to express tracing back from the end. A reasonable range is sufficient; if `end` exceeds the maximum length of the string, it defaults to the maximum length.

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

Function description: Create new data and output it. This function is not applicable to central Pipelines.

Function parameters:

- `name`: Point name, considered as the name of the Mearsurement or log source
- `tags`: Data tags
- `fields`: Data fields
- `ts`: Optional parameter, Unix nanosecond timestamp, defaults to current time
- `category`: Optional parameter, data category, supports category names and abbreviations, such as `M` or `metric` for metric category, `L` or `logging` for log category
- `after_use`: Optional parameter, executes specified PL script on the created point after creation; if the original data type is L and the created data category is M, the script executed is still under the L category


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

Function description: Convert a timestamp to a specified date format.

Function parameters:

- `key`: Already extracted timestamp
- `precision`: Timestamp precision (s, ms, us, ns)
- `fmt`: Date format, provides built-in date formats and supports custom date formats
- `tz`: Timezone (optional parameter), converts the timestamp to the specified timezone, defaults to the host's timezone

Built-in date formats:

| Built-in Format | Date                          | Description                      |
| ---             | ---                           | ---                              |
| "ANSI-C"        | "Mon Jan _2 15:04:05 2006"    |                                  |
| "UnixDate"      | "Mon Jan _2 15:04:05 MST 2006"|                                  |
| "RubyDate"      | "Mon Jan 02 15:04:05 -0700 2006" |                                  |
| "RFC822"        | "02 Jan 06 15:04 MST"         |                                  |
| "RFC822Z"       | "02 Jan 06 15:04 -0700"       | RFC822 with numeric zone         |
| "RFC850"        | "Monday, 02-Jan-06 15:04:05 MST" |                                  |
| "RFC1123"       | "Mon, 02 Jan 2006 15:04:05 MST"|                                  |
| "RFC1123Z"      | "Mon, 02 Jan 2006 15:04:05 -0700" | RFC1123 with numeric zone       |
| "RFC3339"       | "2006-01-02T15:04:05Z07:00"   |                                  |
| "RFC3339Nano"   | "2006-01-02T15:04:05.999999999Z07:00" |                                  |
| "Kitchen"       | "3:04PM"                      |                                  |

Custom date formats:

Customize output date format using placeholders

| Character | Example | Description                                                          |
| ---       | ---     | ---                                                                  |
| a         | %a      | Abbreviated weekday, like `Wed`                                      |
| A         | %A      | Full weekday, like `Wednesday`                                       |
| b         | %b      | Abbreviated month, like `Mar`                                        |
| B         | %B      | Full month, like `March`                                             |
| C         | %c      | Century number, current year divided by 100                          |
| **d**     | %d      | Day of the month; range `[01, 31]`                                    |
| e         | %e      | Day of the month; range `[1, 31]`, padded with spaces                |
| **H**     | %H      | Hour using 24-hour clock; range `[00, 23]`                            |
| I         | %I      | Hour using 12-hour clock; range `[01, 12]`                            |
| j         | %j      | Day of the year, range `[001, 365]`                                   |
| k         | %k      | Hour using 24-hour clock; range `[0, 23]`                             |
| l         | %l      | Hour using 12-hour clock; range `[1, 12]`, padded with spaces         |
| **m**     | %m      | Month, range `[01, 12]`                                               |
| **M**     | %M      | Minute, range `[00, 59]`                                              |
| n         | %n      | Represents newline `\n`                                              |
| p         | %p      | `AM` or `PM`                                                         |
| P         | %P      | `am` or `pm`                                                         |
| s         | %s      | Seconds since 1970-01-01 00:00:00 UTC                                 |
| **S**     | %S      | Second, range `[00, 60]`                                             |
| t         | %t      | Represents tab `\t`                                                  |
| u         | %u      | Weekday, Monday is 1, range `[1, 7]`                                  |
| w         | %w      | Weekday, Sunday is 0, range `[0, 6]`                                  |
| y         | %y      | Year, range `[00, 99]`                                                |
| **Y**     | %Y      | Decimal representation of the year                                   |
| **z**     | %z      | RFC 822/ISO 8601:1988 style timezone (e.g., `-0600` or `+0100`)      |
| Z         | %Z      | Timezone abbreviation, like `CST`                                     |
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

Function description: Convert text to UTF8 encoding to handle non-UTF8 encoded raw logs. Currently supports utf-16le/utf-16be/gbk/gb18030 (these encoding names should be lowercase).

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```


### `default_time()` {#fn-defalt-time}

Function prototype: `fn default_time(key: str, timezone: str = "")`

Function description: Use the extracted field as the final data timestamp

Function parameters

- `key`: Specified key, the data type of `key` needs to be a string
- `timezone`: Specify the timezone for formatting the time text, optional parameter, defaults to the current system timezone, timezone examples `+8/-8/+8:30`

Supported formatted times for processing data

<!-- markdownlint-disable MD038 -->
| Date Format                                          | Date Format                                               | Date Format                                           | Date Format                          |
| -----                                                | ----                                                      | ----                                                  | ----                                 |
| `2014-04-26 17:24:37.3186369`                        | `May 8, 2009 5:57:51 PM`                                  | `2012-08-03 18:31:59.257000000`                       | `oct 7, 1970`                        |
| `2014-04-26 17:24:37.123`                            | `oct 7, '70`                                              | `2013-04-01 22:43`                                    | `oct. 7, 1970`                       |
| `2013-04-01 22:43:22`                                | `oct. 7, 70`                                              | `2014-12-16 06:20:00 UTC`                             | `Mon Jan  2 15:04:05 2006`          |
| `2014-12-16 06:20:00 GMT`                            | `Mon Jan  2 15:04:05 MST 2006`                            | `2014-04-26 05:24:37 PM`                              | `Mon Jan 02 15:04:05 -0700 2006`    |
| `2014-04-26 13:13:43 +0800`                          | `Monday, 02-Jan-06 15:04:05 MST`                          | `2014-04-26 13:13:43 +0800 +08`                       | `Mon, 02 Jan 2006 15:04:05 MST`     |
| `2014-04-26 13:13:44 +09:00`                         | `Tue, 11 Jul 2017 16:28:13 +0200 (CEST)`                  | `2012-08-03 18:31:59.257000000 +0000 UTC`             | `Mon, 02 Jan 2006 15:04:05 -0700`   |
| `2015-09-30 18:48:56.35272715 +0000 UTC`             | `Thu, 4 Jan 2018 17:53:36 +0000`                          | `2015-02-18 00:12:00 +0000 GMT`                       | `Mon 30 Sep 2018 09:09:09 PM UTC`   |
| `2015-02-18 00:12:00 +0000 UTC`                      | `Mon Aug 10 15:44:11 UTC+0100 2015`                       | `2015-02-08 03:02:00 +0300 MSK m=+0.000000001`        | `Thu, 4 Jan 2018 17:53:36 +0000`    |
| `2015-02-08 03:02:00.001 +0300 MSK m=+0.000000001`   | `Fri Jul 03 2015 18:04:07 GMT+0100 (GMT Daylight Time)`   | `2017-07-19 03:21:51+00:00`                           | `September 17, 2012 10:09am`        |
| `2014-04-26`                                         | `September 17, 2012 at 10:09am PST-08`                    | `2014-04`                                             | `September 17, 2012, 10:10:09`      |
| `2014`                                               | `2014:3:31`                                               | `2014-05-11 08:20:13,787`                             | `2014:03:31`                        |
| `3.31.2014`                                          | `2014:4:8 22:05`                                          | `03.31.2014`                                          | `2014:04:08 22:05`                  |
| `08.21.71`                                           | `2014:04:2 03:00:51`                                      | `2014.03`                                             | `2014:4:02 03:00:51`                |
| `2014.03.30`                                         | `2012:03:19 10:11:59`                                     | `20140601`                                            | `2012:03:19 10:11:59.3186369`       |
| `20140722105203`                                     | `2014 年 04 月 08 日 `                                    | `1332151919`                                          | `2006-01-02T15:04:05+0000`          |
| `1384216367189`                                      | `2009-08-12T22:15:09-07:00`                               | `1384216367111222`                                    | `2009-08-12T22:15:09`               |
| `1384216367111222333`                                | `2009-08-12T22:15:09Z`                                    |
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
grok(_, '%{TIMESTAMP_ISO8601:log_time}')   # Extract log time and rename the field to log_time
default_time(log_time)                     # Convert the extracted log_time field to a timestamp

# Processing result
{
  "log_time": 1610358231887000000,
}

# For logging collected data, it's best to name the time field as time; otherwise, the logging collector will fill in the current time
rename("time", log_time)

# Processing result
{
  "time": 1610358231887000000,
}
```



### `delete()` {#fn-delete}

Function prototype: `fn delete(src: map[string]any, key: str)`

Function description: Delete the key from the JSON map

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

Function description: Discard the entire log, preventing it from being uploaded

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

Function description: Delete the extracted field

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

Function description: Discard the initial text, otherwise the initial text is placed in the message field

Example:

```python
# Input data: {"age": 17, "name": "zhangsan", "height": 180}

# Remove message content from the result set
drop_origin_data()
```



### `duration_precision()` {#fn-duration-precision}

Function prototype: `fn duration_precision(key, old_precision: str, new_precision: str)`

Function description: Convert the duration precision, specifying the current and target precisions. Supports conversion between s, ms, us, ns.

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

Function description: End the parsing of the current log line. If the `drop()` function is not called, the already parsed parts will still be output.

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

Function description: Convert a number to a string representation of the specified base.

Parameters:

- `val`: Integer to convert
- `base`: Base, range 2 to 36; for bases greater than 10, use lowercase letters a to z to representvalues 10 and beyond.

Example:

```python
# script0
a = 7665324064912355185
b = format_int(a, 16)
if b != "6a60b39fd95aaf71" {
    add_key(abc, b)
} else {
    add_key(abc, "ok")
}

# result
'''
{
    "abc": "ok"
}
'''

# script1
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key(abc, b)
} else {
    add_key(abc, "ok")
}

# result
'''
{
    "abc": "ok"
}
'''


# script2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 16)            # base 16
if b != 7665324064912355185 {
    add_key(abc, b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key(abc, c)
    } else {
        add_key(abc, "ok")
    }
}


# result
'''
{
    "abc": "ok"
}
'''
```


### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```


### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```


### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Returns the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```


### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Returns a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```


### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```


### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |


### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table(table, key, value)

```

Example result:

```json
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


### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', abc)

# or 

rename(abc1, abc)
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, info.name, "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```



### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, str_abc)
replace(str_abc, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, str_abc)
replace(str_abc, "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, str_abc)
replace(str_abc, "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, str_abc)
replace(str_abc, '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```



### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```


### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol
Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If there is a tag or field with the same name as the variable in the point, it will be deleted

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |


### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

```python
# in << {"str": "13789123014"}
set_tag(str)
json(_, str)          # str == "13789123014"
replace(str, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`

# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
set_tag(str_a, "3")   # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3"
# }


# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
json(_, str_b)
set_tag(str_a, str_b) # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3",
#   "str_b": "3"
# }
```


### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```


### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```


### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, a.second)
json(_, a.third)
cast(a.second, "int")
json(_, a.forth)
strfmt(bb, "%v %s %v", a.second, a.third, a.forth)
```


### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

```

```python
# Processing script
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key(time_now_record, timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```


### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "trim(key, cutset)"

# Processing script
add_key(test_data, "ACCAA_test_DataA_ACBA")
trim(test_data, "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```


### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) uppercase(first)

# Processing result
{
   "first": "HELLO"
}
```



### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, url) url_decode(url)

# Processing result
{
  "message": "{"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```


### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, url)
m = url_parse(url)
add_key(scheme, m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, url)
m = url_parse(url)
add_key(sclient, m["params"]["sclient"])    # URL parameters are stored under the params field
add_key(h, m["host"])
add_key(path, m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```


### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script
Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use(\"b.p\")

# Processing script b.p
json(_, ip)
geoip(ip)

# Execution result of script a.p
{
  "city"     : "Brisbane",
  "country"  : "AU",
  "ip"       : "1.2.3.4",
  "province" : "Queensland",
  "isp"      : "unknown"
  "message"  : "{\"ip\": \"1.2.3.4\"}",
}
```


### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data
#    {
#        "userAgent" : "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#        "second"    : 2,
#        "third"     : "abc",
#        "forth"     : true
#    }

json(_, userAgent) user_agent(userAgent)
```


### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}
```

Result:

```json
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```


### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" && "a" in d  {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
// Fields
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "map"
}
```


### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```


### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
       <entry>
        <fieldx>valuex</fieldx>
        <fieldy>...</fieldy>
        <fieldz>...</fieldz>
        <fieldarray>
            <fielda>element_a_1</fielda>
            <fielda>element_a_2</fielda>
        </fieldarray>
    </entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', field_a_1)

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t\u003centry\u003e\n        \u003cfieldx\u003evaluex\u003c/fieldx\u003e\n        \u003cfieldy\u003e...\u003c/fieldy\u003e\n        \u003cfieldz\u003e...\u003c/fieldz\u003e\n        \u003cfieldarray\u003e\n            \u003cfielda\u003eelement_a_1\u003c/fielda\u003e\n            \u003cfielda\u003eelement_a_2\u003c/fielda\u003e\n        \u003c/fieldarray\u003e\n    \u003c/entry\u003e",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode = "5">
 <OrderNumber>ORD12345</OrderNumber>
 <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', action_code)
xml(_, '/OrderEvent/OrderNumber/text()', OrderNumber)

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "\u003cOrderEvent actionCode = \"5\"\u003e\n \u003cOrderNumber\u003eORD12345\u003c/OrderNumber\u003e\n \u003cVendorNumber\u003eV11111\u003c/VendorNumber\u003e\n\u003c/OrderEvent\u003e",
  "status": "unknown",
  "time": 1655523193632471000
}
```


### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```


### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key(abc, resp["status_code"])
add_key(abc, resp_body["a"])
```


### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

```python
# Directly extract the x.y field from the original input JSON and optionally rename it to a new field abc
json(_, x.y, abc)

# Re-extract the x.y field from an already extracted `key`, the extracted field name will be `x.y`
json(key, x.y) 
```

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, info, "zhangsan")
json(zhangsan, name)
json(zhangsan, age, "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
#    data = {
#        "name": {"first": "Tom", "last": "Anderson"},
#        "age":37,
#        "children": ["Sara","Alex","Jack"],
#        "fav.movie": "Deer Hunter",
#        "friends": [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#        ]
#    }

# Processing script:
json(_, name)
json(name, first)
```

Example 3:

```python
# Input data:
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# Processing script, handling JSON arrays:
json(_, .[0].nets[-1])
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, item2.item3, item, delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}",
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, item2.item3[0], item, true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```


### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)
 
'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])
 
'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```


```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''
```

```python
# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}",
    prefix="with_prefix_",trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
 ```json
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key(abc, len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key(abc, len(["abc"]))
# Processing result
{
  "abc": 1,
}
```


### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key(abc, abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key(abc, abc["a"]["first"][-1])

add_key(len_abc, len(abc))

add_key(len_abc, len(load_json(abc["a"]["ff"])))
```


### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) lowercase(first)

# Processing result
{
    "first": "hello"
}
```



### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key(match_1, match('''\w+\s[,\w]+''', test_1)) 

add_key(match_2, match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```


### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, table)
json(_, key)
json(_, value)

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table(table, values=[value, false], keys=[key, "col4"])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}

```


### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) json(_, second) nullif(first, "1")

# Processing result
{
    "second":2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key(first)
}
```



### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date(aa, "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```


### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration(abc) # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration(abc) # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration(abc) # Result abc = -2300000000
```



### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: int, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key(abc, b)
} else {
    add_key(abc, "ok")
}

# Result
'''
{
    "abc": "ok"
}
'''

# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key(abc, b)
} else {
    add_key(abc, "ok")
}

# Result
'''
{
    "abc": "ok"
}
'''


# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key(abc, b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key(abc, c)
    } else {
        add_key(abc, "ok")
    }
}


# Result
'''
{
    "abc": "ok"
}
'''
```


### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```


### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```


### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```


### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```


### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```


### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |


### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table(table, key, value)

```

Example result:

```json
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


### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', abc)

# or 

rename(abc1, abc)
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, info.name, "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```



### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, str_abc)
replace(str_abc, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, str_abc)
replace(str_abc, "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, str_abc)
replace(str_abc, "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, str_abc)
replace(str_abc, '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```



### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```


### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol
Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If there is a tag or field with the same name as the variable in the point, it will be deleted

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |


### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

```python
# in << {"str": "13789123014"}
set_tag(str)
json(_, str)          # str == "13789123014"
replace(str, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`

# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
set_tag(str_a, "3")   # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3"
# }


# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
json(_, str_b)
set_tag(str_a, str_b) # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3",
#   "str_b": "3"
# }
```


### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```


### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```


### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, a.second)
json(_, a.third)
cast(a.second, "int")
json(_, a.forth)
strfmt(bb, "%v %s %v", a.second, a.third, a.forth)
```


### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

```

```python
# Processing script
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key(time_now_record, timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```


### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "trim(key, cutset)"

# Processing script
add_key(test_data, "ACCAA_test_DataA_ACBA")
trim(test_data, "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```


### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) uppercase(first)

# Processing result
{
   "first": "HELLO"
}
```



### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, url) url_decode(url)

# Processing result
{
  "message": "{"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```


### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, url)
m = url_parse(url)
add_key(scheme, m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, url)
m = url_parse(url)
add_key(sclient, m["params"]["sclient"])    # URL parameters are stored under the params field
add_key(h, m["host"])
add_key(path, m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```


### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script
Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use(\"b.p\")

# Processing script b.p
json(_, ip)
geoip(ip)

# Execution result of script a.p
{
  "city"     : "Brisbane",
  "country"  : "AU",
  "ip"       : "1.2.3.4",
  "province" : "Queensland",
  "isp"      : "unknown"
  "message"  : "{\"ip\": \"1.2.3.4\"}",
}
```


### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data
#    {
#        "userAgent" : "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#        "second"    : 2,
#        "third"     : "abc",
#        "forth"     : true
#    }

json(_, userAgent) user_agent(userAgent)
```


### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}
```

Result:

```json
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```


### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" && "a" in d  {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
// Fields
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "map"
}
```


### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```


### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
       <entry>
        <fieldx>valuex</fieldx>
        <fieldy>...</fieldy>
        <fieldz>...</fieldz>
        <fieldarray>
            <fielda>element_a_1</fielda>
            <fielda>element_a_2</fielda>
        </fieldarray>
    </entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', field_a_1)

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t\u003centry\u003e\n        \u003cfieldx\u003evaluex\u003c/fieldx\u003e\n        \u003cfieldy\u003e...\u003c/fieldy\u003e\n        \u003cfieldz\u003e...\u003c/fieldz\u003e\n        \u003cfieldarray\u003e\n            \u003cfielda\u003eelement_a_1\u003c/fielda\u003e\n            \u003cfielda\u003eelement_a_2\u003c/fielda\u003e\n        \u003c/fieldarray\u003e\n    \u003c/entry\u003e",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode = "5">
 <OrderNumber>ORD12345</OrderNumber>
 <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', action_code)
xml(_, '/OrderEvent/OrderNumber/text()', OrderNumber)

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "\u003cOrderEvent actionCode = \"5\"\u003e\n \u003cOrderNumber\u003eORD12345\u003c/OrderNumber\u003e\n \u003cVendorNumber\u003eV11111\u003c/VendorNumber\u003e\n\u0```json
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the http_status field value is within the specified range, change its value to "OK"
group_between(http_status, [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the http_status field value is within the specified range, create a new status field with the value "OK"
group_between(http_status, [200, 300], "OK", status)

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```


### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in(log_level, ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in(http_status, ["error", "panic"], "not-ok", status)
```


### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```


### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key(abc, resp["status_code"])
add_key(abc, resp_body["a"])
```


### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

```python
# Directly extract the x.y field from the original input JSON and optionally rename it to a new field abc
json(_, "x.y", "abc")

# Re-extract the x.y field from an already extracted `key`, the extracted field name will be `x.y`
json(key, "x.y") 
```

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json(zhangsan, "name")
json(zhangsan, "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
#    data = {
#        "name": {"first": "Tom", "last": "Anderson"},
#        "age":37,
#        "children": ["Sara","Alex","Jack"],
#        "fav.movie": "Deer Hunter",
#        "friends": [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#        ]
#    }

# Processing script:
json(_, "name")
json(name, "first")
```

Example 3:

```python
# Input data:
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}",
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```


### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)
 
'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])
 
'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''
```

```python
# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}",
    prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```


### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key(abc, len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key(abc, len(["abc"]))
# Processing result
{
  "abc": 1,
}
```


### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key(abc, abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key(abc, abc["a"]["first"][-1])

add_key(len_abc, len(abc))

add_key(len_abc, len(load_json(abc["a"]["ff"])))
```


### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) lowercase(first)

# Processing result
{
    "first": "hello"
}
```



### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key(match_1, match('''\w+\s[,\w]+''', test_1)) 

add_key(match_2, match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```


### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, table)
json(_, key)
json(_, value)

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table(table, values=[value, false], keys=[key, "col4"])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}

```


### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) json(_, second) nullif(first, "1")

# Processing result
{
    "second":2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key(first)
}
```



### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date(aa, "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```


### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration(abc) # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration(abc) # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration(abc) # Result abc = -2300000000
```



### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: int, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key(abc, b)
} else {
    add_key(abc, "ok")
}

# Result
'''
{
    "abc": "ok"
}
'''

# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key(abc, b)
} else {
    add_key(abc, "ok")
}

# Result
'''
{
    "abc": "ok"
}
'''


# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key(abc, b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key(abc, c)
    } else {
        add_key(abc, "ok")
    }
}


# Result
'''
{
    "abc": "ok"
}
'''
```


### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```


### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```


### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```


### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```


### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```


### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |


### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table(table, key, value)

```

Example result:

```json
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


### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', abc)

# or 

rename(abc1, abc)
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```



### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, "str_abc")
replace("str_abc", "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, "str_abc")
replace("str_abc", "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, "str_abc")
replace("str_abc", '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```



### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```


### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol
Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If there is a tag or field with the same name as the variable in the point, it will be deleted

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |


### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

```python
# in << {"str": "13789123014"}
set_tag(str)
json(_, str)          # str == "13789123014"
replace(str, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`

# in << {"str_a": "2", "str_b": "3"}
json(_, "str_a")
set_tag("str_a", "3")   # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3"
# }


# in << {"str_a": "2", "str_b": "3"}
json(_, "str_a")
json(_, "str_b")
set_tag("str_a", "str_b") # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3",
#   "str_b": "3"
# }
```


### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```


### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```


### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.third")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.third", "a.forth")
```


### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

```

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
#```python
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```

### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "ACCAA_test_DataA_ACBA"
add_key(test_data, "ACCAA_test_DataA_ACBA")
trim(test_data, "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters:

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
uppercase("first")

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, "url") 
url_decode("url")

# Processing result
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95\"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters:

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("scheme", m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])    # URL parameters are stored under the params field
add_key("h", m["host"])
add_key("path", m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```

### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script

Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Execution result of script a.p
{
  "city": "Brisbane",
  "country": "AU",
  "ip": "1.2.3.4",
  "province": "Queensland",
  "isp": "unknown",
  "message": "{\"ip\": \"1.2.3.4\"}"
}
```

### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data:
# {
#     "userAgent" : "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#     "second": 2,
#     "third": "abc",
#     "forth": true
# }

json(_, "userAgent") 
user_agent("userAgent")
```

### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}

# Result:
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```

### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" and "a" in d:
    add_key("val_type", value_type(d["a"]))
```

Output:

```json
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "list"
}
```

### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
<entry>
    <fieldx>valuex</fieldx>
    <fieldy>...</fieldy>
    <fieldz>...</fieldz>
    <fieldarray>
        <fielda>element_a_1</fielda>
        <fielda>element_a_2</fielda>
    </fieldarray>
</entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', 'field_a_1')

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t<entry>\n        <fieldx>valuex</fieldx>\n        <fieldy>...</fieldy>\n        <fieldz>...</fieldz>\n        <fieldarray>\n            <fielda>element_a_1</fielda>\n            <fielda>element_a_2</fielda>\n        </fieldarray>\n    </entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode="5">
    <OrderNumber>ORD12345</OrderNumber>
    <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', 'action_code')
xml(_, '/OrderEvent/OrderNumber/text()', 'OrderNumber')

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `grok()` {#fn-grok}

Function prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function description: Extract content from the text string `input` using the `pattern`. Returns true if the pattern matches `input` successfully, otherwise returns false.

Parameters:

- `input`: Text to extract, can be raw input (`_`) or an already extracted `key`
- `pattern`: Grok expression, which supports specifying data types for keys: bool, float, int, string (corresponding to ppl's str, can also be written as str), default is string
- `trim_space`: Remove leading and trailing whitespace from the extracted characters, default value is true

```python
grok(_, pattern)    # Directly use the input text as raw data
grok(key, pattern)  # Re-grok on an already extracted `key`
```

Example:

```python
# Input data: "12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key("grok_match_ok", grok_match_ok)

# Processing result
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123,
  "grok_match_ok": true,
  "status": "unknown",
  "time": 1665994187473917724
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, change its value to "OK"
group_between("http_status", [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, create a new status field with the value "OK"
group_between("http_status", [200, 300], "OK", "status")

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in("log_level", ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in("http_status", ["error", "panic"], "not-ok", "status")
```

### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```

### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key("abc", resp["status_code"])
add_key("abc", resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

```python
# Directly extract the x.y field from the original input JSON and optionally rename it to a new field abc
json(_, "x.y", "abc")

# Re-extract the x.y field from an already extracted `key`, the extracted field name will be `x.y`
json("key", "x.y") 
```

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json("zhangsan", "name")
json("zhangsan", "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age": 37,
#     "children": ["Sara", "Alex", "Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, "name")
json("name", "first")
```

Example 3:

```python
# Input data:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2": {"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}"
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2": {"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)
 
'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])
 
'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''
```

```python
# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}",
    prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
'''

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key("abc", len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key("abc", len(["abc"]))
# Processing result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key("abc", abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key("abc", abc["a"]["first"][-1])

add_key("len_abc", len(abc))

add_key("len_abc", len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
lowercase("first")

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key("match_1", match('''\w+\s[,\w]+''', test_1)) 

add_key("match_2", match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table("table", values=[value, false], keys=[key, "col4"])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}
```

### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
json(_, "second") 
nullif("first", "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key("first")
}
```

### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date("aa", "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date("aa", "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration("abc") # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration("abc") # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration("abc") # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: int, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key("abc", c)
    } else {
        add_key("abc", "ok")
    }
}

# Result
{
    "abc": "ok"
}
```

### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```

### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```

### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |

### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table("table", "key", "value")
```

Example result:

```json
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

### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', 'abc')

# or 

rename('abc1', 'abc')
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, "str_abc")
replace("str_abc", "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, "str_abc")
replace("str_abc", "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, "str_abc")
replace("str_abc", '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```

### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol. If there is a tag or field with the same name as the variable in the point, it will be deleted if `delete_key` is set to true.

Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If true, delete any existing tag or field with the same name as the variable in the point

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

Example:

```python
# Input data: {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
set_tag("str_a", "3")   # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3"
# }

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
json(_, "str_b")
set_tag("str_a", "str_b") # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3",
#   "str_b": "3"
# }
```

### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```

### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

Example:

```python
# Input data: {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.third")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.third", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```

### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "ACCAA_test_DataA_ACBA"
add_key("test_data", "ACCAA_test_DataA_ACBA")
trim("test_data", "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
uppercase("first")

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, "url") 
url_decode("url")

# Processing result
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("scheme", m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])    # URL parameters are stored under the params field
add_key("h", m["host"])
add_key("path", m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```

### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script

Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Execution result of script a.p
{
  "city": "Brisbane",
  "country": "AU",
  "ip": "1.2.3.4",
  "province": "Queensland",
  "isp": "unknown",
  "message": "{\"ip\": \"1.2.3.4\"}"
}
```

### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data:
# {
#     "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#     "second": 2,
#     "third": "abc",
#     "forth": true
# }

json(_, "userAgent") 
user_agent("userAgent")
```

### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}

# Result:
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```

### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" and "a" in d {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "list"
}
```

### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
<entry>
    <fieldx>valuex</fieldx>
    <fieldy>...</fieldy>
    <fieldz>...</fieldz>
    <fieldarray>
        <fielda>element_a_1</fielda>
        <fielda>element_a_2</fielda>
    </fieldarray>
</entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', 'field_a_1')

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t<entry>\n        <fieldx>valuex</fieldx>\n        <fieldy>...</fieldy>\n        <fieldz>...</fieldz>\n        <fieldarray>\n            <fielda>element_a_1</fielda>\n            <fielda>element_a_2</fielda>\n        </fieldarray>\n    </entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode="5">
    <OrderNumber>ORD12345</OrderNumber>
    <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', 'action_code')
xml(_, '/OrderEvent/OrderNumber/text()', 'OrderNumber')

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, change its value to "OK"
group_between("http_status", [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, create a new status field with the value "OK"
group_between("http_status", [200, 300], "OK", "status")

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in("log_level", ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in("http_status", ["error", "panic"], "not-ok", "status")
```

### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```

### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key("abc", resp["status_code"])
add_key("abc", resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json("zhangsan", "name")
json("zhangsan", "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age": 37,
#     "children": ["Sara", "Alex", "Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, "name")
json("name", "first")
```

Example 3:

```python
# Input data:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2": {"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}"
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2": {"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)

'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''

# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}", prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key("abc", len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key("abc", len(["abc"]))
# Processing result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key("abc", abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key("abc", abc["a"]["first"][-1])

add_key("len_abc", len(abc))

add_key("len_abc", len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
lowercase("first")

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key("match_1", match('''\w+\s[,\w]+''', test_1)) 

add_key("match_2", match('''\```json
{
  "match_1": true,
  "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table("table", values=[value, false], keys=[key, "col4"])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}
```

### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
json(_, "second") 
nullif("first", "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key("first")
}
```

### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date("aa", "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date("aa", "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration("abc") # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration("abc") # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration("abc") # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: int, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key("abc", c)
    } else {
        add_key("abc", "ok")
    }
}

# Result
{
    "abc": "ok"
}
```

### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```

### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```

### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |

### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table("table", "key", "value")
```

Example result:

```json
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

### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', 'abc')

# or 

rename('abc1', 'abc')
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, "str_abc")
replace("str_abc", "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, "str_abc")
replace("str_abc", "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, "str_abc")
replace("str_abc", '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```

### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol. If there is a tag or field with the same name as the variable in the point, it will be deleted if `delete_key` is set to true.

Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If true, delete any existing tag or field with the same name as the variable in the point

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

Example:

```python
# Input data: {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
set_tag("str_a", "3")   # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3"
# }

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
json(_, "str_b")
set_tag("str_a", "str_b") # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3",
#   "str_b": "3"
# }
```

### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```

### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

Example:

```python
# Input data: {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.third")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.third", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```

### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "ACCAA_test_DataA_ACBA"
add_key("test_data", "ACCAA_test_DataA_ACBA")
trim("test_data", "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
uppercase("first")

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, "url") 
url_decode("url")

# Processing result
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("scheme", m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])    # URL parameters are stored under the params field
add_key("h", m["host"])
add_key("path", m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```

### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script

Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Execution result of script a.p
{
  "city": "Brisbane",
  "country": "AU",
  "ip": "1.2.3.4",
  "province": "Queensland",
  "isp": "unknown",
  "message": "{\"ip\": \"1.2.3.4\"}"
}
```

### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data:
# {
#     "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#     "second": 2,
#     "third": "abc",
#     "forth": true
# }

json(_, "userAgent") 
user_agent("userAgent")
```

### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}

# Result:
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```

### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" and "a" in d {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "list"
}
```

### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
<entry>
    <fieldx>valuex</fieldx>
    <fieldy>...</fieldy>
    <fieldz>...</fieldz>
    <fieldarray>
        <fielda>element_a_1</fielda>
        <fielda>element_a_2</fielda>
    </fieldarray>
</entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', 'field_a_1')

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t<entry>\n        <fieldx>valuex</fieldx>\n        <fieldy>...</fieldy>\n        <fieldz>...</fieldz>\n        <fieldarray>\n            <fielda>element_a_1</fielda>\n            <fielda>element_a_2</fielda>\n        </fieldarray>\n    </entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode="5">
    <OrderNumber>ORD12345</OrderNumber>
    <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', 'action_code')
xml(_, '/OrderEvent/OrderNumber/text()', 'OrderNumber')

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `grok()` {#fn-grok}

Function prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function description: Extract content from the text string `input` using the `pattern`. Returns true if the pattern matches `input` successfully, otherwise returns false.

Parameters:

- `input`: Text to extract, can be raw input (`_`) or an already extracted `key`
- `pattern`: Grok expression, which supports specifying data types for keys: bool, float, int, string (corresponding to ppl's str, can also be written as str), default is string
- `trim_space`: Remove leading and trailing whitespace from the extracted characters, default value is true

```python
grok(_, pattern)    # Directly use the input text as raw data
grok(key, pattern)  # Re-grok on an already extracted `key`
```

Example:

```python
# Input data: "12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key("grok_match_ok", grok_match_ok)

# Processing result
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123,
  "grok_match_ok": true,
  "status": "unknown",
  "time": 1665994187473917724
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, change its value to "OK"
group_between("http_status", [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range```json
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in("log_level", ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in("http_status", ["error", "panic"], "not-ok", "status")
```

### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```

### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key("abc", resp["status_code"])
add_key("abc", resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json("zhangsan", "name")
json("zhangsan", "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age": 37,
#     "children": ["Sara", "Alex", "Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, "name")
json("name", "first")
```

Example 3:

```python
# Input data:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}"
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)

'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''

# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}", prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key("abc", len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key("abc", len(["abc"]))
# Processing result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key("abc", abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key("abc", abc["a"]["first"][-1])

add_key("len_abc", len(abc))

add_key("len_abc", len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
lowercase("first")

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key("match_1", match('''\w+\s[,\w]+''', test_1)) 

add_key("match_2", match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table("table", values=[value, false], keys=[key, "col4"])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}
```

### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
json(_, "second") 
nullif("first", "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key("first")
}
```

### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date("aa", "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date("aa", "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration("abc") # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration("abc") # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration("abc") # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: int, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key("abc", c)
    } else {
        add_key("abc", "ok")
    }
}

# Result
{
    "abc": "ok"
}
```

### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```

### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```

### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |

### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table("table", "key", "value")
```

Example result:

```json
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

### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', 'abc')

# or 

rename('abc1', 'abc')
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, "str_abc")
replace("str_abc", "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, "str_abc")
replace("str_abc", "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, "str_abc")
replace("str_abc", '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```

### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol. If there is a tag or field with the same name as the variable in the point, it will be deleted if `delete_key` is set to true.

Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If true, delete any existing tag or field with the same name as the variable in the point

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

Example:

```python
# Input data: {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
set_tag("str_a", "3")   # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3"
# }

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
json(_, "str_b")
set_tag("str_a", "str_b") # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3",
#   "str_b": "3"
# }
```

### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```

### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

Example:

```python
# Input data: {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.third")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.third", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```

### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "ACCAA_test_DataA_ACBA"
add_key("test_data", "ACCAA_test_DataA_ACBA")
trim("test_data", "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
uppercase("first")

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs```json
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95\"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("scheme", m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])    # URL parameters are stored under the params field
add_key("h", m["host"])
add_key("path", m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```

### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script

Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Execution result of script a.p
{
  "city": "Brisbane",
  "country": "AU",
  "ip": "1.2.3.4",
  "province": "Queensland",
  "isp": "unknown",
  "message": "{\"ip\": \"1.2.3.4\"}"
}
```

### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data:
# {
#     "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#     "second": 2,
#     "third": "abc",
#     "forth": true
# }

json(_, "userAgent") 
user_agent("userAgent")
```

### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}

# Result:
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```

### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" and "a" in d {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "list"
}
```

### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
<entry>
    <fieldx>valuex</fieldx>
    <fieldy>...</fieldy>
    <fieldz>...</fieldz>
    <fieldarray>
        <fielda>element_a_1</fielda>
        <fielda>element_a_2</fielda>
    </fieldarray>
</entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', 'field_a_1')

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t<entry>\n        <fieldx>valuex</fieldx>\n        <fieldy>...</fieldy>\n        <fieldz>...</fieldz>\n        <fieldarray>\n            <fielda>element_a_1</fielda>\n            <fielda>element_a_2</fielda>\n        </fieldarray>\n    </entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode="5">
    <OrderNumber>ORD12345</OrderNumber>
    <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', 'action_code')
xml(_, '/OrderEvent/OrderNumber/text()', 'OrderNumber')

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `grok()` {#fn-grok}

Function prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function description: Extract content from the text string `input` using the `pattern`. Returns true if the pattern matches `input` successfully, otherwise returns false.

Parameters:

- `input`: Text to extract, can be raw input (`_`) or an already extracted `key`
- `pattern`: Grok expression, which supports specifying data types for keys: bool, float, int, string (corresponding to ppl's str, can also be written as str), default is string
- `trim_space`: Remove leading and trailing whitespace from the extracted characters, default value is true

```python
grok(_, pattern)    # Directly use the input text as raw data
grok(key, pattern)  # Re-grok on an already extracted `key`
```

Example:

```python
# Input data: "12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key("grok_match_ok", grok_match_ok)

# Processing result
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123,
  "grok_match_ok": true,
  "status": "unknown",
  "time": 1665994187473917724
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, change its value to "OK"
group_between("http_status", [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, create a new status field with the value "OK"
group_between("http_status", [200, 300], "OK", "status")

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in("log_level", ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in("http_status", ["error", "panic"], "not-ok", "status")
```

### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```

### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key("abc", resp["status_code"])
add_key("abc", resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json("zhangsan", "name")
json("zhangsan", "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age": 37,
#     "children": ["Sara", "Alex", "Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, "name")
json("name", "first")
```

Example 3:

```python
# Input data:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}"
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)

'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''

# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}", prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key("abc", len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key("abc", len(["abc"]))
# Processing result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key("abc", abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key("abc", abc["a"]["first"][-1])

add_key("len_abc", len(abc))

add_key("len_abc", len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
lowercase("first")

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key("match_1", match('''\w+\s[,\w]+''', test_1)) 

add_key("match_2", match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table("table", values=[value, false], keys=[key, "col4"])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}
```

### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
json(_, "second") 
nullif("first", "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key("first")
}
```

### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date("aa", "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date("aa", "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration("abc") # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration("abc") # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration("abc") # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: int, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key("abc", c)
    } else {
        add_key("abc", "ok")
    }
}

# Result
{
    "abc": "ok"
}
```

### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```

### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```

### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |

### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table("table", "key", "value")
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 123,
  "col4": true,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', 'abc')

# or 

rename('abc1', 'abc')
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, "str_abc")
replace("str_abc", "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, "str_abc")
replace("str_abc", "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, "str_abc")
replace("str_abc", '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```

### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol. If there is a tag or field with the same name as the variable in the point, it will be deleted if `delete_key` is set to true.

Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If true, delete any existing tag or field with the same name as the variable in the point

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

Example:

```python
# Input data: {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
set_tag("str_a", "3")   # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3"
# }

# Input data: {"str_a": "2", "str_b": "3"}
json(_, "str_a")
json(_, "str_b")
set_tag("str_a", "str_b") # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a#": "3",
#   "str_b": "3"
# }
```

### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```

### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

Example:

```python
# Input data: {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.third")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.third", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```

### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "ACCAA_test_DataA_ACBA"
add_key("test_data", "ACCAA_test_DataA_ACBA")
trim("test_data", "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
uppercase("first")

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, "url") 
url_decode("url")

# Processing result
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95\"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("scheme", m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])    # URL parameters are stored under the params field
add_key("h", m["host"])
add_key("path", m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```

### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script

Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Execution result of script a.p
{
  "city": "Brisbane",
  "country": "AU",
  "ip": "1.2.3.4",
  "province": "Queensland",
  "isp": "unknown",
  "message": "{\"ip\": \"1.2.3.4\"}"
}
```

### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data:
# {
#     "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#     "second": 2,
#     "third": "abc",
#     "forth": true
# }

json(_, "userAgent") 
user_agent("userAgent")
```

### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}

# Result:
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```

### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" and "a" in d {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "list"
}
```

### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
<entry>
    <fieldx>valuex</fieldx>
    <fieldy>...</fieldy>
    <fieldz>...</fieldz>
    <fieldarray>
        <fielda>element_a_1</fielda>
        <fielda>element_a_2</fielda>
    </fieldarray>
</entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', 'field_a_1')

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t<entry>\n        <fieldx>valuex</fieldx>\n        <fieldy>...</fieldy>\n        <fieldz>...</fieldz>\n        <fieldarray>\n            <fielda>element_a_1</fielda>\n            <fielda>element_a_2</fielda>\n        </fieldarray>\n    </entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode="5">
    <OrderNumber>ORD12345</OrderNumber>
    <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', 'action_code')
xml(_, '/OrderEvent/OrderNumber/text()', 'OrderNumber')

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `grok()` {#fn-grok}

Function prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function description: Extract content from the text string `input` using the `pattern`. Returns true if the pattern matches `input` successfully, otherwise returns false.

Parameters:

- `input`: Text to extract, can be raw input (`_`) or an already extracted `key`
- `pattern`: Grok expression, which supports specifying data types for keys: bool, float, int, string (corresponding to ppl's str, can also be written as str), default is string
- `trim_space`: Remove leading and trailing whitespace from the extracted characters, default value is true

```python
grok(_, pattern)    # Directly use the input text as raw data
grok(key, pattern)  # Re-grok on an already extracted `key`
```

Example:

```python
# Input data: "12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key("grok_match_ok", grok_match_ok)

# Processing result
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123,
  "grok_match_ok": true,
  "status": "unknown",
  "time": 1665994187473917724
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, change its value to "OK"
group_between("http_status", [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, create a new status field with the value "OK"
group_between("http_status", [200, 300], "OK", "status")

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in("log_level", ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in("http_status", ["error", "panic"], "not-ok", "status")
```

### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```

### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key("abc", resp["status_code"])
add_key("abc", resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json("zhangsan", "name")
json("zhangsan", "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age": 37,
#     "children": ["Sara", "Alex", "Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, "name")
json("name", "first")
```

Example 3:

```python
# Input data:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}"
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)

'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''

# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}", prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key("abc", len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key("abc", len(["abc"]))
# Processing result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key("abc", abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key("abc", abc["a"]["first"][-1])

add_key("len_abc", len(abc))

add_key("len_abc", len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
lowercase("first")

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key("match_1", match('''\w+\s[,\w]+''', test_1)) 

add_key("match_2", match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table("table", keys=[key, "col4"], values=[value, false])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}
```

### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
json(_, "second") 
nullif("first", "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key("first")
}
```

### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date("aa", "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date("aa", "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration("abc") # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration("abc") # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration("abc") # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: str, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key("abc", c)
    } else {
        add_key("abc", "ok")
    }
}

# Result
{
    "abc": "ok"
}
```

### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```

### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```

### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |

### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table("table", "key", "value")
```

Example result:

```json
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

### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', 'abc')

# or 

rename('abc1', 'abc')
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, "str_abc")
replace("str_abc", "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, "str_abc")
replace("str_abc", "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, "str_abc")
replace("str_abc", '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```

### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol. If there is a tag or field with the same name as the variable in the point, it will be deleted if `delete_key` is set to true.

Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If true, delete any existing tag or field with the same name as the variable in the point

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

Example:

```python
# Input data: {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`
```

### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```

### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

Example:

```python
# Input data: {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.third")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.third", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```

### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "ACCAA_test_DataA_ACBA"
add_key("test_data", "ACCAA_test_DataA_ACBA")
trim("test_data", "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
uppercase("first")

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, "url") 
url_decode("url")

# Processing result
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95\"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("scheme", m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])    # URL parameters are stored under the params field
add_key("h", m["host"])
add_key("path", m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```

### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script

Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Execution result of script a.p
{
  "city": "Brisbane",
  "country": "AU",
  "ip": "1.2.3.4",
  "province": "Queensland",
  "isp": "unknown",
  "message": "{\"ip\": \"1.2.3.4\"}"
}
```

### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field

Function parameters

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data:
# {
#     "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#     "second": 2,
#     "third": "abc",
#     "forth": true
# }

json(_, "userAgent") 
user_agent("userAgent")
```

### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}

# Result:
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```

### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string

Parameter:

- `val`: Value whose type needs to be determined

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" and "a" in d {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "list"
}
```

### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
<entry>
    <fieldx>valuex</fieldx>
    <fieldy>...</fieldy>
    <fieldz>...</fieldz>
    <fieldarray>
        <fielda>element_a_1</fielda>
        <fielda>element_a_2</fielda>
    </fieldarray>
</entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', 'field_a_1')

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t<entry>\n        <fieldx>valuex</fieldx>\n        <fieldy>...</fieldy>\n        <fieldz>...</fieldz>\n        <fieldarray>\n            <fielda>element_a_1</fielda>\n            <fielda>element_a_2</fielda>\n        </fieldarray>\n    </entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode="5">
    <OrderNumber>ORD12345</OrderNumber>
    <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', 'action_code')
xml(_, '/OrderEvent/OrderNumber/text()', 'OrderNumber')

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `grok()` {#fn-grok}

Function prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function description: Extract content from the text string `input` using the `pattern`. Returns true if the pattern matches `input` successfully, otherwise returns false.

Parameters:

- `input`: Text to extract, can be raw input (`_`) or an already extracted `key`
- `pattern`: Grok expression, which supports specifying data types for keys: bool, float, int, string (corresponding to ppl's str, can also be written as str), default is string
- `trim_space`: Remove leading and trailing whitespace from the extracted characters, default value is true

Example:

```python
# Input data: "12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key("grok_match_ok", grok_match_ok)

# Processing result
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123,
  "grok_match_ok": true,
  "status": "unknown",
  "time": 1665994187473917724
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, change its value to "OK"
group_between("http_status", [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, create a new status field with the value "OK"
group_between("http_status", [200, 300], "OK", "status")

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in("log_level", ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in("http_status", ["error", "panic"], "not-ok", "status")
```

### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text

Function parameters:

- `text`: Input text
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```

### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type `map[string]string`
- `body`: Request body

Return type: map

Keys include status code (`status_code`) and response body (`body`)

- `status_code`: Status code
- `body`: Response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key("abc", resp["status_code"])
add_key("abc", resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`
- `json_path`: JSON path information
- `newkey`: New key for the extracted data
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json("zhangsan", "name")
json("zhangsan", "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age": 37,
#     "children": ["Sara", "Alex", "Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, "name")
json("name", "first")
```

Example 3:

```python
# Input data:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}"
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string

Parameters:

- `key`: Key name
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`
- `prefix`: Prefix string added to all keys

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)

'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''

# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}", prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string

Example:

```python
# Example 1
add_key("abc", len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key("abc", len(["abc"]))
# Processing result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key("abc", abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key("abc", abc["a"]["first"][-1])

add_key("len_abc", len(abc))

add_key("len_abc", len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase

Function parameters

- `key`: Name of the extracted field to convert

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
lowercase("first")

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false

Parameters:

- `pattern`: Regular expression
- `s`: String to match

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key("match_1", match('''\w+\s[,\w]+''', test_1)) 

add_key("match_2", match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `keys`: List of column names
- `values`: Corresponding values for each column

Example:

```python
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table("table", keys=[key, "col4"], values=[value, false])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}
```

### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field

Function parameters

- `key`: Specified field
- `value`: Target value

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
json(_, "second") 
nullif("first", "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key("first")
}
```

### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp

Function parameters

- `key`: New inserted field
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year
- `MM`: Month string, supports numbers, English words, and abbreviations
- `dd`: Day string
- `hh`: Hour string
- `mm`: Minute string
- `ss`: Second string
- `ms`: Millisecond string
- `us`: Microsecond string
- `ns`: Nanosecond string
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai"

Example:

```python
parse_date("aa", "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date("aa", "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters

- `key`: Field to parse

Example:

```python
# Assume abc = "3.5s"
parse_duration("abc") # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration("abc") # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration("abc") # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: str, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key("abc", c)
    } else {
        add_key("abc", "ok")
    }
}

# Result
{
    "abc": "ok"
}
```

### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point

Function parameters:

- `name`: Key to delete

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point

Function parameters:

- `name`: Key name

Example:

```python
host = pt_kvs_get("host")
```

### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point

Function parameters:

- `tags`: Whether to include all tag names
- `fields`: Whether to include all field names

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point

Function parameters:

- `name`: Name of the field or tag to add or modify
- `value`: Value of the field or tag
- `as_tag`: Whether to set as a tag

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```

### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |

### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query
- `key`: Column name
- `value`: Corresponding column value

Example:

```python
# Extract table name, column name, and column value from input
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table("table", "key", "value")
```

Example result:

```json
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

### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field

Parameters:

- `new_key`: New field name
- `old_key`: Existing extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', 'abc')

# or 

rename('abc1', 'abc')
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression

Function parameters

- `key`: Target field
- `regex`: Regular expression
- `replace_str`: Replacement string

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, "str_abc")
replace("str_abc", "([a-z]*) \\w*", "$1 ***")

# ID card number {"str_abc": "362201200005302565"}
json(_, "str_abc")
replace("str_abc", "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, "str_abc")
replace("str_abc", '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Sample/discard data based on probability p.

Function parameters:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability; here it will discard 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```

### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: Change the name of the line protocol. If there is a tag or field with the same name as the variable in the point, it will be deleted if `delete_key` is set to true.

Function parameters:

- `name`: Value as measurement name, can be a string constant or variable
- `delete_key`: If true, delete any existing tag or field with the same name as the variable in the point

Mapping relationship between line protocol name and various types of data storage fields or other uses:

| Category          | Field Name | Other Uses |
| -                 | -          | -          |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Mearsurement name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: Mark the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the fields to avoid conflicts with existing tags.

Function parameters

- `key`: Field to mark as a tag
- `value`: Can be a string literal or variable

Example:

```python
# Input data: {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * Character `#` is only for displaying fields marked as tags when using `datakit --pl <path> --txt <str>`
```

### `setopt()` {#fn-setopt}

Function prototype: `fn setopt(status_mapping: bool = true)`

Function description: Modify Pipeline settings, parameters must be in `key=value` form

Function parameters:

- `status_mapping`: Set the mapping feature for the `status` field of log-type data, default enabled

Example:

```py
# Disable the mapping feature for the status field
setopt(status_mapping=false)

add_key("status", "w")

# Processing result
{
  "status": "w",
}
```

```py
# The mapping feature for the status field is enabled by default
setopt(status_mapping=true)

add_key("status", "w")

# Processing result
{
  "status": "warning",
}
```

### `slice_string()` {#fn_slice_string}

Function prototype: `fn slice_string(name: str, start: int, end: int) -> str`

Function description: Return the substring from index `start` to `end` of the string.

Function parameters:

- `name`: String to slice
- `start`: Starting index of the substring (inclusive)
- `end`: Ending index of the substring (exclusive)

Example:

```python
substring = slice_string("15384073392", 0, 3)
# substring value is "153"
```

### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: Mask SQL statements

Example:

```python
# Input data: {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the contents of the specified fields `arg1, arg2, ...` according to `fmt` and write the formatted content into the `key` field

Function parameters

- `key`: Name of the field to write the formatted data
- `fmt`: Formatting string template
- `args`: Variable arguments, can be multiple extracted fields to be formatted

Example:

```python
# Input data: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.third")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.third", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: Return the current Unix timestamp, default precision is ns

Function parameters:

- `precision`: Timestamp precision, values can be "ns", "us", "ms", "s", default is "ns".

Example:

```python
# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# Processing result
{
  "time_now_record": "2023-03-07 10:41:12"
}

# Processing script
add_key("time_now_record", timestamp())

datetime("time_now_record", "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# Processing result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```

### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: Remove specified characters from the beginning and end of `key`, if `cutset` is an empty string, it defaults to removing all whitespace characters

Function parameters:

- `key`: An already extracted field, string type
- `cutset`: Characters to remove from the beginning and end of `key`

Example:

```python
# Input data: "ACCAA_test_DataA_ACBA"
add_key("test_data", "ACCAA_test_DataA_ACBA")
trim("test_data", "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content of the extracted `key` to uppercase

Function parameters

- `key`: Name of the already extracted field to convert to uppercase

Example:

```python
# Input data: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
uppercase("first")

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: Decode the URL in the extracted `key` to plaintext

Parameter:

- `key`: Already extracted `key`

Example:

```python
# Input data: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, "url") 
url_decode("url")

# Processing result
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95\"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: Parse the URL in the field named `key`.

Function parameters

- `key`: Name of the field containing the URL to parse.

Example:

```python
# Input data: {"url": "https://www.baidu.com"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("scheme", m["scheme"])

# Processing result
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

In addition to extracting the scheme from the URL, you can also extract host, port, path, and URL parameters as shown in the following example:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])    # URL parameters are stored under the params field
add_key("h", m["host"])
add_key("path", m["path"])

# Processing result
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```

### `use()` {#fn-use### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameters:

- `name`: Script name, such as abp.p

Function description: Call other scripts, allowing access to all current data in the called script.

Example:

```python
# Input data: {"ip": "1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Execution result of script a.p
{
  "city": "Brisbane",
  "country": "AU",
  "ip": "1.2.3.4",
  "province": "Queensland",
  "isp": "unknown",
  "message": "{\"ip\": \"1.2.3.4\"}"
}
```

### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Extract client information from the specified field.

Function parameters:

- `key`: Target field to extract

`user_agent()` generates multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Input data:
# {
#     "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#     "second": 2,
#     "third": "abc",
#     "forth": true
# }

json(_, "userAgent") 
user_agent("userAgent")
```

### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Parameter:

- `val`: Must be a string type data.

Example:

```python
a = "null"
if valid_json(a) { # true
    if load_json(a) == nil {
        add_key("a", "nil")
    }
}

b = "[1, 2, 3]"
if valid_json(b) { # true
    add_key("b", load_json(b))
}

c = "{\"a\": 1}"
if valid_json(c) { # true
    add_key("c", load_json(c))
}

d = "???{\"d\": 1}"
if valid_json(d) { # true
    add_key("d", load_json(c))
} else {
    add_key("d", "invalid json")
}

# Result:
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```

### `value_type()` {#fn-value-type}

Function prototype: `fn value_type(val) str`

Function description: Get the type of the value of a variable, return values are ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, it returns an empty string.

Parameter:

- `val`: Value whose type needs to be determined.

Example:

Input:

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

Script:

```python
d = load_json(_)

if value_type(d) == "map" and "a" in d {
    add_key("val_type", value_type(d["a"]))
}
```

Output:

```json
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "list"
}
```

### `window_hit()` {fn-window-hit}

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event for context data that has been discarded, recovering data recorded by the `point_window` function.

Function parameters: None

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: XML to extract
- `xpath_expr`: XPath expression
- `key_name`: New key for extracted data

Example 1:

```python
# Input data
<entry>
    <fieldx>valuex</fieldx>
    <fieldy>...</fieldy>
    <fieldz>...</fieldz>
    <fieldarray>
        <fielda>element_a_1</fielda>
        <fielda>element_a_2</fielda>
    </fieldarray>
</entry>

# Processing script
xml(_, '/entry/fieldarray//fielda[1]/text()', 'field_a_1')

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "\t\t<entry>\n        <fieldx>valuex</fieldx>\n        <fieldy>...</fieldy>\n        <fieldz>...</fieldz>\n        <fieldarray>\n            <fielda>element_a_1</fielda>\n            <fielda>element_a_2</fielda>\n        </fieldarray>\n    </entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Input data
<OrderEvent actionCode="5">
    <OrderNumber>ORD12345</OrderNumber>
    <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', 'action_code')
xml(_, '/OrderEvent/OrderNumber/text()', 'OrderNumber')

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "<OrderEvent actionCode=\"5\">\n<OrderNumber>ORD12345</OrderNumber>\n<VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```

### `grok()` {#fn-grok}

Function prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function description: Extract content from the text string `input` using the `pattern`. Returns true if the pattern matches `input` successfully, otherwise returns false.

Parameters:

- `input`: Text to extract, can be raw input (`_`) or an already extracted `key`
- `pattern`: Grok expression, which supports specifying data types for keys: bool, float, int, string (corresponding to ppl's str, can also be written as str), default is string
- `trim_space`: Remove leading and trailing whitespace from the extracted characters, default value is true

Example:

```python
# Input data: "12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key("grok_match_ok", grok_match_ok)

# Processing result
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123,
  "grok_match_ok": true,
  "status": "unknown",
  "time": 1665994187473917724
}
```

### `group_between()` {#fn-group-between}

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the value of `key` is within the specified range `between` (note: only a single interval like `[0,100]`), create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example 1:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, change its value to "OK"
group_between("http_status", [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, "http_status")

# If the http_status field value is within the specified range, create a new status field with the value "OK"
group_between("http_status", [200, 300], "OK", "status")

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new_key = "")`

Function description: If the value of `key` is in the list `range`, create a new field and assign it a new value. If no new field is provided, overwrite the original field value.

Example:

```python
# If the log_level field value is in the list, change its value to "OK"
group_in("log_level", ["info", "debug"], "OK")

# If the http_status field value is in the specified list, create a new status field with the value "not-ok"
group_in("http_status", ["error", "panic"], "not-ok", "status")
```

### `hash()` {#fn_hash}

Function prototype: `fn hash(text: str, method: str) -> str`

Function description: Calculate the hash of the text.

Function parameters:

- `text`: Input text.
- `method`: Hash algorithm, allowed values include `md5`, `sha1`, `sha256`, `sha512`.

Example:

```python
pt_kvs_set("md5sum", hash("abc", "sha1"))
```

### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map.

Parameters:

- `method`: GET|POST
- `url`: Request path.
- `headers`: Additional headers, type `map[string]string`.
- `body`: Request body.

Return type: map

Keys include status code (`status_code`) and response body (`body`).

- `status_code`: Status code.
- `body`: Response body.

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key("abc", resp["status_code"])
add_key("abc", resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function description: Extract the specified field from JSON and optionally rename it to a new field.

Parameters:

- `input`: JSON to extract, can be raw input (`_`) or an already extracted `key`.
- `json_path`: JSON path information.
- `newkey`: New key for the extracted data.
- `trim_space`: Remove leading and trailing whitespace from the extracted string, default value is `true`.
- `delete_after_extract`: Delete the current object after extraction and rewrite the extracted object back after re-serialization; only applies to deleting keys and values in maps, cannot delete elements in lists; default value is `false`, no operation.

Example 1:

```python
# Input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
json(_, "info", "zhangsan")
json("zhangsan", "name")
json("zhangsan", "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# Input data:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age": 37,
#     "children": ["Sara", "Alex", "Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, "name")
json("name", "first")
```

Example 3:

```python
# Input data:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script, handling JSON arrays:
json(_, ".[0].nets[-1]")
```

Example 4:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, "item2.item3", "item", delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}"
}
```

Example 5:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# Attempting to delete list elements will fail the script check
json(_, "item2.item3[0]", "item", true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: Extract all key-value pairs from a string.

Parameters:

- `key`: Key name.
- `include_keys`: List of key names to include, only extract keys in this list; **default is `[]`, extracts no keys**.
- `field_split_pattern`: String split pattern used to extract all key-value pairs, default is `" "`.
- `value_split_pattern`: Pattern used to split key and value from the key-value pair string, non-recursive; default is `"="`.
- `trim_key`: Remove all specified characters from the leading and trailing of the extracted key; default is `""`.
- `trim_value`: Remove all specified characters from the leading and trailing of the extracted value; default is `""`.
- `prefix`: Prefix string added to all keys.

Examples:

```python
# Input: "a=1, b=2 c=3"
kv_split(_)

'''Output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1,",
  "b": "2",
  "c": "3",
  "message": "a=1 b=2 c=3",
  "status": "unknown",
  "time": 1678087119072769560
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''Output:
{
  "a": "1",
  "b": "2",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087173651846101
}
'''
```

```python
# Input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''Output:
{
  "a": "1",
  "c": "3",
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1678087514906492912
}
'''

# Input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}", prefix="with_prefix_", trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''Output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
```

### `len()` {#fn-len}

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the byte count of a string, or the number of elements in a map or list.

Parameters:

- `val`: Can be a map, list, or string.

Example:

```python
# Example 1
add_key("abc", len("abc"))
# Output
{
 "abc": 3,
}

# Example 2
add_key("abc", len(["abc"]))
# Processing result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert a JSON string to one of the types: map, list, nil, bool, float. Values can be accessed and modified using index expressions. If deserialization fails, it returns nil without terminating the script.

Parameters:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key("abc", abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data back to point
add_key("abc", abc["a"]["first"][-1])

add_key("len_abc", len(abc))

add_key("len_abc", len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted `key` to lowercase.

Function parameters:

- `key`: Name of the extracted field to convert.

Example:

```python
# Input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
lowercase("first")

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Match a string with a specified regular expression, return true if matched, otherwise return false.

Parameters:

- `pattern`: Regular expression.
- `s`: String to match.

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key("match_1", match('''\w+\s[,\w]+''', test_1)) 

add_key("match_2", match('''\w+\s[,\w]+''', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query an external reference table using multiple keys and append all columns of the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query.
- `keys`: List of column names.
- `values`: Corresponding values for each column.

Example:

```python
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the current column's data, which is added as a field to the data by default
mquery_refer_table("table", keys=[key, "col4"], values=[value, false])
```

Example result:

```json
{
  "col": "ab",
  "col2": 1234,
  "col3": 1235,
  "col4": false,
  "key": "col2",
  "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
  "status": "unknown",
  "table": "table_abc",
  "time": "2022-08-16T16:23:31.940600281+08:00",
  "value": 1234
}
```

### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the specified field `key` equals `value`, delete this field.

Function parameters:

- `key`: Specified field.
- `value`: Target value.

Example:

```python
# Input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, "first") 
json(_, "second") 
nullif("first", "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be achieved using `if/else` logic:

```python
if first == "1" {
    drop_key("first")
}
```

### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the parts of the input date field into a timestamp.

Function parameters:

- `key`: New inserted field.
- `yy` : Year string, supports four-digit or two-digit numbers; if empty, use the current year.
- `MM`: Month string, supports numbers, English words, and abbreviations.
- `dd`: Day string.
- `hh`: Hour string.
- `mm`: Minute string.
- `ss`: Second string.
- `ms`: Millisecond string.
- `us`: Microsecond string.
- `ns`: Nanosecond string.
- `zone`: Timezone string, e.g., “+8” or "Asia/Shanghai".

Example:

```python
parse_date("aa", "2021", "May", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1620785434000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", zone="Asia/Shanghai") # Result aa=1639275034000000000

parse_date("aa", "2021", "12", "12", "10", "10", "34", "100", zone="Asia/Shanghai") # Result aa=1639275034000000100

parse_date("aa", "20", "February", "12", "10", "10", "34", zone="+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parse `key` into an integer representing nanoseconds.

Currently, golang duration units are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function parameters:

- `key`: Field to parse.

Example:

```python
# Assume abc = "3.5s"
parse_duration("abc") # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration("abc") # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration("abc") # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: str, base: int) int`

Function description: Convert the string representation of a number to a numeric value.

Parameters:

- `val`: String to convert.
- `base`: Base, range 0, or 2 to 36; value 0 infers the base from the string prefix.

Example:

```python
# Script 0
a = "7665324064912355185"
b = format_int(parse_int(a, 10), 16)
if b != "6a60b39fd95aaf71" {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # Base 16
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    add_key("abc", "ok")
}

# Result
{
    "abc": "ok"
}
```

```python
# Script 2
a = "0x6a60b39fd95aaf71" 
b = parse_int(a, 0)            # The true base is implied by the string's prefix
if b != 7665324064912355185 {
    add_key("abc", b)
} else {
    c = format_int(b, 16)
    if "0x"+c != a {
        add_key("abc", c)
    } else {
        add_key("abc", "ok")
    }
}

# Result
{
    "abc": "ok"
}
```

### `point_window()` {fn-point-window}

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record discarded data, used in conjunction with the `window_hit` function to upload context `Point` data that has been discarded.

Function parameters:

- `before`: Maximum number of Points that can be buffered before the execution of the `window_hit` function; undropped data is included in the count.
- `after`: Number of Points to retain after the execution of the `window_hit` function; undropped data is included in the count.
- `stream_tags`: Tags on the data used to distinguish log (metrics, traces, etc.) streams, default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# It is recommended to place this at the beginning of the script
#
point_window(8, 8)

# If it's a panic log, retain the previous 8 entries and the next 8 entries (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if `point_window()` was executed during this run
    # Triggers the recovery behavior for data within the window
    #
    window_hit()
}

# By default, discard all logs from services named test_app;
# If it contains a panic log, retain adjacent 15 entries plus the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_kvs_del()` {#fn_pt_kvs_del}

Function prototype: `fn pt_kvs_del(name: str)`

Function description: Delete the specified key from Point.

Function parameters:

- `name`: Key to delete.

Example:

```python
key_blacklist = ["k1", "k2", "k3"]
for k in pt_kvs_keys() {
    if k in key_blacklist {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_get()` {#fn_pt_kvs_get}

Function prototype: `fn pt_kvs_get(name: str) -> any`

Function description: Return the value of the specified key in Point.

Function parameters:

- `name`: Key name.

Example:

```python
host = pt_kvs_get("host")
```

### `pt_kvs_keys()` {#fn_pt_kvs_keys}

Function prototype: `fn pt_kvs_keys(tags: bool = true, fields: bool = true) -> list`

Function description: Return a list of keys in Point.

Function parameters:

- `tags`: Whether to include all tag names.
- `fields`: Whether to include all field names.

Example:

```python
for k in pt_kvs_keys() {
    if match("^prefix_", k) {
        pt_kvs_del(k)
    }
}
```

### `pt_kvs_set()` {#fn_pt_kvs_set}

Function prototype: `fn pt_kvs_set(name: str, value: any, as_tag: bool = false) -> bool`

Function description: Add a key or modify the value of a key in Point.

Function parameters:

- `name`: Name of the field or tag to add or modify.
- `value`: Value of the field or tag.
- `as_tag`: Whether to set as a tag.

Example:

```python
kvs = {
    "a": 1,
    "b": 2
}

for k in kvs {
    pt_kvs_set(k, kvs[k])
}
```

### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of the point; if the parameter is not empty, set a new name.

Function parameters:

- `name`: Value as point name; default is an empty string.

Mapping relationship between Point Name and various types of data storage fields:

| Category          | Field Name |
| ------------- | ------ |
| custom_object | class  |
| keyevent      | -      |
| logging       | source |
| metric        | -      |
| network       | source |
| object        | class  |
| profiling     | source |
| rum           | source |
| security      | rule   |
| tracing       | source |

### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query an external reference table using the specified key and append the first row of the query results to the fields. This function is not applicable to central Pipelines.

Parameters:

- `table_name`: Table name to query.
- `key`: Column name.
- `value`: Corresponding column value.

Example:

```python
# Extract table name, column name, and column value from input
json(_, "table")
json(_, "key")
json(_, "value")

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table("table", "key", "value")
```

Example result:

```json
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

### `rename()` {#fn-rename}

Function prototype: `fn rename(new_key, old_key)`

Function description: Rename an extracted field.

Parameters:

- `new_key`: New field name.
- `old_key`: Existing extracted field name.

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', 'abc')

# or 

rename('abc1', 'abc')
```

```python
# Input data: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, "info.name", "姓名")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "姓名": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace content in the specified field according to the regular expression.

Function parameters:

- `key`: Target field.
- `regex`: Regular expression.
- `replace_str`: Replacement string.

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, "str_abc")
replace("str_abc", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$