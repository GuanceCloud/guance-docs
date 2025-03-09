# Create Object Classification Configuration

---

<br />**POST /api/v1/objc_cfg/create**

## Overview
Create object classification configuration



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| sourceType | string | Y | Source type, default value is `custom_object`<br>Allow empty: False <br>Example: custom_object <br>Optional values: ['object', 'custom_object'] <br> |
| objcGroupUUID | string |  | Business group UUID<br>Allow empty: False <br>Example: objcg_xxxx <br>Allow empty string: True <br>Maximum length: 64 <br> |
| fields | array |  | Custom attribute fields (the reported data must contain these fields, otherwise the reported data will be discarded)<br>Allow empty: False <br>Example: [{'name': 'ak', 'alias': 'machine_gun'}] <br> |
| templateInfo | json |  | Template configuration information<br>Allow empty: False <br>Example: {} <br> |

## Additional Parameter Explanation

--------------

*Explanation of `fields` parameter*</br>
This parameter stores bound field information in list form. The list member parameters are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| name     | string | Field name |
| alias     | string | Field alias |

--------------

*Explanation of `templateInfo` parameter*</br>

For detailed structure explanation, please refer to [Create Resource Explorer - JSON Configuration - Template Configuration Explanation]

**1. Explanation of source parameter**</br>
Defines the resource's classification and the text content that needs to be displayed on the UI page. List member parameters are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| key     | string | Resource class |
| name     | string | Resource class alias |

**2. Explanation of filters parameter**</br>
Defines the default listed display fields in the resource explorer's quick filter section. The format is shown below:

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

**3. Explanation of columns parameter**</br>
Defines the default listed display fields in the resource explorer's list. The format is shown below:

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

**4. Explanation of views parameter**

| Parameter        | Required      | Description                                                                                                                                                                   | Example Write Method                                                                                                                                                                                                                   |
| --------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title     | /       | Tab display title                                                                                                                                                             | "text"                                                                                                                                                                                                                   |
| required  | false   | Whether the tab page should not be displayed, fixed value: true, false.<ul><li>true: Not displayed by default, linked with keys configuration to determine if data matches; if it matches, then display</li><li>false: Displayed by default</li></ul>                                                                  | "false"                                                                                                                                                                                                                |
| keys      | /       | Linked with required parameter, can configure key fields and matching logic for field values, display if matched. Note: This parameter applies only when the required parameter value is true                                                                                                 | <ul><li>{"key":"*"} : Data satisfies key field</li><li>{"key":"value"} : Data contains key field and value must be value</li><li>{"key1":"value1","key2":"value2"} : Data contains key1 field value is value1 and key2 field value is value2 combination</li></ul>                                    |
| timerange | default | Definition of interface data query time range. Basic format:<ul><li>default: Follow platform time widget default configuration, usually 15m (i.e., query data from the last 15 minutes)</li><li>Relative time: Custom relative time range, units include m(minutes), h(hours), d(days)</li><li>Data linkage time field configuration ["pre_offset", "post_offset"]</li></ul> | <ul><li>"default" : Last 15 minutes</li><li>"15m" : Last 15 minutes</li><li>"1h" : Last 1 hour</li><li>"1d" : Last 1 day</li><li>["15m","15m"] : Based on current data time, offset forward and backward by 15 minutes each</li><li>["5m","30m"] : Based on current data time, offset forward by 5 minutes and backward by 30 minutes</li></ul> |
| viewType  | /       | Page type. Currently supports two types: "built-in page" and "built-in view", corresponding to "component" and "dashboard".                                                                                                           | /                                                                                                                                                                                                                      |
| viewName  | /       | Page name. If the page type is a built-in page, fill in the relative path address of the page; if the page type is a built-in view, just fill in the view name. Refer to the following [Associated Built-in Pages][Associated Built-in Views] explanation                                                                                           | /                                                                                                                                                                                                                      

**5. Example of templateInfo parameter**

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
            "viewName":"Built-in Page"
          },
          {
            "title":"Tab Title",
            "required":"false",
            "keys":{},
            "timerange":"default",
            "view_type": "dashboard",
            "viewName":"Built-in View"
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
curl 'https://openapi.guance.com/api/v1/objc_cfg/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"sourceType":"custom_object","objcGroupUUID":"objcg_xxxx","fields":[{"name":"name"}],"templateInfo":{"main":[{"class":"custom_object","source":{"key":"test","name":""},"filters":[],"fills":[],"groups":[],"table":{"columns":[],"detail":{"views":[{"keys":{},"viewType":"dashboard","viewName":"NtpQ Monitoring View","title":"viewer","required":true,"timerange":"default"}]}}}],"title":"test"}}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "sourceType": "custom_object",
        "name": "test",
        "alias": "",
        "workspaceUUID": "wksp_xxxx",
        "objcGroupUUID": "objcg_xxx",
        "dashboardBindSet": [],
        "fields": [
            {
                "name": "name"
            }
        ],
        "extend": {
            "fills": [],
            "groups": [],
            "columns": [],
            "filters": [],
            "iconSet": {},
            "tableDetailViews": [
                {
                    "keys": {},
                    "viewType": "dashboard",
                    "viewName": "NtpQ Monitoring View",
                    "title": "viewer",
                    "required": true,
                    "timerange": "default"
                }
            ]
        },
        "id": 260,
        "uuid": "objc_xxxx",
        "status": 0,
        "creator": "acnt_xxxx",
        "updator": "acnt_xxxx",
        "createAt": 1734576782,
        "deleteAt": -1,
        "updateAt": 1734590084.4779553
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "96555412482790535"
} 
```