# Create a Smart Security Check

---

<br />**POST /api/v1/self_built_checker/create**

## Overview
Create a user-defined security check



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| monitorUUID | string | No | Alert policy UUID<br>Allow empty string: True <br> |
| alertPolicyUUIDs | array | No | List of alert policy UUIDs<br>Allow empty: False <br> |
| refKey | string | Yes | Custom identifier for the user-defined security check (cannot be changed after creation)<br>Example: ref-xxx <br>Allow empty: False <br> |
| title | string | Yes | Associated function title<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo | json | Yes | Associated function configuration information<br>Allow empty: False <br> |
| refFuncInfo.funcId | string | Yes | Associated function ID<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.description | string | No | Associated function description (i.e., function documentation)<br>Example: ref-xxx <br>Allow empty: False <br>Allow empty string: True <br> |
| refFuncInfo.definition | string | No | Associated function definition<br>Example: ref-xxx <br>Allow empty: False <br>Allow empty string: True <br> |
| refFuncInfo.category | string | No | Associated function category<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.args | array | No | List of associated function parameters<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.kwargs | json | No | Details of associated function parameters<br>Example: ref-xxx <br>Allow empty: False <br> |
| isDisabled | boolean | No | Whether it is disabled<br>Example: ref-xxx <br>Allow empty: False <br> |

## Additional Parameter Notes

None



## Response
```shell
 
```