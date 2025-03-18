# Create a Self-built Security Check

---

<br />**POST /api/v1/self_built_checker/create**

## Overview
Create a self-built security check



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| monitorUUID | string |  | Alert strategy UUID<br>Allow empty string: True <br> |
| alertPolicyUUIDs | array |  | List of alert strategy UUIDs<br>Allow empty: False <br> |
| refKey | string | Y | Custom identifier for the self-built security check (cannot be changed after creation)<br>Example: ref-xxx <br>Allow empty: False <br> |
| title | string | Y | Associated function title<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo | json | Y | Associated function configuration information<br>Allow empty: False <br> |
| refFuncInfo.funcId | string | Y | Associated function ID<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.description | string |  | Associated function description (i.e., function documentation)<br>Example: ref-xxx <br>Allow empty: False <br>Allow empty string: True <br> |
| refFuncInfo.definition | string |  | Associated function definition<br>Example: ref-xxx <br>Allow empty: False <br>Allow empty string: True <br> |
| refFuncInfo.category | string |  | Associated function category<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.args | array |  | Associated function argument list<br>Example: ref-xxx <br>Allow empty: False <br> |
| refFuncInfo.kwargs | json |  | Associated function argument details<br>Example: ref-xxx <br>Allow empty: False <br> |
| isDisabled | boolean |  | Whether it is disabled<br>Example: ref-xxx <br>Allow empty: False <br> |

## Additional Parameter Notes

None



## Response
```shell
 
```