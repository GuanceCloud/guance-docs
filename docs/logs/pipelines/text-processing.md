# 文本处理（Pipeline）
---

## 简介

在 观测云的日志管理中，可以通过 pipeline 的方式对日志的文本内容进行切割，从而提取出特定的字段作为标签或者日志的时间戳。目前 “观测云” 支持 2 种日志提取方式：通过 pipeline 的方式提取和通过 Grok 辅助 pipeline 进行提取。 

## 基本规则：

- 函数名大小写不敏感
- 以 `#` 为行注释字符。不支持行内注释
- 标识符：只能出现 `[_a-zA-Z0-9]` 这些字符，且首字符不能是数字。如 `_abc, _abc123, _123ab`
- 字符串值可用双引号和单引号： `"this is a string"` 和 `'this is a string'` 是等价的
- 数据类型：支持浮点（`123.4`, `5.67E3`）、整形（`123`, `-1`）、字符串（`'张三'`, `"hello world"`）、Boolean（`true`, `false`）四种类型
- 多个函数之间，可以用空白字符（空格、换行、Tab 等）分割

## 快速开始

### 如何在 DataKit 中配置 pipeline：

- 第一步：编写如下 pipeline 文件，假定名为 `nginx.p`。将其存放在 `<datakit安装目录>/pipeline` 目录下。

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

- 第二步：配置对应的采集器来使用上面的 pipeline

以 tailf 采集器为例，配置字段 `pipeline_path` 即可，注意，这里配置的是 pipeline 的脚本名称，而不是路径。所有这里引用的 pipeline 脚本，必须存放在 `<DataKit 安装目录/pipeline>` 目录下：

```python
[[inputs.tailf]]
	logfiles = ["/path/to/nginx/log"]

	# required
	source = "nginx"
	from_beginning = false

	# 此处配置成 datakit 安装目录的相对路径，故所有脚本必须放在 /path/to/datakit/pipeline 目录下
	# 如果 pipeline 未配置，则在 pipeline 目录下寻找跟 source 同名的脚本（如 nginx -> nginx.p），
	# 作为其默认 pipeline 配置
	pipeline_ = "nginx.p"

	... # 其它配置
```

重启采集器，即可切割对应的日志。[了解更多文本数据处理](../../datakit/pipeline.md)。

