# 事件数据分流实践：基于 Dataway Sink 的实现方案
---

本文档详细介绍如何通过 **DataFlux Func 注入 HTTP Header** 和 **Dataway Sinker 规则配置**，实现事件数据（`keyevent`）的智能分流。通过本方案，您可以将不同业务属性、环境特征的事件数据路由到指定的工作空间。



## 方案原理


### 数据分流流程

![](img/event_data_sharding.png)


### 核心机制说明

1. **DataFlux Func 侧注入标识**：在事件数据上报时，通过 Func 配置动态生成 `X-Global-Tags` Header，包含分流所需的键值对（如 `env=prod`）。

2. **Dataway 路由匹配**：Dataway 根据 `sinker.json` 中定义的规则，将携带特定标识的事件转发到对应工作空间。



## :material-numeric-1-circle: Dataway 配置

在使用此功能前，请确保已部署 Dataway 并启用 Sinker 分流功能。

> 如需配置 Sinker，可参考：[Dataway Sinker 配置指南](../deployment/dataway-sink.md)；


**注意**：部署版本中内置 DataFlux Func 使用的 Dataway 位于 `utils` 命名空间下的 `internal-dataway`。



## :material-numeric-2-circle: DataFlux Func 配置


### Header 注入 X-Global-Tags


#### 核心参数说明


| 参数名 | 类型 | 说明 |
| --- | --- | --- |
| `CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS` | list/string | 定义事件数据的分流标识生成规则 |


#### 简单示例


将所有工作空间的事件统一写入到 "事件集中管理" 工作空间：


1. 访问 Launcher 控制台；

2. 进入右上角 > 修改应用配置；

3. 找到 `func2` 命名空间下的 `func2Config` 配置项；

4. 添加配置：

    ```yaml
    CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
      - category: keyevent     # 数据类别
        fields: df_source      # 用于分流的字段，此处填写事件的固定标识字段
    ```


5. 配置 Dataway Sinker 规则：修改 sinker.json 配置文件，设置数据路由规则：

```json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ df_source = 'monitor' }"
            ],
            "url": "工作空间数据上报地址"
        }
    ]
}
```



#### 特殊字段说明


| 字段名 | 说明 |
| --- | --- |
| `DF_WORKSPACE_UUID` | 工作空间 ID |
| `DF_WORKSPACE_NAME` | 工作空间名称 |
| `DF_MONITOR_CHECKER_ID` | 监控器 ID |
| `DF_MONITOR_CHECKER_NAME` | 监控器名称 |



#### 更多高级配置


| 配置方式 | 示例 | 说明 |
| --- | --- | --- |
| 直接提取 | `-host` | 从事件数据的 `tags` 或 `fields` 提取 `host` 字段 |
| 重命名字段 | `-src:service; dest:business_type` | 将 `service` 字段重命名为 `business_type` |
| 值映射 | `remap:{order:电商业务}` | 将原始值 `order` 映射为 `电商业务` |
| 默认值 | `default:unknown` | 字段不存在时使用默认值 |
| 固定值 | `- dest:env; fixed:prod` | 直接注入固定值 `env=prod` |

##### Global Tags 生成规则 {#rule}

| 字段名     | 类型            | 默认值        | 说明                    |
| ----------------- | ---------------- | ------------- | --------------- |
| `[#].category`                | string/[string]             | `"*"`         | 匹配数据的 Category                                          |
| `[#].fields`                  | string/dict [string]/[dict] | -             | 提取数据字段（包括 Tags 和 Fields）；支持直接提取和规则提取  |
| `[#].fields[#]`               | string                      | -             | 提取字段名，且支持额外的提取字段（见下表）                   |
| `[#].fields[#]`               | dict                        | -             | 提取字段规则                                                 |
| `[#].fields[#].src`           | string                      | -             | 提取字段名，且支持额外的提取字段（见下表）                   |
| `[#].fields[#].dest`          | string                      | 与 `src` 相同 | 提取后写入 Header 的字段名                                   |
| `[#].fields[#].default`       | string                      | -             | 当不存在指定字段时，写入 Header 的默认值                     |
| `[#].fields[#].fixed`         | string                      | -             | 向 Header 写入的固定值                                       |
| `[#].fields[#].remap`         | dict                        | `null`        | 对提取字段值进行映射转换                                     |
| `[#].fields[#].remap_default` | string                      | -             | 对提取字段值进行映射转换时，没有对应映射值时的默认值<br />不指定时，沿用原始值<br />指定为 `null` 时，忽略此字段 |
| `[#].filter`                  | dict/string                 | `null`        | 匹配数据的过滤器<br />支持 Tag 过滤和 filterString 过滤      |

##### 自定义 Global Tags 生成函数 ID {#id}


函数 ID 格式为 `{脚本集 ID}__{脚本 ID}.{函数名}`

函数定义如下：

| 参数                | 类型   | 说明                   |
| ------------------- | ------ | ---------------------- |
| `category`          | string | 类别，如 `"keyevent"`  |
| `point`             | dict   | 待处理的单条数据       |
| `point.measurement` | string | 数据 `measurement`     |
| `point.tags`        | dict   | 数据 `tags` 内容       |
| `point.fields`      | dict   | 数据 `fields` 内容     |
| `extra_fields`      | dict   | 额外提取字段（见下表） |

示例：

- point 参数值

```
{
  "measurement": "keyevent",
  "tags": {
    "host": "web-001",
    "ip"  : "1.2.3.4"
  },
  "fields": {
    "name": "Tom"
  }
}
```

- extra_fields 参数值

```
{
  "DF_WORKSPACE_UUID"      : "wksp_xxxxx",
  "DF_MONITOR_CHECKER_ID"  : "rul_xxxxx",
  "DF_MONITOR_CHECKER_NAME": "监控器 XXXXX",
  "DF_WORKSPACE_NAME"      : "工作空间 XXXXX"
}
```





#### 生成效果验证

在 Header 中添加 `key:value` 的方式示例 {#example}


##### 将事件数据写入同一工作空间


:material-numeric-1-circle-outline: 对事件提取字段


**示例配置**


```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - category: keyevent
    fields:
      - host
      - name
      - DF_WORKSPACE_UUID
```



**示例数据**


```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host": "web-001",
    "ip"  : "1.2.3.4"
  },
  "fields": {
    "name": "Tom"
  }
}
```


**示例写入的 Header**


```yaml
X-Global-Tags: host=web-001,name=Tom,DF_WORKSPACE_UUID=wksp_xxxxx
```




:material-numeric-2-circle-outline: 对事件提取单个字段


**示例配置**


```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - category: keyevent
    # 只有 1 个字段可以简写
    fields: host
```


**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host": "web-001"
  },
  "fields": {
    "name": "Tom"
  }
}
```


**示例写入的 Header**


```yaml
X-Global-Tags: host=web-001
```



##### 将所有数据写入同一工作空间


:material-numeric-1-circle-outline: 不写 `category` 表示对所有数据处理

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields: DF_WORKSPACE_UUID
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host": "web-001"
  },
  "fields": {
    "name": "Tom"
  }
}
```

**示例写入的 Header**

```yaml
X-Global-Tags: DF_WORKSPACE_UUID=wksp_xxxxx
```

##### 其他情况

:material-numeric-1-circle-outline: 提取字段时改变字段名


**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields:
    - src : host
      dest: HOST
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host": "web-001"
  },
  "fields": {
    "name": "Tom"
  }
}
```

**示例写入的 Header**

```yaml
X-Global-Tags: HOST=web-001
```



:material-numeric-2-circle-outline: 提取字段时映射字段值

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields:
    - src : result
      remap:
        OK     : ok
        success: ok
        failed : error
        failure: error
        timeout: error
      remap_default: unknown
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "result": "success"
  },
  "fields": {
    "name": "Tom"
  }
}
```

**示例写入的 Header**

```yaml
X-Global-Tags: result=ok
```


:material-numeric-3-circle-outline: 提取字段时使用默认值

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields:
    - src    : result
      default: unknown
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host": "web-001"
  },
  "fields": {
    "name": "Tom"
  }
}
```

**示例写入的 Header**

```yaml
X-Global-Tags: result=unknown
```


:material-numeric-4-circle-outline: 写入固定值

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields:
    - dist : app
      fixed: guance
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host": "web-001"
  },
  "fields": {
    "name": "Tom"
  }
}
```

**示例写入的 Header**

```yaml
X-Global-Tags: app=guance
```


:material-numeric-5-circle-outline: 使用 Tag 方式匹配数据

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields: host
    filter:
      service: app-*
  - fields: client_ip
    filter:
      service: web-*
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host"     : "app-001",
    "client_ip": "1.2.3.4",
    "service"  : "app-user"
  },
  "fields": {
    "name": "Tom"
  }
}

```

**示例写入的 Header**

```yaml
X-Global-Tags: host=app-001
```


:material-numeric-6-circle-outline: 使用 filterString 方式匹配数据

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields: host
    filter: 'service:app-*'
  - fields: client_ip
    filter: 'service:web-*'
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "host"     : "app-001",
    "client_ip": "1.2.3.4",
    "service"  : "app-user"
  },
  "fields": {
    "name": "Tom"
  }
}
```

**示例写入的 Header**

```yaml
X-Global-Tags: host=app-001
```

:material-numeric-7-circle-outline: 自定义函数方式截取事件字段前缀、后缀

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS: my_script_set__my_script.make_global_tags
```

**示例函数 位于脚本集 my_script_set，脚本 my_script 下** 

```yaml
def make_global_tags(category, point, extra_fields):
    # 只处理事件类型数据
    if category != 'keyevent':
        return

    global_tags_list = {}

    # 从数据的 fields 或 tags 中获取 name, region 字段
    name   = point['fields'].get('name')   or point['tags'].get('name')
    region = point['fields'].get('region') or point['tags'].get('region')

    # 获取 name 前缀
    if name:
        prefix = str(name).split('-')[0]
        global_tags_list['name_prefix'] = prefix

    # 获取 region 后缀
    if region:
        suffix = str(region).split('-').pop()
        global_tags_list['region_suffix'] = suffix

    # 返回
    return global_tags_list
```

**示例数据**

```yaml
{
  "measurement": "keyevent",
  "tags": {
    "region"   : "cn-shanghai",
    "service"  : "app-user"
  },
  "fields": {
    "name": "Tom-Jerry"
  }
}
```

**示例写入的 Header**

```yaml
X-Global-Tags: name_prefix=Tom,region_suffix=shanghai
```



**上报事件示例**：

```json
{
  "measurement": "keyevent",
  "tags": { "host": "web-01", "service": "order" },
  "fields": { "message": "用户下单异常" }
}
```


**生成的 HTTP Header**：

```http
X-Global-Tags: host=web-01,business_type=电商业务,DF_WORKSPACE_UUID=wksp_123
```


## :material-numeric-3-circle: Dataway Sinker 规则配置


### 规则文件示例 (`sinker.json`)

```json
{
  "strict": false,
  "rules": [
    {
      "rules": ["{ business_type = '电商业务' }"],  // 匹配电商业务事件
      "url": "https://kodo.<<< custom_key.brand_main_domain >>>?token=tkn_电商空间令牌"
    },
    {
      "rules": ["{ DF_WORKSPACE_UUID = 'wksp_123' }"],  // 匹配指定工作空间
      "url": "https://backup.<<< custom_key.brand_main_domain >>>?token=tkn_备份空间令牌"
    },
    {
      "rules": ["*"],  // 默认规则（必须存在）
      "url": "https://default.<<< custom_key.brand_main_domain >>>?token=tkn_默认空间令牌"
    }
  ]
}
```


### 规则语法说明

| 运算符 | 示例 | 说明 |
| --- | --- | --- |
| `=` | `{ env = 'prod' }` | 精确匹配 |
| `!=` | `{ env != 'test' }` | 不等于 |
| `in` | `{ region in ['cn-east','cn-north'] }` | 多值匹配 |
| `match` | `{ host match 'web-*' }` | 通配符匹配 |



## :material-numeric-4-circle: Datakit 端配置说明


### 基础配置

```bash
# /usr/local/datakit/conf.d/datakit.conf
[dataway]
  # 开启 Sinker 功能
  enable_sinker = true
  # 定义分流依据字段（最多 3 个）
  global_customer_keys = ["host", "env"]
```



### 注意事项

- **字段类型限制**：仅支持字符串类型字段（所有 Tag 值均为字符串）

- **二进制数据支持**：支持 Session Replay、Profiling 等二进制数据分流

- **性能影响**：每增加一个分流字段，内存占用增加约 5%


## :material-numeric-5-circle: 全局 Tag 的影响


### 1. 全局 Tag 示例

```bash
# datakit.conf
[election.tags]
    cluster = "cluster-A"  # 全局选举 Tag
[global_tags]
    region = "cn-east"     # 全局主机 Tag
```



### 2. 分流标识合并逻辑

假设事件数据包含以下 Tag：

```json
{
  "tags": { "cluster": "cluster-B", "app": "payment" }
}
```



**最终分流标识**：

```http
X-Global-Tags: cluster=cluster-B,region=cn-east
```



## 扩展说明：其他数据类型分流


### 1. 自定义分流规则

对于非事件数据（如 `logging`、`metric`），通过指定 `category` 实现分流：


```yaml
# Func 配置示例：处理 logging 数据
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - category: logging
    fields:
      - src: log_level
        remap:
          error: 关键错误
          warn: 一般警告
      - service
```


### 2. 通用原则

- **隔离配置**：不同数据类别（`keyevent`/`logging`/`metric`）使用独立的配置块

- **字段精简**：单个数据类别的分流标识不超过 3 个

- **避免冲突**：不同类别的分流字段建议采用不同命名


## 故障排查



### 常见问题

| 现象 | 排查步骤 |
| --- | --- |
| **分流未生效** | 1. 检查 Dataway 日志 `grep 'sinker reload'`<br>2. 使用 `curl -v` 验证 Header<br>3. 检查 Sinker 规则优先级 |
| **部分数据丢失** | 1. 确认 `strict` 模式状态<br>2. 检查默认规则是否存在 |
| **标识未注入** | 1. 验证 Func 配置语法<br>2. 检查字段是否为字符串类型 |



### 诊断命令

```bash
# 查看 Dataway 分流统计
curl http://localhost:9528/metrics | grep sinker_requests_total
# 手动测试分流规则
curl -X POST -H "X-Global-Tags: business_type=电商业务" http://dataway/v1/write/keyevent
```
