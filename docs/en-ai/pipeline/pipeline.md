# Pipeline Data Processor Language Definition

---

Below is the definition of the Pipeline data processor language. As support for different syntaxes gradually increases, this document will undergo adjustments and revisions to varying degrees.

## Basic Rules {#basic-syntax}

### Identifiers and Keywords {#identifier-and-keyword}

#### Identifier {#identifier}

Identifiers are used to identify objects and can represent a variable, function, etc. An identifier includes keywords.

Custom identifiers cannot duplicate Pipeline data processor language keywords.

An identifier can be composed of digits (`0-9`), letters (`A-Z a-z`), and underscores (`_`), but the first character cannot be a digit and it is case-sensitive:

- `_abc`
- `abc`
- `abc1`
- `abc_1_`

If you need an identifier to start with a letter or use characters outside those mentioned above within the identifier, you should use backticks:

- `` `1abc` ``
- `` `@some-variable` ``
- `` `this-is-a-emoji-👍` ``

#### Special Identifier {#special-identifier}

To maintain forward compatibility of Pipeline semantics, `_` acts as an alias for `message`.

#### Keyword {#keyword}

Keywords have special meanings, such as `if`, `elif`, `else`, `for`, `in`, `break`, `continue`, etc.

### Comments {#code-comments}

Use `#` as the line comment character, inline comments are not supported.

```python
# This is a line comment
a = 1 # This is a line comment

"""
This is a (multi-line) string, used as a comment substitute
"""
a = 2

"String"
a = 3
```

### Data Types {#data-type}

In the DataKit Pipeline data processing language, the type of a variable's value can dynamically change, but each value has its data type, which can be one of the **basic types** or **composite types**.

#### Basic Types {#basic-type}

##### Integer {#int}

The integer type length is 64-bit, signed, and currently only supports writing integer literals in decimal form, such as `-1`, `0`, `1`, `+19`.

##### Floating Point Type {#float}

The floating-point type length is 64-bit, signed, and currently only supports writing floating-point number literals in decimal form, such as `-1.00001`, `0.0`, `1.0`, `+19.0`.

##### Boolean Type {#bool}

Boolean type values can only be `true` and `false`.

##### String Type {#str}

String values can be enclosed in double quotes or single quotes. Multi-line strings can be written using triple double quotes or triple single quotes.

- Double quote string `"hello world"`
- Single quote string `'hello world'`
- Multi-line string

```python
"""hello
world"""
```

- Single quote multi-line string

```python
'''
hello
world
'''
```

##### Nil Type {#nil}

Nil is a special data type indicating null. When a variable is used without assignment, its value is nil.

#### Composite Types {#composite-type}

Dictionary and list types differ from basic types; multiple variables can point to the same map or list object. Assignment does not copy the memory of lists or dictionaries but performs a reference.

- Dictionary Type

The dictionary type is a key-value structure where only string types can be keys, and there are no restrictions on the value's data type. Elements in the map can be read and written via index expressions:

```python
a = {
  "1": [1, "2", 3, nil],
  "2": 1.1,
  "abc": nil,
  "def": true
}

# Since a["1"] is a list, b just references the value of a["1"]
b = a["1"]

# Now this value in a also becomes 1.1
b[0] = 1.1
```

- List Type

The list type can store any number of elements of any type.
Elements in the list can be read and written via index expressions.

```python
a = [1, "2", 3.0, false, nil, {"a": 1}]

a = a[0] # a == 1
```

## Quick Start {#quick-start}

- Configure Pipeline in DataKit and write the following Pipeline file, assuming it is named *nginx.p*. Place it in the *[Datakit installation directory]/pipeline* directory.

```python
# Assume the input is an Nginx log
# Note: Scripts can include comments

grok(_, "some-grok-patterns")  # Extract text using grok
rename('client_ip', ip)        # Rename the ip field to client_ip
rename("网络协议", protocol)   # Rename the protocol field to "网络协议"

# Convert timestamps (e.g., 1610967131) to RFC3339 date format: 2006-01-02T15:04:05Z07:00
datetime(access_time, "s", "RFC3339")

url_decode(request_url)      # Decode HTTP request routes into plain text

# Create a new http_status = "HTTP_OK" field when status_code is between 200 and 300
group_between(status_code, [200, 300], "HTTP_OK", "http_status")

# Discard original content
drop_origin_data()
```

<!-- markdownlint-disable MD046 -->
???+ warning "Note"

    During parsing, avoid potential conflicts with tag keys. Refer to [here](./use-pipeline/pipeline-quick-start.md#naming).
<!-- markdownlint-enable -->

- Configure the corresponding collector to use the above Pipeline.

For example, with the logging collector, configure the `pipeline_path` field. Note that here you specify the script name, not the path. All referenced pipeline scripts must be placed in the `<DataKit installation directory/pipeline>` directory:

```python
[[inputs.logging]]
    logfiles = ["/path/to/nginx/log"]

    # required
    source = "nginx"

    # All scripts must be placed in /path/to/datakit/pipeline directory
    # If gitrepos feature is enabled, scripts in gitrepos take precedence
    # If pipeline is not configured, look for a script with the same name as the source
    # (e.g., nginx -> nginx.p) in the pipeline directory as the default pipeline configuration
    pipeline = "nginx.p"

    ... # other configurations
```

Restart the collector to parse the corresponding logs.

<!-- markdownlint-disable MD046 -->
???+ abstract

    For details on Pipeline scripting, debugging, and precautions, refer to [How to Write Pipeline Scripts](./use-pipeline/pipeline-quick-start.md).
<!-- markdownlint-enable -->

## Grok Pattern Categories {#grok}

Grok patterns in DataKit can be categorized into two types:

- Global Patterns: Patterns in files under the *pattern* directory are global patterns available to all Pipeline scripts;
- Local Patterns: Patterns added via the [add_pattern()](pipeline.md#fn-add-pattern) function within Pipeline scripts are local patterns effective only for the current Pipeline script.

Taking Nginx access-log as an example, the original nginx access log looks like this:

```log
127.0.0.1 - - [26/May/2022:20:53:52 +0800] "GET /server_status HTTP/1.1" 404 134 "-" "Go-http-client/1.1"
```

Assuming we want to extract client_ip, time (request), http_method, http_url, http_version, status_code from this access log, the initial grok pattern can be written as:

```python
grok(_,"%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

cast(status_code, "int")
group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)
default_time(time)
```

After optimization, the features can be extracted separately:

```python
# The client_ip, http_ident, http_auth at the beginning of the log as a pattern
add_pattern("p1", "%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE}")

# The middle part of http_method, http_url, http_version, status_code as a pattern,
# and specify the data type of status_code as int within the pattern to replace the cast function
add_pattern("p3", '"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}" %{INT:status_code:int}')

grok(_, "%{p1} \\[%{HTTPDATE:time}\\] %{p3} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)

default_time(time)
```

Compared to the initial single-line pattern, the optimized parsing improves readability. Since grok-extracted fields default to string type, specifying the data type for fields avoids the need to use the [cast()](pipeline.md#fn-cast) function for type conversion later.

### Grok Composition {#grok-compose}

Grok essentially predefines some regular expressions for text matching and extraction, naming these predefined regular expressions for easy use and nested referencing to extend countless new patterns. For instance, DataKit has three built-in patterns as follows:

```python
_second (?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)    # Match seconds, _second is the pattern name
_minute (?:[0-5][0-9])                            # Match minutes, _minute is the pattern name
_hour (?:2[0123]|[01]?[0-9])                      # Match hours, _hour is the pattern name
```

Based on the above three built-in patterns, you can expand to your own built-in pattern named `time`:

```python
# Add time to the files under the pattern directory. This pattern is global and can be referenced anywhere.
time ([^0-9]?)%{hour:hour}:%{minute:minute}(?::%{second:second})([^0-9]?)

# You can also add it to the pipeline file via add_pattern(), making this pattern local and usable only by the current pipeline script
add_pattern(time, "([^0-9]?)%{HOUR:hour}:%{MINUTE:minute}(?::%{SECOND:second})([^0-9]?)")

# Extract the time field from the original input using grok. Assuming the input is 12:30:59, it extracts {"hour": 12, "minute": 30, "second": 59}
grok(_, %{time})
```

<!-- markdownlint-disable MD046 -->
???+ warning "Note"

    - If there are identically named patterns, local patterns take precedence (i.e., local patterns override global patterns);
    - In Pipeline scripts, [add_pattern()](pipeline.md#fn-add-pattern) must be called before [grok()](pipeline.md#fn-grok), otherwise it will cause the first data extraction to fail.
<!-- markdownlint-enable -->

### Built-in Pattern List {#builtin-patterns}

DataKit provides some commonly used built-in patterns that can be directly used when performing Grok parsing:

<!-- markdownlint-disable MD046 -->
???- "Built-in Patterns"

    ``` not-set
    USERNAME             : [a-zA-Z0-9._-]+
    USER                 : %{USERNAME}
    EMAILLOCALPART       : [a-zA-Z][a-zA-Z0-9_.+-=:]+
    EMAILADDRESS         : %{EMAILLOCALPART}@%{HOSTNAME}
    HTTPDUSER            : %{EMAILADDRESS}|%{USER}
    INT                  : (?:[+-]?(?:[0-9]+))
    BASE10NUM            : (?:[+-]?(?:[0-9]+(?:\.[0-9]+)?)|\.[0-9]+)
    NUMBER               : (?:%{BASE10NUM})
    BASE16NUM            : (?:0[xX]?[0-9a-fA-F]+)
    POSINT               : \b(?:[1-9][0-9]*)\b
    NONNEGINT            : \b(?:[0-9]+)\b
    WORD                 : \b\w+\b
    NOTSPACE             : \S+
    SPACE                : \s*
    DATA                 : .*?
    GREEDYDATA           : .*
    GREEDYLINES          : (?s).*
    QUOTEDSTRING         : "(?:[^"\\]*(?:\\.[^"\\]*)*)"|\'(?:[^\'\\]*(?:\\.[^\'\\]*)*)\'
    UUID                 : [A-Fa-f0-9]{8}-(?:[A-Fa-f0-9]{4}-){3}[A-Fa-f0-9]{12}
    MAC                  : (?:%{CISCOMAC}|%{WINDOWSMAC}|%{COMMONMAC})
    CISCOMAC             : (?:(?:[A-Fa-f0-9]{4}\.){2}[A-Fa-f0-9]{4})
    WINDOWSMAC           : (?:(?:[A-Fa-f0-9]{2}-){5}[A-Fa-f0-9]{2})
    COMMONMAC            : (?:(?:[A-Fa-f0-9]{2}:){5}[A-Fa-f0-9]{2})
    IPV6                 : (?:(?:(?:[0-9A-Fa-f]{1,4}:){7}(?:[0-9A-Fa-f]{1,4}|:))|(?:(?:[0-9A-Fa-f]{1,4}:){6}(?::[0-9A-Fa-f]{1,4}|(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(?:(?:[0-9A-Fa-f]{1,4}:){5}(?:(?:(?::[0-9A-Fa-f]{1,4}){1,2})|:(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(?:(?:[0-9A-Fa-f]{1,4}:){4}(?:(?:(?::[0-9A-Fa-f]{1,4}){1,3})|(?:(?::[0-9A-Fa-f]{1,4})?:(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(?:(?:[0-9A-Fa-f]{1,4}:){3}(?:(?:(?::[0-9A-Fa-f]{1,4}){1,4})|(?:(?::[0-9A-Fa-f]{1,4}){0,2}:(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(?:(?:[0-9A-Fa-f]{1,4}:){2}(?:(?:(?::[0-9A-Fa-f]{1,4}){1,5})|(?:(?::[0-9A-Fa-f]{1,4}){0,3}:(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(?:(?:[0-9A-Fa-f]{1,4}:){1}(?:(?:(?::[0-9A-Fa-f]{1,4}){1,6})|(?:(?::[0-9A-Fa-f]{1,4}){0,4}:(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(?::(?:(?:(?::[0-9A-Fa-f]{1,4}){1,7})|(?:(?::[0-9A-Fa-f]{1,4}){0,5}:(?:(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(?:\.(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(?:%.+)?
    IPV4                 : (?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)
    IP                   : (?:%{IPV6}|%{IPV4})
    HOSTNAME             : \b(?:[0-9A-Za-z][0-9A-Za-z-]{0,62})(?:\.(?:[0-9A-Za-z][0-9A-Za-z-]{0,62}))*(?:\.?|\b)
    HOST                 : %{HOSTNAME}
    IPORHOST             : (?:%{IP}|%{HOSTNAME})
    HOSTPORT             : %{IPORHOST}:%{POSINT}
    PATH                 : (?:%{UNIXPATH}|%{WINPATH})
    UNIXPATH             : (?:/[\w_%!$@:.,-]?/?)(?:\S+)?
    TTY                  : (?:/dev/(?:pts|tty(?:[pq])?)(?:\w+)?/?(?:[0-9]+))
    WINPATH              : (?:[A-Za-z]:|\\)(?:\\[^\\?*]*)+
    URIPROTO             : [A-Za-z]+(?:\+[A-Za-z+]+)?
    URIHOST              : %{IPORHOST}(?::%{POSINT:port})?
    URIPATH              : (?:/[A-Za-z0-9$.+!*'(){},~:;=@#%_\-]*)+
    URIPARAM             : \?[A-Za-z0-9$.+!*'|(){},~@#%&/=:;_?\-\[\]<>]*
    URIPATHPARAM         : %{URIPATH}(?:%{URIPARAM})?
    URI                  : %{URIPROTO}://(?:%{USER}(?::[^@]*)?@)?(?:%{URIHOST})?(?:%{URIPATHPARAM})?
    MONTH                : \b(?:Jan(?:uary|uar)?|Feb(?:ruary|ruar)?|M(?:a|ä)?r(?:ch|z)?|Apr(?:il)?|Ma(?:y|i)?|Jun(?:e|i)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|O(?:c|k)?t(?:ober)?|Nov(?:ember)?|De(?:c|z)(?:ember)?)\b
    MONTHNUM             : (?:0?[1-9]|1[0-2])
    MONTHNUM2            : (?:0[1-9]|1[0-2])
    MONTHDAY             : (?:(?:0[1-9])|(?:[12][0-9])|(?:3[01])|[1-9])
    DAY                  : (?:Mon(?:day)?|Tue(?:sday)?|Wed(?:nesday)?|Thu(?:rsday)?|Fri(?:day)?|Sat(?:urday)?|Sun(?:day)?)
    YEAR                 : (\d\d){1,2}
    HOUR                 : (?:2[0123]|[01]?[0-9])
    MINUTE               : (?:[0-5][0-9])
    SECOND               : (?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)
    TIME                 : (?:[^0-9]?)%{HOUR}:%{MINUTE}(?::%{SECOND})(?:[^0-9]?)
    DATE_US              : %{MONTHNUM}[/-]%{MONTHDAY}[/-]%{YEAR}
    DATE_EU              : %{MONTHDAY}[./-]%{MONTHNUM}[./-]%{YEAR}
    ISO8601_TIMEZONE     : (?:Z|[+-]%{HOUR}(?::?%{MINUTE}))
    ISO8601_SECOND       : (?:%{SECOND}|60)
    TIMESTAMP_ISO8601    : %{YEAR}-%{MONTHNUM}-%{MONTHDAY}[T ]%{HOUR}:?%{MINUTE}(?::?%{SECOND})?%{ISO8601_TIMEZONE}?
    DATE                 : %{DATE_US}|%{DATE_EU}
    DATESTAMP            : %{DATE}[- ]%{TIME}
    TZ                   : (?:[PMCE][SD]T|UTC)
    DATESTAMP_RFC822     : %{DAY} %{MONTH} %{MONTHDAY} %{YEAR} %{TIME} %{TZ}
    DATESTAMP_RFC2822    : %{DAY}, %{MONTHDAY} %{MONTH} %{YEAR} %{TIME} %{ISO8601_TIMEZONE}
    DATESTAMP_OTHER      : %{DAY} %{MONTH} %{MONTHDAY} %{TIME} %{TZ} %{YEAR}
    DATESTAMP_EVENTLOG   : %{YEAR}%{MONTHNUM2}%{MONTHDAY}%{HOUR}%{MINUTE}%{SECOND}
    HTTPDERROR_DATE      : %{DAY} %{MONTH} %{MONTHDAY} %{TIME} %{YEAR}
    SYSLOGTIMESTAMP      : %{MONTH} +%{MONTHDAY} %{TIME}
    PROG                 : [\x21-\x5a\x5c\x5e-\x7e]+
    SYSLOGPROG           : %{PROG:program}(?:\[%{POSINT:pid}\])?
    SYSLOGHOST           : %{IPORHOST}
    SYSLOGFACILITY       : <%{NONNEGINT:facility}.%{NONNEGINT:priority}>
    HTTPDATE             : %{MONTHDAY}/%{MONTH}/%{YEAR}:%{TIME} %{INT}
    QS                   : %{QUOTEDSTRING}
    SYSLOGBASE           : %{SYSLOGTIMESTAMP:timestamp} (?:%{SYSLOGFACILITY} )?%{SYSLOGHOST:logsource} %{SYSLOGPROG}:
    COMMONAPACHELOG      : %{IPORHOST:clientip} %{HTTPDUSER:ident} %{USER:auth} \[%{HTTPDATE:timestamp}\] "(?:%{WORD:verb} %{NOTSPACE:request}(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})" %{NUMBER:response} (?:%{NUMBER:bytes}|-)
    COMBINEDAPACHELOG    : %{COMMONAPACHELOG} %{QS:referrer} %{QS:agent}
    HTTPD20_ERRORLOG     : \[%{HTTPDERROR_DATE:timestamp}\] \[%{LOGLEVEL:loglevel}\] (?:\[client %{IPORHOST:clientip}\] ){0,1}%{GREEDYDATA:errormsg}
    HTTPD24_ERRORLOG     : \[%{HTTPDERROR_DATE:timestamp}\] \[%{WORD:module}:%{LOGLEVEL:loglevel}\] \[pid %{POSINT:pid}:tid %{NUMBER:tid}\]( \(%{POSINT:proxy_errorcode}\)%{DATA:proxy_errormessage}:)?( \[client %{IPORHOST:client}:%{POSINT:clientport}\])? %{DATA:errorcode}: %{GREEDYDATA:message}
    HTTPD_ERRORLOG       : %{HTTPD20_ERRORLOG}|%{HTTPD24_ERRORLOG}
    LOGLEVEL             : (?:[Aa]lert|ALERT|[Tt]race|TRACE|[Dd]ebug|DEBUG|[Nn]otice|NOTICE|[Ii]nfo|INFO|[Ww]arn?(?:ing)?|WARN?(?:ING)?|[Ee]rr?(?:or)?|ERR?(?:OR)?|[Cc]rit?(?:ical)?|CRIT?(?:ICAL)?|[Ff]atal|FATAL|[Ss]evere|SEVERE|EMERG(?:ENCY)?|[Ee]merg(?:ency)?)
    COMMONENVOYACCESSLOG : \[%{TIMESTAMP_ISO8601:timestamp}\] \"%{DATA:method} (?:%{URIPATH:uri_path}(?:%{URIPARAM:uri_param})?|%{DATA:}) %{DATA:protocol}\" %{NUMBER:status_code} %{DATA:response_flags} %{NUMBER:bytes_received} %{NUMBER:bytes_sent} %{NUMBER:duration} (?:%{NUMBER:upstream_service_time}|%{DATA:tcp_service_time}) \"%{DATA:forwarded_for}\" \"%{DATA:user_agent}\" \"%{DATA:request_id}\" \"%{DATA:authority}\" \"%{DATA:upstream_service}\"
    ```
<!-- markdownlint-enable -->

## if/else Branches {#if-else}

Pipeline supports `if/elif/else` syntax, where only conditional expressions are allowed after `if`, i.e., `<`, `<=`, `==`, `>`, `>=`, and `!=`. Parentheses for precedence and multiple condition expressions connected by `AND` and `OR` are also supported.

Both sides of the expression can be existing keys or fixed values (numbers, booleans, strings, and nil), for example:

```python
# Numerical comparison
add_key(score, 95)

if score == 100  {
  add_key(level, "S")
} elif score >= 90 && score < 100 {
  add_key(level, "A")
} elif score >= 60 {
  add_key(level, "C")
} else {
  add_key(level, "D")
}

# String comparison
add_key(name, "张三")

if name == "法外狂徒" {
  # This is impossible, don't slander me
}
```

Similar to most programming/scripting languages, execution order depends on whether the conditions in `if/elif` are met.

Note: For numerical comparisons, use `cast()` for type conversion first, for example:

``` python
# status_code is a string type extracted by grok
cast(status_code, "int")

if status == 200 {
  add_key(level, "OK")
} elif status >= 400 && status < 500 {
  add_key(level, "ERROR")
} elif stauts > 500 {
  add_key(level, "FATAL")
}
```

## for Loop {#for-loop}
Allowed to iterate over maps, lists, and strings using for, and control loops using `continue` and `break`

```python
# Example 1
b = "2"
for a in ["1", "a" ,"2"] {
  b = b + a
}
add_key(b)
# Processing result
{
  "b": "21a2"
}


# Example 2
d = 0
map_a = {"a": 1, "b":2}
for x in map_a {
  d = d + map_a[x]
}
add_key(d)
# Processing result
{
  "d": 3
}
```

## Pipeline Script Storage Directory {#pl-dirs}

The directory search priority for Pipeline is as follows:

1. Remote Pipeline directory
2. Git-managed *pipeline* directory
3. Built-in *pipeline* directory

Search from 1 to 3, return immediately when matched.

Absolute paths are not allowed.

### Remote Pipeline Directory {#remote-pl}

Under the `pipeline_remote` directory in the Datakit installation directory, the directory structure is as shown below:

```shell
.
├── conf.d
├── datakit
├── pipeline
│   ├── root_apache.p
│   └── root_consul.p
├── pipeline_remote
│   ├── remote_elasticsearch.p
│   └── remote_jenkins.p
├── gitrepos
│   └── mygitproject
│       ├── conf.d
│       ├── pipeline
│       │   └── git_kafka.p
│       │   └── git_mongod.p
│       └── python.d
└── ...
```

### Git-managed Pipeline Directory {#git-pl}

In the *pipeline* directory under the *project-name/gitrepos* directory, the directory structure is shown above.

### Built-in Pipeline Directory {#internal-pl}

In the *pipeline* directory under the Datakit installation directory, the directory structure is shown above.

## Input Data Structure for Scripts {#input-data}

All categories of data are encapsulated into a Point structure before being processed by the Pipeline script, roughly structured as follows:

``` not-set
struct Point {
    Name:    str
    Tags:    map[str]str
    Fields:  map[str]any
    Time:    int64
}
```

For example, taking an Nginx log entry, the generated data captured by the log collector and passed to the Pipeline script would look like this:

``` not-set
Point {
    Name: "nginx"
    Tags: map[str]str {
        "host": "your_hostname"
    },
    Fields: map[str]any {
        "message": "127.0.0.1 - - [12/Jan/2023:11:51:38 +0800] \"GET / HTTP/1.1\" 200 612 \"-\" \"curl/7.81.0\""
    },
    Time: 1673495498000123456
}
```

Tip:

- The `Name` can be modified using the `set_measurement()` function.

- For `Tags` and `Fields`, no key can exist simultaneously in both maps; they can be accessed through custom identifiers or the `get_key()` function in the pipeline. Modifying the value of a key in `Tags` or `Fields` requires using other **built-in functions**. The `_` can be considered an alias for the `message` key.

- After the script runs, if there is a key named `time` in `Tags` or `Fields`, it will be deleted; if its value is of type int64, it will be assigned to the `time` of the Point and then deleted. If `time` is a string, you can try using the `default_time()` function to convert it to int64.

## Script Functions {#functions}

Function parameter notes:

- In function parameters, anonymous parameters (`_`) refer to the original input text data.
- JSON paths are represented directly as `x.y.z`, requiring no additional decorations. For example, in `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`, the JSON path `a.third` represents the target data `abc`.
- The relative order of all function parameters is fixed, and the engine will perform specific checks.
- All mentioned `key` parameters refer to keys extracted initially (via `grok()` or `json()`).
- Paths for JSON processing support identifier notation and cannot use strings. If generating a new key, use a string.

### `add_key()` {#fn-add-key}

Function prototype: `fn add_key(key, value)`

Function description: Adds a field to the point.

Parameters:

- `key`: Name of the new key.
- `value`: Value for the key.

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

Function description: Creates a custom grok pattern. Grok patterns have scope limitations, such as creating a new scope within if-else statements, making the pattern valid only within that scope. This function cannot override grok patterns already existing in the same or previous scope.

Parameters:

- `name`: Pattern name.
- `pattern`: Custom pattern content.

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
        # Using pattern cc here will lead to a compilation failure: no pattern found for %{cc}
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

Parameters:

- `key`: Nanosecond timestamp, such as the timestamp obtained from the `default_time(time)` function;
- `minute`: Allowed deviation from the current time in minutes (integer), range [0, 15], default value is 2 minutes.

Function description: Adjusts the input timestamp so that the difference between it and the function execution timestamp falls within (-60+minute, minute]. It is not suitable for data with time differences exceeding this range, as it may result in incorrect data. The calculation process is as follows:

1. Add hours to the key value to place it within the current hour;
2. Calculate the minute difference between the two timestamps. Both minute values range from [0, 60), with the difference ranging from (-60,0] and [0, 60);
3. If the difference is less than or equal to -60 + minute, add 1 hour; if greater than minute, subtract 1 hour;
4. Default minute value is 2, allowing the difference range to be (-58, 2]. If the current time is 11:10, and the log time is 3:12:00.001, the final result is 10:12:00.001; if the current time is 11:59:1.000, and the log time is 3:01:1.000, the final result is 12:01:1.000.

Example:

```json
# Input 1 
{
    "time":"11 Jul 2022 12:49:20.937", 
    "second":2,
    "third":"abc",
    "forth":true
