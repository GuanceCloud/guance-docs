# Event Data Sharding Practice: Implementation Based on Dataway Sink
---

This document provides a detailed explanation of how to achieve intelligent event data (`keyevent`) sharding through **injecting HTTP Headers using DataFlux Func** and **Dataway Sinker rule configuration**. With this solution, you can route event data with different business attributes and environmental characteristics to designated workspaces.



## Solution Principle


### Data Sharding Process

![](img/event_data_sharding.png)


### Core Mechanism Explanation

1. **Injection of Identifiers by DataFlux Func**: During the reporting of event data, dynamically generate the `X-Global-Tags` Header via Func configuration, which includes key-value pairs required for sharding (e.g., `env=prod`).

2. **Dataway Routing Match**: Dataway forwards events carrying specific identifiers to corresponding workspaces based on rules defined in `sinker.json`.



## :material-numeric-1-circle: Dataway Configuration

Before using this feature, ensure that Dataway is deployed and the Sinker sharding function is enabled.

> For configuring Sinker, refer to: [Dataway Sinker Configuration Guide](../deployment/dataway-sink.md);

**Note**: The Dataway used in the deployment version with built-in DataFlux Func is located under the `utils` namespace as `internal-dataway`.



## :material-numeric-2-circle: DataFlux Func Configuration


### Inject X-Global-Tags into Header


#### Core Parameter Description


| Parameter Name | Type | Description |
| --- | --- | --- |
| `CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS` | list/string | Defines the generation rules for event data sharding tags |


#### Simple Example


Route all workspace events to the "Event Central Management" workspace:

1. Access the Launcher console;

2. Go to the top-right corner > Modify Application Configuration;

3. Find the `func2Config` configuration item under the `func2` namespace;

4. Add configuration:

    ```yaml
    CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
      - category: keyevent     # Data category
        fields: df_source      # Field used for sharding, enter the fixed identifier field of the event here
    ```

5. Configure Dataway Sinker rules: modify the `sinker.json` configuration file to set data routing rules:

```json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ df_source = 'monitor' }"
            ],
            "url": "workspace data reporting address"
        }
    ]
}
```



#### Special Fields Description


| Field Name | Description |
| --- | --- |
| `DF_WORKSPACE_UUID` | Workspace ID |
| `DF_WORKSPACE_NAME` | Workspace name |
| `DF_MONITOR_CHECKER_ID` | Monitor checker ID |
| `DF_MONITOR_CHECKER_NAME` | Monitor checker name |



#### More Advanced Configurations


| Configuration Method | Example | Description |
| --- | --- | --- |
| Direct Extraction | `-host` | Extract the `host` field from the event data's `tags` or `fields` |
| Rename Fields | `-src:service; dest:business_type` | Rename the `service` field to `business_type` |
| Value Mapping | `remap:{order:ecommerce}` | Map the original value `order` to `ecommerce` |
| Default Value | `default:unknown` | Use a default value if the specified field does not exist |
| Fixed Value | `- dest:env; fixed:prod` | Directly inject the fixed value `env=prod` |

##### Global Tags Generation Rules {#rule}

| Field Name | Type | Default Value | Description |
| --- | --- | --- | --- |
| `[#].category` | string/[string] | `"*"` | Matches the Category of the data |
| `[#].fields` | string/dict [string]/[dict] | - | Extract data fields (including Tags and Fields); supports direct extraction and rule-based extraction |
| `[#].fields[#]` | string | - | Extracted field name, supporting additional extraction fields (see table below) |
| `[#].fields[#]` | dict | - | Extraction field rules |
| `[#].fields[#].src` | string | - | Extracted field name, supporting additional extraction fields (see table below) |
| `[#].fields[#].dest` | string | Same as `src` | Field name written to the Header after extraction |
| `[#].fields[#].default` | string | - | Default value written to the Header when the specified field does not exist |
| `[#].fields[#].fixed` | string | - | Fixed value written to the Header |
| `[#].fields[#].remap` | dict | `null` | Maps extracted field values |
| `[#].fields[#].remap_default` | string | - | Default value when no mapping value exists during remapping<br>If not specified, the original value is used<br>If specified as `null`, the field is ignored |
| `[#].filter` | dict/string | `null` | Filter for matching data<br>Supports Tag filtering and filterString filtering |

##### Custom Global Tags Generation Function ID {#id}


Function ID format is `{script set ID}__{script ID}.{function name}`

Function definition as follows:

| Parameter | Type | Description |
| --- | --- | --- |
| `category` | string | Category, e.g., `"keyevent"` |
| `point` | dict | Single data point to be processed |
| `point.measurement` | string | Data `measurement` |
| `point.tags` | dict | Content of data `tags` |
| `point.fields` | dict | Content of data `fields` |
| `extra_fields` | dict | Additional extracted fields (see table below) |

Example:

- Value of `point` parameter

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

- Value of `extra_fields` parameter

```
{
  "DF_WORKSPACE_UUID"      : "wksp_xxxxx",
  "DF_MONITOR_CHECKER_ID"  : "rul_xxxxx",
  "DF_MONITOR_CHECKER_NAME": "Monitor Checker XXXXX",
  "DF_WORKSPACE_NAME"      : "Workspace XXXXX"
}
```



#### Verification of Generated Effects

Adding `key:value` to the Header example {#example}


##### Writing Event Data to the Same Workspace


:material-numeric-1-circle-outline: Extracting fields from events


**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - category: keyevent
    fields:
      - host
      - name
      - DF_WORKSPACE_UUID
```



**Example Data**

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


**Example Header Written**

```yaml
X-Global-Tags: host=web-001,name=Tom,DF_WORKSPACE_UUID=wksp_xxxxx
```




:material-numeric-2-circle-outline: Extracting a Single Field from Events


**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - category: keyevent
    # Only one field can be simplified
    fields: host
```


**Example Data**

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


**Example Header Written**

```yaml
X-Global-Tags: host=web-001
```



##### Writing All Data to the Same Workspace


:material-numeric-1-circle-outline: Not specifying `category` indicates processing all data

**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields: DF_WORKSPACE_UUID
```

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: DF_WORKSPACE_UUID=wksp_xxxxx
```

##### Other Scenarios

:material-numeric-1-circle-outline: Changing Field Names When Extracting Fields


**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields:
    - src : host
      dest: HOST
```

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: HOST=web-001
```



:material-numeric-2-circle-outline: Mapping Field Values When Extracting Fields

**Example Configuration**

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

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: result=ok
```


:material-numeric-3-circle-outline: Using Default Values When Extracting Fields

**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields:
    - src    : result
      default: unknown
```

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: result=unknown
```


:material-numeric-4-circle-outline: Writing Fixed Values

**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields:
    - dist : app
      fixed: guance
```

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: app=guance
```


:material-numeric-5-circle-outline: Matching Data Using Tags

**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields: host
    filter:
      service: app-*
  - fields: client_ip
    filter:
      service: web-*
```

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: host=app-001
```


:material-numeric-6-circle-outline: Matching Data Using filterString

**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - fields: host
    filter: 'service:app-*'
  - fields: client_ip
    filter: 'service:web-*'
```

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: host=app-001
```

:material-numeric-7-circle-outline: Custom Function Method to Extract Prefixes/Suffixes of Event Fields

**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS: my_script_set__my_script.make_global_tags
```

**Example Function Located in Script Set `my_script_set`, Script `my_script`**

```yaml
def make_global_tags(category, point, extra_fields):
    # Only process event type data
    if category != 'keyevent':
        return

    global_tags_list = {}

    # Get name and region fields from data's fields or tags
    name   = point['fields'].get('name')   or point['tags'].get('name')
    region = point['fields'].get('region') or point['tags'].get('region')

    # Get prefix of name
    if name:
        prefix = str(name).split('-')[0]
        global_tags_list['name_prefix'] = prefix

    # Get suffix of region
    if region:
        suffix = str(region).split('-').pop()
        global_tags_list['region_suffix'] = suffix

    # Return
    return global_tags_list
```

**Example Data**

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

**Example Header Written**

```yaml
X-Global-Tags: name_prefix=Tom,region_suffix=shanghai
```



**Sample Event Report**:

```json
{
  "measurement": "keyevent",
  "tags": { "host": "web-01", "service": "order" },
  "fields": { "message": "User order exception" }
}
```


**Generated HTTP Header**:

```http
X-Global-Tags: host=web-01,business_type=ecommerce,DF_WORKSPACE_UUID=wksp_123
```


## :material-numeric-3-circle: Dataway Sinker Rule Configuration


### Sample Rule File (`sinker.json`)

```json
{
  "strict": false,
  "rules": [
    {
      "rules": ["{ business_type = 'ecommerce' }"],  // Match ecommerce events
      "url": "https://kodo.<<< custom_key.brand_main_domain >>>?token=tkn_ecommerce_workspace_token"
    },
    {
      "rules": ["{ DF_WORKSPACE_UUID = 'wksp_123' }"],  // Match specified workspace
      "url": "https://backup.<<< custom_key.brand_main_domain >>>?token=tkn_backup_workspace_token"
    },
    {
      "rules": ["*"],  // Default rule (must exist)
      "url": "https://default.<<< custom_key.brand_main_domain >>>?token=tkn_default_workspace_token"
    }
  ]
}
```


### Rule Syntax Explanation

| Operator | Example | Description |
| --- | --- | --- |
| `=` | `{ env = 'prod' }` | Exact match |
| `!=` | `{ env != 'test' }` | Not equal |
| `in` | `{ region in ['cn-east','cn-north'] }` | Multi-value match |
| `match` | `{ host match 'web-*' }` | Wildcard match |



## :material-numeric-4-circle: Datakit End Configuration Instructions


### Basic Configuration

```bash
# /usr/local/datakit/conf.d/datakit.conf
[dataway]
  # Enable Sinker function
  enable_sinker = true
  # Define sharding basis fields (up to 3)
  global_customer_keys = ["host", "env"]
```



### Precautions

- **Field Type Limitation**: Only string-type fields are supported (all Tag values are strings)

- **Binary Data Support**: Supports binary data sharding like Session Replay, Profiling

- **Performance Impact**: Each additional sharding field increases memory usage by about 5%


## :material-numeric-5-circle: Impact of Global Tags


### 1. Global Tag Example

```bash
# datakit.conf
[election.tags]
    cluster = "cluster-A"  # Global election Tag
[global_tags]
    region = "cn-east"     # Global host Tag
```



### 2. Sharding Identifier Merge Logic

Assuming the event data contains the following Tags:

```json
{
  "tags": { "cluster": "cluster-B", "app": "payment" }
}
```



**Final Sharding Identifier**:

```http
X-Global-Tags: cluster=cluster-B,region=cn-east
```



## Extended Explanation: Sharding of Other Data Types


### 1. Custom Sharding Rules

For non-event data (such as `logging`, `metric`),分流 is achieved by specifying `category`:


```yaml
# Func configuration example: Processing logging data
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
  - category: logging
    fields:
      - src: log_level
        remap:
          error: critical_error
          warn: general_warning
      - service
```


### 2. General Principles

- **Isolated Configuration**: Different data categories (`keyevent`/`logging`/`metric`) use independent configuration blocks

- **Field Simplification**: Sharding identifiers for a single data category do not exceed 3

- **Avoid Conflicts**: Sharding fields for different categories should use different naming conventions


## Troubleshooting



### Common Issues

| Issue | Troubleshooting Steps |
| --- | --- |
| **Sharding Not Effective** | 1. Check Dataway logs `grep 'sinker reload'`<br>2. Verify Header using `curl -v`<br>3. Check Sinker rule priority |
| **Partial Data Loss** | 1. Confirm `strict` mode status<br>2. Check if the default rule exists |
| **Identifier Not Injected** | 1. Validate Func configuration syntax<br>2. Check if the field is of string type |



### Diagnostic Commands

```bash
# View Dataway sharding statistics
curl http://localhost:9528/metrics | grep sinker_requests_total
# Manually test sharding rules
curl -X POST -H "X-Global-Tags: business_type=ecommerce" http://dataway/v1/write/keyevent
```