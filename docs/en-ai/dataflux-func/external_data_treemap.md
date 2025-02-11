# Topology Graph Data Structure Description

Field Description

| Parameter                  | Type   | Required | Description                                                                                          |
| -------------------------- | ------ | -------- | ---------------------------------------------------------------------------------------------------- |
| column_names               | list   |          | Set of column names corresponding to numerical values. For external function data sources, this value will be automatically populated based on `series data`. |
| column_names[#]            | str    |          |                                                                                                      |
| series                     | list   | Required | Data groups, the length represents the number of data sets (in topology graphs, there is only one set of data). |
| series[#]                  | dict   |          | A collection of data.                                                                                |
| series[#].tags             | dict   |          | Associated properties of the data (used for displaying related attributes, table displays it as column data, alias key value mapping). |
| series[#].columns          | list   | Required | List of data source field keys, fixed to `['time', 'data']`.                                          |
| series[#].values           | list   | Required | Two-dimensional array, each item represents a piece of data (in topology graphs, there is only one piece of data). |
| series[#].values[#]        | list   |          | Composed of `[timestamp, data value]`, the length should match `series[#].columns`.                   |
| series[#].values[#][0]     | str    |          | Corresponds to the value in the 'time' column, can be null.                                           |
| series[#].values[#][1]     | str    |          | Corresponds to the value in the 'data' column, its value is a serialized object supporting types `ServiceMap`, `ResourceMap`. |

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

| Parameter                      | Type          | Required | Description                                                                                                                                    |
| ------------------------------ | ------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| services                       | list          | Required | List of node details.                                                                                                                         |
| services[#]                    | dict          |          | Node details.                                                                                                                                 |
| services[#].name               | string        | Required | Node name, displayed at the bottom of the node.                                                                                               |
| services[#].type               | string        | Required | Node type, used for displaying the icon in the center of the node (supported types: 'web', 'custom', 'cache', 'db', 'app', 'front', 'aws_lambda'), defaults to 'custom' if not in range. |
| services[#].data               | dict          |          | Node attributes.                                                                                                                              |
| services[#].data.\_\_size      | number        |          | Value for the circle size field, adapts according to the set size.                                                                            |
| services[#].data.\_\_fill      | number        | Required | Value for the fill color field, the range is set by the gradient color system's maximum and minimum values.                                   |
| services[#].data.fieldA        | string/number | Required | Content displayed when hovering over the node, all fields except '\_\_size', '\_\_fill' are treated as custom fields.                        |
| maps                           | list          | Required | List of node connection relationships.                                                                                                       |
| maps[#]                        | dict          |          | Service connection relationship (direction: source->target).                                                                                 |
| maps[#].source                 | string        | Required | Starting node.                                                                                                                               |
| maps[#].target                 | string        | Required | Target node.                                                                                                                                 |

## ResourceMap Resource Relationship Diagram

The topology graph is displayed in the form of card nodes, with connection relationships ensuring that there is exactly one central node. `serviceResource` is the list of card node details (`service:resource` must be unique, serving as the unique identifier for the card node), `maps` is the connection relationship between the central node and other nodes, with nodes pointed to by the central node located to the right of the central node, and nodes pointing to the central node located to the left.

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
| serviceResource                                   | list   | Required | List of card node details.                                                                                                            |
| serviceResource[#]                                | dict   |          | Card details.                                                                                                                        |
| serviceResource[#].service                        | string | Required | Text displayed at the bottom of the card.                                                                                            |
| serviceResource[#].resource                       | string | Required | Text displayed at the top of the card.                                                                                               |
| serviceResource[#].source_type                    | string | Required | Resource type, used for displaying the node icon (supported types: 'web', 'custom', 'cache', 'db', 'app', 'front', 'message'), defaults to 'custom' if not in range. |
| serviceResource[#].data                           | dict   |          | Parameters for resources under the service.                                                                                           |
| serviceResource[#].data.avg_per_second            | number |          | Value displayed on the left side of the middle section.                                                                               |
| serviceResource[#].data.avg_per_second_title      | number |          | Hover content displayed on the left side of the middle section.                                                                       |
| serviceResource[#].data.error_rate                | number |          | Content displayed on the right side of the middle section.                                                                            |
| serviceResource[#].data.error_rate_title          | number |          | Hover content displayed on the right side of the middle section.                                                                      |
| serviceResource[#].data.p99                       | number |          | Content displayed in the middle section.                                                                                              |
| serviceResource[#].data.p99_title                 | number |          | Hover content displayed on the right side of the middle section.                                                                      |
| maps                                              | list   | Required | List of card node connection relationships.                                                                                           |
| maps[#]                                           | dict   |          | Card node connection relationship (direction source_resource->target_resource).                                                       |
| maps[#].source                                    | string | Required | Same as serviceResource[#].service name.                                                                                             |
| maps[#].source_resource                           | string | Required | Same as serviceResource[#].resource.                                                                                                 |
| maps[#].target                                    | string | Required | Same as serviceResource[#].service.                                                                                                  |
| maps[#].target_resource                           | string | Required | Same as serviceResource[#].resource.                                                                                                 |

# External Function Response Structure Example

```python

@DFF.API('function_name', category='guance.dataQueryFunc')
def whytest_topology_test():
    now = int(time.time()) * 1000
    # The data here is the complete structure of `ServiceMap Service Relationship Diagram, ResourceMap Resource Relationship Diagram` mentioned above.
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