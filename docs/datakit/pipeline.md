
# 文本数据处理（Pipeline）
---

- DataKit 版本：1.4.6
- 操作系统支持：全平台

以下是文本处理器定义。随着不同语法的逐步支持，该文档会做不同程度的调整和增删。

## 基本规则 {#basic-syntax}

- 函数名大小写不敏感
- 以 `#` 为行注释字符。不支持行内注释
- 标识符：只能出现 `[_a-zA-Z0-9]` 这些字符，且首字符不能是数字。如 `_abc, _abc123, _123ab`
- 字符串值可用双引号或单引号，多行字符串可以使用三双引号或三单引号： 
  - `"this is a string"` 
  - `'this is a string'`
  - ```
    """%{NUMBER:a:int}
    %{WORD:B:bool} %{NUMBER:b:float}"""
    ```
  - ```
    '''%{NUMBER:a:int}
    %{WORD:B:bool} %{NUMBER:b:float}'''
    ```

- 数据类型：支持浮点（`123.4`, `5.67E3`）、整形（`123`, `-1`）、字符串（`'张三'`, `"hello world"`）、Boolean（`true`, `false`）四种类型
- 多个函数之间，可以用空白字符（空格、换行、Tab 等）分割
- 切割出来的字段中如果带有特殊字符（如 `@`、`$`、中文字符、表情包等），在代码中引用时，需额外修饰，如 `` `@some-variable` ``，`` `这是一个表情包变量👍` ``
- 字段名中出现的字符只能是 `[_a-zA-Z0-9]`，即只能是下划线（`_`）、大小写英文字母以及数字。另外，**首字符不能是数字**

### 特殊字符

为保持 Pipeline 语义的前向兼容，对于日志而言，`_` 为 `message` 的别名，该别名只在日志类数据中生效。

## 快速开始

### 如何在 DataKit 中配置 pipeline：

- 第一步：编写如下 pipeline 文件，假定名为 *nginx.p*。将其存放在 `<datakit安装目录>/pipeline` 目录下。

```python
# 假定输入是一个 Nginx 日志（以下字段都是 yy 的...）
# 注意，脚本是可以加注释的

grok(_, "some-grok-patterns")  # 对输入的文本，进行 grok 提取
rename('client_ip', ip)        # 将 ip 字段改名成 client_ip
rename("网络协议", protocol)   # 将 protocol 字段改名成 `网络协议`

# 将时间戳(如 1610967131)换成 RFC3339 日期格式：2006-01-02T15:04:05Z07:00
datetime(access_time, "s", "RFC3339")

url_decode(request_url)      # 将 HTTP 请求路由翻译成明文

# 当 status_code 介于 200 ~ 300 之间，新建一个 http_status = "HTTP_OK" 的字段
group_between(status_code, [200, 300], "HTTP_OK", "http_status")

# 丢弃原内容
drop_origin_data()
```

> 注意，切割过程中，需避免[可能出现的跟 tag key 重名的问题](datakit-pl-how-to.md#naming)

- 第二步：配置对应的采集器来使用上面的 pipeline

以 logging 采集器为例，配置字段 `pipeline_path` 即可，注意，这里配置的是 pipeline 的脚本名称，而不是路径。所有这里引用的 pipeline 脚本，必须存放在 `<DataKit 安装目录/pipeline>` 目录下：

```python
[[inputs.logging]]
    logfiles = ["/path/to/nginx/log"]

    # required
    source = "nginx"

    # 所有脚本必须放在 /path/to/datakit/pipeline 目录下
    # 如果开启了 gitrepos 功能，则优先以 gitrepos 中的同名文件为准
    # 如果 pipeline 未配置，则在 pipeline 目录下寻找跟 source 同名
    # 的脚本（如 nginx -> nginx.p），作为其默认 pipeline 配置
    pipeline = "nginx.p"

    ... # 其它配置
```

重启采集器，即可切割对应的日志。关于 Pipeline 编写、调试以及注意事项，参见[这里](datakit-pl-how-to.md)。

## Grok 模式分类

DataKit 中 grok 模式可以分为两类：全局模式与局部模式，`pattern` 目录下的模式文件都是全局模式，所有 pipeline 脚本都可使用，而在 pipeline 脚本中通过 `add_pattern()` 函数新增的模式属于局部模式，只针对当前 pipeline 脚本有效。

当 DataKit 内置模式不能满足所有用户需求，用户可以自行在 pipeline 目录中增加模式文件来扩充。若自定义模式是全局级别，则需在 `pattern` 目录中新建一个文件并把模式添加进去，不要在已有内置模式文件中添加或修改，因为datakit启动过程会把内置模式文件覆盖掉。


grok 函数和 add_pattern 函数使用时可供参考的一些技巧，以处理一条 Nginx access log 为例:

日志格式:
```log
127.0.0.1 - - [26/May/2022:20:53:52 +0800] "GET /server_status HTTP/1.1" 404 134 "-" "Go-http-client/1.1"
```

需求与分析:

假设我们需要从该访问日志中获取 client_ip、time (request)、http_method、http_url、http_version、status_code 这些内容

那么 grok pattern 可以写成:
```python
grok(_,"%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")
cast(status_code, "int")
group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)
default_time(time)
```

显然这不够优雅，我们来优化一下:

```python
# 日志首部的 client_ip、http_ident、http_auth 作为一个 pattern
add_pattern("p1", "%{NOTSPACE:client_ip} %{NOTSPACE} %{NOTSPACE}")

# 中间的 http_method、http_url、http_version、status_code 作为一个 pattern，
# 并在 pattern 内指定 status_code 的数据类型 int 来替代使用的 cast 函数
add_pattern("p3", '"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}" %{INT:status_code:int}')

grok(_, "%{p1} \\[%{HTTPDATE:time}\\] %{p3} %{INT} \"%{NOTSPACE}\" \"%{NOTSPACE}\"")

group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)

default_time(time)
```

以上，相较于单行 pattern 来说可读性更强些；

由于 grok 解析出的字段默认数据类型是 string，在此处指定字段的数据类型可以被避免因 INT、NUMBER 之类的内置 pattern 影响而不使用 cast 函数

### 添加局部模式

grok 本质是预定义一些正则表达式来进行文本匹配提取，并且给预定义的正则表达式进行命名，方便使用与嵌套引用扩展出无数个新模式。比如 DataKit 有 3 个如下内置模式：

```python
_second (?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)    #匹配秒数，_second为模式名
_minute (?:[0-5][0-9])                            #匹配分钟数，_minute为模式名
_hour (?:2[0123]|[01]?[0-9])                      #匹配年份，_hour为模式名
```

基于上面三个内置模式，可以扩展出自己内置模式且命名为 `time`:

```python
# 把 time 加到 pattern 目录下文件中，此模式为全局模式，任何地方都能引用 time
time ([^0-9]?)%{hour:hour}:%{minute:minute}(?::%{second:second})([^0-9]?)

# 也可以通过 add_pattern() 添加到 pipeline 文件中，则此模式变为局部模式，只有当前 pipeline 脚本能使用 time
add_pattern(time, "([^0-9]?)%{HOUR:hour}:%{MINUTE:minute}(?::%{SECOND:second})([^0-9]?)")

# 通过 grok 提取原始输入中的时间字段。假定输入为 12:30:59，则提取到 {"hour": 12, "minute": 30, "second": 59}
grok(_, %{time})
```

注意：

- 相同模式名以脚本级优先（即局部模式覆盖全局模式）
- pipeline 脚本中，`add_pattern()` 需在 `grok()` 函数前面调用，否则会导致第一条数据提取失败。

### 内置的 Pattern 列表

DataKit 内置了一些常用的 Pattern，我们在使用 Grok 切割的时候，可以直接使用：

```
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

## 脚本执行流

pipeline 支持 `if/elif/else` 语法，`if` 后面的语句仅支持条件表达式，即 `<`、`<=`、`==`、`>`、`>=` 和 `!=`， 且支持小括号优先级和多个条件表达式的 `AND` 和 `OR` 连接。
表达式两边可以是已存在的 key 或固定值（数值、布尔值、字符串和 nil ），例如：

```python
# 数值比较
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

# 字符串比较
add_key(name, "张三")

if name == "法外狂徒" {
  # 这是不可能的，不要污蔑我
}
```

和大多数编程/脚本语言相同，根据 `if/elif` 的条件是否成立，来决定其执行顺序。

注意：如果是进行数值比较，需要先用 `cast()` 进行类型转换，比如：

```
# status_code 是 grok 切出来的 string 类型
cast(status_code, "int")

if status == 200 {
  add_key(level, "OK")
} elif status >= 400 && status < 500 {
  add_key(level, "ERROR")
} elif stauts > 500 {
  add_key(level, "FATAL")
}
```

## Pipeline 脚本存放目录

Pipeline 的目录搜索优先级是:
1. Remote Pipeline 目录
2. Git 管理的 pipeline 目录
3. 内置的 pipeline 目录

由 1 往 3 方向查找，匹配到了直接返回。

不允许绝对路径的写法。

### Remote Pipeline 目录

在 Datakit 的安装目录下面的 `pipeline_remote` 目录下，目录结构如下所示:

```
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

### Git 管理的 pipeline 目录

在 `gitrepos` 目录下的 `项目名/pipeline` 目录下，目录结构如上所示。

### 内置的 pipeline 目录

在 Datakit 的安装目录下面的 `pipeline` 目录下，目录结构如上所示。

## 脚本函数

函数参数说明：

- 函数参数中，匿名参数（`_`）指原始的输入文本数据
- json 路径，直接表示成 `x.y.z` 这种形式，无需其它修饰。例如 `{"a":{"first":2.3, "second":2, "third":"abc", "forth":true}, "age":47}`，json 路径为 `a.thrid` 表示待操作数据为 `abc`
- 所有函数参数的相对顺序，都是固定的，引擎会对其做具体检查
- 以下提到的所有 `key` 参数，都指已经过初次提取（通过 `grok()` 或 `json()`）之后，生成的 `key`
- 待处理json的路径，支持标识符的写法，不能使用字符串，如果是生成新key，需要使用字符串

### `add_key()` {#fn-add-key}

函数原型：`add_key(key-name=required, key-value=required)`

函数说明：增加一个字段

函数参数

- `key-name`: 新增的 key 名称
- `key-value`：key 值（只能是 string/number/bool/nil 这几种类型）

示例:

```python
# 待处理数据: {"age": 17, "name": "zhangsan", "height": 180}

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

函数原型：`add_pattern(name=required, pattern=required)`

函数说明：创建自定义 grok 模式。grok 模式有作用域限制, 如在 if else 语句内将产生新的作用域, 该 pattern 仅在此作用域内有效。该函数不可覆盖同一作用域或者上一作用域已经存在的 grok 模式

参数:

- `name`：模式命名
- `pattern`: 自定义模式内容

示例:

```python
# 待处理数据: "11,abc,end1", "22,abc,end1", "33,abc,end3"

# pipline脚本
add_pattern("aa", "\\d{2}")
grok(_, "%{aa:aa}")
if false {

} else {
    add_pattern("bb", "[a-z]{3}")
    if aa == "11" {
        add_pattern("cc", "end1")
        grok(_, "%{aa:aa},%{bb:bb},%{cc:cc}")
    } elif aa == "22" {
        # 此处使用 pattern cc 将导致编译失败: no pattern found for %{cc}
        grok(_, "%{aa:aa},%{bb:bb},%{INT:cc}")
    } elif aa == "33" {
        add_pattern("bb", "[\\d]{5}")	# 此处覆盖 bb 失败
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

函数原型：`adjust_timezone(key=required)`

函数说明：自动选择时区，校准时间戳。用于校准日志中的时间格式不带时区信息，且与 pipeline 时间处理函数默认的本地时区不一致时使得时间戳出现数小时的偏差，适用于时间偏差小于24小时

函数参数

- `key`: 纳秒时间戳，如 `default_time(time)` 函数处理后得到的时间戳

示例:

```python
# 原始 json
{
    "time":"10 Dec 2021 03:49:20.937",
    "second":2,
    "third":"abc",
    "forth":true
}

# pipeline 脚本
json(_, time)      # 提取 time 字段 (若容器中时区 UTC+0000)
default_time(time) # 将提取到的 time 字段转换成时间戳
                   # (对无时区数据使用本地时区 UTC+0800/UTC+0900...解析)
adjust_timezone(time)
                   # 自动(重新)选择时区，校准时间偏差
# 处理结果
{
  "time": 1639108160937000000,
}
```


### `cast()` {#fn-cast}

函数原型：`cast(key=required, type=required)`

函数说明：将 key 值转换拆成指定类型

函数参数

- `key`: 已提取的某字段
- `type`：转换的目标类型，支持 `\"str\", \"float\", \"int\", \"bool\"` 这几种，目标类型需要用英文状态双引号括起来

示例:

```python
# 待处理数据: {"first": 1,"second":2,"third":"aBC","forth":true}

# 处理脚本
json(_, first) cast(first, "str")

# 处理结果
{
  "first": "1"
}
```

### `cover()` {#fn-cover}

函数原型：`cover(key=required, range=require)`

函数说明：对指定字段上获取的字符串数据，按范围进行数据脱敏处理

函数参数

- `key`: 待提取字段
- `range`: 脱敏字符串的索引范围（`[start,end]`） start和end均支持负数下标，用来表达从尾部往前追溯的语义。区间合理即可，end如果大于字符串最大长度会默认成最大长度

示例:

```python
# 待处理数据 {"str": "13789123014"}
json(_, str) cover(str, [8, 13])

# 待处理数据 {"str": "13789123014"}
json(_, str) cover(str, [2, 4])

# 待处理数据 {"str": "13789123014"}
json(_, str) cover(str, [1, 1])

# 待处理数据 {"str": "小阿卡"}
json(_, str) cover(str, [2, 2])
```

### `datetime()` {#fn-datetime}

函数原型：`datetime(key=required, precision=required, fmt=required)`

函数说明：将时间戳转成指定日期格式

函数参数

- `key`: 已经提取的时间戳 (必选参数)
- `precision`：输入的时间戳精度(s, ms)
- `fmt`：日期格式，时间格式, 支持以下模版

```python
ANSIC       = "Mon Jan _2 15:04:05 2006"
UnixDate    = "Mon Jan _2 15:04:05 MST 2006"
RubyDate    = "Mon Jan 02 15:04:05 -0700 2006"
RFC822      = "02 Jan 06 15:04 MST"
RFC822Z     = "02 Jan 06 15:04 -0700" // RFC822 with numeric zone
RFC850      = "Monday, 02-Jan-06 15:04:05 MST"
RFC1123     = "Mon, 02 Jan 2006 15:04:05 MST"
RFC1123Z    = "Mon, 02 Jan 2006 15:04:05 -0700" // RFC1123 with numeric zone
RFC3339     = "2006-01-02T15:04:05Z07:00"
RFC3339Nano = "2006-01-02T15:04:05.999999999Z07:00"
Kitchen     = "3:04PM"
```

示例:

```python
# 待处理数据:
#    {
#        "a":{
#            "timestamp": "1610960605000",
#            "second":2
#        },
#        "age":47
#    }

# 处理脚本
json(_, a.timestamp) datetime(a.timestamp, 'ms', 'RFC3339')
```

### `decode()` {#fn-decode}

函数原型：`decode(text, text-encode)`

函数说明：把 text 变成 UTF8 编码，以处理原始日志为非 UTF8 编码的问题。目前支持的编码为 utf-16le/utf-16be/gbk/gb18030（这些编码名只能小写）

```python
decode("wwwwww", "gbk")

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "wwwwww",
# }
```

### `default_time()` {#fn-defalt-time}

函数原型：`default_time(key=required, timezone=optional)`

函数说明：以提取的某个字段作为最终数据的时间戳

函数参数

- `key`: 指定的 key
- `timezone`: 指定的时区，默认为本机当前时区，时区示例 `+8/-8/+8:30`

待处理数据支持以下格式化时间

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
| `20140722105203`                                   | `2014年04月08日`                                        | `1332151919`                                   | `2006-01-02T15:04:05+0000`        |
| `1384216367189`                                    | `2009-08-12T22:15:09-07:00`                             | `1384216367111222`                             | `2009-08-12T22:15:09`             |
| `1384216367111222333`                              | `2009-08-12T22:15:09Z`                                  |

JSON 提取示例:

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

文本提取示例:

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


### `drop()` {#fn-drop}

函数原型：`drop()`

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

函数原型：`drop_key(key=required)`

函数说明：删除已提取字段

函数参数

- `key`: 待删除字段名

示例:

```python
data = `{\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}`

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

函数原型：`drop_origin_data()`

函数说明：丢弃初始化文本，否则初始文本放在 message 字段中

示例:

```python
# 待处理数据: {"age": 17, "name": "zhangsan", "height": 180}

# 结果集中删除 message 内容
drop_origin_data()
```


### `duration_precision()` {#fn-duration-precision}

函数原型：`duration_precision(key=required, old_precision=require, new_precision=require)`

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

函数原型：`exit()`

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


### `geoip()` {#fn-geoip}

函数原型：`geoip(key=required)`

函数说明：在 IP 上追加更多 IP 信息。 `geoip()` 会额外产生多个字段，如：

- `isp`: 运营商
- `city`: 城市
- `province`: 省份
- `country`: 国家

参数:

- `key`: 已经提取出来的 IP 字段，支持 IPv4/6

示例：

```python
# 待处理数据: {"ip":"1.2.3.4"}

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
### `grok()` {#fn-grok}

函数原型：`grok(input=required, pattern=required)`

函数说明：通过 `pattern` 提取文本串 `input` 中的内容。

参数:

- `input`：待提取文本，可以是原始文本（`_`）或经过初次提取之后的某个 `key`
- `pattern`: grok 表达式，表达式中支持指定 key 的数据类型：bool, float, int, string，默认为 string

```python
grok(_, pattern)    # 直接使用输入的文本作为原始数据
grok(key, pattern)  # 对之前已经提取出来的某个 key，做再次 grok
```

示例:

```python
# 待处理数据: "12/01/2021 21:13:14.123"

# pipline脚本
add_pattern("_second", "(?:(?:[0-5]?[0-9]|60)(?:[:.,][0-9]+)?)")
add_pattern("_minute", "(?:[0-5][0-9])")
add_pattern("_hour", "(?:2[0123]|[01]?[0-9])")
add_pattern("time", "([^0-9]?)%{_hour:hour:string}:%{_minute:minute:int}(?::%{_second:second:float})([^0-9]?)
grok(_, "%{DATE_US:date} %{time}")

# 处理结果
{
  "date": "12/01/2021",
  "hour": "21",
  "message": "12/01/2021 21:13:14.123",
  "minute": 13,
  "second": 14.123
}
```

### `group_between()` {#fn-group-between}

函数原型：`group_between(key=required, between=required, new-value=required, new-key=optional)`

函数说明：如果 `key` 值在指定范围 `between` 内（注意：只能是单个区间，如 `[0,100]`），则可创建一个新字段，并赋予新值。若不提供新字段，则覆盖原字段值

示例一:

```python
# 待处理数据: {"http_status": 200, "code": "success"}

json(_, http_status)

# 如果字段 http_status 值在指定范围内，则将其值改为 "OK"
group_between(http_status, [200, 300], "OK")
`

# 处理结果
{
    "http_status": "OK"
}
```

示例二:

```python
# 待处理数据: {"http_status": 200, "code": "success"}

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

函数原型：`group_in(key=required, in=required, new-value=required, new-key=optional)`

函数说明：如果 `key` 值在列表 `in` 中，则可创建一个新字段，并赋予新值。若不提供新字段，则覆盖原字段值

示例:

```python
# 如果字段 log_level 值在列表中，则将其值改为 "OK"
group_in(log_level, ["info", "debug"], "OK")

# 如果字段 http_status 值在指定列表中，则新建 status 字段，其值为 "not-ok"
group_in(log_level, ["error", "panic"], "not-ok", status)
```


### `json()` {#fn-json}

函数原型：`json(input=required, jsonPath=required, newkey=optional)`

函数说明：提取 json 中的指定字段，并可将其命名成新的字段。

参数:

- `input`: 待提取 json，可以是原始文本（`_`）或经过初次提取之后的某个 `key`
- `jsonPath`: json 路径信息
- `newkey`：提取后数据写入新 key

```python
# 直接提取原始输入 json 中的x.y字段，并可将其命名成新字段abc
json(_, x.y, abc)

# 已提取出的某个 `key`，对其再提取一次 `x.y`，提取后字段名为 `x.y`
json(key, x.y) 
```

示例一:

```python
# 待处理数据: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

# 处理脚本
json(_, info, "zhangsan")
json(zhangsan, name)
json(zhangsan, age, "年龄")

# 处理结果
{
    "message": "{\"info\": {\"age\": 17, \"name\": \"zhangsan\", \"height\": 180}}
    "zhangsan": {
        "age": 17,
        "height": 180,
        "name": "zhangsan"
    }
}
```

示例二:

```python
# 待处理数据
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

# 处理脚本
json(_, name) json(name, first)
```

示例三:

```python
# 待处理数据
#    [
#            {"first": "Dale", "last": "Murphy", "age": 44, "nets": ["ig", "fb", "tw"]},
#            {"first": "Roger", "last": "Craig", "age": 68, "nets": ["fb", "tw"]},
#            {"first": "Jane", "last": "Murphy", "age": 47, "nets": ["ig", "tw"]}
#    ]
    
# 处理脚本, json数组处理
json(_, [0].nets[-1])
```

### `lowercase()` {#fn-lowercase}

函数原型：`lowercase(key=required)`

函数说明：将已提取 key 中内容转换成小写

函数参数

- `key`: 指定已提取的待转换字段名

示例:

```python
# 待处理数据: {"first": "HeLLo","second":2,"third":"aBC","forth":true}

# 处理脚本
json(_, first) lowercase(first)

# 处理结果
{
		"first": "hello"
}
```


### `nullif()` {#fn-nullif}

函数原型：`nullif(key=required, value=required)`

函数说明：若已提取 `key` 指定的字段内容等于 `value` 值，则删除此字段

函数参数

- `key`: 指定字段
- `value`: 目标值

示例:

```python
# 待处理数据: {"first": 1,"second":2,"third":"aBC","forth":true}

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

函数原型：`parse_date(new-key=required, yy=require, MM=require, dd=require, hh=require, mm=require, ss=require, ms=require, zone=require)`

函数说明：将传入的日期字段各部分的值转化为时间戳

函数参数

- `key`: 新插入的字段
- `yy` : 年份数字字符串，支持四位或两位数字字符串，为空字符串，则处理时取当前年份
- `MM`:  月份字符串, 支持数字，英文，英文缩写
- `dd`: 日字符串
- `hh`: 小时字符串
- `mm`: 分钟字符串
- `ss`: 秒字符串
- `ms`: 毫秒字符串
- `zone`: 时区字符串，“+8”或\"Asia/Shanghai\"形式

示例:

```python
parse_date(aa, "2021", "May", "12", "10", "10", "34", "", "Asia/Shanghai") # 结果 aa=1620785434000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "", "Asia/Shanghai") # 结果 aa=1639275034000000000

parse_date(aa, "2021", "12", "12", "10", "10", "34", "100", "Asia/Shanghai") # 结果 aa=1639275034000000100

parse_date(aa, "20", "February", "12", "10", "10", "34", "", "+8") 结果 aa=1581473434000000000
```


### `parse_duration()` {#fn-parse-duration}

函数原型：`parse_duration(key=required)`

函数说明：如果 `key` 的值是一个 golang 的 duration 字符串（如 `123ms`），则自动将 `key` 解析成纳秒为单位的整数

目前 golang 中的 duration 单位如下：

- `ns` 纳秒
- `us/µs` 微秒
- `ms` 毫秒
- `s` 秒
- `m` 分钟
- `h` 小时

函数参数

- `key`: 待解析的字段

示例:

```python
# 假定 abc = "3.5s"
parse_duration(abc) # 结果 abc = 3500000000

# 支持负数: abc = "-3.5s"
parse_duration(abc) # 结果 abc = -3500000000

# 支持浮点: abc = "-2.3s"
parse_duration(abc) # 结果 abc = -2300000000

```


### `rename()` {#fn-rename}

函数原型：`rename(new-key=required, old-key=required)`

函数说明：将已提取的字段重新命名

参数:

- `new-key`: 新字段名
- `old-key`: 已提取的字段名

```python
# 把已提取的 abc 字段重新命名为 abc1
rename('abc1', abc)

# or 

rename(abc1, abc)
```

示例：

```python
# 待处理数据: {"info": {"age": 17, "name": "zhangsan", "height": 180}}

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

函数原型：`replace(key=required, regex=required, replaceStr=required)`

函数说明：对指定字段上获取的字符串数据按正则进行替换

函数参数

- `key`: 待提取字段
- `regex`: 正则表达式
- `replaceStr`: 替换的字符串

示例:

```python
# 电话号码：{"str": "13789123014"}
json(_, str)
replace(str, "(1[0-9]{2})[0-9]{4}([0-9]{4})", "$1****$2")

# 英文名 {"str": "zhang san"}
json(_, str)
replace(str, "([a-z]*) \\w*", "$1 ***")

# 身份证号 {"str": "362201200005302565"}
json(_, str)
replace(str, "([1-9]{4})[0-9]{10}([0-9]{4})", "$1**********$2")

# 中文名 {"str": "小阿卡"}
json(_, str)
replace(str, '([\u4e00-\u9fa5])[\u4e00-\u9fa5]([\u4e00-\u9fa5])', "$1＊$2")
```


### `set_measurement()` {#fn-set-measurement}

函数原型：`set_measurement(key=required, disable_delete_key=optional)`

函数说明：改变行协议的 mesaurement name

函数参数

- `key`: 取 key 值作为 mesaurement name
- `value`: 默认值为 false 删除 key ，可以为 true 或 false


### `set_tag()` {#fn-set-tag}

函数原型：`set_tag(key=required, value=optional)`

函数说明：对指定字段标记为 tag 输出，设置为 tag 后，其他函数仍可对该变量操作。如果被置为 tag 的 key 是已经切割出来的 field，那么它将不会在 field 中出现，这样可以避免切割出来的 field key 跟已有数据上的 tag key 重名

函数参数

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
				"```

### `sql_cover()` {#fn-sql-cover}

函数原型：`sql_cover(sql_test)`

函数说明：脱敏sql语句

```python
# in << {"select abc from def where x > 3 and y < 5"}
sql_cover(_)

# Extracted data(drop: false, cost: 33.279µs):
# {
#   "message": "select abc from def where x > ? and y < ?"
# }
```

### `strfmt()` {#fn-strfmt}

函数原型：`strfmt(key=required, fmt=required, key1=optional, key2, ...)`

函数说明：对已提取 `key1,key2...` 指定的字段内容根据 `fmt` 进行格式化，并把格式化后的内容写入 `key` 字段中

函数参数

- `key`: 指定格式化后数据写入字段名
- `fmt`: 格式化字符串模板
- `key1，key2`:已提取待格式化字段名

示例:

```python
# 待处理数据: {"a":{"first":2.3,"second":2,"third":"abc","forth":true},"age":47}

# 处理脚本
json(_, a.second)
json(_, a.thrid)
cast(a.second, "int")
json(_, a.forth)
strfmt(bb, "%v %s %v", a.second, a.thrid, a.forth)
```


### `uppercase()` {#fn-uppercase}

函数原型：`uppercase(key=required)`

函数说明：将已提取 key 中内容转换成大写

函数参数

- `key`: 指定已提取的待转换字段名，将 `key` 内容转成大写

示例:

```python
# 待处理数据: {"first": "hello","second":2,"third":"aBC","forth":true}

# 处理脚本
json(_, first) uppercase(first)

# 处理结果
{
   "first": "HELLO"
}
```


### `url_decode()` {#fn-url-decode}

函数原型：`url_decode(key=required)`

函数说明：将已提取 `key` 中的 URL 解析成明文

参数:

- `key`: 已经提取的某个 `key`

示例：

```python
# 待处理数据: {"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}

# 处理脚本
json(_, url) url_decode(url)

# 处理结果
{
  "message": "{"url":"http%3a%2f%2fwww.baidu.com%2fs%3fwd%3d%e6%b5%8b%e8%af%95"}",
  "url": "http://www.baidu.com/s?wd=测试"
}
```

### `use()` {#fn-use}

函数原型：`use(name=required)`

参数:

- `name`: 脚本名，如 abp.p

函数说明：调用其他脚本，可在被调用的脚本访问当前的所有数据
示例：

```python
# 待处理数据: {"ip":"1.2.3.4"}

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

函数原型：`user_agent(key=required)`

函数说明：对指定字段上获取客户端信息

函数参数

- `key`: 待提取字段

`user_agent()` 会生产多个字段，如：

- `os`: 操作系统
- `browser`: 浏览器

示例:

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
### `xml()` {#fn-xml}

函数原型：`xml(input=required, xpath_expr=required, key_name=required)`

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

