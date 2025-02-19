# 事件数据分流实践：基于 Dataway Sink 的实现方案
---

本文档介绍如何通过 DataFlux Func 和 Dataway Sinker 实现数据的智能分流。通过配置，您可以将不同类型的数据（如 `keyevent`、`logging` 等）按照自定义规则路由到不同的目标空间。

## 前提要求

1. 已部署 Dataway 并启用 Sinker 分流功能；
2. 上报数据的 Header 里面存在相关的 `key` 与 `value` 属性。

> 如需配置 Sinker，可参考：[Dataway Sinker 配置指南](../deployment/dataway-sink.md)；对于部署版，Func 平台使用的 Dataway 位于 `utils` 命名空间下的 `internal-dataway`。

## 开始配置

### :material-numeric-1-circle: 配置 DataFlux Func

通过 Dataway Sinker 实现分流，需保证 Func 平台中上报数据的 Header 内必须包含相关的 `key` 和 `value` 属性，从而才能实现适配。

> 点击查看[写法示例](#example)。

- 对接参数：

| 字段名 | 类型 | 默认值 | 说明 |
| --- | --- |--- | --- |
| `CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS` | list / string | `null` | 上报数据至 InternalDataway 的 Global Custom Keys 配置 |


1. 访问 Launcher 控制台；
2. 进入右上角 > 修改应用配置；
3. 找到 `func2` 命名空间下的 `func2Config` 配置项；
4. 添加数据分流配置。


```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - category: keyevent     # 数据类别
    fields:               # 用于分流的字段
      - host
      - name
      - DF_WORKSPACE_UUID
```

### :material-numeric-2-circle: 配置 Dataway Sinker

需写入 Sinker 规则。修改 sinker.json 配置文件，设置数据路由规则：

```json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ host = 'web-001' }"
            ],
            "url": "https://kodo.guance.com?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        }
    ]
}
```

**注意**：修改配置后需要重启 Dataway 服务使配置生效。


## 在 Header 中添加 `key:value` 的方式示例 {#example}

### 将事件数据写入同一工作空间

#### 1. 对事件提取字段

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



#### 2. 对事件提取单个字段

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

### 将所有数据写入同一工作空间

#### 不写 category 表示对所有数据处理

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

### 其他情况

#### 1. 提取字段时改变字段名

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



#### 2. 提取字段时映射字段值

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



#### 3. 提取字段时使用默认值

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



#### 4. 写入固定值

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



#### 5. 使用 Tag 方式匹配数据

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



#### 6. 使用 filterString 方式匹配数据

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



#### 7. 自定义函数方式截取事件字段前缀、后缀

**示例配置**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS: my_script_set__my_script.make_global_tags
```

**示例函数：位于脚本集 my_script_set，脚本 my_script 下** 

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

<!--
## Func 侧对接参数

| 字段名 | 类型 | 默认值 | 说明 |
| --- | --- |--- | --- |
| `CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS` | list / string | `null` | 上报数据至 InternalDataway 的 Global Custom Keys 配置 |


### 配置细节

该参数支持填写：

1. JSON 格式的 [Global Tags 生成规则](#rule)
2. [自定义 Global Tags 生成函数 ID](#id)

#### Global Tags 生成规则 {#rule}

| 字段名 | 类型 | 默认值 | 说明 |
| --- | --- |--- | --- |
| `[#].category` | string/[string] | `"*"` | 匹配数据的 Category |
| `[#].fields` | 	string/dict [string]/[dict] | - | 提取数据字段（包括 Tags 和 Fields）；支持直接提取和规则提取 |
| `[#].fields[#]`  | string | - | 提取字段名，且支持额外的提取字段（见下表） |
| `[#].fields[#]`  | dict | - | 提取字段规则 |
| `[#].fields[#].src`  | string | - | 提取字段名，且支持额外的提取字段（见下表） |
| `[#].fields[#].dest` | string | 与 `src` 相同 | 提取后写入 Header 的字段名 |
| `[#].fields[#].default`  | string | - | 当不存在指定字段时，写入 Header 的默认值 |
| `[#].fields[#].fixed`  | string | - | 向 Header 写入的固定值 |
| `[#].fields[#].remap`  | dict | `null` | 对提取字段值进行映射转换 |
| `[#].fields[#].remap_default`  | string | - | 对提取字段值进行映射转换时，没有对应映射值时的默认值<br />不指定时，沿用原始值<br />指定为 `null` 时，忽略此字段 |
| `[#].filter`  | dict/string | `null` | 匹配数据的过滤器<br />支持 Tag 过滤和 filterString 过滤 |

额外的提取字段：

| 额外的提取字段	 | 说明 |
| --- | --- |
| `DF_WORKSPACE_UUID`	 | 工作空间 ID |
| `DF_WORKSPACE_NAME`	 | 工作空间名称 |
| `DF_MONITOR_CHECKER_ID`	 | 监控器 ID |
| `DF_MONITOR_CHECKER_NAME`	 | 监控器名称 |


#### 自定义 Global Tags 生成函数 ID {#id}


函数 ID 格式为 `{脚本集 ID}__{脚本 ID}.{函数名}`

函数定义如下：

| 参数	 | 类型 |说明 |
| --- | --- | --- |
| `category`	 | string | 类别，如 `"keyevent"` |
| `point`	 | dict | 待处理的单条数据 |
| `point.measurement`	 | string |数据 `measurement` |
| `point.tags`	 | dict | 数据 `tags` 内容 |
| `point.fields`	 | dict | 数据 `fields` 内容 |
| `extra_fields`	 | dict | 额外提取字段（见下表） |

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

额外的提取字段：

| 额外的提取字段	 | 说明 |
| --- | --- |
| `DF_WORKSPACE_UUID`	 | 工作空间 ID |
| `DF_WORKSPACE_NAME`	 | 工作空间名称 |
| `DF_MONITOR_CHECKER_ID`	 | 监控器 ID |
| `DF_MONITOR_CHECKER_NAME`	 | 监控器名称 |

### 示例


-->
