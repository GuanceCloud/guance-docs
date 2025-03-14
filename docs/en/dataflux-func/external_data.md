# External Data Sources
---

Using DataFlux Func, you can integrate various data sources such as MySQL into <<< custom_key.brand_name >>>, enabling seamless data querying and visualization.

## Features

- Native Queries: Use native query statements directly in charts without any additional conversion;
- Data Protection: For data security and privacy considerations, all data source information is stored only in your local Func, not on the platform, ensuring information security and preventing data leaks;
- Custom Management: Easily add and manage various external data sources based on actual needs;
- Real-Time Data: Directly connect to external data sources to get real-time data for immediate response and decision-making.

## Prerequisites

You need to select and download the corresponding installation package, [Quick Start](https://<<< custom_key.func_domain >>>/doc/quick-start/) to deploy the Func platform.

After deployment, wait for initialization to complete, then log in to the platform.

## Connecting Func with <<< custom_key.brand_name >>> {#start}

Connectors can help developers connect to the <<< custom_key.brand_name >>> system.

Navigate to Development > Connectors > Add Connector page:

<img src="../img/get_func.png" width="70%" >

1. Select the connector type;
2. Customize the [ID](https://<<< custom_key.func_domain >>>/doc/development-guide-basic-conception/#2) of this connector, e.g., `guance_test`;
3. Add a title. This title will be displayed synchronously in the <<< custom_key.brand_name >>> workspace;
4. Enter a description for the connector as needed;
5. Select the <<< custom_key.brand_name >>> [node](https://<<< custom_key.func_domain >>>/doc/ui-guide-development-module-guance-node/);
6. Add [API Key ID and API Key](#api-key-how_to_get_api_key);
7. Test connectivity as needed;
8. Click Save.

### How to Get an API Key {#how_to_get_api_key}

1. Navigate to <<< custom_key.brand_name >>> Workspace > Manage > API Key Management;
2. Click **Create Key** on the right side of the page.
3. Enter a name;
4. Click Confirm. The system will automatically create an API Key for you, which you can view in the API Key section.

<img src="../img/get_func_1.png" width="70%" >

> For more details, refer to [API Key Management](../management/api-key/index.md).

## Querying External Data Sources Using Func

**Note**: The term "external data source" here has a broad definition, including common external data storage systems (such as MySQL, Redis databases) and third-party systems (e.g., <<< custom_key.brand_name >>> console).


### Using Connectors

After adding a connector normally, you can use the connector ID to obtain the corresponding connector operation object in scripts.

For example, if the connector ID is `guance_test`, the code to obtain the connector operation object is:

```
mysql = DFF.CONN('mysql')
```

<img src="../img/get_func_2.png" width="70%" >

### Writing Custom Scripts

In addition to using connectors, you can also write custom functions to query data.

Assuming a MySQL connector (with ID `mysql`) has been correctly created and there is a table named `my_table` in this MySQL database with the following data:

| `id` | `userId` | `username` | `reqMethod` | `reqRoute` | `reqCost` | `createTime` |
| --- | -------- | ---------- | ----------- | ---------- | --------- | ------------ |
| 1   | u-001    | admin      | POST        | /api/v1/scripts/:id/do/modify | 23 | 1730840906 |
| 2   | u-002    | admin      | POST        | /api/v1/scripts/:id/do/publish | 99 | 1730840906 |
| 3   | u-003    | zhang3     | POST        | /api/v1/scripts/:id/do/publish | 3941 | 1730863223 |
| 4   | u-004    | zhang3     | POST        | /api/v1/scripts/:id/do/publish | 159 | 1730863244 |
| 5   | u-005    | li4        | POST        | /api/v1/scripts/:id/do/publish | 44 | 1730863335 |
| ... |          |            |             |                                   |     |           |

Assuming you need to query this table's data using a **data query function**, and the field extraction rules are as follows:

| Original Field | Extracted As    |
| -------------- | --------------- |
| `createTime`   | Time `time`     |
| `reqCost`      | Column `req_cost` |
| `reqMethod`    | Column `req_method` |
| `reqRoute`     | Column `req_route`  |
| `userId`       | Tag `user_id`    |
| `username`     | Tag `username`   |

The complete reference code is as follows:

- Data Query Function Example

```
import json

@DFF.API('Query data from my_table', category='guance.dataQueryFunc')
def query_from_my_table(time_range):
    # Get connector operation object
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

    # Since the time_range passed in is in milliseconds,
    # but the createTime field in MySQL is in seconds, it needs to be converted
    sql_params = [
      int(time_range[0] / 1000),
      int(time_range[1] / 1000),
    ]

    # Execute query
    db_res = mysql.query(sql, sql_params)

    # Convert to DQL-like return result

    # Depending on different tags, multiple data series may need to be generated
    # Use data series tags as keys to create a mapping table
    series_map = {}

    # Traverse original data, convert structure, and store in the mapping table
    for d in db_res:
        # Collect tags
        tags = {
            'user_id' : d.get('userId'),
            'username': d.get('username'),
        }

        # Serialize tags (tag keys need to be sorted to ensure consistent output)
        tags_dump = json.dumps(tags, sort_keys=True, ensure_ascii=True)

        # If this tag's data series hasn't been established, establish one
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
            d.get('createTime') * 1000, # Time time (output unit needs to be milliseconds, conversion required)
            d.get('reqCost'),           # Column req_cost
            d.get('reqMethod'),         # Column req_method
            d.get('reqRoute'),          # Column req_route
        ]
        series['values'].append(value)

    # Add outer structure of DQL-like result
    dql_like_res = {
        # Data series
        'series': [ list(series_map.values()) ] # Note: wrap in an additional array
    }
    return dql_like_res
```

If you only want to understand data transformation processing and don't care about the query process (or temporarily have no actual database to query), you can refer to the following code:

- Data Query Function Example (without MySQL query part)

```
import json

@DFF.API('Query data from somewhere', category='guance.dataQueryFunc')
def query_from_somewhere(time_range):
    # Assume that raw data has been obtained through some method
    db_res = [
        {'createTime': 1730840906, 'reqCost': 23,   'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/modify',  'username': 'admin',  'userId': 'u-001'},
        {'createTime': 1730840906, 'reqCost': 99,   'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'admin',  'userId': 'u-001'},
        {'createTime': 1730863223, 'reqCost': 3941, 'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'zhang3', 'userId': 'u-002'},
        {'createTime': 1730863244, 'reqCost': 159,  'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'zhang3', 'userId': 'u-002'},
        {'createTime': 1730863335, 'reqCost': 44,   'reqMethod': 'POST', 'reqRoute': '/api/v1/scripts/:id/do/publish', 'username': 'li4',    'userId': 'u-003'}
    ]

    # Convert to DQL-like return result

    # Depending on different tags, multiple data series may need to be generated
    # Use data series tags as keys to create a mapping table
    series_map = {}

    # Traverse original data, convert structure, and store in the mapping table
    for d in db_res:
        # Collect tags
        tags = {
            'user_id' : d.get('userId'),
            'username': d.get('username'),
        }

        # Serialize tags (tag keys need to be sorted to ensure consistent output)
        tags_dump = json.dumps(tags, sort_keys=True, ensure_ascii=True)

        # If this tag's data series hasn't been established, establish one
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
            d.get('createTime') * 1000, # Time time (output unit needs to be milliseconds, conversion required)
            d.get('reqCost'),           # Column req_cost
            d.get('reqMethod'),         # Column req_method
            d.get('reqRoute'),          # Column req_route
        ]
        series['values'].append(value)

    # Add outer structure of DQL-like result
    dql_like_res = {
        # Data series
        'series': [ list(series_map.values()) ] # Note: wrap in an additional array
    }
    return dql_like_res
```

- Example Return Result

```
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

#### Chart Data Return

A typical scenario for querying external data sources in <<< custom_key.brand_name >>> is [charts](../scene/visual-chart/index.md).

<img src="../img/external-2.png" width="70%" >

| Different Chart Data Returns |               |                  |
| :---------------------: | :----------------: | :--------------: |
| [Line Chart](./chart_line.md) | [Pie Chart](./chart_pie.md) | [Table Chart](./chart_table.md) |

## Adding Data Sources in <<< custom_key.brand_name >>>

Directly add or view all connected DataFlux Func lists under **Extensions**, and further manage all connected external data sources.

1. Select DataFlux Func from the dropdown;
2. Choose supported data source types;
3. Define connection attributes, including ID, data source title, associated host, port, database, user, password;
4. Test the connection as needed;
5. Click Save to add successfully.

<img src="../img/external.png" width="60%" >

### Managing the List

All connected data sources can be seen in **Integrations > External Data Sources > Connected Data Sources**.

![](img/external-1.png)

In the list, you can perform the following operations:

1. View data source type, ID, status, creation information, and update information;
2. Edit a data source, modifying configurations other than DataFlux Func, data source type, and ID;
3. Delete a data source.