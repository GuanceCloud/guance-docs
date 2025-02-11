# Create [Object Classification Configuration]

---

<br />**POST /api/v1/objc_cfg/create**

## Overview
Create object classification configuration


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| sourceType | string | Y | Source type, default value is `custom_object`<br>Can be empty: False <br>Example: custom_object <br>Optional values: ['object', 'custom_object'] <br> |
| objcGroupUUID | string |  | Business group UUID<br>Can be empty: False <br>Example: objcg_xxxx <br>Allows empty string: True <br>Maximum length: 64 <br> |
| fields | array |  | Custom attribute fields (the reported data must contain these fields, otherwise the reported data will be discarded)<br>Can be empty: False <br>Example: [{'name': 'ak', 'alias': 'machine gun'}] <br> |
| templateInfo | json |  | Template configuration information<br>Can be empty: False <br>Example: {} <br> |

## Additional Parameter Notes

--------------

*`fields` Parameter Explanation*</br>
This parameter stores bound field information in list form. The parameters of list members are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| name     | string | Field name |
| alias     | string | Field alias |

--------------

*`templateInfo` Parameter Explanation*</br>

For detailed structure explanation, please refer to [New Resource Explorer - JSON Configuration - Template Configuration Explanation]

**1. source Parameter Explanation**</br>
Defines the resource's classification and the text content that needs to be displayed on the UI page. The parameters of list members are as follows:

| Parameter Name  | Type     | Description   |
|:----------------|:----------------|:---------|
| key     | string | Resource class |
| name     | string | Resource class alias |

**2. filters Parameter Explanation**</br>
Defines the default listed display fields in the quick filter area of the resource explorer, in the following format:

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

**3. columns Parameter Explanation**</br>
Defines the default listed display fields in the list of the resource explorer, in the following format:

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

**4. views Parameter Explanation**

| Parameter        | Required      | Description                                                                                                                                                                   | Example Write Method                                                                                                                                                                                                                   |
| --------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title     | /       | Tab display title                                                                                                                                                             | "text"                                                                                                                                                                                                                   |
| required  | false   | Whether the tab page does not display, fixed values: true, false.<ul><li>true: does not display by default, linked with keys configuration to determine if data matches, displays if matches</li><li>false: displays by default</li></ul>                                                                  | "false"                                                                                                                                                                                                                |
| keys      | /       | Linked with the required parameter, can configure key fields and field value matching logic, displays if matched. Note: In this case, the required parameter value must be true                                                                                                 | <ul><li>{"key":"*"} : data satisfies the key field</li><li>{"key":"value"} : data contains the key field and its value must be value</li><li>{"key1":"value1","key2":"value2"} : data contains key1 field value is value1 and key2 field value is value2 combination</li></ul>                                    |
| timerange | default | Definition of interface data query time range. Basic format:<ul><li>default: follows platform time control default configuration, generally 15m (i.e., queries data from the last 15 minutes)</li><li>relative time: custom relative time range, time units include m(minutes), h(hours), d(days)</li><li>data time field configuration offset ["pre-offset", "post-offset"]</li></ul> | <ul><li>"default" : last 15 minutes</li><li>"15m" : last 15 minutes</li><li>"1h" : last 1 hour</li><li>"1d" : last 1 day</li><li>["15m","15m"] : based on current data time, offset forward and backward by 15 minutes each</li><li>["5m","30m"] : based on current data time, offset forward by 5 minutes and backward by 30 minutes</li></ul> |
| viewType  | /       | Page type. Currently supports two types: "built-in page" and "built-in view", corresponding to "component" and "dashboard".                                                                                                           | /                                                                                                                                                                                                                      |
| viewName  | /       | Page name. If the page type is a built-in page, fill in the relative path address of the page; if the page type is a built-in view, just fill in the view name. Refer to the following [Associated Built-in Page][Associated Built-in View] explanations                                                                                           | /                                                                                                                                                                                                                      

**5. templateInfo Parameter Example**

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
            "viewName":"built-in page"
          },
          {
            "title":"Tab Title",
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
  "title": "Resource Classification or Alias"
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