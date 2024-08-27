
# Pipeline Syntax

---

The following defines the syntax of the Pipeline data processing language. As different syntaxes are progressively supported, this document will be adjusted and updated to varying degrees.

## Basic Rules {#basic-syntax}

### Identifiers and Keywords {#identifier-and-keyword}

#### Identifiers {#identifier}

Identifiers are used to identify objects and can represent variables, functions, etc. Identifiers include keywords.

Custom identifiers must not duplicate the keywords of the Pipeline data processing language.

Identifiers can be composed of numbers (`0-9`), letters (`A-Z a-z`), and underscores (`_`), but the first character cannot be a number and are case-sensitive:

- `_abc`
- `abc`
- `abc1`
- `abc_1_`

If you need to start with a letter or use characters other than the above, you must use backticks:

- `` `1abc` ``
- `` `@some-variable` ``
- `` `this-is-a-emoji-👍` ``

#### Special Identifier {#special-identifier}

To maintain forward compatibility of Pipeline semantics, `_` is an alias for `message`.

#### Keywords {#keyword}

Keywords are words with special meanings, such as `if`, `elif`, `else`, `for`, `in`, `break`, `continue`, etc.

### Comments {#code-comments}

The `#` character is used for line comments; inline comments are not supported.

```python
# This is a single-line comment
a = 1 # This is a single-line comment

"""
This is a (multi-line) string, used to replace comments
"""
a = 2

"string"
a = 3
```

### Data Types {#data-type}

In the DataKit Pipeline data processing language, the value of a variable can dynamically change, but each value has its data type, which can be one of the **basic types** or a **composite type**.

#### Basic Types {#basic-type}

##### Integer {#int}

The integer type is 64-bit long, signed, and currently only supports writing integer literals in decimal form, such as `-1`, `0`, `1`, `+19`.

##### Floating Point {#float}

The floating-point type is 64-bit long, signed, and currently only supports writing floating-point literals in decimal form, such as `-1.00001`, `0.0`, `1.0`, `+19.0`.

##### Boolean {#bool}

The boolean type has only two values: `true` and `false`.

##### String {#str}

String values can be enclosed in double or single quotes, and multi-line strings can be written by enclosing the content in triple double or single quotes.

- Double-quoted string `"hello world"`
- Single-quoted string `'hello world'`
- Multi-line string

```python
"""
hello
world
"""
```

- Single-quoted multi-line string

```python
'''
hello
world
'''
```

##### Nil {#nil}

Nil is a special data type representing null. When a variable is used without being assigned, its value is nil.

#### Composite Types {#composite-type}

Dictionary and list types differ from basic types in that multiple variables can point to the same map or list object. When assigning, no memory copy of the list or dictionary is performed; instead, a reference is made.

- Dictionary Type

The dictionary type is a key-value structure, where only string types can be used as keys, and there is no restriction on the data type of the value. Its elements in the map can be read and written through index expressions:

```python
a = {
  "1": [1, "2", 3, nil],
  "2": 1.1,
  "abc": nil,
  "def": true
}

# Since a["1"] is a list, b is just a reference to the value of a["1"]
b = a["1"]

# Now the value of a also becomes 1.1
b[0] = 1.1
```

- List Type

The list type can store any number of values of any type in the list. Its elements in the list can be read and written through index expressions.

```python
a = [1, "2", 3.0, false, nil, {"a": 1}]

a = a[0] # a == 1
```

## Quick Start {#quick-start}

- Configure Pipeline in DataKit by writing a Pipeline file as follows, assuming it is named *nginx.p*. Store it in the *[Datakit Installation Directory]/pipeline* directory.

```python
# Assume the input is an Nginx log
# Note that scripts can have comments

grok(_, "some-grok-patterns")  # Extract using grok on the input text
rename('client_ip', ip)        # Rename the ip field to client_ip
rename("network protocol", protocol)   # Rename the protocol field to "Network Protocol"

# Convert the timestamp (e.g., 1610967131) to RFC3339 date format: 2006-01-02T15:04:05Z07:00
datetime(access_time, "s", "RFC3339")

url_decode(request_url)      # Translate the HTTP request route into plain text

# When the status_code is between 200 and 300, create a new field http_status = "HTTP_OK"
group_between(status_code, [200, 300], "HTTP_OK", "http_status")

# Discard the original content
drop_origin_data()
```

<!-- markdownlint-disable MD046 -->
???+ warning "Note"

    During the cutting process, avoid [potential issues with tag key naming conflicts](./use-pipeline/pipeline-quick-start.md#naming).
<!-- markdownlint-enable -->

- Configure the corresponding collector to use the above Pipeline.

Take the logging collector as an example, and configure the `pipeline_path` field. Note that the configuration is the name of the pipeline script, not the path. All referenced pipeline scripts must be stored in the `<DataKit Installation Directory>/pipeline` directory:

```python
[[inputs.logging]]
    logfiles = ["/path/to/nginx/log"]

    # required
    source = "nginx"

    # All scripts must be placed in the /path/to/datakit/pipeline directory
    # If the gitrepos feature is enabled, the file with the same name in gitrepos will be used first
    # If the pipeline is not configured, look for a script with the same name as the source in the pipeline directory (e.g., nginx -> nginx.p) as the default pipeline configuration
    pipeline = "nginx.p"

    ... # Other configurations
```

Restart the collector to cut the corresponding logs.

<!-- markdownlint-disable MD046 -->
???+ abstract

    For information on writing, debugging, and notes on Pipeline, see [How to Write Pipeline Scripts](./use-pipeline/pipeline-quick-start.md).
<!-- markdownlint-enable -->

## Grok Pattern Classification {#grok}

In DataKit, grok patterns can be divided into two categories:

- Global Patterns: Pattern files under the *pattern* directory are global patterns that can be used in all Pipeline scripts;
- Local Patterns: Patterns added in the Pipeline script through the [add_pattern()](pipeline.md#fn-add-pattern) function are local patterns, which are only effective for the current Pipeline script.

The following uses the Nginx access-log as an example to illustrate how to write the corresponding grok. The original Nginx access log is as follows:

```log
127.0.0.1 - - [26/May/2022:20:53:52 +0800] "GET /server_status HTTP/1.1" 404 134 "-" "Go-http-client/1.1"
```

Assuming we need to extract client_ip, time (request), http_method, http_url, http_version, and status_code from this access log, the initial grok pattern can be written as:

```python
grok(_,"%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

cast(status_code, "int")
group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)
default_time(time)
```

Optimize it a bit more by extracting the corresponding features:


```python
# The client_ip, http_ident, and http_auth at the beginning of the log constitute a pattern
add_pattern("p1", "%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE}")

# The http_method, http_url, http_version, and status_code in the middle constitute a pattern,
# and the data type of status_code is specified as int within the pattern to replace the cast function used later
add_pattern("p3", '"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}" %{INT:status_code:int}')

grok(_, "%{p1} \\[%{HTTPDATE:time}\\] %{p3} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

group_between(status_code, [200, 299], "OK", status)
group_between(status_code, [300, 399], "notice", status)
group_between(status_code, [400, 499], "warning", status)
group_between(status_code, [500, 599], "error", status)

default_time(time)
```

After optimization, the cutting is more readable compared to the initial single-line pattern. Since the fields parsed by grok default to string type, specifying the data type of the field here can avoid the subsequent use of the [cast()](pipeline.md#fn-cast) function for type conversion.

### Grok Composition {#grok-compose}

Grok essentially involves predefining regular expressions for text matching and extraction, and naming these predefined regular expressions for easy use and nested reference to expand into countless new patterns. For example, DataKit has the following three built-in patterns:

```python
_second (?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)    # Matches seconds, with _second as the pattern name
_minute (?:[0-5][0-9])                            # Matches minutes, with _minute as the pattern name
_hour (?:2[0123]|[01]?[0-9])                      # Matches hour, with _hour as the pattern name
```

Based on the three built-in patterns above, you can extend your own built-in pattern named `time`:

```python
# Add time to the pattern directory file, this pattern is a global pattern that can be referenced anywhere
time ([^0-9]?)%{hour:hour}:%{minute:minute}(?::%{second:second})([^0-9]?)

# You can also add it to the pipeline file through add_pattern(), making this pattern a local pattern, only usable by the current pipeline script
add_pattern(time, "([^0-9]?)%{HOUR:hour}:%{MINUTE:minute}(?::%{SECOND:second})([^0-9]?)")

# Extract the time field from the original input using grok. Assuming the input is 12:30:59, it will be extracted to {"hour": 12, "minute": 30, "second": 59}
grok(_, %{time})
```

<!-- markdownlint-disable MD046 -->
???+ warning "Note"

    - If there is a pattern with the same name, the local pattern takes precedence (i.e., the local pattern overrides the global pattern);
    - In the pipeline script, [add_pattern()](pipeline.md#fn-add-pattern) must be called before [grok()](pipeline.md#fn-grok), otherwise, it will cause the first data extraction to fail.
<!-- markdownlint-enable -->

### Built-in Pattern List {#builtin-patterns}

DataKit has built-in some commonly used Patterns that can be directly used when we use Grok for cutting:

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

```python
# The client_ip, http_ident, and http_auth at the beginning of the log form a pattern
add_pattern("p1", "%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE}")

# The http_method, http_url, http_version, and status_code in the middle form a pattern,
# and the data type of status_code is specified as int within the pattern to replace the cast function used later
add_pattern("p3", '"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}" %{INT:status_code:int}')

grok(_, "%{p1} \\[%{HTTPDATE:time}\\] %{p3} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

group_between(status_code, [200, 299], "OK", status)
group_between(status_code, [300, 399], "notice", status)
group_between(status_code, [400, 499], "warning", status)
group_between(status_code, [500, 599], "error", status)

default_time(time)
```

After optimization, the parsing is more readable than the initial single-line pattern. Since the fields parsed by grok default to the string type, specifying the data type of the field here can prevent the subsequent use of the [cast()](pipeline.md#fn-cast) function for type conversion.

### Grok Composition {#grok-compose}

Grok essentially involves predefining regular expressions for text matching and extraction, and naming these predefined regular expressions for easy use and nested reference to expand into countless new patterns. For example, DataKit has the following three built-in patterns:

```python
_second (?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)    # Matches seconds, with _second as the pattern name
_minute (?:[0-5][0-9])                            # Matches minutes, with _minute as the pattern name
_hour (?:2[0123]|[01]?[0-9])                      # Matches hour, with _hour as the pattern name
```

Based on the three built-in patterns above, you can extend your own built-in pattern named `time`:

```python
# Add time to the pattern directory file; this pattern is a global pattern that can be referenced anywhere
time ([^0-9]?)%{hour:hour}:%{minute:minute}(?::%{second:second})([^0-9]?)

# You can also add it to the pipeline file through add_pattern(), making this pattern a local pattern, only usable by the current pipeline script
add_pattern(time, "([^0-9]?)%{HOUR:hour}:%{MINUTE:minute}(?::%{SECOND:second})([^0-9]?)")

# Extract the time field from the original input using grok. Assuming the input is 12:30:59, it will be extracted to {"hour": 12, "minute": 30, "second": 59}
grok(_, %{time})
```

<!-- markdownlint-disable MD046 -->
???+ warning "Note"

    - If there is a pattern with the same name, the local pattern takes precedence (i.e., the local pattern overrides the global pattern);
    - In the pipeline script, [add_pattern()](pipeline.md#fn-add-pattern) must be called before [grok()](pipeline.md#fn-grok), otherwise, it will cause the first data extraction to fail.
<!-- markdownlint-enable -->

### Built-in Pattern List {#builtin-patterns}

DataKit has built-in some commonly used Patterns that can be directly used when we use Grok for parsing:

<!-- markdownlint-disable MD046 -->
???- "Built-in Patterns"

{
    "age": 17,
    "height": 180,
    "name": "zhangsan",
    "city": "shanghai"
}
```


### `add_pattern()` {#fn-add-pattern}

Function Prototype: `fn add_pattern(name: str, pattern: str)`

Function Description: Create a custom grok pattern. Grok patterns have scope limitations; for example, a new scope is created within if-else statements, and the pattern is only valid within this scope. This function cannot override existing grok patterns in the same or higher scope.

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

Function Prototype: `fn adjust_timezone(key: int, minute: int)`

Function Parameters:

- `key`: A nanosecond timestamp, such as the timestamp obtained after processing with the `default_time(time)` function.
- `minute`: The allowed deviation from the current time in minutes (an integer), with a range of [0, 15], and a default value of 2 minutes.

Function Description: It ensures that the difference between the input timestamp and the current time at the time of function execution is within (-60+minute, minute] minutes; it is not suitable for data with a time difference beyond this range, as it may result in incorrect data acquisition. The calculation process is as follows:

1. Add several hours to the value of key to place it within the current hour.
2. At this point, calculate the minute difference between the two, with both minute values ranging from [0, 60), and the difference range being (-60,0] and [0, 60).
3. If the difference is less than or equal to -60 + minute, add one hour; if greater than minute, subtract one hour.
4. The default value of minute is 2, allowing a difference range of (-58, 2]. For example, if the current time is 11:10 and the log time is 3:12:00.001, the final result will be 10:12:00.001; if the current time is 11:59:1.000 and the log time is 3:01:1.000, the final result will be 12:01:1.000.

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
                   # (parse with the local timezone UTC+0800/UTC+0900, etc., for data without a timezone)
adjust_timezone(time)
                   # Automatically (re)select the timezone and correct the time deviation
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

[:octicons-tag-24: Version-1.5.10](../datakit/changelog.md#cl-1.5.10)

Function Prototype: `fn agg_create(bucket: str, on_interval: str = "60s", on_count: int = 0, keep_value: bool = false, const_tags: map[string]string = nil)`

Function Description: Create a metric set for aggregation. Set the aggregation period by `on_interval` or `on_count`, and upload the aggregated data after aggregation. You can choose whether to retain the data from the last aggregation.

Function Parameters:

- `bucket`: A string that serves as the name of the aggregated metric set. If the bucket has already been created, the function will perform no operation.
- `on_interval`: The default value is `60s`, which sets the aggregation period by time in seconds. The parameter takes effect when the value is greater than `0`. It cannot be used simultaneously with `on_count` set to less than or equal to `0`.
- `on_count`: The default value is `0`, which sets the aggregation period by the number of processed points. The parameter takes effect when the value is greater than `0`.
- `keep_value`: The default value is `false`.
- `const_tags`: Custom tags, default is empty.

Example:


```python
agg_create("cpu_agg_info", on_interval = "30s")
```


### `agg_metric()` {#fn-agg-metric}

[:octicons-tag-24: Version-1.5.10](../datakit/changelog.md#cl-1.5.10)

Function Prototype: `fn agg_metric(bucket: str, new_field: str, agg_fn: str, agg_by: []string, agg_field: str)`

Function Description: Based on the names of the fields in the input data, automatically take values to serve as tags for aggregated data, and store this aggregated data in the corresponding bucket.

Function Parameters:

- `bucket`: A string that represents the bucket of the metric set created by the function `agg_create`. If the bucket has not been created, the function will not perform any operations.
- `new_field`: The name of the metric in the aggregated data, with the data type as `float`.
- `agg_fn`: The aggregation function, which can be one of `"avg"`, `"sum"`, `"min"`, `"max"`, `"set"`.
- `agg_by`: The names of the fields in the input data that will serve as tags for the aggregated data. The values of these fields must be of string type.
- `agg_field`: The name of the field in the input data, from which the values are automatically obtained for aggregation.

Example:

Taking log category data as an example:

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

Metric output:

``` not-set
{
    "host": "your_hostname",
    "tag1": "value1",
    "agg_field_1": 6,
}
```

### `append()` {#fn-append}

Function Prototype: `fn append(arr, elem) arr`

Function Description: Adds an element `elem` to the end of the array `arr`.

Parameters:

- `arr`: The array to which the element will be added.
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

Function Description: Decode the string data obtained from the specified field using base64.

Function Parameters:

- `key`: The field to be extracted.

Example:

```python
# Data to be processed {"str": "aGVsbG8sIHdvcmxk"}
json(_, `str`)
b64enc(`str`)

# Processing result
# {
#   "str": "hello, world"
# }
```

### `b64enc()` {#fn-b64enc}

Function Prototype: `fn b64enc(key: str)`

Function Description: Encodes the string data obtained from the specified field using base64.

Function Parameters:

- `key`: The field to be extracted.

Example:

```python
# Data to be processed {"str": "hello, world"}
json(_, `str`)
b64enc(`str`)

# Processing result
# {
#   "str": "aGVsbG8sIHdvcmxk"
# }
```

### `cast()` {#fn-cast}

Function Prototype: `fn cast(key, dst_type: str)`

Function Description: Convert the value of `key` to a specified type.

Function Parameters:

- `key`: A field that has been extracted.
- `dst_type`: The target type for conversion, supports `"str", "float", "int", "bool"`, and the target type must be enclosed in double quotes in English.

Example:

```python
# Data to be processed: {"first": 1,"second":2,"third":"aBC","forth":true}

# Processing script
json(_, first) 
cast(first, "str")

# Processing result
{
  "first": "1"
}
```

### `cidr()` {#fn-cidr}

Function Prototype: `fn cidr(ip: str, prefix: str) bool`

Function Description: Determine whether an IP address is within a specific CIDR block.

Function Parameters:

- `ip`: An IP address.
- `prefix`: An IP prefix, such as `192.0.2.1/24`.

Example:

```python
# Data to be processed:

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

Function Prototype: `fn cover(key: str, range: list)`

Function Description: The function performs data desensitization on the string data obtained from the specified field, based on the given range.

Function Parameters:

- `key`: The field to be extracted.
- `range`: The index range for desensitizing the string (`[start, end]`). Both `start` and `end` support negative indices, which represent a semantic of tracing back from the end of the string. The range can be any reasonable interval; if `end` is greater than the maximum length of the string, it will default to the maximum length.

Example:

```python
# Data to be processed {"str": "13789123014"}
json(_, "str")
cover("str", [8, 9])

# Data to be processed {"abc": "13789123014"}
json(_, "abc")
cover("abc", [2, 4])
```


### `datetime()` {#fn-datetime}

[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)

Function Prototype: `fn datetime(key, precision: str, fmt: str, tz: str = "")`

Function Description: Convert a timestamp into a specified date format.

Function Parameters:

- `key`: The extracted timestamp.
- `precision`: The precision of the input timestamp (s, ms, us, ns).
- `fmt`: The date format, which provides built-in date formats and supports custom date formats.
- `tz`: Timezone (optional parameter), converts the timestamp to the specified timezone, defaulting to the host's timezone.

Built-in Date Formats:

| Built-in Format | Example Date                         | Description |
| --------------- | ------------------------------------ | ----------- |
| "ANSI-C"        | "Mon Jan _2 15:04:05 2006"         |             |
| "UnixDate"      | "Mon Jan _2 15:04:05 MST 2006"      |             |
| "RubyDate"      | "Mon Jan 02 15:04:05 -0700 2006"   |             |
| "RFC822"        | "02 Jan 06 15:04 MST"              |             |
| "RFC822Z"       | "02 Jan 06 15:04 -0700"            | RFC822 with numeric zone |
| "RFC850"        | "Monday, 02-Jan-06 15:04:05 MST"   |             |
| "RFC1123"       | "Mon, 02 Jan 2006 15:04:05 MST"    |             |
| "RFC1123Z"      | "Mon, 02 Jan 2006 15:04:05 -0700"   | RFC1123 with numeric zone |
| "RFC3339"       | "2006-01-02T15:04:05Z07:00"        |             |
| "RFC3339Nano"   | "2006-01-02T15:04:05.999999999Z07:00" |             |
| "Kitchen"       | "3:04PM"                            |             |

Custom Date Format:

You can customize the output date format through a combination of placeholders.

| Character | Example | Description |
| --------- | ------- | ----------- |
| a          | %a      | Abbreviated weekday name, e.g., `Wed` |
| A          | %A      | Full weekday name, e.g., `Wednesday` |
| b          | %b      | Abbreviated month name, e.g., `Mar` |
| B          | %B      | Full month name, e.g., `March` |
| C          | %C      | Century (year / 100) |
| **d**      | %d      | Day of the month (01 to 31) |
| e          | %e      | Day of the month with a space as a filler (1 to 31) |
| **H**      | %H      | Hour in 24-hour format (00 to 23) |
| I          | %I      | Hour in 12-hour format (01 to 12) |
| j          | %j      | Day of the year (001 to 365) |
| k          | %k      | Hour in 24-hour format without leading zeros (0 to 23) |
| l          | %l      | Hour in 12-hour format without leading zeros (1 to 12), with a space as a filler |
| **m**      | %m      | Month (01 to 12) |
| **M**      | %M      | Minute (00 to 59) |
| n          | %n      | Newline character `\n` |
| p          | %p      | `AM` or `PM` |
| P          | %P      | `am` or `pm` |
| s          | %s      | Seconds since 1970-01-01 00:00:00 UTC |
| **S**      | %S      | Second (00 to 60) |
| t          | %t      | Tab character `\t` |
| u          | %u      | Day of the week (Monday as 1, Sunday as 7) |
| w          | %w      | Day of the week (Sunday as 0, Saturday as 6) |
| y          | %y      | Year (00 to 99) |
| **Y**      | %Y      | Year in decimal |
| **z**      | %z      | RFC 822/ISO 8601:1988 style timezone (e.g., `-0600` or `+0100`) |
| Z          | %Z      | Timezone abbreviation, e.g., `CST` |
| %          | %%      | Represents the character `%` |

Examples:

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

Function Description: Convert `text` into UTF-8 encoding to address issues with original logs not in UTF-8 encoding. Currently supported encodings are utf-16le/utf-16be/gbk/gb18030 (encoding names must be lowercase).

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```

### `default_time()` {#fn-defalt-time}

Function Prototype: `fn default_time(key: str, timezone: str = "")`

Function Description: Use the extracted field as the timestamp for the final data.

Function Parameters:

- `key`: The specified key must be of string type.
- `timezone`: Specify the timezone for the formatted time text, an optional parameter defaulting to the current system timezone, with timezone examples being `+8/-8/+8:30`.

The supported formatted times for the data to be processed include:

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

JSON Extraction Example:

```python
# Original JSON
{
    "time": "06/Jan/2017:16:16:37 +0000",
    "second": 2,
    "third": "abc",
    "forth": true
}

# Pipeline script
json(_, time)      # Extract the time field
default_time(time) # Convert the extracted time field into a timestamp

# Processing result
{
  "time": 1483719397000000000,
}
```

Text Extraction Example:

```python
# Original log text
2021-01-11T17:43:51.887+0800  DEBUG io  io/io.go:458  post cost 6.87021ms

# Pipeline script
grok(_, '%{TIMESTAMP_ISO8601:log_time}')   # Extract log time and name the field log_time
default_time(log_time)                     # Convert the extracted log_time field into a timestamp

# Processing result
{
  "log_time": 1610358231887000000,
}

# For data collected by the logging collector, it is best to name the time field as time, otherwise the logging collector will fill it with the current time
rename("time", log_time)

# Processing result
{
  "time": 1610358231887000000,
}
```

### `delete()` {#fn-delete}
[:octicons-tag-24: Version-1.5.8](../datakit/changelog.md#cl-1.5.8)

Function Prototype: `fn delete(src: map[string]any, key: str)`

Function Description: Delete the key in the JSON map.

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

Function Prototype: `fn drop()`

Function Description: Discard the entire log and do not upload it.

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

Function Prototype: `fn drop_key(key)`

Function Description: Delete the extracted field.

Function Parameters:

- `key`: The name of the field to be deleted

Example:

```python
# data = `{"age": 17, "name": "zhangsan", "height": 180}`

# processing script
json(_, age,)
json(_, name)
json(_, height)
drop_key(height)

# processing result
{
    "age": 17,
    "name": "zhangsan"
}
```

### `drop_origin_data()` {#fn-drop-origin-data}

Function Prototype: `fn drop_origin_data()`

Function Description: Discard the initial text, which would otherwise be placed in the message field.

Example:

```python
# Data to be processed: {"age": 17, "name": "zhangsan", "height": 180}

# Delete the message content in the result set
drop_origin_data()
```

### `duration_precision()` {#fn-duration-precision}

Function Prototype: `fn duration_precision(key, old_precision: str, new_precision: str)`

Function Description: Convert the precision of duration by specifying the current and target precisions. Supports conversion between s, ms, us, and ns.

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

Function Prototype: `fn exit()`

Function Description: Terminate the parsing of the current log entry. If the `drop()` function has not been called, the already parsed parts will still be output.

```python
# Input << {"str_a": "2", "str_b": "3"}
json(_, str_a)
if str_a == "2"{
  exit()
}
json(_, str_b)

# Extracted data (drop: false, cost: 48.233µs):
# {
#   "message": "{\"str_a\": \"2\", \"str_b\": \"3\"}",
#   "str_a": "2"
# }
```

### `geoip()` {#fn-geoip}

Function Prototype: `fn geoip(ip: str)`

Function Description: Append additional IP information to the IP address. The `geoip()` function will generate multiple fields, such as:

- `isp`: Internet Service Provider
- `city`: City
- `province`: Province
- `country`: Country

Parameters:

- `ip`: The extracted IP field, supports both IPv4 and IPv6.

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

Function Prototype: `fn get_key(key)`

Function Description: Read the value of the key from the input point, rather than the value of the variable on the stack.

Function Parameters:

- `key_name`: The name of the key.

Example:

```python
add_key("city", "shanghai")

# Here you can directly access the value of the key "city" in the point
if city == "shanghai" {
  add_key("city_1", city)
}

# Due to the right associativity of assignment, first get the value of the key "city",
# and then create a variable named city
city = city + " --- ningbo" + " --- " +
    "hangzhou" + " --- suzhou ---" + ""

# get_key retrieves the value of "city" from the point
# If there is a variable named city, it cannot be directly retrieved from the point
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

Function Prototype: `fn grok(input: str, pattern: str, trim_space: bool = true) bool`

Function Description: Extract content from the text string `input` using the `pattern`. Return true when the pattern matches the input, otherwise returns false.

Parameters:

- `input`: Text to be extracted, which can be the raw text (`_`) or a previously extracted `key`;
- `pattern`: Grok expression, which supports specifying the data type of the key: bool, float, int, string (corresponding to ppl's str, can also be written as str), with the default being string;
- `trim_space`: Delete the leading and trailing whitespace characters in the extracted text, with the default value being true.

```python
grok(_, pattern)    # Directly use the input text as the original data
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

Function Prototype: `fn group_between(key: int, between: list, new_value: int|float|bool|str|map|list|nil, new_key)`

Function Description: If the value of `key` is within the specified range `between` (note: only a single interval, such as `[0,100]`), a new field can be created and assigned a new value. If no new field is provided, the original field value will be overwritten.

Example 1:

```python
# Data to be processed: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the value of the field http_status is within the specified range, change its value to "OK"
group_between(http_status, [200, 300], "OK")

# Processing result
{
    "http_status": "OK"
}
```

Example 2:

```python
# Data to be processed: {"http_status": 200, "code": "success"}

json(_, http_status)

# If the value of the field http_status is within the specified range, create a new status field with the value "OK"
group_between(http_status, [200, 300], "OK", status)

# Processing result
{
    "http_status": 200,
    "status": "OK"
}
```

### `group_in()` {#fn-group-in}

Function Prototype: `fn group_in(key: int|float|bool|str, range: list, new_value: int|float|bool|str|map|list|nil, new-key = "")`

Function Description: If the value of `key` is in the list `in`, a new field can be created and assigned a new value. If no new field is provided, the original field value will be overwritten.

Example:

```python
# If the value of the field log_level is in the list, change its value to "OK"
group_in(log_level, ["info", "debug"], "OK")

# If the value of the field http_status is in the specified list, create a new status field with the value "not-ok"
group_in(log_level, ["error", "panic"], "not-ok", status)
```

### `json()` {#fn-json}

Function Prototype: `fn json(input: str, json_path, newkey, trim_space: bool = true, delete_after_extract = false)`

Function Description: Extract the specified field from JSON and can rename it to a new field.

Parameters:

- `input`: The JSON to be extracted, which can be the raw text (`_`) or a previously extracted `key`;
- `json_path`: The JSON path information;
- `newkey`: The new key for the extracted data;
- `trim_space`: Delete the leading and trailing whitespace characters in the extracted text, with the default value being `true`;
- `delete_after_extract`: Delete the current object after extraction, and rewrite the extracted object after reserializing; can only be applied to the deletion of map keys and values, not for deleting list elements; the default value is `false`, and no operation is performed[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)).

Directly extract the `x.y` field from the original input JSON and name it as a new field `abc`:

```python
# Direct extraction from the original JSON input
json(_, x.y, abc)

# For a key that has already been extracted, perform an extraction on `x.y` again, and the extracted field will be named `x.y`
json(key, x.y)
```

Example 1:

```python
# Data to be processed:
# {
#     "info": {"age": 17, "name": "zhangsan", "height": 180}
# }

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
# Data to be processed:
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
json(_, name) json(name, first)
```

Example 3:

```python
# Data to be processed:
# [
#     {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#     {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#     {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
# ]

# Processing script for JSON array:
json(_, [0].nets[-1])
```

Example 4:

```python
# Data to be processed:
# {
#     "item": " not_space ",
#     "item2": {"item3": [123]}
# }

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
# Data to be processed:
# {
#     "item": " not_space ",
#     "item2": {"item3": [123]}
# }

# Processing script:
# If attempting to delete a list element, the script check will fail
json(_, item2.item3[0], item, true, true)

# Local test command:
# datakit pipeline -P j2.p -T '{"item": " not_space ", "item2":{"item3": [123]}}'
# Error:
# [E] j2.p:1:37: does not support deleting elements in the list
```



### `kv_split()` {#fn-kv-split}

[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)

Function Prototype: `fn kv_split(key, field_split_pattern = " ", value_split_pattern = "=", trim_key = "", trim_value = "", include_keys = [], prefix = "") -> bool`

Function Description: Extract all key-value pairs from a string.

Parameters:

- `key`: The name of the key;
- `include_keys`: A list of key names to include, only keys in this list will be extracted; **default is []**, no key is extracted;
- `field_split_pattern`: The regular expression for string splitting to extract all key-value pairs; default is `" "`;
- `value_split_pattern`: Used to split the key and value from the key-value pair string, non-recursive; default is `"="`;
- `trim_key`: Remove all specified characters from the beginning and end of the extracted key; default is `""`;
- `trim_value`: Remove all specified characters from the beginning and end of the extracted value; default is `""`;
- `prefix`: Add a prefix string to all keys.

Examples:

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

Function Prototype: `fn len(val: str|map|list) int`

Function Description: Calculate the number of bytes in a string, and the number of elements in a map and list.

Parameters:

- `val`: Can be a map, list, or string.

Examples:

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

### `load_json()` {#fn-load_JSON}

Function Prototype: `fn load_json(val: str) nil|bool|float|map|list`

Function Description: Convert a JSON string into one of map, list, nil, bool, float, and retrieve and modify values through index expressions.

Parameters:

- `val`: Must be string type data.

Examples:

```python
# _: {"a":{"first": [2.2, 1.1], "ff": "[2.2, 1.1]","second":2,"third":"aBC","forth":true},"age":47}
abc = load_json(_)

add_key(abc, abc["a"]["first"][-1])

abc["a"]["first"][-1] = 11

# Need to synchronize the data on the stack to the point
add_key(abc, abc["a"]["first"][-1])

add_key(len_abc, len(abc))

add_key(len_abc, len(load_json(abc["a"]["ff"])))
```

### `lowercase()` {#fn-lowercase}

Function Prototype: `fn lowercase(key: str)`

Function Description: Convert the content of the extracted key to lowercase.

Function Parameters:

- `key`: The name of the field to be converted.

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

Function Description: Use a specified regular expression to match a string, returning true if the match is successful, otherwise false.

Parameters:

- `pattern`: The regular expression.
- `s`: The string to be matched.

Example:

```python
# Script
test_1 = "pattern 1,a"
test_2 = "pattern -1,"

add_key(match_1, match('\\w+\\s[,\\w]+', test_1)) 

add_key(match_2, match('\\w+\\s[,\\w]+', test_2)) 

# Processing result
{
    "match_1": true,
    "match_2": false
}
```

### `mquery_refer_table()` {#fn-mquery-refer-table}

Function Prototype: `fn mquery_refer_table(table_name: str, keys: list, values: list)`

Function Description: Query an external reference table using specified keys and append all columns of the first row of the query result to the field.

Parameters:

- `table_name`: The name of the table to be queried.
- `keys`: A list of multiple column names.
- `values`: The values corresponding to each column.

Example:

```python
json(_, table)
json(_, key)
json(_, value)

# Query and append the data of the current column to the field by default
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

Function Prototype: `fn nullif(key, value)`

Function Description: If the content of the extracted `key` field is equal to the `value`, this field is deleted.

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

Function Prototype: `fn parse_date(key: str, yy: str, MM: str, dd: str, hh: str, mm: str, ss: str, ms: str, zone: str)`

Function Description: Convert the values of the date fields passed into the function into a timestamp.

Function Parameters:

- `key`: The new field to be inserted.
- `yy` : The year as a numeric string, supports four or two-digit strings, if empty, the current year is taken.
- `MM`: The month as a string, supports numbers, English, and English abbreviations.
- `dd`: The day as a string.
- `hh`: The hour as a string.
- `mm`: The minute as a string.
- `ss`: The second as a string.
- `ms`: The millisecond as a string.
- `us`: The microsecond as a string.
- `ns`: The nanosecond as a string.
- `zone`: The timezone string, in the form of "+8" or "Asia/Shanghai".

Example:

```python
parse_date(aa, "2021", "May", "12", "10", "10", "34", "", "Asia/Shanghai") # Result aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "", "Asia/Shanghai") # Result aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", "Asia/Shanghai") # Result aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", "", "+8") # Result aa=1581473434000000000
```

### `parse_duration()` {#fn-parse-duration}

Function Prototype: `fn parse_duration(key: str)`

Function Description: If the value of `key` is a golang duration string (e.g., `123ms`), it automatically parses `key` into an integer in nanoseconds.

Currently, the duration units in golang are as follows:

- `ns` Nanoseconds
- `us/µs` Microseconds
- `ms` Milliseconds
- `s` Seconds
- `m` Minutes
- `h` Hours

Function Parameters:

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


### `query_refer_table()` {#fn-query-refer-table}

Function Prototype: `fn query_refer_table(table_name: str, key: str, value)`

Function Description: Query an external reference table with the specified key and append all columns of the first row of the query result to the field.

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

# Query and append the data of the current column, default to add to the data as a field
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

Function Prototype: `fn rename(new_key: str, old_key: str)`

Function Description: Rename a field that has been extracted.

Parameters:

- `new_key`: The new field name.
- `old_key`: The name of the field that has been extracted.

Example:

```python
# Rename the extracted field 'abc' to 'abc1'
rename('abc1', 'abc')

# or

rename('abc1', 'abc')
```

```python
# Data to be processed: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# Processing script
json(_, info.name, "name")

# Processing result
{
  "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}",
  "zhangsan": {
    "age": 17,
    "height": 180,
    "name": "zhangsan"
  }
}
```

### `replace()` {#fn-replace}

Function Prototype: `fn replace(key: str, regex: str, replace_str: str)`

Function Description: Replace the string data obtained from the specified field with a regular expression.

Function Parameters:

- `key`: The field to be extracted.
- `regex`: The regular expression.
- `replace_str`: The string to be used for replacement.

Example:

```python
# Phone number: {"str_abc": "13789123014"}
json(_, str_abc)
replace(str_abc, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# English name: {"str_abc": "zhang san"}
json(_, str_abc)
replace(str_abc, "([a-z]+) \\w*", "$1 ***")

# ID number: {"str_abc": "362201200005302565"}
json(_, str_abc)
replace(str_abc, "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# Chinese name: {"str_abc": "小阿卡"}
json(_, str_abc)
replace(str_abc, '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```

### `sample()` {#fn-sample}

Function Prototype: `fn sample(p: float)`

Function Description: Select to collect or discard data with a probability of p.

Function Parameter:

- `p`: The probability that the sample function returns true, with a range of [0, 1].

Example:

```python
# Processing script
if !sample(0.3) { # sample(0.3) indicates a sampling rate of 30%, that is, there is a 30% chance of returning true, and 70% of the data will be discarded here
  drop() # Mark the data as discarded
  exit() # Exit the subsequent processing flow
}
```


### `set_measurement()` {#fn-set-measurement}

Function Prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function Description: Change the name of the line protocol.

Function Parameters:

- `name`: The value as the measurement name, which can be a string constant or variable.
- `delete_key`: If there is a tag or field in the point with the same name as the variable, delete it.

The mapping relationship of the line protocol name to the field when storing various types of data or other uses:

| Category          | Field Name | Other Uses |
| ----------------- | ---------- | ---------- |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Metric Set Name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function Prototype: `fn set_tag(key: str, value: str)`

Function Description: Mark the specified field as a tag for output. After being set as a tag, other functions can still operate on this variable. If the key set as a tag is a field that has been extracted, it will not appear in the field, thus avoiding conflicts with existing tag keys in the data.

Function Parameters:

- `key`: The field to be marked as a tag.
- `value`: Can be a string literal or a variable.

```python
# in << {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * The character `#` is only a marker for a field as a tag when outputting with datakit --pl <path> --txt <str>

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

### `sql_cover()` {#fn-sql-cover}

Function Prototype: `fn sql_cover(sql_test: str)`

Function Description: Desensitize SQL statements.

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover("select abc from def where x > 3 and y < 5")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function Prototype: `fn strfmt(key: str, fmt: str, args: ...: int|float|bool|str|list|map|nil)`

Function Description: Format the content of the specified fields `arg1, arg2, ...` according to `fmt`, and write the formatted content into the `key` field.

Function Parameters:

- `key`: The field name to write the formatted data to.
- `fmt`: The format string template.
- `args`: Variable arguments, which can be multiple extracted fields waiting for formatting.

Example:

```python
# Data to be processed: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.thrid")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.thrid", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function Prototype: `fn timestamp(precision: str = "ns") -> int`

Function Description: Return the current Unix timestamp with the default precision of ns.

Function Parameters:

- `precision`: The precision of the timestamp, which can be "ns", "us", "ms", "s", with the default value being "ns".

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
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```


### `set_measurement()` {#fn-set-measurement}

Function Prototype: `fn set_measurement(name: str, delete_key: bool = false)`

Function Description: Change the name of the line protocol.

Function Parameters:

- `name`: The value as the measurement name, which can be a string constant or variable.
- `delete_key`: If there is a tag or field in the point with the same name as the variable, delete it.

The mapping relationship of the line protocol name to the field when storing various types of data or other uses:

| Category          | Field Name | Other Uses |
| ----------------- | ---------- | ---------- |
| custom_object     | class      | -          |
| keyevent          | -          | -          |
| logging           | source     | -          |
| metric            | -          | Metric Set Name |
| network           | source     | -          |
| object            | class      | -          |
| profiling         | source     | -          |
| rum               | source     | -          |
| security          | rule       | -          |
| tracing           | source     | -          |

### `set_tag()` {#fn-set-tag}

Function Prototype: `fn set_tag(key: str, value: str)`

Function Description: Mark the specified field as a tag for output. After being set as a tag, other functions can still operate on this variable. If the key set as a tag is a field that has been extracted, it will not appear in the field, thus avoiding conflicts with existing tag keys in the data.

Function Parameters:

- `key`: The field to be marked as a tag.
- `value`: Can be a string literal or a variable.

```python
# in << {"str": "13789123014"}
set_tag("str")
json(_, "str")          # str == "13789123014"
replace("str", "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")
# Extracted data(drop: false, cost: 49.248µs):
# {
#   "message": "{\"str\": \"13789123014\", \"str_b\": \"3\"}",
#   "str#": "137****3014"
# }
# * The character `#` is only a marker for a field as a tag when outputting with datakit --pl <path> --txt <str>

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

### `sql_cover()` {#fn-sql-cover}

Function Prototype: `fn sql_cover(sql_test: str)`

Function Description: Desensitize SQL statements.

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover("select abc from def where x > 3 and y < 5")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

Function Prototype: `fn strfmt(key: str, fmt: str, args: ...: int|float|bool|str|list|map|nil)`

Function Description: Format the content of the specified fields `arg1, arg2, ...` according to `fmt`, and write the formatted content into the `key` field.

Function Parameters:

- `key`: The field name to write the formatted data to.
- `fmt`: The format string template.
- `args`: Variable arguments, which can be multiple extracted fields waiting for formatting.

Example:

```python
# Data to be processed: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# Processing script
json(_, "a.second")
json(_, "a.thrid")
cast("a.second", "int")
json(_, "a.forth")
strfmt("bb", "%v %s %v", "a.second", "a.thrid", "a.forth")
```

### `timestamp()` {#fn-timestamp}

Function Prototype: `fn timestamp(precision: str = "ns") -> int`

Function Description: Return the current Unix timestamp with the default precision of ns.

Function Parameters:

- `precision`: The precision of the timestamp, which can be "ns", "us", "ms", "s", with the default value being "ns".

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
# Processing script
add_key("time_now_record", timestamp("ms"))


# Processing result
{
  "time_now_record": 1678185980578
}
```


### `trim()` {#fn-trim}

Function Prototype: `fn trim(key: str, cutset: str = "")`

Function Description: Remove specified characters from the beginning and end of `key`. When `cutset` is an empty string, it defaults to removing all whitespace characters.

Function Parameters:

- `key`: A certain field that has been extracted, of string type.
- `cutset`: Characters that appear at the beginning and end of `key` and are to be removed from the `cutset` string.

Example:

```python
# Data to be processed: "trim(key, cutset)"

# Processing script
add_key("test_data", "ACCAA_test_DataA_ACBA")
trim("test_data", "ABC_")

# Processing result
{
  "test_data": "test_Data"
}
```

### `uppercase()` {#fn-uppercase}

Function Prototype: `fn uppercase(key: str)`

Function Description: Convert the content of the extracted key to uppercase.

Function Parameters:

- `key`: The name of the field that has been extracted and is to be converted to uppercase.

Example:

```python
# Data to be processed: {"first": "hello", "second":2, "third":"aBC", "forth":true}

# Processing script
json(_, "first") uppercase("first")

# Processing result
{
  "first": "HELLO"
}
```

### `url_decode()` {#fn-url-decode}

Function Prototype: `fn url_decode(key: str)`

Function Description: Parse the URL in the extracted `key` into plain text.

Parameters:

- `key`: A certain `key` that has been extracted.

Example:

```python
# Data to be processed: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# Processing script
json(_, "url") url_decode("url")

# Processing result
{
  "message": "{\"url\":\"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95\"}",
  "url": "http://www.baidu.com/s?wd=%E6%B5%8B%E8%AF%95"
}
```

### `url_parse()` {#fn-url-parse}

Function Prototype: `fn url_parse(key: str)`

Function Description: Parse the URL of the field named key.

Function Parameters:

- `key`: The name of the URL field to be parsed.

Example:

```python
# Data to be processed: {"url": "https://www.baidu.com"}

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

The above example extracts the scheme from the URL. In addition to this, you can also extract the host, port, path, and parameters carried in the URL, as shown in the following example:

```python
# Data to be processed: {"url": "https://www.google.com/search?q=abc&sclient=gws-wiz"}

# Processing script
json(_, "url")
m = url_parse("url")
add_key("sclient", m["params"]["sclient"])  # Parameters carried in the URL are saved under the "params" field
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

Function Prototype: `fn use(name: str)`

Parameters:

- `name`: The name of the script, e.g., abp.p.

Function Description: Call another script, which can access all current data in the script being called.

Example:

```python
# Data to be processed: {"ip":"1.2.3.4"}

# Processing script a.p
use("b.p")

# Processing script b.p
json(_, "ip")
geoip("ip")

# Result of executing script a.p
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

Function Prototype: `fn user_agent(key: str)`

Function Description: Obtain client information from the specified field.

Function Parameters:

- `key`: The field to be extracted.

The `user_agent()` function will produce multiple fields, such as:

- `os`: Operating system.
- `browser`: Browser.

Example:

```python
# Data to be processed
{
  "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36",
  "second": 2,
  "third": "abc",
  "forth": true
}

json(_, "userAgent") user_agent("userAgent")
```

### `xml()` {#fn-xml}

Function Prototype: `fn xml(input: str, xpath_expr: str, key_name)`

Function Description: Extract fields from XML using an XPath expression.

Parameters:

- `input`: The XML to be extracted.
- `xpath_expr`: The XPath expression.
- `key_name`: The new key where the extracted data will be written.

Example 1:

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
xml(_, '/entry/fieldarray//fielda[1]/text()', "field_a_1")

# Processing result
{
  "field_a_1": "element_a_1",  # Extracted element_a_1
  "message": "The XML content",
  "status": "unknown",
  "time": 1655522989104916000
}
```

Example 2:

```python
# Data to be processed
<OrderEvent actionCode="5">
  <OrderNumber>ORD12345</OrderNumber>
  <VendorNumber>V11111</VendorNumber>
</OrderEvent>

# Processing script
xml(_, '/OrderEvent/@actionCode', "action_code")
xml(_, '/OrderEvent/OrderNumber/text()', "OrderNumber")

# Processing result
{
  "OrderNumber": "ORD12345",
  "action_code": "5",
  "message": "The XML content",
  "status": "unknown",
  "time": 1655523193632471000
}
```
