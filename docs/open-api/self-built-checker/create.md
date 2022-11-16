# 创建一个自建监控器

---

<br />**post /api/v1/self_built_checker/create**

## 概述
创建一个自建监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | string |  | 通知策略(即监控器分组)UUID<br>允许空字符串: True <br> |
| refKey | string | Y | 自建监控器的自定义标识（新建之后不可变更）<br>例子: ref-xxx <br>允许为空: False <br> |
| title | string | Y | 关联函数标题<br>例子: ref-xxx <br>允许为空: False <br> |
| refFuncInfo | json | Y | 关联函数配置信息<br>允许为空: False <br> |
| refFuncInfo.funcId | string | Y | 关联函数 ID<br>例子: ref-xxx <br>允许为空: False <br> |
| refFuncInfo.description | string |  | 关联函数描述（即函数文档）<br>例子: ref-xxx <br>允许为空: False <br>允许空字符串: True <br> |
| refFuncInfo.definition | string |  | 关联函数函数定义<br>例子: ref-xxx <br>允许为空: False <br>允许空字符串: True <br> |
| refFuncInfo.category | string |  | 关联函数函数分类<br>例子: ref-xxx <br>允许为空: False <br> |
| refFuncInfo.args | array |  | 关联函数参数列表<br>例子: ref-xxx <br>允许为空: False <br> |
| refFuncInfo.kwargs | json |  | 关联函数参数详情<br>例子: ref-xxx <br>允许为空: False <br> |
| isDisabled | boolean |  | 是否已禁用<br>例子: ref-xxx <br>允许为空: False <br> |

## 参数补充说明

None





## 响应
```shell
 
```




