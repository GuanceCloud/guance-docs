# 开发手册 - 基础
---


本文档为在 DataFlux Func 上开发脚本的最基础文档，阅读后可以实现在 DataFlux Func 上进行最基础的开发、使用工作。

## A. 重要提示

*在 DataFlux Func 的使用过程中，*

*请勿多人登录同一个账号，也不要多人同时编辑同一份代码。*

*以免造成代码相互覆盖、丢失的问题*

## B. 一般约定

DataFlux Func 中，存在脚本集、脚本、函数等概念，当提及这些概念的 ID 时，具体如下：

假设存在一个脚本集，ID 为`demo`；其下有脚本，ID 为`demo__test`；包含一个函数`def hello(...)`。那么：

| 项目      | ID                 |
| --------- | ------------------ |
| 脚本集 ID | `demo`             |
| 脚本 ID   | `demo__test`       |
| 函数 ID   | `demo__test.hello` |

## C. 内置功能的参数传递

本文档中所有出现的*可选参数*，应当使用命名方式传递，如：

```python
DFF.SRC('mysql', database='my_database')
```

## 1. 开始编写第一个函数

在 DataFlux Func 中编写代码，与正常编写 Python 代码并无太大区别。
对于需要导出为 API 的函数，添加内置的`@DFF.API(...)`装饰器即可实现。

函数的返回值即接口的返回值，当返回值为`dict`、`list`时，系统会自动当作 JSON 返回。

一个典型的函数如下：

```python
@DFF.API('Hello, world')
def hello_world(message=None):
    ret = {
        'message': message
    }
    return ret
```

此时，为本函数创建一个授权链接，即可实现在公网通过 HTTP 的方式调用本函数。

### 1.1 支持文件上传的函数

DataFlux Func 也支持向授权链接接口上传文件。

需要处理上传的文件时，可以为函数添加`files`参数接收上传的文件信息。
文件在上传后，DataFlux Func 会自动将文件存储到一个临时上传目录供脚本进行后续处理。

具体 Python 代码示例如下：

```python
# 接收 Excel 文件，并将 Sheet1 内容返回
from openpyxl import load_workbook

@DFF.API('读取 Excel')
def read_excel(files=None):
    excel_data = []
    if files:
        workbook = load_workbook(filename=files[0]['filePath'])
        for row in workbook['Sheet1'].iter_rows(min_row=1, values_only=True):
            excel_data.append(row)

    return excel_data
```

`files`参数由 DataFlux Func 系统自动填入，内容如下：

```json
[
    {
        "filePath"    : "<文件临时存放地址>",
        "originalname": "<文件原始文件名>",
        "encoding"    : "<编码>",
        "mimetype"    : "<MIME 类型>",
        "size"        : "<文件大小>"
    },
    ...
]
```

> 上传文件的示例命令见「调用授权链接 - `POST`简化传参」

## 2. 调用函数

DataFlux Func 平台提供了多种执行功能用于调用被`DFF.API(...)`修饰的函数：

| 执行功能 | 特点                                                | 适用场景                                   |
| -------- | --------------------------------------------------- | ------------------------------------------ |
| 授权链接 | 生成同步 HTTP API。调用后直接返回处理结果           | 处理时间较短，客户端需要立刻获得结果的情况 |
| 自动触发 | 基于 Crontab 语法自动执行                           | 定期同步/缓存数据，定时任务等情况          |
| 批处理   | 生成异步 HTTP API。调用后立刻响应，但不返回处理结果 | 处理时间较长，接口调用仅作为启动信号的场景 |

用户可以在「管理」中的对应入口，创建上述配置。

### 2.1 通过授权链接调用

为函数创建授权链接后，支持多种不同的调用方式。
授权链接支持`GET`、`POST`两种方式。两种不同方式的参数传递同时支持「简化形式」、「标准形式」。

此外，`POST`方式的「简化」形式还支持文件上传，以下是各种调用方式的功能支持列表：

| 调用方式       | 传递`kwargs`参数 | `kwargs`参数类型  | 传递`options` | 文件上传 | 提交任意格式的`Body`<br>`1.6.9`以后可用 |
| -------------- | ---------------- | ----------------- | ------------- | -------- | --------------------------------------- |
| `GET`简化形式  | 支持             | *仅限字符串*      | *不支持*      | *不支持* | *不支持*                                |
| `GET`标准形式  | 支持             | JSON 中的数据类型 | 支持          | *不支持* | *不支持*                                |
| `POST`简化形式 | 支持             | *仅限字符串*      | *不支持*      | 支持     | 支持                                    |
| `POST`标准形式 | 支持             | JSON 中的数据类型 | 支持          | *不支持* | *不支持*                                |

> 提示：对于*`kwargs`中参数只能传递字符串*的调用方式，需要在函数中对参数进行类型转换

> 在授权链接列表，可以点击「API 调用示例」来查看具体调用方式

#### 典型示例

假设存在如下函数：

```python
@DFF.API('我的函数')
def my_func(x, y):
    pass
```

为此函数创建的授权链接 ID 为`auln-xxxxx`，传递的参数为`x` = `100`（整数）, `y` = `"hello"`（字符串）。

那么，各种不同的调用方式如下：

##### `GET`简化形式传参

如果函数的参数比较简单，可以使用`GET`简化形式传递参数，接口将更加直观。

由于 URL 中传递参数时，无法区分字符串的`"100"`和整数的`100`，
所以函数在被调用时，接收到的参数都是字符串。
函数需要自行对参数进行类型转换。

```
GET /api/v1/al/auln-xxxxx/simplified?x=100&y=hello
```

*注意：为了便于阅读，示例为 URLEncode 之前的内容，实际 URL 参数需要进行 URLEncode*

##### `GET`标准形式传参

在某些情况下，如果无法发送 POST 请求，也可以使用 GET 方式调用接口。

`GET`标准形式传参时，将整个`kwargs`进行 JSON 序列化后，作为 URL 参数传递即可。
由于参数实际还是以 JSON 格式发送，因此参数的原始类型都会保留。
函数无需再对参数进行类型转换。

如本例中，函数接收到的`x`参数即为整数，无需类型转换。

```
GET /api/v1/al/auln-xxxxx?kwargs={"x":100,"y":"hello"}
```

*注意：为了便于阅读，示例为 URLEncode 之前的内容，实际 URL 参数需要进行 URLEncode*

##### `POST`简化形式传参

在某些情况下，如果无法发送请求体为 JSON 的 HTTP 请求，
那么也可以类似 Form 表单的形式传递参数，各字段名即为参数名。

由于 Form 表单提交数据时，无法区分字符串的`"100"`和整数的`100`，
所以函数在被调用时，接收到的参数都是字符串。
函数需要自行对参数进行类型转换。

```
POST /api/v1/al/auln-xxxxx/simplified
Content-Type: x-www-form-urlencoded

x=100&y=hello
```

此外，`POST`简化形式传参还额外支持文件上传（参数/字段名必须为`files`），
需要使用`form-data/multipart`方式进行处理。

页面`HTML`代码示例如下：

```html
<html>
    <body>
        <h1>文件上传</h1>
        <input id="file" type="file" name="files" required />
        <input id="submit" type="submit" value="上传"/>
    </body>
    <script>
        // 授权链接地址（如本页面与 DataFlux Func 不在同一个域名下，需要写全 http://域名：端口/api/v1/al/auln-xxxxx/simplified
        // 注意：上传文件必须使用简化形式授权链接
        var AUTH_LINK_URL = '/api/v1/al/auln-xxxxx/simplified';

        document.querySelector('#submit').addEventListener('click', function(event) {
            // 点击上传按钮后，生成 FormData 对象后作为请求体发送请求
            var data = new FormData();
            data.append('x', '100');
            data.append('y', 'hello');
            data.append('files', document.querySelector('#file').files[0]);

            var xhr = new XMLHttpRequest();
            xhr.open('POST', AUTH_LINK_URL);
            xhr.send(data);
        });
    </script>
</html>
```

##### `POST`标准形式传参

`POST`标准形式传参是最常见的调用方式。
由于参数以 JSON 格式通过请求体发送，因此参数的原始类型都会保留。
函数无需再对参数进行类型转换。

如本例中，函数接收到的`x`参数即为整数，无需类型转换。

```
POST /api/v1/al/auln-xxxxx
Content-Type: application/json

{
    "kwargs": {
        "x": 100,
        "y": "hello"
    }
}
```

#### 处理非 JSON、From 数据

> `1.6.9`版本新增

在某些情况下，请求可能由第三方系统或应用按照其特有的格式发起，且请求体不属于 JSON 或 Form 格式，那么可以使用`**data`作为入参，并以 POST 简化形式来调用。

系统在接收到文本、无法解析的数据时，会自动打包为`{ "text": "<文本>" }`或`{ "base64": "<Base64 格式的二进制数据>"}`并传递给函数。

示例代码如下：

~~~python
import json
import binascii

@DFF.API('接受任意格式 Body 的函数')
def tiger_balm(**data):
    if 'text' in data:
        # 当请求体为文本（如：Content-Type: text/plain）时
        # `data`参数中固定包含一个单独`text`字段存放内容
        return f"文本：{data['text']}"

    elif 'base64' in data:
        # 当请求体为无法解析的格式（Content-Type: application/xxx）时
        # `data`参数中固定包含一个单独`base64`字段存放请求体的 Base64 字符串
        # Base64 字符串可以使用`binascii.a2b_base64(...)`转换为 Python 的二进制数据
        b = binascii.a2b_base64(data['base64'])
        return f"Base64：{data['base64']} -> {b}"
~~~

##### 请求体为文本时

请求如下：

```shell
curl -X POST -H "Content-Type: text/plain" -d 'hello, world!' http://localhost:8089/api/v1/al/auln-unknow-body/simplified
```

输出如下：

```
文本：hello, world!
```

##### 请求体为未知格式时

请求如下：

```shell
curl -X POST -H "Content-Type: unknow/type" -d 'hello, world!' http://localhost:8089/api/v1/al/auln-unknow-body/simplified
```

输出如下：

```
Base64：aGVsbG8sIHdvcmxkIQ== -> b'hello, world!'
```

### 2.2 通过自动触发配置调用

为函数创建自动触发配置后，函数则会所指定的 Crontab 表达式定时执行，不需要外部进行调用。

正因为如此，所执行的函数的所有参数必须都已满足，即：

1. 函数不需要输入参数
2. 函数需要输入参数，但都是可选参数
3. 函数需要必选参数，并在自动触发配置中为其配置具体的值

#### 区分函数运行时所属执行功能

如果函数同时配置了「自动触发配置」和其他执行功能，并且希望在不同的执行功能中进行区分处理，可以判断内置变量`_DFF_CRONTAB`区分：

```python
@DFF.API('我的函数')
def my_func(x, y):
    result = x + y

    if _DFF_CRONTAB:
        # 只在自动触发配置时输出日志
        print(f'x + y = {result}')

    return
```

### 2.3 通过批处理调用

> 批处理除了不返回处理结果外，调用方式与「授权链接」相同，请参考上文「通过授权链接调用」进行操作。

### 2.4 额外的 API 认证

> `1.3.2`版本新增

对于「授权链接」和「批处理」所生成的 HTTP API，可以额外添加接口认证。

目前支持的接口认证如下：

| 认证类型    | 说明                                                        |
| ----------- | ----------------------------------------------------------- |
| 固定字段    | 验证请求的 Header, Query 或 Body 中必须包含具有特定值的字段 |
| HTTP Basic  | 标准 HTTP Basic 认证（在浏览器中访问可弹出登录框）          |
| HTTP Digest | 标准 HTTP Digest 认证（在浏览器中访问可弹出登录框）         |
| 认证函数    | 指定自行编写的函数作为认证函数                              |

用户可以在「管理 - API 认证」添加认证配置，随后在「授权链接/批处理 配置」中指定所添加的认证配置。

*注意：如对安全性有较高要求，请务必使用 HTTPS 方式访问接口*

#### 固定字段认证

固定字段认证是最简单的认证方式，即客户端与 DataFlux Func 约定在请求的某处（Header、Query 或 Body）包含一个特定的字段和字段值，在每次调用时附带此内容以完成认证。

假设约定每次请求中，请求头必须包含`x-auth-token`=`"my-auth-token"`，那么按照以下方式调用即可完成认证：

```
GET /api/v1/al/auln-xxxxx
x-auth-token: my-auth-token
```

*注意：配置多个固定字段认证时，有一个匹配即认为通过认证*

*注意：对于 Query 和 Body 中用于认证的字段，认证通过后系统会自动将其删除，不会传递到函数*

#### HTTP Basic / HTTP Digest

浏览器直接支持的认证方式。

使用此方式认证的接口，在浏览器地址栏中直接访问时，浏览器会弹出用户名/密码框供用户填写。

如需要使用编程方式访问，请参考如下代码：

```python
import requests
from requests.auth import HTTPBasicAuth, HTTPDigestAuth

# HTTP Basic 认证
resp = requests.get(url_1, auth=HTTPBasicAuth('user', 'password'))

# HTTP Digest 认证
resp = requests.get(url_2, auth=HTTPDigestAuth('user', 'password'))
```

#### 认证函数

如果接口认证方式复杂或特殊（如需要对接业务系统等），可以选择自行编写函数方式认证。

用于认证的函数必须满足「有且只有一个`req`参数，作为请求」，返回`True`或`False`表示认证成功或失败。

参数`req`是一个`dict`，具体结构如下：

| 字段名      | 字段值类型 | 说明                                                                                                  |
| ----------- | ---------- | ----------------------------------------------------------------------------------------------------- |
| method      | `str`      | 请求方法（大写）<br>如：`"GET"`、`"POST"`                                                             |
| originalUrl | `str`      | 请求原始 URL。包含`?`后的部分<br>如：`/api/v1/al/auln-xxxxx?q=1`                                      |
| url         | `str`      | 请求 URL。不包含`?`后的部分<br>如：`/api/v1/al/auln-xxxxx`                                            |
| headers     | `dict`     | 请求 Header，字段名均为小写                                                                           |
| query       | `dict`     | 请求 Query，字段名和字段值都为字符串                                                                  |
| body        | `dict`     | 请求 Body                                                                                             |
| hostname    | `str`      | 请求访问的主机名。不包含端口号部分<br>如：`example.com`                                               |
| ip          | `str`      | 客户端 IP<br>*注意：此字段需要 Nginx、阿里云 SLB 等正确配置才有意义*                                  |
| ips         | `list`     | 客户端 IP 及所有中间代理服务器 IP 地址列表<br>*注意：此字段需要 Nginx、阿里云 SLB 等正确配置才有意义* |
| ips[#]      | `str`      | 中间代理服务器 IP                                                                                     |
| xhr         | `bool`     | 是否为 ajax 请求                                                                                      |

一个简单的示例如下：

```python
@DFF.API('认证函数')
def my_auth_func(req):
    return req['headers']['x-auth-token'] == 'my-auth-token'
```
