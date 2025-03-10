# Topology Graph Data Structure Explanation

Field Description

| Parameter                   | Type | Required | Description                                                                                       |
| --------------------------- | ---- | -------- | ------------------------------------------------------------------------------------------------- |
| column_names                | list |          | Set of column names corresponding to the numeric values, this value will be automatically filled based on `series data` for external function data sources. |
| column_names[#]             | str  |          |                                                                                                   |
| series                      | list | Required | Data groups, the length represents the number of data groups (only one group of data in topology graphs). |
| series[#]                   | dict |          | A set of data.                                                                                    |
| series[#].tags              | dict |          | Data associated attributes (used to display related properties of the data, table displays it as column data, alias key value mapping). |
| series[#].columns           | list | Required | List of data source field keys, fixed as ['time', 'data'].                                        |
| series[#].values            | list | Required | Two-dimensional array, each item in the array represents a piece of data, here there is only one piece of data. |
| series[#].values[#]         | list |          | Composed of `[timestamp, data value]`, the length should match `series[#].columns`.                |
| series[#].values[#][0]      | str  |          | Value corresponding to the 'time' column, can be null.                                            |
| series[#].values[#][1]      | str  |          | Value corresponding to the 'data' column, its value is a serialized object, supporting types `ServiceMap`, `ResourceMap`. |

## ServiceMap Service Relationship Diagram

The topology graph is displayed in the form of circular nodes, with node names as unique identifiers, used to display node information and node connection relationships.

```json
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

Field Description

| Parameter                  | Type          | Required | Description                                                                                                                                    |
| -------------------------- | ------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| services                   | list          | Required | List of node details                                                                                                                          |
| services[#]                | dict          |          | Node details                                                                                                                                  |
| services[#].name           | string        | Required | Node name, displayed at the bottom of the node                                                                                                |
| services[#].type           | string        | Required | Node type, used for displaying the center Icon of the node (supported types: 'web', 'custom', 'cache', 'db', 'app', 'front', 'aws_lambda'), defaults to 'custom' if not within the range. |
| services[#].data           | dict          |          | Node attributes                                                                                                                               |
| services[#].data.\_\_size   | number        |          | Value of the circle size field, this value has no range and adapts according to the set size.                                                 |
| services[#].data.\_\_fill   | number        | Required | Value of the fill color field, this value's range is set by the maximum and minimum values of the gradient color system.                      |
| services[#].data.fieldA     | string/number | Required | Content displayed on hover over the node, all fields other than ‘\_\_size’ and ‘\_\_fill’ are treated as custom fields.                     |
| maps                       | list          | Required | List of node connection relationships                                                                                                         |
| maps[#]                    | dict          |          | Service connection relationship (direction: source->target)                                                                                   |
| maps[#].source             | string        | Required | Source node                                                                                                                                   |
| maps[#].target             | string        | Required | Target node                                                                                                                                   |

## ResourceMap Resource Relationship Diagram

The topology graph is displayed in the form of card nodes, the connection relationship must have and can only have one central node, `serviceResource` is the list of detailed information for card nodes (`service:resource` should remain unique as it serves as the unique identifier for card nodes), `maps` is the connection relationship between the central node and other nodes, nodes pointed by the central node are located on the right side of the central node, and nodes pointing to the central node are located on the left side of the central node.

```json
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

Field Description

| Parameter                                         | Type   | Required | Description                                                                                                                            |
| ------------------------------------------------- | ------ | -------- | ------------------------------------------------------------------------------------------------------------------------------- |
| serviceResource                                  | list   | Required | List of detailed information for card nodes                                                                                          |
| serviceResource[#]                               | dict   |          | Card details                                                                                                                         |
| serviceResource[#].service                       | string | Required | Text content displayed at the bottom of the card                                                                                      |
| serviceResource[#].resource                      | string | Required | Text content displayed at the top of the card                                                                                        |
| serviceResource[#].source_type                   | string | Required | Resource type, used for displaying the node Icon (supported types: 'web', 'custom', 'cache', 'db', 'app', 'front', 'message'), defaults to 'custom' if not within the range. |
| serviceResource[#].data                          | dict   |          | Parameters of resource data under the service                                                                                         |
| serviceResource[#].data.avg_per_second           | number |          | Value displayed on the left side of the middle section                                                                               |
| serviceResource[#].data.avg_per_second_title     | number |          | Content displayed on hover over the left side of the middle section                                                                   |
| serviceResource[#].data.error_rate               | number |          | Content displayed on the right side of the middle section                                                                             |
| serviceResource[#].data.error_rate_title         | number |          | Content displayed on hover over the right side of the middle section                                                                  |
| serviceResource[#].data.p99                      | number |          | Content displayed in the middle section                                                                                              |
| serviceResource[#].data.p99_title                | number |          | Content displayed on hover over the right side of the middle section                                                                  |
| maps                                             | list   | Required | List of connection relationships for card nodes                                                                                      |
| maps[#]                                          | dict   |          | Connection relationship for card nodes (direction source_resource->target_resource)                                                   |
| maps[#].source                                   | string | Required | Same as serviceResource[#].service                                                                                                   |
| maps[#].source_resource                          | string | Required | Same as serviceResource[#].resource                                                                                                  |
| maps[#].target                                   | string | Required | Same as serviceResource[#].service                                                                                                   |
| maps[#].target_resource                          | string | Required | Same as serviceResource[#].resource                                                                                                  |

# External Function Response Structure Example

```python
@DFF.API('function_name', category='guance.dataQueryFunc')
def whytest_topology_test():
    now = int(time.time()) * 1000
    # The data here is the complete structure of the above mentioned 「ServiceMap Service Relationship Diagram, ResourceMap Resource Relationship Diagram」
    data = {}
    return {
        "content": [
            {
                "series": [
                    {
                        "columns": ["time", "data"],
                        "values": [
                            now, json.dumps(data)
                        ],
                        "total_hits": 1
                    }
                ]
            }
        ]
    }
```