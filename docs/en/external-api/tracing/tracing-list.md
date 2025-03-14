# [Tracing] APM Service List

---

<br />**GET /api/v1/tracing/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| workspaceUUID | string | Y | Workspace ID<br> |
| start | integer | Y | Start time in milliseconds<br> |
| end | integer | Y | End time in milliseconds<br> |
| filters | json |  | Tag filtering and search, consistent with the ES querydata interface<br> |
| serviceTypes | array |  | Filter service type list<br> |
| order | string |  | Sort by resource name, format `[{key:desc/asc}]`<br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | Number of items per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes







## Response
```shell
 
```




</input_content>
</target_language>
</input>