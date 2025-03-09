# Modify

---

<br />**POST /api/v1/data_mask_rule/\{data_mask_rule_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| data_mask_rule_uuid   | string   | Y          | UUID of the data masking rule<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name                 | string   | Y          | Rule name<br>Allow null: False <br>Maximum length: 128 <br>Allow empty string: False <br> |
| type                 | string   | Y          | Data type<br>Example: logging <br>Allow null: True <br>Optional values: ['logging', 'metric', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'profiling', 'billing'] <br> |
| field                | string   | Y          | Field name<br>Allow null: False <br>Maximum length: 128 <br>Allow empty string: False <br> |
| reExpr               | string   | Y          | Regular expression<br>Allow null: False <br>Maximum length: 5000 <br>Allow empty string: False <br> |
| roleUUIDs            | array    | Y          | Roles in the workspace for which this rule applies data masking<br>Example: ['xxx', 'xxx'] <br>Allow null: False <br> |

## Additional Parameter Notes







## Response
```shell
 
```




</input_content>
<target_language>英语</target_language>
</input>
</example>
</example>
</instruction>
</example>
</example>
</example>