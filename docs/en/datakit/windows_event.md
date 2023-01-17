
# Windows Events
---

:fontawesome-brands-windows:

---

Windows Event Log Collection is used to collect applications, security, systems and so on.

## Preconditions {#requrements}

- Windows version >= Windows Server 2008 R2

## Configuration {#config}

Go to the `conf.d/windows` directory under the DataKit installation directory, copy `windows_event.conf.sample` and name it `windows_event.conf`. Examples are as follows:

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

After configuration, restart DataKit.

## Measurement {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration through `[inputs.windows_event.tags]`:

``` toml
 [inputs.windows_event.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```




### `windows_event`

-  tag


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
|`status`|日志等级|
|`task`|任务类别|
|`total_message`|事件全文|
|`version`|版本|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |

 

 

