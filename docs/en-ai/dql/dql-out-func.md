# Local Function

In enterprise systems, data from multiple parties are intertwined. To effectively manage this data, we need to establish clear business responsibility boundaries for the reported data. Given that business data is constantly changing, querying and obtaining associated data results based on the latest business management scope becomes particularly crucial.

The local Function feature provided by Guance allows third-party users to fully utilize the local cache and local file management service interfaces of the Function, combined with relevant business relationships, to perform data analysis queries within the workspace, ultimately easily obtaining performance analysis data such as API response times related to business relationships.

## Configuration Steps

### Editing the Local Function

1. Input business correspondence via the local cache/local files of the Function;

2. Create a new Category=Function Script, define the scope of business parameters, and write data query statements (DQL + Business Relationship Table);

3. Publish the function script.

#### Editing Example

```
import time

@DFF.API('Data Query Function', category='guance.dataQueryFunc')
def query_fake_data(time_range=None, tier=None):
    # Guance connector
    guance = DFF.CONN('guance')

    # If no time range is specified, limit to the most recent 1 minute of data
    if not time_range:
        now = int(time.time())
        time_range = [
            (now - 60) * 1000,
            (now -  0) * 1000,
        ]

    # DQL statement
    dql = 'M::`fake_data_for_test`:(avg(`field_int`)) BY `tag`'

    # Add conditions based on the additional parameter tier
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

1. Go to Console > Scenarios > Chart Query, select **Add Data Source**;

2. Select the edited Function and fill in the parameter details;

3. Display the query results:

![](img/func-query-out.png)