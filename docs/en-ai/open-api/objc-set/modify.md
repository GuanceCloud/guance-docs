# Modify Object Classification Configuration

---

<br />**POST /api/v1/objc_cfg/\{objc_name\}/modify**

## Overview
Modify the object classification configuration.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| objc_name         | string | Y    | Object classification configuration name |

## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| sourceType        | string | Y    | Source type, default value is `custom_object`<br>Allow null: False <br>Options: ['object', 'custom_object'] <br> |
| objcGroupUUID     | string |      | Business group UUID<br>Allow null: False <br>Example: Haha <br>Allow empty string: True <br>Maximum length: 64 <br> |
| fields            | array  |      | Custom attribute fields (the reported data must contain these fields; otherwise, the reported data will be discarded)<br>Allow null: False <br>Example: [{'name': 'ak', 'alias': 'machine gun'}] <br> |
| templateInfo      | json   |      | Template configuration details<br>Allow null: False <br>Example: {} <br> |

## Additional Parameter Descriptions

--------------

*Description of `fields` parameter*</br>
This parameter stores bound field information in list form. The list member parameters are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| name            | string | Field name |
| alias           | string | Field alias |

--------------

*Description of `templateInfo` parameter*</br>

For detailed structure description, please refer to [Create Resource Explorer - JSON Configuration - Template Configuration Description]

**1. source parameter description**</br>
Defines the resource category and the text content that needs to be displayed on the UI page. List member parameters are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| key             | string | Resource class |
| name            | string | Resource class alias |

**2. filters parameter description**</br>
Defines the default display fields for quick filtering in the resource explorer. Format is as follows:

```json
"filters":[
  {
    "key":"field name"
  },
  {
    "key":"field name"
  }
]
```

**3. columns parameter description**</br>
Defines the default display fields in the resource explorer's list. Format is as follows:

```json
"columns":[
  {
    "key":"field name",
  },
  {
    "key":"field name",
  }
]
```

**4. views parameter description**

| Parameter        | Required | Description                                                                                                                                                                   | Example Syntax                                                                                                                                                                                                                   |
| -------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title          | /       | Tab display title                                                                                                                                                             | "text"                                                                                                                                                                                                                   |
| required       | false   | Whether the tab page is hidden, fixed values: true, false.<ul><li>true: Hidden by default, linked with keys configuration to determine if data matches; if it does, it shows</li><li>false: Shown by default</li></ul>                                                                  | "false"                                                                                                                                                                                                                |
| keys           | /       | Linked with the `required` parameter, configure key fields and matching logic for field values, show if matched. Note: In this case, the value of the `required` parameter must be true                                                                                                 | <ul><li>{"key":"*"} : Data satisfies the key field</li><li>{"key":"value"} : Data contains the key field and its value must be value</li><li>{"key1":"value1","key2":"value2"} : Data contains key1 with value1 and key2 with value2 combination</li></ul>                                    |
| timerange      | default | Definition of the time range for querying interface data. Basic format:<ul><li>default: Follows the platform's default time widget settings, usually 15m (i.e., query data from the last 15 minutes)</li><li>Relative time: Custom relative time range, units include m(minutes), h(hours), d(days)</li><li>Data linkage with time field configuration ["offset before", "offset after"]</li></ul> | <ul><li>"default" : Last 15 minutes</li><li>"15m" : Last 15 minutes</li><li>"1h" : Last 1 hour</li><li>"1d" : Last 1 day</li><li>["15m","15m"] : Offset 15 minutes before and after the current data time</li><li>["5m","30m"] : Offset 5 minutes before and 30 minutes after the current data time</li></ul> |
| viewType       | /       | Page type. Currently supports two types: "built-in page" and "built-in view", corresponding to "component" and "dashboard".                                                                                                           | /                                                                                                                                                                                                                      |
| viewName       | /       | Page name. If the page type is a built-in page, fill in the relative path address of the page; if the page type is a built-in view, fill in the view name only. Refer to the following [Link Built-in Pages][Link Built-in Views] descriptions                                                                                           | /

**5. templateInfo parameter example**

```json
{
  "main": [
    {
      "class":"custom_object",
      "source": {
        "key":"resource classification",
        "name":"resource classification alias"
      },
      "filters":[
        {
          "key":"field name"
        },
        {
          "key":"field name"
        }
      ],
      "table":{
        "columns":[
          {
            "key":"field name",
          },
          {
            "key":"field name",
          }
        ],
      },
      "detail":{
        "views":[
          {
            "title":"Tab title",
            "required":"false",
            "keys":{},
            "view_type": "component",
            "viewName":"built-in page"
          },
          {
            "title":"Tab title",
            "required":"false",
            "keys":{},
            "timerange":"default",
            "view_type": "dashboard",
            "viewName":"built-in view"
          }
        ]
      }
    }
  ],
  "title": "Resource classification or alias"
}
```

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg/test/modify' \
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