# Modify a Self-built Security Check

---

<br />**POST /api/v1/self_built_checker/modify**

## Overview
Modify a self-built security check



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| monitorUUID | string | No | Alert strategy UUID<br>Allow empty string: True <br> |
| alertPolicyUUIDs | array | Yes | List of alert strategy UUIDs<br>Allow empty: False <br> |
| ruleUUID | string | Yes | UUID of the self-built security check<br>Example: rul_xxxxx <br>Allow empty: False <br> |
| refKey | string | Yes | Associated key of the self-built security check<br>Example: xxx <br>Allow empty: False <br> |
| title | string | Yes | Title of the associated function<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo | json | Yes | Configuration information of the associated function<br>Allow empty: False <br> |
| refFuncInfo.description | string | Yes | Description of the associated function (i.e., function documentation)<br>Example: ref-xxx <br>Allow empty: False <br>Allow empty string: True <br> |
| refFuncInfo.definition | string | Yes | Definition of the associated function<br>Example: ref-xxx <br>Allow empty: False <br>Allow empty string: True <br> |
| refFuncInfo.category | string | Yes | Category of the associated function<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.args | array | Yes | List of parameters for the associated function<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.kwargs | json | Yes | Details of parameters for the associated function<br>Example: ref-xxx <br>Allow empty: False <br> |

## Additional Parameter Notes

None



## Response
```shell
 
```