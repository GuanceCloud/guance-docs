
# Windows 事件
---

- DataKit 版本：1.4.9
- 操作系统支持：windows

Windows 事件日志采集是采集应用程序、安全、系统等 Windows 事件日志

## 前置条件

- Windows 版本 >= Windows 10

## 配置

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
  [inputs.windows_event.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ... 
```

配置好后，重启 DataKit 即可。

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.windows_event.tags]` 指定其它标签：

``` toml
 [inputs.windows_event.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `windows_event`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`channel`|Channel|
|`computer`|计算机|
|`event_id`|事件 ID|
|`event_record_id`|事件记录 ID|
|`event_source`|Windows 事件来源|
|`keyword`|关键字|
|`level`|级别|
|`message`|事件内容|
|`process_id`|进程 ID|
|`source`|日志来源|
|`status`|日志等级|
|`task`|任务类别|
|`total_message`|事件全文|
|`version`|版本|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |

 


