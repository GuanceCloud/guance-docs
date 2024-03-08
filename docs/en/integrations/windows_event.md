---
title     : 'Windows Event'
summary   : 'Collect event logs in Windows'
__int_icon      : 'icon/winevent'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Windows Event
<!-- markdownlint-enable -->

---

:fontawesome-brands-windows:

---

Windows Event Log Collection is used to collect applications, security, systems and so on.

## Configuration {#config}

### Preconditions {#requrements}

- Windows version >= Windows Server 2008 R2

### Collector Configuration {#input-config}

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

## Logging {#logging}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration through `[inputs.windows_event.tags]`:

``` toml
 [inputs.windows_event.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `windows_event`

- tag


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

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |


