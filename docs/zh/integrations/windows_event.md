---
title     : 'Windows 事件'
summary   : '采集 Windows 中的事件日志'
tags:
  - 'WINDOWS'
__int_icon      : 'icon/winevent'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-windows:

---

Windows 事件日志采集是采集应用程序、安全、系统等 Windows 事件日志

## 配置 {#config}

### 前置条件 {#requrements}

- Windows 版本 >= Windows Server 2008 R2

### 采集器配置 {#input-config}

进入 DataKit 安装目录下的 `conf.d/windows` 目录，复制 `windows_event.conf.sample` 并命名为 `windows_event.conf`。示例如下：

```toml

[[inputs.windows_event]]
  xpath_query = '''
  <QueryList>
    <Query Id="0" Path="Security">
      <Select Path="Security">*</Select>
      <Suppress Path="Security">*[System[( (EventID &gt;= 5152 and EventID &lt;= 5158) or EventID=5379 or EventID=4672)]]</Suppress>
    </Query>
    <Query Id="1" Path="Application">
      <Select Path="Application">*[System[(Level &lt; 4)]]</Select>
    </Query>
    <Query Id="2" Path="Windows PowerShell">
      <Select Path="Windows PowerShell">*[System[(Level &lt; 4)]]</Select>
    </Query>
    <Query Id="3" Path="System">
      <Select Path="System">*</Select>
    </Query>
    <Query Id="4" Path="Setup">
      <Select Path="Setup">*</Select>
    </Query>
  </QueryList>
  '''

  # event_fetch_size is the number of events to fetch per query.
  event_fetch_size = 5

  [inputs.windows_event.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

配置好后，重启 DataKit 即可。

## 日志 {#logging}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.windows_event.tags]` 指定其它标签：

``` toml
 [inputs.windows_event.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `windows_event`

- 标签


| Tag | Description |
|  ----  | --------|
|`channel`|Channel|
|`computer`|Computer|
|`event_id`|Event ID|
|`event_record_id`|Event record ID|
|`event_source`|Windows event source|
|`keyword`|Keyword|
|`level`|Level|
|`message`|Event content|
|`process_id`|Process ID|
|`status`|Log level|
|`task`|Task category|
|`total_message`|Full text of the event|
|`version`|Version|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |


