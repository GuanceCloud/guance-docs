# 修改一个智能巡检

---

<br />**POST /api/v1/self_built_checker/modify**

## 概述
修改一个自建巡检




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | string |  | 告警策略UUID<br>允许为空字符串: True <br> |
| alertPolicyUUIDs | array |  | 告警策略 uuid 列表<br>允许为空: False <br> |
| ruleUUID | string |  | 自建巡检的UUID<br>例子: rul_xxxxx <br>允许为空: False <br> |
| refKey | string |  | 自建巡检的关联key<br>例子: xxx <br>允许为空: False <br> |
| title | string |  | 关联函数标题<br>例子: ref-xxx <br>允许为空: False <br> |
| refFuncInfo | json |  | 关联函数配置信息<br>允许为空: False <br> |
| refFuncInfo.description | string |  | 关联函数描述（即函数文档）<br>例子: ref-xxx <br>允许为空: False <br>允许为空字符串: True <br> |
| refFuncInfo.definition | string |  | 关联函数函数定义<br>例子: ref-xxx <br>允许为空: False <br>允许为空字符串: True <br> |
| refFuncInfo.category | string |  | 关联函数函数分类<br>例子: ref-xxx <br>允许为空: False <br> |
| refFuncInfo.args | array |  | 关联函数参数列表<br>例子: ref-xxx <br>允许为空: False <br> |
| refFuncInfo.kwargs | json |  | 关联函数参数详情<br>例子: ref-xxx <br>允许为空: False <br> |

## 参数补充说明

None





## 响应
```shell
 
```




