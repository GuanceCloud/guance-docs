# Local Function

In enterprise systems, multiple parties' data are intertwined. To effectively manage this data, we need to establish clear business responsibility scopes for the reported data. Given that business data is constantly changing, querying and obtaining relevant associated data results based on the latest business management scope becomes particularly critical.

The <<< custom_key.brand_name >>> provided local Function feature allows third-party users to fully utilize the local cache and local file management service interfaces of Function, combined with the relevant business relationships, to perform data analysis queries within the workspace, ultimately easily obtaining performance analysis data such as API response times related to business relationships.

## Configuration

### Editing Local Functions

1. Input business correspondence through the local cache/local files of Function;

2. Create Category=Function Script, define the scope of business parameters, and write data query statements (DQL + Business Relationship Table);

3. Publish the function script.

#### Editing Example

```
import time

@DFF.API('Data Query Function', category='guance.dataQueryFunc')
def query_fake_data(time_range=None, tier=None):
    # <<< custom_key.brand_name >>> Connector
    guance = DFF.CONN('guance')

    # If no time range is specified, it can be forcibly limited to the last 1 minute of data
    if not time_range:
        now = int(time.time())
        time_range = [
            (now - 60) * 1000,
            (now -  0) * 1000,
        ]

    # DQL statement
    dql = 'M::`fake_data_for_test`:(avg(`field_int`)) BY `tag`'

    # Add conditions based on additional parameter tier
    conditions = None
    if tier == 't1':
        conditions = 'tag in ["value-1", "value-3"]'
    elif tier == 't2':
        conditions = 'tag = "value-2"'

    # Query and return data in raw form
    status_code, result = guance.dataway.query(dql=dql, conditions=conditions, time_range=time_range, raw=True)
    return result
```

### Using the Function to Obtain Query Results

1. Go to Console > Use Cases > Chart Query, select **Add Data Source**;

2. Select the edited Function and fill in the parameter content;

3. Display query results:

![](img/func-query-out.png)