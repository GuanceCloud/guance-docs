# Event Data Sharding Practice: Implementation Based on Dataway Sink
---

This document provides a detailed explanation of how to achieve intelligent sharding of event data (`keyevent`) through **injecting HTTP Headers via DataFlux Func** and **Dataway Sinker rule configuration**. Through this solution, you can route event data with different business attributes and environment characteristics to specified workspaces.



## Solution Principle


### Data Sharding Process

![](img/event_data_sharding.png)


### Core Mechanism Description

1. **DataFlux Func Side Injection Identifier**: During the reporting of event data, dynamically generate the `X-Global-Tags` Header via Func configuration, which includes key-value pairs required for sharding (e.g., `env=prod`).

2. **Dataway Routing Match**: Dataway forwards events carrying specific identifiers to corresponding workspaces based on the rules defined in `sinker.json`.



## 1. Dataway Configuration

Before using this feature, ensure that Dataway is deployed and the Sinker sharding function is enabled.

> For configuring Sinker, refer to: [Dataway Sinker Configuration Guide](../deployment/dataway-sink.md);

**Note**: The version of DataFlux Func used in deployment is located under the `utils` namespace as `internal-dataway`.



## 2. DataFlux Func Configuration


### Injecting X-Global-Tags into Header


#### Core Parameter Description


| Parameter Name | Type | Description |
| --- | --- | --- |
| `CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS` | list/string | Defines the generation rules for event data sharding identifiers |


#### Simple Example


Route all workspace events to the "Event Central Management" workspace:


1. Access the Launcher console;

2. Navigate to the top-right > Modify Application Configuration;

3. Locate the `func2Config` configuration item under the `func2` namespace;

4. Add configuration:

    ```yaml
    CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS:
      - category: keyevent     # Data category
        fields: df_source      # Field used for sharding; here, enter the fixed identifier field for the event
    ```


5. Configure the Dataway Sinker rule: Modify the sinker.json configuration file and set the data routing rules:

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



#### Special Field Description


| Field Name | Description |
| --- | --- |
| `DF_WORKSPACE_UUID` | Workspace ID |
| `DF_WORKSPACE_NAME` | Workspace name |
| `DF_MONITOR_CHECKER_ID` | Monitor ID |
| `DF_MONITOR_CHECKER_NAME` | Monitor name |



#### More Advanced Configurations


| Configuration Method | Example | Description |
| --- | --- | --- |
| Direct Extraction | `-host` | Extract the `host` field from the event data's `tags` or `fields` |
| Rename Field | `-src:service; dest:business_type` | Rename the `service` field to `business_type` |
| Value Mapping | `remap:{order:ecommerce}` | Map the original value `order` to `ecommerce` |
| Default Value | `default:unknown` | Use the default value if the field does not exist |
| Fixed Value | `- dest:env; fixed:prod` | Directly inject the fixed value `env=prod` |

##### Global Tags Generation Rules {#rule}

| Field Name | Type | Default Value | Description |
| ----------------- | ---------------- | ------------- | --------------- |
| `[#].category`                | string/[string]             | `"*"`         | Matches the Category of the data                                          |
| `[#].fields`                  | string/dict [string]/[dict] | -             | Extracts data fields (including Tags and Fields); supports direct extraction and rule-based extraction  |
| `[#].fields[#]`               | string                      | -             | Extracts field names and supports additional extraction fields (see table below)                   |
| `[#].fields[#]`               | dict                        | -             | Extraction field rules                                                 |
| `[#].fields[#].src`           | string                      | -             | Extracts field names and supports additional extraction fields (see table below)                   |
| `[#].fields[#].dest`          | string                      | Same as `src` | Field name to write into the Header after extraction                                   |
| `[#].fields[#].default`       | string                      | -             | Default value to write into the Header when the specified field does not exist                     |
| `[#].fields[#].fixed`         | string                      | -             | Fixed value written to the Header                                       |
| `[#].fields[#].remap`         | dict                        | `null`        | Maps extracted field values                                             |
| `[#].fields[#].remap_default` | string                      | -             | Default value when mapping extracted field values without a corresponding map<br />If not specified, retains the original value<br />Specifying `null` ignores this field |
| `[#].filter`                  | dict/string                 | `null`        | Filters data<br />Supports Tag filtering and filterString filtering      |

##### Custom Global Tags Generation Function ID {#id}


Function ID format is `{script set ID}__{script ID}.{function name}`

Function definition:

| Parameter | Type | Description |
| ------------------- | ------ | ---------------------- |
| `category` | string | Category, e.g., `"keyevent"` |
| `point` | dict | Single data point to be processed |
| `point.measurement` | string | Data `measurement` |
| `point.tags` | dict | Data `tags` content |
| `point.fields` | dict | Data `fields` content |
| `extra_fields` | dict | Additional extracted fields (see table below) |

Example:

- `point` parameter value

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

- `extra_fields` parameter value

```
{
  "DF_WORKSPACE_UUID"      : "wksp_xxxxx",
  "DF_MONITOR_CHECKER_ID"  : "rul_xxxxx",
  "DF_MONITOR_CHECKER_NAME": "Monitor XXXXX",
  "DF_WORKSPACE_NAME"      : "Workspace XXXXX"
}
```





#### Verification of Generated Effects

An example of adding `key:value` in the Header {#example}


##### Writing Event Data to the Same Workspace


1. Extract fields from events


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


**Example Written Header**


```yaml
X-Global-Tags: host=web-001,name=Tom,DF_WORKSPACE_UUID=wksp_xxxxx
```




2. Extract a single field from events


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


**Example Written Header**


```yaml
X-Global-Tags: host=web-001
```



##### Writing All Data to the Same Workspace


1. Omitting `category` indicates processing all data

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

**Example Written Header**

```yaml
X-Global-Tags: DF_WORKSPACE_UUID=wksp_xxxxx
```

##### Other Situations

1. Changing field names while extracting fields


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

**Example Written Header**

```yaml
X-Global-Tags: HOST=web-001
```



2. Mapping field values while extracting fields

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

**Example Written Header**

```yaml
X-Global-Tags: result=ok
```


3. Using default values while extracting fields

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

**Example Written Header**

```yaml
X-Global-Tags: result=unknown
```


4. Writing fixed values

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

**Example Written Header**

```yaml
X-Global-Tags: app=guance
```


5. Matching data using Tag method

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

**Example Written Header**

```yaml
X-Global-Tags: host=app-001
```


6. Matching data using filterString method

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

**Example Written Header**

```yaml
X-Global-Tags: host=app-001
```

7. Extracting event field prefixes and suffixes using custom functions

**Example Configuration**

```yaml
CUSTOM_INTERNAL_DATAWAY_X_GLOBAL_TAGS: my_script_set__my_script.make_global_tags
```

**Example Function located in script set my_script_set, script my_script**

```yaml
def make_global_tags(category, point, extra_fields):
    # Only process event type data
    if category != 'keyevent':
        return

    global_tags_list = {}

    # Get name and region fields from the data's fields or tags
    name   = point['fields'].get('name')   or point['tags'].get('name')
    region = point['fields'].get('region') or point['tags'].get('region')

    # Get the prefix of name
    if name:
        prefix = str(name).split('-')[0]
        global_tags_list['name_prefix'] = prefix

    # Get the suffix of region
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

**Example Written Header**

```yaml
X-Global-Tags: name_prefix=Tom,region_suffix=shanghai
```



**Example Reported Events**:

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


## 3. Dataway Sinker Rule Configuration


### Example Rule File (`sinker.json`)

```json
{
  "strict": false,
  "rules": [
    {
      "rules": ["{ business_type = 'ecommerce' }"],  // Matches ecommerce events
      "url": "https://kodo.<<< custom_key.brand_main_domain >>>?token=tkn_ecommerce_space_token"
    },
    {
      "rules": ["{ DF_WORKSPACE_UUID = 'wksp_123' }"],  // Matches specified workspace
      "url": "https://backup.<<< custom_key.brand_main_domain >>>?token=tkn_backup_space_token"
    },
    {
      "rules": ["*"],  // Default rule (must exist)
      "url": "https://default.<<< custom_key.brand_main_domain >>>?token=tkn_default_space_token"
    }
  ]
}
```


### Rule Syntax Description

| Operator | Example | Description |
| --- | --- | --- |
| `=` | `{ env = 'prod' }` | Exact match |
| `!=` | `{ env != 'test' }` | Not equal |
| `in` | `{ region in ['cn-east','cn-north'] }` | Multi-value match |
| `match` | `{ host match 'web-*' }` | Wildcard match |



## 4. Datakit End Configuration Instructions


### Basic Configuration

```bash
# /usr/local/datakit/conf.d/datakit.conf
[dataway]
  # Enable Sinker function
  enable_sinker = true
  # Define sharding basis fields (up to 3)
  global_customer_keys = ["host", "env"]
```



### Notes

- **Field Type Restrictions**: Only string-type fields are supported (all Tag values are strings)

- **Binary Data Support**: Supports Session Replay, Profiling, etc., binary data sharding

- **Performance Impact**: Each additional sharding field increases memory usage by approximately 5%


## 5. Impact of Global Tags


### 1. Global Tag Example

```bash
# datakit.conf
[election.tags]
    cluster = "cluster-A"  # Global election Tag
[global_tags]
    region = "cn-east"     # Global host Tag
```



### 2. Sharding Identifier Merging Logic

Assume the event data contains the following Tags:

```json
{
  "tags": { "cluster": "cluster-B", "app": "payment" }
}
```



**Final Sharding Identifier**:

```http
X-Global-Tags: cluster=cluster-B,region=cn-east
```



## Extended Explanation: Sharding for Other Data Types


### 1. Custom Sharding Rules

For non-event data (such as `logging`, `metric`),分流 is achieved by specifying `category`:


```yaml
# Func Configuration Example: Handling logging data
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

- **Field Simplification**: The number of sharding identifiers for a single data category should not exceed 3

- **Avoid Conflicts**: It is recommended to use different naming conventions for sharding fields across different categories


## Troubleshooting



### Common Issues

| Phenomenon | Troubleshooting Steps |
| --- | --- |
| **Sharding Not Effective** | 1. Check Dataway logs `grep 'sinker reload'`<br>2. Verify Header using `curl -v`<br>3. Check Sinker rule priority |
| **Partial Data Loss** | 1. Confirm `strict` mode status<br>2. Check if default rule exists |
| **Identifier Not Injected** | 1. Verify Func configuration syntax<br>2. Check if field is of string type |



### Diagnostic Commands

```bash
# View Dataway sharding statistics
curl http://localhost:9528/metrics | grep sinker_requests_total
# Manually test sharding rules
curl -X POST -H "X-Global-Tags: business_type=ecommerce" http://dataway/v1/write/keyevent
```