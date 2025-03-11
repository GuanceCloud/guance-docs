# Create an Intelligent Inspection

---

<br />**post /api/v1/self_built_checker/create**

## Overview
Create an intelligent inspection.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | string |  | Alarm policy UUID<br>Allow empty strings: True <br> |
| refKey | string | Y | Custom ID of intelligent inspection (cannot be changed after new creation)<br>Example: ref-xxx <br>Allow null: False <br> |
| title | string | Y | Correlation function title<br>Example: ref-xxx <br>Allow null: False <br> |
| refFuncInfo | json | Y | Correlation function configuration information<br>Allow null: False <br> |
| refFuncInfo.funcId | string | Y | Association function ID<br>Example: ref-xxx <br>Allow null: False <br> |
| refFuncInfo.description | string |  | Correlation function description (that is, function document)<br>Example: ref-xxx <br>Allow null: False <br>Allow empty strings: True <br> |
| refFuncInfo.definition | string |  | Definition of correlation function<br>Example: ref-xxx <br>Allow null: False <br>Allow empty strings: True <br> |
| refFuncInfo.category | string |  | Classification of correlation function<br>Example: ref-xxx <br>Allow null: False <br> |
| refFuncInfo.args | array |  | Association function parameter list<br>Example: ref-xxx <br>Allow null: False <br> |
| refFuncInfo.kwargs | json |  | Details of correlation function parameters<br>Example: ref-xxx <br>Allow null: False <br> |
| isDisabled | boolean |  | Disabled or not<br>Example: ref-xxx <br>Allow null: False <br> |

## Supplementary Description of Parameters

None





## Response
```shell
 
```




