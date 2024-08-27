# Built-in Functions {#functions}
---

Function Parameter Description:

- In function parameters, the anonymous parameter (`_`) refers to the original input text data.
- JSON paths are directly represented in the form of `x.y.z` without any other modifications. For example, for `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`, the JSON path `a.thrid` means the data to be operated is `abc`.
- The relative order of all function parameters is fixed, and the engine will check it specifically.
- All `key` parameters mentioned below refer to the `key` generated after the first extraction (through `grok()` or `json()`).
- The path of the JSON to be processed supports the notation of identifiers and cannot use strings. If a new key is generated, a string must be used.

## Function List {#function-list}

### `add_key()` {#fn-add-key}

Function Prototype: `fn add_key(key, value)`

Function Description: Add a field to the point.

Function Parameters:

- `key`: The name of the new key to be added.
- `value`: The value for the key.

Example:

```python
# Data to be processed: {"age": 17, "name": "zhangsan", "height": 180}

# Processing script
add_key(city, "shanghai")

# Result
{
    "age": 17,
    "height": 180,
    "name": "zhangsan",
    "city": "shanghai"
}
```

### `add_pattern()` {#fn-add-pattern}

Function Prototype: `fn add_pattern(name: str, pattern: str)`

Function Description: Create a custom grok pattern. Grok patterns have scope limitations; for example, they will create a new scope within if-else statements, and the pattern is only valid within this scope. This function cannot override grok patterns that already exist in the same scope or the previous scope.

Parameters:

- `name`: The name of the pattern.
- `pattern`: The content of the custom pattern.

Example:

```python
# Data to be processed: "11,abc,end1", "22,abc,end1", "33,abc,end3"

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
        # Using pattern cc here will cause a compilation error: no pattern found for %{cc}
        grok(_, "%{aa:aa},%{bb:bb},%{INT:cc}")
    } elif aa == "33" {
        add_pattern("bb", "[\\d]{5}") # Overriding bb here will fail
        add_pattern("cc", "end3")
        grok(_, "%{aa:aa},%{bb:bb},%{cc:cc}")
    }
}

# Result
{
    "aa": "11",
    "bb": "abc",
    "cc": "end1",
    "message": "11,abc,end1"
}
{
    "aa": "22",
    "message": "22,abc,end1"
}
{
    "aa": "33",
    "bb": "abc",
    "cc": "end3",
    "message": "33,abc,end3"
}
```

### `adjust_timezone()` {#fn-adjust-timezone}

Function Prototype: `fn adjust_timezone(key: int, minute: int)`

Function Parameters:

- `key`: Nanosecond timestamp, such as the timestamp obtained after processing by the `default_time(time)` function.
- `minute`: The return value allows the difference between the timestamp passed in and the current time's timestamp to be within (-60+minute, minute] minutes; the default value is 2 minutes.

Function Description: It ensures that the difference between the passed timestamp and the current time's timestamp is within (-60+minute, minute] minutes; it is not suitable for data with a time difference beyond this range, otherwise, it will result in incorrect data. The calculation process is as follows:

1. Add several hours to the value of key to make it within the current hour.
2. At this point, calculate the minute difference between the two, with both minute values ranging from [0, 60), and the difference value ranging from (-60,0] and [0, 60).
3. If the difference is less than or equal to -60 + minute, add 1 hour; if greater than minute, subtract 1 hour.
4. The default value of minute is 2, allowing the difference range to be (-58, 2], if it is 11:10, and the log time is 3:12:00.001, the final result is 10:12:00.001; if it is 11:59:1.000, and the log time is 3:01:1.000, the final result is 12:01:1.000.

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
default_time(time) # Convert the extracted time field into a timestamp
                   # (Parse using the local timezone UTC+0800/UTC+0900... for data without a timezone)
adjust_timezone(time)
                   # Automatically (re)select the timezone and calibrate the time difference
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

Local machine time: `2022-07-11T20:55:10.521+08:00`

Using only `default_time` to parse according to the default local timezone (UTC+8) results in:

- Input 1 result: `2022-07-11T12:49:20.937+08:00`

After using `adjust_timezone`, the result will be:

- Input 1 result: `2022-07-11T20:49:20.937+08:00`

### `agg_create()` {#fn-agg-create}

Function Prototype: `fn agg_create(bucket: str, on_interval: str = "60s", on_count: int = 0, keep_value: bool = false, const_tags: map[string]string = nil, category: str = "M")`

Function Description: Create a set of metrics for aggregation, setting the aggregation period with `on_interval` or `on_count` based on time or count, and uploading aggregated data after the aggregation is completed, with the option to keep the data from the last aggregation; this function is not suitable for central Pipelines.

Function Parameters:

- `bucket`: String type, as the name of the set of metrics aggregated, if the bucket has already been created, the function does not perform any operation.
- `on_interval`: Default value `60s`, the aggregation period is set based on time, unit `s`, the parameter takes effect when the value is greater than `0`; it cannot be less than or equal to `0` at the same time as `on_count`.
- `on_count`: Default value `0`, the aggregation period is set based on the number of points processed, the parameter takes effect when the value is greater than `0`.
- `keep_value`: Default value `false`.
- `const_tags`: Custom tags, default is empty.
- `category`: The data category of the aggregated data, optional parameter, default value "M", indicating the category of metric data.

Example: 


```python
agg_create("cpu_agg_info", on_interval = "30s")
```


### `agg_metric()` {#fn-agg-metric}

Function Prototype: `fn agg_metric(bucket: str, new_field: str, agg_fn: str, agg_by: []string, agg_field: str, category: str = "M")`

Function Description: Automatically takes values from the field names in the input data as tags for the aggregated data, and stores these aggregated data in the corresponding bucket; this function is not suitable for central Pipelines.

Function Parameters:

- `bucket`: String type, the bucket of the corresponding metric set created by the function `agg_create`. If the bucket is not created, the function performs no operation.
- `new_field`: The name of the metric in the aggregated data, and its value data type is `float`.
- `agg_fn`: Aggregation function, which can be one of `"avg"`, `"sum"`, `"min"`, `"max"`, `"set"`.
- `agg_by`: The names of the fields in the input data that will serve as tags for the aggregated data. The values of these fields must be of string type.
- `agg_field`: The name of the field in the input data from which the field values are automatically retrieved for aggregation.
- `category`: The data category of the aggregated data, an optional parameter with a default value of "M", indicating metric category data.

Example:

Taking log category data as an example:

Consecutive inputs:

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

Function Prototype: `fn append(arr, elem) arr`

Function Description: Add the element `elem` to the end of the array `arr`.

Parameters:

- `arr`: The array to which the element is to be added.
- `elem`: The element to be added.

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

Function Prototype: `fn b64dec(key: str)`

Function Description: Perform base64 decoding on the string data obtained from the specified field.

Function Parameter:

- `key`: The field to be extracted.

Example:

```python
# Data to be processed {"str": "aGVsbG8sIHdvcmxk"}
json(_, `str`)
b64dec(`str`)

# Result
# {
#   "str": "hello, world"
# }
```

### `b64enc()` {#fn-b64enc}

Function Prototype: `fn b64enc(key: str)`

Function Description: Perform base64 encoding on the string data obtained from the specified field.

Function Parameter:

- `key`: The field to be extracted.

Example:

```python
# Data to be processed {"str": "hello, world"}
json(_, `str`)
b64enc(`str`)

# Result
# {
#   "str": "aGVsbG8sIHdvcmxk"
# }
```

### `cache_get()` {#fn-cache-get}

Function Prototype: `fn cache_get(key: str) nil|str`

Function Description: Retrieve the value corresponding to the key from the cache.

Parameter:

- `key`: The key.

Example:

```python
a = cache_get("a")
add_key(abc, a)
```

### `cache_set()` {#fn-cache-set}

Function Prototype: `fn cache_set(key: str, value: str, expiration: int) nil`

Function Description: Save a key-value pair into the cache.

Parameters:

- `key`: The key (required).
- `value`: The value (required).
- `expiration`: The expiration time (default=100s).

Example:

```python
a = cache_set("a", "123")
a = cache_get("a")
add_key(abc, a)
```

### `cast()` {#fn-cast}

Function Prototype: `fn cast(key, dst_type: str)`

Function Description: Convert the value of `key` to a specified type.

Function Parameters:

- `key`: A field that has been extracted.
- `dst_type`: The target type for conversion, supports `"str", "float", "int", "bool"`. The target type needs to be enclosed in double quotes in English state.

Example:

```python
# Data to be processed: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) 
cast(first, "str")

# Result
{
  "first": "1"
}
```

### `cidr()` {#fn-cidr}

Function Prototype: `fn cidr(ip: str, prefix: str) bool`

Function Description: Determine if an IP address is within a certain CIDR block.

Function Parameters:

- `ip`: IP address.
- `prefix`: IP prefix, such as `192.0.2.1/24`.

Example:

```python
# Data to be processed:

# Processing script

ip = "192.0.2.233"
if cidr(ip, "192.0.2.1/24") {
    add_key(ip_prefix, "192.0.2.1/24")
}

# Result
{
  "ip_prefix": "192.0.2.1/24"
}
```

### `conv_traceid_w3c_to_dd()` {#fn-conv-traceid-w3c-to-dd}

Function Prototype: `fn conv_traceid_w3c_to_dd(key)`

Function Description: Convert a hexadecimal encoded 128-bit/64-bit W3C Trace ID string (length of 32 characters or 16 characters) to a decimal encoded 64-bit DataDog Trace ID string.

Function Parameter:

- `key`: The 128-bit/64-bit Trace ID to be converted.

Example: 

```python

# script input:

"18962fdd9eea517f2ae0771ea69d6e16"

# script:

grok(_, "%{NOTSPACE:trace_id}")

conv_traceid_w3c_to_dd(trace_id)

# result:

{
    "trace_id": "3089600317904219670",
}

```


### `cover()` {#fn-cover}

### `cover()` {#fn-cover}

Function Prototype: `fn cover(key: str, range: list)`

Function Description: Desensitize the string data obtained from the specified field by covering it within a specified range.

Function Parameters:

- `key`: The field to be extracted.
- `range`: The index range for desensitizing the string (`[start,end]`). Both `start` and `end` support negative indices, which represent a semantic of tracing back from the end. The range can be reasonable, and if `end` is greater than the maximum length of the string, it will default to the maximum length.

Example:

```python
# Data to be processed {"str": "13789123014"}
json(_, `str`)
cover(`str`, [8, 9])

# Data to be processed {"abc": "13789123014"}
json(_, abc)
cover(abc, [2, 4])
```

### `create_point()` {#fn-create-point}

Function Prototype: `fn create_point(name, tags, fields, ts = 0, category = "M", after_use = "")`

Function Description: Create new data and outputs it. This function is not suitable for central Pipelines.

Function Parameters:

- `name`: The point name, considered as the name of the metric set, log source, etc.
- `tags`: Data tags.
- `fields`: Data fields.
- `ts`: Optional parameter, unix nanosecond timestamp, defaults to the current time.
- `category`: Optional parameter, data category, supports category names and abbreviations, such as `M` or `metric` for metrics, and `L` or `logging` for logs.
- `after_use`: Optional parameter, after creating the point, specifies a pl script to execute on the created point; if the original data type is L and the category of the created data is M, the script executed is still under the L category.

Example:

```python
# Input
'''
{"a": "b"}
'''
fields = load_json(_)
create_point("name_pt", {"a": "b"}, fields)
```

### `datetime()` {#fn-datetime}

Function Prototype: `fn datetime(key, precision: str, fmt: str, tz: str = "")`

Function Description: Convert a timestamp into a specified date format.

Function Parameters:

- `key`: The extracted timestamp.
- `precision`: The precision of the input timestamp (s, ms, us, ns).
- `fmt`: Date format, built-in date formats are provided and custom date formats are supported.
- `tz`: Timezone (optional parameter), converts the timestamp to the time in the specified timezone, default is the host's timezone.

Built-in Date Formats:

| Built-in Format | Date Example                           | Description |
| --------------- | -------------------------------------- | ----------- |
| "ANSI-C"        | "Mon Jan _2 15:04:05 2006"            |             |
| "UnixDate"      | "Mon Jan _2 15:04:05 MST 2006"        |             |
| "RubyDate"      | "Mon Jan 02 15:04:05 -0700 2006"      |             |
| "RFC822"        | "02 Jan 06 15:04 MST"                 |             |
| "RFC822Z"       | "02 Jan 06 15:04 -0700"               | RFC822 with numeric zone  |
| "RFC850"        | "Monday, 02-Jan-06 15:04:05 MST"      |             |
| "RFC1123"       | "Mon, 02 Jan 2006 15:04:05 MST"       |             |
| "RFC1123Z"      | "Mon, 02 Jan 2006 15:04:05 -0700"     | RFC1123 with numeric zone |
| "RFC3339"       | "2006-01-02T15:04:05Z07:00"           |             |
| "RFC3339Nano"   | "2006-01-02T15:04:05.999999999Z07:00" |             |
| "Kitchen"       | "3:04PM"                              |             |

Custom Date Format:

You can customize the output date format through a combination of placeholders.

| Character | Example | Description |
| --------- | ------- | ----------- |
| a         | %a      | Abbreviated weekday name (e.g., `Wed`) |
| A         | %A      | Full weekday name (e.g., `Wednesday`) |
| b         | %b      | Abbreviated month name (e.g., `Mar`) |
| B         | %B      | Full month name (e.g., `March`) |
| C         | %C      | Century (year / 100) |
| d         | %d      | Day of the month (range `[01, 31]`) |
| e         | %e      | Day of the month (range `[1, 31]`), space-padded |
| H         | %H      | Hour of the day, 24-hour clock (range `[00, 23]`) |
| I         | %I      | Hour of the day, 12-hour clock (range `[01, 12]`) |
| ...       | ...     | ... |

Example:

```python
# Data to be processed:
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

Function Prototype: `fn decode(text: str, text_encode: str)`

Function Description: Convert `text` to UTF8 encoding to address issues where the original log is not in UTF8 encoding. Currently supported encodings are utf-16le/utf-16be/gbk/gb18030 (these encoding names must be lowercase).

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```

### `default_time()` {#fn-default-time}

Function Prototype: `fn default_time(key: str, timezone: str = "")`

Function Description: Use a specific field as the timestamp for the final data.

Function Parameters:

- `key`: The specified key, the data type of the key needs to be a string.
- `timezone`: Specify the timezone used for the time format of the text to be formatted, an optional parameter, the default is the current system timezone, timezone examples `+8/-8/+8:30`.

The data to be processed supports the following formatted times. 


<!-- markdownlint-disable MD038 -->
| Data Format                                           | Data Format                                                | Data Format                                       | Data Format                          |
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
| `20140722105203`                                   | `April 8th, 2014`                                  | `1332151919`                                   | `2006-01-02T15:04:05+0000`        |
| `1384216367189`                                    | `2009-08-12T22:15:09-07:00`                             | `1384216367111222`                             | `2009-08-12T22:15:09`             |
| `1384216367111222333`                              | `2009-08-12T22:15:09Z`                                  |
<!-- markdownlint-enable -->

### JSON Extraction Example:

```python
# Original JSON
{
    "time":"06/Jan/2017:16:16:37 +0000",
    "second":2,
    "third":"abc",
    "forth":true
}

# Pipeline script
json(_, time)      # Extract the 'time' field
default_time(time) # Convert the extracted 'time' field into a timestamp

# Processing result
{
  "time": 1483719397000000000,
}
```

### Text Extraction Example:

```python
# Original log text
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms

# Pipeline script
grok(_, '%{TIMESTAMP_ISO8601:log_time}')   # Extract log time and name the field 'log_time'
default_time(log_time)                     # Convert the extracted 'log_time' field into a timestamp

# Processing result
{
  "log_time": 1610358231887000000,
}

# For data collected by the logging agent, it is best to name the time field 'time', otherwise the logging agent will fill in the current time
rename("time", log_time)

# Processing result
{
  "time": 1610358231887000000,
}
```

### `delete()` {#fn-delete}

Function Prototype: `fn delete(src: map[string]any, key: str)`

Function Description: Delete the key in the JSON map.

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

Function Prototype: `fn drop()`

Function Description: Discard the entire log and does not upload it.

```python
# Input {"str_a": "2", "str_b": "3"}
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

Function Prototype: `fn drop_key(key)`

Function Description: Delete the extracted field.

Function Parameter:

- `key`: The name of the field to be deleted.

Example:

```python
# Data = "{\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}"

# Processing script
json(_, age)
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

Function Prototype: `fn drop_origin_data()`

Function Description: Discard the original text; otherwise, the original text is placed in the message field.

Example:

```python
# Delete 'message' content in the result set
drop_origin_data()
```

### `duration_precision()` {#fn-duration-precision}

Function Prototype: `fn duration_precision(key, old_precision: str, new_precision: str)`

Function Description: Convert the precision of a duration, specifying the current and target precisions through parameters. Support conversion between s, ms, us, and ns.

```python
# Input {"ts":12345}
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

Function Prototype: `fn exit()`

Function Description: End the parsing of the current log; if the `drop()` function is not called, the already parsed parts will still be output.


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

### Function Prototype: `fn format_int(val: int, base: int) str`

Function Description: Convert a number into a numeric string of a specified base.

Parameters:

- `val`: The integer to be converted.
- `base`: The base, ranging from 2 to 36; for bases greater than 10, lowercase letters a to z are used to represent values 10 and above.

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


### `geoip()` {#fn-geoip}

Function Prototype: `fn geoip(ip: str)`

Function Description: Append more IP information to the IP. `geoip()` will additionally produce multiple fields, such as:

- `isp`: Internet Service Provider
- `city`: City
- `province`: Province
- `country`: Country

Parameter:

- `ip`: The extracted IP field, supports IPv4 and IPv6

Example:

```python
# Data to be processed: {"ip":"1.2.3.4"}

# Processing script
json(_, ip)
geoip(ip)

# Processing result
{
  "city"     : "Brisbane",
  "country"  : "AU",
  "ip"       : "1.2.3.4",
  "province" : "Queensland",
  "isp"      : "unknown"
  "message"  : "{\"ip\": \"1.2.3.4\"}",
}
```

### `get_key()` {#fn-get-key}

Function Prototype: `fn get_key(key_name)`

Function Description: Read the value of a key from the input point, rather than the value of a variable on the stack.

Function Parameter:

- `key_name`: The name of the key.

Example:

```python
add_key("city", "shanghai")

# Here you can directly access the value of the key with the same name in the point through "city"
if city == "shanghai" {
  add_key("city_1", city)
}

# Due to the right associativity of assignment, first get the value of the key "city",
# and then create a variable named "city"
city = city + " --- ningbo" + " --- " +
    "hangzhou" + " --- suzhou ---" + ""

# get_key retrieves the value of "city" from the point
# If there is a variable named "city", you cannot directly retrieve from the point
if city != get_key("city") {
  add_key("city_2", city)
}

# Processing result
"""
{
  "city": "shanghai",
  "city_1": "shanghai",
  "city_2": "shanghai --- ningbo --- hangzhou --- suzhou ---"
}
"""
```

### `gjson()` {#fn-gjson}

Function Prototype: `fn gjson(input, json_path: str, newkey: str)`

Function Description: Extract the specified field from JSON, allow it to be named as a new field, and ensure it is arranged in the original order.

Parameters:

- `input`: The JSON to be extracted, can be the original text (`_`) or a `key` extracted after the first extraction.
- `json_path`: JSON path information.
- `newkey`: The extracted data is written to a new key.

```python
# Directly extract the x.y field from the original input JSON and name it as a new field abc
gjson(_, "x.y", "abc")

# A `key` has been extracted, extract it again for `x.y`, and the extracted field name is `x.y`
gjson(key, "x.y") 

# Extract an array, both `key` and `abc` are array types
gjson(key, "1.abc.2")
```

Example One:

```python
# Data to be processed:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script:
gjson(_, "info", "zhangsan")
gjson(zhangsan, "name")
gjson(zhangsan, "age", "age")

# Processing result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example Two:

```python
# Data to be processed:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age":37,
#     "children": ["Sara","Alex","Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
gjson(_, "name")
gjson(name, "first")
```

Example Three:

```python
# Data to be processed:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script for JSON array:
gjson(_, "0.nets.1")
```

### `grok()` {#fn-grok}

Function Prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function Description: Extract content from the text string `input` using the `pattern`. Return true when the pattern matches `input` successfully, otherwise returns false.

Parameters:

- `input`: The text to be extracted, can be the original text (`_`) or a `key` extracted after the first extraction.
- `pattern`: The grok expression, which supports specifying the data type of the key in the expression: bool, float, int, string (corresponding to ppl's str, or can also be written as str). Default is string.
- `trim_space`: Remove the leading and trailing whitespace characters from the extracted text. The default value is true.

```python
grok(_, pattern)    # Directly use the input text as the raw data
grok(key, pattern)  # Perform another grok on a previously extracted key
```

Example:

```python
# Data to be processed: "12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key(grok_match_ok)

### Processing Results

```json
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123
}
```

```json
{
  "date": "12/01/2021",
  "grok_match_ok": true,
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123,
  "status": "unknown",
  "time": 1665994187473917724
}
```

### `group_between()` {#fn-group-between}

Function Prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function Description: If the value of `key` is within the specified range `between` (note: only a single interval is allowed, such as `[0, 100]`), a new field can be created with a new value. If no new field is provided, the original field value is overwritten.

Example One:

```python
# Data to be processed: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the value of http_status is within the specified range, change its value to "OK"
group_between(http_status, [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example Two:

```python
# Data to be processed: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the value of http_status is within the specified range, create a new status field with the value "OK"
group_between(http_status, [200, 300], "OK", status)

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function Prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new-key = "")`

Function Description: If the value of `key` is in the list `in`, a new field can be created with a new value. If no new field is provided, the original field value is overwritten.

Example:

```python
# If the value of log_level is in the list, change its value to "OK"
group_in(log_level, ["info", "debug"], "OK")

# If the value of http_status is in the specified list, create a new status field with the value "not-ok"
group_in(log_level, ["error", "panic"], "not-ok", status)
```

### `http_request()` {#fn-http-request}

Function Prototype: `fn http_request(method: str, url: str, headers: map, body: any) map`

Function Description: Send an HTTP request, receives a response, and encapsulates it into a map.

Parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional headers, type map[string]string
- `body`: Request body

Return value type: map

The key contains status code (status_code) and response body (body).

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

Function Prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function Description: Extract the specified field from JSON and can name it as a new field.

Parameters:

- `input`: JSON to be extracted, can be the original text (`_`) or a `key` extracted after the first extraction.
- `json_path`: JSON path information.
- `newkey`: The extracted data is written to a new key.
- `trim_space`: Remove leading and trailing whitespace characters from the extracted text. The default value is `true`.
- `delete_after_extract`: Delete the current object after extraction, and rewrite the object to be extracted after reserializing; can only be applied to the deletion of keys and values in a map, not for deleting elements in a list; the default value is `false`, no operation is performed.

```python
# Directly extract the x.y field from the original input JSON and name it as a new field abc
json(_, x.y, abc)

# A `key` has been extracted, extract it again for `x.y`, and the extracted field name is `x.y`
json(key, x.y) 
```

Example One:

```python
# Data to be processed:
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

Example Two:

```python
# Data to be processed:
# {
#     "name": {"first": "Tom", "last": "Anderson"},
#     "age":37,
#     "children": ["Sara","Alex","Jack"],
#     "fav.movie": "Deer Hunter",
#     "friends": [
#         {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#         {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#         {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#     ]
# }

# Processing script:
json(_, name)
json(name, first)
```

Example Three:

```python
# Data to be processed:
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# Processing script for JSON array:
json(_, .[0].nets[-1])
```

Example Four:

```python
# Data to be processed:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
json(_, item2.item3, item, delete_after_extract = true)

# Output:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}",
}
```

Example Five:

```python
# Data to be processed:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# If you try to delete a list element, the script check will not pass
json(_, item2.item3[0], item, true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```

### `kv_split()` {#fn-kv_split}

Function Prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function Description: Extract all key-value pairs from a string.

Parameters:

- `key`: The name of the key.
- `include_keys`: A list
- `field_split_pattern`: The string split pattern, a regular expression used to extract all key-value pairs; the default value is `" "`.
- `value_split_pattern`: Used to split the key and value from the key-value pair string, non-recursively; the default value is `"="`
- `trim_key`: Remove all specified characters from the beginning and end of the extracted key; the default value is `""`.
- `trim_value`: Remove all specified characters from the beginning and end of the extracted value; the default value is `""`.
- `prefix`: Add a prefix string to all keys.

Example: 


```python
# input: "a=1, b=2 c=3"
kv_split(_)
 
'''output:
{
  "message": "a=1, b=2 c=3",
  "status": "unknown",
  "time": 1679558730846377132
}
'''
```

```python
# input: "a=1, b=2 c=3"
kv_split(_, include_keys=["a", "c", "b"])
 
'''output:
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
# input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c", "b"])

'''output:
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
# input: "a=1, b=2 c=3"
kv_split(_, trim_value=",", include_keys=["a", "c"])

'''output:
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
# input: "a::1,+b::2+c::3" 
kv_split(_, field_split_pattern="\\+", value_split_pattern="[:]{2}",
    prefix="with_prefix_",trim_value=",", trim_key="a", include_keys=["a", "b", "c"])

'''output:
{
  "message": "a::1,+b::2+c::3",
  "status": "unknown",
  "time": 1678087473255241547,
  "with_prefix_b": "2",
  "with_prefix_c": "3"
}
'''
```


### `len()` {#fn-len}

### Function Prototype: `fn len(val: str|map|list) int`

Function Description: Calculate the number of bytes in a string, and the number of elements in a map and list.

Parameters:

- `val`: Can be a map, list, or string.

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
# Processing Result
{
  "abc": 1,
}
```

### `load_json()` {#fn-load-json}

Function Prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function Description: Convert a JSON string into one of map, list, nil, bool, float, and allows for value retrieval and modification through index expressions. If deserialization fails, it returns nil instead of terminating the script.

Parameters:

- `val`: Must be data of type string.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key(abc, abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to synchronize data on the stack to the point
add_key(abc, abc["a"]["first"][-1])

add_key(len_abc, len(abc))

add_key(len_abc, len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function Prototype: `fn lowercase(key: str)`

Function Description: Convert the content of the extracted key to lowercase.

Function Parameter:

- `key`: The name of the specified extracted field to be converted.

Example:

```python
# Data to be processed: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) lowercase(first)

# Processing result
{
    "first": "hello"
}
```

### `match()` {#fn-match}

Function Prototype: `fn match(pattern: str, s: str) bool`

Function Description: Use a specified regular expression to match a string. Return true if the match is successful, otherwise false.

Parameters:

- `pattern`: The regular expression.
- `s`: The string to be matched.

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

Function Prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function Description: Query an external reference table with multiple keys and appends all columns of the first row of the query result to the field. This function is not suitable for central Pipelines.

Parameters:

- `table_name`: The name of the table to be queried.
- `keys`: A list of multiple column names.
- `values`: The corresponding values for each column.

Example:

```python
json(_, table)
json(_, key)
json(_, value)

# Query and append data of the current column, added to the field by default
mquery_refer_table(table, values=[value, false], keys=[key, "col4"])
```

Example Result: 

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

### Function Prototype: `fn nullif(key, value)`

Function Description: If the content of the extracted field specified by `key` is equal to the `value`, this field is deleted.

Function Parameters:

- `key`: The specified field.
- `value`: The target value.

Example:

```python
# Data to be processed: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) json(_, second) nullif(first, "1")

# Processing result
{
    "second": 2
}
```

> Note: This functionality can also be implemented using `if/else` semantics:

```python
if first == "1" {
    drop_key(first)
}
```

### `parse_date()` {#fn-parse-date}

Function Prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function Description: Convert the values of the date field parts passed into a timestamp.

Function Parameters:

- `key`: The new field to be inserted.
- `yy`: Year as a numeric string, supports four or two-digit strings; if it is an empty string, the current year is taken during processing.
- `MM`: Month as a string, supports numeric, English, and English abbreviations.
- `dd`: Day as a string.
- `hh`: Hour as a string.
- `mm`: Minute as a string.
- `ss`: Second as a string.
- `ms`: Millisecond as a string.
- `us`: Microsecond as a string.
- `ns`: Nanosecond as a string.
- `zone`: Timezone string, in the form of "±8" or "Asia/Shanghai".

Example:

```python
parse_date(aa, "2021", "May", "12", "10", "10", "34", "", "Asia/Shanghai") # Result aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "", "Asia/Shanghai") # Result aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", "Asia/Shanghai") # Result aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", "", "+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function Prototype: `fn parse_duration(key: str)`

Function Description: If the value of `key` is a Golang duration string (e.g., `123ms`), the `key` is automatically parsed into an integer in nanoseconds.

Currently, the duration units in Golang are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function Parameter:

- `key`: The field to be parsed.

Example:

```python
# Assuming abc = "3.5s"
parse_duration(abc) # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration(abc) # Result abc = -3500000000

# Supports floating-point: abc = "-2.3s"
parse_duration(abc) # Result abc = -2300000000
```

### `parse_int()` {#fn-parse-int}

Function Prototype: `fn parse_int(val: str, base: int) int`

Function Description: Convert the string representation of a number to a numerical value.

Parameters:

- `val`: The string to be converted.
- `base`: The base, range 0, or 2 to 36; if the value is 0, the base is determined by the prefix of the string.

Example: 

```python
# script0
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

# script1
a = "6a60b39fd95aaf71" 
b = parse_int(a, 16)            # base 16
if b != 7665324064912355185 {
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
b = parse_int(a, 0)            # the true base is implied by the string's 
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


### `point_window` {fn-point-window}

Function Prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function Description: Record the discarded data and works in conjunction with the `window_hit` function to upload the context of the discarded `Point` data.

Function Parameters:

- `before`: The maximum number of Points that can be temporarily stored before the execution of the `window_hit` function, and the undiscarded data is counted.
- `after`: The number of Points to be retained after the execution of the `window_hit` function, and the undiscarded data is counted.
- `stream_tags`: Distinguish log (metrics, trace, etc.) streams through tags on the data. The default uses `filepath` and `host` to distinguish logs from the same file.

Example:

```python
# Recommended to be placed in the first line of the script
#
point_window(8, 8)

# If it is a panic log, retain the first 8 and the last 8 (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # Only if point_window() is executed during this run, this function will take effect
    # Trigger the data recovery behavior within the window
    #
    window_hit()
}

# Default to discard all logs with service as test_app;
# If it contains panic logs, retain 15 adjacent logs including the current one
#
if service == "test_app" {
    drop()
}
```

### `pt_name()` {#fn-pt-name}

Function Prototype: `fn pt_name(name: str = "") -> str`

Function Description: Get the name of the point; if the argument is not empty, sets a new name.

Function Parameters:

- `name`: The value as the point name; the default is an empty string.

The relationship between Point Name and the field mapping when storing various types of data:

| Category        | Field Name |
| --------------- | ---------- |
| custom_object   | class      |
| keyevent        | -          |
| logging         | source     |
| metric          | -          |
| network         | source     |
| object          | class      |
| profiling       | source     |
| rum             | source     |
| security        | rule       |
| tracing         | source     |

### `query_refer_table()` {#fn-query-refer-table}

Function Prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function Description: Query an external reference table with the specified key and appends all columns of the first row of the query result to the field. This function is not suitable for the central Pipeline.

Parameters:

- `table_name`: The name of the table to be searched.
- `key`: The name of the column.
- `value`: The value corresponding to the column.

Example:

```python
# Extract the table name, column name, and column value from the input
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column, default to add to the field in the data
query_refer_table(table, key, value)
```

Example Result:

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

Function Prototype: `fn rename(new_key, old_key)`

Function Description: Rename an already extracted field.

Parameters:

- `new_key`: The new field name.
- `old_key`: The name of the already extracted field.

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', abc)

# or 

rename(abc1, abc)
```

```python
# Data to be processed: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

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

Function Prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function Description: Replace the string data obtained on the specified field with a regular expression.

Function Parameters

- `key`: The field to be extracted.
- `regex`: The regular expression.
- `replace_str`: The string to be replaced.

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, str_abc)
replace(str_abc, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name {"str_abc": "zhang san"}
json(_, str_abc)
replace(str_abc, "([a-z]*) \\w*", "$1 ***")

# ID number {"str_abc": "362201200005302565"}
json(_, str_abc)
replace(str_abc, "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name {"str_abc": "小阿卡"}
json(_, str_abc)
replace(str_abc, '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function Prototype: `fn sample(p)`

Function Description: Select to collect or discard data with a probability of p.

Function Parameter:

- `p`: The probability that the sample function returns true, with a range of [0, 1].

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., with a 30% probability of returning true, 70% of the data will be discarded here
  drop() # Mark this data as discarded
  exit() # Exit the subsequent processing flow
}
```

### `set_measurement()` {#fn-set-measurement}

Function Prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function Description: Change the name of the line protocol.

Function Parameters:

- `name`: The value as the measurement name, which can be a string constant or variable.
- `delete_key`: If there is a tag or field in the point with the same name as the variable, it is deleted.

The relationship between the line protocol name and the field mapping when storing various types of data or other uses:

| Category          | Field Name | Other Uses |
| -             | -      | -        |
| custom_object | class  | -        |
| keyevent      | -      | -        |
| logging       | source | -        |
| metric        | -      | measurement name |
| network       | source | -        |
| object        | class  | -        |
| profiling     | source | -        |
| rum           | source | -        |
| security      | rule   | -        |
| tracing       | source | -        |


### `set_tag()` {#fn-set-tag}

Function Prototype: `fn set_tag(key, value: str)`

Function Description: Mark the specified field as a tag for output. After being set as a tag, other functions can still operate on this variable. If the key that is set as a tag is a field that has been extracted, it will not appear in the fields, which can avoid the conflict between the extracted field key and the existing tag key on the data.

Function Parameters:

- `key`: The field to be marked as a tag.
- `value`: Can be a string literal or a variable.

Example:

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
# * The character `#` is only a mark for fields as tags when outputting with datakit --pl <path> --txt <str>

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

### `sql_cover()` {#fn-sql-cover}

Function Prototype: `fn sql_cover(sql_test: str)`

Function Description: Desensitize the SQL statement.

Example:

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function Prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function Description: Format the content of the specified fields `arg1, arg2, ...` according to `fmt` and writes the formatted content into the `key` field.

Function Parameters:

- `key`: The field name where the formatted data is written.
- `fmt`: The format string template.
- `args`: Variable arguments, can be multiple names of the fields that have been extracted and are to be formatted.

Example:

```python
# Data to be processed: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, a.second)
json(_, a.thrid)
cast(a.second, "int")
json(_, a.forth)
strfmt(bb, "%v %s %v", a.second, a.thrid, a.forth)
```

### `timestamp()` {#fn-timestamp}

Function Prototype: `fn timestamp(precision: str = "ns") -> int`

Function Description: Return the current Unix timestamp with a default precision of ns.

Function Parameters:

- `precision`: The precision of the timestamp, which can be "ns", "us", "ms", "s", with the default value being "ns".

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

### `trim()` {#fn-trim}

Function Prototype: `fn trim(key, cutset: str = "")`

Function Description: Remove the characters specified in `cutset` from the beginning and end of `key`. When `cutset` is an empty string, it defaults to removing all whitespace.

Function Parameters:

- `key`: A certain field that has been extracted, of string type.
- `cutset`: The characters in `key` that appear in the `cutset` string are removed from the beginning and end.

Example:

```python
# Data to be processed: "trim(key, cutset)"

# Processing script
add_key(test_data, "ACCAA_test_DataA_ACBA")
trim(test_data, "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function Prototype: `fn uppercase(key: str)`

Function Description: Convert the content in the extracted key to uppercase.

Function Parameters:

- `key`: The name of the field to be converted to uppercase.

Example:

```python
# Data to be processed: {"first": "hello","second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) uppercase(first)

# Processing result
{
   "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function Prototype: `fn url_decode(key: str)`

Function Description: Decode the URL in the extracted `key` into plain text.

Parameters:

- `key`: A certain `key` that has been extracted.

Example:

```python
# Data to be processed: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, url) url_decode(url)

# Processing result
{
  "message": "{"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
  "url": "http://www.baidu.com/s?wd=测试" 
}
```

### `url_parse()` {#fn-url-parse}

Function Prototype: `fn url_parse(key)`

Function Description: Parse the URL of the field named `key`.

Function Parameters:

- `key`: The field name of the URL to be parsed.

Example:

```python
# Data to be processed: {"url": "https://www.baidu.com"} 

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

The above example extracts the scheme from the URL. In addition to this, other information such as host, port, path, and parameters carried in the URL can also be extracted, as shown in the following example:

```python
# Data to be processed: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"} 

# Processing script
json(_, url)
m = url_parse(url)
add_key(sclient, m["params"]["sclient"])    # Parameters carried in the URL are saved under the params field
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

Function Prototype: `fn use(name: str)`

Parameters:

- `name`: The script name, such as abp.p.

Function Description: Call another script, allowing the called script to access all current data.

Example:

```python
# Data to be processed: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, ip)
geoip(ip)

# The processing result of executing script a.p

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

Function Prototype: `fn user_agent(key: str)`

Function Description: Obtain client information from the specified field.

Function Parameter:

- `key`: The field to be extracted.

The `user_agent()` function will produce multiple fields, such as:

- `os`: Operating system
- `browser`: Browser

Example:

```python
# Data to be processed
#    {
#        "userAgent" : "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#        "second"    : 2,
#        "third"     : "abc",
#        "forth"     : true
#    }

json(_, userAgent) user_agent(userAgent)
```

### `valid_json()` {#fn-valid-json}

Function Prototype: `fn valid_json(val: str) bool`

Function Description: Determine whether it is a valid JSON string.

Parameter:

- `val`: The data required to be of string type.

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
if valid_json(d) { # false, corrected from true to false as "???" is not a valid JSON start
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

Function Prototype: `fn value_type(val) str`

Function Description: Get the type of the value of a variable, the return value range ["int", "float", "bool", "str", "list", "map", ""], if the value is nil, an empty string is returned.

Parameter:

- `val`: The value to determine the type.

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

### `window_hit` {fn-window-hit}

Function Prototype: `fn window_hit()`

Function Description: Trigger the recovery event for the discarded context data, recovering from the data recorded by the `point_window` function.

Function Parameters: None

Example:

```python
# Recommended to be placed in the first line of the script
#
point_window(8, 8)

# If it is a panic log, keep the first 8 and the last 8 (including the current one)
if grok(_, "abc.go:25 panic: xxxxxx") {
    # Only if point_window() is executed during this run, this function will take effect
    # Trigger the data recovery behavior within the window
    #
    window_hit()
}

# By default, discard all logs with service as test_app;
# If it contains panic logs, keep 15 adjacent logs including the current one
#
if service == "test_app" {
    drop()
}
```

### `xml()` {#fn-xml}

Function Prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function Description: Extract fields from XML using an xpath expression.

Parameters:

- input: The XML to be extracted.
- xpath_expr: The xpath expression.
- key_name: The new key where the extracted data is written.

Example One:

```python
# Data to be processed
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
  "message": "\t\t<entry>\n <fieldx>valuex</fieldx>\n <fieldy>...</fieldy>\n <fieldz>...</fieldz>\n <fieldarray>\n     <fielda>element_a_1</fielda>\n     <fielda>element_a_2</fielda>\n </fieldarray>\n</entry>",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example Two:

```python
# Data to be processed
<OrderEvent actionCode="5">
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
  "message": "<OrderEvent actionCode=\"5\">\n <OrderNumber>ORD12345</OrderNumber>\n <VendorNumber>V11111</VendorNumber>\n</OrderEvent>",
  "status": "unknown",
  "time": 1655523193632471000
}
```
