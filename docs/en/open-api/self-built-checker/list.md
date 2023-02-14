# Intelligent Inspection List

---

<br />**get /api/v1/self_built_checker/list**

## Overview
Page out a self-built patrol list for the current workspace.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | commaArray |  | Alarm policy UUID<br>Allow null: False <br> |
| checkerUUID | commaArray |  | UUID of intelligent inspection<br>Allow null: False <br> |
| refKey | commaArray |  | refKey, multiple values are divided by English commas<br>Allow null: False <br> |
| search | string |  | Search for intelligent inspection name<br>Allow null: False <br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | Quantity returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/list?refKey=zyAy2l9v,zyAy897f' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## Response
```shell
{} 
```




