# 开发手册 - 设计与实践
---


在 DataFlux Func 中进行脚本开发时，脚本本身与传统 Python 并无太大区别。但由于 DataFlux Func 本身的特性，在代码设计以及具体实践上会有差异。

本文会针对这些差异进行说明。

## 1. 脚本集、脚本规划设计

脚本集、脚本、函数应当按照一定逻辑编排组织，而不是将代码随意堆砌在一起。
合理编排脚本集和脚本有利于代码的维护以及系统运行效率。

### 1.1 按照用途、类型合理划分脚本集和脚本

一般来说，推荐选用以下几种代码组织方式：

- 为业务处理脚本按照行业、项目、组织等方式建立单独的脚本集，如：`eShop`、`IoT`、`monitor`、`sales`、`marketing`等
- 代码量过多时，根据使用频率划分低频使用的脚本和高频使用的脚本，如`prediction`、`advanced_prediction`

### 1.2 调用另一个脚本中的函数

脚本可以根据功能、用途等不同需求划分到不同的脚本或脚本集中，而位于不同脚本的代码可以相互调用。
需要调用另一个脚本中的函数时，只需要`import`对应脚本即可。

导入另一个脚本时，必须按照固定写法：

```python
# import <脚本集 ID>__<脚本 ID>
import demo__script

# 或使用别名缩短长度
# import <脚本集 ID>__<脚本 ID> as 别名
import demo__script as script
```

> 可以在脚本编辑器中，可以将鼠标指向左侧栏中的问号图表，直接复制相关语句

*注意：如果需要导出脚本集，那么，这个脚本集中依赖的其他脚本也需要一起导出。
否则导出的脚本集会因为缺少函数而实际无法运行！*

*注意：脚本或脚本集并不是 Python 模块，原本不能 import 导入。
但 DataFlux Func 内部实现了动态加载机制，并允许使用 import 语句加载动态代码。
因此，以下写法都是错误的。*

```python
# 错误写法 1：将脚本集当作模块导入
import demo

# 错误写法 2：将脚本当作模块导入
import demo.script
from demo import script

# 错误写法 3：只导入某个函数
from demo__script import some_func
```

此外，在导入脚本时，应当注意不要产生循环引用，如：

```python
# 脚本集 demo 下的脚本 script2
import demo__script2

# 脚本集 demo 下的脚本 script3
import demo__script3

# 脚本集 demo 下的脚本 script1
import demo__script1
```

*注意，在同时编辑多个脚本时，如果当前导入了另一个脚本，
那么被引用的脚本实际会以已发布的版本执行，
系统在任何时候都不会导入草稿版本！*

### 1.3 单个脚本的代码量及依赖链

由于 DataFlux Func 运行脚本时，采用动态加载需要的脚本执行。
如果其中一个脚本导入了另一个脚本，被导入的脚本也会被动态加载。

因此，如果某个脚本中的某些函数会被特别频繁地调用，可以考虑将其单独提取为独立的脚本，减少加载消耗。
单个脚本大小建议控制在 1000 行以内。

此外，也要尽量避免过长的依赖链，导致无意义的性能损耗。如：

- 脚本 1 依赖脚本 2
- 脚本 2 依赖脚本 3
- 脚本 3 依赖脚本 4
- 脚本 4 依赖脚本 5
- ...

Python 内置模块和第三方模块不受此限制影响

### 1.4 不划分脚本的情况

上文虽然提到了脚本的合理规划以及脚本之间调用的方法，
但在某些特定情况下（如实际使用到的公共函数很少也很简单时），
可以考虑不划分脚本，将所有代码都放在同一个脚本中。

这种方式，虽然代码产生了一点冗余，但也额外带来了一些好处：

- 单脚本即可运行，减少了加载消耗
- 不会因为公共函数的改变而受到影响
- 不用考虑脚本导出时的依赖关系

请根据实际情况选择最合理的方式规划脚本

### 1.5 相同脚本集下脚本之间相互引用的简写

*此功能在`1.1.0rc51`版本引入*

在同一个脚本集下，脚本之间引用可以不写脚本集 ID 部分（即只写`__`开头部分）。

方便在脚本集克隆，改变了脚本集 ID 后，内部函数之间依然可以正确引用。

如：

~~~python
# 脚本：demo__utils

def echo(msg):
    return msg
~~~

~~~python
# 脚本：demo__test

# 等价于 import demo__utils as utils
import __utils as utils

def my_func(msg):
    return utils.echo(msg)
~~~

### 1.6 避免过度封装

Python 是一门多范式的编程语言，可以使用简单的过程式编程，同样也能够使用面向对象的方式编程。

但在 DataFlux Func 中，为了方便调试，`建议使用偏向过程式的编程方式`编写代码，避免过度封装。

如，同样的功能，可以使用 2 中不同的方式实现：

~~~python
import requests

# 过程式
def query_some_api(url, params):
    r = requests.get(url, params)
    return r.json()

# 面向对象
class APIQuery(object):
    def __init__(self, url):
        self.url = url

    def do(self, params):
        r = requests.get(self.url, params)
        return r.json()

def test_api_query(url, params):
    api_query = APIQuery(url)
    api_query.do(params)
~~~

在上述例子中，虽然两者都能够实现同样的功能，但由于`query_some_api(...)`是一个可以直接调用的函数，因此在编辑器中，可以选择此函数后，直接填入参数运行。

而如果要调试运行`APIQuery`类的`do(...)`方法，必须先要实例化对象才能够调用，因此只能另外编写测试函数`test_api_query(...)`来调用。

具体使用何种方式，请根据实际情况酌情选择。

## 2. 常见代码处理方式

Python 是相当便捷的语言，特定的问题都有比较套路化的处理方式。
以下是一些常见问题的处理方式：

### 2.1 使用列表生成器语法

Python 的列表生成器语法可以快速生成列表，在逻辑相对简单时，非常适合。
但要注意的是，过分复杂的处理逻辑会使代码难以阅读。
因此复杂逻辑建议直接使用`for`循环处理。

示例如下：

```python
# 按时间生成 dps 数据
import time
dps = [ [(int(time.time()) + i) * 1000, i ** 2] for i in range(5) ]
dps = list(dps)
print(dps)
# [[1583172382000, 0], [1583172383000, 1], [1583172384000, 4], [1583172385000, 9], [1583172386000, 16]]

# 将输入的 dps 乘方
dps = [
    [1583172563000, 0],
    [1583172564000, 1],
    [1583172565000, 2],
    [1583172566000, 3],
    [1583172567000, 4]
]
dps = [ [d[0], d[1] ** 2] for d in dps ]
dps = list(dps)
print(dps)
# [[1583172563000, 0], [1583172564000, 1], [1583172565000, 4], [1583172566000, 9], [1583172567000, 16]]
```

### 2.2 使用内置`map`函数处理列表

Python 内置的`map`函数是另一个方便处理列表的函数。
逻辑简单时，可以使用 lambda 表达式；
逻辑复杂时，可以先定义函数后作为参数传入。

示例如下：

```python
# 使用 lambda 表达式将输入的 dps 乘方
dps = [
    [1583172563000, 0],
    [1583172564000, 1],
    [1583172565000, 2],
    [1583172566000, 3],
    [1583172567000, 4]
]
dps = map(lambda x: [x[0], x[1] ** 2], dps)
dps = list(dps)
print(dps)
# [[1583172563000, 0], [1583172564000, 1], [1583172565000, 4], [1583172566000, 9], [1583172567000, 16]]

# 使用传入函数将输入的 dps 乘方
dps = [
    [1583172563000, 0],
    [1583172564000, 1],
    [1583172565000, 2],
    [1583172566000, 3],
    [1583172567000, 4]
]
def get_pow(x):
    timestamp = x[0]
    value     = x[1] ** 2
    return [timestamp, value]

dps = map(get_pow, dps)
dps = list(dps)
print(dps)
# [[1583172563000, 0], [1583172564000, 1], [1583172565000, 4], [1583172566000, 9], [1583172567000, 16]]
```

### 2.3 获取 JSON 数据中多层嵌套中的值

有时函数会获取到一个嵌套层数较多的 JSON，同时需要获取某个层级下的值。
可以使用`try`语法快速获取。

示例如下：

```python
# 获取 level3 的值
input_data = {
    'level1': {
        'level2': {
            'level3': 'value'
        }
    }
}
value = None
try:
    value = input_data['level1']['level2']['level3']
except Exception as e:
    pass

print(value)
# value
```

*注意：使用此方法时，`try`代码块中不要添加其他任何无关代码，否则可能导致应当抛出的异常被跳过*

### 2.4 使用`arrow`库正确处理时间

Python 内置的日期处理模块在使用上有一定复杂度，并且对时区的支持并不好。
在处理时间时，建议使用第三方`arrow`模块。

> `arrow`模块已经内置，可直接`import`后使用

示例如下：

```python
import arrow

# 获取当前 Unix 时间戳
print(arrow.utcnow().timestamp)
# 1583174345

# 获取当前北京时间字符串
print(arrow.now('Asia/Shanghai').format('YYYY-MM-DD HH:mm:ss'))
# 2020-03-03 02:39:05

# 获取当前北京时间的 ISO8601 格式字符串
print(arrow.now('Asia/Shanghai').isoformat())
# 2020-03-03T02:39:05.013290+08:00
#
# 从 Unix 时间戳解析，并输出北京时间字符串
print(arrow.get(1577808000).to('Asia/Shanghai').format('YYYY-MM-DD HH:mm:ss'))
# 2020-01-01 00:00:00

# 从 ISO8601 时间字符串解析，并输出北京时间字符串
print(arrow.get('2019-12-31T16:00:00Z').to('Asia/Shanghai').format('YYYY-MM-DD HH:mm:ss'))
# 2020-01-01 00:00:00

# 从非标准时间字符串解析，并作为北京时间字符串
print(arrow.get('2020-01-01 00:00:00', 'YYYY-MM-DD HH:mm:ss').replace(tzinfo='Asia/Shanghai').format('YYYY-MM-DD HH:mm:ss'))
# 2020-01-01 00:00:00

# 时间运算：获取前一天，并输出北京时间字符串
print(arrow.get('2019-12-31T16:00:00Z').shift(days=-1).to('Asia/Shanghai').format('YYYY-MM-DD HH:mm:ss'))
# 2019-12-31 00:00:00
```

更详细内容，请参考`arrow`官方文档：
[https://arrow.readthedocs.io/](https://arrow.readthedocs.io/)

### 2.5 向外部发送 HTTP 请求

Python 内置的`http`处理模块在使用上有一定复杂度。
在发送 http 请求时，建议使用第三方`requests`模块。

示例如下：

```python
import requests

# 发送 GET 请求
r = requests.get('https://api.github.com/')
print(r.status_code)
print(r.json())

# form 方式发送 POST 请求
r = requests.post('https://httpbin.org/post', data={'key':'value'})
print(r.status_code)
print(r.json())

# json 方式发送 POST 请求
r = requests.post('https://httpbin.org/post', json={'key':'value'})
print(r.status_code)
print(r.json())
```

更详细内容，请参考`requests`官方文档：
[https://requests.readthedocs.io/](https://requests.readthedocs.io/)

### 2.6 发送钉钉机器人消息

钉钉自定义机器人可以简单的通过 POST 请求将消息推送到群中，是作为消息提示的不二选择。
由于只需要发送 HTTP 请求即可，因此可以直接使用`requests`模块。

示例如下：

```python
import requests

url = 'https://oapi.dingtalk.com/robot/send?access_token=xxxxx'
body = {
    'msgtype': 'text',
    'text': {
        'content': '钉钉机器人提示信息 @180xxxx0000'
    },
    'at': {
        'atMobiles': [
            '180xxxx0000'
        ]
    }
}
requests.post(url, json=body)
```

*注意：新版的钉钉群机器人添加了相关安全验证处理，具体请参考官方文档*

更详细内容，请参考钉钉机器人官方文档：
[https://developers.dingtalk.com/document/app/custom-robot-access](https://developers.dingtalk.com/document/app/custom-robot-access)

### 2.7 避免 SQL 注入

当需要将函数的传入参数作为 SQL 语句的参数时，需要注意避免 SQL 注入问题。
应当始终使用内置的数据源操作对象提供的`sql_params`参数，而不要直接拼接 SQL 语句字符串。

以下为正确示例：

```python
helper.query('SELECT * FROM table WHERE id = ?', sql_params=[target_id])
```

*以下错误示范：*

```python
helper.query("SELECT * FROM table WHERE id = '{}'".format(target_id))
helper.query("SELECT * FROM table WHERE id = '%s'" % target_id)
```

实际各类型的数据源操作对象使用方法略有不同，请参考「操作数据源 `DFF.SRC(...)`」章节

百度百科「SQL 注入」词条：
[https://baike.baidu.com/item/sql%E6%B3%A8%E5%85%A5](https://baike.baidu.com/item/sql%E6%B3%A8%E5%85%A5)

W3Cschool「MySQL 及 SQL 注入」章节：
[https://www.w3cschool.cn/mysql/mysql-sql-injection.html](https://www.w3cschool.cn/mysql/mysql-sql-injection.html)

## 3. 对接外部黑盒系统

某些情况下，开发者需要从第三方获取数据，但第三方又不提供标准 HTTP 的访问接口，如：

1. 第三方接口是 HTTP 接口，但是需要签名认证，且签名方法不公开的
2. 第三方接口为订阅接口，需要程序长时间监听的
3. 第三方接口为私有协议，必须使用第三方提供的客户端才能访问的
4. 第三方接口无法提供 Python 版的 SDK，或提供的 Python 版 SDK 只支持 Python 2.7 的
5. 其他无法直接在 DataFlux Func 函数中访问的情况

在这些情况下，如果依然需要 DataFlux Func 来处理数据的话，
可以使用适配器`adapter`方式来实现 DataFlux Func 间接支持第三方接口。

### 3.1 对方接口为「请求-响应」模式

「请求-响应」模式指的是，服务端不会主动向客户端发送数据，
一次数据请求必须是由客户端发起请求，服务端对这个请求进行响应的流程。
典型例子：HTTP 协议。

那么，可以使用以下流程实现对接：

```

   +--------+
   | Client |
   +--------+
        |
        | AuthLink
        v
+---------------+            +---------+           +---------------------+
|               |            |         |           |                     |
| DataFlux Func |<== HTTP ==>| Adapter |<== ??? ==>| Third Party Service |
|               |            |         |           |                     |
+---------------+            +---------+           +---------------------+

```

适配器`Adapter`在上述流程中，扮演协议转换器的角色，
将标准 HTTP 协议和第三方黑盒协议相互转换，以实现对接目的。

### 3.2 对方接口为「订阅-发布」模式

「订阅-发布」模式指的是，客户端长连接到服务器，并订阅特定主题，
之后即可接收来自服务器端，或者其他客户端发布到这个主题的数据。
典型例子为：Redis 的 PubSub 功能、Kafka、各种消息队列。

那么，可以使用以下流程实现对接：

```

   +--------+
   | Client |
   +--------+
        |
        | AuthLink
        v
+---------------+            +---------+                 +---------------------+
|               |            |         |--- subscribe -->|                     |
| DataFlux Func |<== HTTP ==>| Adapter |---  publish  -->| Third Party Service |
|               |            |         |<-- on message --|                     |
+---------------+            +---------+                 +---------------------+

```

适配器`Adapter`在上述流程中，扮演第三方服务客户端和数据转发者的角色，
并在启动后，直接向第三方服务注册/订阅。

- DataFlux Func 发布消息：函数中调用适配器的 HTTP 接口，适配器将数据发布到第三方服务
- DataFlux Func 接收消息：适配器在收到特定消息后，调用 DataFlux Func 的对应授权链接
