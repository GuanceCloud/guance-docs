
# Solr
---


## 版本支持

操作系统支持：Windows/AMD 64, Windows/386, Linux/ARM, Linux/ARM 64, Linux/386, Linux/AMD 64, Darwin/AMD 64


## 安装部署

Solr 采集器，用于采集 solr cache 和 request times 等的统计信息。

说明：示例 Solr 版本为：Solr 7.1 (CentOS)，各个不同版本指标可能存在差异。

### 前置条件

DataKit 使用 Solr Metrics API 采集指标数据，支持 Solr 7.0 及以上版本。可用于 Solr 6.6，但指标数据不完整。

### 配置实施

#### 指标采集 (必选)

1、 开启 DataKit Solr 插件，复制 sample 文件

```bash
/usr/local/datakit/conf.d/db
cp solr.conf.sample solr.conf
```

2、 修改 `solr.conf` 配置文件

```bash
vi solr.conf
```
参数说明

- interval：采集指标频率
- servers：solr server地址
- username：用户名
- password：密码

```yaml
[[inputs.solr]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

  ## specify a list of one or more Solr servers
  servers = ["http://localhost:8983"]

  ## Optional HTTP Basic Auth Credentials
  # username = "username"
  # password = "pa$$word"

```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

4、 指标预览

![image](../imgs/input-solr-2.png)

#### 日志采集 (非必选)

1、 修改 `solr.conf` 配置文件

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- pipeline：日志切割文件(内置)，实际文件路径 `/usr/local/datakit/pipeline/solr.p`
- 相关文档 <[ 文本数据处理（Pipeline）](../../datakit/pipeline.md)>

```
[inputs.solr.log]
		# 填入绝对路径
    files = []
    ## grok pipeline script path
    pipeline = "solr.p"
```

3、 重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

4、 日志预览

![image](../imgs/input-solr-4.png)

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Solr 指标都会带有 `service = "solr"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>
```
# 示例
[inputs.solr.tags]
		service = "solr"
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

重启 Datakit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Solr 监控视图>


## [指标详解](../../../datakit/solr#measurements)

## 最佳实践

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>

