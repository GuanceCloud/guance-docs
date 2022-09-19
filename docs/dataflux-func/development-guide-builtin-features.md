# 开发手册 - 内置功能
---


为了方便脚本编写，以及在脚本中使用各种 DataFlux Func 提供的功能。
DataFlux Func 在脚本运行上下文注入了一些额外功能。

这些功能都封装在 DFF 对象中（如前文出现的`@DFF.API(...)`）

## 1. 输出日志 print(...)

由于脚本编辑器是 Web 应用程序，
不同于一般意义上的 IDE，不支持进行单步调试等操作。
因此，调试可以依靠运行时输出日志进行。

为了让日志输出能够被 DataFlux Func 搜集并显示到脚本编辑器中，
DataFlux Func 重新封装了`print(...)`函数，
使其可以将输出内容通过 Web 页面展现出来。如：

```python
print('Some log message')
```

## 2. 导出函数 DFF.API(...)

一个装饰器，用于将被修饰的函数对外开放，允许使用 API 方式调用。

详细参数列表如下：

| 参数                 | 类型                | 必须/默认值 | 说明                                                                         |
| -------------------- | ------------------- | ----------- | ---------------------------------------------------------------------------- |
| `title`              | str                 | 必须        | 函数导出的展示名，主要用于在展示                                             |
| `catetory`           | str                 | `"general"` | 函数所属类别，主要用于函数列表的分类/筛选                                    |
| `tags`               | list                | `None`      | 函数标签列表，主要用于函数列表的分类/筛选                                    |
| `tags[#]`            | str                 | 必须        | 函数标签                                                                     |
| `timeout`            | int                 | `30`/`3600` | 函数超时时间。<br>单位：秒，取值范围`1 ~ 3600`                               |
| `api_timeout`        | int                 | `10`        | 通过 API 调用函数时，API 调用超时时间。<br>单位：秒，取值范围`1 ~ 180`       |
| `cache_result`       | int                 | `None`      | 缓存结果数据时长。<br>单位：秒，`None`表示不缓存                             |
| `fixed_crontab`      | str(Crontab-format) | `None`      | 当函数由自动触发执行时，强制固定的 Crontab 配置。<br>最小支持分钟级          |
| `delayed_crontab`    | list                | `None`      | 当函数由自动触发执行时，启动后延迟执行时间，设置多个表示按照不同延迟多次执行 |
| `delayed_crontab[#]` | int                 | 必须        | 延迟执行秒数。<br>单位：秒                                                   |

各参数的详解见下文：

### 参数 title

函数标题支持中文，方便在 DataFlux Func 各种操作界面/文档中展示函数名称。

示例如下：

```python
@DFF.API('我的函数')
def my_func():
    pass
```

### 参数 category / tags

函数所属分类、标签列表，本身并不参与也不控制函数的运行，主要用于方便分类管理函数。
分别使用或者各自单独使用都可以。

示例如下：

```python
@DFF.API('我的函数', category='demo', tags=['tag1', 'tag2']):
def my_func():
    pass
```

指定后，可通过指定筛选参数来过滤函数列表，如：

```
# 根据 category 筛选
GET /api/v1/func-list?category=demo

# 根据 tags 筛选（指定多个 tag 表示「同时包含」）
GET /api/v1/func-list?tags=tag1,tag2
```

### 参数 timeout / api_timeout

为了保护系统，所有在 DataFlux Func 中运行的函数都有运行时长限制，不允许无限制地运行下去。
其中，`timeout`控制「函数本身的运行时长」，而`api_timeout`控制在「授权链接中，API 返回的超时时长」。

以下是两者控制范围：

| 场景         | `timeout`参数，默认值                                                                               | `api_timeout`参数             |
| ------------ | --------------------------------------------------------------------------------------------------- | ----------------------------- |
| 授权链接     | 默认值`30`<br>当大于`api_timeout`时，自动缩短到与`api_timeout`相同<br>即`MIN(timeout, api_timeout)` | 控制 API 返回超时，默认值`10` |
| 自动触发配置 | 默认值`30`                                                                                          | *不起作用*                    |
| 批处理       | 默认值`3600`                                                                                        | *不起作用*                    |

授权链接`timeout`详细取值逻辑如下：

| `timeout`          | `api_timeout`      | 最终`timeout`取值 |
| ------------------ | ------------------ | ----------------- |
| 未指定（默认`30`） | 未指定（默认`10`） | `10`              |
| `3`                | 未指定（默认`10`） | `3`               |
| 未指定（默认`30`） | `3`                | `3`               |
| `3`                | `10`               | `3`               |
| `10`               | `3`                | `3`               |

示例如下：

```python
@DFF.API('我的函数', timeout=30, api_timeout=15):
def my_func():
    # 此函数
    # 1. 在「授权链接」中最多运行 15 秒
    # 2. 在「自动触发配置」「批处理」中最多运行 30 秒
    pass
```

*注意：一个 HTTP 接口响应时间超过 3 秒即可认为非常缓慢。应当注意不要为函数配置无意义的超长超时时间*

*注意：大量长耗时授权链接请求会导致任务队列堵塞，必要时应使用缓存技术*

### 参数 cache_result

DataFlux Func 内置了 API 层面的缓存处理。
在指定的缓存参数后，当调用完全相同的函数和参数时，系统会直接返回缓存的结果。

示例如下：

```python
@DFF.API('我的函数', cache_result=30):
def my_func():
    pass
```

*注意：命中缓存后，API 会直接返回结果，而函数并不会实际执行*

命中缓存后，返回的 HTTP 请求头会添加如下标示：

```
X-Dataflux-Func-Cache: Cached
```

### 参数 fixed_crontab

对于某些会用于自动触发配置的函数，函数编写者可能会对自动运行的频率有要求。
此时，可以指定本参数，将属于本函数的自动触发配置固定为指定的 Crontab 表达式。

示例如下：

```python
@DFF.API('我的函数', fixed_crontab='*/5 * * * *'):
def my_func():
    pass
```

### 参数 delayed_crontab

对于某些用于自动触发配置的函数，函数编写者可能希望以更精确的时间运行（如在`* * * * *`的基础上，延迟 10 秒运行）。
此时，可以指定本参数，在指定延迟的秒数。同时，也可以传入秒数的数组，到达各个指定延迟时运行。

*注意：本参数只能保证在指定的时间后运行，并不能保证到达指定的时间后一定运行*

*注意：本参数不适用于「存在长时间自动触发任务」的情况，无论这些长时间任务是否与延迟执行有关*

示例如下：

```python
@DFF.API('我的函数', delayed_crontab=10):
def my_func():
    '''
    延迟 10 秒执行
    '''
    pass

@DFF.API('我的函数 2', delayed_crontab=[0, 10]):
def my_func_2():
    '''
    延迟 0、10 秒执行，共执行 2 次
    '''
    pass
```

## 3. 操作数据源 DFF.SRC(...)

一个函数，用于返回指定的数据源操作对象。

示例如下：

```python
@DFF.API('InfluxDB 操作演示')
def influxdb_demo():
    db = DFF.SRC('demo_influxdb')
    return db.query('SELECT * FROM demo LIMIT 3')
```

如数据源配置了默认数据库，则查询会在默认数据库进行。

如数据源没有配置默认数据库，或在查询时需要查询不同的数据库，可在获取数据源操作对象时，指定数据库 database 参数，如：

```python
db = DFF.SRC('demo_influxdb', database='my_database')
```

*注意：某些数据库不支持查询时更换数据库。需要操作不同数据库时，可以创建多个数据源来进行操作。*

对于 DataWay，可以获取数据源操作对象时指定`rp`和`token`参数，如：

```python
dataway = DFF.SRC('df_dataway', token='xxxxx', rp='rp0')
```

由于数据源具有不同类型，使用`DFF.SRC(...)`时，各个数据源操作对象的可选参数，支持方法并不相同。

具体不同类型数据源的详细 API 接口见下文

## 4. 获取环境变量 DFF.ENV(...)

在脚本编辑器左侧边栏配置的所有环境变量，
都可以在脚本中使用配置的 ID 获取对应的环境变量值。

示例代码如下：

```python
company_name = DFF.ENV('companyName')
# '上海驻云信息科技有限公司'

company_name = DFF.ENV('不存在的环境变量')
# None
```

如环境变量在配置时指定了类型，
取出时会自动转换为特定类型，不必额外进行类型转换。

但由于类型转换可能会因为配置错误而转换失败，
因此考虑到程序健壮性，应当加入默认值处理，如：

```python
page_size = 10
try:
    page_size = DFF.ENV('pageSize') or page_size
except Exception as e:
    pass
```

## 5. 接口响应控制（数据） DFF.RESP(...)

函数的返回值，除了以往直接返回字符串、JSON 外，可使用`DFF.RESP(...)`进行细节控制。

| 参数           | 类型          | 必须/默认值 | 说明                                                                               |
| -------------- | ------------- | ----------- | ---------------------------------------------------------------------------------- |
| `data`         | str/dict/list | 必须        | 指定返回的数据                                                                     |
| `status_code`  | int           | `200`       | 指定响应状态码                                                                     |
| `content_type` | str           | `None`      | 指定响应体类型，如`json`, `text`, `html`等                                         |
| `headers`      | dict          | `None`      | 指定 HTTP 响应头（此处不需要重复填写`Content-Type`）                               |
| `allow_304`    | bool          | `False`     | 指定为`True`时，允许浏览器 304 缓存                                                |
| `download`     | str           | `False`     | 指定下载文件名，并将数据作为文件下载<br>*指定本参数后，`content_type`参数不再起效* |

*注意：如果开启`allow_304`，允许浏览器 304 缓存，可以实现接口性能提升。但也可能会因为缓存导致客户端无法及时从接口获取最新内容*

*注意：指定`download`参数后，系统会自动根据文件扩展名填充`Content-Type`，而`content_type`参数会被忽略*

常见用例如下：

```python
@DFF.API('用例 1')
def case_1():
    '''
    返回一个由函数内生成的 HTML 页面
    '''
    data = '''<h1>Hello, World!</h1>'''
    return DFF.RESP(data, content_type='html')

@DFF.API('用例 2')
def case_2():
    '''
    返回由函数生成的 JSON 数据
    与 return {"hello": "world"} 等价
    '''
    data = '''{"hello": "world"}'''
    return DFF.RESP(data, content_type='json')

@DFF.API('用例 3')
def case_3():
    '''
    下载由函数生成的文件，并命名为`文章。txt`
    '''
    data = '''Some text'''
    return DFF.RESP(data, download='文章。txt')

@DFF.API('用例 4')
def case_4():
    '''
    指定额外的响应头
    '''
    data = '''<h1>Hello, World!</h1>'''
    headers = {
        'X-Author': 'Tom',
    }
    return DFF.RESP(data, content_type='html', headers=headers)
```

## 6. 接口响应控制（文件） DFF.RESP_FILE(...)

当返回的内容为「磁盘上的文件」时，可使用`DFF.RESP_FILE(...)`进行细节控制。

| 参数          | 类型     | 必须/默认值 | 说明                                                                                                                            |
| ------------- | -------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `file_path`   | str      | 必须        | 指定返回文件的路径（相对于资源文件目录）                                                                                        |
| `status_code` | int      | `200`       | *与`DFF.RESP(...)`同名参数相同*                                                                                                 |
| `headers`     | dict     | `None`      | *与`DFF.RESP(...)`同名参数相同*                                                                                                 |
| `allow_304`   | bool     | `False`     | *与`DFF.RESP(...)`同名参数相同*                                                                                                 |
| `auto_delete` | bool     | `False`     | 指定为`True`时，文件下载后自动从磁盘中删除                                                                                      |
| `download`    | bool/str | `True`      | 默认下载文件且保存名与原始文件名相同<br>指定为`False`时，让浏览器尽可能直接打开文件<br>指定为字符串时，按指定的值作为下载文件名 |

> 提示：`DFF.RESP_FILE(...)`会自动根据文件扩展名填充 HTTP 的`Content-Type`头，默认以`file_path`为准，指定`download`字符串时则以`download`值作为文件名下载

> 提示：「资源文件目录」指的是容器内的`/data/resources`文件夹，正常部署后此文件夹会挂载到宿主机磁盘实现持久化存储

示例如下：

```python
@DFF.API('用例 1')
def case_1():
    '''
    下载资源文件目录下 user-guide.pdf 文件
    '''
    return DFF.RESP_FILE('user-guide.pdf')

@DFF.API('用例 2')
def case_2():
    '''
    让浏览器在线打开资源目录下的`user-guide.pdf`文件
    '''
    return DFF.RESP_FILE('user-guide.pdf', download=False)

@DFF.API('用例 3')
def case_3():
    '''
    浏览器打开资源目录下 index.html 页面
    '''
    return DFF.RESP_FILE('index.html', download=False)

@DFF.API('用例 4')
def case_4():
    '''
    下载资源文件目录下的 servey.xlsx 文件，并保存为「调查表。xlsx」
    '''
    return DFF.RESP_FILE('servey.xlsx', download='调查表。xlsx')

@DFF.API('用例 5')
def case_5():
    '''
    指定额外的响应头
    '''
    headers = {
        'X-Author': 'Tom',
    }
    return DFF.RESP_FILE('user-guide.pdf', headers=headers)
```

## 7. 接口响应控制（大量数据） DFF.RESP_LARGE_DATA(...)

> `1.3.0`版本新增

当需要返回大量内容（MB 级别及以上）时，直接通过`return`方式返回可能会因系统内部通讯处理等导致性能大幅下降。
此时，可使用`DFF.RESP_LARGE_DATA(...)`提升性能。

| 参数           | 类型          | 必须/默认值 | 说明                                       |
| -------------- | ------------- | ----------- | ------------------------------------------ |
| `data`         | str/dict/list | 必须        | 指定返回的数据                             |
| `content_type` | str           | `None`      | 指定响应体类型，如`json`, `text`, `html`等 |

*注意：使用此方法时，必须保证资源目录配置、挂载正确，所有的 Web 服务器和工作单元都能正常访问到同一个共享目录*

常见用例如下：

```python
@DFF.API('用例 1')
def case_1():
    data = {} # 大量数据（MB 级别及以上）

    return DFF.RESP_LARGE_DATA(data)
```

### 原理说明

DataFlux Func 底层由 Web 服务器和工作单元通过作为消息队列的 Redis 组合而成。直接`return`的数据，会被序列化后送入消息队列，再由 Web 服务器返回给调用方。

由于 JSON 的序列化/反序列化，Redis 上进行的入队出队、内部网络通讯等，都会因为单个 JSON 数据尺寸过大而导致性能下降。

本函数在底层实质上做了如下操作：
1. 将需要返回的数据作为文件保存到资源目录`download`目录下
2. 将请求作为「文件下载」响应（即上文中的`DFF.RESP_FILE`）
3. Web 服务器直接从资源目录中读取上述 1. 中保存的文件返回给客户端

通过此「绕行」的方法，使得系统内部通讯层面的处理轻量化以提升性能。

### 性能对比

以下是同样返回大约 3.5MB 大小的 JSON 时的性能对比：

- 通过`return data`直接返回 JSON 时，耗费 18 秒时间

```shell
$ time wget http://172.16.35.143:8089/api/v1/al/auln-Ljo3y8HMUl91
--2021-09-16 22:40:09--  http://172.16.35.143:8089/api/v1/al/auln-Ljo3y8HMUl91
正在连接 172.16.35.143:8089... 已连接。
已发出 HTTP 请求，正在等待回应。.. 200 OK
长度：3363192 (3.2M) [application/json]
正在保存至：“auln-Ljo3y8HMUl91”

auln-Ljo3y8HMUl91            100%[=============================================>]   3.21M  --.-KB/s  用时 0.06s

2021-09-16 22:40:27 (50.4 MB/s) - 已保存 “auln-Ljo3y8HMUl91” [3363192/3363192])

wget http://172.16.35.143:8089/api/v1/al/auln-Ljo3y8HMUl91  0.00s user 0.02s system 0% cpu 18.321 total
```

- 通过`return DFF.RESP_LARGE_DATA(data)`返回 JSON 时，仅耗费不足 1 秒时间

```shell
$ time wget http://172.16.35.143:8089/api/v1/al/auln-HPrfGRKIhYET
--2021-09-16 22:40:50--  http://172.16.35.143:8089/api/v1/al/auln-HPrfGRKIhYET
正在连接 172.16.35.143:8089... 已连接。
已发出 HTTP 请求，正在等待回应。.. 200 OK
长度：3687382 (3.5M) [application/json]
正在保存至：“auln-HPrfGRKIhYET”

auln-HPrfGRKIhYET            100%[=============================================>]   3.52M  --.-KB/s  用时 0.02s

2021-09-16 22:40:50 (183 MB/s) - 已保存 “auln-HPrfGRKIhYET” [3687382/3687382])

wget http://172.16.35.143:8089/api/v1/al/auln-HPrfGRKIhYET  0.00s user 0.02s system 12% cpu 0.174 total
```

## 8. 内置简易 Scope-Key-Value 存储 `DFF.STORE`

DataFlux Func 内置了简易的持久化存储功能。
对于一些有数据存储需求，同时需求并不复杂的场景，可以直接使用本内置存储功能。

存储功能为`Scope-Key-Value`结构，不同命名空间下，允许存在相同的 Key。

> 提示：写入的数据会自动序列化，同时读取时也会自动反序列化。使用时无需手工做序列化处理

### DFF.STORE.set(...)

`DFF.STORE.set(...)`方法用于存储数据，参数如下：

| 参数         | 类型                   | 必须/默认值 | 说明                                         |
| ------------ | ---------------------- | ----------- | -------------------------------------------- |
| `key`        | str                    | 必须        | 键名                                         |
| `value`      | 任意可 JSON 序列化对象 | 必须        | 数据                                         |
| `scope`      | str                    | 当前脚本名  | 命名空间                                     |
| `expire`     | int                    | `None`      | 过期时间。<br>单位：秒<br>`None`表示永不过期 |
| `not_exists` | bool                   | `False`     | 是否仅在数据不存在时写入                     |

示例如下：

```python
DFF.STORE.set('user:user-001', { 'name': '张三' }, scope='users')
```

### DFF.STORE.get(...)

`DFF.STORE.get(...)`方法用于获取存储的数据，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `scope` | str  | 当前脚本名  | 命名空间 |

> 提示：当尝试获取的内容不存在时，返回值为`None`

示例如下：

```python
DFF.STORE.set('user:user-001', { 'name': '张三' }, scope='users')
DFF.STORE.get('user:user-001', scope='users')
# { 'name': '张三' }
```

### DFF.STORE.delete(...)

`DFF.STORE.delete(...)`方法用于删除存储的数据，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `scope` | str  | 当前脚本名  | 命名空间 |

> 提示：删除不存在的内容也不会报错

示例如下：

```python
DFF.STORE.delete('user:user-001', scope='users')
```

## 9. 内置简易 Scope-Key-Value 缓存 DFF.CACHE

DataFlux Func 内置了基于 Redis 的简易缓存功能。
对于一些有缓存需求，同时需求并不复杂的场景，可以直接使用本内置缓存功能。

存储功能为`Scope-Key-Value`结构，不同命名空间下，允许存在相同的 Key。

> 提示：写入/读取数据不会自动自动序列化/反序列化，使用时需要在脚本中自行处理

### DFF.CACHE.set(...)

`DFF.CACHE.set(...)`方法用于建立缓存，参数如下：

| 参数         | 类型          | 必须/默认值 | 说明                                         |
| ------------ | ------------- | ----------- | -------------------------------------------- |
| `key`        | str           | 必须        | 键名                                         |
| `value`      | str/int/float | 必须        | 数据                                         |
| `scope`      | str           | 当前脚本名  | 命名空间                                     |
| `expire`     | int           | `None`      | 过期时间。<br>单位：秒<br>`None`表示永不过期 |
| `not_exists` | bool          | `False`     | 是否仅在数据不存在时写入                     |

示例如下：

```python
DFF.CACHE.set('user:count', 100, scope='stat')
# 此时缓存值为：'100'
```

### DFF.CACHE.get(...)

`DFF.CACHE.get(...)`方法用于获取缓存，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.set('user:count', 100, scope='stat')
DFF.CACHE.get('user:count', scope='stat')
# '100'
```

### DFF.CACHE.getset(...)

`DFF.CACHE.getset(...)`方法用于设置缓存的同时，获取之前的值，参数如下：

| 参数    | 类型          | 必须/默认值 | 说明     |
| ------- | ------------- | ----------- | -------- |
| `key`   | str           | 必须        | 键名     |
| `value` | str/int/float | 必须        | 数据     |
| `scope` | str           | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.set('user:count', 100, scope='stat')
DFF.CACHE.getset('user:count', 200, scope='stat')
# '100'
# 此时缓存值为：'200'
```

### DFF.CACHE.expire(...)

`DFF.CACHE.expire(...)`方法用于设置缓存的过期时间，参数如下：

| 参数     | 类型 | 必须/默认值 | 说明                                         |
| -------- | ---- | ----------- | -------------------------------------------- |
| `key`    | str  | 必须        | 键名                                         |
| `expire` | int  | `None`      | 过期时间。<br>单位：秒<br>`None`表示永不过期 |
| `scope`  | str  | 当前脚本名  | 命名空间                                     |

示例如下：

```python
DFF.CACHE.expire('user:count', 3600, scope='stat')
```

### DFF.CACHE.delete(...)

`DFF.CACHE.delete(...)`方法用于删除存储的数据，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.delete('user:count', scope='stat')
```

### DFF.CACHE.incr(...)

`DFF.CACHE.incr(...)`方法用于对缓存值增加步进，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `step`  | int  | `1`         | 步进值   |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.incr('user:count', scope='stat')
# 此时缓存值为：'2'
```

### DFF.CACHE.hkeys(...)

`DFF.CACHE.hkeys(...)`方法用于获取哈希结构字段列表，参数如下：

| 参数      | 类型 | 必须/默认值 | 说明         |
| --------- | ---- | ----------- | ------------ |
| `key`     | str  | 必须        | 键名         |
| `pattern` | str  | `"*"`       | 字段匹配模式 |
| `scope`   | str  | 当前脚本名  | 命名空间     |

示例如下：

```python
DFF.CACHE.hmset('user:001', { 'name': 'Tom', 'city': 'Beijing' }, scope='cachedInfo')
DFF.CACHE.hkeys('user:001', scope='userCache')
# ['name', 'city']
```

### DFF.CACHE.hget(...)

`DFF.CACHE.hget(...)`方法用于获取哈希结构中一个/多个/全部字段值，参数如下：

| 参数    | 类型     | 必须/默认值 | 说明              |
| ------- | -------- | ----------- | ----------------- |
| `key`   | str      | 必须        | 键名              |
| `field` | str/list | `None`      | 字段名/字段名列表 |
| `scope` | str      | 当前脚本名  | 命名空间          |

示例如下：

```python
DFF.CACHE.hmset('user:001', { 'name': 'Tom', 'city': 'Beijing' }, scope='cachedInfo')
DFF.CACHE.hget('user:001', scope='cachedInfo')
# {'name': 'Tom', 'city': 'Beijing'}
DFF.CACHE.hget('user:001', ['name', 'city'], scope='cachedInfo')
# {'name': 'Tom', 'city': 'Beijing'}
DFF.CACHE.hget('user:001', 'name', scope='cachedInfo')
# 'Tom'
```
### DFF.CACHE.hset(...)

`DFF.CACHE.hset(...)`方法用于设置哈希结构中的某个字段值，参数如下：

| 参数         | 类型          | 必须/默认值 | 说明                     |
| ------------ | ------------- | ----------- | ------------------------ |
| `key`        | str           | 必须        | 键名                     |
| `field`      | str           | 必须        | 字段名                   |
| `value`      | str/int/float | 必须        | 数据                     |
| `scope`      | str           | 当前脚本名  | 命名空间                 |
| `not_exists` | bool          | `False`     | 是否仅在字段不存在时写入 |

示例如下：

```python
DFF.CACHE.hset('user:001', 'name', 'Tom', scope='cachedInfo')
# 此时缓存值为：{ 'name': 'Tom' }
```

### DFF.CACHE.hmset(...)

`DFF.CACHE.hmset(...)`方法用于设置哈希结构中的多个字段值，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `obj`   | dict | 必须        | 数据     |
| `scope` | str  | 当前脚本名  | 命名空间 |

```python
DFF.CACHE.hmset('user:001', { 'name': 'Tom', 'city': 'Beijing' }, scope='cachedInfo')
# 此时缓存值为：{ 'name': 'Tom', 'city': 'Beijing' }
```

### DFF.CACHE.hincr(...)

`DFF.CACHE.hincr(...)`方法用于对哈希结构中的字段增加步进，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `field` | str  | 必须        | 字段名   |
| `step`  | int  | `1`         | 步进值   |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.hincr('user:001', 'signCount', scope='cachedInfo')
# 此时缓存值为：{ 'signCount': '2' }
```

### DFF.CACHE.hdel(...)

`DFF.CACHE.hdel(...)`方法用于删除哈希结构中的某个字段，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `field` | str  | 必须        | 字段名   |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.hmset('user:001', { 'name': 'Tom', 'city': 'Beijing' }, scope='cachedInfo')
DFF.CACHE.hdel('user:001', 'city', scope='cachedInfo')
# 此时缓存值为：{ 'name': 'Tom' }
```

### DFF.CACHE.lpush(...)

`DFF.CACHE.lpush(...)`方法用于从*左侧*向列表结构添加元素，参数如下：

| 参数    | 类型          | 必须/默认值 | 说明     |
| ------- | ------------- | ----------- | -------- |
| `key`   | str           | 必须        | 键名     |
| `value` | str/int/float | 必须        | 数据     |
| `scope` | str           | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.lpush('userQueue', '001', scope='queue')
DFF.CACHE.lpush('userQueue', '002', scope='queue')
# 此时缓存值为：[ '002', '001' ]
```

### DFF.CACHE.rpush(...)

`DFF.CACHE.rpush(...)`方法用于从*右侧*向列表结构添加元素，参数如下：

| 参数    | 类型          | 必须/默认值 | 说明     |
| ------- | ------------- | ----------- | -------- |
| `key`   | str           | 必须        | 键名     |
| `value` | str/int/float | 必须        | 数据     |
| `scope` | str           | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.rpush('userQueue', '001', scope='queue')
DFF.CACHE.rpush('userQueue', '002', scope='queue')
# 此时缓存值为：[ '001', '002' ]
```

### DFF.CACHE.lpop(...)

`DFF.CACHE.lpop(...)`方法用于从*左侧*从列表结构中弹出元素，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.lpush('userQueue', '001', scope='queue')
DFF.CACHE.lpush('userQueue', '002', scope='queue')
DFF.CACHE.lpop('userQueue', scope='queue')
# '002'
```

### DFF.CACHE.rpop(...)

`DFF.CACHE.rpop(...)`方法用于从*右侧*从列表结构中弹出元素，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.lpush('userQueue', '001', scope='queue')
DFF.CACHE.lpush('userQueue', '002', scope='queue')
DFF.CACHE.rpop('userQueue', scope='queue')
# '001'
```

### DFF.CACHE.llen(...)

`DFF.CACHE.llen(...)`方法用于获取列表结构元素数量，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明     |
| ------- | ---- | ----------- | -------- |
| `key`   | str  | 必须        | 键名     |
| `scope` | str  | 当前脚本名  | 命名空间 |

示例如下：

```python
DFF.CACHE.lpush('userQueue', '001', scope='queue')
DFF.CACHE.lpush('userQueue', '002', scope='queue')
DFF.CACHE.llen('userQueue', scope='queue')
# 2
```

### DFF.CACHE.lrange(...)

`DFF.CACHE.lrange(...)`方法用于获取列表结构内元素列表（不弹出），参数如下：

| 参数    | 类型 | 必须/默认值 | 说明                               |
| ------- | ---- | ----------- | ---------------------------------- |
| `key`   | str  | 必须        | 键名                               |
| `start` | int  | `0`         | 起始索引（包含）                   |
| `stop`  | int  | `-1`        | 结束索引（包含，`-1`表示最后一个） |
| `scope` | str  | 当前脚本名  | 命名空间                           |

示例如下：

```python
DFF.CACHE.rpush('userQueue', '001', scope='queue')
DFF.CACHE.rpush('userQueue', '002', scope='queue')
DFF.CACHE.rpush('userQueue', '003', scope='queue')
DFF.CACHE.rpush('userQueue', '004', scope='queue')
DFF.CACHE.lrange('userQueue', 0, 1, scope='queue')
# [ '001', '002' ]
DFF.CACHE.lrange('userQueue', 0, -1, scope='queue')
# [ '001', '002', '003', '004' ]
```

### DFF.CACHE.ltrim(...)

`DFF.CACHE.ltrim(...)`方法用于从*左侧*开始，保留列表结构内元素，参数如下：

| 参数    | 类型 | 必须/默认值 | 说明                               |
| ------- | ---- | ----------- | ---------------------------------- |
| `key`   | str  | 必须        | 键名                               |
| `start` | int  | 必须        | 起始索引（包含）                   |
| `stop`  | int  | 必须        | 结束索引（包含，`-1`表示最后一个） |
| `scope` | str  | 当前脚本名  | 命名空间                           |

示例如下：

```python
DFF.CACHE.rpush('userQueue', '001', scope='queue')
DFF.CACHE.rpush('userQueue', '002', scope='queue')
DFF.CACHE.rpush('userQueue', '003', scope='queue')
DFF.CACHE.rpush('userQueue', '004', scope='queue')
DFF.CACHE.ltrim('userQueue', 0, 1, scope='queue')
# 此时缓存值为：[ '001', '002' ]
```

小技巧：限制队列长度（回卷）

```python
limit = 3
for i in range(100):
    DFF.CACHE.lpush('userQueue', i, scope='queue')
    DFF.CACHE.ltrim('userQueue', 0, limit, scope='queue')

# 此时缓存值为：[ '99', '98', '97' ]
```

### DFF.CACHE.rpoplpush(...)

`DFF.CACHE.rpoplpush(...)`方法用于在一个列表结构*右侧*弹出元素，同时向另一个列表结构*左侧*推入元素，同时返回此元素，参数如下：

| 参数         | 类型 | 必须/默认值   | 说明             |
| ------------ | ---- | ------------- | ---------------- |
| `key`        | str  | 必须          | 键名（来源）     |
| `dest_key`   | str  | 与`key`相同   | 键名（目标）     |
| `scope`      | str  | 当前脚本名    | 命名空间（来源） |
| `dest_scope` | str  | 与`scope`相同 | 命名空间（目标） |

示例如下：

```python
DFF.CACHE.lpush('userQueue', '001', scope='queue')
DFF.CACHE.lpush('userQueue', '002', scope='queue')
DFF.CACHE.lpush('userQueue', '003', scope='queue')

DFF.CACHE.rpoplpush('userQueue', 'userQueue2', scope='queue')
# '001'
# 此时 userQueue 缓存值为：[ '003', '002' ]
# 此时 userQueue2 缓存值为：[ '001' ]
```

小技巧：队列滚动

```python
DFF.CACHE.lpush('userQueue', '001', scope='queue')
DFF.CACHE.lpush('userQueue', '002', scope='queue')
DFF.CACHE.lpush('userQueue', '003', scope='queue')
# 此时缓存值为：[ '003', '002', '001' ]

DFF.CACHE.rpoplpush('userQueue', scope='queue')
# '001'
# 此时缓存值为：[ '001', '003', '002' ]

DFF.CACHE.rpoplpush('userQueue', scope='queue')
# '002'
# 此时缓存值为：[ '002', '001', '003' ]
```

## 10. SQL 语句格式化 DFF.SQL(...)

使用`DFF.SQL(...)`可以方便地生成动态 SQL 语句，避免手工拼接 SQL 导致 SQL 注入问题。

| 参数         | 类型 | 必须/默认值 | 说明                                                                                |
| ------------ | ---- | ----------- | ----------------------------------------------------------------------------------- |
| `sql`        | str  | 必须        | SQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params` | list | `None`      | SQL 参数                                                                            |

> 提示：绝大多数通过`DFF.SRC(...)`创建的，支持 SQL 语句的数据源操作对象都已经内置了此功能，可以直接使用

示例如下：

```python
sql = 'SELECT * FROM ?? WHERE id = ?'
sql_params = [ 'users', 'user-001' ]
print(DFF.SQL(sql, sql_params))
# SELECT * FROM users WHERE id = 'user-001'

sql = 'SELECT * FROM ?? WHERE name IN (?)'
sql_params = [ 'class', ['语文', '数学', '英语'] ]
print(DFF.SQL(sql, sql_params))
# SELECT * FROM class WHERE name IN ('语文', '数学', '英语')
```

## 11. 获取资源文件路径 DFF.RSRC(...)

资源文件可以在「管理 - 文件工具」中查看和管理，
当需要在脚本中操作资源文件时，需要使用`DFF.RSRC(...)`获取资源文件的真实路径。

| 参数        | 类型 | 必须/默认值 | 说明             |
| ----------- | ---- | ----------- | ---------------- |
| `file_path` | str  | 必须        | 资源文件相对路径 |

*注意：使用`DFF.RESP_FILE(...)`时，`file_path`参数直接填写资源文件的相对路径即可，无需使用`DFF.RSRC(...)`获取真实路径*

示例如下：

```python
with open(DFF.RSRC('demo/data.txt')) as f:
    # 打开真实路径为 /data/resources/demo/data.txt 的文件
    pass
```

## 12. 内置变量 _DFF_XXX

为了方便脚本在运行时获取相关运行状态的信息，DataFlux Func 在脚本上下文中直接内置了一些可以直接使用的变量。

| 内置变量               | 类型 | 适用范围         | 说明                     | 示例值                      |
| ---------------------- | ---- | ---------------- | ------------------------ | --------------------------- |
| `_DFF_SCRIPT_SET_ID`   | str  | 全部             | 脚本集 ID                | `"demo"`                    |
| `_DFF_SCRIPT_ID`       | str  | 全部             | 脚本 ID                  | `"demo__basic"`             |
| `_DFF_FUNC_ID`         | str  | 全部             | 函数 ID                  | `"demo__basic.hello_world"` |
| `_DFF_FUNC_NAME`       | str  | 全部             | 函数名                   | `"hello_world"`             |
| `_DFF_START_TIME`      | int  | 全部             | 实际启动时间             | `1625651910`                |
| `_DFF_START_TIME_MS`   | int  | 全部             | 实际启动时间（毫秒版本） | `1625651910630`             |
| `_DFF_TRIGGER_TIME`    | int  | 全部             | 计划启动时间             | `1625651909`                |
| `_DFF_TRIGGER_TIME_MS` | int  | 全部             | 计划启动时间（毫秒版本） | `1625651909582`             |
| `_DFF_CRONTAB`         | str  | 自动触发配置     | Crontab 表达式           | `* * * * *`                 |
| `_DFF_HTTP_REQUEST`    | dict | 授权链接、批处理 | 接口调用时请求体         | 见下文                      |

### _DFF_START_TIME 和_DFF_TRIGGER_TIME 区别

`_DFF_START_TIME`指的是函数实际启动的时间，相当于在函数入口处执行的`time.time()`，会因为队列拥堵等因素延后。

而`_DFF_TRIGGER_TIME`指的是函数触发时间，不会因为队列拥堵而改变，可以认为是「计划启动的时间」，取值如下：

| 函数调用方式 | 取值                                |
| ------------ | ----------------------------------- |
| UI 执行函数  | 后端 API 服务接收到 HTTP 请求的时间 |
| 授权链接     | 后端 API 服务接收到 HTTP 请求的时间 |
| 自动触发配置 | Crontab 表达式所对应的整点时间      |
| 批处理       | 后端 API 服务接收到 HTTP 请求的时间 |

> 提示：当使用自动触发配置按照固定时间间隔获取时序数据时，应当以`_DFF_TRIGGER_TIME`和`_DFF_TRIGGER_TIME_MS`为基准，*不要*自行在代码中使用`time.time()`获取当前时间

### _DFF_HTTP_REQUEST 数据结构

`_DFF_HTTP_REQUEST`内容为请求体详情，如：

```json
{
    "method"     : "GET",
    "originalUrl": "/api/v1/al/auln-xxxxx/simplified?arg1=value1&arg2=value2",
    "url"        : "/api/v1/al/auln-xxxxx/simplified",
    "headers": {
        "host"                     : "172.16.35.143:8089",
        "connection"               : "keep-alive",
        "cache-control"            : "max-age=0",
        "dnt"                      : "1",
        "upgrade-insecure-requests": "1",
        "user-agent"               : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36",
        "accept"                   : "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
        "referer"                  : "http://172.16.35.143:8080/",
        "accept-encoding"          : "gzip, deflate",
        "accept-language"          : "zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7"
    },
    "hostname": "172.16.35.143",
    "ip"      : "172.16.35.1",
    "ips"     : [],
    "protocol": "http",
    "xhr"     : false
}
```

> 提示：`headers`字段类型是`IgnoreCaseDict`类型数据。`IgnoreCaseDict`继承`dict`，用法基本相同但不区分键名的大小写，如以下几行代码都能获得相同的值：

```python
_DFF_HTTP_REQUEST['headers']['user-agent']
_DFF_HTTP_REQUEST['headers']['User-Agent']
_DFF_HTTP_REQUEST['headers']['USER-AGENT']
```
