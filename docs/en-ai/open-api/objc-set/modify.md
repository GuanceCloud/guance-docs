# Modify Object Classification Configuration

---

<br />**POST /api/v1/objc_cfg/\{objc_name\}/modify**

## Overview
Modify the object classification configuration


## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| objc_name | string | Y | Name of the object classification configuration<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| sourceType | string | Y | Source type, default value is `custom_object`<br>Allow empty: False <br>Options: ['object', 'custom_object'] <br> |
| objcGroupUUID | string |  | Business group UUID<br>Allow empty: False <br>Example: haha <br>Allow empty string: True <br>Maximum length: 64 <br> |
| fields | array |  | Custom attribute fields (data reported must include these fields, otherwise the data will be discarded)<br>Allow empty: False <br>Example: [{'name': 'ak', 'alias': 'machine_gun'}] <br> |
| templateInfo | json |  | Template configuration details<br>Allow empty: False <br>Example: {} <br> |

## Additional Parameter Explanation

--------------

*Explanation for `fields` parameter*</br>
This parameter stores bound field information in list form. The list member parameters are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| name     | string | Field name |
| alias     | string | Field alias |

--------------

*Explanation for `templateInfo` parameter*</br>

For detailed structure explanation, please refer to [Create Resource Explorer - JSON Configuration - Template Configuration Explanation]

**1. Explanation for `source` parameter**</br>
Defines the resource's classification and the text content that needs to be displayed on the UI page. The list member parameters are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| key     | string | Resource class |
| name     | string | Resource class alias |

**2. Explanation for `filters` parameter**</br>
Defines the default fields displayed in the quick filter section of the resource explorer. Format is shown below:

```
"filters":[
  {
    "key":"field_name"
  },
  {
    "key":"field_name"
  }
]
```

**3. Explanation for `columns` parameter**</br>
Defines the default fields displayed in the list of the resource explorer. Format is shown below:

```
"columns":[
  {
    "key":"field_name",
  },
  {
    "key":"field_name",
  }
]
```

**4. Explanation for `views` parameter**

| Parameter        | Required      | Description                                                                                                                                                                   | Example Usage                                                                                                                                                                                                                   |
| --------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title     | /       | Tab display title                                                                                                                                                             | "text"                                                                                                                                                                                                                   |
| required  | false   | Whether the tab page should not be displayed, fixed values: true, false.<ul><li>true: Not displayed by default, linked with keys configuration to determine if data matches; if matched, it displays</li><li>false: Displayed by default</li></ul>                                                                  | "false"                                                                                                                                                                                                                |
| keys      | /       | Linked with `required` parameter, can configure key fields and matching logic. If matched, it displays. Note: This parameter applies only when the `required` parameter value is true                                                                                                 | <ul><li>{"key":"*"}</li><li>{"key":"value"} : Data contains key field and its value must be value</li><li>{"key1":"value1","key2":"value2"} : Data contains key1 field value is value1 and key2 field value is value2 combination</li></ul>                                    |
| timerange | default | Definition of time range for interface data queries. Basic format:<ul><li>default: Follows platform time widget default settings, usually 15m (i.e., query data from the last 15 minutes)</li><li>Relative time: Custom relative time range, units include m(minutes), h(hours), d(days)</li><li>Data time field offset ["before_offset", "after_offset"]</li></ul> | <ul><li>"default" : Last 15 minutes</li><li>"15m" : Last 15 minutes</li><li>"1h" : Last 1 hour</li><li>"1d" : Last 1 day</li><li>["15m","15m"] : Offset 15 minutes before and after based on current data time</li><li>["5m","30m"] : Offset 5 minutes before and 30 minutes after based on current data time</li></ul> |
| viewType  | /       | Page type. Currently supports two types: "built-in page" and "built-in view", corresponding to "component" and "dashboard".                                                                                                           | /                                                                                                                                                                                                                      |
| viewName  | /       | Page name. If the page type is built-in page, fill in the relative path address of the page; if the page type is built-in view, just fill in the view name. Refer to the following [Associated Built-in Page][Associated Built-in View] explanations                                                                                           | /                                                                                                                                                                                                                      

**5. Example for `templateInfo` parameter**

```
{
  "main": [
    {
      "class":"custom_object",
      "source": {
        "key":"resource_class",
        "name":"resource_class_alias"
      },
      "filters":[
        {
          "key":"field_name"
        },
        {
          "key":"field_name"
        }
      ],
      "table":{
        "columns":[
          {
            "key":"field_name",
          },
          {
            "key":"field_name",
          }
        ],
      },
      "detail":{
        "views":[
          {
            "title":"Tab Title",
            "required":"false",
            "keys":{},
            "view_type": "component",
            "viewName":"built-in_page"
          },
          {
            "title":"Tab Title",
            "required":"false",
            "keys":{},
            "timerange":"default",
            "view_type": "dashboard",
            "viewName":"built-in_view"
          }
        ]
      }
    }
  ],
  "title": "Resource Class or Alias"
}
```


## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/objc_cfg/test/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"sourceType":"custom_object","objcGroupUUID":"objcg_xxxx","fields":[{"name":"name"}],"templateInfo":{"iconSet":{},"main":[{"class":"custom_object","source":{"key":"test","name":""},"filters":[],"fills":[],"groups":[],"table":{"columns":[],"detail":{"views":[{"keys":{},"viewType":"dashboard","viewName":"NtpQ Monitoring View","title":"viewer","required":true,"timerange":"default"}]}}}],"title":"test"}}' \
--compressed
```


## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "{ source =  'kodo-log'  and ( hostname in [ '127.0.0.1' ] )}",
        "createAt": 1677653414,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "desc": "",
        "filters": [
            {
                "condition": "and",
                "name": "hostname",
                "operation": "in",
                "value": [
                    "127.0.0.1"
                ]
            }
        ],
        "id": 24,
        "name": "Rule 1",
        "source": "kodo-log",
        "status": 0,
        "type": "logging",
        "updateAt": 1678029845.282458,
        "updator": "xxxx",
        "uuid": "blist_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BC365EB4-B4BA-4194-B0BB-B1AC8FA29804"
} 
```