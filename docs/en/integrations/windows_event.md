---
title     : 'Windows Events'
summary   : 'Collecting event logs from Windows'
tags:
  - 'WINDOWS'
__int_icon      : 'icon/winevent'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-windows:

---

The collection of Windows Event Logs involves gathering application, security, system, and other types of Windows event logs.

## Configuration {#config}

### Prerequisites {#requirements}

- Windows version >= Windows Server 2008 R2

### Collector Configuration {#input-config}

Navigate to the `conf.d/windows` directory under the DataKit installation directory, copy `windows_event.conf.sample`, and rename it to `windows_event.conf`. An example is shown below:

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

After configuring, restart DataKit to apply changes.

## Logging {#logging}

By default, all data collected will append a global tag named `host` (the tag value is the hostname where DataKit resides). You can also specify additional tags in the configuration using `[inputs.windows_event.tags]`:

``` toml
 [inputs.windows_event.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `windows_event`

- Tags


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

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |

Please note that the metrics list currently does not contain any specific entries.
