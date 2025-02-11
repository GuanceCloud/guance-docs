# Topology Graph Data Structure Explanation

## [Service Relationship Diagram] Data Structure Explanation

```
{
  "services": [
    {
      "data": {
        "__size": 10,
        "__fill": 10,
        "fieldA": "1.0",
        "fieldB": "test"
      },
      "name": "demo_web",
      "type": "web"
    },
    {
      "data": {
        "__size": 10,
        "__fill": 10,
        "fieldA": "1.0",
        "fieldB": "test"
      },
      "name": "demo_framework",
      "type": "framework"
    }
  ],
  "maps": [
    {
      "source": "demo_web",
      "target": "demo_framework"
    }
  ]
}
```

Field Description:

| Parameter Name | Type  | Description  |
| --- | --- | --- |
| maps | array | List of directed edges in the topology graph |
| maps.source | string | Source service name |
| maps.target | string | Target service name |
| services | array | List of service nodes in the topology graph |
| services.name | string | Service name |
| services.type | string | Service type, currently available types are<br/>["app", "framework", "cache", "message_queue", "custom", "db", "web", "aws_lambda"]<br/>Custom types can also be entered |
| services.data | json | Service node data |
| services.data.__size | double | Value for circle size field, this value has no range<br/>It adjusts automatically according to the set size |
| services.data.__fill | double | Value for fill color field, this value's range is<br/>the maximum and minimum values of the **gradient color scheme** |
| services.data.fieldA | string | Field displayed in tooltip |
| services.data.fieldB | string | Field displayed in tooltip |

## [Resource Relationship Diagram] Data Structure Explanation

```
{
  "serviceResource": [
    {
      "data": {
        "__fill": 10,
        "avg_per_second_title": "AAA",
        "avg_per_second": 1,
        "p99_title": "AAA",
        "p99": 1,
        "error_rate_title": "AAA",
        "error_rate": 1
      },
      "service": "demo_web",
      "resource": "demo_web_resource",
      "source_type": "web"
    },
    {
      "data": {
        "__fill": 10,
        "avg_per_second_title": "AAA",
        "avg_per_second": 1,
        "p99_title": "AAA",
        "p99": 1,
        "error_rate_title": "AAA",
        "error_rate": 1
      },
      "service": "demo_framework",
      "resource": "demo_framework_resource",
      "source_type": "framework"
    }
  ],
  "maps": [
    {
      "source": "demo_web",
      "source_resource": "demo_web_resource",
      "target": "demo_framework",
      "target_resource": "demo_framework_resource"
    }
  ]
}
```

Field Description:

| Parameter Name | Type  | Description  |
| --- | --- | --- |
| maps | array | List of directed edges in the topology graph |
| maps.source | string | Source service name |
| maps.source_resource | string | Source resource name |
| maps.target | string | Target service name |
| maps.target_resource | string | Target resource name |
| serviceResource | array | List of resource nodes in the topology graph |
| serviceResource.service | string | Service name |
| serviceResource.resource | string | Resource name |
| serviceResource.source_type | string | Resource type, currently available types are<br/>["app", "framework", "cache", "message_queue", "custom", "db", "web", "aws_lambda"]<br/>Custom types can also be entered |
| serviceResource.data | json | Resource node data |
| serviceResource.data.__fill | double | Value for fill color field, this value's range is<br/>the maximum and minimum values of the **gradient color scheme** |
| serviceResource.data.avg_per_second_title | string | Title for left field |
| serviceResource.data.avg_per_second | double | Value for left field |
| serviceResource.data.p99_title | string | Title for middle field |
| serviceResource.data.p99 | double | Value for middle field |
| serviceResource.data.error_rate_title | string | Title for right field |
| serviceResource.data.error_rate | double | Value for right field |