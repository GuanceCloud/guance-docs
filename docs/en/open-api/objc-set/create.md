# Create Object Classification Configuration

---

<br />**POST /api/v1/objc_cfg/create**

## Overview
Create an object classification configuration



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| sourceType | string | Y | Source type, default value is `custom_object`<br>Allow null: False <br>Example: custom_object <br>Optional values: ['object', 'custom_object'] <br> |
| objcGroupUUID | string |  | Business group UUID<br>Allow null: False <br>Example: objcg_xxxx <br>Allow empty string: True <br>Maximum length: 64 <br> |
| fields | array |  | Custom attribute fields (the reported data must contain these fields, otherwise the reported data will be discarded)<br>Allow null: False <br>Example: [{'name': 'ak', 'alias': 'machine gun'}] <br> |
| templateInfo | json |  | Template configuration information<br>Allow null: False <br>Example: {} <br> |

## Additional Parameter Descriptions

--------------

*Description of the `fields` parameter*</br>
This parameter stores bound field information in list form. The parameters for list members are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| name     | string | Field name |
| alias     | string | Field alias |

--------------

*Description of the `templateInfo` parameter*</br>

For detailed structure description, please refer to [Create Resource Explorer - JSON Configuration - Template Configuration Description]

**1. Description of the `source` parameter**</br>
Defines the resource's category and the text content that needs to be displayed on the UI page. The parameters for list members are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| key     | string | Resource class |
| name     | string | Resource class alias |

**2. Description of the `filters` parameter**</br>
Defines the default display fields in the quick filter section of the resource explorer, formatted as shown below:

```
"filters":[
  {
    "key":"field name"
  },
  {
    "key":"field name"
  }
]
```

**3. Description of the `columns` parameter**</br>
Defines the default display fields in the list of the resource explorer, formatted as shown below:

```
"columns":[
  {
    "key":"field name",
  },
  {
    "key":"field name",
  }
]
```

**4. Description of the `views` parameter**

| Parameter        | Required      | Description                                                                                                                                                                   | Example Write Method                                                                                                                                                                                                                   |
| --------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title     | /       | Tab display title                                                                                                                                                             | "text"                                                                                                                                                                                                                   |
| required  | false   | Whether the tab page is hidden, fixed value: true, false.<ul><li>true: Hidden by default, linked with keys configuration to determine if data matches; if it matches, then it displays</li><li>false: Displayed by default</li></ul>                                                                  | "false"                                                                                                                                                                                                                |
| keys      | /       | Linked with the `required` parameter, can configure key fields and matching logic for field values, displaying when matched. Note: In this case, the `required` parameter value must be true                                                                                                 | <ul><li>{"key":"*"} : Data satisfies the key field</li><li>{"key":"value"} : Data contains the key field and its value must be value</li><li>{"key1":"value1","key2":"value2"} : Data contains key1 field with value value1 and key2 field with value value2 combination</li></ul>                                    |
| timerange | default | Definition of the time range for querying interface data. Basic format:<ul><li>default: Follows the platform's default time widget configuration, usually 15m (i.e., query the latest 15 minutes of data)</li><li>Relative time: Custom relative time range, time units include m(minutes), h(hours), d(days)</li><li>Data time field configuration linked offset ["before offset", "after offset"]</li></ul> | <ul><li>"default" : Latest 15 minutes</li><li>"15m" : Latest 15 minutes</li><li>"1h" : Latest 1 hour</li><li>"1d" : Latest 1 day</li><li>["15m","15m"] : Offset 15 minutes before and after the current data time</li><li>["5m","30m"] : Offset 5 minutes before and 30 minutes after the current data time</li></ul> |
| viewType  | /       | Page type. Currently supports two types: "built-in page" and "built-in view", corresponding to "component" and "dashboard".                                                                                                           | /                                                                                                                                                                                                                      |
| viewName  | /       | Page name. If the page type is a built-in page, fill in the relative path address of the page; if the page type is a built-in view, fill in the view name only. Refer to the following [Associated Built-in Page][Associated Built-in View] descriptions                                                                                           | /                                                                                                                                                                                                                      

**5. Example of `templateInfo` parameter**

```
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
  "title": "Resource Classification or Alias"
}
```




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg/create' \
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