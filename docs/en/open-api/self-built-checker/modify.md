# Modify an Intelligent Inspection

---

<br />**post /api/v1/self_built_checker/modify**

## Overview
Modify a intelligent inspection.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | string |  | Alarm policy UUID<br>Allow empty strings: True <br> |
| ruleUUID | string |  | UUID of intelligent inspection<br>Example: rul_xxxxx <br>Allow null: False <br> |
| refKey | string |  | Association key of intelligent inspection<br>Example: xxx <br>Allow null: False <br> |
| title | string |  | Correlation function title<br>Example: ref-xxx <br>Allow null: False <br> |
| refFuncInfo | json |  | Correlation function configuration information<br>Allow null: False <br> |
| refFuncInfo.description | string |  | Correlation function description (that is, function document)<br>Example: ref-xxx <br>Allow null: False <br>Allow empty strings: True <br> |
| refFuncInfo.definition | string |  | Definition of correlation function<br>Example: ref-xxx <br>Allow null: False <br>Allow empty strings: True <br> |
| refFuncInfo.category | string |  | Classification of correlation function<br>Example: ref-xxx <br>Allow null: False <br> |
| refFuncInfo.args | array |  | Association function parameter list<br>Example: ref-xxx <br>Allow null: False <br> |
| refFuncInfo.kwargs | json |  | Details of correlation function parameters<br>Example: ref-xxx <br>Allow null: False <br> |

## Supplementary Description of Parameters

None





## Response
```shell
 
```




