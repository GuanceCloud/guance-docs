# 【对象分类配置】修改

---

<br />**POST /api/v1/objc_cfg/\{objc_name\}/modify**

## 概述
修改对象分类配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| objc_name | string | Y | 对象分类配置名称<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceType | string | Y | 来源类型, 默认值为`custom_object`<br>允许为空: False <br>可选值: ['object', 'custom_object'] <br> |
| objcGroupUUID | string |  | 业务分组UUID<br>允许为空: False <br>例子: 哈哈 <br>允许为空字符串: True <br>最大长度: 64 <br> |
| fields | array |  | 自定义属性字段(上报的数据中必然包含这些字段，否则上报的数据将被丢弃)<br>允许为空: False <br>例子: [{'name': 'ak', 'alias': '机枪'}] <br> |
| templateInfo | json |  | 模版配置细腻下<br>允许为空: False <br>例子: {} <br> |

## 参数补充说明

--------------

*`fields`参数说明* </br>
该参数以列表形式存储绑定的字段信息，列表成员参数如下

| 参数名  | 类型     | 描述   |
|:----------------|:----------------|:---------|
| name     | string | 字段名 |
| alias     | string | 字段别名 |

--------------

*`templateInfo`参数说明* </br>

详细的结构说明请参考【新建资源查看器-JSON配置-模版配置说明】

**1. source 参数说明** </br>
定义资源的所属分类以及分类需要在 UI 页面显示的文本内容，列表成员参数如下

| 参数名  | 类型     | 描述   |
|:----------------|:----------------|:---------|
| key     | string | 资源分类 |
| name     | string | 资源分类别名 |

**2. filters 参数说明** </br>
定义资源查看器在快捷筛选处的默认列出显示字段，格式如下所示：

```
"filters":[
  {
    "key":"字段名称"
  },
  {
    "key":"字段名称"
  }
]
```

**3. columns 参数说明** </br>
定义资源查看器在列表的默认列出显示字段，格式如下所示：

```
"columns":[
  {
    "key":"字段名称",
  },
  {
    "key":"字段名称",
  }
]
```

**4. views 参数说明**

| 参数        | 必填      | 描述                                                                                                                                                                   | 写法示例                                                                                                                                                                                                                   |
| --------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title     | /       | Tab 展示标题                                                                                                                                                             | "文本"                                                                                                                                                                                                                   |
| required  | false   | Tab 页是否不显示，固定值：true、false。<ul><li>true：默认不显示，联动 keys 配置判断数据是否匹配，若匹配则显示</li><li>false：默认显示</li></ul>                                                                  | "false"                                                                                                                                                                                                                |
| keys      | /       | 联动required参数，可配置关键字段和字段值匹配逻辑，匹配上则显示。注意：此参数应用情况下，required 参数值必须为 true                                                                                                 | <ul><li>{"key":"*"} ：数据满足 key 字段</li><li>{"key":"value"} ：数据内存在 key 字段且值必须是 value</li><li>{"key1":"value1","key2":"value2"} :数据内存在 key1 字段值是 value1 和 key2 字段值是 value2 组合</li></ul>                                    |
| timerange | default | 界面数据查询时间范围定义。基本格式：<ul><li>default：跟随平台时间控件默认配置，一般为15m（即查询最近15分钟数据）</li><li>相对时间：自定义相对时间范围，时间单位有m(分钟)、h(小时)、d(天)</li><li>联动数据 time 字段配置前后偏移时间段["前偏移","后偏移"]</li></ul> | <ul><li>"default" ：最近 15 分钟</li><li>"15m" ：最近 15 分钟</li><li>"1h" ：最近 1 小时</li><li>"1d" ：最近 1 天</li><li>["15m","15m"] ：根据当前数据 time 时间向前、向后分别偏移 15 分钟</li><li>["5m","30m"] ：根据当前数据 time 时间向前偏移 5 分钟、向后偏移 30 分钟</li></ul> |
| viewType  | /       | 页面类型。当前支持"内置页面"和"内置视图"两个类型，分别对应 "component" 和 "dashboard"。                                                                                                           | /                                                                                                                                                                                                                      |
| viewName  | /       | 页面名称。若页面类型是内置页面，则需要填写页面的相对路径地址；若页面类型是内置视图，则填写视图名称即可。参考下方【关联内置页面】【关联内置视图】说明                                                                                           | /                                                                                                                                                                                                                      

**5. templateInfo 参数示例**

```
{
  "main": [
    {
      "class":"custom_object",
      "source": {
        "key":"资源分类",
        "name":"资源分类别名"
      },
      "filters":[
        {
          "key":"字段名称"
        },
        {
          "key":"字段名称"
        }
      ],
      "table":{
        "columns":[
          {
            "key":"字段名称",
          },
          {
            "key":"字段名称",
          }
        ],
      },
      "detail":{
        "views":[
          {
            "title":"Tab 标题",
            "required":"false",
            "keys":{},
            "view_type": "component",
            "viewName":"内置页面"
          },
          {
            "title":"Tab 标题",
            "required":"false",
            "keys":{},
            "timerange":"default",
            "view_type": "dashboard",
            "viewName":"内置视图"
          }
        ]
      }
    }
  ],
  "title": "资源分类或别名"
}
```




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg/test/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"sourceType":"custom_object","objcGroupUUID":"objcg_xxxx","fields":[{"name":"name"}],"templateInfo":{"iconSet":{},"main":[{"class":"custom_object","source":{"key":"test","name":""},"filters":[],"fills":[],"groups":[],"table":{"columns":[],"detail":{"views":[{"keys":{},"viewType":"dashboard","viewName":"NtpQ 监控视图","title":"viewer","required":true,"timerange":"default"}]}}}],"title":"test"}}' \
--compressed
```




## 响应
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
        "name": "规则1",
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




