# Built-in Function {#functions}
---

Function parameter description:

- In function arguments, the anonymous argument (`_`) refers to the original input text data
- JSON path, expressed directly as `x.y.z`, without any other modifications. For example, `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`, where the JSON path is `a.thrid` to indicate that the data to be manipulated is `abc`
- The relative order of all function arguments is fixed, and the engine will check it concretely
- All of the `key` parameters mentioned below refer to the `key` generated after the initial extraction (via `grok()` or `json()`)
- The path of the JSON to be processed, supports the writing of identifiers, and cannot use strings. If you are generating new keys, you need to use strings

## Function List {#function-list}

### `add_key()` {#fn-add-key}

Function prototype: `fn add_key(key, value)`

Function description: Add a key to point

Function parameters:

- `key`: key name
- `value`: key value

Example:

```python
# input: {"age": 17, "name": "zhangsan", "height": 180}

# script
add_key(city, "shanghai")

# result
{
    "age": 17,
    "height": 180,
    "name": "zhangsan",
    "city": "shanghai"
}
```


### `add_pattern()` {#fn-add-pattern}

Function prototype: `fn add_pattern(name: str, pattern: str)`

Function description: Create custom grok patterns. The grok pattern has scope restrictions, such as a new scope will be generated in the if else statement, and the pattern is only valid within this scope. This function cannot overwrite existing grok patterns in the same scope or in the previous scope

Function parameters:

- `name`: pattern naming
- `pattern`: custom pattern content

Example:

```python
# input data: "11,abc,end1", "22,abc,end1", "33,abc,end3"

# script
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
        add_pattern("bb", "[\\d]{5}") # Overwriting bb here fails
        add_pattern("cc", "end3")
        grok(_, "%{aa:aa},%{bb:bb},%{cc:cc}")
    }
}

# result
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

- `key`: Nanosecond timestamp, such as the timestamp obtained by the `default_time(time)` function
- `minute`: The return value allows the number of minutes (integer) beyond the current time, the value range is [0, 15], the default value is 2 minutes

Function description: Make the difference between the incoming timestamp minus the timestamp of the function execution time within (-60+minute, minute] minutes; it is not applicable to data whose time difference exceeds this range, otherwise it will result in wrong data being obtained. Calculation process:

1. Add hours to the value of key to make it within the current hour
2. At this time, calculate the difference between the two minutes. The value range of the two minutes is [0, 60), and the difference range is between (-60,0] and [0, 60)
3. If the difference is less than or equal to -60 + minute, add 1 hour, and if the difference is greater than minute, subtract 1 hour
4. The default value of minute is 2, and the range of the difference is allowed to be (-58, 2], if it is 11:10 at this time, the log time is 3:12:00.001, and the final result is 10:12:00.001; if at this time is 11:59:1.000, the log time is 3:01:1.000, and the final result is 12:01:1.000

Example:

```json
# input data 1 
{
    "time":"11 Jul 2022 12:49:20.937", 
    "second":2,
    "third":"abc",
    "forth":true
}
```

Script：

```python
json(_, time)      # Extract the time field (if the time zone in the container is UTC+0000)
default_time(time) # Convert the extracted time field into a timestamp
                   # (Use local time zone UTC+0800/UTC+0900... parsing for data without time zone)
adjust_timezone(time)
                   # Automatically (re)select time zone, calibrate time offset

```

Execute `datakit pipeline -P <name>.p -F <input_file_name>  --date`:

```json
# output 1
{
  "message": "{\n    \"time\":\"11 Jul 2022 12:49:20.937\",\n    \"second\":2,\n    \"third\":\"abc\",\n    \"forth\":true\n}",
  "status": "unknown",
  "time": "2022-07-11T20:49:20.937+08:00"
}
```

local time: `2022-07-11T20:55:10.521+08:00`

The times obtained by using only `default_time` and parsing according to the default local time zone (UTC+8) are:

- Output result of input 1： `2022-07-11T12:49:20.937+08:00`

After using `adjust_timezone` will get:

- Output result of input 1： `2022-07-11T20:49:20.937+08:00`


### `agg_create()` {#fn-agg-create}

Function prototype: `fn agg_create(bucket: str, on_interval: str = "60s", on_count: int = 0, keep_value: bool = false, const_tags: map[string]string = nil, category: str = "M")`

Function description: Create an aggregation measurement, set the time or number of times through `on_interval` or `on_count` as the aggregation period, upload the aggregated data after the aggregation is completed, and choose whether to keep the last aggregated data. This function does not work with central Pipeline.

Function parameters:

- `bucket`: String type, as an aggregated field, if the bucket has already been created, the function will not perform any operations.
- `on_interval`：The default value is `60s`, which takes time as the aggregation period, and the unit is `s`, and the parameter takes effect when the value is greater than `0`; it cannot be combined with `on_count` less than or equal to 0.
- `on_count`: The default value is `0`, the number of processed points is used as the aggregation period, and the parameter takes effect when the value is greater than `0`.
- `keep_value`: The default value is `false`.
- `const_tags`: Custom tags, empty by default.
- `category`: Data category for aggregated data, optional parameter, the default value is "M", indicating the indicator category data.

示例：

```python
agg_create("cpu_agg_info", on_interval = "30s")
```


### `agg_metric()` {#fn-agg-metric}

[:octicons-tag-24: Version-1.5.10](../datakit/changelog.md#cl-1.5.10)

Function prototype: `fn agg_metric(bucket: str, new_field: str, agg_fn: str, agg_by: []string, agg_field: str, category: str = "M")`

Function description: According to the field name in the input data, the value is automatically taken as the label of the aggregated data, and the aggregated data is stored in the corresponding bucket. This function does not work with central Pipeline.

Function parameters:

- `bucket`: String type, the bucket created by the agg_create function, if the bucket has not been created, the function will not perform any operations.
- `new_field`： The name of the field in the aggregated data, the data type of its value is `float`.
- `agg_fn`: Aggregation function, can be one of `"avg"`, `"sum"`, `"min"`, `"max"`, `"set"`.
- `agg_by`: The name of the field in the input data will be used as the tag of the aggregated data, and the value of these fields can only be string type data.
- `agg_field`: The field name in the input data, automatically obtain the field value for aggregation.
- `category`: Data category for aggregated data, optional parameter, the default value is "M", indicating the indicator category data.

Example:

Take `logging` category data as an example:

Multiple inputs in a row:

- Sample log one: `{"a": 1}`
- Sample log two: `{"a": 2}`

script:

```python
agg_create("cpu_agg_info", on_interval="10s", const_tags={"tag1":"value_user_define_tag"})

set_tag("tag1", "value1")

field1 = load_json(_)

field1 = field1["a"]

agg_metric("cpu_agg_info", "agg_field_1", "sum", ["tag1", "host"], "field1")
```

metric output:

```json
{
    "host": "your_hostname",
    "tag1": "value1",
    "agg_field_1": 3
}
```


### `append()` {#fn-append}

Function prototype: `fn append(arr, elem) arr`

Function description: Add the element elem to the end of the array arr.

Function parameters:

- `arr`: array
- `elem`: element being added.

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

Function description: Base64 decodes the string data obtained on the specified field

Function parameters:

- `key`: fields to extract

Example:

```python
# input data {"str": "aGVsbG8sIHdvcmxk"}
json(_, `str`)
b64enc(`str`)

# result
# {
#   "str": "hello, world"
# }
```


### `b64enc()` {#fn-b64enc}

Function prototype: `fn b64enc(key: str)`

Function description: Base64 encode the string data obtained on the specified field

Function parameters:

- `key`: key name

Example:

```python
# input data {"str": "hello, world"}
json(_, `str`)
b64enc(`str`)

# result
# {
#   "str": "aGVsbG8sIHdvcmxk"
# }
```


### `cache_get()` {#fn-cache}

Function prototype: `fn cache_get(key: str) nil|str`

Function description: Giving key, cache_get() get the correspond value from cache

Function parameters:

- `key`：key

Example:

```python
a = cache_get("a")
add_key(abc, a)
```

### `cache_set()` {#fn-cache}

Function prototype: `fn cache_set(key: str, value: str, expiration: int) nil`

Function description: save key value pair to cache

Function parameters:

- `key`：key (required)
- `value`：value (required)
- `expiration`：expire time (default=100s)

Example:

```python
a = cache_set("a", "123")
a = cache_get("a")
add_key(abc, a)
```

### `cast()` {#fn-cast}

Function prototype: `fn cast(key, dst_type: str)`

Function description: Convert the key value to the specified type

Function parameters:

- `key`: key name
- `type`：The target type of conversion, support `\"str\", \"float\", \"int\", \"bool\"`

Example:

```python
# input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# script
json(_, first) 
cast(first, "str")

# result
{
  "first": "1"
}
```


### `cidr()` {#fn-cidr}

Function prototype: `fn cidr(ip: str, prefix: str) bool`

Function description: Determine whether the IP is in a CIDR block

Function parameters:

- `ip`: IP address
- `prefix`： IP prefix, such as `192.0.2.1/24`

Example:

```python
# script
ip = "192.0.2.233"
if cidr(ip, "192.0.2.1/24") {
    add_key(ip_prefix, "192.0.2.1/24")
}

# result
{
  "ip_prefix": "192.0.2.1/24"
}
```


### `conv_traceid_w3c_to_dd()`  {#fn-conv-traceid-w3c-to-dd}

Function prototype: `fn conv_traceid_w3c_to_dd(key)`

Function description: Convert a hex-encoded 128-bit/64-bit W3C Trace ID string(length 32 characters or 16 characters) to a decimal-encoded 64-bit DataDog Trace ID string.

Function parameters:

- `key`: 128-bit/64-bit Trace ID to convert

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

Function prototype: `fn cover(key: str, range: list)`

Function description: Perform data desensitization by range on the string data obtained on the specified field

Function parameters:

- `key`: Key name
- `range`: The index range of the desensitized string (`[start,end]`) Both start and end support negative subscripts, which are used to express the semantics of tracing back from the end. The interval is reasonable. If end is greater than the maximum length of the string, it will default to the maximum length

Example:

```python
# input data {"str": "13789123014"}
json(_, `str`)
cover(`str`, [8, 9])

# input data {"abc": "13789123014"}
json(_, abc)
cover(abc, [2, 4])
```


### `create_point()` {#fn-create-point}

Function prototype: `fn create_point(name, tags, fields, ts = 0, category = "M", after_use = "")`

Function description: Create new data and output. This function does not work with central Pipeline.

Function parameters:

- `name`: point name, which is regarded as the name of the metric set, log source, etc.
- `tags`: data tags
- `fields`: data fields
- `ts`: optional parameter, unix nanosecond timestamp, defaults to current time
- `category`: optional parameter, data category, supports category name and name abbreviation, such as metric category can be filled with `M` or `metric`, log is `L` or `logging`
- `after_use`: optional parameter, after the point is created, execute the specified pl script on the created point; if the original data type is L, the created data category is M, and the script under the L category is executed at this time

Example:

```py
# input
'''
{"a": "b"}
'''
fields = load_json(_)
create_point("name_pt", {"a": "b"}, fields)
```


### `datetime()` {#fn-datetime}

Function prototype: `fn datetime(key, precision: str, fmt: str, tz: str = "")`

Function description: Convert timestamp to specified date format

Function parameters:

- `key`: Extracted timestamp (required parameter)
- `precision`: Input timestamp precision (s, ms, us, ns)
- `fmt`: date format, provides built-in date format and supports custom date format
- `tz`: time zone (optional parameter), convert the timestamp to the time in the specified time zone, the default time zone of the host is used

Built-in date formats:

| Built-in format | date                                  | description               |
| -               | -                                     | -                         |
| "ANSI-C"        | "Mon Jan _2 15:04:05 2006"            |                           |
| "UnixDate"      | "Mon Jan _2 15:04:05 MST 2006"        |                           |
| "RubyDate"      | "Mon Jan 02 15:04:05 -0700 2006"      |                           |
| "RFC822"        | "02 Jan 06 15:04 MST"                 |                           |
| "RFC822Z"       | "02 Jan 06 15:04 -0700"               | RFC822 with numeric zone  |
| "RFC850"        | "Monday, 02-Jan-06 15:04:05 MST"      |                           |
| "RFC1123"       | "Mon, 02 Jan 2006 15:04:05 MST"       |                           |
| "RFC1123Z"      | "Mon, 02 Jan 2006 15:04:05 -0700"     | RFC1123 with numeric zone |
| "RFC3339"       | "2006-01-02T15:04:05Z07:00"           |                           |
| "RFC3339Nano"   | "2006-01-02T15:04:05.999999999Z07:00" |                           |
| "Kitchen"       | "3:04PM"                              |                           |


Custom date format:

The output date format can be customized through the combination of placeholders

| character | example | description |
| - | - | - |
| a | %a | week abbreviation, such as `Wed` |
| A | %A | The full letter of the week, such as `Wednesday`|
| b | %b | month abbreviation, such as `Mar` |
| B | %B | The full letter of the month, such as `March` |
| C | %c | century, current year divided by 100 |
| **d** | %d | day of the month; range `[01, 31]` |
| e | %e | day of the month; range `[1, 31]`, pad with spaces |
| **H** | %H | hour, using 24-hour clock; range `[00, 23]` |
| I | %I | hour, using 12-hour clock; range `[01, 12]` |
| j | %j | day of the year, range `[001, 365]` |
| k | %k | hour, using 24-hour clock; range `[0, 23]` |
| l | %l | hour, using 12-hour clock; range `[1, 12]`, padding with spaces |
| **m** | %m | month, range `[01, 12]` |
| **M** | %M | minutes, range `[00, 59]` |
| n | %n | represents a newline character `\n` |
| p | %p | `AM` or `PM` |
| P | %P | `am` or `pm` |
| s | %s | seconds since 1970-01-01 00:00:00 UTC |
| **S** | %S | seconds, range `[00, 60]` |
| t | %t | represents the tab character `\t` |
| u | %u | day of the week, Monday is 1, range `[1, 7]` |
| w | %w | day of the week, 0 for Sunday, range `[0, 6]` |
| y | %y | year in range `[00, 99]` |
| **Y** | %Y | decimal representation of the year|
| **z** | %z | RFC 822/ISO 8601:1988 style time zone (e.g. `-0600` or `+0800` etc.) |
| Z | %Z | time zone abbreviation, such as `CST` |
| % | %% | represents the character `%` |

Example:

```python
# input data:
#    {
#        "a":{
#            "timestamp": "1610960605000",
#            "second":2
#        },
#        "age":47
#    }

# script
json(_, a.timestamp)
datetime(a.timestamp, 'ms', 'RFC3339')
```


```python
# script
ts = timestamp()
datetime(ts, 'ns', fmt='%Y-%m-%d %H:%M:%S', tz="UTC")

# output
{
  "ts": "2023-03-08 06:43:39"
}
```

```python
# script
ts = timestamp()
datetime(ts, 'ns', '%m/%d/%y  %H:%M:%S %z', "Asia/Tokyo")

# output
{
  "ts": "03/08/23  15:44:59 +0900"
}
```


### `decode()` {#fn-decode}

Function prototype: `fn decode(text: str, text_encode: str)`

Function description: Convert text to UTF8 encoding to deal with the problem that the original log is not UTF8 encoded. Currently supported encodings are utf-16le/utf-16be/gbk/gb18030 (these encoding names can only be lowercase)

Example:

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```


### `default_time()` {#fn-defalt-time}

Function prototype: `fn default_time(key: str, timezone: str = "")`

Function description: Use an extracted field as the timestamp of the final data

Function parameters:

- `key`: key name
- `timezone`: Specifies the time zone used by the time text to be formatted, optional parameter, the default is the current system time zone, time zone example `+8/-8/+8:30`

The pending data supports the following formatting times

<!-- markdownlint-disable MD038 -->
| date format                                        | date format                                             | date format                                    | date format                       |
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

Example JSON extraction:

```python
# raw json
{
    "time":"06/Jan/2017:16:16:37 +0000",
    "second":2,
    "third":"abc",
    "forth":true
}

# script
json(_, time)      # extract time field
default_time(time) # convert the extracted time field into a timestamp

# result
{
  "time": 1483719397000000000,
}
```

Text extraction example:

```python
# raw log text
# 2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms

# script
grok(_, '%{TIMESTAMP_ISO8601:log_time}')   # Extract the log time and name the field log_time
default_time(log_time)                     # Convert the extracted log_time field into a timestamp

# result
{
  "log_time": 1610358231887000000,
}

# For the data collected by logging, it is better to name the time field as time, otherwise the logging collector will fill it with the current time
rename("time", log_time)

# result
{
  "time": 1610358231887000000,
}
```


### `delete()` {#fn-delete}

Function prototype: `fn delete(src: map[string]any, key: str)`

Function description: Delete the key in the JSON map

```python

# input
# {"a": "b", "b":[0, {"c": "d"}], "e": 1}

# script
j_map = load_json(_)

delete(j_map["b"][-1], "c")

delete(j_map, "a")

add_key("j_map", j_map)

# result:
# {
#   "j_map": "{\"b\":[0,{}],\"e\":1}",
# }
```


### `drop()` {#fn-drop}

Function prototype: `fn drop()`

Function description: Discard the entire log without uploading

Example:

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

Function description: Delete key

Function parameters:

- `key`: key to be deleted

Example：

```python
# data = "{\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}"

json(_, age,)
json(_, name)
json(_, height)
drop_key(height)

# result
# {
#     "age": 17,
#     "name": "zhangsan"
# }
```


### `drop_origin_data()` {#fn-drop-origin-data}

Function prototype: `fn drop_origin_data()`

Function description: Discard the initial text, otherwise the initial text is placed in the message field

Example:

```python
# input data: {"age": 17, "name": "zhangsan", "height": 180}

# delete message field
drop_origin_data()
```


### `duration_precision()` {#fn-duration-precision}

Function prototype: `fn duration_precision(key, old_precision: str, new_precision: str)`

Function description: Perform duration precision conversion, and specify the current precision and target precision through Function parameters:. Support conversion between s, ms, us, ns.

Example:

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

Function description: End the parsing of the current log, if the function drop() is not called, the parsed part will still be output

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

Function description: Converts a numeric value to a numeric string in the specified base.

Function parameters:

- `val`: The number to be converted.
- `base`: Base, ranging from 2 to 36; when the base is greater than 10, lowercase letters a to z are used to represent values 10 and later.

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
```


### `geoip()` {#fn-geoip}

Function prototype: `fn geoip(ip: str)`

Function description: Append more IP information to IP. `geoip()` will generate additional fields, such as:

- `isp`: operator
- `city`: city
- `province`: province
- `country`: country

Function parameters:

- `ip`: The extracted IP field supports both IPv4 and IPv6

Example:

```python
# input data: {"ip":"1.2.3.4"}

# script
json(_, ip)
geoip(ip)

# result
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

Function prototype: `fn get_key(key)`

Function description: Read the value of key from the input point

Function parameters:

- `key_name`: key name

Example:

```python
add_key("city", "shanghai")

# Here you can directly access the value of the key with the same name in point through city
if city == "shanghai" {
  add_key("city_1", city)
}

# Due to the right associativity of assignment, get the value whose key is "city" first,
# Then create a variable named city
city = city + " --- ningbo" + " --- " +
    "hangzhou" + " --- suzhou ---" + ""

# get_key gets the value of "city" from point
# If there is a variable named city, it cannot be obtained directly from point
if city != get_key("city") {
  add_key("city_2", city)
}

# result
"""
{
  "city": "shanghai",
  "city_1": "shanghai",
  "city_2": "shanghai --- ningbo --- hangzhou --- suzhou ---"
}
"""
```


### `gjson()` {#fn-gjson}

Function prototype: `fn gjson(input, json_path: str, newkey: str)`

Function description: Extract specified fields from JSON, rename them as new fields, and ensure they are arranged in the original order.

Function parameters:

- `input`: The JSON to be extracted can either be the original text (`_`) or a specific `key` after the initial extraction.
- `json_path`: JSON path information
- `newkey`: Write the data to the new key after extraction

```python
# Directly extract the field x.y from the original input JSON and rename it as a new field abc.
gjson(_, "x.y", "abc")

# Extract the x.y field from a previously extracted key, and name the extracted field as x.y.
gjson(key, "x.y")

# Extract arrays, where `key` and `abc` are arrays.
gjson(key, "1.abc.2")
```

Example 1:

```python
# input data:
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# script:
gjson(_, "info", "zhangsan")
gjson(zhangsan, "name")
gjson(zhangsan, "age", "age")

# result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# input data:
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

# script:
gjson(_, "name")
gjson(name, "first")
```

Example 3:

```python
# input data:
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# scripts for JSON list:
gjson(_, "0.nets.1")
```

### `grok()` {#fn-grok}

Function prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function description: Extract the contents of the text string `input` by `pattern`, and return true when pattern matches input successfully, otherwise return false.

Function parameters:

- `input`：The text to be extracted can be the original text (`_`) or a `key` after the initial extraction
- `pattern`: grok expression, the data type of the specified key is supported in the expression: bool, float, int, string (corresponding to Pipeline's str, can also be written as str), the default is string
- `trim_space`: Delete the leading and trailing blank characters in the extracted characters, the default value is true

```python
grok(_, pattern)    #Use the entered text directly as raw data
grok(key, pattern)  # For a key that has been extracted before, do grok again
```

示例：

```python
# input data: "12/01/2021 21:13:14.123"

# script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key(grok_match_ok)

# result
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123
}

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

Function prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function description: If the `key` value is within the specified range `between` (note: it can only be a single interval, such as `[0,100]`), a new field can be created and assigned a new value. If no new field is provided, the original field value will be overwritten

Example 1:

```python
# input data: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the field http_status value is within the specified range, change its value to "OK"
group_between(http_status, [200, 300], "OK")

# result
# {
#     "http_status": "OK"
# }
```

Example 2:

```python
# input data: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the value of the field http_status is within the specified range, create a new status field with the value "OK"
group_between(http_status, [200, 300], "OK", status)

# result
{
    "http_status": 200,
    "status": "OK"
}
```


### `group_in()` {#fn-group-in}

Function prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new-key = "")`

Function description: If the `key` value is in the list `in`, a new field can be created and assigned the new value. If no new field is provided, the original field value will be overwritten

Example:

```python
# If the field log_level value is in the list, change its value to "OK"
group_in(log_level, ["info", "debug"], "OK")

# If the field http_status value is in the specified list, create a new status field with the value "not-ok"
group_in(log_level, ["error", "panic"], "not-ok", status)
```


### `http_request()` {#fn-http-request}

Function prototype: `fn http_request(method: str, url: str, headers: map) map`

Function description: Send an HTTP request, receive the response, and encapsulate it into a map

Function parameters:

- `method`: GET|POST
- `url`: Request path
- `headers`: Additional header，the type is map[string]string

Return type: map

key contains status code (status_code) and result body (body)

- `status_code`: status_code
- `body`: response body

Example:

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key(abc, resp["status_code"])
add_key(abc, resp_body["a"])
```

### `json()` {#fn-json}

Function prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true)`

Function description: Extract the specified field in JSON and name it as a new field.

Function parameters:

- `input`: The JSON to be extracted can be the original text (`_`) or a `key` after the initial extraction
- `json_path`: JSON path information
- `newkey`：Write the data to the new key after extraction
- `trim_space`: Delete the leading and trailing blank characters in the extracted characters, the default value is true
- `delete_after_extract`: After extract delete the extracted info from input. Only map key and map value are deletable, list(array) are not supported. Default is `false'.

```python
# Directly extract the x.y field in the original input json, and name it as a new field abc
json(_, x.y, abc)

# For a `key` that has been extracted, extract `x.y` again, and the extracted field name is `x.y`
json(key, x.y) 
```

Example 1:

```python
# input data: 
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# script:
json(_, info, "zhangsan")
json(zhangsan, name)
json(zhangsan, age, "age")

# result:
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example 2:

```python
# input data:
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

# script:
json(_, name) 
json(name, first)
```

Example 3:

```python
# input data:
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# script:
json(_, .[0].nets[-1])
```

Example 4:

```python
# input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# script:
json(_, item2.item3, item, delete_after_extract = true)

# result:
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}",
}
```


Example 5:

```python
# input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# If you try to remove a list element it will fail the script check.
# Script:
json(_, item2.item3[0], item, delete_after_extract = true)


# test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# report error:
# [E] j2.p:1:54: does not support deleting elements in the list
```


### `kv_split()` {#fn-kv_split}

Function prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function description: extract all key-value pairs from a string

Function parameters:

- `key`: key name
- `include_keys`: list of key names, only extract the keys in the list; **the default value is [], do not extract any key**
- `field_split_pattern`: string splitting, a regular expression used to extract all key-value pairs; the default value is " "
- `value_split_pattern`: used to split the key and value from the key-value pair string, non-recursive; the default value is "="
- `trim_key`: delete all the specified characters leading and trailing the extracted key; the default value is ""
- `trim_value`: remove all leading and trailing characters from the extracted value; the default value is ""
- `prefix`: add prefix to all keys

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

Function prototype: `fn len(val: str|map|list) int`

Function description: Calculate the number of bytes in string, the number of elements in map and list.

Function parameters:

- `val`: Can be map, list or string

Example:

```python
# example 1
add_key(abc, len("abc"))
# result
{
 "abc": 3,
}

# example 2
add_key(abc, len(["abc"]))
# result
{
  "abc": 1,
}
```


### `load_json()` {#fn-load-json}

Function prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function description: Convert the JSON string to one of map, list, nil, bool, float, and the value can be obtained and modified through the index expression.If deserialization fails, it also returns nil instead of terminating the script run.

Function parameters:

- `val`: Requires data of type string.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key(abc, abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to synchronize the data on the stack to point
add_key(abc, abc["a"]["first"][-1])

add_key(len_abc, len(abc))

add_key(len_abc, len(load_json(abc["a"]["ff"])))
```


### `lowercase()` {#fn-lowercase}

Function prototype: `fn lowercase(key: str)`

Function description: Convert the content of the extracted key to lowercase

Function parameters:

- `key`: Specify the extracted field name to be converted

Example:

```python
# input data: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# script
json(_, first) lowercase(first)

# result
{
    "first": "hello"
}
```


### `match()` {#fn-match}

Function prototype: `fn match(pattern: str, s: str) bool`

Function description: Use the specified regular expression to match the string, return true if the match is successful, otherwise return false

Function parameters:

- `pattern`: regular expression
- `s`: string to match

Example:

```python
# script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key(match_1, match('''\w+\s[,\w]+''', test_1)) 

add_key(match_2, match('''\w+\s[,\w]+''', test_2)) 

# result
{
    "match_1": true,
    "match_2": false
}
```


### `mquery_refer_table()` {#fn-mquery-refer-table}

Function prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function description: Query the external reference table by specifying multiple keys, and append all columns of the first row of the query result to field. This function does not work with central Pipeline.

Function parameters:

- `table_name`: the name of the table to be looked up
- `keys`: a list of multiple column names
- `values`: the values corresponding to each column

Example:

```python
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column, which is added to the data as a field by default
mquery_refer_table(table, values=[value, false], keys=[key, "col4"])

# result

# {
#   "col": "ab",
#   "col2": 1234,
#   "col3": 1235,
#   "col4": false,
#   "key": "col2",
#   "message": "{\"table\": \"table_abc\", \"key\": \"col2\", \"value\": 1234.0}",
#   "status": "unknown",
#   "table": "table_abc",
#   "time": "2022-08-16T16:23:31.940600281+08:00",
#   "value": 1234
# }

```


### `nullif()` {#fn-nullif}

Function prototype: `fn nullif(key, value)`

Function description: If the content of the field specified by the extracted `key` is equal to the value of `value`, delete this field

Function parameters:


- `key`: specified field
- `value`: target value

Example:

```python
# input data: {"first": 1,"second":2,"third":"aBC","forth":true}

# script
json(_, first) json(_, second) nullif(first, "1")

# result
{
    "second":2
}
```

> Note: This feature can be implemented with `if/else` semantics:

```python
if first == "1" {
    drop_key(first)
}
```



### `parse_date()` {#fn-parse-date}

Function prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function description: Convert the value of each part of the incoming date field into a timestamp

Function parameters:

- `key`: newly inserted field
- `yy` : Year numeric string, supports four or two digit strings, if it is an empty string, the current year will be used when processing
- `MM`: month string, supports numbers, English, English abbreviation
- `dd`: day string
- `hh`: hour string
- `mm`: minute string
- `ss`: seconds string
- `ms`: milliseconds string
- `us`: microseconds string
- `ns`: string of nanoseconds
- `zone`: time zone string, in the form of "+8" or \"Asia/Shanghai\"

Example:

```python
parse_date(aa, "2021", "May", "12", "10", "10", "34", "", "Asia/Shanghai") # Result aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "", "Asia/Shanghai") # result aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", "Asia/Shanghai") # Result aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", "", "+8") result aa=1581473434000000000
```


### `parse_duration()` {#fn-parse-duration}

Function prototype: `fn parse_duration(key: str)`

Function description: If the value of `key` is a golang duration string (such as `123ms`), then `key` will be automatically parsed into an integer in nanoseconds

The current duration units in golang are as follows:

- `ns` nanoseconds
- `us/µs` microseconds
- `ms` milliseconds
- `s` seconds
- `m` minutes
- `h` hours

Function parameters:

- `key`: the field to be parsed

Example:

```python
# assume abc = "3.5s"
parse_duration(abc) # result abc = 3500000000

# Support negative numbers: abc = "-3.5s"
parse_duration(abc) # result abc = -3500000000

# support floating point: abc = "-2.3s"
parse_duration(abc) # result abc = -2300000000
```


### `parse_int()` {#fn-parse-int}

Function prototype: `fn parse_int(val: int, base: int) str`

Function description: Converts the string representation of a numeric value to a numeric value.

Function parameters:

- `val`: The string to be converted.
- `base`: Base, the range is 0, or 2 to 36; when the value is 0, the base is judged according to the string prefix.

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

Function prototype: `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

Function description: Record the discarded data and use it with the `window_hit` function to upload the discarded context `Point` data.

Function parameters:

- `before`: The maximum number of points that can be temporarily stored before the function `window_hit`  is executed, and the data that has not been discarded is included in the count.
- `after`: The number of points retained after the `window_hit` function is executed, and the data that has not been discarded is included in the count.
- `stream_tags`: Differentiate log (metrics, tracing, etc.) streams by labels on the data, the default number using `filepath` and `host` can be used to distinguish logs from the same file.

Example:

```python
# It is recommended to place it in the first line of the script
#
point_window(8, 8)

# If it is a panic log, keep the first 8 entries 
# and the last 8 entries (including the current one)
#
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if point_window() is executed during this run.
    # Trigger data recovery behavior within the window
    #
    window_hit()
}

# By default, all logs whose service is test_app are discarded;
# If it contains panic logs, keep the 15 adjacent ones and the current one.
#
if service == "test_app" {
    drop()
}
```


### `pt_name()` {#fn-pt-name}

Function prototype: `fn pt_name(name: str = "") -> str`

Function description: Get the name of point; if the parameter is not empty, set the new name.

Function parameters:

- `name`: Value as point name; defaults to empty string.

The field mapping relationship between point name and various types of data storage:

| category      | field name |
| ------------- | ---------- |
| custom_object | class      |
| keyevent      | -          |
| logging       | source     |
| metric        | -          |
| network       | source     |
| object        | class      |
| profiling     | source     |
| rum           | source     |
| security      | rule       |
| tracing       | source     |


### `query_refer_table()` {#fn-query-refer-table}

Function prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function description: Query the external reference table through the specified key, and append all the columns of the first row of the query result to field. This function does not work with central Pipeline.

Function parameters:

- `table_name`: the name of the table to be looked up
- `key`: column name
- `value`: the value corresponding to the column

Example:

```python
# extract table name, column name, column value from input
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column, which is added to the data as a field by default
query_refer_table(table, key, value)

```

Result:

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

Function description: Rename the extracted fields

Function parameters:

- `new_key`: new field name
- `old_key`: the extracted field name

Example:

```python
# Rename the extracted abc field to abc1
rename('abc1', abc)

# or

rename(abc1, abc)
```

```python
# Data to be processed: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# process script
json(_, info.name, "name")

# process result
{
   "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
   "zhangsan": {
     "age": 17,
     "height": 180,
     "Name": "zhangsan"
   }
}
```


### `replace()` {#fn-replace}

Function prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function description: Replace the string data obtained on the specified field according to regular rules

Function parameters:

- `key`: the field to be extracted
- `regex`: regular expression
- `replace_str`: string to replace

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

# Chinese name {"str_abc": "Little Aka"}
json(_, str_abc)
replace(str_abc, '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```


### `sample()` {#fn-sample}

Function prototype: `fn sample(p)`

Function description: Choose to collect/discard data with probability p.

Function parameters:

- `p`: the probability that the sample function returns true, the value range is [0, 1]

Example:

```python
# process script
if !sample(0.3) { # sample(0.3) indicates that the sampling rate is 30%, that is, it returns true with a 30% probability, and 70% of the data will be discarded here
   drop() # mark the data to be discarded
   exit() # Exit the follow-up processing process
}
```


### `set_measurement()` {#fn-set-measurement}

Function prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function description: change the name of the line protocol

Function parameters:

- `name`: The value is used as the measurement name, which can be passed in as a string constant or variable
- `delete_key`: If there is a tag or field with the same name as the variable in point, delete it

The field mapping relationship between row protocol name and various types of data storage or other purposes:

| category      | field name | other usage     |
| -             | -          | -               |
| custom_object | class      | -               |
| keyevent      | -          | -               |
| logging       | source     | -               |
| metric        | -          | metric set name |
| network       | source     | -               |
| object        | class      | -               |
| profiling     | source     | -               |
| rum           | source     | -               |
| security      | rule       | -               |
| tracing       | source     | -               |


### `set_tag()` {#fn-set-tag}

Function prototype: `fn set_tag(key, value: str)`

Function description: mark the specified field as tag output, after setting as tag, other functions can still operate on the variable. If the key set as a tag is a field that has been cut out, it will not appear in the field, so as to avoid the same name of the cut out field key as the tag key on the existing data

Function parameters:

- `key`: the field to be tagged
- `value`: can be a string literal or a variable

```python
# in << {"str": "13789123014"}
set_tag(str)
json(_, str) # str == "13789123014"
replace(str, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
# "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
# "str#": "137****3014"
# }
# * The character `#` is only the tag whose field is tag when datakit --pl <path> --txt <str> output display

# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
set_tag(str_a, "3") # str_a == 3
# Extracted data(drop: false, cost: 30.069µs):
# {
# "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
# "str_a#": "3"
# }


# in << {"str_a": "2", "str_b": "3"}
json(_, str_a)
json(_, str_b)
set_tag(str_a, str_b) # str_a == str_b == "3"
# Extracted data(drop: false, cost: 32.903µs):
# {
# "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
# "str_a#": "3",
# "str_b": "3"
# }
```


### `sql_cover()` {#fn-sql-cover}

Function prototype: `fn sql_cover(sql_test: str)`

Function description: desensitized SQL statement

Example:

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
# "message": "select abc from def where x > ? and y < ?"
# }
```


### `strfmt()` {#fn-strfmt}

Function prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Function description: Format the content of the field specified by the extracted `arg1, arg2, ...` according to `fmt`, and write the formatted content into the `key` field

Function parameters:

- `key`: Specify the field name of the formatted data to be written
- `fmt`: format string template
- `args`: Variable Function parameters:, which can be multiple extracted field names to be formatted

Example:

```python
# Data to be processed: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# process script
json(_, a.second)
json(_, a.thrid)
cast(a. second, "int")
json(_, a.forth)
strfmt(bb, "%v %s %v", a.second, a.thrid, a.forth)
```


### `timestamp()` {#fn-timestamp}

Function prototype: `fn timestamp(precision: str = "ns") -> int`

Function description: 返回当前 Unix 时间戳，默认精度为 ns

Function parameters:

- `precision`: 时间戳精度，取值范围为 "ns", "us", "ns", "s", 默认值 "ns"。

Example:


```python
# process script
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# process result
{
  "time_now_record": "2023-03-07 10:41:12"
}

```


```python
# process script
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# process result
{
  "time_now_record": "2023-03-07 18:41:49"
}
```


```python
# process script
add_key(time_now_record, timestamp("ms"))


# process result
{
  "time_now_record": 1678185980578
}
```


### `trim()` {#fn-trim}

Function prototype: `fn trim(key, cutset: str = "")`

Function description: delete the characters specified at the beginning and end of the key, and delete all blank characters by default when the `cutset` is an empty string

Function parameters:

- `key`: a field that has been extracted, string type
- `cutset`: Delete the first and last characters in the `cutset` string in the key

Example:

```python
# Data to be processed: "trim(key, cutset)"

# process script
add_key(test_data, "ACCAA_test_DataA_ACBA")
trim(test_data, "ABC_")

# process result
{
   "test_data": "test_Data"
}
```


### `uppercase()` {#fn-uppercase}

Function prototype: `fn uppercase(key: str)`

Function description: Convert the content in the extracted key to uppercase

Function parameters:

- `key`: Specify the extracted field name to be converted, and convert the content of `key` to uppercase

Example:

```python
# Data to be processed: {"first": "hello","second":2,"third":"aBC","forth":true}

# process script
json(_, first) uppercase(first)

# process result
{
    "first": "HELLO"
}
```


### `url_decode()` {#fn-url-decode}

Function prototype: `fn url_decode(key: str)`

Function description: parse the URL in the extracted `key` into plain text

Function parameters:

- `key`: a `key` that has been extracted

Example:

```python
# Data to be processed: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# process script
json(_, url) url_decode(url)

# process result
{
   "message": "{"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
   "url": "http://www.baidu.com/s?wd=test"
}
```


### `url_parse()` {#fn-url-parse}

Function prototype: `fn url_parse(key)`

Function description: parse the url whose field name is key.

Function parameters:

- `key`: field name of the url to parse.

Example:

```python
# Data to be processed: {"url": "https://www.baidu.com"}

# process script
json(_, url)
m = url_parse(url)
add_key(scheme, m["scheme"])

# process result
{
     "url": "https://www.baidu.com",
     "scheme": "https"
}
```

The above example extracts its scheme from the url. In addition, it can also extract information such as host, port, path, and Function parameters: carried in the url from the url, as shown in the following example:

```python
# Data to be processed: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# process script
json(_, url)
m = url_parse(url)
add_key(sclient, m["params"]["sclient"]) # The Function parameters: carried in the url are saved under the params field
add_key(h, m["host"])
add_key(path, m["path"])

# process result
{
     "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
     "h": "www.google.com",
     "path": "/search",
     "sclient": "gws-wiz"
}
```


### `use()` {#fn-use}

Function prototype: `fn use(name: str)`

Parameter:

- `name`: script name, such as abp.p

Function description: call other scripts, all current data can be accessed in the called script

Example:

```python
# Data to be processed: {"ip":"1.2.3.4"}

# Process script a.p
use(\"b.p\")

# Process script b.p
json(_, ip)
geoip (ip)

# Execute the processing result of script a.p
{
   "city" : "Brisbane",
   "country" : "AU",
   "ip" : "1.2.3.4",
   "province" : "Queensland",
   "isp" : "unknown"
   "message" : "{\"ip\": \"1.2.3.4\"}",
}
```


### `user_agent()` {#fn-user-agent}

Function prototype: `fn user_agent(key: str)`

Function description: Obtain client information on the specified field

Function parameters:

- `key`: the field to be extracted

`user_agent()` will generate multiple fields, such as:

- `os`: operating system
- `browser`: browser

Example:

```python
# data to be processed
# {
# "userAgent" : "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
# "second" : 2,
# "third" : "abc",
# "forth" : true
# }

json(_, userAgent) user_agent(userAgent)
```


### `valid_json()` {#fn-valid-json}

Function prototype: `fn valid_json(val: str) bool`

Function description: Determine if it is a valid JSON string.

Function parameters:

- `val`: Requires data of type string.

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

Function description: Obtain the type of the variable's value and return the value range ["int", "float", "bool", "str", "list", "map", "]. If the value is nil, return an empty string.

Function parameters:

- `val`: The value of the type to be determined.

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

Function prototype: `fn window_hit()`

Function description: Trigger the recovery event of the context discarded data, and recover from the data recorded by the `point_window` function。

Function parameters: None

Example:

```python
# It is recommended to place it in the first line of the script
#
point_window(8, 8)

# If it is a panic log, keep the first 8 entries 
# and the last 8 entries (including the current one)
#
if grok(_, "abc.go:25 panic: xxxxxx") {
    # This function will only take effect if point_window() is executed during this run.
    # Trigger data recovery behavior within the window
    #
    window_hit()
}

# By default, all logs whose service is test_app are discarded;
# If it contains panic logs, keep the 15 adjacent ones and the current one.
#
if service == "test_app" {
    drop()
}
```


### `xml()` {#fn-xml}

Function prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function description: Extract fields from XML through xpath expressions.

Function parameters:

- input: XML to extract
- xpath_expr: xpath expression
- key_name: The extracted data is written to a new key

Example one:

```python
# data to be processed
        <entry>
         <fieldx>valuex</fieldx>
         <fieldy>...</fieldy>
         <fieldz>...</fieldz>
         <field array>
             <fielda>element_a_1</fielda>
             <fielda>element_a_2</fielda>
         </fieldarray>
     </entry>

# process script
xml(_, '/entry/fieldarray//fielda[1]/text()', field_a_1)

# process result
{
   "field_a_1": "element_a_1", # extracted element_a_1
   "message": "\t\t\u003centry\u003e\n \u003cfieldx\u003evaluex\u003c/fieldx\u003e\n \u003cfieldy\u003e...\u003c/fieldy\u003e\n \u003cfieldz\u003e...\ u003c/fieldz\u003e\n \u003cfieldarray\u003e\n \u003cfielda\u003eelement_a_1\u003c/fielda\u003e\n \u003cfielda\u003eelement_a_2\u003c/fielda\u003e\n \u003c/fieldarray\n\c\u003 u003e",
   "status": "unknown",
   "time": 1655522989104916000
}
```

Example two:

```python
# data to be processed
<OrderEvent actionCode = "5">
  <OrderNumber>ORD12345</OrderNumber>
  <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# process script
xml(_, '/OrderEvent/@actionCode', action_code)
xml(_, '/OrderEvent/OrderNumber/text()', OrderNumber)

# process result
{
   "OrderNumber": "ORD12345",
   "action_code": "5",
   "message": "\u003cOrderEvent actionCode = \"5\"\u003e\n \u003cOrderNumber\u003eORD12345\u003c/OrderNumber\u003e\n \u003cVendorNumber\u003eV11111\u003c/VendorNumber\n\u003e\u003e"
   "status": "unknown",
   "time": 1655523193632471000
}
```



