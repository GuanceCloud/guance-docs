# External Data Sources
---

Using DataFlux Func, you can integrate various data sources such as MySQL into Guance to achieve seamless data querying and visualization.

## Features

- **Native Queries**: Directly use the native query statements of the data source in charts without any additional conversion;
- **Data Protection**: Considering data security and privacy, all data source information is stored only in your local Func, not on the platform, ensuring information security and preventing data leaks;
- **Custom Management**: Easily add and manage various external data sources based on actual needs;
- **Real-time Data**: Directly connect to external data sources to obtain real-time data, enabling immediate responses and decision-making.

## Prerequisites

You need to download the corresponding installation package and [quick start](https://func.guance.com/doc/quick-start/) deploying the Func platform.

After deployment, wait for initialization to complete, then log in and enter the platform.

## Associating Func with Guance

Connectors can help developers connect to the Guance system.

Navigate to Development > Connectors > Add Connector page:

![Get Func](../img/get_func.png)

1. Select the connector type;
2. Customize the [ID](https://func.guance.com/doc/development-guide-basic-conception/#2), such as `guance_test`;
3. Add a title. This title will be displayed synchronously in the Guance workspace;
4. Enter a description for the connector as needed;
5. Choose the Guance [node](https://func.guance.com/doc/ui-guide-development-module-guance-node%);
6. Add [API Key ID and API Key](#how_to_get_api_key);
7. Test connectivity as needed;
8. Click save.

### How to Get an API Key {#how_to_get_api_key}

1. Go to the Guance workspace > Management > API Key Management;
2. Click **New Key** on the right side of the page.
3. Enter a name;
4. Click confirm. The system will automatically create an API Key for you, which you can view within the API Key management section.

![Get Func 1](../img/get_func_1.png)

> For more details, refer to [API Key Management](../management/api-key/index.md).

## Using Func to Query External Data Sources

### Using Connectors

After adding the connector, you can use its ID to get the corresponding operation object in scripts.

For example, if the connector ID is `guance_test`, the code to get this connector's operation object would be:

```python
mysql = DFF.CONN('mysql')
```

![Get Func 2](../img/get_func_2.png)

### Writing Custom Scripts

Assume a MySQL connector (with ID `mysql`) has been correctly created, and there is a table named `my_table` in this MySQL database containing the following data:

| `id`     | `userId`       | `username`|  `reqMethod` | `reqRoute`  |  `reqCost`   | `createTime` | 
| ------ | ----- |----- |----- |----- |----- |----- |
| 1 | u-001 | admin | POST | /api/v1/scripts/:id/do/modify | 23 | 1730840906 |
| 2 | u-002| admin  | POST | /api/v1/scripts/:id/do/publish | 99 | 1730840906 |
| 3 | u-003 | zhang3 | POST | /api/v1/scripts/:id/do/publish | 3941 | 1730863223 |
| 4 | u-004 | zhang3 | POST | /api/v1/scripts/:id/do/publish | 159 | 1730863244 |
| 5 | u-005 | li4 | POST | /api/v1/scripts/:id/do/publish | 44 | 1730863335 |
| ... |       | | | | | |

Suppose you want to query this table using a **data query function**, with the field extraction rules as follows:

| Original Field | Extracted As    |
| -------------- | --------------- |
| `createTime`   | Time `time`     |
| `reqCost`      | Column `req_cost` |
| `reqMethod`    | Column `req_method` |
| `reqRoute`     | Column `req_route`  |
| `userId`       | Tag `user_id`    |
| `username`     | Tag `username`   |

The complete reference code is as follows:

- Example of a Data Query Function

```python
import json

@DFF.API('Query data from my_table', category='guance.dataQueryFunc')
def query_from_my_table(time_range):
    # Get the connector operation object
    mysql = DFF.CONN('mysql')

    # MySQL query statement
    sql = '''
      SELECT
        createTime, userId, username, reqMethod, reqRoute, reqCost
      FROM
        my_table
      WHERE
        createTime     > ?
        AND createTime < ?
      LIMIT 5
    '''

    # Since time_range is in milliseconds,
    # but createTime in MySQL is in seconds, conversion is required
    sql_params = [
      int(time_range[0] / 1000),
      int(time_range[1] / 1000),
    ]

    # Execute the query
    db_res = mysql.query(sql, sql_params)

    # Convert to DQL-like return results

    # Depending on different tags, multiple data series may need to be generated
    # Use data series tags as keys to create a mapping table
    series_map = {}

    # Iterate through original data, convert structure, and store in the mapping table
    for d in db_res:
        # Collect tags
        tags = {
            'user_id' : d.get('userId'),
            'username': d.get('username'),
        }

        # Serialize tags (tag keys need to be sorted to ensure consistent output)
        tags_dump = json.dumps(tags, sort_keys=True, ensure_ascii=True)

        # If this tag's data series hasn't been established yet, create one
        if tags_dump not in series_map:
            # Basic structure of data series
            series_map[tags_dump] = {
                'columns': [ 'time', 'req_cost', 'req_method', 'req_route' ], # Columns (first column fixed as time)
                'tags'   : tags,                                              # Tags
                'values' : [],                                                # Value list
            }

        # Extract time, columns, and append value
        series = series_map[tags_dump]
        value = [
            d.get('createTime') * 1000, # Time `time` (output unit needs to be milliseconds, conversion required here)
            d.get('reqCost'),           # Column `req_cost`
            d.get('reqMethod'),         # Column `req_method`
            d.get('reqRoute'),          # Column `req_route`
        ]
        series['values'].append(value)

    # Add outer structure for DQL-like result
    dql_like_res = {
        # Data series
        'series': [ list(series_map.values()) ] # Note: wrap in an extra array
    }
    return dql_like_res
```

If you only want to understand the data transformation process without caring about the query process (or if you don't have an actual database to query), you can refer to the following code:

- Example of a Data Query Function (without MySQL query part)

```python
import json

@DFF.API('Query data from somewhere', category='guance.dataQueryFunc')
def query_from_somewhere(time_range):
    # Assume data has been obtained via some method
    db_res = [
        {'createTime': 1730840906, 'reqCost': 23,   'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/modify',  'username': 'admin',  'userId': 'u-001'},
        {'createTime': 1730840906, 'reqCost': 99,   'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'admin',  'userId': 'u-001'},
        {'createTime': 1730863223, 'reqCost': 3941, 'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'zhang3', 'userId': 'u-002'},
        {'createTime': 1730863244, 'reqCost': 159,  'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'zhang3', 'userId': 'u-002'},
        {'createTime': 1730863335, 'reqCost': 44,   'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'li4',    'userId': 'u-003'}
    ]

    # Convert to DQL-like return results

    # Depending on different tags, multiple data series may need to be generated
    # Use data series tags as keys to create a mapping table
    series_map = {}

    # Iterate through original data, convert structure, and store in the mapping table
    for d in db_res:
        # Collect tags
        tags = {
            'user_id' : d.get('userId'),
            'username': d.get('username'),
        }

        # Serialize tags (tag keys need to be sorted to ensure consistent output)
        tags_dump = json.dumps(tags, sort_keys=True, ensure_ascii=True)

        # If this tag's data series hasn't been established yet, create one
        if tags_dump not in series_map:
            # Basic structure of data series
            series_map[tags_dump] = {
                'columns': [ 'time', 'req_cost', 'req_method', 'req_route' ], # Columns (first column fixed as time)
                'tags'   : tags,                                              # Tags
                'values' : [],                                                # Value list
            }

        # Extract time, columns, and append value
        series = series_map[tags_dump]
        value = [
            d.get('createTime') * 1000, # Time `time` (output unit needs to be milliseconds, conversion required here)
            d.get('reqCost'),           # Column `req_cost`
            d.get('reqMethod'),         # Column `req_method`
            d.get('reqRoute'),          # Column `req_route`
        ]
        series['values'].append(value)

    # Add outer structure for DQL-like result
    dql_like_res = {
        # Data series
        'series': [ list(series_map.values()) ] # Note: wrap in an extra array
    }
    return dql_like_res
```

- Example of Return Result

```json
{
  "series": [
    [
      {
        "columns": ["time", "req_cost", "req_method", "req_route"],
        "tags": {"user_id": "u-001", "username": "admin"},
        "values": [
          [1730840906000, 23, "POST", "/api/v1/scripts/:id/do/modify" ],
          [1730840906000, 99, "POST", "/api/v1/scripts/:id/do/publish"]
        ]
      },
      {
        "columns": ["time", "req_cost", "req_method", "req_route"],
        "tags": {"user_id": "u-002", "username": "zhang3"},
        "values": [
          [1730863223000, 3941, "POST", "/api/v1/scripts/:id/do/publish"],
          [1730863244000,  159, "POST", "/api/v1/scripts/:id/do/publish"]
        ]
      },
      {
        "columns": ["time", "req_cost", "req_method", "req_route"],
        "tags": {"user_id": "u-003", "username": "li4"},
        "values": [
          [1730863335000, 44, "POST", "/api/v1/scripts/:id/do/publish"]
        ]
      }
    ]
  ]
}
```

## Adding Data Sources in Guance

1. Select DataFlux Func from the dropdown;
2. Choose the supported data source type;
3. Define connection properties, including ID, data source title, associated host, port, database, user, and password.
4. Test the connection as needed;
5. Click save to successfully add the data source.

![External](../img/external.png)

### List Operations

All connected data sources can be viewed under **Integration > External Data Sources**.

![External 1](img/external-1.png)

In the list, you can perform the following operations:

1. View the type, ID, status, creation information, and update information of the data source;
2. Edit a data source, modifying configurations other than DataFlux Func, data source type, and ID;
3. Delete a data source.

### Query Examples

When querying for charts, you can choose to query from external data sources.

![External 2](img/external-2.png)