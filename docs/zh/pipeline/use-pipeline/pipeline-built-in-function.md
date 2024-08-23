# 内置函数 {#functions}
---

函数参数说明：

- 函数参数中，匿名参数（`_`）指原始的输入文本数据
- JSON 路径，直接表示成 `x.y.z` 这种形式，无需其它修饰。例如 `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`，json 路径为 `a.thrid` 表示待操作数据为 `abc`
- 所有函数参数的相对顺序，都是固定的，引擎会对其做具体检查
- 以下提到的所有 `key` 参数，都指已经过初次提取（通过 `grok()` 或 `json()`）之后，生成的 `key`
- 待处理 JSON 的路径，支持标识符的写法，不能使用字符串，如果是生成新 key，需要使用字符串


## 函数列表 {#function-list}

### `add_key()` {#fn-add-key}

函数原型：`fn add_key(key, value)`

函数说明：往 point 中增加一个字段

函数参数：

- `key`: 新增的 key 名称
- `value`：作为 key 的值

示例：

```python
# 待处理数据：{"age": 17, "name": "zhangsan", "height": 180}

# 处理脚本
add_key(city, "shanghai")

# 处理结果
{
    "age": 17,
    "height": 180,
    "name": "zhangsan",
    "city": "shanghai"
}
```


### `add_pattern()` {#fn-add-pattern}

函数原型：`fn add_pattern(name: str, pattern: str)`

函数说明：创建自定义 grok 模式。grok 模式有作用域限制，如在 if else 语句内将产生新的作用域，该 pattern 仅在此作用域内有效。该函数不可覆盖同一作用域或者上一作用域已经存在的 grok 模式

参数：

- `name`：模式命名
- `pattern`: 自定义模式内容

示例：

```python
# 待处理数据："11,abc,end1", "22,abc,end1", "33,abc,end3"

# pipline 脚本
add_pattern("aa", "\\d{2}")
grok(_, "%{aa:aa}")
if false {

} else {
    add_pattern("bb", "[a-z]{3}")
    if aa == "11" {
        add_pattern("cc", "end1")
        grok(_, "%{aa:aa},%{bb:bb},%{cc:cc}")
    } elif aa == "22" {
        # 此处使用 pattern cc 将导致编译失败：no pattern found for %{cc}
        grok(_, "%{aa:aa},%{bb:bb},%{INT:cc}")
    } elif aa == "33" {
        add_pattern("bb", "[\\d]{5}") # 此处覆盖 bb 失败
        add_pattern("cc", "end3")
        grok(_, "%{aa:aa},%{bb:bb},%{cc:cc}")
    }
}

# 处理结果
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

函数原型：`fn adjust_timezone(key: int, minute: int)`

函数参数：

- `key`: 纳秒时间戳，如 `default_time(time)` 函数处理后得到的时间戳
- `minute`: 返回值允许超出当前时间的分钟数（整数），取值范围 [0, 15], 默认值为 2 分钟

函数说明：使得传入的时间戳减去函数执行时刻的时间戳的差值在（-60+minute, minute] 分钟内；不适用于时间差超出此范围的数据，否则将导致获取到错误的数据。计算流程：

1. 为 key 的值加上数小时使其处于当前小时内
2. 此时计算两者分钟差，两者分钟数值范围为 [0, 60)，差值范围在 (-60,0] 和 [0, 60)
3. 差值小于等于 -60 + minute 的加 1 小时，大于 minute 的减 1 小时
4. minute 默认值为 2，则差的范围允许在 (-58, 2]，若此时为 11:10，日志时间为 3:12:00.001，最终结果为 10:12:00.001；若此时为 11:59:1.000, 日志时间为 3:01:1.000，最终结果为 12:01:1.000

示例：

```json
# 输入 1 
{
    "time":"11 Jul 2022 12:49:20.937", 
    "second":2,
    "third":"abc",
    "forth":true
}
```

脚本：

```python
json(_, time)      # 提取 time 字段 (若容器中时区 UTC+0000)
default_time(time) # 将提取到的 time 字段转换成时间戳
                   # (对无时区数据使用本地时区 UTC+0800/UTC+0900..。解析)
adjust_timezone(time)
                   # 自动(重新)选择时区，校准时间偏差
```

执行 `datakit pipeline -P <name>.p -F <input_file_name>  --date`:

```json
# 输出 1
{
  "message": "{\n    \"time\":\"11 Jul 2022 12:49:20.937\",\n    \"second\":2,\n    \"third\":\"abc\",\n    \"forth\":true\n}",
  "status": "unknown",
  "time": "2022-07-11T20:49:20.937+08:00"
}
```

本机时间：`2022-07-11T20:55:10.521+08:00`

仅使用 `default_time` 按照默认本机时区（UTC+8）解析得到的时间分别为：

- 输入 1 结果： `2022-07-11T12:49:20.937+08:00`

使用 `adjust_timezone` 后将得到：

- 输入 1 结果： `2022-07-11T20:49:20.937+08:00`


### `agg_create()` {#fn-agg-create}

函数原型：`fn agg_create(bucket: str, on_interval: str = "60s", on_count: int = 0, keep_value: bool = false, const_tags: map[string]string = nil, category: str = "M")`

函数说明：创建一个用于聚合的指标集，通过 `on_interval` 或 `on_count` 设置时间或次数作为聚合周期，聚合结束后将上传聚合数据，可以选择是否保留上一次聚合的数据；该函数不适用于中心 Pipeline。

函数参数：

- `bucket`: 字符串类型，作为聚合出的指标的指标集名，如果该 bucket 已经创建，则函数不执行任何操作。
- `on_interval`：默认值 `60s`, 以时间作为聚合周期，单位 `s`，值大于 `0` 时参数生效；不能同时与 `on_count` 小于等于 0。
- `on_count`: 默认值 `0`，以处理的点数作为聚合周期，值大于 `0` 时参数生效。
- `keep_value`: 默认值 `false`。
- `const_tags`: 自定义的 tags，默认为空。
- `category`: 聚合数据的数据类别，可选参数，默认值为 "M"，表示指标类别数据。

示例：

```python
agg_create("cpu_agg_info", on_interval = "30s")
```


### `agg_metric()` {#fn-agg-metric}

函数原型：`fn agg_metric(bucket: str, new_field: str, agg_fn: str, agg_by: []string, agg_field: str, category: str = "M")`

函数说明：根据输入的数据中的字段的名，自动取值后作为聚合数据的 tag，并将这些聚合数据存储在对应的 bucket 中；该函数不适用于中心 Pipeline。

函数参数：

- `bucket`: 字符串类型，函数 `agg_create` 创建出的对应指标集合的 bucket，如果该 bucket 未被创建，则函数不执行任何操作。
- `new_field`： 聚合出的数据中的指标名，其值的数据类型为 `float`。
- `agg_fn`: 聚合函数，可以是 `"avg"`,`"sum"`,`"min"`,`"max"`,`"set"` 中的一种。
- `agg_by`: 输入的数据中的字段的名，将作为聚合出的数据的 tag，这些字段的值只能是字符串类型的数据。
- `agg_field`: 输入的数据中的字段名，自动获取字段值进行聚合。
- `category`: 聚合数据的数据类别，可选参数，默认值为 "M"，表示指标类别数据。

示例：

以日志类别数据为例：

连续多个输入：

- 样本日志一： `{"a": 1}`
- 样本日志二： `{"a": 2}`

脚本：

```python
agg_create("cpu_agg_info", on_interval="10s", const_tags={"tag1":"value_user_define_tag"})

set_tag("tag1", "value1")

field1 = load_json(_)

field1 = field1["a"]

agg_metric("cpu_agg_info", "agg_field_1", "sum", ["tag1", "host"], "field1")
```

指标输出：

```json
{
    "host": "your_hostname",
    "tag1": "value1",
    "agg_field_1": 3
}
```


### `append()` {#fn-append}

函数原型：`fn append(arr, elem) arr`

函数说明：往数组 arr 末尾添加元素 elem。

参数：

- `arr`: 要添加元素的数组。
- `elem`: 添加的元素。

示例：

```python
# 例 1
abc = ["1", "2"]
abc = append(abc, 5.1)
# abc = ["1", "2", 5.1]

# 例 2
a = [1, 2]
b = [3, 4]
c = append(a, b)
# c = [1, 2, [3, 4]]
```


### `b64dec()` {#fn-b64dec}

函数原型：`fn b64dec(key: str)`

函数说明：对指定字段上获取的字符串数据进行 base64 解码

函数参数：

- `key`: 待提取字段

示例：

```python
# 待处理数据 {"str": "aGVsbG8sIHdvcmxk"}
json(_, `str`)
b64enc(`str`)

# 处理结果
# {
#   "str": "hello, world"
# }
```


### `b64enc()` {#fn-b64enc}

函数原型：`fn b64enc(key: str)`

函数说明：对指定字段上获取的字符串数据进行 base64 编码

函数参数：

- `key`: 待提取字段

示例：

```python
# 待处理数据 {"str": "hello, world"}
json(_, `str`)
b64enc(`str`)

# 处理结果
# {
#   "str": "aGVsbG8sIHdvcmxk"
# }
```


### `cache_get()` {#fn-cache-get}

函数原型：`fn cache_get(key: str) nil|str`

函数说明：从 cache 中获取 key 所对应的 value

参数：

- `key`：键

示例：

```python
a = cache_get("a")
add_key(abc, a)
```


### `cache_set()` {#fn-cache-set}

函数原型：`fn cache_set(key: str, value: str, expiration: int) nil`

函数说明：将键值对保存到 cache 中

参数：

- `key`：键（必填）
- `value`：值（必填）
- `expiration`：过期时间（默认=100s）

示例：

```python
a = cache_set("a", "123")
a = cache_get("a")
add_key(abc, a)
```


### `cast()` {#fn-cast}

函数原型：`fn cast(key, dst_type: str)`

函数说明：将 key 值转换成指定类型

函数参数：

- `key`: 已提取的某字段
- `type`：转换的目标类型，支持 `\"str\", \"float\", \"int\", \"bool\"` 这几种，目标类型需要用英文状态双引号括起来

示例：

```python
# 待处理数据：{"first": 1,"second":2,"third":"aBC","forth":true}

# 处理脚本
json(_, first) 
cast(first, "str")

# 处理结果
{
  "first": "1"
}
```


### `cidr()` {#fn-cidr}

函数原型：`fn cidr(ip: str, prefix: str) bool`

函数说明： 判断 IP 是否在某个 CIDR 块

函数参数：

- `ip`: IP 地址
- `prefix`： IP 前缀，如 `192.0.2.1/24`

示例：

```python
# 待处理数据：

# 处理脚本

ip = "192.0.2.233"
if cidr(ip, "192.0.2.1/24") {
    add_key(ip_prefix, "192.0.2.1/24")
}

# 处理结果
{
  "ip_prefix": "192.0.2.1/24"
}
```


### `conv_traceid_w3c_to_dd()`  {#fn-conv-traceid-w3c-to-dd}

函数原型：`fn conv_traceid_w3c_to_dd(key)`

函数说明：将 16 进制编码的 128-bit/64-bit  W3C Trace ID 字符串（长度 32 个字符或 16 个字符）转换为 10 进制编码的 64-bit DataDog Trace ID 字符串。

函数参数：

- `key`: 待转换的 128-bit/64-bit Trace ID

示例：

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

函数原型：`fn cover(key: str, range: list)`

函数说明：对指定字段上获取的字符串数据，按范围进行数据脱敏处理

函数参数：

- `key`: 待提取字段
- `range`: 脱敏字符串的索引范围（`[start,end]`） start 和 end 均支持负数下标，用来表达从尾部往前追溯的语义。区间合理即可，end 如果大于字符串最大长度会默认成最大长度

示例：

```python
# 待处理数据 {"str": "13789123014"}
json(_, `str`)
cover(`str`, [8, 9])

# 待处理数据 {"abc": "13789123014"}
json(_, abc)
cover(abc, [2, 4])
```


### `create_point()` {#fn-create-point}

函数原型：`fn create_point(name, tags, fields, ts = 0, category = "M", after_use = "")`

函数说明：创建新的数据并输出。该函数不适用于中心 Pipeline。

函数参数：

- `name`: point name，视为指标集的名、日志 source 等
- `tags`: 数据标签
- `fields`:  数据字段
- `ts`:   可选参数，unix 纳秒时间戳，默认为当前时间
- `category`: 可选参数，数据类别，支持类别名称和名称简写，如指标类别可以填写 `M` 或 `metric`，日志则是 `L` 或 `logging`
- `after_use`: 可选参数，创建 point 后，对创建的 point 执行指定的 pl 脚本；如果原始数据类型是 L，被创建的数据的类别为 M，此时执行的还是 L 类别下的脚本


示例：

```py
# input
'''
{"a": "b"}
'''
fields = load_json(_)
create_point("name_pt", {"a": "b"}, fields)
```


### `datetime()` {#fn-datetime}

函数原型：`fn datetime(key, precision: str, fmt: str, tz: str = "")`

函数说明：将时间戳转成指定日期格式

函数参数：

- `key`: 已经提取的时间戳
- `precision`：输入的时间戳精度(s, ms, us, ns)
- `fmt`：日期格式，提供内置日期格式且支持自定义日期格式
- `tz`: 时区 (可选参数)，将时间戳转换为指定时区的时间，默认使用主机的时区

内置日期格式：

| 内置格式      | 日期                                  | 描述                      |
| ---           | ---                                   | ---                       |
| "ANSI-C"      | "Mon Jan _2 15:04:05 2006"            |                           |
| "UnixDate"    | "Mon Jan _2 15:04:05 MST 2006"        |                           |
| "RubyDate"    | "Mon Jan 02 15:04:05 -0700 2006"      |                           |
| "RFC822"      | "02 Jan 06 15:04 MST"                 |                           |
| "RFC822Z"     | "02 Jan 06 15:04 -0700"               | RFC822 with numeric zone  |
| "RFC850"      | "Monday, 02-Jan-06 15:04:05 MST"      |                           |
| "RFC1123"     | "Mon, 02 Jan 2006 15:04:05 MST"       |                           |
| "RFC1123Z"    | "Mon, 02 Jan 2006 15:04:05 -0700"     | RFC1123 with numeric zone |
| "RFC3339"     | "2006-01-02T15:04:05Z07:00"           |                           |
| "RFC3339Nano" | "2006-01-02T15:04:05.999999999Z07:00" |                           |
| "Kitchen"     | "3:04PM"                              |                           |

自定义日期格式：

可通过占位符的组合自定义输出日期格式

| 字符  | 示例 | 描述                                                          |
| ---   | ---  | ---                                                           |
| a     | %a   | 星期的缩写，如 `Wed`                                          |
| A     | %A   | 星期的全写，如 `Wednesday`                                    |
| b     | %b   | 月份缩写，如 `Mar`                                            |
| B     | %B   | 月份的全写，如 `March`                                        |
| C     | %c   | 世纪数，当前年份除 100                                        |
| **d** | %d   | 一个月内的第几天；范围 `[01, 31]`                             |
| e     | %e   | 一个月内的第几天；范围 `[1, 31]`，使用空格填充                |
| **H** | %H   | 小时，使用 24 小时制； 范围 `[00, 23]`                        |
| I     | %I   | 小时，使用 12 小时制； 范围 `[01, 12]`                        |
| j     | %j   | 一年内的第几天，范围 `[001, 365]`                             |
| k     | %k   | 小时，使用 24 小时制； 范围 `[0, 23]`                         |
| l     | %l   | 小时，使用 12 小时制； 范围 `[1, 12]`，使用空格填充           |
| **m** | %m   | 月份，范围 `[01, 12]`                                         |
| **M** | %M   | 分钟，范围 `[00, 59]`                                         |
| n     | %n   | 表示换行符 `\n`                                               |
| p     | %p   | `AM` 或 `PM`                                                  |
| P     | %P   | `am` 或 `pm`                                                  |
| s     | %s   | 自 1970-01-01 00:00:00 UTC 来的的秒数                         |
| **S** | %S   | 秒数，范围 `[00, 60]`                                         |
| t     | %t   | 表示制表符 `\t`                                               |
| u     | %u   | 星期几，星期一为 1，范围 `[1, 7]`                             |
| w     | %w   | 星期几，星期天为 0, 范围 `[0, 6]`                             |
| y     | %y   | 年份，范围 `[00, 99]`                                         |
| **Y** | %Y   | 年份的十进制表示                                              |
| **z** | %z   | RFC 822/ISO 8601:1988 风格的时区 (如： `-0600` 或 `+0100` 等) |
| Z     | %Z   | 时区缩写，如 `CST`                                            |
| %     | %%   | 表示字符 `%`                                                  |

示例：

```python
# 待处理数据：
#    {
#        "a":{
#            "timestamp": "1610960605000",
#            "second":2
#        },
#        "age":47
#    }

# 处理脚本
json(_, a.timestamp)
datetime(a.timestamp, 'ms', 'RFC3339')
```

```python
# 处理脚本
ts = timestamp()
datetime(ts, 'ns', fmt='%Y-%m-%d %H:%M:%S', tz="UTC")

# 输出
{
  "ts": "2023-03-08 06:43:39"
}
```

```python
# 处理脚本
ts = timestamp()
datetime(ts, 'ns', '%m/%d/%y  %H:%M:%S %z', "Asia/Tokyo")

# 输出
{
  "ts": "03/08/23  15:44:59 +0900"
}
```


### `decode()` {#fn-decode}

函数原型：`fn decode(text: str, text_encode: str)`

函数说明：把 text 变成 UTF8 编码，以处理原始日志为非 UTF8 编码的问题。目前支持的编码为 utf-16le/utf-16be/gbk/gb18030（这些编码名只能小写）

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```


### `default_time()` {#fn-defalt-time}

函数原型：`fn default_time(key: str, timezone: str = "")`

函数说明：以提取的某个字段作为最终数据的时间戳

函数参数：

- `key`: 指定的 key， key 的数据类型需要为字符串类型
- `timezone`: 指定待格式化的时间文本所使用的时区，可选参数，默认为当前系统时区，时区示例 `+8/-8/+8:30`

待处理数据支持以下格式化时间

<!-- markdownlint-disable MD038 -->
| 日期格式                                           | 日期格式                                                | 日期格式                                       | 日期格式                          |
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
| `20140722105203`                                   | `2014 年 04 月 08 日`                                  | `1332151919`                                   | `2006-01-02T15:04:05+0000`        |
| `1384216367189`                                    | `2009-08-12T22:15:09-07:00`                             | `1384216367111222`                             | `2009-08-12T22:15:09`             |
| `1384216367111222333`                              | `2009-08-12T22:15:09Z`                                  |
<!-- markdownlint-enable -->

JSON 提取示例：

```python
# 原始 json
{
    "time":"06/Jan/2017:16:16:37 +0000",
    "second":2,
    "third":"abc",
    "forth":true
}

# pipeline 脚本
json(_, time)      # 提取 time 字段
default_time(time) # 将提取到的 time 字段转换成时间戳

# 处理结果
{
  "time": 1483719397000000000,
}
```

文本提取示例：

```python
# 原始日志文本
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms

# pipeline 脚本
grok(_, '%{TIMESTAMP_ISO8601:log_time}')   # 提取日志时间，并将字段命名为 log_time
default_time(log_time)                     # 将提取到的 log_time 字段转换成时间戳

# 处理结果
{
  "log_time": 1610358231887000000,
}

# 对于 logging 采集的数据，最好将时间字段命名为 time，否则 logging 采集器会以当前时间填充
rename("time", log_time)

# 处理结果
{
  "time": 1610358231887000000,
}
```



### `delete()` {#fn-delete}

函数原型：`fn delete(src: map[string]any, key: str)`

函数说明： 删除 JSON map 中的 key

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

函数原型：`fn drop()`

函数说明：丢弃整条日志，不进行上传

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

函数原型：`fn drop_key(key)`

函数说明：删除已提取字段

函数参数：

- `key`: 待删除字段名

示例：

```python
# data = "{\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}"

# 处理脚本
json(_, age,)
json(_, name)
json(_, height)
drop_key(height)

# 处理结果
{
    "age": 17,
    "name": "zhangsan"
}
```



### `drop_origin_data()` {#fn-drop-origin-data}

函数原型：`fn drop_origin_data()`

函数说明：丢弃初始化文本，否则初始文本放在 message 字段中

示例：

```python
# 待处理数据：{"age": 17, "name": "zhangsan", "height": 180}

# 结果集中删除 message 内容
drop_origin_data()
```



### `duration_precision()` {#fn-duration-precision}

函数原型：`fn duration_precision(key, old_precision: str, new_precision: str)`

函数说明：进行 duration 精度的转换，通过参数指定当前精度和目标精度。支持在 s, ms, us, ns 间转换。

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

函数原型：`fn exit()`

函数说明：结束当前一条日志的解析，若未调用函数 drop() 仍会输出已经解析的部分

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

函数原型：`fn format_int(val: int, base: int) str`

函数说明：将数值转换为指定进制的数值字符串。

参数：

- `val`: 待转换的整数
- `base`: 进制，范围 2 到 36；进制大于 10 时使用小写字母 a 到 z 表示 10 及以后的数值。

示例：

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

函数原型：`fn geoip(ip: str)`

函数说明：在 IP 上追加更多 IP 信息。 `geoip()` 会额外产生多个字段，如：

- `isp`: 运营商
- `city`: 城市
- `province`: 省份
- `country`: 国家

参数：

- `ip`: 已经提取出来的 IP 字段，支持 IPv4 和 IPv6

示例：

```python
# 待处理数据：{"ip":"1.2.3.4"}

# 处理脚本
json(_, ip)
geoip(ip)

# 处理结果
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

函数原型：`fn get_key(key)`

函数说明：从输入 point 中读取 key 的值，而不是堆栈上的变量的值

函数参数：

- `key_name`: key 的名称

示例：

```python
add_key("city", "shanghai")

# 此处可以直接通过 city 访问获取 point 中的同名 key 的值
if city == "shanghai" {
  add_key("city_1", city)
}

# 由于赋值的右结合性，先获取 key 为 "city" 的值，
# 而后创建名为 city 的变量
city = city + " --- ningbo" + " --- " +
    "hangzhou" + " --- suzhou ---" + ""

# get_key 从 point 中获取 "city" 的值
# 存在名为 city 的变量，则无法直接从 point 中获取
if city != get_key("city") {
  add_key("city_2", city)
}

# 处理结果
"""
{
  "city": "shanghai",
  "city_1": "shanghai",
  "city_2": "shanghai --- ningbo --- hangzhou --- suzhou ---"
}
"""
```


### `gjson()` {#fn-gjson}

函数原型：`fn gjson(input, json_path: str, newkey: str)`

函数说明：提取 JSON 中的指定字段，可将其命名成新的字段，并保证按原始顺序排列

参数：

- `input`: 待提取 JSON，可以是原始文本（`_`）或经过初次提取之后的某个 `key`
- `json_path`: JSON 路径信息
- `newkey`：提取后数据写入新 key

```python
# 直接提取原始输入 JSON 中的 x.y 字段，并可将其命名成新字段 abc
gjson(_, "x.y", "abc")

# 已提取出的某个 `key`，对其再提取一次 `x.y`，提取后字段名为 `x.y`
gjson(key, "x.y") 

# 提取数组，`key` 和 `abc` 均为数组类型
gjson(key, "1.abc.2")
```

示例一：

```python
# 待处理数据：
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# 处理脚本：
gjson(_, "info", "zhangsan")
gjson(zhangsan, "name")
gjson(zhangsan, "age", "age")

# 处理结果：
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

示例二：

```python
# 待处理数据：
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

# 处理脚本：
gjson(_, "name")
gjson(name, "first")
```

示例三：

```python
# 待处理数据：
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# 处理脚本，json 数组处理：
gjson(_, "0.nets.1")
```

### `grok()` {#fn-grok}

函数原型：`fn grok(input: str, pattern: str, trim_space: bool = true) bool`

函数说明：通过 `pattern` 提取文本串 `input` 中的内容，当 pattern 匹配 input 成功时返回 true 否则返回 false。

参数：

- `input`：待提取文本，可以是原始文本（`_`）或经过初次提取之后的某个 `key`
- `pattern`: grok 表达式，表达式中支持指定 key 的数据类型：bool, float, int, string(对应 ppl 的 str，亦可写为 str)，默认为 string
- `trim_space`: 删除提取出的字符中的空白首尾字符，默认值为 true

```python
grok(_, pattern)    # 直接使用输入的文本作为原始数据
grok(key, pattern)  # 对之前已经提取出来的某个 key，做再次 grok
```

示例：

```python
# 待处理数据："12/01/2021 21:13:14.123"

# pipline 脚本
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key(grok_match_ok)

# 处理结果
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

函数原型：`fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

函数说明：如果 `key` 值在指定范围 `between` 内（注意：只能是单个区间，如 `[0,100]`），则可创建一个新字段，并赋予新值。若不提供新字段，则覆盖原字段值

示例一：

```python
# 待处理数据：{"http_status": 200, "code": "success"}

json(_, http_status)

# 如果字段 http_status 值在指定范围内，则将其值改为 "OK"
group_between(http_status, [200, 300], "OK")

# 处理结果
{
    "http_status": "OK"
}
```

示例二：

```python
# 待处理数据：{"http_status": 200, "code": "success"}

json(_, http_status)

# 如果字段 http_status 值在指定范围内，则新建 status 字段，其值为 "OK"
group_between(http_status, [200, 300], "OK", status)

# 处理结果
{
    "http_status": 200,
    "status": "OK"
}
```


### `group_in()` {#fn-group-in}

函数原型：`fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new-key = "")`

函数说明：如果 `key` 值在列表 `in` 中，则可创建一个新字段，并赋予新值。若不提供新字段，则覆盖原字段值

示例：

```python
# 如果字段 log_level 值在列表中，则将其值改为 "OK"
group_in(log_level, ["info", "debug"], "OK")

# 如果字段 http_status 值在指定列表中，则新建 status 字段，其值为 "not-ok"
group_in(log_level, ["error", "panic"], "not-ok", status)
```


### `http_request()` {#fn-http-request}

函数原型： `fn http_request(method: str, url: str, headers: map, body: any) map`

函数说明： 发送 HTTP 请求，接收响应并封装成 map

参数：

- `method`：GET|POST
- `url`: 请求路径
- `headers`：附加的 header，类型为 map[string]string
- `body`：请求体

返回值类型：map

key 包含了状态码（status_code）和返回体（body）

- `status_code`: 状态码
- `body`: 返回体

示例：

```python
resp = http_request("GET", "http://localhost:8080/testResp")
resp_body = load_json(resp["body"])

add_key(abc, resp["status_code"])
add_key(abc, resp_body["a"])
```


### `json()` {#fn-json}

函数原型：`fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

函数说明：提取 JSON 中的指定字段，并可将其命名成新的字段。

参数：

- `input`: 待提取 JSON，可以是原始文本（`_`）或经过初次提取之后的某个 `key`
- `json_path`: JSON 路径信息
- `newkey`：提取后数据写入新 key
- `trim_space`: 删除提取出的字符中的空白首尾字符，默认值为 `true`
- `delete_after_extract`: 在提取结束后删除当前对象，在重新序列化后回写待提取对象；只能应用于 map 的 key 与 value 的删除，不能用于删除 list 的元素；默认值为 `false`，不进行任何操作

```python
# 直接提取原始输入 JSON 中的 x.y 字段，并可将其命名成新字段 abc
json(_, x.y, abc)

# 已提取出的某个 `key`，对其再提取一次 `x.y`，提取后字段名为 `x.y`
json(key, x.y) 
```

示例一：

```python
# 待处理数据：
# {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# 处理脚本：
json(_, info, "zhangsan")
json(zhangsan, name)
json(zhangsan, age, "age")

# 处理结果：
{
  "age": 17,
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

示例二：

```python
# 待处理数据：
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

# 处理脚本：
json(_, name)
json(name, first)
```

示例三：

```python
# 待处理数据：
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# 处理脚本，json 数组处理：
json(_, .[0].nets[-1])
```

示例四：

```python
# 待处理数据：
{"item": " not_space ", "item2":{"item3": [123]}}

# 处理脚本：
json(_, item2.item3, item, delete_after_extract = true)

# 输出：
{
  "item": "[123]",
  "message": "{\"item\":\" not_space \",\"item2\":{}}",
}
```


示例五：

```python
# 待处理数据：
{"item": " not_space ", "item2":{"item3": [123]}}

# 处理脚本：
# 如果尝试删除列表元素将无法通过脚本检查
json(_, item2.item3[0], item, true, true)

# 本地测试命令：
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# 报错：
# [E] j2.p:1:37: does not support deleting elements in the list
```


### `kv_split()` {#fn-kv_split}

函数原型：`fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

函数说明：从字符串中提取出所有的键值对

参数：

- `key`: key 名称
- `include_keys`: 包含的 key 名称列表，仅提取在该列表内的 key；**默认值为 []，不提取任何 key**
- `field_split_pattern`: 字符串分割，用于提取出所有键值对的正则表达式；默认值为 `" "`
- `value_split_pattern`: 用于从键值对字符串分割出键和值，非递归；默认值为 `"="`
- `trim_key`: 删除提取出的 key 的前导和尾随的所有指定的字符；默认值为 `""`
- `trim_value`: 删除提取出的 value 的前导和尾随的所有指定的字符；默认值为 `""`
- `prefix`: 给所有的 key 添加前缀字符串

示例：


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

函数原型：`fn len(val: str|map|list) int`

函数说明：计算 string 字节数，map 和 list 的元素个数。

参数：

- `val`: 可以是 map、list 或 string

示例：

```python
# 例 1
add_key(abc, len("abc"))
# 输出
{
 "abc": 3,
}

# 例 2
add_key(abc, len(["abc"]))
#处理结果
{
  "abc": 1,
}
```


### `load_json()` {#fn-load-json}

函数原型：`fn load_json(val: str) nil|bool|float|map|list`

函数说明：将 JSON 字符串转换成 map、list、nil、bool、float 的其中一种，可通过 index 表达式取值及修改值。若反序列化失败，也返回 nil，而不是终止脚本运行。

参数：

- `val`: 要求是 string 类型的数据。

示例：

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key(abc, abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# 需要将堆栈上的数据同步到 point 中
add_key(abc, abc["a"]["first"][-1])

add_key(len_abc, len(abc))

add_key(len_abc, len(load_json(abc["a"]["ff"])))
```


### `lowercase()` {#fn-lowercase}

函数原型：`fn lowercase(key: str)`

函数说明：将已提取 key 中内容转换成小写

函数参数：

- `key`: 指定已提取的待转换字段名

示例：

```python
# 待处理数据：{"first": "HeLLo","second":2,"third":"aBC","forth":true}

# 处理脚本
json(_, first) lowercase(first)

# 处理结果
{
    "first": "hello"
}
```



### `match()` {#fn-match}

函数原型：`fn match(pattern: str, s: str) bool`

函数说明：使用指定的正则表达式匹配字符串，匹配成功返回 true，否则返回 false

参数：

- `pattern`: 正则表达式
- `s`: 待匹配的字符串

示例：

```python
# 脚本
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key(match_1, match('''\w+\s[,\w]+''', test_1)) 

add_key(match_2, match('''\w+\s[,\w]+''', test_2)) 

# 处理结果
{
    "match_1": true,
    "match_2": false
}
```


### `mquery_refer_table()` {#fn-mquery-refer-table}

函数原型：`fn mquery_refer_table(table_name: str, keys: list, values: list)`

函数说明：通过指定多个 key 查询外部引用表，并将查询结果的首行的所有列追加到 field 中。该函数不适用于中心 Pipeline。

参数：

- `table_name`: 待查找的表名
- `keys`: 多个列名构成的列表
- `values`: 每个列对应的值

示例：

```python
json(_, table)
json(_, key)
json(_, value)

# 查询并追加当前列的数据，默认作为 field 添加到数据中
mquery_refer_table(table, values=[value, false], keys=[key, "col4"])
```

示例结果：

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

函数原型：`fn nullif(key, value)`

函数说明：若已提取 `key` 指定的字段内容等于 `value` 值，则删除此字段

函数参数：

- `key`: 指定字段
- `value`: 目标值

示例：

```python
# 待处理数据：{"first": 1,"second":2,"third":"aBC","forth":true}

# 处理脚本
json(_, first) json(_, second) nullif(first, "1")

# 处理结果
{
    "second":2
}
```

> 注：该功能可通过 `if/else` 语义来实现：

```python
if first == "1" {
    drop_key(first)
}
```



### `parse_date()` {#fn-parse-date}

函数原型：`fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

函数说明：将传入的日期字段各部分的值转化为时间戳

函数参数：

- `key`: 新插入的字段
- `yy` : 年份数字字符串，支持四位或两位数字字符串，为空字符串，则处理时取当前年份
- `MM`:  月份字符串，支持数字，英文，英文缩写
- `dd`: 日字符串
- `hh`: 小时字符串
- `mm`: 分钟字符串
- `ss`: 秒字符串
- `ms`: 毫秒字符串
- `us`: 微秒字符串
- `ns`: 纳秒字符串
- `zone`: 时区字符串，“+8”或\"Asia/Shanghai\"形式

示例：

```python
parse_date(aa, "2021", "May", "12", "10", "10", "34", "", "Asia/Shanghai") # 结果 aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "", "Asia/Shanghai") # 结果 aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", "Asia/Shanghai") # 结果 aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", "", "+8") 结果 aa=1581473434000000000
```


### `parse_duration()` {#fn-parse-duration}

函数原型：`fn parse_duration(key: str)`

函数说明：如果 `key` 的值是一个 golang 的 duration 字符串（如 `123ms`），则自动将 `key` 解析成纳秒为单位的整数

目前 golang 中的 duration 单位如下：

- `ns` 纳秒
- `us/µs` 微秒
- `ms` 毫秒
- `s` 秒
- `m` 分钟
- `h` 小时

函数参数：

- `key`: 待解析的字段

示例：

```python
# 假定 abc = "3.5s"
parse_duration(abc) # 结果 abc = 3500000000

# 支持负数：abc = "-3.5s"
parse_duration(abc) # 结果 abc = -3500000000

# 支持浮点：abc = "-2.3s"
parse_duration(abc) # 结果 abc = -2300000000

```



### `parse_int()` {#fn-parse-int}

函数原型：`fn parse_int(val: int, base: int) str`

函数说明：将数值的字符串表示转换为数值。

参数：

- `val`: 待转换的字符串
- `base`: 进制，范围 0，或 2 到 36；值为 0 时根据字符串前缀判断进制。

示例：

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

函数原型： `fn point_window(before: int, after: int, stream_tags = ["filepath", "host"])`

函数说明： 记录被丢弃的数据，配合 `window_hit` 函数使用，上传被丢弃的上下文 `Point` 数据。

函数参数：

- `before`: 函数 `window_hit` 执行之前的最大可暂存的 Point 个数，未丢弃的数据参与计数。
- `after`: 函数 `window_hit` 执行之后保留的 Point 个数，未丢弃的数据参与计数。
- `stream_tags`: 通过数据上的标签区分日志（指标，链路等）流，默认数使用 `filepath` 和 `host` 可用于区分来自同一文件的日志。

示例：

```python
# 建议放置在脚本首行
#
point_window(8, 8)

# 如果是 panic 日志，保留前 8 条，以及后 8 条（包含当前一条）
if grok(_, "abc.go:25 panic: xxxxxx") {
    # 只有此次运行过程中 point_window() 被执行，这个函数才会生效
    # 触发窗口内的数据恢复行为
    #
    window_hit()
}

# 默认丢弃全部的 service 为 test_app 的日志；
# 若包含 panic 的日志，则保留相邻的 15 条以及当前这条
#
if service == "test_app" {
    drop()
}
```


### `pt_name()` {#fn-pt-name}

函数原型：`fn pt_name(name: str = "") -> str`

函数说明：获取 point 的 name；如果参数不为空则设置新的 name。

函数参数：

- `name`: 值作为 point name；默认值为空字符串

Point Name 与各个类型数据存储时的字段映射关系：

| 类别          | 字段名 |
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

函数原型：`fn query_refer_table(table_name: str, key: str, value)`

函数说明：通过指定的 key 查询外部引用表，并将查询结果的首行的所有列追加到 field 中。该函数不适用于中心 Pipeline。

参数：

- `table_name`: 待查找的表名
- `key`: 列名
- `value`: 列对应的值

示例：

```python
# 从输入中提取 表名，列名，列值
json(_, table)
json(_, key)
json(_, value)

# 查询并追加当前列的数据，默认作为 field 添加到数据中
query_refer_table(table, key, value)

```

示例结果：

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

函数原型：`fn rename(new_key, old_key)`

函数说明：将已提取的字段重新命名

参数：

- `new_key`: 新字段名
- `old_key`: 已提取的字段名

示例：

```python
# 把已提取的 abc 字段重新命名为 abc1
rename('abc1', abc)

# or 

rename(abc1, abc)
```

```python
# 待处理数据：{"info": {"age": 17, "name": "zhangsan", "height": 180}}

# 处理脚本
json(_, info.name, "姓名")

# 处理结果
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

函数原型：`fn replace(key: str, regex: str, replace_str: str)`

函数说明：对指定字段上获取的字符串数据按正则进行替换

函数参数：

- `key`: 待提取字段
- `regex`: 正则表达式
- `replace_str`: 替换的字符串

示例：

```python
# 电话号码：{"str_abc": "13789123014"}
json(_, str_abc)
replace(str_abc, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# 英文名 {"str_abc": "zhang san"}
json(_, str_abc)
replace(str_abc, "([a-z]*) \\w*", "$1 ***")

# 身份证号 {"str_abc": "362201200005302565"}
json(_, str_abc)
replace(str_abc, "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# 中文名 {"str_abc": "小阿卡"}
json(_, str_abc)
replace(str_abc, '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```



### `sample()` {#fn-sample}

函数原型：`fn sample(p)`

函数说明：以概率 p 选择采集/丢弃数据。

函数参数：

- `p`: sample 函数返回 true 的概率，取值范围为[0, 1]

示例：

```python
# 处理脚本
if !sample(0.3) { # sample(0.3) 表示采样率为 30%，即以 30% 概率返回真，此处将丢弃 70% 的数据
  drop() # 标记该数据丢弃
  exit() # 退出后续处理流程
}
```


### `set_measurement()` {#fn-set-measurement}

函数原型：`fn set_measurement(name: str, delete_key: bool = false)`

函数说明：改变行协议的 name
函数参数：

- `name`: 值作为 measurement name，可传入字符串常量或变量
- `delete_key`: 如果在 point 中存在与变量同名的 tag 或 field 则删除它

行协议 name 与各个类型数据存储时的字段映射关系或其他用途：

| 类别          | 字段名 | 其他用途 |
| -             | -      | -        |
| custom_object | class  | -        |
| keyevent      | -      | -        |
| logging       | source | -        |
| metric        | -      | 指标集名 |
| network       | source | -        |
| object        | class  | -        |
| profiling     | source | -        |
| rum           | source | -        |
| security      | rule   | -        |
| tracing       | source | -        |


### `set_tag()` {#fn-set-tag}

函数原型：`fn set_tag(key, value: str)`

函数说明：对指定字段标记为 tag 输出，设置为 tag 后，其他函数仍可对该变量操作。如果被置为 tag 的 key 是已经切割出来的 field，那么它将不会在 field 中出现，这样可以避免切割出来的 field key 跟已有数据上的 tag key 重名

函数参数：

- `key`: 待标记为 tag 的字段
- `value`: 可以为字符串字面量或者变量

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
# * 字符 `#` 仅为 datakit --pl <path> --txt <str> 输出展示时字段为 tag 的标记

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

函数原型：`fn sql_cover(sql_test: str)`

函数说明：脱敏 SQL 语句

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```


### `strfmt()` {#fn-strfmt}

函数原型：`fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

函数说明：对已提取 `arg1, arg2, ...` 指定的字段内容根据 `fmt` 进行格式化，并把格式化后的内容写入 `key` 字段中

函数参数：

- `key`: 指定格式化后数据写入字段名
- `fmt`: 格式化字符串模板
- `args`：可变参数，可以是多个已提取的待格式化字段名

示例：

```python
# 待处理数据：{"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# 处理脚本
json(_, a.second)
json(_, a.thrid)
cast(a.second, "int")
json(_, a.forth)
strfmt(bb, "%v %s %v", a.second, a.thrid, a.forth)
```


### `timestamp()` {#fn-timestamp}

函数原型：`fn timestamp(precision: str = "ns") -> int`

函数说明：返回当前 Unix 时间戳，默认精度为 ns

函数参数：

- `precision`: 时间戳精度，取值范围为 "ns", "us", "ns", "s", 默认值 "ns"。

示例：

```python
# 处理脚本
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "UTC")


# 处理结果
{
  "time_now_record": "2023-03-07 10:41:12"
}

```

```python
# 处理脚本
add_key(time_now_record, timestamp())

datetime(time_now_record, "ns", 
    "%Y-%m-%d %H:%M:%S", "Asia/Shanghai")


# 处理结果
{
  "time_now_record": "2023-03-07 18:41:49"
}
```

```python
# 处理脚本
add_key(time_now_record, timestamp("ms"))


# 处理结果
{
  "time_now_record": 1678185980578
}
```


### `trim()` {#fn-trim}

函数原型：`fn trim(key, cutset: str = "")`

函数说明：删除 `key` 中首尾中指定的字符，`cutset` 为空字符串时默认删除所有空白符

函数参数：

- `key`: 已提取的某字段，字符串类型
- `cutset`: 删除 `key` 中出现在 `cutset` 字符串的中首尾字符

示例：

```python
# 待处理数据："trim(key, cutset)"

# 处理脚本
add_key(test_data, "ACCAA_test_DataA_ACBA")
trim(test_data, "ABC_")

# 处理结果
{
  "test_data": "test_Data"
}
```


### `uppercase()` {#fn-uppercase}

函数原型：`fn uppercase(key: str)`

函数说明：将已提取 key 中内容转换成大写

函数参数：

- `key`: 指定已提取的待转换字段名，将 `key` 内容转成大写

示例：

```python
# 待处理数据：{"first": "hello","second":2,"third":"aBC","forth":true}

# 处理脚本
json(_, first) uppercase(first)

# 处理结果
{
   "first": "HELLO"
}
```



### `url_decode()` {#fn-url-decode}

函数原型：`fn url_decode(key: str)`

函数说明：将已提取 `key` 中的 URL 解析成明文

参数：

- `key`: 已经提取的某个 `key`

示例：

```python
# 待处理数据：{"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# 处理脚本
json(_, url) url_decode(url)

# 处理结果
{
  "message": "{"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```


### `url_parse()` {#fn-url-parse}

函数原型：`fn url_parse(key)`

函数说明：解析字段名称为 key 的 url。

函数参数：

- `key`: 要解析的 url 的字段名称。

示例：

```python
# 待处理数据：{"url": "https://www.baidu.com"}

# 处理脚本
json(_, url)
m = url_parse(url)
add_key(scheme, m["scheme"])

# 处理结果
{
    "url": "https://www.baidu.com",
    "scheme": "https"
}
```

上述示例从 url 提取了其 scheme，除此以外，还能从 url 提取出 host, port, path, 以及 url 中携带的参数等信息，如下例子所示：

```python
# 待处理数据：{"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# 处理脚本
json(_, url)
m = url_parse(url)
add_key(sclient, m["params"]["sclient"])    # url 中携带的参数被保存在 params 字段下
add_key(h, m["host"])
add_key(path, m["path"])

# 处理结果
{
    "url": "https://www.google.com/search?q=abc&sclient=gws-wiz",
    "h": "www.google.com",
    "path": "/search",
    "sclient": "gws-wiz"
}
```


### `use()` {#fn-use}

函数原型：`fn use(name: str)`

参数：

- `name`: 脚本名，如 abp.p

函数说明：调用其他脚本，可在被调用的脚本访问当前的所有数据
示例：

```python
# 待处理数据：{"ip":"1.2.3.4"}

# 处理脚本 a.p
use(\"b.p\")

# 处理脚本 b.p
json(_, ip)
geoip(ip)

# 执行脚本 a.p 的处理结果
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

函数原型：`fn user_agent(key: str)`

函数说明：对指定字段上获取客户端信息

函数参数：

- `key`: 待提取字段

`user_agent()` 会生产多个字段，如：

- `os`: 操作系统
- `browser`: 浏览器

示例：

```python
# 待处理数据
#    {
#        "userAgent" : "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
#        "second"    : 2,
#        "third"     : "abc",
#        "forth"     : true
#    }

json(_, userAgent) user_agent(userAgent)
```


### `valid_json()` {#fn-valid-json}

函数原型：`fn valid_json(val: str) bool`

函数说明：判断是否为一个有效的 JSON 字符串。

参数：

- `val`: 要求是 string 类型的数据。

示例：

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

结果：

```json
{
  "a": "nil",
  "b": "[1,2,3]",
  "c": "{\"a\":1}",
  "d": "invalid json",
}
```


### `value_type()` {#fn-value-type}

函数原型：`fn value_type(val) str`

函数说明：获取变量的值的类型，返回值范围 ["int", "float", "bool", "str", "list", "map", ""], 若值为 nil，则返回空字符串

参数：

- `val`: 待判断类型的值

示例：

输入：

```json
{"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
```

脚本：

```python
d = load_json(_)

if value_type(d) == "map" && "a" in d  {
    add_key("val_type", value_type(d["a"]))
}
```

输出：

```json
// Fields
{
  "message": "{\"a\":{\"first\": [2.2, 1.1], \"ff\": \"[2.2, 1.1]\",\"second\":2,\"third\":\"aBC\",\"forth\":true},\"age\":47}",
  "val_type": "map"
}
```


### `window_hit` {fn-window-hit}

函数原型： `fn window_hit()`

函数说明： 触发上下文被丢弃的数据的恢复事件，从 `point_window` 函数记录的数据中进行恢复

函数参数： 无

示例：

```python
# 建议放置在脚本首行
#
point_window(8, 8)

# 如果是 panic 日志，保留前 8 条，以及后 8 条（包含当前一条）
if grok(_, "abc.go:25 panic: xxxxxx") {
    # 只有此次运行过程中 point_window() 被执行，这个函数才会生效
    # 触发窗口内的数据恢复行为
    #
    window_hit()
}

# 默认丢弃全部的 service 为 test_app 的日志；
# 若包含 panic 的日志，则保留相邻的 15 条以及当前这条
#
if service == "test_app" {
    drop()
}
```


### `xml()` {#fn-xml}

函数原型：`fn xml(input: str, xpath_expr: str, key_name)`

函数说明：通过 xpath 表达式，从 XML 中提取字段。

参数：

- input: 待提取的 XML
- xpath_expr: xpath 表达式
- key_name: 提取后数据写入新 key

示例一：

```python
# 待处理数据
       <entry>
        <fieldx>valuex</fieldx>
        <fieldy>...</fieldy>
        <fieldz>...</fieldz>
        <fieldarray>
            <fielda>element_a_1</fielda>
            <fielda>element_a_2</fielda>
        </fieldarray>
    </entry>

# 处理脚本
xml(_, '/entry/fieldarray//fielda[1]/text()', field_a_1)

# 处理结果
{
  "field_a_1": "element_a_1",  # 提取了 element_a_1
  "message": "\t\t\u003centry\u003e\n        \u003cfieldx\u003evaluex\u003c/fieldx\u003e\n        \u003cfieldy\u003e...\u003c/fieldy\u003e\n        \u003cfieldz\u003e...\u003c/fieldz\u003e\n        \u003cfieldarray\u003e\n            \u003cfielda\u003eelement_a_1\u003c/fielda\u003e\n            \u003cfielda\u003eelement_a_2\u003c/fielda\u003e\n        \u003c/fieldarray\u003e\n    \u003c/entry\u003e",
  "status": "unknown",
  "time": 1655522989104916000
}
```

示例二：

```python
# 待处理数据
<OrderEvent actionCode = "5">
 <OrderNumber>ORD12345</OrderNumber>
 <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# 处理脚本
xml(_, '/OrderEvent/@actionCode', action_code)
xml(_, '/OrderEvent/OrderNumber/text()', OrderNumber)

# 处理结果
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "\u003cOrderEvent actionCode = \"5\"\u003e\n \u003cOrderNumber\u003eORD12345\u003c/OrderNumber\u003e\n \u003cVendorNumber\u003eV11111\u003c/VendorNumber\u003e\n\u003c/OrderEvent\u003e",
  "status": "unknown",
  "time": 1655523193632471000
}
```



