# Pipeline Data Processor Language Definition

---

Below is the definition of the Pipeline data processor language. As support for different syntaxes gradually increases, this document will undergo adjustments and additions to varying degrees.

## Basic Rules {#basic-syntax}

### Identifiers and Keywords {#identifier-and-keyword}

#### Identifiers {#identifier}

Identifiers are used to denote objects and can represent a variable, function, etc. Identifiers include keywords.

Custom identifiers must not conflict with the keywords of the Pipeline data processor language.

Identifiers can consist of digits (`0-9`), letters (`A-Z a-z`), and underscores (`_`), but the first character cannot be a digit and they are case-sensitive:

- `_abc`
- `abc`
- `abc1`
- `abc_1_`

If it is necessary to start with a letter or use characters outside those mentioned within an identifier, backticks should be used:

- `` `1abc` ``
- `` `@some-variable` ``
- `` `this-is-a-emoji-👍` ``

#### Special Identifiers {#special-identifier}

To maintain forward compatibility of Pipeline semantics, `_` is an alias for `message`.

#### Keywords {#keyword}

Keywords have special meanings, such as `if`, `elif`, `else`, `for`, `in`, `break`, `continue`, etc.

### Comments {#code-comments}

The `#` symbol is used for line comments; inline comments are not supported.

```python
# This is a comment line
a = 1 # This is a comment line

"""
This is a (multi-line) string replacing comments
"""
a = 2

"String"
a = 3
```

### Data Types {#data-type}

In the DataKit Pipeline's data processing language, the type of a variable's value can dynamically change, but each value has its own data type. It can be one of the **basic types** or a **composite type**

#### Basic Types {#basic-type}

##### Integer Type {#int}

Integer type length is 64-bit signed, currently only supporting decimal integer literals, such as `-1`, `0`, `1`, `+19`

##### Floating Point Type {#float}

Floating point type length is 64-bit signed, currently only supporting decimal floating-point literals, such as `-1.00001`, `0.0`, `1.0`, `+19.0`

##### Boolean Type {#bool}

Boolean type values are only `true` and `false`

##### String Type {#str}

String values can be enclosed in double quotes or single quotes, and multi-line strings can be written using triple double quotes or triple single quotes

- Double quote string `"hello world"`
- Single quote string `'hello world'`
- Multi-line string

```python
"""hello
world"""
```

- Single quote form of multi-line string

```python
'''
hello
world
'''
```

##### Nil Type {#nil}

Nil is a special data type indicating null. When a variable is used without being assigned a value, its value is nil.

#### Composite Types {#composite-type}

Dictionary types and list types differ from basic types in that multiple variables can reference the same map or list object. Assignment does not copy lists or dictionaries in memory but references them.

- Dictionary Type

Dictionary type is key-value structured, where only string types can serve as keys, and there are no restrictions on the value data type. Elements in the map can be read and written via index expressions:

```python
a = {
  "1": [1, "2", 3, nil],
  "2": 1.1,
  "abc": nil,
  "def": true
}

# Since a["1"] is a list, b just references the value of a["1"]
b = a["1"]

# At this point, this value of a also becomes 1.1
b[0] = 1.1
```

- List Type

List types can store any number of values of any type.
Elements in the list can be read and written via index expressions

```python
a = [1, "2", 3.0, false, nil, {"a": 1}]

a = a[0] # a == 1
```

## Quick Start {#quick-start}

- Configure Pipeline in DataKit, write the following Pipeline file, assuming it is named *nginx.p*. Save it in the *[Datakit installation directory]/pipeline* directory.

```python
# Assume the input is an Nginx log
# Note, scripts can add comments

grok(_, "some-grok-patterns")  # Extract grok from the input text
rename('client_ip', ip)        # Rename the ip field to client_ip
rename("network protocol", protocol)   # Rename the protocol field to "network protocol"

# Convert timestamp (like 1610967131) into RFC3339 date format: 2006-01-02T15:04:05Z07:00
datetime(access_time, "s", "RFC3339")

url_decode(request_url)      # Decode the HTTP request route into plain text

# When status_code is between 200 ~ 300, create a new field http_status = "HTTP_OK"
group_between(status_code, [200, 300], "HTTP_OK", "http_status")

# Discard original content
drop_origin_data()
```

<!-- markdownlint-disable MD046 -->
???+ warning "Note"

    During parsing, avoid [possible conflicts with tag keys](./use-pipeline/pipeline-quick-start.md#naming).
<!-- markdownlint-enable -->

- Configure the corresponding collector to use the above Pipeline

Taking the logging collector as an example, configure the `pipeline_path` field, note that here configured is the script name of the pipeline, not the path. All referenced pipeline scripts must be stored in the `<DataKit installation directory/pipeline>` directory:

```python
[[inputs.logging]]
    logfiles = ["/path/to/nginx/log"]

    # required
    source = "nginx"

    # All scripts must be placed in /path/to/datakit/pipeline directory
    # If gitrepos feature is enabled, then files with the same name in gitrepos take precedence
    # If the pipeline is not configured, it looks for a script with the same name as the source
    # in the pipeline directory (e.g., nginx -> nginx.p) as the default pipeline configuration
    pipeline = "nginx.p"

    ... # other configurations
```

Restart the collector to parse the corresponding logs.

<!-- markdownlint-disable MD046 -->
???+ abstract

    For details on writing, debugging, and precautions for Pipeline scripts, see [How to Write Pipeline Scripts](./use-pipeline/pipeline-quick-start.md).
<!-- markdownlint-enable -->

## Grok Pattern Categories {#grok}

Grok patterns in DataKit can be divided into two categories:

- Global Patterns: Pattern files under the *pattern* directory are global patterns, available to all Pipeline scripts;
- Local Patterns: Patterns added in Pipeline scripts through the [add_pattern()](pipeline.md#fn-add-pattern) function are local patterns, effective only for the current Pipeline script.

Using Nginx access-log as an example, let's illustrate how to write corresponding grok patterns. Original nginx access log:

```log
127.0.0.1 - - [26/May/2022:20:53:52 +0800] "GET /server_status HTTP/1.1" 404 134 "-" "Go-http-client/1.1"
```

Assuming we need to extract client_ip, time (request), http_method, http_url, http_version, status_code from this access log, the initial grok pattern can be written as:

```python
grok(_,"%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

cast(status_code, "int")
group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)
default_time(time)
```

Further optimization by extracting features separately:

```python
# Log header including client_ip, http_ident, http_auth as a pattern
add_pattern("p1", "%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE}")

# Middle part including http_method, http_url, http_version, status_code as a pattern,
# and specify the data type int for status_code within the pattern instead of using cast function
add_pattern("p3", '"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}" %{INT:status_code:int}')

grok(_, "%{p1} \\[%{HTTPDATE:time}\\] %{p3} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)

default_time(time)
```

After optimization, compared to the initial single-line pattern, the readability is improved. Since grok-extracted fields default to string type, specifying the data type for fields avoids the need for subsequent use of the [cast()](pipeline.md#fn-cast) function for type conversion.

### Grok Composition {#grok-compose}

Essentially, grok predefines some regular expressions for text matching extraction and names these predefined regular expressions for easy use and nested reference expansion into countless new patterns. For example, DataKit has three built-in patterns as follows:

```python
_second (?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)    # Match seconds, _second is the pattern name
_minute (?:[0-5][0-9])                            # Match minutes, _minute is the pattern name
_hour (?:2[0123]|[01]?[0-9])                      # Match hours, _hour is the pattern name
```

Based on the above three built-in patterns, you can expand your own built-in pattern named `time`:

```python
# Add time to the pattern directory file, this pattern is a global pattern, which can be referenced anywhere
time ([^0-9]?)%{hour:hour}:%{minute:minute}(?::%{second:second})([^0-9]?)

# You can also add it to the pipeline file through add_pattern(), then this pattern becomes a local pattern, only usable by the current pipeline script
add_pattern(time, "([^0-9]?)%{HOUR:hour}:%{MINUTE:minute}(?::%{SECOND:second})([^0-9]?)")

# Extract the time field from the original input using grok. Assuming the input is 12:30:59, then {"hour": 12, "minute": 30, "second": 59} is extracted
grok(_, %{time})
```

<!-- markdownlint-disable MD046 -->
???+ warning "Note"

    - If there are same-named patterns, local patterns take precedence (i.e., local patterns override global patterns);
    - In Pipeline scripts, [add_pattern()](pipeline.md#fn-add-pattern) must be called before [grok()](pipeline.md#fn-grok) functions, otherwise it will cause the first data extraction to fail.
<!-- markdownlint-enable -->

### Built-in Pattern List {#builtin-patterns}

DataKit comes with some commonly used patterns, which can be directly used when cutting with Grok:

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

## if/else Branch {#if-else}

Pipeline supports `if/elif/else` syntax, where the statement after `if` only supports conditional expressions, i.e., `<`, `<=`, `==`, `>`, `>=`, and `!=`, and supports parentheses priority and multiple conditional expressions connected by `AND` and `OR`.

Expressions on both sides can be existing keys or fixed values (numbers, booleans, strings, and nil), for example:

```python
# Numeric comparison
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
add_key(name, "Zhang San")

if name == "Outlaw Rogue" {
  # This is impossible, do not defame me
}
```

Similar to most programming/script languages, the execution order is determined based on whether the conditions of `if/elif` are met.

Note: If performing numeric comparisons, use `cast()` for type conversion first, for example:

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
Allows iterating over maps, lists, and strings using for, and loop control can be performed using `continue` and `break`

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

The search priority for Pipeline directories is:

1. Remote Pipeline directory
2. Git-managed *pipeline* directory
3. Built-in *pipeline* directory

Search starts from 1 to 3, returning immediately upon match.

Absolute paths are not allowed.

### Remote Pipeline Directory {#remote-pl}

Under the `pipeline_remote` directory below the Datakit installation directory, the directory structure is shown as follows:

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

Under the *pipeline* directory in the *gitrepos* directory, the directory structure is shown above.

### Built-in Pipeline Directory {#internal-pl}

Under the *pipeline* directory in the Datakit installation directory, the directory structure is shown above.

## Input Data Structure for Scripts {#input-data}

All categories of data are encapsulated into the Point structure before being processed by the Pipeline script, roughly as follows:

``` not-set
struct Point {
    Name:    str
    Tags:    map[str]str
    Fields:  map[str]any
    Time:    int64
}
```

For example, an nginx log data, collected by the log collector, as input to the Pipeline script would look like:

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

Note:

- The `Name` can be modified using the `set_measurement()` function.

- For `Tags` and `Fields`, no key can appear simultaneously in both maps; keys in either can be read using custom identifiers or the `get_key()` function within the pipeline. Modifying the value of a key in `Tags` or `Fields` requires using other **built-in functions**. The **`_`** can be considered an alias for the `message` key.

- After script execution, if there is a key named `time` in `Tags` or `Fields`, it will be deleted; if its value is of type int64, it will be assigned to the Point's time and then deleted. If `time` is a string, you can attempt to use the `default_time()` function to convert it to int64.

## Script Functions {#functions}

Function parameter notes:

- Function parameters include anonymous parameters (`_`) representing the original input text data.
- JSON paths are expressed directly as `x.y.z` without additional decoration. For instance, given `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`, the JSON path `a.third` indicates the target data `abc`.
- The relative order of all function parameters is fixed, and the engine checks this specifically.
- All `key` parameters mentioned below refer to keys already initially extracted (via `grok()` or `json()`).
- Paths for processing JSON support identifier notation, not string literals. Use strings for creating new keys.

### `add_key()` {#fn-add-key}

Prototype: `fn add_key(key, value)`

Description: Adds a field to the point

Parameters:

- `key`: The name of the new key
- `value`: The value of the key

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

Prototype: `fn add_pattern(name: str, pattern: str)`

Description: Create a custom grok pattern. Grok patterns have scope limitations, such as generating new scopes within if else statements, making the pattern only valid within that scope. This function cannot overwrite grok patterns that already exist in the same or upper scope.

Parameters:

- `name`: Pattern name
- `pattern`: Custom pattern content

Example:

```python
# Input data："11,abc,end1", "22,abc,end1", "33,abc,end3"

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

Prototype: `fn adjust_timezone(key: int, minute: int)`

Parameters:

- `key`: Nanosecond timestamp, such as the timestamp obtained after processing with the `default_time(time)` function;
- `minute`: Allowed deviation in minutes (integer) from the current time (range [0, 15], default value 2 minutes).

Description: Adjusts the input timestamp so that the difference between it and the execution time of the function falls within (-60+minute, minute]. Not applicable to data with time differences exceeding this range, as it may lead to incorrect results. Calculation process:

1. Add several hours to the key value to place it within the current hour;
2. Calculate the minute difference between the two timestamps, where the minute ranges are [0, 60), resulting in a difference range of (-60,0] and [0, 60);
3. If the difference is less than or equal to -60 + minute, add 1 hour; if greater than minute, subtract 1 hour;
4. Default minute value is 2, allowing the difference range (-58, 2]. If the current time is 11:10, and the log time is 3:12:00.001, the final result is 10:12:00.001; if the current time is 11:59:1.000, and the log time is 3:01:1.000, the final result is 12:01:1.000.

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
json(_,```python
json(_, time)      # Extract the time field (if the container timezone is UTC+0000)
default_time(time) # Convert the extracted time field to a timestamp
                   # (parse without timezone data using local timezone UTC+0800/UTC+0900, etc.)
adjust_timezone(time)
                   # Automatically (re)select timezone, calibrate time deviation
```

Executing `datakit pipeline -P <name>.p -F <input_file_name>  --date`:

```json
# Output 1
{
  "message": "{\n    \"time\":\"11 Jul 2022 12:49:20.937\",\n    \"second\":2,\n    \"third\":\"abc\",\n    \"forth\":true\n}",
  "status": "unknown",
  "time": "2022-07-11T20:49:20.937+08:00"
}
```

Local time: `2022-07-11T20:55:10.521+08:00`

Using only `default_time` with the default local timezone (UTC+8) for parsing results in:

- Result of Input 1: `2022-07-11T12:49:20.937+08:00`

After using `adjust_timezone`, you get:

- Result of Input 1: `2022-07-11T20:49:20.937+08:00`


### `agg_create()` {#fn-agg-create}

[:octicons-tag-24: Version-1.5.10](../datakit/changelog.md#cl-1.5.10)

Prototype: `fn agg_create(bucket: str, on_interval: str = "60s", on_count: int = 0, keep_value: bool = false, const_tags: map[string]string = nil)`

Description: Create a metrics set for aggregation, setting the aggregation period using `on_interval` or `on_count`. After aggregation, upload the aggregated data and choose whether to retain the last aggregation's data.

Parameters:

- `bucket`: String type, used as the name of the metrics set created by this function. If the bucket has already been created, no operation is performed;
- `on_interval`: Default value `"60s"`, sets the aggregation period based on time, unit `s`, effective when greater than `0`; cannot be used simultaneously with `on_count` less than or equal to `0`;
- `on_count`: Default value `0`, sets the aggregation period based on the number of processed points, effective when greater than `0`;
- `keep_value`: Default value `false`;
- `const_tags`: Custom tags, default empty.

Example:

```python
agg_create("cpu_agg_info", on_interval = "30s")
```


### `agg_metric()` {#fn-agg-metric}

[:octicons-tag-24: Version-1.5.10](../datakit/changelog.md#cl-1.5.10)

Prototype: `fn agg_metric(bucket: str, new_field: str, agg_fn: str, agg_by: []string, agg_field: str)`

Description: Automatically takes values from fields in the input data and uses them as tags for the aggregated data, storing these aggregated data in the corresponding bucket.

Parameters:

- `bucket`: String type, refers to the bucket of the metrics set created by the `agg_create` function. If the bucket hasn't been created, no operation is performed;
- `new_field`: The metric name in the aggregated data, whose value type is `float`;
- `agg_fn`: Aggregation function, can be one of `"avg"`,`"sum"`,`"min"`,`"max"`,`"set"`;
- `agg_by`: Field names from the input data that will serve as tags for the aggregated data; these fields' values must be string types;
- `agg_field`: Field name from the input data, automatically fetches field values for aggregation.

Example:

For log category data:

Multiple input logs:

``` not-set
1
```

``` not-set
2
```

``` not-set
3
```

Script:

```python
agg_create("cpu_agg_info", interval=10, const_tags={"tag1":"value_user_define_tag"})

set_tag("tag1", "value1")

field1 = _

cast(field1, "int")

agg_metric("cpu_agg_info", "agg_field_1", "sum", ["tag1", "host"], "field1")
```

Metrics output:

``` not-set
{
    "host": "your_hostname",
    "tag1": "value1",
    "agg_field_1": 6,
}
```


### `append()` {#fn-append}

Prototype: `fn append(arr, elem) arr`

Description: Appends element `elem` to the end of array `arr`.

Parameters:

- `arr`: The array to which elements are added.
- `elem`: The element to add.

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

Prototype: `fn b64dec(key: str)`

Description: Decodes the string data obtained from the specified field using base64.

Parameter:

- `key`: Target field

Example:

```python
# Input data {"str": "aGVsbG8sIHdvcmxk"}
json(_, `str`)
b64dec(`str`)

# Processing result
# {
#   "str": "hello, world"
# }
```


### `b64enc()` {#fn-b64enc}

Prototype: `fn b64enc(key: str)`

Description: Encodes the string data obtained from the specified field using base64.

Parameter:

- `key`: Target field

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


### `cast()` {#fn-cast}

Prototype: `fn cast(key, dst_type: str)`

Description: Converts the key value to the specified type.

Parameters:

- `key`: An already extracted field;
- `type`: Target conversion type, supporting `\"str\", \"float\", \"int\", \"bool\"`, target type needs to be enclosed in double quotes in English mode.

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

Prototype: `fn cidr(ip: str, prefix: str) bool`

Description: Determines if an IP is within a CIDR block.

Parameters:

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


### `cover()` {#fn-cover}

Prototype: `fn cover(key: str, range: list)`

Description: Masks the specified field's string data according to the specified range.

Parameters:

- `key`: Target field;
- `range`: Masking string index range (`[start,end]`). Both start and end support negative indices, indicating counting backward from the end. Valid ranges are allowed, and if end exceeds the maximum length of the string, it defaults to the maximum length.

Example:

```python
# Input data {"str": "13789123014"}
json(_, `str`)
cover(`str`, [8, 9])

# Input data {"abc": "13789123014"}
json(_, abc)
cover(abc, [2, 4])
```


### `datetime()` {#fn-datetime}

[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)

Prototype: `fn datetime(key, precision: str, fmt: str, tz: str = "")`

Description: Converts timestamps into specified date formats.

Parameters:

- `key`: Already extracted timestamp;
- `precision`: Input timestamp precision (s, ms, us, ns);
- `fmt`: Date format, providing built-in date formats and supporting custom date formats;
- `tz`: Timezone (optional parameter), converts the timestamp to the specified timezone, defaulting to the host's timezone.

Built-in date formats:

| Built-in Format | Date                          | Description                      |
| ---             | ---                           | ---                              |
| "ANSI-C"        | "Mon Jan _2 15:04:05 2006"    |                                   |
| "UnixDate"      | "Mon Jan _2 15:04:05 MST 2006"|                                   |
| "RubyDate"      | "Mon Jan 02 15:04:05 -0700 2006" |                               |
| "RFC822"        | "02 Jan 06 15:04 MST"         |                                   |
| "RFC822Z"       | "02 Jan 06 15:04 -0700"      | RFC822 with numeric zone         |
| "RFC850"        | "Monday, 02-Jan-06 15:04:05 MST" |                               |
| "RFC1123"       | "Mon, 02 Jan 2006 15:04:05 MST" |                                |
| "RFC1123Z"      | "Mon, 02 Jan 2006 15:04:05 -0700" | RFC1123 with numeric zone      |
| "RFC3339"       | "2006-01-02T15:04:05Z07:00"  |                                   |
| "RFC3339Nano"   | "2006-01-02T15:04:05.999999999Z07:00" |                           |
| "Kitchen"       | "3:04PM"                      |                                   |

Custom date formats:

You can customize the output date format by combining placeholders

| Character | Example | Description                                                          |
| ---       | ---     | ---                                                                  |
| a         | %a      | Abbreviated weekday, like `Wed`                                      |
| A         | %A      | Full weekday, like `Wednesday`                                       |
| b         | %b      | Abbreviated month, like `Mar`                                        |
| B         | %B      | Full month, like `March`                                             |
| C         | %c      | Century number, current year divided by 100                           |
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
| **S**     | %S      | Second, range `[00, 60]`                                             |
| t         | %t      | Represents tab `\t`                                                  |
| u         | %u      | Weekday, Monday is 1, range `[1, 7]`                                 |
| w         | %w      | Weekday, Sunday is 0, range `[0, 6]`                                 |
| y         | %y      | Year, range `[00, 99]`                                               |
| **Y**     | %Y      | Decimal representation of the year                                   |
| **z**     | %z      | RFC 822/ISO 8601:1988 style timezone (e.g., `-0600` or `+0100`)     |
| Z         | %Z      | Timezone abbreviation, like `CST`                                     |
| %         | %%      | Represents the character `%`                                         |

Example:

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

Prototype: `fn decode(text: str, text_encode: str)`

Description: Converts `text` to UTF8 encoding to handle non-UTF8 encoded original logs. Currently supports utf-16le/utf-16be/gbk/gb18030 (these encoding names should be lowercase).

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```


### `default_time()` {#fn-defalt-time}

Prototype: `fn default_time(key: str, timezone: str = "")`

Description: Uses the specified field as the final data timestamp.

Parameters:

- `key`: Specified key, the data type of the key needs to be a string;
- `timezone`: Specifies the timezone for formatting the extracted time text, optional parameter, default is the current system timezone, timezone examples `+8/-8/+8:30`.

Supported date formats for processing data:

<!-- markdownlint-disable MD038 -->
| Date Format                                           | Date Format                                                | Date Format                                       | Date Format                          |
| -----                                                 | ----                                                       | ----                                              | ----                                 |
| `2014-04-26 17:24:37.3186369`                        | `May 8, 2009 5:57:51 PM`                                  | `2012-08-03 18:31:59.257000000`                  | `oct 7, 1970`                       |
| `2014-04-26 17:24:37.123`                            | `oct 7, '70`                                               | `2013-04-01 22:43`                               | `oct. 7, 1970`                      |
| `2013-04-01 22:43:22`                                | `oct. 7, 70`                                               | `2014-12-16 06:20:00 UTC`                        | `Mon Jan  2 15:04:05 2006`         |
| `2014-12-16 06:20:00 GMT`                            | `Mon Jan  2 15:04:05 MST 2006`                            | `2014-04-26 05:24:37 PM`                         | `Mon Jan 02 15:04:05 -0700 2006`   |
| `2014-04-26 13:13:43 +0800`                          | `Monday, 02-Jan-06 15:04:05 MST`                          | `2014-04-26 13:13:43 +0800 +08`                 | `Mon, 02 Jan 2006 15:04:05 MST`    |
| `2014-04-26 13:13:44 +09:00`                         | `Tue, 11 Jul 2017 16:28:13 +0200 (CEST)`                 | `2012-08-03 18:31:59.257000000 +0000 UTC`       | `Mon, 02 Jan 2006 15:04:05 -0700` |
| `2015-09-30 18:48:56.35272715 +0000 UTC`             | `Thu, 4 Jan 2018 17:53:36 +0000`                         | `2015-02-18 00:12:00 +0000 GMT`                  | `Mon 30 Sep 2018 09:09:09 PM UTC`  |
| `2015-02-18 00:12:00 +0000 UTC`                      | `Mon Aug 10 15:44:11 UTC+0100 2015`                      | `2015-02-08 03:02:00 +0300 MSK m=+0.000000001`  | `Thu, 4 Jan 2018 17:53:36 +0000`   |
| `2015-02-08 03:02:00.001 +0300 MSK m=+0.000000001`   | `Fri Jul 03 2015 18:04:07 GMT+0100 (GMT Daylight Time)`  | `2017-07-19 03:21:51+00:00`                     | `September 17, 2012 10:09am`       |
| `2014-04-26`                                          | `September 17, 2012 at 10:09am PST-08`                    | `2014-04`                                        | `September 17, 2012, 10:10:09`     |
| `2014`                                                | `2014:3:31`                                               | `2014-05-11 08:20:13,787`                       | `2014:03:31`                       |
| `3.31.2014`                                          | `2014:4:8 22:05`                                          | `03.31.2014`                                     | `2014:04:08 22:05`                 |
| `08.21.71`                                           | `2014:04:2 03:00:51`                                      | `2014.03`                                        | `2014:4:02 03:00:51`              |
| `2014.03.30`                                         | `2012:03:19 10:11:59`                                     | `20140601`                                       | `2012:03:19 10:11:59.3186369`     |
| `20140722105203`                                     | `2014 年 04 月 08 日 `                                    | `1332151919`                                     | `2006-01-02T15:04:05+0000`        |
| `1384216367189`                                      | `2009-08-12T22:15:09-07:00`                               | `1384216367111222`                               | `2009-08-12T22:15:09`             |
| `1384216367111222333`                               | `2009-08-12T22:15:09Z`                                    |
<!-- markdownlint-enable -->

JSON extraction example:

```python
# Original JSON
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

# For logging collected data, it's best to rename the time field to `time`, otherwise the logging collector will fill with the current time
rename("time", log_time)

# Processing result
{
  "time": 1610358231887000000,
}
```



### `delete()` {#fn-delete}
[:octicons-tag-24: Version-1.5.8](../datakit/changelog.md#cl-1.5.8)

Prototype: `fn delete(src: map[string]any, key: str)`

Description: Deletes a key from the JSON map.

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

Prototype: `fn drop()`

Description: Discards the entire log, preventing it from being uploaded.

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

Prototype: `fn drop_key(key)`

Description: Deletes an already extracted field.

Parameter:

- `key`: Name of the field to be deleted

Example:

```python
# data = `{\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}`

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

Prototype: `fn drop_origin_data()`

Description: Discards the initial text, otherwise the initial text is placed in the message field.

Example:

```python
# Input data: {"age": 17, "name": "zhangsan", "height": 180}

# Remove the content of the message field from the result set
drop_origin_data()
```



### `duration_precision()` {#fn-duration-precision}

Prototype: `fn duration_precision(key, old_precision: str, new_precision: str)`

Description: Converts the precision of a duration, specifying the current and target precisions. Supports conversions between s, ms, us, ns.

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

Prototype: `fn exit()`

Description: Ends the parsing of the current log line. If the `drop()` function has not been called, it still outputs the parsed parts.

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



### `geoip()` {#fn-geoip}

Prototype: `fn geoip(ip: str)`

Description: Appends more IP information to the IP. `geoip()` adds multiple fields such as:

- `isp`: Internet Service Provider
- `city`: City
- `province`: Province
- `country`: Country

Parameter:

- `ip`: An already extracted IP field, supporting both IPv4 and IPv6.

Example:

```python
# Input data: {"ip":"1.2.3.4"}

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

Prototype: `fn get_key(key)`

Description: Reads the value of the key from the input point, rather than the value of the variable on the stack.

Parameter:

- `key_name`: Name of the key.

Example:

```python
add_key("city", "shanghai")

# Here you can directly access the value of the same-named key in the point via city
if city == "shanghai" {
  add_key("city_1", city)
}

# Due to right associativity in assignment, it first retrieves the value of the "city" key,
# then creates a variable named city
city = city + " --- ningbo" + " --- " +
    "hangzhou" + " --- suzhou ---" + ""

# get_key retrieves the value of "city" from the point
# If there is a variable named city, it prevents direct retrieval from the point
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


### `grok()` {#fn-grok}

Prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Description: Extracts content from the text string `input` using `pattern`. Returns true if `pattern` matches `input` successfully, otherwise returns false.

Parameters:

- `input`: Text to extract, can be raw text (`_`) or an already extracted `key`;
- `pattern`: Grok expression, supports specifying key data types: bool, float, int, string (corresponding to ppl's str, also writable as str), default is string;
- `trim_space`: Removes leading and trailing whitespace from extracted characters, default value is true.

```python
grok(_, pattern)    # Directly uses the input text as the raw data
grok(key, pattern)  # Re-performs grok on an already extracted `key`
```

Example:

```python
# Input data："12/01/2021 21:13:14.123"

# Pipeline script
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)")

grok_match_ok = grok(_, "%{DATE_US:date} %{time}")

add_key(grok_match_ok)

# Processing result
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

Prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Description: If the value of `key` falls within the specified range `between` (note: it can only be a single range, such as `[0,100]`), then a new field can be created and assigned a new value. If no new field is provided, it overwrites the original field value.

Example one:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the value of the `http_status` field is within the specified range, change its value to "OK"
group_between(http_status, [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example two:

```python
# Input data: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the value of the `http_status` field is within the specified range, create a new `status` field with the value "OK"
group_between(http_status, [200, 300], "OK", status)

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```


### `group_in()` {#fn-group-in}

Prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new-key = "")`

Description: If the value of `key` is in the list `in`, then a new field can be created and assigned a new value. If no new field is provided, it overwrites the original field value.

Example:

```python
# If the value of the `log_level` field is in the list, change its value to "OK"
group_in(log_level, ["info", "debug"], "OK")

# If the value of the `http_status` field is in the specified list, create a new `status` field with the value "not-ok"
group_in(log_level, ["error", "panic"], "not-ok", status)
```


### `json()` {#fn-json}

Prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Description: Extracts specified fields from JSON and can rename them into new fields.

Parameters:

- `input`: JSON to extract, can be raw text (`_`) or an already extracted `key`;
- `json_path`: JSON path information;
- `newkey`: Extracted data written to the new key;
- `trim_space`: Removes leading and trailing whitespace from extracted characters, default value is `true`;
- `delete_after_extract`: Deletes the current object after extraction and rewrites the extracted object back after re-serialization; only applicable to deleting keys and values in maps, not for deleting list elements; default value is `false`, no operations are performed [:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7).

```python
# Directly extracts the `x.y` field from the original input JSON and can rename it into a new field `abc`
json(_, x.y, abc)

# Extracts `x.y` again from an already extracted `key`, with the extracted field named `x.y`
json(key, x.y) 
```

Example one:

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
  "message":```python
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "name": "zhangsan",
  "zhangsan": "{\"age\":17,\"height\":180,\"name\":\"zhangsan\"}"
}
```

Example two:

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
json(_, name) json(name, first)
```

Example three:

```python
# Input data:
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# Processing script for JSON array:
json(_, [0].nets[-1])
```

Example four:

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

Example five:

```python
# Input data:
{"item": " not_space ", "item2":{"item3": [123]}}

# Processing script:
# If attempting to delete list elements will fail the script check
json(_, item2.item3[0], item, true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```


### `kv_split()` {#fn-kv_split}

[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)

Prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Description: Extracts all key-value pairs from a string.

Parameters:

- `key`: Key name;
- `include_keys`: List of key names to include, only extracts keys within this list; **default value is `[]`, no keys are extracted**;
- `field_split_pattern`: String delimiter used to extract all key-value pairs via regex; default value is `" "` (space);
- `value_split_pattern`: Delimiter used to split keys and values from the key-value pair string, non-recursive; default value is `"="`;
- `trim_key`: Removes leading and trailing specified characters from the extracted key; default value is `""` (empty string);
- `trim_value`: Removes leading and trailing specified characters from the extracted value; default value is `""` (empty string);
- `prefix`: Adds a prefix string to all keys.

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
```


### `len()` {#fn-len}

Prototype: `fn len(val: str|map|list) int`

Description: Calculates the byte count of a string, or the number of elements in a map or list.

Parameter:

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
# Result
{
  "abc": 1,
}
```


### `load_json()` {#fn-load_JSON}

Prototype: `fn load_json(val: str) nil|bool|float|map|list`

Description: Converts a JSON string into one of the types: map, list, nil, bool, float, allowing access and modification of values using index expressions.

Parameter:

- `val`: Must be a string type data.

Example:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key(abc, abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to sync stack data to point
add_key(abc, abc["a"]["first"][-1])

add_key(len_abc, len(abc))

add_key(len_abc, len(load_json(abc["a"]["ff"])))
```


### `lowercase()` {#fn-lowercase}

Prototype: `fn lowercase(key: str)`

Description: Converts the content of the extracted key to lowercase.

Parameter:

- `key`: The name of the extracted field to be converted.

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

Prototype: `fn match(pattern: str, s: str) bool`

Description: Matches a string with a specified regular expression, returning true if it matches successfully, otherwise false.

Parameters:

- `pattern`: Regular expression;
- `s`: String to be matched.

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

Prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Description: Queries an external reference table using multiple keys and appends the first row of the query results as fields.

Parameters:

- `table_name`: Name of the table to be queried;
- `keys`: List of column names;
- `values`: Corresponding values for each column.

Example:

```python
json(_, table)
json(_, key)
json(_, value)

# Query and append the current column's data, which defaults to being added as a field
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

Prototype: `fn nullif(key, value)`

Description: If the content of the specified field `key` equals the value `value`, then deletes this field.

Parameters:

- `key`: Specified field;
- `value`: Target value.

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

> Note: This functionality can also be achieved using `if/else` semantics:

```python
if first == "1" {
    drop_key(first)
}
```



### `parse_date()` {#fn-parse-date}

Prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Description: Converts the provided parts of the date field into a timestamp.

Parameters:

- `key`: New inserted field
- `yy` : Year digits string, supports four or two-digit numbers, empty string means taking the current year when processing
- `MM`: Month string, supports numbers, English words, abbreviated English words
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
parse_date(aa, "2021", "May", "12", "10", "10", "34", "", "Asia/Shanghai") # Result aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "", "Asia/Shanghai") # Result aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", "Asia/Shanghai") # Result aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", "", "+8") # Result aa=1581473434000000000
```


### `parse_duration()` {#fn-parse-duration}

Prototype: `fn parse_duration(key: str)`

Description: If the value of `key` is a golang duration string (e.g., `123ms`), automatically parses `key` into an integer in nanoseconds.

Currently, golang supports the following duration units:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Parameter:

- `key`: Field to be parsed

Example:

```python
# Assuming abc = "3.5s"
parse_duration(abc) # Result abc = 3500000000

# Supports negative numbers: abc = "-3.5s"
parse_duration(abc) # Result abc = -3500000000

# Supports floating-point numbers: abc = "-2.3s"
parse_duration(abc) # Result abc = -2300000000
```



### `query_refer_table()` {#fn-query-refer-table}

Prototype: `fn query_refer_table(table_name: str, key: str, value)`

Description: Queries an external reference table using the specified key and appends the first row of the query results as fields.

Parameters:

- `table_name`: Name of the table to be queried
- `key`: Column name
- `value`: Value corresponding to the column

Example:

```python
# Extract table name, column name, and column value from input
json(_, table)
json(_, key)
json(_, value)

# Query and append the current column's data, which defaults to being added as a field
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

Prototype: `fn rename(new_key, old_key)`

Description: Renames an already extracted field.

Parameters:

- `new_key`: New field name
- `old_key`: Already extracted field name

Example:

```python
# Rename the already extracted abc field to abc1
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

Prototype: `fn replace(key: str, regex: str, replace_str: str)`

Description: Replaces content in the specified field according to a regex pattern.

Parameters:

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

Prototype: `fn sample(p)`

Description: Selects to collect/discard data based on probability p.

Parameter:

- `p`: Probability that the `sample` function returns true, ranging from [0, 1]

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, i.e., returns true with a 30% probability, here discarding 70% of the data
  drop() # Mark this data for discard
  exit() # Exit subsequent processing flow
}
```


### `set_measurement()` {#fn-set-measurement}

Prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Description: Changes the name of the line protocol.

Parameters:

- `name`: Value as measurement name, can accept string literals or variables;
- `delete_key`: If there is a tag or field with the same name as the variable in the point, it will be deleted.

Mapping relationship between line protocol name and various data storage fields or other uses:

| Category          | Field Name | Other Uses |
| ---              | ---        | ---       |
| custom_object     | class      | -         |
| keyevent          | -          | -         |
| logging           | source     | -         |
| metric            | -          | Metric Set Name |
| network           | source     | -         |
| object            | class      | -         |
| profiling         | source     | -         |
| rum               | source     | -         |
| security          | rule       | -         |
| tracing           | source     | -         |


### `set_tag()` {#fn-set-tag}

Prototype: `fn set_tag(key, value: str)`

Description: Marks the specified field as a tag output. After setting as a tag, other functions can still operate on this variable. If the key marked as a tag is already extracted as a field, it will not appear in the field, preventing conflicts with existing tag keys.

Parameters:

- `key`: Field to be marked as a tag;
- `value`: Can be a string literal or variable.

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
# * Character `#` is just a marker indicating the field is a tag when using `datakit --pl <path> --txt <str>`

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

Prototype: `fn sql_cover(sql_test: str)`

Description: Masks SQL statements.

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```


### `strfmt()` {#fn-strfmt}

Prototype: `fn strfmt(key, fmt: str, args ...: int|float|bool|str|list|map|nil)`

Description: Formats the content of the specified fields `arg1, arg2, ...` according to `fmt` and writes the formatted content into the `key` field.

Parameters:

- `key`: Specifies the field name where the formatted data is written;
- `fmt`: Format string template;
- `args`: Variable arguments, can be multiple extracted fields to be formatted.

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

Prototype: `fn timestamp(precision: str = "ns") -> int`

Description: Returns the current Unix timestamp, default precision is ns.

Parameter:

- `precision`: Timestamp precision, options are "ns", "us", "ms", "s", default value is "ns".

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

Prototype: `fn trim(key, cutset: str = "")`

Description: Removes specified characters from the beginning and end of `key`. When `cutset` is an empty string, it defaults to removing all whitespace.

Parameters:

- `key`: An already extracted field of string type;
- `cutset`: Characters to remove from the beginning and end of `key`.

Example:

```python
# Input data："trim(key, cutset)"

# Processing script
add_key(test_data, "ACCAA_test_DataA_ACBA")
trim(test_data, "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```


### `uppercase()` {#fn-uppercase}

Prototype: `fn uppercase(key: str)`

Description: Converts the content of the extracted key to uppercase.

Parameter:

- `key`: The name of the already extracted field to be converted, converting its content to uppercase.

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

Prototype: `fn url_decode(key: str)`

Description: Decodes the URL in the extracted `key` into plain text.

Parameter:

- `key`: An already extracted `key`

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

Prototype: `fn url_parse(key)`

Description: Parses the URL in the field named `key`.

Parameter:

- `key`: Field name of the URL to be parsed.

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

The above example extracts the scheme from the URL. Additionally, you can extract host, port, path, and parameters carried in the URL as shown below:

```python
# Input data: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, url)
m = url_parse(url)
add_key(sclient, m["params"]["sclient"])    # Parameters carried in the URL are stored under the params field
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

Prototype: `fn use(name: str)`

Parameter:

- `name`: Script name, such as abp.p

Description: Calls another script, allowing access to all current data in the called script.
Example:

```python
# Input data: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

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

Prototype: `fn user_agent(key: str)`

Description: Extracts client information from the specified field.

Parameter:

- `key`: Target field

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


### `xml()` {#fn-xml}

Prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Description: Extracts fields from XML using XPath expressions.

Parameters:

- `input`: XML to be extracted;
- `xpath_expr`: XPath expression;
- `key_name`: Extracted data written to the new key.

Example one:

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

Example two:

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